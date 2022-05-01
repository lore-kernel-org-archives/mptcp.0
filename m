Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650AB28FA
	for <mptcp@lists.linux.dev>; Sun,  1 May 2022 15:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651419238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pRXun7AhwYyJhHV5gxfwVpOYdoD+WvvntQZZyp6SLJc=;
	b=dh3POv9gpFq850rpLk4KYcC3eycUArBnDONodG84pjDoeqdFL0yWLgCdrf2xWa5x9thjlg
	LCJlbASGvAJvK5Nc2I2ewZ2aYE8K1xCHOnpmTVFMI0RxV1qCm3vdkXYDB9FljQv5qhKG39
	JDe02Q+JOCFA+AG+TxVAzXyexEwj3qg=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2113.outbound.protection.outlook.com [104.47.17.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-3raXWdZLML-3EUbTCB6QoA-1; Sun, 01 May 2022 17:33:57 +0200
X-MC-Unique: 3raXWdZLML-3EUbTCB6QoA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJLCqNZD/9NmhIHoer0zoisBfLPmcJzLbfYM8tJk2GQJSbQhemTzPXX3OsDN5utmM9OHb3KzrZy0Eqh/L0ABILlvp18gf1OrgT/PxEi6PD+o1H3SE8E1d0h++sOmqw14qWkmgUtO/tslJCGCatTXully6vAf19dzUJXUh/kdwogG1PJRmbPaGVEML1KltMxsGAwKLJeywwCFwtkv8SqpA/4AUsfUJUc0g/Lg1J9mCrovmPnCGb3noLmpn6nLUTbzbugIRyXrlXsqVw0uafiJIJaKRl8P5a+5jsu4ukzn/YZ4ITVqE19SjgW3OtAQwSmkAX/48zHOmfUleWLk7ASfxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwktaNPHGbeLzEDGkxgiCFGR7t76BmrBJJXkrjIej5w=;
 b=h3a7FsIWE0owAtmgxVTv4+ynIGv1sJUqdxlOAxKNssw9L1wtSRQW/cz6Z7NdQOyml9JkSz/hHE1qUUbn2T8KnHSSDDTyvRq1YueKwd90jgRomdIAfaQMRNcgLDl8C8TWU1+LqJAT5FMxPWR+rn0svfJNHIcgLTKywgu3taAhJG9waTSj6H5vrv+ZQN4A9yXnnbpOpDTdXeqTgCHFhaeDalETuEZkpET8tocxBblPds947Lo7Ky69WtkunT3/0HeSjYhZU+KpWgTn5Dhik+MMcRN8UNsqkaVO8Ly60a/acRuuPKw0d5JGGI2ATf/9sKBRT+aWzhVhn44vKV0bbk9fYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9495.eurprd04.prod.outlook.com (2603:10a6:10:32f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Sun, 1 May
 2022 15:33:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.028; Sun, 1 May 2022
 15:33:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "mptcp: add get_subflow wrappers v18"
Date: Sun,  1 May 2022 23:33:42 +0800
Message-ID: <135258af10eabbdd638735348cae48c3b88ef764.1651419206.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: HK2PR02CA0217.apcprd02.prod.outlook.com
 (2603:1096:201:20::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfbff179-35f7-4fde-0e4a-08da2b880015
X-MS-TrafficTypeDiagnostic: DU0PR04MB9495:EE_
X-Microsoft-Antispam-PRVS:
	<DU0PR04MB9495BB7D3B7B3283038D3E64F8FE9@DU0PR04MB9495.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h6ftSeSkDnSOVw5LQPecCHNAGmcB42V0K0TTUqYeoqnwa7Q6p+i1il7yLFuK/JqWYK4SrP+4D2uTxxTsRDMOxDIJUbo7wed8iD43QIA6OI9OFCJ5sAysiJ6zQW3RVKJBruu6byKcj4B8SOGYmHIiP4OCso2ocVWf+AbyMnC0+AJ+h4wBrh01XBrd3xy3xUL16vUb7mRSlPG6ZOC7WaNKpyp7OJ6LI+7HTLbh6jxPjA+FPyX966nZnaYNC6esBvA6iIsyntl4LQ51nrua+/uQaWPqTEqOcYo4dpN29k2ZQIYfXMU2mP480sytLIt4xpMhIuQhKhhqR6I106AznOWsxEs07aP845D4dl7H3KRrkhyOYq/Uxi6ZQSuF8IqT1mdyUmxNGlqvdjieaAYkZSu4WGSdDp2okuEz19Bq6sJeQax0h2pMHjxkHn/mYAPbxhniteaBy+DMLylVNu9qZZvdH8gVVEr/MMJ1DgB/Aku/5LCg3ARhKmKHuD1LJzW8lDADLlRytrBH2EW8RFlq41zDgHpy/Q1a5KOzyizuig6yMSIp9dJiccMiWxrTfhLwlhC4lBeZDOTMyrfmwPr/50EP786gbILOl8VJQ98ASIc+qZQBVo18XDLtazStTVdmzbqddORBgZOI/8S9EAiBNpUT45YBdEImPa+7P8Ufc2Qh7GKQPgKJNUK6eCzP3mMwkHS0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(5660300002)(4326008)(66476007)(66556008)(66946007)(8676002)(6506007)(86362001)(6486002)(508600001)(6512007)(2906002)(6666004)(38100700002)(26005)(8936002)(36756003)(107886003)(44832011)(186003)(6916009)(316002)(2616005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e6/CE66FXvqwM9W8FFPx37ERlzi8NhvbUMmkU318WSrfB0yr98PpLdAAFRiu?=
 =?us-ascii?Q?1bZMvChYIR77EskjUz6JOjE1DEIqYFXVhCme1bN5KtNJ48yspWSlj3Cjlgye?=
 =?us-ascii?Q?54cLy3FsTzst3mOKbeEQbQ5joMnAwHW+mRc+ShWbJ1kvuLvB7fu/dycLzfGR?=
 =?us-ascii?Q?7umMT6Itztfpr/98ZC2fCc0v0NNwWzkJlu5Whkb70EJMeWPap+7KtBa1LDlw?=
 =?us-ascii?Q?lUPOerSdf5C1RfLzBXZ7lVC3Rfiywl/yaU6fvGxvANx2wEFJcooWlVE7TlAq?=
 =?us-ascii?Q?xSJgEw1YhfOYG/fgYGyv/XKIK+sFEFTSeiOrLaBp8YVB3K2zI5bfMRwHxylK?=
 =?us-ascii?Q?m9jF5og/DR2hkaB5FXdsPLSh2Z98gVL6AIBkaOpMNr5sdFy2xWr5pXoszNWA?=
 =?us-ascii?Q?uiLslVgyuJmWUb+8zlkyATWpZSgV6WFM0/EJX/D1lVWSWRSpVc/kDmrBZ1EF?=
 =?us-ascii?Q?MKtezGTP4kPAYeNJA1n2tSpGKZaaifI+bIcdusduihYUZsiXAmVLfxZYD8jd?=
 =?us-ascii?Q?2OOkuSNTYlBc2+qVWbAiW7Ao/fkzzi5b+/9j/m+QfcT9WrxIoxu8gs6ES1Q8?=
 =?us-ascii?Q?IWlQlnNV9gyTKaljiSnf2uYbkTGAA6zPeezRHDnypw9GF+vz5WPb2owCp2Up?=
 =?us-ascii?Q?ADRLDNLuYNcmulGun3FLHoYW4QmAvY9950f60QkiaWfx1oP52bEeagfQh3yl?=
 =?us-ascii?Q?tsBxTtPt+VA/LXKnZrYPMOe7SFOYOY/RBJB6eDxjmcqpbfbHpNNHiupX6cmh?=
 =?us-ascii?Q?FUgElptGy5lEXK5jKbNuwBaYKB6Z701xqxUrAQ8N+vCebhriyDYkc1u7Rc3V?=
 =?us-ascii?Q?XM+7BYN6XftaCM14acm4yjiCGYk2tCY/AZ6WKI6H72taRQrpm2hDuRZgdvnC?=
 =?us-ascii?Q?0qOeiJ8/XMAoEf6FVrss5CKN7ZAQTrIgcBXexMMkYLNLFnYZuKI/5KkSOmBM?=
 =?us-ascii?Q?HqclyCVL//1pTzqQucV19vvu18sA8GNR8XDzo/HxykPazF22MD3lJ0jRw/pp?=
 =?us-ascii?Q?YZ9Hb88wfwwxeY7uksHG4bpVsMQW+vbdJn253ClQTGaGRy++g89nHCTHEhs0?=
 =?us-ascii?Q?cP5zL9PH/NoLxwPcvmQaLNmJ1YvCxr1nG2jasV3lvb33ARa413AjbO9TWPVi?=
 =?us-ascii?Q?QEA7n0PJW3ch93whZS94DOODPxGn6dgstbeu3KxTeAsrrB/LwUJLBP6HFDl/?=
 =?us-ascii?Q?EbhY9VPPwP+Dvn0MIerOx1R+Q6NnFxm8SPR9owKL2DMOmIqhMMw0ZOSm7lNj?=
 =?us-ascii?Q?fx5+u0l7S0MdMTs27VgcVDA97pBBLH7ue0TXrlV+Ubp8RmjG4fENuGl99jMv?=
 =?us-ascii?Q?LRp/KndATmUKSlljXymGDRKBBOWAuNb7aogeSFZ4LcRTWegEAdtSOCLtXT7y?=
 =?us-ascii?Q?hvqw7kq49uN6ECFb7vmQAsx1KbYMBZakPXXA7mWA0LxgzVgGDarhlrMlVdOs?=
 =?us-ascii?Q?uukFpFOM2N5WqcG5jUTEFGQgdB8MIfMdNwVc1rV00MkdxVpnb7iuiAdPCBTK?=
 =?us-ascii?Q?0OTx5bc+Zs5ZpfX7VEd8S/M/Ix6iZJqstS8woP8kCJfN4OJp8u1+L23D1c1d?=
 =?us-ascii?Q?pYOsTuXF0NWKIYei09CzOSYOlssAxOMIbU8TvsQrs+ZT8hjjEvQhUJ9+dhlk?=
 =?us-ascii?Q?IsvOzJV0Efbeph4QUE5UHrs8Q/vOQmZiOvhi+OQpa9jX9G9PRYRLNZts/mDN?=
 =?us-ascii?Q?+Mz6W/BcVAR7sNaIvh5YAKQumod+gygdOAYFRkbNUwLG/LDbzIF2Ju2m4hnh?=
 =?us-ascii?Q?KjW509Eg3mQTaJoXC5lft0GJCjV3Cmg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbff179-35f7-4fde-0e4a-08da2b880015
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2022 15:33:54.6085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b9jCZBdwC6BZCcyQRlCVOCJ3SXXIinrG3Q8J8sKluT0oUUV+VOAMn89LmJYRgZgimsjcSR+qtcJcxgN9ubgJKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9495

Fix build warnings reported by CI:

  CC      net/mptcp/protocol.o
net/mptcp/protocol.c:1430:14: warning: no previous prototype for =E2=80=98m=
ptcp_subflow_get_send=E2=80=99 [-Wmissing-prototypes]
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
              ^~~~~~~~~~~~~~~~~~~~~~
net/mptcp/protocol.c:2213:14: warning: no previous prototype for =E2=80=98m=
ptcp_subflow_get_retrans=E2=80=99 [-Wmissing-prototypes]
 struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
              ^~~~~~~~~~~~~~~~~~~~~~~~~
  CHECK   net/mptcp/protocol.c
net/mptcp/protocol.c:1430:13: warning: symbol 'mptcp_subflow_get_send' was =
not declared. Should it be static?
net/mptcp/protocol.c:2213:13: warning: symbol 'mptcp_subflow_get_retrans' w=
as not declared. Should it be static?

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.h | 2 ++
 net/mptcp/sched.c    | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index fc5dca44470c..8e0ee891c423 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -629,6 +629,8 @@ void mptcp_unregister_scheduler(struct mptcp_sched_ops =
*sched);
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
 struct sock *mptcp_sched_get_send(struct mptcp_sock *msk);
 struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk);
=20
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 7a5654132ed3..3ceb721e6489 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -15,8 +15,6 @@
=20
 static DEFINE_SPINLOCK(mptcp_sched_list_lock);
 static LIST_HEAD(mptcp_sched_list);
-struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
-struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
=20
 /* Must be called with rcu read lock held */
 struct mptcp_sched_ops *mptcp_sched_find(const char *name)
--=20
2.34.1

