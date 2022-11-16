Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80080.outbound.protection.outlook.com [40.107.8.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD78D7C
	for <mptcp@lists.linux.dev>; Wed, 16 Nov 2022 02:17:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZ/hcItFlP7/71IAstUCgftesKvRbpcflUl6dts3HPRyfd4wXTrWYeaKGlDt/Ef7+lsbHNxEzzTiF2qWu+N0/tRoOngl9RbKM4PbWgJNS4E0ZCPDrCtQpfgspcdHhGantSCLtjtBxdUH8wBYtL7PX7AR9p5JOJUXXZpXZi2lOhIrWCAzYysNODL/u8Rfb3KnQawi7DDoZmg/9AaeMkoe3v2xUyEcrl+iEYmF9HNuYPQ2pUX1K6h/vces/j3V/iR1GHkEKpLQGx6Ywc/SfZRvwyfj/9MgahWTjtBn4eQA0NIVpg/vImTVKqsul34YVunH+Er/q5N4wioSYNE4jskiCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MJMmEqEC5IRjfcDSzbDd+HyMnODsdV5y0pxUUk4Ey4=;
 b=ecG7x+efQKtDJ+iUbUxUewKqqeHLCcEV/ObEkdVKac3wZ/PRPDQH7H0uAJiggn5xDD02SmDWQR0H0Km3vsAOR5QHpX9KS+CCujaNVmESeKwIrWI9X7dXLNPvAxUb423OD4GMFyTuoXKjPGhkb1jrDoSwCOtZQxmzo1bAs37W5s4+NAb9O2MvlJkZPAHECUVnmS9Ljb/gpRlur0HBSTellU9AKq10+5+ubV+0NgMNE9ygFpJgt0pfyy7Z63iadqURrI8PTsljkvUi6+GhK4bUufJczdPxIQ7ho2htFgkJZrUxa1MhvjgLmIEB7kw2GcuKfMlKQzRwJKsJ/E2pflKXuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MJMmEqEC5IRjfcDSzbDd+HyMnODsdV5y0pxUUk4Ey4=;
 b=tG8hXuYqhvsPoHsnodwQ5/TInI3e2jwRHHmpE200aHmScsCU7wHfutc1emuMnE403q3cfe6mdNuS0YiiE3AurifUpnpVuKcmI8Hbak+M9kUNHdyYdqLuatTaKS97Vu4JxVR3hbkY01gYyv/9RKAlilmJEbnbS/J/0U9cBTTiK34/y+vFK9Hs2lc/s7nhRa41O1qOc+5T0kmTr18EtNod6/omVSDo5/0rXmWjWu42xYB8qvnKNeqbywgnhuoQ/uD5Acfk+wVD3F2bnGLOKSTsSNzPSoYVFUfuDRoZkeHxwrt+/hSdMObepxsW93uT+DFHYetLw1SR1tXY37Goh5kN9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7148.eurprd04.prod.outlook.com (2603:10a6:10:12d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Wed, 16 Nov
 2022 02:17:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 02:17:27 +0000
Date: Wed, 16 Nov 2022 10:17:38 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v19 0/9] BPF redundant scheduler, part 1
Message-ID: <20221116021738.GA3565@localhost>
References: <cover.1668151131.git.geliang.tang@suse.com>
 <76ad0b0b-e55c-22cc-690f-c0fcdd78fca6@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76ad0b0b-e55c-22cc-690f-c0fcdd78fca6@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYCPR01CA0050.jpnprd01.prod.outlook.com
 (2603:1096:405:2::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d68370-ed47-4593-c3cf-08dac778b4e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iD5rxiSDLk/TVIIsRM8eT8nNJt2raFx8P/LpyGr8aoUjgPOfVC+26aAinTWlWfBRwwMlA6LNU/IiMufADDjBxB2nReuMlBtB0U+9yymXLVOdAUWa+VziQQmU7kIj4YMi1i8cwgR7ErxenEIGJGgQBrUUGJI8WAEqUNW2tTdxew1+A25236ZBQ9oE8XQMuXnwgBYHj6mPOusORgj3x+vh7nsXZZCIWcX4djWqJgPuLKG3IOAj1M6OzWaPqa4r1iw20faHtnKdsMoSxOnxoGxEnrRsSbRT4ehAUMHYpDWYkY2LCMqxnaDYSTOg0R5XF981aZ9+WiD1Yz5qGdtuW0wpBmxlPVCJi7aXFG/b/fafKX9SUJwYKJdYVPZP8F1OiUVkP2uBL8pusIx9ENICeepENk7fkExb1FNOHLGC1SJqWqcV+OyKGBs8BJ0urQ4K1/efglzLVEsUiL7SuLYE4RXuv8GEQ9caAXpvgBzQdgSvVKIXAdupQ11lt7RPW9yF9zop1m0Lw3uF6roHZu78csCkxjHjs2bAqWSvK82nz+R5GlON1aO/LCfpYyukFBdFf8zl1NDVy1I8RNv0lZg9jRGvdDuvsNVC4g+CKWaXuY/EUTaFMe9IE9WKrcoFz+N/YRcMe7UiVpG3wtpWPr6WHp7cACtu3hQu6BZTIVF/xNqmb4qCVQm4FB6fwrneDnFncDgOH+mNCS+QhlZpju1L/erXMA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(39860400002)(366004)(396003)(376002)(346002)(451199015)(26005)(6666004)(44832011)(6506007)(6486002)(2906002)(86362001)(478600001)(33716001)(83380400001)(33656002)(186003)(1076003)(6512007)(9686003)(38100700002)(41300700001)(316002)(8676002)(4326008)(6916009)(66556008)(66946007)(66476007)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2+6oNEBZ7pYJE28ANspWbEWeM86vVLrkoQAjg3EAxmQSFKKFc2dmN7xfGa++?=
 =?us-ascii?Q?gubAdUp6RO8BXd3povgaEEk8E+MP+yAC/+aaFnRHh52Fe6rIS6Wk/FM4T1/2?=
 =?us-ascii?Q?GhNyD3D/MEaumugYpwWlBa3K8T0nJYeJXpOOPpa7IwAAgEUKR1+1L3zYrXv+?=
 =?us-ascii?Q?cM4e/rvzZyNKh9I88qTPH6aFiAEdrX1eGl/Uv7TkOv2F2jopRGjzIat05BzH?=
 =?us-ascii?Q?ymbzzfFsJQGke5Jz3237iX2mwNcIFX9uUVIGh9BpTsJqHzoqN2NWfXZLWWxE?=
 =?us-ascii?Q?+rNDQnQLJoC4zR9vve8Cn0ZiJorMl4p7dkdddLKIrZpHPut/47UScQF6hfmH?=
 =?us-ascii?Q?D8PNzNO5WW6htdNLJHMfawDxIWAqj1Iq0zij+6LmTu5L1BdWzbXkhDBnDwRY?=
 =?us-ascii?Q?HWb3aKz//1EM5ryeqmIPpwoLu0Ih4ecZu3glsOwedjMoq//ap1U6jdepDZlL?=
 =?us-ascii?Q?sw9XuGi0FFUTU+cOvP210ClwOk0onClafpwNXDfH9acOSNKeu807nSbpEhQ/?=
 =?us-ascii?Q?n1L0/6uheg3YD17pCBsqsQ7N+7YRNWxkz53io3z3oE/SUz18OcVIrnuqa4aX?=
 =?us-ascii?Q?N/VKSLbv9jaDrtE944fAr1bGympH7oB9VCUcQ1uYkQrbeFBLZBxdR5VyOk/6?=
 =?us-ascii?Q?ab7NAENASV/HTGyX+FgWFFZ6y68h7TbGwCOm0bk1QjupyXayROaEXz9jNVCV?=
 =?us-ascii?Q?ahAFlHGkp+N7YzsnOgADBjEMuG9tsIpptcjEfzOYDujm2vfgU60WRe6PAobW?=
 =?us-ascii?Q?dUdUzLxczJFJQkc3sKftK/Y/IrwipANUlHhpCb3BCoVNrpbDU83DLkZHWDtn?=
 =?us-ascii?Q?hmBAJxQkL689+sYD7pXjnWh05WgSsS6w1ChoxK/507+/iicxlm8UyP/T6AQm?=
 =?us-ascii?Q?KvtTeOwY0Yz0Epbq1IO20kuN/zCPpoJKF//6trcldSLfN7Eq/i+SfOc6kmPx?=
 =?us-ascii?Q?V/MQLqUgZZmQm42MZBjp+bx5rHkbaXfTsLHmcw0s70uUtqJrZutrwtGLmO0g?=
 =?us-ascii?Q?PP+VsOZrYqjtY8j1bi5lGkOC8xjn76j/KCDZVKZPe++DAWRlyjwCCvCDziVI?=
 =?us-ascii?Q?szihGzKO3DJbTThvoBTY5Our0TheFXvF3q2jqgfgAfAZnq8hxHyBHH5/sd8L?=
 =?us-ascii?Q?VL+htVRgsGkFJvAgr9f0O3pG87opLze0zRBwfbSbT+RhUJS5CDZGo4X84t4J?=
 =?us-ascii?Q?UXN+NlOvFqWMyTU4DrnPGSMs3VNVmEx7QknprrpTYhjiK9YtLxKpQsfjYk/Z?=
 =?us-ascii?Q?0iFW///RDgnpfBHvL9VWHIGrLCBr1pUrpEN/w8i2uQalbdJmz4XyGyddKTbZ?=
 =?us-ascii?Q?9hi8h+cGa7pKZjjNl4VDdkc6ZuuM270nrWuRT+oxb2Y7ivgJ55D0Z3bPjBfb?=
 =?us-ascii?Q?Fo3NxYr/UHJCTuiNCyR3QR6GSjVBEurfPg7tFiFrcM8C8pQ9LQX1furL+6dr?=
 =?us-ascii?Q?7fmYG62q2WJtQpDdG92PP1NggvgmRowRgdErOe9vwcK/jn8uhR+HLLvZmoNI?=
 =?us-ascii?Q?o+HTEAdZoSdimyC4jkIoO6Lwp1t9mtit9sNa9FvHumxTDSTJGhf6So5mrp1B?=
 =?us-ascii?Q?t8BwnbBpog5oTM6/X/du9c2XuNdI71U8dMJQMZriZfCLnawzJG3Jn3KSp4P5?=
 =?us-ascii?Q?sA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d68370-ed47-4593-c3cf-08dac778b4e4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 02:17:27.2959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B4fPtbMiF0Ny6nk/zJIyZ+c/udsqasleqpjD2G03s3F/dd8M4NgfSsozIFXYp1RYZDH8aFtqMvk2ZnbwBjl7XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7148

On Tue, Nov 15, 2022 at 04:41:15PM -0800, Mat Martineau wrote:
> On Fri, 11 Nov 2022, Geliang Tang wrote:
> 
> > v19:
> > - update patch 1.
> > - split "BPF redundant scheduler" into two parts.
> > - rebased on "export/20221111T055536".
> > 
> 
> Thanks Geliang.
> 
> I think v19 (part 1) looks ok for the export branch. simult_flows.sh was
> slightly faster (small sample size :) ) on my VM, for what it's worth.
> 
> Looks like the first three patches go at the beginning of the "features
> net-next-next" section, correct?

Yes, the first two patches ("mptcp: refactor push_pending logic" and
"mptcp: drop last_snd and MPTCP_RESET_SCHEDULER") go at the beginning
of the "features net-next-next" section. But the third one "mptcp: add
sched_data_set_contexts helper" should be inserted between the commits
"mptcp: add scheduled in mptcp_subflow_context" and "bpf: Add
bpf_mptcp_sched_ops".

Thanks,
-Geliang

> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> 
> > Geliang Tang (9):
> >  mptcp: refactor push_pending logic
> >  mptcp: drop last_snd and MPTCP_RESET_SCHEDULER
> >  mptcp: add sched_data_set_contexts helper
> >  Squash to "mptcp: add struct mptcp_sched_ops"
> >  Squash to "bpf: Add bpf_mptcp_sched_ops"
> >  Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
> >  Squash to "selftests/bpf: Add bpf_first scheduler"
> >  Squash to "selftests/bpf: Add bpf_bkup scheduler"
> >  Squash to "selftests/bpf: Add bpf_rr scheduler"
> > 
> > include/net/mptcp.h                           |   6 +-
> > net/mptcp/bpf.c                               |   1 +
> > net/mptcp/pm.c                                |   9 +-
> > net/mptcp/pm_netlink.c                        |   3 -
> > net/mptcp/protocol.c                          | 161 +++++++++---------
> > net/mptcp/protocol.h                          |   1 -
> > net/mptcp/sched.c                             |  21 ++-
> > tools/testing/selftests/bpf/bpf_tcp_helpers.h |   8 +-
> > .../selftests/bpf/progs/mptcp_bpf_bkup.c      |  10 +-
> > .../selftests/bpf/progs/mptcp_bpf_first.c     |  10 +-
> > .../selftests/bpf/progs/mptcp_bpf_rr.c        |  10 +-
> > 11 files changed, 143 insertions(+), 97 deletions(-)
> > 
> > -- 
> > 2.35.3
> > 
> > 
> > 
> 
> --
> Mat Martineau
> Intel
