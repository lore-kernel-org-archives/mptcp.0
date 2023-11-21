Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F56C8C0
	for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="nLM5JXG1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nF4FKQvHbi0c6V5CH8xqKV4eA2LqT2v/JRJ3CquzuKgEHcTqElotCniOEVYCXCfl0eOePs3LF+oH0krv3KlgH97kfpdRJJR33q9JlcY+A5+DbeZV5eVX+DH13SNsm6y2/PrblcqOS7F+O+m3uFNIMoGgKe47RMtVdQKhV/LmemjBXV095UsbodgMApNvHtwns22sJXSBsi9KiSbvIMo1LuArDOuLDHDJ+dtwnOLrVfHQ0yabwo0M/GJLFgaFmoA0qSOEKZmgbLXcaHyMGSyYdgzvyfvBea91EuVc3JOz6aeYymfXt4ReEp75fR7eNvycI3Pa6lgaG6/OUAGgjeozQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNtg0ENlx6XyP55fGgvTpB7mqIxaNS8NhC8buwqnLKM=;
 b=RqGP3JwQdp9RUwU4nWJKXbDtIfqRKA3CBOLbRplfrrvJLJvAHzs8+aDQ8i6n7WXsKpkbifdeAjIGQE6CZ9lBOgCaZ1H97fqST2l1Sj2rStT6RWhGcc36JCfH17lzm8PPYnRfD7fwkYPLt2yqfccDtj5cTaG90Ul7ooxxQO9CMUUzDkF91DjcTkn2eYPojuZqFBsmUhELlDLtIe88c71apWBHe9DU7IUZGR1jq5WppRfISdx0Gy+izk+1rbnPnJeibogR8YAIEty67ov09WS8UDFwBn0zdd+5DTbr35M6jHigra1QZfqaQk3l6EZFTACZ6Hbikce6cKuCpU82bk2i+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNtg0ENlx6XyP55fGgvTpB7mqIxaNS8NhC8buwqnLKM=;
 b=nLM5JXG1hbTeP9TjJkEXAWNfPDpY/SgU3DwURc1HCLJBN6/iycu/5Uy74XodaTtqoI/Ch2dkGIC0TzCFYcufqLDJdrM3too2IIiojV7sPnLcTjxev55WqzhnZzHhszNCZdtB21y3ZcTc9Oeqjowzsl/zlC+L7MCn0QjrCGsRYFH6NvBrnJCFTlPsCC5qvYZHX2gjVPL4PKM1mjka5WoltwECctZsAiLSrlRMosuFEkOm71/ZuLXhtAqaV+EUd71R+ILTRgHqnX77iBoaLlBuwgBD5iVj1zDcPyDxBFyD9d8u0Bx8OPddKW1drJVZfQxj1cTrR3nOrwKlJKgpHEsQBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9667.eurprd04.prod.outlook.com (2603:10a6:102:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Tue, 21 Nov
 2023 09:56:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 09:56:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 24/28] mptcp: add userspace_pm_get_entry helper
Date: Tue, 21 Nov 2023 17:52:47 +0800
Message-Id: <8c00174c4018d64fbd09d75a14c1b564c9c0bf7e.1700560046.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700560046.git.geliang.tang@suse.com>
References: <cover.1700560046.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9667:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e686e5e-f7a4-4e65-0b22-08dbea781539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	otA5dCSfmjFMcnu6d5VkTLakSfQPeMEX9gsMbdiaURi1QV2pZ8Scpt4HpQiZhzcVzMVJApYyQm2qChjpU7OkYz4Zr7XYj0/1igsrPUHzOftahb++Sahe702881CIMqC+HsL9eX3Yekcl2wYl0WkofKFzz5hBea8WVZuPzC1G4MbJMlrcTNKA5dqlMIOPW5UeZZVYz/TYBF+Fo+/eaiW/YNunNk3ulryq6xgX65uLAc93LkrBfpKDyjoHEn+8woG7DH2eYQJ9Ft2cDXRrSRe6RWnF7M4e7hsPprDwnuWHhoXP3+qfGPMVWwFQS2rO52LegA8gijr1Ng4KN9rqfcl9b+nqWbld1KebUhwvj0emF7Xo4XQLUvF7e2V4nkpR+LqnZeZE+4qK7iNbUR1HEDlAOipupqT9wWvPu1x54/MnTgYhRa7gyN2EDu7lwpEA9HCtES7laiRIh6ExZVjivhDHyv5pQcC3/2CHl6BkxaOjcANZoCo4ApiETztk+qw588u0xksHAMuPNU/OiFddVF64i61fkh/jflMDxvu+vmeI9Zx/DpD1rOZOPSBwgsx+m55a
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(6666004)(478600001)(2616005)(6506007)(6486002)(26005)(6916009)(316002)(66946007)(66476007)(66556008)(107886003)(6512007)(38100700002)(8936002)(4326008)(8676002)(44832011)(5660300002)(2906002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cvsdHKe0H56Psv/rd2GU2hjGWefuMszINaZgM1i7BoYT58MzialbpOhQH3f3?=
 =?us-ascii?Q?sdDvaP+9HHQzkT4d3w3v7rJzCCnE+QhSBWvacfZGWwZZCOwfXynfA/kQZ3br?=
 =?us-ascii?Q?rzvztqZAbX7Nk/StKqNNTu8yhbMomMQVv4yqPsW/OicEAvRbOWpwtzBR77lr?=
 =?us-ascii?Q?5OwmUXkRM/4yDKo04DaizxWlWR6ZuGQ7SuUODRP172fNf0kt8+0TZiaF9Q+G?=
 =?us-ascii?Q?Y4k4YLnlDbAeqBw4vUAQJDxo1ELtOz9NisbrEoBdI7DRBdpc7ez8lF1OSmwN?=
 =?us-ascii?Q?VSgVDRSr6wTVBqhcHlVy2xTDkcmFRjhp3kStVVm7wskfFMPu/3lqWiDtydvE?=
 =?us-ascii?Q?+ZAyiD5n9HmWxzxCMoL7OYbkLsyJbJmsvTRqu95FzXF51VxK3XelCE8QfhHx?=
 =?us-ascii?Q?lyZUOSrh4Dt3wDtPk1Y1uUaiSv436E0tTaJqlF0oNO+i/XmLBtDgKtQJ56Nn?=
 =?us-ascii?Q?njPM6rHYtN6z1PbHd8il9CqOvUJmaP0ix3X2gqd9wS1pDHIBm2Q4XkRmZx1h?=
 =?us-ascii?Q?9IZOFu5wOy0FJME439/XCAq+G/6czG5LYyF07WuSABv9wg/k0iwL3SB/x3/J?=
 =?us-ascii?Q?r5UMUeIJ/2QBvnkXPMonz+SJZIYxbdXqMVDYj/0J65OOXezTnSlBwYq7nEdM?=
 =?us-ascii?Q?XDEqUfF9TvwWJlkRl1D0OGuy1fmskqIHQ6VgpXwveEMWqLbS88uGqwFo7C6n?=
 =?us-ascii?Q?YMkXlU0TzE3plRDrRnULBHSjonrHK8h11zdSBvd9p5kHLjRnqClZU/OLU6v9?=
 =?us-ascii?Q?6oj2HoXWDk7Ix0OERbF9/11aE/EJzU2J3VY/KuwAo2aNck6+3vw2zOBroVOR?=
 =?us-ascii?Q?7tkg2iW8izk7ntPwNL1+sN6+CxX5KN8uypt3EoYEGhXncj5t4WsjdJPMceDG?=
 =?us-ascii?Q?Ildflt2RFd40U1TlHS3+PzxUfbtbKbV1ej7m5a1cFC0IX3A3/uR6BJ8B1VPy?=
 =?us-ascii?Q?J3Y8h5ZcWodv7EAa0AgFBroKQwCgZkRCduTs22VgfMG61f2PAliyYdiRY64k?=
 =?us-ascii?Q?RuAzJlwJkMO9Ku3OaI65rGO9kBR5edXpRQLmxtly8MUig++wzXpTOPO98RnG?=
 =?us-ascii?Q?08jFH3L8Vl+S50QjebWzf0OZxYguo2Kc1PEaYtopc3o6q3Bz6kqn5Fvthnxw?=
 =?us-ascii?Q?l39I3cftzUOTzfuN/UxU3vBoS4zb5MyjGm6U7dnXFdwDOLQbfx401fXgJjEb?=
 =?us-ascii?Q?NWIyvbP2xYkVv8XrHtrqeSdB3fh31o50EsR2cvNiXWiy5z4OEGc5ZmBaftau?=
 =?us-ascii?Q?grT1li7MTkHrTzsXneExBH5wKpPM7wJzPYn9+jb8KFQWnrPKXqwM9dhl1kWc?=
 =?us-ascii?Q?VEXXPzN1d9PPXmLyBNQ0PiLe6bCSElAvJ0rxV0nwFgJ+8WSaiBsRASRgskR3?=
 =?us-ascii?Q?oxtykQioHX+WBS+0exhc9DsszZkXSjYCROQVmchUt4oDM2UN9awwSAt9+IHs?=
 =?us-ascii?Q?cshyT1r3qFCv5YwOUlsCqfq+e7C4qU0qpJMzdyxK1zMyPZ6eF2je1geCFnjY?=
 =?us-ascii?Q?tKpava8hxedjwKD7Gy6eOO9ViAX6GeL4H5iCqeMOu5uN9wBI3exLdm44uKk2?=
 =?us-ascii?Q?ieSuBJhEdWvlg16tbdKXvjyuxR6HcsYC/RVqpQN92OJCoyiRCBPE0k0mtXUq?=
 =?us-ascii?Q?PA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e686e5e-f7a4-4e65-0b22-08dbea781539
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:56:07.8881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wv/SLyf4ypB96PtHyUJ2qGK5gtP7a+Q1qYcY//R3kTZxQl5j31sXyxPOU++NZU7mx6xgArqwJq00fim5b9WMRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9667

This patch adds a new helper mptcp_userspace_pm_get_entry() to find out
the address entry on the userspace_pm_local_addr_list through the given
address. Use this helper in mptcp_userspace_pm_delete_local_addr().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 44 ++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 06fe6c65b4f9..8c7553d7ee65 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -40,6 +40,20 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 	return NULL;
 }
 
+static struct mptcp_pm_addr_entry *mptcp_userspace_pm_get_entry(struct mptcp_sock *msk,
+								struct mptcp_addr_info *addr,
+								bool use_port, bool use_id)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, addr, use_port, use_id))
+			return entry;
+	}
+
+	return NULL;
+}
+
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    struct mptcp_pm_addr_entry *entry,
 						    bool set_id)
@@ -102,18 +116,17 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 						struct mptcp_pm_addr_entry *addr)
 {
-	struct mptcp_pm_addr_entry *entry, *tmp;
+	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false, false)) {
-			/* TODO: a refcount is needed because the entry can
-			 * be used multiple times (e.g. fullmesh mode).
-			 */
-			list_del_rcu(&entry->list);
-			kfree(entry);
-			msk->pm.local_addr_used--;
-			return 0;
-		}
+	entry = mptcp_userspace_pm_get_entry(msk, &addr->addr, false, false);
+	if (entry) {
+		/* TODO: a refcount is needed because the entry can
+		 * be used multiple times (e.g. fullmesh mode).
+		 */
+		list_del_rcu(&entry->list);
+		kfree(entry);
+		msk->pm.local_addr_used--;
+		return 0;
 	}
 
 	return -EINVAL;
@@ -139,17 +152,12 @@ int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 				    struct mptcp_addr_info *skc)
 {
-	struct mptcp_pm_addr_entry *entry = NULL, *e, new_entry;
+	struct mptcp_pm_addr_entry *entry, new_entry;
 	__be16 msk_sport =  ((struct inet_sock *)
 			     inet_sk((struct sock *)msk))->inet_sport;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&e->addr, skc, false, false)) {
-			entry = e;
-			break;
-		}
-	}
+	entry = mptcp_userspace_pm_get_entry(msk, skc, false, false);
 	spin_unlock_bh(&msk->pm.lock);
 	if (entry)
 		return entry->addr.id;
-- 
2.35.3

