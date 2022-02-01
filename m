Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36CA2F27
	for <mptcp@lists.linux.dev>; Tue,  1 Feb 2022 21:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643750387; x=1675286387;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=B0aAdSDIlz0WJBvwCLBgeIc70RJgMEIkNCuYa2fqFXg=;
  b=T2+CxXgLjqp+eSi3fniEav/K1uaMOD2EWlIq/5Bx0+t+ytgrZWIdZkWT
   L09ZG+IpiOP3n5J79TNlJkXKmV+YEZZ8pb52BJse0xT3k+hxDYqEi1BDp
   6vK147/3cjcQm30DL/xdHoJ6kO20oKWXSCyVbHMOW/sgTVG9G8FWJQSXl
   BFcqxJHlBadrCBIMSaQF6XwJ0fLxnZIEDGRU29XkUeZkdmKtbbLxAEI0q
   ioqUWah9XEJZIrQQvHK85NGrVgxtf17DhOPSjK2rqBth5xgIVKduXu045
   M+tiSPL6y+SXfp1LdOkmV5HvocQnJWifIjZEJxx+i/EUgrch4RuTbI2vk
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="235192411"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="235192411"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 13:19:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="497495397"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga002.jf.intel.com with ESMTP; 01 Feb 2022 13:19:47 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 1 Feb 2022 13:19:46 -0800
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 1 Feb 2022 13:19:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 1 Feb 2022 13:19:46 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 1 Feb 2022 13:19:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkHvVAl1uiRRcZjtQ/JwLsG4IyLvvfDLmp4VUaMLaHl7QciBhxFRCDoRHDiLTHDMKsrUOLl5nJp4ynmhKINOkVdWs+tCThnLD+KDnxZkYxigjZmhQV+7HKwpNb+IgwI7WZyK15+/Adzto42dRXyPQf4Byd/IesKDGV9ekdc+voeDDUQjymYgAANy9PTLAGQW6MBmpuKFYqoYW60jnMG2Ysa5OBx4YIsfdWoeKazrysNHspF9XnmGZ7GWJrVZCMMvqMYj9Q71PHGfbK3lnDpAn0BP2z+qwuCKLAFzl+cwfiPSJiYkM8pyXrtcHckfiygqsl62422BFEyUMH9Sb4L8MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLZetLNMxwA0AvQjlFKJ/+Oyja6KFet9YBbwAop9mjM=;
 b=MLTgjxdIeklwWm/Odazc2rJEKtUgReZTa+KCR3gnlCcTSdZail6YjvXIGjTIC2rIMlVL1BvyadlnQSBL7S1+O0XEiFVtJkE8oQyTsuyYlo9fLwPhtoLC6JS0qPs1JJDpQPVoH+Ydh4UySUSV/Ymjn0eaD3+rnv1dVrya3pz7aujMC9bgpl7ZkDTpD31N2/WWxd96530UPsWdopZ5hhfvhxjjNYs5aWlMazYEfItuakn7PQ0P+CHUdRqY7HDgCaFdNFecgEq3lmY1SR8ShCRPDGm9zq/XiXcvW3IngYsGnv1hpJ1GYTO85xDaadL1IY0Z8g+NfEKWXlg/EhlsZ11zZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
 by MN2PR11MB4399.namprd11.prod.outlook.com (2603:10b6:208:17b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Tue, 1 Feb
 2022 21:19:44 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::44ba:c91c:ea6c:118d]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::44ba:c91c:ea6c:118d%4]) with mapi id 15.20.4951.012; Tue, 1 Feb 2022
 21:19:44 +0000
Message-ID: <ef8fb4a3-2005-92af-1d13-393254d7c60e@intel.com>
Date: Tue, 1 Feb 2022 13:19:41 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-next v3 6/8] mptcp: netlink: store lsk ref in
 mptcp_pm_addr_entry
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, <mptcp@lists.linux.dev>
References: <20220128003812.2732609-1-kishen.maloor@intel.com>
 <20220128003812.2732609-7-kishen.maloor@intel.com>
 <95b6d470ba9cda9da853ff1f4f649f597934ca9c.camel@redhat.com>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <95b6d470ba9cda9da853ff1f4f649f597934ca9c.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR05CA0070.namprd05.prod.outlook.com
 (2603:10b6:102:2::38) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:9e::21)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 796caca6-f050-4160-689b-08d9e5c8910a
X-MS-TrafficTypeDiagnostic: MN2PR11MB4399:EE_
X-Microsoft-Antispam-PRVS: <MN2PR11MB4399AFDA60FE050F9B69482EE1269@MN2PR11MB4399.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l1gJe1cKdicIMvCqbcVnOOcgQzA8BcW/g8cZxNuKmGjFRZAjTOB+M20GWpwVkTyLvaOLQJeUZrO6c0+EtmhCmmvH19slN36dZ4DZihkTeCZka9ndBBz+TWywdZVzxHcHfpMEV0GrO2lO/GIvffr+Zf73V1w0ZP5S0gh4wj7J8++tzeFdtr/0nULk8ScEnTBik/GpSj53L9GuEwLd+v2jrhdZqBWxrqpz1MewHZZqHu7aWMv29yKnefsbANk0RUmGxt+nfMLu17ZH6cy7zgnX+zLaliXLiroQMtFe1FcnDNyxdpImSoVknsw0qquoM8Ebu5HWawYGybnT6aDA844fEiyo1txuqI7dfTXPPbxj3QFo9RBnY8bhGx+G+kV07dFoShwOl6pWW7w2TnYoDXOuByOq5ysqZRSonJiFQgkdQUsr3hI+BuH9AgBXe6KRtwjwOc9CQki6SGLwM4XTpyXrH+ZewO96Ztt6+aaj+LTMvAg8nAcQiEtdejxsufbulU5F/hiBbPRW4+uuCCbmpU4buL7S18vDBeFVX2pOyGZjpfDWmgp0hSMQ8Rq7gG7E7bcKtu3ypfd1kGQLAtDbP6rfVrgnZoDJv2UwbSuxJr9dNN2ApmlzCiOvay6jocD8ABtDNDaCKfnWqA+/rbRxtEHInMD0c5c2J1vbjDlBUd+DDmYRLBgZqmN5cexhfI4RtyJpn4bEnbNRk43U8MufslhbgbLJI42sewtJ/0f17zZs+3w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(66946007)(6506007)(8936002)(186003)(66556008)(6512007)(8676002)(66476007)(31686004)(36756003)(53546011)(6666004)(316002)(2616005)(38100700002)(82960400001)(508600001)(31696002)(86362001)(6486002)(5660300002)(2906002)(44832011)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UElZN2ttaVRZNWxqNU42dkhKYWdWajRvTHdPcyswVE5uV0xqVnk3V2I1elBN?=
 =?utf-8?B?bVZpNHZlSXZKZ0hSbzVSWXd2TzZXNDhLa21oNFZFWlovb3d1QjdYNWQ2djhB?=
 =?utf-8?B?OU9ST0grRU9zZTFUUkRHdDR0Ukd1bmRrclNtUjFJZS9Ea0NrcllnSlRwU0Rp?=
 =?utf-8?B?THg2TVVtL1BZc1dodEY3b2djcGRQMDFkVWhBZGRrQTNWK2Z6MVJSMlY1NkhQ?=
 =?utf-8?B?UXJKR0ZJWnZ1bmdLVGg2bHNxV2M0THpEcUpRNWVJZFNIdXRvK3lua08vWG5z?=
 =?utf-8?B?K3BiTm13YmRTNHRha3drRzJjdVB2aVJWL3pFcG1TakljbmMweWtLQmRuV3NQ?=
 =?utf-8?B?TGJ4a3VVb2YyK0ZHcVNGbk9LdC9oZFFNNURNalFIb05LbitBTTVRd2R1ZTk0?=
 =?utf-8?B?R0E5UXg2Mlp5dGNEcmQ0MVpzOEkxWmhwaVR1WXBGWExqdGtrZXFDOFdxYVVy?=
 =?utf-8?B?NHNBQ2d3UCtkU3BBWkJ1S1JSU3htU2lPN2dRUjVNYURHT1hlOTJwRXRLZjFn?=
 =?utf-8?B?bC9xaVp2Z3lqZml5K0ZiTC9uMWM1RWVVbXFTU3VkRmtCdFd4NzVETWRTNUJS?=
 =?utf-8?B?ZU8wVFcwbnZaSFQxdStGYU5ianlHbWt6ejRUZ0VEcWpzNi9zQnY1SFdPc2lO?=
 =?utf-8?B?OCs2SFl6UTN1R0NPSHFXeGh5V0ZNTXZGU01GUG95cXJzUDFhNEJvaUJUaFN5?=
 =?utf-8?B?UHdxekFVNDFDQzR6c2F2NWIzZ21nTnhvNGx0MDh5Wmt3bnpSTGVTKzJ0UWhN?=
 =?utf-8?B?dW5yaFVQVjEwYmlNdEtoa01ZaXVrZEd5KzVaSU8zQURmNkovdjdORVJEa0t4?=
 =?utf-8?B?ODhqeUd0bjBXMWd2YjY0ZmJWdVZWRlJvL1h1MlNuNWhicHRQZlhTOWIzL0Yv?=
 =?utf-8?B?T2N2ZGhnb3NLQnpFTlFhVkwvcUJSK2x2UHNqU1Faa2drTzBmOVFPM0htUGo0?=
 =?utf-8?B?TnFLYS9mWG1WSEM1VzhKMG5jNWNUS2cyTVN4eFhSZ0FzNW9lNUVHZzFWMEdD?=
 =?utf-8?B?TmFLcFN3YmVwVlV2N1MvMFdnMkRjeDNpam15c0JLMHdyamVqM3RCaG1ZTk53?=
 =?utf-8?B?THFOMHg2R0hWZWJkdkluQjAzWGdqdjJqSEc3d0FVUXM4MXlhQVhlWjR1d1FK?=
 =?utf-8?B?d293OUZ0ZC84Ujh5N1VjSlp1bmF0RjVVT1dYVVpHYS9tT2IvUzdwcEN4V2FE?=
 =?utf-8?B?QndLRFZCNlI5UUt4RnE4SG0yT2l1SDlKdUlmRUN1UXVZVllNcm1CWFN6dktR?=
 =?utf-8?B?Z2x6Q1I2bm9JaldlL1h0Q25EdUlVVys4ejljQUNndXpIbWdtSU5ZbmRpYlBD?=
 =?utf-8?B?akVNTU4rcjVoTERyMWNPV3BDYzFETWZmdG1Nc3RwZVcvTVFNL3g0MlJpU1Jh?=
 =?utf-8?B?OFBmZGJzV3pFZFlFYTExUUxDazJiSnpxYW9LOXRnRXFTS1puVkdJeDZxczk2?=
 =?utf-8?B?MzJMN1oySDl2VjM1T1AydWkxYkpFRjYzYU51Ump0WVJreFNnaG5Gb1hEY3BX?=
 =?utf-8?B?anEvMWVrNmZCZTB0VndaU0FtYzIvUFFpTkU5YjkxV3NnRzJGY2RWNjFmaGgx?=
 =?utf-8?B?U2p4Z2ZyakNmNFVCUnI2Q1lwOS9zWHQrMzZJazVMRFFXRmRaU1J6UTdzSHNl?=
 =?utf-8?B?TnJiSU04VXlCYmFVK0lBTWlmaE9ZeVJGanp1aE1hdEpmRUlwd0F2MWRTZkc1?=
 =?utf-8?B?VUNJWmRjeVV4eGh6U1hRem5HdXhPa0NSR3VKOEExL0lsR1FDNytHWVBHTE56?=
 =?utf-8?B?RlFFbTdPbEVrVVRtZ1hZcnVRSEhORXNOelZYcG40aXVROHJZYys4SkFubjdC?=
 =?utf-8?B?d3lPbzB0cHcxMkJGZWVGOFU3VlZqbXNZNDVERFR6WlpGcEdDRzNIUXBEem9V?=
 =?utf-8?B?L2pza3dFaVhaSEErNExCMk1EOEI5RWZ1Rm56UmJTUE9OaEdSd0hlYTNVL0lZ?=
 =?utf-8?B?Y2hvZy9oSGZ2ZkVPOHgzMmZVcXEvbFdtelpKVDhINEREZkRYbFFzcWk1djdR?=
 =?utf-8?B?VWFMU3FlM1NBZnRTNXpuTUJmMkxPRXREWVBpWHJLMU9NbWV5QnhzOFE4STJB?=
 =?utf-8?B?UlR2Vi9nOFVzem1PUDFYcnFycUV5UTNEVUFaYVRVQlVDRGtXaGw2bTNVQzBa?=
 =?utf-8?B?Zkk0M040MTJLZ2FZWUVoODZRdnk0REM4TFNpL3dsMmltZ0QyVGRnVHVLWVVO?=
 =?utf-8?Q?bePbrOx37Wp12aqjn+y6sLs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 796caca6-f050-4160-689b-08d9e5c8910a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 21:19:44.0952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cgxs++3kYedNycE8Z3eQyUI2CBlOquGCc0G0EF+d+cxbEVCxvWOhDoSfcrabKFgjHq6zOPXbH+PJot8K+yRkLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4399
X-OriginatorOrg: intel.com

On 2/1/22 3:31 AM, Paolo Abeni wrote:
> Hello,
> 
> On Thu, 2022-01-27 at 19:38 -0500, Kishen Maloor wrote:
>> @@ -157,6 +157,33 @@ static void lsk_list_release(struct pm_nl_pernet *pernet,
>>  	}
>>  }
>>  
>> +static struct mptcp_local_lsk *lsk_list_find_or_create(struct net *net,
>> +						       struct pm_nl_pernet *pernet,
>> +						       struct mptcp_pm_addr_entry *entry,
>> +						       int *createlsk_err)
>> +{
>> +	struct mptcp_local_lsk *lsk_ref;
>> +	struct socket *lsk;
>> +	int err;
>> +
>> +	lsk_ref = lsk_list_find(pernet, &entry->addr);
>> +
>> +	if (!lsk_ref) {
>> +		err = mptcp_pm_nl_create_listen_socket(net, entry, &lsk);
> 
> What happens if multiple cores call 'lsk_list_find_or_create'
> simultaneously? Is that possible/expected?
> 

That is technically possible, yes.

> I think the expected behaviour in that scenario is creating a single
> new lsk, and have all the callers fetching such instances. If the race
> happens on mptcp_pm_nl_create_listen_socket() it looks like only one
> caller will get a valid lsk reference, all the others will get back an
> error.
> 

That's right, there will be at most one socket created per addr+port.
I think there shouldn't be a problem with simultaneous calls for
different addresses.

But for a scenario where the simultaneous calls refer to the same addr+port,
I could (as you suggest below) add another lsk_list_find() following a failed
lsk_list_find_or_create() to then either a) obtain a lsk_ref to a
recently created lsk (by the parallel call), or b) fail more definitively.

> Possibly calling again lsk_list_find() in case of failure could address
> the above.
> 
> If the race is not possible, it should be at least documented in a
> comment why it can't happen.
> 
> Side note: using:
> 
> 	if (lsk_ref)
> 		return lsk_ref;
> 
> instead of:
> 	if (!lsk_ref) { //...
> 
> will reduce the indentation level.
> 
> /P
> 

