Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232D36D13
	for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 08:27:01 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1lWxL2-0002Qh-3y; Thu, 15 Apr 2021 10:27:00 +0200
Date: Thu, 15 Apr 2021 10:27:00 +0200
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: ignore unsupported msg flags
Message-ID: <20210415082700.GH14932@breakpoint.cc>
References: <fb3746774c97c3042beb7d76cf9f23e57d7f85e1.1618413785.git.pabeni@redhat.com>
 <20210414155151.GG14932@breakpoint.cc>
 <d75da6f043ccb23b6dc0ef422cd25614427593ac.camel@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d75da6f043ccb23b6dc0ef422cd25614427593ac.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> The intent of this patch is ignoring the unsupported flags. For sendmsg
> that is all of them except MSG_MORE, MSG_DONTWAIT, MSG_NOSIGNAL:
> 
> MSG_OOB
> MSG_PEEK
> MSG_DONTROUTE
> MSG_TRYHARD
> MSG_CTRUNC
> MSG_PROBE
> MSG_TRUNC
> MSG_EOR
> MSG_FIN
> MSG_SYN
> MSG_CONFIRM
> MSG_RST
> MSG_ERRQUEUE
> MSG_WAITFORONE
> MSG_SENDPAGE_NOPOLICY
> MSG_SENDPAGE_NOTLAST
> MSG_BATCH
> MSG_EOF
> MSG_NO_SHARED_FRAGS
> MSG_SENDPAGE_DECRYPTED
> MSG_ZEROCOPY
> MSG_FASTOPEN
> MSG_CMSG_CLOEXEC

Looks like TCP ignores all of them except fastopen:

sendto(5, "foo\n", 4, 0, NULL, 0)       = 4
sendto(5, "foo\n", 4, MSG_OOB, NULL, 0) = 4
sendto(5, "foo\n", 4, MSG_PEEK, NULL, 0) = 4
sendto(5, "foo\n", 4, MSG_DONTROUTE, NULL, 0) = 4
sendto(5, "foo\n", 4, MSG_CTRUNC, NULL, 0) = 4
sendto(5, "foo\n", 4, MSG_PROBE, NULL, 0) = 4
sendto(5, "foo\n", 4, MSG_TRUNC, NULL, 0) = 4
sendto(5, "foo\n", 4, MSG_DONTWAIT, NULL, 0) = 4
sendto(5, "foo\n", 4, MSG_EOR, NULL, 0) = 4
sendto(5, "foo\n", 4, MSG_WAITALL, NULL, 0) = 4
sendto(5, "foo\n", 4, MSG_FIN, NULL, 0) = 4
sendto(5, "foo\n", 4, MSG_SYN, NULL, 0) = 4
sendto(5, "foo\n", 4, MSG_CONFIRM, NULL, 0) = 4
sendto(5, "foo\n", 4, MSG_RST, NULL, 0) = 4
sendto(5, "foo\n", 4, MSG_ERRQUEUE, NULL, 0) = 4
sendto(5, "foo\n", 4, MSG_NOSIGNAL, NULL, 0) = 4
sendto(5, "foo\n", 4, MSG_MORE, NULL, 0) = 4
sendto(5, "foo\n", 4, MSG_WAITFORONE, NULL, 0) = 4
sendto(5, "foo\n", 4, MSG_SENDPAGE_NOTLAST, NULL, 0) = 4
sendto(5, "foo\n", 4, MSG_BATCH, NULL, 0) = 4
sendto(5, "foo\n", 4, MSG_NO_SHARED_FRAGS, NULL, 0) = 4
sendto(5, "foo\n", 4, 0x100000 /* MSG_??? */, NULL, 0) = 4
sendto(5, "foo\n", 4, 0x200000 /* MSG_??? */, NULL, 0) = 4
sendto(5, "foo\n", 4, 0x400000 /* MSG_??? */, NULL, 0) = 4
sendto(5, "foo\n", 4, 0x800000 /* MSG_??? */, NULL, 0) = 4
sendto(5, "foo\n", 4, 0x1000000 /* MSG_??? */, NULL, 0) = 4
sendto(5, "foo\n", 4, 0x2000000 /* MSG_??? */, NULL, 0) = 4
sendto(5, "foo\n", 4, MSG_ZEROCOPY, NULL, 0) = 4
sendto(5, "foo\n", 4, 0x8000000 /* MSG_??? */, NULL, 0) = 4
sendto(5, "foo\n", 4, 0x10000000 /* MSG_??? */, NULL, 0) = 4
sendto(5, "foo\n", 4, MSG_FASTOPEN, NULL, 0) = -1 EISCONN (Transport
		endpoint is already connected)
sendto(5, "foo\n", 4, MSG_CMSG_CLOEXEC, NULL, 0) = 4
sendto(5, "foo\n", 4, MSG_CMSG_COMPAT, NULL, 0) = 4

(fd 4 is a established tcp socket, after successful connect()).

> should we define a 'bail on use' mask with a subset of the above? The
> candidates I see are:
 
> MSG_TRUNC
> MSG_PEEK
> MSG_OOB

Looks like we only need to handle FASTOPEN.
