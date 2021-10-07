Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345D12C80
	for <mptcp@lists.linux.dev>; Thu,  7 Oct 2021 16:35:30 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="213440086"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="213440086"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 09:26:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; 
   d="scan'208";a="713389390"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 07 Oct 2021 09:26:40 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 7 Oct 2021 09:26:40 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 7 Oct 2021 09:26:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 7 Oct 2021 09:26:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaexoZ0fwTLADoYq7yrbaS/s26XTVfoM8XtMvRAQOB+P98NXhNOZe688P9DauSD8z7JyZ591DsY4xnoU/a0l7/fblk1FFJkFCeLytuLUOsuOcyN6lJVepDQ6Wg7g35f0QgOg9ek/TRpyNKaFWoSp5qCF82nVj4Radyu9gv12yzgpBp40qOigeSoZPKbYjlmRUEv/4n3eSnCmNiafRK9fxm/C5nogkxwK7rk4pZkKCHuAFzdWQ6PI4ajdy27v5fYy42rdJWkqZ9F5P5jVZT37YkmfPrffPIsDpocR2sX+EOXagH3TnNok23ab5jmVsM3aHdmjOJ1vIoHBJedvJNp86g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uCP09Uc8wizN4a84UTToVc8lQfiu/NZdfhrjrP090o=;
 b=K55P5pRTjuJm5pQ5+KNmY2VHf7Ti45kxvnrjp10ikua2eD59xTTvySG6kPcu5LvtNSZ/+xco3ZrT6udcwtUdAMg3qWPEEQ1AR72QGkSKgUV01AfY3RCxv2QfrKDCjm2qMwUnu3/cOCMmMKq3aIxX2O8HZ2dD+EeSmjjt9erzmiJ0T7ybbbgayUxlJo6zlLbH0zDQqI2XGuTltS/yxEwoVpDvzpaijr/At1jdACA7WQS7ZDZOAab0eZXjgxAn8OICgikQy9kLnIA0ocD0GyQ4DuJzSEluG8pWzYVGDS0N8IgRUsKeBbehF/x7OaqSI5qPB4nvf3lG0YwxpN79pGbzWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uCP09Uc8wizN4a84UTToVc8lQfiu/NZdfhrjrP090o=;
 b=gh3Fy3DQmxI6ryPjLRw8tngQvAacDIfRe3qDPsbe0LsbRqs88p4L0nhy7CAC59ZO5xi86mNVBcLALPeoZU4XPksqaLaHNWOqSqAHHJWjKoWQsjcQO8OH4MTHwNJn4xcyC/PNAx7P7LSWVARo8+XPyJw2C0h35JTBqHqufUsrBgY=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:95::6)
 by CO1PR11MB4931.namprd11.prod.outlook.com (2603:10b6:303:9d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Thu, 7 Oct
 2021 16:26:38 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::3134:f32f:19c8:324f]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::3134:f32f:19c8:324f%3]) with mapi id 15.20.4587.020; Thu, 7 Oct 2021
 16:26:38 +0000
Subject: Re: [RFC PATCH 0/4] mptcp: Update netlink interface for userspace PM
To: Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>
CC: <mptcp@lists.linux.dev>, <mathew.j.martineau@linux.intel.com>
References: <20211007043656.261552-1-kishen.maloor@intel.com>
 <20211007083218.GA7333@breakpoint.cc>
 <927307c6be705ab82341f8923842eb6687c253cc.camel@redhat.com>
From: Kishen Maloor <kishen.maloor@intel.com>
Message-ID: <279ff57e-2bc5-5609-2599-48bc917c1118@intel.com>
Date: Thu, 7 Oct 2021 09:26:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <927307c6be705ab82341f8923842eb6687c253cc.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR2201CA0043.namprd22.prod.outlook.com
 (2603:10b6:301:16::17) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:95::6)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from jgaid-MOBL1.amr.corp.intel.com (76.105.224.234) by MWHPR2201CA0043.namprd22.prod.outlook.com (2603:10b6:301:16::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 16:26:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01fa0ab3-0454-42c3-d0e3-08d989af3ca5
X-MS-TrafficTypeDiagnostic: CO1PR11MB4931:
X-Microsoft-Antispam-PRVS: <CO1PR11MB4931D3907368D285C55CD724E1B19@CO1PR11MB4931.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cDH43bq1cibugFFyiJztv1o9qY3cm7k89+vRVLrXiohAUlmMRcoCfzQSuRJUslfQww6B7ViPrwAELdEzIWoD7ZUvY1RsRV5/INae1SxACk2GgHNU7vBENjHr1XnMOfdqySLyQj/m6lthAg+YAgS7Ox9/D2zow+KeKZrHFd7882L6bR/Zi2cH1gA7nvYI8uJE27tTEm9csgBt5bq4XreLFUUapx7QGQQ4GrIME8nI80rqNXN1grJe9quzEMQIxnEskO/JM5/wAjdJ4lPYxVdOhFRI+ty6bivwo/yLl7PKyItVzWA9RuRMs+cEymWoGS9g1yV6oq54CCjJ4JwIF17lrR9TqB2Y4jfPwstfMpSR7CXAql2x8XqzUJJ8i+PLL7dvwe+WdaCMotqvo2viK60e/IrfchPJ7RJBHKbMcQCi9s/FpZKv4+3FeP3ra9Y6ThIdNiWfbJKNSoCL0Kayc3bjhre8zHGu4YftTNWnQQtGok2CDKZzwZ0O+ejk/yOa2P8Sg1oxROOkOymRbcGc/wvDkw61Jy/VyxaadJEpZ0XD8/ABfeHD38U8cTcST7aoByZsQcs6NP/6Tffr5jxqTvnZfHQVY1PZIPuIWLGwSE7gufTzDUZheQFfgKSzrc0WZP6MSioAOZWztAvQgjq+X4uFKDjEdEUQQeDxkmnTHLkbtavxitWohgb+S7DrxUsUlcVpKBr7gvFcBtpftrvUqxde235dhu60grR4uV2zlDaVMhHNi7a0+5mJIA1PfJZpFeSDNnVo4vXjMhgGiJIXfH60y9VGg+5LPIR2N2zBZYE7kBNmA/lym9mI6o/ufri6nYAK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(966005)(2906002)(8936002)(53546011)(6486002)(508600001)(66476007)(86362001)(66946007)(66556008)(44832011)(5660300002)(7696005)(8676002)(186003)(83380400001)(36756003)(31686004)(15650500001)(316002)(956004)(110136005)(38100700002)(26005)(2616005)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWJxOGhyQTFsZXkrdFRVT1VwNlZZSjJRMk02K1luekljUm1DbzgxK2pOdGFt?=
 =?utf-8?B?dXluaE5UeUxndjhCbWxNWWdyYUJqWVF1ZkJidi85bndNUWh1ZE5CWmhoZzNm?=
 =?utf-8?B?enQ0TWxUN2NGbmNZQnRTQlBGY1hYVjlMZ2d1S1A1ZWVRUXpHY0NsRTVwOXdF?=
 =?utf-8?B?SlRVajFTSmZid2VNeGUzNVJXM2VTSVNOeFNQelV5cXl4UTVwZWZLdm1ZbXdp?=
 =?utf-8?B?S0E2eW5KNjJYUEJ4Qi9SQktGOFMvUDBkOUF4TmRQSU5qbjBPR1plUzk4VUww?=
 =?utf-8?B?RmJXSGtsV2F0TDk0WjNucXBvejVML3JKZHlyZkNKaDlIUWszSXU5bkptSUk2?=
 =?utf-8?B?Q0xlcy9jM21TejQ1R213RWd3TVk5SlpPdUVCQ1NTVVErWG82ZlNmbEhZWTJa?=
 =?utf-8?B?OC9nQWgydEkySDhtT3l4aWtRNnBvdDdVenlyYXh2RWROdlFZbWZXaVlxVHVF?=
 =?utf-8?B?eTVUNXVTa1pUTlh3UGtxYjdRR2RKMUR6dmpBUURyOUp3R250bHZRZzVEQ1k2?=
 =?utf-8?B?aTYxRjZPNFp2ZmVnTU1xb0Z4QzlCalBkeFErVTl3M3N1dlVTRHRHdDdBRndL?=
 =?utf-8?B?Rll0Z3lZNVc2UFJuOHQwaFM4QURwZEIzUm9hb01hb21wSWh4aHMwekxkcGZz?=
 =?utf-8?B?N3UyY0ZiTHg1UUU1VldOTm9YSGVvaFlSMjk5R29XZStXS3JvMUJ3V21zRDQ4?=
 =?utf-8?B?SVRHQ0hZZkdYQlNIMFVYNXI3ck42WG96bTJGdDRuZStSMHJkM3BBcVVrMkZ4?=
 =?utf-8?B?Z2Y5V000U1ZyRWEzV29qdUlzQkVNU3VzdXZDNWtTQ1RRTEVZZTAxdU9GMWxN?=
 =?utf-8?B?K1BHWDZlSnRMcC8rallEUnNJcTREOXdPZkppc3ppc29wZmlrdzkxUXNya0lj?=
 =?utf-8?B?OEZrZWRhcjlnUVBTbHpBN2t3OHk3b3R3b1ZHaThvRzZzOUplNmFQdCtRTEVF?=
 =?utf-8?B?bDlpZFlLMDdEZ1YxTnZtTi9nNzZwcS9QTldEVXdIVEkwRHVJZ21CYktGMzFL?=
 =?utf-8?B?RkxudnhEdGlEbU1pTDBnanpmRHdhckN4UnZQRm4yUUVXMnN0TE5PWCtZOXhv?=
 =?utf-8?B?aitEdGwzUXJ0ZzgyNWdYWmpHUmJvaVFQa1lrSS9yVGdBZW9FQStPWG9mT2pR?=
 =?utf-8?B?RGw4di9FN0o1cTBldVY2WnJ0Mk5aNkg4MHpSbVh5RzZ6KzRONHNsaHZnaGQz?=
 =?utf-8?B?THZPV2ZEL2xWSmxaZkk4UkoweVpPa044Ym9SRUx1RnhsTG13YlpHcjl4dEtX?=
 =?utf-8?B?VEppRDQ3QmVwcVA4bVVNMVJIbkNYeDFJeTB5bnluZU1XQ3JHYy81ZEZTRHBT?=
 =?utf-8?B?U3AwQ0Y1U0kxL1Irc1NhUnRYME5nS0YwK25tQm5vOWVHTWpRa0Z3VTNZR2FX?=
 =?utf-8?B?MUF0a1NuTzhmUWtaVUZEZ01kKzV0NFk0U29WcGIwUzhsdlpySWZyTzVldlEy?=
 =?utf-8?B?NEpkMUZrb2szZGhNbHdXaTU3WmJ5cy81ZXNBZ3ZtTlhqaTRDbGVxQTl1SWVo?=
 =?utf-8?B?bzkxWnh5NFcyV3crOXExYzFLSXRvdVJnRlp6L29iVWNhMVVPMTBHZVJUM3VU?=
 =?utf-8?B?dkNpUW9tWllZQUphYTQ2RElZK1NGT3Q2aWk3RU5RblVkdDlUT3VyaGV4YmNK?=
 =?utf-8?B?RW1pSEpzcW9ObU9WSzI1ZGsza2ROUGlTV0FTSjU1RHljMTY4eEdZTnU4QUhw?=
 =?utf-8?B?T0tkbmpIeFNQUGRtV2Y2VGRsUmdPODVsS3FNMHN6amtxQ2dNUlE4MzVWbXAv?=
 =?utf-8?Q?5I3+0vOOJlW+vuIxpZ+CMzHP5zTMj+GTKiINdlj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01fa0ab3-0454-42c3-d0e3-08d989af3ca5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 16:26:38.0921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkkGdSY97D52kCJ2uf07FcGIu7ecDRKeG2X1UUh9NAXFcIkbr0qf6iXPfvk/9rgIuy19wk/ODXY0lET9IgyXvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4931
X-OriginatorOrg: intel.com

On 10/7/21 4:26 AM, Paolo Abeni wrote:
> On Thu, 2021-10-07 at 10:32 +0200, Florian Westphal wrote:
>> Kishen Maloor <kishen.maloor@intel.com> wrote:
>>> This patch series marks the beginning of an attempt to update the MPTCP
>>> netlink interface with commands to support the offloading of path management 
>>> decisions to userspace path managers.
>>>
>>> Specifically, the commits in this series introduce the following commands:
>>>
>>> * MPTCP_PM_CMD_ANNOUNCE: Issue an ADD_ADDR advertisement over the selected MPTCP
>>>   connection.
>>
>> Looks like you guys are further ahead than me.
>> I've pushed my work here:
>>
>> iproute2:
>> https://git.breakpoint.cc/cgit/fw/iproute2.git/log/?h=mptcp_sf_03
>>
>> kernel:
>> https://git.breakpoint.cc/cgit/fw/mptcp_net-next.git/log/?h=netlink_cmd_07
>>

Thank you. Just so its clear, I'd picked up this Github issue assigned to Mat mostly to avoid such overlap :)

>> I had planned to work on packetdrill tests next but to avoid
>> further duplicate work I will refrain from doing so.

I can say that you won't see any duplication here specifically :)

>>
>> Feel free to take what you need and/or mangle and discard this at will.
> 
> It looks like your patch:
> 
> mptcp: netlink: allow userspace-driven subflow establishment
> 
> implements feature not available here, while:
> 
> mptcp: netlink: allow userspace to perform address announcements
> 
> overlaps with this effort.
> 
> I think we can merge the 2 series into a single one dropping only the
> later patch, if there is agreement.

Yup, we can look into this.

> 
> Cheers,
> 
> Paolo
> 

