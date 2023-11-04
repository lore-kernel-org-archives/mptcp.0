Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2089.outbound.protection.outlook.com [40.107.247.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FE015486
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BTxUhCDs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMSWRMWopNdF6B5dOpT0IbqfeL7MIna2DEjMBLipFIdnwOhlzE0Q7TzddveeV4G8PRDwAyOAP8mx/8BHFQhOviBmRO/eIz8nstgL1bxTzqtKBCaWTZmKMtYATZdFSDav1oQhNehJJHdFRc+2UefzBzN3Xg8KrolLpbG7VdB+OAUhfDmF7K/W3O9LWQl27RzZN0jz5tUOWQvExFFzHZBidKxy1KYzT7/BEysKIcD1UgfU/kSzlLCUyviK3+Rf/Se+62r8PRyXp2u21owt4f3m9Q6PnSnTt9DUM5qLobFRV5sBtvh75bXyFvp4CzKdmoGv/P7PwJyNh0YcOJrNfrgtpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqtianuffEHA00+Be/9xTjJg7EXapzp64bN/1qmj3dI=;
 b=R+iXIY8EAYAT3nnD4pCLoiMJDlTIXTYPcFJn/3/0AgBxI12EZuOUrvZ+zwoZr3zE8iLBbHaAUx/jJXCJvr2+yRdR+T4GNCUCPa4BGt0pMKZon1p64PJZTqbX6afV3YQ6eaQKBcCLPq3y8Fif90Qd1GRs4YseoiFguqFpzPpinLIgIQELrgLVGwPuC8x18X3zksP6yHjbW4TGL1T081YySbLSoTvcVTD8DYj6gWgnXEek4D3nLfcSKQjD5KDW5Xgy0eNdnVpCNuXxY76tAtS1zYeIC9IFprmS7qKcF6lKyNpPNp7E0pMndpY5ZUNQwVCxcLv/Zu1G+amMSwAdQ+1Tgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqtianuffEHA00+Be/9xTjJg7EXapzp64bN/1qmj3dI=;
 b=BTxUhCDsZgqXsL5GoA8Mwa/K5823P78qp12a+NNJhi36B+Q6RqPMY/OIIhqqfbs0argV5yJvrd3u1uUYW6NGpbY4AdusDzN2GS0WqIZrNqY7G9kAAQ9g46CtFAg0j7tENoR9+xX5rV3SvBkNUJHJjhF8lo8tKTV7bppnN9/hnuhbKZy/Vinqlm0YD4/64IP1XxX+qGRSUhcYMrQyL4RL3idDKpIe/umzzcILhFAExSOZeYy1GhIilXQd+mo7AjdJtsKa3NesS+upPRF/tZC6CUz9MZtsce2ftPIO55a5cO1tX6K76A/yTr9NhgDF7SWG7r2HguZBDYyrDl4auBg0AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6820.eurprd04.prod.outlook.com (2603:10a6:208:188::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Sat, 4 Nov
 2023 14:17:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 14:17:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 05/12] mptcp: lookup_addr_by_id helper in userspace pm
Date: Sat,  4 Nov 2023 22:16:19 +0800
Message-Id: <2f8f85fc067ba04d5c97781b942722e69318b0ae.1699107275.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699107275.git.geliang.tang@suse.com>
References: <cover.1699107275.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: bd05a385-b31b-4de7-9fd2-08dbdd40b9e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RSKnC2EFDr06UnevMNYQPtonFVk08YYBEUS9tZEIRKcfcnDrL6a+ON3Sg4o8aSEaEMpIQvfTR6ZtL8BzOijVVYOxrtnVwNhLSC4ljKdxKgNBWN0Z3LL0HOquci7T0J5HzHZAbZZwS4WrIEV8Q8b/aOzsuspv5Igvs9RdNAGpqLdFxD6KcXxP02611LpFArhKYoXT3fhVfEcOuE7XdcEfuNJNC5jX8JFl5VbE0L5hS6d81SyF1TfRKyiuq+caeYO4uvFNjrIUovjSynQi1MzRrYlQejlNhvJWKKPDAAgepmTVNcqCmddmSuT1qk/sJTJckkXSo1Je9ugrmqkK8VqB0AFUFLfcfJbQD3ddR8se+0y/tkfriG8FDaKKzOW6uv39LxO9bsuSaWLjF+GOK61CO+jdj+QZSh/ACzFfSFpsmEE5THVoBuHnWnNDfh/0mWYWsG70wLyEQiBN82F0m1Atg7CI8h2QYE4V3Qn5gDfSNWkQ2c5Cj3LpnluGY5nw6dlK9JdwOCr/xCzx4peHhpOkkCLTnA6adZMn3pinLAA69lrTxWpgmFgfvXfF7zLrIMirzM5FxGjz+XjfrtqteF0UKi2Ij0BGq7JV3fsvsta5UvY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(83380400001)(5660300002)(2906002)(6512007)(26005)(38100700002)(2616005)(36756003)(86362001)(41300700001)(6506007)(8936002)(107886003)(6666004)(66476007)(478600001)(4326008)(66556008)(8676002)(6486002)(316002)(6916009)(66946007)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JBdU1Khy/FcCI9he4Yxyovq4Xu4fG5NW4l/odhrtQNVL0RO5eVYnH9vruBE5?=
 =?us-ascii?Q?wM4qDwKa8QJ6TicqQxBYkXi164YIZxxtvERq+BqXYgOzTBRZTFXrzS8A8VAH?=
 =?us-ascii?Q?dKtSgQb1KeDMLOerEzhw+lpmh03YoDM8KHKTcYk/X0awfIJdeg+DzY4cYNZ5?=
 =?us-ascii?Q?iXflbNmBaCRb/taM/uNiWumDyz5q/Pt4VP0VfCJ3gc9lGs0ULyGH1YRzzHSc?=
 =?us-ascii?Q?tMp8csVOfVuYFQqT+ugkf15Te8MnTXihP6fzDJFXQw2EyBizDTNI0UB1l8lF?=
 =?us-ascii?Q?gKTFw0C9owOxNRoUVSP2gjaCCFIH0VLAuIinC3ZaZXrmZ8CqQPGlZsY5WQ57?=
 =?us-ascii?Q?v8cX/Uv5NGQwHRw2ZSDv9iRj2WC6Xh6SwOYDrdGJGJKfjR3eiYFY7w4tWFxP?=
 =?us-ascii?Q?AwaBRu8xvepp5G1/498w6WPe/6Adb2c8ZrkY0YVCDuYpKKZLMI42tRA86R/i?=
 =?us-ascii?Q?i1iG2EDGfIBU5xLAus0A8LbsOL1TmZGV/aXDHo+xq4TNxWAfgaz+pKAB0nFr?=
 =?us-ascii?Q?OLylSel8++mNHiobBVIB1esIlZ28dQ6FMSOg6eM8udAXAvjf2sX4V58Ae2Cc?=
 =?us-ascii?Q?+x4ekppWrR+bVQ6efqmdP+S+n21uwninei5Grc9cpkfSPhH5fhIl49CWWJae?=
 =?us-ascii?Q?hlTPr20GIzV13xPoNUOG55sAsBB7815HMsNS5fCfm/4HBIsHLuq63mEHdObI?=
 =?us-ascii?Q?phU1G2by/ijBKZP1DoKTjE8Gv/wei/IJRcE1JoF9BF6jV9TBZVd4XHlm48tp?=
 =?us-ascii?Q?/qLY/r2EQxeigTz7/cOU2BWyFm+sAsXssLCpYU6uSdwS8k/Xt244DVHObtnW?=
 =?us-ascii?Q?F5/XHtZx6eFHlXILZ7SG2VfVhKc/6pyOFGViXpXLGMqXoepK4k+69RntaVZX?=
 =?us-ascii?Q?cWjkH8rmu8pfZ5CRAywrrw7B7oC97KFshqbqbZOaluPDSGwtCoSFA4EVSpm1?=
 =?us-ascii?Q?O2ANSIMcf5IaQ26uehLcUqVPKUkv1rUso8X10jCSrtDNox0DfKmtRmoW5Gjt?=
 =?us-ascii?Q?fJ8Ds3+P6f6nHuAONb6ExOnKVe8h9Pch5J9RS/JuZhE4tJaSeJXY5KcnfeRn?=
 =?us-ascii?Q?kObi69EnU5ImRh31OjSGFfkpiFpJW6bf249wRW3mZeRjIIge5UAd5/oUCmDh?=
 =?us-ascii?Q?3bElwrjt6yugbcIHPXn53inbbZHRrThHNUYhMbF3mPSOGYIE1uRcdiWN+kPc?=
 =?us-ascii?Q?3aFDtC6DiUbnm/N8X3CFWnTsz1QybbAcV9ZNvdc9OFSP7zt9GizlEB5cvdvC?=
 =?us-ascii?Q?q4MxtmVVvuAzeun86/7/gQCOViAug2Oud7Ly0kXBL5RnAt3g+QDAigeCnPDS?=
 =?us-ascii?Q?oJe1MX2m5Z4ED5A0X+/sHWPyFilW8LdndNQiecLEOJurSOxglSg8/OwQLXfQ?=
 =?us-ascii?Q?V/gqVxlIjWitFjeil8uelqMGX4k5D0+ArlvUHVX9FGJ/eXgFFnBs4hqO/C2A?=
 =?us-ascii?Q?+VzhSsdxTfIE4jfETs9VbJSTpRiJ0d90skl8btp80ls1xZfmBcyodk7TNfSh?=
 =?us-ascii?Q?d7xfNnxRPQHxHi5Rw5ULyo2KefOdcSw4ql661DC8P+ar35TXFIjsL6gsBERU?=
 =?us-ascii?Q?qRa0WXA/XgPVthaRnsHOoNEhuZx8KFxyI9GNKtaRJwtu3b6Pw/sEbXFjzu5u?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd05a385-b31b-4de7-9fd2-08dbdd40b9e1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 14:17:07.2142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xdjidPpW5ldOB2D7z2pFWPXszu4CoIwpVtvS5ZS15o1HWDW8ntcDBminpquG0vuqy8bIp12EJGUUV5hKznAVAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6820

Corresponding __lookup_addr_by_id() function in the in-kernel netlink PM,
this patch adds a new helper mptcp_userspace_pm_lookup_addr_by_id() to
lookup the address entry with the given id on the userspace pm local
address list.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 8caf968cd08a..f96dcb2b5db2 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -27,6 +27,18 @@ void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk)
 	}
 }
 
+static struct mptcp_pm_addr_entry *
+mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (entry->addr.id == id)
+			return entry;
+	}
+	return NULL;
+}
+
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    struct mptcp_pm_addr_entry *entry)
 {
@@ -110,15 +122,10 @@ int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 						   unsigned int id,
 						   u8 *flags, int *ifindex)
 {
-	struct mptcp_pm_addr_entry *entry, *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (id == entry->addr.id) {
-			match = entry;
-			break;
-		}
-	}
+	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
 	spin_unlock_bh(&msk->pm.lock);
 	if (match) {
 		*flags = match->flags;
@@ -250,7 +257,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
-	struct mptcp_pm_addr_entry *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	LIST_HEAD(free_list);
@@ -287,13 +294,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	lock_sock(sk);
 
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (entry->addr.id == id_val) {
-			match = entry;
-			break;
-		}
-	}
-
+	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
 		release_sock(sk);
-- 
2.35.3

