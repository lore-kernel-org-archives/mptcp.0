Content-Type: multipart/mixed; boundary="===============5109898257686692864=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v5 mptcp-next 2/2] selftests: mptcp: add
 ADD_ADDR timeout test case
Date: Fri, 16 Oct 2020 17:28:20 +0800
Message-ID: <CA+WQbwt0Kzp7yGcs=htGjOs0uvXxKLGsm51oCq_L49Jez2pwWQ@mail.gmail.com>
In-Reply-To: e0e12d919cae042e299ca326452847984800e77f.1601536190.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6327

--===============5109898257686692864==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

As I mentioned in the last meeting, I want to add ADD_ADDR timeout IPv6
test case. My patch is something like this:

+reset_with_add_addr6_timeout()
+{
+       reset
+
+       ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=3D1
+       ip netns exec $ns2 ip6tables -A OUTPUT -p tcp \
+               -m tcp --tcp-option 30 \
+               -m bpf --bytecode \
+               "$(nfbpf_compile '(tcp[34] & 0xf0) =3D=3D 0x30')" \
+               -j DROP
+}
+
 for arg in "$@"; do
        if [ "$arg" =3D "-c" ]; then
                capture=3D1
@@ -590,6 +604,22 @@ ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2
flags subflow
 run_tests $ns1 $ns2 dead:beef:1::1 0 0 slow
 chk_join_nr "single subflow IPv6" 1 1 1

+# add_addr timeout IPv6
+reset_with_add_addr6_timeout
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
+run_tests $ns1 $ns2 dead:beef:1::1 0 0 slow
+chk_join_nr "signal address, ADD_ADDR6 timeout" 1 1 1
+chk_add_nr 4 0
+
 # signal address IPv6
 reset
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1

But this BPF (tcp[34] & 0xf0) =3D=3D 0x30') is not working on IPv6, please
give me some help
about how to get this right offset value on IPv6. Thanks very much.

-Geliang

Geliang Tang <geliangtang(a)gmail.com> =E4=BA=8E2020=E5=B9=B410=E6=9C=881=
=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=883:26=E5=86=99=E9=81=93=EF=BC=
=9A
>
> This patch added the test case for retransmitting ADD_ADDR when timeout
> occurs. It set NS1's add_addr_timeout to 1 second, and drop NS2's ADD_ADDR
> echo packets.
>
> Here we need to slow down the transfer process of all data to let the
> ADD_ADDR suboptions can be retransmitted three times. So we added a new
> parameter "speed" for do_transfer, it can be set with fast or slow.
>
> We also added three new optional parameters for run_tests, and dropped
> run_remove_tests function.
>
> Since we added the netfilter rules in this test case, we need to update
> the "config" file.
>
> Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  tools/testing/selftests/net/mptcp/config      |  6 ++
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 73 +++++++++++++------
>  2 files changed, 55 insertions(+), 24 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/sel=
ftests/net/mptcp/config
> index 8df5cb8f71ff..af8c0ca79b98 100644
> --- a/tools/testing/selftests/net/mptcp/config
> +++ b/tools/testing/selftests/net/mptcp/config
> @@ -4,3 +4,9 @@ CONFIG_INET_DIAG=3Dm
>  CONFIG_INET_MPTCP_DIAG=3Dm
>  CONFIG_VETH=3Dy
>  CONFIG_NET_SCH_NETEM=3Dm
> +CONFIG_NETFILTER=3Dy
> +CONFIG_NETFILTER_ADVANCED=3Dy
> +CONFIG_NETFILTER_XTABLES=3Dm
> +CONFIG_NETFILTER_XT_MATCH_BPF=3Dm
> +CONFIG_IP_NF_IPTABLES=3Dm
> +CONFIG_IP_NF_FILTER=3Dm
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index 08f53d86dedc..3767acb9bb12 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -13,6 +13,22 @@ capture=3D0
>
>  TEST_COUNT=3D0
>
> +# generated using "nfbpf_compile '(tcp[34] & 0xf0) =3D=3D 0x30'"
> +CBPF_MPTCP_SUBOPTION_ADD_ADDR=3D"13,
> +                              48 0 0 0,
> +                              84 0 0 240,
> +                              21 0 9 64,
> +                              48 0 0 9,
> +                              21 0 7 6,
> +                              40 0 0 6,
> +                              69 5 0 8191,
> +                              177 0 0 0,
> +                              80 0 0 34,
> +                              84 0 0 240,
> +                              21 0 1 48,
> +                              6 0 0 65535,
> +                              6 0 0 0"
> +
>  init()
>  {
>         capout=3D$(mktemp)
> @@ -82,6 +98,18 @@ reset_with_cookies()
>         done
>  }
>
> +reset_with_add_addr_timeout()
> +{
> +       reset
> +
> +       ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=3D1
> +       ip netns exec $ns2 iptables -A OUTPUT -p tcp \
> +               -m tcp --tcp-option 30 \
> +               -m bpf --bytecode \
> +               "$CBPF_MPTCP_SUBOPTION_ADD_ADDR" \
> +               -j DROP
> +}
> +
>  for arg in "$@"; do
>         if [ "$arg" =3D "-c" ]; then
>                 capture=3D1
> @@ -135,6 +163,7 @@ do_transfer()
>         connect_addr=3D"$5"
>         rm_nr_ns1=3D"$6"
>         rm_nr_ns2=3D"$7"
> +       speed=3D"$8"
>
>         port=3D$((10000+$TEST_COUNT))
>         TEST_COUNT=3D$((TEST_COUNT+1))
> @@ -159,7 +188,7 @@ do_transfer()
>                 sleep 1
>         fi
>
> -       if [[ $rm_nr_ns1 -eq 0 && $rm_nr_ns2 -eq 0 ]]; then
> +       if [ $speed =3D "fast" ]; then
>                 mptcp_connect=3D"./mptcp_connect -j"
>         else
>                 mptcp_connect=3D"./mptcp_connect -r"
> @@ -250,26 +279,13 @@ run_tests()
>         listener_ns=3D"$1"
>         connector_ns=3D"$2"
>         connect_addr=3D"$3"
> +       rm_nr_ns1=3D"${4:-0}"
> +       rm_nr_ns2=3D"${5:-0}"
> +       speed=3D"${6:-fast}"
>         lret=3D0
>
> -       do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_=
addr} 0 0
> -       lret=3D$?
> -       if [ $lret -ne 0 ]; then
> -               ret=3D$lret
> -               return
> -       fi
> -}
> -
> -run_remove_tests()
> -{
> -       listener_ns=3D"$1"
> -       connector_ns=3D"$2"
> -       connect_addr=3D"$3"
> -       rm_nr_ns1=3D"$4"
> -       rm_nr_ns2=3D"$5"
> -       lret=3D0
> -
> -       do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_=
addr} ${rm_nr_ns1} ${rm_nr_ns2}
> +       do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_=
addr} \
> +               ${rm_nr_ns1} ${rm_nr_ns2} ${speed}
>         lret=3D$?
>         if [ $lret -ne 0 ]; then
>                 ret=3D$lret
> @@ -491,12 +507,21 @@ run_tests $ns1 $ns2 10.0.1.1
>  chk_join_nr "multiple subflows and signal" 3 3 3
>  chk_add_nr 1 1
>
> +# add_addr timeout
> +reset_with_add_addr_timeout
> +ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> +ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> +ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
> +run_tests $ns1 $ns2 10.0.1.1 0 0 slow
> +chk_join_nr "signal address, ADD_ADDR timeout" 1 1 1
> +chk_add_nr 4 0
> +
>  # single subflow, remove
>  reset
>  ip netns exec $ns1 ./pm_nl_ctl limits 0 1
>  ip netns exec $ns2 ./pm_nl_ctl limits 0 1
>  ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> -run_remove_tests $ns1 $ns2 10.0.1.1 0 1
> +run_tests $ns1 $ns2 10.0.1.1 0 1 slow
>  chk_join_nr "remove single subflow" 1 1 1
>  chk_rm_nr 1 1
>
> @@ -506,7 +531,7 @@ ip netns exec $ns1 ./pm_nl_ctl limits 0 2
>  ip netns exec $ns2 ./pm_nl_ctl limits 0 2
>  ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
>  ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> -run_remove_tests $ns1 $ns2 10.0.1.1 0 2
> +run_tests $ns1 $ns2 10.0.1.1 0 2 slow
>  chk_join_nr "remove multiple subflows" 2 2 2
>  chk_rm_nr 2 2
>
> @@ -515,7 +540,7 @@ reset
>  ip netns exec $ns1 ./pm_nl_ctl limits 0 1
>  ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
>  ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> -run_remove_tests $ns1 $ns2 10.0.1.1 1 0
> +run_tests $ns1 $ns2 10.0.1.1 1 0 slow
>  chk_join_nr "remove single address" 1 1 1
>  chk_add_nr 1 1
>  chk_rm_nr 0 0
> @@ -526,7 +551,7 @@ ip netns exec $ns1 ./pm_nl_ctl limits 0 2
>  ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
>  ip netns exec $ns2 ./pm_nl_ctl limits 1 2
>  ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> -run_remove_tests $ns1 $ns2 10.0.1.1 1 1
> +run_tests $ns1 $ns2 10.0.1.1 1 1 slow
>  chk_join_nr "remove subflow and signal" 2 2 2
>  chk_add_nr 1 1
>  chk_rm_nr 1 1
> @@ -538,7 +563,7 @@ ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags sig=
nal
>  ip netns exec $ns2 ./pm_nl_ctl limits 1 3
>  ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
>  ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
> -run_remove_tests $ns1 $ns2 10.0.1.1 1 2
> +run_tests $ns1 $ns2 10.0.1.1 1 2 slow
>  chk_join_nr "remove subflows and signal" 3 3 3
>  chk_add_nr 1 1
>  chk_rm_nr 2 2
> --
> 2.26.2
>
--===============5109898257686692864==--
