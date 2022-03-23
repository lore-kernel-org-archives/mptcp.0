Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41D71391
	for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 09:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648027784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XL2xunp+RtTybm9qBGIclSF8uOwcpN6+UYkDlorjBv8=;
	b=edHTGTSIlXBi9qrQZ8cLe1uZBRkIJoTFS8JEO7vMJn86XbPhMQJk0YfZiaWlbSASkTwutM
	sUcxNQaTSrPa88UMWz+rgjiD4RRDVVo0WdifaKbzOaW0sJoQosyMP9RPxMjjZ763xi7oIa
	fLI8ry1FeCs3N71VgaWahb6tO8K1LEU=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2055.outbound.protection.outlook.com [104.47.2.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-8RDUdeqBM_m0Hb15VN6rqg-1; Wed, 23 Mar 2022 10:29:43 +0100
X-MC-Unique: 8RDUdeqBM_m0Hb15VN6rqg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVCIAzoXnMD2dPZ0MwMw6lTPzarSj3dPG7VtSAlMF9iBnjzfAsDjzKqZxV5AuO1ZlKM6gBAEsXPTyvrbeuLTBzsV+Mj2MetmEJaqK+zHBPNwlXCT3qbK6sBvDwWUofvoRjoIlYPen1hPcBk5DOafxk5QzEd8KGw7wVk9CmYjxJpvlPXL+VLb8FU6VK83reACDGqIJBrwrN/slwaqIGMcdHnHEdg24pOM4+L/e/0RaX1Yo+nRU+Ha/fwH7H57iWYJDGqvQn3KUPCD0Dmci5qG9RVC50JDHiFyDupqpaj56afqXY6zOB/fqiEZF+vhdX+USmSrFNWd8fIIoR2B+YfMmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4K27S+cFA5BSkcqF0AK8FENfLYEAJKxccjLMd7FSZE=;
 b=RI2OYWwmmJllmgr5hjTf47ubO4qQzbNQsf3xK2XhwM5Oplqc7Xr037pWOcxKVH6sO9Kfu8sEolxUIuwUnT4hchiCfyi5KvfiSUHtRiiazSiDQ1LERlbMGYXu3vhVMbSzfx5Z8VJkPqWmn09m2xYvmTP2v3664VaZpJiBhFm82mZQeDgd5oj2QovhPP3txRge9vLuX3o6fLhV+QmmUupGgvSsbxXqQCLIPLGvKt90M54kZf9xiIgfh7uXmeKBFfd0WhrhFU3rbQ/y9VqSEE5YJUChKezaA9vSIp1Pfn51NzXDKomrPU3+j/hFJPGhP9Do5dLO/G0it6rnxV9tyx9ztA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23; Wed, 23 Mar
 2022 09:29:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 09:29:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 5/8] mptcp: add mptcp_get_subflow wrapper
Date: Wed, 23 Mar 2022 17:29:04 +0800
Message-ID: <a63828e8e19f54767b8783cf5a1cdf8182f41e5b.1648026806.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648026806.git.geliang.tang@suse.com>
References: <cover.1648026806.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0057.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8c0d86d-63e5-42c4-c9bc-08da0cafa78c
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3359:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0402MB3359369FB30DFE939A17DD38F8189@VI1PR0402MB3359.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UMWPl6ia2J0N03Lt69sCny4QAOzBz4Od6UIjXhUTZof89d9Vn47DbySosFEyrKOBf1W1empRwITijzf4xv09c21qU/MSmxk9dcZE/qnq+A1jLwGhRzrRtqzwzn6y3ySR1yWV7g9aekZnXT1Z/kTeGY1jvfCTU2dlEBOPgqziDTlW/fc49b3qs6tURX0Uq5TnxEhORqwqzhC8TiL9oZRX4ESiQCJcdo9yojjZYsFT64KbHRJZXa24eJ+RoFphlAVWtrYY8tqJo9qihTv7YCRg5W4k7iypt/sNpy/lZLFzQya1NoUskD/76pl6F3jF8I8GRdGeD/9Mx6tWxmK3s2bGmHakl7YpsgGZqM0dmDHo88JiJacJIybI5Ez4+M48SE3lnkzQKp0L4PvV3EzxcFH/sPYIMRZyVaQCnoLzW2vPVPmfa1yVfXArjngYxl5Mlb+HQglYIpZ7ZTv006MxWAQiKN0z+QUqV6sVEDkgsvjGlIdq3e3eUbXNmHtKCtRNee85S/9TGfKlFy+s3xvFxqac0WMwd1JESv77Nqwn8gj8NToPGcbTRmX4HRXuNkRtRLW7Hk3j+VZwcwj+9IbLZ6a+cJQDeQ+W94L5DJdeQx7754HbjvEETKTusu0tS17PQ8cSq67KdNtDXiTUghz0hB8EbVbcKFqkWX60baS57Ayet4ieq2MrcMaFNqRabTKb6QXD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(508600001)(6506007)(5660300002)(2906002)(38100700002)(2616005)(44832011)(8676002)(4326008)(6486002)(66476007)(36756003)(107886003)(8936002)(316002)(83380400001)(186003)(86362001)(26005)(6916009)(6512007)(66946007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4nJPY5OFCGrLofUDZTZ7kZ1FrqcgXwTCGqiYvyfFLdqw1GGVDi25IGyA6gqH?=
 =?us-ascii?Q?0SKNSTqFAa5H5+H9P04GhrSuyGUuBGr6FpUv6tKBPzkJcWb7S3U3Z3NfFoF8?=
 =?us-ascii?Q?DIFb69SYhQ4E0OsVplv0uiDhTjfyY/VP4cl7atC2ESFqp1jPcMZgGNTpLlyf?=
 =?us-ascii?Q?xOG2MRgJxlpEjuMJBElBj4+G52Fr+x07RBE5avch+IOaGlGoJ6Trvn2BMpk9?=
 =?us-ascii?Q?1mrolBFTCillvtJDm/yRUCEKFap9UA+J1GQv+VzwUAXYrxpgd3lE+mMOAv35?=
 =?us-ascii?Q?dknhnGKLCpu4io5PlTGTL+l1OrpGaKEQbYcmLbvRCAkFZmQ1EGw7k1B0bW9J?=
 =?us-ascii?Q?VxjMBgncO4SnAYeHEz1oV/nF1z7rBCcHhzQNODMZ1T6W48DuFQu2RZNxgwkp?=
 =?us-ascii?Q?upjZKKZKiPfrIOg7ldSuzry2xQUktrAp+uzuGqF6MVztX651nZj+0oqZ0wsu?=
 =?us-ascii?Q?L9ANjfbN7NV4d14hMhZw2CCDuyw9uParGmbl004Sij9rj61PNZwQTdctlTpz?=
 =?us-ascii?Q?96nU1+0PGT+9TG4FNHA3W/0gmZOnG4Fk9vjyFR7sWd6piCACEAFmP7q1kYsM?=
 =?us-ascii?Q?H75l6i1as4hEnkK8nbjgcAThK0NmUidYq30TL7XP6boDCjjOs8GHLJUbM9a/?=
 =?us-ascii?Q?foUkMHiyGdeJ1ztwhQHY7D2cfEFWA0DgVDpxzPPVXVE5ChU/Goo2Kz1A0cqK?=
 =?us-ascii?Q?gMlxbdqBSd6W1nfWCJ9aocWOKKqYtsrzW7OokIb9DHXOI3Lu8Y8v9jx7Czj4?=
 =?us-ascii?Q?xg2rr8fYswmPuyRiSOLJY6Cn1VMOWj/XAJ1shS+WXgROMlnuCgLf+79NYJTK?=
 =?us-ascii?Q?A/27Gl8fJ45F11xuOiyv77O/TjmeFbKgCSHCq6yDUTPl6/9huuzBwX/hS97q?=
 =?us-ascii?Q?/wd4NIVZ/4p0R806iWC6WL9mvBGQRcHbFWp8QYJpJEUeKKyCP8EAsuyfGqJN?=
 =?us-ascii?Q?N0hjYUGt/Sl3Ga4DqMgUy5xz99z8v1bvNn9H0ZIdP0Hspq24bERCX5pogn6T?=
 =?us-ascii?Q?yl7PGMqoSIzUEvhKR2BfQBDB45oZwDKhaLVAYoGB51coRiWOqJCA8YNhiLOU?=
 =?us-ascii?Q?Tgjqx3+zB78Fq5LKuKVi68AO/CmutQM7qccHfCaKefhnS8dirx31XIle5z+h?=
 =?us-ascii?Q?U2Qj6IAwBnc8K3VwIq1KWjOK6LwNVM2rlZtG5pQBSi4p+/UKUxQwIeT6DCpU?=
 =?us-ascii?Q?e4VcFTTpiEpMDS0y5WDJcVVxumzfcdXhp324SYD2/a/5UI472CtpdlzwLYlt?=
 =?us-ascii?Q?SkBG5dI7QVAMzPQ0VUt8B1xi13+NJvrra05k7Rs7fPyXCjOHaMN59+9Y0wJZ?=
 =?us-ascii?Q?WHEWmeVcsj8Hs8BYRxtehxl07QkIuiEkr5VH28uSSCNqTgIsrEhnBpTPE/mC?=
 =?us-ascii?Q?Ri9H28iMJ88nPBRGAx6VAhEn7b7LEWekpcAqTgbeOrJQGCEkNyhdkor9giwm?=
 =?us-ascii?Q?CmAffGqXqkku26snNNMV1xNB0aiu2nLTso+uhuRV1V2bXdQ1op+w3g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c0d86d-63e5-42c4-c9bc-08da0cafa78c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 09:29:39.8834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrPy7pEkToUsvzPrquabIXYP18a/iTejGhzAK6QBnB75dCNF9a2r1cxNNJVpW639+8UGZ5TYLo0sUWfSHsODuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3359

This patch defined a new wrapper mptcp_get_subflow(), invoke get_subflow
of msk->sched in it. Use the wrapper instead of mptcp_subflow_get_send().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 6 +++---
 net/mptcp/protocol.h | 1 +
 net/mptcp/sched.c    | 7 +++++++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c309922bdb66..4560cdde96af 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1567,7 +1567,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned i=
nt flags)
 			int ret =3D 0;
=20
 			prev_ssk =3D ssk;
-			ssk =3D mptcp_subflow_get_send(msk);
+			ssk =3D mptcp_get_subflow(msk);
=20
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1634,7 +1634,7 @@ static void __mptcp_subflow_push_pending(struct sock =
*sk, struct sock *ssk)
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk =3D first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			xmit_ssk =3D first ? ssk : mptcp_get_subflow(mptcp_sk(sk));
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk !=3D ssk) {
@@ -3074,7 +3074,7 @@ void __mptcp_check_push(struct sock *sk, struct sock =
*ssk)
 		return;
=20
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk =3D mptcp_subflow_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk =3D mptcp_get_subflow(mptcp_sk(sk));
=20
 		if (xmit_ssk =3D=3D ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 9441a510ec6e..c5957fbff35c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -615,6 +615,7 @@ void mptcp_sched_init(void);
 void mptcp_init_sched(struct mptcp_sock *msk,
 		      struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
+struct sock *mptcp_get_subflow(struct mptcp_sock *msk);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 9ddfeb553c78..464f030bcd86 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -11,6 +11,7 @@
 #include <linux/list.h>
 #include <linux/rculist.h>
 #include <linux/spinlock.h>
+#include <linux/indirect_call_wrapper.h>
 #include <net/tcp.h>
 #include <net/netns/generic.h>
 #include "protocol.h"
@@ -140,3 +141,9 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 		msk->sched->release(msk);
 	msk->sched =3D NULL;
 }
+
+struct sock *mptcp_get_subflow(struct mptcp_sock *msk)
+{
+	return INDIRECT_CALL_INET_1(msk->sched->get_subflow,
+				    mptcp_subflow_get_send, msk);
+}
--=20
2.34.1

