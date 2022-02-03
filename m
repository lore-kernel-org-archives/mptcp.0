Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36DB2F21
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 15:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643902852; x=1675438852;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=o+lfkSSvx/k+ulFWzxYOlX1RU6yVRRdCpwsk/2NJBNc=;
  b=F1BZjWqiDySIQAK4Jpl6eN9+FpG3b6uOhrxtbgOt5Ci19t0IgTsKaklA
   ZrKAKnuPrYmBg1s84rT5CsecXjjoFfHwVaqAofBFGfeAwtj+7yEBxBOJi
   ADHjO6iBI0/TdWM4NgcvvFq7jUhOncDXGikPqxGfQQGaai8Xn87569rzB
   ZnuCQ/MlfPpZ0hw9cS2FyA1ITzGL8DR0XZeziCiq7bw6G54Lo98FGjIg4
   JO5i2neIQ136zTr4Csm+CBc1nUOypouKsGt6gu2PRx0mEx9uiS3KK3CLM
   CYXeCQANkRJbMm633PCC3R3o3D+4kiJMUWdQsXsyYmJA102MIODeXGl2D
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="235568449"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="235568449"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 07:40:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="631376375"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 03 Feb 2022 07:40:52 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 3 Feb 2022 07:40:51 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 3 Feb 2022 07:40:51 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 3 Feb 2022 07:40:51 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 3 Feb 2022 07:40:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dds4K3pB81hIfPS7MbCcSnHk+jOo86e2BHoE3C024QopFJhZXP3V5KmjhdkhdS7jmWA7HRNJFMHNcJfk7AB6oLo5oG5/oFqrX8C/h2VmjCRxzr2GQtAgL/mmUzRr4w6KYDMk3ElaEapQWChMMZ7zEaQWcSNzSWvC6RbnbCqbubq44rPT3TwZ0XvSY0x6Fe8nQ7lsBlv7fzCO0rOtozcronCsQRzT0dZ6esyNSx5fdeiPWCXqneYf3SCQWA2OuuMuBcvYsDbmSQzMQcvd+wOmfaGk9fMKmtolo7lHk0bl770bP6p0xaNMEhPvAMx54mJ+lJzsyFoB5USk3dHnh+8H5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1dWkccd2NyjmQ/YruKGmCpJRbKsjgYUqm7u/OjfL7g=;
 b=NCPQDE/6sGCloobhL2Gkf/hMfgTv+DHYVp9SND0i8k/R0a6WV8HWKI3lstV/yDRfO4KVEL8D4+68s/9koHu7NyupJ1pYr7+OB3u/skQT+8/h6T+PC/YdgBSHlfwLsmhwXn6hdHJAvRFaGOgEwf1hOThHK8vx+7kZU32jmthljB1Dg7uIRnr1A1swbu2oIbAVF09HJS6fmATks3rBCQ5flrUYIHvampK5jBS2xCtSgKp3zWruCJ2PxiR3IN9ci4m6UVM0yjzu4vBvc2wdlX9li6WaVGF7f/oNuHDZZUhe3ioaTO+MsYo2StVCSCQScGGDAy2gDgU25P6sKrIlyttDuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
 by CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 15:40:49 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::44ba:c91c:ea6c:118d]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::44ba:c91c:ea6c:118d%4]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 15:40:49 +0000
Message-ID: <2ac8c034-dd8a-f8d5-e844-47bd5ed5acda@intel.com>
Date: Thu, 3 Feb 2022 07:40:47 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-next v4 5/8] mptcp: netlink: store per namespace
 list of refcounted listen socks
Content-Language: en-US
To: Matthieu Baerts <matthieu.baerts@tessares.net>, <mptcp@lists.linux.dev>
References: <20220203031331.2996457-1-kishen.maloor@intel.com>
 <20220203031331.2996457-6-kishen.maloor@intel.com>
 <758fee36-4b3e-0232-0813-e4dee8e53ebc@tessares.net>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <758fee36-4b3e-0232-0813-e4dee8e53ebc@tessares.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR11CA0028.namprd11.prod.outlook.com
 (2603:10b6:300:115::14) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:9e::21)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fac13fc1-31fc-4174-60de-08d9e72b8db1
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_
X-Microsoft-Antispam-PRVS: <CH0PR11MB53322710E5E2099A5CB68817E1289@CH0PR11MB5332.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gKsj+dKGeEdwvgmgIiH2PfB4UngFeuyZawFyPu5rf6NyGm534bPaDmHSY08Gnrakfl4Eud7s7CELMLau9KLmHw4xN3WWv1iSOjzGQHqXgWmrZCqUKA66nwCC9LNcnQ7f5eVzuq8oSh8klXE303NHgzUymh2bYux6i6U/7GZ+caSj8wpalYcuxN+/B/rSo2/br7/3gkKOqbVotMdL5bqxyP2RbLaQ3kUzOWI67SseBLYq69ELgkKwhIXXET39nsQWseS5SWsLgSfDTS8zKl3B4W103inCSo6Yy9Bxgx0LfYhg0DLxIHj8n6LnbqlFuVLETpJ8IVnuuif3vDp5JQfDYvM7zSf35gLVAC5FfE+9YagHKRb9Ywcj41ZYFKSIEPpjfVd7h8RyPsh0dZeB4d+KSCFGhNC5EGmWSXcksWOAokBPDhmT8qnBWsNof5R7Wu7VOVpxym3DGbB2v+oPVypaqgqUQ9aWuFa4uGYP5bDbtN0o/vDDEqT+9rQyP4hfy9DqJXr4lPU+OLc2RtcYgIyg7JCfTbY0h5DDLRMELC/zh/nxSklEeqzjb5KtbSp9MNXDNXk/pTX/bMB0Zue39YJryaju3xHk6XeoRDTeGbtm5/QQQA3LGrz5tOcPIHROs36fzdzqkymKo1nPYEyvryLypTyqJWYcC8c55pJKWquIIBVhJmj3A3XWh0dZaxK9HnTNAyqbfinlNr4s8/TAQEKQftmA/hd9Bcj0nHPqzt7RU1CPO5WDJhwpi36w7Bq7Qh6IqaIoCKAXOTQ4SjLZWoTH6n9/jQhtYl3NnvXwIHQweOr8ITt7b1FSarRDUkAZKkAg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(966005)(31696002)(6486002)(38100700002)(44832011)(508600001)(5660300002)(86362001)(82960400001)(2906002)(8676002)(83380400001)(36756003)(2616005)(6506007)(66556008)(66946007)(26005)(316002)(66476007)(186003)(8936002)(53546011)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0l3UVNodU5GSU12UGtFck9ManB5SnEzVXlkQXQzdnJCeTVUMjR4dFIwQ2pp?=
 =?utf-8?B?NU1ud3ErQVdxMFpPbHR3ZGR1RHkya2IvR1dPanU2UEhhbStmQUhoVVFWTkhL?=
 =?utf-8?B?ZGtYWW9MZjliN2Qyci8zbWR3WjFpYUV3RW1tNkxPRkVVQU9WNlM4V2tITlpK?=
 =?utf-8?B?ZGN3UW5rbVlTOGxtaG1hNytieGt5UEVlUGk0OVpyQTNoS3BuOFdWek02ZnY5?=
 =?utf-8?B?WkZKc0cwZTBuYkJPWktjbmxXdUFCNkJybGs1UHB5MFpDUEdUc3ZEQVorMEsv?=
 =?utf-8?B?QnN4SXhMcmxPaVJISHVkVWd4UnBXVDRwLzFDb2FYbW1tZmJmWmpYdHMvdmRw?=
 =?utf-8?B?MCtmZGtuT0lzOXgzVGJUKzM4V0pxNGhFOUpTUFR5UGltVUdKNmZDRlZNb3Bq?=
 =?utf-8?B?aytBbm5JdklJSFV6amN2Umw3WVNKOTZUbUVEL0tEZFk1L2gzSU13UUhwUHBn?=
 =?utf-8?B?b25yVElGSTgzQU5zKzhzMlRldkVEdURvQkJDcUl3c3BqWkh3dFpQajE3Tm9U?=
 =?utf-8?B?azBaYmFTVzdTdjRuM3BFbnAzVnhXK0VNeDMwaFcwZExjNmJHZjBaUzJHVXB0?=
 =?utf-8?B?VXlGdTg4MWFFbkFBZ3dlanllMVdyK1N1R1l3MndaUDh2VEM3MkJOamxzR3hN?=
 =?utf-8?B?cEY4ZElmblltbVF3Mkl2cmEreEtDcFZqN1kycll5OUFSQUxWQmZjMWNsL1VK?=
 =?utf-8?B?UzFKVDJUeU9MekJaRmxSdnNlamU4WitjVUpJLzdrQ3o3a3NtUnhzZ2VGcWpY?=
 =?utf-8?B?azVPQjN5VEFGdWFWcHhQOG5ITER5Z2FiWUkrd21XTWIvV05ST25kcCtsRU15?=
 =?utf-8?B?NHcxRWxOWnpiRFFFUE83NGNBaFJMV3RVSUMyREtQVEd3SHVhOHBnUDNTeVV5?=
 =?utf-8?B?VDY2dWdlUEJodG5qZHpBcE4wb1FvV2Z3RDdkY3lXT0tjRHVOSXhwZEtVbENO?=
 =?utf-8?B?djJramFCL0JzR2xJZTZKSTB3VkpURU1mMjhWTGdvWlpmUFpBUXBzZE56b1Fs?=
 =?utf-8?B?b0ZydzR5cW9ha3o5ckZCU05QVUlDZmx4aXlTbjJ5MGNqdmRpNGlnVlVZcDJ4?=
 =?utf-8?B?Zi9PVHhvWlJkdURNYjY4d2RXb3Q5eTcxS0hIVFZRbk5Jckoxbnh2Rmo4akFX?=
 =?utf-8?B?dWdRRitLMHVYQ3dURlg5Y2NBaW9ZcVNLMStrMDRBbHUydHNmRDN4UEVYNHNw?=
 =?utf-8?B?Y2YwaWNkOHZ6b0FVRHMxb1dBdGFJYlpySVJGSHgyUHlseU1ReGtSckJ2WHZX?=
 =?utf-8?B?WDhRZTlqRnNveHV5d0Q4eC9YaVR4U3AvcHd4UXFjei9UTEN4aGNEYXViN2Iy?=
 =?utf-8?B?dnQ0RGdydmxZVm9QL3g5MFZ4RVBVZThhY0NGY1FsaDAyRjhCWUNwYm5FS2h6?=
 =?utf-8?B?dkJKc2t0MDhGTjVMMmdPcjVPbmFDSWJmanNkMEQzazFyZTlKWjNteFZ1WW9k?=
 =?utf-8?B?alRTak00Y0R0TjNLM2FrYlhEdEVsdnlMelJ3dnpHMmhyRitPL28rTkt3ZEk4?=
 =?utf-8?B?aU5HZkE5enByelA3VVZzUVpaZ09nTXA4QW5nTlRoLzNHVTlCOFRoZGFKZTNB?=
 =?utf-8?B?Y3BZNENScWFOVWJkelhTU1o0ZkxUQmZuZ3lJTVZWeDMyUU54aHJQaEdnT3FS?=
 =?utf-8?B?NDloK2M3L0pTOWNCYU9pMWc0Sk1tbGw0Vi9CbVJzZXVNY05sbVVvZG9zWFV1?=
 =?utf-8?B?L3NYVklRK0pIN21CRENmdWF1QmVwQTFGQ2cvVFFqY2hnQUcyNzlNQUgvNmVR?=
 =?utf-8?B?a3YxdnRXTE8vQ1lTb29UZlllaGh4alM1SlZXZWFiNEwxcm10cGZ0dGVaSFR1?=
 =?utf-8?B?NUhnaURvSU9Jb0FwVWhwajlpdUdQTU9JUTRiRldSZkZ0K3JVc2t4Z0pOYTFz?=
 =?utf-8?B?b2NLWitaMURJOTdwTGhBKzN2c2V6bjVNWnF5TkpCVTRBSi9pL2JteEhOSTZq?=
 =?utf-8?B?cXJQRVR2eTF2b0FiMHNzenRlQ2dxMFgyTnZDOTcxdndEdzBPNHZ6b1ViOGor?=
 =?utf-8?B?TWZTN1JpaXB6eWNQSDFaRHdJQWR2WkxqdkJIZ010YWZLTW9aMDcvbmVqdnBz?=
 =?utf-8?B?RHY2SDZVd1o1TmUvTGkzS0ZtUjN1bDg2djdIdW1HSk9aVDBWVy9WNTZReTR4?=
 =?utf-8?B?M2pmbTRLV3N5dW52M3gwTGZIbE5TUmZYMDhLbWhCV3pYMEx5MVU0M0pBcTRu?=
 =?utf-8?Q?I8LCnOg9qGzQPmYQmHGyZjM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fac13fc1-31fc-4174-60de-08d9e72b8db1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 15:40:49.8176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aK0sk5M0wJrOoNI09ZgU1qB0LEicVd/e4lehaYwgs32FSkdodW9qeeFU9HCjg4VeCTTJPRiK3TR2jWLWPE1OOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5332
X-OriginatorOrg: intel.com

Hi Matthieu,

On 2/3/22 1:46 AM, Matthieu Baerts wrote:
> Hi Kishen,
> 
> On 03/02/2022 04:13, Kishen Maloor wrote:
>> The kernel can create listening sockets bound to announced addresses
>> via the ADD_ADDR option for receiving MP_JOIN requests. Path
>> managers may further choose to advertise the same addr+port over multiple
>> MPTCP connections. So this change provides a simple framework to
>> manage a list of all distinct listning sockets created in the kernel
>> over a namespace by encapsulating the socket in a structure that is
>> ref counted and can be shared across multiple connections. The sockets
>> are released when there are no more references.
> 
> Thank you for working on that!
> 
> (...)
> 
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index ff13012178ae..3d6251baef26 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
> 
> (...)
> 
>> @@ -83,6 +94,69 @@ static bool addresses_equal(const struct mptcp_addr_info *a,
>>  	return a->port == b->port;
>>  }
>>  
>> +static struct mptcp_local_lsk *lsk_list_find(struct pm_nl_pernet *pernet,
>> +					     struct mptcp_addr_info *addr)
>> +{
>> +	struct mptcp_local_lsk *lsk_ref = NULL;
>> +	struct mptcp_local_lsk *i;
>> +
>> +	rcu_read_lock();
>> +
>> +	list_for_each_entry_rcu(i, &pernet->lsk_list, list) {
>> +		if (addresses_equal(&i->addr, addr, true)) {
>> +			if (refcount_inc_not_zero(&i->refcount)) {
>> +				lsk_ref = i;
>> +				break;
>> +			}
>> +		}
>> +	}
>> +
>> +	rcu_read_unlock();
>> +
>> +	return lsk_ref;
>> +}
>> +
>> +static void lsk_list_add_ref(struct mptcp_local_lsk *lsk_ref)
>> +{
>> +	refcount_inc(&lsk_ref->refcount);
>> +}
>> +
>> +static struct mptcp_local_lsk *lsk_list_add(struct pm_nl_pernet *pernet,
>> +					    struct mptcp_addr_info *addr,
>> +					    struct socket *lsk)
>> +{
>> +	struct mptcp_local_lsk *lsk_ref;
>> +
>> +	lsk_ref = kmalloc(sizeof(*lsk_ref), GFP_ATOMIC);
>> +
>> +	if (!lsk_ref)
>> +		return NULL;
>> +
>> +	lsk_ref->lsk = lsk;
>> +	memcpy(&lsk_ref->addr, addr, sizeof(struct mptcp_addr_info));
>> +	refcount_set(&lsk_ref->refcount, 1);
>> +
>> +	spin_lock_bh(&pernet->lsk_list_lock);
>> +	list_add_rcu(&lsk_ref->list, &pernet->lsk_list);
>> +	spin_unlock_bh(&pernet->lsk_list_lock);
>> +
>> +	return lsk_ref;
>> +}
>> +
>> +static void lsk_list_release(struct pm_nl_pernet *pernet,
> 
> The CI is complaining[1] because these functions are not used anywhere:
> 
> 
>   net/mptcp/pm_netlink.c:146:13: error: 'lsk_list_release' defined but
> not used [-Werror=unused-function]
>     146 | static void lsk_list_release(struct pm_nl_pernet *pernet,
>         |             ^~~~~~~~~~~~~~~~
>   net/mptcp/pm_netlink.c:124:32: error: 'lsk_list_add' defined but not
> used [-Werror=unused-function]
>     124 | static struct mptcp_local_lsk *lsk_list_add(struct
> pm_nl_pernet *pernet,
>         |                                ^~~~~~~~~~~~
>   net/mptcp/pm_netlink.c:119:13: error: 'lsk_list_add_ref' defined but
> not used [-Werror=unused-function]
>     119 | static void lsk_list_add_ref(struct mptcp_local_lsk *lsk_ref)
>         |             ^~~~~~~~~~~~~~~~
>   net/mptcp/pm_netlink.c:97:32: error: 'lsk_list_find' defined but not
> used [-Werror=unused-function]
>      97 | static struct mptcp_local_lsk *lsk_list_find(struct
> pm_nl_pernet *pernet,
>         |                                ^~~~~~~~~~~~~
> 
> 
> I don't know if it is a good practice to declare static functions and
> not use them directly in the same commit but I suppose it is fine.
> 

Since those functions constitute the key API of the 
framework for managing listening sockets they are in the commit
which introduces that feature. While those APIs aren't exercised
until the following commit(s), the goal was to not club too much in one
commit.
 
The CI identified a separate implicit declaration error which is fixed in v5.

> Cheers,
> Matt
> 
> [1]
> https://github.com/multipath-tcp/mptcp_net-next/runs/5046474331?check_suite_focus=true#step:5:4215
> 

