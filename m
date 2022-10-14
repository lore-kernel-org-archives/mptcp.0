Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C561120F8
	for <mptcp@lists.linux.dev>; Fri, 14 Oct 2022 13:34:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAcECOMmJwFBmDuUiC/JWVARki6cSi8mgHBMW8yan+TY5lExSeO9fIP9NmFtK02xCgu8kfB3QCNE6nRN6amZWMjyhSoJXwAXxJCdPMGdAzpBr+V4C4DQD6Vq2JzrWebWdP9T5MhG7FaQ/N9FT3PwcoPDjWhKiZS6OTGXcG56EDt22/Tb3MJ55MsFy12W10viXXfySES8sB08Q0G8jtIluuNgpENSq6LAthoQne/IVbArJkkJsB3najZUMKT/DpmILj/V+iSuyHlOwrQAwGmW/3Q2+ZnrbyCann03ZE8jIdrrJYtDCGZJ27/dUv4Ekv7+NB21xYzWGN0IJQyE0pFlsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ll6lz8kn88aON2SQw/mT3fsK7Jn/AI6T+8oL/8Tcn7k=;
 b=AM6pXwv411uVO8hQCxz32PqHUxS+JApkRYoak9VdCAmZfXt387sEAdmIPKd2C0FSVTp0NpwRP8q8FrlNC6pMyIqmZEkr0Efk19fZodbDO5h3R53aJUubkMPT97R87RyJ+pxaVXGr24BB4LloaB9H4Zfe0zcAa0dMBMca1qicHXfqAnYUmfTArAX7VvB5gEiGzalor5F/sZaiYUMns6hPBB6dhrTpMBuUPoGvMj/vwFPyDcGPuouZ7nvAUhkdBfqTmpDVM7yZdAKoAgREXpVZXE5Lqx4AeVvEkreBJ55QvpGZ2elXMMXOBBCX/opz88a/8bAThUck0LGgCXG7LxEzcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ll6lz8kn88aON2SQw/mT3fsK7Jn/AI6T+8oL/8Tcn7k=;
 b=PQzT5j1qf3reUHyalBVU3AhUm1PhDjdnsm//lRKv0U77jUe0ZRUBJ6V56OQizT2O+QqY1rWYGQON3SO1lvaf1k+dVkIDPtLXFuXvjxNbbau2rCIjUq5qhJAPCNqsLHpywb0R02Rn1pRkiEUIe9nORyp4P1WSnR5lu583lqJIYy2SbLRuUyJVUQkDVuJoJ4f7wrih1piKqGJEpPTI70QQHQFmO9v5GKIJenRoyPiWKUN0se3H+2Fl+RZEMuclXGErBHkFOEJuiYaICT8tbAxsYG1QHYCIwoChlwB46TKYTTT0MWKsiy0VCs9BPxJQVHpzO8UW0tzBNO3+WyQ6qq3NtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6975.eurprd04.prod.outlook.com (2603:10a6:803:138::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Fri, 14 Oct
 2022 13:33:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.029; Fri, 14 Oct 2022
 13:33:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 08/15] mptcp: add sched_data_set_contexts helper
Date: Fri, 14 Oct 2022 21:32:15 +0800
Message-Id: <2c99a6d5b2b95bc013c76c9ac1fe7e8dee1f05d4.1665753926.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665753926.git.geliang.tang@suse.com>
References: <cover.1665753926.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: ab18099e-9115-4a34-2e2d-08daade8bf8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hcKwOrRkJRva/91n70b2GteX/asoom+3+LO2rHLJJoIOEenhVZO92DfxAwJaaiQxompD/0aCzLvuEOtDRg+q17eHb+weq182tih5iyXT7Ciu685q3l71UeTbSH/8f3MHhfDaG6oHCoiue04d8U9bRPLMz7IVNrnpHDTUx1jzBoGCo2+PPtzDMjQ0m8Sllzr9BQ3g8FPX91ijjq8BdCVcSzpmWzy5NclC8INA12jyxIEP2lLMW0ADZpEZAdN9+YnRq8D/zUSUUTW0jK+uJEG4jQPy1pWxVG+WJ9/9aHmYzALHYvy07pwyX6PKMsDv2YymeaRIhyiBZmobFgd3fvMKGT0fFkL4Cd4oVLu/RIXpXi4rO0cqyiwgQsvNh4fA4zs7AMVz7yUoWX5a6XR3EpG6DpXikkYQnkEp47zqFz3ODWHi53M6WoHNUUKjFA/oIdw2cnxCUfLPcNwPM93lUk66BBLXdjibd0WcibNQ3NK/FHq5RqR2XdtR9gLggmL2F0WLSbRYPrzKfxsQL0clrWecLs2g3B+adrUSzfELCjTK/Pbha7zpC+7+To6s2Evdz6FswlcJFiYaE7ffaSJfM7fywG+oaCGL3hlTQVw9B36wRoFET1oVjjfJ1t8nyhCIrYhp4Dl1jmN5Pc50yZnjKUCFQNptISKa0m47FxVAU8v28PoHdanRGDupiw6vzPK//6AyMoKm44kJhasHFzwS0c2/rpFqz7tLMcjWLOSSO1D+RbAVl73COfJvBZUw2tF3AQgb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(8676002)(38100700002)(6916009)(316002)(478600001)(36756003)(6486002)(86362001)(44832011)(2906002)(4744005)(66476007)(66556008)(4326008)(5660300002)(41300700001)(2616005)(6506007)(6512007)(66946007)(26005)(107886003)(8936002)(6666004)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4eSTusKWkKA2TSy6j1j5qGMVtBNFsVdeOP1YUS9nWB/lKR0UwicPKtz3WT7/?=
 =?us-ascii?Q?/vj06pFrJDulaB9R6XR9x4ZrOmIu3bO4RzxH3s8xoMpo5f7JBls93NRIR9wU?=
 =?us-ascii?Q?mClvGnrQTwEZDWjYQVz9gQdLb+OMcve6T/oe7qgm6MNGUxoX4TW6K3KkydQu?=
 =?us-ascii?Q?nEjks7GD+aXosgDbST8p6slQVxW9rFdLBLP8wBbhNkyaBjovuCO/cGhKkV75?=
 =?us-ascii?Q?vMtafHfRALMyTcDWlo58/8nkbANFejBLbNAk4skNdWnrN+PuSgzR/WrrbB/W?=
 =?us-ascii?Q?UTdi69HmmG4bLPXSk6jS2IyRDM8raXolcj3Du3NswyNBcyB8ldiTULAubWKC?=
 =?us-ascii?Q?3e7j+5feRZxygQlgshzH7dIK4eqf3G5zN46mhovay4s+Ip/41LFZFGfcoqpn?=
 =?us-ascii?Q?3EXHVYHlJh0YENfejllDD3IiLxoXWC2ghAcTH8gpC3vIc6+mlH2HS2gUbjbh?=
 =?us-ascii?Q?3qnspCA5JzPl2kC1D4g7fNQHOkcPKhf8xwOL3YaotFFneq50AiYb99GuYihr?=
 =?us-ascii?Q?dKuFJiyHZf/wBAEs5JBeVdxXmo4S5GisRm7w+Xy/Gw3gSzYMPcmrO/WNjQ27?=
 =?us-ascii?Q?fOKpNFfnZWJ2LxWY/TJ7S1w4VR9u7e1go4IR+7MYd0BQ6HzU4Xp0cuXWjGrk?=
 =?us-ascii?Q?j7kfxiyCH4OLQO3PvzCG8LAhwAvN7TQccYW5OmmcGk9Zc0qh7X1AWcvRMAJc?=
 =?us-ascii?Q?pgCjBB9vVnplut1tDbSrx3EqFZfgdS9g4qp+9PuwBbWrCSHSu1MdysN3FiX1?=
 =?us-ascii?Q?OSjyIko1pt6P1YcK5taQjo0V+Hq3lM8nfVoDuWd3T8dfZtNH3gJmyB02AA/i?=
 =?us-ascii?Q?xDVvf/1Z0IM+9/gbfpQ9dLmdPjxuo1m0BIk6ivURo+9G6mWQKGk4LhbT8LZw?=
 =?us-ascii?Q?WgNrvUR+WfuBJyCV7YTpuJPcldHXVLxZniezFUSPJ+wodZ5M5ulpmSfbwKNP?=
 =?us-ascii?Q?DDxIqXxdDbEhZIEHV/Izeo2/ryPaqtsqPkWpCZhVZY5OtnWe39iHyjoxJOTW?=
 =?us-ascii?Q?icBKI2+F5GXo6PDBo6Mypi6fwIo44ZmnH9GI5XmK6Q6sUICF8Lgz0Qy6V5oW?=
 =?us-ascii?Q?on3w1/IWQZib2vZNHXHcp7a6PUgPUc/nbZRZhhsrM4hxGD4nNiGJ+4LvfbtI?=
 =?us-ascii?Q?ViENCGgHiAiBqUJHc99tqDt03izFVrxJhlTNsGdLeUNeGL2GKUB8083/bLVY?=
 =?us-ascii?Q?ufSs8n6uSfxsl//2hwLjqS/qY6vV71tHAfqsRPoNFinuwewb3Jp7PebxIu+x?=
 =?us-ascii?Q?ga1peSYvZhNnxumiLGISKWee8MIN950g7oDfz9T+ia6WB9XeHpjb8vz85r1z?=
 =?us-ascii?Q?pw0Hp/5pybYr8+g+UEzrdp7wXR/iSPdL+R4tzeqLJHWwtOtyqazmPZ1ef+Xf?=
 =?us-ascii?Q?KiSFkc9J3Ct8DVURf/Dn/p1aQJtWoUdTsFzjPhW0y1e8hrosZNnC0F1VIlKx?=
 =?us-ascii?Q?mjvrza6MKVnidFhqUF1AqJgQHU+XGUmhi1p5FKUlm1kjJ0PIsQDWJeon0i72?=
 =?us-ascii?Q?y6lAjdWWdpzoZPWbWU6PEcMQwsYerrDGX6ZHXnGQ6dzfuuFtaIcq7ne75Pr8?=
 =?us-ascii?Q?nBbH5juyDAEJX8fim0t16C3tnOdTWc0Ng9fTVC0wt2SkbxzfatZqehfRnK8o?=
 =?us-ascii?Q?xw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab18099e-9115-4a34-2e2d-08daade8bf8d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 13:33:58.5158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PuYXKWqfIiWdg9arGnV7NAPRcBqSI/EbxiaNGw32yvn4yI3DuAg1oDN0dUdjiD4/w/2YBn6dgkFiFd91DCq2fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6975

Add a new helper mptcp_sched_data_set_contexts(), it will be used in
the BPF contexts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/sched.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 949663742f14..0d7c73e9562e 100644
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

