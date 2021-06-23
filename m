Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5052FB3
	for <mptcp@lists.linux.dev>; Wed, 23 Jun 2021 00:07:26 +0000 (UTC)
IronPort-SDR: 93K+V2hQqQ1FDiO6wW7BUzcN1OYYlsqqK8dRe3ZqA/douLvugJ+WFWYx5nq+TPswQnbblv6FkD
 Rcn9A8ZdgniA==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="271009614"
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="271009614"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 17:07:25 -0700
IronPort-SDR: GLvdQv4eUM5vbMG/VL5fo2TjTjw1n+98/N/zlQX3wqIYoSRI5blwNCbNaDQzgRQ7IoHA/RpqTS
 x7skNDttJt+Q==
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="487098514"
Received: from mrsastry-mobl1.amr.corp.intel.com ([10.212.137.16])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 17:07:25 -0700
Date: Tue, 22 Jun 2021 17:07:25 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Jianguo Wu <wujianguo106@163.com>
cc: mptcp@lists.linux.dev, pabeni@redhat.com, fw@strlen.de
Subject: Re: [PATCH v5 0/4] Fix some mptcp syncookie process bugs
In-Reply-To: <d3c1f32b-806a-bf19-d6a2-324b80d4c387@163.com>
Message-ID: <58edc7e8-652-c5c8-5ee6-878981c6d7b2@linux.intel.com>
References: <1623840570-42004-1-git-send-email-wujianguo106@163.com> <74d34b28-f071-2825-af55-d39952959e4@linux.intel.com> <d3c1f32b-806a-bf19-d6a2-324b80d4c387@163.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="0-1746725553-1624406647=:21759"
Content-ID: <b36ad3c-579b-f4bc-9db9-84fb9fc8420@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1746725553-1624406647=:21759
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <d25cd3fc-55e2-adc0-c4f8-863cc79cb7f@linux.intel.com>

On Mon, 21 Jun 2021, Jianguo Wu wrote:

> Hi Mat,
>
> On 2021/6/19 8:26, Mat Martineau wrote:
>> On Wed, 16 Jun 2021, wujianguo106@163.com wrote:
>>
>>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>>>
>>> v4->v5:
>>> patch1: no changes
>>> patch2: no changes
>>> patch3: no changes
>>> patch4: add comment
>>
>> Hi Jianguo -
>>
>> One other thing that's helpful for reviewers on the list is to use the patch prefixes listed at https://github.com/multipath-tcp/mptcp_net-next/wiki/Patch-prefixes
>> when emailing patches to mptcp@lists.linux.dev
>>
>
> Thanks for your reminding!
>
>> For example, if these patches are intended for net-next they should be sent with [PATCH mptcp-next] in the subject line, or for the net tree they should have [PATCH mptcp-net]. If you're unsure where the patches belong, please ask!
>>
>
> and this patchset should use [PATCH mptcp-next]?

I think these look like mptcp-net patches, especially considering the risk 
of double-free in patch 2.

For patch 4 I'm not sure if that would be best for net-next. Is it an 
optimization or fixing a crash / error / warning?

-Mat


>
>> Thanks,
>>
>> Mat
>>
>>
>>>
>>> v3->v4:
>>> patch1: using seq and sport/dport for hashing, and ignore network headers altogether,
>>>        as suggest by Florian
>>> patch2: no changes
>>> patch3: no changes
>>> patch4: no changes
>>>
>>> v2->v3:
>>> patch1: directly use inet6_ehashfn() for IPv6
>>> patch2: no changes
>>> patch3: no changes
>>> patch4: add Fixes tag.
>>>
>>> v1->v2:
>>> patch1: handle ipv6 sockets/addresses,
>>>        always use 4-tuple drived hash and never look at skb->hash
>>> patch2: no changes
>>> patch3: split into 2 patches.
>>> patch4: new added.
>>>
>>> Jianguo Wu (4):
>>>  mptcp: fix warning in __skb_flow_dissect() when do syn cookie for
>>>    subflow join
>>>  mptcp: remove redundant req destruct in subflow_check_req()
>>>  mptcp: fix syncookie process if mptcp can not_accept new subflow
>>>  mptcp: avoid processing packet if a subflow reset
>>>
>>> net/mptcp/options.c    |  6 ++++++
>>> net/mptcp/subflow.c    | 11 +++--------
>>> net/mptcp/syncookies.c | 16 +++++++++++++++-
>>> 3 files changed, 24 insertions(+), 9 deletions(-)
>>>
>>> --
??>> 1.8.3.1
>>>
>>>
>>>
>>
>> --
>> Mat Martineau
>> Intel
>
>

--
Mat Martineau
Intel
--0-1746725553-1624406647=:21759--
