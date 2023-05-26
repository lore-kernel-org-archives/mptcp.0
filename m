Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03EB17C9
	for <mptcp@lists.linux.dev>; Fri, 26 May 2023 02:17:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPjfeMZ18HMrPvbYnc0o6KYPZRbSaGJSaB675WzOcWmytuVg0ralP53snbgEwZjz1DD3ZBT/GlQZVCJKxKoj0PyRdMWGXsxH5XpvnvwHmLtJ/QlXg/SEGyJ1hB3CCpT3ZTrEnXta710JUHuEcJtkPiFnJMPtfVjRJZRXgjJin22RTjO4thfkd/Mhz0fmFbT83K+PuU97fwJh0C+7th6SrOu7UHY8rb8OnnsGW6+4dUhrH5c/f9Y7g2BrqMx04AoNmONbBl0gxDlDHdrqjWNxtjuzJ2eDjqgQviVcQlEwvZwjYVwxhVX0T/fnBkLA63WFu31LZOwrErZvh77YjcPF8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMoxC37btIoNVLrRHzUuVNInNvDPjhJ2fZUUfDW82Rs=;
 b=NlZ5y5N5JCQzfLTlFLxF7smbWJmQbV4D3Je88wAuJA9e3cG1r4ssMQQ9H/dFjwS6AQJqdjOCrj30OsMWUMprpKiX0Fu4oXZOs2LrR/Hkr3miwCzSBQTFbIm8YWoj2N0GNrKKSbN9v1myYyi8o+0x2q2T4KCoOyepQXv4NPXNQakEqNGdX+i7ijT5DR5VKXnml/vtrGupy6ybYke6pE7FHqb7tmvUn+vaZaBgxkoiWyFnDneknqCv3bEdbHubRvNOnKfQB17SlVNS5JAU8+lM3ubuOOPXG6qPxOaZQIqs7XdbUuQY7MP7L+n8gTkNcoqA6gcTM1UPLgqIy8nSa087IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMoxC37btIoNVLrRHzUuVNInNvDPjhJ2fZUUfDW82Rs=;
 b=tUuWrH2rAxYmMb2W4fr0RivUd1YileVqXV+dt1lkV+M12tZoIftFLolgA2rxAmExpIqme660eqWAquZJ0OxqJOROQC2hbKYoNF6u/ymtq5O4C3bn8uxdUe6OYkn/Rb0hlM8uyIEiNgW5Qt7RnrGYm3R3xvdVj9HHx/i9a8lTwVIgO5s9CSJqexW7vVmfMXRsT99v8DgkfcC7cqF1LUjeTiYPFtSsP0UEtY9eK4SrkmwCWbK8AVV7HZ8kJu7PxQfhFqcDCFRg7NO5vZJsfv86OhA/HZwo6+ASJsKCuT0kxajGobNf5wV2FGEy7KNJteGZCr9Dpb53j4ROUuwMJyolhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7466.eurprd04.prod.outlook.com (2603:10a6:102:87::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Fri, 26 May
 2023 02:17:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Fri, 26 May 2023
 02:17:08 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 4/4] mptcp: unify pm set_flags interfaces
Date: Fri, 26 May 2023 10:16:11 +0800
Message-Id: <ae994823d6d110c718c395a2756e58c52848a12f.1685067241.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685067241.git.geliang.tang@suse.com>
References: <cover.1685067241.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0241.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: f4230df4-3643-4d86-31c1-08db5d8f4e60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IYyocQL/2033fRXJEIBjCgQM5lVQkij30E01Up/ifcJtgB2Q1cLMl/AkXTbqffj4sIRr5YWNQjbdrLG2FVJzQyJtssxlIMwfaHjL5QlSc5wE/uNjfm+PTgbtXHm8ro2ZftrdghuBA06P9CiQ8J6dgTY0BOrmT17fMF/cm39OGY1HZbwp7kkfoM1GT7QESB5zTdiWFXzOpQvHIIc0r1gibJDQQ+ZlXu+uxpWe6RNSwoC22h7wFtujK8ZxXdvvJbyz2H1Xh9M9DXKGjTT1f9cHRRXU8R8psDi1scdzmCKPbGnIRwXAUYaj/8zyeji6QpWxVRj2huahfXdmyetAWSfl19aYnjWiHozTBrYCfjP8XALEgoQ/8RYx0NQU666ywIokVNBDRyNUQSkvyOXTF3vIQmQIR3hQ84c2tXXstDXDYSvGjppFzbz7sgmKU7W0Tu4huo9W4QXuJHQl88DYCih7Ef16p9/tsWCgL1ASb0dOkGleXoorQTmcCTTiO9hBAp3lnYrJFmNemZenhpmXT2bKgfB0Li1EOPOJ4xFDCYnpMk5ad/yCVPRkd386Q/Dq3dVb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199021)(2616005)(4326008)(6916009)(5660300002)(8936002)(36756003)(86362001)(38100700002)(2906002)(83380400001)(8676002)(44832011)(316002)(41300700001)(6666004)(478600001)(6506007)(6486002)(186003)(66946007)(66476007)(66556008)(107886003)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8LxROtWbpBT6Q6U/asOOxD+ojGgpq6OPKc7wRq2L+j7CLFKNsKUyqN1A+XuR?=
 =?us-ascii?Q?ZQWomktcVqCOppRyt0Sp4+7i1vtXOpYbWU9zi6/ICDTmwTdQA2Ls7xYH6IN2?=
 =?us-ascii?Q?CID3KMYTxcF6TsZJYreZkRHTAFR0izEZe+pqmTV1guM+ToHEBPNnDMknZatP?=
 =?us-ascii?Q?itbXna7FCW1czdEPc4rgxqjfbvkhO6807t1sD83PlGHmqdjRuxeX0r+LWOg7?=
 =?us-ascii?Q?hQK2pAgyx7mV/fBTXusorAG7wP8dEERK/P/S4u4Je+YvziKj60aH9dzUJJYL?=
 =?us-ascii?Q?sECXDT0LRWbiAbVD8o1WX08KlIWvdi5zcOOX5Nc/q4W4k2gPBXicE+JxjfF9?=
 =?us-ascii?Q?c6zxYNfz+fQ8gFZslxahn76i3UMnZ19d87Buevt5dJaO1p/vZFPoJI8m5lzV?=
 =?us-ascii?Q?a1dhSgbHvfz/bFGMKDFDW4if919BykwqSO/SbsOIgvWb6C7adX9wdirKt2IX?=
 =?us-ascii?Q?iTqzNTha02IZSWPOFstIcNAot6Z/irb0sZjjaNpm0ZyKJezcdECYrp3ANdxt?=
 =?us-ascii?Q?aRbnBdQUfp9RvU0Ff2RYe6GfYWMdQajbJ9gcaEaUe4UKoFA5I0u+jYXItb+X?=
 =?us-ascii?Q?6GhViTSOm78Z+Pkc3eYNelAs52TnbXmaHJ3KD1hWES7kvdULB/66wAG+J3EJ?=
 =?us-ascii?Q?4f1kBbS1Stm0oamijRf0SbYOmEFlqdq6DrfiECn36jeVBIzyxENV0HLLU9lL?=
 =?us-ascii?Q?YCpqPX+lhf9cFbDQkS/ylpmLvXJkcM0+nPr1c3Agmjk7dqWp/I5dOSJjQu/C?=
 =?us-ascii?Q?jfrWLNjZuhfrzRzUaUmenIe0P3nlbju6xzCZTl5pb4igGhr1q3Tx5q12YISk?=
 =?us-ascii?Q?4jmg00KvMQ2woRfYmozoYHmO4CagWwjT8hcIIQGQqfUVcliJYQwBU1kq3Odb?=
 =?us-ascii?Q?LdqZgIwFMrskp/oNbmV77aFGNBaTvolZ3qOIpjz4MJYdMiNiFLAdZuTztuHa?=
 =?us-ascii?Q?tjXKTdk84hxaA7u98jP/HY8jTSOFKrHsW0epqFF3gmlhlP5Bk6SdSfGNWkh6?=
 =?us-ascii?Q?Ka+LUCUc490gyyGnNMwVBpMDdEqGA+CHwWx9i4mVeHjHdF7fwYF6kGbSTNh9?=
 =?us-ascii?Q?ilwRzwES5MnJJp24w42cZhR7Zt4+vAngMRkagvLWLI9r7FBljIYsVyWmVRQw?=
 =?us-ascii?Q?WugLV9h+KoayUqd5Br7iumyRUCYgeTSAafO1/NHksgnAC4LqRMctX7aWHGpO?=
 =?us-ascii?Q?+yf4A0YINUv6vd67r5Vq9F95et786noLB603XApwV0e6ObDA6zHysJ8M+coH?=
 =?us-ascii?Q?EfkcEEHqygizisNojmKhRRqpVsmc/kcP/OPqNvi+Jgg2pysoHk1hsdSXFADu?=
 =?us-ascii?Q?dsnzho2sm9TC+QrJRAkRgM0K5D2mRszNMhO5gol/cFF80cmzvJXZmSVD98R2?=
 =?us-ascii?Q?Gsdv/eunj4UQLF5INWJkmtBh+INB23Mv/QQYe20QxZzcEoc7B2oj4JfiSWSb?=
 =?us-ascii?Q?Qz6IeZS5JsBVsdBv9fxizqCHnE8lbbFmZA7vPKwPrHAG//dfz+LdQAHwOU4I?=
 =?us-ascii?Q?Jaew/L0zNywMSaQQ/bBqJJkFTzqqmaWfh4/alRsxKvpycNmiUa2+iDPZV+g3?=
 =?us-ascii?Q?r/XZFMRQK5OuSwsQ+0yzaQITmlEn837FFfKuxDI3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4230df4-3643-4d86-31c1-08db5d8f4e60
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 02:17:08.2793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFJvK3gAbkzFjIIM9TF3ebrHuLCo8y4HOuSXrKmQMxfgYvd4FovUo0UntJD5+eS0OmJaVyfCFX0X0h8Sm0uWug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7466

This patch unifies the three PM set_flags() interfaces:

mptcp_pm_nl_set_flags() in mptcp/pm_netlink.c for the in-kernel PM and
mptcp_userspace_pm_set_flags() in mptcp/pm_userspace.c for the
userspace PM.

They'll be switched in the common PM infterface mptcp_pm_set_flags() in
mptcp/pm.c based on whether token is NULL or not.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c         |  9 ++++++
 net/mptcp/pm_netlink.c | 70 +++++++++++++++++++++++-------------------
 net/mptcp/protocol.h   |  4 +++
 3 files changed, 51 insertions(+), 32 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 74b81d5ca4ce..d8da5374d9e1 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -441,6 +441,15 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id
 	return mptcp_pm_nl_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
 }
 
+int mptcp_pm_set_flags(struct net *net, struct nlattr *token,
+		       struct mptcp_pm_addr_entry *loc,
+		       struct mptcp_pm_addr_entry *rem, u8 bkup)
+{
+	if (token)
+		return mptcp_userspace_pm_set_flags(net, token, loc, rem, bkup);
+	return mptcp_pm_nl_set_flags(net, loc, bkup);
+}
+
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a77029648f36..ba1406e601e4 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1879,18 +1879,50 @@ static int mptcp_nl_set_flags(struct net *net,
 	return ret;
 }
 
+int mptcp_pm_nl_set_flags(struct net *net, struct mptcp_pm_addr_entry *addr, u8 bkup)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet(net);
+	u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
+			   MPTCP_PM_ADDR_FLAG_FULLMESH;
+	struct mptcp_pm_addr_entry *entry;
+	u8 lookup_by_id = 0;
+
+	if (addr->addr.family == AF_UNSPEC) {
+		lookup_by_id = 1;
+		if (!addr->addr.id)
+			return -EOPNOTSUPP;
+	}
+
+	spin_lock_bh(&pernet->lock);
+	entry = __lookup_addr(pernet, &addr->addr, lookup_by_id);
+	if (!entry) {
+		spin_unlock_bh(&pernet->lock);
+		return -EINVAL;
+	}
+	if ((addr->flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
+	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
+		spin_unlock_bh(&pernet->lock);
+		return -EINVAL;
+	}
+
+	changed = (addr->flags ^ entry->flags) & mask;
+	entry->flags = (entry->flags & ~mask) | (addr->flags & mask);
+	*addr = *entry;
+	spin_unlock_bh(&pernet->lock);
+
+	mptcp_nl_set_flags(net, &addr->addr, bkup, changed);
+	return 0;
+}
+
 static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
 {
-	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, }, *entry;
 	struct mptcp_pm_addr_entry remote = { .addr = { .family = AF_UNSPEC }, };
+	struct mptcp_pm_addr_entry addr = { .addr = { .family = AF_UNSPEC }, };
 	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
-	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
-	u8 changed, mask = MPTCP_PM_ADDR_FLAG_BACKUP |
-			   MPTCP_PM_ADDR_FLAG_FULLMESH;
 	struct net *net = sock_net(skb->sk);
-	u8 bkup = 0, lookup_by_id = 0;
+	u8 bkup = 0;
 	int ret;
 
 	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
@@ -1905,34 +1937,8 @@ static int mptcp_nl_cmd_set_flags(struct sk_buff *skb, struct genl_info *info)
 
 	if (addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP)
 		bkup = 1;
-	if (addr.addr.family == AF_UNSPEC) {
-		lookup_by_id = 1;
-		if (!addr.addr.id)
-			return -EOPNOTSUPP;
-	}
-
-	if (token)
-		return mptcp_userspace_pm_set_flags(net, token, &addr, &remote, bkup);
-
-	spin_lock_bh(&pernet->lock);
-	entry = __lookup_addr(pernet, &addr.addr, lookup_by_id);
-	if (!entry) {
-		spin_unlock_bh(&pernet->lock);
-		return -EINVAL;
-	}
-	if ((addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
-	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
-		spin_unlock_bh(&pernet->lock);
-		return -EINVAL;
-	}
 
-	changed = (addr.flags ^ entry->flags) & mask;
-	entry->flags = (entry->flags & ~mask) | (addr.flags & mask);
-	addr = *entry;
-	spin_unlock_bh(&pernet->lock);
-
-	mptcp_nl_set_flags(net, &addr.addr, bkup, changed);
-	return 0;
+	return mptcp_pm_set_flags(net, token, &addr, &remote, bkup);
 }
 
 static void mptcp_nl_mcast_send(struct net *net, struct sk_buff *nlskb, gfp_t gfp)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5bba863c5167..87c996e018b4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -843,6 +843,10 @@ int mptcp_pm_nl_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int
 int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 						   unsigned int id,
 						   u8 *flags, int *ifindex);
+int mptcp_pm_set_flags(struct net *net, struct nlattr *token,
+		       struct mptcp_pm_addr_entry *loc,
+		       struct mptcp_pm_addr_entry *rem, u8 bkup);
+int mptcp_pm_nl_set_flags(struct net *net, struct mptcp_pm_addr_entry *addr, u8 bkup);
 int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 				 struct mptcp_pm_addr_entry *loc,
 				 struct mptcp_pm_addr_entry *rem, u8 bkup);
-- 
2.35.3

