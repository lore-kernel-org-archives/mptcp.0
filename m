Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E48621
	for <mptcp@lists.linux.dev>; Fri,  6 May 2022 08:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1651826373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ScSUA/M7xuC+gRwD7uypd3Wv74WAK8h4t99QLYvovSU=;
	b=TwEbyWMviOBoWrVAgwLmwzUxmSC6Nnpt0Jvb6RrcG7EdoE4EXizy+L7oC1IZVPj/RoFZh2
	iHibJIw+aQE0f84ffUAAAjSgejbbg4QB8RktDe6VPMWPAE4AMyTWDpPTyuFyJmcdd8q+Ny
	QpQFOaJX8ymyGV6ZdrOnsL6lbgA3fuU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-tDysvH5KPmyGR4UfGGcqFQ-1; Fri, 06 May 2022 04:39:32 -0400
X-MC-Unique: tDysvH5KPmyGR4UfGGcqFQ-1
Received: by mail-ej1-f71.google.com with SMTP id qa15-20020a170907868f00b006f4c89bf2e3so3845561ejc.9
        for <mptcp@lists.linux.dev>; Fri, 06 May 2022 01:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ScSUA/M7xuC+gRwD7uypd3Wv74WAK8h4t99QLYvovSU=;
        b=uJ1lEGnicM2cj+IGT6v2FOfuTxrRHcAaRKiNN+iiDAh541B25jv7tZdHV5q45BI3rT
         4JBJo26z40rzOLVngA7CzMOFamkG7Lkc5KG7PdBMvChG2Mi1jl4uVvbGuUzNpW1CqidA
         juizyfYxFoKxNpuaf2ZFwwd8m/ZRbKKb6FrX0j93QEThRrNHQ5Dw1go/ZlExOyeSfxmF
         6+bj3UWFRPy6qFL1ePnCy2iR9Gptbp8B54eqizdqEY/7vWJSF/Sz/o4W1sAlaHbs7fF5
         sPLrAtYFPqKLVhuPfWZzYRLvFDxZyHi+xNs7qxX/r8mye/Nno5R+keUMJ22QTgEmNXEE
         2Ltg==
X-Gm-Message-State: AOAM532fsC+JnZIVe38k3G3AwvXn5sByO5utqxdocDnhAR8/Tu9xE3e5
	1waH2stypEgCPPq3HAoETkSTNb7SiTH+c9vQAK/zfd+0vfzTdT0RWm4oDD4sam8rt34cGUuAuwm
	Vr1mpqwzs/ttzCUw=
X-Received: by 2002:a05:6402:1e8d:b0:426:9:6ec with SMTP id f13-20020a0564021e8d00b00426000906ecmr2355299edf.55.1651826371104;
        Fri, 06 May 2022 01:39:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJypLm/5P5C9Piw1lxm4Ka6xZpMbF656MkYPulVvbL8mxmmKchQSb0ViAEO89AU7S/e6NHNA==
X-Received: by 2002:a05:6402:1e8d:b0:426:9:6ec with SMTP id f13-20020a0564021e8d00b00426000906ecmr2355284edf.55.1651826370794;
        Fri, 06 May 2022 01:39:30 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-115-66.dyn.eolo.it. [146.241.115.66])
        by smtp.gmail.com with ESMTPSA id i6-20020a17090685c600b006f3ef214dcfsm1617120ejy.53.2022.05.06.01.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 01:39:30 -0700 (PDT)
Message-ID: <09a0b0d4e22a1894088b221b32bc40df01cd7340.camel@redhat.com>
Subject: Re: [PATCH net] net/sched: act_pedit: really ensure the skb is
 writable
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Fri, 06 May 2022 10:39:29 +0200
In-Reply-To: <f81c6f47-3fe-1e9f-c260-31c68d32547c@linux.intel.com>
References: <dfcfe03e01c364599e92715828b24713d955e7c8.1651764848.git.pabeni@redhat.com>
	 <f81c6f47-3fe-1e9f-c260-31c68d32547c@linux.intel.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
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

On Thu, 2022-05-05 at 13:30 -0700, Mat Martineau wrote:
> On Thu, 5 May 2022, Paolo Abeni wrote:
> 
> > Currently pedit tries to ensure that the accessed skb offset
> > is writeble via skb_unclone(). The action potentially allows
> > touching any skb bytes, so it may end-up modifying shared data.
> > 
> > The above causes some sporadic MPTCP self-test failures.
> > 
> > Address the issue keeping track of a rough over-estimate highest skb
> > offset accessed by the action and ensure such offset is really
> > writable.
> > 
> > Note that this may cause performance regressions in some scenario,
> > but hopefully pedit is not critical path.
> > 
> > v1 -> v2:
> > - cleanup hint update (Jakub)
> > - avoid raices while accessing the hint (Jakub)
> > - re-organize the comments for clarity
> > 
> > Fixes: db2c24175d14 ("act_pedit: access skb->data safely")
> > Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> > Tested-by: Geliang Tang <geliang.tang@suse.com>
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > include/net/tc_act/tc_pedit.h |  1 +
> > net/sched/act_pedit.c         | 25 +++++++++++++++++++++----
> > 2 files changed, 22 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/net/tc_act/tc_pedit.h b/include/net/tc_act/tc_pedit.h
> > index 748cf87a4d7e..3e02709a1df6 100644
> > --- a/include/net/tc_act/tc_pedit.h
> > +++ b/include/net/tc_act/tc_pedit.h
> > @@ -14,6 +14,7 @@ struct tcf_pedit {
> > 	struct tc_action	common;
> > 	unsigned char		tcfp_nkeys;
> > 	unsigned char		tcfp_flags;
> > +	u32			tcfp_off_max_hint;
> > 	struct tc_pedit_key	*tcfp_keys;
> > 	struct tcf_pedit_key_ex	*tcfp_keys_ex;
> > };
> > diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> > index e01ef7f109f4..0fc07532e6f6 100644
> > --- a/net/sched/act_pedit.c
> > +++ b/net/sched/act_pedit.c
> > @@ -149,7 +149,7 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
> > 	struct nlattr *pattr;
> > 	struct tcf_pedit *p;
> > 	int ret = 0, err;
> > -	int ksize;
> > +	int i, ksize;
> > 	u32 index;
> > 
> > 	if (!nla) {
> > @@ -228,6 +228,18 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
> > 		p->tcfp_nkeys = parm->nkeys;
> > 	}
> > 	memcpy(p->tcfp_keys, parm->keys, ksize);
> > +	p->tcfp_off_max_hint = 0;
> > +	for (i = 0; i < p->tcfp_nkeys; ++i) {
> > +		u32 cur = p->tcfp_keys[i].off;
> > +
> > +		/* The AT option can read a single byte, we can bound the actual
> > +		 * value with uchar max.
> > +		 */
> > +		cur += (0xff & p->tcfp_keys[i].offmask) >> p->tcfp_keys[i].shift;
> > +
> > +		/* Each key touches 4 bytes starting from the computed offset */
> > +		p->tcfp_off_max_hint = max(p->tcfp_off_max_hint, cur + 4);
> > +	}
> > 
> > 	p->tcfp_flags = parm->flags;
> > 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
> > @@ -308,13 +320,18 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
> > 			 struct tcf_result *res)
> > {
> > 	struct tcf_pedit *p = to_pedit(a);
> > +	u32 max_offset;
> > 	int i;
> > 
> > -	if (skb_unclone(skb, GFP_ATOMIC))
> > -		return p->tcf_action;
> > -
> > 	spin_lock(&p->tcf_lock);
> > 
> > +	max_offset = (skb_transport_header_was_set(skb) ?
> > +		      skb_transport_offset(skb) :
> > +		      skb_network_offset(skb)) +
> > +		     p->tcfp_off_max_hint;
> > +	if (skb_ensure_writable(skb, min(skb->len, max_offset)))
> > +		return p->tcf_action;
> 
> Now that this hunk of code happens after the spinlock is acquired, that 
> lock needs to be released before returning.

Oh my! I really should take more care. Thank you for catching it!

I'll send a v3.

/P

