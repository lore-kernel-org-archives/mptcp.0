Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4058173
	for <mptcp@lists.linux.dev>; Wed,  5 Jan 2022 01:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641346882; x=1672882882;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mXLiqhLM1DGLnQVtKCbBclLToYkqVxLAGaGAIraswKQ=;
  b=njZDmOKADJwfTruYFW7YzPrSkqZabNO2XO7lb7d0U+nqsppPuQ9JVZyf
   /mZ35OsTkbx3E5aGA6mYQgMX4FIcbs8fJaggx/q7AtQmgGNwtcRCsjOdx
   radfTIzYfA/foc23Hgg9HOfYI8lhe4N0behzpOvfqysTJsB9e/8XfzFmH
   jX4d+J/saYbjfWaUnBRsdKtX6Q3y73YpA56fcx2JxYT5LbO1sPbn1R4h0
   xH3UH8cnQaKOaQJgVGIWXg7Nr3v0zjNadJQE+CldNExnEch5Imdy5JhKg
   DYSRBZA2xktyNt5+hZ6LrYu6jfjyMChfHozv9jp/tN9YVQNuq8cw9V7hF
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242303876"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="242303876"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 17:41:22 -0800
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="470361656"
Received: from marcquat-mobl.amr.corp.intel.com ([10.212.247.3])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 17:41:22 -0800
Date: Tue, 4 Jan 2022 17:41:21 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/4] use 'ip mptcp' in selftests
In-Reply-To: <cover.1641290905.git.geliang.tang@suse.com>
Message-ID: <e0bd41a6-9147-e9c-5bc9-c541282127d7@linux.intel.com>
References: <cover.1641290905.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 4 Jan 2022, Geliang Tang wrote:

> This patchset replaced all the pm_nl_ctl commands in selftests with the
> 'ip mptcp' commands.
>
> Geliang Tang (4):
>  selftests: mptcp: use 'ip mptcp' in mptcp_join.sh
>  selftests: mptcp: use 'ip mptcp' in mptcp_sockopt.sh
>  selftests: mptcp: use 'ip mptcp' in pm_netlink.sh
>  selftests: mptcp: use 'ip mptcp' in simult_flows.sh
>
> .../testing/selftests/net/mptcp/mptcp_join.sh | 686 +++++++++---------
> .../selftests/net/mptcp/mptcp_sockopt.sh      |  12 +-
> .../testing/selftests/net/mptcp/pm_netlink.sh | 164 ++---
> .../selftests/net/mptcp/simult_flows.sh       |   6 +-
> 4 files changed, 432 insertions(+), 436 deletions(-)
>
> -- 
> 2.31.1

Hi Geliang -

I think we had been using pm_nl_ctl to avoid possible problems with 
varying 'ip' command versions on host systems, and to make sure we are 
checking for kernel regressions rather than 'ip' regressions, and to be 
able to check the netlink API in ways that might not make sense for 
the 'ip mptcp' command.

Could you comment on the reasons to move away from pm_nl_ctl?


Thanks,

--
Mat Martineau
Intel
