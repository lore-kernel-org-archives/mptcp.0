Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4120C3D74
	for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 10:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663584259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JBW6YiUMzLA0u5k8g3NIzlgL8NMc0m6HVKZvO+dERsc=;
	b=Ujn1lrUJrmqh5VInk0w6vvXgF28vc/IuUkpWT/suga8OMh4B1NkErU55j3tXeh3f4Whs6d
	RXQ17xFDvsKZXNPVOcQOxwgT2KzrBq/LwHXhk6FgqEBttlqhS/vJUmkynpPF3FdSLqEzOW
	9n/rXApE6KgEWKcxeSphJ4dj0xneAnw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-367-QTwmmFXgNUic_1WsK7CSqw-1; Mon, 19 Sep 2022 06:44:18 -0400
X-MC-Unique: QTwmmFXgNUic_1WsK7CSqw-1
Received: by mail-qt1-f198.google.com with SMTP id fz10-20020a05622a5a8a00b0035ce18717daso2247764qtb.11
        for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 03:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=JBW6YiUMzLA0u5k8g3NIzlgL8NMc0m6HVKZvO+dERsc=;
        b=Crw6tTzGeORFuPGKBynvEjcZCQR84n1rgdFA21gpEsdoitWHJuKwhlNHdXbKz8WPix
         leMy8arIIJMx93pBLYxRJeRx+YSugnvv0UTGNXKlG0cYmsPUYoUVHHSflY4pvAyN9w3N
         qUhBIAdiNyTu0T/jPTsMoKAWYqBvprfVxbpsL9xQ3/ZUKdqKGhxN7CTHtVik9jtG9pnv
         IX9umEfdKCajq21TzAAV83Xe5qp1DSbxX+tv5VTfoCTBc0y3kurlTrLOnsA8iRtyY61S
         AHE3SYCqfaZC4yjFflU385TvI+cHySXf1ZDZaNRtvswti4b8+2QUPU9wc8qnjVHdNQXG
         kG/Q==
X-Gm-Message-State: ACrzQf0oIsITzN6XMfKOoZotVacC6UCW+66CBJplAlEea7FlfW+XGurv
	ywtZTMHInBAv6tDc8sl/+udhuTK+dO+ID6V0UHU9eVdGbfvAy2RcSgUFN8P22121Vam5vihZXNg
	MYBboSJLbielQzNQ=
X-Received: by 2002:a05:620a:1584:b0:6ce:1864:cbf2 with SMTP id d4-20020a05620a158400b006ce1864cbf2mr12501250qkk.33.1663584257445;
        Mon, 19 Sep 2022 03:44:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6S5gXpCblrHCKcMB7gtNuCrtWP1fA2Mp8w1WIcCDQWmC/4/zPqity5qvJQ2MW2Z2mwcUUIpw==
X-Received: by 2002:a05:620a:1584:b0:6ce:1864:cbf2 with SMTP id d4-20020a05620a158400b006ce1864cbf2mr12501241qkk.33.1663584257171;
        Mon, 19 Sep 2022 03:44:17 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-114-90.dyn.eolo.it. [146.241.114.90])
        by smtp.gmail.com with ESMTPSA id dm51-20020a05620a1d7300b006ceb8f36302sm9484727qkb.71.2022.09.19.03.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 03:44:16 -0700 (PDT)
Message-ID: <7f09e484ec0d6068d62bca82d4ca907a09db64d5.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v7 03/11] Initiator: MSG_FASTOPEN
 sendto(). request cookie
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Date: Mon, 19 Sep 2022 12:44:14 +0200
In-Reply-To: <e1e8bfbc5f3ba023e01354e62c4f3a28f69c0bca.camel@redhat.com>
References: <20220917222853.2406-1-dmytro@shytyi.net>
	 <20220917222853.2406-4-dmytro@shytyi.net>
	 <e1e8bfbc5f3ba023e01354e62c4f3a28f69c0bca.camel@redhat.com>
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

On Mon, 2022-09-19 at 12:35 +0200, Paolo Abeni wrote:
> On Sun, 2022-09-18 at 00:28 +0200, Dmytro Shytyi wrote:
> > Initiator: MSG_FASTOPEN in sendto triggers the mptcp_sendsmg_fastopen.
> > It requests a MPTFO cookie.
> > Suggestion @palbeni(JAN 17): 'split the patch in several small one'.
> 
> Minor nit: the above line is not needed here. You can add this
> "changelog" related info after the '---' separator, so that they will
> not land in git.
> > 
> > Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> > ---
> >  net/mptcp/fastopen.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
> >  net/mptcp/protocol.c |  4 ++--
> >  net/mptcp/protocol.h |  6 ++++++
> >  3 files changed, 58 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
> > index 0c9ef6f5d528..9974508e0f4c 100644
> > --- a/net/mptcp/fastopen.c
> > +++ b/net/mptcp/fastopen.c
> > @@ -3,3 +3,53 @@
> >   */
> >  
> >  #include "protocol.h"
> > +
> > +int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
> > +			   size_t len, struct mptcp_sock *msk,
> 
> No need to pass both 'sk' and 'msk', they are the same ptr casted to
> different types. Just pass 'sk' and then:
> 
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> 
> > +			   size_t *copied)
> > +{
> > +	const struct iphdr *iph;
> > +	struct ubuf_info *uarg;
> > +	struct sockaddr *uaddr;
> > +	struct sk_buff *skb;
> > +	struct tcp_sock *tp;
> > +	struct socket *ssk;
> 
> The above variable name is misleading. 'ssk' should be a 'struct sock',
> you should use 'ssock' for subflow 'struct socket'.
> 
> I think it's better to use a 'struct sock', you could do:
> 
> 	ssk = msk->first;
> 	if (unlikely(ssk))
> 		return -EINVAL;
> 
> > +	int ret;
> > +
> > +	ssk = __mptcp_nmpc_socket(msk);
> > +	if (unlikely(!ssk))
> > +		goto out_EFAULT;
> 
> See the above.
> 
> > +	skb = tcp_stream_alloc_skb(ssk->sk, 0, ssk->sk->sk_allocation, true);
> > +	if (unlikely(!skb))
> > +		goto out_EFAULT;
> > +	iph = ip_hdr(skb);
> > +	if (unlikely(!iph))
> > +		goto out_EFAULT;
> 
> Use only lower case for macro names. Also EFAULT is probably not a good
> return value. EINVAL should fit better. More importantly, it looks like
> this check is not needed ?!?

Addendum: you probably need to add/duplicate the full checks
implemented in tcp_sendmsg_fastopen():

https://elixir.bootlin.com/linux/v6.0-rc5/source/net/ipv4/tcp.c#L1174

lines 1174-1180


Cheers,

Paolo

