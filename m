Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2040.outbound.protection.outlook.com [40.107.105.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C93C652
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 07:49:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCVYPuOpgFEKsBicegRnO5aafiIx9/B+LJ3wRvoaPH1CJlJkYBhuBOh02kG6HgMpCFg4z4SSrpDP43XkffqB6piyOJkoqTRmuArotSd4QwbD4gl9FX7obXDeXyBm+S4rwzYV7UaUTf44NTDsrmBl/NVKvAYXYml6M/NVZaxEUIcmU6pjH/PvU7ppv0IIMJ9NTgo5M86S0WBLnJpurX9TmannsTXDXg2i1VO944PMAvgMf8FQOIyg1Dvh561CWMi/2wBnfLyj9ouAAG+KUQTgDtAIFzHe4ItuMfpsQc+rj2jBKc4Afib0t7qCAgXQ8o2cB2/PT7Hbbliqk9QUjrtx5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MTxUdezPauo7emsfRWCE9nwFUwRdoHZ97YNn9b/Q5Y=;
 b=W9ZX6yK9yQbfnQIs13WaGoug1T3wo+7hCR3qkMbvBN0w40UmFUPB+7rLRRxiC32Xj/vaMAcW566xEPs+/3KDq8xNaS97A8FCW5yHb1teosG9FkkxFLiMYN5uJuiFAXUyKHwpPrit0Hc01AmMadRJoQdcS9ZCHPXpq1hZkEs3czAgvqPnU+8X1/+oyTnVfoiFGcNjWdIaUcAwK4JvfVqXvkWl/koONsbQPZe6RMEsK6sVPaSXDgrBNyvm++/3bl0Oh201NQFzxd+ArIKVQbYCskIxWdFYxH5OmqU2FQRKbkaS1LcoyqMfQVAJI1xELzpQH+ZaceGKBZYKLU+/xO8xTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MTxUdezPauo7emsfRWCE9nwFUwRdoHZ97YNn9b/Q5Y=;
 b=sh3OVfNAA+ocZUlfgbDrOux3BOPwvvT6ktEN5DMPrx/bkUvJcnh5qB3NpYO7Cr6rR6QByzXEztj/+boSkCW0Kzk37/mvmLttqMSc1GA9squ4SSTBHfXWcb7YpwuQuCVWmxlo4vZAPdKfHIzM/UYl5TFBRTEuhi2872DgH3hHcTL6d3uxgdAoiE1LvWnk7Q+jZwpEb8fksU4njYou8MFFn6Q3uohbP7ZUGOM0TMJMF65XkEF12uqITblgksne+aDfOipH7IbU7vYrpbPsTi6pRpGmV8OCX+eFZLNZMBMEG+S7Q3DqKJsXfYP32sPEZeVlfKqg1m7esJu5jTRjWjB01w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7521.eurprd04.prod.outlook.com (2603:10a6:20b:2df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Fri, 11 Nov
 2022 07:49:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5791.027; Fri, 11 Nov 2022
 07:49:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v19 9/9] Squash to "selftests/bpf: Add bpf_rr scheduler"
Date: Fri, 11 Nov 2022 15:48:04 +0800
Message-Id: <d1d8d0acb444c6ac39eb6ae945bf439d633e74b3.1668151131.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668151131.git.geliang.tang@suse.com>
References: <cover.1668151131.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:4:186::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: ffa161c0-91e3-4ad6-426c-08dac3b93428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q2/T5ANAEDdo0p2oyhB59OUiEPanl0y30Dy9l8csA0SY3uaY5X8f1ZcbnbwII/pgfTsaXuz937F1JgFzPFnWPvPvDdyZoFB56w3tJLkpMJK0ITTQijBH58WctcJAW5nUJfsTKzvtN/4u7TRPS4Y5yPBMgSEPybbm/D+XLBHyYjcXxzawMUUYhDH3gWI/4RCeYaejJyJuG4cdPSgZ5oLGjC7j8G5k1/e4mOfw/qhxR+eZf4RKyzvMtZIGGU5fwUtCw0xge1jUwUXxrHc4JG5QFqufJvBGGtTijvOTuoGa2Bm871QV/9+QOq+7j9AN4F2Iw/mHAQb7hHhMiC19AO3/2+cQDS5u3AnMuJsMhFPRygAHqLTW5OIE7o11s+lfigaezpaSz35iOyT2ZjdmNvU5gvDy+gMDXVigzhtymQcNigcNjYCETCD6IEBfwIoPjzl1B4JDQBkkHCg6NyYofPmKrOw7XDt2pke2to/K4OmfNLpVRH7FtKSrB3SVXS1ojG3GEw+mpO+3fSDjWCg+2hu/sm60+sMmDuW/FWpNipNC/W9kPJRVvxwVEX9CSSK23P3F1WWeYw3vRdnA50bQ0MJ8GQIE3Tqa17XKwo7rHVcJ+YM9Piw4JbYqLlsXLU76nQnUX3nyg6xRhWTjt6DXiu3/HjOjeu8ks7/NYEz6MhiYlPxTO5AqnndbsIzkC5FCISFxXxEFGcR2otNKRdEVM8WAzA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199015)(2906002)(86362001)(83380400001)(38100700002)(186003)(44832011)(4326008)(8936002)(5660300002)(107886003)(478600001)(6512007)(66946007)(41300700001)(26005)(2616005)(66476007)(8676002)(6486002)(6506007)(316002)(6916009)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DYRAAurHp63PPU1L1KUwlkcPAKZoSIeQqClcJ9PpCXcFOWHom2cSAPghQ+iY?=
 =?us-ascii?Q?ybnHtzk9lJ24jFvBJ8QvFyNv0Rk36N5H67L9al8i0XQLNtUWM3+QdChgW0OE?=
 =?us-ascii?Q?nMu09gZKVICK8hK5o6hdtdSM3b0SBKdT3I5/YhzxifOdmxFytcBMmEGgARkW?=
 =?us-ascii?Q?e3oTIjRgVZ9+uOl6RMOepK9x2aCmbItDAP81zcGRfn71fh0i2Ll682VcJ277?=
 =?us-ascii?Q?Zsr3sHJa93VTPqqw81oSM+8WAbKs+VWAxN3cvb6APnEnfdykiDGUQlTTmyTx?=
 =?us-ascii?Q?cYXpG3NlqdfdID+ptl4JaOg3NrChNe+t4T9arfttFgc/rUfeHYrSX882rmsN?=
 =?us-ascii?Q?zCCB5Xpwd/87nx+ncmy1fi98uD7rIv7/2RJqcTnpnM+xBaU4PTZfYGtIfde2?=
 =?us-ascii?Q?CqvFussi63BZP4hwMbEGPAKkX5mLqoAwK2OAmAIcmT4PjIR81k5t/clzPRZc?=
 =?us-ascii?Q?LtK0cVst1v3W+L/cNdmB+m61nL7ENXWXcc9+SrWGOCPIuyyy7AYWnwtcAQx+?=
 =?us-ascii?Q?5AM4DRB71bjUEJSm01KiEUCKSB+h3YfBKyNZwD541flH2eXpamZtm9bFUmY0?=
 =?us-ascii?Q?nuKdPypbK8sz9lLo20Hk4z5r0wt3c63oEGwf1uoUb7utfAweXP56P3wmpngF?=
 =?us-ascii?Q?Tb/ItvA4vYqsgMzqQeVuHjz7vinplX/QMvVjlZjJPLOTlE/IDnl/JuxY9+T1?=
 =?us-ascii?Q?aAmLeyLqnSMabfB160+0yoPDzFHY1jD8fJ3nvaoAZF93E7JL70Laf7zbTRlO?=
 =?us-ascii?Q?d+2+SSLQ4LtZTg6Qp1YVs+WIRx7EpJdugVeZglITAaG1fvSPN7KOFA9m2xc9?=
 =?us-ascii?Q?CK5sjpgxTOcGOC+mOi3lwPra4OXOr0vkWioIzYKDNdV9uRfAC+0zEjcP9qTt?=
 =?us-ascii?Q?cnRA08ZZ2RHhTTL/dG3hGRbKAzKB3YMGxmW6DAiUs235jki5ZVJ7QUUFTq0l?=
 =?us-ascii?Q?EKC2/6jUIo1p0Xfuw2w+NZOzcdkNfoO/3VQ6Wdw0w2VtLrS8Fc6BAMCePyAW?=
 =?us-ascii?Q?4Mw3ViriAnNEQavcVEeL9r3m3ThQUE3MQQ8yxyALTAoRgc6vsvZyMHmDjBH6?=
 =?us-ascii?Q?csd0i3wZQ34jCwuWDsGra8XQWfx52ObUb8Pzt6Bzgg4WYMzEE/6rwHUi2K73?=
 =?us-ascii?Q?oh4ap3rhEVQ62yC7z1WOqVfoQrs4Hu0Crd3HbAdszgLpJTxQUvyj8v1A4D1b?=
 =?us-ascii?Q?fN4g8r4P3nDVlwoiPr8wIpRjGlkARylsJklkg2q0qcGSIM3g8Ps6jCNmX9oo?=
 =?us-ascii?Q?krtc487OhDMG/6cO0pvXwr27aAdjd3qpBgag3YAvpPkASCzNXq5xtqpXG0AX?=
 =?us-ascii?Q?7YjYxV2u2oaWtiudppj5ZF6txQRVZ7pChzRYK3CWTMptsarsdVHs3LIb1bP/?=
 =?us-ascii?Q?yDSiHjdltMr34/Y5jBhFaKrilFLU61w2G1Q9YCr7D1DDVlz/JMM0xdfHeatl?=
 =?us-ascii?Q?xPNvSGSvthlLJYPYvQzSZfQL0fopB4jcsLzXDKAViKD9SAG2dtyvccYltmoj?=
 =?us-ascii?Q?N7xdGpCmtfbMFo1bl9a9+GryBJ/IJFgeRa8vQWO/NXtT/tcEEbwVQCmtptGd?=
 =?us-ascii?Q?EG+2pK5OLeBJt3gW10EPB5bB7ITIhH6v0wqPlp0+8aLWUxiI2I0ipeW4UmMt?=
 =?us-ascii?Q?EQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa161c0-91e3-4ad6-426c-08dac3b93428
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 07:49:03.8703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3J/G/VCFPmPX+KZYcb0AVZ/yAYheFVx4bke+f801k8uMmGi3GtDn2ej4UkJQi/RrLuSpsnoEhpghgBV+l0nhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7521

Use new API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index ce4e98f83e43..e101428e5906 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -16,8 +16,14 @@ void BPF_PROG(mptcp_sched_rr_release, const struct mptcp_sock *msk)
 {
 }
 
-void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
+void BPF_STRUCT_OPS(bpf_rr_data_init, const struct mptcp_sock *msk,
 		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+}
+
+int BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
 {
 	int nr = 0;
 
@@ -35,12 +41,14 @@ void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
 	}
 
 	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+	return 0;
 }
 
 SEC(".struct_ops")
 struct mptcp_sched_ops rr = {
 	.init		= (void *)mptcp_sched_rr_init,
 	.release	= (void *)mptcp_sched_rr_release,
+	.data_init	= (void *)bpf_rr_data_init,
 	.get_subflow	= (void *)bpf_rr_get_subflow,
 	.name		= "bpf_rr",
 };
-- 
2.35.3

