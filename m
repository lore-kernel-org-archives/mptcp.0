Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27EF31A80E
	for <mptcp@lists.linux.dev>; Sat,  6 Dec 2025 00:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764980521; cv=none; b=GlHcwCW83vMyb0kGEJsJFKQirgHmuHW7Pjnik/bBUT46J2l6/RNgsug0IaixB7JfCXX1EvADw/2BhLDYBgopW6GOvaZQjpC0Sy+gSVvZ3ZhH7hJoaj6xSo+o9LhF0nRqAE9ivKCrwu49p7rILPQBhLUX0T42iwnLkO63RXz7q0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764980521; c=relaxed/simple;
	bh=kKzZ7Rp9SGQ/8qVldDp0KMkdPSUAFMRFC47uaYVBRhY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rOLTUbXtxcTSaX4U5fiV3WiiF1fUk7kbK/R/I48IZyr+NAzMs0z+fPqzaTqJBTE3rOiBtfYGa0VlvHizBA/gHZkNSAAUjHIzmBcvljxxAJpiZRz534aynbgufhbeEkklAedZ9Fu7IOpgWtnqj0XyNUBk1MgCQCoysetk28Uv6eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/dXohQF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/dXohQF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BC7C4CEF1;
	Sat,  6 Dec 2025 00:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764980521;
	bh=kKzZ7Rp9SGQ/8qVldDp0KMkdPSUAFMRFC47uaYVBRhY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=R/dXohQFlAzAivvi7UPheo4u1Wp4LRB0E4QFO0R1aNA25q5ZXyghXlieUajgsnbuV
	 v5CEuPwUjvmBMEydPS3ojvvb2mzpXuZLMFzL/ug+glb8TJiEXM7Fb8EC+sGX44SZsF
	 quHMvVHydTrO7I7vPapSgf78QWFPTDohxcD6ZiJdwmg4orNVZQrXL5zC28fSXj7v8b
	 SrX4wwFpyYfPuIoFCjWP0kt3wy+kurdxvDozrqV9TOZ3/dToNjjMeC6oyGY2F34Ygq
	 XiNUcUgFoCcEZD0Oa8pS5vuqCQZtAGj05KyQVwz/+cv7q6inUXq/GjsrMKBNMJTc8G
	 c0Qiziw0ldVcA==
Date: Fri, 5 Dec 2025 16:22:01 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v14 6/8] mptcp: implement .splice_read
In-Reply-To: <cff194b2736d851c1ad28e2d6e38eb7e890de2a4.1763974740.git.tanggeliang@kylinos.cn>
Message-ID: <088efdb2-4f2b-3c37-ce09-19a855f4f08f@kernel.org>
References: <cover.1763974740.git.tanggeliang@kylinos.cn> <cff194b2736d851c1ad28e2d6e38eb7e890de2a4.1763974740.git.tanggeliang@kylinos.cn>
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
> This patch implements .splice_read interface of mptcp struct proto_ops
> as mptcp_splice_read() with reference to tcp_splice_read().
>
> Corresponding to __tcp_splice_read(), __mptcp_splice_read() is defined,
> invoking mptcp_read_sock() instead of tcp_read_sock().
>
> mptcp_splice_read() is almost the same as tcp_splice_read(), except for
> sock_rps_record_flow().
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> net/mptcp/protocol.c | 96 ++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 96 insertions(+)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 9302b372910e..abd0f44ad63f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4355,6 +4355,100 @@ static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
> 	return __mptcp_read_sock(sk, desc, recv_actor, false);
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
> +	int ret = 0;
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
> +	mptcp_rps_record_subflows(mptcp_sk(sk));
> +
> +	timeo = sock_rcvtimeo(sk, sock->file->f_flags & O_NONBLOCK);
> +	while (tss.len) {
> +		ret = __mptcp_splice_read(sk, &tss);
> +		if (ret < 0) {
> +			break;
> +		} else if (!ret) {
> +			int err;
> +
> +			if (spliced)
> +				break;
> +			err = tcp_recv_should_stop(sk, timeo);
> +			if (err < 0) {
> +				if (err != -ESHUTDOWN)
> +					ret = err;
> +				break;
> +			}
> +			/* if __mptcp_splice_read() got nothing while we have
> +			 * an skb in receive queue, we do not want to loop.
> +			 * This might happen with URG data.
> +			 */
> +			if (!skb_queue_empty(&sk->sk_receive_queue))
> +				break;

Hi Geliang -

This queue could also be non-empty due to the length limit in patch 2. 
Maybe another reason to remove that length limit.


- Mat


> +			ret = sk_wait_data(sk, &timeo, NULL);
> +			if (ret < 0)
> +				break;
> +			continue;
> +		}
> +		tss.len -= ret;
> +		spliced += ret;
> +
> +		if (!tss.len || !timeo)
> +			break;
> +		release_sock(sk);
> +		lock_sock(sk);
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
> @@ -4376,6 +4470,7 @@ static const struct proto_ops mptcp_stream_ops = {
> 	.mmap		   = sock_no_mmap,
> 	.set_rcvlowat	   = mptcp_set_rcvlowat,
> 	.read_sock	   = mptcp_read_sock,
> +	.splice_read	   = mptcp_splice_read,
> };
>
> static struct inet_protosw mptcp_protosw = {
> @@ -4481,6 +4576,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
> #endif
> 	.set_rcvlowat	   = mptcp_set_rcvlowat,
> 	.read_sock	   = mptcp_read_sock,
> +	.splice_read	   = mptcp_splice_read,
> };
>
> static struct proto mptcp_v6_prot;
> -- 
> 2.43.0
>
>
>
