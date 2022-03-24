Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AB01FC0
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 14:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648131009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kIlkckohIQVaAgcW9wBbEZ+XGTzfe149wUCBN/RfOmM=;
	b=d0s3fZVgVszjwi9lnF7gOvotaAqB9ctlJdL4b39FJeGlAucdhqmWgIxdb/2IuIZkdv/VU8
	OvKpwge2OYrUSXYSwHgc6Tty/IFBEj9PjKkmY1mhCrl0SZEHMEUI6UKtSliX1o6Ge/t+hv
	RYkZi/DKsPQSrcrLJ+jtP8qAFi9zBgA=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2108.outbound.protection.outlook.com [104.47.18.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-Lv4ZFUTbMZmrXNZhDo6zGw-1; Thu, 24 Mar 2022 15:10:07 +0100
X-MC-Unique: Lv4ZFUTbMZmrXNZhDo6zGw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWqgQAdAsyS6nGeiAxyL8kW5Wz9rbg8Kff1g4UWDkQCQbC1SPuYY6SxPSOjjzt80ntj1iKp7cvvDqGosVcKGwjk3qCZnPl9KMfwSO3CkTIM9IFO4Gzq62TH0CnePQowAbm2K0S+D/gjJJU2tk6n6wIZlxQgg1jEnLhwUVPXpkB/37JAsqFrPHcENJFUXspHQhc8QiSSuRlWhMqVdCCAInGS8mKxuDa6bQc0RTq3Kq/S/pndekkalvoZubRmKcG1HbMzfn5l5s5AWPPTi9oiPQemcjZP9A9On+K95DBXxLx+aeCtfgXTx59flGpcehEUb8mScFfG3tisQUG9DuZj4VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZomRA7DTzVzrD8uVEMdeP/gn3/Ct6sAiET41uPioC3w=;
 b=F1DtiXTLDIcRnAboIFiyWTGgts9mxL/3GwwKNSeKT6rXUQixt6eP8RcqlQVb/n/nB5t2mPhPJVBzCfeC3Hm7P65sETGcSMFND6TdmefkrEMCLNia07Y+hy3H/7X+0xeNje5H/5OsjrLJzvR0NZoBkvlkMq8rmEMZwA0Zrbgrr/W+LEcYnKmy+M+QedxPTEiBzdK03mn5KRb0W49nAxqtYiOGokxX3SfvlMCDoyCmfBPIl/VAmVTRNsGNixQ7+vktRg8ok7eR+kDHpfpw0UQWwHF3l9/s9hgpDriG5ITRZoYevWFIWHDGT8+oCxit18SFVHvD910bz4MDd3+/CQn6mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB7PR04MB5275.eurprd04.prod.outlook.com (2603:10a6:10:24::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Thu, 24 Mar
 2022 14:10:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 14:10:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v5 8/8] selftests: bpf: add bpf_first test
Date: Thu, 24 Mar 2022 22:09:10 +0800
Message-ID: <9464e044c6dd9ed89b537efe254f3bb96deec658.1648130637.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648130637.git.geliang.tang@suse.com>
References: <cover.1648130637.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0206.apcprd02.prod.outlook.com
 (2603:1096:201:20::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95c760a5-5e26-44ed-1aba-08da0d9fff4b
X-MS-TrafficTypeDiagnostic: DB7PR04MB5275:EE_
X-Microsoft-Antispam-PRVS:
	<DB7PR04MB5275832AAD83C0A806E41FDFF8199@DB7PR04MB5275.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V1ZZjRakC1UKGlaBfm2AdM1sOIBCGksfOBzTEZdWy31jPjtlmSpa8iY8QQYSWeFm6/e1T7Ygh/gEG0tLdOTUMa9CUacZ2PC/r8elPWUT0W26pqtFP2rzJWwGa3pJXDws+rltBWhveIN/3QHAdZbH6V3ACQpe7g1phiLBk7uUytrP8Gs+ZmjJ5aLMSY0SSQJHUSO3xx359cOpH1gBm0O1GkJTpyeCGEPMTxm4HEaHFVdtL4JLYxsNLCF5/gHKDDzdd7KgzIeKPCs8YFGYMZFNMz+lwWy1T9xSj0EcbxgMbW1bYuzAGtdBfXQNlNld8gjHryzbEc8buW9/Z0UMnX5aaivyfOvwDBvqx7i/9OyZWDm6NLni5CWmjp7BQcJVvyUSwkhFndsNBNERbMAxnLCqgAUBzs95hWItZ+ASysFy24V52Rj3ME2+VqLrUe9BHjLPwT+Pf8odI79Ur8voNGTo30BXrRNxu4kNd+D3vsXR7dCpn+8vIutYfHaIwEc1Ct5G0PLh6sY+2zztWWuaMEJuCAKD4RGkjOl/xxlKN1COhTZQglSrYf4DAge8cCMU/q+aMUI/WhlilZPiWu12STBUWJs/DoEsNEzfGxU/aNtiZmxHX8ucR2Dt02aUaRi76AVPCTZ7vtV6g7h4yMcMNuTcB9o3VUT2unZi29vSdS7NrTl9BnzT/WgZrFa7dfxkAUh5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(4326008)(66946007)(66476007)(66556008)(8676002)(38100700002)(8936002)(5660300002)(316002)(86362001)(2616005)(107886003)(36756003)(508600001)(6512007)(6486002)(83380400001)(6666004)(26005)(2906002)(186003)(44832011)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j3cXqgSBXnPsxW4evmlFrNBl2X9ASc68Ao8p1G7d59hZ+2SaJi6Xpix10YUH?=
 =?us-ascii?Q?xASkHAZDNE5n1kzWs8Zr/wEw16wz7ujQGXz/6g1Y5JvC49WRzfP6L70wIvH4?=
 =?us-ascii?Q?mX/TgiWDw8KQ/xL1Fsjp9hLNpkgxfxoPIQQdzqVFxzcb0qeqVciYc4XNm/I4?=
 =?us-ascii?Q?7sLhDkoD13hrdMCNt160tOSZdA2Zp/n3z57ASHEo+NvwlZjUqUnJ2Akasy30?=
 =?us-ascii?Q?GAsJmaZozg9LQMnUL2ZfTyk2h9XZCkHYgxoRb8bQJL/go6KfPuKFpNrQaaZ9?=
 =?us-ascii?Q?Gt6IL67zlegz2TA52FyRICaw2JAVu3qsk3R54QeLigxY7xcQuEVw5nyKlUFK?=
 =?us-ascii?Q?OGiPx+c77uWQUvPEW+LuO63oIlhJjmlVNiySfu77l5pxb0wZSICOCOZAiANJ?=
 =?us-ascii?Q?r1rdtYQDaoj0kvS7vsD3AnJQ1jRS36De3WZVgxV8nNd0CJwcqz26n7H49/+5?=
 =?us-ascii?Q?iyj3czG7CwkUSddrlelTkLI09kxZG9r62hHjAqO8C1yGUKV5LOxuhHuqHCr6?=
 =?us-ascii?Q?JY7qrt34YT4r+D5YrP6tjdDcpRkMkzEdd/AoJ+gKXrQPyLstVM3Rts3DQnuE?=
 =?us-ascii?Q?fXxWLL9MusbIMLT/UFlqSPKTGYgS7/fHfgxgP4/5liSOTP+cjZNxyq+YAQiC?=
 =?us-ascii?Q?bq6JGHICRgNE4hgWiQ0j3Oj2QfFN2O7AywsCGd+FGzsHn3F+eTmprBbGZlXJ?=
 =?us-ascii?Q?7k0bRxlmfrarMl4xpHGyP6/HTJNJTbe9AvbVt1vjOINO+VmVeT56ViVw/fI8?=
 =?us-ascii?Q?DvUeOAf9YIyAohkxiSK2Qnye94EDYqvBiOtjMH2HcS6X0QNWML0Icd0L9Ecs?=
 =?us-ascii?Q?FeiQ3p9XQkmBut/+i8HdfpwjD2duSEbyLaNC1tXi4tmftt8DPHh4bxffDZpO?=
 =?us-ascii?Q?QBkT5/WwBdf3EJBcLkdujEpJVnUeFRcxxOsLzLt4SDgvmumc0ChijgZ6BM7b?=
 =?us-ascii?Q?XWad3MbEho03O0vwx41vPRWqY1zkQzvpUjmKkDizv3LHuB1i85YBnIEglStg?=
 =?us-ascii?Q?pruLW+9iKD6qLsvS/LkKX2BGEsTHZRKVqSiBUJ0i1iC0flALTy+VuqAJjotg?=
 =?us-ascii?Q?cVyOaZKbjlohuhB7rwX5HGZ/Gja2gju71/AeWOn5DRYlUsMAOvtyEryZ+VGB?=
 =?us-ascii?Q?3DxDBiu1N4pxfrjhBrbL5P5xefD7kzOK9GixLGHo2W8/gwUe7nte+4oLP8xe?=
 =?us-ascii?Q?i1VejpEngiUxgv3OpWLpJfRXRbixem2sFXI0Aa3RYn+n/3OyDYxF/SbC+ne9?=
 =?us-ascii?Q?XTFbPfJyr9zbMTN9mpbGUdoM5cxyvpwNjsFVfaaCkqFhZf3LNeIEdQ3m4mHw?=
 =?us-ascii?Q?KauI4OPSVS9/2Tet0eBHUf/jP8b3QFgqYa9y2KdeU5lfUit2eEqTI5fjbGRw?=
 =?us-ascii?Q?WPJHr9WHywUg2wGmWeLtwfaOjWqzRWNgUMW6QT/Yf0ZeQPbvJGDaq6QUD+cu?=
 =?us-ascii?Q?8EfbjAaKmo5FuYshw1nly92esob728gUcxTC2UsOweZ7P+ubUU6NuA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c760a5-5e26-44ed-1aba-08da0d9fff4b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 14:10:06.3544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6yeZ45GaNxzmG4YJq8tRCP/EBRYOklB5s8zi2ONah5YCYFWD84VRRpHjNT/0OyL29V0VunjzO+QO2BQ4VohSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5275

This patch expended the MPTCP test base to support MPTCP packet
scheduler tests. Add the bpf_first MPTCP sched test in it. Use
sysctl to set net.mptcp.scheduler to use this sched.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index b7c230c4efef..151350202fa6 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -4,6 +4,7 @@
 #include <test_progs.h>
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
+#include "bpf_first.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -19,6 +20,15 @@ struct mptcp_storage {
 };
=20
 static char monitor_log_path[64];
+static int duration;
+
+static void send_byte(int fd)
+{
+	char b =3D 0x55;
+
+	if (CHECK_FAIL(write(fd, &b, sizeof(b)) !=3D 1))
+		perror("Failed to send single byte");
+}
=20
 static int verify_tsk(int map_fd, int client_fd)
 {
@@ -202,6 +212,8 @@ static int run_test(int cgroup_fd, int server_fd, bool =
is_mptcp)
 		goto close_client_fd;
 	}
=20
+	send_byte(client_fd);
+
 	err +=3D is_mptcp ? verify_msk(map_fd, client_fd) :
 			  verify_tsk(map_fd, client_fd);
=20
@@ -254,8 +266,38 @@ void test_base(void)
 	close(cgroup_fd);
 }
=20
+static void test_first(void)
+{
+	struct bpf_first *first_skel;
+	int server_fd, client_fd;
+	struct bpf_link *link;
+
+	first_skel =3D bpf_first__open_and_load();
+	if (CHECK(!first_skel, "bpf_first__open_and_load", "failed\n"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(first_skel->maps.first);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		bpf_first__destroy(first_skel);
+		return;
+	}
+
+	system("sysctl -q net.mptcp.scheduler=3Dbpf_first");
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	client_fd =3D connect_to_mptcp_fd(server_fd, 0);
+
+	send_byte(client_fd);
+
+	close(client_fd);
+	close(server_fd);
+	bpf_link__destroy(link);
+	bpf_first__destroy(first_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
 		test_base();
+	if (test__start_subtest("first"))
+		test_first();
 }
--=20
2.34.1

