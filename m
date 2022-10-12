Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60072.outbound.protection.outlook.com [40.107.6.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AA817CA
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:50:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDBkFq/z2+w90p72xRptaKJCkJUxfAyU5Wpp5CUt73lUOMii5YLDMNtsxY6MTyezX5STeKM1vqmtc618pPeEv7rBDKfC3wx2+nlciGIcjo5vwNZpQreZ+S2L3x5fDv91/O90TreJATHC/eP9+KgxQwYeYh+jPP07SRLsPA5aPgHzsGG4pqz2Wou8lXrUxKd+6Qq6g+iGct9+njAdkASuQv4tuI1nBEwz31y9RhHv6iVECRGP1H32UIKPpKb3M15Ak4rVqyEWE3Omu0eNYRvidOeB07+7RzISsIas3siX+XRBXcdpvPvXe6kZGGM9YZrj9rMxLRDypnZ9+WG+/mTB3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyVsnM3nu0INoWwE2u4/FukNHYm/VsXjeKvXtL48DjA=;
 b=bgswOGclKqzZcAkq1JwNyLZ/hrh1hJoI8DPDytl66k/xAZzs5xSLLKu9eKDzf103WczC57kSR8fiaIAt469MF9lJxISwKdxYCZsubMB7j9Q+V84YjERU1wzE8xEOShrXpiqbPgUlAajmr6Fj12TfjuwkFWjOtOl0caOEoz1aiBj90D3S4K0tDeYldq7U0FIvah1LvRmpu/D+WXbyQIyLECPOcqXwxRH9F6IGletahRHQvChopWORdrYN9GcAYQu9iZT8OwAVqHwTgZabT0jf1RZXuT1X+1yMKyObhGnR0mdGUSRO95l0r7daUiR4ljV5OPUQznpUi6R08GXKkMyvNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyVsnM3nu0INoWwE2u4/FukNHYm/VsXjeKvXtL48DjA=;
 b=MbKW27INDJwc50Ky08bBc5bBD02xRx+5KRv1DwDyuP2LETwJnXuvGqxqEt1DHmPeJCQaj5qZesTt80SOk4//4YnxrqswNfLp5gXAqYFGORtaDi8t34c1i2msfBpd+iiGpplKACSDIGstrGqoB6zS9OI8geBTFvoVYYCwkGG6dsoIWxhd9L7jL1Qs42JpQC/U4MmRFtXVWRBrAs9U5i/6xqo0m1SUMDukMLeWP5CwHdTHFJGxJ56Q9AU9ebxaQs7IdDZH1sOIG/zE0rUlmk0WNGFwjDNqB4PdUXdN4erQhg1GEvMoQddV0d77jzFGqKq8LGVTDY26YfCpUdxJe1+LPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7722.eurprd04.prod.outlook.com (2603:10a6:10:207::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 04:50:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 04:50:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 02/16] Squash to "mptcp: add get_subflow wrappers" II
Date: Wed, 12 Oct 2022 12:50:23 +0800
Message-Id: <6bd5b40fcf7cadee559f9b7cca60f8011001ae55.1665549881.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665549881.git.geliang.tang@suse.com>
References: <cover.1665549881.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0197.apcprd06.prod.outlook.com (2603:1096:4:1::29)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c574c74-5217-4eb6-1382-08daac0d59da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0rBj5C08QQOxeGkr+SwMMDo6LBo3oUcKH3L0vVNzKV7cmKu2Tf5KWouYTCYbOGARGrZSagWD/twc8J+4/0PAu1F9FbKkE4YhQ2QJd8pbjxjs8rn67nXBzlzvxvvJGxcXa46R8W3AsHRITbwdYt2yid/RAZUNagvoKboGepyJ3CklCudLnQrEg4vS+Oq4mnYAxinoaj+LXHajQVLjqbrCnF/wO69xcwgdm49OLLGZevBWK9UUmuUqGgOGGXoQi0y6eo4ppWn0ePBJnZLc7/zNJ1YJ3aB3dL6avMBKroZQTQ9JqMn/YKQgJNOkHxonMRcMUQJ3lw4WXcTmotK2uw8xRS49raZ2Jpdwe1MjFziasJLWplMsUbxArKb3uNmezXq9BlAa3myeMvxsuGTZdqTJD3fBa+yLII9m6rJx+O8j0uT61FWL+28t5tdSvtbpPk0yXs6hp3MJqmAVMXkB9BmgPqLiCoBPs02fNkpy1XIiXcDJVD72ZwG1GKcOD20xh+w2IC7FGdbmHTWTIeXP7927j1H1MHeBdiih/AyiHSwCwl6dN1oCoXQGcG8YKnR78CNt5OjEpSC8NkA6NtaUXqCEPL/2uDrOOlkgTD1IEjfROKDyNr3XBmWyPSoH1GLTbsq8D/8A5VpIaHm1Ut4JbOI8VN+YiUsu2Ls7kaGF764QDKSKrMUExVRU5GZ7GncexG4HbYfEQ7pzIaGPzWBTgYRj/2vHc+OEU+wi2mD0ayGvVG8pW2ua0HTfrH/sWVyQX3r1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199015)(6486002)(478600001)(38100700002)(316002)(6916009)(186003)(66556008)(66946007)(66476007)(8676002)(6666004)(107886003)(4326008)(44832011)(5660300002)(26005)(41300700001)(36756003)(8936002)(6506007)(83380400001)(2616005)(2906002)(86362001)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8ZH2Pf1mpgYBzfwLdE49jvArhBccozqdRN+zePE7YQbCFBI9GZ6bAz7Dutx0?=
 =?us-ascii?Q?BO49QYvPfRCmTiwvPlUR06KPhRDEXPTt+6ZPDhCb46cVGhQJH2EkhOYvtd/h?=
 =?us-ascii?Q?xBc5QpodCcDHY+y1k18mo+/UHzRKgthQP0kvLizn8pHCThX97dD6Eeyzz+Ou?=
 =?us-ascii?Q?Lt924aoSgHzE5un8lnKu/HCnpEDw68puc+XtAnblkd+v0PJOMVT00IVrDodk?=
 =?us-ascii?Q?QKDqaleBF6m1D3QCQGHkeqZF/RB1nw8zCWralY81WUelFijsCoETUeMRuXza?=
 =?us-ascii?Q?2SFTp82/xpciRqJsD1OcLmb/Sk9GZg64V1oM9jodB8z5l+Ezmij74GGbOu1p?=
 =?us-ascii?Q?/LBseXpnwYo036kPl6IgqMRQN/NnJRzQo4LoaVsVCt7ypgAH5lnXegb0BIbA?=
 =?us-ascii?Q?DTuOsiyDaoxS5mUlq32MhUap2wKenc9mAW8VWflC7wa+BX60uX8TWJX3zdDi?=
 =?us-ascii?Q?Z+/WNnokiRVv62RCWax/S0je/dhsloe1sLtxsCjplkXQFSD8r7Yw6mJMERCm?=
 =?us-ascii?Q?31xi6gxS8/GzcuwhTy3UyWDca4/qE9jkV9/Pib5DcTvgWj0aFqP3jtl4zlSa?=
 =?us-ascii?Q?QqKEN3aAt/rsZezOBda57OxDq804nYz7We4GJUKlmPUArvOKA0gloka210eo?=
 =?us-ascii?Q?F1l36KbvCCzYTPeBSZmyY3xroiplVPsg8MpG/AF8vAehmAVxVRPAb3izzIqu?=
 =?us-ascii?Q?MlTYGqVTOaXgSnWZtXqbcWt4EsVpL5ld+5dv8ow/+WCljSDzampFNw728tmA?=
 =?us-ascii?Q?djIpzUEJD4wP65attvUwd15s7lwW+Qgk93iq2npbst+T3LUR3aHDKQBPlo5B?=
 =?us-ascii?Q?SxdHchj58bDBkPrAg+ncb9Zy7IxTCe3pug5QSejsWS2iHk6oAhyQ7ciTAgZN?=
 =?us-ascii?Q?GHzUKdYE2xi0h+qqh9G/AoEQOSc15mY5y9SLIf3dhO0QUAAYOd3CGX8S7nbk?=
 =?us-ascii?Q?mG8yEIyNLtT4UbFyTGYpNlJ+uUIzLF0hLkk+wuJ1tBHZVzu7ljC2L1Pmak0S?=
 =?us-ascii?Q?iM9b6ngntPvAM5CtHIAxPKX7GSnPefA49nc2ktaoPChr9eqki7sncdVU8Uy7?=
 =?us-ascii?Q?tOjH22sF/B7TccujW+2td+oIuEEH+ftUidExpKfU2tugli2tvpTuM5DFxzBQ?=
 =?us-ascii?Q?Jaje7cDxRyOHj9C9tI2AH/77HB0aH36BBQ6jT3cnpX7cywxRZY71+J7jOe8D?=
 =?us-ascii?Q?XrqpUgbjK+e9FoI+tqZdGCYGiGHHtFj6cHVilUey3dTPYtiz7sCcL3WoQuTp?=
 =?us-ascii?Q?YppEYZRxT/jJY/lW7DG7ArrMPqBnvyFaeTWlGWUoT4/ypxwNBLSA2L2MEe6Q?=
 =?us-ascii?Q?6P1Qo9qVP8i7Q67fcwqhMLA8vYRMXNkwE42cwx5GoSIGCt/8SdEBvgjb0o3V?=
 =?us-ascii?Q?yMTg0EAJHeZb9EgBLNrYFbEBqmiSZD5CM35QZgEtYKr+Ag3vXaEtAPVF7+7d?=
 =?us-ascii?Q?MswDezIuC8+QeQSVPh15mNyOCU1+gC1MJ9/ta8k2HRHPtsUz7CPF+55mMUqb?=
 =?us-ascii?Q?JjhoL5GUsZmttUDGuq6L1NLfhsD88t4fqEc4sC2HNsD0CVa+K5AMJrTp+ADi?=
 =?us-ascii?Q?uY1/BmoHqHEn+0h2A37s86Bk1yu2Qb+b/f+rkmNqI9DsqL/F9ceATiaY3S10?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c574c74-5217-4eb6-1382-08daac0d59da
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:50:57.1175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVaFrF5J4wCSZUK28Cd7XJilDb0rj4PHGjIPXwA7X33tQZYtva65+wfZc/jzYJaR/3HyEZGGmcqL1K1QewFS+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7722

Use new api, use the return value of get_subflow. Drop
mptcp_sched_data_init, use sched->data_init() instead.

And some cleanups.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.h |  6 ++++--
 net/mptcp/sched.c    | 47 ++++++++++----------------------------------
 2 files changed, 14 insertions(+), 39 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 68a2b22a47eb..ee9e7e55dfe0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -640,8 +640,10 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
-int mptcp_sched_get_send(struct mptcp_sock *msk);
-int mptcp_sched_get_retrans(struct mptcp_sock *msk);
+int mptcp_sched_get_send(struct mptcp_sock *msk,
+			 struct mptcp_sched_data *data);
+int mptcp_sched_get_retrans(struct mptcp_sock *msk,
+			    struct mptcp_sched_data *data);
 
 static inline bool __tcp_can_send(const struct sock *ssk)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 6324a8a76382..c459b01f9a9d 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -94,34 +94,9 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 	WRITE_ONCE(subflow->scheduled, scheduled);
 }
 
-static int mptcp_sched_data_init(struct mptcp_sock *msk, bool reinject,
-				 struct mptcp_sched_data *data)
+int mptcp_sched_get_send(struct mptcp_sock *msk,
+			 struct mptcp_sched_data *data)
 {
-	struct mptcp_subflow_context *subflow;
-	int i = 0;
-
-	data->reinject = reinject;
-
-	mptcp_for_each_subflow(msk, subflow) {
-		if (i == MPTCP_SUBFLOWS_MAX) {
-			pr_warn_once("too many subflows");
-			break;
-		}
-		mptcp_subflow_set_scheduled(subflow, false);
-		data->contexts[i++] = subflow;
-	}
-
-	for (; i < MPTCP_SUBFLOWS_MAX; i++)
-		data->contexts[i] = NULL;
-
-	msk->snd_burst = 0;
-
-	return 0;
-}
-
-int mptcp_sched_get_send(struct mptcp_sock *msk)
-{
-	struct mptcp_sched_data data;
 	struct sock *ssk = NULL;
 
 	sock_owned_by_me((const struct sock *)msk);
@@ -145,15 +120,14 @@ int mptcp_sched_get_send(struct mptcp_sock *msk)
 		return 0;
 	}
 
-	mptcp_sched_data_init(msk, false, &data);
-	msk->sched->get_subflow(msk, &data);
-
-	return 0;
+	data->reinject = false;
+	msk->sched->data_init(msk, data);
+	return msk->sched->get_subflow(msk, data);
 }
 
-int mptcp_sched_get_retrans(struct mptcp_sock *msk)
+int mptcp_sched_get_retrans(struct mptcp_sock *msk,
+			    struct mptcp_sched_data *data)
 {
-	struct mptcp_sched_data data;
 	struct sock *ssk = NULL;
 
 	sock_owned_by_me((const struct sock *)msk);
@@ -170,8 +144,7 @@ int mptcp_sched_get_retrans(struct mptcp_sock *msk)
 		return 0;
 	}
 
-	mptcp_sched_data_init(msk, true, &data);
-	msk->sched->get_subflow(msk, &data);
-
-	return 0;
+	data->reinject = true;
+	msk->sched->data_init(msk, data);
+	return msk->sched->get_subflow(msk, data);
 }
-- 
2.35.3

