Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A0129CA
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 20:35:54 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1nFipc-0003RY-6w; Thu, 03 Feb 2022 21:35:52 +0100
Date: Thu, 3 Feb 2022 21:35:52 +0100
From: Florian Westphal <fw@strlen.de>
To: Kishen Maloor <kishen.maloor@intel.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v5 5/8] mptcp: netlink: store per namespace
 list of refcounted listen socks
Message-ID: <20220203203552.GD4901@breakpoint.cc>
References: <20220203072508.3072309-1-kishen.maloor@intel.com>
 <20220203072508.3072309-6-kishen.maloor@intel.com>
 <20220203174637.GC4901@breakpoint.cc>
 <1517e7e4-521b-6879-4846-024f53c86eaa@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517e7e4-521b-6879-4846-024f53c86eaa@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Kishen Maloor <kishen.maloor@intel.com> wrote:
> > Given that hook lives in an error path (from tcp point of view)
> > I think its going to be OK from a upstreaming point of view.
> > 
> > It hopefully avoids the need for "magic listener sockets", and avoids
> > kernel fighting with userspace applications over which address:port
> > pairs are really useable.
> > 
> 
> Will this also obviate the need for listeners we currently create for port-based
> endpoints?

Hopefully yes.

> Indeed if there are active/legacy TCP deployments that cannot be reconfigured with the 
> NO_LISTEN flag, then we could choose to stick with the current default behavior
> and introduce a LISTEN flag (and additionally a NO_LISTEN flag to not create listeners for
> port-based endpoints as discussed earlier today). Further, if it's possible, we could 
> also update the MPTCP layer to not accept MPC attempts over listeners created in the 
> kernel to address that matter?

Yes, we could do that, I suggest to wait and see how the "syn/join hook"
works out.
