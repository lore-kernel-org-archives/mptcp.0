Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2055.outbound.protection.outlook.com [40.107.6.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF8815CA
	for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 03:36:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMtJvtfjADmLH5LBpjef17nypm7hkAj535KO4VBGYX+PpdEZkn8i1Bejh3hcKOVgNUYGu6VUM3xP0gqv6ZmSwjIcWVPk8eH0Ye1bSG0GToiO2WYc0HurNKbURfQ3WARuZyyEjGhQ5q8N5umJA2zZ5GmBEqbADJuWSLbpchcP22AfY2YuZn9MbMATf5sD45eDkkw63SRf3JAec0djm/rW0XoATa4SA6gtCzfIxpYJ1QJIJ0KetZYkGBpIePYw28ZXNF9GfHVBgVV9OL8109boSkG/hfMk5WfLWy2bcgXBaEhaXj3YvBbFLrkLdwfZHi9GfTlb0vCZY8u9NgyIC9DgJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/ULk7MMDj6LW+9yZ7BSsPVclzKixBv1u9K8ZfL/Nvc=;
 b=Lx2/AmCu6UI9eWWlF9zeGSbHXurfCv9u6YcH0Pl05WNsk4oHGk51WEf/5Bfon3cgLjXwpMmQTBPzV+YwQOCIqyC+KMsUxp6Capmn/i0Gyy5e90UVpC6tvLjgngmeLQwLB4Fwkyet1c5bkpFMDH+eQ7gI/bZLahgl308m2fs9dQ6yNzfEzfrbwJVnYjYdmeO6Nei+cZvn+QPlPguKQwxx1xv6aqBVq/1Mu46tBG659bz1eAP2coKAtuKRI3xMHnUxlBnXin2vB3nPiDhUJ3PhpF0g2tmU1uFasZyYNlHn2pwlpgnj4EN03eu22ImGwW8iZVusNPrst9v7aka+NuYVng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/ULk7MMDj6LW+9yZ7BSsPVclzKixBv1u9K8ZfL/Nvc=;
 b=k6QM96L7OFsw7kGX4FOi+EVg/N/kFH1bwz+TByvv4s8OfVce+Nh4LlOzeDAfLBdZzeqwRL5ZUWFdvy/S4IgDQWzpfVm8tMMuU9zzqXIJ3IywvZguO9z54iWo3l+QLjbPeYi7NInmTYFiLQh3+AUQ+c2BBfXRK2i89F3D8Wv95iFJAZtBGCdEDCYOKvbzFzgg+R9T8rhOla21al/XtmmRjDMhEAwoPEYm1OziO5VvhfRKHSJBfQOInxCu7a17uUVWWP5pk1A2NEchMV392m50LpNDhoAzRRvLOc4BRKIvLNRRzGOSais6XOzWHJQwTJvebpDdeazBBdpyrnlC1+70+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7081.eurprd04.prod.outlook.com (2603:10a6:10:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 23 Feb
 2023 03:36:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e%6]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 03:36:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] mptcp: add ro_after_init for tcp{,v6}_prot_override
Date: Thu, 23 Feb 2023 11:37:41 +0800
Message-Id: <f2d3a14b9382645f8770ad6496fcba6db699ad19.1677123443.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:4:186::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef63d29-9502-4695-da49-08db154f2f49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x0+wlukhWEMUHit/tGONaPVa3wALChmgXx7G45s1iMfq0bWr4OLNU/Q7FMREi7l5RwaOBmB0tBdcHIYiKLVveyvsCQz2YWjxFm4l0MV7fkHGViOjBJr3Kfxn1eckIjZRj4w8l1kfooiL6EifrUcgrNllZdNMjqV5Tid2NRIjJvYNZGP8dAQuqtHS1ZQjsLmLAvk4iSanG/dK8oMLiR725bSKays6JEU3qy85E4bShLzyOIQV3EC9feHi2t7kKSggtv2FTdTf+6eOkB9p+RZXzDIMgD7fqRc/JbJswLUUWaw+XC4tjkULmbX8bH/OstlwOetgwMrKBGUoPbNmKfm+JsQNvbH4ECZnypmSA6tJDOEysGRoqC3ufTZzl+QUCXEJbl24SDZnfNF/ctZtbjTjSh4GY3a9da4F4hyUB0z2JWq0/6b1tPDZRCt+0VXw6zZfCtbxoC0fafk7LuTw6Fy8LBzykFE/rDsrp1uxfZnhZqI7lFghqgQ1+3C8Rnl/ozR9iW7eQCTL+8t/J+WLssQMq8UIH6sXqkRBsKGCzOkRmidyhU1w1bsIkirPw/DCTH1tjZa+GUgTZGJ9Ufx3/Gw2/8gKZs7tfZ3LU/7Lip8toXQAzx67dB5YoNZd5AMrrHsOmYzVZNGgxPcYICsQmuJDUQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199018)(86362001)(83380400001)(2906002)(44832011)(2616005)(36756003)(107886003)(26005)(478600001)(6666004)(186003)(6512007)(6506007)(6486002)(8936002)(41300700001)(316002)(66556008)(66476007)(66946007)(5660300002)(4326008)(38100700002)(8676002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sO1OZFYLCrVjw0JtnZPALftv/Fn9m7GvjuC+kxD8EWhm3CJ0k0Inc+NoJEXl?=
 =?us-ascii?Q?6r7lt2UeQytKl8ZR+wDi64uu1TPOJWgJYT+6+weaoZtBzVZka55rKO73G5uK?=
 =?us-ascii?Q?j6gDdeS2fMHA0+uzXD6Oy5mp+ZRmJB8iV04uaBmyOm3fYp8c58QXD08qXwJ8?=
 =?us-ascii?Q?7npsoM1PUB8E5hCub4P9P3LGqiZYP52iu2J3xjqchJY+xkLlbi6j9Neml+Ib?=
 =?us-ascii?Q?mhloQYMh36/1SFu2zBPeLh5rbWxE9fqOWxEtCq6FCaxGp4vw9qlYip4YbFa5?=
 =?us-ascii?Q?AQRJ8nuvTrEC7jPU+BwA3cUTkrR4qKowblDVCS4s17drmGDA4ydhlJLkiOxI?=
 =?us-ascii?Q?f+JDt8RP9sLn/8QbooC/TU/cu7rikLnXpCf6FAQqmXae+JK2mosLU0VSOJUh?=
 =?us-ascii?Q?uUFl4kfCKxNYMTY0GyS9CwAvLOGL6+boGu23mhJ2jtOwztkC0pIuKqtfRkTD?=
 =?us-ascii?Q?l4wpJBI4buq3/WwZZonbhixINVpnqq1T9jMe70pUP1DbGNNtz9idahm0xLF8?=
 =?us-ascii?Q?GBLhY0+QOcVQ+XuO5FpBUTa9N8IDfRocLR6ELIvm2QMDRnhPzvf04Rj8T1BJ?=
 =?us-ascii?Q?0ZOUXALmt6zeOjUUIRRVw/sFH2NmzXuXuvlIwW2+bCyvmlGtnmvj+3H/mr6H?=
 =?us-ascii?Q?ZXaW2rWw5x5kdYAhLKZkb2XRQ5BGHy5CET35nqXbCjuITM5sP2QoF1zRsboc?=
 =?us-ascii?Q?u0WPlJjUaVwDj0l7TWRoEGGeGPUhebLy6zURLjjHYunX5NQ0mQ8yG5ijV87+?=
 =?us-ascii?Q?+yrPUVbLPkiGsczDPPDF0/5CsO56fVdKDQ3AjV/nmiqrEwdAEMpt4rUS/V+g?=
 =?us-ascii?Q?8Nix+jAVNcG9YKf1lHZqacJxqbSz21o1e3FEugoKj8HbCRXtiIjijQ3No7nG?=
 =?us-ascii?Q?PXikgsBgIz5lgv4nbpwm512t8vpv1RtKHkBq6fmBp4EIqXornggoVXio1lcB?=
 =?us-ascii?Q?I0ae68i3W44Nlzh81wiK/DuB37g+OWar340W8GAdWe31QDXLlCEtSaTxS9qq?=
 =?us-ascii?Q?a+YP6P2o91A0m8BIDFzqAP60RET2k2YDGi35Se9gW+cEdnP9jsmvU5Jl4Sc4?=
 =?us-ascii?Q?zyKqxECtnQooPRyNcjEpN8BeNiQdbuv5WFz+/RKLaoth6choU6sXCS1kUn2X?=
 =?us-ascii?Q?lRgcdjEZsPVzhSkhk7fIEutJuii3oaFdLLNhYLHfNIVwoBFjWqsHO2BvW89r?=
 =?us-ascii?Q?T0Bn5Aarb3rLDE9ltn+oK2kRSXZnAcCSvybMoIjN5EWF0b0h4xKjgsKLlTwq?=
 =?us-ascii?Q?IuBSQc9VbLALTZOims/3gMOnHm0+kQ79ihBRHxGxeWNfFeM4mklpMhknsqqD?=
 =?us-ascii?Q?XDvEHOIMeL1wq8KAKRpXfDhbMQjjzLuQS410aNGJVXRmeWuquFlWj0j16tav?=
 =?us-ascii?Q?yjxFVYlL2lcM0CkW+60ZXCC70PfagutitbeRWDcTDpJP93pQ2I2t3kKBkIHr?=
 =?us-ascii?Q?iVuzZmxcnvpJ7Ml+SNxG2g8z+jYQPq/jcSW6b+WxPQBr9T6mFj45TiY5WY7m?=
 =?us-ascii?Q?Kw0irjHf6gWC0xRj8CuNmDrRjFXSyZrHfZpBXgbmkEfFK1UtfUl9Qvuj3QtE?=
 =?us-ascii?Q?8VooXGlpWcO6tcIeu6CQc0pEm6SYiPnyZL9QqJPTpFuV9ZCK4X76k74yHZhE?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef63d29-9502-4695-da49-08db154f2f49
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 03:36:44.5525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fsmv2M19c62Yd7jjAwd+UFt1kqADbguYdlKbcf3HeA8vB8Bt9xqDgjwPlJhlxtN4e/nxMbElIzqdABlS5QyuYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7081

Add __ro_after_init labels for the variables tcp_prot_override and
tcpv6_prot_override, just like other variables adjacent to them, to
indicate that they are initialised from the init hoos and no writes
occur afterwards.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/subflow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d3e00a428c7e..3a71b3b05935 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -628,7 +628,7 @@ static struct request_sock_ops mptcp_subflow_v6_request_sock_ops __ro_after_init
 static struct tcp_request_sock_ops subflow_request_sock_ipv6_ops __ro_after_init;
 static struct inet_connection_sock_af_ops subflow_v6_specific __ro_after_init;
 static struct inet_connection_sock_af_ops subflow_v6m_specific __ro_after_init;
-static struct proto tcpv6_prot_override;
+static struct proto tcpv6_prot_override __ro_after_init;
 
 static int subflow_v6_conn_request(struct sock *sk, struct sk_buff *skb)
 {
@@ -926,7 +926,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 }
 
 static struct inet_connection_sock_af_ops subflow_specific __ro_after_init;
-static struct proto tcp_prot_override;
+static struct proto tcp_prot_override __ro_after_init;
 
 enum mapping_status {
 	MAPPING_OK,
-- 
2.35.3

