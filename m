Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130075.outbound.protection.outlook.com [40.107.13.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314EA621
	for <mptcp@lists.linux.dev>; Tue, 26 Jul 2022 03:32:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPypop57K4PmeM5iF65zABBclVnR8AHHxCGuGqPbbLRWP2jiYNrJ++ZdEuID5vo5VEtmbNpA2G0k7tqks4PKZMj4OaZgPqMUuNyVClkJsXn8ssHT5R+1cqIV4ud5DDmVXQf4r6M6mx711wsrdxWlgfJvXQfIJBySpMzmrztQeGu3pgXRjlXLMcbSC3MZLEf0nlV5BvYh96zJ5deYrjJhuJcmbE+smPlkN6jDdZr1LD5Hdzm1fQyEa0GvUcA5FBaqdff+BJ1158GHO4QkT0FsFWieT9esXJ28sJvrhFM6JvnoucLMmLqWQRdkTqZZ9LBDW0snc6BfcwYHeqZS0iUWdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRHzWSlgFivUjZ6MjmVtRuvWs0nZxF43vBqDdUTgM1Y=;
 b=ZXg43ujFoh0wpFqNE13m+l1Sbv2MIP/tiuDZz20raZ7guv4bFwQU0eU40w/KGa6R98FUANzxjM6eHgiNM37XOEhK2Jd64T6fFFJShiyrRhrBb3E7ty++451QpTKTFUnRigPVvp3rAut1ntRPsW9eKrXzjiraB75X/oytXiCrXuoMqgNnY046UgI0HZKCQzKtJ8weA1gbL5/Jjdl+sUb6yvxptgiYWyJ/Vu4PLAx8njiys2cWc1bq//6bO+1W1b/s2XXxrFpQx2DIFt9BK1ZiuCJxoYZNrX1kPLeCWswU1g4YZAL44+HtUBwzdT4z3dr/ouvM4EfkdN0F4ZVdcmtfbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRHzWSlgFivUjZ6MjmVtRuvWs0nZxF43vBqDdUTgM1Y=;
 b=Tf7Bvo+8bOp0jVq0peRMYcTHFjjyMLQcSb4cJBcsKj5ijA/3ODQkAQDfmBPxYtHmI9K0/nqyciKJlq25wGAroL5ecfrw8PY21RbkdEftpz9q61yKxPDFIZGsmEL33axGOMHTLMK+UZvyYhzv85P7/NB3ixah07K5zxCzC0ZnkQix9DT11PdQhmWs3bgHcsHZZ6EhdRqgvVrfzoBGd/GaFfLWGUPbSH/VY/AxncpC92LqrKfdCCyFgs9c/R4hEbtC8NbDS0dLdoHGwUU7XAzZl1KAvsGWJm6Gs7+fO3EWeYR7Ir2XPnPey5FxxqP/56aJH6mNZ4VIBMi5+CY0s7/NPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7585.eurprd04.prod.outlook.com (2603:10a6:20b:280::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Tue, 26 Jul
 2022 03:32:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e50b:e0b:7b9c:a79e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e50b:e0b:7b9c:a79e%7]) with mapi id 15.20.5458.024; Tue, 26 Jul 2022
 03:32:47 +0000
Date: Tue, 26 Jul 2022 11:33:16 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v7 06/13] bpf: Add bpf_mptcp_sched_kfunc_set
Message-ID: <20220726033316.GA2520@localhost.localdomain>
References: <cover.1654143895.git.geliang.tang@suse.com>
 <d246b0ca7372421c3bf31cffdf4151b2b6cc5dcc.1654143895.git.geliang.tang@suse.com>
 <20afdb4f-2aaf-5a2f-4472-e4dc35b2f8ad@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20afdb4f-2aaf-5a2f-4472-e4dc35b2f8ad@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SGBP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::27)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d36e3799-cb51-4bcd-037a-08da6eb78288
X-MS-TrafficTypeDiagnostic: AM9PR04MB7585:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gkdZqX20SD32n/ck61Q9SUvz9GpnREv9FLZSBU4h8O1AaiNMv6K+JjPNdggkKmg533KikW9HMEzScvn6woppekXkOT6wffWOo2WZYZNadcZzC/QhIS8mfhRYWnfDx/v6C0SsR9NCGuUKKIGIPRMxCQZIilrOGZbU1Ru7CXnsY8qFiB54vWu607O5nYuv4daBhr4+2OUb+DjCKbozST8ya9bMvJOQdmRrqh/608z+rkzUdVruCxHQkQSwS9582K2dxwciota/gCuuG1mRoNBdniaIISSJd246luMQ8A6DUNYfSdJ8a+tGQ5tnRFiQb3qsFjdPRQQiFWUZEsrT4sZiQIfkivCWCqcxuirhGPL+5Ud426WRMoy9ysOJ2zPMOSaSnaTaGTxHDI+rLTM99NhIxAUDAkBpBqKEFJHkBJbTsmRH2oqrMKMtwYeBUxiKBxRK2EEirnzuCVQiehu1iEwEqtOAM0avrxx7sFayCb6x4vTxQ3szikb9x/xO3dL0h4eOHFCYZCJohQS6cLxcvFludfGVK8+qr0g8STVX4TQgi/V2tQcfszoWi8dO5UphRn1UWr6po5bSmRl6O0R8U8ZqJsn7xt/HN5e/JNRk4qAtGEHCWk8FORINPo4jvNwgzQZ2ffZawASp4cGdVkytqmRrtKsUynFx3O/L2egp5hdmJbul4i5VlN58r2yyDE6eylzG3OYfMR/5cO4dSOAt8OGg5OoHm3Fb6mG/cR0jIJFyqPfYC2HIluXIPRax8JOjS/AKaDSxohZONkDXggu9rbUQrtzeuem97HcTivVdtCNxYol7wfUUUiqK16HaUUmD4jfsuKjIPxDXipyVSVLsMt+44w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(376002)(346002)(39860400002)(44832011)(6916009)(86362001)(53546011)(6506007)(2906002)(38100700002)(66556008)(8676002)(66476007)(66946007)(33656002)(41300700001)(6666004)(4326008)(316002)(6512007)(6486002)(9686003)(83380400001)(186003)(478600001)(26005)(8936002)(5660300002)(1076003)(15974865002)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Onf5EETSANm7bWj0wQi4hPK8aAKYdCEk4kd59vokusOCGj3p3fdZDHo08DF7?=
 =?us-ascii?Q?kaNpplDYBc1oZXps0ZHb8XguckI7ez9NKSkfijXIfV4zE3nMC14oItt16WnO?=
 =?us-ascii?Q?ioPeZ3s8+nQAEm7tzYS8h+aQzngQ31k0W/myvl8gZ8Yroa0M+9DYettaSOMU?=
 =?us-ascii?Q?m5eXLynaWac37P2zfZRTKqgBcIv98JlLXd8+HaLY6NH7O8/L7f5RLcgmzFQG?=
 =?us-ascii?Q?m0PNQN4qJJ9sw1ZsmFNjoAkyKGuoycq/1HtHA6U69ITYm/kZoEAN/OQ4/V9B?=
 =?us-ascii?Q?o9wD4PCifZGDE8BnyXunYuk1miIjY2BCryJikd/ZTlghW++qheTJ7pJYWman?=
 =?us-ascii?Q?Vi+vdf1xHcjlojmBHce/WSjuzZOhv2dJjYBSIr9uw1vsbe3gnyDFpr0DIfKz?=
 =?us-ascii?Q?gtR73yII0gmBiEg3tlavtbk+mQFuR+rJrfdsKi+tPkn4pE2VuVWh44a3pmv4?=
 =?us-ascii?Q?cvNBEfuvkPmjqh+/8vrrz0ZH8UflwWh6oLqWC+4m/S1yvlxvsZZIJgGXQeWl?=
 =?us-ascii?Q?bET9S6CxHac4dJJ5b9sXLk1/kJ6aeXFFELm5DTtigqINdfrQO2QxKYZ9hTvn?=
 =?us-ascii?Q?bBX+EHbu8pHPDXs7lwZTrvRZNYz6TvxEvXYChhBUjpALzLnDrxU50sOaprz0?=
 =?us-ascii?Q?39444QCcDGt9DXgnZWrwvdXRAhp8DthSzAoNj+ydINIe29UjFGdRyVEtkcfa?=
 =?us-ascii?Q?NUqLGpzzyLtbfVesbK5XOEjXj4DmLK3vX07bIstZpXWR+L22FUFlpfpHF9Qa?=
 =?us-ascii?Q?v6zzR5Z4Kx0r+tFAzPzMbGcSVyoms0HkQiED0LrAeTMmaJjmOucDmik9l9Zv?=
 =?us-ascii?Q?LNeVxuwPtNQ8y1rRi0x+n9XHKAl9IF0Mz1B9hEDu3nrv81XvmVRZQ6ZOXRKJ?=
 =?us-ascii?Q?vzygz2BZCUlWxA2RX1/uwfuKYl1A21eZv9xirFI81ny+JpUMZOng96tWEcR6?=
 =?us-ascii?Q?LHe2cF/4kHGioUyd7PC0wuX0qxBsau7k8sY/SK9ajkqvJAi8PAgu5tYzeaWJ?=
 =?us-ascii?Q?aBxJ9uAf6PIYlk+IiZrkCOzr74Anf528viRdWlgyvEC5bkTy9a4nfDpwe3t0?=
 =?us-ascii?Q?vM7qCdYZHtM62wSNRd7mtvU5X5++ofW+CVXFVhSUR0Xss31WMpNAvcNoFZtS?=
 =?us-ascii?Q?b/qCfXcEjrmqAZx+0bOaPLfGDwS11u/P3rWF0xP25KuwOGWmh2NrEjgPdlbp?=
 =?us-ascii?Q?dz5fnyMSs77umddXrNCn2XFP/hIrZBBN2Mwk2WsYf4w1uLTUdUdK2kDsEabj?=
 =?us-ascii?Q?YvTZEfOVs1OT9B2Lk2QS5I0cy8uQNn0UYUkeE6wRHXiIfAIUtTrAhTN1MRj6?=
 =?us-ascii?Q?Qvvmdjz7V78AW9fe6i8cVyzdfL5pyLXZ/OChVC4C4Lll0pCAc81OFdYgT3f+?=
 =?us-ascii?Q?c7foScZO6pQ0Kce8xXOnIj2UUw2hhzwYJIrDMXsyQ4vkThUeRoR5U/3Ms47o?=
 =?us-ascii?Q?0B9asXcqkst6IW8NFpm3UrE8iBYZptfRd9UYi2ZIjjz7xHAiyLS1Rhj/D/OO?=
 =?us-ascii?Q?6c1Mz9X0ZCIhsyUsyf6AdXG5GQ9cAflfCYEtXU4hb7zWd9m9/Qs59a+mmV5a?=
 =?us-ascii?Q?y4ILJEw4uS6kAsSUhHWz0HwTMcPq1i5w3I1rm80E?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d36e3799-cb51-4bcd-037a-08da6eb78288
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 03:32:47.6243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1AfMfFgMDg4POP/BaFaoF9XR99wTg+S6X4O0yc0i4SGi+elGYIl2wYngUPtnmDawhalKHOHJ+oFNHJT76RxHTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7585

On Mon, Jul 25, 2022 at 09:56:10AM +0200, Matthieu Baerts wrote:
> Hi Geliang, Mat,
> 
> On 02/06/2022 06:53, Geliang Tang wrote:
> > This patch adds a new struct btf_kfunc_id_set for MPTCP scheduler. Add
> > mptcp_subflow_set_scheduled() helper into this id_set, and register it
> > in bpf_mptcp_sched_kfunc_init() to make sure this helper can be accessed
> > from the BPF context.
> > 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> >  net/mptcp/bpf.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> > index 0529e70d53b1..e86dff4272d5 100644
> > --- a/net/mptcp/bpf.c
> > +++ b/net/mptcp/bpf.c
> > @@ -161,6 +161,22 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
> >  	.init		= bpf_mptcp_sched_init,
> >  	.name		= "mptcp_sched_ops",
> >  };
> > +
> > +BTF_SET_START(bpf_mptcp_sched_kfunc_ids)
> > +BTF_ID(func, mptcp_subflow_set_scheduled)
> > +BTF_SET_END(bpf_mptcp_sched_kfunc_ids)
> > +
> > +static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
> > +	.owner		= THIS_MODULE,
> > +	.check_set	= &bpf_mptcp_sched_kfunc_ids,
> 
> FYI, I had to change this commit in our tree, see 556f2a5949dd ("mptcp:
> bpf: fix compilation error").
> 
> In short, I had to adapt the code due to modification on BPF side,
> related to commit a4703e318432 ("bpf: Switch to new kfunc flags
> infrastructure"). I hope I did the proper modification.

Thanks for this modification, Matt, it looks good to me.

-Geliang

> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
