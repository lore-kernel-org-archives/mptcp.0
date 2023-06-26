Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2055.outbound.protection.outlook.com [40.107.241.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BFE7FA
	for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 02:24:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoBOa0OPaEsyL5z7kuU2HNANdNn7ccmQkSjh5v80G2M8p4bSkXFq1qtBSDNhzv8xen4XZOIA0kzdViH6S9RFJ6H2vDT5YbhcKsf/tyDQ9qnDe+zMYzMxKxZG9u1GCWZxk47bccBSi9VUKLX2MSIpuVKp3wWC4y+tiOk5gWmAqYzmyUPyAcWx23jyT0cs2pz0B9pJ66hofztW5/Yg5ws/MVSywboAs0B4jAo5DPSXTJy7h0iiMR8l2vGwRai4JDFAAZ+UR/a9Yb4dn+Zgdgzn0xX801+CR3mHI+57XHvKbpiWbtuP6LnFjmUA9ubtElVqVXj+39FHb2cthhx0hXyXfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFJKBA3RCzzauWIHskvLv5uGsj1bBGCTUKvU82tw8j4=;
 b=a5cVd4IWLc26ZuPFjd8ztayJcHKRo8cTvY+RdXAWE7wVPE2irTKJcwEe/C8EwGUdt0+tupHPkJ1kFyCXbF+UpJzzkTdQcMpuNO9e8JCgyWlhtkW9NztVUF2yNNMjHQACmdJh68q77n7Ndr4sYc+ivi3ZTtyqExGKO6kYlASaprocapiUL5UkyLNyiyUe+AFj0+ZvoYgbYvaga0pm2pbzNrvdza+iBvcA71j2SBZH8mxTBabKXtgM8lVzm8WrE+L9D8tzHWxhmNW1ziWo9HmnY2ydrFswC+6HTTkvvPUBzLFjAICrTIfT4XoZkne3ztWntkyUn7sl9/ackzwx+3/qtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFJKBA3RCzzauWIHskvLv5uGsj1bBGCTUKvU82tw8j4=;
 b=iAgeUfmQ3oAnvjPEjxyKF5TxN92Mn0NBt07J7o+PNhwxLKDIDT1n4e7ZPh4aKEVqHqxsn52pTbWmfd+6oqbwBefUkL34C/Zubt5x4CKkMoTfYcPNpu85rotj5JL7xrd4pW9YhXmPwuAiSjRRGt7yCBVeIAXxubsHqc1LDEvbSBTWyte4mUVz/SQVtjRU4O7LdQcgKM/diBaFdoMl5obAVyv7BfRc/4w6Gwxygb4wHT4AOadRDfUQp8vY4SFG+epTOPkc0W/jvR9ei+KurOR6ZRcOyQ7VZSTHpn2dWQUpYVJICKJv8yBwRBzyu8Px7blWDQaqn0JPh7GIyXuLqn4mPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7088.eurprd04.prod.outlook.com (2603:10a6:800:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 02:24:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 02:24:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 07/13] bpf: Add mptcp_storage map type
Date: Mon, 26 Jun 2023 10:23:08 +0800
Message-Id: <71ab0afbeccdc94212dabfe51b6f6fbd1e33e68b.1687746021.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687746021.git.geliang.tang@suse.com>
References: <cover.1687746021.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: 29b744b7-2016-4e63-ca91-08db75ec6720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VFzMn0wUw0Z7gr95bDWwuXCRMbMZhiOZ+oc/rFJB/KYV2qw6W2sTriExlKgdF/SMlORc5S4MT2rS7KeBj0/x8qDjPo1DAvlT/K6Ix1Uwe+N5xMA2TbKfuggPVcecU7h21au7dOuFeWaFpPo06Idha5VGJaPmSCSp9IRGnobkWHQqWQck/1vvT+IoBkteITdzwTT69/+erdEgYfQRlz6zJeWs2DMcnxKceaf4zmHP9wRHVLySzGXH86Yig01Rf4Y9Nzgc8cvYsJrGrROVW7Zg01Zx7jQEvYod9Z8ryaNnwnK+R/+Ov2LP7f5QWZ2tqbghH9K4YJ7RarOFPdMZrnDs+CDg1Gjwtc66eVQM95RcLOk3COWNLEVOxW8I34tDy9vx00TxkKpdp6AZOQ2gr76VJ7+wzs2Lcf5WgTlcZH/oVQDrDdvbf1jyaOJeQJ8dQpQQ0SHHSTK/0ic8iYVedEjrdUOCTBxWnA2855aft1AG93nFSwDvEyYLeY8llHkTO0BteiiJOv2NHiI/phbfdXgtvKIxBhZf1BjIrkvVjpYu7+QYUNisi4O9+hyCL4y1gDHP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(6486002)(478600001)(83380400001)(2616005)(86362001)(66476007)(107886003)(186003)(26005)(6506007)(2906002)(6512007)(6916009)(36756003)(4326008)(316002)(66556008)(66946007)(5660300002)(38100700002)(8936002)(44832011)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0k1Ix+VRUp9f0twOCEfwZRqF8oyl+qGkYYm4VCf3Y7GRMJ0+jRGdPCazxb9z?=
 =?us-ascii?Q?HRup+0mZsJY4xp1+FvfcNJWnCMqqrqxtVemXx02w28TjbQSgd1Kqcq3zCnM+?=
 =?us-ascii?Q?6DVfWXD4x5df9QLAt0Qa4ACQRBB8HSXLO7DepHYT0ofv6s95mN1/BkoeAJR9?=
 =?us-ascii?Q?oGup4vm9TC9w6r3+p2CtwxvskV7+jRk2r3g/zeo9qbjNr6EGVYGkIS6lvwnG?=
 =?us-ascii?Q?9LbF/CvwtfTRK3NxwaPO9sH88cShibD5iJdAw/H6/UyX9Jh1B1ALrIYmYVAM?=
 =?us-ascii?Q?9wldA+HKgPYgTiiNi34LfVIX2SpMjBKmPwv5mLKLuGFmiDZCdvGVckZQDeSN?=
 =?us-ascii?Q?a4alYY7j2TsRDQRqEqFBbMxhfz06GCbgx1LtvQ4Gobg5KFhj/mB6dvS2+kdT?=
 =?us-ascii?Q?F/Q3Pln0xFanKlsUsjzDbfneldb1E94eSvIaQKtBWPRjzyYetxMsn4H8opxk?=
 =?us-ascii?Q?PEM4p89B4yYf87g50yT1LfhWxRRQ75FxUULKq+BBWDqaqLHbfvC48KuftO59?=
 =?us-ascii?Q?zgLTnScNy0H4gbcj29TsEiTT2392zXll7HzvZsxOsTPaKi4DymwhdkLK/wO0?=
 =?us-ascii?Q?q5jUOsN91r2cAPyZoV4n6edkyFnfk/TYpwgaeUacrans73Jd8l7ClMOEYSTU?=
 =?us-ascii?Q?S5HTVToMu5b8Q2S86EJIH1G98C/+OmYjyBx1npqueCY2dHxcV//pBwpQfh52?=
 =?us-ascii?Q?pjKCqH1JRw6d+Xbbu38xpcjkMxGREw0S6WAuBPqaXTNKH/js3rNMLjgsHtYU?=
 =?us-ascii?Q?4JMXXmdauoQ04VC+GjddCHzzdRCWVAqAEj+eQTQQdtRPbB7ER5hakzjNHFyf?=
 =?us-ascii?Q?dQwEBjP8Y2EoaqaOXGfIohlbm/efU/1Am4z1krR4v/18mpfDEjg7+x4C+PnB?=
 =?us-ascii?Q?kemCy8goRMk52Rz4llM8OLnK6M0+uTsIUVbaDk/xtlYDIgWrgwG8BFu8ZZl0?=
 =?us-ascii?Q?nrXkBTdD03L6uzNKfojYnudFn0n4cwge19iHdEXqVrb21RnRWOyHp6cSus4a?=
 =?us-ascii?Q?SbdV0e1TbWFTgtaxllJtRBR5A/8JeTRO/5aqRik2CmHimz7/g964JgMQ0WQJ?=
 =?us-ascii?Q?Dfl3tI59uwXcoNAoGJPW5n++UHAj6TVbWhC4KhZakSwJ2VJvuNw9+LqUindN?=
 =?us-ascii?Q?7s3phgvAkiFHAOr97T+vvgGA7jQ9FCL8tnHxm1pQYYQ/LsxGI4flvrgjh7DT?=
 =?us-ascii?Q?KUKMlGpNeYO9OHeN7iSgO+/jUKjCxBICeaee/P/iUzME34f/ZfHVoKj1K1Eq?=
 =?us-ascii?Q?DVSXLeWmU9f8IC5JCO3QWCvdBb85l13ASo87mezSnXqTMaOdBF8bOwgauOC1?=
 =?us-ascii?Q?a4+dvY/5BYCVCWwgE62NMlneeAu+NB3K9kulMIBruT94RzYxJNpwaKSXowbd?=
 =?us-ascii?Q?v0U/mKDOJUyoQQWeFw5OAsxqqUu5pLQOdE0/5EImAV3sjW3CUhtv6RjxYVj0?=
 =?us-ascii?Q?FwzWfW+//nqgbbkQnpmty5UNdcuc9nsycqd2+6GdtGYki5J5jPPHn0KIROqZ?=
 =?us-ascii?Q?IYJcr94C27M9EivG8so1sBsH9IdVZvbZ6wBY0EF0FPEjSOtTHRfdMgw/Cv/N?=
 =?us-ascii?Q?VYKF0HZ4bodN1GCCkXGH1xZvolXT6tEBosYefj6J?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b744b7-2016-4e63-ca91-08db75ec6720
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 02:24:01.4334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jS90sP35XPY5D9xfkhT2wHgfr2o1LB8kbKsz8rsuosxA4FsbIp9GNhKZMpo/+FjH7iWLFT/Km932jk1iKY6Amw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7088

Add a new bpf map type MPTCP_STORAGE, define its mptcp_storage_map_ops.
Add this storage into struct mptcp_sock to store persistent schedulers
data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/linux/bpf_types.h      |   1 +
 include/uapi/linux/bpf.h       |   1 +
 kernel/bpf/syscall.c           |   6 +-
 kernel/bpf/verifier.c          |   1 +
 net/mptcp/bpf.c                | 154 +++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h           |   3 +
 tools/include/uapi/linux/bpf.h |   1 +
 tools/lib/bpf/libbpf.c         |   1 +
 tools/lib/bpf/libbpf_probes.c  |   1 +
 9 files changed, 167 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index fc0d6f32c687..ef942ba2e176 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -122,6 +122,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_XSKMAP, xsk_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_SOCKMAP, sock_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_SOCKHASH, sock_hash_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_REUSEPORT_SOCKARRAY, reuseport_array_ops)
+BPF_MAP_TYPE(BPF_MAP_TYPE_MPTCP_STORAGE, mptcp_storage_map_ops)
 #endif
 #endif
 BPF_MAP_TYPE(BPF_MAP_TYPE_QUEUE, queue_map_ops)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6961a7b70028..f43cf69e47ea 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -943,6 +943,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_BLOOM_FILTER,
 	BPF_MAP_TYPE_USER_RINGBUF,
 	BPF_MAP_TYPE_CGRP_STORAGE,
+	BPF_MAP_TYPE_MPTCP_STORAGE,
 };
 
 /* Note that tracing related programs such as
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4497b193dd20..8b96df76b780 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1060,7 +1060,8 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 				    map->map_type != BPF_MAP_TYPE_SK_STORAGE &&
 				    map->map_type != BPF_MAP_TYPE_INODE_STORAGE &&
 				    map->map_type != BPF_MAP_TYPE_TASK_STORAGE &&
-				    map->map_type != BPF_MAP_TYPE_CGRP_STORAGE) {
+				    map->map_type != BPF_MAP_TYPE_CGRP_STORAGE &&
+				    map->map_type != BPF_MAP_TYPE_MPTCP_STORAGE) {
 					ret = -EOPNOTSUPP;
 					goto free_map_tab;
 				}
@@ -1085,7 +1086,8 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 				    map->map_type != BPF_MAP_TYPE_SK_STORAGE &&
 				    map->map_type != BPF_MAP_TYPE_INODE_STORAGE &&
 				    map->map_type != BPF_MAP_TYPE_TASK_STORAGE &&
-				    map->map_type != BPF_MAP_TYPE_CGRP_STORAGE) {
+				    map->map_type != BPF_MAP_TYPE_CGRP_STORAGE &&
+				    map->map_type != BPF_MAP_TYPE_MPTCP_STORAGE) {
 					ret = -EOPNOTSUPP;
 					goto free_map_tab;
 				}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b54193de762b..d8482a4ef465 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16577,6 +16577,7 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 		case BPF_MAP_TYPE_SK_STORAGE:
 		case BPF_MAP_TYPE_TASK_STORAGE:
 		case BPF_MAP_TYPE_CGRP_STORAGE:
+		case BPF_MAP_TYPE_MPTCP_STORAGE:
 			break;
 		default:
 			verbose(env,
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 7f29c68a0dc3..764c670e843b 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -10,6 +10,7 @@
 #define pr_fmt(fmt) "MPTCP: " fmt
 
 #include <linux/bpf.h>
+#include <linux/bpf_local_storage.h>
 #include <linux/bpf_verifier.h>
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
@@ -180,6 +181,159 @@ static int __init bpf_mptcp_sched_kfunc_init(void)
 					 &bpf_mptcp_sched_kfunc_set);
 }
 late_initcall(bpf_mptcp_sched_kfunc_init);
+
+/* mptcp sched storage */
+DEFINE_BPF_STORAGE_CACHE(mptcp_cache);
+
+static DEFINE_PER_CPU(int, bpf_mptcp_storage_busy);
+
+BTF_ID_LIST_GLOBAL_SINGLE(bpf_mptcp_btf_id, struct, mptcp_sock)
+
+static void bpf_mptcp_storage_lock(void)
+{
+	migrate_disable();
+	this_cpu_inc(bpf_mptcp_storage_busy);
+}
+
+static void bpf_mptcp_storage_unlock(void)
+{
+	this_cpu_dec(bpf_mptcp_storage_busy);
+	migrate_enable();
+}
+
+static struct bpf_local_storage __rcu **mptcp_storage_ptr(void *owner)
+{
+	struct mptcp_sock *msk = owner;
+
+	return &msk->bpf_storage;
+}
+
+static struct bpf_local_storage_data *
+mptcp_storage_lookup(struct mptcp_sock *msk, struct bpf_map *map,
+		     bool cacheit_lockit)
+{
+	struct bpf_local_storage *msk_storage;
+	struct bpf_local_storage_map *smap;
+
+	msk_storage = rcu_dereference_check(msk->bpf_storage, bpf_rcu_lock_held());
+	if (!msk_storage)
+		return NULL;
+
+	smap = (struct bpf_local_storage_map *)map;
+	return bpf_local_storage_lookup(msk_storage, smap, cacheit_lockit);
+}
+
+static void *bpf_mptcp_storage_lookup_elem(struct bpf_map *map, void *key)
+{
+	struct bpf_local_storage_data *sdata;
+	struct mptcp_sock *msk;
+	struct socket *sock;
+	int err, fd;
+
+	fd = *(int *)key;
+	sock = sockfd_lookup(fd, &err);
+	if (!sock)
+		return NULL;
+
+	msk = bpf_mptcp_sock_from_subflow(sock->sk);
+	if (!msk)
+		return NULL;
+
+	bpf_mptcp_storage_lock();
+	sdata = mptcp_storage_lookup(msk, map, true);
+	bpf_mptcp_storage_unlock();
+	fput(sock->file);
+	return sdata ? sdata->data : NULL;
+}
+
+static long bpf_mptcp_storage_update_elem(struct bpf_map *map, void *key,
+					  void *value, u64 map_flags)
+{
+	struct bpf_local_storage_data *sdata;
+	struct mptcp_sock *msk;
+	struct socket *sock;
+	int err, fd;
+
+	fd = *(int *)key;
+	sock = sockfd_lookup(fd, &err);
+	if (!sock)
+		return PTR_ERR(sock);
+
+	msk = bpf_mptcp_sock_from_subflow(sock->sk);
+	if (IS_ERR(msk))
+		return PTR_ERR(msk);
+
+	bpf_mptcp_storage_lock();
+	sdata = bpf_local_storage_update(msk, (struct bpf_local_storage_map *)map,
+					 value, map_flags, GFP_ATOMIC);
+	bpf_mptcp_storage_unlock();
+	fput(sock->file);
+	return PTR_ERR_OR_ZERO(sdata);
+}
+
+static int mptcp_storage_delete(struct mptcp_sock *msk, struct bpf_map *map)
+{
+	struct bpf_local_storage_data *sdata;
+
+	sdata = mptcp_storage_lookup(msk, map, false);
+	if (!sdata)
+		return -ENOENT;
+
+	bpf_selem_unlink(SELEM(sdata), false);
+	return 0;
+}
+
+static long bpf_mptcp_storage_delete_elem(struct bpf_map *map, void *key)
+{
+	struct mptcp_sock *msk;
+	struct socket *sock;
+	int ret, err, fd;
+
+	fd = *(int *)key;
+	sock = sockfd_lookup(fd, &err);
+	if (!sock)
+		return PTR_ERR(sock);
+
+	msk = bpf_mptcp_sock_from_subflow(sock->sk);
+	if (IS_ERR(msk))
+		return PTR_ERR(msk);
+
+	bpf_mptcp_storage_lock();
+	ret = mptcp_storage_delete(msk, map);
+	bpf_mptcp_storage_unlock();
+	fput(sock->file);
+	return ret;
+}
+
+static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
+{
+	return -ENOTSUPP;
+}
+
+static struct bpf_map *mptcp_storage_map_alloc(union bpf_attr *attr)
+{
+	return bpf_local_storage_map_alloc(attr, &mptcp_cache, true);
+}
+
+static void mptcp_storage_map_free(struct bpf_map *map)
+{
+	bpf_local_storage_map_free(map, &mptcp_cache, &bpf_mptcp_storage_busy);
+}
+
+const struct bpf_map_ops mptcp_storage_map_ops = {
+	.map_meta_equal = bpf_map_meta_equal,
+	.map_alloc_check = bpf_local_storage_map_alloc_check,
+	.map_alloc = mptcp_storage_map_alloc,
+	.map_free = mptcp_storage_map_free,
+	.map_get_next_key = notsupp_get_next_key,
+	.map_lookup_elem = bpf_mptcp_storage_lookup_elem,
+	.map_update_elem = bpf_mptcp_storage_update_elem,
+	.map_delete_elem = bpf_mptcp_storage_delete_elem,
+	.map_check_btf = bpf_local_storage_map_check_btf,
+	.map_mem_usage = bpf_local_storage_map_mem_usage,
+	.map_btf_id = &bpf_local_storage_map_btf_id[0],
+	.map_owner_storage_ptr = mptcp_storage_ptr,
+};
 #endif /* CONFIG_BPF_JIT */
 
 struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bb4d50c8c398..9e2aecae8923 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -313,6 +313,9 @@ struct mptcp_sock {
 				   */
 	struct sock	*first;
 	struct mptcp_pm_data	pm;
+#ifdef CONFIG_BPF_SYSCALL
+	struct bpf_local_storage __rcu	*bpf_storage;
+#endif
 	struct mptcp_sched_ops	*sched;
 	struct {
 		u32	space;	/* bytes copied in last measurement window */
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6961a7b70028..f43cf69e47ea 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -943,6 +943,7 @@ enum bpf_map_type {
 	BPF_MAP_TYPE_BLOOM_FILTER,
 	BPF_MAP_TYPE_USER_RINGBUF,
 	BPF_MAP_TYPE_CGRP_STORAGE,
+	BPF_MAP_TYPE_MPTCP_STORAGE,
 };
 
 /* Note that tracing related programs such as
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 214f828ece6b..3365b6a34bb4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -168,6 +168,7 @@ static const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_BLOOM_FILTER]		= "bloom_filter",
 	[BPF_MAP_TYPE_USER_RINGBUF]             = "user_ringbuf",
 	[BPF_MAP_TYPE_CGRP_STORAGE]		= "cgrp_storage",
+	[BPF_MAP_TYPE_MPTCP_STORAGE]		= "mptcp_storage",
 };
 
 static const char * const prog_type_name[] = {
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 9c4db90b92b6..521cdc2dbcd2 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -308,6 +308,7 @@ static int probe_map_create(enum bpf_map_type map_type)
 	case BPF_MAP_TYPE_INODE_STORAGE:
 	case BPF_MAP_TYPE_TASK_STORAGE:
 	case BPF_MAP_TYPE_CGRP_STORAGE:
+	case BPF_MAP_TYPE_MPTCP_STORAGE:
 		btf_key_type_id = 1;
 		btf_value_type_id = 3;
 		value_size = 8;
-- 
2.35.3

