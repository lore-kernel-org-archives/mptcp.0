Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0667F6
	for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 10:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655722076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0uGDOt00v4cCkmo+/FitkulU03sBPSsF3sYucmlgAY4=;
	b=Qu7Js0m3uQ4y6dipFFPBT9x9BUMY4yBOBWOpDpUlzcBbifasKW1TaL7jx9uP6kSyLUuDIM
	WEML4AXqThrJ+nyCcAF5k/qpAf0J04FUHdvGafOfFMRDLAnspfuyM1+T3cN5MssWRwOyLP
	SS4FBEmeq9X1U5YV7QbH+qciznHJYhE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-4c6Fx39cMO6uSQ56gHaXzA-1; Mon, 20 Jun 2022 06:47:55 -0400
X-MC-Unique: 4c6Fx39cMO6uSQ56gHaXzA-1
Received: by mail-wm1-f72.google.com with SMTP id p6-20020a05600c358600b0039c873184b9so4870868wmq.4
        for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 03:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=0uGDOt00v4cCkmo+/FitkulU03sBPSsF3sYucmlgAY4=;
        b=LFNI2IlIsjMKyl0Meo4XhHEcr7TQIqvTLF0YgXLdNcL4Pn+KOaWJw83Z0y0BWuekb9
         wdijAASHxPI1SY6z32w+LZihQ0y+zKf5YfwIaXLp8iOrBlwSK3940PdBqQDn+hbxkXC1
         xkP1XilpRwsuViUtbyckPNTjecYPucEgGHeAUDMAb9lMmto0DRlUmtKOlLVs4AJtVcFG
         ig6+whoFN0TwnxBF70xrJViGU4RS7GwqQkMIlhB/kwyTunYvUVUjVU020JSXWnfXa725
         kch1Bx8g4+Gm7cf2tS5B8VWSXwbUbg73VYL22FyickBt6+rtcnQ8e2pQwqlnRYV0qwlc
         DC9Q==
X-Gm-Message-State: AJIora/l89BRPdbSZDXUJh067pxUxlIkgy2h+4CyD403soG01Zqms3CN
	ws6j3VrVCLp2qhoI47MGvOW24QDZpJ4x2HZLXJ/h7z9smCUM4xIiKik5l1VUw4RGBAL7kHOcqHp
	N6YJAlV+ENO/xsJg=
X-Received: by 2002:a5d:6d8f:0:b0:219:b5cd:6516 with SMTP id l15-20020a5d6d8f000000b00219b5cd6516mr22276309wrs.246.1655722073896;
        Mon, 20 Jun 2022 03:47:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s9+inGitEuL74RoQUUeFVTAy/LaYkSeUbCq2zwaVYcYwsTsHkk9C2MloblF1PJTxu0Vl/NTg==
X-Received: by 2002:a5d:6d8f:0:b0:219:b5cd:6516 with SMTP id l15-20020a5d6d8f000000b00219b5cd6516mr22276286wrs.246.1655722073633;
        Mon, 20 Jun 2022 03:47:53 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-202.dyn.eolo.it. [146.241.113.202])
        by smtp.gmail.com with ESMTPSA id k7-20020a7bc407000000b0039c747a1e8fsm20008295wmi.7.2022.06.20.03.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 03:47:53 -0700 (PDT)
Message-ID: <ba1862a2456f92b8a83ec00bec65a8208e8d44a4.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v3 6/6] mptcp: fix race on unaccepted mptcp
 sockets
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Mon, 20 Jun 2022 12:47:52 +0200
In-Reply-To: <54f723756f4b4da8827649b6c2f11187e93bf050.camel@redhat.com>
References: <cover.1655460262.git.pabeni@redhat.com>
	 <dd32766a57e98209da3257e9c68980a3b8727797.1655460262.git.pabeni@redhat.com>
	 <cae3fd3-d3f9-c57-8fe8-12c6a215e9fa@linux.intel.com>
	 <54f723756f4b4da8827649b6c2f11187e93bf050.camel@redhat.com>
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

On Mon, 2022-06-20 at 12:15 +0200, Paolo Abeni wrote:
> On Fri, 2022-06-17 at 17:51 -0700, Mat Martineau wrote:
> > On Fri, 17 Jun 2022, Paolo Abeni wrote:
> > > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > > index 1e182301e58b..db83db1b3c4c 100644
> > > --- a/net/mptcp/subflow.c
> > > +++ b/net/mptcp/subflow.c
> > > @@ -1723,6 +1723,56 @@ static void subflow_state_change(struct sock *sk)
> > > 	}
> > > }
> > > 
> > > +void mptcp_subflow_queue_clean(struct sock *listener_ssk)
> > > +{
> > > +	struct request_sock_queue *queue = &inet_csk(listener_ssk)->icsk_accept_queue;
> > > +	struct mptcp_sock *msk, *next, *head = NULL;
> > > +	struct request_sock *req;
> > > +
> > > +	/* build a list of all unaccepted mptcp sockets */
> > > +	spin_lock_bh(&queue->rskq_lock);
> > > +	for (req = queue->rskq_accept_head; req; req = req->dl_next) {
> > > +		struct mptcp_subflow_context *subflow;
> > > +		struct sock *ssk = req->sk;
> > > +		struct mptcp_sock *msk;
> > > +
> > > +		if (!sk_is_mptcp(ssk))
> > > +			continue;
> > > +
> > > +		subflow = mptcp_subflow_ctx(ssk);
> > > +		if (!subflow || !subflow->conn)
> > > +			continue;
> > > +
> > > +		/* skip if already in list */
> > > +		msk = mptcp_sk(subflow->conn);
> > > +		if (msk->dl_next || msk == head)
> > > +			continue;
> > > +
> > > +		msk->dl_next = head;
> > 
> > Why is it ok to read/modify msk->dl_next without the msk locked here, but 
> > the msk lock is needed below?
> 
> the dl_next field is protected from the listener socket lock. Such lock
> is held both here and below, see the caller of this function.
> 

I see the above is not very clear; I mean: this whole function runs
under the listener _msk_ socket lock. The 'dl_next' list is under such
protection.

/P

