Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80079.outbound.protection.outlook.com [40.107.8.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD9A468F
	for <mptcp@lists.linux.dev>; Fri,  7 Oct 2022 15:02:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQXmCE9KwMoWqsaVuNvy+6BTP2lSwmMg6IWGz7poViVnWTYYK3/tYFFvnRLK/iDLcL+JHz51F1lwBJN5Iy4jJQrcAfpe8qp02HC1OtjVMMt3LWl6MGQpvgzuVxlKsKWu/QT7J645CN+1zJtqqBUJ7xPjD15OgGU1M5jKOgbIWcX1NdBMolZryVwM/2YAvyXwKd2ESDO0lCmhAR8jgOow9xG8mswulL1wghAOvW+OELP5ADnmDQepZSizEhvTNLmZGdGx4c6Z0OCxYv5eO46/qTprgBlqI66Akg65U1nuvwjvmTA14g2z6JBU9RuaW/NT10AYKkjXIIJmgslXho81jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PVfXsdGgJPJNdmc3V3dkJQzFVGqb+WIe+7PEFL3m80=;
 b=ioyUoHAWaCRXCDRFPwWrmb5MjsFWyNSL5Mo4CaQXomhG8hl1lFwFRqfYXIRv14N+m4fL60gwl8khmb/EaxOhrSz2PTs556vCRFjf3BAD8dCWWr9KSiewUaSAg9nQoDm29ui8i9eP3AOkO1MC/cwCK/u+nzg/m5ljWBJR6XRCPaZg5iy8J8Oe40bquUJbeAtFmQ84Xi0I2KaZc6O6ewqklY3VaocPa1rSDDVp30WUIYynYPhJgKv1IfXKzQKVIiBVR1Jyf2sl6aUqGMZmA/YQqGUzQJIbY9D6zy2qnbKHyu0+Y0aQMRA7BageU/iIw4mpzewCc3e4Fpco2HZQn4gmeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PVfXsdGgJPJNdmc3V3dkJQzFVGqb+WIe+7PEFL3m80=;
 b=dtTSoGIEfgTKgTElxaNW5aTrL29lxlzlNaL675fiPbpUJ8s5gt7hVdUknUW9JxI68Db5UWRrETuECUkcMEoOXgVEeBrRGwIO2NdQCUzJxri/53bKt2IuZRvMUh3nIHWldWrRvDEJz8H/P7Ly5ns08gI0uKBivR0Idct6nTdrSY6B1+1SV0hfLPxHIf6jtAGj6RTuN71n7MIPFASWSg9sEVDES2xZR76dZOKUMShsiTJIDITF0IBltBy6JzuOABH5X8Ku3r+rISAsPALRjjpAqHUwYpqo8lMkZkK4v2cAKY4S7tQOR6YRTtNEcYyBTphjk8CVKTaN/z2JNIM7nDlDUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8295.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Fri, 7 Oct
 2022 15:02:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770%4]) with mapi id 15.20.5676.034; Fri, 7 Oct 2022
 15:02:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 09/10] Squash to "selftests/bpf: Add bpf_bkup scheduler"
Date: Fri,  7 Oct 2022 23:02:33 +0800
Message-Id: <ef760d3b0a7f1cf9f94ec20c3c91479753909ee5.1665154582.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665154582.git.geliang.tang@suse.com>
References: <cover.1665154582.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: b2b6850e-6b6a-4e7d-8c8a-08daa87502f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JjomWeuS4AF1qTj413Hwc8MvKrxQ50zDY0ApPNW5Gcob1UJ5QNuSa9NsU9sQSXZIiEDzLFoXkLI7/6mj4iBhj13BK1aTDWr82UwofD9Z7RPBnuh0vXOpC/ysQP+alw4Us2gd80745RnV+3AcKX5l2D84khOv3ZZCsWiFQp3vdfeZf+nHBlWgZe90vVYdJ2bsBnnJBEUqRzkD55/Q6SV+b6dGyXbnR/fl/43oLYDcQCTcPN6b5JDxxibm3GcaeJfg/GRMzDQ2BENpA29vnauDY5xskxC0DKOwSmd+ppesFxVldVUapf9GWnwiIJsFngWAjfO/4hWeZsOy28hl7rNraHGB7bCj/ckrIrZt/QtBKHhW3Y/KNHgqSinz/xorpcttcJ8H75P8PXXFkGqHYeKqF8G3v80DwD71EVw/t+qA8B/oqw4Yfvqam4rlcSIoM+xZr+PMc7DH8DjfNHOuMRlu3m9MlrD3NCemw6igBRaTstfjYLyWofpT+cKBCpZFUrnvxmlWtY6BZxsCILihzAl0XzLBw6u7rwBYjl3fNvlaKHBBUm+EmjSXYFKbmF55FDf0Uk3B+VqYtAAvAVPGXVPK0+Q4ayc0vstWkP5/cDi0cT80oY/sjPkqu8gM8AWxGqr099WtGIrqBZF3aTVcL72PLSAjaWLcHe2/+WAaQGd2RoVyV6IE6191vjEVdlyULOZOGV4vOLGFFLChM0NqFfX/w+lNiEbJm0TdBYFNGMbfGacq9intPN7jcLiMZ8bRcBJh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(5660300002)(41300700001)(8936002)(6506007)(26005)(6512007)(36756003)(83380400001)(2906002)(44832011)(2616005)(186003)(38100700002)(478600001)(6486002)(6916009)(6666004)(8676002)(86362001)(107886003)(4326008)(66556008)(66476007)(66946007)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mMOhKExud8BwpcLTNM23Rfrj4jtV5gztmW9GX6mbjueHnGRsjvrXFPqYJzC1?=
 =?us-ascii?Q?nmjsuQja+jhlwcXJK/Y1rcp9nyScZmvQ1xbdBdfwTEvwHYvGkM8tcQIou/El?=
 =?us-ascii?Q?T2a1SYTNcKqp+4TV+bLusNxDcP7DpP2c81MwwbneNY2wbwys+w7aUQj6ovZV?=
 =?us-ascii?Q?U2fj/qA0XgYM3kMLwAOtODHUaA6n+9EDI3Q/FKSBaTuEiwLytIp6Q7Bc8mUs?=
 =?us-ascii?Q?LCU1LgjNJMzdGbhEEgT58+QnJ6o5p6RXzOrsNkGaUrCJLLQCFd+W136l/ohL?=
 =?us-ascii?Q?B+Zj60QmdV/omIxCK1U1Gq9gzd4FwwYb/DhnjpTkwDharDDzXq6rb7HKrUUz?=
 =?us-ascii?Q?9j/4pZFGWmyfAPjmRxtc1B3OIWIJSEs53KPHGdNcXJ+8QQAZK3gbTmkD4NiC?=
 =?us-ascii?Q?VIgzSxnVMcW+pLhVV+bxNrtOM/3dpFDG805FygtWm5wrWhG8MaL55r/NRQ2G?=
 =?us-ascii?Q?VAybg43KPWuu5IdyrnkAWoTlJWqAXDDPE9bLFHFTTkUgi9mboY/bE2kHKAqR?=
 =?us-ascii?Q?Safbqm+y6WrYI5FTV8x9BnBGhPofQLG1sKecZIyW0kDbY3OQuVmssbJYoAA3?=
 =?us-ascii?Q?t5HgWEho7Z2d+XSEGkVYlCLhe7qhk4vb+G3hjNM6QBBggwkGYIiSAO4fJlAU?=
 =?us-ascii?Q?03/PS4ew7zF3QsF2o7xo6PM3P5MRSktG4ojiZ6Tp9lN20mYUQXBxA7psogh/?=
 =?us-ascii?Q?A3wjwurahgSV1G34me1tX8AqHZ/GiINSO0W3GWUbivuktiIRD9/Hh/pRgllj?=
 =?us-ascii?Q?/KbhK4V3e+2CpfYGGe5niXQgG9oQZPqgALjonW3On0z1RuoeYMBTQm1RLfYH?=
 =?us-ascii?Q?WIFzdcdN6eYYQh98Id3bosnwv5n3Wiafz2g1PW0IXrv7m9+/hWO+64vhw9hC?=
 =?us-ascii?Q?7MBHsFxGOpSYbRRaXamkxCGYCWeSpRnwWOzmXfAZL8H4FuQKb9sV+Eqw4c4w?=
 =?us-ascii?Q?qD0g+OSuWyJsUNYE7L+cZupsYERzzTfC5Uq2EXyK8RZU2GzP2srMij/1kGfa?=
 =?us-ascii?Q?s+mXcSwuG0KWSA2gcUfkcNgn/F/15JTaMcmjWR7ulCyYDfBku/utcPNjNpx6?=
 =?us-ascii?Q?/A58BTp0RYqBklHHREwxupmhLuzjrwE9QoAQwEy5Ssub66/643v2sMx7/UiH?=
 =?us-ascii?Q?zkKqJjYIZ5y/NTZt8yhphkCzkfogT3HMu83N/bJjOVuxV1tFxNQi7s9JONvw?=
 =?us-ascii?Q?eWDAzTgWHSfD2ySG/eR7RSUlyEqUO0wKprJbjLdde2pBe7qavAPaTfjhvjV/?=
 =?us-ascii?Q?4O2FeKnfpMAF3cePeeBOlVNUS8xU3nf277NK6SxgbVX2t3tK+ZrUbCRlMOFJ?=
 =?us-ascii?Q?Q02IWq6GKhk6yjzN2gWLbo2RjIP7vSfboS5QR7iz1v2xXc3jvre3/WnuV5hi?=
 =?us-ascii?Q?sO4d3G8vDFWecxoDRLdaYjaLiyxMXIuVhTkywpcF02K/ytrmbBjzJMpWxlpB?=
 =?us-ascii?Q?ykoBngRMabWiHvPosSMPT2+WEYkqpCW0SaCZ4khpjgL9RH+FSBH7qduBeXQg?=
 =?us-ascii?Q?5r/X+PWFOBii1ejIMwynk+1rVYwAdn+rivgQ3fQSAJj2+uRe+293m0A+YLA1?=
 =?us-ascii?Q?Ee9Abngcbpuz31c9SBfCHozidDUEfO6fTxBwQoo3fDyVww7u/zcZ8eg3wFhI?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b6850e-6b6a-4e7d-8c8a-08daa87502f2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 15:02:54.1686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vI95g2kx1OK749gW8afAXrXRDUNS/hY2DicLhzWCQFqVaaErF2GzWZrZ3XdUUuxbTc3hdfv2x/lXFct5+Z32+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8295

Use new API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
index 949e053e980c..b2724426676e 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -16,8 +16,14 @@ void BPF_PROG(mptcp_sched_bkup_release, const struct mptcp_sock *msk)
 {
 }
 
-void BPF_STRUCT_OPS(bpf_bkup_get_subflow, const struct mptcp_sock *msk,
+void BPF_STRUCT_OPS(bpf_bkup_data_init, const struct mptcp_sock *msk,
 		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+}
+
+int BPF_STRUCT_OPS(bpf_bkup_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
 {
 	int nr = 0;
 
@@ -32,12 +38,14 @@ void BPF_STRUCT_OPS(bpf_bkup_get_subflow, const struct mptcp_sock *msk,
 	}
 
 	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+	return 0;
 }
 
 SEC(".struct_ops")
 struct mptcp_sched_ops bkup = {
 	.init		= (void *)mptcp_sched_bkup_init,
 	.release	= (void *)mptcp_sched_bkup_release,
+	.data_init	= (void *)bpf_bkup_data_init,
 	.get_subflow	= (void *)bpf_bkup_get_subflow,
 	.name		= "bpf_bkup",
 };
-- 
2.35.3

