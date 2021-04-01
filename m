Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16AF70
	for <mptcp@lists.linux.dev>; Thu,  1 Apr 2021 19:41:13 +0000 (UTC)
IronPort-SDR: 2vmS8/XeciEroTofcHYTQvi19/zYLdks5pNwmVKlEJxTm1FkB9NM6dlTfQCjIucY+BgARGFBk0
 z1ac1culgVSA==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="191798777"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="191798777"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 12:41:13 -0700
IronPort-SDR: Bo0ikWOsGrvVdiPkUeHU8bpG83V28+DG+2wPCYQ6dZv5nhUtM9eWM2ngvf0YDEnXLemflGbORE
 0JCer0ulJ4/Q==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="419338437"
Received: from jmurunue-mobl2.amr.corp.intel.com ([10.251.11.73])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 12:41:12 -0700
Date: Thu, 1 Apr 2021 12:41:10 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
    "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net 2/2] mptcp: revert "mptcp: provide subflow aware
 release function"
In-Reply-To: <ad4571485ca31026738cf57d67d68d681997a012.1617295578.git.pabeni@redhat.com>
Message-ID: <e5ceaf-ce5c-6979-fb7-9283a1fa266c@linux.intel.com>
References: <cover.1617295578.git.pabeni@redhat.com> <ad4571485ca31026738cf57d67d68d681997a012.1617295578.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 1 Apr 2021, Paolo Abeni wrote:

> This change reverts commit ad98dd37051e ("mptcp: provide subflow aware
> release function"). The latter introduced a deadlock spotted by
> syzkaller and is not needed anymore after the previous commit.
>
> Fixes: ad98dd37051e ("mptcp: provide subflow aware release function")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 55 ++------------------------------------------
> 1 file changed, 2 insertions(+), 53 deletions(-)
>

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
