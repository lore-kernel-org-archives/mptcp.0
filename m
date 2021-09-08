Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858AF72
	for <mptcp@lists.linux.dev>; Wed,  8 Sep 2021 15:42:39 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1mNzie-0005R1-OV; Wed, 08 Sep 2021 17:42:36 +0200
Date: Wed, 8 Sep 2021 17:42:36 +0200
From: Florian Westphal <fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	mptcp@lists.linux.dev
Subject: Re: [mptcp-next 0/2] Fix mptcp connection hangs after link failover
Message-ID: <20210908154236.GH23554@breakpoint.cc>
References: <20210906131045.18513-1-fw@strlen.de>
 <e7135787-ee9c-dcef-d569-ceee8a3298b4@linux.intel.com>
 <20210908082050.GG23554@breakpoint.cc>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908082050.GG23554@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)

Florian Westphal <fw@strlen.de> wrote:
> Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
> > On Mon, 6 Sep 2021, Florian Westphal wrote:
> > 
> > > First patch is preparation work: tx_pending_data counter is unreliable.
> > > Second patch fixes premature stop of the retransmit timer.
> > > 
> > > Florian Westphal (2):
> > >  mptcp: remove tx_pending_data
> > >  mptcp: re-set push-pending bit on retransmit failure
> > > 
> > > net/mptcp/protocol.c | 32 +++++++++++++++++++++++++-------
> > > net/mptcp/protocol.h |  1 -
> > > 2 files changed, 25 insertions(+), 8 deletions(-)
> > > 
> > > -- 
> > > 2.32.0
> > 
> > The code changes look ok, and I don't see any copyfd_io_poll errors. But I
> > do get consistent failures in the same group of self tests related to stale
> > links and recovery:
> > 
> > 15 multiple flows, signal, link failure syn[ ok ] - synack[ ok ] - ack[ ok ]
> >                                         add[ ok ] - echo  [ ok ]
> >                                         stale             [fail] got 0
> > stale[s] 0 recover[s],   expected stale in range [1..5],  stale-recover
> > delta 1
> 
> I'm on export, 9c7d1b9a14eba479466423d64f99c8a4e29b66f4, with these two
> patches and I don't see this error.
> 
> Running mptcp_join -l in a loop now, no luck so far.

Gave up, its not triggering for me.

Any hints on reproducing this?

Does it pass for you without my changes?

I don't see how they would cause this; if anything this patch makes
the stale detection reliable because the retrans timer is not stopped
too early anymore and it makes sure that mptcp_subflow_get_retrans() is
called once for each retrans timer call.
