Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3665A2F29
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 20:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643919004; x=1675455004;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TK8wJOyBorEDNdAQlMXG5/6mYKIPj9bCduwoYWjli4I=;
  b=jPsdooFtc+lsDUaIFT6zRiMGdo9lmG+EdBtz3itQP0mvC7Q9o7Wxn6Q9
   syzKJry+HRd2qj/WI7d6PRBP4kbDXNMJB8UhxyN4yKKQGzvPjTIs3hREN
   yp/pnZ/aI6BkRgxE1TPlxPrg1TrpcI2WboInIPYn0396c4wdZc/s3W1ty
   H2Hj2vIusNDCL/5M4/lmc26PW+7H0/Umy8yX1ob+d2bD+mCMAjTZnGHMM
   ozhW4cR4eGAZVmvRPEVGu/1Gz5+7GVwvoCKXbq8qntrVyddpIvihBOzhh
   YkteFhL8sctLs1ETPzEkMipuqwNmU27wlbZDsuEr0ZN3f7j3Zwnh9t3gm
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="308973738"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="308973738"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 12:10:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="771899703"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 03 Feb 2022 12:09:58 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 3 Feb 2022 12:09:58 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 3 Feb 2022 12:09:58 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 3 Feb 2022 12:09:58 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 3 Feb 2022 12:09:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jH3wFDOTBXf6ZQlmWPkTIt2emBEN1xtCnysk76ZGXcUXuGB6MkRA1r7F2EArTpAiBcGD+JG0AWJkkQsvR9qsW2ZxgM771yZizhHnMa1FM3/qyWI9P4jxhKNUYBYrt5ibJh2Ci/ZY/jvz/Rqm7UQy232KyMAk2fOWMpfpdyWYl028mb8Iv7h/n126XZkkAWiOgh5JPltFKC1qSfutPVx6tNNMRWWkdOtlbMRxF2dOg0jI3l9DYoiwvwMRnzf8+OCBFbD4lhUDboQI9A6MCF01I03eMdAjMLQ9m+XZ+0bULJie45fmJA65VHABgSK97GIwkfpYf7lTb3QF2FJVS/vi3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtK++0ByRIRA6g2A6j/Rl9goDKwEi8zIueyWo1uFIpk=;
 b=RYVZ+kPzuuOsh9ayV22R6xnC9AFdgjP1OI5RlyPyppHBGD6H9Ko1TNIcm6vcxSvpPedQ6Wp2As4ggHj4tiy1Q8olrFdxuNRFlBpR/LYVwL5d3B3+07gcIGrY/ByUzxDqj19Mipu91iJzCWKP+OFGmBcHO8y0SDFrDeiN+NUxtVabKb8XgOyY6N8ge/WUkfdJTr0mcuYIJAfXSwSLgEcVJvnq1Q/+cf/pYGtCJ5Z5tEqYjx4lUIHhIARteZbZa+5nz3dYKFFv/UcD24TAw/4bI+G3TGAS4O+Kdjqwa2eQRlXrX3oXVqPgS/r2nUSM41GkXdISqtDnppHdydyUZFaXFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
 by PH0PR11MB4983.namprd11.prod.outlook.com (2603:10b6:510:40::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 20:09:54 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::44ba:c91c:ea6c:118d]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::44ba:c91c:ea6c:118d%4]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 20:09:53 +0000
Message-ID: <1517e7e4-521b-6879-4846-024f53c86eaa@intel.com>
Date: Thu, 3 Feb 2022 12:09:50 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-next v5 5/8] mptcp: netlink: store per namespace
 list of refcounted listen socks
Content-Language: en-US
To: Florian Westphal <fw@strlen.de>
CC: <mptcp@lists.linux.dev>
References: <20220203072508.3072309-1-kishen.maloor@intel.com>
 <20220203072508.3072309-6-kishen.maloor@intel.com>
 <20220203174637.GC4901@breakpoint.cc>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <20220203174637.GC4901@breakpoint.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR14CA0048.namprd14.prod.outlook.com
 (2603:10b6:300:12b::34) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:9e::21)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc7ce19c-ffb5-4bbc-2007-08d9e7512451
X-MS-TrafficTypeDiagnostic: PH0PR11MB4983:EE_
X-Microsoft-Antispam-PRVS: <PH0PR11MB49839DA2A12FECD723156A9CE1289@PH0PR11MB4983.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NR2azsK30GIwhBlM2kOqu4El/63E0rPtcsklfStNJd0F6l8m9dIY8SCH5B1HvNy7NDU8yS9TvAqKubwH1HYcN7el6JCVBN6aBkZToyMB9KkkkJf7C39ojc8c7+edqD0DIBA5ls7+D1QWHFJtHf4d3ZBNFxH//XonxGXD4+LPLK80cezIkSJM1C4fNgoiwHRjSiasihaveQWJqb8vahw0mT/gMmdlTNzdccA2GTJeCriTdAmHKyGXRDfyKwk9shVCkwD/SVfGoaR56nV6MIVjU76H6JknGaOL/vZps9jeig3dD1FNi6JpQU0+p/Nr1pOm2IBP5K6wfhZqM77G4o9ZtCr8eS9YOikWv7Ma5m4Qoe1/L+JyuM3ldWssOI2WNjetcW1jn8gbtSEgiV6BxaBOrOb9/wJASxSP0hzMzcwdYwvOq8x+A620il5ojL+uVKweIjGOxiClIZMEjnUEu0SB4097J5OVOiTen6QspMJWBCCO0hqpX1SX2JNFRKwjcjv9RFsK/35UpyhBOtBltTHq725tJ8xQW/1nTpZGIQX3Nt5mH74IgXjNclAPMOtiP++p7nBNE06OusK7e1gCDbIZmp6mhg0m0J9WXS+z/bxXc+tthYV+0x0rcDeQUzcFwINhMcMQPVSCdN0zPuNwrM2ickBn29OawlJ7KfqYK/VQ9tAw9XtH/Hg+fX/R4UP0kj7moc7QoraWThPCRwSc231tirPRqEpx6uEwfbWoOH1LpSU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(66946007)(8676002)(66556008)(82960400001)(66476007)(86362001)(4326008)(5660300002)(6916009)(316002)(2906002)(83380400001)(31696002)(44832011)(38100700002)(2616005)(31686004)(6506007)(26005)(186003)(6486002)(508600001)(36756003)(53546011)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVRjQmQ2UmxtaUVUNHJacEZnTjU2a0o2SGVaSEkrdlIxYnh3S1lSU1JXd0hK?=
 =?utf-8?B?VEo3c21MTmtEMDRCcitsRUNzdGFndUxQWEFpR0I1dHNiSmk0Vk5zRVd5TWlB?=
 =?utf-8?B?c21URFFDRElaUXJMY002Q0czdzFtbmhMRktqc0t1aTBXajg3QTZXaXpLOXhY?=
 =?utf-8?B?UjRSK0o3NFdwc3B1NzNpclpXRUlNWVo1Rk1hODVJdTNDYlZFY2NJdHJjU2RJ?=
 =?utf-8?B?dGpYR21lTy9wZXdjV2d5WWJLUUtqVUxqWTRmMENGUUwwOU9xN2haZXBuY2pl?=
 =?utf-8?B?QXdZQkJGYlI5eGJFSmFocDZsbTNtVjZ0NE5MajFlSEp6L25MeXU2QmxQMWdy?=
 =?utf-8?B?Tk1NNVM5elcyV1g4d1VNazFRNTdxR2Nta1IxRDlOcHIvUXoySXZkazErcjZT?=
 =?utf-8?B?OFF4OC8vTUQyVFlYQXU3eUNRYmVCekYrUG5uUEdvdmdTeDdNTmFxdlJ1Q3lR?=
 =?utf-8?B?ck9SYWtHSTR3T1k4RWZ6c0grOVVFeWNVU3VjanFGNWo3OUF2MmhyWFZDcjVk?=
 =?utf-8?B?c3pFWDZWWmZyMTloaWc0cDM2RFRhVDVCTHRyVG0zQ3Jma2NiWlVreTVsM2t1?=
 =?utf-8?B?d2U1OFhzMW1naGFlUkhJYU9KUHZOb3dydUFmaXVVVUEvcHY3MVdYaDJST3hY?=
 =?utf-8?B?Rnk0QTlRRXkxT20xZDNlYjZZZStzQzhqQWIwU0FFaTJRY3ZkYUxzNUVtSUVQ?=
 =?utf-8?B?bDFsdlBRUm9GaVQxTFoyMHNwNGN6alRkT2lXa1pWM2pWdHROWUJSR3hScVNI?=
 =?utf-8?B?Si96cE5RNWhpRHptaHk2ZFc1MDBBNHp1VnZ4ZkF6OVpDMkhhY0U5aWFpT0xn?=
 =?utf-8?B?NG5NWDlVbFpneUVQcktVWkFYUm5RbUEzYmYvanUwOGMrOEVDWFV2ckE2bXdB?=
 =?utf-8?B?VDZXVUZYQTQvUkM1ZVN4MksxRkhONis0R2ppZkpIdVNYdElDWGp0WnFRakh2?=
 =?utf-8?B?eWdSamtrWFhaYjh2RjRUNVUraHA2dkJTRXdYSUx1WU1MYU5vMGtaUmNNSjcz?=
 =?utf-8?B?TWVZQmZ1amFDMWw0N09kdUhPVlJEeFhGNVZkRThvSU1FeldRVUttYWxEODVQ?=
 =?utf-8?B?OEFpNG11OU16VmN2NW9aQURTaEV0NjdLcTJZM3VmbzNYYWZvU25xazgzTTEv?=
 =?utf-8?B?eHBMYXdLQmlPTGdLV2tYNTRCaE5qSjNnUmFvb21vQklXOTU0UGkwazdQb055?=
 =?utf-8?B?dGlYYy9wVHU5WStSM085RjRwSmRPOHFkYjM2OWRTcW5YRlFQQTlES2o3L2hH?=
 =?utf-8?B?eTk5aGFKa1ovWGxpV1ViL09UWDFlRGlTUHVyMUpHMUtrSlQzdUEwZDFBSDlk?=
 =?utf-8?B?ZjZlL1BvekZqRWhVKzlFUyt0UHBIOFFvR0x4d2JoME9jak16Ykp6TFJ5elhy?=
 =?utf-8?B?TVZYZnBtN1hBSmtwb1RNQk5FaEo4enJwdyt0UCszL2JidHhTQTVCd3NaVnFs?=
 =?utf-8?B?UnpmNkZIRnlIMVRwL2lZNlBjaEtoZU82Q0xqWEpOYVhkTzk0UTZyWm5rQUlP?=
 =?utf-8?B?OGRya1lxNG5od1BIVTBIb1NmTnhBRGd4T1VXdk5GVkpKNkR3Z2JJbGx6NHZt?=
 =?utf-8?B?WUNrajZMaEpaV0IvZktQTE0vTGkyNVB1dFYrS0Z5cFJkTjR0OU1iSTdtOXdU?=
 =?utf-8?B?RmRMZ3JLYmxJbC9DQUcrK2srblNVdWVxOEwvalltWGhJeXM3ajY3QjE1KzJN?=
 =?utf-8?B?KzFmZUViVnlLZE9lRGUwT0pkMEdqc3J5SmU0SHg3cXpnM2F3eEtsTkhzaXBu?=
 =?utf-8?B?cnVHT2JjRVp0elpmbzF6RkVVVnZXMWt1SjkzNVJFcWJjcSsrYW9rWGd0emZp?=
 =?utf-8?B?YW1iVlhUcmxkZ1NzRm1lNXZEK1BDQjhiT1NqNDNoWFIzaWFyWHVYcnhPZXNU?=
 =?utf-8?B?d3hSYWdPcE4wSE5hbS9GMXR3SmJPRmlYNGRpU2UvbDYwMGFHTC9QRndnWlBB?=
 =?utf-8?B?bGh2Ry9kbzgvSkRNNWQyaHZRazdydFdoNE8zcE40YWtMVTN6a2NFY0Jualc4?=
 =?utf-8?B?U0F5Si94QXZXSEcyeXFieVIyNWQyL3ZJQTFETDhTRmVYdW12QTdsTTZmUTBN?=
 =?utf-8?B?YzZPNFR6bWJab1B5R1RXNktFNlVoNWJDaFo0c1R4QVRuNjFSSkloc1ZTZXNy?=
 =?utf-8?B?TDdITTVpUGJBRjN1L0Z6QmREQi9pcUVYaGRPS1MrQWJncmFwc2VXalhhaDNy?=
 =?utf-8?Q?kAPLIApzdQ0Ae3Mc4nNLAXc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc7ce19c-ffb5-4bbc-2007-08d9e7512451
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 20:09:53.8705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jBYMuZRfuia/WhXIrYLQs7EG1sCgLMDX65WP5vUUfV5JFksE1OPu9y4g3vq9NgqSs1ERnMfOJ/sfowcr9ZBZPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4983
X-OriginatorOrg: intel.com

On 2/3/22 9:46 AM, Florian Westphal wrote:
> Kishen Maloor <kishen.maloor@intel.com> wrote:
>> The kernel can create listening sockets bound to announced addresses
>> via the ADD_ADDR option for receiving MP_JOIN requests. Path
>> managers may further choose to advertise the same addr+port over multiple
>> MPTCP connections. So this change provides a simple framework to
>> manage a list of all distinct listning sockets created in the kernel
>> over a namespace by encapsulating the socket in a structure that is
>> ref counted and can be shared across multiple connections. The sockets
>> are released when there are no more references.
> 
> I think it makes sense to work on a hook in tcp v4/v6 input path
> that gets called for th->syn && !th->ack && no-listener-found case.
> 
> The hook would:
> 1. retrieve join token, fetch mptcp_sock and allow 3whs to continue
>    if things look ok from mptcp p.o.v.
> 2. return "go ahead and send tcp rst" or "mptcp magic, skb stolen"
> to the tcp stack.
> 
> This also makes sure that plain tcp or mptcp connect requests will
> not work for addresses that did not go through socket/bind/listen API.
> 
> I will try to prototype something next week.
> 

Sounds good.

> Given that hook lives in an error path (from tcp point of view)
> I think its going to be OK from a upstreaming point of view.
> 
> It hopefully avoids the need for "magic listener sockets", and avoids
> kernel fighting with userspace applications over which address:port
> pairs are really useable.
> 

Will this also obviate the need for listeners we currently create for port-based
endpoints?

> The latter is a concern IMO, esp. with reuseport and other round-robin
> schemes, I don't want mptcp layer to interfere with other application
> running on same host.

Indeed if there are active/legacy TCP deployments that cannot be reconfigured with the 
NO_LISTEN flag, then we could choose to stick with the current default behavior
and introduce a LISTEN flag (and additionally a NO_LISTEN flag to not create listeners for
port-based endpoints as discussed earlier today). Further, if it's possible, we could 
also update the MPTCP layer to not accept MPC attempts over listeners created in the 
kernel to address that matter?

My only immediate concern (on the surface) with your proposal (which may not actually
be a worry upon assessment) is any potential risks of spurious MPJ
attempts over what might be a "slow"(?) error path - just an early thought for 
consideration. But look forward to seeing your changes!

Cheers,
-Kishen. 
