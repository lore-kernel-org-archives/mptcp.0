Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344D015AB
	for <mptcp@lists.linux.dev>; Fri, 18 Mar 2022 02:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647572352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVb3lDAosTJk9u2z+aEWPP3nnC70b2NntB1dS8zv6tw=;
	b=UcEROJeAF3vnJsrMmSBh65lFHTwAFlgnIJTzw52sqRUJ5HcbO+1w+VYD5U3khquplK06xs
	hGEj4bZk5J1DIee5Zep1b0bnPOKiqMJ8OunC/tI4WFW+oxEb0EggxLK33J6MqIT88otXR3
	RPThSv9PA8sOnVnfOI4Xk4QdwY0mVyc=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2057.outbound.protection.outlook.com [104.47.8.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-hd6lO945NGy4aBGgUyrLbA-1; Fri, 18 Mar 2022 03:59:11 +0100
X-MC-Unique: hd6lO945NGy4aBGgUyrLbA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjQRoVwbUFJbXmetkNYH4CPkjmg3ESSXQEfZ2tLEFS4oCvA0ZrkwYshmQgVLVJC4xz6VuphWq3GXZbihM4BNQgy/hGZVruG6rUNjeq1wBEvde6isC4e8KRg46bwSKTOvGO1s35nSN3sBr7xTjjgiX+k63GcF87xl0tubrmIdEKU8L9wN5st9izmo2ktZatfFwgvlirTkPhHzIbQPqn9AWV+ozzh4tDoADx6P86YjKPbTLjmMo8CNRDLXQ4jnrkTGI1XtDVIHtbm67a7DsFuOj7DSkUob2rWQHBk4ke4sCHOSslnrATU996gAnu0B0UoWcO1OrUfc1J8+q7gg5lFYjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYeTynXd83tEuFkDwFtbapTC1eObe3XpGn+iAMCsnb0=;
 b=MKlRrCKFQemO/uHWhGn7Uh7M+I/O15vsQ6r6jU7KI5d3K4iuXN/CxZuoJJ2GT/6i94UqwJMSIBwHjxfwR69OuR0DBGJrsTDwCyXdy5G9KlL6zDnBVvGElGS3hW1P2++ykxPgp8kf/1S8XiPwlGJQf6JI5Ci1JjPcAmpXxO+V4aurc+bo/OMOJiaaOlDmbvKJVdN8ySnX6B1W+qNt1Wew8RfUy+st+60DUIUqt0Q4/vX2Xykr5ICUDcUjbjh4mLHcgzEsVq3bMmZckLIGRsMDId/u0BeeQrM0YB8kcyDaOfP5TP9frezK8+VyBF6ENIrwU3G39oePCfPqvrrY8fDNRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5652.eurprd04.prod.outlook.com (2603:10a6:208:12b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 18 Mar
 2022 02:59:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5081.017; Fri, 18 Mar 2022
 02:59:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 7/8] selftests: bpf: add bpf_first scheduler
Date: Fri, 18 Mar 2022 10:58:09 +0800
Message-ID: <49747d1d690e8b915e5101f285b12d7b9eb236f7.1647571510.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647571510.git.geliang.tang@suse.com>
References: <cover.1647571510.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0217.apcprd06.prod.outlook.com
 (2603:1096:4:68::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 780daca2-a7e2-42ee-eee1-08da088b4649
X-MS-TrafficTypeDiagnostic: AM0PR04MB5652:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB565295D282E7FF550E7E2D12F8139@AM0PR04MB5652.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vPkyUp71XN0zuUl6y4jLBYlF87wXEocyiiLeUUDYAslrQTTMAlXDZxQzCMNhHbHXyCqyhzEyT2/WFb7PM50mTQtpirSEc8Age59u6x/fUMt1umRIX4KaCru1mVUXJ3yXgVFhn6JYXEbs/ZcoB/RMTwg43RZVxuQEl/A1qLeVtThNWcxMcGkWIXwFH9rp3kjIIIz1eYnDwluyun8hBaUimWgrk+/yUfKUs9We/InsOXVB4ePS7+ZAz7oGynxvau11vnxKwmxSKFVusQFVkR9YBk6maQ9Dtqma/Tb08/9vpd6HA1AV8CrOoqnlUkziKy5qfnAzJZ4MD5f+HWNHnZbUcKtBy8fYuGBmWsOvBDxIS0Uc087CPcbgDyZQmwxXTq4fHomx6oBYUg6msIvVYmMXPGWdVjbpmH+bSthSCj6am1tVWpoovG6g7v4SJip9fc04cbUySiybDGtlJWVEePp4nNgufC8nlFyp7jH18avg6PVZFos7f7fGs7B5hyLLNWAEcVYfuLQ3i18np8B75xGE2hzADavH2SXs34h1FkcnY+Ky/T5git+HbsSYu3nDvEZNzKsbfzQaMsCOAU354K5ZFJwVdi7ITXoo5TO6fHy/p4rohBwy8nezbA9qureAtwTQFN7v7OT8jfEMaH3wdEh9qJxVIb7rrwXIj7+9Qb715bUbqaSJVNt/haKfT1vzPhdH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(2906002)(86362001)(66946007)(316002)(8676002)(6916009)(6486002)(508600001)(6506007)(44832011)(2616005)(26005)(186003)(107886003)(6512007)(5660300002)(36756003)(8936002)(4326008)(66476007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eXbNJB4DtQunQUAX30kgIS4Unzq750KL+wawkqxg3PEE+hpzClSYp6hQCKuM?=
 =?us-ascii?Q?a5iM5pgDzH2pV/sps6tw+E4+YP2X6q4rz8r2+rT4OaY7BSBSvw/cQM7j4qy4?=
 =?us-ascii?Q?9XXKe+L4G3K8UUbI2pvLO/54TWb738ScIZJUz6dxgtY+QGMxD4MA3qs72qkB?=
 =?us-ascii?Q?/XnNgHJM4mlKH+/KLjHGyNkHwmuLsTVPo0j+G/LDf1DxyTBe5PrSk1V6nQXk?=
 =?us-ascii?Q?cdPNoRQ2HnhrmrjSPTD7ZFHGeh81jZ/DgpD7YEwO1F5tO/nGRoZouTd4WImW?=
 =?us-ascii?Q?fmvJJ9n6BVLp3TJ9lBCPaJIS9N+mKhaUT7AvmQaRY+tf5WWHTgYqE6IPrqw7?=
 =?us-ascii?Q?4rTwFOmPnf0hphO0dMeVyLEHSefppSMB4Z8jKsqAfdy8EnpeFKzwQcwBGHQ1?=
 =?us-ascii?Q?0CSrb2b2WoUO7veJMKKCnFDwYPZRHtrPTfF7F5s+/TuTcVka/E28UBIpiQ8B?=
 =?us-ascii?Q?bQh9IiSPRZyg44Tf/Gmnjf1TdYcy/SqGEKGQpSAEofH4VsjAdk7JP/moZVon?=
 =?us-ascii?Q?UbGqvmokYMmPDUijosQmAf8dlnbjeuA2V9RGz+S3T5KpsMjNEL2+1GgrqhOz?=
 =?us-ascii?Q?/BL87ujKzcpmMK5URoRKd8WGEwGuiHEgzJGh6WIjPKVNFJlStb4wxvi5Clai?=
 =?us-ascii?Q?ZM+qopOOoP/Jh9Fdc3jsIMAlTnNGVec1GuJSZSnbJStbFtzk4R2iKYgiLGvQ?=
 =?us-ascii?Q?d1wT6Rk4/Y4UiOjRCUAzl0P+m4XPHcPYgvKLPx4PIcmdlthwLl/jaNRf8jM6?=
 =?us-ascii?Q?ujJVqm9EIEHUs+4nmplrFZzJfVUtufWRYcPe20USyuvr62Wn46ZBjCShBUOb?=
 =?us-ascii?Q?sc5tXJS8fjsY0iJmgWvoZwQrNl3P7PY9iqFoSpj4Ba66BjUJGUq283+DIttB?=
 =?us-ascii?Q?8piG+wgFOi7PjLWfJFzgk0VgNwXsdlSxOOraq2VFN+EHPBaqCT8Yj5gkuaYQ?=
 =?us-ascii?Q?gtXenln6Bup8VKKw7WBXM9tCesRMWgEMfveK1XzHKsUpFnUJ+O2uy4BOYnQC?=
 =?us-ascii?Q?zUC2Ff2rQblD9Qdd3ZrrA3QxxoPIIg1kjjQ5AGySbIcpJ0cz/CieGcaYSA+3?=
 =?us-ascii?Q?1aAaTpQ4BLoYWMvpTtriRDV0QzVQHMQgMbhnwm/uesGHWfM+X2jFXu6Zo40E?=
 =?us-ascii?Q?TiAWSWYDniIADEPFllmcYwMbKkVVBee34jr12MkMXqRSkCUIRNv1MTi8GIJc?=
 =?us-ascii?Q?3eVr0i6aGSfTny3/2RybY5PnZ+RMNnGMHmQn7JLPCQsjY1XBv2h/Dj0JrsDS?=
 =?us-ascii?Q?H3/Q1qkJefgVlygTksbH6njmn1rhrGGEKbigEmz9KYBZnxT1FaThWXWzPnvh?=
 =?us-ascii?Q?BUshWeTAbQB3j5ZV309y8wrqmzlJaeA6ocdLk8cdHgtFLHIGFbdHp1pf3msX?=
 =?us-ascii?Q?UE9DelYJQX43O847LDkcaXh//F1VBIfFxFAyLtV3HdD0f0RWh9kz2B7VtqJR?=
 =?us-ascii?Q?XVkPK/2kkqI7m9/2B2T/DKjXR9DAhK79XbkYzHr1Yh8dReKap7/AIQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 780daca2-a7e2-42ee-eee1-08da088b4649
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 02:59:10.0323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZ1YzVKbDs0nz95dEPPRIbA0iR26PPSh6XESB7MreQfXDbHorFJaoqxJ+188bybI1uDLGAum4aOaOGDDIvWgBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5652

This patch implemented the simplest MPTCP scheduler, named bpf_first,
which always picks the first subflow to send data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 12 ++++++++++
 tools/testing/selftests/bpf/progs/bpf_first.c | 24 +++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_first.c

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index f92357597e63..5bb21b24231f 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -197,6 +197,18 @@ struct tcp_congestion_ops {
 	void *owner;
 };
=20
+#define MPTCP_SCHED_NAME_MAX 16
+
+struct mptcp_sched_ops {
+	char name[MPTCP_SCHED_NAME_MAX];
+
+	void (*init)(struct mptcp_sock *msk);
+	void (*release)(struct mptcp_sock *msk);
+
+	struct sock *	(*get_subflow)(struct mptcp_sock *msk);
+	void *owner;
+};
+
 #define min(a, b) ((a) < (b) ? (a) : (b))
 #define max(a, b) ((a) > (b) ? (a) : (b))
 #define min_not_zero(x, y) ({			\
diff --git a/tools/testing/selftests/bpf/progs/bpf_first.c b/tools/testing/=
selftests/bpf/progs/bpf_first.c
new file mode 100644
index 000000000000..ad6822d61741
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_first.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2022, SUSE. */
+
+#include <linux/bpf.h>
+#include "bpf_tcp_helpers.h"
+
+char _license[] SEC("license") =3D "GPL";
+
+SEC("struct_ops/mptcp_sched_first_init")
+void BPF_PROG(mptcp_sched_first_init, struct mptcp_sock *msk)
+{
+}
+
+struct sock *BPF_STRUCT_OPS(bpf_first_get_subflow, struct mptcp_sock *msk)
+{
+	return msk->first;
+}
+
+SEC(".struct_ops")
+struct mptcp_sched_ops first =3D {
+	.init 		=3D (void *)mptcp_sched_first_init,
+	.get_subflow	=3D (void *)bpf_first_get_subflow,
+	.name		=3D "bpf_first",
+};
--=20
2.34.1

