Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EDA173
	for <mptcp@lists.linux.dev>; Wed, 19 Jan 2022 21:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642627865; x=1674163865;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gyVdNfT1nMzFN8ULJNDQUuNDDcI9Stc6XXrxifCQ1ZA=;
  b=BzcOK+V6ZhyQZ8GWIOo5YSydoWDzgPHgSasvJTAj1IxL1hrOfJ03WIOU
   h5JThS2RMWScWcT/pn3G05mxqGfSM0zbu2J1iI49oogisX1eraZYdn8ox
   TFsVxspW48chS4cBrsaRTXN9yP6PeLDLpQ9yuyUWKOsgZxq0vkan+NYbG
   6H4CUQgXCeJaXHZJ8P0aHtfZ0Tp1muUCTxKq3te91FeyYhGbgt0gOLUot
   nI44xiBzmgRusED6Ptd73CRGj53LeapzSvsvhij9iDdQ/gZvCoKsA8Ond
   l2D4pOoQIE3QuP10SvIuT/K4jOYzw1jiYam/74l4wSYBmaX0GOfPzDQV4
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="245394589"
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="245394589"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 13:31:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="578972896"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jan 2022 13:31:03 -0800
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 13:31:03 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 19 Jan 2022 13:31:03 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 19 Jan 2022 13:31:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4l8ROhqy4SzH1rDBITKYJ59PxGLL1kccs4Q7a6TTWShjHHjXup+aks4PMp5NdxdSXdjfMEwLthyZkKnC89oLfWCgqmhFE5LxrjhqXTHHwQjVGVi1MSiL2f6kwbUy9e4/d7kC5hsm9WB3EfbQ+UApXhTyGwBmWCwlnAN30qFFRbsd3f9j53t+UHVvnPiKq2Jjf/G9L6vYE5d1QSQad/ZlVTe6PWNz81zhcSM4zdzkexJI3dcGgzD4Q75s9tgaIuSWKEzPb6auRHOzlLT7JeZoopEbRknzt50qLcwxzOqmbv1HdZ9nnkA628W+xVTB98v/5qzux4wej3QdEMNyfHOSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rf1Odi5sjJ6yMSSF3b9dOuCZE/OjAJoJ/2KjkKiIjjU=;
 b=UZSHv3AJdJrtYyAIRiZkuoRniZnhG31XJ8K90u5wRepRclt0O7E3MYk5btkUL8nCDoQZDx1a5SgXrBzUd4a8s6gkAfdfgDpGfIXAV2j5sBV8L1vLeulMfYrTFswstN4qdnK0C62NZ2R/Ok4txKLFQQIB6qq2MKIKv5UQNUDiTbPkmRC6Tl+y9mASM+SPZBFxpFAbPjhV5cOJwUTafhxE0gSfQTAHrcxepFwdhaz4Y5wwwUB86WYKjQ4byTc3zQVudvBocbr/wLZTaJwnFq/OWmQes1Eje4Cb/R6eKRZJKwz3TR+k5QtD/LYjiMhRIm1OOqfufSt9XktzPZhciscGBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5145.namprd11.prod.outlook.com (2603:10b6:806:113::6)
 by DM5PR1101MB2282.namprd11.prod.outlook.com (2603:10b6:4:53::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Wed, 19 Jan
 2022 21:31:01 +0000
Received: from SA2PR11MB5145.namprd11.prod.outlook.com
 ([fe80::992:6137:3ea3:6cfd]) by SA2PR11MB5145.namprd11.prod.outlook.com
 ([fe80::992:6137:3ea3:6cfd%4]) with mapi id 15.20.4909.007; Wed, 19 Jan 2022
 21:31:01 +0000
Message-ID: <ed1a5c67-67ab-b69d-5f0b-232a8e4605a1@intel.com>
Date: Wed, 19 Jan 2022 13:30:58 -0800
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
 <c2a1c4e2-2c3f-8f16-7643-5b7d2857cc43@intel.com>
 <bad0c4ad-69fc-2e1e-35a-43178343704f@linux.intel.com>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <bad0c4ad-69fc-2e1e-35a-43178343704f@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR18CA0070.namprd18.prod.outlook.com
 (2603:10b6:300:39::32) To SA2PR11MB5145.namprd11.prod.outlook.com
 (2603:10b6:806:113::6)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc078944-9e0d-4340-d85b-08d9db92fd4e
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2282:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1101MB2282A62DD1C91C7B48BCE353E1599@DM5PR1101MB2282.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dhMbUdEvLVJ+o7NQzRKNXm0+l9m0cTSU691WaB8rZTyAlkYjQLyTMwOLao5eXRwc/NPpLrqhRY21nCXqhnPbD3njqE3QAl8KhdmptNTuHZrPPaBRHNcbHQ/Rul+Hb7gIw8NlWqA8W7MlNlMIGWEyuoIPJ2T2lhoomxt9gQrQ3NomzotiK/A6GUEjE84O2bx6JhG/TK6WGnGXAwpr5+UoEaVUBAkuQHHznFs5S8SgmedMKbk1WI8EOzJUlovNNWISGDDytbjGQw4KUhSlJON9uPqaQ4TFE9soO6CfDp8U1cq9Dluzhmk9i8o2eFPIxxTDJY4jQSiR6Zt45Br8xZSz+6aH9syzCOg7JUudmwlIcVflzhFci1aAym1hO3iSDQi+4cY2lGnhzsYKKZg4bIPoBxKhqdflpnS55+ZTGm1kukmZLwcb38/ukvtamJOXk9U7QYJCkgpXnKFX0uxvK0ZHzEV56740yUW17MwbLpdAr7iNeP483GybB6vLJ8whdVNHW34P1guK/gnJKVm7MkDlmTnMXdQVOGmHiIjl1jNobXLdURANSh2aaXTYn/VJ7xpVzbrgEMCqhBwt0ljmBkxM1ZMeAPI/ObyI7yDnB02iQptLunb9GN4ut5lo6uc60M7rUX0vMurHZ/r8CUZ1kB7la8TtmuozgllqKJGvuHR/ANDucAmphtEhDXmWqAj6TLYiS01bXrTCC5A0H4tENCGE4OcTfk0cam7dRNvfjxwRAzk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5145.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(186003)(38100700002)(2906002)(8676002)(66476007)(31696002)(6666004)(66556008)(86362001)(31686004)(82960400001)(5660300002)(4326008)(66946007)(508600001)(6486002)(83380400001)(6916009)(53546011)(6506007)(26005)(316002)(8936002)(6512007)(2616005)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWNsU01ZTkpDS1F0akZFRXlKRTJ2V3dEUnpGNldGd3dmdVdsU2pxZlpUcmpv?=
 =?utf-8?B?Tkpjc0xTNEtjUUtTRzJHQmNhSnpBUnY1SkhmMlJidEpwUWlncnpFdHgwM1Vw?=
 =?utf-8?B?WUlJWGlwb011T0V0NHFRTHJyallUdEJ2a1ArSEZvTUl3WjRsbzMzSUpPR2dn?=
 =?utf-8?B?UzY3Zzd0clMyTjRTbXBnWU1GcSs4NndvdnVsY0drNU9DNlFTUVh4ZkVwSkVM?=
 =?utf-8?B?Z2NLOFdhQmtvT1pnMUZzOFpMYXZiM0lWNTFxM0UvOGFuZnBySnhHRVRWNWNG?=
 =?utf-8?B?R29oMk1pOGZvTVNENmcza0ltQ2JyMGk5NWd3MzFKQ3Bza3B5MFBCQlM4WkVu?=
 =?utf-8?B?VU01Q2U0eTl5TW5EN2RwSVRxU0oyVHd1SUJPVHZYb2NpbHdyclF5UG1SMVY1?=
 =?utf-8?B?LzlweVlOUmJGV2thcUtVYWNJYS9ydjF5OWdJZXNMQXY0eUpJL0RKbEt0RUFY?=
 =?utf-8?B?dUdwMVlqVVR4dG5PdXl2VDNNaCtYbHdKRkppNGdTSVo0NWM4bEdKdE5yVEVj?=
 =?utf-8?B?a09FNU9ZSzF3bEkwUVlCK3BOdFhuODUrdkV0aWJhZlR0ZWxXMUdVQ1p0Tjll?=
 =?utf-8?B?N01VVFNHUmx5OVBvcEx5ejRnTXk2cVpzbTBsRi9oYlA1b2doMlFoRDdpNllk?=
 =?utf-8?B?Ri93NXFIWFo4VEtHb3NUWWYwTVFabS9wejNSNmIrUHRCNEo0dHlGUHEvb0Ny?=
 =?utf-8?B?b2V5OU8yazlSY0Rnb0x1N2hpL0lXT2xudDhqNXdGVFBLZkpRWGxnUVM1TGNt?=
 =?utf-8?B?bzE1UnQxS0k5VjBlbTNNcnFHWkdaeFlCcHArL2g3MUNGNjF0ZE9FZkJUUCts?=
 =?utf-8?B?TzFLa2kvVE9oOHBMazBkUEYrdU82YmtDbTFzMXhrWllOTFZaU2QvVWtLcURH?=
 =?utf-8?B?RVRTelQxUCtqbFo3bHhaTE1lcDE5Vk92YjJBbDFmZjVVYWQrb0pWTk5Lc01E?=
 =?utf-8?B?SnJvMEczVmRQcmpkOVVPaUVPNWZJVUZMT0U4SmJiMFErc29Lb3Y3NGNWVWhh?=
 =?utf-8?B?czZhOUFwTWlPUk14Y2ZjMXJRWERKM05uTElTbVI0cXN3OXo1OWRBUTNTcW1j?=
 =?utf-8?B?ckkxQmplYUorYTlHM3pscjVNOFRqVWk3bXFOSXVuZUo3VGxyN0pEVjBBWTdo?=
 =?utf-8?B?dHhmZlVPaGk5YkhMV1NEd1IxcEdwaVBkajdnb0F5UFJqVFBlUzR4MEJaYlNp?=
 =?utf-8?B?UUVMY1BZaHNaYjk5ZHdhcmVVYzFPb0ZCenl0Y0cxeDBGOFNMSHVjRHVCNGRL?=
 =?utf-8?B?MTBlK29CNlZYVnlXRjBTM0IzVy9vdXFBTWQzSUtwOXhXcjFrU2ZhRkxoSWw1?=
 =?utf-8?B?SzVuZEcxMnBYcGROOVU4TXhPOTJrT0w4enFIRml4M1RXcExLL1phQWk3cXdy?=
 =?utf-8?B?bDA2U1ZYM25JNDRjVGprdE1vT2d6YnRMZFU0c2YrSVZWY1ZJeXNlT0o2SzFt?=
 =?utf-8?B?cTc4T1MzdDhPSkJrY0dYMGJzejVFVzh0MnNnZEx6a29hbWMwNG5rbTAxSjM0?=
 =?utf-8?B?VmJLTWZ0OGZXNWNpU002UmJsNjhJckxlMnE0SXYrMlp6MitGeERSOUF4RGxO?=
 =?utf-8?B?NlQxNUFnZWlCcnNuZVJXOWtGNHRCVlF2SnJVaW1xaytVN25IKytSZmxhT0ZN?=
 =?utf-8?B?KysrazlZQjZqbWgyRlRrcCtNMjB2VTNaZGlLTXlwa1UrYlhnV3J6bWFWV1Jq?=
 =?utf-8?B?VVBCeDVwNThHQkw3YzRGaHlhVGxFYTRWNzlTSGdPWEVZUnVPLzVWZWZJTUVY?=
 =?utf-8?B?U2NaTGFoNjlZaG9NbXBCZkU3UU1FS2VpR3JEVGNZNU1kNkZ2TDltaGx5MDh0?=
 =?utf-8?B?NnVPbXlSc2FlWCtVL0szbUlDMlFjeXhwZG13UVJXRDNlRzVHNHR6QzZXRjM4?=
 =?utf-8?B?RjV4OWY3RmoxS1JLSFZENXVHeHJWeVQyR3Rsd3VLV3drc1FUc0VoMGpiSW15?=
 =?utf-8?B?TjhZbWYxakh6VWlRRmI4LzRidEZRYzB4ZVJPVVI3NVpFTkZVaWwwTm9uWmRa?=
 =?utf-8?B?WURjRlBFck9KTWJLN3hNSDRlbUVNZ2NMbHdDOVI0eCtMeHlZczNNUlVTQlhW?=
 =?utf-8?B?Tmo4bTdtQmg4ZTloa2FzT0N2MHphMkJCaTBvL05mOUdsWDFhemlIV2EvOEVP?=
 =?utf-8?B?RHhUS29HNFh6QVpNN25DbTBueHpPT3RITlRiaVRobG5odVhMd3d4bHB1aEZs?=
 =?utf-8?Q?hJNaeUk3Tpsai+NSF20H8UQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc078944-9e0d-4340-d85b-08d9db92fd4e
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5145.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 21:31:01.3490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nadX/EHJFZfu7Ra2wb0AFYWibP23fS4GHG3WW+E14NJ4PzBRDHA7wbIrvkhT2gJq3L6gUsVgt+B+ts5Tt4arsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2282
X-OriginatorOrg: intel.com

On 1/19/22 12:44 PM, Mat Martineau wrote:
> On Wed, 19 Jan 2022, Kishen Maloor wrote:
> 
>> On 1/19/22 11:20 AM, Mat Martineau wrote:
>>> On Tue, 18 Jan 2022, Kishen Maloor wrote:
>>>
>>>> On 1/14/22 9:11 AM, Paolo Abeni wrote:
>>>>> On Wed, 2022-01-12 at 17:15 -0500, Kishen Maloor wrote:
>>>>>> This change adds a new internal function to store/retrieve local
>>>>>> addrs announced by userspace PM implementations from the kernel
>>>>>> context. The function does not stipulate any limitation on the #
>>>>>> of addrs, and handles the requirements of three scenarios:
>>>>>> 1) ADD_ADDR announcements (which require that a local id be
>>>>>> provided), 2) retrieving the local id associated with an address,
>>>>>> also where one may need to be assigned, and 3) reissuance of
>>>>>> ADD_ADDRs when there's a successful match of addr/id.
>>>>>>
>>>>>> The list of all stored local addr entries is held under the
>>>>>> MPTCP sock structure. This list, if not released by the REMOVE_ADDR
>>>>>> flow is freed while the sock is destructed.
>>>>>
>>>>> It feels strange to me that we need to maintain an additional addresses
>>>>> list inside the kernel for the user-space PM - which should take care
>>>>> of all the status information.
>>>>
>>>> The PM daemon will have the complete picture, but the protocol needs to know the
>>>> local ids assigned to addresses so as such the kernel has to store addresses
>>>> (with their ids) regardless of PM.
>>>>
>>>>>
>>>>> Why anno_list is not enough? Why isn't cheapest to extend it?
>>>>
>>>> The anno_list is the list of addresses that were announced via the ADD_ADDR command, to
>>>> be used specifically for doing re-transmissions.
>>>>
>>>> However, the implementation can also accept connections at local addresses that were not
>>>> explicitly announced (hence not in anno_list), and in this case the kernel records the address
>>>> and assigns it a local id unique in the scope of its connection.
>>>>
>>>> So basically msk->local_addr_list is the list of all known local addresses, both announced
>>>> and not so their ids can be later retrieved.
>>>>
>>>> To give you more context, in my last iteration of the code before I posted the series, I was storing local addrs
>>>> in pernet->local_addr_list just as its done for the kernel PM, but later moved it to
>>>> a per-msk list to eliminate contention (in accessing that list) with other userspace or kernel
>>>> PM managed connections.
>>>>
>>>>>
>>>>> Being the list unlimited a malicius (or buggy) user-space could consume
>>>>> all the kernel memory. I think we need some limits, or at least some
>>>>> accounting.
>>>>
>>>> At this point we're taking the PM daemon as a trusted entity which can issue these
>>>> netlink commands for path management. So there is currently no configurable ceiling
>>>> in the kernel on the size of the PM's kernel stored context.
>>>>
>>>
>>> I think it's still worthwhile to have some limits/accounting as Paolo suggests - part of the point of pushing PM code to userspace is so bugs or other vulnerabilities don't take down the whole machine.
>>>
>>
>> Agreed, but do we put circuit breakers inside the kernel or the PM daemon? (for e.g.,
>> if a PM plug-in can see limitations imposed by the daemon?)
>>
> 
> Kernel, I'd say.
> 
>> If we consider userspace path management as providing "more flexibility",
>> then conceivably the kernel would expose hooks to the PM daemon to bump up any
>> kernel enforced limits when necessary. So a malicious or buggy PM could also raise
>> those limits.
>>
> 
> True, an admin (or bad actor) can get themselves into trouble by setting nonsensical limits. But the limits remain useful for stability and managing resources.
> 
>> Since interactions over the netlink interface are to be carried out by a privileged
>> entity, I've been assuming that the PM daemon is to be trusted.
>>
> 
> We're trusting the PM daemon with certain (granular) privileges/capabilities using CAP_NET_ADMIN, not the old "root-controls-all" model.
> 
>> On the other hand, if we're talking about having fixed upper bounds in the kernel wrt
>> # of addrs/subflows (which cannot be changed by the PM daemon), then that could make sense.
>>
> 
> That's pretty much what I'm talking about, maybe tunable (within a range) by a sysctl.

Sounds good, I will look into adding a couple new params, configurable via sysctl for regulating activities by userspace PMs.
Note that these will be unrelated to the equivalent limits that we have in place for the kernel PM. 

> 
> -- 
> Mat Martineau
> Intel

