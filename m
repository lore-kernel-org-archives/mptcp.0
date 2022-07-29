Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C916538C
	for <mptcp@lists.linux.dev>; Fri, 29 Jul 2022 21:20:53 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1oHXPY-0006iO-Dn; Fri, 29 Jul 2022 23:20:44 +0200
Date: Fri, 29 Jul 2022 23:20:44 +0200
From: Florian Westphal <fw@strlen.de>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev,
	matthieu.baerts@tessares.net, Paolo Abeni <pabeni@redhat.com>,
	Xiumei Mu <xmu@redhat.com>
Subject: Re: [PATCH v2 mptcp] selftests: mptcp: make sendfile selftest work
Message-ID: <20220729212044.GB18926@breakpoint.cc>
References: <20220729095550.3040-1-fw@strlen.de>
 <7ff00ad-80b5-8ab-6544-fdfaefd43f0@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ff00ad-80b5-8ab-6544-fdfaefd43f0@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
> Looks good to me, tests run fine on my system. I tried to reproduce the
> failures that CI reported on the non-debug build but so far it doesn't look
> like this change caused those failures.

Thanks for reviewing.

> With the Fixes: tag I assume this is intended for -net?

Yes, its intended for -net.
