Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B044C68
	for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 10:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1636627711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p0+pQcBcIni9n+LmX3PZ/f55dweStP4Sco97lLH+K/c=;
	b=SqLGSqIbiq3prYf2fUPNqXT1SWF9wajmKKEH/9gh4Sj3VvDVmiGx0RmpkI9huQ2mxMORn+
	ZFc/PT3DAhGW2XdNi/QFBBKgrmTJO8XQop0KX61Xsx2E0YlKEfmldRWjhbv9Ac3pc2Vevy
	DnyBg9iTxCkU3Xv2FA49D2zkfL6FiE8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-9eXGICmhNzWYGt2T-avCdQ-1; Thu, 11 Nov 2021 05:48:29 -0500
X-MC-Unique: 9eXGICmhNzWYGt2T-avCdQ-1
Received: by mail-ed1-f71.google.com with SMTP id z1-20020a05640235c100b003e28c89743bso5018806edc.22
        for <mptcp@lists.linux.dev>; Thu, 11 Nov 2021 02:48:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=p0+pQcBcIni9n+LmX3PZ/f55dweStP4Sco97lLH+K/c=;
        b=SSnP/ss1vRURJ/hP2WpbCQNC/xtrpkAJbILXGm4k1jQbzd+rWV8MvKfgTh94Y05Fre
         Z1rBee+JZCZYezl3HsVuD2q6kWXRw3bL518kVbLBhKWZdqtFgbip1FYEcDO9mnFT4Ekg
         XOsLXpHnEeQxTUCcRVqJCCks0GnTTzLbxgHdnvpUf8FwfC9HLOYs65lqkCypJ4+fVI92
         NURnbUW4HKjIkMiZt7BMQ1bGTNk0Z8Lw2ebZ6L+KuPJS7iIfTiqB+EbCDN1Ks21azxEc
         Mq+P5t602Vm1vPz89yplpVHrvNUHWAgqps3bdMV8PGsm3/qqGdi6AztbaRLBaQLJ5fvi
         PK+A==
X-Gm-Message-State: AOAM530sg1k3Xg+QnzmCDPMg18SXu3um+VOyInEbvC0r6B6vZdiDR0eQ
	UShavFtR1zqJiXA+DqugWd4i/NC0d6r8spTSSvnU/2+xJUlHrB8dzL2Ls9APKspt/Oz5vysI5N/
	4Yc+pPywN8CC6j2M=
X-Received: by 2002:a50:e183:: with SMTP id k3mr8799144edl.22.1636627707853;
        Thu, 11 Nov 2021 02:48:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5gqbYX1hf/K88nwe0T8ojDinjISdF+J+XTO5HmMXMJLJozXnqdzTzLusEXmB1fFOYgFq0nw==
X-Received: by 2002:a50:e183:: with SMTP id k3mr8799120edl.22.1636627707638;
        Thu, 11 Nov 2021 02:48:27 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-224-97.dyn.eolo.it. [146.241.224.97])
        by smtp.gmail.com with ESMTPSA id m11sm1363936edd.58.2021.11.11.02.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 02:48:27 -0800 (PST)
Message-ID: <90884a510cc98544af9aa4d45d8eeba77477b6fc.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 1/3] mptcp: add TCP_INQ cmsg support
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, Mat Martineau
	 <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Thu, 11 Nov 2021 11:48:26 +0100
In-Reply-To: <20211110101732.GE16363@breakpoint.cc>
References: <20211108105711.16200-1-fw@strlen.de>
	 <20211108105711.16200-2-fw@strlen.de>
	 <add0921a-4ce2-a3d4-d4d-442d4e88365f@linux.intel.com>
	 <20211110101732.GE16363@breakpoint.cc>
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

On Wed, 2021-11-10 at 11:17 +0100, Florian Westphal wrote:
> Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
> > On Mon, 8 Nov 2021, Florian Westphal wrote:
> > 
> > > Support the TCP_INQ setsockopt.
> > > This is a boolean that tells recvmsg path to include the remaining
> > > in-sequence bytes into a cmsg data.
> > > 
> > > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/224
> > > Signed-off-by: Florian Westphal <fw@strlen.de>
> > > ---
> > > net/mptcp/protocol.c | 33 +++++++++++++++++++++++++++++++++
> > > net/mptcp/protocol.h |  1 +
> > > net/mptcp/sockopt.c  | 37 +++++++++++++++++++++++++++++++++++++
> > > 3 files changed, 71 insertions(+)
> > > 
> > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > index b0bfe20d6bb0..b4263bf821ac 100644
> > > --- a/net/mptcp/protocol.c
> > > +++ b/net/mptcp/protocol.c
> > > @@ -46,6 +46,7 @@ struct mptcp_skb_cb {
> > > 
> > > enum {
> > > 	MPTCP_CMSG_TS = BIT(0),
> > > +	MPTCP_CMSG_INQ = BIT(1),
> > > };
> > > 
> > > static struct percpu_counter mptcp_sockets_allocated;
> > > @@ -2006,6 +2007,29 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
> > > 	return !skb_queue_empty(&msk->receive_queue);
> > > }
> > > 
> > > +static unsigned int mptcp_inq_hint(const struct sock *sk)
> > > +{
> > > +	const struct mptcp_sock *msk = mptcp_sk(sk);
> > > +	const struct sk_buff *skb;
> > > +	u64 acked = msk->ack_seq;
> > > +	u64 hint_val = 0;
> > > +
> > > +	skb = skb_peek(&msk->receive_queue);
> > > +	if (skb) {
> > > +		u64 map_seq = MPTCP_SKB_CB(skb)->map_seq + MPTCP_SKB_CB(skb)->offset;
> > 
> > MPTCP_SKB_CB(skb)->offset is an offset within the skb payload, not related
> > to the map_seq.
> > 
> > I think MPTCP_SKB_CB(skb)->end_seq has the sequence number you need for
> > hint_val?
> 
> I don't think so.
> 
> INQ should return all bytes that are still pending for read().
> 
> ack_seq is the largest in-sequence number we've seen, so ack_seq - map_seq yields
> the in-sequence byte count of the skbs that have been queued for reading.
> 
> I could probably use skb_peek_tail() instead of skb_peek() and then grab
> ->end_seq instead of using msk->ack_seq, but I fail to see the advantage.
> 
> Because userspace might have partially read some data, we need
> to add the offset that userspace might have consumed already.
> 
> e.g., one skb queued, with 10 bytes of data, userspace calls read(, ..., 1);
> so the inq hint should return 9, not 10.
> 
> (read() increments MPTCP_SKB_CB(skb)->offset if skb wasn't consumed).

I think the problem is that at CB->offset initialization time we have:

	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow);
        MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + copy_len;
        MPTCP_SKB_CB(skb)->offset = offset

	// ...
	WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);

'offest' can be > 0, and 'map_seq' is the sequence mapping for the
first byte carried this skb. MPTCP_SKB_CB(skb)->map_seq + offset is in
general different from ack_seq (is greater then...)

A possible solution would be updating 'MPTCP_SKB_CB(skb)->map_seq'
every time 'MPTCP_SKB_CB(skb)->offset' is updated, and then using
directly 'MPTCP_SKB_CB(skb)->map_seq' to compute 'hint_val'

WDYT?

Cheers,

Paolo



