<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>{!! $title ?? '' !!} - 798Store Admin Dashboard</title>
    <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
    <link rel="icon" href="assets/img/kaiadmin/favicon.ico" type="image/x-icon" />

    <!-- Fonts and icons -->
    <script src="{{asset('servers/js/plugin/webfont/webfont.min.js')}}"></script>
    <script>
        WebFont.load({
            google: {
                families: ["Public Sans:300,400,500,600,700"]
            },
            custom: {
                families: [
                    "Font Awesome 5 Solid",
                    "Font Awesome 5 Regular",
                    "Font Awesome 5 Brands",
                    "simple-line-icons",
                ],
                urls: ["{{asset('servers/css/fonts.min.css')}}"],
            },
            active: function() {
                sessionStorage.fonts = true;
            },
        });
    </script>

    <!-- CSS Files -->
    <link rel="stylesheet" href="{{asset('servers/css/bootstrap.min.css')}}" />
    <link rel="stylesheet" href="{{asset('servers/css/plugins.min.css')}}" />
    <link rel="stylesheet" href="{{asset('servers/css/kaiadmin.min.css')}}" />

    <!-- CSS Just for demo purpose -->
    <link rel="stylesheet" href="{{asset('servers/css/demo.css')}}" />

    <!-- tailwindcss -->

    @livewireStyles

</head>

<body>
    <div class="wrapper">

        <!-- Sidebar -->
        @include('layouts.servers.sidebar')
        <!-- End Sidebar -->

        <div class="main-panel">
            <div class="main-header">
                <div class="main-header-logo">

                    <!-- Logo Header -->
                    @include('layouts.servers.logo')
                    <!-- End Logo Header -->

                </div>

                <!-- Navbar Header -->
              @include('layouts.servers.navbar')
                <!-- End Navbar -->

            </div>
            <div class="container">

                <!-- Content -->
               {{ $slot }}
                <!-- End Content -->

            </div>

            <!-- Footer -->
             @include('layouts.servers.footer')
            <!-- End Footer -->

        </div>

        <!-- Custom template  -->
        @include('layouts.servers.setting')
        <!-- End Custom template -->

        <!--   Core JS Files   -->
        <script src="{{asset('servers/js/core/jquery-3.7.1.min.js')}}"></script>
        <script src="{{asset('servers/js/core/popper.min.js')}}"></script>
        <script src="{{asset('servers/js/core/bootstrap.min.js')}}"></script>

        <!-- jQuery Scrollbar -->
        <script src="{{asset('servers/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js')}}"></script>

        <!-- Chart JS -->
        <script src="{{asset('servers/js/plugin/chart.js')}}"></script>

        <!-- jQuery Sparkline -->
        <script src="{{asset('servers/js/plugin/jquery.sparkline/jquery.sparkline.min.js')}}"></script>

        <!-- Chart Circle -->
        <script src="{{asset('servers/js/plugin/chart-circle/circles.min.js')}}"></script>

        <!-- Datatables -->
        <script src="{{asset('servers/js/plugin/datatables/datatables.min.js')}}"></script>

        <!-- Bootstrap Notify -->
        <script src="{{asset('servers/js/plugin/bootstrap-notify/bootstrap-notify.min.js')}}"></script>

        <!-- jQuery Vector Maps -->
        <script src="{{asset('servers/js/plugin/jsvectormap/jsvectormap.min.js')}}"></script>
        <script src="{{asset('servers/js/plugin/jsvectormap/world.js')}}"></script>

        <!-- Sweet Alert -->
        <script src="{{asset('servers/js/plugin/sweetalert/sweetalert.min.js')}}"></script>

        <!-- Kaiadmin JS -->
        <script src="{{asset('servers/js/kaiadmin.min.js')}}"></script>

        <!-- Kaiadmin DEMO methods -->
        <script src="{{asset('servers/js/setting-demo.js')}}"></script>
        <script src="{{asset('servers/js/demo.js')}}"></script>
        <script>
            $("#lineChart").sparkline([102, 109, 120, 99, 110, 105, 115], {
                type: "line",
                height: "70",
                width: "100%",
                lineWidth: "2",
                lineColor: "#177dff",
                fillColor: "rgba(23, 125, 255, 0.14)",
            });

            $("#lineChart2").sparkline([99, 125, 122, 105, 110, 124, 115], {
                type: "line",
                height: "70",
                width: "100%",
                lineWidth: "2",
                lineColor: "#f3545d",
                fillColor: "rgba(243, 84, 93, .14)",
            });

            $("#lineChart3").sparkline([105, 103, 123, 100, 95, 105, 115], {
                type: "line",
                height: "70",
                width: "100%",
                lineWidth: "2",
                lineColor: "#ffa534",
                fillColor: "rgba(255, 165, 52, .14)",
            });
        </script>

        @livewireScripts
    </div>
</body>

</html>
