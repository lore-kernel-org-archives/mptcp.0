Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FF32564
	for <mptcp@lists.linux.dev>; Fri,  8 Apr 2022 15:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649432588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x9PjuXmxx//rp3Sg1bxMtKi7svQtMfnWGsRK9tVAIhg=;
	b=dySledCNhEtuc+D2JsYsZYD1dYQlihLAhNYRXV9sgB3EEeHYyEMoRmXKsG7rwmuKehuECD
	h8QL2LFU06SQQl1Hzv14MecLwjWqzmUbplLHS/+NHAjCMPodIrnRaLZvvULI0shW0Y5FxM
	ivctGqIaGn1AZtMBIZHBw8BZ+JkR1KA=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2054.outbound.protection.outlook.com [104.47.0.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-Pj_HCG0TMZW7ZWbb9xHh7w-1; Fri, 08 Apr 2022 17:43:07 +0200
X-MC-Unique: Pj_HCG0TMZW7ZWbb9xHh7w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdyljVndLy+sQtzYkpRibs+jzqmmQ0ncUtTfhsddxRi2/CdOrt1tkixfrn8qFtbKkWmYF2cqEoH1zmMqD2EXOLTyCh3H9mOMjGyWQA9F+GPdTJmQCDkDf94cCwLKHzNJ5UWUFuUokWKIfoBkBRVOTMB6nlEeRR5jgP7os14/Btznh6uZhoIr5kR/qONKEzNptSU/4aYg1tB0BSyRsUGv10L/d0gWHQgZdNnGk1yPQzaL5MaX+8Aup2b+i3f82gjDst417SWri8BR8UZ4LINAcLqXCdkVNOchi4IxLOyPa0DXyhZ2xnrqqKdlnF/tr9/smSKl7Rq4wcOXWUpIGZKVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDnccN4Ej6cG02KY5kELgZn3ENNVMtxOEg3GeS2yTrk=;
 b=UUZoTiUzNZvtiKi3A6azG5TWsDr7vWZsSAAjmGf5hZgIYfLYrzkYX7Wm7M3aurDs7cylJctql7IGUljgc2GcViOye5+aWRVo7yx4I63p4jFpnZyM+EdxE0xMw3d+r7NiSxtsGPe+lTQbaZzzOUJBy2gX2Ey3SMw2xhNuYD+kAAO9+1cfPz1W3etkMfhRZXXtwHQ/Zg8plRHO1ecWqB/uTlf57VN8aZ+WCdbtXmsIyOgb+KFwCH7jIFeNvTaVx11F3aW5CMApUyXTuMuYO/h1Jy8cXi/gJDUUSFgfxq0r5X5ZuHMa9Z6SKlnStx34ZNMkch5VURTr5wYZUdiM9T6tNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB3957.eurprd04.prod.outlook.com (2603:10a6:209:40::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Fri, 8 Apr
 2022 15:43:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Fri, 8 Apr 2022
 15:43:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 4/4] selftests: bpf: add bpf_rr test
Date: Fri,  8 Apr 2022 23:42:35 +0800
Message-ID: <926fa0efd29f8cfa3d9ae15fa48a1f1228abbbdb.1649432434.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649432434.git.geliang.tang@suse.com>
References: <cover.1649432434.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TY2PR01CA0013.jpnprd01.prod.outlook.com
 (2603:1096:404:a::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80fedc16-2dbd-4e79-9093-08da19767852
X-MS-TrafficTypeDiagnostic: AM6PR04MB3957:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB3957C02AFD2FBD08E24954DAF8E99@AM6PR04MB3957.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FJQZCvQd6MaumuMBYxaakW/ISluEW2CP95g5urUPvzYHoZIRQi+hM2z1/tnGEnLy7fc3yFHwfA6jrmC+A0+SbUVABd7njbusO/1B4v3Kb6CNVFbbHFJnUgdxFZYaU+9HCvoFzgVicDKU3tWZEbERP1SQhTcObaH+/06QcUnDcQVfzNLaeDpeJ7Kjr8MEzlwljboFLQEcT6hg5Zce5i3PyqR5ZHmN8S/vMHjr41KhipnVzPElMHofgO0/1gQYsnUL1Lny5EKIhd47Ecp5mPw9VL6JyzBiFdN5XAYHaNBploK+58pXnm+h0n6qWGM9IsJHv/EuXmIB9cCFM9clI+1MI3rt0yxcUeyANVD4maskGHN5b3Qtmz7XjUK/C2qS8E7rDlj9f/qeMAPgaL+8YJwFQ6XNdHZBmTiL7g4m2CE/bm1Ze6s+v5yDRhCzJo9chfPPS9QdxzUk1AgfByX/i3WUFEWaxNU3VROtN7svW2K+bvP7qgdxLL/PHhB6nKUksPHYd3tSrW6BUPucCRRtY7Gy5Kh501qO/phntx8TFhzdHPAUnLFO4tgfrKsUXgok9O09BfQHIE0S+niqlUJDjiFpp04Yqp0qOF0WO43GdNQl7rkiM+HikiwHSzXJGV3t0FCxAGwGqD2yvVnNvm2PGLol/zjiuH5TURxyNV0AcXbd9YVkgt+gJeNytwK9xwAMK51L
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(6916009)(36756003)(26005)(6512007)(66946007)(316002)(8676002)(4326008)(83380400001)(186003)(6666004)(2616005)(5660300002)(6506007)(44832011)(508600001)(66476007)(2906002)(86362001)(107886003)(66556008)(8936002)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Ta2iwAdOlW+t2J3VnWlp6bv2sfGL2ZINEcVIbAfRITVO5nqtiogG2TC9QY6?=
 =?us-ascii?Q?ClCW9d9hSg1/63G8v1o/wcUxEtHCCMwxeJfg1X6UIlZYs4k3nKPPMea2tfJq?=
 =?us-ascii?Q?c1I/Ez65XU/hO3y86Zy9myNG3ugfOhao3gLADjv/TmFL0nZphoHL4OJTQsrB?=
 =?us-ascii?Q?4RcskGHEnNZNklqnD/TUUFXptv4C3fE/BrAzKG5Imc8wuoIe8/zFMpwIaI3e?=
 =?us-ascii?Q?zIDfCfuWexUKU+V5SDZyZ5pwqJe4kiYoUVkN9GAwTTy9iKfeoNccEvOemBMc?=
 =?us-ascii?Q?1WcCK/ie+ZbCLRNPfCB3xuRSfXov6ugg7KbdGm9upKjj7QUdRSGA8hABAHp5?=
 =?us-ascii?Q?EAaOBPBU9jNHYPR1x99ajfWLVxKzk54RmR6dFiBfGeH+0vc7AdUTUCqbZpkt?=
 =?us-ascii?Q?bWjdPkCscBlfsJe1H2QomAza2fC+771w2nVgIcdLCDAdiVnpt3eusqfpTDsJ?=
 =?us-ascii?Q?cxCHpKFw+znmkeljzpq3AZUihVwz6xOkwhhcwv8ZE4hcEuzuHxaBww9IAa/i?=
 =?us-ascii?Q?MeHwV3VfdFoa76cBC29Qyx16Thwi9zE78vedBcNZQLv8/zxxwr+/48voVskd?=
 =?us-ascii?Q?fpjkfgKsaddPUKVLXjUo+VM8tAD/BNHgJ5dL8tiR+K4g3QIwWjeW/g6WvGnq?=
 =?us-ascii?Q?RUWgyGJyhYwruCPXT4ne/Bexd3WpdKLQfYy3snsvWAivJw2ND6aeEOCGWbKj?=
 =?us-ascii?Q?KJv1aDKguL4G8O4ceu5fW8RTVnylYETvtOVNmn0S1VSEhI42pk66OhuSU1K9?=
 =?us-ascii?Q?Hr1iw30I/9XT8UGsd6UIFcnQMBNZ2miU+MCmxFOr2o8Nhgs5u5RBb7VUZfuk?=
 =?us-ascii?Q?LLcwu21Q0A2M6Bi14i09u6/w0RpAW/lXm3CXhFiR/BXXhPBt6di+67Z2tRsM?=
 =?us-ascii?Q?HefssLejurEi3yY/pximt4bi3FZnSBYqinMcT7n5Xcj33kpDD9ISwW+yUF5F?=
 =?us-ascii?Q?UWsPrAIF0zEMIhJNnjibZ5ITdAtEb5iM2bOWgC2u5Blo8aGjVgCEmT095XpD?=
 =?us-ascii?Q?dnLr7beTRBKx4QBOtgYUD+Fw5F+cJDxWwDV/Oizoei3lDrndO2Bv1PJ6mk/I?=
 =?us-ascii?Q?FHGx5T7p59Ik9qy8h7yYWPEUA8vkbh5HAY10uOmhPZQgqeuU60vqBiYoru2Q?=
 =?us-ascii?Q?bCy/VmP7i8bVIZ1URZGwrcjb2/45Rg72JnqcBp7PtNjSemoRAc+XWaSrargz?=
 =?us-ascii?Q?vs9ZbnIn8u+ZoLrhq8hU6SEhvqHCQwDNix++dQBEGxHfGT/gKIgN6qjUAhZu?=
 =?us-ascii?Q?uI8Tf4h9hPfT901lnk0MIubuNQnIXEM7+Wf+IZ3zAmzrKMcLv2CNq9geiO14?=
 =?us-ascii?Q?D30kUU03eopoXlyBfPEtvnP6DoM5eTL+SAgX/bHo88VVxFLr2heEvLx5VeG5?=
 =?us-ascii?Q?fAlZ61HS9Dould0wkMBPYc/zL8VMlabipQFaAfuyTSAloNviA16w2rA1IX0P?=
 =?us-ascii?Q?N7fhWE6W1Q2UAjPzh4cZdCs5j/5TlhSkoOEfCnNVuDLo3fC9UpuLANqeFxHK?=
 =?us-ascii?Q?06NupUR2vjt75QlsRrd4fM3Ou+9E8G82xO2hVysFWXBv6Etqb7TCE+v2+X2c?=
 =?us-ascii?Q?m6ndzK+96vQMibAdQaLyWjqDP9p9lY0z/hYi1w3wfWnq1n7WyUiWkzkMjIre?=
 =?us-ascii?Q?t6OXc1KpMUXbVw0Vm+00xqCwfHvh4iVvvtYg9GAJUeRU74kEFnOq6M9yvRqT?=
 =?us-ascii?Q?OL8qvPS4Xj9VeJ/OJafiSGx7e7NlebPrPoXXOLtded4BIHz2D+0V6dejeBqH?=
 =?us-ascii?Q?WEYE7z1UTSIVbZ/lh0twrGWP6gc2ld4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80fedc16-2dbd-4e79-9093-08da19767852
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 15:43:04.3421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DbjmsS6gq9ZG9LTEUSVDgOAIqPzvJc6SuQAXN+MJraPVdzgz9wL7WbdrMZHqrMooLffSbHT3SOmE25bEMzh3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB3957

This patch adds the round-robin BPF MPTCP scheduler test. Use sysctl to
set net.mptcp.scheduler to use this sched. Add a veth net device to
simulate the multiple addresses case. Use 'ip mptcp endpoint' command to
add this new endpoint to PM netlink.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 377ebc0fbcbe..7052c520c0f7 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -6,6 +6,7 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 #include "mptcp_bpf_first.skel.h"
+#include "mptcp_bpf_rr.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -362,10 +363,46 @@ static void test_first(void)
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
+	system("ip link add veth1 type veth; \
+		ip addr add 10.0.1.1/24 dev veth1; \
+		ip link set veth1 up");
+	system("ip mptcp endpoint add 10.0.1.1 subflow");
+	system("sysctl -q net.mptcp.scheduler=3Dbpf_rr");
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	client_fd =3D connect_to_mptcp_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+
+	close(client_fd);
+	close(server_fd);
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

