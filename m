Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2085.outbound.protection.outlook.com [40.107.15.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBE818B16
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 13:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCjG81Kd/kpW4GwdjNYD08hNVc1yS0iH83sjaH64LJUXZCG354LQGq+wkDIwKjxbbFXLWBk0nyWYkEcb21SK8nq8z56DTt4ho/uudGyHvK7jY3PRBxn7Q1tc++N4Ul11gS6ikcfsiUZUeglw8JsZj3wv3e2dXObRZY8YKy3k/RhOeU6CfjQSJicTt1+xw4X/WwxLr+rfYEjlGIqeT7zS8KyNwOiRzbRonwKDG2f4uij/uaUcUeP35Skp5nMreE5+dVKYCMqSx4Eb3UvUp7SClOzGcGt2gYqIwGQ/G/DVC2h9LcFk9PpUGn5UTS3fUgwJB+wL3fODfZeSNE+iSm7kDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7cU5o/eEbJ37j3M3s//dtRMxGczzatUur/3AhxzcEM=;
 b=jax3a4IfKzaFPE5W3oosUBhsjCl0yOjPzurH2hO2KiXz1u+a1gOHkyeUtcwcm5d5CGQARVInBK4mQdwhm5gL+Lk/LDzdmIHmtaxvfbxd01K/QdI8wRWoRhLLEFBHhEdmGulwU9A2WUSfDwI64hu/7nel1N9mSnpoHvFMeH8P+0biV17arxPt7Wf6c4oosqNbqYA7KPzeN+pddhMnlGnYGdviVM1VbiYxtT8WCwQVKWtUMGxT4QG+uHQpwcQzm26WOf5kyUfUO2KK41YIGlJDO+QdO2+jKP45ra165PgCe504CBgoxUBF8WGdUSfOM5WUO27JmkYkm014DbQHAbwZ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7cU5o/eEbJ37j3M3s//dtRMxGczzatUur/3AhxzcEM=;
 b=JEtEzruYPxeDj/DS7T0xou5dkvudDXaSBxIgzpCkdriJ7dgnpV52+++CuHBAhzO+ixuexVDugc8759dSR0DNrhxaO7TKVl8+4XaKoL/U1HTtkldWM1nRMMQKeWOfaB2hKjEzW81x9OvsnEGjNczFy4dISkrEBpcC5Q4gIWduWbycwAJUfl5PMvH2o/SvNKCN89BRTpLK+Jqw8H23efUmHjGoTpFzDMRon69T6+8gLca9ZdeIHNZowyTAAMjeaYMHYmMBTQLPCw70M3mOSK8luUi+ixMGWjBjQqrRrfhUxhu5646NusmJF3V9Vb52e9FBlYhv/3sV2Pae6g6ntUBaMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8836.eurprd04.prod.outlook.com (2603:10a6:20b:42f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 13:57:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Wed, 17 May 2023
 13:57:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 5/6] Squash to "selftests/bpf: Add bpf_rr test"
Date: Wed, 17 May 2023 21:57:13 +0800
Message-Id: <c4185c460f20695b085b9bf841e3e56c4cd0e167.1684331602.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684331602.git.geliang.tang@suse.com>
References: <cover.1684331602.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b123720-5666-4d27-8ee0-08db56deb87b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KXX8Ala9TdnT5ObqDYDouG5oCSC1g+svyPCv9k7r1hn0i/V2lQZ3X5dzwby4qAFd1jBORljgPcxqsfyhXg2u9z3nuVdG7JP3WrzEe7B6YX/gC1HZLtRVFohToPxmpkKs291b1BaAdtEaP8OsXmovn/eilLLwEkCzXGHUOKjBrc/jBf0j4C3FlhUl552GtZg9afV12rL4e9uDXs8z0q+sW7eOeYRHHbx3M5J6WA96Ar18H25LwhP87bj7h3fdV20H5DMJ8kDkHPNBSHabEuzUF0qyFtW/1n2Mo8WNDMut+1lv1NQvHyUE2UgTpRLLoMPyo8cqbSACjvBukEY4t0mosvo8VE3VhXoGR/NjEtmWllSnPydw7Zi1pDgcZYqzRFlb9WkMuYiiWAHabHdXUI3S/PqObi9wex+rPaRQnNKZE1hk3rL8VK1jUPA+Xm/7jjAtjOChZgwyy3ED7k83Z2H8qdOLa0VIeKHjk4lDw8X44aEOP4Swsb7PC6PmzrOW3kwbplwneIPS8mzdZSp9Chk4gK8i6jdnMJP2xO9w+IaX+2fPiWI5fhdIjNAQ8u8AbFM5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199021)(36756003)(316002)(6486002)(66946007)(6916009)(66556008)(4326008)(66476007)(86362001)(478600001)(8676002)(5660300002)(44832011)(6666004)(8936002)(2906002)(38100700002)(6512007)(6506007)(2616005)(186003)(107886003)(26005)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iewc3lAWqLF8pf9kgUqObQF/Uk3vkka7M/8S2HeCd3X6yaneR5VEKN3KPaSM?=
 =?us-ascii?Q?G9uWEyxj6HrD8CEShWdwLT8JD4U0dp3fLCK9GJ5mxbZ9SZZwd/B02Co3XChb?=
 =?us-ascii?Q?2d05c45T+xD93GWW+LK1Wzo4Wt6W3m5lvUIsTLP/09+Su++Czw0v1odEo9d5?=
 =?us-ascii?Q?sV9po76BSeRR0ALZ+1ZeXxZzYfp+asksseoRjVS+cio1BCK2YLRHxX3OvWtG?=
 =?us-ascii?Q?TvMDoDIPhUgkC9kuTU+2gjPbqNmsnIt8Q32Eo+ihePzFDT1O4vA/rOtbufun?=
 =?us-ascii?Q?zHamfYaUXHOTVYpVB9ATPePV9PdOJLxETZG8u9bwPolezD/ccfk1vWdswZWO?=
 =?us-ascii?Q?bYiO4dZwJ1usuLR/uMQJe6OS8SmfYheSc+xJyW9j/RNhz1O5VSdPo6gNwq5N?=
 =?us-ascii?Q?pyTqiQ/1uZ9XRTpnVcAlWo7bt+o5Oii9lmc3QxphYaYlXV/nVeCYI/LP+0Ni?=
 =?us-ascii?Q?KBkRyDxk0EBmyMoRoW5fna+JtVcYZ0081+eUAs/coNTCjKlFf9xO6DDQpq65?=
 =?us-ascii?Q?1fJyPcaJDIizH6hkyOjvwBLLYBPteiBTxZiM/WAPDrv9rl7Mdro/8nQ/Xvx7?=
 =?us-ascii?Q?r/mEYvHiEIIafzDF99OFej0nWvGiOpxW/7dgD/r01GEsTmsIFaUVYZgQb8sI?=
 =?us-ascii?Q?hXVjfaTcstM9J8FRPuvqId69hEc5SxO32VN0XAhr2Os1OFDGeBNMyPrbB+FG?=
 =?us-ascii?Q?DvT/SYEHoLrMw678g9kKvGjNmshQsqh7y0kmFl01upHtGHKk+jpQFMbResoJ?=
 =?us-ascii?Q?DXCCrbucQQGnjqW9NEVyK1uB3gfvYu2IemKiTtCPhmJ6aN9YZF2TTxgJ98QC?=
 =?us-ascii?Q?5QGaWmX3we4JumLcaiQkTI2NqJ3HBtwx7haI+6mjnELJ0DF/Vd7CTeVvqvvf?=
 =?us-ascii?Q?WWY+T6UMmGfLwC9x22yTMnCssSzaBM0WiuT3jjT0eCUsxNacV9LjzqbGIz2c?=
 =?us-ascii?Q?4QGA5PwumG+ZPouzxrPaSL/DUb5pnuCBlZcHNO1opx0CYHHE/quIvD6fgYUW?=
 =?us-ascii?Q?9BcSWd9qF8WYeT4mU6SF8QzqdTCAiMBWpm5IZbhNZTOLtC8MjTzdHb9lx6YF?=
 =?us-ascii?Q?q8P0i40s2RQQ2Z1b4+pDy0WiXNbTXtadKR43si/cYxuBxSVr7ZzgL6x/EgrM?=
 =?us-ascii?Q?96k+DI9hgAk0h6HmVjjyu6FDKqIeZyJEmIkQRYtYBlyvhgsa28oMR1Ivw+7G?=
 =?us-ascii?Q?5Q2kfbc1tvxlQd2lIjBHI4v6Zq4lkrB6vBxFMywN/axXwYFtFpFtmU9Lg5PO?=
 =?us-ascii?Q?hBDtJQGohuge6lHfiqrQV/XMvrKfOixeuyv5ttlu38l5Bvpb24ddpgltS5PS?=
 =?us-ascii?Q?ZGI9HwpxzeKqnB0/qqgqZByIolkXIXwuseVMrFAgPMPQLtfSIGwxyF2oTAGj?=
 =?us-ascii?Q?VjnLkadgIGDHF1T2m2iNYQuD3j3GfXyyuEHftS13vnx2NrYgh3x4igchlTY8?=
 =?us-ascii?Q?qbILsF1MJsZYV/7XS+cr7CaqezPEOqsnVdZ8Xt3HLSMUseiur2Ps9n/vMcx+?=
 =?us-ascii?Q?Kdvd6UdKyRGlBdGVotsASKQv6P9UZLZfB4D7+MiB6Oey7K3+3zOJBBTWUsjn?=
 =?us-ascii?Q?lRxh+4Wd7ZdGfbUeAucA1JVah+uky54mFMZlitkx?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b123720-5666-4d27-8ee0-08db56deb87b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 13:57:58.2549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FmDR0eEh4LjvaewGzoDGjQMP6cr7j4p6FkUeumyFsU2AWldNVbX4WeRY4lZgq1GygjL1Zsx6NR6jgVXVdDpJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8836

Run mptcp sched test in a dedicated netns.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 88bef3dff24e..912457da88eb 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -385,6 +385,7 @@ static void test_bkup(void)
 
 static void test_rr(void)
 {
+	struct nstoken *nstoken = NULL;
 	struct mptcp_bpf_rr *rr_skel;
 	int server_fd, client_fd;
 	struct bpf_link *link;
@@ -399,7 +400,9 @@ static void test_rr(void)
 		return;
 	}
 
-	sched_init("subflow", "bpf_rr");
+	nstoken = sched_init("subflow", "bpf_rr");
+	if (!ASSERT_OK_PTR(nstoken, "sched_init:rr"))
+		goto fail;
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
@@ -409,7 +412,8 @@ static void test_rr(void)
 
 	close(client_fd);
 	close(server_fd);
-	sched_cleanup();
+fail:
+	cleanup_netns(nstoken);
 	bpf_link__destroy(link);
 	mptcp_bpf_rr__destroy(rr_skel);
 }
-- 
2.35.3

