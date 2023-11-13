Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2079.outbound.protection.outlook.com [40.107.8.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41338466
	for <mptcp@lists.linux.dev>; Mon, 13 Nov 2023 02:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="jy9wDSBT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ekqy21ZfkUvrxoP4n2RU6NdaLyGvZ3DWFaj/6z6y6JojgvbxA5+TEBrjEzY2oJet45+EVdXXEV046tx02Ai50/muuzP3yUDaO2Jg9aaY09r7qP7lloidBHgyeSz2F+nYS3AOitA68LwrLvQaU1uyH9KcCBymHXT9quA9PAjeBL2GFdcPKollwdeC2JhINowKyclsNKjBOK2aC7L8hMoCHXPDVZofPuw2K1xPS9xxn9u8Zo4tGQ+B1zgOK97vR8WBcrhJ3Byo9HPPu/N8+wXnPqOKI+YZuBDeAmZOsd29ehWfABib6P2mt/40p1kINFAwkIgrdJeGrkw6j2ddM4FU8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9I9BhsUgHu9NIyvVUommWpfzUKT8CPGIVlfQ/Lgp1ME=;
 b=DTlY1PppRu0nimoBM5wI42biqdWpaiosmloZhNlxQqXmA8hZaMq5cfjOZZ22sBrZ1iViRjTFuGLYWY4epA1CsUr4/trj3ouSzxZ2Jumug2G6JETATw9M2ONe2pw+VssUxWTMdUl2OBGxKQn2qsN6jB8XYjuBI8y+7IF0T2rEMlYnIVwJ50iQkxMB4zDvMX1NHnO0adQ3dEjdDE3Zo6z002x8dSyYu5tCNhH5KBX4Uid/q2NKynI8NN4zKqg7+yxaO29/ioYdQmxfCxDYnGTD2jOd3z23+wVdWbckdO1/RAELhgwlcTYR/7ijNjCgKVlk6AWzEKiHsrRL8NzE3GkNdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I9BhsUgHu9NIyvVUommWpfzUKT8CPGIVlfQ/Lgp1ME=;
 b=jy9wDSBTTDPFzER2IHnIhTozEPRrvuQgEdldFI/M0/3y7LZVk4U1jfAgB89CBimKT9H/nWseq9vEck9RjltoDX0PmtJLYnVNbuocBpXMJ30XXG9Q22cMMZW/U8A66kfoUjAw3WdGAJMEIAvFLYIBrCLYM04aYAzgPVg0h6wiHdtXH+GrcX9Db8whaGGTuz2VGwAFs3mhpjSADqV34NYTj+fSgW6vGM0TDUJqELg5xPX+rKnyRQ793L3U9/xqMrPkllFHpoEuCfej3DjsE3juH3S4WgDd40sAUKO2hFWzpkbjC8uZmiXH7LbYHgEz8JdwlKYdmG94HpMq0qMdBxUcUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB10038.eurprd04.prod.outlook.com (2603:10a6:10:4db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.14; Mon, 13 Nov
 2023 02:49:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Mon, 13 Nov 2023
 02:49:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 06/22] mptcp: dump addrs in userspace pm list
Date: Mon, 13 Nov 2023 10:48:50 +0800
Message-Id: <01e8f88c6ed7a504ed2e12aac58ecfb909ac0d26.1699843617.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699843617.git.geliang.tang@suse.com>
References: <cover.1699843617.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:4:197::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB10038:EE_
X-MS-Office365-Filtering-Correlation-Id: 862aa3ea-35eb-43c0-cd58-08dbe3f32ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7SO81tAKchqDxx/ykZBbbtMqxt1UGPMWT7DWJWfgUezANw61nUIQ6Sd2toAG8PLKk+BpLkgMpXXBAHeGr0xE8aKkDjNvZjK7RhUV/d6KwLgLujLrdv7IXz0C2++tDdNH3M6P6P/uZLQrNNWHj/dUNeQKGPIAAj1Sh0/iYNAcpT52Klrw8GHX/87Dr5jrPewnr6KRy8VuNrsrcZpr8Rxo+Yp95hrNTUyVm5YtH+fmDczRAajgHsG5t3ERGhiYLMVpVMdi79RySVDph8WakgFZzOLCo32ZAISU9rXXAmF90Ul/drk/d3es3kamvgoMeScJj8tvrsIOB+WZl2iubnUk3O954p+kCaaq96vVhYNTUWFtIroLS2POJj57F/TgFIbLyQoHK3elLwgSFJf2wQSYxFan68enD1/A6h3a/xja2oxivxRspWHaBGypHh0jhDHa5gNB4CYi0Rc34wSjsGBfDuOIHY8rqAEleWbDkJFh9LOUgbQdmCHqTvTSy7DH7vnR4z0qYNdyKWOdYKTP1HeZVTRS94uZ3hbId0DQnQx5RJbh7FdxG4AIB8kNk6hEoSvd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(5660300002)(41300700001)(38100700002)(36756003)(6666004)(86362001)(2616005)(107886003)(478600001)(26005)(6506007)(6512007)(6486002)(83380400001)(4326008)(8676002)(8936002)(44832011)(6916009)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oex6vMouXdrEQ5IfcQ0dyvOIbNGk6ep0SvwlupGdIHcGY7PUjMcRbM32kaxT?=
 =?us-ascii?Q?aTwAx4Z7aKH6/II5ln+KCTh8dA9gC9K2cVzFkAkv17pE3mE4PqdpBlWq5KXP?=
 =?us-ascii?Q?igSl1wMWzprHVrovtIUsQFmRJYKHC+eKSKUXe/h/6Gf2d57JWeMl8w6AFb72?=
 =?us-ascii?Q?xa6kJ0ZyOHWI+JYPOoN5jJG3MU5d/pwxqs4LifK1DFvvcyNw3xCWkN44KNw5?=
 =?us-ascii?Q?ja83cuzGWcgORVAftKj+olsDypElCYILueGygHyqEphD+x8ynxKTLVyH3srV?=
 =?us-ascii?Q?nSpvxQYLJwddvoIDSG1Fjba8ADsLooT9M1eHM97qnEnqXNQmF4YIvjuS4PVY?=
 =?us-ascii?Q?ShkCBbjoEEa6JLHsA9benD2Os44RGqo32ghuMAtoPkZ4gDfzX50/33RCPHzt?=
 =?us-ascii?Q?E1BWWrnhBaCdsrjlxj499EPoJOdwkrzL9PeFMFInJVEgPtmJNFLKDNYim/0d?=
 =?us-ascii?Q?N5yWE6/VUUANWewWRzbM6dw5GDgp6kcapqTtwOHrk9u3VlvHkSoKyUs1UuLe?=
 =?us-ascii?Q?y6e6hiRxOqQDaWhx5k+AJRyHVFlwdZzbXZ21Ay6hwC5RWluYG4ACf0ea0u23?=
 =?us-ascii?Q?/iI1CJkQHl8YdgqhihgolBqeooY5XrrgYAt0nAbIIVMQOAfyWWmgGVQxW92p?=
 =?us-ascii?Q?GOSILuWwx9sJeHnNCODLNjokXJhoNGOZop4sCOleLjR4OB5zKDaLilKNM4cp?=
 =?us-ascii?Q?rcXpJzIHrIB0Uf/CiCpZQQLEqio/YHzepocN0pQtz7Xc7psjnlnA+cbRp0L7?=
 =?us-ascii?Q?aGqg0NCFMkTaO3Syf7sTUsu61aQoYvUGCwN81ed3uMRLJnuBbIS5hPaknjLi?=
 =?us-ascii?Q?lv2bwPQAG52g0aEVTKHcAHhtZ/FSe4hzokfMrMgveeSWobsM/0Kzt8Wqhqkh?=
 =?us-ascii?Q?LoJZZ+YGuxLFuofvSGDIuxwX1xR6CpMfQMRIlyxvrikRxF01IPbzHv6RbyHG?=
 =?us-ascii?Q?sCJqrZgqIGKAg1gsRA+ch79zSQ6Azm8jgmCA4jvTda97kIfUrPlbPlKgxlr/?=
 =?us-ascii?Q?R9bVsn7BIPNSWfQ0p2yFz6Unoj37VrV4hIYq43ot6Now0Ct7X9TDKO3UubrJ?=
 =?us-ascii?Q?hP8KbQgZI1Xx/2xA1TADgpsWBwY9JQK/qILwJRkXRQSYVqFiO2Z/spEI/snR?=
 =?us-ascii?Q?EdRiTId+hyE0AfS9IXKUOxDm1n9/cmQ+iBfJEjsDiY0o9ZRCHK4ZCaEmvrRq?=
 =?us-ascii?Q?wbdM7Jeaong85A4J8AiOe/0FONKMKxw1uphcPqvhKc94fPZvT0dzxioODkWt?=
 =?us-ascii?Q?8dtmuKz87l3MFynYXv7LEzNoy00MHrGALI1Xa5Jf+TMoAmE/pgXuEcBR8qCM?=
 =?us-ascii?Q?OGx4F+jyOJgDz49PtkOc7SuYhrKOXQH2phxMSC+weCxIjUGmQR737yWf7sJT?=
 =?us-ascii?Q?LWgkrwlR33hJmIwytSs+PnAiH2WEH4PgZcXgdK3RNlFOCgnXXgqCVHlu/fYe?=
 =?us-ascii?Q?OR4YjXP+fOp18YhlKqKBKB8xIHelZ/vV/H9J+gppdXMbs4XJxc2r2YZpZ0HN?=
 =?us-ascii?Q?WXad5+TuPNQMSVqUcRNeeDRer/AX4i4OpTTnczqyfSzkMNfUi1VaY92EoJfd?=
 =?us-ascii?Q?H8ORaJXlwrtrfL0MDqF4gubXlhaWbaapLwvjOCt4?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 862aa3ea-35eb-43c0-cd58-08dbe3f32ad4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:49:33.9454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqa6nNImcFsdFhvffY29U7r0Ne9c9nQgupfEtASlw9f+wTRrwap462NMZEzCJBCYge5fApKzEq4kZAmeHtCQIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10038

This patch adds a new function __userspace_pm_lookup_addr_by_id() to lookup
the address entry by the given id in the userspace local addresses list.
Invoke it when dumping addresses from netlink commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   |  9 +++++++--
 net/mptcp/pm_userspace.c | 25 +++++++++++++++++++++++++
 net/mptcp/protocol.h     |  2 ++
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4cb52df57ba5..08b4211fbcbd 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1673,8 +1673,13 @@ int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
 	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
 		if (test_bit(i, pernet->id_bitmap)) {
 			entry = __lookup_addr_by_id(pernet, i);
-			if (!entry)
-				break;
+			if (!entry) {
+				spin_unlock_bh(&pernet->lock);
+				entry = __userspace_pm_lookup_addr_by_id(net, i);
+				spin_lock_bh(&pernet->lock);
+				if (!entry)
+					break;
+			}
 
 			if (entry->addr.id <= id)
 				continue;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6999296cd5db..5e45e36ce1d3 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -549,3 +549,28 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 	sock_put(sk);
 	return ret;
 }
+
+struct mptcp_pm_addr_entry *
+__userspace_pm_lookup_addr_by_id(struct net *net, unsigned int id)
+{
+	struct mptcp_pm_addr_entry *entry = NULL;
+	long s_slot = 0, s_num = 0;
+	struct mptcp_sock *msk;
+
+	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
+		struct sock *sk = (struct sock *)msk;
+
+		if (mptcp_pm_is_userspace(msk)) {
+			lock_sock(sk);
+			spin_lock_bh(&msk->pm.lock);
+			entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
+			spin_unlock_bh(&msk->pm.lock);
+			release_sock(sk);
+		}
+
+		sock_put(sk);
+		cond_resched();
+	}
+
+	return entry;
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 88f5b422f941..c30e59278080 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1021,6 +1021,8 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+struct mptcp_pm_addr_entry *
+__userspace_pm_lookup_addr_by_id(struct net *net, unsigned int id);
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
-- 
2.35.3

