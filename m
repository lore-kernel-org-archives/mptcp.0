Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158A92F2B
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 18:24:12 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1nFgBp-0002Uz-J1; Thu, 03 Feb 2022 18:46:37 +0100
Date: Thu, 3 Feb 2022 18:46:37 +0100
From: Florian Westphal <fw@strlen.de>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v5 5/8] mptcp: netlink: store per namespace
 list of refcounted listen socks
Message-ID: <20220203174637.GC4901@breakpoint.cc>
References: <20220203072508.3072309-1-kishen.maloor@intel.com>
 <20220203072508.3072309-6-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203072508.3072309-6-kishen.maloor@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Kishen Maloor <kishen.maloor@intel.com> wrote:
> The kernel can create listening sockets bound to announced addresses
> via the ADD_ADDR option for receiving MP_JOIN requests. Path
> managers may further choose to advertise the same addr+port over multiple
> MPTCP connections. So this change provides a simple framework to
> manage a list of all distinct listning sockets created in the kernel
> over a namespace by encapsulating the socket in a structure that is
> ref counted and can be shared across multiple connections. The sockets
> are released when there are no more references.

I think it makes sense to work on a hook in tcp v4/v6 input path
that gets called for th->syn && !th->ack && no-listener-found case.

The hook would:
1. retrieve join token, fetch mptcp_sock and allow 3whs to continue
   if things look ok from mptcp p.o.v.
2. return "go ahead and send tcp rst" or "mptcp magic, skb stolen"
to the tcp stack.

This also makes sure that plain tcp or mptcp connect requests will
not work for addresses that did not go through socket/bind/listen API.

I will try to prototype something next week.

Given that hook lives in an error path (from tcp point of view)
I think its going to be OK from a upstreaming point of view.

It hopefully avoids the need for "magic listener sockets", and avoids
kernel fighting with userspace applications over which address:port
pairs are really useable.

The latter is a concern IMO, esp. with reuseport and other round-robin
schemes, I don't want mptcp layer to interfere with other application
running on same host.
