$(document).ready(function () {
    function buscar () {
        var value = $("#busca").val().toUpperCase();

        if (value === "") {
            $(".painel").show();
            return;
        }
        
        $(".painel").hide();
        var nenhum = true;
        
        var paineis = $(".painel").each(function () {
            if ($(this).find(".label").text().toUpperCase().indexOf(value) < 0)                
                return;
            nenhum = false;
            $(this).show();
        });
        
        $(".nenhum")[0].style.display = nenhum ? "" : "none";
    }

    var timerBusca = null;
    busca.oninput = function () {
        clearTimeout(timerBusca);
        timerBusca = setTimeout(buscar, 200);
    };
                  
});