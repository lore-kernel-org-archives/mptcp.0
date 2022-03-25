Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE0F7E
	for <mptcp@lists.linux.dev>; Fri, 25 Mar 2022 00:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648167518; x=1679703518;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=9h5KDEfnNbqf8vyUS+BKINrr29xw9J/VCdSpw4Q9LcY=;
  b=VMPiJFL2Cqn/5IoJz2w9kNt1l1pCZ3kYwdz7n6x12Sc6mSM3PMA97LY2
   6iucS+KLW1F1wrgRVxKooe1Rx1n03B//LQhVq+UTeFwbuOtcLlD7y1B3/
   CS0uFPUCyadfa7gLOQX+svBDpcUV71u9xmKaRhd96MAOF20ch1iWzzOO4
   +YOpciSoVCoL4ublwE8OhbcdVvEJ7rtfMVO9Vchq2VGyu7v/KfnWcnu55
   S3fhPsHNopZP76Bf4uZ9j99VLvP6sc9Yc4OmygxBSkUXlUD+XkDEtUh/o
   FtafaB1cuXo0kSQF5ngBTRfPZGqE0KdqFP1+jQtTYJxO8EnDnZPT/A03j
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="344957727"
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="344957727"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 17:18:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="638046314"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Mar 2022 17:18:12 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 24 Mar 2022 17:18:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 24 Mar 2022 17:18:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 24 Mar 2022 17:18:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQGNiFe11tmCGh51SHpIsElrSFtvtU02ZZCy0kBT7KTUBLMyGYS7OOpqclKnIMfA6hOGiIsXnGmZH9OG578OFGcNyqeqUw4O7jcjhbUB/bwci554m5KBZdcrGnrAbQuBuEpiMjp4d/bUGsZCcqYZKS/1RUROP8oYA6EOJ5uXN88rZQwXxGTA5fTO/rw6JEEjlVyoBP1t+sUZn3ExONiOAZ6kIwMG7B4O31MbiZO1WQPOpo1ZcCr7Hv7f3ZuJJ0Hm7YDXhxLzSSVOLuhfpX1i616g0+GyG8OPiQD/pYGWoU2fJNHmwJnpnKYJwha/sp8Ld68r8Yz625q7iPKxmTelFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQccCpROYxjMMHgpTChJNbVEk0A2mQhd/zugstS6suM=;
 b=JFzZvb35xnwVbojeRCdrzH126fwcWq5go2nxqXvx0mb0RwQ2iAOxTEvXo2MYWV7pgv9RKYzsZUZnqNud41lfDHVKR5uH7F35Tdp87y8a4uX3BcYRkeRTsDkMbAbexLhJ/73vMn1l2pZg7uIbkJ8uy/t23w6lCFzeICNMabJ/nBU9wBd0WqHhpO/LfmMlhI8ttUD02IU0GkUvSyAwPNbJZ7Eyw8HfNO+fJR47sRdj1QV+XTzOv5cDZdeyyuRYBmRsHz+DicQNKQ+RY4zpLt5JkiFim3tKApkpMqA2GX5mu2Y3MoJKk4BZBTLAOM+kM8awPAAeO6GH3tnfbv2Y4OUvnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
 by SA2PR11MB4777.namprd11.prod.outlook.com (2603:10b6:806:115::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Fri, 25 Mar
 2022 00:18:10 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::44ba:c91c:ea6c:118d]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::44ba:c91c:ea6c:118d%5]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 00:18:10 +0000
Message-ID: <d96ab7f2-b87b-2519-283c-ca7b3810eb33@intel.com>
Date: Thu, 24 Mar 2022 17:18:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH mptcp-next v5 02/14] mptcp: handle local addrs announced
 by userspace PMs
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, <mptcp@lists.linux.dev>
References: <20220316231636.645625-1-kishen.maloor@intel.com>
 <20220316231636.645625-3-kishen.maloor@intel.com>
 <820d78dda48eb1ddc37485826af946505b22c605.camel@redhat.com>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <820d78dda48eb1ddc37485826af946505b22c605.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:74::31) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:9e::21)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 983e04ae-1bba-43ec-e592-08da0df4f170
X-MS-TrafficTypeDiagnostic: SA2PR11MB4777:EE_
X-Microsoft-Antispam-PRVS: <SA2PR11MB4777F27329B1701C20EAEB65E11A9@SA2PR11MB4777.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YM+OYGEQdwz5QDwkaNSC6qJQrhRBhk0IKytrKkgrV9aPWLMpCiC4GGeoWar5UrpUqUHXpFFhKFUA3TZoNBQfZs+LMp+tIB3WlhW1z3a/ELLgT3uoyTroSOUazk1IUXawqGFfVU1+cEWl7aYU5SkopzyjbI39Qz0NX90HwS95SII3aXohZlwlllEaj3PocxFjN1Ne0UFtnAYerOmx16MWe20EcVQlFT5d0mig2/l/Ef7c+7RAfn0S972ALWeqDgqZUugQmpMFMFgsfwk6vS4bJ4SbHiJ7XWU30ZlHXnLyio0gMJ+RnoX0WB1f3bZmiOX021Wl4j0WSxnqRJrdPndQWidfqSY1M1Kx0HxSUwaOpLNSPjF6FYwX2prUoUUPxfSDJeZIKFXnPsAr0fRg2BUTK4DNC8TmKUP/orQ0JPhLV0FRDpLU17kqVmF1UqLAkUTENU4QJkqYsky0pyC6JqCdL/s61zdZ8IuLEaMgjkpwT4zlfXw4RtpTJsz82geLY8/2GFdF0VrWNkMMbQ+5WnZWvls7MfYmWZ/VnxjtEspnGYgR3ZBZQsB0RJSwng24eGR7+lWHS47cvSIWPRgjHdqqovzTCk9KHhXDIPww8Fxa7YVpokE8kW0qjVfgJzN15FyCo2qosny+Dg5/CT7/JL0W2u9ZEDBTaL8lWtFMzzKJCYa4DC+JTcXPsqk21R8Xr5CWabPBdfbkuNYH6EqABtDq7SB8NDBpw7EHHj3y3PtyYI8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6512007)(2616005)(8936002)(186003)(6486002)(53546011)(83380400001)(508600001)(6506007)(2906002)(31696002)(6666004)(86362001)(44832011)(5660300002)(82960400001)(66946007)(38100700002)(36756003)(66476007)(66556008)(8676002)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTBBbHhzSnp1QXFDYnJwc3hhS3VmSmsvekRpd3RPWk84UE1mQ0lKM1FHYkI5?=
 =?utf-8?B?UEJGK0prRnV2cW1JbFFhQ0ZmQ0t2Vi9UQk9Mc2U4WTRlOFhLaG9FTzFvcTRV?=
 =?utf-8?B?bXl1eFhFcm44aHllQWo0TUFGbGN0VHVKT29QMHlvd1V0d1NNMXdseGtpbyt6?=
 =?utf-8?B?aUpNSVBwTVFIbEtueWdSbmQwQkExMmR5RzJ6ejgvdStmM0R6bUpmWnpFY2Rj?=
 =?utf-8?B?MDFLb0dzK2h0VTZBNHluSGlVSVRwNVRzSW5XUHYyaVUrd1NBUkN0QSs3L1Na?=
 =?utf-8?B?Q1U0elhuQk1mK2RYVDlodHYwbFJETkNFNXJPZU9DcXo1ME80aTlONjNNY3pM?=
 =?utf-8?B?dGphNTNDUzRxcVNHWDdHU1NwWU8zVlRNcHR0OW9sZmMydEkyYmZSdE9RZlBV?=
 =?utf-8?B?blUrb2F2SGhIQXNGdFFDNmtmNG1Wd2NSTFJiM2pBWmprdnJWcHFzUjRMbkcy?=
 =?utf-8?B?VXEzaDNCM2hoV2RUcGxSYjJkQ2QzbHhiK0t5VEErTjd6ZmxHd0pNRFJjbnpM?=
 =?utf-8?B?VHllQVdqb1NGSjU4NnBNZUFjWk1zcGo2UTBLZENoWi9ra0FKSmRPN041QnJ4?=
 =?utf-8?B?NDNaT2pSS1JlblFGb29NeFFCN3k1Q1hkdVRDR21BUTAzU2hDdFFacVdOSWxp?=
 =?utf-8?B?YmQ5TmxwWWFrQ1M0RzYyeU9tWlowRWdvUTg0MGJxUEN6YjhjbzdrMWtGMUJF?=
 =?utf-8?B?SURES3YvUldtZnJkS0FLUjhRUG1iY0t1RmRuR2g0RmJhMEdkdTB0Q01naytV?=
 =?utf-8?B?VmdDTmNNZ294YVhVYnZkOHBKaXJ6VVh6S2thNDdlWVR4bkdBWEs0aFhHcmZl?=
 =?utf-8?B?N09adi92b0N5bysvcUdNZ1JWYmVqbnRiT09uVWpvU3J5UCsvYVVtNElDSFZV?=
 =?utf-8?B?TGxzeStjS1hoeXpXS3ltSzRVc0xYUEVCUHQ0TnpDQ2VDYVZoNW5EQkhSRmFW?=
 =?utf-8?B?Mkdyd2ozN2JhRGZodlg3bnFZanh5SC95ZGVaT2o3K1dhN3JhTTBCbXAreFlo?=
 =?utf-8?B?WFBEdEQvM01QcUMxeUN1cVdtSVl6SUg5M2ZYMndrS2ptVEVkL0hWMml5S0Rm?=
 =?utf-8?B?d2VlOHE1RVdGalFTTXBDWk9CRnFsdGVkOVNhTXlPSFpLTjlXYjJnVUhtZWxn?=
 =?utf-8?B?UzRUQmo0d2VVVWQrY20yR0tDU0VIcEdTYVI2dXZRRmx3eEIzZ1BPRHBMZUpl?=
 =?utf-8?B?TklYNDl1cnoxWlFMWXlxRzdxcmxFOXIvOGtLcmFPVkVzMGpwbUxlWHZzMmtD?=
 =?utf-8?B?V0ZmZ2laRDBmbG4zVi85MDdpbnIvLzJzTlRUUXFJby9jcGNXKzZzWk5NWEh6?=
 =?utf-8?B?NnVBUlkvc095WlRQdlhaVVJNN1JjS3FSL2daZVVON2pBOE5aSGxwenM5UXo5?=
 =?utf-8?B?bUtHeUoxd1hBd1NKZ0k5TmJqSFArWGwzbWRIYWd5LzhPUGZ0OTUrZGZxUHBN?=
 =?utf-8?B?NHJiRlgrMUkwd0tSQU43MEdnM1VTWjRJNnhCY1luUUtsWGxLcTQvYWs3eTd6?=
 =?utf-8?B?OGsrWDNOZFJUTWw3NS9pWERaYmNEZVFxcVVKdXhvU3pHc0d4RmdaSnkxemFu?=
 =?utf-8?B?ZUVicTN1QUNQVFA4TU8xeFZVNkFtaUJ3K3NwZGtQa25OVjV0L29OenRYbzZh?=
 =?utf-8?B?eVpIL1J4bFA2MWNMS2ErbEtvV1hxVzJOeXc4aTRVTk1yNllZWm5wekppQzdB?=
 =?utf-8?B?dzVlNVFBQXp0b3Z6Tlo2bFZlOGJZV3YvSGw3UlpLU0VoZHZnWVg3NWlUQnU3?=
 =?utf-8?B?NzROT3cvOHRaTFhDaTlTWG9ONTU2NWRYK2Z5WkFHbGViY2tDVlY0bTdnbHpT?=
 =?utf-8?B?TExuSWY5WFB1RHBQS1piUVNwSzBJV0pCL3o0bThCaWV3RmpHMVNldFRvbmtQ?=
 =?utf-8?B?a2pWc255RFdvY0IyYTdIVmtVWHYyTkVQWWswVXdNdkRnL1hkQzh4ZzJtVUtz?=
 =?utf-8?B?cUZoVU5ac2JvYTBGcFlaN1VhMUc3WmVwL29QMVlpaEc4SmxyRnl1bUZKUm80?=
 =?utf-8?B?MVQvaG94YVdBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 983e04ae-1bba-43ec-e592-08da0df4f170
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 00:18:10.1797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k4c7yvQeWPsXC71A+v8JvBOhJUK3H5Xv3yMAjEuzVVE2AjV9BgPX5NJDO1KpmG4LzvnhWnVi7qhdZpCCQ3CVeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4777
X-OriginatorOrg: intel.com

On 3/21/22 3:53 AM, Paolo Abeni wrote:
> On Wed, 2022-03-16 at 19:16 -0400, Kishen Maloor wrote:
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
>>  net/mptcp/pm_netlink.c | 72 ++++++++++++++++++++++++++++++++++++++++++
>>  net/mptcp/protocol.c   |  2 ++
>>  net/mptcp/protocol.h   |  2 ++
>>  3 files changed, 76 insertions(+)
>>
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index 98e59576415b..d8825bf580b7 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -390,6 +390,24 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
>>  	return true;
>>  }
>>  
>> +void mptcp_free_local_addr_list(struct mptcp_sock *msk)
>> +{
>> +	struct mptcp_pm_addr_entry *entry, *tmp;
>> +	struct sock *sk = (struct sock *)msk;
>> +	LIST_HEAD(free_list);
>> +
>> +	if (!mptcp_pm_is_userspace(msk))
>> +		return;
>> +
>> +	mptcp_data_lock(sk);
>> +	list_splice_init(&msk->local_addr_list, &free_list);
>> +	mptcp_data_unlock(sk);
> 
> Why are you using the mptcp data lock here ? I think that is subject to
> lockdep issues. Likely the pm spinlock is a more suitable lock.

I needed a spin lock to serialize access to that list so had used mptcp_data_lock
instead of adding a new lock. But yeah, I could use the pm spinlock instead and may
be also move this list var into mptcp_pm_data.

> 
>> +
>> +	list_for_each_entry_safe(entry, tmp, &free_list, list) {
>> +		sock_kfree_s(sk, entry, sizeof(*entry));
>> +	}
>> +}
>> +
>>  void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
>>  {
>>  	struct mptcp_pm_add_entry *entry, *tmp;
>> @@ -878,6 +896,60 @@ static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
>>  	kfree(entry);
>>  }
>>  
>> +static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
>> +						    struct mptcp_pm_addr_entry *entry)
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
>> +	mptcp_data_lock(sk);
>> +	list_for_each_entry(e, &msk->local_addr_list, list) {
>> +		addr_match = addresses_equal(&e->addr, &entry->addr, true);
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
>> +			mptcp_data_unlock(sk);
>> +			return -ENOMEM;
>> +		}
>> +
>> +		*e = *entry;
>> +		if (!e->addr.id)
>> +			e->addr.id = find_next_zero_bit(id_bitmap,
>> +							MPTCP_PM_MAX_ADDR_ID + 1,
>> +							1);
>> +		list_add_tail_rcu(&e->list, &msk->local_addr_list);
>> +		ret = e->addr.id;
>> +	} else if (match) {
>> +		ret = entry->addr.id;
>> +	}
>> +
>> +	mptcp_data_unlock(sk);
> 
> After "mptcp: introduce implicit endpoints", the above mimics very
> closely what mptcp_pm_nl_get_local_id() is already doing for the in
> kernel path manager, with the main differences that it avoid the hard
> MPTCP_PM_ADDR_MAX limit.
> 
> Perhaps we can re-use the same code? e.g. enforcing the
> MPTCP_PM_ADDR_MAX only for the in-kernel path manager, or possibly
> retaining such constraint even for the user-space one?

I don't think so. The semantics of mptcp_userspace_pm_append_new_local_addr()
are different and work in concert with the ANNOUNCE impl. It always looks for a matching 
addr+port and id to return a stored addr; if one matches and the other doesn't it rejects
that insertion; if neither match it adds a new entry to the list; when adding an entry if
an id wasn't provided (which can happen only in the "implicit" case), one is assigned. 
Also, id assignments apply within the scope of each connection (i.e. per msk). 

> 
> /P
> 

