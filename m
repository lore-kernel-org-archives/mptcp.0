Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2077.outbound.protection.outlook.com [40.107.8.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B508474
	for <mptcp@lists.linux.dev>; Mon, 13 Nov 2023 02:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Qen15CsJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYla3z9LUc4B6wcNLXGPOXwRDNqIX5K7VwU4VScs7/GB/KbI3d4oNA+GRZYSN8RIDwWN4wX/4en0r1VxWiOBFLDbHWC83p1ELrDFMKaQ+OFnUcKoweJ9AS7sPfdrrgCHPgKcyy/pY/XUUd+8/36Kx5yXHDvhc8QoTD0i9EkMC5cYfgbOSUFupkpUAyv6JmKLYFUj6UyCjbZ/HNuq0hsOqrpt+Xt5OZ5MpstvDPFFl7Xv6kiBJh01XCldhdfcpKWc1pWmeJBgrMTV7UW3DZAJAxhQuoFry5rtLH+HKyEyoynSLbXwgXnjKc2jCGxyltb8fcVMc+ou2naaW93yg2rGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Txjq8/0fP0unonnfGgO9aF6JgFqppQuwu1fvcU3sfZw=;
 b=WcbNKMILjH9apjxMnMnGxd4tkl+Z10YOu91FT7wW5wnDvd7XlQkVH7Wc3by/kT3k/8Eo65tYU7fyNn5UQ/mf+yPacXMVtHE2fnc2pvP3Ysq0RL2wWU9LByMDtb/xwd6jYPrlkxQQoAe8qwN3yqQ2husqKHIyeiuHr8kyimNr9TdYd0FKu9LD5q4e+se0nU9GBOn1DysLTqsSuVtODOGblcyy5JTIVjmYMBzbRTzMNq4Omob+rbiw97ZO/pPobtLqV12YljsRT95evWPoKBRdA7rCQIzFPZm1Z6iBh8dniQ1owNWYZ5/Oc31vmZ7TU1l8N+uNR9D5LvaQE835MwcUYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Txjq8/0fP0unonnfGgO9aF6JgFqppQuwu1fvcU3sfZw=;
 b=Qen15CsJvEimvRmzOa4Kr5dbCPDz9zhjJwpjJsrn8rjoP7p8F7GOmjIxFqqykGLcYImAUJWM/2s1ZVk5lNlNfakoP6k+501/2GpBi2qnHsABOb4HMaMNgYzMAMZ7PlNNPZPu1kDb7vpKrRJgPWUimn43gzcAFkGPmDFJWyMhueBNw6ZcNn439WGR4Fl2r5JSuf2BBE2eXzmVHmXH2h+E/uU2PBhk1VFfsFYT+QCXtVDsgQAjyUWq5nujBq0lo2E/UoPoD10ByuC1i3hgja6OKfD6vGAecACgv+98M1NHlD/UkILAfbjPT+JYNdd/DJhedKO6VQuoUKvIoYMrMOX8ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB10038.eurprd04.prod.outlook.com (2603:10a6:10:4db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.14; Mon, 13 Nov
 2023 02:50:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Mon, 13 Nov 2023
 02:50:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 14/22] mptcp: flush userspace pm addrs list
Date: Mon, 13 Nov 2023 10:48:58 +0800
Message-Id: <c31e12a771b2b7c1bef21ac77bc70aa7c92765df.1699843617.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699843617.git.geliang.tang@suse.com>
References: <cover.1699843617.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB10038:EE_
X-MS-Office365-Filtering-Correlation-Id: 719e82b1-3efa-4450-691b-08dbe3f345a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RqRjJB6FuFu70y26vYByCB0+e8REEy/C80ZGmHFXv+Zn/MDheZJ7iPY76YocYhxk8lsQdw/0tbme/EJK35lDvBtCDHTnEDoh2QG7whj5vMPhzuisrfeBeyfPhKp/luw69bJQa8An6mSbWaRwQn35XDpDg7bl5q1B3nJXexya5gpW+ESRUlqaDsLvw9ewAqQTn9fNcdvgOvjVQvIRI5McdRmAdi777ATVxspMGNOwZH+VFJBSweWbwgu343gWEYrgTFQStYzTg/P+Dd6dQdC3Wjed5AbbgxkCtyXCtVhSZU0f/z8nwYg7XS4wksepDmberEY1tPoYvi9aRioppjMrLkVNfTl6GVCTGfkh9cACQB8Ez6cNzIgR7q/bNYvKaBsvySnTTjIKvp6MXXlhuFWrynIY0kqq24PbngZKbEuWa+Br09c81oXvonxB03GipBUh8MsiTyg9dmYVGLGMDCfLHGUqb305sxlAhFPQ7pUI5ZXI2eGgmeg5JKKUbmeE00i0j0A3nxdAfEHIAKt8c0TcDRXMgfDaLwnuaivTO1MYmjdkyWCezl/5e4G425HqtpQ9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(5660300002)(41300700001)(38100700002)(36756003)(6666004)(86362001)(2616005)(107886003)(478600001)(26005)(6506007)(6512007)(6486002)(83380400001)(4326008)(8676002)(8936002)(44832011)(6916009)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kS48ogx4h2xptNzQJB4WbciRioB6CyLTFTumsME71UspfKBMKeps+XIDx3/E?=
 =?us-ascii?Q?l1rkw07GbuF/sM9bYaOfRmXDxcN+VufJs1Sl1Kqeg8INzOsFoT0E5nf1MT/M?=
 =?us-ascii?Q?YxrFk1GswBa6iJsce7Y6x0kF7Wp+z5AHtQuyytNSKkeL4Q+SnGtYmPo6/uht?=
 =?us-ascii?Q?pcQj8Suye+s789jPkmOOlQgtlckvKdRqxt0ODkzGYHha4qWO21H0LkhHwy7T?=
 =?us-ascii?Q?zJU0wyEZ6TzJPBy8jXTA+Vfq60+sHlNKFzuyoorMTqF1/ikfGOLPUpxk4pyh?=
 =?us-ascii?Q?wkCBDjsLKlXlKli7E0qOMfZGNfDn3fW9vlaRSxgfUxIiTJMtwHPoDZRdg2Ck?=
 =?us-ascii?Q?SWM98HLi4Rox+XbQue9ojbnB6VHnWHHVZqcRMfU9x6qOAh4e5NiBTRsNEHLc?=
 =?us-ascii?Q?3Jnj2j73Xw92jVga7fqREpGbVUhdBQMMw4o2MQ2ofkt57r8rYH3X3aFyvNZh?=
 =?us-ascii?Q?rMjeC/YZWPDmUHTCeuHUiYUPspzU6IyBYQmLxUcOYqRHgtN9wvEqWKqUD4Sk?=
 =?us-ascii?Q?bJjbhrsVtExxd7JnRNjKUp7G2m8tAs8MngiBzj6fyRXaeJW/sajEL80GOs8o?=
 =?us-ascii?Q?GcF2nPX/0HxlSs44YBkQ7475mKE/8oa/4KWYihUvMvU/qN6BIQACNP7mJZTd?=
 =?us-ascii?Q?N4KyspoYncNCJcd56D58I/lrB1qxwlQVLodMrVqtyrcHoRyNbXXbW6Tc+Bge?=
 =?us-ascii?Q?NOckyggyxuoItNhaP4to0XS2bPU0ldjxW+qdkZPrEJW1AicN9S2UJ5egMqXr?=
 =?us-ascii?Q?iqDVfftO761XNsX8iUo8HFbI65PTyRH+3YPtThsvyNWwi3vpVUGOPDWDQi+t?=
 =?us-ascii?Q?ypmOjzBfbZ2iHMvFm0Bqgw5Gl7JJHHDJK9m2EVks4CWNWVJFi069TLPTtSXP?=
 =?us-ascii?Q?Gn2bWOhcsbWJNCfZXFTH7eTMtV+6NPuGrS4CtLxmjxUfJ+BMYSRy/466kogQ?=
 =?us-ascii?Q?/rGmycj8RQxWCIsvZZ2P0632acY4xrAizFd4O2mIQtWz1401SeVIWgKg19tD?=
 =?us-ascii?Q?9wqi6xZEyfHicNVvf84hO13gPW/kz9apMBlibehOKAhAE5Tlu5equ6BN8HU0?=
 =?us-ascii?Q?QdkpmRhVJoEy3eNA3tKP/kRtwkoo2pgdkd5juFFi84huT7DLeik5AFb1odol?=
 =?us-ascii?Q?JZFOf0vInh1eeqXrG9GChLsHuWKtRmgRSvmVjxHr12EF+IBguOePjEvLxHVs?=
 =?us-ascii?Q?EWV4pUsfmIfu4WGC9Y5xwdZm/op89SlEWxThgYAumuUuEru/j0sXF7LnLip1?=
 =?us-ascii?Q?Ff7OMinAm9cELHjNZYOl4uo5UHUXhSWAnK473rQz93l1j9Z+xCdlGmyS+TPR?=
 =?us-ascii?Q?ajj3m8VSCCMk+1xIAEWbNPRHHSsKMSWM0aKVvkzCZSnae51BiDFNFgjCNPaN?=
 =?us-ascii?Q?6JmH012Tg+Tcx3zLPoX3KOpTGpJnaGoMnoWAPoLqQpru1qxtzyCFGEGVQFVw?=
 =?us-ascii?Q?E3gZ3ziV5gcID+2Xyi1BlH98ViOte8UNfh4laaRsvbH+50h0M99AWUEkq5im?=
 =?us-ascii?Q?6FBFHA0cvV33eSH8G9S1ZAvWfHTa3erWLeEOtaGB9RY84ZYsvs1nZpQOjvtb?=
 =?us-ascii?Q?/eoNRJwB4P4LSUqUA+C4vrcgjlSW8/Kr4Vjhcu91?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719e82b1-3efa-4450-691b-08dbe3f345a2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:50:18.8885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XD8YaZ4DwSUgZe9m78ZJtz4tp2P8rFBMDawrCkbhIlTsqMU7Jog/03UgEo30z1FmloBFBcoEcRczbxOnNilyxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10038

This patch adds a new function mptcp_userspace_pm_flush_addrs_list()
to free the userspace local addresses list. Invoke it when flushing
addresses from netlink commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   |  2 ++
 net/mptcp/pm_userspace.c | 25 +++++++++++++++++++++++++
 net/mptcp/protocol.h     |  1 +
 3 files changed, 28 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 08b4211fbcbd..b7e4c8d21078 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1565,6 +1565,8 @@ int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
 	synchronize_rcu();
 	__flush_addrs(&free_list);
+
+	mptcp_userspace_pm_flush_addrs_list(sock_net(skb->sk));
 	return 0;
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 70f6a510e3b4..abcdc95e7bde 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -20,6 +20,8 @@ void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk)
 	list_splice_init(&msk->pm.userspace_pm_local_addr_list, &free_list);
 	spin_unlock_bh(&msk->pm.lock);
 
+	mptcp_pm_remove_addrs_and_subflows(msk, &free_list);
+
 	list_for_each_entry_safe(entry, tmp, &free_list, list) {
 		sock_kfree_s(sk, entry, sizeof(*entry));
 	}
@@ -580,3 +582,26 @@ __userspace_pm_lookup_addr_by_id(struct net *net, unsigned int id)
 
 	return entry;
 }
+
+void mptcp_userspace_pm_flush_addrs_list(struct net *net)
+{
+	long s_slot = 0, s_num = 0;
+	struct mptcp_sock *msk;
+
+	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
+		struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+		struct sock *sk = (struct sock *)msk;
+
+		if (mptcp_pm_is_userspace(msk)) {
+			lock_sock(sk);
+			spin_lock_bh(&pernet->lock);
+			bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+			spin_unlock_bh(&pernet->lock);
+			mptcp_userspace_pm_free_local_addr_list(msk);
+			release_sock(sk);
+		}
+
+		sock_put(sk);
+		cond_resched();
+	}
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 76981adcac22..089fbebd21d3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -944,6 +944,7 @@ void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
 void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
+void mptcp_userspace_pm_flush_addrs_list(struct net *net);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
-- 
2.35.3

