Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3A748C1
	for <mptcp@lists.linux.dev>; Wed,  9 Mar 2022 17:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646847612; x=1678383612;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AVu/cl8Q1VFkNH4uvmszvVsX8k82glPL6Oh3MtAP72M=;
  b=F5HKiQ90s4yPqfTEAWaQzuOUHZhz/rtRfyP90I3XCO+zamMLCGzxz7sk
   CE2SV9us3IJGrSIsFIG/XHG3fOvP1zFXfLUim0LVQyXX4V0Yx4EoBp7PG
   hGZMrq1oVBJMGXCJIHnBesXJIRIlwTlMLwCq1xcu72/kaeBreUuEWo9V+
   0vPcgcbfiavb6NhzZqyktDVXkBoRtQkugBfvaaxEhYahjmep/HgdB/88B
   DVj1p9U20i9+fkfAAxm0xBp2WrlqSG7dWoCWNBfBR9DGMhQuB/IalZLoE
   gJ1Ickf2o94q8bOZ2WYcmzgA475TsImhKQNQgV8RMunZYKh5A3MyWbTnQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="235649720"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="235649720"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 09:40:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="781161273"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga006.fm.intel.com with ESMTP; 09 Mar 2022 09:40:10 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 09:40:10 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 9 Mar 2022 09:40:10 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 9 Mar 2022 09:40:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZIcwQAG0+j2jPewoPA1kIDjXmz2TDVkzmJd81a10QMhys5Ikd0gJzgC6Bv0VssA7tVy89I6NsgbbPsKD9FjrDjhCxD116Tul9hWrMiQRmvmyJrBfQq8tdSDRdz47Al3Mmsv0rsppYRxZrzS+ulIh4EN4ECIIvQtY4UfdENaI/4UJMmlMUO7gQ+Y6tCPZHdfLTLb2Z8V7E305+AlTVTQfmCgCPbAxXY6NKvomreY9XPZaU5jMDhE4Kp8v1MfOTy3ZXhv7YPblmRXL17P+4y/0y9Nbb2nVrRD7lu/kaKjeAOseijAfmFNy7TjYcSJ6LnL2W9vmWvTx9bYKiL4/7qu9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3kX6sUFQup9p/EBoGiW/EE0zVE1Hhi3vbHkS3QRe7E=;
 b=PPjBNOyLQa3qCSp4IEVWCw3ngHhhp7qNK7LnuKYoPm8rDhwxBtg/zxAg1FD76ejixX+SMIhXEAlWFZAn8L/koDbXZrKBzOMcqVZUaVDdiUK8QgicwCigr45+rtnvY4hVjAHGGEClxbh4DE3mOsfxFY9MLjFrRrVzn4AYm1QN7rmPm8eErIAv7hfj62JbDMeTykkY13+7elSWzixxVAFiMIfj7VP6afIlvXMJU7thwnZx4fRwP/SJ3V4xwqrx/RY0KEoibMy4YS0LR/JmJN2KtSui7SO1wcR7GIltxs8+BV52rx9kpG98lmiqYZWL69qLZHM+XesBMRIAvZeEPgCw0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
 by DM5PR11MB1531.namprd11.prod.outlook.com (2603:10b6:4:10::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 17:40:08 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::44ba:c91c:ea6c:118d]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::44ba:c91c:ea6c:118d%5]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 17:40:08 +0000
Message-ID: <4e545ab7-7a9c-921a-0095-6a7e5803cdae@intel.com>
Date: Wed, 9 Mar 2022 09:40:05 -0800
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
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <20220309125351.GB26501@breakpoint.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0312.namprd03.prod.outlook.com
 (2603:10b6:303:dd::17) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:9e::21)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cc0b418-d74e-4f20-7dde-08da01f3da82
X-MS-TrafficTypeDiagnostic: DM5PR11MB1531:EE_
X-Microsoft-Antispam-PRVS: <DM5PR11MB15316B18DE570352C986B1FAE10A9@DM5PR11MB1531.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eClYecd8G1KAONg5T2qyCV0GrnratoY/Ip+srg2s+XgFJA+Z5dLLtjBY/TTiUYOtxRgxiPebCoUyYG2/zSS+RKPhZM11jJlQ4Lhg/eN+leaVRKncKX7dbJIkjWIU/Aiz4XSFWpClr3HmCcoHFLSvqSXy1/lp4+tpSQwArFiNaTeFd6fhS/JX3UBTAaw1VKJn1poBOiX8l42vIiU7h30rvCwh1b/66oBriS3pYAAMd2cPn8siXyUHmbJ7yrtrVzIjCjt1sXoyk7Th6PqXBvPnSwNgMiUNKYB2z7VSaJtnjEWf6k8Ka9zv2JsP9a5tjgmVpwYfJcVVlf2y4c//nNm5z8qD8Tj5LuxbHfwOH5VpXcOvtHAGVw9sUXinFdHMBYYQto8/NAE3uxF1fULdTVt4W2K+dg4QPxEqHJ0RuJV/qSfKp/Z5hFmOQWccXD6N2LJkUaFj/GXsyEEB1uMsXSzNQmHxImc3l8hDj9ojL6xP+QWzqmDtLzwzI8pNn5IRZPQGLA6G/bsDZhpZbuIztbp1ebcb0O+WWv8OAX7AgJBj6q0D/Dn37scIOS6ABFetzwt4yzdGeLmbZILPGDATg/W+WMDhUfUClH2Rn7i7/nfoLJXtYaK8U49ockOlgrtgY+cYU68NqArAAOBj4KFL2o8ir1KaDJuzmtygtBxaQ9k+2chOXR2965SHyDCRXqU6mm6LlDcTqTZkwLDgAbhR/hQtFiWQ86OYnQTzVRAQM4h4brlosp4wAbZi8n6pCM08wmgm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(4326008)(66556008)(66946007)(508600001)(66476007)(8676002)(6486002)(83380400001)(8936002)(5660300002)(6506007)(6666004)(53546011)(36756003)(31686004)(26005)(44832011)(86362001)(186003)(316002)(38100700002)(2906002)(6512007)(82960400001)(2616005)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnpkRGl2b3k1R2Q0K1VEekdpYVBEZVlNaUhRbEMyVjZCeEowejJHeUJ2ZHky?=
 =?utf-8?B?ZUpzc2dYeGxrMzlhWTFBVTl2a0xvdW1EQ2RRQmlpWnZyTFZXWHA2Z1ZXYU9z?=
 =?utf-8?B?MzdNTU9rVmRQZkNxMzNVVnBOVXBGbEc2UEFSbkRZU09GOHI2SVBWWTRWVzVC?=
 =?utf-8?B?a1hubEdHWFhFYUlXWFBqQVhOd3hGZzhyUWpsSnMvcVl2OGt5RmZoUEFlOXFv?=
 =?utf-8?B?TExGcE52RGRNRlR1L1loOVNVbU1tL1RkVDM1blp1c0tiTzVDb3V0TmtVdzhW?=
 =?utf-8?B?SWtwSktCZEVnQW1IMVZWZlFUZ1N0ZVNDR05oaEZvYXpObURJc0hWZjEzTlFN?=
 =?utf-8?B?bjFWL0lHMjRtNFJ0MG5LM3FrL3J1aC9rUytPOE11TDhEcjUwM2JhRFd1NmhI?=
 =?utf-8?B?VFRhbGtlZ1lYd05vQWw4TVlPSi9HOUhUZ2xmUDNGWk9vTGJFSHF4cmYzWCt1?=
 =?utf-8?B?d3BEZFlobmhXMC8vZ1ZuZ3BXMis3VzByaFVpbFNBOUl1MzJPZ0xOVE9SNTVz?=
 =?utf-8?B?UVNaK3RvVGZLUlJCZU95cnVXT1ZXV3A2YVlWMC9mZkJDeVF5ZEJuYjJHQ1pr?=
 =?utf-8?B?SUFQdUp1Q1BmTEE1aExhMVpaNjBCNmpBM1JXTEpaTVdtcXJPOW5CMXlmVnJ0?=
 =?utf-8?B?T2IwRmFvMjBWakpOVDNiRUNCZm9FNkE4OU1pSFFyOVEwMDkwTlVxSnB6NXNP?=
 =?utf-8?B?dndJM085NmVCUVdUOXpwM1NhVUN5b2JnRmc3Tk9TRGVoK0Q4dFBGUzlsSktQ?=
 =?utf-8?B?c3BZTHZoV2QvQTBPdEFNRVRyRDdzL2F6VmFKTEJOZWNVdkRFbzlTeDFZelZk?=
 =?utf-8?B?UkFpZ3Rwd0QvYzczaG5sVzBKZmsrQ3FvK0xMaTV3ZkNCNjlubDdIT1ZvU3Bh?=
 =?utf-8?B?VmN0cm5lNmxYTGpjSlRBaHdPREkzVE53TTdXaUd1ZUt1Y1huU1ExMVVSbnUv?=
 =?utf-8?B?MHBBTTBTQTVvTEQvMkNQeXQ2SGZULysxRUZBTjZIcll0WXNPcWNKUURLY3cz?=
 =?utf-8?B?R3lJODM1OWtsMDRLTlVITWxZSG40V0g0VHBvbVF0Q3hyTXVlUUpJOFYwVmd0?=
 =?utf-8?B?Q0REVWpIeU5ydmhzZlhENmdLdnF0Vjcyc1NsMWtkV0RVNUpLTVl4VVVhclZ6?=
 =?utf-8?B?QjZDZDJOZW11V3F5R3JpS0FKS1JaODdJR3ZkdjN6aUVxNDljaStYQThQMXl1?=
 =?utf-8?B?T0tsQk5rVytsN3ZQczJCaDhRcFZLN3dYSFAveklOTUJ5S1djcjZuMHBLdkxx?=
 =?utf-8?B?RlZKd0h1QUhQcFJNODZ2L2Qwd0pHaVhUV1FhT0kyUDExQWFEcDZTYVhZQkEr?=
 =?utf-8?B?NXdYUU9vLy9KK0h6M2hXc3I3MGJWd2VvVGtvRytJbncrTERTSlNzTmhkV1hB?=
 =?utf-8?B?cE5vSlE3NFpaRzZqR1Z2SjNEWXRLMjY5b0c4cjBZaUFRMm1kamsvRXVXRG91?=
 =?utf-8?B?b1IwekJUUmh4S1FsRzZyK1VQQ0R6UFBnOG1oTVJCSkJtNnZ4MVg5U3pCM2Zw?=
 =?utf-8?B?cm9kd2gxUlJlZTdqSUVUd2lWbTNZRXgxWVppaW4xeEVLTG5qeEYrd1N4Mk14?=
 =?utf-8?B?eitMc29ST0NSK0l1bWgrTWt4VXVTd0lxYVlCd2gyWUtXVVlrazZOWHc0N2k1?=
 =?utf-8?B?RmFzSFplMEtzcGdxL1JzbDcvSG9tejJHU0lqNE5lc25ZRmpOQVRwVTNuSmxG?=
 =?utf-8?B?a0NKVGc5TzgrbmxsRkhDMVQ2NHNkRENXUnVyT2pFUE1oU1NodjJMT0xFdzlG?=
 =?utf-8?B?SmNnL0J2aURSNEl1QngwK0ZJT2R6d2Y0WG8yVFl0SmdldHN6R2VYOEc0aW1h?=
 =?utf-8?B?UnBnTWdCUHM0ZXd0UjFWd2tXUDdEVDYzeG4xZFAyMjF5UExJWUZrRXJNK3lq?=
 =?utf-8?B?dUNMZjM4dXBTU1ZuQWNzM09JaEdtOFN1a2x6eWtVWVQrMHR5SzNWemZBZkVF?=
 =?utf-8?B?b3pMaExHalBjY0VXaSs0NVJmZnV3c0Y4MTVrMk8xV3hXWXZRNjVXQXN5VHRq?=
 =?utf-8?B?ay94bDk0VVRzZW1XdmhteFBYblB0WGppaVJ4dkNaWjYzaEdXcGozbzdZbWZP?=
 =?utf-8?B?ZWZ6cjRHd0ZzMXBOa3l5SkNXdytwVlR1QkNYb1l0eHBkWS85U0VFWERTcjhx?=
 =?utf-8?B?ZGk5MUUxTnJ2L3BSK0FzUGFTSWhldnVScElOMzZuY1ZpYXY1cmFERDN0Vmpz?=
 =?utf-8?Q?/Ho1IWzvw2FArFYWYaqPk/o=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc0b418-d74e-4f20-7dde-08da01f3da82
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 17:40:08.3211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vRebPZUlEk2Xz/DCM2qinhH7ODb1feJEo4KYnX/4rh/gZ5u+OTS8aRz79jTuICKToeg83xq0GCkaSxbAMuJ9LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1531
X-OriginatorOrg: intel.com

On 3/9/22 4:53 AM, Florian Westphal wrote:
> Kishen Maloor <kishen.maloor@intel.com> wrote:
>>>> Over a newly established MPTCP connection following listen(s1), the PM can issue an 
>>>> ADD_ADDR with B. In light of this change there would be no listener created for B. 
>>>> But if the remote endpoint immediately established a subflow in response (to the 
>>>> ADD_ADDR), then that would create a subflow (connection) socket at B.
>>>> It appears (and correct me if I'm wrong) that bind(s2, B) would fail after this point (?).
>>>
>>> Why would that fail? You can bind x:y even if there is an established
>>> connection from x:y to q:r.
>>
>> If I establish an MPTCP connection using mptcp_connect individually as 
>> Client and Server, then I am unable to bind a 3rd (new) Server process at the Client's 
>> addr+port [1]. Why is this the case?
> 
> Whats [1]?
> I suspect this patch series needs following addition in patch 3:
> 
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -337,6 +337,8 @@ static int mptcp_init_join_sk(struct net *net, struct sock *sk, struct mptcp_joi
>  	if (!tb)
>  		return -ENOMEM;
>  
> +	ssock->sk->sk_reuse = 1;
> +	ssock->sk->sk_reuseport = 1;
>  	inet_csk(ssock->sk)->icsk_bind_hash = tb;
>  	return 0;
>  }
> 
> After that, follwing sequence should work:
> 
> 1. bind(0.0.0.0, p1) // listen, accept etc, initial subflow established
> 2. announce p2
> 3. receive join on addr, p2
> 4. bind(0.0.0.0, p2)
> 
> 4) should work because sk used for endpoint in 3) has reuse flag set
> and is not in listen state.
> 
> cf. include/net/inet_hashtables.h, line 47:
> 2) If all sockets have sk->sk_reuse set, and none of them
>    TCP_LISTEN state, the port may be shared.
> 

Wouldn't 4) fail if the socket being bound at the time does not have the SO_REUSExxx flag(s) set?

If so, that would be application level thing and in that situation we don't have a way to
avoid a race. Whereas when we require an explicit listener, we could have the kernel take a step
back (and not create a listener) to break the race.

(By the way, [1] was just an annotation so I could refer back to it in my statement
below :))

>> However, I am viewing this matter in light of your changes wherein a connection 
>> socket is established without there having been a bound listener at that 
>> addr+port. In that case, I was wondering if the above situation [1] would apply on a
>> subsequent bind(). If it does, then we could encounter a race such as I described. 
> 
> If so, we should consider dropping support for address announcements
> with ports, it seems too fragile.

Well, this isn't about port-based endpoints and I have thus far assumed in 
this conversation that we're just reusing the subflow port. So, A and B as taken from Paolo's 
original race condition scenario in my mind refer to addrA:portX and addrB:portX.
