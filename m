Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E172C82
	for <mptcp@lists.linux.dev>; Thu, 20 Jan 2022 01:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642640515; x=1674176515;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=68+MpkJpkRi3Wb3SfgAmZGAFd3r1kQVs2pywEYQFONc=;
  b=JMluYs2sY9OD8UgIjWlrSVYveAn1u9pP6pUEVxOCev6FVIV144KsKrmx
   D0VRYFHry11yalu01uIUary+BJn0r9lkcPUy9JAbJaRzm4UwaaijQUnqB
   1kMRaa8nwGAIfG4I6xuQ8ggVVqVLLt5YJ86GPh+gUWZe5y6ENg5Lbus8R
   nNO0tlI6Pmin53KPXKF1yapR8k8xhy4nq+hQ4vpCZ+qKTCGQevg60n+yb
   UlEVXvRUE+d0Hxb8GZXwCE/pMWoWMeqY49AxpRVIs2zif8m18K/VZ07id
   nr3oFE7jyVrka5Lx2KwyDiS2wE3grVhfWhG8bIZ3rEZJMrT0D3FNC8vjv
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="244061895"
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="244061895"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 17:01:54 -0800
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="532556706"
Received: from anikkhan-mobl.amr.corp.intel.com ([10.212.249.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 17:01:53 -0800
Date: Wed, 19 Jan 2022 17:01:53 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 00/10] set flags and selftests
In-Reply-To: <cover.1642320655.git.geliang.tang@suse.com>
Message-ID: <c135c322-e71f-f525-ba83-ea53691e65f@linux.intel.com>
References: <cover.1642320655.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Sun, 16 Jan 2022, Geliang Tang wrote:

> v2:
> - use a mask of changed flags as Mat suggested.
> - squash patch 8 and patch 9 in v1 into one.
>

v2 looks ready for the export branch, thanks Geliang.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> Geliang Tang (10):
>  mptcp: set fullmesh flag in pm_netlink
>  selftests: mptcp: set fullmesh flag in pm_nl_ctl
>  selftests: mptcp: add fullmesh setting tests
>  mptcp: allow to use port and non-signal in set_flags
>  selftests: mptcp: add the port argument for set_flags
>  selftests: mptcp: add backup with port testcase
>  selftests: mptcp: add ip mptcp wrappers
>  selftests: mptcp: add wrapper for showing addrs
>  selftests: mptcp: add wrapper for setting flags
>  selftests: mptcp: set ip_mptcp in command line
>
> net/mptcp/pm_netlink.c                        |  50 +-
> .../testing/selftests/net/mptcp/mptcp_join.sh | 936 +++++++++++-------
> tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  19 +-
> 3 files changed, 616 insertions(+), 389 deletions(-)
>

--
Mat Martineau
Intel
