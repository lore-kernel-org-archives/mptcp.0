Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157FB29CA
	for <mptcp@lists.linux.dev>; Tue, 21 Dec 2021 07:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640072660; x=1671608660;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VuiJ6rOxA8x5XYvLI1Ya2ZPXbTl5kx+6sFfF+qseZf0=;
  b=l5hXptG5DhLzSrw9QLcRSlY+haOzDHwVm0zKxg9wwR2KwHCdEsKG9Awi
   CMblrkKQBunLsc98cZ7YtLrKXJPSLkE8vVVVjUhIvmNzyB/OP2xjL4hAl
   IO2jS7Kor58q6l74qVNLCJ/tjvuSa667NMVwt85OgyW4SIw6+ru/VTZDB
   TCjYtvxvWyIxMeOD8FZCGemIlh15AAcirf2nBSpJQnXpXl+bMMi3/9hgq
   65O0zusBtuHWTmOYW4kajro0oZCwVMSRhtGYTKeW1wpq2AaS0xsQDdEtl
   JZibA+IR9edxkS1ccTde3DP2JeYO1WwNwiE+jbSRBLtMQnbvkEnAbU8pB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="326645200"
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="326645200"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 23:44:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="466210899"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 20 Dec 2021 23:44:19 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 23:44:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 23:44:18 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 20 Dec 2021 23:44:18 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 20 Dec 2021 23:44:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fopO6fmO+d24isCI0Jm8+5n7dcoXzl7nTH81xw5TL3rkqJ1Fx4l9/4hufgEd712lVnouPNZUh/a/E2tKWXvXL8D/4G7Y583G0BWGBAgET35d+pkRrpUBOAeiW+uHow3mfBQDa6C17Oi2rDQAaOBk84wV1/ItVvH0Qy81TZLInwN6qIw9UIjKZrrdKLhkfMvQzLaRLHkQ5x6yCzA5uMvbF2QhF0PlWmgPisajmVcfTJQDRVagmwzSd3oUwjr3rsZp33n1a10CVPgwSww+d8KCx7rIeiLXfaExs0f/7cd8lLfcrmjThr1r1wUvA3/xFAMcjL6XE/jUBbk/Lu8ak04wzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJGLYHHH6y7zSgKALUkog8pGNUuqZmmgEEsGUtOi5xs=;
 b=XqXEMQS9/zHGs3luWKVurA55x04PsxeX37iKH2lunVmfQM9VBebTWn5mRsU96Xlmc4Bvhr5xnb012QACZ0/DHFhhZJw1o99uKzRzkPbs91tRG5S+D0xExC2inObxetTt32dB3drkBYtEcIN6l7lOKLagQ42pMktikT9ysivS8OWy/0Fl6IQD2PpJBsLAxqvnZ/qsMuLDo9o1OXpNvAWUJDsRqYDca/C4lkqoZiyZVTgE54KfDoykpHpCiJJ3anFqEINLjysC9wnbE9jYLT9h/7KuGR6w6IWfkF0t6lkdCVgtL5S6Aj+0bf4DUi828UUEtN+V7S7jgbGTY8lvHOi6cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:95::6)
 by CO1PR11MB4964.namprd11.prod.outlook.com (2603:10b6:303:9e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Tue, 21 Dec
 2021 07:44:17 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::c41f:17d7:bed3:7888]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::c41f:17d7:bed3:7888%9]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 07:44:17 +0000
Message-ID: <b1f32100-b571-6e81-98b0-ce7d380fcb71@intel.com>
Date: Mon, 20 Dec 2021 23:44:14 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH mptcp-next 08/21] mptcp: attempt to add listening sockets
 for announced addrs
Content-Language: en-US
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, Paolo Abeni
	<pabeni@redhat.com>
CC: <mptcp@lists.linux.dev>
References: <20211216222314.1244708-1-kishen.maloor@intel.com>
 <20211216222314.1244708-9-kishen.maloor@intel.com>
 <36f0c0b90d362b0f6a2ab02ba1f192eb87481752.camel@redhat.com>
 <c44c731d-6031-7ad3-7270-979436ae6816@linux.intel.com>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <c44c731d-6031-7ad3-7270-979436ae6816@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0110.namprd05.prod.outlook.com
 (2603:10b6:a03:334::25) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:95::6)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 033a18c0-a9ec-4029-ccb0-08d9c455b0dd
X-MS-TrafficTypeDiagnostic: CO1PR11MB4964:EE_
X-Microsoft-Antispam-PRVS: <CO1PR11MB496496B04504566174476155E17C9@CO1PR11MB4964.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yMrIc/uL6xl82EjUKOVdsDbV6MYOoMyzQL9QSGXsPltYyDWmr7gKYRyj8I/JWIpzHGQl92W94eSsr0iLQJeYaDLnkPB22jL3U+zINqmlzSuMdKaeiUUExwNu60shpnFXv3/f653ekGEvFlLiKI4ECgf4tBtzEffGnBteAhiTbL43B6apwGaeCDb6FmbZIrX9nbEcvhza9/AJRrShSRYlXRAAYS8o37ffPYFaomDsumAM7IekQIhf/iepL5JVYt97iPWj1jIxUfXUL2E2NfzaONjz3M9qEa8Sal6pDO8KVK64LVTUWHiwGutQ5Rz8Seq5QY0e76a1ouGMaIqFNdT0TyqkT99Uhn+ydfF2S4bL3mK6K6kRAcEOewG2Su8kGyTpXApM3uNR7jjlTkUfCx4KeHneDquhxx+Uw5PL+v/p4qDGspbnwyNbKjVJCO0liIP8aFuKF/Ws5mAjP7AyLwJ1dpYueJu6+qkk9gPGKqL5F6YLHUwYePfymE4plul6NxyiYBxo+PQeaPB5lESddGls0QtdZ1bq8gtwvrG6+pOQsPWTOsZYNHQNc4IeoSmDUqmM1teuJJFF+M0QGEVmvD9VccY+2A0QnvvXLnr1Qgg7zlD4DAWUDwpZ1HyITiWyLTp7wprj/zP3HpcvSSJtrN7l5Z5agT2mUhgV3Ynaj9yzNCqcpTvvdB+PJXC7OZ8HMbN7UcenIHL8HblIz6PkcRGt1uRY03y3/KzacpmzMt0Z3VI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(36756003)(44832011)(8676002)(4001150100001)(83380400001)(38100700002)(6486002)(4326008)(31696002)(316002)(82960400001)(86362001)(186003)(2906002)(26005)(508600001)(2616005)(66556008)(66946007)(8936002)(31686004)(66476007)(5660300002)(6506007)(53546011)(6666004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkpURWJSckhFZDY1SEtxQmhUcks1ZWd4RHhRRnRBbXI4aEE0U1FGTUVtTWJq?=
 =?utf-8?B?Yno2dlBtNmEwRGdkZmVIbjFSY0hOL2wvaVpZdHhPN0d0U29iWWh0U3NSc1Qr?=
 =?utf-8?B?Q0xXckdFdS9WN2VJQXBKcGJhVHpEenNlNXNpMDFMQy9nYkxWOEJaNmZLVHpX?=
 =?utf-8?B?Y3VPZ1JqMjFqRURKWFJDeDg5SFQ4ajk4VUJHRno3VHNGUytyeExRdnlGN3Mw?=
 =?utf-8?B?VmlneEptNjVhTklRc1dYL2FTNGNEVHdSSFlvaThLQVF3YkVNTVZEUmk2c2VI?=
 =?utf-8?B?M0Zld1d2QjgrUmdMNk8rcEk1QU82NDdDSWVGV2Ftb2lhdkNFNUt5QTI3R1Qr?=
 =?utf-8?B?dWRiYjdXcmdVVXZvQ2E1aFEvbTBNZzd4bHRUWXpuZjM2ZjFBVjJHLzFzS1hR?=
 =?utf-8?B?SEJxdFh1UHdXNjRwMFBCa1g5WUZVdWV2K1hnYTVuNTAxODQ2NVkzcTQrbDNz?=
 =?utf-8?B?eTBkaEsrOENDVFFXT1JrWWxkbVdyMjVtVVlYaFpRbDU1UkJDY085dDVpTFhM?=
 =?utf-8?B?ekVYSTBaVmJWcHc1WG0wS3BXRG53VEpGRC9peHg2RDJJTGtTazhCd3BXaWl5?=
 =?utf-8?B?cTIwQVY5NW1hbEJ6NHlDRzc4Y0U4YkZsNUg4aTlKZXMwbE9Tam5mMVAzQTdV?=
 =?utf-8?B?UVRaWWZRNldJcE51OC9sb1VMYUF4RHdLSG1RYnJNSVY5a0dsaVdoYlpSU0Nw?=
 =?utf-8?B?VElSM2FOOFpGYWx1MUFBTGw3di9Ta1VJOHV1WGxzRmc1SjU0Z3JBNHZDUnd3?=
 =?utf-8?B?Yjc1eFNmZDAxMUR0VWdyL25Pc3dvb1NIRGduOEFtVTR5bVpTZTFtelNHUjBs?=
 =?utf-8?B?WFBPZ050KzJuOVYrNzlhU3lXRkJRZDAycTBJT3lIN3ZUTUIvczJuSlR1ZHNy?=
 =?utf-8?B?Q3BLTzAzUmc1MWZpZ0JGUCt4NDlVUG5kWkZsVWIwcmFWaE4wVGVXM3FDcXVR?=
 =?utf-8?B?VFFmdW54b29hSkpySDgzczJCMEltQ1daQkxVU0JXV3phWHU2cXJvVDNKUlRC?=
 =?utf-8?B?SWlIeFFtTVFTaktseENoV3hMamllMEx5cG1lK0I4dDRXQmdtd2dLeEtGZkZ2?=
 =?utf-8?B?c09SUEQ0bDgra20vb09jdU5ISWlLYmV6STZidFJGV2JHck51d0pZZVVZalkr?=
 =?utf-8?B?dzZTL3V1VnRCa0FiOWxDS0ZoNEpKOHd0am5xcE5acFBFZTVjaW1pZ1oxV3Bn?=
 =?utf-8?B?RlVwaXdoR2J4TkdEZXBwTFZPZGprTHdWUXVuR2RNRFhUQ21hanpJSkhRRUdm?=
 =?utf-8?B?eUdMNzdpblNQaENNZXZlOTRybDBlUUIxcDd5cGJMR2lEWDdPN2tZTlp6VjBS?=
 =?utf-8?B?K2Q5MWpqcDRTU2piQ3h1UGxOamNHNnZCNW9IY0R0ZHd5WWROSmw4cG9jUkRt?=
 =?utf-8?B?elRoVHB3QytHM2Q3OU9uUGh2MTkvOGc5QTJzNjFDbk9kRlNwazh3R1AvSWdi?=
 =?utf-8?B?cXRuUENrTCtUdzMxZ1MvQmc1V1EwbUtJd2ZNS3VUNU1aQjc4UGpHM2VLM0xX?=
 =?utf-8?B?WTBoWXN6bzJUSURwSU9lQ1JmdDNBZjRINWR3eHBZdVFKdFQ4b3djUCtQQ2NB?=
 =?utf-8?B?enJBQWtKbHdFRFV1SFlRaVEzN00zTUxteit1K3hJWnJGNXFvblVMUnYvbzkr?=
 =?utf-8?B?eVF0V2MrMi94UDFFVEk5SjVVb1F0SkhmcFplWXNPSkdaTk45K2JZVzJsNzhW?=
 =?utf-8?B?OTBtWHpqTUppQktNUFpzc2ZPS3JkRU5paUZWc1MwZHhVQjM5N0FtMHJnVUtY?=
 =?utf-8?B?MFpOMExqSVNoWE1WOENxRHdqalgzTGxQVWRtMkdnY21tR21nbHE1TytuTlBm?=
 =?utf-8?B?L0NvbHVEaFIxRnZKeSt2NjNPL0pqN0hVTlNoeFVEQ3VlQnk3d1E3dXhpYUpM?=
 =?utf-8?B?dnAxMHgxandmRWdMMmR1MHNaUVJrOHBSQXJ0dWh0V3grMmZ0QmxFWmJhZUt0?=
 =?utf-8?B?MEFXRTF1ekkxSjRpSGlicGh5WXRJSlNYOG8yaWhadCtxVHZIeXpTQVpuMTFW?=
 =?utf-8?B?OG1DbEVtKzhXUHJIRmo0THZ0ZEVsa0FYZWwzMTNlOFhJbjFmMnhSaVBQalRM?=
 =?utf-8?B?Vmc2WTFoOVdLZy94bnkrWHNpL2VkVDRtRy94SndtWWExbUdPZEx6K1JrVGZH?=
 =?utf-8?B?WHNSdmFLU09vQXJRRkFzbFd6T05mM1JjNDVtMmdKTFRzSktjUm5NMkJ3cndO?=
 =?utf-8?Q?rxI8G2iB/xaMz4A2M2kZRQU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 033a18c0-a9ec-4029-ccb0-08d9c455b0dd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 07:44:16.9689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvKitLWaH3kKVli55vDI9DAsUq3inE5m0vkFUSrMO/OpyoROF5P9emjnC3/0IAP86iuSy+qrA3wiiIQu5PvP2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4964
X-OriginatorOrg: intel.com

On 12/17/21 5:17 PM, Mat Martineau wrote:
> On Fri, 17 Dec 2021, Paolo Abeni wrote:
> 
>> Hello,
>>
>> On Thu, 2021-12-16 at 17:23 -0500, Kishen Maloor wrote:
>>> When ADD_ADDR announcements use the port associated with an
>>> active subflow, this change ensures that a listening socket is
>>> bound to the announced address and port for subsequently
>>> receiving MP_JOINs from the remote end.
>> Is this change strictly needed for user-space path manager? I
>> personally think we should avoid it.
>>
> 
> Definitely something we should discuss! I had initially thought that less state would be needed in the kernel for userspace PM sockets. Maybe we can still achieve that.
> 

The in-kernel PM could also benefit from this change. The change merely attempts to 
create or reuse a previously established lsk, and if an lsk is held by the application, then no action is taken,
which may very well be the vast majority of cases. In other words, there should be no impact with applications that
currently work without this change.

But, for e.g., if an application holds an lsk bound to a specific
address/interface, then this change would ensure that an lsk is created for a different
address when that address is advertised. Other situations like the application closing
its listener after a connection is established are also addressed.

A consequence of this change is to also ensure that an lsk is created on a machine 
that's running a MPTCP client application and it's PM issues an ADD_ADDR message for some
address. This is now plausible due to the other change in the series that allows subflows
to be initiated from both ends of the connection and something that userspace PMs will
be at liberty to utilize.

More generally, I tend to view path management (and how it is facilitated) as a logically 
separate function from what the application does. The PM unilaterally 
decides to advertise addresses, so these changes mostly just help to make it
successful.

>> yes, port-based endpoints do create an in kernel listener socket, but
>> that is sort of last resort thing, it's a single socket per endpoint,
>> and it's created at endpoint creation time.
>>
> 
> The proposed code shares the listening sockets to limit how many are needed, although that behavior will definitely depend on the userspace PM using the same addrs & ports across different MPTCP sockets.
> 

In the proposed changes, there is a possibility to share lsks that were created in the 
kernel context (i.e. not something that an application holds) through
reference counting.

In the userspace PM mode, all created lsks (whether port-based or endpoint-based (i.e.
reusing the subflow's port)) are active over the lifetime of the MPTCP connection. When the
msk is torn down (for e.g. application terminates), these lsks are unref'd (when the
refcounts hit 0, they are freed).

In the in-kernel PM mode, port-based lsks will persist as they currently do without the
change. But any lsks created against endpoints bound to the subflow's port (as a result of 
this change) will persist only up to the lifetime of the MPTCP connection.

>> The fact that potentially multiple listener could be created "under the
>> hood" at run-time can have a number of bad side effects hard to track.
>> e.g. if an application already create multiple listeners on different
>> address, it will randomly fail at startup...
> 
> An application trying to listen on those same ports would fail whether these "extra" listening sockets were created and tracked in the kernel or by a userspace daemon, wouldn't they? With those sockets owned by userspace at least it might be more obvious what's going on.
> 
> I haven't (yet?) thought of a way to have a "MP_JOIN-only" listener that would avoid such address/port collisions with other applications without getting too invasive in the af_inet or tcp code.
> 

Well for starters, no ADD_ADDR announcements can happen until an MPTCP connection has
been established (presumably the application has started up), at which point the 
application is bound to whatever port(s). 

Any lsks are later created by the explicit request of the PM for to help initiate subflows over 
that connection. Port-based lsks will continue to function
as they currently do. But any lsk that is created (as a result of this change) against the
subflow's port (which would happen only if the application isn't already listening)
will remain active over the lifetime of that connection and be freed when the connection
is closed.

So, all this change is doing is helping the protocol function as it's supposed to.

>>
>> Can't instead the user-space path manager creating the listeners as it
>> fits it's strategy better ?!?
>>
> 
> Kishen can confirm, but I think he was looking at the netlink 'announce' command being a request from userspace to both (1) send the ADD_ADDR and (2) ensure that MP_JOINs sent by the peer in response would work correctly. This is more like the behavior of the userspace PM netlink commands in the multipath-tcp.org kernel. Due to implementation differences in handling incoming MP_JOINs, now we have to figure out if responsibility for #2 belongs with the kernel or userspace daemon.
> 
> Kishen, did you consider having the daemon own the listeners? What tradeoffs do you see with that approach?
> 

Taking a step back, the current MPTCP stack design (as I see it) is contained wholly in 
the kernel. So the kernel needs to store some lightweight context (e.g. lists of 
mptcp_pm_add_entry and mptcp_pm_addr_entry structs) to refer back to in the functioning 
of the protocol. 

With this being said, it seems that storing listening sockets inside these structures doesn't cost
anything over and above any alternatives. More critically, the lifetimes of lsks are directly tied
to those of these structures so it is convenient to keep them in 
one place so they can be cleared up at once. I haven't found a convincing reason to
create/maintain listeners in the PM impl instead. I think at a minimum it
would place some burden on the PM impl to stay in sync with what is happening and do
the right things (like clearing up lsks), which we kind of get for free by co-locating lsks
with other kernel context.

> 
> Thanks,
> 
> -- 
> Mat Martineau
> Intel

