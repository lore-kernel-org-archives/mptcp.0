Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494E2173
	for <mptcp@lists.linux.dev>; Wed, 19 Jan 2022 01:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642555467; x=1674091467;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=hggh57VH2UNbB5OTNAZXvkYvgg+fYqjOQvxJ39ZR0ls=;
  b=NyUby7rT3EAIPwGj99B21gUB8QeNYasAbYl+oXQaM2zsB17czKwW4AlG
   2bNuv0RlSmmD7QxaoMOuYRKgO6u/LjdOANU/tQVmH2OcXLIayIKC8dQnv
   vjYVKHChs6Xkl8DuomPZoMj1TdUEL2FDbbvAW9K12EBzSPt+M9VBaypgC
   WOk3c1og8nl18xd6Ft+6C/rmUJYeUyDznHLNdxK+wiMYBzKmziXv2LGhE
   bPpq+0HUTQRbtQhxqqF7UBzzbLDiqGptPxeoBXQxRW7db2zCexF9zgw58
   /30JTKswJxfXQHnbKj1ye87PyghqQ79dQs7pOXBP8cxlas2ro33IRGANE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="244913336"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="244913336"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 17:24:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="477192753"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga006.jf.intel.com with ESMTP; 18 Jan 2022 17:24:26 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 18 Jan 2022 17:24:26 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 18 Jan 2022 17:24:25 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 18 Jan 2022 17:24:25 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 18 Jan 2022 17:24:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Evi2asqtRAOREhMtRCywkOLRnmAMwIU9u7eILZJnvD0df3Stsd/c4ryG5uWsm+ORI+6n4t/j/tvhS3OEtYH3mugHuFfujMscrf9sNY2gdv6jOCrW4Ei8qwYsK2j3g54nbHcQOqc5lPUo4o2J42oFPFmNKaIGUA3dCvZB79pkang+nEZErKa/W9+k2K4REgAjTon5Du7Voyjmv7K2rd5qa1ncupXGUIwqqEoCuAG+u2GbwyoJdp2WvBjAmppN7uf7+qsCfk6zCAycecbmj/0VvifBMB+gaEZRSV/KBdk1sKykYKTOAJ6kasQZsc7uvqCnYUcPqJTRgLQGIChOv/iXYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2lmv7wvl+Ivg/ErAQSIvOMEoSALIo6tPpo8htjV/5s=;
 b=iBu11hi6GQpTGmBbqkdlEHRcgAXQF7T4gKwSA7KA3MhTMk4N+2n5zwS0itHmnKACb+iso48iYkY5NZ+DccbZM1AniUwgjwf0QeDFnT2/RZSSZ9LLC4nTdd4rnTghpqxLSbG/tDxt7S65tv6ZQt5SqKfG5/66pdkp8l5yXZNBNY8jcODDeCd5nTtiKZCvy16c+0nkc/+QYyDgQOGWjOTkGZ4HTTAINHFGThVBZTGKarP7upaOWnFfxjI+5OXF8Xh4ME1jWPLpPt0DcDyhQNW64NW4k2/aoOAVvu3l0lgT85XbRooqLGN4KBjXuYwH1rGI3kUOFz7vuKo0mHSmpZiQEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5145.namprd11.prod.outlook.com (2603:10b6:806:113::6)
 by SN6PR11MB3149.namprd11.prod.outlook.com (2603:10b6:805:d5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Wed, 19 Jan
 2022 01:24:23 +0000
Received: from SA2PR11MB5145.namprd11.prod.outlook.com
 ([fe80::992:6137:3ea3:6cfd]) by SA2PR11MB5145.namprd11.prod.outlook.com
 ([fe80::992:6137:3ea3:6cfd%4]) with mapi id 15.20.4909.007; Wed, 19 Jan 2022
 01:24:23 +0000
Message-ID: <d399a1cd-39f5-244a-b88b-54c1f17b9437@intel.com>
Date: Tue, 18 Jan 2022 17:24:20 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH mptcp-next v2 10/21] mptcp: handle local addrs announced
 by userspace PMs
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, <mptcp@lists.linux.dev>
References: <20220112221523.1829397-1-kishen.maloor@intel.com>
 <20220112221523.1829397-11-kishen.maloor@intel.com>
 <0e4b1a7f071128a6a775b7e903dc48513a079037.camel@redhat.com>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <0e4b1a7f071128a6a775b7e903dc48513a079037.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:303:b4::23) To SA2PR11MB5145.namprd11.prod.outlook.com
 (2603:10b6:806:113::6)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1977a55-ebcd-4eb6-75c3-08d9daea6d08
X-MS-TrafficTypeDiagnostic: SN6PR11MB3149:EE_
X-Microsoft-Antispam-PRVS: <SN6PR11MB3149F1B16DACC472C74C7CFFE1599@SN6PR11MB3149.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YILNgHDPw8mK2GBnUOvGkGjZFA1V+rPrYwzPQNgLPjQhGdmTet4CCqhYyOEbGHyQIK/ziFuEBbxlR4z8R7VHEXEscSJt5U4VT2O03cu9Av84SowjEUBu4IUvZdDsA2OVvAiXfx2v1up8n4ylOrb6JIW0OzNFwIGvAtD4aZHucTu7D6I4w4++Xtp8+YRudLss+q5non1yjWY/acvnvT7FFGYr8JvGRL+Sxp0nOetAR3s/uzqVffKG/c0FaKUuBdVPJBPW23oMFXW5n07hqqZWfjQcyhD2vCRpqIKKKwbX76QNdTiOCGqDj3SMSp6sind8bnD+uFcMPcBb0+UQpkiUy0PzMjOldjlSOT3A4rnELcObOTCq5+tZkv31pSKFECmUy2EX1de1NIGKwy9S60zi9Awhwlu8kHXRK2y7Ysqs7/k5II4ake53ZboDJMhJhEHlWXsQFRD1fWWuEkBqnlydiP9UOJw1Fc2vTN8pbi03/3WyRTnMMtZXWtY0QYQuo6ydZTbiZiwpOzE3i9sc5Je4hyFWrSq1w6O5lRthf7ZT7cYrSm+thfMD+PpATJBWUlcR9cmRZOufbiOVTFkwCQvQ1kvaitLuRI0gKEGLHaVIUqgI3BS6KO8rM/p41v0AUU6lXMuSj234hJ/4r5O0Ruvsuu2R/c36EoZTfIyb0oOt22QgdTw+OcEp6vqAHt0LHRc8D/GKHRUpitUtLIaL3lprtwt71pnyHbbDPSLkfK/b0x4NeY3ZYk2XZW4JbuLbL8LS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5145.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(8936002)(36756003)(38100700002)(6506007)(53546011)(66476007)(31686004)(6486002)(31696002)(83380400001)(316002)(6512007)(86362001)(2616005)(8676002)(66946007)(82960400001)(5660300002)(26005)(66556008)(2906002)(44832011)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3lUSzNjZHB6czk5Z1J0QkxiNGYydlVOTlpvcXROUG1wM29CK3gxY1BQKzl0?=
 =?utf-8?B?WHArYkF1NjMxZTV2dmhqZk1mQk1VU2w1azlWc2Vla3Y1SDBvQXlsQ2lUbUpu?=
 =?utf-8?B?SFNCajVVRjdRb0E0T3R3ZjlRR1ZESHltR3VhamVZTDBnaXZ3UjViK3JhaFI4?=
 =?utf-8?B?Y1NTVmZIZ2tQSW4yNjU1SzIyQzVZaUpCdklieU04bnpWMFhxTndOZHZIdmF6?=
 =?utf-8?B?aWkxZHpyS3l0WVhZdHo5dHdhcTd3dzFYVUh6UUVaMkNmME9KOEZxRG5xYTk4?=
 =?utf-8?B?L0VjcExkNHZTNGt6SzVrT3g1Q3dFb2FSNjFMQnNyRlZzNkpjNUR0d1FRV3Rs?=
 =?utf-8?B?Wk1tck81eTNSUjJGOEtXWGpGSmN0SGhEeENwSEtSYXN1UXZ3STFKZWxWMTdH?=
 =?utf-8?B?MTB0ZGlRbGtkRitrVUhNcXVYWkt4enJHcW9jUm5Ca1RpdWNqdXFsR09PMS9Z?=
 =?utf-8?B?OHpLK3ZJYjIvSmhsc2RpL1BteW5pMGt1dlJIVFJqUVJjamQzMU4zRG5uNGR2?=
 =?utf-8?B?ODExSGp0dUV4UGlzbnM1cG95RkpGai9PQm5NQlM3YXZRdklZWlYwSkNHMlYx?=
 =?utf-8?B?TzZySnYzZFVOajlWdUEwWEZSQnJiRk03WUFOVllHREx1bkJpTC8zYXZ1ZGVj?=
 =?utf-8?B?b3BBRlhCc2pUS2RzaXc1b05QUlVhOCtrWnRYQVVweUx2WWpCRm9uUGtoQmo0?=
 =?utf-8?B?b3Z5c3VaRUcxT0F1UUdSdElvM1l2elF5cVBXSTVyVlpreXM4M2M1QUxid0s0?=
 =?utf-8?B?ZWpxRW9ZQTkwWVVsbWM3Z25JdVVmM1ZMV28zY3huemYyd1owS0h0VlptREpH?=
 =?utf-8?B?T3NPZ0pHOUlZcTM1WlBpYnROTXdJNHJxUnFrM1Y0dW0yRkVrRVB3RUx5OGln?=
 =?utf-8?B?dHE2MFBmamRYVXVoNXRxNENPVDJZUHJ5OWdySnczYk1hdm9rM2N1MHZ3a3FT?=
 =?utf-8?B?UHJVbUt0MlJFektMZnN5cHdra0dzbFE3Uk1hUXBrQ1B0d3Q2MlFrYXhvNE1q?=
 =?utf-8?B?TG1RZDJNSUpKR2RjVHRrYTZ0aXJ0dWM4WEJaMnNEcWhHYWlQZ04xSnQxc2hV?=
 =?utf-8?B?YlNGczlnMy9wNGEwdm9oRUZzSEhjZmJMczZYMXltNXd2Z0FSVmlkdjNxbXhZ?=
 =?utf-8?B?VzR0b2tDcmxMN3hDKyttb1A1NzVzL2I0MDYvTzhZOVdLNE9zTFBwWVdNb2dE?=
 =?utf-8?B?TWl2a0FnYlg0RDlyN3B0S24vN3V6WEYyTmgvT09QNXQ4MG1ZVGo3K0FTLzMx?=
 =?utf-8?B?YXVLT1gxaHJkbEdpdVNpVFJJMndSNXVGNEZTOE90VHhiWlZWaWpaSC9hMUd4?=
 =?utf-8?B?allDaWsxZnBzSXlQRDJpYVZWYlZLRklLbTFnUFlMSUF3MGdyMFJiZ0M4VER1?=
 =?utf-8?B?VXhMQ1lDZ1BWSTh4M1pQcCtMV1QvczBsZzVBYk03OUpuRWpHVjJxdEhrSWNj?=
 =?utf-8?B?Uk5wcWtwTXpRUmpCK1BVbFJWSmI0YVFiSmtEZS9KZDlGMUVDR25qS1hIZ0Zp?=
 =?utf-8?B?MkFOdytLSmE4TXZKRk5PbVlheGhheERtRSs1TSt4MGZiUUpyalF3bHM4QXRv?=
 =?utf-8?B?QWIyZGdNbzQzM3FxRkVSN3hiYnlJQlljdnhtQ1JUT2ROMUdIUjlORHp0a01Q?=
 =?utf-8?B?cXEwNmdmMHZSZ0x3TEZka2s0WVpFL2VBUmlkN2dodzFVTjlUYkNZTk5tZlJn?=
 =?utf-8?B?dUhEWk9nUnNvcHA3ZUxSekZOdWhyNHQ4dzdWRDlVZUJOd2hYWDZYOVUyeU9v?=
 =?utf-8?B?cE84U2RLU3hCUzhCbGNXM1BSanY1NWJLeTJla1dHeFZtbXBGZEVISDc4emZB?=
 =?utf-8?B?cGJ3M2pCcTR4bFdNbWs0UWdMRWM1RjlkS2IrVzduSmRBNEM3QnlTQ0tQckYw?=
 =?utf-8?B?R25nc3VQc2hEMHF0cHRsRFhlMWFSL2d3TXgrSHdUSWIrZVBiNTBlaFVyRXVJ?=
 =?utf-8?B?YWxjNWVHSlZlbTl0b0RuenFzL2YyMUV5UFFrQVdMUnVKbXBxYUt1Ym04dlNH?=
 =?utf-8?B?NGNRMGRSZEI4RHo4WnFLaDNLU1grVnV3dTdmU1FMekV4RkYySVRGbjdOZG8z?=
 =?utf-8?B?SXRVZEZCK0kzc0RxVVRERHpJbmthd0hLSW1FWjFmem0rNlhLb3p2SXhXQnJI?=
 =?utf-8?B?U1pFMzhZTmZiOU83SStkNDlvaDNlcDhLRHE1SlpKT2NvbnJxOEppRXYrdi9R?=
 =?utf-8?Q?GwSZrBbSnog9aimZLxcxcew=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1977a55-ebcd-4eb6-75c3-08d9daea6d08
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5145.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 01:24:23.7527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IkvuNvF5bEhwPwJpQLDhnFVkDQFu5eYs0HQxfUn8PmMIEqarBmROeFmN+3SUw+Wix1iop12qBiUOrmIMn/rPag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3149
X-OriginatorOrg: intel.com

On 1/14/22 9:11 AM, Paolo Abeni wrote:
> On Wed, 2022-01-12 at 17:15 -0500, Kishen Maloor wrote:
>> This change adds a new internal function to store/retrieve local
>> addrs announced by userspace PM implementations from the kernel
>> context. The function does not stipulate any limitation on the #
>> of addrs, and handles the requirements of three scenarios:
>> 1) ADD_ADDR announcements (which require that a local id be
>> provided), 2) retrieving the local id associated with an address,
>> also where one may need to be assigned, and 3) reissuance of
>> ADD_ADDRs when there's a successful match of addr/id.
>>
>> The list of all stored local addr entries is held under the
>> MPTCP sock structure. This list, if not released by the REMOVE_ADDR
>> flow is freed while the sock is destructed.
> 
> It feels strange to me that we need to maintain an additional addresses
> list inside the kernel for the user-space PM - which should take care
> of all the status information.

The PM daemon will have the complete picture, but the protocol needs to know the
local ids assigned to addresses so as such the kernel has to store addresses 
(with their ids) regardless of PM. 

> 
> Why anno_list is not enough? Why isn't cheapest to extend it? 

The anno_list is the list of addresses that were announced via the ADD_ADDR command, to
be used specifically for doing re-transmissions.

However, the implementation can also accept connections at local addresses that were not
explicitly announced (hence not in anno_list), and in this case the kernel records the address
and assigns it a local id unique in the scope of its connection.

So basically msk->local_addr_list is the list of all known local addresses, both announced 
and not so their ids can be later retrieved.

To give you more context, in my last iteration of the code before I posted the series, I was storing local addrs
in pernet->local_addr_list just as its done for the kernel PM, but later moved it to
a per-msk list to eliminate contention (in accessing that list) with other userspace or kernel
PM managed connections.

> 
> Being the list unlimited a malicius (or buggy) user-space could consume
> all the kernel memory. I think we need some limits, or at least some
> accounting.

At this point we're taking the PM daemon as a trusted entity which can issue these
netlink commands for path management. So there is currently no configurable ceiling
in the kernel on the size of the PM's kernel stored context.

> 
> /P
> 

