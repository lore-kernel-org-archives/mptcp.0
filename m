Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2057.outbound.protection.outlook.com [40.107.105.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BF612B72
	for <mptcp@lists.linux.dev>; Wed, 29 Nov 2023 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a8AHIwAu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocnj0niEl0ywaKV01D5cb1YTVDIMFJzWl5TN1Co4fqPh8yaEgJyvLezgW7/N4XChLbWu/xyxwunPk/dSJcnWxJjIWHZwaheD3aY8oReVjr0Gbs8V5PhH9OMToQYmxQri312gqhrP7UD/s6VnuKQdelkYHar6jwPMq3VZHhKVPVWJlbTYLzH91MGPiuMoBK2+a2s6H6UIgnihIEk2jw+WY8fj6DYVcKky0edbMs+oHPNE9aKnTVHjfxts39QemNS2Ba4BudR6uwX25JLThFlAH3pIyDpCH1E9bKo9vvu6acjIW/YRvaRoVlXieCnsBca74gpj/abep/llUYM7FeT7Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gk+qvxGruMlhEM5135brL3AmZ2SRDXolpxyH9Vkywng=;
 b=KvBKAK8uYnYsQpBaObtNrzHK6Wemg9zotHE9hsTIcQxw1EiKZ3xOGQccFAtbr5Sy/BSu4KLvBWHOf6bzhCWv7rYZOB8r91ihM9+LHoXI/UNOpqv8AzRq5fI3b1B98E0ZMDrqcvNIIZZ7vtzQbas6MkgR8CjF/iwFpQbIJy2ETNZyyjXrUs32PC58JbSQGc0Hqfdvu0bEx/b3EAfsmQ7s/ibyc5zkXvrq/6rtuLr05Z6Kaef23um/K9/LwwGNmSUH6Hrd6sWyigynmz7ZtSTEUU4KA1rYCJZvWgrbM6AHHfgVLBBJmyaZ58KIEjMNlx16v2LV8t1zMtezWY+6dVD9ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gk+qvxGruMlhEM5135brL3AmZ2SRDXolpxyH9Vkywng=;
 b=a8AHIwAuVS/PkDhOySQFa0u2Pr1VH1RAcIyiDVDIi2xHPZbFXbLghfCA0MFPAFkM1Qdgx1ZHgM0eQvrY2EbbmamRWePQBjyqWL5hFdPNJFLrHuLpcP7BdNIxXB89ULD0UEOodKPBuQrBWs8jF9bnoctXuuQ3ACvrIjzL1GJVExQpB5wETHaFpiOAhEdImHkZCWCu9WzqtH4/R9Ont/bFolwaVNdKNqCTTuQE2bw161R5Ybf3x+/kiGrEQhj9r+MSHRckfDpRfygBVtQJla1QZm1Ce3lGE2YcFy6/U5AHNudxKbIjJnSblCmbfTUBUYE1wYb5SVBmJf9ytHA9kunbKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS1PR04MB9333.eurprd04.prod.outlook.com (2603:10a6:20b:4df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 11:10:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 11:10:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 3/5] mptcp: add mptcp_set_state helper
Date: Wed, 29 Nov 2023 19:10:50 +0800
Message-Id: <d208e183b50a09efc3e7edf818e9ad9d755056e1.1701256112.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701256112.git.geliang.tang@suse.com>
References: <cover.1701256112.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0056.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS1PR04MB9333:EE_
X-MS-Office365-Filtering-Correlation-Id: 72383118-109b-4c6e-e5e9-08dbf0cbddb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E/1/DzsOZv3SYxlhEjZdHTHVJngqbuxZaMui/7nDrkSGHBwVADl0rbA1EbZ86+DQDBs2aGsrlkFCs9935cWBbRSv1c16osEnIlD7rc+nZJ7xmdHIUv7S+GRiF8H3+/BCV6kfu3UuZVo0y8DLPalw24EBV7SVGYgFdRpvmbH58J2CRaPoEbMtBIYel9TsqQgQ9k3xXgvqowbpik8P+um5lHL5gxJpFg2XLSF5IpSYU3l42aXaFiMkhuLixYa5O6JWZFwj0XMKuvKlESrgRnEhTaYeCLqUw+CsBdZTMvbkdidNyi441UCpvccva4GLtSVBZ2Y0ZwWfTRJpLrwQGDoLUPldvD9bFXL+pu8mym144e1Rp1ZW4lGrHTgDFbzU6Ghg5prVZt8kPt2PoUMtIsC41unhv0MoMHW6/mCPUmipzm5Y9279YFzd5HIONCkUn6FERZL1j+MPJYrfujA3IlVzwIYhEO5AGwHkqT648RwsxzvsAW+/z+tQr1/AR7uEl2i0Lqn0cVKcphVAt15yyMTOrKJ19oXZA+lUWGQnKFpobUq9w6HMTwn/gI2IoekVQPIVajJ+bP9P9q2FPD5rB3Wgm8Pz/kqhEXp/Ic7HZY3WG+s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(107886003)(6512007)(2616005)(26005)(6506007)(6666004)(478600001)(83380400001)(2906002)(5660300002)(41300700001)(6486002)(966005)(66946007)(44832011)(8676002)(8936002)(6916009)(66556008)(316002)(66476007)(4326008)(38100700002)(86362001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DGwsePsaW5o7QXsd0dZWmH9UPf/BP0zET/J2pHptVP5+JTQfRBc6dQsGbsO7?=
 =?us-ascii?Q?EQBHelz/dcdsWZl7gT55tBBlgBjO21jgxXqA5h9GZ0MAhWIMuHJouUAYg7U4?=
 =?us-ascii?Q?xWSQi96JSd/9Qbj9QtmIzIcIrT1zCJf88UtUSUPvOmlbgBpi9+OPgEhj/42a?=
 =?us-ascii?Q?gGjluaC09brPwY22dqYwb7jlgQO3T3N/9qY1QVXTJeaHU626YvXZlLX7UtIa?=
 =?us-ascii?Q?BbTyg6NhnuB48VzATqt3cNna4ENeqyNcci0Tv0+sH4DeNikP5TuQaAXMMxxE?=
 =?us-ascii?Q?jtK9Vv823ImcWgyfGgViWPaN2K8d+kNIzAqEWdsybE/8YfEOFFYFnHgXsCz5?=
 =?us-ascii?Q?UYfkownVmsd/o61uGx+WAJLZV0etHwUOiS9Hk7+T84R/tqyZrxmPzb1uaSzc?=
 =?us-ascii?Q?tbe2rWveE3Mx7DsqcmKAZR2UDu75awWCDKX0VzfSCOYN4oVBtL6VG4CFpVMC?=
 =?us-ascii?Q?yhyIEw2gLJRMv4v5/IS3AJKxxvwyY5KiU2gqt772T7+NiqGtRS53X43CRfIH?=
 =?us-ascii?Q?uC0NhF1CaeK+Pem44WegTw+PcHm7NeVUcB5AlrkaaKb8beXQGjoolot8we9M?=
 =?us-ascii?Q?VRXb0cUKL+H+ZTIplTGdq6bM/1fqw7M6Agt5kMfN8r1E7mmpsOKZPi3N4w44?=
 =?us-ascii?Q?K3A2rLxf8bdo2wAymVUJ+NIEHqSKR/LbW7atWK4xUaSSxBAiaWssod0Vx1XV?=
 =?us-ascii?Q?k7kePWw0u8Z+BXwX6S0fAOWJrqEO8dZJTGYC7KTKo3vrJM16HZFiwlB19b9z?=
 =?us-ascii?Q?aA6PiKwca0A6/Pu63vUtqs5Cwj64jl9WPMUB/gHsiq7CCoeq5sD5RScsH1hb?=
 =?us-ascii?Q?jXTXWO/uT8zcIiYGOZnv+MNPfSzqlTG6Pu51ppzHoziKKthZ2fVwCv4XCuxN?=
 =?us-ascii?Q?IdNEmFEmawDVsmAjzKA/Mvc8ktIP0HwRCwduboVw4ujGCtfnIjiHIYtIN67F?=
 =?us-ascii?Q?CarBQe6y66qzUNYURfvEz52vSLXLB9te5MaUf/kLejYPkVXnVbcORStry23z?=
 =?us-ascii?Q?j/OKRMfR2zIWokuws2I9+9V/DFt1U6ZdRvmnn26ZciP1q3V8c1Kl8/WXUTd8?=
 =?us-ascii?Q?MpxqplyQBVyBXzeX8JlVGgtBGg6Q0wdWng/LQCuOIzIZHGiobAxW0nfvx//f?=
 =?us-ascii?Q?NqJvAJ+l7yEOrEfk+Iap4uNjkGoQRSkVqdzD9QNin+DdYVGpgqfCCEcq4gt9?=
 =?us-ascii?Q?UdUERTaG48VVkpOQrLwxo9Yd3c1E/Y7XVLJaWcoSEM/hGEDPy1k1n1AzAS9X?=
 =?us-ascii?Q?iHf2lQ95Wy1q0tHRQRIbIs61z48+tbcppRXybZNpBc2kMJuoW7n+EtOgucq3?=
 =?us-ascii?Q?yO5E3pJdDSGVAbBsUuulC61l5qtihVaQ6NawMrrFzPqEEIlg7YdlAuBIZse2?=
 =?us-ascii?Q?vdMXdqj3QvLnArfaHmd0WnSp6r46i1Hpqp22X89bvWuHBRSb5H7N2s3gzT7M?=
 =?us-ascii?Q?u7RbvgxOC4yOAlA9QqvAvOUB9oGXDmL7gtNnNuEoIf+Szv5DhiyRTMxfEbPq?=
 =?us-ascii?Q?ChVerq6UC/2NgsiGfjsd7iAI5WCBbzxC/RuGD/WOhIAD9dNCb8081INC6LTm?=
 =?us-ascii?Q?1kh4TRxA01MpBwA4+yBVYqufBmGwIziASbfz4kmr5NPWkFZWntaXRDHIHAtk?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72383118-109b-4c6e-e5e9-08dbf0cbddb7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 11:10:59.2737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yn0x5OTmJhYujLOSIjWgg6L9FVltekIwP0WnhBLvmPk2bAtfaGzuCnTmgfCJZjWXZUd1HdUGYAzcjgI8Vu6AXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9333

This patch adds a new function mptcp_set_state(), in it if switch from
or to ESTABLISH state, increment or decrement the newly added counter
MPTCP_MIB_CURRESTAB.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/460
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 19 +++++++++++++++++++
 net/mptcp/protocol.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6956fde61c68..cd0d54d85080 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2885,6 +2885,25 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 	release_sock(ssk);
 }
 
+void mptcp_set_state(struct sock *sk, int state)
+{
+	int oldstate = sk->sk_state;
+
+	switch (state) {
+	case TCP_ESTABLISHED:
+		if (oldstate != TCP_ESTABLISHED)
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB);
+		break;
+
+	default:
+		if (oldstate == TCP_ESTABLISHED)
+			MPTCP_DEC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB);
+	}
+
+	inet_sk_state_store(sk, state);
+}
+EXPORT_SYMBOL_GPL(mptcp_set_state);
+
 static const unsigned char new_state[16] = {
 	/* current state:     new state:      action:	*/
 	[0 /* (Invalid) */] = TCP_CLOSE,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8529b3ae55e9..a8e558bdc54b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -643,6 +643,7 @@ bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
 void __mptcp_unaccepted_force_close(struct sock *sk);
 void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk);
+void mptcp_set_state(struct sock *sk, int state);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 			   const struct mptcp_addr_info *b, bool use_port);
-- 
2.35.3

