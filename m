Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DB128E4
	for <mptcp@lists.linux.dev>; Sat, 28 May 2022 15:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653750722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TAcmGRr1lDxOEVWSDyU1aA1gIKcZZg/PTK35Z4J/kZk=;
	b=dhya5FvINwZEUubpjGKU4EMlwDPfh+cKjIjPEYEyrEnE8K+W9ZYSInmlXK9ss0sqfQwOMd
	S4+hyPX854vjS3VcgNziFMmadjjgTCfdjqh+eLFb3s8xYFxW8pPhjG54oDfyYM4qlSugAl
	x2Afk49W0DVWmcV7lOyd2X/3hf8U+yg=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2057.outbound.protection.outlook.com [104.47.1.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-19NzyVGfNXCvB-hyOsmxFg-1; Sat, 28 May 2022 17:11:56 +0200
X-MC-Unique: 19NzyVGfNXCvB-hyOsmxFg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChiDzIjzQ+bd0IoTcKZgJL4TSrwcy5hHsW3aAH1USiJoIGa3ac0XhT0lG4LpqfWStPfiubaAmOeJuTHjqBKMnQ6Xca/RYyNbjC59WMGHiofjGLax/yhTm2cFOHuIz7XAjd5bgNJF3UGh2eJzm+oJKvfWPQMyFLOxLbl+QevR5+iat+exhFYAKuUWgXPrQuXa9+Rsh/frSJ7aZkHCQS6mGVUbzEQ9Ac18syd+jjt+U1ZHcUqHNVfvERPuFVKlMmxzMREh8nP+qEyCixaK/E4tghW3cD66UP2OSS/WuJ8O7TuDYYcX10SeY6hNzmi99QJMHwe8GhcopG+2mR6ruBhG3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9EAaPilZc+t56m6nC5qsqHPiZiyFqS5pUIxf37syIQ=;
 b=LYIvp1GEfxs6nkt2erVIWX3tntUHjETbTTyUp5VZFnV6nVa3boZOHhdi9lUHNB9RF52Hwi+gNVb1uYaKeG9N4TeaUWF4ddEt4U9ewqi1VkbSniapBuaw1W+V13hixZ2H3d/q4JYDZMh6toBrRDzTApmELGS/OS6eWnIvVabR8O07clYKb8ApbvJqr5KdtdsIcsksQ2JdOTRr2MhlCLP2LLMSJfYVBwR7eIF0B2xhIvqSC26PlomBObCqBhZENz7d7UMhuUb+/e6b/8PYpXawnOJpKQIXPRnsKe4TNJe3qIpT/l3zdVm36roSlnHJL/00OgIQwYibP2cMzFJu3InGrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8485.eurprd04.prod.outlook.com (2603:10a6:20b:418::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Sat, 28 May
 2022 15:11:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5293.017; Sat, 28 May 2022
 15:11:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 01/10] Squash to "mptcp: add struct mptcp_sched_ops"
Date: Sat, 28 May 2022 23:11:43 +0800
Message-ID: <5355e749a5027f3b1c6d5c7307892a590b09e206.1653750351.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653750351.git.geliang.tang@suse.com>
References: <cover.1653750351.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0101.apcprd03.prod.outlook.com
 (2603:1096:203:b0::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0530cd54-5964-4c34-c98c-08da40bc66f1
X-MS-TrafficTypeDiagnostic: AM9PR04MB8485:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB848582B0F9CAA827A21B8CF4F8DB9@AM9PR04MB8485.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h7Ap1TJDcMDc5XDMJOkiiTbPd18C0fjyjGdSPBCF04hLjtOHwNg74yeaICnCIGEvyCBDYU6LXkGQl0ZVrQJwh+WN2dkcPUGAgNtFFLSO7CsprTV10PkNnf5fe7jeBpBheIoeYtYGArBAofM2S/qHunmG6BaJA4HrCPQm8v6fXZO9yTYqbFuU44kme24kXKPec+6KXszIybcIoGAinfmw3o6IwNjjm6fgsnatjK4Gdt5/ggAlhWc5pMrqbhgf/iUNrORC58/15hO0cwrWHqRxMNBAj9O5J07DRXa5vnWzoz66hc3TbTS8zhNO/InpOKvEVzjP4hO8GnfOUNpyBq0wcOqwiiGwLK+QXA8+C25hGvUE1Y9VcOqi6d9UJTnsKgvtnNotpvKGT4WNs25JQ5Ea3jQQGoRCaYyMXRDJckU1Mh/mqFIvXVx1VsnYB1E+NDLtLQDAVWvSUk5sGzzD0fyAbQRowpF0n9+vstm2MN4J9yAdrj/ZdQm/TqENGj1W57QtvNO/MxHGcDIlXdKcvc3cv6y06o9MqsevZozZVan1VF7OY+XZMpxwK8N7KeutjIn7BHznAmifhHymcZsugSRFMqpv7Wra9Co5gbB1D7r7n124ik2qrVkFEsIkVjFhvVtGJN/pj2dQTDHI05Kh1VQVy/mf3lKVBZo4GY7jjWaYm0L7EQBf8X+bvY0NmI0m4drY5YGgoMdAjNTMMC7PZb7hrw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(83380400001)(66476007)(38100700002)(4326008)(66556008)(8676002)(86362001)(186003)(107886003)(2616005)(66946007)(6486002)(5660300002)(2906002)(6916009)(44832011)(6512007)(316002)(8936002)(6506007)(6666004)(26005)(508600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Emz2X7mHoE5r+RjBoa3yW1//7mle6BsENeafFgDkaKHCL4vMkxAzd3oT1aUf?=
 =?us-ascii?Q?qxhAJkCREjAKVkF/oftmd+v1AO6Pu57zqM2BvK5DVn4Q9W88DSBowqTjU2gY?=
 =?us-ascii?Q?04FFnv5HjdRKawB9pA/K7fmLz90tODCfiKE/nUDnJxBEDbAn5dQdZQ4IYr/f?=
 =?us-ascii?Q?raK5jH29Q1pbu/xkN2HY5r1xL6Rxb7dIivlq3r5K83Kw11t/ETeSYHDcF6ef?=
 =?us-ascii?Q?Wf3PqBYQTQLOOfRWaQ5ow3cMnwnfgEqjaEwbeouhBFoRdUtfhDfq8BkBKgQA?=
 =?us-ascii?Q?UqYUVP0g2rr4kT3NZ9fHWk3R0GUzVjlsxXPeKRsxhA5YmNCyJ8kZZGuDnQXu?=
 =?us-ascii?Q?G44bgkkVLDX0GPs1uuwXI2w1cxYz/du+tql9A6PjzjC8pGSgigpCfv/PZpkP?=
 =?us-ascii?Q?S9QRtP5wQQbe5U2kn+PvoovgrqAzVGHg8Ej7szu3hQtHU1jxrJG3ZJ2Pk2wI?=
 =?us-ascii?Q?ryaqsu6Pj+PssQtaAM3+wYOAhrn1YYeI0XZLD+1Pxts8CaTvKzJiIbSJizoC?=
 =?us-ascii?Q?MpkIlp5avn2I/olFmKdSKMQDAPum4mSx5h4u/bH5DxVX1Z0iipvnrnfKQlNF?=
 =?us-ascii?Q?E7P96KVLX+IGLCQ9CJaZcateHBQlGyTojgl2vMuWt+mjvNQb+h50uH6iDL/l?=
 =?us-ascii?Q?R5KRmASpSTouPI3Uzdd+tCyYzQ5ZP8R0S4bLhcaU/lF1UEnDKRaezVrne6kK?=
 =?us-ascii?Q?61v3F5Pp/mZlZHN7A+UHICuyA839QoPsKn3VPPPYE+SjwiJ+RYIYeAditzW9?=
 =?us-ascii?Q?Oplg+FXFpzV2porPR3oOMrAFGWDsrQmNtrtNYLoI4Phh7eOJFDAZ0V0BSrg8?=
 =?us-ascii?Q?n550PD3bsocHl3b0sr+QWYhusyGOLisyNUhs6cAs9FhzgRhPCJpktIqrUXo9?=
 =?us-ascii?Q?s1Sf2JKfTPtmYK5zRzW7jxIwaB/QLyf0xlXTd596T+mSfc2UkCV/F7Z4tWuQ?=
 =?us-ascii?Q?Wmiua/2X55mCa8p5TfyzEiBMEk7ngW3QEWOBACwgJlKTWAGfoOGH+RECYA9p?=
 =?us-ascii?Q?uOj8AlQt4Nkef9PSxszPOrtvYWG7vBqx6sneR2JxKwSoTRLvKUeXWH/SBtHc?=
 =?us-ascii?Q?jp+C8F1qi77y4+aV89E2HN8vDpvqSDtCEpAbUML/4LnsjX4GRsVgeHjC2eY/?=
 =?us-ascii?Q?ZmLdbnHwGu7f7a8WtJ00PXGOmMlFmpyr4XomeAxe8OR0vbfh60CuKIgpTkiR?=
 =?us-ascii?Q?5O4dLfCVszDEWmQ3JRNjIoR6fWzzbzZfVIx7NghRvbZRhaB/UHrJoze4sPuK?=
 =?us-ascii?Q?1fNHPgdZJ6InO1aQm1MtNCGHer7qi8E4aYzVWLW0nb3EQbVtLdGLcEKiqV5T?=
 =?us-ascii?Q?Q9e4GUArabN/7J3QKY8A3lgeJivqRX0TtUDW6LhA2P6ZxYqxye0lU8/gP0Yw?=
 =?us-ascii?Q?zETGNOcAoN7SGGIAJMJo/tN6zWdb5HOiTWM4FrCbcQKvFxUbkIDDyqH6bEP+?=
 =?us-ascii?Q?rDIjQ6UsN/ocsp38HVwmdXYjy+rsfGw6vNjxRiUaarVuX4DA1cQMVXDqdNJR?=
 =?us-ascii?Q?qEvRSv8dbl0F10OzsKsSdNPRQoI8B9oEDdYZ/0qswrz5wYJqK8kXvX+dOfGu?=
 =?us-ascii?Q?8ieRNKc5W57K1OPWtaZwuIA7W7xq51bwRSRMtOxgO+XYvkA/jvDdJ6n4qz7B?=
 =?us-ascii?Q?92Th3QOSmmddd441nnR4YOThftQTqtelD6SCOqLPJEbenoKZSUggv59RsEaY?=
 =?us-ascii?Q?3KT7whsWwIiDUbkC1A8iZXBT0BvI/xvksiDKXQisb0ggrv4cGoH84eWsFyS7?=
 =?us-ascii?Q?A4O8eHTARvhahezFmL3JAEl9o/LafQA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0530cd54-5964-4c34-c98c-08da40bc66f1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2022 15:11:55.4622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WChUKorAC7aGfyzdO5fS3tBgkmMoJ9IlH1g6U2bfISFFvB1CfQA380D+nj6rfAy0mPSzFjvQG3JM24ogu6FwDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8485

Use bitmap instead of sock in struct mptcp_sched_data.

Please update the commit log:

'''
This patch defines struct mptcp_sched_ops, which has three struct members,
name, owner and list, and three function pointers, init, release and
get_subflow.

Add the scheduler registering, unregistering and finding functions to add,
delete and find a packet scheduler on the global list mptcp_sched_list.

The BPF scheduler function get_subflow() has a struct mptcp_sched_data
parameter, which contains a mptcp_sched_subflow array. The struct
mptcp_sched_subflow has a member is_scheduled, it will be set in the
MPTCP scheduler context when the scheduler picks this subflow to send
data.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h                           | 12 +++++++++---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 16 +++++++++++++---
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 6456ea26e4c7..8a53583a9745 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -97,14 +97,20 @@ struct mptcp_out_options {
 };
=20
 #define MPTCP_SCHED_NAME_MAX	16
+#define MPTCP_SUBFLOWS_MAX	8
+
+struct mptcp_sched_subflow {
+	struct mptcp_subflow_context *context;
+	bool	is_scheduled;
+};
=20
 struct mptcp_sched_data {
-	struct sock	*sock;
-	bool		call_again;
+	bool	reinject;
+	struct mptcp_sched_subflow subflows[MPTCP_SUBFLOWS_MAX];
 };
=20
 struct mptcp_sched_ops {
-	void (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
+	void (*get_subflow)(const struct mptcp_sock *msk,
 			    struct mptcp_sched_data *data);
=20
 	char			name[MPTCP_SCHED_NAME_MAX];
diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index aca4e3c6ac48..91900f2f047a 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -231,10 +231,20 @@ extern __u32 tcp_slow_start(struct tcp_sock *tp, __u3=
2 acked) __ksym;
 extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) _=
_ksym;
=20
 #define MPTCP_SCHED_NAME_MAX	16
+#define MPTCP_SUBFLOWS_MAX	8
+
+struct mptcp_subflow_context {
+	__u32	token;
+} __attribute__((preserve_access_index));
+
+struct mptcp_sched_subflow {
+	struct mptcp_subflow_context *context;
+	bool	is_scheduled;
+};
=20
 struct mptcp_sched_data {
-	struct sock	*sock;
-	bool		call_again;
+	bool	reinject;
+	struct mptcp_sched_subflow subflows[MPTCP_SUBFLOWS_MAX];
 };
=20
 struct mptcp_sched_ops {
@@ -243,7 +253,7 @@ struct mptcp_sched_ops {
 	void (*init)(const struct mptcp_sock *msk);
 	void (*release)(const struct mptcp_sock *msk);
=20
-	void (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
+	void (*get_subflow)(const struct mptcp_sock *msk,
 			    struct mptcp_sched_data *data);
 	void *owner;
 };
--=20
2.34.1

