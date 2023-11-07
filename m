Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41192595
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 08:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xvxac0F8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+ctGalqJc2LSI7OAf4YTrVjOwx0/EVL+drhbwc/TyEB6/6uqZWdQcRxjM1/G67/f3vLQBymxKyNUFwPK66CgjmUyu+viUnns9kau9ze5JYB/xKZg0qX9CTwPvn4JAfWIL8mYfjq+f24OJhLacSMkm0ayIdOK5NnjtNQMiOHIdLNf8uvEN06bg+N+aEQYmb036kmD+4aCxDvs997nfQOyajxPwe3FBgDj+YUBbgqI4+2TdVevrm25XQaVHlJHyoLpW+M8/9eyDXc9qHk9MdWFlDQ/xy2ILcaCgp2Wmh4G8sjklEkvvfXi9PtZpbJBWuV2C6ylm7KEYVoQ9uFD7HX4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwNDfN17K0LFAMDx3qp7Q1h4GjSywajxnLKO7TC/I1k=;
 b=jeV6iAAJfVAdbIDEs/qMIfY//5jKFI6rZW7+WOS37K9GsOqM1Ibn62agBjZd6hSeZnDUVtMgkWVe5Pgak/yF4zyXjKer0edDddad7JuI1rw5zIbhN5PnfZkCu7yxR65O4nTnh3cMIL5YzuZWUp2kSODcTRfWMXJlFgT1xe0nVLkEOBOXjPMbWUAbdDeR1mpFWO/EwtPSjwOBib3mpQCT+qxyu3ExpsBaCm2CojXBcY1Gj1N7lgzKqjNGLQ4x8pIH15BmKBMiSs1ziormWhf+5aA0ZP3j4qgvCNVmkkXfa/HIl2XNvf9YClkJxtBOHsMD8OfPxrUrZQwaJnaGVmgFDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwNDfN17K0LFAMDx3qp7Q1h4GjSywajxnLKO7TC/I1k=;
 b=Xvxac0F8ftEWpkqeCXnffRYaNcvfB8LElrPn/R9r4meWXvCKfLwTsYZpLmMYmoms075UGIF3CQhgtBIGZ5ceaE1BiCMLoq82aaRNIECH8v3Uo4fifUZCJQ6kgfTTYpjj69BxvdXPSwGVaTmhwQfVJjGfSgaAHV6AB3QIcTHKayr+NHrtWyCOalyI/U+QgavQNaB2WevlRGgD4XMS5KrssjZbCkO0h3AGSY5Fh8Ma1Tc6IVkbeRg5ykFq6jBz6UluCDZkLLpJR2/FHRZM/c9AYURuMJf4ECEPNUwIWtUmK4Hw2uFY0dDPBR7T2QyJz5QJNJjfjufiArH+l3nX4kLLXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7663.eurprd04.prod.outlook.com (2603:10a6:102:e9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Tue, 7 Nov
 2023 08:16:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 08:16:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 15/20] mptcp: add userspace_pm_get_entry helper
Date: Tue,  7 Nov 2023 16:14:21 +0800
Message-Id: <4b914e167aa771a5351f4c0143a5d6388265c76a.1699344621.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699344621.git.geliang.tang@suse.com>
References: <cover.1699344621.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0202.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 06479e43-15a4-4e0d-bbf9-08dbdf69cb0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	02DmcExuSHWy3ckOl/E3sp9OpYL3/jNZcHzMYP6hICuEzUXGyp5b2MpbEKqC+kOBqk5ZtySwdkPFf94uF2MFayGOIsJKTd8hUwbAF+B2hOOY88tmKs8/Sniz6pzlzbxVpmqxiaiik25I5AFNcIPn6uHFtUtlpKFYtSTzt/mPSEtZ+0FkLA6aHNEelIm56pRPFWMeKzbwOpkb6TZDTJjmcr93n8Vig6zU45U354xZLf4Ko2mC+jWDYMKER+eXjXwcEc7vpKsV6bsWBQMOYS/IjMZKhjHBJiqgbenvocOwkqFl323e1elN8Xlw7MDhpexBcy/GGnZD0hrhFf00x0YHoggryAws8Lmop8HaJ198z/udXkLNvLyrj4mNXx/BJnWuk2JP1AqCHWxydq1IlTT2IKNI2uJ+YYPRCPP3RiPK9gcUQyOOxeND9qrLt1M0XXIMJM4HbIhH/OqS3xzMb+QQJ+chj3r73nXH7G9Ffc5EucsJeQOQQ16mq4Ve4SamMQcQzZ9mYhnnnaV0PNS7SdRH4Id93gbutmM19IwpOtzbX846JvQ781+7neV3ePdQI4/b
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(2906002)(83380400001)(41300700001)(38100700002)(8936002)(478600001)(4326008)(6666004)(6486002)(86362001)(44832011)(8676002)(66556008)(66946007)(6916009)(316002)(66476007)(107886003)(2616005)(5660300002)(6506007)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lDGj8ttOnYC49M7hrRPeXkwh0NHDcbpDkICoSxfRCeFxQSvA552/XuuTIwnE?=
 =?us-ascii?Q?KRzmz1Xc9HbaVU0kcdMHCL3dnWyA64Mkn1EI/rQ19SY1Ny8pbAu6k4824dut?=
 =?us-ascii?Q?FEs/ThX4DPr6EmWkyngYfvoRa4zrFT4rpGXzE4muvaD2YYxDCL0Yb+6D15I0?=
 =?us-ascii?Q?86C/dh3YhXiTex+LrswZ/kIXrhJWc9eQJ9vEf+2HESFE7kHBSHgqA8RFAWt0?=
 =?us-ascii?Q?4D7r9P61oFmTiTt1BEsjbwlFTMXXPByERpqMEvQWFViPYvLcZJUEgscSksSf?=
 =?us-ascii?Q?GCUtCPQ05I+wWfs+Kqt5Ja13YyJ+kNFgUqacv+A+Z6KF4sG/Ix/HNWwhZdrZ?=
 =?us-ascii?Q?3JRGRrPbk4DMIMSVjL9jbJg9vNneFW0Qbg17d1dpOFOka7RdGIVgD1/NZjUs?=
 =?us-ascii?Q?Rk6yGVvU1PmtuSj49ui2o+IQfGiekIpfRGnra+ndQL61TYmtAhdBW9KVCMh/?=
 =?us-ascii?Q?1Q/FCYGw8AhQ6ve+SwRqqLFd4dW13b7IrSJKPD1FXsqNNmuPyXE1xlnaNAXc?=
 =?us-ascii?Q?bLJ8XqjftMzerAGxO2INUY8eedLsaZ5Fgv4FCZkxA5oE3v6aVlPwuqaSwT0C?=
 =?us-ascii?Q?fSuMixBJuyMd9sHQxKvW4Y4S8dR2Ik/jrNwZU3RqMDYx+AaiytlZ4N9GSUBZ?=
 =?us-ascii?Q?aCADBJRu9V75rgQMVBipWvpf4w2x8C1txw0ieLZcWNSGDgD4p45kNKzxp69y?=
 =?us-ascii?Q?Lfl6eFgmUW7wEpRcjteeUiJ0ezETTmJT9htBL5fyYh+z/++/t1AYxEogxzaz?=
 =?us-ascii?Q?APodlUSj4Do62q2sYYbispaVzL5sPWcgebiqVR63+hbQWcuDn1KPtNLaTHye?=
 =?us-ascii?Q?64p0R4QY4dnJUPZY5OEKeqiZwS3uQbQAE/+MepT0mUto/m2IsdNP6egMo0Cf?=
 =?us-ascii?Q?rhZdjA/jCW5TaXI8Z76VWT6QEdeptr0Kw2Uv3t8AiRbmzuhtM+eHl0p3gumf?=
 =?us-ascii?Q?Ip9M5lHa545aTREFLh1ooew4vZU75rrTGlZMIpHVf576vr/e9KSykrqnWa80?=
 =?us-ascii?Q?bcQjJ9MZS7/hme+Hfm9TRbxL+5E8hF6GjeHJOqOTTaSHfbJyEmrXr2j0DeEx?=
 =?us-ascii?Q?T98GS2cCo3rdmppD8/YGFGRVdtJxHkJ/bbFO93QUD/LotDgnERZE8IQQd3If?=
 =?us-ascii?Q?l6ekGi9FzHGSW0Hpcj3Sw8oRdIwbI+7yGBh4h/+k3e7TDxOvXyU0zN5osAQ+?=
 =?us-ascii?Q?vCw+ZiabOvwjW+EorQRX2gSCE/pGN35a2Qp5NMjw1BUnGzvJnqTP2xSCOIcp?=
 =?us-ascii?Q?8DMY3bxZNSkJNMNzrUb+KQBL6T04toDooVvSBbTksJLEIiwzovhhHiwhlXLe?=
 =?us-ascii?Q?w6UV6v14uOz/hXNzXjODSKwI9gq90av8GGKGe3r+8eyU24Vm6Yrq7ksNRM45?=
 =?us-ascii?Q?TsUzDBGmr+BXdVxbWI6jQl6cbDd7rXhWyKJzKOU98aJbl8deC8wosognBCfh?=
 =?us-ascii?Q?lMvyzZrU0UNyhCA8MP2GeJ46cgbYR9fycgsQYN+z0BRytPed7WIslEYV9BdI?=
 =?us-ascii?Q?487OpojoVfjOHoZHcuP/YQyYdObJwS92U5XnIdke55DPwnJm4n4a6/HF466q?=
 =?us-ascii?Q?3pYq51odRQ/ZoTzuRMCaKHWCInoAUtX1hO4TEXN7?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06479e43-15a4-4e0d-bbf9-08dbdf69cb0b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 08:16:07.6228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IYeFHatCZWO4y6L5i/lkhb7zumuOfKlbGMGzPI0g+0TXds9L+lD5nO+pjNpFBkUzt6wSuTe9REH4dZaGq3m0AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7663

This patch adds a new helper mptcp_userspace_pm_get_entry() to find out
the address entry on the userspace_pm_local_addr_list through the given
address. Use this helper in mptcp_userspace_pm_delete_local_addr() and
mptcp_nl_cmd_sf_destroy().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 08620b3ca8e6..465f2c208ac1 100644
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
 						    struct mptcp_pm_addr_entry *entry)
 {
@@ -100,18 +114,17 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
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
-- 
2.35.3

