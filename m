Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2046.outbound.protection.outlook.com [40.107.241.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADAF2595
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 08:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="vNPy4Fc2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVfRqd3Ut0H7Sk3FR4V6AFoSr4WMEpxM1/9mpqYbOqi3FEpTObp1xQcA3kQZIzjRJlX+1WNdutDYoCmuiH9M+DnGSzcGXXYqGphl4f3uzA65xCFKqWlvaS+AUddZMetmjwGsNkw7rrzJWrzX3W6q7IcFdNfv+C8gVPEo/knC6eS/qbkkD0uhIG3negIrI6ehHNwM+lO+UQSTwN7t2CRJtnaa+KT/kfjAkzuUzc+fpOT5IL6sGcVyZZukQP3S0xtrMZ2x4jzONVJfFjQ7Dx7eYyxOeRGw7x9NdXbxpdR8z2wTYSzJtZytPM8cB8SrXEcDImVSFugau5vxQckKvzJH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hu9CrCfDzUavUX2oZKjGvwPBX6f90usa1TcCycyIL9Q=;
 b=lIxyFz5ZzK7ehEjTCYf7C+63/zrXLewzRWbkfLnVOC8N4FAwYrQZ0pMi/Yjazv4nyH2qJ3woTIKNjTADSyyR/10CLKNqJprYIFGt15B7/aJozZcgH/dZgGsRoGPp0bSnW+KvqTdkHVowwU0iXJtsFR7MMS4I5fDFoklmD4vn6teeLMku6I1fCgWDYVLhkdJZmKb7J0nbYoT4tiEyjvhZ6VNIT9fU/EJvs1kBWfMv6qLBRrjplHZ2WllcsXJMq2wUED9TAqas6VJzcdm4t0u0HFlBBTrQKFw/nnJIPjtaGItaS6fj/7UY9FltUSgzPvyuMcofq/xLOkI5L8vhJB8vXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hu9CrCfDzUavUX2oZKjGvwPBX6f90usa1TcCycyIL9Q=;
 b=vNPy4Fc2DhyD+vY7Gf/FQFtO6pKRL2gZCygAmKCs9XtMnHuIGzw3F7KnaeN/Wy0+9KV8rWPFy7BXQjZfzuGfkHC/dLoDpVlNmLZk6Al3h3PomVYUJYEE83X4YO6Yxd9ssQPp0Kw5+HjcAyshaLelhgBW9KIvUwPAetl01+0r3J1mgBygmA6mSDTYM62vkEawymB2+gm+cKIc1y4/9Er/yHbO63N+wbcrWOltk8mw7Doby1KdFdR9bg9wxfL0lJFrGBT6ciAGt16TjE1XE0V7uSRb7AfdKDX8XV8pe4AiOi4e2tbrm+XqbbIdeaBObd5gdalJURo3R1e/C2y7MMTcvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB10023.eurprd04.prod.outlook.com (2603:10a6:150:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Tue, 7 Nov
 2023 08:16:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 08:16:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 18/20] mptcp: add userspace pm addr entry refcount
Date: Tue,  7 Nov 2023 16:14:24 +0800
Message-Id: <9af3d9432d2217ccf5e252d9825c2059d9742085.1699344621.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699344621.git.geliang.tang@suse.com>
References: <cover.1699344621.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0199.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB10023:EE_
X-MS-Office365-Filtering-Correlation-Id: aa6e2cf9-cccd-410a-5e50-08dbdf69d741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V4yGDthbu0+wlvYNmc0Ttz6SfeILDovG+JWv3RxSE0HIt0LyXiSSZFwBjl1X7vCtbyqsx2vOzD6G16hwoLYGEIRhZ7Pwje41cGjf8+JwnrV5gvvjkhsJGq7wva9DWrx0zvK2MLHKWhMwr55ShOq9M0WhAJcjjGSSJNxz0u/sasaqmqUE1Nj5ewfwzuUN4KV9KTZApKNNJQuIJ9DEgOja4UcyXi9uEWbyC/0JA8qAs60S/W6Bc6hCH4Ai4lH6DRzSFY+vldZU5x8DPVgDvispTU51XEv4BUrAy8hvT6JsNi8SlDxQ+k36TyfZrFpsVLSvl7nlGhXc6EJmEq3bSE/3Tuhv3D8XmHQ9ZT4JGbm3nEm/qCGhTsI99Go8Yr3OVwhTyCaGGnCc/7yMtW548opWfZUXo5XNU89omW13lWik2iCsIS4HTg8/ciWpeF3s9mBDCG/+XGM+G04nOYAFWMkg3erdpRZc+o5RbpUiWvUll9U6K3Kv9Ave7h9lk1zFnvf/329IRyctCpmNVG62qSI8WRK5IMotBQTZOV1kRLiNgEs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(346002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6512007)(8936002)(2616005)(107886003)(966005)(26005)(6486002)(44832011)(36756003)(8676002)(86362001)(316002)(66476007)(4326008)(2906002)(41300700001)(6916009)(5660300002)(66946007)(66556008)(6666004)(6506007)(478600001)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SotwaqkLQPu9zQ7rIDxuctZ/tlUFn/2hIv+CEdTka2ftf0OsrWphf07HRqIO?=
 =?us-ascii?Q?HkZHzUGPvFuJV85xD3ceqlSPQzfj0MQK4JoNH7peEpMDwcSB3dlWS6Mz6bKN?=
 =?us-ascii?Q?NDEOOphPZXcCmXGMgo2azWSn5LF4+7bYQwdOF9tINeRkwsngDMQ4NzuM96st?=
 =?us-ascii?Q?fxZsZpwIRiJEodlhu3dyHWWwFH4RASIFzhVbvr2G2Pl8D/qzIo6fj01kCf9Q?=
 =?us-ascii?Q?kA120OduvdsYKsSOE6ULOQJWCkwnIpFT9zHpTEDxbEKFaKmrYWKk18G5J5rl?=
 =?us-ascii?Q?p1hIpBsgGRo6yQl8IKhwrIuom05cMon2VvIVNQl/LLs9LZMuOFc3xMhHjjqS?=
 =?us-ascii?Q?ioX9tVQodxTshTgXjTBjnUs/94BHMFxX2bj+jjvqyaNcElKNGJ7QqT+KuoDj?=
 =?us-ascii?Q?y3OsrMoAqTuRbTgggcmSRKr1W216wcG3oBUk32EJRFUOjBm6Tld72zqKVVPq?=
 =?us-ascii?Q?Ap4G83qRNum8ikj1iE4/K3Xq/Ms//DLG3m1jzgSZytMDonesRkaJuQu5/5MB?=
 =?us-ascii?Q?TOb2OKIJDWIpWZCL9fLaRQT/MmfjyrnOF1l6zN8zayruXzG83vcpcJ0n1A5x?=
 =?us-ascii?Q?xXS9ExzCl2CCsoCuosJmkTL2uyqgf4vV2Wiu8hjWvd3519KTOkU0OC8lJW3l?=
 =?us-ascii?Q?zngAR98mvIQ6CFRtl9XyQihFlBqV4JmPWPHZDpSFmNqTpZpXl0PT4+/utKru?=
 =?us-ascii?Q?aZmNaFfaKIaOv2BWc9Ixpk15NObt2EnNsVKHvq5DYP6sJaraGgEAlCQHbUkI?=
 =?us-ascii?Q?zcT6iyrz/J7TQseMQNTTVRd/PeZA/nk3SG6HI5RrkGtFPhQsfxO+tzKhylAd?=
 =?us-ascii?Q?zSx7LPQtxC+xyBXBDjiz4r2k4IASSjZd6ODNJXJNa5jR3bvs0b7StB157j24?=
 =?us-ascii?Q?SbrsKhtfM9sEfWE2lyXiksZSlgB1DSYEgYd52H9YsYNYfqJObJ5GB1i1CqBK?=
 =?us-ascii?Q?k7XmRSnEQy7vJLkU7bU9Yegj+BL1Ocdn3twkeYSdaHDA+kdMG4AZ6A7Xu21N?=
 =?us-ascii?Q?nogku4i7QY6n6kE+T1xrJA1VC0tyyN35fUQu5QIi3rqUwvSVRoM2jnCRtQIn?=
 =?us-ascii?Q?qWG1sd5KkQOC3gPH2uBKsC2sUDjJMgkRfz4otXECR0sMKYiHtmUnKISsdmK+?=
 =?us-ascii?Q?8pNBbBtxw7hE/D96d4AsOnD2nfvLWPye3aexs8JZC9EMU2QMV3SvmvI4u499?=
 =?us-ascii?Q?6j0zBFm9MBcMjJJEtDEm3lHK8dQUCFrMTQVfsnukEv21QDelRMXr8EqB5d/6?=
 =?us-ascii?Q?VtfwoBqrJU63McHSGlRMgwEcL9mH6hqmAL149PC03iz5hz6WOz/jm20LiGcj?=
 =?us-ascii?Q?J1kXQLWLKDzyeHNeyqoSWLb2U4LM3+YBIbNc+YzWgQZuPthliuGSiLaN7U29?=
 =?us-ascii?Q?HK72f/XnF9VFoBeD0T4KfZV2XLvZYKuF0kDF8SqcQiPXS9vDW4QWzao1Nxjp?=
 =?us-ascii?Q?7UsPVptK9ZfLiYy6EFBIS4QKZ8y2XulhplFRjw0HrjY8niKtKCABZlf6XL4O?=
 =?us-ascii?Q?ycllUeQW8/IHmvS26KwZ3VP5eJ4yK0qb8FGprmTQtvt9UYsBdG7nxpKlbAL/?=
 =?us-ascii?Q?bRpFc/hZ2euU8ysOZ2BBtIrz94w7Unu9syU1qgLD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6e2cf9-cccd-410a-5e50-08dbdf69d741
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 08:16:28.3260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/XP8jWBeiJFwdsxnBhSeAo41OMvXoob6YuTQMG3JC/5IGnNdKjBCDjKy9lMT1LwC5luN007QtZZhSJNiL3svQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10023

This patch adds userspace PM address entry refcount. Add a new filed
'refcnt' in struct mptcp_pm_addr_entry, initiated to 1.

Increase this counter in mptcp_nl_cmd_sf_create(), and decrease it in
mptcp_userspace_pm_delete_local_addr() according the subflows value.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403
Fixes: 24430f8bf516 ("mptcp: add address into userspace pm list")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 33 +++++++++++++++++++++++----------
 net/mptcp/protocol.h     |  2 ++
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 7ba872813933..8a2455a2187d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -83,6 +83,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		__set_bit(e->addr.id, pernet->id_bitmap);
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
+		refcount_set(&e->refcnt, 1);
 		ret = e->addr.id;
 		goto append_err;
 	}
@@ -108,12 +109,11 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 
 	entry = mptcp_userspace_pm_get_entry(msk, &addr->addr, false, false);
 	if (entry) {
-		/* TODO: a refcount is needed because the entry can
-		 * be used multiple times (e.g. fullmesh mode).
-		 */
-		list_del_rcu(&entry->list);
-		kfree(entry);
-		msk->pm.local_addr_used--;
+		if (!refcount_dec_not_one(&entry->refcnt)) {
+			list_del_rcu(&entry->list);
+			kfree(entry);
+			msk->pm.local_addr_used--;
+		}
 		return 0;
 	}
 
@@ -207,6 +207,11 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry = mptcp_userspace_pm_get_entry(msk, &addr_val.addr, false, false);
+		if (entry && !refcount_inc_not_zero(&entry->refcnt))
+			pr_debug("userspace refcount inc error");
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
@@ -312,8 +317,10 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
-	list_del_rcu(&match->list);
-	kfree(match);
+	if (!refcount_dec_not_one(&match->refcnt)) {
+		list_del_rcu(&match->list);
+		kfree(match);
+	}
 
 	release_sock(sk);
 
@@ -398,10 +405,16 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	release_sock(sk);
 
 	spin_lock_bh(&msk->pm.lock);
-	if (err)
+	if (err) {
 		mptcp_userspace_pm_delete_local_addr(msk, &local);
-	else
+	} else {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry = mptcp_userspace_pm_get_entry(msk, &addr_l, false, false);
+		if (entry && !refcount_inc_not_zero(&entry->refcnt))
+			pr_debug("userspace refcount inc error");
 		msk->pm.subflows++;
+	}
 	spin_unlock_bh(&msk->pm.lock);
 
  create_err:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d0eb7b84a262..3093766dd224 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -8,6 +8,7 @@
 #define __MPTCP_PROTOCOL_H
 
 #include <linux/random.h>
+#include <linux/refcount.h>
 #include <net/tcp.h>
 #include <net/inet_connection_sock.h>
 #include <uapi/linux/mptcp.h>
@@ -244,6 +245,7 @@ struct mptcp_pm_addr_entry {
 	u8			flags;
 	int			ifindex;
 	struct socket		*lsk;
+	refcount_t		refcnt;
 };
 
 struct mptcp_data_frag {
-- 
2.35.3

