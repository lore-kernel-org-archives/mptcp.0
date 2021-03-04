Content-Type: multipart/mixed; boundary="===============4594094792388995272=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-net] selftests: mptcp: Restore packet
 capture option in join tests
Date: Thu, 04 Mar 2021 18:58:06 +0800
Message-ID: <CA+WQbwvf_ZiKdbhVRWoGry5XOxp-7y20x5Twa04mtDFZXd2cxQ@mail.gmail.com>
In-Reply-To: 20210303224300.95599-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8024

--===============4594094792388995272==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

I tested this patch, it works well. Thanks.

Acked-and-tested-by: Geliang Tang <geliangtang(a)gmail.com>

-Geliang

Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2021=E5=B9=B4=
3=E6=9C=884=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=886:43=E5=86=99=E9=
=81=93=EF=BC=9A
>
> The join self tests previously used the '-c' command line option to
> enable creation of pcap files for the tests that run, but the change to
> allow running a subset of the join tests made overlapping use of that
> option.
>
> Restore the capture functionality with '-c' and move the syncookie test
> option to '-k'.
>
> Fixes: 1002b89f23ea ("selftests: mptcp: add command line arguments for mp=
tcp_join.sh")
> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 26 ++++++++++++-------
>  1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index 96379ede5925..4d7dab0bce7a 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -12,6 +12,7 @@ timeout_poll=3D30
>  timeout_test=3D$((timeout_poll * 2 + 1))
>  mptcp_connect=3D""
>  capture=3D0
> +do_all_tests=3D1
>
>  TEST_COUNT=3D0
>
> @@ -123,12 +124,6 @@ reset_with_add_addr_timeout()
>                 -j DROP
>  }
>
> -for arg in "$@"; do
> -       if [ "$arg" =3D "-c" ]; then
> -               capture=3D1
> -       fi
> -done
> -
>  ip -Version > /dev/null 2>&1
>  if [ $? -ne 0 ];then
>         echo "SKIP: Could not run test without ip tool"
> @@ -1368,7 +1363,8 @@ usage()
>         echo "  -4 v4mapped_tests"
>         echo "  -b backup_tests"
>         echo "  -p add_addr_ports_tests"
> -       echo "  -c syncookies_tests"
> +       echo "  -k syncookies_tests"
> +       echo "  -c capture pcap files"
>         echo "  -h help"
>  }
>
> @@ -1382,12 +1378,20 @@ make_file "$cin" "client" 1
>  make_file "$sin" "server" 1
>  trap cleanup EXIT
>
> -if [ -z $1 ]; then
> +for arg in "$@"; do
> +       if [ "$arg" =3D "-c" ]; then
> +               capture=3D1
> +       else
> +               do_all_tests=3D0
> +       fi
> +done
> +
> +if [ $do_all_tests -eq 1 ]; then
>         all_tests
>         exit $ret
>  fi
>
> -while getopts 'fsltra64bpch' opt; do
> +while getopts 'fsltra64bpkch' opt; do
>         case $opt in
>                 f)
>                         subflows_tests
> @@ -1419,9 +1423,11 @@ while getopts 'fsltra64bpch' opt; do
>                 p)
>                         add_addr_ports_tests
>                         ;;
> -               c)
> +               k)
>                         syncookies_tests
>                         ;;
> +               c)
> +                       ;;
>                 h | *)
>                         usage
>                         ;;
> --
> 2.30.1
>
--===============4594094792388995272==--
