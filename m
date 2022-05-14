Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E56B362
	for <mptcp@lists.linux.dev>; Sat, 14 May 2022 00:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652487557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pEXMqVrStShkar4Pe6krNN0nmDtmfPy1PS/uuHgfMbM=;
	b=TL38BCiaGApVnYJ+q/Yqe2y86nFN0H6bSNP9XRiOXOYurZpoQnyjha9Qb952EVZHnkAsyM
	mlYy6Y0kZLQ9WHdPBkjf91Zn9iuWj0yuZ3LJfl+W1oK3HiMG5V5MmrV3ebYxOJGpA1bu22
	yLC95nU4Qv9JrXA954sevIwasHnwxHc=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2050.outbound.protection.outlook.com [104.47.14.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-flgaf3EEPVeR4HwUa9Brdg-1; Sat, 14 May 2022 02:19:16 +0200
X-MC-Unique: flgaf3EEPVeR4HwUa9Brdg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQT5EpKi6zcVzx7P4mXKiC0TkTujRqSBfQT9zqKz5o8jAyG5md1WF/Q7woAM+MfH8D/bQSIcbD/c4twdv1zinoanQ8TQLszmEcnOUASzHIA7543CaLUnGRc075Sp6SxIIGxlpAamld8nLicNEiIoAMn6/hG1Bp/dbzUfvjTH1lyveOWK7+T86CAvbQPQNUCkFioZnjz4/Keh8XrJ9KrTQ0I84H7pml9IHQeZOvQytbG4gv4QCdGwDCEZUVVHkii6gzUlbkuKW+tfcL3vGl4P5iX59Sn7hHgGeYs83UHcHEhQaoOMvZyDeHKFTgeI1vEH667OfTsUEW7+KuShYGnHsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBIcJnAgqd95YXhFSYVcJV2/TsiZqmozR//nLREuQNU=;
 b=fb3d4sW927Bqy77E2n1Et0ifcszIDRt4oAhc4d5ekas0IBhgYAz3UjzXTPhS8fZllImvhXhYeECe8XEQIfjBGtCiOeEuNuaFTwDPFUj55/lS7swhdzXjPSEj77Vi6WJeQlnpTC1o1edERUtF/0rYfTDENf451X8rkZhGLcLCdjLf7rNcUM4skco45rITIsJR1nP2HNCEb4k51ng5NkrKz4qorOXzRKxHbHT5CWfQj/QAjNodlFMnNR0drm6kP1QOsgV2Icqo2qTIlSk9k9NIyQyfJrV3/K0392DRSx/vgswEu0wjGgiDLqS9sa3hsARrt/vgWQhZv6vfoRbkz3tyXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB7PR04MB5579.eurprd04.prod.outlook.com (2603:10a6:10:80::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Sat, 14 May
 2022 00:19:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.017; Sat, 14 May 2022
 00:19:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests/bpf: add MPTCP test base"
Date: Sat, 14 May 2022 08:19:04 +0800
Message-ID: <6f5f38cec460bdd53b7d0f179816a1248c3db0ee.1652487491.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0014.apcprd03.prod.outlook.com
 (2603:1096:202::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68f2d650-c4b8-45b0-b383-08da353f5f77
X-MS-TrafficTypeDiagnostic: DB7PR04MB5579:EE_
X-Microsoft-Antispam-PRVS:
	<DB7PR04MB55798FE5B5E6C87827CBA3C2F8CD9@DB7PR04MB5579.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zoja+gCU0e2sSVLei7rswtW3qBudiDe9XNrdC2tEYND/G1mSXSSVq2hvYmWqBLxw9QUQrBkM7SMqiOSSbl1f/EjXIZyOsexG7hd+60AoqvrafNH/DHIIldk4Vqp+xLvjzzg2lfFi/LAcgPdshDy86zoeK/AZp/7oO0MAbnwS6EW7Fuii8wx+wbLcrLPY7D1GMhZoRqqJdUd57AzQahQ5hs0wpmnd1Ue/Fo2VE9XKMAGpZcImkwGzpQ5fsHL/Ixag58p4g43Vet/ny59Kq1d5tlnAnOnTb7xjldCG4JJQMVKgKM5OEQHTyfvBE6DAM5LMQnVsMNrw1G8JT58xMcwvn/M4PuwdWYMSEIEKR0KiJQBIF7BpTBs1GFpVo8KLV0u+O+3JvDiIBfGFjxb7q4BHmoJGTlM6PGNyzrGrhkY7C0Z+VQNdDepZRmEJyulmqZ0/qmBATADWmK9hWS4ZhcTzo5YDPBYPhvSMYE5RdSfq2DzCLrVWft2U87uR2ZgYOkX23mNRJ8gvUVWILkh104MbcHT1f4S+8jx2qm9gpCKFMq6DbTm6mE6ax5Jd4R+MlyqHl67oEBA7L7uE5+2ezgS2KEnfsvxDG/jcgF3ScENtWW5S1Ne0Y/zd/EwS/UDSGTayKoIQ5apEmsOesZYsdApzMYxSRzt8xOPq+3cHrFvJ4tLrxeB3R1tQYRVGTLn8XTT/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(316002)(6916009)(107886003)(6512007)(86362001)(8676002)(66556008)(26005)(36756003)(66946007)(4326008)(66476007)(6506007)(83380400001)(508600001)(186003)(44832011)(5660300002)(8936002)(38100700002)(2906002)(6486002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Y73Qffyej7DNocmmv+yAlhddlS+z/8qWLjG9jTKVL1RUMyfZ+r09KJOoQ4m?=
 =?us-ascii?Q?isEoRg307xR8EeMzsBo0WXQ2qsH+eazYHHyaPvI18C3f0QYyG+GcM+WNiBYR?=
 =?us-ascii?Q?qVqRlVpj1vLMqJ1R1pHZvjljkf8nv1Qsj2QneNjMx6rbsfOi7i4TynFU37lu?=
 =?us-ascii?Q?kludmTn33oJY7VnecZX7HzfTLBNoqp8DjmkLgcs1sFLg5KBL83bl8zqNjeFg?=
 =?us-ascii?Q?1og4bdmyLV3XOGtWuAzPkn/ewPlgLOQFaUfnbzYsy/4qJd3lBtEsZP8BGeGz?=
 =?us-ascii?Q?yAo/h6n2x4sxRmRSSLIh0D60XS8KFrXzbpiCWjIc9D+CarOeAftfpoicJ7BU?=
 =?us-ascii?Q?mu8phdP4WscxXgy7VrIp0p6gZ7yAS7xVyHiC/gwFNLblucqfD1MHS0+GkaU7?=
 =?us-ascii?Q?k1OVuxyiG5eBZApt4pI+J3/3BE8ryOLX505w4/cpIAxbfpgCZ4uAJMxvJCJl?=
 =?us-ascii?Q?Pihh8PTmb+8NqhZGRB+y2kWF3kyVqZmeFPC8Ak8cwAqhriRnUN7lpKvdM4Kh?=
 =?us-ascii?Q?AqkABq7zxkfwkz0AeJl6xPFAZTWYtPT14sWorDO5Ll3fZgS6RBo7WNFc0eU6?=
 =?us-ascii?Q?Gm0dUkIkAMQItEOr9C1Z3WBs27Bk5da10LpGIwgFSNLtyJZMRhdTeyB/ofUb?=
 =?us-ascii?Q?OS8hTf210ZOHcq+5dOSxfFh3VxMuJST3ZiwXut2Ttv8cfcKJn+Qf7Iam3d6l?=
 =?us-ascii?Q?Zhe2I09OP3Ef+wjTvwZ3s5SclMVjoSuZgZ6T3sirvsX8ib41WP1Pi7fSIcx6?=
 =?us-ascii?Q?LWhVXyLusKqsSWdbx7ECowkBw2ScHBcD9INO0LD4fG4DUmGeipTzed6uTpbB?=
 =?us-ascii?Q?KwgIGimWVrL7EhQ8XdCEySR0BFDoFsbyZiZamS7YC1X20mcp/qnCN2AhSANk?=
 =?us-ascii?Q?zaRdAbJb13fntTPXCAFPy3E0IdMFKHfQqk8HU5QykK0H1BaICrgOxyaR8v2V?=
 =?us-ascii?Q?jojZs26pNkkBV6wbLrxbePY0KcX4dSw8iiM5EcaAyd7wr+rjOZJlBzqISpAm?=
 =?us-ascii?Q?HDaPl5wXQjk4NADCKXK/Jx9CVah7xAe8H2XwzW/JoSicZhyVh+gulnc+/o97?=
 =?us-ascii?Q?9mM+GekUn6oxUkb4cVboALGaF/kNfmGbB9O0ytWoeSax7sfcWPm/m/uhMSL4?=
 =?us-ascii?Q?pv450Sd1Gq7DQ0v5in1LB38PcSfuO4UFcM7GCXiGSdqNSGXV5wlirqFPTAJC?=
 =?us-ascii?Q?pi2hM7+YM06KZO7O6mRFwwxDPwBw4v3gwsLJTgc8WBb5xKBICnUb89sHW8Mw?=
 =?us-ascii?Q?audNmxnj2brA2r5zslge6yMZveub7nY1ThCtigGLtg0saRZSrVfVpetql0Co?=
 =?us-ascii?Q?AXXIyBYquzmUlPsHNS+rFj3AE5r0sPzixZRbpR05TAvtaKYCvWvo7sM86zAi?=
 =?us-ascii?Q?lZIYsHv8wPuhAAA4hQc1eJoBxd3UVtrdSFSqTziZdv34hIp9aE467lRHOs36?=
 =?us-ascii?Q?s6gyj7vQuiOmFmcU+f4qd6MskFNe17v7Fd2ztIgt2uizUG/merIzUTlLIUqs?=
 =?us-ascii?Q?jeU9zdDztYMWQfc0RrdexOIx02F+8DnLD5goVKlXql9tcLbkbXx+OgANhnU2?=
 =?us-ascii?Q?jAzo3gxTDh5Pj1PtVGy2ceqcTAYuGCQ69axCww55uuyCIWi6eSgaRkHztwDk?=
 =?us-ascii?Q?vJ/00bLV3oy59c4Gn3ewbsKqCVSzdYWtJj82w0tPzL6XhN2qsEy12zRRLV0S?=
 =?us-ascii?Q?FQYVX66EEGI9XP58P/TTvLjsryGu1TU4Z06qGZENvB86rsXEmztniXEbp8+a?=
 =?us-ascii?Q?Vmu8HKnSCYcCIBi2wWXUksV/Z3HTBBE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f2d650-c4b8-45b0-b383-08da353f5f77
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2022 00:19:12.9113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XzQiMvpQFNOmPar2NHr7vT3fJDLnXZUA4dbnj4J2eJ9LpDpA8QU1C2F8cmOAtFdWFEXiOC/EWNG1KfePFVmxrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5579

This code using ASSERT_* instead of CHECK_FAIL should be
squashed into patch #3, it shouldn't be in patch #4.

Squash to "[mptcp-next,v2,03/14] selftests/bpf: add MPTCP
test base" in "update bpf patches on export branch" series.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index cb0389ca8690..301f19375811 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -103,25 +103,25 @@ void test_base(void)
 	int server_fd, cgroup_fd;
=20
 	cgroup_fd =3D test__join_cgroup("/mptcp");
-	if (CHECK_FAIL(cgroup_fd < 0))
+	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
 		return;
=20
 	/* without MPTCP */
 	server_fd =3D start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
-	if (CHECK_FAIL(server_fd < 0))
+	if (!ASSERT_GE(server_fd, 0, "start_server"))
 		goto with_mptcp;
=20
-	CHECK_FAIL(run_test(cgroup_fd, server_fd, false));
+	ASSERT_OK(run_test(cgroup_fd, server_fd, false), "run_test tcp");
=20
 	close(server_fd);
=20
 with_mptcp:
 	/* with MPTCP */
 	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
-	if (CHECK_FAIL(server_fd < 0))
+	if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
 		goto close_cgroup_fd;
=20
-	CHECK_FAIL(run_test(cgroup_fd, server_fd, true));
+	ASSERT_OK(run_test(cgroup_fd, server_fd, true), "run_test mptcp");
=20
 	close(server_fd);
=20
--=20
2.34.1

