Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284C82EDD41
	for <mptcp@lists.linux.dev>; Fri, 10 Oct 2025 10:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760091189; cv=none; b=Gvl0btD0reXJgQOzFO3HZVu2DsRskA0oS17OMRj2u2kTxxbIxUQKRjvSPmVlZ4euqO8bMwxbIEcPyUq4iT5SzdewHj271fgFPvUeOOI/GwLhHDEf4Khr/N04wV2GVVAgX9cvISV9Y9JRBodixgYOf0dI7Ts86KTWIFbpo8nxFys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760091189; c=relaxed/simple;
	bh=r99CMKp2MiQBrv+VBx42UT6fgolm2ZmEBHya0cDnBmI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cFEucW6T7K6JZ5Ewg5NLXGg275bR+Xw5j9XSAiAWFNS7/nq03D7avC+GND/2UehshifG1r5Uz5e0biWacEWz8NONAbxOr/PFhGXkVOZOWfcugMweKipysPMvpnycVN3cDuLA6q4B6sGEfJ2BqtjyNXKj5NLVJKDtIkLZ6oKd7yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYtAXI2k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYtAXI2k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E93C4CEF1;
	Fri, 10 Oct 2025 10:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760091188;
	bh=r99CMKp2MiQBrv+VBx42UT6fgolm2ZmEBHya0cDnBmI=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=jYtAXI2kU6rCYyQcJa8i/so/Hl7XmDSzqwHX+WtpLeZhta5aCiR1HK15ohYYqvEU1
	 4g359wmlGHNpapB93AEWJtcZvtLAjMWZ6bDjB+VraONHN3WgBmSAQ8/MbtiJvMWudy
	 OJ3h5e9QXmVqO1pLRB3W1ZgoLYB6PU8V4O8k7WPnAmzrlHrzdYXUXlHiaPkVRFpUQg
	 8iin2JGWHlBwwVXfYerkyDhRq+2BosF3Qd77jl8/xyZaV2mA5cYaxnoIW7QqWufcpx
	 LlOJZpnTqqWp3TpWpkGkWDjkGMNlKD76a1+v+HR/H7tEZliZ4aIg5TlgxrDS/lnG6O
	 oJz6D9Tw0ZNOQ==
Message-ID: <c95505aa16c3c4660a509a749c8dd48c30c4b077.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 4/7] selftests: mptcp: join: mark implicit
 tests as skipped if not supported
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Fri, 10 Oct 2025 18:13:05 +0800
In-Reply-To: <20251008-c-flag-add-addr-delay-v1-4-c624eb3bf10d@kernel.org>
References: <20251008-c-flag-add-addr-delay-v1-0-c624eb3bf10d@kernel.org>
	 <20251008-c-flag-add-addr-delay-v1-4-c624eb3bf10d@kernel.org>
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
> Fixes: 36c4127ae8dd ("selftests: mptcp: join: skip implicit tests if
> not supported")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

This patch looks good to me.

Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 59983aed2591..b2a8c51a3969 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -3939,7 +3939,7 @@ endpoint_tests()
>  	# subflow_rebuild_header is needed to support the implicit
> flag
>  	# userspace pm type prevents add_addr
>  	if reset "implicit EP" &&
> -	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
> +	   continue_if mptcp_lib_kallsyms_has
> "subflow_rebuild_header$"; then
>  		pm_nl_set_limits $ns1 2 2
>  		pm_nl_set_limits $ns2 2 2
>  		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> @@ -3964,7 +3964,7 @@ endpoint_tests()
>  	fi
>  
>  	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2
> REJECT OUTPUT &&
> -	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
> +	   continue_if mptcp_lib_kallsyms_has
> "subflow_rebuild_header$"; then
>  		start_events
>  		pm_nl_set_limits $ns1 0 3
>  		pm_nl_set_limits $ns2 0 3
> 

