Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A09E256F
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 14:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654092593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F/1D37CrJPvZzbxiZMvJq3yVCCtd/NboQN/xO+EiniM=;
	b=Z5tq8f/5rPxswBgVyYLAC8Af42aTezSIWECw/xfWZ8S0+G8AzA1DdXaN+2kUe7fLJE8Zns
	IRiYjyh5ks0i1y8aqth7YIAA24jdmxyH4SvdUXMxWBdMsopEQ6kEt0+CSJxjLkLbCUzBPO
	FFaJuNnFpQ1oFCjwTZ074OR9Z98dNQQ=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2057.outbound.protection.outlook.com [104.47.0.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-qz4npsyaMlyuMX5ttpFBTg-1; Wed, 01 Jun 2022 16:09:52 +0200
X-MC-Unique: qz4npsyaMlyuMX5ttpFBTg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGn8WMWtc4n1NcorUluWV+1r5hDkCVsVCAPEe/tFu5BpR3OV24uvwNBQudxARi/T9z1YlBDh0BFzJi17gDIpuVJU8JLxUI0XHRYA5hrDAJAEeHHszDoI3gsE+ctsxKH3mIJhgHZd3M5W7XTPc1KsObIg+yHpSXKrR1ev1dwlO0pkt+puYREfagCC9RgbXIGnn6F3+IesyLQry9s9nBxV35l40fOvzczA8FBmWkr3++UarySwAgv9SUQBRiQoDtdg1Db3aGuLmRvrUQWpZDWsnE+CVg7EYtZJKa0FLI/LDXHY6vEbjc9oehvZw5tUCvlDnjLLTffhWRsJk/FJ6pXsqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdN0/NTSngD34hg/2mAz8TcUJyKmvrSSKr9bbGv39HE=;
 b=IPjYjOLElUnePuvd127R8889hFHxr7sWe141jSpLNdPgpOePpekUEc3cgC5Md9+251PcwgxfKP2N+HTcB6ccDN4NM+OabvSIic5shlfJPF+F0IIROj+YzXheV0UAT1ToykYEoU+74kzoxJSFYFBboLgIUf94wPy71kDdfFFpyqmoDoPnp5UOS8aTYmW+cOQM3wzObW731AgXd27EyYyIKIHC41mLKmKqPK2mSlP/wD5ObSxSzCUan8nKZSao68eNydoPga4TX3+SedpewisYQn2cRO2jmV5B/uHxqvAv56PdwpIC/3uvLaJE/6tmQB4qtUqWYgFqTUhc5fG3+9VwRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0402MB2935.eurprd04.prod.outlook.com (2603:10a6:4:9d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Wed, 1 Jun
 2022 14:09:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 14:09:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 11/11] selftests/bpf: add bpf_rr test
Date: Wed,  1 Jun 2022 22:08:24 +0800
Message-ID: <94de6d463bde36d3ad8e50324b9c40ce9ae36467.1654092153.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654092153.git.geliang.tang@suse.com>
References: <cover.1654092153.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0181.apcprd02.prod.outlook.com
 (2603:1096:201:21::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb4ced8d-8def-4acc-0241-08da43d864ff
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2935:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0402MB29352431144489000FA06F3FF8DF9@DB6PR0402MB2935.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Gr0AST09tRFQjoWnbN48rXB0QloZ/Texq5zAXXowG77d0AQ4DVDasyc8Bd/hHZ8sm+T99/BryECeSXi9zExaPO9D4g1ybSlGiVKKM70yXxKl5jyv6wormj4BbPtJTBS/5uguYqte9fFndpw1E5XRMMo7Ra07XMaInlZPiM1QcQbRggHhAJHpKoP9Xuw6jbY/yaavSnDPJvPhCrYMCJ2iat4WB2gqPk+T6//e8CTPYHPXMYEZc5gHVzfQcvtSZnkNQr7G8jjk5jzr0y+8p1Tbu3X/5BIlJGuNhHGEn33Tk6ZxOg7F8gMr2oEOZ0nyaHpDVFlySEfsdTlxZ1n7sBflp4VOGYKgEDpjYYMU7Dr52zpGGsLAqGwnczy3Mt+f9ebyRtdAJBgEEG3War/HL6f6JAkUzHe/GPV02QCHCzDHN0gDGD7YL4TVPBSOvDSROKqDxjg97OEoYm5+Z03q7fWR1TeBRY73O6DHkLIoJzSU8qgXRPn/nFPOmtTa6TelSqQaTrzmbO0zEKHP33BSA/+JrVerZY8ZXgTzJKB3q8//Z3Hy6jqe7Kxhy3uxSgp1vyCGc6xl4T81oZpG3dXnDM1vWy5S1Mg8gfexA7awNFpk3OWIyBAWFedkl5vekjlAhSVSBvcYkysPDC3kWQLoRw1NlhI6CQK0pynSJ1covfJji5vef3dulJSxSwrLi1EhcMX1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(6916009)(6506007)(6666004)(5660300002)(83380400001)(38100700002)(316002)(6486002)(4326008)(66476007)(66946007)(66556008)(2906002)(107886003)(8936002)(2616005)(26005)(6512007)(36756003)(86362001)(508600001)(8676002)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6X59anSLw+g5CHORdsdi+3KhClh7JJvbGKH9er4IjxqybR1BsnnCG2iBlydt?=
 =?us-ascii?Q?eu5LQmK3mzkwaz5ASXEXGaZjfcTyz1HY7kmZO5mKjMTqLj63dfc7kcc2wkgG?=
 =?us-ascii?Q?/2jc6Ss2ouUcxpnHDflh75uvNLDrvVwmFMZEAZN8QkCSTjEkjumi5tyfe8fh?=
 =?us-ascii?Q?e1qPitDoEBrxwBB5RMSqr+sYH0EphN+yUwsKGom3CI9WAtwiIXozhPqY8vK9?=
 =?us-ascii?Q?exAC+GLU+2dwI6pj6a9Nzs/HeZpIWLnf4bjbbYq3Dh5sy6ID/9Jp95ArKyk7?=
 =?us-ascii?Q?x3ge8HuYJoVY/Dnw2E3rvWfGeCKSWM6JSy3ASIRqDwbH280YRjVozRS63D5S?=
 =?us-ascii?Q?KYOoNpYltdZBMrtcuny9s++/bchvLWIR9bDudAQJeHKYH2h3etM6byqDilgt?=
 =?us-ascii?Q?ZssxXJKkFN4re0D5ClHZ4pmVYHrNdzBzCtsn5LLNimwJ+mF4Du9D3gCvAoUq?=
 =?us-ascii?Q?ihfqOgrTViEPFJT8yovkFOoGDAmzqE7B6leHipqUhAGMPeD71KGF1CqTypTX?=
 =?us-ascii?Q?N125HW36XRcc6dqzR9LbFfqCCFcFhyuui/XmraUeI/8RHfWI9i/kCbWRFveA?=
 =?us-ascii?Q?LEBSvt5UoPIoPzfHU4xQ27kqb18K03xd7p21DQGkDr/Wes/YzR6rSKbKxNQc?=
 =?us-ascii?Q?EXz5UUm/AwPf6+hQTxb6vvOMYA6OrJ7E7V8oLPBk5k5+QAwCbtJvYEKXM59R?=
 =?us-ascii?Q?Cs4zanTZktueiFkOJlksJ+gHaepGA9JpS17IncLCzgcZ+RxRLDk1+GEYazLN?=
 =?us-ascii?Q?bjpizMImhc3J537xdBIwNWLxH3FRaFJKiOJmPIYXiMNeP5mFw+3QuCjgg9Fg?=
 =?us-ascii?Q?lZsslUhjzpWEdw5mgXTiGuFn9GqRIqhD9zDYMMYLrW2nIFTQkCcRNGtdp5CG?=
 =?us-ascii?Q?7MH8P7Tk1vLCrOVJ93dYQMclQwZvqpWMgu85/J7B3EchNxj6molUCwGLt6LP?=
 =?us-ascii?Q?QF5Mn1oaGsYaHPKhQN5xhFE5BexPKZO2pr9vKT+Dl3IfDwgwq+Be/JBPC2Q7?=
 =?us-ascii?Q?4mJhMlJ5VMn8ibh3xFfIwwfnxX4QXAvQ1zyWBKXWJYxxYximztaDgsNtxvcs?=
 =?us-ascii?Q?D7NuzC3xu2TnRzFBtrroTQVUPgDI+ByLbiUGw+fWdsOXTMnbgOT+O1ckRaTh?=
 =?us-ascii?Q?YNVNXIXoWY1aPVoI3eiZOrGB80bpJ6a8ljOANAMAWahcWEjgS/ehkpWHHrBH?=
 =?us-ascii?Q?RxCZgalNV7OdQQkYHbCSlzI37NrtCbqCw4FGMCgtA12WJm9/jiShLwVeT0jG?=
 =?us-ascii?Q?2hEmPSKvKIEsYzq+TeFIwIALFF8YO///Mvh8E5kwzm+IQYsqr8/IxAGVZx08?=
 =?us-ascii?Q?VshLvg4gyZdYEawUCme+sWioIf9m1d6RfyvRMy8rrqqajQS5UyN2qzF5JvIY?=
 =?us-ascii?Q?6ycQi6EZkH7xAaAJyKO8jlC6PH11p47czc0sU6OuMqkXWSGkmhenp2UdUsSp?=
 =?us-ascii?Q?TQBfl8u8ET75CvEIhpVXpBy9sowMZChVe+icgmz2Z6COqunx34ukkeEpN3aN?=
 =?us-ascii?Q?NOE0w9YWAZLUBt1FTlGOngVFJhNSCspVy8CozW4n05jNiItqj6RMQX0pltdY?=
 =?us-ascii?Q?4ioPplfjqB2t6kxg2Zi5EzfGaoZxQRvp/KJMXWGKRYIF8E+IJT8wnIwIBDUB?=
 =?us-ascii?Q?sowyV+/G7f8KkJDEa2by0S1Hc2TZuMRtZKqTaubzWpmfzBiRmP28pZInjSoG?=
 =?us-ascii?Q?GK2/Xue5BuLwoDtD73fmVCAEYBfSM5Lgf6Q58KwTzNYDmo1+J9+AstrzVhpD?=
 =?us-ascii?Q?pHa8uQ5xRVPAegX1KJfYzDG/eimZQOU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4ced8d-8def-4acc-0241-08da43d864ff
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 14:09:51.5589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XO/IQ3fVgiU9Eqwndnat1OTRHsy3zHQ++ZyRymKRr7jPIv/+TwqyNvFE3Ue2ByRuWFDhRZCB3Cx8osnDMcOz1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2935

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

