Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39413FE2
	for <mptcp@lists.linux.dev>; Thu,  9 Sep 2021 22:33:03 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10102"; a="208037302"
X-IronPort-AV: E=Sophos;i="5.85,281,1624345200"; 
   d="scan'208";a="208037302"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 15:33:03 -0700
X-IronPort-AV: E=Sophos;i="5.85,281,1624345200"; 
   d="scan'208";a="470280978"
Received: from jabusaid-mobl.amr.corp.intel.com ([10.255.231.212])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 15:33:03 -0700
Date: Thu, 9 Sep 2021 15:33:02 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Sasha Levin <sashal@kernel.org>
cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
    Yonglong Li <liyonglong@chinatelecom.cn>, 
    Geliang Tang <geliangtang@gmail.com>, 
    "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
    mptcp@lists.linux.dev
Subject: Re: [PATCH AUTOSEL 5.14 209/252] mptcp: fix ADD_ADDR and RM_ADDR
 maybe flush addr_signal each other
In-Reply-To: <20210909114106.141462-209-sashal@kernel.org>
Message-ID: <3a6c39db-8aca-b64b-51db-cd1544daf9dc@linux.intel.com>
References: <20210909114106.141462-1-sashal@kernel.org> <20210909114106.141462-209-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


On Thu, 9 Sep 2021, Sasha Levin wrote:

> From: Yonglong Li <liyonglong@chinatelecom.cn>
>
> [ Upstream commit 119c022096f5805680c79dfa74e15044c289856d ]
>
> ADD_ADDR shares pm.addr_signal with RM_ADDR, so after RM_ADDR/ADD_ADDR
> has done, we should not clean ADD_ADDR/RM_ADDR's addr_signal.
>
> Co-developed-by: Geliang Tang <geliangtang@gmail.com>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
> net/mptcp/pm.c | 13 ++++++++++---
> 1 file changed, 10 insertions(+), 3 deletions(-)

Hi Sasha,

This patch is part of a 5-patch series, and was not intended for 
backporting. Please drop the patch from all stable branches.


Thanks!

--
Mat Martineau
Intel
