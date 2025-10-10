Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE7126FA77
	for <mptcp@lists.linux.dev>; Fri, 10 Oct 2025 10:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760091129; cv=none; b=lNafNUMwwYBSabs99C4SRufo7yFMtCI/BJozKLZ9vRwS9RcvL1qr+C9pVLoEH0VEiYdqB1onnR4sKPuj5RlTP1QuN3tvzlmJCgZV4LYheHmlaf/GHQvhCELG2j7k6I+3Jo9WCA+3VF/e2qi229Q/cAw1sNsKiEu8/mIHqCM/WAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760091129; c=relaxed/simple;
	bh=j0voTGVh278xQ5QF23hqIqjxANnXn68j+xGCecuUvUI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ogEeBcurTgSBz18ZbG01RUJQbniC2jhIPYRuGQq+TYEM++X1r2dB50yGlz/QiGPgFNqz84I9ROlJ+lrM9IUBDH7bVnlwnkIRHLV1VgVb38OIvGUGbOcYE0xu6mVTV/L/20/wp4O3Gvf2A781pQVbLk56drjBovanpu7VGkWiTiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dj19k06N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dj19k06N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF197C4CEF5;
	Fri, 10 Oct 2025 10:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760091126;
	bh=j0voTGVh278xQ5QF23hqIqjxANnXn68j+xGCecuUvUI=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Dj19k06N2U0BTnCM/yxwksncEFrVzZQzQiz8OBxHzQoiuTrTtN/MZ4HfUz1oHst68
	 JkTmy5q8riGTI0byUWvyk/yp0hN4gpmncNaMM97fCzZBOVPTfu6DTs82EOROEkDupo
	 Fl01gXTU/72fqlYsfDpoh6M6MWYYv67hmLjiLVaMJ8sbW6XpbdwkBWdHShA+cfoFc8
	 YjszKRKIO7vZq6/IPYt7L4u7UIb7umfXgibd3R5accSWqFwoUxwaKeX8PIu+j0YiNn
	 YZgBidARYTrBYDJVUDeqgxBmf3kO+0BoC4BNW78LENmZDJzsm+2so5zbE7T0lFK/1l
	 X5Yy4VshzjREA==
Message-ID: <ac60f12f22ccfc13477fb82814c8befedf6b18d9.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 2/7] selftests: mptcp: join: mark 'flush
 re-add' as skipped if not supported
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Fri, 10 Oct 2025 18:12:02 +0800
In-Reply-To: <20251008-c-flag-add-addr-delay-v1-2-c624eb3bf10d@kernel.org>
References: <20251008-c-flag-add-addr-delay-v1-0-c624eb3bf10d@kernel.org>
	 <20251008-c-flag-add-addr-delay-v1-2-c624eb3bf10d@kernel.org>
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
> Fixes: e06959e9eebd ("selftests: mptcp: join: test for flush/re-add
> endpoints")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

This patch looks good to me.

Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index c90d8e8b95cb..deba21ca5a97 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -4115,7 +4115,7 @@ endpoint_tests()
>  
>  	# flush and re-add
>  	if reset_with_tcp_filter "flush re-add" ns2 10.0.3.2 REJECT
> OUTPUT &&
> -	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
> +	   continue_if mptcp_lib_kallsyms_has
> "subflow_rebuild_header$"; then
>  		pm_nl_set_limits $ns1 0 2
>  		pm_nl_set_limits $ns2 1 2
>  		# broadcast IP: no packet for this address will be
> received on ns1
> 

