Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5302F27
	for <mptcp@lists.linux.dev>; Tue,  1 Feb 2022 21:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643750471; x=1675286471;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=KejTenXu2uDMGcw50lUhw7+AGDyGrO0cbcEt5kgviDk=;
  b=lAJpw/dGe/1YUPwi99CjUeViXtlJQh6QAX9O+UYLmKqZggTU0hAoHTvV
   SmU1x9sGVK82lYPRz3NYtVCfpCy4LPDHFDXiGuLdniYcVLYMNC5YotfAu
   /G/Mu46nHlmK/i6/tC1je/kr8KfTHW8lYgwTeQ6svyhYSV/E2PeWRsS0E
   9m/DFnZJGs5tKFAyPtmhb9wfPVhesUyPjlOGDJ+bLjGsl8nkDoxfdE1q1
   WucnlnTW6OaaJeMpILvemYjQBlXqnKxmI3tGyqre43FYN9/8rpl4s2Xs6
   cb4EWdAfQj8j5FsveJkZ7todIHsI8icICPwL4NXp/dMz/Y+sxVMMuTT3l
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="308528802"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="308528802"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 13:21:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="599353096"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga004.fm.intel.com with ESMTP; 01 Feb 2022 13:21:10 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 1 Feb 2022 13:21:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 1 Feb 2022 13:21:09 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 1 Feb 2022 13:21:09 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 1 Feb 2022 13:21:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tc2vd/H1PTuFb9+NR0zB9d6qxC2auQ9v7O6pIkjyn4gOA2d/b52wDzDMMvTSVy05K0hroS7igmxlPNWs77jsIZA7VEecGNZgT5VyK4Si5AuArqrMEmJmoW+rmABTLMmUCCAQqFLLhgTe4B7nuXzIa2wD7t5BdSHOIDB1VmLEEGDBMyNVr1XjKtc2/bprkoM91mlusCR7MLF1spHB4GypOP2MMYT16OU+ht4MZ22G9kxHgS1flQo+u9e6LnBIV5Pl6yesG5s4ko35YvVSf0fshAls36uAn2uN46BHQzDranQ59QGedfFlO6Bpsnf5lVg+mrfHgrzQyo+dDlZ1uY3+rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZYdAo+ayiDLGWNkhGjTT/HW/LiOvf4WmWDqjQRH7JI=;
 b=ixPqoMEWMbi2gmnkdcWP5f6nbFNYhbAc2V4pSNUM3rbKgwwcKe6Bojc4j1sUsisFeQEJOyCGG+VCshv1MWKMnx8mWm8/Pgex82kokv/sJYcb+nt3ey9eEpgEips1TAZq05Z1yk8AeZyUqMlYAOmgMyBaj3zk9PNqx+sNqqNey84U6Z+vcXCwKfftOJ9xXyo7CzJsReo7dGUc1bz9LDGs4ROIC+CN6Laa2KVOJ/EoKzZf3kVG09PGeDF5I2KFAWf29ITcxsTzK2yX/x76A+7p5MobrGmplB/4xL7yOSoxAdVMzHdgnJfsEj5xkCY+Pa4I8JaOzrDuBPrWYhSBTg4giw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
 by BN7PR11MB2547.namprd11.prod.outlook.com (2603:10b6:406:af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Tue, 1 Feb
 2022 21:21:06 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::44ba:c91c:ea6c:118d]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::44ba:c91c:ea6c:118d%4]) with mapi id 15.20.4951.012; Tue, 1 Feb 2022
 21:21:06 +0000
Message-ID: <2aa3c5b3-0cbb-1963-62ba-822939e14cb9@intel.com>
Date: Tue, 1 Feb 2022 13:21:03 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-next v3 03/14] mptcp: handle local addrs announced
 by userspace PMs
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, <mptcp@lists.linux.dev>
References: <20220128003836.2732694-1-kishen.maloor@intel.com>
 <20220128003836.2732694-4-kishen.maloor@intel.com>
 <7f767e0572a9897d461e5b3cb1546811b024bd18.camel@redhat.com>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <7f767e0572a9897d461e5b3cb1546811b024bd18.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR05CA0082.namprd05.prod.outlook.com
 (2603:10b6:102:2::50) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:9e::21)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9e52ec3-6bd6-4a28-945d-08d9e5c8c1ea
X-MS-TrafficTypeDiagnostic: BN7PR11MB2547:EE_
X-Microsoft-Antispam-PRVS: <BN7PR11MB2547D90FC40961DA0313CCD5E1269@BN7PR11MB2547.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QXmkOyTHu/c1yDUZrNn+XANNyl1j0idDlq2ypbVG2TIfUuKQgnEtTfBbkn1GKf+43T+rx4nMJ4tbnqcz1rIbrzimfDQ82MA07qKaqCcB1gNh3UlwqwX2jGo1Xh9SyZNEVaFRRRxpAelT61U0Ux8S073fBBr2B+UNbLq4EfeP5AyN1cYnFOp6PVqOWuYYHUT9OYWALB2Ynjhr4IjCRcCqxxNggaGq2BUXJ2jDRpD2G0Ld4uYRy0RMUYalMqUELBWY/rLpNde98nPXMvVs7xFjJvutyA1Tv3Th6qmfN6X/NoB2BoisnaAd5zYvfOty92TP+gVX3p+/TyDTgPvE1YDEHwJ6EUlw6Xt1H9iPQlod0F+fTijr6SABzmjuu9niMvvqwMMC9RubxNYh9dhSqLxsEG/niN/uxOb8u1HJ2mccrGiHrOxolo8wiVfMjhhZT/zmCZhtQ2XpzTvqWuCIuKXOFdadZhOMxwVHY9c9WOgloNY2MpGijksMpPrWr72ySvNUtLuKXnLbacyCU16n9Z6siezJPrqRMx3MpWE5x/vKSfYZmUByC6KAIKTRLEAjlsmu9NfuzgbuGeZyxiUM2etoQfLn25rp43eBGi0uFEt/m7+w719iUGnMwzV4quaOEWneBflws4pyuTbEr3KT4YIvoB0U/PHZk+55wY3zzesHQZgsosRZdwvsRqTg94QBmhy5Ld7Av+NpV2R2GZsQP9JIk18fL8mVRxnaiGbmmPAQCPU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(8936002)(82960400001)(31696002)(66556008)(316002)(66476007)(44832011)(66946007)(86362001)(5660300002)(38100700002)(83380400001)(508600001)(31686004)(53546011)(36756003)(2616005)(6666004)(26005)(6506007)(6512007)(186003)(2906002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkdQdXNWKzZsT3Z1L3gyVWhGSWZtZ3VuS2ptQk84Q29vdTBsTVFlMnppS2xG?=
 =?utf-8?B?SDJMLzhTS2NHVVdJN3hMWFZaeXBSMGtkUDBxS1V6QTQ2VVJoN1pWUmVFd01z?=
 =?utf-8?B?UkkxOERWekZ2RVZxSU5jdllLM3hHREkxZEZua1FTTnBVVDJoVkdoQmFscStS?=
 =?utf-8?B?RHRPSEowT1liV09XaU9SMnVIenRRTG41TTI4WXNZb2MxRU9mN2NEL29icE16?=
 =?utf-8?B?YzEwTTJRVmtlYmtxREFoYit4dTA4aXltUjUyUHlVd2J6WHJjRE1xeWV6b0dZ?=
 =?utf-8?B?YWd5MWZ5ZDZEK2UzSU4yaFhFUTgyd0paVEpwSTJTeFdMUFl1UW5Mc1RPcWQ5?=
 =?utf-8?B?RDFPL21CM1YwNWZrOWVtYldLZXl5NGJJelhXWXZBQ0FwT0ZscDFRYklqRFg5?=
 =?utf-8?B?OVUxMWN5MG85TGZtcHEzSW5KbEJxSFdjMzVUaG1aaEFhS3E2cUVjL2F5ZDBN?=
 =?utf-8?B?L2s0bUVSMHV1dkd6ZDJvUEZoWmRiVjRGZDk0UVZMbmdmZXQxWEN5eTNTVGNT?=
 =?utf-8?B?bmc2cFNLRllZM213TWMyT3NxRS9VemFVMDREbU9QaHlGZ0RFaXpWaDhGRUpL?=
 =?utf-8?B?ZVBkTnJ1cjZ2dHFHclVENGZBd3lUU3RmNzVZck1XTUJBVFJVV0NyOHdVZTVS?=
 =?utf-8?B?VG04ODBaeHIwVEU3T2lJZm9heWE1dkJzUmZaRkwwUlFPRTluVEdCMTRJT3ZD?=
 =?utf-8?B?aVp6cW1iRGVTckM3N1p4Zkh3WXV2bzB0Q3FVNUI1WTJOT1JhNUdaTlJRMHoy?=
 =?utf-8?B?VkEraFIyTmtXMHFreFpRWjJjTVIyZ1ZFK0toK3dhU3V4alZ5V1RGeStJTS9S?=
 =?utf-8?B?NHZQWHFhUDlBNFI0K2d2NUx6TGJsMlFTVWJkOGszd205M2lkaXhRS3BuaEZ6?=
 =?utf-8?B?R0JSR2FHN1Rvckk5ejMxN21zbjlBU0JyY0k5YlFlamJqWUJrYUU0MXF6SGNm?=
 =?utf-8?B?V09VQ2pDQzB0UXlmQ05DTzArRFZhM2RGdTVNVTdhZEhTaXRZKytCekdMZFZK?=
 =?utf-8?B?aElyeDg4UXY3ZGFpNG1HVUV0S04yY1hjUU9XSmNjM2tTenEvbUxYL3FsWkJV?=
 =?utf-8?B?ZFF3L3gvU1k5SysxVWFHanJhV2Ewd0c4K1JCNC9BNHRqRUFOQVNtYSs3YlY0?=
 =?utf-8?B?K1o0dmhEd2pnd0dxajZReE11QnR5bFBRWHQ4QVV6eHVrWmxnbjRNaDdOeWJj?=
 =?utf-8?B?azFzTlhwWXhlbGJLWGkvNFV0VTk3aE5VR3g0V0MzTmMzMFpRZWdMYWc3Q1Rr?=
 =?utf-8?B?dkdYa1BNejJ1K0UzUllLYjNrMnJIWi9kdVovMVFHWm52Rk1oQ3VJazBxTllV?=
 =?utf-8?B?Yi9QZnh6M2tLTGZJYmpVNE02Z1BlbWYxYTZOd1hEUDNHT3NlZ0h4Vjh3dzFn?=
 =?utf-8?B?UDV4VGpNeHgxNnVENTEwZkFlclVsQjg4TmQvQnVvL0hkbkNBeFJiZzBJVW5u?=
 =?utf-8?B?eXoxSXd1K2I2QkcyY21JWmpKbWtwdEp3eTd2b0RCTWVwVlh2dWFnRkNZdmZz?=
 =?utf-8?B?QmFrYVBwR3Fyb3FpYmNqTTNZRzM0d0twTEhPeFo2WkptSWlwRVcyNk4vNXNv?=
 =?utf-8?B?TmJ2ZS9GQ2p0emt6SmZ4S0RTRk92OWxSbFRreUFTWTZORUlHL2RhODR4WEo5?=
 =?utf-8?B?YURiYVZkYTdxZ3VweXFhdUhoV1FsNXd5bm5HbTh2QWV3VFhOQUZxVWxzcTYx?=
 =?utf-8?B?ZkRtYXFCa1dFUVh6Mnl5NXlxQmtIUHNtMy8wVERGa2FBcWlWMTNHbVpqVS9z?=
 =?utf-8?B?VFZXdUlKUGZWaG1EeEpYbW1EOW9CZ1NKYmZLZENhbnM4R2RyazQ0MjByT0R6?=
 =?utf-8?B?Y08wdjUwNjlVV2hyTERHdXhtRUpYT0N6dTkxNmtUdTFwaUkvbjNyZ09GcFR5?=
 =?utf-8?B?QklvY3ZnTDFOakJLRFVvM0ZQRG1HeGRUeW1qY2JNdld5UnRIY0hHOWM4MHlz?=
 =?utf-8?B?NGtyNFBiZjU1cUUzZnpXWGMzVWFsTmJxbkk0UHJ5ekMwRWVaME84Y0syc0ZZ?=
 =?utf-8?B?YWlsdG1Ka3pIVVJmZDk3b2NaWERINXVpZU9GNStWakxJb29UVjZqMlYzUUpj?=
 =?utf-8?B?UU1ReG5qMEJicXF4d3B4RXhFSUl0dlgrTWk2YU9BSTVPc0RMbG9JU05MQmQ3?=
 =?utf-8?B?SHMwcjAxTzI4elhrSTFEMXh5TEtpdzlkeHhTSUZFU1hJeFRUUklJY1N2NXgw?=
 =?utf-8?Q?MHoGX47rPqc3w3YtmVK/1tA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e52ec3-6bd6-4a28-945d-08d9e5c8c1ea
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 21:21:06.0325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fEqNlfzI5EmxpwwkSg8geD8j97U7bbDwj5riwESvOsFqmcoY/XdL3XBS6fFUd790MVRYUaoPCYQedMUkP1V7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2547
X-OriginatorOrg: intel.com

On 2/1/22 3:58 AM, Paolo Abeni wrote:
> On Thu, 2022-01-27 at 19:38 -0500, Kishen Maloor wrote:
>> This change adds a new internal function to store/retrieve local
>> addrs announced by userspace PM implementations to/from its kernel
>> context. The function captures the requirements of three scenarios:
>> 1) ADD_ADDR announcements (which require that a local id be
>> provided), 2) retrieving the local id associated with an address,
>> also where one may need to be assigned, and 3) reissuance of
>> ADD_ADDRs when there's a successful match of addr/id.
>>
>> The list of all stored local addr entries is held under the
>> MPTCP sock structure. This list, if not released by the REMOVE_ADDR
>> flow is freed while the sock is destructed.
>>
>> Additionally, this function enforces the kernel imposed limit on
>> the number of local addresses that may be used over a connection.
>>
>> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
>> ---
>> v3: incorporate the new sysctl configurable limit on the # of local
>> addresses that may be populated by userspace PMs
> 
> I think here we could use omem instead and avoid introducing another -
> possibly hard to configure properly - sysctl.
> 

I will look into using omem here as an alternative limit/bound to
the sysctl param.

> /P
> 

