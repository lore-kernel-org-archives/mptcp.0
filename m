Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFCC28F3
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 12:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652271503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IHj5/kdOTrVpOR0BXpBCCrRj/JAcMQFspS66lZdojSQ=;
	b=cFBTtRLv8H2IEIQYewnhURApbm2+8/ZSiyRgklrCyr7Nlkfjj2rrQdCkbgNW/+RtUWAes7
	BDJtGztNx4h3/kWuhaDyEmb4NKP9vmfQFKPj/10Apa2Q1lf8nX5Tp91gi5/VeAPLYpXdt0
	mDP8iWbNNEt6fufSlFhl+rwE523+WjU=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2172.outbound.protection.outlook.com [104.47.17.172]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-24-77vRF8QnNUm9vFWz4tawGQ-1; Wed, 11 May 2022 14:18:22 +0200
X-MC-Unique: 77vRF8QnNUm9vFWz4tawGQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SF0vbbLrEYtt5ySlZUTTvo0O9pelwOukKxhXMmHqCYD6ecmVlg98N029HQJ/fkMoo8dZdDqpvFp0Ulo0nzyGrqloQ+K1/BzoYC1Fqx0lumPoTSggIKRlejVrWDwV/X/nvwhA2Vme59s6XKG3Aosbvr3iH5z2NZ9fLxDKkYra/559hz7J3stuBXTboLqOr8TgjUnmmN05QdSj9KlTsP66p/RoQLywenRS06bBIqsStwA+vh+sfrCZTL8sP8VCamwo2huOV5mLWwRaM9r/5InqhILPPXqeD3efTnadh4hLRdehLVEIn9uqHsQ0XchqJbuVHbvgWwb8lnTQKCMVE6FNnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOihhAklSno9eNJ3F+UDdesgolVQUEFBKrOTaQFuRJU=;
 b=f0Zt2zKaG06owODbUWPMKKlYcbXPLKwS4EUGjRT0V2mxYI5vCZ8RdWk7PVQP17whDgKqNFJgoJDLjt/+8Rcvn58CGL7ffDNCL2XoOZBLTOR8kQ9maAgTzuAXSRe2a7ShibiSxsJ7YXtkrewqDJvT6UmuVGUmOlc6hbDAZKSFbGRESxqWO4SaR5ubp9IT2hW3+k98KORheW4aZUvUvXdNrLUeOgSk61hN+xMeJIzFReW2cuCvP8Ta+653iLUKOsnfsNV+MiY9r/HOPH+bMK/FyM4WpkewkkyvDb/um3DIG9AFGqMQOY1sC2Ygpp35CqUa9YDk6v/RL0Oyiu93aEtH1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by PAXPR04MB9075.eurprd04.prod.outlook.com (2603:10a6:102:229::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 11 May
 2022 12:18:21 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 12:18:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 5/5] selftests/bpf: add bpf_red test
Date: Wed, 11 May 2022 20:17:45 +0800
Message-ID: <98009f8c10d2a46ada81b7edbbe99faeadda1e0b.1652271034.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652271034.git.geliang.tang@suse.com>
References: <cover.1652271034.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7c5fdb1-b6b7-47fc-01ca-08da3348533f
X-MS-TrafficTypeDiagnostic: PAXPR04MB9075:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB9075431A18547F9501A8703DF8C89@PAXPR04MB9075.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Wyjze0XdrSRO1Oia6qmQ7r8qiz+KPWd5pMbc9VKpruGaYLBtl+XFzlea8u9Nlq9fLCVzBParO/KHIP23kMV1BiELxGUCr3T0L8Y0ZmQN5z6KdK/mysbYwXyBBRgnhBrhPCmn9V3YV0vrE5/4AJbKe4romLx3v5K+HorWgbeDlXszyT1YN2D2fyBxIw1UaADTOOiQ7lz/0b1ARmvatjeLvXcrj5c1ftKTN3CHAmnnxEjXXxfDUhEW60M3D7aezRhNiBFK8R3zCRWkY++K229Kftiiz5Dju0IUaYpnP1zNNUs3ENK1sxw0aISsAP7uTsttwe55I8R6cwT+QKVIKovnV4h+c2J9t/8bkAWUn7RDxHPLwl9DeHhVQ9sDfw5Xr94U4/85rYqakItGhq+NZpULDI8Dtlmr8/X1ORy4LTIhSbclWEafQ1o27JS1xGS8mMglLvaser31mVY0OiEynaMVE2lKY3nS66oWqZ0r1N06t0ziW+bzXOLlmCkGZ+p/1NmPGsiibM8DxcJwtp1uBjKVt7dnThldOxIfnIHeJqA6WlX0vK2aeX6ke3WqfF2lrzL8Yt4+D3+zKjK2wzxeI+AURMVz+4ongA0d+j+7Zh6lzQOM4W2FXlBif98oEF3KMk+YwVdXOu4zdRPewrqVYGrrDgQWNFTk0tZXfWBE7YmgokruI+TPMY/BGIDBfgQInaJy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(6512007)(66556008)(8676002)(26005)(66476007)(2616005)(6916009)(6486002)(6666004)(316002)(107886003)(6506007)(86362001)(83380400001)(508600001)(186003)(38100700002)(36756003)(4326008)(2906002)(44832011)(8936002)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vO04F0RAAxw5V4QuhPvF0wCEJ9j817UhPdlsUWTUXFNaTJusMCQapLf7q1Br?=
 =?us-ascii?Q?OsB7CuqEiJZ5W7bGx6DUZYWbTUBMqPMnxf8OdOACBE+n0gJjotk1Tult0c3z?=
 =?us-ascii?Q?qxcG98Ce1Ea9VrdwQ1Pnq1/xnp/gRw62rX1WsS3T8RFhVH/W94OY/PoHvjS/?=
 =?us-ascii?Q?XBpVfqT6cUfOVFX0eGe1KxqrTo8a2CCw+mHdnDw1xyr6RE4zZmmsWOIj7dbF?=
 =?us-ascii?Q?6qb75EFYauBHKFeRRBJMXna7vte8kDNEx9TY4sJyjKU8P7nT2mvXR0ULxy7k?=
 =?us-ascii?Q?rYkrvtgUEvDoVk4u2nPJgsx0/ZxLhWIg37IY3LSajI2g3eyl66WvkToWP676?=
 =?us-ascii?Q?mrxJk4Jf7CC8qO/LiRJd4UxjdRtRADvPoBx75SWIObY41Exx+ceh761l1ueA?=
 =?us-ascii?Q?mf8YLCQF7aPQ6vT6YTf6eQIpf5e/5kefhSfiI/hZzFmMsWk61SPiD+dz3Hr9?=
 =?us-ascii?Q?SlgT4eoUfA2szdGqsVdh+gqcCZBaH7lZvk0g8jffNbDq41ge9ARg9z5tf2Fs?=
 =?us-ascii?Q?eYasuU7XyaLc5F5I4ZFAWk+XMx6CxQcAWPup0UuYSAVPtrfvDVQ0Ihaz4dXC?=
 =?us-ascii?Q?as83zbYaYI2/HhkLm0+UokvTkRvGpyMZBSOO21RMLJTbwioB+Iv/iQxzoCvU?=
 =?us-ascii?Q?zSEN8Tez3fpFyOSqtZUsZGEW6APzaAojurFvTHQ6hBNqObSqKwtmb+jSN5z9?=
 =?us-ascii?Q?9FEgjA0jDwt46zsWIvwYewYpSzQESW283uF/sUBgItgRceNe6ucj8V1eh5Rq?=
 =?us-ascii?Q?LB15zPHjY+lkhYDOW5KDS3NQRnotiJuyGol9aJgmU+Cq0jPUoMf27EHGoXcm?=
 =?us-ascii?Q?qTRzJaOJBv/m+ZtVJ0uVMDDjg6UPQvA4rrQLLcfCQ0xC3f9Oha66bD+l8SMi?=
 =?us-ascii?Q?XjrmO7jJTNgfIrkzrMvM9vC7H7IoxKmXOAnBhJUi2EeeXiYhmMxCOaxsxS4k?=
 =?us-ascii?Q?7vCpBng6HeL4Gyw8dDFiPCFUI5+E5Q0x+wD92I0nlNgmK2rR11k4WNaH2xs2?=
 =?us-ascii?Q?ggKEgHXhFHVaj8cQIGrOueJZIPS/FaIHnuE9tnNgD22UcXhJbqjL4QksQEig?=
 =?us-ascii?Q?KofL2f9BbbjMXsHW5Zu+V+xyTbkxqeN3wCPPsG5rFBv4p+4Cvjmh9m8XcUSG?=
 =?us-ascii?Q?ocoiaSUZxfBLHB9j+EIVIEc4+4mWU5DW8ngeWlnjOIYbamfSviPjcRqe3PCX?=
 =?us-ascii?Q?oC1bprZKOG1Hqrbu5q33kRAgWMcUalOl+ql4Se0qeQONCEGWqocqqS/+KUp7?=
 =?us-ascii?Q?rtroEQ4KSkXi4mfOOtwGfx3vCjMtOPyACXpwvzvPTmHpR9VoVLdUgFRNxRQ4?=
 =?us-ascii?Q?GlkLSGDZ4BwRCiPJ244Ej4dSBt77PoWFBqKidmWwD6bZoMB9kQ74Be/s/Tvj?=
 =?us-ascii?Q?QGXYJ0i4bb2u29hAGkZQq7mp/Dvvi70WuGQ1X6AYEALuYDJQJqOncPYQNqy4?=
 =?us-ascii?Q?s2lhYEHKs2uqm25g/pp0lb/SSjMCKaowwj5ZDLVJFeBen40qqefgmhVVhOeV?=
 =?us-ascii?Q?WY4oaIrPetPh77hweQLWunVUK7WjUWKmycGsgz3EWTV6FUXthJbLLdGDzVXF?=
 =?us-ascii?Q?cB2Gso7Jjk0bS32f9VyybkWFNdzw+eo5cHmPZSuJTxGob9pTjhVxYI5Y8VEU?=
 =?us-ascii?Q?1FRWDeYuXQ7+JT6K9J84L0W4nO5SK+tB+z7vdRyzYtW3yojKO814UNkbq1KE?=
 =?us-ascii?Q?Ix2kb4Yth7A2ITcmFNdOq82f9qNJse/c9hGWNdMV2CQv61B7vaOcoHOq8F7v?=
 =?us-ascii?Q?VNnxHNnpkkzmDGlJBpMkEQNmCx5UiCg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c5fdb1-b6b7-47fc-01ca-08da3348533f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 12:18:15.7865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4Lt1aHHNWg80V0USmBFyMIzL8PGSpqTErD9GOGrwi6iu3K3u342vVJI5P96PnKRrfKCOH0QKSleCO5bsiaF3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9075

This patch adds the redundant BPF MPTCP scheduler test. Use sysctl to
set net.mptcp.scheduler to use this sched.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 6303eba67fab..58300a30f218 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -7,6 +7,7 @@
 #include "network_helpers.h"
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_rr.skel.h"
+#include "mptcp_bpf_red.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -405,6 +406,41 @@ static void test_rr(void)
 	mptcp_bpf_rr__destroy(rr_skel);
 }
=20
+static void test_red(void)
+{
+	struct mptcp_bpf_red *red_skel;
+	int server_fd, client_fd;
+	struct bpf_link *link;
+
+	red_skel =3D mptcp_bpf_red__open_and_load();
+	if (!ASSERT_OK_PTR(red_skel, "bpf_red__open_and_load"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(red_skel->maps.red);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_red__destroy(red_skel);
+		return;
+	}
+
+	system("ip link add veth1 type veth");
+	system("ip addr add 10.0.1.1/24 dev veth1");
+	system("ip link set veth1 up");
+	system("ip mptcp endpoint add 10.0.1.1 subflow");
+	system("sysctl -qw net.mptcp.scheduler=3Dbpf_red");
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	client_fd =3D connect_to_mptcp_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+
+	close(client_fd);
+	close(server_fd);
+	system("sysctl -qw net.mptcp.scheduler=3Ddefault");
+	system("ip mptcp endpoint flush");
+	system("ip link del veth1");
+	bpf_link__destroy(link);
+	mptcp_bpf_red__destroy(red_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -413,4 +449,6 @@ void test_mptcp(void)
 		test_first();
 	if (test__start_subtest("rr"))
 		test_rr();
+	if (test__start_subtest("red"))
+		test_red();
 }
--=20
2.34.1

