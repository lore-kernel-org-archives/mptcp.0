Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAAF2C82
	for <mptcp@lists.linux.dev>; Wed,  1 Dec 2021 23:22:26 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1msYSq-0008C9-6T; Wed, 01 Dec 2021 23:52:36 +0100
Date: Wed, 1 Dec 2021 23:52:36 +0100
From: Florian Westphal <fw@strlen.de>
To: Maxim Galaganov <max@internet.ru>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
	Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH mptcp-net] mptcp: fix deadlock in __mptcp_push_pending()
Message-ID: <20211201225236.GD2315@breakpoint.cc>
References: <20211201211523.7155-1-max@internet.ru>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201211523.7155-1-max@internet.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)

Maxim Galaganov <max@internet.ru> wrote:
> __mptcp_push_pending() may call mptcp_flush_join_list() with subflow
> socket lock held. If such call hits mptcp_sockopt_sync_all() then
> subsequently __mptcp_sockopt_sync() could try to lock the subflow
> socket for itself, causing a deadlock.

Reviewed-by: Florian Westphal <fw@strlen.de>

