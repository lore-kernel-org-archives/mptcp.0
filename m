Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E622F27
	for <mptcp@lists.linux.dev>; Tue,  1 Feb 2022 21:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643750426; x=1675286426;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JtQNyhJqEtd+RAGslhRsvugFlamSZOl5gH7RgdBCeWQ=;
  b=QVUTAYjmt1cpNKhw7D+0eRiDZsl5tXCcviiazdDFZCFSrATN5s/PHGfW
   fJHRTTPG++82HstYWvXa34lzkYZyywErDrBi5Ltq6mRs1FonDn353rqxw
   f9W+DOZ1vzKRayBL6kliMSzPHcfzoqfVQ7HSMOQqokW10myOmGktYngLc
   SStTT+ipxY9ZrZx25rlnZGEFBQ4yKpLKHov7AnxGIyDA/CdsMWlRuyBj+
   K3IwRA2DZ/m2nFekEhKJtDN1qcGhOvG/GTIKrUioiidXPIXPwDIbcLvPZ
   f+lqTvvG8kPN6W4aOuWNxBvx3kuHyRKRLKYcgLr+qqBO86dkILFpJDk9G
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="308528652"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="308528652"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 13:20:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="565735678"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 01 Feb 2022 13:20:26 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 1 Feb 2022 13:20:25 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 1 Feb 2022 13:20:25 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 1 Feb 2022 13:20:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcXIDkvcqjZz16YdPnRGKA2NilPO9lUje5ACkGDd9kyU1LQzRLOQSpNJNgfRhiCzv9gF3BHLIGy2ktrP263YUwYctUUJ9y8ByS52+gjqJZXNBSaKpwFmMA6p1Z4xaGFRjmBxcbBzKV4lJfrkll4c2L6kOk8oCVTCUegBIy/GGiz8m9bTmEgS6fBc3oOnTKlkL1Wft97kPs+sHOwdA94zR/1Bxj1l6HM6COYVaQrRLI0t3iheQlqKSdkw7WiOoDuX3fuvQh4tnwXbpJ47aATvYDPVDb72e7g80JiQeYpYZAPEQO57PLe8HwxycnhXCIZEVNb7gzR2RKIVJAnAMFIe9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWw04hhZ/gFaYuG+21r1QsAnHSt38o6pXyE70lEujcw=;
 b=EGOiCQadu18MF8UjueKKj/MoZb97JVTXstUefdpiy1kF7MDvKkEOAV1gjhQLBi4qe3MnRCIVtBueZNDtqGY8LlZH6c/mBnFE5Gm8B+IN6Lz04MDmQBYswgaCEdjpBLAdMx++ctrE/VcHtzzONtC5rgqW+l7rxgz4KQFlV5GK8LutPkEnC+QNCDF/Xcxlt2wjV20xM2nHmZMixLMllr5iXmUip7rg6FeOTnYkkV89rqR1ey/+BSMV2kmdkpnsCTSpvfPSFoKGENOaEpRJP2vSHERBB/2xxaUxmr3iVkp4wbp7RYAZIEQXYe1a/q90ZxyRB8AaSgKBNRdQwqcwR1qqDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
 by BN7PR11MB2547.namprd11.prod.outlook.com (2603:10b6:406:af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Tue, 1 Feb
 2022 21:20:23 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::44ba:c91c:ea6c:118d]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::44ba:c91c:ea6c:118d%4]) with mapi id 15.20.4951.012; Tue, 1 Feb 2022
 21:20:23 +0000
Message-ID: <eb8a98af-f3ce-40ab-bfb0-ab97c702b82b@intel.com>
Date: Tue, 1 Feb 2022 13:20:20 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-next v3 01/14] mptcp: add sysctl param to limit
 userspace PM activity
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliangtang@gmail.com>
CC: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20220128003836.2732694-1-kishen.maloor@intel.com>
 <20220128003836.2732694-2-kishen.maloor@intel.com>
 <CA+WQbws7UHpc0LA3kd7wSqB_k-6aEN9HLm_JbeNSi0XzsPw=Gg@mail.gmail.com>
 <01efbd33-cd64-8b71-7553-a80a9348f6e6@intel.com>
 <ae8ee5081d51235ed2c97edd023991c398e632c1.camel@redhat.com>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <ae8ee5081d51235ed2c97edd023991c398e632c1.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CO2PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:102:2::19) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:9e::21)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f4687da-aa47-4b10-687b-08d9e5c8a8c0
X-MS-TrafficTypeDiagnostic: BN7PR11MB2547:EE_
X-Microsoft-Antispam-PRVS: <BN7PR11MB254762C0C98CD3C0240A0DBFE1269@BN7PR11MB2547.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qH+O/haJ0i1WDJYPd8JrId/Xww/YK8KQqChUt1iuY9dDIjr8UqPSeKLo0fZTuhH78BbfkcJcG6TzfDway4ecrwl5Nht6dOvjmM+bsCZ3fezpHKHOPxIrSyHUaztezMGEKkcKhBQexpbphl4ojqusDa2sAjEa5dKLD2QuEH9xpIGxgOX2tbwfdzf66ggMfxuRYvzn1/T3nkP4afR5DiOIU9O0kJh31yM/aIR0UPmrBldwOify/hkAY/1Dgx3yzQHNhP7tiWmjjvW5JX0bl42ub7AziEgTuvQ3V2POft9Z4T1HfjpyAdfm9QlFMPba2LBMoDd4FBUBvdq6t0xnUjtxxOZffyDvCfqWABQD36iLiNR4Cd6AtiAF6QgFPjEpmlX7Au9niPpAm/4ijQR6E4E2bi0WkNw7Amdv26Wo54YO9Oscwc9NjA5P9MYdelXPs2YqzxwiUV1gNXaPmrbY/cWa8+5B42Kctnq583tKZvBIWoXxM0sInaEYC9QYGCHG8uynXCSN6uVVur3eMDBj0lxMFVNfbzbq7grI+Dg7V9054bxrqqaEUhrgv1454llfbO1P9vt09x+ldOtmDcfgm8sNek4A2IuLa046nHMbQ1L5rHfZ+nn8KFcQdE+QADlz1evAfnrFfjwQcfoctIeoV1g2bzy50CdZHHNVDUsy6Ya738r+rf4msTkeMN4C5l7xTFG+/xi3JPEtL4V5GZLK1qbGwqMba+ZTSclCZLTgoDzyvZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(8936002)(4326008)(82960400001)(31696002)(66556008)(316002)(66476007)(44832011)(66946007)(86362001)(5660300002)(110136005)(38100700002)(83380400001)(508600001)(31686004)(53546011)(36756003)(2616005)(26005)(6506007)(6512007)(186003)(2906002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFNEWDl3RFpzcEkwbnhDWmVEN24xUFlld0xXYS9CNHpEMER2VGdERFk0OTY1?=
 =?utf-8?B?MFU2Q0MvTjBrcUh2K2pTckM0VUhXUlJKa0JZa2lDV3Y0K3kvZ0hoUDRPeXAv?=
 =?utf-8?B?Qk9CS3k1U012WitMa2QvWG5Od2x2QTYxWkgrT2NTbUNJK0I1N2FvZG04VW5l?=
 =?utf-8?B?NUFhaUhkYUpwQ01XR0JldGxYdVQwMDFlblZRR0s2eTYzemZ1NmwwOGcyNlo5?=
 =?utf-8?B?RUMra3A4ZG1mTWQ1TEZKMTcybS9UbWI5Q1pINk9GQXZUOFZUUGcwVkdkRHlW?=
 =?utf-8?B?VTVhZ3ArY3I3dW5JV0tuWVF0em53QzhaQmdpZ3p2RElNWDdzd3Vqa2piZFlM?=
 =?utf-8?B?c3FnNU0xY09OckJQQWx3TS9pdHNjV0RZa0V0NG8wM0hiLy9LM01oNnBySUJ3?=
 =?utf-8?B?cXBETWlJN04xR2l6T1A4VlVLZzNCN3MvczFJT1ZXMklmSHU5RjZpS29WR0li?=
 =?utf-8?B?NXR3WDlMM0Fnb1JCQ25RN1JjdnpOSGZGSnYzRGlIVjNEUXRhQThsWEc3MlFO?=
 =?utf-8?B?eFFzQS9jdFJvYzZaTHBMTnJuRlNwOGp2L1E4UzdLRlhLKy9rRHhYQUl0TjNt?=
 =?utf-8?B?UUx4RkxMeHEvczVxaGQvRGIweGVEOUxTR3lCSTFmbmM5ZmdtbHJ3UUxLc0Ew?=
 =?utf-8?B?R0wrdjJqeXB1UXZqRTUwc0NlM0VYTGU5TUhYV3NPSWp6YTZ6RnpRSFJjM2JF?=
 =?utf-8?B?SW9zR1ZQTS9zWnFvZ2VJSzN5YjBPMEk4WjBENm9BL0VsN1UwR2IrK0doQm1o?=
 =?utf-8?B?cHR5OWE5aVl1RG1RUjRJang4WHJvTGZwNThFbVVhRmdiUVF1a091TjNXUE9K?=
 =?utf-8?B?d0lITnVwOEpHcnJ1eHdqRnNJNUpvckxJSHdWUmdkTFlEYW1GYlhwSTZkM0FQ?=
 =?utf-8?B?ZnV1UkwweDBRQllWTGZIdCthb2dDaEZxZjhTQk9CRU9lcmNhcjh0K1grRjFr?=
 =?utf-8?B?WUloYmhxYVV4MXpDY0owL2s3UE5XZjN1Vi9UTTV6eE1HcENhQjFHVHJPbktm?=
 =?utf-8?B?UWpDVlNrWlNIODBqUnYzRUU1ZkVld0czejZBVjdFQk1KdWRpTFVhdU0wV200?=
 =?utf-8?B?eDVpNG8vMGIvNXQvZXpwVTlOQVd6OThJRlZNZDVDUEl6QVkvY2JwYkU2VFly?=
 =?utf-8?B?ZTZlZ1c5TzBMcWcwMjhaYlcrMGtwRnhmSkR4dWl6QkJkQVgxQmt5cHlHVWIw?=
 =?utf-8?B?QjNpRXNOVjJjK09EaTltREwwWUlKT0hIdXlaN1pGWG9iZGswK29Td0ZjdXA2?=
 =?utf-8?B?OFpqeE4vT1hjSDZEN0pnbWFkdmFvbndKYTV1aS83ek5nSFMyTmJ1MzlocnNn?=
 =?utf-8?B?LzAwakFIZzdRb1QwWHF4dEtaS2ZRODI4V0hvN3pycktJTDg4dW5OTjhEY0FZ?=
 =?utf-8?B?NmJtWjFmWVdNUDdrVXNEY3ZGMTRVREJBUlhhRjRNZnpqeStTMDNaRDBXWmxL?=
 =?utf-8?B?M0xFZGxmbzhXcXNORUtyZCtwSVh2amlLYm9YaDdZdTBYdms1YS9RY3lkaCto?=
 =?utf-8?B?Mk5Sa083MlZ0VFNCVHE1OE8vZzNUSXhLWDI1c1FGSGdteDZqV0plNWRZejNv?=
 =?utf-8?B?U1haN2tQekNVMnQ2Y01XS3MxY2JkWUFndjdUZGFIWG15bkZYU1JrNmVZUExU?=
 =?utf-8?B?Rm9kRWtWVlZaMG5lL3BxZlN6QkE1a0pZYWNIeC9MVllrTlNEV3lBOGpqRHhj?=
 =?utf-8?B?TnFmR2pWTWxVQXNNdzBTMHJ1Q1BDVEdDNHV3dmNDUjYrQVdvamxkMTEyOU5n?=
 =?utf-8?B?OWowZElYNi82V2xsY0trandFUzEyQ3ZhRTBHN1p6MEkrRGVRc2hhSWlsNXdZ?=
 =?utf-8?B?dzVGRGFlVUJ4WFRQa0RlRllTdVJjOE1rL0t5TkRtQ1hmZWZRVmY2dnJpQ01q?=
 =?utf-8?B?dW03NXRiMysyamk4WCtob3E5SCtBcVlFcFhxalNaOXhLcG9DSWhOVFJTdjR3?=
 =?utf-8?B?T3dLYnV0OVpKMTNKMTZpVDdyY1FaeWFwZWNEcXprUU1GWDVhQmhXdU5welpO?=
 =?utf-8?B?R09QREk0RDFyNmo3K2d4NEVBWFExWWNBMUZoYjEyNTd0eEY1OVhaSnZpaGRT?=
 =?utf-8?B?NFJGNnB0Zm52SUwxbUdsWmd5d3hMdTZpZTFRRnF2L0dFWHhUanBMQ0hoUE5M?=
 =?utf-8?B?RFpnUWlvekc5dDRPY2pFTVBTRW1USVhpU0tKNnlQUEw0RmxyZmdlVTlYR3dM?=
 =?utf-8?Q?Cr5NkagC/bHxTxxgBRovYKQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4687da-aa47-4b10-687b-08d9e5c8a8c0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 21:20:23.8120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFqQcfTsA5z/nZMAXqIPBeCpFNL7ptkG3Z40kQwYfTUR7g1MYljYwSSHi7gt0bEGgfsVNE4ESmRCMY1XlyXJ3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2547
X-OriginatorOrg: intel.com

On 2/1/22 3:49 AM, Paolo Abeni wrote:
> On Mon, 2022-01-31 at 14:23 -0800, Kishen Maloor wrote:
>> On 1/27/22 10:38 PM, Geliang Tang wrote:
>>> Hi Kishen,
>>>
>>> Kishen Maloor <kishen.maloor@intel.com> 于2022年1月28日周五 08:39写道：
>>>>
>>>> This change adds a new configurable param userspace_pm_local_addr_max
>>>> to set a limit on the number of local addresses that may be recorded
>>>> by a userspace path manager in the context of any MPTCP connection.
>>>> Consequently, it also limits the # of subflows, i.e. to as many that
>>>> could be established via the bounded set of local addresses.
>>>>
>>>> The patch also ensures that other stats inside struct mptcp_pm_data
>>>> that are updated along kernel code paths exercised by userspace PMs
>>>> remain untouched for userspace PM managed sockets.
>>>>
>>>> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
>>>> ---
>>>>  net/mptcp/ctrl.c       | 17 +++++++++++++++++
>>>>  net/mptcp/pm.c         |  4 +++-
>>>>  net/mptcp/pm_netlink.c |  3 +++
>>>>  net/mptcp/protocol.h   |  1 +
>>>>  4 files changed, 24 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
>>>> index ae20b7d92e28..dffc2da6d713 100644
>>>> --- a/net/mptcp/ctrl.c
>>>> +++ b/net/mptcp/ctrl.c
>>>> @@ -19,6 +19,7 @@ static int mptcp_pernet_id;
>>>>
>>>>  #ifdef CONFIG_SYSCTL
>>>>  static int mptcp_pm_type_max = __MPTCP_PM_TYPE_MAX;
>>>> +static int mptcp_max_addrs = MPTCP_PM_MAX_ADDR_ID;
>>>>  #endif
>>>>
>>>>  struct mptcp_pernet {
>>>> @@ -32,6 +33,7 @@ struct mptcp_pernet {
>>>>         u8 checksum_enabled;
>>>>         u8 allow_join_initial_addr_port;
>>>>         u8 pm_type;
>>>> +       u8 userspace_pm_local_addr_max;
>>>>  };
>>>>
>>>>  static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
>>>> @@ -69,6 +71,11 @@ int mptcp_get_pm_type(const struct net *net)
>>>>         return mptcp_get_pernet(net)->pm_type;
>>>>  }
>>>>
>>>> +unsigned int mptcp_get_userspace_pm_local_addr_max(const struct net *net)
>>>> +{
>>>> +       return mptcp_get_pernet(net)->userspace_pm_local_addr_max;
>>>> +}
>>>> +
>>>>  static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
>>>>  {
>>>>         pernet->mptcp_enabled = 1;
>>>> @@ -77,6 +84,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
>>>>         pernet->allow_join_initial_addr_port = 1;
>>>>         pernet->stale_loss_cnt = 4;
>>>>         pernet->pm_type = MPTCP_PM_TYPE_KERNEL;
>>>> +       pernet->userspace_pm_local_addr_max = 10;
>>>>  }
>>>>
>>>>  #ifdef CONFIG_SYSCTL
>>>> @@ -128,6 +136,14 @@ static struct ctl_table mptcp_sysctl_table[] = {
>>>>                 .extra1       = SYSCTL_ZERO,
>>>>                 .extra2       = &mptcp_pm_type_max
>>>>         },
>>>> +       {
>>>> +               .procname = "userspace_pm_local_addr_max",
>>>> +               .maxlen = sizeof(u8),
>>>> +               .mode = 0644,
>>>> +               .proc_handler = proc_dou8vec_minmax,
>>>> +               .extra1       = SYSCTL_ONE,
>>>> +               .extra2       = &mptcp_max_addrs
>>>> +       },
>>>>         {}
>>>>  };
>>>>
>>>> @@ -149,6 +165,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
>>>>         table[3].data = &pernet->allow_join_initial_addr_port;
>>>>         table[4].data = &pernet->stale_loss_cnt;
>>>>         table[5].data = &pernet->pm_type;
>>>> +       table[6].data = &pernet->userspace_pm_local_addr_max;
>>>>
>>>>         hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
>>>>         if (!hdr)
>>>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>>>> index e5d5cb847209..24839cd7025c 100644
>>>> --- a/net/mptcp/pm.c
>>>> +++ b/net/mptcp/pm.c
>>>> @@ -182,7 +182,9 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
>>>>         bool update_subflows;
>>>>
>>>>         update_subflows = (ssk->sk_state == TCP_CLOSE) &&
>>>> -                         (subflow->request_join || subflow->mp_join);
>>>> +                         (subflow->request_join || subflow->mp_join) &&
>>>> +                         READ_ONCE(pm->pm_type) == MPTCP_PM_TYPE_KERNEL;
>>>
>>> How about using mptcp_pm_is_userspace() instead for all the
>>> MPTCP_PM_TYPE_KERNEL type check in this series?
>>
>> Most PM related code paths in the kernel largely drive the in-kernel PM's flow and only a 
>> small subset of those are shared with the userspace PM. Among those shared code paths, I 
>> believe there's only one spot in my patches that has a userspace PM specific branch for
>> which there's an explicit pm_type check against MPTCP_PM_TYPE_USERSPACE. The few remaining 
>> checks are against MPTCP_PM_TYPE_KERNEL to bypass some in-kernel PM specific
>> behaviors in *all* "non-kernel" PMs. As we may have > 2 PM types by construction, the code
>> does not assume the userspace PM when pm_type != MPTCP_PM_TYPE_KERNEL.
> 
> You can introduce and use 'mptcp_pm_is_kernespace()'. There are a few
> more chance to use it in later patches.

Sure, I can introduce that API, thanks!

> 
> Thanks!
> 
> Paolo
> 

