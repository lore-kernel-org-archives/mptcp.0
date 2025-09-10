Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882F335961
	for <mptcp@lists.linux.dev>; Wed, 10 Sep 2025 03:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757474647; cv=none; b=hBVWYn7z2r5nCfSclWxTbGsUnE1DEJgMj0TR74/XLi+6HymE6n1B63fNruNftM8EBLfaHkux2xIzfbCRnmnn63IsQha+orXNyXKBxB4F2UpwVIgVu4/Rhigi5VmmYTPk/CHU6KaMYZE58V5VdcxUKh2/gClX7SwM7oW4e2LEZwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757474647; c=relaxed/simple;
	bh=jboUkeT6qKgGzNYvWXQ7xzhk7Sr7Qqrd+DTmZUf1TMc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jOxTtyupIQvAFn85MaURdLNh+yr589XtP0ScFv+9RjLTAwmne7+3hQgVxqqDtpGFdGfH+l+1g0xbolEmqbtoSnjkjZjKazJJpyLq2A+Q1u8LGpG8m4AJhd2ipAWcLC7IG9/X+QRJ5ZK3NdJuWP9q4uCzr+GFsbL9Rn6GUx6pdBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsGKhLNj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsGKhLNj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74177C4CEF0;
	Wed, 10 Sep 2025 03:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757474647;
	bh=jboUkeT6qKgGzNYvWXQ7xzhk7Sr7Qqrd+DTmZUf1TMc=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=MsGKhLNjqlwHuJSXyLNJR3H2uq247X69qQT6VzjiZtuqbMvYtfJgnxpFUChVW/9Tw
	 5ZpEBf6Yc+ZgdsbU5WWdxGAawA1xJIYvAGillv4P/CbQhCX0cu5dtVhCFhPOrCAl0H
	 T4AhH0aM5ks6VTXW5McdnrOQqM/CIrN3z8Bsm1L5sdwS77HPsKVffmb0iuieGl60xd
	 EB+yD4mu1Xe4QwKxRVmHw7w4UpsuzcjDNVS7FF8bIbXYomoWtL/PBG9gMkL/kYFghp
	 zWRXghTbGHfI4OPQAwSnXVdTznrcIt74bHSbyW1GsqGWZ4uFC0de4nblgEIJa4nauZ
	 +GfCBfXYjYwjA==
Message-ID: <b76b31112598ee1e4774e1fd0cb68162c5633a3d.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v2 1/5] mptcp: propagate shutdown to subflows
 when possible
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Wed, 10 Sep 2025 11:24:02 +0800
In-Reply-To: <aa8f9007-71cb-4c82-b235-bd585da19922@kernel.org>
References: <20250905-sft-mptcp-disc-err-v2-0-dfb3b6b4a877@kernel.org>
	 <20250905-sft-mptcp-disc-err-v2-1-dfb3b6b4a877@kernel.org>
	 <9f2a05ac6034fb33f579302a0ede2ec13eb6c915.camel@kernel.org>
	 <aa8f9007-71cb-4c82-b235-bd585da19922@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Sat, 2025-09-06 at 15:42 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 06/09/2025 02:45, Geliang Tang wrote:
> > On Fri, 2025-09-05 at 20:18 +0200, Matthieu Baerts (NGI0) wrote:
> > > When the MPTCP DATA FIN have been ACKed, there is no more MPTCP
> > > related
> > > metadata to exchange, and all subflows can be safely shutdown.
> > > 
> > > Before this patch, the subflows were actually terminated at
> > > 'close()'
> > > time. That's certainly fine most of the time, but not when the
> > > userspace
> > > 'shutdown()' a connection, without close()ing it. When doing so,
> > > the
> > > subflows were staying in LAST_ACK state on one side -- and
> > > consequently
> > > in FIN_WAIT2 on the other side -- until the 'close()' of the
> > > MPTCP
> > > socket.
> > > 
> > > Now, when the DATA FIN have been ACKed, all subflows are
> > > shutdown. A
> > > consequence of this is that the TCP 'FIN' flag can be set earlier
> > > now,
> > > but the end result is the same. This affects the packetdrill
> > > tests
> > > looking at the end of the MPTCP connections, but for a good
> > > reason.
> > > 
> > > Fixes: 3721b9b64676 ("mptcp: Track received DATA_FIN sequence
> > > number
> > > and add related helpers")
> > > Fixes: 16a9a9da1723 ("mptcp: Add helper to process acks of
> > > DATA_FIN")
> > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > ---
> > >  net/mptcp/protocol.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > index
> > > 1c26acf6c4145896ecbb5c7f7004121c66a20649..9feb9f437c2bdfff392249e
> > > 7ad0
> > > 0edd09ba67ac3 100644
> > > --- a/net/mptcp/protocol.c
> > > +++ b/net/mptcp/protocol.c
> > > @@ -372,6 +372,20 @@ static void mptcp_close_wake_up(struct sock
> > > *sk)
> > >  		sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
> > >  }
> > >  
> > > +static void mptcp_shutdown_subflows(struct mptcp_sock *msk)
> > > +{
> > > +	struct mptcp_subflow_context *subflow;
> > > +
> > > +	mptcp_for_each_subflow(msk, subflow) {
> > > +		struct sock *ssk =
> > > mptcp_subflow_tcp_sock(subflow);
> > > +		bool slow;
> > > +
> > > +		slow = lock_sock_fast(ssk);
> > > +		tcp_shutdown(ssk, SEND_SHUTDOWN);
> > > +		unlock_sock_fast(ssk, slow);
> > > +	}
> > > +}
> > > +
> > >  /* called under the msk socket lock */
> > >  static bool mptcp_pending_data_fin_ack(struct sock *sk)
> > >  {
> > > @@ -396,6 +410,7 @@ static void mptcp_check_data_fin_ack(struct
> > > sock
> > > *sk)
> > >  			break;
> > >  		case TCP_CLOSING:
> > >  		case TCP_LAST_ACK:
> > > +			mptcp_shutdown_subflows(msk);
> > >  			mptcp_set_state(sk, TCP_CLOSE);
> > >  			break;
> > >  		}
> > > @@ -564,6 +579,7 @@ static bool mptcp_check_data_fin(struct sock
> > > *sk)
> > >  			mptcp_set_state(sk, TCP_CLOSING);
> > >  			break;
> > >  		case TCP_FIN_WAIT2:
> > > +			mptcp_shutdown_subflows(msk);
> > 
> > I think we should not directly call mptcp_shutdown_subflows()
> > within
> > mptcp_check_data_fin() and mptcp_check_data_fin_ack(), but should
> > instead call it after these functions return and the sk state is
> > TCP_CLOSE. This ensures that the original purpose of these two
> > functions remains unchanged.
> 
> Thank you for the review. I'm not sure to understand what you mean
> about
> the "original purpose": they both set the appropriated actions when
> DATA_FIN have been received. Here, I do want to shut the subflows
> down
> when the DATA_FIN ACK are received, so that's the good spot, no?
> 
> Note that commit 3721b9b64676 ("mptcp: Track received DATA_FIN
> sequence
> number and add related helpers") already had a hint of what should
> have
> been done: see the "Close subflows now?" comment, later removed in
> commit e16163b6e2b7 ("mptcp: refactor shutdown and close").
> 
> Or maybe do you mean their original name "check_data_fin(_ack)" is
> confusing? The "check" here is not just to check if the DATA_FIN
> (ACK)
> was set, but to check actions related to them.

I mean not to modify mptcp_check_data_fin and mptcp_check_data_fin_ack,
but to check TCP_CLOSE in mptcp_worker(), something like:

@@ -2749,6 +2749,9 @@ static void mptcp_worker(struct work_struct
*work)
        mptcp_check_data_fin_ack(sk);
        mptcp_check_data_fin(sk);
 
+       if (sk->sk_state == TCP_CLOSE)
+               mptcp_shutdown_subflows(msk);
+
        if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
                __mptcp_close_subflow(sk);

Another option is to call mptcp_shutdown_subflows in
mptcp_close_wake_up, which one do you think is better?

Thanks,
-Geliang

> 
> Cheers,
> Matt
