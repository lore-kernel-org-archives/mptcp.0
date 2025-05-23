Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF700145B27
	for <mptcp@lists.linux.dev>; Fri, 23 May 2025 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748012653; cv=none; b=InoT336ib65shhL3bn5juJNNHI4bhjT+DOlTOaRvdsC7M+vWLRFlbGkObEWUYJRZQpMYEKrj1fPc6YOToq8qznmuVpvbKuhGVvpHorjqqjV+gHkduQpL7mSjG1Q3BtXn4vFj1GbJhYq3RDRrdJy64d2WF1/BbJUi/dQVcieYbqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748012653; c=relaxed/simple;
	bh=esPW36YWIeTH1wWIfWVYq2V7kHxLm1ChZ2xJLDUyp+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=og5+1WE6vzcO4MvRv4mFoxHOhaahTX1gxseP5J6CZiflgnZ0WyL8s05JR4y0gFT3fqHtAgwqCseJnXtThmQUvpf5K2tATX5cjLC+vR1lbSaX0cYDYqnQrxLjFfngMWvt66/vxpl306605I/iw+3TLl8JVQnijJ6H5SAizii1gmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwiWwHkR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwiWwHkR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F50EC4CEE9;
	Fri, 23 May 2025 15:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748012653;
	bh=esPW36YWIeTH1wWIfWVYq2V7kHxLm1ChZ2xJLDUyp+g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AwiWwHkRVR6M5Uh2ocudQfBBcPtNZkf8IlBxobziGe9KZf+/huXwwTBxWwJ3Zp98C
	 BmHoRvRrYC44slIOYic5rJWO4RGTA516Qgkg2HJdq3FAtaOo9dWtazLUHtVVq0ejx6
	 hB0HsxuJ2MP9itZHI9eRsFbGum44lmgMrzK/P4FAN1NyT5l0AUqUNhvrQ+Q4yL70/V
	 UDUnxUyycqhG/Bzr8DMbG4RBkDGjc8G27tnNQ8vvhbGn2HpDLiYU/mxO/I3ooP2Av8
	 piUuMRjsWCjRPE7iTODHsGVjYdOKovm+EcaQ/19qZg41a0RRJi3FLfuB4LLWls0cIq
	 TiJ09RE+DdaPA==
Message-ID: <f63aaa87-7294-431f-a372-706456cb7730@kernel.org>
Date: Fri, 23 May 2025 17:04:09 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 2/2] mptcp: implement .read_sock
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: hare@kernel.org, Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1747904572.git.tanggeliang@kylinos.cn>
 <1f7ebd44d183d92aa891d99b2192bd812eeaeb00.1747904572.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <1f7ebd44d183d92aa891d99b2192bd812eeaeb00.1747904572.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 22/05/2025 11:21, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> nvme_tcp_try_recv() needs to call .read_sock interface of struct
> proto_ops, but it is not implemented in MPTCP.

Thank you for looking at that!

> This patch implements it with reference to __mptcp_recvmsg_mskq().

Can you share more details about the implementation please?

I didn't check in details what this .read_sock interface is supposed to
do, but it might be good to add some explanations about that, mentioning
the differences with __mptcp_recvmsg_mskq() and why they are there, why
you cannot share code (which is certainly fine, but better with a few
words about that) etc. Plus also the differences with __tcp_read_sock()
I suppose.

Without that, I'm sorry, but it is difficult to review the code, at
least for me who doesn't know much about this interface, what it is
supposed to do nor how it is used :)

Also, would it be possible to add a new MPTCP specific selftest?

> 
> Reviewed-by: Hannes Reinecke <hare@kernel.org>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/protocol.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index a9094cd8bcd0..e5c69b13dbf7 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3956,6 +3956,58 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
>  	return mask;
>  }
>  

If it is inspired by something else, please add a comment about that
here so if something change there, we might think about changing things
here as well.

> +static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
> +			   sk_read_actor_t recv_actor)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct scm_timestamping_internal tss;
> +	struct sk_buff *skb, *tmp;
> +	size_t len = INT_MAX;
> +	int copied = 0;
> +
> +	skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
> +		u32 offset = MPTCP_SKB_CB(skb)->offset;
> +		u32 data_len = skb->len - offset;
> +		u32 count = min_t(size_t, len - copied, data_len);
> +		int used;
> +
> +		used = recv_actor(desc, skb, offset, count);

(to avoid confusions with __mptcp_recvmsg_mskq(), maybe clearer to use
'count' instead of 'used' here? I mean: below, 'used' is used here,
while 'count' is used in __mptcp_recvmsg_mskq(), that's a bit confusing)

> +		if (used <= 0) {
> +			if (!copied)
> +				copied = used;
> +			break;
> +		}
> +
> +		if (MPTCP_SKB_CB(skb)->has_rxtstamp)
> +			tcp_update_recv_tstamps(skb, &tss);
> +
> +		copied += used;
> +
> +		if (used < data_len) {
> +			MPTCP_SKB_CB(skb)->offset += used;
> +			MPTCP_SKB_CB(skb)->map_seq += used;
> +			msk->bytes_consumed += used;
> +			break;
> +		}
> +
> +		skb->destructor = NULL;

That looks strange, please keep the comment that was there before

> +		atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
> +		sk_mem_uncharge(sk, skb->truesize);
> +		sk_eat_skb(sk, skb);
> +		msk->bytes_consumed += used;
> +
> +		if (copied >= len)
> +			break;
> +	}
> +
> +	mptcp_rcv_space_adjust(msk, copied);
> +
> +	if (copied > 0)
> +		mptcp_cleanup_rbuf(msk, copied);
> +
> +	return copied;

On TCP side, they first check the sk_state, and they also look for the
end of the end of a connection. Is it not needed here?

> +}
> +
>  static const struct proto_ops mptcp_stream_ops = {
>  	.family		   = PF_INET,
>  	.owner		   = THIS_MODULE,
> @@ -3976,6 +4028,7 @@ static const struct proto_ops mptcp_stream_ops = {
>  	.recvmsg	   = inet_recvmsg,
>  	.mmap		   = sock_no_mmap,
>  	.set_rcvlowat	   = mptcp_set_rcvlowat,
> +	.read_sock	   = mptcp_read_sock,
>  };
>  
>  static struct inet_protosw mptcp_protosw = {
> @@ -4080,6 +4133,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
>  	.compat_ioctl	   = inet6_compat_ioctl,
>  #endif
>  	.set_rcvlowat	   = mptcp_set_rcvlowat,
> +	.read_sock	   = mptcp_read_sock,
>  };
>  
>  static struct proto mptcp_v6_prot;

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

