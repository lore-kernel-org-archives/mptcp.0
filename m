Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539FB6F
	for <mptcp@lists.linux.dev>; Wed, 24 Mar 2021 17:15:49 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1lP76h-0004y7-19; Wed, 24 Mar 2021 18:15:47 +0100
Date: Wed, 24 Mar 2021 18:15:47 +0100
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev,
	mptcp@lists.01.org
Subject: Re: [MPTCP] [RFC PATCH mptcp-next v2 3/8] mptcp: setsockopt: handle
 receive/send buffer and device bind
Message-ID: <20210324171547.GK22603@breakpoint.cc>
References: <20210324131546.13730-1-fw@strlen.de>
 <20210324131546.13730-4-fw@strlen.de>
 <1c0d6fff2e9c3aa94d427d836d5922597adba644.camel@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c0d6fff2e9c3aa94d427d836d5922597adba644.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> On Wed, 2021-03-24 at 14:15 +0100, Florian Westphal wrote:
> > @@ -441,6 +465,12 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
> >  	}
> >  
> >  	ssk->sk_priority = sk->sk_priority;
> > +	ssk->sk_bound_dev_if = sk->sk_bound_dev_if;
> > +
> > +	if (sk->sk_userlocks & SOCK_SNDBUF_LOCK)
> > +		WRITE_ONCE(ssk->sk_sndbuf, sk->sk_sndbuf);
> > +	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
> > +		WRITE_ONCE(ssk->sk_rcvbuf, sk->sk_rcvbuf);
> 
> Don't we need also:
> 
> 	ssk->sk_userlocks = sk->sk_userlocks;

Yes, right.
