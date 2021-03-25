Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5640B5F
	for <mptcp@lists.linux.dev>; Thu, 25 Mar 2021 14:45:30 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1lPREm-0002vD-5E; Thu, 25 Mar 2021 15:45:28 +0100
Date: Thu, 25 Mar 2021 15:45:28 +0100
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev,
	mptcp@lists.01.org
Subject: Re: [MPTCP] [RFC PATCH mptcp-next v2 1/8] mptcp: add skeleton to
 sync msk socket options to subflows
Message-ID: <20210325144528.GB8998@breakpoint.cc>
References: <20210324131546.13730-1-fw@strlen.de>
 <20210324131546.13730-2-fw@strlen.de>
 <85febbb1c0b4dc7b73861fabdc846194f468f127.camel@redhat.com>
 <20210324200148.GL22603@breakpoint.cc>
 <2ee15b0397e7653f8d8cfd74d53398a6a5f0c19c.camel@redhat.com>
 <20210325124904.GB26567@breakpoint.cc>
 <205a6dd33129312123ca863a8bab4aca23dad96b.camel@redhat.com>
 <20210325140603.GA8998@breakpoint.cc>
 <027b859a6f5dd1f03ad6d1c56376dc19d5d2af5b.camel@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <027b859a6f5dd1f03ad6d1c56376dc19d5d2af5b.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> On Thu, 2021-03-25 at 15:06 +0100, Florian Westphal wrote:
> > Sorry, I am not following.
> > 
> > The ssk (s2 msk->first) has ssk->seq 1, s2 msk has 2, so this would be
> > synced again on completion.
> > 
> > I don't understand how s1 and s2 are related.
> > This is too complicated for me :(
> 
> s1 is an msk listener socket. It will get 2 setsockopt() syscall, so
> s1->sockopt_seq == 2.
> 
> Even s2->sockopt_seq == 2, as you noted.
> 
> If we copy msk->sockopt_seq into ssk->sockopt_seq, any additional MPJ
> subflow joining s2 created after the above syscalls sequence, will
> get sockopt_seq == 2, (inherited by s1->sockopt_seq), so will not be
> synched, even if synchronization will be needed.
> 
> Not sure if the above is less confusing ?!?

I would expect the new join ssk to have a 0 sequence number.

> > > Instead, if we set sockopt_seq to some socket status related value
> > > after every setsockopt(), s2->sockopt_seq and s1->sockopt_seq will be
> > > different and we will sync later MPJ subflows.
> > 
> > What is a 'socket status related value'?
> 
> I mean something that changes when 'sk->sk_state' changes. Even plain
> 'sk->sk_state'.

So instead of sync if msk->seq != ssk->seq we sync if
sk->sk_state != ssk->sk_state?

I don't understand how that works.

We might try to discuss this in the meeting, perhaps that would help?
