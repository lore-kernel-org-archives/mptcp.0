Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2089.outbound.protection.outlook.com [40.107.104.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10F9364
	for <mptcp@lists.linux.dev>; Mon, 28 Nov 2022 03:23:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HarM52IYNo/Dmnext30/80v67WLAvMNDjElmxo+P9jwIhWMsjQWD+0+4kzV3fGn1VcOCCx8WtOF088XH3DmZc9kYaLfrMbwNqViQ/5sEGCuk6oNmjsgcJGYtq0uzFyk0SconUQIcZAM2aW3MorOucHKJSPsoY9iQ3xi81tshWdM8zK3B4L3DVeZmHEReGDVpZ2e1waYOGkvFGAWbfghgjjDG8tDNVRZZyKKH4vqxT5NE6y6ENV9r/LQi2DxTu7k8EcLeVolODgu1F+3+tSCpZ/wD1psO1y06q9Fcx+Ka7PFrzJXRRwixzPDz1DOB2+0kGFe+Xew+aasYcO033gam8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kz9q0gJnpVwfDpXUYlVftmGAroFYmhWCrjPWKzh9eho=;
 b=emju2M92fxdOiGTG4M6G2TafVU93e8TbIZb6pLvdRIncON0RSR6+fK6pSMjwU7WXamEn3y9FV1vkCUvv+ZRt2z2wlXDGUvqFNim+YRgiduPbxGDAhK4K1dTiS1hhkvnZiBN0NIAC0TPb5y5GU7EX3mAtcp9Vp2HjQDQhgX/fkJ9ybxJB3VEZUg5xuwkj53FAbVouHvHiT1yde3aQjYlUKw5OX89p5LodEDEHkxLq/GmTjVS3ymLWrBUXhnU1NbodkoYnTNlSbc61/uKQPt1ZLnI2EhMS3UELY2JAb8fCZJx2nJS+4DbDmAZqJCk4RrDtVRK6h8YFingXrN9Xag0yeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kz9q0gJnpVwfDpXUYlVftmGAroFYmhWCrjPWKzh9eho=;
 b=h1D+gKDjuqvodjANtS2u9iyMnErjLlS0Nc9wxSSZ5rfnmKbFBBytqZijK+F5lyS6Ykjxzvb9Gk+smcMiOKyITjIh3Czo1tEtfKnVyeWjjJQAv2crZ5gkLAzkDd9RpdLa5HTyuFcm95jB1QndLu5RIDZm2rsvNKN3Tss01UsoYAOUBc5edYQMXrrIQx93obnBJrkuhXzDFREto33W+UBGGgYPB8vss8+WyW0wdK/LlkmSeJKrO5gAzX/pJfOfkNcVXYsk1Wc/wsyiKDk59D3cUOIxZ+2ZkOTXgAxvpinf9t1dkbGwKYO8qWAe+wkgEd1omHUXliPAH3rbRyNfUIhgiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8272.eurprd04.prod.outlook.com (2603:10a6:102:1c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Mon, 28 Nov
 2022 03:23:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852%7]) with mapi id 15.20.5857.020; Mon, 28 Nov 2022
 03:23:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v21 1/7] mptcp: add scheduler wrappers
Date: Mon, 28 Nov 2022 11:23:57 +0800
Message-Id: <8d577acd5a20231d75a8ff18572c88a0c03e35b0.1669605531.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1669605531.git.geliang.tang@suse.com>
References: <cover.1669605531.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0206.apcprd06.prod.outlook.com
 (2603:1096:4:68::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c21b799-4962-46f8-6a2e-08dad0eff140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h5GVZwr9kuX4tUPXPHKZr/PT7ZiDkKYe0dMkaNsSd5QpqqvtKetP7xgCCD+FHEawSZ0HqsKZLlm2pb5IhTUKYB5fLLCFKRkEapqmTKugfkC8o/v3XgOYQOlQji548igQ6SaER4ZnsfC7MUgaOGeyBQUScoxnxzAsFZzfBsDroYDlRGwEEgoXY8Kigx3fiHkTJ433PPl+8gF3zW/U2+9kgXz6oLf8B48ecbOgyQ8yXaaFyc2oO6h8oMrX5LJtgV+ATEt3oG6atlnR21jeL5N/ocdoBH4I4z8/PYtwfQ29o3cx1d6Oz76JFY8eBOrDPzKAoaD90xxu68PxU4fXbw8Xq7hqwkaf5NgkRb45Q/BarfhhticV8vfSZUKsrtD1S8mpS9GJ24olHunSiokwwRD7aIV37bi8XfrJ2hOY7d/LT0tXVs0K3J3x2/Ct6kn6v1mc490C3Rz7Aee4LwnmeaALfzZGCFYy/QhcRrXUiT6tMa3aO6i9Gi/BHWNdTv92kBBUCBff8OVadzdo6q2b/MtgA7lPpRgQbuPCK7rjWiVwmYTI9LJCVMCWhP1Rx96jYavb0VLKDuJZ/sTimANQu5YNXA0cC07Dbd3l3HwUN67XGWb0JbCPnceHoiPhM70SZun32gceQp2fKb0xCtIBhFcejQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199015)(36756003)(6486002)(26005)(478600001)(38100700002)(6506007)(6512007)(6666004)(41300700001)(8676002)(66476007)(66946007)(66556008)(86362001)(4326008)(6916009)(316002)(44832011)(5660300002)(8936002)(186003)(2616005)(83380400001)(107886003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dj+GnRPOAOX89T6A5SCQwbrbo1vfoJ/0mZasDQHuVvfpVgXm3IDLt3qwSI90?=
 =?us-ascii?Q?PdFqSPMk6QKSeVTGCBYLnLVGVYKAtLvLOdND44404beMXbzSS41RppAto8rp?=
 =?us-ascii?Q?Qx75aDiEQYLjPsrKuaVyV4YkwhABK6WrLcGsP1zfq1E0I0icI+9SrzVsCk3l?=
 =?us-ascii?Q?l4Px8xim7U6qD7tmsw5p5U2PXADkpZZmFuBxmBhY5tRPgWxFrxcRA+Kr7vEZ?=
 =?us-ascii?Q?AIHOxRhNheZY0V2ACn+kj/jMTqdA0xgrUPJLDIpMeGGxRsX5mMOwF0JVQ156?=
 =?us-ascii?Q?mo2UO+ES4lYNoUCR7HtW6nwXTfn8Dvrbso9HB2GpkdTVG8eLPw/6fFhKccAs?=
 =?us-ascii?Q?ThHWTFv1OOMjNpDR8LYh361nj2QDiqJ1xQSobuPTPjB9BhH02vW6zmXCoLyX?=
 =?us-ascii?Q?94RHXvNGl8YvaGlYQZao5VwxXMeCjQl+62/fJYjnEMhyxvCuq/SpCShbnIt0?=
 =?us-ascii?Q?+XY1O7ljFXBJoYjJIcVDfMc9kEASbjl2GmV6ApocRaszmfXkngb9N/4wwVUs?=
 =?us-ascii?Q?mIX+hn3BRxBsjOiXZ/QNACrcHDJJ0jyKEvvSZ3V4JxAaoZeynai34pQq8tlf?=
 =?us-ascii?Q?KIfebS3npNm4flsycssjV7TWCAJi11nlfmvad12xxA3MKpZuPc7zZeOdVSlP?=
 =?us-ascii?Q?G86vP1YWDEIabVmWfXrH87TQJbyXPHDV6YtaaBz4W5OS9b4FXJH1cfO8bPQB?=
 =?us-ascii?Q?99x3qr34F5ONWz+9UtPqGrHxifUUFMyLnQ4wmGFGzAXHIS7onG0TdsT8X0rx?=
 =?us-ascii?Q?wvgtzmCyNj6Mujo+8WaQVzXzKzWLOEP86lPH4w5rKmst/w1cIEa5p6rzKf1V?=
 =?us-ascii?Q?mpWFtTxJxXVSeaX2WwcTktLJaTMG3wH5/3QSCr7/N7vuSKHiE/x6ZyyoWsOY?=
 =?us-ascii?Q?vWcFFGqVXTj4WkBe0d3x65aSYqSogHyCVbBpSLssvduQeRyQN5kQzHUR9YrH?=
 =?us-ascii?Q?a+351aEMs3RbOP93jofUiobwMcLxu+otlWqzIdO5XY46QRZVelXbQF8lJ4JZ?=
 =?us-ascii?Q?K0qETsDTkWIuTB7GhbOyPvCuERjlW3gwINJ7Z+jhB0RACc6TkIC8UVe8+upB?=
 =?us-ascii?Q?Ip7/xqzoOfOcrOVBHqVxSy4po7WuIQnKhnJB9bCkigIzBdOPv7i3uEKpWIlF?=
 =?us-ascii?Q?QH21C20l8oTQcF3j+r6gRIbptVgvU1X/YfBcU8GzqJWQJjfzShB3TmF/ZsZA?=
 =?us-ascii?Q?/MnsoYpK86ggpLVSgEOBd0C62AbjLSsv8YDsqBtIFZNzD2GaeUIdk3p1Huob?=
 =?us-ascii?Q?I6QUsE1k/YJrwtMMmMSMyVCXq2Nd+R2PYn+0/F8g1tjpsHrZieEGY+bFX7aH?=
 =?us-ascii?Q?ACrPskTo7tFVM8wOi6+RpaMDJ0c3lQPu9CyeiM5P2AaTdP2zTh4hjXH2DSHx?=
 =?us-ascii?Q?QcPQFPkgxeRS2TXBGd7CqdybaVd5sSnZZrs6o3BNViALy3egXeqDid1mYegN?=
 =?us-ascii?Q?5Vl0L2fswU2v6RwuCgldw9MDf+m40I0CKzvNTHHVYqa+5nyJ3IS02zpkUr+6?=
 =?us-ascii?Q?X9CmHD66vEwUwkNB/H6Uxrs78AueadR123fWgkui5EerY076mzl6FBzRzEl7?=
 =?us-ascii?Q?KE/vgFd4ZTs70L6EBFIEujn9XC1XuSY7Hjb1xCSPftMl1TQd+WlzrZQau0/J?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c21b799-4962-46f8-6a2e-08dad0eff140
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 03:23:39.2294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9fMH6ddqf0nsBWsX5Y8OERBLKJGsKA64ZSERSgz/BbdZJVAkKjCwbpgYn1WOwJDFDoFOvZgezJXQVfXtvs90Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8272

This patch defines two packet scheduler wrappers mptcp_sched_get_send()
and mptcp_sched_get_retrans(), invoke data_init() and get_subflow() of
msk->sched in them.

Set data->reinject to true in mptcp_sched_get_retrans(), set it false in
mptcp_sched_get_send().

If msk->sched is NULL, use default functions mptcp_subflow_get_send()
and mptcp_subflow_get_retrans() to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  4 ++--
 net/mptcp/protocol.h |  4 ++++
 net/mptcp/sched.c    | 50 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 99f5e51d5ca4..d8ad68dd504a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1397,7 +1397,7 @@ bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -2213,7 +2213,7 @@ static void mptcp_timeout_timer(struct timer_list *t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-static struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 {
 	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 224f03a899c5..adfb758a842f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -657,6 +657,10 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 				   struct mptcp_sched_data *data);
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
+int mptcp_sched_get_send(struct mptcp_sock *msk);
+int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 0d7c73e9562e..c4006f142f10 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -112,3 +112,53 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 	for (; i < MPTCP_SUBFLOWS_MAX; i++)
 		data->contexts[i] = NULL;
 }
+
+int mptcp_sched_get_send(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sched_data data;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled))
+			return 0;
+	}
+
+	if (!msk->sched) {
+		struct sock *ssk;
+
+		ssk = mptcp_subflow_get_send(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
+
+	data.reinject = false;
+	msk->sched->data_init(msk, &data);
+	return msk->sched->get_subflow(msk, &data);
+}
+
+int mptcp_sched_get_retrans(struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sched_data data;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (READ_ONCE(subflow->scheduled))
+			return 0;
+	}
+
+	if (!msk->sched) {
+		struct sock *ssk;
+
+		ssk = mptcp_subflow_get_retrans(msk);
+		if (!ssk)
+			return -EINVAL;
+		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+		return 0;
+	}
+
+	data.reinject = true;
+	msk->sched->data_init(msk, &data);
+	return msk->sched->get_subflow(msk, &data);
+}
-- 
2.35.3

