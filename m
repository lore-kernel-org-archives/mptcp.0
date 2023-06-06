Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2079.outbound.protection.outlook.com [40.107.6.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51338813
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 06:45:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/Vx8lnTivdBLnExKPHFqDjMeSxGY1tyReoKyIgVaU3BWZqq1SdwYN5HWwdIvFBqaTgLCdBPHJpKnC8ZWy3DHfoR5USTZVLCPA3EH2rxrSRaXx4ipYtGCBumWdxb3k4IJXAYWRS1s94JpjcBnfb2wyZhMp8sI0w1MfVl5i0RwwKcgQ8wrs0/tlrXQD1Md8eD3sw4PVOrtJUUjHM492WJguWz4hLqTCvjTAwQzbC6dGvOvK5Wc16aP04DvTjxZycZ70z0+PZUVgmlZB+5jAaUvj3gF4ojGZ9qZ95Wu2+gCk3NGSG+/FawqeSNTQlnJqj/BNFHVBAV/u6aO9P85b5+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Q4INmfgho9xg6KL19Hk5Uam9YcWUetT2OGIV4nX6Ho=;
 b=not/bkWremoXDQpCchaH+JFFPcXVYtJ4o2buXavXMxUHo8+cxzv905eDCiySL2JEyDe+czxziwh7cnM/vgD49AaR1Zji6n84kpfK39IZNETHMG5O4t6ew8z1Mhu2e40VpTIuaawzL++2Xw/jawxn1jlCNIwqOXwD/+BSfpR/5/HNICXmYAm+clQqOF8FK1nGnJkh37VwYA2BmAHnod8wmTv1RlKBfZf04WB5qWWyxoh8D/8QWmYWWqYtfntnvADEB55aAnFwPqAvKJHj6Hg2IepNamIur/F6kVLzjbO54nKed1ZXnLyn4GI905xMZo2LIkypTqoLjjsoaJ3H+5IR+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Q4INmfgho9xg6KL19Hk5Uam9YcWUetT2OGIV4nX6Ho=;
 b=XbVsuPpKdEoNaL1wUGMEl3qL+iGmngwYzG/irD0yS/X3VUVN6Usjc6yef/PR9O4tTC66n5rBj0zsAN4gCaW7W0mD5XenkP81V79nMXNm/avSVJfMi6Lwdo74l64Bs3B+0+hqSIc7uR532WncreS0xAHVlkMzy2DRQtBLKA8Eug4Pw3QFDrUjacIEEiDj8XCD9yrfY2mUbPlybk8kI2IA2pRCh+xaFuW3rUK4nM+ylPI5H9OyPP2/MhXWUorM4LmnroQPfTlJr9RVEOX6iTBbiiZk6FHBXhsNIuxHc8hAwU8AcMahPUm8aG9M18kusAw5zlaLzVMSNdWO8znRex3i2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7029.eurprd04.prod.outlook.com (2603:10a6:20b:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 06:45:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 06:45:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 03/18] Squash to "mptcp: add scheduler wrappers"
Date: Tue,  6 Jun 2023 14:45:02 +0800
Message-Id: <78c762473c2b299ebaa301b15fa9849ddf7d14ea.1686033694.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686033694.git.geliang.tang@suse.com>
References: <cover.1686033694.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0178.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 45691365-f878-4e7b-355f-08db66599eb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OeEaYo+MqjMIp4YcTryBjcmotlZdZV+lh82vvZ64ASZoD5MAueWWjkak8JQznnFJnSJYiVr52zuyCWOmig2LuG4VK9qteAnMqTZbN2zrmI7VUOnDz8ECnLyxOMoz/c1pgiAYwGx6Wiyl6ySn1bHvNC0+O6xPcZ1HP+8KU4HJNpi+5e7cxUVl+O0fPrua1cMZgRiV/RDkhFPAh3khwvTG70N8g+FAOgw0IWRcBUdIhWKt6XfsxX+YTs/Z45hqrw1BK+R3Xoea+vjeY7Hq8BpoZm8ikL0PKX0V71G6YSpWRK5Z+Bc1ERpMhoApb2/kzXrGFtM1BMaVGZKoQBigMsnyPf59h8zGf0fuaYN6qvZNM/+TgH4YEtnNupSj+VT53Yu4utXGC06mfJneqVxArC4QFhyvy9r96BFUejYHpmf1EpCpRgvdO44da+pWyeyrKL7rNjrEzaZ026nS5CCF6m5EexgBD4sYo4Nn8QNmDBHwrcjfORLBtuMLAS1XLKTqMSvexHrrbHUVqmAa91Tisjat3D8zBBqGzS+n7ltIT0O7xQkRT9mUw0/HWdcP91QZdn1d
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39850400004)(366004)(136003)(451199021)(2906002)(478600001)(8936002)(5660300002)(8676002)(4326008)(44832011)(36756003)(86362001)(66556008)(6916009)(66476007)(66946007)(316002)(38100700002)(83380400001)(41300700001)(6506007)(6512007)(2616005)(26005)(186003)(107886003)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?blylgaJcWHfBfUrg1PIg/gqVHq6KrsNepOa43eKKvkxSi0c1aRU/T7a4eIEl?=
 =?us-ascii?Q?QNnsSt/a5FlTHGTA0fWCz6AP9obah1G2JsyZI48AB1WbXVKxVNC+cCQd8vuL?=
 =?us-ascii?Q?doqzMBRzA+eY4joNuRHLPH5TFi02CvqHiKnIEOI4JvdZUREg6o/P7xt6L8T+?=
 =?us-ascii?Q?uS2IfKK5LeiQAMskMWPjGkI/Cgv+HtZ9CDvFwlcfLE41bSzEwNW98xidNMCT?=
 =?us-ascii?Q?Ne4EsnBnv/4truk0DtZb7TTyBbO1SYdoHMpSXLM+y71Db2kd3RA3nxcsvmv7?=
 =?us-ascii?Q?5qGff5NlHpZAECENFJP9IH5jOYoFYeRP7CUtdX/aRkdHmx8ZEXtaDQLDzHNE?=
 =?us-ascii?Q?L3kWbyIAdfCgi3ta6M2J2HKc+nQq8ugCTmVBa5wQQIOBdFOmPchAw7sH1fuD?=
 =?us-ascii?Q?DUlhvysMe1bD6IPFWKiwv4CxU7tjxP+YXvue8GDwwYaTk1AsrvbOmL0BKDH7?=
 =?us-ascii?Q?AOnVclbBbnyWQvsdW5tWXruuIu2hcurYS/D0SpIKVbhnnAhKtxCDGXQjPe7/?=
 =?us-ascii?Q?RHGzXtXZAi2TDFINr34PqvWEr4IKl4jHyicUICuaw6cfWJdH6qK66EVZIOVT?=
 =?us-ascii?Q?KJIxguvNcPOJ1kQj+/LC18j8JajSDpd6fS6etx7l2qxMaC10B3rWHfrIHdbc?=
 =?us-ascii?Q?SGvYJzQBLVSCtqJO6PKYGyC58HFjjHifYsDgl85Nek3qAnGTB1ptNWcpHVLL?=
 =?us-ascii?Q?34wvl8qiqU5Hf/BUmJUs+TjSdim2RJ2jgHcYML1Cpt9wutaLwoVIJ2sW07D3?=
 =?us-ascii?Q?DDEJGOF9nGOimt/JOaNRScWnQGFOY7KdU4Rd3lrYzr8DBetpuAWJqHvui8QW?=
 =?us-ascii?Q?fj152q0Ge6Kl6hgNxbnbmRBRQUK1cUMwacvZA5ToE35pwYl2OMfaNUjpsUDV?=
 =?us-ascii?Q?TZyBOnaAqQUnumxGlFF0kg4O+CmzUPTD1D+xi/cluD/hyxfIEyzopxnjoKWD?=
 =?us-ascii?Q?2tu10YKVnuzDNvSsR1zYTulmKTdpQBSV0CDmUYWrrUGooET+75owdRMzOmtQ?=
 =?us-ascii?Q?/8Aa1fQHpdF1jeGGBpSxO4aNymjntfQFUDm9hxw6wGSmhjTEncFtnvGcSOng?=
 =?us-ascii?Q?hXGwEn67hdpI92kVlc/kIf6gTh0n+mri9hTUj+HLuSn/62q2V06pfUb1hgob?=
 =?us-ascii?Q?vLf5COK5euAJBapxLpkjCPo4N2cax4qvEpKfSpb7suvGuDKhiABYOvvSzGQt?=
 =?us-ascii?Q?jk20TGuKVmaUStgrewxV/9DGa545iM4JSt7lsD+Zl6lMH2j7gw+RW6ix7JwF?=
 =?us-ascii?Q?J3wJfpcDOp1FpodaU0xH97vhcpJBgYnU32u63QRi5zWqCUM1qy/tb7sn1SYX?=
 =?us-ascii?Q?n7nyh86wqgIPl1AM/HzaKu5kYWTIo71LS2zYHONocMIc2T9U8JEoGRwQvo2w?=
 =?us-ascii?Q?AogLH0yi/poYEdP1cSbKdWxQrVUq+F2vRK45eixoGl4TlvHSirW/Tw89hPKT?=
 =?us-ascii?Q?dW20kIqVrd4jMdJwIsriaH00hzIw0at4p82pa+Pqt/365ArEY2ZvRaAX46cw?=
 =?us-ascii?Q?m9ya4IwBbeX3dlWy2JLGKD8Hyom9W/R+uvFrpHICvggaQ8T35cHL0CifwSz5?=
 =?us-ascii?Q?vBTGf9vci4iHHoZPIpQ2ygHJqNzbp0tIZnY8mfd3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45691365-f878-4e7b-355f-08db66599eb9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 06:45:30.5174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8fTF96h98S5wneolD0jNt7wiOY3U3BQvut6wpIq3hGrscG3eF4TfctpQ9d7laU6D50iq5FbcentxIT7h3B0Vnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7029

Use msk->sched_data instead of the local variable data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/sched.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index a053a9504dfd..5438a86e897a 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -127,7 +127,6 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 int mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sched_data data;
 
 	msk_owned_by_me(msk);
 
@@ -157,15 +156,14 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 		return 0;
 	}
 
-	data.reinject = false;
-	msk->sched->data_init(msk, &data);
-	return msk->sched->get_subflow(msk, &data);
+	msk->sched_data->reinject = false;
+	msk->sched->data_init(msk, msk->sched_data);
+	return msk->sched->get_subflow(msk, msk->sched_data);
 }
 
 int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sched_data data;
 
 	msk_owned_by_me(msk);
 
@@ -188,7 +186,7 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 		return 0;
 	}
 
-	data.reinject = true;
-	msk->sched->data_init(msk, &data);
-	return msk->sched->get_subflow(msk, &data);
+	msk->sched_data->reinject = true;
+	msk->sched->data_init(msk, msk->sched_data);
+	return msk->sched->get_subflow(msk, msk->sched_data);
 }
-- 
2.35.3

