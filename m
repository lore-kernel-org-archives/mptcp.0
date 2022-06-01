Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE18362
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 06:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654065984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6qeaeLhCS49ag5oPQUlPBw/DfNU+X0en57Oj78sWy2U=;
	b=nfKAyhhN6awFi34Br6wEMd03oKHelTawBWh99/UpiyxtNDblbo/214G7npE3BGssvwtCNZ
	bKuQ87Xa0t3AROGlpNNLsswbPHabHN4yMOkOXTwPdHo13V2pusXbjgNB9eIio5xH2LSioo
	3wbG+fi1VCP8GGBx5ymRxl3mprYwgzw=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2104.outbound.protection.outlook.com [104.47.17.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-3jK8omHcNeim6fRGA4JMcA-1; Wed, 01 Jun 2022 08:46:23 +0200
X-MC-Unique: 3jK8omHcNeim6fRGA4JMcA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zz19COGGvtQA0S8/XLyM+3uT0RqaWQa+NGQzBwiTTSOFiesFp6nlvsZzanhSrq1fmW2T4n4OtRyQBQt0jLK8auBUXghr7EyLGjazmfoDXm61RTGsg9/Arl55mknsQxTv6MHaihnT13Vj6UNeqH1gDmRQlcanJShswuZLy4GkBTNEzeik1cvMeGfHqfrQ42YcGohLtdQ78W1xrmZe0HHK+QU4KfkuUvMH+w2ux7hwmO8aLsbcZk/B0gF2Dg1DIdTQOdJw+7jW8m5DuplBBGU/yxPtBgPJUDw1mxw2PEAbj4djsw/AIvNbW4ShPViLhhohy1baY62OqKL/BHCvVQNxiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yO1a+YtcJ54XPUQMZ+djN76nbPAj4ZonspXA11NptY=;
 b=m9JxQEDLD8MRV9qf+QI7JT2N69mNY85duK8wUPCPBRkmbv6HA8YQ1R0tyJwODA6CogZedqe868dihnA97UMZKfvgch4wrP9TDTOk7IWs+Szz/YWrhpAg1YVxsKWJfntOfBn3E/8fZbcqCMoHgRRdQ4ku9YR+RX9bmemOgxdBIeBlcv9A9P+Dml1urgiksS832oy7UwnZNCYHlB611KZV2zxlolROGZ1dgPBDq51aGAo8/8Q6lose4xARNjsiJPrLDI4HKInxhvdW/kIpOa1DWxuFI4RfXeFpwSwkpkcKuIA3oJCzxQ1MWcQNsC40OHfp8En8PS6rgEcyE/kKgaG4tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR0401MB2434.eurprd04.prod.outlook.com (2603:10a6:203:35::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 06:46:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 06:46:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 03/11] Squash to "mptcp: add get_subflow wrappers"
Date: Wed,  1 Jun 2022 14:45:52 +0800
Message-ID: <5ff48a0eef44e9ed917d62d1b1e3c309cea98c09.1654065674.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654065674.git.geliang.tang@suse.com>
References: <cover.1654065674.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
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
X-MS-Office365-Filtering-Correlation-Id: 339e3665-bcb7-4860-7f8f-08da439a70d7
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2434:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR0401MB24341E22B98C95248EB9CA91F8DF9@AM5PR0401MB2434.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5w1drSTycobSKy9sMoi3aOE6hUyGcfU2EAUvabUOMkPQp4t1NZAT5WXXcJ3DdlVgn3bGOHOm6/jBDiPKPmkNrX+/EHLLu4O6Ya4aefvyVcNnpUCZ3gxL79898SywgLm36nhNskQ0gNlym0XhusG3mcjP3FYFGMQ0Shgo+AabHT0fDKl3l577eR/wU6vqd4Gh/Lcwel/W/TtZP52YIRp0BxY+SgVlHcSjaG1oDl8eUQezn5tLp1Fkjmf+4TrPb2YzgzsEQYLQkOs5CxGIsVuEly4fh8AKto+pmKgC0Q5HSiZ4rWtUtEBSHtKguLgTGfZLrMFe8OT1rTAWfS9WINYFLiPYV4Q1Rj+wsz9rNMnRHBj5gKCKGbpRHo/MfWI66Z0kDyqeuZH1vOUEH/sxvtA97nhXWkuhUVB7WEnvp4SfuwBsfg89Mfbcjmtodi3//Kbk89492rtXK4m0VQ8X4yj4Qt0fYZjwsxujSGKQh/Zh3b8BO/lLV4Obz7WOQQZJ3MiXx2SBXEaBbHH6wgUe9K4+852oNa0Ann7Ic3T3scLZq7mcURBu9YQF94UfEQiQLtLu8Do/T9pfnDQAUUzwGmjmCOdz4Gq5nywK7ehlFggk5E8MqEoucNlXoy12XXa/nX0JrTl5fArHCT4yUqtNgC77E7pp4WNgr2L7++f2ozrDIyB1teLtC7xNOievFF+aQWUj6QUsB+xnKX4ahOVJQlPJ+g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(6506007)(44832011)(508600001)(6666004)(186003)(6512007)(2616005)(107886003)(26005)(38100700002)(2906002)(83380400001)(66476007)(66556008)(66946007)(36756003)(5660300002)(8676002)(4326008)(6916009)(316002)(8936002)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r5YylKpdXD8VYHIvWBZAR+ro/6A3Roj8ofQdJaetAeSxu4Lk013jDBABjOBf?=
 =?us-ascii?Q?qTkEmLAweumfMIFqy4AMOyvIhqqhhYXupqe5bOJWKo1O/epIYwHWb88thR/m?=
 =?us-ascii?Q?wQsEvsUmWHMf1FTirxvRLErlpFXKfBJmak6+IwcKcBq5GusQ/SVnHVxsiEHT?=
 =?us-ascii?Q?14ow6YnsJNFhzf/CW2CL3dPVd3luKamDFevvQJys7G7Y9sm1lrktUA6CrRKj?=
 =?us-ascii?Q?1idCgOCqr2edonIcsNliZJEiLH9A9hK4dRqfY3CYwV3FrKAjwlNnja7kp4+L?=
 =?us-ascii?Q?kJwuUgyyPf31T7LTxJW88bJsOnRZsa5rj3l3gTounGxiNLVhDCDmcdyGlDBH?=
 =?us-ascii?Q?p0vztXkyMXJUfc3D5Ld5i2+gAII10533q+Dkg8ipGnUku8XBfR2975mFoBBy?=
 =?us-ascii?Q?N+Yu+qZ9x7HUQkBaTy2m4EgCfW9nRwUleAInr8JyMY5q0gwXApn5wumieK2l?=
 =?us-ascii?Q?Z83q08zDJcqJkH29Ed3OiPiezpSqapjboPvyb1/kIuIBzhnxmE9z4As0UhN8?=
 =?us-ascii?Q?N6ASuWeGeH7mhRtDidhlfa2xircDvqMwmRXlXm+cGD3a/Ra/4SvYJaON0ynq?=
 =?us-ascii?Q?r0z5VhLnFm95tP23D7kBa0IcMsgTGeqCqezqn5jlPeocEaKkGcPy0uGe6DQn?=
 =?us-ascii?Q?9II4z74yhiZGCs9AFBrJAD9DQMNEexDeEMmGAN4AlwLaf754IUZguv7TIoid?=
 =?us-ascii?Q?RpwteJb36quK53uG+vBkMlrBlvn2g2hzbMutTtKECboayG6qmyte3nDI/0JA?=
 =?us-ascii?Q?z39NeCGahhF2DElIavrnTANRG66pkp/XSkl/g1dm98Y7MQxIWknJx/F0QlKV?=
 =?us-ascii?Q?/CFFFoBnX6yhJZJOuf6AzXgK0fDLYL1jpFui3Zox4mQckQf7lOkxmwBMXRRa?=
 =?us-ascii?Q?uKR23d9D7LlMukRsclH9YA3JTvxx91cPsssusVNB/0IL8+Dt0riHXUbzdxE8?=
 =?us-ascii?Q?2JPHiN3c2OaxkuZcMrOnTosL4VEW9vQ8FeJfK035fry6qrVytCDWkwL+0p/1?=
 =?us-ascii?Q?rDJpi97rgHJB9SYub1nvhaTPoTuonmVSjueHYZxdW4jbL15A16Dxk4oppYo+?=
 =?us-ascii?Q?mm4QmS/etJ4I1SLwPGxOwaJkwbBoCy5yxHc1aZiTz1rPQhW8gv3mLVd6P33v?=
 =?us-ascii?Q?o1EKKJgWSzgzjKdew0c0SSxPS4UamAjkSuS7RTMSgulr/Z/aaIXJXMwxkDHk?=
 =?us-ascii?Q?dLCkQljiP7xH9cyzPyFKfmM4Lgtx1c270KHcBnFTK96Aont/FDBj8fcO6sZ8?=
 =?us-ascii?Q?6qWWCFrUFYnPhhfnD+yrvhSM4Xo74f1rpF5bkuJOK+tD3G81FAnwMc6NaN3C?=
 =?us-ascii?Q?GMjwMmwtcX7pKs6l1ydESNtVTu1YZaEIvFGqMydZmzEPvJFx4Hwy1MIz+yUc?=
 =?us-ascii?Q?ZEGTObmZeJ37fCpq9PIuVBiVVFAs0wRCKP1ZKC2hH4tll3zmjqldtenv35YS?=
 =?us-ascii?Q?J5b6FphTpAtmJfr3kVnjTqkkUHBHoTC7MVYZMk78bu62xFBD8aXvrBuHcJOq?=
 =?us-ascii?Q?U4l58oYoo06qB0nbMfG4wzUGsrfO7hT3XPcWMeoS9/DUIq+4DbEB39ZGIN28?=
 =?us-ascii?Q?GxUF7A4Y4hXPrb92WWeqt2niBbvx/T2ZYXtzzUAiWn/6jWarfRRs+FqQ/g4Y?=
 =?us-ascii?Q?JqtKU/t6N7Pbshz7YPTRu6whTktwrxpgLfkAMIUmRz5QaoUw1bjeDFMHbuES?=
 =?us-ascii?Q?mvbEnhI27lp5537DyzDiNf5PzEUBxlKlculu1A8piB8zzCVO9avBF+NkBVuB?=
 =?us-ascii?Q?AC2LsCeC1YZRbGCjFUHBuwWN8I/8Y28=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339e3665-bcb7-4860-7f8f-08da439a70d7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 06:46:22.5729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBifwINhH3HrgycR/OXYOXd/L5u+P/rdpvI/TENfTTzM+TjcxgOjO/zfDpLKIFYgUynrbe9gLDvxPHgkt35fjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2434

Please update the commit log:

'''
This patch defines two new wrappers mptcp_sched_get_send() and
mptcp_sched_get_retrans(), invoke get_subflow() of msk->sched in them.
Use them instead of using mptcp_subflow_get_send() or
mptcp_subflow_get_retrans() directly.

Set the subflow pointers array in struct mptcp_sched_data before invoking
get_subflow(), then it can be used in get_subflow() in the BPF contexts.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/sched.c | 54 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 3ceb721e6489..613b7005938c 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -88,11 +88,25 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 	bpf_module_put(sched, sched->owner);
 }
=20
-static int mptcp_sched_data_init(struct mptcp_sock *msk,
+static int mptcp_sched_data_init(struct mptcp_sock *msk, bool reinject,
 				 struct mptcp_sched_data *data)
 {
-	data->sock =3D NULL;
-	data->call_again =3D 0;
+	struct mptcp_subflow_context *subflow;
+	int i =3D 0;
+
+	data->reinject =3D reinject;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (i =3D=3D MPTCP_SUBFLOWS_MAX) {
+			pr_warn_once("too many subflows");
+			break;
+		}
+		WRITE_ONCE(subflow->scheduled, false);
+		data->contexts[i++] =3D subflow;
+	}
+
+	for (; i < MPTCP_SUBFLOWS_MAX; i++)
+		data->contexts[i] =3D NULL;
=20
 	return 0;
 }
@@ -100,6 +114,8 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk=
,
 struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_sched_data data;
+	struct sock *ssk =3D NULL;
+	int i;
=20
 	sock_owned_by_me((struct sock *)msk);
=20
@@ -113,16 +129,25 @@ struct sock *mptcp_sched_get_send(struct mptcp_sock *=
msk)
 	if (!msk->sched)
 		return mptcp_subflow_get_send(msk);
=20
-	mptcp_sched_data_init(msk, &data);
-	msk->sched->get_subflow(msk, false, &data);
+	mptcp_sched_data_init(msk, false, &data);
+	msk->sched->get_subflow(msk, &data);
+
+	for (i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
+			ssk =3D data.contexts[i]->tcp_sock;
+			msk->last_snd =3D ssk;
+			break;
+		}
+	}
=20
-	msk->last_snd =3D data.sock;
-	return data.sock;
+	return ssk;
 }
=20
 struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_sched_data data;
+	struct sock *ssk =3D NULL;
+	int i;
=20
 	sock_owned_by_me((const struct sock *)msk);
=20
@@ -133,9 +158,16 @@ struct sock *mptcp_sched_get_retrans(struct mptcp_sock=
 *msk)
 	if (!msk->sched)
 		return mptcp_subflow_get_retrans(msk);
=20
-	mptcp_sched_data_init(msk, &data);
-	msk->sched->get_subflow(msk, true, &data);
+	mptcp_sched_data_init(msk, true, &data);
+	msk->sched->get_subflow(msk, &data);
+
+	for (i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
+			ssk =3D data.contexts[i]->tcp_sock;
+			msk->last_snd =3D ssk;
+			break;
+		}
+	}
=20
-	msk->last_snd =3D data.sock;
-	return data.sock;
+	return ssk;
 }
--=20
2.34.1

