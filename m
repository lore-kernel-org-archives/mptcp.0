Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CD7625
	for <mptcp@lists.linux.dev>; Tue, 22 Feb 2022 06:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645510838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4a7PEGijpEKRKEZCjXWVCJsIpM97ACLX7CYkcSs/y/w=;
	b=QeExPWRn8KrYlnggzoa/1hGKdqbJECJbQEZfkyHeSN8bjwoSWXSxyv+6FJBQSMbMVhurCy
	23bh8+PKiaJSpVLOJsX55YbJkKCtQL8a2jE82fpSQ1vCQtlXxoO/cYOdugsjJt2KpPgLjl
	sYBfbzl+ohpDrUe71by0VnvsO1+0SLI=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2050.outbound.protection.outlook.com [104.47.13.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-32-a8yUhD-2PXqFrKfCvTCtww-1; Tue, 22 Feb 2022 07:20:37 +0100
X-MC-Unique: a8yUhD-2PXqFrKfCvTCtww-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ii03iWkOd1/SIEGlPHmSkAShS5D30HVvT8PdGt4F7weaoDaXlWfYVa9MhfqOOvue/CZocQgbIQJW/OX1IucGe3WHAIB0Ukt1S6gtcV5kD12hpADVakzqBFe7KNx9Ko7BTPML6s07jeC7gmxBN+Nb7SNifuJIDCuq2Wgw0wFUwdiCzHf6WsNJhFBx0ZIx22iEGNBI5cV4v9H2dgoZAyJpCB/O44lntDMFEdP6FdgJHDD5A8QYsWz7m8JX27efXCN61nN3d5YfD5aAzbrRcTME118n5mB1ERDi429YVr3jqaZ4kT275UNAkEx9OMLTeu4K2gk4l9FyDdnvu80tu8S1DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDQ6VJzh/DvtToR2B9vXTfSUh5Xmu5grO82/ec+7Z8k=;
 b=g4zELgjGftMG+yZtubxM2uFAMDP4mdnwn9WvxsiJPRkbu4MaW5Y/xiSRBxKO5UOyv0YKAqTIJWioXoHiHrgb7BK/im58T3nNYipmmMuqMxbRsBKxUh9ajIsAtIILtCBA+p0ZIsue3gHDBFoGfcL/jBP5zC0BNCpS04lWFGpK/Gmm0J5xfY6VJ8edl6O2hCzXUztK7mvRapEQtofDVj5lIJOZCkwVKqcnKWo5GJVy7KhhLn/njsYHrghpGDzeR/UjOohsfZMe6/0JxP0ikbsBVQk4ukV+KMFH57N2q5Y0BpbAjVmeMYA3ALHCRpTsWwVivCSs+fQu22/RotVPKqGndQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5553.eurprd04.prod.outlook.com (2603:10a6:208:119::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Tue, 22 Feb
 2022 06:20:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 22 Feb 2022
 06:20:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next] bpf: examples: fix libbpf 0.7 deprecated warnings
Date: Tue, 22 Feb 2022 14:21:11 +0800
Message-ID: <807598d13bce34bb92b2078bbef0aa30007aac2c.1645510773.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0044.apcprd03.prod.outlook.com
 (2603:1096:202:17::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66a94925-ae9a-42bb-164d-08d9f5cb6f68
X-MS-TrafficTypeDiagnostic: AM0PR04MB5553:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB555327678DBCBBA10C67F412F83B9@AM0PR04MB5553.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w2l180JJbinYuQ3fb8BLvWZ1g+++Jh6kzjC8AZFj/0S4dXt/xWjTYF/Egpmaxsuf/UzL/9CLZhX8yelVKhigKea7anY6C9FEGuWUr5xzh6ybA1oyrt1jzn8mPpZYT8odkm41IJSKaCNkybw/IEXgs53FwOclINddtBYMQMTDm6XzHm4+MbDxIBQfTOxbuheSjA+BH+ZFh02Cjo5eeFWyfWjRJC+LUafgflWT7EBp9l6ywe/u4OAkrJhQ5LH08tLgOmQQlo9ZDrnPmXzfW1oHE5HDtzCveI6GcqZrXFYOkVaLcOU/OEDVskfUlfxavxFwO8n2ziEcj5mY/VVUkBfJLJQBwXxBrUU284N07/mnHNBUjgxKXBSw/uFr2VHUrfvh6p/1hzUc7odC5d3oAOzOv0SWHhPATcsRzaSje6g9ockNkMIj1mNbd/wAahu9Y1BZQ7puojLdOlxBCL5wEZ+zadFHHzgMsz0B3GzR29vYdZWH1+7/1i7ez5Z7RKVGXsGoy7hC5h7X7R8RVW05cPwqEdGXm9ID6x19cV9qMSHSBDrfw6K8xJtBu+mIxWWpMQw0kmfxgLfXO2UT0gj8qHg8dL1ZwX88p2sO0sM06ecYebvb7EdwZvESCtNYBQNGW1if+/XUP9q4KMo8/98K0cB/zg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(26005)(186003)(2906002)(6916009)(8936002)(107886003)(86362001)(6666004)(36756003)(83380400001)(316002)(6512007)(2616005)(5660300002)(44832011)(55236004)(6506007)(8676002)(66476007)(66556008)(66946007)(4326008)(508600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?me9dc1S+kYN9RdfH+JhhtppCJOnDHrB4LVj7+B3ReGlm9eSEfjNxEA1XPMVW?=
 =?us-ascii?Q?E535MLZCxGrUO0grhqCI7tmT5uwjq88oicTuQFLGeq3nZPO3zvW462btpFC2?=
 =?us-ascii?Q?SFQ3ojdAZhek+Xuvdj3GZ+55GfUngKOTO6Yd5JYdi/71vFKnk4fuvCYh4S0i?=
 =?us-ascii?Q?kHyTu35eVFOPZezxqzN/q4UM3+wgsxuyABqZ76B8fjIsNM+jb+3qxyZOzWq4?=
 =?us-ascii?Q?Os/0VQgVsTzssM0znISSpT2d0Epm8oCTFhOL0KID0YflG8EY0yYIEeN6Pthf?=
 =?us-ascii?Q?FCOSc8oORlAhhqtQWYu6XwD7ZkCc1pg+Lzjk68v6xHBIVaTq6T8uIE7378nR?=
 =?us-ascii?Q?r7FlUhANc4TOL+x8twkPMeh6126qvZQ9Lmicho97BRm3Yb6dDRfLoBQ34fNd?=
 =?us-ascii?Q?PmEDJL/4Tmj4FSWdikkS8DMaBJW0OMysy9MoI+nzYKJ/+/arrdBDJhyy4l2k?=
 =?us-ascii?Q?po1M4oEpMC11TUmuB+Yd1xLYynF+KVZ9+8R6HGxZdJUBbKw4LkWNXQO/emhm?=
 =?us-ascii?Q?gD+p0zsd0YjsMFp034PjglJkRmqcjP0TF45r5Fhdlnn40CYf/1pWWlosPGtU?=
 =?us-ascii?Q?1R2UDvo+2k7cevplHS/8rG+hztax+CUS4uLXG9XZr54ZUKnVxHHtXXQ1lu0A?=
 =?us-ascii?Q?4fUQXwy+KIpBhWWzq+tkG4FQvGTCa/PGtx+oaEtb82J+Ukk/WPdpvO+iimwf?=
 =?us-ascii?Q?rjj+HJGCbLRb5V+xRNpNGCt7nZn7o02/ewuRl1vIvYXZXHVQfp63/YGwN6vk?=
 =?us-ascii?Q?hrsm4L6OqSu/0Hh0Gnd/e/rVctRr9TkFnDAzytX9Qv6AxnQX1o+FZW6/UaF7?=
 =?us-ascii?Q?BvN27CwLDN1UHv98zIc2iNNwGywD4T4JMsI3sNK6dQWfMSmhbAhyNK5I/rfK?=
 =?us-ascii?Q?mZ5FZ7wUBJkpmEIZl9oMjxsv/VR9Gt134vh/Rmcw/z0JH5XY6FxuZZumS6ci?=
 =?us-ascii?Q?tz+iRQ14nCrtCaOSi15MN/i7fRQeWCmWwWbDHgsyhBpOd91spD37oiWgZFVy?=
 =?us-ascii?Q?3UjS2z+rVZwouhmRs73H3rFJLIRckF48jvFoYlfVvgGCujX2QXC6rj4x9ZDs?=
 =?us-ascii?Q?Z3Y2UzPYlBEytzIEQQvEjRQP/UAvUHLLxKFg0UE63reNsrSIp3en7hHBeo7s?=
 =?us-ascii?Q?pzMs9vqhE/Rkt74EZxPD4UF55LnG6qvleWazGJ9KdUs+vwhYAhz85sPEdjJC?=
 =?us-ascii?Q?Bj1YTHT6gMr+PLHQ8nYA0ORk6VdTFcGYXbHildw/0+PB531XFTSnosyJSu/4?=
 =?us-ascii?Q?V0wiqPGVCNXBle64AhZ7jXebALWY1jOpXyknKmcrs3zbehfnWemzyvjtcnys?=
 =?us-ascii?Q?X+mw4CR33+q0zeCOlygQCKmfzpB3sCU+Um/GeXYNP5f45/5soBzVRe7vpfG3?=
 =?us-ascii?Q?B0TEoLGaDxFeciCipptiZtyndGG7qfsGt3x82KfYfOHIzLxIMQ13C/EsBb2h?=
 =?us-ascii?Q?l/8qpeu1yhnckkkAcHC7yGQowu4xJO5Ek0bo1dW0pkZeEfGCeZRTQBKLZiH2?=
 =?us-ascii?Q?GrABgNMXxFCBaPkADavvI3XVAUbiXZlLizZqAnRNP+qxIoK1uwwAYbtYpcoC?=
 =?us-ascii?Q?Pr5wUJPplr2YYfjoOMDiKWgw/9uTmRmy7kHcK8azoZsMPVhnRF3fUiRw321F?=
 =?us-ascii?Q?0kM2zgu4ALzvy686jqIG3JI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a94925-ae9a-42bb-164d-08d9f5cb6f68
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 06:20:34.6831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gpvfsTuitWk96+tP4QnGLiLdNn12lKOyiaIy9PDTwpUpnG0DzUV/7Lm992sIWqx0/dPiL6Uc0OwVNVTZkCrXvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5553

This patch fixed the following deprecated warnings:

loader.c:136:10: warning: 'bpf_program__next' is deprecated: libbpf v0.7+: =
use bpf_object__next_program() instead [-Wdeprecated-declarations]
                prog =3D bpf_program__next(prog, object_file);
                       ^
tools/lib/bpf/libbpf.h:265:12: note: 'bpf_program__next' has been explicitl=
y marked deprecated here
LIBBPF_API LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_object__next_program() in=
stead")
           ^
tools/lib/bpf/libbpf_common.h:24:4: note: expanded from macro 'LIBBPF_DEPRE=
CATED_SINCE'
                (LIBBPF_DEPRECATED("libbpf v" # major "." # minor "+: " msg=
))
                 ^
tools/lib/bpf/libbpf_common.h:19:47: note: expanded from macro 'LIBBPF_DEPR=
ECATED'
                                              ^
loader.c:139:18: warning: 'bpf_program__title' is deprecated: BPF program t=
itle is confusing term; please use bpf_program__section_name() instead [-Wd=
eprecated-declarations]
                name =3D (char*) bpf_program__title(prog, false);
                               ^
tools/lib/bpf/libbpf.h:294:12: note: 'bpf_program__title' has been explicit=
ly marked deprecated here
LIBBPF_API LIBBPF_DEPRECATED("BPF program title is confusing term; please u=
se bpf_program__section_name() instead")
           ^
tools/lib/bpf/libbpf_common.h:19:47: note: expanded from macro 'LIBBPF_DEPR=
ECATED'
                                              ^
2 warnings generated.
mptcp_set_sf_sockopt_kern.c:19:8: warning: 'bpf_map_def' is deprecated: use=
 BTF-defined maps in .maps section [-Wdeprecated-declarations]
struct bpf_map_def SEC("maps") mptcp_sf =3D {
       ^
tools/lib/bpf/bpf_helpers.h:136:18: note: 'bpf_map_def' has been explicitly=
 marked deprecated here
} __attribute__((deprecated("use BTF-defined maps in .maps section")));
                 ^
1 warning generated.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
RESEND:
 - update the subject prefix from "bpf: example:" to "bpf: examples:"
---
 bpf/examples/loader.c                    |  4 ++--
 bpf/examples/mptcp_set_sf_sockopt_kern.c | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/bpf/examples/loader.c b/bpf/examples/loader.c
index 6a87aa9555c8..c4f8e85585b5 100644
--- a/bpf/examples/loader.c
+++ b/bpf/examples/loader.c
@@ -133,10 +133,10 @@ int main(int argc, const char **argv)
 	LIBBPF_ERROR_WRAPPER(ret, "failed to load programs from object file");
=20
 	do {
-		prog =3D bpf_program__next(prog, object_file);
+		prog =3D bpf_object__next_program(object_file, prog);
 		if (!prog) break;
=20
-		name =3D (char*) bpf_program__title(prog, false);
+		name =3D (char *)bpf_program__section_name(prog);
=20
 		switch(bpf_program__get_expected_attach_type(prog)) {
 		case BPF_CGROUP_SOCK_OPS:
diff --git a/bpf/examples/mptcp_set_sf_sockopt_kern.c b/bpf/examples/mptcp_=
set_sf_sockopt_kern.c
index 4079ce197e83..6c8231d21ad8 100644
--- a/bpf/examples/mptcp_set_sf_sockopt_kern.c
+++ b/bpf/examples/mptcp_set_sf_sockopt_kern.c
@@ -16,12 +16,12 @@ char _license[] SEC("license") =3D "GPL";
 char cc [TCP_CA_NAME_MAX] =3D "vegas";
=20
 /* Associate a subflow counter to each token */
-struct bpf_map_def SEC("maps") mptcp_sf =3D {
-	.type =3D BPF_MAP_TYPE_HASH,
-	.key_size =3D sizeof(__u32),
-	.value_size =3D sizeof(__u32),
-	.max_entries =3D 100
-};
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u32));
+	__uint(max_entries, 100);
+} mptcp_sf SEC(".maps");
=20
 #define DEBUG 1
=20
--=20
2.34.1

