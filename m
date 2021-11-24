Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB6368
	for <mptcp@lists.linux.dev>; Wed, 24 Nov 2021 10:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1637748597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/FZY09uhfF47R/gcD+WUBLc0xbe4aW6IlnjrZUnWiCA=;
	b=Y7+AczFcmvfu5I7PXoyy/ZBlhiQE1Q00y49NrX4neoQ1RSChpLLDK2cnDhwU+9Une53r3r
	ovgTmvEeUMu4YTskMbiQ1+UwCWwmnj43rEluUd52BpVyxZeFvA2cwvD+MWJJeM/ijH5hZ5
	2Pxi0EXXyULpPb/AzP/D3x53NUZGA2M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-FkX5vq6sMrOIpT1-88UqgA-1; Wed, 24 Nov 2021 05:09:56 -0500
X-MC-Unique: FkX5vq6sMrOIpT1-88UqgA-1
Received: by mail-wm1-f71.google.com with SMTP id l6-20020a05600c4f0600b0033321934a39so1132028wmq.9
        for <mptcp@lists.linux.dev>; Wed, 24 Nov 2021 02:09:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=/FZY09uhfF47R/gcD+WUBLc0xbe4aW6IlnjrZUnWiCA=;
        b=6DRU5wQFahbD/SzESvDWt5CI+tUOerozcAAWOOoGqCb2YbDEYKiGMEJxSdSLbrGZGi
         9w8rtoFjYKCBVBxJPydIwLwuPQAmT14IXh/H8dLdd+842SFNV0QYUr+2PhrrIupJy9CH
         U+/yr9la8trjchCnRm87Hbbj2AJqf+p/IU6kYnlxVC/F9RfSqN6FK63eAyRNxx97hErx
         dyVJ8k9azA2P9trwZtnXn67YnUvim5Z5ITuliA7oEilj78fna5J19C32/xNyNmlwKldP
         TDbzi8fXPrR7SrMFEUw7u5mma5Gcrnt4baCCHaY7pcHNYXSXQ5mD0gRuhmUXr2g3PKmW
         ECeA==
X-Gm-Message-State: AOAM530oy/PtHnIqGYLRYFAdd5p+lZFn10vv7lBjcfJIGWsFWVfwiCGR
	5zNXK6lbdzJL8MAdwNu8jfBVPOEObIMYUgfkRKt938HQ7OQtvFvkKHfN0vDKAk2odGxUJHiMEC5
	fgxVONxWGFzmWy5M=
X-Received: by 2002:adf:ea0a:: with SMTP id q10mr17171651wrm.1.1637748594952;
        Wed, 24 Nov 2021 02:09:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyjf8d4cJS09k6CjIx8xx7jHPKYVf8jVm7SBxJfkzbqB0GWyznYlyQgMZlKCJMLEkhMbNXx7Q==
X-Received: by 2002:adf:ea0a:: with SMTP id q10mr17171616wrm.1.1637748594690;
        Wed, 24 Nov 2021 02:09:54 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-229-135.dyn.eolo.it. [146.241.229.135])
        by smtp.gmail.com with ESMTPSA id q123sm3982975wma.30.2021.11.24.02.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 02:09:54 -0800 (PST)
Message-ID: <d6eb410eafef719adefb61bb584eef1e40c01184.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 2/3] mptcp: do not block subflows creation on
 errors
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Phil Greenland <phil@quantulum.co.uk>, mptcp@lists.linux.dev
Date: Wed, 24 Nov 2021 11:09:53 +0100
In-Reply-To: <39669a68-eb6f-6602-1469-886266346e48@tessares.net>
References: <cover.1637684792.git.pabeni@redhat.com>
	 <c080cc1785cbe3bb3c049a683f2cc6d55f95f17a.1637684792.git.pabeni@redhat.com>
	 <39669a68-eb6f-6602-1469-886266346e48@tessares.net>
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

On Wed, 2021-11-24 at 10:55 +0100, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 23/11/2021 17:37, Paolo Abeni wrote:
> > If the MPTCP configuration allows for multiple subflows
> > creation, and the first additional subflows never reach
> > the fully established status - e.g. due to packets drop or
> > reset - the in kernel path manager do not move to the
> > next subflow.
> 
> Thank you for looking at that!
> 
> Why the PM could not try to establish all possible paths "in parallel"?
> Is it because we have this limit of allowed subflows and we wait to know
> if a path is established to count it as used subflow?

IIRC, that design choice is to avoid that an MPTCP endpoint could
easily become a DDoS bot, generating "a lot" of syn in response to
action from possibly untrusted peer.

>  But if here we
> mark a path as established if it has an issue, does it still make sense?
> I probably missed something here :)

With this patch we don't mark the path as astablished, we try to pick
the next one. 

> > Let's trigger subflow creation on both the above event.
> > Note that we don't need an additional timer to catch timeout
> > and/or long delay in connection completion: we just need to
> > measure the time elapsed since the subflow creation every
> > time we emit an MPJ sub-option.
> 
> Just to be sure: can we do that because we always expect a retransmission?
> > @@ -1382,6 +1382,19 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> >  		/* MPC is additionally mutually exclusive with MP_PRIO */
> >  		goto mp_capable_done;
> >  	} else if (OPTIONS_MPTCP_MPJ & opts->suboptions) {
> > +		if (ssk) {
> > +			subflow = mptcp_subflow_ctx(ssk);
> > +			if (subflow->start_stamp &&
> > +			    unlikely(after(tcp_jiffies32, subflow->start_stamp + HZ/10))) {
> 
> Small detail: checkpatch asks to have space around "/". I can add them
> when applying the patch if only this needs to be modified.
> 
> > +				/* we are not established yet and "a lot" of time passed
> > +				 * e.g. due to syn retranmissions. We can attempt next
> > +				 * subflow creation
> 
> That's strange to tell the PM "yes, the subflow is established now"
> while there is potentially (or clearly in case of error (RST) below) an
> issue :)
> 
> Should we eventually have another function name doing the same and
> resetting the stamp variable?

Yes, in v2 I'll add another pm helper for that.

Side note: do we still need the pm -> pm_netlink additional layering?
That was initially introduced to allow multiple in-kernel PM, but
afaics we are now considering a single in kernel one and e.v. an user-
space one. Perhpas we can remove some intermediate abstraction?

(not in this series!)

> > +				 */
> > +				mptcp_pm_subflow_established(mptcp_sk(subflow->conn));
> > +				subflow->start_stamp = 0;
> > +			}
> > +		}
> > +
> >  		if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
> >  			*ptr++ = mptcp_option(MPTCPOPT_MP_JOIN,
> >  					      TCPOLEN_MPTCP_MPJ_SYN,
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 0f90bd61de01..85986f3b58ed 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -1273,7 +1273,16 @@ void __mptcp_error_report(struct sock *sk)
> >  
> >  static void subflow_error_report(struct sock *ssk)
> >  {
> > -	struct sock *sk = mptcp_subflow_ctx(ssk)->conn;
> > +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> > +	struct sock *sk = subflow->conn;
> > +
> > +	/* subflow aborted before reaching the fully_established status
> > +	 * attempt the creation of the next subflow
> > +	 */
> > +	if (unlikely(!subflow->fully_established && subflow->start_stamp)) {
> > +		mptcp_pm_subflow_established(mptcp_sk(sk));
> > +		subflow->start_stamp = 0;
> 
> Detail: do you need to set it to 0 here?

So we call mptcp_pm_subflow_established() at most once due to subflow
timeout or reset. I feared a malicius peer could trigger a lot of
activity with a e.g. a burst of icmp unreachable.

Thanks!

Paolo

