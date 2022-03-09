Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D055394
	for <mptcp@lists.linux.dev>; Wed,  9 Mar 2022 23:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646869254; x=1678405254;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YglcRG+ppVxjXKmb5gB2p5eFJxjY3GgzQDDYfP0YSLg=;
  b=is0eW3K3GTUXiucahs11hXcqPoJe+Vtz4DnX6/MMVBcJR3hZ2fn1jHgW
   5Zzu5ErsIMBatin/IBC5eAhEBE1/i4srmhf2x7EUgvI596aRSaimCUmIo
   tOYrRPImVSUio+XgUiQaiHlEIbyHK6qcaLfKxrkcbyJWtf3hGNJrdIvX6
   Lszy5R/1zUuK30EDBxDNAdHLkYuWiQdXzj1mBtzDh42qVCpRig07GwWq2
   qcvk9/X1/2pZ2xJImP1pVDWI5sciWsO5EXndfmIBwvGDMm0nC1mFGiRc/
   d7tQxYh/B/ctt+saH1j/rPYZNP/0EDN+cpEFuBugIe+7PIDCgA3N5rUEb
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="254849395"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="254849395"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 15:40:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="611542504"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga004.fm.intel.com with ESMTP; 09 Mar 2022 15:40:35 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 15:40:34 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 9 Mar 2022 15:40:34 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 9 Mar 2022 15:40:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCMS7jfnikLV8zKbZl5xdHw2xWp23ym+0ULHm0f6j7gcjooj67gflKLXKai8WzCAfDl1o6y4JAp9kwg3FHm/6Ybty7W5hnXO0jtuXfYyknMhZjtZQQN5oYkrs7SCJssGBscrLxJHN6+HDJU9pW9X8l7yd5Su+trKrh1MLn2rZ4JCvIiY/xITZL3FrcpwNwb9Aw4m/qrYorS5lOq2bhrksPMEOCIoVqzHDwOV28O/mT9UBmzdAdDRzboknepCQpTBwlUtyVXTZrxp1T4yTEf4M67DqWx3H+t8YnqrmwKN+UTReh4Jc780qgA2b6oUqspZnOFLw6fz0Xf3CwAWenjolg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmNyPTOBjlc/SmxTG5YYXBQGbsk0fNkXYuIjKoW88Mo=;
 b=KptrX4PjU91hxyR/qBNEPMQwtPoEYs0oT91NcAz4hqWmNckmM8UjoWl/J/tWUgtCJMOvDggQx+MIUh8EQW5El28KDw+ud/Qk5NO9Sbh6LAek4m3M4qsoCwmoUAjMiH2FSx3h/6UQzugXreo9zeVRBTk8SXiCIQ58nSGAeOvQ/jp0k48PnJ4oDibEdkYn+JR0PEp1xL6lqFyxv+5KeQKXG/RV5BBW5DmDLxL/goaxMQH84FbaMD7yYUyxQbIDdpxNEMy2OensOWQ82MCydOwKPQTZpKJhHKA1ipJ1Nlq3zZ3Is6AUaB09CZvzIx4g05TnNUmtPbUlmcy3NqUgYTY7rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5145.namprd11.prod.outlook.com (2603:10b6:806:113::6)
 by DM5PR11MB0043.namprd11.prod.outlook.com (2603:10b6:4:69::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.25; Wed, 9 Mar
 2022 23:40:32 +0000
Received: from SA2PR11MB5145.namprd11.prod.outlook.com
 ([fe80::9931:fb24:e892:4de2]) by SA2PR11MB5145.namprd11.prod.outlook.com
 ([fe80::9931:fb24:e892:4de2%8]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 23:40:32 +0000
Message-ID: <642225f9-f179-9947-49d1-2ee6ce7cd40c@intel.com>
Date: Wed, 9 Mar 2022 15:40:29 -0800
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
 <d796fef2-d380-c92a-7516-617992a20460@intel.com>
 <20220309125351.GB26501@breakpoint.cc>
 <4e545ab7-7a9c-921a-0095-6a7e5803cdae@intel.com>
 <20220309213730.GC26501@breakpoint.cc>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <20220309213730.GC26501@breakpoint.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR18CA0055.namprd18.prod.outlook.com
 (2603:10b6:104:2::23) To SA2PR11MB5145.namprd11.prod.outlook.com
 (2603:10b6:806:113::6)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50608152-5219-4a7f-3cb5-08da02263363
X-MS-TrafficTypeDiagnostic: DM5PR11MB0043:EE_
X-Microsoft-Antispam-PRVS: <DM5PR11MB0043E8EC689EA5EA2328544CE10A9@DM5PR11MB0043.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dPqrP2egYIKQrYX75aibY4J8k406qpSISHv7V5Dx/M8gFfUyeWejiF1tkGh1lHzPZXADrZNZmodj+K6UgRiH2ZqCrJFunlpoCSA78mMPv+cSrTQ/gOPisGWNgv1BjsXNmtnBMiNTzTpcijMHjLs2VC3X2Pb2WUBI3PevRMZw0HmiSaeBvBffWBtmRfB5k6SMpwCjC8hcgpdipNa1CmwdS4zcdzhstBYqHACUF8YlxrQgruyaYum6XqEvkTcidJlQcqwk9qhAv7BzYrOnWk9Wxnr7I/UWDhbiL/uvfB+ajDOpQ9SJjNPjEV8Dy+Rl+pmiTVCwINpUoMRUi6Gd93urL6emJAvVRe9aTI9lV5FtmE8CemVuf3V/GyjwfX1e/WLiDsjwvlXDcrGh3UQENLDVCZnLk2n4P2peoZO6+Ko0EfeT9qmxsuLxid9lXj9AheslnfMt6nh+s/zIgajp444RRclPgYPd1Wmcaku/Weo+odQECUsVsOquPgXmdRHkz0wIMnftBItzJ0+MbpCfjd7IoPV5qI6ih0IUTOcmqBqNFki0fn9FUuJgBzfExWywjOlmT58y+iNjYkRaeuzFr0/veK8LpxjdGLkw5yPVEhpGONRO90Uhod4627KiC0xapeoicNHk21GIXw6qMNyg0JGTi3xSt3bRoyOpOm46sjQssnZqU8CiG8pz2ZvGCZYUCdKhyi5q6SU2m3wWBIUaN5pICBEA9HcVtOdie5g3Q9bSoUb1cE+JVla/OynZFRWOnx0a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5145.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(316002)(6916009)(82960400001)(66476007)(508600001)(86362001)(6506007)(53546011)(4326008)(66946007)(5660300002)(36756003)(31686004)(186003)(66556008)(44832011)(38100700002)(2616005)(2906002)(83380400001)(6666004)(6486002)(26005)(8936002)(31696002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGFSaWZ1SjNsU3dVYzNpY3J3Vnk4U0pHMjU5ei8rQVV4dnRKOGhkU3Z5SkNz?=
 =?utf-8?B?Nm1SclFaUUdzN0NCNVZuNkR1OTdOTzhmQkh4Z3ZuSzFjMStQSUluS0R6R1RD?=
 =?utf-8?B?QldVaTNKaW90TEI4SW84Z09lUHFFdE9neW5MRHZva3M3QzBZTWxkOUw4bTBz?=
 =?utf-8?B?SklvVStxVUZXNzd5Y252SVIxT01hLzNLMUk5WUJ5VmpNNUU1aEpibGZLY0Ur?=
 =?utf-8?B?VVJhNWZ1THNQeFQyY3hFMGZhZ1RoVDBoRzBnTElreCswVk1ZVENHL2V6UHB4?=
 =?utf-8?B?QS9aNXYwM3VLbUtWREdDOHdtRkZrd2Y2S2VyWktDNjlsYjFyZEM4OWRwOFZ2?=
 =?utf-8?B?d01OV0xjVGhhMG5XaytndStFa0NCYUNtTWRDaDNLTER6MVpPTUQvYkxMVHVk?=
 =?utf-8?B?M2lPT3UzWk9wNitUWW0wajhYbjVtb0JSWGw2ZHlaMHJKMFluaGF1djNCNDNq?=
 =?utf-8?B?cFNaOWtFRkRRRkhJNGFBOG4ybDErWFNNQU9ONnA3elU2Skowc1l0Wjd5OUxP?=
 =?utf-8?B?ZmN2cDk1V2Nsem9XK29jdkVibEpJY0p6VlBPVnNyL0U2eXhGM3VUeXZjRDFr?=
 =?utf-8?B?dEpFOWVwWUdTcUM5YWlpOGhSZ2JKNUVpcnlCSWN5VW9BKzBmZUlSSEx1VFRh?=
 =?utf-8?B?djRmNU9XTGNxNW1jRWRONlUvMDlWQTVmMzJlQVFhK1ZON084K2QwTUZBV2J6?=
 =?utf-8?B?bFcxT0hGUEtOUkI3NXNtS09hN3dqNktsQXBPMmRTOUxQaWVkS0g2aGgwckN1?=
 =?utf-8?B?RmYrTnB0aVdTaTNEQlpQVEkzN0xPbi9vZnZSdjJOYlpYdCtYQVYvS0lwMllj?=
 =?utf-8?B?RmhzaGdnczhZTzhVVDJJYWZlQUhWL3ZEbHowVTZ5ejhrTWJnNHNiczVQMFpG?=
 =?utf-8?B?SVFkQzhQUlBSTHIzSS9Bc0ZrR3U3SWE0ZytGVWxCaHdQV0dMUTA3RE5qczFL?=
 =?utf-8?B?UjJkbmVhWC9Wc2RjZHluam1SUzF1WTlaa1kwajJoSDF2QWx1OEErSSsvYStu?=
 =?utf-8?B?N1pvZFY3UXNpSGhlRUpYUEptaVFvS0pWeW1FblVuNWl5Vm5zNFJwc0p0TEha?=
 =?utf-8?B?ZENEMlUwMWNyTVc4UlJkWTluY2FWT1ZML0JIdmE2VXJLMHoxNXhjanBIL0hX?=
 =?utf-8?B?QTd5RUs4SFlYOGV1TEg0WGNYb3l4RndSeEU3VTRydVIvb3J3OThLS0djOWQr?=
 =?utf-8?B?MXB5L3BKU2NyWVpMMjhtTHJlemd4RUI2dnVRK2wwalpFMzRLUkFJcCt4SlZR?=
 =?utf-8?B?NGZEZ3hsZ0RGZy9SSVErMERQZjZNaENMSGl0OEFPVzhkNzQzZCtKUnVqazFz?=
 =?utf-8?B?eFRDN2YyWWltaDdocVNkQWVVbmI1amhMT08ybWs3a1d5Sm1IWFMyZ2NxVUlS?=
 =?utf-8?B?MGpHZVg4RlJYYnZtMHpqQ1g5SDdsNEVzY2RBMTZiV2ozdlZaRnJNdG9vWGl2?=
 =?utf-8?B?Q2lOL2V4WC93Smp1ZTRjWVdUUHlzaDRzMXBsSytjaVd5Y3NSeFZwK3RiMlhN?=
 =?utf-8?B?dFBnMnBROGNPSld6MEswczVIdUdzRWtWREtZQVBFUVUvcUxLNzFvbklQSHFa?=
 =?utf-8?B?b3dRaWlNZUxXWGxvRmVrb1I3K2huajdyU3l3ZkZteGZEc2xZQ3VEenFtWkgy?=
 =?utf-8?B?bkpWdC93bkRpNnZJVEQ3c3lUb0JoQnkzY1hFaDA4Umd5T0JpVTNmQjVFZmxi?=
 =?utf-8?B?OVFTOVBsTWFlN0FpamVpMGF6Yktpb3BBM3VNMnZYZWVRRGNpY09YVXhYSFMv?=
 =?utf-8?B?ZDZneVA0bTdEUFRZU096V3VUbG1lakl0Y1NVc3l5MG41MU9qaDNPT0tKMi80?=
 =?utf-8?B?TmRIT1hNOElBbUpZNjNyWTBHaUg4S1hEK2Mxemg4dHNWV2lLQW9mNGkyNDc1?=
 =?utf-8?B?V0ZERGZ2R20zMHR6QlM2MlFndW1NYUcyYlhqS3hTcTFnRHBUUmZjUzVlQStQ?=
 =?utf-8?B?YTZ4bmp5aUs1NStmZlRTNURTTHVIeEo5aTd0cDhSSCt6c3dXeUFkbEkrcDdF?=
 =?utf-8?B?b1pSWGFpNndnRnFHMkVHNHJHdlJsSmlQYXBKenpZZVc3V0QvUFBnQzg0VW9H?=
 =?utf-8?B?YXQvSnNJcHJrbmhHR2NwbytlYjlmMkpuZU5kb1pEc09QWjZ0ZWNFUXo4MGxE?=
 =?utf-8?B?TmozSXhWNFh3MTdDckV0ZG4vTk9Hc2ZnYzRzcElHYnZVcU1EMHVKTkV5NWRn?=
 =?utf-8?Q?yGf9XNUDBBPk4wpTQ5+S6U8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50608152-5219-4a7f-3cb5-08da02263363
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5145.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 23:40:32.2375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5iY3x4RwvdwXdXGG72ExNy6vZ8NntKKaJKnShbSU9AOwXoEjRd/JpLMdMCpv5gzpfos/xp37xepGQww/42cPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0043
X-OriginatorOrg: intel.com

On 3/9/22 1:37 PM, Florian Westphal wrote:
> Kishen Maloor <kishen.maloor@intel.com> wrote:
>> On 3/9/22 4:53 AM, Florian Westphal wrote:
>>> Kishen Maloor <kishen.maloor@intel.com> wrote:
>>>>>> Over a newly established MPTCP connection following listen(s1), the PM can issue an 
>>>>>> ADD_ADDR with B. In light of this change there would be no listener created for B. 
>>>>>> But if the remote endpoint immediately established a subflow in response (to the 
>>>>>> ADD_ADDR), then that would create a subflow (connection) socket at B.
>>>>>> It appears (and correct me if I'm wrong) that bind(s2, B) would fail after this point (?).
>>>>>
>>>>> Why would that fail? You can bind x:y even if there is an established
>>>>> connection from x:y to q:r.
>>>>
>>>> If I establish an MPTCP connection using mptcp_connect individually as 
>>>> Client and Server, then I am unable to bind a 3rd (new) Server process at the Client's 
>>>> addr+port [1]. Why is this the case?
>>>
>>> Whats [1]?
>>> I suspect this patch series needs following addition in patch 3:
>>>
>>> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
>>> --- a/net/mptcp/ctrl.c
>>> +++ b/net/mptcp/ctrl.c
>>> @@ -337,6 +337,8 @@ static int mptcp_init_join_sk(struct net *net, struct sock *sk, struct mptcp_joi
>>>  	if (!tb)
>>>  		return -ENOMEM;
>>>  
>>> +	ssock->sk->sk_reuse = 1;
>>> +	ssock->sk->sk_reuseport = 1;
>>>  	inet_csk(ssock->sk)->icsk_bind_hash = tb;
>>>  	return 0;
>>>  }
>>>
>>> After that, follwing sequence should work:
>>>
>>> 1. bind(0.0.0.0, p1) // listen, accept etc, initial subflow established
>>> 2. announce p2
>>> 3. receive join on addr, p2
>>> 4. bind(0.0.0.0, p2)
>>>
>>> 4) should work because sk used for endpoint in 3) has reuse flag set
>>> and is not in listen state.
>>>
>>> cf. include/net/inet_hashtables.h, line 47:
>>> 2) If all sockets have sk->sk_reuse set, and none of them
>>>    TCP_LISTEN state, the port may be shared.
>>>
>>
>> Wouldn't 4) fail if the socket being bound at the time does not have the SO_REUSExxx flag(s) set?
> 
> Yes, it needs SO_REUSEADDR set.
> 
>> If so, that would be application level thing and in that situation we don't have a way to
>> avoid a race.  Whereas when we require an explicit listener, we could have the kernel take a step
>> back (and not create a listener) to break the race.
> 
> Uh, what?  Sorry, I am totally lost.  I have no idea what the problem is
> that we're solving here.
> 
> EOD, I am out of ideas.  Feel free to toss this patchset, I have no idea
> what to do.

Sorry, what isn't clear? 

This series was meant to address perceived pitfalls of kernel listeners, such as
race conditions which were discussed. So, I believe we are trying to assess if
these changes indeed do that, or if anything further needs to be done. 

It seems we've thus far identified one change as a result of this conversation to avoid a
race, i.e. setting the _reuse_ flags inside mptcp_init_join_sk(). Is there anything else to do, or
are we now confident in these changes?

I think the group needs to make a call on our path forward (one way or the other) so that 
we can also progress on other related work.

On a separate note, I brought together my entire userspace PM series and this on a 
tree to test and found a couple of glitches in this patchset. A few userspace 
PM subflows tests would fail due to that. I can respond later on this thread with the
specific modifications after I clean things up on my end.
