Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621DF72
	for <mptcp@lists.linux.dev>; Fri, 14 May 2021 19:06:08 +0000 (UTC)
IronPort-SDR: loQFGgObC2lqnNLlwVOIVGJb/eNtxTDhjODLsnFkMS8A8DQEpLgVq06ZzWWSXOZ5pgkFTM6QbE
 t9MJh5NC/t6g==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="179822268"
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="179822268"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 12:06:07 -0700
IronPort-SDR: ViTA5ZHSomsOuqoaKsD5T9DSvfRjo+phictIpnMDLyDyuyvE2oLYHmwkGqTxiazRcaY1o8fGzN
 hdc5WMTczugw==
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="431826700"
Received: from akshtadu-mobl.amr.corp.intel.com ([10.251.18.116])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 12:06:07 -0700
Date: Fri, 14 May 2021 12:06:07 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v3 mptcp-next 3/7] mptcp: sockopt: propagate timestamp
 request to subflows
In-Reply-To: <20210514094857.10663-4-fw@strlen.de>
Message-ID: <aa25a5eb-446b-295d-a5c6-46f5e6a3a9a8@linux.intel.com>
References: <20210514094857.10663-1-fw@strlen.de> <20210514094857.10663-4-fw@strlen.de>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 14 May 2021, Florian Westphal wrote:

> This adds support for TIMESTAMP(NS) setsockopt.
>
> This doesn't make things work yet, because the mptcp receive path
> doesn't convert the skb timestamps to cmsgs for userspace consumption.
>
> receive path cmsg support is added ina followup patch.
>
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
> net/mptcp/sockopt.c | 50 +++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 50 insertions(+)
>

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


--
Mat Martineau
Intel
