Content-Type: multipart/mixed; boundary="===============5748618445743946429=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v6 mptcp-next 9/9] selftests: mptcp: add
 testcases for ADD_ADDR with port
Date: Wed, 25 Nov 2020 11:10:20 +0800
Message-ID: <CA+WQbwvJYiGnvzGSZifqQ154rzWd3hECU1ohPW0-PzCsH64wqg@mail.gmail.com>
In-Reply-To: e740557e2b2a45a0ef480d362a393132ec0fa685.1606272852.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6917

--===============5748618445743946429==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Sorry, there's a checkpatch.pl warning here:

WARNING: Possible unwrapped commit description (prefer a maximum 75
chars per line)
#19:
This patch added testcases for ADD_ADDR with port and the related MIB count=
ers

Please update the commit message to:

"""
This patch added testcases for ADD_ADDR with port and the related MIB
counters check in chk_add_nr. The output looks like this:
"""

-Geliang

Geliang Tang <geliangtang(a)gmail.com> =E4=BA=8E2020=E5=B9=B411=E6=9C=8825=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8811:01=E5=86=99=E9=81=93=EF=BC=
=9A
>
> This patch added testcases for ADD_ADDR with port and the related MIB cou=
nters
> check in chk_add_nr. The output looks like this:
>
>  24 signal address with port           syn[ ok ] - synack[ ok ] - ack[ ok=
 ]
>                                        add[ ok ] - echo  [ ok ] - pt [ ok=
 ]
>                                        syn[ ok ] - synack[ ok ] - ack[ ok=
 ]
>  25 subflow and signal with port       syn[ ok ] - synack[ ok ] - ack[ ok=
 ]
>                                        add[ ok ] - echo  [ ok ] - pt [ ok=
 ]
>                                        syn[ ok ] - synack[ ok ] - ack[ ok=
 ]
>  26 remove single address with port    syn[ ok ] - synack[ ok ] - ack[ ok=
 ]
>                                        add[ ok ] - echo  [ ok ] - pt [ ok=
 ]
>                                        syn[ ok ] - synack[ ok ] - ack[ ok=
 ]
>                                        rm [ ok ] - sf    [ ok ]
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 114 +++++++++++++++++-
>  1 file changed, 113 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index 0eae628d1ffd..10d702a1e5d3 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -429,6 +429,10 @@ chk_add_nr()
>  {
>         local add_nr=3D$1
>         local echo_nr=3D$2
> +       local port_nr=3D${3:-0}
> +       local syn_nr=3D${4:-$port_nr}
> +       local syn_ack_nr=3D${5:-$port_nr}
> +       local ack_nr=3D${6:-$port_nr}
>         local count
>         local dump_stats
>
> @@ -451,7 +455,55 @@ chk_add_nr()
>                 ret=3D1
>                 dump_stats=3D1
>         else
> -               echo "[ ok ]"
> +               echo -n "[ ok ]"
> +       fi
> +
> +       if [ $port_nr -gt 0 ]; then
> +               echo -n " - pt "
> +               count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtPort=
Add | awk '{print $2}'`
> +               [ -z "$count" ] && count=3D0
> +               if [ "$count" !=3D "$port_nr" ]; then
> +                       echo "[fail] got $count ADD_ADDR[s] with port exp=
ected $port_nr"
> +                       ret=3D1
> +                       dump_stats=3D1
> +               else
> +                       echo "[ ok ]"
> +               fi
> +
> +               printf "%-39s %s" " " "syn"
> +               count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtPort=
SynRx | awk '{print $2}'`
> +               [ -z "$count" ] && count=3D0
> +               if [ "$count" !=3D "$syn_nr" ]; then
> +                       echo "[fail] got $count JOIN[s] syn with port exp=
ected $syn_nr"
> +                       ret=3D1
> +                       dump_stats=3D1
> +               else
> +                       echo -n "[ ok ]"
> +               fi
> +
> +               echo -n " - synack"
> +               count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtPort=
SynAckRx | awk '{print $2}'`
> +               [ -z "$count" ] && count=3D0
> +               if [ "$count" !=3D "$syn_ack_nr" ]; then
> +                       echo "[fail] got $count JOIN[s] synack with port =
expected $syn_ack_nr"
> +                       ret=3D1
> +                       dump_stats=3D1
> +               else
> +                       echo -n "[ ok ]"
> +               fi
> +
> +               echo -n " - ack"
> +               count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtPort=
AckRx | awk '{print $2}'`
> +               [ -z "$count" ] && count=3D0
> +               if [ "$count" !=3D "$ack_nr" ]; then
> +                       echo "[fail] got $count JOIN[s] ack with port exp=
ected $ack_nr"
> +                       ret=3D1
> +                       dump_stats=3D1
> +               else
> +                       echo "[ ok ]"
> +               fi
> +       else
> +               echo ""
>         fi
>
>         if [ "${dump_stats}" =3D 1 ]; then
> @@ -717,6 +769,66 @@ chk_join_nr "remove subflow and signal IPv6" 2 2 2
>  chk_add_nr 1 1
>  chk_rm_nr 1 1
>
> +# signal address with port
> +reset
> +ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> +ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> +ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
> +run_tests $ns1 $ns2 10.0.1.1
> +chk_join_nr "signal address with port" 1 1 1
> +chk_add_nr 1 1 1
> +
> +# subflow and signal with port
> +reset
> +ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
> +ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> +ip netns exec $ns2 ./pm_nl_ctl limits 1 2
> +ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> +run_tests $ns1 $ns2 10.0.1.1
> +chk_join_nr "subflow and signal with port" 2 2 2
> +chk_add_nr 1 1 1
> +
> +# single address with port, remove
> +reset
> +ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> +ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
> +ip netns exec $ns2 ./pm_nl_ctl limits 1 1
> +run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
> +chk_join_nr "remove single address with port" 1 1 1
> +chk_add_nr 1 1 1
> +chk_rm_nr 0 0
> +
> +# subflow and signal with port, remove
> +reset
> +ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> +ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
> +ip netns exec $ns2 ./pm_nl_ctl limits 1 2
> +ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> +run_tests $ns1 $ns2 10.0.1.1 0 1 1 slow
> +chk_join_nr "remove subflow and signal with port" 2 2 2
> +chk_add_nr 1 1 1
> +chk_rm_nr 1 1
> +
> +# multiple addresses with port
> +reset
> +ip netns exec $ns1 ./pm_nl_ctl limits 2 2
> +ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
> +ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal port 10100
> +ip netns exec $ns2 ./pm_nl_ctl limits 2 2
> +run_tests $ns1 $ns2 10.0.1.1
> +chk_join_nr "multiple addresses with port" 2 2 2
> +chk_add_nr 2 2 2
> +
> +# multiple addresses with ports
> +reset
> +ip netns exec $ns1 ./pm_nl_ctl limits 2 2
> +ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
> +ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal port 10101
> +ip netns exec $ns2 ./pm_nl_ctl limits 2 2
> +run_tests $ns1 $ns2 10.0.1.1
> +chk_join_nr "multiple addresses with ports" 2 2 2
> +chk_add_nr 2 2 2
> +
>  # single subflow, syncookies
>  reset_with_cookies
>  ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> --
> 2.26.2
>
--===============5748618445743946429==--
