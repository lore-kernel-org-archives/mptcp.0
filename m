Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF0429CA
	for <mptcp@lists.linux.dev>; Wed, 14 Apr 2021 16:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1618416483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+Ux+58CR4iMCtda9Tn+7E+kjt0GegfdlkqH1Z6v+nc=;
	b=Pgyjm5b2cBAIdx2cziowRIDFOK0O/bOtLqE3zxkX6TpquTsjjxJvkA6xYySlA0q77x8iGO
	y/6cp+fiT63FwQT396oaEUPMJUyaVQGGcsn95XKSLCJ67D2m357u0CUEdMMGR/3AOpmZ/c
	4ocvdAglM2W2B8N5AIGiCZxOn0DWLWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-voesO9reMUaebwL-aqcsMw-1; Wed, 14 Apr 2021 12:08:00 -0400
X-MC-Unique: voesO9reMUaebwL-aqcsMw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21DF1C73A5;
	Wed, 14 Apr 2021 16:07:59 +0000 (UTC)
Received: from ovpn-113-255.ams2.redhat.com (ovpn-113-255.ams2.redhat.com [10.36.113.255])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 616065D9D0;
	Wed, 14 Apr 2021 16:07:58 +0000 (UTC)
Message-ID: <d75da6f043ccb23b6dc0ef422cd25614427593ac.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] mptcp: ignore unsupported msg flags
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev
Date: Wed, 14 Apr 2021 18:07:57 +0200
In-Reply-To: <20210414155151.GG14932@breakpoint.cc>
References: <fb3746774c97c3042beb7d76cf9f23e57d7f85e1.1618413785.git.pabeni@redhat.com>
	 <20210414155151.GG14932@breakpoint.cc>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2021-04-14 at 17:51 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
> > Currently mptcp_sendmsg()/mptcp_recvmsg() fail with EOPNOTSUPP
> > if the user-space provides some unsupported flag. That is
> > unexpected and may foul existing applications migrated to MPTCP,
> > which expect a different behavior.
> > 
> > Change the mentioned function to silently ignore the unsupported
> > flags.
> > 
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/162
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> >  net/mptcp/protocol.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 2d895c3c8746..bdec946b9b04 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -1585,8 +1585,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
> >  	int ret = 0;
> >  	long timeo;
> >  
> > -	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL))
> > -		return -EOPNOTSUPP;
> > +	/* ignore unsupported flags */
> > +	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL;
> 
> Ignoring MSG_MORE is fine, but DONTWAIT and NOSIGNAL?

The intent of this patch is ignoring the unsupported flags. For sendmsg
that is all of them except MSG_MORE, MSG_DONTWAIT, MSG_NOSIGNAL:

MSG_OOB
MSG_PEEK
MSG_DONTROUTE
MSG_TRYHARD
MSG_CTRUNC
MSG_PROBE
MSG_TRUNC
MSG_EOR
MSG_FIN
MSG_SYN
MSG_CONFIRM
MSG_RST
MSG_ERRQUEUE
MSG_WAITFORONE
MSG_SENDPAGE_NOPOLICY
MSG_SENDPAGE_NOTLAST
MSG_BATCH
MSG_EOF
MSG_NO_SHARED_FRAGS
MSG_SENDPAGE_DECRYPTED
MSG_ZEROCOPY
MSG_FASTOPEN
MSG_CMSG_CLOEXEC

> I'd prefer hard errors for those until mptcp does the right thing for
> them.

should we define a 'bail on use' mask with a subset of the above? The
candidates I see are:

MSG_TRUNC
MSG_PEEK
MSG_OOB

Thanks,

Paolo

