Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB154378
	for <mptcp@lists.linux.dev>; Thu, 17 Mar 2022 15:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647531139; x=1679067139;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d1GGbcrK4DOw6FFC1QC7zm0IivnEX4fkTjrKJiTyKfg=;
  b=aKtGgVtsR5I4ZkYkMf5AxAH49546Ww7aLFmxRFypveg97KTz40k++Szn
   SyCj2oTKHpbCVqKtZDGy5Cr2qDK4zfI/M9RAxG3w1f8897EF/pircplJp
   ABtR0o3Kit3WSGkHg4bqZUCrFuSpZX/+FLPP6+E8bDlUp4+gT8jbh3aH2
   k/bCiABOHHJEyRLo+99MfebFMql/8mlxFedsSc1jXXuDVNnKDTM7Ur6r8
   JE2DqcmM5ZsxTo0/EI6r+QRqxXBdoP7RMP/40uA2Wxo+fQiQA52vmApru
   Oi8jgTcXg2EUle7Sn+PaDgNVgehZt1f7zjWZUffInsv6i553ldVTo6h2J
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="281685541"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="281685541"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 08:32:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="541410111"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 17 Mar 2022 08:32:02 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 08:32:02 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 08:32:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 17 Mar 2022 08:32:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 17 Mar 2022 08:32:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2HAB4r8+S/wiENLSGyZhfVnhQbCFyadHUBCB86SY2nFqhvhlceOLR+P5YAWpCKv4fbOJWP7bbLnCcsKBsPDpCASSY1YAqHaplV0CZWXnP9yUoAX1/iVJElpRuGxTV5iB2vhWLcMOFiQI0mW2UptGslOpENI9WGjOIDkDDx9RhE3CRdTM8X8NUI0xnzxKu6xkyAdtHdy9LVxKSXQwfS1X53ASvAGjRZ2q4Kbp3Smw26eXMifQ+LO1LUn8Fczq36JO/87JKqceCZaxFndRoomwR/MMf5vIxx7EIvATkhPEqVkBbTxaZPkOx+s2qslwyO8iHkd8nsODCiiDMJuvlCIwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13YaUZ3Dw4M/Y0AmCbJ7OJZUX1LCHSWnDMbic/dhw24=;
 b=ODFqwo8YyfOFhNFfuc0NVggeOhC+shsnpDVQaESvdcTgaSS0IPIa1YQ6I5NxXjGatBCrem/atWdm2tLoC/zxC1qOrz9aiINDduLgj/NjK4kjdV4IFXnfUmd2mlwq5c0dYELqAWdI6ekAxoys1+zkBOdr8Es0ejIas6hqsxqqu+dxW8tmYoXkBJQ6Hvn/X+EdZQiYMIUHUH+pV0+DGXsfiyqdBs1qyG5FPaAsLa11wslBXQ7dGcsfrf/29Yep00osidI28DWC6no02n26xtNnIkuZ+mrkaCmNGnoXUJaW7doSBexE14N3KeKQUK49paq68Xj5g28k7TT2E7JTyIbJCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
 by SN6PR11MB3421.namprd11.prod.outlook.com (2603:10b6:805:cd::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Thu, 17 Mar
 2022 15:32:00 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::44ba:c91c:ea6c:118d]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::44ba:c91c:ea6c:118d%4]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 15:32:00 +0000
Message-ID: <6641896c-2180-5428-ee5d-2c03c696b89f@intel.com>
Date: Thu, 17 Mar 2022 08:31:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: mptcp: expose server_side attribute in MPTCP netlink events:
 Tests Results
Content-Language: en-US
To: Matthieu Baerts <matthieu.baerts@tessares.net>
CC: <mptcp@lists.linux.dev>
References: <20220316190747.634325-6-kishen.maloor@intel.com>
 <e2b531cd-2927-ad69-81a5-c67b689fddf5@gmail.com>
 <42689a87-1939-07a6-d824-4ecde16d50b6@tessares.net>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <42689a87-1939-07a6-d824-4ecde16d50b6@tessares.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CO2PR04CA0192.namprd04.prod.outlook.com
 (2603:10b6:104:5::22) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:9e::21)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84b51d79-48c9-40d3-2646-08da082b4753
X-MS-TrafficTypeDiagnostic: SN6PR11MB3421:EE_
X-Microsoft-Antispam-PRVS: <SN6PR11MB3421EFEA2D4E1999BCD1D7D1E1129@SN6PR11MB3421.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f9Sdfg1UYLXCAM20jrbv5wGWdf/D/74kMfqXGqKTdoAplZfISP7xCZpIPrkGGHJrCmlDGUg1vxNf1kovXQ/Mdd7iJa73qPle7uXAusXfeXPG/3VhBEXfEtC4VkwvVRFauk0yBthmZyzzRN1Lsv0h+1YWqhspRTOT47bLi0bk3ZLRCpZDdohRIHebH8eGvv13G9R+OxZJKG4CceyNOIQZuUqaVhtWagdLxieq7tWLqokDBRmiKUtOu41BAIw2yiYgl6lP3aiiXi2ume0SY3ACg0hgNUzk0GWTzSJeRsGlo47gDRFdszTQpXyAy7G1WWGb+mzOxJ/7BkBn4rpM5seHtGo6i5ekvNoBXd3F/LrSXx/09jqUNfJMs03xlbZcxwKRD3KvNUDssFf4vLzJRKSgp1aKRk4Jxtl/lxsewXlsIkTiU37zRxBiQ8cDOhMhF0WYW82+7vnJSWW0moIvQXBVm8ln13sCjvZwzsV4YNFLhTEfmeG8gGY6+T3RZibN/yBkYGDAa5fCmU8Qdq1tK4ZJmBdFqjxajVWkJxulzvHaqky75Uk5JWrcSjVZt8GNj+wCxjOcDU6+0ZOXcJYu6Mbw0fwjv/3qPkhBzVBRT4vPTEaKPxNBAADT9Ub53PdNfJx0UQMzDJC/E/8xd63SNaiUo+KsabBpfNdfXNjTJvs3Ra+E8637G4U1ajJTSCHQK8X4jqAuzpPayK3gOQodydptqeZOSg/LtFyEDWcvn+bdQk42UL55ihJ+W6KmylM/LxvCEYij+YBrALPu2wX5FWljvyJZPjJsS37o4Ha5WbIK0Zqn/MlXav2kfItFXipJK6wt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(6916009)(2906002)(4326008)(6666004)(8676002)(186003)(26005)(31696002)(31686004)(86362001)(316002)(36756003)(44832011)(82960400001)(38100700002)(966005)(6486002)(66556008)(5660300002)(83380400001)(66946007)(66476007)(2616005)(6512007)(508600001)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZldRbUVoeCswR1JpeDdPdWRaZ3hydFRpSWQwdVFaY2VjRWUwS0o0SnZYcG82?=
 =?utf-8?B?VDQvV0E0Qi91NCtlMmRyZmdUd2d6UnBaV0RwR1l2OUIrcHQyZTZwRm9yc0ha?=
 =?utf-8?B?TU1aMzNZQkZDcG4waTFKbm15OXo2WXQwaGNrNlhGSVVrZ29PaW02OHhscXVO?=
 =?utf-8?B?c1U2cEdCTExuaktyQzFUY0NCcWY3Smt0Yi9pdDJHZk1YYTRGTTc4Z2F0VFY2?=
 =?utf-8?B?aUQ3WVlHanZyWk81MU02SW8yVzlpRDI2dnJLdnVtSVU5NWJrSmc3S2lHNCtG?=
 =?utf-8?B?TVpaem56QThaVEtuRlhMbUppVzFZYU5OdEIwY3hLS0JoSXdCeUgzTWpGcU81?=
 =?utf-8?B?Ym5rZ2lLUmNKZ3hEVkJEaTRZWVk4Tzg3dmZIak5GdGk0NVdGM1JlVGQ4THNP?=
 =?utf-8?B?ZnJFMHkzc2ZjcDRIN3ZPNWJMaVozbXlKR1FTZlJScE5SbERIR1V5dFBwd1hL?=
 =?utf-8?B?Q3haYnluT08zeCtyVXZVSjJHb3lCNHJQQlZtNC9hTHVNWjQwUG1BeXJQcFls?=
 =?utf-8?B?dUViZGd3UHN5Q21nS1ovVkduRE4raGRkRXlaajh2bU5rWkxqclAyY0lWQXF0?=
 =?utf-8?B?eWg1YVRrZGNMRUx4UmNMRlpmR0lDVkUzeGQ5cFRyQ2Vha3ovRWU4bS9rVVJy?=
 =?utf-8?B?RjRoKzZUUWU2VW16MGZ5aFlxb253amQ1S2xVc3gzd0VNeHgxelNzRUJzY3Rq?=
 =?utf-8?B?dXlweDZWb2p1VUtjcng3NER6enJYcnJncGJXNDFweDl2a2NSS3l5T1dEN3N1?=
 =?utf-8?B?S0NBMDVXZDZVaTA5Tk54WjFOTTR2VGxsZTJSQllUeU5EdEVja041d0c0N25s?=
 =?utf-8?B?THgwc2RaR3RYeE1rMnVSZ3V3ZnRXTG9uZ2ZXSEtJT1ZRUnJrUjdhcDduZU5H?=
 =?utf-8?B?K2kvNnhTNlM2WDNFb3QyS2pCWm9hTXU5NWtYbkZ3TzFXU3VhdEhHNHEvTFVn?=
 =?utf-8?B?aExUNkx3ZVIyeXBSQzEwWkdaL0NNTElPMkpSMUtVMGFsaVNMZGdqQ0ozbXhh?=
 =?utf-8?B?R1lDdTdXbVNiZzduWFd6bmRHV1dRYmppd0U2R2gwNEJWQlJlc0ZzWVZuK2VS?=
 =?utf-8?B?OW16UVZxZytlbkhIK2k2d1ZzUEhnQS9xN2ZPRmpZN0hjblNFVWlia0tBTWVK?=
 =?utf-8?B?T09wZ2xwNGRVcERoN3Q4Sk5PYzVCSXlsWDVWeklnaFhpV3FLT2Q5ems3NnNs?=
 =?utf-8?B?aWRYRm1WM1BOZXkvTzhJbVRYUldIWldGSHpoWCtJQXJLY0MvNXR2VEVVMjN2?=
 =?utf-8?B?MDMvWmUwZEpXSHhaSHMrczljM3JGSHlINmRHZXk3TEJIYmdQWnZmTXMwbzhs?=
 =?utf-8?B?eC9QN2V2ajlhR0h2b0VRWkxQREd2aFNWTEY5aVNTeW9KdVhZNjRzTHpOYjlk?=
 =?utf-8?B?M2NZUkpVODNtaWhtWUdNems5c2RWams0dkJFczkxSGN3NTFnTHJlZE9OR2dL?=
 =?utf-8?B?OXViWFJ1c3AvMDN1YWNreEpOUUhWR2UxSXNWK0dZN0hqL3VhREhyVUN5USsx?=
 =?utf-8?B?QUU3aFZRNDEyOHJSMnFsSURoSVJ5VmVQUDN5ZkJ6U1JCRnczTDVFOFJTeTUw?=
 =?utf-8?B?SGd5M1QycjlOU0tEbFR5c1JKK1FibjI0elBmaEpwVnRNeFhTTmtpMWdXYnMr?=
 =?utf-8?B?OXBvUGp4d2U2K0hMNDQyQUR2SW5QODIzUEp4SE5LSGFWN0MwMFhnRHlhdHVs?=
 =?utf-8?B?OWlHekV3cVE5SWhqUVVCQVV3MkcyQlFnZm9CSTNlSHR3M3F2NFAxYURoSFJ0?=
 =?utf-8?B?L0JFSUozT3pkaU5WS0o4R1lHQS9WUmVjWWxOWE5FNzdHMHcxVmZNcmt1V0s3?=
 =?utf-8?B?ODR2T0o2czdzRzM1M3AwY05hZDlXakhMNjkxMGRWSDhHQkVkODVGU0F5VCty?=
 =?utf-8?B?eVZlS3hwS01nclQrRTB3UWRreENZY084VGxDbHdyb2E5aWwxU056bUhRZmp2?=
 =?utf-8?B?bW9tbGIyK2ttdmVlR1ZWc1djTVI1Z3RoM1ZIUzlZWjdXRlJvUTQzQTMreCth?=
 =?utf-8?B?MlFTSWhuZktRPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b51d79-48c9-40d3-2646-08da082b4753
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 15:32:00.0375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KrYVDQolxex4gEvm/zp7X4GIS2joQknAMqy6dWc43DCquaJeruz6rZNxSzVfUmWituNHEZZpuDsYYv4xbH4qug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3421
X-OriginatorOrg: intel.com

Hi Matthieu,

On 3/17/22 2:22 AM, Matthieu Baerts wrote:
> Hi Kishen,
> 
> On 16/03/2022 21:55, MPTCP CI wrote:
>> Hi Kishen,
>>
>> Thank you for your modifications, that's great!
>>
>> Our CI did some validations and here is its report:
>>
>> - KVM Validation: normal:
>>   - Unstable: 1 failed test(s): selftest_mptcp_join 🔴:
>>   - Task: https://cirrus-ci.com/task/6221660377317376
>>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/6221660377317376/summary/summary.txt
>>
>> - KVM Validation: debug:
>>   - Unstable: 3 failed test(s): selftest_diag selftest_mptcp_join selftest_simult_flows 🔴:
>>   - Task: https://cirrus-ci.com/task/4814285493764096
>>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/4814285493764096/summary/summary.txt
> 
> The errors in mptcp_join.sh selftest are suspicious:
> 
>   echo  [fail] got 0 ADD_ADDR echo[s] expected 1
> 
> We can find them with and without a debug kernel config.
> 
> May you have a look at it if you don't mind?

Thanks! A conditional was added at the wrong spot. Will send v7 shortly.

> 
> Cheers,
> Matt

