Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2067.outbound.protection.outlook.com [40.107.104.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C65A3F
	for <mptcp@lists.linux.dev>; Fri,  9 Dec 2022 08:57:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eODzw/rrTjEhN5fBVvTo0e6KgwcKqxcZ23U2A6ZTrysRC2vFCJw1b3hWJTCgeVQ/xW7kKfNX9hr/g4NG2C1NoiF260TtmO9UVqLMCsaDloP0cwgwmnVDYYA2HKOTpiXAj7JDEo0ycafUQ4JAlItZID5rxrLcwYV5kJx5EKMVO0LNrSnuBo0475r6DwYe/dUjqPXizjpWoTnyX5UxoGdpRnbILN7oGDgPNvbLPny9RlSn0/bPrUkoqdwo+pcvx7j1CsNgtMoXDjUUiJVSd43hYl5mSnWfCVcg0iqvD5UCuacX1++WixXmFpNDvTuChqL7eoFjJODu6b1cXR2Liu625A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPzhQ+71vSntv52sYcAbTak1Knxw9B65U4rBbSFwvqw=;
 b=cv/Fdz7c9u6CgTrAVKW8+jKLHPhJJTgMaS/L6DQvQfHu8OEmVILAqSht/Y4bvwCIaTVCY893yUWbljipYJB9hYLf55ULs7sMv/iksLD0XZ3QeDGbdY1cydut2EPMX5f0VJl1SsZ8Cr+B4y1b5Rv9I15xUDsJ6lHHw7nBogW50I6uMl3Y3+D0ZxeDfFe2NM1ebuyXbGR/QNycurXFDXAd+a23i+BtzBCDkxfL0/4FF/DIMiG7K21Pms4cxn0ZPQZrkM2Ci2i6ussgXudNLDWU5RVbhYXvG1aI+m4YkItj7gh0BQIlbIYa7CTPoyTipYHKx3E1oRvCVOc7grsEyuCVWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPzhQ+71vSntv52sYcAbTak1Knxw9B65U4rBbSFwvqw=;
 b=cyA2E5NWbZR5urA0z7s1af2+b1lwT45ImnTajQ5j9/nJs/SAjFZRhQM4dhC7tQPCaPsnoZclleZPa52HMjDh1Ut2c5oIHt3tTR2sYEEfKEZk9jnSSjxR+prI9f8cC/geD7hQWZQ00ZEQpS4xkYwpVWglv+wppJ5tYGpfNdE1Ffjt/dwsfa409j0GgWFLpBTj4X2R0CA0xe87sliCHurwmR5eAsYss8AZ6DWefNfMJ1qUzCPsYaA3Xiua87J1oAncWlDuZFE6PF6TcLB9E6NTaCvYVOueWGjtzp91AYByfRVwY47qKTbBRopUr/Be888en65ZOBeVVJqvbRhCtcvR+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9257.eurprd04.prod.outlook.com (2603:10a6:10:373::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 08:57:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5%6]) with mapi id 15.20.5880.016; Fri, 9 Dec 2022
 08:57:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/2] mptcp: use net instead of sock_net
Date: Fri,  9 Dec 2022 16:57:42 +0800
Message-Id: <ae15815f27ca643fdb86beab5e42222449cea46c.1670575887.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1670575887.git.geliang.tang@suse.com>
References: <cover.1670575887.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9257:EE_
X-MS-Office365-Filtering-Correlation-Id: 8054d501-956c-4288-38fc-08dad9c37623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6jR701iKa5MuLy64j7tFHsAjUIQDIR/Lg/C8ortFP/dJxovqZ1W265M/xDKOVo+tNOHe8AYqN2iB4cLDCBIrvINgtNxSZb3KUSNx23dZPfQQHPPxPHjBehjklQm8M47/a7U6sDb+kFpoRQd1CDk8nv24yMeaNn2gR6/1WZdABOcT4J/Z9bKh6ebOh5pTDqeIyuRivNj3KIQQUlFOWSdwc+XyvpRFU/yOoElr4E62EO3v6iRByFPKK23+F7nzxfrOiZNpSAvUx7b6oCEpd900ZvfdFQCVPY7FEJFDrEM5cERJ7+gq5JyoB+DiolYfoNdfmSuh6FTbX+6m3WV07D6jWnmGLv1F8qltlWlvQKDKMa+7lVywIqCuTFGIQ4BlXnBRlEH/RbLm6b04KVVzLZM4y+sLvru0jhUJnyVDgQsaGtuYUBqO51emRDyEHFzGDDBIeErbbzybR63B490iGVKFiQx62P93ZKKp0vgNMfA++dmHyfutlUlhBo9PCqvBuSwvNhUO6cKN9lWp7d1FRS5DlUwbtZtpdD9XCuutyit08ypZ9FJ68skM50w7OCfSBpt6mL4oEjKUmwo9JJQB1CKvvdC3b0FZYMl38JCbL4KDSGCHLQ7v8NcG+eIYOWOi/VE9XunR9EVNhQXXBI9h7oN0Qw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199015)(83380400001)(6486002)(44832011)(86362001)(8936002)(5660300002)(41300700001)(4326008)(2906002)(6666004)(186003)(478600001)(6506007)(6512007)(26005)(2616005)(38100700002)(6916009)(107886003)(8676002)(316002)(66556008)(66946007)(66476007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8KP2YP21ZohcPpiToJrxZuVJ6QgPaPwqJeyvGtVaYRFb2QK3IZMWd/mVF2ED?=
 =?us-ascii?Q?qJodNAVmbgN+LfLBiDEVCYCtXr7GFR4oHRv9iGQTM9BuORw27H4z6ZRvV56o?=
 =?us-ascii?Q?k3Lv5AKQfwWRHrgR7DMtiLXFMmbPQIoS2+oZfPq5ebFLHmpXmLknJZImvm6B?=
 =?us-ascii?Q?YtupAkBvhzfnr1ex8/bkWcGunXNsvFak3THCXggHzEXHXjGyeoCr3R1CiNyd?=
 =?us-ascii?Q?+O2NNYax0Zz+DcaGFFpmm61kheNl2hrPx1X3PCkqX0WXqgaNssKxIJVeuZuy?=
 =?us-ascii?Q?Ni7Vqj47aq/2c+Um1ofEv/PlCZxrRCcpz0K/1pTxLyKGMnqZJwXOcTGTwMi5?=
 =?us-ascii?Q?PFDBetRskloIN2pd/+WsRECb0d+XYGTfvrAov22hdxnsxpifuuJ4h4PoLleb?=
 =?us-ascii?Q?SbeyW1fG8SneaXL3ukWAmSPJZ9Zf5+XB/at/SUQUb3ryhBcL3TIogWrroS6b?=
 =?us-ascii?Q?jr2n41QFMWwRIpAjWcAbp1AA2hCNTw01ZjVCnaI9yFWcqcN7onRiZIrDw8mN?=
 =?us-ascii?Q?lrhwT6G1hhqRe5sw1woKM+5QuNExWFxdKrE4rx2L5o6IRHauwH2FA+Mhk5rG?=
 =?us-ascii?Q?a28a3x7VDoWEypCkA7S0FpBiD6N0Pob8vPQzfdCJ4JjBrVFTDW3cPt0SWndX?=
 =?us-ascii?Q?gmeza8wHjmxfxG6Xj0FqQaUUuZ4rDrjmi1GheWL2FGTsDZ5RLMN+pRt9qCjq?=
 =?us-ascii?Q?h9M80B+9Y+UWzwf8AaV+GvQ4nJ/BDI4v2h59mR19xFJhqZsceOBp1ZR67Aw6?=
 =?us-ascii?Q?N//ou5JC1vsH1xe1HH6KBZHdSsr/Q1L52c7v2++XbrPCGo/xOXj1CEV38C+X?=
 =?us-ascii?Q?8zXzpeYBpNHAbTnKYaWZY4+q6J00PI2AnGvEHlZhE9ivxC6YyBeruaLFgm/i?=
 =?us-ascii?Q?C2tJ/yrRYTXWCzrwTgW5PLZy/6d/Ti6wk3NhXtROTlXNozPN8KyK9dRfryD3?=
 =?us-ascii?Q?g6tUBkRpq6zKLHyrM//k96x1jiUoE67UVl16YFkchY0LpuqgjLmisNGeHW9W?=
 =?us-ascii?Q?Eu7I3IYp+pgpBMbCg4v1JdeYEZ2SDXGJ4P+BXT7NRB9w/NiPxZB6x55pgqzd?=
 =?us-ascii?Q?g/9BEIydezLoOH+e/sHWq/ztd2mZrFrijZYFL0GnfgVodPtVCRk4uihM3/w+?=
 =?us-ascii?Q?InXSy5Scq6nGQRJ25+z0gFrJgRMLig72V0yJVFMO0ThOc9b+u8AJWjdGhFRr?=
 =?us-ascii?Q?odlm1OxfUKHA8s+P7lAKFkqJd7rxTDX4CJzphhTcwvF8ZRa5gSgPgmERtEuU?=
 =?us-ascii?Q?P/RQUIthKQZuiAp8heVWJdcAOb9JmKI8Ab2+ClU4QOv25mco5j2hO0zBubV5?=
 =?us-ascii?Q?slYT+bP57KNXE4/fFIQXmd1goRHuM83Ju5o3gL4TFYs41RFHmjBUvPdmLp22?=
 =?us-ascii?Q?WImzd8LnB/0qO4Fj3LFI6/4QyxiLLRqG+5cPZKgy30H6ENAeYjIpEbiKWZfH?=
 =?us-ascii?Q?BDUJx/ka/v82j1Qc47nHvZmgkSQLWrgX/wAJ1i5kdXi8MkXw0P3fAyfXwFex?=
 =?us-ascii?Q?491hMG35kW5OMxH2tkd5Ae1HAV0lmFIPoZGl3Rp4KnvKXRr7i2y8DnDdZqu+?=
 =?us-ascii?Q?ye+PYjvr2HghyKspz+YNTNqr6Fl4aPy52BmbWSqi3qb2IOR0WiG4nqAuoks6?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8054d501-956c-4288-38fc-08dad9c37623
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 08:57:55.1310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bKqIB0GYqKn4nQ+BOmKOZej/zktZnh0tx4nihq2plBXAESGQnG06ReKICNrO87auOShfGWD0VEIm7F882/NjzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9257

Use the local variable 'net' instead of sock_net() in the functions where
the variable 'struct net *net' has been defined.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 5 ++---
 net/mptcp/protocol.c   | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d20f1d969900..f2a43e13bacd 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1140,7 +1140,7 @@ void mptcp_pm_nl_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ss
 			if (!tcp_rtx_and_write_queues_empty(ssk)) {
 				subflow->stale = 1;
 				__mptcp_retransmit_pending_data(sk);
-				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_SUBFLOWSTALE);
+				MPTCP_INC_STATS(net, MPTCP_MIB_SUBFLOWSTALE);
 			}
 			unlock_sock_fast(ssk, slow);
 
@@ -1900,8 +1900,7 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (token)
-		return mptcp_userspace_pm_set_flags(sock_net(skb->sk),
-						    token, &addr, &remote, bkup);
+		return mptcp_userspace_pm_set_flags(net, token, &addr, &remote, bkup);
 
 	spin_lock_bh(&pernet->lock);
 	entry = __lookup_addr(pernet, &addr.addr, lookup_by_id);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6d03bdcda33e..88c019c56369 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2739,8 +2739,8 @@ static int mptcp_init_sock(struct sock *sk)
 	mptcp_ca_reset(sk);
 
 	sk_sockets_allocated_inc(sk);
-	sk->sk_rcvbuf = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rmem[1]);
-	sk->sk_sndbuf = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_wmem[1]);
+	sk->sk_rcvbuf = READ_ONCE(net->ipv4.sysctl_tcp_rmem[1]);
+	sk->sk_sndbuf = READ_ONCE(net->ipv4.sysctl_tcp_wmem[1]);
 
 	return 0;
 }
-- 
2.35.3

