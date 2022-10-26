Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140053.outbound.protection.outlook.com [40.107.14.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6991F7B
	for <mptcp@lists.linux.dev>; Wed, 26 Oct 2022 08:05:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvS4T+5MHsYc+snao6F27Tsaqj3Og8cE5P7BEXZjVHZiy0SbSvg0LmFKRwww8H/DYKdrZe2UfMW2Y0tFEc+dj7dv3EVzVS//zPJQFDhqB/jifW3zSH5cDYmHoX77WseigvyqHtCP/tgI5ZDlSw7r5XodQRFXzBInD33BE/4ZAyH9BF9hiYVL+7NM8KMuZmOV1n4T6So/TZ8UKDl/0rf4jUAQKojOoru6D8oWFIyAcERRabK5F4+zu5MomIlWooWMvplH039r4RFyXKe3UbZB91FlC+DMaCihfXth39z8X8CqtwLqdlkdbwqE/Eu1p2i7SV8HJgUP+k01HuAVAHOTfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnDh4myN5PG5rA51tFqnEO/Baj34uQClbwjqgpGiogc=;
 b=eoYeX/mPpNy66T1p+WeZrOMDOMRv3+sj9EKKHE18osemYf2CAYC3ns+9BX9uWwH5hoJudM9ZvUwLyrK+GfO3vCLyPOOVF/WIUMpMnQLOkxdTH+OHRqN9qDx7P58CNluCkO2VBlZXQfcBLSalyIZj+nFOMIHPdJ+c8XHHFZyAjfppRbNfvgsG5RfA5pUv3wYjkEOAos3qE3jvSEKp2Q64D0HZkoOce49h0izw7UCt89+pdw2sVxJ6nm6fMCYIMNbOPFihSiWnLrZB/PClrR5GTn6YQq6qisf3k/Hlm/GicYKcry5bJqDYjbawbjirR/amIdfPiPDo+G1ennzlhSd2vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnDh4myN5PG5rA51tFqnEO/Baj34uQClbwjqgpGiogc=;
 b=RI2tk7hu5JgtBYtRFFlPfF01ovMmq1P6KXu0b3G74+QVmURk4qVF0RIGGDxBo9pjsr23f9vViov3b70EeYyeJj0kDOjplRSlv/HMRWnTfZIM6jqKvokWF38xx36WVCzB/ZgHSdrcWwpbs+ZIef84BWAXVlhHs+xiKOxHyc+ekZY/YfgTSaj4/T+4ytqQZPnlbfgwKF/A8IDeNReSd0sdWh3Xk+IKs6Y3Qib0nsP1jtJWSN/pBfwIunpZWIEgGnrL9Odx00bka/Yj3ydSBH1K8oNLQ/3CY9XlclolSSdEvE6p9ijwMRG2mRCZ25JUSMQJI8Py01XYOGKKHtgpVyNdZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7777.eurprd04.prod.outlook.com (2603:10a6:20b:236::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Wed, 26 Oct
 2022 08:05:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::84de:d6d2:6710:556a%5]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 08:05:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v16 07/15] Squash to "selftests/bpf: Add bpf_first scheduler"
Date: Wed, 26 Oct 2022 16:04:16 +0800
Message-Id: <7a372617c0016e5be22fc99af6d3f092efdb9696.1666771065.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666771065.git.geliang.tang@suse.com>
References: <cover.1666771065.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: 644b8248-b57d-4ee0-a585-08dab728e777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q1ohHMgg26JJTgg5aLN3KiDAmEjsm1OesfKID+ebZwT562wiy+4mW9q4wcjS4ZsAId1FUG2R/XtAJQd4kCSSusWWfaRdFMkC3xs647TKbLqR+K4PSXIQnhEwp7MLUe+e3uEyk2rdp3Tp5RuoMXEbicRtdK+Hcl/04Tg7zoj40LQcEqgUxL6e0bdZ8nCfrgKNu16EkU6H4RQBtFlYNZYhtnr3PV7WqXNJfnsGJ6ujPYYYZYjuKXeFcloQXQb/9a9idfvHWnHD2R31oRafaeu13o5IefOrZfCAMmfmJKLj/9YWwpF29p8LyamVXmhMuP5g+gwgy9QQS6cCj7tTZ2BrfOg86BboWJdhr1R0GEbdDaB697YHQbnoRZCPUO/URlrwDqnCo/HesJSFxBaad+O1yfmNiPL75/ZXPLmKrj0PtXbrOFgC57XaOSw6B8a90c7ZH0P9Z5vWoPDWc2sMZozUmM9J2f2cfLg12Q2KG2fPHPytXeXvqf79Se82pyGPf7IpzXnYOwgnHoymU/GwfH34hfPouCG/Zth3+6alx3JwzT4tyyNWSHSCFCpSco9FwFIyJbg+VwuWt10r3fEp5MCkejl76fmBbJkn3QTflSySluJ0Ed8apvdSap8AcBkdw00DxXr66Hfk1G9CTMgtXD8B+iSh00PrBBlmWD+ygH2CrVshH0/4fqycYrPvlwbNLLgzXG/KFWLYq8KstoDXiYG8UAZP4ajNDZWf+ZoES9UviopRl2dUkqMBigJ0ReXmxmz7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199015)(8936002)(41300700001)(2906002)(66476007)(66946007)(66556008)(44832011)(4326008)(5660300002)(8676002)(86362001)(6916009)(107886003)(6486002)(6666004)(478600001)(6512007)(26005)(316002)(6506007)(36756003)(2616005)(186003)(38100700002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uQoQp/vi53zM6SVOYisoHJNcL9V2DvNwOiucDEeaa2tkp+TH8CFgHcvu/wso?=
 =?us-ascii?Q?T1bPZZFGB9BbsAyRhQPCOx5t5l6o49h0OKhBfozvCs/xjrKgkmqkhuVUyMTC?=
 =?us-ascii?Q?ZXDpSFr8xTgNItN068neVAUoBZtHtYfmdxQirBxQYvI0x6+6oicQN5CCbRFf?=
 =?us-ascii?Q?kB7Jqd4GTjh2Hzqi9OLtc7rieJo7Y694YBgebZILDtNIvDshGkI+OQeQkzgp?=
 =?us-ascii?Q?/TqCjkT0i+hYMJKFGwREeVhon7n/E9zdyLRZuQZLiTa8WeUlllz1eC45dzhN?=
 =?us-ascii?Q?3GsybWNfKC5MLKxF2Nv9ybUm2HDBptMFxyb0iEg/i/wVtbbdGBd/iB7D7/m5?=
 =?us-ascii?Q?5DyLQoj1EhKOl4aZwB6z6f9swKlsOMOqaVVjWAztYxVJ+SqJCy7wmbSYSFKr?=
 =?us-ascii?Q?MsNayMa+eoBzvpa6XAwGkysDVvZV1bDmBs9m/68rFW1zY5KlSm0pPGOmsjbW?=
 =?us-ascii?Q?oowZA/0IrPFdl1//BV48I17aobjy/+CDAqjezXHW08lIahNu8JkyHjOnyyKa?=
 =?us-ascii?Q?aXaTSHByrxxgDYpcuRKQtb9w+lEdlMrd3u+gFHvxXieNU9GuKHtgAdoN9ARd?=
 =?us-ascii?Q?8ScYQjDbMX42tIcbaKdjHxYND96WK6MzQvSj85YVVrJS2DH8LoA0fICvDI9H?=
 =?us-ascii?Q?6Fve2DqoO1NLWOMTlseA4q+yHkxw9uAPYo1V+efOhNgCgeu04FvVLUiVjC+h?=
 =?us-ascii?Q?DERPWnxEEtD48BLLkXAbtnt+jcvN4ykJYFPAJyxWNkwYAEbvKnonYVIDvzjh?=
 =?us-ascii?Q?dEXOHXa5I/7KLn3shFPyhEuEKTIvQb4COtBZSJG2zjK4ZJSOQ6SRdiGSbled?=
 =?us-ascii?Q?Vul+J2gyplIPxyM6cPT5IMCwxoG9guNn2tPYN67gYG7RRmQn49Tp/FeGPwKe?=
 =?us-ascii?Q?GfZePyrsbsxXOkfppzgast/ECi06VltxoTgNYUzaWpGN6bbqPhkzpySevgPD?=
 =?us-ascii?Q?ZXvZNDhCmiKu+IlMfCPai52OY0V4sZ1iHm+lbz1ZTvqXlDThQG841mKC4FnU?=
 =?us-ascii?Q?mFBnfo11nJjZFJaSAQO0jSGzLzT8t6fQRw64EMenTzE3miUhxoG6m4ewWYd/?=
 =?us-ascii?Q?hizJQicNvTMpr07AiANLZBjtZTnZKaDSYu+kjsV0Xybh+5wr/qIzYTLgRv87?=
 =?us-ascii?Q?WvZF+ywTlfKQxFLsW7CxDcrRnUVoOX2zFJWr/SmbyiA+Y4CTk1XtJn9giQnO?=
 =?us-ascii?Q?BYdb7FzdHG/olozjijrS80j1bgQDRk1fufNQFjWGjctf59NP6LsI3OHfRTqY?=
 =?us-ascii?Q?m6fGongXf28h8sasZPJU8YLlRScOm9eyvmItSwvB+wDmyZhm+w+JTb639REa?=
 =?us-ascii?Q?0b/V/JGNKW2sFC+notlLgEUsX8lEIBKsEZ2QLTBKsZ3ZQ8ppncKBLWLJfpbI?=
 =?us-ascii?Q?JQpJYiuTvDg056hQzvkyezwhFyrWHvB7wGfAnsgXJff4/UETcSMdEb0ak2sH?=
 =?us-ascii?Q?kr5YxIkppqoFo1zj/ApEvTgukAlWqvSoU8aR7sAOKuYEVwr6ZyO52eSh5KNE?=
 =?us-ascii?Q?lWqofDELrgq/9cuXAsQYJghtal4t/2Jci0/0tiXs0Y2MUOEP9SkSl7FiDQrk?=
 =?us-ascii?Q?us3vwWRKNYy/wz8/GhAPGBpMDMIo0dN8hc9M+pYL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 644b8248-b57d-4ee0-a585-08dab728e777
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 08:05:53.7549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yf6AN4Y37OOovx/iLxZ27Gts6so7/OCNBvLr9D03IAsUdOYqD8tpu19M0Ko5INesPoMXKDYzexnjAAuCvKmDXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7777

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

