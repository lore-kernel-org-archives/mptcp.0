Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF784AD5A
	for <mptcp@lists.linux.dev>; Wed, 19 Jun 2024 01:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718759126; cv=none; b=my1uDOl1mP3ltdNFX8Y/it1z28Xbq3xZkm4u6Gu8HWuKKXIFFg3cYYRdbnIVZmIBkwYbbhM7KMpu4Yb7rHThjrdcZSN/+fZujnc1aJYc5NPbUjLjnDbYVpetRnJ2B61fjDnkQ5srU5B9K3Y8O67Q6GjFmeAIWxtepfob4oKRoHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718759126; c=relaxed/simple;
	bh=R3ZYhZEOarggCcuAI+FsuBn0kNy2wcK/1kEGOOyJns8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qFQWDe7QDMV3HE5SbNB1eLAU303AgchsxwBPayCHcQI25IJ9PsgKJ4TjkoJKBhx2hVbA9YzJULnLq8jsH+9yzIfQEHpaUJvpUgBCnW9andthIIa5tcaXRGcsVGnmG4TSlVID3Z+t0XZ13ilp7wT7ufKSx7r3qUlsatAniERFWa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxgyB9TZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxgyB9TZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519B7C4AF1D;
	Wed, 19 Jun 2024 01:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718759126;
	bh=R3ZYhZEOarggCcuAI+FsuBn0kNy2wcK/1kEGOOyJns8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=IxgyB9TZr1fBx/o6r1wosIRm8shh1CP2fAwDJxVNd/iqRiMtGVXsZ0L12438FU2/W
	 R8ljoy3O6X3OzAvWCvcULQUMPXM61vB9KJFQVcnnmzTC24EwjrG0Iy4tIrMfChdf4l
	 ELPKo4j95bBze/lM59tEa5ZYWxo+mYh4UD1zSjNGPgIi++tn7+OKS/KTtIvFehAeSO
	 zcMEfWaua7zta7Yp4I/uyhCoy9Dps8VjkkWz4kW7bV8Y9Y1yyY0IYV/mxUI7W9C0Jw
	 YTBVnXdoezZ0p95hgUhj3ZpsTtlI/ODQ8G7Pvl12Pl0k98cpgCxnypiocRpqSRSyaL
	 UvmzI/3A2si5A==
Date: Tue, 18 Jun 2024 18:05:25 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Gregory Detal <gregory.detal@gmail.com>
cc: MPTCP Upstream <mptcp@lists.linux.dev>, 
    Matthieu Baerts <matttbe@kernel.org>
Subject: Re: [PATCH mptcp-next RFC 2/4] mptcp: use new push callback to
 schedule chunks
In-Reply-To: <20240527-sched_per_packet-v1-2-09a41d405f7c@gmail.com>
Message-ID: <38095a7e-9943-de35-b500-af174a681119@kernel.org>
References: <20240527-sched_per_packet-v1-0-09a41d405f7c@gmail.com> <20240527-sched_per_packet-v1-2-09a41d405f7c@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 27 May 2024, Gregory Detal wrote:

> This commit modifies the subflow push pending function to call for
> each data that will be sent over this subflow.
>
> Only send the amount of data defined by the scheduler. If it sets
> MPTCP_SCHED_FLAG_RESCHEDULE, the function will ignore further data to
> be sent. This will cause the get_subflow function to be called again.
>
> The previous behavior is maintained if the push function isn't defined
> by the scheduler.
>
> Signed-off-by: Gregory Detal <gregory.detal@gmail.com>
> ---
> net/mptcp/protocol.c | 14 ++++++++++----
> net/mptcp/protocol.h |  9 +++++++++
> net/mptcp/sched.c    | 20 ++++++++++++++++++++
> 3 files changed, 39 insertions(+), 4 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2f8f32cd31d3..abfd5b6748f2 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1526,12 +1526,15 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> 	struct mptcp_data_frag *dfrag;
> 	int len, copied = 0, err = 0;
> +	u16 sflags = 0;
> +
> +	while ((dfrag = mptcp_send_head(sk)) && !(sflags & MPTCP_SCHED_FLAG_RESCHEDULE)) {
> +		u16 limit = mptcp_sched_push(msk, ssk, dfrag, &sflags);
>
> -	while ((dfrag = mptcp_send_head(sk))) {
> 		info->sent = dfrag->already_sent;
> -		info->limit = dfrag->data_len;
> 		len = dfrag->data_len - dfrag->already_sent;
> -		while (len > 0) {
> +		info->limit = limit ? info->sent + min_t(u16, limit, len) : dfrag->data_len;
> +		while (len > 0 && info->sent < info->limit) {
> 			int ret = 0;
>
> 			ret = mptcp_sendmsg_frag(sk, ssk, dfrag, info);
> @@ -1546,7 +1549,10 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
>
> 			mptcp_update_post_push(msk, dfrag, ret);
> 		}
> -		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
> +
> +		/* if the whole data has been sent, move to next data segment: */
> +		if (len <= 0)
> +			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));

Hi Gregory -

It's important to be careful with possible race conditions here, since 
this changes existing assumptions about updates to msk->first_pending. I 
believe __mptcp_clean_una() (called when processing acks) will not get 
called until the msk socket lock is released so the data in msk->rtx_queue 
_should_ be available for reinjection. But we should be careful to verify 
all locking assumptions around these msk values. For example, sometimes 
the msk socket lock is held here but other times it's the mptcp_data_lock.

Also, it looks like there are some error paths that could exit this loop 
without updating msk->first_pending, which would be problematic.


- Mat


>
> 		if (msk->snd_burst <= 0 ||
> 		    !sk_stream_memory_free(ssk) ||
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 19d60b6d5b45..5e4d62bed142 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -742,6 +742,15 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
> struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
> int mptcp_sched_get_send(struct mptcp_sock *msk);
> int mptcp_sched_get_retrans(struct mptcp_sock *msk);
> +u16 __mptcp_sched_push(struct mptcp_sock *msk, struct sock *ssk,
> +		       struct mptcp_data_frag *dfrag, u16 *flags);
> +static inline u16 mptcp_sched_push(struct mptcp_sock *msk, struct sock *ssk,
> +				   struct mptcp_data_frag *dfrag, u16 *flags) {
> +	if (likely(!msk->sched || !msk->sched->push))
> +		return 0;
> +
> +	return __mptcp_sched_push(msk, ssk, dfrag, flags);
> +}
>
> static inline u64 mptcp_data_avail(const struct mptcp_sock *msk)
> {
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index 8def10abd60e..d6ff82bde641 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -193,6 +193,26 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
> 	return msk->sched->get_subflow(msk, &data);
> }
>
> +/* This is called before the data has been sent on a subflow. It returns flags
> + * that defines what the scheduler should do with the ongoing data.
> + */
> +u16 __mptcp_sched_push(struct mptcp_sock *msk, struct sock *ssk,
> +		       struct mptcp_data_frag *dfrag, u16 *flags)
> +{
> +	struct mptcp_sched_chunk chunk = {
> +		.data_seq = dfrag->data_seq + dfrag->already_sent,
> +		.limit = 0,
> +		.flags = 0,
> +	};
> +
> +	msk_owned_by_me(msk);
> +
> +	msk->sched->push(msk, mptcp_subflow_ctx(ssk), &chunk);
> +	*flags = chunk.flags;
> +
> +	return chunk.limit;
> +}
> +
> int mptcp_sched_get_retrans(struct mptcp_sock *msk)
> {
> 	struct mptcp_subflow_context *subflow;
>
> -- 
> 2.43.0
>
>
>
