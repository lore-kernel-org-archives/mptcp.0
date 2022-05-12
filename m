Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D57E160
	for <mptcp@lists.linux.dev>; Thu, 12 May 2022 00:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652314666; x=1683850666;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pR8OCziy9uWrINe2HYzY8stQqJBQxkCKJgg+iWlDXk0=;
  b=CwqS0y/NeR9h6M5NkbjX3/b4bMWf+EiF9K2g4Cv5UJK2a42rcu51eul3
   InlpHAH9KZwxwtG9Kn15JmCvyTwtx3D9kpmH/Q8wFZRd2ZSrA5z4w0GEV
   L2YfxXOH3+6+9cjfO5HmLuuZ3cPqbYmUZRC8i0chcz2kjg6e9ARzHIIIV
   D1iAgoAKjnvmyZePtoqbVaitiTuWvx0D4prfcp+HzygBAST7dHxfBmXoD
   gm7o9mhuZsi88X1AaWeXvj/ACzPbL73V8kkA+lyM7A5Xu0+VEtzjBUXB1
   UqxYkwhZSZG7r/b06Xt7s++AYGPoY6T8KLFFZWCiGuH2VgQMKCIRfNtfH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="250374439"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="250374439"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 17:17:45 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="814692905"
Received: from rdstein-mobl.amr.corp.intel.com ([10.212.177.197])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 17:17:45 -0700
Date: Wed, 11 May 2022 17:17:44 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 00/14] update bpf patches on export
 branch
In-Reply-To: <cover.1652255615.git.geliang.tang@suse.com>
Message-ID: <86d11c5a-d5db-2fdb-f40-a9c6b7a06420@linux.intel.com>
References: <cover.1652255615.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 11 May 2022, Geliang Tang wrote:

> v2:
> - drop "bpf: expose is_mptcp flag to bpf_tcp_sock" (Martin & Andrii)
> - patch 3, use is_mptcp in tcp_sock, instead of bpf_tcp_sock (Martin & Andrii)
>
> base-commit: bcf89bc9c28e ("DO-NOT-MERGE: git markup: features
> net-next-next") on export/20220510T054929
>

These look good to replace the equivalent patches in the export branch. 
Thanks Geliang.

- Mat

> v1:
> - drop bpf_mptcp_helpers.h (Andrii)
> - patch 6, skip the test if 'ip mptcp monitor' is not supported (Mat)
>
> Geliang Tang (13):
>  bpf: add bpf_skc_to_mptcp_sock_proto
>  selftests/bpf: Enable CONFIG_IKCONFIG_PROC in config
>  selftests/bpf: test bpf_skc_to_mptcp_sock
>  selftests/bpf: verify token of struct mptcp_sock
>  selftests/bpf: verify ca_name of struct mptcp_sock
>  selftests/bpf: verify first of struct mptcp_sock
>  mptcp: add struct mptcp_sched_ops
>  mptcp: add a new sysctl scheduler
>  mptcp: add sched in mptcp_sock
>  mptcp: add get_subflow wrappers
>  mptcp: add bpf_mptcp_sched_ops
>  selftests/bpf: add bpf_first scheduler
>  selftests/bpf: add bpf_first test
>
> Nicolas Rybowski (1):
>  selftests/bpf: add MPTCP test base
>
> Documentation/networking/mptcp-sysctl.rst     |   8 +
> MAINTAINERS                                   |   1 +
> include/linux/bpf.h                           |   1 +
> include/linux/btf_ids.h                       |   3 +-
> include/net/mptcp.h                           |  25 ++
> include/uapi/linux/bpf.h                      |   7 +
> kernel/bpf/bpf_struct_ops_types.h             |   4 +
> kernel/bpf/verifier.c                         |   1 +
> kernel/trace/bpf_trace.c                      |   2 +
> net/core/filter.c                             |  18 +
> net/mptcp/Makefile                            |   4 +-
> net/mptcp/bpf.c                               | 175 ++++++++
> net/mptcp/ctrl.c                              |  14 +
> net/mptcp/protocol.c                          |  32 +-
> net/mptcp/protocol.h                          |  12 +
> net/mptcp/sched.c                             | 141 +++++++
> scripts/bpf_doc.py                            |   2 +
> tools/include/uapi/linux/bpf.h                |   7 +
> tools/testing/selftests/bpf/bpf_tcp_helpers.h |  32 ++
> tools/testing/selftests/bpf/config            |   3 +
> tools/testing/selftests/bpf/network_helpers.c |  43 +-
> tools/testing/selftests/bpf/network_helpers.h |   4 +
> .../testing/selftests/bpf/prog_tests/mptcp.c  | 378 ++++++++++++++++++
> .../selftests/bpf/progs/mptcp_bpf_first.c     |  32 ++
> .../testing/selftests/bpf/progs/mptcp_sock.c  |  82 ++++
> 25 files changed, 1002 insertions(+), 29 deletions(-)
> create mode 100644 net/mptcp/bpf.c
> create mode 100644 net/mptcp/sched.c
> create mode 100644 tools/testing/selftests/bpf/prog_tests/mptcp.c
> create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
> create mode 100644 tools/testing/selftests/bpf/progs/mptcp_sock.c
>
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
