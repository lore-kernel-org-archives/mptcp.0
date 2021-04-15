Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5494A6D32
	for <mptcp@lists.linux.dev>; Thu, 15 Apr 2021 09:44:21 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1lWyXr-0002tF-JE; Thu, 15 Apr 2021 11:44:19 +0200
Date: Thu, 15 Apr 2021 11:44:19 +0200
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: ignore unsupported msg flags
Message-ID: <20210415094419.GI14932@breakpoint.cc>
References: <fb3746774c97c3042beb7d76cf9f23e57d7f85e1.1618413785.git.pabeni@redhat.com>
 <20210414155151.GG14932@breakpoint.cc>
 <d75da6f043ccb23b6dc0ef422cd25614427593ac.camel@redhat.com>
 <20210415082700.GH14932@breakpoint.cc>
 <bb30887a053765e34b6b7c0cf0db887b45397cd3.camel@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb30887a053765e34b6b7c0cf0db887b45397cd3.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> Looking at the code even MSG_DONTWAIT, MSG_EOR, MSG_MORE, MSG_OOB
> MSG_ZEROCOPY has some effect on TCP.

We handle DONTWAIT in mptcp, and the other ones, afaics, do not result
in a user-visible change (i.e., if we would not support DONTWAIT, we
would cause userspace do block in send() even if userspace specifically
asked for us not to, so that would be a bug).

But for the others I think ignoring is fine.

> MSG_ZEROCOPY needs to be enabled via setsockopt()
> 
> Currently we implement MSG_DONTWAIT, silently ignore MSG_MORE and we
> bail on MSG_OOB, MSG_EOR, MSG_ZEROCOPY
> 
> > > should we define a 'bail on use' mask with a subset of the above? The
> > > candidates I see are:
> >  
> > > MSG_TRUNC
> > > MSG_PEEK
> > > MSG_OOB
> > 
> > Looks like we only need to handle FASTOPEN.
> 
> LGTM, for sendmsg() sake: ignoring MSG_OOB and MSG_EOR does not look
> too evil to me ;)

Agree.

> Than there is recvmsg()...
> 
> With a quick code inspections looks like TCP support:
> MSG_PEEK, MSG_TRUNC, MSG_OOB, MSG_WAITALL, MSG_DONTWAIT, MSG_DONTWAIT, 
> MSG_ERRQUEUE
> 
> MSG_ERRQUEUE requires to be enabled via IP_RECVERR()
> 
> We currently implement MSG_WAITALL and MSG_DONTWAIT, soon MSG_PEEK and
> we bail on all the others.
> 
> Ignoring MSG_ERRQUEUE or MSG_TRUNC may silently break user-space
> application.

Indeed.

> I think we could provide a dummy impl for MSG_ERRQUEUE: always
> returning empty msg, which will be consistent with the lack of
> setsockopt support. We could even call into inet_recv_error(), as the
> relevant queue will always be empty, and could possibly simplify a
> complete implementation someday.
> 
> I also think we should bail on MSG_TRUNC, and silently ignore all the
> others.
> 
> WDYT?

Sounds good.  MSG_TRUNC support should be easy to add as well.
