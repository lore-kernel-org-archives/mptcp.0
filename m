Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DF228E2
	for <mptcp@lists.linux.dev>; Wed, 27 Mar 2024 01:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711502269; cv=none; b=gk7sFP8bsS1El2yyrFz9eNGEIXTIFPA+3eFy5+yshBIk1GDazDj5Hn3+SZJp5hjIi1xGjwmJb4PAPkMzdWZEYyt8/NnbiPTih4H6GjaolIoiAls2xStZBA4Krc8aZr0jCxXgS6386daE+LXTcbe715PO2zj4CbWJZb1oS87GPWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711502269; c=relaxed/simple;
	bh=dWlLhP0rJjsnIPddg9bW1pM/BbreWkaOBfhuNc0y1xg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gDvil8371mFLhjRuOV98uNUebLamAGCXnCUPFDbOFfFnOz/3y8RMz+s1CrWzJLFK74rkrVA6cHMbxT69bKW+fVWNtklHPoA1G84Sj1GRBPaLycyV4SYC8r4FeiO5cyNBKBrLcVXQ2BYh6yTzMPmnAn1KSUAU8XV2VLky8EO+1g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRhVtLSo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRhVtLSo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D70C433F1;
	Wed, 27 Mar 2024 01:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711502269;
	bh=dWlLhP0rJjsnIPddg9bW1pM/BbreWkaOBfhuNc0y1xg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=TRhVtLSodmN9cQT10xtPOZzd8FUEeyvRrup9lyHFY22/IcSd1gOO5y3Xz/aU0DAP1
	 YMBfPPhjtFy5vrNp6HahtMDc1tlcOFISDHB4lw6A2nLOO9FFNR0S32ytJs3aZ1scbJ
	 ARxT/3MwdBWoJknj85M2x9mLpfoWM308R2U6jowMt/Czh5ROykgH3NVTybdBHDmdmd
	 K+HDIQr4Qykhgdjd658Ck13qp9ekQyHn8cTItOhnPypx0vJBaAKCKNnPNSwKBTHjDc
	 /izU/HOehbnIhX6PGVKdAv3U1EYjCRTaAoLkrhqHXM3EMGPUbERc5Gd0lQkMN4DfDJ
	 b02Y5dpvSu4lQ==
Date: Tue, 26 Mar 2024 18:17:48 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next 1/3] mptcp: add last time fields in
 mptcp_sock
In-Reply-To: <ddf6d9178e3fa8b2646d8b7b9fb5e091ebf07833.1710748923.git.tanggeliang@kylinos.cn>
Message-ID: <87957d6b-e4cb-c171-38a8-3c88d0dd4109@kernel.org>
References: <cover.1710748923.git.tanggeliang@kylinos.cn> <ddf6d9178e3fa8b2646d8b7b9fb5e091ebf07833.1710748923.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 18 Mar 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> This patch adds "last time" fields last_data_sent, last_data_recv and
> last_ack_recv in struct mptcp_sock to record the last time data_sent,
> data_recv and ack_recv happened. They all are initialized as
> tcp_jiffies32 in __mptcp_init_sock(), but updated as tcp_jiffies32 too
> when data is sent in __subflow_push_pending(), data is received in
> mptcp_recvmsg(), and ack is received in ack_update_msk().
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> net/mptcp/options.c  | 1 +
> net/mptcp/protocol.c | 5 +++++
> net/mptcp/protocol.h | 3 +++
> 3 files changed, 9 insertions(+)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 5926955625cf..c0832df3b0a3 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1069,6 +1069,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
> 		__mptcp_snd_una_update(msk, new_snd_una);
> 		__mptcp_data_acked(sk);
> 	}
> +	msk->last_ack_recv = tcp_jiffies32;
> 	mptcp_data_unlock(sk);
>
> 	trace_ack_update_msk(mp_opt->data_ack,
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index cdf9ec67795e..a6b5c6492e9b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1556,6 +1556,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
> 	err = copied;
>
> out:
> +	msk->last_data_sent = tcp_jiffies32;

Hi Geliang -

I think msk->last_data_sent should only be updated if err > 0.

> 	return err;
> }
>
> @@ -2262,6 +2263,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> 		 skb_queue_empty(&msk->receive_queue), copied);
> 	if (!(flags & MSG_PEEK))
> 		mptcp_rcv_space_adjust(msk, copied);
> +	msk->last_data_recv = tcp_jiffies32;

This is too late in the receive process, to be comparable to TCP I think 
this timestamp should be set in __mptcp_move_skbs_from_subflow().

- Mat

>
> 	release_sock(sk);
> 	return copied;
> @@ -2793,6 +2795,9 @@ static void __mptcp_init_sock(struct sock *sk)
> 	WRITE_ONCE(msk->allow_infinite_fallback, true);
> 	msk->recovery = false;
> 	msk->subflow_id = 1;
> +	msk->last_data_sent = tcp_jiffies32;
> +	msk->last_data_recv = tcp_jiffies32;
> +	msk->last_ack_recv = tcp_jiffies32;
>
> 	mptcp_pm_data_init(msk);
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 5a4538205fd6..3a3fed3642dd 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -282,6 +282,9 @@ struct mptcp_sock {
> 	u64		bytes_acked;
> 	u64		snd_una;
> 	u64		wnd_end;
> +	u32		last_data_sent;
> +	u32		last_data_recv;
> +	u32		last_ack_recv;
> 	unsigned long	timer_ival;
> 	u32		token;
> 	int		rmem_released;
> -- 
> 2.40.1
>
>
>
