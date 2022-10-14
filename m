Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E8D370
	for <mptcp@lists.linux.dev>; Fri, 14 Oct 2022 01:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665710474; x=1697246474;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=O4hiDO6UEvYS2c237TlmsjMyeEinH5Se1GqNeyMOOSk=;
  b=J+/SZSCmTnh3zuXEYcsv5XJPd5Bx/W+5/DFQkolCrVXH5t+D+kxi16Si
   4Ir5vMu+radB/feQVD6u2QC2F/SzZZbisjrajCBYjncZddJuqtL7RxvyD
   G1nXplcbTTvGKl0XiSWwFaZDSM6KM2PbKMc51eLMIPj9vO1Io6ctVZxV0
   a3ichv30MyKhsC3VO4+FOdgDPkEjxw0VInNtBzeaSKkUxDal9GLvt73GU
   F3w7Sm2FPFPx472mvLaQ6Q6rXPNTpK427XOG+QhZz+uAXDrSiW90AmyXK
   7e3/aP7XE+GL+7jszT/PRp2V4h9wE8EwhqN0Qf/Oxq+pLN/KaEQJBVm5Z
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="288536477"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="288536477"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 18:20:58 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="690353868"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="690353868"
Received: from pateldee-mobl5.amr.corp.intel.com ([10.209.118.62])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 18:20:58 -0700
Date: Thu, 13 Oct 2022 18:20:57 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 00/16] register default scheduler
In-Reply-To: <cover.1665549881.git.geliang.tang@suse.com>
Message-ID: <0dab574d-6f86-c437-0e23-48ddab404149@linux.intel.com>
References: <cover.1665549881.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 12 Oct 2022, Geliang Tang wrote:

> v2:
> - split "mptcp: add mptcp_sched_data argument" into 5 squash-to patches.
> - split "mptcp: register default scheduler" into 3 patches.
> - depends on "refactor push pending" v7
>

Thanks for rebasing this Geliang.

In the review for the "refactor push pending" series, I proposed that the 
series focus on the single-subflow refactoring for now. Does it make sense 
to rearrange these two patch series in to four different series like this:

1. refactor push pending (single subflow)
2. register default scheduler (single subflow)
3. Add multi-subflow scheduling
4. Update BPF scheduler for multi-subflow

I'm trying to think of a way to focus on *one patch set at a time* so we 
can make progress more easily. The large patch sets with lots of squash-to 
patches are getting hard to keep track of.

Thanks,

Mat

> Register the burst scheduler as the default one.
>
> Geliang Tang (16):
>  Squash to "mptcp: add struct mptcp_sched_ops"
>  Squash to "mptcp: add get_subflow wrappers" II
>  Squash to "mptcp: simplify push_pending"
>  Squash to "mptcp: multi subflows push_pending"
>  Squash to "mptcp: simplify subflow_push_pending"
>  Squash to "mptcp: multi subflows subflow_push_pending"
>  Squash to "mptcp: multi subflows retrans support"
>  mptcp: use snd_burst of data instead of msk
>  mptcp: define default scheduler
>  mptcp: register default scheduler
>  mptcp: add mptcp_sched_data_set_contexts helper
>  Squash to "bpf: Add bpf_mptcp_sched_ops"
>  Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
>  Squash to "selftests/bpf: Add bpf_first scheduler"
>  Squash to "selftests/bpf: Add bpf_bkup scheduler"
>  Squash to "selftests/bpf: Add bpf_rr scheduler"
>
> include/net/mptcp.h                           |  7 +-
> net/mptcp/bpf.c                               |  1 +
> net/mptcp/protocol.c                          | 33 ++++---
> net/mptcp/protocol.h                          | 13 ++-
> net/mptcp/sched.c                             | 92 ++++++++++---------
> tools/testing/selftests/bpf/bpf_tcp_helpers.h |  9 +-
> .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 10 +-
> .../selftests/bpf/progs/mptcp_bpf_first.c     | 10 +-
> .../selftests/bpf/progs/mptcp_bpf_rr.c        | 10 +-
> 9 files changed, 116 insertions(+), 69 deletions(-)
>
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
