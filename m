Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEBA168
	for <mptcp@lists.linux.dev>; Wed, 22 Dec 2021 20:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640204889; x=1671740889;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ay3tFy1HiGSwGaXHKVDsuy4JSmp+EiXY7Lj+B4FmTBk=;
  b=cAo3zesjNsaaY+HwuyxDxc8yvCtJMBzB3L5OvYkPclZ+7I6kC/PshNR2
   sOP7n/huZGejnxHpR6Og40O638s9t2OfNEKVHq/iJG8nXxISfXxoVUyek
   wzK9CcIjRQ1eGTDrKNcHkY+X25rQi9ArQ4TXIKMSFnYY55VXmpdz+jPa/
   +XkmZUlk+LCbcAW9OJotEAxV0cTUn7/G0eV+HtHBVGfA2uJfa86avGnZh
   bxVGpgQJTb2W/DPGtP82PAuo6JoyZmEOi/AOM+3k4nDwmS3NQ32JtWB74
   Q9IwvtnUd7jz555G1EAVfMwy5xuB2DrNHqwDC/i1NmGQyoPeG83zvIvC7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="304072651"
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="304072651"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 12:28:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="508608551"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 22 Dec 2021 12:28:02 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 12:28:00 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 12:28:00 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 22 Dec 2021 12:28:00 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 22 Dec 2021 12:28:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJZi7sPZzjsZRaB95iMDkYgDSYN9M+p7N+hSYrt+B/XIV3NPyAJqH0rFIAHmF2+CJNwQ2kc02jXhuifHZ7XfVAFFwuG3XzY9mpxeXeJCQOJxxdoNXG7dj42g4g3NqFuv62eP/ZFvKqZ8V0sKqvr37wuvIxc+OZRBkTHUYYtLB9l3Lz1xKBRgZXILL79Vy2b48qo5OdBisy7sGMZVygSEtC+zZT3sVoS45l1Ylnu0afhixUAvi2dlKwOMWgqfsUxXzSHxJKX/wu9zrIrM1agDMwUYY/uzkpkNRRuz7ri0b7PalJkdyFGzEugOCzNsFiO99kQ3rknJh1ei3ebs+iy4Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3drhP/5eudUpDzbQ5dUj1yfQVaiQ+lL6oNMIoTvVXPg=;
 b=noFd87T6vY4MB9ch9NikaAyWXWFpPgrTlmjwZX8KnIUK4GzQwWniYhBtgXwuX2cQUKzU14h24JdXb65v+YStHEZbolPXgZS7h8+k0/DVEm85r9taqpIe1QF1bF0H5x1Uxur+7iOqTFPnl1WSIf9UXKmA4Fn1+rbTTlSp93vYYftu4/KIwj+neTtMFucQXlATn7pYxKwPD3gNNljGoAPyvVKYhWDE8b9Kt2L/q8Lc9tl9VxrBFJaKK0W/bJXwKA5+YLEXMwR9hnCQUSXFFxdYaY6AUFxv8KJvQef9s7Stu3h3nI3u0LCHaAdFheZ9uhu4DeKkStAcuHqWyTYTRqKNgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:95::6)
 by CO1PR11MB4881.namprd11.prod.outlook.com (2603:10b6:303:91::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Wed, 22 Dec
 2021 20:27:59 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::c41f:17d7:bed3:7888]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::c41f:17d7:bed3:7888%9]) with mapi id 15.20.4801.023; Wed, 22 Dec 2021
 20:27:58 +0000
Message-ID: <ec2f7644-0f41-705e-e111-992cdf7fb9b5@intel.com>
Date: Wed, 22 Dec 2021 12:27:55 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH mptcp-next 07/21] mptcp: netlink: process IPv6 addrs in
 creating listening sockets
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Matthieu Baerts
	<matthieu.baerts@tessares.net>, <mptcp@lists.linux.dev>
References: <20211216222314.1244708-1-kishen.maloor@intel.com>
 <20211216222314.1244708-8-kishen.maloor@intel.com>
 <e9dd7944-6eb5-b96e-4192-d52c98decffc@tessares.net>
 <c84d9c47-0ef8-4e00-3724-b6e323c0bba4@intel.com>
 <0c44a4f2371ca515edce8ba67f60778f9c990cb9.camel@redhat.com>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <0c44a4f2371ca515edce8ba67f60778f9c990cb9.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:300:117::20) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:95::6)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc08f23b-1427-4b40-1620-08d9c5898b41
X-MS-TrafficTypeDiagnostic: CO1PR11MB4881:EE_
X-Microsoft-Antispam-PRVS: <CO1PR11MB4881FA986A2B67801D5284B4E17D9@CO1PR11MB4881.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sHig8Pu8MtyzKyOw7N1feeBl7nYF/MZXjqT3MxlUe3pJTf2QF8uRUTqG23GJYfJuKV93MU3SWCgUoZSnXfdvWcd02vvvULy9xmF+Oxa3ZjiDQd/IEhdVgqaBy1Da2VlvyR2/zCHNqRmB7CbjKdfa6M64btEnIX9ergM0Azvq38X7V9eFz7O0mrrsB4sJMfwojquL2Plg3Sj6JHlvkKurXDU75XQFbCH5xLf/s+5i6omgsDUxwloI04g24KeN+UHN4wGJdfj5kEe6zX+U4qR90ENMqCJa8z1pgHHCSMkjB8Gsyy9KUkqzqLtdkCr1Szi7gZ3OPNF6K4nuHW4X5jhnxPuyysvoy988aIIDlpfR9++eNZTdPIr+K93SK+cBMrtg7phnYl9c74RZ5ABkT1LGn3bGvnCVXCgd/tOSRBu92u6dU4CFEynV4bf3DKDnsmRZdZmOBZepTp9IEZI0SQ7lVrPYr78gkjtFr9KzNyEmfcgWHjQpW1O0F5g+TW+J9nrI2KAHtN09k2MzGZ+iLqirm8ky5ND7IfxyK5Vmg2pUz8xVfRV8ZClvvnxem9yDYqsgvK55AhHelO4EC6DssmmbFv6bg9l8Qys+CI28G5LmY57+Mwm7DXhD8KUXidB7AEpyt8ObdIMOXZmoSPGxvJp1GeMr98yjsTDIe/K0Ir6VPsGLYOkSInMALoMnyy7kIOJQihb3zXtHiB1TW6ojCAj+K6knhEr+e3xfzn/wd5gwJ3jANjJqgTBEopxyVXxo3zSTGfRENBEQjdExZXIKsTIgbjk2sdNyY1TMXsZFXh46gm7s+egJiHfPPsGAHH/vyxrx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(6486002)(5660300002)(66946007)(8936002)(186003)(8676002)(26005)(44832011)(966005)(4001150100001)(6666004)(6506007)(53546011)(83380400001)(66556008)(66476007)(82960400001)(31696002)(6512007)(38100700002)(110136005)(316002)(36756003)(2616005)(2906002)(31686004)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bERUNndYMUI1MFhIZ1ZDS2xrSEpXQytYUkVTWWNFK2FmQ2tMZG56ZWwvajVS?=
 =?utf-8?B?Sk9acE1FUEVTTTkwS2ZKS29CN0JidzlKYWZSZTlOS0xmN3N1VUtRRG9pY3A0?=
 =?utf-8?B?djZuTUZyTkJlcTZyR3czZldpTzU4b0hQcS84UGNFN1JYS0NpZEh6VGNOdWh4?=
 =?utf-8?B?cndoQ0JMckZUbXY1OURiQVpUcWFPK1p2M2RWck5jc2RpM2VKQUVtSlkwMWhD?=
 =?utf-8?B?anRXU2hoaDFHZVFyVTNyM01hVEhZMkUrNHA3b2gydXRrMXMvNG45bHZmbDds?=
 =?utf-8?B?VktyOUEyVGhLeTUzRlN4QWxlWjduS3llY1I3clhiT3NNZ2phbGRRRnFKcGs5?=
 =?utf-8?B?SS9oMmZadkFvWnU2WFdzVnk5VEhTZzlQUUJYTzYyd245bEdydWMwT1NacDJY?=
 =?utf-8?B?N0FnQW1qTDlEUFF0ZjM1MmZESkYwMUNZeXhjQVBuSGF5WEIvTk54ZkRueFps?=
 =?utf-8?B?ODVRNFBIL1IyeDNJay9VaTV5cE5OeUd1M1kzZ05zc2NHOEJ6SldUbUZra1p4?=
 =?utf-8?B?Rjc4ckJvcWJTVkVJQnZrSVRGTHdBZGlHY25nVWhiRVFzUVZmNGM4VjVyQU02?=
 =?utf-8?B?TG51L3JCQU9sYUxjbGtqQ053Z0VLTm9WbGhvbUxhMUlUandFcG84Rld5QUlo?=
 =?utf-8?B?TVg0bmFJYUpLT3Z6UkNoenE5R1hqZ0YveXkrcmRJaUt2WXZ4dHM2V0R6Y1cr?=
 =?utf-8?B?d0xZUXFEVzlLdUFVRmQvQXFvQkVQNWhJUkhObjl6anZPeW9nRW44QjhXeW9K?=
 =?utf-8?B?L28zVll4UW5oT2t2TG00aTIzSW0wOTNJZERoMG9DVHliQkdVRExoQk9xMEZB?=
 =?utf-8?B?KytpQ3J2U3FpU3RhRjZXOXdidXg0SHp4aXdkM0IvUkNEVlNMdWdrVllUS0c4?=
 =?utf-8?B?YTJCQ2NDSlkveVBQWGx1Nm5Kb24vZ093VzNXeEhUOHBra1FCayt4QW43MG8z?=
 =?utf-8?B?ajVkSzVFWlFvL1NRTW1aQjBsOTZxQTdCejI5TmZadVRrOVRSLzlKQ2hheHdN?=
 =?utf-8?B?WlZFYkt5RDYrK2ltOHNnTzhWWXB5UTh4TCsrS2g0bVNYcTA2U1h2VytTWlRR?=
 =?utf-8?B?SkpNSnFpeHN2b0NoYjBvd3RISU5JeVZCTXE2VEdWL2xJdXpqWkdmYnlPL040?=
 =?utf-8?B?TGE3anlSTHNaS2dWRVZ5WTlLWDlCS1h4OHYySnBnRVZ4em5SODhZbXVZd2Ja?=
 =?utf-8?B?V3Zpczl1VTNyZ0xvU2NxOStOSm1QQnVJa2NzV1Znd0prZkU3TjlZUkFYODJw?=
 =?utf-8?B?VGtXZDFsN1QrclQxTEJJSjRLOU5CenVGdzhGNHNjTndEckhDeDJtSkliMisy?=
 =?utf-8?B?Q0V5elR6REYvOHhXSWZZeEFxSE9qaTdjSFJMbDVLNUxQZXpSNjBhM3ZlRTMw?=
 =?utf-8?B?MDQrWUNESHNYcHlaZnlDRWM1T3ozcUUyYjVKLzRrekRFRnJzK2w3VEdPRzNx?=
 =?utf-8?B?K080Wkc3Ylc5WkxRdWxvMnErMkczUWY3c29zSmt6emNyTyszZkFWS1k5c0g3?=
 =?utf-8?B?ZitlQ29CNW1EY0VKR2RIRS9zNFk2dXJRZFdnMlNkbVgvaE5aOHNSc2pYcWhm?=
 =?utf-8?B?MitOSjdCMjc1aEhIeFlTSWE5c1c1cUh1SThZRHRhTW9Lank1U1R6Ukh0RGpp?=
 =?utf-8?B?UFNPSXAwejRpeGR2OFd6RG1VUkdwQXhaaml4akllSi9qNE5TVi90cjl2WEhn?=
 =?utf-8?B?dGwvUEY0VlRBb3EzZ21pMkVZRnA3TG5VK1o0bXEyNjBKeXNPekdSaVdBZC9M?=
 =?utf-8?B?MjZYMVN2ekFnK1hZdW9weUpJZWg3R2g3aDZyQ3cza3orelpmZ1pyaGlzNFZk?=
 =?utf-8?B?ZklUbEZtNW9lZHh3ZjRlNHBDRkZDUHEzeEdMcERqL1FPUjBLV2p0OXNpQnll?=
 =?utf-8?B?UThKM2ZzQ2Eyc3FxeTJnVmN1Yk14WWxCd3hQS3RJSE0wbDM2cXdRTTJvMEN3?=
 =?utf-8?B?ckJmY0R5dmlDRHpieWpqbVdHZ3Back91NGxwaDBudDFFeHpvUEcyNURtVlFl?=
 =?utf-8?B?RUZmRElIMjJodnF4aGk4WVhmOCt1b2haVzNITFZSVUdXeXFIV3I3T3JybHF5?=
 =?utf-8?B?K0JMUlRPRmlJaXpwVzFpYkNaaHg3dkJHL3FzcXJiS3pHdFVsallFNjQ1UnRq?=
 =?utf-8?B?SHJqUzk4Q0d3by9mOUtGTXBTU2pxdWMxVzRWTlFVU3BFdkticUZ4dlMybDlp?=
 =?utf-8?Q?cDSIeLOlDIoHtJ5Ovm3OWfQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc08f23b-1427-4b40-1620-08d9c5898b41
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 20:27:58.8350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVvo8mRuPNxta+MrW8Yz5qnsWNkDUJVwDonflS6/EepO1dfneNNrOdr1b9xgtWQjB1OQU1Gm/rb+Y4v31mHKbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4881
X-OriginatorOrg: intel.com

On 12/21/21 1:45 AM, Paolo Abeni wrote:
> On Mon, 2021-12-20 at 23:32 -0800, Kishen Maloor wrote:
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
>> -lsks were created only for port-based endpoints which (I believe) would not work with
>> IPv6 (lack of option space), and,
>> -the stack did not allow incoming MP_JOINs at machines running MPTCP client 
>> applications (with this series, subflows can be established from either end so there
>> needs to be an lsk).
> 
> Could you please elaborate more this last point? If the stack does not
> allow the latter, it's definitely a bug. The port-based endpoint
> implementation was aimed [also] at that goal.
> 

Prior to changes here: 

https://lore.kernel.org/mptcp/4cb68f04-5732-e1fe-4b3b-82a418d87f00@intel.com/T/#m637d52ce80f1ff21b20e9de9b877c016fdb4729d

I believe that MPJs received at endpoints running MPTCP client applications would fail to establish a subflow due to logic in mptcp_finish_join().

> Thanks!
> 
> Paolo
> 

