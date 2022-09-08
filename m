Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DE37C
	for <mptcp@lists.linux.dev>; Thu,  8 Sep 2022 11:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662637686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dUTrTud5JQsL95XiMfKi52diAUq+QxwHypVvtGLHdek=;
	b=U2Yw/Eh1fBXqAwhCyUkA4BTsb5xcSKxSJRQgJYcrTCjxtDNT1odK0fqH090diTlFrSRWoW
	DyypQkayAKIeN4GRPCjcSbFldP2AbqIvK1zCDrNT+BT2JTd2VBTaHU5MQt9eqHFyB5HibF
	VLsXvvBJQ/J/0QISP5FeXAMbubq8cj0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-453-Jb1RygkkPbSOCFVOZtc1SQ-1; Thu, 08 Sep 2022 07:48:05 -0400
X-MC-Unique: Jb1RygkkPbSOCFVOZtc1SQ-1
Received: by mail-qk1-f198.google.com with SMTP id r14-20020a05620a298e00b006be796b6164so14424714qkp.19
        for <mptcp@lists.linux.dev>; Thu, 08 Sep 2022 04:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=dUTrTud5JQsL95XiMfKi52diAUq+QxwHypVvtGLHdek=;
        b=GAidl1zU7E4gG5/kcbC94k4/DeinYY3n/N1Jsj7+nlWS26fgFZp6uJ+Gexqu8tp8NO
         sbb466w07VsDQntUFAlZIgHtsE3wnUL+wMHNuliNPaI5UxpDRRB10wLGzmLT4OBs9U/y
         TYskCR/wk/sgJW28ArYiO9PdHPxiy86fVSn3MlviTzoH8lNr9r6Rn5CKENmQkFKOnH3h
         EHSvYct6FHtZWVH5PxpEpAS8uuVz1ygJ3dUbDI2bP2MnFKc0NFdj2Su327o/zpr3omin
         HYURTRE6qlbolGRko1hF7/JUWtpiYSWVJ2TyyZUtR7K8aXxItNpebBrvEXzzT0HGmloQ
         0brQ==
X-Gm-Message-State: ACgBeo1HycF7SAYSK2qgs8A48ydj9TCqPW74cxKulV95X7NYq5dbHnMO
	XR9dPQ72JbIfqvP21Vz40Fmg2nMFAvPGMV6fi9arKwwcak+pr3VBhZD71BkyYTVLuT5HbmEorfX
	S2B+jpS9DycIqTR8=
X-Received: by 2002:a05:620a:2157:b0:6ba:cc6b:8e99 with SMTP id m23-20020a05620a215700b006bacc6b8e99mr6082127qkm.185.1662637685043;
        Thu, 08 Sep 2022 04:48:05 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6uRoOYQdxEfpcF3fyh7wZLedMww95Qjv5L7mfJubgYt7fZMzascPulojz/MwmEQo16wjkFZQ==
X-Received: by 2002:a05:620a:2157:b0:6ba:cc6b:8e99 with SMTP id m23-20020a05620a215700b006bacc6b8e99mr6082109qkm.185.1662637684769;
        Thu, 08 Sep 2022 04:48:04 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-119-112.dyn.eolo.it. [146.241.119.112])
        by smtp.gmail.com with ESMTPSA id l16-20020a37f910000000b006cbc6e1478csm1267548qkj.57.2022.09.08.04.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 04:48:04 -0700 (PDT)
Message-ID: <697a9878ebff12d2a08a40bab699ed7cb41326d9.camel@redhat.com>
Subject: Re: [PATCH v3 mptcp-next 1/3] mptcp: propagate fastclose error.
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Thu, 08 Sep 2022 13:48:01 +0200
In-Reply-To: <86057d75-499c-8e30-ef15-7cd67cbc2344@tessares.net>
References: <5e26963328ae04aa375089a713ec40f5eb6adacd.1662051551.git.pabeni@redhat.com>
	 <86057d75-499c-8e30-ef15-7cd67cbc2344@tessares.net>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2022-09-07 at 19:22 +0200, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 01/09/2022 19:31, Paolo Abeni wrote:
> > When an mptcp socket is closed due to an incoming FASTCLOSE
> > option, so specific sk_err is set and later syscall will
> > fail usually with EPIPE.
> > 
> > Align the current fastclose error handling with TCP reset,
> > properly setting the socket error according to the current
> > msk state and propagating such error.
> 
> Thank you for the patch and sorry for the delay!

Thank you for the review!
> 
> I have some questions here below:
> 
> > Additionally sendmsg() is currently not handling properly
> > the sk_err, always returning EPIPE.
> Could it be seen as a bug-fix and deserving a dedicated commit?

I personally see this as an improvement, as AFAIK there is no mandated
by RFC return error code for MPTCP.
> 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> >  net/mptcp/protocol.c | 45 ++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 35 insertions(+), 10 deletions(-)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index f4891db86217..b04f184695e4 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -1685,9 +1685,13 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> >  	if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
> >  		ret = sk_stream_wait_connect(sk, &timeo);
> >  		if (ret)
> > -			goto out;
> > +			goto do_error;
> >  	}
> >  
> > +	ret = -EPIPE;
> 
> Regarding this line above... (see below)
> 
> > +	if (unlikely(sk->sk_err || (sk->sk_shutdown & SEND_SHUTDOWN)))
> > +		goto do_error;
> > +
> >  	pfrag = sk_page_frag(sk);
> >  
> >  	while (msg_data_left(msg)) {
> 
> ...Could we eventually have no data left and no going through the while
> loop?

yes...

> In this case "copied" will be 0 and we will return the new -EPIPE, maybe
> not what we want, no?

no;) we now always return 'copied'. We set 'copied' to the correct
error code only in the error path, saving a conditional in the fast
path.

All gracefully stolen from plain TCP ;)

> Or should we change 'ret' value just before calling 'goto do_error' to
> avoid that?
> 
> (...)
> 
> > @@ -2404,12 +2410,31 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
> >  		unlock_sock_fast(tcp_sk, slow);
> >  	}
> >  
> > +	/* Mirror the tcp_reset() error propagation */
> > +	switch (sk->sk_state) {
> > +	case TCP_SYN_SENT:
> > +		sk->sk_err = ECONNREFUSED;
> > +		break;
> > +	case TCP_CLOSE_WAIT:
> > +		sk->sk_err = EPIPE;
> > +		break;
> > +	case TCP_CLOSE:
> > +		return;
> > +	default:
> > +		sk->sk_err = ECONNRESET;
> > +	}
> 
> Should we eventually move this out of tcp_reset(), export it (inline
> function?) and re-using it here to avoid the duplication (and eventually
> being out-of-sync in case of changes on TCP side? even if I guess this
> would not change but well)

That could be a possible follow-up I guess, but I would refrain from
touching TCP to address issues/295.


Thanks!

Paolo

