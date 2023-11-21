Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2053.outbound.protection.outlook.com [40.107.8.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB2F3BB49
	for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="2AMoBrTv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUluhowZH5fhQuvxY7yFz2CZvmxOoqtw7kmaFGvOEZU56CQ6q6GBicEsNQKJhWj2D4mwHLXuoMl31s2EThZbh1O811lZaYOn6+mim8ORWh9Z7LfkO9c4nOTDdn1tVGHjH9omw0yCSag2MiFaYvyP3HVMJhuKU39L/zm9BGK8D4hKY4oS7Ycu/ybHgsFuOlVV2yoCgkWSnaZtNStHm57yd4t3YNtpb9eFe69oqcbS5BE37ODb9YPcUBIxbDJMo76edrhqbn1Jfx1Ro+kMpR4BlcC/buEBTtOlL054eWNCuXRPNXWetEdKVsQPNpYdhRTCnczxG8YL0c34zuXCHKn9Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8cF9N0Tt7Wm0hCVdx2El5/WoarZD0AglWoxn39IpyU=;
 b=Z8N4KFYpimVOBD6QyHYwaLCM/pCYzFkJcScjus/Nxy2hgtmkhdYBJl29cvKRpM0SV8xPCEWq0EtpnFTeaYSzIzn3QDdnTdXAMkIjFJYWaGNj4Zhw2k6yrp7vsty1mXagGQd5yCL1jFq5c0xGS23nDMnwZIzyh1CFm53BVDbk/MmuFMsuhRFZY9keu6W/oTvx/ZxF1KgphBjnA5aVgatUzcVLTMbaOQYOkdNXZpaJT6Deq9Yw1HQ1pDvCh2YFRBoahjg94yVNcpfoR8BZc9qnqV/1ImqwuMGgWvTiJrST4naojpalRlPP+51mnx3kf/5yddHwCm+irX0Fe19K2yp89A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8cF9N0Tt7Wm0hCVdx2El5/WoarZD0AglWoxn39IpyU=;
 b=2AMoBrTvkk1nOX8SiR1MWNpUrb+LOPe0FQsRt5H4cWaA/hURoLO/an/J4KRlKszSTr2tVaXUVDEAI+dAzEGTHShJGVHoksthw3IaNtQSQnIEFhq/4tDv3TfRnLECYW+2JEDxBfP0usvf8ZdyxeuvdfBFq9/zvk5fH8x38Z1vDSL3NJCGIYHIsVFettPjQFqLqsDfN+UdDxps8n0vXCduTJtweedouSMstrv+l0Ld8kKEY0hyggDOzsTcH5vysxIUpN2tIZCX1VEFCGa5VVwyJiL+OpxK+1ZaOJQNy4xRqKSIzpbrLGFJCnVxS5BkevqTkj0RKIaBT4YNv2NSXUwdJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7750.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Tue, 21 Nov
 2023 09:54:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 09:54:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 12/28] mptcp: set set_id flag when parsing addr
Date: Tue, 21 Nov 2023 17:52:35 +0800
Message-Id: <55a43ff03cae9a70f9129ddeece8f83f1982d36f.1700560046.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700560046.git.geliang.tang@suse.com>
References: <cover.1700560046.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0124.apcprd02.prod.outlook.com
 (2603:1096:4:188::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: da0c85b5-5601-40b8-2381-08dbea77e441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9eA7oSL7iMQyeRwpS0fGLITqUur2A6jWhq7X0MjIDcER9aJz756bEEEJiLVdZ2LNhwGUv8RXIPPg/7qXNYfSaalja6k4XYYWGdcG2lZNr8C9RSXANdFUGsb55quql/VSkuSvY+eV2guJ+v4LVsmJzfhrVJin7MRjVQH38m6LOEw5EyJwPWESbGVxFwWqZqnVdU5Yt07BUJXIFnwoRC+n+DIeOe4PYGdhFQext1joeqG5SbKH+s0ocVz9ikmhpBZugToDJ4X0zCvuSfE1PTHTPlm1vWdYtyyjrClpngEbAmUhB99/iniM6INUp47Td/LOftke0VkZt2gciIJWiJuD2nEbiyE4adYmg+mIOR0rvFlQodwlCdM6Kw2XOVPYlWUe3G5QAvlxCJFSaqC9zJ8/g9g48cccs9f0L5s1vK/h0ChNHNbB7q4vX0adeayz6IdBbZMfzhPCuImkkXSr8jTCMKSUrMwPgW2MSx+Gf2dVIOG7nv/uq2xOZghVnJAmFO6BUW/p9OWV29HAVgC0qG7RlVboO08uX2csJpqAAi5dSrL/tEvFw2wVf1KmjMhHtkmU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66946007)(66476007)(66556008)(316002)(6916009)(6506007)(36756003)(6512007)(6666004)(2616005)(26005)(107886003)(6486002)(478600001)(38100700002)(83380400001)(86362001)(2906002)(44832011)(5660300002)(4326008)(8936002)(41300700001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fij3Jy+2sTTMCmML9I7iOzFx6kS5W9uDMa+mlK1z6YpSYxOVbPaPhpZgGlgq?=
 =?us-ascii?Q?696O+ycrh3gtqT9NYu4Gfrf9/sJTHHTL9UlRA+zCgW6ZvBQdPjHTZLfjYR26?=
 =?us-ascii?Q?DtMW7xmuJaQgx79ICz5BD9b8eIqdNAKHz5S0uvqVYIAAHiFUQkA2U4V6NbUQ?=
 =?us-ascii?Q?p86OZs3KmBsCWcHrov/t2kaDdMRuTVoTxWcHy+QqcUJQIEJ1MscIVV6o7V6r?=
 =?us-ascii?Q?UR0rLIjiWufsxJT9uCKJtJ+zLzlTbZn7HLL5IVgfrukjL7G7+/xh0nwu6AMD?=
 =?us-ascii?Q?hNwEkAbTIDFmkOYJyKCU/ks5WJcU1ktChhK2uSyudcXyC7wzT2NIPazPRVP6?=
 =?us-ascii?Q?xXR/BlUZPFALLNZ3bPD9fK4tc/SaXZAqmurOiBFu3YpaDHz4eQOA5pSGM0y5?=
 =?us-ascii?Q?nUnVXBBvOfNcSTGBVullucNPqKAfRBaj2rOaVEVFespvj9tj+c4kyHrKUf/+?=
 =?us-ascii?Q?iW2XhqMmAy5V4ReyNbIBSc3gO2Gn3jaT5PkvcbC/7oRpznDeFMfEEjLc0AuO?=
 =?us-ascii?Q?XDmBdCXTsng/ZW08zAU4y9rCrDGU4SBdMXBjvnLXgQt6Zvg2k/fvzeXTqgmU?=
 =?us-ascii?Q?hlCUyqVwGzyTxGAiVcw7Ob31cpq+cur1c5IAhHtqz9/veji6mx+RsvyFDeCy?=
 =?us-ascii?Q?F9Zl2Y6DtMPrgYcnT6nh/WtUuRKf5tVBNXjkfcKl/6p8TuU4rJ4pdJwakZRL?=
 =?us-ascii?Q?zO6HFqYmuZnM6hvF5VwGK+k3QxI4Ri7HbQRdIgdJsEThGEY+9f7/WyzfCk5a?=
 =?us-ascii?Q?6SfqP75Xb6Cw75CFCIsyiz7ot14uZ71K2d4LsUEoDN3kE3y47P5kqTEWeI/6?=
 =?us-ascii?Q?62fTLdTcTp4ePrDENpb0WUZSr2mDb1dD2A0mgLaRI7Rd4cU3zaArKsw0VSA1?=
 =?us-ascii?Q?JTNzg9IglTEfkI9IUPV+OWeq3llzu5x/bhKVCForyVDlESQra664TjuSlrKf?=
 =?us-ascii?Q?s2p6ELsC0lkOXV+o47oockQyfF2rP13E2sB8e8iDr1U3djHXnCBn4/uqYkca?=
 =?us-ascii?Q?jFZ/LvfzpDWMvXO45Xhi8Xm/xJCtKBqxywy7rgaLeTm7gfA+8fB7w+JhHk1n?=
 =?us-ascii?Q?zqXixhJDbHX70NG3RY96BAPk9kJ49I0zgiJqgI5z8XuouhKPrC9aDkadv6iX?=
 =?us-ascii?Q?ynLJXLH/h69EoR1+E6OLFEhjb+FOfJ/s8905Uj6TrrEpf5IzPzFCeTz1/FAN?=
 =?us-ascii?Q?ulen/3OL03i71n02VT/ei8O9uS9KMhp4DnYUkf4V1yz8oYeZybt6u1v5FGMA?=
 =?us-ascii?Q?cXrDGmHX4r17X1mkAyfzbT7Z1g7IJSRXOzbbUhazMbCDrmbqkb056kriQTqQ?=
 =?us-ascii?Q?4bPM95SWSmmDC4ZYdxL7gAGGod2/Zlov/XSdzZpaK1rb4a4CQ+g84iEI35aw?=
 =?us-ascii?Q?QUdnQFNmz+2A6ZF1Vl5nVMsaoHhUQrxF9D80QAmG4jyvlnUVcLKaEWkrx9uo?=
 =?us-ascii?Q?wn7tGJ8SIE8ySYxbwCDbIpd4RrigigXcJqyyu1R30xNyurxkB7L7qFlSH6pu?=
 =?us-ascii?Q?r0DXO077cKk+KHSZN1QLZmnTtpABKoNODl4FxaM9YobcUQPNEYTlmbAvOiiC?=
 =?us-ascii?Q?EkOC9ewYTlVMZmbp0LZLqZHZC2Kdkan35oL2KMpoS/FTDFL3/O6nXUBuBu0O?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0c85b5-5601-40b8-2381-08dbea77e441
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:54:45.8680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65DYwmf0Uh4x33peF8v4/nmhZEILYgdXSKzlFg58VwmmHB5yByblU3uShbtkUu55hLAxBH2ybd9AU3Z1YVzt7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7750

When userspace PM requires to create an ID 0 subflow in "userspace pm
create id 0 subflow" test like this:

        userspace_pm_add_sf $ns2 10.0.3.2 0

An Id 1 subflow, in fact, is created.

Since in mptcp_pm_nl_append_new_local_addr(), 'id 0' will be treated as
no ID is set by userspace, and will allocate a new ID immediately:

     if (!e->addr.id)
             e->addr.id = find_next_zero_bit(pernet->id_bitmap,
                                             MPTCP_PM_MAX_ADDR_ID + 1,
                                             1);

To solve this issue, a 'set_id' flag is needed to distinguish between
whether userspace has set an ID 0 or whether userspace has not set any
address.

This patch adds a new parameter 'set_id' for mptcp_pm_parse_entry() and
mptcp_pm_parse_pm_addr_attr(), and pass a 'set_id' flag to them. If an
address id is set from userspace, this flag will be set as true.

Fixes: e5ed101a6028 ("mptcp: userspace pm allow creating id 0 subflow")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   | 26 ++++++++++++++++----------
 net/mptcp/pm_userspace.c |  6 ++++--
 net/mptcp/protocol.h     |  3 ++-
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 08b4211fbcbd..4db37baf74ed 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1108,7 +1108,8 @@ static int mptcp_pm_parse_pm_addr_attr(struct nlattr *tb[],
 				       const struct nlattr *attr,
 				       struct genl_info *info,
 				       struct mptcp_addr_info *addr,
-				       bool require_family)
+				       bool require_family,
+				       bool *set_id)
 {
 	int err, addr_addr;
 
@@ -1123,8 +1124,11 @@ static int mptcp_pm_parse_pm_addr_attr(struct nlattr *tb[],
 	if (err)
 		return err;
 
-	if (tb[MPTCP_PM_ADDR_ATTR_ID])
+	if (tb[MPTCP_PM_ADDR_ATTR_ID]) {
 		addr->id = nla_get_u8(tb[MPTCP_PM_ADDR_ATTR_ID]);
+		if (set_id)
+			*set_id = true;
+	}
 
 	if (!tb[MPTCP_PM_ADDR_ATTR_FAMILY]) {
 		if (!require_family)
@@ -1172,19 +1176,20 @@ int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
 
 	memset(addr, 0, sizeof(*addr));
 
-	return mptcp_pm_parse_pm_addr_attr(tb, attr, info, addr, true);
+	return mptcp_pm_parse_pm_addr_attr(tb, attr, info, addr, true, NULL);
 }
 
 int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
 			 bool require_family,
-			 struct mptcp_pm_addr_entry *entry)
+			 struct mptcp_pm_addr_entry *entry,
+			 bool *set_id)
 {
 	struct nlattr *tb[MPTCP_PM_ADDR_ATTR_MAX + 1];
 	int err;
 
 	memset(entry, 0, sizeof(*entry));
 
-	err = mptcp_pm_parse_pm_addr_attr(tb, attr, info, &entry->addr, require_family);
+	err = mptcp_pm_parse_pm_addr_attr(tb, attr, info, &entry->addr, require_family, set_id);
 	if (err)
 		return err;
 
@@ -1239,9 +1244,10 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
 	struct pm_nl_pernet *pernet = genl_info_pm_nl(info);
 	struct mptcp_pm_addr_entry addr, *entry;
+	bool set_id = false;
 	int ret;
 
-	ret = mptcp_pm_parse_entry(attr, info, true, &addr);
+	ret = mptcp_pm_parse_entry(attr, info, true, &addr, &set_id);
 	if (ret < 0)
 		return ret;
 
@@ -1423,7 +1429,7 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	unsigned int addr_max;
 	int ret;
 
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
+	ret = mptcp_pm_parse_entry(attr, info, false, &addr, NULL);
 	if (ret < 0)
 		return ret;
 
@@ -1616,7 +1622,7 @@ int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	void *reply;
 	int ret;
 
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
+	ret = mptcp_pm_parse_entry(attr, info, false, &addr, NULL);
 	if (ret < 0)
 		return ret;
 
@@ -1866,12 +1872,12 @@ int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
 	u8 bkup = 0;
 	int ret;
 
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
+	ret = mptcp_pm_parse_entry(attr, info, false, &addr, NULL);
 	if (ret < 0)
 		return ret;
 
 	if (attr_rem) {
-		ret = mptcp_pm_parse_entry(attr_rem, info, false, &remote);
+		ret = mptcp_pm_parse_entry(attr_rem, info, false, &remote, NULL);
 		if (ret < 0)
 			return ret;
 	}
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index de10be21bf26..3d4258d2e269 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -156,6 +156,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *addr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry addr_val;
 	struct mptcp_sock *msk;
+	bool set_id = false;
 	int err = -EINVAL;
 	struct sock *sk;
 	u32 token_val;
@@ -180,7 +181,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 		goto announce_err;
 	}
 
-	err = mptcp_pm_parse_entry(addr, info, true, &addr_val);
+	err = mptcp_pm_parse_entry(addr, info, true, &addr_val, &set_id);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "error parsing local address");
 		goto announce_err;
@@ -323,6 +324,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	struct mptcp_addr_info addr_r;
 	struct mptcp_addr_info addr_l;
 	struct mptcp_sock *msk;
+	bool set_id = false;
 	int err = -EINVAL;
 	struct sock *sk;
 	u32 token_val;
@@ -347,7 +349,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	err = mptcp_pm_parse_entry(laddr, info, true, &local);
+	err = mptcp_pm_parse_entry(laddr, info, true, &local, &set_id);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
 		goto create_err;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c30e59278080..0460cb391ede 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -881,7 +881,8 @@ int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
 			struct mptcp_addr_info *addr);
 int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
 			 bool require_family,
-			 struct mptcp_pm_addr_entry *entry);
+			 struct mptcp_pm_addr_entry *entry,
+			 bool *set_id);
 bool mptcp_pm_addr_families_match(const struct sock *sk,
 				  const struct mptcp_addr_info *loc,
 				  const struct mptcp_addr_info *rem);
-- 
2.35.3

