Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2056.outbound.protection.outlook.com [40.107.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD00C17C9
	for <mptcp@lists.linux.dev>; Fri, 26 May 2023 02:16:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVAi2l2o1ZPN8y2mNXpARngmgat0CuBzOaY1JClFdLKRjYuF/AoXSfLiF6M43+5U5Ere9XeVr8c9SHGTMH3+puJsTmsMC5cQEWXWKm6Bpo4Dxn1vMDhZFJh2BOqsR+IzOLuWNOKZDBgUtMZywp8Klj9Fp0kwGlYrBoyZpDjhvEhWn99G0GyQEMYv0ZKCFUJUxSRGdS4P3dw1O+bC2/oVGnol8cnpklqyEnrmhRz4nzVnt7/7dteZLEETpPiGwnH+9okJvhtwTZFukkOlO/zqnW0Txu6LkpioBYjNy+uYp9G3iStRqaPQsQaFArzs4IYxQSzk9/LwsjDdRsAe1a2CCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6dlJvmqnH/DnlcQ0YYS+LdKilIBArwhW5gjE5sagf4=;
 b=Op+ZnlJ3I26mjmwcAmMwNmqxGjWSxkrpMocHoK4LoiZ9ExpRVlQiQ415OcTGB3Qo3q9YPLUe4+PGBwKzfqBgUQivG6nJ68itCtdXLYghYDwT9XoWQxtqbEiyWJjPjQmmJVoPP85/hdT9dYTAksZ5ORg5NiwqgFXF8FwPeiWQDIW90wwdW1CBbcuJVPdOI83yOsbEFthsmn2X/+0J+uDL1xNPPELfI25LqHCDfxe+ajlVjmKemdmO+mi3UPeaAkcJp1vDs3GcpiXngIgad1ltJopXxloNyEOvIkf80ABqq/CTeyPG/IXSbwUw6Ptq3lQIgzAEHimddsvE/5JcQz46Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6dlJvmqnH/DnlcQ0YYS+LdKilIBArwhW5gjE5sagf4=;
 b=4MrmLh7z6dvKivrSvl0lia+xrYlXStnrLDgbAGP/bd8Sp4/2PyVa0wbVlaape+r9GVDV8b89Q2qNRtwxjoisedU2UrJUhACbETLSBscRiTo3CxRI64LVsx/23QpUb8WRjX3l6OIkjbU2zW6uA2U26danQ4PZb2Jz+AA4HQQmIy7UO4XYSntshsR3XK0g7OFRBiWl36P3vSQWcoEFaF2IluVkGDxdREl4t5tvXsEh3Hq7ZT0j/7MIKWJxOU48jrmsvqqpBAdK2fAvbJnIzoPfnGySL/tWXcsjsAaxppFzfPNiESWlKMGEGrj/saBJWd7dg6tmfjsrgma6CyY6E57vlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7466.eurprd04.prod.outlook.com (2603:10a6:102:87::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Fri, 26 May
 2023 02:16:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Fri, 26 May 2023
 02:16:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 1/4] mptcp: export local_address
Date: Fri, 26 May 2023 10:16:08 +0800
Message-Id: <c8237ef479d4db0fb3c170e48d7c991d274816c4.1685067241.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685067241.git.geliang.tang@suse.com>
References: <cover.1685067241.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0245.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f89e48d-972f-4eab-e5b0-08db5d8f3a87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pqqimMnwz+4m1L9X7EWZ9uq0yrBLtqyTg2WInOr5eMGW8FExsDz+5jjbKYj+bulYdI2qwXS0+oK7fshpCOTeUimUQTMiTPkqQJumhtCKtkpaerEv4NntT5bi23sjgg3obrRQJW788u111d07htQIHbBAfSXRFHFwYexDaxzr4a4siHC3bJIvrpuIbcMPjj+1vpf7m4uSg34BgOiVGmSJ9KQ2BgfVGPd/yHVZGGVE1+cfOOMOOCMtw/9EfNidNJz7IhR2M4mRlK0RDJV1aGN1lDFWKBbWBzSPiau4eXDISakIbM5BNWKr7c8WdFIp/8wFNTQ7cE06HWn3JO1ftrUm87yrRdcp7hbHKFZLXfSax+71PRUqJV73ZEJN4b/poY6ZO7PH6CW+9zueQdWCweD2j16TwUhK4Ne9/8qXiRYgafbmIvEaSqSjQNGk7CimFAE/7odKscsNGApF9xJZjhNZ18ZWwRgFC81mn3/YGgLZAmGhayQcoOsmry7o81w/5Bq2By+sXgxSHS4rK6b1kFTZRMMciWLcWHRqNeDcRKa1zTXrqRTyTmJhL4KYgoSp2bHL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199021)(2616005)(4326008)(6916009)(5660300002)(8936002)(36756003)(86362001)(38100700002)(2906002)(83380400001)(8676002)(44832011)(316002)(41300700001)(6666004)(478600001)(6506007)(6486002)(186003)(66946007)(66476007)(66556008)(107886003)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cExnX8MHXsnTWU4in5SfAu68b13NYAyXgtFyyK04cGsI0wQ23fYxTiZbo894?=
 =?us-ascii?Q?82GUFXuhc84VnuXpDFKwnvqy8I8yL9odQ0DlNMPB+dA8n8iHU/gz7phNDSBm?=
 =?us-ascii?Q?QFrOtrFG6I5CWPviXPUQAXlPDEAyMCHaLArB2mk0+bDTAoRcc19BwjyWvKfs?=
 =?us-ascii?Q?m4pLW7dqe1Zc8vChfQKVBwFb9KZRJNDH6ewiuibQVKKypVLu4siJ0pl60P/b?=
 =?us-ascii?Q?m+10HoNp09rxBA6iMkTlYc6Ut4Oc0ByJlO1P9qxWbWzSrVO49v312Nng8VQQ?=
 =?us-ascii?Q?Jwk+NFtgxJsTTFJKTs1p6hcdiZkbH5dCOq9AanfkbS/9QmgWwRH0zMVf9D66?=
 =?us-ascii?Q?6+vxoxbnW4HFQhuAcVqPW1fLXDVtrYhcbimrZoZgYWeILyO1oWZ19MGrThcd?=
 =?us-ascii?Q?HQQXfYBHMSVmrOEy0ZUDkGL/OGep+KMKeHbepPTUJvIGgXUM2GaNscmZwjqU?=
 =?us-ascii?Q?woH14ghhkvxowmUqBKWkk1BSgn3pQ26fxrOeBfgPXZYPtNP0hBokPDwfvl5P?=
 =?us-ascii?Q?I/Ly6hGQmQSUNJLHlEfewKMueCzy0jYWsf3qkeDppwdPp0oh+PDUqa5BGvQL?=
 =?us-ascii?Q?t069sKLsrIU7mWTFBowXBM3UVUQRkf9TemHvsAxPoq7bclaOTgLb8qysVg5p?=
 =?us-ascii?Q?Ktr29JNNM0iBmGVNBFscjyzzco8EkXjiPimmiMi1ltnYMUr/oRx5xFNcuXLz?=
 =?us-ascii?Q?rrcPkjVwf1UyDPxuCvcXvFPwGGKELdpK75t5Z+5X8qrgqaEZCBkPSJTuEGcK?=
 =?us-ascii?Q?X/ArvflW8kRGElwp1WUShYk9ZKpGTwim+kYi4YJ5IK5Ehfb3PSOpELZda5YL?=
 =?us-ascii?Q?UnRk1MVpJj0VLVSb0ieMiROyBemdTVXnlRwQb5YhOfTb2vCYYqP4+fgfx9lq?=
 =?us-ascii?Q?wqHu832ZiCTtHQSfroHGfk3XW1++DpZD3ZCE9Bnc7/77HB+WY1XGc+FyuC0k?=
 =?us-ascii?Q?FwqR8Hjj6xH1O4RbFcfcDEQMghooxp0lILNlffQxf0iGQF/rCqmnopO/ij+r?=
 =?us-ascii?Q?Y46OUyP8Ibox/pXpKVmyMXWuC2Liaro7Fh3AjL0PNfh0w1k4wmUdcJjpJRG1?=
 =?us-ascii?Q?n/0MPbVjypyIkXPZWTFHs+f9YvAZh/zgd1MntyUHgBHzRt2iBSDmMKNZqX3z?=
 =?us-ascii?Q?+SFGWPHDZK/frbN27HRYS5fqOHJ6eCb8Y8TLwtXR3W9/NzcKI7sLBB03ey2H?=
 =?us-ascii?Q?o0lbpBt/SJjZ52lWBfbnTkpl2BnZ/NNHWtTZRt2tchcaeceqW3aRo6TEL5Gc?=
 =?us-ascii?Q?v2CABicyBzW8jMZArBw44TXquJLNLGztUy708ICM9a3vvG0HguSr3eXhzxhh?=
 =?us-ascii?Q?u1/XqHlu8KmVFwimjy4ZoVHDvoRfP4fpi7HZV2i+vw8QJVG7+Wzu/dY1/QVm?=
 =?us-ascii?Q?Sh2KdwqniNdKuRFCk/4gPEqBzI2c/mtxFjwJECVQJ/YQ2fw0ZP6lCV8LO7+/?=
 =?us-ascii?Q?ZVRJTPF4cqE08Tn62vsh0V1PdUxY+Pt/6UfFJpLMOfoOE8Bd4WMSbpsZfZWb?=
 =?us-ascii?Q?XU/8vNXWWKsZEegheF6YQq4CDsCO2rc/CrgY+kf4yZQKkH/uh0i9Nk6eIPai?=
 =?us-ascii?Q?8wQvZIDFIVM4dXWikpfsaR0KdrngOZ7iz6C5zc5Y?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f89e48d-972f-4eab-e5b0-08db5d8f3a87
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 02:16:35.2161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHxqaWIygoTQcmHAUEr4ETNjIA8vhpEfxcHYY9VrCLLxNTditbT+Uj4ufbTk3HlUtyXfZj08GvQDkiFTmlU3nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7466

Rename local_address() with "mptcp_" prefix and export it in protocol.h.

This function will be re-used in the common PM code (pm.c) in the
following commit.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 17 ++++++++---------
 net/mptcp/protocol.h   |  1 +
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ec892fb8d85f..2f58ab49512a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -86,8 +86,7 @@ bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 	return a->port == b->port;
 }
 
-static void local_address(const struct sock_common *skc,
-			  struct mptcp_addr_info *addr)
+void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr)
 {
 	addr->family = skc->skc_family;
 	addr->port = htons(skc->skc_num);
@@ -122,7 +121,7 @@ static bool lookup_subflow_by_saddr(const struct list_head *list,
 	list_for_each_entry(subflow, list, node) {
 		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
 
-		local_address(skc, &cur);
+		mptcp_local_address(skc, &cur);
 		if (mptcp_addresses_equal(&cur, saddr, saddr->port))
 			return true;
 	}
@@ -263,7 +262,7 @@ bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
 	struct mptcp_addr_info saddr;
 	bool ret = false;
 
-	local_address((struct sock_common *)sk, &saddr);
+	mptcp_local_address((struct sock_common *)sk, &saddr);
 
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
@@ -538,7 +537,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		struct mptcp_addr_info mpc_addr;
 		bool backup = false;
 
-		local_address((struct sock_common *)msk->first, &mpc_addr);
+		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
 		rcu_read_lock();
 		entry = __lookup_addr(pernet, &mpc_addr, false);
 		if (entry) {
@@ -749,7 +748,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct mptcp_addr_info local, remote;
 
-		local_address((struct sock_common *)ssk, &local);
+		mptcp_local_address((struct sock_common *)ssk, &local);
 		if (!mptcp_addresses_equal(&local, addr, addr->port))
 			continue;
 
@@ -1067,8 +1066,8 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	/* The 0 ID mapping is defined by the first subflow, copied into the msk
 	 * addr
 	 */
-	local_address((struct sock_common *)msk, &msk_local);
-	local_address((struct sock_common *)skc, &skc_local);
+	mptcp_local_address((struct sock_common *)msk, &msk_local);
+	mptcp_local_address((struct sock_common *)skc, &skc_local);
 	if (mptcp_addresses_equal(&msk_local, &skc_local, false))
 		return 0;
 
@@ -1488,7 +1487,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 		if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
 			goto next;
 
-		local_address((struct sock_common *)msk, &msk_local);
+		mptcp_local_address((struct sock_common *)msk, &msk_local);
 		if (!mptcp_addresses_equal(&msk_local, addr, addr->port))
 			goto next;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bd3771c7d79d..d8c9035c44fb 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -640,6 +640,7 @@ void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 			   const struct mptcp_addr_info *b, bool use_port);
+void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr);
 
 /* called with sk socket lock held */
 int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
-- 
2.35.3

