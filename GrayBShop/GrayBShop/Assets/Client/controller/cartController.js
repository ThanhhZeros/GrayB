var cart = {
    init: function () {
        cart.regEvents();
    },
    regEvents: function () {
        $('#btnContinute').off('click').on('click', function () {
            window.location.href = "/";
        });

        $('.btnAddCart').off('click').on('click', function () {
            let total = $("#cartcount").text();
            var count = parseInt(total);
            $.ajax({
                url: '/Cart/AddCart',
                data: { MaSP: $(this).data('id'), KichCo: $('#kichco').val() },
                dataType: 'json',
                type: 'POST',
                success: function (response) {
                    if (!response.status) {
                        swal({
                            title: "Thất bại!",
                            text: "Số lượng hàng trong kho không đủ",
                            type: "danger",
                            icon: "warning",
                            timer: 1500,
                            button: false
                        });
                    } else {
                        $(".close").click();
                        swal({
                            title: "Thành công!",
                            text: "Xem chi tiết tại giỏ hàng nhé",
                            type: "success",
                            icon: "success",
                            timer: 1500,
                            button: false
                        });
                        count = count + 1
                        $("#cartcount").html(count);
                    }
                },
                error: function (response) {
                    console.log(xhr.responseText);
                    alert("Error has occurred.");
                }
            })
        });

        $('.txtQuantity').off('click').on('click', function () {
            let price;
            let total = 0;
            let sum = 0;
            var listProduct = $('.txtQuantity');
            var cartList = [];
            $.each(listProduct, function (i, item) {
                cartList.push({
                    Amount: $(item).val(),
                    Size: $(item).data('kichco'),
                    ProductDetail: {
                        ImageID: $(item).data('id')

                    }
                });
            });
            $.ajax({
                url: '/Cart/Update',
                data: { cartModel: JSON.stringify(cartList) },
                dataType: 'json',
                type: 'POST',
                success: function (res) {
                    if (res.length == 0) {
                        window.location.href = "/gio-hang";
                    }
                    else {
                        $.each(res, function (index) {
                            total += res[index].Amount * res[index].Price;
                            price = res[index].Amount * res[index].Price;
                            sum += res[index].Amount;
                            $("#thanh-tien-" + res[index].ImageID + res[index].Size).html(price.toLocaleString());
                        })

                        $("#order-total").html(total.toLocaleString('it-IT', { style: 'currency', currency: 'VND' }));
                        $("#cartcount").html(sum);
                    }
                },
                error: function (res) {
                    console.log(xhr.resText);
                    alert("Error has occurred..");
                }
            })
        });

        $('.btnDelete').off('click').on('click', function () {
            let total = 0;
            let sum = 0;
            const id = $(this).data('id');
            const kichco = $(this).data('kichco');
            swal({
                title: "Bạn có chắc chắn",
                text: "Xóa sản phẩm này khỏi giỏ hàng",
                icon: "warning",
                buttons: true,
                dangerMode: true,
            })
                .then((willDelete) => {
                    if (willDelete) {
                        $.ajax({
                            type: 'POST',
                            data: { "MaAnh": id, "KichCo": kichco },
                            url: '/Cart/Delete',
                            dataType: 'json',
                            success: function (res) {
                                if (res.length == 0) {
                                    window.location.href = "/gio-hang";
                                }
                                else {
                                    $("#row-order-" + id + kichco).remove();

                                    $.each(res, function (index) {
                                        total += res[index].Amount * res[index].Price;
                                        sum += res[index].Amount;
                                    })
                                    $("#order-total").html(total.toLocaleString('it-IT', { style: 'currency', currency: 'VND' }));
                                    $("#cartcount").html(sum);
                                }
                            },
                            error: function (res) {
                                console.log(xhr.resText);
                                alert("Error has occurred..");
                            }
                        });
                    }
                })
        });

        $('#btnPayment').off('click').on('click', function () {
            window.location.href = "/thanh-toan";
        });
    }
}
cart.init();