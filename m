Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFD34407
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RkdNlQI1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHXaYPZxnRiPonfXZrWSKjjY7GTIbUCJUGOErJ4Xi/BbS5+Zya/lPNb/Ys3flnPVshybbyOBd86QQb0lv+sPrlbzfnOa86ewQWyuegvY6jN7Nw+LdJ6a4FM1teJB3oqAmiC60gd54M9S9yXs6qTALveDOD5mz91wiFIdHw0A9gO1DLJfPmEhxfh/zxap9kwhgNjg5PsUjLVFc+EfWAKjgBtMVfDSPz2/ZotGYyXd1Td3TbrGsuE1jNhu3scIe2c7JiYIde06580EsMWRyR0Mhur+Qw797sMnh2KkZMKv6ELGGb/PpwtOUPoSjvlLC9kbaRuE9xLqh2h3N4WE6aQadA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9I9BhsUgHu9NIyvVUommWpfzUKT8CPGIVlfQ/Lgp1ME=;
 b=TYIARaHnwG2kEUnrwCiIO/T9Tuy7oEtmfkhrWmeIGz5olV20T9Y+woQ/1JvgzFG0w6Vn/7XO7jmL1M6XypmHBBoeGobb7opvNDlWzu2X8G7VAD7guQkwmeDWa3M6eGjg97YT6fT9oaGpXXSDZ/iEOBy37St2weZPpsBWkSTnT0P/0PJMEs53uBQ2J5cqnRnGDlNXgzHVdqLunothz+r2UfTveHbdhylm6b8qmrvsOixHmFcjln+dwXYexWCq6YVjSXMMTo3QHpmBRu7SUmtf4okMQjYqTK3By3M39RkcNXKc1+D/GDA1pDOo1RdkNC1obxpesqZoj7QQJlv+ATsH/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I9BhsUgHu9NIyvVUommWpfzUKT8CPGIVlfQ/Lgp1ME=;
 b=RkdNlQI1FU1ArggtqbaCzW79TaTL2yALDcPINq58Ly2SS2R7Tw5cfR1Dyk+JBmGgInEtf2i7855M7yM+igihSeYOGLBc3DObhMfh2KCGd6SkgDAGJPE+XqfjirVv9D631AtV2d/25kVCj8zDSnT13hfe5TPAD+r5Cel2LO2870Dt70wBVPNNVdlOxi0HPRhLj9goKbs8ak/irW4f3nX/6vYjcH6Duv390gXit1gDYvcsoG47C41oBvsY/Yxl+x1dtTc8aS3V0dHav77QonDJ8sUKh6ZQkFVjpCjHnp3tua/RITc6JA0XMwF5vNf7pi2udrcj4J+SF7RY/J5DDDDJcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10052.eurprd04.prod.outlook.com (2603:10a6:800:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Tue, 14 Nov
 2023 06:36:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:36:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 06/21] mptcp: dump addrs in userspace pm list
Date: Tue, 14 Nov 2023 14:35:03 +0800
Message-Id: <d0db0c557de24de8b9c5efc4ed181775d39a2f3b.1699942931.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699942931.git.geliang.tang@suse.com>
References: <cover.1699942931.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10052:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b5539fe-a6ee-4cee-c559-08dbe4dc017b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W2dcl7j7RMtmbsXUPPW8XWX2rKKf8/x3piKTtPAZaRBbUd4KDEscsQoonxp6kkW168tUx7e+3ol8BSJlz7vStYRXqG9IXDED5VPujTHAXBgh8m4Sr85kx4GNNWYiMrYutTCo+KoTmFzq7FQCq7weWhkekJiLSBv5G+fY1fn4uZOpPgmXpL8VcfmMZ4DXvuhN95k0R0lMk0DUk7ivz5KVM6lkju+oo4deRAP9PSG90LPso6FvRdOXAcOa63uyn3XeN6EJvL8EHE86r7Jl9zoGQ2QHIRg8NfxZLhL5ZceAZqsUxAZwQ1mPNCJOhUpBIpepCH6VYB1tyHPxh6YhDUftiY9iB6UHFTbn5paNbTPKOVxmy47OhUNRe/5eKc2/9IQ29ISSSeteIvGGh6cOL/pgva+BPFDMHTwaTtZepSBQX5cMVRcT8N9D7XhS6Gt8LbFg76nwtpWdjjBtjIaHx5phH3CsVJm6Mjk2G74enV8gTo7iBYh6G7tQhL/NFb7C4/fpf6c700dH85W9jyA6k0q4vPxxDoGSjDxfubf8wJfWF6v1nAfwdgYQKR+NefyQN17C
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(107886003)(38100700002)(66476007)(66946007)(6916009)(66556008)(86362001)(36756003)(6512007)(83380400001)(6506007)(6666004)(2616005)(2906002)(41300700001)(316002)(478600001)(6486002)(5660300002)(8936002)(4326008)(44832011)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H0kiM1SKpB01lfgeTO0mOrwr5A8qYXyOZ98CMcJBJdKr4JjHOPxC9NVIfWOq?=
 =?us-ascii?Q?sOlYWiv+KpcT2vYVqTmshtww7nOUKJwJxCqOTHORodJjF4wfP5pYOfQqlzKO?=
 =?us-ascii?Q?5enBKG8gcVDkiQ/Fph3a2GpHypVSblLSggxf3eNYrPf6bBBEiC89Nv+CG1Pl?=
 =?us-ascii?Q?skeSB/ojvWAyLsQ5AxKecdE0hhA12nBIop4Cydu5zGVryeEUISmxzQ7EExm5?=
 =?us-ascii?Q?x6ckF5GnO+BdjObTFJib7cJwq0StS2//8eQFnTj0u9UHfuYyV4NVlrJjT0Rl?=
 =?us-ascii?Q?SclFaVT39Au8GQKQ+toEshlWrmB1y6tOPduuqy3qjsJK74k3QQu1UKIJVEKT?=
 =?us-ascii?Q?f4mEhIMgbddNRXGlwoScT8TQ51H1PMrpq9EfOls8Gq9JCl0gvQRRV74qQ/B8?=
 =?us-ascii?Q?6/r98vtNeoKHUCIp/Moc7YoEkq8vugj4OrU232zsPr+TP7Q7VOaQFGNWhMCK?=
 =?us-ascii?Q?9bAnZXST8/Mk50J5bgJ40HqyBLFPn8nD1UslI1omJnSNM+SJgpgPUJ7sBJ27?=
 =?us-ascii?Q?G4tIfgf28VOouCmgbv0BAn4EqtyPC3UcFdf5BeEMNCW0uN47DmIGIjRP+Kxf?=
 =?us-ascii?Q?vhkuh7Osk59rhrV1/p4Ah4QXvVXUtsa5ns/DuSxhLijYvThOpfgbJVJv6wOC?=
 =?us-ascii?Q?TtqQGXhFcLIwa+gLr6g0B7xu2/Ms/C6PA9Vsh2Yq74dsehRwiO6C7HhYl+Uo?=
 =?us-ascii?Q?LWM26K2JF7kCLANhaQaCEOA7bfm0KJJK+hHGBlfZZym4EBna8sd4g2Oz0PQ+?=
 =?us-ascii?Q?ff8zk0RKIWDMvRw3SAsu7qQgAXc+j6htBW00jQvf2abEyfxWRFV6M89NG4d0?=
 =?us-ascii?Q?5xKGZx07VhIMpx8LwlltIjiTLBV6r+jtfzBUCb/DAb0M3n96392sHSkc/NAt?=
 =?us-ascii?Q?vZKe2jdqNvoggFKWlvUoZ47mbLQu0iHHZNrI2wzMWTJnnGGh3teEmnB7SkC1?=
 =?us-ascii?Q?rtckmKuSi1J4DC3OwjybMW8PA/n0AJGdJj4+Gngs4VapDdXMqR5siojjekmW?=
 =?us-ascii?Q?UXlYaAUvsLZR5ACair84/hGsWPhSwvHXn/BwnjJs+21lvUu6U334nyPemFd0?=
 =?us-ascii?Q?4OgvcJz/OeowtCji2iydF+2a/WfqxGWlAFtRrcq9DAAF2jdLH53ahJ6zEriS?=
 =?us-ascii?Q?9A13CR8zoVGXnLnohY+V87UQW2FFyDyeEQlpl1TmrXwALJv7Ricft3mxGhAh?=
 =?us-ascii?Q?PuQ4CN8yCjYQEh/DcBuTK8fgiGLdMzhWRXKRVBBEc+yTjPb03FezdQR8CL7d?=
 =?us-ascii?Q?I+tCqAwk43oV5AJhAebGlxHMZ6JSrL9KhGtY7+LaocIThQkWjEBDLTOaofrz?=
 =?us-ascii?Q?vUWO0pE08AMPS1wP+urEPNfOCsJquPMQcypleLni/irlLRAmAWCT9pq/I6o1?=
 =?us-ascii?Q?zSSw6H9WAxmqQWTWAHmkyR92fmZZTSZBCNkKhsJgx66G0vaNzLVbUonqa+o5?=
 =?us-ascii?Q?2NPCNovKW3CE469dwU+/Fu4HA4c5NWnusH3XwmDHNHzaFZnz6uS/adhZo9PX?=
 =?us-ascii?Q?dUi40+jZYZns92/vSP6CdSl1i+ZO8ddpVJ3vT0Habx0V+B/K4Ee6gDbWD2NY?=
 =?us-ascii?Q?lb3XNkD+FNS5m5W/Y6sRCihlZBVUxuDKhTisMdGp?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5539fe-a6ee-4cee-c559-08dbe4dc017b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:36:17.3085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kl4pFfEZpx7L7RV9gFjq8p0e9nSw/AggoqG6+bzjoajEjMKHTjoqCRU12G3cq7uHFU/TwH167dEzOpuyGbWhFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10052

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

