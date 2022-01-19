Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C575029CA
	for <mptcp@lists.linux.dev>; Wed, 19 Jan 2022 20:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642624048; x=1674160048;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7MRDMfpJGLpMwD76jDtJ/wtvfawg52QfVzeKMNDtjlk=;
  b=gf7AM1BfgQsHRzSRCJ84WSZQWd+uCVQ7Q4Hq1VtxVlgHWixwGC8gd9TA
   ngVvVejPDRl302ziU0o95G7Wq2Dqv0esnvJaW9smjH6TsgpaJmnZQxJya
   UkxompnGjLkEh1EscNu5cpb0PZVR8jRBxyVcZxQYCWNj5sEPBR7rbqGXS
   my1CSkZi0TMhSd5OhgrKZH3hfxKVbt7OXRmEgVJ6bM/RWQOVIxWcj0wyX
   z+WVZukRISDxhBSnd8o2euLTphpyw4P+fn8EtIhOcW/JCnb9aVilX/Ktg
   zG8UHqvEt4Ts6GWZR7PElqJVDaOT12IJ9kOowwOkFlVwM0/E5y+DOMIIk
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="305918339"
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="305918339"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 12:27:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="532468129"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga008.jf.intel.com with ESMTP; 19 Jan 2022 12:27:27 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 12:27:27 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 19 Jan 2022 12:27:27 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 19 Jan 2022 12:27:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSX3+CfIHrSMz/KctVPpBcJARfdn8Las2dsGbMbU/x5zT/YibYlvQKzg/AyXZdxrlfxZdwC34ZzYqDhcb458hqqJ8D9fLhpRQLNt3zyajjwmVTpebbqOkxFZyVPJgFg0mjUQy7UbTuBCZIHLVvSkIk4shW3PjnLn6Rg7oPV+vs+vwdCT4Da03xJ20lDcb98Qju/ttWEDjLNFpTQwwtILOzsdRacEwze42651Z82c1Z6QpKcbMzvYizzwx4jP6ocNOZGyTT1qWE8IAV5beruebIM3DHv4t9pmEg3rDlIlo5WWyiZDviPfgr/9Qve9zR4tiFlRN5vJvp1MYh6u0DT2Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olxe/8aGjE8USlt26CzpTYXwhV0tJ63r9I1BbspWjVw=;
 b=eDlC1g5UqDLFPzgfBoZrl1ql5d00p703g6rfzgkYEcNnM1+gGAmPM/qO5Ak4DM7HtDO0i3p01V2qhVBRS9f1ED38Ae6D1iKySjF0RCL1xWT6gWiDHUhagfEBER8XKGt0Ly2B07iTr+vdZ0L0lHqSOKorLYVO/WzjNLA0lqyZlexaaR6Utk5sQhvtbyBWw7tupN3V9wReEPeruAo+4lKHKr0+upO0kDsMVyc+nxV5sFe7EnpkGxH7qH8x9SLe5Zr2v7tiUo4xuI9bpBSXh6BR2MXZxJjRrV9qbmgBMz+c+ye5DkNiLOGD05xqTdMGoPbZK1KbzFuZ4tWGsdBTCQhaXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5145.namprd11.prod.outlook.com (2603:10b6:806:113::6)
 by DM6PR11MB3436.namprd11.prod.outlook.com (2603:10b6:5:65::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 20:27:26 +0000
Received: from SA2PR11MB5145.namprd11.prod.outlook.com
 ([fe80::992:6137:3ea3:6cfd]) by SA2PR11MB5145.namprd11.prod.outlook.com
 ([fe80::992:6137:3ea3:6cfd%4]) with mapi id 15.20.4909.007; Wed, 19 Jan 2022
 20:27:26 +0000
Message-ID: <c2a1c4e2-2c3f-8f16-7643-5b7d2857cc43@intel.com>
Date: Wed, 19 Jan 2022 12:27:23 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH mptcp-next v2 10/21] mptcp: handle local addrs announced
 by userspace PMs
Content-Language: en-US
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
CC: Paolo Abeni <pabeni@redhat.com>, <mptcp@lists.linux.dev>
References: <20220112221523.1829397-1-kishen.maloor@intel.com>
 <20220112221523.1829397-11-kishen.maloor@intel.com>
 <0e4b1a7f071128a6a775b7e903dc48513a079037.camel@redhat.com>
 <d399a1cd-39f5-244a-b88b-54c1f17b9437@intel.com>
 <7830588b-99bd-d5aa-5018-7f559fa39bda@linux.intel.com>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <7830588b-99bd-d5aa-5018-7f559fa39bda@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::7) To SA2PR11MB5145.namprd11.prod.outlook.com
 (2603:10b6:806:113::6)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d111b158-c830-458a-29b7-08d9db8a1b38
X-MS-TrafficTypeDiagnostic: DM6PR11MB3436:EE_
X-Microsoft-Antispam-PRVS: <DM6PR11MB3436E168603AD4E96A118B2CE1599@DM6PR11MB3436.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UiI4exZdnxz/WMBSTGddOD9dcq79FZYA6k1K2/bJbFF4qS9eJyDLo0FF7+/6xOSDCz/6KR3AbEs6AvHiXvTl8CNMoGBMWFSbI/yi9aoGfkgcEZ123x4X4OL3cQkMGTkpny84E100fbxNIJ96YoH89r1Lxn4cI2yze+4M+aW8Z9+C4kAWVr8+ceGpoowTiGZkVv8VVZcslv7dQH762CPtg3gOOHfpNPUIptvAvf1zYV2nh5UIm3VUUtvhqorpSYPIDBF2cggSQXT9/diQj34Jo6Btk0FFrB0waxXeW/Y9z/FhVVUhYih1Z59ZiflXwF5eZ01BCbOyF0xScovbidxGTeGtG66SeLwevkMFJx8qqzG+Mnaj2AqDQ/pFHayBmhHzhe83kuMmgSqGqxoY3PjXmupF47haUz3rOcb+HG/YMFqS5tLtWqtI0Iy3gfVqhCSS6fl2l0kjftPhGmZEok9e64BUmFEEgbnCxbbqMDZAkGU9Y0rs/N6lSjpCv3S9Xu7Zer/uTFO9j9FB7VA26lOp0Rvttt0r5yZEfu9Ltzn7EaxMq0qiYAiYEcYvT/yGgayO+q0L964oOYRfP5hiK3sRwrYyNhVzjhtGICSK8LDBHGJGR8t0lTbusxMs/rXuXL5/OLIkEVumQz4RGBbkj3HcDuvDB6d+XsA0mCCz/qaWXvDr/BcUJhAHMFWXSQHtz5EjaVGsAxh6WD+DBTE3iKfK7cvVKdUP9CShYuQKIy7jkEs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5145.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(2616005)(31686004)(86362001)(6512007)(508600001)(38100700002)(6486002)(83380400001)(44832011)(6666004)(186003)(2906002)(82960400001)(8676002)(66946007)(66476007)(66556008)(26005)(6916009)(31696002)(36756003)(6506007)(53546011)(8936002)(316002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGRGYWZQMWVscnlHWXBxNXREb01RbmF0Y0FCRHRLTnhhUEVSZTlwZ1djaFA3?=
 =?utf-8?B?NFRRSkVacnNTeXFobWw1Rk1SaW00VG52YXJpVTg1VmpkVTR4aVV5b2xLZGZX?=
 =?utf-8?B?V0tvYmttbmFoVjJNQk1PVWFNc2hSRkVNRFVOU1dYVXF5Sk9NSDU1R2RpMDRW?=
 =?utf-8?B?cG5BTzNXK3BjcmpxMEE0T0U0cnZ2VC9uS0IyNUJiWnZyS2ZzWVMvdEYrZ3U0?=
 =?utf-8?B?N0NZTzNrSElOSVgvd09QR0RMZ2tiWm9RbmwydWgveHo5YitURFRndGtqVWR1?=
 =?utf-8?B?SlRlRWNYZ05CazRPaUlJVnhud3JyUVgrZjNPdnNYRlFCMTgzUE9IV3luNEdO?=
 =?utf-8?B?clpoTlFGWFRqT2grUVd1NUx0bVo0L2xwc2NwWWNUelhWaVdNVGdWdGduUE5X?=
 =?utf-8?B?S2NkMFBhR2pJMEdhQ3VPM2Rubk90Vm54Y2lYQkVjNHB4ZUswTFd2MlNZMUdw?=
 =?utf-8?B?SmFzR1JsOVVHcnZjR0V4b0FvQjNRS2h2b1RodlYwRVRkaWp6WEMzdmJwU0dw?=
 =?utf-8?B?MU9uMXFVY0QvVVFIUHMyYkdweE5mTVp0ZXZtTFl5RWpvaUpSWkZmdkNOZnVZ?=
 =?utf-8?B?aDlhMEUyQW1tcHZScDBlZm4yWmZkUlc5V0l3TzBuenI2R09QWFBSYUFSY0lQ?=
 =?utf-8?B?ZjJHQzdVQXZCZW16dGJGbnIxcEJFNHlSSER1N3phbVVKVGM2Q1RDYXpYRDhH?=
 =?utf-8?B?ZkN4K205TkdqMWVsaGRyV2k3UDRZeHpDRWlvQmNXTmh3dlhVck5JYmZ2OFFN?=
 =?utf-8?B?eEZBNGdkMEJicU9Ud2x5SmhSb0pSZjVvYitIdkc0Wnc3MXFZT2Z0ZDZxbnFY?=
 =?utf-8?B?UUlpYm56MkRBbWhtRWxYbVpFbGU3UXBZN1VkQlAwMTAxMi90Njhjd3RaRTlr?=
 =?utf-8?B?S2s3b0lwbUdQNm10MW1DY3F5NlVqZTN1WnNicmpicFJJU1RPMmREY3diQVhj?=
 =?utf-8?B?UCthSlhSY2FXeFExZ0Jjd1JvYUNXMlRxTTdyN1luY0VPeGxxSlRzM05ZTlFC?=
 =?utf-8?B?blA4UmNaeEZYcEhEcXQwUExVd3Mwa0JFdWdabTdwdmdaMnpEbkF6NGJPbnFz?=
 =?utf-8?B?Z3o2ckFNTFhqUDB4UWZOUU1ra1Bycmk0aXl3Wk5RUkRtSXNUY21IMVZ5Kzhx?=
 =?utf-8?B?b1RDcnMxTTdaRHJrWnlhSkVnMmVYdUFiY1JOUTM5Y1JKYll3Y0EvMWZKdllV?=
 =?utf-8?B?dHdsMEFKNlp0TFA2cGF2QzJHdVpvVzFVdThoUmdIbko3OUNkRUZsaHFqbnF6?=
 =?utf-8?B?OWVrNi8rTVkwbEI2bHFNU3dSSTBxdWhXYVhYWjhBWjlvTnZQMnRtU2hGL1Qv?=
 =?utf-8?B?WldsSzJuM0J1R2F4bWEzUnM1UUZXeFgwc1F1RnZHM3ZIYmd0S21HTmkwRGY4?=
 =?utf-8?B?RUpYK2o3dHdEUHJUSTFJbEgvQnNHai9vTjhVLy9XZWdKVjQxT3Z6eXdIbHZ0?=
 =?utf-8?B?WmtKc2JyMXJnc2JvSjVpQXc3UjlaSEdkV2lDTmExenAvSHpxeVVlQTVPTHJK?=
 =?utf-8?B?OFB1ZkIydEF5WEdVVjVRcXIrSFNleitXcW52U2hLKzI2VFlIT0gxbWM0K3VB?=
 =?utf-8?B?OGlsZlI1SUhRdDViVURXUzBCV29hL3BabE9mSnNKQStVSURXY3V3dlM2RTBw?=
 =?utf-8?B?RTYyTUFsSWFWZk1QZ3MrV211QUdVclNBSkZmZVlFWWpzWnJ0dm5BM0diN3lk?=
 =?utf-8?B?VFVYc0pNUlhZVTljcDJqbklJdmp3YTVoQkY5VXEvQ2FlOWNpUjZPTVNEM05I?=
 =?utf-8?B?NlRqemVJSzQ5UVdBS3R2YVFUT0ZhYk85QUowRGplYlRFN1RUakhGdjRJVHNp?=
 =?utf-8?B?ZjV5UTgzbHNtNlNHaWRqK3I0bmxLYy9KTk9WdWNWbzk2eUEvbGdFTXdjYzBV?=
 =?utf-8?B?ZEVXckhOYkIvei96SkgzaEhaQ2NpbjdMeWQ0ekNHWjIvQUpkWEhNbmt2VmZx?=
 =?utf-8?B?ajFuT0wyZVROeHR1Y0w4T0NzUmFtMjNGRVJKYXQwSzJnRytRaEx6UEhHRWEv?=
 =?utf-8?B?ZWU1cGMrTERtQXVvcWQxZjluRkxwOVNtb0V3Sm1USC9vY3dIeXFRQXh3SUpC?=
 =?utf-8?B?WDU3RDIzc09rUFJ5QTFFcjFOdnlQMkw5ZGREYm4vU1c0aGNiWmc0UTY3T0s3?=
 =?utf-8?B?UENJOTI3NGM2N28rUHlwOGpUdzlaVHNSVXptSUY0c2x4VEo0SW5OemN6amNx?=
 =?utf-8?Q?Wduqf9rdDsImR/qJriS/9tM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d111b158-c830-458a-29b7-08d9db8a1b38
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5145.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 20:27:25.9520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P8yI5ziPfdIgPOh2W5dURO3cm0qPWcWnGWSkSn3G4k0nGONc/t+XbcTAdAfXS/rNfv+jfe+8v90pGX1hIn6vSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3436
X-OriginatorOrg: intel.com

On 1/19/22 11:20 AM, Mat Martineau wrote:
> On Tue, 18 Jan 2022, Kishen Maloor wrote:
> 
>> On 1/14/22 9:11 AM, Paolo Abeni wrote:
>>> On Wed, 2022-01-12 at 17:15 -0500, Kishen Maloor wrote:
>>>> This change adds a new internal function to store/retrieve local
>>>> addrs announced by userspace PM implementations from the kernel
>>>> context. The function does not stipulate any limitation on the #
>>>> of addrs, and handles the requirements of three scenarios:
>>>> 1) ADD_ADDR announcements (which require that a local id be
>>>> provided), 2) retrieving the local id associated with an address,
>>>> also where one may need to be assigned, and 3) reissuance of
>>>> ADD_ADDRs when there's a successful match of addr/id.
>>>>
>>>> The list of all stored local addr entries is held under the
>>>> MPTCP sock structure. This list, if not released by the REMOVE_ADDR
>>>> flow is freed while the sock is destructed.
>>>
>>> It feels strange to me that we need to maintain an additional addresses
>>> list inside the kernel for the user-space PM - which should take care
>>> of all the status information.
>>
>> The PM daemon will have the complete picture, but the protocol needs to know the
>> local ids assigned to addresses so as such the kernel has to store addresses
>> (with their ids) regardless of PM.
>>
>>>
>>> Why anno_list is not enough? Why isn't cheapest to extend it?
>>
>> The anno_list is the list of addresses that were announced via the ADD_ADDR command, to
>> be used specifically for doing re-transmissions.
>>
>> However, the implementation can also accept connections at local addresses that were not
>> explicitly announced (hence not in anno_list), and in this case the kernel records the address
>> and assigns it a local id unique in the scope of its connection.
>>
>> So basically msk->local_addr_list is the list of all known local addresses, both announced
>> and not so their ids can be later retrieved.
>>
>> To give you more context, in my last iteration of the code before I posted the series, I was storing local addrs
>> in pernet->local_addr_list just as its done for the kernel PM, but later moved it to
>> a per-msk list to eliminate contention (in accessing that list) with other userspace or kernel
>> PM managed connections.
>>
>>>
>>> Being the list unlimited a malicius (or buggy) user-space could consume
>>> all the kernel memory. I think we need some limits, or at least some
>>> accounting.
>>
>> At this point we're taking the PM daemon as a trusted entity which can issue these
>> netlink commands for path management. So there is currently no configurable ceiling
>> in the kernel on the size of the PM's kernel stored context.
>>
> 
> I think it's still worthwhile to have some limits/accounting as Paolo suggests - part of the point of pushing PM code to userspace is so bugs or other vulnerabilities don't take down the whole machine.
> 

Agreed, but do we put circuit breakers inside the kernel or the PM daemon? (for e.g.,
if a PM plug-in can see limitations imposed by the daemon?)

If we consider userspace path management as providing "more flexibility",
then conceivably the kernel would expose hooks to the PM daemon to bump up any 
kernel enforced limits when necessary. So a malicious or buggy PM could also raise 
those limits. 

Since interactions over the netlink interface are to be carried out by a privileged
entity, I've been assuming that the PM daemon is to be trusted. 

On the other hand, if we're talking about having fixed upper bounds in the kernel wrt
# of addrs/subflows (which cannot be changed by the PM daemon), then that could make sense.

> -- 
> Mat Martineau
> Intel

