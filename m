Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DA572
	for <mptcp@lists.linux.dev>; Thu, 18 Nov 2021 22:09:58 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="234540601"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="234540601"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 14:09:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="473325817"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga002.jf.intel.com with ESMTP; 18 Nov 2021 14:09:54 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 18 Nov 2021 14:09:53 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 18 Nov 2021 14:09:53 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 18 Nov 2021 14:09:53 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 18 Nov 2021 14:09:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkCSccfIfZBNZKJcMYMs48ksZlcUJsu1lc8G77+qL4EbGSFPk0tcoihBzzf+jNa1VHRCRyOzJYVoI8VrB6PjTZPPwvf6YLkdIHJZtS4W35hG16HLqMfF281LNP/PTvHCxGHGVQdzjk6u/kW0MFPg/Z0O++WXLQrIZ/e9wbATKxWzVtOdV/6RbcXqoO9a3jaf0XUONF0qrQxPpg6aL2YIO6Qekf00NilMgGUkZuMqoPE2Cz83nAu5t6ME3pZgu87/GPNZo8KL5fQrQxfWy7/XppqK+hKb7h8NHnjjwwB/Fa8gkw+E/8KpSYIApwkfz1FwLRA6wQ9KjQTk0NX8ifVIkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCsQGaokmgOP62chhaNRxDwnBPF/f5VFfOiKT/yO1TU=;
 b=dr2S35iv7QSybu9YsbQLyWXo6KHr7gimLiq8K+cG0tu52iBcDWLw5oCwpLwnZXdSEIXx9HUS6qVgHc2VIYzKcHrcv6wozd8gbSNXHm7R1QAWCZwk+Y83sF0UodJeil5u5xJXrf5YDxzPaj/Gp7UqblbuMLV5jB3eMM7lMqmreUpYvkewI5lcKrxPOBGvMPhY3dMrg/eI3U3DG0kfYQPF+BSr+ozk9hM6oNxA/0W+ZPm0JLJie7oQ5Izd0SaZvpG3yLHfH8/y6+pY4+QYq0xyBHoeAR3RSf0uAKuMFuXFF7JMLJ8URLCsh9GIbA4UrOmeoEro5TB+OtjofYwWsqGZjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCsQGaokmgOP62chhaNRxDwnBPF/f5VFfOiKT/yO1TU=;
 b=woC95VV5zhc4eYbRANvEy+lLzzOKH/4UC4k0uXrWbvjwPC84ZtpdI7lgEpHrZSWcPG6i7ubf49HwAzG/Xj0cQLHXyr6gj6rTB4KIcu9cSpvuFd4y6s79Da61yeen78SkxO+Q+VUUucy0GOMsoDtpQo/hO/qkFlG6W0bgBC7o/MI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:95::6)
 by CO1PR11MB4884.namprd11.prod.outlook.com (2603:10b6:303:6c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Thu, 18 Nov
 2021 22:09:47 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::651c:7abf:4572:3438]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::651c:7abf:4572:3438%3]) with mapi id 15.20.4690.028; Thu, 18 Nov 2021
 22:09:47 +0000
Subject: Re: [PATCH mptcp-next 3/6] mptcp: Bypass kernel PM when userspace PM
 is enabled
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	<mptcp@lists.linux.dev>
References: <20211118013005.263660-1-mathew.j.martineau@linux.intel.com>
 <20211118013005.263660-4-mathew.j.martineau@linux.intel.com>
From: Kishen Maloor <kishen.maloor@intel.com>
Message-ID: <5c002f40-69b8-c32c-fc9c-cb163a6a902f@intel.com>
Date: Thu, 18 Nov 2021 14:09:43 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20211118013005.263660-4-mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO1PR15CA0066.namprd15.prod.outlook.com
 (2603:10b6:101:1f::34) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:95::6)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from jdavid4-MOBL1.amr.corp.intel.com (76.105.224.234) by CO1PR15CA0066.namprd15.prod.outlook.com (2603:10b6:101:1f::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 22:09:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69f147d5-9c7a-4450-c1a7-08d9aae0215b
X-MS-TrafficTypeDiagnostic: CO1PR11MB4884:
X-Microsoft-Antispam-PRVS: <CO1PR11MB4884916AEF8D77F105098278E19B9@CO1PR11MB4884.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Udkhxm9ZIWGrMBMqNIO/MBr7CA1RLuZ34QB4V3FgRCu4nYu5bi8603+zlkAbfAGyvTlHFpMPDL4TGxcxu7HoKfoU/pboI0YfRiWDra2Z4rNM3aDHRiWoM2ijnpG3gjDBQ/dyTgdqzYnrvRlCblfIzVZyzQs6C+kgDi7Cv5inIsksGcW1ZxMpy7GwH+6eoaMuPHvJtcy2DIDM1DiaB1bZu73E53NiHeJqbvnb994Mr8F+kVl0zPOe56Wv1q3Oo7odsVwnNyQJMLNKOSPOSJnx7O1ngdXraSHa+Ck9WAq2AsnpzVcZXmP+a50KFIo3wUp7Mr79UigTD6t3U7fSsehutUo+8Mo+ep/OAeT1mcKLSsG8X7XK4rMJU+pptKIX2vhzec+FnN1JwOy0f9PHRGQuaL+PkSDs79ZpXkrGg5eY1f0BsreDxJZDcTljkfP8cizc9GOmTMwB50+R3tx+actlfUKUu1PIrI14SzVku1Sb1SstovZ4nc0whgZQbK/LC2KVFToE+UDG8iC+KDJ/A7zs26aB3LursITjJasB8dQyn2kBVyQP6C82OnUVCn4BBeM9r2E/p0a7jS7oxkvjcg5ErydOTBqC9wFcmZqGdBkeVIglhXbwQWUR1BPzURHUZeHoF9ccc11Xs3955X+Ntf7nkOvDAjqwzIE2MdgjzV1/s4khUgHddJvKjMxV/HuQB4/W7HVT79iUukuAMKy7Z8psUtvBWGQcwuI+vs2WPLHFiXM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(82960400001)(38100700002)(2906002)(86362001)(316002)(7696005)(36756003)(956004)(2616005)(8936002)(5660300002)(6486002)(66476007)(186003)(66556008)(66946007)(53546011)(83380400001)(44832011)(26005)(31686004)(8676002)(508600001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZE9LNk5lemVYUW1yVy8rZFpYUTdiZzl5SnV6L0ZyeVpGNUFvOXRleVNtYlVj?=
 =?utf-8?B?RUZiVW5tZFRQbHUzZmhxNGorM09xd09DWGFVZkZ2eDZvZ1B2ajhrZU92L1Uw?=
 =?utf-8?B?M2lrcGFTZ200c0g4VUwzc3FtNGlBQ2tyNkhac1pqSDE4dTNCaG5Ud0M3dzc1?=
 =?utf-8?B?OENNUCt4ejU0WU9FMlhRQ0s5SGMrYlh2VDhJM0ZwZElxUXJPZnRmNW52cSt1?=
 =?utf-8?B?WVpyZWtXSFdyRUZwcnQzajVGUjRCRkVkOWtwOHFuQ3h3Zk5DRUFYelI3S1Jy?=
 =?utf-8?B?WnQ5Y1ZRRjBiUU9NMk8vUUM4UnQvZ0VxaDEzQ1dnSXRMT3JEQzdtTEhMOTJU?=
 =?utf-8?B?MXJ4ZytLbnAybWsva1JhdnJ2VmwvNmlTWUc3N2dZYTBHTmlFNjFJMEZjdGc2?=
 =?utf-8?B?a211dEJsS0xYV1pWN25BVkdQWGMyZVhnVlNHalVLZzFtNkRnd1NNclR4amJ1?=
 =?utf-8?B?Sk5odEFLM1d0N2hUVVd1c21tTGJsSkdnS1NBVGtKVjJDYmZ3eXNpRjFzQkhm?=
 =?utf-8?B?VWZOSGxYRnQ5QldWZnNnMDFTYmppMy94RG9Xalp0SWdsNnMxemQ5WDZObmZx?=
 =?utf-8?B?dUJxZXhZK2lQdWNPNWZmWmd3aDVKTWNLNFBGR09TVmMrcFplUjN5YllZUzA0?=
 =?utf-8?B?ejhmeVRLdXdwcUE3L0Z5alBBVVRZaFlmeTExUGVXS052RUhQWWtqWVBFZkJn?=
 =?utf-8?B?dTJsaWZLbEpvWnY0NW5VSTU0a3lDVXJqTnAvN3lYZURHRnJuZkpiUi9BMjJG?=
 =?utf-8?B?aEppbnNwVDQ3SXp0aTJUZUN5dE9YbnhiMERIZUpMZld2cFk1S2VzZXI4cE9O?=
 =?utf-8?B?N1NxVW14YTdGT2ZVckhhTVdMS0g2TzhMeWtJd2UxSVVIWm1NMG5hTU04NGMy?=
 =?utf-8?B?SjNqT3pzcUExUmI2cEhSbWhjVlpHU0VsVjBwYmlrZGNSRTFqUGZRd2VvUFBq?=
 =?utf-8?B?QnV1T1JvRFFseHEwN1FLSnJyMnFnSnQxN1d2MTFrUFRJUXgxRm0wcjJyYTRO?=
 =?utf-8?B?TjU1YjRuL3BIbGsxNU9obHhxaFBrekRtZzRJSWJTNFB0VE1EdWZrdWRWSGgz?=
 =?utf-8?B?ejY2Q3gxb2tVTjhhaXEwbXBaWXBReENlbnc0SGFnZ0FLL3JOdnducndBQk5v?=
 =?utf-8?B?eDc4RWFQNC90VnlsSzNPRkp4T0xITmcwRkN6Q2tXcHNjdTdlN1RzVHNHRnhu?=
 =?utf-8?B?bUYwdGJBMkRnamNjMFZpYnljQmI1ekJIVWNwQ0FzTXNuWThWdEFscWhLd2wy?=
 =?utf-8?B?STBEbHJkSnZIQXRTQTFZckFjTjBta3hSei9pbXdEVjN0K1orMTBMcGpxYmIx?=
 =?utf-8?B?UnRXQVlzOWNmVHY2dFlvTE92aEVBWTl2aThZaFZmTlZ6eHFRZW9QUUhjVVBQ?=
 =?utf-8?B?OUJ2czczZzhIS1NpNEc5MURxL0svcFBMdDhDTnRRRnJ3VGxJUFJrQ1B5dW0x?=
 =?utf-8?B?TFdNSnRIcHVwQzJLOHRKRVg2bkRvWXZMQWxkTzRON3lYbXEycDhkVFFKcEY0?=
 =?utf-8?B?Um5TR1R6cytxWGhOeEp3ZzFlbTcycU40Snd5NWEvQmNoZlJjaFRld1RMRkZV?=
 =?utf-8?B?c2NnaXBrQU9scmRBNFdSWktFaXptT2JXWkI3YjBtVjR5MXRialM1aExqb1BJ?=
 =?utf-8?B?QmxZWE9hL2RDT2pVckZCV2ZWdGR4bDVDRlU0bnNiY0o3RCszUHp0MzJ3dE9D?=
 =?utf-8?B?RS9lL3hxN2lic1RRTTduei9TNlNqb1BiWS9nOEVPdkxxOGIyOVozSG02THRG?=
 =?utf-8?B?cHdVV0RvRE5HK2YvUWhUZWVEOStFQ2wvWHFMNStvZHlFeXB2QUFZdEt4V3lC?=
 =?utf-8?B?NUxIc3VXUnFTS2JGWXZWV1NqSUpHVFA3NHdEL2NZclZGcWN4VjQ0SmpkQlo0?=
 =?utf-8?B?RTVrVHpSTnJldzJyeTg1TWp1Uk1Cc01NbUQ1THRkZi9QYTMvTHZMdzhNOEtG?=
 =?utf-8?B?RUQvL204REJZMXoxNW8wcDB5azBDMzh1eDNEM3V2THNsR1BRaWpydXIrdkts?=
 =?utf-8?B?M0R6cWZnRlVDTjFSVnJGWitwbTRzbXZraFJvbVpyZnRWM3pnNjU2a05EOEJ6?=
 =?utf-8?B?YkVmaVp5UjBpOHFwZTc3MTFhMEFXckxKSWFXUVBhMXo5WU5LOEhSOWtsb2wy?=
 =?utf-8?B?MS9aYnVDaDJEV3pES3B4UmI0c01hYnZIY3hMWGJlMzlIUW1RY0xQdlAxc3My?=
 =?utf-8?Q?pEMlxxfgMM1UEtDUKPd2jxo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f147d5-9c7a-4450-c1a7-08d9aae0215b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 22:09:46.9575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSwEHX3zczFA8NHfcdcHn6mACPiWpwp3rQhNwCh0Ssj9+nQn/oBo9M5uJG/UUzi5KXv3c6qG4mbAtBjBWNzfBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4884
X-OriginatorOrg: intel.com

On 11/17/21 5:30 PM, Mat Martineau wrote:
> When a MPTCP connection is managed by a userspace PM, bypass the kernel
> PM for incoming advertisements and subflow events. Netlink events are
> still sent to userspace.
> 
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> ---
>  net/mptcp/pm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 3a3800771aca..7f96a888e2d5 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -189,7 +189,8 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
>  
>  	spin_lock_bh(&pm->lock);
>  
> -	if (!READ_ONCE(pm->accept_addr)) {
> +	if (!READ_ONCE(pm->accept_addr) ||
> +	    READ_ONCE(pm->pm_type) != MPTCP_PM_TYPE_KERNEL) {
>  		mptcp_pm_announce_addr(msk, addr, true);
>  		mptcp_pm_add_addr_send_ack(msk);
>  	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
> @@ -233,6 +234,9 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
>  	for (i = 0; i < rm_list->nr; i++)
>  		mptcp_event_addr_removed(msk, rm_list->ids[i]);
>  
> +	if (READ_ONCE(pm->pm_type) != MPTCP_PM_TYPE_KERNEL)
> +		return;
> +

The flow which ensues from MPTCP_PM_RM_ADDR_RECEIVED can be fully utilized with userspace PMs, so the above check for pm_type can be removed.

>  	spin_lock_bh(&pm->lock);
>  	mptcp_pm_schedule_work(msk, MPTCP_PM_RM_ADDR_RECEIVED);
>  	pm->rm_list_rx = *rm_list;
> 

