Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3607B622
	for <mptcp@lists.linux.dev>; Thu,  2 Jun 2022 04:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654145720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FpG6ENw/8D3PwJ90m30Sg3WYwAOt5cFlzsOTeYTz8Ck=;
	b=WZcDFJa6suEeXWdbydcj4MKK3xs+xNu4bVPtL6+wvUvhgl4BMnCx8XrA+ry5/GQgpI7WTq
	nLFswiHqM5TXI5eeU+4R1CAafi0C3S2UaeyZjPxRk/O3PAzfjLZLlrRXTjWNzep3Lssd+h
	YJhzu09yMPVn40WFriGCju6Ih1pz5fk=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2056.outbound.protection.outlook.com [104.47.5.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-Bs14z6YSOWGfJYhz09ebDQ-1; Thu, 02 Jun 2022 06:55:19 +0200
X-MC-Unique: Bs14z6YSOWGfJYhz09ebDQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxulyOA2aFXDt6YdMzazOVKXIgcCOhONDcgCjcFbylzVqRDEVeVdQvF4GuKtbsYrGKBZQqQt2hSzfYA5FzWn4Leb090nh9O6XZV9NugltASVOaLvHf+fgawyY9RZWPMgLqfxksE5YRsD5vdKnetkhb2t2g61zOIOzs+B21V3EujzpAHpexE34avn8RYK9dd1He3/qNhYTprSFNlSQyaW+mIirAxzGifMPbezggHKdMq14Kwg/+vILkS3W0fUK39cIGmJAqUwijKrc+czOkv0TWdSmQutULc1WFKW1ZHjtfJS5UiIO9Kbe+LkAs4Th2AjyA2D17pq7nAYUtSHohyY/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GcfFui1g5oBNt3wRa0fwp161zlANUD9TuVQAshuDjk=;
 b=mDxR8TylB+INtfyZYztzbF66T83wifvtejXiNahQ8tNs5zYQnQ1qmWQR3xTdOKlBDkBuBDI+cn88NrzZONCui/DgiMLE2ETsTYSEjPjYXr/I308NW5sy2j8p3FiUlhXXrYq8SPZw9LrtRpTugT+m/ntcPuXU09AsSW4uU4Sp340SgAt47hjAhkuseRVpPEmVtjdIAkZv7WBauCSoG35ZqU1n+01mg6K2rqT5StReVhcYRWKwW3lCdY3CPSL7Fr3Em3q3/ZQRmUYhbSmr2xbbj7MEH5z2AUd/VUw2QglAcW9gZSQ4CXcFbNGvw6WLPaBs9N8toPQwDs6+G/emSbH6WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3384.eurprd04.prod.outlook.com (2603:10a6:209:6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 04:55:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 04:55:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 11/13] selftests/bpf: Add bpf_bkup test
Date: Thu,  2 Jun 2022 12:53:48 +0800
Message-ID: <9d676989dfef5a0197b741c5d50eab75e4967adf.1654143895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654143895.git.geliang.tang@suse.com>
References: <cover.1654143895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0014.apcprd04.prod.outlook.com
 (2603:1096:202:2::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d53db17-8ddd-43a1-31f4-08da44541725
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3384:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB338423FF02B100C67F40BCB9F8DE9@AM6PR0402MB3384.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T629Y8cTXjnDOpKgZFvIvDuD6MNBsGaRciOuzU/wEDuv/9jgB4jbWgURxdqbxdMFrNKVLOaFDq2koAiUIoXW0jfL3TTOgAc93Gh9PyXhUMdqpyGfoN7mAylVVJq9cMd4b40NRV5sYi1lJXU1BnTRj2IoPDg4xjIfgubX9PO0Pq5zWBSKMRUY7hFINHaiJF3dGQKz6DiTLeEg5R+NSjFf0dOaMoXkpVDVQA+1VRpenwy5Y/YeM5lFbordYPmEnrBuLxE/nRAm5opByTvSinYDZif5SreB+1O4Bp3cYAgHTLk2QrD38krc7IHfn38XXQcshuW/WxdTCXrNmr+h5Ksu6mekqU8249r1ENlxzMZQ49SMjiRVQkRzWncYyei9QRipUNcCvqbP8Bx6EA5fkmZFCPItgx5hC1uNzm3TXY6eDBF3fTI8xoIvQL7JRV3m9bPSVvCsunNWxoupX4h0NWbI9AKcmFwMJJryV5TlDOJhiToYO93GK/knLO7qtTXSMNU70akHHO91OHaVelfcUM4y8yFRSDe3jCDXkjY1aWb9xqNmb2SbL0MPaoriJT0I9ZPGVh05j4kAjZOC3Je9TZIHFz3zrdrxNg2bgHmRALWPIFoaNDcKeX4sjZmweCpHiodDZp6b0asRiRn63nXSooO9fcwRi6oguqjm4KLmr6+PWcoopXK2wEw6L7lykoxNeiW3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(86362001)(83380400001)(6666004)(8936002)(36756003)(186003)(4326008)(2616005)(5660300002)(2906002)(107886003)(38100700002)(26005)(316002)(66556008)(66476007)(508600001)(66946007)(8676002)(6512007)(6486002)(6916009)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RtrV/rSWzFB+uI07jSNryAmLoXNGhJoJb4G4X5KiN/zCRabjvy5oM9jMhQv7?=
 =?us-ascii?Q?A+LWdzEnJjODX5NSEVhnL7/dMVesw+VSVXwfD9b6A893OkVE0K9EiyS0QphP?=
 =?us-ascii?Q?TnsBMtgIb/bRG7u4Lo/BVVACUuDQcY5oA3/Xn1+rjqn78uBBNW6fftgPZP0b?=
 =?us-ascii?Q?tc4RKEFfI2Y2B5VRJJgzIOmmjQ8t6FcB42nv0cMIAnrTES+x8u68VP9UuQEf?=
 =?us-ascii?Q?cHpHTlVDGVrAQ5uJxHVujBThBHy0fkn5pXVcqshYYfn5uB3bfPjBB0rbpQ6s?=
 =?us-ascii?Q?WjE5z+WLPNKxIp9MZI1UHf/d1SKYTxPdScpH72PY+fJOmSiGxxNLJbbV06UC?=
 =?us-ascii?Q?RLF9Zxxy7ObdOQoaQFdHmRZGsVsB+KNrBEWBdB8jBGOwvl1qDNo3YX98Sk+b?=
 =?us-ascii?Q?D720xGMZqwbQdQd27lScAfTp07mKUQi1IeEes3iccI+FYZ+Y4+b7rdy6+72K?=
 =?us-ascii?Q?M0i1tqLDFn0NcgRM6sQ1hNKmAuoAENU+Y58VtmEVfke91lKspEDAWxtUzk7O?=
 =?us-ascii?Q?1Jq+674YjMhXXzbRBRCF8agJwnmqghmvcUrloWWpdMK4rB4HZRg/0OoBGqdC?=
 =?us-ascii?Q?6mIGXP8AbNpXTRrA4L2yfw5FrKcjLwAb7KcriCv2TEDbWnx1KNJ63VYH2oTP?=
 =?us-ascii?Q?sVKcPH/q+HJ4NbXQfoYP+97LQKm9xnN1ZwwOms4l6xO2lj7tzrkwbEBiKjgS?=
 =?us-ascii?Q?4Aivgx2dzOndH01mZHEPvdQEjfHBeuwbvntKNzvOV7IvLSKZfwE2XUBjhDMm?=
 =?us-ascii?Q?J+df3FHSodjqAUp87oNp2YIHaBE/yOlysytut9wsbD/UoHj5MpSapnder8PF?=
 =?us-ascii?Q?1h6HLkH/oFTQLB2Hs6ndoW11l+LvjfIPV5QS7dPk/6Mo/EwINBulJdqk4ZhQ?=
 =?us-ascii?Q?t0EtIlmWj7i4eGA4EnM5Q5MX+xFhF1WDB0v2IwRmQ0nNAbLXrysi50IGpEDe?=
 =?us-ascii?Q?zjpfYOBgF6/HDq1pXYjHtClq/VmnT0VcXW9ofGxsapd/QyzE8VkCTq1LWtMD?=
 =?us-ascii?Q?Q/Q+skhDjAU+GIHOyAl4nNRu2r2L7ctmNHdkPZUt2KRArKLBbyRkXqsnbY3x?=
 =?us-ascii?Q?8/dDaZ1m8AxTQX7j5kOiLP+AHHvVlFXpCYbdAD8OiBv82boxaXbth6g3bVCP?=
 =?us-ascii?Q?iuJtWgpT23WDPjrcvCod7JORLcM3bT6qb+fUirS/jNWTa3SYLhIQ+dlLCAZB?=
 =?us-ascii?Q?0WmAoEvKhwdYO/y+Po2PU6ghe3bJincSY+QBTqZoDm7RtxvPXEdv9OkwrwtI?=
 =?us-ascii?Q?64xtkcLmNahgOexHpuUpbOYrNlPSotfYFabsm44f9DgPTHZd9GCiM5vbW244?=
 =?us-ascii?Q?+7RSPnDCbTAp7PalKL3UToeTYsGw+ogvcsTdGG4+9Z4qAtQc2X0dViscrk/O?=
 =?us-ascii?Q?sLFtSbhyq9QIbDlhohViZyeKswvvrNAvYHAlFOIpNHFJ/D4Ht6xbydNjuSiC?=
 =?us-ascii?Q?1EW2U+RdwqwgaaIffsE0kxLJ+KJaGNZ0MgySvgt1rqZW92gCQW53VkKz6CH1?=
 =?us-ascii?Q?efmKkAEquDTiLGdED5v0uPXXD8Jy+Gea9D2S0U8OyEYsIuYdjA8MHwMb1pXV?=
 =?us-ascii?Q?CdpnkN/Q3AytF9dtDX1mkef3w+VzWv5As4ZW0dxBRzTy1zfk8FTTg+WhtKXc?=
 =?us-ascii?Q?otyFNAX2gFKezR/kLmA9UNPAv+Iz9zwVBgnh9Teffd/fJTHZ32LYqonlUde3?=
 =?us-ascii?Q?BNN3hYl5wfOEtgPNQPGFOxeY76JN+aKJjyTDb0thGRTyTggG3+Srsz0w/JWm?=
 =?us-ascii?Q?rYSm5uswFD1YrvlHTj7/STSIt5JSU6U=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d53db17-8ddd-43a1-31f4-08da44541725
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 04:55:18.5257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 525JrUDeiFixBWbTdsr3DgAZ5zPoULxMgfOWHkUo3bq3CGWEfNvpEcHX3TB6uwni90T/xJybNKWR6568DSouKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3384

This patch adds the backup BPF MPTCP scheduler test. Use sysctl to
set net.mptcp.scheduler to use this sched. Add a veth net device to
simulate the multiple addresses case. Use 'ip mptcp endpoint' command
to add this new endpoint to PM netlink with backup flag. Send data,
check bytes_sent of 'ss' output, and do some cleanups.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index eaea4105728d..f3c73cd2c786 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -7,6 +7,7 @@
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
 #include "mptcp_bpf_first.skel.h"
+#include "mptcp_bpf_bkup.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -296,10 +297,44 @@ static void test_first(void)
 	mptcp_bpf_first__destroy(first_skel);
 }
=20
+static void test_bkup(void)
+{
+	struct mptcp_bpf_bkup *bkup_skel;
+	int server_fd, client_fd;
+	struct bpf_link *link;
+
+	bkup_skel =3D mptcp_bpf_bkup__open_and_load();
+	if (!ASSERT_OK_PTR(bkup_skel, "bpf_bkup__open_and_load"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(bkup_skel->maps.bkup);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_bkup__destroy(bkup_skel);
+		return;
+	}
+
+	add_veth();
+	system("ip mptcp endpoint add 10.0.1.1 subflow backup");
+	system("sysctl -qw net.mptcp.scheduler=3Dbpf_bkup");
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
+	mptcp_bpf_bkup__destroy(bkup_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
 		test_base();
 	if (test__start_subtest("first"))
 		test_first();
+	if (test__start_subtest("bkup"))
+		test_bkup();
 }
--=20
2.34.1

