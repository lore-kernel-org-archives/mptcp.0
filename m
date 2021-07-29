Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A4B3481
	for <mptcp@lists.linux.dev>; Thu, 29 Jul 2021 00:17:27 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="212500768"
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="212500768"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 17:17:25 -0700
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="417446416"
Received: from sghoshal-mobl.amr.corp.intel.com ([10.212.197.34])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 17:17:25 -0700
Date: Wed, 28 Jul 2021 17:17:24 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@xiaomi.com>
Subject: Re: [MPTCP][PATCH v6 mptcp-next 0/5] fullmesh path manager support
In-Reply-To: <cover.1627391588.git.geliangtang@xiaomi.com>
Message-ID: <d7953e6a-46f0-4ce7-fde0-b4e91eed8057@linux.intel.com>
References: <cover.1627391588.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 27 Jul 2021, Geliang Tang wrote:

> From: Geliang Tang <geliangtang@xiaomi.com>
>
> v6:
> - drop lookup_subflow_by_addrs()
> - pass three arrays instead of 'entries' in fill_local_adresses_vec()
> - drop the 'remote' argument of fill_local_addresses_vec
> - drop the 'local' argument of fill_remote_addresses_vec
> - fix the pm.subflows.
> - add limit testcase.
>

Thanks for the revisions! Extending the netlink PM is a much better fit.

I don't have any comments to add to Paolo and Mattheiu's squash-fix 
recommendations.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


-Mat

> v5:
> - patch 1, add a new helper lookup_address_in_vec.
> - patch 2, update pm.subflows in the non-fullmesh case.
> - patch 4, add more tests.
> - tag: export/20210727T054640
>
> v4:
> - add new helpers, fill_local/remote_addresses_vec
> - add max_subflows checks
> - add 'local' into the local addresses array only when no fullmesh
>   entry found.
> - add signal,fullmesh check
>
> v3:
> - the in-kernel fullmesh path manager has been dropped from this
>   patchset, only keep the fullmesh flag support code.
>
> v2:
> - Implement the fullmesh mode as an extension to the netlink PM, not a
>   standalone PM as Paolo suggested.
> - drop duplicate code.
> - add a new per endpoint flag MPTCP_PM_ADDR_FLAG_FULLMESH.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/193
>
> Geliang Tang (5):
>  mptcp: remote addresses fullmesh
>  mptcp: local addresses fullmesh
>  selftests: mptcp: set and print the fullmesh flag
>  selftests: mptcp: add fullmesh testcases
>  selftests: mptcp: delete uncontinuous removing ids
>
> include/uapi/linux/mptcp.h                    |   1 +
> net/mptcp/pm_netlink.c                        | 145 ++++++++++++++++--
> .../testing/selftests/net/mptcp/mptcp_join.sh |  67 +++++++-
> tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  16 +-
> 4 files changed, 206 insertions(+), 23 deletions(-)
>
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
