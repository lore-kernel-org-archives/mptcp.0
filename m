Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF42EBD
	for <mptcp@lists.linux.dev>; Wed, 23 Feb 2022 18:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645639650; x=1677175650;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=OYYhdxNkpgjnZL3tdJVI7+MNF/xRkQ2tAb3JtIqlo/0=;
  b=mZf+Xk14TGNRDlfoThVhbESR55Ts6kjuPjGHLZs2G5ncuiSp+XjFQdYV
   g1qSl/2a4TJfBezb7qgRufQyYq1B4SjFoyuEppETJTkg+4nukrshR2M1i
   uXHvF0R0cZPjE3VVxcXgJNSYHmbglaECGLPcKZWFdERpv5k5DIPTKfVej
   NdivQmbRn7n2TD/ECyRZTNPzIFN7ZHDLRaK+YskhPN3oxQ+Xzy5fh8Jyr
   51CvIR3jyKZei5pdJyI4bhzBv/tXMRXt3UHlKj3wIqeuppIOlgIMivJ3G
   jWfddJ8UqfRzaMcat31zMpwxpbT0kRhD1o2nv3Uo9Y68fDaDVf0bD4jou
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="251781596"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="251781596"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 10:07:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="548376257"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 23 Feb 2022 10:07:29 -0800
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Feb 2022 10:07:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 23 Feb 2022 10:07:29 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 23 Feb 2022 10:07:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nmu/t2jwDUzlPmqB920y7ma/QwFxO9a0rRCO9GE0f1xJ/vWjYiXU8eyT9QZNBUYjSom2uucAPB8OET2EIbvNH823wCmKYxN46QeLutxhe0QkcG+nyQ9q0OpHThs6ov7WT1YhYt5QUDOQO5EYvKlOFtPZcZcO/y14BlxQfVvkSogMlMUFM9aSz7dwv69Ni5F7hl+tl2P20ceUMFa3QiB5+xM2+FYbBpmbPImv252GQl7S0b3DaT6Q78TH3kfTU1F4h/WorH9PBOhY7sh9p9f14FsR8s9jqvZ3vXh+2yucPeRNFGYKF02xf4KJSZG1sLg69Kmpktsh29c+dJsHP2nAig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gPE7l7mAhkEc0y/Es98eB4IzzBSvmNTrpOeBMyCmQw=;
 b=ofyWWSdDv4gURaWGb6WBXpgd9wCdECf/l132jTfGRATHX4RRsg8aekqmC+nHi+zPTmZ7QeivAkkQ+/il1aA+s9B83gdj5tVPH/FkjTFkut7IfCiin0rlTmfjjO07Dvn7mPtTa8Tf9Sfvz9QDSJ63GYaXcTML4IlGJ1sUPiz8763h/zTkJGbF5/tpmSAIX1bDkoY6+07UnAToGMT9enIkWydX8POYLW2O5UwFJ6pnVqurFYOLLcskIBp4QqzK+FPv8H+B5GG4m3MWNR6KnmPM5bdN5UpoCQvuCdjzyk3pPr3eVJVQ+1KIIX9WjXbIYij5PFAQR1wVh/KMsH2bop/4Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
 by BYAPR11MB3688.namprd11.prod.outlook.com (2603:10b6:a03:f8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Wed, 23 Feb
 2022 18:07:26 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::44ba:c91c:ea6c:118d]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::44ba:c91c:ea6c:118d%4]) with mapi id 15.20.5017.023; Wed, 23 Feb 2022
 18:07:26 +0000
Message-ID: <66c825e6-a960-b5fc-014d-fb2075093255@intel.com>
Date: Wed, 23 Feb 2022 10:07:24 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next v2 4/5] mptcp: handle join requests via pernet
 listen socket
Content-Language: en-US
To: Florian Westphal <fw@strlen.de>, <mptcp@lists.linux.dev>
References: <20220217142538.7849-1-fw@strlen.de>
 <20220217142538.7849-5-fw@strlen.de>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <20220217142538.7849-5-fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR10CA0062.namprd10.prod.outlook.com
 (2603:10b6:300:2c::24) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:9e::21)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e2fa7a5-d87d-4d23-399a-08d9f6f75935
X-MS-TrafficTypeDiagnostic: BYAPR11MB3688:EE_
X-Microsoft-Antispam-PRVS: <BYAPR11MB3688AFEAB6E2F153C18CAF16E13C9@BYAPR11MB3688.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: du5OQyNYNXWBnWP2eE3YNzi9j3alrKyUnwNfs1FHpwdiFKAJc6nnhIC8YPU0skIHd3MAMP2kCT2Stthp4iGhH/dEXHkOpiI8LJ4e99f/+E7e5ehJUpIw8RefbjuZuj/OHWEK+7I35sDBLV7+UrFibnFPazQ/fhg3j4LATsjX7/ydhAUe6mHd39oUxxmH9V5JmnIbNr1QLwbTanJixG2RoSyy8vbA7myr4aqI58Pa4seMx4XeUU1Sqcj9pJpCHD7BSgnzzScp18q7CFqeuWpz3CueWVHdzm48wpV3SfKdtr0uPeI5VUMui+fpLEh1SJ/1kDTPijs9g+Us0v2JCeGDRjf/n4qOcOmZU9/r9dPbKeCOTFWl4K3O7OuscZ0Sl7nDMFUj97JA/Z8Z7Hk4nFOfXGexOvNKLOquxLKc9Sq0etasFpRmt1nyd7ujkrpu2RfU9sXzLX6eNxFd2ZbdNcvakJBuQyaGFRBVM/O8W9nZnOhjsVXQyVV9MK5Xe9b5bcbftDTD1xOd3m3/XQzZ3bY8wmfBnsxaSiLlOP5z8Wlh8oTBUe6jCzfidDBZME7HNQbZTkZN8v7TXy4dfoae4blX9BPc3KMxVuboTQfuXq+mXoyvshBR3HDULwxleMX3U/nczhcvwzPdTAoJb8ccucBSZgu4b4t/il7yxFhNDkizS9GiUAug+PdJ+fhErayYZ1cJ3kSSwqmMT/TiSL5/NggTiegC3RmpYdxbFM5GSdusass=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66476007)(66556008)(36756003)(82960400001)(316002)(6486002)(8676002)(38100700002)(508600001)(2906002)(6506007)(2616005)(53546011)(31686004)(6512007)(86362001)(83380400001)(31696002)(30864003)(8936002)(5660300002)(26005)(186003)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFF2L25MS0E1eVhXT09qRjdnZDhZdGRENyt4Q09Fck1ORXIzWGUvR1RYdWZ0?=
 =?utf-8?B?NC9CMFdCL0lNRkpDUGVjSDhrTm95aS9OdlZablFvUHV2NE1WcWhYYXMxd3lI?=
 =?utf-8?B?SllTRXo2blpxSHJzZHg5cVZ1OEErUWRRQ2F0Y2c2ME4yQUZIL3JJS2F2Z2s4?=
 =?utf-8?B?M2ZDZ1JyZXdLN3M2Ykd5dkNiaEZwaDVIdE00dlJ6UE5xeWRPTWFnOE1ac3Bv?=
 =?utf-8?B?bFowOE55WmpndG9YZGlLdFJwSGFLeXdRRjYyRm1Hbjd1Q0tscnRkRmYzWUJR?=
 =?utf-8?B?ckkrRHl2WGl3UE9ndFUvN1ZMRHF4ajhhWjRhSXZZRHlmQWZNTndjcnhCcTNX?=
 =?utf-8?B?NEhHcGlsK1MzTk1qR0hDRW8rcm8wZFJ6Z0FRZzQvSnVpTHh1ME53UFVOVWNN?=
 =?utf-8?B?a1RnOGkwdlBqQkhMbW12L3J0SVpSWmFiV3M4Q1A3M2lRTmY5ZzJpTVRjOVJE?=
 =?utf-8?B?UytMVjJ4bTY2SUhSUENTQzBQV2JqVVd4aEg5Qy9KWmgyUVlxTlRYSW0wbUg5?=
 =?utf-8?B?UXdJNlByYy9mdHpHZWwvZElIOWtZekJnb2tLSVZPK1cvZmZ5ZlYvbEgwZDJh?=
 =?utf-8?B?MFU3cVppMk1HRzB3WFFVTmgzNWczWFlzcGIxTVZXNjB3TG5VMEQ4cnNFWE0r?=
 =?utf-8?B?QWZYaUJRNnNkcEZrVEYyeGRadWNNOVl2M1JLQ2dza1czcG1Wclh6MTZaRGtD?=
 =?utf-8?B?ZjF1cUdJSk41NU9HeDBEYWwyTGg0d3BocWt6NE9iOXpkS0s0MmF2aUQyOVZl?=
 =?utf-8?B?OHh3RElURTBnT1pOZG5FSHI4dHRFdGhuUS9zZ3NXTmVHYWwyZGdSa1d2OC9l?=
 =?utf-8?B?T0s5OW4zQ2NveGJpVEQ1WEwweTFtNFFMV2ZELzhTR3pzeFl0SGpnMlA3MGZz?=
 =?utf-8?B?eE04UGF4c0ltYjJtWFJnWXV4YjFJYWVFSnk3M2ZxTnFaVUt5aWRrcmU3a0xt?=
 =?utf-8?B?UGVVZ3BsV3Y0a1VYSVBzdFpWVDRMUGhMSkNncVY1OTdEVTQreWg1Qjk2dThD?=
 =?utf-8?B?UnFXQytYMUREUXBJNEdDc2pxaWZrSGpqSnc5SmNXb2N3QzhlWDF6Nk5jNXJO?=
 =?utf-8?B?MVpEZ0k3ZEg4NUJYQjlzNU9uNGZUV0F0NlRWUU5lWlNSTkZiOFlwS0ZiNjUw?=
 =?utf-8?B?MnNJdVFRbjgvVGFtQkhPTHpLcCszOFJxOTRQV2cwbURnN3dLeExMUUpYdm9i?=
 =?utf-8?B?N2laWlJaa1JtQTUycURrb254c1YvT0ZXWXVkZDZjb1VMZzRsSHhlbHluZkNW?=
 =?utf-8?B?eEp3ODB4QVJjWFhHVmxhdm1oQlZqZUtheSt2cStacEVLYyttdDVML1hUcTV4?=
 =?utf-8?B?elF3dm05ZGs1SVU1RzgyWGV5UlNNZHlibldNekxGS0N2T291VmJyclJlalQ1?=
 =?utf-8?B?VlROWXA1bUZ3OFcrUnEzN0JuSmR2SDNlWmcyZTdKL0FsZ3BoQXpSeTJ2VnIw?=
 =?utf-8?B?QmdZMU9xTzV4U0krSFo0TWlncFMrZmk3WTltSE84d0RoL2Z0S0Z3OExMTUZZ?=
 =?utf-8?B?L0NvM2k0UnFpTTlTeGZkM29Renh4OEQ2UUFNb3R2WXIxVXc3by8ybHI4WDU3?=
 =?utf-8?B?cGFGUmtNRk5nTGFPQTMrWnZrNnh4cksrZDFsU2FJeVN6VXV2YWFEUk8rU0p6?=
 =?utf-8?B?QzlwOFhEUVF5MUVQRDZjTzBKUDB6ZmlVR284cGtsa2ZHWU91SFMwL0xaNzlq?=
 =?utf-8?B?bm5nMU5DM0NPazY2NDBIUFZHU1c0OGoydXN2Z1lzNkE3aWg5bjdoeitxZ0lk?=
 =?utf-8?B?NTN4amdkZEtuWnVQN2U5OTl0aWFncmYrK04weVM3VXptTnNBZ0c2QXN5ME96?=
 =?utf-8?B?Q3FmTGZLY3F4OGYzbWRRTW5EbzdFUGpEUU9ldUp3bnlkWHhYSkxYMGFqZE1B?=
 =?utf-8?B?bjBud2dwa1owZzVFeHZrN0ZwbHR4ZUpXMjZDWFFWWDY1b3FuNlgyYnVCZDJC?=
 =?utf-8?B?MnAxMHg5VXN3TWdzOXk2VU4yeWhPa1pIK3ViT0lmOFdVN3NvM1IyY0svbnhs?=
 =?utf-8?B?ODNJUUl5MXExK0VZd1RMM3VyMjlud0V0MWZnN2hKUG1MNi8rNFRxUWtUcmhK?=
 =?utf-8?B?S0tjZEx2UjErRXpCeHdlcFAzWE8zc3NvdXhKWkZvODUvazh3d1hFdGt3bWZ6?=
 =?utf-8?B?WVVqdUNtYUxyMG5MTWZJZXprOUwyQkprRllqVXk3dGJ1RFVhMS9OYzZxcTNH?=
 =?utf-8?Q?iPyzdz6uHQDnJJpoF23i8ro=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2fa7a5-d87d-4d23-399a-08d9f6f75935
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 18:07:26.5370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FblZRNih1L1xmrtzVieftdaZooQGcy4pouY56lDPuOdzbty0DMo4a2OZiTe3j2QFFkQnBNao4pUpsZmsAwbSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3688
X-OriginatorOrg: intel.com

On 2/17/22 6:25 AM, Florian Westphal wrote:
> Currently mptcp adds kernel-based listener socket for all
> netlink-configured mptcp address endpoints.
> 
> This has caveats because kernel may interfere with unrelated programs
> that use same address/port pairs.
> 

I assume that this refers to the potential race between a kernel listener and
the application which Paolo had raised. I'm not sure if this change eliminates that 
possibility. Pasting Paolo's example below from the prior discussion:

"""
s1 = socket()
bind(s1, A)
listen(s1)
// at this point incoming MPTCP connection can be established on s1
// and ADD_ADDR sub-options could be sent back

s2 = socket()
bind(s2, B)
listen(s2)
"""

Over a new MPTCP connection following listen(s1), the PM can issue an ADD_ADDR with B. In light
of this change there would be no listener created for B. But if the remote endpoint immediately
established a subflow in response, then that would result in a subflow (connection) socket at B. 
It appears (and correct me if I'm wrong) that bind(s2, B) might fail at this point (?).
In other words, it seems like the subflow creation could race with a subsequent bind()
causing startup issues in the application.

If my assessment is correct, then I think this change isn't sidestepping the issue  
that motivated it in the first place. However, I do like the fact that we don't need
code to manage kernel listeners, just so long as there are no other breaking corner cases
and the TCP level changes are acceptable upstream.

> RFC 8684 says:
>  Demultiplexing subflow SYNs MUST be done using the token; this is
>  unlike traditional TCP, where the destination port is used for
>  demultiplexing SYN packets.  Once a subflow is set up, demultiplexing
>  packets is done using the 5-tuple, as in traditional TCP.
> 
> This patch deviates from this in that it retrains the existing checks of
> verifying the incoming requests destination vs. the list of announced
> addresses.
> 
> This can be relaxed later if deemed appropriate.
> 
> Furthermore, TCP-only listeners take precedence: An MPTCP peer
> MUST NOT announce address:port pairs that are already in use by a
> non-mptcp listener.
> This could be changed, but it requires move of mptcp_handle_join()
> hook *before* the tcp port demux, i.e. an additional conditional in
> hotpath.  As-is, the additional conditional (syn && !rst && ...) is
> in the 'no socket found' path.
> 
> The pernet 'listening' socket is hidden from userspace.
> It is not part of any hashes and not bound to any address or port.
> 
> TPROXY-like semantics apply: If tcp demux cannot find a port for a given
> packet, check if the packet is a syn packet with a valid join token.
> 
> If so, the pernet listener is returned and tcp processing resumes.
> Otherwise, handling is intentical.
> 
> This patch does not cover timewait sockets.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  include/net/mptcp.h  |  10 ++
>  net/ipv6/tcp_ipv6.c  |  19 ++--
>  net/mptcp/ctrl.c     | 211 ++++++++++++++++++++++++++++++++++++++++++-
>  net/mptcp/protocol.c |   2 +-
>  net/mptcp/protocol.h |   2 +-
>  net/mptcp/subflow.c  |   3 +
>  6 files changed, 233 insertions(+), 14 deletions(-)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 5ee422b56902..49c188b978e1 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -189,6 +189,7 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
>  				  struct sk_buff *skb);
>  
>  __be32 mptcp_get_reset_option(const struct sk_buff *skb);
> +struct sock *__mptcp_handle_join(int af, struct sk_buff *skb);
>  
>  static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
>  {
> @@ -199,6 +200,11 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
>  }
>  static inline struct sock *mptcp_handle_join(int af, struct sk_buff *skb)
>  {
> +	const struct tcphdr *th = tcp_hdr(skb);
> +
> +	if (th->syn && !th->ack && !th->rst && !th->fin)
> +		return __mptcp_handle_join(af, skb);
> +
>  	return NULL;
>  }
>  #else
> @@ -283,9 +289,13 @@ static inline struct sock *mptcp_handle_join(int af, struct sk_buff *skb) { retu
>  
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>  int mptcpv6_init(void);
> +int mptcpv6_init_net(struct net *net);
> +void mptcpv6_exit_net(struct net *net);
>  void mptcpv6_handle_mapped(struct sock *sk, bool mapped);
>  #elif IS_ENABLED(CONFIG_IPV6)
>  static inline int mptcpv6_init(void) { return 0; }
> +static inline int mptcpv6_init_net(struct net *net) { return 0; }
> +static inline void mptcpv6_exit_net(struct net *net) { }
>  static inline void mptcpv6_handle_mapped(struct sock *sk, bool mapped) { }
>  #endif
>  
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 788040db8e9e..3b8608d35dcd 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -2233,13 +2233,22 @@ static struct inet_protosw tcpv6_protosw = {
>  
>  static int __net_init tcpv6_net_init(struct net *net)
>  {
> -	return inet_ctl_sock_create(&net->ipv6.tcp_sk, PF_INET6,
> -				    SOCK_RAW, IPPROTO_TCP, net);
> +	int err = inet_ctl_sock_create(&net->ipv6.tcp_sk, PF_INET6,
> +				       SOCK_RAW, IPPROTO_TCP, net);
> +	if (err)
> +		return err;
> +
> +	err = mptcpv6_init_net(net);
> +	if (err)
> +		inet_ctl_sock_destroy(net->ipv6.tcp_sk);
> +
> +	return err;
>  }
>  
>  static void __net_exit tcpv6_net_exit(struct net *net)
>  {
>  	inet_ctl_sock_destroy(net->ipv6.tcp_sk);
> +	mptcpv6_exit_net(net);
>  }
>  
>  static struct pernet_operations tcpv6_net_ops = {
> @@ -2264,15 +2273,9 @@ int __init tcpv6_init(void)
>  	if (ret)
>  		goto out_tcpv6_protosw;
>  
> -	ret = mptcpv6_init();
> -	if (ret)
> -		goto out_tcpv6_pernet_subsys;
> -
>  out:
>  	return ret;
>  
> -out_tcpv6_pernet_subsys:
> -	unregister_pernet_subsys(&tcpv6_net_ops);
>  out_tcpv6_protosw:
>  	inet6_unregister_protosw(&tcpv6_protosw);
>  out_tcpv6_protocol:
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index ae20b7d92e28..6358c803ba12 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -21,6 +21,12 @@ static int mptcp_pernet_id;
>  static int mptcp_pm_type_max = __MPTCP_PM_TYPE_MAX;
>  #endif
>  
> +struct mptcp_join_sk {
> +	struct sock *sk;
> +	struct inet_bind_bucket *tb;
> +	struct inet_bind_hashbucket head;
> +};
> +
>  struct mptcp_pernet {
>  #ifdef CONFIG_SYSCTL
>  	struct ctl_table_header *ctl_table_hdr;
> @@ -32,6 +38,18 @@ struct mptcp_pernet {
>  	u8 checksum_enabled;
>  	u8 allow_join_initial_addr_port;
>  	u8 pm_type;
> +
> +	/* pernet listener to handle mptcp join requests
> +	 * based on the mptcp token.
> +	 *
> +	 * Has to be pernet because tcp uses
> +	 * sock_net(sk_listener) to obtain the net namespace for
> +	 * the syn/ack route lookup.
> +	 */
> +	struct mptcp_join_sk join4;
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	struct mptcp_join_sk join6;
> +#endif
>  };
>  
>  static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
> @@ -185,13 +203,173 @@ static void mptcp_pernet_del_table(struct mptcp_pernet *pernet) {}
>  
>  #endif /* CONFIG_SYSCTL */
>  
> +struct sock *__mptcp_handle_join(int af, struct sk_buff *skb)
> +{
> +	struct mptcp_options_received mp_opt;
> +	struct mptcp_pernet *pernet;
> +	struct socket *ssock;
> +	struct sock *lsk;
> +	struct net *net;
> +
> +	/* paranoia check: don't allow 0 destination port,
> +	 * else __inet_inherit_port will insert the child socket
> +	 * into the phony hash slot of the pernet listener.
> +	 */
> +	if (tcp_hdr(skb)->dest == 0)
> +		return NULL;
> +
> +	mptcp_get_options(skb, &mp_opt);
> +
> +	if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPJ))
> +		return NULL;
> +
> +	net = dev_net(skb_dst(skb)->dev);
> +	if (!mptcp_is_enabled(net))
> +		return NULL;
> +
> +	/* RFC8684: If the token is unknown [..], the receiver will send
> +	 * back a reset (RST) signal, analogous to an unknown port in TCP,
> +	 * containing an MP_TCPRST option (Section 3.6) [..]
> +	 */
> +	if (!mptcp_token_exists(net, mp_opt.token)) {
> +		struct mptcp_ext *ext = skb_ext_add(skb, SKB_EXT_MPTCP);
> +
> +		if (ext) {
> +			memset(ext, 0, sizeof(*ext));
> +			ext->reset_reason = MPTCP_RST_EMPTCP;
> +		}
> +		return NULL;
> +	}
> +
> +	pernet = mptcp_get_pernet(net);
> +
> +	switch (af) {
> +	case AF_INET:
> +		lsk = pernet->join4.sk;
> +		break;
> +	case AF_INET6:
> +		lsk = pernet->join6.sk;
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return NULL;
> +	}
> +
> +	ssock = __mptcp_nmpc_socket(mptcp_sk(lsk));
> +	if (WARN_ON(!ssock))
> +		return NULL;
> +
> +	return ssock->sk;
> +}
> +
> +static struct socket *mptcp_create_join_listen_socket(struct net *net, int af)
> +{
> +	struct socket *s, *ssock;
> +	int err;
> +
> +	err = sock_create_kern(net, af, SOCK_STREAM, IPPROTO_MPTCP, &s);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	ssock = __mptcp_nmpc_socket(mptcp_sk(s->sk));
> +	if (!ssock) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	ssock->sk->sk_max_ack_backlog = SOMAXCONN;
> +	inet_sk_state_store(ssock->sk, TCP_LISTEN);
> +
> +	s->sk->sk_max_ack_backlog = SOMAXCONN;
> +	inet_sk_state_store(s->sk, TCP_LISTEN);
> +
> +	s->sk->sk_net_refcnt = 1;
> +	get_net_track(net, &s->sk->ns_tracker, GFP_KERNEL);
> +	sock_inuse_add(net, 1);
> +
> +	return s;
> +out:
> +	sock_release(s);
> +	return ERR_PTR(err);
> +}
> +
> +static int mptcp_init_join_sk(struct net *net, struct sock *sk, struct mptcp_join_sk *join_sk)
> +{
> +	struct socket *ssock = __mptcp_nmpc_socket(mptcp_sk(sk));
> +	struct inet_hashinfo *table = ssock->sk->sk_prot->h.hashinfo;
> +	struct inet_bind_bucket *tb;
> +
> +	spin_lock_init(&join_sk->head.lock);
> +	INIT_HLIST_HEAD(&join_sk->head.chain);
> +
> +	/* Our "listen socket" isn't bound to any address or port.
> +	 * Conceptually, SYN packet with mptcp join request are steered to
> +	 * this pernet socket just like TPROXY steals arbitrary connection
> +	 * requests to assign them to listening socket with different
> +	 * address or port.
> +	 *
> +	 * The bind_bucket is needed for sake of __inet_inherit_port(),
> +	 * so it can place the new child socket in the correct
> +	 * bind_bucket slot.
> +	 *
> +	 * A phony head is used to hide this socket from normal sk loookup.
> +	 */
> +	tb = inet_bind_bucket_create(table->bind_bucket_cachep,
> +				     net, &join_sk->head, 0, 0);
> +	if (!tb)
> +		return -ENOMEM;
> +
> +	inet_csk(ssock->sk)->icsk_bind_hash = tb;
> +	return 0;
> +}
> +
>  static int __net_init mptcp_net_init(struct net *net)
>  {
>  	struct mptcp_pernet *pernet = mptcp_get_pernet(net);
> +	struct socket *sock;
> +	int err;
>  
>  	mptcp_pernet_set_defaults(pernet);
>  
> -	return mptcp_pernet_new_table(net, pernet);
> +	err = mptcp_pernet_new_table(net, pernet);
> +	if (err)
> +		return err;
> +
> +	sock = mptcp_create_join_listen_socket(net, AF_INET);
> +	if (IS_ERR(sock)) {
> +		err = PTR_ERR(sock);
> +		goto out_table;
> +	}
> +
> +	err = mptcp_init_join_sk(net, sock->sk, &pernet->join4);
> +	if (err) {
> +		sock_release(sock);
> +		goto out_table;
> +	}
> +
> +	/* struct sock is still reachable via sock->sk_socket backpointer */
> +	pernet->join4.sk = sock->sk;
> +	return err;
> +
> +out_table:
> +	if (!net_eq(net, &init_net))
> +		mptcp_pernet_del_table(pernet);
> +	return err;
> +}
> +
> +static void __net_exit mptcp_exit_join_sk(struct mptcp_join_sk *jsk)
> +{
> +	struct socket *ssock = __mptcp_nmpc_socket(mptcp_sk(jsk->sk));
> +	struct inet_bind_bucket *tb;
> +	struct inet_hashinfo *table;
> +
> +	table = ssock->sk->sk_prot->h.hashinfo;
> +
> +	tb = inet_csk(ssock->sk)->icsk_bind_hash;
> +	inet_bind_bucket_destroy(table->bind_bucket_cachep, tb);
> +
> +	ssock = jsk->sk->sk_socket;
> +	sock_release(ssock);
>  }
>  
>  /* Note: the callback will only be called per extra netns */
> @@ -200,6 +378,7 @@ static void __net_exit mptcp_net_exit(struct net *net)
>  	struct mptcp_pernet *pernet = mptcp_get_pernet(net);
>  
>  	mptcp_pernet_del_table(pernet);
> +	mptcp_exit_join_sk(&pernet->join4);
>  }
>  
>  static struct pernet_operations mptcp_pernet_ops = {
> @@ -219,12 +398,36 @@ void __init mptcp_init(void)
>  }
>  
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -int __init mptcpv6_init(void)
> +int __net_init mptcpv6_init_net(struct net *net)
>  {
> +	struct mptcp_pernet *pernet = mptcp_get_pernet(net);
> +	struct socket *sock;
>  	int err;
>  
> -	err = mptcp_proto_v6_init();
> +	if (net_eq(net, &init_net)) {
> +		err = mptcp_proto_v6_init();
> +		if (err)
> +			return err;
> +	}
>  
> -	return err;
> +	sock = mptcp_create_join_listen_socket(net, AF_INET6);
> +	if (IS_ERR(sock))
> +		return PTR_ERR(sock);
> +
> +	err = mptcp_init_join_sk(net, sock->sk, &pernet->join6);
> +	if (err) {
> +		sock_release(sock);
> +		return err;
> +	}
> +
> +	pernet->join6.sk = sock->sk;
> +	return 0;
> +}
> +
> +void __net_exit mptcpv6_exit_net(struct net *net)
> +{
> +	struct mptcp_pernet *pernet = mptcp_get_pernet(net);
> +
> +	mptcp_exit_join_sk(&pernet->join6);
>  }
>  #endif
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 4599bde215b2..5b54e3c8efea 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3777,7 +3777,7 @@ static struct inet_protosw mptcp_v6_protosw = {
>  	.flags		= INET_PROTOSW_ICSK,
>  };
>  
> -int __init mptcp_proto_v6_init(void)
> +int __net_init mptcp_proto_v6_init(void)
>  {
>  	int err;
>  
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 7bd064b68b51..6a81e2a21301 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -647,7 +647,7 @@ static inline bool mptcp_has_another_subflow(struct sock *ssk)
>  
>  void __init mptcp_proto_init(void);
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> -int __init mptcp_proto_v6_init(void);
> +int __net_init mptcp_proto_v6_init(void);
>  #endif
>  
>  struct sock *mptcp_sk_clone(const struct sock *sk,
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 8be20f7b76df..4696d27a8994 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -116,6 +116,9 @@ static void subflow_init_req(struct request_sock *req, const struct sock *sk_lis
>  
>  static bool subflow_use_different_sport(struct mptcp_sock *msk, const struct sock *sk)
>  {
> +	if (inet_sk(sk)->inet_sport == 0)
> +		return true;
> +
>  	return inet_sk(sk)->inet_sport != inet_sk((struct sock *)msk)->inet_sport;
>  }
>  

