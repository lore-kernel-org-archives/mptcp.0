Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D321D29CA
	for <mptcp@lists.linux.dev>; Tue, 21 Dec 2021 07:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640071979; x=1671607979;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Xa5YtBaMvGUhw6cFvsJCgyxt8YncXFkqKJU5QWykKd0=;
  b=QEmaPfzbxSFhL6SZGq1FIOKwkOs1pahBVC7oBcdBJKVB4ymFCT4YyRii
   ZPgIYTqVEmh/PzyBk1guQfT+lj97xQ1V00jnb7QDJWwSyhEA99LPziztZ
   /3hUotFxFis6zaQinxAS9/2A0g2+F7DV6GxdA0Lu4VpGVvq+Uot8++ZoE
   BwvtGLBT/uv0gLs2ucd6k1l81p/YeXSfpwkO4wOtm5Tn1ZimWTam2UCCD
   n2QeVxEFl2nDNhTnoLy0rTfJAv5CqS3+wLTGD2z3GqlD++tq+fc7+DUeN
   FpGAq9ERAOM/AC7WFbnhBSu4s4cvQ7rbFIs6YFNklv2esrQBeE9ykTSnY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="326643903"
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="326643903"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 23:32:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="606980677"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Dec 2021 23:32:58 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 23:32:57 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 23:32:56 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 20 Dec 2021 23:32:56 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 20 Dec 2021 23:32:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuOQTC7aEGR5TitDrrsMrFTvRp6XjCWgtW3hwH0doh7n/MOqMNhNXDKClWaNm5UaGYxi/ETZReUYXgH3VsL7SeYHigbJxWb+tNQOAryzrbbHfXwOVteTSB+O1VQTKPuxizRKqUJ6Aa9ZJDdVBnlTb36Qr64dwnawrUIRNuS4duhyII4USX35NeWEq1/f6YDKjqB8muRE049MiVPrpVT6UhcTM7RpXdmjn+P6xOETenjUpRyQNdJ7obQdAG3BYmo865+Q/qBjZjv8hXgShV0X4VLGPhQ7D9J+G5OizCXZyXsH5Bl3EPi7gLgmyodvRoQJOxd4NgnUuUe62VERe9FZ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTDCNon7YVr5UVl5v2jyRxxTbe6E8Oadr5n572dvdoI=;
 b=D/NPtL96WJLwqDy27QEjdzoiMdlALYceJpgzCMjONe01P6jGiHKZQmNqplFo9d9fbFnucttd4S8w/7e4IICXVBW8HzYUsggGPr/OQtS0g8i3nRV/I9uhvv8CYeh3kkaibfnyRP2e6iNS9lEGMftnmtvjKH82SXyzk7ynCyVYD1Yz45ynUccsa5RSE81xD7Lo+C7WFkjsWxJ1j8OhdkjfCt4jmZf+08dcxUvVOvVIqWT2/RcGY+14+/RBZFdZZzfQzmq2pL7D/Ze+8SJTXt6DMn0nNNmeM9snA5w4n3/FwE727ad7yGHfemsPHtTIWMVIVyslFn5dZT9l148twQa5VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:95::6)
 by MWHPR11MB1774.namprd11.prod.outlook.com (2603:10b6:300:10a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.20; Tue, 21 Dec
 2021 07:32:54 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::c41f:17d7:bed3:7888]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::c41f:17d7:bed3:7888%9]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 07:32:54 +0000
Message-ID: <c84d9c47-0ef8-4e00-3724-b6e323c0bba4@intel.com>
Date: Mon, 20 Dec 2021 23:32:51 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH mptcp-next 07/21] mptcp: netlink: process IPv6 addrs in
 creating listening sockets
Content-Language: en-US
To: Matthieu Baerts <matthieu.baerts@tessares.net>, <mptcp@lists.linux.dev>
References: <20211216222314.1244708-1-kishen.maloor@intel.com>
 <20211216222314.1244708-8-kishen.maloor@intel.com>
 <e9dd7944-6eb5-b96e-4192-d52c98decffc@tessares.net>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <e9dd7944-6eb5-b96e-4192-d52c98decffc@tessares.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:a03:180::21) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:95::6)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d21b9123-8c1a-4ff1-b77b-08d9c4541a2f
X-MS-TrafficTypeDiagnostic: MWHPR11MB1774:EE_
X-Microsoft-Antispam-PRVS: <MWHPR11MB177482DD336CC741C0F76403E17C9@MWHPR11MB1774.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LpZnVy3o2XUEovkJaDvcoA88ddCZYFJg+dtVRhxBSmaxsGT5FUyFa6cccGV7okEFzw8EI2UJ+4xE2q+NW/JwT4l1DCmgIph2DmepUISiGd9y25q/nGWSNpb5XlMGyV7OdedGlh/zPob5veHr7mTr+XHCcZBlEvgyZfkDanYxsbU1y87o4H8cgE4zBZM05MFbh/MfssSf6KNvgyuyX7VL4FPdTTPAg95p+GCk+J6hxDc0RVbxRr97J5JNPlTlD8pcz2iNDH/evl7s3ZtaLf1OSuFW4M0P2eGLayxWw2jKkaj0iutNzwIzuM9yR2UvY7TLHHZN8hACD3n1AHltJ7pkp1lXAAQ8LD9511imNRWsbuuo9CiZG9+Uc3NldKsIhzQOyKSF9ZQi+ohghXb2kMmYXzjKVv4k7ddZBkecY8P9JpWBDkwIjHVGuGfL2w9ZdrZsCP4ZuWm8loqcrp1/8/u6cR6hwtAC79ajhach9OXguU3+zMHbw57vJy9KHH17fwWLTlvL66MEAKmJt30dmbrn2Q5Ft7K7XUodTWrS5/1eOVa7zOd6kE7XCIcu3pMZA/k8/J2Am1YSWtyLnLXNYeMLiQ2afvMHw6oS73dCmql/KhXXQMd92Uiq+/BEltz53BfamVZvpeTxz3Wad5WbIlknJ53M6RdJTYp/3F8uQSnN/uCYM5V3xZe82znwoIhNK+m7CTRSI5r7nPZCxK348VyIVFiXKZ9BpO1sAHVyO6+vklUQWNBXJNJKOLe1YhNiUkwT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(66556008)(31686004)(316002)(82960400001)(6486002)(38100700002)(2616005)(66476007)(66946007)(2906002)(6506007)(53546011)(6666004)(31696002)(8676002)(5660300002)(83380400001)(26005)(186003)(8936002)(86362001)(508600001)(6512007)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjF2eVlONGRtTTZTZERtc2FsblhWWUp3dzZLSGIzZE5jM3hTdEFsazN2dzRU?=
 =?utf-8?B?M2tlNXZWbFpGQk5vamZUcUpyckdNNnMyUTVmNzN0aXcvZVJMN256UGhKcjk3?=
 =?utf-8?B?YTVOMFR0dEYvZ2JZeENxbkg1TVVrTVVBL2hOQzZ0UHlHT0lMRTcyVFVPay9j?=
 =?utf-8?B?WEhmcWR6UDVaeWZwZmhtcWhUWHprL01kOFJHQUVFMjhqdFY4VTNqUWZ6STA5?=
 =?utf-8?B?blF1WEhwZmUrWW5pelU2VWlYMU5WaGNtajN1Zy9VTmREaHJ0ZmpHZmhaTUhr?=
 =?utf-8?B?Y0dTNkhINy9TbWFSOXRDRlJyYmJDUEhBRG5RM2YzVGFMSTRydGFVTmNyNUtY?=
 =?utf-8?B?ZEVVRFhwZkFsSjdvZVBUSVEwbkFlVjFoU3FFNktYNDNjSlpQYXg4WXUrbS9J?=
 =?utf-8?B?ZXlkYnNoS1Y0MXAvYUxKRDhhWEZidFYwY0dJRHIzS0tpb3pqRXVlem82M3hv?=
 =?utf-8?B?ekhwNWQ2Tkt1dzh0WHJIZGhNM21qd2dkajg2Y0pKTDEvaWlYdmk1RzdXZFBP?=
 =?utf-8?B?dFp5Y2lWU01semhEMW1mRVN6ckpMZ3p6ZDJxTVVncE1VMUFscnM2bmZXRXo2?=
 =?utf-8?B?WC9xeGJZTDNsQmEvTTRiRWRDZlJ0Y3FCOWl3WURMT25OVUM4OGpUNC9kMmFB?=
 =?utf-8?B?bEF4S1RpSUthZzVkcmRwOHNhNE5hZ2RVS0paQlhhdXNpZC9ncmc3OFcwdExU?=
 =?utf-8?B?SHpLRFMwY0lRdE04NEJHS1dUMDBRR3ZhZndPL09XckMrZEtiM0FGVmpTZmJT?=
 =?utf-8?B?ZzdRaWFGaU5jUDdXdGxTV0hGajloTURQVXlGK1N3Zm5OYjQ4THB6aS9ZdTFx?=
 =?utf-8?B?Q1RLZTh0OEZPRWtxbU5rL2FLZmJ5WUZFM0s1RVZVQWZSdVYxa3JUbDNJVDN6?=
 =?utf-8?B?YmlRTWJOK2FPMXE0SjNSSzQ2L0xmNnoxTGZCbmlZMm5aeEtETTZKbTNlaHVM?=
 =?utf-8?B?cEpYTjY5cVBVd0pmUFRnTVZ2KzNrbkZXY0EwTUQrN2hpRTJqRFVqUE9YblYv?=
 =?utf-8?B?UVYrMzlHeFJNcXBkWloxYmlQTHZtVUNNWW0zL0J1Qk5sRVd4MGN6dzhYWEln?=
 =?utf-8?B?aHlpazdIaGxHMHV4czhKOGJjdVhWYVllbTVuZ25VZVQ2TWZCb3lYbmtiZjN3?=
 =?utf-8?B?UVZGcmhEcExVa3FPNmtLNG52Z3Y4QnlLbVF3WmVOakgvV1g5SXBZbHNqNUZ3?=
 =?utf-8?B?bXB2M216Q0JxU0ZJeEtwdjNPa2swU21UWVF6Q0FjN2Y0dWJCbW9KSVdmdnJ4?=
 =?utf-8?B?OEJsaWpiVi84UnpTaURMeHl1RVFHNHU0NlZNcG5nODYxeWNDbjZmcXpaVUNm?=
 =?utf-8?B?ZEVQTkJGVFVwTEZoOGFjbkx3dXFSNVRNVk9hb2QyVS9rSnU2YXNCWGlKR2x0?=
 =?utf-8?B?QkNTRDhuck9UTFlaQWRDeURZRXNQT1hPb2lVeVdPL3Jzb2ppeDczdzYwWEVt?=
 =?utf-8?B?azE3WDhrblFIR0tuWjdCWm5haVBrekpMUmplc2Q1V3I2TTl1NDR2c3pJaDJt?=
 =?utf-8?B?RU0rOC9sT2xZZEM2RWFINm5WWGZoU3VzR3FlT05HZ0xiQXMrMC9UUW5KaFNU?=
 =?utf-8?B?SGhFUWVrTERwOG9HODRyZmp4bU4xWHdidjgzZDVHZ2R5ZjQ2T2lPZWx5T0NN?=
 =?utf-8?B?aG0zQXB1ejZUZUVpMmQrdmtzQVp5OXVnTFlBSnNWdWhSbG5ycW5yNk1UQUd5?=
 =?utf-8?B?OUh5cHFTQ2MveFVwRG9WMS9XYUlPdzBPTmdJQ0QyOEY2UVNLTnRNSmlSTS9q?=
 =?utf-8?B?bUVDYUc1eEk1TUxxZmx6OEhFckQ3NjhiQ2VhQUFSOXJ5VFY2ZThjbHBpQ2F3?=
 =?utf-8?B?UVVVYy92ZUdZckVvaXJiWUc4T056dnhkRHVzellPQWkzOHdIZXZZcXRqd2s2?=
 =?utf-8?B?Sk82VWdyU0djS3NsUUI0VllIenFMVnFHV0V5Tmk0enhhc1pwOGJnZ2M4V1JK?=
 =?utf-8?B?ZFFXaUlGRDJKbFhQWnRlUmVsWUk1bVVZeDBoZVdpN3RXemFoY0c3TThqQmRw?=
 =?utf-8?B?SENlY3pQTm0wZnVSVWprMW43QVh1UFhSTFU4NkJyZER1eS8zWXBnbzYzbzJT?=
 =?utf-8?B?UE9BcmVkSEdKOHZCQWNVak13SWtQQVBlc2NJUHBsbG15TlRJdk1oN3dyWFZK?=
 =?utf-8?B?aEdjTWYybmdhcGlDTFo4aTRFVFFubkRmYUVsQXRUMzlZSmZJdWRtTlNQa28v?=
 =?utf-8?Q?QpHBUQBhuIivohiyeYN31mU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d21b9123-8c1a-4ff1-b77b-08d9c4541a2f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 07:32:54.6731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BkjNGR5zjKHDwDl+7vSXy6YByUnRh8JnvJXwhHmrHLXtf7LwZTej51lmrbBi8XmcbWFIPU5kpscGjuqZM7n4AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1774
X-OriginatorOrg: intel.com

On 12/17/21 8:29 AM, Matthieu Baerts wrote:
> Hi Kishen,
> 
> On 16/12/2021 23:23, Kishen Maloor wrote:
>> This change updates mptcp_pm_nl_create_listen_socket() to create
>> listening sockets bound to IPv6 addresses (where IPv6 is supported).
> 
> Should we consider this as a bug?

We could I suppose, at least for lack of completeness. But you're right that we've
now updated the behavior in this series in attempting to create listening sockets (lsks)
corresponding to every announcement, which necessitates this handling of
IPv6 addresses. 

But prior to this series: 
-lsk creation (through a subflow's port) did not happen in the kernel under the assumption
that MPTCP server applications would've established a listener,
-lsks were created only for port-based endpoints which (I believe) would not work with
IPv6 (lack of option space), and,
-the stack did not allow incoming MP_JOINs at machines running MPTCP client 
applications (with this series, subflows can be established from either end so there
needs to be an lsk).

So, may be we could also choose to not call this a bug :)

> 
> I understand we change the behaviour but I guess we should have done
> that from the beginning to support IPv6 and v6-mapped addresses, no?
> 
> Cheers,
> Matt
> 

