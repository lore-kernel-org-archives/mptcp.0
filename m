Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD951946DF
	for <mptcp@lists.linux.dev>; Sat, 13 Sep 2025 00:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757724861; cv=none; b=HlvaoqjL+XTNo5PwucBCGa0Dm/ogyWfjrQtTwirsy71TIeO4tcsxgPsO1Uc7qDJDrbgCHyvSB+3fg1YXSO/4wh6Zdta16y5PQjc9BJwNfj2f2Q17fIOH4DjzfueHQnEu84JX6tIH3LgP/O9koHF06huWrjVHYeTn7voB0N2jYKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757724861; c=relaxed/simple;
	bh=K1g/EMmUiYq/vK9L+wrU7Q4pJ27BNThcfZcWKJL/89I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WpyEXkKQU9synpzm2XoZrKagsUvdVrfbLdbMd9YvTphnxF7h5SeIgQibtgHx0jxLT9Pokv+IrlYNIokf/jp3f95WAJwymfrWT9Q5QEF7mwYkmmrgRGn5euNtgu6bQ8NjgJ+gnuCKLfM6Y33swmkbNBA7CqyabckU6skT7h2bP0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHQEP+88; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHQEP+88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87A2C4CEF5;
	Sat, 13 Sep 2025 00:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757724860;
	bh=K1g/EMmUiYq/vK9L+wrU7Q4pJ27BNThcfZcWKJL/89I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XHQEP+888GuD24P7yq26PKm+ICRv85c2Vr6QW9K49kk2rC5wMkaSixd4FKnUiPFNN
	 lZn8s+kDOxUaEd9E4MLoCyScZQ/IVE4agnuzE5DqBIq2AZXUG8ou3IjxIE3X1AtB10
	 NI8XUXO9NAAsNIqs7SuMtUXVzp+A1qOEEByCE94qab8LxUM1P9YDaL2yK0nI0NqJBZ
	 sErjWMOta9iuLLwx/Ay41QnQ4FgWdJYCagMWgTDnFTfsDns1wsyVCxz39mKJUEXqbh
	 ltLvrA7dw5E3dknS/AnHSFh4/4/coYHFjb/WRpweR10biuIrLwKlt5Hb3GFQKtas5l
	 LOdqU8KkkBg7Q==
Message-ID: <5dbda348747d3bfde801852fe6a392385d8e0643.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v10 7/9] mptcp: implement .splice_read
From: Geliang Tang <geliang@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Date: Sat, 13 Sep 2025 08:54:18 +0800
In-Reply-To: <c6d0dd27-a68c-8598-3c58-07965600b3b8@kernel.org>
References: <cover.1756780274.git.tanggeliang@kylinos.cn>
	 <3ec04ed0947b753b7b1c5a3a201aca4cbc3ee5b1.1756780274.git.tanggeliang@kylinos.cn>
	 <c6d0dd27-a68c-8598-3c58-07965600b3b8@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2025-09-12 at 16:41 -0700, Mat Martineau wrote:
> On Tue, 2 Sep 2025, Geliang Tang wrote:
> 
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > This patch implements .splice_read interface of mptcp struct
> > proto_ops
> > as mptcp_splice_read() with reference to tcp_splice_read().
> > 
> > Corresponding to __tcp_splice_read(), __mptcp_splice_read() is
> > defined,
> > invoking mptcp_read_sock() instead of tcp_read_sock().
> > 
> > mptcp_splice_read() is almost the same as tcp_splice_read(), except
> > for
> > sock_rps_record_flow() and __mptcp_move_skbs().
> > 
> 
> Hi Geliang -
> 
> Please take a look at the recent addition of
> mptcp_rps_record_subflows()! 
> This should be added to mptcp_splice_read.

Yes, indeed. It was included in v11.

Thanks,
-Geliang

> 
> - Mat
> 
> 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > net/mptcp/protocol.c | 94
> > ++++++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 94 insertions(+)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 6574f82d59d1..701295f6ae1b 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -4091,6 +4091,98 @@ static int mptcp_read_sock(struct sock *sk,
> > read_descriptor_t *desc,
> > 	return copied;
> > }
> > 
> > +static int __mptcp_splice_read(struct sock *sk, struct
> > tcp_splice_state *tss)
> > +{
> > +	/* Store TCP splice context information in
> > read_descriptor_t. */
> > +	read_descriptor_t rd_desc = {
> > +		.arg.data = tss,
> > +		.count	  = tss->len,
> > +	};
> > +
> > +	return mptcp_read_sock(sk, &rd_desc,
> > tcp_splice_data_recv);
> > +}
> > +
> > +/**
> > + *  mptcp_splice_read - splice data from MPTCP socket to a pipe
> > + * @sock:	socket to splice from
> > + * @ppos:	position (not valid)
> > + * @pipe:	pipe to splice to
> > + * @len:	number of bytes to splice
> > + * @flags:	splice modifier flags
> > + *
> > + * Description:
> > + *    Will read pages from given socket and fill them into a pipe.
> > + *
> > + **/
> > +static ssize_t mptcp_splice_read(struct socket *sock, loff_t
> > *ppos,
> > +				 struct pipe_inode_info *pipe,
> > size_t len,
> > +				 unsigned int flags)
> > +{
> > +	struct tcp_splice_state tss = {
> > +		.pipe	= pipe,
> > +		.len	= len,
> > +		.flags	= flags,
> > +	};
> > +	struct sock *sk = sock->sk;
> > +	ssize_t spliced = 0;
> > +	int ret = 0, err;
> > +	long timeo;
> > +
> > +	/*
> > +	 * We can't seek on a socket input
> > +	 */
> > +	if (unlikely(*ppos))
> > +		return -ESPIPE;
> > +
> > +	lock_sock(sk);
> > +
> > +	timeo = sock_rcvtimeo(sk, sock->file->f_flags &
> > O_NONBLOCK);
> > +	while (tss.len) {
> > +		ret = __mptcp_splice_read(sk, &tss);
> > +		if (ret < 0) {
> > +			break;
> > +		} else if (!ret) {
> > +			if (spliced)
> > +				break;
> > +			err = tcp_recv_should_stop(sk, timeo);
> > +			if (err < 0) {
> > +				if (err == -ESHUTDOWN) {
> > +					if (__mptcp_move_skbs(sk))
> > +						continue;
> > +					break;
> > +				}
> > +				ret = err;
> > +				break;
> > +			}
> > +			/* if __mptcp_splice_read() got nothing
> > while we have
> > +			 * an skb in receive queue, we do not want
> > to loop.
> > +			 * This might happen with URG data.
> > +			 */
> > +			if (!skb_queue_empty(&sk-
> > >sk_receive_queue))
> > +				break;
> > +			ret = sk_wait_data(sk, &timeo, NULL);
> > +			if (ret < 0)
> > +				break;
> > +			continue;
> > +		}
> > +		tss.len -= ret;
> > +		spliced += ret;
> > +
> > +		if (!tss.len)
> > +			break;
> > +
> > +		if (tcp_recv_should_stop(sk, timeo))
> > +			break;
> > +	}
> > +
> > +	release_sock(sk);
> > +
> > +	if (spliced)
> > +		return spliced;
> > +
> > +	return ret;
> > +}
> > +
> > static const struct proto_ops mptcp_stream_ops = {
> > 	.family		   = PF_INET,
> > 	.owner		   = THIS_MODULE,
> > @@ -4112,6 +4204,7 @@ static const struct proto_ops
> > mptcp_stream_ops = {
> > 	.mmap		   = sock_no_mmap,
> > 	.set_rcvlowat	   = mptcp_set_rcvlowat,
> > 	.read_sock	   = mptcp_read_sock,
> > +	.splice_read	   = mptcp_splice_read,
> > };
> > 
> > static struct inet_protosw mptcp_protosw = {
> > @@ -4217,6 +4310,7 @@ static const struct proto_ops
> > mptcp_v6_stream_ops = {
> > #endif
> > 	.set_rcvlowat	   = mptcp_set_rcvlowat,
> > 	.read_sock	   = mptcp_read_sock,
> > +	.splice_read	   = mptcp_splice_read,
> > };
> > 
> > static struct proto mptcp_v6_prot;
> > -- 
> > 2.48.1
> > 
> > 
> > 
