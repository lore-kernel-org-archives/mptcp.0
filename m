Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCCF173
	for <mptcp@lists.linux.dev>; Thu, 12 Aug 2021 11:28:04 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1mE8sU-0006tz-3B; Thu, 12 Aug 2021 13:28:02 +0200
Date: Thu, 12 Aug 2021 13:28:02 +0200
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 5/5] selftests: mptcp: add mptcp getsockopt
 test cases
Message-ID: <20210812112802.GA607@breakpoint.cc>
References: <20210811131523.6339-1-fw@strlen.de>
 <20210811131523.6339-6-fw@strlen.de>
 <442435228e4ef69a6b2eff0d968d7fe78a08863a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442435228e4ef69a6b2eff0d968d7fe78a08863a.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> >  TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
> > -	      simult_flows.sh mptcp_sockopt.sh
> > +	      simult_flows.sh mptcp_sockopt.sh mptcp_sockopt.sh
> 
> I guess this change is not needed.

D'oh.  Will remove this hunk.

> > +	ret = getsockopt(fd, SOL_MPTCP, MPTCP_TCPINFO, &ti, &olen);
> > +	if (ret < 0)
> > +		die_perror("getsockopt MPTCP_TCPINFO");
> 
> Perhaps we could add some test case for weird lens: too short olen,
> size_user gretaer then olen, size_user smaller then size_kernel, WDYT?

Sure, will add those.
