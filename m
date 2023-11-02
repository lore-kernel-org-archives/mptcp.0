Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2087.outbound.protection.outlook.com [40.107.104.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19C0125DE
	for <mptcp@lists.linux.dev>; Thu,  2 Nov 2023 10:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="No9s74uX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvm1WS4gZ4E99BHb6+vcYtH7VtIzdxpVEP/rIiPElFCRv2YCz3AunjrR0EAJV+J+fno2IJPFL+MXNFFgPdeWzwLUaIGfqCYoHHCCbLRLKnET5VkfeJ1PFnN/8DyaBoKo2yM3J59zVUq4SjH2r3YkGxZb1SRpIVd/h3+u/pQWm7yad2EmqvQ4OiS7USv4ewTmND7X+VzNpdpca6fuTa7WAyKKMQqo5tTOWSIxDDAIuCO+8+/41l0DkhpOu2vwW7E/ssFYHhXl05vint2SjFF8t/cXN/x4w4ZJgs1Nyu4WhIZ1IZ6qw8MymUr3nku4//F58WE/7XR41Yrx5Nos0B0R0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzDmn+Bg83LLeWLktjSwq4tat9vEpQUpZ+70ab7Ldco=;
 b=EhF5JLUvs3cS1BEB9KFcCphVkthw0OlwaWyooyNXgeXxi9w44jgpVn7kCcyQVwWolCpgnNC2N9RCjN3uID++mNuqV8JWGRl5tv8n5X39m7vhQ9pet0vjIGabP3YTmyCipH2Rx+92LceDkwtbasc/UJMol3fmObD48J/tDfbjhRL3rdpar4h8CNnzR1pdHZmTFJcT/0t9StPOeEKT/TtN16qAMHvbuPKSFZPi3/ZVVUSrfn/v+7NrnCiJ9LYmlRjwvpMt+IYzjIt7LZeAC4Its6IMsl7+Aye3t5xBazCeRWF1gIaICMmT9rNWsrk012H8Pwt6zf7wC1upI7SNnusitA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzDmn+Bg83LLeWLktjSwq4tat9vEpQUpZ+70ab7Ldco=;
 b=No9s74uXDYSi6LERzQKhOh/Dwlf4TVtMGUucH1PkIbRR996JxhVQYqN0boAi+tBgx85Ej/BqpwVDiveA+3jW1cg9auS4ezzWJYoam4OwkHpeZVz/nf54ph1s9YrDjoUvisowe5gLoiG/XDoLvUnAlnojIpyVUZD+R3mtqbbipjZ76enZHqP/8/tTdRBJVXhdJoI4tgrMYO3YJ75q/ic6XzoicjY27rD6PoH48hYNOO+CF5Q1pQ/KSZQLFckj2au5r0um7M/kG7KVRa0SaGwxkaFefFzpOnPrqFiGta+tFjbNPSjpR9s02MmAJg1bxYLXe2GDj9ISNwyAOM1m3MRCkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7686.eurprd04.prod.outlook.com (2603:10a6:20b:290::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Thu, 2 Nov
 2023 10:06:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235%6]) with mapi id 15.20.6933.011; Thu, 2 Nov 2023
 10:06:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 6/6] mptcp: add netlink pm addr entry refcount
Date: Thu,  2 Nov 2023 18:05:57 +0800
Message-Id: <05bcb3d49614735b76ef6963a716439ed2730f03.1698919435.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1698919435.git.geliang.tang@suse.com>
References: <cover.1698919435.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:4:188::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f2794c-8c32-4f45-21ae-08dbdb8b611f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EWfCl5ADpn3dvh96at1zNSeOXCVDisO0IgpAAa+P9/CZCncnS4LQf08ruNnHFDQohIfBMlOFG37HZlhouiD92U81sWspBkTT+KSBoBUQWaqTBvTV+T25SCZ9K6JtOhCnLa0s+lFg/jGqqELQmesOCuHTZz06sQF3w1ODyY8nfmjrVqEBm7Ra3U9CqJ5pKuAXHwpFh4SHUKpBmoLXOxCSOFVvegHX3MrvPFgvrQvEQQYOXSoGx07/E4bRQ/lsM49Zte8/1ls69gv1tD6QVaNGMira5H8Amt7pbLSF8PbqwCjEAQpcrmh0bCZ+ioiUJTSWB/5NxWVLDj7g8PoB21EYYqV79lzWI+TXyfQp2Jg0/QCuluzMgYqoW8SG5+o65RU6LoabHMXHb3HfDGfvlXGqQcZsdaC3qcMGgWZ86a89lUmOVi+I/T1+DJkIOu14wuP6XZqayBeUf6IzUwWtUxhqyxWEapqgW31dLC9okDqItLf+j3+UDuVq3jIQPL3qqk49tf0uUMkSup2XaYDjM/Ym3cOLCKvwCrPDSNxuY/U276s32+Z4yPw5q/lbvd0YZbak94NEJ7pcKE2hDmNmvmPI+Eqd4UX+tAmSyQnWmIyQiFs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(346002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38100700002)(5660300002)(316002)(66946007)(66556008)(6916009)(6512007)(66476007)(8936002)(8676002)(44832011)(41300700001)(4326008)(6486002)(2906002)(478600001)(86362001)(6506007)(6666004)(36756003)(107886003)(2616005)(83380400001)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JToUpm/d2WvajNLFp9ilMWV/JALePxPwu+wKA7QRUyjSuNgwzaBJsB1yYWUS?=
 =?us-ascii?Q?0rqYiOQGJE6HC8Qa0DoHmIW88ECPu4HRYv6saFag5iseKZyj6v5Vjb96Y9hG?=
 =?us-ascii?Q?6BtveTktQ1cLgvovRjyHatyVGnFiKOUXtkog50oZNjtj00zKuBA9oMkKfsp0?=
 =?us-ascii?Q?x8RKDuYDdMkd57D+oDwT0GdADCA0cJYdNgUOIVB88e1PeFUEgQye8K+M8TRv?=
 =?us-ascii?Q?yYCYAPdLppynkttagliCSlPGhX7ajR5ri6Jd7Y5v71C4OEknwl7lWI61XMN7?=
 =?us-ascii?Q?tdxWQay7Taaubp+C2EafUYdAK9YO0hkEMu0da2rmZgwFkgeRMikqHqv5ePE6?=
 =?us-ascii?Q?FYCSKgHo4hoaPpA7EwVI/kqlGWHIrn+wTeAIQ0+nGT6IF5ehChNvg99JPnjp?=
 =?us-ascii?Q?ZwjL1sSrrIykk2oqsYEMZ8MGteG3xXRi+PvNQnyw/nudHu4965RCC8G7FsPj?=
 =?us-ascii?Q?NSwu9iAhnRuDgpwaENvmUHSGQ/Rcy8465aZwdv6fCd3CRRTQoJHle+wQZ5gF?=
 =?us-ascii?Q?pDseg/D3R8Sntl2JAU8ZBGyGncUfL6qQJzTxaPOmWkZgn/2DpRcSyfCiBuPb?=
 =?us-ascii?Q?LY5eAmkKEp6YkJRX9KRz3aPf7FVh0IGrm6shTUsoKsv1F/6WDifX9hN3adfL?=
 =?us-ascii?Q?LVInOMPtsfAWepUfptk20o4zAoCIcnCkr88TGGSyvzSyh0DrD9j6ZboRlw6k?=
 =?us-ascii?Q?f8EzAaJ70bzTyPsqTy3qWp+0QeCvFcV2WmKur67smv1j1i8Vqq/3atSC01jH?=
 =?us-ascii?Q?YwV88ii20dPKpCIlGBffcHPqo42ChoGz9JtldfMXj8fzJPEQyrWe+eW+z5Zg?=
 =?us-ascii?Q?D8H64HSq6lM66jW5MgxhU29VmVwUIVoq8ZOxQs8PEBfBS6B1chMekHOgmwns?=
 =?us-ascii?Q?1RWOOTiSSaxvhc8k/f5CV8t3jOmMtZef1LEgt0rqMToCT9P2lPWUoS/8cPXb?=
 =?us-ascii?Q?wSoCsEiXsmMa5abNh9nkWRsjYPix2Fkk0ly+vh4ZFaO97f+N6SpFl+9Nz0Mj?=
 =?us-ascii?Q?7OFmtMDHEgsTq/c//DVzpqILXSPjkZxnzz5/wN+InVSkpOg1ZTqJqi4xY1/5?=
 =?us-ascii?Q?yBEND3GMSCso72pgLR4ugqs5CNdROQ69Qlp1M9m5s5pPU8R9qBEx/cLmIoIe?=
 =?us-ascii?Q?FSIPR4Gk2AGiSv4FAenDUuBkPmjqf+dqjzERaXEN6qZqfjTHabCBQRrtWvNf?=
 =?us-ascii?Q?+0ghmoIST+1KE48yNvpWwOAmQ95VnY3JYSxpccWzDzkFXDlIDpG91uGAPc3Q?=
 =?us-ascii?Q?87zrXAfaVjFUlytZcsCvOw00U+k+6Axy2k/awZP9mniyvFtuVYpLAZG8iLR0?=
 =?us-ascii?Q?fcLIldwUERwS2HfySOOhPmfuZEAeqhXu+20zENgxdFxHaQjQ7S1AC7LDV91o?=
 =?us-ascii?Q?qsxWXBDX/mZWQFiascY77d8k4/OI0QJBuEAEQUnjbaF3nF3WB4UJ04+lLQk3?=
 =?us-ascii?Q?tZSDwRTZw85ELv03ARaaecaxSUO6MzDQhcZ1oOgoWlMU9S+TJeUVJOrjj1LW?=
 =?us-ascii?Q?zZwxYxFeze4JEmLmEkeGKHCgLMjHPW9IC1nSLxP4F99PmwNuftfZ2Pq1/+sY?=
 =?us-ascii?Q?WwOQX0AwSjjsl2CSKXTe36XnXRrq6wFuaXICgTF6jWLdzUlshkl3Gaj02XCA?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f2794c-8c32-4f45-21ae-08dbdb8b611f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 10:06:28.0593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+vxbOXYIL+2gaAe+8qVWXE2co6gSgeotxutfeYT20x6tED3VpRPdgzA/st285XfS7E403VaxfSpwC0cRA4wTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7686

This patch adds netlink PM address entry refcount. Init 'refcont' of
every address entry to 1.

Increase this refcount counter when a subflow connecting or an address
signaling in mptcp_pm_create_subflow_or_signal_addr() and
fill_local_addresses_vec().

Decrease it in __mptcp_pm_release_addr_entry(). When the counter reaches
1, then free this entry.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 0e10ff1050e7..c80cc9c01c96 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -653,8 +653,10 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 			continue;
 
 		spin_unlock_bh(&msk->pm.lock);
-		for (i = 0; i < nr; i++)
-			__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
+		for (i = 0; i < nr; i++) {
+			if (refcount_inc_not_zero(&local->refcnt))
+				__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
+		}
 		spin_lock_bh(&msk->pm.lock);
 	}
 	mptcp_pm_nl_check_work_pending(msk);
@@ -694,7 +696,8 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 		if (!mptcp_pm_addr_families_match(sk, &entry->addr, remote))
 			continue;
 
-		if (msk->pm.subflows < subflows_max) {
+		if (msk->pm.subflows < subflows_max &&
+		    refcount_inc_not_zero(&entry->refcnt)) {
 			msk->pm.subflows++;
 			addrs[i++] = entry->addr;
 		}
@@ -945,9 +948,11 @@ static bool address_use_port(struct mptcp_pm_addr_entry *entry)
 /* caller must ensure the RCU grace period is already elapsed */
 static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
 {
-	if (entry->lsk)
-		sock_release(entry->lsk);
-	kfree(entry);
+	if (!refcount_dec_not_one(&entry->refcnt)) {
+		if (entry->lsk)
+			sock_release(entry->lsk);
+		kfree(entry);
+	}
 }
 
 static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
@@ -1137,6 +1142,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	entry->ifindex = 0;
 	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 	entry->lsk = NULL;
+	refcount_set(&entry->refcnt, 1);
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
 	if (ret < 0)
 		kfree(entry);
@@ -1364,6 +1370,7 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	*entry = addr;
+	refcount_set(&entry->refcnt, 1);
 	if (entry->addr.port) {
 		ret = mptcp_pm_nl_create_listen_socket(skb->sk, entry);
 		if (ret) {
-- 
2.35.3

