Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290A872
	for <mptcp@lists.linux.dev>; Fri, 14 May 2021 19:05:19 +0000 (UTC)
IronPort-SDR: zyVfeCJ3l4u8tDV94xUiigVkuglUMSVR+dHgHhnmrhGn0yauGCdeMAOJySc1UR1xOQPHzsSnJR
 1k+dZ61ggmsQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="264147398"
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="264147398"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 12:05:18 -0700
IronPort-SDR: YKVhzo/gTCYuIBsA08gmzHciYynITKluBDjflGqmW+SLIDvXtBm55RSRWQYXxwZ20aCXbPBVEi
 eInYrbX01XxA==
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="431826538"
Received: from akshtadu-mobl.amr.corp.intel.com ([10.251.18.116])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 12:05:18 -0700
Date: Fri, 14 May 2021 12:05:17 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v3 mptcp-next 1/7] sock: expose so_timestamp options for
 mptcp
In-Reply-To: <20210514094857.10663-2-fw@strlen.de>
Message-ID: <3ae5516c-f76-8099-17fa-d84a9a17411e@linux.intel.com>
References: <20210514094857.10663-1-fw@strlen.de> <20210514094857.10663-2-fw@strlen.de>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 14 May 2021, Florian Westphal wrote:

> This exports SO_TIMESTAMP_* function for re-use by MPTCP.
>
> Without this there is too much copy & paste needed to support
> this from mptcp setsockopt path.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
> include/net/sock.h |  1 +
> net/core/sock.c    | 26 +++++++++++++++++++-------
> 2 files changed, 20 insertions(+), 7 deletions(-)
>

Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
