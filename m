Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEB920E7
	for <mptcp@lists.linux.dev>; Thu,  7 Apr 2022 01:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649296705; x=1680832705;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=AyDhtycM0J+3qhFwiqSiZ5wRcLpkCSJDWjqiyUHAJn4=;
  b=nEKer9Trfhlx3MTlJGsh7RGF0KledEX/f18ZQB9QP0sLnzGnPWeNaMGF
   Usk7I61WWcfT85M7SGVwC9j8umNurgFlzb23OQa2S6dbeFjQes82YoI1x
   hdw9QO8tECLzK8okYTIwngWoqWGC3TulZBsOM1LPU+FSVzJIbUq0WNJpw
   iNhoKtX+r6t2DgxmoTzDET3R9tm08B6Z1kd2X6um0ha0naiyw70oN2Vd7
   FOUTAbgtTubvoMu+O0DXQ3KQLzk0o4exmh3mbQtbjylF4jWCua1P6U4CO
   0b07aDZexVB+9OfOJ7kjwT6gtZgfOyfD3ojVwlZ2QCphK4By2PgRNrpoR
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="261197048"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="261197048"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 18:58:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="588612470"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 06 Apr 2022 18:58:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Apr 2022 18:58:24 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Apr 2022 18:58:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 6 Apr 2022 18:58:23 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 6 Apr 2022 18:58:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WG64oxdyopTtc/FB9/vzgO2XDse8Y3jqRpZCV9u80ezGuH7xx5MUqjywj2qQckmpXDyFJWOO2FywqtHXGvBvzWuoKEQjHqGZ8WCifrjh2WiYpNBoEI8xeXEGwUYYo8b6dJFdNG+JjQRELOGVB6VrxB5E/VSnjQaeHfXdKDj6SqBjCUuBJSHzlmhccNTRmoUi4DcjWsuQJf9p0AQiZYg5DqF2wkYondZLT3UnUg3Ul9LrnlZmKe+v6o0ozA0Br2NRBwoap6mzbhxN03deh7YVjyX71dtfmGRU/g8/L239QWL5e7j1CcfCK0RKFayyiRJ9aibMPfp0pF2JKEwrY67qjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAGrC+S/EljJLpRGuIbBGVNIo1mfH6GivkZha6btZk8=;
 b=Eah+MbBBYRax1OtjWeVUt4fc7plS2Mepko2CoxY1ue8QELUG47d298TgPQgfqJc1JE3zWFluCHsXGsXqPHbRwlWLY/L8CujCn0X9lVS6s9CO/qo/uwhzUsHnx8dVxGLZcjCGhLWP4uOQTJzJsnvMFQKF16QdwFqO5d5JMQCG5x4oWIpnZ0Spc2w1KwHyopL3b2X5LTMzOyIhRpvv2pad/x3+4YLUBpwSRKl8w59q4MJ4VdCHUaV0Ew60xCAiQBuniC0p2RIoSq4mJ1rlF5B/d6oe5duFlAN2nKJ9EX+sOd+a7xO814GFwtzjlOpWJ7bwhWLnXL8AHKHj4eTF5VaXVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
 by CH0PR11MB5738.namprd11.prod.outlook.com (2603:10b6:610:113::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 01:58:03 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::99:140:4781:f4d6]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::99:140:4781:f4d6%7]) with mapi id 15.20.5144.019; Thu, 7 Apr 2022
 01:58:03 +0000
Message-ID: <7d2e5716-1507-d7eb-72df-baac56cf71c4@intel.com>
Date: Wed, 6 Apr 2022 18:58:01 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH mptcp-next v6 03/14] mptcp: read attributes of addr
 entries managed by userspace PMs
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, <mptcp@lists.linux.dev>
References: <20220329021437.1196552-1-kishen.maloor@intel.com>
 <20220329021437.1196552-4-kishen.maloor@intel.com>
 <c71821482e4eefe5a5f6067f38192e95bd834ba8.camel@redhat.com>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <c71821482e4eefe5a5f6067f38192e95bd834ba8.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0146.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::31) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:9e::21)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2211c23e-61d8-4916-6bc2-08da183a0d2c
X-MS-TrafficTypeDiagnostic: CH0PR11MB5738:EE_
X-Microsoft-Antispam-PRVS: <CH0PR11MB5738AEC04C7701F208597208E1E69@CH0PR11MB5738.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MzS+v1++xv6IoseavGCeGmoaSX2rwVjGXBUrKs+yZ9+FTvdM6JxVJPxVHkQl1EnibPiePJaSkutG+RMd9H9cizHQZ3HUVlqV6qE1CG55GYLHlirNpnYH8oTZkxFm/MluIPSSiy9Z/VLnzJuCFyn1y6OYEK2n2bbDWQDT6tZswG+LtaKwkhzdLYiF6sqjKuYGdLK2r8ImNQS7/Jsg4OVcVd9q/e3wVPFWPwYck3ATVQuumcRAvHu36ht/YUznarWW3sg7qDcNuDCYWcnDqfgUGZOH7NXY0PFUUQH0b1lD06vPfc72+VeUAJPyaR41fKUbr2PSX3xnvZcYUh6rU+WIX2MlRfRqtyZWkYA/FZBxFQRU7UnvX3412kf1WTNyIAQse0k/Q2tDYTEXRpCfWqnIqNQPKkgVepy81GtT4nN2fvf/1ZuQuaMjKPq37vj92X8GGwwMWMZo33ttcYMFqAZeofDjD1HzNQPsYPFCTd9HhM6RjEQmpGMEgVan4ipj6HcxS7TNw7YXZMOh+7B9lR3bDxmtp/HLwaaqKR+YHiVDiNrieY1RvBXER0jWv18KWYSQFuRZUZnPq0G2sz5NvrpJXc7p3U2dSb0ei2e5yfy+4cBz0lAFAGTZUvRQ/+IQVuyJ/48JHmYrUExJX6AgPehWnJTLFQKslRArxZGwCS0oumblfCiJ84jkmVix4+PhFcT/gba8qJ9TY/1OYGXncX4utsEPA/fobA2wGY3Dkw3Gzo4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(66946007)(316002)(86362001)(66476007)(66556008)(31696002)(38100700002)(508600001)(6486002)(6512007)(186003)(26005)(82960400001)(53546011)(6506007)(2616005)(5660300002)(36756003)(8936002)(4744005)(44832011)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2JiWGxSN2hGcXo2cXd0UkVKK3d6Tkh3WFNHbWxNOUVORzVheTZoMm5qQXY0?=
 =?utf-8?B?OHZ1YzdBWE5BVFM3T3FDQlJIWGtLWW9vVFhXaFpyWjZsTnBLOTRPOUpUUTlx?=
 =?utf-8?B?cUtRTnkySHBwWTFKT2ZxVDJKamNIcnYxNUQyOUZ1RVZQdFp3V3o5Q3JKTStv?=
 =?utf-8?B?MTg1Q1dSZlNZQStlOWxwRENTRzJrbG5zTXY4bVJmbUlFUERxbXA2eEpuM0Jk?=
 =?utf-8?B?NnFod0hOSTMrdy8wQzJxUE9YOS9nU3ZMQmlVc0RSVU11QThvdCsvYkZCSThx?=
 =?utf-8?B?VWlkem5yazFuNzNzMTZ2Ulg5RDBEbkpjOVVEaEV0MFhGT1htMWs2UGNhNzdk?=
 =?utf-8?B?SHBqeFpSQVF4WkYvMFlBVVJ0M2xjYUo5KzMvVUh0OGMwbFNDREV2bzhpUWpV?=
 =?utf-8?B?WE02R0JpRDZjT2NXd3p1N1lFLzcwdmFMUVhxQzRJNkxGczFYVTZYdDRQTzJw?=
 =?utf-8?B?Q0V5TmJIWWJtNXJkc0xUY08yN2VxSFppQkJxcXB1am5JWm1tcVlwb3dCK3Zv?=
 =?utf-8?B?V212MkViU3JuWFJFWGptZld0Z3JIbFRZN1RieTR2L0FMS0p0Uk9TSGRwOG91?=
 =?utf-8?B?em0vSCtDR3NNMDB5VllFZVVKMDlVNlJCRW00NktGTEQvVDJpT1d2VUtxQkZn?=
 =?utf-8?B?VE5EUFZyNklhdXdMOXdMNHczVWpVYjlFcGtPUmZoTmpCMGRNR2FnN0VIblpl?=
 =?utf-8?B?WVpOMld3UGdZREt3N3FpMTBUVmxoZm1HR3hkMFBkakgrWWlyMUFObklrTjJ0?=
 =?utf-8?B?T0RiWkVQdkY0SUVtYmJtREY5dUFWdkhUVDlMS1dnR0JkSkJQVEptSkRydEc0?=
 =?utf-8?B?cElRMUZBbkNPbEFoYlFCZGgzMkVGdWF3VW9KdzQ0aE5LREp6Z3ZlRC9lcEF2?=
 =?utf-8?B?bVM4WkRtWWhuaGhRVTU2Q3JUNlBUVFRkaUo4K1JuNE5UeWtod3FhZEtieTdj?=
 =?utf-8?B?dCtvMHgwMGdhenZqMm1SYkpFb0FxOVhLbmduT3ZZQ093SHdCdnJaRWNrd3BW?=
 =?utf-8?B?TC9idkh2bFRkay84QmVrdkZjN1BpR3Y4V2VEUnZseWl6RmN1K2Z1VUFWWG80?=
 =?utf-8?B?Q21KVlRiZHphK3VsVWUvSGxNU1J3NEhDTExBWVJxaDNXMjlZbTJSZ1E3OWxX?=
 =?utf-8?B?SkF6VS90YTNmR2k4elFTaXVwcW93YXNpejNHL2NQRThLSDUrdTRRU0RHQ0cw?=
 =?utf-8?B?aG1XdkUrTnVDMytLNEh6Q0wrcDVIZEhlT3JzOE5uR05oc2tHZTNLVnlzRUl6?=
 =?utf-8?B?Z0E2OUJNcWpoWWJXQy9TVmlMSjRacFNPaVBpSlJmaytpdm9QUlM0WURaYmUr?=
 =?utf-8?B?cFBhd1IrSi80R3ZtNXhvL20wNCtDSnh0K2hUSTI1WVhVSTB6clBMUTQ1YWpP?=
 =?utf-8?B?NE9LVjhvcXJuWHd2eHdldXN0S0MwYXRMSXdVbHBaTFRoOGpVQUU4V3R2RFNh?=
 =?utf-8?B?dHp0M3ZndnM2aHl2cDl1MHAzK2hpZVQyZmdOejU1WkJhbnczZzVNenlJajFx?=
 =?utf-8?B?M0FzajN6dnVOay9oRlNMbU1ZejRtWStLdHJFekwvMlpRU2FsaG1hSUd3VzEv?=
 =?utf-8?B?aUpsY3RnQ1Z5UCtyaVFIUjhMVXkwZ0hMY3c2TE8yLy9uVldHMFM5TDlUSVpT?=
 =?utf-8?B?WnJaTUFKaW12VmZnRFBIMUxJOWpqK3E2OFJtcXk0eDdaWFZtVFlTZ1dXNVpa?=
 =?utf-8?B?NkxMcVlnb0Q4N2E5cENYZ3ZJN0w5clJHN3RsTE8vRzQ5SHhhTnl6cXFINGJT?=
 =?utf-8?B?TU1CY1JZV2ZERCsxbzVjSUZ3L25PNWI5YTZCL29RZ1FnNm4yRVI2QTQ2WEFV?=
 =?utf-8?B?em5ZSlRxb3lBV3VmVWcvNFA4RGtKeTY0SFAySDUxWW1wcVpTWlNLM0JScGQy?=
 =?utf-8?B?WUVvYktZMU8veksvcHo4dlk1VWFuNUhTQXVZenUvZnVPUXBKZkpFUXBHSmZF?=
 =?utf-8?B?RFp0a09hMFVJTFozQXcwcUJDVHBaNTd1UUJmbUdWQXlyMXBlVnpQU0ptS3JH?=
 =?utf-8?B?ejBDcXd5enlORHM2MkVJOU1wRjFxakJpekI4RFBaVTBCMXhMRHRLUkgvb0dT?=
 =?utf-8?B?TWxVblBoUk14N2s2UkhYMk5OSUNENTVmNmFaVFJFZGtJMGlYZ2V4TThpUG9w?=
 =?utf-8?B?QytJek5rNFZ2bkd4dHVIS04zcVU3OWc3NlJ0cC9zbi8zMW5rRTFUaDdkMDVm?=
 =?utf-8?B?K3hRaWZxeGZZcHExK1RaelRaNnRQcXM3Q0h2ODNRNlAwcEYranhSLytEWEF0?=
 =?utf-8?B?SmpIbytaM0NYVE1FVE4vU0d1elZCLzBGNlB3Z0FUdnVlQW1kWFFhQlcwZlgx?=
 =?utf-8?B?TEdsUDlCUjFOTGU2SzNqWTRkMHRUN09yczNlMXpackN5UEdYcjNGUGhobkJ2?=
 =?utf-8?Q?IFBY8PHTIIvVH3Cs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2211c23e-61d8-4916-6bc2-08da183a0d2c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 01:58:03.5982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7SD0JmL/C+yj2Jw94NSQAA8lhzHvDZfDrvEsFFrld6xLHZANUaUX05WlTV04tIpcxR4kT9vGkD0tL9bv0EKuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5738
X-OriginatorOrg: intel.com

On 4/1/22 8:03 AM, Paolo Abeni wrote:
> On Mon, 2022-03-28 at 22:14 -0400, Kishen Maloor wrote:
>> This change introduces a parallel path in the kernel for retrieving
>> the local id, flags, if_index for an addr entry in the context of
>> an MPTCP connection that's being managed by a userspace PM. The
>> userspace and in-kernel PM modes deviate in their procedures for
>> obtaining this information.
> 
> I'm sorry, but I was not able to give feedback earlier. I really think
> it would be better do the 'if (mptcp_pm_is_kernel(msk))' in a thin
> layer, and add the new code into pm_userspace.c
> 
> e.g. this patch has a relatively large diffstat because quite a bit of
> existing code is just re-indented, with the proposed schema that will
> be avoided.

I have moved code from the 2 functions that had explicit in-kernel vs
userspace PM branches into matching functions inside pm_userspace.c.
Hopefully that makes it cleaner.

> 
> Thanks!
> 
> Paolo
> 

