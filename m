Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57547E
	for <mptcp@lists.linux.dev>; Fri, 11 Mar 2022 01:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646960728; x=1678496728;
  h=date:from:to:subject:in-reply-to:message-id:references:
   mime-version;
  bh=jlGBaT1LYUiiKpU9JsyoAPnYyINT+ZCq0StQy2Ph4vQ=;
  b=NtKGGazQuu5AxM4zugZtKbaMecmCPP/nx6pA8bVmlssr4Z3BdvSwP2pi
   P1G0Ky96rwtR42l8pm1r772VBrO3RW2SAHLkM9XuXhh6DNWUF+rknyQ3z
   z2ea6oPmqOpq9D7Pxp2auwWapsy+3BqCVbTuIesnf16OK3GdlQzJ2w3pe
   T2U7J9aJe09CNV6OD6TDfDga4raM+HbjHFBGCN+jCVCJ72YLFt2KDqkn0
   TaK/4yjWifFc1x9EeNBlZCTXh2IW/B1JbP6Wyk7oBYdvpxFkofpFX413N
   /Ukf4FIMOtHcehmQ4q3HEjttRWNcqcgR+ZG1pk7dUjtxoAICwHJJuMGAq
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="280202272"
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="280202272"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 17:03:58 -0800
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="496551675"
Received: from pschuste-mobl.amr.corp.intel.com ([10.209.118.252])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 17:03:58 -0800
Date: Thu, 10 Mar 2022 17:03:57 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [Weekly meetings] MoM - 10th of March 2022
In-Reply-To: <75c7803c-89c6-9e93-8f58-d2c6f3e24360@tessares.net>
Message-ID: <48686ee-4d79-c9fd-35d5-593b9ec9742b@linux.intel.com>
References: <75c7803c-89c6-9e93-8f58-d2c6f3e24360@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-571681002-1646960637=:46608"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-571681002-1646960637=:46608
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT


On Thu, 10 Mar 2022, Matthieu Baerts wrote:

> 12758809: Needs ACK: [mptcp-next,1/4] mptcp: prefer ip address in syn
> skb instead of listen sk bound address
> 12758808: Needs ACK: [mptcp-next,2/4] tcp: add mptcp join demultiplex hooks
> 12758810: Needs ACK: [mptcp-next,3/4] mptcp: handle join requests via
> pernet listen socket
> 12758811: Needs ACK: [mptcp-next,4/4] mptcp: remove per-address
> listening sockets:
> 12765701: RFC: [5/4] mptcp: handle join requests early:
>    - series: mptcp: replace per-addr listener sockets
>
>    - Kishen found a couple of possible issues (bind race conditions)
>
>    - Paolo gave his view of the situation:
>        - initial need:
> https://github.com/multipath-tcp/mptcp_net-next/issues/203
>        - (who opened that really...)
>        - need: accept new subflows for existing connections but where
> the listening socket has been closed
>
>        - 2 approaches have been taken:
>            - Kishen: create listening sockets (from the PM, with
> options not to do that, etc;)
>            - Florian: accept MPJ without having to create additional
> sockets
>        - these 2 approaches have pros and cons.
>
>    - Issue 203 is a nice to have, maybe not even a bug depending on the
> point of view
>
>    - → probably not a good idea to add too much complexity in the
> kernel, important bugs might come
>
>    - → maybe easier to let the userspace PM to create listening socket
> and not let the kernel doing that all the time.
>
>    - → the complexity to addresses races discussed on the ML would be
> managed from the userspace and maybe not even visible if opening
> listening would be done only in specific cases
>
>    - → idea would be to let the userspace PM (mptcpd) to do the bind +
> listen:
>        - not to have the complexity on the kernel side where we cannot
> change the behaviour
>        - having the kernel creating so many listening sockets "doesn't
> smell good", we will likely have complex issues to fix
>        - if we can do it from the userspace, probably best to let it do
> that
>        - 203 can then be fixed with mptcpd by creating listening
> sockets if needed


Ok, after this community discussion today, I think we should go with the 
"userspace (mptcpd) handles the listening sockets" approach. Kishen and 
Ossama are on board with this too.

In addition to the points just above (complexity, possible hidden issues, 
flexibility), this will leave the in-kernel PM implementation as-is for 
now. It also remains possible to change the kernel listening behavior for 
MPTCP joins at some point in the future, but will unblock the userspace 
PM.

Kishen is working on modifying the userspace PM patch set to add selftest 
support for these listening sockets in pm_nl_ctl. Ossama is looking at the 
mptcpd changes we'll need.


Paolo brought up and advocated this solution today, so it seems likely 
that he will concur. Considering the active participants in these 
discussions in recent meetings and email threads, I think we have a good 
consensus on this approach to the listening sockets. Questions/comments, 
anyone?

Thanks,

--
Mat Martineau
Intel
--0-571681002-1646960637=:46608--
