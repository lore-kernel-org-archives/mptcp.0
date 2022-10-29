Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94C27B
	for <mptcp@lists.linux.dev>; Sat, 29 Oct 2022 00:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667004522; x=1698540522;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+6lpJJEfPvbKSHG6j71IOpzGK/+qpk/LI3BHEx0F/5k=;
  b=OZnwBF/aVq048Y/psm4o2LFNHj9ZPBIztQbTEhjSz7RO6XhryoS4BxYc
   QfRk5lUo6wdHG1ud23KUpi4lFYOS0oOjQ8Pj2qqDymvVMwMw2zESTLNzx
   vZrI/esLkynZE7dNSsuvCZ8za89ukbXLNCiRaQvOqvb1KcxTJhEyLWCYZ
   fiRAxf2OKZFWHOUCVCyfmmJaraVMjLM/Sv48rCL6/4YE/kRRO5OX91lQK
   Sm3FP04MePN1wop2qKZ1F2bfGuNVpfoAQ8ZLAnQlUvIvagJz8Eh1NPJPZ
   FWR2p0kXxacGUelK/cMIivPMbcU7iRWgiVZtlS0b6wu3puYlfPX3EROAw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="310318817"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="310318817"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 17:48:34 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="610931654"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="610931654"
Received: from jwaelder-mobl.amr.corp.intel.com ([10.212.239.103])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 17:48:34 -0700
Date: Fri, 28 Oct 2022 17:48:34 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/4] mptcp: run mptcp_sockopt from a new netns
 + cleanup
In-Reply-To: <20221019161940.3178393-1-matthieu.baerts@tessares.net>
Message-ID: <7dcdee31-d2b9-8d71-efcd-cd9b64278dd7@linux.intel.com>
References: <20221019161940.3178393-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 19 Oct 2022, Matthieu Baerts wrote:

> Here are some small fixes for the MPTCP selftests, no big changes.
>
> The first patch is a fix and for -net: if we run mptcp_sockopt.sh after having
> modified some settings related to MPTCP on the host, we can run into issues
> without this patch.
>

Hi Matthieu -

The changes are looking good to me, and Geliang's suggestion on patch 1 
seems worthwhile for consistency. Can you post a v2 with the suggested 
global ns variables?


Thanks,

Mat


> The second patch uses the new netns for mptcp_inq, cleaner.
>
> The third one remove some defined but unused vars.
>
> The last one uniform 'rndh' variable because it was declared with undefined
> variables in a few places.
>
> Matthieu Baerts (4):
>  selftests: mptcp: run mptcp_sockopt from a new netns
>  selftests: mptcp: run mptcp_inq from a clean netns
>  selftests: mptcp: removed defined but unused vars
>  selftests: mptcp: uniform 'rndh' variable
>
> tools/testing/selftests/net/mptcp/diag.sh       |  1 +
> .../selftests/net/mptcp/mptcp_connect.sh        |  6 +-----
> tools/testing/selftests/net/mptcp/mptcp_join.sh |  5 +++--
> .../selftests/net/mptcp/mptcp_sockopt.sh        | 17 ++++++++---------
> .../testing/selftests/net/mptcp/simult_flows.sh |  4 +---
> .../testing/selftests/net/mptcp/userspace_pm.sh |  2 +-
> 6 files changed, 15 insertions(+), 20 deletions(-)
>
>
> base-commit: 1907372cfe4315a0491ae262ac23b1b4cd9cdf94
> -- 
> 2.37.2
>
>
>

--
Mat Martineau
Intel
