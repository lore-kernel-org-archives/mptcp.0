Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2055.outbound.protection.outlook.com [40.107.241.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5B835888
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="jSFiaYWp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bcu3PDb8N89bDo187BW5qrk+GrF7YGqjz4WlDqslLloGuf+3GTEOehuAO8JX+gxsQ+RxWSK4WdrXOpKanWhLhhDtvsy5c+UHS6jIcP1uRcrloUR9a9VX9UMJgTyA6pk5Q5HTHIrc5+iO185wkbhhoE/DdcOO3mawLNVPJqgvDEJ0JjgOTaPQvL/eackG7DiUBSQsiyFFG2OQhKEaZbZYv0or609Go/Nf5tiG+EPYmmPNNn8k+HCv/5xkkSlf4irBM4+acbEeMw/cF01C8+ua9tClbyTJ3/iJR3HvjO7oB3B2rw+jnJF2zWptKTAw8Gl2wlTYl9fC6/0gxV/rDNEuiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFu5NR5fYWXwtw4Q2nfrmDukq9pre3TiGE1SzTkbt14=;
 b=RvTnmzZ3a2HJP/ObgoWfowUG7Hh8OnxXWB4orOxNUAWBEgR7EXy06SfqUIOqBX9MIRm6Z8yZKKU16v6dW8EflR/BheuZOWY0L2LHhhaLqZRLPxWrkVYIY1qruHSuDuagSGI15R9IttcKGu5pAtLFfl+X7kDoaspaQyyVhZ2+7u0PExNq0R6avhaZKr5Z4LUpEjzCMPz86KGE3g7MTo3/ENTDR7teTKoW2UOL1io8LW9LcFR6TyH1E7/4VAeLuW8qHGmmfQRMjn0Rt/E+NuiOHicsC1CDBFbF4PWZ4WH1X9ow9MJ5F2DHpL8jGuSwy+w7mQkDQ4EgMfQBX0B6arrN3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFu5NR5fYWXwtw4Q2nfrmDukq9pre3TiGE1SzTkbt14=;
 b=jSFiaYWpPB8fG3GRKB+E16ojkGjCihqBNAEFNQ10mxpG/xZ75Y5EfgMl3lBQSR69Twm5ZQpTonqtC5CpVSkQTtwEvqv/B6r0Fl3s+IHuyf3V6X2qU3zD9SR9GJ87+1o1vCRSyR9FI94Q0ww7myS+P9VRpa0J7jb7JaDWGqqBGzh5zZSyU5sn7vjCB0mmI8MCnf9Gx7EtoNfS1bDVsrHUUnHiPYXsqIJexh41XxWhJBWydJVKlFWKsoSIqSD+8dx+I7PGvKVKK4l4wxpBVcFpzk4nKI67YK59b1VDAdOOL0TWyaXfEdLtw/wxg/qYOqQ+6sNW8Qd92S/aCW05HGDWzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7001.eurprd04.prod.outlook.com (2603:10a6:10:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 14:22:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:22:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 04/32] mptcp: add userspace_pm_lookup_addr_by_id helper
Date: Tue, 28 Nov 2023 22:21:57 +0800
Message-Id: <8113515cf4afa6ab23296f05bcae27abaf6a4a73.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0176.apcprd04.prod.outlook.com
 (2603:1096:4:14::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7001:EE_
X-MS-Office365-Filtering-Correlation-Id: fc577231-e9ce-4942-8353-08dbf01d6de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YshPsx6JHZSvp8qxEx0xABPBq7aUON4aZoDKcEhCAcq+22h/kvC4CkOyKn7G+mlruNaOJsgrpv8PcR9MobojlkyHABLpdjUsZCrHNDQH72Aq+2Mcl6RbxECMVE3jFJtTpPu/tWr5xP5LpcrenWP++z/kDVT55H4eod/uFyumaNM3tPaf3xO8GqbNJNmnnIgfVRGtETIcZQ6vR1nt64aJ+eD0FQViTvxmhiI/26vdZEwWhLJALgRs8M7ikY7clQRElVCV97lpoTFDsqb8Mb3bhld+djxCz4j+Qsp60zTgFqfuyIZp4mgdLYz16ss2udKV1u6lXwCTC31aZR1bUw+CHkQ6LpdWEO1YJJoboffXzrxBks3DxvU4bMctHe1zmbiwspeuWTZAV0UfYLne6VC6ZHcQ81sDdP+lPqvszXi4dvloefJu7rLpVEP305D7dmVCxgLP/EFV6/vFNVibeTC/Gnq2QKVCOKgcFe91f7tIOF8mGsx71Xfz3PDK6k6Fmu02jUA1nAsgopYCQBg9Ta4rJVyLl4eAaV7eqrSRKQ0LKjYSdikk37bAigAcWKVfKbiT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(2906002)(36756003)(5660300002)(86362001)(26005)(6666004)(6512007)(83380400001)(107886003)(2616005)(6506007)(38100700002)(478600001)(6486002)(44832011)(66946007)(66476007)(4326008)(8676002)(8936002)(6916009)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hbY8+TVnJcjT+S3SSMP2cSic8+UdCm41fwzdSXvnqwrtV+j9YCgiODedvX2R?=
 =?us-ascii?Q?qEtIXENIwiT2eX3r1QzqHvdNueovjaNsHJqiTLSOA6YpybVxXD3AucG7CFoZ?=
 =?us-ascii?Q?tmLUPggKdDOQRL1PONXliH1tSxoeFSREQw0RNBZHRsgtRqrb77RhxzvwfCi2?=
 =?us-ascii?Q?zdwDDVQTdO5n4r3iKUoHhcFVx7WYkPv9x0zWXytEkuS3YebtjFLfXFBfJGTL?=
 =?us-ascii?Q?bqWFMjucfhUpyvSRAA8ckG1NM40FHYIV51COLHfmZUOYiSZ97wCMT5C91q8I?=
 =?us-ascii?Q?XXZEoUPwI1o3ZcPzGbA5QvcE3c04jUHMtnUdGI3zYIWci7vkXrI8SWihGjbe?=
 =?us-ascii?Q?Tb/Xr7oWrtfawa2+P2zp6Ht7Kr90f2l3eCNF/yxiRh5UjEca6a1rH5NitsAg?=
 =?us-ascii?Q?jeGD3lOvN8KPXa2KJpw+gl6LPsdU88l9LXu460lEKoA0fned5E2I7PnM1Vi9?=
 =?us-ascii?Q?VoQS7OgG8mDs8fpYw/JtQk/obhmpXvvmlj/8lUDLCQYPbDYreNsUDpjqZxc6?=
 =?us-ascii?Q?Xp5OHEjwszxkw3Mb4ALpviyLcfAeAhXmmHol4PwSrdjzzTBpslR803L21PuI?=
 =?us-ascii?Q?H7NOaZdVv8GVLVzKjw0SBpqsG74hEu1jzaNdgqoAwMdlGZyfPQdk87NdOicD?=
 =?us-ascii?Q?wYK7wP66+5c8GggfVRQ5abX5uk2ASWZjzR5wEnHNHwMKrmNtpfrf+BtxeCiS?=
 =?us-ascii?Q?R0bC6Z0//M76IyHh4FMwFqTXGmJm/lWbF0wDdFfHEGpIqA+C6sAnQDvYxS66?=
 =?us-ascii?Q?ccYUM7CMvACKNBXmLWSi1ztFkPXVD5QerOfOWAtaLzLECgWMcT80jWMaA9Jp?=
 =?us-ascii?Q?1+L6VR/r7o6G4CcHoUswdvhOIuYA5TLELmCS+kCEotbP4tLDm3TVKV22v5ex?=
 =?us-ascii?Q?4n9qlgOnlmPq5HBQJmhRKyEcUXLNu57Kvunu/sktwDrR1MwHg80e06HfhAkK?=
 =?us-ascii?Q?8gYLLgikUsF7Euv8R8Vz3lvOfNoSk7st1OcWtf9PeXZyVN0MbZS5n9MCPMbz?=
 =?us-ascii?Q?agw6jR7ZqIzBxO6P/4Yz2D7rtNleAxTJkBS/DN62+rb1OB/C13cRrMqLcEPW?=
 =?us-ascii?Q?DBmymQQ69k1oxhIkz2mRPIHhomZg2hmPxebaA/m9PayyQH8OnOL6LlH/S+88?=
 =?us-ascii?Q?XLJ2qbriYNbrYmdDneD2nIEe+Vr9vs+a7+R4GoncSlOC62uEyLO6t337C95A?=
 =?us-ascii?Q?UIgQj3k3vpiJSCGNj8jP/F9SdbHbVbiOVRAS4zGT/EUdRseMDQhlw5h+UFz4?=
 =?us-ascii?Q?dWCC/3eMOX1E7vO8S4Cc8UTrfj0t/LqHEiwHprHYQ333qt7skcq7qj5R1WXJ?=
 =?us-ascii?Q?6UhRPs28Np2u15ZC8PNSz20nea5LDQkcghzcj9AvbHgFe5AULnvtTUqSgWRE?=
 =?us-ascii?Q?Vvgot66ZEtpP56zLfHqSg5212EdIK07FlDCRB63XNs0J2y34l4AmPi07V6vY?=
 =?us-ascii?Q?78JADHMznnn5KHydqUDl2DOlf/DE/e/rqP7ALMh7VYbnFnTxH7Vd9hOWKdcD?=
 =?us-ascii?Q?/fmCeApBSY1Td77DgQNXg2+8MlOzGmyMLgktE9CYwgxw5jHlk8zZY4UnduUr?=
 =?us-ascii?Q?fOYdB2yES1cOmDTiHGi99UaL9+Ggm6NVnkU2EIlR?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc577231-e9ce-4942-8353-08dbf01d6de4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:22:19.2998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywi5pGfDe39sA4FBrH8nPr25oKckMKG0zdCryIUbNsOEI6Yf6qnDUXZj5FR1YKWHzY2Rvb1SjQy91vYaQBQprA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7001

Corresponding __lookup_addr_by_id() helper in the in-kernel netlink PM,
this patch adds a new helper mptcp_userspace_pm_lookup_addr_by_id() to
lookup the address entry with the given id on the userspace pm local
address list.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b3a606a5e182..6999296cd5db 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -25,6 +25,18 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
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
@@ -107,15 +119,10 @@ int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
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
@@ -247,7 +254,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
-	struct mptcp_pm_addr_entry *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	LIST_HEAD(free_list);
@@ -284,13 +291,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
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

