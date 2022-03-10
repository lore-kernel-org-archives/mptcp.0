Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9037A
	for <mptcp@lists.linux.dev>; Thu, 10 Mar 2022 01:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646875658; x=1678411658;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DMUJNYbrHYAJ5rSFJ5RJ/z4wpdCDszK/HNZLFUwPbTc=;
  b=ZZHiFjRjtT8395g6d9SD0GOuQvidsT+LOrBS4eRLYsD+lTyiIxdoIE9H
   dRFDUb96wIl11HitVkRuHCI31e4EGGT8bY3DoFCEiX4uAwqd+WrVNRvJH
   qlm0WtQhKCOJF+Keh0A0AbKnSuA34XFlBQl87yQmpD9K7zgyn71arx9no
   trgDXT+C/78BXwn+pne4ga86hND3zSb1HAU0qt+arDbrQqvNSz7hbUKYS
   fIRKzIZpEej8BkLvZDx7WtZINy1kuHWKSkU3t9TOcNWVhvRinL0pmbBoG
   LHh2NUojMSGrQl1rbvDZaPlaw889oNY+cq9BRQB7D8pWOFFxI4aPongJs
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="341562331"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="341562331"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 17:27:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="688493540"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga001.fm.intel.com with ESMTP; 09 Mar 2022 17:27:38 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 17:27:37 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 17:27:37 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 9 Mar 2022 17:27:36 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 9 Mar 2022 17:27:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3iG95qVjo7xZGr9m5pqHN1mdSmBai9aACWbLa4v8WG/wJONAhPir2U04C9yFV03U49BfK1Os65U2eQxIJa590UKkQZKOA09bn6J8nStfWsI8+7nKR9BqgM2BsQnMkQQ6UnyDsGhK8oIuTmQfaEl37ktqtpPSZHCik+5D44ih/kjjwL7DO+ZNbTompmQcyOr/vMCulV9qE8Mg915sBFffdSKhQMgh7TEAR0UIo338TMnQEHhKltfBUKb1Ho6wsRMi3Cokq1br4+gJVLBu0+d6jl51CBLOd9udehuoXAVZA/s8rSfpddklKleWa+jJ6I+Yk2xv1TBvTxOfSFVcd/vBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lWP07hmetoH+yExhG+72bUpFdUd2H4altE2wV1xYcI=;
 b=i+lUyS1SwTjbB4DfzNhHpF9ZJMriqJLse7ncKnXkHFk1HzZZ7CD1QUKptpGp7MPAaeQrwkiJu/bjsCzIsktY/Qfcytoa5zJpUErH7IbknBtbZj8CR5vO/3hQu9ry0WUYVW4lHdZG4eg1DL1SUvRsWMn8ipcSwOBO7+KFMY7FdmVHJd1fcntStQHAvjcIRpSdq+xauDxGjENEVDfJCIaAdvMH3ez2TSivmgoFFE2IiyVKcEhGGLuY7FuVVFiUfO2QKnAZKy5KpJOFY3zdNd6KEQG3X7SrLpQ0HiRhZvhHL49l5FAXk6oARLNesokaKg8ybPrPjIMktXzrpfsuHv7kBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
 by MWHPR11MB1374.namprd11.prod.outlook.com (2603:10b6:300:24::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 01:27:35 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::44ba:c91c:ea6c:118d]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::44ba:c91c:ea6c:118d%5]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 01:27:34 +0000
Message-ID: <dac6c014-6012-ed80-6db9-61c714b14f23@intel.com>
Date: Wed, 9 Mar 2022 17:27:32 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next 3/4] mptcp: handle join requests via pernet
 listen socket
Content-Language: en-US
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
CC: Florian Westphal <fw@strlen.de>, <mptcp@lists.linux.dev>
References: <20220224155010.23676-1-fw@strlen.de>
 <20220224155010.23676-4-fw@strlen.de>
 <ab1f9296-3637-d13a-bfe3-97183f593190@intel.com>
 <20220308184531.GA22024@breakpoint.cc>
 <d796fef2-d380-c92a-7516-617992a20460@intel.com>
 <20220309125351.GB26501@breakpoint.cc>
 <4e545ab7-7a9c-921a-0095-6a7e5803cdae@intel.com>
 <20220309213730.GC26501@breakpoint.cc>
 <642225f9-f179-9947-49d1-2ee6ce7cd40c@intel.com>
 <aa986cb4-4ba4-7924-d090-d2d615b15649@linux.intel.com>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <aa986cb4-4ba4-7924-d090-d2d615b15649@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P223CA0025.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::30) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:9e::21)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3842abfc-c770-4c6c-0285-08da0235279f
X-MS-TrafficTypeDiagnostic: MWHPR11MB1374:EE_
X-Microsoft-Antispam-PRVS: <MWHPR11MB1374AF8D21752B15772E55AFE10B9@MWHPR11MB1374.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bp3C7zsuHWV3WZ8eWqXeuY+U1TN02HD+8R5fqVz0oUfrkRBGIip4OmRRtuZBgGT3PcN7oBwjm+P827AANL/56x7cauUXmZIwep8awrDwCKYHL/lFn0l/hVlK4gl3mpijzkxOaUDZbzZGMd8pA2lZwBCOicWe1pt8kxA93wH53MSFxsMnE9HDyt+VR/oDUKn5Kscsq09oGoY6sqqUzRHAF9tffZQnl5iS2HKokHgIGqcf3ySc5KikbeW3kRtTC2q4yQdqIUU2oLQ/Y4CJFOMNBoB0e/giC3FJ1gt87S22kC1EqFyvBbM+I1c72cyS0SAFoVFgUCQh2ybtosfBbmOUeMMcJYc3E/pP8QHuaF2CfiuyI46zrAkHUjczGWPNBVsMf0m6i/OoJk/zauxmWY2ROoOfLKAEguZhC0pKZYtEFSFrz/4yMiehU6CjjqZwNA/kA1jZ8xTuRUcI0E/Dkrr97tDgUrvPjEMUXnwAJ8zyYv1qyt92SYEWSCkV7GQqa9Mw0/cBSkrvJOY7MmeKvL3AzBNQVw4rHDVN4vIH9hOcO2wxae8EdLM+hDQoP++BC4gRo39nD6S4M15Rtr95rn1WJ773XYyvK62O2X4ncXtgE1GsMku1ROW/LybIax8xPQEIZ8gy3cZCwhYcv4ms0f8qIzqpVAiEro2QTB2wOpYe6YyE8RRv6aY7f1i3cGm0xHKHTvZ+ovhrOqaiTaRGr4EGFSVwNQ5irNVQ/dfocjG/qrqAB2h905UbTgFW8X+uQ2FD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(82960400001)(8936002)(508600001)(86362001)(6486002)(36756003)(2906002)(31686004)(5660300002)(316002)(31696002)(53546011)(6506007)(2616005)(6916009)(4326008)(8676002)(66946007)(66556008)(66476007)(83380400001)(6512007)(186003)(26005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cy9jL2hta0MwcHZtSHRSQ2wrVDJXc3Mvdi9RbHE0MkNhcDNOWjVHSnRFRnpG?=
 =?utf-8?B?Z3RjZFZScXVXZHVUdk01cHkrTWNOeURyODF6ems3U1l0Z3RpQ2tWdzJYWGRJ?=
 =?utf-8?B?R2ZhN3lFS3RqdlNROW5wUWs4cFZkU29NSjZ0b2dIR0NVeGV4TUEwYlZUaHh5?=
 =?utf-8?B?K21TMHB2bU9VTDdBM0g3cFcyanQxa0l1dENGVXNtaWExcUt4MDdlY0F6eHhY?=
 =?utf-8?B?N3dPNm1COWNtN3lFRUJYOFRKcGo0VC9uNVJrYmxwZ3pHamNNS3R3eVRFdzZI?=
 =?utf-8?B?MFZrcmw5OENJc1JvVGpZU2dJQ2lwK2RNd3FtQ0hFaFd2L1JVeUFLaExtVVNP?=
 =?utf-8?B?RjdBcUM1UURicUcyakhXb2FKallmcm83SkwwS3pncnEvTVQ2ZWZNbjA4cTI3?=
 =?utf-8?B?QVB5VVB0S1U0V0JmZGlBMUtaczQ4YkZVaHc3Ymp1dU9GU2NzWjU1K0hRNVdj?=
 =?utf-8?B?cXlUbVRNejZSSGpnVnR5clI3QlJ4dTN2MHRSUUgxY3RWbkFEb2JjRW5oaUJN?=
 =?utf-8?B?ZFJGbFppTkhMNXkzSGRROHJpbmIycUJEYTd3a0RIOThGWG5lQ0hXMmxwbXAw?=
 =?utf-8?B?MHBCZmlXNWNyWWxSeTRpZGpXRG5TZHAzQnJrMXdUWmpqZ3dXUTV6VmsxSEJW?=
 =?utf-8?B?MWdBNFJyUGM2NUI1VHpqVEo2MXhBWU02QSsyK3NUZzk1ZUJoUXg0NFhWbGxs?=
 =?utf-8?B?ZGJNMkRoUmp6N0lJMU90QWxqTTJ4L3VLM2wrU1B1elk0L2dYd2d6UHNBYkhz?=
 =?utf-8?B?aUVqRXVNdjJ0ZXNpN2NhMjFjSnB4TENzUGdrMHZoaGh5NE5hYzVTL0gzdVFC?=
 =?utf-8?B?RTVmOW1FVGxVc3d6citjZm5hN3dJZjQydlgwSTlOSEJQTTdOdTdBVkV6Y2Ra?=
 =?utf-8?B?Tk41K29KM0swMjA1UFoxVmp2MU4wZDJpUjlaRTVET2R3Qm93UGVHbG1qSDZ3?=
 =?utf-8?B?MktwNk4zQWZDOG1nTnF2MkZDRnVSQmNzTjBzOUkxTWZkZzllK2R5Z0thZkpP?=
 =?utf-8?B?SzRhN3VaSlpXTWljSWlDdFBpdXhXaDRLYzZIYzZHK1ZBWjlKRVNwYUIzcWJs?=
 =?utf-8?B?NWZBbTMxN0ZjWFV4Mm9yYjR0Q2l4N2JCTFp5OTlIQy9LVWRFejhSY3ZTNkxN?=
 =?utf-8?B?YUtsekUyY2tGSXY0Y0FyVW9SU1FOUkU5MVdQQTYyT0s2MCs3T3VZSFRubnJ0?=
 =?utf-8?B?VEZzb1ZGTDNkUkpIUEFwSGhya0dwMnFDRVJQSGpiSjBBVHdpQzJIeXNaa01j?=
 =?utf-8?B?Sm5LaVJTc3NmdVNOWDhsOTZDK203aUFaMjlieDFhaStNdlUrR0dlam9lS0x0?=
 =?utf-8?B?RTdacHpCVmpoR1pwS3VVUVpHVllTaHhrTHNlQ0xIT0FPcGlYQXZXMFNVaStW?=
 =?utf-8?B?WEc2OWZXWHc2emY5T01oeDFXU0lxaDhxUHY0OGFxTUJJQWFkVUNLYVpqUjlH?=
 =?utf-8?B?cXFEQklqV0FPOXNJWHZnaC94ZXNldUNzQWtUY0dCZHlKeHVTNTBkOHFwN1VI?=
 =?utf-8?B?U29ab0dNbEdxdHpjWlpDbW1zMDZJNVhpUWlXbWFva2o4WGFGZ2prUGJqZ2ZO?=
 =?utf-8?B?Y1gwcTNNRE55Y3UrMml2QkpyV3ZUN2VkZ3dvdkMzblVPcWEvOGZDK01BalBp?=
 =?utf-8?B?cXRlTXNtVGgzcFB2M3lkL28zY0t4L0VLcnU3dm9McGgyQkpnZ2N1eXI4RVFr?=
 =?utf-8?B?Y2F1ZHNDcE5tcHUwMU5SUHhsRjZrZkU1K3BjOWxxbDVuTTJMY0tGWG1OUGlY?=
 =?utf-8?B?S2t0OHhXZ1NsTi94YVd1QmpoWmFJbjh5QXA2RmNDbFc3dHhkU3l3U0F3eXVY?=
 =?utf-8?B?Q3FscnE2N05lWG1mTzNmcDdLcXdqWGxYbjRPQW1jVWhsMXB4Snlid0pPTEkr?=
 =?utf-8?B?MGk0c3h6OW9UbStKNGtpa0ROTkZaaGIxeDZsL1BEN0Z6NUxZaTdrT3ZqYWRs?=
 =?utf-8?B?VE5wSnpyelE2UDhDWmpNZC9ncERJamkwVXlDbVNsaFdicFpVSitxZWZHNFhK?=
 =?utf-8?B?YnJGc0NxbGd0dmMxajRLR0lhOEc4bk56QnI0V3BnN3I2NFBTaEVNUHN0aEhB?=
 =?utf-8?B?aElGTm9UUGxaMThhVmJ0ZGc2S2hwM3VNUFQ5V1kwVHRRdlRSRmdpbjErdGxE?=
 =?utf-8?B?Y0QzaFR0YlhUSkZ6ZU1OVjJTTS90OHlhNVhyRWt2eng1QzdzUEpkZm1ERDYx?=
 =?utf-8?Q?TOFSJUWwAQbHaydw6UHd5p0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3842abfc-c770-4c6c-0285-08da0235279f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 01:27:34.9163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVqcRBHjfzeVnBEb9xTctxZkeiBsbMDRvcXCZmK0lBrzNyETced7NjwPuGZzNKH5D3FLP3A4kbcFS5ZzylIc7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1374
X-OriginatorOrg: intel.com

On 3/9/22 4:37 PM, Mat Martineau wrote:
> On Wed, 9 Mar 2022, Kishen Maloor wrote:
> 
>> On 3/9/22 1:37 PM, Florian Westphal wrote:
>>> Kishen Maloor <kishen.maloor@intel.com> wrote:
>>>> On 3/9/22 4:53 AM, Florian Westphal wrote:
>>>>> Kishen Maloor <kishen.maloor@intel.com> wrote:
>>>>>>>> Over a newly established MPTCP connection following listen(s1), the PM can issue an
>>>>>>>> ADD_ADDR with B. In light of this change there would be no listener created for B.
>>>>>>>> But if the remote endpoint immediately established a subflow in response (to the
>>>>>>>> ADD_ADDR), then that would create a subflow (connection) socket at B.
>>>>>>>> It appears (and correct me if I'm wrong) that bind(s2, B) would fail after this point (?).
>>>>>>>
>>>>>>> Why would that fail? You can bind x:y even if there is an established
>>>>>>> connection from x:y to q:r.
>>>>>>
>>>>>> If I establish an MPTCP connection using mptcp_connect individually as
>>>>>> Client and Server, then I am unable to bind a 3rd (new) Server process at the Client's
>>>>>> addr+port [1]. Why is this the case?
>>>>>
>>>>> Whats [1]?
>>>>> I suspect this patch series needs following addition in patch 3:
>>>>>
>>>>> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
>>>>> --- a/net/mptcp/ctrl.c
>>>>> +++ b/net/mptcp/ctrl.c
>>>>> @@ -337,6 +337,8 @@ static int mptcp_init_join_sk(struct net *net, struct sock *sk, struct mptcp_joi
>>>>>      if (!tb)
>>>>>          return -ENOMEM;
>>>>>
>>>>> +    ssock->sk->sk_reuse = 1;
>>>>> +    ssock->sk->sk_reuseport = 1;
>>>>>      inet_csk(ssock->sk)->icsk_bind_hash = tb;
>>>>>      return 0;
>>>>>  }
>>>>>
>>>>> After that, follwing sequence should work:
>>>>>
>>>>> 1. bind(0.0.0.0, p1) // listen, accept etc, initial subflow established
>>>>> 2. announce p2
>>>>> 3. receive join on addr, p2
>>>>> 4. bind(0.0.0.0, p2)
>>>>>
>>>>> 4) should work because sk used for endpoint in 3) has reuse flag set
>>>>> and is not in listen state.
>>>>>
>>>>> cf. include/net/inet_hashtables.h, line 47:
>>>>> 2) If all sockets have sk->sk_reuse set, and none of them
>>>>>    TCP_LISTEN state, the port may be shared.
>>>>>
>>>>
>>>> Wouldn't 4) fail if the socket being bound at the time does not have the SO_REUSExxx flag(s) set?
>>>
>>> Yes, it needs SO_REUSEADDR set.
>>>
>>>> If so, that would be application level thing and in that situation we don't have a way to
>>>> avoid a race.  Whereas when we require an explicit listener, we could have the kernel take a step
>>>> back (and not create a listener) to break the race.
>>>
>>> Uh, what?  Sorry, I am totally lost.  I have no idea what the problem is
>>> that we're solving here.
>>>
>>> EOD, I am out of ideas.  Feel free to toss this patchset, I have no idea
>>> what to do.
>>
>> Sorry, what isn't clear?
>>
>> This series was meant to address perceived pitfalls of kernel listeners, such as
>> race conditions which were discussed. So, I believe we are trying to assess if
>> these changes indeed do that, or if anything further needs to be done.
>>
> 
> Responding to both Kishen and Florian:
> 
> I think Kishen's summary here is accurate - the way the current PM code uses listening sockets, and the expanded use of listening sockets in the userspace PM code, led to some hard-to-troubleshoot situations where in-kernel listeners interfered with applications expecting to bind() the same addresses / ports.
> 
> And I think what Kishen found while testing the userspace PM patches is that the "pernet listen socket" approach still has some bind() failure corner cases that application programs (and programmers) might find surprising, and that the kernel can't solve these cases. In comparison, with the in-kernel (explicit) listener sockets, the PM code can see some of those failures and work around them to some degree.
> 
> 
>> It seems we've thus far identified one change as a result of this conversation to avoid a
>> race, i.e. setting the _reuse_ flags inside mptcp_init_join_sk(). Is there anything else to do, or
>> are we now confident in these changes?
> 
> Kishen, to be sure I'm parsing the above question correctly, "these changes" == the "replace per-addr listener sockets" series this email thread is part of?
> 

That's correct. I was referring to this "replace per-addr listener sockets" series.

> If so, yes I think the reuse flags are part of moving forward with this, in addition to what you mention below.
> 
>>
>> I think the group needs to make a call on our path forward (one way or the other) so that
>> we can also progress on other related work.
>>
>> On a separate note, I brought together my entire userspace PM series and this on a
>> tree to test and found a couple of glitches in this patchset. A few userspace
>> PM subflows tests would fail due to that. I can respond later on this thread with the
>> specific modifications after I clean things up on my end.
> 
> We will talk about it again at the 10-March meeting, but it sounds like you have some modifications to propose that might be important to consider in a final decision. Do the fixes you have to this patchset involve the bind() issues above or are they totally separate?
> 

My changes are separate and fix a couple of logical errors in this patchset to make things work.

The bind() related issues discussed in this thread however was just me analyzing for situations
that could lead to races with the application, and was thinking along the lines of Paolo's prior
assessments.

> 
> -- 
> Mat Martineau
> Intel

