Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F023191CA
	for <mptcp@lists.linux.dev>; Fri, 24 Oct 2025 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761310613; cv=none; b=k21JV4XMVVO3WcmDXrDCYPDMfql6uun3lU7IlJTTItjApdghEVJ/6c663rA8rP/7LELC65ZcxD53TNg+/lutzwqV7xZ75LtAILmHKKPhEH3PucEB74hRXlRge8nEF0/g9Mq2tZpHbet8hhtYp1W51STOYZbeSVS/D0SIzh9hc6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761310613; c=relaxed/simple;
	bh=L1mybk0+rZNdSb2cidfoCbaMrwSS1920zSu99XV0B/g=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YroOuoiF0UpLezcHxZ0npXh+48K9G78FxPxkfrSWTPmETRVHM51jb8y91VQQF4t1QhhYYAEVx87vPFPSq7pNENFNMcPJFigncGaFjlGoV42xZzbi93XP/imVxBnkHlY7MztkDJVw6c52NtcdyGnBC6g9NgQ6lMpNcycndoEabVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmULLd0u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmULLd0u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFE3C4CEF1;
	Fri, 24 Oct 2025 12:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761310611;
	bh=L1mybk0+rZNdSb2cidfoCbaMrwSS1920zSu99XV0B/g=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=lmULLd0u8LhjyMo0HNf+PrgjmkGw/6ixU48O8GdynR99NolRbWRGWch5nytkx2w34
	 yVZEk5AcY2z4b8uxvgC2o6Siqk+vhWFLxlxKejWOiA4CaRU0qX3iYJyJ6zlFmw+hbn
	 KOiGKpD+6rbxPLq/9bRF3wD+2W2Xal3Z5il2RlOe8hrRfiEUf9Ne8FkFiqpD7aKuKk
	 S/at9/OpfHDGKeq7RVL34pPgAvmxLeGTElUKRwwJxfXdTIlOAqNxp6dsqrluuzjrSx
	 /p8Jm/Tf8w0LKiuLooQdDFPKfRgPRcsGPQnyOuMSoCphosT7MygLNGq2cxPrilJ8WG
	 BNV+xNlJWFvBg==
Message-ID: <95fdc88fbeba58db5976f97f117b1579a873c051.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: join: validate
 extra bind cases"
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Fri, 24 Oct 2025 20:56:49 +0800
In-Reply-To: <20251024-sft-fix-bind-timeout-v1-1-cb81a67b222c@kernel.org>
References: <20251024-sft-fix-bind-timeout-v1-1-cb81a67b222c@kernel.org>
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

Thanks for this fix.

On Fri, 2025-10-24 at 12:02 +0200, Matthieu Baerts (NGI0) wrote:
> I was going to send the related commit upstream, but then I realised
> in
> a slow environment (e.g. public CI), with a debug kernel, the default
> 10 seconds timeout can be too short:
> 
>   086 multiple bind to allow joins v4
>         join Rx                             [ OK ]
>         join Tx                             [ OK ]
>   main_loop_s: timed out
>         add addr rx                         [ OK ]
>         add addr echo rx                    [ OK ]
>   ./mptcp_join.sh: line 3305: kill: (2032) - No such process
> 
> This doesn't affect the results, because it happens after the test,
> when
> checking the counters. Still, better to fix that by using an infinite
> timeout: the process will be killed at the end.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 05faacefb719..e0cdb9c662aa 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -3293,7 +3293,7 @@ bind_tests()
>  
>  		# Launching another app listening on a different
> address
>  		# Note: it could be a totally different app, e.g.
> nc, socat, ...
> -		ip netns exec ${ns1} ./mptcp_connect -l -p
> "$(get_port)" \
> +		ip netns exec ${ns1} ./mptcp_connect -l -t -1 -p
> "$(get_port)" \

A timeout of -1 means block indefinitely, right? Do you think using the
default 30 seconds (-t ${timeout_poll}) is sufficient?

Thanks,
-Geliang

>  			-s MPTCP 10.0.2.1 &
>  		extra_bind=$!
>  
> @@ -3315,7 +3315,7 @@ bind_tests()
>  
>  		# Launching another app listening on a different
> address
>  		# Note: it could be a totally different app, e.g.
> nc, socat, ...
> -		ip netns exec ${ns1} ./mptcp_connect -l -p
> "$(get_port)" \
> +		ip netns exec ${ns1} ./mptcp_connect -l -t -1 -p
> "$(get_port)" \
>  			-s MPTCP dead:beef:2::1 &
>  		extra_bind=$!
>  
> @@ -3340,7 +3340,7 @@ bind_tests()
>  
>  		wait_ll_ready $ns1 # to be able to bind
>  		wait_ll_ready $ns2 # also needed to bind on the
> client side
> -		ip netns exec ${ns1} ./mptcp_connect -l -p
> "$(get_port)" \
> +		ip netns exec ${ns1} ./mptcp_connect -l -t -1 -p
> "$(get_port)" \
>  			-s MPTCP "${ns1ll2}%ns1eth2" &
>  		extra_bind=$!
>  
> @@ -3371,7 +3371,7 @@ bind_tests()
>  
>  		wait_ll_ready $ns1 # to be able to bind
>  		wait_ll_ready $ns2 # also needed to bind on the
> client side
> -		ip netns exec ${ns1} ./mptcp_connect -l -p
> "$(get_port)" \
> +		ip netns exec ${ns1} ./mptcp_connect -l -t -1 -p
> "$(get_port)" \
>  			-s MPTCP "${ns1ll2}%ns1eth2" &
>  		extra_bind=$!
>  
> 
> ---
> base-commit: 6354d0b328258d1974cc7d32a82983b2bd3e5871
> change-id: 20251024-sft-fix-bind-timeout-7e7c47a5d50a
> 
> Best regards,

