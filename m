Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993BD63B9
	for <mptcp@lists.linux.dev>; Sun, 28 Dec 2025 02:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766889682; cv=none; b=rlwR0wbfv3apoNGNwaqH/oaszgydY1A5MfJrc28wCWodyl1pGejcaMlqS2+X8XXCx/Lylm7jLTnSRgWSjQWR3h0DCHQgfEniVPxamaCKwBnaNCDmOICuKaGgTkxxa25BsJa7pPda5UHmqD96AXcs5oyoVAcaBOXwnT89Takv18c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766889682; c=relaxed/simple;
	bh=y409UCEvV4+6M4phn6MuS/WjlCuT+8tI30Xh4BS2TQM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J+EO20qf7hU+1bLmFx7Fc5NHMEzzwcVV9C0GJ8YZCNKuRqHKcId1ogYAxUmZQXbEWiN9iiLWLrcqNUrPTLw3M8i1sxjUqvrN12zxeYIYxx2a8oiZxAhOy9aucB039WnFOVqWphNWUbe8Sio0508W1DEVybcg5vv6oov/+H/g0oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtzR4Re9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtzR4Re9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8A1C4CEF1;
	Sun, 28 Dec 2025 02:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766889682;
	bh=y409UCEvV4+6M4phn6MuS/WjlCuT+8tI30Xh4BS2TQM=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=JtzR4Re9C5H/r+hstuVLcvwgn/qOtauZ22bSNthcGs+8ndRNs9TcRvAJeUYl2KqpK
	 SVSr8a/WmbkZTUZJQRNiucU8sd4UoCNPgBSaDe3z5UIKHrbqQj4QOjU8+O0p7x7kDJ
	 IcnSW7dyTQUBkLduGZhK2drYhtN0OkLV3EeUmIZpKm+FLH0qtkXgtwddcG4InPslG9
	 sgpjlJ7NxdWZew6Cj8ekraDpei/AKV6zqpOkl6mkRqHYdq750MsJDGs5RNQPC1OcBT
	 EQYa5Tg+/GXYyi17q3iRPkGcixwB7dUKG4K7LMdgwMb8Rf0Bn0nDXkbJNPnyP/XDOp
	 SemesUXsVf8hA==
Message-ID: <3e571d6931ca7277ad062df8ed0f23a78f00c912.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 05/11] selftests: mptcp: join: wait for estab
 event instead of MPJ
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Sun, 28 Dec 2025 10:41:18 +0800
In-Reply-To: <20251226-mptcp-issue-603-v1-5-bb30e331b839@kernel.org>
References: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
	 <20251226-mptcp-issue-603-v1-5-bb30e331b839@kernel.org>
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

Thanks for this patch.

On Fri, 2025-12-26 at 07:40 +0100, Matthieu Baerts (NGI0) wrote:
> 'wait_mpj' was used just after having created a background
> connection,
> but before creating new subflows. So no MPJ were sent. The intention
> was
> to wait for the connection to be established, which was the same as
> doing a simple sleep with a "random" value.
> 
> Instead, wait for an "established" event. With this, the tests can
> finish quicker.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 18 ++++++++++-----
> ---
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index bf0cc59b5210..9b58d7567c18 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -4000,7 +4000,7 @@ userspace_tests()
>  		{ timeout_test=120 test_linkfail=128 speed=5 \
>  			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
>  		local tests_pid=$!
> -		wait_mpj $ns1
> +		wait_event ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
>  		userspace_pm_add_addr $ns1 10.0.2.1 10
>  		userspace_pm_add_addr $ns1 10.0.3.1 20
>  		chk_join_nr 2 2 2
> @@ -4033,7 +4033,7 @@ userspace_tests()
>  		{ timeout_test=120 test_linkfail=128 speed=5 \
>  			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
>  		local tests_pid=$!
> -		wait_mpj $ns2
> +		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
>  		userspace_pm_add_sf $ns2 10.0.3.2 20
>  		chk_join_nr 1 1 1
>  		chk_mptcp_info subflows 1 subflows 1
> @@ -4061,7 +4061,7 @@ userspace_tests()
>  		{ timeout_test=120 test_linkfail=128 speed=5 \
>  			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
>  		local tests_pid=$!
> -		wait_mpj $ns2
> +		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
>  		chk_mptcp_info subflows 0 subflows 0
>  		chk_subflows_total 1 1
>  		userspace_pm_add_sf $ns2 10.0.3.2 0
> @@ -4082,7 +4082,7 @@ userspace_tests()
>  		{ timeout_test=120 test_linkfail=128 speed=5 \
>  			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
>  		local tests_pid=$!
> -		wait_mpj $ns2
> +		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
>  		userspace_pm_add_sf $ns2 10.0.3.2 20
>  		chk_join_nr 1 1 1
>  		chk_mptcp_info subflows 1 subflows 1
> @@ -4106,7 +4106,7 @@ userspace_tests()
>  		{ timeout_test=120 test_linkfail=128 speed=5 \
>  			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
>  		local tests_pid=$!
> -		wait_mpj $ns1
> +		wait_event ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
>  		userspace_pm_add_addr $ns1 10.0.2.1 10
>  		chk_join_nr 1 1 1
>  		chk_add_nr 1 1
> @@ -4159,6 +4159,7 @@ endpoint_tests()
>  	# userspace pm type prevents add_addr
>  	if reset "implicit EP" &&
>  	   continue_if mptcp_lib_kallsyms_has
> "subflow_rebuild_header$"; then
> +		start_events

What do you think about using reset_with_events here?

Thanks,
-Geliang

>  		pm_nl_set_limits $ns1 2 2
>  		pm_nl_set_limits $ns2 2 2
>  		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> @@ -4166,7 +4167,7 @@ endpoint_tests()
>  			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
>  		local tests_pid=$!
>  
> -		wait_mpj $ns1
> +		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
>  		pm_nl_check_endpoint "creation" \
>  			$ns2 10.0.2.2 id 1 flags implicit
>  		chk_mptcp_info subflows 1 subflows 1
> @@ -4180,6 +4181,7 @@ endpoint_tests()
>  		pm_nl_check_endpoint "modif is allowed" \
>  			$ns2 10.0.2.2 id 1 flags signal
>  		mptcp_lib_kill_group_wait $tests_pid
> +		kill_events_pids
>  	fi
>  
>  	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2
> REJECT OUTPUT &&
> @@ -4193,7 +4195,7 @@ endpoint_tests()
>  			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
>  		local tests_pid=$!
>  
> -		wait_mpj $ns2
> +		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
>  		pm_nl_check_endpoint "creation" \
>  			$ns2 10.0.2.2 id 2 flags subflow dev ns2eth2
>  		chk_subflow_nr "before delete id 2" 2
> @@ -4271,7 +4273,7 @@ endpoint_tests()
>  			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
>  		local tests_pid=$!
>  
> -		wait_mpj $ns2
> +		wait_event ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
>  		pm_nl_check_endpoint "creation" \
>  			$ns1 10.0.2.1 id 1 flags signal
>  		chk_subflow_nr "before delete" 2
