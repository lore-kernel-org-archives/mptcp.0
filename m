Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2080.outbound.protection.outlook.com [40.107.7.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA737E
	for <mptcp@lists.linux.dev>; Mon,  4 Sep 2023 09:40:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtSQdoUG/TtIjIEDKwBtGWGEDfAmbmdy08VxIFgh0477QGhHdlfDbZjOVmbUFvpw4CBPjifOq1So7ioQXe4PVDmzca1uOmYjMcSPDwJSkpJVox9WOloLQ6XDlsplNpfjnVCWK+KpYAV3pl5NT214koONWW78ibki89aEFVhXSsSmZoxAooI87MwNBPKDdUAuyt44By5+DFtRWp52VbaRRRpsQr8/877p9XfViRjOtPiYW4KtSNQrKEAaBeT3dU8/+Wperu5CIOiYvANp5UaKUduvavzXvn6jB3QT+rKOnypD5xGLJtGJOjykCkcv6rzgrIcuyUUBwNLlW3TzRBk42Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdP1NqKdWSbJ7zHbsBrj4GVOHNZH0mGBPLuWFbRAxI4=;
 b=OrjmulxON6h16cqHnwsjNQicOP/BmQmSHE8HQbax9VU8VcQc5XuIQn5refOa6NS5xITnGhtukgTXffa72vVdNS9fQC5vbyqnu2/PbJISJ6hpYiwIpByhk9bjeRIHVI2VS9iGS2wZfDM8mJ28Ckr1nJ5oGycsMirbrCH58LnXgAacKZzb3j3EzakwYGRkCErYEb8OoggL3dyt6JdRC2FVODncLptTG05HE2HkHvoNN9A2G17idszJJvA2YU1ioJ1Hmx9KoWoea86BLn5eUXFSGimfNlCIkcAXsg0g00f7/Iy+fMrl6K3M+TbpjrCDn9Ya55Tu5quAlSQdquD5BC2zOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdP1NqKdWSbJ7zHbsBrj4GVOHNZH0mGBPLuWFbRAxI4=;
 b=a8Ov1YAXJfjiHdTvpIKAib1StMGG1cDmkMnt4fO6uvCE13tCe7/k3c2M5FyGgKPce5oHcm2XoWOet/Vf6V8lhExWszAzwHjY90GvJw+n0eMo6MgYeHJR0x+mejiJ0Bnwi1jAbi9aFc2nu7eMq6fwbbPzQ9e8NBUsjWkjVdtvdPbe5qSY1PGyixqjna99/Piju0zakehL9wEofNjQ7fVVR+x72WWNV64pii8xKi7zNMI70o1mxZBEVMvQ7Iv4VnZ3SAqrH8R8F4oZZ6hIaxyyUsxJ9Bj38bzkicDeZHjOy1AdybTvDhRerGkwh5S4ckGO15sE+RjACxs/smp7fa5keQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM9PR04MB7716.eurprd04.prod.outlook.com (2603:10a6:20b:280::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Mon, 4 Sep
 2023 09:40:08 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::a5bd:13d0:b0ae:59da]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::a5bd:13d0:b0ae:59da%7]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 09:40:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 6/9] Squash to "selftests/bpf: Add bpf_bkup scheduler"
Date: Mon,  4 Sep 2023 17:39:25 +0800
Message-Id: <77315648e218e021d96d8117fc11e52028a452a0.1693820153.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1693820153.git.geliang.tang@suse.com>
References: <cover.1693820153.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0299.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::19) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AM9PR04MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 86199977-2ee7-4438-a3f4-08dbad2aed5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bKtlyoHCibWbqOZqdR+MROk1Uww8D+KM999r7fwHrYC+XuM2efJ6sjD5PwGRK0qPosY2rQBY62CZ466kZlVw+zJxdwo4gxUSOcw6IzgnyAe3Q7xoRDA8V5hOKu682UI5+Npx9z1RlCut2wMRqDhq0Zw3ucYsYi1h73UimLW4FFiX1BiAJGqTVDrIx+Il4+mMXfBdD67MsrmqK13A2byvGKOgL3xeIDDX0tR7Nd9TIeYvV8tvJHTRCAV1yXmhTibDdrorAK9qxaXjebpZ4O2Pt09rjhbHxQUplfIIMKmmCabsS583f0XDxnSUEcnYLO8tBNPgrAP6IOa0i/drSxGT7/4stnvz7XG5DAiTCXazIG8LzkyMtUsSfz2KFu2ZUbuoLOgDigHCiFP1hmXv3Z8whZyNxBBkMUmeOetdppGeCbIaaEcqCfNHTTSRL5p2AzAfBlzNXqvhfPdWICD9ZOlNnIJW3K8zREvDqJ/mNpedXV3W84nrSh+xOA19FxN2nic/uumM89dd3zqxZIBVQRGY6j72iOxpVDSU/pU9KTJEk+NcCm9e1GTnmRhDZ5igb06B
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(39860400002)(396003)(186009)(1800799009)(451199024)(41300700001)(6666004)(6506007)(6486002)(478600001)(38100700002)(83380400001)(2616005)(107886003)(6512007)(36756003)(2906002)(66556008)(316002)(66476007)(6916009)(86362001)(8936002)(66946007)(5660300002)(44832011)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YFY/LV4G84NqbYxHVutufdRvMkD6NnQcORvA+4rhjhuKEoV/o/FRiol/Vwfn?=
 =?us-ascii?Q?mIP3XLa/FhNYasn0/LLrtYeEGDwcaIsv9cb3WTtAKVENZ73vZYrVjf5lPKW9?=
 =?us-ascii?Q?V05HtnnBDCm4gEvvpvAJoCqsOqoKpOftfjOMFbiUGTmOFM+lBp805ldFw9A1?=
 =?us-ascii?Q?AN1SgW3771XWpX5DYFK5lE8WR8KxZiYK1xBhBeZCHZ5Bnej4ZWN4gCUvg6PU?=
 =?us-ascii?Q?gAe2hhkyCkyKvvXDWu/KCi9YtpKo8g/LjnGK+YbTPRZ+E1CPzYb09jX1ZhfD?=
 =?us-ascii?Q?OiCZs5gpcPjk8dINoaU7FkiiB9+EH1VQ2TVxI/xMKNxqBiWwvSRAvFyzV3vz?=
 =?us-ascii?Q?09il7PhVypgVO9GC6rHd1jPtgAgQTHxgGPZMbOxrVcFzYzPmOkZ/tzcpi104?=
 =?us-ascii?Q?5ni1Pqgtmk1uZmW8z6fABgWnX32JrK/QDmNs2526f13709fNFovo81YmmyZp?=
 =?us-ascii?Q?YFE8XI6SKtmLMSJeiNdEp2i0oq+rqV33Vf+kiZ6ns/nrD/MeZNwIqgehJNUq?=
 =?us-ascii?Q?mpWz1SMRYyK5ZRm56jYaIR/O2Od47eDMnFH9FYivHQlf0A9k7NcqShFT9PW8?=
 =?us-ascii?Q?pmb4Dg++rShTOpKnv5rdkKq3vDTo9dzC7FKHaz/q3oCOZP8D8tFMCONsOtYX?=
 =?us-ascii?Q?bn2wqT7/xOjctrzDO7QUk1G6TeziYpAQeGFRJ9x+ieAFEB3avzXZyRL6wE4y?=
 =?us-ascii?Q?DDeN4vpHUGlJQVaXtTyZ2ZFZLXHt991IRk+I+XDEpz+gWciGIwWWHbqpAnMU?=
 =?us-ascii?Q?iuel0Zi19HNi8/klEvt1G9qxTtYcY9VBK1JjLAuU9dgvAqG5D3co9KuZPZ5z?=
 =?us-ascii?Q?8qJKCG5EYb1+aJFdKe2zoSTxpa+E7piDxEq1eUP27KIn+WbirR3eV/dCcjie?=
 =?us-ascii?Q?EbAfdBcsJWWtZ7WBxa3FsgLwVxrsIn1Ikz/WLSo40eb4HEvWAZ8ZJSpVxIAc?=
 =?us-ascii?Q?ex3GcAGBw86tGrz9nRQ0y4TS5Z1QC6JmMI/Jh6zD6/qNf4JF4NyUZw6yGiyK?=
 =?us-ascii?Q?CggR10pWiaPIFupGIjRgysjW0u3Vq+g4h9fGRLnq5eyBUAKMHFzO5oxJVZq4?=
 =?us-ascii?Q?RtsNOrAMblUEWiNyMWG5dTkt2e+uQTNr+pVqkfpb3Za2i2nVdaezpowO5Htr?=
 =?us-ascii?Q?miFn8qvedPujMN/x3jB/Le8IeD0q9Qd0g7Aov8PTJv+SkS0Y9EO/taxMYO7I?=
 =?us-ascii?Q?FSxaS37RKHjopHawYUayiLt6Ej0kxS89dInEeYYlFyTMM83ygq/J3IIHhuKa?=
 =?us-ascii?Q?9SlMzees6UfaeDOY5skmcrX30j+/LoXQsGnN4siT95hrYClnOSFo4+xsUF3O?=
 =?us-ascii?Q?xlVcbW0d46n8gDZXRa9ME0bVx53z1eliMxm2kpUTZ7NaNgd59vZrBzEkSJmO?=
 =?us-ascii?Q?F1HK9ZORxlKBuWsnxPuMowZmdJ/PGkIUsQzeIsS2/Rwyt9QJoS24Ik8W9qJX?=
 =?us-ascii?Q?5qgZwRbvhRzic1HBY4pmzv18mHZoiS5iw/hag2T/Egdfx96dtA+651VP14f2?=
 =?us-ascii?Q?VeVdCpBBl9uDj17kHkLSYaM0NOJq/I9QlUe0H8mN7xU80t54Tdosepeky77o?=
 =?us-ascii?Q?U+NHgEF/fxvrEdiv17iMxOruwMV7QSztFqQ7gDW30avW7CaaWZT8DxyVPtLX?=
 =?us-ascii?Q?R5xL8KpBntCjdrIlqXnSKmqJIrxXzgYGg9rNZIPLY5EY?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86199977-2ee7-4438-a3f4-08dbad2aed5a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 09:40:08.6237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tv12vUT09h+jT7qa5T6jGiq5XFYH54y1hDetYyE+KiIbtP6a5jSAM7B8wvI7YeUCNW2FInRPaCactchZ5n5EPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7716

Update mptcp_sched_data_set_contexts and mptcp_subflow_ctx_by_pos.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
index 904186fb6750..bfd4644dd592 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -21,12 +21,10 @@ int BPF_STRUCT_OPS(bpf_bkup_get_subflow, struct mptcp_sock *msk,
 {
 	int nr = -1;
 
-	mptcp_sched_data_set_contexts(msk, data);
-
 	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
 		struct mptcp_subflow_context *subflow;
 
-		subflow = mptcp_subflow_ctx_by_pos(data, i);
+		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
 		if (!subflow)
 			break;
 
@@ -37,7 +35,7 @@ int BPF_STRUCT_OPS(bpf_bkup_get_subflow, struct mptcp_sock *msk,
 	}
 
 	if (nr != -1) {
-		mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(data, nr), true);
+		mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, nr), true);
 		return -1;
 	}
 	return 0;
-- 
2.35.3

