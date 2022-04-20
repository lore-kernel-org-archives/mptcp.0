Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F118D10E8
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 00:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650413562; x=1681949562;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4nkNNmVAiZ+Io4wAINqEOPRgW/ZYcDuOnM26Gr13gXw=;
  b=bCAamdro8LmUEpCB4u7Afly6YyiatYVTADiCdTpXF6s9u1IPGGXtr+Lk
   LuZioEy83caqX0MMdDye8tj2r7FFxguuSEVhhM8ViTdXL/fPdOftBLn7g
   JB3WSSNxL982FHnCk8uz3hon7y6sDiy1OJv8zCHzkPyKoE8sfnDY/q8BW
   LQs9CsiCNJ/m3/U7LZPl7BGb7ehRVHxDwNENGpvziAvEaRqr4Jf7GEJC4
   78gxKAqQxvUAUVQmI8nAxnnYamPZMtw1xL69scC/v3FqZ/VWtillreAbw
   OkQysib239m0XKrFtFkQC6zRiz8x5pOeTLA0+QQ+Pc5lhicSBEY2iy62h
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="264074169"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="264074169"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 17:12:41 -0700
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="702371637"
Received: from aupasani-mobl.amr.corp.intel.com ([10.209.21.110])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 17:12:40 -0700
Date: Tue, 19 Apr 2022 17:12:40 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v11 0/8] BPF packet scheduler
In-Reply-To: <cover.1649432004.git.geliang.tang@suse.com>
Message-ID: <6d99dae8-9728-3dc6-cf3c-611d8b3ae0cf@linux.intel.com>
References: <cover.1649432004.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 8 Apr 2022, Geliang Tang wrote:

> v11:
> - add retrans argment for get_subflow()
>
> base-commit: export/20220408T100826

Hi Geliang -

Since we discussed this series in the meeting last week, are you waiting 
for additional feedback here on the mailing list?

Notes on the discussion are here:

https://annuel2.framapad.org/p/mptcp_upstreaming_20220414#L71

The main topic we discussed was how to handle multiple subflows, it 
sounded like you were planning to work on that but I don't want to make an 
incorrect assumption!


- Mat


>
> v10:
> - patch 5: keep msk->last_snd setting in get_subflow().
> - patch 6: add bpf_mptcp_sched_btf_struct_access().
> - patch 8: use MIN() in sys/param.h, instead of defining a new one.
> - update commit logs.
>
> base-commit: export/20220406T054706
>
> v9:
> - patch 2: add the missing mptcp_sched_init() invoking in
>   mptcp_proto_init().
> - patch 5: set last_snd after invoking get_subflow().
> - patch 7: merge the squash-to patch.
>
> v8:
> - use global sched_list instead of pernet sched_list.
> - drop synchronize_rcu() in mptcp_unregister_scheduler().
> - update mptcp_init_sched and mptcp_release_sched as Mat and Florian
>   suggested.
> - fix the build break in patch 8.
> - depends on: "add skc_to_mptcp_sock" v14.
> - export/20220325T055307
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
> net/mptcp/bpf.c                               | 129 ++++++++++++++++++
> net/mptcp/ctrl.c                              |  14 ++
> net/mptcp/protocol.c                          |  24 +++-
> net/mptcp/protocol.h                          |  16 +++
> net/mptcp/sched.c                             | 104 ++++++++++++++
> .../testing/selftests/bpf/bpf_mptcp_helpers.h |  12 ++
> .../testing/selftests/bpf/prog_tests/mptcp.c  | 113 +++++++++++++++
> .../selftests/bpf/progs/mptcp_bpf_first.c     |  30 ++++
> 12 files changed, 464 insertions(+), 5 deletions(-)
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
