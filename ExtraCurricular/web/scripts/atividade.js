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
            if ($(this).find(".titulo").text().toUpperCase().indexOf(value) < 0 &&
                $(this).find(".texto").text().toUpperCase().indexOf(value) < 0)
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
    
    var theater = null;

    $(".midia").click(function () {
        var midia = this.firstChild;
        
        if (midia.tagName == "AUDIO")
            return;
        
        if (midia.style.position !== "fixed") {
            if (theater !== null)
                return;
            
            theater = midia;
            
            midia.style.position = "fixed";
            midia.style.width = "800px";
            midia.style.height = "600px";
            midia.style.zIndex = "10000";
            midia.style.transform = "translate(-50%, -50%)";
            midia.style.objectFit = "contain";
            
            fundo.style.display = "";
        } else {
            theater.style.position = "";
            theater.style.width = "100%";
            theater.style.height = "100%";
            theater.style.transform = "";
            theater.style.zIndex = "0";
            theater.style.objectFit = "cover";
            
            fundo.style.display = "none";
            
            theater = null;
        }
    });
    
    $("#fundo").click(function () {
        theater.style.position = "";
        theater.style.width = "100%";
        theater.style.height = "100%";
        theater.style.transform = "";
        theater.style.zIndex = "0";
        theater.style.objectFit = "cover";
        
        fundo.style.display = "none";
        
        theater = null;
    });
});