Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C7D8F69
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 10:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1665569189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXJxqEklUv9ulwRug+hJh7Gp/7S7i5XJTozPFoDsudw=;
	b=ELa/0fIUXHDv1j1/d6avD3EwHL/igUqzJUys0KE6aGh+JQYDL6i4rs4+IWBFcD2whR71Jx
	1ec2fbp/bGQrKvla1Ttj6GpYJnk+QeCW/yQLKqps1g9Dffhjr34Josp+IbP9sTgbUW8YUF
	Oqrg8wKakucgKCG7McA6WEy+go6l+gU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-45-wiWK0lCAMpyCAehaVxjL-Q-1; Wed, 12 Oct 2022 06:06:28 -0400
X-MC-Unique: wiWK0lCAMpyCAehaVxjL-Q-1
Received: by mail-wm1-f70.google.com with SMTP id c5-20020a1c3505000000b003c56da8e894so928215wma.0
        for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 03:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IXJxqEklUv9ulwRug+hJh7Gp/7S7i5XJTozPFoDsudw=;
        b=wRMewLJKSSR5wD7CkZx+U4DUyrWjhkhMrRHGSiKtkMrKNThjcDxtMKPuoemfcjUl8C
         1OYPzE+yEZbK0nSvoj/gGCe2hlunAyuNMJk65soWfYBebcU9lkSn0FZ7y/UIm6aWYcBf
         CZwzDUbbSVf9injcFZ4hXGwS0WfClzIOhyhIM1Q6mLnYcgGLpxUAV8od7yx+zR1IbdJ+
         w6r5v7bHaOOzYIihfS5wPw7f9VicreudMM/q4QKSJ99bTMQ2e6RBGjuG25VRE4FOGPjk
         cD0fTaZuvrBat7Fdf7opSpOuzY+oOv5vIQ7DTVnhG9tkVMVPPBnxwRxKfyIzAWgMHvb6
         4xow==
X-Gm-Message-State: ACrzQf3oMJuA3aQiEiglRfkbcMxEhSBTS5VgwmmiHasLBSkZp6eCnIx3
	i2Wvi8Cy2LdWh40Ol6CpHM429KqRn/V8kBzKnrtmbm+7QeLyoga5T6EjzpmaSin4EAJ9oBlBayw
	R0Nj3Ht2kN+fq1P0=
X-Received: by 2002:a7b:c84f:0:b0:3b4:84c1:1e7 with SMTP id c15-20020a7bc84f000000b003b484c101e7mr2240248wml.12.1665569186442;
        Wed, 12 Oct 2022 03:06:26 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4AWD8cpdRkBXtLhS5rgtG8bZg50lg70WiTL0BVuDdAQxIztkxGfSD03SUCRkLN1A+xgGRyng==
X-Received: by 2002:a7b:c84f:0:b0:3b4:84c1:1e7 with SMTP id c15-20020a7bc84f000000b003b484c101e7mr2240230wml.12.1665569186148;
        Wed, 12 Oct 2022 03:06:26 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-103-235.dyn.eolo.it. [146.241.103.235])
        by smtp.gmail.com with ESMTPSA id d9-20020adff2c9000000b0021badf3cb26sm16302163wrp.63.2022.10.12.03.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 03:06:25 -0700 (PDT)
Message-ID: <75fbbda1c891d1471cfc0ab47bd169a7b4e77b02.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v2] mptcp: fix abba deadlock on fastopen
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Wed, 12 Oct 2022 12:06:24 +0200
In-Reply-To: <cda1ff18-db08-712c-fecf-82a613809ff0@tessares.net>
References: <c23778554e349d0a85a34aba14affdac9f5164c5.1665510026.git.pabeni@redhat.com>
	 <bbd50fc8-150c-84db-5287-71911a91e9c7@tessares.net>
	 <0c51594362f1e64b9b2a45d10536051abf1e0470.camel@redhat.com>
	 <cda1ff18-db08-712c-fecf-82a613809ff0@tessares.net>
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
Content-Transfer-Encoding: 8bit

On Wed, 2022-10-12 at 11:38 +0200, Matthieu Baerts wrote:
> On 12/10/2022 11:10, Paolo Abeni wrote:
> > On Wed, 2022-10-12 at 10:22 +0200, Matthieu Baerts wrote:
> > > Thank you for having caught the issue and already provided the patch!
> > > 
> > > On 11/10/2022 19:40, Paolo Abeni wrote:
> > > > Our CI reported lockdep splat in the fastopen code:
> > > 
> > > (...)
> > > 
> > > > commit ("mptcp: factor out mptcp_connect()") will need some
> > > > mangling on top of this one.
> > > > 
> > > > A possible alternative would be targeting even the above to -net.
> > > > 
> > > > Not strictly required, but it will also make more striaght-forward/
> > > > legit the __inet_stream_connect() invocation here.
> > > 
> > > Indeed, we can. We would need more work around that anyway, no? (see my
> > > comment below)
> > > 
> > > > ---
> > > >  net/mptcp/protocol.c | 43 ++++++++++++++++++++++++++++++-------------
> > > >  1 file changed, 30 insertions(+), 13 deletions(-)
> > > > 
> > > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > > index f599ad44ed24..21f5676a60e8 100644
> > > > --- a/net/mptcp/protocol.c
> > > > +++ b/net/mptcp/protocol.c
> > > > @@ -1673,6 +1673,31 @@ static void mptcp_set_nospace(struct sock *sk)
> > > >  	set_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags);
> > > >  }
> > > >  
> > > > +static int mptcp_sendmsg_fastopen(struct sock *sk, struct sock *ssk, struct msghdr *msg,
> > > > +				  size_t len, int *copied_syn)
> > > > +{
> > > > +	unsigned int saved_flags = msg->msg_flags;
> > > > +	int ret;
> > > > +
> > > > +	lock_sock(ssk);
> > > > +	msg->msg_flags |= MSG_DONTWAIT;
> > > > +	ret = tcp_sendmsg_fastopen(ssk, msg, copied_syn, len, NULL);
> > > 
> > > Would it not be cleaner (and easier to maintain?) if a new parameter is
> > > added to tcp_sendmsg_fastopen() to force passing the O_NONBLOCK flag to
> > > __inet_stream_connect? Not to modify msg->msg_flags to have the
> > > behaviour we want.
> > 
> > Uhmmm... cleaner only for this call-site. It could be confusing adding
> > another parameter for blocking where there is already msg_flags for
> > that. And I'm personally against adding to many arguments to a single
> > function...
> 
> OK.
> I was suggesting that because tcp_sendmsg_fastopen() is only called once.
> I guess tcp_sendmsg_fastopen() will not be modified in a way that will
> break MPTCP support because we force MSG_DONTWAIT, so fine for me.
> 
> > > > +	msg->msg_flags = saved_flags;
> > > > +	release_sock(ssk);
> > > > +
> > > > +	/* do the blocking bits of inet_stream_connect outside the ssk socket lock*/
> > > 
> > > (I thought checkpatch.pl was complaining when there was no space before
> > > '*/' but it doesn't, all good :) )
> > > 
> > > > +	if (ret == -EINPROGRESS && !(msg->msg_flags & MSG_DONTWAIT)) {
> > > > +		ret = __inet_stream_connect(sk->sk_socket, msg->msg_name,
> > > > +					    msg->msg_namelen, msg->msg_flags, 1);
> > > 
> > > Without the commit ("mptcp: factor out mptcp_connect()"), would we need
> > > to call the -net version of mptcp_stream_connect() but without the lock?
> > 
> > Not strictly needed. I test this patch on export/net. Possibly cleaner.
> 
> OK, thank you!
> 
> > > > +
> > > > +		/* On connect hard error fastopen no bytes actually sent. */
> > > > +		if (ret && ret != -EINPROGRESS && ret != -ERESTARTSYS && ret != -EINTR)
> > > 
> > > The two last ones are there in case the "actual connect()" got
> > > interrupted, right?
> > 
> > Yes. Plain TCP consider copied_syn == 0 in that case. I did not find
> > any existing helper to match such condition. Perhapas a longer comment
> > may help.
> 
> Thank you for the explanation.
> Yes, maybe a longer comment but only if you have to send a v3.
> 
> > > > +			*copied_syn = 0;
> > > > +	}
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > >  static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> > > >  {
> > > >  	struct mptcp_sock *msk = mptcp_sk(sk);
> > > > @@ -1692,24 +1717,16 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> > > >  	lock_sock(sk);
> > > >  
> > > >  	ssock = __mptcp_nmpc_socket(msk);
> > > > -	if (unlikely(ssock && inet_sk(ssock->sk)->defer_connect)) {
> > > > -		struct sock *ssk = ssock->sk;
> > > > +	if (unlikely(ssock && (inet_sk(ssock->sk)->defer_connect ||
> > > > +			       msg->msg_flags & MSG_FASTOPEN))) {
> > > 
> > > Just above in this mptcp_sendmsg() function, we mention we don't support
> > > MSG_FASTOPEN yet. maybe we don't need to add this additional check now?
> > 
> > Thanks for catching it. This is a stray change from a previous
> > revision.
> > 
> > 
> > I can send a v2 addressing the above and cleaning up comments, but
> > AFAICS there is still pending the main question about including "mptcp:
> > factor out mptcp_connect()" in -net. Currently I think that could be
> > the better option.
> 
> It is fine for me to have the refactoring ("mptcp: factor out
> mptcp_connect()") sent to net. I can move it.
> 
> Do you think we need to modify the commit message? e.g. "Note that the
> fastopen call-path invokes mptcp_connect()" → only with MSG_FASTOPEN,
> not in -net.

I think "mptcp: factor out mptcp_connect()" will require quite a bit of
mangling to be move to -net, I'll send a -net version  together with v3
of this patch.

Thanks,

Paolo

