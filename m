Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541EF36DA15
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 09:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141294; cv=none; b=Ad87YOvsWBV8+Q8g3VUzKxtj55k2eqtATmfOD0cpwSUUnwgmRydmTt7KL8Oxjd29hRpGeDdPFa7G/CzNQzLd35Bf/CIAqkpNPvCYaWsDsFnk6mPAuIfwv/zQEzanhEjcN1WpX6t7+iNAZoQXKB2LnZmZUuSdwiV4RgZHxrl9CFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141294; c=relaxed/simple;
	bh=cc2Q35P8xmy9ETrqHhGfIW78fxpDPXFgGb/a+JFYOzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kdzc+ZZNIbkJKRXkag3lX0N8o4HNgWtnLy09H90D29udMWXy266+Kqv/gYDRRtpj+11TLwnPg72WKdNa+qwEt6RTFqB0sR4/ZpAo5iPMs0PyGUxardnvEhPB+9foejD521CAqSSTST+X0c79z8pX5hkhWDS+jgO2tINYdmYd0X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9o2F6EO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9o2F6EO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDB31F000C4;
	Fri, 16 Oct 2026 09:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792141293;
	bh=VPkAhERgkM1llMp/Sep26PBOLoRNyYkwF4NEnSdmut0=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=R9o2F6EOju3HgqowN3FLmlXKz6Kh6J3fcN7jvP4EQiJAkZb/V2duaKw0SdvK1YopE
	 KULsc1n9hpzPkkqEfFSAxsWxCQdYXa8uR8p3iPfOhriG0vEHVOdD4dda8rcbK9fDLO
	 kmWtLtGTJFC+V42WBvOEJZyT+k2mN9bZMgV7K/BewheDSZ5N1wkOrWWq0bwc+7mtHP
	 PQQt30EMLzU3TlUG2i7uhjpLhB/EqOBfKDbGgsI1D9T/sFAE6c7YwL+ciiYkLNT961
	 5Evjx25AJuuWVH7CkMvL5k3687x/9W/ldq/kjvZXEfI91Yn+foIYneDePiWcCw62hF
	 hDpyRtjHv8nTA==
Message-ID: <f084569d-5d99-4cd9-8513-26a21c9b2517@kernel.org>
Date: Fri, 16 Oct 2026 11:01:29 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v4 3/3] selftests: mptcp: join: validate
 subflow retry after link failure
Content-Language: fr
To: Anil Kaushik <anilkaushikwireless@gmail.com>, mptcp@lists.linux.dev
References: <20261016055010.980819-1-anilkaushikwireless@gmail.com>
 <20261016055010.980819-4-anilkaushikwireless@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261016055010.980819-4-anilkaushikwireless@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/10/2026 07:50, Anil Kaushik wrote:
> Test the subflow-retries limit, with its default value, and a long
> connection in the background: drop the packets the client sends from
> the additional subflow address with netfilter, without bringing the link
> down, until the subflow is closed and re-created. Let them through again
> later than tcp_syn_retries allows, and check the subflow comes back from
> the same address. Then do the same with the initial subflow.
> 
> Finally, close the connection while a subflow is being re-created, and
> check the netlink events. The big files used for the long connection
> are removed at the end.
> 
> Assisted-by: LLM
> Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
> ---
> 
> Notes:
>     v4:
>      - default limit, no sysctl or MIB counter
>      - more SYN retransmissions than tcp_syn_retries
>      - close the connection while a subflow is re-created
>      - check the netlink events
>      - check the waits and the new subflow port, remove the big files at
>        the end (Sashiko)
>     v3:
>      - check the subflow address, create the files before the background job
>     v2:
>      - one test, with netfilter
> 
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 124 ++++++++++++++++++
>  1 file changed, 124 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index f4d8afaeda4f..bbeff6739c5a 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2151,6 +2151,69 @@ wait_attempt_fail()
>  	return 1
>  }
>  
> +# $1: ns ; $2: counter ; $3: expected minimum value
> +wait_counter()
> +{
> +	local cnt
> +
> +	for _ in $(seq $((timeout_poll * 10))); do
> +		cnt=$(mptcp_lib_get_counter "${1}" "${2}")
> +		[ "${cnt:-0}" -ge "${3}" ] && return 0
> +		sleep 0.1
> +	done
> +
> +	return 1
> +}
> +
> +# $1: client address ; prints the local address and port of its subflow
> +sf_from()
> +{
> +	ip netns exec $ns2 ss -tnH state established src "${1}" |
> +		awk '{ print $3; exit }'
> +}
> +
> +# $1: client address to block
> +#
> +# The link stays up, but the client packets from this address are dropped:
> +# the subflow using it is closed after a few retransmissions, and re-created.
> +# The packets go through again later than tcp_syn_retries allows: the new
> +# subflow still connects thanks to the subflow-retries limit.
> +sf_retry_after_block()
> +{
> +	local syn_tx ack_rx before after
> +
> +	syn_tx=$(mptcp_lib_get_counter $ns2 "MPTcpExtMPJoinSynTx")
> +	ack_rx=$(mptcp_lib_get_counter $ns1 "MPTcpExtMPJoinAckRx")
> +	before=$(sf_from "${1}")
> +
> +	print_check "subflow from ${1}"
> +	if [ -z "${before}" ]; then
> +		fail_test "no established subflow from ${1} before the block"
> +		return
> +	fi
> +
> +	ip netns exec $ns2 nft add rule ip filter OUTPUT ip saddr "${1}" drop
> +	if ! wait_counter $ns2 "MPTcpExtMPJoinSynTx" $((${syn_tx:-0} + 1)); then
> +		ip netns exec $ns2 nft flush chain ip filter OUTPUT
> +		fail_test "subflow from ${1} not re-created"
> +		return
> +	fi
> +	sleep 5

Do you need a long sleep here?

We usually try to have "quick" tests. Here it looks like we do nothing
for 5 seconds, and possibly the sleep is not even needed.

> +	ip netns exec $ns2 nft flush chain ip filter OUTPUT
> +
> +	if ! wait_counter $ns1 "MPTcpExtMPJoinAckRx" $((${ack_rx:-0} + 1)); then
> +		fail_test "re-created subflow from ${1} not established"
> +		return
> +	fi
> +
> +	after=$(sf_from "${1}")
> +	if [ -z "${after}" ] || [ "${after}" = "${before}" ]; then
> +		fail_test "no new subflow from ${1}: ${before} -> ${after}"
> +	else
> +		print_ok
> +	fi
> +}
> +
>  set_userspace_pm()
>  {
>  	local ns=$1
> @@ -2585,6 +2648,67 @@ link_failure_tests()
>  		chk_stale_nr $ns2 1 -1 2
>  		chk_link_usage $ns2 ns2eth3 $cinsent 50
>  	fi
> +
> +	# subflows closed after a silent link failure, then re-created: the
> +	# additional one, then the initial one. Then close the connection
> +	# while a subflow is being re-created.
> +	if reset_with_events "subflow retry after link failure" &&
> +	   continue_if mptcp_lib_kallsyms_has "mptcp_pm_kernel_retry$"; then

Probably best to check if the new limit exists: modifying pm_nl_ctl (in
a dedicated commit) and see if it is there. Maybe pm_netlink.sh will
need to be modified as well.

(And iproute2 too if you don't mind, please :) )

> +		init_nftables
> +		init_shapers
> +		ip netns exec $ns2 sysctl -q net.ipv4.tcp_retries2=3
> +		ip netns exec $ns2 sysctl -q net.ipv4.tcp_syn_retries=1
> +		ip netns exec $ns2 sysctl -q net.mptcp.close_timeout=5
> +		pm_nl_set_limits $ns1 0 4
> +		pm_nl_set_limits $ns2 0 2
> +		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
> +		# created here, not in the background job, for cleanup()
> +		if [ -z "$cinfail" ]; then
> +			cinfail=$(mktemp)
> +		fi
> +		if [ -z "$sinfail" ]; then
> +			sinfail=$(mktemp)
> +		fi
> +		{ timeout_test=120 test_linkfail=131072 \
> +			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
> +		local tests_pid=$!
> +
> +		wait_counter $ns1 "MPTcpExtMPJoinAckRx" 1
> +		sf_retry_after_block 10.0.3.2
> +		sf_retry_after_block 10.0.1.2
> +
> +		ip netns exec $ns2 nft add rule ip filter OUTPUT \
> +			ip saddr 10.0.3.2 drop
> +		wait_counter $ns2 "MPTcpExtMPJoinSynTx" 4
> +		local retrying=$?
> +		mptcp_lib_kill_group_wait $tests_pid
> +
> +		# stopped at the latest by the close timeout
> +		print_check "no subflow connecting after close"
> +		for _ in $(seq $((timeout_poll * 10))); do
> +			ip netns exec $ns2 ss -tnH state syn-sent | grep -q . ||
> +				break
> +			sleep 0.1
> +		done
> +		if [ "${retrying}" -ne 0 ]; then
> +			fail_test "no subflow re-created before the close"
> +		elif ip netns exec $ns2 ss -tnH state syn-sent | grep -q .; then
> +			fail_test "subflow still connecting after close"
> +		else
> +			print_ok
> +		fi

Best to move this block from print_check in a new helper: we usually
avoid adding "subchecks" in tests directly.

> +		ip netns exec $ns2 nft flush chain ip filter OUTPUT
> +		kill_events_pids
> +
> +		join_syn_tx=4 chk_join_nr 3 3 3
> +		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 3
> +		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 3 error 3
> +
> +		# big files: do not keep them, the next tests create their own
> +		rm -f "$cinfail" "$sinfail"
> +		cinfail=""
> +		sinfail=""
> +	fi
>  }
>  
>  add_addr_timeout_tests()

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

