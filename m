Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465A2184E
	for <mptcp@lists.linux.dev>; Tue, 19 Apr 2022 23:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650410531; x=1681946531;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=J30uoEoKxh00P841H62wviF6McbOcLEavCSnqK1G70U=;
  b=bRARWxEyA5S9Leow8rQkQgsMUoMkakfnx06cyFLoC/fXu63IoxeAtQLF
   BOndd/Ac5IkMBbK1Z9PeFwZDfCEgqHQmlKCOaz9BVz55cedlxFW6hxK3R
   wCbmrzxzoNy1tbZ7fqJb0fUQftKsv5Gs72oXOc3Nac84KNu4e8codMwUV
   D81Lrrv7wiFXAOLz3OgmsMurK15+/hv/ZSWDv8qJCA7tStCF27WC0QIAx
   BQ6yo13e3R/TPzBKFutz735goDJRC+U4rQAvY86iRTGFlHzYVn0LVNTtL
   cH8ZCc4jrty9XmoqYE1wb+yH2ZykT83YEa4tcU0wQb6c/0ib/BfQzZuYg
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="324337701"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="324337701"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 16:22:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="702361976"
Received: from aupasani-mobl.amr.corp.intel.com ([10.209.21.110])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 16:22:10 -0700
Date: Tue, 19 Apr 2022 16:22:09 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Kishen Maloor <kishen.maloor@intel.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/3] mptcp: fix bug in userspace PM APIs
In-Reply-To: <20220419230340.2263545-1-kishen.maloor@intel.com>
Message-ID: <5d81340-d390-3b99-c34c-02a9ef122ad@linux.intel.com>
References: <20220419230340.2263545-1-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 19 Apr 2022, Kishen Maloor wrote:

> This series fixes issue #267:
> https://github.com/multipath-tcp/mptcp_net-next/issues/267
>
> Specifically, calls to mptcp_token_get_sock() from userspace PM APIs
> hold a reference to the msk which needs to be freed before leaving those
> functions. This was causing a memory leak which was caught in
> the CI debug build.
>
> Kishen Maloor (3):
>  Squash-to: mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE
>  Squash-to: mptcp: netlink: Add MPTCP_PM_CMD_REMOVE
>  Squash-to: mptcp: netlink: allow userspace-driven subflow
>    establishment
>
> net/mptcp/pm_userspace.c | 93 +++++++++++++++++++++++-----------------
> 1 file changed, 53 insertions(+), 40 deletions(-)
>
>
> base-commit: e561667a821b0ecccba582520829f38da50567a3
> --
> 2.31.1
>
>

Thanks Kishen - patches are ready to squash unless the CI surprises us.

Matthieu, I did run these in a virtme environment to confirm the leaks 
were fixed. The only remaining leak I saw was the upstream one (in 
msr_build_context()).

--
Mat Martineau
Intel
