Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDC85F
	for <mptcp@lists.linux.dev>; Wed, 24 Mar 2021 20:01:50 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1lP9hM-0005hl-OM; Wed, 24 Mar 2021 21:01:48 +0100
Date: Wed, 24 Mar 2021 21:01:48 +0100
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev,
	mptcp@lists.01.org
Subject: Re: [MPTCP] [RFC PATCH mptcp-next v2 1/8] mptcp: add skeleton to
 sync msk socket options to subflows
Message-ID: <20210324200148.GL22603@breakpoint.cc>
References: <20210324131546.13730-1-fw@strlen.de>
 <20210324131546.13730-2-fw@strlen.de>
 <85febbb1c0b4dc7b73861fabdc846194f468f127.camel@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85febbb1c0b4dc7b73861fabdc846194f468f127.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> On Wed, 2021-03-24 at 14:15 +0100, Florian Westphal wrote:
> > Handle following cases:
> > 1. setsockopt is called with multiple subflows.
> >    Change might have to be mirrored to all of them.
> >    This is done directly in process context/setsockopt call.
> > 2. Outgoing subflow is created after one or several setsockopt()
> >    calls have been made.  Old setsockopt changes should be
> >    synced to the new socket.
> > 3. Incoming subflow, after setsockopt call(s).
> > 
> > Cases 2 and 3 are handled right after the join list is spliced to the
> > conn list.
> > 
> > Because splicing is sometimes done from non-preemptible context, the
> > sync action can be deferred to the work queue.
> > 
> > Add sequence numbers to subflow context and mptcp socket so
> > synchronization functions know which subflow is already updated
> > and which are not.
> > 
> > seqno is re-set to 1 in mptcp_sockopt_sync_all(), at this point
> > the list of subflows is up to date.
> > 
> > A setsockopt sequence count of 0 means that no setsockopt call
> > was made so no synchronization is needed.
> > 
> > Signed-off-by: Florian Westphal <fw@strlen.de>
> 
> If I read correctly, each incoming subflow always get setsockopt_seq =
> 0 at accept time, while outgoing subflow are always synced at creation
> time.

Yes, outgoing are synced at creation time.

> It looks like we have 2 semantically different 'msk->setsockopt_seq'
> values:
> * 0 -> no sync required
> * any value greater than 0 -> sync required for incoming subflows.
> 
> If so, setsockopt could always set msk->setsockopt_seq to 1 and no need
> to reset after sync_all.

In the outgoing case, the subflow isn't linked to the conn_list yet.

It syncs current msk settings, but user could setsockopt() before
the connect finishes, in that case another sync is needed after
connection completes.  No idea how to handle this with single toggle
bit.

I could make it so that it always re-syncs after connect/join finishes.

> socket()
> sesockopt()
> listen()
> // msks is accepted, msk->setsockopt_seq != 0
> // mpj subflow is accepted, ssk->setsockopt_seq == 0, the mpj ssk
> inherited from the listener socket the same sockoptions of the msk/mpc
> subflow

I'm not sure all options have this 'inherited from listener' behaviour.
