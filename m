Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0486F
	for <mptcp@lists.linux.dev>; Thu, 25 Mar 2021 09:32:09 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1lPMLW-00013V-Va; Thu, 25 Mar 2021 10:32:07 +0100
Date: Thu, 25 Mar 2021 10:32:06 +0100
From: Florian Westphal <fw@strlen.de>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev,
	mptcp@lists.01.org
Subject: Re: [RFC PATCH mptcp-next v2 5/8] mptcp: setsockopt: add SO_MARK
 support
Message-ID: <20210325093206.GA26567@breakpoint.cc>
References: <20210324131546.13730-1-fw@strlen.de>
 <20210324131546.13730-6-fw@strlen.de>
 <c4fbd91c-2873-956b-df8-7bba2da711f@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4fbd91c-2873-956b-df8-7bba2da711f@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
> On Wed, 24 Mar 2021, Florian Westphal wrote:
> 
> > Value is synced to all subflows.
> > 
> 
> The use case I remember for SO_MARK with MPTCP was to designate different
> interfaces for different subflows:
> 
> https://lore.kernel.org/mptcp/CAKD1Yr2sBCdUO48cp=rZQ6s4v13ytpPd9oPT+U=iYrdXtba5HA@mail.gmail.com/
> 
> 
> Once we have a way to set individual subflow options, it could both be
> useful to set sk_mark on all subflows, and also to not override individual
> settings. The current sync mechanism would overwrite all supported options
> when any single option changes.
> 
> There's no way for these options to diverge yet, so we could wait on solving
> that problem. Do you think it's better to stick with the current syncing
> method for now, or to do more detailed tracking of which options need to be
> synced?

Looks like same issue as with TCP_CONGESTION.
Q is how we can expose the individual subflows.

I see
https://tools.ietf.org/html/draft-hesmans-mptcp-socket-03

Should that be implemented instead of this?
