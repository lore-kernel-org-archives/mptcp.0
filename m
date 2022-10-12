Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60073.outbound.protection.outlook.com [40.107.6.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F30217CA
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:51:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOtlzyAE31n5tdDcY1vqOY9J7km4DAEjivEkhsxxfCrmKqaGCT1utHECtPFt8i/neXmqo+2N57it65eMOKXX4ptF/TeutPQOR6PDn1mOYCYD1xJJPh4F1dmYDcHTn5ddVYromrJZ9ODbBPupFOeoDr8VN3vbcTLw2EiiJASQ80SVB5PiSJCFHoEETQbBBjKiK0hwB5fZ9dJhZQ8S3/i17sg66Jc54XN4alTFt9jP0Lo25jNxcm85euRRSl0QC6+JV/BiSC2eY3/3/uYNgHmQkMm7KS1VhlaR0/37KTFjSkAZLYc0SL4n/s0XVrwWMldMbp+Qz6ZtRW+ky36r+yr9kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkvWR3eOrK6CESOXYU5jorf2JxV72aIBftIS/u7UIbU=;
 b=ipIhjmms6rpyVsnlyUV3Uc3+xJStmv+1Sk9Nvc8/wGoY+/7OTou9zQ4MEhNWQI9BuNqjm3uxV/jFnmdue4pSCVlBe+9LKcAKOhWvtbGc4sFZQ5Foobrrkehsfq/RsbkYf3/YVyogshWz547HlFCkQtJiaWvS3lpXsa56lH1W+JVRAAUqYDb/yRYrZyaghT3xvA61YCYB+iVH7inFm5Hy4/xl4r2PSPt7JBtxtAIedj21+IwB5rjyXqvgZAfhxOO/7W6HnbTBVBmeabJIpHJ18uuy8nsUlHrXk4FIhzX/Ausi1oG2x5XEAdH+B0z6g3XtUwpyhhFwlBww8aNl8eL3yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkvWR3eOrK6CESOXYU5jorf2JxV72aIBftIS/u7UIbU=;
 b=tkxw2ZQNMJtsqB/ld9iqEEEW3vVlzIsG/5vjnQVlzCHTvNAHdlmYExlxtR3UxSNQ2MATM5J8KbezUeyk4mYtADqEcW81HmltlTdNSE08hQiHdHvFgj9LE/Is4BRo+lwHE97+4swBE4ejYh4Ifwc+wVCto5mXJl69i3pmJqFg8ag/GAgUVvGjHwOTarMzATvHWajTTophDEz57FrrolmyosEDk3GaJO+b8fwANtZIzsnRNsK951vqL9ZuXuwIWkU1Vp2IurfJFgK5an+4/5bWUa+5IWzLGwLgqt83f7LuXpbVWb4+g5LN39kZpttesYJ7rZrWSM6ckBZMPtTSWaZI8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7722.eurprd04.prod.outlook.com (2603:10a6:10:207::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 04:51:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 04:51:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 10/16] mptcp: register default scheduler
Date: Wed, 12 Oct 2022 12:50:31 +0800
Message-Id: <47a6a4513adaeaa4111554ae880d150dadb9bfe2.1665549881.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665549881.git.geliang.tang@suse.com>
References: <cover.1665549881.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0218.apcprd06.prod.outlook.com
 (2603:1096:4:68::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: 79264f3c-ca5b-4c73-1ae0-08daac0d78cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Sh95YriTeoqlYX70BolRPrzzrURLVKGmpzjXIkmMzKCPHDyrXJYJ7gzSeR7xpBDWSzJigR7R7KOGYAITzuvmA6E4StFpO6aVLarqCKaVQm9HcF0L5Zf1fu6n1Fg42fcSbUCAMaRTV+VVIeYKWwOQv+kHH7oPtSnJI6GnQeZ0tUhIz/IOjSLedDj2d5xhAGWrCKllgbFRQZJsWo0531+MaQ5nIL8berXJbDhLxSRMMzISIAwv7R7p5knegXxvMxe7TdVmiM46WXAIr7Qt3YIVoZhv4tQ2ktFXq6xgkD/wBAiveb/N1onBoQf5hNDI6Fn2Kc67Yg+C9HrkZBNjaGYpbzVlCcie49QvE1lokx/vUUDjsrCVrTZWOScHAU37x4nT6kp+tQdBe3t1CoiLrAXCN6yoS+VeKYXMUqpDNM/EY9D2UQvzR9Ugrk8ZtM4oI01b4BWHW96uS6OXcu+JQVpodpSKESJxtIS5/Kq1EBTTBK/p5jS84dmUq0x6Dd43MyQ/Pz6IRQvfANSSIAIFbVgVBwN4OnuL23Xsxv7HiQtndR+fWNnIZ/oK5zrIa3zo4E0OwZ5nbjIeFe0QWTLhGpI75diGs3C7TJiEIuh8PdDpAmhFzLtV9FrEVGmvP/Ui/Qc4u0u/Wd4ZWDLclcJRmKK9ijGnV6sRyT9g0LxKuXyHH62vjJFCHNsyjpcl1g8HNPRI3/JlF1GqgTbkJhGbALtJSRzeYVOj5D/BM3rgdxDnxr9k70/dV/r68QGHrH7lhwgY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199015)(6486002)(478600001)(38100700002)(316002)(6916009)(186003)(66556008)(66946007)(66476007)(8676002)(6666004)(107886003)(4326008)(44832011)(5660300002)(26005)(41300700001)(36756003)(8936002)(6506007)(83380400001)(2616005)(2906002)(86362001)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GFs5Gy9twYkQfbh9RtBKmU8KHAMf2qDVdIL2jqqJtu5/wYp1/Q0v6Zr6mo4l?=
 =?us-ascii?Q?XP+24kfQV6lOpmnZH3dH9Yu/3o1daGaophUBHj4mVwXalzvIUVSThWFMRJV/?=
 =?us-ascii?Q?Wwp3Oa0/8rDgRDdyIrEpBQVMEV2Ea0bLiPbrPkM7AWnPbRyY2FeThAFdZDIP?=
 =?us-ascii?Q?dFuYgAIM/uiPyHkgR7mIPgJr81CAd9KviiL5/Z5WNv1D1wLTh4Sme++CogSS?=
 =?us-ascii?Q?1+Rt4W9Uv3NFLvh5amJ5CI+s6u6veCYJL395kzMxnQ5L03q7x2ElHp+Hjs0h?=
 =?us-ascii?Q?ckLMHsXMtuP4msaqz0JswHDsTSzTROyRsq38/+mK5oIdIKWb0GaM3G3NgL2p?=
 =?us-ascii?Q?fGjnl9sh86lh4YmQRzctE/khMpwXJl4wbw7D1zRyHwTg89JJURqvvlEdElu0?=
 =?us-ascii?Q?RUIycM4avuBiVOf6Cm/pIT2C6iQHN2x6S8eVxTRtYrNd+KFmhaCnKcH/2qNG?=
 =?us-ascii?Q?qpgPwpU6swCvJyckH+egiqVi4r80imvGGZL/ojagFf4g+u3YrxpNVNbg/9/n?=
 =?us-ascii?Q?xLygfGy86QVpeoftliLIwDCFGpSrZDIxx+HxDrbdHFRNuPGM+daNiSEtWCuV?=
 =?us-ascii?Q?oG+cBUQaFrhlw5S4Dlc4oDdMMggGTgLm/qM7E1t2JZEI7uzmffnUm2QGvotG?=
 =?us-ascii?Q?l0HohogLNx53IGuswWuGV/vE5c3OXFtCcoMdZ4/lefGqSLkT4LDIi+SJQsRK?=
 =?us-ascii?Q?TSHtfcWvDSGq2amyfaBbKMR04p5aALlgx79YHVCUcXJ7LyrbSA7b9ojnXUv9?=
 =?us-ascii?Q?dsIA6Z5mEk8opWk/YdJ/LSFF2VxH+ZZiSbkXV/T4I6hWkSwDAJsz4j3yX+jm?=
 =?us-ascii?Q?k9kMQf8qhGe/kWwtrHMmc/SJ7HPok8JB/rSU7oZDuh8KWNKm7O6peNdsk81T?=
 =?us-ascii?Q?U64ekQoHqUMGS1VMNDZRF8GyNCPdlKsZYM+L9SsjuI1sQB7guFeDLotSBc8+?=
 =?us-ascii?Q?UTSQAg1L/CvbiMPW31nBgSg/D6nKLhpSFuAuzGSmzMxQvyIn/NPYOYMP0Ji7?=
 =?us-ascii?Q?IniIbGcRNqRbM8kvTIi/OSGmZNEG2I3C5EQQsR88OBSSueIjzVeD8NVXpg+w?=
 =?us-ascii?Q?j9xLLoixLKO9El75295T9d7xIfDOb4S7cFT9p29HFCcWvdRL45ki7TLvuczK?=
 =?us-ascii?Q?fh+mlCQXEqyaDwkdnRyY6sHILoa8PBFw8DkynIUSaMi1RTYjbzb2EwSCrjut?=
 =?us-ascii?Q?FrugQbN2LjYcMq2Seg9t1Wy6nngNOv6+ZnUJbiluKLdO6QfKAL4y+7uV9gmf?=
 =?us-ascii?Q?8fnBU7hDWcrCPcKZ1vJedDWL7tAOdItXv5v9NVlNWZ7tchLcYzP7lgRLpxDZ?=
 =?us-ascii?Q?jEfD1tvjtSY50JWiAQp9kWB0f1mfXV9zdwkAqtSKxdeH4dBwF5lhm+jSv6jK?=
 =?us-ascii?Q?jy7KVom1VjQUswp7DEVWp9VDZ9a3C6OmUp4QuKXLCzQLgSOw6LueihaQRywO?=
 =?us-ascii?Q?FNRrmw7EzUSIRsoOB0jQRmsrYbJm229iMJr5B4Q3A1ZbJIHefJjGgt7cK2AN?=
 =?us-ascii?Q?BtA+Tg9dyxiX+z2eXvuvb7h6llCsdoOPawhKk0jNbnBN9W/qQ6dBYJl4vjmf?=
 =?us-ascii?Q?89wFK2lSdoyBtVRHBesKAdwdsyePS3VovCXSmsKvFmnvpFlXbuM2M1WNuRzx?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79264f3c-ca5b-4c73-1ae0-08daac0d78cc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:51:49.0665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1s7VV585QxY5DZrfWiMfSouAKYo1NtLLj9lDqMQGoQjoXaAV9njjNCHGeGbtKK1a0ilqv57LPwzYt/TppOguYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7722

This patch registers mptcp_sched_default in mptcp_sched_init(), which is
invoked in mptcp_proto_init().

Set msk->sched to the default scheduler when the input parameter of
mptcp_init_sched() is NULL.

With these changes, msk->sched will no longer be NULL. Drop the code that
checks msk->sched to be NULL in mptcp_sched_get_send() and
mptcp_sched_get_retrans().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  1 +
 net/mptcp/protocol.h |  1 +
 net/mptcp/sched.c    | 28 ++++++----------------------
 3 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3f0829ea2ad9..13d65542a4bd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3890,6 +3890,7 @@ void __init mptcp_proto_init(void)
 
 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_sched_init();
 	mptcp_token_init();
 
 	if (proto_register(&mptcp_prot, MPTCP_USE_SLAB) != 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d3cc84b15929..669584978213 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -632,6 +632,7 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+void mptcp_sched_init(void);
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 14b3efb347bd..cc9865a79ffe 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -85,11 +85,16 @@ void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched)
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
@@ -100,7 +105,6 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 
 	pr_debug("sched=%s", msk->sched->name);
 
-out:
 	return 0;
 }
 
@@ -127,8 +131,6 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 int mptcp_sched_get_send(struct mptcp_sock *msk,
 			 struct mptcp_sched_data *data)
 {
-	struct sock *ssk = NULL;
-
 	sock_owned_by_me((const struct sock *)msk);
 
 	/* the following check is moved out of mptcp_subflow_get_send */
@@ -142,14 +144,6 @@ int mptcp_sched_get_send(struct mptcp_sock *msk,
 		return -EINVAL;
 	}
 
-	if (!msk->sched) {
-		ssk = mptcp_subflow_get_send(msk, data);
-		if (!ssk)
-			return -EINVAL;
-		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
-		return 0;
-	}
-
 	data->reinject = false;
 	msk->sched->data_init(msk, data);
 	return msk->sched->get_subflow(msk, data);
@@ -158,22 +152,12 @@ int mptcp_sched_get_send(struct mptcp_sock *msk,
 int mptcp_sched_get_retrans(struct mptcp_sock *msk,
 			    struct mptcp_sched_data *data)
 {
-	struct sock *ssk = NULL;
-
 	sock_owned_by_me((const struct sock *)msk);
 
 	/* the following check is moved out of mptcp_subflow_get_retrans */
 	if (__mptcp_check_fallback(msk))
 		return -EINVAL;
 
-	if (!msk->sched) {
-		ssk = mptcp_subflow_get_retrans(msk);
-		if (!ssk)
-			return -EINVAL;
-		mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
-		return 0;
-	}
-
 	data->reinject = true;
 	msk->sched->data_init(msk, data);
 	return msk->sched->get_subflow(msk, data);
-- 
2.35.3

