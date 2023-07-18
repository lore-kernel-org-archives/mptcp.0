Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2050.outbound.protection.outlook.com [40.107.13.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5025917CE
	for <mptcp@lists.linux.dev>; Tue, 18 Jul 2023 03:37:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfgj12ZgAm72u8MnHLi8CmyCLQkw+/XGIxJ19r3mg36UOM0PZ1tuQgmH1MeYpoIzBIJZs327XzcP+h21fjf0hTit0VZ5SFVv1v82F1GidhdMHDV5rVPHHGHxd+PhvQ1TTBTxQA3ia0TrUD3ZnQiM8dRW3Ew0F6wQVT6wvRxdsxUONXxM8Qd0PX6BNP0k0IAQWMjQs455qIqCyKgvAct3jVNzKmw2mjF/6ErUscB7zzp3nIVki3Np2D/Dh3tb79mRa0c+VmI8/89GE9bbVHOZLgS32eO3Obcue9oIshebP+Wk0NzhGPQX1XtuaA9HxAvsTCsnVx+TI8jACqjNJCzcjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGdAS7TLnoFBaQuysKdehFsXvbDD0HRDI6niCWMV4oA=;
 b=csWMFCULCYc+UP24UpgLPFYDZEft+wKeqJkAf0YO0CMtGZGrYthTx2huMat85fDWda1OCgdMLXVwb5mXMGsBrRauvtUb66dY+JE+1RlkXPnVZVoTr1MLvJaa50/gZBvQW2W6NE3FlFangLSGCxtKWUGD/0Iu/ud64CpFYWVKoaD4mYj8IgZUzpopdQTUzBLvj0kz6Vym9AmIiYqV194Cxw1BGhTpzNRWa2zE25N6pYSb3GvcMJSHiTarZaWPzU8Yc2R5FPm+8gGsPL+hfMPyHZ3k3TImJZunWj9YcLRfDPqUeajVlc/Vij+O+oRgnUnRkAOQEyFVEf9Jr9dv1LyQiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGdAS7TLnoFBaQuysKdehFsXvbDD0HRDI6niCWMV4oA=;
 b=kl+c7uEWibqEgVuN+vnyXVEAlEvNsB67h9FVLDoNN0vRAUyqRqNMetvAsMbRTeVZr+1wX4BcDfGb6Ldk+Vx3dNOIkbZlbTn8uESJN25iOt4JBVFbPrfGu9SXs3c2kMZ0zal7lx7kC9gRLlnFNuEc4mxH7psDLUZmLJApUPtsd9Wuc1Xhd+h+1IyerzALHB3hMmIbM7SFFAQ3tGhHSM2DTDInwCo7NunzBvB1OH+dYyWDPfdlAAE/ttUzPSf5wdA31HhIb64D4wJUxy8jCbm5hIzevpvmr6x5NCstJfsnmBRY312wlrD0N2ks/8DZZFA6gqJz8riNP9CTUVXRRcoTLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9105.eurprd04.prod.outlook.com (2603:10a6:102:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 03:37:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f397:e53b:9707:1266%4]) with mapi id 15.20.6588.028; Tue, 18 Jul 2023
 03:37:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 02/13] Squash to "selftests/bpf: Add bpf scheduler test"
Date: Tue, 18 Jul 2023 11:36:39 +0800
Message-Id: <a445e376acda401cdcf82c729cbb7c096f973675.1689650435.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1689650435.git.geliang.tang@suse.com>
References: <cover.1689650435.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:194::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cf3d147-d24f-4460-0ec2-08db87404b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Yivzr4PPyo2phOq5icljS9jf/3CTkjXogYXLwoYtXjj1wcDQqYPCrmmOVOgHeRXc8IDA+ciwlLxSJtogN+bUFQPq69k2nhcM/eDxrgGObSQYtNMPjfL/Y0vlalnLWpdaVOLXODgqjEa2jRDZjlZudnYLCetRnjTvzyoWLYJdzgmNSAXPwshv7JKheMTGZDlNw7agOsfGE+ho6ufosIrX4Gf9ZwVT25w9E0pnTV4DXZPLgr5WPIqL4NLX3TnHHt3DSalk1PGPVWi8/H4PGscUaYkRBm3JER8C5HW7EbCNOVIj62K//w8kgC6YvSLLBorKcm8/Qxp1cQjpJ3vSkGI5XHvoUEg6BvnYn2LMy51l80ra7Wp5+2Cyb91s4K4YtlowA8dGXaKy4nHDjudgcMgwxuAJbH/60yVpk1ltopavoEcdPO4bYDdkckd9iEt1935oFFoyGY22eB3tfEhBT5qi5LOO1uS8O6ZO9SQcZSMCoVfCF1wWQ3fJVi1kmXqFJpJJ84wpespLx+ACv+86Loiivs++cR4llhefvpCXJ3+wORZ1R9z01hzyIYAXAGYWTKWa1EiAjpyaVG47p6ZZm1IDu+vBIuxoyhAV1gWbZSXUonE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(39860400002)(376002)(396003)(366004)(451199021)(107886003)(38100700002)(8936002)(8676002)(83380400001)(36756003)(2616005)(2906002)(6506007)(26005)(5660300002)(186003)(86362001)(44832011)(316002)(6486002)(6666004)(4326008)(6916009)(66946007)(66556008)(66476007)(478600001)(6512007)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J99I+kQiti2fTWHptAObyUJF8LC4eqyu9ys/0kjkrt48SOoWr/TbS/KxpG5e?=
 =?us-ascii?Q?Hbn+IWiF8u5221WmNe/qY0/QL6yFfBmb/x4x4hoTRmqVxXNH+PajdERvxEeU?=
 =?us-ascii?Q?ffOnFCI2e8WNl9hf35idge46UxNb66SrX9RJfewiFFTgcw/9cT3wa+bpe8IU?=
 =?us-ascii?Q?padoOMVpxZkcrKI+wW5oaCQiVyAorf9FWsv+XqsqXjDxXSJEi5j1N5s2PmMw?=
 =?us-ascii?Q?wJDiMTCBSKHVW/fZIOWyoHBd+QeoLVOnfMMseYKH9giDJU5rYrDF+4dJ8tv8?=
 =?us-ascii?Q?1f/cNNutGXIBtBZmMctUSk1XdlwvooNOjL0wT/BchvDVKvZH1ujYqPq1QW68?=
 =?us-ascii?Q?DwgPylDCXrV03i1sgWNcjHgw+3RB4zqLM5d/PAKVdy3nGN2c0U79MnHLRU3m?=
 =?us-ascii?Q?Ojtv1rTM2ISEdrYzhN4d0/8akyso3qXHcJobCaeoXBRK9evQ0edL/uby5ns3?=
 =?us-ascii?Q?fPXsGRAbOPU/HZTcyuYdFxFH3KwFNECmaJxgg+40cuvFXWZ6wuZ3jlLRPglm?=
 =?us-ascii?Q?kfAIoL4t+f1xO0xI/KK2SrtqYfGPrLW+m7qq+2dmGkb9xTrjSq2oJTPoHkyH?=
 =?us-ascii?Q?3hpc/0Ym2qh6SaCBH0uOdMwsHIQ93if6iaaFgcCybg14bJItwrEsFnC2JvRH?=
 =?us-ascii?Q?iJBswdpyvdag/sQlpBTNON5rsWz2+W9kOjsTE15Tf1LFVqPV6FUJ8Cm1lgjw?=
 =?us-ascii?Q?oIz8HVegl6olkxJdvq9ylAjC+OgdcHC6uyXnusFdeFo7+us0SbajAqzPsJbA?=
 =?us-ascii?Q?xLF4N5DzwnLE+lL4sovXo8oRAIeZjekAKUHNYhNB/+pCKLq2zWyO3O8b3j1h?=
 =?us-ascii?Q?K+xN887pCpJmq321VMkLcuMebPGNPzKC9aAcU/PfWaYQj3j9HS8Af42HPmn/?=
 =?us-ascii?Q?HN8HALrDpMOB+7mkAEcjnC8/1w9K6JQGaOlBJSom2DH5bJz2utOtD59rUTCf?=
 =?us-ascii?Q?X83NrAwGr040NBMJv/Hfxbiqefz7F5KF4hByVFpE7x2JvEQyZDFERm02EyZu?=
 =?us-ascii?Q?PYXWw6F6AH6bjIxdijiu5PxFs0dUB5ZTgPKV2FLt2JGtbUSL1yzuJcCcRBDA?=
 =?us-ascii?Q?psfSdS5H5VRa685FpOHpC1DauebRpTxJ8G12VGG15+2A84V6tvRr04xuvySe?=
 =?us-ascii?Q?ZdlXz3EXqREDjSMFDt21fDnBFX7zoDKuydDqFSbgtE1tAg5aq3Pb4eFu9UPt?=
 =?us-ascii?Q?6TnIpCopfa3lVce4ARlPWd34mcXBcYTPx+AShMaE1ow4RlnJUOMkxQPW++67?=
 =?us-ascii?Q?4Rloa0hCazTXtWXIInkcP6h3hIUGnUBU2giWDQSxKTjlmzCc5GfBMQjmZLR6?=
 =?us-ascii?Q?mQ/htayD5k+P+FwmxPI4a7JpkmX3PLU82oDQ75em+iptPQkMR6qcqlNi6bfK?=
 =?us-ascii?Q?jY2hWP0Ms3DXolIBFPN6W0LgJPMw143oytiOz57kRJYvccD+Eb3eca0qT8OL?=
 =?us-ascii?Q?Vq1z9u/yK8KakNB/hrsEppLEaC5ZuUsZbFZHD5b8QYOlKbKzg5IVtdT1zX44?=
 =?us-ascii?Q?oTChj4XmI1tONwV1PtKy+zv5JEMoPegFgK7rYxeWTZc/u2PAg2GYGvU3TG97?=
 =?us-ascii?Q?wFul9XSI9P/igg7TFRKEPwrEv5WNOnieCexJ6dzT?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf3d147-d24f-4460-0ec2-08db87404b54
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 03:37:21.5639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9JAnj0pWtT8/0BAofbi7Wg5ufnJwggWw4nbTVkQ3ZyCRp+tpTIX/TGNrxPsekJFca1a/pbJSEHO1iPWjzYLNeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9105

Start server with PORT_1 and update has_bytes_sent.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 3279ff50ff69..f648e5d49f12 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -296,6 +296,7 @@ static void send_data(int lfd, int fd, char *msg)
 
 #define ADDR_1	"10.0.1.1"
 #define ADDR_2	"10.0.1.2"
+#define PORT_1	10001
 
 static struct nstoken *sched_init(char *flags, char *sched)
 {
@@ -322,8 +323,8 @@ static int has_bytes_sent(char *addr)
 {
 	char cmd[128];
 
-	snprintf(cmd, sizeof(cmd), "ip netns exec %s ss -it dst %s | grep -q bytes_sent:",
-		 NS_TEST, addr);
+	snprintf(cmd, sizeof(cmd), "ip netns exec %s ss -it src %s sport %d dst %s | %s",
+		 NS_TEST, ADDR_1, PORT_1, addr, "grep -q bytes_sent:");
 	return system(cmd);
 }
 
@@ -335,7 +336,7 @@ static void test_default(void)
 	nstoken = sched_init("subflow", "default");
 	if (!ASSERT_OK_PTR(nstoken, "sched_init:default"))
 		goto fail;
-	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
 	send_data(server_fd, client_fd, "default");
-- 
2.35.3

