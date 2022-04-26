Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E16F7E
	for <mptcp@lists.linux.dev>; Tue, 26 Apr 2022 14:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650981664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hvvbsvegrT5AxOmxgn8ZnJ8aX41EgSZK+9yoTkUuqUY=;
	b=VgHNvJ69j+vnRS3OvDZes9D1TO3nQZQUCkbLVjqWlcpZhB6f2dw2t2xfzZ+WgMinzbr624
	aLcd5vp5Ey/Fk5aamfdoFrWY6sgwM8q4jl8WLI7Gyx0s6hWqPpS7J21yzy1JoS0HGuhMMk
	vGaJLW37DBq9Oax7E1OF6F6iCGfQ/pg=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2057.outbound.protection.outlook.com [104.47.2.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-sa0no3VoOfCXiiaQXojh5Q-1; Tue, 26 Apr 2022 16:01:03 +0200
X-MC-Unique: sa0no3VoOfCXiiaQXojh5Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLMu4m4pWe/ZTR8+sKIUIvmw/A53SYvXdPcISdVlHGuMbDHBn3hgK1VDgcK4jfsCnP3MGdY8grHMs9C+3M+EbapGdoqpUpJH9KHROKoCIeUyFVtXaQQrQRXH84Hi3QtiGecZOims1OAbuWrgPtlQZvojRnImD6FJ7jzOr8f3yYKAU7xftIE3P+7zFyN5fMfH4yXBGSKPG/314WH2/bJ0JPSxKmoJwbrOkPyLeWAKVMsJDs26ftS95S5hZbq1eiMJJTRrxlGKQQHKIXIAChbH55ETAnnaOxH0uaCudPwbZ8VuCSDeGMP1RZrBJCGZdqUo2I8IcRqA0IxKdTiSavw10A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5IMNB/Ob+mif/9GAdi4MrvdeD5EMOBSGJjiuM5U208=;
 b=Wat86DaH8jIUlm74ttaUbs6QYKiEXwNVag6u7DYnIl/HoVsO8ksgRBNUqoQZt6yUtfUERf6iLVdLa7d5eQN9QI4qzDacmSoJ20Ai0fU3W/KrvOwZ0rpJvg0tErS/QX5WyyWY2kzyRsRcQjBg6hP+TKkTZTpjsZ5p56p0H1sOO1spRb9kKIMk3Bfi3f7Utca5R5u4Rk+W5os7IXWwFix/y63tjs0IHU3TliGsW9PRe4ni9QHy4XYr4EFP1DXCtyuljeuHm/vwHllagcgtFUjy0TR9edwuhF79ll1B9EreKjc7/ZlkeWEnMbfuHfWdq5DD67ufz4sC8DKv0+5PF9yTpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8816.eurprd04.prod.outlook.com (2603:10a6:102:20f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Tue, 26 Apr
 2022 14:01:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 14:01:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 2/8] mptcp: register default scheduler
Date: Tue, 26 Apr 2022 22:00:53 +0800
Message-ID: <f4d87249e9da9ace4bd57acc37c688bf27729a44.1650981078.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650981078.git.geliang.tang@suse.com>
References: <cover.1650981078.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:202:2e::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1e24bc7-f9b8-4ede-c85c-08da278d3271
X-MS-TrafficTypeDiagnostic: PAXPR04MB8816:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB88168853AD25AC82794BBD80F8FB9@PAXPR04MB8816.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/TDRj6wfYvhu4YrnumfDBKGcQpriFS5TF7Akz7aB+1dgPk2tN0qd9yItmjwx0VfiBG6ISldpAwQaW5NDTvGDfFAiW92QnOpBf1Rm5TR9D7Dtq9s48hPrHkNOc0cinvb5qvQP34hOcdHU87lQ8MFEXQ+SHU2nyFFQZhfVa/lPHm6Pxm4T4kYw0Y/5e7H7I9gaM/kKO7+nY+MYMxkD4PaRX66FbTyj54If+IthFv1hvJZuy6OAE8IdVxJubYIyxSxXSTXapAxCwuBT9IgGzI00TtRFLZXR7sTkWJRXzzqG2s0RsFEtZtd3SchHdL/tOcf9NFhUVAkfAs3ms4cAMD4JbG9FaQ9DPoOcyJE7uzlR9isNV0rPLCO9J+cavqm3ZwtEcZeDHPzwE63HmI9Ngr2QnIaJd5L0RO43isCK9+DrxITcUuEouSbA7i+kCCZWlZt8Z150USy7U4VusZL1BWs1BFM0tuSGxg7hlE6hdPNP80Cc2i3des2DtwQuXgbjNDbcss5Npt3eHc291R7jiuxmOFjahI9Q+bB2Kj+lUx2CFo9krkiEtezUklVJgsUEv/zM/uavhTTxZ2rSgk/OT10Pu7nZ5YPitUziFq6xN6GqhNdzCNMQIV93rKX6muT5SnPXSIJRbTyc3xBq4NHcPgHSD++k2cGWHgWbr50GwQ4Y+bvnE+iKT2ecw3czogknp/qJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66946007)(8676002)(4326008)(83380400001)(107886003)(2616005)(316002)(6916009)(86362001)(186003)(508600001)(6486002)(6512007)(66556008)(6666004)(6506007)(26005)(38100700002)(8936002)(5660300002)(36756003)(44832011)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Unbqgw3Pd2BfQ8Y0NSU/6nQoiP9fu8+906wVgoS0A4Zhj47xTaKJjedYyh47?=
 =?us-ascii?Q?OUxESO0JoYi5kF3HPlVC7Ovp3k0Dxq4FPsZVqCB38sSs7DKpFIKFdepxF3ep?=
 =?us-ascii?Q?TaLwnijf+mWvmh7ykrl74f/250c9FWR6eRIND3p9l9CYtFQHC1S/eDERnf1l?=
 =?us-ascii?Q?L3S5AjgP/Wh2dsT7orU8VWCRvDDu1mnOShqORLwYhw8YkPX/W6iKUy+eR5rp?=
 =?us-ascii?Q?BI1zpOzpvUoxaJvnPmDDjOLBWWfSRnExmo1d7szFUZkfbR12dWln+idpnAjR?=
 =?us-ascii?Q?iZqjgjRdsBDr109VezQSgVyXbDUW8j4BeVsaGwqj+MkIYGLfzPgNQ5iElMRs?=
 =?us-ascii?Q?NMkS3RExfd4UWCVj4Sl0VaDGHDQfA98kzpCCNv4SudoXi8BnamQD4MpZNUUX?=
 =?us-ascii?Q?3KNjkj/yeWJS0oWzMvy3mDGtOxin61MZwVwBuh88ydtQB0K995H6w7zzn+VN?=
 =?us-ascii?Q?QAtRMxmasjCIbi3WV+QyL+bJSHc5+J/JbCv1YM4tVfrqDT7sY8NNLYcL8xQQ?=
 =?us-ascii?Q?RUj0+m1vFuqcgmiAHFafuXow+ljw5LYFbuEcKjYdM72HHWeHzBz+2MNGhA3a?=
 =?us-ascii?Q?bOgW3TeCf+lPty4VxkYgYIUY379SglDxpcVrEGlJ1qQ4VNuGppamHQL7Bfgc?=
 =?us-ascii?Q?GBYYz7f9HapUFET/RzrWv6uybGWkkCGj0LxhKyZsUC2HBUquuDcTxV6hvGI2?=
 =?us-ascii?Q?0nfFJygzo4RUYlrDGDldbQamOdDDedB+6uASXg7XS+VsyQeCdumi3tzZz1vU?=
 =?us-ascii?Q?XkEhf+pCs9XBYRDbDSFW011o7DWc7UZYBS+0EGHQvlJfHNWfmLsPx/UPTBB5?=
 =?us-ascii?Q?SHFGZKNMdAlK9Iu+9lj/YG4Hs3a1ElLXXt8bgMBAV9kU2RrmlATijfSS+9tg?=
 =?us-ascii?Q?S3M5KnDVXxJ/HUTA4abUQpDH95G2gp1oZNdCrQ9VrwPQlmZ2V6vQ3cpLCdgX?=
 =?us-ascii?Q?JJ13uyRZfijSe/WN1yeIy2mI1iypJ3F1xfAdIRCimGKdESqCuLVK/fpMvDaI?=
 =?us-ascii?Q?Ap4ZGLF2Y+duxX2XSi/VWwUoRrKgmaIjwzxtY7lk61sXUPY4BshjfZcUbRAD?=
 =?us-ascii?Q?eLUAkZ0iaX1wl9nSayOwQo/DnftJ/iQeLTGaHVB5Lp3H+aEzllxjGneuSwoc?=
 =?us-ascii?Q?rWoI1syBHbD9Uy+wfeMaqcUo6ZxsEhV/7ZMxjMOSakKwyoxuu9RJldbS+kzg?=
 =?us-ascii?Q?OnQNW+xG5d6nII+yskBIlN3CJQ7eVifqF4vLhZLs9V4Bauv3kbSwjzhizOX7?=
 =?us-ascii?Q?r1HHXKCMRkW50s6hK0lNA5bT/vOIm+lb1XSZNPABF+QYx2rbPsbOm0jeXm0F?=
 =?us-ascii?Q?V7LHqgxRSo7ZkrbY/JyNZLo7FnoRZm420Z54LhkbYBm3YWvPdcKeT+DkrQ7m?=
 =?us-ascii?Q?9nmZPVdo1Y1susbd1Izq9pNc1ZmyETtgvoALWA0YfinKOtAor3/XB5mJKj9s?=
 =?us-ascii?Q?QXSBA0WRw3lZpe8toLL6Z2fLERIi3KyNFyM+OiguP41QA6CdKp6YQgU4K1hq?=
 =?us-ascii?Q?HDkFKFehBAVjjq4CkhpJsj7JTNFETeyYTl+5Tel2Oc3SV1DCgkxQOB3vnJeK?=
 =?us-ascii?Q?nlPVRtdqA07jl9SVuTwUuMd0hpM4un9GV8WqBTs1nAb1V5DND5bYs7bxCi9H?=
 =?us-ascii?Q?Iin93eqiqoppb4srWc2PKOJ5/N9zq/GYpS+Ns33wuQYsKVSlltI/MDiB4fEO?=
 =?us-ascii?Q?IVcXk4bEJdJ9rir+YDeV0kWdzTmDDcMPLh8LLtqZ5sgqBL+pQIqxdSL29lBY?=
 =?us-ascii?Q?Es7XTJQt0eN9sfNRVOEs2l+1Aa61BkI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e24bc7-f9b8-4ede-c85c-08da278d3271
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 14:01:01.9660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MaI37/sbVmaId7QcM+UkTisnA8tj2YeXSNTnddjo/ijGCwTPx3SS+Oe93y2AszK+d3cWe8Gak65Vh/sCzHxaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8816

This patch defines the default packet scheduler mptcp_sched_default,
register it in mptcp_sched_init(), which is invoked in mptcp_proto_init().
Skip deleting this default scheduler in mptcp_unregister_scheduler().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  9 +++++++++
 net/mptcp/protocol.h |  3 +++
 net/mptcp/sched.c    | 14 ++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 653757ea0aca..bf9d5bd8dfa6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2259,6 +2259,14 @@ static struct sock *mptcp_subflow_get_retrans(struct=
 mptcp_sock *msk)
 	return min_stale_count > 1 ? backup : NULL;
 }
=20
+void mptcp_get_subflow_default(struct mptcp_sock *msk, bool reinject,
+			       struct mptcp_sched_data *data)
+{
+	data->sock =3D reinject ? mptcp_subflow_get_retrans(msk) :
+				mptcp_subflow_get_send(msk);
+	data->call_again =3D 0;
+}
+
 static void mptcp_dispose_initial_subflow(struct mptcp_sock *msk)
 {
 	if (msk->subflow) {
@@ -3813,6 +3821,7 @@ void __init mptcp_proto_init(void)
=20
 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_sched_init();
 	mptcp_token_init();
=20
 	if (proto_register(&mptcp_prot, MPTCP_USE_SLAB) !=3D 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 221bb6b9860e..65a765c8d2be 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -624,6 +624,9 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *=
info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+void mptcp_get_subflow_default(struct mptcp_sock *msk, bool reinject,
+			       struct mptcp_sched_data *data);
+void mptcp_sched_init(void);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c5d3bbafba71..bd0beff8cac8 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -13,6 +13,12 @@
 #include <linux/spinlock.h>
 #include "protocol.h"
=20
+static struct mptcp_sched_ops mptcp_sched_default =3D {
+	.get_subflow    =3D mptcp_get_subflow_default,
+	.name           =3D "default",
+	.owner          =3D THIS_MODULE,
+};
+
 static DEFINE_SPINLOCK(mptcp_sched_list_lock);
 static LIST_HEAD(mptcp_sched_list);
=20
@@ -50,7 +56,15 @@ int mptcp_register_scheduler(struct mptcp_sched_ops *sch=
ed)
=20
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched)
 {
+	if (sched =3D=3D &mptcp_sched_default)
+		return;
+
 	spin_lock(&mptcp_sched_list_lock);
 	list_del_rcu(&sched->list);
 	spin_unlock(&mptcp_sched_list_lock);
 }
+
+void mptcp_sched_init(void)
+{
+	mptcp_register_scheduler(&mptcp_sched_default);
+}
--=20
2.34.1

