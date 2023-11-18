Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2063.outbound.protection.outlook.com [40.107.249.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B1D18E33
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fx+j2ljO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJctVxya4IZAa+4jNqgIoBTG9jNoHiuZGYnwW+U5jPHLewwc1tvWV00r6hjTYuMWMMn27XYvFULP5kQJ2poplR7lBiC2OUYdueQ0sij1LPBc9FnaBBkqz9SAC58nai9U1/A8TyQ/3kiKGToTj33mupW+PeisiqiU5mHeMD6VjwZz512HafMHnoSs9q/pCpi2/Q8OBK/s+3uNUXe/mM5c7fAcpWCLi8pU9kvmWgnard0Yk1V3Yk7+P7zyBhi6LeHuCKxJs1CA7DXz7YYxO7c5L8QAA9//TEtGbVXGYm8SOSNmxUywsYFemI//JihcEYHoUaT5iNjiMtv7WpO5Bub3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sv6SbZfaNpoauTaauA4Q4ikrqXjzoN6RyN0lTmIDWjk=;
 b=VOR3TmD0z2V8ODXBzYzPDKZABA0Kc9XK/Wu9EgUp2mIU10MoP1P49+c6Bl/qQsyz2jQmNt1wwZXVlAiELY6Sl5BCWQiTjEz74HBP8eyfRZ5EX/DPtkuHTwf4rD8YD9xFINV8jqnRZBYVfMRJ2BEL0+uO8KDCp6BkbRG2CcR+DDtN2Z1PWxIA3v4ZCQXYscQoyIBYSxT923duIzCTnQSDZsizpMKDLrz2wkmhIVVCWFcFhZCYe61YY9T7z5XH5qcvojWzIOWoq3mWwrtP9WGCSrLPa3d8ytbgIYjbLSvr5jzYZ5Liva7aOkKI5yQewkLsKYMt2fYIFcTa6TUYJ+KMdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sv6SbZfaNpoauTaauA4Q4ikrqXjzoN6RyN0lTmIDWjk=;
 b=fx+j2ljOOOXFZ0aoS1r/TyV/3hZ3kd7WZieLkNam7sWD4VgybnnFGn4enFpWxKB8ByI3G4Y2B2sVMx/Y0J3riMuYIBm4iceLlUOXrMkD8G8XXhLH9+ABtzsyDdvexoWauYD9Mztlfnl67d7MmrQPRI74kG+kt7lR7Tm1NK4Pk/ekjUQDZb43r1oZMvIpMMyABFoR0WWpumyakW2ndm+3mKqMC3PlXFEUxZCPWXhok8vU+jM3QjMYkOcvqe0o5jkJ4WIVi/HNIUCLSRpQtr/MaIbygSeoAceh0CHqcs2l4TIZwO+siz43DKHlrgFxDrKdL/mZt4655ypC0QrjzhPTDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13; Sat, 18 Nov
 2023 14:30:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Sat, 18 Nov 2023
 14:30:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 13/27] mptcp: use set_id flag when appending addr
Date: Sat, 18 Nov 2023 22:28:28 +0800
Message-Id: <ad87a8b0475d448a463571a92e607b18ec0c8b64.1700312872.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700312872.git.geliang.tang@suse.com>
References: <cover.1700312872.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0045.apcprd06.prod.outlook.com
 (2603:1096:404:2e::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d07cf36-7b8e-4908-11ec-08dbe842ee69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/uCBC2XLHB5Ga6f7SqRDT/EkUlIHvXBwIfP7LPr5UtfGnFzkNAyh7vvPHsjMFO0Jb3Vkt+t6ATplpxohcp9AUrhr72zjypJJ/5Dpw7d186kNi2Mr1b6U5nt/SPSYH/RvTZSP8YuKtzLB0jtQjZqq9/Cw9yKRSfu4lg0S+T+ve6+An3TsteblUU0UHTrWWvBQNemd+aOfMtn+5qtdLmp3D6kExTQPjxAif55/+jy+zv0RDJWrBENX8tbcfa6EO0DPSsQH3HRB/YFrfFKboq6Q8rlt0X1V72bwe6uPaoTsbuxyxw5BRiUS12dgiaYAUIGlob2j/pi1gwxX+qN5DABBkWMc9xe4HAa9iu4SroNMqBevtCMBOgWN6QWbZDss/cKVmib3B8MpQIHNmwL9masWPLQJ8vA/foPUgtcwNEakD8uorvfqeweLwhRoHFp/19dXBaXwX6iCVYsjA/iNAyP4Pvmdfr2eYQNx2I36sOfFDR4OKSwXnGUYXpqQIqyRBnTw+TrrFt/WjBVyjGUWDR6ujmh/wAyPHh8U27ftpQEjENm9rj6t6YYFtXCFaZ+isgaIth3ADF2k482BTYzNy/sbzd6ITfBnFIlVOG3KPEtmgu0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(316002)(4326008)(8676002)(8936002)(66556008)(44832011)(66476007)(66946007)(6916009)(5660300002)(6486002)(478600001)(83380400001)(86362001)(2906002)(6506007)(41300700001)(26005)(107886003)(2616005)(6512007)(36756003)(38100700002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7WeAjI4uc+z5PZRNkJjhHb4j9lZfSnqNB5uCnN8M7K8ZzwHbCLgcULIQX38e?=
 =?us-ascii?Q?76BhUg+nBGauI1jpjbSEfxMIuDz6GLW6eoEZnkjNUBwLk35S1gZLBHLpdlkg?=
 =?us-ascii?Q?nWAuzzYM8hBjyopfqKuva5KjajxUzA4/8tAD47Ct7ACEapouMFjuQNPe9kyw?=
 =?us-ascii?Q?XXDGGpExdS8trRvaVt7ZIQpJIJFEmOs+NRBlZ6QOE6mjSYuJvdf/lWZ/tq8X?=
 =?us-ascii?Q?mP9ak0ApkgWNorgl8ZDjuS+PWxxUC9aEpEEBSFp18Vu7dgTAbBOWnkIxpRNB?=
 =?us-ascii?Q?14APx5VCeYkA14MOZNV90f/re6t2u49mDD/i0jXIrF2NK8YwOz3mIRWk3ARE?=
 =?us-ascii?Q?Ag2AW4pVl5nfUzVdnGZRdh8JBGKejb1g5UH9XRxO3DEyHpEhQ7DfzSx80o4+?=
 =?us-ascii?Q?XFR16pB87SIq0faw7TnLpu94s83bsA2nAqMLzSbBVxE1EnjIJ2U+pYB6IH07?=
 =?us-ascii?Q?b3Jw6vdIEbUvcKKta3LqTScyNJ5JFcsZXGeoOtT/fLf0cihTt7tQ5KvFLcK4?=
 =?us-ascii?Q?HMyOlQpIjpzGmshsZKf7r+4W4IIkylo/qA3ub17efWii7iRuuVaqQBOrYs6w?=
 =?us-ascii?Q?OPeypohu0r3byX1fjxyV8SB8WFgJm/2SSbrh5ismv7W+JUy20rmSNKXgZiVA?=
 =?us-ascii?Q?4jMtrlOqI60refix78eKWb8+nvGk6KN/5nsPeu1MXzsYiaee0zm4uo8/NH/q?=
 =?us-ascii?Q?efY4RoItdr+Ap6yxZp8DzauDEoxOPgNzNhRBwzjILJQtOsmW4S29swuzsV3i?=
 =?us-ascii?Q?YSVG6RFtEHfAGxyoFjY4QkE+vUkaUIfqsqun+rLi6CWkxE1nujw4sgGj0ohw?=
 =?us-ascii?Q?0iIP7eD/X3yny1FgyHwZwG/5bG/CzvePZBWL5QokIJgknWfbuIerqtm0Xuit?=
 =?us-ascii?Q?vUu3EfxDqmzTeWiS1ySbwro0sCHiu7CW+shz2BpGgvqrHt3Dn1nri97jDSjN?=
 =?us-ascii?Q?6kxfq0CfTOtTXaHVVpA0+WZl6+xAukSdzBzAe3SrgcMpacURQ2AyOIsGVU1W?=
 =?us-ascii?Q?kg/fjoyTVpUbDVLdWtZLachlguhRHjz9tGdaEg/fpXWHdeDVDDJbextDZi4M?=
 =?us-ascii?Q?/xzr8fzHwM+nMYGkU8Bwt94CbwD/XvunNXyJGDdM6gEcBWjDROKbTheL9vby?=
 =?us-ascii?Q?6E0hEAwuJ7O6PyVdc21+QmrqmBUaN/ogpmJQ0ZmjkEZFRGWHFNKDwJUy7pm9?=
 =?us-ascii?Q?9DyHzPJMyvrwpemc0PS0XrRr9e/xnHMg46oheakYZTyhUgDJCnVfGRlVbWmo?=
 =?us-ascii?Q?XAisFFjOtK1zGoudM4gzv4tPMmbVC6+qrJRTJh0E2hGrxIGp2GCnBuE6WaBG?=
 =?us-ascii?Q?dDwrTTbrwv4UIQ9in5NyZ8XGWM79PhqIW4vqTgmkKCBic2Xe6TkYiFk9Fhgs?=
 =?us-ascii?Q?gfAK4oGOsYavIU065wPO5IvePXAyzFWV9IQQvG7CM67ZEgz+/goKgGpTNody?=
 =?us-ascii?Q?QiXcAEyvrh7weSLqBMSAK4suKLFbpbgfYmqic7BQ8Pddn7OJMeV2e5i6cdum?=
 =?us-ascii?Q?8WgnLyFQwZLa6vnL0aRQS2JvnjOz2t2IWagzLYYso3GMtjm/1vSOrH0gaN+X?=
 =?us-ascii?Q?V58E4VdloJTkOgN/Lo3mHqaC8+HrwGjKKH8wuCCqGpGO1j53lIhB9yXh51+c?=
 =?us-ascii?Q?0A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d07cf36-7b8e-4908-11ec-08dbe842ee69
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 14:30:37.2575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYNyKG6Flz3Nr3G8CvZqFdfsK/JfUcvALSn2gYDPBv4y1WH20Lni/FHZcIbcvYoieh5mYzXWi77/XOeIPqoGqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869

This patch uses 'set_id' flag when appending new addr, adds a new parameter
'set_id' for mptcp_pm_nl_append_new_local_addr() in pm_netlink and
mptcp_userspace_pm_append_new_local_addr() in pm_userspace. Pass the flag
'set_id', which was set when parsing the address, into these append new
local address functions. If this flag is set, do not alloc new address ID
from id_bitmap, just keep the userspace set address ID.

Fixes: e5ed101a6028 ("mptcp: userspace pm allow creating id 0 subflow")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   | 11 ++++++-----
 net/mptcp/pm_userspace.c | 13 +++++++------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4db37baf74ed..cc4ac206f848 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -855,7 +855,8 @@ static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
 }
 
 static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
-					     struct mptcp_pm_addr_entry *entry)
+					     struct mptcp_pm_addr_entry *entry,
+					     bool set_id)
 {
 	struct mptcp_pm_addr_entry *cur, *del_entry = NULL;
 	unsigned int addr_max;
@@ -903,7 +904,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		}
 	}
 
-	if (!entry->addr.id) {
+	if (!entry->addr.id && !set_id) {
 find_next:
 		entry->addr.id = find_next_zero_bit(pernet->id_bitmap,
 						    MPTCP_PM_MAX_ADDR_ID + 1,
@@ -914,7 +915,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		}
 	}
 
-	if (!entry->addr.id)
+	if (!entry->addr.id && !set_id)
 		goto out;
 
 	__set_bit(entry->addr.id, pernet->id_bitmap);
@@ -1041,7 +1042,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	entry->ifindex = 0;
 	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 	entry->lsk = NULL;
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, false);
 	if (ret < 0)
 		kfree(entry);
 
@@ -1281,7 +1282,7 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 			goto out_free;
 		}
 	}
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, set_id);
 	if (ret < 0) {
 		GENL_SET_ERR_MSG_FMT(info, "too many addresses or duplicate one: %d", ret);
 		goto out_free;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 3d4258d2e269..c9dc25fa8540 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -38,7 +38,8 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 }
 
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
-						    struct mptcp_pm_addr_entry *entry)
+						    struct mptcp_pm_addr_entry *entry,
+						    bool set_id)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_pm_addr_entry *match = NULL;
@@ -51,7 +52,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
 		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
-		if (addr_match && entry->addr.id == 0)
+		if (addr_match && entry->addr.id == 0 && !set_id)
 			entry->addr.id = e->addr.id;
 		id_match = (e->addr.id == entry->addr.id);
 		if (addr_match && id_match) {
@@ -73,7 +74,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		}
 
 		*e = *entry;
-		if (!e->addr.id)
+		if (!e->addr.id && !set_id)
 			e->addr.id = find_next_zero_bit(pernet->id_bitmap,
 							MPTCP_PM_MAX_ADDR_ID + 1,
 							1);
@@ -147,7 +148,7 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 	if (new_entry.addr.port == msk_sport)
 		new_entry.addr.port = 0;
 
-	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry);
+	return mptcp_userspace_pm_append_new_local_addr(msk, &new_entry, false);
 }
 
 int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
@@ -193,7 +194,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 		goto announce_err;
 	}
 
-	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val);
+	err = mptcp_userspace_pm_append_new_local_addr(msk, &addr_val, set_id);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
 		goto announce_err;
@@ -374,7 +375,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	err = mptcp_userspace_pm_append_new_local_addr(msk, &local);
+	err = mptcp_userspace_pm_append_new_local_addr(msk, &local, set_id);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
 		goto create_err;
-- 
2.35.3

