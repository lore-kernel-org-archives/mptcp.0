Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1B67082A
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 03:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758251897; cv=none; b=UCFEW4tAHsyo5NzWBCUOEGfIIUK9cFjKn3MZPEZvZiTYDdnAKtHZ6T0H4Ohpq8NvgH8d+pMuarwAHc2To6QdkoGkd73m+y0JxRJfDVD1Jk6D+rhdCi4yzEqZa+URr1Yc3tnby5w4N6t5bkFHe/COPhzPtSQnXkX+ZkI/0yIIba0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758251897; c=relaxed/simple;
	bh=yam+YOCgHsSCQZoFpL+6Z6TA5jgSsP2A82JqIidjWCk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R6hXaPrHZAokgSaU6bWIP1RUbP3IQY9Yji3StaZXmvQEglGEFtYQXZQBryG2JzfA6tvngQ81TAkvVLGY3mMHtVAMJE7Ob81P0463qGCEhUB1PKo+wyN/N8CNEntn+A4HXZLGuanPW7sjFJSfr14uCQSSukBeRhm5fiMKrQ+MQIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3/m1nWS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3/m1nWS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E83C4CEE7;
	Fri, 19 Sep 2025 03:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758251894;
	bh=yam+YOCgHsSCQZoFpL+6Z6TA5jgSsP2A82JqIidjWCk=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=S3/m1nWSObvhvLm5GCbCOCnaVXO+sGCbwpghQmtbLcJNOC/PPLL43EH1rkn4buwdy
	 x2qBmjfLqy61ykCzhO+Pt7zixJXmBRhYfalBOo45mS5u/0rBNu5fpVbaS7R+X2qqzX
	 rG7kn32/jueNiRt2/FsrREvVOnteV5bJZFlOXbxEXUv15qjAJUg1ekddLuWI60+5Nb
	 1HGeb6ITCSmJWPJTQTIJDy1IGdworZQDEL3voGIciP6lV6wUjkk5Ws4X1ZBIp1D8iT
	 2kXikBU+/z+Ysszf9stEmwhuhM07EEVK/N3pw40KEet4zxblnLJRoc2mTkpOgKQ6HL
	 GkOcORmLUKZ4Q==
Message-ID: <ac08f69806eebc9237119b45ab6b3e7a1bd059ad.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 01/10] Squash to "mptcp: pm: in-kernel:
 usable client side with C-flag"
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Fri, 19 Sep 2025 11:18:08 +0800
In-Reply-To: <20250918-pm-kern-endp-add_addr-v1-1-e12e58770a11@kernel.org>
References: <20250918-pm-kern-endp-add_addr-v1-0-e12e58770a11@kernel.org>
	 <20250918-pm-kern-endp-add_addr-v1-1-e12e58770a11@kernel.org>
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

Thanks for this patch.

On Thu, 2025-09-18 at 19:42 +0200, Matthieu Baerts (NGI0) wrote:
> The id_avail_bitmap is only used when either the 'subflow' or
> 'signal'
> flag is used, but not with 'fullmesh' only. Here, it is replacing the
> 'subflow' action, so check if this flag is set.

I recall that 'fullmesh' can only be used together with 'subflow'. If
it has already been determined earlier that the flags contain
'fullmesh', shouldn't the flags here already include 'subflow'? I'm not
entirely certain, but directly checking for 'subflow' as done in this
patch seems like a better approach.

So this patch looks good to me.

As mentioned in my previous comment, if possible, the refactoring of
the fill_local_addresses_vec_c_flag helper in patch 2 could also be
added to this squash-to patch.

Thanks,
-Geliang

> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/pm_kernel.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index
> d7cd89fa6a11a1ea7703edbfbdf2bbe86a6a3054..277f81f38134d07918143331746
> a50bc316d81ca 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -411,7 +411,8 @@ static unsigned int
> fill_local_addresses_vec(struct mptcp_sock *msk,
>  			locals[i].flags = entry->flags;
>  			locals[i].ifindex = entry->ifindex;
>  
> -			if (c_flag_case)
> +			if (c_flag_case &&
> +			    (entry->flags &
> MPTCP_PM_ADDR_FLAG_SUBFLOW))
>  				__clear_bit(locals[i].addr.id,
>  					    msk-
> >pm.id_avail_bitmap);
>  
