Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B877C
	for <mptcp@lists.linux.dev>; Wed, 16 Nov 2022 00:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668559277; x=1700095277;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VhpBdvVFRfiHVer5EtMAIDXcly+VVVVhNUFGD4np3xc=;
  b=MbjPQbw4hGLgk8UsHqKojWqijzDYP4+JrvakuUM/C3inb0RFadKGQQHA
   cgGHysDATjVOL3M40CxR61SOap0pigi3v3DD3nplAvqYk6k8qJRCGbhSC
   2C1dTrFu6+PF0dIFSyU+B458R6kHgRChyhsOFSroC+ohi7kS0iY3pClf7
   0yS8T+RXw9goCLIGt4v9YabKZGjIoDfU793Z19Kgq2rQwg2lw7EdIpI7c
   c52t0MvZVKkkdLH5LFsLFl9vZ0slm4dUQiCOpiseJKm1UcEyBrUK3jg9r
   WsNzsFtpkjlZC5o8LAAbOJUWk5MY5lxSPBrPMmze7KWrrX5y/vsnFQK6V
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="311115900"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="311115900"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 16:41:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="707940735"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="707940735"
Received: from trichard-mobl1.amr.corp.intel.com ([10.209.2.82])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 16:41:16 -0800
Date: Tue, 15 Nov 2022 16:41:15 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v19 0/9] BPF redundant scheduler, part 1
In-Reply-To: <cover.1668151131.git.geliang.tang@suse.com>
Message-ID: <76ad0b0b-e55c-22cc-690f-c0fcdd78fca6@linux.intel.com>
References: <cover.1668151131.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 11 Nov 2022, Geliang Tang wrote:

> v19:
> - update patch 1.
> - split "BPF redundant scheduler" into two parts.
> - rebased on "export/20221111T055536".
>

Thanks Geliang.

I think v19 (part 1) looks ok for the export branch. simult_flows.sh was 
slightly faster (small sample size :) ) on my VM, for what it's worth.

Looks like the first three patches go at the beginning of the "features 
net-next-next" section, correct?

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> Geliang Tang (9):
>  mptcp: refactor push_pending logic
>  mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
>  mptcp: add sched_data_set_contexts helper
>  Squash to "mptcp: add struct mptcp_sched_ops"
>  Squash to "bpf: Add bpf_mptcp_sched_ops"
>  Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
>  Squash to "selftests/bpf: Add bpf_first scheduler"
>  Squash to "selftests/bpf: Add bpf_bkup scheduler"
>  Squash to "selftests/bpf: Add bpf_rr scheduler"
>
> include/net/mptcp.h                           |   6 +-
> net/mptcp/bpf.c                               |   1 +
> net/mptcp/pm.c                                |   9 +-
> net/mptcp/pm_netlink.c                        |   3 -
> net/mptcp/protocol.c                          | 161 +++++++++---------
> net/mptcp/protocol.h                          |   1 -
> net/mptcp/sched.c                             |  21 ++-
> tools/testing/selftests/bpf/bpf_tcp_helpers.h |   8 +-
> .../selftests/bpf/progs/mptcp_bpf_bkup.c      |  10 +-
> .../selftests/bpf/progs/mptcp_bpf_first.c     |  10 +-
> .../selftests/bpf/progs/mptcp_bpf_rr.c        |  10 +-
> 11 files changed, 143 insertions(+), 97 deletions(-)
>
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
