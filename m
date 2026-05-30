Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6705E219E8
	for <mptcp@lists.linux.dev>; Sat, 30 May 2026 04:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780115023; cv=none; b=XAK7ATZayXSgJN7LQOvQdz+kdnRWGQ9tBb7FiwkpMKC8C11JOF5XB6o00c1wHXbxQmOSq9mIlmOO70oJHNnYDiP35zzbEhAHXZWfoJuhV7KObGoMo5BR2iDmMOo8Lpqb2birfwv5kxA2QaQYjN7ko0WDfrx9ZGwxrGxFj4dNBZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780115023; c=relaxed/simple;
	bh=7nlhoWGQPXzV9RM4PBhWA2+QnXnq/Tj7nx2KMzXog70=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CTId8ywGRdR78CLgX+xeudXQbcW3lspyZnwRcKuciUUqwtEAwY4zs/tS5QJEWk31tyi349+r2JxUgDlC1rXzu9jDWY4iOcjIQxsJPiFNK3PxS097F+bUPX43nutxJP3CNuBTH4h23qEue1w0C4Gd8DcODT82S4Jzk9Ovos+7es0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nj2fbRml; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nj2fbRml"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A891F00893;
	Sat, 30 May 2026 04:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780115022;
	bh=q0euofeEGyTVqhkM2IC63Tg0nfGVKYGkogGh0MItXzs=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=nj2fbRmlQSMomIpPYXePJnvo/1VbfuVpXkTVJsQb34TbZBB6+q6yg/uedBtnRJDDg
	 /CyaoQc4YXHKoh69eEj32xI6+Oth9zyfSg9ezY/7EhgxBlcLEVBTIDQUBuC1ZB2MYf
	 x/fSkPPnJZ53aaHujeHdrjZvxcr0ndFSt3zEB7o3FLh5QxMExdxSN/eRhSmj5QynLg
	 SO+ybNOVRwA9sD3narpKG94YKghwxGxVJXP9vbDCCEoT6t2qfy7yGzKayT5vGQLQg2
	 aJenMiDih/16BslFIbzjsHrPPaQjQLfbicnU3zN7dE/6idFNLQrCFU49RgshsQ1Meo
	 x+6ohcNYhZZhw==
Message-ID: <c181d3ecd7c215186f871442e7e2fe1555c3bb57.camel@kernel.org>
Subject: Re: [PATCH v10 mptcp-next 3/3] mptcp: let the retrans scheduler do
 its job.
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Date: Sat, 30 May 2026 12:23:39 +0800
In-Reply-To: <20f8009c-438a-4103-9864-f2648eb6a2f0@redhat.com>
References: <cover.1780049797.git.pabeni@redhat.com>
	 <199d3b27cc1f092a1bca686963103f922d0d27cd.1780049797.git.pabeni@redhat.com>
	 <61de072a8e750ec6c7d7228cca6d7d55885e0abf.camel@kernel.org>
	 <e90f30c1-59c5-4707-8a95-a5e876d20399@redhat.com>
	 <20f8009c-438a-4103-9864-f2648eb6a2f0@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

On Fri, 2026-05-29 at 19:04 +0200, Paolo Abeni wrote:
> On 5/29/26 4:14 PM, Paolo Abeni wrote:
> > On 5/29/26 3:27 PM, Geliang Tang wrote:
> > > On Fri, 2026-05-29 at 12:44 +0200, Paolo Abeni wrote:
> > > > Currently the MPTCP core enforces that when MPTCP-level retrans
> > > > timer
> > > > fires, at most a single dfrag is retransmitted. If some corner-
> > > > cases
> > > > it
> > > > may be necessary retransmit multiple dfrags, and the MPTCP
> > > > socket
> > > > will
> > > > need to wait multiple retrans timeout to accomplish that.
> > > > 
> > > > Remove the mentioned constraint, allowing to transmit multiple
> > > > dfrags
> > > > per
> > > > retrans period, as long as the scheduler keeps selecting
> > > > subflows for
> > > > retransmissions and pending data is available in the rtx queue.
> > > > The default scheduler will transmit a dfrag per available
> > > > subflow.
> > > > 
> > > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > > ---
> > > > v9 -> v10:
> > > >   - simpler handling for data-fin rtx
> > > > 
> > > > v7 -> v8
> > > >   - fix corner-case retrans_seq update
> > > > 
> > > > v4 -> v5:
> > > >   - fixed already_sent update
> > > > 
> > > > v3 -> v4:
> > > >   - avoid quadratic behavior, fix retrans_seq update
> > > >   - fix rtx timer re-schedule miss
> > > > 
> > > > v2 -> v3:
> > > >   - fix infinite loop issue (should address tls tests failures)
> > > > 
> > > > v1 -> v2:
> > > >   - fix retrans sequence update (sashiko)
> > > > 
> > > > Note:
> > > >  - sashiko may see issues when dfrag = mptcp_rtx_head(sk) !=
> > > > NULL and
> > > >    dfrag->already_sent == 0. That condition should not
> > > > possible: if
> > > >    mptcp_rtx_head() is not NULL there should be some data
> > > > already
> > > >    sent.
> > > >  - sashiko may see missing data-fin rtx when the initial
> > > > `dfrag` is
> > > >    not NULL. data-fin RTX is NOT needed in such scenario.
> > > > ---
> > > >  net/mptcp/protocol.c | 119 +++++++++++++++++++++++++++++++----
> > > > ------
> > > > --
> > > >  1 file changed, 87 insertions(+), 32 deletions(-)
> > > > 
> > > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > > index 51756800edc2..7fe618e22d1b 100644
> > > > --- a/net/mptcp/protocol.c
> > > > +++ b/net/mptcp/protocol.c
> > > > @@ -1201,13 +1201,6 @@ static void
> > > > __mptcp_clean_una_wakeup(struct
> > > > sock *sk)
> > > >  	mptcp_write_space(sk);
> > > >  }
> > > >  
> > > > -static void mptcp_clean_una_wakeup(struct sock *sk)
> > > > -{
> > > > -	mptcp_data_lock(sk);
> > > > -	__mptcp_clean_una_wakeup(sk);
> > > > -	mptcp_data_unlock(sk);
> > > > -}
> > > > -
> > > >  static void mptcp_enter_memory_pressure(struct sock *sk)
> > > >  {
> > > >  	struct mptcp_subflow_context *subflow;
> > > > @@ -2830,8 +2823,12 @@ static void mptcp_check_fastclose(struct
> > > > mptcp_sock *msk)
> > > >  	sk_error_report(sk);
> > > >  }
> > > >  
> > > > -/* Retransmit the specified data fragment on all the selected
> > > > subflows. */
> > > > -static int __mptcp_push_retrans(struct sock *sk, struct
> > > > mptcp_data_frag *dfrag)
> > > > +/*
> > > > + * Retransmit the specified data fragment on all the selected
> > > > subflows,
> > > > + * starting from the specified sequence
> > > > + */
> > > > +static int __mptcp_push_retrans(struct sock *sk, struct
> > > > mptcp_data_frag *dfrag,
> > > > +				u64 sent_seq)
> > > >  {
> > > >  	struct mptcp_sendmsg_info info = { .data_lock_held =
> > > > true,
> > > > };
> > > >  	struct mptcp_sock *msk = mptcp_sk(sk);
> > > > @@ -2841,6 +2838,7 @@ static int __mptcp_push_retrans(struct
> > > > sock
> > > > *sk, struct mptcp_data_frag *dfrag)
> > > >  
> > > >  	mptcp_for_each_subflow(msk, subflow) {
> > > >  		if (READ_ONCE(subflow->scheduled)) {
> > > > +			u16 offset = sent_seq - dfrag-
> > > > >data_seq;
> > > >  			u16 copied = 0;
> > > >  
> > > >  			mptcp_subflow_set_scheduled(subflow,
> > > > false);
> > > > @@ -2850,9 +2848,12 @@ static int __mptcp_push_retrans(struct
> > > > sock
> > > > *sk, struct mptcp_data_frag *dfrag)
> > > >  			lock_sock(ssk);
> > > >  
> > > >  			/* limit retransmission to the bytes
> > > > already
> > > > sent on some subflows */
> > > > -			info.sent = 0;
> > > > +			info.sent = offset;
> > > >  			info.limit = READ_ONCE(msk-
> > > > >csum_enabled) ?
> > > > dfrag->data_len :
> > > >  							
> > > > 	   
> > > > dfrag->already_sent;
> > > > +			DEBUG_NET_WARN_ON_ONCE(!before64(sent_
> > > > seq,
> > > > +							
> > > > dfrag-
> > > > > data_seq +
> > > > +							
> > > > info.limit));
> > > 
> > > Same as I reported in v8 of this patch [1], 
> > 
> > I'm sorry, I missed the previous report. Thanks for persisting :)
> > 
> > > when testing based on v10 I encountered the following error:
> > > 
> > > # Starting 4 threads
> > > [  879.268966][ T4341] ------------[ cut here ]------------
> > > [  879.269413][ T4341] !before64(sent_seq, dfrag->data_seq +
> > > info.limit)
> > > [  879.269417][ T4341] WARNING: net/mptcp/protocol.c:2883 at
> > > __mptcp_push_retrans+0x562/0x6f0, CPU#18: kworker/18:6H/4341
> > > [  879.271883][ T4341] Modules linked in: mptcp_diag tcp_diag
> > > inet_diag
> > > sch_netem
> > > [  879.272450][ T4341] CPU: 18 UID: 0 PID: 4341 Comm:
> > > kworker/18:6H Not
> > > tainted 7.1.0-rc5+ #94 PREEMPT(full) 
> > > [  879.272813][ T4341] Hardware name: Bochs Bochs, BIOS Bochs
> > > 01/01/2011
> > > [  879.273225][ T4341] Workqueue: nvmet_tcp_wq nvmet_tcp_io_work
> > > [  879.273527][ T4341] RIP: 0010:__mptcp_push_retrans+0x562/0x6f0
> > 
> > Which test-case produces the above splat? Is the splat
> > deterministic?
> > 
> > Sashiko reported such problem, but I don't see how that can happen
> > without i.e. an independently generated data corruption as root
> > cause:
> > 
> > info.limit can be 0 only when dfrag->already_sent == 0, and that
> > can
> > happen only if mptcp_rtx_head(sk) == NULL - if the current rtx head
> > is
> > not null, the current retransmit head data fragment must have some
> > unackledged bytes, that is already_sent must be greater than 0.
> > 
> > That incoming ack can touch/modify the RTX queue while
> > __mptcp_retrans()
> > is running only when __mptcp_clean_una_wakeup() is explicitly
> > invoked,
> > and the code always check `dfrag` afterwards.
> > 
> > AFAICS if that warning fires, there is some bug elsewhere.
> 
> Well, sort of: __mptcp_retransmit_pending_data() explicitly breaks
> the
> assumption above by explicitly clearing `already_sent` in all the
> data
> fragments in the retransmission queue.
> 
> __mptcp_retransmit_pending_data() behavior is actually "correct" - to
> ensure recovery. I'll and explicit `already_sent == 0` check and will
> drop the DEBUG_NET_WARN_ON_ONCE().

Thank you very much. Except for this DEBUG_NET_WARN_ON_ONCE, all tests
are working well. Please add my tag for this series:

Tested-and-Acked-by: Geliang Tang <geliang@kernel.org>

-Geliang

> 
> /P
