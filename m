Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2047.outbound.protection.outlook.com [40.107.7.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997DAF51D
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="5JgSl8Y1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMDpKRHqgWPtn/7Xa9NBYa4hIY+HqP9pIg8q99Iggzt3AhFCd3OmZeasR9iPKjQlw8Tz4s6R0qqeBgC/otHGsaOFZw2hJ+hs0bewlGiymyKppa/BFYeWlaixdfSR3vGohOYW5SUoVFp21G5iV0+0sBdMxPSqyOQcz9sNaWzpK9WHE1ubVi6/J94OwNcHoOyXij7L9dsybdE2Z82EN/FOl3QiKsHomL6QS28JbREUua60r7+qleN4RQQlMFx16mOH+sEinovzcAPHelhSnn8EoLW5yRJvQ8Oo7TnButashWgV5wu07E4rTL3bmIMJ0NFBEag1snQiJY39w+zRXpnqQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9I9BhsUgHu9NIyvVUommWpfzUKT8CPGIVlfQ/Lgp1ME=;
 b=STgyKjvPKaVmmjDhZare8TJ6QWE9++P2CVgoWpxI6CNHs4l4paiCQOVa2n41qOIcK/YkVokKcYonq1VYk6b+eVeD5ctFOhPCc6ZErvTz+xWc+L5jrJtYuN+RjuQX+iNr4lUT0M7BH9COibPam1ORaQ7Rs3TWddgnaf+SEmFQ9VPskwTJunadDdMICo+h7AUt68Glpe5hTNGk6KF1KYlHqU/N+rHCFZxwPRpXLj04SKJImLNjdrrjf+ZG0gqnP75K2s0AH0zKZEaeRPw0Mw/RRB3Uyc91Bwj4IkhTQ1zCOwuX75WVnTw1arVXtc8ErOZlTd6gGoStNbbwsZKXucwk3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I9BhsUgHu9NIyvVUommWpfzUKT8CPGIVlfQ/Lgp1ME=;
 b=5JgSl8Y1hVw7dGXYz/675xh0+wEcCBA7mO6rdV0XWALeXf8sqsqnb8p9xNwtrbBUTzCYqBqTNzvTuJgF65Lawh3km5+gyaYZdgiTaprA9a3sp5cs2mNMY27xyGNUBFh5zTe8kA0ZjmyCGUwaJmufihS331lLkYITawsTBjuG5Eh8gc4fux7JweNTKwpGlHHt2bjlN0XEoGXbIg5diDipmdrKv4dFclxczWQ5S+MeohjwRpUoXvDDFkN3Xg+M3LgWNOtEu2jaNTfx8da5ZIg1wojeEyXncqaQ+62balDhoQyHmsd2m9GJDbQJO0IPrMVu/IbXy4wHJ3HCB4e6BYmFiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13; Sat, 18 Nov
 2023 14:29:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Sat, 18 Nov 2023
 14:29:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 06/27] mptcp: dump addrs in userspace pm list
Date: Sat, 18 Nov 2023 22:28:21 +0800
Message-Id: <2e615eb73216c3c5ce7e7f600fd4a6404fce005d.1700312872.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700312872.git.geliang.tang@suse.com>
References: <cover.1700312872.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0140.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f7c8ca-0e3d-4cad-39b3-08dbe842c70b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TLVrOIZAWH8VV+L9UyV0VoCSE2H7MqWPh/N1+TE0x5SWVPMXe5Shf3VOwQXWjnp9LfZrygzm+jSLobQZMdwvkDc4yF9jYbHbe2DgRXox3gmN+1xQU3671R5TKGQzoNmrYJC+/xKEW+CV+TbKXJSAYQlf2zXqVvlIdEfYVNgKraJHpoOMkkj74WeroA1qDd8nJnOokKc1MdAoOYnvFHbMNgpgpfldRQ6hmpWkBB+XQeOwL0RZexbP/ujGy0PvI+YOKOiIdSfZNDkCXiQmHA3G8c+BuPBl/2dNZCp8cVc66Vlbi2+gWmBzgUiHM42ye6ZXRiml0AEAlo5MLTm/AGw4mauiTN2BCeonixig/vMJCf25FSJCtGk+Mgbg3IGuO/gaaneac1/K7rcD3u4NspQTQNmvmIVuSq4GSPserB8dLSNEHlZ7LQBy+7R5CattsMoxCKTKDQVz+tQtLjsLurpF85KUh5HwXo15dyxJC3WSDHfbPV911Sndj80NYqfkjwSUldoBjuN1Dd4zxTgpKxiLbjr+RFCiWluFTG13FfToDEKBb8RusPTB8iDQIXQ+MqMh36A144tiBhW1HO4SFh7Aj4TEPeEuXNLOhwyDdSeOn7Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(316002)(4326008)(8676002)(8936002)(66556008)(44832011)(66476007)(66946007)(6916009)(5660300002)(6486002)(478600001)(83380400001)(86362001)(2906002)(6506007)(41300700001)(26005)(107886003)(2616005)(6512007)(36756003)(38100700002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tDISVYyE1uOuryBkKikBNNQ5h4vxE/IrkTL0trmNQXq8daLHZEEQ35Z2Z+kF?=
 =?us-ascii?Q?R1PKnXO5U3ImbcobUFC8B4KpizQmz4Wti3AwjCKkn5XrmCBN5eIlapedM5IH?=
 =?us-ascii?Q?I4L/zrkFvevWumgMC7/qXHD6RzOfxxfwD96Tsih5bSkMg+V+cE0oPQSIPug5?=
 =?us-ascii?Q?kIxChWxwxNLXFE0OtHJVKrgrzXcflX6FLQ1+SMMcHa1kifAwXjBx7tB8nbbr?=
 =?us-ascii?Q?O/XXjsEMdrNZgWGz6nrNahufHhCE6yzzHYYs468tvT2b1Mo8/sXjdj74dsVf?=
 =?us-ascii?Q?j3LQfDjqOvUKmrLbIlo/RphlYXZRdfOmvjP7bH6CGKz5lziVLNPnofNfAvl4?=
 =?us-ascii?Q?6AmagYd37Y+5GfcMkuIPu6FB2M9XI9LBWXPMK3WG8IQr1QOVZE70XEMxqwzO?=
 =?us-ascii?Q?6scWCC/k2wb0DFh88jtjlilyt3M9aL7rsE2lyPgy3cM+alEyA7ml2YpHi3fV?=
 =?us-ascii?Q?6XOwTJixOq/kw/C7G/nsQtFCb9RwbGFi2uU92UNViaOagjZGASXu4k8gNa9G?=
 =?us-ascii?Q?IUw0Mholpfebmhh84mduaGiRoyhoDBZRiv3R+gpS0bL9H9/VZrQR+6WLn8Mx?=
 =?us-ascii?Q?JwlD89+ZBZ4wKfNQiS7hms4ms4C9IKDCUvn+yaZaEp5QNwGAqRJgTeDfZ51L?=
 =?us-ascii?Q?5IWGuGKqMfDre05wwULQJYUw5x9vYRY3Im6SILszc4v9EHQGuf0Moaqnd2VE?=
 =?us-ascii?Q?/UxzNUXVoCuFIx62mrtqDDrTR4AsZW4kuVfhtjETLF9KZ/jbgB0ZCpZH7irb?=
 =?us-ascii?Q?qlRKAG5FcMuHKvms+V/9YdQwYZYR8zkovtBbA917pMycIEyQVcgda2iXCdsJ?=
 =?us-ascii?Q?koCM5uaKZSjqNci7iMc5r8m/Gh/dHwol22fkfFHtFlF2mfQgpiNa+jQM2692?=
 =?us-ascii?Q?6wMg43zgfSP8pD2sNQ0mMEJ1IFrohjgaNMltl9sIWbVAAmQsBlX0DF2UES75?=
 =?us-ascii?Q?dYCTSiWy38pFv3gbH003TXXrzALtn1dGXUneOd2PykRS7jf2fSr2snrf1Qww?=
 =?us-ascii?Q?RgCopwfrjlmXQ1RnVQVZbl6ZRhQMH718Yl7SNAuTDSVMeY4QN09pv+p3gkfd?=
 =?us-ascii?Q?jof2PAG2BcnYoPLBqaWUCxB4y5lEW6awxvFMRRKUsDrPqUzxBKuj1ZGGRP2F?=
 =?us-ascii?Q?NH51rPClaJ+YhyDdsdP6L37NrmyzNknUhlihCBZKm4o/DN1l8xziBWUew5Ms?=
 =?us-ascii?Q?B4SX4cVhuLUa2nBofmo3o2nxUPG6jffhocfUpp0poHAG3jYI41STt/v0RN1z?=
 =?us-ascii?Q?ywcFNv2px0YxAk+tgU/GeUBbytPHC9P2LMPNEBBo3qRUcHtD3US8CXYucMkH?=
 =?us-ascii?Q?eW1sKkrZ1EU6w/qin+erug9xJj7Mqq5jP4v8powW+5ctSPMFq8llpSysvDfV?=
 =?us-ascii?Q?kIK77FvpixDL+YfHA+Bi6ZGagFo/e5XzRYNYAeMlhqCQdBSvVXzRCX69bwg9?=
 =?us-ascii?Q?5WzXGAn4fBjPMifkjlxxgnTMnA6xyPTaVPA1yisTeU81r+khOv1BWcoiCeV2?=
 =?us-ascii?Q?1U767rv/FJbiphONn6C54Bn92QFGGXWM6+hWBcnYgmPjXTGsb32iAfH9vtud?=
 =?us-ascii?Q?9UOJ09Q/tEqI/1Y+aV2rDuOJybsmv9K+oRRS4vrh?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f7c8ca-0e3d-4cad-39b3-08dbe842c70b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 14:29:30.9212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsZEEHr1PDZwWuucAyMQ8p2kofkdYYxhBFUBzK1gmqJ0mtDd5HEVgZMFlVvDafrKEvlfFCODqYX/zWRUl4OteA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869

This patch adds a new function __userspace_pm_lookup_addr_by_id() to lookup
the address entry by the given id in the userspace local addresses list.
Invoke it when dumping addresses from netlink commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   |  9 +++++++--
 net/mptcp/pm_userspace.c | 25 +++++++++++++++++++++++++
 net/mptcp/protocol.h     |  2 ++
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4cb52df57ba5..08b4211fbcbd 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1673,8 +1673,13 @@ int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
 	for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
 		if (test_bit(i, pernet->id_bitmap)) {
 			entry = __lookup_addr_by_id(pernet, i);
-			if (!entry)
-				break;
+			if (!entry) {
+				spin_unlock_bh(&pernet->lock);
+				entry = __userspace_pm_lookup_addr_by_id(net, i);
+				spin_lock_bh(&pernet->lock);
+				if (!entry)
+					break;
+			}
 
 			if (entry->addr.id <= id)
 				continue;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6999296cd5db..5e45e36ce1d3 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -549,3 +549,28 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 	sock_put(sk);
 	return ret;
 }
+
+struct mptcp_pm_addr_entry *
+__userspace_pm_lookup_addr_by_id(struct net *net, unsigned int id)
+{
+	struct mptcp_pm_addr_entry *entry = NULL;
+	long s_slot = 0, s_num = 0;
+	struct mptcp_sock *msk;
+
+	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
+		struct sock *sk = (struct sock *)msk;
+
+		if (mptcp_pm_is_userspace(msk)) {
+			lock_sock(sk);
+			spin_lock_bh(&msk->pm.lock);
+			entry = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
+			spin_unlock_bh(&msk->pm.lock);
+			release_sock(sk);
+		}
+
+		sock_put(sk);
+		cond_resched();
+	}
+
+	return entry;
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 88f5b422f941..c30e59278080 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1021,6 +1021,8 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+struct mptcp_pm_addr_entry *
+__userspace_pm_lookup_addr_by_id(struct net *net, unsigned int id);
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
-- 
2.35.3

