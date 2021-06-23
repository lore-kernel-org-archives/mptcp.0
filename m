Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7C570
	for <mptcp@lists.linux.dev>; Wed, 23 Jun 2021 09:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1624441685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBTK6nBj2bkaTtCXNCWZeGDygQk0fWijsEVtELI86sc=;
	b=ghv4ATa9IR+GNEpi+XZvotWh2rguE1WVhYMOfboM1aiCAqUlYLrE7ywoU2SU3UZQEmMozW
	H86rI2pfObh2vzEr0jtgyaI5y0sMxF0uxjUW1icue/Mt46QGAZUz3w8ht6f33HJ5PYuhe+
	FHJdYr81tzfvR/y1i+sWlUZO9ANMpSU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-HDr9F2WWMpq8AtQ-YYNJkw-1; Wed, 23 Jun 2021 05:48:04 -0400
X-MC-Unique: HDr9F2WWMpq8AtQ-YYNJkw-1
Received: by mail-wm1-f71.google.com with SMTP id v25-20020a1cf7190000b0290197a4be97b7so383408wmh.9
        for <mptcp@lists.linux.dev>; Wed, 23 Jun 2021 02:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gBTK6nBj2bkaTtCXNCWZeGDygQk0fWijsEVtELI86sc=;
        b=UNQZQBIm3aLgkhfRTHrWu93a6ggR57DlrFa06IZ6hCSIvny9fOvhoRZZj4khitSFgG
         3yTpCBHelJxUHXhKT7xm7yw9dchL1TYHiJUEIpU5hY0T+1gSRDqVRU/5trBVRFeKOaB4
         A3DzSVpouAqIXlAGDmwbQ5vWLtJvncGqT/yRWqYe5MyTkCxQ0b3G6UDlnl2YThpRUVub
         2WpzoGTSb10nOufGWKgPFGeulA/AyxCb2X1wKuf4qBc7GQF32koxM6IkRDuDOHyJR8jR
         hyCx2a4QRlxNoSPWE7R0c7l2xf19YVTYLev+g0YVWXhVPXfPfNHNQJu91QC/QtbfOIx6
         FDrQ==
X-Gm-Message-State: AOAM531agdj0HQqsU622vSBjvm7xF1UJP/YYh1HSWMqx9vP2fOjsL1A8
	mkQIYoMJ9B+uP7UcEPCsM8VWPVv3uU4vrp9u47zctdhdk0EwN/wB4ri/SNf/BS3U0TuoxjB3+MJ
	PMZHj557/r4xQH9U=
X-Received: by 2002:a7b:c006:: with SMTP id c6mr9669556wmb.11.1624441683001;
        Wed, 23 Jun 2021 02:48:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzE4Cx/CjA8vNp9t8U1kBPAYZ5h9/jXJWt9IfNb125+mNyrh8E1s4mAI8BijxwTLDRMeQECUQ==
X-Received: by 2002:a7b:c006:: with SMTP id c6mr9669536wmb.11.1624441682821;
        Wed, 23 Jun 2021 02:48:02 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-109-224.dyn.eolo.it. [146.241.109.224])
        by smtp.gmail.com with ESMTPSA id q7sm2641398wrw.18.2021.06.23.02.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 02:48:02 -0700 (PDT)
Message-ID: <1ac0561c290bf87aa54277bc6b458a859b8ff080.camel@redhat.com>
Subject: Re: [PATCH v5 4/4] mptcp: avoid processing packet if a subflow reset
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, Jianguo Wu
	 <wujianguo106@163.com>
Cc: mptcp@lists.linux.dev, fw@strlen.de
Date: Wed, 23 Jun 2021 11:48:01 +0200
In-Reply-To: <2024b917-84de-4dea-2244-5dce7a7f2495@linux.intel.com>
References: <1623840570-42004-1-git-send-email-wujianguo106@163.com>
	 <1623840570-42004-5-git-send-email-wujianguo106@163.com>
	 <45dcfe4c-1918-2d78-accf-141bb4af2c5b@linux.intel.com>
	 <b568316c-d0f9-9315-692d-ea83b2d49b85@163.com>
	 <2024b917-84de-4dea-2244-5dce7a7f2495@linux.intel.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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

On Tue, 2021-06-22 at 17:00 -0700, Mat Martineau wrote:
> On Mon, 21 Jun 2021, Jianguo Wu wrote:
> 
> > Hi Mat,
> > 
> > On 2021/6/19 8:19, Mat Martineau wrote:
> > > On Wed, 16 Jun 2021, wujianguo106@163.com wrote:
> > > 
> > > > From: Jianguo Wu <wujianguo@chinatelecom.cn>
> > > > 
> > > > If check_fully_established() causes a subflow reset, it should not
> > > > continue to process the packet in tcp_data_queue().
> > > > 
> > > > setting:
> > > >     TCP_SKB_CB(skb)->end_seq = TCP_SKB_CB(skb)->seq;
> > > > 
> > > > so that the following check will drop the pkt in
> > > > tcp_data_queue():
> > > >  if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq) {
> > > >     __kfree_skb(skb);
> > > >     return;
> > > >  }
> > > > 
> > > > Fixes: d582484726c4 ("mptcp: fix fallback for MP_JOIN subflows")
> > > > Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
> > > > ---
> > > > net/mptcp/options.c | 6 ++++++
> > > > 1 file changed, 6 insertions(+)
> > > > 
> > > > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > > > index 1aec01686c1a..be435c5421cd 100644
> > > > --- a/net/mptcp/options.c
> > > > +++ b/net/mptcp/options.c
> > > > @@ -926,6 +926,12 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
> > > >     return true;
> > > > 
> > > > reset:
> > > > +    /* If a subflow is reset, the packet should not continue to be
> > > > +     * processed in tcp_data_queue(), so setting: end_seq = seq,
> > > > +     * then tcp_data_queue() will drop the packet.
> > > > +     */
> > > > +    TCP_SKB_CB(skb)->end_seq = TCP_SKB_CB(skb)->seq;
> > > > +
> > > 
> > > This does have the desired effect when mptcp_incoming_options() is 
> > > called from tcp_data_queue(), but mptcp_incoming_options() is also 
> > > called from tcp_reset() and tcp_rcv_state_process(). The other callers 
> > > appear to tolerate the sequence number modification.
> > > 
> > > I think it would be clearer to either add a return value or output 
> > > parameter to mptcp_incoming_options() to explicitly tell the caller 
> > > that a reset has been sent and tcp_done() called. Then it would be 
> > > clearer in tcp_data_queue() that the packet is being discarded due to 
> > > mptcp header content.
> > > 
> > 
> > If a reset has been sent and tcp_done() called in 
> > check_fully_established(), the sk_state will be TCP_CLOSE, how about 
> > just do (sk_state == TCP_CLOSE) check in tcp_data_queue() as it did in 
> > the V1 of this patch?
> 
> Oh, I see now that Paolo suggested the the end_seq assignment in order to 
> only modify MPTCP code.
> 
> I still think it's better to make it clear that we're discarding a packet 
> due to the mptcp headers - using the existing sequence check (intended to 
> detect acks) in tcp_data_queue() seems sneaky to me.
> 
> Something like
> 
> if (sk_is_mptcp(sk) && !mptcp_incoming_options(sk, skb)) {
>  	__kfree_skb(skb);
>  	return;
> }
> 
> seems both compact and clear. Does that seem ok Paolo?

Uhmmm... we need to touch every mptcp_incoming_options() call site, and
in tcp_reset() the above chunk looks a bit strange to me. Probably we
could just ignore the mptcp_incoming_options() return value there. 

Otherwise no big objections - not sure about upstream ;)

Cheers,

Paolo

