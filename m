Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A889F33D6
	for <mptcp@lists.linux.dev>; Fri, 15 Apr 2022 19:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650049812; x=1681585812;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FRUBAYKf7Kpm/UqyE4mAZWkitRHKTu/UCxHJzQE6ycM=;
  b=IuWj+zOoGz9zKlQcaz0yplG9Z9sgEk2r15j2XPziiHCzmDNFOsCBv0ro
   R/1+oDmBpxLA3A28tMUzb3sgH0fY3seaBpxx6fQYDP4WxzVWIP1RTNub9
   OE94aHuP5H1j1KiRG+1QN6sXW/nGuq5xdVY22qpLgzWwdA3wUyvd+xSyk
   4YtDB7ILtL6grR3VOk3yPaTxdJZV0204wTQKO3r5Ak1f0ENZgkUd4v38X
   nRrk6ZNuTdfPYMolVMgTNmjsJGRh1pAsoaMC064odQBFEo71sNW9DbeJR
   xTMiSpexQ7Qh1K5GezcyueZfLX4vlEQKgP2udyKB0VV1MYV1ae7G7ciND
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="262672148"
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="262672148"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 12:10:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="624625599"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga004.fm.intel.com with ESMTP; 15 Apr 2022 12:10:11 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 15 Apr 2022 12:10:11 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 15 Apr 2022 12:10:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 15 Apr 2022 12:10:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 15 Apr 2022 12:10:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uvm+eU5B+YcVi8ZKK/O7n+Xzuw5A+x29/63ezNT7vVgxJ87gUy5wVXidNhwIpYt4sI8d4pJg/ep47ODKNGjJiopmZm6FBehJbeJ8ZtszTrvCEaW4r+J6sAQ+RKt5FFxJklAspTP5pILqlrzm01WfYyreByQI9Q/KPDQK5XLfOFpWZhfJxlWns4pT8qh8JEpyh25Gq9u3iRLJhiL3N+HGqCMq4IuZcoASh496EkzYmmDkiPbq3pXP/RWITANTr7kLx28ytTn3+UDIND7AI/q5OIio9QE17Lvi7sslhmW/KPobdoYaBz44FKXr7TZnhWVtHi5C5atyERaM477/uhfFIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKXSRL18Kq4dnW+N8MigYECJFyoa7tzRtgDtnDG4L4A=;
 b=G1OQRkpF9mUSwvT8Dhy2F1bXntvEApTnb9rzHFcsOY8WbaIsuONAXjnptWOE6dXPuP1qdPk9uMeGvi0uLn5BKoiabY9wE4LtfQQCAHLV6juLDw3qVeq+/dwg2RniQ8u1hTwQp483XBBgZzx17KMgyTfXlXHa9h6McPVsHakivvqcpygem8f/+dvG8JAmba+pa72rFymtR4PUNt7WuiNyWEVz+tivBCi7oqiu9BrP/h4/2GnWTwMbiqTIOvav66QIQ54CTsRd/PhMYMD46IXt6FsG0kWW5Ib+G4pnGg8i7wasBsBH7S7cJ0U3o+W5AYsWN2W4pqpH2SyCW+E64YTe5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
 by MN2PR11MB4320.namprd11.prod.outlook.com (2603:10b6:208:195::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Fri, 15 Apr
 2022 19:10:03 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::1d37:67cb:38a0:f3d1]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::1d37:67cb:38a0:f3d1%5]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 19:10:03 +0000
Message-ID: <fa6d257a-c625-a723-0808-aff2e33da9c4@intel.com>
Date: Fri, 15 Apr 2022 12:10:00 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next v10 00/14] mptcp: APIs and self-tests for
 userspace path management
Content-Language: en-US
To: Matthieu Baerts <matthieu.baerts@tessares.net>, Mat Martineau
	<mathew.j.martineau@linux.intel.com>, Paolo Abeni <pabeni@redhat.com>
CC: <mptcp@lists.linux.dev>
References: <20220414211920.1987961-1-kishen.maloor@intel.com>
 <af711184-4972-ac24-8a13-835c1196c32d@tessares.net>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <af711184-4972-ac24-8a13-835c1196c32d@tessares.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0009.prod.exchangelabs.com (2603:10b6:a02:80::22)
 To CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 534237c1-7689-4581-cd20-08da1f138baf
X-MS-TrafficTypeDiagnostic: MN2PR11MB4320:EE_
X-Microsoft-Antispam-PRVS: <MN2PR11MB43209594D108CCB5F3713DA6E1EE9@MN2PR11MB4320.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mymShziW+pnP1FE1VV4Ax/AfNraTmuhg2xivARDXMUxXVYEnhPLZoTANA0zEyYqE4lW1EuSd5LRH2zLRJ9wURTw+uT033Bg2q6BRTBZOfFcPb/rh1upfeGotbssUF3F7buuG+7x/gn/BGa6akN/lVyDpgzkWsnRMZj3jQdVUmy76n5CTCoh/NQYZyc7o7tw8bFFsCVYeS09e1rjBWaB3u8PGQg3Hmvfs2fhckKgH4Ii1xz5Y901ihPod+CkIu2I0gW7ws3EvYCRqX5xlHdg93aIC9115N0Unt0hfoy6aif7XlUVcwzSdW0EfAsZledReNT0wDeH/I5plPRNROAEABz5EuNgCKhdXvMbrdQhWslXHSPocID8FlJSkoDeQRa1ZsqF5emgKiq6lsbf6XctT6lKHee3Hpl42Lg1J8qtbeZCYbTSkKnO5YQ4jDuHvz5K/V6ebvsrCY/Xk3hcsAF0WrXIkR8jQB4zITWylOFPKVMGh8oiO+uUDM+ChlK0elbXojC1eIYmdGp7eavBRN1KfmNf6Ltc31vEE0w2hNy/hJJgwOUn1DCCgJVrgbWYCsNb/s6DrgzZ9E2vE++QCQslOwynQGicxHhOvUfhmDdHZZm5Ke7wmgEeTqT8CjgHoVZEismvcVn7dsR6IaX2Jz4ujdzrbAFuZtM3yd6oBT1bOdc3XOrzUefHMf62bl9SAiG3aWswQi25VS1HnJzJt+/hRgGxo69LExvGfg5don7Gge2whO7Jzz0OfhEe0z+KoghzqyCPfOQcxjzrDUlu56pQtSsKQnAh69cn6heB5fwjGGzj1p/LC4xpiWqiJAIpzycYd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(8676002)(36756003)(966005)(31686004)(316002)(2906002)(4326008)(110136005)(82960400001)(66946007)(66556008)(38100700002)(66476007)(44832011)(6486002)(8936002)(508600001)(6512007)(26005)(2616005)(53546011)(186003)(86362001)(31696002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkdlSGtmQ2kxVElORDRQbXZYY2NkUFZ2QTZDRGdrMFQxajFXcGtBZ015QVpz?=
 =?utf-8?B?ckZsTENUQXlzOC9nSFlkemZsZXBhdjJabUgyTG8yY0pGVlZxSXpIUFpueXdO?=
 =?utf-8?B?VFBsNnhDa1VWZnBDdi9QbHNaMkwxUXllZ283aHpBdUg2b0w1VzZIOURhWmox?=
 =?utf-8?B?VXpzUzZYSnFXSmNFQ2cvc3V4c2wrNEtMWHpvQk1qQW9aSG5BaWpkWUkxeVVa?=
 =?utf-8?B?RTBwQjdMLzlveXNTbGgyazllakQ4SjBoMko4ZVRMTXNFa1poRE16MjdaL3oy?=
 =?utf-8?B?R3pZejBPVUFYQWtGMHQxOVdtdmtIcURPQTlBZXJBV0doZ2N2WXc5Z1dmOCs4?=
 =?utf-8?B?VXp1VG1UdUh6cVp0cStCWVF3MU13eUtvbENHOEhrRllKdEpnMG1LZFh1S3V1?=
 =?utf-8?B?WWI3R3YreW5uTXBnUFV6N0c3QVZBLzlQM3VheVorWUJFR0hwb3JiV09UbVZU?=
 =?utf-8?B?SzRVUVRlWW9rMXo2ckxBNFVFMWttRUZLRUI1Qm1NeU5hZlZKanZTSDUyNDU3?=
 =?utf-8?B?L1dERnRWZUsyOXJEZ0RCak5BOW9hMjkydzVPdUtYY1ByYVVFdjJ6MzFwN25T?=
 =?utf-8?B?OENkWElhSlpTb2hKaTErQjIxNVFGcUdpNjQ5UHEyTUt5VlhiNlpyV2U1MllS?=
 =?utf-8?B?ZkgvdFprakovM0ZHTlI3WTVSRUV3TGNQL1BGNGRjcW9Sam1aamViTjJLcnFK?=
 =?utf-8?B?KzdnYlFFTWpFK056WUgrWmZPMi9HUWJUWTQ0SWR2a0dRNTJIclUrOHYwZ3U1?=
 =?utf-8?B?QjlFd01JQXFZZUJteVR2YzNSMmxzdEJMSnZnYkRGVmZOYmVCQlYyakpRUFdh?=
 =?utf-8?B?SE1JMlNsZFFWWHdaVG5RTUYzYjE2aUV1c1Fsd0RoU1JmS3lsTzV0NkMyOGpm?=
 =?utf-8?B?SVp4eTNWTGppQWJ5RjgvOWRxdC8zdlBUdnRxbUpvc25tSE1UL2M3R3h1YVJY?=
 =?utf-8?B?blMxVDZSUkEvQnBkQlA3dk1XMnNOSUo1T3ZkejJqM1VUUWVMdU05RVRvV2hh?=
 =?utf-8?B?Yng4VzRtZ0VGY1RrMnd0ZnRVMEYweHVidXZHMkZUSVdnaXFodnJsUUNlNzVD?=
 =?utf-8?B?a2xnT0pDTEx4MjJ4UytmUjlMaURLME54QmZIR1BBTlk4WUozeGUvTVA1QTNq?=
 =?utf-8?B?QnBFODM3TDRCVllRTHY1K3BqRk1ZV2x3bkxNWDY1NDR6TW1iT25EaUovVTFV?=
 =?utf-8?B?VFN2a0xnMTdrRlRNRGRYWDRYK3FBVE5pbjlGcXZaSkFqODVtSlNxbHZNVjJC?=
 =?utf-8?B?cmljc3NGc0wwelgzaWxRMVdYaTNYR0pxQ2R0d1B2Q0lsbkFsQWN1RTJyQ1F4?=
 =?utf-8?B?M0d6eXRUZnNpd1pQOERTK2lzVXFkT3FlRGhreEtVcVpiNmtKQ2JaUzR1a3lX?=
 =?utf-8?B?L0xqVmV6T3RMVzhRdkZyYllUM0VLNEw1V05jMUV0WCtuU01DLzZCYmlobE44?=
 =?utf-8?B?a01sTXV2bzVDdGNyLzU2VkdRZUhmZS9FUDIzNWdWZXlRMk54N29SN3F4TGM3?=
 =?utf-8?B?dS9EUEhndzk0Y1dGZmQxUTYyTG9zRXgwb0MvYmh3aDROc0M3ZllOcXp5SEN2?=
 =?utf-8?B?aWIvZUdRSCs5eG5aZ016NzZoU3pQVWxYQnJQamo3bUJoTUxURStLK0J1aTFv?=
 =?utf-8?B?VUFTWWwrR2lYS2JIRlFpMk1IT25YN2dCbHlSOUw4MFV6Y0tsSmFoWWxsSmhB?=
 =?utf-8?B?UG81K2dWb1V3clAzN2Q2NmxDWG02UjV5eFhiN21MZ0lvWDFIVFhOYndCdVJr?=
 =?utf-8?B?amp4RWZMNndXZW4reFAzcTcwU2wxZ1RMelRkWVNKblljcVdoanpibE11SE1l?=
 =?utf-8?B?bTRlNW9HNmlFY08raW1TOFM5ZGYzeFR3VzY2TVRJVXBzRFNKMGpUVW5ybGgr?=
 =?utf-8?B?a1JCcHpWMVg5bHdhM0V3Vmk3VDZ6V3pSVjQxVGI3WVYwaFY1R1N3SEs5ZVRH?=
 =?utf-8?B?eTcyMVZ1RHJFUHNzWlZTM0czcnRDTDFGVWZPelk3WEJJS291ejVVZ1I3eCtw?=
 =?utf-8?B?Vm56ankwaHliNnFwQWRVVWE2TFBFYktrNXA1NW9tdmpLMVpnU2dWVlQ2bTBn?=
 =?utf-8?B?RkZ2YzdmNElIRnk2V1hyTXU1WjhUdkJMNVo5UGgvOXBvMmxPdk5aQWpVeWtM?=
 =?utf-8?B?T0crdGcvcG5ETno5Um1qVzl5WVBsMVBOcWUwMm9LNnkyWjZ6RjBEWnhtUkpR?=
 =?utf-8?B?OEZKMlJqM2RJeWQwQllvZ2RyNWFKbVF3c1FDUzlXWDZWVU00dzhGRzNaeXJJ?=
 =?utf-8?B?dlJXa2JiNnlkR083M1krRVdReTJvd0NsbUJ5cVpNK1U0MDFZbGFUU1pvb0ZI?=
 =?utf-8?B?eFZmS3VxcTFFaVRaNFU4cEJIL1JBR3hlMWM2Q1ZyR2w3TmNnK1RuZlFmUERS?=
 =?utf-8?Q?DO/2/rXh4BXiAc4g=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 534237c1-7689-4581-cd20-08da1f138baf
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 19:10:03.6928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vyvu2Y9YKcYyb2LXNm/DhUEYP+WctGQqUR7IiTXQO3lMWoRL/BVR1zkh/mA4auzdbGWSMisCgfj21oknNqYpJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4320
X-OriginatorOrg: intel.com

Hi Matthieu,

Thanks so much for the merge and for taking care of the other CI fixes - appreciate it!
I had missed those.

-Kishen.

On 4/15/22 3:54 AM, Matthieu Baerts wrote:
> Hi Kishen, Mat, Paolo,
> 
> On 14/04/2022 23:19, Kishen Maloor wrote:
>> This patch series brings together the base functionality
>> and new netlink APIs for flexible path management from userspace.
>> Further it extends the MPTCP self-testing framework to support the new
>> netlink APIs along with the ability to capture MPTCP netlink events
>> to aid in functional/behavioral validations. Lastly, it adds a
>> self-testing script with a suite of test cases covering the entire
>> range of the new userspace path management capabilities.
> 
> Thank you for these patches and reviews!
> 
> I just applied these patches (feat. for net-next next) with Mat's RvB
> tag, Paolo's Ack:
> 
> New patches for t/upstream:
> 
> - c2dcdbadfac0: mptcp: allow ADD_ADDR reissuance by userspace PMs
> 
> - 26c71440e307: mptcp: handle local addrs announced by userspace PMs
> 
> - 5a865082c99a: mptcp: read attributes of addr entries managed by
> userspace PMs
> 
> - 899ec4b7d092: mptcp: netlink: split mptcp_pm_parse_addr into two functions
> 
> - 37d4d520025a: mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE
> 
> - 90e75a0f1e7a: selftests: mptcp: support MPTCP_PM_CMD_ANNOUNCE
> 
> - 151abf946ec6: mptcp: netlink: Add MPTCP_PM_CMD_REMOVE
> 
> - 961b8d01cd00: selftests: mptcp: support MPTCP_PM_CMD_REMOVE
> 
> - 68f10488da73: mptcp: netlink: allow userspace-driven subflow establishment
> 
> - 04de6ee0fd99: selftests: mptcp: support MPTCP_PM_CMD_SUBFLOW_CREATE
> 
> - 337354cbefde: selftests: mptcp: support MPTCP_PM_CMD_SUBFLOW_DESTROY
> 
> - feac5b7157cd: selftests: mptcp: capture netlink events
> 
> - 802a0fcee8de: selftests: mptcp: create listeners to receive MPJs
> 
> - 7a589792c590: selftests: mptcp: functional tests for the userspace PM type
> 
> - Results: dd31cb34f82b..f0428dbd45eb (export)
> 
> And an extra fix for the CI:
> 
> - 6505be1e8a40: Squash to "mptcp: handle local addrs announced by
> userspace PMs"
> - (no co-dev for that)
> - 66af7c7950d4: mptcp: remove dup mptcp_pm_addr_entry
> - c14d95c1413b: conflict in
> t/mptcp-netlink-allow-userspace-driven-subflow-establishment
> - Results: f0428dbd45eb..4fa4540bfc5e (export)
> 
> Builds and tests are now in progress:
> 
> 
> 
> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220415T105031
> 
> https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export
> 
> Cheers,
> Matt

