Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2053.outbound.protection.outlook.com [40.107.104.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DDF323C
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 06:45:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCxlThH0Y3zc8VRhyXLMvbqqw82WDcw+6taOiukXrxHhyKmPTumTIgDDZqrNlwk0SUcHZodugoFzIut+fA8MVPsgc5fwWx2wspTHy7H6V9/0UHHf/tVE5TjwHhV178OcrOVfMP7vzYk2JC0m222IgecrkobYrEiKfiY2bTw3g7HpISqd0JGv0604+CPVCQCVNx/lGmZXqKrLbvd9HCLrSuKtJ2b5YDec6QFngmPRMS7Sy6ksgmQnpqE78WES7ad9gtWQ/TcNkWNf6V8UQQqH1XOB8epQAwS3AqfXzfs2+1An3/cNb6+WVLT4MftyPGbmcc2g0CdFeJBu5mK7Q2Rc/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJjowJ4690G2NdLtiQ+Je2I0ckCnZXEC/DGaQQoUNmE=;
 b=R4ShHZFXUXL9C68bTo0x21sasFAoWmKDIuG0LA7LTla9Gj2e4LvSB1ZQHCnn0OFEKXPnL7L4xHxnl/X9e1zdnzo8C4yzA1FlyxQCKFLaxyDgnJstX0bHe2hkjuRe3+GFtWn3HxMV4imVciRUHK5KHymWbcYEKpq+IVFWCOQHTCJwSuDrRZWzJ1daie797DdyqEJ6YJjWiSCVSOHPnudef0Qf2sprQQw7quEGZBYJusBzqk2J3EiOTFfS0GpksyRAeGRpyGF1zwrqJ4TCTEd0Gyl2g6YMeShxkem6HrpNfUrd6ZcJiNNbQ2icW62ph1KX6gv4sR67B25wQf0mQjZR2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJjowJ4690G2NdLtiQ+Je2I0ckCnZXEC/DGaQQoUNmE=;
 b=Fr5FSREnTiPvIhQZFu61BFkRj1LCeMmRp8SFHzkbW2xFH6n8Ud3QAHxKGpg11eV4echmTQMEfRVIFQrg2aOmR9VHoQaHlqK073IJDtpPMR/x3gBXWAvkX78fTfbtf1FQ9L1HeuocpTa4px+kMbvEsC7YzrFuupHxilWEasXm38PS6OjbiX4MBatoH491bH5uhKSNMACoixfySjjlEa1eUd0FsJvwpbr3odscdoMJfo7SKnzZCaTJnmPcKuzFk5nbIr0DpxU27rFaNMLP9k4+I9m8+1BT8Fj1h2BaM2WJ5geR2IYD6KIvpJxRni53MWu+TCJVE8kwmPKTMjydeXcFfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7894.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 06:45:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 06:45:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 06/15] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
Date: Tue,  8 Nov 2022 14:45:05 +0800
Message-Id: <5baac399ca9080bc784254394896d7096d34075c.1667889809.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1667889809.git.geliang.tang@suse.com>
References: <cover.1667889809.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf9e880-978d-4858-d98e-08dac154db19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/Aw0TAwM4h1C/3BgDdIWgjhGOIiC76nt1dMtSe0Y9Pt2Hi7Yn2HAWQtxyoQKxspXIRGov8SlB2207qqjdsS8XcUMIFPZIHYzbFZANicZWoQ/+JFExY64BJGIU6D3QME5PssRkhkSWFHHY84IhtLBx0JirqaNkSxw/zRCBsiqYzJlwsJ6ud0NKzWFNI4PZHS5AOLqauif1fM59nBngIm3zc3feH8xhqK5WGFRKcxx+nnkkKHq2tdf2CU5fjpvsHRQqCTl7WHtHfcKjMfPrOMZJp4qF76YA2Xf1uuowQtAzwrutXkmlrJ4dpAO2JZSlWCMAXLiK1cMhaSQY0VnSsR6OYOa51fgNjLvZdRVRemH18fuWJUcSHHDdTYPHRzALIIaokLIAAi5WS4GA4YbuJyIJwhJgmRv+uQ3i09Eqhjh/OVqUiHbaqoiMDur2DIlOOFGQuf+6uT3iUgYWUqCs+T76hWdfYnhd92nmONDiny5J35BBuH/8s74fQuCnP9RBg338Lzm+C0PdFDdtOurRK1Q8KC9knM0JD8St+mw13iFt0+LynXYt07W13fHgaNUwcTBbdOsTinR6WE2m5IoVGy6vVQ2gp0jgFSgaYQv7qX/QsDaKn6WOdETQwXloQqHTnEScwDQ2r7rYSo9eUCNZV8r79do8p0dunhX8DRc57/eYBhOjeenI2JB+qHun4b3vVTvC0+8ydbxWAp9U4Mr3dSb0sx7bIP+bUHMBgZrd1+hqe1qn39qM7BgXuagCUFweX5q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199015)(44832011)(4744005)(41300700001)(2906002)(5660300002)(8936002)(86362001)(4326008)(186003)(38100700002)(2616005)(8676002)(6916009)(316002)(66476007)(66556008)(66946007)(6506007)(6512007)(478600001)(6486002)(107886003)(6666004)(36756003)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ij0YfSRsYScjl5tanXplvXh87ZKqSoh+gM9izaSonLDvjJLL+uNgYxo2BrEB?=
 =?us-ascii?Q?5vgb7E8nj8qzuAjsqB2PKm69oQTl/05/qYM1ZON5+9pYbCkHvXYmKU66w5zq?=
 =?us-ascii?Q?nrNKaGCKhrT8whwIZB0GzYWWnvLgXH4A1Ui7kEOPbGiDdzeg0Yb2xjBqwxpA?=
 =?us-ascii?Q?oJTKUs49l6ZyxjSkk0gVzzDH/GLSPWFpUSC7fKrJ5KU6amX2sfOJkIzAivC+?=
 =?us-ascii?Q?zKSnEB3ybaJ+k4vGAo74HLzxmOY9niyG7pK22gcKXRk+wUrVhad2fXE9yNIL?=
 =?us-ascii?Q?SHRGRwz6e9gyejhuD4w+PB6Yl3Mm2rYJJlEEuq53GmeyS0Hnuv1HYlhopD6j?=
 =?us-ascii?Q?Y/bsi18lcnmBUgot4CUZvy4Nca3ZLsbxqyRD3SISqMOoi0StfQHOfBhw4HsQ?=
 =?us-ascii?Q?ZWBAVZjtCB0ZnmsQ9ExHRpHWv70HE+IAPHJ/6V/rpyqk7jQK+VAdpsCxqatT?=
 =?us-ascii?Q?c0DeTGx3ApESYd5C9OINGGSdi+auLv3iGWqbX6jUCnMw4OZ4W4cINhQ1e9KW?=
 =?us-ascii?Q?3xZmaPwsu3jnvCV9+MECAF+Ixf+1l2tVHbn+HLn59MVfVS0DwkuSis5aG/9X?=
 =?us-ascii?Q?GiOqgYvkm38QOVJyF4Omy5AEIimAQhHPt6np5aiLqkbRmAHCtkasPbn5l4Db?=
 =?us-ascii?Q?36Nbar7/zBWptosbzSlaRAVHvrI+ry4JRc0csSI4h1WaJSrAte8y8NEYZ7NQ?=
 =?us-ascii?Q?IT9MjYovw3NGzMxFtOPyOjOQHqnhhvuxoba0UElqI9L4ukhj6j/73vMMgquW?=
 =?us-ascii?Q?KA+IwWCzbiBfGlYuIxGZIrVEU2QBNZmEZImARezEYEE3sMAQDfcBW967dqBG?=
 =?us-ascii?Q?OwQFZIIie4nUxfLWkyiTupHLkKduPdEabDy7U9KWRnsl+6/dUM58XB1gd0sk?=
 =?us-ascii?Q?s72ZJ8TpVu0HLMwCE4vTnTRjtYANm7tUUPSOBU5PPGNkhuqbSBmzG6EV82eI?=
 =?us-ascii?Q?1X6VtWTt+b5RAq+2XjH5/KAp5XautX+B/ZUruql6JZjmkvrsDCxSK6SFbh84?=
 =?us-ascii?Q?hg1Z7yEbunQeUvBQEMvFNYVsbXtCT7cwuiS8bKR3Z+pMMJFmiMCAixvXezNe?=
 =?us-ascii?Q?GhKkv6aYT0A6hNsIRUpJIPHG2xUwJWnT/MqrNLfbdL3YEUcTxUARsXl1L93H?=
 =?us-ascii?Q?JPAYcaVbWsiJN9yLx6ZXR8xAQPa35ifOwiLg8RNxZY7OjGNga7AQPl6hRtbT?=
 =?us-ascii?Q?WiLWmamvVbkd4ir+iFB28jq+6s7Fr9eEHzpXbJmg2bvMK5mMyOyx/DvFZ10+?=
 =?us-ascii?Q?AaAsTXQa+dPyN3GdrY9ea6qfJUUqzFzhQj8Y34hbQMXMZ1/Eh94DGsVDQakJ?=
 =?us-ascii?Q?QvURmTP3btE6G7CWqLFDPiBPdtB+Hvh1WKI49z1InCQbuVBNpLkQ/ZIx4G0P?=
 =?us-ascii?Q?u4jPprHAlrr1pQzd8ippzG2C9ejm+y7cpiv1gHp2xTgxspA7titP/BtRdoWP?=
 =?us-ascii?Q?OjatfuDBSd01zR3OkbNbP6do8rJ3DjZ9+ZMLMSm2Q0EIRv70KPEGU7U2Ue/K?=
 =?us-ascii?Q?zTs8eKFU+Ped6weP1bhofRFOXPwbKu1AlAS3X+hwRAt8KLw8Z+bu7NcCpJNn?=
 =?us-ascii?Q?4j1qHg6+nrs5BtJPm/7tZvMlLHUF93N8bK9qsJ05?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf9e880-978d-4858-d98e-08dac154db19
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 06:45:42.4758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44stxkeU6SHLsO7RLO0FiK7J8MlAvXomI9TjpJu+MuxivF59AhEZZbZ8IDrhZ+BHmwm2s3D3ASrikFrSkFF6YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7894

Add mptcp_sched_data_set_contexts in kfunc_set.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 0a768898990f..03decb05755f 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -164,6 +164,7 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
 
 BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
+BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
 BTF_SET8_END(bpf_mptcp_sched_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
-- 
2.35.3

