Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18AD17E7
	for <mptcp@lists.linux.dev>; Fri, 13 May 2022 01:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652404533; x=1683940533;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=g9HiSvRZpufrC3K95IOhacFNuvsO9+KifoI+tkCxB1c=;
  b=NMqbs1JudQEqHmbAWptNd0gwDrcb0lvtAIEBIVjsZZm+rSrXHj0oXD6j
   77yNyRjG1s3R8t1hj+pMfbom/qmP1o/PRYn/UFdhcQdgUJS01PNYvf1eI
   r7+o8nw+Vrlc8iirUMx0koG639oXolqTmJ+l7M3NabIWa/wKPLJzN4GC3
   +Z0U+tWUFbwr86FILytBSC+equZoSXuil9foPAFyeViOaIHxA+RubwJmC
   18fRq2P2lI7VCVCFWQQ3oWEDfh4UsGhs7qEtZFDTQo8kHWCNRdOekFl11
   ikk6t+RJeUhNMX0e9uHJ0OjwEbQLsoFY8MKQw9KEiQwpbkCCnq2aO85kV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="250081827"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="250081827"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 18:15:33 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="658874929"
Received: from gjimenez-mobl2.amr.corp.intel.com ([10.212.193.238])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 18:15:33 -0700
Date: Thu, 12 May 2022 18:15:32 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 0/5] BPF redundant scheduler
In-Reply-To: <cover.1652271034.git.geliang.tang@suse.com>
Message-ID: <ae464c1c-fc6a-72f3-9ebe-a0c647b9f0e@linux.intel.com>
References: <cover.1652271034.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 11 May 2022, Geliang Tang wrote:

> v2:
> - add MPTCP_SUBFLOWS_MAX limit to avoid infinite loops when the
>   scheduler always sets call_again to true.
> - track the largest copied amount.
> - deal with __mptcp_subflow_push_pending() and the retransmit loop.
> - depends on "BPF round-robin scheduler" v14.

Thanks for those updates.

As we talked about in the meeting this week, I think it's still good to 
revise this to be able to return multiple subflows (whether in a bitmap or 
array) from the BPF scheduler function. That is more likely to be workable 
with __mptcp_subflow_push_pending() and the way it chains to send on 
different subflows with mptcp_subflow_delegate().

- Mat

>
> v1:
>
> Implements the redundant BPF MPTCP scheduler, which sends all packets
> redundantly on all available subflows.
>
> depends on:
> - BPF round-robin scheduler, v13
>
> Geliang Tang (5):
>  Squash to "mptcp: add get_subflow wrappers"
>  mptcp: add redundant subflows support
>  mptcp: add call_again flag in mptcp_sched_ops
>  selftests/bpf: add bpf_red scheduler
>  selftests/bpf: add bpf_red test
>
> include/net/mptcp.h                           |  1 +
> net/mptcp/protocol.c                          | 64 ++++++++++++++-----
> net/mptcp/protocol.h                          |  4 +-
> net/mptcp/sched.c                             | 11 +++-
> .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +++++++++++
> .../selftests/bpf/progs/mptcp_bpf_red.c       | 54 ++++++++++++++++
> 6 files changed, 151 insertions(+), 21 deletions(-)
> create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
>
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
