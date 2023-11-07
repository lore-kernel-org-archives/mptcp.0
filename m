Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224AD28E2
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GIHczZhn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsJ61+WQ2Jse5UzHo2KS811Zvp7aniI1EKn8IRaEWz6+XRniCSL4Ndr6ylCiOcpaDm+eBdJuQWdsgGt/cSgMmbdEOQr7hw5UzzcACodQObdeF372gOKV/QpHhsY5HBEhRowbJkWEDtXvJYhhwNU+onnCRMGQ80BGehU/83zYbzRRtWpNyzdZgcOSha81A3tuGkxUR4FLgYGv3U64KSFXtxlSmmpz39dGVTcDhxGOWkpv0nJ9D6J+Elpj3xW/Ut5yJj+8+dOceIeOMFLQfIf2ZCHOkaimd3EGKJeLGNjOhJkXRtc5lf156Whh9LkpEaHLy0I9Qk+pULRJOzZaBJqMQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePPCKbrvcYO71HNeRwZE6CAy/2FxyDSgm8y5jFpi/dU=;
 b=TyO0gMYW2UWlkm103VSlwtCguc1j1HANzAy2APvzki3IzKyvkZIuTxP4/0htP+JOjaIv7uqcsZqExXOWDb0XHI13H1nuPjU2UBB8vqwrKomkvWWK+L9+el6PBFhUJKswnIF3+13X+dR1f29obLRt7KaCovwo8vgcJ81sfmFx+h15YjX5GQbZ37QFDV1bu/0cRhnvOXey4QYPkl8yjpF8aQ6rkOxAcPljqyfmhGnuuiEpgxUrl/BNPesN7/A3GWdQi0MFoCyQk3kEaRWNgZWQr2ctujK/1d2UJ8+NA6s+aeaz6v0Jv89dAJIzdgf7xyPqIoaGPrJ3kQVjv5NB2qwHvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePPCKbrvcYO71HNeRwZE6CAy/2FxyDSgm8y5jFpi/dU=;
 b=GIHczZhn7/DXCFVV4JKsmbD9fZtTlxgkK2qtipRU3L5Cyy7AOsNcODaeMwTpXn4lotb4NWLP/HqIke0KQeC6ZZunb6NPkGEHRfhJQ5ponnNaAK95D4C5zzPzEEiJDBcXg8AjVKI3Kff9MBbqRDbR0rN3ApDFjii1KBfSId4d3+Y4Ezhf/Nx1N7h9ioXksEII+QXe4w5ev1q9sz+b9n94m3FhegaBCCOGUM/Mmr2qkR7+6uMZN8qB4egs99jfCkYNaRPbtniaUjPhszJSLhyARxt3d4z01CuIxQOyBdZeZnkMOF0qu+/QR2160PNliT0jiJzC/0T3kqck/EIx80vPEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7663.eurprd04.prod.outlook.com (2603:10a6:102:e9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Tue, 7 Nov
 2023 08:15:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 08:15:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 08/20] mptcp: dump userspace pm addrs
Date: Tue,  7 Nov 2023 16:14:14 +0800
Message-Id: <87810ebe9149b5592ab6bf90077e50f5b596d73d.1699344621.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699344621.git.geliang.tang@suse.com>
References: <cover.1699344621.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0113.apcprd02.prod.outlook.com
 (2603:1096:4:92::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: f0b050b1-9358-4fe1-d1e1-08dbdf69ad02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6NX1eI3OsUAsIkMwJx/pG/w178JYSBDAIrt4oF+ePmtvh1HFUzfid9eJdc9N1eQ0Pt13s4PczF9CZDr5ZOv///qunXLO4WzGGEeakmY4yPvwGNqvIOpsDc3/cu2XgSGFToWkkkRWUHJ+8xakF9Gk3PeC3I7lQcQmxtUgUEtX4hUANzqqa4/Xvvb9RvOMkT+ZK4dFd1XbsaqcxGPCR8Wf1YJt7al3zf4XjC2+Iy5RZYGmlwvRxr/Os11VqbimzNzMH+XyucOnqY8/7Ur+GhM61pGae8TjxJlirJ8U6ujh8nmR6dallc3zSCinRpxZiIi886LvhdK8ez+LZdXmcLPYS3M2OXbBdyVO6dqXdb8Q1s58PHrvi+pFiOD3W3xWTGhdxKaOxukhC1c8wn90cz0gx44t+Mh/N//MMj7vFw3BaTjGdHlsxd34erjcfINWyJvl1kB4RxSo6ll3hSeERJRb116rttPgucy7H/sReSSNAxeyUyg9axZd39HljQUu9d42ZlxB2xV2BClSq9jA8CFBsdIij+KGQnZ7tGh2Rhr0G9lAio9ujoGZGVrhbsXGsZN+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(2906002)(83380400001)(41300700001)(38100700002)(8936002)(478600001)(4326008)(6666004)(6486002)(86362001)(44832011)(8676002)(66556008)(66946007)(6916009)(316002)(66476007)(107886003)(2616005)(5660300002)(6506007)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yp+7+Vxey9Eocx2enwXQH/5TjAnMIR7mr7PjF243AsLy+dk+w8a8HCLV3bSF?=
 =?us-ascii?Q?1IFeXfgAHBNuW7NEnuZAM71CvrOJzThBRxkblycMmQkhCqR0USXE18D7Rzzy?=
 =?us-ascii?Q?2sGilIQ/1mz/U0iHjxaLbA1faROzx2/yPNHVyHYMvr+gIkjbY0VE3oJlR8QI?=
 =?us-ascii?Q?Muxp/D45jqnGzvX3ulceOB269AcksXofQFO0rtvz7gA3sRw19Ru2meXBiQ3N?=
 =?us-ascii?Q?q34lRMcp2p+1uD5onDj6qsAL4REUKc+tANmhFDeUTQ19asP6ttmW+5+CblZN?=
 =?us-ascii?Q?byw+4ZEfE+Ju3quRqgUVtTE1AzzpGJUI30eXSBn9RgCXyCVgyLoO6ebXUY3h?=
 =?us-ascii?Q?p4vl0rgWoagwkd7QEIu9nM9K9UTE7m5+PhXwti1t3LUQycr7oJ8/+Q198NcK?=
 =?us-ascii?Q?JqsFQhaq04opA+WUkGdS/Wtdh0ezqIXZIBFDwi+dGlAtWpHkU1sdkNOOLFFn?=
 =?us-ascii?Q?AtHTYy67DA0lpxUdkx66EDdLevKZqOdkFX4wP41vgEhstgiUxMnKekuB8vPn?=
 =?us-ascii?Q?hXlAhTde7t6MP6h0oTXVHNJg6HBPTOVehaMnkyxgy90NIRyE5Oh22IbwSVAQ?=
 =?us-ascii?Q?rMLVOv4mH9WIXxQHnMBUD1IiYj+9LFYnlfgnGav6t1fuhMZyrtsnrLoGu0+W?=
 =?us-ascii?Q?IzRqERW+aHonXarIQtP9l3AVurhj8Ng8cmMkv79k5a7W+UOtX2oahEcuWxJ8?=
 =?us-ascii?Q?mLyUFiOpS+fX8EKTpRO2Ms2bsxYT6tgLotu13VYEw4Gu3pn8LqyM/eiqvDiW?=
 =?us-ascii?Q?fAEZDWo+Am+yRlEkEyI5faIQLvM5K/3JWlxK5C1MVAHW7Up0lBbJF/tGX3fl?=
 =?us-ascii?Q?Tk3MSRrjT4qli9YC/gMuH7kiL5Rfg59CSFWjpl3lu3wDzpc1/7Em1wVosZz1?=
 =?us-ascii?Q?JveavFaZ2ftNoSB85syXm2gZV4et9JmRuNq/rv+MCZfrh+HsMwcMG/wxIMqV?=
 =?us-ascii?Q?WTUE8rgR2lEdcGXe6jFwshRSldVXTY1J+z4FacYhoYT5g2JeNYiGvE7UJS9w?=
 =?us-ascii?Q?UJLFLSavC+m5fNovQjxy1zS0/qWjHapo8DtUEvUVENBO6iFcMtdBB2gyUAsJ?=
 =?us-ascii?Q?5U14JucrlvYPxo2WoraDudZsFcaYBcd06nUonibqdVUgRuKV5Zthc8ZtHIgI?=
 =?us-ascii?Q?i5xv+OgcKfxY/kG92VWkRmmAX7sRl0/L3A5eAsjac++q4pAUjjmmkKLZYQ4n?=
 =?us-ascii?Q?BNwBLeK8qEFS4HKWRyZfgr3cc8qVLOzzd9G/8a+GOC7utldBllc+wsDFu/H1?=
 =?us-ascii?Q?7EE9/PbZbl/ar65t9u8rE5FFU8YO0M5YRmqpONcnvtl6G4RDG4wavfawmksN?=
 =?us-ascii?Q?VKzEdF5b7OsHoT70cSMDYyO7KuBNgJv/wRCQ+Qy93cT2MQzJpjuPQOnk2hZ8?=
 =?us-ascii?Q?3wGgkuIUv+MCS0LQZDAQWyHMTYud4hwC5lmi6SRGm4oFHs+PfeIDfqrrc9vt?=
 =?us-ascii?Q?v8o6PQ59Uh4GJf6Sd81XLzBEduNgs1FI0PLPNnih2P/5S8VbPru9mN+CBrLb?=
 =?us-ascii?Q?Hf2e0NIxDBbdiBGPQVLHibltDPjREgdXGIhKjOhPuuehkcsSKmH5+Lsg6qtH?=
 =?us-ascii?Q?60dofmvs28zGvgCz9K8MKgFMz33N0hXoDHVt/ax3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b050b1-9358-4fe1-d1e1-08dbdf69ad02
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 08:15:17.2727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JcL2oReK0YIXBpIVZwTV9JiqRkxqVCwijtEtAiKsdRrcYz2CMd+HsJwcPolphCZYBe/ajKpjvbLwK8gtJ3fMWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7663

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
index 5d42b62cc3f6..b7e4c8d21078 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1675,8 +1675,13 @@ int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
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
index 73d16c8006d1..bd491b78171c 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -574,3 +574,28 @@ void mptcp_userspace_pm_flush_addrs_list(struct net *net)
 		cond_resched();
 	}
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
index 54f96e7f7603..089fbebd21d3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1022,6 +1022,8 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
+struct mptcp_pm_addr_entry *
+__userspace_pm_lookup_addr_by_id(struct net *net, unsigned int id);
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_work(struct mptcp_sock *msk);
-- 
2.35.3

