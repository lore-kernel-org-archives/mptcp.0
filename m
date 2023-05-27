Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ACE20EB
	for <mptcp@lists.linux.dev>; Sat, 27 May 2023 12:56:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVuprhM2Kpue0z9Frh1RPAEcjtm3h6QukSE/pbHVGRnUzvfSnOStITSD5A1FrNN3qHOe/PSDjqd35b0E7YqCfSUfpLrJIorb+UK0Y2Wps7vDtNq2lJFnk9+TctXhY2jtxT5sbxNuqT1dtU3qcLeZUrkfKvOX7KBhZtXmEli4FsVgtrQV/z3pR5FfJ1yNx+P4OIhO4fj1erGAROU7Asv2CbyE5ZJpbz+ENTC0HRCrzWOmACmfCEnC8CS2COWf/qcY6TRMdwSVZriBf4567V6TQGWtFX2PKq9iB128oHl+GGbknsgCbREcM3BzhGc+1rvs/+IxCFV0lM8+KcbEvYPG0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UK5Y79Per6GMJgO0SoIuINhs49NEm4DbLqKMsmC/DBU=;
 b=PnBZ2UUH2JiRi71wIH8zO7QctnC64XJ5ZTarku1EszgK6KDMj84Og7oq1eRex+64jaByAZCf4j2CtOQ7zVYqLckl6qxQqTZ0ulDsikZbBLl4o0X/gMfE1rpVPPOlpe4Gw6S3xBt+MK7BXsxAE5WZdDYNPa24F8d7IUFUlhM3uiOfIJp4OR8svmO7CvQa6L/8AQCZWGB/vnfFMu4Sdldsgr2HWuhKC8kn4yxQfdhP8V/KwFhBU2ogGtv8gIk43eV8JBIs+d12NKO+I0u2P7URIXx2UQ8FgxHhL+LIj09SLVt55eb8KdiaesP/KVFrhE1xEwTEgyBv5hWomsvdv00CwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UK5Y79Per6GMJgO0SoIuINhs49NEm4DbLqKMsmC/DBU=;
 b=n9DJzEMsq1zfvyF98YCAsaIXG/Zj9eYKd4WmF0NVd+GMKXGn5kwhSfwMUIVdmQqdaiS1l8JNzPd46QL53o1GmHkD/Bgu5jSxZ0MZkeV9jB0/S1D7NbVP7Z2X0BdBAGkii96d704EaOZuJSVl/t3xKho6YTMrsvE7rnCp6xVc2GimD/sTYg8KOVZJDLeQrvFrYDOCtv4vJnEGzq3+9C27z3W29o2S1Ic/pyOZSZy0MUZczxhj76i2WgphCv1n7dK1I6quYocxSaijQqwo5KmVHj9X8juB+V6tycn/4JaknwWgQ1m1Rqds0UCjlbUsnh/5YEFjKphOTCbhwc5saSd26g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8371.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19; Sat, 27 May
 2023 12:56:25 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Sat, 27 May 2023
 12:56:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 6/8] mptcp: register default scheduler
Date: Sat, 27 May 2023 20:55:35 +0800
Message-Id: <5da8df506f527dfb2b8ae2e5dc72ef28b7f4936d.1685191581.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685191581.git.geliang.tang@suse.com>
References: <cover.1685191581.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0132.apcprd03.prod.outlook.com
 (2603:1096:4:91::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e5437c-f62a-4ddd-e95f-08db5eb1c7b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TMGBqQPbQeHNNkX/vCVMJ5TLcgZSk88yPJv0K0z42xoPsaONtnpbr97AJSVGCxM0Pr3MzdDk1GqVvGgHFEujjryMqDflpSEB4wyepG2KLX8afBB9gDJRFvQs4U+v6xleUmNoNwsYyi20U/TQSsClYkv91rQlsq6P0FbxM0MGn3Tx7P4wEvNWAz6pF6yRLv/ctvqcXO6cyNieVq6KC/gazJIf3iyefy3p+E9IW2pmr23lCI5/2jPJraSGB1PyuaskLlYdPg1mU2tXQiJjI1PNgcWawxrE96smOaLx1Wimb7Tyj1mEtloTT6mjWvcRAFU2W37MLeZlObMyAK4LpQS07Qox8/ko/BtQvSG++b+LIoLP7gwCHdKIrXwSiX5AHShEFZtqqhswE4B8vdjhF0btPA9pZlcl7goOV0ITbKmb8SxTCHEZ1zLCF/1JbZS5W6x2nLK4rxCgA7ehzgYvNVF5MoQkX4U0gnWMeUnskKE05YQSl2l1kAv4MGBhy8uSqJJ1/R4q6bRG+Mo890nzaaMHqgIlgdnog3WbYrw4pzEkXRpZbzRi+Xg4yLqyAngYUsC4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(6666004)(316002)(6506007)(26005)(6512007)(36756003)(66556008)(107886003)(44832011)(66476007)(66946007)(6916009)(4326008)(38100700002)(5660300002)(6486002)(41300700001)(8936002)(8676002)(83380400001)(478600001)(86362001)(186003)(2906002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sEnTY++QQBxtE/fGneFIWq06al/UK/eD/oOVoi5mUIGwm5dQs8Ei5fgUQaNu?=
 =?us-ascii?Q?MA85M3uxrOBoREfJ+xtPXeUAPDpSHqeZ/DgrSiasO1hyX97jttWqLJJhFT06?=
 =?us-ascii?Q?Xss3StO6yItYZ0Bp6n/8lwoEr7Yvza2ugFH8I0sk80w5lKOZXzkag9DGWMyp?=
 =?us-ascii?Q?V8vdDhnEehhFSbN3Ny2UkTL1VtoaLsTNYOIJ9dIEtTYzMPqUTSzLLs/knbDo?=
 =?us-ascii?Q?B5qpnVCEDQvZvz5qZL/Ljrso8xprAghzlDX+ceou5Vt+R5GKg/CYa1M6hHA3?=
 =?us-ascii?Q?ZSs8fjPeosPPt8O707KBngp81CnBuQbZgWgEei3zi6zMMaVTZ/CbJGRWVwJe?=
 =?us-ascii?Q?fcxiyLST0Fya9ZNBzhcHNbtMBKruUrxo4At1arkfooOFEr8GWl7QJWJxLmvj?=
 =?us-ascii?Q?WPsU0NaQy2D+5wDWHltscxcTtK0/GU8h91pdDrIqGSNRd0JxrmRjdml11H1J?=
 =?us-ascii?Q?Pdik+W4Sr3Ykdt3iFq1CtHISBua+v3oxrBxg92GjqKEo8DAV/ydTqaTCbqnm?=
 =?us-ascii?Q?C/4bfgjz3HeQKtYzLkBzFf2ds6F98fWu5c90JD2s4yfr+E/6bywgDFpi0BhY?=
 =?us-ascii?Q?qwOiBBIcQCPpBwEI+h5QiIAxvupobpMRmgW7OSTD8WXxirPQh4S5YmJ6Vwkz?=
 =?us-ascii?Q?yz4C3Ipa5oR0YF1xvzGINVCJWIOiZ9iC/I6bAQIKqV/KNnWQdIyYvkgC6uOB?=
 =?us-ascii?Q?l0Ta0dzuYCqrNgyKO1MwoVTkFfg96ZB168iKBtw5U0i1You1PYGjDHTmxKCn?=
 =?us-ascii?Q?gzxgMpcklV9jmxYcVZQBFuiXUcWSlqTxldmaA5RhpFCSPVncv2n7+MKHonYX?=
 =?us-ascii?Q?/C+bZ11gTcWDaYEHybvSewYnjnHh/B3DaxYQDKqWrs+rNdauewLXBhqieUsV?=
 =?us-ascii?Q?EDWBxSwUBxcpBj7pVsJQrSArntDCZn9uDRZCV5Y22FmNuOYbY7XgmOrRphNz?=
 =?us-ascii?Q?EFlfSWMVBT3928uuGdqZv+pgFAbCVgjs8XQS2xkhzK41KOudbp1j9s8emXgS?=
 =?us-ascii?Q?mS9CMuW3tOmgdJybLuzy/rkrLOWnSMXm0Z/UsXi6RnI2qxJ+CSkJLCvJ5IqF?=
 =?us-ascii?Q?8CsAVqegzXaWPws02nEEPPpbQTPjdkfBhcYudhbcZUyP0Vre8WRttxOxTmDf?=
 =?us-ascii?Q?bE1967hkIZei7X5l+1wsyctmC4sZIEJ9W8OMjsJ/1hVCLyafpI2DZjO0D40H?=
 =?us-ascii?Q?XrtTKVRdsmrC4eIcgVOyTfjQxN+/EBbp6lO63egjhuMjyKu8HcsiX4L1+H+O?=
 =?us-ascii?Q?QOyqtTuqxL2oJz02Orwj5r5boJqm9yo1CY4DbFflK7ldZSnvqr4l8sfwLZwg?=
 =?us-ascii?Q?7QjhctpSU+rTbg6OLChxAzivCrXrYFm02D+0ZH+yO8aFEK45rCn92t3EftaZ?=
 =?us-ascii?Q?uqqq33NVLoeG0Pjd1kfN1SEY2ZbsHEoa08BuUGcQVe+xbay0DXduY40ehAnI?=
 =?us-ascii?Q?aWGIm1KIqjZrhwFWwhOHUivLYOHfwwe62JncnDOLhwwpatNVTLR6WEFbU+ym?=
 =?us-ascii?Q?Jn7qWhTZSn47W6J1vwMSYZPw2xL2f6w0j+SNNiFUTI2Mzw+1PrbwtsZfypFZ?=
 =?us-ascii?Q?WM7ezzQMxRUzjm0vrnsQ5z8TvQYYf7fYnM8OEGig?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e5437c-f62a-4ddd-e95f-08db5eb1c7b0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 12:56:25.9084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bYgevWqbaZcp7lh4PSkgj7+UxpJzxeYX1s/NQL//wxapaLMUp0T9MXKigu5PUre2LkaPBUsMPvjB+nwyFwNhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8371

This patch defines the default packet scheduler mptcp_sched_default.
Register it in mptcp_sched_init(), which is invoked in mptcp_proto_init().
Skip deleting this default scheduler in mptcp_unregister_scheduler().

Set msk->sched to the default scheduler when the input parameter of
mptcp_init_sched() is NULL.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  3 ++-
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/sched.c    | 38 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 83bdbd0a7bbc..5447f8b0598b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2278,7 +2278,7 @@ static void mptcp_timeout_timer(struct timer_list *t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
 {
 	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
@@ -4005,6 +4005,7 @@ void __init mptcp_proto_init(void)
 
 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_sched_init();
 	mptcp_token_init();
 
 	if (proto_register(&mptcp_prot, 1) != 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 760fdd888e31..9552d5f581f6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -651,6 +651,7 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+void mptcp_sched_init(void);
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
@@ -660,7 +661,7 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 				   struct mptcp_sched_data *data);
 struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
 				    struct mptcp_sched_data *data);
-struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
 int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index e1c8548a52c0..69f9e56ffff9 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -16,6 +16,33 @@
 static DEFINE_SPINLOCK(mptcp_sched_list_lock);
 static LIST_HEAD(mptcp_sched_list);
 
+static void mptcp_sched_default_data_init(const struct mptcp_sock *msk,
+					  struct mptcp_sched_data *data)
+{
+	data->snd_burst = 0;
+}
+
+static int mptcp_sched_default_get_subflow(const struct mptcp_sock *msk,
+					   struct mptcp_sched_data *data)
+{
+	struct sock *ssk;
+
+	ssk = data->reinject ? mptcp_subflow_get_retrans(msk) :
+			       mptcp_subflow_get_send(msk, data);
+	if (!ssk)
+		return -EINVAL;
+
+	mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+	return 0;
+}
+
+static struct mptcp_sched_ops mptcp_sched_default = {
+	.data_init	= mptcp_sched_default_data_init,
+	.get_subflow	= mptcp_sched_default_get_subflow,
+	.name		= "default",
+	.owner		= THIS_MODULE,
+};
+
 /* Must be called with rcu read lock held */
 struct mptcp_sched_ops *mptcp_sched_find(const char *name)
 {
@@ -50,16 +77,24 @@ int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
 
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched)
 {
+	if (sched == &mptcp_sched_default)
+		return;
+
 	spin_lock(&mptcp_sched_list_lock);
 	list_del_rcu(&sched->list);
 	spin_unlock(&mptcp_sched_list_lock);
 }
 
+void mptcp_sched_init(void)
+{
+	mptcp_register_scheduler(&mptcp_sched_default);
+}
+
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched)
 {
 	if (!sched)
-		goto out;
+		sched = &mptcp_sched_default;
 
 	if (!bpf_try_module_get(sched, sched->owner))
 		return -EBUSY;
@@ -74,7 +109,6 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 
 	pr_debug("sched=%s", msk->sched->name);
 
-out:
 	return 0;
 }
 
-- 
2.35.3

