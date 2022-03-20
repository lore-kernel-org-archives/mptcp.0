Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26BF33D3
	for <mptcp@lists.linux.dev>; Sun, 20 Mar 2022 14:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647785374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4iw7s5zvEERrVINVLyzL/lgSDArs/eQmsP63FkC7pec=;
	b=QQop89qcY+SyQ8Sp3586TwhUVmi9vdXl+1dIRIIiTueCwvkg+Rj3nhnaBDV4CykonF51U0
	Wmhvj6Q0JurJA+MlCSuMIMd1jVeH8hVKPxBLZjSCsfxxuzFNSzSGPfOwIUKBJZ0U/qwgBe
	5Dbwldcl8bhXp2h8KutfGhqlgBD9Xkw=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2059.outbound.protection.outlook.com [104.47.6.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-20-ziBz8CzOMiuRK_sb8bbBIw-1; Sun, 20 Mar 2022 15:09:32 +0100
X-MC-Unique: ziBz8CzOMiuRK_sb8bbBIw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkhaaCPCgHNgAKg/GTd9v2mYfL6kTk59YcLjgfw7MHRYDyuaIAEg69ZrX8Q0/q36ZPm3zpaZdxWc6qpx9QDcYzK8xVpT0RRxasqKTyxg0MdQyGHhiFFSccc4v42tioDbd3J1dQ3qHsqZ5i14FHCExqe4t7blYMfGzR1+P+ylLhgxKAZvnX5BdlzMEOzO7Gm39GnQCQ1iG3fq162oLJqqrDv0Cabt0j90gxtqVwqvfr7DbuudprS1Rr7EiziVZQRaTvEAwToa8sVYbAIZx39BiPxlK58DKgZmnHwu0dIegaeavb6ry0gvnylYecljz2eqDNXIFZIfSnhRvqNFpbR1Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePBzszVn2fho5okFj9sFkOOiJcmiqWhaLyfHNvwVum8=;
 b=HU8YT8iItD0x1YlTAtdrkKTBjcxnIkI0m0bzSVcSeoOjmyzeHkCO83DMEDFsP9VOYGrbn13WmI4azfIer1IZVMyByrOnto2ADXUEzeiOHfRI2uciL7L6gcxkJajrEXNvXCVkfDyYe+Q3GhiaJ4Wlgd51dSntv4jQgXCIgpyKyD26mNzS15eVHEFjfgSOf7/QCWc+Lqyp2V2Zt3fICaBkpKaW0ei13pJHLm2PdX51FT7U1wfgfqyyrr66tHG1sjMmRHQ9EBkFV+dO8c05aSPZd06qRCb1jgaIPEns3RYW16SsM6ux4CfP94m0E5fN86e5rbv+35CNwTi+i2zGY4dMWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7035.eurprd04.prod.outlook.com (2603:10a6:10:127::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Sun, 20 Mar
 2022 14:09:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5081.022; Sun, 20 Mar 2022
 14:09:31 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 2/8] mptcp: register default scheduler
Date: Sun, 20 Mar 2022 22:09:06 +0800
Message-ID: <d6e5cce088abd4c956edc8f47d21a723a5a77b70.1647784679.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647784679.git.geliang.tang@suse.com>
References: <cover.1647784679.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:203:d0::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdefa165-7160-4f9e-46fc-08da0a7b4119
X-MS-TrafficTypeDiagnostic: DB8PR04MB7035:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB70352D06DBC89EAB42164B6FF8159@DB8PR04MB7035.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DvIUHkKH4s9vhHG2MFXEFyxd88eXLal0Hn6U4UyfXYWMqoaO4QeAwE0VPJTShIewvGwkUZsQYqnA0LBj8sE+fMzxknN7CQGQVx6usYwA5z4LvlBSJh5OhXk59FDYTAGbdrh7RS29CYWy7um7+ves76sbWAKHVJcCoE0CF9MPw3SmPap4qY52kYPyoFvA5S0qQoPl1++fXtXXLom7nrJxRCrr+H0yY6r7hXdE1OoW3R+eZL7ScBb71blAFUT9jcAWw8w5XmzoHevqvwq+kYYRYX7+f4kb98/ZmXYyRRNTpPX071fSLVIJp6lzLq6N4rK1Go/UoG65Hasqc/kwaPKxHFz9/R8hfE+md3g27h3OnZg3WBdyR7pUbWmYunLxXaPKBrCyPk35aDNo0EeAthiEwA0BvGlAT3q2AF0+aZXeB4r15bTK95U7nvMQqbg1O3a6B2yGrPI9m+LhVaMhjI7LC2KEQg2ZA1EDGhka2gMZwWlrwN8DcVvG8QlG47fA9+01CIOGdSLA0yMxK9LidlRZSb3nI91f2e20cjnw025PD2u3fuf4hS0+KLRy4X18/Vn7KPS2bFGaaH5oCPAQGZBrLuiolXFxOwtV8e/7cPGERAQBc2CjqIx9ZlxFi3lUYLKaMQ2C1Nb62phHBXyESKzfjRoOcRS8aQQhciotk3S46fDf17FfeTWXX4j6V30Ze3WB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(83380400001)(44832011)(66946007)(66476007)(8676002)(66556008)(4326008)(6486002)(6506007)(508600001)(6666004)(2906002)(36756003)(86362001)(2616005)(107886003)(186003)(26005)(8936002)(6916009)(5660300002)(316002)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gbNxHhT5dmRTzK6Bt48Qwo9+VIJj8bYT61zW3qJErdYeW4xti1zG3bJVNjJ6?=
 =?us-ascii?Q?50+gqcbdyh+yVgNPxB3D/ggdgCLdm4jvIjWgXKU6NAGOA0/TGa8e2v2azQO/?=
 =?us-ascii?Q?LrzbbbCsAGXuMPCOY2tEQqRNAupS5UQ8ukIapTxCE3v6K8Zbhp/qyIA4PW0t?=
 =?us-ascii?Q?bOCKXv1MIxASsNBKHv2Wo40W3/8MOMm+rHfhKDz4GqrDCDvOW0Z3LZp2XKkm?=
 =?us-ascii?Q?308C1M31O/4dzQsa2AGLVEBKmiaCk760FEjl/Zxv5U/M123KMtRNLC/piHhJ?=
 =?us-ascii?Q?CFXdcXqoBoo4tbNUSXA+5X2oHt07TpxABEmW01QGb9LcnDdLpzU6rS7evHkN?=
 =?us-ascii?Q?WPlKMsDZ1kDpKZMGvCaLjALtRWJcJlgsLo+IxgPnF2maE/hg7iIjEEAellRt?=
 =?us-ascii?Q?s94KTjFYQOKeZpZloxXwNyrrZ3IrNGuj6WBBqLuRd6dDgHUqu/yXQpgFsUrs?=
 =?us-ascii?Q?2RWHt7XLWNEnSA0qCpI5cF0Eh4EexitNUTJ2LEIqVUltI/+PwcZT9w5wEJxs?=
 =?us-ascii?Q?Pi1nh5O2B4zxEZCSSyi5u1/tPI7rZXJkaNRXVInblhy0Em5WdhMJb2WX0GSD?=
 =?us-ascii?Q?KbLyOc7jud+ynz/DTV2PkDEaCsRdnhf6nkNtsiv+1rnfeEkhRKgtDhgY+DzY?=
 =?us-ascii?Q?Tx8w/HsZgH+oBhjsXX5nxn0cF8furhh3Pqu0TEIfawwVszinATAdrPKeFlJ1?=
 =?us-ascii?Q?Oth+cTRKLzeTGYoUSSk/Yk1TfemIouNgu+dLQeKfdBFlHnc+vzAmWTeyIRHt?=
 =?us-ascii?Q?6PNS54evELSvyEKVnqcq22R1mBhluFvb937nW07TEzxVTLkA9RiYPzHd99TA?=
 =?us-ascii?Q?18gcaP6jwKVAoC/oA17wqqMq5jaRCvCnr6I7MFDCsTWucyVbDoa4PEg4tftg?=
 =?us-ascii?Q?Ph26J4kU9NfPdnHBUMA1x/cyYSOv3nbdgETZ2Y/+zdGTaVmyKJCmwxVzzehe?=
 =?us-ascii?Q?P5b33AJLJ7jSl+0/UQEggl2PhE2BgCYxff59Y5b3O42Ew85OSHNVyVm832/C?=
 =?us-ascii?Q?7lT6JK77CvQad9+1Ggq/YXr+2fqkWT5DIHR9xmTq5iS2tXkBX4BD5kN2NnKj?=
 =?us-ascii?Q?MYhaUhkRTEDy97XS+xLz7IlgDQ9gDPC1Qjmm65YcWQOliLkQku6vQDqi47WS?=
 =?us-ascii?Q?fadYzLx0Bg1u8/DN3Ws2E8GX2e2OhfpJapDD8k9GdVbujr2TiwOSB0hZ+upl?=
 =?us-ascii?Q?N+U/wKSJhFOAWd2RwqHubE8Jj2ehZdH4jwDhXIyW5tCAb2b6vHclZV0xCok5?=
 =?us-ascii?Q?4BRFdBvUSUhetq7iQ5qSPA9zbWBZt/SnTtpVSZNo/RJ+bIelh4+xJlmFugvJ?=
 =?us-ascii?Q?xecbrVppKIcFp5I1cRDnEy3CTqpGbD2WVl0MRJoffYCiQabkB4FRQMRj3E3S?=
 =?us-ascii?Q?yi4X2J6/Vsa+7z88NKxFDOY2PG68Ug5jAzn0AfUgUb9WP/4ILz8DiNiJMPwI?=
 =?us-ascii?Q?jd1VkhZoy+BLGy3ZoOPlzXnKuJMDq6mHEVJOqV7849WqPLYpVtV8Iw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdefa165-7160-4f9e-46fc-08da0a7b4119
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2022 14:09:31.8902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gYUsz0HnQuJRLqI8LzlvLoPGTEZu4Kzc9xzr5Yk97GlQiojsP0v+HppNU7P+JIKCEk2Gw0MbieGAODQwkc9sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7035

This patch defined the default packet scheduler mptcp_sched_default,
registered it in mptcp_sched_init().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  3 ++-
 net/mptcp/protocol.h |  2 ++
 net/mptcp/sched.c    | 11 +++++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fbb14dfe62b3..11e19ac9d5af 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1424,7 +1424,7 @@ bool mptcp_subflow_active(struct mptcp_subflow_contex=
t *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -3743,6 +3743,7 @@ void __init mptcp_proto_init(void)
=20
 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_sched_init();
 	mptcp_token_init();
=20
 	if (proto_register(&mptcp_prot, MPTCP_USE_SLAB) !=3D 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 500dc7b3fde8..c186d199cf5b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -608,6 +608,8 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *=
info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+void mptcp_sched_init(void);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 53a1bdaae2f1..331e6517622a 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -53,3 +53,14 @@ void mptcp_unregister_scheduler(struct mptcp_sched_ops *=
sched)
=20
 	synchronize_rcu();
 }
+
+static struct mptcp_sched_ops mptcp_sched_default =3D {
+	.get_subflow    =3D mptcp_subflow_get_send,
+	.name           =3D "default",
+	.owner          =3D THIS_MODULE,
+};
+
+void mptcp_sched_init(void)
+{
+	mptcp_register_scheduler(&mptcp_sched_default);
+}
--=20
2.34.1

