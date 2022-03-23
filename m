Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26371391
	for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 09:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648027756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SBetFJ/hf24FoSZ/3gQHTEBo+uObUxuEPrr46Np0joo=;
	b=M9MRUZB8HB8JuRcSSfQn7HOozrrU23YEOQyEJY1GUcJPprs1zHwtcxyZtoIPvz1tvy6gde
	dBCPO38p1X8cJZfPk2k2oCoM34Fc8mvWnqB2pvVGAp8Pva0kUDg48+yqsTGL9XQDmoJMz5
	8KAKaXHKp4FJcOtpMhLornWW6bJeWDY=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2173.outbound.protection.outlook.com [104.47.17.173]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-OYUIp8hEN2es-FsN9IPmmQ-1; Wed, 23 Mar 2022 10:29:15 +0100
X-MC-Unique: OYUIp8hEN2es-FsN9IPmmQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzSMTXeCkfOn5N/eMZ8vWInVimWiSm3bY0jsiG/QD6TgMTWC8Q+ZM//4+00Tif2IdT8me+1z3QA3HOU1wS4+/nrmMPpGtjC4UQuNv6Ege7x7XZDQE7XypQBc/mFrQ+5pYiW6/cE1/t4TXTtSoP049XztYIyCRGldqiMtMY7BeqDiSPDYf2CBEBHl+Wgz6Lx9+wNZ4qnzl27HTVFdPn4II92hf4F+dJV0wpbnS6vDajeW0eYFJJstjR+KpwAVEFdRIn1zdjPKlQANfJPgY45mH2sCNYc7G5jIuQ2UaWBHfo6i87rHvsjOTsL/mobqT0pu7L5Tw0Qx1wZg+v8M1Pfgyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFUb1G0gcEjAAwlYB1STU5HkHqMxAZTWE5PIj8MNvv8=;
 b=MPdxJPos2A70Xy+GoHw/DQJkiUvRJl/FrT4wTbCK8NYtNbDjE4FI1FkhE3QLqKiM2zV4hSTs8CG55rSMXyBnHaOObLg0867iIzO0MN2alimHfyeOQjOXdKwiZVEO/W4aYyBAm2tnMPRynerIrflbAzyPzGSCB8f7Ip/yzPWrjqj2ePHZ1JcVnYs/VlBJX5sdE0dLeHoGe5PA95Q89WT5CwTWXQHe/Xq56gB2uA+HAoHODEjShCLOLKZkRBxfc6Ep8EeRB0isWF/JdIzkJNDxHTS3OiJbR4s9yjQGAbCevTG0lLEliIcWETyhai1Zb+zFXHp85g0jmG0FtWFjUcDY/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB6733.eurprd04.prod.outlook.com (2603:10a6:803:11e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23; Wed, 23 Mar
 2022 09:29:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 09:29:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 1/8] mptcp: add struct mptcp_sched_ops
Date: Wed, 23 Mar 2022 17:29:00 +0800
Message-ID: <fa3a222b7462e0645589d29a9949a14df0d27a28.1648026806.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648026806.git.geliang.tang@suse.com>
References: <cover.1648026806.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:203:d0::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5b49e50-278a-4332-1c39-08da0caf985a
X-MS-TrafficTypeDiagnostic: VE1PR04MB6733:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB67331BFDE90DD572F04DBF54F8189@VE1PR04MB6733.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6MAA1NCbfNENJ5DGsCFe4WwxAfrGcNYgP4x8i5g0UjQwD0AePgk/Tklk68F35vldhdqOH1wlKmhRHtHfvN1lNzZu5DgOqE/WGdpDFQy0BX5PGOKZ+O50yEzec/6NXuYrZS+PxkgdSDtijB5neRbnE7QYZpEkMmpDutExscybLJrqVilx6ChSh8HjTN2G6HysciY1bpvNvkFiChj3fiMsfqZPdhlWSjD4jn80ZeU3MXZp4OlhiczvMfuRgfqgYSAn5s0zNzVaFbBrvuEST6m32fw/tD3dnEJG4kh2dWRqsxkya0NTL39zY+2va2SuIUvEm62EpZ69ZXE+ulowCrRPYQrNZCi3fFjpim8YmVCHkRWMOJ3RvoJ91Qq/N1lqKspSA4dkvT8BsGKA+KlqejR3oN/fLB/TBpaoMNi5n+SGw2AR5JWlaU7/MAinkUEtbAEZBcANOO2CbUzPmG8DpnNgPOQlFXMBsGtbJ3O5wTiXRtbX9agR7qKxUiXbQvDpNieyGYuR7uqwUrmV/09wXn0xiItElSwWFeGfQ9PyHm4reAHi+++PDRgWMiEtb1yUtC0q7wWHHWmSmzdckZc1kUJW5zqE+gTJCNx4uxDyUu2TZnS5cALLIOXnZEZBJ6kydZZUMMyB4175ez6L4TZGAznbASN7IDWM4VE0fCIRVgRWKJpUriktV37KtnxHrLnfOobf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(508600001)(8936002)(83380400001)(2906002)(38100700002)(6916009)(2616005)(316002)(26005)(186003)(6666004)(107886003)(44832011)(66556008)(66476007)(66946007)(8676002)(4326008)(5660300002)(86362001)(6506007)(6486002)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e13VTZe3DGq9W3T883xjdASenGanagtCp5fKRF1XKe21b+Ga83s8MNrtaiNp?=
 =?us-ascii?Q?LACwNG6jlRjFdMVzypq7cPHhgQsxfSG7oEceClcrP0nW7sRRD2Cmx7Qbj+QS?=
 =?us-ascii?Q?4lo279BCI3IpO2MQP6N/D8x/0AYXd31aqbeTfrfPUEpKTJF1WqUZHJ/BnoPH?=
 =?us-ascii?Q?DvU+3zVURitKpiA1WgjegA+aoEmX377CIfMbLlZLnjXuf0Grbgslq6c/jaGY?=
 =?us-ascii?Q?/hsCilRK5Xkpxa0Wh31SY2KmpOZBq/aLfLEw9NeUSEqOJBaKoWHxN1eyArYr?=
 =?us-ascii?Q?dCnejmtKniEtfm+Ra9N4TNJjOintkGWdpJSwKj6DORNDFbpqMldpTrPOf6iZ?=
 =?us-ascii?Q?Gvjt7T36qTGgKU/g4i8YvO/vVo437rnbYBTaeqJZg/WDlROMxazAsjqjf2mf?=
 =?us-ascii?Q?uLvJV4SLf53GFAqKAap8+gD6DttnlqucnOh6rpY/vL875tj4N8nLaOX1FAer?=
 =?us-ascii?Q?OU9V16cNM7tHUtIZ/7HvUjNrOpvnfvOrAIjWjxV8izTQIzi4RumJXrK1GWXV?=
 =?us-ascii?Q?PchTZyJ3Op67UOIOzGZCdu/qHtkZwuH98871ecUJhqGDUkswdCTvmhsgvzPn?=
 =?us-ascii?Q?My8aUpKoFPRMdAjo4nyyrNl5eJyc8/yzhHjNRUsi+gaPjZxmdbnim7jAgEEb?=
 =?us-ascii?Q?pJLaTbGxMJsyOlPG8rh7S9+1b8kMF/FWQyuvv15PwEhk/zPxiKQuXxcA+a03?=
 =?us-ascii?Q?cEMq4FGN76pMRX2aI9swxdJANpB3dWnBuCWUzmFfJojqdWBzC6CWeqjHjVyL?=
 =?us-ascii?Q?tGM4ZJQS7FmgIynVpPQ/XHrrzEjMCnEXTYiBQ0p+LgDbDdhCFNwvOu6H1Mja?=
 =?us-ascii?Q?SLVj9JtYaJ7Kq9C+mRbdbzx+nl6czq/C8257Jk1CvxFTNu2HtHdsmUYnQg9B?=
 =?us-ascii?Q?0HpYiLoxawoX+q6WeAjfgrYn3qCvUu+wbpWhoGplcbsoH6aj29OjllMV2QoM?=
 =?us-ascii?Q?nEteBhJ7uZ4CNvqc2DSOK1PuEjLSqKQxR9SvbbsT/4Y+5gRSXlJuYAmqpduc?=
 =?us-ascii?Q?rKNG1grOmKP43qx3kwD5EFDR82U6CyzB+eopIR84/LMRWd0i7KLo+stSjDP/?=
 =?us-ascii?Q?GK82RS4UEtrvNgUP8tFdG9mUJDHzM534egQTRDXpuJesGS34/MqY+JCSKj7b?=
 =?us-ascii?Q?mio13KPJmdXS1L/P0+QHlcdEthKPxbCSCqamdsOSdLQPzvnOOedPoZAs0cPB?=
 =?us-ascii?Q?aRnIAuLifZT49EEL1BlttG8I+jLtU8i7j5V8dhspV+VNkLtfHxMWb5vI88RR?=
 =?us-ascii?Q?JQztPtSlVKgypZ5Kw+Dovrrl3NP8VrvXNJWc8Xg2SWiPvXjklVB3Hr0tg63D?=
 =?us-ascii?Q?LllDqovsKD9VKWOqVKNgqgHlSN75Wlbrm8SxC7yka3KQMMwurnjzdXonZOkU?=
 =?us-ascii?Q?/swFI0b2qbOHvA3f8bpa6Ba0fUu3cK/JcBo1esV41QGLLSQaw3pQ6S0Y8Xkb?=
 =?us-ascii?Q?PM0i4B8JYkCR+v2Oj9rHNOeAI1YcU0e+3GuNQL/ABUjIA8aXNovk4g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b49e50-278a-4332-1c39-08da0caf985a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 09:29:14.3854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hfqEg1KLDrgf1mry1IK8y/Zt6MlF/Y0rGVS21WNlvP8uu76td97jkvvraeUGyawvDpXa4nlN6PKbeoR+Cm+rog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6733

This patch added struct mptcp_sched_ops. And define the scheduler
register, unregister and find functions.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h  |  13 +++++
 net/mptcp/Makefile   |   2 +-
 net/mptcp/protocol.c |   1 +
 net/mptcp/protocol.h |   4 ++
 net/mptcp/sched.c    | 111 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 130 insertions(+), 1 deletion(-)
 create mode 100644 net/mptcp/sched.c

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 8b1afd6f5cc4..e3a0baa8dbd7 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -95,6 +95,19 @@ struct mptcp_out_options {
 #endif
 };
=20
+#define MPTCP_SCHED_NAME_MAX 16
+
+struct mptcp_sched_ops {
+	struct sock *	(*get_subflow)(struct mptcp_sock *msk);
+
+	char			name[MPTCP_SCHED_NAME_MAX];
+	struct module		*owner;
+	struct list_head	list;
+
+	void (*init)(struct mptcp_sock *msk);
+	void (*release)(struct mptcp_sock *msk);
+} ____cacheline_aligned_in_smp;
+
 #ifdef CONFIG_MPTCP
 extern struct request_sock_ops mptcp_subflow_request_sock_ops;
=20
diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 0a0608b6b4b4..aa5c10d1b80a 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -3,7 +3,7 @@ obj-$(CONFIG_MPTCP) +=3D mptcp.o
 ccflags-y +=3D -DDEBUG
=20
 mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o ctrl.o pm.o d=
iag.o \
-	   mib.o pm_netlink.o sockopt.o
+	   mib.o pm_netlink.o sockopt.o sched.o
=20
 obj-$(CONFIG_SYN_COOKIES) +=3D syncookies.o
 obj-$(CONFIG_INET_MPTCP_DIAG) +=3D mptcp_diag.o
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fbb14dfe62b3..95f7c3fc943b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3743,6 +3743,7 @@ void __init mptcp_proto_init(void)
=20
 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_sched_init();
 	mptcp_token_init();
=20
 	if (proto_register(&mptcp_prot, MPTCP_USE_SLAB) !=3D 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c8bada4537e2..dd10899bedfd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -605,6 +605,10 @@ int mptcp_subflow_create_socket(struct sock *sk, struc=
t socket **new_sock);
 void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 			 struct sockaddr_storage *addr,
 			 unsigned short family);
+struct mptcp_sched_ops *mptcp_sched_find(const struct net *net, const char=
 *name);
+int mptcp_register_scheduler(const struct net *net, struct mptcp_sched_ops=
 *sched);
+void mptcp_unregister_scheduler(const struct net *net, struct mptcp_sched_=
ops *sched);
+void mptcp_sched_init(void);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
new file mode 100644
index 000000000000..52e7c74b33ae
--- /dev/null
+++ b/net/mptcp/sched.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Multipath TCP
+ *
+ * Copyright (c) 2022, SUSE.
+ */
+
+#define pr_fmt(fmt) "MPTCP: " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/rculist.h>
+#include <linux/spinlock.h>
+#include <net/tcp.h>
+#include <net/netns/generic.h>
+#include "protocol.h"
+
+static int sched_pernet_id;
+
+struct sched_pernet {
+	/* protects pernet updates */
+	spinlock_t		lock;
+	struct list_head	sched_list;
+};
+
+static struct sched_pernet *sched_get_pernet(const struct net *net)
+{
+	return net_generic(net, sched_pernet_id);
+}
+
+struct mptcp_sched_ops *mptcp_sched_find(const struct net *net, const char=
 *name)
+{
+	struct sched_pernet *pernet =3D sched_get_pernet(net);
+	struct mptcp_sched_ops *sched, *ret =3D NULL;
+
+	spin_lock(&pernet->lock);
+	list_for_each_entry_rcu(sched, &pernet->sched_list, list) {
+		if (!strcmp(sched->name, name)) {
+			ret =3D sched;
+			break;
+		}
+	}
+	spin_unlock(&pernet->lock);
+
+	return ret;
+}
+
+int mptcp_register_scheduler(const struct net *net, struct mptcp_sched_ops=
 *sched)
+{
+	struct sched_pernet *pernet =3D sched_get_pernet(net);
+
+	if (!sched->get_subflow)
+		return -EINVAL;
+
+	if (mptcp_sched_find(net, sched->name))
+		return -EEXIST;
+
+	spin_lock(&pernet->lock);
+	list_add_tail_rcu(&sched->list, &pernet->sched_list);
+	spin_unlock(&pernet->lock);
+
+	pr_debug("%s registered", sched->name);
+	return 0;
+}
+
+void mptcp_unregister_scheduler(const struct net *net, struct mptcp_sched_=
ops *sched)
+{
+	struct sched_pernet *pernet =3D sched_get_pernet(net);
+
+	spin_lock(&pernet->lock);
+	list_del_rcu(&sched->list);
+	spin_unlock(&pernet->lock);
+
+	synchronize_rcu();
+}
+
+static int __net_init sched_init_net(struct net *net)
+{
+	struct sched_pernet *pernet =3D sched_get_pernet(net);
+
+	INIT_LIST_HEAD_RCU(&pernet->sched_list);
+	spin_lock_init(&pernet->lock);
+
+	return 0;
+}
+
+static void __net_exit sched_exit_net(struct net *net)
+{
+	struct sched_pernet *pernet =3D sched_get_pernet(net);
+	struct mptcp_sched_ops *sched;
+
+	spin_lock(&pernet->lock);
+	list_for_each_entry_rcu(sched, &pernet->sched_list, list)
+		list_del_rcu(&sched->list);
+	spin_unlock(&pernet->lock);
+
+	synchronize_rcu();
+}
+
+static struct pernet_operations mptcp_sched_pernet_ops =3D {
+	.init =3D sched_init_net,
+	.exit =3D sched_exit_net,
+	.id =3D &sched_pernet_id,
+	.size =3D sizeof(struct sched_pernet),
+};
+
+void mptcp_sched_init(void)
+{
+	if (register_pernet_subsys(&mptcp_sched_pernet_ops) < 0)
+		panic("Failed to register MPTCP sched pernet subsystem.\n");
+}
--=20
2.34.1

