Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BED1420A8
	for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 22:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708035605; cv=none; b=GmpTWwKk1eahwiD+I00cKzYb2Ndj+1cKwt34yd+xxKJKiJ4TVLpF9gwC/M8/0utHUnzakAG8uSqLVXqtFIdwD3lfG64zigf6U8oxGXnPgQjY8i1LWVV1ApXyt7SaB/wnU2WFFvP/FgNO6bV0x9g/F8ZgHzZGmEWz0qlHephIXmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708035605; c=relaxed/simple;
	bh=n/qtvCVXhbH8YxjFV6TDuSZIkG+0QwQccbzArK73GBU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DQ8wvglKlA82lQ4yIHCB1LaSv3eCHDauy3G/xVDTx9tqLN/3vGTJmatR2tbrpkdGyHBkCNMgTrJPk35Ss2LrhEke8v54iNfQPBps4nN7CeH9xHWOULzNnFR6HRqkE7WHaG6/kZHWjpqXA2uc6xvVq783lV/2Niz7CgMf3g2VChE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3LiqTT5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3LiqTT5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C2AC433C7;
	Thu, 15 Feb 2024 22:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708035604;
	bh=n/qtvCVXhbH8YxjFV6TDuSZIkG+0QwQccbzArK73GBU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=c3LiqTT5GNvPpg3AQGUlNlJ7traK0JjaD7cQM8HdvxZEfC4ckfDqEa0OyX1jiOadQ
	 ci/GPndNMaxq2jVejQIRFtTLK0zfGGoKBsXkiEwBSAaEgbsB/ICv1S/0/2NZ1CUP2k
	 xRLNvAygAcJ93k+LtbqOi8X4l6amCFOLPudYqUb0icMLXgIHNC1k3X+zFUgXMRGlki
	 +30O8+66iNu3+NU+cicWQymg+d+qcivxKCLDYkQhySLmpUr+v8BrJNQZ+M6FIXT7o+
	 /5tOT9YVstisEMrzumOFgXpi+RbhzMNrvUvqCvmMy1EMMXBFxzUvHOb/iBzM+cmelm
	 VBsJZZMBfh20A==
Date: Thu, 15 Feb 2024 14:20:03 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [mptcp-next v2 3/7] mptcp: fix potential wake-up event loss
In-Reply-To: <78924a15f3d86f989fa286f10ef88670b790eb89.1707739536.git.pabeni@redhat.com>
Message-ID: <27696500-0456-ef2d-164b-d6c7a30a459e@kernel.org>
References: <cover.1707739536.git.pabeni@redhat.com> <78924a15f3d86f989fa286f10ef88670b790eb89.1707739536.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 12 Feb 2024, Paolo Abeni wrote:

> After the blamed commit below, the send buffer auto-tuning can
> happen after that the mptcp_propagate_sndbuf() completes - via
> the delegated action infrastructure.
>
> We must check for write space even after such change or we risk
> missing the wake-up event.
>
> Fixes: 8005184fd1ca ("mptcp: refactor sndbuf auto-tuning")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.h | 27 ++++++++++++++++++++-------
> 1 file changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 486fff865803..2e197262a42e 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -797,6 +797,16 @@ static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
> 	       READ_ONCE(msk->write_seq) == READ_ONCE(msk->snd_nxt);
> }
>
> +static inline void mptcp_write_space(struct sock *sk)
> +{
> +	if (sk_stream_is_writeable(sk)) {
> +		/* pairs with memory barrier in mptcp_poll */
> +		smp_mb();
> +		if (test_and_clear_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags))
> +			sk_stream_write_space(sk);
> +	}
> +}
> +
> static inline void __mptcp_sync_sndbuf(struct sock *sk)
> {
> 	struct mptcp_subflow_context *subflow;
> @@ -815,6 +825,7 @@ static inline void __mptcp_sync_sndbuf(struct sock *sk)
>
> 	/* the msk max wmem limit is <nr_subflows> * tcp wmem[2] */
> 	WRITE_ONCE(sk->sk_sndbuf, new_sndbuf);
> +	mptcp_write_space(sk);
> }
>
> /* The called held both the msk socket and the subflow socket locks,
> @@ -845,14 +856,16 @@ static inline void mptcp_propagate_sndbuf(struct sock *sk, struct sock *ssk)
> 	local_bh_enable();
> }
>
> -static inline void mptcp_write_space(struct sock *sk)
> +static inline void __mptcp_sync_sndnxt(struct sock *sk, u64 new_snd_nxt)

Hi Paolo -

I think you missed my comment on this in v1, __mptcp_sync_sndnxt() isn't 
called anywhere.

- Mat

> {
> -	if (sk_stream_is_writeable(sk)) {
> -		/* pairs with memory barrier in mptcp_poll */
> -		smp_mb();
> -		if (test_and_clear_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags))
> -			sk_stream_write_space(sk);
> -	}
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +
> +	if (!after64(new_snd_nxt, msk->snd_nxt))
> +		return;
> +
> +	msk->bytes_sent += new_snd_nxt - msk->snd_nxt;
> +	WRITE_ONCE(msk->snd_nxt, new_snd_nxt);
> +	mptcp_write_space(sk);
> }
>
> void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags);
> -- 
> 2.43.0
>
>
>
