Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2049.outbound.protection.outlook.com [40.107.104.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18C635888
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VT+RIH6l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQDe5LiwJ16pQZHouu2pgDdErAeNMw55tSYUT9aK3Jn4lPVFGr37rSBLlRwzhlTDHeb39py8pRlMlHtBxN5BMTwlTTWbBiq0iqpD2SDQkRrHtuFcHbQB+ICLrRoaI53m9Oe3JhqTIw1mn7STyOgHED5rFkNMIU0tuPJlz6Mn60cNbPgHbwfeHzfJ0wDQ0CSsMt0VZlTl1Vacg5BTC1dPvdEEw2xiKdfQKD1pkO+oBSUPz+C1NurMe5XaOjx/HgwZtfK06mnprk6IY5GAZOUGXm/lAPJLOcslOTZkHbC0yCh7OiEAakvNZMOpNacZOy/LwLk5u01clWziE3VXtJdsHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8cF9N0Tt7Wm0hCVdx2El5/WoarZD0AglWoxn39IpyU=;
 b=SYMw0y6J+k55mekfUoeb8XPC7KgDXcM8CIe+cpNwmlSOyLXzW7gXYWrVi71Sg1s0li9fwREH7UqyuWtZ65l1CV77DG830Dk0g/rcv4k8j7Dq+BHr2RnyHlyPDFRe2Gnwy05pjr9TC6m5OQkyjqXNBuHd4gG/iIe5GYY7ES6gCNMRcotQB7MquKzgp6bcJ16+jodSBB7gJ/c16UsWSIX+TEKDe/o52Bumi2KCH68cWKMfRA38bRzxNhKfkNOZ0M7Wx0+VXpBHe/AYrtuWGSLuSO6TB0uDYAUqY3WSkaU5SBvCshRedqpaipFzQZ3siWqDH4fyz0VtG06mUMMohar82Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8cF9N0Tt7Wm0hCVdx2El5/WoarZD0AglWoxn39IpyU=;
 b=VT+RIH6laBkd/dly79zS3FraEZoGeVZDV0l3iiCuNE9/Ydz3xcf6iIHCe0EdCOQm9my8STD73OEWQZZyBJfV59a3b2v8Keloqo84Zl4KBODLEyANU5DnKzCXEgNUAEXjaG/OdJQ2BuVWfbB/XP5FlZ6E3nrrzuq94SxnxBv9iCI+1MKafHHjhISABb9UxuP1o9b1JNmg7QV1J6WtwQft6vSvHde6R2MfM8UhN5X5EWOd+UV3Sw6b1scVCV/9hvFkXiqiOCyR3eNFDaP3wC7zi3+tVjxvJxPrmdzLeXq9PtwWK9T40DSm/6UqBP6bxsHOImnKbb7RTJHF74hfzGpgig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7045.eurprd04.prod.outlook.com (2603:10a6:20b:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 14:23:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:23:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 14/32] mptcp: set set_id flag when parsing addr
Date: Tue, 28 Nov 2023 22:22:07 +0800
Message-Id: <37db3134b7a5442dc2af408d8a2ef10f11b286fa.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0037.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::6)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ae5cca-7a8a-4102-a5b5-08dbf01d9945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1wL6RdTnetMRhCtVeOdwMhj2w3qHPyGxJXiOlIKTj4YRz4GO55I02OnGusp1Hdf4JMQDktyFpSw+KTep8b5JlsEr2ukg13z5FBjXs6+btpJDNCYKMAx8ea0ZzNe811lnyAWYm2mI0ebLDg4HHOkCYG8fHHS3bCT6LXSCAupCtRHywkk86sYkFBJ14q0hQ5wmqccHHjNtz0hJs3hjix63j6kcU6H6ZiLVENAfV8VLtMY5lBlQEb0CRQz1JaX1hWX6WyrnWneZXNutcWi/w2FJT0qVJQIlt6zeb5O1sbIfM3IW8iN3+o5rekxe0lB/ZpnbeZilFp3HPQhMls9bEl+ujehyEGjCmR981NkLOrox9rbYvpPfuYUUWrAhLSqFIWKwmvYDcdTi5b0Am83dyhcqjODV1KOB/YodDf0HOZWSvGHAqfrZXSdbc28hYdIPE06lxOjv6nFOsI5Cz3+TNHAP6RvwdZQZ+2MIa6U9iE0tw/cn5x6pcYjAZmKzfMVrVpv6yNoz8B7wa7IwLjh+CjuBmrtJfAcr6nqtlhFruommznKJdQarsMwM7AFWMpg+qkb4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6916009)(66476007)(316002)(66946007)(4326008)(66556008)(8936002)(8676002)(478600001)(6486002)(36756003)(44832011)(86362001)(5660300002)(2906002)(38100700002)(26005)(107886003)(2616005)(6506007)(41300700001)(6666004)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VDc/mGadmQPJnCi25mVFYcNUyFg+s47pg3n81QdBLy/9krzCaWQmBGwYDDRs?=
 =?us-ascii?Q?eHo6ughfmVGPd9Cf1p7X50MTbB1RPpXaOkSX5Y8F7b64v/JFiYq3XmcznnZc?=
 =?us-ascii?Q?XTJOyrvcNwPGJhGqfKrAJcXjuTWoEM/3kVLTR9oGwreIOAokVFLiaRKGb7I2?=
 =?us-ascii?Q?71eEZLrViV5YSlwbI3HEAoe9Qcza8mlQFSMjHi+hWwJaWOh6JNJRh8Lv7oaG?=
 =?us-ascii?Q?Yaaw4jpnidkxGIIitVEfnsSbsvLwtFD9qTYtSDTX8UgLzz3wWftq3CSDNt46?=
 =?us-ascii?Q?u0PcCGitUA7AFvBy8WqfuQpAABW9z7a3RiWp8ZLt4UEMmbpzCWPqepJ9jrjC?=
 =?us-ascii?Q?qyQY7kqTTqVbuY7HOP6FETOfOoLINW88zjeNgxchTra8OwgU0Sh0rq7Wtmyc?=
 =?us-ascii?Q?URj32hyGCd2qcvAjjsNDgzCdgK6WV2G1s5REGdPgIwNYIQwu/0rJj1aIsvHT?=
 =?us-ascii?Q?BKunlkgais3umGat/dENc9W3kVh6tiEDnC25aklRVP9t+O5c5XjtaQdEIMLw?=
 =?us-ascii?Q?Q6aADo+wPdJitS/bqvexJjoAr1MA75vWSJeuddX41zJilNGKibUOMx5hB2tl?=
 =?us-ascii?Q?FRWIcPqCmEQIhOFBKlvWb4wvqQGiafFHwk2oMQgcBC11moh5zi+oW0ivjnHo?=
 =?us-ascii?Q?liOfb5GEsh0So63joPCqM3EqxmnDHsVx8ESRU+3a5dnPLU5BsoXbb434iXuO?=
 =?us-ascii?Q?VdTPeeRmiSR0/jCyV4W9qzrb7w1w8o3tNxnTrqGT4Hpn/i3RLzWzG01krXd5?=
 =?us-ascii?Q?+bA7OeTd/0pcwiXDb6z4LwoWZDfY73uQO/POsu3MdUcBvbvBMygyWYV9OYE6?=
 =?us-ascii?Q?O7+XVhHBXtljMIfygZty2Z5O4NZo67HZlmpDuebwcwOsHyLl7Wq5f5/j/FeR?=
 =?us-ascii?Q?qnACGXPZ2EWNh4xPwee5xjX9YE3K7FHTe7uP6Xmgb5fZdocJxeLikpbPVpJI?=
 =?us-ascii?Q?DSYH5fsEXzo8zVxDMBmr/m15kYN+4amK2D71jL9J/QPfnRLHS3CN648O823h?=
 =?us-ascii?Q?RYbGElmsC5Nz1zx8Yyc1kPui/3Jhr9VniKjS1BjTetDykYLXnlk+Nvtarh4m?=
 =?us-ascii?Q?AJ8GC4zkFHU46tNVaC2jB7/5TqicTmsSqnLe8Tm3hjUvEXML4adrmgZNvP78?=
 =?us-ascii?Q?bmhGAe4FHDmOe8Z1FJcfjLfDuLmu+Ssd1DxjW6Absi1mdb+yZLGrz+vUokRu?=
 =?us-ascii?Q?jRfzoI+xDVFvOTuVlr5dPHodKZkZt630g5XrCHVV0mvZFGQQUidnlYy+vpsx?=
 =?us-ascii?Q?+B7FqAG7kQIZAyEqxcj0565GvBV191iFl5npH46gFpHsMrSTszWoZhfgwnlW?=
 =?us-ascii?Q?6CuYCy5PnFkGQxCnbl9AmMFD0NtK1HI28Y3x/fTlSgt5JKOm87PUZueE+KE2?=
 =?us-ascii?Q?tiOfzhnUlvAsWPZGcvea4CZY90CXU9+gIUbmlgfXzskIoC09vAs+t+XGbf+P?=
 =?us-ascii?Q?B6jZ+a/EwJ077+uue8RwMna0OUTc+IViEoC7RRBlprQ4nImSi1qu2wvDNITC?=
 =?us-ascii?Q?Den4Cc8VmSZCbZ9MbyykwLhuZFRx5uc66Bubd4u0FKJwl4IYvZqu+7Bo9suk?=
 =?us-ascii?Q?0efJvPc09Qjb+CUjsPZ9mx07fFcQIxVTE+FkoGoz?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ae5cca-7a8a-4102-a5b5-08dbf01d9945
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:23:32.2411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fqF0BWA2RPSIGKEE1MWsToi4Fxo1Y7s0ndPfD85wIqNmnvHxyqaOzRj/NAxjAQt3vzOM4qIpxf9rShB2KYoF6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7045

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

