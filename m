Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7238CA7E
	for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PHGO5BYo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ovo10f9n3q4+N/3Fp+0gKjOcdLYo6ET4zzS3amKoT/IS5QPcvjGJJbgVe+B78x9OczrL14i7qYoTRyV7TWaGl96pjBDdeXqP9jU+c3EFmsHgv198GzU8x0U+fKDoGgszPpYmBecdP36JO7HiOH0PgBkX3V5S3rZvaD0nKISXC0/iP+2YthnYNflayKmm2b1GLvnprGGRYpmRGVoxRTi9/sR/gJCcbxJz+ll3EkSvjYL88UX0f7vnenYNmHSO5ESV4hbe15fVGbS7ZoEl2NQfHwuFc0xQCxSIR2OTdMXjgUmvT4wH4gHCMBbMGMP0lZPbSq4+FNZU+eAGmsojMVl8YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdLYbK7vXnu1Q5Sj+OUn839s8mJ1ffI2svEYGzcGgdM=;
 b=l22aClqUT35AkBw/fp6fQ3FkBoDSZH29HRjP0yyqD9gICTSn5zXMW099tULs/MPBYAXftcJsHQz5HKPNxvzgv4VJVuFCihN2QK9soRZDW5SA5W9ySj1ShPUDYg30aiWUGcjsr3d2LYfjGOolo9ZkUcHRig+jgKKj7v1d2lOJhcdCMq3ctjuiqTNGLjnRckq+5V99TmLN8Xz59e+HgLPyULgZYHNnKlY7TQsQVBCIKMYOd85VmC5jP5WNgOFVGlU6tOFMi+J1F3jwxfDgCj4A3l9Xh6dymDxmHyho5D0Qz51A4e15YkaPOVv9EC/4jj+l0CHQdWXAxLqubShd2kJI1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdLYbK7vXnu1Q5Sj+OUn839s8mJ1ffI2svEYGzcGgdM=;
 b=PHGO5BYoGHynrClKK94HQN8kZGhCkn2hvyd67Q501PxH39MKhewk30xeDUmChHj/fj8YhG1I7qurHwuXXVcLgIGwtklDpTsrXxkk9K8ISOBs/CXg8NGudexr3u3EJI9tScDEoe6gSWTDsqB69tDx8nfgo24CuhT1gIYZrCI+0oL7waEfV9ygDgWNnJFTVvHmjtSu/BRgu5Jyd6LraNXPwX38H+/PCVq39F1mv3/jB1+9D4F1iq7P96DdJUm0BnPP8RkjxVayFOGv1kAAYYCAk3v8q9OsDZLLpZ29ZrHalVQ/m1ii90xTdbrnIx6V5Sbn4JHo5Rqc4kLWjm5Og4dy/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7271.eurprd04.prod.outlook.com (2603:10a6:10:1a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.8; Fri, 17 Nov
 2023 08:56:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Fri, 17 Nov 2023
 08:56:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 05/26] mptcp: drop lookup_by_id parameter in lookup_addr
Date: Fri, 17 Nov 2023 16:55:58 +0800
Message-Id: <ea101bf9edcfa59db4de5420e3930c5ba3673779.1700210966.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700210966.git.geliang.tang@suse.com>
References: <cover.1700210966.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0201.apcprd04.prod.outlook.com
 (2603:1096:4:187::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBAPR04MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c657b68-77fd-43ed-4d75-08dbe74b1ed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dFMbWkSYHVmoSzwPlIgccgCoPdjgx2uJwE2u1HHCD2IVXNQIwySEzz6l891Tn6I5eVnhWPbmV7LuUl8vF6LY0pnFAARyVmRmUocxcaxbsLMG9qB+UOXwvMH0KAC3y6+vZu2Tza8kHKeMmmqSirKEjEsD7oXChiPJSBIwsgJuIKaxgVg/kwATcyOJWuRmCvEiXdoN+ncxQ/d1seWMPWeKXkcUJrIruNeMwQUtThG0uthbRVHk7VWyKbSfgVUUepxLppOAcbHvQAVdAKq59ML7zn/udhEdBxRy+BARIfwuQYk1AEUb3c/gQS5yw6E4ANsOvF45r4OElQztf3LdrtRibw32n4o3t1/52BDo6SvfHC5rmLSrG3dMbLY0o/aR3sflegMtJbSXPOSszeDt+FBHki5fvSyGsr8uv8BuK7daIFTqNSUciFiYSP1SJaSFVZ25Ruce2nFMqNU2tc+IdjDWp3cInvH/2SmI8u/HU9aAItzP/e0kub/OmKVfB87dKGHiy1CHPow0vp6HltBDNTS1SzYgMFZmLQv9gj8iuA+4xab9Nb3RA/mNR+E20dTXeJxg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(86362001)(38100700002)(36756003)(66946007)(66556008)(66476007)(6916009)(316002)(26005)(107886003)(2616005)(6512007)(6486002)(478600001)(6506007)(6666004)(5660300002)(44832011)(2906002)(8676002)(4326008)(8936002)(41300700001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fn41lS3o4uLlgH5P6IrqxvvmZYtXZBQfQS+G3Nz7s/AhcBu2y7INnNv6tssz?=
 =?us-ascii?Q?NZEuzeAPjDmfrUcUy8T0rfPXBlrcvXgLEilGrBjQHQ1HLeY0tZ1TQjs5gnBD?=
 =?us-ascii?Q?TnAA02PJNSoApmLOHAzwlSaEo8gkPSVtOBTG9RBI7f4XsdE4i1tN6+Bkvf2o?=
 =?us-ascii?Q?Mbppstc9A4nl7NODZC8iRpAUMxClJHDHVD+JCGtqTvMCnOhxzKXhmITNJgDR?=
 =?us-ascii?Q?ijNy9QQQ5hJw97H4H5CXm77ugNAxo6B4HZS//kMx21gbrkol5GrVSReJzu3j?=
 =?us-ascii?Q?3GiMdHw8SQgMzUuj/6RYRJHA7Vx0vZtitYKnLAhSd59mbpHSsk95GGvKnB06?=
 =?us-ascii?Q?NLkPTT8L8eF9zWAS1uqPl72Nu1uVmKLMLn8o/27OJx5RLlkrCFsgnugCPMlW?=
 =?us-ascii?Q?n2UahEQQniI8yCNaVp78XSXk1750G/7Xo7HwjpHiG3Uavd93FGlX5MjVSexz?=
 =?us-ascii?Q?Ty4mOIoNHZpPP6nZrxfzXJCq3vYxxuzdqePiCvcTDzxutW+OU+b2mimhi/cC?=
 =?us-ascii?Q?A1KFeuVCZSFNHi9RsGN6BLDFOco/9Dswh731yTuDkl/KtP5d6uWhVUia0ftg?=
 =?us-ascii?Q?5MRMqLYHbXrzZXatTAb2CLg1/EGC/ZwnpHgIAYU9fI9iHlVy0e7kb1UFTuPu?=
 =?us-ascii?Q?owIly+ZpIv87gVqmU/6tdEZXsgSNJ9elWYmHAoGb8qStmuBCrlCRz5vbYIPA?=
 =?us-ascii?Q?4oZ1C7ZQ5eXyv+FSZs83WRp86quDhmZWxl1rGc1XqIIjSZngds5ZiaJh2frV?=
 =?us-ascii?Q?YBABg9bIyYLVJ0ravZD5H6pjg2KES+Ek1l6FS+Xy+1u1CI6wUm8FjSVpIZRp?=
 =?us-ascii?Q?GhkyMiKF2Ak/hf5FnLs0POg1MX5RUQ7173querGcYOxhbikI2NTAC6FxvRVH?=
 =?us-ascii?Q?00G9XnDdCbNfWg3/k1lgQIBTTuLpflBnTkQs+UnYf4d117eO3M+3kT9TJNUs?=
 =?us-ascii?Q?SskvK3F5CfwbtWstvJCklx3hNjbZ12OiKkujtFFDKYuQb1LqzFfvk3PEDc/m?=
 =?us-ascii?Q?XNc9ZdYonoYm/YJRLg6NlpvS+OhhWqnK7osJWsA+JjRTXY5AdvoTXdobBR7M?=
 =?us-ascii?Q?sF9HLppHnwBLOXPvzsyeBKmOAoaCSe5v7QchWMP5a8hSOSnjMN7EvCjZC8n5?=
 =?us-ascii?Q?by9aXgPAdGgu3SAiPdrEQ9MMb0Voc3+ngksN0SfCXtg8Xq310ysQFG+RNRgT?=
 =?us-ascii?Q?Rl5GHosRE5vkt5idlVpekW5s9MIbak12turrp+hO9q4o00ZCQCkshlIbQ9gr?=
 =?us-ascii?Q?6eiLjC8UTliTJOpT6YgCpT4jBH9B3GWDn6nVRVDJNXnZTnNm6d08z/L1znuW?=
 =?us-ascii?Q?8b7XQSahtX7L2AVNm1hjVUN18rh+VpECSq8fTEOaos0aWDgEjzbG/aa02545?=
 =?us-ascii?Q?Ke0FQUV6sZ2Hd4yFkmlZrI3fmCouPVXG0hYJ3rT27zBMsal8PhmgwjBVP5hJ?=
 =?us-ascii?Q?psup33SA6lKT8BwscaS8Wlbz8ncLknU2nu+6ivk/LG/66qFQZvwKfKAhA8ha?=
 =?us-ascii?Q?qZeTsYcgkdna4NCwu+yyX+l3tQfikdoGw8u6+h293O8+vJO02XZjPQEFZlbE?=
 =?us-ascii?Q?Wh/FIF4bGA/p8bWu5wBqmrWYKQT8dQtMEGLqMmaC?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c657b68-77fd-43ed-4d75-08dbe74b1ed5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:56:43.1312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkfHN3fbuBWHxiR6z79/pDkb1VbkCzVF94DpnGX8v2yOvFL81ure6qLPKkG2G64br6FpOkx9toO3eVby4sVKgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7271

When the lookup_by_id parameter of __lookup_addr() is true, it's the same
as __lookup_addr_by_id(), it can be replaced by __lookup_addr_by_id()
directly. So drop this parameter, let __lookup_addr() only looks up address
on the local address list by comparing addresses in it, not address ids.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index dbf040e39af4..4cb52df57ba5 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -458,15 +458,12 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
 }
 
 static struct mptcp_pm_addr_entry *
-__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
-	      bool lookup_by_id)
+__lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, &pernet->local_addr_list, list) {
-		if ((!lookup_by_id &&
-		     mptcp_addresses_equal(&entry->addr, info, entry->addr.port)) ||
-		    (lookup_by_id && entry->addr.id == info->id))
+		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
 			return entry;
 	}
 	return NULL;
@@ -496,7 +493,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
 		rcu_read_lock();
-		entry = __lookup_addr(pernet, &mpc_addr, false);
+		entry = __lookup_addr(pernet, &mpc_addr);
 		if (entry) {
 			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
 			msk->mpc_endpoint_id = entry->addr.id;
@@ -1832,7 +1829,8 @@ int mptcp_pm_nl_set_flags(struct net *net, struct mptcp_pm_addr_entry *addr, u8
 	}
 
 	spin_lock_bh(&pernet->lock);
-	entry = __lookup_addr(pernet, &addr->addr, lookup_by_id);
+	entry = lookup_by_id ? __lookup_addr_by_id(pernet, addr->addr.id) :
+			       __lookup_addr(pernet, &addr->addr);
 	if (!entry) {
 		spin_unlock_bh(&pernet->lock);
 		return -EINVAL;
-- 
2.35.3

