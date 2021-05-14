Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8B270
	for <mptcp@lists.linux.dev>; Fri, 14 May 2021 23:36:10 +0000 (UTC)
IronPort-SDR: MwuUz+4ZqeGpKsjTnppK4CyhH/bn3IXN8Uo6hDOT6KZVYtDCG1lfhiEBOCF81si/GHEmxUN+b5
 sNKVNBRZU0Rw==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="187372808"
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="187372808"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 16:36:10 -0700
IronPort-SDR: XBh9f87lYPsFrc0CNDuVVZiYer60RUGBbbz0NBaZ/j34/cBVIH4+TjGJv4UlqNlXuA3n0a+oJP
 y5ISoVn3iAqQ==
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="438193421"
Received: from akshtadu-mobl.amr.corp.intel.com ([10.251.18.116])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 16:36:09 -0700
Date: Fri, 14 May 2021 16:36:09 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH v6 mptcp-next 0/6] add MP_CAPABLE 'C' flag
In-Reply-To: <cover.1621002341.git.geliangtang@gmail.com>
Message-ID: <6710673b-57b5-ec89-26ad-e047ef9e459c@linux.intel.com>
References: <cover.1621002341.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Fri, 14 May 2021, Geliang Tang wrote:

> v6:
> - rename mptcp_pm_add_entry to mptcp_pm_anno_entry
> - update mptcp_pm_free_add_list
> - update code in mptcp_pm_nl_add_addr_received
> - tag: export/20210514T055902
>

Hi Geliang -

Thanks for the changes, v6 looks good for the export branch.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


-Mat


> v5:
> - add a new patch "mptcp: add add_list in mptcp_pm_data"
> - fix !CONFIG_SYSCTL case
> - tag: export/20210507T174457
>
> v4:
> - rename mptcp_is_allow_join_id0 to mptcp_allow_join_id0
> - rename deny_join_id0 in mptcp_pm_data to remote_deny_join_id0
> - add comments for self test cases
> - apply: export/20210504T064955 +
>          "data checksum support" +
>          "data checksum support cleanups"
>
> v3:
> - use 'u8 allow_join_initial_addr_port'
> - drop the spinlock in patch 3
>
> v2:
> - rename join_denied to allow_join_id0 in mptcp_out_options
> - rename join_denied to deny_join_id0 in mptcp_options_received
> - add a new function mptcp_pm_deny_join_id0_received
> - move deny_join_id0 flag from mptcp_sock to mptcp_pm_data
> - check deny_join_id0 flag in mptcp_pm_create_subflow_or_signal_addr
> instead of in mptcp_syn_options.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/183
>
> Geliang Tang (6):
>  mptcp: add sysctl allow_join_initial_addr_port
>  mptcp: add allow_join_id0 in mptcp_out_options
>  mptcp: rename mptcp_pm_add_entry to mptcp_pm_anno_entry
>  mptcp: add add_list in mptcp_pm_data
>  mptcp: add deny_join_id0 in mptcp_options_received
>  selftests: mptcp: add deny_join_id0 testcases
>
> Documentation/networking/mptcp-sysctl.rst     |  13 ++
> include/net/mptcp.h                           |   3 +-
> net/mptcp/ctrl.c                              |  16 ++
> net/mptcp/options.c                           |  14 +-
> net/mptcp/pm.c                                |   2 +
> net/mptcp/pm_netlink.c                        | 151 ++++++++++++++----
> net/mptcp/protocol.c                          |   1 +
> net/mptcp/protocol.h                          |  21 ++-
> net/mptcp/subflow.c                           |   3 +
> .../testing/selftests/net/mptcp/mptcp_join.sh |  56 ++++++-
> 10 files changed, 238 insertions(+), 42 deletions(-)
>
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
