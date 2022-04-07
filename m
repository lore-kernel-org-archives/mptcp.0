Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E75620EA
	for <mptcp@lists.linux.dev>; Thu,  7 Apr 2022 04:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649304639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x9PjuXmxx//rp3Sg1bxMtKi7svQtMfnWGsRK9tVAIhg=;
	b=Hz6iN5rUNzxWS+RAw/HOlMxdC217JvJrHuBVR4Y46quKwLSYNZm3I4wWA8tI18vhDjBSOi
	raha6UZ19EghnP4Wv1au4oYm/5mT0UZK9nHFFcMlX7jpJ4VP6bOz7qRR4ujKhHtx4uNDeI
	IhO39x5q5WrdCj+sZGo7c+Xfw7fbkzg=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2107.outbound.protection.outlook.com [104.47.17.107]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-QzVPzynPP6yFh5QTMGIiUQ-1; Thu, 07 Apr 2022 06:10:38 +0200
X-MC-Unique: QzVPzynPP6yFh5QTMGIiUQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNh6zlG4b2JbNq5TDWaiSngbsFXejVQrAlE33O1435j9luJnsDn2oI7n/e7XDl2AbMJIxaKS+a62z8eYbdM6ggdQf4vmp3k23gCgVaignnadYaxA5jFvdOmZl6DGt0GDIHMdRh+9SjIMIPx9e4tVh5TrVyiWu1KfLztnc9Jk8rkJ9g4Z/v1C285pqNC46Y5aJf7uKkp9OgEe/e61AyqGL/ZSF8EJmuhh5MnqzspJ8C+1n8luWOPJ+2CWG7UZw04/EFckT/eRQvy+3/wuRmSuJC27LiH6GdRwQ1de4oInMAzJeA9otdyR78+iujM1BwT8Co0/jW5a2mfKsGuVP3dPZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDnccN4Ej6cG02KY5kELgZn3ENNVMtxOEg3GeS2yTrk=;
 b=liWHwPRdGU8DDVJtlWXzwG2YYiIYgUIIRadpFmnZTS12uzikL7fqXYbOzn2+bbOuwh9IZ56G603teTaNflsunduJX9Sdbwndp5zePPNmebl/8Tb4AYY13khI5N2eH0zWVoA5WSwfGdmj1dAeCX7QY2y4x9FDVcpA9UGt53V8YxtExAKSxWMD1ku4hR0h3JkdUej21F+pfFsoqo8OE7VP7WkfzoEjgB9fwk5k/AiHGEMKAgKs+BICeAhTRScXqpFFYhaW1q9SNVcffUNgpq1crzgDDlXqjvxwNtsQx5NGW3uYBzJKYO4/htnB5Bll8/nd73sQuTzZx9D48D2StnQ9Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3354.eurprd04.prod.outlook.com (2603:10a6:7:85::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Thu, 7 Apr
 2022 04:10:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Thu, 7 Apr 2022
 04:10:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 4/4] selftests: bpf: add bpf_rr test
Date: Thu,  7 Apr 2022 12:10:11 +0800
Message-ID: <23532823f88c24c7549e4e0bc19099e91c3bba83.1649304364.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649304364.git.geliang.tang@suse.com>
References: <cover.1649304364.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0030.jpnprd01.prod.outlook.com
 (2603:1096:405:1::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84fd21e6-e6c5-4f2d-ca93-08da184c920a
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3354:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB3354F4B1E327F961B7F181EDF8E69@HE1PR0402MB3354.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VkMOO/er7yTCr9VIsciK6ziki6JK8WHRwGTd1GVcIzZcBja7JupTABKxNN1D/HQZRchuMUc8MKlXyijirD9OZ2uuIVqORLDi3ale5DB3PpTs1puBSNRh46VO6SK9Yj+mUWirCtWtEwuyptkCW6BsnAeW0SEtembWh4UpWwkObo/yGt9hnWOZmV664Slz92uhx1WS9Ti6eo2pa2PhUIji4fcMiOCdLnexDF70RmPw0c6GkqAt5OaaOfyvxEmu0/phIZ6hKMJ5gtV95DA+6pi2IvmrmI3xGiIj12qm8v2uHo3ElKtlOoKHo8aSxLKHSq5fqoi2W7s4UmpYuOt5vWMVcUWqjz3EsXaZ7XtR/JqDqFJKQ7gGKaIYiyt7ikyP0HVZJ75mUbFicYklKrxj/HKcx/xp/p0/1+5U7qZzdqZMa0k3/8rwoT0f14OMLfGxx6Ta4ollWMIMt9dBrKMfBBuZDV8aABtQKnNJHHQ7eY0FWTZMw8Lk3fHz7kFXoh0O4nmIqFZ0UgbvyZ5o8FRQnPnLbrBrUHBdjJktAxcUquYl9xG3NmCIcoKAhOADhnasYaE6Kvuwa/xSYBk1BmBN9gDLLV4b1SRU+JmGxf0MRVdvtfayEj/HkeyuZ6Z1xR6cLH2OxPC/hUeG252iE1v0rRi6H+wSgE+rtWouCi94lGKgaxVv+HQw61VD63oplmmPYWuE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(6916009)(107886003)(186003)(66946007)(8676002)(66476007)(83380400001)(2616005)(6666004)(6506007)(86362001)(316002)(4326008)(66556008)(26005)(38100700002)(2906002)(5660300002)(508600001)(8936002)(6486002)(36756003)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aevbrlpMluHLofK3raS6t61h68VklQjSJbiDbFjBG+5aR83lRn8Xg3aGHmxh?=
 =?us-ascii?Q?tr1WWELFa9UMS6YQN//uEDUtlQda7xQdqJZCH5gkZCvYzS/RJihGt7DsHxcl?=
 =?us-ascii?Q?2MiZbszbN5TKAjB7e8eBPp97IlFquDR4pNjPfTcdW9zLfmdHjm4F8oSGDcH4?=
 =?us-ascii?Q?aS9xpavqA405s4r0XOyfdp0i/qWuWd5ulqfsRhtGuGkX4ps9Y4X9vPSpwCiz?=
 =?us-ascii?Q?CNEGiKFc+JTqOk4JwxACy+kaMxigxwmfDaba1B9NYDsqBn18StC0ZMKkwoKe?=
 =?us-ascii?Q?YKU4D44YDUtTWxA9AUWMqDTzpFqMwmhTG5jbFTJCNxUSLh4cgOigOPDUwQc3?=
 =?us-ascii?Q?whZYJ1AhjtrJ+fozMKqIjSzcuPp4cvgCFDmGGhAxbd7wbVddAQszO+HAJ4s2?=
 =?us-ascii?Q?bPQkZ1JqqkSDFHOZ/bDA3VwUaad5O39NoujnvUDeZB8htvqabJeCs6sfivns?=
 =?us-ascii?Q?ElmTvueoMVMCZkBsvBV+uo6EynIpq6c8FWbxTiNBlgadalSOusNxzPUp+cMV?=
 =?us-ascii?Q?FJ/BMlLuWemW7dJR5mhnWsQ10G6FUlRj7LRJ1DUm4N7bB3kB4T3i9b3DN+hJ?=
 =?us-ascii?Q?w4uT6Y3+cUMzDLo8HAsW1P2lL0jaeRBwgGrjVf9DXs5QY6hVFcF9cGvx9Ap2?=
 =?us-ascii?Q?I+UaYQgTmftC5ySu7ohdbpFXp/hniavDNeM3HOZuEoiVrhdaNA0osjQepvYP?=
 =?us-ascii?Q?xnxY1p53kMHD6eN02nftugcdXkUBUF8kj9SqDD5tnCktn4WGcSihMSrRJd/W?=
 =?us-ascii?Q?Q7cnKvCsuMqBSXX+DkTvf7mX9RMf+6YQXccFwGq2dO9qtzR2JCunstLqCAF1?=
 =?us-ascii?Q?9W9HxZAKzS2sh2SFC6vi0U/YENN4GqCe54dWsWpZlhUajzHla73VRG1fbPvx?=
 =?us-ascii?Q?Mrxz6fdynojLE6Gi4FcJ3Z3a2Zsr2E5gIvv5sxRtZj/cB55c2NAvH8lX3wVj?=
 =?us-ascii?Q?oLvqUDavnuhNUa6DAr93Y2pMMG0axt1PWQaGa7oOuXDvL9T2xLnBVtNMBznh?=
 =?us-ascii?Q?zL8dV7DV0hN1J6SBtHPHAcMXF3eU3S2W0tgRR5/8uFfK8lIjPj1uyqNctOnc?=
 =?us-ascii?Q?NTMmbUw3ERjGoZrJoadf/VHOe4b5mE5RSFWMKL3AZklqLGsJs3J8PWuPIJ41?=
 =?us-ascii?Q?JVIsH21I+GoUiqgBM4fuw/kJ0cyJCNBcff+VlAIAcT6gAAEhffc/4rqHTL91?=
 =?us-ascii?Q?/zMBemEprY7gHFP697ul8upR2rtHcMjaNTgNRsnnx0K1N5hEU7Zq++GTaeeA?=
 =?us-ascii?Q?aJhk1/aTm2IgYE5L/zrong73M+sOaSrmiA7gSBKwAEnCWHj4soCROcTSjq2R?=
 =?us-ascii?Q?E1umxhdQS7p6JcAf6MOCk65QNAJVTFsmy0IUSzty0cBAjI01HEG6YzSYgMEB?=
 =?us-ascii?Q?Lfb9sWZxzEba+hFhJIY4fpqy+Xx5pQiVwgr5nyLoW7wErOvttoYvp8454dsb?=
 =?us-ascii?Q?pMXK3DAtbeED6Bk/cKiVHfUMWP+E6qxxAef0FP4H4zxOpv4vQzoQiVwCeHYJ?=
 =?us-ascii?Q?kUcyMBimJ/X3sSzmVv1KjGBRNIlavsdC5uI1F+yqGVT7G+yNdnwgr6QKxC8W?=
 =?us-ascii?Q?zoLB6EPxIvVqAWYaoq9XSaSjZ6NHAnY6BgMvLHE32T6o5/9c0nLkIS/RJwxZ?=
 =?us-ascii?Q?btnocTIUYl8SPlZaZdLHpC2RyQHlWkyPEmfUBwNqT/HXwib2ljDE+rkwkQxe?=
 =?us-ascii?Q?jkgwXWuayQnFCoanclJ6QUeMTqKlb/lYtGpVaux46hgLN5a/2xzdS71eutN3?=
 =?us-ascii?Q?1tjnb57pCROZdoKh8bnnfJvJaQeu0zI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84fd21e6-e6c5-4f2d-ca93-08da184c920a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 04:10:37.6233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPC0Xb607G6dDT9X5RYSbZmXjnV6lxV7JxWqWGq5qasWYvnOm1wHtnDG9cjcD0q6qLWmvE2g9Dy78V2NFql/eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3354

This patch adds the round-robin BPF MPTCP scheduler test. Use sysctl to
set net.mptcp.scheduler to use this sched. Add a veth net device to
simulate the multiple addresses case. Use 'ip mptcp endpoint' command to
add this new endpoint to PM netlink.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 377ebc0fbcbe..7052c520c0f7 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -6,6 +6,7 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 #include "mptcp_bpf_first.skel.h"
+#include "mptcp_bpf_rr.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -362,10 +363,46 @@ static void test_first(void)
 	mptcp_bpf_first__destroy(first_skel);
 }
=20
+static void test_rr(void)
+{
+	struct mptcp_bpf_rr *rr_skel;
+	int server_fd, client_fd;
+	struct bpf_link *link;
+
+	rr_skel =3D mptcp_bpf_rr__open_and_load();
+	if (CHECK(!rr_skel, "bpf_rr__open_and_load", "failed\n"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(rr_skel->maps.rr);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_rr__destroy(rr_skel);
+		return;
+	}
+
+	system("ip link add veth1 type veth; \
+		ip addr add 10.0.1.1/24 dev veth1; \
+		ip link set veth1 up");
+	system("ip mptcp endpoint add 10.0.1.1 subflow");
+	system("sysctl -q net.mptcp.scheduler=3Dbpf_rr");
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	client_fd =3D connect_to_mptcp_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+
+	close(client_fd);
+	close(server_fd);
+	system("ip mptcp endpoint flush");
+	system("ip link del veth1");
+	bpf_link__destroy(link);
+	mptcp_bpf_rr__destroy(rr_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
 		test_base();
 	if (test__start_subtest("first"))
 		test_first();
+	if (test__start_subtest("rr"))
+		test_rr();
 }
--=20
2.34.1

