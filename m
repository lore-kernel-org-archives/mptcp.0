Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6042D2FAE
	for <mptcp@lists.linux.dev>; Tue, 25 May 2021 22:49:53 +0000 (UTC)
IronPort-SDR: 2OmmjBaQvnRnMKIxZvF3cwfnfeRFO/N1pBOPbreQbHO0HjRbTaIhbZpCWhzzNZP62ZSSTWpzwC
 CMefjyL6yYBA==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="182648839"
X-IronPort-AV: E=Sophos;i="5.82,329,1613462400"; 
   d="scan'208";a="182648839"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 15:49:52 -0700
IronPort-SDR: vHvBUHQJIDKkEgpOssIGTPSos8/+8BdayYb8BSXhvk0V6Z+RF8ipEHcCEsL+U7asU3Ov8GRnwC
 2wbyElOkE/eQ==
X-IronPort-AV: E=Sophos;i="5.82,329,1613462400"; 
   d="scan'208";a="414209952"
Received: from unknown (HELO [10.209.3.202]) ([10.209.3.202])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 15:49:51 -0700
Date: Tue, 25 May 2021 15:49:50 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH v8 mptcp-next 0/4] add MP_CAPABLE 'C' flag
In-Reply-To: <cover.1621933974.git.geliangtang@gmail.com>
Message-ID: <1c2231c6-158e-3f91-90ff-47ef2e364da2@linux.intel.com>
References: <cover.1621933974.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 25 May 2021, Geliang Tang wrote:

> v8:
> - drop add_cached in v7
> - tag: export/20210525T061510
>

Thanks Geliang. v8 looks fine to me for the export branch. I think Paolo's 
concerns have been addressed, at least as I understand them.

Maybe best to apply to the export branch after the Thursday meeting just 
to be sure.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


-Mat


> v7:
> - use add_cached instead of add_list
> - tag: export/20210524T060340
>
> v6:
> - rename mptcp_pm_add_entry to mptcp_pm_anno_entry
> - update mptcp_pm_free_add_list
> - update code in mptcp_pm_nl_add_addr_received
> - tag: export/20210514T055902
>
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
> Geliang Tang (4):
>  mptcp: add sysctl allow_join_initial_addr_port
>  mptcp: add allow_join_id0 in mptcp_out_options
>  mptcp: add deny_join_id0 in mptcp_options_received
>  selftests: mptcp: add deny_join_id0 testcases
>
> Documentation/networking/mptcp-sysctl.rst     | 13 ++++
> include/net/mptcp.h                           |  3 +-
> net/mptcp/ctrl.c                              | 16 ++++
> net/mptcp/options.c                           | 12 +++
> net/mptcp/pm.c                                |  1 +
> net/mptcp/pm_netlink.c                        |  3 +-
> net/mptcp/protocol.h                          | 11 ++-
> net/mptcp/subflow.c                           |  3 +
> .../testing/selftests/net/mptcp/mptcp_join.sh | 75 ++++++++++++++++++-
> 9 files changed, 131 insertions(+), 6 deletions(-)
>
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
