Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8053168
	for <mptcp@lists.linux.dev>; Mon, 29 Nov 2021 14:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1638195893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3/3OP1n3mdbvgUBcuRX4g8PVuK75JYEJ53mNG8Bm2b8=;
	b=HkLJ+1Zb54ggv2sA+uGsVZXHpcrEegDtObGsM2tpevWsmJo4XEYHb23mVTgwBPJrpQEwW5
	VTrFpXFPOuzGub2hslmU/6k0luRpMMVghYWwHH7gAr+ICfEChbEHTwBHeC1rgC/53Ep5CD
	D2gYA7aXzTiv/bPZQRwoJ1ApM9bHZpo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-cp7uwUjqP1OT-liuDuvQbw-1; Mon, 29 Nov 2021 09:24:52 -0500
X-MC-Unique: cp7uwUjqP1OT-liuDuvQbw-1
Received: by mail-ed1-f71.google.com with SMTP id t9-20020aa7d709000000b003e83403a5cbso13888031edq.19
        for <mptcp@lists.linux.dev>; Mon, 29 Nov 2021 06:24:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3/3OP1n3mdbvgUBcuRX4g8PVuK75JYEJ53mNG8Bm2b8=;
        b=31Fl4NHRJ8sTFC32mRHUpr3kaORJ800lftDtFjGmfWJck5s4ELeu2VNEIjMemCSipr
         HWZX4Obhw2Zs2ykRz+AJ2qH9NA8EIstJHkKt+kFBG8Nkt4DGjU7KnLsCn28FXEYOFVJo
         pq0ogPXhULTHAkIkrHxLtSpGQ8MQfCDJGl9okOWeb801p1b+bnpXOPvPgJvHgfftsSRw
         dHlaTTOgzp4OuSyE8p7mZfyCi9JyL6oDWe1Pr0cR7Zt7IHCX+HJ/TNBTS5+6+67P59e5
         ELr/iZ0fe9d2+yKrTfkLjZKFsNDJYY6MtCfKnIqDO9Qg41/dB8CFmGuBmSrgXbRzXuz/
         E8VA==
X-Gm-Message-State: AOAM531MCIbf2CkPyl6o+M7U9F4El8EurBQNK7ntOHAeR1s47TT9/D4G
	3Zy7SiFDIf0hnh7ZSHhW6R6UHLgJWuLIlMV0FDFJNQUp/A13CIaGnjerTIVNKNvK1YaryiYd15+
	ey317GmULajMRtZU=
X-Received: by 2002:a05:6402:5194:: with SMTP id q20mr74958330edd.123.1638195891016;
        Mon, 29 Nov 2021 06:24:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxg6KzJnFp/RCcEI5GSfkBWxsp7u9VCPOhi10etC3/kGS53vq3+OXMvYHnWSZrCVQxUEwlb5g==
X-Received: by 2002:a05:6402:5194:: with SMTP id q20mr74958289edd.123.1638195890693;
        Mon, 29 Nov 2021 06:24:50 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-97-140.dyn.eolo.it. [146.241.97.140])
        by smtp.gmail.com with ESMTPSA id o8sm10128319edc.25.2021.11.29.06.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 06:24:50 -0800 (PST)
Message-ID: <aaaf9a30a1ffa9d00704c5f36cdedc1e4dd51684.camel@redhat.com>
Subject: Re: [PATCH v2 mptcp-next 3/4] mptcp: do not block subflows creation
 on errors
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Date: Mon, 29 Nov 2021 15:24:49 +0100
In-Reply-To: <cd1448c5-1fa6-7721-7685-c8d580684ebb@tessares.net>
References: <cover.1637929034.git.pabeni@redhat.com>
	 <7eaa67c01eb780dacbbac368004d2306a7981e09.1637929034.git.pabeni@redhat.com>
	 <cd1448c5-1fa6-7721-7685-c8d580684ebb@tessares.net>
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35)
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

On Fri, 2021-11-26 at 18:53 +0100, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 26/11/2021 13:19, Paolo Abeni wrote:
> > If the MPTCP configuration allows for multiple subflows
> > creation, and the first additional subflows never reach
> > the fully established status - e.g. due to packets drop or
> > reset - the in kernel path manager do not move to the
> > next subflow.
> > 
> > This patch introduces a new PM helper to cope with MPJ
> > subflow creation failure and delay and hook it where appropriate.
> > 
> > Such helper triggers additional subflow creation, as needed
> > and updates the PM subflow counter, if the current one is
> > closing.
> > 
> > Note that we don't need an additional timer to catch timeout
> > and/or long delay in connection completion: we just need to
> > measure the time elapsed since the subflow creation every
> > time we emit an MPJ sub-option.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > v2 -> v3:
> >  - fix compile warning (CI)
> > 
> > v1 -> v2:
> >  - explicitly hook on subflow close instead of error notification
> >  - fix checkpatch issue (Mat)
> 
> (+t :-P )
> 
> >  - introduce and use a new pm helper to cope with subflow close
> >  - update pm subflow counters on close
> 
> Thank you for the new version!
> 
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index 7a6a39b71633..00a8697addcd 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -1382,6 +1382,21 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> >  		/* MPC is additionally mutually exclusive with MP_PRIO */
> >  		goto mp_capable_done;
> >  	} else if (OPTIONS_MPTCP_MPJ & opts->suboptions) {
> > +		if (ssk) {
> > +			/* we are still in the MPJ handshake and "a lot" of time passed
> > +			 * e.g. due to syn retranmissions. We can attempt next
> > +			 * subflow creation
> > +			 */
> > +			subflow = mptcp_subflow_ctx(ssk);
> > +			if (subflow->start_stamp &&
> > +			    unlikely(after(tcp_jiffies32, subflow->start_stamp + HZ / 10))) {
> 
> As discussed at the last meeting, we will reach this code path when
> retransmitting the SYN, one second after having sent the initial one. In
> this case, we might not need to keep 'start_stamp'.
> 
> But we can improve that in a new version after.
> 
> > +				mptcp_pm_subflow_check_next(mptcp_sk(subflow->conn), ssk, subflow);
> > +
> > +				/* avoid triggering the PM multiple times due to timeout */
> > +				subflow->start_stamp = 0;
> > +			}
> > +		}
> > +
> >  		if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
> >  			*ptr++ = mptcp_option(MPTCPOPT_MP_JOIN,
> >  					      TCPOLEN_MPTCP_MPJ_SYN,
> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index 1ff856dd92c4..df8a596cd3ff 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -172,9 +172,32 @@ void mptcp_pm_subflow_established(struct mptcp_sock *msk)
> >  	spin_unlock_bh(&pm->lock);
> >  }
> >  
> > -void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id)
> > +void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
> > +				 const struct mptcp_subflow_context *subflow)
> 
> Detail: do we need to pass the 'msk'? Can we not get it from 'subflow'?

The caler has the msk handy, passing it to the helper keeps the args
list similar to other releated helpers and avoid some more dup code.

> >  {
> > -	pr_debug("msk=%p", msk);
> > +	struct mptcp_pm_data *pm = &msk->pm;
> > +	bool closed;
> > +
> > +	closed = ssk->sk_state == TCP_CLOSE;
> > +	if (subflow->fully_established && !closed)
> > +		return;
> > +
> > +	spin_lock_bh(&pm->lock);
> > +	if (closed) {
> > +		pm->local_addr_used--;
> > +		pm->subflows--;
> > +		/* do not enable the pm worker: we don't want to pick again
> > +		 * the just closed subflow
> > +		 */
> > +	}
> > +
> > +	/* Even if this subflow is not really established, tell the PM to try
> > +	 * to pick the next one, if possible.
> > +	 */
> > +	if (pm->work_pending)
> 
> Does it not need to be "protected" with a READ_ONCE?

AFAIK not needed: this is the only read issued on such field in this
scope and and is done under the relevant lock (all write operation
occours under the pm lock).

> > +		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
> > +
> > +	spin_unlock_bh(&pm->lock);
> >  }
> >  
> >  void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
> 
> (not related to this line)
> 
> Did you see that the "fastclose" packetdrill tests are failing? Is it
> due to these modifications?

uhm... I haven't check them. I'll have a look soon.

Thanks!

Paolo

