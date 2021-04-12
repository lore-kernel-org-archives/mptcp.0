Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8800270
	for <mptcp@lists.linux.dev>; Mon, 12 Apr 2021 08:05:42 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1lVrZb-0004EP-Bk; Mon, 12 Apr 2021 10:05:31 +0200
Date: Mon, 12 Apr 2021 10:05:31 +0200
From: Florian Westphal <fw@strlen.de>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Florian Westphal <fw@strlen.de>, Paolo Abeni <pabeni@redhat.com>,
	mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp 02/10] mptcp: tag sequence_seq with socket state
Message-ID: <20210412080531.GA14932@breakpoint.cc>
References: <20210408184936.6245-1-fw@strlen.de>
 <20210408184936.6245-3-fw@strlen.de>
 <9f60e0e9-a44f-b659-14f6-f91161cf6569@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f60e0e9-a44f-b659-14f6-f91161cf6569@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
> On Thu, 8 Apr 2021, Florian Westphal wrote:
> 
> > +	return sk->sk_state << 24u;
> 
> I think this works because sk->sk_state gets automatically promoted to an
> int, but maybe "(u32)sk->sk_state << 24" is the intent?

Yes, I can add an explicit cast.

> What I didn't realize at that time was that mptcp_sockopt_sync_all() might
> not be called for a very long time (or at all?) if there are no joins to
> trigger it. To really protect against overflow, mptcp_setsockopt() can call
> (or schedule) mptcp_sockopt_sync_all() if the non-sk_state bits of
> msk->setsockopt_seq exceed a threshold.

Next patch adds sockopt_seq_inc() which is supposed to guarantee that it
never wraps to 0.  I can change it so it will wrap in the 24bit sequence
space only, so it would cycle back to sk->sk_state << 24u.
