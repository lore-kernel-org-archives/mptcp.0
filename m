Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E348D51B
	for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 22:20:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGOHM+qsw518DXKmZRLJntmKyHmQQRnM9Nt0gR/Vbt8R12Q3NMmEDgaRg8+OXQoAo2fYtIArmTDCtbbicSAIO/SoJN2gHfrZZEJ1BAVlO92aodQxkCwkWYrG0cJrAemRCcunSsTlGTQR684H4JRIagtcOMXA9rjLPOzNkKWkHSlRvZkeunpJbl7VYfX4BAC/mcxOLKd8qnGooRgIJ3TcbUoalXNWUmfeUZCPNBGNF/w/w5LimC813ydgSut/3vvm2uoa5USX5Vp6s9R9xhWJwFMKkN+gM18nJiEySqu+UR4YzKu1+4AE8SJne9YJx7FSsWQj2vFA7D8fPAG9flutyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDLU1J5rayh8zhcDDS/hmO3aWXchJ8BR2mbRMx+u32E=;
 b=R/9kWKwhjvnwEEEoc2hj8jNoqxahI7KY4Yu0ZvfbS0Mk7lLtZjeXd2HcgXY/amizf5YfdXIREr0gxIknQ5YK4wUsfQkSWW5wcq3XnZjZ/zpuZJKuQYQv0X9bGMMjuJsgkvRr67TOB23w5H3u0uLYd9EAdZ9rVSWuFdT7IZpGCEjXM/s5jgCdKu/3zGJFUQrbH9+ghudZmL58IfBADr2UNnysaHIYQTb3o6VD6Qw3Qopje5IO0zw7cZ6REwPcgaizj6UHjTDw8qu/QVB8QYgimuN+xj9l3i62yE8HhRxh6pqOm8McgES4SuJ7KV3Xu7N8CpEEEo34Xug0hPMXkZ0TJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDLU1J5rayh8zhcDDS/hmO3aWXchJ8BR2mbRMx+u32E=;
 b=LMf6iIzWl6lY/OLMxX8lZb9TFtqFhPU7vie1/sQW0uBn+9DTsngIOKb2YTSkceDLfKxyMNusJ2P55eYpXtkP+QJz1AYlquFjRKbla5Y4kD386UMIkjblVzCIF48AyoV1fqlzFaj6AVWnWtmSwKfVE1nbh1HBwa97UId1Hbb3sz7gEhSmHLl31L5VFfdhKF7V2xkk6SOu2vqigFAnulHphaRnEYfcJHJh0+CHqXzHc1ZubfmdJEBTbte7ep6iDnerRUjmCKdgeHyqYQMG9pQPGzMsVelTVYY4wuAcvuQHCvPC2PD6gpAebu7gQQCO5dOot5lUZP+PNLOc2LpiGdowRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7625.eurprd04.prod.outlook.com (2603:10a6:10:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 18 Nov
 2022 22:20:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5813.017; Fri, 18 Nov 2022
 22:20:01 +0000
Date: Sat, 19 Nov 2022 06:20:28 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v20 0/7] BPF redundant scheduler, part 2
Message-ID: <20221118222028.GB3222@localhost>
References: <cover.1668598782.git.geliang.tang@suse.com>
 <68561c02-7c8a-d460-1139-1822499af26e@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68561c02-7c8a-d460-1139-1822499af26e@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR06CA0204.apcprd06.prod.outlook.com (2603:1096:4:1::36)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a0d127-073a-44e3-261d-08dac9b30915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pPXsYpeK3/4yVcFoFr333m8TF98VXnZLPD6TfJF/WQ2We0BZJqyV62/uODBNZk50FvDxifECf0MMG7awElk/c74u0VxsfETGWAS5X1l68K0z3mBT8PoWabyiztKeWioEt/yTe3F7HOAl1vBmOem+KYXB3mmqD1AJoriezcRUkwwYE5LH3bMXjHJ1ssUPHAFjimnHN0FNDNrgai1rQeFT2jSO+t/go4khP6Ug8CtXZH6ev4XLYckjqBGAj3fw5P4yQ8pZ8VcD/hnIkSiBmVWjppY1if3awdNTtaoMMu7G16d+cYjNH3WYHlGnZdjBGGqaGErUsPKYCo7s5EE7FgG0pC8zpeQmV6fCfdTmuW8rxKkQcJsrhjuZpom8deGnGsnQFAb7n+35df7SiShX/LEjUqucW2ak/oz8G85Xc7ZStcqTN+G7jyr5R0iFlHr9iSrHFBfqC64TYhbIcyU1K4Wdksck8nHms/lHgMv/evGUTMljcnHWsDm6GKrzu3BNY2GGADBpiqvgn4QByCkK4njwZWgYr4LWsvkpiOGhbvdSoz0lXqZzRKQ7AXxcTnueZfOnA9nb6erZbRFnj6Fj/pI4BBRC4I2dTn+OEUZCofVlV5tWrbV6myF2XHolHLkqSHfyxIAjm+0YtiJpACoC8cvZ9lRLfMavDmVo1iwXhtIREmM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199015)(5660300002)(44832011)(2906002)(41300700001)(8676002)(66476007)(4326008)(66556008)(316002)(6486002)(66946007)(6916009)(6666004)(33716001)(9686003)(186003)(83380400001)(86362001)(6512007)(26005)(478600001)(1076003)(6506007)(38100700002)(66899015)(8936002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nEwPDEL9W7foXrA4CiCK1TdFYQSzGUeA7p0idQts9NEHdEM5fAgGoC7hYLeO?=
 =?us-ascii?Q?6zs2IRjIMQXZZIZz7XmMB6LzmHfhjIMSG0aIlv9/gVeEzAmVn3z6GgJIPNHE?=
 =?us-ascii?Q?OSqzj4Fc4FzmZBfXTY8+2XIcUzZzS326jUPPE7el12QqDQhX5lIzflmzJeA8?=
 =?us-ascii?Q?ntHIcO0sdDlYFqQmdOYj/zKRPpcP3h2WL4IBuhKOY8C5U3AmLMWVfNFyg+Ev?=
 =?us-ascii?Q?I5i3jqjpBxieUp2JRdiAjaVsnyj9j6YSwurI46ExLIOn3z4TZLGgLCXLNpJn?=
 =?us-ascii?Q?wwOfu8N7R4u5FIPA8feg7WY6uJUmbD3hPdWrP11qC7r5ffqxQu4rQOhkQ5ol?=
 =?us-ascii?Q?Kh2uRzQBWPYv9LzC5gwJ+a5nfFcL50kLvV7X9lFUrTTW76BAghyVGYwJbkpi?=
 =?us-ascii?Q?pV+UbicJGJDkdar4boYNKHzeZMAkeHxhqPBkF5sT3ngWZrG9Wt56riSNUZE5?=
 =?us-ascii?Q?q542cHnaL0G59/LpE9pXUVXN3Hd6bZcR0bkizA4AqNsso1ps43wLpp84L/Gy?=
 =?us-ascii?Q?0B59nrsKnIKUwlwAQ4YNAs/Nm2rCVGDbWx/8e797rtfCcSHd6DawtRL5JWph?=
 =?us-ascii?Q?Vu7paU6IzI6pOqUGzUeYS8OG3OG57DzTXQmRFVjiRgEai4usHIMXcPtKbY3H?=
 =?us-ascii?Q?IznP5492i4QqjQk3qCAsoxgzkq+aW55jiWlUVP456Fxywz/emtizTqw6DdSI?=
 =?us-ascii?Q?ywq5w3cWdHYsmW60yMOQ6H+Png6qXmPasUHzrNTpv3B5xb/8ZXO1ZVG9qWXi?=
 =?us-ascii?Q?49BM9FuOAQkb/ulaejYKF+/vcZEpvOzKJO5dykzE+ctTE4VhbW6sZQlvVFmG?=
 =?us-ascii?Q?xfdp+A37HLfqRFVf9osOG3JU9Nq0XZsVCfySgCiL2CRf6GAaXq4937xM6P/V?=
 =?us-ascii?Q?U6OABfj07IyOvwg9XXQ/LuPk6+O0/Mul6nkdXaLnSdv7MKJwn+1fZsK2QwWN?=
 =?us-ascii?Q?nIK5bRsqT1RG5/QgYW4lUa04buCeA2dISGn85CtEPR1lqGPz1lQQ4mG0/JeN?=
 =?us-ascii?Q?sxSEDbetG3UyRHEzc2Bck1AJ3VYQ/cv0aCNcY3dwN3F/B/X63mIkMRkjyCpY?=
 =?us-ascii?Q?GJ2sVk78o8/JBCFtQ6V56BYlDnc2spQ/02nJq3RWbqLNz1tpVNP5cr6vqPT9?=
 =?us-ascii?Q?ycUIuq2Rfldtt9AwBaXb6GstWC0YTysgdVtF2cEdChmLy66iIjuTYBx8jh3G?=
 =?us-ascii?Q?GKJLFjPl2reebcXRvkOXhzplvtmPhTalbuo1CwJyix/2SOqV2x5PGWG5iY3p?=
 =?us-ascii?Q?wdmSBhgZF/EhupnlxWqYwa1gLIrtyRuzXbfTcTYuld/8SdA1VXzpZ6Dy73NJ?=
 =?us-ascii?Q?KUEd/5dAPZ1dZ/6tocyYvX6oOs7nkOWjdilTe0Kyptzk09tG3xx9YglOd3+3?=
 =?us-ascii?Q?zdyps2sMAI/zOdyypQl6Jgr4/Jbw9UsGbBQbgU4Y5T1fEDpso6rIt2Ghm5Hd?=
 =?us-ascii?Q?kkhVnHenjc2tGB33v8MMZr5sUScVmp0Xsdugh243bP86mD2rJ6BT40ZbeNxQ?=
 =?us-ascii?Q?SsIozs3Qa5ey1XO1oZHdFZ6XP6cvacg46Fj1q2SEFroTkJyQHKGapWM4gJPb?=
 =?us-ascii?Q?8BMc/uifgPPt8RLitDORdKmwEZoTBsll/QXm7hPJowjmfNGIWryanBtEGiYJ?=
 =?us-ascii?Q?UQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a0d127-073a-44e3-261d-08dac9b30915
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 22:20:01.7712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hGLO1dFyzJIqqG7Cc7TrkEZboMoRZKDL6F4BNFI2C7NN0Qx0wJwHpzekOqjcAMu06pponoKiM9YHR5TJzC96qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7625

On Fri, Nov 18, 2022 at 01:42:48PM -0800, Mat Martineau wrote:
> On Wed, 16 Nov 2022, Geliang Tang wrote:
> 
> > v20:
> > - rebased on "Squash to "mptcp: refactor push_pending logic" v19"
> > 
> > v19:
> > - patch 1, use 'continue' instead of 'goto again'.
> > 
> > v18:
> > - some cleanups
> > - update commit logs.
> > 
> > v17:
> > - address to Mat's comments in v16
> > - rebase to export/20221108T055508.
> > 
> > v16:
> > - keep last_snd and snd_burst in struct mptcp_sock.
> 
> I didn't notice this back in v16 - why has last_snd returned? At the end of
> the series, it still doesn't appear to do anything. Is it useful for some
> future feature?

last_snd is now used for BPF round-robin packet scheduler in
"selftests/bpf: Add bpf_rr scheduler".

Thanks,
-Geliang

> 
> - Mat
> 
> > - drop "mptcp: register default scheduler".
> > - drop "mptcp: add scheduler wrappers", move it into "mptcp: use
> > get_send wrapper" and "mptcp: use get_retrans wrapper".
> > - depends on 'v2, Revert "mptcp: add get_subflow wrappers" - fix
> > divide error in mptcp_subflow_get_send'
> > 
> > v15:
> > 1: "refactor push pending" v10
> > 2-11: "register default scheduler" v3
> >  - move last_snd and snd_burst into struct mptcp_sched_ops
> > 12-19: "BPF redundant scheduler" v15
> >  - split "use get_send wrapper" into two patches
> > - rebase to export/20221021T061837.
> > 
> > v14:
> > - add "mptcp: refactor push_pending logic" v10 as patch 1
> > - drop update_first_pending in patch 4
> > - drop update_already_sent in patch 5
> > 
> > v13:
> > - deponds on "refactor push pending" v9.
> > - Simply 'goto out' after invoking mptcp_subflow_delegate in patch 1.
> > - All selftests (mptcp_connect.sh, mptcp_join.sh and simult_flows.sh) passed.
> > 
> > v12:
> > - fix WARN_ON_ONCE(reuse_skb) and WARN_ON_ONCE(!msk->recovery) errors
> >   in kernel logs.
> > 
> > v11:
> > - address to Mat's comments in v10.
> > - rebase to export/20220908T063452
> > 
> > v10:
> > - send multiple dfrags in __mptcp_push_pending().
> > 
> > v9:
> > - drop the extra *err paramenter of mptcp_sched_get_send() as Florian
> >   suggested.
> > 
> > v8:
> > - update __mptcp_push_pending(), send the same data on each subflow.
> > - update __mptcp_retrans, track the max sent data.
> > = add a new patch.
> > 
> > v7:
> > - drop redundant flag in v6
> > - drop __mptcp_subflows_push_pending in v6
> > - update redundant subflows support in __mptcp_push_pending
> > - update redundant subflows support in __mptcp_retrans
> > 
> > v6:
> > - Add redundant flag for struct mptcp_sched_ops.
> > - add a dedicated function __mptcp_subflows_push_pending() to deal with
> >   redundat subflows push pending.
> > 
> > v5:
> > - address to Paolo's comment, keep the optimization to
> > mptcp_subflow_get_send() for the non eBPF case.
> > - merge mptcp_sched_get_send() and __mptcp_sched_get_send() in v4 into one.
> > - depends on "cleanups for bpf sched selftests".
> > 
> > v4:
> > - small cleanups in patch 1, 2.
> > - add TODO in patch 3.
> > - rebase patch 5 on 'cleanups for bpf sched selftests'.
> > 
> > v3:
> > - use new API.
> > - fix the link failure tests issue mentioned in ("https://patchwork.kernel.org/project/mptcp/cover/cover.1653033459.git.geliang.tang@suse.com/").
> > 
> > v2:
> > - add MPTCP_SUBFLOWS_MAX limit to avoid infinite loops when the
> >   scheduler always sets call_again to true.
> > - track the largest copied amount.
> > - deal with __mptcp_subflow_push_pending() and the retransmit loop.
> > - depends on "BPF round-robin scheduler" v14.
> > 
> > v1:
> > 
> > Implements the redundant BPF MPTCP scheduler, which sends all packets
> > redundantly on all available subflows.
> > 
> > Geliang Tang (7):
> >  mptcp: add scheduler wrappers
> >  mptcp: use get_send wrapper
> >  mptcp: use get_retrans wrapper
> >  mptcp: delay updating first_pending
> >  mptcp: delay updating already_sent
> >  selftests/bpf: Add bpf_red scheduler
> >  selftests/bpf: Add bpf_red test
> > 
> > net/mptcp/protocol.c                          | 242 ++++++++++++------
> > net/mptcp/protocol.h                          |  18 +-
> > net/mptcp/sched.c                             |  67 +++++
> > .../testing/selftests/bpf/prog_tests/mptcp.c  |  34 +++
> > .../selftests/bpf/progs/mptcp_bpf_red.c       |  45 ++++
> > 5 files changed, 320 insertions(+), 86 deletions(-)
> > create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c
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
