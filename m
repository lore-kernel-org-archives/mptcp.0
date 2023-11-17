Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2054.outbound.protection.outlook.com [40.107.14.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB9BD28E
	for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 08:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gD4ApYck"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmwEBeiS/CDDEWKcU6UM7z220KZ3wolGLeHX+//HyVxK5wFXQu8ozAWZn6IcsVWXqYWw21YqStTFhM2Gtpf3ggP9r9D2w0/TlJJj8sk31utz98+T/jCn93oJ3BJMoymhhapyj4wwPwq+kv0KNIEv0nTyBRaMrLCfGF9xerN/r/DEOYnhPhY6al5AYkhMRlaSwxQVDtdikp4rvXIHp+sHOUeSXxURRRvOsyjSi1fJ7dsGdYXp/YZ0FIBBvtHyre9rUp95EJTuDTCnOlhbHgS8QNeRMitudgsb7b7xAJPEyB1LpmOY8LEOIaNeNVQSXk2jX67aoVne/2NM7CvR90WKZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8cF9N0Tt7Wm0hCVdx2El5/WoarZD0AglWoxn39IpyU=;
 b=CxGGekCFZVD1wb6MVx+oavzI3+3H0TAAU3PwI9IWIE859Yos8uQHe6K+02EfPDM7i5nsr+oqBMXNXRIA8tdfHIuZm1kQ0KF8C6k/W6ouWfjcNQMCCu9Sn4ganSrh9V0Qe2r+97JMkAtVBvS3fBSeW+LqbA+P5m/zC8EzTDJSAzqjsVQyhkpJrF3Mr2LNk4za3ktgd1YMOMDDiAv0L3fF2MpWC7+k6KNp94EDzSKDMg6ZJIqh+gTcseBCMxVxs6N62f3vBm487wnGh1XRm2Va5GrNoG7EAuK6cSCBLw+Kzk/dbWCBWkYbaHeBlX5xvzZKSklj5nsElm6E7ZlLowPl3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8cF9N0Tt7Wm0hCVdx2El5/WoarZD0AglWoxn39IpyU=;
 b=gD4ApYck3rWibuN7qUsD/ecRiTnfQhI9LTFSxe+KbYxwCSj47UlicP5BNAOqd7WPzX3dpDigu9W8qo3R8Rzvo+dOJvDWK2W2ww5TrvDnpBvlpNdAkPA8Ph1XIRcHL/vnO9hY4Sf2li2RVJdsDF89iyHw1P+mzF94ceDouagUOX7uo7om26lCCDaeNnsZI+xlHaHO4oGgOyPj96cXjZ2buTis6lwqGXiOQTWRD+vCY9tFOnJHwbsCFO1DLwCscWMBb20n4zoUS/JIkmbCz6s/89RCHv/4qpvtNxlgmFqKvMopMQmDblE50JyMF9YRN2WybRNrlUHRGkY3eqmJe35+og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9975.eurprd04.prod.outlook.com (2603:10a6:150:118::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Fri, 17 Nov
 2023 08:57:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Fri, 17 Nov 2023
 08:57:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-net v10 12/26] mptcp: set set_id flag when parsing addr
Date: Fri, 17 Nov 2023 16:56:05 +0800
Message-Id: <83760751463a714a58d116d3706572b12782ebb9.1700210966.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700210966.git.geliang.tang@suse.com>
References: <cover.1700210966.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9975:EE_
X-MS-Office365-Filtering-Correlation-Id: fea4b57f-f13b-4426-7d2b-08dbe74b3de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/rE79n7dAtgXv5jwR8tmXnTiDSYOXz4jrZt6K+Pgyjvt2ykKjMW2jx4zxLU67dByDY+RuhWZCQst/GMDzbp+xJ5i8JIqEFy2dLWYE1GodfRjpLMAd7vj4A/xTrfRpP85AMbKq/6eSuvZMmVWDhjHYnQqfsgV0wGf6xjDikjdHy/Z8b+PkB6Xa7mSIo7axBSawRNDZ2Y/gkphdw1riRv3/FZBMRu6usFYl7hNakKATN9/OuJpFdwuhq8y2fEKJCNWLDKi6tifP4W4F5hU5zE2lBcSwHJaEyBX1JqPzeohwBsDRLA3mPDJyukWCV/sskxLrJ7d7QwcW1BYQUSiWnN13hu6StX4Mf56fWQ214FRlGeqO+2gMsecgiAm5K58UoJKrl43NPVxQwN3fdxIGBPymIfi4UqXWnRXE0hunR0eQp8xmXQwTEacB6c425wZlwkOyGTsRM5CGB3TVHGobENLEJbECT6y2t9H5df4OPhuowUzisJ8sfhmJXvgI5rP7N892jYuc5hbowt6lwSjpdEiCyCNvU/h7Dxie3wU4Z4zsvNrX9Hut5c/mbF+jiTiEwCO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(5660300002)(2906002)(36756003)(86362001)(6666004)(41300700001)(316002)(6486002)(26005)(66556008)(6916009)(107886003)(66946007)(66476007)(4326008)(8676002)(8936002)(83380400001)(6506007)(6512007)(478600001)(2616005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WgIWvzfTtckhQACs49qU1dbTvYcqzTgLdwRkuZRAXMaHCfh00RcjloXFtB61?=
 =?us-ascii?Q?FHlB/W+Rz02bRBdt2fK8wsupnOwQ4oIZuyTJ5VEehXXfhf3ot94jdZObMkSv?=
 =?us-ascii?Q?H9nIzq7xnqyInHurQo/is83kDsoNPT7IakxVmkB5dbFyo8fnHxHU9RBCJoks?=
 =?us-ascii?Q?boTeXaU3Jf5bnuN0xeh9phMh3GJSFNU+p0VYkkrIl0L1YlFsb7H/Bz5swboZ?=
 =?us-ascii?Q?fCvwhBzbsIz7XUTmxJOEBiQk2xAz7NsZO8jCwwp1NZKA+QO02VHg1rYx8uxb?=
 =?us-ascii?Q?/bfRwqRnUbev0/n58seKV6dGDaaTHvv6yflZmybIoXicbsZf72SGlF0ztwJW?=
 =?us-ascii?Q?P5NHCcd1ONX1rSSi7O2T7XKhZ60hpaqwGCkw5gNd4A1C1JsFtYb1DCI3OYDV?=
 =?us-ascii?Q?TNhZ9S0mMr1p6KoU8b398m52pDPt+P9diQwxw0rS7AKbj2X36EKP78oTpBgh?=
 =?us-ascii?Q?+lzH7tjh/EgTjbPnOKPuUgLk0pLU3pSqHCSRjDrxSIMrrEU+T/0iOk2iO0Hq?=
 =?us-ascii?Q?lHrhXd1pE2tg+SK14jw1hF5RLvh8yHKV/CTsT6qLYYDfKZP8/OodJiNC5Z+z?=
 =?us-ascii?Q?o1sck8ZQ1KNyLbF53Jx2PhxjD6sY9JCoD52IrzlcpjJ/zoO8hAB8grEa5FIM?=
 =?us-ascii?Q?J66kRUKumUUcXwQjZ+p2i8Dkjjf50BCgsKCnOsXiGHRBmfutbZa2g+/1h1uQ?=
 =?us-ascii?Q?sylU8vRMFRU1LwXGC+Ow4egBGwGiCXmyniXBnmE4pgfQLseALW2kJWkyYT6N?=
 =?us-ascii?Q?fUYqdQkm//J9FW0BqxIj8nFHSonj9hPwvgBGgvL0cIf5u7WYbqQc4Jd6Ak0C?=
 =?us-ascii?Q?lPjTyjaCXGkq3dMCvryzJumnXsIfvc6Cd0H2+OaG0UbMgFf5mNV3cEaxihZu?=
 =?us-ascii?Q?lG2YUQY4NT3aSK3KDO8D7q0gWlBlvaNjBWiQZSGOLvPtHFTM2EfTtEn8frqI?=
 =?us-ascii?Q?pkOhnh/9upJ8WzIjLPeHHiToZ45/yOhEJZcuisf95bNFIr8gx5TmOYDw/pT3?=
 =?us-ascii?Q?kCqWaNUXdM1hkTT7NWFUaWNd/PDgI/sLcf/EyW1VPyBahf5JtlbaWwCREuub?=
 =?us-ascii?Q?08cG3meO0X5g5PvxleG7Qbe3MN+TuHdRm77oMtKGjjVpKlRAWx5+ckKE73y8?=
 =?us-ascii?Q?AaRNxK9PCXoUlztMtioitwoz9njp/1r2dIbTIFykhzwQ1k5g597tp41eCuEV?=
 =?us-ascii?Q?OggoLc33k9X1SSnEYArjpcAcyWLFNvsFSlVFd2nSxenNgW1IFH3dLYNlGMIc?=
 =?us-ascii?Q?EyMrX7A319pve7XDsGoRC1+tzuGCY/TEu13agdHmXotPloOAWwKRwsw012PF?=
 =?us-ascii?Q?wRSSmnSSfUhQQcR+Y826vcdVL+1N3eFnPggsPD/nJORDOr64Qf8kt/IOxxBt?=
 =?us-ascii?Q?ayYlCXTZm0UB1avsj50QeYgyFUJGmR4e1ANICtDiZzRLeUcrfB+ukBhePwvO?=
 =?us-ascii?Q?bh5eS3eGGQ72VzmwWjSm2gwEAKI97W6xtI00vVMSisBw7FQiY0tcqMWG0lSw?=
 =?us-ascii?Q?LYGn1u80wQKljl6/xRo1hSyQhmPx0t3zFIwXv+yVhyr62I2icPZjcU4PVVbA?=
 =?us-ascii?Q?VPtxTOcicdhVjcdBp5KLDNPSnm3ttjNxjwpXz19vR6eHkT1fLvd66lfHTMWS?=
 =?us-ascii?Q?sQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea4b57f-f13b-4426-7d2b-08dbe74b3de4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:57:35.3651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHv5r1p4cCFo4aXPWazqdYyyhp6Sycj85Sr2gal4GCrg/IPDLDTKieLlzugSMVrTrMo7kMqQptrMkNcQmlg/2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9975

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

