Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE796F
	for <mptcp@lists.linux.dev>; Thu, 25 Mar 2021 14:06:12 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1lPQcd-0002gQ-1r; Thu, 25 Mar 2021 15:06:03 +0100
Date: Thu, 25 Mar 2021 15:06:03 +0100
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev,
	mptcp@lists.01.org
Subject: Re: [MPTCP] [RFC PATCH mptcp-next v2 1/8] mptcp: add skeleton to
 sync msk socket options to subflows
Message-ID: <20210325140603.GA8998@breakpoint.cc>
References: <20210324131546.13730-1-fw@strlen.de>
 <20210324131546.13730-2-fw@strlen.de>
 <85febbb1c0b4dc7b73861fabdc846194f468f127.camel@redhat.com>
 <20210324200148.GL22603@breakpoint.cc>
 <2ee15b0397e7653f8d8cfd74d53398a6a5f0c19c.camel@redhat.com>
 <20210325124904.GB26567@breakpoint.cc>
 <205a6dd33129312123ca863a8bab4aca23dad96b.camel@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <205a6dd33129312123ca863a8bab4aca23dad96b.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> > Ok, so you propose to init ssk->sockopt_seq to msk->sockopt_seq in
> > mptcp_accept()?
> 
> in subflow_syn_recv_sock(), but only if we can avoid incrementing  msk-
> >sockopt_seq on per setsockopt basis, otherwise things will be
> crippled:
> 
> socket(s1)
> setsockopt(s1)   // s1->seq 1
> listen(s1)
> 
> s2 = accept() s2->seq == s1->seq == ssk->seq
> 
> setsockopt(s2)   s2->seq = 2
> setsockopt(s1, <a different sockopt from the above>) s1->seq = 2
> 
> At this point, if we increment sockopt_seq after everu sockopt, s1-
> >sockopt_seq and s2->sockopt_seq will be equal (and we will not sync
> any mpj subflow accepted later if propagate sockopt_seq to ssk). 

Sorry, I am not following.

The ssk (s2 msk->first) has ssk->seq 1, s2 msk has 2, so this would be
synced again on completion.

I don't understand how s1 and s2 are related.
This is too complicated for me :(

> Instead, if we set sockopt_seq to some socket status related value
> after every setsockopt(), s2->sockopt_seq and s1->sockopt_seq will be
> different and we will sync later MPJ subflows.

What is a 'socket status related value'?

> Perhaps we can keep the things as-is to and ev change/improve in a
> second time?

I am confused, you mean leave it as-is, i.e. scratch this patch set
and retry (new per-subflow sockopt api for instance)?

Or leave this RFC v2 as-is and see if we can improve the sync strategy
later?
