Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C1020E6
	for <mptcp@lists.linux.dev>; Thu,  7 Apr 2022 01:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649296704; x=1680832704;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=DobSC7ZCtR+GroXcBQlgwelEnXRVdclGZvL9AqR4XpI=;
  b=Lg9C0MOc16ge7DNjN4C9DbYolnqlsgF3SiW5okLLxshbkIA0oN7zcaHz
   ib/+vKo4X48s6++UZMDQuFciUl2F1duhRG/Hrxba3DArzXvMy/RjojOzF
   aE4e+GnRyQgof+CWfMlmiosCDdy+pQG5eLCihfw6WMlbkVEN0QU1iTrUa
   hhqC+t9JYVBaiSQGK+eoaKxaZLpDqOGIyFfBo2zC9hE+YN8LQ/boL33sA
   v+DiZ0+9jNXCfoB+MRE2jgihngbLvLo2Lw/vAMVuiwFwucZ/RTkD9WVc0
   XaIFfFBYSW8ZqUyyhpd1zw3YzXLrOAGMLlgscbDWhv/fRDcMuNWu3bRDw
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="347645729"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="347645729"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 18:58:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="621055878"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga004.fm.intel.com with ESMTP; 06 Apr 2022 18:58:22 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Apr 2022 18:58:22 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Apr 2022 18:58:21 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 6 Apr 2022 18:58:21 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 6 Apr 2022 18:57:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rl4961GLOsJ9HQ4jYwJ5hBWWqVUaau8AdVwMV5lasM6eS+5U2rrPK8PTxSnAUo3YOeE6cY5c6g3SFySIo6z1UV60Kff0gYtnEtOShkK1BTXV7K2Tys+XEUzwrZiOGQVtfGjVU4pJ62haVjvsrHzPpTsGlgvRp3XMlFW5dyt5ef+YwzdtZFq81Qgfhtktxfv24azONV1Zpzq8hXKFdG1b8zMgc7WhQP5T3skfVt6WBB1L/aO5Tw/LmqfJlZrhNOFTgCPIynrHWAHjq9GWFp+uE/ECfVDVYQo9REeFSmkna/H5y4jCXSCX+ldn4CFb9zwsFf2fSZxW2KiKMdzE6YsOIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFokJy3ydPHePWoKVrJh2R00UNz2b2Ocv4hZdhMRtZ4=;
 b=KZlVCKo5+ncdF9NCg1ZV9mTdueWWER/GzZkXD+mFa0e+d8X+FY3Y6FXL3/ZMNCDPSJVwXNICsZdx07hI/qFlYYjfkyY7wQLCdbBYxd1J/d1B4Q3XzlnXrtKJ2Vr1ngq6qhPCH+ThtTe/JyrmdnTF/BDUOdzhN3Gg5XDwX+ALmaD67Qwvay3wiGnVFPjk3++ypt8VCeeUQvPklRmZLiPb3N9G97ubEZBkOHChFQeKeFPT4Yz+yL2h+vLSoLGkws7Nd9AfFNFCV5zgFcWGWGtNzWEkiEm31LFZx2m8wPge/l2jqLK9wLHtEwT6czlh1IieQOLvj7v8nAYg6CkwNwjjzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
 by CH0PR11MB5738.namprd11.prod.outlook.com (2603:10b6:610:113::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 01:57:44 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::99:140:4781:f4d6]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::99:140:4781:f4d6%7]) with mapi id 15.20.5144.019; Thu, 7 Apr 2022
 01:57:44 +0000
Message-ID: <ec32c0b4-c655-fd01-8999-5aa4a0db86b5@intel.com>
Date: Wed, 6 Apr 2022 18:57:42 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH mptcp-next v6 02/14] mptcp: handle local addrs announced
 by userspace PMs
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, <mptcp@lists.linux.dev>
References: <20220329021437.1196552-1-kishen.maloor@intel.com>
 <20220329021437.1196552-3-kishen.maloor@intel.com>
 <38f029432d4e83aa39d8730af3a6a7a3b80df232.camel@redhat.com>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <38f029432d4e83aa39d8730af3a6a7a3b80df232.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0125.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::10) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:9e::21)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b8d0713-e3c6-4940-21d9-08da183a01da
X-MS-TrafficTypeDiagnostic: CH0PR11MB5738:EE_
X-Microsoft-Antispam-PRVS: <CH0PR11MB57382ABED0536CDBE468DD92E1E69@CH0PR11MB5738.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qpRBOyx/TVQw6x/Kla5/RNNgAPw2okvrL1cBVOpXsn8gvl+pAX0dV5PgoYRkhxSpyazw9M9nSD2GbULM4Ck3l0zODIpr7d/XZesAUsosNEs+yeSU28tSOemAPzXE+xE7S98p/GVZBsDccaREdB7Achq8JR88C8SfbjziKbd0bjsOFLyVblaynDNU96Wz+xSQkQVhE86+nxpZEgMq+vFiPMZTk9UPKsaibX3ck4BJ++nyG+epcqwGrFH4iAcxOzB+Dn3+wKYcKYtjeaH7u7pU0Pg0QuAy5GUDI9d3YIf3armbudm+LK53fsmPRSY8CvAtJeALLkTbhmZY42dHAygd9qy3cWOUfDk2xiad6aVpgsBiUcX1CNbNWfdkvy9XMGRlwG5QEp0HuPcZTO6JSsdFAUYoTHaWfxXlq8tMNlAZrZTMOkYxdanTE6VBFZPMbVBGWyaut+C9OWszGtrE2JSD0q/Im+vnVP2X2RWkPiZ6nJeL70Cg+/YVJrE5ynDN98tjIXUGLKr3LYo2rb9VJ22AcCEYNDjQoQf/1g5PjrL+Xdxs9xF9icn6KmFJe/fV9F4TVxwtJ/tpSBfQhZi9xBVAWTTpQIW/yWFMgeyHcgUiddNAIiQuMocuU+YHzW1yt58MQWDfISFZoEdN0Afhe2THwwTDY491nNNGUD1T9Kv8lTJCtIiP1/l0oHAnNMHXX/dpSxO8gtzwIz3q8TCb5GPiCog7tJsj7VgoQH/fYH66BjQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(66946007)(316002)(86362001)(66476007)(66556008)(31696002)(38100700002)(508600001)(6486002)(6512007)(186003)(26005)(83380400001)(82960400001)(53546011)(6506007)(2616005)(5660300002)(36756003)(8936002)(44832011)(30864003)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmFIMzJxT0czQXhWTCtFSmsweEhTSDNvSWZmWHI1QklCVXJiaDhtaFZmTVRw?=
 =?utf-8?B?VjlIY3VHSXlvbEhzYmpFSCtEcEFWUHpCRE1mU3lTVmlPK0FSc1IzaUhTaXVQ?=
 =?utf-8?B?YjQ4R3RCcUozV1QyS2d6a2M2V0RMeE1maGttRGlhWm5IZGMyejVzZm5iZkdF?=
 =?utf-8?B?NHR3TDhobUNhYlFPODIvcHM0SmNzZG0xZWF5UjI0eDFXc0RXSzJRTndwRHhx?=
 =?utf-8?B?cmdxM21acEtQTERxaE42dEkwSmZqMlh0RDRJL0hYTTJPVGN6cGhyL1hRYlVa?=
 =?utf-8?B?azJzSVVPWkdZYkhWYTRBeU8zV1pGRHhraWUyNlArd0M2MmFOeEVMNFh5QS9n?=
 =?utf-8?B?NG9MNUJmZ0o5SHlvYTUvYjZhelF1anZ6WGJteHJYZ0tUQlJ6VTJJaXd3UldN?=
 =?utf-8?B?bjVrZkVuaGxTNmN5SkxwbVc3eXB0UkxrQ0VZY25wS0tOZ2VibDRRSm11Z2lT?=
 =?utf-8?B?UnRwL1R0U0FqVFBHUi9waC8wZmVrcUNMbjdxV2FXbm9RbkwxV3h4RGEyUGVt?=
 =?utf-8?B?eS9jays5TVYwSEZsK2RURm56OWJtekFXbkpYT2cvakFBdldTYXJWeWFPNXNi?=
 =?utf-8?B?YWZNVTArWnNnczRkbDVMOG00UGtSaUJpL2tUcHdHTHFwS2xTeDNleVhwZkkz?=
 =?utf-8?B?ZTJFSDNqS2ptRDlQTFNjTlBxcHk5Uy9PSklXem92ZzZuajZvRHZqT0dmSEVp?=
 =?utf-8?B?VVpXT2t3Rk0xY2dhaERPR2JiR2JBL2wwOWo1c0hNU3ltbWtmV0lueWtVQzlP?=
 =?utf-8?B?N01iM0pyMlhpZXhiZ29WaHA2d050Q3NxRFFqU1FMNGRBS2doRGFZQTdQd0ww?=
 =?utf-8?B?bmVlWHVuRUlKZTMzQjhTbjd4WXUyYlFsNWEzTld1V0NzNnRHY2hpMDFNWXNB?=
 =?utf-8?B?cWp2YlRXMU8rWEZQSjlyMWRDeEVFRmtmeGdnMFhyTlhEOGt5RmVxRHZsYTdn?=
 =?utf-8?B?TjdYT3FuZkR4cVgxVEZWSTd6T2NLWnRScW5xenZuYVd4amgxMTl3Z3VmYzJC?=
 =?utf-8?B?MnFyK3pJWHNnTEhIcEExVVdtK0U5QnBQcXdWaXBOVlljWEN2d0I0Sjk2Zng4?=
 =?utf-8?B?b3FTMTZWeitOMXJ4WGV4YzdXR1RmS3BTRkpXMkVheThwWnp2aDAyanJrQWs5?=
 =?utf-8?B?QUh2R2xwYTJ3Rm1VbWV0ci83clBvWVMzN1JPQXlWMjR0VG91R3RTRkhDb1di?=
 =?utf-8?B?T29ZMUQ1UXY2OG5qUGtNN1BKZEVWa1VUVDJLMXZjaytNOGJmZElIWTFNRy9N?=
 =?utf-8?B?ZFlvNVNKYzBZbDNMUmlKbFVWMlFWRHo5eW40QWZWaEYrUTlTU0IvOGpCYlhF?=
 =?utf-8?B?cmp3eW9VTE83dkNWQkxjTW1sOE1WTG50d0NRLzRoOHIwckJicHBkNWI4VGFT?=
 =?utf-8?B?b2JSNHhWQlRYb01pVzh5YXpiN1ZYMkhNcHRJSUtuSVE0YTltMFgxeklkaWtv?=
 =?utf-8?B?QmFISUYzdkQ0Z0xIeGZuRHg5cEZ2REM1MHhjL0cxamovdkptL0pxT0xocTJG?=
 =?utf-8?B?ZGpjbjNZUFJYRXZhWHhpMjEyZldOSnhYc1pzcERYQ2IwY3daMkJ1WjcwRjJB?=
 =?utf-8?B?WUFHaGR2eERXNjJaeDdMR3hnSG5HbXVjM1RxVk5HUXcvNCtYN0U2LytyQ3k1?=
 =?utf-8?B?T0ZaZmV5THJTRU1LcFJtQ3dycUxtVFZLeUcxMlU5WVZqVDNlRnVLMTZBZUNR?=
 =?utf-8?B?NzJkek1WK1lwTDRQWTdXVktjQTV3VjMyTHp2ZHc2WDQzT1dKOWtZNEcwbTFw?=
 =?utf-8?B?NlpPZ3JxYlk0K1lLdVZCWnNRdFF2eXYyUk4vSUpzMWFMaklPU3lRMklyWHNY?=
 =?utf-8?B?TXRLK2kwMHpxZ3gzZjVRWTdLeEFKZWcrRFIvR0ZaN29sZXJZbGhUR1UxdXh0?=
 =?utf-8?B?cUtVVTMwQ3FQdlhiTTZWc3p4LzRYNktMRHF0L0tFYkl6U0dCSlovckNtN0E4?=
 =?utf-8?B?eHZKYWNQTXIyZGhtdGl3VnBSVC9uUUg3M2M5RFk5akpVcUowb2JISW1jRjd0?=
 =?utf-8?B?SjBYWDEzUWErSW1nUHB4ZTRyWjg1MUV0TTFBcXhpUkpTa3JXbnRBWHpOcG0y?=
 =?utf-8?B?WjM2K1QvWkJ1RktIUXBZWVB0dFVTdnJNVGlvcEduRWlVdnpHUVFxeGZnZkFM?=
 =?utf-8?B?N3BTWlBaWWxBbWRIV2tMWU95R3g1UFRyMzg1MlpEbGFIWWJ2ZGxPRkw0TG1O?=
 =?utf-8?B?L2dpMXNMRWI0cG8rUGlwYkhrYTQwOUIvL3czYjRmTTNpd0YzaEFLZlNpWDMz?=
 =?utf-8?B?bkRvZzFFNndmN3EzWkI3K2pGUDBYRThBZFRzRUpqSGdYenp2aGlDV3ppR2k0?=
 =?utf-8?B?dWI1OXM2ZGt3LzZXN1lUM0dLVjFUQXFVekxyS1QxcXN5QzU3SU5oWldrVGFB?=
 =?utf-8?Q?E+xj0rXmTAm7oNnM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8d0713-e3c6-4940-21d9-08da183a01da
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 01:57:44.7868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ZI2b41O0QshNBL75mvH4DchdQpi9d62S5ed0x8eK95eL+MSjrkstNrQyZwRjtEc0JLQHox9XSt9pCxnticYWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5738
X-OriginatorOrg: intel.com

On 4/1/22 7:43 AM, Paolo Abeni wrote:
> On Mon, 2022-03-28 at 22:14 -0400, Kishen Maloor wrote:
>> This change adds an internal function to store/retrieve local
>> addrs announced by userspace PM implementations to/from its kernel
>> context. The function addresses the requirements of three scenarios:
>> 1) ADD_ADDR announcements (which require that a local id be
>> provided), 2) retrieving the local id associated with an address,
>> and also where one may need to be assigned, and 3) reissuance of
>> ADD_ADDRs when there's a successful match of addr/id.
>>
>> The list of all stored local addr entries is held under the
>> MPTCP sock structure. Memory for these entries is allocated from
>> the sock option buffer, so the list of addrs is bounded by optmem_max.
>> The list if not released via REMOVE_ADDR signals is ultimately
>> freed when the sock is destructed.
>>
>> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
>> ---
>> v6:
>> -Move local_addr_list into struct mptcp_pm_data.
>> -Replace mptcp_data_lock() with the pm spinlock.
>> -Move mptcp_userspace_pm_append_new_local_addr() and
>> mptcp_free_local_addr_list() into a new pm_userspace.c.
>> -Make addresses_equal() helper non-static and rename to
>> mptcp_addresses_equal().
>> ---
>>  net/mptcp/Makefile       |  2 +-
>>  net/mptcp/pm.c           |  1 +
>>  net/mptcp/pm_netlink.c   | 34 +++++++++---------
>>  net/mptcp/pm_userspace.c | 74 ++++++++++++++++++++++++++++++++++++++++
>>  net/mptcp/protocol.c     |  1 +
>>  net/mptcp/protocol.h     |  7 ++++
>>  6 files changed, 101 insertions(+), 18 deletions(-)
>>  create mode 100644 net/mptcp/pm_userspace.c
>>
>> diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
>> index e54daceac58b..cb7f53f6ab22 100644
>> --- a/net/mptcp/Makefile
>> +++ b/net/mptcp/Makefile
>> @@ -2,7 +2,7 @@
>>  obj-$(CONFIG_MPTCP) += mptcp.o
>>  
>>  mptcp-y := protocol.o subflow.o options.o token.o crypto.o ctrl.o pm.o diag.o \
>> -	   mib.o pm_netlink.o sockopt.o
>> +	   mib.o pm_netlink.o sockopt.o pm_userspace.o
>>  
>>  obj-$(CONFIG_SYN_COOKIES) += syncookies.o
>>  obj-$(CONFIG_INET_MPTCP_DIAG) += mptcp_diag.o
>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>> index 5d6832c4d9f2..cdc2d79071f8 100644
>> --- a/net/mptcp/pm.c
>> +++ b/net/mptcp/pm.c
>> @@ -469,6 +469,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
>>  {
>>  	spin_lock_init(&msk->pm.lock);
>>  	INIT_LIST_HEAD(&msk->pm.anno_list);
>> +	INIT_LIST_HEAD(&msk->pm.userspace_pm_local_addr_list);
>>  	mptcp_pm_data_reset(msk);
>>  }
>>  
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index 8d04c8d8a8df..836f6df9f744 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -55,8 +55,8 @@ struct pm_nl_pernet {
>>  #define MPTCP_PM_ADDR_MAX	8
>>  #define ADD_ADDR_RETRANS_MAX	3
>>  
>> -static bool addresses_equal(const struct mptcp_addr_info *a,
>> -			    const struct mptcp_addr_info *b, bool use_port)
>> +bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
>> +			   const struct mptcp_addr_info *b, bool use_port)
>>  {
>>  	bool addr_equals = false;
>>  
>> @@ -120,7 +120,7 @@ static bool lookup_subflow_by_saddr(const struct list_head *list,
>>  		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
>>  
>>  		local_address(skc, &cur);
>> -		if (addresses_equal(&cur, saddr, saddr->port))
>> +		if (mptcp_addresses_equal(&cur, saddr, saddr->port))
>>  			return true;
>>  	}
>>  
>> @@ -138,7 +138,7 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
>>  		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
>>  
>>  		remote_address(skc, &cur);
>> -		if (addresses_equal(&cur, daddr, daddr->port))
>> +		if (mptcp_addresses_equal(&cur, daddr, daddr->port))
>>  			return true;
>>  	}
>>  
>> @@ -262,7 +262,7 @@ mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
>>  	lockdep_assert_held(&msk->pm.lock);
>>  
>>  	list_for_each_entry(entry, &msk->pm.anno_list, list) {
>> -		if (addresses_equal(&entry->addr, addr, true))
>> +		if (mptcp_addresses_equal(&entry->addr, addr, true))
>>  			return entry;
>>  	}
>>  
>> @@ -279,7 +279,7 @@ bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
>>  
>>  	spin_lock_bh(&msk->pm.lock);
>>  	list_for_each_entry(entry, &msk->pm.anno_list, list) {
>> -		if (addresses_equal(&entry->addr, &saddr, true)) {
>> +		if (mptcp_addresses_equal(&entry->addr, &saddr, true)) {
>>  			ret = true;
>>  			goto out;
>>  		}
>> @@ -414,7 +414,7 @@ static bool lookup_address_in_vec(const struct mptcp_addr_info *addrs, unsigned
>>  	int i;
>>  
>>  	for (i = 0; i < nr; i++) {
>> -		if (addresses_equal(&addrs[i], addr, addr->port))
>> +		if (mptcp_addresses_equal(&addrs[i], addr, addr->port))
>>  			return true;
>>  	}
>>  
>> @@ -450,7 +450,7 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullm
>>  		mptcp_for_each_subflow(msk, subflow) {
>>  			ssk = mptcp_subflow_tcp_sock(subflow);
>>  			remote_address((struct sock_common *)ssk, &addrs[i]);
>> -			if (deny_id0 && addresses_equal(&addrs[i], &remote, false))
>> +			if (deny_id0 && mptcp_addresses_equal(&addrs[i], &remote, false))
>>  				continue;
>>  
>>  			if (!lookup_address_in_vec(addrs, i, &addrs[i]) &&
>> @@ -483,7 +483,7 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
>>  	struct mptcp_pm_addr_entry *entry;
>>  
>>  	list_for_each_entry(entry, &pernet->local_addr_list, list) {
>> -		if ((!lookup_by_id && addresses_equal(&entry->addr, info, true)) ||
>> +		if ((!lookup_by_id && mptcp_addresses_equal(&entry->addr, info, true)) ||
>>  		    (lookup_by_id && entry->addr.id == info->id))
>>  			return entry;
>>  	}
>> @@ -498,7 +498,7 @@ lookup_id_by_addr(const struct pm_nl_pernet *pernet, const struct mptcp_addr_inf
>>  
>>  	rcu_read_lock();
>>  	list_for_each_entry(entry, &pernet->local_addr_list, list) {
>> -		if (addresses_equal(&entry->addr, addr, entry->addr.port)) {
>> +		if (mptcp_addresses_equal(&entry->addr, addr, entry->addr.port)) {
>>  			ret = entry->addr.id;
>>  			break;
>>  		}
>> @@ -732,7 +732,7 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
>>  		struct mptcp_addr_info local;
>>  
>>  		local_address((struct sock_common *)ssk, &local);
>> -		if (!addresses_equal(&local, addr, addr->port))
>> +		if (!mptcp_addresses_equal(&local, addr, addr->port))
>>  			continue;
>>  
>>  		if (subflow->backup != bkup)
>> @@ -902,9 +902,9 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
>>  	 * singled addresses
>>  	 */
>>  	list_for_each_entry(cur, &pernet->local_addr_list, list) {
>> -		if (addresses_equal(&cur->addr, &entry->addr,
>> -				    address_use_port(entry) &&
>> -				    address_use_port(cur))) {
>> +		if (mptcp_addresses_equal(&cur->addr, &entry->addr,
>> +					  address_use_port(entry) &&
>> +					  address_use_port(cur))) {
>>  			/* allow replacing the exiting endpoint only if such
>>  			 * endpoint is an implicit one and the user-space
>>  			 * did not provide an endpoint id
>> @@ -1031,14 +1031,14 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
>>  	 */
>>  	local_address((struct sock_common *)msk, &msk_local);
>>  	local_address((struct sock_common *)skc, &skc_local);
>> -	if (addresses_equal(&msk_local, &skc_local, false))
>> +	if (mptcp_addresses_equal(&msk_local, &skc_local, false))
>>  		return 0;
>>  
>>  	pernet = net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
>>  
>>  	rcu_read_lock();
>>  	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
>> -		if (addresses_equal(&entry->addr, &skc_local, entry->addr.port)) {
>> +		if (mptcp_addresses_equal(&entry->addr, &skc_local, entry->addr.port)) {
>>  			ret = entry->addr.id;
>>  			break;
>>  		}
>> @@ -1409,7 +1409,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
>>  			goto next;
>>  
>>  		local_address((struct sock_common *)msk, &msk_local);
>> -		if (!addresses_equal(&msk_local, addr, addr->port))
>> +		if (!mptcp_addresses_equal(&msk_local, addr, addr->port))
>>  			goto next;
>>  
>>  		lock_sock(sk);
>> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
>> new file mode 100644
>> index 000000000000..cb8321cdb4ea
>> --- /dev/null
>> +++ b/net/mptcp/pm_userspace.c
>> @@ -0,0 +1,74 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include "protocol.h"
>> +
>> +void mptcp_free_local_addr_list(struct mptcp_sock *msk)
>> +{
>> +	struct mptcp_pm_addr_entry *entry, *tmp;
>> +	struct sock *sk = (struct sock *)msk;
>> +	LIST_HEAD(free_list);
>> +
>> +	if (!mptcp_pm_is_userspace(msk))
>> +		return;
>> +
>> +	spin_lock_bh(&msk->pm.lock);
>> +	list_splice_init(&msk->pm.userspace_pm_local_addr_list, &free_list);
>> +	spin_unlock_bh(&msk->pm.lock);
>> +
>> +	list_for_each_entry_safe(entry, tmp, &free_list, list) {
>> +		sock_kfree_s(sk, entry, sizeof(*entry));
>> +	}
>> +}
>> +
>> +int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
>> +					     struct mptcp_pm_addr_entry *entry)
>> +{
>> +	DECLARE_BITMAP(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
>> +	struct mptcp_pm_addr_entry *match = NULL;
>> +	struct sock *sk = (struct sock *)msk;
>> +	struct mptcp_pm_addr_entry *e;
>> +	bool addr_match = false;
>> +	bool id_match = false;
>> +	int ret = -EINVAL;
>> +
>> +	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
>> +
>> +	spin_lock_bh(&msk->pm.lock);
>> +	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
>> +		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
>> +		if (addr_match && entry->addr.id == 0)
>> +			entry->addr.id = e->addr.id;
>> +		id_match = (e->addr.id == entry->addr.id);
>> +		if (addr_match && id_match) {
>> +			match = e;
>> +			break;
>> +		} else if (addr_match || id_match) {
>> +			break;
>> +		}
>> +		__set_bit(e->addr.id, id_bitmap);
>> +	}
>> +
>> +	if (!match && !addr_match && !id_match) {
>> +		/* Memory for the entry is allocated from the
>> +		 * sock option buffer.
>> +		 */
>> +		e = sock_kmalloc(sk, sizeof(*e), GFP_ATOMIC);
>> +		if (!e) {
>> +			spin_unlock_bh(&msk->pm.lock);
>> +			return -ENOMEM;
>> +		}
>> +
>> +		*e = *entry;
>> +		if (!e->addr.id)
>> +			e->addr.id = find_next_zero_bit(id_bitmap,
>> +							MPTCP_PM_MAX_ADDR_ID + 1,
>> +							1);
>> +		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
>> +		ret = e->addr.id;
>> +	} else if (match) {
>> +		ret = entry->addr.id;
>> +	}
>> +
>> +	spin_unlock_bh(&msk->pm.lock);
>> +	return ret;
>> +}
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index b2c654992de0..b016822f44dc 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -3103,6 +3103,7 @@ void mptcp_destroy_common(struct mptcp_sock *msk)
>>  	msk->rmem_fwd_alloc = 0;
>>  	mptcp_token_destroy(msk);
>>  	mptcp_pm_free_anno_list(msk);
>> +	mptcp_free_local_addr_list(msk);
>>  }
>>  
>>  static void mptcp_destroy(struct sock *sk)
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index 187c932deef0..40dabf9462a8 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -208,6 +208,7 @@ struct mptcp_pm_data {
>>  	struct mptcp_addr_info local;
>>  	struct mptcp_addr_info remote;
>>  	struct list_head anno_list;
>> +	struct list_head userspace_pm_local_addr_list;
> 
> It looks like anno_list is never used when the user-space PM is enabled
> - and userspace_pm_local_addr_list is never used by the NL PM.
> 
> What about reusing the same, single field? Ev. using an union, but not
> strictly needed, since in both case this contains addresses [to be]
> announced, right?
> 
> I really think we should avoid adding more data to the msk struct for
> user-space PM consumption only, it's really counterintuitive.


anno_list is used by both PMs to store struct mptcp_pm_add_entry entries.

userspace_pm_local_addr_list is used only to store per-msk 
struct mptcp_pm_addr_entry entries that were populated by the userspace PM.

Unfortunately the local_addr_list used by the in-kernel PM is in the
pm_nl_pernet structure.
