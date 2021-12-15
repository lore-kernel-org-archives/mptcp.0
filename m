Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB2568
	for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 01:32:07 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="226401622"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="226401622"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 17:32:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="465334397"
Received: from gchandra-mobl.amr.corp.intel.com ([10.209.52.30])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 17:32:07 -0800
Date: Tue, 14 Dec 2021 17:32:06 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-next] selftests: mptcp: more stable join
 tests-cases.
In-Reply-To: <b6f8d2e06bfa3b15cc7fa0ac3076cfafd7448b07.1639482622.git.pabeni@redhat.com>
Message-ID: <542f3ab-d93a-4cba-3bdf-4b8b85744073@linux.intel.com>
References: <b6f8d2e06bfa3b15cc7fa0ac3076cfafd7448b07.1639482622.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 14 Dec 2021, Paolo Abeni wrote:

> MPTCP join self-tests are a bit fragile as they reply on
> delays instead of events to catch-up with the expected
> sockets states.
>
> Replace the delay with state checking where possible and
> reduce the number of sleeps in the most complex scenarios.
>
> This will both reduce the tests run-time and will improve
> stability.

Running this in my local VM I saw more failures with the patch than 
without (this is a kernel with a lot of debug turned on):

27 remove single subflow                syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         rm [fail] got 0 RM_ADDR[s] expected 1 - sf    [ ok ]

...

37 flush invalid addresses              syn[ ok ] - synack[ ok ] - ack[ ok ]
                                         add[ ok ] - echo  [ ok ]
                                         rm [ ok ] - sf    [ ok ]
copyfd_io_poll: poll timed out (events: POLLIN 1, POLLOUT 0)
  client exit code 2, server 0


Could have been an unlucky run on my machine :)

Matthieu, does it improve behavior in your test environments?


- Mat


>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
> - fix ipv6 addr handling
> ---
> .../testing/selftests/net/mptcp/mptcp_join.sh | 65 ++++++++++++++-----
> 1 file changed, 49 insertions(+), 16 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 8f49bbd4a201..7014391d750e 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -238,6 +238,42 @@ is_v6()
> 	[ -z "${1##*:*}" ]
> }
>
> +# $1: ns, $2: port
> +wait_local_port_listen()
> +{
> +	local listener_ns="${1}"
> +	local port="${2}"
> +
> +	local port_hex i
> +
> +	port_hex="$(printf "%04X" "${port}")"
> +	for i in $(seq 10); do
> +		ip netns exec "${listener_ns}" cat /proc/net/tcp* | \
> +			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/ && \$4 ~ /0A/) {rc=0; exit}} END {exit rc}" &&
> +			break
> +		sleep 0.1
> +	done
> +}
> +
> +# $1: ns, $2: endpoint id
> +wait_address_deleted()
> +{
> +	local ns="${1}"
> +	local addr="${2}"
> +	local cnt
> +
> +	# 'ss' will trim everything from the rightmost ':' on looking
> +	# for a trailing port number. Append a colon to avoid ipv6
> +	# address corruption
> +	is_v6 ${addr} && addr="inet6:$addr:"
> +
> +	for i in $(seq 10); do
> +		cnt=$(ss -HtON ${ns} state big src = ${addr} | wc -l)
> +		[ "$cnt" = 0 ] || break;
> +		sleep 0.1
> +	done
> +}
> +
> do_transfer()
> {
> 	listener_ns="$1"
> @@ -307,7 +343,7 @@ do_transfer()
> 	fi
> 	spid=$!
>
> -	sleep 1
> +	wait_local_port_listen "${listener_ns}" "${port}"
>
> 	if [ "$test_link_fail" -eq 0 ];then
> 		timeout ${timeout_test} \
> @@ -324,10 +360,13 @@ do_transfer()
> 	fi
> 	cpid=$!
>
> +	# let the mptcp subflow be established in background before
> +	# do endpoint manipulation
> +	[ $addr_nr_ns1 = "0" -a $addr_nr_ns2 = "0" ] || sleep 1
> +
> 	if [ $addr_nr_ns1 -gt 0 ]; then
> 		let add_nr_ns1=addr_nr_ns1
> 		counter=2
> -		sleep 1
> 		while [ $add_nr_ns1 -gt 0 ]; do
> 			local addr
> 			if is_v6 "${connect_addr}"; then
> @@ -339,7 +378,6 @@ do_transfer()
> 			let counter+=1
> 			let add_nr_ns1-=1
> 		done
> -		sleep 1
> 	elif [ $addr_nr_ns1 -lt 0 ]; then
> 		let rm_nr_ns1=-addr_nr_ns1
> 		if [ $rm_nr_ns1 -lt 8 ]; then
> @@ -347,22 +385,18 @@ do_transfer()
> 			pos=1
> 			dump=(`ip netns exec ${listener_ns} ./pm_nl_ctl dump`)
> 			if [ ${#dump[@]} -gt 0 ]; then
> -				sleep 1
> -
> 				while [ $counter -le $rm_nr_ns1 ]
> 				do
> 					id=${dump[$pos]}
> 					ip netns exec ${listener_ns} ./pm_nl_ctl del $id
> -					sleep 1
> +					wait_address_deleted ${listener_ns} ${dump[-1]}
> 					let counter+=1
> 					let pos+=5
> 				done
> 			fi
> 		elif [ $rm_nr_ns1 -eq 8 ]; then
> -			sleep 1
> 			ip netns exec ${listener_ns} ./pm_nl_ctl flush
> 		elif [ $rm_nr_ns1 -eq 9 ]; then
> -			sleep 1
> 			ip netns exec ${listener_ns} ./pm_nl_ctl del 0 ${connect_addr}
> 		fi
> 	fi
> @@ -373,10 +407,13 @@ do_transfer()
> 		addr_nr_ns2=${addr_nr_ns2:9}
> 	fi
>
> +	# if newly added endpoints must be deleted, give the background msk
> +	# some time to created them
> +	[ $addr_nr_ns1 -gt 0 -a $addr_nr_ns2 -lt 0 ] && sleep 1
> +
> 	if [ $addr_nr_ns2 -gt 0 ]; then
> 		let add_nr_ns2=addr_nr_ns2
> 		counter=3
> -		sleep 1
> 		while [ $add_nr_ns2 -gt 0 ]; do
> 			local addr
> 			if is_v6 "${connect_addr}"; then
> @@ -388,7 +425,6 @@ do_transfer()
> 			let counter+=1
> 			let add_nr_ns2-=1
> 		done
> -		sleep 1
> 	elif [ $addr_nr_ns2 -lt 0 ]; then
> 		let rm_nr_ns2=-addr_nr_ns2
> 		if [ $rm_nr_ns2 -lt 8 ]; then
> @@ -396,19 +432,17 @@ do_transfer()
> 			pos=1
> 			dump=(`ip netns exec ${connector_ns} ./pm_nl_ctl dump`)
> 			if [ ${#dump[@]} -gt 0 ]; then
> -				sleep 1
> -
> 				while [ $counter -le $rm_nr_ns2 ]
> 				do
> +					# rm_addr are serialized, allow the previous one to complete
> 					id=${dump[$pos]}
> 					ip netns exec ${connector_ns} ./pm_nl_ctl del $id
> -					sleep 1
> +					wait_address_deleted ${connector_ns} ${dump[-1]}
> 					let counter+=1
> 					let pos+=5
> 				done
> 			fi
> 		elif [ $rm_nr_ns2 -eq 8 ]; then
> -			sleep 1
> 			ip netns exec ${connector_ns} ./pm_nl_ctl flush
> 		elif [ $rm_nr_ns2 -eq 9 ]; then
> 			local addr
> @@ -417,7 +451,6 @@ do_transfer()
> 			else
> 				addr="10.0.1.2"
> 			fi
> -			sleep 1
> 			ip netns exec ${connector_ns} ./pm_nl_ctl del 0 $addr
> 		fi
> 	fi
> @@ -1685,7 +1718,7 @@ add_addr_ports_tests()
> 	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
> 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
> 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
> -	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
> +	run_tests $ns1 $ns2 10.0.1.1 0 -8 -2 slow
> 	chk_join_nr "flush subflows and signal with port" 3 3 3
> 	chk_add_nr 1 1
> 	chk_rm_nr 2 2
> -- 
> 2.33.1
>
>
>

--
Mat Martineau
Intel
