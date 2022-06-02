Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB15622
	for <mptcp@lists.linux.dev>; Thu,  2 Jun 2022 04:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654145735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/1D37CrJPvZzbxiZMvJq3yVCCtd/NboQN/xO+EiniM=;
	b=RYtcZ+27rl0eGFrXdYvMRS5mhNxcWv/f7aSnAG7SInrMaX5BY6Dta5jfROgYJD3qyigTkD
	BbrVthM443JblJMly9B58b9f6Q5SefCm+YlMFSUr0qHojYMxR7BoM5/CJLArwFcg4eL3St
	09bcBMyJDZgtYU4MY/blrcwp1lXk1aU=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2056.outbound.protection.outlook.com [104.47.5.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-30-gvkmAGr2M4K2jl-BnoKZ7Q-1; Thu, 02 Jun 2022 06:55:34 +0200
X-MC-Unique: gvkmAGr2M4K2jl-BnoKZ7Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHru77pQnu1TKx4DK8ujQ/m9/SH9SoPgOsGtxfDxnwjOZs2Wdf5K0YDoUc3I6c1PayFByfsfB664SDvn6+tfBxy5Mr7BKxpWTlzZ5f6RqXQ8B1kc9lkjhLWwiQhyT7k24Cwtq52I2nSxwkukLSrZiDTjBfrhPfIVaUBatnkRaVnbBMXXR3c4bnN8OolwXu17wGFnoWrnJzcM6IgJAKi4sVjAP/2l3nqZn2JajTcive7O4fLlDUt2q7ZsnFRG0jToSwKEcOY+At6T6Dq5n1Y07MXQSlm4fG1zsddogfRwz5jzC8zv7z7ay2rO9U7B+MCck4rcbne5hxQaK1f0/nkYhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdN0/NTSngD34hg/2mAz8TcUJyKmvrSSKr9bbGv39HE=;
 b=SZqqk8nZYWypkMA7W+TDRDHneu+Kjml1zjwccj2vR6zJjsKLzFOf0PesOhmsbZbheGxQrE7+xTIoDmBmmo/N8Y5kC7GJLKr9Uyd8fbdzglt1RYY/V3PNqqpO51Ftx77cYmWvXXstJoN94Q3i8Eg+n7/VsGVGcigX2QkLsz0hUypvJeMva7FT7J9QOVQp1wRd63ju/ANb7ZuHK2typElbuBE90EpwBMb7QC77Zwz9qP/aT64/R17fW56HO7Vtn35b4+v6HAxz9ORtN1Dd/7CH/+reYnuVGpqohoK0RnEh0Qy751RjhWPCtWo+MOKVVRyR9YU4/MezLsRxGWD4ozkf3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3384.eurprd04.prod.outlook.com (2603:10a6:209:6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 04:55:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 04:55:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 13/13] selftests/bpf: Add bpf_rr test
Date: Thu,  2 Jun 2022 12:53:50 +0800
Message-ID: <f26165cd8b5d4380c16b4d13607e219e376bdb19.1654143895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654143895.git.geliang.tang@suse.com>
References: <cover.1654143895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0135.apcprd02.prod.outlook.com
 (2603:1096:202:16::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d3908c8-1f65-4df7-aca0-08da4454202d
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3384:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB3384535D93A06D5F3AC316A3F8DE9@AM6PR0402MB3384.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XYf4QUxgLSllZgETlb6VPkk8aR7X089UlgDWUpa7XzhsD8Rw5DTZnQThAeMtmGUGhWQINuXbWxtXOb2lakStQWRAYv04y8rFy6i0qhWqgSmMDKpQ0+7c+YIu0WZ4/RU8XNqG/p/fjfc1FyUPfKALAHWa4k7YiBcQZ6ktI9pJWaveb5XHcTrP2uzF7O+HEJy5GFiIfs9khzNxiYZOMHHq9NT/+ojquj1hNPeFI9ISxi7yMR85H2PwfexbstvcrwiMP8Vj/RJDGGAxVYFTwJq65QReVG28t5jZmqE6thdk8isAtRjr1iM+skhPTNFTYyIDnhHN0UV9uahlvaPygupTGZ6LQFVy72gIeNI/ISRt8BzhxyLONQJJCuhGkQMiLSrykB44oODBbasPgC5UWqlwp6T3Iso+EnhCbE0XFwOUpdjIZCGrcOuCA5YbKy70wMJFo8yTjV6ewVJ4vY9bU9Q08E9Xt+OUDreMCsqryG4pX3VfthVEhfXne/wJbKh4MwbxqP/GP8oMtS3V+2+pGARQQ0OY0ATGu2+yZmRQohEeor3a+B92HsecGNX5KrDVgLVfQAD5bQsQbIs2MvOpg5GVGsMNNokmOGW6QlL1m6eu/ripWgaWvNyLX5WPgTlpTOTk5cjgMcH3JpXWB+kHpLHic4Nal9oo5l3Dk7pxnURaxqT2VZzn3fVLjdcBHj/yuloO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(86362001)(83380400001)(6666004)(8936002)(36756003)(186003)(4326008)(2616005)(5660300002)(2906002)(107886003)(38100700002)(26005)(316002)(66556008)(66476007)(508600001)(66946007)(8676002)(6512007)(6486002)(6916009)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?038wLK3AFkfoz+E4/UvkvLZUCCYFIrMPcBvHad+xojVlqcW1H6OeHBfNTZwD?=
 =?us-ascii?Q?5aN+zQY7lD/V8ex4b9O3KZcNxd9kVOf5KBn6WPd2hWwn8QlE4Qdb8UnGKvh1?=
 =?us-ascii?Q?gcNsjjpZcS5jCmZJtTfIX7AKCGIbUl3gVbmOJ52aGGsEdVMUdPquhgYt84k+?=
 =?us-ascii?Q?L51/c+uzMyIyY2GUos5Ybdtj1B7K8jelWQn4GgHL+wjNPgd/O4Ng2IkQGUHf?=
 =?us-ascii?Q?+Nmsd07NaCpRo6H72ix3AgPoU23MLZRBT5gBV0LYNmrcNLN3bpQz7ymFjWbI?=
 =?us-ascii?Q?bZXfx+00pRScyJFza1HUHAPfiKyRKCjDt1LdqzvD1kNXbG1QceGjCUE1Pd+C?=
 =?us-ascii?Q?L69urBomq8JND54Yu/a0u63QZE02rwjxVUfnd3CsC8TKbXLI07x9JXx+G/RC?=
 =?us-ascii?Q?iNcnSlDiSLMT3xAHy7k9s3b8CfK+wY25uoqE/cODoiwvO/S/MDy1/pDnmnxe?=
 =?us-ascii?Q?nC4+03V4opy8qmGVLdkCDNEnFGt9JPfH28a4Amle8QEL6oYF8xFFv4R2FbC+?=
 =?us-ascii?Q?0TH59E5jXDfBLdMULdKw9avGFe0RMj1oLSJTk23ju73bl8KTHcbF6iT2ohgD?=
 =?us-ascii?Q?zmdcftV+1n8s5F7/wasaLXZmL9FwfBNePzFv0EdgOcFZuM6UuQ7rSJJ2VzcO?=
 =?us-ascii?Q?liyVfSY6u96zpPRJsEwI7KOmYRTnxeR4RAxmRNS+bbZcC4dP/oJK9K1UZuXp?=
 =?us-ascii?Q?TGODNfGdTIBgjyaJa7/8KSxHsAKLhHFix3UD9UPmaJ38hOK0Ce9M4GLKX9km?=
 =?us-ascii?Q?Ko4wfdGjY7X8O7NZD/rh3n15/zVEKvYh0I2naMk0FZIYLkGCpirEoXpWoE+M?=
 =?us-ascii?Q?7UwOKB5rTWxaM44Z8N/9PCwO/basx/iirLROl6BBQZ4p0ULggiKJFIs0FY9w?=
 =?us-ascii?Q?oT+L56Z3Uy15hfzZHGoYBbil5iKeDoiU2UDlTUnQi9fg4NG4EEZMogClJotd?=
 =?us-ascii?Q?R/tpHiW9HPrM6OyI0nTAc26wyXihQ5tW+SEr2Q4yayJBQ/gCfLOfqOlYfL3i?=
 =?us-ascii?Q?9Pjvajng5NG+mzz2q/q5hhHoRoSEoVQ5PLEvAu4ad4OsIR4hNDCF7zXt24II?=
 =?us-ascii?Q?O36tPFIsYDlZkg2ywXKj97AlzxVu7cc6XOPQPFvwlybdEZ9ZYEj4o32ZTqJU?=
 =?us-ascii?Q?Ama8TwnhOJq/9LlrnnewibfAcXf7KjGbOf+r/htKZ9ys4oPiqjCLBOFCBr3d?=
 =?us-ascii?Q?23cfNsH2pEyvQSTPRP8l4BAWU9b/vU+C3OK/7VdqT7zmv9P91Q20WlA06Iim?=
 =?us-ascii?Q?J2RKmjsDEgDY667IT7VZyMQXnTZIJLHXaJzkbfSbT5CQ1FSwyY4LI0dXO9Rk?=
 =?us-ascii?Q?+1GjVoioNzk6TpilyYX1p+UiGcyb7ktbU/T+rL/9p2LV0nRDkb6uA3cJlHIO?=
 =?us-ascii?Q?+CVL/Rmk9lsosgHHrCTm9EfB/BsxDDQmbFyh5oCeuMvPu7bwrSZOvXjgZoTU?=
 =?us-ascii?Q?JscS5fZ4siGUyYmH2CgTetd9GJ7/A30bUJiAUAKMAxsOTXnwQq3xwTKbBgfF?=
 =?us-ascii?Q?DXmWJRZvhxNY1pK1Gn++wwbQkmBJRlwZmVeG37VcC4Ejgcp7XEZrrhCKQtWT?=
 =?us-ascii?Q?PqZkKw5zb7K6fsEC2qooEBxlvruGOYvDcf+pDjN1iuatSVj0WxI85F3iUwxe?=
 =?us-ascii?Q?At903TPPbUGOvn929F2dDhoMri0vH0sRtji7R62U0ttzT7/B67Il0mgy17Xa?=
 =?us-ascii?Q?eSLGvJEdCV6ZPWBSfJD7uZL7rvTIIunwzP10LTzKef/A0mTmsZtioPp7Ah3g?=
 =?us-ascii?Q?yUG0dsuHeUTktT5iqA2zrRdTgmYC/5g=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3908c8-1f65-4df7-aca0-08da4454202d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 04:55:33.6808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vSnTZBpAvj/gqJ01bw3xfMVlwbq8mx4e2zw8zSeSd84Ubbu3Dm42XcNsyaaVfpAJzXWT1wu/DNFrlFtKyOdt0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3384

This patch adds the round-robin BPF MPTCP scheduler test. Use sysctl to
set net.mptcp.scheduler to use this sched. Add a veth net device to
simulate the multiple addresses case. Use 'ip mptcp endpoint' command to
add this new endpoint to PM netlink. Send data and check bytes_sent of
'ss' output after it to make sure the data has been sent on the new veth
net device.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index f3c73cd2c786..1ecc8a2b76b6 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -8,6 +8,7 @@
 #include "mptcp_sock.skel.h"
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
+#include "mptcp_bpf_rr.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -329,6 +330,38 @@ static void test_bkup(void)
 	mptcp_bpf_bkup__destroy(bkup_skel);
 }
=20
+static void test_rr(void)
+{
+	struct mptcp_bpf_rr *rr_skel;
+	int server_fd, client_fd;
+	struct bpf_link *link;
+
+	rr_skel =3D mptcp_bpf_rr__open_and_load();
+	if (!ASSERT_OK_PTR(rr_skel, "bpf_rr__open_and_load"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(rr_skel->maps.rr);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_rr__destroy(rr_skel);
+		return;
+	}
+
+	add_veth();
+	system("ip mptcp endpoint add 10.0.1.1 subflow");
+	system("sysctl -qw net.mptcp.scheduler=3Dbpf_rr");
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	client_fd =3D connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+	ASSERT_OK(system("ss -MOenita | grep '10.0.1.1' | grep -q 'bytes_sent:'")=
, "ss");
+
+	close(client_fd);
+	close(server_fd);
+	cleanup();
+	bpf_link__destroy(link);
+	mptcp_bpf_rr__destroy(rr_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -337,4 +370,6 @@ void test_mptcp(void)
 		test_first();
 	if (test__start_subtest("bkup"))
 		test_bkup();
+	if (test__start_subtest("rr"))
+		test_rr();
 }
--=20
2.34.1

