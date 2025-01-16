Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A961E48A
	for <mptcp@lists.linux.dev>; Thu, 16 Jan 2025 02:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736995284; cv=none; b=KJziZP+dHaUgN4N8ywEtpskz7wKJMb/nwvweZUeHjFGZ72EM8aegrpLJM4/AdvqXb/DSsG5UQiOgZ+nCv6gzEWGDoxDJ6GdnvUUrWZZzut8RDQZn5iIg9OVLG7W3E4Nrycq4K4ESJxRI/kOPDzb+Ss3KiNwva9biAyE10DBV1fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736995284; c=relaxed/simple;
	bh=80942Y7S3nf6pNGA+4oAXHdh2v5HmHSba18G7kgrqpI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uo1Z1zleVDgXI2/UnOQRzdHllBb0rqjCE8e/0gB2DHtb8XJCvqigz2Sz4HZxpMtgmiUEnuyhd+XAO+9xbCvocz3hYu7OBuU2vYZeHz8effhbmISt0EM2Yp/rMEQsngx8FhJ6NHSgRwEqNDCUyuPcxHU9J+pJK/Ie/IOK3qzlTt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwIdWuX0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwIdWuX0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D733C4CED1;
	Thu, 16 Jan 2025 02:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736995284;
	bh=80942Y7S3nf6pNGA+4oAXHdh2v5HmHSba18G7kgrqpI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=bwIdWuX0aUKmMVz+sSwynOt3qrJ37zBuqHcG6pPwZ5LO3j0OJ/a3x1Z5Mvx9UBG/8
	 6ovymdQGadVKZGpnxte1a3icppw2eSih+nM/jnwRG9rYXVjyglaSna11ktCogMkaa6
	 x31FsWFfXGIUOzU0av9fhSwhjzqsHmfv1y2K8fLmgHDK6F2WY+0+DoRW9y1ptXKRCm
	 1hG4UKJAtUxmpPvb4PKN/qWggxdO3LiVQMkh8XB2FWWYf54zkBm9OpRwyfh91WGnZl
	 x/dZ8Qx/xoh6oSUaV59il/0O/EN/m73lxgf3S/pMwq+UJIor/LHIeLXt2iYy9QY0Qz
	 LW18YSOO6Fddw==
Message-ID: <c12ee9591c031a519dc706987fd78ae8752421f7.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 3/6] mptcp: drop inet6_sk in
 mptcp_nl_find_ssk
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Thu, 16 Jan 2025 10:41:19 +0800
In-Reply-To: <27f1c41a7a532e09596979e895af8dcbaca9313a.1736935086.git.tanggeliang@kylinos.cn>
References: <cover.1736935086.git.tanggeliang@kylinos.cn>
	 <27f1c41a7a532e09596979e895af8dcbaca9313a.1736935086.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2025-01-15 at 17:59 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> In mptcp_nl_find_ssk(), 'issk' has already been got through
> inet_sk(). No
> need to use inet6_sk() to get 'pinfo' again, just use issk->pinet6
> instead.
> This patch also drops this 'pinfo' variable.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm_userspace.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index e53426a5fc52..de17b18b78fe 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -465,9 +465,7 @@ static struct sock *mptcp_nl_find_ssk(struct
> mptcp_sock *msk,
>  			break;
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>  		case AF_INET6: {
> -			const struct ipv6_pinfo *pinfo =
> inet6_sk(ssk);
> -
> -			if (!ipv6_addr_equal(&local->addr6, &pinfo-
> >saddr) ||
> +			if (!ipv6_addr_equal(&local->addr6, &issk-
> >pinet6->saddr) ||

CI reports a warning here:

WARNING: line length of 84 exceeds 80 columns
#27: FILE: net/mptcp/pm_userspace.c:468:

Will update this in the next version.

Thanks,
-Geliang

>  			    !ipv6_addr_equal(&remote->addr6, &ssk-
> >sk_v6_daddr))
>  				continue;
>  			break;

