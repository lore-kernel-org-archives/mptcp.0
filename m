Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620DC10942
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 08:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IzqE2XH/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSg8ehKOX+VVZiXt/uLmRbZn+9PjGTE8ageldwT/Fnsh44Cyw2Xl4H+ofHPWB9xNIz5fXys+CGg46V9G0FipM7hxXiFn4Yyn9vrlYzn6j6KPrMryvVbYI7/9C1I9MT8CDk3bKxo2v0OsOAJEAcmnFlEFxLZwzDANxW3yn00qqf6QUZKeyHzJ2HYlxd2sKrTT0s5xyLpiAYT6Gt596A3uWTPrufJgJcGXr2uWVZxWgisLxwyrCLPriNheHA4bzJfKpqcfoTw8c4HFUUuguyNGyPp9d6dfemEqRYMUb2C/yyymBAGEtHaDrqw9P+FAxo3pt2xNk8p7UvhX28QxDoWGZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoP166l0cxfbdzoTW90KFZp8hVW5a78ALyEg75TjHvY=;
 b=JArJJmTq/vUskozgXqGsNY+/2aCqajWSVCEMtXksoqYRod8YU0zwJX7liL0GR7gHCtqjw6xDJmz+TCFun2C3sAdxRMYXX8y8640A/uoGDYZ+CJDx3tss9MOKxtZDkV3XVIYcQSWfOrU5iN4VINLLNWG0HWl3Yfao1vnVrqJeKVUwLOPQgyDdv++b7m18BeWY6MBl6mY+oU7JyqpP2WlNYZqU0fhW70RxpSisH3Q/swkjqKSIUmvCHuC2sQqlRBBESbhc7WDXVS1SSiDl31dmtvw1DK1mfHVnS3I9h+u+NEfmHXPuVo83EK3M25oup6gQ7uvbcfwpboePlhs4BbKPtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoP166l0cxfbdzoTW90KFZp8hVW5a78ALyEg75TjHvY=;
 b=IzqE2XH/sEWEmVedMghT3lts5Nu6JRtk7V2CtDp1eqikT2sqz/rc0gX2G/YY1GlnA8pVEz694ODF3pCPL2OhoZvg0NyI6fNbH9MYhvnzli19SWnlmi4nneg6bRrOUyQCjzM7EhwTO76y9gtlt0DXrdBsCFcFch6ttUU8PCz1kb3Q70sYSVpCVmnSR9S7KHIhFuvDucngVygmTGBQk3sOCRYtqL16vDzAG2WRCZUbosV6meImQ2yiDWggM/C6opVTTyb/1xhO+zuU1y9gnbhFyWvhaVt400rOWrKl9taNGzJT4URGY9OTGgd/+GOEBLwzCRGfW4kaRIyUJv2VAujbqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7663.eurprd04.prod.outlook.com (2603:10a6:102:e9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Tue, 7 Nov
 2023 08:15:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 08:15:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 06/20] mptcp: add userspace_pm_lookup_addr_by_id helper
Date: Tue,  7 Nov 2023 16:14:12 +0800
Message-Id: <55cc4091c152c6882880e498aa817c33953a0687.1699344621.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699344621.git.geliang.tang@suse.com>
References: <cover.1699344621.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: f6160d25-b02d-4b1e-24d3-08dbdf69a4d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iBvWssu8Qb37IE//W1pDyQQPxMasqw0nP7cE9kT/5c98sbcNqRrXESVEbqpXcvMGRWtMwppX4xNUPRRK6y1RsXQe/leE55opCZ8314Hr3itapFyeC8VKSd78zvRI4SU52LhxNH7CUsrAzMEt16ER+soIxMTf+yqfv//aJC9VnYVr/1/xW34/p8q0g0ye4w8S8eNpctuyZd2SyGAK0QHORjih5kdbdAMXEQI71ZgghVU5tdYy4gKYaK+N3OG7GAYY1FVb2p+sMCojObIUGYpoGalD3oAoFm+TXCRJYQenMd2mGJfmmWlR6jsrdZRK/sea1ZE6haTT5NaiJIao8Lg2kGl8nere4V1lTRY3ev6hilLuucrZ3z4uddHTUVGWMt2z1Y1DphHED0c78Pc8gICedV1wh1oabArNiJYPVOB9OCpNvx4Gv8E9kSOnbhlAg1gEpWAAO4IcV5jS9yf44iTWYWO6R4P8Ckso9TGfKYc43EWKxK7D8V8dnwKquwFJOF+k/nkLA7xFKGbJxj4Xfc+A97STu4L2m14SszyW3lsXZtOFz/Zy31Ultj76sTRQJd2V
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(2906002)(83380400001)(41300700001)(38100700002)(8936002)(478600001)(4326008)(6666004)(6486002)(86362001)(44832011)(8676002)(66556008)(66946007)(6916009)(316002)(66476007)(107886003)(2616005)(5660300002)(6506007)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NNkQoFACTv6sG2K+haLFPTteBgBJ08h2E8+XLvKeApnx8K+lEsx9GdIWyGA9?=
 =?us-ascii?Q?Ew24L9RNvKgi+PZ6/Tt/N5u4OOt3wocAgOHrF/Bi0JjgtXZ7cIxXlU8lDNgS?=
 =?us-ascii?Q?nxVejYRo7ozAenj6sfEaH7WtC3tAx85oHzuiESEwNGDR1ALBD+9rD/uodjfL?=
 =?us-ascii?Q?9mImY88sGn6RGBByn1h2IvFVEUOpEJHQtQ2QQjKGlugCqK9/EMOEgwu2pb1R?=
 =?us-ascii?Q?5XvtHA4fRyW3uSBi7MaDwZU3GeaGpXTCi46ACszXXNAxBMnotKhSY9VargcC?=
 =?us-ascii?Q?QKWu6ypANrHgCF4CvrrCQBVkSqp9AOna5zV928yICiMap89AhkwdOS5Yzjpk?=
 =?us-ascii?Q?oEUCdCRLptGQxfIR6IDFfLsqUab075bOD8bU22b48hwmehFJ2N5hhIo+zEpn?=
 =?us-ascii?Q?RY7EJ6guljp/ZVGO4sk1HyWRQwf9wni6xR8URxSQCMWM4oRXIu3MfYNs5VSB?=
 =?us-ascii?Q?+m2ne5wq7bf2Vsb2qfziM+UeHlOaFsEXLICQkdUkv6uShuy+sbqjUz8MQuFM?=
 =?us-ascii?Q?sQamNsmpav5FJVtPCdQuI0aoF23TlXmOktx+Xuj7rgQPV4xLfNMTIKyM32kf?=
 =?us-ascii?Q?HMhhvOOnEqJQP2EbmDz94VPFCe8aSHVcW5DCO2OqvdnQNIxCy+rRTApXRnHs?=
 =?us-ascii?Q?MWm2f9HNiWAXMHsfU1TSLf3u6vtzmuHWX/O/G9PgoJO3rdabySk+BJm9XSaT?=
 =?us-ascii?Q?ubFFvninJOBK3FDXOfPcgF6uOjbEOkMfHRL0qDlAsEee9sWFZviiIh61Y8Ml?=
 =?us-ascii?Q?ANj0K0Zusc0ooe85Nr0pma06WnLdPVG3OsYw6g9vFNofuYZf5ZeSJoEo1osc?=
 =?us-ascii?Q?afcI8/vxD22MwDmOJPW3/qoloADBovFpUfSVIl6ICHmHH+M48+jkakmiJNNt?=
 =?us-ascii?Q?bcWePJzwiAnIriLGZE3YmNaMIFN6mt3hQePnNzmUHN3+P9uBtO0kT9tjYcNV?=
 =?us-ascii?Q?yAMPYY+4sZ49qjoRHktG3SF8sV/gpvz4iEG4zLN+PUgcjlULLiROl5N3eGYb?=
 =?us-ascii?Q?dfvExYi0HSPydID0ahv7OQMo8wlM/anh7aaMekKSrizTLsFet6lo1PyMSacR?=
 =?us-ascii?Q?MmvDQzeknc2CkCh1Ojd0o6+LN0sNA06y66u6A/l8DQ2MfatUCmiQJQL2B5k0?=
 =?us-ascii?Q?AukSRn2VHZQKksEQQkU1TTppYKbl1kKwSGWawAEk6Mv3FpyN1Riy/XtYxl7h?=
 =?us-ascii?Q?v0wQixyKuCyfAeVxmPw1Qb9q/Ap/DUpC1zqf2EVDoGybk/m45VzA7ShaxWh/?=
 =?us-ascii?Q?/4m5OVs+dwhgTv1fwMQUcRTM1xe3Goa2Y1I271M+otSAxWUROPE9VdMMDExj?=
 =?us-ascii?Q?x/Oj8L+j+qRh4/hNIUfJTyyaWsjqDLfoeX7SvkdAKXMJ5CJq3L++dUDJQpHx?=
 =?us-ascii?Q?np03vOtDK8NtOFSk5d1n7azYbi+LelqMOjddlnearCehFNTDna8Yt+HbPNLh?=
 =?us-ascii?Q?zYrxgMQ+kFMrIHBpgOoFp6gB8Kba1OvknSVSEpuXZTJFZlTYnwC1CcnPoCpp?=
 =?us-ascii?Q?lNLVL57Bpy6kwRkTxhGJcyLVxlnifF/Pcaq16Yr1+hddjONlJO18Zebb4Lu3?=
 =?us-ascii?Q?mTZxw8XYf5Pt4twaE8z+uau5nJ46ZCkiqZrZq22+?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6160d25-b02d-4b1e-24d3-08dbdf69a4d3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 08:15:04.0890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOJ4GxF4iZk/gW4DN6i2b/EhNko7vW0Cjg894MwhTqLsmATTVTVaBF2QU4p31VYg7wRS4s3rpaGj/OupOUrVwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7663

Corresponding __lookup_addr_by_id() function in the in-kernel netlink PM,
this patch adds a new helper mptcp_userspace_pm_lookup_addr_by_id() to
lookup the address entry with the given id on the userspace pm local
address list.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index fd74c0092039..73d16c8006d1 100644
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
@@ -109,15 +121,10 @@ int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
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
@@ -249,7 +256,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
-	struct mptcp_pm_addr_entry *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	LIST_HEAD(free_list);
@@ -286,13 +293,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
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

