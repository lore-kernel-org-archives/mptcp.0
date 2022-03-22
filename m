Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE35A50
	for <mptcp@lists.linux.dev>; Tue, 22 Mar 2022 21:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647983561; x=1679519561;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pfeE+V6/+FtNeBqgIzXnStWi81ClyBjOeQ0OsYMlglA=;
  b=LnrFFBPs+yP2IgKfqMxPSpSQvHUs+jMm93xdklsyxi3i2CvCr71fSQPo
   a8RoGK+7ntBK2eq4YH4ZTV2ovu9sCzLys9j58EWJs0SXX0Aq3CxC5XHJE
   HCnXuyTEBo/N9KfIAP5RJ540AGv8p2EOyAElqY0JQ9CYhzYTPc94igMkV
   gAKC5AF9z0VijlJofWU3woyL5fkNGiG7DXgr5i3Q3g1GNlh52E4DsTr4F
   oZqG04WJ2ilDWutjGEaKT4pPEklPyQWMwYfRIW2EN5iITYjie0O3tvYyV
   ifs9GgDbNQ2mjHi7A2EmPpvgMcEz6XFymCYZessFVAVtjjzeNTg8JIDiR
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="257665598"
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="257665598"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 14:12:41 -0700
X-IronPort-AV: E=Sophos;i="5.90,202,1643702400"; 
   d="scan'208";a="552265016"
Received: from priyankk-mobl1.amr.corp.intel.com ([10.212.193.244])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 14:12:40 -0700
Date: Tue, 22 Mar 2022 14:12:40 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 0/8] BPF packet scheduler
In-Reply-To: <cover.1647942374.git.geliang.tang@suse.com>
Message-ID: <96349b9-1e53-7664-556f-142a4140257a@linux.intel.com>
References: <cover.1647942374.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 22 Mar 2022, Geliang Tang wrote:

> v4:
> - set msk->sched to &mptcp_sched_default when the sched argument is NULL
> in mptcp_init_sched().
>
> Depends on the bpf patches queued in the patchwork:
> - add skc_to_mptcp_sock, v10
> - check more values from mptcp_sock, v2

Hi Geliang -

I sent a message earlier today about rebasing the above series, can you 
rebase this one too? It doesn't apply easily on the current export branch 
or export/20220303T054913, with the above prerequisites.

I'll still post a few comments just based on the email version of the 
patches.

- Mat


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
>
> Addressed to the commends in the RFC version:
> https://patchwork.kernel.org/project/mptcp/cover/cover.1631011068.git.geliangtang@xiaomi.com/
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/75
>
> Geliang Tang (8):
>  mptcp: add struct mptcp_sched_ops
>  mptcp: register default scheduler
>  mptcp: add a new sysctl scheduler
>  mptcp: add sched in mptcp_sock
>  mptcp: add mptcp_get_subflow wrapper
>  mptcp: add bpf_mptcp_sched_ops
>  selftests: bpf: add bpf_first scheduler
>  selftests: bpf: add bpf_first test
>
> Documentation/networking/mptcp-sysctl.rst     |   8 ++
> include/net/mptcp.h                           |  13 +++
> kernel/bpf/bpf_struct_ops_types.h             |   4 +
> net/mptcp/Makefile                            |   2 +-
> net/mptcp/bpf.c                               | 102 ++++++++++++++++++
> net/mptcp/ctrl.c                              |  14 +++
> net/mptcp/protocol.c                          |  13 ++-
> net/mptcp/protocol.h                          |  11 ++
> net/mptcp/sched.c                             |  94 ++++++++++++++++
> tools/testing/selftests/bpf/bpf_tcp_helpers.h |  12 +++
> .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  42 +++++++-
> tools/testing/selftests/bpf/progs/bpf_first.c |  30 ++++++
> 12 files changed, 336 insertions(+), 9 deletions(-)
> create mode 100644 net/mptcp/sched.c
> create mode 100644 tools/testing/selftests/bpf/progs/bpf_first.c
>
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
