Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A4920FF
	for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 07:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648537793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MdHV+Yxcnb4lJlcH3UDTLYzqQiwff72jxt+g/SzyCnY=;
	b=GeArYuB0/Q5TnB2Au84vO7zMmHHxA0i5PJSJqf8ULCx7nSOSPcIorZ9BKwA/rM5JZbqR/G
	PXFDG+gD8+XeqPL1pGYjB4gJMplJJCU2nDarYV8jVrWTEZB9AEXRtycmlCivA3kGy2wr+z
	lup3a7FW1KP8VVbDmXtrjL1RI//k5k0=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2174.outbound.protection.outlook.com [104.47.17.174]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-GjHDMAzoNDecQgmpYcP-qQ-1; Tue, 29 Mar 2022 09:09:51 +0200
X-MC-Unique: GjHDMAzoNDecQgmpYcP-qQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfCNgsADdmFTqTJ4AAayh+1iq6vnivtqf3YJWl6NU24q0UDFyeTjjBG96LNbOcSuHmtYwCdh8W3JUnUoGKnHsHqHtXA4FwSjAaVtzzogeAedqsPRJQd2Yak0wsFIufFQ9gKGETHi5vPikKOz0qVlYhPRjyZyUSIKf2SGSlJJoQOlwmH3udy7sZsTvu6iltq23FFFmtGV5s2fj3pFm6XAk51/MbGjfdkJ/iDGyH9qAGnwgUTlAXRMf003/NkCbXKrR6oqg7GddLFR9dnUrv4n5Iu32tsfNwRlDwIUYNB1hNInusLwp/yh7arsp0DSyWOEM2KdAwCNvU6pq2lX2T++RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOFFrwF5WwqeyUWL/THPWXxSVU7wkHZ286dmOq3oq4s=;
 b=Kq9LzE7uq7qy82unga/FvakY5UEVnWx4GtmV3cT+fU1l/3UAcmePCsADvpcPAR/m4DUTJPJXEkLyoEBNm/JpNcVPZWBO0/ijpbPHXRCBkLe5iypWbF5XvwZswVy8dPqIaYyrMRP+XN8jSF5KZkp3D5OZ3EAuXizp+Rl7NVtibu/MDQjHrfOzhguhGmOPuQ2ouyzd26JS0UA2hRedipohcIkkshcoxH8Qy/B7mskjdP39Hy3fR8mKsdgsgsgjkjCmhyiRqoEmt3qcqj46DDjHNBUdkxUZ8TunIAnnQgKF2TP7793ZwWlKdVcsQh8BKVEavRFHalsrQcB/6XHHdfNiQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7335.eurprd04.prod.outlook.com (2603:10a6:10:1b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.23; Tue, 29 Mar
 2022 07:09:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 07:09:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: fw@strlen.de,
	Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 3/8] mptcp: add a new sysctl scheduler
Date: Tue, 29 Mar 2022 15:09:22 +0800
Message-ID: <eb3e00f5b612200cb1e8463338b297a6cc0409ab.1648537203.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648537203.git.geliang.tang@suse.com>
References: <cover.1648537203.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0118.apcprd03.prod.outlook.com
 (2603:1096:203:b0::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f48c4b3-0939-4eb4-6027-08da11531d3f
X-MS-TrafficTypeDiagnostic: DBAPR04MB7335:EE_
X-Microsoft-Antispam-PRVS:
	<DBAPR04MB7335F6764B4980424500FC79F81E9@DBAPR04MB7335.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3A9JprFt7N+Hy5kDXdyahevrLqoGLkq9DKQk+UzBaVQfUiprf0/25SjfpnWvumXWbRCQl8gvRIt62PotbfMrC8jmAG0jX+f1VofLoaK2h4FAUmCsDyN0CfNNKaqHQkAa6MHgMNYmQFNuniYVVdRy64ZQpEmUzTsQ/yP5DovQ/mKXggnbo+LWUorQZFjZn5u9mHDf+28yX1DNhR7crHxVV4HAkURRn0nEx4B+ERPgyOHzKRac/rb0ojAMUc1V9sE6pX2x+Tr7KyfqUIGO+As1KIJdowj8ZpjEa4ckt9+RDuO80TsjAAwhONIGuJxVebl8skKkRDH4msFbZRklzvCMAikUKhjJhiPTcXQTCn8p+xxRtk8z0H3+1UReu2pVndmzhudGg/uCYxE6Flaz3Jo7J2SQPLcukdKkueSEhbHHFp6z0MSkWuZgBLppN0ztw4EAl2JB7Les75E2AdQ1hTc7dd42bdxmXo9LmR5W8Nq/7nW5hkB/vh889pDVueMRcchmZl3RNy4An3U+UF+uOAGJR5/M3reClKpuJlAUS4EsTzqfzVSYq+gOwCNcyEphkvQKLHhoROgNmM8d8oWZOleEWLVEfIQulQmt9TniXGPqYQZ371NBO1Wo/D3/jxjpDXjZoaavEK4HyAfQPCvKCkprhJLxrGfUIa4ECfd6zMSCt4of69MsU+9rTVB8aJqVpzryjenCnSuCfaYzuY80Va7cWw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(2906002)(36756003)(6916009)(26005)(316002)(186003)(107886003)(38100700002)(2616005)(4326008)(6486002)(6506007)(508600001)(44832011)(66946007)(66556008)(8936002)(8676002)(66476007)(5660300002)(6666004)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FFdQeKvz2v/NvRpZecFpdmfz3UGtD+k/wnsFJ73lkocuQQfe7zRNSF8kffSg?=
 =?us-ascii?Q?Hn1pnubrPZbHlqWwQY5b9vqj09v7F6/qeWTZDc4htTjouWeNfrl5d8WYXpeB?=
 =?us-ascii?Q?FY+ezk0U1DvCCtwRkFSovLbHwBb+jyEnCdAQL0Kb2DVSMlWpA7jeKIKU3GVR?=
 =?us-ascii?Q?kkPSlCK6Rd87tEnz9IXA0QJ0DjMFvDaVDINgcgQa1VoI905W9W4Df7YG8o+v?=
 =?us-ascii?Q?S9JoqlB/gahlcXjAjqURJxtpH5vZelwzEDJMxGI63yDDu6ivDtcYTjx0ZbcT?=
 =?us-ascii?Q?YU5yt4EQVaY0j+Gkfoixp7s2022xPBDcNyZWgbEafcTzCpNu5D8bNxTTH2Mu?=
 =?us-ascii?Q?jk2YqL+d/+MNe+mlWzRfLhctUdRXKcBlgm26rN7LTG8xpmYrR3ctK7caxj1H?=
 =?us-ascii?Q?t1L4ciJTb/D1zyI2yadLjbv0wfu0sHhlWIYLJDEqoMO35R2YfngfyNWN1xRV?=
 =?us-ascii?Q?IAkHTH2QwONzZseDLjjFHvxU9k1GsmOQUL/EyTj+oMA5bd+VX8xd6nz50R+j?=
 =?us-ascii?Q?PHA5K77Gfjrc+JkR1e9Ty3MbJZOwgXL8vcRj12v+AQtpbzpH1EaBFzMvU3Eu?=
 =?us-ascii?Q?Ywc/1+sUdRXZmg2bGez3ejmkXtZTGuOkc74B7sJiBL13+OiFui8NKedwfzr2?=
 =?us-ascii?Q?VfFfxr7awjJ4xcwGg+D7BQpBRVTuEY7Hh2YYchC9czp1aK+NmCynpkUgTbDH?=
 =?us-ascii?Q?2mPbQ3e7Ub2ZvIBMMGv3ac6Y+7NOjeXUkCbDATACc3R9VNyQRCdCq3Gzheu9?=
 =?us-ascii?Q?6TXjhCMqDGE1/GLmsPtRe1yR7ArL9YQeZfrWl7XLrvqYy5KeNeR6ERuT1uF6?=
 =?us-ascii?Q?F+GhOjxG66oywMLfMnSWtsojPTTKFiGZ2ptCaV1sk5Ohsd9v625Q66RFHGN+?=
 =?us-ascii?Q?/2o4+mLZr4GmGTviAKthnxokE0xYoDuma3z5UqHCcaM9yoKxWlomqG+G0Itm?=
 =?us-ascii?Q?t5VigjtBZY3jO7ziAjGVQP41oB6Mrd3BMS9k1Mov/HH1ualLjf/K2ePhsSxl?=
 =?us-ascii?Q?OesNfANXyHFwGZkOyXCVJnuEQok+CUuWJ2MBToeopaA+zlYdjFfJUINE4wwb?=
 =?us-ascii?Q?R8jOoFNKluTJvxIxt+y/C8W2zjc1ykbmrsL7aELAPBqlfUCAG/+KPMRh1dTn?=
 =?us-ascii?Q?Uqa2gSzqNFe3XNCJhy4Q4TVVtiJSHmQBghhgbttX/nzfAo60l6kZppYBGHul?=
 =?us-ascii?Q?/cO9ZSM2kwvUSINkir0cLSyh5Jnr4A+TAy304Wc2tKbWwa1vKArtOtN7GhYu?=
 =?us-ascii?Q?f3ucpuVJ9M5GRp2e0hN5QRyeXEZut5T7rv9QOg6pzI/Fnp+NQxEarQlSn1ss?=
 =?us-ascii?Q?bD+0ru45eDdlgMCD/wlUoQ1HowfbRVf20btuW6KzNm1aD/RYPh2hvpjikBOA?=
 =?us-ascii?Q?h4Qu8CPH0kyUk3G8inbZm55sMjwXVDZZ7Z+acQHKqq4L/7v8ZP5PF28XwJux?=
 =?us-ascii?Q?inW0GS6QjknWVY4ftKzaY1TO3xHeAjxpSgzlXzh5zzg9O/NZ51F1Wrsl74d6?=
 =?us-ascii?Q?lGdCnGRCjY7gC94MSSjJkncMZbsKgkksteXAw8gIiVxtENVOIwuD3MkbgfV2?=
 =?us-ascii?Q?9lbHfGIGPO38WyB5bwJGqOioUY4vMcSO8J+D2D1wJhL0ywpxdtqQKAXWxBRq?=
 =?us-ascii?Q?Vpdi7trbGPttWATJe+I5K13OoMRScYeDbdTxInUBBYVlOs06OvEt1f6KE0DX?=
 =?us-ascii?Q?KuX/OWayc3PRnb+vbXiHA1zl7pgC94a7Pn7MnDzO1oOtGVJXuXZNbt3kdV/K?=
 =?us-ascii?Q?6QGt+l1paOvBFB+KL7vlYQv3N9WVEls=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f48c4b3-0939-4eb4-6027-08da11531d3f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 07:09:49.9965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GsPD5sLtW2ckIzGKM3fyyUD0lbHnmNCFFbqjwf4VA3pwJKzMxO0U7iVLRZfEf2yIvj+L0i/5X9sGpuOOt32Shg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7335

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
index 76b98240921f..e9fbed723caf 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -586,6 +586,7 @@ int mptcp_is_checksum_enabled(const struct net *net);
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

