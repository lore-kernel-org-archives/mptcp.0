Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46422C83
	for <mptcp@lists.linux.dev>; Fri, 29 Oct 2021 11:00:39 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1mgPcd-00086R-Ks; Fri, 29 Oct 2021 13:00:31 +0200
Date: Fri, 29 Oct 2021 13:00:31 +0200
From: Florian Westphal <fw@strlen.de>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 2/2] selftests: mptcp: add tproxy test case
Message-ID: <20211029110031.GA14584@breakpoint.cc>
References: <20211028093902.8685-1-fw@strlen.de>
 <20211028093902.8685-3-fw@strlen.de>
 <a941c69c-43a-8469-ae72-15cfcc56a8f2@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a941c69c-43a-8469-ae72-15cfcc56a8f2@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
> > +	ip -net "$listener_ns" $r6flag rule add fwmark 1 lookup 100
> 
> Something's still missing from the kernel config - this works with ipv4 but
> with ipv6 I get:
> 
> Error: Rule family not supported.

Yep, ip -6 rule fails.

> I experimented with a couple of extra CONFIG_IP6_NF* options but didn't find
> the right ones, here are the ipv6/netfilter options I tried unsuccessfully:

Thanks for providing your .config, this helped a lot.

CONFIG_IPV6_MULTIPLE_TABLES is missing.

I'll send a v3 once I've confirmed your config works with this option
enabled, I'll also make the SKIP message a bit more verbose.
