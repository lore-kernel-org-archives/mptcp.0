Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2054.outbound.protection.outlook.com [40.107.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB729A956
	for <mptcp@lists.linux.dev>; Wed, 23 Aug 2023 11:04:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1S8EKlaZtLdnaZou5mmMh0Xn+AnPIu6Y1BeLaB1k7jGQy0EqVkm4XSeCXdu52gxmXxbwBE9TQ3RupTFtoCS1pmzGzP9JEEAeh821xCVRE4jQa2HdpnTveGgL+ptFHBw8B/fnP9rGeyGrdDjfdmjATwOJ4TrhoC5G+uaT8CINh2jEVgh/K8djlobbC8sX90ZxqiBW4G4OyQlqNixnGNn1Tjvk5aH6KvCl6M4O2wa0LP0hp1zuWSJhXvUj0LTSY625LQkxvvd72xKpU6sf+awtD4E2ZlQTKxASP18iq6cIxRBNdml7qkceAFdqAuFfZP3wAoUYyIuaCWIwvAINJzJmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRJlKOBitb7UDTr3qIV+eH7sEJjwebxlDJu9UYxlNRY=;
 b=Px0NnHM2/xBC8Mr19YPve/Fgt6fqqDSf0g1M7oFi9qho15X/HyMZg4dKpGXE5w6o21yWMsMNT8/EnQ/3qAssnrH2p9IEuZjehVPhodraRbwelmjHa3eixZYrfQTcBL3Mnvp8RmfV0ja+4M87HmSA6+dv6plxEV99j8IDfddUkGVP2XxN5Qhp+nh2hqeEreHeHaawEqiNamMFlPoEnHsU3nP0+S6eDQhp2cwoR8CNeudEJkVqJulzLd8wrtOJXTLY5TlIR78XkoXvh043b4XR8M3XY8ROyp0NdQWKz7YyJ7F65sikwVRzQZdOX7QZOp0H2BnxgqugsZU/j2HpPTlNUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRJlKOBitb7UDTr3qIV+eH7sEJjwebxlDJu9UYxlNRY=;
 b=vkfpIKzlSJd3/7Nv/0Sfxx1s2eg0gVv27t2+jcywzHsfywpswnWy3sII/tXoff2nEWYi6Q+djiYf2oSXV/pfXAZd46wtWxkPEaqloLb0oouL1b3jpLJakt/zX966mjjTu5AiRSF8GIakiTCbvdkkHsxyxLGTWtqEpbDR/T53po4vyea0vdPm4zW/ezW0/foobw5IPu9uXilMCdf02f4N+C0nulzV2RdpqY7wMfjg8Rx+5mOKqNxBV4EFYHdDZIklZkHzUDG49zeg8hIZPYWkeJNb+h4XzpOM8i3Gr6koUhCeHHU7V2vAsHwwzkEGUu2/lht2UP2VLmrbjw2PMqyujg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7901.eurprd04.prod.outlook.com (2603:10a6:102:ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 11:04:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 11:04:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [RFC mptcp-next v2 2/2] mptcp: add bpf_burst set/get params
Date: Wed, 23 Aug 2023 19:04:46 +0800
Message-Id: <486891cb494ba4e9eeb02b6e220ca670dbc80866.1692788531.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692788531.git.geliang.tang@suse.com>
References: <cover.1692788531.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: d874e4cf-3689-4830-c3ec-08dba3c8bd75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CtZ2/hsLELJ22GEnu4vxaACRWddXa7n88jhPoEfAQfypfFMSDVcc5Xl3RfrQi/mWniPJCU0yHk+btLgAihVYGO/b36+nWguuqaOqOpF3CtuR8gi9sFYK265cTPXFhncq/Xs3ubd3FkdY9rcmdfW5I6oaUyqrraY9G+YTfm9RBnw+tWoxBwRtXQAKYTU2XmhNKiNg0u0vibG+1DZq4T7WezGeTlhEG/l7R2n4Bczyo/ix6mYf2XNEdCOyU7zHlgVfupikVwfjsjC07fXs/AOpSOkHk95diWKMdaGwMfwKdM6ACkMkCLHgLNlwuX/wSmbjLbwKsAryne2e10RNGJu5POAKTwRfAD6xjsOxGhMweqFXmp7afV/UqMC8Z/8KGdpK3T1tOvHcoa93BAOT4Wx7ASsJqAXZxJWf+Sy425eyC9CUXph1NfYbilWDhWcOFA8eQrbaCzuYOaWHTfeFIq0pMIvEqbvkIQD2hONJnv7qB2hR0jUQfVYcyCo5behsUnFTKlm3lRduY0+IjDKXQHMZRJCapysS7u7HWNwfSeDycdfB60L5LvvloZLx/MXwM7FlaGrsQCwWoyfsVPe7gRtsTUpmcNZQax+lP7LPLlUMi5jzqBF3VG2N53KaqqC7psEHflIcojyMcA2sqJZE3nHLL9cz84vAgqDn0LJmkhfGuq0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199024)(186009)(1800799009)(83380400001)(2906002)(6916009)(6486002)(316002)(66476007)(66556008)(6506007)(66946007)(6666004)(478600001)(86362001)(36756003)(44832011)(5660300002)(107886003)(26005)(2616005)(38100700002)(41300700001)(6512007)(8676002)(4326008)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SYCgy0a/RYRLGdpNUXSypmw7cXRFiLvkk4aIUS3tnsCsrauFEc9wQ0xgif4X?=
 =?us-ascii?Q?gJZl866WpNJ8HWgklfPI0jcTZp+940VzQbZUQvFmeYpEO/Xr84u39EFLbm+t?=
 =?us-ascii?Q?hCLjhO+ApnnDNgMSGTx7trmyGSyrZo50jbVbrWy8SFM922ZG9liCAnpP63m3?=
 =?us-ascii?Q?4x7k83y1prXtcIzWv2hzG0fhU7CiSDb5gpCO7EWcbTJExxPlV/ufx9MJuZFC?=
 =?us-ascii?Q?GaiL3yE75wwcbM0TKft5N6UxWesVlNUfNsN0xIP8eekDOJtqc7Lpmfnq3s2a?=
 =?us-ascii?Q?sMc6vkuSNJksLWOnyDvRKJ9z3WcOejjewl1Usz0XW6GJkmm4Jm1gRqxcRWGL?=
 =?us-ascii?Q?s1EJWZXtAyAcCw36NjdMLoJR9/pSc+nfsvgMzDfWXWkxPjq1kcH3kA7LMoe6?=
 =?us-ascii?Q?ZGcVTfJMpYoogNSywrzn3AQSyPdekjju/lSzsS1Qq4anx/GkoWfdp3LLeRtt?=
 =?us-ascii?Q?cFJEFly0hYYXYeAo3O40pkuW0abzvWaIs4zbEe23wToBCUEQSRNKP7+lDa1F?=
 =?us-ascii?Q?9zGOBtjyr/lp2sa3GDFuQOeZdBEB5VRNBunlnVIj2EDxpbskSka2aiMJHr6v?=
 =?us-ascii?Q?DYxBwxHjSCSElqkpppNGqKdtH5SRZIMr0VbybxGmEXJkEoOZ654Rx2q4F7aq?=
 =?us-ascii?Q?aUWQkTIl8Pk7PdGGAhH3vN65M10x0zHt4UT/J3EiUOI9MjCVDuReGh83zBhZ?=
 =?us-ascii?Q?MpmRnzfR2nPShW41lXCkEvxPpK4+gdCGnYYvIY+xMGQASMpwBJk28K1w2/Gc?=
 =?us-ascii?Q?KBvev8+0l/j7akxd3X7WSPsRtjA3QSqoJqf0DwgI1nLLx3kushk9aKEGAz73?=
 =?us-ascii?Q?BGRcE3FF1afd7omRTqwlOf///FI99TvUXgaDbPt1gtaySuaACImdW9mefqpO?=
 =?us-ascii?Q?w7v5RtNe8CTTxLk0XSlyFzNK5O1H4WyZik76+MfBJulmCCRsuLw7dNGL4Tbk?=
 =?us-ascii?Q?S3amHljyGr1MaJfpiD1nlcMrj5RN75HjhFI2PJh3Ow1gN9/N0AFznQLwENqB?=
 =?us-ascii?Q?eT6+lw5YN3sxQ96qqj6FOib+AAYsZ/PFFTZ8jKJ2mS7qd/QvP1XI9SePFwIg?=
 =?us-ascii?Q?ua730svk5ktIENGJln8dZ2sZ7Pm2Hm5IkeIabtbN9jWUOwkRcXmbX+rW3rjT?=
 =?us-ascii?Q?Uuz961ccuGWm02ljCQHCQ/hDNGnlieW1TXjCJJIwKT/c2KSDeHfllhHpusl4?=
 =?us-ascii?Q?utvX7WQoIL3IvkWKFIw1TRp+8tXgPoBCbR1Zyo9r9NbCq21oIkt4B3HxVAok?=
 =?us-ascii?Q?CIMhLb6FcAr7qxWQfpOWUtY7ijopSMwCqsHbEFqh4SphFhfaaZwiyAudsw2O?=
 =?us-ascii?Q?u1/2mrjYdAHLdFhYyLSFSOO4T6vquDTYQMDvAmvBRjnf9TkavPUDlDO6Vwsn?=
 =?us-ascii?Q?5LgL+UDNnEwNyey8jX3/c/WBoY1kQN54JP42qkiS0Yr3H+QKwZQU2x/HvVX5?=
 =?us-ascii?Q?gcoDP68I29YPxMEN6tCt1K+PCI544+9svv0QiZD6MwMBcOgmIkNmGbrkiDTc?=
 =?us-ascii?Q?D0C1RchJsXsvUfwPeMyAX9pH4dM4J9FgrDRRAEsGa+9HBrQONDQ70UJfKWX5?=
 =?us-ascii?Q?pc1imXTpSR/uxjAqflMPMW5JoDGExcjP+AYf3tnT?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d874e4cf-3689-4830-c3ec-08dba3c8bd75
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 11:04:37.3377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ustAwKK+MLYiLK0kdjmtREX25/I6RZJPNViBY7pNn9nzTWZWn9x8jWdS+eUn2oexc2zrdWLl4fuuYYBYP3nBWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7901

This patch implements the set/get params interfaces for bpf_burst
scheduler.

Export bpf_sk_storage_lookup(), use it to get bpf_local_storage_data
from sk->sk_bpf_storage, then get or set its params ptr->snd_burst.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/bpf_sk_storage.h |  7 +++++++
 net/core/bpf_sk_storage.c    |  2 +-
 net/mptcp/sched.c            | 39 ++++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/include/net/bpf_sk_storage.h b/include/net/bpf_sk_storage.h
index 2926f1f00d65..805142d59d02 100644
--- a/include/net/bpf_sk_storage.h
+++ b/include/net/bpf_sk_storage.h
@@ -37,6 +37,8 @@ int bpf_sk_storage_diag_put(struct bpf_sk_storage_diag *diag,
 			    struct sock *sk, struct sk_buff *skb,
 			    int stg_array_type,
 			    unsigned int *res_diag_size);
+struct bpf_local_storage_data *
+bpf_sk_storage_lookup(struct sock *sk, struct bpf_map *map, bool cacheit_lockit);
 #else
 static inline int bpf_sk_storage_clone(const struct sock *sk,
 				       struct sock *newsk)
@@ -58,6 +60,11 @@ static inline int bpf_sk_storage_diag_put(struct bpf_sk_storage_diag *diag,
 {
 	return 0;
 }
+struct bpf_local_storage_data *
+bpf_sk_storage_lookup(struct sock *sk, struct bpf_map *map, bool cacheit_lockit)
+{
+	return NULL;
+}
 #endif
 
 #endif /* _BPF_SK_STORAGE_H */
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index cca7594be92e..1c023f65017f 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -17,7 +17,7 @@
 
 DEFINE_BPF_STORAGE_CACHE(sk_cache);
 
-static struct bpf_local_storage_data *
+struct bpf_local_storage_data *
 bpf_sk_storage_lookup(struct sock *sk, struct bpf_map *map, bool cacheit_lockit)
 {
 	struct bpf_local_storage *sk_storage;
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c78ed61290d2..067df28899a6 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -11,6 +11,7 @@
 #include <linux/list.h>
 #include <linux/rculist.h>
 #include <linux/spinlock.h>
+#include <net/bpf_sk_storage.h>
 #include "protocol.h"
 
 static DEFINE_SPINLOCK(mptcp_sched_list_lock);
@@ -202,18 +203,56 @@ mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
 
 int mptcp_sched_get_params(struct mptcp_sock *msk)
 {
+	struct sock *sk = (struct sock *)msk;
+
 	if (msk->sched == &mptcp_sched_default)
 		return msk->snd_burst;
 
+	if (sk->sk_bpf_storage && sk->sk_bpf_storage->smap &&
+	    !strcmp(sk->sk_bpf_storage->smap->map.name, "mptcp_burst_map")) {
+		struct bpf_local_storage_data *sdata;
+
+		sdata = bpf_sk_storage_lookup(sk, &sk->sk_bpf_storage->smap->map, true);
+		if (sdata) {
+			struct mptcp_burst_storage {
+				int snd_burst;
+			} *ptr;
+
+			ptr = (struct mptcp_burst_storage *)sdata->data;
+			if (ptr)
+				return ptr->snd_burst;
+		}
+	}
+
 	return 0;
 }
 
 int mptcp_sched_set_params(struct mptcp_sock *msk, int burst)
 {
+	struct sock *sk = (struct sock *)msk;
+
 	if (msk->sched == &mptcp_sched_default) {
 		msk->snd_burst = burst;
 		return 0;
 	}
 
+	if (sk->sk_bpf_storage && sk->sk_bpf_storage->smap &&
+	    !strcmp(sk->sk_bpf_storage->smap->map.name, "mptcp_burst_map")) {
+		struct bpf_local_storage_data *sdata;
+
+		sdata = bpf_sk_storage_lookup(sk, &sk->sk_bpf_storage->smap->map, true);
+		if (sdata) {
+			struct mptcp_burst_storage {
+				int snd_burst;
+			} *ptr;
+
+			ptr = (struct mptcp_burst_storage *)sdata->data;
+			if (ptr) {
+				ptr->snd_burst = burst;
+				return 0;
+			}
+		}
+	}
+
 	return 0;
 }
-- 
2.35.3

