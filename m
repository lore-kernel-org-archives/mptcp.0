Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970747E
	for <mptcp@lists.linux.dev>; Fri, 20 May 2022 08:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653033978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AXWL2ZNZmKT6oCDoY4/UsV5a442NXKPnv7wN0F484IU=;
	b=jFzuRnBH8M+e6ayqrhGdLdOJBp9hvyWaqhoHcxePHtLR58G3YnYOSdpnrzXHNY5DxajnSM
	IGhUYH47BAIiRefpci8pDvCiX9NzZU6WgEHx3RL1OCDmeFrOk05SmG7h10PMg6ygY+uGet
	nm1pO97IAkjIWuPuA0HR6ciAPZbILc0=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-PXZ5WOCYMXWLyNbm8JBb8Q-1; Fri, 20 May 2022 10:06:17 +0200
X-MC-Unique: PXZ5WOCYMXWLyNbm8JBb8Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTn4aVGzQsgBsaQHUKpL+WezuOKStBSeYT7LEZdq3/xr2tqmN/QDRwRZv5e+n9OoLbtJ2tGXJvz7TAlK12s0afbf2HXaIqUVZGrtHn1qraoJ75Bi+dY11nrGIKBwx0AEjQZJN2GerjESGWaae+3pLh6whs3dFN0tB+jj+PBl/JMrR0/CcrzPdN6MjEho7jPWJ+HvC9QsMMLqCHz1YmxxQRJuc6diLSQoStlolymAnsugIsQfWTq6wjNM5XYEzQLYIHPGS/OcYsaT/hcpvENsudxPjfcZAbo1b2Qnu0x0KbCUmUdolS2lzgww+ihj83Eus3Aald2fOvs0x/xZRb62wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hnqi0yp8pF8K7QJ5868TyQ8pxlByiRBptdcHn1UtMeg=;
 b=QqyfgbRF0n4wA+tQSl8o2fakOKPzGquhbRTr/hPtJcyYEjI7OUvUcgRmO/OVgrYkr8FGeXIOJ3ikfrcNUkHX8zZXsJLok2OZvsGUncKfVGw5SPNVP1n+1kVA2LIoJklE6GvTPAN8LI/LVSlOpf396t5ZtWLBLQ3hIdF9oYXHVBzNB7BZAsRHNr6u7XUW5+f1+JxHpG81fb4pbDk/q+4PpVmMUVolrsLQLFFonDSAMr8KCYB+FJ9HOQHe/DBQNzWiSTQj33pk7Q88jnNfHVLingrjTziqwjJ1/49P+o+O1B460S7W8IjmllfgQGS1+fytq8oPH9i/DOIWaFujJejnHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0402MB2757.eurprd04.prod.outlook.com (2603:10a6:4:94::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Fri, 20 May
 2022 08:06:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 08:06:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 10/10] selftests/bpf: add bpf_red test
Date: Fri, 20 May 2022 16:04:55 +0800
Message-ID: <d232fd9eb44b9e665bfb03dcda7863f428cad7d8.1653033459.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653033459.git.geliang.tang@suse.com>
References: <cover.1653033459.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0139.apcprd02.prod.outlook.com
 (2603:1096:202:16::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2506b2e6-f48c-4f8f-893f-08da3a379cfb
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2757:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0402MB2757500257F3EC361232F7FDF8D39@DB6PR0402MB2757.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cCalEzPGAM/yeRavVHnwzcA5dlARAfSMeMJziAa0+G/KZSkS8HdPn9fi6nKkIxDJulQ677xJhEWMWg6tXfbAC1gbA6yrMGRz1HS+6mt0rOuYRp3CtOTfPB3f4SvdpZu5GqDIiDfL1GkLdepa7oNwlFJmwnjZEjqSC5Xc9IROXVM+deGj7u6wxJpv/CnxO68P7iz9KDfUh5prvnSlNrfsF2HDDBunH0ZVi49T59kyCZz0qHiSFP41dRGwEDuEuMFs4+GVEMhA2ZNfh0/0T7inoRgntRT+ckn44Q87i9IlZN4yfRj1u69vDduNbfqt6jyTeVInQSZa05B0QKjoRAcZEINYtyVyt84o08UaTzkVhZaZwfYzj/jOgPlkIpVtCVXOMPyXMVUApw0BP9NvODvkMJDK1LUJfdWcLHM1G/7X0vfOaXNpD4ZFtS+HXR14bQu5H5OQhBDcUQk9pVGk95zV3SStifEQjEal+rTV/rK/lWjn2SNecQydjYGASnaPX3L26lk9tdOcmo4X8/NAbRyPZQBVkQfOpuuATwTpmED2Wo1/XKRxUZ2pHrIf21qw4+ENxGg1yG74WM0mfj0UbXljeHSGWeLX4WIPc4TECzAVYcL0rH/7mW6WwJ+vUJvCTGVE3ZLFuemD5jHFbkb9BwMyNWxRriVGPr9GEkk6x21t5/Uh0BoJplYIsaCZXTm0WRmH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(8936002)(508600001)(6666004)(6486002)(316002)(2906002)(6916009)(5660300002)(38100700002)(8676002)(107886003)(4326008)(44832011)(83380400001)(36756003)(66556008)(66476007)(66946007)(2616005)(6506007)(186003)(6512007)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?APWZx1Usx34tDvFNzk1idSILOa6NZDs8CthjewDxmW6o+MpgTYETkkOTzxb4?=
 =?us-ascii?Q?Fzlfo80r9DnvNatD7HTiS1W/rpxvCUz6NnwUogBNz6LbncBlMse9j1rNpDLV?=
 =?us-ascii?Q?McWjdTUCuNqCY0uSftsVCQOvD8go4wJI8srHXKH9bptqofB7WuCkBAWM6/zg?=
 =?us-ascii?Q?yUxuFCP6ZZXgMOicad1xVnydsY1RA3GUPGwBMEz2hbhFjt4m0IxItlxmAgCo?=
 =?us-ascii?Q?KSYhfwcT6fBClZWmTUWbRG6H/a58qpFNuUwpm9siiU7sPvufKzH8abyoumGc?=
 =?us-ascii?Q?uQk0Xl2PmzpYp2wpgKwVlZzIxnj2mm9tam9gVSUxGXEpaCYJFHCv6gr8Uqis?=
 =?us-ascii?Q?uji7V3KkDIG0A7hb7/Ia2lEhKiONXcbnfmTsY1jqBbpxqp1q6+Dh9wn9CuKx?=
 =?us-ascii?Q?SI502gyRMsr+C9GQWMCVd3TPEWLwlDX3jDehnMhkzOUb6Bnskatz5CerYKj9?=
 =?us-ascii?Q?couUc9Ndt52GBUQlM6Cd/OIPlnw3fRPL2qsa08GX0TVEHtJYvV5fF4+MJGGm?=
 =?us-ascii?Q?uhL4hR9Y+yN4O+/veL3WpzTvZINMpdE3gaVlImgrSDqLd7tPU1cOPHgQmo7e?=
 =?us-ascii?Q?z8XbXTOyR783iVzjIgHKux05bWdIqmKeimowfm30+1tJLQ7LU+zbR1Uj/rHx?=
 =?us-ascii?Q?1hjQAQQGleXrqDIqNf8bmdrc3EYqUUWJMpsk/2pe+u3rNRZVksY1eE5iw3eX?=
 =?us-ascii?Q?idwCLP/NOJNgX0Cwuzb0pclGJRYqRjyeF5vjVBOqjHUwj4ARjoYCmRO+3Azr?=
 =?us-ascii?Q?YJubluK+u33sVR/RPI8eAScrubMSnWQqz9C/TLNIMlxcKMwVmA7tJTKvbh3J?=
 =?us-ascii?Q?P0+mr74bB/LBNUESGcs4ug63W87VFbBRoYD2ovWA71K4/5c3le82nHz2FKkF?=
 =?us-ascii?Q?6XgHdd2N3d+L19gJSap/HB7zCkAXzGYs7LRGkbGugXCj25Dg9q2WSDLl10X3?=
 =?us-ascii?Q?gS0rP1LauYYT8A5Ft3GG4WblZxKvYFpNrJxVVDWAX44Q7/ahX1RI95Y+jbL5?=
 =?us-ascii?Q?aoeNjj6XbdjrP20uExHlHKki+Faqt4YuknQ5tzrr7XZvv05xQwfG61HNLmGu?=
 =?us-ascii?Q?1b/IPS7nBO7mZrPdT3qtDWrArmyj5dNvyirqeuH3BV9AbWQnA0MkQgWPq1RA?=
 =?us-ascii?Q?A7Fbs3qhYujqwxiyZtBy1fvYnpPOO8qw8emRKHTul2qSmWr7/Xf2idz3SBT7?=
 =?us-ascii?Q?WN69sbMlWRgPd3TWaPzLg6ST4AYgiF57h+8UyhpAYsXSRl2v9yiepIos27Mj?=
 =?us-ascii?Q?xw3Ilfq3b8vRS0zzCDPlyZ9AtGJG0Dcy8Lh+1VL7h6we8npQmmrSIkwN13hZ?=
 =?us-ascii?Q?zlig9fDSXMQSvkcGj7pC3SYjSsx3bBDjSJd7AaMXceLhycSkYVjJ5+wPZ6QY?=
 =?us-ascii?Q?93p/P/dsHG+Eh1nj8qkX73FtRSeJBIxx1tmUFiUSxruy9mh6C7JPkp3n7fEx?=
 =?us-ascii?Q?wH+f9+MSxotqgTNkjtjWctYk1GOEfd6syaUSa6g0I7Z2u0OpuRCxVMlKClOP?=
 =?us-ascii?Q?j0BcqVCB66iHnQKWufQOzhR+4V8mN1coZi3UEtEluO+Ve/f6KQkARAxK8wMA?=
 =?us-ascii?Q?ruWufcg+IUaM0hiqFSC7FDNqhO41LD3SSziLY+y9ERcvl3r1WedARhOSBLuh?=
 =?us-ascii?Q?tRcVw6p0P12ibs3iNlRTZqK9pvS3rqh6TPgolLDD4zBx7cEKaZij65ASSah/?=
 =?us-ascii?Q?DsoeRmHz7DDY953rTzYDEtaSxvRMU4Z8Bbu6R8y8fPKZ6mpuT1Dlq0zcWNfN?=
 =?us-ascii?Q?a+qfwUq672VYDPyLS6XHAEuHObma8Kk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2506b2e6-f48c-4f8f-893f-08da3a379cfb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 08:06:16.0813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U6NsQ46cDj7Z6w7skfd6QTIDff8hJmUeM7SnG2yfBGfIGoH2Dw7ETUjxPDcWJ3LCS6W9iwScR3cNLH674K53cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2757

This patch adds the redundant BPF MPTCP scheduler test. Use sysctl to
set net.mptcp.scheduler to use this sched.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index afa4de991f1e..f9feddace825 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -8,6 +8,7 @@
 #include "mptcp_sock.skel.h"
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_rr.skel.h"
+#include "mptcp_bpf_red.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -315,6 +316,41 @@ static void test_rr(void)
 	mptcp_bpf_rr__destroy(rr_skel);
 }
=20
+static void test_red(void)
+{
+	struct mptcp_bpf_red *red_skel;
+	int server_fd, client_fd;
+	struct bpf_link *link;
+
+	red_skel =3D mptcp_bpf_red__open_and_load();
+	if (!ASSERT_OK_PTR(red_skel, "bpf_red__open_and_load"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(red_skel->maps.red);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_red__destroy(red_skel);
+		return;
+	}
+
+	system("ip link add veth1 type veth");
+	system("ip addr add 10.0.1.1/24 dev veth1");
+	system("ip link set veth1 up");
+	system("ip mptcp endpoint add 10.0.1.1 subflow");
+	system("sysctl -qw net.mptcp.scheduler=3Dbpf_red");
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	client_fd =3D connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+
+	close(client_fd);
+	close(server_fd);
+	system("sysctl -qw net.mptcp.scheduler=3Ddefault");
+	system("ip mptcp endpoint flush");
+	system("ip link del veth1");
+	bpf_link__destroy(link);
+	mptcp_bpf_red__destroy(red_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -323,4 +359,6 @@ void test_mptcp(void)
 		test_first();
 	if (test__start_subtest("rr"))
 		test_rr();
+	if (test__start_subtest("red"))
+		test_red();
 }
--=20
2.34.1

