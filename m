Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD901365
	for <mptcp@lists.linux.dev>; Fri, 29 Apr 2022 14:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651243656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FQXOqwpaPzRfacWRpiaqoHdT+r5JbbXwwocSCWnPku0=;
	b=Tqeh5pxlqIwP/14vz/fjk75Xap7uGzy+KpkHHcTot6Gx4263KkCrgY1rh/aG+j4kTkAN8F
	R0+hYbwfGcG2Khks8p0esANdYoY4L5umb/3ZMPQMt2kh3Pkh639nDjgn37V7KpQLpbnMcH
	zclVKsxn9tqLnnzWzjmy5/2QFCTlp8U=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2110.outbound.protection.outlook.com [104.47.17.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-8-tkMgp2cuO4uZN9haaWl25Q-1; Fri, 29 Apr 2022 16:47:35 +0200
X-MC-Unique: tkMgp2cuO4uZN9haaWl25Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ninz+HE8jti7PXNpqUxV4oc4F5pO4994LmrgqsscyTBT8AW8zWfZ9Jy6UShTOT5i2Y1sdzhd0YGVLxSqj02vmFzxamjs7JnwgqhLYNAji7+UyvkNr7f5zl2nkfd11lyRnGw8/bljl92k6+bC2DpWsqAipKA8FQFwhpsZcyok/MmIIcM0c9J6Ta9Y1savG+V1hedQ9EFiHIyQtpUbJ9EMwbcbIA8wQgNoFiFhPWRDHZDBEWtcoyKmeOOByaGkL6D4EDaDjCDXuqTWxe3vrMoX3JrEXs6P6FAebvToJcwaxd50EvBr/bMhT/zXRyRmO90k8ZwxQFn/bkHUqoc54ka/5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJNUTtdsaL5rG2E4ookCQ1uYpyfkaG1N5bTlzLzWDnY=;
 b=OhYfhN5RI+kCLgduMqNJK0drttZr+juJqz1eUsZEZEi0XBl+QjSt3rOgAxmhWufOlY8tCLFIZoFDnmloLbSd+TjsvN+JgZVbOVLlTjGHvIKhxked3jfSPiLXrL4NuKHAjYmPlrLx19TSzf9ORIVIzt/oKIur2Reg0ZjAXGNbmjsr6qHLr64T421yhrfmFKaq/L4gI+Oi90Eo26ARjKOiyzz7kOC3IsBV/It+fv4RSxqz7xQ9iX+9FTOLrtRKbAhel9PfuyvpA7wiEzxCZAuHlxX2iPaszMhC4+0m6Vx1HxCI21yTNx1PPwm1FqGE2xJ7JrbfmMfeYZA5jNqLh5zY6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB5008.eurprd04.prod.outlook.com (2603:10a6:803:62::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 14:47:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.025; Fri, 29 Apr 2022
 14:47:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "mptcp: add struct mptcp_sched_ops v17"
Date: Fri, 29 Apr 2022 22:47:46 +0800
Message-ID: <1746e385b6be5e9afb8b634cd5fc1cf4b543549c.1651243641.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0152.apcprd02.prod.outlook.com
 (2603:1096:201:1f::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 291cf3d9-e138-4fbf-feca-08da29ef310a
X-MS-TrafficTypeDiagnostic: VI1PR04MB5008:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB500840922843C005AADECF71F8FC9@VI1PR04MB5008.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y71HBzPpIppvJYSM4s6jqaXxI1i/zNYiHEyHJajGa5ch+AUUR6m3YkaoD9TJaMTYd8rb3HavYCjP88XGPcuNqAhFD05sXmM/c6mUSo+THR/Mq/UE+jVBnFG8DOD66JG5fd+o95kq6Y5lzQf+pXqaV2M8fvO5hOZphA2JBCBAJJqHyVYaVcbArg8PfF4Ii8EpmFr4ZOc/Ohs1DFKOxMMLapPBUvl3+482LwfIs2fFOABAEct+45fFGcxiitl2nnRdJzNsYXEnuJ/Lh4yN2p/w6/5Yl3hZPVwY959pHAEwLm0S7oVsMhl41XPHyFBlcticdnnmYRgwJy8YzZnqYp/DBRbgLCHY6baohDVhKR7c1qULEcqgAVno0cJ6pFYaX7ggYbTchuiYXaGUEWh8OenIfSNmn3CW25+gGNqfu1j5uuwJRnjy5C38ZjU/lopRHhd+r5YokqpoB/7YfNO6bbU0jvU/yPvtszJDel6RkquM4ths+3FdX9ZYiJfcg95hKTnFuKI62394UK1k664SJVnE33b7l1rZGPE7QeWNpp4SqeMfXgO1LxV5tUvps/hpujUJV1pxj5qdlgydL0tXBR1gbPN23J4e1Y443SqH/M3wLhIvL01VOav7hzCALF8bekcLDN6buXRx8k1Ds1QXUb+gw6cE7dehxhKzEFnMsw+PgIr8VEFsshcszfOchYS5wOui
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(6916009)(8676002)(44832011)(8936002)(4744005)(36756003)(4326008)(5660300002)(6666004)(26005)(6486002)(6506007)(508600001)(6512007)(2906002)(66476007)(66946007)(66556008)(86362001)(186003)(2616005)(107886003)(83380400001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GKMFpOUVHf8x89x4TVXNeGd9hJ7cpyvzRsEEPZiCr6zcZUowPOKDwV0Q6dJ/?=
 =?us-ascii?Q?IHmCP6YATPtfaA1RposchottDMJXqqGj4PHteJfKBGgIsMNXYKY7wQ+I2vJr?=
 =?us-ascii?Q?Q7EsSLjsXGjSLUaNlXICTiPaxwG6ZnZbvv0ZzvX8/ZS8DPCctJTqkpHLVyCB?=
 =?us-ascii?Q?hbJTPwWZ4cLM89SLbuGStHeXmemc2hXwnPZwfJYy8MEzBjWSnA4sxF4tMxcA?=
 =?us-ascii?Q?IMjq7oHcM27hc3tkLY00LuC/JJ45OZ+ysMeXs9fCx2z5YA1y1jlxFsUF8Ous?=
 =?us-ascii?Q?ti9x25/8GzZQQnhdca99XDGuHvei1RbR0OR5RIZSUUQSNpelhp8jrr9o4baS?=
 =?us-ascii?Q?XSTWdiQJ4oknKOXRw+b8qcHRYHFoKqW+VPd9cUi9xFskH2G0m2nEBmXGIEoU?=
 =?us-ascii?Q?I20WoPTvd+d0jLsIw4mWX/wnN0MIkzruiXJOaaJiOWskrZxeBEkgYk2M1KmY?=
 =?us-ascii?Q?lH53wGft4HkD3Sx5NnxMYsWsHIIRCC4QIOumahoI+6NFCbN+71/Ts25ry5Q2?=
 =?us-ascii?Q?Ojb9DebNsRKrS6RE8AiHdFp1DWQ+EqEqIjDkjow3/rAHn0viWTo42A6Khp/N?=
 =?us-ascii?Q?pzXsX0HlQGMIGg9ukXlWfT9rSfdTlyobG2Rhh5pzCfbjBS0OSd1psxoV1epq?=
 =?us-ascii?Q?MID9ntRVjb4qmowUeOy7WZ3CxligF+wuTsPudowsgffCk+vNyzVIY2uAySic?=
 =?us-ascii?Q?ASbJLy1MB7qMwIGb+vlD3/7wrQPqoZiVQ6SCN5Edw1RJscS9v7bsVcxz8SNV?=
 =?us-ascii?Q?3j6WqQVLeu9WwnTZZiLj1hd6DRdZA+PNDpHhemYpi9553gCFCuqfGdOed7BU?=
 =?us-ascii?Q?b3Vd2H3ojuxdNhiCYlGMaBduZNu5oHDO2geXaDhXiN1K8Qw4eZ5vyZcw3Wtu?=
 =?us-ascii?Q?jh5G55khWXTN2YlvN1I2TTNkZcAWFdltkBh9titn5nzCpTm8fwbh6czb2vv+?=
 =?us-ascii?Q?BGBaHMFlTgAxlcfYhbRjKj18t6g2RrGRrNaGILeyg2HGhtKqibe+HT3LGv/D?=
 =?us-ascii?Q?yx5M4KUHoxsREJU1Xpuk3sL1+dFeHxNz2NEmUpAgxHmyLBQQ8J/TOceSm7HC?=
 =?us-ascii?Q?Kr1+lvZl8rZxSiy9l2U4b1+U500+d0y0LUayyH2tuLeEwHHKnHb0FD8t/lfp?=
 =?us-ascii?Q?p1ejOmdJztg1G1wH95+zO/24TXePKihWN4BF9J4SuEBQIzf4JrGP2NkvY/y3?=
 =?us-ascii?Q?WrvzF29/U3JmMbWk6xVtmirswtB0H2GGXxPCjCpQ6Q3B+XWZYVF5G7nODULg?=
 =?us-ascii?Q?KfT6FgKXJs4v3zG1P2fNf1Y3Z9kRkHDD4SwjzeD4zPwr6TRTPODY0P/kSboj?=
 =?us-ascii?Q?7oWESrVcDQpgDaGHawCCg4DBz2/fnmmeZd/cZi80KAChhkiKrNBfoyQKeMdW?=
 =?us-ascii?Q?/6r7p+rGY7A9uZuZuI3D+HPx0SHkOPNJ1tzzp2JTJtXpFzYheDcrHGsul8Qh?=
 =?us-ascii?Q?84E+m2L44LFr2r+g7uMy18ottf/W0VMG1ykO7UcAc8vSYvCY3eAxmbf93Uk0?=
 =?us-ascii?Q?n0nGw3ZoP1BpZLtY4wnckwlC3G9FBzyAvmpF4K8ctFFpo7hwyWpwbTzAIAr3?=
 =?us-ascii?Q?DuwxcwZpB/mjcU8SPBwIFhyFwcK5M+POGgKatMbAWwmero/ZJQVXhCuswb1k?=
 =?us-ascii?Q?ZOZvG383EKFF0YWx0KR6Yke4sX1ZlMYIECRupwGFgWKO7diiF+60OJ92AoVz?=
 =?us-ascii?Q?YP704t9Majn4oyhnBvT53ix828WHb5IfnjPor/bkSWkYBvLKiWieFuop+uI7?=
 =?us-ascii?Q?2vLoEHTP26lmGMdvXcFxYj1LGX7vfQk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 291cf3d9-e138-4fbf-feca-08da29ef310a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 14:47:32.4479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0lFjjRUoUxw6wrN21B4ZYwXcNTiCnoWTp0YMjaqip6jEK/toyeXEcEDKdHpGkFcGk46hbhkaP6fsKI8w6M5yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5008

Use tabs instead of spaces.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h                             | 2 +-
 tools/testing/selftests/bpf/bpf_mptcp_helpers.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index dd4ee7a77567..bea7608d72d3 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -95,7 +95,7 @@ struct mptcp_out_options {
 #endif
 };
=20
-#define MPTCP_SCHED_NAME_MAX 16
+#define MPTCP_SCHED_NAME_MAX	16
=20
 struct mptcp_sched_data {
 	struct sock	*sock;
diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index 79a16636400b..ee07caf978b3 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -6,7 +6,7 @@
=20
 #include "bpf_tcp_helpers.h"
=20
-#define MPTCP_SCHED_NAME_MAX 16
+#define MPTCP_SCHED_NAME_MAX	16
=20
 struct mptcp_sched_data {
 	struct sock	*sock;
--=20
2.34.1

