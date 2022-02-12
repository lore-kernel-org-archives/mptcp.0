Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84EB7F
	for <mptcp@lists.linux.dev>; Sat, 12 Feb 2022 00:13:30 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1nIg2X-0003Yp-8B; Sat, 12 Feb 2022 01:13:26 +0100
Date: Sat, 12 Feb 2022 01:13:25 +0100
From: Florian Westphal <fw@strlen.de>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 3/4] mptcp: handle join requests via pernet
 listen socket
Message-ID: <20220212001325.GD6497@breakpoint.cc>
References: <20220210152949.19572-1-fw@strlen.de>
 <20220210152949.19572-4-fw@strlen.de>
 <422ec600-3bc4-9f38-d2b1-060311ec3c40@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422ec600-3bc4-9f38-d2b1-060311ec3c40@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

Matthieu Baerts <matthieu.baerts@tessares.net> wrote:
> On 10/02/2022 16:29, Florian Westphal wrote:
> > RFC 8664 says:
> 
> Very minor nit: s/8664/8684/

Ugh.  I'll fix that up, thanks for noticing.
