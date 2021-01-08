Content-Type: multipart/mixed; boundary="===============4479268958879075826=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v9 mptcp-next 9/9] selftests: mptcp: add
 testcases for ADD_ADDR with port
Date: Fri, 08 Jan 2021 15:01:07 -0800
Message-ID: <75e47be-9a3e-f4c7-c41c-e0aa36ca1d85@linux.intel.com>
In-Reply-To: 5381fb7d3e8478ea5192044cef1e897a2512879b.1609820648.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7289

--===============4479268958879075826==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 5 Jan 2021, Geliang Tang wrote:

> This patch added testcases for ADD_ADDR with port and the related MIB
> counters check in chk_add_nr. The output looks like this:
>
> 24 signal address with port           syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                       add[ ok ] - echo  [ ok ] - pt [ ok ]
>                                       syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                       syn[ ok ] - ack   [ ok ]
> 25 subflow and signal with port       syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                       add[ ok ] - echo  [ ok ] - pt [ ok ]
>                                       syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                       syn[ ok ] - ack   [ ok ]
> 26 remove single address with port    syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                       add[ ok ] - echo  [ ok ] - pt [ ok ]
>                                       syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                       syn[ ok ] - ack   [ ok ]
>                                       rm [ ok ] - sf    [ ok ]
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> .../testing/selftests/net/mptcp/mptcp_join.sh | 160 +++++++++++++++++-
> 1 file changed, 159 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/test=
ing/selftests/net/mptcp/mptcp_join.sh
> index cf9ae0bd7254..f32fa18b4695 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -487,6 +487,12 @@ chk_add_nr()
> {
> 	local add_nr=3D$1
> 	local echo_nr=3D$2
> +	local port_nr=3D${3:-0}
> +	local syn_nr=3D${4:-$port_nr}
> +	local syn_ack_nr=3D${5:-$port_nr}
> +	local ack_nr=3D${6:-$port_nr}
> +	local mis_syn_nr=3D${7:-0}
> +	local mis_ack_nr=3D${8:-0}
> 	local count
> 	local dump_stats
>
> @@ -509,7 +515,87 @@ chk_add_nr()
> 		ret=3D1
> 		dump_stats=3D1
> 	else
> -		echo "[ ok ]"
> +		echo -n "[ ok ]"
> +	fi
> +
> +	if [ $port_nr -gt 0 ]; then

I get a lot of these errors in the existing tests:

./mptcp_join.sh: line 524: [: -gt: unary operator expected



> +		echo -n " - pt "
> +		count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtPortAdd | awk '{p=
rint $2}'`
> +		[ -z "$count" ] && count=3D0
> +		if [ "$count" !=3D "$port_nr" ]; then
> +			echo "[fail] got $count ADD_ADDR[s] with a port-number expected $port=
_nr"
> +			ret=3D1
> +			dump_stats=3D1
> +		else
> +			echo "[ ok ]"
> +		fi
> +
> +		printf "%-39s %s" " " "syn"
> +		count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortSynRx |
> +			awk '{print $2}'`
> +		[ -z "$count" ] && count=3D0
> +		if [ "$count" !=3D "$syn_nr" ]; then
> +			echo "[fail] got $count JOIN[s] syn with a different \
> +				port-number expected $syn_nr"
> +			ret=3D1
> +			dump_stats=3D1
> +		else
> +			echo -n "[ ok ]"
> +		fi
> +
> +		echo -n " - synack"
> +		count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinPortSynAckR=
x |
> +			awk '{print $2}'`
> +		[ -z "$count" ] && count=3D0
> +		if [ "$count" !=3D "$syn_ack_nr" ]; then
> +			echo "[fail] got $count JOIN[s] synack with a different \
> +				port-number expected $syn_ack_nr"
> +			ret=3D1
> +			dump_stats=3D1
> +		else
> +			echo -n "[ ok ]"
> +		fi
> +
> +		echo -n " - ack"
> +		count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortAckRx |
> +			awk '{print $2}'`
> +		[ -z "$count" ] && count=3D0
> +		if [ "$count" !=3D "$ack_nr" ]; then
> +			echo "[fail] got $count JOIN[s] ack with a different \
> +				port-number expected $ack_nr"
> +			ret=3D1
> +			dump_stats=3D1
> +		else
> +			echo "[ ok ]"
> +		fi
> +
> +		printf "%-39s %s" " " "syn"
> +		count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPortSynRx=
 |
> +			awk '{print $2}'`
> +		[ -z "$count" ] && count=3D0
> +		if [ "$count" !=3D "$mis_syn_nr" ]; then
> +			echo "[fail] got $count JOIN[s] syn with a mismatched \
> +				port-number expected $mis_syn_nr"
> +			ret=3D1
> +			dump_stats=3D1
> +		else
> +			echo -n "[ ok ]"
> +		fi
> +
> +		echo -n " - ack   "
> +		count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPortAckRx=
 |
> +			awk '{print $2}'`
> +		[ -z "$count" ] && count=3D0
> +		if [ "$count" !=3D "$mis_ack_nr" ]; then
> +			echo "[fail] got $count JOIN[s] ack with a mismatched \
> +				port-number expected $mis_ack_nr"
> +			ret=3D1
> +			dump_stats=3D1
> +		else
> +			echo "[ ok ]"
> +		fi
> +	else
> +		echo ""
> 	fi
>
> 	if [ "${dump_stats}" =3D 1 ]; then
> @@ -955,6 +1041,78 @@ chk_join_nr "single address, backup" 1 1 1
> chk_add_nr 1 1
> chk_prio_nr 1 0
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
> +run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
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
> +run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
> +chk_join_nr "remove subflow and signal with port" 2 2 2
> +chk_add_nr 1 1 1
> +chk_rm_nr 1 1
> +
> +# subflows and signal with port, flush
> +reset
> +ip netns exec $ns1 ./pm_nl_ctl limits 0 3
> +ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
> +ip netns exec $ns2 ./pm_nl_ctl limits 1 3
> +ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> +ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
> +run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
> +chk_join_nr "flush subflows and signal with port" 3 3 3
> +chk_add_nr 1 1
> +chk_rm_nr 2 2
> +

These last two tests failed for me:

38 remove subflow and signal with port  syn[ ok ] - synack[ ok ] - ack[ ok =

]
                                         add[ ok ] - echo  [ ok ]
                                         rm [fail] got 0 RM_ADDR[s] =

expected 1
  - sf    [fail] got 0 RM_SUBFLOW[s] expected 1
./mptcp_join.sh: line 524: [: -gt: unary operator expected

Server ns stats
MPTcpExtMPCapableSYNRX          1                  0.0
MPTcpExtMPCapableACKRX          1                  0.0
MPTcpExtMPJoinSynRx             2                  0.0
MPTcpExtMPJoinAckRx             2                  0.0
MPTcpExtEchoAdd                 1                  0.0
MPTcpExtPortAdd                 1                  0.0
MPTcpExtMPJoinPortSynRx         1                  0.0
MPTcpExtMPJoinPortAckRx         1                  0.0
Client ns stats
MPTcpExtMPJoinSynAckRx          2                  0.0
MPTcpExtAddAddr                 1                  0.0
MPTcpExtPortAdd                 1                  0.0
MPTcpExtMPJoinPortSynAckRx      1                  0.0
39 flush subflows and signal with port  syn[ ok ] - synack[ ok ] - ack[ ok =

]
                                         add[ ok ] - echo  [ ok ]
                                         rm [fail] got 0 RM_ADDR[s] =

expected 2
  - sf    [fail] got 0 RM_SUBFLOW[s] expected 2
./mptcp_join.sh: line 524: [: -gt: unary operator expected

Server ns stats
MPTcpExtMPCapableSYNRX          1                  0.0
MPTcpExtMPCapableACKRX          1                  0.0
MPTcpExtMPJoinSynRx             3                  0.0
MPTcpExtMPJoinAckRx             3                  0.0
MPTcpExtEchoAdd                 1                  0.0
MPTcpExtPortAdd                 1                  0.0
MPTcpExtMPJoinPortSynRx         1                  0.0
MPTcpExtMPJoinPortAckRx         1                  0.0
Client ns stats
MPTcpExtMPJoinSynAckRx          3                  0.0
MPTcpExtAddAddr                 1                  0.0
MPTcpExtPortAdd                 1                  0.0
MPTcpExtMPJoinPortSynAckRx      1                  0.0


Are these passing for you with the latest export branch?


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
> # single subflow, syncookies
> reset_with_cookies
> ip netns exec $ns1 ./pm_nl_ctl limits 0 1
> -- =

> 2.29.2
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============4479268958879075826==--
