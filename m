Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC407F
	for <mptcp@lists.linux.dev>; Tue, 17 May 2022 07:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652773424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k4e6XJz2VQVuuJ9v9KWKVJ7FMOUD81zKs3guDPgowwE=;
	b=HGdcS88TR8iRARev2qp1+UVYOHr8ZfXMNRsdPuzV0xLxzclXaY1sYrIW/N6mD0MMD6UXaL
	JB8xS/XebiQq0Wc9ahmF3G37EKcyo7B0r95WZEmhTpOufQET8kBxUpQVzG38RzfXfbYt8g
	kzbUw1OW+LozvaoZgcjCowsI7Xw1xL0=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2052.outbound.protection.outlook.com [104.47.4.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-30-A-OJA_u3O7OXZ3za0IU5uA-1; Tue, 17 May 2022 09:43:43 +0200
X-MC-Unique: A-OJA_u3O7OXZ3za0IU5uA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXX0itBmpao6pP72+ns5WBEEbFAFrnCK3A31F4zyVPxnOxjKjoXJulOroxTEY5YQMKfFxHaVq8udr5qFKg/LBUUCpBoeWDcldiUvx+9/UvgwGnmM0dcuVUrnXmQEXHJWHGCjYFdW3uZdn+68ArBcTE5Zivhl5Axz9qM0MwwF5IvPeJIvcin2Jmodux9NpCHnY33mFoNUUNduD6pIAD/UcO63c2qAE7PAzuj61u8Wa/v8fERfHqpacE7Mu7MqmfQ0ER8ycMEGf09kUl/MjGBTF+s2kVD7SYCl0wVe5nGbC2Zl6VFGJg4KKrq75GRTROeH4s0klgXsFhzy1MykjH9tnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mNUxQ8sUDTsEmC8WHlv7w6RyMlLIJbH1XSmoyVZB6k=;
 b=oWz1/4wfXNlIUwc85HTYupDuhgLpRBDJI35g7eI/zsBVtlXUau7JoPnYEeHFqQYcyaoQFb4I04l6UHP0NBHL8FGdVaDQdDvpx8jWNGaq26ESN1/RWWNYKGTDkdH7CxuyP2abMPxnTvMUuaRO/NqWnKNXFxAy9PNG+Eg9BNwKD8Xvah2QMOrNLL8kB5GCZ5UsHsk6oKLuU5bWuyFOkDLUo6gA7KYbiW33ManUqwj9MsVn5E5A9Iu1bTNqdSwCUMoGhPx+zfyeMEly+riJZMW3mONjcJXgK+SRM8GmAghFE6At59MKVA11Hd2urOkNK6TIcvOoLWeuv9afntoCXyEtxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Tue, 17 May
 2022 07:43:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 07:43:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests/bpf: test bpf_skc_to_mptcp_sock"
Date: Tue, 17 May 2022 15:43:21 +0800
Message-ID: <21cfe6781be9c51aefa003c6f76ce99cb335b8c6.1652773264.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cc055f923d6d3014e9a0e3273e6d01c8a528bba1.1652773238.git.geliang.tang@suse.com>
References: <cc055f923d6d3014e9a0e3273e6d01c8a528bba1.1652773238.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0059.apcprd04.prod.outlook.com
 (2603:1096:202:14::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b58d51c-daab-4784-1fbd-08da37d8f6e9
X-MS-TrafficTypeDiagnostic: AS8PR04MB9126:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB91263341F756C7F4B20A0AAFF8CE9@AS8PR04MB9126.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eG9j+Zj1GV3/DsnR104DlBIcn2y4SDtq32JIWWt7ZtxePfJH7e9AuMZMvBPJ04bLCRpki0b8WQDpxPxWE2QRZQH7x0XiHu8Rh5oLEqa0H1L7PBVIOVq1JSMznh4BKrE/tBUTKBMOgjvbAR9a1GGk9ofMKIO5yb6ffLnJqzxItes8PbbkK4GsCBq6abJ4hUtDRyMECWiX7FOy62F+FU7EIBAm+vfIZGt2ta/SnB3fNDF4Ii44x31hnR6xGAmTrN4gl+0tzt/QsAfTSHBU4L4zY3w2GBuoR1ToqoPI3nvWbqRriNyj53sS60ck3Hbs1OQPI4XBkO3KiLlamLkwLD+5kY6ebdbHQfxmtM2Hz39+Hf3rUD3nVFlKnfiydLOFZ2qWSZxOu5q5tk9MOrJII+npT031WJeHZuTREzqLoIKZ4Ajqx8zN1G+Wt26+dZKwcVexso7IfHnXUU8W/P8Ld0aqXB4aliaYlD9rmx1wRTMdZwVzReirrZInFyd1SOFX4rz6iuiPw/qw6M6eHAK6t5yFJpBZ4u2U+aPBwmG96XjN8ciU2Eb85aakuQDhsKWiVDmeSHKf5+XZC0A0mZCF1uAC8R/deC5eGIuPhz1d60lzdpt8CVwUxxt2j6mOTvwK0KeuAWTteZoqAjwAREvEH62YLmoeaVgMkcUUrpHfNPduOZVMPP/SPwn9NFlJROqESECfS+Bn0rpjK9uiBV+Gs8HBqw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(44832011)(2906002)(38100700002)(86362001)(8676002)(66556008)(66476007)(6916009)(508600001)(8936002)(26005)(4326008)(6512007)(83380400001)(6486002)(5660300002)(2616005)(107886003)(6506007)(36756003)(186003)(66946007)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cAx1HfN2wOzYsa4++BuLR7c9CvkxO8nzlUJyzTeTAquGUm965yP5XdjhImFe?=
 =?us-ascii?Q?9gp+B6mKH7l5lffj2pjNI4BayxC1fbZcG7uzts8pWASgsKXXXfboOPaVMOdU?=
 =?us-ascii?Q?dtxreGt8JsL6TsaqX1r6lXGEMTIbtO9O8j9Do2LWaQGzigtnrPSQSPm7HNQE?=
 =?us-ascii?Q?JOMY5xEuPETywNEjgJVPt7kPuWKxBa8nO2F5yaLO917l5uphEnbSYjP7To5V?=
 =?us-ascii?Q?VrK0+/Zd6PexzHzeEZBikZbzvSqCLxyACVAPimSjBg8DLrQjTfTtIy8jeQns?=
 =?us-ascii?Q?Idq6WhPHTTUDdRESLWyRA3opO+mW4ITuKyrtRFfbK1G652L7bBx/IsStjue8?=
 =?us-ascii?Q?KEr/4XSxzE+ZVWJw4FcXGJxk+gkHUSw644cuzaMkUY8cudbmGeFXvFGMGXId?=
 =?us-ascii?Q?vv8rHYxakXHUIEZCpoDByz8lVRg9MRcnrF2X+h2/wsfNPPLDPAD1QI8+AstH?=
 =?us-ascii?Q?MxTyDqtJvU7KIFeU2d36dbSh2OmuaKDefo1rnH4tfc06ya7/iHfyE93ga7mq?=
 =?us-ascii?Q?Wfs8Eiez31DdZsIxT3Hu8T0zPorgVw22A+887Bi48/h5huT4tIInqTgVsZbO?=
 =?us-ascii?Q?LznLTi/idvQyRYDI7gD5pycpn8weicdztP8uewxPKRw1vvjJU5ofom8pS3gD?=
 =?us-ascii?Q?RUGlUG3Tk+RAhM+eWh1IST+k3kMq47R2YbzfdGQc9BTLCXUbg5C2Cs0NONVa?=
 =?us-ascii?Q?xp19rbBEGIXb2N+aH6XLbOMFZAKl4/RPII6Uzc2+2Ne7FyUGig7rscGYsxTm?=
 =?us-ascii?Q?485CxJ/Czal9Zd0sLae75k9I0Ufdxs7hUJeMBFV/ON+qdmxbyj9olqaOpbxT?=
 =?us-ascii?Q?aASZK/bvr3SmcGZj3TRdMTLnMxHww5b4WLrczAqDhrKXKiHI1nd3kMAcXtia?=
 =?us-ascii?Q?80T77imswV/nhZjvaUQaSAXv/+SZBt2GABWZTs0l5Azb90UCIIPR4wwJeg3u?=
 =?us-ascii?Q?+Q2fnI3N7jmo7vaztBcvqRGKPDO+jsN7XEIhs8B5dIoMGukZk8gDQ8EhHd7b?=
 =?us-ascii?Q?4bNRn0xUKC2NljhGFeDC8Q+tyjCVgqcGUl3EDQ6LojI1UY5j7e1z6ZoJm+6D?=
 =?us-ascii?Q?cw9AuPSuPcwjcQoEd5NDRQpVco21s8P1M/5Y0ZGTFqqnUoh44Yxw018Ua0ZI?=
 =?us-ascii?Q?T+FbYDr8FM+N0t30DTri18ndxGBR/uK3xnDtRnP2OPm7/lvfL3Ii/1EU4Zjf?=
 =?us-ascii?Q?dfq0HRreU8vFc5Vc2zgJ1NYU8eqCb6kGZ/pDTpBkDlpMZ3l76BASRNdv3fAt?=
 =?us-ascii?Q?7KpftVXXm+ukHuDmsLBQ4nffDFEaQvNZWmc8wm4ODoDMGubY8djvqSvEJbdm?=
 =?us-ascii?Q?5I3VBPK4s3MSUpkIWQ73V21izibW4spu+WIPqxWO8pG8rCEku25kMMZU+UHv?=
 =?us-ascii?Q?4vHh1SgAdfhEnDJuW0O/eeC7PrQV7dD4reBRPPLXBJZung3K1qHMInMezCX5?=
 =?us-ascii?Q?O0XKB52kschJ7MRUMvZTSrLw1knr68k1i+jA6oGthi/hq0kDLK3W87PRZDVF?=
 =?us-ascii?Q?uPaDBsNMKItqCgF8AgNkhbBzxAFfPiEEQVzQXtmD0nXQJgu0HhYxjPcCYLpw?=
 =?us-ascii?Q?SIfvVhCpPlcSV78dwvZ/alQRevoKZdux/nBcam7cmGeRZ6cdg5aSJVLng/II?=
 =?us-ascii?Q?SB9pXrqDIRbedfSYDwhjlshPWm7Le4PyfxYRSmj1NR+u0qmGT3nF+3B2LTry?=
 =?us-ascii?Q?lnaV67QO7Y+XQSM9KgQpXbZQLSZuGV1XZEdeUVZA6blAQAM5MziH3U3ZcKY6?=
 =?us-ascii?Q?opwROhQYs+z+NakO055hEWW8hJRfhK8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b58d51c-daab-4784-1fbd-08da37d8f6e9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 07:43:42.4251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0K7Nk4YalCVas+XJgVOYyL+KhZKlX89irw4S3uMGEnpR5aB9jNxESGhWC9YxEKW07J4xCUBk9BvXP4t4183uvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9126

Drop CONFIG_MPTCP (Martin)
Use ASSERT_EQ (Andrii)

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 12 ++----------
 tools/testing/selftests/bpf/progs/mptcp_sock.c |  4 ----
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 6cfb29399989..6f333e3aba9c 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -14,7 +14,6 @@ struct mptcp_storage {
=20
 static int verify_tsk(int map_fd, int client_fd)
 {
-	char *msg =3D "plain TCP socket";
 	int err, cfd =3D client_fd;
 	struct mptcp_storage val;
=20
@@ -33,7 +32,6 @@ static int verify_tsk(int map_fd, int client_fd)
=20
 static int verify_msk(int map_fd, int client_fd)
 {
-	char *msg =3D "MPTCP subflow socket";
 	int err, cfd =3D client_fd;
 	struct mptcp_storage val;
=20
@@ -41,17 +39,11 @@ static int verify_msk(int map_fd, int client_fd)
 	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
 		return err;
=20
-	if (val.invoked !=3D 1) {
-		log_err("%s: unexpected invoked count %d !=3D 1",
-			msg, val.invoked);
+	if (!ASSERT_EQ(val.invoked, 1, "unexpected invoked count"))
 		err++;
-	}
=20
-	if (val.is_mptcp !=3D 1) {
-		log_err("%s: unexpected bpf_tcp_sock.is_mptcp %d !=3D 1",
-			msg, val.is_mptcp);
+	if (!ASSERT_EQ(val.is_mptcp, 1, "unexpected is_mptcp"))
 		err++;
-	}
=20
 	return err;
 }
diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing=
/selftests/bpf/progs/mptcp_sock.c
index 3feb7ff578e2..dc73b3fbb50b 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
@@ -7,7 +7,6 @@
 #include "bpf_tcp_helpers.h"
=20
 char _license[] SEC("license") =3D "GPL";
-extern bool CONFIG_MPTCP __kconfig;
=20
 struct mptcp_storage {
 	__u32 invoked;
@@ -49,9 +48,6 @@ int _sockops(struct bpf_sock_ops *ctx)
 		if (!storage)
 			return 1;
 	} else {
-		if (!CONFIG_MPTCP)
-			return 1;
-
 		msk =3D bpf_skc_to_mptcp_sock(sk);
 		if (!msk)
 			return 1;
--=20
2.34.1

