Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2069.outbound.protection.outlook.com [40.107.6.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289A610FE
	for <mptcp@lists.linux.dev>; Wed,  5 Jul 2023 06:57:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGBRqwiCTf0oSyrShEGpdqQIuugJvYoFsdA0aUFqjbeuWxqUFdiSwYvpQk938kOp+/dCURFqvnXf8NtwD1nTJW7W7bpW73kWb40YWhKZxtjum7Wleh1A38jbhLDfqRloQ6jozGbR6BzJtcU/HULBFKIl+lDmAEe6yoeQOhtxII1uNCSuT4RcI9DShvJ8Ni2uOz0a4ohltbKhleOEI6C02vaPKpXdoDOF7NIEN4O3RcRna3fMGiwP/OFinYwk0RzJ3LKWvS0NuAuMpon6AW7FfYjN4aOHMwQBUlgEqUlrUfQ5Mb1o3da2HOKP6D4Vi7ZDnJupbljqCTx5cz2UmAfhXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCbo5XqEqbC+uIC16R9lbl1b4dXbL9eVmWQcvZ28mp8=;
 b=n9V2E+dNHPlqPh22i4pYeWdEMRB92a5hqfMzTApp3/2JOEbbMdGwlI2RR5IJzmjt1Tngg7DOk856walyoV510KCkqumtkL+uDXhU1mUzSSvFvz1E6wrF+w9pYPvft5raEApI/G8AXeUU8SlnlPeR/dc5MJhzug6fNeZbJa7fnP1rffXwg9zKj3XhFsuAea7+ME3K90s4NCuJHmK/+U/4VMb5xEZeEDCXMmP2zK6Yx59w/L+1UCpZ6Z5g1B5X+BhWsH8j2u7NKsL21VuxoR1NvNMxviTxsdDSFZ4B2cye/PSWsXfHsTahKoflKdhkR/43aoHuC56uNYkOKzJUPuBarA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCbo5XqEqbC+uIC16R9lbl1b4dXbL9eVmWQcvZ28mp8=;
 b=GpB1nztYm0P8tiTh3Kd+TY3UpiJwabek3Oww/CsCKtu//4R+X/vEU5et7rxe4MgTQnx8JGKporIyicS6meB/39lFdrQZmlFGI+7HecD5dgZ3f7btW4DmARUZXS8ZQ6bQDcH/D9OHg9LOrzP2zUoYoydEKmcpdUg/TuzLS5aSUNVHXFjnFR+qke085Dvzr0UjzqYxyUKRfzCF2Vt/1OiFStRJfbEabbb+mvou2kQIAR4ipTk6LBhYENy167jX4NZEQYSkIC4mM0I4fc8cKq5BK1/A5tuRasbWpiwWnu51U0zW8SwbC5KJ24iPWKaoi9sUSwxPsBhFQX0qb5QICMiJNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB7187.eurprd04.prod.outlook.com (2603:10a6:208:196::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 06:57:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 06:57:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 2/7] bpf: Run a sockinit program
Date: Wed,  5 Jul 2023 14:56:36 +0800
Message-Id: <b26b90dc9620fd1b3cdf90b8215a75387304f520.1688540074.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688540074.git.geliang.tang@suse.com>
References: <cover.1688540074.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:405:1::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: 50dcbaa9-a8c2-43b3-f5db-08db7d250a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TUUwVhkUvuw+l+j+p2VqpQi9uQPPOKxe2iRCSga398inzYHQwtW/Q5KFPc2h6paq9a/dJmVZufGkoAriqlkg9ffuLIk/I3caznIa0N+e1rC0Rf7w8zRV6FYZD3aHIFOP7Y5OdXBWPpOmIxA1mvvNnJGMfpIof4cddjbW3M8RZ7nnn1t0/udc2E/DqlDM4TsPwbwqDnnZFNwSXLqkZo4jUTYULrytp59qnjuS8m2buwnjIk/im+yST88Q/NutaMUjFIVxoREN978hxlfMf/+coXz6IhDpTdFScIei0iG8WXdNbJ5sla+EKP5KofHiaDw3PmGwmX13wr6eeAJiIT79OMVx+Gh+BJZsPjnF5IQ+s4EawOYgDkPWFYjDQjhwXQpGfJF5SACzxE5PABja5NtljUzBpk1y7DzHQBwmtXb4Noo5rSmC6F1WODG62Bs/7ODhb4KnAhJeyLh+it8a4zTVROhv2wLCrAiyHTam2f533efCQsEZdmF5x0q95uReHshp7x8xdOEGczxaZuLGmICEsT02oU/wAWy1ZbY7Z3heJ7bQcekRvh3adizQunZV4pAaxjyPTdkdqPLW/v5BTgut+1RobQyCMf5zfZOwzidfk88=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199021)(44832011)(5660300002)(8676002)(8936002)(41300700001)(316002)(2906002)(83380400001)(2616005)(4326008)(6916009)(38100700002)(66946007)(66476007)(66556008)(86362001)(186003)(6506007)(26005)(107886003)(478600001)(6486002)(36756003)(6512007)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WuBMHblN55ICC1wpiPi9vbcop1lxy5mCl3+pjOjHM09syE2yVLSEzPUzuVwg?=
 =?us-ascii?Q?jBgXCtcuG9qzGwxBTf9/R2DiSPXA704A/Z4+uPduMLQR9k7kRO6rEKA99fZP?=
 =?us-ascii?Q?rPR/18i5NEUtiOeeMah2WWcprc+T24AAYBZa3yXBNx8ubiUhzztKnDHFyiOX?=
 =?us-ascii?Q?fb9Xq4p2gbL+FwZ30ttyKfEVZFqEFYq2msijy/3KaCZCx2POM0sIQbFPWzmV?=
 =?us-ascii?Q?ompc82ie7i1Aw5ypLJ00L3yCftbCB9J+QeXRrqE/qKgdUo5YpYVE/9OyHSRh?=
 =?us-ascii?Q?VXH67h0utvV2PebAInHB98spghXfxJ9jGR905EUfQCAbhCRyMJrFWaj2L0xr?=
 =?us-ascii?Q?rljDaS27BcTBHs5I6HZ/svxo2ImTNI17wQTn6zaNFJbBv2DQPPP+OKe7j8NJ?=
 =?us-ascii?Q?QIGDv5ubPfWJK4qDAJHnN4LdcJOHPf5Ytlh/NCuXs44qCp7r9kjwCElzxz+A?=
 =?us-ascii?Q?XoE90CSUYJ++Cp7vRgsZKUcwnga4y0dSxnX/ZWXh+4RcH97t4BUKTmMEpLRs?=
 =?us-ascii?Q?oGGZEy4I0mmTMVFI4HZEQ0VP9jhZU4VhyurITxo1TC1WMh1zBvYI2i1bGp4X?=
 =?us-ascii?Q?LhNdO7AMuP8OFLuqHy9Ii3Aa8aN1UDAXIJydDQoT+lNeJJDn7Gt5FeGjzTLL?=
 =?us-ascii?Q?fZArvLFJBAxMYa4hdbOJxO4D4iPVr9ftLSYoxUQxbmsvVW/GTrUW+qMtOlfu?=
 =?us-ascii?Q?tFTNUVSsli1qBmRCq4UDJjPap+sEZoXuutk1w6YQLbcIu9Z3eR4asPkx1Qes?=
 =?us-ascii?Q?IuLuWcBn94aNwjfvjtOMlz5au0g4JhI3RZV6uXWdGLT3/Z/BDDWCvn5HLFYl?=
 =?us-ascii?Q?fC/48DGWnrSU4dfgM6n0BLWk04P7E2l7CtMMXCOimREf35t7MRAJrMn5VOCn?=
 =?us-ascii?Q?lhfC0xXfBPW85JaShhUGoGqovoZk5DyrzoHxcnaojkooKE260KT1zNzHxyyo?=
 =?us-ascii?Q?LQbQyJIzyvYTETCBf7ZN7RZc7yfS1Y6d9r2d9E66W6AQYCd4P9QPWbTeyAVd?=
 =?us-ascii?Q?qOeTKUbrDcUIX4B5ArdUWDahDGBIYWhB5ivZ9/0360funZTyFymdOEYyYp1d?=
 =?us-ascii?Q?5fhddmBE2fLCB2NEhezuSyatTKbbBlcJ/W5bmvGiHHlVcwt6/Rjlh6eQ0ccm?=
 =?us-ascii?Q?kGglDyPH4cU95PCL44DghQpCZlzXxUm7rt8caUE03eK5N7jjSifr3rLsOtO0?=
 =?us-ascii?Q?yGhUBduh4gFLupy1bv/4TjwvLcjIo3tJRtIOMeVOYXR8yjXGV1L8yhK428W8?=
 =?us-ascii?Q?B1zVKAQ8So9O009agp5x4dj0Yc+RWXekXCNr762YbJyoH6265jDc7rIuQaar?=
 =?us-ascii?Q?t6OdQW3FZinzOEUUBYKxOs6Qom+vax332iRRJwgErzfKLHNbNDG+x4spQttW?=
 =?us-ascii?Q?Jw9Syd+3QdQUb/CFOXEZ9+QQuzP9FrX1W8qaRwSo2x/WErQGCRfCPLt8N4qi?=
 =?us-ascii?Q?Eg/6our5FDYD7vVOSKateJxlcv3HfEJlmPigj6zGL+7U22acMNZ/TJIE9orJ?=
 =?us-ascii?Q?K4dOu1RxWCaWP3DAKZXjE1p7a8W3zSF0Sj60j4rEnA38Zdpk1Gk94ePI7Nhx?=
 =?us-ascii?Q?v+0mEw96j0ZSDrBmb8y9K6DTucZEg1Zg60fps5X4?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50dcbaa9-a8c2-43b3-f5db-08db7d250a4a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:57:04.6812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ll4wT0/uyfJjEBN6lQhVqnUHvDHWBha1A9mh1ODjKntDwo5JcnGgpzxuUdyfAmdiRFwo/Nci3N4Lv2qFnOrULA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7187

This patch defines BPF_CGROUP_RUN_PROG_SOCKINIT() helper, and implements
__cgroup_bpf_run_sockinit() helper to run a sockinit program.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/linux/bpf-cgroup-defs.h |  1 +
 include/linux/bpf-cgroup.h      | 14 ++++++++++++++
 kernel/bpf/cgroup.c             | 24 ++++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-defs.h
index 7b121bd780eb..aa9ee82f5d20 100644
--- a/include/linux/bpf-cgroup-defs.h
+++ b/include/linux/bpf-cgroup-defs.h
@@ -37,6 +37,7 @@ enum cgroup_bpf_attach_type {
 	CGROUP_UDP6_RECVMSG,
 	CGROUP_GETSOCKOPT,
 	CGROUP_SETSOCKOPT,
+	CGROUP_SOCKINIT,
 	CGROUP_INET4_GETPEERNAME,
 	CGROUP_INET6_GETPEERNAME,
 	CGROUP_INET4_GETSOCKNAME,
diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 57e9e109257e..a2f58f0d2260 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -57,6 +57,7 @@ to_cgroup_bpf_attach_type(enum bpf_attach_type attach_type)
 	CGROUP_ATYPE(CGROUP_UDP6_RECVMSG);
 	CGROUP_ATYPE(CGROUP_GETSOCKOPT);
 	CGROUP_ATYPE(CGROUP_SETSOCKOPT);
+	CGROUP_ATYPE(CGROUP_SOCKINIT);
 	CGROUP_ATYPE(CGROUP_INET4_GETPEERNAME);
 	CGROUP_ATYPE(CGROUP_INET6_GETPEERNAME);
 	CGROUP_ATYPE(CGROUP_INET4_GETSOCKNAME);
@@ -148,6 +149,9 @@ int __cgroup_bpf_run_filter_getsockopt_kern(struct sock *sk, int level,
 					    int optname, void *optval,
 					    int *optlen, int retval);
 
+int __cgroup_bpf_run_sockinit(int *family, int *type, int *protocol,
+			      enum cgroup_bpf_attach_type atype);
+
 static inline enum bpf_cgroup_storage_type cgroup_storage_type(
 	struct bpf_map *map)
 {
@@ -407,6 +411,15 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 	__ret;								       \
 })
 
+#define BPF_CGROUP_RUN_PROG_SOCKINIT(family, type, protocol)		       \
+({									       \
+	int __ret = 0;							       \
+	if (cgroup_bpf_enabled(CGROUP_SOCKINIT))			       \
+		__ret = __cgroup_bpf_run_sockinit(family, type, protocol,      \
+						  CGROUP_SOCKINIT);	       \
+	__ret;								       \
+})
+
 int cgroup_bpf_prog_attach(const union bpf_attr *attr,
 			   enum bpf_prog_type ptype, struct bpf_prog *prog);
 int cgroup_bpf_prog_detach(const union bpf_attr *attr,
@@ -505,6 +518,7 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
 					    optlen, retval) ({ retval; })
 #define BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock, level, optname, optval, optlen, \
 				       kernel_optval) ({ 0; })
+#define BPF_CGROUP_RUN_PROG_SOCKINIT(family, type, protocol) ({ 0; })
 
 #define for_each_cgroup_storage_type(stype) for (; false; )
 
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 93b9f404a007..fe294e4d618c 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1996,6 +1996,30 @@ int __cgroup_bpf_run_filter_getsockopt_kern(struct sock *sk, int level,
 
 	return ret;
 }
+
+int __cgroup_bpf_run_sockinit(int *family, int *type, int *protocol,
+			      enum cgroup_bpf_attach_type atype)
+{
+	struct bpf_sockinit_ctx ctx = {
+		.family		= *family,
+		.type		= *type,
+		.protocol	= *protocol,
+	};
+	struct cgroup *cgrp;
+	int ret;
+
+	rcu_read_lock();
+	cgrp = task_dfl_cgroup(current);
+	ret = bpf_prog_run_array_cg(&cgrp->bpf, atype, &ctx, bpf_prog_run, 0,
+				    NULL);
+	rcu_read_unlock();
+
+	*family		= ctx.family;
+	*type		= ctx.type;
+	*protocol	= ctx.protocol;
+
+	return ret;
+}
 #endif
 
 static ssize_t sysctl_cpy_dir(const struct ctl_dir *dir, char **bufp,
-- 
2.35.3

