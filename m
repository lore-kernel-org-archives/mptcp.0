Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50061.outbound.protection.outlook.com [40.107.5.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C6FEA4
	for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 09:54:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IByRLnX2E6w8OEHZDqg0iaTL4ivV2rfL64/isTBFRtbpyBMsan+doV8+5xAgxfkglwu04GBp+i871amepEE1S1SVafAeoHane8fK8x9s5fl6efzU1uccda3RVUoMT7AzJDR/k75sQP3QTDCnNdO4JG/x1BYdZKzngFeEJuBMm73WPjZDRDcOCkSkEQ9uLJsuLHzRxvAWh0yRkgQ/BvfyVGKzrptE5NepcQZeaCQPGS/TT5UeB1baSFt59Z7yqtn1NhmugM1VYSXMZXfcTpKjeLm//asq00rxMptum1r0BG8RWlrPv31Ky7SPBQqf5EZgNcwJ6d96UvC+U4qin01a8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=k/HBxMYJjzl6brALzNqzxM9wr4xBtWa4z+fHR7hKbTd0O/wRK88PAv5JVeh/wZHB4oQG7p8qBEPIeYS48dw+b1E4NpxIBUQddfM704ADRkDzrek0X2SjNfwNn3o2JRliMLS3z8NFOPJygrzONwNAmR28+qkp2k0btZ4FTbudXVREUphCNDZzk2qpaYyWx9Rcu0dMHHyCqxpLkV19M2aDR4bfPMPKxv7d3Lk9WDCjShWq1041Dv+oU8Y+AdoHGkyjOtft/pcFLvKjVXfWR7vZXjxx8f/8lckExSCfQi/CKxV+dSXhoozk9Th9TB4h/JEsDfnPVN/o6S8Gcqu55hqGtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=jKzWM2TLTRx7cGR9w3NHNMjLJvK9heCDO68IRer37YZJbDDb5v8V9Mi0pHPGQ73UhWUJ/+mjMZ8xg9zOamr9Y/c5a3QoTxy2D7wiV7TqS1APxnjlPHa5OPK1c4E4Sth/2WG9ORhWMSydc00Hx10DTl9bzxhbYeLkc1cR2PGGc/Q2/HSNZ1y8EAuZELHqK1tfThg4PKsfCU0U64rZPIrBFD27jaN0RaHmu7h/TKTso0KzXHemxWyXnLnVeHCZ9pHiMqdI/98TYpWWX7W5dCuh3kiUa6nlda2sXc/WIbIXY9T2AWx79Eo8Yl6CiX22d8MVQwsyTleSb8wU6nBVgLTVuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9427.eurprd04.prod.outlook.com (2603:10a6:10:369::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Tue, 21 Jun
 2022 09:54:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 09:54:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 5/5] selftests/bpf: Add bpf_red test
Date: Tue, 21 Jun 2022 17:54:19 +0800
Message-Id: <23316da1666099022ed050bfd6ac2540aeeec198.1655804700.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1655804700.git.geliang.tang@suse.com>
References: <cover.1655804700.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:4:7c::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 432df42b-a87b-40ea-2df2-08da536c13a2
X-MS-TrafficTypeDiagnostic: DB9PR04MB9427:EE_
X-Microsoft-Antispam-PRVS:
	<DB9PR04MB9427ED226B2B2299EE6E8072F8B39@DB9PR04MB9427.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iYdufBAEf/tskiqid4t8regvDKQVRn1FehtK4OCcMjWeCzXeFS5k91yh1fIj+7VGo7F6gf30QzwYjEyslEjUItv8TuWUYbYpWGziZTwYBHBzEcqx2c2ox9I5pZb4atxlXgHzjk7++r9bCzGvNcx/S0+tWTo9l9HmsQ2acoEjvPq/FKDDs+xUK6/kia8LnK85GhGIAanQE2r5IMib5B7gTlVR38bAWZIQTX9ez8T0Xw/F5oKXCFpJdsda08m2zKRj3J+C899LjNMfv1It3X1MaSt1lad6/bsKvva9fQoVXQEAnkmjWSPkvzAEbdGao96YK6SYvlYEzO8wftaMaNaauPFZLawK5RzNmjoyX6w0so68eHlDYFekwMPHVLF+MJnyKr/Hz6pka0RQWw+Mgwv3dDOyzKanWaBKZ/5q3SphUgQybiU10st4yLywL2zCV/QNcMcbnI1U0mpB9V29OOjVD3XgKsmn92rsYlWbp5bhwz1kGEwDmWbzxOVv2ujGwbq27EwWyXr+q5Fpy277R34Bv33gP7la43fb8dNyEqx1+CBJojzg9bpYgngnPbaQZ5iO+rOsRhTWg7MrolPFxM26vRYl9HnCt9zYm1J3gVMPpvBbgWETGWREqjjnl8NiEP3W81wLgM3rj4zZ9a5kaDUbxPHlXHIaE06lpbbMUoREN1gYjCpsJZXFWV3M+O5LE7B+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(39860400002)(346002)(366004)(396003)(2906002)(6486002)(83380400001)(6506007)(5660300002)(6666004)(44832011)(478600001)(8936002)(36756003)(38100700002)(186003)(86362001)(41300700001)(316002)(107886003)(6916009)(66556008)(66476007)(66946007)(2616005)(8676002)(6512007)(4326008)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zRuQjiNaGhNqLvy0YdEEwzAsfM07Zxn5Jdzbh94HeBgi8DHIkpgRUX1Zmk6M?=
 =?us-ascii?Q?rbbhBoYzIQClJuPVCvSqjCy5HBXGw2N39SY4snrFAMYGiBA+NXVzHj054fGU?=
 =?us-ascii?Q?mLteFVs9CzIKPtz0wpbOKLZc2zArWf1Y6OhSbFCqY0vMWHmRUl63zK0Yvr7n?=
 =?us-ascii?Q?3XVYMyA/GQh8U00GgeTkaOqBBMMnwKrGMuoAfs5Pd1nYB/jvLCKWDkULA8V/?=
 =?us-ascii?Q?cgyBKH991RcxKh3F5Wko3HQPbkouaEN8VHeFMlibSeuAOqJV5vILg06ux4T9?=
 =?us-ascii?Q?tlJ0JqFust9bYBAThqOp05XWuyYRSi4TpEpvcso9BUE7n+/wStoiTo1i8CCV?=
 =?us-ascii?Q?SmKyK4DWkAhAVsstZ+/dWgUj8rfJciQogJxNxtaV2aPAC+JIntgCO4O/S6l1?=
 =?us-ascii?Q?syd624x8B2VratzwBsM6B5K+XoGyDZbWHVvAxvk56ZnBzCXXZIHpEjDajIRN?=
 =?us-ascii?Q?tEGUEz56ehlGMjH8itlYgri0HRcfnxE7Z9qM/QlPhGlWud1B9kyesQf9VDRH?=
 =?us-ascii?Q?xSMwC278qXQkaDKAszk5LjMEDMfo8nvBTJb8IjP0/x5ibNEoeWp858FLXm6b?=
 =?us-ascii?Q?ParXc1/pLrHw6jxM6fdUdhfgk+ZzbBXZ3Swp0z2qHahPILbh6GPDVqNn2CBq?=
 =?us-ascii?Q?+U7AiRB/Kl3UkwrCA+owH143UQV+6NcBKNIn76L5OFlTr6hP8Ttju9bVImtV?=
 =?us-ascii?Q?vfTDKlBopWZcWRMWQnYr2o2lDE8mVUrXiDja5Yhh5/iHWpqvQbSjJg+qX+dM?=
 =?us-ascii?Q?pZIElp+qWIndY42tjsJdDZ7rC6EOUT128P2ULgJGXKsR6auYofJUUy/8d6V2?=
 =?us-ascii?Q?+i4IZ2j7rslJ3ofBrmkWj2UeUu7fW6+B/ZEmaAfkklW19UUcSRHa/XaG5PbJ?=
 =?us-ascii?Q?/Z0st3HleqzqceJOQwXEe3lDIzepVMuTXM+kUm6VObMSnmV5ZNbOEQQMpkh9?=
 =?us-ascii?Q?WFzI0wayA5FjhXKoPz2p36meONTWvVxgr3SpOsrh0R+KzYIInXkr81MO96aH?=
 =?us-ascii?Q?Js4V0rL8CiIcR8toq/9c1NcqzQa/SZgADDVU5zUz/H+XidBxsnP5Y+rW7g40?=
 =?us-ascii?Q?rp1lbwDPuEv/GQnPfXmBQdBVpaPFarxsNC2amSbz36dRmeeOCEhcIY6wwaP9?=
 =?us-ascii?Q?UwSv40W4CXJx/55aYCR7A/5ebPfHMagnx7ag0NGkVWj+IYk5qOxuLiQmZxaL?=
 =?us-ascii?Q?X4mQv5mY5Sbs9LB124a9vYWxmbKIwlP8g01e/Nq7ws1PRzwSRO8ofgwPvaG1?=
 =?us-ascii?Q?ldtb0kZYYyI3/N2VpDRjd2kbMKyel1AiXB0xeEjNZxM5Iuou4bvHdg6xnqsf?=
 =?us-ascii?Q?CEmDJBgQJzukSE4xGrycpQhY5A1D2lNIByJ0OXQxpqyWFQ2lJ0OWutTUuSAF?=
 =?us-ascii?Q?+o/+8l5YxhDcNrsNrZvnPVfVro1qBg11sgkUN3YZnepSDwK1yECMi4VXULh5?=
 =?us-ascii?Q?upWmN5zIjEfNEnLzCf0O37qg1CuUO0uSo/L69HanLMMMWxmh0xXZ2ipcGKWM?=
 =?us-ascii?Q?k9b8RV/qC/NfSAm9cMRLtB6YQiUuwB2X6g2HjJ46xu0BjKjYvO7c5Q30oCYV?=
 =?us-ascii?Q?nvl9ZykC3uUviQ8ZXmj6QbHZam7q+VNFQ8tiz7XOKIx39+aF67WAdkcc86No?=
 =?us-ascii?Q?Cndx364dO+xo+a64+laWqZJg/RcfgL+IiYj7ZtKE3GN6zYVW4QIC21EJaYQX?=
 =?us-ascii?Q?T7U5ftj+IMhwKSq3e6RMy6zc9Cw/zkDvixuO/GnfGcDnVSgpr5nCwO7bigFK?=
 =?us-ascii?Q?GphQ0fbdPPNtrrjqlu7EoxXyKeBp5aE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 432df42b-a87b-40ea-2df2-08da536c13a2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 09:54:47.8565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBOz5hx2tW1McvrEAqhvnmUbUZt04Z5sUJdT4gZ1Yfwb2JXS+5CHUcmxqelgkLRFAh+wskaGPbzot1H4PHUg/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9427

This patch adds the redundant BPF MPTCP scheduler test: test_red(). Use
sysctl to set net.mptcp.scheduler to use this sched. Add two veth net
devices to simulate the multiple addresses case. Use 'ip mptcp endpoint'
command to add the new endpoint ADDR_2 to PM netlink. Send data and check
bytes_sent of 'ss' output after it to make sure the data has been
redundantly sent on both net devices.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 647d313475bc..8426a5aba721 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -9,6 +9,7 @@
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
+#include "mptcp_bpf_red.skel.h"
 
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -381,6 +382,37 @@ static void test_rr(void)
 	mptcp_bpf_rr__destroy(rr_skel);
 }
 
+static void test_red(void)
+{
+	struct mptcp_bpf_red *red_skel;
+	int server_fd, client_fd;
+	struct bpf_link *link;
+
+	red_skel = mptcp_bpf_red__open_and_load();
+	if (!ASSERT_OK_PTR(red_skel, "bpf_red__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(red_skel->maps.red);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_red__destroy(red_skel);
+		return;
+	}
+
+	sched_init("subflow", "bpf_red");
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
+	client_fd = connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
+	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
+
+	close(client_fd);
+	close(server_fd);
+	sched_cleanup();
+	bpf_link__destroy(link);
+	mptcp_bpf_red__destroy(red_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -391,4 +423,6 @@ void test_mptcp(void)
 		test_bkup();
 	if (test__start_subtest("rr"))
 		test_rr();
+	if (test__start_subtest("red"))
+		test_red();
 }
-- 
2.35.3

