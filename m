Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2059.outbound.protection.outlook.com [40.107.15.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E117CA7E
	for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="kYsljzaj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jr+IzQpC3pxH+Knk2rF3++bIfYpbXvXty7mT9FwtO2zjCDqfnY7K9mKmX6Q+K88+BA6/VigjIEPVxj5dKSB+TXs6rT72ezOgwxNMt4ciQarPz1AWCIo0K5s3JOuepTskUqtwOJnV+sCnGc5vJgg+H1pHKSgofVf+9IUJqYxtEzLLRsswnvWRsUZk57gfcjZIINZjmU7zQpFUMAzGqxS1b+s6lnLeyCNwTE9pXBBkLA3t5ga7ibUxEuhjm1tuS6B3Q/OZsSdb3+6OmMtG18K1AK4NBfe7iLlf+IyMfvHrB/7BxQY76cS7D0yCvur6kDjg6JzJX+HEu6DTEwBd6qTt6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9I9BhsUgHu9NIyvVUommWpfzUKT8CPGIVlfQ/Lgp1ME=;
 b=NDvDA+K8HB9pUDmzb6AH1ElU9XmWVPA0GsHt/Q9UESjZkyhxUkeXCYPflhDI26AVz9Rcb7dLtp2pOd/khIw59CsTcCLrOQNhWMV9MHC3VLnKBez4puHJguVbMKXLDllm/400+v85bRdylFjuZ20ZO1kVa1Ybpvrd9DJPESdciGV1NP+2cyb5R18LjTkH2HBfKWHmURLFHLzvfkmt5wT8EMukBqup+VJZrAvvYHKjHaNf7q1JFPGXkRL19gGi5Ei2Y4PyxbIi0f1mqMRzo4iHtJ6uYU6vl/NwS9urUhYnLwYvN89mLiAo/TVj6/BC42krA6Aau1BqGWWI3gzgbY7SSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I9BhsUgHu9NIyvVUommWpfzUKT8CPGIVlfQ/Lgp1ME=;
 b=kYsljzajk3kyHFcPn53WJmvTJR47z7EK4razzwZ+/PO8FTkeym9EDEZ9wr2EFPW1kW0QMfTGKpsogdCD804ixuqsRB6MH1nbsWbqMDAJtWPZiTRFEe+JxIMLxR9OXpkhJvRKC165kF1cH2kEdj8VWjtfzEUv3wXpXd+VYCPyvtNANCosWfMcc1pokwhOUvtXxqf3GsoomcyCeU9oEe/HSYOezbzCBRbZMrCvBd5n6ZmOFHE1AlXYBYzomRhzxUI1kk002kaI6lWZi4pc6mXX2Cg+8KxQ+n7kEyDfyzczc0vaFd8qsw1uymh/1eTAC9O0mndCftb/amCGnKoJHV9JWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7271.eurprd04.prod.outlook.com (2603:10a6:10:1a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.8; Fri, 17 Nov
 2023 08:56:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Fri, 17 Nov 2023
 08:56:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 06/26] mptcp: dump addrs in userspace pm list
Date: Fri, 17 Nov 2023 16:55:59 +0800
Message-Id: <bde0e3431e8a8ee1897a8b8019ab542783608f15.1700210966.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700210966.git.geliang.tang@suse.com>
References: <cover.1700210966.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0309.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBAPR04MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: a7891ce9-938f-4b49-c7e3-08dbe74b2341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jsbOJrNi83c6CBnJA483sQNmsnKPrPByw3lZUle0fnEt09p3daMcI/X0UoHv15D0qARph84T0SE4KRpUGo0KGqvj56mkNOcwoZk1LM7eZj5LbDJnWXfQjces55LKpVxQXk/HUbAA5PsMcTz5qFcU+GR32nTs5AiOW7PVX65Ntx83W2avDuwpf4tc7zMvXYhDf/tS7WXH3znaGj5FRJupAN81b0S6L4zDLZ9pPD2xvUx/aXkalWXngFLYit1CMBs1R5k7EaRcP0VSdkLn6yyzu9bk1U/uZvsbAkujRr6RLGZgRXnL/aoTqNEE3S6m2MPt01O+QAd8p58PxzhTek08ryu8BvzuHjMvJLrF9XbjfO3ePpEQi6fdxPpi/dWoliWNvy2uPmhAhI84nN1JheCkvkNVvv5rgzaNsvbRrs3XMnSS0d9ffBzBPN4fkK1H+i76h7dU7JNVtZzkRqlfI8HR76OWSzr2Mu689RvjPusO0+nnYuZU/y/U0aHp9DbYUjbume1Izdh2dbu6ag7Xvy+qmHe3ZmCbyEjQ7n7X3FVbHRzxi8T89nh39fHFk6DokD6P
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(86362001)(38100700002)(36756003)(66946007)(66556008)(66476007)(6916009)(316002)(26005)(107886003)(2616005)(6512007)(6486002)(478600001)(6506007)(5660300002)(44832011)(2906002)(8676002)(4326008)(8936002)(41300700001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5nFkC6G1+aoYIN4MmXtfkHjdh54Q215XL3XfFicYrxPT1vDzDMHqCY7+NBwS?=
 =?us-ascii?Q?QvGv7xcxjnwyarCO35tlbpvgn/xusal4xGASSjiCOcYWpHlwytzFcgIhmmxE?=
 =?us-ascii?Q?znHvactfozx6M3h6Q/SxFIsHjcSPVEvj6+w7qSXX0GhtLl7LDTMGZlBsr9Tj?=
 =?us-ascii?Q?ras7odCw8xj62Ir0ApuMkW9uzWy5WE3UDXO8b4OYN1rinAtFO9MUqoW5CGjZ?=
 =?us-ascii?Q?OmZ49Zw+J+bUhAFCM0JxrY4T7olKAE2QFDhcbmgcjSSZtVL0vRqQLflJlBvH?=
 =?us-ascii?Q?uB2DNEJ/M/DluPIc6JokwIkgTExYWPytPOIGJLrJZBPtN8xJy0D3FTCpiZpW?=
 =?us-ascii?Q?yWWaehSP8ia8AzsyoEuE+UrOr9AvkOKFLzfB4AHLkTlJYnOj5+curlNXFX5D?=
 =?us-ascii?Q?EVPNvhCldp5MtuLJPNEbjkOToZOHitqrh8nAL5CqiHY/3eX2M/xenCV6K63z?=
 =?us-ascii?Q?584Ap0cTSoJSyLXzc5FNhtm5Fc070/4Cyr3iW/ZZOpqOeY7uS8U/ND/r7hKh?=
 =?us-ascii?Q?NAOEV538k4RLrh2T2RGueedV0G9fvt1AQpERv26Ky4Z46gClEiGkUqWL5Q4p?=
 =?us-ascii?Q?FN6VA0por2nDbW3H4u8398gsV85B/NpCpDPjwscNpDjWi5lWTxNt9TNF/gWZ?=
 =?us-ascii?Q?lF4RpYxT+YLUjbdrpPVehR+uNnQak6s6GJz12eenEhHHk+rqdVjgNlcbWEUk?=
 =?us-ascii?Q?JY/PMnrcP0ImWT/awCNQVjlPu/UmkLK9XuwLD3H3q8S9wMApJGscB6sqqomt?=
 =?us-ascii?Q?8Hv6WD3svezGew9BAlqT7hME+1zTf0ahr1ViMM3PTY8EAI9zV+vjTEx7slkZ?=
 =?us-ascii?Q?6X3uB38/glPJEanxy3R6lUuyHsjLNLAJHgvLkOhoVkRAMx50jtGVb9Az4qMI?=
 =?us-ascii?Q?REJ3IglFLaiG4PcVR83eVtEYBSeOK1MC9ivaPjscn3CGUks4HIt/xq2V+cQH?=
 =?us-ascii?Q?7mkEPmqn0tPzhZI99IQ1S5hAMrEO8AoH6UqQVvmAUkHzOZ1STXOqgIvGFkl6?=
 =?us-ascii?Q?yPmIFljjI1UlzuKx+sgyWFnP9QL2D8duJp1A7/iqM+2tjSN+PpyMDwMVxFgr?=
 =?us-ascii?Q?7CIoITf4QfICzxoMl72kndOPEiqw2KE3NZbpfc6BGDDEYVwU0nFeLz5KTojC?=
 =?us-ascii?Q?9RiUImJAHAeYTNvdPbb8akY+6YChatrpW2fICT/WR5KVQ66j87tGu3ry4VMd?=
 =?us-ascii?Q?atxBHoQ6KwuiCSwURYudmt9tMPFXplcrrQzcaBwKK8apz496XI8dI9oxsAUU?=
 =?us-ascii?Q?F99fzti1OUyHfxoACA9XdwFgKXaJcu0CEQal6fRNyew+7nldJGc/K31xlGuQ?=
 =?us-ascii?Q?JS1rVroDdTGaDK2PtO7zhI61XSn5/mrMYEZdnzKUqn25JyPVZTDgXkx2v+8r?=
 =?us-ascii?Q?mPNDG5TfE73ifPiddNwmuG2ccYgfSbuYl9g3iwZwjJNO6Syc21uE1jbX5fHM?=
 =?us-ascii?Q?sj9Fqf+ssBAASNOknQUXWUthVkFoIWfxyUWTXleYEv4ZfvTrB6PSxj8hxVpY?=
 =?us-ascii?Q?Uivh58WeJhNua/fvz1oc2CgMJ3uMQNT4xY/SIcp2ZPFSRuBMW9FHEQJj3ef8?=
 =?us-ascii?Q?BU+rBWdiSge0Aq8NWgMcRf2KU17pP+hrkPTkATtl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7891ce9-938f-4b49-c7e3-08dbe74b2341
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:56:50.6705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WiRTiihtUxQ0Ltq5uS430zmj2nC5SvqBfz6G76iCDheVgS0qVtRolcJ07ImJfmUPjDukrHTAqIH3Z8bxx4ZSyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7271

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

