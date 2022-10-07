Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5072468F
	for <mptcp@lists.linux.dev>; Fri,  7 Oct 2022 15:02:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ky1HqqudGasIGEsTILiWuWO1BaooWJgOEQ2HJEVqp4tcEfg/mcNtD6PSkrJ+1TYsIJ06EA5hVjTneZhVTpwQma6L9I6mdsR18IrYjRmyVys3YcTh3ByGxhh3PrxKsClCFt//mt+lJyEkHSUEBXmFccKH/frn+QbveOAPQPMnAvmsY7GGtmUT35U13dLHnvwtRQHlnE56HREw2ycot7uMlxAy7dt2xv0gUKPXqu+gprmGvqmUCr93YBuVJNikHlAPnv1TwxP0bnZd1R/a+SMKecnIKQ5EcOlJ7dFXFjHSagN/DKStxJVFM7Ll2Fd2l4ikncqG4eMRBQBER+Y1Ll2RnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCEYA0PnN+0FzykuFC65UBPyVRnhXc/paJo7eYADJXg=;
 b=LHx/f+cj7Dw0tyOka35OAcjg7SUDdQy8X+oqrGw5b/Y3od9lpmH6uFeRfvT8ZAk17occVAh6H4Q3sO01Og0gN5kkdDW9/QetwTu8z/3YWzZLPoE82oIDJbm8UQKg6W3cmXFFM3RYxBDnFySPpXoLHg130xv7MbGC/T/ktpPzhduw2S564WK+3qn4STnOIShLiLZ5R2DrscrahK3FpDTjaDWKAuDf+m81WjTk5L/nHXkKQTc6h/f53K9EjzTqeZUbxWG6Ti0z4MioMQ9ikv4yQVDHwPJvF4aKnX0ZWgdIJCXe52gu1ZAvk7WxZ796I/AYEAgV0eOngO20rvkdKjtZew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCEYA0PnN+0FzykuFC65UBPyVRnhXc/paJo7eYADJXg=;
 b=qvHHmqvvnaXt3PVlBEI7MKb4Gr+YuBF+29xSy+bOFh4fchz5jCd0bfEdPWRVKHQnQQ9qKCKe3OnWvqQ6R/YgVTne7tNvnW6Ti9f57JXPQWIaBTY91hWOstSIzMdxHKZV1CRG+hTISLMYV1f10PWpVfmYtmScr/5KKIUMUxfUR9vl3yYpUerAjcJ8OdbeGsqDXf7gww2qgOAEmZHMdrL0Fr30qEhrdANKIWIrDW3giB0VxP6+AOVWW7lJH0O5EzmMfg8AB2gPeL1s0bfVKUE9bH/VKqAD0h5ryAVf6gZuU/eqtWhI4FQNEzP4FaMer01WI5ItpCejEXLtM1QZxbeprg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8295.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Fri, 7 Oct
 2022 15:02:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770%4]) with mapi id 15.20.5676.034; Fri, 7 Oct 2022
 15:02:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 01/10] Squash to "mptcp: add struct mptcp_sched_ops"
Date: Fri,  7 Oct 2022 23:02:25 +0800
Message-Id: <a1fba8ce51f7c3dff3236efb5b3862f9237a8883.1665154582.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665154582.git.geliang.tang@suse.com>
References: <cover.1665154582.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bfebc44-bb0c-4be3-e086-08daa874e354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oWejPMh5nUljB9iGstoToH1TaL94bwASEmDN/TEy0JsE9o4nlC0Ev0kDYS80KxHl4Xeo6xiYgjrUFgnDDOAGCa6JiI2Qg0nlZIBHC9IrxWmrSc7OTsCyEgrzdJw+LfWaPQJ4gnRYCuNzWrz5HjY66+WQR9AfciMoGqCAT1C7NEK9DEnP76o4EnODSElb6q6qHGIlk/+1a96O6jCklnurbU+n7oGzBxK6sKLjGAqTA/TPH1fmlE8ThZVaE/muydl9RaZrZ5qfvStOA6E8+XQFRBYiCjI8k6LIyCaqli5o+ru7vdvt/sFAgVkDW8ACfBoQ+XjBbvxsibjoUqKSGN2lg2UqyK+7DEmu3M+/ZaBrMACZ9ln65YvL6ySA4ciCrOgpSSZm+gioTlPwQdPnZP/mH8qzcgCcf97GFORGy95C4szqQwp3n23kCot3cbJ8U8ITF7dhirrrAOAs/26/n6bIK8MqTdJciuF71mnN14aQb68DrnHWe63x3LolGGASmFY0+TgmC+7CZfRoE9kVQ7hGQHsD9W+UMhT2Dtg1d66ujVPMNFUMqccE85bD3sHE6pPsHVGVXm/zbxC9eWothSeEb8Ucer19uCjKw8KJMYFBhUIYESmiDpTyGm706QREKvF0pnwYSEtlwdMNhzCh2QexvwRTlDatGjC3nbN23pIb/QFGABDnkd/Aoy4tRyYyj7AOeSppGUDZYwc3c8LQR1NrnKuyoBRAr5flttrTwVzeAu+doddfsotBTptLve3har5T
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(5660300002)(41300700001)(8936002)(6506007)(26005)(6512007)(36756003)(83380400001)(2906002)(44832011)(2616005)(186003)(38100700002)(478600001)(6486002)(6916009)(6666004)(8676002)(86362001)(107886003)(4326008)(66556008)(66476007)(66946007)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S+iaueEvKDKbGrAxF8bAHWkhmQXOlwibIx7XvgsaaB0oKtb49JVGeGevD+2H?=
 =?us-ascii?Q?GmdzktVsqhOFOScDDkjtacBM8GHTBZm72xxKIAo9cmsf6H4WRZ6wTppkGvWe?=
 =?us-ascii?Q?PWO8A3Qyp5fLP58JvklzI7Q2Lj9e9dnTtLviwRsojA1r7ZyIwAyh5HEldPJv?=
 =?us-ascii?Q?7q4yr5/qRhOAdBFbg6dN3VrJjo2OWkoYND0PP6eu5oWkhBVxHpPi3skqL5cI?=
 =?us-ascii?Q?9PB6DbTossYJMrosTH96qxcc/HeBrEAJDesLnn4JaaUXjYBttBt7k2pkozT4?=
 =?us-ascii?Q?oc45y42AfglOPop5oPaitUIjPrDeSpdjlFqGtMUqTofVXjOeDPDuhLEFVIY3?=
 =?us-ascii?Q?qZF8M8+EpTaJtW04m0gGcGE97IDoceaXqlbw8sAajv8c+i0sVGiwPIl9pdzZ?=
 =?us-ascii?Q?HcNWS84l6eJBZcPQ/9ur4Lo2SLy2SgFU3db4V1RC3Bt6e2AL0Dk+2qvCZB9Q?=
 =?us-ascii?Q?RhGp4M6Dj8wf6MrfZHwIXv94aCk0nNZcOlELTUK7UonLtVcUx+36sqKGtVdY?=
 =?us-ascii?Q?gI4JKIkMEyc0qrE68dbIhsd8iANOGKsSu44Q4XHr32zyKYK1byTkIamqc4t6?=
 =?us-ascii?Q?hJSnLJSTYt1aTXggz51opL6n2hSf3rfyVERaKwjD+VdtOSc4xw0bW1vaMgAY?=
 =?us-ascii?Q?WlD7XoCcquz+J40rdEoslmdyhqIXDnwKHupTZgapDUuaTkKjsj6ISPIIp+qm?=
 =?us-ascii?Q?MO90q/pla0A2+RaQA2Q7bfIwmxxMO8Udp0BES2ZOQW6esMYzQgU4VAxpxjJx?=
 =?us-ascii?Q?d84K5OMB/TCaLv3LmLNdrvntOiK90FPPrfINVU5Kz4RPxlFsorgERCRjJ1zG?=
 =?us-ascii?Q?ZtFoZijVzsdisyQArYSaPcgOpnNHGAQMEJ4u9eIBRvyAHqywyyf+O/yfxON5?=
 =?us-ascii?Q?bCZgGaW6ACrhDs0sQlJKMqx8jk5waqCrKPaK9ZpRhEMpoBaau38kW67uh09p?=
 =?us-ascii?Q?oilGvg7EKsqpXkFBhe9XaVenwMQgXRd7+W48fda84Td+y1LBpBrqQCyWpxw5?=
 =?us-ascii?Q?BkXD0KdES2s3PAJoygNlYdCEsm6B2i1P5rHFVNdaglCv4Q3vuTP2GEqcirIh?=
 =?us-ascii?Q?Aq07z4wNCAP8n2yyrsCX7r604UsikFGtEmbTvZz5u8j5qeh3H27pFZR1uBAc?=
 =?us-ascii?Q?bHxRjZaKIe9gu3EmTyIs4Umk36APkRgKJ9y5b8nAPWttQB1b3clsqxeR+dpX?=
 =?us-ascii?Q?v8cdbtRHUaQmtM2v4Sih6X0+j0dgixMDliqnO5J+chL9JFTCoV8zkRMwgUKP?=
 =?us-ascii?Q?txIH4VKhegTufDyJVIK6pKs0AdF6W42S4dTE45qFKQV8Ctce2Gi36uNxbg0F?=
 =?us-ascii?Q?DqnS1h/q261/AViBMrD5mvH4dPQ5KI7ac6Dpx/IKULi5QBz/cW+Qyu6mVvw6?=
 =?us-ascii?Q?LLiF46BuxoRnF2wCxTj1TIZ4lkpoDCXv0yxrN2M0bhh/gDXQk7R9qmcLd50b?=
 =?us-ascii?Q?tdaKMkC5HM99pL/JhSq7TqI48vIdSZjrqQ861ogQ9nEB4aUvCZvoI5K7YBDQ?=
 =?us-ascii?Q?7V7e7UnI4/iSqb4K+PCXlCLueuovcgOzzYJgz1TXHs4y+7PzNKKPyymv3wrY?=
 =?us-ascii?Q?c+2iZhfA/hUa3B2SH+zQT8mYzQEIujTJfkW6wsWQD8qgSaAL3kfOygencUlW?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bfebc44-bb0c-4be3-e086-08daa874e354
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 15:02:01.1259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGn4uiYiAR+Kgxu+T5/jzXRBJr+scFYpD7OWqp2cP034lV8bhI2Mj+EU0bOw+a6ND68iqnFbK/4UFtxB25+cGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8295

New api:
 - add new data_init
 - add snd_burst in mptcp_sched_data
 - add an int return value for get_subflow

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h | 7 +++++--
 net/mptcp/sched.c   | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index c25939b2af68..cac5b0d512fd 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -101,12 +101,15 @@ struct mptcp_out_options {
 
 struct mptcp_sched_data {
 	bool	reinject;
+	int	snd_burst;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
 
 struct mptcp_sched_ops {
-	void (*get_subflow)(const struct mptcp_sock *msk,
-			    struct mptcp_sched_data *data);
+	void (*data_init)(const struct mptcp_sock *msk,
+			  struct mptcp_sched_data *data);
+	int (*get_subflow)(const struct mptcp_sock *msk,
+			   struct mptcp_sched_data *data);
 
 	char			name[MPTCP_SCHED_NAME_MAX];
 	struct module		*owner;
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 3d805760ae99..52b734e696a6 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -33,7 +33,7 @@ struct mptcp_sched_ops *mptcp_sched_find(const char *name)
 
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
 {
-	if (!sched->get_subflow)
+	if (!sched->data_init || !sched->get_subflow)
 		return -EINVAL;
 
 	spin_lock(&mptcp_sched_list_lock);
-- 
2.35.3

