Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A2133F8AD
	for <mptcp@lists.linux.dev>; Thu, 23 Oct 2025 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761238569; cv=none; b=I1WtesYGl40u9RUHJekQRsEJkhaJRcUhPMwE91ZFkCt66oCb7in6bfM5yT5urjYqpFU8yB8+xoAAhVBHcBHVh9mLHPZTIr0/QBjZHwv4BVuTDsO2XKxAnoQGJoKEmIRHLsAMUrcCiuhW9rIFony4gzjYvHb7jCqDSHB2lMyM+QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761238569; c=relaxed/simple;
	bh=McZ9602myAyvHmInwoHGec8pSKnduCG57t1in3t7cRw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=B7nTrDN5tJNyNWWSgxoA6ZekR0lEFdpXTl9W3vkfQg3ETi+NBe0xJ1oYEZnjjiNwbLTfObhGJRyt9THZlyCWK4poS6zHtXq/n4ac10NMaO2F2UWo7fe1uwAkRXXdC0an5Wly/okE6iWX/LxxTKj08CoBZaHbthEcXZP094nernk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uIumfIYc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uIumfIYc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D8EC4CEE7;
	Thu, 23 Oct 2025 16:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761238568;
	bh=McZ9602myAyvHmInwoHGec8pSKnduCG57t1in3t7cRw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=uIumfIYcpc8p4pE2Sk3AKSn2g1zpSPEzgPI8OSWuGBB+K3+imr6leGYVs98JLmsU+
	 ueUVyw62n/GCkabkrwnHghm5ozXScoliV1BWlKUDePs6Mub5/WHZZjhZ/0dVvtlcP7
	 2Q6LnzK+Gu9xySRlow8gn/trR7v6Naj4tlm7ZwPXBWlEroYjhsy+ORC2BoBTXMtBTL
	 cjZhJFbxt7okpMmJvmmri8itJal9sz2808Fyuw9yH8YSaZb2m8bHgbvA2cjh9M4C40
	 Qq92qAeW9CHEtjOpxMLWP96yS2GiSbR3NTkbrM3ZMtsmWISYpQ6pBHqfvyHUzhKbp/
	 3uo1zntFCv0Zg==
Date: Thu, 23 Oct 2025 09:56:07 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Geliang Tang <geliang@kernel.org>
Subject: Re: [PATCH v6 mptcp-next 05/11] mptcp: fix MSG_PEEK stream
 corruption
In-Reply-To: <d110f41af91c7b3feb17b6b5942c21cdcec93c13.1761142784.git.pabeni@redhat.com>
Message-ID: <9a415164-74cb-3650-9299-edc82652b086@kernel.org>
References: <cover.1761142784.git.pabeni@redhat.com> <d110f41af91c7b3feb17b6b5942c21cdcec93c13.1761142784.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 22 Oct 2025, Paolo Abeni wrote:

> If a MSG_PEEK | MSG_WAITALL read operation consumes all the bytes in the
> receive queue and recvmsg() need to waits for more data - i.e. it's a
> blocking one - upon arrival of the next packet the MPTCP protocol will
> start again copying the oldest data present in the receive queue,
> corrupting the data stream.
>
> Address the issue explicitly tracking the peeked sequence number,
> restarting from the last peeked byte.
>
> Fixes: ca4fb892579f ("mptcp: add MSG_PEEK support")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> This may sound quite esoteric, but it will soon become very easy to
> reproduce with mptcp_connect, thanks to the backlog.

Would it be good to apply this to -net?

- Mat

> ---
> net/mptcp/protocol.c | 38 +++++++++++++++++++++++++-------------
> 1 file changed, 25 insertions(+), 13 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 51c55a45aeaccd..200b657080eb3e 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1947,22 +1947,36 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>
> static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied);
>
> -static int __mptcp_recvmsg_mskq(struct sock *sk,
> -				struct msghdr *msg,
> -				size_t len, int flags,
> +static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
> +				size_t len, int flags, int copied_total,
> 				struct scm_timestamping_internal *tss,
> 				int *cmsg_flags)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> 	struct sk_buff *skb, *tmp;
> +	int total_data_len = 0;
> 	int copied = 0;
>
> 	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
> -		u32 offset = MPTCP_SKB_CB(skb)->offset;
> +		u32 delta, offset = MPTCP_SKB_CB(skb)->offset;
> 		u32 data_len = skb->len - offset;
> -		u32 count = min_t(size_t, len - copied, data_len);
> +		u32 count;
> 		int err;
>
> +		if (flags & MSG_PEEK) {
> +			/* skip already peeked skbs*/
> +			if (total_data_len + data_len <= copied_total) {
> +				total_data_len += data_len;
> +				continue;
> +			}
> +
> +			/* skip the already peeked data in the current skb */
> +			delta = copied_total - total_data_len;
> +			offset += delta;
> +			data_len -= delta;
> +		}
> +
> +		count = min_t(size_t, len - copied, data_len);
> 		if (!(flags & MSG_TRUNC)) {
> 			err = skb_copy_datagram_msg(skb, offset, msg, count);
> 			if (unlikely(err < 0)) {
> @@ -1979,16 +1993,14 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
>
> 		copied += count;
>
> -		if (count < data_len) {
> -			if (!(flags & MSG_PEEK)) {
> +		if (!(flags & MSG_PEEK)) {
> +			msk->bytes_consumed += count;
> +			if (count < data_len) {
> 				MPTCP_SKB_CB(skb)->offset += count;
> 				MPTCP_SKB_CB(skb)->map_seq += count;
> -				msk->bytes_consumed += count;
> +				break;
> 			}
> -			break;
> -		}
>
> -		if (!(flags & MSG_PEEK)) {
> 			/* avoid the indirect call, we know the destructor is sock_rfree */
> 			skb->destructor = NULL;
> 			skb->sk = NULL;
> @@ -1996,7 +2008,6 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
> 			sk_mem_uncharge(sk, skb->truesize);
> 			__skb_unlink(skb, &sk->sk_receive_queue);
> 			skb_attempt_defer_free(skb);
> -			msk->bytes_consumed += count;
> 		}
>
> 		if (copied >= len)
> @@ -2194,7 +2205,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> 	while (copied < len) {
> 		int err, bytes_read;
>
> -		bytes_read = __mptcp_recvmsg_mskq(sk, msg, len - copied, flags, &tss, &cmsg_flags);
> +		bytes_read = __mptcp_recvmsg_mskq(sk, msg, len - copied, flags,
> +						  copied, &tss, &cmsg_flags);
> 		if (unlikely(bytes_read < 0)) {
> 			if (!copied)
> 				copied = bytes_read;
> -- 
> 2.51.0
>
>
>
