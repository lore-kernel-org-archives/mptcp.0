Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AFF26D4EF
	for <mptcp@lists.linux.dev>; Fri, 12 Sep 2025 23:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757720500; cv=none; b=chQ6ZF9S4eLx9vt6bIYuN8L1N1bNWC5/izMfz09+DuboFZOD1O8DxrVbGjr5r0YfsDtrw40bvkcFOO7Q5ZXeqBEHD8v5YdXOj/pRmbsSnyRxU6Vbo39vmjEqjb1Ac+nbB7Di6sOnipx9Us4Ipi6Eb5hiELM880zFB0ZOKKikP0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757720500; c=relaxed/simple;
	bh=V9BMpo8uwl1d2W68KL+6iYdTz9ptvza4fDQrwWl/tb4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=siPJQ0g0SAe4XWTD8PpPx5Y3X0CJgTdu8czTFuCw3eLChlTLrgxA7MYtlGRhdEBJRSYvWkvPxeaqhTHarpJw6mX42J+nHW0WbEhEAlzBngGH1w6weI0Gftfnf14XZ3B9awUburDUaIJEudlStkor8Yw7r6hLzH9ngUeHebE87o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZhdcMs2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZhdcMs2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45295C4CEF1;
	Fri, 12 Sep 2025 23:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757720500;
	bh=V9BMpo8uwl1d2W68KL+6iYdTz9ptvza4fDQrwWl/tb4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=NZhdcMs26vJp9NgAhWu9/Ae+MIAfi2LV+gF0MzCwbvZRroFNAlte3ZiBIvoXR0lG+
	 5MvghVOJcdrtSEBR7of1EvyNAVHo6uvqemdZjcWHYf2lVpTKrsOo1I/ut6K+q/OpEp
	 sIVgjSsrw7ZgPRMIKZhbXJ3sd+sF3q2psJ8VqBqNahJLNZgCbRNO3WnVqp/LTAB5m0
	 2h7Fm3JfCooUoQ0Ki9SY/wrHm2SXLbgHJPn/QoAtMVum7ckQnK5NnXRM3+RHFLuvPb
	 rMHxtZOtTzm5FjbjAXzPgDWgbz2w6dkSKRIVrxze28koB7y1/Z26iuXOQjHEUNU6NB
	 txpRpsj27LTDA==
Date: Fri, 12 Sep 2025 16:41:38 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v10 7/9] mptcp: implement .splice_read
In-Reply-To: <3ec04ed0947b753b7b1c5a3a201aca4cbc3ee5b1.1756780274.git.tanggeliang@kylinos.cn>
Message-ID: <c6d0dd27-a68c-8598-3c58-07965600b3b8@kernel.org>
References: <cover.1756780274.git.tanggeliang@kylinos.cn> <3ec04ed0947b753b7b1c5a3a201aca4cbc3ee5b1.1756780274.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 2 Sep 2025, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> This patch implements .splice_read interface of mptcp struct proto_ops
> as mptcp_splice_read() with reference to tcp_splice_read().
>
> Corresponding to __tcp_splice_read(), __mptcp_splice_read() is defined,
> invoking mptcp_read_sock() instead of tcp_read_sock().
>
> mptcp_splice_read() is almost the same as tcp_splice_read(), except for
> sock_rps_record_flow() and __mptcp_move_skbs().
>

Hi Geliang -

Please take a look at the recent addition of mptcp_rps_record_subflows()! 
This should be added to mptcp_splice_read.

- Mat


> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> net/mptcp/protocol.c | 94 ++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 94 insertions(+)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 6574f82d59d1..701295f6ae1b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4091,6 +4091,98 @@ static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
> 	return copied;
> }
>
> +static int __mptcp_splice_read(struct sock *sk, struct tcp_splice_state *tss)
> +{
> +	/* Store TCP splice context information in read_descriptor_t. */
> +	read_descriptor_t rd_desc = {
> +		.arg.data = tss,
> +		.count	  = tss->len,
> +	};
> +
> +	return mptcp_read_sock(sk, &rd_desc, tcp_splice_data_recv);
> +}
> +
> +/**
> + *  mptcp_splice_read - splice data from MPTCP socket to a pipe
> + * @sock:	socket to splice from
> + * @ppos:	position (not valid)
> + * @pipe:	pipe to splice to
> + * @len:	number of bytes to splice
> + * @flags:	splice modifier flags
> + *
> + * Description:
> + *    Will read pages from given socket and fill them into a pipe.
> + *
> + **/
> +static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
> +				 struct pipe_inode_info *pipe, size_t len,
> +				 unsigned int flags)
> +{
> +	struct tcp_splice_state tss = {
> +		.pipe	= pipe,
> +		.len	= len,
> +		.flags	= flags,
> +	};
> +	struct sock *sk = sock->sk;
> +	ssize_t spliced = 0;
> +	int ret = 0, err;
> +	long timeo;
> +
> +	/*
> +	 * We can't seek on a socket input
> +	 */
> +	if (unlikely(*ppos))
> +		return -ESPIPE;
> +
> +	lock_sock(sk);
> +
> +	timeo = sock_rcvtimeo(sk, sock->file->f_flags & O_NONBLOCK);
> +	while (tss.len) {
> +		ret = __mptcp_splice_read(sk, &tss);
> +		if (ret < 0) {
> +			break;
> +		} else if (!ret) {
> +			if (spliced)
> +				break;
> +			err = tcp_recv_should_stop(sk, timeo);
> +			if (err < 0) {
> +				if (err == -ESHUTDOWN) {
> +					if (__mptcp_move_skbs(sk))
> +						continue;
> +					break;
> +				}
> +				ret = err;
> +				break;
> +			}
> +			/* if __mptcp_splice_read() got nothing while we have
> +			 * an skb in receive queue, we do not want to loop.
> +			 * This might happen with URG data.
> +			 */
> +			if (!skb_queue_empty(&sk->sk_receive_queue))
> +				break;
> +			ret = sk_wait_data(sk, &timeo, NULL);
> +			if (ret < 0)
> +				break;
> +			continue;
> +		}
> +		tss.len -= ret;
> +		spliced += ret;
> +
> +		if (!tss.len)
> +			break;
> +
> +		if (tcp_recv_should_stop(sk, timeo))
> +			break;
> +	}
> +
> +	release_sock(sk);
> +
> +	if (spliced)
> +		return spliced;
> +
> +	return ret;
> +}
> +
> static const struct proto_ops mptcp_stream_ops = {
> 	.family		   = PF_INET,
> 	.owner		   = THIS_MODULE,
> @@ -4112,6 +4204,7 @@ static const struct proto_ops mptcp_stream_ops = {
> 	.mmap		   = sock_no_mmap,
> 	.set_rcvlowat	   = mptcp_set_rcvlowat,
> 	.read_sock	   = mptcp_read_sock,
> +	.splice_read	   = mptcp_splice_read,
> };
>
> static struct inet_protosw mptcp_protosw = {
> @@ -4217,6 +4310,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
> #endif
> 	.set_rcvlowat	   = mptcp_set_rcvlowat,
> 	.read_sock	   = mptcp_read_sock,
> +	.splice_read	   = mptcp_splice_read,
> };
>
> static struct proto mptcp_v6_prot;
> -- 
> 2.48.1
>
>
>
