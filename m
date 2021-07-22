Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAE5173
	for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 20:53:28 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1m6fh7-0005KD-E6; Thu, 22 Jul 2021 22:53:25 +0200
Date: Thu, 22 Jul 2021 22:53:25 +0200
From: Florian Westphal <fw@strlen.de>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [RFC] mptcp: add MPTCP_INFO getsockopt
Message-ID: <20210722205325.GH9904@breakpoint.cc>
References: <20210722150154.10608-1-fw@strlen.de>
 <ff3627c3-7e0d-b374-3532-a5d93f7455af@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff3627c3-7e0d-b374-3532-a5d93f7455af@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

Matthieu Baerts <matthieu.baerts@tessares.net> wrote:
> Hi Florian,
> 
> Thank you for looking at that!
> 
> On 22/07/2021 17:01, Florian Westphal wrote:
> > Its not compatible with mptcp.org kernel one:
> > 1. mptcp.org defines 'struct mptcp_info', but we already have this for
> >    inet_diag.
> > 
> > 2. 'struct mptcp_info', as defined by mptcp.org has different layout for
> >    32/64 bit arches.
> >    This is a problem for 32bit binaries on 64bit kernels.
> > 
> > For those reasons a new 'struct mptcp_info_opt' is added which contains
> > aligned_u64 fields to store the userspace buffer addresses.
> 
> Thank you for the explanation, it makes sense!
> 
> > 'struct mptcp_sub_info' is added as per mptcp.org kernel, but I don't
> > like this structure.  I think 'src' and 'dst' are confusing terms.
> 
> Do you prefer 'local' and 'remote'?

I thought about alternative names, I like your suggestion.

> > In light of this, I wonder if it would make more sense to split the
> > functionality.
> 
> Would it not start to be a bit costly to get all details if the
> userspace has do a few syscalls?
> - general info
> - get subflow IDs
> - for each suflow, call subflow info + peer/sock names

Yes, good point.  Its unlikely one would ask for a specific subflow
endpoint addresses.

So perhaps just keep that in mind for later and go with a mptcp.org
alike approach.

> With the full structure, we could eventually allow userspace programs to
> set some "*_len" members to 0 not to get all info, e.g. only get the
> general info without peer/sock names for all subflows. Or without
> TCP_INFO for each subflow. No?

Yes, userspace can set the address field to 0 and the kernel will skip
that part.

One thing that I'd like to change is the way the length fields are
handled.  I propose that userspace can set the legnth field to 0 to
request the kernel to fill in the required size.

This won't work reliably (there could be a new subflow arriving
after the query and before the second getsockopt with the "properly
sized" fields.

At the moment, there is no way to detect this.
Perhaps the info struct should contain two size versions, one with
the "this is how much I copied to the buffer" and another with
"this is how much i would have copied".

> > sa.sa_family = subflow_ids[0];
> > getsockopt(fd, SOL_MPTCP, SUBFLOW_GETPEERNAME, &sa, &len);
> > ..
> > sa.sa_family = subflow_ids[0];
> > getsockopt(fd, SOL_MPTCP, SUBFLOW_GETSOCKNAME, &sa, &len);
> > 
> > tcp_info.tcpi_state = subflow_ids[0];
> > getsockopt(fd, SOL_MPTCP, SUBFLOW_TCP_INFO, &tcp_info, &len);
> > 
> > ...
> > 
> > and so on.
> 
> This could be interesting if there is a demand to get info only for some
> specific subflows :)

Yes, as I wrote above your are probably right that the "give me the peer
socket address for subflow 42" is a bit esoteric.

> > Alternatively one could overload e.g. the upper 8 bit:
> > 
> > getsockopt(fd, SOL_MPTCP, subflow_ids[0] << 24 | SUBFLOW_FOO, ...);
> 
> Maybe a "cleaner" workaround to set the ID? :)

It would be more consistent, at least.  The "piggyback in the buffer" is
very ugly...

> > In any case, here is a tentative patch to add a mptcp.org-alike
> > MPTCP_INFO getsockopt.
> 
> Thank you for sharing that!
> 
> (I didn't check the code yet)

No need to have a super close look, its going to change anyway.
Its also heavily lifted from the mptcp.org kernel.

I will add attributions as needed once a formal patch submission
is made.
