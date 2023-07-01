Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEBC3D67
	for <mptcp@lists.linux.dev>; Sat,  1 Jul 2023 12:57:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naXWQY9dkaOgIXmtOCMJtqKqLplQhFSV+pyMjQxdoePNE96dbUsRr/XKfq6KeXH5nNbOxK9lZ894OyhQAt4dMWiSYltEsOMZYVe/cf06LeNu0Icr2dA7mBFz0rX0K+XK1MHrnt7AZEU7fBkZPqABrw6eCd5/6PlkRaWeT0dnVIHjDpdrA2kCYjqSFFTQUaZ/shsspdnj51O7Id/rxZfboSh0mZnB+v/8QBvf0c3Qp8ayCnNLwmf0KCGDTw4GOkkSakWJGNzqalyik3QDAwpPw+asqvsfFJ0qPwoAx8RImjiPyR3NpxMScS/bzFUEBSPDLubKABlcPkWs94/hsSoQmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pczfCTBDUN+4PxNRArlR9nYhsPd7NUF81cZB8rd1o7U=;
 b=hY4PBrIUbj1mys8lgpVBC9HvDaamH0asEXX6GQ00bv/K1vqHhA1jNLLxIsysIyuoxxSbxOXCGbr1SQiAFiWAj+918gG8CY7vKTYdD5N+ZKTkdRx7/s7D60WMlUIjOAIyqMeJpOykJLhbo3xN9O4D3/Lit3lOafq37h7XJkAnB9YRWOnRB0S2joQy9DdoVw4K/4nvW3YF3Vjx1AzXmPYqZf8qlvbnv4Zpd3SDcJSDuBLfizerlFTw4viGuvQlILwcQS7C57loztLpHtA2VUx7SwiT7IldR/pDSVn9jjWsnfF9/0wro1pMSMehjZEAdshDaLuzZzPzh+qqCwsANHEx1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pczfCTBDUN+4PxNRArlR9nYhsPd7NUF81cZB8rd1o7U=;
 b=k1caY3GW3ei4pl0+T2PID+jFmSSyJ0NGnQGIXGi/7hhmX3H/U81kHTXQsJ8Gm4Use2HhE1/oOsc2cY8MwAN1l1pekWByIJgnv5l90fdRuCi3R93XbW6rYOuDSmaMSdzWE3b/oQCLKGjczwjQaLCQyZiEFHOMuHSfdd7YBmWMTz7reWPcKvGzw60ssoJiVI2QQT3lyeDMzJW+GdprYp+qLcfZsM0EZ6ttc4oTDiNeIVFOTKzNUFsnAGGEKfCJKu+duexz3Iutr6XnLy1MtAo3LLCQjPg8I9Xj94zyrbWf7YoY4bA/A4oO8RS/ESwo9SYcqoHZmi9w9N8fCGatthjGLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7553.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Sat, 1 Jul
 2023 12:57:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6544.019; Sat, 1 Jul 2023
 12:57:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 2/4] bpf: Add bpf_mptcpify helper
Date: Sat,  1 Jul 2023 20:56:58 +0800
Message-Id: <daf3d1e26f19ee83b427ef9e17183cd09fc26de6.1688215769.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688215769.git.geliang.tang@suse.com>
References: <cover.1688215769.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0003.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f78e02-9ae2-406e-c470-08db7a32bbf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4qUKDj5PfkS/VNyKaRcNnhCcwVBUMlK9f2ORIuGEINPcPHZcFNFzsSDmd1lUKd630Mxqle3ZFYiWr+NCASROPU9uktU7AsN66eHO8ZNJEFqv/5p2Wmw5qsqSh60/pPLLOFri2gg2X71JZgloyvB2jZpOaAfTdJ9ue4vK3kcq7/490R19fj9wTrlImY3MkN5xYQzTFurJaqFexUgHUQaDY/bFrSFvnYLwqJEto3dSvSvRoBvudxeYmswEtxNFAp4NVpgoxuVel8NROzlvmO7uAzoMewoZn6AGvdn5Va73ctdk4oCFzxbu1MtI7lazr/ox5kPX4fxAJ2aXAHOrH5uXXUXc1pnuYt39q3L8McyPPOH+OqJWxOu1VSycyXHxy5VWvTGRhMaw4fqNkg+hbnpdQE7nPNbo8BVKIOpln2L2tOPLPSGmzFSlXbfKQKoLPx/gIvZJVJ+oX4PAK6EHdcVZ3YLd/pFLItTKRHKJ+SvJ14RgOS2ZJ4gW0xKqXLG8nsIICokK7YKeSNSJvGVz4pzAWGU1RtrBuhhxt8lFNK1v7pYxHfual3KeKGpHU/dr9Yop
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199021)(5660300002)(8676002)(8936002)(107886003)(36756003)(478600001)(6916009)(4326008)(6666004)(6486002)(66476007)(66556008)(66946007)(316002)(6512007)(41300700001)(38100700002)(44832011)(186003)(2616005)(6506007)(26005)(83380400001)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FP1UoagcIyp82UFj7YGd5cMJqBffTdwnacdpi2ezrjFPEMVr77rATIchqfBa?=
 =?us-ascii?Q?V/kcGjaKvTNW4FC4A/HW8zcPcTUqCKpxxWtNirLHe0v3asqjs53iaiDLqsdg?=
 =?us-ascii?Q?hecDD2Sv/zVAhgmVLK8pwLWt7PNnYHPLGSKLa7XODyZqR66glOvlgju6Nwur?=
 =?us-ascii?Q?DBb+DrhSw6/G6xu4L/ob5tT1CuQ2dNyuzaq2QpMVmTSqfMR/0c8B61N1aTcK?=
 =?us-ascii?Q?Oc7+vGUFZJsLf9gCJx0lS818rK9p6vLEqWAL0qyWEWUtjiey1GGSJGUIxz5+?=
 =?us-ascii?Q?6UplRa63EFkscgO3v+ge5aumHBzxIQHzY+ptHmLDFcsaFl6Hny39F06VRNS+?=
 =?us-ascii?Q?y1tN32iKh9GsKrA+MNEvXaGfAbH94iaFT/+vL93+LxWWLAqIxSq1HldpMYIg?=
 =?us-ascii?Q?a+55gTCKYdy33mbhTulWfQi3Pt2ngKRCk7p1+cXXUa87alA6D8Sg0zFktN7P?=
 =?us-ascii?Q?0SI/BhKNLiTiVGvFeC96ubftRoBHVnHvma7DZMmrH7VF3LunCue8rYWGONuU?=
 =?us-ascii?Q?1TYv6lYm41UdAAx3B3rNDHMsOF0Cr7FaewswmW9S5out8tKLN3JXecBIH4FT?=
 =?us-ascii?Q?aiuzKyToOvdnlVeZyV29Dwtc1igdPB/FvUrpKyjDbDhGGpb/3gD94pKQTzv4?=
 =?us-ascii?Q?gHCBrMwy01nn2Ep+Zju69TZQE0PgPofDxW3Zg2dI7wxwCyuy2MRCbTfE58Ju?=
 =?us-ascii?Q?xOpkwJJyci4r+dZMIQGfxXFFJ8F8LQ5bRoMYyJZnjDKSWtm7uWiYjMVdhbXv?=
 =?us-ascii?Q?yV6lOfIgnO4fESDgWBC0Snlv94i97FPcplPxz4n4TaJA7zAtHdDOvUdzsFvg?=
 =?us-ascii?Q?twVJWMP5PiKpr02vYONqcWOcsKTPOhDpu01QVafxFJX8uD7elOKEgt4sYPit?=
 =?us-ascii?Q?KaxQHBBYL6g0L6zi/l2cxYqvN3AyEwkzMQxGDapT+TPw+I5qD5FNQYN65ZAx?=
 =?us-ascii?Q?R6eDX3e98aE5PHPUkB0+xVhCS/SiSoebE3B0Z6PGjmx0UX7Qpj7YNu/8Gm45?=
 =?us-ascii?Q?3cUzVQhWP3AOH0KF70bQt1WeT0VcU6FfHpNtZyodWE1KwdhOw6FgLOjkfelF?=
 =?us-ascii?Q?RF1Z3m9oPwuhhfIQ/zPpPw90uFgeGr5aU/7RftLGSrjtOr4qnfdHqDKCsrSS?=
 =?us-ascii?Q?Q8HpYl2nWt6cILPdDx2oG0ipi1GgYzxq/M3eUIB1DSQriK93NO+1ix2gAl3w?=
 =?us-ascii?Q?/Aod5PepV06P1Z8slmne/d1fSVzoRcUzBg5gOlIdSCqsbEpzVPqCNgnQAVPA?=
 =?us-ascii?Q?nRDjCQyirDEBAeuysKgdKu+AmT1lsOuIhQyriwfqGgu68YB675UoEjVS/ibm?=
 =?us-ascii?Q?UOMGQTsyfHycRlq14JJrq6cHipIFahIp8zLwQzscLqVTyDCFMKPfvtO774Km?=
 =?us-ascii?Q?Nwon4ydfC2yig/WU2Tgq+dThRjxwI2mMLIfysHgZtwiZq/FucW9Lk4GJYoFI?=
 =?us-ascii?Q?H/Z7eYRcVnVNlJ6+nhY2H/6AQ5kA2iI3w9ib7yq4JOCVYP/6Ux94Ge6RA0q5?=
 =?us-ascii?Q?ee9tmOo27pLi0OXzLhydjyi26d95Qel20OKohQrfGykK63fn9P2RMc/OJ9xv?=
 =?us-ascii?Q?jJyBzfLXqiq7/gobT8hGkrhb4wisrDALwTjQMcVe?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f78e02-9ae2-406e-c470-08db7a32bbf8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 12:57:32.7187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: As8w0J8ZrVGpgUP6W3wmIQjKERTBk7g+MOqcf8f/t/y5QKSP5A4Ge7rdLD+m4yhYRx6T7Ojv4IkiEZyBNxfpRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7553

This patch implements a new struct bpf_func_proto bpf_mptcpify_proto. And
define a new helper bpf_mptcpify() to mptcpify a TCP socket dynamically as
an MPTCP one.

In bpf_mptcpify(), if the protocol ID of sk is IPPROTO_TCP, set it to
IPPROTO_MPTCP.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  7 +++++++
 kernel/bpf/cgroup.c            |  2 ++
 net/core/filter.c              | 18 ++++++++++++++++++
 scripts/bpf_doc.py             |  1 +
 tools/include/uapi/linux/bpf.h |  7 +++++++
 6 files changed, 36 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f58895830ada..424056fd5335 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2883,6 +2883,7 @@ extern const struct bpf_func_proto bpf_skc_to_tcp_request_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_udp6_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_unix_sock_proto;
 extern const struct bpf_func_proto bpf_skc_to_mptcp_sock_proto;
+extern const struct bpf_func_proto bpf_mptcpify_proto;
 extern const struct bpf_func_proto bpf_copy_from_user_proto;
 extern const struct bpf_func_proto bpf_snprintf_btf_proto;
 extern const struct bpf_func_proto bpf_snprintf_proto;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 60a9d59beeab..fa8a80024b67 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5573,6 +5573,12 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * struct sock *bpf_mptcpify(void *sk)
+ *	Description
+ *		Dynamically mptcpify a TCP socket *sk* pointer as an MPTCP one.
+ *	Return
+ *		*sk* if it's valid, or **NULL** otherwise.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5787,6 +5793,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(mptcpify, 212, ##ctx)			\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 5b2741aa0d9b..6b56de24e1a2 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2542,6 +2542,8 @@ cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		default:
 			return &bpf_set_retval_proto;
 		}
+	case BPF_FUNC_mptcpify:
+		return &bpf_mptcpify_proto;
 	default:
 		return NULL;
 	}
diff --git a/net/core/filter.c b/net/core/filter.c
index 06ba0e56e369..e43b2c42c094 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11678,6 +11678,24 @@ const struct bpf_func_proto bpf_skc_to_mptcp_sock_proto = {
 	.ret_btf_id	= &btf_sock_ids[BTF_SOCK_TYPE_MPTCP],
 };
 
+BPF_CALL_1(bpf_mptcpify, struct sock *, sk)
+{
+	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP) {
+		sk->sk_protocol = IPPROTO_MPTCP;
+		return (unsigned long)sk;
+	}
+
+	return (unsigned long)NULL;
+}
+
+const struct bpf_func_proto bpf_mptcpify_proto = {
+	.func		= bpf_mptcpify,
+	.gpl_only	= false,
+	.ret_type	= RET_PTR_TO_BTF_ID_OR_NULL,
+	.ret_btf_id	= &btf_sock_ids[BTF_SOCK_TYPE_SOCK],
+	.arg1_type	= ARG_PTR_TO_CTX,
+};
+
 BPF_CALL_1(bpf_sock_from_file, struct file *, file)
 {
 	return (unsigned long)sock_from_file(file);
diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index eaae2ce78381..7a20ab9c6513 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -751,6 +751,7 @@ class PrinterHelpers(Printer):
             'struct file',
             'struct bpf_timer',
             'struct mptcp_sock',
+            'struct sock',
             'struct bpf_dynptr',
             'const struct bpf_dynptr',
             'struct iphdr',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 60a9d59beeab..fa8a80024b67 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5573,6 +5573,12 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * struct sock *bpf_mptcpify(void *sk)
+ *	Description
+ *		Dynamically mptcpify a TCP socket *sk* pointer as an MPTCP one.
+ *	Return
+ *		*sk* if it's valid, or **NULL** otherwise.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5787,6 +5793,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(mptcpify, 212, ##ctx)			\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
-- 
2.35.3

