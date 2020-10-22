Content-Type: multipart/mixed; boundary="===============5933906799605876292=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash to "selftests: mptcp: add ADD_ADDR timeout
 test case" v2
Date: Thu, 22 Oct 2020 10:42:56 +0800
Message-ID: <CA+WQbwuXyZSBm0M5Z6j46ZcM2WBcNaK_V969fsih__qJ8LZyhg@mail.gmail.com>
In-Reply-To: b3ed8ba86d19ab431e4e04b3dd94afbd973d8393.1603262779.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6400

--===============5933906799605876292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

This squash-to patch is v2 for adding IPv6 support for ADD_ADDR timeout
test case. And I also put your squash-to patch about "skip mptcp_join
selftest if IPTables is not available" in it together.

Please help me to squash it to the original commit "selftests: mptcp:
add ADD_ADDR timeout test case".

Thanks very much.

-Geliang


Geliang Tang <geliangtang(a)gmail.com> =E4=BA=8E2020=E5=B9=B410=E6=9C=8821=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=882:49=E5=86=99=E9=81=93=EF=BC=
=9A

>
> Added ADD_ADDR IPv6 support for reset_with_add_addr_timeout.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  tools/testing/selftests/net/mptcp/config      |  8 +++-
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 41 ++++++++++++++-----
>  2 files changed, 37 insertions(+), 12 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/sel=
ftests/net/mptcp/config
> index af8c0ca79b98..c74e60a01c17 100644
> --- a/tools/testing/selftests/net/mptcp/config
> +++ b/tools/testing/selftests/net/mptcp/config
> @@ -6,7 +6,11 @@ CONFIG_VETH=3Dy
>  CONFIG_NET_SCH_NETEM=3Dm
>  CONFIG_NETFILTER=3Dy
>  CONFIG_NETFILTER_ADVANCED=3Dy
> +CONFIG_NETFILTER_NETLINK=3Dm
> +CONFIG_NF_TABLES=3Dm
> +CONFIG_NFT_COUNTER=3Dm
> +CONFIG_NFT_COMPAT=3Dm
>  CONFIG_NETFILTER_XTABLES=3Dm
>  CONFIG_NETFILTER_XT_MATCH_BPF=3Dm
> -CONFIG_IP_NF_IPTABLES=3Dm
> -CONFIG_IP_NF_FILTER=3Dm
> +CONFIG_NF_TABLES_IPV4=3Dy
> +CONFIG_NF_TABLES_IPV6=3Dy
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index 3767acb9bb12..0d93b243695f 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -13,17 +13,19 @@ capture=3D0
>
>  TEST_COUNT=3D0
>
> -# generated using "nfbpf_compile '(tcp[34] & 0xf0) =3D=3D 0x30'"
> -CBPF_MPTCP_SUBOPTION_ADD_ADDR=3D"13,
> +# generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) =3D=3D 0x30) ||
> +#                                (ip6 && (ip6[74] & 0xf0) =3D=3D 0x30)'"
> +CBPF_MPTCP_SUBOPTION_ADD_ADDR=3D"14,
>                                48 0 0 0,
>                                84 0 0 240,
> -                              21 0 9 64,
> -                              48 0 0 9,
> -                              21 0 7 6,
> -                              40 0 0 6,
> -                              69 5 0 8191,
> -                              177 0 0 0,
> -                              80 0 0 34,
> +                              21 0 3 64,
> +                              48 0 0 54,
> +                              84 0 0 240,
> +                              21 6 7 48,
> +                              48 0 0 0,
> +                              84 0 0 240,
> +                              21 0 4 96,
> +                              48 0 0 74,
>                                84 0 0 240,
>                                21 0 1 48,
>                                6 0 0 65535,
> @@ -100,10 +102,18 @@ reset_with_cookies()
>
>  reset_with_add_addr_timeout()
>  {
> +       local ip=3D"${1:-4}"
> +       local tables
> +
> +       tables=3D"iptables"
> +       if [ $ip -eq 6 ]; then
> +               tables=3D"ip6tables"
> +       fi
> +
>         reset
>
>         ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=3D1
> -       ip netns exec $ns2 iptables -A OUTPUT -p tcp \
> +       ip netns exec $ns2 $tables -A OUTPUT -p tcp \
>                 -m tcp --tcp-option 30 \
>                 -m bpf --bytecode \
>                 "$CBPF_MPTCP_SUBOPTION_ADD_ADDR" \
> @@ -122,6 +132,17 @@ if [ $? -ne 0 ];then
>         exit $ksft_skip
>  fi
>
> +iptables -V > /dev/null 2>&1
> +if [ $? -ne 0 ];then
> +       echo "SKIP: Could not run all tests without iptables tool"
> +       exit $ksft_skip
> +fi
> +
> +ip6tables -V > /dev/null 2>&1
> +if [ $? -ne 0 ];then
> +       echo "SKIP: Could not run all tests without ip6tables tool"
> +       exit $ksft_skip
> +fi
>
>  check_transfer()
>  {
> --
> 2.26.2
>
--===============5933906799605876292==--
