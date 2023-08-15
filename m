Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2069.outbound.protection.outlook.com [40.107.104.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0DB3C1D
	for <mptcp@lists.linux.dev>; Tue, 15 Aug 2023 10:45:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4lqXMWTtGPxwjHrQtt2+tD7lIfcpbg6OEbjN7wPQGvX97feaalHwQfsaymzwu4mTJ0WNN7DcgUo7ku6+SSu/gfm4Nrp4sKwqzeMAvZz29/9EPoe56lwyayhQPKGCHd9IDhXtZ0oop5rzxlYhXYJ0Aqb61lrYTQ2hRuDQLWnK1g0458pTxiD6Toa4gCas6HYS5RqrNVPcvxMOWscczOGssA1oLXY8KxfRyiyLpZ2FCeufUJaiKeNcQIVuk+zGYu38ugvQxh5WK4Q4OYEJK4mG3QPCP3y5dGzTaFleU9LnPCSrx9N1ZiUjua/wKIJV4rcB/guaAf+1QqJwZ/YhZ2K2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAAXql3Yrv8IptjivqgKV53RXg8qd136zG1/7YaiGOo=;
 b=f5fLVKxYuzENPeZ+pMjusFMn375Zk+U9amSnDZdZIuv6UFwT0JcjVrFA6musZkho44HLrd7rNgNtVYURCRh/8+1fneC9YyKQPqyQuUE+FHO091hFAMoZOrWB9O+QAG0AkDRtBck8W4YEEdOcy8zysRF5q7TG/VnOATZR2mUDSDLmgd7uH/KUThg1EGMzdH7a3Bq5ow/+5/0/gRNuzxaCnsrt42hyEvJtlRpodLATQPDQjP2nL5BlcHehQLMrIs5Ud1z8HxR32w92DmTZP8kI4wDrmPATJI0Z/KX8OjBi/b/Dnfu3ZtTQYnYW6es2P9CPS3OPkPDtjvWPQNhMK8KKiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAAXql3Yrv8IptjivqgKV53RXg8qd136zG1/7YaiGOo=;
 b=zB4oMzlwdHLxvOIT6Zfxsy1rQkrs+pjDvXEeFLVAgbGLrrwum6BLyzRQRS+BDlc2fLw6mETwY3ksi1buQ5iN4IyPuG5fgD/LE5MkItRboly37eJi0JFb+Ei5HQ1RqQHp0iI2bHlqUZThbrDRfq4NpRZSV0b0gHfRZn8W5nZUwQ84kyP7+lhAtrqYUD6XRMV7U/gTfWK2IINiaUBgIVkqpjltDNuTiFGy8WRIj0yhy0C4LUyX1HFaNnhAY7Am1kHEQxHkaNYMH0+CujFgCSVn/rHyZYoNFfTMGxf63QuBnvhZZB8QbCEmqOqgvawi5K18d1QSfdSPkSrOfgWHVR6kMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8099.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 10:45:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 10:45:29 +0000
Date: Tue, 15 Aug 2023 18:45:50 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [RFC mptcp-next 00/11] BPF packet scheduler updates part 4
Message-ID: <20230815104550.GA29593@bogon>
References: <cover.1691676509.git.geliang.tang@suse.com>
 <2eac859e-6884-40d1-af20-e79f58424e06@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2eac859e-6884-40d1-af20-e79f58424e06@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8099:EE_
X-MS-Office365-Filtering-Correlation-Id: 826df4a0-dd15-4bcc-541e-08db9d7cbdf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5HfMPARKrlVm7q0ZyrRivFdhMr+R5Nj24a7MgqjlanPlxxw6M31Q259SoB9qYRCbVoIxthP7mVG4qZAiMVN4na+Qyt2EgRZnUPARe16BEZTY9AEgzgD+cPm1JgOwUEc7+NFxNXknXSczbuXQ55hnUVgsNQqQD1K0URdMulGCe3NkqqzFZLbVkfTF40LwIuafGeOoZ1ivVgbHiXyg81hPfaWCPScQK90ThmZZRlXhUYlOVTILPghWelDlhMIY0khanJSjL8Nm1FWdNk0yWP5SHDys69rMhEOA99PGndy5XKJJnWyh/3aR5OomGMSINYPBv6RN3cfAh3Qri08IxvT0eH5Uf1jgng6sc99REF8JHh6Y/7fTLhhZP0oDSY5KDaDD0joZheBpMjI3TOzd015VlupcRvj/FP4Ns7cXpXtSI0VXGgTO1dQ+MJmhgUYmDzMLw5qXELCdR2cRpVy6LIuCTT5WkW5nZzrsOBbMuIXfP3ao29xZAqKOobVNkfopUL2BDC+TS8OaAck8oSIDptKg7CedlmVWDB2jAmx1LxJFibP1hRHvhXiDl+VFN/RGa4auTbfryLRiTa4hBx6YcY0hR4GTubav6Vi1Fc9Vhivlejzaw5mlL/0B9cbH2PXpRd51
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(366004)(39860400002)(346002)(376002)(186006)(1800799006)(451199021)(38100700002)(6486002)(66899021)(6666004)(478600001)(5660300002)(2906002)(33656002)(15974865002)(86362001)(44832011)(33716001)(6916009)(4326008)(8936002)(66946007)(66476007)(66556008)(41300700001)(8676002)(316002)(6506007)(1076003)(53546011)(26005)(83380400001)(9686003)(6512007)(13296009)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8R2ro3GwRcMhTe6mc3l1bp2jI00Sl59Awd+mWdnEp+5PC2+hYT9b5KFfBR2G?=
 =?us-ascii?Q?xF+3NyyKYHfTTwo3M5utSZ1kTXGcyH3fxvABKXs70UHRTPUXgPsXR9iNsEBL?=
 =?us-ascii?Q?Py/YkmbbCCsCrMbAT2w/8w6NKT3MQ/iM9N0FJIwi+78hW1tky6H38Iu72qku?=
 =?us-ascii?Q?i+y7/sCwZgTMcZVskIw8+Zm2YC7WpLmr8LO82IW3jPKegE6C/nZk+5arveSL?=
 =?us-ascii?Q?2C1TgwbsU5+/eaVIq9u7VxLHyHjfkCZ9l54fEBe6jtU5MY+NvwYpZgmNkDTS?=
 =?us-ascii?Q?epf/aoU+ZKtJnhrpJinlBaW7W8qpr60ZrDmZZouq8MBI0GMIvgH5dD7zrhFL?=
 =?us-ascii?Q?+ibONY2Zzs755yXJfoi8ivJw/Fi6ENx9eEzmGgeVMODUJn9ufp7ZdQWu26O+?=
 =?us-ascii?Q?9zTo5CSwQNFn5Amz40MlNSETuFDMJnUsGjGgySEIP/HLV7+ADLQYhVEUUdsT?=
 =?us-ascii?Q?2l2MPyDaBgYg6rPML/tq/m2PQeghIl0btvXKW6OgB/PYlHzrjrQGNpdk0rSa?=
 =?us-ascii?Q?E0XQnsWtoUdC1zf3G+U5NsfcKKPXHNhmZxcJZBTRDQCyzRMlmlKvcY9HXz6v?=
 =?us-ascii?Q?t1dWI2PWWHw55nml5c4ZN5H2woSfqmQsRe+yGj55tL5LpKCV+aqDfGp8Uj7W?=
 =?us-ascii?Q?C9DJDiYHxzyMWfzgaLWsoqCMJWD0jhkgyZMtvg9JGkf6UnfvoP1x6WBqII2K?=
 =?us-ascii?Q?u+D/cSSYXltEfbGndXyIRbNSK2BkTarc7W9fynIZ3HroICdZysrF/IWzOWjR?=
 =?us-ascii?Q?FiGyH2QxjePiDE7/WNkLpFqke28jnQ0TspRCymV0p05o8mU0kSFpF6GFN7fm?=
 =?us-ascii?Q?zSM3NvTul0ei7s+BG35bjWAJpQN/wOLVuzE2B9vCF4nWf1KTHN0pUfNZoB4s?=
 =?us-ascii?Q?5v5sWDloba++GOY84aM2q67BXaCwkVdcldOtQLsuCeQFtcIBdH6rvJ2tWhUG?=
 =?us-ascii?Q?C5b5YjvHLF6nTNV5K5Fg7UeTtoiVPjEOLqpblfl9fOjlc4xWwTh5VCwGo4ZE?=
 =?us-ascii?Q?YGtukg6w2WgQRyia+nuD0wxgFQw8zA/N0jtGrsCYxUiTd+KjPN5uaYXl4kBg?=
 =?us-ascii?Q?6FPQSzVY5MacK2I2c8jul0WDdtdZ/LlDA4hQsrNcN5dKQ+R8wBn9fg6AeGk/?=
 =?us-ascii?Q?Fyzdu6aK9YH13aXdg+gwsZGLFKps4JDuCBh6cR/ch1AyXKspiZbv6Mc3Vux9?=
 =?us-ascii?Q?kBz+RHSDQM2m6ORMvkQa3qWWsVVsxidsRMemRkIAQE024go+lqHMvh6qqzh7?=
 =?us-ascii?Q?RnLHJDn/QHgbDJs7VCIqQV4T4AOBmlPUAgCxTYkQfCDYIAGMc51dKZlNoPgJ?=
 =?us-ascii?Q?I9BHQG+XegcHB50AzwN5980ihopG/Wtsgzvgv5pHOFbz7M/ybiNEqOOd1lrO?=
 =?us-ascii?Q?tlW8wD6m2AR4ctCyzeeyJriNyG8m4BvRHYdJuvxsPm7U+QjMpWb4CyaRHEGg?=
 =?us-ascii?Q?/kwvCYel1bcpggBaIxJkgB8utXB1mbsdZNb7dayd17NU9J591LLMFyuhpFiJ?=
 =?us-ascii?Q?3PPBpehvntDa8aKeqNhMVGfU81fPoWCWXihndcxJQZGDc/uSqJaJ6H+ti6K/?=
 =?us-ascii?Q?p8072gI4GG6ksAZ3VhY6J6ALl75SpGYR1UipSBdX?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826df4a0-dd15-4bcc-541e-08db9d7cbdf5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 10:45:29.3070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMG1YQSRITwVfcRwc3q9RV9VIQNXjMjkiAC1BEBgrPXCnAi95M7nBIbl6FmOdT7HJgq6gk38Zte76Blwu/9nWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8099

On Thu, Aug 10, 2023 at 05:50:05PM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for these patches!
> 
> On 10/08/2023 16:09, Geliang Tang wrote:
> > There's a bug in bpf_burst. snd_burst stored in mptcp_burst_storage in
> > BPF context is not used. msk->snd_burst is still used in kernel space.
> > To fix this, add two new interfaces in mptcp_sched_ops to get and set
> > scheduler's paramters from BPF context to kernel space.
> 
> I didn't fully look at this series in details (and I don't have the full
> picture in mind) but I'm a bit worry about these parameters. I see two
> ways to extend the BPF packet schedulers:
> 
> (1) either we keep the API as it is and we parametrise actions like here
> 
> (2) or the new schedulers have more control on what is being done
> replacing what the core is doing to select what can be sent and where
> 
> I think that if we take the first option, we would limit the extensions:
> when a new scheduler will want to change what the core is doing, a new
> parameter will need to be added with more indirections, complexity, etc.
> 
> The second option requires some "big" changes in the scheduler API but
> it is probably the right time to do that and probably worth it. (but
> before modifying the code, we should probably discuss high level
> architecture). With this new API, BPF scheduler should be able to only
> modify the parts they want, leaving the rest like it is when the default
> scheduler is running (or use helpers to keep the behaviour of the core).
> 
> This is also somehow linked to issues #343 and #344 on GitHub.
> 
> > Geliang Tang (11):
> >   Squash to "mptcp: add struct mptcp_sched_ops"
> >   Squash to "mptcp: add scheduler wrappers"
> >   mptcp: use snd_burst wrappers
> >   Squash to "mptcp: register default scheduler"
> In other words, I think we should not modify the patches above and send
> them as their are to netdev. Then think about the strategy we want  to
> allow "any kind" of packet schedulers implemented in BPF.
> 
> WDYT?

I agree, let's deal with them after the scheduler refactor patches are
merged. Some patches below are still valid. They address to Mat's
comments in the series "add bpf_stale scheduler" v2. I'll repost them
as a v3 this week.

Thanks,
-Geliang

> 
> >   Squash to "bpf: Add bpf_mptcp_sched_ops"
> >   Squash to "selftests/bpf: Add mptcp sched structs"
> >   Squash to "selftests/bpf: Add bpf_bkup scheduler"
> >   Squash to "selftests/bpf: Add bpf_rr scheduler"
> >   Squash to "selftests/bpf: Add bpf_burst scheduler"
> >   selftests/bpf: Add bpf_stale scheduler
> >   selftests/bpf: Add bpf_stale test
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
