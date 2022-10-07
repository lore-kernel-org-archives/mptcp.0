Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80075.outbound.protection.outlook.com [40.107.8.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9C0468F
	for <mptcp@lists.linux.dev>; Fri,  7 Oct 2022 15:02:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNJfLVA8+R6kqdaTQxIekK6QvwJL5O8epDsRSiTtp01kjIc+CFN1eVdIr0mWSDxdY5VCrTCy6o0oVxzQy8RUi9HCjTzH5QBIGZ+W1H1voplVKyzUzoPcETuDbMC89HeWWxGdIgq49kfASt3yFkFqc8R7VZ9ufzz4m/iW8vvmXgwC/3R/9d4ElPmeyP/JzjRdvWSbOoOTdsPF6PFcbJ6KVdW6Ocl1N8unb89fItIhBhv6Bej9OxUZ1oaAzcetgNzY8Kof63z1TXmNsn+Z76pgvDzHqueJz8e4Z/4MY2YFMpQS3ek4YCQSj7q90+wSpSaAfIPF9OkhYooD0evL1Uhp2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnDh4myN5PG5rA51tFqnEO/Baj34uQClbwjqgpGiogc=;
 b=kho10VROJ1e73xrRlJ0erTJOxzTS1gXr0alyykuB3qJFDefSGAG/2hNs5zEluB/REPDYCrHu2aKkaRK+PfUMgdyPi6N0x/EDxEu7GxbnbEcBp/4N2RekUSSaGCUw7tcC9As6csV/Hgw07HpsPys10JDx819IYTCIeTEC0d0dJXqjUCQ3qrQgvu9vqwoBmLMu/NdP8zWVGE6JIJD7coEvK5hdMs58m4t4o+WQ9V2u0hnvaLbL6t9Ty2gbgm/ecNxwtj8eMSFumgS0ps7t3ZRkEggOY1ZF3WRBTrlaYEe2tSsn7bfNPhRXvNe8EiRMkkmrOC3x/fEL5RMcdUP4FZ34nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnDh4myN5PG5rA51tFqnEO/Baj34uQClbwjqgpGiogc=;
 b=jT33ShexrUZR5Qo2PWuR2qmKlQapGP4BaF2rI2112EA7Sjqb0WshhvMLzcpyuwrYQp78Ha7e5Tb5ljVve1M/kt/q1n4lKnfFF5rz+V1GcfRPmjPIGTycAbO0ZlTxZEe4+FWmf8F5xVECVEa850aOrux80wR6MJINg0WAP5LHTc3DooxgiM3I9KohGjua2K5jYgRAG6VtllhHWiEVZBZW5lusS8pOauiMuClLFeVjiHpArGyjAKNSStTockv2ZX50rDS4McfExCukLehCRn19dP0N3TOuwtz7dMiwH5tZERm40F+y6XXDmXmyKFvbWksnuwee+ntabtC7TQdTxgk/bQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8295.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Fri, 7 Oct
 2022 15:02:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770%4]) with mapi id 15.20.5676.034; Fri, 7 Oct 2022
 15:02:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 08/10] Squash to "selftests/bpf: Add bpf_first scheduler"
Date: Fri,  7 Oct 2022 23:02:32 +0800
Message-Id: <86bdc0acc11573f720fcfb4e6d55b2826f5995d5.1665154582.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665154582.git.geliang.tang@suse.com>
References: <cover.1665154582.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 480e784f-21cd-4b84-f94e-08daa874fedb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pZ14Ibq43VvWB5ZYEQjgvniulzlo+oDqtfWmcMXRCcrEMPtcAmBvM8cebarHkcHgFXe4HnO37cApcw0noTWsQU8Dwcm0yr4D6RbvxONBMPK+a9pRt3RbXcZeQvZGyR8Sm1UyVe5az5WLFil0RmfS0O3f2BRh6cz6XBIC9ntDx5nbON3VCUZk1Xt5utEWFiSKKEYuB9NjC+i1ZTIGI6eUudXB+CUBioKucJNCYQhVKlnYiGeF/2D0QtwDpvCDFmWyAAVI+5nelzwwStOBgDXKfh59CHvii6cLxHVoGLDKL73Hob8VixI+INug37dPsyq42aC/RAloW4C8XnjNluJ8RpDFZjdkb9nRC3zQ82e1hrcwy2tiy3kJnHbi0jFlPS7WbheWGdaJMNpgWqrKpsBJ53gBZBu4mHXkt12WonLObskBNaCBpgJpUZ2bMdi+QXEp0KrybgJoaAyxyPB8MPBra0vA3/R77IQ/S6+8IpBA+3nk46xzabGOHSOv1BJ9pWXCU3E6hhwzyg6SiXnGEOz9QFmUCiknoxlGwLrWhq8lkE7kPXxHD9Fv/5/yM0TPo2SJ1bEmLQx1Hx9AkE+AeqW3qWanTe8kTh3GRLTZxSoijniZWN6Q2Y0PFAuiEb0X72pDsKmdo1zUa8f+fB2I+DVvNj4yqfadVpeM0hgxU4mXZkslG4S8nviLMdHw9EONO1r5XrVe4D6DtUZ3g3O7sXHW7RiPMFmT+mKjrWsuE27YMEFrwJtJw0CpJjE59PuLB5Aq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(5660300002)(41300700001)(8936002)(6506007)(26005)(6512007)(36756003)(83380400001)(2906002)(44832011)(2616005)(186003)(38100700002)(478600001)(6486002)(6916009)(6666004)(8676002)(86362001)(107886003)(4326008)(66556008)(66476007)(66946007)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?txlE6C9tr+k+Kenp4ob81r6UpyVBWmXvwSinE11Ix25ZEMKoeuZ9OY3BOKhY?=
 =?us-ascii?Q?IMgIdfYO0ckFCyzh9pNlJw+fdkX60pc2P51SwL42B3TMuCYIRRCTEBdxiSH9?=
 =?us-ascii?Q?l2Z0TezTszgQpIDxGaRomIOdbGm+SZDjDGk6JGI9vz3uZWX5Bz5ev3szWxGS?=
 =?us-ascii?Q?eChmBB6ViHRdLHljaZ+pzTkJOpJ3MizohcsxO5IvZpwh3URZT7BTPYYc0eu4?=
 =?us-ascii?Q?rBSNyRkg9ngYzwVSM30VhJCcwDUoS6fy9VwSRdXYVcABH0S0/0Qk3a6ZwPqN?=
 =?us-ascii?Q?xGNArzpU2hs8WgGu3J5YY2Eg01ZZ/Q3gAjk99iZmrJSJTWy7d44mLL4rcxz7?=
 =?us-ascii?Q?pVTMvkhAk9TNo7PPPKyHDfptTNA4FyDN90J9orV2kau/ITOBt/N0cx+oK36T?=
 =?us-ascii?Q?hfcEBLpmD9BECshkDve/ylwKLzHQ1SVl+qMf5IpTori7fnHXvh6W4qZIcL/J?=
 =?us-ascii?Q?VpKuAGMAC5/7EZeovjQbK9VBXm7LOR80hQIJPSucp6+L5di+v+Q1ORXNWtoR?=
 =?us-ascii?Q?xglj1IfISKthQn4rwjoFOSiRFnon20N9pKbBjIMBhhHCmIv2vbkSM0lZzYjZ?=
 =?us-ascii?Q?lxwvW5G07Hdk/S1UVSzbPmFl7ew5eTeRvgYbPgM7l2aFjpSIAPDfJGfLtGm9?=
 =?us-ascii?Q?xK/gyy6+0zYyqZ4j8eI80+WHMgPHnkpsd1Sr05Cyqrm0m0I3ERL8D5ed1XUh?=
 =?us-ascii?Q?pyCZ6ewJsE5p8Bi6LvgGk2ROBxz9Q9CoDRhOhC0go8xeMU2dejtt3qxLNDz5?=
 =?us-ascii?Q?i/XoaTBf3y8Yvbaeq0TOW5ch1lLfx3oDzywJrXeMndZ76sw9rBNFBaCjKtwE?=
 =?us-ascii?Q?G012Fyf6cy59H9h8WWOCFoeu8LipcHeXA+Thz9GHy9MV7uYNpl0fffhSu+Cr?=
 =?us-ascii?Q?H7ESaGVeeoBeCBsrWo5tRXWP/s8jvTtjgamNSJ5J45e4c4CS1+2/Z6whrP7R?=
 =?us-ascii?Q?C8tKLrG9q2P4wMuIjFzm1VW6Lpj+2TcqBowK2PkRZwH1xucl6ThRxysHW40i?=
 =?us-ascii?Q?y4LfFw0K3evd+hPGXEIQEWYd1JaZ7D1MOVBKYtvyI3YSKC3r6ydzlG+C5sEg?=
 =?us-ascii?Q?UV0518V7Vs30hcVVCCuews3ca5yqzY/5omAyhW8pReRXHMC75mxzw4E9Dctv?=
 =?us-ascii?Q?8dQu4HrA2bb1MltO2E+9p8h77Ld7wIN18RAVYkgf05SoT0mMjA85v4jJTPZW?=
 =?us-ascii?Q?xRjgX8ZythB79zZt2mGV/94lqJuiEvP7lFdr22Q+8T9VDz9Zc9/NRXIGc5vy?=
 =?us-ascii?Q?KHWy8nE4pHGl3GlHO5O0AvZxlKmVx4PgCe6Ij9Y16v16/ncxt4Y1yGPZ3gtN?=
 =?us-ascii?Q?owzPhVBm3BO13db4GIuMifXkYDhRZPIYnSwFvp3kA2bp2vUjJKebMEUyARKR?=
 =?us-ascii?Q?abdIdxQu/T5OXghlNkdfl3P2W+ui8GD5AylarmM7PpDucnXGKTa1p3lvrR21?=
 =?us-ascii?Q?jyW00KvWY/nre0puN+d5OqiWa8lyi6Jva1HMU7DeufmqYIIepWXitModcOkr?=
 =?us-ascii?Q?Ym0urID1s7ukpKzTDip4vKAKiuvr9VxP9T6Q+lR/gtgi2BVFS1kh37bXxW1l?=
 =?us-ascii?Q?K/IbvteFbZic9lVPVff5c192AuWmw5pKHoWDjzBM0NFJKlrgsfbCA6thYD8m?=
 =?us-ascii?Q?yw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 480e784f-21cd-4b84-f94e-08daa874fedb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 15:02:47.5441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6sbBUarXJT0Y5HjzhMmK8pZa6DuntmEAo1Bm0xumZl9nftI3spizViQGe8U5cR1ZoEtN+CKu5ETFVlqUZcYDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8295

Use new API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
index fcd733e88b02..e4caa2dd8c6f 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -16,16 +16,24 @@ void BPF_PROG(mptcp_sched_first_release, const struct mptcp_sock *msk)
 {
 }
 
-void BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
+void BPF_STRUCT_OPS(bpf_first_data_init, const struct mptcp_sock *msk,
 		    struct mptcp_sched_data *data)
+{
+	mptcp_sched_data_set_contexts(msk, data);
+}
+
+int BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
+		   struct mptcp_sched_data *data)
 {
 	mptcp_subflow_set_scheduled(data->contexts[0], true);
+	return 0;
 }
 
 SEC(".struct_ops")
 struct mptcp_sched_ops first = {
 	.init		= (void *)mptcp_sched_first_init,
 	.release	= (void *)mptcp_sched_first_release,
+	.data_init	= (void *)bpf_first_data_init,
 	.get_subflow	= (void *)bpf_first_get_subflow,
 	.name		= "bpf_first",
 };
-- 
2.35.3

