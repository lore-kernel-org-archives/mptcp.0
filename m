Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45167B
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 01:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645666006; x=1677202006;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HUq4eRkpzLqmDG4kQr5+bn785+2g7lWbarvYostEoRI=;
  b=JzU+0/BoiUuDLYuVrgTam6R3VQH+MEDJLYLftbUo+gJBWaKTvl3Yk4qr
   n8ZUJBkxD/5D7MAE2zYetdEVpj3N3IMDLTh6gkg3XwhD8MVRqV2BuCsWy
   wgaZUAalu+a8KIMI5h3VlUxHTSrwjP+pW+U2r+T9GGAhkCpLkySYyiNoN
   TO9xefsDragDoLs27L+lMReA2hmn79l6jVBMy/acSASIJKUIDSOz1EVwB
   WYkKWNSl3YW2dOxZP2dseKf2WcidcRJu1XVbQfd4in8Wwl/TFYBdlmDam
   yU3zgRLq6ESeYCewr4EYg/WViiZTyqQWSFMjHA6ulzO77WRX9ubCyW/se
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="239516821"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="239516821"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 17:26:46 -0800
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="508673100"
Received: from ortmgvpn37.amr.corp.intel.com ([10.212.237.95])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 17:26:46 -0800
Date: Wed, 23 Feb 2022 17:26:46 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH 3/4] mptcp: handle join requests via pernet listen
 socket
In-Reply-To: <20220223110832.29357-4-fw@strlen.de>
Message-ID: <ff6fbff-8753-4a55-8aa6-9c7dff89644@linux.intel.com>
References: <20220223110832.29357-1-fw@strlen.de> <20220223110832.29357-4-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 23 Feb 2022, Florian Westphal wrote:

> Currently mptcp adds kernel-based listener socket for all
> netlink-configured mptcp address endpoints.
>
> This has caveats because kernel may interfere with unrelated programs
> that use same address/port pairs.
>
> RFC 8684 says:
> Demultiplexing subflow SYNs MUST be done using the token; this is
> unlike traditional TCP, where the destination port is used for
> demultiplexing SYN packets.  Once a subflow is set up, demultiplexing
> packets is done using the 5-tuple, as in traditional TCP.
>
> This patch deviates from this in that it retains the existing checks of
> verifying the incoming requests destination vs. the list of announced
> addresses.  If the request is to an address that was not assigned, its
> treated like an invalid token, i.e. we send a tcp reset with mptcp
> error specific code is returned.
>
> The checks that do this are moved from subflow specific code to the
> new hook, this allows us to perform the check at an earlier stage.
>
> Furthermore, TCP-only listeners take precedence: An MPTCP peer MUST NOT
> announce addr:port pairs that are already in use by a non-mptcp listener.
>

This rule seems ok to me. But there's a loophole: MPTCP can announce the 
addr:port, then a TCP listener is created for that same addr:port and 
starts rejecting any incoming MP_JOINs.

> This could be changed, but it requires move of mptcp_handle_join() hook
> *before* the tcp port demux, i.e. an additional conditional in hotpath.
>

One possibility that doesn't disturb the hot path too much: Let the TCP 
listener try to handle the SYN. In tcp_parse_options(), add just enough 
code to set a bit in struct tcp_options_received if MP_JOIN is present 
(don't fully parse the MPTCP option). If MP_JOIN is there and MPTCP is 
enabled, return early from tcp_check_req() and have tcp_v4_rcv() treat it 
similar to req_stolen==true. Instead of kicking back to a regular lookup, 
try a token lookup.

> As-is, the additional conditional (syn && !rst && ...) is placed in the
> 'no socket found' path.
>
> The pernet "listening" socket is hidden from userspace, its not part of
> any hashes and not bound to any address/port.
>
> TPROXY-like semantics apply: If tcp demux cannot find a port for a given
> packet, check if the packet is a syn packet with a valid join token.
>
> If so, the pernet listener is returned and tcp processing resumes.
> Otherwise, handling is identical.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
> include/net/mptcp.h  |  10 ++
> net/ipv6/tcp_ipv6.c  |  19 ++--
> net/mptcp/ctrl.c     | 229 ++++++++++++++++++++++++++++++++++++++++++-
> net/mptcp/protocol.c |   2 +-
> net/mptcp/protocol.h |   2 +-
> net/mptcp/subflow.c  |   8 +-
> 6 files changed, 251 insertions(+), 19 deletions(-)

--
Mat Martineau
Intel
