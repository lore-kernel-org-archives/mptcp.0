Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA143D7F
	for <mptcp@lists.linux.dev>; Fri, 18 Aug 2023 08:39:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jz6+qBBgoUSDud1Ofj6D/KzpbvvP+JgVSv9WgZorg9b5TFgi/hZZ5ngcJ6PAEiwFT4UzHnWUx5aF8RiAJUjx+nq+4DIOowkuSBvGAVkphDIVPioiBpMKwq6Nlx8pDv6Jjm986eXaZSj5su1K0HTO3GyYG4huL+yI+0GQw4kdVppEaEntP0kiYCVrApqGSH7+tRv+bnGLkAl5sV8dEYtQAATSTcMkAQEZcICskW5JxJKrOk4Xz83B1IH+ZCMX0LmdqHMp1rP3zHjetO+OPCR1dZ++gGf3K40YwIyinIpQZpxv7T7xe/aU7/wtILGBFaUKTTqXIoZVPGP0yCihu29xbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Y96Z2QnPST2uwtPRcuWZKf4jTY/Dr9tBeyPLl6cH+0=;
 b=NE0j+VusjvI+38wl2J477AyJ9i6y9EeADRurjlFCkIv8T/LmsmHdqof1Mr6ZZo24UnElgrY83k9cneonRgpYpFqVmv84rTeChAZTaeDVJ8OC/ZpArSLs2YfqAiFAPqRM/i9aE/yKUYK26ufIoFLirNwsouQmayj8H3XQDFdx8enbbuU2P3sjUnxVgqLjIn0IaU3Awe5yX/H1w1B3ILznHzjR3LaRI+1r2BmggtgfDNDZquBYWqa+wzou3DrDTcEX5LDKPLYGEhOJlMsOrVoHlZIAEdevP0k/dMC9QBe6TDjrvS+cdEV7Qgs/heRP1ePcf2Fr34xg0zeuvqlHfJmHAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Y96Z2QnPST2uwtPRcuWZKf4jTY/Dr9tBeyPLl6cH+0=;
 b=z2XLu7rEJYYL8arBLAn8D8xWYFhPK52PHi2kC4AVeaRt8LCksDWZqiIH/mI++EzEta+dDHzkkagMFMsLcj4mVUaTl9xGzPHK8Z1wDAylx6H6x/Wg0KT/HdMfYuJL7lJXEJqiLo+HKDHjVIDJeiA9cnCmIr500hgxYLa4SnhrwhQUA25j61UrJJhgja8CljhHcmUxsnjbAQwv2I/naVCQ80qITkwAd140u9pMll91HQ3E8GT9Ri/jUKWDrLCeP0Uqi2asBPYlP/MhkZA5B/+K9mUqKehImck7Co9hdVrNzv116pv61bk2uWAIkg/PPJbsuSrD4mzr32v88s7y5/xCwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9301.eurprd04.prod.outlook.com (2603:10a6:102:2b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Fri, 18 Aug
 2023 08:39:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 08:39:03 +0000
Date: Fri, 18 Aug 2023 16:39:31 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 5/6] Squash to "bpf: Export more bpf_burst
 related functions"
Message-ID: <20230818083931.GA21065@bogon>
References: <cover.1691036765.git.geliang.tang@suse.com>
 <644d34afc1b3b8d72b7c87baf099417d0be561ec.1691036765.git.geliang.tang@suse.com>
 <b2f50040-0373-4e5e-b4d1-f94c40e2f2b6@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2f50040-0373-4e5e-b4d1-f94c40e2f2b6@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9301:EE_
X-MS-Office365-Filtering-Correlation-Id: 97eb07f7-9039-4dc4-e3c5-08db9fc69399
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FPOm0fu+2xWqfSotGKYmLxlbYoNNKNIgGCtvgza0S5JY0XGvnLzZk/bL8VdmtyO5OJ6Y98cnm4n5QALjsInLyVAt8moMgr+LKOurYjOc7y3mer3PR1XsrvUCyg6dJrZQ6twn2Rruv7HvaFMvMzPvRYMnCJnwVHliDq98gvMPEY0LMPDzNAPjfF0sEH2Am07kj1GteuZVhlHNzeNIw379Bmmdd8SBGAXiOY58P0Apc2ApH87MqCgL4b9UFhE7UDGGIuWDPgHfkFC6vSPJqzo3uGvLzYXFuybm2G/TuiPU0iiLnOFkA/Gtx62peO25Fid5PnCzMUU6Y51zEejzuao6wnsbHIItqvITsd+T05uKV0eRaSAQSNTWx8SwiNU1TScYWZj7TthBT3q7YD5MIpFbh8GclMBXgY6JCUBDWzYextRkYtIWT/TN0es4XrZQfNegllI+S1OcQpPqQ4NILSiAftq4AmPGC3q0xINAT/hkHOO0/+Ou3Ltlj7CfsmfIyIB3aDrJb0854ca0RPWiTO64owBewrycFdkKYBkzrfYQo8AQk1nPZ+9pWQ2vWYjTY8C/0lZ17tL03xZZ/EtOgldauRNsZzknoygQON+WGQNNbKBxnchNL+xoBRv1nqe+T6pc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(376002)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(2906002)(83380400001)(26005)(86362001)(478600001)(6506007)(6666004)(6486002)(1076003)(6512007)(33656002)(9686003)(53546011)(15974865002)(966005)(44832011)(5660300002)(41300700001)(66476007)(66946007)(66556008)(316002)(6916009)(4326008)(8936002)(8676002)(33716001)(38100700002)(13296009)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oyahgHkO6Lb/kgOfDjlSnt1d6H7FNC5BlGzSBKhNVR6p+bh84FkZ97bbIdi1?=
 =?us-ascii?Q?Cth0MlAJv7AmTn3BKq1Mv8QzICRh3qW6Ct5y7f5leA8HEMEdFUzEycpCy0Hv?=
 =?us-ascii?Q?nSbvA/s/XqMCZoxJ4nywotP5LBGtBF7VJaP3rO+IZGltPjZSNmDPyrMN5qIU?=
 =?us-ascii?Q?zkR1kr6UdzkAuFCZJlR5JbelWTZzbyW6oz8WwE6JESDH4qRjalS3gOlRDSub?=
 =?us-ascii?Q?LKmfOKtW2K58Ux8VKHsQ3wRZg7MmhsB2/IARUjV3wQf0CHall22C4nlODJyT?=
 =?us-ascii?Q?f71pnP5s8bNJ508A/joo4LE1TN/eDkYWVrprIihgJPWGN6ZMaFpbccNewJt4?=
 =?us-ascii?Q?4Ggr1c1Cnedzl8t4FMA0HJo/uI7+GfSq+meVfPxnG5pMpgvHR2/2jomEbluq?=
 =?us-ascii?Q?6vYSvtT+HVG4MYZtgzv+F/TLyNuDNFGeEYyWS1w5AKFx3tigZYo2hb0b4PXB?=
 =?us-ascii?Q?Mg9rGznWZf7kH9o1k9fp0jQh8WEszlWz4u+ajfXGVfk9Y2acpPvzDoK1M4ze?=
 =?us-ascii?Q?7+AnlcXrqiGeizNvuceAuz++kEqe1c7T4hhsHVKJFqirqvdWUUhhwxQ3gSAu?=
 =?us-ascii?Q?25CfBKYSxEahZQKzqJqldI2i/EXqvGwnABW1naCeaXiRtnYuj5BTGPGx0Rqg?=
 =?us-ascii?Q?yQic6gAMI7TiVN9EWjXv9UF+x5wqg04aFDT9s1t9MvlP3WDTFqBoCXipppg2?=
 =?us-ascii?Q?qHqLmbO6NyaUCJdL3P5TH20mMHqPyDxWSZ5FfTfgh9nzKs5BAZwV7P5m7UVL?=
 =?us-ascii?Q?4/3x1hxVL4KCxuedi7d33sQqlp1h6jK6dSFsUmbqOYrGqHviM4civLEeYrb5?=
 =?us-ascii?Q?lm1h4y2YnWQtmxRPB2zN0ReUVbMcYL+ctisQ19kw+dGyEPDgn+DnNkkXSm64?=
 =?us-ascii?Q?M+OCQW0IAfnVhdgeOpZPPCDV5HcEjPfJYHcaSIN9LnVa1Q6tk6nYZTHifjKF?=
 =?us-ascii?Q?Os8JCyX4VBNEQjJfjkjmsUXMOGL5588u0eOFE5rGqGrZG3ealynjgbzeAZQD?=
 =?us-ascii?Q?KdAgSPm6fCXcuNwueGBKycvM4osQmJzMxa1Jhuy3bQMFeh8apy2sxmklcf15?=
 =?us-ascii?Q?D7a0z8SX7tCpwVSuqPsvPibBLfd3fM/G2cEQCB4fSOCfzJwYYJ1fZS7qmRil?=
 =?us-ascii?Q?CA0qPXRa8FvVehXpBRK28Ooth2FeGq78g2+6kWOi+bU8kiRbbICjrV4c0J0B?=
 =?us-ascii?Q?9wfnw7SDMWmQXXiqlYcqpUh/QaSx25kX4gX6Z9HNxji1tFKZUQog5wbrGwSO?=
 =?us-ascii?Q?HsVS3PHMinOmj7kQMcuXxaT0VfqMi8gpMN5v+hw7A0XN7Xzrf4qlEi8nuYob?=
 =?us-ascii?Q?qFuIG3oa/i6z7pMe+BU/Kr0sp8iYhG877Taugwq9qZc2wxA2/8pAQrcUF0Um?=
 =?us-ascii?Q?DJPLxK1OmyPG+yhNSKgJwPiyWj8ux9CbCjW+noPJTA/iVhbaVPLzU2YAqbCV?=
 =?us-ascii?Q?Xx+pL/KoB4ihHwX4Se+89U3jFZ+m446rvGbM9Cjht1UNtVw/BwAK249KHCqP?=
 =?us-ascii?Q?uQtT5iOyysBkjc7bjFrtcIZgTAAyeifSI4MhMxs79so3kjDZ9aDpsHkn1X0T?=
 =?us-ascii?Q?y4+uqUooBLF2CSJ+cEGiSkQeOPM/VwrUCrAOd4Uh?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97eb07f7-9039-4dc4-e3c5-08db9fc69399
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 08:39:03.3115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHA1UKap3ArxKgu/9Cbzq2ROQmpro+zXYVxk7CrVAHfNpJvtIpHdor2+7dVm88b8jPR9mXA7/fz/+vYLfJcZnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9301

On Wed, Aug 16, 2023 at 01:55:01PM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 03/08/2023 06:27, Geliang Tang wrote:
> > Add "ignore -Wmissing-prototypes" for bpf_mptcp_subflow_queues_empty(),
> > drop the declarations in protocol.h.
> > 
> > Drop bpf_mptcp_subflow_memory_free(), it will be defined in BPF context.
> > 
> > Update bpf_mptcp_subflow_queues_empty().
> 
> I also had to partially revert this commit.
> 
> Maybe "__bpf_kfunc" would avoid such issues reported by Sparse?
> 
>   #define __bpf_kfunc __used noinline
> 
> Do you mind looking at that please?

Hi Matt,

"__bpf_kfunc" doesn't work. I have to ask BPF maintainers what to do for
this and hope to receive their response.

Thanks,
-Geliang

> 
> New patches for t/upstream:
> - 11ace9718934: mptcp: partially revert "Squash to "bpf: Export more
> bpf_burst related functions""
> - Results: d30c287ad522..dd7fb06cb618 (export)
> 
> Tests are now in progress:
> 
> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230816T115317
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
