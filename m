Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2BA4C84
	for <mptcp@lists.linux.dev>; Fri, 17 Jun 2022 22:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655503889; x=1687039889;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=v4DDu+bitg/F1FCCSr7g5ld+JIVSkrdezAyVwtKz/IM=;
  b=lP2cWioYBeKo9kgleQhr8dlvc0kUqULo3v675vjfyockKajlcxH2am9o
   RToqbzYYx0nQyc9uqKtVbYXxIhUB1BSSrYvwt5DwrUrCALOyr0YLZbOmo
   UcCRnVZbYSQCy3Up4/zJWHAiUVWTsCulMKzDAI9JEt74CHmHHlRgmOLvS
   Ko2FR6LT11BzshX//7U0pkMClR4ybb1UReEHUt0frfHDdWMgKxeaM+uJb
   zc67kGtOS2nek6Z26JNY+PMq1UUNeMrU6qwZ/pSA9fM0FSaFOK+aZ6Ghy
   ZvO5KBG9j5ISHA8xXXlh8FjllTa4fZG2o7rvLDUKYXac4Fh9q8SQsCSLZ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="262636742"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="262636742"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 15:11:29 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="536970694"
Received: from theiders-mobl.amr.corp.intel.com ([10.209.81.3])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 15:11:29 -0700
Date: Fri, 17 Jun 2022 15:11:29 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 0/5] mptcp_join userspace pm tests
In-Reply-To: <cover.1655355422.git.geliang.tang@suse.com>
Message-ID: <f5913d71-d469-c4c7-7520-c69a3e641b5b@linux.intel.com>
References: <cover.1655355422.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 16 Jun 2022, Geliang Tang wrote:

> This patch set adds add address, remove address, create subflow, and
> destroy subflow test cases for userspace pm in mptcp_join script.
>
> v3:
> - use MPTCP_INC_STATS instead of __MPTCP_INC_STATS.
> - drop unneeded pm_nl_set_limits.

Thanks Geliang.

Series looks good, with a squash-to request (see patch 3 comment):

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

>
> v2:
> - add more tests in mptcp_join.sh
> - patch 4, add kill_wait helper as Matt suggested.
>
> Geliang Tang (5):
>  mptcp: update MIB_RMSUBFLOW in cmd_sf_destroy
>  selftests: mptcp: userspace pm address tests
>  selftests: mptcp: userspace pm subflow tests
>  selftests: mptcp: avoid Terminated messages in userspace_pm
>  selftests: mptcp: update pm_nl_ctl usage header
>
> net/mptcp/pm_userspace.c                      |  2 +
> .../testing/selftests/net/mptcp/mptcp_join.sh | 82 ++++++++++++++++++-
> tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  2 +-
> .../selftests/net/mptcp/userspace_pm.sh       | 40 +++++----
> 4 files changed, 106 insertions(+), 20 deletions(-)
>
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
