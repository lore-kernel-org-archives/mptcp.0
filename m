Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80053.outbound.protection.outlook.com [40.107.8.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96028808
	for <mptcp@lists.linux.dev>; Fri,  9 Sep 2022 12:19:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyUEuvFvvMD0YI9YzfB7LuVJckslEp07BYylF8v5KfRnkciOr2S+1k/B+8J474nf8XdYN/FX17PDrhlPIGsr0dzOHX4lKNVi2/ShAmMGtOQfB9Q4JKQQf4DOzuoGIBT+6J1TUmAU6BP2MUfHuVbYM7VGlfJESlRtJ1KHfHe0IsiZ0vEKelGbGBzgP9c/lIVRB5RVBA27jEZ8Xnfoz/4DtA7EVuRSvlCl9u68iGv7uZwiIik1e2xpTWxfp2IBPLopyrHWpYfU8CQUpS3MpQrnliSngHA6DmcraEr+8WO2+nudGTpXVtquWkxkg2UExNaI+mj2dzs4MnbPyBdM+obsDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXrnn8EnE6h/PMqiunkzRgsbXmWVOOvugvwPfkHmTYU=;
 b=SIBjyWIjAyQ3wHWsFAz2PnzXhjl1TcHrvB/gbDev5QV18DymRfm4Ap7oFeei1WkIpRgI7jKjeEuC2yCRUJ8zeiIZBkrsjM7fCV43FUbnliKAouDGoqbjKWYc1aOkmR5xxbt2eVwB9VTzeGP9rQ4X2Oo+Xn6myCfvt8+2UGsarG8Xqgi58hLs5z1aFacK8E0/yrt8J1Ixx+tHQTw7H9Soyg+oAhB8y3/LrRL3l70MaM3M1bpbXyxfIhpNmmSp3EnDyus3IQi3ptvhgI6M6Re6NFXAUtssi3WtA28D//bb1ksiQEJYeyL6HrWmq9IuW8c7ZeQnOfMejwjQXKkXgRsksg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXrnn8EnE6h/PMqiunkzRgsbXmWVOOvugvwPfkHmTYU=;
 b=HRWQb/NYWwv7SiSRZlBLqCmRz0GJL15RvlIzmm7oNx/mhrmD5ZXKRn5ISSNoVCJuHHW69Imp/lkOYv3FbLcYKS93w5voS7LDd/hTV1xp4hEXXKmMayQFkNvwYxM0vVT6rnweFay3OQ7Cw7YCdBFYGlFFL2SZeSnfvRgCVokq9p/CN09s/6rr+1ZZWfvAk4Ev02/1tZMuurViW6zWjSJL22AQW/7IMURjKkyJHpsTIji/RuVVBZKxuRImlII2C+0YjSZrLEUrAKTcrgrAkS+ZV1Tb6vLs+AadoJFBp+Oz7UFmAkQt42O79ISUZmsPzaoX7f5Y7qhGYttgenNN45IEGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2826.eurprd04.prod.outlook.com (2603:10a6:3:dd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 12:19:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5588.017; Fri, 9 Sep 2022
 12:19:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] tcp: Add mss zero checks to avoid divide errors
Date: Fri,  9 Sep 2022 20:19:39 +0800
Message-Id: <48ba286b429284accc457e34c6580efcdec593c4.1662725968.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2dd8421e-255d-42d6-6602-08da925d821a
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2826:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8ypFBWjbbVGWy5Q+DxBIp0/8tFBkytB6wW6cC0S+IDFBd6JWZlrWxLlcFRil58nwXlVxXLlGdfhAADtN7m2ClfSzg1FE3gyU95H/4DzfhI750IXIq3O4p8vFE2piEy68CkGblR39gmQIlr+jG5y7UFljL55Hu+3cpnxbwPfLSLCUzjBGmrVNHMp8ZKTkH2l3GAQAbDQYnqUDNi5bwlk6eXxHfEnurk/EC1tLWBddw7ZBeZ1rYEjXl6QoyzihY4jlFeEPQ8SzPncmYjDWqz/eE83bGvQLZsGXgP4jnmAGBHM2Dlbna/U5oQGvlcMrFghaYQrmQWV4hnJS/eKb8KCv19z8zpA5EViYNGPfOHON86/OxJd8dBWhg31wVIYRRwhuu9UQcGsrBqhXoF6KjPqRUfy5LYIqislDPbxniL0nbt+2k4hRHhEyFKs4pk/6V49q/wOOgr7CgirCrbdi34p2UI3IT8wc+wOlJSxy0330lWbq5DN2f1gC/iumIhTkhKrmmhgonwLtZRGp2zAu6Q0pzuNMtk/oF2Pq4F/vPtwVD5KhrElEaOxgzNIALVxqJDhlxG45MzbzJPAGOWkRUutPLAgN+WcZDiuVhyDfOE1tmV2/1dXXWvSMYF78Pn11fwjyTnRqSt/+GOayWT5+e8FS5Djy/U63x39Ko4Nym5c6GD971v1Q4O24/vYXUIf9ZjmJOxRz7PQW2i8JZSdXNUXkmPz3+UzonJlmVzwqMa/7sXmOroUNMyveBNt45h//2Do6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(136003)(346002)(39860400002)(366004)(86362001)(6512007)(6506007)(8936002)(38100700002)(26005)(478600001)(41300700001)(186003)(8676002)(2616005)(2906002)(83380400001)(44832011)(6666004)(107886003)(66476007)(66556008)(36756003)(66946007)(6486002)(5660300002)(4326008)(45080400002)(316002)(6916009)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UJwfhHrRU30lSAg44NgA4xNe3qtc3rPpEx0fZg93uREUc01vQQcFFsmIIxAM?=
 =?us-ascii?Q?dG9203wxQnOlJv1GbQNfOe0D7SToRulG12yubC8ay03qY1TZCXwDBNMG1kCm?=
 =?us-ascii?Q?yIzrWRoKJF+hbLjDXXgUnoRMuKFfjW5693xIp7AjSJLNOp58R1fo7wInFyaH?=
 =?us-ascii?Q?wCCK5/vb7Kg3xqFiUt6rQMY40uLehEh/riIGHfqqCBKs9kjD6fj8ok0sVjlY?=
 =?us-ascii?Q?aDBTkQ+EjMTaRvVCGoZoYHuE4Rbq8m/PVn98mRc0ajRW04rT+yzTEQ7N+vXB?=
 =?us-ascii?Q?VGQscMjYWbJTH/lZl99UTKZUINGlBFIjQz9Yvx2bFu5ezDBpotCYtE9u+3o4?=
 =?us-ascii?Q?1WnO9wYYx8L2tKKeCE9NONWDsgSbhDu334uGPAQ5JRjI2FvF/Q2egkdmcWHx?=
 =?us-ascii?Q?E21krZfK3qwjtE0L/jRkFJcNCnpL8S/vc4c1Mx1GKruIAO6E6Qh4P7mtUc7K?=
 =?us-ascii?Q?pubaQLHY73qeiX1e55I+YQtIJC0kxlTJIoXlrEot7OXKx18kihe4RARUd/x+?=
 =?us-ascii?Q?7VXcK9olPyHb9B70psxq2VvL5mxRma0d8U3NhfQT/KbWfQQkGEP6tKte6Cbx?=
 =?us-ascii?Q?pWd4x4vGyB9XYLkn1B19djLaiPDewhUuzgknrEmf8GFhKQa8iVhJ7lojRRx/?=
 =?us-ascii?Q?1B9+TrCbGW4NjAy6tQzafW5TI7+yI7s27F1FmRo1q+OTrLOhIFkdNq58NsGf?=
 =?us-ascii?Q?BZZk/c4h+20a9uGaUxgiSfoSz5iCNHDCDHDJnZlZoaz0sZQyNDOl8gTtMX9w?=
 =?us-ascii?Q?5Vfa91wt3KDUBgpa0hfFmCrTWi3fWrcP1bCqMHVY0LEvkaZ2SoZvbQzK8z6J?=
 =?us-ascii?Q?JxsYrAe44X+hPvYC1m0akVP3HjbTFE9xsgANYV7iWZDRHS9MDDvlfTUt/Q7u?=
 =?us-ascii?Q?3vBmEUXqsbSPwn+BHDDl1yyLrN93+2TYrodrxpoL016qUktYEkQE2IBLde6i?=
 =?us-ascii?Q?OAExM3yjuod/Jm4jd2GlnKYRWRWJNOPQ14buTtzoki2z2OH+caN9PUIB/NTz?=
 =?us-ascii?Q?18xg+tBslUQ+AhL/0//2HS7vwdmLJVwZwuyndKBXExALXAPnhOh0UtqoJoOf?=
 =?us-ascii?Q?i7eO0gm2q9Nth0junTdEzq9S26SB+fKShBjOnuIrFYNjiMgQJoIJ0rrt7wKZ?=
 =?us-ascii?Q?Xpq23/7BvkdXOHH8/UTrz8Vl3fuGJLFUp7kUd8651sC0fEeSoptuR6YVPPRh?=
 =?us-ascii?Q?ZFzpYijIMb3QJZooYNMELIK7DQRnqHe5df3vYeXqtyhX6F7rUIGrHDOH+9wj?=
 =?us-ascii?Q?1+xILnncCQQ2vvTyr1sn9F5Wfv4lmtjDHDGQcQ/2zr97HikDJzPUEUGgPiPA?=
 =?us-ascii?Q?4/SZq0R86gikcScy/J9ZNH+pUEHwXH4Z0mCGlglgmBF/UmBTZg+mT3rffrf1?=
 =?us-ascii?Q?hbmgC7DmrjrVeyni7vxtxly6wVULnAPWM/ww15pSRlC0rGjDtEnELQA7zIDW?=
 =?us-ascii?Q?8mOAMJD3PPoy21dMbCwkB2s2L06zY4B3yREL7Jkzw3wFFScx7ogDxyu83Vld?=
 =?us-ascii?Q?KRWl9l+GeXDhL8LfB911uisr04XHIMEV8hjjJQG4BJqHqNU+dTeS1UQrJj/j?=
 =?us-ascii?Q?h6iXyTPwzZcZTCtxI8v7w+gW4CQwJOnn0ctcuVV+?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd8421e-255d-42d6-6602-08da925d821a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 12:19:14.2009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A+jDlsUOHfF3Nmz6NAZilsvCaPGSkCmdMa6lX1xLwjAF6RNuYMYvR2YNwxf3KJO5pTEmtwhmIyo3mROY326dvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2826

If mss_now is set to zero when invoking tcp_push(), this divide error will occur:

[  120.369955] divide error: 0000 [#1] PREEMPT SMP NOPTI
[  120.369969] CPU: 4 PID: 15485 Comm: test_progs Tainted: G           OE      6.0.0-rc3-mptcp+ #251
[  120.369976] Hardware name: LENOVO 20UASA0901/20UASA0901, BIOS N2WET27W (1.17 ) 03/29/2021
[  120.369980] RIP: 0010:tcp_tso_segs+0x68/0x90
[  120.369990] Code: 0f b6 8e c9 03 00 00 d3 e8 89 c1 8b 83 f4 01 00 00 83 f9 1f 77 09 89 c6 d3 ee 89 f1 48 01 ca 48 39 d0 89 ee 48 0f 47 c2 31 d2 <48> f7 f6 0f b7 93 06 02 00 00 5b 5d 39 c7 0f 47 c7 39 d0 0f 47 c2
[  120.369998] RSP: 0018:ffffab29d1547c60 EFLAGS: 00010246
[  120.370004] RAX: 000000000000febf RBX: ffff9b4a82f83480 RCX: 000000000000febf
[  120.370009] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
[  120.370013] RBP: 0000000000000000 R08: 0000000000000a20 R09: 0000000000000000
[  120.370017] R10: 0000000000000000 R11: ffffab29d1547ae0 R12: ffff9b4b02980000
[  120.370022] R13: 0000000000000000 R14: 0000000000000000 R15: ffff9b4a867ec100
[  120.370027] FS:  00007f73957ff700(0000) GS:ffff9b4ded700000(0000) knlGS:0000000000000000
[  120.370032] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  120.370037] CR2: 00007f73957ffda0 CR3: 0000000104102005 CR4: 00000000003706e0
[  120.370042] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  120.370046] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  120.370050] Call Trace:
[  120.370056]  <TASK>
[  120.370062]  tcp_write_xmit+0x80/0x1270
[  120.370069]  __tcp_push_pending_frames+0x32/0xf0
[  120.370076]  __mptcp_push_pending+0x401/0x430
[  120.370083]  mptcp_sendmsg+0x41d/0x4c0
[  120.370089]  sock_sendmsg+0x58/0x70
[  120.370094]  __sys_sendto+0x11e/0x150
[  120.370100]  ? mptcp_setsockopt+0x2a8/0x1170
[  120.370109]  ? aa_sk_perm+0x3e/0x1f0
[  120.370116]  ? fpregs_assert_state_consistent+0x22/0x50
[  120.370129]  __x64_sys_sendto+0x24/0x30
[  120.370133]  do_syscall_64+0x37/0x90
[  120.370138]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  120.370145] RIP: 0033:0x7f7395c15b66
[  120.370150] Code: d5 53 49 89 f4 89 fb 48 83 ec 10 e8 c4 f7 ff ff 45 31 c9 89 c5 45 31 c0 45 89 f2 4c 89 ea 4c 89 e6 89 df b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 ef 48 89 44 24 08 e8 f6 f7 ff ff 48 8b
[  120.370157] RSP: 002b:00007f73957fe860 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[  120.370163] RAX: ffffffffffffffda RBX: 000000000000000b RCX: 00007f7395c15b66
[  120.370167] RDX: 00000000000005dc RSI: 00007f73957fe8c0 RDI: 000000000000000b
[  120.370172] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  120.370176] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f73957fe8c0
[  120.370180] R13: 00000000000005dc R14: 0000000000000000 R15: 0000000000000000
[  120.370187]  </TASK>
[  120.370190] Modules linked in: bpf_testmod(OE) uhid btusb btrtl btbcm btintel bluetooth nf_tables ecdh_generic ecc iptable_nat bpfilter i2c_designware_platform i2c_designware_core iwlmvm x86_pkg_temp_thermal iwlwifi intel_lpss_pci thinkpad_acpi intel_lpss mfd_core ledtrig_audio battery platform_profile intel_pmc_core intel_hid hid_multitouch hid_generic usbhid nvme nvme_core i2c_hid_acpi i2c_hid pinctrl_cannonlake sg dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua efivarfs
[  120.370238] ---[ end trace 0000000000000000 ]---
[  120.378634] RIP: 0010:tcp_tso_segs+0x68/0x90
[  120.378644] Code: 0f b6 8e c9 03 00 00 d3 e8 89 c1 8b 83 f4 01 00 00 83 f9 1f 77 09 89 c6 d3 ee 89 f1 48 01 ca 48 39 d0 89 ee 48 0f 47 c2 31 d2 <48> f7 f6 0f b7 93 06 02 00 00 5b 5d 39 c7 0f 47 c7 39 d0 0f 47 c2
[  120.378649] RSP: 0018:ffffab29d1547c60 EFLAGS: 00010246
[  120.378653] RAX: 000000000000febf RBX: ffff9b4a82f83480 RCX: 000000000000febf
[  120.378656] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
[  120.378658] RBP: 0000000000000000 R08: 0000000000000a20 R09: 0000000000000000
[  120.378661] R10: 0000000000000000 R11: ffffab29d1547ae0 R12: ffff9b4b02980000
[  120.378664] R13: 0000000000000000 R14: 0000000000000000 R15: ffff9b4a867ec100
[  120.378666] FS:  00007f73957ff700(0000) GS:ffff9b4ded700000(0000) knlGS:0000000000000000
[  120.378670] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  120.378672] CR2: 00007f73957ffda0 CR3: 0000000104102005 CR4: 00000000003706e0
[  120.378675] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  120.378677] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

This patch adds necessary zero checks for mss_now in
tcp_set_skb_tso_segs() and tcp_tso_autosize() to avoid this divide
error.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/ipv4/tcp_output.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 290019de766d..74db29eb6ba6 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1441,7 +1441,7 @@ static void tcp_queue_skb(struct sock *sk, struct sk_buff *skb)
 /* Initialize TSO segments for a packet. */
 static void tcp_set_skb_tso_segs(struct sk_buff *skb, unsigned int mss_now)
 {
-	if (skb->len <= mss_now) {
+	if (!mss_now || skb->len <= mss_now) {
 		/* Avoid the costly divide in the normal
 		 * non-TSO case.
 		 */
@@ -1971,6 +1971,9 @@ static u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
 	unsigned long bytes;
 	u32 r;
 
+	if (!mss_now)
+		return min_tso_segs;
+
 	bytes = sk->sk_pacing_rate >> READ_ONCE(sk->sk_pacing_shift);
 
 	r = tcp_min_rtt(tcp_sk(sk)) >> READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_tso_rtt_log);
-- 
2.35.3

