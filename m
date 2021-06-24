Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39148177
	for <mptcp@lists.linux.dev>; Thu, 24 Jun 2021 10:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1624528961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=83ZzuqkGvtZI8T4dDVGYuoFCIfrZeeJ3DWc8cc+CFh4=;
	b=RtRH+NwW3QVvdx9XMXMonhTBlPgLqStwVriKhd4ucZIs8gYXRdPBxLw6K+q/lzfIekH+ry
	ZxvtsHsvCSXaMY/Unpijqhg+yqRMYfpNFxXXv+sa2Y1deqymid5T1JjftcuMEWOjeAncz+
	lPUwLkO4oB2WiJBYEsNq9fl/UVzFtqs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-575-m9z-fV1FO7ud1e2pC5SLrw-1; Thu, 24 Jun 2021 06:02:39 -0400
X-MC-Unique: m9z-fV1FO7ud1e2pC5SLrw-1
Received: by mail-wm1-f69.google.com with SMTP id j6-20020a05600c1906b029019e9c982271so2877246wmq.0
        for <mptcp@lists.linux.dev>; Thu, 24 Jun 2021 03:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=83ZzuqkGvtZI8T4dDVGYuoFCIfrZeeJ3DWc8cc+CFh4=;
        b=QXJMKpY691gjKLYhs5zi6sCPgUdsloABERo/PJVckbCVBGcbVCadgolfFJvs+X/yVD
         NBsFBdeQkK87Y4b/dG4wPQir1JJwHRAHKVOcUQdM/AxxYWyOGsTyyPApnrJRKK7WOFN1
         GXTWCb0w9sjCkOong7jAsOtkTyDbLPbknX42RWNavxYe9xx7EirJ2ajbPMqjDIJBSyaG
         uXbwijzKCj52lEbCkyMDOwY/o0IB8Y0+8kHmZxij44GkQUZYUMvhQG3FOaRHn7TP296I
         uM/w1MXDBdiR+mS1sgACg1t8+1+eqzyQvWIC3wO4A3DMs0mY+rZ85WU3Sdtz1gsV8zaV
         s47Q==
X-Gm-Message-State: AOAM531WsV38yCVCgsvl9efNamXA4GzIKypzS4mux3n2oTf5ec9N52IP
	JKlJYaR/AajccR/0lIKp81mJO77y6mBTYhVRambPyHmF0ZTDM4tUB6jVYqFbGImTFI/mwxfNgJo
	I9UQt7cdGX8xGofQ=
X-Received: by 2002:adf:c790:: with SMTP id l16mr3555764wrg.121.1624528958576;
        Thu, 24 Jun 2021 03:02:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAxk2HA9mv0TXOcX689bC7RQcD5EGzCsEfWC0JYc5aNojgO25SQTLOtN+sUKBx6k7RZ+UXLA==
X-Received: by 2002:adf:c790:: with SMTP id l16mr3555743wrg.121.1624528958373;
        Thu, 24 Jun 2021 03:02:38 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-109-224.dyn.eolo.it. [146.241.109.224])
        by smtp.gmail.com with ESMTPSA id n16sm2705208wrx.85.2021.06.24.03.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 03:02:38 -0700 (PDT)
Message-ID: <7c26d28d7249536615bf945b09d683f81eb06be0.camel@redhat.com>
Subject: Re: [PATCH v5 4/4] mptcp: avoid processing packet if a subflow reset
From: Paolo Abeni <pabeni@redhat.com>
To: Jianguo Wu <wujianguo106@163.com>, Mat Martineau
	 <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, fw@strlen.de
Date: Thu, 24 Jun 2021 12:02:37 +0200
In-Reply-To: <f7e8a4f2-1725-72c3-b54e-5f6dc1af0a24@163.com>
References: <1623840570-42004-1-git-send-email-wujianguo106@163.com>
	 <1623840570-42004-5-git-send-email-wujianguo106@163.com>
	 <45dcfe4c-1918-2d78-accf-141bb4af2c5b@linux.intel.com>
	 <b568316c-d0f9-9315-692d-ea83b2d49b85@163.com>
	 <2024b917-84de-4dea-2244-5dce7a7f2495@linux.intel.com>
	 <1ac0561c290bf87aa54277bc6b458a859b8ff080.camel@redhat.com>
	 <f7e8a4f2-1725-72c3-b54e-5f6dc1af0a24@163.com>
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

On Thu, 2021-06-24 at 09:57 +0800, Jianguo Wu wrote:
> 
> On 2021/6/23 17:48, Paolo Abeni wrote:
> > On Tue, 2021-06-22 at 17:00 -0700, Mat Martineau wrote:
> > > On Mon, 21 Jun 2021, Jianguo Wu wrote:
> > > 
> > > > Hi Mat,
> > > > 
> > > > On 2021/6/19 8:19, Mat Martineau wrote:
> > > > > On Wed, 16 Jun 2021, wujianguo106@163.com wrote:
> > > > > 
> > > > > > From: Jianguo Wu <wujianguo@chinatelecom.cn>
> > > > > > 
> > > > > > If check_fully_established() causes a subflow reset, it should not
> > > > > > continue to process the packet in tcp_data_queue().
> > > > > > 
> > > > > > setting:
> > > > > >     TCP_SKB_CB(skb)->end_seq = TCP_SKB_CB(skb)->seq;
> > > > > > 
> > > > > > so that the following check will drop the pkt in
> > > > > > tcp_data_queue():
> > > > > >  if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq) {
> > > > > >     __kfree_skb(skb);
> > > > > >     return;
> > > > > >  }
> > > > > > 
> > > > > > Fixes: d582484726c4 ("mptcp: fix fallback for MP_JOIN subflows")
> > > > > > Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
> > > > > > ---
> > > > > > net/mptcp/options.c | 6 ++++++
> > > > > > 1 file changed, 6 insertions(+)
> > > > > > 
> > > > > > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > > > > > index 1aec01686c1a..be435c5421cd 100644
> > > > > > --- a/net/mptcp/options.c
> > > > > > +++ b/net/mptcp/options.c
> > > > > > @@ -926,6 +926,12 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
> > > > > >     return true;
> > > > > > 
> > > > > > reset:
> > > > > > +    /* If a subflow is reset, the packet should not continue to be
> > > > > > +     * processed in tcp_data_queue(), so setting: end_seq = seq,
> > > > > > +     * then tcp_data_queue() will drop the packet.
> > > > > > +     */
> > > > > > +    TCP_SKB_CB(skb)->end_seq = TCP_SKB_CB(skb)->seq;
> > > > > > +
> > > > > 
> > > > > This does have the desired effect when mptcp_incoming_options() is 
> > > > > called from tcp_data_queue(), but mptcp_incoming_options() is also 
> > > > > called from tcp_reset() and tcp_rcv_state_process(). The other callers 
> > > > > appear to tolerate the sequence number modification.
> > > > > 
> > > > > I think it would be clearer to either add a return value or output 
> > > > > parameter to mptcp_incoming_options() to explicitly tell the caller 
> > > > > that a reset has been sent and tcp_done() called. Then it would be 
> > > > > clearer in tcp_data_queue() that the packet is being discarded due to 
> > > > > mptcp header content.
> > > > > 
> > > > 
> > > > If a reset has been sent and tcp_done() called in 
> > > > check_fully_established(), the sk_state will be TCP_CLOSE, how about 
> > > > just do (sk_state == TCP_CLOSE) check in tcp_data_queue() as it did in 
> > > > the V1 of this patch?
> > > 
> > > Oh, I see now that Paolo suggested the the end_seq assignment in order to 
> > > only modify MPTCP code.
> > > 
> > > I still think it's better to make it clear that we're discarding a packet 
> > > due to the mptcp headers - using the existing sequence check (intended to 
> > > detect acks) in tcp_data_queue() seems sneaky to me.
> > > 
> > > Something like
> > > 
> > > if (sk_is_mptcp(sk) && !mptcp_incoming_options(sk, skb)) {
> > >  	__kfree_skb(skb);
> > >  	return;
> > > }
> > > 
> > > seems both compact and clear. Does that seem ok Paolo?
> > 
> > Uhmmm... we need to touch every mptcp_incoming_options() call site, and
> > in tcp_reset() the above chunk looks a bit strange to me. Probably we
> > could just ignore the mptcp_incoming_options() return value there. 
> > 
> > Otherwise no big objections - not sure about upstream ;)
> > 
> 
> Hi Mat and Paolo,
> 
> If you both agree, I will send a new version that mptcp_incoming_options() add a return value, and only check return value in tcp_data_queue(),
> ignore the return value in other call site.

Even the hook in tcp_rcv_state_process() can be followed by
tcp_data_queue().

I *think* it's better ignoring the return value of
mptcp_incoming_options() only in tcp_reset(), adding there a comment -
something alike "mptcp can't tell us to ignore reset pkts".

Cheers,

Paolo

p.s. I'm sorry for the long, difficult and somewhat on/off review
process. This change is indeed tricky. Don't despair, it looks like
it's near to an happy ending!


