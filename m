Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925641391
	for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 10:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648029819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yhhM+11oJ5EtK3TQ7pxTinK0Z8NtJOnOpwSet9hEWkg=;
	b=AGyGUMu2esTnF28jNqwMTb2hVtF76LtnNFma1eOdka1tImFUJL8pUhLGXyL2CWT1qq6ihD
	jYozqyRoJbAjQXp5WtHzdcuFSeY30BRCWSgWrB97JFQLGy5jjtzhiwhLwYTDsgaq27TSUx
	gqloyUd/rw50jMbKaOxuS5uu2nViF8k=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2055.outbound.protection.outlook.com [104.47.9.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-20-XYPgoGbEPnabLZmHZFgkLQ-1; Wed, 23 Mar 2022 11:03:38 +0100
X-MC-Unique: XYPgoGbEPnabLZmHZFgkLQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBcRA5h2Ydksw+bee7BJpasCrCjl+xccBi4zzY6w5v2zWneOHQv+audLiory2ki65Xs+MXwNV1oAknPn3MGkGRURqxshZZ1aVp0XB4ViRz6IZvn6qgNBoZSe+AUpenJb9sePFJbyQk0CDCsQ4tLrA0tB48kn1LkhwsnhRvo/FaF2ffTR4lP1RSl9Kqk5YN0rl/KRf4v7T/YP5Flmc1r+XwygUedojrRlC8N3crvKrgM5zXvsrrIn2wd0UkoBVZWf/XAA5jHveSG+31G4zUcc+cgvqrm9qH/HQmpf+POsln3lvj0NVXSATymWt/t1NNFEkLGYZXCoG5c7HqTXGTAfzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9D/8EOhyV6wy4AICWHfGH5Hu3nhhKJGmkw1UbxlR8I=;
 b=H5iYC0L06r1AKdUhRnMxzna/c3/Fu14D9Zrp7tf4xodcS81oEwneEy97iHCBsgObT71ck4QkImigYMOkefafbtWCaTJUzRr40bRiFMeZz2fFHnVjWJSGNrOq36p/XhOo1fY6diqJLQtTZkzOqet63ZdHEm1wGF/tHMz1aq9NtFOM+aW0QuqFpF2BxoFg8COW1KF2gqIXqSyljwwmD4yM/MEXm+3ys6MqGFbmsHIb1xp4/VFYLiEBsoTH8ijxg2gWrZE68wLYdSJJv3RXoMNAW/sLLgCaYE7M9dn+MiCPj3tqYFFqzBxINxvVfkDsI+gYuck1zjgfn+1MMyHx5Yffiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB6718.eurprd04.prod.outlook.com (2603:10a6:803:124::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Wed, 23 Mar
 2022 10:03:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 10:03:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] mptcp: add pm_nl_get_pernet helper
Date: Wed, 23 Mar 2022 18:03:32 +0800
Message-ID: <44d42216864c1ec295ddf7098327fe5603dfc448.1648029714.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e68bfde-76f4-4673-3122-08da0cb464d1
X-MS-TrafficTypeDiagnostic: VE1PR04MB6718:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB67187008F37722EAE961B4B0F8189@VE1PR04MB6718.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XyrpwmRm+/rvMcKWV51nngj7mdPQNSjgAd4C1Tur10uKAvpweULePkYAnBVzKiea4Q1wRzUCIVa41XYJXfpzcnHkAb/5mBW1WFGhA/gbrkPe3Gj16MLonI0EDzkbwN/Jq9Tfo1J/LUOE4ZcmUSL+fJSiCw/PMKVejdBT6eoDh4KqUaVtUDyc3SDrIOzsGALFouGYsGru6GmxuOAwgwg+OPlPO4hNZfPr8uFNieGWH9ElMmQEHfeeS24a4A7upPQXRIbGxoPuWvj0bb8ULk4wGC7l4pDu9MY2oPaC0Ln7NiPp0tdfSLtdwoB6twNhWLU+fTLba56tmErxwNKit4ow/IknXUfXXIHsO68X/2dtdpzHvIsN7D1tG/P5HBj4PdIgQbVxp5ODo/orfZ4vY1jjplRD1zwWpdtWnMdFm3qEW9FCu9gW8fN5IQhULuKptOZeGd8fGNoZ6bNnVD93TaLrZNn+DosqQijwkJBkVzNtF4K4UU+F++FUVlGs8u3BXNEgE4/hUQPsDgONsJnKRp2rpxmSoTYjRGB825n/7GpxtwxtMajhKobBfrSmBlXR/DSSkwjlrX2ns3LvH51G0QXA+i4UWdWODz7O9J9Lu4O3L/KQdf+K68l+DD0yYqhOoho7PB3h11p3m3OU1byQ0Fas6qaB4PVwwtwdWjlMJ1w37urJoM+aRrKf9FtvGUIKvfnUR+KPK7krqt8qMhFZHGLW4A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(508600001)(26005)(38100700002)(2906002)(6486002)(107886003)(186003)(83380400001)(6666004)(6506007)(6512007)(2616005)(316002)(6916009)(8936002)(36756003)(4326008)(66946007)(66476007)(66556008)(8676002)(5660300002)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+yzOB3BvZi37hVNmD3NWbOrDye7q166xyy8Pyg7uU/O1IJmEOX52PAApYV4U?=
 =?us-ascii?Q?HLvd7OPxRHG2qxIjk4u2pqCvqJedOk240NBX7nTE4D5tyD3ISo/YL1wJI0Rb?=
 =?us-ascii?Q?InVf/27/hFX0MaHXo3KoM/rdRO25uXj51jjHB4ABTvJ4j2OmsZ1YMFs8Es/3?=
 =?us-ascii?Q?HIvPaOJ8S1pb9aBMZuyslx0+Cc96e74UNpZ9Gz8DEqZMAz8g8aiUgpUrApU7?=
 =?us-ascii?Q?aZrW23t3RKnChu7jGT7/ILVHx8lgwttzZTD5XtGp3Y8y4eUUmqXCHadzitDO?=
 =?us-ascii?Q?5HHP6DnWZmh9AiRrlNMxWOKP+iFr/qoUZkD6GrxU35fHTyaFQMgyjrDQ1/wC?=
 =?us-ascii?Q?U8NcaVGu3raMevZCBdTxQYRjIvtR07fMC1wPvutbXorPEHYITMBdkOj9/kj7?=
 =?us-ascii?Q?iJv9qdngTKeaHgxZEQE08RMB5MGaOR9pkX4fw9RCCSatFVMbzNaNKZd6oQEB?=
 =?us-ascii?Q?z1WXHcrVWTUqlaZSPf2QiEANUsQ79faCqp8K7J++jQlZI7ujwabuRC80wjtS?=
 =?us-ascii?Q?vWrEjAan89e2at9L2xYIrjq73yu6agX9ASBakcPvszvviwMQRLRv0jEgu1y1?=
 =?us-ascii?Q?I9+iTl+Jn6yv6h2IK1YSsNV0r73Wkmn/orwjCKh5sh2/LTbslzdi1h3bqTIi?=
 =?us-ascii?Q?grZluG0Y+izJkmMCLUZAiJnHvdzV+cC+2XXhCChKbQfHqey3NwU1231/D2dX?=
 =?us-ascii?Q?HIMB7yGRx7rYTYvxvtnxB1Z8gi5p38Im6E8treoCLWLXi2VGJ9ySCbD/z7+m?=
 =?us-ascii?Q?XgpQXhgx/fko+MYDBeSnxZ08VwUdZuPynMToTjJR9q1g11zpibmkGvm1xvuS?=
 =?us-ascii?Q?TFsa1spgi+/xxweM6Y1y7Lg+poIKPmYgEtJyWHWISkSf5Nfcb0RqtO9Ese6n?=
 =?us-ascii?Q?3rpIS80vPfUsrg6EZpYo/t1vAr/xpfIdmfWl5mrwI2q3pMb9VsWX4BiN4kGZ?=
 =?us-ascii?Q?CStLwmusileTRUcOwmJ9JNOWz3vMs9A5zuZ2j/9TPzY9JbD/WA9smK//SI+4?=
 =?us-ascii?Q?6Ju7HNNlWSfjjbG/OOSGI9c9vGKj4Ty6wVbB0IDhrxhx5po0eD2rhgGI2I5m?=
 =?us-ascii?Q?h8AAk3oKes0m4dgPyHB/cTqocePvsRz9qMaWT8W3JEAS1hpEkR5orM2G0xTr?=
 =?us-ascii?Q?FQ73WTzQ+7Qf8A1f+TN114e2nOyU90F1Q4KzoM5XC2RaxCXDp0ZQjB63Obfh?=
 =?us-ascii?Q?X5Xv8UTQBfsMXVfJtn8OsJW0cSrmNFOq05hxKpM5swg2cyWRCM/sExtfc6Bv?=
 =?us-ascii?Q?FU2hgi1VNkjZy02cqV+BE5sts4duJJWQL4ur/OrpJA8o0vnhY0ro8D5HLQoe?=
 =?us-ascii?Q?943yASyttnZ4iGY+K3K3T+jjtkNTGP6061zchFe8KxEhebYvLxOp4BRyoYoA?=
 =?us-ascii?Q?MaNf4vWx+EW4Ne/kY0PCP/wo/BD+q0cp69kRX8jo8MQ7aHRqnu4oBhPRBMMc?=
 =?us-ascii?Q?fbcV3la4/KL9aAWMAYwtFdpByHXy3OfZ4bFG7LQSvO2C3NHmgEPtww=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e68bfde-76f4-4673-3122-08da0cb464d1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 10:03:35.4392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TqcouM+OL5+VH9CDAYFuwVUEAf4T5SwfTOkbh/LbcULlqMsRGTrWBFYTK4Ry6q++ZrYDj5bgMXeOvEOxVu8ffw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6718

This patch added a new helper pm_nl_get_pernet(). Ues it instead of
using pm_nl_pernet_id directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c1f4befb1e45..0530e03d0fe5 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -55,6 +55,11 @@ struct pm_nl_pernet {
 #define MPTCP_PM_ADDR_MAX	8
 #define ADD_ADDR_RETRANS_MAX	3
=20
+static struct pm_nl_pernet *pm_nl_get_pernet(const struct net *net)
+{
+	return net_generic(net, pm_nl_pernet_id);
+}
+
 static bool addresses_equal(const struct mptcp_addr_info *a,
 			    const struct mptcp_addr_info *b, bool use_port)
 {
@@ -208,7 +213,7 @@ unsigned int mptcp_pm_get_add_addr_signal_max(const str=
uct mptcp_sock *msk)
 {
 	const struct pm_nl_pernet *pernet;
=20
-	pernet =3D net_generic(sock_net((const struct sock *)msk), pm_nl_pernet_i=
d);
+	pernet =3D pm_nl_get_pernet(sock_net((const struct sock *)msk));
 	return READ_ONCE(pernet->add_addr_signal_max);
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_add_addr_signal_max);
@@ -217,7 +222,7 @@ unsigned int mptcp_pm_get_add_addr_accept_max(const str=
uct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet;
=20
-	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
+	pernet =3D pm_nl_get_pernet(sock_net((struct sock *)msk));
 	return READ_ONCE(pernet->add_addr_accept_max);
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_add_addr_accept_max);
@@ -226,7 +231,7 @@ unsigned int mptcp_pm_get_subflows_max(const struct mpt=
cp_sock *msk)
 {
 	struct pm_nl_pernet *pernet;
=20
-	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
+	pernet =3D pm_nl_get_pernet(sock_net((struct sock *)msk));
 	return READ_ONCE(pernet->subflows_max);
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_subflows_max);
@@ -235,14 +240,14 @@ unsigned int mptcp_pm_get_local_addr_max(const struct=
 mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet;
=20
-	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
+	pernet =3D pm_nl_get_pernet(sock_net((struct sock *)msk));
 	return READ_ONCE(pernet->local_addr_max);
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_local_addr_max);
=20
 bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 {
-	struct pm_nl_pernet *pernet =3D net_generic(sock_net((struct sock *)msk),=
 pm_nl_pernet_id);
+	struct pm_nl_pernet *pernet =3D pm_nl_get_pernet(sock_net((struct sock *)=
msk));
=20
 	if (msk->pm.subflows =3D=3D mptcp_pm_get_subflows_max(msk) ||
 	    (find_next_and_bit(pernet->id_bitmap, msk->pm.id_avail_bitmap,
@@ -508,7 +513,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(stru=
ct mptcp_sock *msk)
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
=20
-	pernet =3D net_generic(sock_net(sk), pm_nl_pernet_id);
+	pernet =3D pm_nl_get_pernet(sock_net(sk));
=20
 	add_addr_signal_max =3D mptcp_pm_get_add_addr_signal_max(msk);
 	local_addr_max =3D mptcp_pm_get_local_addr_max(msk);
@@ -604,7 +609,7 @@ static unsigned int fill_local_addresses_vec(struct mpt=
cp_sock *msk,
 	unsigned int subflows_max;
 	int i =3D 0;
=20
-	pernet =3D net_generic(sock_net(sk), pm_nl_pernet_id);
+	pernet =3D pm_nl_get_pernet(sock_net(sk));
 	subflows_max =3D mptcp_pm_get_subflows_max(msk);
=20
 	rcu_read_lock();
@@ -1021,7 +1026,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, =
struct sock_common *skc)
 	if (addresses_equal(&msk_local, &skc_local, false))
 		return 0;
=20
-	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
+	pernet =3D pm_nl_get_pernet(sock_net((struct sock *)msk));
=20
 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
@@ -1200,7 +1205,7 @@ static int mptcp_pm_parse_addr(struct nlattr *attr, s=
truct genl_info *info,
=20
 static struct pm_nl_pernet *genl_info_pm_nl(struct genl_info *info)
 {
-	return net_generic(genl_info_net(info), pm_nl_pernet_id);
+	return pm_nl_get_pernet(genl_info_net(info));
 }
=20
 static int mptcp_nl_add_subflow_or_signal_addr(struct net *net)
@@ -1295,7 +1300,7 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct net *=
net, unsigned int id,
=20
 	if (id) {
 		rcu_read_lock();
-		entry =3D __lookup_addr_by_id(net_generic(net, pm_nl_pernet_id), id);
+		entry =3D __lookup_addr_by_id(pm_nl_get_pernet(net), id);
 		if (entry) {
 			*flags =3D entry->flags;
 			*ifindex =3D entry->ifindex;
@@ -1647,7 +1652,7 @@ static int mptcp_nl_cmd_dump_addrs(struct sk_buff *ms=
g,
 	void *hdr;
 	int i;
=20
-	pernet =3D net_generic(net, pm_nl_pernet_id);
+	pernet =3D pm_nl_get_pernet(net);
=20
 	spin_lock_bh(&pernet->lock);
 	for (i =3D id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
@@ -2159,7 +2164,7 @@ static struct genl_family mptcp_genl_family __ro_afte=
r_init =3D {
=20
 static int __net_init pm_nl_init_net(struct net *net)
 {
-	struct pm_nl_pernet *pernet =3D net_generic(net, pm_nl_pernet_id);
+	struct pm_nl_pernet *pernet =3D pm_nl_get_pernet(net);
=20
 	INIT_LIST_HEAD_RCU(&pernet->local_addr_list);
=20
@@ -2181,7 +2186,7 @@ static void __net_exit pm_nl_exit_net(struct list_hea=
d *net_list)
 	struct net *net;
=20
 	list_for_each_entry(net, net_list, exit_list) {
-		struct pm_nl_pernet *pernet =3D net_generic(net, pm_nl_pernet_id);
+		struct pm_nl_pernet *pernet =3D pm_nl_get_pernet(net);
=20
 		/* net is removed from namespace list, can't race with
 		 * other modifiers, also netns core already waited for a
--=20
2.34.1

