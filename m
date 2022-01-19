Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9328F2C80
	for <mptcp@lists.linux.dev>; Wed, 19 Jan 2022 17:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642615188; x=1674151188;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lkVTe8y6gD1c9mimqiw39krDgt85QSjo+DwZGDmRVk4=;
  b=kmgE6vhqLr7M/fUkDo4y2+CfOmRRP2qmBuAsCzQzX4EnkmdMAM51dsaj
   f64r+vgHOPuMTeROx+kn83HSunhAQa4B7gOQ1LzUDOuxOuA1mmPVPYcXg
   ArmxoOsXnVKdusBfTD3RaNA4iLtQtZ9ZcgKgEwjgc7lUh12YV8vtjz7Ln
   DSlAmoDSjY0ueK54PIC4Z3USMfVB1PZy0QfHDhI+t3TiDvm+HNyOPXFBe
   0Dh6nC6YQFFW4A2spS3c8ImJiFglG6uQnroOv7tTMqzoqMhTkUGvish/W
   PpNJtw9ZaHqHnWnYkVk02wvb5qUYzf4vpZmE1A5dPhuMTIxLUx++rrJuG
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="308469419"
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="308469419"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 09:59:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,300,1635231600"; 
   d="scan'208";a="615781332"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jan 2022 09:59:45 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 09:59:44 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 19 Jan 2022 09:59:44 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 19 Jan 2022 09:59:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJtvU5iznAMSy6lWv9ptI9jVpRN12H6546G45OLtaiWY4/xp+5qXUJuRaoUbpUvaXFSbIiBlxHJGT1PyS9V5bj/Hi4qebtC6WCRHDjDYAAyeJJQ/L+dsLhM7MFnPtInJp5HSqEmfrreSBq3cTDjVcAzG9zDRN3KDO+g1AI+lAnQv127kjDkDnC637ZykZhsbqmyx9/wDkZbnNLzlExed4rZhXi9mMd3n/0dmXgI2FNkyNN3D/vNKAgRzOenhCKg148jGiVhqv/ASKLdNb6jjQLoC0/Ls1hlPfk5Y7Llq3OTr1CiYWIpS/ri8qnilFY/ZKxg7cf28SzkGoTbDMmHE1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsGXxqwYRKwg2nSJomeQ6BL2nOF7gB4TWiD5+hym73U=;
 b=BagZvto4yhDYT2ioM0QuD5RkPNV7JONteDQ7jMlGWPOJH4vyB38WgmwcPR3zGE61Irfk5OHZWO2slCzEhkODvPhMNODwsUZOR7mgUx3uLVR/v04aU3/YjRuv6PsyGHdSx8tj1Nj7ftF/jO7yvnGAi3qNKc636oCU+Q12KncMsARrPigxz/b3q83iMgYAExQt9aj6P/jBsknLb4OmcjYkmbpytMzMzEI0SCiZnAhhFbGjVpU8XSGtlLrU7czKIBXGB+CEmb8MFQ2saYxKP/G1jQL0oVoh5tLCN2P/9xpRAxoNdYli+tu0rqxOZ1dG1CSrkAAqf55/k2gr+q/zmu77CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5145.namprd11.prod.outlook.com (2603:10b6:806:113::6)
 by BY5PR11MB4193.namprd11.prod.outlook.com (2603:10b6:a03:1c8::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 17:59:43 +0000
Received: from SA2PR11MB5145.namprd11.prod.outlook.com
 ([fe80::992:6137:3ea3:6cfd]) by SA2PR11MB5145.namprd11.prod.outlook.com
 ([fe80::992:6137:3ea3:6cfd%4]) with mapi id 15.20.4909.007; Wed, 19 Jan 2022
 17:59:43 +0000
Message-ID: <d6eb3faa-0838-58c9-8203-a7531d9cd620@intel.com>
Date: Wed, 19 Jan 2022 09:59:40 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH mptcp-next v2 04/21] mptcp: establish subflows from either
 end of connection
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Mat Martineau
	<mathew.j.martineau@linux.intel.com>
CC: <mptcp@lists.linux.dev>
References: <20220112221523.1829397-1-kishen.maloor@intel.com>
 <20220112221523.1829397-5-kishen.maloor@intel.com>
 <83f91e9b-9c20-6e83-6442-41b87139f4eb@linux.intel.com>
 <eb4affeebe3b03948a2252b0d6af852751c0ac1f.camel@redhat.com>
 <d3b555e1-752a-e125-1654-3d8cbdd20e4a@intel.com>
 <f161df56e10f36dc27403586793c367b29eb7066.camel@redhat.com>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <f161df56e10f36dc27403586793c367b29eb7066.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR06CA0062.namprd06.prod.outlook.com
 (2603:10b6:104:3::20) To SA2PR11MB5145.namprd11.prod.outlook.com
 (2603:10b6:806:113::6)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f483bc63-5d06-44b6-eadf-08d9db757896
X-MS-TrafficTypeDiagnostic: BY5PR11MB4193:EE_
X-Microsoft-Antispam-PRVS: <BY5PR11MB4193F8DEEF455AC3DF798213E1599@BY5PR11MB4193.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 60Tj2Bo8jFjwq/T9zD9Zvc0tcHlhVuhZ6/W+vxD1EnMuEenbd1fZ9TNrResrMv1fQMX6GjPWjW+jMEXMqcbf9BsEjg11/Lx2MUXiF0A8IGZPGuT3JNJzIVV80SJTES08z9mp7koRvPkx6PKqR3Itry7qN5qsPR/1bmaHneOHNvASk6TIigJ+RZgcwrLXaf/V6Br5MzCVxESyOb7tdC9UOq2AIfUXvQrV9RQIz4wi2m+XoI4KnQZaOzZtp00Xx+d2Bw8rIzAhUcglVV4UD3TNSihhQUiz+NL2rbkYwXYFYkmVHY+aFQJWHJtz3JUY+6341aDsmjIU4qOy0s/IvI/FtYkIM9lGxXJq6OU3z1PY60CuElA4oNI+/o+8F8kD63p5HCxf2zhqSQPHqDhU+q54JKy2f76Xcp2rCUn7nwXI6MNrz+N5+7uZOn5yNLntMCXFIs6SJRdkpis9UWgLJSHNkGNqLg4V/D5jCm5diHG5fEbMr/S71raY6vB2zrIOBDaokzOOzYZe2QYZA3Hic+8egxgcq/CXOmPkaFf4hmF1J+u3YlbgofF63th6G6/EYiw11AkDtQ+kOtdL+JHOSP4Q4cssnohPU0G5hovNk1MfxnPH7R/BUNU4yqYlhnD+fVsfOFK2i10BhNFjGfx6qxw2el9gVn49SibbmLAEn+4YaA3PA0hr6QI5IMN9PlQORIRCq6Rpi4gC2s/8lDLGzeLUibW89dXOZP7lu8Gw65Ms2gunNQdMjat6OrhOABetuppu3HDq8M9i08VV6C7zsp8Q7PnFqVvt4qAZgpoXlb8+/c+BGvILyqrehzd4b3xJImfz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5145.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(966005)(6506007)(86362001)(508600001)(26005)(83380400001)(53546011)(186003)(6486002)(66556008)(66946007)(66476007)(5660300002)(31696002)(31686004)(110136005)(38100700002)(4326008)(2906002)(8936002)(44832011)(82960400001)(8676002)(6512007)(2616005)(316002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHY3NDErSndBUGluRlYraWNlZFBNQkQzNHdDVW9KUU1pQ2YxMWRvRy9HbVV5?=
 =?utf-8?B?R01kRS9xZ2RPSDZQV1QzT0pjdkN4UlZQZW0wbkNSU3JuWUI4V1c0RG1RYllV?=
 =?utf-8?B?ZVpyd29KT05UdUExWDBSY3hBYVRkT0had0ZXSVNMWGE0dlI3WjhxMDMvR2xX?=
 =?utf-8?B?ZTNjVmoxL2J5NU9UbElQTXF0YlNQd3p3SGpOdWhlWEphbllBRTRPd1RLRk9r?=
 =?utf-8?B?em5Eb1RnWXRoVzAvMzdlSDNTdXNrWlBrUXhRc1V3UlRSeUp4OUV1Nm00T1BD?=
 =?utf-8?B?NllzdHJBOXlLcTY5OE80YTFVZExmUWw1N2VjSXo4K0RPUTFVa3NGNStleXNk?=
 =?utf-8?B?QlBQeWt3SUhESW00REFnc1dJRGpRVnErYWZ0RnpsL1NmSGJVTnovQXJBc1BP?=
 =?utf-8?B?Sm1BZU1vcTM3L1QvV1k0dXF0UVpSRkNjMVJyUTR3MVBzbkpKR3dVTk9vaDBN?=
 =?utf-8?B?SWJEY3NXU3l0VmkzK1J6Tm5pVHlnV2VUaVJZOHJ6ekg4aU1IM0Mzb21YZWgy?=
 =?utf-8?B?eFNKbVpqMEs4VFhtZWRrdnpORG0zcEE5eW5rSkloSHFUS09odmNqdHUzQUZJ?=
 =?utf-8?B?V2ozNUN6RG1yMUYwL1pnanowNTkzMUVpTDFYK0s3RmNMT1lCbFAvTVlNQUYv?=
 =?utf-8?B?MUl2a3RWVDF5T0wxY0JQejZSNCs5ak1GRmR2L0YwUXhRZWpDdkhUREpDc2gz?=
 =?utf-8?B?SFBUNVcrcFJuRlprdWRYWkRKZkFwR3F4S1RkTnd2emxXcWdrNnFxVmZjcnVB?=
 =?utf-8?B?WFJzbW9RR1FpaGVsbWZuRmJVb3dEcjZVNXJPZUJ2ZWJVd3FydlY3MVdZT0xI?=
 =?utf-8?B?UndzU3luRGtibVpDOXhrZ29vV28wbVZHVmt3Q2dDSzJYbkVZVHlVQWM3cWNM?=
 =?utf-8?B?dlZLWDVGRUNVTlRiV1VueXp2RUdWV3lHdmFaM2tUWTY3NGtNczJ2Ti9jMW00?=
 =?utf-8?B?TlJJTXJqSG15b3NpOFJmdEtPODJPTDBNSVJsbGV4b3loVGZKRmpaajgzM0U4?=
 =?utf-8?B?NEpNZ2tMLzlwWXNhL3VGZWcvT1ZGUnlleW56YVduc0xhZHFyQnB5dDBCL1dn?=
 =?utf-8?B?anMwVTFQT2hGSWU3aG1adldGV0U3cWdrNG80cG44c1lxaUlVeW1sVDdDRWtx?=
 =?utf-8?B?QlRnK3pac0R6dWlzZGhxaUt2NVAzd2JpcTYvUEFGcGFYME0xb2ZpUk8vb3N6?=
 =?utf-8?B?UFRocDNKcS9ZK0RWYUhFOWUxM0t4azRKMEk3TU8zT2NFS043OG9vaTJNZkk4?=
 =?utf-8?B?WEw3clcrNm1UUDRSWE56WDFqZ0NCM3gxYWloWlFaWWJBVEZINnZkQVVVSHBl?=
 =?utf-8?B?Q2VmUHVxTUZaWU1VOHNUWDV4clVaSHNhMklIMllXZFVaTTU4NUJ4NTdGRHZu?=
 =?utf-8?B?TFljTDFtaFZ0ejMyR0x3QWlIVUlrWXlzb3d0QjFlMTB1UHNWYnc3bzJycnlu?=
 =?utf-8?B?bXBwTG1XQU5oZzBCdS9DVkZ2VGRWNkIzcS8wa0loY0IxQWVRN1FPak9XN0pm?=
 =?utf-8?B?MlZYeHE3ZDJTajVHNFhCSkpxdWpTQ01FbUs0ZTdWYWNmU1A5YmQ5RzBOQytO?=
 =?utf-8?B?a0Q1MDZKdmlsMVQ3K0E2Z2pBVFF3K1NEOHppd1lwZ0hidlcyc3A2bEVXQXhQ?=
 =?utf-8?B?ZUdqUjRkb3djQ3l5SDZWWWZKQmo3eVFXeG13dkM2K3M1NmJ6VzRGbFR1eC8x?=
 =?utf-8?B?ZStWajJrdUtJS2ZpaGIrSERJektUQWRxVnA0cWFKK0padlBBZWc2Z2hJazJ0?=
 =?utf-8?B?L283ZEU4aXRiR0o2bmgvV1BGSWxYMkVnTDg3OHlObFM2RFZpS2VMRVh2c2dZ?=
 =?utf-8?B?UFp4ZTJhMEN1dW1tRDloT3VZYnRPK1ZGek5FaFFaUUFXaFJCUFZrbkRWV0ts?=
 =?utf-8?B?Q3pPL01aVGhPRmU4eXk0aHo3TFFoYlpSOXFCSmpWRnBaUkUzZ3hKNkRQQVg1?=
 =?utf-8?B?eTEybXdwNDZ3ZDVIU1pRU1k2M0hOeWZIb3REOWUrNlRXUXdKNnR2eGMxSnAx?=
 =?utf-8?B?VlFsZHdXQXJPY0tKT1dRN1krbUEyOXlHQUxLVTlBYjlhR3lidGlmZWcwSHF2?=
 =?utf-8?B?ZjhaU0lzdC9OYU4zelZJU3RDZGMxU2VmbGhsZHRNWENnMlJEMklBT1RtZGRw?=
 =?utf-8?B?ZGZUZVRWcmZJM1FoNkIvbWMyK1UvS2lGaUpJNHJhV2R5Vjl3MmxlZ2h5S0hN?=
 =?utf-8?Q?A4UsaI1c8y7Lw8yIC3YDwPc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f483bc63-5d06-44b6-eadf-08d9db757896
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5145.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 17:59:43.2635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUFNwBMLQZkcQXsCZhjm1L4AEiG/dptN2G8dfDTYPQG9x7/rCB4S5LEJU2ykcikS8XlNEpxcPYLEl5+rB/+14A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4193
X-OriginatorOrg: intel.com

On 1/19/22 4:01 AM, Paolo Abeni wrote:
> On Tue, 2022-01-18 at 17:26 -0800, Kishen Maloor wrote:
>> On 1/17/22 12:59 AM, Paolo Abeni wrote:
>>> On Fri, 2022-01-14 at 14:43 -0800, Mat Martineau wrote:
>>>> On Wed, 12 Jan 2022, Kishen Maloor wrote:
>>>>
>>>>> This change updates internal logic to permit subflows to be
>>>>> established from either the client or server ends of MPTCP
>>>>> connections. This symmetry and added flexibility may be
>>>>> harnessed by PM implementations running on either end in
>>>>> creating new subflows.
>>>>>
>>>>> The essence of this change lies in not relying on the
>>>>> "server_side" flag (which continues to be available if needed).
>>>>>
>>>>
>>>> After this patch, server_side is unused except for some debug output. If 
>>>> it's really no longer referenced (see below first), may be better to just 
>>>> remove it.
>>
>> I think we'll need it. 
>>
>> One possible use is to inform the PM daemon of the type of application 
>> (client/server) associated with a connection.
>>
>> As we're discussing the idea of creating listening sockets only upon request, the 
>> knowledge that we are on the client end of a connection is something a PM daemon could
>> use to request creation of listening sockets whenever it advertises an address.
>>
>>>>
>>>>> v2: check for 3rd ACK retransmission only on passive side
>>>>> of the MPJ handshake
>>>>>
>>>>> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
>>>>> ---
>>>>> net/mptcp/options.c  | 2 +-
>>>>> net/mptcp/protocol.c | 5 +----
>>>>> net/mptcp/protocol.h | 2 --
>>>>> 3 files changed, 2 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>>>> index cceba8c7806d..89808816db06 100644
>>>>> --- a/net/mptcp/options.c
>>>>> +++ b/net/mptcp/options.c
>>>>> @@ -921,7 +921,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
>>>>> 		if (TCP_SKB_CB(skb)->seq == subflow->ssn_offset + 1 &&
>>>>> 		    TCP_SKB_CB(skb)->end_seq == TCP_SKB_CB(skb)->seq &&
>>>>> 		    subflow->mp_join && (mp_opt->suboptions & OPTIONS_MPTCP_MPJ) &&
>>>>> -		    READ_ONCE(msk->pm.server_side))
>>>>> +		    !subflow->request_join)
>>>>> 			tcp_send_ack(ssk);
>>>>> 		goto fully_established;
>>>>> 	}
>>>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>>>> index 4012f844eec1..408a05bff633 100644
>>>>> --- a/net/mptcp/protocol.c
>>>>> +++ b/net/mptcp/protocol.c
>>>>> @@ -3248,15 +3248,12 @@ bool mptcp_finish_join(struct sock *ssk)
>>>>> 		return false;
>>>>> 	}
>>>>>
>>>>> -	if (!msk->pm.server_side)
>>>>> +	if (!list_empty(&subflow->node))
>>>>> 		goto out;
>>>>>
>>>>> 	if (!mptcp_pm_allow_new_subflow(msk))
>>>>> 		goto err_prohibited;
>>>>>
>>>>> -	if (WARN_ON_ONCE(!list_empty(&subflow->node)))
>>>>> -		goto err_prohibited;
>>>>> -
>>>>> 	/* active connections are already on conn_list.
>>>>> 	 * If we can't acquire msk socket lock here, let the release callback
>>>>> 	 * handle it
>>>>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>>>>> index e2a67d3469f6..c50247673c7e 100644
>>>>> --- a/net/mptcp/protocol.h
>>>>> +++ b/net/mptcp/protocol.h
>>>>> @@ -908,10 +908,8 @@ static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
>>>>> static inline bool subflow_simultaneous_connect(struct sock *sk)
>>>>> {
>>>>> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
>>>>> -	struct sock *parent = subflow->conn;
>>>>>
>>>>> 	return sk->sk_state == TCP_ESTABLISHED &&
>>>>> -	       !mptcp_sk(parent)->pm.server_side &&
>>>>> 	       !subflow->conn_finished;
>>>>> }
>>>>
>>>> Are changes in this function needed? This code was added to address
>>>> https://github.com/multipath-tcp/mptcp_net-next/issues/35
>>>> which was a weird case encountered with syzkaller where a socket tried to 
>>>> connect to itself, triggering the "simultaneous open" code path. It 
>>>> doesn't seem to be applicable to MP_JOINs.
>>>
>>> I *think* we can reach here even with MPJ, e.g. if we have port-based
>>> endpoint matching the src address/port - possibly syzkaller could be
>>> able to reach such scenario.
>>>
>>> Additionally I fear dropping the '!mptcp_sk(parent)->pm.server_side &&'
>>> check could re-introduce the initial issue, at least for the MPC
>>> handshake.
>>
>> The purpose of this commit is to permit the MPJ sequence to happen at either end of 
>> the connection. The change in mptcp_finish_join() had the most direct impact for enabling 
>> this, so I looked at other server_side checks mostly in terms of establishing that
>> bi-directional symmetry.
>>
>> If the above condition holds only with MPCs, i.e. for the initial connection, then I think it would 
>> be fine to preserve the server_side check. But if it also holds for MPJs, then we might
>> have to account for both cases. Perhaps replace:
>>
>> !mptcp_sk(parent)->pm.server_side)
>>
>> with something like this?
>>
>> ((subflow->request_mptcp && !mptcp_sk(parent)->pm.server_side) ||
>> 	subflow->request_join)
> 
> It looks like 'request_mptcp' is 0 on passive sockets, so:
> 
>  	subflow->request_mptcp || subflow->request_join
> 
> should suffice.

That's right. Makes sense.

> 
> Possibly factoring out an helper for the above condition would make the
> code more readable.

Thanks! Will do so.

> 
> /P
> 

