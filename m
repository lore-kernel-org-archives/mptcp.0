Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3976029A1
	for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 23:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648595584; x=1680131584;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=R0UbuqJSiyAP2VmSarJrESO4BoxzBbNXzu7ZPn9Ihgk=;
  b=DVgIw7R0LRtgT8BLDduJlbajIdqsf9gm6HMTKS6yK+563iDmCciuSEGg
   oKVIS14U76aFF4F4gAY54BqRfoab4KmGhyUwMICK/TZHdg5Wz9pxTOJdL
   RkLNjax8TWgFPCDl/0E6OpdluBb3eLP3GKFcKi84uHfY817fwXvtJfF1H
   N2MgGgLlN/pKvwEyio+XRoxtUaPS7DN/ztqTjqJJJpw0qdDhcF0d4Eu5O
   pT2n38kG4NAtQJz6K02P9Q8IB1L5iug5HP33PZztQnn8H9j5caLp9/mg0
   XE7cz0UCleUlGJzjbfNyN+u8XlGxMHvXeFW7nk+3gdvLiES69kCEiW6uY
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="259582987"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="259582987"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 16:13:03 -0700
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="649643978"
Received: from lnlam-mobl.amr.corp.intel.com ([10.252.130.19])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 16:13:03 -0700
Date: Tue, 29 Mar 2022 16:13:02 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev, fw@strlen.de
Subject: Re: [PATCH mptcp-next v8 0/8] BPF packet scheduler
In-Reply-To: <cover.1648537203.git.geliang.tang@suse.com>
Message-ID: <bf2b415d-a5f8-907c-9a55-d8b6d2c317b6@linux.intel.com>
References: <cover.1648537203.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


On Tue, 29 Mar 2022, Geliang Tang wrote:

> v8:
> - use global sched_list instead of pernet sched_list.

Yes, I think this is fine. I had initially asked about pernet 
configuration with respect to registering BPF schedulers, but the 
important thing is that the sysctl can be set per-namespace.

> - drop synchronize_rcu() in mptcp_unregister_scheduler().
> - update mptcp_init_sched and mptcp_release_sched as Mat and Florian
>   suggested.
> - fix the build break in patch 8.
> - depends on: "add skc_to_mptcp_sock" v14.
> - export/20220325T055307

Thanks for updating. Builds and runs fine here.

Before we add this to the export branch, have you thought about how 
subflow data (including the backup bit and throughput/latency data used by 
the default scheduler) can be accessed in the BPF get_subflow hook? Do you 
think that can be cleanly added after this series, or is there anything 
that may need to be changed in this series?

Thanks,

Mat


>
> v7:
> - add bpf_try_module_get in mptcp_init_sched.
> - add bpf_module_put in mptcp_release_sched.
> - rename bpf_first to mptcp_bpf_first.
> - update commit logs.
>
> v6:
> - still use pernet sched_list, use current->nsproxy->net_ns in BPF
>   context instead of using init_net.
> - patch 1:
>   - use rcu_read_lock instead of spin_lock in mptcp_sched_find as Florian suggested.
>   - drop synchronize_rcu in sched_exit_net as Florian suggested.
>   - keep synchronize_rcu in mptcp_unregister_scheduler, otherwise, got
>     a workqueue lockup in my test.
>   - update Makefile as Mat suggested.
> - patch 2:
>   - add mptcp_sched_data_init to register default sched, instead of
>     registering it in init_net.
> - patch 5:
>   - move mptcp_sched_get_subflow to protocol.h as Mat suggested.
> - patch 6:
>   - use current->nsproxy->net_ns instead of init_net.
> - patch 8:
>   - add send_data to send more data, instead of send_byte.
>
> v5:
> - patch 1: define per-namespace sched_list (but only used init_net
>   namespace. It is difficult to get 'net' in bpf_mptcp_sched_reg and
>   bpf_mptcp_sched_unreg. I need some suggestions here.)
> - patch 2: skip mptcp_sched_default in mptcp_unregister_scheduler.
> - patch 8: add tests into mptcp.c, instead of bpf_tcp_ca.c.
>
> v4:
> - set msk->sched to &mptcp_sched_default when the sched argument is NULL
> in mptcp_init_sched().
>
> v3:
> - add mptcp_release_sched helper in patch 4.
> - rename mptcp_set_sched to mptcp_init_sched in patch 4.
> - add mptcp_sched_first_release in patch 7.
> - do some cleanups.
>
> v2:
> - split into more small patches.
> - change all parameters of mptcp_sched_ops from sk to msk:
>       void (*init)(struct mptcp_sock *msk);
>       void (*release)(struct mptcp_sock *msk);
>       struct sock *   (*get_subflow)(struct mptcp_sock *msk);
> - add tests in bpf_tcp_ca.c, instead of adding a new one.
>
> v1:
> - Addressed to the commends in the RFC version.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/75
>
> Geliang Tang (8):
>  mptcp: add struct mptcp_sched_ops
>  mptcp: register default scheduler
>  mptcp: add a new sysctl scheduler
>  mptcp: add sched in mptcp_sock
>  mptcp: add get_subflow wrapper
>  mptcp: add bpf_mptcp_sched_ops
>  selftests: bpf: add bpf_first scheduler
>  selftests: bpf: add bpf_first test
>
> Documentation/networking/mptcp-sysctl.rst     |   8 ++
> include/net/mptcp.h                           |  13 ++
> kernel/bpf/bpf_struct_ops_types.h             |   4 +
> net/mptcp/Makefile                            |   2 +-
> net/mptcp/bpf.c                               | 102 ++++++++++++++++
> net/mptcp/ctrl.c                              |  14 +++
> net/mptcp/protocol.c                          |  15 ++-
> net/mptcp/protocol.h                          |  16 +++
> net/mptcp/sched.c                             | 104 ++++++++++++++++
> tools/testing/selftests/bpf/bpf_tcp_helpers.h |  12 ++
> .../testing/selftests/bpf/prog_tests/mptcp.c  | 114 ++++++++++++++++++
> .../selftests/bpf/progs/mptcp_bpf_first.c     |  30 +++++
> 12 files changed, 429 insertions(+), 5 deletions(-)
> create mode 100644 net/mptcp/sched.c
> create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
>
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
