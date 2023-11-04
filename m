Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E8F368
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 00:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="jrkW60T0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wn5l+Ig9FuXqj5rkf9aX4GR1hdOgIB1Dy2Xb8X/sWF6EToMEfkTGOEYswM/HQ5eBIm2CW+buHPkoxxCooJ7m3EnCQ8H1Eyhq+Osfy08tZLP8/eZVW+QTddJPWtoCAJ8DsDMB2997PmVFl4I+SHHkge4JalMx+U5v7o9c2PmInp51/mLV7h6exMmOWCC5wZ1ATSMS5DuQRKTnEd5xYuz8HTpfz4BTXuBtmZ7DufVO2gTUhIfMfe/82qbPWeum2bXpvD11eWmh3w0KF4hcf0M0lEADKNfItlYbunnJ9N/g6bTptkdc+UC+969SrzwvBv/wpwZm8UcVmvsp5Ig/mBGpBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvyPMA/bySFPFIqW2JDW9tr13OIXOzQbjy0djyw9/h8=;
 b=b6VE++aKJnUTu0dMmPfXBiFa/zEuorZd5BMg+PB+eAxwOGif464aLKJP1/Gk85/cc3iiCmhvxyU9E+BHq0CRc/KQKhDmW37pBEIO+hlFor0kdYYYw22NMH1HJFjsEBZGl8uwEhUqoBJiOel8Q1iP/q2/C0woZTLj2Myl/+nhjmu1Q7PjqliwGoG6lZ+VIKKMW6F/yI2myUYpW+2PVFbNROT5+LnVkFK2BVijvP5xvnuC2BRJwp6wESG2udEMtWDP0wBUrDP0+KdZDSJAYxubjBRCJ4pgr4j6o+lKD+F2CX1Z8AHljfhGPNXLIDXoUlfuxy+R62h2ON/7TrxGHi6lGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvyPMA/bySFPFIqW2JDW9tr13OIXOzQbjy0djyw9/h8=;
 b=jrkW60T0/Rr1pyNGG6SCa5llZ/+c2X+FJpETRAxdFh6aupzGKnpxycWKDVz/c9gC5H1yC0D9Pn33KxeJcRNC2o8UKFNf6uj+4WSktSJ81145L/8iEyb9mUeTNoU3Z+ytpp0yr14Mm3WE7VPpBPMp9t7x4s75HfOUCeBBultooBDebkeTtxQvb2yAtIaH+o/juv9xnaX1Gv8iHdNVKaZc9eVFk/DA+/SHlOBPRji10KrU8YbU6Tjpg47zjekBseLkEfW0PAIFuEyqpMhKXojgQtFDr+40eWRQ3jW0zemOE33x+9shh+XtA1cMDq/QTdnBSBizrdzPgdj2IcWlWeNQ3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 00:26:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 00:26:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 01/12] mptcp: add userspace_pm_get_entry helper
Date: Sat,  4 Nov 2023 08:26:12 +0800
Message-Id: <cdcf457671c5de518f7d3a7ec3d458fd029fdf94.1699057244.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699057244.git.geliang.tang@suse.com>
References: <cover.1699057244.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c3a527-c770-4c6f-d428-08dbdcccbd69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y+zer1e+YvS77//DX3Gk0ry5DlQSNc0UAdBm9/s1wU0q9dTTr97C3RaZWEbJwMLRTQjRasVaeJCHGRAmqaFe+iE00fIkCdMe9x5SwF0oafICyyvVK+68InvJjHFn+3FBMqymYUc+crH9YlZLcc1tH2ZfIlXeoYTs188d9P56nnDb2YQhBZDPbcuvtZw0OT/oqM2FvEqyGjAKcE3m4EQcA7vsp+2OqwHjUl7MX520gjcEYwovXu14kIQDn6EtL++/6SEFibr5kN9oJGlphwIKodTvxGS/P2RO68S+u5Ccp6o4o82DCeBjT3ugbAkMlUmfDNN1BCZpNXf77YpeUpELVw/jzHEK6Qru45FnNtBzH2B/Lys6uzMpJLkcOb7yWIlW64X4vd1GSHou7O2DOUoxZIB+/e5m5X2sW0sJsMfma8i3zty9sQPINdPkwnvuYl7ReERfkkG+Va+uqz9MSpbuNBKZJNaY3BA1aWh53n+vTIcNDWagt1wJMIrnvyTfGA+KMUU1Em153BHzowvbpPF/yawTNT5LO0BvJnimu1WWX+WceVnGDhi2S3xuulSPX34xa1wJNEEFbsEdyDKAKnRn78n8ZnmmFLYBLv/l1Z/8nRk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6486002)(5660300002)(66476007)(66556008)(6916009)(8676002)(316002)(4326008)(2906002)(8936002)(66946007)(6666004)(478600001)(44832011)(6512007)(107886003)(41300700001)(26005)(2616005)(6506007)(83380400001)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t7DBsYptIuumcDSE0NBpayimkLZAUeScbOW2CW0JJGk8emlqo6ZHM6k7Wzbj?=
 =?us-ascii?Q?txR+udt2f+8MZvl7MrmyP0fB7PL7zhoa0graVawFFkvHlrt0YnsQllApPwfD?=
 =?us-ascii?Q?z4Br5dkyQVdL/s+11BC7V2zEzPqNo7/ZOfI3A5c3DgEdsNn1ji7/eUylOTd9?=
 =?us-ascii?Q?xfyTtippvmEFAahjt3XgPieoHZvxrJNRVCYGXEGCu+ox5yuG4K98YAnKwWsO?=
 =?us-ascii?Q?cjc2ZHBl5umE1akETvc5tl/thRDkAZ+wKgzI2D9s2u/C5fpQpjAGAGcTK4Vi?=
 =?us-ascii?Q?SYtWXhtyxu9ApWeCuiVYK6Kqen7JPA/7/gZm3tDlT4CEU5dkg3h+fQg3a2mU?=
 =?us-ascii?Q?xbj7FtXJZZh+ZV3dFSkzTQrnpPGqFMj2lgz9atCc8HmCMV2fMJxozX5WFBh2?=
 =?us-ascii?Q?afakm12Xn45DEE9f66QbKD7pz+5+vF8n/XKdHPR+EeI4TQtBJDkKkF67706x?=
 =?us-ascii?Q?BhKF+sXtyQc2AsGSevH2wEMacDz0ew0X7b7sZAult4dqgbQAqm1aO88uYx53?=
 =?us-ascii?Q?0gSqWa8BT5Nfr5tByFuP9qzjPPy3ZDUqZPAJIlOBC7ppJOrboIHX3f3z6ATm?=
 =?us-ascii?Q?4s0HOgbPOUcXB/vSNKgfUcBRQuEZD05X7qfJ3GySQl4B7gL/QIHVKNrrsXpC?=
 =?us-ascii?Q?IBEuobDnxX8I8O0WTscbTK5ujxe4x7VKywX67COX0UC9G7CvRle0JXJ6HJYv?=
 =?us-ascii?Q?TOaKQ0kcds/bWf29vhImftn+OgtS3rxMqeCmipXOev9lhpnePVaFXgzzZJhg?=
 =?us-ascii?Q?Y7KdP2B49R+9sRyslT0BIhfyMweJVba9mZPEV4wCw8tFUn9HXsd2gUbZbKSo?=
 =?us-ascii?Q?OtqOss7mfrsFUZa4DSRD4wG1uurnqyVCqV2fNeTECSGEPmYi8lvuZWk/luUz?=
 =?us-ascii?Q?CEO0JaqjLwcK4SM4SIQP49IdcvjVfEkRUuBEgKpqRY6F1r4Xn2XnhrbD1sCQ?=
 =?us-ascii?Q?krncdUkyty36R43o+IyHumTHNTtECwbVS2oFMZkGAO4sonfaTyX30tKrf3g3?=
 =?us-ascii?Q?d6jSCuTLJ7C9n4XzOcDTw0cGx0GLIl3m0HeEf+LNMCbkryKwCeUzpo16b3II?=
 =?us-ascii?Q?DQQ3qkUniJ8Dh6IwuWiR9zNkTa9IwIAH5jESVAIkp0ffZ2GQayik8v5qo3mY?=
 =?us-ascii?Q?iMMo5hVfcxBKf5a1w3wDWd1JPn8UZph0ZOhWBj7Zs8mhVDv6kRNF2ewItlGw?=
 =?us-ascii?Q?IkSgwvJJ+I3Wts24ARk1y2TRE8ikNrM49pJWK3xJlhqqjkPxNeYakHXohAfh?=
 =?us-ascii?Q?OyvLsOsIcjCMQkY+7a2PqnAqj2CwvnGMunhYqLiLykC+Pe/D02zUib9SXMvx?=
 =?us-ascii?Q?seFQe1Sat71kpDT1hi3hEQmNjHPxf814D80zEqQhotLIUGXhl8U5u2f24y+T?=
 =?us-ascii?Q?97NIOyEE7+9fsuR+18tz6MEFB4oOpvTI3muSxrlzbu9LbRucEoxWS6e72mat?=
 =?us-ascii?Q?rvW/gQqKssfSOqb+J0B76yZ2dkj1hnzZIUNCPEZbmhAbvU4ZXNpCWysDN96t?=
 =?us-ascii?Q?w/I14HvXv2mV0Mwkdtev3jA7RJqvKCLllLavwEwChK/htEfkmh2EtHNQaLmr?=
 =?us-ascii?Q?UWJGIZ0SgsjY9l3CnPVj8mMG7WznaCrOgebvSfnv?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c3a527-c770-4c6f-d428-08dbdcccbd69
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 00:26:51.5581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCcMq2aX7vOWAiIx53OCXIzZjtTCwISx14oahd/4EsaR1zkQFVd0DyKCwyBzkP7CFrslEW2c0lcIuWE4+EC+vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989

This patch adds a new helper mptcp_userspace_pm_get_entry() to find out
the address entry on the userspace_pm_local_addr_list through the given
address. Use this helper in mptcp_userspace_pm_delete_local_addr() and
mptcp_nl_cmd_sf_destroy().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index efecbe3cf415..69733a1a5663 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -25,6 +25,20 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 	}
 }
 
+static struct mptcp_pm_addr_entry *mptcp_userspace_pm_get_entry(struct mptcp_sock *msk,
+								struct mptcp_addr_info *addr,
+								bool use_port)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, addr, use_port))
+			return entry;
+	}
+
+	return NULL;
+}
+
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    struct mptcp_pm_addr_entry *entry)
 {
@@ -88,18 +102,17 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 						struct mptcp_pm_addr_entry *addr)
 {
-	struct mptcp_pm_addr_entry *entry, *tmp;
+	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
-			/* TODO: a refcount is needed because the entry can
-			 * be used multiple times (e.g. fullmesh mode).
-			 */
-			list_del_rcu(&entry->list);
-			kfree(entry);
-			msk->pm.local_addr_used--;
-			return 0;
-		}
+	entry = mptcp_userspace_pm_get_entry(msk, &addr->addr, false);
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

