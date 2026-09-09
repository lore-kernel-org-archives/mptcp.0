Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE2056E054
	for <mptcp@lists.linux.dev>; Wed,  9 Sep 2026 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969084; cv=none; b=JiFI1MoPzUaQHNV++IInFbGe5zK6Wf4jH6zmwdWTXvZgpFQ0KlW6KOBhL/eAOAZYBFO75FfGee6dAPlqjzUB+9aTyxkf4VsRj/sxD3Sni6NqZXs0IHlc65XkIFNWcd4Vx6my8+aczfjFpAaa/J67Kd5+Hx+ITIYQHYhZkIoDG0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969084; c=relaxed/simple;
	bh=OdOjTaDB+KlQ1aFDCMQQgqa+0Zi0nEzd9uyXFUWuudU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FzQdDxTYUJQibedFzAUYwHede8kFSGyJH3JYFZeQ2UVHkrSq8XJNU5gM1eL9HXPKov3O0a6Ks8NODuqN82EN/Xl2x2UZUM7wiqNlQpP7wMfGze9lB3bTPKR34DKZxdt5THJ1DTY+u/rF6cKSxCsW4pue25hIPSpRLdv+LAQ6+qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgEfS6hv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgEfS6hv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6D11F00A3A;
	Wed,  9 Sep 2026 15:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969083;
	bh=nRSE2yfvWYodoWr/Zn8kOEL/HhevrNtbwejypCMSkbA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=PgEfS6hvC3dke4sS2VFiY/tGE+VAby4aFnkZ65V8ZWOM+yOubaLIl4gZUKKkJgIi0
	 tKLAmWKoPSVqdf7ZbmLCvWBxx4Bfxvui3ha6MNPCMOHBdYfOIQbSWxD1Vw9R7EGdDF
	 DJLxLOZrKHbToq1AHcrmhkymE1i4uc+aBjiCJb9j1Qz/crfAfV/2HWfJmS/aso0KxQ
	 u4/GzXyz/6S7oAahFeP2qdMyaQ1weVyoHIFcJsgreSUQG52HeCppH2B/kdzOH/KwV8
	 or4ugDKPJYxBvz87LI0ZGmy7SmZpsxKf0tu/LTOwa+kLcGekcN0CzUAtVnTZZFuN0o
	 VWvlAB/85HqLg==
Date: Wed, 9 Sep 2026 08:51:22 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net 0/2] mptcp: options: avoid printing uninit
 data
In-Reply-To: <20260908-mptcp-opt-read-debug-v1-0-b3e74549b6f6@kernel.org>
Message-ID: <d4f8a020-8cce-d760-4625-adafb26d9ede@kernel.org>
References: <20260908-mptcp-opt-read-debug-v1-0-b3e74549b6f6@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 8 Sep 2026, Matthieu Baerts (NGI0) wrote:

> When parsing the MPTCP suboptions, some pr_debug() might read and print
> uninit values.
>
> That's mostly harmless, but that's also confusing. Fixing that also
> avoids some tools to complain about accessing unint data.
>
> So read these fields only if they have been set.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Matthieu Baerts (NGI0) (2):
>      mptcp: options: mpc: avoid printing uninit data
>      mptcp: options: dss: avoid printing uninit csum
>
> net/mptcp/options.c | 9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)
> ---
> base-commit: a59eb98e30b7db5fa1cc7cd5343ad387bced3ae0
> change-id: 20260908-mptcp-opt-read-debug-d818ab97c05e

Thanks Matthieu, series LGTM:

Reviewed-by: Mat Martineau <martineau@kernel.org>

