Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2044.outbound.protection.outlook.com [40.107.14.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1459443F
	for <mptcp@lists.linux.dev>; Wed,  9 Aug 2023 07:07:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3yW/fjT18/LBiRL7DQZ2nEbLSFYMwfcyMcTFaftW5G+WxIiFnP0bgOc1XV75zs70UM6yI/p4nhrtzlGKRlw3Kth4rl4Sj7fLNBWjBq37PcVrG5Mbs/gfuKDOXPVz0qMbyngVXQvavcZMUhkInhQyBrnSUjPlHaUBD4JC0pRqlnInKD2UEdoaCAkDZcCUdIBx2fNqK/OeJDeeJWlKq+OI/PM0xzfQiE7drmj9woPWrQ8vOyLppxIVrOchX/pmFUT3BxTgKdutKORYufnayfACrpFazyjQKICZ0bMHELjKpOBYI1BKDtecWPSZ0F5T8bQYGjD4kCmx6Qr/xIV4gr8Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Ry62aeb39kupNs7F5hNOPItGL5kFfiHuWgjEEqqWdc=;
 b=KigIQlqeY79LRMeJx5xLCrf5+qzSDlUVAZBSMFLtIpR4GyKWYrueuz7aoGjDHlBnWh7cfixjUAadbeib9V9O8qlxKIDQePcNhxetqno8+yO1p2l+l085eywSrWb44+jzC2wkGrscC1WzRLbwlU+1+Ra2VwsbH255N2beoKP29dz7+nPhzEwGCXyZ6AUXlhmF4xwpJVKjuzBxhXSiQecMpObahc8BxmFdY38+z8Yv2icfWSmclxszfmL5OabziS1iHkyYOlfO5rkNjr5x+kc7EDbj/l+T/EzInXJk9X/ZeMDh4EK+SZE+FbVBMEGn2QyxnmXuZFifa6lxJxHmwvsMLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ry62aeb39kupNs7F5hNOPItGL5kFfiHuWgjEEqqWdc=;
 b=CudCm7dd/Rd0ILYCMrtU5B1tt/dmjPyD3VMH/EKKrqsZSg8p87CIt4CErmII5hrGu3X70FefasPHD3cc0ifdgcWuyGBXMJqGijAvNwZRboivUyn4lbnJoMFxFYl9/LbdztNDgi4NCAblyppq7OXK/PPD+ruGmTyESYto+TCeDimWfJk36VyIteP/JGnyOF5uDWwi/JKvUiOtcaNrszt5kIK/ofu+773C6HTKCeY6ADvR4fEHBXiR2kWwHVch786TPhtCXTqkLphxQdwtTdA7I5A5nlheoU4ZJWw1ApY7cJV2lsc4WtlSlmTJGm5Gy2/sAQPn3jBWFMuNF+vOy3cobQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7984.eurprd04.prod.outlook.com (2603:10a6:102:ce::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 07:07:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 07:07:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 3/4] selftests: mptcp: add id argument for dsf
Date: Wed,  9 Aug 2023 15:06:38 +0800
Message-Id: <c3b615a6e41c66947047c81a8ace8e67792d3e8e.1691564649.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691564649.git.geliang.tang@suse.com>
References: <cover.1691564649.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0048.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: 6017baf6-b3b1-427a-ead5-08db98a73c30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Xxad9bZ8L8Sc5LkPgcvqBAiBhn4A4XU4N1L92mAL0nWyQ0mo90tYV+5qvRSbCDFmrZoayCUZcT1pqoq1xZ0Zi8o50+Lla2bE25F/xbUkojjzg0s4BCeL9J5/pnx/1U80K/sU9t0+vyuG0OtJrAImRH23GAtxCMXAWFRX5cDJBptkgVRvpRit8vSlryrCzTrPToMeFxn8GEHWhm3EltD1ZshnfCyySXjuoHNBjCoxwZkyESfywWFTew7fngEXUlib78k1kRssfJZnIUuuyM9cdR9YOh8x3QXV5jQ0gIUpf1zuoAkZNqb0Fo5rn9We5Fx8OIlF5DTi76DaNbFgQegxlU75KBGwce917zHqN1jz8vOrdOMWCxcZY5KHRfiVVxOUqtFdAkkq+fQXFhMjKKdWj9MQHVIjQLMoSaeY9Ji1Yms8sRCtQyb1u3lEJwHQbByCGTViZSng5TOt0BoWgKHOfPKpq3xz4H7rWnb3EdZEyMkFjNv0mKN4fe+fZxP0Waeef3rZoodE5lz5G4Dpw1JiETlH5TZyr6O/kZSz0W9Hi3UUuEHcMKdVlYbndopIs7zC16eG049L+AKLZiXwu9t7PsqxFpIS4v/DbK1g8xxZSYQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(39860400002)(136003)(376002)(1800799006)(451199021)(186006)(6506007)(86362001)(44832011)(2906002)(5660300002)(4326008)(66946007)(316002)(66556008)(66476007)(6916009)(478600001)(8936002)(6486002)(6666004)(8676002)(41300700001)(83380400001)(2616005)(6512007)(38100700002)(26005)(107886003)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hx/AoKu4komYYl3r7ATe7Bevs7i5l7BtR8i0rkaBnbiDkxZIVyP5iqHDLy0w?=
 =?us-ascii?Q?cs11cOb0scRAFr8PT2BkCDxw4NOrZrwiaLgEbzGROLVg1DnybZW2h6EXs3Zy?=
 =?us-ascii?Q?tGIPid3QmexQvB11BkE6Ew8IkiLU0gL6QTYqgMDUSaAluAm4k4JArNiHTOMC?=
 =?us-ascii?Q?/TeKQAe7brgJZBs4uaEGHq1k7bDDt9sTep5vBxOcWTCL8nIGqo8tHIHTyERh?=
 =?us-ascii?Q?z5R6i4y3R9GO4mwu02cPgc2M/WHL9+p5Hse1Sn2XBzMWL8AcK4ZaebEynOCZ?=
 =?us-ascii?Q?KskOJ8vgb6wwx3OIyqA4mn4a4jK3OoriLSQxootyfjNo+e3VCNc79+JoUAfu?=
 =?us-ascii?Q?IchGW/fXWPdJ4Rt0mSeTk6b2JWL4Fx1zWSR8O/YsPE2pOnZaj3LEf0bC+S6M?=
 =?us-ascii?Q?A1Nl0wW+qXj+xyDFF7wFdrJKi4QZgqWuwZYQr/yxk2soEvBuEfWXkBzFbOLG?=
 =?us-ascii?Q?MFs8QcAZjsk5MIMtnBV5agcnEcR/pkBidW0jvYFfZntswz7cEivLiPQdMHKw?=
 =?us-ascii?Q?5/Cg6YMS7QFj36dqbZ6flLOW8vLkKPX/lrELckGL8BWjRKAZVvwybQEnYj/J?=
 =?us-ascii?Q?DDt2iVPdpdSvUHkR+GPM4WUqBDoVWO2ZcZh2HEfvb0FhRl5KToHWoCcVJE5b?=
 =?us-ascii?Q?Q6PpxV5gpGSwwT+fmYaCc/XnWecLoWd7tlG0asF/c/WRUwaQfdeYLmUnQd/X?=
 =?us-ascii?Q?ZIJ9DNUWpYRXO7Th8KMOCthuBSu3087uxlw+bl6sDJL9pdlzEf0gBGoZMnG8?=
 =?us-ascii?Q?ucfpAMOgydfFDaz3H2ET13s4WARNpxquJqFjxpPdSA8iXm+rywGWM0gBateu?=
 =?us-ascii?Q?Ap7bkJ8dQ6Zh1HdprlPIK2qsgJBnEj244Oq5lPg4kqrR2X4PMGBMtFlHbe1M?=
 =?us-ascii?Q?1PWCxwErvXQfNUpFKBdnqGwhrTvL0gRzUOxlCtCUVyfj3y7Y7KyGvM6OVHed?=
 =?us-ascii?Q?lqWJofFGl7r2mDfcfzCePLt3PdisNM/fbuMe6xkzjSGFpjkAFi4teTWdGZoD?=
 =?us-ascii?Q?2aMjqHHu2P5j+Ck75QvU2R78N34pmKD0iHxoFquGlOKY/nYnd6iAe6jChfIp?=
 =?us-ascii?Q?cFQYQqKGbY3QkCH9wjDS1N45K25D4PcGqO7SikiAGZNBFJFfTFs5rL53URvn?=
 =?us-ascii?Q?PWN0HFdc5r893XmcjvKVcj0DJRzQXQnmlesAi19GIE9k1yDPXbeTD1uThXpw?=
 =?us-ascii?Q?JhG7W/WYVjGmP7m/HQUWDiAenmiuTRi4T7cCCkKASQwhd+kXvZwWIGEIPjqB?=
 =?us-ascii?Q?2TRNYX2iHyzHo1PXq2g5uTrZCVCQqZDMxLV+7ZgtBxF2fPCuXDg/jZWc7JL2?=
 =?us-ascii?Q?IG5raCu1+tMCH3wllzv3G1euGEcMgW02o9r4VuzGIFC+8TWrFcgSvzD1MpMf?=
 =?us-ascii?Q?+Iex7yqAYKgmcwByryHlGn2VjQNiTyhfuvWN/GfPAWsBt/Q/2sYcMaZnx3Q7?=
 =?us-ascii?Q?Sf1q79YGuUtlk5pqO8QT9uAqxHK7Kkrk3srb6ONW7/3qqJrwwNZZ1YgsR/fr?=
 =?us-ascii?Q?dHRnzHv1Vdr9sbrA/oWMviz1OMEFEu4CY+D48xDg3EOMaXsOBfB9o50jSuDq?=
 =?us-ascii?Q?9IbCeFmVuQADJekLlLm83Jj65pyZiJuk/SOp3/ur?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6017baf6-b3b1-427a-ead5-08db98a73c30
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 07:07:04.3300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hN49FL9s3zjQM1rYmhaDgx4oVvmKRK0Sm5fVxcoNNfPUcTwaLstplyTI3xqbu5OdNK5YIqBUylzz2Vmcl0KXMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7984

This patch adds a id argument for userspace PM subflow removing
function dsf(), to remove id 0 subflow.

It can be used like this:

	./pm_nl_ctl dsf token $tk id 0

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 32 ++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 49369c4a5f26..8a5fa655404a 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -347,6 +347,7 @@ int dsf(int fd, int pm_family, int argc, char *argv[])
 	u_int32_t token;
 	int addr_start;
 	int off = 0;
+	u_int8_t id;
 	int arg;
 
 	const char *params[5];
@@ -358,9 +359,37 @@ int dsf(int fd, int pm_family, int argc, char *argv[])
 	off = init_genl_req(data, pm_family, MPTCP_PM_CMD_SUBFLOW_DESTROY,
 			    MPTCP_PM_VER);
 
-	if (argc < 12)
+	if (argc < 6)
 		syntax(argv);
 
+	if (argc < 12) {
+		for (arg = 2; arg < argc; arg++) {
+			if (!strcmp(argv[arg], "id")) {
+				if (++arg >= argc)
+					error(1, 0, " missing id value");
+
+				id = atoi(argv[arg]);
+				rta = (void *)(data + off);
+				rta->rta_type = MPTCP_PM_ATTR_LOC_ID;
+				rta->rta_len = RTA_LENGTH(1);
+				memcpy(RTA_DATA(rta), &id, 1);
+				off += NLMSG_ALIGN(rta->rta_len);
+			} else if (!strcmp(argv[arg], "token")) {
+				if (++arg >= argc)
+					error(1, 0, " missing token value");
+
+				token = strtoul(argv[arg], NULL, 10);
+				rta = (void *)(data + off);
+				rta->rta_type = MPTCP_PM_ATTR_TOKEN;
+				rta->rta_len = RTA_LENGTH(4);
+				memcpy(RTA_DATA(rta), &token, 4);
+				off += NLMSG_ALIGN(rta->rta_len);
+			} else
+				error(1, 0, "unknown keyword %s", argv[arg]);
+		}
+		goto out;
+	}
+
 	/* Params recorded in this order:
 	 * <local-ip>, <local-port>, <remote-ip>, <remote-port>, <token>
 	 */
@@ -443,6 +472,7 @@ int dsf(int fd, int pm_family, int argc, char *argv[])
 	memcpy(RTA_DATA(rta), &token, 4);
 	off += NLMSG_ALIGN(rta->rta_len);
 
+out:
 	do_nl_req(fd, nh, off, 0);
 
 	return 0;
-- 
2.35.3

