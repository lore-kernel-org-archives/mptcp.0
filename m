Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2086.outbound.protection.outlook.com [40.107.105.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C960584FB
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SWKVOSOd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNQJR2+7vqZ2LU/T3uw/mYUZO+srlvKPO8coG7MzJUnCnTNricoKD4kVHtHHNeBQFiU6xaMMuf/bSbl7EOi/tR11UbxAn6/EGeUAkgxyKusXZZ5i/v/ZEmQK7FaFNcuUoZUfCcjRZr7vHA5u8+BNc2BDYtpytpKCkk9SSQWDZhV/O69HAThFR+TrQTGua4OOo3BIlhjpvhrrNvnoG5h4l5ytI4JtZGQCxRufMUmWVdFtTuGe2B0+aHkgk2chKmyR9zjSgMGrZAtuWWpcmQ6l0LJlLHaknUvLkJDuTv1WaN2KZSn+Ruiyf8ISHwQLgXFo9M5H63ZLxvPX9WzKoqbj+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sf5bQUbh5eEFZga+1M+nElTrKfqhdkRszfzsQuNXB3c=;
 b=ahGcGDb+PwF4JpoYIbmddC2i3phVOeQh1Tgdiephb2Zz+td6UmvzpsJbKVNxtcrdUzaDWMUP1frhmC9kAJMbJZWTRBRIOclhWqLvGIu9qz66U8RzSw6bL5BF8AYvnyoTSQPjPclp+BJht3Bv3aQmIoahlLGn0rXzFYGkQE7p2cYieNUpKe31Mf/AxpzCOITPKH15pln/n2xlrFxaA+dXXcBYARE1HvlFKsUFGND5mreo3mffPRTI2j10naJt63A710PydDSv7n4Vl3gBj6WNQ9yxf1F18E7sXmJuNQldwCk2Mi3rSfB2ckcQZbC9irfm8Vs6AxoomQa75MDdvkk1tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sf5bQUbh5eEFZga+1M+nElTrKfqhdkRszfzsQuNXB3c=;
 b=SWKVOSOdis/LFgzb5xbWQJzvqNKLsxOvZrDc5Vfn+4aE6y2ygT4I0fDMofULwuggpWWVMntbln6+KZpqelERPSACE/BAn5rHlOQOZWvC6rGjx/QjYfTFrAPCD6CJo7MfsXJ5vCJRedguZpa3UVPMiFkO1aHumWqZcodh7fHmVBhdFwEQz9+kUTdqcKEj8ltsv4fuXrRm+Plb5Ac63p7zcdinvUWxgI369O2M87qzod76w7hNoHoEw8rK++XuUVA0ZLWczkt5nA5MuhHBjzm5dGJh5FFnd+E/Eutjg9JgbixVpGdF6/zcMfNmzU4aeQP8E6AGUNgXNBKeiWZ4c9fvBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAWPR04MB9837.eurprd04.prod.outlook.com (2603:10a6:102:385::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19; Tue, 28 Nov
 2023 14:24:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:24:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 22/32] mptcp: flush userspace pm addrs list
Date: Tue, 28 Nov 2023 22:22:15 +0800
Message-Id: <8206a3d8e4a1e2b93362e2a7c7e23adc15194544.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0193.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAWPR04MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b3a598-be34-48c5-66fe-08dbf01dbc34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TlE47JzvX5pcFPpuYlb1nBu58fvIRSz8FSQm7uKN15N/Z89CNiXwToGwGOFLO2V7NtdegGXTMRtL/R69JKi/gzazgpMz9S+PxTs3NZJoiPQ2QXhGZRVW8FcDj9l9/zTzvTi4SL3g4Wv04Ul+mhm3OemZ3upKGv/CGwA9tSIniYO1RfAEwovk12pR7sHgq50P7lOJNpCCvvZQo/lu4LdFCDsaHts6VhgPK9FEn7aCxA4+M/6lKmU/o2ilrtOtfIfyUvuwFY3FLszIWkIUOyevaYqekd+j1yc8d8yNF6Rpvn4VHhft13DGbwgrx/bCJs/DpZvCJwtiCTO3kCc66xuCBA4/SD4zMYQXqZTeKvySktUBjfllztAckRx/Lbxw7KJvtJF8vTAEOoII65swjQfOXIzQJjacE/63c9nU/oqj4KcE+fKcgKjR3xLLAG6V0D/dsfbu+4UydB3u+4FO7FpsnKZ6zREDtFrJT8Bm2VwwtxDZIgop4GyUJG1ch1zfmouUnG2dp6kEzz6+clMT8QIPgi2eU32kq+gqKDRxkIpjaqeIndtH+htkeTC5yND23eGJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(44832011)(8676002)(5660300002)(4326008)(41300700001)(26005)(8936002)(2906002)(478600001)(6666004)(6506007)(6512007)(107886003)(2616005)(36756003)(83380400001)(86362001)(316002)(66946007)(6916009)(66556008)(6486002)(66476007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hPqhl5Hp5BOu2oWy0qbsytjto5Re/BRYk5aE1FscFwHtij4a6WGSYdu8E4dX?=
 =?us-ascii?Q?H9TC3igea8HJQWb9Pq67kHPrPGrw7n5lRtxjNUoA7jih0L5wDPj+sLcof7WA?=
 =?us-ascii?Q?IKqe4Vw9T+RnALZGqovNEjjbwDaU78UUKcR3+6PDYmpm7GOvykU0GEMpDu9U?=
 =?us-ascii?Q?lEmd+X5u+DFNB87suLJwNUTD1Xw6hF8oPRETyWbqoIFfeU5+dXzTD7ofR/nU?=
 =?us-ascii?Q?cPPUV/iKkOo4p/ECK1jISYz6O8BRREgRkaBGZi3xBkn1NDn81Uq9sQ5w7fjH?=
 =?us-ascii?Q?4Bys2m0RulcoK6DZEGnaJ04MYEwRbc9f/3KNQQjQ716RVzPOilFFWIhnE/ys?=
 =?us-ascii?Q?IJ65wFCKsi/hZy2OztP1kOyAIvW3tCkgvv5jyOX2NF9jKtGGhRvVHngCUWP6?=
 =?us-ascii?Q?bLJTLlqsK7k6hIeL+Bi72U1XD6TzeOBDYWcK8S6oGfk0K/iinchXMFMIf2m1?=
 =?us-ascii?Q?SGCDsg4PUsg3JbgvrdV2q5XctmD3Xt+aEOwt2bm9KD55i7wwtmXqoBk2M7iS?=
 =?us-ascii?Q?hsJ1He/oLkmIby5MmiB1Qgr8PRclY63UpPVvlz6XGviLDltprELcftDE4ITQ?=
 =?us-ascii?Q?umZwzeJMvHIuYiW5/OYk0uaPSWmTUlMmJAuUuEPGLQtUk5TISSHDDEPZVy61?=
 =?us-ascii?Q?k5G6HCzrShLhafBwRYWSarz7d0PQ3MMO9VOL7HAbmDZ7ym24kcd7Kpwg78Uc?=
 =?us-ascii?Q?ufY3DtvKcEABRaQ22Hxc6++7jlI0oomrjed7lsL8r+E2euldl7bcc/AoUI4r?=
 =?us-ascii?Q?ez4fTNe5mKh6+QQM0aiCvKDG+dv6SVc70ZzXvaQ6xe2j1tacHV42zdmULGgx?=
 =?us-ascii?Q?2JA4Y+xfme7jndNLbfTogPEw+IsDrOJFI7T/+ZmpOuJlSyuiz5uMsBo3Dfpr?=
 =?us-ascii?Q?QYR5fHI8F2fkwK7ICS1ZJFRFFZPhCqhA/bMmZGUesP+EFW9JSDe+fgqn/Y9+?=
 =?us-ascii?Q?NifXAWW63PskqbAUsjCwKyH6G3UJvWP/3VhJKfjtzvwG/BfeZLw+JaXJLJyY?=
 =?us-ascii?Q?lN/8joTMBIqQZM8MKoF614wfvBWREB8Juf3EWac8MhW08Mv1HHHPDXke3PtV?=
 =?us-ascii?Q?Wz9FA/dZX0n9YWbIqTLrVcUSIdhDqCyJPIT6oUOXGt7HDi8S5Gvyiqy/+gaG?=
 =?us-ascii?Q?Ro43cfPZOwSz8VMrXG2lNKpvrPZwV+pJNzfQWAWpyvf1VRz8GftoxCEKf6Re?=
 =?us-ascii?Q?xtHpYw+88Kob7YtN2QvQfYGGsm5whjjNa5ibX42F959nZVkn7Ycl2pmiPxDl?=
 =?us-ascii?Q?qTqgeDv6fQ3+DKmak8hsWD8GXZdP2MbAZkmVFuficgTk31lrtXw3Hbf3a42A?=
 =?us-ascii?Q?94Uq6fcvZ+OC4kqaZmYw7EWXppB79myI9krCDkyoN8uZpm4pSccBkz7KSfxH?=
 =?us-ascii?Q?axJjeBLOkcZOxpKO368sved0YkGCrMsFO1uajHBlRwIuCJty3LyQkzHSFYEa?=
 =?us-ascii?Q?Q7P7gm6gmNqA6xTVU3lyH2XidXOuhtYHUa9izLXK+9QKK0t++rmPENV0T1oz?=
 =?us-ascii?Q?Ab+XTOcadkYDwNU1ak3fVm0XmsNL6SrEozh7UCUn14AwR7HOWz40t/ZcVOKA?=
 =?us-ascii?Q?0k1eEXYykmcUJicAXfDtHPaOJui0yI8tfumEo85t?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b3a598-be34-48c5-66fe-08dbf01dbc34
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:24:30.6118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M///WbdLJHsHWDEq898rJjQyRGfdKKES3ir19edOGIb0E/b7YWl8bRwZcZ2OZBkUFavu54Ya+rlCknNWRhuf9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9837

This patch adds a new function mptcp_userspace_pm_flush_addrs_list()
to free the userspace local addresses list. Invoke it when flushing
addresses from netlink commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   |  2 ++
 net/mptcp/pm_userspace.c | 23 +++++++++++++++++++++++
 net/mptcp/protocol.h     |  1 +
 3 files changed, 26 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a4dc2bc8fb55..6bc1a6b5b4f0 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1587,6 +1587,8 @@ int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
 	synchronize_rcu();
 	__flush_addrs(&free_list);
+
+	mptcp_userspace_pm_flush_addrs_list(sock_net(skb->sk));
 	return 0;
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 674262face65..8494d6df866a 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -597,3 +597,26 @@ __userspace_pm_lookup_addr_by_id(struct net *net, unsigned int id)
 
 	return entry;
 }
+
+void mptcp_userspace_pm_flush_addrs_list(struct net *net)
+{
+	long s_slot = 0, s_num = 0;
+	struct mptcp_sock *msk;
+
+	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
+		struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+		struct sock *sk = (struct sock *)msk;
+
+		if (mptcp_pm_is_userspace(msk)) {
+			lock_sock(sk);
+			spin_lock_bh(&pernet->lock);
+			bitmap_zero(pernet->id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
+			spin_unlock_bh(&pernet->lock);
+			mptcp_userspace_pm_free_local_addr_list(msk);
+			release_sock(sk);
+		}
+
+		sock_put(sk);
+		cond_resched();
+	}
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index efb24c05a7e2..7441e3b9443d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -944,6 +944,7 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
 void mptcp_pm_remove_subflows(struct mptcp_sock *msk, struct list_head *rm_list);
 
 void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
+void mptcp_userspace_pm_flush_addrs_list(struct net *net);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
-- 
2.35.3

