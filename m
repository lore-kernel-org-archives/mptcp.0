Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28464219E8
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763018138; cv=none; b=h+ets3MbBgzWPgPl0TQhG0z3SFwbMPA2ZeO7W3tbtwBe5zilFwezyWdlDyDr81HWPbmv6r7Q5LqhSTGW5sf+68EVmKzc/aF2CIR0smZzFqMaCMqEciuVqtvJWzISVbiLhgOIxBawsTY3Gq/ZUhO3ZvODi9+YtLZoaNFeabS901I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763018138; c=relaxed/simple;
	bh=5dgRNTrOPSFaFr2NA5Of0KzknGFBYH9RmtQ0F3dTkBc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IzRqvtIAjwEaB9TIlUBScfXcysjZbUb8nKODn3nN5yaDZxwqjWewNm+KPGeiA/yXGT4RwEVOnTLuQDkk/HY6ydgQQEGEAvHF3NTSk5kakm3Jf+HjxKYAQ1N2yre0WpjtCtTHWkcBY68fKuZsGzVZU2QYkCzn2HmBNUc34yn3nko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmJlf2Td; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmJlf2Td"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE991C4CEF5;
	Thu, 13 Nov 2025 07:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763018137;
	bh=5dgRNTrOPSFaFr2NA5Of0KzknGFBYH9RmtQ0F3dTkBc=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=JmJlf2Td3EDEz2/Di25m/A1nJSclEnJuTlJGQUDEzqmAfz0TDUAo9CQqynrVIoZTh
	 9l2b6ZIEFbd9FJWDAvpVbxpAdR0e+Iuh3ajV6I2LcGfc63jTKcBj2CwIDj1Q+Yz2Du
	 ZTJ+eRgCXkE7ZyQEImc5qMwJm+nXK5PzKXQVgM+UIMGTTnVqbY3N4vTCCoKX3rB6/f
	 8oqB2xd3FmszRMV35XL92K/i8rTZHqVS3a7StvEbqX0Yey1h4mbsfwSfevngwbp2QZ
	 KYDmYl2QVvyMvqnbzzqH2Etn9XwQRNQ4mD7dlLpagJuhVneK7h/mBmiAVA0cYkZGCI
	 8kfSfh0ufk1lg==
Message-ID: <2a6869ca39bda7ddf8b486cd03e0867b30e0d565.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 4/4] selftests: mptcp: get stats just before
 timing out
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Thu, 13 Nov 2025 15:15:34 +0800
In-Reply-To: <20251108-slft-timeout-stats-v1-4-c2234d277318@kernel.org>
References: <20251108-slft-timeout-stats-v1-0-c2234d277318@kernel.org>
	 <20251108-slft-timeout-stats-v1-4-c2234d277318@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Sat, 2025-11-08 at 15:20 +0100, Matthieu Baerts (NGI0) wrote:
> Recently, some debugging happened around a test that was timing out.
> The
> stats were showing connections being closed which was confusing
> because
> the closing state was caused by the timeout stopping the transfer.
> 
> To avoid such confusion, the timeout is no longer done per
> mptcp_connect
> process, but separately. In case of timeout, the stats are now
> printed,
> then the apps are killed.
> 
> The stats will still be printed after the kill, but that's fine, and
> this might even be useful, just in case. Timeout should be
> exceptional.

Today I found that this patch has increased the runtime of the
selftests, for example:

# 66 ns1 MPTCP -> ns1 (dead:beef:1::1:20004) MPTCP     (duration  
390ms) [ OK ]
# 67 ns1 MPTCP -> ns1 (dead:beef:1::1:20005) TCP       (duration  
415ms) [ OK ]
# 68 ns1 TCP   -> ns1 (dead:beef:1::1:20006) MPTCP     (duration  
380ms) [ OK ]
# Time: 38 seconds
ok 1 test: selftest_mptcp_connect
# time=99

The mptcp_connect test ended after 38 seconds, but it waited an
additional 61 seconds before finally stopping at 99 seconds.

This needs to be fixed, or we should revert this patch first.

Thanks,
-Geliang

> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 21 +++++++++---
> ----
>  tools/testing/selftests/net/mptcp/mptcp_join.sh    | 29 +++++++++++-
> ----------
>  tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 13 ++++++++++
>  tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 21 +++++++++---
> ----
>  tools/testing/selftests/net/mptcp/simult_flows.sh  | 24 ++++++++++--
> ------
>  5 files changed, 66 insertions(+), 42 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index 1149bd150d6a..6bff77ed0a74 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -391,26 +391,29 @@ do_transfer()
>  		mptcp_lib_nstat_init "${connector_ns}"
>  	fi
>  
> -	timeout ${timeout_test} \
> -		ip netns exec ${listener_ns} \
> -			./mptcp_connect -t ${timeout_poll} -l -p
> $port -s ${srv_proto} \
> -				$extra_args $local_addr < "$sin" >
> "$sout" &
> +	ip netns exec ${listener_ns} \
> +		./mptcp_connect -t ${timeout_poll} -l -p $port -s
> ${srv_proto} \
> +			$extra_args $local_addr < "$sin" > "$sout" &
>  	local spid=$!
>  
>  	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"
>  
>  	local start
>  	start=$(date +%s%3N)
> -	timeout ${timeout_test} \
> -		ip netns exec ${connector_ns} \
> -			./mptcp_connect -t ${timeout_poll} -p $port
> -s ${cl_proto} \
> -				$extra_args $connect_addr < "$cin" >
> "$cout" &
> +	ip netns exec ${connector_ns} \
> +		./mptcp_connect -t ${timeout_poll} -p $port -s
> ${cl_proto} \
> +			$extra_args $connect_addr < "$cin" > "$cout"
> &
>  	local cpid=$!
>  
> +	mptcp_lib_wait_timeout "${timeout_test}" "${listener_ns}" \
> +		"${connector_ns}" "${port}" "${cpid}" "${spid}" &
> +	local timeout_pid=$!
> +
>  	wait $cpid
>  	local retc=$?
>  	wait $spid
>  	local rets=$?
> +	kill $timeout_pid 2>/dev/null && timeout_pid=0
>  
>  	local stop
>  	stop=$(date +%s%3N)
> @@ -431,7 +434,7 @@ do_transfer()
>  	local duration
>  	duration=$((stop-start))
>  	printf "(duration %05sms) " "${duration}"
> -	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
> +	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ] || [
> ${timeout_pid} -ne 0 ]; then
>  		mptcp_lib_pr_fail "client exit code $retc, server
> $rets"
>  		mptcp_lib_pr_err_stats "${listener_ns}"
> "${connector_ns}" "${port}"
>  
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 8be8bfa71946..9ce386b3056c 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1041,38 +1041,38 @@ do_transfer()
>  	if [ "$test_linkfail" -gt 1 ];then
>  		listener_in="${sinfail}"
>  	fi
> -	timeout ${timeout_test} \
> -		ip netns exec ${listener_ns} \
> -			./mptcp_connect -t ${timeout_poll} -l -p
> ${port} -s ${srv_proto} \
> -				${extra_srv_args} "${bind_addr}" <
> "${listener_in}" > "${sout}" &
> +	ip netns exec ${listener_ns} \
> +		./mptcp_connect -t ${timeout_poll} -l -p ${port} -s
> ${srv_proto} \
> +			${extra_srv_args} "${bind_addr}" <
> "${listener_in}" > "${sout}" &
>  	local spid=$!
>  
>  	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"
>  
>  	extra_cl_args="$extra_args $extra_cl_args"
>  	if [ "$test_linkfail" -eq 0 ];then
> -		timeout ${timeout_test} \
> -			ip netns exec ${connector_ns} \
> -				./mptcp_connect -t ${timeout_poll} -
> p $port -s ${cl_proto} \
> -					$extra_cl_args $connect_addr
> < "$cin" > "$cout" &
> +		ip netns exec ${connector_ns} \
> +			./mptcp_connect -t ${timeout_poll} -p $port
> -s ${cl_proto} \
> +				$extra_cl_args $connect_addr <
> "$cin" > "$cout" &
>  	elif [ "$test_linkfail" -eq 1 ] || [ "$test_linkfail" -eq 2
> ];then
>  		connector_in="${cinsent}"
>  		( cat "$cinfail" ; sleep 2; link_failure
> $listener_ns ; cat "$cinfail" ) | \
>  			tee "$cinsent" | \
> -			timeout ${timeout_test} \
>  				ip netns exec ${connector_ns} \
>  					./mptcp_connect -t
> ${timeout_poll} -p $port -s ${cl_proto} \
>  						$extra_cl_args
> $connect_addr > "$cout" &
>  	else
>  		connector_in="${cinsent}"
>  		tee "$cinsent" < "$cinfail" | \
> -			timeout ${timeout_test} \
> -				ip netns exec ${connector_ns} \
> -					./mptcp_connect -t
> ${timeout_poll} -p $port -s ${cl_proto} \
> -						$extra_cl_args
> $connect_addr > "$cout" &
> +			ip netns exec ${connector_ns} \
> +				./mptcp_connect -t ${timeout_poll} -
> p $port -s ${cl_proto} \
> +					$extra_cl_args $connect_addr
> > "$cout" &
>  	fi
>  	local cpid=$!
>  
> +	mptcp_lib_wait_timeout "${timeout_test}" "${listener_ns}" \
> +		"${connector_ns}" "${port}" "${cpid}" "${spid}" &
> +	local timeout_pid=$!
> +
>  	pm_nl_set_endpoint $listener_ns $connector_ns $connect_addr
>  	check_cestab $listener_ns $connector_ns
>  
> @@ -1080,13 +1080,14 @@ do_transfer()
>  	local retc=$?
>  	wait $spid
>  	local rets=$?
> +	kill $timeout_pid 2>/dev/null && timeout_pid=0
>  
>  	cond_stop_capture
>  
>  	mptcp_lib_nstat_get "${listener_ns}"
>  	mptcp_lib_nstat_get "${connector_ns}"
>  
> -	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
> +	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ] || [
> ${timeout_pid} -ne 0 ]; then
>  		fail_test "client exit code $retc, server $rets"
>  		mptcp_lib_pr_err_stats "${listener_ns}"
> "${connector_ns}" "${port}"
>  		return 1
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index 91ec75ddcb96..5fea7e7df628 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -350,6 +350,19 @@ mptcp_lib_evts_get_info() {
>  		mptcp_lib_get_info_value "${1}" "^type:${3:-1},"
>  }
>  
> +mptcp_lib_wait_timeout() {
> +	local timeout_test="${1}"
> +	local listener_ns="${2}"
> +	local connector_ns="${3}"
> +	local port="${4}"
> +	shift 4 # rest are PIDs
> +
> +	sleep "${timeout_test}"
> +	mptcp_lib_print_err "timeout"
> +	mptcp_lib_pr_err_stats "${listener_ns}" "${connector_ns}"
> "${port}"
> +	kill "${@}" 2>/dev/null
> +}
> +
>  # $1: PID
>  mptcp_lib_kill_wait() {
>  	[ "${1}" -eq 0 ] && return 0
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> index 6cde7429104b..326466f2f6eb 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> @@ -172,31 +172,34 @@ do_transfer()
>  	mptcp_lib_nstat_init "${listener_ns}"
>  	mptcp_lib_nstat_init "${connector_ns}"
>  
> -	timeout ${timeout_test} \
> -		ip netns exec ${listener_ns} \
> -			$mptcp_connect -t ${timeout_poll} -l -M 1 -p
> $port -s ${srv_proto} -c "${cmsg}" \
> -				${local_addr} < "$sin" > "$sout" &
> +	ip netns exec ${listener_ns} \
> +		$mptcp_connect -t ${timeout_poll} -l -M 1 -p $port -
> s ${srv_proto} -c "${cmsg}" \
> +			${local_addr} < "$sin" > "$sout" &
>  	local spid=$!
>  
>  	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"
>  
> -	timeout ${timeout_test} \
> -		ip netns exec ${connector_ns} \
> -			$mptcp_connect -t ${timeout_poll} -M 2 -p
> $port -s ${cl_proto} -c "${cmsg}" \
> -				$connect_addr < "$cin" > "$cout" &
> +	ip netns exec ${connector_ns} \
> +		$mptcp_connect -t ${timeout_poll} -M 2 -p $port -s
> ${cl_proto} -c "${cmsg}" \
> +			$connect_addr < "$cin" > "$cout" &
>  
>  	local cpid=$!
>  
> +	mptcp_lib_wait_timeout "${timeout_test}" "${listener_ns}" \
> +		"${connector_ns}" "${port}" "${cpid}" "${spid}" &
> +	local timeout_pid=$!
> +
>  	wait $cpid
>  	local retc=$?
>  	wait $spid
>  	local rets=$?
> +	kill $timeout_pid 2>/dev/null && timeout_pid=0
>  
>  	mptcp_lib_nstat_get "${listener_ns}"
>  	mptcp_lib_nstat_get "${connector_ns}"
>  
>  	print_title "Transfer ${ip:2}"
> -	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
> +	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ] || [
> ${timeout_pid} -ne 0 ]; then
>  		mptcp_lib_pr_fail "client exit code $retc, server
> $rets"
>  		mptcp_lib_pr_err_stats "${listener_ns}"
> "${connector_ns}" "${port}"
>  
> diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh
> b/tools/testing/selftests/net/mptcp/simult_flows.sh
> index 503cb59571a4..cc4d40d149e2 100755
> --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
> +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
> @@ -158,24 +158,27 @@ do_transfer()
>  	mptcp_lib_nstat_init "${ns3}"
>  	mptcp_lib_nstat_init "${ns1}"
>  
> -	timeout ${timeout_test} \
> -		ip netns exec ${ns3} \
> -			./mptcp_connect -jt ${timeout_poll} -l -p
> $port -T $max_time \
> -				0.0.0.0 < "$sin" > "$sout" &
> +	ip netns exec ${ns3} \
> +		./mptcp_connect -jt ${timeout_poll} -l -p $port -T
> $max_time \
> +			0.0.0.0 < "$sin" > "$sout" &
>  	local spid=$!
>  
>  	mptcp_lib_wait_local_port_listen "${ns3}" "${port}"
>  
> -	timeout ${timeout_test} \
> -		ip netns exec ${ns1} \
> -			./mptcp_connect -jt ${timeout_poll} -p $port
> -T $max_time \
> -				10.0.3.3 < "$cin" > "$cout" &
> +	ip netns exec ${ns1} \
> +		./mptcp_connect -jt ${timeout_poll} -p $port -T
> $max_time \
> +			10.0.3.3 < "$cin" > "$cout" &
>  	local cpid=$!
>  
> +	mptcp_lib_wait_timeout "${timeout_test}" "${ns3}" "${ns1}"
> "${port}" \
> +		"${cpid}" "${spid}" &
> +	local timeout_pid=$!
> +
>  	wait $cpid
>  	local retc=$?
>  	wait $spid
>  	local rets=$?
> +	kill $timeout_pid 2>/dev/null && timeout_pid=0
>  
>  	if $capture; then
>  		sleep 1
> @@ -191,8 +194,9 @@ do_transfer()
>  	cmp $cin $sout > /dev/null 2>&1
>  	local cmpc=$?
>  
> -	if [ $retc -eq 0 ] && [ $rets -eq 0 ] && \
> -	   [ $cmpc -eq 0 ] && [ $cmps -eq 0 ]; then
> +	if [ $retc -eq 0 ] && [ $rets -eq 0 ] &&
> +	   [ $cmpc -eq 0 ] && [ $cmps -eq 0 ] &&
> +	   [ $timeout_pid -eq 0 ]; then
>  		printf "%-16s" " max $max_time "
>  		mptcp_lib_pr_ok
>  		cat "$capout"
> 

