Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230817E
	for <mptcp@lists.linux.dev>; Fri, 20 May 2022 08:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653033907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HgiCgcLUzNbnopS6Lre4ScGyu6JrybWxTQv2w7B/QWk=;
	b=b8epHf+Rd8JIf7XWqfa+cNYWvYvlDY5cfrYeXj3MptTEHOnjC4dqMr3RQcwEAvls1AQyj/
	7qrzwEIZKdQx9EA0CTal8PO274JgRiGC8cJUdaJB7FG5/+d3eiEjdHraELnJAAtQZcqkD5
	6EHHZg2Q3JnPZy2BViOKAdcsVqynueo=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2050.outbound.protection.outlook.com [104.47.12.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-CBTEhm7yN9aG0zVi1BDoAw-1; Fri, 20 May 2022 10:05:06 +0200
X-MC-Unique: CBTEhm7yN9aG0zVi1BDoAw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B28zIxLrZsB2gu0LnLZGARlzvm93bzMpCP/7tNaGHAtPXGsZAlUZ3hryjothOf1YUVHfIDuEXl3BmcWPeE29xuS++/YE5Yt/Zh3HZ/aey/VCEXIqYW3xKXpBQd1lk/jM9M1Ukpo9xkE0g1zedctsB4fuaP8YoR1gM7r20VUOl4ALNWIUzFnesHaZMf9rZR6qoHsuOGEjtggRL1VV9mZNRTKjNUChk7+klEWWQjRxcxsu/yy4I1Yqmzd6kAvlTklHVlhne01eqbjC9KkxSoKT4IZrVuZt41BYkfpslzJoPydRxKv3KVHfik38h8nSKyhTodbJ4uHFKd+the5p61lCKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abFsfmjpY9aNd8jqUMNQ2Y2EoA0F7dw6k7Hk61+OqKk=;
 b=BHxXlXy8qnTEr2SQJzAUjgJ3Kbo8c0UWYWJRzpTQ3o3NLI2VcIbpR+6FHcV2Uhv4JodFvyaHzh2NQwLQcZ9Hbkhu4sFdqETXU+As34NevtegjkwX9Eamsgp5crpV2Nn/c9FFICPdGCKPHFEtcv9ymgEoO0QxRfWhd9RLAsGy7IKSANHcmorY84ySrJlANcUFIopXXj6SpL2Mz0Q74XJ9fgnXL0WVnLPHrG6HW1SUWgNa+iBQMMLzvhjGLIpQ/URxzkp98kdeilN5Vx+cReSXUKzYAe9ew7tXgzSRlffsksrt5BATWNhlxJBukkzO8CygNEruxO+kzy1EmgwPEBEHVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9149.eurprd04.prod.outlook.com (2603:10a6:150:24::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Fri, 20 May
 2022 08:05:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 08:05:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 01/10] Squash to "mptcp: add struct mptcp_sched_ops"
Date: Fri, 20 May 2022 16:04:46 +0800
Message-ID: <e24810544d0d0c7cf70a4b1333afcb8d2da4760b.1653033459.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653033459.git.geliang.tang@suse.com>
References: <cover.1653033459.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0001.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f240623-f374-4750-92f1-08da3a3772d5
X-MS-TrafficTypeDiagnostic: GV1PR04MB9149:EE_
X-Microsoft-Antispam-PRVS:
	<GV1PR04MB9149EB62615D1182D2CA7A54F8D39@GV1PR04MB9149.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q2EHSVFDsh/3W8ML0imxInqiCTKZlxMt7r4FBtfsiVOsYILaGlpbYUpiWeGd0Q1EP/QbGPV2YczPGFVZSt/OEUWjKtyRF6VpYrY4pt+Ua0kjVJlO4f9Xo3qd3iGVFVkFMRLSuqmJKew93bkkwmu//O7oGheLEtlT2xvetakdcEyUxpvjZv21gm5zzUAA0aMwKavvvRdR51aTa7oUZCm04DlZR9pfh5y/OGMnnPe8bMUtXhTrAQLIRYqd8nENitCxZahx4S29q94eHS7j94egwP8CJVKywtmjhjewGYhJRhHyL9GNplaG56ucZvX3tAiPzvl7MTjgObvCSjomKUApctHVhEfPAD8CZLmNwOKzgyM/c8qAedS9QEjlaNyVLBZUjh4bZeBL0YNsh/r2Cm5zkUo2pCCh/GNOVIXDyNiEQwOEeq1LDHfdhc9jiAIp/MXGY3GDBcTosfr5Hoc3BuZZhFI1bp42Mmf6AyDIEBew5W62kW/91n1ASeGjnYYCo8ngZJ5HcbcumiVCVDv5+6orVCfUSDCm1ZYeA2wp0OB/10ZdAL4NeKExEiaXF5oYWL3qXL3imFCKAmQ7svIq4eio0LKMbNxiz4+BtM+CAQoLvDEYxUy572P6Tg94IG4qWZIoAoxTaqXuYg68E2g5+UO+e5yD2Hx2lllqtlvAgfFmf1BqeT2PkA1dUI4C2ld1fiXGtO5Nq2NIsQDY7uxHYGpmlA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(107886003)(2616005)(26005)(5660300002)(83380400001)(86362001)(6512007)(316002)(186003)(66476007)(4326008)(508600001)(36756003)(8676002)(66556008)(38100700002)(6666004)(66946007)(2906002)(6916009)(6506007)(6486002)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ixzP+H+sBlQet9jUdwZkV7SB18kfUed2784rdLqpE76WQpVZZEqeQnokON3w?=
 =?us-ascii?Q?pXHmh7E7xpFOBIrQ13LAaO5s7OHOYl2+4d52SouDvbv+oOiOPYsXzW1E03xX?=
 =?us-ascii?Q?ZwHuM9SYXalx3GiIopxwSvvzTnpnd6XqeE/cDj2e06rf+xx1nzoR1Sq1VISX?=
 =?us-ascii?Q?oEOJYR7kWWv2d3AP/tzM6R9iqvw8/LAbbSu+iNOILn3FMf3nNKouM4UJZ+NS?=
 =?us-ascii?Q?Pg8aEIItWO2AJPHc2fcXcKD5xmSLPLvmCsTpb5Sg17baXKDRkY8QwwPfL+Gp?=
 =?us-ascii?Q?mria1OdUdDpxGG+Hjuu/Qmvhz2bCA43Ff1vhXIfrK2kjcpBWdTnVxEvDbMA3?=
 =?us-ascii?Q?0vewFgrVmnDeyCcVHg+jBLZIt+CXVqacnQvI6Bnml2D5XJUssJUwAbBi1zPX?=
 =?us-ascii?Q?nGHjVixlJUfN73gH0D02UQDDScfAgqrcS/jKL/KADHOjAxMbP5+mXBJpbzay?=
 =?us-ascii?Q?fC4tiLqvKH4anPUxIUwEdNwSUBKgx0FI6mkwmB0AyO0oxa2+4CBheXWVHrZ/?=
 =?us-ascii?Q?NHBbsEoYfkYTF4LKuhJPQXZd96rLtlXtoehm9EFje3JUhxH3N6BIGR1Nd4W1?=
 =?us-ascii?Q?5yQqbsJ8+PhGWyP94Zq1Z7EIkncB+/NOsdoJXm/mEPpkkHIaGV8b0jnuTTmO?=
 =?us-ascii?Q?j+w9klykjaYIe2EIX+NHHyX84R3jiY/lke//iTRg8putEeH16i3OTf9Skatv?=
 =?us-ascii?Q?HOWssA/oENFYmiyzkQY5RehYR1T8sYFnfW56cJhF0ZrZB3sVQtdxSjLz4xNS?=
 =?us-ascii?Q?7EI+H8xmcau9DJPjmnG2chieoo/DOeyguCu0/enff1DHKCV8G9nQLomFOnyX?=
 =?us-ascii?Q?e3i1v1bNxybAAlheCtmlj/sQ2GlH8iZMpFLpVxHqEpUfwF4/t7KFkMYj4qgH?=
 =?us-ascii?Q?i8hGIpO8nN6cqG7JdSgnzryml3wdU7vP6pdCv0nTZv5DwGs+h9MHQs9bDJDv?=
 =?us-ascii?Q?bjdf7vs9USBC+OYHcdvEM/6/dnUhza6+Ad6/UeHoZWkMarw+Jg9edCExv6di?=
 =?us-ascii?Q?I1lisHU3TCwlDfPtrxTlwzlAKVdE07IkG2obA0Rdv4GdPlbvPAUPTTYI0o63?=
 =?us-ascii?Q?lfSeb+FO/LRHm99NhPfSTURmIDIIv6NN9uoL0XZ4SwVjtKrjby1+Okn16wk9?=
 =?us-ascii?Q?ReAn3xboVAvrVv4I71r/ttRZbcPyFW9zxoWeW5+Pw9T9498M16r9kw8p019p?=
 =?us-ascii?Q?5u8jCtqhqjgEPcBzFJOQ4BOquwHLvdXSrjezaYRuX+CQzH6hGU5n13tOUAtS?=
 =?us-ascii?Q?qiRy5Pvi0pyi2LVPxuUQ2YYF3aFDBPGDU2l1PjB7Mo194wLTJytZtXBxgoFO?=
 =?us-ascii?Q?viVFC5NuPgOpP9iK2mrTPrJ2JCwZupLfJkaZrNyyngMj2VbqC47Y8ERg1tt0?=
 =?us-ascii?Q?NtQSL74rQ5xOVc9p5vJJA4YwpxjG5bTokoIu+OH5gXru7BOqL5PZ6E4FWkAJ?=
 =?us-ascii?Q?yK0Hxx4pV1Do245KyV16EO2wxI4knTyrBkiKsvxM1o8hOzgIlRjNu4gzjdGZ?=
 =?us-ascii?Q?pihXFnwp4UkUogZKD+QhkM7D+VdvfDW0vONCnF5A0VGIGblDrBGJ/1ZYchKl?=
 =?us-ascii?Q?Ml7XxRpQWXQ/szJLXtCNd8gH0M7YAtPhVQMsGtSppH8uLjdSDl2vOdYrk4e3?=
 =?us-ascii?Q?B6F3nC+FHbgNvTuc2IyeNUkeRU9BOyF9d2I+qnpxeIjYXYCi/RMnXzTOZGGz?=
 =?us-ascii?Q?sHNoCFKfg8SEk/yDMDgEGf+j+UlOlDD2LZo/dXOw/wDwB608LhlmLx5lKBL2?=
 =?us-ascii?Q?aVURdOEzBK2RGF8TC0a13+vXGDamFlY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f240623-f374-4750-92f1-08da3a3772d5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 08:05:05.2120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ggCAqidbfZMa/Cd1wAgxDTWhfBgX1MbCIGzYhEdcbr/orrkS5UjX7X5DShyGim/XJoyM/6jPWX04HyiaZj/2nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9149

Use bitmap instead of sock in struct mptcp_sched_data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h                           | 3 +--
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 6456ea26e4c7..33a44ec21701 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -99,8 +99,7 @@ struct mptcp_out_options {
 #define MPTCP_SCHED_NAME_MAX	16
=20
 struct mptcp_sched_data {
-	struct sock	*sock;
-	bool		call_again;
+	unsigned long	bitmap;
 };
=20
 struct mptcp_sched_ops {
diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index aca4e3c6ac48..60c8239f95ff 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -233,8 +233,7 @@ extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u3=
2 w, __u32 acked) __ksym;
 #define MPTCP_SCHED_NAME_MAX	16
=20
 struct mptcp_sched_data {
-	struct sock	*sock;
-	bool		call_again;
+	unsigned long	bitmap;
 };
=20
 struct mptcp_sched_ops {
--=20
2.34.1

