Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80042.outbound.protection.outlook.com [40.107.8.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E237A
	for <mptcp@lists.linux.dev>; Fri, 10 Jun 2022 13:06:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEKcBwnu4yZP69J3AfgQPtCIL8OOKYfncq/Ar5Vq9dohOKOfg0EdDDOeWkX8AzqOXN7jeARMhmHJhQABexOZtTVwXGF7FmiiY5UqbdrbW5g4OaY8mC8UGnJz39BF3E+EP5qFfL0UlAelLK33pCd41o0PdRkqvMjEgGSgSK2fpq/FPg+y7QdaT4v/B5Ier9pVaoR5jgm8G+Emiu9l2eQdyyCoG0S6DipoDdDaBpyjGQY+Q5JzLW1XXxuRCkWT8ZJtwFOrh8dtFNO5OJ+XVc7wCviSCtgzfOJ1VvysEi5n97Bd5D/Jd3mGl5JIOXihTSpjxcCS6LlbFkzfUejY1vXKrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Is4brtMMtcD/9QHxIvOsPSI/DV6RBOb2bkvAGvAprus=;
 b=iP9PfEzEINAB78ulI25NjOQqM3GNyhJmdYuJPT2RG0WBB24jlzpDhNB5bFwInRen8y1Mn6IAeF+zjBy1HUp9h9AVXaGkCEKrCsSde4ytwJvRbGk2cnkAeMaylzBKqNhV9bnhKrSlBxYCfGWOCECay0fvrXRaw6B8g+D8KgyGhmfkm6ijtP1yHYKL3KbLi8RNaMbwLFXOabkwAvnPEXebMpbLnwzDNhp4g3i/gNdlvzcteh5Kl/zywGkkCwq26/8wz/3NpwEjqvzLO1gC6WpHlV3vGwyTpqi1cg8I7lVbmGS9PQ9TOQ8ktnQFO6NkMEzABAjapNWgZC4I1B0LjH0e3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Is4brtMMtcD/9QHxIvOsPSI/DV6RBOb2bkvAGvAprus=;
 b=s7wXsVewoPobr2i58JZREhdUa6Uc0kgCLjHaMFvn15/Dc2ISfJ45e8678PupXhFSZhZsNGhwIDnVn6whAP5kbJJzZUCbezmEVg/07IfwjnmUtKY1iITF2Za32uxlKC/E91yX7xwtB2bP9JehAqKa2QzITFmpA2TrGmox/g2DmETBc/Erhwk8xfk9ipyVihwCKQxciXGUMqGDi/jfs2I2E92H2Sz6kX5BFgBsxayhye9o0iXx/phC3zn38t+F9CuBbuRdoa1p03ZYb49OkqyFy/revjz7V69FTEuSpNR/WrZEUfGUKaczlysmOh7cUtDVFwUEHqIjSeMaXUEvRRO1lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0402MB2725.eurprd04.prod.outlook.com (2603:10a6:4:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 13:06:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 13:06:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 7/9] Squash to "selftests/bpf: Add mptcp sched structs"
Date: Fri, 10 Jun 2022 21:05:32 +0800
Message-Id: <bf3ee8197abd0c37dbf331c425bb6e3f170de3ef.1654865847.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1654865847.git.geliang.tang@suse.com>
References: <cover.1654865847.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:3:17::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d8de03d-e70e-4442-770e-08da4ae2107f
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2725:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0402MB272539B9B5E90C7426BE0C97F8A69@DB6PR0402MB2725.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	elJC22rXi9/ShlDAVEFUXKib889m00DYs+dymwRRCu9XTtaWwx2J1EkV1rQVZ48+0SMmc7ljapJTearlG4D5B4wnhcM5K/eZeYuC2u4SNSMSHQc5u8FTXCcgDcM7xViZJHLR1xfCRVMPpUrpLrRfYzw1PKTfyVOIxX1px0Jjdox/6t4oZ4RiV6d4Earl2XLM57ari/MZziuwyWm+bCPDHLxU2NGtt4XXEQt5ZtngO5ubsPOoB8EWg4wT2s8N/DRD30xQcHBS0D9N6iQ7Ewg3QyuSOptixk85YCZxUvX4eeg2SjGM3c9BHyXOhPneZ9qXwSnVvf1QJ7c1J33YQh1hLzR0YZ6DJA/MEeKVs3MPQwo4ByxKfG1+kj6TidSGZdWcEQHIW03EXS1iGVipbaKgPVi6hUQi5uPsTbRh5PiHwtr2raYVMHsRQwF/cIrykJYS51c4QcjeUQYqH6zogqlYT7uPsalakckYIqy1iIt2IYUAwSuU+CIBsohUU8+WepEFnQWJNJjENppx3lkW9zX4Oq8nlUFku1Xn5sGbv6Qm/UPcvb641v2CF/vWnopL3CREgUJkYEZci1EJi2wwtDbI5m8jgAkHJPdjloy8ZWBFZrsNAfmkExA6UVentj4OWFgU+qb6HYyi1fF94Yg2m/mCk+dGx5sAkii0q9DF8xrKnCKiDRYRIuyZxqV06vo1Qpl2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(26005)(6666004)(2906002)(4744005)(44832011)(86362001)(6486002)(508600001)(6506007)(2616005)(107886003)(186003)(8936002)(36756003)(38100700002)(5660300002)(316002)(8676002)(4326008)(6916009)(66476007)(66556008)(66946007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kgCs3FxcbiShyIewjlb4gJy8Pmc38RMLYcJHm6HNCc6JpVWwfPPBWCMiT/SK?=
 =?us-ascii?Q?V3p8T9KA3m6ldSBoGFsIyhP50QETX6/P953GzuUaw3WhwPaperdkOcrVpNfZ?=
 =?us-ascii?Q?esN84vmxZvWnwxu48+tvWsfg4M9TaKuIupQ2qfbH+3knghduiGVKU7FVZBnW?=
 =?us-ascii?Q?WLV+ECbe5kG8sqNqPbPHIZA/rSaRnqMWN3duMPYKEPF21sn7d6dyDy3FagXj?=
 =?us-ascii?Q?v8KGHeSvW9lO6XG/Zz8imzc84lrijgffKxUI1rk4zIJxh3RzFFD9lLFJy7wl?=
 =?us-ascii?Q?bx6oBTsvGDioiJhoJLDFsONbA3aMUFRV4nBjquaPZ6j/wEWP5nNJMLJu/xyq?=
 =?us-ascii?Q?icJYL47IV2bDd4bjPN/HwfiC/Op7MthSjxeEPK31KQ1itWc/7AqbkrHDGIHz?=
 =?us-ascii?Q?0e0KNWUcly7vr6+OZEysyO0/X5jRRWUo7FY7OHOFXirbTuwEmJPwicd0i4iC?=
 =?us-ascii?Q?cQYmOZRWfv4YYM/aRkn122lXIDV1q057O/525EjEknFdX5nFF22swCv5E0kj?=
 =?us-ascii?Q?4bKWbUWRswG23jnprzCkBfdTvfmc+7aSRzgzSyzb+zdAKThinDLqb/ffbTLN?=
 =?us-ascii?Q?dtolTVo3LNfpVy2UVwkSJaxrNZ44iIpBVC5PZFhncEEHMZWBAxvBKnSoibFm?=
 =?us-ascii?Q?MSce5jBBNHqPi4nDvyQdSaI3Bdjyk8pzGx3zAYcQI83ce87WmJni+H5QTSE0?=
 =?us-ascii?Q?xolF7YwFjNIts2PC3Tq6g/TgD4IaB14BIYbaEh6g/c6mkG00b6wG7AM4MuP4?=
 =?us-ascii?Q?ctkotyqreu7ZfCZmHf1TAEradvaWsnOBq9Q0keCQktXyBib7FpP6b/eJcfsQ?=
 =?us-ascii?Q?qxXv5pOf4LEs9R+3iDmLDUkGtwfwR7t3+hINVj/S5nhdOjTIrrs4z/NT5uoN?=
 =?us-ascii?Q?I3wVt70yTTXRiFOveiWtIaMmCCBqZu7w0HXunMaN+8Rsz4zCQWpXH36Au70R?=
 =?us-ascii?Q?4JkYBpP4Gjue45wLxYiCDlYqeIFJ4nI7IVwlTQSo2p3nF2lzIGm3mzsXHDiG?=
 =?us-ascii?Q?wHHbnn7W6m5KAqe9X9xifbiDd4QeR7LmoCIVjc++44siqVWhjxLkuAuaAiQN?=
 =?us-ascii?Q?6hc6f7lNgf4Q4STuhdrhWfPjTPGeyphszNfX2athEq6Yagrp5zshrq+UqIyz?=
 =?us-ascii?Q?75XGkjMTtyFgfzpGiv/KwFngPbuWNOsELBklPe61gVPRXyxfRg0FKXT6LOhq?=
 =?us-ascii?Q?PLBp8GMpIVtgfTGK6YkpT+G8VwvH85HSeshRouZMQKbwvWl5ivMREf0ljm6A?=
 =?us-ascii?Q?ORD7BztP2fQMDidke8ey2F0pxtG0BrevCvlJRQ492eY5lRvt267+DF9JAy1C?=
 =?us-ascii?Q?vffwfrHTxQQ6qy+74jpwQBNRWmR3CwSP8feJMaw8R/aayA5KFgMNM375gOOQ?=
 =?us-ascii?Q?JT+5OhKFDymwfAMPJ1EsY9S3jfYabzSZghbQLcnNP1HuDnqoVJ9RugMZiUkY?=
 =?us-ascii?Q?GUnLbhAIPLUfRtKB9Rels1m3CdphEoXLunK8N6+a+7RSptg+RVCi7+dHcLPQ?=
 =?us-ascii?Q?hjWTs4eWyW+sXnDMBA0i3VXXC+fnINTuTe5iMqmECgTGhDsJK8y00gFEygn5?=
 =?us-ascii?Q?rfK5D5YCfuG3XRg0W88wJcgbqCr4Jg4Ljn9KN+6HvntZ+55V1ojEt/BFJ+TD?=
 =?us-ascii?Q?RrXPSoYkb9VgACoLYCe0filh3fiOaUKdnYgPmgBg9JreAVRfvHQlRZ4RKbo5?=
 =?us-ascii?Q?eQJ9hszucgj0+lzJXjkEGsQFD+dyUSL5xhhd4gIPYX3i3UulcGe3pgnt/AKN?=
 =?us-ascii?Q?gBlc8dm8eWBBmlh53+3COFOx700JtTk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8de03d-e70e-4442-770e-08da4ae2107f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 13:06:42.7137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UebBDk5THgUk+bZM4G6zzluti9qrUD89SV1NgKu6+aHqXd2EGdhnjsB7vojSIcgWwbdm5pQs9Ka+XMm8U6Zj6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2725

Add redundant flag for struct mptcp_sched_ops.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index c7d4a9a69cfc..3f570a4ffb12 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -245,6 +245,7 @@ struct mptcp_sched_data {
 
 struct mptcp_sched_ops {
 	char name[MPTCP_SCHED_NAME_MAX];
+	bool redundant;
 
 	void (*init)(const struct mptcp_sock *msk);
 	void (*release)(const struct mptcp_sock *msk);
-- 
2.35.3

