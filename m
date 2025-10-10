Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE09323B607
	for <mptcp@lists.linux.dev>; Fri, 10 Oct 2025 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760091213; cv=none; b=kVLXTkRGR8zjlrx95ldQUwxa2np3iFn9tMOed9oLsNxlwNw1DqDnG7kU3jXjSKUWgh4Aiuf1v7fA+DMEV240x1E+TbnTGFt5Nn4BuYUC9F/TCtGE+yqQIUuVtN7C5WwKFH/uj6ca9ZABdnGpzjA8lM7wOTJOCd1vWHNtucIxoGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760091213; c=relaxed/simple;
	bh=2SoBwWJ2WjiMPeOUnKOPQ0NJGKJhl21xOj3YSV01jXI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ud2tnqGFjdXwWpM/QD87gYcwdNbRv0LFZvOyrwLkO8mwii5bY2XJQxf6hm42+ky+ASzxdj1zjY0xtN5c9KxIwP6eMCgyL2JLTWno2Gs7MBk9unI23ZMSVbyx0oTFvlpnHIcj5iOuv0k0daX36ov2XJZHCwSAF5XlQpWDNJXYiYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2QGBGBL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2QGBGBL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5509DC4CEF1;
	Fri, 10 Oct 2025 10:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760091213;
	bh=2SoBwWJ2WjiMPeOUnKOPQ0NJGKJhl21xOj3YSV01jXI=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=u2QGBGBLwtGWnzJpDV7IVCWrxkt+uWwO01uP36QvupiVaLBr/00iygtf7PxtLeusu
	 A6f/RG2H7cAihIN2dShFetLC8D1YWS1wy0zi2eeJ1ZQD7jlxnK7f9Dz/SoP5fcJhVH
	 Y4iyKu/Oxy8AENAR04xouaQlfSOTz28fZx0sXg0koH/r0HVEpvEPRIWVUXVHq5/KE9
	 RSLkjVraigmH4q/V9znvR+zytX2U5MgJPlQ5jgY6DxzTuQ+V4Jii+I5neUf7dDUcoh
	 eUEesvwPxNQjjsCqYAhQ1XVGXJxqQd6mo7oBG4SYhL8bE2BDAkAt5YDJ4uzJovPgtb
	 kZJQJZ0w2Kgbw==
Message-ID: <9bbedcaff68784b2c56c7c08d4eaaa990563c7db.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 5/7] selftests: mptcp: join: mark laminar
 tests as skipped if not supported
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Fri, 10 Oct 2025 18:13:30 +0800
In-Reply-To: <20251008-c-flag-add-addr-delay-v1-5-c624eb3bf10d@kernel.org>
References: <20251008-c-flag-add-addr-delay-v1-0-c624eb3bf10d@kernel.org>
	 <20251008-c-flag-add-addr-delay-v1-5-c624eb3bf10d@kernel.org>
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

On Wed, 2025-10-08 at 15:59 +0200, Matthieu Baerts (NGI0) wrote:
> The call to 'continue_if' was missing: it properly marks a subtest as
> 'skipped' if the attached condition is not valid.
> 
> Without that, the test is wrongly marked as passed on older kernels.
> 
> Fixes: c912f935a5c7 ("selftests: mptcp: join: validate new laminar
> endp")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

This patch looks good to me.

Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index b2a8c51a3969..78a1aa4ecff2 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2324,7 +2324,7 @@ laminar_endp_tests()
>  {
>  	# no laminar endpoints: routing rules are used
>  	if reset_with_tcp_filter "without a laminar endpoint" ns1
> 10.0.2.2 REJECT &&
> -	   mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$";
> then
> +	   continue_if mptcp_lib_kallsyms_has
> "mptcp_pm_get_endp_laminar_max$"; then
>  		pm_nl_set_limits $ns1 0 2
>  		pm_nl_set_limits $ns2 2 2
>  		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> @@ -2336,7 +2336,7 @@ laminar_endp_tests()
>  
>  	# laminar endpoints: this endpoint is used
>  	if reset_with_tcp_filter "with a laminar endpoint" ns1
> 10.0.2.2 REJECT &&
> -	   mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$";
> then
> +	   continue_if mptcp_lib_kallsyms_has
> "mptcp_pm_get_endp_laminar_max$"; then
>  		pm_nl_set_limits $ns1 0 2
>  		pm_nl_set_limits $ns2 2 2
>  		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> @@ -2348,7 +2348,7 @@ laminar_endp_tests()
>  
>  	# laminar endpoints: these endpoints are used
>  	if reset_with_tcp_filter "with multiple laminar endpoints"
> ns1 10.0.2.2 REJECT &&
> -	   mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$";
> then
> +	   continue_if mptcp_lib_kallsyms_has
> "mptcp_pm_get_endp_laminar_max$"; then
>  		pm_nl_set_limits $ns1 0 2
>  		pm_nl_set_limits $ns2 2 2
>  		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> @@ -2363,7 +2363,7 @@ laminar_endp_tests()
>  
>  	# laminar endpoints: only one endpoint is used
>  	if reset_with_tcp_filter "single laminar endpoint" ns1
> 10.0.2.2 REJECT &&
> -	   mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$";
> then
> +	   continue_if mptcp_lib_kallsyms_has
> "mptcp_pm_get_endp_laminar_max$"; then
>  		pm_nl_set_limits $ns1 0 2
>  		pm_nl_set_limits $ns2 2 2
>  		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> @@ -2376,7 +2376,7 @@ laminar_endp_tests()
>  
>  	# laminar endpoints: subflow and laminar flags
>  	if reset_with_tcp_filter "sublow + laminar endpoints" ns1
> 10.0.2.2 REJECT &&
> -	   mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$";
> then
> +	   continue_if mptcp_lib_kallsyms_has
> "mptcp_pm_get_endp_laminar_max$"; then
>  		pm_nl_set_limits $ns1 0 4
>  		pm_nl_set_limits $ns2 2 4
>  		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> 

