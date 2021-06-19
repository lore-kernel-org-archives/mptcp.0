Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0AB71
	for <mptcp@lists.linux.dev>; Sat, 19 Jun 2021 00:26:39 +0000 (UTC)
IronPort-SDR: 72+5x8UPX5Nql7nh2eWO8oD42MNQ32VIG0sU+9a9g5bGHrjbtXc244Mm5l6z7X9PGHi79I15mP
 hm9pQLoWwZpg==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="193770591"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="193770591"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 17:26:38 -0700
IronPort-SDR: 8AUbxrWBIfqP9Nm9S2u3+JoCGbi7LJiQz/TmGVjTSMZAfExQ1co1PFzKewZm/PeBqrcPOgvyEw
 roKxM7iDYaRA==
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="485865240"
Received: from rsurapan-mobl2.amr.corp.intel.com ([10.209.105.229])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 17:26:38 -0700
Date: Fri, 18 Jun 2021 17:26:38 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: wujianguo106@163.com
cc: mptcp@lists.linux.dev, pabeni@redhat.com, fw@strlen.de
Subject: Re: [PATCH v5 0/4] Fix some mptcp syncookie process bugs
In-Reply-To: <1623840570-42004-1-git-send-email-wujianguo106@163.com>
Message-ID: <74d34b28-f071-2825-af55-d39952959e4@linux.intel.com>
References: <1623840570-42004-1-git-send-email-wujianguo106@163.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 16 Jun 2021, wujianguo106@163.com wrote:

> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>
> v4->v5:
> patch1: no changes
> patch2: no changes
> patch3: no changes
> patch4: add comment

Hi Jianguo -

One other thing that's helpful for reviewers on the list is to use the 
patch prefixes listed at 
https://github.com/multipath-tcp/mptcp_net-next/wiki/Patch-prefixes
when emailing patches to mptcp@lists.linux.dev

For example, if these patches are intended for net-next they should be 
sent with [PATCH mptcp-next] in the subject line, or for the net tree they 
should have [PATCH mptcp-net]. If you're unsure where the patches belong, 
please ask!

Thanks,

Mat


>
> v3->v4:
> patch1: using seq and sport/dport for hashing, and ignore network headers altogether,
>        as suggest by Florian
> patch2: no changes
> patch3: no changes
> patch4: no changes
>
> v2->v3:
> patch1: directly use inet6_ehashfn() for IPv6
> patch2: no changes
> patch3: no changes
> patch4: add Fixes tag.
>
> v1->v2:
> patch1: handle ipv6 sockets/addresses,
>        always use 4-tuple drived hash and never look at skb->hash
> patch2: no changes
> patch3: split into 2 patches.
> patch4: new added.
>
> Jianguo Wu (4):
>  mptcp: fix warning in __skb_flow_dissect() when do syn cookie for
>    subflow join
>  mptcp: remove redundant req destruct in subflow_check_req()
>  mptcp: fix syncookie process if mptcp can not_accept new subflow
>  mptcp: avoid processing packet if a subflow reset
>
> net/mptcp/options.c    |  6 ++++++
> net/mptcp/subflow.c    | 11 +++--------
> net/mptcp/syncookies.c | 16 +++++++++++++++-
> 3 files changed, 24 insertions(+), 9 deletions(-)
>
> -- 
> 1.8.3.1
>
>
>

--
Mat Martineau
Intel
