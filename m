Content-Type: multipart/mixed; boundary="===============2019014738851354007=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add
 ADD_ADDR timeout test case"
Date: Tue, 13 Oct 2020 11:49:00 +0800
Message-ID: <CA+WQbwuHx6Uyzomi+9x5GZ=WgJQy8fYCs0SzU3cmjk+5Mfc-iQ@mail.gmail.com>
In-Reply-To: 20201012154129.1824527-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6297

--===============2019014738851354007==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2020=E5=B9=B410=
=E6=9C=8812=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:41=E5=86=99=E9=
=81=93=EF=BC=9A
>
> Skip mptcp_join selftest if IPTables is not available.
>
> Ideally, I agree that we should switch to ntf but I don't know the
> advanced features of it to block ADD_ADDR packets by matching TCP option
> 30 and MPTCP subtype 3. If it is possible to do that, please guide me to
> match MPTCP option (it looks like we are limited to a fixed list and
> MPTCP is not there) and match some data after and offset (tcp doff?).
>
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Acked-by: Geliang Tang <geliangtang(a)gmail.com>

> ---
>
> Notes:
>     to be squashed in "selftests: mptcp: add ADD_ADDR timeout test case"
>
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index 3767acb9bb12..0b060d9a79ae 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -122,6 +122,12 @@ if [ $? -ne 0 ];then
>         exit $ksft_skip
>  fi
>
> +iptables -V > /dev/null 2>&1
> +if [ $? -ne 0 ];then
> +       echo "SKIP: Could not run all tests without iptables tool"
> +       exit $ksft_skip
> +fi
> +
>
>  check_transfer()
>  {
> --
> 2.27.0
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
--===============2019014738851354007==--
