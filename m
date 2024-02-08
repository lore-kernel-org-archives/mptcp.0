Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D5412E61
	for <mptcp@lists.linux.dev>; Thu,  8 Feb 2024 01:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707357432; cv=none; b=I9QTjkQWTzCiz1aAi5uoAEktZUbr4AP6KTdI0Wp3k2t+fkUj6uHH724wUfg+zVvxmK09pJQMh29qFzBvMhpwkQe1eTa00pqNuWvu2mVdgIQw/NU8UVWEia18ewqkACCjQD5NCq5WVNVP4hoQ+/3b7LHg2yVyeeo5Jk7f5MTQCkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707357432; c=relaxed/simple;
	bh=oGNIM/ihzyJ/vh/ShPB8Ryy5hiEw5YrCpVP4xVbYl78=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SeiW/CaiCW/snhpr/vo+7PkRQo7ZxrlTHOUaIvZKrsAUu3zCii7qyalxiEkX7Ny2rrXp2gDvIVxlz4Ov5jqX8X7kmxdgz2O3Yef8LZtPFzP065cqN+D72azRqpgt5qOWbuqF1Rl58C0jEeJWumCDlEVlL4yKiowSjeZKs0+eq1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqutEveM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqutEveM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE99EC433F1;
	Thu,  8 Feb 2024 01:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707357431;
	bh=oGNIM/ihzyJ/vh/ShPB8Ryy5hiEw5YrCpVP4xVbYl78=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=qqutEveMVxKUvd3JHD2eqG4KyfyeTLJmr7LqxosIs4hXekrevzF8yonKuPiUwPSfU
	 nl94sbvekyWO1Xbxs4gijLn9NuxUJdbN/Q63W9AsHX42oxRhk+Qe+HsvCbQ1q7w4o1
	 /ZfNuTywuGJa4YAAcMyIFKeHaZfnMtTGoUJDzC/3hFpcM8K61lamZE5cG9rsNQVZbh
	 lq6B5jek4XQ2wj+bjRR9nFV2ul7SPgA0ZapoqG5p/PyZmljFeoNHy/OqicmVyRa2tq
	 alLyw3pOIvrDDaJ5IrxUeS+DPyeMJFfc20FC94VO2lFklRJ539XylicW1G/yga62AX
	 a2C7guGKUv7BA==
Date: Wed, 7 Feb 2024 17:57:11 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 3/7] mptcp: fix potential wake-up event loss
In-Reply-To: <27f976d6a8f1a88ed5ad3822af43d0fc648ab9f8.1705836321.git.pabeni@redhat.com>
Message-ID: <57919905-c224-b7b6-1a66-54550487973b@kernel.org>
References: <cover.1705836321.git.pabeni@redhat.com> <27f976d6a8f1a88ed5ad3822af43d0fc648ab9f8.1705836321.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 22 Jan 2024, Paolo Abeni wrote:

> After the blamed commit below, the send buffer auto-tuning can
> happen after that the mptcp_propagate_sndbuf() completes - via
> the delegated action infrastructure.
>
> We must check for write space even after such change or we risk
> missing the wake-up event.
>
> Fixes: 8005184fd1ca ("mptcp: refactor sndbuf auto-tuning")

Hi Paolo -

These first three patches have "Fixes:" tags, what do you think about 
applying them to mptcp-net instead of mptcp-next?

> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.h | 27 ++++++++++++++++++++-------
> 1 file changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index d05ec76dd7c2..bbc490f36273 100644
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

This is never called - extra code from an experiment or did some delegated 
action code not get added?

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
