Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCAA2F35
	for <mptcp@lists.linux.dev>; Tue,  8 Mar 2022 23:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646780460; x=1678316460;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BgUD+8qGfPnT5yT+Gnbe0loZEWS8KMiltiSjBkyYtmw=;
  b=Arzidv9rVVv1AQIF+voH5DbcYm3MUNVYHBG1QGr11wN5g5TmFvzsQZjx
   UP9g/Tguwpe3WOnqIB2MNitcb4/mjcT5xTdSIEv8tUNaIh52NLfgSzoD0
   uULN5rTMBdHQQla8LzxorOfMRxcF6UhrDBhE2vV+xXhMLZZ09y43G8DHD
   d+JuSAKYBiFdMn6Pe2Gp58zH93yegRnWrS6d9bLF0MB2BovCpGcZJ4V1M
   om0cqBRxcSbmF5PAYN4PZqHxMe9Hzhn5QGC/ReqaojWI5S3wcaTzL/Eo+
   P0urzFeiGLyT+XvWyHdrkDUGiAuW7CKmkyQufwUVEUeqFcx8yoAKMSUem
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="242278452"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="242278452"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 15:01:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="553835572"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 08 Mar 2022 15:01:00 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 15:00:59 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 15:00:59 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 8 Mar 2022 15:00:59 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Tue, 8 Mar 2022 15:00:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezu8VHn7xP6x2o0ssGM5LaMHgMCWNLOdkBhAa6TrR2Prh2sUee5EZ8ACY+zb65c9W7bp9XcRUCgWLcq+uGV/TnLr53FSXm8gUqucg+65zjgOohN/P3B1t2XwL806qT2CVPuLYRJ3xUmToRwyirBWz8kHya+nz3ENNyugPOrxlA+KKyJQQVgUnfrc4a4K/ExGv/Dr05HEL8X5wH/DBBnEuFSr7MhSKJLIimKYJglH+S4eKi8At6IkTjI5wtF1veX5F0wHeC+jmkUOHsNqEYnhGEK36cQql9blZatAH+Rv+ZsmQOpifQS/jVcxvKvAZLDEcPU/xpl1bB+oacjR4Gdwkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUtb6z3nqklo2co4PUbfOtFDHP90FpIg02FArRuN2Tg=;
 b=JXVS1gMrHn+YNHQFvqTflIEVqTDYLBOn6h1+EPoGQWq89KUMaMjZ/StrMOgUQyalrGPr//3Q2K9gKrf9eR34QauDCNiMiCRsz3Xqz/8Xqu3kbH/xFGn6iqw6UYjM2SQCNaDwtfCfiXBQ5/5hHedGIwSqCUhu93QLfrXfEXymDnm078JN7UJrkYRgSUQR3+UHJGTuMF0/RboGISsTYZyiSKLsnfHXlGEneB/wl7qIqVj9N7tP0rRa6RwaG5MdzAaYYgryUvw35vbsHdjyQOYBRgD7OIkCiLoeUPLOKpOrSDTgwstfx631L+I1hoXuwBUEcQuAPTwmfMx/6QjmSK0SvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
 by BYAPR11MB3349.namprd11.prod.outlook.com (2603:10b6:a03:1c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Tue, 8 Mar
 2022 23:00:56 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::44ba:c91c:ea6c:118d]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::44ba:c91c:ea6c:118d%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 23:00:56 +0000
Message-ID: <d796fef2-d380-c92a-7516-617992a20460@intel.com>
Date: Tue, 8 Mar 2022 15:00:53 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next 3/4] mptcp: handle join requests via pernet
 listen socket
Content-Language: en-US
To: Florian Westphal <fw@strlen.de>
CC: <mptcp@lists.linux.dev>
References: <20220224155010.23676-1-fw@strlen.de>
 <20220224155010.23676-4-fw@strlen.de>
 <ab1f9296-3637-d13a-bfe3-97183f593190@intel.com>
 <20220308184531.GA22024@breakpoint.cc>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <20220308184531.GA22024@breakpoint.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0130.namprd04.prod.outlook.com
 (2603:10b6:104:7::32) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:9e::21)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c12cee10-343e-4cc5-9dc5-08da015780b2
X-MS-TrafficTypeDiagnostic: BYAPR11MB3349:EE_
X-Microsoft-Antispam-PRVS: <BYAPR11MB3349F9D0EBD152745FD977E1E1099@BYAPR11MB3349.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7phMyrp4MqME5K4/sWWh1ohy1Wd6W8r8Dnppues/yI+/HvwRyTSZ4hCubknxfgOmjbfiEh+UgvWHOpdhsl5KJ+hS7baleKkPuJx0tYIhw2HziH35+9owhKmo5A/tiHp9wAtTI9m5yKtYUxc00vA+E6BTKAvVDOO36RqO8UgebVIimFGVOidB4RlmBNO2zJZaqLFtaXecZ4vMVR2QtSS9VB5nlXP8OGJ1kjE+mCCGkg4aZQrur0wq1PR84rMqH6rs1i0A4hR3t07xKyGOr6CWiCX8RRywohOZ1v6hyYmMLngQ98csGdw3V8DodAI/+3kkVVgQjyGIcRoYZrVO2t6vABJsX4JjUG/eCesXuGrgPYYb9lg9nOO9FI86AsPyh2U9jbSsc8oe5kaK/pP1unHLn2R8dVvILjyYalOuCyYIVzcc6tbGnHg5wDXBL/mAmjwIddFLmg2WD1w7kRewqWXhEHWyvKpqxW/sj8FzMkLf5kuTNgpU/G3+ASNJlYZsg9KIm4gBcnE9cVuUHJ/+LQXnh+xkrliMQ/Dpi1PMpLVocd/fCzFxlONRJ4FMt2nRfhCT6N2CzVOcv7RUzheauxETPdjdejcBlXt6xqPaKcOt8DB56YmpF7KKE8DniAg7+oJxLNlk8RoifUVYBc71B4TfM8OIRk06N1WHL/MG+bIAK86TSGFTcMi9u2HhyZtKLqQnxLeajba3qzpG9DXSCcNlH74xQd2x6z6+r0X3Zvcyi+Ia9TqrVXYcPtvd8Ky85Z9T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(44832011)(5660300002)(66946007)(66476007)(66556008)(8676002)(83380400001)(26005)(4326008)(316002)(36756003)(6916009)(8936002)(38100700002)(31686004)(508600001)(6486002)(86362001)(31696002)(2906002)(82960400001)(6506007)(6512007)(53546011)(6666004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG1FV1YrdmVMKzBqN2IvVHZWODFsc2dSMkZGNWtYVHBWOFlJeHVhNXFQT2U3?=
 =?utf-8?B?d3NLTlN2WkJGWjhISElGbFRFWjlZV0VDQ2trYThBeGZrY2JhWDI2S2kxVkQ3?=
 =?utf-8?B?cjNCSEUyL296TjRjSUhMSU1IL0RaeTUwOWVsYXdjV3BjYjF1elplTXIwOVZ6?=
 =?utf-8?B?bUd5L25ldlBxZXlxdEVPaFF2Mi9ja1ZzTXZHSCtVMldiN09Ha3d4ekdJMUJN?=
 =?utf-8?B?dHc4TlpreTViM3p5Z3lCZGczWTVrVDY2V1JNMkRRUmZzR2pNZGN0K2hNUlk5?=
 =?utf-8?B?UGpyMldVN1ozT2t3cEJhRVVkY2VpLytyYUs1UGRwL3F0OFhHWlJNbmVOa00w?=
 =?utf-8?B?dG9BLzlKTTJKbnRCQUJMTHBZL0Vzb25LYmR2OExHbUVIVWZQa1BvVTU4cVVY?=
 =?utf-8?B?ZXROZHNpN1U2T3VpRHIrQlc1bU9sdnZxblpQUGQrNkhZL0FvcWgwdC9YTXRT?=
 =?utf-8?B?bmRoUDRubUxiSjQrbzBvQ3c4b1VJOUVuVjY2cGJrank4NHlhb0FLOUsxcDhn?=
 =?utf-8?B?NXJ3VjFNZFNkeXZCTk96d3FBSHMyZkFJM0VKNExmVlRDby9ZL1NZeURJRnJM?=
 =?utf-8?B?bU9NSkF6TmRvVkRBcndvNXZyY0JMVTFUNVJseUdyZU9Wc3B4czBTMU04TUVF?=
 =?utf-8?B?QW9qVVplbVViRVQ5UUlOTlgwanBsbDFTUWFVN1cwb1hZVW45aTkzZElmYmlI?=
 =?utf-8?B?aUlodFNJQXp2REo4aDNLVGpXN1RTZmJwUzNvTWlvWjh5UURjdXNxY1hKTTRt?=
 =?utf-8?B?ZUlNWDVZZG9hcWZ3Z0hQS2NiS0tkMHhIZStHVjlpTWJFeCtrWW40K2VtRUYz?=
 =?utf-8?B?QXMrRDFDRC9nWVZxNHRCZjlmc2FuOGRYdlBDYWFkbFkxdXhsSkNocDhMbVp6?=
 =?utf-8?B?T1hHdk54LzJIdUdlQTNtWTlya2dvWXB1em1CRUFkTHNMVDBZVlRWYnJCT1JC?=
 =?utf-8?B?YTB2ZUlxWTZRZXZKU3dCQm9JeHpIY1VGMWxVTStPN2lPTG8zWnNNcGlYVk5y?=
 =?utf-8?B?d0E5cmxPdWt3TW8yTHNFNUpnYWVtUTBBK1FweDhQN0tvZjN3VFdHMEpYNm55?=
 =?utf-8?B?T01FRGhrZHpRVDVKZ1p0bnJDYmdWVVFyWU1Xc3d4YkFpM1ZZcGxRNHJvR1pC?=
 =?utf-8?B?ZkhMRmtkRzVrZk1UZS9TTlNpczBySmxtSkdIODMxbFltNzVubk5JaW9CQTZq?=
 =?utf-8?B?UEdGeEw2a1U3Vm54SmlnMjhvNU5ZQ054dW5Zb2h3S2tibnZFWndrbFI4S2ZF?=
 =?utf-8?B?ZHQ0TGJqU1dCQWlLZGRnY003bnJ0eks2TjB6N0FmeSszemgvV1RhVnRhdjhI?=
 =?utf-8?B?amwxMkVHeGdLekJsQlIzQ2s4RWhOc1ZtdC9KL2N1a0VDcFlYVDJtellSRUp6?=
 =?utf-8?B?RGpGZEpIdWZNbXk4MVhNQ2NTMFQrY3UxQTgrV01DMmdlWDV2MXRqN0s4ck5V?=
 =?utf-8?B?WGJmRVZ3N0JXNXB3Yk0rbnY5WGREcWZxTVVSUU9nNElZMjAyWjF4WUIxWTN6?=
 =?utf-8?B?cGtWVUdHR1pMV3ZDZm9QcmRTMnF3d3puVWJGeWJsdzVtSEE5R0FMTDYrK0VQ?=
 =?utf-8?B?QWxoaytlRUVHZmpzVVppbVFFQXZMV1RoeVpEVURTVHNQdWJKcjdRQkY5WW1U?=
 =?utf-8?B?OEp0d2RPbEliaWV6ME10WlA4NWkxTXArS0NPandrYlYrTkZneXJ3RFRZZmph?=
 =?utf-8?B?Z2ltM25CS0VBbXFsRmN3eDhJeE9Sck1VVDd4V081ZS95SFd1SENZUzJLelFo?=
 =?utf-8?B?L0wrSGVUK1g5UzUyaENOZEFpd1VuenZPNnFtSWhUSGQ1SFJRdm5kaEVoTjVK?=
 =?utf-8?B?bHQzT1hRUXVvWjNqeG1OYmlMWW4xYjhvdEpKcm5Kdi9PWGgveFQ5RkRoSDJs?=
 =?utf-8?B?bU9nOXZpRzVmR0NVR1dNclRVZTE4MUYxVTdZTE9VS2QzWnZpM1AxL3ZXb3A0?=
 =?utf-8?B?OThVZk5RdGdUYUdOanhITVhTWHlxK1BtWE8yLzd2MmRaYmNwak1PWVNJWXVj?=
 =?utf-8?B?aDNvKzlzVjhWWlBzc2V2WU00elN2RExjdVRYamFDNWEvQTl5NlNQa2NPZXFI?=
 =?utf-8?B?MEg0c2ZQVFl3MU9KUUpCaGR5SWYvTWh0eDFSOW94bHZuRmlTcFltbFc2VkFm?=
 =?utf-8?B?Vy9sNW5EVDFYL0lSYUpPcnJickdFY0N2R3pnbVk3ek9RcDkrWmVXKzZ6azRz?=
 =?utf-8?Q?0FTx4dMb4w7MjkkaqXWqa8A=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c12cee10-343e-4cc5-9dc5-08da015780b2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 23:00:56.1817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smPxSCm88Mz13xr2b9bO4PD0RlDiWcWIYxt5k81BI9JCgeZJS5/SHTk2VlOX5YgRBHlzLefolwPLmqrNFzzJtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3349
X-OriginatorOrg: intel.com

On 3/8/22 10:45 AM, Florian Westphal wrote:
> Kishen Maloor <kishen.maloor@intel.com> wrote:
>> Hi Florian, Paolo,
>>
>> I had responded as below to v2 of this series but wondered if perhaps it got lost
>> in the barrage of emails. So thought I'd resend it as I still have questions
>> regarding our rationale here.
>>
>> On 2/24/22 7:50 AM, Florian Westphal wrote:
>>> Currently mptcp adds kernel-based listener socket for all
>>> netlink-configured mptcp address endpoints.
>>>
>>> This has caveats because kernel may interfere with unrelated programs
>>> that use same address/port pairs.
>>>
>>
>> I assume that this refers to a potential race between a kernel listener and
>> the application which Paolo had raised. But I'm not sure if these changes
>> eliminate that possibility. Pasting Paolo's example below from the prior discussion:
>>
>> """
>> s1 = socket()
>> bind(s1, A)
>> listen(s1)
>> // at this point incoming MPTCP connection can be established on s1
>> // and ADD_ADDR sub-options could be sent back
>>
>> s2 = socket()
>> bind(s2, B)
>> listen(s2)
>> """
>>
>> Over a newly established MPTCP connection following listen(s1), the PM can issue an 
>> ADD_ADDR with B. In light of this change there would be no listener created for B. 
>> But if the remote endpoint immediately established a subflow in response (to the 
>> ADD_ADDR), then that would create a subflow (connection) socket at B.
>> It appears (and correct me if I'm wrong) that bind(s2, B) would fail after this point (?).
> 
> Why would that fail? You can bind x:y even if there is an established
> connection from x:y to q:r.

If I establish an MPTCP connection using mptcp_connect individually as 
Client and Server, then I am unable to bind a 3rd (new) Server process at the Client's 
addr+port [1]. Why is this the case?

> 
>> In other words, a subflow creation at an address could race with a subsequent bind()
>> at that address causing startup issues in the application.
> 
> I don't think so.  Its fairly common to implement "graceful restart/update" via
> "close(listen); fork(); exit();"-sequence. child continues to handle existing
> connections while new process can start & to serve new clients.

What you're saying may be true for a previously bound addr+port that was in the LISTEN 
state at which a new listener may be bound after the old one was closed, and in the 
presence of ongoing connections. 

However, I am viewing this matter in light of your changes wherein a connection 
socket is established without there having been a bound listener at that 
addr+port. In that case, I was wondering if the above situation [1] would apply on a
subsequent bind(). If it does, then we could encounter a race such as I described. 
