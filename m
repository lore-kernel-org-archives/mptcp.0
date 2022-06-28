Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2205D33D6
	for <mptcp@lists.linux.dev>; Tue, 28 Jun 2022 23:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656460446; x=1687996446;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8Ez0tZQ/dnCrk/rvUDYypnaWRfylxFXRVRx1W5mg0zA=;
  b=Z0dy5G7s8nWl2o9ZX06Ez8K8TU0/fSHrNz4irMXX9qL7d2l/YjYoHDxR
   KzetojKMQwxBmu1PqydJrpJ1EFL/uWT6ZrcpkWqIvWA2Ttta+hrcZMs85
   lMVNCnHEG6ytqVrf85pkTrwzPOLa9UfkDVRIul85sDzXefFbz10yupXfd
   2+nX7OtDuPZMkGFZ8OLOS8JbBryYqi9qTFhok8fe9jfMmbsAqxLmdAq7b
   +b1UcS30boI4wejM0HDDi6WlZWkGcbHBqJ0MaHodNIJR9ICk4MVgeyn9m
   RliSmSCtkkZoCDGc5xKCR3opubNj4oNLoJ/RFQAJZay9EUFdNEIl877pP
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="270641285"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="270641285"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 16:54:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="917375974"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jun 2022 16:54:05 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 28 Jun 2022 16:54:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 28 Jun 2022 16:54:04 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 28 Jun 2022 16:54:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCeCffuDTHe2CypeVkIpviM+MYiwPNW1XVsC99Kkal+moIi+dZAWzRUzer8FTsSYutF9g2o4pN7zNP/HsR/kTsErHHFkZUKKOy1U54nxaNRJchAtv7V0JlPyMvvo9FvcZu+tJbZH66PY1l95SqfzBKHYhSnSVdT0Q5rMFCOCtDq1Md3T6FJ7vXgpIOXaRij+EGrgCP4g6PYMOwCvMlR2fYNYti8cbuajlVol2BfteE0Z90x5pROIk9/pyxZL8jVZLAaQzxYWlFshsLa49fkQS+5LryG5nkMEXAwGvf/SXb+gS6rXhmasdax+pK6c1lwul73T7PI+likoiAM9dNjM6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SMgVhkCxMB/x1bJSvVkZbRBla6ZhyMd25Bj968P+sE=;
 b=ay3r4a55IYAE6DnZoR+P5Tdy6Ab6hFE65BE2fTemsuTzQcPdtVZ8g0dD9jjoUBixn/7dLZJjaOLKBgOMyIuNDBwh3HhBPPT8T3dLzCIGL9cINCEkNaz6XgCAxthoBVPZh3VvUb7lvOyTJp1MDOhtL3FtB+GIOqxgr8BD0yJfPAAdmAjPwNyPWcm2hpZQIusZOeTFVXsvdaweeqN4vHYfZ63u11ln/80prv2czp6ZNwk2R2kulyNJ0krw/XtwPoN5QR6mt4A7pqua7iJj58B2jL1+nvEIPinIjaSgmYo9BYRCAWPDgFVj6lw9fm/r+J6AS2uuAvh+rCEneWuy/2HJHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
 by BN6PR11MB4020.namprd11.prod.outlook.com (2603:10b6:405:7d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Tue, 28 Jun
 2022 23:54:02 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::ddab:9556:f41c:48f7]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::ddab:9556:f41c:48f7%5]) with mapi id 15.20.5373.022; Tue, 28 Jun 2022
 23:54:02 +0000
Message-ID: <428f2b24-9fdb-5b6c-18b0-a783f449e379@intel.com>
Date: Tue, 28 Jun 2022 16:53:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH mptcp-net v3 1/2] mptcp: netlink: issue MP_PRIO signals
 from userspace PMs
Content-Language: en-US
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
CC: <mptcp@lists.linux.dev>
References: <20220628212918.417515-1-kishen.maloor@intel.com>
 <20220628212918.417515-2-kishen.maloor@intel.com>
 <cd551eb2-fff8-718d-3c3f-382cbf22a020@linux.intel.com>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <cd551eb2-fff8-718d-3c3f-382cbf22a020@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CO2PR04CA0188.namprd04.prod.outlook.com
 (2603:10b6:104:5::18) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:9e::21)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f303edda-8035-42e8-c113-08da596179e6
X-MS-TrafficTypeDiagnostic: BN6PR11MB4020:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: an3PREFI0CNoZNfeKjmvP60XmoM2NCLRvDjCHSFVV44tWepB37UHGFg2+hGvbD8g55Svih5wNdyAX+3f30/+fuLtycpMVNzqkYQjEx7NuRqs0tT/XLx3LxEgJnmTAMX/wU+f6UEZz+ORWr8Ai8c3vYRom1QFZv3GPfVixgm05uOjSKHYbfKPpOR5AUQ3V1EeNYwPitqdIZkR2OOREb52p/5fp7A8wv13uLid/vm+km2Wcoo1tSI2RXLzUZO6/NuLB6Rd+nFYdZlQXJPDsY5ZxgPbirA6VHQSh9eTErPMKJonozH5mk33r7XkQBedl6SFsL3AAj3O70YCD2z+WCVKPVDY8I6PloigZ/Ovk3VjGTtjJ+MyKlLlbiWymnuUuIjXyYxACW34uGsJVs8+bJbhr2HO15HbySI47ed/JB5BHHdwqT8bfX//fvaeimJb8YOYN71CrPgaDFas3+CMu4YCy7oPZiFvP3s5Le8bNfrJpPL5y7LpPGt6NxNkvSzXLRuIIfSgZJ1y3RkYwrhXQEzo9vDvoz6HHDmqA55mvZhuSJid6w0K6OA8tJOWc6CbvKu+MYGXQLrrozGC1uYO2SQvVWPfBCH0zdK+/9sf0WOZRT/IeA5Qyx0o6HAyJJY3I0oBqneXGqpiWWgyP1tFvM4ZTM/phRFFXfU/8PwST1M2KIh54Iy3ICLDQEntyhxaKN2eOU9iZtpXcoMWDy/s0K2woLRP45V/jHtqBlGxV13JyvOJtdH6ZVJnjZWo+i2e8BoPt8AHEVnfgeGkC8T2K4zJ9gSsMOPxp1WIvU+X1ZwlN37L3FkYuNiuncnIGXKa1JHczNm74To6qEEnoxMg7I1GCquTyfabPdpu4+ppTd1en7s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(39860400002)(136003)(376002)(396003)(36756003)(8936002)(6666004)(86362001)(5660300002)(2906002)(186003)(6916009)(66556008)(2616005)(38100700002)(41300700001)(966005)(4326008)(53546011)(44832011)(66476007)(26005)(31686004)(316002)(66946007)(6486002)(478600001)(83380400001)(6506007)(82960400001)(6512007)(8676002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFkzd2MrVmVPTHRTVk92MW9mSFhtZlV0bzhnNjBaMlVVRkJORklLellaOVpZ?=
 =?utf-8?B?ek5GbnNnb3E0TUlnZVoyaUErQWVlZVU3YzU5Mm1YdUFrdCtVVzRPUTJlV01j?=
 =?utf-8?B?bjdYUmFTdy9BTi9hOVBvTWJjbGxzR3YvdUJSODY5YXhHR1gyVHQrLzUySzlC?=
 =?utf-8?B?MVNlQ1pOMlJsdDdZNXBXRWdEeGxtSERSOEprV2xaa1EvOTkwUVZwcDk0VGFo?=
 =?utf-8?B?QzZPT3FGQVNVZHhXRVlPWXN2VzllWWphYmEwNndPbW1JeENjYmVvVGtMQjNK?=
 =?utf-8?B?TUJvOTBvaERFUU1iejAzZng2ZkpvWmpUbHZLbFE5dEtEdXZHeDd4aVRFYkM5?=
 =?utf-8?B?NVkxSXZELzgzSDN4MXlTSFNxZkI1aUpwRER0dGFMK3kwS2lXYUY2Y2l5YTQ5?=
 =?utf-8?B?bHVjRHh5S1l4cE1kMWRaZjNjMnRmaFZHT1dFdEFucnp0SzBlL0htT0xONUsv?=
 =?utf-8?B?N2VEWGhwT0VzODUyY3R6UGZTUkZ2a3h1VDZNQkkyc0ZpWndiY1NUckc3U2hT?=
 =?utf-8?B?YVZjZ2NHanEwei9va1UwZ0hEOFVTaU9FcTU0ZEMwc0FaWEhLc1BLYjYyMXNH?=
 =?utf-8?B?RCt0VnM0Mi9MSGsxZnYvYnA1VWd2QnZIREplNkJGNTkraS9CTVpVbkM4WFJ4?=
 =?utf-8?B?RXNUbkxQUUV2aVFEWVlJSzA1TC9uOGR4aFY1NkFEYko3ZElvT2UvLzRCMDB1?=
 =?utf-8?B?RXo1dHR4RFE3M0FDT1o4YjRRODd2L2FBZTY1eDVKZFJIMnRRZEE5OEYzTHNr?=
 =?utf-8?B?TVJiMFltUFVMMkpxdDZxM0lic3l2L0VTeE5JZjliODRoWWpjeEFKUnJkSEM3?=
 =?utf-8?B?djlOclVXZzQ4NnoxeVVrOE00THRkU0lKUVBEVEFCYlJxajhpNTlsd21aTCtz?=
 =?utf-8?B?VzR2dFNFYk9ROHEvVEphZ240NkR3MHFaNGN2bmhmVDhpWldFNVNhYmV6d1Vu?=
 =?utf-8?B?d1ZEK242cFRBNERpN0lrWFZKM1NUZFFSMDdrVVd6djBOdEdoMzI2Y2h1YzNu?=
 =?utf-8?B?MnIvYkpPcnIzUEZEMlFuaTNkV1BqSWR6TlNjNFhYSmhYSXQ5ejBSdzU5eCtF?=
 =?utf-8?B?b3MyVXZXbUVROWtGWk1qc2RwenhuNk1BVmcwZlQrdnExdnN3cG02dE51bE9T?=
 =?utf-8?B?WU5UOXE3YU1xL2Z1bXB3WXZaWEMwUUc5bnRPRkhQRG4zNVhKZ1hvaUJXWWNF?=
 =?utf-8?B?eHFZRUVKRmZKRmJxSTEyTTkyMUFNSjhvWnpKT3lLYndWQllXOUtLanFaL0xn?=
 =?utf-8?B?WklZUkxUbFVkYnBXV3FNZUc0UGRvdWNZUWptL2h0WEo5aEZrcmh0RDEzOEpP?=
 =?utf-8?B?Qk02MldpNTBSelpZSmtncWZpVFBjOEdvZzZqS21kd3pPeEE2NEZINHR6TEJE?=
 =?utf-8?B?OFJrYTExZzNZdDl4ZFdxcnFvdWE3UkdNOGw4dXA0Ynk4L2t0WVQ1bWtyVTht?=
 =?utf-8?B?eWgzOStSUWFLVjh3UzBac1MyZjRiRFY1VnFsRlZNbldlYm5kQ2c5YjJKVWdq?=
 =?utf-8?B?cVpvUmhQckdSRkluckI1dDRQQ2JwZlJxR2YxMG1adGNMQUJ2aXhqUUtNRHJC?=
 =?utf-8?B?ajliTCtucEQ0bjRoSzlqK0RoQ3FIUFE0WUZCemdIYi9RNGpZcU1aQkFXd2Zx?=
 =?utf-8?B?WmhOaVZkcU5aS2Q0WjBzVzEvbU5MSU9MMjV4ZEsxT3pON0JQMUJmbjZnTTAy?=
 =?utf-8?B?bDJUaThRVUVwcXhqUkpMbVRBUHh5MVR0RDhNYVNOTWZIcFpVNmJ0SVRGSEtx?=
 =?utf-8?B?d2JieCs4MG4yY1RiWFIzQjlzYlpaZzhSZXFlSnBjbjZSeUZ2NHh0eW1DN1NW?=
 =?utf-8?B?UkMrWUUvSTZ0SkF4WXFBYmswR2NUaXRpdWRDTkYyekdtYk5oYkpHMWk2ZGVK?=
 =?utf-8?B?SldaNEZYcjVvT2xBbVRSRW5QZmNPN3hBb2ZkeEI2eWV5NnlwcmszSndBQ0Zl?=
 =?utf-8?B?K0hXSGE0ZXBrUHp6ZGI3RjdZM3NTd2pnVTZwcU1nRkxHWmpoTUtVZVVhQVFM?=
 =?utf-8?B?NVY3a1lDeVRVQ2FURnR3QTkxYmp1WXpBYjU4VWpjNmJpcWF6M0dpWmNNR3RL?=
 =?utf-8?B?UkwvUFZKQ0U2NXdtZjY2aGtZV28rWVZ2TFUrTzA3QTdzcGZENnQ4eXk4Rmlv?=
 =?utf-8?B?bExVOGx3VU0rM20xTjNoUUUyazFzZk5vNHlrWXlKNzBOWkFrZmdUZGRXUDBx?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f303edda-8035-42e8-c113-08da596179e6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 23:54:02.0399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrpypIzaUJtrkLKBXSw8sXJxynGjdVhpGnP2jnMOn2aRxSUsELvOjq1fqZn89jpeTF/gSXiIASYuEW6aTtzQXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4020
X-OriginatorOrg: intel.com

On 6/28/22 3:57 PM, Mat Martineau wrote:
> On Tue, 28 Jun 2022, Kishen Maloor wrote:
> 
>> This change updates MPTCP_PM_CMD_SET_FLAGS to allow userspace PMs
>> to issue MP_PRIO signals over a specific subflow selected by
>> the connection token, local and remote address+port.
>>
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/286
>> Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")
>> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
>> ---
>> v3:
>> -use local and remote address+port (instead of address ID) alongwith the
>> connection token to select a subflow.
>> ---
>> net/mptcp/pm_netlink.c   | 30 +++++++++++++++++++++++++-----
>> net/mptcp/pm_userspace.c | 30 ++++++++++++++++++++++++++++++
>> net/mptcp/protocol.h     |  8 +++++++-
>> 3 files changed, 62 insertions(+), 6 deletions(-)
>>
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index 05c6a95e9c28..602892f2f921 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -717,9 +717,10 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
>>     }
>> }
>>
>> -static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
>> -                    struct mptcp_addr_info *addr,
>> -                    u8 bkup)
>> +int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
>> +                 struct mptcp_addr_info *addr,
>> +                 struct mptcp_addr_info *rem,
>> +                 u8 bkup)
>> {
>>     struct mptcp_subflow_context *subflow;
>>
>> @@ -728,7 +729,7 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
>>     mptcp_for_each_subflow(msk, subflow) {
>>         struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>>         struct sock *sk = (struct sock *)msk;
>> -        struct mptcp_addr_info local;
>> +        struct mptcp_addr_info local, remote;
>>         bool slow;
>>
>>         local_address((struct sock_common *)ssk, &local);
>> @@ -736,6 +737,12 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
>>             continue;
>>
>>         slow = lock_sock_fast(ssk);
>> +        if (rem && rem->family != AF_UNSPEC) {
>> +            remote_address((struct sock_common *)ssk, &remote);
>> +            if (!mptcp_addresses_equal(&remote, rem, rem->port))
>> +                continue;
>> +        }
> 
> Hi Kishen -
> 
> Thanks for the v3!
> 
> The CI build failed because the ssk lock is not released before this 'continue' statement. The sparse error message was pretty vague, though.
> 
> remote_address() is only checking sock_common fields that don't change, I don't think the ssk lock is required (it's used this way elsewhere in the code). So this new hunk of code should be before the lock_sock_fast() call.

Thanks, Mat. I just happened to miss this while resolving conflicts here during my rebase to your series.
I shall post a v4 shortly.

> 
> 
> - Mat
> 
> 
> 
>> +
>>         if (subflow->backup != bkup)
>>             msk->last_snd = NULL;
>>         subflow->backup = bkup;
>> @@ -1839,7 +1846,7 @@ static int mptcp_nl_set_flags(struct net *net,
>>
>>         lock_sock(sk);
>>         if (changed & MPTCP_PM_ADDR_FLAG_BACKUP)
>> -            ret = mptcp_pm_nl_mp_prio_send_ack(msk, addr, bkup);
>> +            ret = mptcp_pm_nl_mp_prio_send_ack(msk, addr, NULL, bkup);
>>         if (changed & MPTCP_PM_ADDR_FLAG_FULLMESH)
>>             mptcp_pm_nl_fullmesh(msk, addr);
>>         release_sock(sk);
>> @@ -1855,6 +1862,9 @@ static int mptcp_nl_set_flags(struct net *net,
>> static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
>> {
>>     struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, }, *entry;
>> +    struct mptcp_pm_addr_entry remote = { .addr = { .family = AF_UNSPEC }, };
>> +    struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
>> +    struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
>>     struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
>>     struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
>>     u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
>> @@ -1867,6 +1877,12 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
>>     if (ret < 0)
>>         return ret;
>>
>> +    if (attr_rem) {
>> +        ret = mptcp_pm_parse_entry(attr_rem, info, false, &remote);
>> +        if (ret < 0)
>> +            return ret;
>> +    }
>> +
>>     if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
>>         bkup = 1;
>>     if (addr.addr.family == AF_UNSPEC) {
>> @@ -1875,6 +1891,10 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
>>             return -EOPNOTSUPP;
>>     }
>>
>> +    if (token)
>> +        return mptcp_userspace_pm_set_flags(sock_net(skb->sk),
>> +                            token, &addr, &remote, bkup);
>> +
>>     spin_lock_bh(&pernet->lock);
>>     entry = __lookup_addr(pernet, &addr.addr, lookup_by_id);
>>     if (!entry) {
>> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
>> index 26212bebc5ed..51e2f066d54f 100644
>> --- a/net/mptcp/pm_userspace.c
>> +++ b/net/mptcp/pm_userspace.c
>> @@ -420,3 +420,33 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
>>     sock_put((struct sock *)msk);
>>     return err;
>> }
>> +
>> +int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
>> +                 struct mptcp_pm_addr_entry *loc,
>> +                 struct mptcp_pm_addr_entry *rem, u8 bkup)
>> +{
>> +    struct mptcp_sock *msk;
>> +    int ret = -EINVAL;
>> +    u32 token_val;
>> +
>> +    token_val = nla_get_u32(token);
>> +
>> +    msk = mptcp_token_get_sock(net, token_val);
>> +    if (!msk)
>> +        return ret;
>> +
>> +    if (!mptcp_pm_is_userspace(msk))
>> +        goto set_flags_err;
>> +
>> +    if (loc->addr.family == AF_UNSPEC ||
>> +        rem->addr.family == AF_UNSPEC)
>> +        goto set_flags_err;
>> +
>> +    lock_sock((struct sock *)msk);
>> +    ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc->addr, &rem->addr, bkup);
>> +    release_sock((struct sock *)msk);
>> +
>> +set_flags_err:
>> +    sock_put((struct sock *)msk);
>> +    return ret;
>> +}
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index 033c995772dc..480c5320b86e 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -772,6 +772,10 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
>>                    const struct mptcp_rm_list *rm_list);
>> void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
>> void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq);
>> +int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
>> +                 struct mptcp_addr_info *addr,
>> +                 struct mptcp_addr_info *rem,
>> +                 u8 bkup);
>> bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
>>                   const struct mptcp_pm_addr_entry *entry);
>> void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
>> @@ -788,7 +792,9 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
>> int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
>>                            unsigned int id,
>>                            u8 *flags, int *ifindex);
>> -
>> +int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
>> +                 struct mptcp_pm_addr_entry *loc,
>> +                 struct mptcp_pm_addr_entry *rem, u8 bkup);
>> int mptcp_pm_announce_addr(struct mptcp_sock *msk,
>>                const struct mptcp_addr_info *addr,
>>                bool echo);
>> -- 
>> 2.31.1
>>
>>
>>
> 
> -- 
> Mat Martineau
> Intel

