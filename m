Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB3317C2
	for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 01:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668735851; x=1700271851;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=pnWLTjkH6b+Vxc570jKKt/0IO8FoZqRwBt35HAo96qg=;
  b=fyGGPsx0n6i0C3NCMvSAYjNmejjwDk6Ojg2cZ3ojiTqDZpgKgy5n2rK4
   +HYZcnsfH2gsbE8mPM+XG4vtbReX18ezSr+1S2bOy8III6115zCtvbxFW
   95C3f67BwKr/8NvXPBlvqyLDFfO8Ln5F2xRi1Sm9OJdRipQLVRKJJr++3
   WqDvUqmkklacPbo/kGu+DnLE74SqPRnXxGvcVjETvt4a4xaWj3g3rTo/W
   q4W31lH57EMqtX1c6vGXeu2xRCFZSBSe2qLmV4lXhmGjWsyJrHVT3Sh1a
   xZt3xRxhMotuK86GqU5pswDH9EH8FqiG7rURF62CPQIKvqTwfkRFvIh9m
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="300563637"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="300563637"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 17:44:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="617839372"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="617839372"
Received: from racevedo-mobl1.amr.corp.intel.com ([10.209.34.116])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 17:44:10 -0800
Date: Thu, 17 Nov 2022 17:44:10 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v5 0/4] add pm listener events
In-Reply-To: <cover.1668662624.git.geliang.tang@suse.com>
Message-ID: <1ac7039a-3872-9ce1-0e7d-fc6ae13522d0@linux.intel.com>
References: <cover.1668662624.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 17 Nov 2022, Geliang Tang wrote:

> v5:
> - use GFP_KERNEL instead of GFP_ATOMIC in patch 1.
> - add the listener event checking in the existing test in patch 4.
> - update subjects and commit logs.
>

v5 looks good to me (one minor commit message change noted on patch 3, if 
it's ok with Geliang):

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> v4:
> - split the selftests into two patches.
> - do some cleanups.
>
> v3:
> - add selftests.
>
> v2:
> - send created event from mptcp_listen.
> - add a new patch, use entry->lsk directly.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/313
>
> Geliang Tang (4):
>  mptcp: add pm listener events
>  selftests: mptcp: enhance userspace pm tests
>  selftests: mptcp: listener test for userspace PM
>  selftests: mptcp: listener test for in-kernel PM
>
> include/uapi/linux/mptcp.h                    |  9 ++
> net/mptcp/pm_netlink.c                        | 57 ++++++++++++
> net/mptcp/protocol.c                          |  3 +
> net/mptcp/protocol.h                          |  2 +
> .../testing/selftests/net/mptcp/mptcp_join.sh | 65 +++++++++++++-
> .../selftests/net/mptcp/userspace_pm.sh       | 89 ++++++++++++++++++-
> 6 files changed, 221 insertions(+), 4 deletions(-)
>
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
