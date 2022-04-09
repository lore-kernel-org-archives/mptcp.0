Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48BB622
	for <mptcp@lists.linux.dev>; Sat,  9 Apr 2022 01:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649467660; x=1681003660;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4M1svzXP68AvkpZSaI1nPompBM5oiEKBXok1n1bdwXI=;
  b=QLjXvliCjyTvdHwNaJ0Z0aNkzwaBIp9qIL1jHVvIqfTLTZG+L/E8qb1c
   VmXiYTLDNwWjiqiLsX9rvsrgmY/d1krkx0RKIbJF9mMz8Az3Sj/hBsJfL
   27FdUgQsgIO5jsfZ5mw0zOa4qig3S4/RB97cddVeuh7EF9YaSwI0d49nG
   U9NU5msEKN18li2NMn4v3aMFw2dbqEbGcCLC4TSncfl1Kux29Hi4dK93a
   DNGwpPKV06EHXjrKGlW0qQRcpxDZ6GTiqqNtN9MF7BK8XYHYYagUAPGUn
   mNNRwJy/GFhztUPRFTFTqYlTN7FezDqizUhbY/13wVjgucBtg53IPQdUn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="242334056"
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="242334056"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 18:27:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,246,1643702400"; 
   d="scan'208";a="609999401"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 08 Apr 2022 18:27:40 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 8 Apr 2022 18:27:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 8 Apr 2022 18:27:39 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 8 Apr 2022 18:27:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1UzWR9U4zWB5z4tRGU5SRzmAjVgNXOTCEt1mQ0OeROXhqlWDc/N0XLgNnnobGwSOlafokO5plJGJxgFe5nlf79H5D8YzMmgEOHDwflJ1JdjQvSoJR4I5HkOobK4y/gQ/2XowlL9YoIW/neXaVd7ZWDsEZgfzL5oMuf2idhM5yL17LFtRjILqmkkjShHd3niysBijpRr4sYIPwIfUL0QBCYTLh+NVQgoTRBdDFDRqRuo1HGTytwhBsgFrJbYNPmvQhvmHgZMSYjODLrXEpv3AmAeYjNPTXfx6HVOtgOkPHrQUNL/eSfU1wCDXcJlWZW84a3GTjveeKfnHUskgBTQyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3PEow09jvFvUOkTTyrJEQwd5JFjFAkzJufSmIu+FsE=;
 b=Y/iOaf0gvzG/QwVkzGGw3QjnzQlGmMP50HVdtXefI9pWDnsnFIHBiHW4poedr/4bX6D9+f4zwcI1rjVmH+a4DJe6kFhcgjb+V/CrWDLLD/xtx46e4oxDdWTVa2tZou6vV3ejYneJdGMr7s6J8WYoOTqepUDCoDOwUNYNc3VzBlcmyg4kx10UV4opYhzyCQwxLxKHNQ0UAJ32Rn01ec03ClkMadWdJZ7NvIjhQakTP4DQJs5wtNIhrrff7h/Re10w7/ScMVswR/y6ZhpkjWoj/6WIP8O5uKjhMQ7HOFWshVZcujLWhHEU/8URUfAEgjldkjPB4AA7jDJ10IxGwPRfLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
 by BL0PR11MB2883.namprd11.prod.outlook.com (2603:10b6:208:7b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Sat, 9 Apr
 2022 01:27:38 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::99:140:4781:f4d6]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::99:140:4781:f4d6%7]) with mapi id 15.20.5144.022; Sat, 9 Apr 2022
 01:27:37 +0000
Message-ID: <bec5db91-a2d1-cfeb-3551-23588aa7704b@intel.com>
Date: Fri, 8 Apr 2022 18:27:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: selftests: mptcp: functional tests for the userspace PM type:
 Tests Results
Content-Language: en-US
To: Matthieu Baerts <matthieu.baerts@tessares.net>
CC: <mptcp@lists.linux.dev>, Mat Martineau
	<mathew.j.martineau@linux.intel.com>
References: <20220407234029.1774481-15-kishen.maloor@intel.com>
 <0fad9a2c-ced8-f28b-9582-076ec7ff6b5f@gmail.com>
 <f1401baa-ac43-e1eb-209e-6c4d956cc37f@tessares.net>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <f1401baa-ac43-e1eb-209e-6c4d956cc37f@tessares.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0066.namprd08.prod.outlook.com
 (2603:10b6:a03:117::43) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:9e::21)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48e072a8-854b-4ddd-01ce-08da19c821d4
X-MS-TrafficTypeDiagnostic: BL0PR11MB2883:EE_
X-Microsoft-Antispam-PRVS: <BL0PR11MB2883B57DD3F380B74D8E8DEAE1E89@BL0PR11MB2883.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mITwa4mZVRVsraKidT8RDOzHxT+Jn3emktTDRIccuJC5NQ+AzTykZpWjkyRiew/DDfOBaSZEhr3Ui7Xtf2qgXl20O+TyGVSSLaPG/LhqtagBn5fMVDZpCWii1HccVFUR7Lr5lG9bTyvtMyTqjo37sxrTwN2PxwpkN8TzRLM/JQrG5GkjyHr0ZYizZgVjowFF9nom8dxMuXQTqBb2Ye0AWo4Hmka2KA54zjk+t67TiP2dqZKePQlW6h3iLICmDrqAURvcGsiNWS9rQIFdJmjVHWs0WLLDHj1motlRQci4bfae+Soqgoxnv3FPP4ECszyjx84FvdUBxv07g5XhbPUhOL4trk4DM+XTbh5Wxca+aWSPac+KYK+FcPeqclVuCTDEkXSKkDYe+3Q8sA/yzfaeb9z8LMz3FsEUVXsiWvg98u7W0samDHqht6PZywrd/UkAlxsz6rpyEb8v2YlaIIaY45ijmyJF7qzcYC8fBo7J0oWCIGt7tSot278bZyiyZhlnKrQZUcLTe+wDfiq5mipSBhnjLRgXhnBdtpio6zFiFce+vq26Kww6oMNki0YdYsPcO8+oBA/yVJy1pzn7PRu183jCWWsCn6vMLYUjo41JOG59UrFimciN4AB6UFWnJNE66Q9PPpfrlGzzLW7aS3U+EInDCeZDdIr+P2McuPFKasaW/t9w0/Dhv3SKO015ihSahMV8mjf1iaoGuWOx21uvZBmovuziYlCKQNK1fd8htfcnSIdzxpWLMj+k2fVPt0bKOCEX5FBX2qzTucFh702JM/xKn0Ino2Ydjrer2MpZxQLup0s2aPHB/o3QMjN+J5RI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(82960400001)(8936002)(2616005)(6506007)(44832011)(38100700002)(316002)(6916009)(26005)(508600001)(186003)(966005)(6486002)(6512007)(5660300002)(53546011)(4326008)(8676002)(83380400001)(66946007)(66476007)(31696002)(2906002)(36756003)(31686004)(66556008)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXRjQWNXNFBsSy9aZTNZczhtRVY4L2hpMFlSRVkvS1N2cVgxVjZERmdCd25p?=
 =?utf-8?B?RWNMcXA2R0Q5L3VscTBrc3J5WWRrSkRvamNvWGhUNEVkdW9QUzIvWW5QZmRL?=
 =?utf-8?B?ck9ZM3M2QU5DTWxySW5VRnNqR29tbjNQRFBUVzRRYzZUU3ArT3ovVjdWU3k4?=
 =?utf-8?B?TzAxaExjdytUUzhqYloxczY0MDY2TXl5SUwrcHowRWxneWZJUTJ2Y2ZwK2I4?=
 =?utf-8?B?eWo2K2ZoNUw0bWlrczFPTzVoMGM5TWZ3aG1kMk9hSHNLWEw1RHNTMkx6dzdN?=
 =?utf-8?B?blk2eFlPRDBOUjhOcDBEV3UxcmJZc05nMStCNGdsNzR1K25YK3JQTE1FSXpJ?=
 =?utf-8?B?WVNOM2xHSC9zOTBXci9WV2szNXp3NGV4R0lPOFNGNjVTRktXSzZoZFJEUUFV?=
 =?utf-8?B?QWREd2RTNHZOOFpVZVBXR0xXdThuTWF5TVFMQU8yVHBkZjVPTUhpaTlYVEJW?=
 =?utf-8?B?c3lwWEJ2bUY5WFpsU2k4RjlnemFkdGJtVWg1NXFGLzN0WHNZdm8vaC9wUm1T?=
 =?utf-8?B?YnNJa2NtQlNlaXBVOHAzWWI5WjVJY2ZDSVRTYmN4a1JNaTEzUEZlamo0WCtq?=
 =?utf-8?B?ai90d2FuOW1QeDYrOW1QZ0hxaTF4NjRnTnMrVmhaRXlPYUFvTlFISHphM1hN?=
 =?utf-8?B?R3lnYkJvd001aVhFTEVPRGkzU28rNTNob3AxUk1oVm83M0VRcDNGamg0NUM3?=
 =?utf-8?B?Ulh6WU94dFZzWEQ5Tm9SclZsZU1rQ1F3T3JiVjlHWHNQUy9BVUhrQ0ZJdDFD?=
 =?utf-8?B?SERsZEZlVmNqcWlIclExU2x6UlRpYkp5Y0xKRXVKNndwZXlyK0dOUjBuc0tn?=
 =?utf-8?B?WlJhUzFPSnZiK01zNHYveUJhVFVtYWd0T3YvSjdpaTJPcDZ3N1U0TGNkRC9l?=
 =?utf-8?B?UnZnMldrdDNuS283QUtwR1hjMzFzQVBzR0owV21Qd1RKbnNVRmoxUlVHYmdz?=
 =?utf-8?B?TEVWOGR5b01TYU9RNkFCSEdrRzdrR1U4QXJEMS82akZrMmJnZXNxUUtML0J2?=
 =?utf-8?B?VGZqalh6dHdweWl3U3ZabkIwck9qeUlEeDNrMWM3L08rRUh3Rko0RE9KZUhq?=
 =?utf-8?B?VjhGZTk2UVQ1M3lEZ1FYTy9PdjNsMDFZaDVldlQyWTlETHJqbTQxcjRaR3Bm?=
 =?utf-8?B?Rmx3M0hLZ1ljNWlEN3RDOCtvaHNkSVZwOG54L3hSVDFZTkJFYWpwTS9VMzRX?=
 =?utf-8?B?NklJUTUyMUdyc0ZITHdxNThRR0lvb2tpVDB2djRZM1JRZ09Od0R5cnlreldY?=
 =?utf-8?B?ZmlPSFR3TlVLczJ3MGViU1JUYlNsUjB3cCtFVzUrZG5TQW1RUlh4RkptZEo5?=
 =?utf-8?B?STl4T1VGUkZEZG1DdHZKdWVERHdCKy81Y2ZjQVpiVU9WUG53MmRtMTg2K2Fx?=
 =?utf-8?B?NTNMNzZOR1Vsa0IzQUhTTTEzNHNtK1dsQ2YwdjVESEZxN3MrSFgxajNEWjBQ?=
 =?utf-8?B?azVoa01XR3R5UHFDazVkaVllZlhPcTZTMHlnYnFKOXdWWUliNlZVWVFsSXE2?=
 =?utf-8?B?bC9UL3lseUZqb1dmSzhOK2swODFadHpranJrN3gwb2wxMGpsVllXT0o0M3NE?=
 =?utf-8?B?UXdBcXJzZmR4dHhFZlJtMjR5V3RRakFjN2ovenFKeCtXOVlmanpRSjRiOUNN?=
 =?utf-8?B?bGJsYzRYckJYNXBMYktZV3UraGs2UGFGWm1wSkt3c0JWajZzcGNZUHpIS0FC?=
 =?utf-8?B?UnMwdjFBV0p1SFdZaGRDMTZuc3ljNmRHRzd2cDRTWTd0UGtYU215K3JvRjBM?=
 =?utf-8?B?Z1U2TXJCZ29vT2lhbzVnMUdjdDNTamUxbFJyaWF3M0xSMEd0Nmc5ZEVSL2lM?=
 =?utf-8?B?K0tCNXBsYndPKzhVWjZ4aG45TnlQVzVNdTBqb1NjTVQzTkpobjVXbmdlQ1VY?=
 =?utf-8?B?ZWN1WjZJeVgzS2VublFHNS8za0lTM3BWY2VYc2J6eDlnZk9oNE1FK2hLMnpV?=
 =?utf-8?B?M1NHZU9kbUNFdktwR3FMK09OR05hOVFQdERZNEZTaHowZW0xVDhocmU3NG1x?=
 =?utf-8?B?bUxGNEVTeHQrUlp4R0diQWNiR0xkZTY3SXF5WGhDQU05RWFSdDVTYmdaRUwy?=
 =?utf-8?B?L205MVNHQmtMQ1g2anRubzBod004dityR0FkejZHL1pHcGUydGZSbm1LZVRo?=
 =?utf-8?B?eEFHa0VDaGk5czNGK1Fkb1pWcTJBazBMY1E2eEZpK0l5K2pwRkZNK0NDUHN1?=
 =?utf-8?B?d09meDFMa0ZCcStZelhGNDMxckRBY25udkdHS0hWdzA5K2RTQWlQMHVoTmMr?=
 =?utf-8?B?TUdXT2NJQkh3N0JrRW9IV1JzOUtEL250ZHdOKzhheDRnSDVBRmNkekVVN1BM?=
 =?utf-8?B?S1pyb01LOTVlYjJCT082Tzgrd1lUVzNvR1VvclRmM3QxUXpTQ1A1WVlqYkpF?=
 =?utf-8?Q?fRVyW65Ac6XDdZR4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e072a8-854b-4ddd-01ce-08da19c821d4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2022 01:27:37.9135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMqnqV3nRMLdRqF6kht+UsjxPcK3u6Aif2jcipXcsPnPgP7m96uClAnAec0ZHjB31Q49E7FctyilhsxF8imvTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB2883
X-OriginatorOrg: intel.com

On 4/8/22 2:35 AM, Matthieu Baerts wrote:
> Hi Kishen
> 
> On 08/04/2022 03:57, MPTCP CI wrote:
>> Hi Kishen,
>>
>> Thank you for your modifications, that's great!
>>
>> Our CI did some validations and here is its report:
>>
>> - KVM Validation: normal:
>>   - Success! ✅:
>>   - Task: https://cirrus-ci.com/task/6670539791007744
>>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/6670539791007744/summary/summary.txt
>>
>> - {"code":404,"message":
>>   - "HTTP 404 Not Found"}:
>>   - Task: https://cirrus-ci.com/task/4629846209855488
> 
> It looks like the issue is the same as with the previous version:
> 
> [01:14:32.748] + ./userspace_pm.sh
> [01:14:32.757] +
> /tmp/cirrus-ci-build/tools/testing/selftests/kselftest/prefix.pl
> [01:14:32.764] + tee /tmp/cirrus-ci-build/selftest_userspace_pm.tap.tmp
> [01:14:38.155] [ 3434.740942][T11903] IPv6: ADDRCONF(NETDEV_CHANGE):
> ns2eth1: link becomes ready
> [01:14:38.171] [ 3434.756018][T11903] IPv6: ADDRCONF(NETDEV_CHANGE):
> ns1eth2: link becomes ready
> [01:14:38.192] # Created network namespaces ns1, ns2         			[OK]
> [01:14:40.882] # cleanup
> [01:14:40.917] User defined signal 1
> [01:48:15.919] Timeout: sending Ctrl+C
> 
> 
> More details:
> 
> https://cirrus-ci.com/task/4629846209855488?logs=test#L8520
> 
> 
> Do you mind having a look at this please?
> 
> There is an issue only when the kernel debug config is used:
> 
>   $ make defconfig debug.config
> 
> 
> You can easily reproduce that with:
> 
>   $ cd <kernel source code>
>   $ echo "run_loop run_selftest_one ./userspace_pm.sh" \
>           > .virtme-exec-run
>   $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
>            --pull always mptcp/mptcp-upstream-virtme-docker:latest \
>            auto-debug
> 
> (or use "manual-debug" and run the selftests manually of course)
> 
> For more details about this docker image:
> 
>   https://github.com/multipath-tcp/mptcp-upstream-virtme-docker
> 
> 
> Cheers,
> Matt

Hi Matthieu,

I am not entirely sure, but the problem seems like it could be related to the consumption
of I/O buffers during the invocation of commands in the script that somehow reaches a 
breaking point in the debug build. As such I have tried to mitigate that with a few 
changes to the script: disabling buffering in printf and sed calls, and also lowered 
the size of the temp file that's exchanged over the MPTCP connections which the script
sets up to run the tests. I'll post a v9 shortly and we'll see how it behaves.

Thanks,
-Kishen.
