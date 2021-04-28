Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BC072
	for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 11:03:26 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1lbhyW-0003rf-JB; Wed, 28 Apr 2021 13:03:24 +0200
Date: Wed, 28 Apr 2021 13:03:24 +0200
From: Florian Westphal <fw@strlen.de>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev,
	Geliang Tang <geliangtang@gmail.com>
Subject: Re: [MPTCP][PATCH v2 mptcp-next 1/4] mptcp: add sysctl
 allow_join_initial_addr_port
Message-ID: <20210428110324.GE975@breakpoint.cc>
References: <cover.1619592361.git.geliangtang@gmail.com>
 <51758a7f629764dc91186acbf09665992e5b8e69.1619592361.git.geliangtang@gmail.com>
 <20210428094043.GC975@breakpoint.cc>
 <be8baf91-5399-43d2-e595-f8565b353815@tessares.net>
 <e05e68e1-4971-7daa-24bf-1d79b9ba89c1@tessares.net>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e05e68e1-4971-7daa-24bf-1d79b9ba89c1@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

Matthieu Baerts <matthieu.baerts@tessares.net> wrote:
> >>>  	int mptcp_enabled;
> >>>  	unsigned int add_addr_timeout;
> >>> +	int allow_join_initial_addr_port;
> >>
> >> u8 allow_join_initial_addr_port;
> > 
> > Should we do the same modifications for 'mptcp_enabled'? Switch to a u8
> > with min 0 and max 1?

It would be better yes, but I was more interested to not follow the
existing example.

> Even if we typically use it with 0 and 1, modifying 'mptcp_enabled'
> might be seen as breaking the exposed userspace API, no? Maybe too late
> to change?

Such changes have been done in the past, I think its ok.
