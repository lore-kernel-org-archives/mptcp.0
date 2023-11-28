Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2082.outbound.protection.outlook.com [40.107.105.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195EA58ADF
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LZVkCgaK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPt/awfmux2UB9Sh3WGE4Hz7F8tH2XgLK5ZTn+Km+b0/ifBN5TRK1UGoU7AgfIXcULN2HemalwX4lxk7C2Bwd94bUYb3yTpWz9t/E6KLvh8hDqGvzkWj5hFsW/xgsw+pOVC81HMibGY0L+lRNJ4QAbdcd3OoOHz7JrLt/gJReV2DjdPYVHZ5b+omGDQ25rSaz/cwV4lsDeXTzttCH5rUBkQuqSc1rKPuiU/vGQHYFaAkSwIFK6uOh/pXjrMZp3yS+Wr54SAAxF0VaAKXRkDOLbAz9WwfODnHhApkuHwqMdoEnOKfjClscGQdyIv/Cmbun87dyc7eJX7H5Z+2+pnr8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNtg0ENlx6XyP55fGgvTpB7mqIxaNS8NhC8buwqnLKM=;
 b=itFdqRKTTr/GxIP6FrX8uYtl3tFOZK1l3mc2JxqFyDd1pMEMazyNtDbFoi6EvvqFWOqGMvhzpW9PBHsZXp2S2H9IEeDxkkxihLLuNKZFwUrblrOavQX4d8CpW487V59cNat4e9+DFKSymUANQGit8/ZtHZ69/pKazGj8BmcUNMpRZnYUnBKygYQwed27Z7TcaVmvTUpyhGyi4Iuc6w26eXHopUfBtNuXX3ZRRrfJIoDU4pnGug9hpO2m0DSf9Uuk4ix1czFx3ea2w7ZqkjCSVFZVsd8jKg2SllWJcLmnVgFqbJ40DfISQeEjz/U2tdk24pP1tM7gQf7YBRphggqBFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNtg0ENlx6XyP55fGgvTpB7mqIxaNS8NhC8buwqnLKM=;
 b=LZVkCgaKUjXVeD0rqMT1+kGgBYDCTB25BfApX17KFUmlxRstlELL2yXp/zDHgwlkZQ66UNqo0jmc9DL+0aQ/fVvkxpP12mPD+fs65BBFN625KeLYXkzut2wxwT7qffhMNDk/H0wKdcgb/CN2h+K4n/rkcxToe1KCyGgrAiTwD6xBYu4tPN3nk/DjMnJTAQXxbX77N5zdLlv23OLJ4iHyCvppSXA9O2ZJLSPeeRZipcDRq8ZKUP/nMotWKF1dQ7F+XEGvHMr5WTzNfOp/t0HzfS8Jihaj6yCQk0Kdyqkl15xuliH/lmShpVqx2l2GTOMDoz149MkJKtcl4KCuOjY6LQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAWPR04MB9837.eurprd04.prod.outlook.com (2603:10a6:102:385::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19; Tue, 28 Nov
 2023 14:24:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:24:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 26/32] mptcp: add userspace_pm_get_entry helper
Date: Tue, 28 Nov 2023 22:22:19 +0800
Message-Id: <6bf532642cc007e930690a15b66836cfd525a78e.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
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
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAWPR04MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d4daf8c-2553-462c-b220-08dbf01dcd0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PnmJArUqI2IroJ/Iey9DFbKrMX2HTOp0K9gHouRSfyObeuihIaLqTnmNc1/YtHYxQ3VG/Py4LdMNoh1xR0m3ms7HO8aS/SgGmeAdpg/ONTbvdDvNEVXfdMouPg/Tbsg7SA0uULdSP8MBLF8zGTR75cUwPK1BLYcctsiHIlv7jMOWF0N+kG4PfbPBosd4awMxAJEcDOOktI5kw2KyLfp/QylIX4lM8GVdHoIfSsduRxFJGmSfnWhwNYMGE+4+D4Juoqx40TRfA0Ei+aZo8IpN/HIJVEx86nQcDTL4xzHbE4wcf37BOgTaNQH6DfnPtch/cEi5cHc82yfUlpxRS4/YGKeFmz+ZO9me8ku6GsQDVbdCcN3/NYjXnTK0q5eJqtLfLvmsjcFpv3PvVGiAy8tJcPl1yfQ0sQlcH/Q/8rGsstq5KjjljDU7xXuGzrXwyWzk50RDuBDyGaZj3EZJoE5Cg+jrooAVZuFC7Ztvl/e6l5QuikcOuU4xM0L1wNfSlxiLCNLn6DQoEzWsZfHwWhAErkGT+PvcMvcfFxdZLPF69HblMYJgZt4ziNMBRuOH995M
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(44832011)(8676002)(5660300002)(4326008)(41300700001)(26005)(8936002)(2906002)(478600001)(6666004)(6506007)(6512007)(107886003)(2616005)(36756003)(83380400001)(86362001)(316002)(66946007)(6916009)(66556008)(6486002)(66476007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hQfcfmuuuI7S9OuUkfcsnqHnmTXI8Q3zU8EjpjiCoLBseqGgwCLRmQJ0IyJk?=
 =?us-ascii?Q?3pIYwcA1ik8SDcS+svvMojnaLJ+o7O2z+KgL4teaAM289otWT9pQiN1yQ7Ir?=
 =?us-ascii?Q?2HDLuFIsw+JnDmttwzs20ipJgBkMeRzf0pmrngTElOEjYTfXw4x2GRfu9LJ1?=
 =?us-ascii?Q?PUoBNiFlLQ9t2TFWZ6tN935wxnluVlAZy2Q7CyVrHiYzrMlEgirImsym5vZD?=
 =?us-ascii?Q?JwLrCKX/ZSUmR797f3s7m/+8kdbJDnzdr9QGCY06BjEAYQyUdvRwt6XHqeMR?=
 =?us-ascii?Q?XSUfGqCowtqqI4tysPBLsbEYunAuXcpiMvauEr7gRYbq8Ej0EfDrqiFPAZz9?=
 =?us-ascii?Q?fTTrqByhYLAxsvJ6CBLQqq77O1ohYec2KIenmbL9HY6Wf9yp9t2gKgotBQzc?=
 =?us-ascii?Q?wk1ZUU+ojLfUcqjs/+Q+YQH2mRqWhK/TZBpW2avOPQOtWCzluQGW1uhfJgxA?=
 =?us-ascii?Q?wZ7B/zK2IlfyFUrsDoieGaN19cCVq8B4BqN9NHJ2PorigTpKEVdA5oJ8A++h?=
 =?us-ascii?Q?0/hWtuYxCDOVyP0z7InHFKB8asSjw0Xz6GQeHUNYRfQXVBH89K3/mSnrF9ua?=
 =?us-ascii?Q?665uQ0W4ivWZ6zAjdvzST3KNdE7fyzen4h03QC0nuoSaOt1/yL3O9yeGmuMA?=
 =?us-ascii?Q?swsucALjwkulgMsGe/3XiugovEkvWgRYpsY+kvwLW+kqpNs77QAQVw6CGe99?=
 =?us-ascii?Q?zRk6gY74F9wWM4a1FfcsfuYWKv9eoW63oau9SoO6WiwCFik1rYRGsr1BRaxu?=
 =?us-ascii?Q?aFTLiIFSt8JhVREuOwwcAO7cuysNS1e+lZvpCQk2U5s5MBAF4gLEx1ZYRBzO?=
 =?us-ascii?Q?bw85BYyGvBqJEvU9wx+PzmOowPtHFmwyvySx+l9nJbFAr/9rP0hzQIseRKJb?=
 =?us-ascii?Q?ZawuaG1yyn0yQKKNrDWB0TOJFen5ZXbfqIRzwc+e8xpk9Qyimup2RBZNWYSk?=
 =?us-ascii?Q?lNsQ8LBoydhew08gRWRtJMxGjq3eBK9j6L/YN+dY2MwDGRZUjF3xPUHIrM58?=
 =?us-ascii?Q?6wrFdasowbYmYGx8Zq3ihNxOxQxBDSoF/yaI/Av6EcKSaTDoTojbGzCh9SYd?=
 =?us-ascii?Q?UNU2xBI0cALvFroProS3F3mN5jfFW/pJwNUBjg8csVd0JsVmiuMr55KBfpST?=
 =?us-ascii?Q?xR/ToOJ5QrcjRHFwpXL4R7QsD23BtVY/i4omSDb6iB4RTImf/MJ48mi8uG4Z?=
 =?us-ascii?Q?GsoVvmD7WlRNO1csoCSuIl07OyPa988B1jJnINydy0AeJS0lidkRDwqK0e9y?=
 =?us-ascii?Q?fag/tcIBT1f0npJh/Z2V8nSrrlE7TBJCvf86mU3ieHUJJ/hFrcM1GXv0uUGa?=
 =?us-ascii?Q?DSKRjM7Fo+sc/gAFUt1Nx3zrjfbQiEBWa14jWnBqp86hXUs+UGWvDA5AajOn?=
 =?us-ascii?Q?zmdjTZROeMj3XMN7qABt3rAbz/UfKaq7KK1JmLT7p5nCdqMrAkrgo+0/c0V1?=
 =?us-ascii?Q?NdQ+XKsg6KsyZVrh2vlW3/e6YktEDPmWLv49wDOOamfpISTJP4mTqWCIAfqr?=
 =?us-ascii?Q?3a79FkSsmuAa9nS2B9P8qwGky7FLw0hS02pEIfLUeie5fVycbGo0pJwda8eB?=
 =?us-ascii?Q?JccvdXBIjBPNCgetVxndheRepiwDWdL5FkwfWw+o?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4daf8c-2553-462c-b220-08dbf01dcd0e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:24:59.0862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wVFB6OOW0tSve91FRLacG1VOR0xd8qS0YBuz1HUeuwnKYQFQTpd5XSTpqRPahkMlS9i7kOInRBjed6IL8DnRMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9837

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

