Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4542CA8
	for <mptcp@lists.linux.dev>; Tue, 26 Oct 2021 07:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1635235162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1eWUWmkwSKHyLz3U+RzHA66acy48ImQBhJOC+Nv8e0k=;
	b=bGLhyHflb8LyAXevPBM/DhBtJgfYCTWaH2amBrlAOR5SrMWyrZtRYhXbsOJ4SOt6Lt/6Pz
	ECBy3KQ/xZ01swOrw+5qjMO6sMJZarA2kc28i6YhTxQdOILZaDqdAJFVD7U5IotX/kQaBL
	wkGPvxE4KkOJVC9RIhGiA0deVbmgDk0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-CfORdKfzPfC4UcS3YqVzgQ-1; Tue, 26 Oct 2021 03:59:17 -0400
X-MC-Unique: CfORdKfzPfC4UcS3YqVzgQ-1
Received: by mail-ed1-f69.google.com with SMTP id z20-20020a05640240d400b003dce046ab51so12223486edb.14
        for <mptcp@lists.linux.dev>; Tue, 26 Oct 2021 00:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1eWUWmkwSKHyLz3U+RzHA66acy48ImQBhJOC+Nv8e0k=;
        b=UAHhC/Iap93Kjb8D+ENoG7MXI8PYsu4ZJmcK9qpTl9yuHjtnfPBPFPD3ndsVbmyNPA
         TkYy1Ob+f3BTYcBBpK1f9OXFzEbZ/jj4jSCs+HWD6Z0ts/cd0dQAsUStBvkjoi4IQm3Q
         nrDp3GinamqfGtwiVI8z/7UEoXJhWVfC98SwPR+rnf9+TMJvxCXYF16x6IXBQoo/SI4O
         1MYVrW/8aFYUry9vSBwLzvQ7KGa283qj5Sme5PqPuUZCk9191hfqMRdMdoQ5WkiJY8Dy
         ikoHAmLbnU+2LSaNW/rLegM6U1/SygA8uYlfibWKYxOM1VQkSmf3ni+W965xsQWLZSsa
         6IcA==
X-Gm-Message-State: AOAM532w6e1kgjW9n8a8/kudf5VD/Cf2n055AuDrpzxzN0Q/ZVX4Uzhq
	KWpsDCZLn3K17vWE3uQornIdi//rLVTB5dq6qSqNO2WhwrRAQdzbPWaThPFGmaomRN0QNraY02R
	iVjJSnJiKfo/AvdQ=
X-Received: by 2002:a05:6402:2808:: with SMTP id h8mr33521174ede.394.1635235156056;
        Tue, 26 Oct 2021 00:59:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsNKh6tx51PAxWOsLzXu7iIQzwxLWTCYycHqyoBNjqIv4zOJY7xlJylli4uy/91VVuk4c1qQ==
X-Received: by 2002:a05:6402:2808:: with SMTP id h8mr33521142ede.394.1635235155788;
        Tue, 26 Oct 2021 00:59:15 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-240-164.dyn.eolo.it. [146.241.240.164])
        by smtp.gmail.com with ESMTPSA id m3sm2873736edc.36.2021.10.26.00.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 00:59:15 -0700 (PDT)
Message-ID: <d33c1a2c642adc3682107b4bfd1c7ddde9437806.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] mptcp: enforce HoL-blocking estimation
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp <mptcp@lists.linux.dev>
Date: Tue, 26 Oct 2021 09:59:14 +0200
In-Reply-To: <88871581-6815-174-a75c-22618eb7c475@linux.intel.com>
References: <22cda018a37459d99683e572e35ac61bbc43fcae.1634900440.git.pabeni@redhat.com>
	  <6e3468c2-8e61-a05b-8cd1-4656e9217fcc@linux.intel.com>
	 <049cc3893767d00b4511aafb8acb191dea7aaca8.camel@redhat.com>
	 <88871581-6815-174-a75c-22618eb7c475@linux.intel.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2021-10-25 at 10:17 -0700, Mat Martineau wrote:
> On Mon, 25 Oct 2021, Paolo Abeni wrote:
> 
> > On Fri, 2021-10-22 at 18:19 -0700, Mat Martineau wrote:
> > > On Fri, 22 Oct 2021, Paolo Abeni wrote:
> > > 
> > > > The MPTCP packet scheduler has sub-optimal behavior with asymmetric
> > > > subflows: if the faster subflow-level cwin is closed, the packet
> > > > scheduler can enqueue "too much" data on a slower subflow.
> > > > 
> > > > When all the data on the faster subflow is acked, if the mptcp-level
> > > > cwin is closed, and link utilization becomes suboptimal.
> > > > 
> > > > The solution is implementing blest-like[1] HoL-blocking estimation,
> > > > transmitting only on the subflow with the shorter estimated time to
> > > > flush the queued memory. If such subflows cwin is closed, we wait
> > > > even if other subflows are available.
> > > > 
> > > > This is quite simpler than the original blest implementation, as we
> > > > leverage the pacing rate provided by the TCP socket. To get a more
> > > > accurate estimation for the subflow linger-time, we maintain a
> > > > per-subflow weighted average of such info.
> > > > 
> > > > Additionally drop magic numbers usage in favor of newly defined
> > > > macros.
> > > > 
> > > > [1] http://dl.ifip.org/db/conf/networking/networking2016/1570234725.pdf
> > > > 
> > > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > > ---
> > > > notes:
> > > > - this apparently solves for good issue/137, with > 200 iterations with
> > > > no failures
> > > > - still to be investigated the impact on high-speed links, if any
> > > > ---
> > > > net/mptcp/protocol.c | 58 ++++++++++++++++++++++++++++++--------------
> > > > net/mptcp/protocol.h |  1 +
> > > > 2 files changed, 41 insertions(+), 18 deletions(-)
> > > > 
> > > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > > index 7803b0dbb1be..cc9d32cb7bc7 100644
> > > > --- a/net/mptcp/protocol.c
> > > > +++ b/net/mptcp/protocol.c
> > > > @@ -1395,20 +1395,24 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
> > > > 	return __mptcp_subflow_active(subflow);
> > > > }
> > > > 
> > > > +#define SSK_MODE_ACTIVE	0
> > > > +#define SSK_MODE_BACKUP	1
> > > > +#define SSK_MODE_MAX	2
> > > > +
> > > > /* implement the mptcp packet scheduler;
> > > >  * returns the subflow that will transmit the next DSS
> > > >  * additionally updates the rtx timeout
> > > >  */
> > > > static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> > > > {
> > > > -	struct subflow_send_info send_info[2];
> > > > +	struct subflow_send_info send_info[SSK_MODE_MAX];
> > > > 	struct mptcp_subflow_context *subflow;
> > > > 	struct sock *sk = (struct sock *)msk;
> > > > +	u32 pace, burst, wmem;
> > > > 	int i, nr_active = 0;
> > > > 	struct sock *ssk;
> > > > 	long tout = 0;
> > > > 	u64 ratio;
> > > > -	u32 pace;
> > > > 
> > > > 	sock_owned_by_me(sk);
> > > > 
> > > > @@ -1427,10 +1431,11 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> > > > 	}
> > > > 
> > > > 	/* pick the subflow with the lower wmem/wspace ratio */
> > > > -	for (i = 0; i < 2; ++i) {
> > > > +	for (i = 0; i < SSK_MODE_MAX; ++i) {
> > > > 		send_info[i].ssk = NULL;
> > > > 		send_info[i].ratio = -1;
> > > > 	}
> > > > +
> > > > 	mptcp_for_each_subflow(msk, subflow) {
> > > > 		trace_mptcp_subflow_get_send(subflow);
> > > > 		ssk =  mptcp_subflow_tcp_sock(subflow);
> > > > @@ -1439,12 +1444,13 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> > > > 
> > > > 		tout = max(tout, mptcp_timeout_from_subflow(subflow));
> > > > 		nr_active += !subflow->backup;
> > > > -		if (!sk_stream_memory_free(subflow->tcp_sock) || !tcp_sk(ssk)->snd_wnd)
> > > > -			continue;
> > > > -
> > > > -		pace = READ_ONCE(ssk->sk_pacing_rate);
> > > > -		if (!pace)
> > > > -			continue;
> > > > +		pace = subflow->avg_pacing_rate;
> > > > +		if (unlikely(!pace)) {
> > > > +			/* init pacing rate from socket */
> > > > +			pace = subflow->avg_pacing_rate = READ_ONCE(ssk->sk_pacing_rate);
> > > 
> > > Checkpatch complains about the double assignment. I did do a double-take
> > > to confirm that it didn't look like a '==' typo, and slightly lean toward
> > > keeping it checkpatch-clean.
> > 
> > Yep, I'll fix the above in v2.
> > 
> > > > +			if (!pace)
> > > > +				continue;
> > > > +		}
> > > > 
> > > > 		ratio = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32,
> > > > 				pace);
> > > > @@ -1457,16 +1463,32 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> > > > 
> > > > 	/* pick the best backup if no other subflow is active */
> > > > 	if (!nr_active)
> > > > -		send_info[0].ssk = send_info[1].ssk;
> > > > -
> > > > -	if (send_info[0].ssk) {
> > > > -		msk->last_snd = send_info[0].ssk;
> > > > -		msk->snd_burst = min_t(int, MPTCP_SEND_BURST_SIZE,
> > > > -				       tcp_sk(msk->last_snd)->snd_wnd);
> > > > -		return msk->last_snd;
> > > > -	}
> > > > +		send_info[SSK_MODE_ACTIVE].ssk = send_info[SSK_MODE_BACKUP].ssk;
> > > > +
> > > > +	/* According to the blest algorithm, to avoid HoL blocking for the
> > > > +	 * faster flow, we need to:
> > > > +	 * - estimate the faster flow linger time
> > > > +	 * - use the above to estimate the amount of byte transferred
> > > > +	 *   by the faster flow
> > > > +	 * - check that the amount of queued data is greter than the above,
> > > > +	 *   otherwise do not use the picked, slower, subflow
> > > > +	 * We select the subflow with the shorter estimated time to flush
> > > > +	 * the queued mem, which basically ensure the above. We just need
> > > > +	 * to check that subflow has a non empty cwin.
> > > > +	 */
> > > > +	ssk = send_info[SSK_MODE_ACTIVE].ssk;
> > > > +	if (!ssk || !sk_stream_memory_free(ssk) || !tcp_sk(ssk)->snd_wnd)
> > > > +		return NULL;
> > > > 
> > > > -	return NULL;
> > > > +	burst = min_t(int, MPTCP_SEND_BURST_SIZE, tcp_sk(ssk)->snd_wnd);
> > > > +	wmem = READ_ONCE(ssk->sk_wmem_queued);
> > > > +	subflow = mptcp_subflow_ctx(ssk);
> > > > +	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
> > > > +					   READ_ONCE(ssk->sk_pacing_rate) * burst,
> > > > +					   burst + wmem);
> > > 
> > > I see how this gives a smoothed-out version of the pacing rate, using
> > > avg_pacing_rate for the bytes already sent on this subflow (wmem) and
> > > ssk->sk_pacing_rate for the bytes that will probably be sent now.
> > > 
> > > Is this a *better* estimation of the flow speed than the plain
> > > ssk->sk_pacing_rate?
> > 
> > It looks like it is. I get a consistent (higher) failure rate using
> > plain sk_pacing_rate instead. 'sk_pacing_rate' is an 'instant' value
> > applied to the current pkt, can change in a relevant way in a little
> > amount of time.
> > 
> 
> Ok, sk_pacing_rate is even noisier than I realized. My main concern here 
> is that whatever filtering we do on that noisy signal handles a variety of 
> conditions well. This includes cases like a failing wireless signal, where 
> the current and future throughput might be far lower than the average 
> pacing rate would indicate - and in that case the filtering algorithm 
> needs to respond appropriately.
> 
> My first job was in test & measurement, where a lot of thought goes in to 
> taking noisy A/D converter data and turning it in to a "good" measurement 
> value. When using a weighted average like this, it's common to throw away 
> the average if the new value is a significant change (like "X%" higher or 
> lower). 

I think I do understand.

Please note that here there are some difference WRT sampling more or
less noisy values: the stack enforces that the current sampled value is
applied to current packet and we record the pacing for each xmitted
chunk of data.

Using the current pacing_rate to estimate the time to flush the ssk
xmit queue is subject to relevant errors, as it applies the "wrong"
pace to previous samples. 

The computed time could differ in a significant way from the real one
only if the TCP stack will produce multiple GSO segments for a single
burst, using very different pacing rate for the 'next ones'.

Since the max burst size is below the max gso size, AFAICS the above
could happen only with GSO disabled, when performances are expected to
be bad. Additionally, throwing away the average on sudden pacing value
changes will not protect from the above scenario: a delta will be
caused by _future_ sudden change of the pacing rate.

Not sure if the above is somewhat clear ;)

Cheers,

Paolo

p.s. just to move the thing forward I'll send a v2 with the
uncontroversial changes applied...

