Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2072.outbound.protection.outlook.com [40.107.7.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD00B5684
	for <mptcp@lists.linux.dev>; Mon,  5 Jun 2023 10:05:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0JFTWIVBKTywuarMJp1YdGXwAUzf/5X2orxlklpX4zLanziZS9NTyHWtgmopePZhhdcvOEqRzsLlt8VwotcKwjaC1ZWCnygWUFEwJw3mr2N5RoD4KeSAXq4cPkdhXeuIZz3vRTFPJluLH09FCDl2oKYl5o2e1tj1IrK7mhOrvDb8UoadM5U8rEIPx5m45y8nTjJjM65bwZoWuzFXpvyukyk27p1C0z4p7opmY7jWP33sRsN4VcEJmcrxkRzRurWK89sfDkFDBUnskn5PO3qqPLsN/k8/abz1pcDuNIn45x5BHgO3FV6Y/gWKp2VQ8X4zEnPanaJ/vk11aBYcLGvLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRqCkPL2VkAeojXJPWudnY77t0Xfml9Sx2W9o79Y7So=;
 b=Ddm4P5204277ep0J/GNWDU2Is60LLqLGOl6LsqytwxaKfos6EvzW52MnHnWeSfUXvpZuI1AErE99xYC9dW9qCbbIN2yM3F4Cx0F8qrTqZ2SmxYWw4ansJk1troBbF14ekw3TzDIBVwSL7L7BSZOHZ7CPqxN/Vd+ax40sZn1Fp0rhdNsKuPa9u67dIeQtsGDJxoQtevCXemerTiFvUz6L9YUoTd8y3KoSkG0Um9v3156q1mi0Rc4/mppMlZRfMsXuj/Y1sBzFe6+13h8m5Wsp0YJGTNUYq7O6AZQ1fGzqSFKLRiE0nkiMkgSytqLRh/j82YbhL/O9jkxIsSuiTCogNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRqCkPL2VkAeojXJPWudnY77t0Xfml9Sx2W9o79Y7So=;
 b=swYI80VhHsLKqC6htK6rb7Keh1KEARrHOUdUwx2XGZQatR1qMwzPbfo46+s679tnSBLprIJq04awZquk7mw4nHf52QZCvhbjvVHULBdTZiVaf2xVKLPuOHbbB54WR0NunoXVBZMiQWzFEsYp6Bso2yn9V3L5yJhKsMYONd+3MKCxLHMBZQCKgUVTyGSD3hNLC0HYVHCh6+YXn4Sa3XUgCcTyz4PvtDAd6VorSBjSQRsFy+D918MvFQ6OO9tiOOsZcxityhR9fcUK0KqIfI8nmXYxEkSGvv/k60Dxe2DMUF1632K9pACSS32TxdoQi3f9lnJDOvDAQuoOlSxxClmboQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8596.eurprd04.prod.outlook.com (2603:10a6:20b:427::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 10:05:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 10:05:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 08/14] mptcp: add two wrappers for bpf_burst
Date: Mon,  5 Jun 2023 18:04:03 +0800
Message-Id: <112c0e8d4aa00eb4118b487b9881a9588c21a905.1685959315.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685959315.git.geliang.tang@suse.com>
References: <cover.1685959315.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: 666bb75e-2c73-48a1-d373-08db65ac5faa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sskFJmpR6r2yvxMCX7CGNDPDI/64s71rCjlJIFQ4fFBYDtg08/Hf9QzHFvi/gME7lPhPTGXD2ja+dIvH1Yk2LwNJYXgirYC9X25b7FPHbppFkx+oevjhJZuwm1yToQTgtJ/Vni04Fd7DdRcrqit0BZ6B7XIZi8a+Vgd9vN12k/n+DByLctnMZFhw1qT0MWK8+N7bhE9eRFncrqxxhpanJ9kycubfZ+l7eYwK6YuR5Ks7SG5+3SmpUU4xJsJwR15cDY5kqEeYZASm7/w3PWIxPwq+NsiejPUDyUUtZH8qIs51IB7qI7rTlRdO0xWCE3/6nXHCKxoqNkLpDej5yJiWFSR5qdTbbdjkme+0Wcv7FXXE7neKy83/atK2ENuvHM94xu6A9R9wI8gX33bGsztUfiOm68S9op7QEXmCnVI1CEn6f42NvJfpG2nZV8q9xvhebEE9oT6OLlhjPQq4mE8qFXTmje9tZmEXUtiVAQQckYItqkn8J/qIbMkpooli/lp7npf2fK0b0ifN6PVSyiUpyk+g67NzDTIMvPXLCmLjeiL+yXsVCmSfUTnFPS+dmZlp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199021)(107886003)(6506007)(186003)(26005)(6512007)(2616005)(6486002)(36756003)(6666004)(2906002)(8676002)(8936002)(44832011)(478600001)(5660300002)(38100700002)(6916009)(86362001)(4326008)(316002)(41300700001)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XgsQeQ7wDR6Uy/PZ1ZwjbCTRifWMVRRjZ6XI6EFMzn1+Z9XZcm9gw/wAuTGS?=
 =?us-ascii?Q?B0kqJyBpNPJlo+abEvyDBwPoN269ivhy6eGD+eV8rwZdbYSO1eDykeBRmqJ6?=
 =?us-ascii?Q?FdcbnSYjmRCXCj4zVhrHIhiYgitcsFO/XIIMKSXLKZ82vvCGMcwU1G5PWN64?=
 =?us-ascii?Q?IUDEf0xVFHBSnfS3H8emqK7nYq4ryCHHA9fiK2cHXIvjThLGXbFtnDdtlDRO?=
 =?us-ascii?Q?d5TIOMMAeOVjq/+2RCxMkopKaOhGETecpAT7VdNLrliuiDJVqw+vs33jU8Ca?=
 =?us-ascii?Q?F2oC26dE2BA1i7B/3zJHWIkrHQTiQC83z1WHIuKkhPbkXsUyWyLud8NrcYs2?=
 =?us-ascii?Q?IuTk75dvFk+BfrRoGKQxtteYEttOWes8KGlpSiSm+ZwTSAhs6YTvbKs5WEN6?=
 =?us-ascii?Q?mModmM1uFFl1yI7DaAi7mkhF3fsiAJ4ijsVCAkeCrrSi9VZlHQ8iE5DVnqre?=
 =?us-ascii?Q?BHXh8S+0A/Ao+wEm4wbSmAjykMdMtk81KwF/vWoHzmeEB8RzmYXmFkTPHQht?=
 =?us-ascii?Q?6jkgPWT/TPKUE9bmYpl7LJsgvvjBp8gWUas2MUfS9ziolIjtZe0Qtoyggp1u?=
 =?us-ascii?Q?fgpMt+hiVS29XJ1Lit8qcGaW2LYJxU+oEEjwTXTTuB9POey43R6+rVuGJFiK?=
 =?us-ascii?Q?lkiIf68jjms4Lx+v3pGYiNQwX03ZgNQam0XzHdKl4P9PgZPRjWpUv8a2PSy4?=
 =?us-ascii?Q?zYId4DW0vIp7OIEs85zDPclOs+6itg9P8is22DadRlN7GbPIzI8DJa/XpLfL?=
 =?us-ascii?Q?3zHn3x20I+lEu5PXHrYeFkykQgWcfH3O269VpAVpyMV36f7zJdz6SFzox6mx?=
 =?us-ascii?Q?8O7la36+1oOswO7/MViYvfoCBuLE0s6h7RidqKn+en9TXKJ71bRydAHQysva?=
 =?us-ascii?Q?EhpzbcyUDSHuIWO9OiqDTKiS4s25ltv2ExHmQAB9gbJboJ5iLVbaqVuab7Ok?=
 =?us-ascii?Q?A/VWNEFWiQSsV/FD/tomLrH5oERB9ewipORPN034C5V1sZJqYKkh19ePRD95?=
 =?us-ascii?Q?6n37nMu6pfq5+H6UDCAbFtKvP4bWkSC6hGZ9h/Ucg4GdCRk613SNBPeL2TnV?=
 =?us-ascii?Q?CVrORQNPwfpN5TjnYE6tkwCCnkop4el7UO38pAyUMN/prc3EWrFxdI49HjP3?=
 =?us-ascii?Q?dRRI6Hz0Yft3WZIIAYwpnUx1z1v67Bo/SNU8yAfrGPtdOBqe0xqo7XI3Lxrm?=
 =?us-ascii?Q?AVQMf1IUouIfuy6nRbDmD+LI7Gfn5rAWnpvx8+2RXOWlcL/UdyAqm7EoP0HG?=
 =?us-ascii?Q?mEf1dfuuv2tWO4s91HEEwvsyZ0uKmbAZXYUb4cT6fWxXgwMB7I5rqT2zkYDH?=
 =?us-ascii?Q?bK1FIVkWsQiy4iLJDJqX1BXXua9l/336EaKkL67JaB121LekgbMk7eIDejxy?=
 =?us-ascii?Q?sAPwkwzJok7YPFq5eBycxRDfx30bTUJ3XGh0K6/E7mLor7zTcrDsxizWUDGA?=
 =?us-ascii?Q?OemV9Pwa9TpIatsmRb+50a6jKy1Zd1g/hCGvsWWcoheA3yW4jMVFf2Sb6/uc?=
 =?us-ascii?Q?gDhBSgdLNIBq3m4wB74zCkt4yVvvuCBOumlGSHjWPYMbAuU9y2NrQNlgjIo+?=
 =?us-ascii?Q?2nwCqshjekS72A4+Ybx2qSkjCAHe3D+SIfAp+F9DzQ9iWMeZXsbAwCszHDpe?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 666bb75e-2c73-48a1-d373-08db65ac5faa
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 10:05:21.8863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3sabPB3H7wHSsVMrPb08uA44n1WY85dy1g18TuNFtpRfUPUYkgO/jl0e+lEc5wrhkBzhLp4E/gFLry8/7eXv6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8596

sk_stream_memory_free() and tcp_rtx_and_write_queues_empty() are needed
to export into the BPF context for bpf_burst scheduler. But these two
functions are inline ones. So this patch added two wrappers for them,
and export the wrappers in the BPF context.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index dd1208670c54..3ec90caa8643 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -173,6 +173,18 @@ static int __init bpf_mptcp_sched_kfunc_init(void)
 					 &bpf_mptcp_sched_kfunc_set);
 }
 late_initcall(bpf_mptcp_sched_kfunc_init);
+
+bool mptcp_stream_memory_free(struct mptcp_subflow_context *subflow)
+{
+	const struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+	return sk_stream_memory_free(ssk);
+}
+
+bool mptcp_rtx_and_write_queues_empty(const struct sock *sk)
+{
+	return tcp_rtx_and_write_queues_empty(sk);
+}
 #endif /* CONFIG_BPF_JIT */
 
 struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
-- 
2.35.3

