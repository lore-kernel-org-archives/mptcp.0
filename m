Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D63329CA
	for <mptcp@lists.linux.dev>; Tue, 21 Dec 2021 07:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640071763; x=1671607763;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=uB00kjBr6O1ATmDvjmj/1pJrlEnIfFH6SFGPR1rBCXY=;
  b=aUgllryic1yHha651CpdPHtBoVMb+Lp7R43u7fEbk8KUGZBmmYgq+lA8
   Kjo6B+bE7jhjDalloY4iWFR3xYxDdYx9NX2DN1f/wy5lE2GO1PtbkbV2g
   Q7I8/g7xL6b4wAxeb0+5TSk4LequpnMlVso69XeeeKagz/BnQAm5tMVYU
   z46I92ZaeyiQW+rwu+M9xS2+dGZNLqPoTKbHZ6XbDj+oG9liljMTOs+fb
   Ki+zmawx5IDTJg428NR3qiwRj2ZCbwJgJAGuK+1vH+OC+RBNFt8gfut9J
   ZpKTdJuCz3tlID9k2Xtt3iTY+RIA8ZYO8orpYi7rBpWP0Fz1JBNqAaBkr
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="237881905"
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="237881905"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 23:29:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="521650711"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 20 Dec 2021 23:29:22 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 23:29:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 20 Dec 2021 23:29:22 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 20 Dec 2021 23:29:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OccEBU+y9+B/PRQKSJl4Q8QqlKArji8920cfHoY6la49lttuOXUawlA5uIRblqgH3EXUN3kdkz5DzLmJOxkVDo2RF8Uqo7dkwd3e0jzKRCrX5XVNqPvmysBVe4wy99R9gmy7YFVjqF+6GBVgRGuw+kq07gfakaVghYllFiUdIw1cYjZdB5WTClMzvyGoe80Scg9sPaHSvf1HF2If8ql0dVJ4/nt2y39jq51bdq4yBihksU4NFVrZrVQjDyxRzp6p0J75R4DhDJJ6cK/6XT6q/OVkPDtRT3XcaQ/D3nfqePwRPuudPauuZV+0TJufBQcah46esm99D+IEq0Ftyployw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ChQi5Tf1I86yj3pHwPyrpd/DgH5GWnOuEBB8cxxv3k=;
 b=VMN+UF8pec8X3/DhAOnoKmqzh/C9+rsA/xtTvp4fvjzJXY4WdY0C516xqg+n+Aa2t3ahGz2MnAR/RAJOVvI2OXeiK7pT3fqmsAg6EGOij2PkgXs/XofJ4m2ITMj0NrBkRp4zyDMJbL2ZuVx8Nmb2O4WiNYYvJb6RkIcnB4ys/kbESo9Pd6It4Qxb8Og3IwaCQSgwnwt1GxGVZzWRle94ZxfL59cU2HT+ULGArjXMsbAnd/b5p8aoOsTRYMpRWfAYAOR1QJENJf74DEKq8rtr6q3odtsGkfj750goJXhxrCsk3A4EYH4rnYydHjuhnzV8oZHkYuhB6EXLAI3MsOLNlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:95::6)
 by MWHPR11MB1550.namprd11.prod.outlook.com (2603:10b6:301:b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.19; Tue, 21 Dec
 2021 07:29:17 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::c41f:17d7:bed3:7888]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::c41f:17d7:bed3:7888%9]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 07:29:17 +0000
Message-ID: <c61a30dc-a669-cb2d-7981-69c7a36040a3@intel.com>
Date: Mon, 20 Dec 2021 23:29:14 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH mptcp-next 06/21] mptcp: netlink: store lsk ref in
 mptcp_pm_addr_entry
Content-Language: en-US
To: Matthieu Baerts <matthieu.baerts@tessares.net>, <mptcp@lists.linux.dev>
References: <20211216222314.1244708-1-kishen.maloor@intel.com>
 <20211216222314.1244708-7-kishen.maloor@intel.com>
 <b3039ba9-934e-0090-f5cd-66d4d11c959a@tessares.net>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <b3039ba9-934e-0090-f5cd-66d4d11c959a@tessares.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:217::13) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:95::6)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2cfa3f8-ee50-4449-e41e-08d9c45398a6
X-MS-TrafficTypeDiagnostic: MWHPR11MB1550:EE_
X-Microsoft-Antispam-PRVS: <MWHPR11MB1550F77C8DBF62A1DCE44DECE17C9@MWHPR11MB1550.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/i5F4T8keadHk4zlYgAZyPD0rihGIb9QXYHUqbgMsnCjUAoo0acqRCoyAanrzHCjEP1DdhBcWgDuHJQKondmK0oMpKQSGLq3Mdo34c4Bzs8hDeHek73y4/VC0iV47jeOb85OnuT3KYvaWEliJhFkbRU72twynsml6okEgfhDUqJ0Lj7WrfXtx+IATeyeNnjDU2+2d8GZVRxH1P0zom2gtzf/R/1apdKJY/7UJpG+uWj2LOhYQ3F3DnYEa/fKPldeLVqk2nn5U6cNi/Ar4j8htctHu9sL12xy5QZNyDyONGAVqgo4ROovfPs7tfRyiEckOBu02L3ePGVQOmiDBCGQABAmIBlgdEDrrR7Vi5wi2LGE09NHVxdcE/M7jEJBzFxJUfcwWTa8NboI2rtLwIKZlB2R6CswTejP5U4TVWPsc/1v1YvN9cLWKXNnE3kOzkMG/QcUtmOcTlYQu7HOpvQuAUEKVUVjbo/LOyqb7TBpui5YoBKAazjWKj5YW3dwJZBYl/aAq5co1nMnG296nTDds0rfg+Gc/bGw1AQT6+UES8PT7JL+fcGmII/tl+a6VqQspE9xwYI9XdVXYXEYc4spHYzdIW6xw+cwZDcAeC5q3jvRP9EQXdYSXFdqDmWtaCf6DQvzbxaU34Kmkl86hqB6q5YmD0uSzqVG10+BKvZEap9p7I9s3+LPz4Si8Px/sUCt7FPoQunTnhVmlyirt+U/HKBCpJ0/Rf0Ns4ovGZ9RpQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(8936002)(6512007)(5660300002)(508600001)(2906002)(6506007)(38100700002)(36756003)(186003)(2616005)(53546011)(31696002)(82960400001)(66556008)(44832011)(31686004)(66476007)(66946007)(6666004)(26005)(6486002)(83380400001)(316002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU1lcjd4ZFJXcFg0cDhSblJCdmp3SmJxQ0ZCOS9Ed2ZWY2lOdytudkFBNXB0?=
 =?utf-8?B?Z05MZnVTM0wwL1d1YktFZ251Y3ltSjZVY2xoZHZMRFlCd29ISW02Q1Bxd3hE?=
 =?utf-8?B?NkRuY1BEMnlPUk1WUFdMTXVHSWYwM28zZ1ZDZ2Q3SWxJSGtQNWtraHBKS3h2?=
 =?utf-8?B?OGRMRzBIbzErU2ZZWDJ1ckxPcWNieU9WZTFRZTRiV3V1Q2kyOTAyQ1BOUkVC?=
 =?utf-8?B?SUJ3Z1U5K3VLM0c2ejloN2drUlJZZFNTbjBpS0hDMnBURUVOVHZnV0lLOHEr?=
 =?utf-8?B?aDdDc1FIcVFoNHk3S1RCMFFDV3FCWTVOSmJTTXg4dVB1blAwSHNvd1hUWERX?=
 =?utf-8?B?azhCZEhIVmdFTURZeHBLWUladmh5S2s1dGdYc2JQWEliZUNQak10ejNHdXY4?=
 =?utf-8?B?TWlsOVZOM3JXTUxNbXlGNm5EYndXUFFsOFFJRDNlbklockZqTTA5aTlwQ0NR?=
 =?utf-8?B?Y2FFcUlEcGFLdVF6UU1JK0NSOVlKOWd6bEdJMWdrRE92ai9JRGN4emlzZnds?=
 =?utf-8?B?NTllK3hXVzZrN1hmWU93V2JLSlJwcEJURU04UGNTZjdEN1dlclp5OW42Ky9Z?=
 =?utf-8?B?VEQ1VGs0TmFHeXZxbzJMdHhvUUUwZ3ByVVkxSm5Eb1cwK2pNV29GUXlycllv?=
 =?utf-8?B?VmsyYTlpdTIrdW9IYlA4RHltb0R3TTA5SThHd1Z4eXh4anpmdnp2ckw1UHZ6?=
 =?utf-8?B?Z1BWdHZTRm00TWRYbFpGMER5My9nSzl2V0VkdEZzWHM4eWozaTE0eGdrOUVH?=
 =?utf-8?B?WU9MVmYvbVdPS09jdCtZU1ZRWExhb1ZKazF6WDM0Vlh3Vms1cHduUkZYOW9J?=
 =?utf-8?B?U0FBYzhCVUdwak00T1JaR3BROGNJdy8yWEp2NUtsRFluT2psY09XQ0JhYVN5?=
 =?utf-8?B?NWdRdU10Y21FbzhqRVVCUTMxODhZK29PUm9mMU16QXVrUUpVa3FUSHBxRUZK?=
 =?utf-8?B?RUZoU3djVkpYeXhWenZxWFNyMnc0U244SGdOblpiaXlvQkIrZ2xIU2grYUxi?=
 =?utf-8?B?c2xrNnZ1WVBQa291aktkS2pLUFN4a1p0cnp1a2NqSkQ4SEZXRzZkWGh3dm5n?=
 =?utf-8?B?R1J4aHUwaFpMRERUR2FLOG1xNHEwNlllb0xBQlZoRDMzM0xQRmhmWEdJWWYw?=
 =?utf-8?B?WW5xR3NhUVJ1SjBONFlDSjN4SUw5UDlyYUR3UFVleXdYaTdDMjJSelVoNW1p?=
 =?utf-8?B?Z1RTUEVRUjdnTDhyWXp0WEJ4SW5VZjEzdVg3WjhoaUZkRmh1eGVmTjhBZytM?=
 =?utf-8?B?RmlKRTVRNXRYSTBCRkZ3Y09CSE93SGhsM0FmSmYweW45b1RhcmdUdXdRRGx3?=
 =?utf-8?B?bENpRWxvR1FjTXVIcFF3c3B0WmpoL3BNWStHcmNHVHV2aXIyd2llbi9SY3hk?=
 =?utf-8?B?R01xRUlwZFNrR3AvYUlMWDRBTkcvL2JFZ0Y5eFE2YklVR1ZycDRnZkh5Wm5s?=
 =?utf-8?B?eTBSbTVSbzFOcS9YbWZ0ZE5vYTQwNWxSVzZaYzB0ZWVFZjZsYk00QXpDVHNL?=
 =?utf-8?B?NlNjQkc5a3VaQ0puOEk3bUZKUlkvNWtwenA1WEw2SUltM1l6bE50QUFLZ0Fx?=
 =?utf-8?B?ckY3ODBaOXZKbUt3OFBLbXQxcCtIbnhyeURQNnNNU0QyZUxhZmlwUFZGK3dw?=
 =?utf-8?B?UWxHNGpNU0NxaE9PUGhSWU9FcUlUcUFQZ0ZOR21GblgvdzZncTdYUW5GejlF?=
 =?utf-8?B?TkhsVllNRkpmMnNHQ2VhVi9lR2lXVUVqd1JBMjZPSGdDT0FlenBtcjBtNFdP?=
 =?utf-8?B?VzNYV3ZDVDQ1QjB0aW5rTmVPQmhCcEtWN1pLVFFWMWowdmhvSmlUVVBESjdR?=
 =?utf-8?B?ZExXaFNUMkZtcHdvRm5WaE9nMEZZMTlWcEdhWUwrT0hSYzNobnRaZDJQdWVr?=
 =?utf-8?B?TW90aTVvRGtOQ0l1d2FsbGE2SWs4RUZXQldqQU11dGdxeUJMRFlVaWlhSzV5?=
 =?utf-8?B?ZDRQYks5SHBNNnU3dy9zU1JVZTVJem9YMlpxV2dHYjB5S2RHNmNwa3FGZUVz?=
 =?utf-8?B?QnNqdkh1b29hZlV5WTNqWFNXYjlGR29nNDZjbDFvaWpjVzVzYlJacUZwemZw?=
 =?utf-8?B?djdBT2Y1WGZMVE43bU5EQTF2Q056bjJQaGt6WkUzL2JMMXFVTlhrUEJwNU11?=
 =?utf-8?B?WG1ORFBxeDY0aENKbmJpN01QRjNMZ0ZhTHh4b0RrVzU0VVZmQWQ5d1NEWFRX?=
 =?utf-8?Q?iwH0uBpW+40E3ACBfk7XQNo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2cfa3f8-ee50-4449-e41e-08d9c45398a6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 07:29:17.3772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHHi6gEoQ5L1bnaHm8cs7rWejbLql7aU7JdqldGWqmBrNrXtw3ixH5Lsgd1ynzNG5HpirGQKxNNxPV8mHCJ2Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1550
X-OriginatorOrg: intel.com

On 12/17/21 8:25 AM, Matthieu Baerts wrote:
> Hi Kishen,
> 
> On 16/12/2021 23:22, Kishen Maloor wrote:
>> This change updates struct mptcp_pm_addr_entry to store a
>> listening socket (lsk) reference, i.e. a pointer to a reference
>> counted structure containing the lsk (struct socket *) instead
>> of the lsk itself. Code blocks that directly operated on
>> the lsk in struct mptcp_pm_addr_entry have been updated to work
>> with the lsk ref instead, utilizing the new helper functions that
>> operate on lsk refs.
>>
>> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
>> ---
>>  net/mptcp/pm_netlink.c | 62 ++++++++++++++++++++++++++++--------------
>>  1 file changed, 41 insertions(+), 21 deletions(-)
>>
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index 0cb03d78e22b..29f6d01ace2d 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -35,7 +35,7 @@ struct mptcp_pm_addr_entry {
>>  	struct mptcp_addr_info	addr;
>>  	u8			flags;
>>  	int			ifindex;
>> -	struct socket		*lsk;
>> +	struct mptcp_local_lsk  *lsk_ref;
> 
> Linked to my previous email: same here, please use tabs like before.
> 
> (same in other structure you modified I guess)

Thanks! I shall fix this.

> 
> Cheers,
> Matt
> 

