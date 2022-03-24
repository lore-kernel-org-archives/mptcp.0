Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B0C7E
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 17:35:41 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1nXRN6-0008K5-3w; Thu, 24 Mar 2022 18:35:40 +0100
Date: Thu, 24 Mar 2022 18:35:40 +0100
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 4/4] mptcp: let mptcp listen dump show listen
 backlog size
Message-ID: <20220324173540.GB30280@breakpoint.cc>
References: <20220324135753.25182-1-fw@strlen.de>
 <20220324135753.25182-5-fw@strlen.de>
 <69492012a2c7630ff3b5c036992fbc497de2906a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69492012a2c7630ff3b5c036992fbc497de2906a.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> > -	r->idiag_rqueue = sk_rmem_alloc_get(sk);
> > -	r->idiag_wqueue = sk_wmem_alloc_get(sk);
> > +	if (inet_sk_state_load(sk) == TCP_LISTEN) {
> > +		r->idiag_rqueue = READ_ONCE(sk->sk_ack_backlog);
> > +		r->idiag_wqueue = READ_ONCE(sk->sk_max_ack_backlog);
> 
> What about accessing msk->first->sk*ack_backlog instead ? Are there any
> possible subtle races? Otherwise sk_ack_backlog will always be 0,
> right?

Yes, msk->first would be better here, will drop this patch
and merge the msk->first bit into preceeding one.
