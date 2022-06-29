Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFDD7B
	for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 10:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656497451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=my0bCgM8u/FW/vPx+A6bENJbiLzM97GLcBiHKZrvm34=;
	b=fw35MJJOneueEIydlPG2KCUTQuiDXrzfMc5xJ15lK0ZRlBEr5cRFxrmnOyuTI4BZcPaa8v
	HIfAI1G8kx9qGZM4gIvICEll8qYSKEVC1Y0lNpO2aWQ9OEvDOzj6haBaLbXd0wsge2acgs
	UPjqPR+8okwfUFR+f2ilCH2lIuIfHiI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-lEBK74XZOFWzDl0JJYTaQg-1; Wed, 29 Jun 2022 06:10:49 -0400
X-MC-Unique: lEBK74XZOFWzDl0JJYTaQg-1
Received: by mail-qk1-f199.google.com with SMTP id w16-20020a376210000000b006af059b17b7so15011804qkb.12
        for <mptcp@lists.linux.dev>; Wed, 29 Jun 2022 03:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=my0bCgM8u/FW/vPx+A6bENJbiLzM97GLcBiHKZrvm34=;
        b=T+2oDhmsEKEAvFGzvrGjd0ASK2+epjTfVxMj/ZCz2wfk5WKNf5b7cLnGExsEQbzFLh
         BhEQ6Uq1LeUHZSqnX/LZAF+wbgCGuALdDk4bJjMhkIADI+OSm9UOH1tlOw9ufWqS7hxU
         Y4a6uVok6cHnaI4AVOL4qppLBT9RasMeKw9IopScSezNq20SvwtCwsbftYShjEnf1nqm
         jrKUryC/FmqjgOoOMqQKGsMR7yqH1s8m50OMcVGydB8Jnmvr3s5ktzhLfnE/Jpx2RCy4
         rcSnrJft+kjKFoFZuY7oZJ844LkyMIaaITcl2RXw5CnkZDeLeKLkWw2Wg9quBKZ2IlKS
         0lEQ==
X-Gm-Message-State: AJIora/stSoY1WWUkKOej52uqGBEbwf1+Aw9Qr4eTQtOcs1zTHS/YcPP
	W0rrT8nwfQLRXm8Be5FQ6EHQuU5NVf5iemnglViSbwarjfe7JPoMk87cYQt+Yr4oNs31eBk8KA0
	PyjjMLlbyuxCppqI=
X-Received: by 2002:a0c:90e4:0:b0:470:2bd2:3a02 with SMTP id p91-20020a0c90e4000000b004702bd23a02mr5794292qvp.30.1656497448886;
        Wed, 29 Jun 2022 03:10:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tBid0RvllBLZsqOaBUO10qGyLeCcJ855OO7ma8QpW1pqgRa5thKAkPVndDL474CxBlCrw6dA==
X-Received: by 2002:a0c:90e4:0:b0:470:2bd2:3a02 with SMTP id p91-20020a0c90e4000000b004702bd23a02mr5794275qvp.30.1656497448531;
        Wed, 29 Jun 2022 03:10:48 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-106-148.dyn.eolo.it. [146.241.106.148])
        by smtp.gmail.com with ESMTPSA id f10-20020a05620a280a00b006a69d7f390csm12950423qkp.103.2022.06.29.03.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 03:10:47 -0700 (PDT)
Message-ID: <6693bf191808b3089a01b60bfaa350e551c62bc5.camel@redhat.com>
Subject: Re: [PATCH RFC 2/4]  mptcp: introduce and use mptcp_pm_send_ack()
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Wed, 29 Jun 2022 12:10:42 +0200
In-Reply-To: <12f7b059-d6c8-cd75-1e1-33abe8b2b8fd@linux.intel.com>
References: <cover.1656088406.git.pabeni@redhat.com>
	 <a59c3eb1e47c5c32f97c87d66c52f6c0021846bc.1656088406.git.pabeni@redhat.com>
	 <12f7b059-d6c8-cd75-1e1-33abe8b2b8fd@linux.intel.com>
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

On Tue, 2022-06-28 at 16:28 -0700, Mat Martineau wrote:
> On Fri, 24 Jun 2022, Paolo Abeni wrote:
> 
> > The in-kernel PM has a bit of duplicate code related to ack
> > generation. Create a new helper factoring out the PM-specific
> > needs and use it in a couple of places.
> > 
> > Note that this additionally moves a few unsafe subflow socket
> > access under the relevant socket lock.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > net/mptcp/pm_netlink.c | 45 ++++++++++++++++++++++++------------------
> > net/mptcp/protocol.c   | 11 ++++++++---
> > net/mptcp/protocol.h   |  2 +-
> > 3 files changed, 35 insertions(+), 23 deletions(-)
> > 
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index 2b2bb3599781..91f6ed2a076a 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -463,6 +463,29 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullm
> > 	return i;
> > }
> > 
> > +static void mptcp_pm_send_ack(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
> > +			      bool prio, bool backup)
> > +{
> > +	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> > +	bool slow;
> > +
> > +	spin_unlock_bh(&msk->pm.lock);
> > +	pr_debug("send ack for %s",
> > +		 prio ? "mp_prio" : (mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr"));
> > +
> > +	slow = lock_sock_fast(ssk);
> > +	if (prio) {
> > +		subflow->send_mp_prio = 1;
> > +		subflow->backup = backup;
> > +		subflow->request_bkup = backup;
> > +	}
> > +
> > +	__mptcp_subflow_send_ack(ssk);
> > +	unlock_sock_fast(ssk, slow);
> > +
> > +	spin_lock_bh(&msk->pm.lock);
> > +}
> 
> I was short on time yesterday so I delayed reviewing this RFC series... 
> Instead I spent time working on the "Locking fixes for subflow flag 
> changes" series which has very, very similar locking changes. MPTCP minds 
> think alike?

:)


> I guess the lesson is that I should always look at Paolo's pending patches 
> before trying to solve a "new" problem :)
> 
> In that other series, I remove the pm locking when sending this ack for 
> MP_PRIO - but I think this refactoring could still be helpful. The pm lock 
> could be released and reacquired by the caller instead of inside 
> mptcp_pm_send_ack().

LGTM! If you agree, I could rebase this series on top of "mptcp: Avoid
acquiring PM lock for subflow priority changes".


Thank!

Paolo

