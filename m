Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2083.outbound.protection.outlook.com [40.107.7.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DA3C8C0
	for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bsaES1Pn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzLIRGVDWNjiKh3BlOVRypzG6Payt8tts4StXmMJwdvFEy6JldEEepsWGsLNAFeOl8KFRdYQrmnVD5/YigEtRDp5eP/mmo7ObpWtJwX8WhL0Vc9DF30QRURyI5yqryG0KP/XYwoG4O0fyifVOoLYP7odUt1vl+JcBzsx9p8B39gwFTb/JPx7xf8z4dQvY5+0ZRi+ubsu40UUjo5SyTKRKgBbpMeJjeXMDxEy4cTo7IpAfYjoP4mGQCcRh2zPTcn6dIx/wDrVQZgldVzb0fH8ciEqhFAtImA8J/I8tx8v5f7NqFmBAcT5uGh7Euxx7BWBo1Y8LVH1TJT61dp6gHN/9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pniVddLH6ts6xok3y2xfxjPsHWnK8WegizqVMsEvsI=;
 b=elv6m900NuXJkQIgOLLcG4NKx3LgfllsE31suovbAveTMZKwurVLd68mIllsTLfrMjZ/NSrqj0xyErFrW9JhITinN1XxFSxuTJfMQUI+1lqzcZp6vWv3IY6ynYjf1e3P11NL3s3Wm8EZe2Qpfv6Pzl3lqhJvkB+vAFqwWfNL1ArK77fHANjKMwQ5k9b1AAC06s62RPv5gYdKmhM67NmBOAchFiRWu3NkLtXmOdDcttwiVLGQQWcaL6udg8YtdQPxtncxttSGi2Xpnnoe0/D2TqVMAGsBB6W74xrQPBjfKC7dq7NsR0LjY0jUe/IeKoRBRf1iQYeQi9zSrqleUs1viw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pniVddLH6ts6xok3y2xfxjPsHWnK8WegizqVMsEvsI=;
 b=bsaES1Pn7k+gIf8Rm7W0zheqOFM2ajjK7aSqOjJHIELplaWsE7oB8gfL1IV/54nYVTtbt/jHsGGJIl2QcyM8yftgbQm91vAILA9VeEIpIR8KAKH79pzHlIAPLghP7tKe4llroKIhFFXKITg4TwkfXpxDmHASVHHvlKdEGMisyzE9PphOTGH09B3KsQuzwfcs1n+128q89mtfqXzkdoIzMKRIPEjFKKrSeDBzi624vdcjGTdFpbAmqc6TD2vytOf52Ru6cj6xcSSrHdjlaUEydDC+Al+eWHlx3wtQLNPSBiD5FJ9sZ2qFOOyKtSxGjkqSbCLo3MAxrMh4T8TpVwrfLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9667.eurprd04.prod.outlook.com (2603:10a6:102:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Tue, 21 Nov
 2023 09:55:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 09:55:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 22/28] mptcp: add use_id parameter for addresses_equal
Date: Tue, 21 Nov 2023 17:52:45 +0800
Message-Id: <1b88c444d9f914917aa2c37b0b5743024746fd0c.1700560046.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700560046.git.geliang.tang@suse.com>
References: <cover.1700560046.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9667:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e085be1-3489-4742-eb52-08dbea780e5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4jIaessf5y7w/MCxTv7Bpnj6Diftxj5M6g6yldYzOqZYJc/y+7cqNMoDW6SvB4au73uH8G4RnU6lMM6tN/SpZyEo2YdK4RV9uBGivEeXI0s9YJmKZegc59Z+mU3QFkTRrD9UYGuRj1H4eWUBbx2i/BR3SE0RVaeSBPPlTyf7HmNGZpJV5hPM0OchIYyM+6XEI7f6G1+CkofUg3rSFTWsloRNb/rjG9nbc9/qs+uonWj00q2r+P0F3DbAle81MgF5BNtiMp7Vnnpd+uTgu6eJlkLc97riiUp3smGBO/SDkFfrEXI/0AHKrTYhblSL01hsAUTRzELeiZq5hQZyyFYeipyMdjcQYvxZHhXrv9vFxxxKOgDdBPeEbC7PJZKf6N/iYMD6Dx67UbiCQk+AbX+4W54J522yAk3mF3rvGKbvbrP1VxFhxNHJxhdpuoLkvnTNyB5bA/QrLtMSLLRmNNzy/zKrPk9KFrlPMDB5KSzgh9tV8WFqiK7bh8MQAj318Bd4Ma/8yR95IajQXPPJCthrMG781bamULGWSNY7vGMFIwH8eOXy/5Bnm1kChT3d9WzH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(6666004)(478600001)(2616005)(6506007)(6486002)(26005)(6916009)(316002)(66946007)(66476007)(66556008)(107886003)(6512007)(38100700002)(8936002)(4326008)(8676002)(44832011)(5660300002)(2906002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1LaO/Jdk3MJtgTeSYM2nk/faw9xvqaLPWT+dXURx6k481TRGSlm94+zzCZri?=
 =?us-ascii?Q?hEKtkN7tWjtj652QYV5giF7ZCEvD1GlAt8I529/BzQ5AupXsENONyN1TGuB2?=
 =?us-ascii?Q?/EBklCZxonhoYSUSgRzwro5tR6apEZq2cijJBVm8WN6zO7zZGj+rG9E9MSHd?=
 =?us-ascii?Q?srZRZ79ISdIWk6TVYxAU7gvL3Qj7uaQXhPsXbwAoI7toXkWAwjwCY6Y55wqq?=
 =?us-ascii?Q?u3079gGI3wtknZralqjdC97w6z4i1tYV9xciutQ1jS6ahlJHxSXFQcAkucAv?=
 =?us-ascii?Q?mZAnZ43OSKLb63xEYxOaFxdyDKHaItk3YJXIcsu2GAPcmC9mMfehnImbEVNF?=
 =?us-ascii?Q?+UdHQghHbMBBn99jVo+iFR2dSZYHl1ab2eYkoWv1C3AZL2aLpdIIGTy4VygS?=
 =?us-ascii?Q?pJGMDgXmWJc4bx3n1KDOOEQyoCgtsffdzyEbj++FQ4oWaAUdU0UIGfcgycfT?=
 =?us-ascii?Q?WTH8ugVwtA45zhlFVCxEiUXj1L8a6Ml4+9pbz30lvgf4MWENdInk/c/nv3ka?=
 =?us-ascii?Q?Q4QoGbrFabp0Hhb1qfM3PbkvwErLWrEmovnanQXPHmcIL6cGpSbdyY1O0/VG?=
 =?us-ascii?Q?oIvkOeOJ7eISIlRhpz6gCOAeap04891UauW4gU8ld+tUmTefqHDMnU6XhZWC?=
 =?us-ascii?Q?rzwhqcaAoyMARZvmIK9TwbfWmrHDLyWhXalPZWhyWcgxnkQO9rzdJ0b59JMs?=
 =?us-ascii?Q?GCqUVbfmaVAjtUWx89oE8v3VqHWBpONJaJqSKQvxKxoN6/0iR2JzV0e3XSzT?=
 =?us-ascii?Q?SF0/iMH+iRQvapgVpiDSDeAWVExttFKWg094IWkKWVsW8gC3v7KzWjewtjnN?=
 =?us-ascii?Q?9+2ZWWDseLajiLLY/qqPf4P6SCt73UrUF8pvht3Fu2O0bC+5awTfLbqkgDDz?=
 =?us-ascii?Q?F+RFV3RMxhCA9zvEil4efTFJdBuwdgiNWQLEz3RZ08MlYMKWEvrdN4sPLjPr?=
 =?us-ascii?Q?/l4z/P/tWO1nGu+G4IqfryYA+85nbrC9mxehmGkML66KHonD9r2AhsoIY5yp?=
 =?us-ascii?Q?34/9B4u9skTDWysufR4j3lALgMmSKMBP0plnJ1qlsvKYQjrnIUWw8y9f1sCP?=
 =?us-ascii?Q?i6mxYmW6SnIbb0DX90KtFqCASDP2JuGkdjv1Aj6Jnq28Q858TQxGmgOAg8Ho?=
 =?us-ascii?Q?EqpFaidgsBia5k+eFF8vXaGRGDWHUcJQy5/0w5sVwqODeC3I+oq9EudU5NXR?=
 =?us-ascii?Q?dWUugaf6hDMVkh3cxPlOYfX2wn4LdzO3rCASy7PDonnsRA9qj4PcmyWH4lHv?=
 =?us-ascii?Q?cW92w2jpBREbSAOBWYTk0RP1i6WvKo49l/kYhK3usyIBh6u6aMMyyMd6nX2U?=
 =?us-ascii?Q?E82DYMFypXVGPvGDzWcOvtprWGedHNVDDV67Zr9NNaGdO5h/acL5Q16yq4eh?=
 =?us-ascii?Q?TB44FADXlhKkN6BQ5Sv7GDaSZ/+hMuqZSQ9ZZ+Kqr5eISpjUPCEsdpQB/OfD?=
 =?us-ascii?Q?YfAFxpQJXF09Mvp4qNdKpGkAtLhaGaK/KI0xBPR5fFxOY8Q3sUTvVttuL1bD?=
 =?us-ascii?Q?LUOmpmLM4hUaKS2dDruSvWXAWWJaE+5KYWaMGLlQOH+DWvFouG5seqVciGIA?=
 =?us-ascii?Q?K3PddLBjTQK/fTuC8/a/TkEWhz7X7xLvXTz/6yd9xQicZ+C6TVKbqZcGoUpu?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e085be1-3489-4742-eb52-08dbea780e5b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:55:56.6777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EonY/eIK5Wtq3bh0n4CF5uHCbGFbvhPFenVq2epz2g8G44WYqYGBYO/lR+f5xzHtfYBp5zXPA8v7eobXkK0MCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9667

This patch adds a new parameter use_id for mptcp_addresses_equal() to
test the address ids, as well as the address. This can be used to test
if the two given addresses are identically equal, they have both the
same address and the same address id.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm.c           |  2 +-
 net/mptcp/pm_netlink.c   | 32 +++++++++++++++++++-------------
 net/mptcp/pm_userspace.c |  6 +++---
 net/mptcp/protocol.h     |  3 ++-
 4 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 48ff7ce20890..77a0e859076c 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -420,7 +420,7 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	 */
 	mptcp_local_address((struct sock_common *)msk, &msk_local);
 	mptcp_local_address((struct sock_common *)skc, &skc_local);
-	if (mptcp_addresses_equal(&msk_local, &skc_local, false))
+	if (mptcp_addresses_equal(&msk_local, &skc_local, false, false))
 		return 0;
 
 	if (mptcp_pm_is_userspace(msk))
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 6bc1a6b5b4f0..6ad8bb2f32e9 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -47,7 +47,8 @@ pm_nl_get_pernet_from_msk(const struct mptcp_sock *msk)
 EXPORT_SYMBOL_GPL(pm_nl_get_pernet_from_msk);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
-			   const struct mptcp_addr_info *b, bool use_port)
+			   const struct mptcp_addr_info *b,
+			   bool use_port, bool use_id)
 {
 	bool addr_equals = false;
 
@@ -68,10 +69,14 @@ bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 
 	if (!addr_equals)
 		return false;
-	if (!use_port)
+	if (!use_port && !use_id)
 		return true;
 
-	return a->port == b->port;
+	if (use_port && use_id)
+		return (a->port == b->port) && (a->id == b->id);
+	if (use_port)
+		return a->port == b->port;
+	return a->id == b->id;
 }
 
 void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr)
@@ -110,7 +115,7 @@ static bool lookup_subflow_by_saddr(const struct list_head *list,
 		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
 
 		mptcp_local_address(skc, &cur);
-		if (mptcp_addresses_equal(&cur, saddr, saddr->port))
+		if (mptcp_addresses_equal(&cur, saddr, saddr->port, false))
 			return true;
 	}
 
@@ -128,7 +133,7 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
 		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
 
 		remote_address(skc, &cur);
-		if (mptcp_addresses_equal(&cur, daddr, daddr->port))
+		if (mptcp_addresses_equal(&cur, daddr, daddr->port, false))
 			return true;
 	}
 
@@ -205,7 +210,7 @@ mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 	lockdep_assert_held(&msk->pm.lock);
 
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, addr, true))
+		if (mptcp_addresses_equal(&entry->addr, addr, true, false))
 			return entry;
 	}
 
@@ -222,7 +227,7 @@ bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
 
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &saddr, true)) {
+		if (mptcp_addresses_equal(&entry->addr, &saddr, true, false)) {
 			ret = true;
 			goto out;
 		}
@@ -463,7 +468,7 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
+		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port, false))
 			return entry;
 	}
 	return NULL;
@@ -704,12 +709,12 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 		struct mptcp_addr_info local, remote;
 
 		mptcp_local_address((struct sock_common *)ssk, &local);
-		if (!mptcp_addresses_equal(&local, addr, addr->port))
+		if (!mptcp_addresses_equal(&local, addr, addr->port, false))
 			continue;
 
 		if (rem && rem->family != AF_UNSPEC) {
 			remote_address((struct sock_common *)ssk, &remote);
-			if (!mptcp_addresses_equal(&remote, rem, rem->port))
+			if (!mptcp_addresses_equal(&remote, rem, rem->port, false))
 				continue;
 		}
 
@@ -884,7 +889,8 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		entry->addr.port = 0;
 	list_for_each_entry(cur, &pernet->local_addr_list, list) {
 		if (mptcp_addresses_equal(&cur->addr, &entry->addr,
-					  cur->addr.port || entry->addr.port)) {
+					  cur->addr.port || entry->addr.port,
+					  false)) {
 			/* allow replacing the exiting endpoint only if such
 			 * endpoint is an implicit one and the user-space
 			 * did not provide an endpoint id
@@ -1022,7 +1028,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port)) {
+		if (mptcp_addresses_equal(&entry->addr, skc, entry->addr.port, false)) {
 			ret = entry->addr.id;
 			break;
 		}
@@ -1404,7 +1410,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 			goto next;
 
 		mptcp_local_address((struct sock_common *)msk, &msk_local);
-		if (!mptcp_addresses_equal(&msk_local, addr, addr->port))
+		if (!mptcp_addresses_equal(&msk_local, addr, addr->port, false))
 			goto next;
 
 		lock_sock(sk);
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 8494d6df866a..06fe6c65b4f9 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -54,7 +54,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
-		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
+		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true, false);
 		if (addr_match && entry->addr.id == 0 && !set_id)
 			entry->addr.id = e->addr.id;
 		id_match = (e->addr.id == entry->addr.id);
@@ -105,7 +105,7 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 	struct mptcp_pm_addr_entry *entry, *tmp;
 
 	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
+		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false, false)) {
 			/* TODO: a refcount is needed because the entry can
 			 * be used multiple times (e.g. fullmesh mode).
 			 */
@@ -145,7 +145,7 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&e->addr, skc, false)) {
+		if (mptcp_addresses_equal(&e->addr, skc, false, false)) {
 			entry = e;
 			break;
 		}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7441e3b9443d..d132a8d91d10 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -645,7 +645,8 @@ void __mptcp_unaccepted_force_close(struct sock *sk);
 void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk);
 
 bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
-			   const struct mptcp_addr_info *b, bool use_port);
+			   const struct mptcp_addr_info *b,
+			   bool use_port, bool use_id);
 void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr);
 
 /* called with sk socket lock held */
-- 
2.35.3

