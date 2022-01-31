Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3573FE0
	for <mptcp@lists.linux.dev>; Mon, 31 Jan 2022 22:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643667839; x=1675203839;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s1Wd3CEz545BzdSDL74Nth3pwmqyXYE8e9TRD5gOVB8=;
  b=OnuSSByd4Inim/JRKURqhsatzQGbz+a+V+chjs5H3Jn1c/eFmEACN4Ba
   1FWnfpGNJnqI5IRtQ0uEV3TVrDYTFNC/AB4e85ZUaYlENq0RS0FzdGV/Q
   r9oqAm474IqqkB6U/MCvD7ZXSxntqJNd1wqY5P9QXiGRQ2OrCsldMMvJH
   BbpZEHwcLNcQHHPbvSVF+eblapUeR/kZCX3hw7sPgCEh6IPhVQCfyAmjb
   rOwkL1mAXJcXrkNlxWPm2BdEhbuaqWlcv+4vVWpNqW9RLha4x3EUEu4jA
   PW7+2dkZLM80MRx7/zIXHCAG6xJ2V40RX2LyIlnOC0YAoCJ0W8a/zcBAM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="247781842"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="247781842"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 14:23:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="534327322"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga007.fm.intel.com with ESMTP; 31 Jan 2022 14:23:59 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 31 Jan 2022 14:23:58 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 31 Jan 2022 14:23:58 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 31 Jan 2022 14:23:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAL2PpfyBGuf4bUrvlHjYw9f7A5J7J/8UQgCDoc8SaatDFBC35Fuz+G2JfuX1TFtYNOKmS0JPchRj5cF5WZfBtrmoEd1XCh+Ya684iE6VoSqz2RK8qtwkGeiCX9pLe7GgxmvQlngm2WjYKJ5pzrvwSwKw3YmDyj1jgZSldOSgbajmm+Ri+bXGWZA2XffajfxZIAfiX+/mmmBOVE/5FIkOrQ8TPkrPc+VXAamOxM2nJQlK/4/F4pnHXVk2rmIUacifwt4eDWCxYv35m1VdWQlDy4pVCkFTr7tAKjosjmRlLc8BOfmQBDkPN90a4vcV4tm5m+CIfyiQ8YpgD8DRWfy5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgSoU23eVHG7XohTjsyu+ZB2QDcj7qEw54G7h6yz7Ug=;
 b=JlK+VRdFVJDzKm+q+siCwTmkwmlwq1b6d0dqDzg4IzIiCb+7mAK1RQIh6+5Fj/pI0X68tf76gbzqnC7womIr36t1MiTgehQiIDh7KDXEybB9GpIWZ7MEJrIuijQpCfe+7fBWs9TDRTmsFnR+LkLX8XtzBU9p+DgND0UZqY0o28PcKAd7mlD6l7xulC0iOWOE/6hinvmKBpmG4xE4od8KDKanqUmJPNZ+wNcN/x8RTGBItkXkk8nhmuTdWUXbcYD4nktcLERa1PRcFIKjg9Mc2Hroe6HWUNlIQY4Re/kmZs180GnQCBn9yLnQ7sMjdo2yyGKDX2868f1STDCq84nXsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA2PR11MB5145.namprd11.prod.outlook.com (2603:10b6:806:113::6)
 by BL1PR11MB5495.namprd11.prod.outlook.com (2603:10b6:208:317::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21; Mon, 31 Jan
 2022 22:23:56 +0000
Received: from SA2PR11MB5145.namprd11.prod.outlook.com
 ([fe80::992:6137:3ea3:6cfd]) by SA2PR11MB5145.namprd11.prod.outlook.com
 ([fe80::992:6137:3ea3:6cfd%4]) with mapi id 15.20.4909.019; Mon, 31 Jan 2022
 22:23:56 +0000
Message-ID: <01efbd33-cd64-8b71-7553-a80a9348f6e6@intel.com>
Date: Mon, 31 Jan 2022 14:23:53 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-next v3 01/14] mptcp: add sysctl param to limit
 userspace PM activity
Content-Language: en-US
To: Geliang Tang <geliangtang@gmail.com>
CC: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20220128003836.2732694-1-kishen.maloor@intel.com>
 <20220128003836.2732694-2-kishen.maloor@intel.com>
 <CA+WQbws7UHpc0LA3kd7wSqB_k-6aEN9HLm_JbeNSi0XzsPw=Gg@mail.gmail.com>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <CA+WQbws7UHpc0LA3kd7wSqB_k-6aEN9HLm_JbeNSi0XzsPw=Gg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0353.namprd03.prod.outlook.com
 (2603:10b6:303:dc::28) To SA2PR11MB5145.namprd11.prod.outlook.com
 (2603:10b6:806:113::6)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b522c91-85cf-4fec-6c62-08d9e5085efd
X-MS-TrafficTypeDiagnostic: BL1PR11MB5495:EE_
X-Microsoft-Antispam-PRVS: <BL1PR11MB549541AAEBBC4A39A635667EE1259@BL1PR11MB5495.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jxl51OxBIVQxXl11opYvkVwrIhkxOJYlXqThm4TUqnYL5PrNOEO9X2VheQNJ0ZrIW/uAjczwh227NeJVzB1sJNJP+XHdvPY9OoaTUn4u/B01AR0oH7QPrjU9QO6om351nBPMEOLcbKV3fH8wPugVV8CZHi+gKC2aCg3qKmi7ZfyhjymOEeAucSx8KH/U7IIl89s4ji/ExCVtVSnXOtl7TQxBHBugA1Jn4iphpMEKCUzsejC/ISGz6aXuRLkNnkOHvteVITG81wTP0N67LTfJcbzW2KNEpkXd1Xv5mSOE9PXFYAxDAXhyLOc9oJtGFXd3zO4cb4PExBwvh++4UJy357KtLUJiCwD/vd+XyBosog8Qd2hrzd6OlHVdVjH+hM7WtYGGyaZmp+8ZAzJcg/CXOqJBLvrrnCuKQ8NKu4PhMs5kVYmGf4L8z0UAO6Y7mG2k2nROOZRIIgopo4G+3fu1uIsZVnyUGZMz4KobybhBA+SEtLEgBLAqzW2jv0XaZICvXYOQOdqBDm+XYmTmm/Zbi1xrvsbA+cuzDHBq9X0rHW3h+I3Yop5bY+xzr17YLTPfUCP5ZugF6eBqOtY+6uBLSEIl7aG/CN+NL3gN3CrucVqsgMvJvA2T1MtkddAw0wKhKDelcHSieQ0YTibmJ2N+G1c3z590rFoGq+TpSmhDM14pafRSADdTACG4ITKmjvuQVsIaTumEM8Qci0n8WD/CSWpeuK83tSrP7qzc8TB5mMQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB5145.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(82960400001)(2906002)(36756003)(53546011)(6512007)(6506007)(508600001)(38100700002)(6486002)(26005)(5660300002)(86362001)(186003)(83380400001)(8676002)(6916009)(316002)(8936002)(2616005)(44832011)(66476007)(66556008)(66946007)(31686004)(31696002)(4326008)(6666004)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0lwZENZQ2l6YVNCazBGb1VYVmRPZDhEVUExWFRHR0R6NWtxS1JJZlBBSXNR?=
 =?utf-8?B?eXpZeXVOZTBYUVZqMnFrVnUzVEtjcGVUZGRXQ2pveTV4V3NybG5uQ2xJK3NL?=
 =?utf-8?B?Ykg1ZXhPU01CdS9aM1M0TTdpMjIxQUJWUDJvM0d1TU5qWTVQbHh2MlhzQU96?=
 =?utf-8?B?bGNtQWNzbitoSndBd0tlN3k4bkdDblhSM2MxWjE4bmQvZXhsOFlOSzFFeFlk?=
 =?utf-8?B?TEdjOVZVRUlOUzBjd1lTeXQ3RjVFVnRlajFneWkxc3QxUFZmV3E2dVF3ZkNY?=
 =?utf-8?B?ekdGVDJ0M21Uc2dtM2F5ZytkL3JFMGVWZWxLbGw3S0lFRWwzQmNyeGw4ckpq?=
 =?utf-8?B?MnpnNExpTUMzMGZLb05DcEVLd3J4c0NXMmRqeXJlRGN5Z3oyTmY3NnNUbkNI?=
 =?utf-8?B?U2tERnlCbm15bDQrb3Y4L2laRzZjMUE1ampTK1NCemNSbnJiWnVjdHpxRnZU?=
 =?utf-8?B?T0FGdzVrOElVNGVqZHdiaG80MThpb2NwMXZNVWx2eS9yaXA1dnE4R1VOSm0v?=
 =?utf-8?B?SE9nQVBsK1hCaVAxTjNqaDNPMmNaY25OVGFvVThrQWhMbGdqY2VuRkNQeGVI?=
 =?utf-8?B?TGxFcE1JTjMxbVdVL3liM3QyNUh1UVR4bjYwemR1ZG1qNEdJaHhwd0NyQkZ0?=
 =?utf-8?B?cndUcnZDSStMZ2xPTGJPcEcwWjc5Ny94VWpPd0h1aFdoOGtrSElBbHBxa2dV?=
 =?utf-8?B?eEFRVVFlZnZYckRxK2t4VC9JRmlrV1U5elhuaUVqMGRyaTNCMWp1bkU4WUVs?=
 =?utf-8?B?d0F5bWZrKzEzcERUYTBBYXVhMG8wc3drNHhzNWl1RWFPdlBuMVFvVXF2a2tW?=
 =?utf-8?B?clJjVWhFY25tQVJhT3kyc1V1NDBhOHFmbU9xNlQybWZWR0o0U3hsZ0lTYU1p?=
 =?utf-8?B?UEVXVkU4QmxmbXJwdlc0MUNmamppZ3I3U01WNTc2dm1pN212elgvenpkTTlN?=
 =?utf-8?B?UmJ1cHhIc2VjTVQxenJ3WXJpWks2Qy9ncno1cWU1WU9HY0R4YVM2UFh0QSti?=
 =?utf-8?B?cUROdFJyT3UyNkxnUnlpb08yL0tWZlBPU01IWWV3RWhqNStSYmptUkxRRENs?=
 =?utf-8?B?YlpZZ2JhdHNYSS9uY21yM2VFaGlyYU84WFFkMWdZOXIzdUZ4MS8raUZFc2hn?=
 =?utf-8?B?UGY0ekVsZ1pMazZGTlArNUdSL3EwVTVYYUdNYkFHQ25GTEsrTkJuQ1grWm1I?=
 =?utf-8?B?clV6bDErVC9HeTNRTm5lREVvRmdocmt6YWwxMFlNMWRuMS82Umd3bnJnQlJ0?=
 =?utf-8?B?Mm1kYnFqeFlPV0JOa2ltSDBmU29QTFhjV2l3L0habWwxaUpYVWRTZEhyejNS?=
 =?utf-8?B?Y1pCZTN6T2tXdGsxY0RJVzFRaFNyQWpJL0tWaVA1VmNvODlvbUZZNXRPc2FC?=
 =?utf-8?B?aFVpbERUYkt2NHd5QVhWVmJraXhzM0YybWxsQmtsR2lYWWl6d01nTE5hSHlC?=
 =?utf-8?B?MGhqemljNHhJUlFyOTFsYzBrQ215UmROMmFJa1JjYXFYeXRybWxJNHNwRkRw?=
 =?utf-8?B?cEw3M3VPeldaQ1NBQnV6RTlTZzlQdzl5YlM1NWJ3SWVCZ3NvSVhLU1h3M2JG?=
 =?utf-8?B?Tm1YSGVmdzFZZDNoK1BiTmFCdUIxZmNtWDBRaVQzK2F4dVlWbzQ5WkZpS3B5?=
 =?utf-8?B?NkEyNjhlNWk1WWdSQmNpN1YyWDloVnpta1VtTndia3VGUTM3c2xMaVlqSFlB?=
 =?utf-8?B?b0E0cTJGM2RLekdkMzVJMHkvRldwQjFERVBjRzU4T282b3JsSDQyVCtpUWdJ?=
 =?utf-8?B?VTFqZ051eHdOSnM1WkQwTUd3MjNFREFMT2JnRndERHk5RVgzcFNxYXpKTmZZ?=
 =?utf-8?B?K2lUcWdtOGFOdTExZlZkcWlyWHlWVzBjVndpTWtvK0ZXcjVBaGdlb2x4RzBE?=
 =?utf-8?B?VFoyUkxoeXF3b1lCNzVpSEplbGc4QXBZWXBMb0ZudUcraDVVdUNGc0xQTXJO?=
 =?utf-8?B?TkpQbU9iNnNFdVNCMmlvWnROaGF3WFFjZzZDL01TWERSN3JFL2VCOHdsUEZi?=
 =?utf-8?B?RmoyRHpNb2E1akkyRFFYZGR2Z2NjQ1FIY3M1U3B3TmZQTXBKN1lsT0FkYW1L?=
 =?utf-8?B?Y2toQ0JKdWNxRHpxMDd6UXkybjkyLzZ4WDUxVVc4QW5EckFNTlJJQzFoSTFl?=
 =?utf-8?B?bmhwWTZWK1BpNUJ3ZDFpa1MraFVzQklmQ1VmS2tPaU1TaC9MVXd5OUMvU0pN?=
 =?utf-8?Q?UJ1IJBk1cIsfrkBvk66KU3Q=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b522c91-85cf-4fec-6c62-08d9e5085efd
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB5145.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 22:23:56.7207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36658ZdSZw8ln3utszLkTOB5Z1Tk4wFS/gme6PpZFWNF/vi0b8biKqRcAo5z78VTorAasYPqBl2U2gT1gNk7mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5495
X-OriginatorOrg: intel.com

On 1/27/22 10:38 PM, Geliang Tang wrote:
> Hi Kishen,
> 
> Kishen Maloor <kishen.maloor@intel.com> 于2022年1月28日周五 08:39写道：
>>
>> This change adds a new configurable param userspace_pm_local_addr_max
>> to set a limit on the number of local addresses that may be recorded
>> by a userspace path manager in the context of any MPTCP connection.
>> Consequently, it also limits the # of subflows, i.e. to as many that
>> could be established via the bounded set of local addresses.
>>
>> The patch also ensures that other stats inside struct mptcp_pm_data
>> that are updated along kernel code paths exercised by userspace PMs
>> remain untouched for userspace PM managed sockets.
>>
>> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
>> ---
>>  net/mptcp/ctrl.c       | 17 +++++++++++++++++
>>  net/mptcp/pm.c         |  4 +++-
>>  net/mptcp/pm_netlink.c |  3 +++
>>  net/mptcp/protocol.h   |  1 +
>>  4 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
>> index ae20b7d92e28..dffc2da6d713 100644
>> --- a/net/mptcp/ctrl.c
>> +++ b/net/mptcp/ctrl.c
>> @@ -19,6 +19,7 @@ static int mptcp_pernet_id;
>>
>>  #ifdef CONFIG_SYSCTL
>>  static int mptcp_pm_type_max = __MPTCP_PM_TYPE_MAX;
>> +static int mptcp_max_addrs = MPTCP_PM_MAX_ADDR_ID;
>>  #endif
>>
>>  struct mptcp_pernet {
>> @@ -32,6 +33,7 @@ struct mptcp_pernet {
>>         u8 checksum_enabled;
>>         u8 allow_join_initial_addr_port;
>>         u8 pm_type;
>> +       u8 userspace_pm_local_addr_max;
>>  };
>>
>>  static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
>> @@ -69,6 +71,11 @@ int mptcp_get_pm_type(const struct net *net)
>>         return mptcp_get_pernet(net)->pm_type;
>>  }
>>
>> +unsigned int mptcp_get_userspace_pm_local_addr_max(const struct net *net)
>> +{
>> +       return mptcp_get_pernet(net)->userspace_pm_local_addr_max;
>> +}
>> +
>>  static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
>>  {
>>         pernet->mptcp_enabled = 1;
>> @@ -77,6 +84,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
>>         pernet->allow_join_initial_addr_port = 1;
>>         pernet->stale_loss_cnt = 4;
>>         pernet->pm_type = MPTCP_PM_TYPE_KERNEL;
>> +       pernet->userspace_pm_local_addr_max = 10;
>>  }
>>
>>  #ifdef CONFIG_SYSCTL
>> @@ -128,6 +136,14 @@ static struct ctl_table mptcp_sysctl_table[] = {
>>                 .extra1       = SYSCTL_ZERO,
>>                 .extra2       = &mptcp_pm_type_max
>>         },
>> +       {
>> +               .procname = "userspace_pm_local_addr_max",
>> +               .maxlen = sizeof(u8),
>> +               .mode = 0644,
>> +               .proc_handler = proc_dou8vec_minmax,
>> +               .extra1       = SYSCTL_ONE,
>> +               .extra2       = &mptcp_max_addrs
>> +       },
>>         {}
>>  };
>>
>> @@ -149,6 +165,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
>>         table[3].data = &pernet->allow_join_initial_addr_port;
>>         table[4].data = &pernet->stale_loss_cnt;
>>         table[5].data = &pernet->pm_type;
>> +       table[6].data = &pernet->userspace_pm_local_addr_max;
>>
>>         hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
>>         if (!hdr)
>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>> index e5d5cb847209..24839cd7025c 100644
>> --- a/net/mptcp/pm.c
>> +++ b/net/mptcp/pm.c
>> @@ -182,7 +182,9 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
>>         bool update_subflows;
>>
>>         update_subflows = (ssk->sk_state == TCP_CLOSE) &&
>> -                         (subflow->request_join || subflow->mp_join);
>> +                         (subflow->request_join || subflow->mp_join) &&
>> +                         READ_ONCE(pm->pm_type) == MPTCP_PM_TYPE_KERNEL;
> 
> How about using mptcp_pm_is_userspace() instead for all the
> MPTCP_PM_TYPE_KERNEL type check in this series?

Most PM related code paths in the kernel largely drive the in-kernel PM's flow and only a 
small subset of those are shared with the userspace PM. Among those shared code paths, I 
believe there's only one spot in my patches that has a userspace PM specific branch for
which there's an explicit pm_type check against MPTCP_PM_TYPE_USERSPACE. The few remaining 
checks are against MPTCP_PM_TYPE_KERNEL to bypass some in-kernel PM specific
behaviors in *all* "non-kernel" PMs. As we may have > 2 PM types by construction, the code
does not assume the userspace PM when pm_type != MPTCP_PM_TYPE_KERNEL.

> 
> Thanks,
> -Geliang
> 
>> +
>>         if (!READ_ONCE(pm->work_pending) && !update_subflows)
>>                 return;
>>
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index 126cc961a4fd..882988e43d76 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -933,6 +933,9 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
>>                 if (!removed)
>>                         continue;
>>
>> +               if (READ_ONCE(msk->pm.pm_type) != MPTCP_PM_TYPE_KERNEL)
>> +                       continue;
>> +
>>                 if (rm_type == MPTCP_MIB_RMADDR) {
>>                         msk->pm.add_addr_accepted--;
>>                         WRITE_ONCE(msk->pm.accept_addr, true);
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index 30006735afb7..6cfa8ec26482 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -852,6 +852,7 @@ unsigned int mptcp_pm_get_add_addr_signal_max(struct mptcp_sock *msk);
>>  unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk);
>>  unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk);
>>  unsigned int mptcp_pm_get_local_addr_max(struct mptcp_sock *msk);
>> +unsigned int mptcp_get_userspace_pm_local_addr_max(const struct net *net);
>>
>>  void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk);
>>  void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk);
>> --
>> 2.31.1
>>
>>

