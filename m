Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6CD17CB
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 09:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1665565827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KgIkXma0E5msWYy155T5GltFicUJWPgn01iAvI795ZE=;
	b=NL8PWypsf1+gy8Rego49hxTabTlNTrRE9Uelyv1gw7D2fZeoSCmQ3xIYrXkfnWmyuhx5Du
	9IDQFbt0caqj4R/GpeYx0zCrfrFtrSG0zURx3zKx1/uCSL1rUfCx2F8tUXPf4eT0PH1G+T
	HmWW2Lq3NBDsOcNb6RBxOFigSjKFdMo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-102-DIHVB4NBPreDdrI8g8VZEg-1; Wed, 12 Oct 2022 05:10:26 -0400
X-MC-Unique: DIHVB4NBPreDdrI8g8VZEg-1
Received: by mail-wm1-f69.google.com with SMTP id fc12-20020a05600c524c00b003b5054c70d3so9700216wmb.5
        for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 02:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KgIkXma0E5msWYy155T5GltFicUJWPgn01iAvI795ZE=;
        b=gIeEkrPs5c6XC21MF7D9oSS89ZfBROEl+/lwRX4Icsd63Aq0XKfnrOwTIWaVQDeJWi
         Yty1Edm4N6wizBfWhj1f1WtisatLiWYj6VAHWurpHcFkeKdMIXNNd9Hct/V7707gjcQ5
         hCInlWx+bJP8SSATVQyhmuaOeqqs8xgzARAHiA2QX5AViPieBpN+/12OCu6gotfZUg0i
         M1/XkGDHVHBTNVzrJSeyk8nxbyJjJQqK2D4FhQ1ukNcIo1yPFVe/Ir6x7vifL//ok47d
         8r6MZLgGTSjBKsnLnIapcSi0p1uJihHs4hiN55InmgYdOkblLaYO7G97ktm8QBJyfew3
         atpg==
X-Gm-Message-State: ACrzQf0fOZqVi0EcIW/LE7zYv8/2zQcv9YOHgFJMsO5MY70VvypBTSUR
	PhsLB5P2vKXWJvl6ZyB9QpIBVbfxjK6nQpmVN3vcCir+ldhrlHzXe6bopfdoDfFNVj9QnUYLMK1
	lsPXajUQRdXKsC5U=
X-Received: by 2002:a05:600c:6885:b0:3bd:d782:623c with SMTP id fn5-20020a05600c688500b003bdd782623cmr1984036wmb.102.1665565824836;
        Wed, 12 Oct 2022 02:10:24 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4dEdvp7Izi0kkwf9P7W/WV/zsYxRBYW8pnBgB2yNhAXAUig90/CdbuXTMkEb8O+nfiGzQ8sw==
X-Received: by 2002:a05:600c:6885:b0:3bd:d782:623c with SMTP id fn5-20020a05600c688500b003bdd782623cmr1984008wmb.102.1665565824449;
        Wed, 12 Oct 2022 02:10:24 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-103-235.dyn.eolo.it. [146.241.103.235])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d6d42000000b0022e049586c5sm13192325wri.28.2022.10.12.02.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:10:23 -0700 (PDT)
Message-ID: <0c51594362f1e64b9b2a45d10536051abf1e0470.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v2] mptcp: fix abba deadlock on fastopen
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Wed, 12 Oct 2022 11:10:22 +0200
In-Reply-To: <bbd50fc8-150c-84db-5287-71911a91e9c7@tessares.net>
References: <c23778554e349d0a85a34aba14affdac9f5164c5.1665510026.git.pabeni@redhat.com>
	 <bbd50fc8-150c-84db-5287-71911a91e9c7@tessares.net>
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

On Wed, 2022-10-12 at 10:22 +0200, Matthieu Baerts wrote:
> Thank you for having caught the issue and already provided the patch!
> 
> On 11/10/2022 19:40, Paolo Abeni wrote:
> > Our CI reported lockdep splat in the fastopen code:
> 
> (...)
> 
> > commit ("mptcp: factor out mptcp_connect()") will need some
> > mangling on top of this one.
> > 
> > A possible alternative would be targeting even the above to -net.
> > 
> > Not strictly required, but it will also make more striaght-forward/
> > legit the __inet_stream_connect() invocation here.
> 
> Indeed, we can. We would need more work around that anyway, no? (see my
> comment below)
> 
> > ---
> >  net/mptcp/protocol.c | 43 ++++++++++++++++++++++++++++++-------------
> >  1 file changed, 30 insertions(+), 13 deletions(-)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index f599ad44ed24..21f5676a60e8 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -1673,6 +1673,31 @@ static void mptcp_set_nospace(struct sock *sk)
> >  	set_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags);
> >  }
> >  
> > +static int mptcp_sendmsg_fastopen(struct sock *sk, struct sock *ssk, struct msghdr *msg,
> > +				  size_t len, int *copied_syn)
> > +{
> > +	unsigned int saved_flags = msg->msg_flags;
> > +	int ret;
> > +
> > +	lock_sock(ssk);
> > +	msg->msg_flags |= MSG_DONTWAIT;
> > +	ret = tcp_sendmsg_fastopen(ssk, msg, copied_syn, len, NULL);
> 
> Would it not be cleaner (and easier to maintain?) if a new parameter is
> added to tcp_sendmsg_fastopen() to force passing the O_NONBLOCK flag to
> __inet_stream_connect? Not to modify msg->msg_flags to have the
> behaviour we want.

Uhmmm... cleaner only for this call-site. It could be confusing adding
another parameter for blocking where there is already msg_flags for
that. And I'm personally against adding to many arguments to a single
function...

> > +	msg->msg_flags = saved_flags;
> > +	release_sock(ssk);
> > +
> > +	/* do the blocking bits of inet_stream_connect outside the ssk socket lock*/
> 
> (I thought checkpatch.pl was complaining when there was no space before
> '*/' but it doesn't, all good :) )
> 
> > +	if (ret == -EINPROGRESS && !(msg->msg_flags & MSG_DONTWAIT)) {
> > +		ret = __inet_stream_connect(sk->sk_socket, msg->msg_name,
> > +					    msg->msg_namelen, msg->msg_flags, 1);
> 
> Without the commit ("mptcp: factor out mptcp_connect()"), would we need
> to call the -net version of mptcp_stream_connect() but without the lock?

Not strictly needed. I test this patch on export/net. Possibly cleaner.

> > +
> > +		/* On connect hard error fastopen no bytes actually sent. */
> > +		if (ret && ret != -EINPROGRESS && ret != -ERESTARTSYS && ret != -EINTR)
> 
> The two last ones are there in case the "actual connect()" got
> interrupted, right?

Yes. Plain TCP consider copied_syn == 0 in that case. I did not find
any existing helper to match such condition. Perhapas a longer comment
may help.

> > +			*copied_syn = 0;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >  static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> >  {
> >  	struct mptcp_sock *msk = mptcp_sk(sk);
> > @@ -1692,24 +1717,16 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> >  	lock_sock(sk);
> >  
> >  	ssock = __mptcp_nmpc_socket(msk);
> > -	if (unlikely(ssock && inet_sk(ssock->sk)->defer_connect)) {
> > -		struct sock *ssk = ssock->sk;
> > +	if (unlikely(ssock && (inet_sk(ssock->sk)->defer_connect ||
> > +			       msg->msg_flags & MSG_FASTOPEN))) {
> 
> Just above in this mptcp_sendmsg() function, we mention we don't support
> MSG_FASTOPEN yet. maybe we don't need to add this additional check now?

Thanks for catching it. This is a stray change from a previous
revision.


I can send a v2 addressing the above and cleaning up comments, but
AFAICS there is still pending the main question about including "mptcp:
factor out mptcp_connect()" in -net. Currently I think that could be
the better option.

Thanks,

Paolo

