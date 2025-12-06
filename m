Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD2026E709
	for <mptcp@lists.linux.dev>; Sat,  6 Dec 2025 00:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764980269; cv=none; b=BVXM20bgZz5fpbvmYwbR0xavgwnSreVvXMsQo2HoVxwo3jiiH3Ujez9Ct/oSU2QgvBTfBxXDbzlvVbx3MM5F4+5/ZJUf2yCJ1JaiaNKo2QZN9dvvUzBXmU1nvnUKUUg7gY8OalSPQPbkCzaLqKgcZAXJeM1hdcMiqmvu4bgJ/EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764980269; c=relaxed/simple;
	bh=NgK5jXSia+XlYKCMZy/1ZZsslzeHLCmjfXDNw7sI6is=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=edW+dJic/hXzr+lRO47eRjzYL2FXoVPMNtJrXfVb6dWeC4dtt7MCRoX59s69q7bceWbXT0Znrpavg6g6Al5BaLne3PdhYkhHNaACParnb2jVxPxlqgo3kwEsWhG2NFHGhlCrFxxQo10ynWQ07l+bLgtyYOGgun2pnutYYwf95tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNgv6SJC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNgv6SJC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48570C2BD05;
	Sat,  6 Dec 2025 00:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764980267;
	bh=NgK5jXSia+XlYKCMZy/1ZZsslzeHLCmjfXDNw7sI6is=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=oNgv6SJC6Sz7IGW1EdOycFfuw9zDJllwXE2RLvHnn0qDEhqtsUa0kQL+IJ03HlwPl
	 W5RaPBXizwRU3nvetFeS6kqrVNT1oalG6AktaudW7OI+fueKPHsDffEUyq+xXGR2qk
	 B+QikJC0B/yDj/p2sa7MIy3PMk4X6kBuGM1cM3S6lEhkla7VR7nwKcljvazwkTjG/f
	 gQJvLvTybT20hDjFNthHq/JK7jcC4l6qJICg5dk6rRPm382st6LM4EXYMOrM+I7+j5
	 yYuR0P/btcrBrlJ/zLG/U84lm/3lAPQV2ETMZLnobnoaCtTnfLoEhDoHzyn8JKQYYO
	 B+R5KXlN0P2oQ==
Date: Fri, 5 Dec 2025 16:17:46 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>, 
    Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH mptcp-next v14 2/8] mptcp: implement .read_sock
In-Reply-To: <0a5459b14005500ef92850ce375ee67eda063426.1763974740.git.tanggeliang@kylinos.cn>
Message-ID: <1b8f42fb-0527-3efb-73a7-9859e290a078@kernel.org>
References: <cover.1763974740.git.tanggeliang@kylinos.cn> <0a5459b14005500ef92850ce375ee67eda063426.1763974740.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 24 Nov 2025, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> nvme_tcp_try_recv() needs to call .read_sock interface of struct
> proto_ops, but it's not implemented in MPTCP.
>
> This patch implements it with reference to __tcp_read_sock() and
> __mptcp_recvmsg_mskq().
>
> Corresponding to tcp_recv_skb(), a new helper for MPTCP named
> mptcp_recv_skb() is added to peek a skb from sk->sk_receive_queue.
>
> Compared with __mptcp_recvmsg_mskq(), mptcp_read_sock() uses
> sk->sk_rcvbuf as the max read length. The LISTEN status is checked
> before the while loop, and mptcp_recv_skb() and mptcp_cleanup_rbuf()
> are invoked after the loop. In the loop, all flags checks for
> __mptcp_recvmsg_mskq() are removed.
>
> Reviewed-by: Hannes Reinecke <hare@kernel.org>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> net/mptcp/protocol.c | 86 ++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 86 insertions(+)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index b29790a7cea8..75f90f5fc2a3 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4296,6 +4296,90 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
> 	return mask;
> }
>
> +static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct sk_buff *skb;
> +	u32 offset;
> +
> +	if (!list_empty(&msk->backlog_list))
> +		mptcp_move_skbs(sk);
> +
> +	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
> +		offset = MPTCP_SKB_CB(skb)->offset;
> +		if (offset < skb->len) {
> +			*off = offset;
> +			return skb;
> +		}
> +		mptcp_eat_recv_skb(sk, skb);
> +	}
> +	return NULL;
> +}
> +
> +/*
> + * Note:
> + *	- It is assumed that the socket was locked by the caller.
> + */
> +static int __mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
> +			     sk_read_actor_t recv_actor, bool noack)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	size_t len = sk->sk_rcvbuf;

Hi Geliang!

Why limit the maximum length here? The socket lock is held already so no 
new skbs will be added to sk_receive_queue.

- Mat


> +	struct sk_buff *skb;
> +	int copied = 0;
> +	u32 offset;
> +
> +	msk_owned_by_me(msk);
> +
> +	if (sk->sk_state == TCP_LISTEN)
> +		return -ENOTCONN;
> +	while ((skb = mptcp_recv_skb(sk, &offset)) != NULL) {
> +		u32 data_len = skb->len - offset;
> +		int count;
> +		u32 size;
> +
> +		size = min_t(size_t, len - copied, data_len);
> +		count = recv_actor(desc, skb, offset, size);
> +		if (count <= 0) {
> +			if (!copied)
> +				copied = count;
> +			break;
> +		}
> +
> +		copied += count;
> +
> +		msk->bytes_consumed += count;
> +		if (count < data_len) {
> +			MPTCP_SKB_CB(skb)->offset += count;
> +			MPTCP_SKB_CB(skb)->map_seq += count;
> +			break;
> +		}
> +
> +		mptcp_eat_recv_skb(sk, skb);
> +
> +		if (copied >= len)
> +			break;
> +	}
> +
> +	if (noack)
> +		goto out;
> +
> +	mptcp_rcv_space_adjust(msk, copied);
> +
> +	if (copied > 0) {
> +		mptcp_recv_skb(sk, &offset);
> +		mptcp_cleanup_rbuf(msk, copied);
> +	}
> +out:
> +	return copied;
> +}
> +
> +static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
> +			   sk_read_actor_t recv_actor)
> +{
> +	return __mptcp_read_sock(sk, desc, recv_actor, false);
> +}
> +
> static const struct proto_ops mptcp_stream_ops = {
> 	.family		   = PF_INET,
> 	.owner		   = THIS_MODULE,
> @@ -4316,6 +4400,7 @@ static const struct proto_ops mptcp_stream_ops = {
> 	.recvmsg	   = inet_recvmsg,
> 	.mmap		   = sock_no_mmap,
> 	.set_rcvlowat	   = mptcp_set_rcvlowat,
> +	.read_sock	   = mptcp_read_sock,
> };
>
> static struct inet_protosw mptcp_protosw = {
> @@ -4420,6 +4505,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
> 	.compat_ioctl	   = inet6_compat_ioctl,
> #endif
> 	.set_rcvlowat	   = mptcp_set_rcvlowat,
> +	.read_sock	   = mptcp_read_sock,
> };
>
> static struct proto mptcp_v6_prot;
> -- 
> 2.43.0
>
>
>
