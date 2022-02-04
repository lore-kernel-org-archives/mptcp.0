Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14D32F26
	for <mptcp@lists.linux.dev>; Fri,  4 Feb 2022 01:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643936552; x=1675472552;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JKH0Xcdjp0GuyaeyYvJWYIN0FSDx3Idh5wPA48hf9X8=;
  b=jhQzypAfZerpZvvE1iAd69BeQGQWYqlMZuOVdYOA2/wWGjRna3Y9q399
   zNzkoPNFj4gUWo77avT8C4BnFrPy6Le4uniGmoI5dowbPePrsi7gRQwwM
   WU52PwZk0E94Wr2qk9PsobycssgGPaukLtq5e0aUZ6aCng+YhbPxGKuFp
   Ho7YCRra50AZqPrPM0fE1YqUCWy+JnRsCFOFhiA1ENF9+t6reCCSl22Qq
   ml8XFPy8wUAvHtj4XH/LzUAyovYWzJsTX2jZOTmRdq8d1v9zHwWNa0G7u
   ru0LWxOrRV9tINcJG/URUx5UL5Uon+jyRykPiNgHanPm/OJ6nS7C1sBzk
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="248052174"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="248052174"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 17:02:31 -0800
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="538988670"
Received: from jingmia1-mobl.amr.corp.intel.com ([10.212.144.107])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 17:02:31 -0800
Date: Thu, 3 Feb 2022 17:02:31 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v5 5/8] mptcp: netlink: store per namespace
 list of refcounted listen socks
In-Reply-To: <20220203174637.GC4901@breakpoint.cc>
Message-ID: <947dd6a4-3b48-64d3-7a3-d92f6edd856@linux.intel.com>
References: <20220203072508.3072309-1-kishen.maloor@intel.com> <20220203072508.3072309-6-kishen.maloor@intel.com> <20220203174637.GC4901@breakpoint.cc>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 3 Feb 2022, Florian Westphal wrote:

> Kishen Maloor <kishen.maloor@intel.com> wrote:
>> The kernel can create listening sockets bound to announced addresses
>> via the ADD_ADDR option for receiving MP_JOIN requests. Path
>> managers may further choose to advertise the same addr+port over multiple
>> MPTCP connections. So this change provides a simple framework to
>> manage a list of all distinct listning sockets created in the kernel
>> over a namespace by encapsulating the socket in a structure that is
>> ref counted and can be shared across multiple connections. The sockets
>> are released when there are no more references.
>
> I think it makes sense to work on a hook in tcp v4/v6 input path
> that gets called for th->syn && !th->ack && no-listener-found case.
>
> The hook would:
> 1. retrieve join token, fetch mptcp_sock and allow 3whs to continue
>   if things look ok from mptcp p.o.v.
> 2. return "go ahead and send tcp rst" or "mptcp magic, skb stolen"
> to the tcp stack.
>

This is basically the approach the multipath-tcp.org kernel takes. I think 
we initially decided to use listening sockets instead since it was less 
invasive, but now we have found the limits of the listener approach.

It even looks like your proposal adheres more closely to 
https://datatracker.ietf.org/doc/html/rfc8684.html#section-3.2 (last 
paragraph): "Demultiplexing subflow SYNs MUST be done using the token"

I hadn't noticed that "MUST" before.

Do you think the token lookups should depend on anything other than the 
token value and net namespace - for example, to make sure someone can't 
use a public interface to try to brute-force potential tokens in use on 
other interfaces? The HMACs later in the handshake would guard against an 
actual connection (but would burn some extra CPU cycles). I guess this 
isn't a fundamentally different problem than we have today if there are 
any MPTCP listeners on public interfaces, it just means they don't have to 
work out the port number first.

> This also makes sure that plain tcp or mptcp connect requests will
> not work for addresses that did not go through socket/bind/listen API.
>
> I will try to prototype something next week.
>

Thanks!

> Given that hook lives in an error path (from tcp point of view)
> I think its going to be OK from a upstreaming point of view.
>

Seems reasonable to me.

> It hopefully avoids the need for "magic listener sockets", and avoids
> kernel fighting with userspace applications over which address:port
> pairs are really useable.
>
> The latter is a concern IMO, esp. with reuseport and other round-robin
> schemes, I don't want mptcp layer to interfere with other application
> running on same host.

The complexity of the magic listener sockets - creating and managing them, 
as well as mysterious interactions with userspace - does seem more 
significant than the TCP changes, so I hope the prototype works out.


--
Mat Martineau
Intel
