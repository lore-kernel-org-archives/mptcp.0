Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9862C80
	for <mptcp@lists.linux.dev>; Wed, 10 Nov 2021 11:49:22 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1mkm6S-0001sA-Sr; Wed, 10 Nov 2021 12:49:20 +0100
Date: Wed, 10 Nov 2021 12:49:20 +0100
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 3/3] mptcp: add SIOCINQ, OUTQ and OUTQNSD
 ioctls
Message-ID: <20211110114920.GH16363@breakpoint.cc>
References: <7bfe33f96550ffd6efaa3266f6027a8d7c500b70.camel@redhat.com>
 <67929b99f9baaf448457bf2cd5efce430dd1a2d9.camel@redhat.com>
 <20211110113751.GG16363@breakpoint.cc>
 <9ebe8731335efceb98088549fbdfd1f1a2bed92c.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ebe8731335efceb98088549fbdfd1f1a2bed92c.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> > Bah.  You are right. TBH I do not understand READ|WRITE_ONCE usage in
> > mptcp anymore.  Maybe its correct, who knows.
> > 
> > The different locking schemes are not easy to follow for me.
> 
> Indeed I agreed!
> 
> I *think* (mostly guess) some _ONCE() annotation are now obsoleted/made
> unnecessary by the several re-factors.
> 
> For sure we need to document clarely the locking schema (where? how?
> would comments on the protectect fields suffice?) and possibly/likely
> review the current annotations.

I think adding comments in the mptcp_sock struct would be a great start.

> > > BTW this always reports '1' on fallback sockets after shutdown, as
> > > after shutdown write_seq is incremented by 1, but snd_una/snd_nxt are
> > > not incremented when receiving the TCP fin. I guess the fix not
> > > strictly related to this patch.
> > 
> > That should be ok, we should return nonzero inq hint when next read()
> > would indicate EOF.
> 
> This is for the outq ?!? I think it should be 0 after all outstanding
> data is acked ?!?

Oh, I misread it as inq.
