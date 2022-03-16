Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C626D3D6B
	for <mptcp@lists.linux.dev>; Wed, 16 Mar 2022 23:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647472986; x=1679008986;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=8C+JIN5GUJvzmxnBdZpwR5C+5tpWrJJhGl74VFQ/IkE=;
  b=MwlMEjjxD9HNTJMegSPqyW4+d52kp0EnPYQalUxqwlGqGQK/mb/85ZXL
   CyOZ/82cXVu4Wkx+6NBfWwp691bIrdNnEjnqReIge8u6FpmZypw5SdREG
   rifCHtl+f3Gy0KLQs18frk5NIAEeg1R1SDdZhM5qxKhWhIIapPa1/r024
   NX9VW+jakCeCjfY3DvOwQefROWGnpw9bSPbdhgn8AuyHL05Cn/Yk0n2VY
   lOIWJNYRMplCj3BzXnecz/A9T5i836hLrbHi35z/2N29WRtKIZ6jnzNxr
   SfYzhsNMSBprTyy2ng1PxBdYe7r18XnbcbKX6R6kFaLYBtCpa07tqIaXS
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="254292093"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="254292093"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 16:23:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="557674498"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 16 Mar 2022 16:23:05 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 16:23:05 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 16:23:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 16 Mar 2022 16:23:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 16 Mar 2022 16:23:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3IsnJySVR6KfRMaY/IR1qbsOQ0f4NeE4RNLL+n8MRxNd+Ib70Q5yS6U+eD5ikYzaoKrIdaGM88Tf7agTiT/ORhXcvdbRtKXV0uZouIvu86CZUcmPEqDcbgmEGE/QYej5qVImdVb4eWVoFdq7WSNYfeP68cXNL8jaXxUR3AIGXXY5GmtIEUoyXdAfY/2T1x9/3pf0QPkla8vXQx+gPRgbVPFadoGrzqpwkCYLFF/uilhAZ+Q8IZ4wQHa6DvcSEdtLg5rubU1gA8sDyIPtGOhvPA/vQfVzl8tBeB72Xva7RnTsyOQIwFA0h6d7oeeQaGtCRdeuXvQiVLrAkgpj1PpkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcZ8r6UcWpR9FGSiPhXtHnPoldtqAxuRX9nRkMSv2KE=;
 b=TBxIKyXbsgq8770B0CpU1RY2N5kboQH3n8DJZmQPgD8DSgg96LvMWB3Z2Tsj+ui+dgRi/ofiftGU3C41sDZ/ZIhk5zp+JpJDI77ORYBVKXvBVxLQqrPGYzIysiK36nmfGQOLOD6qTthaXNALhotzJGjXeehQXABH2F8ZbwH5+cFGX8Hija8GA2yDwGc7y24Cpfsfy6IhmkUhgQ1GLQ3k91LeA+LtOxtYxce5wacRHVqFsOqdtKMQF472/+bV+52807trNPqGF3n1pJEIhu10Os1DY0LE9Jv+4wOc5yZUbq/Ysq0bTN4wlXZAnffVdPqXrGxtDWpjIBVUV6p9tLy8ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
 by DM5PR1101MB2297.namprd11.prod.outlook.com (2603:10b6:4:54::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.16; Wed, 16 Mar
 2022 23:23:02 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::44ba:c91c:ea6c:118d]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::44ba:c91c:ea6c:118d%4]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 23:23:02 +0000
Message-ID: <5db496e4-ab36-3a11-531f-f16252955d7e@intel.com>
Date: Wed, 16 Mar 2022 16:23:00 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next 0/5] mptcp: fixes and enhancements related to
 path management
Content-Language: en-US
To: <mptcp@lists.linux.dev>
References: <20220316190747.634325-1-kishen.maloor@intel.com>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <20220316190747.634325-1-kishen.maloor@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:300:16::28) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:9e::21)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72e88cbf-6265-4bd3-639c-08da07a3eac0
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2297:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1101MB2297F81AACC3C76103465E8DE1119@DM5PR1101MB2297.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4VaPKnfI8Gjs9XwkLE3kGfmUsnTDJuarzbhdNwp7BZk5JiPVF/DRKqY5Ts6xTnDIOpxnkWyAILB46KPjWS5/gdI/r2TG3DHiRbTnOymK+Pi8rPvwwmR0qTJEc6mpjvpV1xUfq8I1io1zE7OhyCvyQO0LaKHAGA+MoymihdwwgCFGRAOA98GCPDtIKjbPSvEaQoQNMDybcBxi27ffZQ4Bmwq+SioOcLr7UM4jISdnk9XDascKt0tuPVWaX2+Ttxk4o1uAYoF8/lIYo9cvBJgyRfZJRz0kc1/22Ol+taBt4gPTVBniRHeoy7pOY+ZxqGEeIXCQrHXfEvr0oLEhW1hNpkkL2bxsP2y2XdQojNVX0KYT2P5HjI2K8fv5IdCSBKjwN7jBN0w+io1azsr89uBwqyjfl0UXcRTO9uWiSCVJereLJOEqbnCjG8a48uko92T5hCANMx9lt/cyelHAogBOcIUf3+VxAk5S+OKfJ6VmHLJWyp7WXGM4MpX2qvZFk6uzvdmqNwBWQLCBgWrBORArC+5RkMLx/4c1cy6ptEqJAW7+72vYk5/1Pr+A2Jjn73itDQBD5/qR+AoFMBlKjp3aADDEatfzKJ0aweT+arEESZJpTAcsG13EDf0b7HFt7gGjFvrC4crI8jQ0dcKPRMGC8dkdV3RTs2UOa4EMEFxYc72GWxlb84/hd9DDBjyJFzJTbHI8yVNmL9T30/B7ZgYCUUSFS18V9cWbrslzgyIvvsc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(44832011)(6506007)(8936002)(53546011)(6916009)(2906002)(316002)(2616005)(66476007)(66556008)(31686004)(66946007)(8676002)(36756003)(5660300002)(83380400001)(6486002)(186003)(26005)(508600001)(31696002)(86362001)(38100700002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU1jOGRGSERGN2FFaFRhZVlibWwwMnhLaFlOKzFaZDB1L3JrQkl2K2JRSFhv?=
 =?utf-8?B?Y2k0aWt4M2k4U2NtMnZja3VvTHN4N2pGTWRiQS84c2h1Q2xXSkpDc05lOVVY?=
 =?utf-8?B?N1NxTnZLcHhyRzlRNFZCdElhbGQwT0Y4U1ZCV1pNcDdobTVyK2FuMllxMzR1?=
 =?utf-8?B?b3FsSEVwa2IzcjVYckdzZUFlbHpENzVpbG1OVUxmcTdIY2s2UkRXWTJiOGpL?=
 =?utf-8?B?aE5obzQ5QVZBWGZBUTN4TGxFbEl4QTc1S2o3NXJ0YUZYUXhGZzUzbGxnSCtW?=
 =?utf-8?B?bEF2VkJQQmJ3M1RVWDFsenJvK2wxNCt0eTRHcUpzeGRhU3hnNEI1TXZwOHJz?=
 =?utf-8?B?R0dYYXZQOEEvVEZET1Vkd2NWSjVSRE1PbWo4OGszQ09Cd0wxTXlDSEhHYUhV?=
 =?utf-8?B?UnkzZW5nU0lGWnVCWFBkSmM1OWVXVEpLeS9DMFZZSDFKRzZCWVVvU0xtZFNQ?=
 =?utf-8?B?UUhZZ3IyRHNRSkVIYkY2V3dlRnJZUmM0bnVXZG1XN0lGUXczbFVFWVRGU3Zu?=
 =?utf-8?B?aTkyWHhGdk84L3F2YTNVZUNTR3c3YkJadStpN281TlozRUMzN1pRMmEzMm1z?=
 =?utf-8?B?OHRCTUhBYnFYZzYrZmx6YldrNS9QcnJBeHhUaUl6ME5KZCt5ZUpZeG1kaFBM?=
 =?utf-8?B?V0U3VVNXMUZHREJnKzJpUEhXc2hpeU1Cbi9RTExhMkxsMlJUTTVYM2NHK0V5?=
 =?utf-8?B?US9iRTF3Rk12R1E3bWo4MFhRaUV5aUVjeFZiWW5IanQ4NzdvRDltOGJVRlpU?=
 =?utf-8?B?dElUVVFUdUdSMm1vVkJHNGFNRjZaSG0zcHdqUDNFREpJV0RHUUk5VllvM3I2?=
 =?utf-8?B?d0lGZFhmVHRjU3JXWmVtMU0vaCtGbk9aT0xaWUxIZDFpRFVIN0pkdWRDVWx0?=
 =?utf-8?B?cld1M3JxNis0ZDNaNkRWN0Z4TkFBWkR5N1V1L0tHSFFPUWZGR1hhckY2OG91?=
 =?utf-8?B?dlVFRGF1cHh1UEl4QWZpdkd5cVNpNDlYd1k0TWswU3dkRkVOWVZqampKU1FQ?=
 =?utf-8?B?M3MzdnlBL1VnSDV6aEh2VndIQzRLNFlmOVZwUkRlZ1JwVnNGUDltQTlJdlZi?=
 =?utf-8?B?RkVYSzI2d0N6YnFiUm4rWnZONXF1ZHBjRWF0YzJuMGF2a1FPa0FTbkQycTJx?=
 =?utf-8?B?Z1ZPN2dSMHpvemw0RWlpK094ZUQrdTNkVDRucjljVXRTdDFWMXhBd05wdW84?=
 =?utf-8?B?YjJKdCtEYTZzUlAyczEzYXhYN2w3SlZVbWhsQXd1dC9vdTg0MHZVNDhlVUtX?=
 =?utf-8?B?My8yYWQzL3RxMTdDdXRMK1RnT0dVUkRzRlJtRDhKT1ltL1pJYVVyczhIWWtP?=
 =?utf-8?B?amJKMHJtNHpJRmEydmVSV0pCV2VHRVk5OCt2SWR4UStUL2JVR003Y1diZExm?=
 =?utf-8?B?WmdhU3l3S3JZcHRqaVZhNHFXTHp5cDQ4c0VWWEI3ZjVIRS9FTER5TXljcVNm?=
 =?utf-8?B?L2F2UzJGeS9OQTRBT0lZQml5L3BpMnZiYXhhYWVJbURpczdReW44Wk9idGZM?=
 =?utf-8?B?SE5UWkVFNXd2Qk9kc0h3OUF4alBPaWUwSytNdGJuTEVQcXFDaUg1NklJUW81?=
 =?utf-8?B?Q1NXYjIyckRoNHJKd2JEaHJ0eHE4ZHVOK1B1MFJZaTc1R2lvVVFaazZEb2dR?=
 =?utf-8?B?UnVFUmJoNFBKd2dhcWFqdG9NVlhuNGljYUdMUWNPRWFZc212RHVRWW5hY1hx?=
 =?utf-8?B?NGx0ZmtqQ0xaOUsrMzhOYTNnbmswQWZ6d1EyVWIwTVF0QW1CQXZVNkNxMzZZ?=
 =?utf-8?B?b0tnU3RTcGZnUXFqOUNKbm1mdzk5Z1AyVTBmbm5Wd2RnbTR6dVo3VFRqYklD?=
 =?utf-8?B?RURJaUd5cTRWejNXYm9FV2xXajNQVld1UG5lNllTWHVHMVJ5K0hQZ1NiV0hH?=
 =?utf-8?B?ZjBlMU1jejRKdlV2c1BmaHZ4ditUSDJvNllpSU53cGhySG4wRlBWTWUyZXN6?=
 =?utf-8?B?dzBQbGdHd2U3eFBRN1dCTENWU0E1azVrays4dVZ2VU5MU3Q2N2g1QTIxQnBP?=
 =?utf-8?B?TTVhWnpyQnRRPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e88cbf-6265-4bd3-639c-08da07a3eac0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 23:23:02.7448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TvUHmhBRiiJm8ZBpKmdp1V3Y0IKkMU/w76SIGGp3WXZP3XXcq9osKhq+CJyF1W88/pzM4VKmpacrYThTOiNSDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2297
X-OriginatorOrg: intel.com

This series is technically v6 of the original
series with the same name, but with some dropped
functionality based on community discussions.

On 3/16/22 12:07 PM, Kishen Maloor wrote:
> This patch series incorporates fixes and enhancements related to
> path management over MPTCP connections, particularly in support of
> userspace PMs. The changes ensure that the required bits of
> information are conveyed through MPTCP netlink events which
> would be consumed by the path manager in making its decisions.
> Further it adds flexibility in establishing paths and from
> both ends of MPTCP connections.
> 
> Kishen Maloor (5):
>   mptcp: bypass in-kernel PM restrictions for non-kernel PMs
>   mptcp: store remote id from MP_JOIN SYN/ACK in local ctx
>   mptcp: reflect remote port (not 0) in ANNOUNCED events
>   mptcp: establish subflows from either end of connection
>   mptcp: expose server_side attribute in MPTCP netlink events
> 
>  include/uapi/linux/mptcp.h |  1 +
>  net/mptcp/options.c        |  4 ++--
>  net/mptcp/pm.c             | 21 ++++++++++++++++-----
>  net/mptcp/pm_netlink.c     | 22 +++++++++++++++++++---
>  net/mptcp/protocol.c       |  5 +----
>  net/mptcp/protocol.h       | 22 ++++++++++++++++------
>  net/mptcp/subflow.c        |  5 ++++-
>  7 files changed, 59 insertions(+), 21 deletions(-)
> 
> 
> base-commit: 2a9f09777d24fc18cc62762b398054d3961ad8bf
> --
> 2.31.1

