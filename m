Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904A533C9
	for <mptcp@lists.linux.dev>; Tue,  3 May 2022 21:32:35 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1nm08B-0008S0-Hc; Tue, 03 May 2022 23:32:27 +0200
Date: Tue, 3 May 2022 23:32:27 +0200
From: Florian Westphal <fw@strlen.de>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] selftests: mptcp: add TCP_DEFER test case
Message-ID: <20220503213227.GC21053@breakpoint.cc>
References: <20220502163641.6146-1-fw@strlen.de>
 <403af1b2-b34d-45f-c53-ae2f1e18225@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403af1b2-b34d-45f-c53-ae2f1e18225@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
> On Mon, 2 May 2022, Florian Westphal wrote:
> 
> > Check that value x can be set and retrieved.
> > 
> 
> Hi Florian -
> 
> I see the same error in this test with both my local test VM and when
> running Matthieu's CI script on a different machine:
> 
> # mptcp_sockopt: mptcp_sockopt.c:150: check_tcp_defer: Assertion `rv == value' failed.
> # mptcp_sockopt: mptcp_sockopt.c:765: main: Assertion `e1 == 4' failed.

seems like fix is to remove this test, kernel xlates value to
number-of-retrainsmits so set and get may return different values.
