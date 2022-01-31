Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE712C82
	for <mptcp@lists.linux.dev>; Mon, 31 Jan 2022 22:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643667737; x=1675203737;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w2Xh+T/j5Q4oT5KAKv3GM12+L6wTmPEPsTIUQo1DwOQ=;
  b=U2+hoEcmyK35vZMUxKEDU64wB6egVwqiWJI0Yuzn0nKSvhGaLW2Sp0Kv
   t0+mCzM87q8jFkReRhjwDHsOcGRNxBOJXe6bLmk5FuYOkvzA+TJA7Rsn4
   qYM8cduovPIgDKJ4NkPXgZ1sinNYK3D/XYRn5Dxb154m9/8NXSKR9xz35
   Wo94gcIdHSHXSulFwL6GlhV3tPhC7ehrToFns6jtADIyZ3HKoh5dDiM15
   NsXcR70jPDTO2xMN5ZdLKgzaxAKfXBzLMBeqKSNQV4LzxthsREBtMnChF
   9s9fbUzVZFNFPMeadCIOUFeOUnYIc6Ii3AkUwSZIsJ0ynvNOEagkabRy9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="246396612"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="246396612"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 14:22:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="497104912"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga002.jf.intel.com with ESMTP; 31 Jan 2022 14:22:16 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 31 Jan 2022 14:22:15 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 31 Jan 2022 14:22:15 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 31 Jan 2022 14:22:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRslo7L30bq6iGZMTv/ZmemNg2p4+V4RCNpdyrzLEiDMSHfeENn6TnviwR7qDe5GNRkqtMdZ2/Hn1qi40LChEoZe2kcaStB6r11mozI+m0erbpk+mLN0/TtPTRk2hXmefAiD4x6PUYdVho5B+u4bcChzdqhdRiphT4oxVC0fdDnLhvb6+IwN/rAisph6REGQ4qp4LkvJ+qshEPNf97n7aTtisccsFGulYmX97b1Vhw4/b0zIN3W1We8RX/dLjdkyFMtUJu4cHJ4rPMzTPZxLnRGWvoAqklpYY97h/kJQKOx+Ixwp+kqlbYTi4XxrWrFjTt2sFqESlQ12GUqD02m9pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyGWWxtw1965WaBQ0rr6pn6pO623LSiXLKefYM3/i+8=;
 b=CTd9p51yBLXVIwuZQ9BM+OYwQjRno5zPMWncEW3lPgduTSlLyWC/ixbCCHZTpvzj/SByg+Or4uWGdp3a/1OIhwu6pEN8dRtR8x1qV8bJYycYirFX1poxCHIG1hFmTKqLLuzHduwtSBnX/l7JsvSc9NpxYWrIjwq7OOQFuWQn5EJQ8BaYsDWk2xcuPRwaIfz6ULB9pFS+GNc5Ecb/IP3GK2D1sc5vSo07CcKNCJc3RLhM5AwrlW+vrGnkXmMI/5iV7ci2r1J5GuhPcpouGxgWjBOU3np6aYvnQ/VdeYbWY8di/ivFUhCjyiHsK62tVkqDtSFoUcg0ELFA1HBaHwSVYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5145.namprd11.prod.outlook.com (2603:10b6:806:113::6)
 by MN2PR11MB3597.namprd11.prod.outlook.com (2603:10b6:208:ee::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Mon, 31 Jan
 2022 22:22:13 +0000
Received: from SA2PR11MB5145.namprd11.prod.outlook.com
 ([fe80::992:6137:3ea3:6cfd]) by SA2PR11MB5145.namprd11.prod.outlook.com
 ([fe80::992:6137:3ea3:6cfd%4]) with mapi id 15.20.4909.019; Mon, 31 Jan 2022
 22:22:13 +0000
Message-ID: <31e424bf-fda9-0590-77e8-e36edba35a94@intel.com>
Date: Mon, 31 Jan 2022 14:22:11 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-next v3 3/8] mptcp: reflect remote port (not 0) in
 ANNOUNCED events
Content-Language: en-US
To: Geliang Tang <geliangtang@gmail.com>
CC: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20220128003812.2732609-1-kishen.maloor@intel.com>
 <20220128003812.2732609-4-kishen.maloor@intel.com>
 <CA+WQbwsXeN-gCRksSZ_BaK8W8byzTFiqsfgc3tbcQT3=CS7V1w@mail.gmail.com>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <CA+WQbwsXeN-gCRksSZ_BaK8W8byzTFiqsfgc3tbcQT3=CS7V1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0337.namprd03.prod.outlook.com
 (2603:10b6:303:dc::12) To SA2PR11MB5145.namprd11.prod.outlook.com
 (2603:10b6:806:113::6)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e600c9ab-f394-4009-d5ed-08d9e5082170
X-MS-TrafficTypeDiagnostic: MN2PR11MB3597:EE_
X-Microsoft-Antispam-PRVS: <MN2PR11MB3597851DC67DE1B614B71743E1259@MN2PR11MB3597.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MEdGhwY2tLKhbc905b9+WppefVKK4PrK3yZSGBHZyycVZl+Ztx2cimutcAu4e1TzIe/tQsb48pE8aDTHlQYfscZoZ5Q2z3jP5/dbinjfIHI67+OnH0bE6YHr9olqfi10orDsxRUcmbxPZRIpxrdpD5eYNej09F1RbtGG1DNRtpAxQjHsGoV4Ky6FmgRquqC+LmUw/RX/93Pva0dXPjhIhQ6kAQamQxHXT5YVyhQSwC46RDcg0VzXAaLYku5gk/qlpeFmQtKXUAKAtIqtWUyk71jIPGvbj3KHvpBdtmrE6aVlY+qjt9qhAD2bJYdZBCYlWF0zdcg4/mTpxR4SDy+HrvE7uvWDsXBMiWtrp7QKIjR/rkBJzsYfUA6sdxq9upm0BrcGedBPbOKXtWw6lNeY7HVtQu1Jd6Z0OHyr9HUn9rbxJkBJKhhaYVEipWzUYEmGLX9BSsy2k374j5w+dlZOcEMCNVS2GiWWjyEUWh+3LqF0ZEgZjDaWzQK839QTLxHCHVRt4MRd3KDj0Lncj8Ll5tHzGZjeruP8ZtbNlTzoPaSh4K8N673FKdslN4NzMkpM5LzmKhPY6lfI53uVD/tpXWKkJTgWiYiY8zOEb+fOJS4fRJWb1lP9fp2bBoehopXZiL/SWfDGLvaVDeG1vfL//8Ic9G+uFQzXcDWwkgXgrQbYdd1NHgkRMuL7tBkF7OfJPMtipqT9hHhqfcnNjuG2ybmJx1r6+ovFNkRFMWn3Z0A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5145.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(66476007)(66556008)(31696002)(86362001)(82960400001)(38100700002)(66946007)(8676002)(4326008)(6512007)(5660300002)(53546011)(6506007)(508600001)(83380400001)(36756003)(6916009)(316002)(31686004)(6486002)(2616005)(2906002)(44832011)(26005)(186003)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkFpSUVzTjFaSmhqQmdsQnQ0NGc4NittK1pMTXVLNHhiVndlRWJaQWJGVjFw?=
 =?utf-8?B?NTBYYkpJK1kzSGlGSDdWdmcyc2NVTk1Nc2xxNDFGcWJ0U2JnWDU1bzlEa3Mx?=
 =?utf-8?B?ekFZNk1lODRUa3BOUk1LcDdnQjgrSE9OZnREY253eEhvSHA2S1lFbzZDdEtU?=
 =?utf-8?B?Z3NPQVZYWGNQSXFmVXhLLzJnTXpxS0d1SnB5eHZ3cmNwTnplSDdodmpLcHBV?=
 =?utf-8?B?U25KdW51eStuUjh4WWxGOVRzTUpqeXh6cjFqSWlRZWpOZi93UUNXdnlXUTBw?=
 =?utf-8?B?a3E1UUZiOGREVEp6cnRWRGtBb0dLdktnTnQzM3BBcjllbytqa0tlRU1Vbmds?=
 =?utf-8?B?SytOMXBkVmFzMGtJQWZRNnpKVU0yY2tweTk1ck9LQTdOWjd1VjhwejN2dDh3?=
 =?utf-8?B?aUlwUHZsY1IxbHFIUmNmRldTS2lrRk5heHNYRjJSN1ZaVUErSlFCSEJtT1VX?=
 =?utf-8?B?dnpGdURUZXJweHJXR1hxVDVJakpqT3QrVGxDZHdjOUxKaFVzbkp5RVpya3I1?=
 =?utf-8?B?a2hBOGJRclJ5a3FxNFU2TzhzRk8wbGNlajl3b1hCNFJscHF0ZytZaDZUblhs?=
 =?utf-8?B?dXJEN3FoaDRGSVBIVGd4NEZLVkxBTWJsdGVRWlZ5QVNYSExlemMvMCtwYlgv?=
 =?utf-8?B?Wk9GUGJRVlFyNnpRNFA1Q001bzVFZksxeHBSd1ZCSG1CUTRpS3RZVzBoY1d6?=
 =?utf-8?B?SHBTeEYzNE9ZMjFyMTlpMTg1V0RJS2ZnK2hZejJwVFdaYzlqZnNrRjRjbFRN?=
 =?utf-8?B?ODB4UzByOUZlMGpkS0E3c0xWZzNITW1tbkFOSXIxWFhkZmhWZ3JHT0h0YTNR?=
 =?utf-8?B?aEpNSEpsWE56VWJCdmtPNVpyTjJIUmFyMHhGRHlra0lmMjR6TTUwcXFwMXh4?=
 =?utf-8?B?dkdYdFY0SGZMbjV1T3ZCbm9GUHlRRDFBczlDUmlFVk81UkxxU3lyNHlHSlRH?=
 =?utf-8?B?WnY0emx6MS9OL0FmbzhidkR1Qk9hVEk1Mjh1SmpjZ2pBTDZqNURTczVtOE8w?=
 =?utf-8?B?dStzTWRGS0lhT2lqUmVEcmZHVGEyMGsvazFiMCtRbzFzUnl5YnZVczJsM3Ur?=
 =?utf-8?B?MXpMRkkwOVFYdGd4V2d4OEhRSjIrVDFBeHBsVi96aS9pUGdwT0t4WWRBNGMz?=
 =?utf-8?B?LzlhYlZoaEUxOWg0STQzS1Vna2NYV0x1NDVaa3lXS0trMERLZUl2UGhsRDZX?=
 =?utf-8?B?amhFanE4RVJRNVFBd3ZtamZUdlBwTzNOUGZYRXBIdWR0RnhKcUh0b3hZY01w?=
 =?utf-8?B?UTkvSDR3KzA2Q3gwcXpvanQ1anpwU04zOTQvVDlReEQxNDRFRC9GUm1Mciti?=
 =?utf-8?B?ZEsrbXNITlpLQlc2VThJUFdZTjZOT05jQkREeEp3K09IUlFwQWcxd3RUc29q?=
 =?utf-8?B?R3loZWU4MldXOG8vdi9wUEk2b1BmT0ViOHZHWm0yR3phT3pySFRlWkpBVDhi?=
 =?utf-8?B?cDRnWkZKQ0h0cGs5Wjd3ZWgrZnhjMzdRTHhMT0Z6UTZaR0IvcDU3SEo3Ty9k?=
 =?utf-8?B?R1JDUlFnMFBkOHFRbjdnRFcvWkZRNlZtdWJhRG9CdHNERGFkMWZKc09qK2px?=
 =?utf-8?B?TDBYSms5TmJrbzZ5SVVEZGtXd1o2MVJwUDRXTm1TS01DL1BIWjRXd25XbTA1?=
 =?utf-8?B?cDQ2VEhXV3dNSUV3VXk5dmxwclRtT0plblBqYnlHNThCM1FEd3pFaW5TK0t3?=
 =?utf-8?B?VkFielVGcEs3Wk1LNUlyQjhTTjQrdnJEdTQweE80S2Yzamw5Sk0rdWZENG92?=
 =?utf-8?B?YVRLeDNkZVcwV09ORmJuWkNzMDlUc1NQeEVsTW9XNDFGOGVlT2hUQ1c1VEYx?=
 =?utf-8?B?bDhieVdoa3lidWtlMXplcU5ncFprNjluSXgzWWRwcm13Q2VnWUZTQjVJZXEr?=
 =?utf-8?B?NW5EQzBFR2hTMmF2b29sWGJFeUtmbkxCTXNVdy9Gald2SmxLK09ORzZtamtp?=
 =?utf-8?B?VXFiUDBJUWx5bG5vSTZYdklGOVJMU2hvOE1uamlhM0F5SFNRRDdGYXZoSGdD?=
 =?utf-8?B?KzFPSUpJNVJZU3ZIcDBLNWtMa0orelhMNCsvRW5ldktTajJiZi90U3dGMytt?=
 =?utf-8?B?UThKMXpNS29PemJsU0lHcDRERk43YnJnRmJuNVZJLzBzSUltSCtwSDhqaTZT?=
 =?utf-8?B?eHQySFFxWEJVS0kveHRxSDJNWnJONnVsMjNKT0M0RmZvZGpiMlJuRFJpMmhM?=
 =?utf-8?Q?KEehlMURmmgcc6nXjND2bVU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e600c9ab-f394-4009-d5ed-08d9e5082170
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5145.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 22:22:13.5677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VJ/YBJVjfj7W69FSjVejGFkHOkheqYlbtW/IBcUkEmFNGpUhgExbQLS9QIbjAtydhWX1FPEJECeXlF3cZ0TF1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3597
X-OriginatorOrg: intel.com

On 1/27/22 8:07 PM, Geliang Tang wrote:
> Hi Kishen,
> 
> Kishen Maloor <kishen.maloor@intel.com> 于2022年1月28日周五 08:38写道：
>>
>> Per RFC 8684, if no port is specified in an ADD_ADDR message, MPTCP
>> SHOULD attempt to connect to the specified address on the same port
>> as the port that is already in use by the subflow on which the
>> ADD_ADDR signal was sent.
>>
>> To facilitate that, this change reflects the specific remote port in
>> use by that subflow in MPTCP_EVENT_ANNOUNCED events.
>>
>> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
>> ---
>>  net/mptcp/options.c    | 2 +-
>>  net/mptcp/pm.c         | 5 +++--
>>  net/mptcp/pm_netlink.c | 8 ++++++--
>>  net/mptcp/protocol.h   | 6 ++++--
>>  4 files changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index 0d0d2eb8c8ca..0d3c8f7e5be6 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -1132,7 +1132,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>>                 if ((mp_opt.suboptions & OPTION_MPTCP_ADD_ADDR) &&
>>                     add_addr_hmac_valid(msk, &mp_opt)) {
>>                         if (!mp_opt.echo) {
>> -                               mptcp_pm_add_addr_received(msk, &mp_opt.addr);
>> +                               mptcp_pm_add_addr_received(msk, &mp_opt.addr, sk);
>>                                 MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
>>                         } else {
>>                                 mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>> index 6b6220895929..e5d5cb847209 100644
>> --- a/net/mptcp/pm.c
>> +++ b/net/mptcp/pm.c
>> @@ -200,14 +200,15 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
>>  }
>>
>>  void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
>> -                               const struct mptcp_addr_info *addr)
>> +                               const struct mptcp_addr_info *addr,
>> +                               const struct sock *ssk)
> 
> I think the better parameters order of this function is:
> 
> (struct mptcp_sock *msk, const struct sock *ssk, const struct
> mptcp_addr_info *addr)
> 
> Put the new parameter ssk just after msk.
> 
> Furthermore, I think instead of adding a new parameters ssk here, it's
> better to change the parameter msk to ssk.
> 
> We can get the msk from ssk like this:
> 
>     struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
>     struct mptcp_sock *msk = mptcp_sk(subflow->conn);
> 

Thanks! Your suggestions look fine to me. I shall reflect this in v4.

>>  {
>>         struct mptcp_pm_data *pm = &msk->pm;
>>
>>         pr_debug("msk=%p remote_id=%d accept=%d", msk, addr->id,
>>                  READ_ONCE(pm->accept_addr));
>>
>> -       mptcp_event_addr_announced(msk, addr);
>> +       mptcp_event_addr_announced(msk, addr, ssk);
>>
>>         spin_lock_bh(&pm->lock);
>>
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index 93800f32fcb6..f90e77c3775d 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -1972,7 +1972,8 @@ void mptcp_event_addr_removed(const struct mptcp_sock *msk, uint8_t id)
>>  }
>>
>>  void mptcp_event_addr_announced(const struct mptcp_sock *msk,
>> -                               const struct mptcp_addr_info *info)
>> +                               const struct mptcp_addr_info *info,
>> +                               const struct sock *ssk)
> 
> Here change the parameter msk to ssk too.
> 
>>  {
>>         struct net *net = sock_net((const struct sock *)msk);
> 
>     struct net *net = sock_net(ssk);
> 
>>         struct nlmsghdr *nlh;
>> @@ -1996,7 +1997,10 @@ void mptcp_event_addr_announced(const struct mptcp_sock *msk,
>>         if (nla_put_u8(skb, MPTCP_ATTR_REM_ID, info->id))
>>                 goto nla_put_failure;
>>
>> -       if (nla_put_be16(skb, MPTCP_ATTR_DPORT, info->port))
>> +       if (nla_put_be16(skb, MPTCP_ATTR_DPORT,
>> +                        info->port  == 0 ?
> 
> Here two blanks before '=='.
> 
> Thanks,
> -Geliang
> 
>> +                        ((struct inet_sock *)inet_sk(ssk))->inet_dport :
>> +                        info->port))
>>                 goto nla_put_failure;
>>
>>         switch (info->family) {
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index c47d69a42fcb..d20c65fcba89 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -753,7 +753,8 @@ bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk);
>>  void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
>>                                  const struct mptcp_subflow_context *subflow);
>>  void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
>> -                               const struct mptcp_addr_info *addr);
>> +                               const struct mptcp_addr_info *addr,
>> +                               const struct sock *ssk);
>>  void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
>>                               struct mptcp_addr_info *addr);
>>  void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
>> @@ -781,7 +782,8 @@ int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *
>>
>>  void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
>>                  const struct sock *ssk, gfp_t gfp);
>> -void mptcp_event_addr_announced(const struct mptcp_sock *msk, const struct mptcp_addr_info *info);
>> +void mptcp_event_addr_announced(const struct mptcp_sock *msk, const struct mptcp_addr_info *info,
>> +                               const struct sock *ssk);
>>  void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
>>
>>  static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
>> --
>> 2.31.1
>>
>>

