Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208A22F38
	for <mptcp@lists.linux.dev>; Thu, 17 Mar 2022 11:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647515622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Udheg44YCDCgzsUi9I7VL/85NkpRWMZTbG8FykK3ATc=;
	b=IJgy4nyh5V5yEeEfTH6yNwKwwssmK5hPMbAT3QXvxNb8Zx73rVnd2p5KKRf7u9AzZGRzgi
	11cLQs+wPV5ig0jk/DqNMlXrZqZ6qnW1BRMEJZtJZc/C33gj/So7QdB4Veol/XFvYSAq2M
	kd+0+an14aUVrWE3bRIGPGeYzBG7IFc=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2055.outbound.protection.outlook.com [104.47.13.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-21zsWVmnM3WbGrrtZpB7fg-1; Thu, 17 Mar 2022 12:13:41 +0100
X-MC-Unique: 21zsWVmnM3WbGrrtZpB7fg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnSGR5s7cfY6gvhA5Zl0AzD5l/AKesQ1XBeLmRL+UU0TMvVJiQ60NwFEeWOLiJM/ysN/4gqEfA+OWSDtIGTvoRVc4uRfgoPyqjwsKzoMr16x6hrYHGEy/0IWEV1pC8khgBGr5tzKtesYh7Mzuhawm7PO2Fl9zkm2Z7/5B7521Zdwq0t0N3GekVbUbmtqJQWgFB2RW0PVdtLaP+KudyJmnEpyBYTl79rgE4y4y67gbNZuvc8J/QZnLFOZkD1OOxYmw6Iz/HHq28ehFI8npqn2Hn0AXOqFDgkAx96jJUo+5EAAXS2QT43bKka65fGsRE5tcxRCXjd/HesfMfyaVBn8LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+4PwirzxDMkgLp5leLNf0DgYP/UCJbEoTsIkb+WYZU=;
 b=LtvksrXEQg17UOVgJCIiPxVeBC6E6ynXpRdoA8uLVc4hzUPYYVJszIYeJATvHm/CFFJMOUb3U8LVGKU6UgVVv7ZTYD9w89w538HFu5/M2ZkrPe7FaPQtuGOlUjRjO1aPqiIE1Ea2SRJ71r2v0ge/kuApHKliNtw53MqalxhEAXGLZn1T6on7koXag9/38ZC/tAZxEsZURaGCQSOjwhhkT+MUDbUtPgXnSip8fXdHujDbPB7lYIoqTjvsz0anM7U1iRaGnYOtO89k5UvdsGXbcYqyOTOhRdkMQIJZEqC7fh4yF/68wt/GuNIiYGbLZSg8Sh0d/+M3LLjhhxb2vyTGnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB6429.eurprd04.prod.outlook.com (2603:10a6:803:11a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 11:13:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 11:13:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "mptcp: add a new sysctl scheduler"
Date: Thu, 17 Mar 2022 19:13:41 +0800
Message-ID: <517eba844c4178e8ee6dcfd511cb3d1911e4eb41.1647515607.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0190.apcprd02.prod.outlook.com
 (2603:1096:201:21::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2356d6d-b3ea-4b86-caed-08da08073066
X-MS-TrafficTypeDiagnostic: VE1PR04MB6429:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB6429A567385F4BABD49D34B8F8129@VE1PR04MB6429.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NiAMN7zJR+Svx7JPfn1+K5nIbWZVf4+LMWkhm1+pNaDoA28rSle2h7RCtBkWPnYlBya6/d2V/56RXq860YxYNYukI57mQ5SJei/zTYTi1fr0TWC/tGgedqScgx/7z/++56+12tRDfaLercvvax7yKY5QtjIhokm5P5GM3idlZYOKGZlF4XuE0BJYUP2Svv2C82y7PpaJlNABGVXa2ZpPC+Gi560hcWwJtRj8LRTFsH3/65scgt+ZuXJKhxCVnde5aqDxanjbKvXrc/XY3r0h846fFa2b5ulVBRCG4RVLjGExXllav3+Bf0cKlbqzkV5l51l9OFnQId/MnjRpl6ZGuwPM6C9uhb9EOPF2q8huHff4ERmj2FTmFeW/gA/Tpm9kTs7klZDKo+LeFTsgrj5Qujm+ZEpptSqDrIwq8bRTi9+RdyhOcv/5JZe+BgERHeHdbVn+cGVa5Naigu79Y9Ix8Mt6BW2Pv/sKdy+3mNLt7w7KjUgRtm0IMPYxc0Y4bj6sx/7b/h6t8Kf4cuhRNJN4jWyhq1hBmMPXK29SGb137a2QbmPCYJkbQdiCcpUZuL4kxYRoq+qITHFznYhyj0l/ltR0EhHJjf7m2V0Q95ruW95eqhAniD754T2i5c5HOmm5KwFF0hcHZrWInPFYDdozEj2qciSBECvu7Wu4FaP04LD4i4kXEUxDUJqhz2id7JkZzl6HhzHX03tpsbCplqGIKA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(6916009)(36756003)(6666004)(6506007)(316002)(2906002)(38100700002)(5660300002)(26005)(6486002)(4326008)(186003)(83380400001)(44832011)(8936002)(66476007)(66946007)(66556008)(107886003)(86362001)(508600001)(8676002)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?17nvPYwU4dRwM7JxX7JlQlBK61KX4Gp2NPRpJGl8mR91c0CIRunKt/JUZRoc?=
 =?us-ascii?Q?8gt3fgbzBBFLUc1I4w3/aHult+0zk3gr+PmJa8TlRNHYO44j7gRdHF7SQNML?=
 =?us-ascii?Q?ijaybqPiykh4LYG2nszrDaZYVpYkG0oFKgAq0ic7amh1ILD7U7tH/LjLaaao?=
 =?us-ascii?Q?a36YpTyCvnZg3FRrbo154d1KhDS6RthogiPZm4sSv5oxNofazKPqRW5a0Ymj?=
 =?us-ascii?Q?7VU09i34ciRyi669FXmpHSKRA06QrhUaD0+x6MkOhxZjUC2Tt5w2BnD5bjXn?=
 =?us-ascii?Q?I9/e1JwwxR3ZsSCKPGoUbCwLDo+kIF1mT+8EFxCwHpr5iZMGeyJTnd1xLmhH?=
 =?us-ascii?Q?sMFKK1m4SxtF65zZiLemdjdMVOoXRh5lnDfCqSxOKmgB/qBK/pzfyspn1gBg?=
 =?us-ascii?Q?qmrQfvFQErU/P0jOarHcxLov5uQOQEQXkkwge7keM3wAVN5/h9dbyrNJDQ1P?=
 =?us-ascii?Q?yVjmKy05BChYt3H9Cg82057skZxbDX+g4CFP1pHrwD5loRJGkxj/guCGBTKK?=
 =?us-ascii?Q?LPinHF/CnHbXvq/B6B3kscr8X5wNXoX5LhVDI0eFhYLLrsMjTd6VAnzVmAro?=
 =?us-ascii?Q?PkhmRWSbQXNDQLddSTkgfOG2q5TMWlVLKILpFS/F558X8INQePCY3IAkjbZC?=
 =?us-ascii?Q?h2ghu7CQ7wtBGHdRQQW+1rFglurNSai2qKv3/CBLFC75wRQaRAzj5hmFTzNX?=
 =?us-ascii?Q?k1HPmX8U1E6GeFljueooEQRV9+2lJ3ncJbmwSYQ0M8wSStWwEbnC+t7dhvMA?=
 =?us-ascii?Q?ypYafgocAE6jvjdbm5eV3kJtifjf1Uzb0YPmIJ6OsCmFc0o1rA5pazlFrcne?=
 =?us-ascii?Q?6vmSk4WE55Wvpq8pPNhnrZTwrpGfYSv3N7ONtOOys71zvln9rr07Kz3R9+4i?=
 =?us-ascii?Q?vEfuOFQWNAIdwPVamMkB6tjoZnog8NOYmvQDb1dr5995nhG9fcYm59zrOlmY?=
 =?us-ascii?Q?UJJx5DwNlRBj+xVHQ85I6z1joBPXZBJhlYWwS2NGkDSsbLvWIL8WYAebuyVr?=
 =?us-ascii?Q?tXmKKjpQE5Sr8omakf/XFvtFix+PGm48Vt2XwIJ59uutF0Uwlx1nZDPv7g8X?=
 =?us-ascii?Q?2hb6V9b+DbZXU8Ae+6P3b0NkSvGbs3ye+/5gkh0yH2wuiWWogY63ILhgdMD0?=
 =?us-ascii?Q?y7yEJSvwlp4fWlqWLVTp8m5jdRDStyrGVPzFj2MgeqNkQcqL4yx5aSWnX5ew?=
 =?us-ascii?Q?D4ONeXRNPVsabJ5cHO06aftM6U4p4ApPEvULGhTHBvJMstUlnQNGC+qkYiJ5?=
 =?us-ascii?Q?7lC3STtMN+B9ZbgZyXYkqhRGx0wvUAubuuZ1h7R9TIpISvd14KSzCZqAY52k?=
 =?us-ascii?Q?TS0X71c73TWKeQ2JcKQODZPjyq7bhhS5iaKz7pkFCfO/99R8AR9qqAJXVKyL?=
 =?us-ascii?Q?iNLCcCY4JP4RnU8rzbkJVPyP99kNgq0Fx5vKdnUK1Abn+ajScfTN6oA5bSc2?=
 =?us-ascii?Q?oKhECOB/eSxzTXur48KynLA4clhR0QRgXD383due2s46m1UqZ3C5lw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2356d6d-b3ea-4b86-caed-08da08073066
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 11:13:39.7432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5vIEZjiGOWsHgNVp3fTVgdcLfZ2TCfNqXBKjO9rdxy+jJjpOqmxZo9hzpdOdJlg1ZMRXzqTf0Nylrhj4EfFOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6429

Add consts for mptcp_get_scheduler.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/ctrl.c     | 2 +-
 net/mptcp/protocol.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 4e0811969d8c..c46c22a84d23 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -70,7 +70,7 @@ int mptcp_get_pm_type(const struct net *net)
 	return mptcp_get_pernet(net)->pm_type;
 }
=20
-char *mptcp_get_scheduler(struct net *net)
+const char *mptcp_get_scheduler(const struct net *net)
 {
 	return mptcp_get_pernet(net)->scheduler;
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 33720856bfed..03d5de0f659f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -584,7 +584,7 @@ int mptcp_is_checksum_enabled(const struct net *net);
 int mptcp_allow_join_id0(const struct net *net);
 unsigned int mptcp_stale_loss_cnt(const struct net *net);
 int mptcp_get_pm_type(const struct net *net);
-char *mptcp_get_scheduler(struct net *net);
+const char *mptcp_get_scheduler(const struct net *net);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
--=20
2.34.1

