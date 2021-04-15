Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C016D32
	for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 09:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1618479189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJakeu1hL+S6XhOHwIjijLCfNUYQqumjmL5vzOs+7R0=;
	b=eZUu4E+sj1QUnSqdA3SAY2vqU2s6ODEhWEhzL2wdWzUoEd6TDykDiBwin4azmvVEwvYszY
	Ak38x9bH/tZfM80Sfvw1Wi+lsvxvDDd47BOLcTthcQQMXKZdzn0oS+WlhE0IPCslqcBWew
	sbvaUHiiN4LvLad/wS0UONgkt+vzMH4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-I84pSdIBPRe_T3V2QqTiHA-1; Thu, 15 Apr 2021 05:33:07 -0400
X-MC-Unique: I84pSdIBPRe_T3V2QqTiHA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44D91802B40;
	Thu, 15 Apr 2021 09:33:06 +0000 (UTC)
Received: from ovpn-115-128.ams2.redhat.com (ovpn-115-128.ams2.redhat.com [10.36.115.128])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 77EB210027C4;
	Thu, 15 Apr 2021 09:33:04 +0000 (UTC)
Message-ID: <bb30887a053765e34b6b7c0cf0db887b45397cd3.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] mptcp: ignore unsupported msg flags
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev
Date: Thu, 15 Apr 2021 11:33:03 +0200
In-Reply-To: <20210415082700.GH14932@breakpoint.cc>
References: <fb3746774c97c3042beb7d76cf9f23e57d7f85e1.1618413785.git.pabeni@redhat.com>
	 <20210414155151.GG14932@breakpoint.cc>
	 <d75da6f043ccb23b6dc0ef422cd25614427593ac.camel@redhat.com>
	 <20210415082700.GH14932@breakpoint.cc>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2021-04-15 at 10:27 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
> > The intent of this patch is ignoring the unsupported flags. For sendmsg
> > that is all of them except MSG_MORE, MSG_DONTWAIT, MSG_NOSIGNAL:
> > 
> > MSG_OOB
> > MSG_PEEK
> > MSG_DONTROUTE
> > MSG_TRYHARD
> > MSG_CTRUNC
> > MSG_PROBE
> > MSG_TRUNC
> > MSG_EOR
> > MSG_FIN
> > MSG_SYN
> > MSG_CONFIRM
> > MSG_RST
> > MSG_ERRQUEUE
> > MSG_WAITFORONE
> > MSG_SENDPAGE_NOPOLICY
> > MSG_SENDPAGE_NOTLAST
> > MSG_BATCH
> > MSG_EOF
> > MSG_NO_SHARED_FRAGS
> > MSG_SENDPAGE_DECRYPTED
> > MSG_ZEROCOPY
> > MSG_FASTOPEN
> > MSG_CMSG_CLOEXEC
> 
> Looks like TCP ignores all of them except fastopen:
> 
> sendto(5, "foo\n", 4, 0, NULL, 0)       = 4
> sendto(5, "foo\n", 4, MSG_OOB, NULL, 0) = 4
> sendto(5, "foo\n", 4, MSG_PEEK, NULL, 0) = 4
> sendto(5, "foo\n", 4, MSG_DONTROUTE, NULL, 0) = 4
> sendto(5, "foo\n", 4, MSG_CTRUNC, NULL, 0) = 4
> sendto(5, "foo\n", 4, MSG_PROBE, NULL, 0) = 4
> sendto(5, "foo\n", 4, MSG_TRUNC, NULL, 0) = 4
> sendto(5, "foo\n", 4, MSG_DONTWAIT, NULL, 0) = 4
> sendto(5, "foo\n", 4, MSG_EOR, NULL, 0) = 4
> sendto(5, "foo\n", 4, MSG_WAITALL, NULL, 0) = 4
> sendto(5, "foo\n", 4, MSG_FIN, NULL, 0) = 4
> sendto(5, "foo\n", 4, MSG_SYN, NULL, 0) = 4
> sendto(5, "foo\n", 4, MSG_CONFIRM, NULL, 0) = 4
> sendto(5, "foo\n", 4, MSG_RST, NULL, 0) = 4
> sendto(5, "foo\n", 4, MSG_ERRQUEUE, NULL, 0) = 4
> sendto(5, "foo\n", 4, MSG_NOSIGNAL, NULL, 0) = 4
> sendto(5, "foo\n", 4, MSG_MORE, NULL, 0) = 4
> sendto(5, "foo\n", 4, MSG_WAITFORONE, NULL, 0) = 4
> sendto(5, "foo\n", 4, MSG_SENDPAGE_NOTLAST, NULL, 0) = 4
> sendto(5, "foo\n", 4, MSG_BATCH, NULL, 0) = 4
> sendto(5, "foo\n", 4, MSG_NO_SHARED_FRAGS, NULL, 0) = 4
> sendto(5, "foo\n", 4, 0x100000 /* MSG_??? */, NULL, 0) = 4
> sendto(5, "foo\n", 4, 0x200000 /* MSG_??? */, NULL, 0) = 4
> sendto(5, "foo\n", 4, 0x400000 /* MSG_??? */, NULL, 0) = 4
> sendto(5, "foo\n", 4, 0x800000 /* MSG_??? */, NULL, 0) = 4
> sendto(5, "foo\n", 4, 0x1000000 /* MSG_??? */, NULL, 0) = 4
> sendto(5, "foo\n", 4, 0x2000000 /* MSG_??? */, NULL, 0) = 4
> sendto(5, "foo\n", 4, MSG_ZEROCOPY, NULL, 0) = 4
> sendto(5, "foo\n", 4, 0x8000000 /* MSG_??? */, NULL, 0) = 4
> sendto(5, "foo\n", 4, 0x10000000 /* MSG_??? */, NULL, 0) = 4
> sendto(5, "foo\n", 4, MSG_FASTOPEN, NULL, 0) = -1 EISCONN (Transport
> 		endpoint is already connected)
> sendto(5, "foo\n", 4, MSG_CMSG_CLOEXEC, NULL, 0) = 4
> sendto(5, "foo\n", 4, MSG_CMSG_COMPAT, NULL, 0) = 4
> 
> (fd 4 is a established tcp socket, after successful connect()).

Thank you for the estensive testing!

Looking at the code even MSG_DONTWAIT, MSG_EOR, MSG_MORE, MSG_OOB
MSG_ZEROCOPY has some effect on TCP.

MSG_ZEROCOPY needs to be enabled via setsockopt()

Currently we implement MSG_DONTWAIT, silently ignore MSG_MORE and we
bail on MSG_OOB, MSG_EOR, MSG_ZEROCOPY

> > should we define a 'bail on use' mask with a subset of the above? The
> > candidates I see are:
>  
> > MSG_TRUNC
> > MSG_PEEK
> > MSG_OOB
> 
> Looks like we only need to handle FASTOPEN.

LGTM, for sendmsg() sake: ignoring MSG_OOB and MSG_EOR does not look
too evil to me ;)

Than there is recvmsg()...

With a quick code inspections looks like TCP support:
MSG_PEEK, MSG_TRUNC, MSG_OOB, MSG_WAITALL, MSG_DONTWAIT, MSG_DONTWAIT, 
MSG_ERRQUEUE

MSG_ERRQUEUE requires to be enabled via IP_RECVERR()

We currently implement MSG_WAITALL and MSG_DONTWAIT, soon MSG_PEEK and
we bail on all the others.

Ignoring MSG_ERRQUEUE or MSG_TRUNC may silently break user-space
application.

I think we could provide a dummy impl for MSG_ERRQUEUE: always
returning empty msg, which will be consistent with the lack of
setsockopt support. We could even call into inet_recv_error(), as the
relevant queue will always be empty, and could possibly simplify a
complete implementation someday.

I also think we should bail on MSG_TRUNC, and silently ignore all the
others.

WDYT?

Thanks!

Paolo

