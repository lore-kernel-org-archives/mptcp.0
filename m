Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD992C9C
	for <mptcp@lists.linux.dev>; Tue,  1 Feb 2022 21:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643750525; x=1675286525;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SuwaG+fW+tqHOdJ0qmTA5gHE+oULk5OXswKimvpy6p4=;
  b=dWFuAfr/jLjZjen+EJAVF2pzwQByiDoE+YlYyGsvX9wGSCPOm2xjOOS7
   ckBt1ph13rpotPrlDi5gGymsUio6D3mHLmLz4uo1rdeaYyfEY7vQXfX/P
   hJyC1eg+5p3bRVHLWPfpirX9RatrtJYJsA1WpiReSLIFCKubrXq1E7Red
   Y1fkrNZ9vt6irdsZvyaDKF1R7vnVie96YnVvbMYpFAPOdUh7cUicKcRyJ
   tGZGQfd0q1+39b6OPAhNMeN8WQNeBlA2kKOdBOtEQeLdwtdkEBhgncmSN
   N/tBbeu9yzNvGz+yO+YAqq5PlxOm9UpqBPT9AJkV/r0pVuK7cngGXbW8t
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="228454521"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="228454521"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 13:22:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="599353266"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 01 Feb 2022 13:21:59 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 1 Feb 2022 13:21:55 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 1 Feb 2022 13:21:55 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 1 Feb 2022 13:21:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROtLZwnKHotUj4SCecCQEyBQz3a2XWHE9V2n26iJ9VQJ96WJULBIbMDXx4lhhsl61I2p//UDzsYL2WU1es+yrPoSw51alNlB0/R3O7nMCGkInlekfX47zyu8GwaboKavMrVsgaonM5QNts28jtoGlasLo3IaTvQaSwkMdojCt84JIi4N+ca3mFNrIh7foEeI26kubYiem8jMCDigD7gDku4Xo5PtL0Px58lsfm+iEKDE+Ib5BBoCT6rXBmebhECZ7pbSoDNzIJAFOw7TjrBSpmi3h8GNAEc+QrCMIot96gTvMoHVfgsCszzYki0h+HGMnlM18OEO00awDcyYDCqqVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y67eoKDN9r5X4mGML7sVcKoljvaRAQNIXzckFJNJbBg=;
 b=eJBOMD41XZZWIUiudQdSM3psI2FB5nfkpT7JqujW1stdkkq8xe1+i99PhY5VPpPxRHhWjW6XfZtJpqAzjtZbfsUXnlthmc5FMXRxXrThMhS0GInQ9i03QviwDAz/SB+1UlCmo6PGD6ykbTNpujW0+ntu66Qh+7Ed0qr9JQ/rb9i97XV6vP9g23E2uaI7BibHM1+5GYL6iznubjT6TJGbWV5TWpbFTRH3dJvIZsAZgSuZOJSSW9m3ioaoqaqams4xScJtwzQz+DGld44k0gR3BjVk854STTUPrIuGZXG9TpBefTyhdJlVlpmQGqJtkSRPPjz99edf+7evK2FQeWxNAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
 by BN7PR11MB2547.namprd11.prod.outlook.com (2603:10b6:406:af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Tue, 1 Feb
 2022 21:21:54 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::44ba:c91c:ea6c:118d]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::44ba:c91c:ea6c:118d%4]) with mapi id 15.20.4951.012; Tue, 1 Feb 2022
 21:21:54 +0000
Message-ID: <7f32b1f1-838e-dee8-0073-e59f59c46f95@intel.com>
Date: Tue, 1 Feb 2022 13:21:51 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-next v3 7/8] mptcp: attempt to add listening sockets
 for announced addrs
Content-Language: en-US
To: Matthieu Baerts <matthieu.baerts@tessares.net>, Paolo Abeni
	<pabeni@redhat.com>
CC: <mptcp@lists.linux.dev>
References: <20220128003812.2732609-1-kishen.maloor@intel.com>
 <20220128003812.2732609-8-kishen.maloor@intel.com>
 <2a4c2a567359b839aacd3d56d8a7734af5479747.camel@redhat.com>
 <1b10e9d2-cc63-efe9-2488-29a66ebaaaad@tessares.net>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <1b10e9d2-cc63-efe9-2488-29a66ebaaaad@tessares.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0008.namprd16.prod.outlook.com (2603:10b6:907::21)
 To CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff981234-9b5c-4711-2064-08d9e5c8de90
X-MS-TrafficTypeDiagnostic: BN7PR11MB2547:EE_
X-Microsoft-Antispam-PRVS: <BN7PR11MB2547FB622F5E97B8BDDD1DB4E1269@BN7PR11MB2547.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ny7KB7FpXRsdI7nHGlIijgq+wt5XOR3JM5plMU5OjpPsCt+fLD5gMvYbqf4PI29TGojY6Sz9320vJ1/vm/EYn6ELp8Jx7O1MJIahHjbsqfCBUiwx9SAAWBdCiXcmgDfLf0B3vRl8qlRewmvz52JMvtPyMuMOVQRr06/Q1e6tZdcKLR115dcazg2jwEqf7e4TDpR0QTBA2i9uRhFnQJ0yXr0og5xnr+mTx+CYwa587ShA4XgcSClMAMVI2zRynmXlOJAuWNN8k98o34QWLt6od7lqIWtqqSZ9a+wwEPIZoO+Gym92vMCRTlrJ5y3IDaiMmIHOPQrUMjiIDycn2/SGXOGAaXNiYerKNU/mbcIBG71LiHhCIigbSuJPmqNmiklMwIDgeiybJy4uFUrFNlLGOPHRUSFHxtVqwCOBgmzTHjNEA0I0Xs/aKydLuItfF8FQelvOTMvBEb9Sl4XTDkQsEXGxMePD/LeS2shwzABHS82PdcSn7hTbP7Y0oATY3lKal2UFEGLf1f3r9fpfMUgNLWvJpR/vIF3f7uNGVLwZ4mSpjGMC47ANRKanCFMSDcGJ7FyNYFyWpTwKNocH/25OsXeOl4hmwY8BuByInlCeQTBiaOU7ToqNRxXA6WCm7VxUUSm3qtQuafiVsAIq3wkhykalCEus/0NsUadpY0jaBKIKoKVWzsGlKfnvF5SQQtbVsjDJWVhMyMsNVAdPh+qGoHceFk1B3vw1+24dLXAlL9/LDObfXBuF4BytmpMQ5P9tnkXJ4Ang9OmAof28VZWhAkMZxFYGJRiTFQuE76QehjSJ7m4TWaxNEDV4Av8ZVZvD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(31686004)(36756003)(2616005)(83380400001)(966005)(508600001)(6486002)(26005)(6506007)(6512007)(186003)(6666004)(2906002)(82960400001)(4326008)(8676002)(8936002)(110136005)(5660300002)(38100700002)(86362001)(31696002)(44832011)(66946007)(316002)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VW1DaGJJYkVEdkp4elpQSWw0Y2I4SWRuOGsrM2pBWllUVGh3TStDY3I4M3dF?=
 =?utf-8?B?TnNhSlVZZEZFOXErdlFRM3ZSZkxPQ1hSZzhVR0FqSGs0WjFNVktWMXllMGhT?=
 =?utf-8?B?bDJ3d1VhRWhOd0E0ZEMzTkQvQ2F4bmwzYkxPdGJNRURsdU1vcGJiR21zbnR1?=
 =?utf-8?B?NmVHTVBEa3J5NGV5UHFHSW15bmk0SHpTZ1JDaG5RaHVrWHJheUxZSEdOYzRO?=
 =?utf-8?B?Q2wreDlEQjNkN016bnZLTzVtTFV5MjRLSlRWbFhEWjV1QWwrQ1VnN3hNS0Fm?=
 =?utf-8?B?cWk3K2ZWOWhiUGE3ZEdnVkU1ekMzeGgzcDN6Slc3SWo0NjJTZHE5R1VGM0dY?=
 =?utf-8?B?cUNvS09uNDZrK28yaFgwMEFsQStkM0hzK2dFNWdvS1N0UXBaV2Z5U3RycGdl?=
 =?utf-8?B?STB0elFGNlluTFQ5ZmliM1BvMjI5ZjFQb2hJbExXekM3SlZnSytwOEdQYzQy?=
 =?utf-8?B?NENDcDFaZTBSYWpxV2NBUDFrTDdPUTJDZHVUM0NNb3lHNUwzOG4zcHlmdzQv?=
 =?utf-8?B?Y0pZMGl5ajc4eE5NRVVlcSttc0hUQXVhWXNsbXRmdHkrYjJDU2U2b3V4WFhn?=
 =?utf-8?B?OVRCSkNhQjNXc3dLRmdkcXp1dDJaRnFCbWRGbVdxdko5NXpMS0J2YUdyNmRG?=
 =?utf-8?B?Tk9ucmZHelEwOW5BMW83Tk51OFlUMDI4b0ZuaDhQamhyYzkwRVA0dWhKZnYw?=
 =?utf-8?B?TFdIRTBBS2c1cnRKSEFqUTRvTm9IYU9iS2lrczk2ekFGeE1HMGFFZysvQXBQ?=
 =?utf-8?B?b2thNXJRV29KMVZ1MlhzV29vOWluekp4amFHOExCZHpudURkMkh5OStjY3dy?=
 =?utf-8?B?c0pGSDBEd2xNZ2NjTUg3NE9OeEFoZzljNUpEY2s0ampydEZaaEl4YXAxY2RD?=
 =?utf-8?B?NEd6cWlPMHphak5oMVlaS1lHMWFVRkdacE9UTXJSUVV0NDBZalRQMDYvMVB4?=
 =?utf-8?B?eEQ0SUpSTUxhODIxM1hzbllLZTVCNUZrWFN6YXdiSUhlWVREV2gxYUROaUxM?=
 =?utf-8?B?NEc5UFI0WDlQYVhzNFBNK3pxblBxZjJRM01uTjl6YUhMdVVYTmRNeGtsbllW?=
 =?utf-8?B?cmtzanNPYXpoSWwwR0tRUHFRZWZwamJKVVN4MGJicTkrbXJXOVNRamFpdHc1?=
 =?utf-8?B?WkpOeXAwcG1YVCtTVHdrTXVVZnFPRnZ1TXR6eWliWHZDeUVkUXUvcGlveUZo?=
 =?utf-8?B?ZUpxT1c3dlVmRForYWJOa0ZwVHhSeGJ2OHNmS3ViLyswcE1SUDcwV2x5VzBO?=
 =?utf-8?B?UXZsNTNrSFBvWGE1dysxKzE5UUw1QWxVMnp2dFpySW5TWjNFWENsQ3lPamlV?=
 =?utf-8?B?Wmh4dmp3VVRmMjlzdjV0bm1mNUQ0Qm5NRVRKb2x0UVptYm1xL24yQ0dSOEg0?=
 =?utf-8?B?emxkVDFocEdld0dERjF0M1J1TjBjUDdhY2ZyMTVLNVUyS0ZGRTI1bE1zcEYx?=
 =?utf-8?B?Y2ZydVBlQ3RIbGRKVGoyMzlrV1F3WHZUQ0dUQkQreGNsdDdleDRQYzVxRnJz?=
 =?utf-8?B?TWxoU1E1NzNxdUp0L2VYWTBoSDgxWFE5TWlwdkJnci9SalJHd2J3eWFjdEFJ?=
 =?utf-8?B?cEJJKzdkYS9Ic2ZDRUlJbGdsNkZDc0xOYTdCcUVBZWVsQUl5RGFOZWloM2Jn?=
 =?utf-8?B?Rk5icUpnaW0rdjFIWEprWlU4RnIxcWFqbzh4djRaN1B1ZkhPOHB3QjljMVEr?=
 =?utf-8?B?SDNXN0EzWFpJUUs2cXUrcGp0UDZjQ3c5SHdYMWhNcVpUOGlsWHVyZjNid0g0?=
 =?utf-8?B?eDdtSlMrZ2ZlbEFidU51ZEYxNnN2OFlqTUxWbkdVbzJnbkRvRnFmYllDWEFp?=
 =?utf-8?B?aXBab2lPbGhML0loVXVvZzcvZVlGUDdxM3huTVVndHdDMFI0MWM1QXloUDAz?=
 =?utf-8?B?UlRiZFVsWW9rdldXK04wenZUeXY2dW9EaTlMcytMWjMrbitIZllOSytCMVN1?=
 =?utf-8?B?bWFDajdtWENHcUpyTnRTOENiOERuQkxuWWVZeUE2V1FBYzNZaWlpb2lQS1JJ?=
 =?utf-8?B?Rm44MmIydWIydktub2hNeGRPdHRlQTZqK05jKzBUK0xNWjZUd2YwOXhXaWFz?=
 =?utf-8?B?S1ZzUDhMUEQ5R0tRTkMzMHVzYXNuaUZLUy9DQy81V3dyZEVwVDkvMHdlMzZG?=
 =?utf-8?B?K25FcVZVSnh2WDVJQ2dtNnhKM1pTeHFXbDEvVWhZaG5DNDltczBWbTV2d1pj?=
 =?utf-8?Q?TKXICbHpFVMip+g7mvV7Grs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff981234-9b5c-4711-2064-08d9e5c8de90
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 21:21:54.0780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QV/+2I/K41D9rPN9m1LiZJtn+FDWcpCEo0ZUyE6AA2yirHT3cPx4Lyg4IKHdWodI+JXEMCVl10DvgBnnYrsEpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2547
X-OriginatorOrg: intel.com

On 2/1/22 9:25 AM, Matthieu Baerts wrote:
> Hi Paolo, Kishen,
> 
> On 01/02/2022 12:42, Paolo Abeni wrote:
>> On Thu, 2022-01-27 at 19:38 -0500, Kishen Maloor wrote:
>>> When ADD_ADDR announcements use the port associated with an
>>> active subflow, this change ensures that a listening socket is bound
>>> to the announced addr+port in the kernel for subsequently receiving
>>> MP_JOINs. But if a listening socket for this address is already held
>>> by the application then no action is taken.
>>>
>>> A listening socket is created (when there isn't a listener)
>>> just prior to the addr advertisement. If it is desired to not create
>>> a listening socket in the kernel for an address, then this can be
>>> requested by including the MPTCP_PM_ADDR_FLAG_NO_LISTEN flag
>>> with the address.
>>>
>>> When a listening socket is created, it is stored in
>>> struct mptcp_pm_add_entry and released accordingly.
>>>
>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/203
>>> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
>>> ---
>>> v2: fixed formatting
>>> v3: added new addr flag MPTCP_PM_ADDR_FLAG_NO_LISTEN to skip creating a
>>> listening socket in the kernel during an ADD_ADDR request, use this flag
>>> along the in-kernel PM flow for ADD_ADDR requests (Note: listening sockets
>>> are always created for port-based endpoints as before), use the
>>> lsk_list_find_or_create() helper
>>
>> I think it's better introducing the opposite flag (e.g.
>> 'MPTCP_PM_ADDR_FLAG_LISTEN') otherwise this will change the default
>> behavior
> 
> Maybe it is fine to change the behaviour. Without changing the user
> exposed API of course.
> 
> I mean: it all depends if we consider the fact that when the userspace
> closes the listening socket to accept new "MPTCP" connections, it is not
> normal (bug) to close the possibility to create new subflows → socket
> controlled by the user vs socket controlled by the PM. If we do consider
> this as a "bug", then that's OK to change the default behaviour, no?
> 
> I don't know if other people are sharing my view here.
> 
> For me, if an app closes the listening socket after having accepted a
> new connection, it is just not to receive new "main" connections on this
> socket but it is OK to accept new subflows as they are part of existing
> connections (and managed by the PM).
> We would then avoid people hitting issues like #203. If you hit this
> issue, it is not easy to find the answer I think.
> 

I think Matthieu has clearly captured above my rationale that led to this change because
I did consider this a "bug".

> If people know they don't need/want the creation of a listening socket
> only to accept new subflows, they can set the NO_LISTEN flag when adding
> an address with "ip mptcp". But if the cost is minimal most of the time
> because no additional listening sockets will be actually created, that's
> fine to use a "NO_LISTEN" flag I think.
> 

Yes, when the application is listening (which may be the majority of cases), no listening
socket is created for address announcements reusing the subflow's port. If the application
happens to not be listening, then a listener is established, so issues like #203 would be
addressed by default. Further, if the user does not want (for any reason) a listener
to be created, then they could supply the NO_LISTEN flag with the address.

> WDYT?
> 
> Cheers,
> Matt

