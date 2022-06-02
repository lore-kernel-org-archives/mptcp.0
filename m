Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5534A363
	for <mptcp@lists.linux.dev>; Thu,  2 Jun 2022 00:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654128137; x=1685664137;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UEpeExEmUt3yUBD9YrdsV+iyPSv2AkkHAct0yWgjKak=;
  b=MUd6KRu0T309sJWLvumPVZCaml8RpBIq4aF4LfIFhvUB1yvJH7VMFMbP
   d3X6gL3Z88Y6fWy6NqAKyTJ3rXB73ZIPV9JdoI/QCRlhhPy4+nxIUX16i
   WUWPchXAcxyZglfax/DsBmvuC2VB0wYzr7vZUz+2warAP0hEij8Qny5dq
   WbJXnY3YAB6CceoZXxybc5ciTMopYYQz6ylRyqCq7LkB0C1IX7PHEuvBi
   GvZ0VRosPE0nbtJUaRTzQxm2Q4XF8sGoJ8Tkt8n8WQQrOjVuw8cIvSJPr
   +vk4FKNzvHO8ZnE+L+Anp8Tn2nPZaYxrdS+1EAVs7Ty/5z7EfMDq3ZI4E
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="273338762"
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="273338762"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 17:02:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,270,1647327600"; 
   d="scan'208";a="904701251"
Received: from hli80-mobl.amr.corp.intel.com ([10.212.232.82])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 17:02:16 -0700
Date: Wed, 1 Jun 2022 17:02:10 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v6 00/11] BPF packet scheduler
In-Reply-To: <cover.1654092153.git.geliang.tang@suse.com>
Message-ID: <a8e78a15-c2bf-fb1a-9496-2555b92193f@linux.intel.com>
References: <cover.1654092153.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 1 Jun 2022, Geliang Tang wrote:

> v6:
> - fix the warning reported by kernel test robot:
>
>>> net/mptcp/bpf.c:165:6: warning: no previous prototype for 'bpf_mptcp_subflow_set_scheduled' [-Wmissing-prototypes]
>     165 | void bpf_mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow)
>         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> - rename bpf_mptcp_subflow_set_scheduled to mptcp_subflow_set_scheduled
>

I think these should be squashed/applied to the export branch. Any other 
fixes can be squashed later.

I have a minor change to suggest in patch 5, I'll reply to that 
separately.

- Mat

> v5:
> - add bpf_mptcp_subflow_set_scheduled helper.
> - drop padding bits before backup, use BPF_CORE_READ_BITFIELD_PROBED()
>   instead.
> - The new patch "mptcp: add bpf set scheduled helper" should be inserted
>   between the commits "mptcp: add bpf_mptcp_sched_ops" and
>   "selftests/bpf: add bpf_first scheduler"
>
> v4:
> - merge "mptcp: move is_scheduled into mptcp_subflow_context"
> - rename bpf_backup tp bpf_bkup
> - full patches of this series: https://github.com/geliangtang/mptcp_net-next
>
> v3:
> - use new BPF scheduler API:
> - add backup scheduler
> - add round-robin scheduler
> - check bytes_sent of 'ss' output.
>
> v2:
> - Use new BPF scheduler API:
> unsigned long (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
>                              struct mptcp_sched_data *data);
>
> Geliang Tang (11):
>  Squash to "mptcp: add struct mptcp_sched_ops"
>  Squash to "mptcp: add sched in mptcp_sock"
>  Squash to "mptcp: add get_subflow wrappers"
>  Squash to "mptcp: add bpf_mptcp_sched_ops"
>  mptcp: add subflow_set_scheduled helper
>  Squash to "selftests/bpf: add bpf_first scheduler"
>  Squash to "selftests/bpf: add bpf_first test"
>  selftests/bpf: add bpf_bkup scheduler
>  selftests/bpf: add bpf_bkup test
>  selftests/bpf: add bpf_rr scheduler
>  selftests/bpf: add bpf_rr test
>
> include/net/mptcp.h                           |  7 +-
> net/mptcp/bpf.c                               | 34 ++++---
> net/mptcp/protocol.h                          |  3 +
> net/mptcp/sched.c                             | 60 ++++++++++---
> tools/testing/selftests/bpf/bpf_tcp_helpers.h | 17 +++-
> .../testing/selftests/bpf/prog_tests/mptcp.c  | 89 ++++++++++++++++++-
> .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 43 +++++++++
> .../selftests/bpf/progs/mptcp_bpf_first.c     |  5 +-
> .../selftests/bpf/progs/mptcp_bpf_rr.c        | 46 ++++++++++
> 9 files changed, 272 insertions(+), 32 deletions(-)
> create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
> create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
>
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
