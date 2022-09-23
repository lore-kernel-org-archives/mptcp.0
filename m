Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2051.outbound.protection.outlook.com [40.107.104.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C4D15A3
	for <mptcp@lists.linux.dev>; Fri, 23 Sep 2022 03:24:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HToFhY6GFqrAbFH0RdrpXqKhCb6titaDPulohMQNnfcOouGifAITsOGvByVbKJg1H9JFaZuNGVzCGSdPoHsZhf0yQGP+Y+6qV/E37zGjl/Yn2E0Enk+JJ5PzV2+ioNhgrY49S/A0n6M3NEO/oIz83/7YiYcfFNrEo52rk2JQj2mvQsXbHrr/y1cU9Pf8Ro+tRC+6CGpye1Vee8eAg0nT6+wbIVZYFwnUcineG608ISqj9FYVkEtYDzqQky3Q34ImXEa4SM9MT+R4b75p9wnHCaTmtTWvrAErNdArkDppB+CeYXE0PorwBGiSTLYvZKDj6XyHOvvesbYrmA28rnBz9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJt9aphIjydZ8x5OdKBcKQNba8u1r2Pk2tF9JuZ2qhg=;
 b=O9OadcS4X+72Sn7eEVlStzQMMoAJCvVHj3k9bIyl4Ch05ibkzDWa/BalZnINKwSjcD2PiNhrGbDqN+yYDY6hY/xC/N1xe+rBC+RiG9ZU5fdm6FD5Zfgz/BLdyQ7xqtgx5tZ4CExBng4LOFHueGxRUoCOrdSGXXiga5TDsFEMJ0/qM8T0FKtnTh7LGUJImMXlfwptDPtSoVoqkJ6ScL+FMdI6zb4NDPPwXJYIrky1RPr5UQxVN3+m5M+FvMrgSwWFG6jx3nac+vLjAxmWmttLitNhBnqJLyBuEgX1eY13t7EBK6ntgfhm6FNwpS5kDQ/RHG4+WnDAUMC1xYxKMXVIYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJt9aphIjydZ8x5OdKBcKQNba8u1r2Pk2tF9JuZ2qhg=;
 b=Iq9LBEy+/R+UWgff1NyK2AAIqI20p4pRibpbKDmuuR7Ynf2yRpEOnxIs2nszHQqzBqmuVls9qhSCLp2VOkne9LiFul0W7NO4apyUG8fRnI3/ijXht4UFQ8v0eW3jD5AVPMXp2IGm2eBHMXGq02bgs7asyppg7SsWR5rfAmxrPdQNZQewdtPERJvgjwPSIHCRj3z21ocL6Ntdi09/lmhfXBvPQzrPK18qTscdqfPIhFePhnYag/o3otxe+0ycXePlXKB3aHpjFNN0WnCXWdZkszKrzQCoKAxOmlG697Zc3MoYjTgq9Qv03SeeL0x9WefPzUvS7IvhQTh3URmrpS7ntQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6834.eurprd04.prod.outlook.com (2603:10a6:208:17e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Fri, 23 Sep
 2022 03:24:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5654.019; Fri, 23 Sep 2022
 03:24:52 +0000
Date: Fri, 23 Sep 2022 11:25:27 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v11 0/5] BPF redundant scheduler
Message-ID: <20220923032527.GA3913@localhost.localdomain>
References: <cover.1662714028.git.geliang.tang@suse.com>
 <a3095b2a-d4ae-d617-cc4a-16fe55cdab9b@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3095b2a-d4ae-d617-cc4a-16fe55cdab9b@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fb2cf20-eac9-408c-e5e5-08da9d132db5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ewmOoO4MBALj7Tj5WPTmBwJWhqqUp9IGSCIULbj9/rGmiZrvUrO9WqEUnKrY94jTQpUpxp99n1TxEtSNKrNjz58BfRhe+3XYwn3Jl9JGWDxY6Fa7+OavQzJe4sE9dqlira1uBy2TwPXPnoOhHaytQJtZievAG0qELuoOF33T7+v7Ha7ANt4NixUOmdU1j3Y46xomTxYL4r7lXuf16iNbp7Q95t698jrv3nbawvUaHl+3bwvAVKX9OseWSjUPHoceqKDFBv/YelxQJHbDbEC/WTFbg+vv8dN+bxkbezQwxGs7TUZ/K6QmrynWQT51a89B8NaNyF5zjcOCDCECXLt+qEMDDXCnqJ2Lo2LKJXKCEcFYvB5JubkEOMMzgISd6EnWCJtGnhyqWg6zWJ+pRGlG5vLPF709ZF1h8QbtcV/goe2gSdn4nA1D/n4rbrGicbcAgcr+OEAhZV9kdOC3SCgaC+IktAERRmi6BwSi08OqdJ2AovcnZ9VWojQ2yqgIFeaWwuwrkKdBcaiidZd+VMg6PKcRa9YkRwn4PXeriwAeH7Bbcw0h1TJjG0fkEP7SbdgFO4UL2AsLBDAIszS4V+kZNhH1TerfPUSq2XVncUoHNDkORod93hylcWLeWlZYqvvfpt0dcg/Cp6N0KDlLgL6mSdzmkYITNozfVRrmos1fjacgFL27e13gshJxBHQ+7+707oRviKENciwKIYE/7KLQjw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199015)(30864003)(1076003)(45080400002)(186003)(38100700002)(41300700001)(2906002)(6486002)(6666004)(5660300002)(8676002)(8936002)(9686003)(44832011)(83380400001)(6512007)(316002)(4326008)(6916009)(26005)(6506007)(66476007)(66946007)(86362001)(33656002)(66556008)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZbE0l60FHXaba39w6O4apoVihQgJqZQbjbsJYcVeMfEpAMzfKKDwMMnjkyY4?=
 =?us-ascii?Q?Sk1C4u9d89LNmguT3BO7O43jeiNl1EhaEWn7JsRc/m8A0jycYeuZlFjYA4LE?=
 =?us-ascii?Q?8SesxfA8mQR04NS3EjpT/zUgcAQxwPTGbhqgdvUGIzffoIO2o0Wk+nd2rf+f?=
 =?us-ascii?Q?Eq/509y+fbe92LtJEE2lsKM66OEJbVT6r61LuYeam9mn4w9mDllXy++bvNJ2?=
 =?us-ascii?Q?i+zBRJV2tduWK+6VFunx4AOuqP8Ah2QRvyH7zCss9DgzL41Ga/jZzH4PEAOZ?=
 =?us-ascii?Q?JmLFwRugp5vROD58Lqq1OfMTYwEPMO/M3gJMc5Xw2q88xQyb4w0kbEN0rTV6?=
 =?us-ascii?Q?02pQunPhfcbTUhH8oqGgeHT6V3HCeaNMsz+guVUM37ItFAghp8bPl0mW0pjt?=
 =?us-ascii?Q?HZMfh1pthtWJ4CnrB5XP4/PYYQgLWZtHdxl+c+XEW+LfyrUaMFDo7eQYYbuR?=
 =?us-ascii?Q?5y6bDwjL4nMZrFdJQkZSbJLDiawvUV6Ww2gaKAru0w6avT0Z/y+gVtFamERB?=
 =?us-ascii?Q?2/9jjqdmw1scpjEEAryX/JP9nea2AY4880wPYDIUgG0ydTawzmTAE6oVBO8m?=
 =?us-ascii?Q?v7oRs04qjEpIqUfD72PPkEWz9NcX+/oShiEs/8vhHXKig0aa4BGAySao7zX6?=
 =?us-ascii?Q?Mhrx1dwdv0KCYiHX/nc7Qu9Q+3NBvXYt7jBXc62fLkU5aUgdRsh4SSfW3It3?=
 =?us-ascii?Q?Yy6Di0Q2F5SnzilFT2ABd+VrIc+HvVlMyeKbC/VBXx3VVODVlsnovTJ+7Pui?=
 =?us-ascii?Q?pJ+YjGU4v6b/mHgRTe+qZ4s6lqHCWJedAjMWfANjgLlfb++jO9An6XWsHOhV?=
 =?us-ascii?Q?vOcIKQKkuMbxqf5KApyiwyLTLNwf+7qpGNIN1n+9v8rlrHZSrcxi/SCDyDae?=
 =?us-ascii?Q?lge5kPH/mnlTJIREsqSvGFDAq1QTUiICAfykrnq/naYaLuh97gQF3wlYdHM5?=
 =?us-ascii?Q?YP4vMe+oODaMoLs3CA5omj1t31uzzT2hui3HYy9xboCux1d+nXvOV1ZAxPOB?=
 =?us-ascii?Q?AA/bfAWls9LG7jtSymykvWteYE8ew2FYGVDe5DxPXN3IL1JH08KwqvYqXgsL?=
 =?us-ascii?Q?W4tw+k21TKmnLPu/qkDa/ygWdpmqIGK16SVqdEhJhzgYlSQH01NDAB6azDOk?=
 =?us-ascii?Q?AZ6DscvuKJtXJSbKSXKHocrfOVImC261IYL3KVBDlhRqxLu3kTpaaUGEvFLz?=
 =?us-ascii?Q?fs7sYVpeNPowfBaiOeJpqmjuMKyyma4O1tkB0joRKSmcz3xSzuW33igRcu2A?=
 =?us-ascii?Q?V3aLG0LI7LEa3V5DXQGYIyYCk8uvTwRNKIY3Rwa++RNRsWMKotsRDN8LkLnw?=
 =?us-ascii?Q?3rdsMoHxWPSq491bEM6jDf6lu15ifjjZmHVJm1FNQ8NGNi672rpenvCv1q8h?=
 =?us-ascii?Q?uwn5+iVIOJbxaE0q70ZPmQjua+GWoXvd+PmGxcY41OLvmjv4rNqxjVjqvayZ?=
 =?us-ascii?Q?lK5K/gkZ38Awi4ibQvsqFfqzJc84Go6iZF6OdTgR0K64FlCcYwt+ymeZJTvI?=
 =?us-ascii?Q?xM8qPsJTc8NfQtfRchUF07pwKJMVlEQGNa2cJnih8g8XFs6k4tbMWKwxpJJh?=
 =?us-ascii?Q?g8J0CtJ6FQaaAGXM/9gC/pNsEpMVFXVDlVNSHFUJ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb2cf20-eac9-408c-e5e5-08da9d132db5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 03:24:52.6150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q095x7s4SeW/IXKZtQ1jMCwDZYmn76LrcG/3OEKXmfO5VUIN2AxonlTb6eJZevjqXSLQ/CiV6MmhNzgwcZwPxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6834

Hi Mat,

Sorry for the late reply.

On Mon, Sep 12, 2022 at 05:01:39PM -0700, Mat Martineau wrote:
> On Fri, 9 Sep 2022, Geliang Tang wrote:
> 
> > v11:
> > - address to Mat's comments in v10.
> > - rebase to export/20220908T063452
> > 
> 
> Hi Geliang -
> 
> Thanks for the updates to this series.
> 
> I get slightly different kernel splats than the CI. For example, here's my
> kmsg output with the first test in mptcp_connect.sh:
> 
> [ 3102.670021] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth2: link becomes ready
> [ 3102.885448] IPv6: ADDRCONF(NETDEV_CHANGE): ns2eth3: link becomes ready
> [ 3103.112575] IPv6: ADDRCONF(NETDEV_CHANGE): ns3eth4: link becomes ready
> [ 3103.463347] IPv6: ADDRCONF(NETDEV_CHANGE): ns2eth1: link becomes ready
> [ 3107.580236] ------------[ cut here ]------------
> [ 3107.581325] WARNING: CPU: 2 PID: 1112 at net/mptcp/protocol.c:1306
> mptcp_sendmsg_frag (/home/mjmartin/work/mptcp-nn/net/mptcp/protocol.c:1306
> (discriminator 1)) [ 3107.583192] Modules linked in:
> [ 3107.585317] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-1.fc36 04/01/2014
> [ 3107.587250] RIP: 0010:mptcp_sendmsg_frag
> (/home/mjmartin/work/mptcp-nn/net/mptcp/protocol.c:1306 (discriminator 1)) [
> 3107.588421] Code: 0f 85 21 fd ff ff 48 c7 c2 a0 c1 1a 83 be 78 00 00 00 48
> c7 c7 80 c7 1a 83 c6 05 9e 31 f2 01 01 e8 03 83 03 00 e9 fd fc ff ff <0f> 0b
> 0f b6 44 24 63 88 44 24 30 e9 dc f4 ff ff 8b 74 24 18 48 89
> All code
> ========
>    0:	0f 85 21 fd ff ff    	jne    0xfffffffffffffd27
>    6:	48 c7 c2 a0 c1 1a 83 	mov    $0xffffffff831ac1a0,%rdx
>    d:	be 78 00 00 00       	mov    $0x78,%esi
>   12:	48 c7 c7 80 c7 1a 83 	mov    $0xffffffff831ac780,%rdi
>   19:	c6 05 9e 31 f2 01 01 	movb   $0x1,0x1f2319e(%rip)        # 0x1f231be
>   20:	e8 03 83 03 00       	call   0x38328
>   25:	e9 fd fc ff ff       	jmp    0xfffffffffffffd27
>   2a:*	0f 0b                	ud2    		<-- trapping instruction
>   2c:	0f b6 44 24 63       	movzbl 0x63(%rsp),%eax
>   31:	88 44 24 30          	mov    %al,0x30(%rsp)
>   35:	e9 dc f4 ff ff       	jmp    0xfffffffffffff516
>   3a:	8b 74 24 18          	mov    0x18(%rsp),%esi
>   3e:	48                   	rex.W
>   3f:	89                   	.byte 0x89
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2
>    2:	0f b6 44 24 63       	movzbl 0x63(%rsp),%eax
>    7:	88 44 24 30          	mov    %al,0x30(%rsp)
>    b:	e9 dc f4 ff ff       	jmp    0xfffffffffffff4ec
>   10:	8b 74 24 18          	mov    0x18(%rsp),%esi
>   14:	48                   	rex.W
>   15:	89                   	.byte 0x89
> [ 3107.592031] RSP: 0018:ffff888010f67910 EFLAGS: 00010202
> [ 3107.593172] RAX: e585171f95821f87 RBX: ffff888113b04f00 RCX: ffffffff8260bb19
> [ 3107.594458] RDX: 0000000000000001 RSI: ffffffff8260bac4 RDI: ffff88800fa84848
> [ 3107.596326] RBP: e585171f95821f88 R08: 0000000000000000 R09: ffff88800fa848af
> [ 3107.597665] R10: ffffed1001f50915 R11: 0000000000000000 R12: ffff888010f67a78
> [ 3107.599903] R13: 0000000000000001 R14: ffff888107691800 R15: ffff8880357a0000
> [ 3107.601366] FS:  00007f668bdb0740(0000) GS:ffff88811b100000(0000) knlGS:0000000000000000
> [ 3107.603201] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3107.604495] CR2: 00007ffe77890328 CR3: 0000000115318005 CR4: 0000000000370ee0
> [ 3107.606212] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 3107.607854] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 3107.610532] Call Trace:
> [ 3107.611229]  <TASK>
> [ 3107.611746] ? mptcp_init_sock
> (/home/mjmartin/work/mptcp-nn/net/mptcp/protocol.c:1230) [ 3107.612654] ?
> lockdep_hardirqs_on_prepare
> (/home/mjmartin/work/mptcp-nn/kernel/locking/lockdep.c:4252
> /home/mjmartin/work/mptcp-nn/kernel/locking/lockdep.c:4319
> /home/mjmartin/work/mptcp-nn/kernel/locking/lockdep.c:4271) [ 3107.613890] ?
> __local_bh_enable_ip
> (/home/mjmartin/work/mptcp-nn/./arch/x86/include/asm/irqflags.h:45
> /home/mjmartin/work/mptcp-nn/./arch/x86/include/asm/irqflags.h:80
> /home/mjmartin/work/mptcp-nn/kernel/softirq.c:401) [ 3107.614952]
> __mptcp_push_pending
> (/home/mjmartin/work/mptcp-nn/net/mptcp/protocol.c:1569) [ 3107.615948] ?
> mptcp_close (/home/mjmartin/work/mptcp-nn/net/mptcp/protocol.c:1532) [
> 3107.616850] ? __sk_mem_raise_allocated
> (/home/mjmartin/work/mptcp-nn/net/core/sock.c:2810
> /home/mjmartin/work/mptcp-nn/net/core/sock.c:2981) [ 3107.617982] ?
> copy_page_from_iter (/home/mjmartin/work/mptcp-nn/lib/iov_iter.c:751
> /home/mjmartin/work/mptcp-nn/lib/iov_iter.c:738) [ 3107.618991]
> mptcp_sendmsg (/home/mjmartin/work/mptcp-nn/net/mptcp/protocol.c:1789) [
> 3107.619896] ? __mptcp_push_pending
> (/home/mjmartin/work/mptcp-nn/net/mptcp/protocol.c:1682) [ 3107.621006] ?
> inet_send_prepare (/home/mjmartin/work/mptcp-nn/net/ipv4/af_inet.c:807) [
> 3107.622087] ? inet_send_prepare
> (/home/mjmartin/work/mptcp-nn/net/ipv4/af_inet.c:816) [ 3107.623082]
> sock_sendmsg (/home/mjmartin/work/mptcp-nn/net/socket.c:717
> /home/mjmartin/work/mptcp-nn/net/socket.c:734) [ 3107.624372]
> sock_write_iter (/home/mjmartin/work/mptcp-nn/net/socket.c:1109) [
> 3107.625361] ? sock_sendmsg (/home/mjmartin/work/mptcp-nn/net/socket.c:1092)
> [ 3107.626261] ? file_has_perm
> (/home/mjmartin/work/mptcp-nn/security/selinux/hooks.c:1724) [ 3107.627185]
> ? selinux_file_permission
> (/home/mjmartin/work/mptcp-nn/security/selinux/hooks.c:3570
> /home/mjmartin/work/mptcp-nn/security/selinux/hooks.c:3590) [ 3107.628345]
> vfs_write (/home/mjmartin/work/mptcp-nn/./include/linux/fs.h:2187
> /home/mjmartin/work/mptcp-nn/fs/read_write.c:491
> /home/mjmartin/work/mptcp-nn/fs/read_write.c:578) [ 3107.629171] ?
> __ia32_sys_pread64 (/home/mjmartin/work/mptcp-nn/fs/read_write.c:559) [
> 3107.630159] ? bit_wait_io_timeout
> (/home/mjmartin/work/mptcp-nn/kernel/locking/mutex.c:902) [ 3107.631177] ?
> __fget_light (/home/mjmartin/work/mptcp-nn/fs/file.c:1007 (discriminator 1))
> [ 3107.632005] ksys_write (/home/mjmartin/work/mptcp-nn/fs/read_write.c:631)
> [ 3107.632957] ? __ia32_sys_read
> (/home/mjmartin/work/mptcp-nn/fs/read_write.c:621) [ 3107.633859] ?
> lockdep_hardirqs_on_prepare
> (/home/mjmartin/work/mptcp-nn/kernel/locking/lockdep.c:466
> /home/mjmartin/work/mptcp-nn/kernel/locking/lockdep.c:4320
> /home/mjmartin/work/mptcp-nn/kernel/locking/lockdep.c:4271) [ 3107.635041] ?
> syscall_enter_from_user_mode
> (/home/mjmartin/work/mptcp-nn/./arch/x86/include/asm/irqflags.h:45
> /home/mjmartin/work/mptcp-nn/./arch/x86/include/asm/irqflags.h:80
> /home/mjmartin/work/mptcp-nn/kernel/entry/common.c:109) [ 3107.636398]
> do_syscall_64 (/home/mjmartin/work/mptcp-nn/arch/x86/entry/common.c:50
> /home/mjmartin/work/mptcp-nn/arch/x86/entry/common.c:80) [ 3107.637254]
> entry_SYSCALL_64_after_hwframe
> (/home/mjmartin/work/mptcp-nn/arch/x86/entry/entry_64.S:120) [ 3107.638351]
> RIP: 0033:0x7f668beb48f7
> [ 3107.639336] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> All code
> ========
>    0:	0f 00                	(bad)
>    2:	f7 d8                	neg    %eax
>    4:	64 89 02             	mov    %eax,%fs:(%rdx)
>    7:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
>    e:	eb b7                	jmp    0xffffffffffffffc7
>   10:	0f 1f 00             	nopl   (%rax)
>   13:	f3 0f 1e fa          	endbr64
>   17:	64 8b 04 25 18 00 00 	mov    %fs:0x18,%eax
>   1e:	00
>   1f:	85 c0                	test   %eax,%eax
>   21:	75 10                	jne    0x33
>   23:	b8 01 00 00 00       	mov    $0x1,%eax
>   28:	0f 05                	syscall
>   2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
>   30:	77 51                	ja     0x83
>   32:	c3                   	ret
>   33:	48 83 ec 28          	sub    $0x28,%rsp
>   37:	48 89 54 24 18       	mov    %rdx,0x18(%rsp)
>   3c:	48                   	rex.W
>   3d:	89                   	.byte 0x89
>   3e:	74 24                	je     0x64
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
>    6:	77 51                	ja     0x59
>    8:	c3                   	ret
>    9:	48 83 ec 28          	sub    $0x28,%rsp
>    d:	48 89 54 24 18       	mov    %rdx,0x18(%rsp)
>   12:	48                   	rex.W
>   13:	89                   	.byte 0x89
>   14:	74 24                	je     0x3a
> [ 3107.643426] RSP: 002b:00007ffe778943c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [ 3107.645335] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f668beb48f7
> [ 3107.647101] RDX: 0000000000002000 RSI: 00007ffe778943f0 RDI: 0000000000000003
> [ 3107.648756] RBP: 0000000000000000 R08: 00007f668bfab214 R09: 00007f668bfab280
> [ 3107.650320] R10: 00007f668bdba140 R11: 0000000000000246 R12: 0000000000001500
> [ 3107.651883] R13: 0000000000002000 R14: 0000000000000000 R15: 0000000000002000
> [ 3107.653497]  </TASK>
> [ 3107.654005] irq event stamp: 17761
> [ 3107.654780] hardirqs last enabled at (17773): __up_console_sem
> (/home/mjmartin/work/mptcp-nn/./arch/x86/include/asm/irqflags.h:45
> (discriminator 1)
> /home/mjmartin/work/mptcp-nn/./arch/x86/include/asm/irqflags.h:80
> (discriminator 1)
> /home/mjmartin/work/mptcp-nn/./arch/x86/include/asm/irqflags.h:138
> (discriminator 1) /home/mjmartin/work/mptcp-nn/kernel/printk/printk.c:264
> (discriminator 1)) [ 3107.656996] hardirqs last disabled at (17788):
> __schedule (/home/mjmartin/work/mptcp-nn/kernel/sched/core.c:6393
> (discriminator 1)) [ 3107.658933] softirqs last enabled at (17806):
> __irq_exit_rcu (/home/mjmartin/work/mptcp-nn/kernel/softirq.c:445
> /home/mjmartin/work/mptcp-nn/kernel/softirq.c:650) [ 3107.660848] softirqs
> last disabled at (17819): __irq_exit_rcu
> (/home/mjmartin/work/mptcp-nn/kernel/softirq.c:445
> /home/mjmartin/work/mptcp-nn/kernel/softirq.c:650) [ 3107.662940] ---[ end
> trace 0000000000000000 ]---
> 
> 
> Do you see anything similar in your testing? This was on a 4-cpu VM for me.
> 

Yes, I got both this error (1306 WARN_ON_ONCE(reuse_skb)) and another error
(1010 WARN_ON_ONCE(!msk->recovery)) in my tests.

> 
> Line 1306 of protocol.c that caused the splat is:
> 
> 		WARN_ON_ONCE(reuse_skb);
> 
> and it looks like that is expected to happen with a zero window and all data
> acked. Sounds like a condition that wasn't expected with previous schedulers
> (that only sent on one subflow at a time), but could happen with redundant
> schedulers when msk->snd_una is updated by another subflow.
>

The original code updates dfrag->already_sent immediately after invoking
mptcp_sendmsg_frag. But we delay updating dfrag->already_sent in our code
in this series after all frags are sent. Then mptcp_check_allowed_size()
will return 0 sometime in this case. We got (1306 WARN_ON_ONCE(reuse_skb))
error here:

1291         if (copy == 0) {
1292                 u64 snd_una = READ_ONCE(msk->snd_una);
1293 
1294                 if (snd_una != msk->snd_nxt) {
1295                         tcp_remove_empty_skb(ssk);
1296                         return 0;
1297                 }
1298 
1299                 zero_window_probe = true;
1300                 data_seq = snd_una - 1;
1301                 copy = 1;
1302 
1303                 /* all mptcp-level data is acked, no skbs should be present into the
1304                  * ssk write queue
1305                  */
1306                 WARN_ON_ONCE(reuse_skb);
1307         }

The orignal code updates msk->first_pending immediately after every frag is
sent, but we delay updating it after all frags are sent. In this way, the
code will run to the position of (dfrag == msk->first_pending). We got
(1010 WARN_ON_ONCE(!msk->recovery)) error here:

1008                 if (unlikely(dfrag == msk->first_pending)) {
1009                         /* in recovery mode can see ack after the current snd head */
1010                         if (WARN_ON_ONCE(!msk->recovery))
1011                                 break;
1012 
1013                         WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
1014                 }

I'm trying to fix these two errors, but I haven't made much progress. So I
want to hear your suggestions.

Thanks,
-Geliang

> If you can't reproduce this, let me know and I can investigate some more.
> It's reproducible on my system.
> 
> --
> Mat Martineau
> Intel
