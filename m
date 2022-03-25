Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D8F23AD
	for <mptcp@lists.linux.dev>; Fri, 25 Mar 2022 10:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648203102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k5sO8uSF51RAvce2HnMhBCWduQaAMikYatKY0TPpHP4=;
	b=Gon+uU0eA4M30p41vyY3wRIxPwhwkkHNBWHEzHQPmRaM32w5BhxhErqa4zu0fTSvs0g/uO
	t58jBY18vkPAgdAlNVLdorujasTcAI9F3dtoW5ptNuoMnSVbz5B36oyoXaOlr3rsmiJA6l
	XSXKkBdGjAPC+ZXBKdbtb8H0G+r5FO8=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-vlh-XmdeNpmBIy53Gl4C4A-1; Fri, 25 Mar 2022 11:11:40 +0100
X-MC-Unique: vlh-XmdeNpmBIy53Gl4C4A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ze0TMAzeVnRpR7/kzj2NK7+UvKAj5VO5PQZueyh3IQYHm0zfa37WBxtYgEAZWB+VXInIW1Fo5gPvQ1DF9GYmtf4ZZ4Wpp+Y5PP/H5kyb5tVn2Q1ONIpwZyScxYtPIbP0JGw3CHeQZSqW0jYHCg5U/xZs1t0ENhYrG9D9HPpGISJ//ADykit4nGLrzyvMcuqlOVmymzX4+ZRbHN6fHp5R55at9p2msCLNX7qWMTRhNuAOPKCLAkDEuDV7zR9XH8v+4n+tag8Hd+kVNrVRDfjW1jGBV6ijCVO+NVha5MV/q2uiGotdmOIoxybNvpdeSgImdC1qMTKHQr2d2tgzfiNvjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6k+FlABiSKKzhP0R2JpmiSPAa2NJuDqdV6liuSLhps=;
 b=Ptdjwj/EgL/E5GQchiX9s973MLwsQNnDMZvk1H1Z97QQlN+tFWpo+RzbEyoNYsM6MT/6gzF5UwWCjtKLzStSOg3zNWtLLB1f76BcL7EERL6oikmrJYpBaHGwpAFL7JhSLODGuZjrI85/HdODDVWh0o8xa/7Dk0urWLnWHooxJWLX9fzv3lnyVrO2Vq5U8fz96BhQxucU9GN4ifZqbf/G2geDuV+Ufu3v/5zqiZjahjO97lOzf89IY7hkmE+XZEO2TlpzhDId5AwKhULv5rb+r5ksj1XG7eI09yVNToISaxKrnUFXjqL+4ery1vfyKgL5ulphXB9KkHYxc9eAXFqGtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8726.eurprd04.prod.outlook.com (2603:10a6:10:2dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 10:11:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Fri, 25 Mar 2022
 10:11:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 5/5] selftests: bpf: verify first subflow of mptcp_sock
Date: Fri, 25 Mar 2022 18:10:56 +0800
Message-ID: <29cb864996911bc7990c17f9b8501f1a3451d158.1648202310.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648202310.git.geliang.tang@suse.com>
References: <cover.1648202310.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:203:b0::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4566c58-9a29-4b6c-6689-08da0e47da8a
X-MS-TrafficTypeDiagnostic: DU2PR04MB8726:EE_
X-Microsoft-Antispam-PRVS:
	<DU2PR04MB87268BDA104660F96413DC47F81A9@DU2PR04MB8726.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YzWV0iHwrRhyTefwBkD74Z1eut+ik43SEnxot85xDCmcPI28+jYQxp/Yal/jpzO7OFz4Q3KZeBOqwNrp2u0p5KgqIWFB0e0Mp5U5vO3N6RyDhKDnbEs3ljeAG6NJUVyvd1kqBb6IfAaTSt+DVCxjYq7LouXQaoLDtV6uBBMRz48/jaTEXm6pXpBUEYd5PG9ooaEMW/ugnUpjOYZh07BLsZW5QIQsToSf6J89rb5zSz+qwNL9C23Rewcq9pV9c6F1dIWDYkiyirEco82fP9BU2X2fS/6fy/606oytUtHjBPsJmTAzspgf45VTjOqe5Wt0oTaQmZ06cofqHooiDOoNukiGrvrQYIKBwZWF1YJqi1MotSeb/8REqAe5x1LYdMtVFYkjiMMt3QP2WruymoU0ddH8M+xxNZhrcoX3oiO30BSi9SSKQa/abZuVALxs6yMUoKqMiW2tc+Ok42zH5hLxuOZ6t1Vho0ecrJfl4hFKn+N8gILg1o1eCc1pUAUiq5/LjNWDed/faxRY640kvkkgaMaSVquuFl4Bg8t1+fF7DGNE+ye5Bx+BnCNftEkxTqTj+g6v+oZhP+/QZ8MIbD2gi0isg/o6oB6qBO84WsDsMr9wfYUyprn3QvcZpGgRNZNGpVJUP8hIvHV8vOMvN5ejxG7m9A3sMFrfPmFzAbZeme2vJs+LtzSNmTTqc4402NS1KT/Z/hkJ8c811X+efhUVbw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(6506007)(6666004)(8936002)(316002)(6916009)(36756003)(66556008)(8676002)(83380400001)(186003)(2906002)(2616005)(44832011)(66476007)(38100700002)(66946007)(508600001)(4326008)(26005)(5660300002)(107886003)(15650500001)(86362001)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oasvbo26T1nMXam/kRESXrxCV1pmVZXFQWjcmAQPHaRnITtmmZUtGg7m7eKG?=
 =?us-ascii?Q?wgOvmb0ppEpvBXUZ/zkGZneFLu3l2J0dhBWooXAhKP6vey4A6Mt60j0+8iUh?=
 =?us-ascii?Q?t0toW5Ig54Dze2LC4oJgk3DlaXvm0NxdOEJ56MFSt+iCnBQHMz1YtuvQjWJM?=
 =?us-ascii?Q?AyZHpGxxj8pQgHZkYQDH7zHaJd0C7y/gvxsOMBZy3U/KTlpK7ojh2P2MLRAc?=
 =?us-ascii?Q?oQwK1UGJEEhYKXnw4URfLI5jmbf4/qYRD6aPvAEGZdIrgjaIms1XHkMYkpPS?=
 =?us-ascii?Q?KNRpS07HYfXJhhX7Bc219Qlqkj39ZoQzV/GJ0nu0hW0hAlHEY/PRjU8vavYg?=
 =?us-ascii?Q?xT6Ikee5CJkUwtdo8KEjamwHTz0X5P9g72LHUa8/imzSKRB2iVrOAb0+dvKy?=
 =?us-ascii?Q?ypquUWL7veA9pY0QmyyU2SCiaGTi+Y/kBxEw0uw0XPn8OcSXYOfh/blK56Y2?=
 =?us-ascii?Q?hj1Ywk7mGlw7lmw5iMHT6qn3K+hO+zD2CzeihHHwe/SpmOZKaiyp+WYD2RAj?=
 =?us-ascii?Q?gN5H9n5/ASjyAUhuM+KA/f75NC2svF+++0dUJKIfziMcOOjr11Z+oZvdm3er?=
 =?us-ascii?Q?9BrKwQgKecBYzldaoqWcY4bPvoApBcHC++byoNp/RTPqzg9KDz7q342jalDc?=
 =?us-ascii?Q?ufrbdU/T4wQXr3C6o1kVlgnUOHckFg8gTRle9v1PwRnjNMmoBCCFPr3gbR2N?=
 =?us-ascii?Q?jCnH+RYpQVr8cZ2kVmoSO/BPDrFMEkuN4/BEEapD8xQQte7gAPfl0G+LgXby?=
 =?us-ascii?Q?v851a90NS9wtiYvwh+1M2S0/xVSLukNRrigXhFShaEEGxDWCHuq54yz5wUUu?=
 =?us-ascii?Q?NjK2vqaNSWHJQHu/msY7hesa4+6on2CjrWa+1+/IF+T5x8YYGI6FV8ZLAzRF?=
 =?us-ascii?Q?qtd1wG0yikbU9j7LfQ9PK1PVigRQg+b9hIsF0clTwGTtVnXl6Kj8How5XA2z?=
 =?us-ascii?Q?LzUxv59y/PmIGIXnJ5xxdeRMmI6z1JVE/W3lcdMRvRpI3g3YwpjwIltY0egf?=
 =?us-ascii?Q?2DGArnCbmmoHlVlKRAo8RZOaSfTnAutb5rjYgUM18lh0JPfyL232VuZguOxH?=
 =?us-ascii?Q?C9tZdmy3j1nF1v2fzN/1ShmcHZzOlanOpWunvAmXf4H2MvSX1b+7Ec7Q6IB/?=
 =?us-ascii?Q?tQZ4ompgsydNeGbm5R6zBbaH7zFVgLDUvxBUUlw5L7ceAavTLZr5J8lLgreo?=
 =?us-ascii?Q?3M1818JzrwBaoYORyWaPltIsmMHbE7RAQL5MVPwNx7fwAtPWuztQ2+kw70V+?=
 =?us-ascii?Q?4ijXWOTgSnCotmpoOsJGuIj8GHFp1DaQuqWYDbUk5fHqBXtkpZQap8oSaG5l?=
 =?us-ascii?Q?F/Jx2Nff7immGbegvgzhNfvgS1aavXiH12VXUac9ex4PMw/YwnioEYcDmfGx?=
 =?us-ascii?Q?qa8KzbqCQBQJliLwgWoKIjeNh3uzXXJHoFRwBup+LpkqHOTBOxu1l94MA+L2?=
 =?us-ascii?Q?V2qebSWRoIM+hNwSrs7ID/OfuOnnFyjPVguKveFiXS2vrH/14wRjtZ5TqAHf?=
 =?us-ascii?Q?Z4XcjgtmgIfKl+0kVRAhkpn9q/NGwwh0MPM68vdwzBFjZYzEjHULVXZFB6FK?=
 =?us-ascii?Q?pHMDtkaFHN5fLPAksP5e9tmYVg9fM0w04SER9xuiBO6/rYeRh775mpH8QMHH?=
 =?us-ascii?Q?0KEmfSLeSY//1nCCSsVMLfwn+izInDLRwpNYLpZmrJNkhu6iTujMW7Zhc9lL?=
 =?us-ascii?Q?i1QB9bSld+RZFI0bWN4oJPmPjdL1jQKivLBS/8RdPdIPwFtc98KbTTTSFbAq?=
 =?us-ascii?Q?4qzgeWK3VPo+dKWMCf5+hFCZvyXOo5U=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4566c58-9a29-4b6c-6689-08da0e47da8a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 10:11:39.9566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gxys1z5MPWMAiCFUeXW8n2jhoEBfT7HSECg93k9UBLN7F0NZeQoTFpbiL8KkG4M22a2cvrwhhk4CWsH+YzbEgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8726

This patch verified the 'first' struct member of struct mptcp_sock, which
pointed to the first subflow of msk. Saved 'sk' in mptcp_storage, and
verified it with 'first' in verify_msk().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h  | 1 +
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 8 ++++++++
 tools/testing/selftests/bpf/progs/mptcp.c      | 5 +++++
 3 files changed, 14 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index bebe382bcc7a..f92357597e63 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -91,6 +91,7 @@ struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
 	__u32		token;
+	struct sock	*first;
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index ea8dfcdb230e..888d9e9b8870 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -12,7 +12,9 @@
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	struct sock *sk;
 	__u32 token;
+	struct sock *first;
 	char ca_name[TCP_CA_NAME_MAX];
 };
=20
@@ -133,6 +135,12 @@ static int verify_msk(int map_fd, int client_fd)
 		err++;
 	}
=20
+	if (val.first !=3D val.sk) {
+		log_err("Unexpected mptcp_sock.first %p !=3D %p",
+			val.first, val.sk);
+		err++;
+	}
+
 	if (strncmp(val.ca_name, ca_name, TCP_CA_NAME_MAX)) {
 		log_err("Unexpected mptcp_sock.ca_name %s !=3D %s",
 			val.ca_name, ca_name);
diff --git a/tools/testing/selftests/bpf/progs/mptcp.c b/tools/testing/self=
tests/bpf/progs/mptcp.c
index 6e7d2abf6ce3..16055f553f29 100644
--- a/tools/testing/selftests/bpf/progs/mptcp.c
+++ b/tools/testing/selftests/bpf/progs/mptcp.c
@@ -12,7 +12,9 @@ __u32 _version SEC("version") =3D 1;
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	struct sock *sk;
 	__u32 token;
+	struct sock *first;
 	char ca_name[TCP_CA_NAME_MAX];
 };
=20
@@ -51,6 +53,7 @@ int _sockops(struct bpf_sock_ops *ctx)
=20
 		storage->token =3D 0;
 		bzero(storage->ca_name, TCP_CA_NAME_MAX);
+		storage->first =3D NULL;
 	} else {
 		msk =3D bpf_skc_to_mptcp_sock(sk);
 		if (!msk)
@@ -63,9 +66,11 @@ int _sockops(struct bpf_sock_ops *ctx)
=20
 		storage->token =3D msk->token;
 		memcpy(storage->ca_name, msk->ca_name, TCP_CA_NAME_MAX);
+		storage->first =3D msk->first;
 	}
 	storage->invoked++;
 	storage->is_mptcp =3D tcp_sk->is_mptcp;
+	storage->sk =3D (struct sock *)sk;
=20
 	return 1;
 }
--=20
2.34.1

