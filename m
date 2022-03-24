Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEC61FA1
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 15:03:31 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1nXOzn-0007Kb-6k; Thu, 24 Mar 2022 16:03:27 +0100
Date: Thu, 24 Mar 2022 16:03:27 +0100
From: Florian Westphal <fw@strlen.de>
To: Geliang Tang <geliang.tang@suse.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH RESEND mptcp-next v5 1/8] mptcp: add struct
 mptcp_sched_ops
Message-ID: <20220324150327.GE24666@breakpoint.cc>
References: <cover.1648130637.git.geliang.tang@suse.com>
 <4df8257d4783911e933bdf3a3ddcfbac1c9db4f1.1648130637.git.geliang.tang@suse.com>
 <20220324142753.GD24666@breakpoint.cc>
 <20220324144110.GA15636@localhost>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324144110.GA15636@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)

Geliang Tang <geliang.tang@suse.com> wrote:
> On Thu, Mar 24, 2022 at 03:27:53PM +0100, Florian Westphal wrote:
> > Geliang Tang <geliang.tang@suse.com> wrote:
> > > This patch added struct mptcp_sched_ops. And define the scheduler
> > > register, unregister and find functions.
> > 
> > ... but why are they pernet?  Makes no sense to me, so an
> > explanation would help.  Or, remove the pernet ops.
> > 
> > All callers pass &init_net, so I don't think there is any reason
> > for pernet data structures here.
> 
> v4 used global list instead of pernet list:
> 
> https://patchwork.kernel.org/project/mptcp/patch/02c1d2d2eee134713737fe5c5f73127e8c741589.1647942374.git.geliang.tang@suse.com/
> 
> Should I go back to v4?

Mhh.  Mat, why the pernet thing? AFAICS all net namespaces would contain the
same (albeit we'd have to kmemdup first to get unique list_heads....) info,
so I don't understand why thats a good idea?

A single/global lock is fine if its not taken in the normal (per packet) case.
