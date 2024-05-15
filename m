Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE60F28680
	for <mptcp@lists.linux.dev>; Wed, 15 May 2024 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715791383; cv=none; b=itJcSGGeYh4GyEemqJZ/fwYRiA12F17vCziQwDPgyPZyO/QDgMIi9cCKcvnkY91du6t34RXdKQrBzmGiv/uNLamP3EzWJcxPYUirdR151ZbIw/B5z3V6pdOU1awtyrqYZJX9V6TdDmvWPHUho+Y33KUKZlJO0k4KzgedSCUZpwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715791383; c=relaxed/simple;
	bh=NsbE6lFvwQptzbfyYqBEU4ZmpAajFjYVtvOgTaP6FCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSXORKMkcE90jaknd2Z3a3m9emVn9l9DJezeItqmnfBzgw1OSfReuvBK6UDTGFc6kjZNeZUbtRilmqzhqR2S4Tlf4nFSaq7PDIC8ZitvkapsgmFZSjVkQPlMiHUayYnfSbxVUfY/xzsWVIrx9CMJZQ9yuEZYas+Ngm1k0BFP6Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bh4Vdb0P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bh4Vdb0P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A942C116B1;
	Wed, 15 May 2024 16:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715791383;
	bh=NsbE6lFvwQptzbfyYqBEU4ZmpAajFjYVtvOgTaP6FCU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Bh4Vdb0PGyT7gzVdVOeemr2MMgofLGXb7LtL9ai34OHSTmbrB7EZeA9CWf3IhOAd3
	 Kf4s7L2q1GYcPLYPIl8mfbMyqrfEjPxoGL1ot3jP2vOr+EyB2ZFUReOWvSWGonVJet
	 RQjWNBvE5chWCUMdaE6PJzy5RyViUjvuD8Fj+RP6+xkmLLr38GePgH0x+9F2KAtI8s
	 4K0B01nn7tBhrhg9QvV+wuXEMzr2+Ao3NlgnPT25rLwm7E/Q6R4f/WsDKwBtRRT196
	 WQ6Q2Axgp+Swp0A9GnJ3txDVkLjwu1hiFhRNtwSL9KNNUi1YZPYTjAqIDaFtqlKTBS
	 3aMqwZyaTYY1w==
Message-ID: <63507d19-aa98-4964-83b8-ba0a5d84aa2e@kernel.org>
Date: Wed, 15 May 2024 18:43:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v4 3/3] checkpatch: skip warnings for symbol
 links
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1715503185.git.tanggeliang@kylinos.cn>
 <1628d78e12809ff0f4dd0526f6addbbf00dae66b.1715503185.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <1628d78e12809ff0f4dd0526f6addbbf00dae66b.1715503185.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 12/05/2024 10:41, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> If there is a symbol link in the given patch, checkpatch.pl reports two
> inaccurate warnings:
> 
> $ cat 0001-selftests-bpf-Add-mptcp-pm_nl_ctl-link.patch
> 
>  ... ...
> 
>  '''
>  # diff --git a/tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c \
>  #            b/tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c
>  # new file mode 120000
>  # index 000000000000..5a08c255b278
>  # --- /dev/null
>  # +++ b/tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c
>  # @@ -0,0 +1 @@
>  # +../net/mptcp/pm_nl_ctl.c
>  # \ No newline at end of file
>  '''
> 
> $ ./scripts/checkpatch.pl 0001-selftests-bpf-Add-mptcp-pm_nl_ctl-link.patch
> 
>  '''
>  WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
>  #57: FILE: tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c:1:
>  +../net/mptcp/pm_nl_ctl.c
> 
>  WARNING: adding a line without newline at end of file
>  #57: FILE: tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c:1:
>  +../net/mptcp/pm_nl_ctl.c
> 
>  total: 0 errors, 2 warnings, 16 lines checked
>  '''

With 'checkpatch.pl --strict', I also had these warnings:

> CHECK: spaces preferred around that '/' (ctx:VxV)
> #63: FILE: tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c:1:
> +../net/mptcp/pm_nl_ctl.c
>    ^
> 
> CHECK: spaces preferred around that '/' (ctx:VxV)
> #63: FILE: tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c:1:
> +../net/mptcp/pm_nl_ctl.c
>        ^
> 
> CHECK: spaces preferred around that '/' (ctx:VxV)
> #63: FILE: tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c:1:
> +../net/mptcp/pm_nl_ctl.c
>              ^

I guess a similar fix could be done for this check as well :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

