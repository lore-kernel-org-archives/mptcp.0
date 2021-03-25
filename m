Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F816F
	for <mptcp@lists.linux.dev>; Thu, 25 Mar 2021 12:49:07 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1lPPQ9-0002Ku-02; Thu, 25 Mar 2021 13:49:05 +0100
Date: Thu, 25 Mar 2021 13:49:04 +0100
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev,
	mptcp@lists.01.org
Subject: Re: [MPTCP] [RFC PATCH mptcp-next v2 1/8] mptcp: add skeleton to
 sync msk socket options to subflows
Message-ID: <20210325124904.GB26567@breakpoint.cc>
References: <20210324131546.13730-1-fw@strlen.de>
 <20210324131546.13730-2-fw@strlen.de>
 <85febbb1c0b4dc7b73861fabdc846194f468f127.camel@redhat.com>
 <20210324200148.GL22603@breakpoint.cc>
 <2ee15b0397e7653f8d8cfd74d53398a6a5f0c19c.camel@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ee15b0397e7653f8d8cfd74d53398a6a5f0c19c.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> > In the outgoing case, the subflow isn't linked to the conn_list yet.
> 
> My bad! I did not recall we use join_list even for outgoing subflows...
> I'm wondering if we could move them directly in conn_list
> inside __mptcp_subflow_connect()? I think it should not be problematic.

I thought conn_list was only allowed to contain full subflows, but I see
that scheduler skips subflows with incomplete join.

But such change doesn't appear to be related to this one.

> > I'm not sure all options have this 'inherited from listener' behaviour.
> 
> Why not? the subflow socket is cloned from the listener TCP subflow. 
> 
> If tcp_create_openreq_child() does not propagate some socket option,
> then the expected behaviour is probably not propagating it.

Ok, so you propose to init ssk->sockopt_seq to msk->sockopt_seq in
mptcp_accept()?
