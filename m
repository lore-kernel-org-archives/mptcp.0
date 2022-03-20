Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEC233D3
	for <mptcp@lists.linux.dev>; Sun, 20 Mar 2022 14:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647785393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xH2MJTdonteAMs6DbBr3qI2YjrAVbj+bmtMdmQvGKH4=;
	b=dEEkAkl2ffz+wrAQKrs7Vf6FzDwrej4CnfgxY2myCj8xMVxZ+hCpgjToqAmZxgJK4pIdmp
	pf/XU32pKOMq7lgGLCwsD/oro5HH3p6E1VP7Foras8ENOjfadjag3jxvkBW+ZknVpvVC4g
	mhMrsmowU0Eox//HONG/RntsDUKGtXg=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2050.outbound.protection.outlook.com [104.47.6.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15--caTxT8xO0KsZryzWILrbQ-1; Sun, 20 Mar 2022 15:09:52 +0100
X-MC-Unique: -caTxT8xO0KsZryzWILrbQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvDfI0WYyUgwK8HWptoVn9OdBL6jieeYzJSICgCN8N1gUjs9UrDG9Za54L4j7Rr7U7SZbKbIlQd47Qp7fQHMZcvWVYm/UXGMUqZp4ckGYgHMa7V8PXf59PKpiIHVY6DVl840p7qB40uoLDHejnmwoxM/+cUbaRmudsuZ0xTI3qbSVeGwYlIuhL6AnRXsaL9sOjqhqjfuXYZq8anIIPqmk/qX0uXGvHjUehIIl2wpDc6rFb4kXU8wWC1xUydEvd2iG8GH39pblZ0BEO07gqE+VCE8EUOkAxQOv0CpmVBgkJFuSIdpp2wBNwWTI5/6mcyA9qKi0ebrv5PcM+n6LUjSVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZM4KsaSNBw1M9IQ2CPtc9UuE3cUmxbZRD4JrEpqeuO0=;
 b=k9QlViXSW195RyqsJY07uBjOTAbVVaBZ8SZPi2jlUA/Cck1Z47LV+ZQtv+HGZ9zlsYqAZKfeiFLLeQh7aQtuWTVGlC+Z5pfrxTT5Nm63PAEHktoFBVCCU1JG0c0irGK0hgf1TBqldH4tsaNBqhdYQ595LTWRZESVpseStgtM6UV9ZOC4tv+HY5jREWLF5aEPKIySjqzG1kHJafNLwfjEJTW7uJhndPAsaqEY9u/A1jNU32puF0EuSwiQZXVP77jHbUxmjgu6MLJDQot3v5usJfrQdG6tqolfl6wHK5JKoklcs2DMNJrzYVb7Egr4HRQ3zYOafELiFccY9g7yB5sM+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7035.eurprd04.prod.outlook.com (2603:10a6:10:127::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Sun, 20 Mar
 2022 14:09:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5081.022; Sun, 20 Mar 2022
 14:09:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 5/8] mptcp: add mptcp_get_subflow wrapper
Date: Sun, 20 Mar 2022 22:09:09 +0800
Message-ID: <0e23d9845733b9ceccfd4ef37a993746b340f0d5.1647784679.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647784679.git.geliang.tang@suse.com>
References: <cover.1647784679.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:203:d0::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 730703d5-5b71-4c9c-2e82-08da0a7b4ce8
X-MS-TrafficTypeDiagnostic: DB8PR04MB7035:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB703541AAFFA5999C22149C0AF8159@DB8PR04MB7035.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Nq+Xeb0I2CGNCKs1hrddRCQfdrN/EElktjnZwlxiDT25SufG68U5sZkiHrU/L8l8GpVQFj7Gpn1cS0Q7C7+s4KxnMbdNgBZWJEEY5GWhAOTTitEkE7XOySKsCLnWdmmzRNOMK1l/7sKQGx/vIyUckZBSfqBhTi7trDeWxyh+iz/9qv9/2NI5Ftux4GuF2uq9baEwkBpTVpHjnVDA9vlHB53jHoe9PcZJvixzvItiyMXQQ+DaF3uz7JqJTBXWSgpiX+nc/+E6CXLBNKqnJNWJ2CfKB21ovuMxsy8kb59rEeuxkc67+wElaM2wajcylxtKQsDetIHgphhyjh2JvoVLbQLfm5APzGcEvYY3tR1TBJzYxpgGQjM6jCE5drA0Y4dzssbxpU6aZ/CaXZFaVnnmERd/sRjHlhoynrQuCNN6wTu9DIUOGYRHpta3K5GS7byEY/mbZc3+rkR2I5+185wbWYlJdCl4zDLSXkZNpqim6WocP+xvLz7CdG8apqVCI2cH10jPxh6Y+7aKEv2VI4pOU9rb6+Geo6oCKRyeKpyT2a/gLXDD78LWjDDvsOFbSppjObeGWx4W0HlTA50xQme3qpn7FasyNkOav2Gf0YWf989tdC2rBiNkw1qiO/kOMUY+Ang9MI4nCg8NLHf68XF70SYKTpaOebtSLjJwusOv81/ae35PjtY5B7qQsHXrRbqS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(83380400001)(44832011)(66946007)(66476007)(8676002)(66556008)(4326008)(6486002)(6506007)(508600001)(6666004)(2906002)(36756003)(86362001)(2616005)(107886003)(186003)(26005)(8936002)(6916009)(5660300002)(316002)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QeWMIeksDkZaNQd+K1M9khXZcRuvdZpOfv8wDvpCzmU/ETslMy5yjzcIjg1j?=
 =?us-ascii?Q?YnGYRrQKzjfYnrnco2hYBT4noPuGjKxW5jvfQ4FC5ug0EBZh5Nv0dQpI0IJU?=
 =?us-ascii?Q?RJGsD/U9TkfIL2YNJ8l5/akpFUi1c+TTfcW53ejoJjJG1DstvQ+3eDAbWzHX?=
 =?us-ascii?Q?Vuh8VNQu3UxsYIcV+enwAgLVYZTohNP3cHhpxov72X1dyTSvzdmT8kO1QFG7?=
 =?us-ascii?Q?GKT+ZkqeRqZ0p6xYROvMytb5VqCbh5MZ5a+LsifLXcitFIK96TLPehJwYjYk?=
 =?us-ascii?Q?Moav/D+1Gzz7yDjGpCw33/63D7Cmj5rfGg4Io3vMRh8XTm0VfoFwsmYcRfF2?=
 =?us-ascii?Q?JiB5+Ok5luzDIVmkEOYNmiUQuxBkITZXxIeRv+rux+jS1UASFeJNdGbEYUJb?=
 =?us-ascii?Q?L/Q8PdPE3Xiws5ikxrDJiFurCe++SavQc9VheRVyZqlBoK7JDkWLLSuQJTCq?=
 =?us-ascii?Q?PCZLkdkbqH2FzA5Vk8wMCbT6y+iNRpc2zEaV53JTkHLvXMh/QyPQtWJ6WkbY?=
 =?us-ascii?Q?BMpwS1qxmVWuoDLWh/AA+sNi2cuXTRcrhn6uVFYbAEo35gBV3kaq2czXWHlt?=
 =?us-ascii?Q?MEbByiWPZMiEP1WVABiRDac1Iip+WeQWL9lqT/NZ9NA6L6q4vmbVYio+LS3P?=
 =?us-ascii?Q?FkFl/Q52t9/qBkOfkekKcx68de/SEKjw1cmXUblPwCHZI1ZU1rzkrG4H/Y/X?=
 =?us-ascii?Q?ESNragzPqTMiyub8UW2UnaQ+b0+dRx7txz7KVjw9FvWA2p0FdQfF6gUa5GnT?=
 =?us-ascii?Q?yvSwx+QD0LfnCI35sbRtagZCDFgMkh4LL/TkksWsjE9XZVgej5lVAexAGFWG?=
 =?us-ascii?Q?yjWhbkeuPAKeEZRp/2C1yvLFPrlKSyUzlMt53ZZMwXh7I/4zT4Jf3P0BIwKu?=
 =?us-ascii?Q?+FoxKgwkIF6TOBL6dLCbEGiki0lx5jF8Y+ZcmfTBTj6caUMPkWsCVS4w0SEg?=
 =?us-ascii?Q?YaN2m8DybhY+o/sJbGyDTuh1LjeOj985oqBhHhwvLud+MwuKrsk0YkJkaHyU?=
 =?us-ascii?Q?LKOt7Df7seof/gCoA7o6P31v3G3+U+l1Qxpsxszy4qF18GWJ71cdJPx+Q7vH?=
 =?us-ascii?Q?cljm4KTMJ4yvdE5Q+1PKrtEU2raNOASrNwSOflNHkA7GT7PXJN5EkOyuxUKe?=
 =?us-ascii?Q?Mnx0A7KMeicR3EjosVzvVz/+m0dFpFM91Y2bpRHx7xNbwe4DjSD05VIwQjNg?=
 =?us-ascii?Q?pKDkqQ8Hg7lkkaSwEn4t7wTH5hXWyhlSys6YJvRWcOIWX5skDcubw0xuabLG?=
 =?us-ascii?Q?GLrMIR2Gihx0vuqCixH4gEOKyPZ0HSO3gQNgbyMzziheeRCYN73bA41hBK4Q?=
 =?us-ascii?Q?r66OUYA5lvBL8sJyC1qePY0tXnWL3hZ2rv3mRs5ptXJokkMi3vbPptO44bkC?=
 =?us-ascii?Q?C9UlISRHRfSFjyVriERXesTUg1wG0x7mtUiVA43OiUPWRXlMZYr/YogLEfKA?=
 =?us-ascii?Q?DPocrJREUUWdpjKuXUfB5WYuQ/V5jWjtlVGp3M3odezq/Ogw0XpNaw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 730703d5-5b71-4c9c-2e82-08da0a7b4ce8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2022 14:09:51.7479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1L6DIsvidbQgWXq/CJ4XXlWr3Ib+0lB7+S0DmoOy95zc+f75m5w+BRxt9LJRd+T2nUpu6SnK/hEvYm35MTafEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7035

This patch defined a new wrapper mptcp_get_subflow(), invoke get_subflow
of msk->sched in it. Use the wrapper instead of mptcp_subflow_get_send().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 6 +++---
 net/mptcp/protocol.h | 1 +
 net/mptcp/sched.c    | 7 +++++++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c892e3b6b65c..22be279c8391 100644
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
index 21bb248a2c82..91500269b175 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -615,6 +615,7 @@ void mptcp_init_sched(struct mptcp_sock *msk,
 void mptcp_release_sched(struct mptcp_sock *msk);
 struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
 void mptcp_sched_init(void);
+struct sock *mptcp_get_subflow(struct mptcp_sock *msk);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c1a4c5170b8d..bd096bf52f4e 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -11,6 +11,7 @@
 #include <linux/list.h>
 #include <linux/rculist.h>
 #include <linux/spinlock.h>
+#include <linux/indirect_call_wrapper.h>
 #include "protocol.h"
=20
 static DEFINE_SPINLOCK(mptcp_sched_list_lock);
@@ -84,3 +85,9 @@ void mptcp_sched_init(void)
 {
 	mptcp_register_scheduler(&mptcp_sched_default);
 }
+
+struct sock *mptcp_get_subflow(struct mptcp_sock *msk)
+{
+	return INDIRECT_CALL_INET_1(msk->sched->get_subflow,
+				    mptcp_subflow_get_send, msk);
+}
--=20
2.34.1

