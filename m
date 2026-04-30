Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E20C1632DD
	for <mptcp@lists.linux.dev>; Thu, 30 Apr 2026 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777559350; cv=none; b=WPUqARi5I7OVl6Lok+Lw2doDDGIGavSivEhi6eF5vjbcu0vVkGtFi4P+Au4vWwzwYlTH4HkF2lktSXrUef6to/FsjoB5cftzyW3j5dKXMwn5wa0Uj2P3QFxZmKveW2Tg6syJNvLyy+vVNX7oQjqy0lKhql0HRGVZlz8MYRs5Phg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777559350; c=relaxed/simple;
	bh=9A4skh0AuYEKGJtIARf4b2f0pZhdauWHo28ztKa0D3g=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=DBdrTUsXN8EUTWxoZz2oALnKE5SD7/LsyxE33IxZtsC4z/HPCiyoQiA8rLf5oRQD06JSiliVmm5aQHyf3kgrfiGNb8/war52aSGV56ESl2XxDWWgySc9q2lo9HQ3uNSMeGXnN7YO/SskcOZ7ViSBTpfFo4Mjf1AzDj65zNzpdYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArBfgemz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArBfgemz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF31C2BCB9;
	Thu, 30 Apr 2026 14:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777559350;
	bh=9A4skh0AuYEKGJtIARf4b2f0pZhdauWHo28ztKa0D3g=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=ArBfgemz/GQJf80T2y49DWajNf/wyW6DcR+nwKIox6YU8G3PaTBga6PgfyMdWsarn
	 XwmYh+5gqqTyblmD77MLApVEhQsOer7vUqXMSFXlruHJnct9RFEyGtdMEqM/RV7mjK
	 ysEfgv0N3rdmj33VLlAkd1ut7sUKeNVjOe9KlquT33Igc1q66bMjiR7NS5+T+iXnr/
	 yHRWE3zVyhmTPaLmmpve5GtMdQx1cuBF+slG/SyAk2GXUe7tZuwRW4zd87j7T6jUEV
	 IPeJ+TDjGLvYuZZEtEKoGbNC2Q4zZcLd2rO2ipVAKpMgc5fLGGRL8xRLCt6W9iDF+q
	 oGfTbpL8j94kw==
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH mptcp-net] mptcp: fix rx timestamp corruption on
 fastopen
From: Matthieu Baerts <matttbe@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <eaeec8e58b36820e2c592b7a88681f3c188cb64a.1777460572.git.pabeni@redhat.com>
References: <eaeec8e58b36820e2c592b7a88681f3c188cb64a.1777460572.git.pabeni@redhat.com>
Date: Thu, 30 Apr 2026 16:29:00 +0200
Message-Id: <177755934008.1566930.11036454276948716689.b4-review@b4>
X-Mailer: b4 0.16-dev-76c3c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1780; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=9A4skh0AuYEKGJtIARf4b2f0pZhdauWHo28ztKa0D3g=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI/p5tcetvx9u9XPb+r6SUhpzWS+Z6lz6zMnM4mrpHBs
 nbD0tKojlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImIfmD4770q6wdf/27/09rt
 N2vVDd9PyPUP8A8zkwt0CJm3f2HxaYY//EvL/gsvKH57/dMeYU7B/wkZi3I7Opa3c7k4TFQ/pJH
 GAQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

On Wed, 29 Apr 2026 13:06:02 +0200, Paolo Abeni <pabeni@redhat.com> wrote:
> The skb cb offset containing the timestamp presence flag is cleared
> before loading such information. Cache such value before MPTCP CB
> initialization.

Good catch, thank you for the patch!

>
>
> diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
> index 82ec15bcfd7f..082c46c0f50e 100644
> --- a/net/mptcp/fastopen.c
> +++ b/net/mptcp/fastopen.c
> @@ -40,12 +41,13 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
>  	 */
>  	tp->copied_seq += skb->len;
>  	subflow->ssn_offset += skb->len;
> +	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
>  
>  	/* Only the sequence delta is relevant */
>  	MPTCP_SKB_CB(skb)->map_seq = -skb->len;

From sashiko:

  Does this assignment result in a zero-extension issue?

  While not introduced by this patch, since skb->len is an unsigned int,
  applying the unary - operator results in a large positive unsigned int rather
  than a negative value.

  When this is assigned to map_seq, which is a u64, it gets zero-extended
  instead of sign-extended. Downstream in mptcp_inq_hint(), the calculation:

  READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq

  could underflow if msk->ack_seq is 0, resulting in a massive 64-bit value.

  Could this trigger a fallback where ioctl(FIONREAD) falsely reports INT_MAX
  bytes available?

  If a peer sends a TCP Fast Open SYN packet with a payload, server
  applications querying FIONREAD might attempt a 2GB allocation and crash.

  Should this be explicitly cast, such as -(u64)skb->len, before negation?

It looks like it didn't get that map_seq will be += skb->len later.

-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>
