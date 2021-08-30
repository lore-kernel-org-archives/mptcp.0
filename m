Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E273FC3
	for <mptcp@lists.linux.dev>; Mon, 30 Aug 2021 18:40:48 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="282046133"
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="282046133"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 11:40:48 -0700
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="518967614"
Received: from sahushub-mobl1.amr.corp.intel.com ([10.209.36.196])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 11:40:47 -0700
Date: Mon, 30 Aug 2021 11:40:47 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/2] MPTCP_INFO: Fix compilation errors
In-Reply-To: <20210830103357.3114290-1-matthieu.baerts@tessares.net>
Message-ID: <ca22e2bc-ac5a-aa6a-b247-32359611a3@linux.intel.com>
References: <20210830103357.3114290-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 30 Aug 2021, Matthieu Baerts wrote:

> Geliang and Intel's 0-DAY CI Kernel Test Service reported compilation errors.
> Those are fixed in patch 1/2.
>
> Patch 2/2 contains one modification needed after patch 1/2 but also 2 others.
>

These look ok to squash, one detail:

> Matthieu Baerts (2):
>  Squash to "mptcp: add MPTCP_INFO getsockopt"

The struct_subflow_addrs hunk of this one applies to "mptcp: add 
MPTCP_SUBFLOW_ADDRS getsockopt support", but I figure you can straighten 
that out when applying (no need to repost).

>  Squash to "selftests: mptcp: add mptcp getsockopt test cases"
>
> include/uapi/linux/mptcp.h                    | 12 ++++--
> .../selftests/net/mptcp/mptcp_sockopt.c       | 40 +++++++++----------
> 2 files changed, 29 insertions(+), 23 deletions(-)
>
> -- 
> 2.32.0
>
>
>

--
Mat Martineau
Intel
