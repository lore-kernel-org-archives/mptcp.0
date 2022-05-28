Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C6228E4
	for <mptcp@lists.linux.dev>; Sat, 28 May 2022 15:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653750774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tsdyxvHeHUgkx1/i4msHT1pYKZKfz1GQpufWvqPj4cg=;
	b=Lr/LMZPu3ndtc/nOlC2sontuoadGAsvXFE1dkLMwCLmwFyXpNtruGu6CZ9NP4SWJJ0AcW1
	yJEWO+1W4o9S7nkzOK54EHKRNZYZiMOba16NKDSHBG64ppsBXw1HFLjej34lxRzFl/fVrx
	zD7FNDWsuubpbK1aPx1z7h6HJAhsUfM=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-7-nag63sBIMXOl4Z2Lrh_R2g-1; Sat, 28 May 2022 17:12:53 +0200
X-MC-Unique: nag63sBIMXOl4Z2Lrh_R2g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bW+Aw1gX6PIg9kXc9cHMZ/1iFfK72ns8oqLq1qX81s6lbTLVMl7HDWAhaEPPFLlAQF84QbHAlDYAAH1I1eadwY+mQ9wNfxHIQfYAAgB4QQzWW0EByttLMTKIQo07uuq3jGtvqjElyJRhbzPSn/h8bpYBne1Pcgx9hYCKM3dg3P+55reyxzl2WtPQy0fSNeVYe5Eg2itOYi2/Msk50u+j9UGwQK20LDIq5Pp18FE8c3AStFsP4MhneUvJa4RjUr3ErqutiDl9KNLSVecco2JKRgGNsbHyGV6a58wDXApP8Ep2RmSi0fY0XTarqDsxNfAonDOTMxe6iCWRTsdalg//Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBVHehu1HJnLSMuH9LBaYBn9FYWX9AVxpfLrNg+aj7k=;
 b=adI3JRQugW5SLjqSS7iLdMEu+ZQgkA/dFJhR/WA7h65KkkWUehj7g5c5e627AIjV9ADEc6BCQ6CdI00cY46w5p9LhlA6t+pnpe+EwomaxyUUSmP2zdDzd4wO/A4SfwJlyOb8S32a84lj6tAO352SStGGVZROmMvN1KTrjTSMIRcyZYpq/Y1mkPsuT/E3exMXDwgdJlXED/+2NrxuELW5+xLDBbx543cqHDdH7W3DJegDRBOpJRl7Q2BGOUpFbCNsVqT5QzobVLWuD9vufO3ZnDfv/6dS2x2ZLESRiij24lRzJ+WJVSX0M59AQtDDe9i3G3CYv1BsaoIEZ5oA86t0Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8485.eurprd04.prod.outlook.com (2603:10a6:20b:418::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Sat, 28 May
 2022 15:12:52 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5293.017; Sat, 28 May 2022
 15:12:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 08/10] selftests/bpf: add bpf_backup test
Date: Sat, 28 May 2022 23:11:50 +0800
Message-ID: <ed081aecdf454886478df46af2c602083546d27f.1653750351.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653750351.git.geliang.tang@suse.com>
References: <cover.1653750351.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0043.apcprd03.prod.outlook.com
 (2603:1096:202:17::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 551a0985-1ebe-47c0-bef6-08da40bc88f1
X-MS-TrafficTypeDiagnostic: AM9PR04MB8485:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB848545A1AA1506B8A81B7D35F8DB9@AM9PR04MB8485.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a0zEK/6D03rk7227qsPRT0qTef2kyNROL+M+f1ndYgBxhpwufVu18qc3c0mlMlKqoqNPjEKAcp1TBJNSUoGKz0zCN2NZFH2DoX0HkYliQBIkXvWms0JpNdaVzRc9M76Kre/z0HCF7tx6GZWEa7ODsBPsytOgP8Ri3WCPjm0CPjDAyO+bYvrY/meHJeMCkwQBhrLbf5bGd0FGX82VTf5dROYRhYolQs1V46hrdr41YiSYoWl4ikpnTviCpxjH747AR9fpiSw7g0rQ82i5R8nfu/E+kVly0lQ/5IzRM0RNt9hjnsx/mqCoHpQwHleZfcuBYOeAHVlPdyfiuzfnvxms4tJHX8U/UVNv8cehZtf9BKmzdV1RVFbJEagB6kFWc/MYrfub7pcAnnqnbMsXtbWr3io2OAA1Ix4/2EKa3Rz3VOgfkC4Alo58mw1YgAo0th9Gr7RaLbz6Ak3YlrIyRtfdSXfXlIzBY74q9pXS0zLsxLacOQ3voKfCy3e9hloVUVP9rHEvloDi+U/c8xi8jgRz5uG3Mq8bjMb6N6qfFn3S7QbTVvdwT9+ZYl2QK6vZcRIqI5HJDN1JNW8PGPi6feB+R37+IqVD73oEJUR59BlbM+b/mQs9cOlZ8I1ArmrjLcom2SfJziE2gJWPznNVredMU0rL+mGGC0d+BLVr+hvW97Y4B1UYQWj2qGEEfikEyIf7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(83380400001)(66476007)(38100700002)(4326008)(66556008)(8676002)(86362001)(186003)(107886003)(2616005)(66946007)(6486002)(5660300002)(2906002)(6916009)(44832011)(6512007)(316002)(8936002)(6506007)(26005)(508600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ReXNjCe36OniJQeIZnEqPXbw1/22lUlATyn9HjeIMPvWeY0H5bmKn/GZQUY2?=
 =?us-ascii?Q?LK9qABoJ3RmIyUQzNuNDaSX7yDd5i7bhUEzYfv+eEcM22luGhnTFqq1piGBC?=
 =?us-ascii?Q?YhasB1LfhJMJzdw4zmI+CKlLrtEIvQLE5jlEnzBoUrz3SNDrRjH0GBhiemCw?=
 =?us-ascii?Q?+G30q7egoEX4cRChhrB81ycK2CY4jP9puo5q7+yrRIrpJVBFv5QWluQ3nwoO?=
 =?us-ascii?Q?ZasCohb5+3AcOJcZjPtpZqGoaXlSNJLBK7At+1WH411GFyqcJubTsUjNm+1o?=
 =?us-ascii?Q?N0u/ox9qt4HbmAOzEPSa8oRsgyBck5nHep0A/Qz5+n2k6dA9xaGao08TSjJv?=
 =?us-ascii?Q?owK+7Wv5LEivIiLcAPlFBEbTpJzZnJahIaZychVZcd2lz1QEdCKD3QBcqqvj?=
 =?us-ascii?Q?yPiqXJhgG678s7q8QUbWBfSVmQ4LiqNNOQIQ7MAQP6YafzxBWgTQf06J2rVM?=
 =?us-ascii?Q?SqfzzVSvpHPlk+W43Lh3WypH0iXV2sSIEuh3TeAfXfOdqdw9riKJH4YMNxfz?=
 =?us-ascii?Q?qgTD6pACl8/DpWt1qsuVA/a3+D141owtSGDeCus2KKfoKhUMzJoS2MurIbtx?=
 =?us-ascii?Q?wqITsdpqGEalzMJOwpl82xKsiE1lqc833DXcxuhjPGpPwAunZDdV48Te8gNW?=
 =?us-ascii?Q?uve54KVlr3a2FP3xGEGpDjF05HHku/j4H9B6i5w6V+k1YBh+KgAGcdMOUzqV?=
 =?us-ascii?Q?BfvDJLuvhgR4DQVfcLkBb/qmiEBun1i24pkTxvtOg1jmFA/RLe6KX1bct6Hp?=
 =?us-ascii?Q?s+DkiRTmebCSM5ZcNagr8UCkRp53lS13wvaIKT1GnEGtR6MX1BBPHGsBrGhX?=
 =?us-ascii?Q?q8hvrA8kYW6vnVN8+ZIeUGlhszMFPwWbktnyFPVLzBJYu5ZG8R7dFVGA5oKq?=
 =?us-ascii?Q?e350wKuPicqpDwZe/q0PeqjNMYJDEi+QP7X5MEHkoEs5SzsJX5QSYb3sY7OQ?=
 =?us-ascii?Q?Q4tC+Zs+i4d4cmJCQAifm+04E3joBEQwNxHqOYVWn5gKklemHVYeqDeIFan6?=
 =?us-ascii?Q?L2MkEB/oJdSQf8+JQtZkC8WzDj9nIFbBlEHMORoB6S+81ZSFDWlx0B0yp2mT?=
 =?us-ascii?Q?tK/Lrc5vEruFY8m42lCsz6JdSRZL1o4MRQ8HBfd2LClV6e1lw9yFkrfYJJU8?=
 =?us-ascii?Q?6fKjp09rhVvYjWxkj4Epb1tuqm86mQCWA4mwY2DSgFGrqpKxZzob6mmKY+JU?=
 =?us-ascii?Q?HgRNzmDIu6+1G83eF/LAJlcNxxWWGHlxNC2ljNIvz3ZsgRUZ0X5iczebo38R?=
 =?us-ascii?Q?XCUTwy9XKKnAE9OxaZYPFkVYvJobW3WGR6addg8rOEMwS0IBX6HZrpM8nQj+?=
 =?us-ascii?Q?T72+j94NnhJpNTc7pFht1+6kYwj0eY2k8AxPVYQLhrlzbK3ZwPUbeCqRL4pV?=
 =?us-ascii?Q?BR6bnGWDeCyATC9dJWe93qadVNFS0FSpYVjV4V+7wjXPWXOehKIcAe4la1WT?=
 =?us-ascii?Q?WadVEz9jmC77VeeRbWK/m5Jn6AxOuz/WkGO9dxw5Q2IDIeixpW9gsYYpp/iR?=
 =?us-ascii?Q?s4GAvjFW/SFBoMIkOhD+dJrxMMNbaWF681yxvqk36A7bNo2wG4dtpOTi61eQ?=
 =?us-ascii?Q?zFenXt9W3t27YGS/Qro7AWCUO8NyyCcnPYsjkrgD2Gh3b0ZG8MNBFFEGgno/?=
 =?us-ascii?Q?teRoCMT8Eca9FLBfoA6uYtJknM8+0S06g5dAUIoDmdBNNC1jrBdJtZ/P2vTh?=
 =?us-ascii?Q?FQm+VBqbcLdVCUAmiybGbj2sT8weRBWK7rA+ea9WoLnIs0tBAjQUoBFIiaJ/?=
 =?us-ascii?Q?rxyNgJtC3iE2d97i+dv3UIp7UXZqwjc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 551a0985-1ebe-47c0-bef6-08da40bc88f1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2022 15:12:52.4888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2LpILWDm9lNKwQifee7GJlzYkCTmvX/Hl2EwpwEVWj8oWzdsHa5rX55eXXZ1dc9nvuES3fk1DtIoLsT2sqdfiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8485

This patch adds the backup BPF MPTCP scheduler test. Use sysctl to
set net.mptcp.scheduler to use this sched. Add a veth net device to
simulate the multiple addresses case. Use 'ip mptcp endpoint' command
to add this new endpoint to PM netlink with backup flag.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index eaea4105728d..1f92d251a9ba 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -7,6 +7,7 @@
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
 #include "mptcp_bpf_first.skel.h"
+#include "mptcp_bpf_backup.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -296,10 +297,44 @@ static void test_first(void)
 	mptcp_bpf_first__destroy(first_skel);
 }
=20
+static void test_backup(void)
+{
+	struct mptcp_bpf_backup *backup_skel;
+	int server_fd, client_fd;
+	struct bpf_link *link;
+
+	backup_skel =3D mptcp_bpf_backup__open_and_load();
+	if (!ASSERT_OK_PTR(backup_skel, "bpf_backup__open_and_load"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(backup_skel->maps.backup);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_backup__destroy(backup_skel);
+		return;
+	}
+
+	add_veth();
+	system("ip mptcp endpoint add 10.0.1.1 subflow backup");
+	system("sysctl -qw net.mptcp.scheduler=3Dbpf_backup");
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	client_fd =3D connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+	ASSERT_GT(system("ss -MOenita | grep '10.0.1.1' | grep 'bytes_sent:'"), 0=
, "ss");
+
+	close(client_fd);
+	close(server_fd);
+	cleanup();
+	bpf_link__destroy(link);
+	mptcp_bpf_backup__destroy(backup_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
 		test_base();
 	if (test__start_subtest("first"))
 		test_first();
+	if (test__start_subtest("backup"))
+		test_backup();
 }
--=20
2.34.1

