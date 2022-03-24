Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81457E
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 17:07:49 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1nXQw4-00089h-Sc; Thu, 24 Mar 2022 18:07:44 +0100
Date: Thu, 24 Mar 2022 18:07:44 +0100
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 3/4] mptcp: listen diag dump support
Message-ID: <20220324170744.GA30280@breakpoint.cc>
References: <20220324135753.25182-1-fw@strlen.de>
 <20220324135753.25182-4-fw@strlen.de>
 <4e72bdc521dd29c791a51b85700a54a03aba4c00.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e72bdc521dd29c791a51b85700a54a03aba4c00.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> On Thu, 2022-03-24 at 14:57 +0100, Florian Westphal wrote:
> > makes 'ss -Ml' show mptcp listen sockets.
> > 
> > Signed-off-by: Florian Westphal <fw@strlen.de>
> > ---
> >  net/mptcp/mptcp_diag.c | 67 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> > 
> > diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
> > index c4992eeb67d8..6a6dfc7eac33 100644
> > --- a/net/mptcp/mptcp_diag.c
> > +++ b/net/mptcp/mptcp_diag.c
> > @@ -69,6 +69,8 @@ static int mptcp_diag_dump_one(struct netlink_callback *cb,
> >  struct mptcp_diag_ctx {
> >  	long s_slot;
> >  	long s_num;
> > +	unsigned int l_slot;
> > +	unsigned int l_num;
> >  };
> >  
> >  static void mptcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
> > @@ -114,6 +116,71 @@ static void mptcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
> >  		}
> >  		cond_resched();
> >  	}
> > +
> > +	if (r->idiag_states & TCPF_LISTEN) {
> > +		int i;
> 
> perhaps here we need to add something alike:
> 
> 		if (r->id.idiag_dport)
> 			return;
[..]

> Also, what about moving the following chunk in separate helper -
> mptcp_diag_dump_listener()?
Changed to:

if ((r->idiag_states & TCPF_LISTEN) && r->id.idiag_dport == 0)
            mptcp_diag_dump_listeners(skb, cb, r, net_admin);
