Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2ED2356BF
	for <mptcp@lists.linux.dev>; Mon, 17 Mar 2025 11:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742209203; cv=none; b=Faw4lOZRvMsUR7C9lUDopG6YwqG8fLiyidxwM9A1yxaceO16oNU03jwV8CZM8hSJEUN/DNnvoKUsgpp+PXRFmmC/OXXq9Al0bHK0B67safQVYP9evDCzL1OqEqnQ+SqcQkLwMnb6QyjK5uMSyndOtKzlO3alFeY5G8dY2dv+a58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742209203; c=relaxed/simple;
	bh=3CLQ2WFCFg2MGGMfghzVQC8I/C56Ih4rygnIIZKIk4c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V0Bt6mmXUOQgGGqAI0nf54cjMbgJtqQXMHHfY4zl4aMa0wTqHgm/7EKNWEtyst1FkXDZrpc616weIdJm4NrDfQTirnTZXo8FRWs4+8DMdHKiPEtGFORFUZsKIzK9BAFo4E18FmGqAuqVrq/NEFhPDqyGkfib+fI5k/A/Pv55qik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtcuI2Cn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtcuI2Cn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C9FC4CEE3;
	Mon, 17 Mar 2025 11:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742209202;
	bh=3CLQ2WFCFg2MGGMfghzVQC8I/C56Ih4rygnIIZKIk4c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=jtcuI2CnH00idFbwbF1HrojaKx0V5LoKbpEKqcl9kQJq8MjKRdKRpxDGSjX0ym+rk
	 5ewpmQDqOnVJtCx/w9IcqXKmxneVN4rTAFdWecVySmwyFWAS3EymUV2YnaSSuw4HFb
	 QT0VwON+DIs6czOI3rphJP97pSsDLCDjYPVxZVHoExbs8Q+V/6nMUDedH6DDOglmBw
	 auyY+LWtWKHQoMlwdmBidzbB0WSuAtFgWDpIxhMpidRdedzo8ou1YjjRs747zb0EBL
	 bpKBYe0152ZPZ2Y4IZuT69njYO8ZnWGyiGpp2V8wkopaEq4ow4/SJqrKY1dWFg/q38
	 hRelnLfoVF9Tw==
Message-ID: <2b680d20eb5873f14f35d9d23aa78b2f5a9d5bfd.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 1/2] mptcp: add bpf_iter_task for
 mptcp_sock
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, mptcp@lists.linux.dev
Date: Mon, 17 Mar 2025 18:59:56 +0800
In-Reply-To: <a92d50cf-2eb3-4c56-91cd-0dfa3eb43f7f@kernel.org>
References: <cover.1741577149.git.tanggeliang@kylinos.cn>
	 <e04cc2fa5f500097ac7d95afb94f68d0d8dc0057.1741577149.git.tanggeliang@kylinos.cn>
	 <c151a68a659659a2bc8632b63cb04cb59275ec83.camel@kernel.org>
	 <a92d50cf-2eb3-4c56-91cd-0dfa3eb43f7f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Mon, 2025-03-17 at 11:29 +0100, Matthieu Baerts wrote:
> Hi Geliang, Mat,
> 
> On 17/03/2025 10:41, Geliang Tang wrote:
> > On Mon, 2025-03-10 at 11:30 +0800, Geliang Tang wrote:
> > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > 
> > > To make sure the mptcp_subflow bpf_iter is running in the
> > > MPTCP context. This patch adds a simplified version of tracking
> > > for it:
> > > 
> > > 1. Add a 'struct task_struct *bpf_iter_task' field to struct
> > > mptcp_sock.
> > > 
> > > 2. Do a WRITE_ONCE(msk->bpf_iter_task, current) before calling
> > > a MPTCP BPF hook, and WRITE_ONCE(msk->bpf_iter_task, NULL) after
> > > the hook returns.
> > > 
> > > 3. In bpf_iter_mptcp_subflow_new(), check
> > > 
> > > 	"READ_ONCE(msk->bpf_scheduler_task) == current"
> > > 
> > > to confirm the correct task, return -EINVAL if it doesn't match.
> > > 
> > > Also creates helpers for setting, clearing and checking that
> > > value.
> > > 
> > > Suggested-by: Mat Martineau <martineau@kernel.org>
> > > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > > ---
> > >  net/mptcp/bpf.c      |  2 ++
> > >  net/mptcp/protocol.c |  1 +
> > >  net/mptcp/protocol.h | 20 ++++++++++++++++++++
> > >  net/mptcp/sched.c    | 15 +++++++++++----
> > >  4 files changed, 34 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> > > index c0da9ac077e4..0a78604742c7 100644
> > > --- a/net/mptcp/bpf.c
> > > +++ b/net/mptcp/bpf.c
> > > @@ -261,6 +261,8 @@ bpf_iter_mptcp_subflow_new(struct
> > > bpf_iter_mptcp_subflow *it,
> > >  		return -EINVAL;
> > >  
> > >  	msk = mptcp_sk(sk);
> > > +	if (!mptcp_check_bpf_iter_task(msk))
> > > +		return -EINVAL;
> > >  
> > >  	msk_owned_by_me(msk);
> > >  
> > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > index 01157ad2e2dc..d98e48ce8cd8 100644
> > > --- a/net/mptcp/protocol.c
> > > +++ b/net/mptcp/protocol.c
> > > @@ -2729,6 +2729,7 @@ static void __mptcp_init_sock(struct sock
> > > *sk)
> > >  	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
> > >  	WRITE_ONCE(msk->csum_enabled,
> > > mptcp_is_checksum_enabled(sock_net(sk)));
> > >  	WRITE_ONCE(msk->allow_infinite_fallback, true);
> > > +	mptcp_clear_bpf_iter_task(msk);
> > >  	msk->recovery = false;
> > >  	msk->subflow_id = 1;
> > >  	msk->last_data_sent = tcp_jiffies32;
> > > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > > index 3492b256ecba..1c6958d64291 100644
> > > --- a/net/mptcp/protocol.h
> > > +++ b/net/mptcp/protocol.h
> > > @@ -334,6 +334,7 @@ struct mptcp_sock {
> > >  				 */
> > >  	struct mptcp_pm_data	pm;
> > >  	struct mptcp_sched_ops	*sched;
> > > +	struct task_struct *bpf_iter_task;
> > >  	struct {
> > >  		u32	space;	/* bytes copied in last
> > > measurement
> > > window */
> > >  		u32	copied; /* bytes copied in this
> > > measurement
> > > window */
> > > @@ -1291,4 +1292,23 @@ mptcp_token_join_cookie_init_state(struct
> > > mptcp_subflow_request_sock *subflow_re
> > >  static inline void mptcp_join_cookie_init(void) {}
> > >  #endif
> > >  
> > > +static inline void mptcp_set_bpf_iter_task(struct mptcp_sock
> > > *msk)
> > > +{
> > > +	WRITE_ONCE(msk->bpf_iter_task, current);
> > > +}
> > > +
> > > +static inline void mptcp_clear_bpf_iter_task(struct mptcp_sock
> > > *msk)
> > > +{
> > > +	WRITE_ONCE(msk->bpf_iter_task, NULL);
> > > +}
> > > +
> > > +static inline bool mptcp_check_bpf_iter_task(struct mptcp_sock
> > > *msk)
> > > +{
> > > +	struct task_struct *task = READ_ONCE(msk-
> > > >bpf_iter_task);
> > > +
> > > +	if (task && task == current)
> > > +		return true;
> > > +	return false;
> > > +}
> > 
> > This v3 has a bug. When I was testing MPTCP BPF selftests in a
> > loop, I
> > found that the test would break in some cases. After debugging, I
> > found
> > that "task" and "current" were not equal:
> > 
> > [  520.209749][T11984] MPTCP: bpf_iter_mptcp_subflow_new
> > msk=00000000fc8f7370 in_interrupt=0 task=00000000ef28139f
> > current=0000000024db2987
> > 
> > I will try to fix it, but haven't found a solution yet.
> 
> (sorry for the delay, I need a bit of time to catch up)
> 
> I talked a bit to Alexei Starovoitov last week. He told me that with
> the
> BPF struct_ops, it is possible to tell the verifier that some locks
> are
> taken either by some struct_ops types, or even per callbacks of some
> specific struct_ops (WIP on sched_ext side). It is also possible to
> get
> some locks automatically (polymorphism), and there are examples on
> VFS side.

Thanks for your reminder, I will look at these BPF codes. Our goal is
to make mptcp_subflow bpf_iter only used by struct_ops defined by MPTCP
BPF (bpf_mptcp_sched_ops and bpf_mptcp_pm_ops), right? Other struct_ops
are not allowed to use mptcp_subflow bpf_iter.

> 
> In other words, it means we don't need to add this "bpf_iter_task",
> there are other techniques, but I don't have more details, and I
> didn't
> check in the code. If it is not clear for you and you don't find 
> other
> examples elsewhere (sched_ext? check WIP patches maybe?), then Alexei
> said we should not hesitate to ask questions on the BPF mailing list.

We can send "Add mptcp_subflow bpf_iter support" v3 to the BPF mailing
list and ask questions during the reviewing process.

Thanks,
-Geliang

> 
> Cheers,
> Matt

