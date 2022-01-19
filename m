Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D416173
	for <mptcp@lists.linux.dev>; Wed, 19 Jan 2022 01:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642555234; x=1674091234;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=XTlIDZuZ5RdPj57NduSomVYpN138r+PoWuE30BfP1E0=;
  b=mVTBtcEdncJ9WBEMBD/Mk+V+0wGmoLaprvqNfH6ql3JmVdqux+XKQM/Z
   azZtrDLaAophuLTtKATWA9ijOvQG8N4IdcbN9QLdkeofPcv3PSqsHVreV
   7vEUmQx3zzrQoZXlODZbSyeBsPaG6kUNsJV/plXrXhFfElz0z/P+aBBqT
   DSsGZ5YYKS6oveww25ERLOp8aOGguCnRdeuCaVEdERusH6buTGwD6sPZs
   iJiXx8X4ALIRCNjcqxtfsq0SZPco3B8KLUiMvNU6ZwCdSkI4E8wJUOe+x
   MxU/TC+J0Z1fYfXQ83xi8KDg8WBucexYPKyhEK/aCIt0GIkuHbXzm5oRf
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="269342070"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="269342070"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 17:20:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="477191161"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga006.jf.intel.com with ESMTP; 18 Jan 2022 17:20:33 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 18 Jan 2022 17:20:32 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 18 Jan 2022 17:20:32 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 18 Jan 2022 17:20:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msPWIJWCRoLRvQc1adAvLiWPtZbeOBpX8oVi9/hgKNesqNelxM6/lC5UOoZzePGzwfom9Vwl9I8r4y7jkF7Qy7ehQYlFAJdqWN3d3jBixniw+/01+p0Ob9CQGcCH2hBcFqR5+fjnTDqxGW8jZ655KNnpe7ox4L2f/fQZNFHXtTYgvNtcmc+ccJuvObBQMuMl6+TUjZuTLpl5Y4aplk2c3QmsGIthj6tHZYiOeL/XiCiIX9GfgmpIBhcUqo11jzoKW4FK5QLD9Il5USMIFuYGYtoR/qutajBYil2Z7i+JIyqCukq5yFWy7Jscz07kZFUJ5SfiXXvOsmOkJ8KDoEX6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AccytdL4G9hCj6ff6Ug8eqtMs6mEOVw+CMW9HQNtcE0=;
 b=CKBd1Sah5eV6UzBrG7wTyPBBqwG+2PPaaziyoa2S8LNqpTLDDJZzjot/8TxNM1+LVbzTiS9HbF1++WsYKycLu46CLzfs5JcDMww+I7rPt7R1Q0ODgSfrlhMKwZlUxr28sRZ+HfhCO3fX866HeXsz4vUqT2w+hz9f9JYfqu2gp4wWcIPNuWSqENWQX+I9ikOyeMPYwg/z/VMxBg2yRtsAaPql7aiXZjTZEnSDwHMoFX8WYsuZv/c2GIktel97UkO9Mpe3EQACqNi+BP8N+XdgZzMltv3I9zNIbaNzvRFFvXUlq9yRTd0a9+XIw2scdKNWH3zyQgjGXhH2g9dsEiyH8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5145.namprd11.prod.outlook.com (2603:10b6:806:113::6)
 by SA1PR11MB5900.namprd11.prod.outlook.com (2603:10b6:806:238::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Wed, 19 Jan
 2022 01:20:25 +0000
Received: from SA2PR11MB5145.namprd11.prod.outlook.com
 ([fe80::992:6137:3ea3:6cfd]) by SA2PR11MB5145.namprd11.prod.outlook.com
 ([fe80::992:6137:3ea3:6cfd%4]) with mapi id 15.20.4909.007; Wed, 19 Jan 2022
 01:20:25 +0000
Message-ID: <d2c95daa-5ad1-68d9-1072-4220c3931838@intel.com>
Date: Tue, 18 Jan 2022 17:20:22 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH mptcp-next v2 08/21] mptcp: attempt to add listening
 sockets for announced addrs
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, <mptcp@lists.linux.dev>
References: <20220112221523.1829397-1-kishen.maloor@intel.com>
 <20220112221523.1829397-9-kishen.maloor@intel.com>
 <c187fa2042e25cdc85aff2dd6687781b2511d86a.camel@redhat.com>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <c187fa2042e25cdc85aff2dd6687781b2511d86a.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR05CA0085.namprd05.prod.outlook.com
 (2603:10b6:104:1::11) To SA2PR11MB5145.namprd11.prod.outlook.com
 (2603:10b6:806:113::6)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7bf3910-44be-47ab-6cb9-08d9dae9df14
X-MS-TrafficTypeDiagnostic: SA1PR11MB5900:EE_
X-Microsoft-Antispam-PRVS: <SA1PR11MB5900F2C9DEC69CFB0336A9EAE1599@SA1PR11MB5900.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kc+ZLM5hpyQ7rVLC7BZUIKQCg/Lpylz5vgTeAs5VJJJT+xb/uRnr63+xPXKC1d9WDGsSGp7kI8JDi1aHoMjXtg6rEQ5iP4L6Fre2+KHW2T3/fQEzoHKZ9NEw27Dw8o02zppOJWnSqtOikxjCYCsTkcoRxn+RntdWxcdoVJJfq7Aa23ikeK+F23GvSDdRiPhW3G28/PePU4GcCNPl8eApkDyns/rSDNSvGjbt93FSCOrs6q96MF5SRU0DW+9TmPayj46f0IxBBPrhNAApDbCiz32RLdPzYwhnSiqjd/FEgSCNaVfVEkN3QEpDfNLYRQPIlAFXU2FCfijjvHjkcWcgddDE7Qg/r0lulI95ya3LsNTpGe6UKF6+jmiLB0J3W2s+G/vUsgeB+suLN9NK3MgZ7aEXf2iro/0epShr2C4f+CcMoyu1lM+/10A//okal00ejbS5C67KBftZcPXy1I4lTVpNpMHLuszqH37Syn96JIkF01P4lyNuv1xb+1anTsA3CR9EruEd4gctZdg/6ISxnanoIZ/vHu70ykwvwqcq4xlWf10f4sC2vuR4TTrYhxX+qQdBiFwsQdt5frWqPHnNzfakqhjCrqvOT7wKXLRjpXGTEDoEbZSHNQ8EvPT0Usdp5OdKu0+6vx9xPnpWRJkmQila7Lc0ky9j/DWIDOwVqgsnSWnlyUC6JHdk5r4Fxsh1QLBokrZdwNRxr1YGiS9CLhO9x4k2wkfULF3XpEEV76cJxRCzYjjDkuEO/WbmKbgWcCYncuegZO/HWN9/OolzZw76HTdqMDPurMtKx/ASIW174nBI22ebTKPQPyaVRRQ3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5145.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(6512007)(508600001)(8676002)(5660300002)(2616005)(6666004)(86362001)(82960400001)(316002)(966005)(186003)(2906002)(31686004)(8936002)(6486002)(36756003)(6506007)(53546011)(26005)(83380400001)(38100700002)(66476007)(66946007)(66556008)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0Q2blcvcUtuSDNkdFUxTmUzQTJPdHhVZ0VzSTRaTTZ2MEdPQlVldkN3RFVq?=
 =?utf-8?B?akR1aVRrN0F5aUExOFhSN0FUYXZQbWV3d29uK3BYR2pGbEp1TlZDaERxVzJl?=
 =?utf-8?B?WWU3b0RjbmpNSkdBS3Uzb1ZSQVIzRThkV2llUmhlVHVHVUUvVndKb3Q1VW04?=
 =?utf-8?B?QzYrWXZKN3pkV0h4a3ozYnRyUExLT2FjYytaeXQ0eXErVTVEWHIrazQ4QzFV?=
 =?utf-8?B?K3cxUEgwU0trbFZIQmRqb2hiL1dRUGtjb28xTXFGNTk2VkNOU2lRay9wVC9h?=
 =?utf-8?B?ckk2M1BPNVBidVhXNkg1MTJFNjJHOFZSd1g3U3FraFdrRWhuR2doeGNrcjh5?=
 =?utf-8?B?SWRhd1Bsald2b1NVVWNDbyt3L2VxczNYVlhYY3JKZm5XeUlLZG1taTRXSjh3?=
 =?utf-8?B?Q0dIM1JCWVkzMnJHY1hkLy9neVdFR3VKOHhqQThQMndGbDNnVDNMbUY1Zmkv?=
 =?utf-8?B?TWhWaXFuSUpNcEoxNGtsSzRKa2piQ1UzZng2ZG51S00ybmx5R0FXUS90MWJL?=
 =?utf-8?B?aTVrb2thZEphUHFFUDQ3bzNBbFFPUGdKWFZscDhrS3JWak9zNURHNHRIemdV?=
 =?utf-8?B?Y2Fvbmw3WUhhNEVORFVkM0dJeTdWMkdSNXNoMlExRkdJdTRtVVVCRGRreW84?=
 =?utf-8?B?cXFUMlcwTkExS2NrOUVwUVgyMFRlcUlDS3ZjalFEbVJ6OUxSd3l5MSs3M3Ay?=
 =?utf-8?B?VWJUVE9WT1Iwb2xxMWYzelp0MDBXZU1LSlU3SE84NEEzYXB3SDV2bktjdkdn?=
 =?utf-8?B?bjF3cisrTGFtbEtXQjVsRC9iZXgyL0kyTC9qUXMrV253QWxmU0dkTjFvWHhR?=
 =?utf-8?B?cVhaZ3ZkUGJGQ2wwbFp5UGpzM08wT3VMT3JQaDFhbDI2REZWOU8zb3lPSmlG?=
 =?utf-8?B?TCtidkoydHFqcEljZUZCVGdCRlB0dTdwOHprUFAzMjdtZ0d5MnBOMWpYeTkz?=
 =?utf-8?B?QVhUOVFqUUM2WUlGRmFWdXJxVExJT1NRc1JncmxmNXpnV2UremgvV2swSjJo?=
 =?utf-8?B?eFVaY1pMc3U4UzdnamkxM2xzVkc0ZE80NytXM3B6ZXA2WmpYYmhSOU1yaVhn?=
 =?utf-8?B?REdHUGpJNVpJd3lCcjg1eEpLcjU1WkZZOTEyellmY0FvQTI0TDJqeXZGL2Zn?=
 =?utf-8?B?MW5vN3dhZm5uMTBlR280Tm9zTHBIVFlkVVB3R1lpb1NWTDRPamgvczVHMVZD?=
 =?utf-8?B?SjQranpHYjRsdHhzSUhEOS9PUWJQc0lTWHN1UE1tZ053V1NQSVlydnlJbVU0?=
 =?utf-8?B?MTF4aTFaSFJ2MVNxcTdXWHBJMmJnc001NCtVYUxqWitQcXFqWVJyMHZ0MWFx?=
 =?utf-8?B?NUFBZERMRm5wbHZ0bmNuQWRrNjNtemE1cEhTbGJKMzVOMXFaelZHeFdXMjhS?=
 =?utf-8?B?eDJUajV4MUZBZG5PKzE4VTA3RkNkanU0eWNjMzJJVkFBR2lGZlJ3cEthTnd0?=
 =?utf-8?B?OWhBcFVOSG1aTlU2b3JHUXdDNTFjR3QveWsxckl3cG9ibExSK3N0alRIL0d0?=
 =?utf-8?B?eGh0QktqYVJHaU1keXZJQzhuQWJlY2YrQm9jTTd6SjFlViszSVFVbk1TdXQr?=
 =?utf-8?B?dEpCeFNKYXVOSU5qb2FGZjV6c0FZSjhNUmszUFZCSnlhT21tbVQ1UHQyL1hz?=
 =?utf-8?B?dDVnNlVWS0k1emJ3aVkxYnQzVURaSXhnY3BjZFhhaVNRdmRLL2tyRnZBcU5N?=
 =?utf-8?B?MUxBeC9LRXZyVHBDTU1hUVpLcWIvdzI3TUR5L0hucExlSWRBcGRnQXIyWDF5?=
 =?utf-8?B?bmdac0lFTzFpRzZWTmhidkhJd0lFQ0VKVXJCa0lJQW92TDRJVlQ0c2IvVm4v?=
 =?utf-8?B?MTBRdktsNStubUJCNmxXWk5WV0VKRDZRNXkzWUVkUTRpcnRhZXd5TnBUc1JZ?=
 =?utf-8?B?MzVFSUI2N1cwSzQ1a1VheWJFeUJ2YVZRdk9iZkF1RFo0TFlJa21tdFNBaFdH?=
 =?utf-8?B?SWJDcDVyNEY3TVAxb3o4eUEzWVptVk14aHhZTkdJb0JrWXFpbUNpeWgyR2tT?=
 =?utf-8?B?YWFoMkVweUpLZG42NDQvM2dnVi9zdGVWbElLdm9wMG5NZzVWSlo1dzBKZ1NI?=
 =?utf-8?B?YU5qRFVRM1VDc3RCeFV0V1p4RjVBbjdnaGd1eERKcjVRTElBY2M3dzI5RnJq?=
 =?utf-8?B?NlUrc25PNjFPT3lnOHQyMmlzejcvZVd6MnVpRlpoSlJ0bUNJcUNRVzZUK25P?=
 =?utf-8?Q?w5IRGRBrpjUn1WMYSWpCswA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bf3910-44be-47ab-6cb9-08d9dae9df14
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5145.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 01:20:25.6091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p8/WsuU9pwcsH7NEsC+zJvergw1Hen4uD3ouN2KQQq4/5y+KXxPUxEDNZb2lQ+Dxq2OvsCUAnjAlDr9BMN18aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5900
X-OriginatorOrg: intel.com

Hi Paolo, Matthieu,

On 1/14/22 7:54 AM, Paolo Abeni wrote:
> Hello,
> 
> On Wed, 2022-01-12 at 17:15 -0500, Kishen Maloor wrote:
>> When ADD_ADDR announcements use the port associated with an
>> active subflow, this change ensures that a listening socket is
>> bound to the announced address and port for subsequently
>> receiving MP_JOINs from the remote end. In case there's
>> a recorded lsk bound to that address+port, it is reused.
>> But if a listening socket for this address is already held by the
>> application then no further action is taken.
>>
>> When a listening socket is created, it is stored in
>> struct mptcp_pm_add_entry and released accordingly.
>>
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/203
>>
>> v2: fixed formatting
>>
>> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> 
> should be either:
> 
> """
> <changelog>
> 
> <tags>
> """
> 
> or:
> 
> """
> <tags>
> ---
> <changelog>
> """
> 
> we usually keep the changelog outside the commit message for
> development history before landing on netdev, that is:

Thanks! I shall reflect this change in the related commit messages.

> 
> """
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/203
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
> v2: fixed formatting
> """
> 
>> ---
>>  net/mptcp/pm_netlink.c | 56 ++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 54 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index 779ec9d375f0..e2211f3b8c8c 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -43,6 +43,7 @@ struct mptcp_pm_add_entry {
>>  	struct mptcp_addr_info	addr;
>>  	struct timer_list	add_timer;
>>  	struct mptcp_sock	*sock;
>> +	struct mptcp_local_lsk	*lsk_ref;
>>  	u8			retrans_times;
>>  };
>>  
>> @@ -66,6 +67,10 @@ struct pm_nl_pernet {
>>  #define MPTCP_PM_ADDR_MAX	8
>>  #define ADD_ADDR_RETRANS_MAX	3
>>  
>> +static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
>> +					    struct mptcp_pm_addr_entry *entry,
>> +					    struct socket **lsk);
>> +
>>  static bool addresses_equal(const struct mptcp_addr_info *a,
>>  			    const struct mptcp_addr_info *b, bool use_port)
>>  {
>> @@ -438,7 +443,8 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
>>  }
>>  
>>  static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
>> -				     struct mptcp_pm_addr_entry *entry)
>> +				     struct mptcp_pm_addr_entry *entry,
>> +				     struct mptcp_local_lsk *lsk_ref)
>>  {
>>  	struct mptcp_pm_add_entry *add_entry = NULL;
>>  	struct sock *sk = (struct sock *)msk;
>> @@ -458,6 +464,10 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
>>  	add_entry->addr = entry->addr;
>>  	add_entry->sock = msk;
>>  	add_entry->retrans_times = 0;
>> +	add_entry->lsk_ref = lsk_ref;
>> +
>> +	if (lsk_ref)
>> +		lsk_list_add_ref(lsk_ref);
>>  
>>  	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
>>  	sk_reset_timer(sk, &add_entry->add_timer,
>> @@ -470,8 +480,11 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
>>  {
>>  	struct mptcp_pm_add_entry *entry, *tmp;
>>  	struct sock *sk = (struct sock *)msk;
>> +	struct pm_nl_pernet *pernet;
>>  	LIST_HEAD(free_list);
>>  
>> +	pernet = net_generic(sock_net(sk), pm_nl_pernet_id);
>> +
>>  	pr_debug("msk=%p", msk);
>>  
>>  	spin_lock_bh(&msk->pm.lock);
>> @@ -480,6 +493,8 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
>>  
>>  	list_for_each_entry_safe(entry, tmp, &free_list, list) {
>>  		sk_stop_timer_sync(sk, &entry->add_timer);
>> +		if (entry->lsk_ref)
>> +			lsk_list_release(pernet, entry->lsk_ref);
>>  		kfree(entry);
>>  	}
>>  }
>> @@ -570,13 +585,16 @@ lookup_id_by_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *add
>>  }
>>  
>>  static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
>> +	__must_hold(&msk->pm.lock)
>>  {
>> +	struct mptcp_local_lsk *lsk_ref = NULL;
>>  	struct sock *sk = (struct sock *)msk;
>>  	struct mptcp_pm_addr_entry *local;
>>  	unsigned int add_addr_signal_max;
>>  	unsigned int local_addr_max;
>>  	struct pm_nl_pernet *pernet;
>>  	unsigned int subflows_max;
>> +	struct socket *lsk;
>>  
>>  	pernet = net_generic(sock_net(sk), pm_nl_pernet_id);
>>  
>> @@ -607,12 +625,39 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
>>  		local = select_signal_address(pernet, msk);
>>  
>>  		if (local) {
>> -			if (mptcp_pm_alloc_anno_list(msk, local)) {
>> +			if (!local->addr.port) {
>> +				local->addr.port =
>> +					((struct inet_sock *)inet_sk
>> +					 ((struct sock *)msk))->inet_sport;
>> +
>> +				lsk_ref = lsk_list_find(pernet, &local->addr);
>> +
>> +				if (!lsk_ref) {
>> +					spin_unlock_bh(&msk->pm.lock);
>> +
>> +					mptcp_pm_nl_create_listen_socket(sk, local, &lsk);
>> +
>> +					spin_lock_bh(&msk->pm.lock);
>> +
>> +					if (lsk)
>> +						lsk_ref = lsk_list_add(pernet, &local->addr, lsk);
>> +
>> +					if (lsk && !lsk_ref)
>> +						sock_release(lsk);
> 
> Let's suppose an user-space application listen on 2 different address
> (A, B) and does:
> 
> """
> s1 = socket()
> bind(s1, A)
> listen(s1)
>  // at this point incoming MPTCP connection can be established on s1
>  // and ADD_ADDR sub-options could be sent back 
> 
> s2 = socket()
> bind(s2, B)
> listen(s2)
> """
> 
> If there is a signal endpoint on B, the above listen can race with the 
> mptcp_pm_nl_create_listen_socket() call, leading to hard to track
> startup issues for user-space application.
> 
> I really think we want at list a configuration option, off by default,
> for this feature. Some specific self-test would be a plus.

Looking at your example above, assuming both A and B are bound to the same port
then yes, a race such as you suggest could occur. 

But if you consider bug #203, it arose only because there was no listener in
the application (and unexpectedly so). So if the path manager creates a listener (at the time 
of the address advertisement) to facilitate MPJs then that would have the usual
side effects of creating listeners (in general).

For e.g,. I think this clash could also occur with the existing code in the kernel PM and using a 
port-based endpoint when the app happens to bind a socket to that specific addr+port. 

The other scenario where the path manager needs to always establish a listener is when
running alongside an MPTCP client.

We could certainly add an "attempt to create lsk" option to the ADD_ADDR netlink commands,
as I believe you've both suggested, but perhaps we should think further about the guidance
regarding usage of this option.

For e.g., if creating lsks is not the default behavior, then bug #203 would persist 
unless the entity that issues the ADD_ADDR command exercises this option.

> 
> It will help reviewing, splitting this series in at least 2 chunks:
> * pre-reqs up to ~this patch
> * user-space PM specific stuff
> 
> Side note: it would be nice reducing the level of intentation, e.g.
> factoring-out part of the inner code in some helper.
> 
>> +				}
>> +
>> +				local->addr.port = 0;
>> +			}
>> +
>> +			if (mptcp_pm_alloc_anno_list(msk, local, lsk_ref)) {
>>  				__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
>>  				msk->pm.add_addr_signaled++;
>>  				mptcp_pm_announce_addr(msk, &local->addr, false);
>>  				mptcp_pm_nl_addr_send_ack(msk);
>>  			}
>> +
>> +			if (lsk_ref)
>> +				lsk_list_release(pernet, lsk_ref);
> 
> Probaly not very relevant, but something alike:
> 
> 	rcu_read_lock()
> 	lsk_ref = __lsk_list_find();
> 	if (lst_ref)
> 		if (mptcp_pm_alloc_anno_list(...)
> 	rcu_read_unlock()
> 
> would save a pair of possibly contended atomic operations in the common
> case.
> 
> Thanks!
> 
> Paolo
> 

