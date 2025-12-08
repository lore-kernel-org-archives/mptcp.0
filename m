Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A1A1E32A2
	for <mptcp@lists.linux.dev>; Mon,  8 Dec 2025 02:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765160083; cv=none; b=Vuej87Wo/kS8LJV5by28R+36Jchs8NRRHnHNl2aKXYOdU5230OHFL5Y/YElUbs9S0OYj3McmKpCmkIqwELhggTny4D6Fv7M6O55tF/6BDkOpn7IoubKY/The2LGExkS5YQKfwu0w3jV1wJSHn+Pmf8v2Lv0sK1FSGNtFn8SdOY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765160083; c=relaxed/simple;
	bh=Pn7xlUlUPxS4nSPIIKKF2FlQdms++FHmDmf+Hjqt3Tg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JHXmq7JP2TAKIsLYfkEj4awuSKVCSL0ENi8hhlYWArj+9LXyuaa79F94KlqW44nmfRBNcRMiS04X7WoRlMYaoBKMUh4KYkZ8JepJFTg25HkSsDJ7dps6ge1MfAD8uCPtDitgZbwNOLMvlLQl+aGp5p6XbXKS+o+yniS9SbXp98U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1TJmukg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1TJmukg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4722C113D0;
	Mon,  8 Dec 2025 02:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765160083;
	bh=Pn7xlUlUPxS4nSPIIKKF2FlQdms++FHmDmf+Hjqt3Tg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=c1TJmukgrgmKArMPiYmuSk5NXoMe6RQI8rK+haTSmw5269XkAaOFIWmQthMEEqxoO
	 zec1rG69DtscL7ZkJdwu+oBmT9/5/VU0jxScfKuHt4cSShQUdCEf0AR4HDVBu7a9dP
	 u40HF1P0hehVjadLnvuhscB1jZNk/EcAXNz7pQPdx+5ns946duZdGmSUbevfm3zkEd
	 n/b9pGGIILO8G9rLxMMHw5Z57zbbmHRsj05wzU+g+T5Rob1/tTNngdisd5npMl0Hs8
	 LK6KcNbQcSEMmYNKRyHxFeVsjq74nPrmeTwBXgQSewwnVd3GiwOLH2xBErBoqUxZYQ
	 5zH42kg2bJ/Bg==
Message-ID: <ad1f2dee6222d945512931218dd77074a5221cfb.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v14 2/8] mptcp: implement .read_sock
From: Geliang Tang <geliang@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>, Hannes
 Reinecke <hare@kernel.org>
Date: Mon, 08 Dec 2025 10:14:38 +0800
In-Reply-To: <1b8f42fb-0527-3efb-73a7-9859e290a078@kernel.org>
References: <cover.1763974740.git.tanggeliang@kylinos.cn>
	 <0a5459b14005500ef92850ce375ee67eda063426.1763974740.git.tanggeliang@kylinos.cn>
	 <1b8f42fb-0527-3efb-73a7-9859e290a078@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Mat,

Thank you for your review.

On Fri, 2025-12-05 at 16:17 -0800, Mat Martineau wrote:
> On Mon, 24 Nov 2025, Geliang Tang wrote:
> 
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > nvme_tcp_try_recv() needs to call .read_sock interface of struct
> > proto_ops, but it's not implemented in MPTCP.
> > 
> > This patch implements it with reference to __tcp_read_sock() and
> > __mptcp_recvmsg_mskq().
> > 
> > Corresponding to tcp_recv_skb(), a new helper for MPTCP named
> > mptcp_recv_skb() is added to peek a skb from sk->sk_receive_queue.
> > 
> > Compared with __mptcp_recvmsg_mskq(), mptcp_read_sock() uses
> > sk->sk_rcvbuf as the max read length. The LISTEN status is checked
> > before the while loop, and mptcp_recv_skb() and
> > mptcp_cleanup_rbuf()
> > are invoked after the loop. In the loop, all flags checks for
> > __mptcp_recvmsg_mskq() are removed.
> > 
> > Reviewed-by: Hannes Reinecke <hare@kernel.org>
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > net/mptcp/protocol.c | 86
> > ++++++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 86 insertions(+)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index b29790a7cea8..75f90f5fc2a3 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -4296,6 +4296,90 @@ static __poll_t mptcp_poll(struct file
> > *file, struct socket *sock,
> > 	return mask;
> > }
> > 
> > +static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
> > +{
> > +	struct mptcp_sock *msk = mptcp_sk(sk);
> > +	struct sk_buff *skb;
> > +	u32 offset;
> > +
> > +	if (!list_empty(&msk->backlog_list))
> > +		mptcp_move_skbs(sk);
> > +
> > +	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
> > +		offset = MPTCP_SKB_CB(skb)->offset;
> > +		if (offset < skb->len) {
> > +			*off = offset;
> > +			return skb;
> > +		}
> > +		mptcp_eat_recv_skb(sk, skb);
> > +	}
> > +	return NULL;
> > +}
> > +
> > +/*
> > + * Note:
> > + *	- It is assumed that the socket was locked by the caller.
> > + */
> > +static int __mptcp_read_sock(struct sock *sk, read_descriptor_t
> > *desc,
> > +			     sk_read_actor_t recv_actor, bool
> > noack)
> > +{
> > +	struct mptcp_sock *msk = mptcp_sk(sk);
> > +	size_t len = sk->sk_rcvbuf;
> 
> Hi Geliang!
> 
> Why limit the maximum length here? The socket lock is held already so
> no 
> new skbs will be added to sk_receive_queue.

This is indeed a point where I'm not entirely certain. In v1 and v2
[1], I did set this len to INT_MAX, meaning there is no restriction on
the maximum length.

I revised it to INT_MAX again in v15 and also removed
tcp_recv_should_stop() helper related patches (patch 3, patch 4 in v14)
from this series as you suggested.

With these changes, everything is working fine, and all tests pass.
Please review v15 for me.

Thanks,
-Geliang

[1]
https://patchwork.kernel.org/project/mptcp/patch/32cc946892d634a14cdf4373c1b9d47126162e5a.1749286212.git.tanggeliang@kylinos.cn/

> 
> - Mat
> 
> 
> > +	struct sk_buff *skb;
> > +	int copied = 0;
> > +	u32 offset;
> > +
> > +	msk_owned_by_me(msk);
> > +
> > +	if (sk->sk_state == TCP_LISTEN)
> > +		return -ENOTCONN;
> > +	while ((skb = mptcp_recv_skb(sk, &offset)) != NULL) {
> > +		u32 data_len = skb->len - offset;
> > +		int count;
> > +		u32 size;
> > +
> > +		size = min_t(size_t, len - copied, data_len);
> > +		count = recv_actor(desc, skb, offset, size);
> > +		if (count <= 0) {
> > +			if (!copied)
> > +				copied = count;
> > +			break;
> > +		}
> > +
> > +		copied += count;
> > +
> > +		msk->bytes_consumed += count;
> > +		if (count < data_len) {
> > +			MPTCP_SKB_CB(skb)->offset += count;
> > +			MPTCP_SKB_CB(skb)->map_seq += count;
> > +			break;
> > +		}
> > +
> > +		mptcp_eat_recv_skb(sk, skb);
> > +
> > +		if (copied >= len)
> > +			break;
> > +	}
> > +
> > +	if (noack)
> > +		goto out;
> > +
> > +	mptcp_rcv_space_adjust(msk, copied);
> > +
> > +	if (copied > 0) {
> > +		mptcp_recv_skb(sk, &offset);
> > +		mptcp_cleanup_rbuf(msk, copied);
> > +	}
> > +out:
> > +	return copied;
> > +}
> > +
> > +static int mptcp_read_sock(struct sock *sk, read_descriptor_t
> > *desc,
> > +			   sk_read_actor_t recv_actor)
> > +{
> > +	return __mptcp_read_sock(sk, desc, recv_actor, false);
> > +}
> > +
> > static const struct proto_ops mptcp_stream_ops = {
> > 	.family		   = PF_INET,
> > 	.owner		   = THIS_MODULE,
> > @@ -4316,6 +4400,7 @@ static const struct proto_ops
> > mptcp_stream_ops = {
> > 	.recvmsg	   = inet_recvmsg,
> > 	.mmap		   = sock_no_mmap,
> > 	.set_rcvlowat	   = mptcp_set_rcvlowat,
> > +	.read_sock	   = mptcp_read_sock,
> > };
> > 
> > static struct inet_protosw mptcp_protosw = {
> > @@ -4420,6 +4505,7 @@ static const struct proto_ops
> > mptcp_v6_stream_ops = {
> > 	.compat_ioctl	   = inet6_compat_ioctl,
> > #endif
> > 	.set_rcvlowat	   = mptcp_set_rcvlowat,
> > +	.read_sock	   = mptcp_read_sock,
> > };
> > 
> > static struct proto mptcp_v6_prot;
> > -- 
> > 2.43.0
> > 
> > 
> > 
