Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BB2168
	for <mptcp@lists.linux.dev>; Tue, 14 Dec 2021 15:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1639496236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZenNBKaA3EXlAZACrsaxBJM+XmWv8iireuypH4fyszk=;
	b=FDGQKnuBg59ksrp1uK3quZ9EHrrGeFo0x2LiccWcnSoMaDaTKTqpSPstOU6Tdm4lXxzhVk
	s7+ZrVkfnhF3bdf01xaIO8px5b0C6saV5NH+sznECCDeP6q9qSxpLisiZpjL4Ws1G9Ntyz
	4wKFaecvVmNJFetoqymKxRreNVHD8Tc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-uaKp_yihNdWcWWMVfhzmrQ-1; Tue, 14 Dec 2021 10:37:15 -0500
X-MC-Unique: uaKp_yihNdWcWWMVfhzmrQ-1
Received: by mail-wm1-f69.google.com with SMTP id 201-20020a1c04d2000000b003335bf8075fso11474165wme.0
        for <mptcp@lists.linux.dev>; Tue, 14 Dec 2021 07:37:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ZenNBKaA3EXlAZACrsaxBJM+XmWv8iireuypH4fyszk=;
        b=Lsnkdm5rSUlkuWPd3O+g2w8SJjJrCRYphcx9R3qzY7WjwtqSQpCvjNlC7YqFcezGip
         AewiRaDRv1ys99sXejeIaD2SouuYUnhLUkwqD0HcnT6PFZxJWdA5UAuDjIoyBYHYeUjI
         9kUZtNrWCF+BcEfhkpRMFLB4DsIjPpBjoXkI9Fgd245l1VIZhtMKCWKNB60bYOUU+UOf
         l3fhtBubwrqyPKBSj41x/8LDar/rwJiNmcpBdAU51NEzjlfCpAAcbnJ6JnUEJph1aXRP
         D9vWstx8sP53/fdFA6sCRD5ASDLMo7enZG4bVQK2b+ZNGE2PSo/bcQ93/cNcekTR93ar
         NMvA==
X-Gm-Message-State: AOAM531nhqmnlCDLWjhDVA6Y9hkatl0TE+zHWKRki5TrvHlbnxPBdM7d
	lMPUPq+USmyaDwAvFFUmVkeOp0eoaJJ+8RTIcBAAo48e3He1HF6+unJfvFa0l2tcWwvOlovGi50
	0JxpiiMMD996V6rs=
X-Received: by 2002:a7b:ce96:: with SMTP id q22mr47441000wmj.9.1639496234235;
        Tue, 14 Dec 2021 07:37:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxyOY1rOkZxae9kWvsPmEjAfiz7xAgWDjJ8c+Er9Ohrh9tar9UYrOfRbbT1uJBkFtpWOj9n2w==
X-Received: by 2002:a7b:ce96:: with SMTP id q22mr47440974wmj.9.1639496233993;
        Tue, 14 Dec 2021 07:37:13 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-237-50.dyn.eolo.it. [146.241.237.50])
        by smtp.gmail.com with ESMTPSA id x13sm223734wrr.47.2021.12.14.07.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 07:37:13 -0800 (PST)
Message-ID: <5396a93fbcc6e8d2f3b9ff6681956401fad06cd3.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v5 4/5] mptcp: do not block subflows creation
 on errors
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Tue, 14 Dec 2021 16:37:12 +0100
In-Reply-To: <85360ad-80da-1bfc-6d68-31f8407467c0@linux.intel.com>
References: <cover.1639070864.git.pabeni@redhat.com>
	 <9b71adc2d81f4eff820862dfcd3ba32d31ac520b.1639070864.git.pabeni@redhat.com>
	 <85360ad-80da-1bfc-6d68-31f8407467c0@linux.intel.com>
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35)
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

On Mon, 2021-12-13 at 15:10 -0800, Mat Martineau wrote:
> On Thu, 9 Dec 2021, Paolo Abeni wrote:
> 
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
> > v3 -> v4:
> > - fix 'subflows' underflow
> > 
> > v2 -> v3:
> > - fix compile warning (CI)
> > 
> > v1 -> v2:
> > - explicitly hook on subflow close instead of error notification
> > - fix checkpatch issue (Mat)
> > - introduce and use a new pm helper to cope with subflow close
> > - update pm subflow counters on close
> > ---
> > net/mptcp/options.c    | 21 ++++++++++++++++++---
> > net/mptcp/pm.c         | 23 +++++++++++++++++++++--
> > net/mptcp/pm_netlink.c | 20 ++++++++++++--------
> > net/mptcp/protocol.c   |  6 ++++++
> > net/mptcp/protocol.h   |  5 ++++-
> > net/mptcp/subflow.c    |  5 ++++-
> > 6 files changed, 65 insertions(+), 15 deletions(-)
> > 
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index 7a6a39b71633..00a8697addcd 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -1257,10 +1257,10 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
> > void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> > 			 struct mptcp_out_options *opts)
> > {
> > -	if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
> > -		const struct sock *ssk = (const struct sock *)tp;
> > -		struct mptcp_subflow_context *subflow;
> > +	const struct sock *ssk = (const struct sock *)tp;
> > +	struct mptcp_subflow_context *subflow;
> > 
> > +	if (unlikely(OPTION_MPTCP_FAIL & opts->suboptions)) {
> > 		subflow = mptcp_subflow_ctx(ssk);
> > 		subflow->send_mp_fail = 0;
> > 
> > @@ -1382,6 +1382,21 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> > 		/* MPC is additionally mutually exclusive with MP_PRIO */
> > 		goto mp_capable_done;
> > 	} else if (OPTIONS_MPTCP_MPJ & opts->suboptions) {
> > +		if (ssk) {
> > +			/* we are still in the MPJ handshake and "a lot" of time passed
> > +			 * e.g. due to syn retranmissions. We can attempt next
> > +			 * subflow creation
> > +			 */
> > +			subflow = mptcp_subflow_ctx(ssk);
> > +			if (subflow->start_stamp &&
> > +			    unlikely(after(tcp_jiffies32, subflow->start_stamp + HZ / 10))) {
> > +				mptcp_pm_subflow_check_next(mptcp_sk(subflow->conn), ssk, subflow);
> > +
> > +				/* avoid triggering the PM multiple times due to timeout */
> > +				subflow->start_stamp = 0;
> > +			}
> > +		}
> > +
> 
> tcp_options_write() and the various helpers it calls are (so far) free 
> from side effects and locking, and I don't think we want to introduce 
> those now (__tcp_transmit_skb() seems like a sensitive code path to tinker 
> with, even if it is only in this narrow case for packets with MPJ 
> suboptions).
> 
> The msk sk_timer seems well-suited for this? I think we're only using it 
> at disconnect time so there shouldn't be conflicts. What do you think?

I really prefer to avoid using another timer.

I'll try a different approach: creating all the subflows at once - as
per Matt suggestion - so that we will not need such hook at all.

Cheers,

Paolo

