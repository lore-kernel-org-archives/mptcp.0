Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7C936D
	for <mptcp@lists.linux.dev>; Thu,  5 May 2022 04:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651724849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w1a8T5yipnbnlwToWpoyBHWjN2RYY+E9OHoflZ37M8c=;
	b=kciipyj6m2vNodWhY6wV0lf2lcvUDh3RyFManU4bUa1IMIzTdqyRjJMdAu+jD8cFiuSkLK
	LqbOhz8rnPM9jXzTf45VpwJkBVxsts6O6u9gfS8cmEFQY91RYVfW9S033BARwjxmbegffV
	UqWywPNHRgbkaAFFnOhor4+toFUvUC0=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-i6EWWlVcPySbFxeHyA-fOQ-2; Thu, 05 May 2022 06:27:28 +0200
X-MC-Unique: i6EWWlVcPySbFxeHyA-fOQ-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnYZ/VyFDTeg1gFE+3o9dqG68MhoPKebmogcGUr/7xjtU+eEJvcytcmOjW7y85/fbpTs1Gq1XYuucwmn/Hm8s3UlIwSMqDZVbGpM1LQWHTWYUL5CEC2byIRBb55N+4pdOfis5WTGOFRAEGVUSLhIMC0vsf4oF9MGRb+llnHGjObWfxr0DuywRzmAB1nNHq/B/hSLaUY1SKZpk4OlMc73THWBitG5Fvsn4Ea7AsWGxzXI12qzC6uFJsclg21UI5WWgRZxDTmDewD0QgxGU5Q6uyqkHVpLDRR0TxbbgcLZfJ8ziBFuQJ+xZ+uLO3c4SVeD3hlvj/iqFMgDasHE9L6FIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s96QDLX7cy+vmpFvcCA1TxEbfDGF8m2PZDmJ+Or4Kzs=;
 b=OvNhkhH5YXWHtGL0HvPCu1mBqajToh6PiQmx4SkesW41RPOcoUtchx7kFv/7tS4eIf6VdPJgtVB4xQawkintXgR3pM2gn0P9qJzqX4xyzS58F/CQ4vxBY1lge3sLFf6VW4VLLHi6TUAvuIg86QxSDBPikXBwasLRqlkmhbOEoPY65RIc21UlJSHjll66VT5dx0fhrs+dWter8SknEEZgTEe2QNR0i1YL9xJsL4m1fdzCJ0UAwrUFIcMIY/d8W2K2a2HxR6Fm5wJvsu3qiz8jTFzWVtVB/Dtun13+FZjOjH2N4yeCA3KVv8KM5Z03fHszxI23LjHF1McJfztiimpx+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7861.eurprd04.prod.outlook.com (2603:10a6:20b:2a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 04:27:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 04:27:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 3/3] selftests: bpf: add bpf_rr test
Date: Thu,  5 May 2022 12:26:59 +0800
Message-ID: <89c1a1cb213959a3a59fb7ddffab8b043ab5f3ca.1651724418.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651724418.git.geliang.tang@suse.com>
References: <cover.1651724418.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0178.apcprd02.prod.outlook.com
 (2603:1096:201:21::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a6ab871-0b56-4b83-b45a-08da2e4f8f62
X-MS-TrafficTypeDiagnostic: AS8PR04MB7861:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB7861606AA0A724F40B761C70F8C29@AS8PR04MB7861.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XqobN+iqcskjEz4G1Wt7MhjjVyZu+zMEG+aT6rfnRvXwzuumru5EmGSI5cC788QL4vr88bwidAjopDdrtIvfZq42olGg2TqoeIEGqLH550Imy8UPgMFrT5ypvFczeJZjjOMIdYmm7Omk1hSOQD2PZj4DsTouXMDPzSTmY/n5/4/15MYZee+JNMTWYe+PUyPUzCe2RDSYPBBcdXvEIGslQlspPLoofDzgae+c6zR3HdInOChskgoCS4wwoddx+Z/uEvEE5jCSfMd7FUA5aaqimcnG0AYqLjzU77PHfhdBQ6KkJM4KA2Dx4CML2JSwLzcHuD75RFDh0ixeuUMP46K3TbRvsh7PybTYD/uqdwPY6u69uILP4wBMBv44pl9kxemGG+PsUbYVKvvFfLGeP7Loc09lcKO9kAgTJNika5kaPRyF3tTI5sibvCEJV/dNOcv+tUENVlfi+nDuIDJ+78OQ0n9uzpD/Ylj4OqFY0iY9uoH+tEiYWnqgqVlqBhSdRiX6uT4hbBpHVyxN6O8KxV1RPcASAjnkgWm+kGhAPuqpRw7Vd/im47HbtlN9Q5D+KbkT2Ehq5Zf/mVjOmaLYvp4lwevi7z+n/1MiaMvkOntVhNbXL8srCN2WzgrhUPasDyZB19icTj7d3rijEg3yhrpPhA9pvAdSEvIB4mzGgj9Z3q3QGXeVk04AQsV8B2S/vS/3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(6512007)(6506007)(26005)(86362001)(508600001)(38100700002)(8936002)(6486002)(36756003)(6666004)(44832011)(5660300002)(4326008)(83380400001)(66946007)(66556008)(66476007)(107886003)(8676002)(316002)(186003)(6916009)(2616005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IY97kOso+6ACWOIP14swz7PfxUyMZ4quA1xG4Tc9aG1YhBBS4SU/7COvnx06?=
 =?us-ascii?Q?8wTAQhwSlV0cfoV86wD0CtXksaqyYIToSOPF47PIt7ht42AlpYSY4RPo1+0i?=
 =?us-ascii?Q?am4HyS7pXAzCyAe2WR1xhpNtlGQmohLLKtdNAOH02eb9LYY8tsTxSLRocrp3?=
 =?us-ascii?Q?u0rFE0poMRZg5X7wfTD/2ZVhfkU+awGpPZ3mhuTCLrnYuR/YVgoMamJb8mdS?=
 =?us-ascii?Q?fO3RTcppg6ugPNHXz+vK1mwyoBHeezjWFC5HW+W4SXKANHaD7mIEo/XURbEQ?=
 =?us-ascii?Q?6ek+X0cocnkfYM/yrSoIbV2VxyXvsdEQ4kpAJiyNxvNx45HxJq4r8Y3m97QR?=
 =?us-ascii?Q?R6DUs+6psemL/9wwoFLRZ0A2Ggq8pCH8e/YMjSCcmS7AmOxXLq9RyeZw87Js?=
 =?us-ascii?Q?9CY7w8OSlNt0Xj0BuczxJk6qyAhrvxFedVeH6/y6dNST4N9W6bKyQ1U/A847?=
 =?us-ascii?Q?+JTgwzbYbg8fbKKj8I8XA/0xkT1ADBEqyBG0SMkkFy0T534V/F1oyBsREixS?=
 =?us-ascii?Q?CIVUK3IVRIY3VfRzJoxrREMdrNLMKYkVcFgRN6u4ByKwSVZuPfwIU8s4seBC?=
 =?us-ascii?Q?5xpYhL7W2FbqLqTpHjXoyl+UfUplkM+KdSqBTn+ER4yT5Zmw0gcbp0f0iNtK?=
 =?us-ascii?Q?CJ9c9B6vabXKo8CEJWbqHyFNAb3Dm7e4yGdKc7PbBjvrEPtzMW20jcWyHv2e?=
 =?us-ascii?Q?dENQswd3P/xG3dGFlXsuGQu/EtYq+qDAtxyh+k/Pqu8kUbS6GDVMlV4NMwUb?=
 =?us-ascii?Q?tyBdoaeGiNAfk3KEp9ySkyp7XVbYilIRkclrdVm3MEPg8h45GhKZEUZmVK3s?=
 =?us-ascii?Q?mhLe6GoYj+7KJsV0p67VHVkctm9KMJlcUm1vhSFQj14bBJvra3xHenG/xdY5?=
 =?us-ascii?Q?ph5ShqbBLlzyw8gQNYQGhS3ZcqcYB+PQlQGF31Cosgs2+CRRdRXVtDm+BJXg?=
 =?us-ascii?Q?KGHrLdc9H2eXbb9sEy2dlFxcFCYdcNHgNJURE8CSRoWG+VOWFPHW2z3RJ8c3?=
 =?us-ascii?Q?mfUiK+UyUGkXoS1+c8dPp0aZwHeFu2U0OX6Li7/kkBa7I8AIQobnX0J0J4PE?=
 =?us-ascii?Q?ITtseMSkkyVRuVIpzLigi01acdBwwn63Q/qoX35u34THuDoa4t5fQdu69RsJ?=
 =?us-ascii?Q?fErcU1BT22spWEME0sRMkYRXrMnmPcCMMDPBoV0hCai4l0K/F6nki8bz9CF2?=
 =?us-ascii?Q?E8oETTXbJw1EtK0zyI9jCN/S/j67JiqOpxrPIaXiYjunveRe1tKKbwVUuSN9?=
 =?us-ascii?Q?zyVXjKuMg9y6JSoxMSwfizpm/EJY4Q8aE4qJym+P+0q+40NFWwGTWwr3GfgB?=
 =?us-ascii?Q?wL7aPj9D/0nEXk7Xz8afmYMK6sbli1U5NzLS+N5LLYf9Y7ABUjtoun19sm+S?=
 =?us-ascii?Q?C7FaOXr/OvPVsGwzo0YEebktIHUMqZvHG+Pr9C0vB5M3VVXlj5LMxMFrhGrm?=
 =?us-ascii?Q?FnLXImLvSZKroZUyslAKT0Vab1Ws4ndK1ojT7+4xVANEJDVPNS+9947w2RSO?=
 =?us-ascii?Q?xX4NGIO2a6/KzUd2iFua+6I4mTR+sxFky479PrR/oXEu/6/WEdIt0A0UAboZ?=
 =?us-ascii?Q?d1ovQR7eTseLTayPeyfAYbRN7vLI33SreVg2XmvPd5QErckQ+Jn14y2UQimT?=
 =?us-ascii?Q?rpXe7M2sfbKEra4PfQDzH5ALUwsNVY5iXJGmE72zWt8CCxfIPlM/OjNunkr3?=
 =?us-ascii?Q?V4VzFS/SMXWlD4pjFfi5lb/Y6tjKL5wT6D/FtQ48czL6Nat5N2mJtzJ5P0FA?=
 =?us-ascii?Q?MgzIFBFl6FwLf4M927YwLcBF4EA/uko=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6ab871-0b56-4b83-b45a-08da2e4f8f62
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 04:27:27.2375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KwLYjCsBrRURpTqG6dxQj6tWsJ5ltnOMnW/J+xgXMfx6f4vZDZvJ09n5LNNheUoY/91jYsZqqZzEk1zeqwKemQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7861

This patch adds the round-robin BPF MPTCP scheduler test. Use sysctl to
set net.mptcp.scheduler to use this sched. Add a veth net device to
simulate the multiple addresses case. Use 'ip mptcp endpoint' command to
add this new endpoint to PM netlink.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 3106e013b9ca..cc65e9afb796 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -5,6 +5,7 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 #include "mptcp_bpf_first.skel.h"
+#include "mptcp_bpf_rr.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -376,10 +377,47 @@ static void test_first(void)
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
+	system("ip link add veth1 type veth");
+	system("ip addr add 10.0.1.1/24 dev veth1");
+	system("ip link set veth1 up");
+	system("ip mptcp endpoint add 10.0.1.1 subflow");
+	system("sysctl -qw net.mptcp.scheduler=3Dbpf_rr");
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

