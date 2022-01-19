Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4223E173
	for <mptcp@lists.linux.dev>; Wed, 19 Jan 2022 01:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642555596; x=1674091596;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JPh+fihPEKwbpWpqSt8WUzoIATHXEf01cCczsCkkRTM=;
  b=LZG0jhSmFxJH6umIU9cXhAHBcqvEqfoauTZ04LkEptNH2KhBKkMlJikv
   QTPGV+Tc35hvQzLjWKO2VKKmc0RwYxpeOVyFXO1VyMY2ZTADpP/boiHDS
   J7LAC+G7oWtmlr8/BCK9oIv2sUxrqJd1Cui3Ruq/7tJu6kOGsZf0vaVfI
   wHrYAwJsKSMs+5XStwhbA0GRiBaP+HWzcaoJ3Q+Kvom3DHSvppZLAQggf
   6WkLwjt9fGLoS79IwEt/JdIxOG2NDFF4pQbV9VeRjh03SizlSGBWsbZKi
   ZM43dYi0DHS6IbnEzZM+6oqrBUYuDwZBcz0sfOAfaYrY2RzzJpko+2fvb
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="232318301"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="232318301"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 17:26:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="578639785"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jan 2022 17:26:35 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 18 Jan 2022 17:26:35 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 18 Jan 2022 17:26:35 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 18 Jan 2022 17:26:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNe85xoKb9h9Bxit3/Ts/GkCyVlPiC4w2FXLn8sOmaXZvNsfg7Bbi+CbVOGwSKkV+w8UcAG0p/8EupKLVly2cfGZERYBGveFDkgP5juWp51zglkfwo1bUbiMPRXDDfMDG8oA6cUa0JckjCUNHWFLIudP3E0uqYwsCJKnF9fXKAhCUAvWKesIuqjC4AcuNSTpUAoi+CqF0HFwhnKBmQ/jz0PPn8kvd2yrEvyDBC5BvjJPaJCY5logPderb+VHK0qKzqNTA+VgOAwAfq1wcWO4EWrOHtXnnr+NGs4WHSUxtE+K0Ny7K3T91NdZaIKdgyL8f+xpLa2GwNAieBIFUMZe+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3O6ZdQbKyPmTbcfaloVdj/nWtZaBnVuUB/Tgrt6wBc=;
 b=N/FMdtU7RY4N00ugz2Ik6FD9r2sQG23vXxxPBBuY3ZtjLH6sVSjuZmBx2Dynw773c7mh00guRAUC19Fdf6aHcqQRZwwTzRvr6v+A3jeEwcZ4fTwI1jGdJQ5Y8w9eGxzhRDj8b3Hbevb5bMgLCw3rrlawf0EDDaUYGE7IRTNika9jKw8Dl8CLS29XgV9+t5VTdQ+VKF2H4/z8zwd/X4zOIHGK1UxcqmDT6snysfvAoEtLeB7G328FSWL7YWTFOxtSJJg/7DY0+KdPCawTUvG/QFGvamdXpSwGhZYXBW0JElvESGh+eRFVANj9hwYDDzdSnJbbmU90zeHc16F6GASklw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5145.namprd11.prod.outlook.com (2603:10b6:806:113::6)
 by SN6PR11MB3149.namprd11.prod.outlook.com (2603:10b6:805:d5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Wed, 19 Jan
 2022 01:26:32 +0000
Received: from SA2PR11MB5145.namprd11.prod.outlook.com
 ([fe80::992:6137:3ea3:6cfd]) by SA2PR11MB5145.namprd11.prod.outlook.com
 ([fe80::992:6137:3ea3:6cfd%4]) with mapi id 15.20.4909.007; Wed, 19 Jan 2022
 01:26:32 +0000
Message-ID: <d3b555e1-752a-e125-1654-3d8cbdd20e4a@intel.com>
Date: Tue, 18 Jan 2022 17:26:29 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH mptcp-next v2 04/21] mptcp: establish subflows from either
 end of connection
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Mat Martineau
	<mathew.j.martineau@linux.intel.com>
CC: <mptcp@lists.linux.dev>
References: <20220112221523.1829397-1-kishen.maloor@intel.com>
 <20220112221523.1829397-5-kishen.maloor@intel.com>
 <83f91e9b-9c20-6e83-6442-41b87139f4eb@linux.intel.com>
 <eb4affeebe3b03948a2252b0d6af852751c0ac1f.camel@redhat.com>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <eb4affeebe3b03948a2252b0d6af852751c0ac1f.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0098.namprd04.prod.outlook.com
 (2603:10b6:104:6::24) To SA2PR11MB5145.namprd11.prod.outlook.com
 (2603:10b6:806:113::6)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ba95792-b74d-43ed-1f74-08d9daeab97c
X-MS-TrafficTypeDiagnostic: SN6PR11MB3149:EE_
X-Microsoft-Antispam-PRVS: <SN6PR11MB3149D75EECEE7596B4214704E1599@SN6PR11MB3149.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NoErvKgjoLfeIZDLWeDihFRbnQ7cBDtwNa9AiqUoF4SFy5llyRcpUuezxcLp5bz2xdnRMmyQ6ugfE5CzZouBpSkaBnweqH7GeGtagsdmTdQ9F3uaaBuikFUZBR7Gwmmi7/a+XYnyNcxcNLMERxdp9y5YwFTsy2Q5U+sLkMKtEa/GOSj91s4x0LS/d6t01R6y4Nk5IVIQTqs2sxOEd1JMxzbgX8x51ZZptxLFc8p0PU2sCWv+9tC6K3oj2OQn8X/mj1HqcMBg32GuuqB03yui3R+WtDhUt35E69RU1mdJtuCLJWOHmbfbtksGUzxtzDcn+nXSHWLa58XXaD0+TY7Au9uUXTTU6hRBt8WDO1ic1LuqDyfnAFVAgbeJmuf/aQS0OzKg4RlsZHj4xEKSuq5Wu6ZvPjgZBjFYQaIwqUaK44OaNtfB1YpGACQ1/uh1mBx4orHxeWw4cMWrpp+vh4wqnhqarr8gYSOjlFNwf5zCHzohYarCnFUmUcPCNdvuri3dG8oqH89drh94y7VavQhzi8FK5LW43g0fmZo/0iZN6AiwvoDx7XwuTGSleZBwtfa641VHxcrRETyke91mKobPLutW38y4JRvYA1MrhU3AbgilY6PRowRzTJ6O12P23fEFB6E8dVzVvySgwUxXvDhEFMoGZGQE7PlPAtSRoKzD9sZ2qlOrEcRL2WXOmoCPzb5TI9a3vpuChBMrHvyUuTuQIpLsf5qD33HW09BNCT36Zsg7XbbXovgvsNu8TlNsQTOSKwK3SvtrzCOteyoalyqll3E/tIyy/rgIpgHvYbNrcAJ39CC63h7UuUAOgqU5HX2ggAzDmzzjl3SlCFU89J8lSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5145.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(8936002)(110136005)(36756003)(38100700002)(6506007)(53546011)(4326008)(66476007)(31686004)(6486002)(31696002)(966005)(83380400001)(316002)(6512007)(86362001)(2616005)(8676002)(66946007)(6666004)(82960400001)(5660300002)(26005)(66556008)(2906002)(44832011)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTRacFRiVFJwU2ZoOEdrMjZ4TXMyVzZBWjFOS0ZpR2k1TmN5UU92aFJMVnBt?=
 =?utf-8?B?U0tEUlVlNzFtVlFuVzVXbjA0NVpjQjJEa0YvSDNjUndnWXQ5ZlROWWlYZ2h5?=
 =?utf-8?B?bmZxTGtvZ2tKeFVYN2Fqa1pNdlUxdEpVS2Zsc0NITW96OUI4RzVnUEVDY0Ry?=
 =?utf-8?B?WWNVMTBvR1hDV0tIeFdPd1VXU2xlbzBjcTRpMW51eHZYb3l6Q2JNT3phaFBB?=
 =?utf-8?B?WUhGQ3VLcUtjeGNUYW9jaDR0d0lqK3lFZW5NMU16aHJWUEdsYnNIYjN0eERG?=
 =?utf-8?B?cUFlUmRxekdKdVg2RVFaT1hHc0VBQUZrNExEcEVxclAyUTJhRU9xZGs1azF2?=
 =?utf-8?B?bkFtSjlBZm4wM016R0JZckVSOHNkdkFxY1o5TzIwcDRNUGtML2NjaFdUSTcy?=
 =?utf-8?B?Z1FXVnFEQ0pQekpZVVZLUWYzMzFtSU5YY3p0OFdManoxVUVRaXJndUgrOFFS?=
 =?utf-8?B?ZGdhTU1GUS84U09SeDZFZllyR2dVSEdZV1RYekY3bWRRMzNEdEErNHVWRTBG?=
 =?utf-8?B?cGVoSW1WM3V5clNVV2FnbDMvRk9vWmxjMzM5UmtLN3BoUnljT0d3OWhmbzAx?=
 =?utf-8?B?YXU0Um43YXFqSHhYWEhVbW9KcU4zc29HdmhJSkhJOHYrN0NOYi8wVThZNm9S?=
 =?utf-8?B?Z2VhUk5kazY1aHU1UW95dzI5SzNseWRYeU4zeGlkN2lzcVE0TWFnb2Z3SHVp?=
 =?utf-8?B?Z3FCcGVMTHZ6andCaTVjZHl1eUh6Qk92UjF3OHdidzhJMkUrZWJ0OHM1T1RB?=
 =?utf-8?B?cTFMT2k5eTdOUXpKZXRyZmt6Y3J2Mk9NSHp2QW8xdmwxRlJDWW1jd25ON2p2?=
 =?utf-8?B?ZFppOWpCRGxrVXFoWjdIU3VYbFV6YkpTRmk0TTBEU1M1QzQ0M0lnTVE1OG1N?=
 =?utf-8?B?ZGU4YUZFMlgrSHo4NGlWTVF5WjRPVEVBY3pRUGxsNWFRMVJqYUxHV2ovVVZl?=
 =?utf-8?B?WGR0Z3J6Y3RkOGVjV3dPWE5EdW5oVzVTVlhqd3lQSU5RdXU5OE8rZDN0bHRo?=
 =?utf-8?B?Y1hBKzFBcGZrTno5UmVoYWZlQnRiNWxlVmZOUjR6bSsrcFdMeHBUdHdXbEtT?=
 =?utf-8?B?a3VPTlpDa01Fc0h1TVVrU2cyTU1EN1g2dXpwYTd0clFNVlU4Z29sbkY4L2VC?=
 =?utf-8?B?UEdRZGlmTTJtUVlKa2lyMWFrMXpkVVV2UWppU1ZUblFMdGhHWTMyRFpVYVBu?=
 =?utf-8?B?cHFTVEZwbWVqcmJmcS9GMnRaUkVlYWpsL2g3RG1RWWVEUVBhMG9XUDk5N1hB?=
 =?utf-8?B?RWZUUWd1Rmh5VXBoNGxRZ0cxbTJEa2poZjU4YnFyUlU0dFRJam1vV0xJblRw?=
 =?utf-8?B?cHBaTk1nNGN3dFBmVXc2M3BuYkhwenlTYnMwY1A4T2dkL2VQd3E3eU8zWE9n?=
 =?utf-8?B?WllXakl4N2YvN3oxcm5GQ1pxUHhOajd5V3ptbzlUWU9FMVJBQ0x1QXFTb2xS?=
 =?utf-8?B?M1Brb3QyaXR2bXR6ZUlzbmtXclJVRDN6cWp5R3lTZUNWL0ViSmdEZ2Q2WnJO?=
 =?utf-8?B?Vm4vcEdZUjluODFUaTVvNkZ4YmRtUEtKVzBKSG93cVFZK0VvTzY3NUdtMk04?=
 =?utf-8?B?T3JvS20vZGtsWUtXcFd2RlRCMFl3dS9JaHFaTGdrVDFyTGdWbGx1eDJxOTMx?=
 =?utf-8?B?OXRkUmxlOFFYaG0yQXlFOG8zT084K1M0d0NQR0JUQnlnd1RDbkRUN3ZkRitt?=
 =?utf-8?B?WEU0MWNkWXA4bFFHVHdVVjBEMTZ1a082S3dSQmtsT2Z1NFpHeUdiR2Jodi9w?=
 =?utf-8?B?TXVFUWZQRWIyK3d2S0U4anBjcFZlNzgxV2pWcWFmT3VjUFkxcS93akU1RFlh?=
 =?utf-8?B?NGtWQkZzNkRrbFFldzVwK0VEQmRLVEIzc0RVdGczR21tYlRQUDNhbDhuNzRp?=
 =?utf-8?B?TmdWRE52SUhabXpuL2lLVm10VitRQ1Z5RUQ0UlRWcVRHdW1vVWIwVWFtMDk1?=
 =?utf-8?B?R2l5R05nTGd5UklBMElGbW1hT3JWemdQeU5pNUt0Nzdtdm5VODhwN2gvTzlW?=
 =?utf-8?B?ZGZldVJ2eGtCR3ppdkhuZWtBdHBPdWEwc3ZZZ3p2Ni9KMUVMR3dTamluS2Nq?=
 =?utf-8?B?UGdUVG1oWjl0ditkSmZHYkZHc2VpMzgrOU9SNnBsOFpFNGtPbnlBekJTQmZ5?=
 =?utf-8?B?VjRpYW0reEVVMGtCL3VBNk1Wb1NjLzJGSnlJU1d3UFNUMU1CaWdmczU0VUpG?=
 =?utf-8?Q?5KNbHKKKI/o3xHSNYKW161k=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba95792-b74d-43ed-1f74-08d9daeab97c
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5145.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 01:26:32.0176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JG5z8KfEGMee3aor56kdFzPBbo+99Q+aEdxeN4jzxyuwEy2xaxEroXPspNsaE5uBNZflwVCdRT/QNfUIc2dGFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3149
X-OriginatorOrg: intel.com

On 1/17/22 12:59 AM, Paolo Abeni wrote:
> On Fri, 2022-01-14 at 14:43 -0800, Mat Martineau wrote:
>> On Wed, 12 Jan 2022, Kishen Maloor wrote:
>>
>>> This change updates internal logic to permit subflows to be
>>> established from either the client or server ends of MPTCP
>>> connections. This symmetry and added flexibility may be
>>> harnessed by PM implementations running on either end in
>>> creating new subflows.
>>>
>>> The essence of this change lies in not relying on the
>>> "server_side" flag (which continues to be available if needed).
>>>
>>
>> After this patch, server_side is unused except for some debug output. If 
>> it's really no longer referenced (see below first), may be better to just 
>> remove it.

I think we'll need it. 

One possible use is to inform the PM daemon of the type of application 
(client/server) associated with a connection.

As we're discussing the idea of creating listening sockets only upon request, the 
knowledge that we are on the client end of a connection is something a PM daemon could
use to request creation of listening sockets whenever it advertises an address.

>>
>>> v2: check for 3rd ACK retransmission only on passive side
>>> of the MPJ handshake
>>>
>>> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
>>> ---
>>> net/mptcp/options.c  | 2 +-
>>> net/mptcp/protocol.c | 5 +----
>>> net/mptcp/protocol.h | 2 --
>>> 3 files changed, 2 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>> index cceba8c7806d..89808816db06 100644
>>> --- a/net/mptcp/options.c
>>> +++ b/net/mptcp/options.c
>>> @@ -921,7 +921,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
>>> 		if (TCP_SKB_CB(skb)->seq == subflow->ssn_offset + 1 &&
>>> 		    TCP_SKB_CB(skb)->end_seq == TCP_SKB_CB(skb)->seq &&
>>> 		    subflow->mp_join && (mp_opt->suboptions & OPTIONS_MPTCP_MPJ) &&
>>> -		    READ_ONCE(msk->pm.server_side))
>>> +		    !subflow->request_join)
>>> 			tcp_send_ack(ssk);
>>> 		goto fully_established;
>>> 	}
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 4012f844eec1..408a05bff633 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -3248,15 +3248,12 @@ bool mptcp_finish_join(struct sock *ssk)
>>> 		return false;
>>> 	}
>>>
>>> -	if (!msk->pm.server_side)
>>> +	if (!list_empty(&subflow->node))
>>> 		goto out;
>>>
>>> 	if (!mptcp_pm_allow_new_subflow(msk))
>>> 		goto err_prohibited;
>>>
>>> -	if (WARN_ON_ONCE(!list_empty(&subflow->node)))
>>> -		goto err_prohibited;
>>> -
>>> 	/* active connections are already on conn_list.
>>> 	 * If we can't acquire msk socket lock here, let the release callback
>>> 	 * handle it
>>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>>> index e2a67d3469f6..c50247673c7e 100644
>>> --- a/net/mptcp/protocol.h
>>> +++ b/net/mptcp/protocol.h
>>> @@ -908,10 +908,8 @@ static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
>>> static inline bool subflow_simultaneous_connect(struct sock *sk)
>>> {
>>> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
>>> -	struct sock *parent = subflow->conn;
>>>
>>> 	return sk->sk_state == TCP_ESTABLISHED &&
>>> -	       !mptcp_sk(parent)->pm.server_side &&
>>> 	       !subflow->conn_finished;
>>> }
>>
>> Are changes in this function needed? This code was added to address
>> https://github.com/multipath-tcp/mptcp_net-next/issues/35
>> which was a weird case encountered with syzkaller where a socket tried to 
>> connect to itself, triggering the "simultaneous open" code path. It 
>> doesn't seem to be applicable to MP_JOINs.
> 
> I *think* we can reach here even with MPJ, e.g. if we have port-based
> endpoint matching the src address/port - possibly syzkaller could be
> able to reach such scenario.
> 
> Additionally I fear dropping the '!mptcp_sk(parent)->pm.server_side &&'
> check could re-introduce the initial issue, at least for the MPC
> handshake.

The purpose of this commit is to permit the MPJ sequence to happen at either end of 
the connection. The change in mptcp_finish_join() had the most direct impact for enabling 
this, so I looked at other server_side checks mostly in terms of establishing that
bi-directional symmetry.

If the above condition holds only with MPCs, i.e. for the initial connection, then I think it would 
be fine to preserve the server_side check. But if it also holds for MPJs, then we might
have to account for both cases. Perhaps replace:

!mptcp_sk(parent)->pm.server_side)

with something like this?

((subflow->request_mptcp && !mptcp_sk(parent)->pm.server_side) ||
	subflow->request_join)

> 
> /P
> 

