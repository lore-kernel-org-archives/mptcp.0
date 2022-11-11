Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2044.outbound.protection.outlook.com [40.107.249.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFFC652
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 07:48:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/vuRBUB2gfKlllF6dI7oaQ6KgVo0+AaevD5prPBZT0X1HleEdTtZtWXpfy0Q4qj+2oIFfvN3O4VeHyVs/RU/uAg9PuNCrKRdEAN1HPL9uNvALaq49eEBWDXWN7Vs1KbRVqlNPBD07KG6EriZbpVmMEqopu3YKce7zMefcwwbvsdeUR1bgBX5wTiHCMjL7IJEyPCHQLiEDVAaDwd8xW05Lk7KQDmO3+4K+khwFLYzPza/bSNBLL99VC0V5TI4b214VCsWghFjVShXz83R88w2VjwnbXy4a2rkWvZP3IN/80KT1n+VGNkv3BeZwPNy4yb4WY/MvIH/gjIbWVr3ldMjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/4/JsCXP+/OKQz6jjCp+OtHk954GaICx+c/+SeaJ/8=;
 b=R0Yh4GyACPUYcHCMOXL0Jdm8f6ltKe03yhTux5SkPKm7dX1+g55EeKTAkocPYVICwlZQcw96QI3ZOzmmScloFUYJsVoUWgZG3OiFIXc0qyXVR3M7LkqDn19nkfXNzf08CnZk8gyx5PLjOhYlqH1xGdFEsxCOOW732EJQiDYY+xPwBJ8oV+LXYuURdhR59jMCXJBfsq0ATKCINzVJMixxU4CLLCFmbfTrQGFwvk4XpTelS9WyuvwParswDXvpEqkccQpXK3lMOxjybDQ81M4cgJQsIIPNI2npJ+FNrGLy1ULMJm0aDdx98gEwtPQikejn8/SAlR3ELiMaHu2a4MR/lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/4/JsCXP+/OKQz6jjCp+OtHk954GaICx+c/+SeaJ/8=;
 b=h62B0/m2xDoUVRuLcXGSPakrRgfwbTAqJwFHuE7VXmCztXF+P+ipzIBLry1O7zWlTBCWqBpzwQtJ3mIupkV4m/SdAIlGYNMSd0cYvPudh7YIhvZVkKJuJQGi7NWqIf6WQm8DbNyIlYIBcT8RRogrIbFjCS2v2Iex8JUxyX6hxQkj3VEfgSHVOGbtsxiyeW4WLA5fBCdv4DfXZZ6B+CoiFkmNmvlIc0WXIHY7+yY83SjqIFjlkmRZyvl/fPmMFy1rfPe0sZg73yDDF0slwO7Vi9IUu3LSGblsmGKv/6dsPjO235KPg9wdZ7mjpLD5T1PAUBInXgj49smk6/SfeOGYkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8230.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 07:48:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5791.027; Fri, 11 Nov 2022
 07:48:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v19 3/9] mptcp: add sched_data_set_contexts helper
Date: Fri, 11 Nov 2022 15:47:58 +0800
Message-Id: <5ad9715e09a2acc245c7a504b086d6ff33b40a7e.1668151131.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668151131.git.geliang.tang@suse.com>
References: <cover.1668151131.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c72a4ac-6d5b-4cbe-1137-08dac3b91ebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pfDVkNmlMScsrLIaeEv9bKhiC59nOZzs8YpRonvbxzmc5+0mT2SXlLYHZ92VrrmKuM9NeVIXtTYSSg9l/16dc/GoMfB8awdXPaKtt69C8pUS42ScsgSE9NMNdsacbSUtFOAFD2Uj5dA9YVH3PU4aaLX2qTZcYBqqD3wmmz5f6EUssOcLEm3o9B2j7MuVi017zI+1dHqFfxpHIWNerBGkQyKiiwhUovCL/2QI++DoDCSCyE/A3uDP7l7LEcv8vNkS8UcQV+OLCOueBzyT+VNyg2nPbF1VPeV0Jx+LQYeqvh2m3KeRnrT7IZb7BQnquh5PZCjrSSqMsHgex1iGa4QePlvJ6uUt8j1Cw/oF6ucPmLF4zLUKpN9oSwjprtjGBnfvFVhPiIDivd0SKPnpn5HbnmP7y5mlgrwXqME588VjFLM0NxCyN8yZ4+OZj2IWfu9LA0gHD6GBNwj1ScGwy2HVDvX+wyf61cSdmFYvPFpnl2E4qNKJjOkD7E+jB4fDfbYvc7W9aUWwNPAXD5aeuWuq6HK/kUvoNWtGX3tPFJN9omnKy1Sw/znHsxl1fz+l2itQySSubUiIkcDGkWKs3Hc5yTfOnKMCz5a3Ykf2mmJROb1tz9aDAXlUbeislKAbLiiKLa6APwiA5wbTqsduKBJKHwVIGSsC/vPhRwtLDlkWh2ZVTUW5xrpTAQ7N56fdgCEvD0bVscL3gArlfi7MbL5fwg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199015)(6506007)(4326008)(26005)(44832011)(2906002)(38100700002)(6666004)(86362001)(107886003)(186003)(5660300002)(36756003)(6916009)(8936002)(66556008)(41300700001)(478600001)(6512007)(316002)(66476007)(66946007)(2616005)(8676002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nCbCcgdVGQpBsnhh/VtURvvMh/7aVU4m/kUaS5hKW0ZR8QFBXWaVp1ozdSCX?=
 =?us-ascii?Q?12Q76nv2t2GhJZeZOUwtQAhtf4YPiR4zhVJtM+aGV7qCX4Djb0PQuIjyyl5n?=
 =?us-ascii?Q?g2R6morAt6zMAzcq7hzv3BpRcracxmDyIBersIa26OLpTybtSqociNcukmSj?=
 =?us-ascii?Q?d0GL9Fr38hpOzQKTvcZHxdDiy/tezJnobS59q3JprSPSOMw5kW0m/x9qhRjm?=
 =?us-ascii?Q?1N8ChKpaM/8bz09iAHrLOSTHMDNsimf6KtF1kSvFlsGzrk+G0lgAv/Mqcv7E?=
 =?us-ascii?Q?fFf4k2YiVWoVUCLwzwHSeHUHslljt1iQwNnOWNSt+Qe8m/iAfJJMxAhpjnkt?=
 =?us-ascii?Q?Nw6ya4ZoB/ZeqPJaH1/+NQ8TjIkQoziBHYUfsZcbw6QdSHS1iJ7zUStya8G0?=
 =?us-ascii?Q?TwBxQAe0eQeG6znSZCxkX8PnHBI9fsm8cQ4rJKOnIC0tMBsDvpUzbAR9/qj6?=
 =?us-ascii?Q?EQxxtZ1xmJBv163BQM4OHnyqR1Zxf0+qfbhExlI/HkBt8H4tsqHkpIp6o09m?=
 =?us-ascii?Q?y7UzKhqTt+lAOPQ20k4LTe4j8FpwkUd5UZ3KKGMZP1E1A6ceAeNQkp6OY3LV?=
 =?us-ascii?Q?4HSnFpS9KL46mZfo5hA7FY6szj1AYDWkw5gzlxjDaz/D0o+k2L6vNTgRxbSZ?=
 =?us-ascii?Q?8AD4dZRA3IWjS7RtU/fxBAN9aw7cvQf9wXcHR8cfO3v6u9zt94A6jij8HzXZ?=
 =?us-ascii?Q?FRcqv81uGgWYsbagWuOb4cmaZZ9hMA0QplIO5W/eMED9dC/qCpEddHq5PE8f?=
 =?us-ascii?Q?WngTlAnVeXPfgh6jWExZESXvD+ReiYQRNDGdSMCQssNmkxE/LvcYlyL/5dNG?=
 =?us-ascii?Q?oDjiiXVnroyGPdS6Sm0eK3EINSAxjuXoKLpRAzkLNRhRNlrSo5UK+ncZX9xF?=
 =?us-ascii?Q?I2b6WAnID4+FDLVBaUJsoJ9Uh2t+U6hcLHLW2RAQu68ILVmq6aVLbOmweAlf?=
 =?us-ascii?Q?Ld+sgMETUqzZVzOZCDQZHovh9amB4fPW/kInDjvlK9NQfb7spPnViO3NspN4?=
 =?us-ascii?Q?rYM7eB2pqJza/majQG+htDoUrNfOb9YrSxyPsvoJnQsuS871kIH6ERG9RUOo?=
 =?us-ascii?Q?LYXVAVn0PHCWVqlG7RP+XmyBDZH4yO+ZFPC9R4tQUu6PnRPDgx4p1fULK0vl?=
 =?us-ascii?Q?Rgo+Zf1mQmT5LKdABMKSbYdEntHApo0BQr3wfBuUK9O7puhNqkZPAD0BguER?=
 =?us-ascii?Q?UUtw6VktCXlXNlJ+HOEzLrOodrtRvph0X154gR3CnWOuSlVS5no1ZCSAtTqx?=
 =?us-ascii?Q?oHV1YD2u+vWOn2m2FyL4aiwjQcRIJJB+Hp/FWJakyfCru7M+zKl8NXVbyao5?=
 =?us-ascii?Q?uiln4yxKCor15LI1Yx2A+sSrF6cBwtaseMpr7283hrl3zarw247qpiL8/3So?=
 =?us-ascii?Q?jMTCPUB665QrMs4X2KO2WgSVVJ92yCGGAjnx0ItOgHZFlKTBVRXdVDz473Ex?=
 =?us-ascii?Q?yaPH/cXAsMEAsB59IoBjReb6hSLsLUk1U2oSa73n4apCrI3GRmCTPvvP54be?=
 =?us-ascii?Q?M9P2czPY36YWTVk8CkxNBBAPH1h/7K/ThveCYZYmEuf2oPN6qLT3u35D62cQ?=
 =?us-ascii?Q?MyeehIBt/Xsu69PuvTa9CIJu2oocN9AsdJ7j3tPKya+1otAqxw9VaORm6tP0?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c72a4ac-6d5b-4cbe-1137-08dac3b91ebd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 07:48:27.9200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjYOttavnp3+9gvnmVc3DyjH5UfzLlJvDp+zwK+/+ylf3fOUpz5YB7ir7K0PWTUthgGVh5unxqQFpD3Ti3rfeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8230

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

