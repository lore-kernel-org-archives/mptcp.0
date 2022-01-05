Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E70E168
	for <mptcp@lists.linux.dev>; Wed,  5 Jan 2022 03:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641353771; x=1672889771;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=e9rjoGEAwQ391IMnOxmCLqbdG0SIgcvRCNtqKdXEifw=;
  b=knGB1WJugPsQHFqNIOceXJZqi03/FM5fod9hmaELLpUj5t3w7mxDA1GV
   zFvDkh433H0PgQVCUoDIz86CnpapUPETRBsns4fS6Tda1Nq9t4IF0FOVH
   TwqkouWBFhf7fPvUrqd4w1r+ZAmQ6kWvRBMWR3EzcYjCgsZQN4UWnTxV1
   H6nkePjiHGlhDOqlLxvOx5vHT0al0Wljp9cAypYSARdJUNhtxweBa7hI0
   yHvpMPZWOz6KAnVf/VjRKk0waaZ9qf+6raeUno2B9xF9lWnPgu8hayNmp
   apPIFYrBFivzCBkhUefkxrEFTYFB/hK8+l+NpwlY/xscarKOG8ADVzSef
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="266632621"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="266632621"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 19:36:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="470384953"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 04 Jan 2022 19:36:10 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 19:36:09 -0800
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 19:36:09 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 4 Jan 2022 19:36:09 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 4 Jan 2022 19:35:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGVfeBYPmk6eIO+hSZ9m3GHSCxB6O5jfH3Cvei2BZDrcsA1qsDFZTIyWoyMOZPQYggJvoaCTN2XDv7Hl7Ijvxif6HHDxxxxtgqXLBOb/59cwxmygol1131+bjDKN1fP37PbDHGg+AItILI+8ZR3WKclIC4C6Sz+9OFprJ0tB2WWJ5RZzMKmad+NPYJwl2wsfVLwuRzgMuGlOzQwswtSElkmPDTDYhWb42b4+slC/2S5OEb54/QGwhpEHyexOPVJDHfoMzP6x86PsEzkV4OFXpjaf+C9x9Z966KjYHVkEA3CEXSpS5nD2R8Hze/nk7x45MeQxPdVe1JEUUlk0kL7nWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qc7mrLQMrZqbO3/RuEHarnOm33kU2Gz29y8LNUpTf64=;
 b=KifFMp0B5IgkZPgyfjS+6+3ateT7qLPYbuTjYFz4bIS5KFWuhMaFxpUVPUFPRxvZN2e+0T0Q2KFHnlP9tbxreQ1mhSlErHVKKCtKaydY6JO3zQJSB6XzvZPDBnvs0ZkqawIFn5kkRrxurLlqWx9/gPRtLWu39reWhEJ5gWVs7WDzHczUCjj8lt+tHY1xjW4SSeS9YcUOSSSp841DAcznoLUc2lQDexswbkza+a5JX5N5q70f+hSgUn4yVqN5WAJh670UDYMaRIph/Pc4gQCQw9xxcJafox9epCx+aBB4N3+XL2SM3TZOzAHj8QvJ+4rweWSG2qHbJig5QRaT+FdQBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:95::6)
 by MW3PR11MB4588.namprd11.prod.outlook.com (2603:10b6:303:54::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Wed, 5 Jan
 2022 03:35:48 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::1c3e:cd78:54b3:2432]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::1c3e:cd78:54b3:2432%5]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 03:35:48 +0000
Message-ID: <acaf0e9c-4cba-68cf-fe6e-5b8f10bf94a3@intel.com>
Date: Tue, 4 Jan 2022 19:35:45 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH mptcp-next 07/21] mptcp: netlink: process IPv6 addrs in
 creating listening sockets
Content-Language: en-US
To: Matthieu Baerts <matthieu.baerts@tessares.net>, <mptcp@lists.linux.dev>
References: <20211216222314.1244708-1-kishen.maloor@intel.com>
 <20211216222314.1244708-8-kishen.maloor@intel.com>
 <e9dd7944-6eb5-b96e-4192-d52c98decffc@tessares.net>
 <c84d9c47-0ef8-4e00-3724-b6e323c0bba4@intel.com>
 <4f968c6b-9004-8b17-6715-824bb95cb740@tessares.net>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <4f968c6b-9004-8b17-6715-824bb95cb740@tessares.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::21) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:95::6)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 857ce13a-2472-4306-8412-08d9cffc76c2
X-MS-TrafficTypeDiagnostic: MW3PR11MB4588:EE_
X-Microsoft-Antispam-PRVS: <MW3PR11MB4588A8A5B9870B4F75F56019E14B9@MW3PR11MB4588.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MBKhALDlejTabQ1QDTMw0+1QPVa4AjW964Pc6WaV72ipgashcK+7KMr8uXULLJ/BcAVia2HYrz7ywPc4W7lVLkTyylc+5Tl4DkBTh+DeqQwjr/Q4Cv9FhWABQNt+lNExS7LcjRvfS0aNaXxYmKSN2yJVX9MioZo+sJM+EYihZvh9f1eWktzfjAo16dtR8sGIWmfWPyg4fO0GenD/9dBaQ257/C9RgUcH5bXTzkZkm06Tce/yZL6H9pNGq7h1qVOOFjjV9eWfIOapJTZKTpm4rID1KA2telLNvd3iIO+yWmFQKHpTkiKH8VKohUdVcqxrT1t+scmmZQIdukLyOO05Y/j7ojFnK1+LUcxqhcj22LrG7jtn28auC7hWrhnG610TBWuLl7A2nsof0qD155MDHbF2JPzAJliAMbnViFHC7g/WfI5cZ+W+P/HG09Tdv4vtekKzhwNvZBEe25YiSBQLMp8HGZzK8EmowlgD6+Ix9rDHJTHA4oAzdtsZkr5FIXIVFCmGdpcDGSicKsZOxrLIO7MumrPqLWLQnOQi/Su9oxNWw3d8tMfTHt5Scrk7uX5uWpZzgAu28twOKE6cM4Ze4Q3zjmcQg7zT3R1VKieWZSXxrNLefRKRx6KyT3khzqGQMofNRD/yYsBnBQdDs2ZY2Hsn4K/Y+MKMfenrzF4H0ks25pyGR88E6q2UJQ6CdlKKsEY+GI8eFKgjJNe4TVT8dqOUqP6uOkHk7Sv4EkuJrk4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(6666004)(186003)(31686004)(38100700002)(6512007)(316002)(86362001)(5660300002)(31696002)(66946007)(66556008)(66476007)(44832011)(2616005)(26005)(508600001)(6486002)(8676002)(6506007)(36756003)(8936002)(53546011)(83380400001)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3hIbStFMjVOK1RTRlhYSVViWit0REdvdjVUd0Z5WTBQL2xFR2ZKcm1kYWsr?=
 =?utf-8?B?OUk1bkJSeGtCYmRBQ3QrdHlqSCs3UzhUdTJaOEhaS1VHSTNicS9nWm5lUnRq?=
 =?utf-8?B?b0c3eUJmNUtQRGxvbFBLWTBsWEs5VDN5a2crQkloR285djFja2RuU2t5VWJa?=
 =?utf-8?B?RUNBVEs4SXBOS0VYVE8yQldDNEw4a1ZBK1YxbDUvUjMyY0hFUk1jVXpBMHZR?=
 =?utf-8?B?SERZTDRETWVLalFOM24xd2Zhenh4WDQ5UnFJRGVhTkV6SnRZWTZ1aWlpbzFP?=
 =?utf-8?B?QmtQRnR4TUJnSy9McjNLekdld0ZuVzlRYTVnUzBXQXpsajVDK0ZFMDYzNzgr?=
 =?utf-8?B?MFRvZnpCbFFPVGhsN2tWdkdVM0ErQms2VWdYSytYL0FIWUdtOFVYd0NRam1q?=
 =?utf-8?B?Wis5dXRYQnRsUU5lVEJjOFVKYlNvVFNpSndwTUk4cW1ic1c0aEx0d3pLaTFk?=
 =?utf-8?B?NWFtOGVqTVY5NWNiZjl0NkRkMVFmVURmNjVUaSt3ZGJCYlhOWTBqT1g5NnVD?=
 =?utf-8?B?TVpMaWkra1lES2JTZ2Y2ZDl2NW5kS1VmMFFVSHQ2RGF4T28zMmprMW9uSXdn?=
 =?utf-8?B?RGcvamk1Wjk1aXBnTG5SaHBrbW4wTFZ5V1lWdFlOdnZUYkhTRHcvdk9UUHl3?=
 =?utf-8?B?dEcyMTZIZU9tRUpuMkdaUS9wTmg3MUZFbEEvbDQ5V3NRWnBMNWo4ajUvRk1I?=
 =?utf-8?B?V2hObmRCOGU0cnhyb1hvcUNkVWFyMXV4bENMUG95bFZPajR4czBjeUg1VHNQ?=
 =?utf-8?B?UFAwcW5TclFjQ3c2TWdSSzBuMU9iY0VJZStkMjZIampaVU9mUWtOaEZDZFJK?=
 =?utf-8?B?aVBzS28rVWN6Q28xZXg4QVVWa0dQWjhOeWlmcUVPRHFGNDdycWxtR3gvczFB?=
 =?utf-8?B?ZUNSay9XRjEvcjdHclVsZ1ppaUZoWkVHTDFXc0dtSzkzeVo1aExvRXhlT1dB?=
 =?utf-8?B?YWpuNE9SSndMZ1lNRmVYVFRiVkFoUVNyZDZOV2pIWHM1MW1kLy9iSm1HWHo2?=
 =?utf-8?B?Y3MxelJTSGp0Sy9JWHlUSDBKYmJhZzFKRzY1Vjg3WURoQnhpaVFhZkQrMU5w?=
 =?utf-8?B?Snl2MHp2L0p1V2h0YUlXNkJKcmdZMGtrTEszVGg1THptZ1pOY0RGZzZTeVEr?=
 =?utf-8?B?VzdYVFlwMUtlOWNndVNsak44K1JzcmRjeXZnUnE0R214NnRERlZyUmR6SlRS?=
 =?utf-8?B?MEZndUlkcXE1d3pkSTFMOFR0d1BUbVhYODlEeGNRUWxHMER0OWpQNVYrbkhG?=
 =?utf-8?B?ZXF3WC93R3E4THpuZDBIanFhNEN3YWRPSStRWXFtalFrYVp3UWtxbGpyZzdv?=
 =?utf-8?B?d1cvSmhtZ2EvWWlWYUNqWkpoemErY001cWxOaXBBalFTSnNuTXM3Zk1MYnNB?=
 =?utf-8?B?TTF2S0dkcjFvd0dLQTVnN2Npc1AwU0V6UDFMZnFJU1IrQmpVMVZFRlNFYUVm?=
 =?utf-8?B?YWJsSnFuc2JiYTk0ejB6Qmx6THNFN3JjV0F1VzdnN0RZZHdvdm1ZSnhXSWx5?=
 =?utf-8?B?YnE0UE9pSDBmMXdPZFY2KzI3cUFrdS80SVBzNXdTRWVOZm8rOHRZL3BPWDdo?=
 =?utf-8?B?VWVsOFE4VXlORSs3ajhldE1oSGN3dWdlWHJqZ2hJa2pHS3RtWW45VDBZaE1O?=
 =?utf-8?B?RTRzVjMyTW5EQit6NEJWSExwTSs4SmwrV0dFM3dDRVJ3SUdPV2Y5M1BJUk4r?=
 =?utf-8?B?OTN0VjJVR1dNMCs0SkVybStWNEF4bGJyWmVmdXc1b0ZlZFM0eFpwYWpQSVlQ?=
 =?utf-8?B?bEh4a2NRYUJNWmFVL24rdEVyL2U3QXJxRTlmWlNJYXVOZFBCM1pScUhBK1FL?=
 =?utf-8?B?QURqdGR1U28xd1k0YjVremFCNUR2dEs4Zm5RRlNURGhaR29taEt0T1kxZFBa?=
 =?utf-8?B?ZDEwenR1aktTWnE2Ynk5VWl3Z0I3b05SQm8yd2dWRWVSMTlDTk5PejFSVmUx?=
 =?utf-8?B?M1J0dkVTaEsvQ0N5N2RiZFl3K0dISkNDQlRQQmVlODZZcDFXYlpjd1d2TzE3?=
 =?utf-8?B?WnM1cEM1TGRGNDhjM0JEVXBvQVlEUUgzaTlVTnloaW56L0ZMUkIzdFI2MXNW?=
 =?utf-8?B?b29TaXpxdFBNaE9Dc1pSNVJ6TGZkbkV3Kys3NUxGNFhaT3RTditTNHgrVkI1?=
 =?utf-8?B?RnJFdEp1YzVJZ3E1OTZIRDhQUzgwMlBBOWlkUXNqTnlQL0VFSjJORVp5Q3ZS?=
 =?utf-8?Q?BvK9MB8WqF84ApX+zlvmJE8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 857ce13a-2472-4306-8412-08d9cffc76c2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 03:35:48.2677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5Fi/DCQ4VGiTmOHc9Chlnk/OA+hfHjsf1N2Vbi3nvnM9YJVGvavLRjbIP6MQWprztMkpSH0ntmbcsE58hCDCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4588
X-OriginatorOrg: intel.com

On 12/29/21 5:52 AM, Matthieu Baerts wrote:
> Hi Kishen,
> 
> Thank you for your replies!
> 
> On 21/12/2021 08:32, Kishen Maloor wrote:
>> On 12/17/21 8:29 AM, Matthieu Baerts wrote:
>>> Hi Kishen,
>>>
>>> On 16/12/2021 23:23, Kishen Maloor wrote:
>>>> This change updates mptcp_pm_nl_create_listen_socket() to create
>>>> listening sockets bound to IPv6 addresses (where IPv6 is supported).
>>>
>>> Should we consider this as a bug?
>>
>> We could I suppose, at least for lack of completeness. But you're right that we've
>> now updated the behavior in this series in attempting to create listening sockets (lsks)
>> corresponding to every announcement, which necessitates this handling of
>> IPv6 addresses. 
>>
>> But prior to this series: 
>> -lsk creation (through a subflow's port) did not happen in the kernel under the assumption
>> that MPTCP server applications would've established a listener,
>> -lsks were created only for port-based endpoints
> 
> Yes, that's correct.
> 
>> which (I believe) would not work with
>> IPv6 (lack of option space), and,
> 
> Yes, there is enough space. We even have packetdrill tests, no?
> ADD_ADDR are sent in a dedicated ACK packet, without DSS. I think we
> started to discuss about having a dedicated ACK packet to cover this
> case and ADD_ADDRv6 + echo I think.

Based on what I briefly observed, it seemed like there wasn't sufficient option space to 
advertise a port in an ADD_ADDRv6 message (even in a dedicated ACK, I believe). So, I 
concluded that the port had to always be reused. Anyhow, if there is indeed sufficient
room for a port, then yes, we could consider this commit as a bug fix.

> 
>> -the stack did not allow incoming MP_JOINs at machines running MPTCP client 
>> applications (with this series, subflows can be established from either end so there
>> needs to be an lsk).
> 
> If I'm not mistaken, that was by design: to simplify things.
> 
> It is very rare and very specific when a server initiates connections. I
> think in most cases, the client would like to be in charge of initiating
> paths and would not like the server to do so.

I've been considering path management as a separate function (architecturally) from the role(s) of
the MPTCP application(s). So, in my mind it is not the client/server applications initiating new subflows, but is rather
the PM (in concert with the MPTCP stack).

So may be the requirements for and scope of path management policy needs to be discussed then (?) (if it hasn't 
already happened) which could be realized by userspace PM daemons.

> But as it seems not to be too complex, it is good to have a way to do
> that. But I think we would need an option to (dis)allow that.
> 
> Cheers,
> Matt

