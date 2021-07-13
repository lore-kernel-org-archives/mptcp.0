Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94087168
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 00:04:31 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="197257188"
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; 
   d="scan'208";a="197257188"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 17:04:29 -0700
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; 
   d="scan'208";a="502505731"
Received: from archidas-mobl1.amr.corp.intel.com ([10.212.129.5])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 17:04:28 -0700
Date: Mon, 12 Jul 2021 17:04:28 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH mptcp-next 0/9] fullmesh path manager support
In-Reply-To: <cover.1625825505.git.geliangtang@gmail.com>
Message-ID: <f6b48327-e562-1a5a-f470-23c24be45c41@linux.intel.com>
References: <cover.1625825505.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 9 Jul 2021, Geliang Tang wrote:

> Implement the in-kernel fullmesh path manager like on the mptcp.org
> kernel.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/193
>
> Geliang Tang (9):
>  mptcp: add a new sysctl path_manager
>  mptcp: add fullmesh path manager
>  mptcp: add fullmesh worker
>  mptcp: register ipv4 addr notifier
>  mptcp: register ipv6 addr notifier
>  mptcp: add netdev up event handler
>  mptcp: add netdev down event handler
>  mptcp: add proc file mptcp_fullmesh
>  selftests: mptcp: add fullmesh testcases
>
> Documentation/networking/mptcp-sysctl.rst     |   8 +
> net/mptcp/Makefile                            |   2 +-
> net/mptcp/ctrl.c                              |  16 +
> net/mptcp/pm.c                                |   9 +-
> net/mptcp/pm_fullmesh.c                       | 463 ++++++++++++++++++
> net/mptcp/pm_netlink.c                        |  14 +-
> net/mptcp/protocol.c                          |  11 +-
> net/mptcp/protocol.h                          |  11 +
> .../testing/selftests/net/mptcp/mptcp_join.sh |  66 ++-
> 9 files changed, 588 insertions(+), 12 deletions(-)
> create mode 100644 net/mptcp/pm_fullmesh.c
>
> -- 
> 2.31.1

Hi Geliang -

This patch set brings up a lot of questions - many of which it would have 
been good to address by having some design discussions before starting to 
write the code. But the patches are here, so let's discuss!


An early design goal of the upstream Linux MPTCP implementation 
(https://github.com/multipath-tcp/mptcp_net-next/wiki/%5Barchived%5D-Initial-Design) 
was to simplify the kernel side of MPTCP by moving functionality to 
userspace where possible - especially the path manager.

The current in-kernel path manager was designed for two main purposes: to 
handle path management on busy servers where kernel/userspace 
communication could become a bottleneck, and to provide basic path 
management capability until userspace path managers were ready (like 
mptcpd). Userspace path managers would then be the "playground" for 
various path management algorithms.

The multpath-tcp.org kernel has a variety of in-kernel path managers. 
These are typically built as kernel modules, so unused path managers can 
be excluded or built as modules and stay unloaded until they are needed. 
The fullmesh PM as implemented in this patchset is always compiled and 
using code space when CONFIG_MPTCP is enabled, and is always getting 
address notifications and updating per-namespace address lists even if the 
fullmesh pm isn't used.

Right now, I would ask you to wait before making more changes to this 
patch set so the MPTCP upstream community can discuss and decide what the 
proper direction is for path management.


Here are some path-manager-related topics I think the MPTCP upstream 
community should discuss before moving ahead:

* What's the long-term plan for in-kernel vs. userspace PM? Commit to one 
in-kernel PM, plus userspace? Or are there use cases for more in-kernel 
path managers?

* How do those plans affect iproute2?

* What are our limits or expectations for in-kernel PM complexity and 
resource usage?

* How do we structure path management to make sense to users? It could get 
confusing to try to explain the difference between an "in-kernel fullmesh 
PM" vs. "userspace fullmesh PM".

* What are the most important path managers and PM-related development 
tasks to prioritize?


I think this would be a good topic for a Thursday meeting, or we could 
schedule something at a different time.


Thanks,

--
Mat Martineau
Intel
