Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C03D1E130F
	for <mptcp@lists.linux.dev>; Sun,  3 Aug 2025 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754230088; cv=none; b=V26A+8p0/m4wEHWbFSvniCRqveebUgP3pMsTRBCSkNIL5AyaMF4w9U57zzhYAX8P4ybmfx19ARofVwDy0V7Cfwdrb/OXi5Ny46EW8W4yh1kmWOncxSHo7QYPsMbNobcxjAZilHS40ZXVmpZfvQHhsXRezATRR8vcW/n+Yr6YtdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754230088; c=relaxed/simple;
	bh=ye+TQwwgKo6PKjXqeQhMfy7GC7bU3uzTkPL6lc8BxMs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NvbxXwtbeDmZ27C5aIKluZhceyyn+1fBptIMAMF6WufhSVpgLP1dijPjoOxkw1lGYARRUnnH9Alqa2YEzdxRNxjCT9IPelrOs16JcSmGFtrRTKNnS23exR3OCNM2wluhOpnDtAYEFVcPYkd/qFM2LmZqlwRVmAHvO2Kn0bUnQPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MURs+uLO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MURs+uLO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8748C4CEEB;
	Sun,  3 Aug 2025 14:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754230087;
	bh=ye+TQwwgKo6PKjXqeQhMfy7GC7bU3uzTkPL6lc8BxMs=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=MURs+uLOqjQYsS9y7tXNu+FIOV+joL7EuFMLBBgteeIPSNgt7OPlWUUi7HIZOLsbM
	 VCoK+i5/hX+46/bVadY7us/z7tDSqd5mgmEQhZu3SjdrXDaYFNn5YMW0rRko+8Sy4V
	 AM5igdg/yAk9vbFSMPgnAp+ltg+yd+pxjLujn0UBWMYqHWYgxXP1yxeRGJieATdM1G
	 ge0wvr69QcddR2gOFpG4lnbikyM5F83IB6uF9VS6awP6ircBNb5V5jdR3VasyWQlOu
	 wSMn6ftUflozAeSUaZYk9AVzBBKqqBPCLdt5STQldlzvUxxRVrGsqZNUFTd6e1+QbD
	 Si5SBbsucVmBg==
Message-ID: <7bc26a32ca9ce941ddc0040be77dab18c8b55256.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 0/2] selftests: mptcp: connect: fix C23
 extension warning
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Sun, 03 Aug 2025 22:08:04 +0800
In-Reply-To: <20250803-sft-mptcp-warn-gcc-v1-0-6d87808721ea@kernel.org>
References: <20250803-sft-mptcp-warn-gcc-v1-0-6d87808721ea@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Sun, 2025-08-03 at 14:13 +0200, Matthieu Baerts (NGI0) wrote:
> GCC was complaining about the new label:
> 
>   mptcp_connect.c:187:2: warning: label followed by a declaration is
> a C23 extension [-Wc23-extensions]
>     187 |         int err = getaddrinfo(node, service, hints, res);
>         |         ^
> 
>   mptcp_inq.c:79:2: warning: label followed by a declaration is a C23
> extension [-Wc23-extensions]
>      79 |         int err = getaddrinfo(node, service, hints, res);
>         |         ^
> 
>   mptcp_sockopt.c:166:2: warning: label followed by a declaration is
> a C23 extension [-Wc23-extensions]
>     166 |         int err = getaddrinfo(node, service, hints, res);
>         |         ^
> 
> Simply declare 'err' before the label to avoid this warning.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

LGTM!

Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
> Matthieu Baerts (NGI0) (2):
>       selftests: mptcp: connect: fix C23 extension warning
>       selftests: mptcp: sockopt: fix C23 extension warning
> 
>  tools/testing/selftests/net/mptcp/mptcp_connect.c | 5 +++--
>  tools/testing/selftests/net/mptcp/mptcp_inq.c     | 5 +++--
>  tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 5 +++--
>  3 files changed, 9 insertions(+), 6 deletions(-)
> ---
> base-commit: 5c7ec796258e1599e2033ae0f40434b2ba6ca21c
> change-id: 20250803-sft-mptcp-warn-gcc-4808047d562e
> 
> Best regards,
