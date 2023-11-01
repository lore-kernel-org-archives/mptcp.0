Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2080.outbound.protection.outlook.com [40.107.104.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE407F
	for <mptcp@lists.linux.dev>; Wed,  1 Nov 2023 04:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="qvLObUdi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kvo9MIodK/7+E8pxkcwokmWYVc0reDnU/+c0HWqggq1FFiqTWLiIPJUx+mrVxMNH9YIviG2xJHITpwcHX6NVUtlkL1MdNNrP06Npc8Ed3EWEG+UcnS/Yzj/JJHbOa+nYnMktSL25RV7rITYojzzggwFIwIXp1hWIcPba95ssfaqdYuLRfRcw71Hm3KA6cmn29IdXB5a1jJ8VtZSaRmRsy3GlIVKYrhLp+T4Flz6XNdE9FxD59egRtZ195tYUo8doOdWIwZHiwwnuLYg1YWnJMwDHgBvUZYNAFGmqYKY6n4xMRVBEsNYdsXW8gWT8mTWe6SlIcAS0GjDIExsyo3azgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioNIBttAsZxCO6Eyi+izpxVjMGqWLp67YkoKkjGczjM=;
 b=hxXpngQ/bwMXU0Z9gM+ma8xpYMOmIGuPRU4HTIdO5iAPsl/xJwLlOLDQZgHrq6h4ogAt4JvDloMd/E77qgUkOblLhYSqCBSrSvypYxRJMkxVWzWMbLfv7Vn1dqrYYod/iZ43oG5uLffqLH8sCBerydAoChKkNdfDesP438D4e6hiYXJu8JqaW4mUzNxNU5SRSau8aIIGFnX5swQ7GL+jgtr0Ib0xJHKrbIQ0+n1egQfVik4GbGbj0mBbsiyNX5GAQWeezeFF9V7IVYHzy4UFswV/Ew9kcpAjscEmvuziWjtdAtkKN3U2pP8H/HTGJsqIKaNfj7jvJrYBI3YYuBoWLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioNIBttAsZxCO6Eyi+izpxVjMGqWLp67YkoKkjGczjM=;
 b=qvLObUdisTn2zSxHYcnKTkumirVUPPgtgwfpxLxYu5PUCchotdbEG0x46FxFZPcD57CGWeiWTCcnL8HnhTTVvLHhwwtvG5ZOvOouaT1C8/6JWPCtb0ZQpxpBDp9zA1eOY2S367Z0MYDTpdyE3RdC47AGx1cyz9r25NW2sB+3gni6+84GJV3fEKUtCTfMeRXDShLFRKdOUVwOn4BZ88B9mGYt8g3Cy9DhL/bGIagOeWHzYEyR5pvygDDBvvDzlQq8frsishu3zpGE+xaD27Opm8f1Brxj7Y/1p6rQt83peq1wCMnZfpyYZeXmb5o7VyGu2hmfibVKWMSDMDVjUkw4xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7070.eurprd04.prod.outlook.com (2603:10a6:800:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.18; Wed, 1 Nov
 2023 04:39:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235%6]) with mapi id 15.20.6933.011; Wed, 1 Nov 2023
 04:39:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 9/9] mptcp: add netlink pm addr entry refcount
Date: Wed,  1 Nov 2023 12:38:24 +0800
Message-Id: <592df7187a35e27e8f478c09c8ab14b99c2eac90.1698813419.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1698813419.git.geliang.tang@suse.com>
References: <cover.1698813419.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: b9bf4bdf-16cd-485c-2608-08dbda947d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J3OUALbAnIy4k5lGAS9ul24Q7V5OMELAlV6URUbPWEix+2gePcvw2shskyqvZAJKLXWQwXehaZwxdiRihYfcd2uwMPBRot8y/80PQsmNos+1tYsE8+fn01qWqRAiWJCDPi8k2s16PMfCbl2xfjHcdTBed+XPPHOSXpX0KAGqVeojRNqh3s0T/t+rnuaBBXY/0Kf5rBHbQYTD/L0SVsIcrt+GRf1pD2GQ8KTUyGxjQ0WbCBy5eiXXqT3ehS7vIOTOBDPsCV1z4iYZkEiWtpo7+xaWYplxREwdblpSoqKTl8fhCLW5EfHEuGHaEvyX1MjKBgn7D1gturOH2WPkjou8uVwkrcXm/jSPjuCrw06IYiiSOdPX2eTguHEoyjh0Hs9rgfj0P2ugHQKtJPT9uMRvei5bNKgEwa20G62pK4j8Y763C10TzsX1mUK1EGoKRc5GaBdX2JZCBHBfrjb4+GqBB9iDLw0tGcNfrt1Araask4F+jhTIz1q8n0P54EdjjQ/YBLVDpJPioaRKXLDS61Laow2gWdZWrsxJMJwHr08kjbn6DpLbMJj5/a+XQ8VEiFnyABDIPQ95LjeWAEi97t3kXtK9VN440Bg4gQUsrH7HwWo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(44832011)(38100700002)(66556008)(66946007)(66476007)(36756003)(2906002)(6916009)(41300700001)(316002)(8676002)(8936002)(83380400001)(4326008)(6512007)(26005)(86362001)(107886003)(5660300002)(2616005)(6666004)(478600001)(6506007)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BiQcuCsw2SMviv4wOPt8axC+aCiLh3kaNScMlZ5ZNGqCJPYLBAFsSd/fp5RC?=
 =?us-ascii?Q?Relsbtz9xnqdSelsvXlOvq8RxWKXrM/8IoqXoLWGAWGnmf0JLRqZG2Ep3tyV?=
 =?us-ascii?Q?YPR7xWklMCwpcyEKbAzXJChEqUTuZQbLVJZ4aItk+YZKSK1TObDKJXF4D8Xz?=
 =?us-ascii?Q?HYtiVMCQ6jQflKWJwno8ontLbxwrQy2WJJY4ZjD8Yz8h7v6Xy4XPEdu6pDFJ?=
 =?us-ascii?Q?gA/QgkCExDI5TPj1jY6mJJjSxVAjq4VRBcY8EItj7xPfCPyauK1bbQGBbA3e?=
 =?us-ascii?Q?uJUZ9JerbinQc6qCiQ2QorJMjIs9r2Z0CZd1YVDTZhNQgzMt3kD1FwbIH25N?=
 =?us-ascii?Q?myR4I122oTn5mkWUc6RkUzCqrWUqkbHshTeeiKIIg2/RPMKcNAl3nrH6NugE?=
 =?us-ascii?Q?r3/8aBrXUWbyt0homaAlbR7qoB4Yz/IPjNNCoah7UopMqSMRcSqi5ilPi5pY?=
 =?us-ascii?Q?1do+uWXrwAfq0UBRfBfZsjybgCVi0uZM9cjEFLRFXRZEkec5akeRYAmAvawj?=
 =?us-ascii?Q?8AwHqkOZfi2Vw0FSUbCjhOPWKVuK0YzSxtegCMnkaSEpVZ3JJezyQYLogKUe?=
 =?us-ascii?Q?czO393qfiJIrLnJn53yeBe8N/HNaooQ5+WcNwzpVSG9z6n1ZrCVPZAEWjyDJ?=
 =?us-ascii?Q?6HcUraog3GpvXixqTa93BhRJ1mwmWSNCOWiQVv773miDyghlwpWhRx7xSbO0?=
 =?us-ascii?Q?9mn3asmA578fTK+OGtL1VU/8zvax01P0RznZ3PSaZrp1jdMAnzcRZ9WCb99i?=
 =?us-ascii?Q?k+yy31eUcaDuNpA2/NOfAIS8De3+zGtdhcoXgBf4W5CSmz4znQxLLD6FtOHg?=
 =?us-ascii?Q?5zY8VW7/t5QPdqhTNXgKNjxv5wWnnLkYHyT7WtWQ1fcrZplPLimSco3oVfyF?=
 =?us-ascii?Q?vv/IloH8DWlCtj3weeyyPn5zGHERDyQ6epNkwcOA7yd3SAfwkIchcnTxadHl?=
 =?us-ascii?Q?6EfT4E82rLoGPj8Xb4o/JsYnwiZ12qVTURg2yEqeACvq7AdDFAXODhnD4YAE?=
 =?us-ascii?Q?Jx6RxCk1o6CuHN3waJaZsH41tChNfb4ITJ3CcriTp8Sn2M2ZJNCoNQS/FQZZ?=
 =?us-ascii?Q?0xLQ4JFr728CyO3P63GxS7QYpkqsp5682oN3Uj3nG0htXCFY9AvNs9cu6Iws?=
 =?us-ascii?Q?4zSVvltNvs2xnK5+uB0fDc8IRw0CLBDQx9OiCdTPHcU9Oi6rqoLhq0K75hET?=
 =?us-ascii?Q?9hVMjczq20DwwWubn37PPqnklb9Ch2Og6D/Dqv8qb3UA9OxGHzhh9HJZTHU4?=
 =?us-ascii?Q?IRMY5mizjyTZhW7UsI4pFLfcGc/Mm/K0tmu9T/ahVhDq+FHxonS0lMVylgPd?=
 =?us-ascii?Q?waW1D8MYZcjMzgoLaMH6L43v6MytRiPMuG2Ku7MdzwKd7rEgiVm0DPJqOWIf?=
 =?us-ascii?Q?j17jRdaz9rtI4y2lqGjRMCaE9tulIZFS2WhCF6pE8RFIsm1B58LSJLbKyvf5?=
 =?us-ascii?Q?dRy+7flmGIqKJqg3V5/ypqdveFhhgx78S//ZjC/5jLFZVps9QruyPN6EF/C5?=
 =?us-ascii?Q?2rRNpJCnyZ0WPRKQHFZsADedsefmOAUA3i8NxoF/lOuuXcwe4LQitbtlJtUJ?=
 =?us-ascii?Q?sbNplaDOref0eyEac6nMgHjqSv2yFhRRRLSaguUt?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9bf4bdf-16cd-485c-2608-08dbda947d37
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 04:39:09.6864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1vb+/wbAGBuNE3XMDzGkLKirw0ZKOQtD5aCUFZ1xuHJw4hdBV7AuD1Zk5g5SZKL3LsFBLQzyjSSafamqJvsew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7070

This patch adds netlink PM address entry refcount. Init 'refcont' of
every address entry to 1..

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
index e5deb05293c6..74dd2613775d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -603,8 +603,10 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
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
@@ -644,7 +646,8 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 		if (!mptcp_pm_addr_families_match(sk, &entry->addr, remote))
 			continue;
 
-		if (msk->pm.subflows < subflows_max) {
+		if (msk->pm.subflows < subflows_max &&
+		    refcount_inc_not_zero(&entry->refcnt)) {
 			msk->pm.subflows++;
 			addrs[i++] = entry->addr;
 		}
@@ -895,9 +898,11 @@ static bool address_use_port(struct mptcp_pm_addr_entry *entry)
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
@@ -1087,6 +1092,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	entry->ifindex = 0;
 	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 	entry->lsk = NULL;
+	refcount_set(&entry->refcnt, 1);
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
 	if (ret < 0)
 		kfree(entry);
@@ -1314,6 +1320,7 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	*entry = addr;
+	refcount_set(&entry->refcnt, 1);
 	if (entry->addr.port) {
 		ret = mptcp_pm_nl_create_listen_socket(skb->sk, entry);
 		if (ret) {
-- 
2.35.3

