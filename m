Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6CD17E7
	for <mptcp@lists.linux.dev>; Mon, 28 Mar 2022 22:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648506904; x=1680042904;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=s6TQF10cJgFMF5XBsUypily8BIzTZUl9olPLupNraUg=;
  b=MYemNjsUneFgGe2a0ZE93kzDmc2HWs4KZ7YABOqLgrQK7q+dL9oEY3dd
   RCzvhFP3ccW0JH8bee1aFa/W3qSnp1Lbp3fzLtaifOo2uwRsmHS0A61Ie
   2rvidi+dlYIw4h0lwi31lTreajkky3O4vQVzll+Eqa3BT3vPQeRVNwZm3
   envcG7hzrvzwANMu8+Gg3lGWO4DTdHdBE8a+HZE6IU83WzfxYDFaRxLTO
   chocwjqVPQ+ztfzCz5iG59Jk8VHJUtRExkBaKGYPeN6QoNCHNtQ1r8a2n
   3hNwoO3oqbUIJgnzcpzX7zdFt5RpTh862C9aIGBiELctKj6EX6lTseCyV
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="256691289"
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="256691289"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 15:35:03 -0700
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="694515407"
Received: from pchung1-mobl.amr.corp.intel.com ([10.209.44.61])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 15:35:03 -0700
Date: Mon, 28 Mar 2022 15:35:02 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v14 0/6] add skc_to_mptcp_sock
In-Reply-To: <cover.1648311457.git.geliang.tang@suse.com>
Message-ID: <af1bae9-ab98-245-4bce-1747b1fbfeb1@linux.intel.com>
References: <cover.1648311457.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Sun, 27 Mar 2022, Geliang Tang wrote:

> This series addresses to Alexei comments in [1].
>
> [1]
> https://lore.kernel.org/netdev/20200922040830.3iis6xiavhvpfq3v@ast-mbp.dhcp.thefacebook.com/
>
> v14:
> - merge the squash-to patch for patch 1.
> - rename progs/mptcp.c to progs/mptcp_sock.c in patch 2.
> - split the token verifying as a new patch from patch 3.
> - update the commit logs.

Looks ok to me, Matthieu had acked the previous rev so he can take another 
look too.

- Mat

>
> v13:
> patch 1:
>  As Mat mentioned in the "BPF packet scheduler" series, BPF packet
> scheduler depends on CONFIG_BPF_SYSCALL. In fact, the series depends on
> CONFIG_BPF_SYSCALL too.
>  - change "CONFIG_BPF" to "CONFIG_BPF_SYSCALL" in Makefile
>  - change "ifdef CONFIG_MPTCP" in include/linux/bpf.h to:
>    "#if defined(CONFIG_MPTCP) && defined(CONFIG_BPF_SYSCALL)"
>  - drop "#ifdef CONFIG_MPTCP" in net/core/filter.c
> patch 2:
>  Address to Matt's comments in v12:
>  - use bpf_object__find_program_by_name, bpf_object__find_map_by_name
>  - use -EIO
>  - drop close_client_fd label
>  - add more CHECK_FAIL
>
> v12:
> patch 1:
>  - merged the squash-to patch for v11.
>  - rebased to export/20220324T054815.
> patch 2:
>  - fix the libbpf 0.8 build error.
> patch 4:
>  - use fgets instead of fread to get null terminated string.
>
> v11:
> - merge "check more values from mptcp_sock" series into this series.
> - patch 2:
>   - rebased.
> - patch 3:
>   - rebased.
>   - add 'Copyright' entry as Matt suggested in v9.
> - patch 4:
>   - add test__start_subtest.
>   - add some 'Copyright' entries.
> - patch 5:
>   - change monitor_log_path to static
>   - drop bpf_trace_printk()
> - patch 6:
>   - use TCP_CA_NAME_MAX instead of strlen(val.ca_name) in strncmp().
>   - use 'sysctl -b net.ipv4.tcp_congestion_control' to get ca_name.
>
> v10:
> - merge the squash-to patch.
> - update patch 3 as Matt suggested.
> - add sync() in get_msk_token() before read().
> - add a comment for get_msk_token().
> - update subjects and commit logs.
>
> v9:
> - update progs/mptcp.c in patch 4 and 5
>
> v8:
> - update as Matt suggested.
>
> v7:
> - parse msk token from the output of 'ip mptcp monitor'.
> - add Nicolas and Matt's SoB tags.
>
> v6:
> - add skc_to_mptcp_sock helper and test
>
> RESEND:
> - fix the CI Build Failure.
> v5:
> - fix incorrect token value
> - verify the token in selftest
>
> v4:
> - define bpf_mptcp_sock_proto as a static function, no longer export
>   it in linux/bpf.h
>
> v3:
> - use RET_PTR_TO_BTF_ID_OR_NULL instead of RET_PTR_TO_MPTCP_SOCK_OR_NULL
> - add a new bpf_id BTF_SOCK_TYPE_MPTCP
>
> v2:
> - keep RET_PTR_TO_MPTCP_SOCK_OR_NULL. If we use RET_PTR_TO_BTF_ID_OR_NULL
> instead of RET_PTR_TO_MPTCP_SOCK_OR_NULL as Alexei suggested, the
> "userspace" tests developed by Nicolas will break.
>
> Geliang Tang (6):
>  bpf: add bpf_skc_to_mptcp_sock_proto
>  Squash to "selftests: bpf: add MPTCP test base"
>  selftests: bpf: test bpf_skc_to_mptcp_sock
>  selftests: bpf: verify token of struct mptcp_sock
>  selftests: bpf: verify ca_name of struct mptcp_sock
>  selftests: bpf: verify first of struct mptcp_sock
>
> include/linux/bpf.h                           |   9 +
> include/linux/btf_ids.h                       |   3 +-
> include/uapi/linux/bpf.h                      |   7 +
> net/core/filter.c                             |  16 ++
> net/mptcp/Makefile                            |   4 +
> net/mptcp/bpf.c                               |  22 ++
> scripts/bpf_doc.py                            |   2 +
> tools/include/uapi/linux/bpf.h                |   7 +
> tools/testing/selftests/bpf/bpf_tcp_helpers.h |  12 +
> .../testing/selftests/bpf/prog_tests/mptcp.c  | 209 +++++++++++++++---
> tools/testing/selftests/bpf/progs/mptcp.c     |  48 ----
> .../testing/selftests/bpf/progs/mptcp_sock.c  |  76 +++++++
> 12 files changed, 331 insertions(+), 84 deletions(-)
> create mode 100644 net/mptcp/bpf.c
> delete mode 100644 tools/testing/selftests/bpf/progs/mptcp.c
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
