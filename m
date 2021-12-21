Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6A62CAC
	for <mptcp@lists.linux.dev>; Tue, 21 Dec 2021 07:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640072028; x=1671608028;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=iSTDHbgX3LETTT2hJoTqmwgn8bLdhA4ne5pXddJy3HQ=;
  b=AB5y/U0Mv7bGWh0URxtjm9tlZoT4xBGTPatwZ8TQZTXZ+xEeMs0YkjiG
   duqXPBIE0sZYPrwP/TB+ooEHUAjiaWuNVRXAhIGQivLBkMsN+P1nTpJwA
   JkmB5NrLpe4RFKm78az4iyzsrGOMYyJfP+oTcSA/9xlSPSlGcgKNxdrmC
   jACreZcrNl55tRDtr7cNlWf7acTFgBVfvAH7SfzjD9OsSNxEcSnTHvRbI
   6H/cgqWhEVww1GzL2kHSR6Um5cm8NwQrcikkGr1StSGmNFQKCembKrVL3
   EarW04oB98WCAmcnOCf3ldPVP5mLa70h7t98e+CcacuQ4Wyj/2O8W30Xc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="264532719"
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="264532719"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 23:33:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="606980798"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Dec 2021 23:33:47 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 23:33:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 20 Dec 2021 23:33:47 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 20 Dec 2021 23:33:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKen9KQNZv+1mu4VIW23qzKMGU8Z3p9XvkMNZHj+/dkKILFzIZ6x77avt235BzIXiaqN9pbk+F56MGjo0ANQDo1dehS/OKJEF0K0Bi426UrLEwAG6ZjI/1RAk2MRK//qcGo80FFb6aInW14BVsel2pYBm2DTeCjOTdHVcyb9/fWQEh9AsUrTMkIR9AyZblF0+UtuTPIROyBtWMNbMDNC+21mBcczULXu4qxNTg7xmL2+ZO7fu0HlA+ouFnU3asI/zoEsh4bjCqLbtp2swti1NwIyZRlZRFmEaquI71Cc4OhaO1sZjGKNur+CAKSdaMzcDWa3xVLCt1I9EKjSrlr6cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCXHuOBLJUNAb7lNtOoI6MjUtRZfj6Wkxm24Wfu6ZyE=;
 b=OJSqGzmztfnQtY8JPbS+0oC3sd3/2MPQEcCJeKfj5P6v5d1+8H6l0Wmfac7Z/z1veHYR3Plat9fYgLIR0Pr7CXs+Ug0tKoBWN9mP3l4E+7FW5CwKAFSTbgRjwObCwfgDOUwsovXEkCJvWYUEM+pFmfWJYa55YhxLYrkpqlc29AyA3Ma0645gPhLbTzlYtQokCias5oUe2cqjIeWExmdQetv3GvGa/a+jF+RviGjSGrmnt54uG+cahHAUzUaGECd2+di1vNSIJUy7G/iwsLU0sxa3eS1NkvWMOVEgBiEtTZOK0lfjiDzsH1Q88z3JfbnpiM6TWIkHplUr7bZi7qXVUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:95::6)
 by MWHPR11MB1840.namprd11.prod.outlook.com (2603:10b6:300:112::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Tue, 21 Dec
 2021 07:33:46 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::c41f:17d7:bed3:7888]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::c41f:17d7:bed3:7888%9]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 07:33:46 +0000
Message-ID: <c41a20f5-451e-e5f3-d23e-ef9a7e7d8041@intel.com>
Date: Mon, 20 Dec 2021 23:33:43 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH mptcp-next 09/21] mptcp: allow ADD_ADDR reissuance by
 userspace PMs
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, <mptcp@lists.linux.dev>
References: <20211216222314.1244708-1-kishen.maloor@intel.com>
 <20211216222314.1244708-10-kishen.maloor@intel.com>
 <14ebb20462d681f7ec696499816187672a5985bd.camel@redhat.com>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <14ebb20462d681f7ec696499816187672a5985bd.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:a03:180::38) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:95::6)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7dbf1e9-7811-432d-c8bd-08d9c45438e1
X-MS-TrafficTypeDiagnostic: MWHPR11MB1840:EE_
X-Microsoft-Antispam-PRVS: <MWHPR11MB1840B05DF0FC386910529A5DE17C9@MWHPR11MB1840.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IGmnvbX60M0bKhSK3shYB/b7NhFdxYH64RQs08fnFNmKy76RlowAhljvhrs7JfMwJOgaXujZTwmDaMnn+hg8JgZsOh5Ru8QxyvnJouVl5oI1ky+WrzOe5lKRl2LwnpTVnDB0tCBcV186zczWbmffq8JjaMr2MR+GX6DPnyOaByeOg15WrfRXfh4N6OVfR2h51P50ZQzCPGlQgwUmYFmxk4FfeGotdg9hwqNINn9JWcoxsOTr3G3BqdYuT7AAb5yn9lvRc9GXGY9eHi3ga5LumZS45HBtppl9GUjsfv+hDn/J+oo7rZUVff8plmi1ji33WffuVpiYC9T0/XN5EmbD0cGmC0K1KRvQADOBA4/YzZPbOI5rEbxBLj1VCrXwZfhr66O2dlTuNdEnpDBhuN0ah2c3AApKhtFwYhWs04+RJjZ4emPIQipWx8fc7VQl2gGQ5wIx5kgE3dWf6zgYCECgK8SRWRHY17+j388hP22cKNt2QDTFMqrRHA1/MrG0sXhtuxL/8SM/XjA8SB7ld9dDhDDZVnKjuhTOnpLQsztCH+VbsVq0gX2yGMlpUwYBKA+faj4dIoR3ZbpeWh7gnY+FE4D73HsylbN1UbWXlvj2f0hI683iefUbmq/vsp06uNglu7MBnTOnZyct2sIa3SNEfvL+E+/X4TK7m/ksxsP/eevm6jiO9oBySdzmGzX6PCAzms14bC1Gtr374H22Eebqa7SFPf6cj03bIHEVL9t4Oqk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(8676002)(6512007)(2616005)(316002)(83380400001)(66476007)(66556008)(6506007)(6666004)(5660300002)(38100700002)(8936002)(6486002)(31686004)(86362001)(53546011)(82960400001)(26005)(66946007)(36756003)(4001150100001)(508600001)(44832011)(186003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ulo4SWhnWkYwWDhZb3lwK2dvcVZYRGhzY2NqdzhoUE1rVU91NzE3MmxWL2dw?=
 =?utf-8?B?Q3FRR1gwcmdsVnFwdG43V2RvYXB3T2NCWkNMMjlzdHVKc29SVlNlbk15Snhl?=
 =?utf-8?B?YWp5djVpbTN1MTM0NTBUSG1CWmFlSmsxMEJ0RmMzN3Rxd01RKzdXK1YwOUto?=
 =?utf-8?B?N2JndDRqSzYrVWxsc0EyVlhHSGErK0Jtc1I0c3JxRmZqSHE2OXQ0QmtiVzVI?=
 =?utf-8?B?QzlDNW5OSW9QK0dqQU5aNDR5ZkVhbVgzUWtDYWs1Zy80L0VhMzROUjUrTVR6?=
 =?utf-8?B?TUUxQ2hBZUJLK0R0MDcyNU8rQ1M4SUZSQ1NIbzFHWlFCR0xWaTU2K3A0QXk0?=
 =?utf-8?B?S1BkVjlvMnJQTjJqbUM3NXZZNUJTSFBJakdIdHg4QXpQVFB5SGFpdjluRzVO?=
 =?utf-8?B?UTE3QjFHWWdUWkRVSzhVVFBHZDlEYUIxSTliYm41NHVXR0RxZ1dqUGlvMThI?=
 =?utf-8?B?eEhaZ1pHd1dUVGtPODk2UTBjMFl5OVlnRTBMVnZrRVl6bitYKy9wZG16bm1y?=
 =?utf-8?B?S1Y4UGE4NXRYWmltRGlEY3QxU2p6SGlzNVdRYmlTUllNUHBDUG1wWnNRa0dW?=
 =?utf-8?B?VUVwaFR5Q2h3OVVFakxXRkNicHI5bHI1SmZSdk1HOVdEZE0vUDNBVVdVZmYw?=
 =?utf-8?B?ZEdsbWpXQk5zUFJPZlhyR1ppNERlcmJnak4xSng5TFNRTGVuRE9SbUF4RWUy?=
 =?utf-8?B?V2pmTXdXZXU5dU9SNHo3emREb0xmOVdxN3V3bW1KbHc2bUlvdkIxbHVUSUJD?=
 =?utf-8?B?ZWVTTGxyTHovQjhDYURUQWs1MGNZTnFFUEoxREhJWG93RFF6MExoZU5Vd01X?=
 =?utf-8?B?citFRnVyaDY2RWNPTGVQaTRhWjBXdmRCZHQyeTRibzhzQkE4MHErTVlJUWly?=
 =?utf-8?B?SEJzaWg5cmMraVkxWFEzVS92dGo5a0h2Y0k0alJvZ0JJYWVZM0ZvZTZIaG91?=
 =?utf-8?B?Vjkvcjc1cFZxbnJOQ1ZUeTFKSWRPbCtDRE8rVFNxRjNPcDc2UHVPS2gwaDlh?=
 =?utf-8?B?eGlkN2xUaWgzNVp1eXZoZVVEUGJZWG5mQzZUZUJFTlVmMVgzV3ZxTTBJVjVh?=
 =?utf-8?B?QnVubG1KMGE4cVJ0ZW9YWVp5R1AvODlxVUErOTcxUGFmd1dGOVRKbVE5UXd5?=
 =?utf-8?B?K2I4UEdzVSs3di9YM1dnSnppYkhzcmxzSjJvRVZramN5VjZjZVdyYmRxNkNr?=
 =?utf-8?B?b3BoRVFtWnhiN3JHVHNuajFEWTZvVnZLTHlJR0Q1Q3VXcjdHalpPV2RDZnI4?=
 =?utf-8?B?YU1uWG85Y3UzL0tVMFlOQjBFcXNRUjJvRjRlaHI5TWtqd21DWXE1eHBwaEVn?=
 =?utf-8?B?VEw5SlZlMVcydXRjellRc1pGa01McEF3L3pSWWhzUkE1OWZNYXBSajRPMFVW?=
 =?utf-8?B?L3JEbU56M2h3T3k2bVk4QXlRSGEvOWFYbHpScWwvdkt1aGl1SHJwV1pvUWJ0?=
 =?utf-8?B?QjhPREE1c0NVelloT0VBR3Q1MDIrSnJORkRHM284aWhrTHErdHRYM0sxdVpV?=
 =?utf-8?B?eW83LzZxOFk1S1BMcUFDaXVhN2c0Yy9ndm1DS2dEMkpNTVJkdkpnUzIwa1Br?=
 =?utf-8?B?TEZmVDJtdzhOb0VCbG1pUU9jTVY5alBUZjN2clFtbkxqNEZrclJTS3AyeEpC?=
 =?utf-8?B?QTBkK0h5dUMzOVBBdk1jSmRGMGx6SGp6aXJxQWZ5NnpiYVcxdHM1d1YzaGZG?=
 =?utf-8?B?ZEF0VGdEREZYYXYvcUt2cTM2OU5sVDhzcjRSS2xuNnVHei9veVM0aHZqbWxn?=
 =?utf-8?B?d1A5eXpaSHRNeHNCN1dPcU5kdmU4TDRxYXRQOTJ2a2ZoOCtTOTZLRnA5NE9n?=
 =?utf-8?B?ZGp0dTVVRzB6dmQxckNYcDB6Q2FydWJUTUJqaEN0RVdtNzVYcndoK1VndTJZ?=
 =?utf-8?B?NmJSbm5mUUtpRU0wU2V6clFneVBodmxRSG9OYTdtUitpa1ZhbU1zK2xlUTRl?=
 =?utf-8?B?QWtDZldma3YwY0RlZWwrM1dqZTVxajVtbnhRRVZmektFd2x2UmdUeXFMaUpa?=
 =?utf-8?B?WVVPSkZSMjQxVVpCVjJpaE1XY1dEZkkyUHlDOFdTNlR5OGlKRHhla0YrRnBn?=
 =?utf-8?B?UGZOb1BtZHdsNVRtYnJVS2ZvclZPMUZVVTVwNWNha1FBZjhjRkpPNXFHMFlL?=
 =?utf-8?B?dUhnRjN4M1orWms3UEczaUIyQnBlc2FJY0xvZStTOE03SHdGYkdNVWxYOXBh?=
 =?utf-8?Q?2Df6SDR7g19w4aJnzJ0faeY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7dbf1e9-7811-432d-c8bd-08d9c45438e1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 07:33:46.1508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1GpJguvV4AvzdfPMIWAnQGliYM4kqcZQy/eRxWxG607QRMBifkhuQQKRf7+5NN2AEgOdvp+VABh+Id1YalOKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1840
X-OriginatorOrg: intel.com

On 12/17/21 10:38 AM, Paolo Abeni wrote:
> On Thu, 2021-12-16 at 17:23 -0500, Kishen Maloor wrote:
>> This change allows userspace PM implementations to reissue ADD_ADDR
>> announcements (if necessary) based on their chosen policy.
>>
>> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
>> ---
>>  net/mptcp/pm_netlink.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index d57e2f825728..1adaf5d14f87 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -452,8 +452,16 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
>>  
>>  	lockdep_assert_held(&msk->pm.lock);
>>  
>> -	if (mptcp_lookup_anno_list_by_saddr(msk, &entry->addr))
>> -		return false;
>> +	add_entry = mptcp_lookup_anno_list_by_saddr(msk, &entry->addr);
>> +
>> +	if (add_entry) {
>> +		if (READ_ONCE(msk->pm.pm_type) == MPTCP_PM_TYPE_KERNEL)
>> +			return false;
>> +
>> +		sk_reset_timer(sk, &add_entry->add_timer,
>> +			       jiffies + mptcp_get_add_addr_timeout(net));
>> +		return true;
>> +	}
> 
> I'm unsure I understand correctly the goal here ?!? retransmission on
> timeout of the announced address are already implmeneted by the
> existing code. What kind of different behaviour do you want to obtain
> here?
> 

Yes, existing code retransmits unacknowledged ADD_ADDR messages.

This change is separate and allows userspace PMs to re-issue ADD_ADDR messages at a 
later time. Section 3.4.1 in RFC 8684 mentions scenarios where address advertisements
may be "refreshed" (periodically, or otherwise). The in-kernel PM has no such policy,
but this change allows userspace PMs to refresh ADD_ADDR information should they choose
to.

> Thanks!
> 
> Paolo
> 

