Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2042.outbound.protection.outlook.com [40.107.247.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D38211190
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 22:30:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJo7N7JIR0qneDs0C9ahTjjxL1o+TNWGBEVI+ClZ5/XdZkfkdqTuxELDLZSt2bCNSmDO3HPRyol/Kfur4tHIyz3SJyJEPNvTrYRIzu/8gHCcGfcajXOVKE6edyE8nl1hEDJ7yQW7XFicvSzDTzC0kXCSOvWUy4Y20btVcg2RhRFlZtLJZiz+2PdUkLIHRKyfOfdHVsUFyi22iLqdRhahIi+Uh21vPaBzcyZ0zm3H+6H0A9ekKXMm7I5jUR092gJ/fwk909Wj3oaoND+2T0otjiFdTdpj4MiqdYkUqZFXUHH3ScV8nzRS1mjvFIlKRpFDe9xz0wdqJnwhLqq7fRFHmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kol6ZS1sHzyuZk8o3p2znIegxMWQVSEFtY4soGlFjYg=;
 b=Rkj2FqIJYq4ry8t0sxicQzM3hVqPfLVclIchUyldjXtR0OJNu366UKj4ftmZQtxFPVE1BoQoyIE9lTRR6LghlqwqL0lfkvSe9nbIic8w4r54LbAQDzKmhApwRIXa7OdilmphzC3xuW0v65LdDc3ejXyIETmMPihf+juW/2jqG/xtqkns0IEO7BVkkdWYeZ6iA/acYBJ9wd8knfhgFR27HQqE6sc5R6wHDx3dSR9utLlfpJB23ahkfcMprSSpQQjQelzZ1vJxpQicWXiUM8gHKHOD3fMgY8Nl3ray0Gm4zFFlOjfD357sZpPPyukxQY6W6CgD9+FhF1WPQEbfiI8fgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kol6ZS1sHzyuZk8o3p2znIegxMWQVSEFtY4soGlFjYg=;
 b=0rbAn9+DBEOd9dcVgZDnwh6FYpWz9Ck+TVsvPq6vh7DuGqRk3REzoXmturOUgn/TKWj0QegoGFcX/ISIBhtlwhW67AeWrdSH3PEi68QMkfvmS7HKxm5qKWCWJrQmk+PmzAVOuuB/51VOgWWfDPfai1XAYqD8BaDIQgH8v3offtZNXhtx769EA8cQWi/5s33L8iRs+9HJOWU8Qsf5MtZyyOr1ueJ5sphUubvRU9AtiOtXn5FbJFAczcgzx4YYa9fj7tkyJMez0GS9yt6eWSkpMWhxYHGA2v/WoA/8GUU2Q2dI9YhdEfrb9MwlNEk6E+nKaeCX4pGijs0SA2M6lxdoyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7675.eurprd04.prod.outlook.com (2603:10a6:10:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 17 May
 2023 22:30:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Wed, 17 May 2023
 22:30:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 5/6] Squash to "selftests/bpf: Add bpf_rr test"
Date: Thu, 18 May 2023 06:29:41 +0800
Message-Id: <d9e5a3380e0757f2348415051effbf851154e3e2.1684362296.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684362296.git.geliang.tang@suse.com>
References: <cover.1684362296.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 850ed2d3-113e-4a7d-0db1-08db57265476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MRYHvp8utNA/+oDVcSLrVmiQmiqC7wxGSqJSyEBv/hiOcpTJOAoVFcsFj9EhJA6bBUdNhSs0jVV/zXdI6mPuHAndrAWia+XALDSZ8bBMOFocITbGMAVOQnrJCcqNckldSxfVVka3VjSJ2KQFPh0bckXPaF9bXSlwX9Sy79R5qExqGLiNCKrspL/aRr/5r1qTNg0KKVsRctWOAMXtYMtBK0uk6ZoM4VIyTfI8BABMNHnR6/9plHikSgV+5yqIlrCltnJf7O+ugA8LdQ5xkoTva0MAPMKJlY5V/vM2l2PSKWBt0op/MTPMpzvJyPKra8YcDITVqN1cGTWjIA0wWaKZGcfkXsqxTZPBhxWoVLjqW3YXXuH1FwM2DckE3j5HQIGB6Xzl+kN18CVuHhwelmZKHXjYezGSIX1gfRaddCeA8ZdewNXk+h2iah1tOZ4T1PzezMC/U754eBRXhT5if1mb0RrpXAFbHB6tmfCxMfXBsap97DB2qHPio3YNGCcMUeTKPI8ybVkYUJjq9NuHYFy03iSP2JX8EaAJNTVusmDWsknLm2/NOnnU9XPAfJrOrbeB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199021)(86362001)(38100700002)(36756003)(316002)(2906002)(5660300002)(6916009)(8936002)(6512007)(8676002)(186003)(6506007)(478600001)(66946007)(26005)(107886003)(44832011)(66476007)(66556008)(2616005)(41300700001)(83380400001)(4326008)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3yeOSalkROhTcZ0PriyIQ0vbvHK58rjx4GPw5z4gi6mSujAicUGlTBwb3TQl?=
 =?us-ascii?Q?TYUq11BdJCRF6jvA2eTovSaeGaIQLD4yfLfpe0fgjU8BWxxih8gacaT3YcT7?=
 =?us-ascii?Q?jCazgCnQOhLVruxkZLKqC10kIJ3YzbDEWzi93U0P3Wd0nJJEd/ALlwJ1dNWo?=
 =?us-ascii?Q?rWKjZcWJW24Hqd/Rw4rt4F3fWKjbytr6bE5bzn9reHg8pwD+ZE/nDfDGQlW9?=
 =?us-ascii?Q?UTfY/uHTONjja+kWIKZ0iHoCko1zQGdyCYbRl4tr3aVArO4aP2Qmlyya1Hq3?=
 =?us-ascii?Q?83Xa0XPqYU0e6R+XfjJEd3r4eIYLMYxQCMCRj1S03narWugpfHCSW1SYUnKc?=
 =?us-ascii?Q?grfkyMRSY72+Tg9UpLmAxF+k5ibN293uE/ukKXPzMqhhYNGOxJ6hyIa+PNs0?=
 =?us-ascii?Q?SbPIdj2KuUEAL4cheDwhY0+dKtjJ/I3cdutlRXQ5WF/2DTM6MqjP3gx+aJBD?=
 =?us-ascii?Q?+CqtIT0bKMZns9w16BHLViNUavXnbnC0cNTwmNm873ZC/HGRRRzjpJmlN+BW?=
 =?us-ascii?Q?GMio11h2glcA0O/TABcDMIsS0U+5ASaB4+ucPGd0OS2cODNTdc+wm/7rZSSV?=
 =?us-ascii?Q?cZLZru/2ifZgK5NC9m6V6B5hsztKcxKd7fiYPqxKK5hBcWM6aZdsYWa0TkBk?=
 =?us-ascii?Q?x0nUCBAmWngWMEPZ95v6PbFoAi8n/1ZOasIJn/S55PxXMv65EbZ8gKJahzVi?=
 =?us-ascii?Q?MaWo+sWStsdn1mwOoGMhKIwFchKbEPKPgIUC7qpgC9GZ55UmIzAMZwNMfIuX?=
 =?us-ascii?Q?zGzb6mvZMwuaBZiEJ5r8D+++z3h4+Xwy+HSpO435uhgPL4R9AE4/RekMyTjY?=
 =?us-ascii?Q?mmyAkoCNR+kX5a4Q7pqsraWt+GhOsz+2IFiMwLHtw9/Q0Mw9Fj5zlh7HgZZk?=
 =?us-ascii?Q?NWGExx6zos9s5/jyyJ63Kc2wtylAUiUWGVuNmQQhvMR5ePy7m8XP15Ut99uM?=
 =?us-ascii?Q?2hueROW45xtoqBnjJEpmfksqQ+ET4TtzhzzejSntJ47mSxeI0LPUZajMNGTA?=
 =?us-ascii?Q?THN3+4mI7FSuVMDL/HGOgBcejfZQgH78q1EzFhiY0w2fJ+SH1FJf1cxOO02p?=
 =?us-ascii?Q?MFdKBE9dnuaZhol/avGFNbZ0mCl/5oI2lAOz/ADCNXqgPTSVhFEYu+h3lNus?=
 =?us-ascii?Q?/ItBCWoN2Tc48sxopBu+UdHMYikGZJvimhfUteWT04f/IjjJoHxL9cK5iAiq?=
 =?us-ascii?Q?r9AvwJfzE17HBOkmKXO3Uj5v0EUcWWl58C1I/XiGypR31pZ3syKNMibnLNHQ?=
 =?us-ascii?Q?GjgZH8Y2ds3UPCPHfu8IMpvRVEt+a1uwKjtLu55uy8Ua3NbHtntTRkhMD/JB?=
 =?us-ascii?Q?RSOAevNG0oWidaSxXSuW/p7nVg6Ffqs33GF4p7m7QyghjQA1cqEpTODlTar6?=
 =?us-ascii?Q?7dH2KOjkMB/BCvpn51p9d38tRNeFQvMWHPCVpQ1qL2TykWDCFP4jOnGVPP15?=
 =?us-ascii?Q?ZUGzrdPOT9gs9B1CaMNoOWMkgkJBSs8GQvFP8pFB1l7eDDs8nv2dA3HJh4Qb?=
 =?us-ascii?Q?6FW1tZWo8fhcUg+XkCLoT5b09BzgbdZG38ff1emm+Lw7hosGz9FoZqE4lgfB?=
 =?us-ascii?Q?FZkwbgLA0ADGqWnXyIJL/knqo/kjn+SS0tZpqyQe?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 850ed2d3-113e-4a7d-0db1-08db57265476
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 22:30:34.2302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wDTWxZKN0XSfRSCkt1H2JDzwA5a+1KUlV9AQt84vSVzNNFLwBuAtuzgAdh9/nZxP4Zmgm0lCrAZVm3pd84n8nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7675

Run mptcp sched test in a dedicated netns.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 3d99b6a1aebf..13594084d095 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -389,6 +389,7 @@ static void test_rr(void)
 {
 	struct mptcp_bpf_rr *rr_skel;
 	int server_fd, client_fd;
+	struct nstoken *nstoken;
 	struct bpf_link *link;
 
 	rr_skel = mptcp_bpf_rr__open_and_load();
@@ -401,7 +402,9 @@ static void test_rr(void)
 		return;
 	}
 
-	sched_init("subflow", "bpf_rr");
+	nstoken = sched_init("subflow", "bpf_rr");
+	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_rr"))
+		goto fail;
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
@@ -411,7 +414,8 @@ static void test_rr(void)
 
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

