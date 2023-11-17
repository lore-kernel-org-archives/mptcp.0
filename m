Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595BBCA7E
	for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MOZGP3wJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnsNEJhZCterNepSthtbJ156S2A2zQ5uLCjvipTdc8wMd4QUk1sjaThI+pYXdGn58J7gGm7DADhvZCFK2tDv/KIYmjKCbMQW0YWYEQ6eM28gaPRAQjtK39xlVf+21FwHIxAjY0rIcpCHcv0tlQFC3iZ1UQw9qv/fMnfieMeCgeaFM/65KnAUBqGHalY8kitPUoUjHMqA9Ww7AdtA/jL470Cd2T2s29v4fvGeGuDIGl0kHGrxYwUQ58/GLU2KWYbhHj+8D851zlf0q9+QVOle2vf47JfjwEno+YRvs+K8P78+TpWhUYxhafiHULdmB0l8O8Fded85a7fhIcq0ZlrKuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFu5NR5fYWXwtw4Q2nfrmDukq9pre3TiGE1SzTkbt14=;
 b=gE1gUfIH5GduN6Do29C8SZuq42aPpy0LKyhpesp0+BH9RC2cpUO6xapSwDqDBOaS1KYIFAlSWq8qsjVbow5ZsDtJ4Q904yhMukdyvTXhjomBZGaZX7s14sM6EGLOuAC/SLbnebUtyZq+DbA+krRvGYdTNb+AV/L8zIg5vVzurEmYOtAIl8DI28LFGRBfVt1jS4riP2IjhM3n/Tsv+r65cDwWG7M3arZWWc0+GqjoJv7SJibT8VTmgMq5D21T5kQCicRk5i2TFL0i+QmTpks/uSemI/GPQQkNZN/PgSAStofbWkusm/qk6WOMOfNNtbkp2uJjaM2jqYsv6w/H/m4Ipw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFu5NR5fYWXwtw4Q2nfrmDukq9pre3TiGE1SzTkbt14=;
 b=MOZGP3wJ9Zv7NGJYL6Q/4UwpJ/7HtVhm3dcZZWzoLlbKTgSCm32c5Bsis1EkDxY6d3R1cRFj+2tqgoRAuijKFodFvoMwQ1iVMy7FMitnRcZeEOY92JEHSQO0Ggp4+yAWYXQUyEMH0Pm0ppamiqI1ZoUz977Y9pNZcWyLllnFTogbC+l5id018++BtAQapzq8gtxmIkvNKGQAe4Om5furkhdhs314EI4Nw6kgM1ZZWxDVQ28toevs1gHDtV5kJ6ym3rWCLKpf5kElo85VcyzgXcilySJIqty2VIhtpY2GjzNrxuvg6fyRGcVsX63V5QJNHjx0wjgO7JEnbZFiZF17Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7271.eurprd04.prod.outlook.com (2603:10a6:10:1a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.8; Fri, 17 Nov
 2023 08:56:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Fri, 17 Nov 2023
 08:56:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 04/26] mptcp: add userspace_pm_lookup_addr_by_id helper
Date: Fri, 17 Nov 2023 16:55:57 +0800
Message-Id: <840c715ad90c9b288534f18b2fcbafb62df1854f.1700210966.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700210966.git.geliang.tang@suse.com>
References: <cover.1700210966.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0199.apcprd04.prod.outlook.com
 (2603:1096:4:187::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBAPR04MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a4b022-7340-45dd-ce96-08dbe74b1ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fZLKxczMWZZrKIQRb6yfRR/CJOVDfjkm8+jk1vNU5ank9q3oft877CGBd50zYvG+bGMc7oNz2sODZn77ECDctZd8+2HeFes8ngY2I+bE6nk1Re6peaBOv2gXswVtoNP+ul335pXTXelH27cI3OyBlGP83xXsEil5Bi/1rPvlQG6ttxpHHz8Erghn/NfKc9JWngAqjdqSTJkn9wZSTsQc7UBAjgKenPYo6If9lJdIx/y+IjelyKkGUwrVWCoBpIVd7KHbmmKr53eQMn4Stt9Ed8n6mRtpno18/i6FFOVLRWXsdNdfVRudSiO8P0H8g8LAw9ouNpXDzcXtFh1atNOE1yfYyd8EJI005mGeqtP2/o+Ep+QMJzQcBhHtZU9vBtQtmQIshuQ1sF029IFBFlKtKT32tzbWHZktpa4eyrlbm0cdrWJNyDS2QxqJS5OG4B8345KZoaYMFdz7fmd3tlvwN1sAecvwAKIgcpRaL8OAd89KnANnP/SjxhW+bxI0zi4krMnFzfojgL4Z3bbjPPfAULsoF9L/2GCgRt4UjmNumYe11dsfOMD47j9ER9E1W7sZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(86362001)(38100700002)(36756003)(66946007)(66556008)(66476007)(6916009)(316002)(26005)(107886003)(2616005)(6512007)(6486002)(478600001)(6506007)(6666004)(5660300002)(44832011)(2906002)(8676002)(4326008)(8936002)(41300700001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x5V+IIvEfMV3V1JZRUV/NPUSUrFSRJlAAUpEsyx/bQS9Jo9jNGZBq/G+NwK/?=
 =?us-ascii?Q?e5tePpJrGW7cp54D6dXYqIstdq5fTpBFKc8rEo/MEX8E+/r73LanCX1LU8Bx?=
 =?us-ascii?Q?SGClcgx0WaDNw/h2W1glHW8fqTpFjxzl6FlffLU5J6PnU7DwBI/D24zzUHSq?=
 =?us-ascii?Q?DiaFTW5Rls7GOr+BeG3LTTX4AzcMK2VYbtH3aICazoUyyfgnAzlhi3/bo7DK?=
 =?us-ascii?Q?IcMXLJ+1zM+BVP8sBloJEzdLEsq0H/idh/t8y3RsW4MjL/WSaBrlw/jtTEIF?=
 =?us-ascii?Q?hTAkwBEk7TsxLKA7cV1oiKnL4pQtWMKu+rsgI54yL1nU4KlAlJps0XRgl51w?=
 =?us-ascii?Q?H19CPeZgrnSsfZqhtcgao8Yywx82TnShv1X4EDYzPhoJ6TQyjnkW/EznDGF4?=
 =?us-ascii?Q?pML5t3KdI46rJY4MqQ6/+JCocNg2C0xF20a/oD2Hpy4XVdfXdtm8SkrOGPej?=
 =?us-ascii?Q?HOBfBrHcpjnA9ljv3mxB3gbrXwXCGg6/je4qratvANl2rMENYs2qbcoQvSFx?=
 =?us-ascii?Q?Vx7U/6nSn/5M+rPyGXQ93v8GxRMrpp25qAfEfStceivPSgWXaVqUfmScxkaS?=
 =?us-ascii?Q?dqHeN2yoazNmiuaGGceqkLsXN2UoLaYeeQrFbf/UXZIW1mkg14bTlaQ3lgFZ?=
 =?us-ascii?Q?4RrgV3JkfTsM4FGiF7cF/dZekkpPwvjan/ZjQwjQb5XmzMXPa86bz76hAcht?=
 =?us-ascii?Q?QHJFvi4Dqoh4kHRqdf+/rDsUyjVLi+rV5a07OvZJfN2T6AkhkqEPINfPy8Mn?=
 =?us-ascii?Q?2j0DkWigL6faDMkLE1UStPnFLGy8WBC0WS5ziJOpRR0yysMCuIlwqlAn4J+B?=
 =?us-ascii?Q?s0eRmpJlFBUFueFySo0lU7Y8SQgTxtiBU6CWY4AlCs28ISm9dsCFi0de4gfR?=
 =?us-ascii?Q?0m3rdGgRbalT5iovhaMD/EeimCwDlUoKDnxjDTWcbM5hPBQIElA3HeaDiSBo?=
 =?us-ascii?Q?62IICLHuLwyEO7P4i8aPEAJ1iynIcq8dJMyQPiltyahKYKLEKWhK2TzouB+E?=
 =?us-ascii?Q?klb4N0wyVxEf+B6DajS97AUi0XGsz6fiXt91Ihya0shfJ0mbPPfrEaGXgGXI?=
 =?us-ascii?Q?LKN4OhRE7RLDuJPjIw6IqiPXsIrJa4mG4KC7zVNE43+DkoC9wAWSPK1gZKhp?=
 =?us-ascii?Q?ZC6fFq58eEEBAgzWHppiJBWGQ9osT3UMKFttUakO+fXTmDneiEbbBzmdsV0n?=
 =?us-ascii?Q?EzBkGGqzzk4sLaI8hrcMXnJF767300iaarIR8fplAr4prxQ3g1o8NfA2UE0u?=
 =?us-ascii?Q?7GUPnQuVwmc5xM+TdbzFoqRlSKbDWLNIzFID3q4P2iNWxdXPAhMiB/SBZyxa?=
 =?us-ascii?Q?GdMyXoJIzTeuxj/rK9BXDmRa4oG9I7dFHwmKqoD60O2dMuuzE9qsq0p4gD68?=
 =?us-ascii?Q?GgeN4x4ozd6OWxBXD6G5/dFFjyqtvJNdVKNbv5kDBhLdZZgkNdqMhFZ//o49?=
 =?us-ascii?Q?AeKbMj6OXSooaiUFL1dmtSGgSS+BiSjGbItE+Dlh3ND/G9VWo0X9f412c3sP?=
 =?us-ascii?Q?Rx691WvcwsdXuHD5RaA8kiojW8zlu0fSHjAACSkZY5LWq3RA5THgDbyhMUq0?=
 =?us-ascii?Q?h/a+ROTtUKgqWgNARgNaKc+8rITXOp2Hx5mVpKA8?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a4b022-7340-45dd-ce96-08dbe74b1ac5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:56:36.7468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7aKYEiLDSFcptgT/gFIn2fA2UWaGch44TqQGfvD65k8ZnumT+62RiIdVfhE3Oqas5YpE+NiOnRVuWFBls8coA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7271

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

