Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A331FA0
	for <mptcp@lists.linux.dev>; Mon,  9 May 2022 14:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652108242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tcb2tLyrETvjUnzEX7MIKXWSaeXeDcHTAAHTq1boeS8=;
	b=a6ehf2SjMQZDhRKGBbFOLTXvMGJF1gPpo7kZrXm0ZEvREP2t/KOKWi5+T76gxWOeQIgiHA
	ibbXFTG56uexuZCwfyUEBCcjtZAuykI+qBce4AapXzmJAfCnVMNiwk7jXOk4K9QI+bOb/s
	BXRT5zgJrQ7Lm9+q42qqmhd61YbogZk=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2104.outbound.protection.outlook.com [104.47.18.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-J39GlPAfPGSC7cZWJUaGPg-1; Mon, 09 May 2022 16:57:21 +0200
X-MC-Unique: J39GlPAfPGSC7cZWJUaGPg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fszeDMXpRjMEGrzWZjtg+XEo3Ktv7ULaMwaNF0KKaAGBkHcAConqzG2uYnrgU+KgHOajcMGNMbfBwmdv7Q20FVvkL75UREbAl8spgL4vI888pzATYlQlweFBMbET2ICQyKHeR4P45ZYQnFFDyspMnYcX0A0ZgaGFq0MIFOFexSNwmYvIKpvwV+QPMpcWY+l61qHM31rrlW1R30Q4LA49RnzhI9YJY6bB6T3qsB5YCAriKYDubQYoEST6YJv8Zft3A041Z6lcHyCMkh9iL7AWrSIhJRHgkk1Nc2t0aI0+KFqlHRSaeXmf2kr00WJp7MtvxYZQUcrb733VBzvqJQRNYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36zxFFA66huPCNzXZu6GJsGeekz3BA6Lcx2UC3S+iX0=;
 b=i+BW6nxgI/sbaeb+h/tBK8Y+CEeY+/EHz2HdE6wbDlH8bWhT2xobAYtQoo6i2AG6jxcbzx7gd7/Y+2ddmBW6ReE6/Uj2yUKz0XXT5BY98Rr3GdrK/5cjzmJaNJbqUmEAw0Fg0L38vHAT8iJLuD6BLO/7RVPS36lWzyqaNYpA4f4CxeBm9HDwRPnM4+Rv/LsMrl/PaElaKVm57/Xmvpogl2pBoXWyD6uvR1K8U4Mibtmjyg1DOQt3WsscP/b43oDFFFQpgwskmyyRxOvBfNd1FPTMaMK4qcemzf1X5okpC7TIu2PdvcndtT7FyTLIYthETC3uPqwDlrfdAE6AzlVTEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR0402MB3924.eurprd04.prod.outlook.com (2603:10a6:208:7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.28; Mon, 9 May
 2022 14:57:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5227.022; Mon, 9 May 2022
 14:57:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 3/3] selftests/bpf: add bpf_rr test
Date: Mon,  9 May 2022 22:56:49 +0800
Message-ID: <96f9ac276c4f24d2ef189987522dc0c987266c94.1652107942.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652107942.git.geliang.tang@suse.com>
References: <cover.1652107942.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0166.apcprd02.prod.outlook.com
 (2603:1096:201:1f::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4e5b8eb-93be-4fef-5676-08da31cc37dd
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3924:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR0402MB3924A0B15E2677548D954B51F8C69@AM0PR0402MB3924.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K7ERGYm469q3zxWr4c/3H/NjOi6NnD+GXs0fvGyi2pU5ODD83WVnBfdQ7Djmf5ecZZtjmtyw+9leMMWRPI5h7O3kxEY0T/izLGuZHEFBEYwnM6IkRWxTx/pjkqw7sOWy0iv9RBkhx0PyWN6yOPct+nWvgOapGkIoZ+wDIuXfGyz45Bcg0qM2hTQ6iV6PlYDwjU/53ZogbtXrzXCkd0bVlflHVm2jF5Ur9BzjlGIZIyzG16fEaMqjpcPnEfZoPBDM6OGsXRBSlW88IEiFb50FOmH0v3fEp0S9tGefP1jOmxeLd7n/5ervXuOoB7w0Ttw7GxnfSU0AAZdK8ljjZJO+E34lhXeL18iW1q2k3ENtcjiRGTRMn3evKTEwrbmMBXuOQnX5nQhFnywT3UfCokR6LwQOz6K3ke+ERurORkWPEDTr8S2u/e98dX9DLa9Ewpf8SrkBRP2cOmzybvJ5+3Onzf/weKhiZ9MglCCz3gz27Ml6yUP73YIulI0SDG7fFVI9I4c7Llq5sGaprqZna0l0/e2QJopVUufvWbb57glEDTMr842eqZKu5GksVjuuT8sDWHxMeHTE32L/uLbwqvuBwiRuxuE5UfR1LBcyYMT8Wbl+bxJHZz7l0Qy4piKgF0K/ylnymmrnPEfE2c/nIKwwK58eMUcPGCtVIN67NB23n3lV1XBsSnblRH8upy/OMm2F
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(6916009)(2616005)(86362001)(107886003)(316002)(66946007)(8676002)(4326008)(186003)(83380400001)(44832011)(36756003)(66476007)(8936002)(38100700002)(6666004)(5660300002)(6486002)(508600001)(26005)(6512007)(6506007)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tMeaFaZZyhV4XCVIa7/MBkwZt0/kHqaOsBq+TrUwTYFPVR010jrujksHH95d?=
 =?us-ascii?Q?2ZiAaSOemr/w2jrLJPVB0YVcCFdapKrA3zSzvqrdW+f8LeFfOil7PZRZQ6rl?=
 =?us-ascii?Q?DIWfX1mKpHH7oSURB8MvKSvIhtTvd6/JGD0PlGes8vyutnMuLQXlWjY0D7q3?=
 =?us-ascii?Q?SQ1c0FMkrN5ME6ph0LQJCm29uZysefrO/74O3PGSRJg9ojfVMOGWZs0UXYzP?=
 =?us-ascii?Q?jUpbY3+Ao8b8uYfIALN8lNWlpkdZviapLG0SE6l3nvcyhTy54bD8pOFJH39Y?=
 =?us-ascii?Q?RYxXhnfTXBRWZ8b63tRIcrqfWEGYc29DVQxoAwGWTnpby+abXABmb4E5/i+b?=
 =?us-ascii?Q?gct2X/X2vlHJu8CP12YrLOS3Z1HW5DDfJpdpM6ndcKx0n9pMqH/6Fu0RrlSr?=
 =?us-ascii?Q?7dI0xTOgtimPRbh9EdbFd2FmB03VUb9tlvbDssjRkybV+aqI7cfLqHQPYBow?=
 =?us-ascii?Q?+mMyaHumGFxvOLskEyiiCf0DwIkfKYyaySzAioaFuGlDEoKOvvT9T1psxzL/?=
 =?us-ascii?Q?cYM90jv9DGeN0CtHaSOH1Pexx73HwzF45v+J6AB8bt0+RYhkvjp224Co2wqr?=
 =?us-ascii?Q?QWZXfI5ZPqpwQvWwoJFByDs1/bGzYRWxXKK4XlnTHDMOBQLGgjeWfiNXdMrK?=
 =?us-ascii?Q?+JkWh4m7mYzuxb1UES2kSyirnKBRT/RaszRKBF8zkTG2i/LMxRH9ejEizcMF?=
 =?us-ascii?Q?+s68t0UF4n2JALEA+HfGpZmg0NWFvFLqIktzcqGF//lQMVYXP9S7ti1K+rq6?=
 =?us-ascii?Q?rYnQrTlHlSpUfUGyZp8rTG0ASvA7hloo4zI5T4QFGsUaoIZWAeAc9qC659kx?=
 =?us-ascii?Q?z9PA6nnQVL56o9rnSJuzGBr55ka1cqZw54v4Rtkl2OU/0h+Dk9Ry8g2zbLT8?=
 =?us-ascii?Q?vGPUC3TcokHTqw97fP3hygtYr+Bbz+0M4Ozp9edC4MQOP7RUR69QJYb+Pirn?=
 =?us-ascii?Q?1GojAmfOWe0iApQuWYVeUOP+SNKxXJtUjv9WLlsYRmSAiTjxExK/+bT+EXZu?=
 =?us-ascii?Q?kg7i0E+gNPlf80MSQLSZbQKeTBhSRxpd3dmbPh+cqMp5/7N27V3e+QgNjaPv?=
 =?us-ascii?Q?gTN8Dj7uMpPpGK/weeAshlrTtrPreV/pJXofbY26ansLIpuPv+xX8wgeO5Ou?=
 =?us-ascii?Q?REZ5s84Y8g+M7sBwJpKqEaFE/B7qcDpOt016IA/uOMEdGMWu/vj5tjkjf8dI?=
 =?us-ascii?Q?eavXpSJUCMhudIWCRpKIghInk62F/gqfvEzPc2AUBomDoaoDiv/OrzSXkED5?=
 =?us-ascii?Q?fVMIOE5zyyZTsu3MtbZ7+71zVLqTdCvWlYr5ApQLhmmxfSmCmr65/QqW/JIj?=
 =?us-ascii?Q?4O8JF/Cv7RVKKH+i36v7tu/i5ujZ2CFB5bVlOsoHNma/Mjyx69vktJ/2dfba?=
 =?us-ascii?Q?RxItNTLR3Oa/Qdmb3VJtyFjb+4hC1gye2piUqf9/sRc2g2hFpNHIvR0MjfDZ?=
 =?us-ascii?Q?f/W5I57+H0uSunzA/VCJVn7v+2w3/LV0WN8Ud5B+lDCvKTr60eV8VTPrWFid?=
 =?us-ascii?Q?Wg4NWGhk+ptzHQUZExr1bBtlE/Lmq9hB9/yjb1SIBhi5THhgjE+zwtF/TYrO?=
 =?us-ascii?Q?Q8iTr0u9KpJKxreo23FypeIOi2rkN+7mYOJUnlT0RchxhHcaXVUMf/ZqZRCR?=
 =?us-ascii?Q?4NlztlJSHFU+TXQo1Da95Q2HZTiZgmFM+SldM4kOidtqUDmCrQwZV9i2ZOei?=
 =?us-ascii?Q?i+0VgdGhEdqoM4JbfRA70KLOlA+rLIlg03w1/+nZwmBcMGv4GHsvaJZZN2im?=
 =?us-ascii?Q?CbO3e4U4lIeCsqN2h8ZLJGwByw6r4D8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e5b8eb-93be-4fef-5676-08da31cc37dd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 14:57:20.9813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmMOtzYsyJUZi3iJqL5GLhj1H1y4yK5MKqjoeT8T9x/FJvoiUszIdhEySXrVtA0wbDSW+vmGC5BCuVKCDTg2+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3924

This patch adds the round-robin BPF MPTCP scheduler test. Use sysctl to
set net.mptcp.scheduler to use this sched. Add a veth net device to
simulate the multiple addresses case. Use 'ip mptcp endpoint' command to
add this new endpoint to PM netlink.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index cbd9367c1e0f..5058daf15ce5 100644
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
@@ -365,10 +366,47 @@ static void test_first(void)
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
+	if (!ASSERT_OK_PTR(rr_skel, "bpf_rr__open_and_load"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(rr_skel->maps.rr);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_rr__destroy(rr_skel);
+		return;
+	}
+
+	system("ip link add veth1 type veth");
+	system("ip addr add 10.0.1.1/24 dev veth1");
+	system("ip link set veth1 up");
+	system("ip mptcp endpoint add 10.0.1.1 subflow");
+	system("sysctl -qw net.mptcp.scheduler=3Dbpf_rr");
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	client_fd =3D connect_to_mptcp_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+
+	close(client_fd);
+	close(server_fd);
+	system("sysctl -qw net.mptcp.scheduler=3Ddefault");
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

