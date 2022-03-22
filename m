Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093B2C6A
	for <mptcp@lists.linux.dev>; Tue, 22 Mar 2022 14:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1647960418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xrsukYObwboNFMhTdcnAGVvPXHI5TCpGU4ZANXRAwm0=;
	b=KMGQc9RTQ+7S5DwRBODDXrlGtSs0p7pxr0SwDi5bC3QzXRZwuHeW4WOTipnXSaj4d6zMbI
	ichJxU9H0HjXScLVxUKYpgyhkihPE9uxxdrHJhysw7ByV7Eq3W31fMPdpYNw5Yz+0JG95Q
	8gBvZRRA3QYZdO0a2nxnZdY3EOcGkic=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-Nx4nSU9hMm2n5ChNsLHS_w-1; Tue, 22 Mar 2022 10:46:57 -0400
X-MC-Unique: Nx4nSU9hMm2n5ChNsLHS_w-1
Received: by mail-wm1-f72.google.com with SMTP id r9-20020a1c4409000000b0038c15a1ed8cso1441782wma.7
        for <mptcp@lists.linux.dev>; Tue, 22 Mar 2022 07:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=xrsukYObwboNFMhTdcnAGVvPXHI5TCpGU4ZANXRAwm0=;
        b=UB+W+EkbQKGgpxqI1Kj11m30XK/elQzrJrjk/xc4ig7HKjJu/sNCSoyZWdhEghYcv7
         vampcoYt4stvghfRN7IaCaaHCI6gjiBFZCRnP/1Go2IghTmnkREeEMInOkcy9SyZ/O8J
         suGBYNTVTxZ6SrqJ55nk3a5DdlxnAazfADyFL/vCKt+V8ys3YnChxeZUrldCj+EGYD4t
         D4fuaIAFvAW0iv6tvJMIp9GjJ/2o8pxZuXrsU9i0dMYFFHtHkaxbCTdh2ueNMiOe/MG6
         SgdueSoLJY4kINzydUUVqbXU3Ga8cA+Me0XcGK10EDIbD1MfkMSzXOchhxHYypO6vtRK
         Qonw==
X-Gm-Message-State: AOAM533b1G8RXvXuKNBT2oOJT1W2RCXtEOk8BFdp8gNfdZixQAr7IA2Z
	+cGIjYE/acCeOK13NIAK1mM/BDkIrpVm34NJ/N8N9PFERGV1H8EvSrCaetlzOEYr7qXYAhpQ5fs
	gofirDzgco1QCCAI=
X-Received: by 2002:a5d:464f:0:b0:203:e128:e with SMTP id j15-20020a5d464f000000b00203e128000emr22809967wrs.576.1647960416026;
        Tue, 22 Mar 2022 07:46:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxu6/JtzrvPz0ECImDMj0W8NZWf2D6D+onGOU2RvPprNyOx1oLbttg5QvVPAzDURFsnSoUeOA==
X-Received: by 2002:a5d:464f:0:b0:203:e128:e with SMTP id j15-20020a5d464f000000b00203e128000emr22809949wrs.576.1647960415763;
        Tue, 22 Mar 2022 07:46:55 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-135.dyn.eolo.it. [146.241.232.135])
        by smtp.gmail.com with ESMTPSA id z18-20020adfec92000000b00203f04ed4a8sm12258910wrn.13.2022.03.22.07.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 07:46:55 -0700 (PDT)
Message-ID: <dc6e488a53b154be3a37455babca0e60333787b5.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 2/3] mptcp: reset the packet scheduler on
 incoming MP_PRIO.
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Tue, 22 Mar 2022 15:46:54 +0100
In-Reply-To: <8e593068-fb24-252-6980-19aa9c4fe577@linux.intel.com>
References: <6fc1ea29ae85074d626ad1cef3fea34055de37f1.1647601548.git.pabeni@redhat.com>
	 <4982f05aedd915cdc486399696d8c5b492fd2d9a.1647601548.git.pabeni@redhat.com>
	 <8e593068-fb24-252-6980-19aa9c4fe577@linux.intel.com>
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35)
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

On Mon, 2022-03-21 at 17:21 -0700, Mat Martineau wrote:
> On Fri, 18 Mar 2022, Paolo Abeni wrote:
> 
> > When an incoming MP_PRIO option changes the backup
> > status of any subflow, we need to reset the packet
> > scheduler status, or the next send could keep using
> > the previously selected subflow, without taking in account
> > the new priorities.
> > 
> > Reported-by: Davide Caratti <dcaratti@redhat.com>
> > Fixes: 40453a5c61f4 ("mptcp: add the incoming MP_PRIO support")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > net/mptcp/pm.c       | 19 +++++++++++++++----
> > net/mptcp/protocol.c |  2 ++
> > net/mptcp/protocol.h |  1 +
> > 3 files changed, 18 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index d0d31d5c198a..2f6ee422c6df 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -262,14 +262,25 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
> > 	spin_unlock_bh(&pm->lock);
> > }
> > 
> > -void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
> > +void mptcp_pm_mp_prio_received(struct sock *ssk, u8 bkup)
> > {
> > -	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
> > +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> > +	struct sock *sk = subflow->conn;
> > +	struct mptcp_sock *msk;
> > 
> > 	pr_debug("subflow->backup=%d, bkup=%d\n", subflow->backup, bkup);
> > -	subflow->backup = bkup;
> > +	msk = mptcp_sk(sk);
> > +	if (subflow->backup == bkup) {
> 
> Above should be "if (subflow->backup != bkup)"?

Ouch, my bad! You are right, v2 is coming...

/P

