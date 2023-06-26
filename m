Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2048.outbound.protection.outlook.com [40.107.241.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5EC7FA
	for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 02:24:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCsWLlKPZVa0wC8prxKxJfnmELHk0577Vz34NJv1Lpj3TmSjXh0KaTAokVmkZnKwPzgFVIiFAeD2YmmDmsjX0IBtCikZh5BCJbecU6NpmVYAXij589Airr5+nNJUawTO7SqZI5HLG1RNY/Cch1IcmR9C+9dBGyIgIq5h4JGdTb5COpWF5O3hvLN51ZQP/jlwZmuwOL6ZqHaGKDDkj+Xv9hVAv9SIC6V0XvX6LnIfg92d9k82SJxWAcVvcOPCh+1plMsMq1HoGVLvu3nT6qQfxtjiOLlfEBAQg7W3JAY1zN6MpnrNDolTNt7xO2PH+VAnULjlpbz/WmdqnTVz0E1djA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hp1JKoQDCuvHpzmx4z/JOo3IqIGgE5P22SInXVRcGfk=;
 b=eUtDHsLuRoRdBb7Fhi5q3vK8q2BV8XqjFxExuCNWFP0pZ9ohjE2KcDwMRsKKM0SWW1L4F5sJ8Uv6n0j9mhW3D+JbMSAGHpUHSDtoKwAXmhytzpbvfLINOcYMRm6CAKBKrsLCErr+A/TSq6B+t1NBvTxny8+zBQKUZ+X4kRylXDcBQ1syzVzEfU74vqg+Qv22FzcyDmHpc0k8TBZCWNmImVJlDcDuEAj5ZqDT63GMKJU4Ea4VDiGeeaBATlP7USID3qdnaje6lcIb7DuCGprvqkRlGqDV/r1wUMi3qDxU7xT8J2rbJ74Dt2YroNzpFl1Z8wJNAqAe3pEsPpmhhGZ2CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hp1JKoQDCuvHpzmx4z/JOo3IqIGgE5P22SInXVRcGfk=;
 b=ONfgXG3QHZSkUzPWhULk7QjQR3qBc98BibTLfWQlM5HqZF4X3LWuFrVuMx8hdG3cokn2dNo1dIJlab7GBX7qq2Egj9ArVT6Fzu6I34eW5JqZj7vyTiEdz9GG0a7dOOTe+I3xyW9Mox0SEgoCQpRUrre925XIX3CAunKTgQuFfgysFw6HzBLrKPsUZuKw2MECF5elZL3aN2O/WMjwUK9QlzBLJJVMd3X+YLIylnKBm49hLE7vRcNy4l7ZHe1Z1+yGx+tzlEoYmzrL9WmvFWgvDpLH2ASgnTC6mzzuDP/AQxDnrRxG+iVdY2LMF48TvyEdLyPSry6JX8D+vNQ3PGLwrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7088.eurprd04.prod.outlook.com (2603:10a6:800:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 02:24:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 02:24:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 08/13] bpf: Add mptcp_storage helpers
Date: Mon, 26 Jun 2023 10:23:09 +0800
Message-Id: <b2ec9149c3161152699aa6ac331d439b15a8380a.1687746021.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687746021.git.geliang.tang@suse.com>
References: <cover.1687746021.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: 9884669b-580e-4bef-4986-08db75ec6b43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	llnkZVZs3PCAxl8Q9bhShS08MGKx7M8S9zWpz6dcakALGHY+GJprlwt1codLkw/faJo41kRgSGNzOdE8L3Miq1AVhFwC3U7UFldixv3bFZVVW5IVpvI/vu5NQV5z9p+b0RTARmmDhS5zy/M9Dat1c34x3KAMjv5XDYiClGWyYpqwstyHu2rFFG42RaWjI9ElZT8ZqH6Dv2VhjPShAMEuN8KIr5PIxoLYWsbl8oOCkVXX7djPW5+dHyhzYzO5DsbyB7bE/r/eTSj9d2x9qg97BF6xlxjr/AWM2BQWrTMT4eWDy/9sx6H00AJyzwfsLj3KsEFLDrku+5fNGvFIJ2Q7w3XgP6aAwlEaCXL8/YvpajercLqBteeOZ1ebrLVUZQXKvRv3va0oAfRGjApgxkz7mrO8bXvnsKfmyB8nHOHNY1A3lgcG3zbberFm/OEo5qA7mPDUqvKQcYCrZWsvcahEIbvWsnUGfSALeidRCYFdwPPbO9wcssb1TgpFf18vEsiOBbeKJ/hHvOQAIWnIi+9BSZ+dYVDsI6iiBEIVwIftnrZWphK1tik0kDoqY9Sy4iyZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(6486002)(478600001)(83380400001)(2616005)(86362001)(66476007)(107886003)(186003)(26005)(30864003)(6506007)(2906002)(6512007)(6916009)(36756003)(4326008)(316002)(66556008)(66946007)(5660300002)(38100700002)(8936002)(44832011)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MlntkSzZuDZzV8+n5h+ZHzhMwsUwt0S9PzecpqU/J1ac0Lwcy6NMKURIAcP9?=
 =?us-ascii?Q?SD1RH6kkp1oKnsLseLy0TMWUiEs/mtXVIsvawhV/i6koI+yCDmqObBtMYoHl?=
 =?us-ascii?Q?nRsX57ASvNQJ2LUgSR9axQpkIv9MZFMduAVWjYLGA/US9xbQiarm1eoBQ8dL?=
 =?us-ascii?Q?03JwMGu0P2CKs5PkG0ibLNejAoPNKoAmSvrL6/JlWVIchsPU76uu030vdmJK?=
 =?us-ascii?Q?rIEKzBDjHg/eBTVyNWs/PNB7O7zh3gcdtTdgPGCLLIHsLsV0nKuynjWPj1Pp?=
 =?us-ascii?Q?zkaBJAH6rpRdXs3dUUaAhYe2yZkI6l2wZ8LlQN/YGky0TGKnyEPs/IW9SU+p?=
 =?us-ascii?Q?SWA9BffXA1dib1OD8zkB3siccWZ3WcwyVhB04eQ0JMjmjFTIARh2zW9uTYas?=
 =?us-ascii?Q?sdDXte3VwE7J7Tz2VGmh0y1MicEPvGTtfbv3M2jiGhFWm/VtVw8vqjlyMZGu?=
 =?us-ascii?Q?so4sSG2G5N/SiX+tqP/KeTid8kdSC2erUhLxBy3rL4Y90lYGvw5zMl5AGOpK?=
 =?us-ascii?Q?2B/Tkx/KSaYzZRriysXNFf7oK6paNERXMNzMr1JNcdRVd/Z1WDmlqBn4keGw?=
 =?us-ascii?Q?YIquBRZB5Jvv4KMv5Zroew/lLjBzS8jOwyuZI2OBejWU3B1iy0oFpPgITuk+?=
 =?us-ascii?Q?/WkkRV9V8cQzSnD8K4Wprf0ED3QFlJH+1URk3nEPF5V+EgymKA8H9+nnBIE6?=
 =?us-ascii?Q?Tkf2+L6E/AsQqpyWo2yazIP4OR+lowSsaM2p8L0ZYnTImfgrwfk5f0uNByKb?=
 =?us-ascii?Q?2it6to6aGt/sdJc5rktHRjA6ik5IQ9AR5ah+JmFze03Icu/2MjiA88rWM40T?=
 =?us-ascii?Q?OS9lb4QO2axIjv70LXLEsWjfw0dMWxYx/fTgFM5mliTTKVt7QqgjyqRcaPX6?=
 =?us-ascii?Q?fZLx6iLOzjddaCOI7Qrwgv4AFQFAzjO1bKqBqrYBOxHAwwDgr3fI0/y26Uct?=
 =?us-ascii?Q?ZYXvIkmJMNXpjLaP5WQLpHAkGdBufOj/61lXUQCVnphLylSMH3WGZ/T8fqPB?=
 =?us-ascii?Q?oOXsv6bOY4DdMfQFqZRW8cDA4suyKetJfMGDkzNqj1TP7l81HYEdKy0AP8Le?=
 =?us-ascii?Q?3X6rDXdfP14wRUxab6IHcNZZ+lk9lhaPTRPokS+VOVlLj+DlxyQucfiSFAbd?=
 =?us-ascii?Q?jDnYEhFi/MFqTNSjyWs84NLsI0C82E1qTSew5H22WfpwSVN9M7pNfAW140pI?=
 =?us-ascii?Q?bwUf5br8dPm/6P3kc7n7RxGb0GXDAWRjullLqTA9pTg3ui1mMZ2T8HFwmtoN?=
 =?us-ascii?Q?hDfOCUl1rA6EHnaX/ok8Dc2lFRuX2J1R79dqwxF5hDhJsvuxYLuU1bw23rdx?=
 =?us-ascii?Q?n+cVi4GZmKQX6n004ABBfkDO7ykUJosE11HIjYoXc/QvTN5saXLBR4oZy75Q?=
 =?us-ascii?Q?TMh0wP8r1cXKJOlp2tuJgarwGjwnyQ0aDGXQdrj+QYjESscSEGfx9OJDBVVl?=
 =?us-ascii?Q?1tejvHjrIn1GtX26WbzVXDKlAVIdqNYp6V6p9xLae1avV8D02k4tJy/V8Eu8?=
 =?us-ascii?Q?4Y8VdnuahodyIklWHocuqhk89HH1V1xmNkm4J/Hfb2iXnqVFVnFpZrzqCnlf?=
 =?us-ascii?Q?kM3poUEx2oVHUBtgoGFySobjEpZsQxtQRAB5l1rU?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9884669b-580e-4bef-4986-08db75ec6b43
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 02:24:07.8107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVG60Z36ZswMyXWxmxPnM/bLHqM1Vq53jREwXeoJZTo7kg83125t3tSLuN9onHErIVA59VEPXfuP9LrTDxDEMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7088

Add two helpers bpf_mptcp_storage_get() and bpf_mptcp_storage_delete()
for mptcp_storage map type to get or delete a bpf_local_storage from
the given msk.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/linux/bpf.h            |  2 +
 include/linux/btf_ids.h        |  1 +
 include/uapi/linux/bpf.h       | 39 ++++++++++++++++
 kernel/bpf/helpers.c           |  4 ++
 kernel/bpf/verifier.c          | 13 +++++-
 net/mptcp/bpf.c                | 84 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 39 ++++++++++++++++
 7 files changed, 181 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f58895830ada..ac4b5748451a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2909,6 +2909,8 @@ extern const struct bpf_func_proto bpf_get_retval_proto;
 extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
 extern const struct bpf_func_proto bpf_cgrp_storage_get_proto;
 extern const struct bpf_func_proto bpf_cgrp_storage_delete_proto;
+extern const struct bpf_func_proto bpf_mptcp_storage_get_proto;
+extern const struct bpf_func_proto bpf_mptcp_storage_delete_proto;
 
 const struct bpf_func_proto *tracing_prog_func_proto(
   enum bpf_func_id func_id, const struct bpf_prog *prog);
diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 00950cc03bff..abd56cfcb03f 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -267,5 +267,6 @@ MAX_BTF_TRACING_TYPE,
 extern u32 btf_tracing_ids[];
 extern u32 bpf_cgroup_btf_id[];
 extern u32 bpf_local_storage_map_btf_id[];
+extern u32 bpf_mptcp_btf_id[];
 
 #endif
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f43cf69e47ea..137e0620fd69 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5570,6 +5570,43 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * void *bpf_mptcp_storage_get(struct bpf_map *map, struct mptcp_sock *msk, void *value, u64 flags)
+ *	Description
+ *		Get a bpf_local_storage from the *msk*.
+ *
+ *		Logically, it could be thought of as getting the value from
+ *		a *map* with *msk* as the **key**.  From this
+ *		perspective,  the usage is not much different from
+ *		**bpf_map_lookup_elem**\ (*map*, **&**\ *msk*) except this
+ *		helper enforces the key must be a mptcp_sock and the map must also
+ *		be a **BPF_MAP_TYPE_MPTCP_STORAGE**.
+ *
+ *		Underneath, the value is stored locally at *msk* instead of
+ *		the *map*.  The *map* is used as the bpf-local-storage
+ *		"type". The bpf-local-storage "type" (i.e. the *map*) is
+ *		searched against all bpf_local_storage residing at *msk*.
+ *
+ *		An optional *flags* (**BPF_LOCAL_STORAGE_GET_F_CREATE**) can be
+ *		used such that a new bpf_local_storage will be
+ *		created if one does not exist.  *value* can be used
+ *		together with **BPF_LOCAL_STORAGE_GET_F_CREATE** to specify
+ *		the initial value of a bpf_local_storage.  If *value* is
+ *		**NULL**, the new bpf_local_storage will be zero initialized.
+ *	Return
+ *		A bpf_local_storage pointer is returned on success.
+ *
+ *		**NULL** if not found or there was an error in adding
+ *		a new bpf_local_storage.
+ *
+ * long bpf_mptcp_storage_delete(struct bpf_map *map, struct mptcp_sock *msk)
+ *	Description
+ *		Delete a bpf_local_storage from the *msk*.
+ *
+ *	Return
+ *		0 on success.
+ *
+ *		**-ENOENT** if the bpf_local_storage cannot be found.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5784,6 +5821,8 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(mptcp_storage_get, 212, ##ctx)		\
+	FN(mptcp_storage_delete, 213, ##ctx)		\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 4ef4c4f8a355..381b680007fb 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1768,6 +1768,10 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 	case BPF_FUNC_get_current_ancestor_cgroup_id:
 		return &bpf_get_current_ancestor_cgroup_id_proto;
 #endif
+	case BPF_FUNC_mptcp_storage_get:
+		return &bpf_mptcp_storage_get_proto;
+	case BPF_FUNC_mptcp_storage_delete:
+		return &bpf_mptcp_storage_delete_proto;
 	default:
 		break;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d8482a4ef465..c7479628acf7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -553,7 +553,8 @@ static bool is_storage_get_function(enum bpf_func_id func_id)
 	return func_id == BPF_FUNC_sk_storage_get ||
 	       func_id == BPF_FUNC_inode_storage_get ||
 	       func_id == BPF_FUNC_task_storage_get ||
-	       func_id == BPF_FUNC_cgrp_storage_get;
+	       func_id == BPF_FUNC_cgrp_storage_get ||
+	       func_id == BPF_FUNC_mptcp_storage_get;
 }
 
 static bool helper_multiple_ref_obj_use(enum bpf_func_id func_id,
@@ -8241,6 +8242,11 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		    func_id != BPF_FUNC_map_push_elem)
 			goto error;
 		break;
+	case BPF_MAP_TYPE_MPTCP_STORAGE:
+		if (func_id != BPF_FUNC_mptcp_storage_get &&
+		    func_id != BPF_FUNC_mptcp_storage_delete)
+			goto error;
+		break;
 	default:
 		break;
 	}
@@ -8353,6 +8359,11 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		if (map->map_type != BPF_MAP_TYPE_CGRP_STORAGE)
 			goto error;
 		break;
+	case BPF_FUNC_mptcp_storage_get:
+	case BPF_FUNC_mptcp_storage_delete:
+		if (map->map_type != BPF_MAP_TYPE_MPTCP_STORAGE)
+			goto error;
+		break;
 	default:
 		break;
 	}
diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 764c670e843b..0bf3409cf288 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -201,6 +201,17 @@ static void bpf_mptcp_storage_unlock(void)
 	migrate_enable();
 }
 
+static bool bpf_mptcp_storage_trylock(void)
+{
+	migrate_disable();
+	if (unlikely(this_cpu_inc_return(bpf_mptcp_storage_busy) != 1)) {
+		this_cpu_dec(bpf_mptcp_storage_busy);
+		migrate_enable();
+		return false;
+	}
+	return true;
+}
+
 static struct bpf_local_storage __rcu **mptcp_storage_ptr(void *owner)
 {
 	struct mptcp_sock *msk = owner;
@@ -305,6 +316,59 @@ static long bpf_mptcp_storage_delete_elem(struct bpf_map *map, void *key)
 	return ret;
 }
 
+/* Called by bpf_mptcp_storage_get*() helpers */
+static void *__bpf_mptcp_storage_get(struct bpf_map *map,
+				     struct mptcp_sock *msk, void *value,
+				     u64 flags, gfp_t gfp_flags, bool nobusy)
+{
+        struct bpf_local_storage_data *sdata;
+
+        sdata = mptcp_storage_lookup(msk, map, nobusy);
+        if (sdata)
+                return sdata->data;
+
+        if ((flags & BPF_LOCAL_STORAGE_GET_F_CREATE) && nobusy) {
+                sdata = bpf_local_storage_update(
+                        msk, (struct bpf_local_storage_map *)map, value,
+                        BPF_NOEXIST, gfp_flags);
+                return IS_ERR(sdata) ? NULL : sdata->data;
+        }
+
+        return NULL;
+}
+
+/* *gfp_flags* is a hidden argument provided by the verifier */
+BPF_CALL_5(bpf_mptcp_storage_get, struct bpf_map *, map, struct mptcp_sock *, msk,
+	   void *, value, u64, flags, gfp_t, gfp_flags)
+{
+	void *data;
+
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
+	if (flags & ~BPF_LOCAL_STORAGE_GET_F_CREATE || !msk)
+		return (unsigned long)NULL;
+
+	bpf_mptcp_storage_lock();
+	data = __bpf_mptcp_storage_get(map, msk, value, flags, gfp_flags, true);
+	bpf_mptcp_storage_unlock();
+	return (unsigned long)data;
+}
+
+BPF_CALL_2(bpf_mptcp_storage_delete, struct bpf_map *, map, struct mptcp_sock *, msk)
+{
+	int ret;
+
+	WARN_ON_ONCE(!bpf_rcu_lock_held());
+	if (!msk)
+		return -EINVAL;
+
+	if (!bpf_mptcp_storage_trylock())
+		return -EBUSY;
+
+	ret = mptcp_storage_delete(msk, map);
+	bpf_mptcp_storage_unlock();
+	return ret;
+}
+
 static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
 {
 	return -ENOTSUPP;
@@ -334,6 +398,26 @@ const struct bpf_map_ops mptcp_storage_map_ops = {
 	.map_btf_id = &bpf_local_storage_map_btf_id[0],
 	.map_owner_storage_ptr = mptcp_storage_ptr,
 };
+
+const struct bpf_func_proto bpf_mptcp_storage_get_proto = {
+	.func = bpf_mptcp_storage_get,
+	.gpl_only = false,
+	.ret_type = RET_PTR_TO_MAP_VALUE_OR_NULL,
+	.arg1_type = ARG_CONST_MAP_PTR,
+	.arg2_type = ARG_PTR_TO_BTF_ID_OR_NULL,
+	.arg2_btf_id = &bpf_mptcp_btf_id[0],
+	.arg3_type = ARG_PTR_TO_MAP_VALUE_OR_NULL,
+	.arg4_type = ARG_ANYTHING,
+};
+
+const struct bpf_func_proto bpf_mptcp_storage_delete_proto = {
+	.func           = bpf_mptcp_storage_delete,
+	.gpl_only       = false,
+	.ret_type       = RET_INTEGER,
+	.arg1_type      = ARG_CONST_MAP_PTR,
+	.arg2_type      = ARG_PTR_TO_BTF_ID_OR_NULL,
+	.arg2_btf_id    = &bpf_mptcp_btf_id[0],
+};
 #endif /* CONFIG_BPF_JIT */
 
 struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index f43cf69e47ea..137e0620fd69 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5570,6 +5570,43 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * void *bpf_mptcp_storage_get(struct bpf_map *map, struct mptcp_sock *msk, void *value, u64 flags)
+ *	Description
+ *		Get a bpf_local_storage from the *msk*.
+ *
+ *		Logically, it could be thought of as getting the value from
+ *		a *map* with *msk* as the **key**.  From this
+ *		perspective,  the usage is not much different from
+ *		**bpf_map_lookup_elem**\ (*map*, **&**\ *msk*) except this
+ *		helper enforces the key must be a mptcp_sock and the map must also
+ *		be a **BPF_MAP_TYPE_MPTCP_STORAGE**.
+ *
+ *		Underneath, the value is stored locally at *msk* instead of
+ *		the *map*.  The *map* is used as the bpf-local-storage
+ *		"type". The bpf-local-storage "type" (i.e. the *map*) is
+ *		searched against all bpf_local_storage residing at *msk*.
+ *
+ *		An optional *flags* (**BPF_LOCAL_STORAGE_GET_F_CREATE**) can be
+ *		used such that a new bpf_local_storage will be
+ *		created if one does not exist.  *value* can be used
+ *		together with **BPF_LOCAL_STORAGE_GET_F_CREATE** to specify
+ *		the initial value of a bpf_local_storage.  If *value* is
+ *		**NULL**, the new bpf_local_storage will be zero initialized.
+ *	Return
+ *		A bpf_local_storage pointer is returned on success.
+ *
+ *		**NULL** if not found or there was an error in adding
+ *		a new bpf_local_storage.
+ *
+ * long bpf_mptcp_storage_delete(struct bpf_map *map, struct mptcp_sock *msk)
+ *	Description
+ *		Delete a bpf_local_storage from the *msk*.
+ *
+ *	Return
+ *		0 on success.
+ *
+ *		**-ENOENT** if the bpf_local_storage cannot be found.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5784,6 +5821,8 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(mptcp_storage_get, 212, ##ctx)		\
+	FN(mptcp_storage_delete, 213, ##ctx)		\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
-- 
2.35.3

