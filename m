Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84CB2C9F
	for <mptcp@lists.linux.dev>; Mon, 25 Oct 2021 13:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1635169612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hREwVADpgUJNwEBnFYI2/5NVZabsGbBtzHEjCiW+DTc=;
	b=HSbe1sKNb+4SYjTyGk/xp7noGMiAqQ7W2ezk+vVryu4FTIk1DBhsVTBP91xzZX0h7aYY1M
	xruaXPsnOnvKwjwKw9mF+196kBZBKdPqQ+fB9l/b8HEXq1GjQT9shvoN2Fgx5Vq+CGFQWp
	rnD/OPGAi3i595oKRaKIdssaGHVK8sk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-ozi7IawWMp-laDMje7PXUA-1; Mon, 25 Oct 2021 09:46:48 -0400
X-MC-Unique: ozi7IawWMp-laDMje7PXUA-1
Received: by mail-wr1-f72.google.com with SMTP id u15-20020a5d514f000000b001687ebddea3so1747531wrt.8
        for <mptcp@lists.linux.dev>; Mon, 25 Oct 2021 06:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=hREwVADpgUJNwEBnFYI2/5NVZabsGbBtzHEjCiW+DTc=;
        b=ivQQWyNJCrCMSP7/l4A7nEcFuGCTN/6cu5nNG4CFAqhatOo1mDbKoITUKUbmgXbRl8
         854qCebb+i5j6Mgn4StXH4iQxFKIZK/txJxG2oUArnZxJZbY3KMUQNzTgu05tsek3oiN
         CntlGvF/Q/c8KUBDSYHxtAYKIm/ZMPIhU01y+oyLdxErtJ8V294dGzhG2RggKN1gxcCi
         70XUA57EeWVbx30OzEzoz7lL3oC0rcbArwboAY/+VdDHv2DznPZeo9jLoDsTYfZ+idmo
         2n/Ov1lR3NsRel7f3TKEpbsxO6om7oFZxt6I1vS8sdqBlZeL2wC/cDgcjmIlXVdrU2Pz
         sJvw==
X-Gm-Message-State: AOAM532G6gkn4SiZROEf+YyJ4g7KiEZkkBk3veeu47Y4tE8Oo0GRPs7h
	gyY85JzbR7MgXmTgKzrQv7zrV4Q3NpZ8zIdknW7XEPlH+k35KhAVLdpVp0hqSt08Uch6TF1N7PQ
	utjTSj8RATErzH0k=
X-Received: by 2002:a05:600c:3581:: with SMTP id p1mr3281222wmq.88.1635169606516;
        Mon, 25 Oct 2021 06:46:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9R1zrACCre+LC56TRf102rz7DFlWWQ5MkHZkXqvnh9KS6JuvqNdLyoh/c4BnQV/Ck1aq+Jw==
X-Received: by 2002:a05:600c:3581:: with SMTP id p1mr3281190wmq.88.1635169606073;
        Mon, 25 Oct 2021 06:46:46 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-240-164.dyn.eolo.it. [146.241.240.164])
        by smtp.gmail.com with ESMTPSA id f7sm15349962wmg.14.2021.10.25.06.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 06:46:45 -0700 (PDT)
Message-ID: <049cc3893767d00b4511aafb8acb191dea7aaca8.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] mptcp: enforce HoL-blocking estimation
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp <mptcp@lists.linux.dev>
Date: Mon, 25 Oct 2021 15:46:44 +0200
In-Reply-To: <6e3468c2-8e61-a05b-8cd1-4656e9217fcc@linux.intel.com>
References: <22cda018a37459d99683e572e35ac61bbc43fcae.1634900440.git.pabeni@redhat.com>
	 <6e3468c2-8e61-a05b-8cd1-4656e9217fcc@linux.intel.com>
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

On Fri, 2021-10-22 at 18:19 -0700, Mat Martineau wrote:
> On Fri, 22 Oct 2021, Paolo Abeni wrote:
> 
> > The MPTCP packet scheduler has sub-optimal behavior with asymmetric
> > subflows: if the faster subflow-level cwin is closed, the packet
> > scheduler can enqueue "too much" data on a slower subflow.
> > 
> > When all the data on the faster subflow is acked, if the mptcp-level
> > cwin is closed, and link utilization becomes suboptimal.
> > 
> > The solution is implementing blest-like[1] HoL-blocking estimation,
> > transmitting only on the subflow with the shorter estimated time to
> > flush the queued memory. If such subflows cwin is closed, we wait
> > even if other subflows are available.
> > 
> > This is quite simpler than the original blest implementation, as we
> > leverage the pacing rate provided by the TCP socket. To get a more
> > accurate estimation for the subflow linger-time, we maintain a
> > per-subflow weighted average of such info.
> > 
> > Additionally drop magic numbers usage in favor of newly defined
> > macros.
> > 
> > [1] http://dl.ifip.org/db/conf/networking/networking2016/1570234725.pdf
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > notes:
> > - this apparently solves for good issue/137, with > 200 iterations with
> > no failures
> > - still to be investigated the impact on high-speed links, if any
> > ---
> > net/mptcp/protocol.c | 58 ++++++++++++++++++++++++++++++--------------
> > net/mptcp/protocol.h |  1 +
> > 2 files changed, 41 insertions(+), 18 deletions(-)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 7803b0dbb1be..cc9d32cb7bc7 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -1395,20 +1395,24 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
> > 	return __mptcp_subflow_active(subflow);
> > }
> > 
> > +#define SSK_MODE_ACTIVE	0
> > +#define SSK_MODE_BACKUP	1
> > +#define SSK_MODE_MAX	2
> > +
> > /* implement the mptcp packet scheduler;
> >  * returns the subflow that will transmit the next DSS
> >  * additionally updates the rtx timeout
> >  */
> > static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> > {
> > -	struct subflow_send_info send_info[2];
> > +	struct subflow_send_info send_info[SSK_MODE_MAX];
> > 	struct mptcp_subflow_context *subflow;
> > 	struct sock *sk = (struct sock *)msk;
> > +	u32 pace, burst, wmem;
> > 	int i, nr_active = 0;
> > 	struct sock *ssk;
> > 	long tout = 0;
> > 	u64 ratio;
> > -	u32 pace;
> > 
> > 	sock_owned_by_me(sk);
> > 
> > @@ -1427,10 +1431,11 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> > 	}
> > 
> > 	/* pick the subflow with the lower wmem/wspace ratio */
> > -	for (i = 0; i < 2; ++i) {
> > +	for (i = 0; i < SSK_MODE_MAX; ++i) {
> > 		send_info[i].ssk = NULL;
> > 		send_info[i].ratio = -1;
> > 	}
> > +
> > 	mptcp_for_each_subflow(msk, subflow) {
> > 		trace_mptcp_subflow_get_send(subflow);
> > 		ssk =  mptcp_subflow_tcp_sock(subflow);
> > @@ -1439,12 +1444,13 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> > 
> > 		tout = max(tout, mptcp_timeout_from_subflow(subflow));
> > 		nr_active += !subflow->backup;
> > -		if (!sk_stream_memory_free(subflow->tcp_sock) || !tcp_sk(ssk)->snd_wnd)
> > -			continue;
> > -
> > -		pace = READ_ONCE(ssk->sk_pacing_rate);
> > -		if (!pace)
> > -			continue;
> > +		pace = subflow->avg_pacing_rate;
> > +		if (unlikely(!pace)) {
> > +			/* init pacing rate from socket */
> > +			pace = subflow->avg_pacing_rate = READ_ONCE(ssk->sk_pacing_rate);
> 
> Checkpatch complains about the double assignment. I did do a double-take 
> to confirm that it didn't look like a '==' typo, and slightly lean toward 
> keeping it checkpatch-clean.

Yep, I'll fix the above in v2.

> > +			if (!pace)
> > +				continue;
> > +		}
> > 
> > 		ratio = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32,
> > 				pace);
> > @@ -1457,16 +1463,32 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
> > 
> > 	/* pick the best backup if no other subflow is active */
> > 	if (!nr_active)
> > -		send_info[0].ssk = send_info[1].ssk;
> > -
> > -	if (send_info[0].ssk) {
> > -		msk->last_snd = send_info[0].ssk;
> > -		msk->snd_burst = min_t(int, MPTCP_SEND_BURST_SIZE,
> > -				       tcp_sk(msk->last_snd)->snd_wnd);
> > -		return msk->last_snd;
> > -	}
> > +		send_info[SSK_MODE_ACTIVE].ssk = send_info[SSK_MODE_BACKUP].ssk;
> > +
> > +	/* According to the blest algorithm, to avoid HoL blocking for the
> > +	 * faster flow, we need to:
> > +	 * - estimate the faster flow linger time
> > +	 * - use the above to estimate the amount of byte transferred
> > +	 *   by the faster flow
> > +	 * - check that the amount of queued data is greter than the above,
> > +	 *   otherwise do not use the picked, slower, subflow
> > +	 * We select the subflow with the shorter estimated time to flush
> > +	 * the queued mem, which basically ensure the above. We just need
> > +	 * to check that subflow has a non empty cwin.
> > +	 */
> > +	ssk = send_info[SSK_MODE_ACTIVE].ssk;
> > +	if (!ssk || !sk_stream_memory_free(ssk) || !tcp_sk(ssk)->snd_wnd)
> > +		return NULL;
> > 
> > -	return NULL;
> > +	burst = min_t(int, MPTCP_SEND_BURST_SIZE, tcp_sk(ssk)->snd_wnd);
> > +	wmem = READ_ONCE(ssk->sk_wmem_queued);
> > +	subflow = mptcp_subflow_ctx(ssk);
> > +	subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
> > +					   READ_ONCE(ssk->sk_pacing_rate) * burst,
> > +					   burst + wmem);
> 
> I see how this gives a smoothed-out version of the pacing rate, using 
> avg_pacing_rate for the bytes already sent on this subflow (wmem) and 
> ssk->sk_pacing_rate for the bytes that will probably be sent now.
> 
> Is this a *better* estimation of the flow speed than the plain 
> ssk->sk_pacing_rate?

It looks like it is. I get a consistent (higher) failure rate using
plain sk_pacing_rate instead. 'sk_pacing_rate' is an 'instant' value
applied to the current pkt, can change in a relevant way in a little
amount of time.

AFAIK, the weighted average above is a good approximation of what
happens: TCP assigns to each packet a minimum departure time dependant
on the current rate. That departure time is then enforced by the tc
scheduler. Even if the available b/w changes (increases) in-between,
the packet will still respect the departure (rate) constraint.

> If there is a change in speed, it will be slow to 
> respond to throughput changes. I think you could remove avg_pacing_rate 
> modifications and include the expected burst length in the calculation 
> earlier (in the mptcp_for_each_subflow() loop) to implement the blest-like 
> behavior. Maybe rename subflow_send_info.ratio to 
> subflow_send_info.time_to_flush.
> 
> What do you think?

Field rename will make the code more readable, agreed!

I'm unsure I follow the other part correctly ?!? Do you mean replacing:

	ratio = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32, subflow->avg_pacing_rate);

with:

	ratio = div_u64((u64)(READ_ONCE(ssk->sk_wmem_queued) + burst) << 32, ssk->sk_pacing_rate);

?

In my experiments, adding 'burst' to the first expression, does not
change the results at all, while replacing the average pacing with
sk_pacing_rate causes a relevant failure rate increases.

I'm reasonably sure the above change will not be for the better.

Cheers,

Paolo

