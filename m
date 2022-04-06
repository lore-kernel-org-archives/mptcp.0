Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8BF33D7
	for <mptcp@lists.linux.dev>; Wed,  6 Apr 2022 13:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649251605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eMbZueC0wrBXT/nYWGKDGIW8Gt36/rZavUq2XXamGeM=;
	b=PFTh1k7iNEUfMTI08139ewvaFW8k08OdJf/BCymeS3ZUbzISO13Aa36k7qINP1tXauIwGl
	FrQ3eOh58onE/JDnHP8fkHj3hiXNqiJhOQghdmjjKDXCNoOqewWfZW0pe85vJonAfQJjdW
	osQvghZ51Ygiw/mHXlyK8+3/6x3QFrU=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2054.outbound.protection.outlook.com [104.47.13.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-L1HkN8xKMS6tvCnVv3b9Gw-1; Wed, 06 Apr 2022 15:26:44 +0200
X-MC-Unique: L1HkN8xKMS6tvCnVv3b9Gw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRF47HEolmWjRPlF8EC2wjUV+Ao0ITYzhROvlFkQgBKdvDo91yvNT4zwpUVtwC9PJajmwvtAIXdPR7ObBZ4Y7K4lX6Ibr3+g1+/C6DcO1sXlz/4d/tbB4JW52wDvlw8ee0Lm1/Q9oH5bniCSe0KMPsEYwmeiEybuEiJt5N/0tyz6NPYsVjDMaZxQ7QLfmUeAVNI+Yw2+aZrmO787Wrf/RgVEBsZeVxKSpMqwnymNOehh/aUuYpgG+j8dAwo5mmBosKu3rwvD8awD2fwVBxW62smtiN1fY9oVakAs3x2Ixhb8B4auBlnhNKVkvmkoukp/BpRMYK8Y8jijDFBW05S1vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYhpqqqSnZMOBiugBMjEt3q8dlQtsVRYUsY4x/Z6FGs=;
 b=DAa+GovydK5MwnV66/6FQ7IofFgSGm1PBAL5Zv11lYEfb31oQ3ek+wiYdwwfvoy4AKixEm0ZxO7gwsojiOfoWQHasw22lFH+wI1YTfWhjwG1f7bC9yTu3Xzjs4m+RdNprxzURpPKYLo26VVWiwNW01LzvA6jEd+84sRiGGfH7hbHERvty+icDcQYIaSwmoHxjmIb0BFeikQ/fM8Sb5tW3DGb2+ieTVKhHzmCHjyWhLMIkf0o2yhvx74+7JNVbjAUHcT4sJJzgMag5gjL2C/Gi+2EIdpxoLfHyif8Cvcv1ITTDsaC+oZvINwdhFDgQvC132sUKoW9V9jNTJrZlx92Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB7PR04MB4187.eurprd04.prod.outlook.com (2603:10a6:5:26::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 13:26:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 13:26:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 3/3] selftests: bpf: add bpf_rr test
Date: Wed,  6 Apr 2022 21:26:21 +0800
Message-ID: <28d5b2a89d1a47965f6f6e4544166659217981b1.1649251279.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649251279.git.geliang.tang@suse.com>
References: <cover.1649251279.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0007.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 565d5aa8-b8e5-4dd7-bdcd-08da17d1165e
X-MS-TrafficTypeDiagnostic: DB7PR04MB4187:EE_
X-Microsoft-Antispam-PRVS:
	<DB7PR04MB4187FCDDE714EC1161636926F8E79@DB7PR04MB4187.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EEddxF1Sl/hCf90trU+ISyg44OkLKNNZptETgXiWbRBW1sM8l4oKas1bTgspr4o2N7IjfQTcfnQ8ftv+xCAvI7udXBSXTtRiFAQeIp49GRomtjOHMlU6YEgpC/dIIF93fTeGq15LaFXRXDdMh8Y+51ZCkSjxBRgcB3rTqeoTJ7x0HY9rzhHQd9TtRc1R12mQeT3T3i495h0N/TZ36HePOp+MygXrwm6JVqUuT3tEdwLxgQZh741JSwqS9hbRPp3Uhd7g3WDP+Dj5OlSwrHoj5RIMQLeeW8hOZkjU9oZWAIZe2nOcWowDl8L6rRMez6uvi6l4qhxkBnIfg0PXI/LDkUsWdaqZB/xAsJkvtRy4tcTn1Yi7CTFexnHgbF35tcW/35IcJrJwr10Znq21xs+tUHh6ICiGera2uzD6mumntuXEUCQsIsQ7I9IRWj8suuea38sXNL4aE1vKJuFF1LRPBbvM1y95HVpNAnTXoKA5i//3k94emH+J1vpkDUuyhZZAbPt2umDacpRH2FYyOb19Fb18ZD00nEY7SbXb6vpKwJzPFUcaBj+eQx2dc7MhEYDfhmqEbv3PKwLePOHd58qwgHNKfips70Q79ex68eK69iqqL1ZNHf9fGu6vOs19sIQhkXoZQEdjIPt5PWutUyHWpUB1J3MqbJ+V4Kiz9jWRcaDXHlD3k3T2peNLBvFOlaRC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(508600001)(6666004)(66946007)(4326008)(2616005)(83380400001)(66476007)(66556008)(6916009)(316002)(86362001)(6486002)(6506007)(8676002)(107886003)(38100700002)(26005)(186003)(44832011)(2906002)(36756003)(5660300002)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K52DgOVX7fhhjg1E5ofNbYrRCIV+vNBkoV+gai/iU7ug0uEphNX1RLSbOozV?=
 =?us-ascii?Q?AbDsJtuet4ufikV6iHwfsG1K28JwAC0WRhXRqvAf8vX3MQXrCLMizAa9gmKE?=
 =?us-ascii?Q?9zPFiwfgQJ5ZAfk9L2ZjkVGR09fFuk0NYiBlO4/PEJvg3yTZJOa65IjxXu4h?=
 =?us-ascii?Q?RxLPP3GDqHoscT9tD4s8ehaivX068TD+OBiFTIFPJZ2zVublZwrm8U1x+jMa?=
 =?us-ascii?Q?gxvc5s2I1TsOAJkm5j6wiO260WbNeu3DAXp4ydBVTNAQeZEZvstGsTrChYfe?=
 =?us-ascii?Q?QDczI+oV96pvF+1sYv/8mF8wkwGhAj06r4iok8quj9x+aNiGhXwDT0D8qI1K?=
 =?us-ascii?Q?VvnCu8QpRv0odfyGx+9+ciMUzoYMVM5ihKxx2w/PQZtZHFZKzfhod98XpYYZ?=
 =?us-ascii?Q?SO497zRmsE8taG9o8dETMZkBkFnu+SJMyvMb0nxTnney8audXe8ZGyB43nso?=
 =?us-ascii?Q?QPGHfAPihvNkWQRCGNuXS73sOQ22W1d0rP/ZwE3FnQ2ezMxeXZ2wLq9r2QnL?=
 =?us-ascii?Q?YJQM/JEkKba7ABzxL4986shAqVgP3UaISSUJ3zQ1kIPC8fcJJEtAgeRjQHTv?=
 =?us-ascii?Q?U13fxEwConk0Ek4QSA+UvbCk7HTWkCMVzmxrvpynXhcCKOW0LiqnT7kTMQv5?=
 =?us-ascii?Q?HRJqv+Uearo23EaQCLOkHLCyHaM8EBNRibIfRtOX0lwnMvn453QXv92tXGJ/?=
 =?us-ascii?Q?JPVddoONWZ23rR2MWhfNCLaiBEu7ypuqLmjoSTDkoB3Bj4WjMi7QTtiBgsSM?=
 =?us-ascii?Q?5hZx2HbQlkK4l32QcyL3qFXDDFwrfR01OuepuG7laulemiw6CfnHQGeaE+0w?=
 =?us-ascii?Q?LSpmwLorrk3Z+s8lj7hmoiBjfkq8tGq2F8j1uah3MNxJlFjzTmtg5s40fG5Q?=
 =?us-ascii?Q?4tQ5ZJlHB54d6hgsctOfN4gsdxr2OC8RboxTkfQREIBugSzxYo7LlLEfL74J?=
 =?us-ascii?Q?9TO2bf+ded65l9ZHAL4bkrOuQpUSw3okDgTgeDW000nhAH7/5dM1vY/Aj9UI?=
 =?us-ascii?Q?MoZ0/WZNndhApflsHtIuJEB8/ufgI5f6DePRHoPvxs0CRflFGjWmn0SNy/oM?=
 =?us-ascii?Q?QGuve1A4wOI1DCtFbe+NTpS2E7AJrapttwm6KJGdfjVwb45peYDaOOLre6yV?=
 =?us-ascii?Q?NB7+M0o3wAwuqsUdVFuQhIOunrnnfVqVMAdhwKoLc3VOBQZqgZLZh6iLAAFG?=
 =?us-ascii?Q?VkSsIOaYLOVlv3K4Ve/05IB90ZXZcgg5lsfjkZsco58PokyU4wGlDRy81isf?=
 =?us-ascii?Q?SbeAz1fFVkBYo/gMg5gBPh7CthXb/+Q3Ruo/V5NJMZwydoCcrjBhggAJ52VX?=
 =?us-ascii?Q?hjyTUutYNFe65UDSkKEyeOasQwgcGQoi9dFhfi1/pV8BUcMN6B1V9P6XJkoK?=
 =?us-ascii?Q?styfIEDcBYKYDQliz5yqIaWX9hPP3Izdl+PUEKv/21h1O+yh8kaWUVyC81KJ?=
 =?us-ascii?Q?bm5WkTY+rg/Yrfk/AxOrA3FaxRSKacuNL8JXV0QFRJ6r9Zg/DRs2desfFLxa?=
 =?us-ascii?Q?cNV+PkEcN/Ypf7XEhR1N4HSPCI8uYg7e2Nc/Nawk+XUqrWDgzIByRWIMM6Jw?=
 =?us-ascii?Q?gbYz1plmTmT/ZyoQAqOHOQGxZUX1yKJV/kABudhdPR9zVfNy+06hQRUAN0L2?=
 =?us-ascii?Q?tReQxvbwsa4H1+vqeUfEcZFyiP1Mbunb+dARFXnxt+6UviQdba/24De7/FWa?=
 =?us-ascii?Q?clzZ7V7AHcKlZFFIzaN2oD2SAxOpOKmKMp9TQyyzxf0lsFJJnXQtAqtZQjia?=
 =?us-ascii?Q?m82aqfFEAXmdVGYFCYlnJntO2EAxZy0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 565d5aa8-b8e5-4dd7-bdcd-08da17d1165e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 13:26:41.8664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oqeNUErn87Qt/0yR27aXOMeHhO8/0gtouWJLKnFrfXzRGgVu6Z4L/dp10rN1+3a7s3Fq+sWhoLlNHhN9Sia8Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4187

This patch adds the round-robin BPF MPTCP scheduler test. Use sysctl to
set net.mptcp.scheduler to use this sched. Add a veth address to test
multiple subflows case.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 467769e229f5..4b191a7fd12c 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -5,6 +5,7 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 #include "mptcp_bpf_first.skel.h"
+#include "mptcp_bpf_rr.skel.h"
=20
 #define min(a, b) ((a) < (b) ? (a) : (b))
=20
@@ -363,10 +364,46 @@ static void test_first(void)
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

