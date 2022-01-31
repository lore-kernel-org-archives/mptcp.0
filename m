Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482E52C82
	for <mptcp@lists.linux.dev>; Mon, 31 Jan 2022 22:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643667857; x=1675203857;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=90+/wRe7BeFzOGiEMxXWB0f1I0jns8BryukeUhmPVuE=;
  b=eVKHoL7NomUNynVAm8b2BNxsdQyk6AN8olX4l9hCtX+itc34M56Q7ja+
   V39esM8STdM3lzekOBq0wOlhUrsmP8Kgsw9bE6kSl9rmFQCrd0lz5WM74
   vY2V9Cm5zI0880f4fV4bU4mvjkbd3apKGfwtLEGk7yBXmpWUUVcX2eUDH
   i9vX/ycDa19gpxlZlGkuNhI1MR8CZB8mP3gNkm+1A54qnu/vWB5W2lut9
   LTAZDO/ZReth3m0ysUQxIf5xnFLXNePxqTMNj+GAO2ek92i7WdD9TfQ2M
   3ahYK+BbvpsLhe2hPR+uOkuxz9daOwu1ienRn7PEXTA6J4BMT2M4MHuWL
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="231134000"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="231134000"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 14:24:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="675879821"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga001.fm.intel.com with ESMTP; 31 Jan 2022 14:24:16 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 31 Jan 2022 14:24:15 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 31 Jan 2022 14:24:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 31 Jan 2022 14:24:15 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 31 Jan 2022 14:24:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwd4dEkDjF4Ew+dBa81D2WTPQJoNjFkHdt1TCZQBLnQOPmF43A2FynY1kyAKPbrl9+/BSCFd7aFylBJ5+iLPs283lnWahocbz/YaVBaf7QN+LbhFg7QeMArApSCUejjxn7hlBigrnhwGOY6l011oi/enoZu/6A2Y9OKXZjV2IUsj32lDKuNzhPeAU6/Ir2uGMNqVkJEu+Kt/wPvdj/jxndNxvIAc8gs+JnwP9HroOmS5hQAU9Fjb8X/tUseh8Z3ypjVb4W0byTL0/N8qqLWMDRFtoK38Iotyfn+pMZ3J9z5EeYfPivKyQOQeA8d8gBSz+hgcCH1YuW0OfW+gl/0+UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjGSaW3iQxelFcyShpL3wqSYLhawBrs1zvwXXUgopt0=;
 b=a3nGCkzhjxEjiJj18kaHIzMDUKvqrItZHrxSL9gkdEKMCficPtatAy0PNqPHhIL2Mk31I3amXjWG+bVGvP00SV5g/eL7LLX8OcLCROtLnPx7QjGScUlBnn17b6MOlNL+ZB90J5hxhtr1CERJlDvodub23YfQo/n2tdYLHa/IPPPTuDGmnnT+Ap0DPYrzdL7N+k/cRwEuP91Dt1bxFkMQqlFbSY17oP8AVix8mnsN3Vkfatoq0STM+Xc2Xfrx1rM+zwSXo3S+JLK0Ozw7FLwMGeQZM695y7BT9lvL93CejUQg9US89dcG/DER77LhfhPFiLdhjqCKAf8S8XSaZWTTuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5145.namprd11.prod.outlook.com (2603:10b6:806:113::6)
 by SA2PR11MB5147.namprd11.prod.outlook.com (2603:10b6:806:118::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 31 Jan
 2022 22:24:13 +0000
Received: from SA2PR11MB5145.namprd11.prod.outlook.com
 ([fe80::992:6137:3ea3:6cfd]) by SA2PR11MB5145.namprd11.prod.outlook.com
 ([fe80::992:6137:3ea3:6cfd%4]) with mapi id 15.20.4909.019; Mon, 31 Jan 2022
 22:24:13 +0000
Message-ID: <fe9ebc02-c00d-bcb6-4f6e-670a3a0c75b1@intel.com>
Date: Mon, 31 Jan 2022 14:24:10 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-next v3 14/14] selftests: mptcp: functional tests
 for the userspace PM type
Content-Language: en-US
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, Geliang Tang
	<geliangtang@gmail.com>
CC: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20220128003836.2732694-1-kishen.maloor@intel.com>
 <20220128003836.2732694-15-kishen.maloor@intel.com>
 <CA+WQbwvJOa3iJ8BucsMUPho-=eBQziemvneM_Ld82gOC0f4Zwg@mail.gmail.com>
 <92547a-438c-d7fb-93b1-2b54ab745134@linux.intel.com>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <92547a-438c-d7fb-93b1-2b54ab745134@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR12CA0066.namprd12.prod.outlook.com
 (2603:10b6:300:103::28) To SA2PR11MB5145.namprd11.prod.outlook.com
 (2603:10b6:806:113::6)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1a28446-81ff-4e5a-baea-08d9e5086905
X-MS-TrafficTypeDiagnostic: SA2PR11MB5147:EE_
X-Microsoft-Antispam-PRVS: <SA2PR11MB51477FDC927F1AF0135F3FBCE1259@SA2PR11MB5147.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nZQ/XPayBk5NML1iE0IZOg1OP2JCH6f5JHIwmeFWbvXJRvubIgH1Wx/NgLmwvKX8Ss8zN8tzHP3l7qkTOK4p7vUIWERha2ACx6Vp3pG9sVMxuzVF3zXTrJwVCKgedi5w9vqTqkOF7vWZ193IFeqU6WRrVqRIBCXQv6IeaMNbkcxhsqC4YcQrnG6cDUBn+i9VXUxPexBUbFU0qt96p8s0vcLG86SLA0GWufj/fBCTcrBw1AP+e/3W9vTjVUPmO52iGTYPBw5curtiHpXq9usxkI5aFUO8wW9Ef0FH1+ooNcqNyDb/NEo1CG36Pkb9Q+O49NDPNoPWslTcE0oCWRhzkgkmDWcoPVYcB6j0vRc67B+1QjXoGKf4lAVKlqU8tSJRGysvmjWA+lCQVBCHnclxnnYt2NK2RgZHa+TM4SEX4PCNBhnZife6pF88nepHVxFdX47LR6WLnXEYFPIzHhiIi1MvG+HwsUepEr9jNLK5EcMRfLhkxqNn6B18LAN+CQDcDl5Uj2b5wZ++XaOSzkztR8Se+yxlZBVrfuTZx63BdUTojam2Lg7eYIs5uLqTo/JfkZqez2SsLwkkEhOR7wNal/zGu1hQyCAS3ual2sKH82Jmeqv+Pam/ENJola3Mf7uhn0wxYP8nj1Qf3GeMolUeUjWqRoG76yTIfYo7rYD/XtBkdsAIG10bIVgOEWReOerILbfBH6DI3HMOLrBbzVqXgZJrFW00+38lW1F+VQAcA70=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5145.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(2906002)(31696002)(83380400001)(38100700002)(26005)(2616005)(4326008)(36756003)(8936002)(66556008)(82960400001)(110136005)(66476007)(66946007)(31686004)(316002)(53546011)(6506007)(186003)(30864003)(6486002)(508600001)(5660300002)(44832011)(86362001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0xHazd6a1liazR3RnN5SU9Ic3dQSUcyZ0JpSVFnSWp2NkJRQ2VDRDIxTyt4?=
 =?utf-8?B?U1M3Z0tTS05tcnJtTGtGQndkYTNHWVJFK3hVenFPcmwzMHBnMWRyYjVoRVB5?=
 =?utf-8?B?ZVlzb0RyanZXZWc1bUYxTkkySHVpNFpCSHNHVmpkYXQ0SEoxaElDb0tRUnY2?=
 =?utf-8?B?REpaMW5hM291SUxCSWxVUkFEbzdZcDVGOVR0ZDBBWGs3c3VvajA5Z0dvNU9l?=
 =?utf-8?B?eGsyRVpWcFczYWtqb21DM1VRTmk1N1hCWnFWRXhGNlVpYy82cWp2aTMvZStU?=
 =?utf-8?B?ejVOdFRtWGd2SE5WYVEwMElzVjNPY1Vvc095em04YTlQQlN3cXBOVlZWM0JU?=
 =?utf-8?B?eXVndFJ1MVRyRWdQRFMzRjBKZmltYlJ6dmRnQ01YaW9WeWM0dXNnZEs0cTN6?=
 =?utf-8?B?NTUzdGdaZHllOTE1a1RFdGEvZ0lHT0t0K0tiTnI2UlI2d0dJRGx1WHZQM0hq?=
 =?utf-8?B?SWhkR3kxWWZjUEdEbzNFaXhmQjMyb3kvb0dhaXFIeEN0VmNzZ1NYNGZnT0Fn?=
 =?utf-8?B?anVDZE5JYllONzM2cDRrSHFmODVPSXJOdHh2eUUwbHdEUEYrWlZyRjhGVlAy?=
 =?utf-8?B?WEFiSW1WVGx2VzhUMWNxMWpkbHNzMjdwTVgzc1BweHVIdi8wbG11UXFxWHlR?=
 =?utf-8?B?em5aZ1ozSCtNT08vd3Zpa1FWRGQ4eFhxWjd3dTBHemFjRlJzRWRlWmNEVlBH?=
 =?utf-8?B?YWRabEZQMFl6T0dzRllYYXlnWDBjY1BZbDR4L3hPU0xON1hObVB0bzNYeWZv?=
 =?utf-8?B?eXdsTVZJc2srdDUzMStscC96ZHZGVHFyZEVKd0d4bXY2T2dzWXNFQ1F5RVRn?=
 =?utf-8?B?QkhoN1EwMkRGZmM0NHVLbXdZMDdFS1l4TXN6ZU5LRXVrKys0aE4vNGVQV2Q1?=
 =?utf-8?B?d2hJN1RqNnA2UjBXYyttdTlkRkE2azJza1hZckJmY251VFBZNVA4TWFYbXo1?=
 =?utf-8?B?V2JJT1grM1dnMGszam94eWRhWVVsZlJjK1N2ZGV5S2Z1UlkvbVlYcGZqb0F3?=
 =?utf-8?B?elZHVE9LZjcyU3NSYnF0eWxkd2NGbVNKUnRQQ1I1UFYvTXBQckFFblFhYXlz?=
 =?utf-8?B?alQybGdQSkwzSnVqeHFjTW5ycFJzSjZ2Z3VsSktveDhEUUVOMnk4VEd0NTlo?=
 =?utf-8?B?NHJXeFlsMDVLSFpBODQwMEd2aEVuTHJOUUpzbzVBc1FkdmRmczV0Y2lCRnJT?=
 =?utf-8?B?bDF4bXA3Zmd1QllXY2ZnNXI5YTEwMnl3V0dZaUJiRjFzMUVEeHhoZEQrOXB0?=
 =?utf-8?B?ZnVWeWd4c3Y4KzlhUUMzOC92R0IwWVZHc0c2YTE1S0x4dHBtWVBIZ2g5enBL?=
 =?utf-8?B?L0hOcFI5emZ1T09RTW16dU1ZWjVKVU04OUxHYUtVR2RNZkdJanpTNStWNExa?=
 =?utf-8?B?Y3dSaG1UQkVlR1N0TEN1S3BrS0laTDRiVTRoTHpha2RPc0ROSUNFYmE0RmVD?=
 =?utf-8?B?citIVzRxNmdqWitCcWVSZ3F3Smk1OUcwWHg3bDViS1YxQ0hZby92c0ZNTmtN?=
 =?utf-8?B?TlF5Uk9lSjg3YWo3NkdtT3RaTllnSzJUZW1oeFBrWVZqMkRIQWU0dkptcUIv?=
 =?utf-8?B?dkpEWXpvSlQvMnhtZEJJRHVTTktJVlRCc0xqOThZL2NLdnE3NDNUdUlDSUZu?=
 =?utf-8?B?S0I4MXpvdW5CU3A3N3BDa2UycnBZcWZwWk42c3RNaXFXeVovTnBaMjNPSVZ3?=
 =?utf-8?B?NUpxZVR0dy9jL2IwcXlCYStzeFZXSVVRQ2ZETUZ2VmhvSTlqOFNleHNWT0Yr?=
 =?utf-8?B?TkNxZjU0R0lqZEJLMWVDNXJxV1FZNS9PQStKbGtaTTAyMFJ1SWpka1VIVmtC?=
 =?utf-8?B?Wk5vRGdsWmxjRG1ESnNmVVFhWXhlUU5yRGVwUVFNUUk1WEhiUXZlV2Jqckdp?=
 =?utf-8?B?QWpQMUYybVhwYThaaG5laXFvZHdHa2RaWnFLeDVvb29qbk5ERW54em1LUmQr?=
 =?utf-8?B?MUZJVFJoR2tISzFYSVFuRUtsVHg4OGsyYzVpN1dyMnMwZk83UkwwOWdrNFdB?=
 =?utf-8?B?dDgzWDlISUJ0N0JlZGhabzJQTVNhSVlLTnM5Ty9qYzFuMUhqYmpvbUUrdkd3?=
 =?utf-8?B?ck5qUkcxbHFoMUg5aDRwdmhPR0R6azFqUFRCK2V3TnNmY1VZbjBCSUpKZ1FH?=
 =?utf-8?B?dFNNMEF6cXdPREZiWjlHZklBN3RqWG5XRndkNFlSaTNkTjZlWXk4RXFXZlRz?=
 =?utf-8?Q?Jp4Hsx6z0uWdOJrr8OiHGUE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a28446-81ff-4e5a-baea-08d9e5086905
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5145.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 22:24:13.5836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DfhANTYkREvEY0oqxxRrLLERARbw0brjdGKzni5yaltuTih7a5N9DfwLb1V8zBspkXyrbUUGYZ8o9owIeoD/mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5147
X-OriginatorOrg: intel.com

On 1/28/22 11:48 AM, Mat Martineau wrote:
> On Fri, 28 Jan 2022, Geliang Tang wrote:
> 
>> Hi Kishen,
>>
>> This patch will get many checkpatch.pl warnings:
>>
>> WARNING: line length of 103 exceeds 100 columns
>>
> 
> Most of our selftest scripts exceed 100 columns, as do many in the net/ directory. I think the longer command lines end up more readable without wrapping, but some of the longer 'if' statements could be wrapped to help with readability.
> 

Thanks, I will try to wrap some of the longer lines in the script to get in the
vicinity of 100 cols (even if slightly higher). 

> 
>> Thanks,
>> -Geliang
>>
>> Kishen Maloor <kishen.maloor@intel.com> 于2022年1月28日周五 08:39写道：
>>>
>>> This change adds a selftest script that performs a comprehensive
>>> behavioral/functional test of all userspace PM capabilities by exercising
>>> all the newly added APIs and changes to support said capabilities.
>>>
>>> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
>>> ---
>>> v3: configure net.mptcp.userspace_pm_local_addr_max via sysctl on
>>> the namespaces established for testing, read and verify the new
>>> "server_side" attribute from netlink events upon connection
>>> establishment, new test case for sysctl configured local_addr limit,
>>> added descriptive remarks throughout script
>>> ---
>>>  .../selftests/net/mptcp/userspace_pm.sh       | 656 ++++++++++++++++++
>>>  1 file changed, 656 insertions(+)
>>>  create mode 100755 tools/testing/selftests/net/mptcp/userspace_pm.sh
>>>
>>> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
>>> new file mode 100755
>>> index 000000000000..cc6c03626c21
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
>>> @@ -0,0 +1,656 @@
>>> +#!/bin/bash
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +
>>> +ip -Version > /dev/null 2>&1
>>> +if [ $? -ne 0 ];then
>>> +       echo "SKIP: Cannot not run test without ip tool"
>>> +       exit 1
>>> +fi
>>> +
>>> +ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED
>>> +REMOVED=7          # MPTCP_EVENT_REMOVED
>>> +SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
>>> +SUB_CLOSED=11      # MPTCP_EVENT_SUB_CLOSED
>>> +
>>> +AF_INET=2
>>> +AF_INET6=10
>>> +
>>> +evts_pid=0
>>> +client4_pid=0
>>> +server4_pid=0
>>> +client6_pid=0
>>> +server6_pid=0
>>> +client4_token=""
>>> +server4_token=""
>>> +client6_token=""
>>> +server6_token=""
>>> +client4_port=0;
>>> +client6_port=0;
>>> +app4_port=50002
>>> +new4_port=50003
>>> +app6_port=50004
>>> +client_addr_id=${RANDOM:0:2}
>>> +server_addr_id=${RANDOM:0:2}
>>> +
>>> +sec=$(date +%s)
>>> +rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
>>> +ns1="ns1-$rndh"
>>> +ns2="ns2-$rndh"
>>> +
>>> +cleanup()
>>> +{
>>> +       echo "cleanup"
>>> +
>>> +       # Terminate the MPTCP connection and related processes
>>> +       kill -SIGUSR1 $client4_pid > /dev/null 2>&1
>>> +       kill $server4_pid > /dev/null 2>&1
>>> +       kill -SIGUSR1 $client6_pid > /dev/null 2>&1
>>> +       kill $server6_pid > /dev/null 2>&1
>>> +
>>> +       kill $evts_pid > /dev/null 2>&1
>>> +
>>> +       local netns
>>> +       for netns in "$ns1" "$ns2" ;do
>>> +               ip netns del $netns
>>> +       done
>>> +}
>>> +
>>> +trap cleanup EXIT
>>> +
>>> +# Create and configure network namespaces for testing
>>> +for i in "$ns1" "$ns2" ;do
>>> +       ip netns add $i || exit 1
>>> +       ip -net $i link set lo up
>>> +       ip netns exec $i sysctl -q net.mptcp.enabled=1
>>> +       ip netns exec $i sysctl -q net.mptcp.pm_type=1
>>> +       ip netns exec $i sysctl -q net.mptcp.userspace_pm_local_addr_max=2
>>> +done
>>> +
>>> +#  "$ns1"              ns2
>>> +#     ns1eth2    ns2eth1
>>> +
>>> +ip link add ns1eth2 netns "$ns1" type veth peer name ns2eth1 netns "$ns2"
>>> +
>>> +# Add IPv4/v6 addresses to the namespaces
>>> +ip -net "$ns1" addr add 10.0.1.1/24 dev ns1eth2
>>> +ip -net "$ns1" addr add 10.0.2.1/24 dev ns1eth2
>>> +ip -net "$ns1" addr add dead:beef:1::1/64 dev ns1eth2 nodad
>>> +ip -net "$ns1" addr add dead:beef:2::1/64 dev ns1eth2 nodad
>>> +ip -net "$ns1" link set ns1eth2 up
>>> +
>>> +ip -net "$ns2" addr add 10.0.1.2/24 dev ns2eth1
>>> +ip -net "$ns2" addr add 10.0.2.2/24 dev ns2eth1
>>> +ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1 nodad
>>> +ip -net "$ns2" addr add dead:beef:2::2/64 dev ns2eth1 nodad
>>> +ip -net "$ns2" link set ns2eth1 up
>>> +
>>> +printf "Created network namespaces ns1, ns2         \t\t\t[OK]\n"
>>> +
>>> +make_file()
>>> +{
>>> +       # Store a chunk of data in a file to transmit over an MPTCP connection
>>> +       local name=$1
>>> +       local who=$2
>>> +       local ksize=1
>>> +
>>> +       dd if=/dev/urandom of="$name" bs=1024 count=$ksize 2> /dev/null
>>> +       echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
>>> +}
>>> +
>>> +make_connection()
>>> +{
>>> +       local file=$(mktemp)
>>> +       make_file "$file" "client"
>>> +
>>> +       local is_v6=$1
>>> +       local app_port=$app4_port
>>> +       local connect_addr="10.0.1.1"
>>> +       local listen_addr="0.0.0.0"
>>> +       if [ "$is_v6" = "v6" ]
>>> +       then
>>> +               connect_addr="dead:beef:1::1"
>>> +               listen_addr="::"
>>> +               app_port=$app6_port
>>> +       else
>>> +               is_v6="v4"
>>> +       fi
>>> +
>>> +       # Capture netlink events over the two network namespaces running
>>> +       # the MPTCP client and server
>>> +       local client_evts=$(mktemp)
>>> +       :>"$client_evts"
>>> +       ip netns exec $ns2 ./pm_nl_ctl events >> "$client_evts" 2>&1 &
>>> +       local client_evts_pid=$!
>>> +       local server_evts=$(mktemp)
>>> +       :>"$server_evts"
>>> +       ip netns exec $ns1 ./pm_nl_ctl events >> "$server_evts" 2>&1 &
>>> +       local server_evts_pid=$!
>>> +       sleep 0.1
>>> +
>>> +       # Run the server
>>> +       ip netns exec $ns1 \
>>> +                       ./mptcp_connect -s MPTCP -w 300 -p $app_port -l $listen_addr 2>&1 > /dev/null &
>>> +       local server_pid=$!
>>> +       sleep 0.1
>>> +
>>> +       # Run the client, transfer $file and stay connected to the server
>>> +       # to conduct tests
>>> +       ip netns exec $ns2 \
>>> +                       ./mptcp_connect -s MPTCP -w 300 -m sendfile -p $app_port $connect_addr 2>&1 > /dev/null < $file &
>>> +       local client_pid=$!
>>> +       sleep 0.1
>>> +
>>> +       # Capture client/server attributes from MPTCP connection netlink events
>>> +       kill $client_evts_pid
>>> +       local client_token=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
>>> +       local client_port=$(sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
>>> +       local client_serverside=$(sed -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q' "$client_evts")
>>> +
>>> +       kill $server_evts_pid
>>> +       local server_token=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
>>> +       local server_serverside=$(sed -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
>>> +
>>> +       rm -f "$client_evts" "$server_evts" "$file"
>>> +
>>> +       if [ $client_token != "" ] && [ $server_token != "" ] && [ $client_serverside = 0 ] && [ $server_serverside = 1 ]
>>> +       then
>>> +               printf "Established IP%s MPTCP Connection ns2 => ns1    \t\t[OK]\n" $is_v6
>>> +       else
>>> +               exit 1
>>> +       fi
>>> +
>>> +       if [ "$is_v6" = "v6" ]
>>> +       then
>>> +               client6_token=$client_token
>>> +               server6_token=$server_token
>>> +               client6_port=$client_port
>>> +               client6_pid=$client_pid
>>> +               server6_pid=$server_pid
>>> +       else
>>> +               client4_token=$client_token
>>> +               server4_token=$server_token
>>> +               client4_port=$client_port
>>> +               client4_pid=$client_pid
>>> +               server4_pid=$server_pid
>>> +       fi
>>> +}
>>> +
>>> +verify_announce_event()
>>> +{
>>> +       local evt=$1
>>> +       local e_type=$2
>>> +       local e_token=$3
>>> +       local e_addr=$4
>>> +       local e_id=$5
>>> +       local e_dport=$6
>>> +       local e_af=$7
>>> +
>>> +       local type=$(sed -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
>>> +       local token=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
>>> +       local addr=""
>>> +       if [ "$e_af" = "v6" ]
>>> +       then
>>> +               addr=$(sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q' "$evt")
>>> +       else
>>> +               addr=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evt")
>>> +       fi
>>> +       local dport=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
>>> +       local id=$(sed -n 's/.*\(rem_id:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
>>> +        if [ "$type" = "$e_type" ] && [ "$token" = "$e_token" ] && [ "$addr" = "$e_addr" ] && [ "$dport" = "$e_dport" ] && [ "$id" = "$e_id" ]
> 
> Here's one spot with leading spaces instead of tabs - looks like there are others too. Also an example of a line that could be wrapped :)
> 
> -Mat
> 
>>> +       then
>>> +               printf "[OK]\n"
>>> +               return 0
>>> +       fi
>>> +       printf "[FAIL]\n"
>>> +       exit 1
>>> +}
>>> +
>>> +test_announce()
>>> +{
>>> +       local evts=$(mktemp)
>>> +       # Capture events on the network namespace running the server
>>> +       :>"$evts"
>>> +       ip netns exec $ns1 ./pm_nl_ctl events >> "$evts" 2>&1 &
>>> +       evts_pid=$!
>>> +       sleep 0.1
>>> +
>>> +       # ADD_ADDR using an invalid token should result in no action
>>> +       local invalid_token=$(( $client4_token - 1))
>>> +       ip netns exec $ns2 ./pm_nl_ctl ann 10.0.2.2 token $invalid_token id $client_addr_id dev ns2eth1 2>&1 > /dev/null
>>> +       local type=$(sed -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
>>> +       printf "ADD_ADDR 10.0.2.2 (ns2) => ns1, invalid token    \t\t"
>>> +        if [ "$type" = "" ]
>>> +       then
>>> +               printf "[OK]\n"
>>> +       else
>>> +               printf "[FAIL]\n"
>>> +               exit 1
>>> +       fi
>>> +
>>> +       # ADD_ADDR from the client to server machine reusing the subflow port
>>> +       :>"$evts"
>>> +       ip netns exec $ns2 ./pm_nl_ctl ann 10.0.2.2 token $client4_token id $client_addr_id dev ns2eth1 2>&1 > /dev/null
>>> +       printf "ADD_ADDR id:%d 10.0.2.2 (ns2) => ns1, reuse port \t\t" $client_addr_id
>>> +       sleep 0.1
>>> +       verify_announce_event "$evts" "$ANNOUNCED" "$server4_token" "10.0.2.2" "$client_addr_id" "$client4_port"
>>> +
>>> +       # ADD_ADDR6 from the client to server machine reusing the subflow port
>>> +       :>"$evts"
>>> +       ip netns exec $ns2 ./pm_nl_ctl ann dead:beef:2::2 token $client6_token id $client_addr_id dev ns2eth1 2>&1 > /dev/null
>>> +       printf "ADD_ADDR6 id:%d dead:beef:2::2 (ns2) => ns1, reuse port\t\t" $client_addr_id
>>> +       sleep 0.1
>>> +       verify_announce_event "$evts" "$ANNOUNCED" "$server6_token" "dead:beef:2::2" "$client_addr_id" "$client6_port" "v6"
>>> +
>>> +       # ADD_ADDR from the client to server machine using a new port
>>> +       :>"$evts"
>>> +       client_addr_id=$((client_addr_id+1))
>>> +       ip netns exec $ns2 ./pm_nl_ctl ann 10.0.2.2 token $client4_token id $client_addr_id dev ns2eth1 port $new4_port 2>&1 > /dev/null
>>> +       printf "ADD_ADDR id:%d 10.0.2.2 (ns2) => ns1, new port \t\t\t" $client_addr_id
>>> +       sleep 0.1
>>> +       verify_announce_event "$evts" "$ANNOUNCED" "$server4_token" "10.0.2.2" "$client_addr_id" "$new4_port"
>>> +
>>> +       kill $evts_pid
>>> +
>>> +       # Capture events on the network namespace running the client
>>> +       :>"$evts"
>>> +       ip netns exec $ns2 ./pm_nl_ctl events >> "$evts" 2>&1 &
>>> +       evts_pid=$!
>>> +       sleep 0.1
>>> +
>>> +       # ADD_ADDR from the server to client machine reusing the subflow port
>>> +       ip netns exec $ns1 ./pm_nl_ctl ann 10.0.2.1 token $server4_token id $server_addr_id dev ns1eth2 2>&1 > /dev/null
>>> +       printf "ADD_ADDR id:%d 10.0.2.1 (ns1) => ns2, reuse port \t\t" $server_addr_id
>>> +       sleep 0.1
>>> +       verify_announce_event "$evts" "$ANNOUNCED" "$client4_token" "10.0.2.1" "$server_addr_id" "$app4_port"
>>> +
>>> +       # ADD_ADDR6 from the server to client machine reusing the subflow port
>>> +       :>"$evts"
>>> +       ip netns exec $ns1 ./pm_nl_ctl ann dead:beef:2::1 token $server6_token id $server_addr_id dev ns1eth2 2>&1 > /dev/null
>>> +       printf "ADD_ADDR6 id:%d dead:beef:2::1 (ns1) => ns2, reuse port\t\t" $server_addr_id
>>> +       sleep 0.1
>>> +       verify_announce_event "$evts" "$ANNOUNCED" "$client6_token" "dead:beef:2::1" "$server_addr_id" "$app6_port" "v6"
>>> +
>>> +       # ADD_ADDR from the server to client machine using a new port
>>> +       :>"$evts"
>>> +       server_addr_id=$((server_addr_id+1))
>>> +       ip netns exec $ns1 ./pm_nl_ctl ann 10.0.2.1 token $server4_token id $server_addr_id dev ns1eth2 port $new4_port 2>&1 > /dev/null
>>> +       printf "ADD_ADDR id:%d 10.0.2.1 (ns1) => ns2, new port \t\t\t" $server_addr_id
>>> +       sleep 0.1
>>> +       verify_announce_event "$evts" "$ANNOUNCED" "$client4_token" "10.0.2.1" "$server_addr_id" "$new4_port"
>>> +
>>> +       kill $evts_pid
>>> +       rm -f "$evts"
>>> +}
>>> +
>>> +verify_remove_event()
>>> +{
>>> +       local evt=$1
>>> +       local e_type=$2
>>> +       local e_token=$3
>>> +       local e_id=$4
>>> +
>>> +       local type=$(sed -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
>>> +       local token=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
>>> +       local id=$(sed -n 's/.*\(rem_id:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
>>> +        if [ "$type" = "$e_type" ] && [ "$token" = "$e_token" ] && [ "$id" = "$e_id" ]
>>> +       then
>>> +               printf "[OK]\n"
>>> +               return 0
>>> +       fi
>>> +       printf "[FAIL]\n"
>>> +       exit 1
>>> +}
>>> +
>>> +test_remove()
>>> +{
>>> +       local evts=$(mktemp)
>>> +
>>> +       # Capture events on the network namespace running the server
>>> +       :>"$evts"
>>> +       ip netns exec $ns1 ./pm_nl_ctl events >> "$evts" 2>&1 &
>>> +       evts_pid=$!
>>> +       sleep 0.1
>>> +
>>> +       # RM_ADDR using an invalid token should result in no action
>>> +       local invalid_token=$(( $client4_token - 1 ))
>>> +       ip netns exec $ns2 ./pm_nl_ctl rem token $invalid_token id $client_addr_id 2>&1 > /dev/null
>>> +       printf "RM_ADDR id:%d ns2 => ns1, invalid token                    \t" $client_addr_id
>>> +       local type=$(sed -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
>>> +       if [ "$type" = "" ]
>>> +       then
>>> +               printf "[OK]\n"
>>> +       else
>>> +               printf "[FAIL]\n"
>>> +       fi
>>> +
>>> +       # RM_ADDR using an invalid addr id should result in no action
>>> +       local invalid_id=$(( $client_addr_id + 1 ))
>>> +       ip netns exec $ns2 ./pm_nl_ctl rem token $client4_token id $invalid_id 2>&1 > /dev/null
>>> +       printf "RM_ADDR id:%d ns2 => ns1, invalid id                    \t" $invalid_id
>>> +       type=$(sed -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
>>> +       if [ "$type" = "" ]
>>> +       then
>>> +               printf "[OK]\n"
>>> +       else
>>> +               printf "[FAIL]\n"
>>> +       fi
>>> +
>>> +       # RM_ADDR from the client to server machine
>>> +       :>"$evts"
>>> +       ip netns exec $ns2 ./pm_nl_ctl rem token $client4_token id $client_addr_id 2>&1 > /dev/null
>>> +       printf "RM_ADDR id:%d ns2 => ns1                                \t" $client_addr_id
>>> +       sleep 0.1
>>> +       verify_remove_event "$evts" "$REMOVED" "$server4_token" "$client_addr_id"
>>> +
>>> +       # RM_ADDR from the client to server machine
>>> +       :>"$evts"
>>> +       client_addr_id=$(( $client_addr_id - 1 ))
>>> +       ip netns exec $ns2 ./pm_nl_ctl rem token $client4_token id $client_addr_id 2>&1 > /dev/null
>>> +       printf "RM_ADDR id:%d ns2 => ns1                                \t" $client_addr_id
>>> +       sleep 0.1
>>> +       verify_remove_event "$evts" "$REMOVED" "$server4_token" "$client_addr_id"
>>> +
>>> +       # RM_ADDR6 from the client to server machine
>>> +       :>"$evts"
>>> +       ip netns exec $ns2 ./pm_nl_ctl rem token $client6_token id $client_addr_id 2>&1 > /dev/null
>>> +       printf "RM_ADDR6 id:%d ns2 => ns1                               \t" $client_addr_id
>>> +       sleep 0.1
>>> +       verify_remove_event "$evts" "$REMOVED" "$server6_token" "$client_addr_id"
>>> +
>>> +       kill $evts_pid
>>> +
>>> +       # Capture events on the network namespace running the client
>>> +       :>"$evts"
>>> +       ip netns exec $ns2 ./pm_nl_ctl events >> "$evts" 2>&1 &
>>> +       evts_pid=$!
>>> +       sleep 0.1
>>> +
>>> +       # RM_ADDR from the server to client machine
>>> +       ip netns exec $ns1 ./pm_nl_ctl rem token $server4_token id $server_addr_id 2>&1 > /dev/null
>>> +       printf "RM_ADDR id:%d ns1 => ns2                                \t" $server_addr_id
>>> +       sleep 0.1
>>> +       verify_remove_event "$evts" "$REMOVED" "$client4_token" "$server_addr_id"
>>> +
>>> +       # RM_ADDR from the server to client machine
>>> +       :>"$evts"
>>> +       server_addr_id=$(( $server_addr_id - 1 ))
>>> +       ip netns exec $ns1 ./pm_nl_ctl rem token $server4_token id $server_addr_id 2>&1 > /dev/null
>>> +       printf "RM_ADDR id:%d ns1 => ns2                                \t" $server_addr_id
>>> +       sleep 0.1
>>> +       verify_remove_event "$evts" "$REMOVED" "$client4_token" "$server_addr_id"
>>> +
>>> +       # RM_ADDR6 from the server to client machine
>>> +       :>"$evts"
>>> +       ip netns exec $ns1 ./pm_nl_ctl rem token $server6_token id $server_addr_id 2>&1 > /dev/null
>>> +       printf "RM_ADDR6 id:%d ns1 => ns2                               \t" $server_addr_id
>>> +       sleep 0.1
>>> +       verify_remove_event "$evts" "$REMOVED" "$client6_token" "$server_addr_id"
>>> +
>>> +       kill $evts_pid
>>> +       rm -f "$evts"
>>> +}
>>> +
>>> +verify_subflow_events()
>>> +{
>>> +       local evt=$1
>>> +       local e_type=$2
>>> +       local e_token=$3
>>> +       local e_family=$4
>>> +       local e_saddr=$5
>>> +       local e_daddr=$6
>>> +       local e_dport=$7
>>> +       local e_locid=$8
>>> +       local e_remid=$9
>>> +       shift 2
>>> +       local e_from=$8
>>> +       local e_to=$9
>>> +
>>> +       if [ "$e_type" = "$SUB_ESTABLISHED" ]
>>> +       then
>>> +               if [ "$e_family" = "$AF_INET6" ]
>>> +               then
>>> +                       printf "CREATE_SUBFLOW6 %s (%s) => %s (%s)    " $e_saddr $e_from $e_daddr $e_to
>>> +               else
>>> +                       printf "CREATE_SUBFLOW %s (%s) => %s (%s)         \t" $e_saddr $e_from $e_daddr $e_to
>>> +               fi
>>> +       else
>>> +               if [ "$e_family" = "$AF_INET6" ]
>>> +               then
>>> +                       printf "DESTROY_SUBFLOW6 %s (%s) => %s (%s)   " $e_saddr $e_from $e_daddr $e_to
>>> +               else
>>> +                       printf "DESTROY_SUBFLOW %s (%s) => %s (%s)         \t" $e_saddr $e_from $e_daddr $e_to
>>> +               fi
>>> +       fi
>>> +
>>> +       local type=$(sed -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
>>> +       local token=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
>>> +       local family=$(sed -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
>>> +       local dport=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
>>> +       local locid=$(sed -n 's/.*\(loc_id:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
>>> +       local remid=$(sed -n 's/.*\(rem_id:\)\([[:digit:]]*\).*$/\2/p;q' "$evt")
>>> +       local saddr=""
>>> +       local daddr=""
>>> +       if [ "$family" = "$AF_INET6" ]
>>> +       then
>>> +               saddr=$(sed -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q' "$evt")
>>> +               daddr=$(sed -n 's/.*\(daddr6:\)\([0-9a-f:.]*\).*$/\2/p;q' "$evt")
>>> +       else
>>> +               saddr=$(sed -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q' "$evt")
>>> +               daddr=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evt")
>>> +       fi
>>> +
>>> +        if [ "$type" = "$e_type" ] && [ "$token" = "$e_token" ] && [ "$daddr" = "$e_daddr" ] && [ "$e_dport" = "$dport" ] && [ "$family" = "$e_family" ] && [ "$saddr" = "$e_saddr" ] && [ "$e_locid" = "$locid" ] && [ "$e_remid" = "$remid" ]
>>> +       then
>>> +               printf "[OK]\n"
>>> +               return 0
>>> +       fi
>>> +       printf "[FAIL]\n"
>>> +       exit 1
>>> +}
>>> +
>>> +test_subflows()
>>> +{
>>> +       local evts=$(mktemp)
>>> +       # Capture events on the network namespace running the server
>>> +       :>"$evts"
>>> +       ip netns exec $ns1 ./pm_nl_ctl events >> "$evts" 2>&1 &
>>> +       evts_pid=$!
>>> +       sleep 0.1
>>> +
>>> +       # ADD_ADDR from client to server machine reusing the subflow port
>>> +       ip netns exec $ns2 ./pm_nl_ctl ann 10.0.2.2 token $client4_token id $client_addr_id 2>&1 > /dev/null
>>> +       sleep 0.1
>>> +
>>> +       # CREATE_SUBFLOW from server to client machine
>>> +       :>"$evts"
>>> +       ip netns exec $ns1 ./pm_nl_ctl csf lip 10.0.2.1 lid 23 rip 10.0.2.2 rport $client4_port token $server4_token 2>&1 > /dev/null
>>> +       sleep 0.1
>>> +       verify_subflow_events "$evts" "$SUB_ESTABLISHED" "$server4_token" "$AF_INET" "10.0.2.1" "10.0.2.2" "$client4_port" "23" "$client_addr_id" "ns1" "ns2"
>>> +
>>> +       local sport=$(sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
>>> +
>>> +       # DESTROY_SUBFLOW from server to client machine
>>> +       :>"$evts"
>>> +       ip netns exec $ns1 ./pm_nl_ctl dsf lip 10.0.2.1 lport $sport rip 10.0.2.2 rport $client4_port token $server4_token 2>&1 > /dev/null
>>> +       sleep 0.1
>>> +       verify_subflow_events "$evts" "$SUB_CLOSED" "$server4_token" "$AF_INET" "10.0.2.1" "10.0.2.2" "$client4_port" "23" "$client_addr_id" "ns1" "ns2"
>>> +
>>> +       # RM_ADDR from client to server machine
>>> +       ip netns exec $ns2 ./pm_nl_ctl rem id $client_addr_id token $client4_token 2>&1 > /dev/null
>>> +       sleep 0.1
>>> +
>>> +       # ADD_ADDR6 from client to server machine reusing the subflow port
>>> +       :>"$evts"
>>> +       ip netns exec $ns2 ./pm_nl_ctl ann dead:beef:2::2 token $client6_token id $client_addr_id 2>&1 > /dev/null
>>> +       sleep 0.1
>>> +
>>> +       # CREATE_SUBFLOW6 from server to client machine
>>> +       :>"$evts"
>>> +       ip netns exec $ns1 ./pm_nl_ctl csf lip dead:beef:2::1 lid 23 rip dead:beef:2::2 rport $client6_port token $server6_token 2>&1 > /dev/null
>>> +       sleep 0.1
>>> +       verify_subflow_events "$evts" "$SUB_ESTABLISHED" "$server6_token" "$AF_INET6" "dead:beef:2::1" "dead:beef:2::2" "$client6_port" "23" "$client_addr_id" "ns1" "ns2"
>>> +
>>> +       local sport=$(sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
>>> +
>>> +       # DESTROY_SUBFLOW6 from server to client machine
>>> +       :>"$evts"
>>> +       ip netns exec $ns1 ./pm_nl_ctl dsf lip dead:beef:2::1 lport $sport rip dead:beef:2::2 rport $client6_port token $server6_token 2>&1 > /dev/null
>>> +       sleep 0.1
>>> +       verify_subflow_events "$evts" "$SUB_CLOSED" "$server6_token" "$AF_INET6" "dead:beef:2::1" "dead:beef:2::2" "$client6_port" "23" "$client_addr_id" "ns1" "ns2"
>>> +
>>> +       # RM_ADDR from client to server machine
>>> +       ip netns exec $ns2 ./pm_nl_ctl rem id $client_addr_id token $client6_token 2>&1 > /dev/null
>>> +       sleep 0.1
>>> +
>>> +       # ADD_ADDR from client to server machine using a new port
>>> +       :>"$evts"
>>> +       ip netns exec $ns2 ./pm_nl_ctl ann 10.0.2.2 token $client4_token id $client_addr_id port $new4_port 2>&1 > /dev/null
>>> +       sleep 0.1
>>> +
>>> +       # CREATE_SUBFLOW from server to client machine
>>> +       :>"$evts"
>>> +       ip netns exec $ns1 ./pm_nl_ctl csf lip 10.0.2.1 lid 23 rip 10.0.2.2 rport $new4_port token $server4_token 2>&1 > /dev/null
>>> +       sleep 0.1
>>> +       verify_subflow_events "$evts" "$SUB_ESTABLISHED" "$server4_token" "$AF_INET" "10.0.2.1" "10.0.2.2" "$new4_port" "23" "$client_addr_id" "ns1" "ns2"
>>> +
>>> +        sport=$(sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
>>> +
>>> +       # DESTROY_SUBFLOW from server to client machine
>>> +       :>"$evts"
>>> +       ip netns exec $ns1 ./pm_nl_ctl dsf lip 10.0.2.1 lport $sport rip 10.0.2.2 rport $new4_port token $server4_token 2>&1 > /dev/null
>>> +       sleep 0.1
>>> +       verify_subflow_events "$evts" "$SUB_CLOSED" "$server4_token" "$AF_INET" "10.0.2.1" "10.0.2.2" "$new4_port" "23" "$client_addr_id" "ns1" "ns2"
>>> +
>>> +       # RM_ADDR from client to server machine
>>> +       ip netns exec $ns2 ./pm_nl_ctl rem id $client_addr_id token $client4_token 2>&1 > /dev/null
>>> +
>>> +       kill $evts_pid
>>> +
>>> +       # Capture events on the network namespace running the client
>>> +       :>"$evts"
>>> +       ip netns exec $ns2 ./pm_nl_ctl events >> "$evts" 2>&1 &
>>> +       evts_pid=$!
>>> +       sleep 0.1
>>> +
>>> +       # ADD_ADDR from server to client machine reusing the subflow port
>>> +       ip netns exec $ns1 ./pm_nl_ctl ann 10.0.2.1 token $server4_token id $server_addr_id 2>&1 > /dev/null
>>> +       sleep 0.1
>>> +
>>> +       # CREATE_SUBFLOW from client to server machine
>>> +       :>"$evts"
>>> +       ip netns exec $ns2 ./pm_nl_ctl csf lip 10.0.2.2 lid 23 rip 10.0.2.1 rport $app4_port token $client4_token 2>&1 > /dev/null
>>> +       sleep 0.1
>>> +       verify_subflow_events "$evts" "$SUB_ESTABLISHED" "$client4_token" "$AF_INET" "10.0.2.2" "10.0.2.1" "$app4_port" "23" "$server_addr_id" "ns2" "ns1"
>>> +
>>> +        sport=$(sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
>>> +
>>> +       # DESTROY_SUBFLOW from client to server machine
>>> +       :>"$evts"
>>> +       ip netns exec $ns2 ./pm_nl_ctl dsf lip 10.0.2.2 lport $sport rip 10.0.2.1 rport $app4_port token $client4_token 2>&1 > /dev/null
>>> +       sleep 0.1
>>> +       verify_subflow_events "$evts" "$SUB_CLOSED" "$client4_token" "$AF_INET" "10.0.2.2" "10.0.2.1" "$app4_port" "23" "$server_addr_id" "ns2" "ns1"
>>> +
>>> +       # RM_ADDR from server to client machine
>>> +       ip netns exec $ns1 ./pm_nl_ctl rem id $server_addr_id token $server4_token 2>&1 > /dev/null
>>> +       sleep 0.1
>>> +
>>> +       # ADD_ADDR6 from server to client machine reusing the subflow port
>>> +       :>"$evts"
>>> +       ip netns exec $ns1 ./pm_nl_ctl ann dead:beef:2::1 token $server6_token id $server_addr_id 2>&1 > /dev/null
>>> +       sleep 0.1
>>> +
>>> +       # CREATE_SUBFLOW6 from client to server machine
>>> +       :>"$evts"
>>> +       ip netns exec $ns2 ./pm_nl_ctl csf lip dead:beef:2::2 lid 23 rip dead:beef:2::1 rport $app6_port token $client6_token 2>&1 > /dev/null
>>> +       sleep 0.1
>>> +       verify_subflow_events "$evts" "$SUB_ESTABLISHED" "$client6_token" "$AF_INET6" "dead:beef:2::2" "dead:beef:2::1" "$app6_port" "23" "$server_addr_id" "ns2" "ns1"
>>> +
>>> +       local sport=$(sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
>>> +
>>> +       # DESTROY_SUBFLOW6 from client to server machine
>>> +       :>"$evts"
>>> +       ip netns exec $ns2 ./pm_nl_ctl dsf lip dead:beef:2::2 lport $sport rip dead:beef:2::1 rport $app6_port token $client6_token 2>&1 > /dev/null
>>> +       sleep 0.1
>>> +       verify_subflow_events "$evts" "$SUB_CLOSED" "$client6_token" "$AF_INET6" "dead:beef:2::2" "dead:beef:2::1" "$app6_port" "23" "$server_addr_id" "ns2" "ns1"
>>> +
>>> +       # RM_ADDR6 from server to client machine
>>> +       ip netns exec $ns1 ./pm_nl_ctl rem id $server_addr_id token $server6_token 2>&1 > /dev/null
>>> +       sleep 0.1
>>> +
>>> +       # ADD_ADDR from client to server machine using a new port
>>> +       :>"$evts"
>>> +       ip netns exec $ns1 ./pm_nl_ctl ann 10.0.2.1 token $server4_token id $server_addr_id port $new4_port 2>&1 > /dev/null
>>> +       sleep 0.1
>>> +
>>> +       # CREATE_SUBFLOW from client to server machine
>>> +       :>"$evts"
>>> +       ip netns exec $ns2 ./pm_nl_ctl csf lip 10.0.2.2 lid 23 rip 10.0.2.1 rport $new4_port token $client4_token 2>&1 > /dev/null
>>> +       sleep 0.1
>>> +       verify_subflow_events "$evts" "$SUB_ESTABLISHED" "$client4_token" "$AF_INET" "10.0.2.2" "10.0.2.1" "$new4_port" "23" "$server_addr_id" "ns2" "ns1"
>>> +
>>> +        sport=$(sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
>>> +
>>> +       # DESTROY_SUBFLOW from client to server machine
>>> +       :>"$evts"
>>> +       ip netns exec $ns2 ./pm_nl_ctl dsf lip 10.0.2.2 lport $sport rip 10.0.2.1 rport $new4_port token $client4_token 2>&1 > /dev/null
>>> +       sleep 0.1
>>> +       verify_subflow_events "$evts" "$SUB_CLOSED" "$client4_token" "$AF_INET" "10.0.2.2" "10.0.2.1" "$new4_port" "23" "$server_addr_id" "ns2" "ns1"
>>> +
>>> +       # RM_ADDR from server to client machine
>>> +       ip netns exec $ns1 ./pm_nl_ctl rem id $server_addr_id token $server4_token 2>&1 > /dev/null
>>> +
>>> +       kill $evts_pid
>>> +       rm -f "$evts"
>>> +}
>>> +
>>> +test_local_addr_limit()
>>> +{
>>> +       printf "Test sysctl: net.mptcp.userspace_pm_local_addr_max=1\t\t"
>>> +       # Limit the # of local addrs for both namespaces to 1
>>> +       for i in "$ns1" "$ns2" ;do
>>> +               ip netns exec $i sysctl -q net.mptcp.userspace_pm_local_addr_max=1
>>> +       done
>>> +
>>> +       local evts=$(mktemp)
>>> +       # Capture events from the network namespace running the server
>>> +       :>"$evts"
>>> +       ip netns exec $ns1 ./pm_nl_ctl events >> "$evts" 2>&1 &
>>> +       evts_pid=$!
>>> +       sleep 0.1
>>> +
>>> +       :>"$evts"
>>> +       # ADD_ADDR from the client to server machine -> success
>>> +       ip netns exec $ns2 ./pm_nl_ctl ann 10.0.2.2 token $client4_token id $client_addr_id dev ns2eth1 2>&1 > /dev/nulls
>>> +       sleep 0.1
>>> +       local type=$(sed -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
>>> +        if [ "$type" = "" ]
>>> +       then
>>> +               printf "[FAIL]\n"
>>> +               exit 1
>>> +       fi
>>> +
>>> +       :>"$evts"
>>> +       # ADD_ADDR from the client to server machine -> fail (limit already met)
>>> +       client_addr_id=$((client_addr_id+1))
>>> +       ip netns exec $ns2 ./pm_nl_ctl ann 10.0.2.2 token $client4_token id $client_addr_id dev ns2eth1 port $new4_port 2>&1 > /dev/null
>>> +       sleep 0.1
>>> +       type=$(sed -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q' "$evts")
>>> +        if [ "$type" = "" ]
>>> +       then
>>> +               printf "[OK]\n"
>>> +       else
>>> +               printf "[FAIL]\n"
>>> +               exit 1
>>> +       fi
>>> +
>>> +       kill $evts_pid
>>> +       rm -f "$evts"
>>> +}
>>> +
>>> +make_connection
>>> +make_connection "v6"
>>> +test_announce
>>> +test_remove
>>> +test_subflows
>>> +test_local_addr_limit
>>> +exit 0
>>> -- 
>>> 2.31.1
>>>
>>>
>>
>>
> 
> -- 
> Mat Martineau
> Intel

