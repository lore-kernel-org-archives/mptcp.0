Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEB23C35
	for <mptcp@lists.linux.dev>; Tue,  9 Aug 2022 11:16:26 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1oLNDk-0004ra-ET; Tue, 09 Aug 2022 13:16:24 +0200
Date: Tue, 9 Aug 2022 13:16:24 +0200
From: Florian Westphal <fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	Thomas Haller <thaller@redhat.com>, mptcp@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH] mptcp: allow priviledged operations from user namespaces
Message-ID: <20220809111624.GA18587@breakpoint.cc>
References: <20220805115020.525181-1-thaller@redhat.com>
 <e95949bf-53cf-bdf-27c8-8cbc3eeda450@linux.intel.com>
 <20220809102507.GA13671@breakpoint.cc>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809102507.GA13671@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)

Florian Westphal <fw@strlen.de> wrote:
> Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
> > On Fri, 5 Aug 2022, Thomas Haller wrote:
> > 
> > > GENL_ADMIN_PERM checks that the user has CAP_NET_ADMIN in the initial
> > > namespace by calling netlink_capable(). Instead, use GENL_UNS_ADMIN_PERM
> > > which uses netlink_ns_capable(). This checks that the caller has
> > > CAP_NET_ADMIN in the current user namespace.
> > > 
> > > See also commit 4a92602aa1cd ('openvswitch: allow management from inside
> > > user namespaces') which introduced this mechanism. See also commit
> > > 5617c6cd6f84 ('nl80211: Allow privileged operations from user
> > > namespaces'), which introduced this for nl80211.
> > > 
> > > Signed-off-by: Thomas Haller <thaller@redhat.com>
> > 
> > Hi Thomas -
> > 
> > Thanks for the patch! This does seem like a good idea to me (and it seems to
> > work ok with our MPTCP tests), but I'd like to get some more community input
> > before merging (Paolo/Florian?).
> 
> Looks good to me, I don't see any places where we'd accept e.g. a token
> from a different netns.
> 
> mptcp_nl_cmd_add_addr should probably be changed to use
> GFP_KERNEL_ACCOUNT so that the added entries can be limited via memcg.

> mptcp_userspace_pm_append_new_local_addr() helper needs a bit of rework
> for that, but I don't think this has do be done right away.

Actually its fine; the allocation is accounted vs the socket.

mptcp_nl_cmd_add_addr has the only "permanent" kmalloc that I can see.
