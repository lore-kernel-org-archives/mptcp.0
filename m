Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8854F1C861B
	for <mptcp@lists.linux.dev>; Thu, 10 Jul 2025 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752138649; cv=none; b=WgesIxUsOFqIXef+y2MdBrfNAa7f0pXyEx9EYJmFG+OKe+QNnuaQf4tyzVBVzNhC9jF+jSVLolpdhjfw60jy+sIb8AdWay84kjhOQNdG9Xf+OPb9rpZtU1S51690hNJVViH8uS/lSyfC4PQPFHho69AnSn7+h69z7l7ci+i9ciY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752138649; c=relaxed/simple;
	bh=7rGcfQZaxQiLHz+Mtq0J6brhuSKcetZpfEr9hElOZCc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kdYB1zfb89jaXKVfXcxG0ZN5LC5jqzc7B8fXrD1IsPwKfe9sp2vUSgGhqeNVIJbYenwf0Oegjv5fVdhZ++FVkNTyL0duj257AA+obDKpPgRMPhRbtHxKT0cUuO/zLHnqagJZSOGHQ62L54wADImTmHiUR2SGIoOkN+OCsTIgiN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccS9uCwS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccS9uCwS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A606C4CEF1;
	Thu, 10 Jul 2025 09:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752138649;
	bh=7rGcfQZaxQiLHz+Mtq0J6brhuSKcetZpfEr9hElOZCc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ccS9uCwSplwtylnc+7KnftFBT+0Ulm1MzbkRyS7YD85Iz4RkrrSdsnJnfjzUaky7x
	 vCjwC99aaI00KZWl9nNLFId9uuuEH45yEMkFq1v6oGk1J34rVXM9JLH7mk5B1Y1i/2
	 QkhKFEW6Z3C9hjKgBddytbpEUM4GV5ym08w0q8Yr4rWO3YLPMymOnihVunwn/2fElL
	 rn2uhdW+Nh96yxglk/FrURlWNPYJffMdAq5CcNf0mUhl8FiUzn8Bxs3yPX7zY6wp6M
	 FvRsHRvAcjVk7Oraex+UurRK+DwXXulCT58zpVeZcSIo81IjCN/dvaRXLXVVmGNRUQ
	 4KyLdW/EU1TRw==
Message-ID: <0346b37ff8021446d3be6839132141daf277ffb6.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v7 3/4] mptcp: implement .splice_read
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev, hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Thu, 10 Jul 2025 17:10:44 +0800
In-Reply-To: <63354366-79aa-4799-9af3-5f5a379ea4eb@redhat.com>
References: <cover.1751880561.git.tanggeliang@kylinos.cn>
	 <7c269511e2ff8cf2a44934cb0f12554770c5c7c6.1751880561.git.tanggeliang@kylinos.cn>
	 <63354366-79aa-4799-9af3-5f5a379ea4eb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

On Tue, 2025-07-08 at 16:52 +0200, Paolo Abeni wrote:
> On 7/7/25 11:34 AM, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > This patch implements .splice_read interface of mptcp struct
> > proto_ops
> > as mptcp_splice_read() with reference to tcp_splice_read().
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  net/mptcp/protocol.c | 136
> > +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 136 insertions(+)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index fc429d175ede..4638d4be2b98 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -4023,6 +4023,140 @@ static int mptcp_read_sock(struct sock *sk,
> > read_descriptor_t *desc,
> >  	return copied;
> >  }
> >  
> > +/*
> > + * MPTCP splice context
> > + */
> > +struct mptcp_splice_state {
> > +	struct pipe_inode_info *pipe;
> > +	size_t len;
> > +	unsigned int flags;
> > +};
> > +
> > +static int mptcp_splice_data_recv(read_descriptor_t *rd_desc,
> > struct sk_buff *skb,
> > +				  unsigned int offset, size_t len)
> > +{
> > +	struct mptcp_splice_state *mss = rd_desc->arg.data;
> > +	int ret;
> > +
> > +	ret = skb_splice_bits(skb, skb->sk, offset, mss->pipe,
> > +			      min(rd_desc->count, len), mss-
> > >flags);
> > +	if (ret > 0)
> > +		rd_desc->count -= ret;
> > +	return ret;
> > +}
> 
> I have mixed feeling WRT the above. I'm wondering if we should reuse
> the
> same code already existing in TCP, moving tcp_spice_state definition
> in
> some shared hdr and macking tcp_splice_data_recv not static.
> 
> > +static int __mptcp_splice_read(struct sock *sk, struct
> > mptcp_splice_state *mss)
> > +{
> > +	/* Store MPTCP splice context information in
> > read_descriptor_t. */
> > +	read_descriptor_t rd_desc = {
> > +		.arg.data = mss,
> > +		.count	  = mss->len,
> > +	};
> > +
> > +	return mptcp_read_sock(sk, &rd_desc,
> > mptcp_splice_data_recv);
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
> > +	struct mptcp_splice_state mss = {
> > +		.pipe = pipe,
> > +		.len = len,
> > +		.flags = flags,
> > +	};
> > +	struct sock *sk = sock->sk;
> > +	ssize_t spliced;
> > +	long timeo;
> > +	int ret;
> > +
> > +	/*
> > +	 * We can't seek on a socket input
> > +	 */
> > +	if (unlikely(*ppos))
> > +		return -ESPIPE;
> > +
> > +	spliced = 0;
> > +	ret = 0;
> > +
> > +	lock_sock(sk);
> > +
> > +	timeo = sock_rcvtimeo(sk, sock->file->f_flags &
> > O_NONBLOCK);
> > +	while (mss.len) {
> > +		ret = __mptcp_splice_read(sk, &mss);
> > +		if (ret < 0) {
> > +			break;
> > +		} else if (!ret) {
> > +			if (spliced)
> > +				break;
> > +			if (sock_flag(sk, SOCK_DONE))
> > +				break;

I noticed that this SOCK_DONE flag is also checked in
tcp_recvmsg_locked() but not in mptcp_recvmsg(). I wonder if this flag
should also be checked in mptcp_recvmsg() too.

> > +			if (sk->sk_err) {
> > +				ret = sock_error(sk);
> > +				break;
> > +			}
> > +			if (sk->sk_shutdown & RCV_SHUTDOWN) {
> > +				if (__mptcp_move_skbs(sk))
> > +					continue;
> > +				break;
> > +			}
> > +			if (sk->sk_state == TCP_CLOSE) {
> > +				ret = -ENOTCONN;
> > +				break;
> > +			}
> > +			if (!timeo) {
> > +				ret = -EAGAIN;
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
> > +			if (signal_pending(current)) {
> > +				ret = sock_intr_errno(timeo);
> > +				break;
> > +			}
> 
> I think that moving the above if statement before the queue empty
> check
> will not change the overall behavior.
> 
> With that in place you could factor out an
> 
> bool mptcp_recv_should_stop(struct sock *sk, int err)

This helper can also be used in tcp_recvmsg_locked and tcp_splice_read
too. What about rename it as tcp_recv_should_stop, then add it in
include/net/tcp.h and use it for both TCP and MPTCP. WDYT?

Thanks,
-Geliang

> 
> helper from mptcp_recvmsg() and use it verbatim in both in
> mptcp_recvmsg() and here.
> 
> Side note: suggestions for a better helper name welcome!
> 
> /P
> 
