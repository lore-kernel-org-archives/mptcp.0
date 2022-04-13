Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43DE2910
	for <mptcp@lists.linux.dev>; Wed, 13 Apr 2022 16:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649866071; x=1681402071;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=iiETn61cj5JwHMdn3b+rYiAUMKFB9MFsE9oOjUHjdoQ=;
  b=DlsMV5DzH6L9qmvDJciRxqfHVLi77YvhfJBdxTeLv5a0Oc0OJpDvRM1Z
   DBoDlORHIJjKva7appKyQfqOcBY1goL9C2NmT3wpIWeHFqlLq8AnzVLR5
   DT90s/e9JtLq9Mw+PzMqkp1QSd4QtXDmwzdQPacvp6y60EivvfwDsw1TO
   NIhZcxSXJzhaYkJ//KEwfdsrWk1aC/5ZQzPikRzmKh0+yr47iR3N4mePw
   ykV/JyVW6+VXKbzwyXp6GB8j8UaFtdLmBo59JgLjVMirV1/D+v0ncE4UT
   0fdNznbjMfuz/jKVlpJ45QPtTpOTQMgS8/6kRind2RggD3m9F2fiYF8yK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="262459512"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="262459512"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 09:07:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="552264009"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 13 Apr 2022 09:07:48 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 13 Apr 2022 09:07:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 13 Apr 2022 09:07:44 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 13 Apr 2022 09:07:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGuzsDX3l7RjPaxKoC51ownDn0S+i1HYHAq/Ev212/+WEi2DrFkAVEbCLOertFuesvSu52c47v6HWOP3MGBI07tnGxVdeZac5BNDoFbTl3f4f3Sn9saL6CicUyz9ljSjg0dw29qD7d2U1rF4Lz6jpsCTLZTsFPHsWze7DGVYGCind77c5Y+n3MthQHHLkB4YmtCWBA49ZDvEdZQQ6dbV+QeKnNP1tdEEb1DnRDMygsC8H0kA3y/X4znKk7hZApd/EPu5+qopQgXo2e1CSPJcVApXWyIaWQRY9k5T3I73l2Y9B1zbnFgdt6m/DWUQCE7U1TAd4esW3prhcTlqtHwXIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHvYxdoohzhXu0UEu0dRpHXyguoHfxLFMYbjdHlQCIs=;
 b=OpHNTsfnRTczBan+q/eIUUpy8gXvOGBqUBRNGQK/HLABjErWH+8+6aKEU9SE9wBsTUrfrkYA7g8QrdNgBTUpX6wryMvkG/wtuXiCTcN9Jfifcqx8RvKUzd98wiwsLj7JQCN/7aQtK0TsGjNwtxBpgtIQb0nZ7YeBmJyJSAPWm0ZgofeaICTleFyKCI0nve0skJz6tjTRS/zxp47GNNvIHAMgLxB8E7/v0AuCaV5NnNxDxZytYdkUOJAnXbf3U63bC2Z4UlchuBfDEBcJmXI+vzm28B/ia56WgRV2qiXTy/ttRqqemWFOQ6q969EFSBK2LnUF/RiOZ/WCBC64s6EcSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
 by DM4PR11MB5309.namprd11.prod.outlook.com (2603:10b6:5:390::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 16:07:42 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::1d37:67cb:38a0:f3d1]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::1d37:67cb:38a0:f3d1%5]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 16:07:42 +0000
Message-ID: <9b4aae55-1703-8922-c969-9225443b7795@intel.com>
Date: Wed, 13 Apr 2022 09:07:39 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH mptcp-next v9 02/14] mptcp: handle local addrs announced
 by userspace PMs
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, <mptcp@lists.linux.dev>
References: <20220409013825.1877395-1-kishen.maloor@intel.com>
 <20220409013825.1877395-3-kishen.maloor@intel.com>
 <cd3448feaa77b8555a6fe69cfcbf8d7ca49028dd.camel@redhat.com>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <cd3448feaa77b8555a6fe69cfcbf8d7ca49028dd.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::18) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:9e::21)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1aad043a-2bed-4fe4-265e-08da1d67bd2f
X-MS-TrafficTypeDiagnostic: DM4PR11MB5309:EE_
X-Microsoft-Antispam-PRVS: <DM4PR11MB53092206470A715F78216E13E1EC9@DM4PR11MB5309.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IqOdA0w3L/74USYJMpYYUDQZwDpidtyO+JZWmA2IALqWL6UApwtq8FJK1diYOJHBZ4o/7NdnlgUsiMFjFuQmTmvA6PupHiCkWzrGg+PchgKliJhATPSZD3VKtv/TG0Fa2iIO1jRkO9nmim52PQQsbeSkemJDMn8F5QPMIGb+tqUi0smwITlVfapgqT9eTBOPvh3atEnqqlpYHr8xYl6IrjGBixikDgHxmk7TOGMj0T4c9GsdkHFDaD9gTzUkgTh3PzXNxPUgsFlzqihM4m3lZAejKMCRWJgkiO1BzN7JLF7dS9Vy9zp83GSQFPPkHPMmj9y0uA7DVNhfK9hiqPMWCncGaCdfciCy7oMkBgRLgrkhEe9umgT27kaLqQds3Nn6dz574QdprlzUEBDvtvnL6YZeZ1OuB+/6IwT+A1nxr+GFmOTWHkNC71mBKrhmAQvJFW3/eHfF+Vk4de5KKSOJTPNLBEivjHtg0lVEJ0TULG4sUudAm6RF23Qod5wc+yI9aAyZgy1Mk8L3+be7KjVOT3d2BJ1l14S5AXCHTTw+WEPNWanTJpejMyWGnSz1lxLs9V/5v2rBqwcDKM+CvuwkDARfNsT1WEfA19sMlx4QPI4/nd3gPvY7E0hm0u9w2i11xAyMztygdgGjIelsO1P2H1UxiQOg/N2JtU0gff0EepHf05kPipVYxvwcXVbeYD6WUNUMO8bz0zk+qiDMFPtyHsREmi9rVYqml99WHgRqs6Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(83380400001)(6486002)(316002)(86362001)(31696002)(66556008)(66476007)(8676002)(66946007)(6666004)(38100700002)(26005)(508600001)(6512007)(8936002)(2906002)(82960400001)(2616005)(30864003)(36756003)(53546011)(5660300002)(31686004)(44832011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzBFMlZWMFUzbEloVnVJQkFSdTNJSGZITWRSSlRleHpUZ2RLeTNrZ1NYRXJG?=
 =?utf-8?B?Q1dpU29UOXpBcEpJaTlyUGllWFNTZjUyVTdHKzdOTnZaWXkwWWRuRjR5VXVN?=
 =?utf-8?B?ZFA5YTlNalZoL0hXQXNYR0hOR1FIdU1YYzZLcVVEanNvNmY5aWpXYVVxeWV2?=
 =?utf-8?B?ejFZekRZeUwxLzJ1VzA3a1IzTzM0alYycFdmNVBaWlphUjRoMGZHQnU4ak1a?=
 =?utf-8?B?LzBxQVBQd0FNVktTa3JQMjN4bFBhQkNiOWtnb3NhWGtLeDFHOC9WZE1ndWh3?=
 =?utf-8?B?MjQrY1QxbVRGQkRuWitsUkZiMHgvL3JudzI1L294VXovSExXZTY3UXc1alRr?=
 =?utf-8?B?WjQrTlYrSDNXc1NGMmk5OHVJOEFRZVdqNm1WWVNkLzBoTFNsV2t0c2tnU01o?=
 =?utf-8?B?ay9qYVFObTJoT0hVblZMdHZPRjJwcGpJTWNLZWMzR1pCcHQwc3BkNVp3bWhz?=
 =?utf-8?B?LzFPaGFBclVOUVc5aStMdUdRYjUvbkJ5UVFKNXJicTF5TEw5QWJ1SmF6SjY3?=
 =?utf-8?B?TU9jWnBCdXBDZjhyRWwwYlc0clF5UUVyM2ZCN2VPY0pkRVVCYlNtZktPcFI3?=
 =?utf-8?B?M3VVUFlKZk9NeGhWd0tWZzN4dGJFQzZMaCtJNS85WlBGTHJ2OWRlN0xoMkhk?=
 =?utf-8?B?aXljd1JOUWJrV2lldHRTRytmbGRvQjFhaW9jQjdhV0pEUjZiTFNXV3k4M0NK?=
 =?utf-8?B?YldqV3JhYTNvY0xueHNiYXR4NkZwTGZhMDJ1KzlJSUxqUmNlc01UWVY4R2xl?=
 =?utf-8?B?dXl1VGxXWVlHVkJYOWx6Y05qY0MxcjJLTm95TWUvemFDRCtDV1VCUCtEaEQ3?=
 =?utf-8?B?bWpkdDNzRUpkRXh3WFBsbW12K2VoT3pST0s0dEtpWkdrRnpsV2IwUDJZcytO?=
 =?utf-8?B?K2I2NHdwRzViYjdmME1HdTBZSnA5YVJkMzN4L084QmRKWUlGdiswc1FjQjZD?=
 =?utf-8?B?RFVneFF4ZEdBVlRwcnRWdEtvckZmVFdaOGpxcCtQTzArUm9lM1lIME5VM0FK?=
 =?utf-8?B?b0FaKzBLbUZ4WVpFUTJaaVFoV2lxS3FsOGRDR09aTUNQM1JuSjJuTlUvK1o5?=
 =?utf-8?B?bVpyYXpXM3dQNWd4N2VPRmJ4QlAzbVpJdDFkU3IzUUo0VzJOTGZhQjlkcUg0?=
 =?utf-8?B?SlVydFNJSmh2MTh6UWFiUzc2VFU4WjU2U1lIUXZrRFdDSCtTS25vZjM3NzYx?=
 =?utf-8?B?b0I2dHRPdW52YmtVL3h6TG9UTHZhcEdZSjRPVjFaZzBIRHREMGtNQmtJUUow?=
 =?utf-8?B?N0ZYVkFad0drZDU4bXVMY3ZvdVMxMWEzTVZGUWZMUFhSdnROZXhwRG1jZTZP?=
 =?utf-8?B?RHpmU3RRM3JENG1lYW5LOVdmb250dFRGZmhjSVVSRDRtK3A4czd4cjh4ajRV?=
 =?utf-8?B?WWpaSGpaT0tuWmdiMmVrUGs4azhNNTlLYjJBUHAwWXU0ei90UXdCTitBWlRw?=
 =?utf-8?B?NUdxdDhwaDJJcWFkT09UVDI1cDZQdyt6S2NyYXpmS0J3T3ZqblNZM2I3T0l6?=
 =?utf-8?B?c2VNSjRpdHUvcDNlU013K2JIOGFvQWFxZWpSMDBBOCsraDhGL0kyU0NtV0Vq?=
 =?utf-8?B?bEwyYnZKTElXNlJxaCtRdWhNdVpXbkh5dXdjVVIyY0dGa1loRGhDcU5Ga2FQ?=
 =?utf-8?B?MzVXNlNDeXF3VVVUNCtZbFo2SmJvNnFPNDBzUWE2OTZWVkp3L1BhcHJKZDNE?=
 =?utf-8?B?allZc0VyUkQrYlN2N3dxWmE4YkowNmhWTkVsUHJ0Z0RUU21odWdMcDhDUDZo?=
 =?utf-8?B?WjNEelJyMFhvYXZrL2w2VFdwQ0tNSmxLaEJja3BiV2w5SjN4RjN3SWtNTi9k?=
 =?utf-8?B?YnhWWGNNbUdrOUFCVVFtZldEa1hmWVJQNnI3WGV6NGd0K3UrNVIxSkp0SzNJ?=
 =?utf-8?B?eUNaTGptRk5ZdTdVOHFNa3dpMkt0R2lDVzFYaXlsUkdvWnk4b0xwUWNNL05Y?=
 =?utf-8?B?NzBqckxrbUNoYzhsbzFZakFVb1k4cnJmV1VQZHZhUm1sbWtHK1JmRGtPbEta?=
 =?utf-8?B?WldwditDNi9kSkxkeVpPZVhEd2tJbUcyRElHbVhkdjlYMzVHclVJYitMOVNT?=
 =?utf-8?B?Z0pGd0t3NE5mMmdmREFZai9PcXYyUjl5NUw3SitTT3JXdWMrSnhQd3YzQjBO?=
 =?utf-8?B?K2VIb2tZRUFMbWdnWndJZnZZZGlqUi9aNFdHWmJNL0RIS0h3Q2h3aTNqVjQ2?=
 =?utf-8?B?RVNwWUQxYTVsdCswczhlcU5PSjZDOG4yd0Fyb3ltVGhsM1dhSk1rZm02Qjkw?=
 =?utf-8?B?c2h0MFQyVHNucFBnZmJuMW1vRXB3VFZyUjV2THQ2TndreU5wU0QrS0ZBbEVa?=
 =?utf-8?B?YStaOXJ0NUhmck0zVE5HMHpvcjVjUTVTa2d2OXo2YU9Qd0IwWVVPM21ZOHRY?=
 =?utf-8?Q?CeFEL9bySaR84iRI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aad043a-2bed-4fe4-265e-08da1d67bd2f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 16:07:42.0417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGsmvn8Le54i6uD4CDY7Zck/JhzX6v9yO/OcCUOi7pc7XPgHrGs41cxrIGmlBxZp90hC8draJbuEKuXy2sc4mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5309
X-OriginatorOrg: intel.com

On 4/13/22 7:06 AM, Paolo Abeni wrote:
> On Fri, 2022-04-08 at 21:38 -0400, Kishen Maloor wrote:
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
>>
>> v8:
>> -Add copyright notice to pm_userspace.c.
>> ---
>>  net/mptcp/Makefile       |  2 +-
>>  net/mptcp/pm.c           |  1 +
>>  net/mptcp/pm_netlink.c   | 34 +++++++++---------
>>  net/mptcp/pm_userspace.c | 78 ++++++++++++++++++++++++++++++++++++++++
>>  net/mptcp/protocol.c     |  1 +
>>  net/mptcp/protocol.h     |  7 ++++
>>  6 files changed, 105 insertions(+), 18 deletions(-)
>>  create mode 100644 net/mptcp/pm_userspace.c
>>
>> diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
>> index 168c55d1c917..4004347db47e 100644
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
>> index 98b205c2c101..92d47e8e8983 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -66,8 +66,8 @@ pm_nl_get_pernet_from_msk(const struct mptcp_sock *msk)
>>  	return pm_nl_get_pernet(sock_net((struct sock *)msk));
>>  }
>>  
>> -static bool addresses_equal(const struct mptcp_addr_info *a,
>> -			    const struct mptcp_addr_info *b, bool use_port)
>> +bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
>> +			   const struct mptcp_addr_info *b, bool use_port)
>>  {
>>  	bool addr_equals = false;
>>  
>> @@ -131,7 +131,7 @@ static bool lookup_subflow_by_saddr(const struct list_head *list,
>>  		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
>>  
>>  		local_address(skc, &cur);
>> -		if (addresses_equal(&cur, saddr, saddr->port))
>> +		if (mptcp_addresses_equal(&cur, saddr, saddr->port))
>>  			return true;
>>  	}
>>  
>> @@ -149,7 +149,7 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
>>  		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
>>  
>>  		remote_address(skc, &cur);
>> -		if (addresses_equal(&cur, daddr, daddr->port))
>> +		if (mptcp_addresses_equal(&cur, daddr, daddr->port))
>>  			return true;
>>  	}
>>  
>> @@ -269,7 +269,7 @@ mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
>>  	lockdep_assert_held(&msk->pm.lock);
>>  
>>  	list_for_each_entry(entry, &msk->pm.anno_list, list) {
>> -		if (addresses_equal(&entry->addr, addr, true))
>> +		if (mptcp_addresses_equal(&entry->addr, addr, true))
>>  			return entry;
>>  	}
>>  
>> @@ -286,7 +286,7 @@ bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
>>  
>>  	spin_lock_bh(&msk->pm.lock);
>>  	list_for_each_entry(entry, &msk->pm.anno_list, list) {
>> -		if (addresses_equal(&entry->addr, &saddr, true)) {
>> +		if (mptcp_addresses_equal(&entry->addr, &saddr, true)) {
>>  			ret = true;
>>  			goto out;
>>  		}
>> @@ -421,7 +421,7 @@ static bool lookup_address_in_vec(const struct mptcp_addr_info *addrs, unsigned
>>  	int i;
>>  
>>  	for (i = 0; i < nr; i++) {
>> -		if (addresses_equal(&addrs[i], addr, addr->port))
>> +		if (mptcp_addresses_equal(&addrs[i], addr, addr->port))
>>  			return true;
>>  	}
>>  
>> @@ -457,7 +457,7 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullm
>>  		mptcp_for_each_subflow(msk, subflow) {
>>  			ssk = mptcp_subflow_tcp_sock(subflow);
>>  			remote_address((struct sock_common *)ssk, &addrs[i]);
>> -			if (deny_id0 && addresses_equal(&addrs[i], &remote, false))
>> +			if (deny_id0 && mptcp_addresses_equal(&addrs[i], &remote, false))
>>  				continue;
>>  
>>  			if (!lookup_address_in_vec(addrs, i, &addrs[i]) &&
>> @@ -490,7 +490,7 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
>>  	struct mptcp_pm_addr_entry *entry;
>>  
>>  	list_for_each_entry(entry, &pernet->local_addr_list, list) {
>> -		if ((!lookup_by_id && addresses_equal(&entry->addr, info, true)) ||
>> +		if ((!lookup_by_id && mptcp_addresses_equal(&entry->addr, info, true)) ||
>>  		    (lookup_by_id && entry->addr.id == info->id))
>>  			return entry;
>>  	}
>> @@ -505,7 +505,7 @@ lookup_id_by_addr(const struct pm_nl_pernet *pernet, const struct mptcp_addr_inf
>>  
>>  	rcu_read_lock();
>>  	list_for_each_entry(entry, &pernet->local_addr_list, list) {
>> -		if (addresses_equal(&entry->addr, addr, entry->addr.port)) {
>> +		if (mptcp_addresses_equal(&entry->addr, addr, entry->addr.port)) {
>>  			ret = entry->addr.id;
>>  			break;
>>  		}
>> @@ -739,7 +739,7 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
>>  		struct mptcp_addr_info local;
>>  
>>  		local_address((struct sock_common *)ssk, &local);
>> -		if (!addresses_equal(&local, addr, addr->port))
>> +		if (!mptcp_addresses_equal(&local, addr, addr->port))
>>  			continue;
>>  
>>  		if (subflow->backup != bkup)
>> @@ -909,9 +909,9 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
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
>> @@ -1038,14 +1038,14 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
>>  	 */
>>  	local_address((struct sock_common *)msk, &msk_local);
>>  	local_address((struct sock_common *)skc, &skc_local);
>> -	if (addresses_equal(&msk_local, &skc_local, false))
>> +	if (mptcp_addresses_equal(&msk_local, &skc_local, false))
>>  		return 0;
>>  
>>  	pernet = pm_nl_get_pernet_from_msk(msk);
>>  
>>  	rcu_read_lock();
>>  	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
>> -		if (addresses_equal(&entry->addr, &skc_local, entry->addr.port)) {
>> +		if (mptcp_addresses_equal(&entry->addr, &skc_local, entry->addr.port)) {
>>  			ret = entry->addr.id;
>>  			break;
>>  		}
>> @@ -1416,7 +1416,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
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
>> index 000000000000..c50f8900ffba
>> --- /dev/null
>> +++ b/net/mptcp/pm_userspace.c
>> @@ -0,0 +1,78 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Multipath TCP
>> + *
>> + * Copyright (c) 2022, Intel Corporation.
>> + */
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
> 
> Is this condition reachable? Which code path use it? AFAICS the later
> patches require the user-space PM to always set the local address ID -
> which is IMHO correct: the address <> ID association should be up to
> the user-space.
> 
> So basically this enforces no dup IDs usage, right? (Which again IMHO
> should be up to the user-space). If so I would simply avoid all this
> code.
> 

The userspace PM handles the selection of IDs for all addresses it advertises.

When there's an incoming subflow at an address, it's corresponding ID is not known.
mptcp_userspace_pm_get_local_id() would be invoked on that path further leading into
this function and the above code locates a stored entry (if there's one) for that
address and retrieves its ID. This information will then be reflected in the subflow 
event that gets dispatched.

So, all this code is necessary.
