Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12304F8B4
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TFlSwx1R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPT/ZrrBpJPM5g6LUwPcGvtvcQTwAKml/3KVSHhO+nSkffwysvUXcr3hmBtsD+1ZcB13+z0T++h3hzVmNgYeLMTiYUIB6hT/qRjeQGO0ptuvwyiwot/I+dAVqvNw/YAeejieclX4X6Znnyw3NnSM4/Ri6UXWdfwfzBGNGNG/9l1+uxb2767nRG+FBTWFMELyI3PfAtS7a5uFIxje8FSVCvQbJK36vM/H/m/vK7B6IVGGXk7Vj4ZxAzMjR/Z057YeqUXnVwp//ZWqfSqFfm/9eXGqjrp8gL1MAIgrnTvHuZAvCHgL8/6tcxyQtoZX7wbHpIZYr1/6Z3KX/98QTvmqtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8fBOvxUcdB6/Qw4FOyGEcT2F+mSte+m/WYOXoZKPpA=;
 b=JbBJSTlN7I0gtOBfLmKnbRtOIKu0R23/9gUFz2v04bgMaFz/ulfWcO6CCGG96th3Tlt2b6oHW7ZJB7l5xItaYucREv5RNLblkKnpgZD06pq0oxQx72ztSVlbyLzUpCrq6tzElLfx4fk6JGYJ5onr/jgq0jdTNV8B2yOHsHRipLXwU7ZXNJ8ZwfO1EUTOULTbViyp/YRqcFG2HZUEwWzOWXBxVMj6SvX3brQa3gxoAh2NJI9ptV+dOGIllpqrQWMJw/AQAVxN3Nii+80grNxSyxOs5hK92gg/r+yVlzmrPYFsDHk9QZ6se9YO/axYq4Q5mb1/g5H5i5ekW/P0TndXvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8fBOvxUcdB6/Qw4FOyGEcT2F+mSte+m/WYOXoZKPpA=;
 b=TFlSwx1RvY7favtSp4rFAn5naRoZaw0KKLnA4Wlj99vdAeAZBMVqaVCdjEw22bVqt6k5hILTPQFdno9BbuvTQeQj32eMzYIXKUxNl/mvrNSj7E/40BhBtoxe3KXblnRwhSuoLgLAaXtJnjH0EbIbVAkFND+HwLYellC1VjaN7e8vQp8QUxUXp64Kwto9wAWlY9VfBy6Pxha3pBabBR2emAPELAEfTK1jUQ9jEd7WV58uHL15dyMf40OibGzX8+mPqt5KzCGSH29+6ZAXtmWIOdHrkrxsxzFCVEKRQKHPpq2rlAOvGfPx+SZ4uc1mBB9uQPu/XPGcBBQSmm5S5wOBoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9104.eurprd04.prod.outlook.com (2603:10a6:150:23::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13; Sat, 18 Nov
 2023 14:31:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Sat, 18 Nov 2023
 14:31:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 23/27] mptcp: add userspace_pm_get_entry helper
Date: Sat, 18 Nov 2023 22:28:38 +0800
Message-Id: <20d2d311aabb3c47723d2669b842b1a2817ee060.1700312872.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700312872.git.geliang.tang@suse.com>
References: <cover.1700312872.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0194.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b8bcc5-da95-42b3-08ac-08dbe8431996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uY6j073Jhs+eaMGvgXHYH8TAEfnGQTqrf1woe96vXGIki0S02RCTv7x2oIgJ9KaOA3ICh5WxTFRk16Hs98aQMPSiyL8DDfgD/TYzpw1/WSSJ/Yh/CguxLLdPxjbnlD9YyhsFhSdpJeUzkESFF8PqZje12EQSiCcmZzqZcfmyxsaJ053hMT9f6Th80BjHGKU7k/89xD30o23tVvN++ICKpW7pl0aNeL1OrIrkRTxfQcJa1MfDwuVmD5ntcZGKs5og2PsVSqgXlFa6/C9k8XXWHkYQzfwz8WxFZ3WR5Ny7vCiQYLaRQaesmqpVduRJ0g5Cvv0/ArQp76hPgQnez2A3mHhScX1zoB0jgUmEt9X5RZE/nO+NkcsXIHuE151TYW9bhI035JMfjzJdFNo9TVzPsFJ6EEbrfmx2QbPdiGSFnQsULRB8ZcoZVssVRkdMI9GXiZy/QG0nRDjphzaO8euSZ48RcMV9XzI/G0vmv4temmJuLtCJehuJeMHA0fyr0eSFljzcps9vC5oyhyteuGm49VogFzLOKGlc46JE0yKM/1FtOu3Wwfxzfsic+0IU8MQfITGXWA2FXCHMINQEuVJ3QSszsP34+zBE8fjaZ01MyAc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66946007)(6916009)(316002)(4326008)(66476007)(8936002)(8676002)(6666004)(478600001)(6486002)(41300700001)(36756003)(5660300002)(86362001)(44832011)(2906002)(38100700002)(2616005)(107886003)(26005)(6506007)(6512007)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ToZWS3ROYzyrvqFG877dof2qJs/IQJA/ivfaW6p0xqRFS4Qu2enHnQzT5UC5?=
 =?us-ascii?Q?RRZZG4nYPx4XAXtRrjkT+YzabGVBVxZMgbVUBdMIOP4bnjfNDsN/DjP1hBL0?=
 =?us-ascii?Q?egpoQVEjXZfnVYrvSrnDebY6nFSW/pAO0HXpKX3i8Slrdyn8tUFTxeIcgdC7?=
 =?us-ascii?Q?j5Jh0tE7i8KanzZ1d3MqrZCF8LhrUX5/BGqvTBlVkAgLAjW6BWotJxQGbc1Y?=
 =?us-ascii?Q?OqEb3s0VcwVKYN23PLtwgxKauNCaGrSANUwo9n+Bq7MR4B8Udi6PcCcDWqfp?=
 =?us-ascii?Q?/7jM+Hm0o7q+sST3juJyh2p12Kn+uzmXoSoEnSwXlfHEVGiKQESvt0XXr4cY?=
 =?us-ascii?Q?o3OvcY4BvnAj7hJsHhcAK53qvBITjgHkqo857GBEBLpY+FnudCPeVxHYW/8e?=
 =?us-ascii?Q?qbOYvcw//9WNc2CIMV4VmjunSYrNkZycBzUCL8j4omLAilX+i6ZIDPVTnQ6y?=
 =?us-ascii?Q?WMxbUU9sx1oVif0miPW1TvSm+ceKGEiW+Tjb6nTPbZXyDvD/+mSAn9OPW7ZQ?=
 =?us-ascii?Q?aqlZTtHzDwVBQnYHBJLN5EtGCbRHvGAWu/nVn9D7xglj4WukaICfJGLYfiaw?=
 =?us-ascii?Q?8TMtDNbjMvDFiiZ3I3tE4+J6scWFSs79Ccft/UwYU/DX47l93LmfV0NQKZTR?=
 =?us-ascii?Q?78HPsZja6DuxfoPUdlLRDffhyxa9TPdrakcb0tx/yV4CnWc8HPz4sr2nPhyB?=
 =?us-ascii?Q?mREgkzyBvb4CgZadaqei+e8p8gB+23wIfkbqgRxc/9UMvlkL0deIENilURKS?=
 =?us-ascii?Q?uGjd0fXS8ElzfogzXpWT4fDcIfxIRtbB36dmcwQ3VnMJ5RsEVLXc3ghqJ35b?=
 =?us-ascii?Q?n6zk5vjjJQ1/bpobd5QPiL4Dp5BROpeUO2byMxLtP5zLGZojMLq9jJLCzQ+E?=
 =?us-ascii?Q?MGh3H193SxIhO9L5fy8JjCgcoLYJkTEP6T57eT37wiSNlYj1fWIwWEs5pZDK?=
 =?us-ascii?Q?SJBwpaC85nQX6VGcnGDJlNF2sbii26bjqGYRd2M19q0dNpAc0TvrVYwMHStL?=
 =?us-ascii?Q?Al44nmN9OghjanFTPf3prm7I33sNjxd4unNrXXgDr+XShPlpwg4K068j3DwO?=
 =?us-ascii?Q?kD1M3sn79ojvoMl83Wizi10XoQAK9L/GpuNwljnDwGQNbWIMLTtz5+gSVEum?=
 =?us-ascii?Q?wcMfjtY4ADMA545dJ0rwMWmYSvPaDprixR/3yUF3qmIZhD+4v0wGZ3XlR+nN?=
 =?us-ascii?Q?gGPbbA4gJUDPQLZuic3exRvGaCqxZ5++lLGKM8YpVOcTjxADpAUsIIesnvF6?=
 =?us-ascii?Q?FE7fVZX3U+VYPOC009YVY40+ghM68JFj3YdrV8EgXt/kViJ31oexSYdcxAJp?=
 =?us-ascii?Q?WCRWy3hNP0i47YLkV8IUX3rExB3rr6YvgyevzhEyrjrzLwjjbaiBH9c41Brr?=
 =?us-ascii?Q?yaMLwGzzLWXMyyx1p4lr4cEeGPjDREXxLru1qBlcZBaIVmfiGGj3jiy86Qcx?=
 =?us-ascii?Q?qzL36QK9qkTRRsyBzEeG0ZN4uCzEDChoJk/hYcI/EbXDOXPhsAALGyHtUjrx?=
 =?us-ascii?Q?IEsp2aAqOBCq8kXaQq0MxVQhXrf1a9/RQi4IqpizkNj3yomGhvnlOLbRsUGm?=
 =?us-ascii?Q?m5tDpOPW04l/r/iHyuIWuNsfhlsChNn7ozIkkN9VrYkA/NGBObhmSh7ad347?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b8bcc5-da95-42b3-08ac-08dbe8431996
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 14:31:49.5993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bl+Jrphw73vPlUxTMNYXT5S0QV2XGvxlx1a7NTsEDRMBFf8pe7cYsC+UMgOxL74rXQaScxvJgKP1ZNBxrrXDUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9104

This patch adds a new helper mptcp_userspace_pm_get_entry() to find out
the address entry on the userspace_pm_local_addr_list through the given
address. Use this helper in mptcp_userspace_pm_delete_local_addr().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 44 ++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 9eb6c447f18f..255cb733c59b 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -39,6 +39,20 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
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
@@ -101,18 +115,17 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
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
@@ -138,17 +151,12 @@ int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
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

