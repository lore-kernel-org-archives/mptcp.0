Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCA0173
	for <mptcp@lists.linux.dev>; Wed, 19 Jan 2022 01:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642555511; x=1674091511;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/C3/FEIfNaOYAb3nUvXIStjVj0maIpXTBmp3XHtTz5M=;
  b=IS3LbYt+s4U7UJFK+ZkommHDEGqR69bdp4gRF8aSlvuwTmWZQgCTaj73
   op7xwAaIwM8ztJWQcn5Ex0KNu7HiIufHRiuxVMO/cS1/yX0qXcqOkfpBu
   XoHeUCoECBCHMSUSiYDC9kh9Jyh1a7GgS19PgvzFKcj1jGoIqqLvJpHeX
   LfOfZ/ywCCSHMMLBGHpzxt8CuB00raS1jBTU/BL5z8Ak3IBXiEQ8WB0Wl
   aVUjtVQ5cAXhANNPFgAMq9X09UfiRZxoagAHJxXTmdOA4+93zRDwHrmBQ
   vo1lBamwlVKMSoWAHR/ZiNdCVmocadX10UtKy5TOuyJJDqfmWmsw4AHBi
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="225629489"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="225629489"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 17:25:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="492859602"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga002.jf.intel.com with ESMTP; 18 Jan 2022 17:25:10 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 18 Jan 2022 17:25:10 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 18 Jan 2022 17:25:10 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 18 Jan 2022 17:25:10 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 18 Jan 2022 17:25:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UnUDBULvBc33n/DhvECzTb159R5eMBxt/fkS8GYRYT7tT0EA8yDXaCg0fQglbqjWKNePA+G2HCOSPGJNqqdBeq24td7Y1ffPNoeFdj4T5AAHr+vL+9W53lmb6WqRJHAAo8iDmUIlHJohCF6aqHuxiq0fdeoWiLPSoyHb8znsiuAXeghSnjsl0/S00A0b7pYqV3aKTU5uUTS7/ND57F0pKiVWXrxG8Jr+oA3VYHRf2J1Hw6V9tNvXbvhi9RHRUEgASwe7h87lsxzUiOLkk9W7upCc6QGZo3yKnQ8a7WcWszroXfT8caO1pWOvhNoa3md2uqsMsvywT7k8AC0nAoxXAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQGD6tMd9l3kZknODaF+ku6hnDANULk5mjeOQkTsZ+k=;
 b=OUAHFjxj8oZTRNKHarc+uS3lZ1tzsgvjpeTUQJHG90NedjzPO29FewcDGuRW5hEy+SpgU0hyX0UfLZzDDy2qIUp5k1qSEFWP0+iUVUs3qGZ/IShI9R6/amwUsYxMYZxqbAetFJNIgxYo88JXmtBhSWstF9MuPFcxJjOKgvmPUM6ooH+ocKKT/5EJiLTELaGOtwzO7E1hbQCpYbPn4loZjBokRrAne80kcoSW6ZXX3I4GUTRESN9ubNSK0qx4Zl4JLbu8yWD5bOIREFmG5WbA7qCd+qaNuvhe1ms1EsKfzSEzIBdvppndu8kirKVdG4rCxMLjIcozEm6kGBDoXJT08g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5145.namprd11.prod.outlook.com (2603:10b6:806:113::6)
 by SN6PR11MB3149.namprd11.prod.outlook.com (2603:10b6:805:d5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Wed, 19 Jan
 2022 01:25:07 +0000
Received: from SA2PR11MB5145.namprd11.prod.outlook.com
 ([fe80::992:6137:3ea3:6cfd]) by SA2PR11MB5145.namprd11.prod.outlook.com
 ([fe80::992:6137:3ea3:6cfd%4]) with mapi id 15.20.4909.007; Wed, 19 Jan 2022
 01:25:07 +0000
Message-ID: <e5b4f614-4b6c-84d3-8558-bcd707bc32ac@intel.com>
Date: Tue, 18 Jan 2022 17:25:04 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH mptcp-next v2 07/21] mptcp: netlink: process IPv6 addrs in
 creating listening sockets
Content-Language: en-US
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, Paolo Abeni
	<pabeni@redhat.com>
CC: <mptcp@lists.linux.dev>
References: <20220112221523.1829397-1-kishen.maloor@intel.com>
 <20220112221523.1829397-8-kishen.maloor@intel.com>
 <489b1e836ec09b23cd9318f7fa8a404dec50e72b.camel@redhat.com>
 <911f2260-4694-cd5a-61d8-f094f0ab672b@linux.intel.com>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <911f2260-4694-cd5a-61d8-f094f0ab672b@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0261.namprd03.prod.outlook.com
 (2603:10b6:303:b4::26) To SA2PR11MB5145.namprd11.prod.outlook.com
 (2603:10b6:806:113::6)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d17b3cb-6a08-4bb7-6c19-08d9daea86e3
X-MS-TrafficTypeDiagnostic: SN6PR11MB3149:EE_
X-Microsoft-Antispam-PRVS: <SN6PR11MB31498D61D4094D954F9AB204E1599@SN6PR11MB3149.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TyPdijeONLJDGU4VvgG2KFWXrBe1y4RHA54RENvHdyh+yXMaiMXX2r4QvSsncHiQoXrirrwmZksaNenZWDbIeRLUk+jD8CIfuN4k7Zdq4v5FAMQzRsuF0VxvWM1+iZAC7ZrDW+AHXy7aHPgoV+qRLRlWlVMqjax665a7AyW8m3VWKuyGSUE6iOcQ+DhsMP5au2RenQWUkMJ1Hst58q3JltxlSlPNORONgWlN61VSpc0N0jWvQc8JIF+8J40GSxIS8FLNbimQRzx59hAcGo6/zJOmm3V8BeVKcEKuavoSFJmfA3WbG201CIdNzEqQiYy5kgjKsBmn19vf37a/KQiJifEh5PDcP+YrytkLAVInsUrgRicIfOsd/Ts9+KAig18WOiGuTSosAwMuHc5MEh7qYoEhRq7uS7P5ftmpin7QPgaThmjGASuGdTvkgXVSQ1yIdAaiuL6+Oqe7bTcMDweiZRzoR5l14oHCwiXTwM9Op2LrD1Avxq8Po+DtjGB4fisd/q6Y7422MgXcCipZ1SNro5Lp/G+cfpe09CDqhzixn5HqIOFEbNzydAgTjVskwvQNbDXg7DZDRSweTBt3DA0q2gbaGo9bbjZRuytE120n9wpJPSmfccGz/n7vwci5oaE4JrtpYdAH9m2EXSvAju2Bnu5AZIpMonfHjhI0DvX0IuGtFZhgkshXc+VlSe6Nj23lwccK+W2Mw40V6CGxw8/4tP9PP9o4RonzKCaTVg6/kbE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5145.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(8936002)(110136005)(36756003)(38100700002)(6506007)(53546011)(4326008)(66476007)(31686004)(6486002)(31696002)(83380400001)(316002)(6512007)(86362001)(2616005)(8676002)(66946007)(6666004)(82960400001)(5660300002)(26005)(66556008)(2906002)(44832011)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enhibUdOcDR2RG83Sy9tM0NIK2VUdGQ0QTlFWm4yd3lHQzZTTll4L0E5clNm?=
 =?utf-8?B?Mm1TR2FhYVNNOEJyRkpmSVhKanZvS0E4T2Zzc1hBRGxvWFZZem5LTTU2Qm1W?=
 =?utf-8?B?YStlVG1hb2Z5TmphZVYxeXVtdkNCbTRoZFM3WlhSMGRSRnZvMVhDendndVM1?=
 =?utf-8?B?QU1vOWx4ZE51WndyeHBHbzBKcGRTL0xocTl0Qzd0RWJsZ1U0S1JnVWVhRys5?=
 =?utf-8?B?Z296UU1iUTZ5b3VOUGl4UWppckxmTEU5Qm0rZjI0dE5sT1NndVpNYzFURUhU?=
 =?utf-8?B?aHhwZURtT1pGamZrNVczQ1RGUUpoYVVhVk1UanRZTWhlbzc5K2NHSklYV2FG?=
 =?utf-8?B?eXNCMG83ZXBZZmRVbm9pejNXKzFEQjlzU3B4aWw2S3Q5TXRoZzZwcjdIb0xq?=
 =?utf-8?B?a3RqTUtFUHV6S0J0LzhyMXhHaWF2TFZXZ0oycEVLVWFVRnBtY1prcTlpMU10?=
 =?utf-8?B?MVpkYW9iazRhbTdJaU1MMHN4MGFtRGZYcG15S1NINmFZZFEzQTNCVjZrV2t3?=
 =?utf-8?B?eUlOMVIxNnFjVURWSkxyZXowVU1kZjVNUEw5c3lUa0NrN2k0OXptYTRSOUtk?=
 =?utf-8?B?WmxoL1VQb1ZvMnNNOGI2R0FHZVFIdzlVTG9peUlCM3V3OWl3QW0yTjR4Y0R4?=
 =?utf-8?B?c1E2SHBDRCtLUHVWNkJtYmhseVE0aUh4c2YyL3BOMkZXR3dKc1ZuODc3blZa?=
 =?utf-8?B?WnBOR2NveEhvSVFWTTc0STdKRHJuQWJ6b1dEVkVNZnhhdUNPQjd3ZEtyaDFu?=
 =?utf-8?B?MmJMU2t0bVhOOVBxQmVGcU5pYlgrT3dHUXk0eUY4QmFJWFpDMjl0QmVhZjI3?=
 =?utf-8?B?clU2NlFHbWROWGpUSGRFd3NsNitpc291c2tSeWpHdlNzdmZoZmpqTHh2NGts?=
 =?utf-8?B?bVB0dGdoeWM4dm5Ma3laanR3RThOU3EvSlR2eUlJQUpaOWIxWkRNUllEZHhU?=
 =?utf-8?B?MlBsbUd2cVp4NUlQcHdvYWRuKytoS00vMkcweXQ2MmNVYStPT1hrVFpNMTFp?=
 =?utf-8?B?Z3BQQ2Nldjk1TTAyalFxT3A1WnZiTFVWbERoQUxpL2RReHNrbkk0SGpQd3RO?=
 =?utf-8?B?YmY1dFV3LzZtQ0tZNVdPZUtFNlVlS0gyRCtONHlJMThsbm1kQ1dLZWVCcEpI?=
 =?utf-8?B?YThxVlFFQ2tKZjkwdUFGMUFTY3huSUNSN3F2bzVLRzRYVEVMNzNrenpTbFFx?=
 =?utf-8?B?b1FmU3djUFFodEp3aDIxQ2dXOWt4Wk0xVk9rcnl0Mnl5WlRNS21PelVwLys1?=
 =?utf-8?B?WjdEajNqUkhqNzdYbmZZZlRuaStzOHJGc205KzhVTkQ5OFhNKzJGcVBkSTFi?=
 =?utf-8?B?WDlBSk1WMmo1L3RjWmNYOFYrUkQxUGJHY3FVcDZWcVVYNEhTY1dabmVpdnB6?=
 =?utf-8?B?Zk0wNzduWmpEVlJGbnozaTUycENjTWQyZ0R0UGFaWFdoMmE0cEFTZE1xV3Ez?=
 =?utf-8?B?TWQ3T1E4a3lma0ZEcXJOVjNlNmIrY0RoeSszalFOckhQemJXdDkrcHYxcVJG?=
 =?utf-8?B?N1kySTNxYWpoM1RieEZYeFBMS0w5eExiUUZKOVhlM2FQWjdSUGFBLzhRNnZa?=
 =?utf-8?B?bXkzNWhzbERZNnM3OWFuSk9mUjkwbHUwU3lyc0pWdmZJWTRQNW1IdkhXWktL?=
 =?utf-8?B?OXhrYXAwcDBFMzVIM0d2ZG4vQ09iTVVocVVpOHhLMnQ2WjB2SjlMYWJHc0Np?=
 =?utf-8?B?TUpTMXUybVk1MmlseHRicXYvdGEwc2pJclh0VFh1VTZOcGhCcnFYdXowK3J6?=
 =?utf-8?B?TTZ0WVlENW5CcWRCVm5mSjB1NnRuSDBXTS9Sb0swdzlMdi9SNjNBV2RRQ2d2?=
 =?utf-8?B?bnhZU1R2OHhCcm15ZG9tZDdFYSsrU2NwcU1iNXRSc0ZrTm9XWlpUdkJTa3pU?=
 =?utf-8?B?VjRHZU1ucmxsSjh4dWJCbmJ4UjdsOEVMTUxTT3JqbFkvL0R6RGNjcHJFQW5i?=
 =?utf-8?B?Q1dPUlZ4Q3FCUUV1Z0xoaTdWcnEvRHVrMU96NGRDZzlNdFZJY1RPZ2UwK3FP?=
 =?utf-8?B?UXNKSFNIbjRjRDEvTzJOWGREczBYcE1QSm5ZUjcyakNHWU9Db25Nam1ZY09C?=
 =?utf-8?B?VVRFR0p0QlgwdU1UVFc2d3JIK2FNb2VrdmlRbkNOWTVSb1hvK0JKMFRoUE5r?=
 =?utf-8?B?RU5iMU1pdU03ZTNmNzVQRW05SDZ4bVNxNE5zMk85d2pJK0Q5dmVOSTZDdEht?=
 =?utf-8?Q?zc+OxsiSZ1OK72KOLKX3Qfk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d17b3cb-6a08-4bb7-6c19-08d9daea86e3
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5145.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 01:25:07.1295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JW7/1LUAqDfC6I3JeVfY1KQVDgoDlQowo80aNdWUy56Se2uEOPo+tvF5OCQyxf5T5n3JGKJVXCLk+3AJr3PJtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3149
X-OriginatorOrg: intel.com

On 1/14/22 2:09 PM, Mat Martineau wrote:
> On Fri, 14 Jan 2022, Paolo Abeni wrote:
> 
>> Hello,
>>
>> On Wed, 2022-01-12 at 17:15 -0500, Kishen Maloor wrote:
>>> This change updates mptcp_pm_nl_create_listen_socket() to create
>>> listening sockets bound to IPv6 addresses (where IPv6 is supported).
>>>
> 
> This tag -
> 
> Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
> 
> would help with backporting to stable.
> 
>>> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
>>> ---
>>>  net/mptcp/pm_netlink.c | 8 ++++++--
>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>>> index 4c1895dbc2a5..779ec9d375f0 100644
>>> --- a/net/mptcp/pm_netlink.c
>>> +++ b/net/mptcp/pm_netlink.c
>>> @@ -986,6 +986,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
>>>                          struct mptcp_pm_addr_entry *entry,
>>>                          struct socket **lsk)
>>>  {
>>> +    int addrlen = sizeof(struct sockaddr_in);
>>>      struct sockaddr_storage addr;
>>>      struct mptcp_sock *msk;
>>>      struct socket *ssock;
>>> @@ -1010,8 +1011,11 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
>>>      }
>>>
>>>      mptcp_info2sockaddr(&entry->addr, &addr, entry->addr.family);
>>> -    err = kernel_bind(ssock, (struct sockaddr *)&addr,
>>> -              sizeof(struct sockaddr_in));
>>> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
>>> +    if (entry->addr.family == AF_INET6)
>>> +        addrlen = sizeof(struct sockaddr_in6);
>>> +#endif
>>> +    err = kernel_bind(ssock, (struct sockaddr *)&addr, addrlen);
>>>      if (err) {
>>>          pr_warn("kernel_bind error, err=%d", err);
>>>          goto out;
>>
>> This looks a bugfix for -net to me?

Sure, we can record a bug and the fact that this commit fixes it.

>>
>> Possibly worthy additional an additional mp_join self-test for the ipv6
>> case.
>>
> 
> I agree, this would be good for -net. Kishen can you add the suggested selftest too and repost separately for mptcp-net?
> 

Actually, this path is currently exercised by self-tests in userspace_pm.sh through address 
advertisements from the namespace containing the MPTCP client, for which a listening 
socket is created to subsequently receive MPJs. 

> -- 
> Mat Martineau
> Intel

