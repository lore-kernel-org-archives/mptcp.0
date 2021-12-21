Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B1729CA
	for <mptcp@lists.linux.dev>; Tue, 21 Dec 2021 07:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640072144; x=1671608144;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=VeZ9xHJJd9zp7rJdV1FCBodeb+sjIEsGwUOqxECtfjQ=;
  b=cvaEgFbkDintdA8GK8fyzSIKumYFZl5AMMyI9vJbU9m912j/Dp/rGGFV
   8YiPepbwtCcIN/1WHWBqlS6OIld9s6VTkrjYXi2h/wxav8PFl5t1sLWcr
   nWroE6VPNyLN9ukbrkwNLnfUzmQ0w+/3LS7Y3ujFSJZ+BqCE0JS+Q+3Lm
   shRAre7v3eFow2/PSi4kOhibWu04Ia82SCoE0IR7HX5eG/RIFHF9yIO+o
   zzveXmQvWqjMM04nf3URdAuuD9sBdoLjyo0bsV1TuqfNtyXUZnoeRjq6a
   yYTXHYLGU8E/vQKO+MiYV9bKrNq39VaAB2b6gff1WNfKnk3qsTO4pVJBx
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="239090438"
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="239090438"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 23:35:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="586601153"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga004.fm.intel.com with ESMTP; 20 Dec 2021 23:35:43 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 23:35:42 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 23:35:42 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 20 Dec 2021 23:35:42 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 20 Dec 2021 23:35:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7ZbDub26bIhM/Kv4xYL25zeMBEJHUcRb0v48BO84mbRR+OK/CcJ2CAK0GHMA21iwX4DWagS7jMU1iUuep0OaeAN7Nq7/EKenx1bFaW8tE/w+U6MuEopNG/oA27MFrtfMm6C9jSoOUMjQa15FTPbhPderK+ydpXZtisDrNwETm94sVwQFwGeZP5YCyGPyfR7GQtrWJabrkRM41X0/dLZDCXfepq6wIhVrqlyDCBTtBXhQnukueXRhQK2H6Kas5wHOdqv8qQiRhOy3w7S8XkbbkwT74ZWb77HDIiIVBTvfIxbQXJal+h2zKK1gfu6veLjU1kdnhs3Eu2Fm+mKlJQGrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3SDp19J96d49dwCD9dF1fTS/ZOiBveYUcohFHRDFRQ=;
 b=VzFSpu+jhptAPmi5zcG1k1ZXRAb+z6GN7vKPesNzOyrVHzDJiUAYFDhXuVDOeHY7/cypsTQ1bAiBU0DrERnI9O4sq/SCZEYsGVT0L5VNa6Z8iQ/lcspgJIBJ5PYklGFpi2M0B65AF4HR6J5UxYFiZIXP1tuX8TjYLelmKbHV1oWdzAqhezWszmGj+h66LRqKRHMG7n1u+2TIBjGQoap4kVRhY8TS2/EWhQ3Kq96Fpb9QJ5urzpq5Sls9i4s9R4Yb596xAcV7VkrArgfe06a5m71tzc+3aRVGgZoYxpv4dEwsm4yPSuwEU1sNBzLwiQ2QPyO7tnrebRb0CbfLFCUyFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:95::6)
 by MWHPR11MB1664.namprd11.prod.outlook.com (2603:10b6:301:c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Tue, 21 Dec
 2021 07:35:41 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::c41f:17d7:bed3:7888]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::c41f:17d7:bed3:7888%9]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 07:35:41 +0000
Message-ID: <4cb68f04-5732-e1fe-4b3b-82a418d87f00@intel.com>
Date: Mon, 20 Dec 2021 23:35:39 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH mptcp-next 04/21] mptcp: establish subflows from either
 end of connection
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, <mptcp@lists.linux.dev>
References: <20211216222314.1244708-1-kishen.maloor@intel.com>
 <20211216222314.1244708-5-kishen.maloor@intel.com>
 <3b6e24478094b08d72da468f9865af798266fffe.camel@redhat.com>
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <3b6e24478094b08d72da468f9865af798266fffe.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0058.namprd08.prod.outlook.com
 (2603:10b6:a03:117::35) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:95::6)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8a051ba-88f7-4be2-f116-08d9c4547d96
X-MS-TrafficTypeDiagnostic: MWHPR11MB1664:EE_
X-Microsoft-Antispam-PRVS: <MWHPR11MB16647578E2F4070B3E7D6695E17C9@MWHPR11MB1664.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DyKPnanvETN088vBjF+pDaIQYnxO2dc7jzglUiAk5p6KvrV/tXWvFOldQXLHLCnEgyywWHNidpuZGxOkFgFK3YHKhvgx27nT+wnwbA9tVhHejVIA7ah5UiY6BktLG1zNeMts8hYeF3+pHnmZOeSd8RII5ndHFCNPCoy0tfgtBu+3IHI/SDL4/yTfW+4fr+ii/p3xqf92tnBjN1SGwzm+EXDS2V/Y0L2ZsAYVykxXAhaMWlZj5l2D6AvuOy/HZQVXDNeKs7VO8QJskM/CeKUgqyZ5nlwfdNSSSu+Ixy62JM6fYAx8Pw/Ms59ZJYCEhTWKG0A+0+5DlCy2yuFE7xZ2VD6Zy5BwW/Q/EYs06nc79Ovwr7v/YwGAydhpVxPihlx9xTbY6Fsph9htUEm6Q7NeeoOgUYF4GatUZYoZ1gxqhQ5ctNC8QR4GbT9F7PRpyQ/wU6i4lML20bqgHE8nS+9M90R43w/XcyaFe7h1sqDi2RRtMpRCauT83V+xI2F5sYJ1MUD9TNF6pNYB02JGUAS8O2gMhI0vSxmz1Yz6aqLuO+p4TlrdA/co86fLerdeWRbf5dPzY9xeOE6XQb+bq9JcwyJMD73GW4blRXdgS99GCQrmoT54w/+KR8CAiTDFl6kAJV6bHuvpe/mIzlw1mpB2OpPhkWKIXxDdzDsM3ChBMDZOWZjodrMOZAoiVuHB6jEcaZVSi+DAiZLlYJrwi6rR9/zcFk6oJMTMHnMu++okKNw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(5660300002)(26005)(6506007)(86362001)(82960400001)(2906002)(66946007)(83380400001)(53546011)(31686004)(316002)(6486002)(508600001)(66556008)(8676002)(8936002)(66476007)(4001150100001)(38100700002)(6512007)(31696002)(36756003)(44832011)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnFwQ2NKQjg2RTNIdytiMHI3U2FJR244cWlTR2cvUkw2RTR5Sm9ISkRpSE9J?=
 =?utf-8?B?bEJJODdCVzMxVFRHYlRTaHdmUW5zajR5TkYzeWR1MjU3TGM2cnhUSml1bXJK?=
 =?utf-8?B?N05QZE92UWZCYlBLc095K0gzbU1EWk9UMVc1OUpJcDk1dnZWTjE3azdrc0VZ?=
 =?utf-8?B?b016RVdPOVllS3Fsc0hpWVBIT253R2MxQzFDb1lOTTZ6aUM1cTlBNHZJUjBY?=
 =?utf-8?B?OTlRQnJkYVVCa25MNFdUdUNKeVRSVDgwZGxONEJ2S2l5R3ZRV0lYRnhoeHpZ?=
 =?utf-8?B?c0FTc25JQW9UMkhyZHdsVDBvdXl0Zlh4OWtkbVR3MHJVRVM0V0ZPRlhSbm8r?=
 =?utf-8?B?a0ZpZ2JXd2tDbXhodzF4YXo5aUdUOS9tcUpIamJjZmovYW0rOUg2RnRTbnVJ?=
 =?utf-8?B?bEpNY2twYTJUVmMyRVp5L01IbHZFMFQ5SkZMRlF3cHFDQ0tWS3B3c0tpRFYx?=
 =?utf-8?B?WEV5cmJxWmlsQ0dNbVRMZTY0dnVDc1JqWjNPeFVGTlNOTTh0bDhVblVnaC9y?=
 =?utf-8?B?TU1KWUYzMk1BNS9UQVJzRkRJWDdVVzBhbGcyN0FSdTgyY1dLYjFqOVlIVFRY?=
 =?utf-8?B?cEY5N2Fpd0k3SGlNbnNlSFI2ZzRhdUdxdGd6VG9XN0J2TlJsV3o4SjFGSVdN?=
 =?utf-8?B?OE02MU0yK0I5TEJYTS8za1ltWW90dDcxOWpxR3hiUHo4WWZIdVYzU3MzbEdX?=
 =?utf-8?B?V29UN0xkRHBSdWRPVmlMT05hNFcyTWRER1pmQTlxY1UrWDM1WnlFZFdVUjBP?=
 =?utf-8?B?Y24yQ1N5VzNOT0tub3RWNTFsZ2k5cmloQ29OeTBDKzNJLzkwaHhZTjVybHFP?=
 =?utf-8?B?NHpSemtLMWZsaHNoQWZMR2FSVXpTcGxBeDZqblpXNVJnaURWL3NrUlRMcnI2?=
 =?utf-8?B?aGhXZXpLMDdRYTdQbzU5eEg3aFd0dUpoSmY3emZzN1NyWVB2Y3BRUElZZzJk?=
 =?utf-8?B?TmJUZ2VBeVd5SHg5Z0tHTGdMbGVKNHJWdExTVktLVHhHeWY2TDBTbEl6U0E5?=
 =?utf-8?B?aW8wWEVRenZOV1E3Q2xObU44K1E0WExxT1dxRUdpNEdBNFdmWndraGlyM0lx?=
 =?utf-8?B?WjFpKzJOSTJGSFVWdFpMZHE4S3ZXQk5lTW5QZlBCNjBXS2d1amlzeFRMQ3Nz?=
 =?utf-8?B?SVVBbUN1OE1pZDVYOTM4ejVwZXF4K3RCcFNCY0ZQMlo0K3ZXbXZHTU1XOU85?=
 =?utf-8?B?NXNNZ0IzTFF0TTRyaVo5S0VXTncrbUdhWU0yNUhkaElqejdBL251NFVLdGVS?=
 =?utf-8?B?V3YyZzJtMkJjdXNmZ0lIclVMVGsxNVViOEJQak1sck16RGpTcWR3aHBtalRO?=
 =?utf-8?B?K2ZMODkrQ2tGY25DS2hORVRQa0FKOHhmWmlpZkZ0UHFDK1lLYzFvZ01hUGhZ?=
 =?utf-8?B?YmN2SnZFY2M4SUpZc1BEaWw5WjhkSlpZdk9udHY4a2ZFYmlsWnE4MTNMZFN4?=
 =?utf-8?B?elpBeUlVakxKd2J3TUd3aXlLOW5XR0c2NmNpRVRBd0NHY0p3eTI1dlhyLzF5?=
 =?utf-8?B?cVdGWUtaUHF4Nnp2N2FWaXI5TkFwbWFRY3BTUGYraWFNYkV3RERSTDZseVZw?=
 =?utf-8?B?MFhnSmk3TDU5L1hFYU9ENi9LclowNGZHRzU3SUwrTFJCYjdvYnJ3TTBUWWlz?=
 =?utf-8?B?WDZMcWJEWmg5cUt6ZXFZZkpteWo0Z3lIY0h2M1M0anBOejVvMGNUaDlnSXlE?=
 =?utf-8?B?RHRPMnZvblQ5UThHNGdRRmtkMEZDMVZ4NEU0WjNreTQvLzRIOGhzTkZLQ1Ev?=
 =?utf-8?B?eHFkQ3d6Z3htRytWSWllSFNCYjV5MzhmV3FTUGg3Z0JuS3dUTXFtWGM1Wnov?=
 =?utf-8?B?a1VIR3RvT0NpVTRiOVB4aURVZTNnanppOEVTZ0Q5a2t2TUdEWTRaRWYycVlD?=
 =?utf-8?B?cHgvdWRadkpUQ0tMSmVTcEpLa2dtOG96SUFiS2R6eDJIRXZRZldBK21nRE1n?=
 =?utf-8?B?V2YxWERaZWlRQlBoeFlGeUlpSUduM2VyRW5GcXlNZWV2MFZYQ21FWjIvOVBF?=
 =?utf-8?B?L0ZXS3h4UXg2ZlUxNWxxbTNhNGdXcTQ3S2NLS3RZVENTT0V4dEJUZGxoS2Ew?=
 =?utf-8?B?YVhFYk0wZ3E4UzBubFl4OERHeFBLeVg3cSs1bnNnRmFvV1liU1R0cmNHNzJZ?=
 =?utf-8?B?RTdzSkl1S1dOdVN0NVpobi9FUmhjSGFPTDJycVNEK01oMDkyN2tUYWVCb0p4?=
 =?utf-8?Q?8IEID3ZB7UaHJnXT3fhv8Ds=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a051ba-88f7-4be2-f116-08d9c4547d96
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 07:35:41.4430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwDtkZnWJ6nR1qErCEcIvNn5SzWCMG6hrB+RB92srl1W8quTkEetB7Dtqtq4GWHVRxSa/YZTjcQHe7ZVz3N/Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1664
X-OriginatorOrg: intel.com

On 12/17/21 9:41 AM, Paolo Abeni wrote:
> Hello,
> 
> On Thu, 2021-12-16 at 17:22 -0500, Kishen Maloor wrote:
>> This change updates internal logic to permit subflows to be
>> established from either the client or server ends of MPTCP
>> connections. This symmetry and added flexibility may be
>> harnessed by PM implementations running on either end in
>> creating new subflows.
>>
>> The essence of this change lies in not relying on the
>> "server_side" flag (which continues to be available if needed).
>>
>> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
>> ---
>>  net/mptcp/options.c  | 3 +--
>>  net/mptcp/protocol.c | 5 +----
>>  net/mptcp/protocol.h | 2 --
>>  3 files changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index cceba8c7806d..ee13bb46dc38 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -920,8 +920,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
>>  		 */
>>  		if (TCP_SKB_CB(skb)->seq == subflow->ssn_offset + 1 &&
>>  		    TCP_SKB_CB(skb)->end_seq == TCP_SKB_CB(skb)->seq &&
>> -		    subflow->mp_join && (mp_opt->suboptions & OPTIONS_MPTCP_MPJ) &&
>> -		    READ_ONCE(msk->pm.server_side))
>> +		    subflow->mp_join && (mp_opt->suboptions & OPTIONS_MPTCP_MPJ))
>>  			tcp_send_ack(ssk);
> 
> This change looks dangerous to me ?!? Or at least would the client to
> send an unneeded TCP pure ack as the 5th pkt in the MPJ handshake ?!?
> 

The purpose of this overall commit is to allow subflows to be established from either end,
i.e. irrespective of the client/server roles of the MPTCP application above.

> I think we should still try to invoke tcp_send_ack() only if this peer
> is passive side of the MPJ handshake. Possibly we need to use an
> additional status bit in mptcp_subflow_context to track that.
> 

Yes, possibly, if that mitigates the concern you raised. It does sound like your
suggestion would still keep with the goal of this commit.

> 
> Thanks!
> 
> Paolo
> 

