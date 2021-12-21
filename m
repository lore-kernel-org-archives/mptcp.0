Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8C529CA
	for <mptcp@lists.linux.dev>; Tue, 21 Dec 2021 07:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640072096; x=1671608096;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=+BSGsJEx9S045vA7SH+CNOgQikY0t1Nn87dJ4ec6UqI=;
  b=hJXb3nbePIbXfKmaWxKZQk2f7PK6StYuW785nod/ew3AWE/JMxtxHdok
   kSFcjXxnw63JgaQT+y7dofnjHWbEb7gzn1d93aEFuRbGFT8kOQXSzMbKz
   0Mk9I0qTUaVgWYbu6eLdHaahL2MA5E1+e2tpBgdm+3v2jbnOlFceTrZI3
   5NPDccriIl0GOHlebhArzF4brRaA/yJFoEeM7C6Q1tALJtaTWw0FqkdPE
   JhDrVOPO9o+oeFKJc+HHEQ1YdKxk6COcOpLripC6NC9rSRHD98aR3pAA0
   sozD9Uje/YA58DZ6zvZFYyfy7BQXnKlNagwnpVhKojRDEFZ48/JRq/MMF
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="227636700"
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="227636700"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 23:34:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="521138996"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga008.jf.intel.com with ESMTP; 20 Dec 2021 23:34:55 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 23:34:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 20 Dec 2021 23:34:55 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 20 Dec 2021 23:34:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftEYDhLmU2lZyEVs+tcgUxr8nBjvWx/JuC7if66CSiy2ok/n99gPx4RRifRLX0oc99WaPmHKDzB9Qpx/e4d1vGT8sxRTYOQrrnHJI1/V0benLeG6CrPO0ZXDEenOhWMN4ZB2XBbdLdSTWsDJB9Apyh6XOGAmCfJApLulB8Azg2/gjrJ8K8RoP0U1XIeqrHXXpMb4z1Tz5WyTMmxWQNPAvhUDXOcsVGOiwXh4R4EUclxT/qRCImiT/yY5OyYNyNip9L6F5KZFpEKqvpJTe8cT8XiFN5WRrwu9Es0G96bh+6FfuB96YJs5J0ShaGGwd+qjFFDhKE7nEQkGiNz5yf7L3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahKZpJPYMc+khu9NPzV3D0kurYDnBgRjHGhVLhLy4kA=;
 b=A/lUySMcjD/o/2vpyWJyCZ8DhDia0M2lRsNTH9bRqIpWs2VxIvPwMAjDB0dao4zrRzIutyrprHdHSto5z7p08V2h7uqaW7kS/G7ykgDkSEkNzoDkcWoQOJDbyjXx0J7m6wRPMr/Al9iQ3/OcOn+byiRtiafCs1MdSBaw7Dy/RHNBlGoHabHI5fMpihn7efo12zyrRPtgNXNtc2u3AYdMsfGs0RMPH9fcFHMnEajn6hIJMcyJYLBK26KbbT2v7oshYquQ4AmQCWdgEy69R07wcViaMwJCGcn4sqRoOExUxj85arZFpHnaHlP2ilTeAD1CGddr5yqLPryM5TZ89BiE7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:95::6)
 by MWHPR11MB1664.namprd11.prod.outlook.com (2603:10b6:301:c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Tue, 21 Dec
 2021 07:34:54 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::c41f:17d7:bed3:7888]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::c41f:17d7:bed3:7888%9]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 07:34:53 +0000
Message-ID: <39006fe0-fbff-f08f-4642-6ef8cdb2ad8f@intel.com>
Date: Mon, 20 Dec 2021 23:34:50 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH mptcp-next 08/21] mptcp: attempt to add listening sockets
 for announced addrs
Content-Language: en-US
To: Matthieu Baerts <matthieu.baerts@tessares.net>, <mptcp@lists.linux.dev>
References: <20211216222314.1244708-1-kishen.maloor@intel.com>
 <20211216222314.1244708-9-kishen.maloor@intel.com>
 <7be3ba91-232d-1357-dcb7-b55b01d46f3f@tessares.net>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <7be3ba91-232d-1357-dcb7-b55b01d46f3f@tessares.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:a03:180::48) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:95::6)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82e8506b-e573-4e9c-3018-08d9c4546143
X-MS-TrafficTypeDiagnostic: MWHPR11MB1664:EE_
X-Microsoft-Antispam-PRVS: <MWHPR11MB16647AB7B910E82610F72F65E17C9@MWHPR11MB1664.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XzoFALACroc2/VKTp0FLXN5cI5gDmaYWLIIO9W1n72Utwg0zbdCDxbqeOH+q8mLYL1HDXq4ecnTWOFnVEyMYXBzQRY2vWilFY84jQCOuy0+7lM6FKSEhW+FI6/+OiJ27geKQ51rdyvecl4oDTTxMNT4uSgPAavr/9aCvnMF9Z5mkpKwDT0PRQp8aKpMj33n0G/zixvTy3ep+5cwwwJDBHI5y/hq2Z5PksApDj3z7AW7MDe0FavTAui9jly7YR00YHDOA/gyoU8jm8tmDB+6/x+jI5KoW0xw61hGiSkwc+Fut/fJN5UcgHjMLDTliewNGooNCD3wGyKsHHOtNSaK98oMr5rWVTjB4/w7ovEPyHJvAkzuOgcQWskxpg2CdOh46b8Yi/12nQPq9dkVA9fUfI4pz0WPuc0TYFR3wHFKebCMWaZJh/Pji0AE6/pXHGZZYvbLoC5dN3zPPm98Fgpe51F93GMU9m5Tabk0hMJGILJ0t5JBb1Fe0PsYTZTGKNiEUmIZ5KKud6KfjfNlIIFGam7cmz9zbjZPOlwf20Zw/7MZtv04HVQqxOk8SWQBHtrvTFUX3pA2BW3YbPPaVRNtyxsn+0qCITF+VJ0u0tP3+VaoFhjQHtK+9Y3HE18CxpUjN3dWjr6XHisyUi1Ax6RvHdZJD1JCQKCbv3788YykJoGc23yRngbY1XbHaxd4xY7eUX2fNRB15YnKYRY8WaA6ufkYPme81VAiCt09Bnu5/LiZR9WhME2Shum06sITcp/PlGFhhUiZOmuCFaD57MwU/8+P6r1cCum+BztqQk6GL+sODF5ClAfLjyueTwqywjOTs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(5660300002)(26005)(6506007)(86362001)(82960400001)(2906002)(66946007)(83380400001)(53546011)(31686004)(316002)(966005)(6486002)(508600001)(66556008)(8676002)(8936002)(66476007)(38100700002)(6512007)(31696002)(36756003)(44832011)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2lpR2c2dFJ4Yjk0cXRiZUY3ZEs2TloyR1B1OGRFRE12YzlHV016NkRSRitQ?=
 =?utf-8?B?Q2RFT2NDcmpuVmYydHpUZm9NQnhmRkpTb2ZtTmNnY3VYdnF4OXV5UHNMVldK?=
 =?utf-8?B?TlpPbFY0a3pkcG5YcEhvUDlQa2lPMFk5MXZXRDBiMDZXK2MxZ3VRSWFsSFVZ?=
 =?utf-8?B?M0NEajEvcnY0Q095S3V1akV0Z1dzTEpFZEVKcXlKVVV3TTJJczQ1K2FPTHpq?=
 =?utf-8?B?RTB5eWt4MWFUTS9iaWlObXExYzNRWEVBemFQTlI1UjdRanJTdjFJRzNUV1gz?=
 =?utf-8?B?VkJTZGk2SzZ0aHpLMFNscXZrWGVhOUIzckxQMVFtaHEvb2R1R2Y2STRyUXE3?=
 =?utf-8?B?Wm4rc3hPM2RUVzltbnUvajFEZ1ZqcFhvMTBlOXF4dkNLVlFQZ0NVSzBGUHB0?=
 =?utf-8?B?YUl5QnBaN3lOODB5ZzgxdUJHKzNsa25STE52UmJMUTJNL0dzaDdtM2JUUngv?=
 =?utf-8?B?NWxQK0YrNTFXOEYva2svajhTVFQyRHN4ZUpjRyt1NmNtZnk2eXR0NEs2WHU4?=
 =?utf-8?B?ejM3TGRBWk9lRnJyZVM1bTc1TEQwT2d2MjdNelBTb3VsbHRWbi9haUw0bUFm?=
 =?utf-8?B?QkRLTldHZlNHSTRBN21EZWFUTUsxRUtmK25MNEZvVysvZVpjU2FNQ2dwaHU4?=
 =?utf-8?B?R212dSt4V0tFb0oyL3NVM3pxNnFqaWNXSS95QnJPbVBxU0Y5aVQwdDhVNWsr?=
 =?utf-8?B?QUM1ZlU3bjBQZVdKK29rTExnWWlNa3l3aUk2M0R0SW1tQ3lQMjJkaGFjOGVR?=
 =?utf-8?B?NzJQbVEwdjQ0dmI3Sy9Fa1dqWXMxdjRhSVpoYmhtYkFCVGZKa0M0SlNqdG9J?=
 =?utf-8?B?T2JhR3JTcDgxQ1RmNjR4dFFMNVNZTE5WZVUrcitBMzczNWdUNUh2Wkx2MFhz?=
 =?utf-8?B?OU5sVWlTY2R6cCtTcUNVTTBmNHQyTzZucURIQkRsYWpubFFRaWQ5OWtZSkNx?=
 =?utf-8?B?cEp3clhURmo5NnR5SGpZeWRFYk9zMVphYlJ3RUxOSkNWeUhUakNrbW1TVlhn?=
 =?utf-8?B?dzgrd2FsSzF3SzBLWlE3NzUrNnpsYjNXMHpzcGhnYno0VkdycGh2WXpFNWg0?=
 =?utf-8?B?OXJGOWZUbVdYSHhwMW1DVktsZTB4VGZEdDVMRGZsdmdOUFZGektMaEJJUnlU?=
 =?utf-8?B?NTd3cXBJNWNoblJLbWFvR3lEVCtOeDdLeGc1K0JnRWtsc0tBSjNCK1RUWWhs?=
 =?utf-8?B?R01yaFl3QVNmT0R6dHRsTGJMSDYreXpWelJpaUdDUEZDMXovdzdTcCtST3BU?=
 =?utf-8?B?bzlNUDFheXFQTVVjM01LMGpocStrQnJucExENFlEbHVSSVk5ZC9iMmduaXAx?=
 =?utf-8?B?VlJjakZhK3FCM2pFK2kxVXlwSzZaTG9xQVphZlJyTlMzRXpBeTd4eE4wTFpW?=
 =?utf-8?B?SDJZSUh3bXBRcHpvSmRRc045blJKSlBDM2F3WVVTMmh2SWtFbkZ5alBSbklX?=
 =?utf-8?B?L0ZvK3M4YXozWjkwTUNRSEJ4ZmFXWmNtWStFcWxYTGR2NnVrcmFBQncvK1Vh?=
 =?utf-8?B?dFh3dThCZG1TNEhib1FKUnpNaVNJNFpNcWNlNS9mU2JkUDlrMDZGYkZyQXV0?=
 =?utf-8?B?akxJQ0RDTXd6MnZtMVZPZmNRVTNDSWUwVG8xVE5BWDVRSWo0UkxPd0daejhw?=
 =?utf-8?B?QU54SzMrYXFQN2JyTm1WWkUwTW1xRENpOXczUlJxNGNCWEthaVRDeTI5NGF0?=
 =?utf-8?B?bkJ3NTFIQ3k0SXptdnlwbFN6MmJNVWNRMVlGOWJGbzhKbnBOWUdnZmcyL0I4?=
 =?utf-8?B?cEhTVXhXU0VIUVFCN2llVHVNR0FmWERUV1BZT2h2L2hUbWdEYnhjcG5UNllq?=
 =?utf-8?B?RXFid3NRazg1S2FMZGFtVEVFUXphVUJiN2lGSFN2bG5hNFdqS0lkMW1wb3Uw?=
 =?utf-8?B?ZDFPVitnb2FQUk5SVEhmWlQ5ZHdZZzROWHdnQW52R1N2WE45WXpKcHZzT2R1?=
 =?utf-8?B?SFRSdCsyU24xeGFUcGgvUUVQL2tRVS83bkpsdXZ4K0NwalZZWmwvQkczeURZ?=
 =?utf-8?B?NnRHNEwzRnV0bmdUaFBlakdqa1pEZC9CR09YRTRvYTV3LzNDcXREU2dEa3pr?=
 =?utf-8?B?UDRVSHJOMWpxdHYzSVN3S1J5eWJVenVYOXNQZzNMbGFmQ3R1ek1IL0h1bG9w?=
 =?utf-8?B?MUxvaTN5bGh0OHVNdGVha01lVnZUUHNjQlV2ZTNkYnp1MVltSUtyTk9TUEgy?=
 =?utf-8?Q?xpoZN/dzwYppDyE5sH2TqUY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e8506b-e573-4e9c-3018-08d9c4546143
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 07:34:53.9149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJZX4uXoadfad2H4/AG0Lm4lnRj8cJrp9wE8zXZvzUcYlybO30FxOhOIMdiw8E2qqbQunnU+gHOz8gmgTsFzBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1664
X-OriginatorOrg: intel.com

On 12/17/21 8:34 AM, Matthieu Baerts wrote:
> Hi Kishen,
> 
> On 16/12/2021 23:23, Kishen Maloor wrote:
>> When ADD_ADDR announcements use the port associated with an
>> active subflow, this change ensures that a listening socket is
>> bound to the announced address and port for subsequently
>> receiving MP_JOINs from the remote end. In case there's
>> a recorded lsk bound to that address+port, it is reused.
>> But if a listening socket for this address is already held by the
>> application then no further action is taken.
> 
> Do you think we should add an option not to do that?

I can't immediately see why that would be necessary. I would think that a machine that
wants to restrict MPJs could choose to not issue ADD_ADDR advertisements. 
So it could be more a matter of path management policy?

However, for PMs that do issue ADD_ADDR messages, this change merely attempts to create
or reuse a (previously established) lsk (which was stored in the kernel context).
But if the lsk is held by the application, then no action is taken.

There's a separate change in the series to allow subflows to be initiated from either
end of the connection. So in a scenario where a machine that happens to be running a MPTCP 
client application issues an ADD_ADDR message (and reusing the subflow port), an lsk would
be created as a consequence of this change.

> 
> Or maybe we can see that later. I don't know if there are use-cases
> where you would like to restrict the MPJ to the same restriction applied
> to the first one.
> 
> Also, I guess we can add:
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/203
> 

Thanks, I could add this to the commit message.

> Thanks for looking at that, I think it will be useful, especially for
> apps that are used with mptcpize.
> 
> Cheers,
> Matt
> 

