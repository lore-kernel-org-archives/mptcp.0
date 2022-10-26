Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2077.outbound.protection.outlook.com [40.107.247.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026A27B
	for <mptcp@lists.linux.dev>; Wed, 26 Oct 2022 08:05:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZ3UhCfPJLu9GoG2G8nVYPh8InyVmIdQfaEv2NUWItvaieJzSrv3WdQ8veZ17aajbtMFMCUBY8w+gLE4+ThtHCd44JXocqfIA45ZIKDF1oykFama61FyVeNH2fC1lPL3Tat0CCVsT1nya81yRM0cj00W1IU6hkFCX9WPCk2WF79K0yxu/pF+7pAouaO+IWwzJPMo5HbWORvD193NP/1slDPjT+yco7Hobh0eBCLT1pFvyRjDSCaBfHoh1omw3jT9DV5H3/jFoMS4fI/dAC1OoT8ynYQsOC+E/IocBGn92+GkTblSnVZBe7cLJ9vKsrphGcc4h3pSOPNGa29cul8A+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/4/JsCXP+/OKQz6jjCp+OtHk954GaICx+c/+SeaJ/8=;
 b=GuHxSk/MmDjTmurVLPDMfZbQ0f/xhrWfFAzqxMqFr+EpAiJJdRfrQPjpDZ70/UgXYA0xmGL0tDhLZBDxMop8LBKdlbvDw+PtXLRK8U0NlXJwUMqBwQHNu2z0JgO6IZu93WPBgwL6D0rNgr8atAS8PaW9v7VXFsQ9IF4eUu03RW0KsMPYNEX8PV0nxE14GktR7lbwytYNJldg7cgco87tp44FXoBm90dR6GhUyrl2YZjYhk9TAABIrp48FnMOOxG53fQrRZSQA2Q1OH/vHOdOmHmwH2GA3TTeMx7/zOkSNN9yMqR/XXhyrt+NiEXtJ98FCpjP5r/QMn0urwX5B3IVew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/4/JsCXP+/OKQz6jjCp+OtHk954GaICx+c/+SeaJ/8=;
 b=Yq5c76osE3+eVslTMk2KrdFC8lJCkmAJncKMa3aR/AeT2qQ29H4II62j+dv9HBABcePyE4W2NHORW19NahG/yfg8HlK1y+XLai1DSanHoedLsIB9QXMgbOz2F+jCcE3sSxFd3uWyjwA7DjioKliuDItudqGjxQoitgHbwBNwLrvwIaAq3QulwkNd3Tak1P6pfdhUPZNLZWcnstXLz70PqEDkCprrGSqbBCRkIXx/7bjFNOjJNLfuSwMxhK4OQhYeW2GgvuVar5oy1FOyJi0UPjo9i8PubFtaRrvgnCoHagJ6sPCCA9nb4DjqnG3GHGrcIn6QBq/XrkHpzhu1LkrASQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9219.eurprd04.prod.outlook.com (2603:10a6:102:222::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 08:05:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 08:05:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 03/15] mptcp: add sched_data_set_contexts helper
Date: Wed, 26 Oct 2022 16:04:12 +0800
Message-Id: <f99562761392fd8f88a9aff297bd0c8c021688e6.1666771065.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666771065.git.geliang.tang@suse.com>
References: <cover.1666771065.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0008.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9219:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c40c384-b2c2-4f7b-97e8-08dab728cb36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rK8ln0vsGNKBAPokNsg64J+heNUs4LHz9SerrJV0FLRBhNGU9LRHOLV9wFygjl73zEULezh8rUd54CbRdZjEm5gA5HpCSjYRL7LTi3Nj0fLvZMTkccfdmibMlKKJNaAM6WG+CC81HuOqOr9MlaiUwTyr4ZOPprfZ7sDU6i9YvblIO2zM112mfUdXqQM6Kkf8fdVnw3Gp9R62nRroDTE38TpkASVdm/HfVIL6P8o9NTX2NAx3dE/ZxAOyIpSPY2QsjZ6T+jigFme9Vut2RBzRU3NMQsXxKr/99Spc5kB/U6g5nx+NqS/RGaUOvs+cRXr8mU2SGdmPxSHbJpWVH+lHHO0UK+a+brWjYPySRg82BbXNG6PvL68ATfic3V8/mHbfuujMm1zD7HjxF2je1VQ00FDOt5WHpv6Or0hZFX8AboVyGG/89DEfr+/JQxoPEOyykdoofDXQYI3eRXmrRoTqJ5wcjjPoK2fSCQ8gqnfZrO/iPYt/L1UjQ76zPDJYjMUfxW06pXd6Fbvo8z9HYirO2VXYJOFC/MXU6mY2VQxNJyi705NqhEBn1UnEGFGaIf9BW6GyKFtpIqi43CjvEHbd6atJl7Zft1tdCyBVjgcSKgS5rOfMnfP5/eOHO9NyAxsss3pKzpD5npVnhSTyiUfTxQwgWWdbFTQSH8UCriFtGb5KjZm4F6phltiR6UsxI9RC06HCTNoxAQMU0pCGM5WqpmGZKGkrI/DmhOPNZeceGdVhtidqS907kKsluofG5vpe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199015)(36756003)(6512007)(86362001)(44832011)(2906002)(2616005)(5660300002)(186003)(4326008)(6666004)(316002)(107886003)(6506007)(26005)(66946007)(66476007)(6486002)(38100700002)(66556008)(478600001)(6916009)(8676002)(8936002)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?36gJ9Vq6fQOflOZX/beHqJ8V/1R87NWtZecWV9utiNlQ4CLFBBh5NuqLlVaT?=
 =?us-ascii?Q?Q63ffqEBYFB6eMTqSTuWzMDPX94SF+SonNRHh5rIGPEiHOsMQNszwr6KqR3Z?=
 =?us-ascii?Q?YAfTqBh2MHMAdwY5/5XsdhLF9K2Kg3Cv2YoH3qTRSPWMvU9CKvjLPE5Nt+ZI?=
 =?us-ascii?Q?pjwHSAJvNyj8diVswaZrpr40oyuaIMU/D6agMsBXMqgoDS1HXv+NEbP+1JY3?=
 =?us-ascii?Q?uXY2StUzN3GzUw2zCZlv/1/qiPEUuFPcL8bCSdd8XCH1pz446qJ8YRTJGC3G?=
 =?us-ascii?Q?SjUMc5F/JlSFZFJzz4DJeR/y1d4odXqydpJCuZ5mWBGBu7+GrJnxYqcDkae3?=
 =?us-ascii?Q?hOC2AJHpFVyP/EakgKiif8591p2f5I+XzGD1MANoezpBDSBtwDBPB4/DL5KV?=
 =?us-ascii?Q?8II99DF3zoM+U32CK5r5zSmXgakIFgZtXTP0JsACNlNXPXdbXq/wluJYqOG0?=
 =?us-ascii?Q?HuIE5blWmklAo8MDB/vHkdxruR/DB3p480kuoFdph5TAt40ao4n1Hi4+81Td?=
 =?us-ascii?Q?0f3R0YeMsuxJY5l3Q5MDLdnSH4BgqGp8eS1EJlwAS4qbQGhqI8iQdaY+YkGJ?=
 =?us-ascii?Q?owJqB+0uScdsG9v5ltqiIQuTjcfwWWh1Idjebs/JgmgWiU3+qHrLgxNSridl?=
 =?us-ascii?Q?uN1vHcT2xxFcmCXRtDqa95bqJ/82peKia9GGGg4RdfkMaLBgn6/kjGUnV5pL?=
 =?us-ascii?Q?Kf4iUrD6a1W7cSaDY3W3zLZAsHWkkY33nDLj8QhvuqAvOwFxlJQqkK3sgsAx?=
 =?us-ascii?Q?xVEFiFA0pajSA4gAfYbMbBPh/kr97vqHBGJHAayN2Azbaqq3o7+YbpWjgN4j?=
 =?us-ascii?Q?NJ9oMe/UO73x7lW0lyIQdOxbRgL4nTDJKD8ho763NSskZeq/3l7+mxwCi871?=
 =?us-ascii?Q?88hoQWRljxxZwEpy+UQd/LfW7V7bDb/xdsT6WNOTeSFmd44eVZjFr9bX+oYm?=
 =?us-ascii?Q?TG27LiOSc1E3pSUJXUeQClidENI0E9tARf59TWj2bXsQUqgjlJCm4DA6X7kI?=
 =?us-ascii?Q?ysfhNlu2kQTXfdZojTJPuTVWC4xnOyUekB5MwmI5R/E1Ocr22DrEnr7vsjPB?=
 =?us-ascii?Q?nBh3aPigFSROR97tafGpI1FafGnR86pJsC/zJV2o8NsQ5irC3I9t8la5Vgdp?=
 =?us-ascii?Q?W9Y8utJ1GmPGpNc0xe8HJpNOBUz9JAVCQjx48Uw7orEqYQGc6Qi3tV/WvoyS?=
 =?us-ascii?Q?0QpxFlzbHmlgePlIhD8DZDSRYfCWRDKniYM+xhY4TFBJrgQJh7yU+w0qN1e5?=
 =?us-ascii?Q?sYuw5o6zoBY+PNNHxh5X32iR7ck6hQ7JW51ZJRE7GvF5ABw28t8K3pAIf2Ar?=
 =?us-ascii?Q?Z7rgooNdzga8VzKgn1Ugoj0SjBbZVQWLIoszkNSlJXUjQ8KXRYBvsaH0XVj5?=
 =?us-ascii?Q?l2w/vF3xWNXup9FGpR8jxyDp8FG+D1pmtF4xgz/zdmaroOH2+D8nIm/tx1Ae?=
 =?us-ascii?Q?yTPCwcVCMZyfm6mKjmC/22IUYBfXT2tkQz4FJ8OlBPAGyWt71qaIQhxXluv1?=
 =?us-ascii?Q?TIaUBWKVUZeR7CuS6iWWgNtcDW+L6niRNmT2WZ0E9q35kiClcByMYyaQAGve?=
 =?us-ascii?Q?Xt1j/vuRhV8jP1gEcAnnAy4i9LmOhaBueB/SQxYG?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c40c384-b2c2-4f7b-97e8-08dab728cb36
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 08:05:06.3367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bU+dWnHdSPXEcD3KKFd66duR2mq8Ykj26klMRIXciqZoa+clkDCTTBaNEwsFdIMezN1Kdr0++Lm1c0eB5E4SKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9219

Add a new helper mptcp_sched_data_set_contexts() to set the subflow
pointers array in struct mptcp_sched_data. It will be invoked by the
BPF schedulers to export the subflow pointers to the BPF contexts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/sched.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index d295b92a5789..5a910da1452b 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -93,3 +93,22 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 {
 	WRITE_ONCE(subflow->scheduled, scheduled);
 }
+
+void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
+				   struct mptcp_sched_data *data)
+{
+	struct mptcp_subflow_context *subflow;
+	int i = 0;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (i == MPTCP_SUBFLOWS_MAX) {
+			pr_warn_once("too many subflows");
+			break;
+		}
+		mptcp_subflow_set_scheduled(subflow, false);
+		data->contexts[i++] = subflow;
+	}
+
+	for (; i < MPTCP_SUBFLOWS_MAX; i++)
+		data->contexts[i] = NULL;
+}
-- 
2.35.3

