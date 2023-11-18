Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2076.outbound.protection.outlook.com [40.107.249.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DD318C17
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="rk7dnbvq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqvOhFgUqPdRjHcTiGizyINsjg7q2TLdQxzlO8jzAiU9O8HFpVmBg0NakHrUDCeb48JPbOsJvNw7Hwxje42H8JmENKYFdjBMVUNM0GweFiySdwnQkIF0BYmvau9DgPpAZUNj7O62CugZUZdLCYgbvGwmBRxbvTpJa1DY4IBTACVZgHBv/A4cCDv6+FJZNLKbAUhHBCYRpFnV7kLDbndDnNZYAudAfl37GrtUsOKBRrr3v3fdDXILqr6RA3sexeK71q4MgCEdQsOgpife5t007rmgj3zLIB+GORGyn66K4cbE3TGUfLBETnjtK3Vb2kTgCow26pJVVGQhwOAHDi/IIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8cF9N0Tt7Wm0hCVdx2El5/WoarZD0AglWoxn39IpyU=;
 b=anDvTDOqnA2Nnsms8oyEm9ne4ZTv1mkf/IJ/e05oGCn9rrESN5GLKrOyDlw+FPIpA1qn4niemhnRMoZgTBrXgdq+SWoJhoDBeJW5IvCXyeoGBRCnPuAyV8A1uS5KScwVwCpvkytle7lhQNryC7xCEudTSR5No8PQqgz2LLwb1iGlH4SryR6QePqEvRAeOtwLcpd4rHj/RIM2ncl3vWtvmqiJXMTnZFyBQosg7nly3UleWZWPIKlJJOPs5Mrpn1VxRa0Lu/ECKC7Fm6K2OtauO4udmT44CkKoHknVTgtdS3jwQe+lst6lswTHNrfuLfoTLUl41BwDn+4GOSecQX58ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8cF9N0Tt7Wm0hCVdx2El5/WoarZD0AglWoxn39IpyU=;
 b=rk7dnbvqIBVDUVsg3jE5sFvf7VO24QbPQj9qmxhnA3+BagTsC7uIu4aEGNzbXxGPMsIz3fPlUHJZFjlRxRZFW5wHLknj/hJBTLqbwvw34fzmZ/Tfz4IWBigp6LAM24teZs7tufow8q+0ZvVpLtozeNgGnHla+CrHwFd05FBy8S3deSwlGO/6Y6od6VSu5qGu7ybW3DoSgEv6iHknPxmis8HFkGfobZVf+FP3/Om+Jq9WX0amgHgkBeRjZ5e1GTWsrfh7YKO2xcyK+5eudzQIs6GeVIBwFp1dfDa1tf/7ZPVkOHjI9ZkdpmK4VkuURxzauYFay483uNMdbuesvnSRbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13; Sat, 18 Nov
 2023 14:30:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Sat, 18 Nov 2023
 14:30:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 12/27] mptcp: set set_id flag when parsing addr
Date: Sat, 18 Nov 2023 22:28:27 +0800
Message-Id: <53250d8b308802d4a7179a02ba7ad13cf0f540a6.1700312872.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700312872.git.geliang.tang@suse.com>
References: <cover.1700312872.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY1PR01CA0202.jpnprd01.prod.outlook.com (2603:1096:403::32)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 052998e8-408a-4dd3-b6a9-08dbe842e917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7RPXpCRvuS3gfPKnKX9A3dn1Vb/BIrTUxGYOg14FHHn5iKbjjno3D44zHnj3YabA/gvP6Uud80OORyw1Xv6yAwlm2gqMIXkpWYdkPP9hW8Dbp6LhR386bLF/mfSyIQLwKZPgqaYSb9L8+SMcPLtFp68+pT01eZKcf6pgsspGzS54AGX3YhHiiMrcEu8AvT6F+pO9lhBs3OzKpp1R5jvuyGQg+n+adssE2MUwRC/umbN1N7aiv8Ko9Mw0vjPZsvH5K+/fZTVGBuwETRK7qwhjmdzW99B4wgVuZomwetHmbiKJ/j8/O2AXz0bZEs3dcm4utoj1PDKtNRCJukk+0kWudoKcX/SgcwxblKqjEHPT4nz4OKMg0RLoVZMGrkpv7OstVU9QnTFb5mJF2lmY2HbRkCQvuuUQsYoxZygDjime+cCngR1+qgVOXecx2LPZQIGb1Mlqhu8NAVcPxA8azcCcqK6I6sTN8myEUsXMhk2Q/G57uf3IH/pbzcIl/ti6ZK/fFBwS2NElbufPjHgtOmH4Jwrboay/UI6ePiD5CIFymjZ0qt2GmVisSS2CWd28oFL8iQwbuBg2M2yGjyVQzceeiKxV/9a86swj9T1VvQoKDa0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(316002)(4326008)(8676002)(8936002)(66556008)(44832011)(66476007)(66946007)(6916009)(5660300002)(6486002)(478600001)(83380400001)(86362001)(2906002)(6506007)(41300700001)(26005)(107886003)(2616005)(6512007)(36756003)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SmTt5lO+A+DRl/SjOM+bStr+ijy9u7NsYPgCB7/PHMO2TLpJEXy7JlA/JfGa?=
 =?us-ascii?Q?LOr2hffuF6Q1loz/slG91BqHv7k6pmXm1qtL07vbBN1rpZFxuTqNwjvh/AJI?=
 =?us-ascii?Q?0oUQnFntk54V4N/UMKsRtniERIBIvVj54zNcJD+PweIeFHJsFb1OVIfe+zGR?=
 =?us-ascii?Q?71li4j9Ihmy2kDFLcg7jecJpRIML4XJN7yxk1fvlPyrbrnbS3+4Lw8UP4guD?=
 =?us-ascii?Q?hcQZ32HxCUPPdjWZSHLzlRvq0HSeFi3E4RT2CdRTKsDWe6wo4IR6VtcpxgAg?=
 =?us-ascii?Q?tNmnxqvH9xtzqaDhLydsDyYyFu4331Bx5o2DE/xWZNhz87YwPDDKxhbDvJBk?=
 =?us-ascii?Q?JKBRq/f8l18zuXlKEJMNIxveoWdr6tCPN0KdYDamSaDj/4EHNv8iBn/wW55x?=
 =?us-ascii?Q?/h17TXhq2ASUBHgs83UO8QMCWEhS4N0c+NXjoVwOnYI40LWUPKIZH1zqen19?=
 =?us-ascii?Q?ZoUihukX1ERB9v5aN6Dj4gnnMrPtecAREF9xQr2oySNEvV1ha7BqRu0E0x5k?=
 =?us-ascii?Q?usmpsiVatix0Og/qhIPWq4zKTI00PtR4azdvbjHrACJpFagKdBcJyKuFeS+Z?=
 =?us-ascii?Q?agOoP/rXatMeBtQfgNPmEKj1ppsvpd7e5ZGtX6SHcNzBsEvR1XQ1GSN+IV+2?=
 =?us-ascii?Q?RLjHTE7rUq4EozlWdfXLzHeiHVTboTAiirKvwAbIYHyqzh7DpKWpc02qu/k3?=
 =?us-ascii?Q?DTuQw2Fx7BADbbnBRYfvJ03ZBRy8ndweEwBx3TysAJjrbCA9HA02g3Qhddxt?=
 =?us-ascii?Q?XHd2HValU8/aHvTc0Lg0ARLidrnLt7Mx3tHQtmelxE2iqcMV/et3LNNrblPz?=
 =?us-ascii?Q?rrpv7LnNESeX7+z6IcmqWh+65sMKfoMSc7mAxbA66SS/B3AKqPYG97GNkDcv?=
 =?us-ascii?Q?/e1JjsrECglw6OQLtzVOKZkNWj4tDGqmgtWGf0ko8pd7PQLD1C6J5vqTpgyr?=
 =?us-ascii?Q?7ErO5BsSiopygAlc4oDgezz+pgdRN66+IjkBCzlVjEPWmWtFoQM7mFwjb809?=
 =?us-ascii?Q?taCnxZ2LMYZ8sdHweAUlC+8+Gf7+oPwHDgGjphLXVHAcnIZWZBSp9u8FWis2?=
 =?us-ascii?Q?L5Q1vkdfDIN6XHyVwvkrrEvDEF1ZdR0j4IjuwvYyZd5l019jbrhu3kUwp3yd?=
 =?us-ascii?Q?ckn5YjCeEjhwv08UsZIXc20WVYdnfdjOov3CN4yCksYnyVPjmNWs7o4TM1kL?=
 =?us-ascii?Q?QIlfkeCM9/hLbpRIVItN5pYOhty8g2bfoVKtTjsSx3i8m+//3s1xIDXiCdIs?=
 =?us-ascii?Q?WRpmHgHTaVAvVHiXdH1QDG6T47/N+SeB9uJCD9hbkY4lWPmzNWyAVHwgn2B6?=
 =?us-ascii?Q?fxRMyQBk3WVZ8H5v7jrGVNObdclKd3HpyrCLmVbe1TgMrs1eH/M7oe0oSFYn?=
 =?us-ascii?Q?NpP7n7l7cSklCkQw47AF/7NZt+7vM9q4DwhkqWpkIlU34zbwMB6SQXb3wG9N?=
 =?us-ascii?Q?diaRw368bboCFEh9HPJ40K1bMN0PYB6Zt4Fq9ILT70NfHUuxuiWTL4VEr9uF?=
 =?us-ascii?Q?JK9KfddENRowJ7tzUxp8noMrqDkyOc01Xi1uvg2rfwzEns2GcPiRnSGM2m2B?=
 =?us-ascii?Q?Z9FEsusUbrnVvDB5Sz6lsCAJMU/oV9kdun9f3Q2tLex4jb0RqUbx7jPxxkxe?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 052998e8-408a-4dd3-b6a9-08dbe842e917
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 14:30:28.2983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwqydFmz9Tw+xbsO4hmiEnihtdBzySH2AZGONnQYjAkylhIZ1nMZBdOYIIKlVEX+Rp0CAuuAFbiREGerXqBvig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869

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

