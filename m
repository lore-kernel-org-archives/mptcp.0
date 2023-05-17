Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D3F11190
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 22:30:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+Hlc8gZjrDLOJ4DcHzJ37W/kQHcspzdqdXn6ZmisZuo1wZS2PGqrIVhmLvOPnxpqu6hBguQY+jv5F4QpjXyvntKpYVpPi6agS7AcRczbvESMQwsnpYlM8piLIm6RZ0txUodvxba/k65laecCsJWew+OF31FXuj4yzW5i/8Yrgjw4ApwoKXANg04hu7sJgaWZRCIdhlUQyMvrku/rkrG9GdyF59/i9KjsjUCMB4n1idZT4tWSPOl3VJ0L48xe+Cilut5vzPmlF9oAIzPdNzMGkKEsAvs8gsWSQNj1Kq7joy+9t+SzdlwgjLdDLNXHEu+sPrw3X1TcoZjuKX9GHTS4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9gtDAZMiGQZ6npo1/1zHwUkp067gbu18iHIzeIXGoA=;
 b=j3qJcuY5YHRs7EOSDiGZYeS0WKT7WbYOpIzdhOBNKRz+v7X+H3muoKBo0FnT2oK0jlYXmS5ofoO4p7zZFc5ImtuvuLZO1eCylA7xReTgmEpvcVpO6zfSVqVPEXbIoyuD6T4s7LBHP1GN+COLOd2h/ZPNy9EJLa87lCOyBHau0e//snwPT8NmmgggmPf42rl0FVBwp3lA0tZQw3jk7Kt6SqqXd+lpr67XQr44Ok7oNRIHOSIzVrFTXWWIwsgYBOXhKSUVeELUXbKlDWYja3pfd6/7px1ABgR+BuF56/IGsCiy7N1nnGcQockbv+Zj2qfqtXXfiGPJ6IqQH8LkY/Kj8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9gtDAZMiGQZ6npo1/1zHwUkp067gbu18iHIzeIXGoA=;
 b=C1cqdaBoMfRvW87eSioRPYWA7WHznJxs0qac/q+8YzJPKYo1ePKMxx8i39wgXgFiUe/NkvXQP32ve8BGXNErNybcRk5hcS4VyT969r0zz+XnH36fMrrMhhcbZVvqGJLozfKXTSVAyKO2Se145C8DW+QhZRa5PSoQWP39YBVOByjt48yL2sqFcnJMqzbSESXxidRSkrvsZs04VszKZozIDnrgDiAgXfjBPUeoyEDwiR1ihSHrrJAyoLzEhyjf+h5sTByq2jqcJNRQAsvImhZ/Y3leQbB6m16xCIt7l8b08zEc4zZ0W/yv3cwl7/CUOCMo6ZwKK1yVb+wFVlY8SMNHBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7675.eurprd04.prod.outlook.com (2603:10a6:10:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 17 May
 2023 22:30:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Wed, 17 May 2023
 22:30:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 3/6] Squash to "selftests/bpf: Add bpf_first test"
Date: Thu, 18 May 2023 06:29:39 +0800
Message-Id: <015d62d94ededcf2b4fa7049dbc788ec39bd7d7a.1684362296.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1684362296.git.geliang.tang@suse.com>
References: <cover.1684362296.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::21)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 83572118-d6d2-4885-b8f9-08db57264a69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aKCn97Wy/TOo6ynaVb1dqnXk/wTf2AY5IPz9kZOKGozRnxoPMHI+8tTVpg1E+Vgf+faTxEkrjKr81iV8se0mGXRc8Ss3v1FjJxNXkMXm/7Ovi0GSCYhckD/kmwLQ49tJa3TGLKVl7kaGDjBrF9tKSpIhIgYVU0Pjp+dueNt1n/1S8TQ5EfFCqGhGEQaf8W9+1tyKWlPzfTV+nofn3d1mOKduAduFaNY92Jz07ftV8SwCvFasnYUBhy6byXerL3qdI1CBhMj8Vl9GhrK/ZxilmR0uVS7G1xskL8/lRrspNxnNidWrg19QIfGc904QdBPzO7yOiib5sBAx1wbo9JPkDlyW+XLDXvRLbze38UUB+WcLAJw2E2Q3+DVXHv42R635vwZux2vMc7idLvx7zHMXSHuHwN41CxAHj8H6PNQcy4i3xeg0mvS9NEptkLF+xjXje3biwk83NgR+CfCH+ns10Euz1oqbDODhZ0EFhQkeLn4NhT5nMiInetNA8u3k1hawOueR6/VoSNvI3ljJggr7XrS2o2i5SMKpaX4zYZpUaNn3bnRABTvL9S6wKbIgWYCs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199021)(86362001)(38100700002)(36756003)(316002)(2906002)(5660300002)(6916009)(8936002)(6512007)(8676002)(186003)(6506007)(478600001)(66946007)(26005)(107886003)(44832011)(66476007)(66556008)(2616005)(41300700001)(83380400001)(4326008)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eG+Aw9hpN9uFU27II5sqJWSmJ3RJfobEVP1yyr7qCOVj3m+IO7i3GMHOumTr?=
 =?us-ascii?Q?rBgQLyhNTzYzWsBGuxmtc1ZNNKxmWKFFVZ0lSAytTTncmoDLZhMojUu+jW23?=
 =?us-ascii?Q?rjegKfV11YLDc1fbqXPvbK8qtLOAZn/iZhytg4J43NJRDFUkf4tD88AcLApw?=
 =?us-ascii?Q?OiIIbc/lidNUVsAayzF94OhB69AyG+V/v4L9Tib+w7aft1EXQylUMUEJ7N8H?=
 =?us-ascii?Q?O31uM937mGkMKSHqu+zdo+9NGuSvLsrq5HuZnw4Heidg95SPID20nTuecErn?=
 =?us-ascii?Q?fhngOiiyu+ipj6B2c7sMW2noVE70IL+D7U7JFbhr+KUBovSaxYje1j86vyFu?=
 =?us-ascii?Q?Y70Fh21xvFnDI6wOsUAG7W+D2MadgaaIIATGeifDAZid9q6kz20/TmCZ/a7b?=
 =?us-ascii?Q?CmOx3RzfHXXEJKbEBRkBimtBRc0mHnWoWF65xfi3mQlsso1+ZOVIGOsqmHac?=
 =?us-ascii?Q?+Bh7EkqW4ODgPjiFbdMFnJrQ8JbE4W92TimZuik3yOZfr6v6JzDOBgEVFKEF?=
 =?us-ascii?Q?4GrHfBfcqEU+/JG7NKLHjaiQVHtiXESoODrrXpSRyoj91Pd/qzq0jxAYXtSZ?=
 =?us-ascii?Q?O23CVEf5fLQbccNEMHIM359UP854aRnCbJuRDEgVKZMRZ3gxGCYYfhkIdmkm?=
 =?us-ascii?Q?mRjRJukmWq8wfI33/+DAaVZmBSwWKM7aVAhGaO/Txx2BoK1pbogsYCWl6GW8?=
 =?us-ascii?Q?J2hJMjMSFtZzeAmxLgHAkZ9JAv0+GPCi66fSyC1lDdeQD+RYVZUb7Y0Z3sUu?=
 =?us-ascii?Q?XCCJM7QGLgc62DJxs4GcQ27169JhbvFFEVgKw85LSG65HGo8M1s67x4ajfes?=
 =?us-ascii?Q?8Nhz9bNr04GgYnKgm4higiboXWLPqyloo2J78gpT6hehc7W89iCWMYD0PKT8?=
 =?us-ascii?Q?HrB2zFCJ3vEfForfa6wyy09pGXgP5sOoa5i0OYcTeIMpOCHmoidyFv6ld3m6?=
 =?us-ascii?Q?p/q/VGhEj+AIqyAP1vB1ZZpDWwAMqmpw9rdZu73rHB2eZJc+t3LMRbrUvbiu?=
 =?us-ascii?Q?d2hevDSgBNZ1u7uTBGvtYEzWEIehtJvsl5wvk1k4sE1Bs3JiE9htANR1n5u2?=
 =?us-ascii?Q?SphhI1+hGy4iiCZ1q9SjG+fkN+qzDHdzsB5X44XTyBBpWK3gOVMCklV3E4CV?=
 =?us-ascii?Q?2IYprVz8vN8oaNru08DU7FHZVyoDaJbq2uoJB2EAIJ02sCkIRDr4Yzr9j4ID?=
 =?us-ascii?Q?vK1TA7LZ0O3jIfBVJedNfS8Ej/IWkY6tKDeIuQry6eyvV1anIxueIVwqhxGe?=
 =?us-ascii?Q?wJbmd+LhjhZqoL+wuJpZK887e/tpmAFVI41onki3zqzQcO2mZ4qHWYs/ZfsF?=
 =?us-ascii?Q?1MVfR7dyeRM4jzs/RzKErj9ekuBaoYqUpdAdc/hhBpWXqhf3qun8ra1mHl6T?=
 =?us-ascii?Q?NrPLonJgBuRzqDO+qWhSpXzx3QZBxl84j+DmbU5wpzZdCaTqidt0y90UvVw+?=
 =?us-ascii?Q?jz/G3G9+7YY3IZZKiGCAClGrmS7QhyI4fyxRy824ff0Y4YQmLuoEJdb4yJtr?=
 =?us-ascii?Q?E4ru/J5dLZNd7cu/DHBPrczMfQdx4yMmth1vUKXLUpXe94oB8QQEGZ7GmB86?=
 =?us-ascii?Q?S/NmcnT/DZrej4p7GWRlc/8WMviA6rahEf888UEX?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83572118-d6d2-4885-b8f9-08db57264a69
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 22:30:17.5429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gt0FxwE94fgGwg5AsWjTg/WOCheDNyeLuuwou9ezSoXfH6l2ase9tVvY12gmdbi73JIzJG/RH8y1HVKUteZ9DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7675

Run mptcp sched test in a dedicated netns.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 51 ++++++++++---------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index ce9dc3ef3d40..85e37e0f64a3 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -285,36 +285,33 @@ static void send_data(int lfd, int fd)
 #define ADDR_1	"10.0.1.1"
 #define ADDR_2	"10.0.1.2"
 
-static void sched_init(char *flags, char *sched)
+static struct nstoken *sched_init(char *flags, char *sched)
 {
-	char cmd[64];
-
-	system("ip link add veth1 type veth peer name veth2");
-	snprintf(cmd, sizeof(cmd), "ip addr add %s/24 dev veth1", ADDR_1);
-	system(cmd);
-	system("ip link set veth1 up");
-	snprintf(cmd, sizeof(cmd), "ip addr add %s/24 dev veth2", ADDR_2);
-	system(cmd);
-	system("ip link set veth2 up");
-
-	snprintf(cmd, sizeof(cmd), "ip mptcp endpoint add %s %s", ADDR_2, flags);
-	system(cmd);
-	snprintf(cmd, sizeof(cmd), "sysctl -qw net.mptcp.scheduler=%s", sched);
-	system(cmd);
-}
+	struct nstoken *nstoken;
 
-static void sched_cleanup(void)
-{
-	system("sysctl -qw net.mptcp.scheduler=default");
-	system("ip mptcp endpoint flush");
-	system("ip link del veth1");
+	nstoken = create_netns();
+	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
+		goto fail;
+
+	SYS(fail, "ip -net %s link add veth1 type veth peer name veth2", NS_TEST);
+	SYS(fail, "ip -net %s addr add %s/24 dev veth1", NS_TEST, ADDR_1);
+	SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
+	SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
+	SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
+	SYS(fail, "ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags);
+	SYS(fail, "ip netns exec %s sysctl -qw net.mptcp.scheduler=%s", NS_TEST, sched);
+
+	return nstoken;
+fail:
+	return NULL;
 }
 
 static int has_bytes_sent(char *addr)
 {
-	char cmd[64];
+	char cmd[128];
 
-	snprintf(cmd, sizeof(cmd), "ss -it dst %s | grep -q 'bytes_sent:'", addr);
+	snprintf(cmd, sizeof(cmd), "ip netns exec %s ss -it dst %s | grep -q bytes_sent:",
+		 NS_TEST, addr);
 	return system(cmd);
 }
 
@@ -322,6 +319,7 @@ static void test_first(void)
 {
 	struct mptcp_bpf_first *first_skel;
 	int server_fd, client_fd;
+	struct nstoken *nstoken;
 	struct bpf_link *link;
 
 	first_skel = mptcp_bpf_first__open_and_load();
@@ -334,7 +332,9 @@ static void test_first(void)
 		return;
 	}
 
-	sched_init("subflow", "bpf_first");
+	nstoken = sched_init("subflow", "bpf_first");
+	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_first"))
+		goto fail;
 	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
 	client_fd = connect_to_fd(server_fd, 0);
 
@@ -344,7 +344,8 @@ static void test_first(void)
 
 	close(client_fd);
 	close(server_fd);
-	sched_cleanup();
+fail:
+	cleanup_netns(nstoken);
 	bpf_link__destroy(link);
 	mptcp_bpf_first__destroy(first_skel);
 }
-- 
2.35.3

