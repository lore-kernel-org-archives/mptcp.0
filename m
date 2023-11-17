Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2045.outbound.protection.outlook.com [40.107.14.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADA4B663
	for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="5IJK5H1R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TH5dfjyTedlxtUys/oHJ9LK+fo0xDB0am94Pg/9HXnzdtdpYBTe11Up4f1+EHjBbEW6jbj73Gs1d+lpddNcXjlsbAAfnYkmaqL0fcWLBzmgao9YCYq0myTHJNkbKDrEc3v/eEsQH1FRLKXRpxkKhFKbu8gbQclj9onkHn0o+pVRvuAeM15WFX3JW+XCFG6A3HyCni70/WSuYMr1+eCbiawEM+cTqin0mhHxYItRzJeS3pxXeYd87a4jqqUduspexp7ZEZplOzLXB98CrxAuDbNdyoG4zQbAIghS7YEQZGGZPzD4HnijRTdpYuAnRbgs0n6s9y+ssHU7NZkA8/0AdcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZoWC+Yu4gf47BLZOBPG7qKeOc+M63vRFX6TxkXdf+Q=;
 b=b+B+bVTo06LriPCkiGODnBviIqSNwSdTHpNkec+YfCVl4NtmnL8LIF7R/N8y+bP0FMzIkzu+8QAVWkMUQbyQMpBdzwero8BlaWCWNwGIvIba8O2u8nzE93CKmjCbQy2zLHyWVzoAJWD/5W5Q8w+yWO6DW1aLKSSnRTyuZRPzUsAdhHmeDbARvGt1qvEw//j1SURCcMY+kg42l1QBemGk6mXRTbKzyzTrRfItDpFVfeE1mJ7QNn4GbnQO6W5TvgnyahH04bzNpU6/QN4u4WhJBl9qNlPZSKyDkN7D/MdA8EoeldupYUp9iDKnw4eQgjuJxtvyS//M/nGVWqEPYNCsxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZoWC+Yu4gf47BLZOBPG7qKeOc+M63vRFX6TxkXdf+Q=;
 b=5IJK5H1RUucytVrAHbhpm8SbJ62d5qUJ9pQn7cs5w4qpgNUymJtEHYoZ1xCGVrvL6wnoSfX26J0MsKJeewISS2zX8zyyLLv47AuYmPCzgIJmA9I8GxhUwxyET5fvGdno6edHFewqwTMfGf28r5KQWbV7X+MbvXBzZ8d/v+jM3XbLIaKzBuvFHnj/BH9OjwtEjV662qjfuWyM69Nkif288nNfp9XD9qbCW+h0QbQkUz56j2JiTSRvoGC6YBuj7CSyNebmnq1EgcOStbGrW3kXHYm5yceIkrlFiwHENq7zWKytLbesh5Oix9RWtUDG9unfjbNRzJJJ/xWOCBjMG4pMQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9975.eurprd04.prod.outlook.com (2603:10a6:150:118::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Fri, 17 Nov
 2023 08:58:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Fri, 17 Nov 2023
 08:58:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 18/26] mptcp: flush userspace pm addrs list
Date: Fri, 17 Nov 2023 16:56:11 +0800
Message-Id: <77fed5e2f323633c5ac8ff8bf03a451bce8e8474.1700210966.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700210966.git.geliang.tang@suse.com>
References: <cover.1700210966.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9975:EE_
X-MS-Office365-Filtering-Correlation-Id: bd96f837-34f9-49d4-3664-08dbe74b5376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xwQrcD9ncugG8ePvs0Y7o3VahLfNWpu+/ErlRIvET1wTP3Bqyu2Svx7eSsLmnE1B9COOebuNpKAlXqTt5/rezGVrci60wF3E4s2we6xiciPuBKNE/E3H2wAl746jjSQAUY/Occ9n422jysRpahvt/lZOX1+WVsw/h9QHxxaKPl+rpsDwRuJT1qm4KXxjY+B/a1g0F6Sp1+lZ4FIsg8WOY1Fp+aKzAlVcjmM0/bV4Ni2rYqywlSvXZTyJ/zVOVjU4RLQo4bk/FLwy8NnidFg5VO/95z31mVIiqU7Z/0sint7hi9xzjb3p/hOValGr9UTyeptWvBC2qpdnyPzrQn4M31YiNvfosh5iCaOgZ0ht7LlHxTD9oFI6vw+jvA54t+Age2vPS44KZ0l2nrUPVcfZmecrX/K9EkE0xA33nBQ6p6IuX4FjwtMRoR6wT0eSSpVSNoL7loTMtX13Qb48xHGX5Bl8uZFhkvlYecKxkkyfGCuPF85YsbhnsFPID72iCh96jtfYOt3FX6YxxM+LdY37V1Lgk8flYhsD508bZ0veV5ihzqjFx2mB/V7GLpUxjsTH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(5660300002)(2906002)(36756003)(86362001)(41300700001)(316002)(6486002)(26005)(66556008)(6916009)(107886003)(66946007)(66476007)(4326008)(8676002)(8936002)(83380400001)(6506007)(6512007)(478600001)(2616005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ou4F+h0lsjL8gHUFYTdqBRZyX0uMfR47Db2+gR7AV3ZB2bW7r0ZA65NlYov4?=
 =?us-ascii?Q?l88eDUkbXSHWYrd0OnMjLef4hVIw7dormlXYpwN5J4n9iValIKVm2nTM+4GU?=
 =?us-ascii?Q?R1S5pg6iZzmZGiL9xWoT8hI5iSVLln4dIDR7C5TVIHz45Wc7zLn+HciJ9aNS?=
 =?us-ascii?Q?RfzY8kByKC5tVSNe1OlvoHFheVM9ph8rxjBkF5ucQgk3wQTWCgBuyy75V4Cz?=
 =?us-ascii?Q?wsO4fjwXu/ivY7xFL+HgRfGqbbj3f2tXqDKTMgC+/RJPt4wJ3vzba5xK12m2?=
 =?us-ascii?Q?Yh78yF+0cLmshKj/FW9H2bbzGpcOb248q79TnoHILOv5hGaBmiFqUpJQSN0s?=
 =?us-ascii?Q?MKxtfAZBE98oN3O/bfaI23IigGCtMXL7hvFsmqK0f3nXOiDi49XP4ndcEvY+?=
 =?us-ascii?Q?BsxaoHms5iOHWPx8I91NdtV/Uf9yVdXPV7Kn80iUzteToyIFQaDC78a6S+Qg?=
 =?us-ascii?Q?j4mVB7BH/bzmWwa/OLWTgfVKO0Ht+mum95OTr7UmMUPwZnTt4e7tqqgNnGYi?=
 =?us-ascii?Q?SYNhzdXwoQU+TEHrKc/rexqwRJFQJw4cSKcLmdI07/thprbveZ3brcM4Lu9e?=
 =?us-ascii?Q?/AHgQuAnpV3TB7S6VfbPgVwcIBokwZAfqUUgkb8+tTUcSkn+3M441js4raP9?=
 =?us-ascii?Q?0ct7sXWrugAwUgZRrxxiWDYafTzy8d7eAnNK1y5NwmiNyQEEzqFElp7aiZ97?=
 =?us-ascii?Q?P/g5ch4jXUt2IKQHIZl8RrSZM5Nzs0KqGBt0lBmu3dJFJieU/klKzlhLMrfq?=
 =?us-ascii?Q?0FRgVeXH5Zg2l5CtB7mp55Z+uWMUqZbSWnT7ooBmVPzqFlu8GYK4KbL0Di/9?=
 =?us-ascii?Q?Xqqbp6lZ4vs7oZ8tgD6AZo+FCoozOHbCEv1p8d04hv15U+ge6OqFgWvbyg7L?=
 =?us-ascii?Q?IWMXtj7d3MqrKYXeJg+oX6nz2JLoJIcAF6cTPTWqGYPtvUs65mALckZrwetU?=
 =?us-ascii?Q?/PPq2wtTr86qyl0p1iBH78YM3hYHbbQxefecouwNHTfCra9HtEzejqGNmnEx?=
 =?us-ascii?Q?BJWj+WMQn/jcu1lwTG8lvPQpCEOheJcE44qjxSBBYVV4cEsFHHGRdysGZQGp?=
 =?us-ascii?Q?OM4Kgu/TI27H076LLUw77pkFtZC8B7wBBcgB7DXx1a7VQOGPa6Y2WN/SpH3A?=
 =?us-ascii?Q?kZ6QweE2r7mrn8a01ZWSZLPpwIVCq6sbhociF8H0TParqW8Lv62C91TQddFX?=
 =?us-ascii?Q?d51pYhXNCFL5qJQi+3D+O73GTIcm12dGO84qRvi+Imu3UBKcykR9rmyFAaOD?=
 =?us-ascii?Q?0hs54FX6rxQD73ouMKFvo4vZj6aocIQtf1WBjzM4V8XcXmmeys1QCAfdizzU?=
 =?us-ascii?Q?q72peDr4GJmK0iLaHYY/ZmoccsZ9/QIjYBuwXiXrcsAxDL08otWFwoBbJc93?=
 =?us-ascii?Q?LSCVaqCrsp9aKVTXWq+dp0NFTJSqv/omOFSe+pJHuBq47cNCz1MGuYa28MR8?=
 =?us-ascii?Q?srxwqcsNMq25chu2BkGlFY4rZyIBt9tdKJqekdJbnN93TIEC82eJQbc0rahv?=
 =?us-ascii?Q?2IaRzM8hFKfjV+EjB1CDgfTEspsRacho4EDY1WvtdF5CLk0SvH2SSo8n+9Ac?=
 =?us-ascii?Q?BqK+w5X64EbXGGPdlhEK3Agt6EyJq6nZWZwMRDM3bDHejHz2XrRND2gOe/vj?=
 =?us-ascii?Q?Aw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd96f837-34f9-49d4-3664-08dbe74b5376
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:58:11.3196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FKjaaQBf84PDwPKP8YwDDRNukd5c48iiUQblDOO0GLpcvx96iuWyqR01M5V6zHH/otoxEACSnojj/hD11dn+tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9975

This patch adds a new function mptcp_userspace_pm_flush_addrs_list()
to free the userspace local addresses list. Invoke it when flushing
addresses from netlink commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   |  2 ++
 net/mptcp/pm_userspace.c | 23 +++++++++++++++++++++++
 net/mptcp/protocol.h     |  1 +
 3 files changed, 26 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index cc4ac206f848..e571d6cb3a4c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1572,6 +1572,8 @@ int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
 	synchronize_rcu();
 	__flush_addrs(&free_list);
+
+	mptcp_userspace_pm_flush_addrs_list(sock_net(skb->sk));
 	return 0;
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 9fc5dbd346db..aef8cf3d208c 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -596,3 +596,26 @@ __userspace_pm_lookup_addr_by_id(struct net *net, unsigned int id)
 
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
index 4999bb6241fa..139332f48a66 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -945,6 +945,7 @@ void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
 void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
+void mptcp_userspace_pm_flush_addrs_list(struct net *net);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
-- 
2.35.3

