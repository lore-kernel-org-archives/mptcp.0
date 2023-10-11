Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF101A711
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="4lHzcXLD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMK+zTt9ZVvZPI2boW/AMBxxUtH3hgVldGLpTym8CIOdA7j6A8zVN+Ve5U1Bw58DVOboA9uyRISufGqWHWenJJFSoYecfGzyd+9tB+TDf/MQKSFOfCI4DqOHF24+qFZaOveeEPLJBgu8Zyt6p0eGKRD2F+hLaAS+ii99Yiec40udwBhAQiKlVMUv6Wi844VQcDo/0j99OxOy8/AE3NWBtUXifODnG0deUmaIa4wgGreHKggKaK6nHPVD8q7rA4rUy7/MEY3OdibXszleCCP6GqPcKeYujWCr0tE0GcmvBb9hK3lXm42mWQDjeGE1x8Kg63pHMacMQrY/5EWhx0mb3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JF9SqZpDHJjR5kQXzGZWWiFtHP5q3yVGiq85xPy6jr8=;
 b=AHHtdByv+OV2DETO4XcrnDDq23xJXC2U4Ij3FSTu7f2+D7J2SAAD30JWj/jdTVBOL3GrlsWF4hk6ifL3JkXNO3Lgk1dLdArsbw7xozyEsN2lYC1n4bhR/cxk8Nsdl1Iy2GTRN3e/00YxvFvx9mMHa7ZyprBxbzN0g/te3IowPVyppPX1AQ3yW8YYYMtOqkPMiA353PwbfQvZgeLB9h4VR6L1O93IRsmmDR0ES7cjgSe2LTpRNpOLYtvlF5EM/3MTaomZtw45Bp+FmILGfA2ZTlLDJopOv1/5tZIXlONSf0CKWSYfCtcxeCD0+hbuSGMNlMqDsGDJob4vqqvq3z6C9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JF9SqZpDHJjR5kQXzGZWWiFtHP5q3yVGiq85xPy6jr8=;
 b=4lHzcXLDQ+Rh117FlgE1N9kw8RGOkVCx1EErHX+LtRNfnRLhUSCiUhlisklw1gGySS577EoOuRBR4KIOyZkB1YJFO/Bazs6CEhfz9o5iQnL4QSCsCKp/0i6u7RBLtzSVeinAkb1ePQV8S18EYtAqsU2JrMs2kaeRB6xEdcSU0b1Iz8lpBI3lpV0Xm2F4oqamYudOP+pwBcwuRvTDkWefczLN7xsWDySqIljwwwlHhPyj0pPxThatdIjZUo6xUHdkzu1mYdfa7q4OYiKo2VhhbnSOfWZ38JvFsRzE1mj4FLs68xaLcHm4QLCnjdvGU2ZjSR5WBAhYPxJspyp96SteXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6960.eurprd04.prod.outlook.com (2603:10a6:803:12d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 11 Oct
 2023 09:49:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 09:49:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-net v13 3/5] mptcp: userspace pm send RM_ADDR for ID 0
Date: Wed, 11 Oct 2023 17:50:27 +0800
Message-Id: <e373d76fbc89cb5132d363b65904fc207e9f959d.1697017655.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697017655.git.geliang.tang@suse.com>
References: <cover.1697017655.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0139.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: 99b03555-b517-4d00-5324-08dbca3f63ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4A8x1u8g+x/tcP9U45BOpRSUI2y4wgwst/cY0snzN6GdGpyyHCCNurg3qtjNHOMJhQJ02sdp+fCxb4hLLTYEvmbI8q12KpmdqMEXp8UUnCD5aEmOY2a5NVmnNY6uYUpyAy1bc9NeX3vnW6JYV7hSbUSjr4loKHXfQ50JJw+V09MSPTucGgolmyssf4Ar2zM8PksZA6fR2wKbCtdif2vZP73PKO0fTutkaJzZyvGWv/wCeXVh4F17QUqEfBHym1OMiQlr+HkO8Dy8D1L1rdj9FsrKawowdaGX3xDKNogg4cA0+f9a9DPrSsaMBc/NdOh9G1lbIX9R1xE7NL2sDZvTXb2hcYkwERbccbMCV9hSRbURjhAzkr5BVPclaNmyZ76u1XjR+Bj2XGzoKaN0pJa3OD2WSaXGE7XNVHEJ5gpd1NYSHXbdL8S60Q/7OwzOSESXDr3ixi2kCXqBNw2t3KMdTkP9paE8xws5PuT76WLcHl7ZR2yrj4agt8uL2YrtbOVAO+1456XXwYeloOuRqrlzE8IVQHFaUEvuc60IeefVqSmcrUWnKPOV8U78JlAhyarKhtPZVbIA0LefIj0RLDC4VKZFv2XwulyOyHxgH26D1UI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2616005)(107886003)(478600001)(26005)(6486002)(966005)(38100700002)(6512007)(66476007)(316002)(66556008)(6916009)(66946007)(6506007)(5660300002)(44832011)(83380400001)(4326008)(8936002)(41300700001)(8676002)(36756003)(6666004)(86362001)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nj9P92StR/MMBiciub5oZV/3URajudrkLCqlMi/AYxJGDNJHIgmlIa4Ijadc?=
 =?us-ascii?Q?fgYIz8pC9DbxJlwUlQIAc0vEqO7D04zQ/gHlTHnEhGm4Rp1fNc6C7Xp70bgY?=
 =?us-ascii?Q?hgaX0Th8GCOAAHYajXtKFFM/Vdl0YcHfSfyEA8ZWLILckdOBAuU25hflgpkW?=
 =?us-ascii?Q?khkO3vZXNvDuLiK7BmPdDfbDIkcjelWzybbEif4kmPwRpPW3i7B4BugaUopz?=
 =?us-ascii?Q?VHwJj7VDWR3Q6nJ1AEOZTlK1cdFQ6It2PaK4D8Li0l4H6DoJZ7aXX/maV/CQ?=
 =?us-ascii?Q?O62fbb0YHHZdDrak5/3XltKQGtWkpzh4ZfQZqlh6A4uyr2UTaJhLqb3BLb/e?=
 =?us-ascii?Q?gmTzk71Qh8fiOYeehM84cyGOOalM/8PSuwn+93urVPoQzP6DijFYovY37My0?=
 =?us-ascii?Q?MJovP+apuuci+aG30nFL3Vz/A2N8Q0cCiwWXKZtqb5sx30NY5Ee3UA+AQVSD?=
 =?us-ascii?Q?7/cuT5/ZDBQ6tpXdXI+IisToNppChXbgKaqDF6sY+Kv10R470/7kijzllZdi?=
 =?us-ascii?Q?+SnlViLAuEUeyHsrA/5jhm3t3Rn01PHnFntagrLf6VSLyaggmWrmO3MXmKDY?=
 =?us-ascii?Q?laXb3Q7y3qRTkX9NRBxoBB5MwRzwJdKzn7DXROlKfdTn2OXP6VXBbXE50VUZ?=
 =?us-ascii?Q?G7vtK8RB7UiSCrWQ93lExj3F7kODgm3GEDsKl+qP6KtrDObDgfc3nnaQs6PH?=
 =?us-ascii?Q?sdWznG2v5MpF7YnqwZJkSSt1m2OxEIvrjztcHhLu1s9oBt8CmdoqJrJ3PLVe?=
 =?us-ascii?Q?L5xCeb0ujRRE6NgcEKYYc7UwwWGG+oNIHjAH/IiOJUIef3Fngn3PFyrZhSCW?=
 =?us-ascii?Q?zUSseqvx1vmANOREazUHUTdxU8UE3WVXmc//GHB1LPGdcst5fmlZZR6dAxL+?=
 =?us-ascii?Q?6cfWqlhEBPG2SnV+CD54KtpQrL4fJ5S/RLJxD2HJL9r6fU/rCIygt72hHNxv?=
 =?us-ascii?Q?e6N3Rbsv9iX4wDqdj0edy2428Wi5UbMeN8y2LO27t0Un7ugUq0b5FKdMAQqP?=
 =?us-ascii?Q?CToFdy2PX/sS0CqoPPyXGRD+1V4nrlKGeSjq5nSJdDBIjXEXZ2L+FKQN+u+8?=
 =?us-ascii?Q?qf8z4nLvT7P4Xtq2fAyGFU1BXSYdogQ8x8laViTrmSvM0rZ35Wv47woYC8Mk?=
 =?us-ascii?Q?4ZTnOZOcYm0kpg836vrfJVUs7QU1kwXk9IRliZwLBQTHagLCDi6+EzG08PA8?=
 =?us-ascii?Q?KcbjHQEorJCrsFGgc/BsXqcp8pWfAozWPK+MS61bEk7kLL4TAzLhj5R0YWmx?=
 =?us-ascii?Q?HC4g1k03TSh8R5V8nz8UyD5vtdCcXXhkOJLxnW6TQrBYibN1j/dD4K1liDYq?=
 =?us-ascii?Q?P3vr0yAM9ej2aUFauTr314B8KQw5889PeXUV0gQJWGGVHcKUjtB/rOuflMzy?=
 =?us-ascii?Q?D//2mRQLcZ4Z9b9/XvzkZX07Cc9qhuuSJZfMHoKlwLNFDdkwPSsFMQUc0hMa?=
 =?us-ascii?Q?nIFRyRP0KN3nF/dIWaQ/+M4cvg1UL2qBf/EQN+rP36iE1njBqL2Yo9sy/A35?=
 =?us-ascii?Q?KxzQsO98rzUC3FCynk4Mm2d0ocJi5ySdv9HqcxeVNDLLTtXPqccvoLeljsKT?=
 =?us-ascii?Q?RJt+mTcPczjAzVTu5s327ezBISv0dcm4W8KLdhSv?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b03555-b517-4d00-5324-08dbca3f63ad
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 09:49:41.0275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ekqDrvOGaB3fENlS61ED6MrFwNVUStSZ5BW99F2vcbHXFpbKFj/IPwYhi/ktPYzc3uodM2JYKgVA2XwF2GI3qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6960

This patch adds the ability to send RM_ADDR for local ID 0. Check
whether id 0 address is removed, if not, put id 0 into a removing
list, pass it to mptcp_pm_remove_addr() to remove id 0 address.

There is no reason not to allow the userspace to remove the initial
address (ID 0). This special case was not taken into account not
letting the userspace to delete all addresses as announced.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6b8083650bc1..ea50e694125d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -211,6 +211,40 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+static int mptcp_userspace_remove_id_zero_address(struct mptcp_sock *msk,
+						  struct genl_info *info)
+{
+	struct mptcp_rm_list list = { .nr = 0 };
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	bool has_id_0 = false;
+	int err = -EINVAL;
+
+	lock_sock(sk);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (subflow->local_id == 0) {
+			has_id_0 = true;
+			break;
+		}
+	}
+	if (!has_id_0) {
+		GENL_SET_ERR_MSG(info, "address with id 0 not found");
+		goto remove_err;
+	}
+
+	list.ids[list.nr++] = 0;
+
+	spin_lock_bh(&msk->pm.lock);
+	mptcp_pm_remove_addr(msk, &list);
+	spin_unlock_bh(&msk->pm.lock);
+
+	err = 0;
+
+remove_err:
+	release_sock(sk);
+	return err;
+}
+
 int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
@@ -245,6 +279,11 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 		goto remove_err;
 	}
 
+	if (id_val == 0) {
+		err = mptcp_userspace_remove_id_zero_address(msk, info);
+		goto remove_err;
+	}
+
 	lock_sock(sk);
 
 	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-- 
2.35.3

