Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96BF9CA49
	for <mptcp@lists.linux.dev>; Sun,  8 Oct 2023 12:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RC1UJqtJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsxWFmWSXzXTbz6KQDqroQ8a4SImp4uqoWFQNnwu4oiUT4lJb8cY0iHoqQyt2FtdaITIPtTE106PhoFHhtIGAcvPxnLIJYNPnyKQfsFRMIntAaXcA05O/6nb/z6kiscqJJSQ0ZenzyV+RjhEedQ5zQL+IEJwQiIC09CYsqpEOovFVhfI7jtxfQXERoFwsOUKkfAzAxbSheU/hr4OWMjepbvFRFkiEEJK1j2PAHvXvuU1oGS/FX0G+9suL90Z88G2gc1MsE0H3nxwZMrZ0iPahfTCZCKPlge83AYZEnQeeEGsYInI1q6eS3HV8alQhG8n+70aDMqZXQoOkGNEkn1Gmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZG5waajWHSjIN7C5JRA4aEyXengNXduE1zrxzJM4GQQ=;
 b=CCYxhb5XjffRSxi9NQYEBZxxjd+/dT6eHv9SToNyGmbOeT4FYHeCYedIn/oQr1XJf8S49OrrfQqPEgy4205SqeyOYzPS90TdjlNFaLfEnOeFcSs68tlFDl0Ald1T3mH4SisDZCwX3arDDUiX9VxOxeieVb3q2MqpMpcs7RkT5UxAX0AknpWbBQ7QnSJ43BFuzdXuMMjyvWZwY98WMeENtzCc2ACrv9vaiFWxE02yUz99m2AxUS55ZZ5ZdxfrQAlmrakY383pe+55ducPKFJEgM+pJgK3jf4tMn2LX7DMtj+7lVtu+mkgq6nBcQnilaCEutcU3UnRuJjElzd7pXRqiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZG5waajWHSjIN7C5JRA4aEyXengNXduE1zrxzJM4GQQ=;
 b=RC1UJqtJK9iDrRASa2CXJQ6gQzXfvxWWkO7em1BX75/19fRMg8ru6oisPyuVYza1+FlSUna+UgE1XWuntfx3u7niZ431MRXsrEJu3MjtusbOh/m90xR6eh2AT9eI8ND4QHSSa9X3CAqP999n4dLX29chz2h03SsuNqLHOqLDkomiA0Vu8bzN3TgjLjmPHCzev9jilOBPlSk5XZ4HiOKI1a46DolM3dCWqn05zzEPhJQ63dL44E4cx6eqylH+UIpro36jdrwei1jJNZkekeq7xleUpmqz9mtWlKLbcKx3MR/58lJRgOXc2d5jBte0CXpdJl4Ae20fhcdt0jRr35tvLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9914.eurprd04.prod.outlook.com (2603:10a6:10:4c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sun, 8 Oct
 2023 12:32:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6838.030; Sun, 8 Oct 2023
 12:32:00 +0000
Date: Sun, 8 Oct 2023 20:33:13 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matttbe@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v11 1/4] mptcp: set next subflow to msk->first
Message-ID: <20231008123313.GA8315@localhost>
References: <cover.1696760702.git.geliang.tang@suse.com>
 <6a31565e01d3474be56bdf62c54d0c20c065c65c.1696760702.git.geliang.tang@suse.com>
 <6c266459-dbba-4bda-b868-b5bcdaf351b0@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c266459-dbba-4bda-b868-b5bcdaf351b0@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SL2P216CA0162.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9914:EE_
X-MS-Office365-Filtering-Correlation-Id: 36cb287e-e863-4be1-42bc-08dbc7fa90db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z1c4K+CLbqwYa2TVIR/TE2V6gSWQalUf5uFImwjqDBz9dQPLEG5zWdJB2TKAIgYlfQOcWwc8sz2xju+dU+gNLFCP+b73fPKlEJjhJGHElp2Z/rrbx0oVVqIIzAXn/fqw1A4il+dhUD2yCNjx5QSUALrhNtOi2KeTEijIs6VAGlmwXmaIVbWQy7lv1epp+xVrdnCnC6zDDa+f2dvGxIzWRgmRwSNUGa2a/vX+9T8A9XJTGqUjD0dYTXx+9U3eHyiU5As9DZvdcZCtc7KziBEBFLNMlYgXoHJkzR+WvTeVCQJoYal8KbzpWVFsMkuTa8EemgnrmyIMw+SeDagLKXOsUqCucQNhPKSek4+T/JHB9Z3SaMn0Ge4o+H+MvAw5WaEiBrS1D4LmXyO//kFkvVf90tMSyHuQDjNBezC/+8PHLUO0BStaEOK0O1b0dLOAkp87qFA+EhU6ZLdQeAUJ07eX+YyAxpPyKbJP2HTI0SKgjmqN2+DPTLs+5l3Y03BeOoAsazoWrjizJGpwZQ84C+aE8rqtXMF0PPu/+e8SNzOCTwJ/me/IXAVt1Mfku3vgFWrqxn39h1xJz7fdown+0R+ts/26W2V+dAu0z58Ss2E4HTA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(53546011)(1076003)(26005)(8676002)(478600001)(6666004)(6512007)(6506007)(83380400001)(2906002)(4326008)(33716001)(66476007)(110136005)(66556008)(66946007)(5660300002)(6486002)(41300700001)(44832011)(316002)(8936002)(38100700002)(86362001)(33656002)(15974865002)(9686003)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x4ratB6FaH6QNxGZmPrNkdnPWz+zf9n8nbV2YHyVNQTVjd/dmM2VIfy/5Njy?=
 =?us-ascii?Q?+rY+qvxibDq3rH14pWKr7B6haT/D8QK9YwpXlIJFocU2Wlh4lUrBxTTMGAnt?=
 =?us-ascii?Q?yJ1ZoOnuG4rtw2P70GmpA1y3z1qY9wIh6d6xqbAn85kOl5Cs+IWKjVrtYg+c?=
 =?us-ascii?Q?XW40PkJYNfFlbp2x/XNHCdVCV52EAbGheSaYytijxoDANmHu2QhaJh07mE6/?=
 =?us-ascii?Q?0pcNxyWsnac/yaCiSGElspAJq4wSretQFc2k9mKeueUp8DlSln+b7Munb3Td?=
 =?us-ascii?Q?0ok2qCLL6uO8q2G8yfc80InuNPTg8dHRsUMCqmwCyyvJyArXvsnoRrZbTizL?=
 =?us-ascii?Q?CuFgFeasdxuqKRDDxmdwKQRL8Ev4632BAzB1iKeMSW9DTjnYJFs1Rw+Wam8h?=
 =?us-ascii?Q?yafGxMXDMF0jrydXpz/BmbWWjLVmo/LGhLxZsrLH2sfR+V1+BiHw+VNg/Pne?=
 =?us-ascii?Q?hDeGx//xRec58w2zA1Km/DM/L5HweaUO6PrVPw1m8ig3HEBhVvQEt8CoHfjt?=
 =?us-ascii?Q?5015CdXl1XXFVF+an1QcCuem4nmX+UIC8G7ov7JpJo54hzj+baYFGasOjJFl?=
 =?us-ascii?Q?U4bhfYPJI6j2pQ1R5EQvhBCJu7QuVTNkF3cm4O0FxNPfjyVxkcCKY28GRfq9?=
 =?us-ascii?Q?xDakvZLFfi5pHDsSOIoEbfbRMdw9VxEo35NUi2+VlaOFiOmNu7PPV2MjGioo?=
 =?us-ascii?Q?GMyLyRnvoGF9OEaWytQbcDYod0Lbm78jrr9UctvRgB7kHhMd9J8hE6CJVYh4?=
 =?us-ascii?Q?AR9epAicmlNNKSWre/J2rs65Xo4mwjqH2Y7w4RhhO59elZwVX+L+PMyNWuOV?=
 =?us-ascii?Q?wyrsqKgLp2URDTmmzt2paM0H/ynYgSaU/1UDsixFdj8+6tlRxpODdOBfUuHJ?=
 =?us-ascii?Q?8FHluCsPVEGisxj0ufrxirjj1TDRf9UbLeS94RMKmLWcXiKS57yg5rAtC7KG?=
 =?us-ascii?Q?kZhTvd1Bo6xjXv1QTx+BfBsUyqBtUMldRKrb2bykdR+7Aoa0JaeaAj994BEN?=
 =?us-ascii?Q?+nGLf57Jo7+aOajfzwyJM+77yINMDddtQMBLBuOW+SQZ/yCCfBItcieobAQP?=
 =?us-ascii?Q?RFEBC2OOpjLMTIzsZc+C5T5hW0MPr5rOjqWjfbyTdDkExiYPhBmZb9yRKrf6?=
 =?us-ascii?Q?4NgNwhZTvJtz/AZxUNGSVJ4CXwAzB4ukHivYxLh6BCeNw2f/X1g+A192X4Bk?=
 =?us-ascii?Q?HXYCFrImvaH2WIXdkIaPqk/7MtpwbkL5vvsLXoc1/2NRI9gkGXebL4c1yq0n?=
 =?us-ascii?Q?jIuxHrrBPk4NT6USL7Qd4Qdi4g7E63lSdkQFyXHjDBbHRseQ3c6vMG/j1RI+?=
 =?us-ascii?Q?V+Cq7E8J0Me06RWNuOvV7eKoyg0d2C2ICcNPSbJ7agvzWJW2cmTqcAc/22kb?=
 =?us-ascii?Q?H/kMBAvMEHpJIhrpkM9sgga4liQPN1fztxU/gMcYmEftEmLOkACMVKMwZQGg?=
 =?us-ascii?Q?XB0IKSRFsDO1UtC6UqBsTtfQGjxtMWp3F9kGNVlvefFRUMOl5LxuuMVFzcI6?=
 =?us-ascii?Q?oRulUoywUyKQ1+aUreikDdktcz4vVY1sqEX4QxvtbRez90Y4X0E09RQh+2Za?=
 =?us-ascii?Q?GuZPor7tMmEKbLlgDVldopPFphZMhgQKhCjjxJPj?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36cb287e-e863-4be1-42bc-08dbc7fa90db
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 12:31:59.5423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LSkZbmwL1I2H0dJIQFDFXxG0lqyFipeHIOCgxKmqZnUeq0Rljo/GZW2BSbM0CBICSTBFCHNqd7gVnIHKj/orhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9914

On Sun, Oct 08, 2023 at 01:11:32PM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> +cc Paolo
> 
> On 08/10/2023 12:27, Geliang Tang wrote:
> > When closing the msk->first socket in __mptcp_close_ssk(), the original
> > behaviour is to reset this socket. But if there's another subflow available
> > in this case, it's better to set the first available subflow to msk->first,
> > instead of resetting the msk->first.
> 
> I don't think we want to do that. If I remember well, we want to keep
> having 'msk->first' pointing to the initial subflow for various reasons
> (I don't remember exactly).
> 
> I think what we want to do is not to reset the initial subflow if there
> are other subflows still available and we don't want to set it to 'NULL'
> in such case.

Is it like this:

       if (ssk == msk->first && !msk->pm.subflows)
               WRITE_ONCE(msk->first, NULL);

This doesn't work, it will get a NULL pointer crash:

[  390.852957] MPTCP: msk=0000000089655116 snd_data_fin_enable=1 pending=0 snd_nxt=8683552930344602029 write_seq=8683552930344602029
[  390.852969] BUG: kernel NULL pointer dereference, address: 00000000000000a0
[  390.852973] MPTCP: msk=0000000089655116 state=7 flags=0
[  390.852980] #PF: supervisor read access in kernel mode
[  390.852989] #PF: error_code(0x0000) - not-present page
[  390.852990] MPTCP: msk=0000000089655116 rx queue empty=1:1 copied=0
[  390.852998] PGD 0 P4D 0
[  390.853010] Oops: 0000 [#3] PREEMPT SMP NOPTI
[  390.853020] CPU: 6 PID: 796 Comm: kworker/6:3 Tainted: G      D            6.6.0-rc4-mptcp+ #19
[  390.853030] Hardware name: LENOVO 20UASA0901/20UASA0901, BIOS N2WET38W (1.28 ) 08/30/2022
[  390.853037] Workqueue: events mptcp_worker
[  390.853056] RIP: 0010:mptcp_worker+0x113/0x3e0
[  390.853070] Code: 83 28 fa ff ff a8 01 75 71 f0 48 0f ba 73 d8 02 0f 82 9c 01 00 00 4c 8b a3 80 00 00 00 4d 85 e4 74 18 49 8b 84 24 c0 04 00 00 <48> 8b 80 a0 00 00 00 48 85 c0 0f 85 9f 00 00 00 48 89 ef e8 b5 f2
[  390.853079] RSP: 0018:ffffc90000527e38 EFLAGS: 00010286
[  390.853087] RAX: 0000000000000000 RBX: ffff88815c26e0f8 RCX: 0000000000000000
[  390.853094] RDX: 0000000100016275 RSI: 0000000000000246 RDI: ffff888108c70000
[  390.853100] RBP: ffff88815c26dac0 R08: 0000000000000800 R09: 0000000000000400
[  390.853106] R10: ffff88846d700000 R11: ffffffffb026f448 R12: ffff888106f5a000
[  390.853111] R13: ffff888100099c05 R14: ffff88815c26e100 R15: ffff888103fd36c0
[  390.853117] FS:  0000000000000000(0000) GS:ffff88846d700000(0000) knlGS:0000000000000000
[  390.853125] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  390.853131] CR2: 00000000000000a0 CR3: 00000001a21fc002 CR4: 00000000003706e0
[  390.853138] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  390.853144] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  390.853149] Call Trace:
[  390.853155]  <TASK>
[  390.853164]  ? __die_body+0x1e/0x60
[  390.853177]  ? page_fault_oops+0x15b/0x470
[  390.853189]  ? pollwake+0x78/0xa0
[  390.853203]  ? __pfx_default_wake_function+0x10/0x10
[  390.853215]  ? exc_page_fault+0x71/0x160
[  390.853226]  ? asm_exc_page_fault+0x26/0x30
[  390.853240]  ? mptcp_worker+0x113/0x3e0
[  390.853253]  ? mptcp_worker+0xc8/0x3e0
[  390.853265]  ? __schedule+0x352/0xc20
[  390.853279]  process_scheduled_works+0x22b/0x360
[  390.853298]  worker_thread+0x147/0x2b0
[  390.853315]  ? __pfx_worker_thread+0x10/0x10
[  390.853331]  kthread+0xe5/0x120
[  390.853346]  ? __pfx_kthread+0x10/0x10
[  390.853362]  ret_from_fork+0x31/0x40
[  390.853372] MPTCP: msk=00000000c3583a71 state=11 flags=0
[  390.853375]  ? __pfx_kthread+0x10/0x10
[  390.853388]  ret_from_fork_asm+0x1b/0x30
[  390.853412]  </TASK>

Now ssk (msk->first) has been released, we must update msk->first.

Thanks,
-Geliang

> 
> Could it be possible to do that instead you think?
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
