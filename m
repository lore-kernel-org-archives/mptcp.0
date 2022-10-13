Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8372CA4
	for <mptcp@lists.linux.dev>; Thu, 13 Oct 2022 12:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1665663596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vIISMPIM3gpiLvzqCEzFsR3p7VenxdRNwIWCBQlvKwU=;
	b=YW8IszZ6CKp8k6LwoB8cda9FgyACxM9alPCmDdSzXm4X+tENWJWTxuGshVRIpeY0J9OVkW
	TcicT6gkHZPzM5tcqqgJLVWHbnrmebQaGus0nfcmO9S0SUWhAFEePRc4KVYXXMpcsJ2wS7
	EndMXJdW3pqGJ57rxrI3ADaz8z+JThk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-157-HcLvy7bhM1yvDY6Hua2scA-1; Thu, 13 Oct 2022 08:19:55 -0400
X-MC-Unique: HcLvy7bhM1yvDY6Hua2scA-1
Received: by mail-wm1-f70.google.com with SMTP id i7-20020a1c3b07000000b003c6d18a7ee5so295205wma.6
        for <mptcp@lists.linux.dev>; Thu, 13 Oct 2022 05:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vIISMPIM3gpiLvzqCEzFsR3p7VenxdRNwIWCBQlvKwU=;
        b=jxzw7+GY+lUv26mfB17DEsScKVLT3OokWIQpjis6lhtQQwjpA31Kxti1eqkWPawo9p
         a2uNjlDRZLNN8Hq3or/t66frnX/PrujJEwAXPFla/WAOAwFt5hYtUzEy1VQ0ZE+6KMEm
         49amZSOEXEqAeNtVh2/RnTht7ThhCPo9tDhJFXH19eTX/Wp/er+mdDplO7MANtHcd/9p
         7mYDEb+JEARcIh2CA1BeTMVzjqkkAvm8JMXu3fIhDHCg+ZyfvkYW6fwxMwA6ushBlpNN
         MKhhH3UDVN3VhD7GJVWOEi5FuGPCONcxjyK/AEXARCh/BefJ1sVyE0pPw0WlSUVswHF9
         J99g==
X-Gm-Message-State: ACrzQf3rb63Xo60zkdPwJuagG9/M1Oem7mP8ZGqoVBaWkFSsHpXROd0D
	fmTlWYy8BlB+ou7iUQgE0qJgdmOW7xuHmjoVwrazfkM+JcIf3fHgZW12FNyat8uOyqUgBp5Bdln
	g6l+wXp0QVCUscrQ=
X-Received: by 2002:a05:6000:1203:b0:22e:3a70:4c94 with SMTP id e3-20020a056000120300b0022e3a704c94mr21308682wrx.713.1665663593872;
        Thu, 13 Oct 2022 05:19:53 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6QLJF1LXBwzF/wgK0Xzmbs2PEbMuWV3jLTrt/OO9PR7QLpyAhTwrnQXLy9KN/Grx4BHaJMfA==
X-Received: by 2002:a05:6000:1203:b0:22e:3a70:4c94 with SMTP id e3-20020a056000120300b0022e3a704c94mr21308665wrx.713.1665663593601;
        Thu, 13 Oct 2022 05:19:53 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-103-235.dyn.eolo.it. [146.241.103.235])
        by smtp.gmail.com with ESMTPSA id q65-20020a1c4344000000b003a8434530bbsm4397888wma.13.2022.10.13.05.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 05:19:53 -0700 (PDT)
Message-ID: <4ce32959a049f5fcb34e98dc761af5d022fd8607.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v3] mptcp: fix abba deadlock on fastopen
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Thu, 13 Oct 2022 14:19:52 +0200
In-Reply-To: <dee06f30-f5ea-deb3-9d40-b4f7a5d460df@tessares.net>
References: <7c61250080c052b9dfb42a023c85dc36d4450daf.1665584136.git.pabeni@redhat.com>
	 <dee06f30-f5ea-deb3-9d40-b4f7a5d460df@tessares.net>
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

On Wed, 2022-10-12 at 17:39 +0200, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 12/10/2022 16:48, Paolo Abeni wrote:
> > Our CI reported lockdep splat in the fastopen code:
> 
> (...)
> 
> > The problem is caused by the blocking inet_wait_for_connect() releasing
> > and re-acquiring the msk socket lock while the subflow socket lock is
> > still held and the MPTCP socket requires that the msk socket lock must
> > be acquired before the subflow socket lock.
> > 
> > Address the issue always invoking tcp_sendmsg_fastopen() in an
> > unblocking manner, and later eventually complete the blocking
> > __inet_stream_connect() as needed.
> 
> Thank you for the v3!
> 
> I just have one last question here below (+ 2 small comments but a v4 is
> probably not needed):
> 
> (...)
> 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 1cdf9cd1a3cc..82d899233df4 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -1673,6 +1673,37 @@ static void mptcp_set_nospace(struct sock *sk)
> >  	set_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags);
> >  }
> >  
> > +static int mptcp_sendmsg_fastopen(struct sock *sk, struct sock *ssk, struct msghdr *msg,
> > +				  size_t len, int *copied_syn)
> > +{
> > +	unsigned int saved_flags = msg->msg_flags;
> > +	struct mptcp_sock *msk = mptcp_sk(sk);
> > +	int ret;
> > +
> > +	lock_sock(ssk);
> > +	msg->msg_flags |= MSG_DONTWAIT;
> > +	msk->connect_flags = O_NONBLOCK;
> 
> Just to be sure I understand properly: here O_NONBLOCK is set but that
> will only be used for the subflow and only if MSG_FASTOPEN is set (and
> allowed), so not for TCP_FASTOPEN_CONNECT, right?
> 
> But no need to reset them later, right?
> 
> (I'm a bit confused by the fact we set msk->connect_flags in
> mptcp_stream_connect() before calling __inet_stream_connect() and not
> here below)

You are right, that is actually not obvious. The later
__inet_stream_connect() call will not reach mptcp_stream_connect(),
will perform only the inet_wait_for_connect() bits, so the
connect_flags will be unused.
> 
> > +	msk->is_sendmsg = 1;
> > +	ret = tcp_sendmsg_fastopen(ssk, msg, copied_syn, len, NULL);
> > +	msk->is_sendmsg = 0;
> > +	msg->msg_flags = saved_flags;
> > +	release_sock(ssk);
> > +
> > +	/* do the blocking bits of inet_stream_connect outside the ssk socket lock */
> > +	if (ret == -EINPROGRESS && !(msg->msg_flags & MSG_DONTWAIT)) {
> > +		ret = __inet_stream_connect(sk->sk_socket, msg->msg_name,
> > +					    msg->msg_namelen, msg->msg_flags, 1);
> > +
> > +		/* Keep the same behaviout of plain TCP: zero the copied bytes in
> 
> s/behaviout/behaviour/ but I can fix that when applying the patch, I
> guess "checkpatch.pl --codespell" will remind me that.
> 
> > +		 * case of any error, except timeout or signal
> > +		 */
> > +		if (ret && ret != -EINPROGRESS && ret != -ERESTARTSYS && ret != -EINTR)
> > +			*copied_syn = 0;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >  static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> >  {
> >  	struct mptcp_sock *msk = mptcp_sk(sk);
> > @@ -1693,26 +1724,14 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> >  
> >  	ssock = __mptcp_nmpc_socket(msk);
> >  	if (unlikely(ssock && inet_sk(ssock->sk)->defer_connect)) {
> > -		struct sock *ssk = ssock->sk;
> >  		int copied_syn = 0;
> >  
> > -		lock_sock(ssk);
> > -
> > -		msk->connect_flags = (msg->msg_flags & MSG_DONTWAIT) ? O_NONBLOCK : 0;
> > -		msk->is_sendmsg = 1;
> > -		ret = tcp_sendmsg_fastopen(ssk, msg, &copied_syn, len, NULL);
> > -		msk->is_sendmsg = 0;
> > +		ret = mptcp_sendmsg_fastopen(sk, ssock->sk, msg, len, &copied_syn);
> 
> 
> It might look a bit strange to add some code here and then move it to a
> dedicated function in the following commit but I'm sure that will be
> fine for other net maintainers! :-)

If you prefer I can rework the 'factor out' patch to make this change
more straight-forward.

Cheers,

Paolo

