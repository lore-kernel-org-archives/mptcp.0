Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAE53D67
	for <mptcp@lists.linux.dev>; Sat,  1 Jul 2023 12:57:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceZaaTTJXjlwnOtvC3oLqVzENiaevWL8xMxnj+qJR4ARt81lZ4NgEfPZ6TXee3cs9EUyv2hU+0pnTeatMz9zbr6ZUGyauFlqD/wQCFLGnbjvN9dBzfsfY8QMKO70ZcNGIdwCDFmaDSNbonPq64ga1DXuI06VlxLPkIM8dOw/wEzsHx2ucQ9EOgP/JxQnsmU9BSvOCdUgrSkEylsZsRVd/Idkw8xoUvNtvp6JihPxpF0IZonIrihN6qcPI6Ok82ceNzkHD93vIndfDLZt6ul7qJ76Vp+1y/PRQ4XKMOZp8ml1a4P0DY1JyTArP2z+ge1HvVjg7IqZRrq5VOCz2vW7sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VObWVx7lM52bt2nA8f8h0h8GlYb273mMIi2tyP5Rut4=;
 b=gMQEIil0tL+QZ0Am/PREDK8S+8721EmehYezdCoieCSqu5vcXjP56Fe+wTHt2gnCsnmfj0Jq46PB3/yIDM2rcENcp5dhAIe6Ht1jTA7I8RmCZufrh2+0ByrEd+4ajAdVrDz60hmpzZ6PXvF5ksi3UNXlJnB9sUTPcy9pOH3v8cHQBKNBEMTbAkDOr8O3hVO7BVnd6rzryL0WyTjoUu1MCz1TXvTf0utT/kuS7+8cKgf7yPUB2OEJcfCfQORO6V3dgZzSv+x9HKaEDX+/w0I/AmoknpCZ9jDu4aoeQV/E9RGjpF73NLSP/s4hCm2hJcxkR40+HKj36gwx7TFJT8wcIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VObWVx7lM52bt2nA8f8h0h8GlYb273mMIi2tyP5Rut4=;
 b=Q4p4CuOGk8iZV7VYGRBNY+3xJ4Hb20s68cxUjUAiUGyfJieuw9NZbTIWFGxGxxCS44VZIM7z2OdNVJfHfvFovenB9n7YVjeL1S3ud5fpl4cNhigQHKSevXM32hUQDOmge7q52j+N2tVW2bvxqGnu1qAJ66v1D/TuOe8MVW0uawXlGqjipjrHJdWEpuNOUQpHDqbtgeqQAMVB0KYCSSoxC9crCsCAk4lz11ocfxZ99evbvL2nI4Et8kFPoZsRMUQshmw0gxGjDebBVraMAjsv8jLGrjiNQCONuf1lNX4Ev9k616mJ8OjPAcooVl5Zd4cFTI4WUah4e226/xEOyBelbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7553.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Sat, 1 Jul
 2023 12:57:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6544.019; Sat, 1 Jul 2023
 12:57:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 1/4] Squash to "selftests/bpf: add two mptcp netns helpers"
Date: Sat,  1 Jul 2023 20:56:57 +0800
Message-Id: <1ce0da8fa8beb7277c15ea3aea4393d7413b66c3.1688215769.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688215769.git.geliang.tang@suse.com>
References: <cover.1688215769.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0002.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d621452-f842-4c97-9082-08db7a32b5ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AkyX8BiHEbeZgKg/nqa9feOV57pnfJ1Ya0FooPwwAdE43svMjZBVlRjTLopXoNEju9Z82HDRZEXuGx5f8H62zxLowZPmWa3z0ELXmafHkWg9TgH3u05alOx3tZW4K3ldxl6pfyYG/dxltvctDwuPl+l7Oro+leROH8+mZvSTMmogt0VQqkZhFUsOY2mVEMWsFWwSPeAwz+Vc/g0K68XMv0HvQI1svHZ5nrv1OarCbUgIY7f+qIuL3QKybHfGIuxIn7cC0UWtRRVtnGBdKLffp2QktZLLvnVmEDjsne+N+gDSoiNz/uwuPkCU+G+DYuCG6KSKR2J1ssFcHQaYBMXsynDwPP23uKt4uRU9WySApTZ61D2Y/GdL5fQUON0Uv9xuuG4613ihsglwRInw05v+zEQJQybWuLRpZ2zYr+k72VfGXkhWHnsdACO0AIJIF/llM3XJ45vI4BwSTXZ/AQ0jKnIRsgP9bh9QdKDgpZwfKr34Cg0CyQCL4FBrTOkHAWG3n32OiR4bXdKHH0NwuM8kE1LZjm7KufdzeMjH5/WVtOmVlv3KWhnVx8dU2s5+3aAI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199021)(5660300002)(8676002)(8936002)(107886003)(36756003)(478600001)(6916009)(4326008)(6666004)(6486002)(66476007)(66556008)(66946007)(316002)(6512007)(41300700001)(38100700002)(44832011)(186003)(2616005)(6506007)(26005)(83380400001)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MROa+Kr38MwV8ohivSbBFeOvA8JB3u55pwp/UqJgoCRPP5eDiIe6NKth46fB?=
 =?us-ascii?Q?TUCcRKmAeOs6o1wDuwD0tKIhP/f8PZDpCFhRQxollJkg1+v1dNPSQ/Ah5hEf?=
 =?us-ascii?Q?evlNxUcssXVT3PVvjK6zuAiee02+fTasw4e2W4XqqwIpZ1WbUKZsvAHlTKw2?=
 =?us-ascii?Q?3U7EJThr2ng1c1ia4v0FcF5ZbipYrh9GaTKfe7zwAl9Ytjcwkn73Omla3s3y?=
 =?us-ascii?Q?kKP45EkGUkbqcNB3FLjPcJUgCeS/LZ6rmdhc8aXLKc8BKuZpJaSGsiL/Spli?=
 =?us-ascii?Q?5iKq7YYDMx8MakCB4xo8eOjZoiGjfoLPP/1URYNz24PH3tHXKUYQMqAD6v5Q?=
 =?us-ascii?Q?XHOyj8d/OGj3Y2lBssW84jwblGI6oN9SeV648fmMEj5YYFzPG99hhlhI+bNp?=
 =?us-ascii?Q?M4P9wcfuOgRa4Ct0rMaDCgb8/LuILs+cZRKJIXJzGr2Ns6Zru1D+nVzMmx+j?=
 =?us-ascii?Q?DTzlcwbvHUx/c3BWkDYi+lczwzzXCPEmpj3Sm8o/Ya4kfcjNJmy84t6q9d1N?=
 =?us-ascii?Q?JMtveNgWssrw5c/gzJ5AHTH6vC8pYfP/xVn4dh3NkghWT5xnaAgUCn1NedfY?=
 =?us-ascii?Q?mnV8Ty4+p2ZQIDW7X1jXYSKmGN9osQ7mh1EQpypwSPgE1nRJOGLNsOXUATJj?=
 =?us-ascii?Q?JTy1fmdNQyuBB0PNsd/JYffQXxI7/SMxNQopDUv4z4XBV8LEHWGViuRAD6gX?=
 =?us-ascii?Q?5GxG4q4tGSyDQh7WacJGQgCCqJvu/p2ptZUguITz+30YlsrRKLCCokpWlau0?=
 =?us-ascii?Q?RDPWWWJveoZ/WDnWKvALzOplTcWx8NV6Gyg74XtYnXSCJ1528PaIC2Qb1MTQ?=
 =?us-ascii?Q?6dod+N0WR4XD3B7sIe4T32wPzn3w22K6J1UjwyynRdPalI10dMndysa6F0yo?=
 =?us-ascii?Q?VXF7PCI9qix31CM69VoqnmHDm6d2pveiogpZ9IYbwFhIsUKYTaBPmh8TMJSs?=
 =?us-ascii?Q?/OfMCv3qRq8C0Gs+h3TUA/fkUYOgUkFVKVF7LIyWy2LGex4+AT1jYisW4WNq?=
 =?us-ascii?Q?ARjj0g9pp63A69lS5ymlK+LtAiurFGM13WCKcWl4II1om7Et2NDQEXTlYIId?=
 =?us-ascii?Q?rxZ0gvIuLWCY3yqxBnKv4BWQvguY0x2BeQ56ng7bDTT3pbxQHPHuHrXUer+K?=
 =?us-ascii?Q?UZ4Vr2MX7+umwI26sxeAhb8ZS/O+aLQO0xDXWNWWbsYeB22oO3gdeLCVPXJx?=
 =?us-ascii?Q?16u+idTNyyUimq76dSzC/iNNHCa8ZQc8ra8gGr/eD1WThP/I86ozZc7w69eW?=
 =?us-ascii?Q?+L8HM9faMwJ/b0t7JibVAqfzBcpS5R00qDwHNL+VM5E8vJqgYG+nTyWQlKQT?=
 =?us-ascii?Q?XvzpBvB4rILhcDxikBGy0urv4jiIBqeZb8st4Mj4WAVLoujuLcQfMdVeU5QG?=
 =?us-ascii?Q?VAWCLNHraR60tFXvtDmToQxDYhHTANn3iZJyyFpc8TUQDcuHXXU1SmlQQipn?=
 =?us-ascii?Q?YjE8FYL6ZzmsVwZvO7NtBzB/NrZoZCCws2Z9MiuwXcNUSHEU6OF7dd/zVQiA?=
 =?us-ascii?Q?oVytrLF9Ikc+F1eQ2p2ksikcrwqPHt57vLOCjpP7KEGapaTp1i8oUtYduPXL?=
 =?us-ascii?Q?q8syYCHpFN+0tOlY8l0xyjC2iDWNmd7XbbxFx6aM?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d621452-f842-4c97-9082-08db7a32b5ce
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 12:57:22.1754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zi2MXG4injfcxwUjzNlpqxQGqwtl+NWq1a/zVaLR20nOaAA0vIlRL+hdz42q1yQCviXznb104mOKvzF69xFang==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7553

Move the helpers to the beginning.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 40 +++++++++----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index a968641cc94a..e430bebebcf0 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -26,6 +26,26 @@ struct mptcp_storage {
 	char ca_name[TCP_CA_NAME_MAX];
 };
 
+static struct nstoken *create_netns(void)
+{
+	srand(time(NULL));
+	snprintf(NS_TEST, sizeof(NS_TEST), "mptcp_ns_%d", rand());
+	SYS(fail, "ip netns add %s", NS_TEST);
+	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
+
+	return open_netns(NS_TEST);
+fail:
+	return NULL;
+}
+
+static void cleanup_netns(struct nstoken *nstoken)
+{
+	if (nstoken)
+		close_netns(nstoken);
+
+	SYS_NOFAIL("ip netns del %s &> /dev/null", NS_TEST);
+}
+
 static int verify_tsk(int map_fd, int client_fd)
 {
 	int err, cfd = client_fd;
@@ -142,26 +162,6 @@ static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
 	return err;
 }
 
-static struct nstoken *create_netns(void)
-{
-	srand(time(NULL));
-	snprintf(NS_TEST, sizeof(NS_TEST), "mptcp_ns_%d", rand());
-	SYS(fail, "ip netns add %s", NS_TEST);
-	SYS(fail, "ip -net %s link set dev lo up", NS_TEST);
-
-	return open_netns(NS_TEST);
-fail:
-	return NULL;
-}
-
-static void cleanup_netns(struct nstoken *nstoken)
-{
-	if (nstoken)
-		close_netns(nstoken);
-
-	SYS_NOFAIL("ip netns del %s &> /dev/null", NS_TEST);
-}
-
 static void test_base(void)
 {
 	struct nstoken *nstoken = NULL;
-- 
2.35.3

