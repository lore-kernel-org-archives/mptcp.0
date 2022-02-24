Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF34C7B
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 00:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645663691; x=1677199691;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nq+6jYac5epLh6HiGyU3tXgYOyXw8mPDfiVQNlPXx80=;
  b=hYdLsioUrh2m+4KM9ufCFl2syZktX6uC0JFbCzrCre28sQs7x8rF/GQe
   ghITB2bhcomSr7PPrsiZ9pKnet5/QUC2aH7YkWC/AFHV68pAq4W75xORJ
   7dT5WCqeT9cEIDroytmxE7YTCsKWhI/n2T+gdBQqymuHhyAMMUVRillO0
   5fYCKQGmx/FCzslugtn2c1ohUfMAyiy5/LWsi6aAHlNLbr/gHmPiOvgrf
   366njsbmn1lhbSI/F0n09RRKN7LK7M+0pxz6aNYmtuL/u5xv9ed5jfdCl
   Xjtqfk2lLtbm4McNZBzvvaGPV7zqtlJQPiZbfPlJ+DadAoGyaenE1FXdx
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="315343738"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="315343738"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 16:48:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="591907414"
Received: from ortmgvpn37.amr.corp.intel.com ([10.212.237.95])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 16:48:11 -0800
Date: Wed, 23 Feb 2022 16:48:10 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 0/4] mptcp: replace per-addr listener
 sockets
In-Reply-To: <20220223110832.29357-1-fw@strlen.de>
Message-ID: <2cb7a320-78bb-e14-26cb-a815daab7021@linux.intel.com>
References: <20220223110832.29357-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 23 Feb 2022, Florian Westphal wrote:

> Changes since v2:
> - drop first patch again, no longer needed
> - move announce list check to the new join hook (Paolo)
> - add joinhook for timewait sockets
> - hide join6 member for !ipv6 build
>
> Changes since v2:
> - avoid unneeded sk refcount inc/dec pair
> - use more descriptive name for function name
> - fix typo in rfc number (Mathieu)
> - don't increment listner refcount, caller assumes noref
>

Hi Florian -

Thanks for the v3, I think that covers the review comments on v2 for the 
functionality covered in the previous revs.

My main questions have to do with:

> Not changed:
> - hook location, plain tcp sockets take precedence.
> - per-netns listener
>

Do you have plans for either or both of these? Not sure if you have 
work-in-process or if we (the community) need to figure out a more 
detailed plan for TCP/MPTCP precedence and the degree of TCP changes that 
make sense upstream. Since this week's meeting is happening real soon, we 
can definitely sort it out there.

With the upstream kernel at 5.17-rc5 we should also try to figure out how 
much of the listener and userspace PM changes we want to merge to 
net-next now vs. in the next cycle.

-Mat


> Global listener means other namespaces are affected in case
> of backlog overflow. Pernet listeners avoid that, so I don't see
> a strong argument for tcp refactoring that would allow global sk.
>
> This series introduces a hidden per-netns pseudo "listener" socket to
> handle mptcp join requests with a valid token but that do not match an
> existing listening socket.
>
> First patch is a minor preparation patch: MPTCP Join requests packets
> that fail to find a suitable socket by means of standard address/port
> demultiplexing will be steered to a pseudo-listener, similar to TPROXY
> interception.
>
> This pseudo listener isn't bound to an address or port (all zero), so we
> need to fetch the port number from the tcp header and not the listener sk.
>
> Patch two adds a stub to the tcp demux code.
> This has no functionality, its extra to make tcp datapath change stand out.
>
> Third patch is the bulk work, it adds per netns listener and implements
> token-based socket demultiplexing.
>
> Last patch zaps the per-address sockets from mptcp, they are not needed
> anymore.
>
> Florian Westphal (4):
>  mptcp: prefer ip address in syn skb instead of listen sk bound address
>  tcp: add mptcp join demultiplex hooks
>  mptcp: handle join requests via pernet listen socket
>  mptcp: remove per-address listening sockets
>
> include/net/mptcp.h    |  15 +++
> net/ipv4/tcp_ipv4.c    |   7 ++
> net/ipv6/tcp_ipv6.c    |  26 +++--
> net/mptcp/ctrl.c       | 229 ++++++++++++++++++++++++++++++++++++++++-
> net/mptcp/pm_netlink.c |  82 +++------------
> net/mptcp/protocol.c   |   2 +-
> net/mptcp/protocol.h   |   4 +-
> net/mptcp/subflow.c    |   9 +-
> 8 files changed, 287 insertions(+), 87 deletions(-)
>
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
