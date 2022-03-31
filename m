Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7267B
	for <mptcp@lists.linux.dev>; Thu, 31 Mar 2022 08:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648714983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QtLKI4tcDd0C7uKMzKHsVqRlASRRbVm/w+BmLAbFd54=;
	b=mlvS4lnk9u9oGZNzGWaCu2hQ+zZPCZbPbb1XgQptrTIJXhdErDN3Pz5MIyIlcU5pMzoAws
	Tf06FFK0Y23DcS5Xd1kkjwcaRRamwqX1TcLKwO+4swOH9XrL68tpgiBc5h1HGP0OF6m99z
	USeesES8b0QzZSweAmErXk0t2B7FZYw=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2108.outbound.protection.outlook.com [104.47.18.108]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-n9IqbVPoOdu76Vxs9ffK6g-1; Thu, 31 Mar 2022 10:23:02 +0200
X-MC-Unique: n9IqbVPoOdu76Vxs9ffK6g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXesW3yu22BPwhUNfH9Tn2GNmzUq6hIaxhSLIo4cg40uhB2j4GWvoHrV2FssUmXwhIIOReHjyqIMOAXLspV6bsYL3DXLkbVVkX29PWgBfQskiefQt7f4PbG9xcE0Q1rsPOQYADTzrNOCh3rfxV00VUSIndE5YTY7B+2PLh0X9RuQGZRA/abZQrEnUlgJ5HXTh7XJEw7htimwLF7KiEiiAeym9dYNfZVwiajJyYcbK55zuiwCcYUugwkTE5OFJWDV1SU4beJvQdC9UMGiCSRtHa/sXnur3oifCnRNsqQtPDnyJbhSsT6gpDCWV6rY+gAN5ueAOp9f7OcygVmTd10GGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqTXxHRnmFlLD4mnBiUsENxLc1efDeW0yD50ME4IYJI=;
 b=Cl9Z8Og2CIzUfFwSHa+WwkPCRlKMku9+OZYrll6HtkWwtsakJMCkBy5Igy3wo6ircbbcnwLcavrL0kDWwVtZP/QzdzDKuSpEJJxCDsoa/a1FopxQWILf9ERx0lqZsxFBNJZ7/EN9NMKTD9T4YE0OTa+VlcGBVPh9gP1pQowpdbkXggDhfYdMLf1kfob21XVNIZuM9uae4lzhRQXMfq1eisgbB2aRzmjfcTajW6MDd3am7gfgPNJRsGTM5r0u7a0kkfZYip5gKSO6ZPSINA7wtfCqIr47RUVcLcjwaxho2QJi320V2P6KHLGmr/M03iXjnTYj72EOwxrK76man6QZXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8113.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 08:23:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.023; Thu, 31 Mar 2022
 08:23:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: bpf: add bpf_first scheduler v8"
Date: Thu, 31 Mar 2022 16:23:07 +0800
Message-ID: <e6bb3c020929be2e6a41ef994e740eafe7fedce9.1648714973.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TY2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:404:f6::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fa1213b-5f02-4cc1-ea82-08da12efab88
X-MS-TrafficTypeDiagnostic: AM9PR04MB8113:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB8113A1C55D7E4185268D38CBF8E19@AM9PR04MB8113.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oSjxoOiQ6BQ6H+ttjyU6EG6bMtf98zSLn2VDBKdxoO4dKQ1kHoCc2eC/wyyVA+v/v696U3m0nRqhham8gHb6OdsP5Kk3Kicchlj17xsC6aN+ZPQx82kkO6u7ZnoYlyvoW+3N/vPlJIpx1Wc/1qM2hpK0RCEjf6pUAl/+dpoc1jgF1qY4hKsaDFjZjz29D9vX7E5jE0FEV+12JNdxtHhm78oTcgHeU3u5rqy8AQQN8Jm/B11eb4Twav0SSrmeNSXttJXKG/XkZsT906uGH88lFFPtoD2UdUqzhun6DSz3iwWTVlMIaAGpzU14p4uPWZGFQmew2jLranDszfjhZfB683wx9sJTBvtE1D8iEgIM8q2Aa8vyZB1KEEy8BnqIA/tTADJ12ZHScy8M7S69I4Yt4NP8YzwSxwGZPUuL+48mBeRXTbIoLgtK+RxAXn/b3BHvMfJHT9ppaI/YG0qwwBXxVjk/yk2RWtO53TPBKUgKuL0WqYxzMUJWTC9PMaRT+4O2YNqWyIEb8nkxjjVdKPg90FWHdzFz7SHWwF2UgebbQteXlX6nqMFLHqTv5Y1b3xQ2+WvRGlYnKw9eUbRfXSd7lthAnox7psY1Pd4yPkNvMgUPqQvDtl1KfBwnAP9CoSDsq49kBdXWwedJoWbo7dYmjjlwrYuTa35bXkGa1I6TcqPS/gsZodqGkSbAtbX1FTQh+Q+0my+bd2Gp8hJR277LIw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(26005)(2906002)(186003)(6916009)(508600001)(8936002)(6486002)(2616005)(107886003)(44832011)(36756003)(66946007)(38100700002)(66556008)(66476007)(83380400001)(8676002)(86362001)(4326008)(6506007)(6512007)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?beXvvYypxoATkI2wLwld8KOnShkiue65R0axRqOhGmwxB442tZDjJo95wTXT?=
 =?us-ascii?Q?BpgLHBwb9o9e3RO+QfTMXEt/Mpu/OaelDnMmO0e0wgduZoe8QatmcHi3WOEV?=
 =?us-ascii?Q?T5sIFYch76z7JtmPhCuc8UyteinnKhcyOif9mit9qATHtihKNJzdcCP39hqd?=
 =?us-ascii?Q?wEUScFVXXGEUA36cq/dXl0ApXFGuJo1G+MUevQcCFJp7dsbVfMsotPL45pUO?=
 =?us-ascii?Q?T0oAO3/lsM371QZfly+rOu9MVq+mQtE9stIieSF+W3Ybhzt2h1501DS/LpxN?=
 =?us-ascii?Q?obhuTq6cT4gXPnrBuHg/TMQYofzkUsV7h/oLn/bqi8l6eny/4+qPJQOqR7EV?=
 =?us-ascii?Q?rKhmb0k6/wQAmgIyyWMMe8wa6m7wXROcAZRJyg2dXTw/0MZ5FHRqBU0/X78b?=
 =?us-ascii?Q?e32HsccYQU5g9p2n5Tp+z/+X1Zt9KOFSTxWclcS+2CYNF2/aHKPHDpzBn8S1?=
 =?us-ascii?Q?pz+0Pl4PxclG501xKriVmo+S28GTXdot2+9rFqrDq/NPRDwS1GNAqqIvGBtN?=
 =?us-ascii?Q?mUkTSVx8ihl/4Dtk1AKwcVSeDbekcUlGNnixscWQmFVtOvCYfc3FNPIFx3XY?=
 =?us-ascii?Q?hSvPbJvrra7oX1IKuCJ+YTtacqHoHoKMCt9Z3xwf1FjjhBq8jA8/uJ3ha0ZM?=
 =?us-ascii?Q?S0nHR44EzDKG9Tnbm3EyVY8gncQYnTdfGPVLTfd31KIOVqwEItEF3WjgePwO?=
 =?us-ascii?Q?uJerY+teHNomEg/czV8cSro060QPnjrnzmU+BX3tMmCQqTRpE1EHsRybdFO4?=
 =?us-ascii?Q?edgXd1cpWdccQKCBIjcVddtAry8lO9nScIRPcyL2TfUobufIa0okaoCftuAw?=
 =?us-ascii?Q?T34VypCbw8oZSpBYK0qfEPsNHENRgYf1wJVR6PpeBxeQUvyBaqOFn02UxX5f?=
 =?us-ascii?Q?xoCyekHinicqByIHoMS2mZ4LlkWERmI+1dnfsIMPayJAavsDKZF3U8ioY9To?=
 =?us-ascii?Q?l3n5EpZbyFtAP0H6PTwS5n1/6svAaQq4DhzFMRX1XrUD0PxVEBwpogpxOBsv?=
 =?us-ascii?Q?oTxcgrnxYUlUQlJBFW+yr7KiJ1Iy6RUU1qjW+qm56eQtk69jwXip5240NidQ?=
 =?us-ascii?Q?7qSmOCLtFt6mwkCDt1oLu0q1yj5Dcc6s/lRMfiooZToZCSHIaOnoHKjSkq43?=
 =?us-ascii?Q?YNWC9a6BFaDE1vzzqtIo52uRUCsTYdxLW9TzmNysU6UYufDiMhc15tULa0bC?=
 =?us-ascii?Q?J9dR/06CqAzg7PgEocfFRzCLhJngfkuBXpoyDVl73TOpXTwxa3T2L6KU6TuD?=
 =?us-ascii?Q?foHxXFW98eDhOsUIUvkZH74FBBFfCyNmdsJemChT2Kbd3FKX0X1C4wS8LpHo?=
 =?us-ascii?Q?JN3KwQblRNQy3RtugMs6D9a8pkh0/OPXiwDIlNEaR0z/vLIEfIAWZnj39Cyr?=
 =?us-ascii?Q?t46TVziwGpV1T3LabeU+Yiq91pt/W4Q1dRFK3qXG/TcCgWZynE1RgpNd6vmE?=
 =?us-ascii?Q?nRt6bcDUCpDWrvzzMFYHkb4KtNXtj46BM8gdH6uJwRnKwP1xUazWVE/lUlhZ?=
 =?us-ascii?Q?+qL90va0B+q4ESy6b7PpotYar3fjAVMCB60wfcTqtGVojcfx1jFgSWDElS+C?=
 =?us-ascii?Q?/7JQCc3AE6fO8Tay4Zf+JAVHxwzoRYE5HK8rSycRYDpnyUgC7WVTAJ2G0GE5?=
 =?us-ascii?Q?IwE8aFx3x3zyJJNAK6y6tVGZRKdBzTaj6WQ4pqLNStgLOxvf8ZxKVhXQWuMf?=
 =?us-ascii?Q?vXaqX4MbWoe3bpIXxspQ6eXKlI0McOpopnFbCy6+6n4lUUidebL+im3ewg90?=
 =?us-ascii?Q?Mc22jF5fCS5x0IhFEuHzwDmHe8g62SM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa1213b-5f02-4cc1-ea82-08da12efab88
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 08:23:01.2113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nyyd8D8DgRH7h6k79Wi1ob5wt2O9ODJKCSuYW9gsvUTYMTanZbnkxHPGhiNL2xmpLnGRCC7UNT+Ui3knGSGuDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8113

- Move mptcp_sched_ops to bpf_mptcp_helpers.h.
- Update MAINTAINERS.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 MAINTAINERS                                         |  1 +
 tools/testing/selftests/bpf/bpf_mptcp_helpers.h     | 12 ++++++++++++
 tools/testing/selftests/bpf/bpf_tcp_helpers.h       | 12 ------------
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c |  2 +-
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 40a62dc29e31..852e21ca47f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13746,6 +13746,7 @@ F:	include/trace/events/mptcp.h
 F:	include/uapi/linux/mptcp.h
 F:	net/mptcp/
 F:	tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+F:	tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
 F:	tools/testing/selftests/bpf/progs/mptcp_sock.c
 F:	tools/testing/selftests/bpf/prog_tests/mptcp.c
 F:	tools/testing/selftests/net/mptcp/
diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index b5a43b108982..5135eb6710e8 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -14,4 +14,16 @@ struct mptcp_sock {
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
+#define MPTCP_SCHED_NAME_MAX 16
+
+struct mptcp_sched_ops {
+	char name[MPTCP_SCHED_NAME_MAX];
+
+	void (*init)(struct mptcp_sock *msk);
+	void (*release)(struct mptcp_sock *msk);
+
+	struct sock *	(*get_subflow)(struct mptcp_sock *msk);
+	void *owner;
+};
+
 #endif
diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index ee66a8bef85d..89750d732cfa 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -189,18 +189,6 @@ struct tcp_congestion_ops {
 	void *owner;
 };
=20
-#define MPTCP_SCHED_NAME_MAX 16
-
-struct mptcp_sched_ops {
-	char name[MPTCP_SCHED_NAME_MAX];
-
-	void (*init)(struct mptcp_sock *msk);
-	void (*release)(struct mptcp_sock *msk);
-
-	struct sock *	(*get_subflow)(struct mptcp_sock *msk);
-	void *owner;
-};
-
 #define min(a, b) ((a) < (b) ? (a) : (b))
 #define max(a, b) ((a) > (b) ? (a) : (b))
 #define min_not_zero(x, y) ({			\
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/te=
sting/selftests/bpf/progs/mptcp_bpf_first.c
index 3ae5c1eab5f5..21890a60f9c2 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -2,7 +2,7 @@
 /* Copyright (c) 2022, SUSE. */
=20
 #include <linux/bpf.h>
-#include "bpf_tcp_helpers.h"
+#include "bpf_mptcp_helpers.h"
=20
 char _license[] SEC("license") =3D "GPL";
=20
--=20
2.34.1

