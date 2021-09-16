Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778AF3FD0
	for <mptcp@lists.linux.dev>; Thu, 16 Sep 2021 10:07:07 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1mQoIK-0001xY-Nl; Thu, 16 Sep 2021 12:07:04 +0200
Date: Thu, 16 Sep 2021 12:07:04 +0200
From: Florian Westphal <fw@strlen.de>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp] mptcp: don't return sockets in foreign netns
Message-ID: <20210916100704.GB20414@breakpoint.cc>
References: <20210915121144.9891-1-fw@strlen.de>
 <42126ef3-b46d-27ef-64d7-7a257275e188@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42126ef3-b46d-27ef-64d7-7a257275e188@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
> 
> On Wed, 15 Sep 2021, Florian Westphal wrote:
> 
> > mptcp_token_get_sock() may return a mptcp socket that is in
> > a different net namespace than the socket that received the token value.
> > 
> > The mptcp syncookie code path had an explicit check for this,
> > this moves the test intp mptcp_token_get_sock() function.
> > 
> > Eventually token.c should be converted to pernet storage, but
> > such change is not suitable for net tree.
> > 
> > Signed-off-by: Florian Westphal <fw@strlen.de>
> 
> For the net tree, would need a Fixes tag. How about:
> 
> Fixes: 2c5ebd001d4f0 ("mptcp: refactor token container")
>
> mptcp_token_get_sock() was originally introduced in f296234c98a8f, but the
> changes here would only apply to Paolo's refactor and KUNIT tests.

Yep, f296234c98a8f is 'more correct' (day 0), but I'm fine with using
2c5ebd001d4f0 instead.

Thanks for reviewing.
