Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2040.outbound.protection.outlook.com [40.107.13.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7053D8A
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 09:00:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7sSzL0qECK6eQKx+48ifF1hreGsS9382xdsFW2SIQ3aAHC1h8hcLr5oROzdUnA3lom2TmBgNE0TYn+r1NKaQPWld93gpay35FMnJgZj+EkJ70292IMy8gA9GfAX5NQmGE/aWl794uxosKKel24Rj81Ibe1qzFMyhg65ItLBuPBPy66KG5MxSQxeHu77zmXRKe0sNQ+/uDVBsrj641wahYk+US2clxwiZD4Mn/QqZKGw1BxZ/cgFJLrcyvKF2GxKoPzXCdQ2uus9MNU4V7qHDmDubr7k6QGjO07AEa6gGFhCqjjFu1moMEPnvimkWcpSFqlsAapM33YUU1n3e51m9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChUCjRiubFR03LB6GTb2pMI9Y/Bstw8T5WguBdon494=;
 b=dtIQugAl+wqipFHTCGMenTD2qk93kAKWWSuoFQtXNQ0xxHEsuvWHV8RTd6pzcj3/JI6LMwtCFkvY7kY3vKUYc4npM0Zg7CoBt6gQ76zaph0sXRdXzhJ+YItKA9tjTcu1RHE1zRgcNDtk3HQEtfEsC3SeGcij80+iAtIcGzOJ3VYp/HWyXGfp4rRJM9luTklXYrZ5fSDfGz/esrUlfrbDpZEQIscWFZcJ2g7bwiJtYqQCQI9BAqpyqjXarhfyUdRUXotYaz6oMFGBWuv16Xj9MDX2FcDI0Yt+fuFGV7JdAIDtHW2mdolywC0iYIkgQoFLuyagFdVGbqKcJWIOWPahvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChUCjRiubFR03LB6GTb2pMI9Y/Bstw8T5WguBdon494=;
 b=39AwpymzSxr0nejWC1eBL5X9tudfrDlXiADIHfyHZv0ckbLXx3GaeAoeuIaF2ACNWYBwDhENvBu1kor7Rv5fpzHN6Mg2HB72u6I/HJvIgPqYqjFhStMEKMqLZU+lq8geBGrYs/+30xbVbOdmH1e/nUxEXfWLV6sxpXDA0NsfEQ94Aazv+KU+Cz8c77EYpynT/jrPOVECz8dkN3KTm+2BnHvNRz0PaHYpdTWrXT0jScDrAIQtwMwwFk3QDaX3d3sPb/9wcL3zLew6bgGUs8jme4N91azck898BjeF3tXa3KW/3QpMIRptifAxv9UaG6avhYuAfxL5o/NHxmWPur2m8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS5PR04MB10059.eurprd04.prod.outlook.com (2603:10a6:20b:680::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Tue, 6 Jun
 2023 09:00:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 09:00:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 02/18] Squash to "mptcp: add sched in mptcp_sock"
Date: Tue,  6 Jun 2023 16:59:16 +0800
Message-Id: <2fa14365a52e6b9f364ca03da86edf14df342633.1686041504.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686041504.git.geliang.tang@suse.com>
References: <cover.1686041504.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0227.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS5PR04MB10059:EE_
X-MS-Office365-Filtering-Correlation-Id: de016ed4-11f8-4405-c3fd-08db666c736e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TGdnKnTkEGDPL7kSY/Aq5ZPP44ShSwb6HROt44VvvwhwXbLDDAM8LnuYQaYzL7fMR1FJpYQvoN6nzgSWwdasSQ34KIiquKNgVtg7Y63oLxNV/M3ohvNXPRD97C25CvI6VTffl955N1LkQcHhIiTfLg7OosxmB+LS9ZklRDS2s24Eg8lodY9dDExCTRoES5azLn8O/BqSjHoAJRW5j8CMVs5QXmbhV7L+mkQHpfj65y4on6SPd4LEd6sdFwIrnIGOm7V+nEASjFyHXFAHmU6uSBXRHS1X1hPljKgTJcRLDwGgKniVX34QHzr7FuW1H5PcAYYKytpDUl60HsPER0cOzKzgQRdQq3afUiIMGbgidUPuIP9Yxo6puuyNG+f4okWntiiREBde1ylr2tS8HV68CcVRNVT+3gIV4shbL2HrGojcLdvfEfxg79L1/q/t76asVzlrjnEVP4knNAhG+qnhiDZfMPnNp69ENA1ebemMcOr9XAIptQeQhe6n6Kk55K3iMJmMmrEnkuo1JBAFnNrFaPcYNVh2V0BNKvqyBI9uxmUmS008IOU/6IBbrHWSvlaG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199021)(6486002)(38100700002)(6512007)(26005)(186003)(5660300002)(83380400001)(6506007)(2616005)(8936002)(2906002)(107886003)(44832011)(41300700001)(8676002)(66946007)(36756003)(478600001)(6916009)(66556008)(4326008)(66476007)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8qqc0I+8Jjni2qRAmOsOyWK8t9iglcCeGuHZ4ZJms/ijLpsAc+QQesqvWJ1P?=
 =?us-ascii?Q?16GwcGvZ1Mtmii6I2ms1vpdrJn7EhznlLHxdwiu7oT8h9r6GIxICRkXY/MUx?=
 =?us-ascii?Q?Ie/6ZX6H9fqOaSDpEwuj3XaOgRSnX9R+Yn4rFO19XKYUqpqZX/tv/C5razFt?=
 =?us-ascii?Q?7F5iMRvFc6ffAq+NvZJu1P/uw4JCmQl8DUOrUZc1MIiqc3xPOBp+6/HOCjiL?=
 =?us-ascii?Q?PAdePNypDDJr7Imh6ZJHaUrkdTlzBNVbqjPEcBrJyRQCE07CEyroyW+6y6au?=
 =?us-ascii?Q?aS9y2vWdQ9rfudl0C+U6EBRAwyT/SvB6nJ7Wtf+VmDDB4y6Aq9ppOqne8bA1?=
 =?us-ascii?Q?inHnoIBt8BSI1h3lEaX/Q8Hy27WzA/pglNgQSKUvgGI1YxEUZwKaF3+iAvjl?=
 =?us-ascii?Q?/CASzNqs3xR9gI+Z/88lgWYBGt1pK/Gmzqa1qJcyShxyQbtfqZE22r/LdjOb?=
 =?us-ascii?Q?RSywGkvrYx+EZwTyuvS3S1MnsYNbf0kKwD82DRdB7mKHPV6ZXeiqGcOdf5Ba?=
 =?us-ascii?Q?YnfdPKEZWPOEf3hnxyzTEqT7AHqosErnkZHkJn61drLoUiMZ4vCaP8gEqdPs?=
 =?us-ascii?Q?LHHu1MuqgrdlBoAKsTF1dDFZiWQbQT/zHbsN3+XX4X1OULhwOswCBTX7nTH8?=
 =?us-ascii?Q?7bpFT7FQ25FxzozCCU55wIJ5ElbCkDPDUheRKDQ0XhgEfmOeo+B1soVaQmyV?=
 =?us-ascii?Q?pgG+3K06jCwUUF3l3q3j+K/jksGkg/H14zZns9z1ClnODO0GQe2kImPfayzW?=
 =?us-ascii?Q?WJBe93oW8oqG5GXQwEimWuHMRtzCdKrutlk9M7SrBDt6gYFtlJ73zdojNPET?=
 =?us-ascii?Q?ayCqx6mLNsiV785l7XicuXcZ1nEHXEzCcKrd1fvpOblJ5rC79rLbnhEXMHTa?=
 =?us-ascii?Q?rD8+GwIJJPEnHlWQt3MNjz5j2UbxIVeRdzjKO0c713dFNLPOzFVJLca4AIIv?=
 =?us-ascii?Q?EUBFbfmJj3JCAWFPvxFiLURRwAcGJydHf1Vs4EGPt//WoqfepcZTLVV+mw1v?=
 =?us-ascii?Q?eUq9ypiyMsKk3nLTis91Kpori/4/PiWC/NVn/w3AOUY9L0wVJiv/7LSmT5yo?=
 =?us-ascii?Q?+bEtW70Hmy6cQgHEuYMJQn1h1qY+HshKL+lVaUovyBwuZgc13DS2+QuH/IRF?=
 =?us-ascii?Q?I92oox9JSAzuWRs1u2n0tnu3ETEAOsSsjcunkENCnzO9oGJ/n15G1nlSicaj?=
 =?us-ascii?Q?inrTcFwK+WcjGzsb+0A6DGlBJ86aksr1Bh7tg9aIJH1CadtBwxGZvh4oX4WU?=
 =?us-ascii?Q?QKOalfFjgx7VpiPeBuCjcWoBNp9NmuIfGXrAkl37KF46T8zoQPz8S+2t9eNh?=
 =?us-ascii?Q?wlOitsQDbg4M1b5zc3uYbekUzzoiUuzoxp2zO/vSS/6FZvSkWaiagaSiTHsf?=
 =?us-ascii?Q?dwlcGmePu4+G6v2OBTfee+vHeEnseViSp25mJ9nRXn2HSGemYyFrW7xTyl7R?=
 =?us-ascii?Q?jgc4hCxYYBck2vf0f8UdSXlVcSlVm04psrKKN5dbTle9IIcB0og0cx5a+HXt?=
 =?us-ascii?Q?4Qk5zCo07vdfem6UM/h68YKuSEibue0km9z0on1ih+qZjGl511vxhXWn4Bnb?=
 =?us-ascii?Q?gGesi+uS4AfcxE/CCLdW+FVi/0KbAznDgk7RUrmx?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de016ed4-11f8-4405-c3fd-08db666c736e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:00:18.6010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OduD7BdUzMuiGwY4llzs8RV3i2lDRK4Sgvw2vYoQZRWS+qJE0vcs7eoBG6sH13h2JdtAE+RO/sEwGSP9fQBxXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10059

Add sched_data pointer into mptcp_sock too.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  5 +++--
 net/mptcp/protocol.h |  4 +++-
 net/mptcp/sched.c    | 13 ++++++++++++-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cbfa4c3ddc3a..380b7335618c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2825,7 +2825,8 @@ static int mptcp_init_sock(struct sock *sk)
 		return -ENOMEM;
 
 	ret = mptcp_init_sched(mptcp_sk(sk),
-			       mptcp_sched_find(mptcp_get_scheduler(net)));
+			       mptcp_sched_find(mptcp_get_scheduler(net)),
+			       GFP_KERNEL);
 	if (ret)
 		return ret;
 
@@ -3225,7 +3226,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	msk->snd_una = msk->write_seq;
 	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
-	mptcp_init_sched(msk, mptcp_sk(sk)->sched);
+	mptcp_init_sched(msk, mptcp_sk(sk)->sched, GFP_ATOMIC);
 
 	/* passive msk is created after the first/MPC subflow */
 	msk->subflow_id = 2;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d2e59cf33f57..ac05fc317689 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -315,6 +315,7 @@ struct mptcp_sock {
 				   */
 	struct sock	*first;
 	struct mptcp_pm_data	pm;
+	struct mptcp_sched_data *sched_data;
 	struct mptcp_sched_ops	*sched;
 	struct {
 		u32	space;	/* bytes copied in last measurement window */
@@ -661,7 +662,8 @@ struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
 int mptcp_init_sched(struct mptcp_sock *msk,
-		     struct mptcp_sched_ops *sched);
+		     struct mptcp_sched_ops *sched,
+		     gfp_t gfp);
 void mptcp_release_sched(struct mptcp_sock *msk);
 void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c7c167e48d72..a053a9504dfd 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -56,7 +56,8 @@ void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched)
 }
 
 int mptcp_init_sched(struct mptcp_sock *msk,
-		     struct mptcp_sched_ops *sched)
+		     struct mptcp_sched_ops *sched,
+		     gfp_t gfp)
 {
 	if (!sched)
 		goto out;
@@ -64,6 +65,12 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 	if (!bpf_try_module_get(sched, sched->owner))
 		return -EBUSY;
 
+	msk->sched_data = kzalloc(sizeof(struct mptcp_sched_data), gfp);
+	if (!msk->sched_data) {
+		bpf_module_put(sched, sched->owner);
+		return -ENOMEM;
+	}
+
 	msk->sched = sched;
 	if (msk->sched->init)
 		msk->sched->init(msk);
@@ -81,6 +88,10 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 	if (!sched)
 		return;
 
+	if (msk->sched_data) {
+		kfree(msk->sched_data);
+		msk->sched_data = NULL;
+	}
 	msk->sched = NULL;
 	if (sched->release)
 		sched->release(msk);
-- 
2.35.3

