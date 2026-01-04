Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFFE4207A
	for <mptcp@lists.linux.dev>; Sun,  4 Jan 2026 03:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767496637; cv=none; b=LGwXQBxS2YN5/nbkLC7rXGGyziWATvVtDGdUpasAPT0piDBhkKBwWsg8dQsIUonYLV3hFc79kAGNeD+BWdG+Ui+N+IOX0iSCtpGmeSv83UG+X3obb+Gunn/dQechxMokw78jdwteCamP6TncrSFJ7jGaJLYB/f+AQHWSTYWhuFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767496637; c=relaxed/simple;
	bh=TTbkuwGqi65OwDeuw/iQ1zIfzoa0OhHerTsdBF4lsmM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OSFAzRGEvBELrM+aljEQ67Mo9i49YNuBuGvEvZzJxwLpiNBD+7S+RUYFAJNFln8s4XnVT5yKZx/JPyGZZhdPFjgTbYrbjMJv1/s7zeT0poMxSv1Xw/qRRxU0ocTpmCAOFFU0cTYhF1d8EBsHYBe/znUWX91sq1r5j4q/uNVUFgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDnYekwD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDnYekwD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9C6C16AAE;
	Sun,  4 Jan 2026 03:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767496637;
	bh=TTbkuwGqi65OwDeuw/iQ1zIfzoa0OhHerTsdBF4lsmM=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=YDnYekwDgOTI6Z4XOxfW7WV+w9Q3LqN02BTpf9USv3ULVJdF5vPggzLu+O4catJHx
	 nhXyY2dwXXmzGz3pPedlmZusn2Mss2TiwlA2njXabaUGjUne9Ewr0xF+A0uHnzCcpP
	 3NzJ7GontHwp2QeBb6YCOZj0EEYTLEuhXVAMqt2phNUNc3xLm5ZQ0Rf2VM/uo6b+j1
	 h8YfTt7LKFY86Qa5ToxdA0LdK1i8fPPUzs83Fpit3SJp3wRMbVW6FSLcOMaAfJlvHG
	 iTVaY65+t8lLaJ8emm9q7nhuIS2oe0v0bDJWHadYdcpgbLrTprOMqq4HBqRPc2EgRY
	 6OA8ztZEUWR1g==
Message-ID: <522643c85b522c8cd1ce7642179da7288ea9bd0f.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 02/11] selftests: mptcp: check no dup close
 events after error
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Sun, 04 Jan 2026 11:17:13 +0800
In-Reply-To: <20251226-mptcp-issue-603-v1-2-bb30e331b839@kernel.org>
References: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
	 <20251226-mptcp-issue-603-v1-2-bb30e331b839@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Fri, 2025-12-26 at 07:40 +0100, Matthieu Baerts (NGI0) wrote:
> This validates the previous commit: subflow closed events are re-sent
> with less info when the initial subflow is disconnected after an
> error
> and each time a subflow is closed after that.
> 
> In this new test, the userspace PM is involved because that's how it
> was
> discovered, but it is not specific to it. The initial subflow is
> terminated with a RESET, and that will cause the subflow disconnect.
> Then, a new subflow is initiated, but also got rejected, which cause
> a
> second subflow closed event, but not a third one.
> 
> While at it, in case of failure to get the expected amount of events,
> the events are printed.
> 
> The 'Fixes' tag here below is the same as the one from the previous
> commit: this patch here is not fixing anything wrong in the
> selftests,
> but it validates the previous fix for an issue introduced by this
> commit
> ID.
> 
> Fixes: d82809b6c5f2 ("mptcp: avoid duplicated SUB_CLOSED events")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 49
> +++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index b2e6e548f796..468ffb97293b 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -3872,11 +3872,32 @@ chk_evt_nr()
>  	count=$(grep -cw "type:${evt}" "${evts}")
>  	if [ "${count}" != "${exp}" ]; then
>  		fail_test "got ${count} events, expected ${exp}"
> +		cat "${evts}"
>  	else
>  		print_ok
>  	fi
>  }
>  
> +# $1: ns ; $2: event type ; $3: expected count
> +wait_event()
> +{
> +	local ns="${1}"
> +	local evt_name="${2}"
> +	local exp="${3}"
> +
> +	local evt="${!evt_name}"
> +	local evts="${evts_ns1}"
> +	local count
> +
> +	[ "${ns}" == "ns2" ] && evts="${evts_ns2}"
> +
> +	for _ in $(seq 100); do
> +		count=$(grep -cw "type:${evt}" "${evts}")
> +		[ "${count}" -ge "${exp}" ] && break
> +		sleep 0.1
> +	done
> +}
> +
>  userspace_tests()
>  {
>  	# userspace pm type prevents add_addr
> @@ -4085,6 +4106,34 @@ userspace_tests()
>  		kill_events_pids
>  		mptcp_lib_kill_group_wait $tests_pid
>  	fi
> +
> +	# userspace pm no duplicated spurious close events after an
> error
> +	if reset_with_events "userspace pm no dup close events after
> error" &&
> +	   continue_if mptcp_lib_has_file
> '/proc/sys/net/mptcp/pm_type'; then
> +		set_userspace_pm $ns2
> +		pm_nl_set_limits $ns1 0 2
> +		{ timeout_test=120 test_linkfail=128 speed=slow \
> +			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
> +		local tests_pid=$!
> +		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
> +		userspace_pm_add_sf $ns2 10.0.3.2 20
> +		chk_mptcp_info subflows 1 subflows 1
> +		chk_subflows_total 2 2
> +
> +		# force quick loss
> +		ip netns exec $ns2 sysctl -q
> net.ipv4.tcp_syn_retries=1
> +		if ip netns exec "${ns1}" ${iptables} -A INPUT -s
> "10.0.1.2" -p tcp --tcp-option 30 -j REJECT --reject-with tcp-reset
> &&
> +		   ip netns exec "${ns2}" ${iptables} -A INPUT -d
> "10.0.1.2" -p tcp --tcp-option 30 -j REJECT --reject-with tcp-reset;
> then

These two lines are too long and need to be wrapped.

Thanks,
-Geliang

> +			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1
> +			wait_event ns1 MPTCP_LIB_EVENT_SUB_CLOSED 1
> +			chk_subflows_total 1 1
> +			userspace_pm_add_sf $ns2 10.0.1.2 0
> +			wait_event ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
> +			chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2
> +		fi
> +		kill_events_pids
> +		mptcp_lib_kill_group_wait $tests_pid
> +	fi
>  }
>  
>  endpoint_tests()
