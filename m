Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D07B538F
	for <mptcp@lists.linux.dev>; Wed,  6 Jul 2022 17:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657127891; x=1688663891;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Gpv/+bt/h/Ko3VWokp+9SWjW142I6+Q/APUbbsZkV2I=;
  b=lyp98omybzW7S70Ox6eABvLpgQs+u0Z33Egi7bwXMMAZajm4Ntbgpy9/
   tOcGe9v/Qk/jmYAbR+ehAIDDymU2r4579exCmZ8cXvz3fLldR5Mw0HnCM
   DlG0bQTC/i7oPNoMYNMlzpmA3pbvU4iNqROYle32mtQXnDtka4Lg0gc/U
   NMj2+Y1eVF6YUvgNNo1XPaioCgExWhkCckBi4iITQGDI+udV7NzNl813M
   twzapCf8Vi/p3USTJweh2NTL+JGoyJmJURjJTtWwrLm8BICMSX/PB5hEQ
   EanBKMyX3vH0ixIGTXA+y5//lm+hFVJg87kGt9xZ0CX0tz3wREEhdEcfu
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="284555885"
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="284555885"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 10:18:11 -0700
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="543485819"
Received: from lerosale-mobl.amr.corp.intel.com ([10.209.34.41])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 10:18:10 -0700
Date: Wed, 6 Jul 2022 10:18:10 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] selftests: mptcp: validate userspace PM tests
 by default
In-Reply-To: <20220706091706.2679400-1-matthieu.baerts@tessares.net>
Message-ID: <87fe9b3b-99c8-7529-27a6-89f0e5f1f7ef@linux.intel.com>
References: <20220706091706.2679400-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 6 Jul 2022, Matthieu Baerts wrote:

> The new script was not listed in the programs to test.
>
> By concequence, some CIs running MPTCP selftests were not validating
> these new tests. Note that MPTCP CI was validating it as it executes all
> .sh scripts from 'tools/testing/selftests/net/mptcp' directory.
>
> Fixes: 259a834fadda ("selftests: mptcp: functional tests for the userspace PM type")
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> tools/testing/selftests/net/mptcp/Makefile | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
> index f905d5358e68..48a99e1453e1 100644
> --- a/tools/testing/selftests/net/mptcp/Makefile
> +++ b/tools/testing/selftests/net/mptcp/Makefile
> @@ -6,7 +6,7 @@ KSFT_KHDR_INSTALL := 1
> CFLAGS =  -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
>
> TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
> -	      simult_flows.sh mptcp_sockopt.sh
> +	      simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
>
> TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq
>
> -- 
> 2.36.1

Thanks for quickly acting on Jakub's note. Might end up sending this for 
-net too. I don't think it should conflict so where you put it in the 
export branch probably doesn't matter too much.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
