Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E6B802
	for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 10:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648032818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HyXAt3oktVwIu3ze/0LeqM/vhX+tFa1vEFT7CiUDc0w=;
	b=DCf8cNZkC9qj1GYx/2bB1tXQFyHUPM9yRXxtJ8/xLEQsLJmw1m2gc8Z0nLx+HAuJTXFnqc
	gezRTEOcroJXUoJGVn8R4Lqjo0sL1r8LOdsHoqLUl3TqPZZyUyClPxLMV1xwPRS8IJWlQS
	7w1blgkqmRL7SWBAMEjTgh4FnMDF3iI=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2059.outbound.protection.outlook.com [104.47.4.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-1a7bb3EZNiizs022WJidpg-1; Wed, 23 Mar 2022 11:53:36 +0100
X-MC-Unique: 1a7bb3EZNiizs022WJidpg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHDUaCx6njUZ4JDpVF5RDBU95aTvDee37oiXg/X9YegfDVYr27bkwJa6KEjZlk9OlPwvblApCsFUjFmUSjgPP25wb3JdNa2FIa50cuiiQODFp7PEheWrwURuti/djaEEbLlGUV3YHGXOekP30PKvpP3gfxS7PSsg+tKYqkmM4FVI8iv4wt4nKaaaRxt4ThmudaGL80z/mNCh1BcVYnPrpKLH9LLKZqZN5suN4AKMMJsGB6FGrtG2Y2mJhliaumDmhGuk9YZ1O77HMt6TWANd/5o2pzjpeL+Btx01mhhBN4477TN92x4GyHROY5St+NG0AJUTbw/YxzA7MwxwhxIh+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKY4edU257+JNYW7BuXXwSiA+YWylA6e+anGSPe5vAU=;
 b=RM37DR7BwEIDOwJocjOva8DcyMtJDgaI12en/EFXSQit5FDp4HeMDkH1F4EM78wDiaRgnpmBrj3XrPLA+AnhxaByNkPo/gm5lcgAsP8stDfgZ7qcO9BWIHNdK5Q4d/b9LqlbMpzmvuE71bnlDsVamWl1kZuESykLCnsK6RGpCz6JIRg6VeqapWhss+qo6lAKentLhLckSK19wBXnJjEdOtdcEL6XRc8yGL8r1BRcci/AidNWmnSeUySte2W4Z99s6DpE41DqaVK+IjUUsdnJNKS9eLlb2yGLXuj54ps/eTbs0l5N0Ui6w2pJuSv/e5VaKN+Z6WONJMWYK4GFvEIaLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB3280.eurprd04.prod.outlook.com (2603:10a6:802:11::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 23 Mar
 2022 10:53:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 10:53:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next v2] mptcp: add pm_nl_pernet helpers
Date: Wed, 23 Mar 2022 18:53:38 +0800
Message-ID: <60276cb27a70bf7c789700fad30f58bb26921585.1648030937.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0208.apcprd02.prod.outlook.com
 (2603:1096:201:20::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d27589da-4b52-4372-74e3-08da0cbb60ec
X-MS-TrafficTypeDiagnostic: VI1PR04MB3280:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB32805280DDE6D27446C10911F8189@VI1PR04MB3280.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tTYeRE2fsBeM454JBxPbkBKrOel8zdYaxRfzXieN9c+7NfUW4JJRGd84CipGG4tbZMLkO2OuOLT66FNhVGlycV3X/2O3TgOXhuOem5R+miVk3dZ9E2mTtrOwXqqxBG244cll5AX5CF9c4XGHc2EyQeMqzuQFVdQ3SPNPtXPglnNK5uq+rjyo8PKUMcqdfR1oKqJIJ4xsItp1qaMy/jjYddwOLz1tOgzjgrnBHMrMmyTiK1bwJxA0qSX6mHvd5uMyuhYETvjwFFXPRfZqrPJLV8LszNEtT181GndYVnQFBhiNyf1i7pXx4ynTkou0AcDUkSzHXOq0dTKIszWAbA9vVU82YNX9f1uOrhQS/C3w4FigkmJqvfnG+Vus2sLTh7Z7Np+c+4S73IKRoLA4b37s1IWjRJNNaPgHBWvErQttQu9TmYTySPYmR4jdezps/WE9zBGaEE0DhFrv/chrYy6J46caSzVbLnsQpKYdB4zsW2ROPJIxVBdjgqSZsxBh+FoKPN/3joQJxzYqY24eYlX975O9u3twp+/hPEuwFKLJCNNAIewwQj7VWihiThhH/fNssMfABHbfy1AbqkHBy8KUo6EsBm+YbRzE3b9iLwYdAt/820mW6m4mdEduLD7s2B6Q0pzJAC6ryQC3GHquqUA/zV2dgaIqXWadppIcA2DJxJFGMWsIYFa2kgtK54IEMn3jLkG5OqcpahCyx6Ib9OaSxQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(6916009)(26005)(186003)(6506007)(6512007)(83380400001)(6486002)(2616005)(316002)(508600001)(8936002)(36756003)(44832011)(66476007)(66946007)(2906002)(86362001)(66556008)(38100700002)(4326008)(5660300002)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h2lg0JUOuwDuQnOJZ/uMAIH+2bnL88K5S66Ae5VsDifd6v05mHEvErnMnsmR?=
 =?us-ascii?Q?ImTlRunmgrJruuRpG/o3EXalYptdrOzvszER2cvMFNNWL349Z4QwBarpye4t?=
 =?us-ascii?Q?8nayhkJ6Vyt0u/Ut+hjwyruV23fvOo/gtEkmbdeNjmUYI1wT3mYcymNeQ8s8?=
 =?us-ascii?Q?fFrDx0xBkwlORe6V/Yg1N9ZmpXuaMeP581wpLXojlgsWZfahmQ+4SGMpzALi?=
 =?us-ascii?Q?Ob4qxD90EDeYZGIuITVbPRh/LTjKTvQvVFgxMdQs9bz2k214kxm4g2TMMDHU?=
 =?us-ascii?Q?jB+W/tazxnVHs9Py4DacVm72d1ST4WUWslNfqbHZ3TsFfWiLHzJyqjh/Usgh?=
 =?us-ascii?Q?NQDoSlW4BXE3ZVpdamGi9KREK2JLvzIC1iv2772bXAvga5aFI8m2j6RQ6arL?=
 =?us-ascii?Q?AgZUpnCWvF7UaewG1ZUqQBmfWQ516DWe69NwFhEYpjKq3GBGCU4X5h9k0rOn?=
 =?us-ascii?Q?oX0stx23Tp0g3Cexpc7tJk9P0SqAzwqu4Dog3t+YT6X6bEN8MqEQUO5DNnZy?=
 =?us-ascii?Q?2ZUmlRFBl9xi/fOm+QyM7GJGXewY9DvyakejG+GvJQDXjwE2vYO0PBKBCsxh?=
 =?us-ascii?Q?pjcI4MKSOHaHUOeOnLklxFbFpX8BnGn6XK2eptVhKcquJYsseVQA4NOXmptx?=
 =?us-ascii?Q?oBW86z9dKAmhmR99jCi6yE/WkWfbLoQKIxCWNNOpSPtiiuU+5G64hYMBAv6Y?=
 =?us-ascii?Q?qESRm8RHUspryaVjgtN/CWIfJT9BqJREReEu+GnZJHcbw9d3wi9QOiKbn8o8?=
 =?us-ascii?Q?gc6U0n05EOUVPLs+BXREWtVkbH5k+SF1c0QI/YOtUsdZK5OJ59Nz63qByJ9r?=
 =?us-ascii?Q?fF6A92Gt1suMHPZp9AyL6drrsDoYpizsfzvtkmGXlt3sTMdjSsnBEl7UAPqD?=
 =?us-ascii?Q?JAVGrR0q6uWwd4g2gLdXvNJUaIhXcanm9n4jKrPq67WPAPU4BwP33Io8HK9O?=
 =?us-ascii?Q?PeJbCe9XMhzIyQSaWXK9I5dpuao453URD0rWjQ6UNSoOtFQ2x6hSRQs3mg1o?=
 =?us-ascii?Q?HLs1xKHFPR1ln9W27aLSEjlb0xJs7eK8t2lFRD4wX6xa51HH9baARXXmgo6y?=
 =?us-ascii?Q?1oQTJZTOB4YtOtmnlFYB1+4ziu6rFTJDyyfS7GTy8X8RocOlGyEwBCGDKgOz?=
 =?us-ascii?Q?fQw3cIMCB+3qtxnOxiq07Z3kzWTuIcIliJzBeRt0C6eKdwj/re38ngZDfnao?=
 =?us-ascii?Q?XyFvLa8ksqQCnfVmUuJsXWw5C8msDjt49nV+ibIiZu74RJ3XRlkJyk0w3uIA?=
 =?us-ascii?Q?v9Igha/QJM/NrUihlAAFEu1Pw7hfTJyiP1ft2Yq2fc01/RrH0mX3ZPV7ol24?=
 =?us-ascii?Q?l2cDxd6eNwuwMMQpLoDW3Y8K//mdJTAO40uo5NpdB3qOVcufNLPDidPlwq44?=
 =?us-ascii?Q?ZhJtkti1231KW3KbRHJsLZYlPQ4ymUiwxgZjFW8pChns1/iUg+doR4tXPyPt?=
 =?us-ascii?Q?eF0xpmOm6T1VJhL7oBO0N5Sd0FcO5OnAJzZb5rjrmx4wg2lg9T2Nkg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27589da-4b52-4372-74e3-08da0cbb60ec
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 10:53:35.5091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZR0fQE1aKXmmXsFcwSMjvtvrlB43XbTklky/Za1KvMW7HjjCHwhLshnPme1BnMmm8ipfyH41Rn2A1zfRHwGtBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3280

This patch added two pm_nl_pernet related helpers pm_nl_get_pernet() and
pm_nl_get_pernet_from_msk(). Ues them instead of using net_generic()
directly.

Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 v2:
 - add pm_nl_get_pernet_from_msk as Florian suggested.
---
 net/mptcp/pm_netlink.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c1f4befb1e45..f15ba942c36d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -55,6 +55,17 @@ struct pm_nl_pernet {
 #define MPTCP_PM_ADDR_MAX	8
 #define ADD_ADDR_RETRANS_MAX	3
=20
+static struct pm_nl_pernet *pm_nl_get_pernet(const struct net *net)
+{
+	return net_generic(net, pm_nl_pernet_id);
+}
+
+static struct pm_nl_pernet *
+pm_nl_get_pernet_from_msk(const struct mptcp_sock *msk)
+{
+	return pm_nl_get_pernet(sock_net((struct sock *)msk));
+}
+
 static bool addresses_equal(const struct mptcp_addr_info *a,
 			    const struct mptcp_addr_info *b, bool use_port)
 {
@@ -206,43 +217,39 @@ select_signal_address(struct pm_nl_pernet *pernet, co=
nst struct mptcp_sock *msk)
=20
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk=
)
 {
-	const struct pm_nl_pernet *pernet;
+	const struct pm_nl_pernet *pernet =3D pm_nl_get_pernet_from_msk(msk);
=20
-	pernet =3D net_generic(sock_net((const struct sock *)msk), pm_nl_pernet_i=
d);
 	return READ_ONCE(pernet->add_addr_signal_max);
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_add_addr_signal_max);
=20
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk=
)
 {
-	struct pm_nl_pernet *pernet;
+	struct pm_nl_pernet *pernet =3D pm_nl_get_pernet_from_msk(msk);
=20
-	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
 	return READ_ONCE(pernet->add_addr_accept_max);
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_add_addr_accept_max);
=20
 unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk)
 {
-	struct pm_nl_pernet *pernet;
+	struct pm_nl_pernet *pernet =3D pm_nl_get_pernet_from_msk(msk);
=20
-	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
 	return READ_ONCE(pernet->subflows_max);
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_subflows_max);
=20
 unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk)
 {
-	struct pm_nl_pernet *pernet;
+	struct pm_nl_pernet *pernet =3D pm_nl_get_pernet_from_msk(msk);
=20
-	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
 	return READ_ONCE(pernet->local_addr_max);
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_local_addr_max);
=20
 bool mptcp_pm_nl_check_work_pending(struct mptcp_sock *msk)
 {
-	struct pm_nl_pernet *pernet =3D net_generic(sock_net((struct sock *)msk),=
 pm_nl_pernet_id);
+	struct pm_nl_pernet *pernet =3D pm_nl_get_pernet_from_msk(msk);
=20
 	if (msk->pm.subflows =3D=3D mptcp_pm_get_subflows_max(msk) ||
 	    (find_next_and_bit(pernet->id_bitmap, msk->pm.id_avail_bitmap,
@@ -508,7 +515,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(stru=
ct mptcp_sock *msk)
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
=20
-	pernet =3D net_generic(sock_net(sk), pm_nl_pernet_id);
+	pernet =3D pm_nl_get_pernet(sock_net(sk));
=20
 	add_addr_signal_max =3D mptcp_pm_get_add_addr_signal_max(msk);
 	local_addr_max =3D mptcp_pm_get_local_addr_max(msk);
@@ -604,7 +611,7 @@ static unsigned int fill_local_addresses_vec(struct mpt=
cp_sock *msk,
 	unsigned int subflows_max;
 	int i =3D 0;
=20
-	pernet =3D net_generic(sock_net(sk), pm_nl_pernet_id);
+	pernet =3D pm_nl_get_pernet_from_msk(msk);
 	subflows_max =3D mptcp_pm_get_subflows_max(msk);
=20
 	rcu_read_lock();
@@ -1021,7 +1028,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, =
struct sock_common *skc)
 	if (addresses_equal(&msk_local, &skc_local, false))
 		return 0;
=20
-	pernet =3D net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
+	pernet =3D pm_nl_get_pernet_from_msk(msk);
=20
 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
@@ -1200,7 +1207,7 @@ static int mptcp_pm_parse_addr(struct nlattr *attr, s=
truct genl_info *info,
=20
 static struct pm_nl_pernet *genl_info_pm_nl(struct genl_info *info)
 {
-	return net_generic(genl_info_net(info), pm_nl_pernet_id);
+	return pm_nl_get_pernet(genl_info_net(info));
 }
=20
 static int mptcp_nl_add_subflow_or_signal_addr(struct net *net)
@@ -1295,7 +1302,7 @@ int mptcp_pm_get_flags_and_ifindex_by_id(struct net *=
net, unsigned int id,
=20
 	if (id) {
 		rcu_read_lock();
-		entry =3D __lookup_addr_by_id(net_generic(net, pm_nl_pernet_id), id);
+		entry =3D __lookup_addr_by_id(pm_nl_get_pernet(net), id);
 		if (entry) {
 			*flags =3D entry->flags;
 			*ifindex =3D entry->ifindex;
@@ -1647,7 +1654,7 @@ static int mptcp_nl_cmd_dump_addrs(struct sk_buff *ms=
g,
 	void *hdr;
 	int i;
=20
-	pernet =3D net_generic(net, pm_nl_pernet_id);
+	pernet =3D pm_nl_get_pernet(net);
=20
 	spin_lock_bh(&pernet->lock);
 	for (i =3D id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
@@ -2159,7 +2166,7 @@ static struct genl_family mptcp_genl_family __ro_afte=
r_init =3D {
=20
 static int __net_init pm_nl_init_net(struct net *net)
 {
-	struct pm_nl_pernet *pernet =3D net_generic(net, pm_nl_pernet_id);
+	struct pm_nl_pernet *pernet =3D pm_nl_get_pernet(net);
=20
 	INIT_LIST_HEAD_RCU(&pernet->local_addr_list);
=20
@@ -2181,7 +2188,7 @@ static void __net_exit pm_nl_exit_net(struct list_hea=
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

