Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA12934028B
	for <mptcp@lists.linux.dev>; Mon, 22 Jun 2026 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782150021; cv=none; b=Ctyq6HuXbdOJMfxnJs4yXo++cGU+h9UtsDw+6pfHYXdD/zIkiK6Ohuh+PsaVfEWEPdTqiC0ajCcDLY5N3VYO/+K1QXYbQII/kDgd8NBReFPF5PZM4XtdrJZCAEracbzkE3zQXWHm9YMghfI7o3RLhow6aboAxGxs6VBN6tjOuwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782150021; c=relaxed/simple;
	bh=qvsOUiK3zMRWZzvmPozpiQLD8wtkEGLQYbE+Mw05nbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOqqNyPY8Tf/H6STXbFHM91K2eRoMsHKwOqXv1HIW4WvoKE+q9IlU8jV643YiBSopIp/cVVl2K6vBmmqTWqxzo4UHNi0NQwACqvtJqzzB5kc20zT+KuN9fk1i0I6wzbRBjINoBsriFdOhjXZNnlaUtj9kaXFcnf7VHBPifQdiXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4UfDuGR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4UfDuGR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967921F00A3A;
	Mon, 22 Jun 2026 17:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782150020;
	bh=mUrH5NwYvB2YS1NFMAws8XmyxsjeWdo8Lgc0/isrASc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=C4UfDuGRnh/Z/fd819knCSHRH5P9jcbWhxjqAlsLN7QEKoub8OATtcjmIwxhjwlla
	 QQaOcv6R71pOLGldLeQh3VpmptyeG5zGLBe5zTgISeYP4Fvp35SDKPSKR1k0Y7OobX
	 TjzJ7/e6iDaMqhY7PTdxwyYBRj9bhtrO7zcte00txmQBjUBNH9BJ6GQzlf55OUnOt8
	 Mc3LVuCNxbWXmsieg+gLs+qSDWmpL0OQwBIyxEwAAYcwL1q6XzHkQfX12CsGi3LeeV
	 sV1dFJ9MgIv1vlGxyFELz6oeStL3zRUGaKD0nFRoIW1B6hsMErCpES/uCyWd+YAx1a
	 FV3SKWuM2X7Gg==
Message-ID: <0647e1d1-a985-442e-b1d3-416a45867be9@kernel.org>
Date: Mon, 22 Jun 2026 19:40:18 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] selftests: mptcp: fix const qualifier warnings
 in strchr usage
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <3b746802bcc4b08e9a6d2f2fb2f7622197a2d25a.1781911900.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <3b746802bcc4b08e9a6d2f2fb2f7622197a2d25a.1781911900.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 20/06/2026 01:32, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> In mptcp_connect.c, strchr() returns a pointer to a character within
> the input string, which is declared as const char *. Assigning this
> return value to a non-const char * discards the const qualifier,
> triggering compiler warnings:
> 
>  make: Entering directory 'tools/testing/selftests/net/mptcp'
>    CC       mptcp_connect
>  mptcp_connect.c: In function 'parse_cmsg_types':
>  mptcp_connect.c:1267:22: warning: initialization discards 'const'
> 	qualifier from pointer target type [-Wdiscarded-qualifiers]
>   1267 |         char *next = strchr(type, ',');
>        |                      ^~~~~~
>  mptcp_connect.c: In function 'parse_setsock_options':
>  mptcp_connect.c:1295:22: warning: initialization discards 'const'
> 	qualifier from pointer target type [-Wdiscarded-qualifiers]
>   1295 |         char *next = strchr(name, ',');
>        |                      ^~~~~~
>  make: Leaving directory 'tools/testing/selftests/net/mptcp'
> 
> Fix these warnings by declaring the 'next' variable as const char *,
> as it is only used for read-only parsing.
Thanks!

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

New patches for t/upstream:
- 7fb42c115a57: selftests: mptcp: fix const qualifier warnings in strchr
usage
- Results: 7fc976a6891c..23524644cc06 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/83be48a0589e16868a5c7e58173046507a3084d1/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

