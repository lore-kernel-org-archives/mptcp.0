Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92527A
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 04:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650430648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HIVn7S+y9Xdc1/M5E39oPAD5w+fP2A9xdhJzlnkWETo=;
	b=fhuFT7SsuPm5JJY4YBb6pa9Nu4mCLq66JghMbX8Qi/qTZjInJoAC6AkHR7Jt+bBNaDXkAP
	1Ij5TmlGC0nSoe439aAx7eGdVICQvV8BQ8D3HAqCkwB2RFJv5KqS/rPd+Gyyf5X0VpuchY
	dhUCkNO1Pv4+1+ZoYuVq3X9Dmmn7qFw=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-ODxLK3nWMdqr1PhC4HMn0w-1; Wed, 20 Apr 2022 06:57:19 +0200
X-MC-Unique: ODxLK3nWMdqr1PhC4HMn0w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OO+4AwOfNj9EbmrOtfMjlIZTnI1ytt0SGcOTEItB50avDhd0hklqXxivuSMysAfs7CY2KTMfc0AM0SLiJDzgJ3K0Mch7qRtUV0ai5ijACmIuIrdT3F1gf7EcHKoIqK4phlSxxtZaZFggPmz6pwqZGn8ZZrjqBfmO9AM/IXTaAJYUJ2Oz90kym9kZH4sCCDHgTiA25vLK3Pv3DwCV2xF2FUIB+nmcnugWDaNRRceBxJV5ndKXAgT4Xom4rbXYisCxLgmdN529RnLIN8CpZndnLJFvreFt6k03BG/MLt8MUzfbO29fLF8wTMXNhyDojywLKkDanC5uUEB5p2QwRu0/8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeT3Unm2LHkrcYgU07Mt2ZInydm4PZB0Y79DyhMIGGE=;
 b=I9EqHFGLNQe+ZWmcLcq/VXTMdozWC+4bKpWCuVe4ZWgohoRlUNeowPEHvNv/vhHilVNKO0QSGj5P5iqvOWasjpJ96QUfMt+z/bZhnkbmDmPOyj4lv+iRLdgz5m2TiMKG0iNKn3f9FJXWhZgKBRsCHmIVxPlf5UaBP4aySItR6ZAj2OHM3cfa63VBsA9PlyqKhO/4ZKuZizELjllB1tdF5HdjVZw3r/FzBLHo+3MUQ49wREQtdd6UOVwvEODLv+1qP0E+bYBuP1JHdNEiq/e8FjC2VZXxu3zzbKjrjiezbJS2DRys1foAfE7rOLxORhLz3FToa5iYpB2VxiWbOP+hZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB5752.eurprd04.prod.outlook.com (2603:10a6:20b:a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 04:57:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 04:57:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 03/10] mptcp: add a new sysctl scheduler
Date: Wed, 20 Apr 2022 12:57:02 +0800
Message-ID: <6b5019d618e5dc9c398c5029c2af3ca7ce639499.1650430388.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650430388.git.geliang.tang@suse.com>
References: <cover.1650430388.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b9d3caa-f4a4-4865-df27-08da228a3f11
X-MS-TrafficTypeDiagnostic: AM6PR04MB5752:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB57524293438A4D4A4E8A88ABF8F59@AM6PR04MB5752.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oJawo2FlWLEArw0LqQkVREHNLBnvWI/FRAeI1Vvu4d0ljFjo8KO/JiqLKCg9zRnrsl61EKASYFbopN21pmlVFuZptjt2j427j0XyUJanIdX5JtdGgQ1WKnfF4vkkiO9Ut94MqjSGfI1lvY9/rP+v11Qzb44yuzuJ3LjLMCIiJ2e1sseLFEkVyxZWLe6gasvK+xTu667ctmWryYQfPVmYfF3OV17dpKArTq2b+PxmBf45YkriM7kQ3m+PE4k5EIK+wzYO5CWbZJS7coA7AcIVuUDnMzv+4sQYosM4pQEg2IjE4yRXO7NT6y44Wa5ew5PivNhpfhOoFkTZQCLZ9LgDdptVJpzbt3da+J3+T09aQsnf/2S2cVDYx+ATg73MJTkifEQFXcdG0ZGSe+ebDIToVT2NnOMISR3nsrWIgRYuUA6aPmCozAxw3S66OPrTGMo4HqM7+J7ZXwsJCXWBFsNSaChawvr50JqWvW+6WVuJthNi45kA7wU3RuuPOOuo4GUOvUXXN/fKF8F7O3rPihLCKpfO/xa/cP1JYozlvqC01tKRRpSne/JUMnvwYaOL+NpGsR/mLg/lby6s+hIx4z65BVeSvR6SuAnMbOhfC7h1jep0uw/H+n7lrCdUZsJsno3MWpyYUu40tZecvEgGGK99FLOu22LKtmQvKqA4v6d1u6rJP/Vp3KkXkJhjYKvM4zQM87IyF17+s4FnC1dcg/EIsg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(38100700002)(508600001)(36756003)(316002)(6916009)(6486002)(66946007)(4326008)(2906002)(8936002)(6666004)(8676002)(86362001)(6506007)(44832011)(107886003)(6512007)(66556008)(66476007)(5660300002)(186003)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B/l0rVetiVFnRxtmPFdfatV81AsyOZ94Ojh4InflBnZnV6i3SiVn7NXUxCbT?=
 =?us-ascii?Q?aVEQeI6tmMYDQLWx5XjZh1zcJdTdlFrd+ejh/MQkKKwm+lT8kCccYm3yz6JB?=
 =?us-ascii?Q?WCps2g0IQcKh9kLRWkRMNgtpkAjzNkHr8gIzCyT2WUlttJEUbPo5spmsoEiY?=
 =?us-ascii?Q?TiorXllKWwZMQ6rI9jTl19/2A3K6/hOR8nQ8BTOQXpyb3yyOHGhCpd/00pZn?=
 =?us-ascii?Q?y5MY8+xsGC7I2iBIwkiDD/qwQo44pwhckL5hozwkDOoIv7DTkDYvaMGnRa8Z?=
 =?us-ascii?Q?dfg9bIN3wg5kYyVj/Kb0i7QoadAIoyV8HpXBcPQjWmFZQzy9BlJvnzTv+T1N?=
 =?us-ascii?Q?+WSleZTYxP0n90W2/VYg0nqhd7TdX0waHpVi3pA0ecO6uh+6NUNFng4cSZVw?=
 =?us-ascii?Q?GnbsS6RU1NgVkCn+Y+Pnom0vriRqP6ta7UTd0kXUg6H7I09LnJR1IaSLcokd?=
 =?us-ascii?Q?dgIcC2UcYBrRda8ELpS1FcVJjw7W/uuy4XijQNoLbtGTvQ+FidpqkSNX/OYe?=
 =?us-ascii?Q?4e2JoTZzyDyrJcHE5l02bGeajTyTQAqQPDrnQTil+gfjNdiSp7q4Tyt6nJu4?=
 =?us-ascii?Q?tEdZRgSOswqJb4fSdwxpJk+7S5N2Q3Fdp0ocEw8vYt+rIpXhldiWf/OyJlrE?=
 =?us-ascii?Q?/RTOuQjZor5fww8Au7FmgLFu1IirvA0FYDaOTSEDQ34KwyHs/c5ZVxAvtKSE?=
 =?us-ascii?Q?C9YO4pZZ6Bk6iCLtcQyljzTANqzEXUn5b1xsVgSNcXoKBa6ma1tVz5Lqh1fl?=
 =?us-ascii?Q?lT3ftLypuSBtr3bl/co1ewaJ+dY7T0BGN5Um8b7D84HNngWxmMgHZHCwBUgL?=
 =?us-ascii?Q?vtTX2JxaMmxuO1wtNz3hWjBeVQWaf6KKbd/kKNXA6fnjb/ghMZkFZmGNES6U?=
 =?us-ascii?Q?O4dzNzLoW19ValWu+xEUX1UXKS8sEupbR0ipjPdIb4ByVSohbZ0jQCyhK4kN?=
 =?us-ascii?Q?8TOAFUgjKBMjjzBWS6l6l5jMiz1gZ9lrZ/EX7P077wYXMB9Z6Z2ByvhL25hx?=
 =?us-ascii?Q?OHqhFSFIomuErkPDV6ObVzxJY6Efji818UcCDbFTpenhdi4zYFvVtwQsYZST?=
 =?us-ascii?Q?C7WflZ7Vqc8HzASnRHtwb7VyvFhYp3SfLhj/Eq4G4xXJoD4keQKLQEfWREwV?=
 =?us-ascii?Q?vLsLd3q239ywFP62vwJIkxB6Bh0JFE1rYiPscVS0zRYU9qlEkhpU3d78pPXX?=
 =?us-ascii?Q?rrnsYnYZY4hAv9NvcF9I02PI75QLqNe9NGeeMmINSF/NNgmHURA0VIvPvZHR?=
 =?us-ascii?Q?iBW+aWGgLgr9TA5K+joMcz+7p3wZn8a7O6umR3Sqt7DPC/gYIXG6vgQoxxVI?=
 =?us-ascii?Q?iRmteQ8ta13+/gycY2WU41yKAFWTsdt18fs1eo7hC9G88YeWzOBqb3GCLaW3?=
 =?us-ascii?Q?U/REBUfFTzSjsKyxmKbgNxfH83rzyGPCtUI0bBOx0buSw0WOxUEyzCIJUhvF?=
 =?us-ascii?Q?//81HVRdy9vbKdekNW6pUX+ia+dwlXmQg8a6qGK3JaTvHkHd75BJ7XXOSwl1?=
 =?us-ascii?Q?HHyTFR0gnMoJ//zczT4i/hdOPbJjX/8t5DsCF/5YOY0w+Hz7cjWM5jWHpKvL?=
 =?us-ascii?Q?jRfxeTtTkEu5x5lAiqmsVO5yeHVkGaJtMn5M25xv8jz7bl1/foPsZ+UvTNZx?=
 =?us-ascii?Q?ImvXXAUlxR+T8mYBrUTqCiHWkmVzhfcPevOhb6B0tIMv+l7Q24ZRBgdQSSn8?=
 =?us-ascii?Q?dxi1J8u7x3Cbq+KF21eamtC+GHn6uVeLtqZVlehdo2I7z0mkaEVfSsMOnj4B?=
 =?us-ascii?Q?jzr5+//ZmO2b9TncrG+HzoAJlmFKUHA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9d3caa-f4a4-4865-df27-08da228a3f11
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 04:57:18.8438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/98lUvgrfAA3fZVFGnfCttuckPYyxSmXmuG/C6zAtrXqDUXkdq7ZnwrpYghplabWFXgAtRQRIpJI6J/Xmz/vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5752

This patch adds a new sysctl, named scheduler, to support for selection
of different schedulers. Export mptcp_get_scheduler helper to get this
sysctl.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 Documentation/networking/mptcp-sysctl.rst |  8 ++++++++
 net/mptcp/ctrl.c                          | 14 ++++++++++++++
 net/mptcp/protocol.h                      |  1 +
 3 files changed, 23 insertions(+)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/netw=
orking/mptcp-sysctl.rst
index e263dfcc4b40..d9e69fdc7ea3 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -75,3 +75,11 @@ stale_loss_cnt - INTEGER
 	This is a per-namespace sysctl.
=20
 	Default: 4
+
+scheduler - STRING
+	Select the scheduler of your choice.
+
+	Support for selection of different schedulers. This is a per-namespace
+	sysctl.
+
+	Default: "default"
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index ae20b7d92e28..c46c22a84d23 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -32,6 +32,7 @@ struct mptcp_pernet {
 	u8 checksum_enabled;
 	u8 allow_join_initial_addr_port;
 	u8 pm_type;
+	char scheduler[MPTCP_SCHED_NAME_MAX];
 };
=20
 static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
@@ -69,6 +70,11 @@ int mptcp_get_pm_type(const struct net *net)
 	return mptcp_get_pernet(net)->pm_type;
 }
=20
+const char *mptcp_get_scheduler(const struct net *net)
+{
+	return mptcp_get_pernet(net)->scheduler;
+}
+
 static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
 	pernet->mptcp_enabled =3D 1;
@@ -77,6 +83,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet=
 *pernet)
 	pernet->allow_join_initial_addr_port =3D 1;
 	pernet->stale_loss_cnt =3D 4;
 	pernet->pm_type =3D MPTCP_PM_TYPE_KERNEL;
+	strcpy(pernet->scheduler, "default");
 }
=20
 #ifdef CONFIG_SYSCTL
@@ -128,6 +135,12 @@ static struct ctl_table mptcp_sysctl_table[] =3D {
 		.extra1       =3D SYSCTL_ZERO,
 		.extra2       =3D &mptcp_pm_type_max
 	},
+	{
+		.procname =3D "scheduler",
+		.maxlen	=3D MPTCP_SCHED_NAME_MAX,
+		.mode =3D 0644,
+		.proc_handler =3D proc_dostring,
+	},
 	{}
 };
=20
@@ -149,6 +162,7 @@ static int mptcp_pernet_new_table(struct net *net, stru=
ct mptcp_pernet *pernet)
 	table[3].data =3D &pernet->allow_join_initial_addr_port;
 	table[4].data =3D &pernet->stale_loss_cnt;
 	table[5].data =3D &pernet->pm_type;
+	table[6].data =3D &pernet->scheduler;
=20
 	hdr =3D register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
 	if (!hdr)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9fd4c689e423..d05dd2e2d05c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -596,6 +596,7 @@ int mptcp_is_checksum_enabled(const struct net *net);
 int mptcp_allow_join_id0(const struct net *net);
 unsigned int mptcp_stale_loss_cnt(const struct net *net);
 int mptcp_get_pm_type(const struct net *net);
+const char *mptcp_get_scheduler(const struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow=
,
 				     struct mptcp_options_received *mp_opt);
 bool __mptcp_retransmit_pending_data(struct sock *sk);
--=20
2.34.1

