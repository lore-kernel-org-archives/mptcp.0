Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D5B7C
	for <mptcp@lists.linux.dev>; Mon, 28 Feb 2022 14:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646058750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uefkMAHuAj+W2kwPOOTlayn6e7qD9XFVKeHFDJYySxc=;
	b=KUhpwNEcirTkJiJ7RPIpmgfNBMve6D2dSgpobACGDxxQi2mEHTpR5IjqRxykdHbkjp5aSQ
	K4zqUghzoF078GPltgXAJPVMpV7bjmcps0n2vyA5LlX3nYQjJsFEwRD4Fr09VOV3e2Zb+m
	EJFyXb8kdoJqSuCwSYo4qE2hC+CYt9M=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2059.outbound.protection.outlook.com [104.47.13.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-30-6c9z49kSP5ywB2pMDMgXxg-1; Mon, 28 Feb 2022 15:32:29 +0100
X-MC-Unique: 6c9z49kSP5ywB2pMDMgXxg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYtqm88QK5igFhsAR1RcasAAp/N7QqmbcRy4z1AVhh416ixNuoMrak7eZzTmNQdkgfdOwu1IkkYNU8SA5MRToVfZoOn0rAnR96tpUXRxA9FQ4SFJFaB54lST3lym/11oUzCvCiObhhR6zyBwK9eyBaqoJBp62DfZrt2nsXxl+sgHz+8xbKsa7p14UcOZuaQ2jaxVv5LW/qq9xp6/8iDrEMrvXtQ61XobElB6vpSlHOUe0l8CrNtaKm6+2pS932p92UkoL4dz4R9EmF888/o1Kq4fAKv4nzjmeJxBeRv2GsyxtmyZxjWUC1JNihQT/x1Q9fQx0mPY40Hkdu31GDOCqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jsfz6jOHQWnLQU4ZqYsCBfYueIj9dPAWYFwEDn3E9qk=;
 b=EWpafo6MGKwPOPxgvsCjrGMH9ZS+8lYJFmtbJtONkZ63CBJsOIetisRVo2mgnbMYJ4Cyw8CDJi9PPamrQxiz16JLVrnjM8e1CxRZYwESN7WzxQPudeSxbCtcLmgiCeDQ3jib6P1xePwtMEjDfVr/3c9Ly93SIlWNZ14WV2lPqLiuzVHtPwmkgE9uQQKqIIzo0kvk405OCNnSAcxjV4TrAVHIOQsOyfn6wYb0DdzSfPRXiDGv7bX/xEYjnWDtNipVnTI1lVh1vyHS9kPS93S9sBCFj1btRHIMNnHLKmQFOihrdCQG+at9X3r2m/P+/8xDNwhpZ/E13aNnrqdfSu1S/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0401MB2245.eurprd04.prod.outlook.com (2603:10a6:4:47::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 14:32:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%5]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 14:32:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 2/2] bpf: examples: fix libbpf 0.7 deprecated warnings
Date: Mon, 28 Feb 2022 22:32:48 +0800
Message-ID: <8aa977acd5b4022a72a621788ad9f158d95a36f7.1646058641.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646058641.git.geliang.tang@suse.com>
References: <cover.1646058641.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0014.apcprd03.prod.outlook.com
 (2603:1096:202::24) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 392a28cd-bc83-42fc-46b7-08d9fac72545
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2245:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0401MB22454C3C1605E2E6F9146C2AF8019@DB6PR0401MB2245.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pKBWf0/CAzHLUbDqM17JoTnf5fnnML6H3PHMM9lOfrGKrXFnC0VmZacRGlraaqlz2Ua5BSDlBrjAFyTPIb6Jh3fSpIZi0UGAyNHJsxwz0b1WMYgKOazLJ+4hXEt6uO3ICkCcFSKj5s55hb/f0lewbJR4VhopPSvDAGqOqPK3BYIr3VNbky0GRH/KAAYlHvB2FWsKuxNP2iz4zSn+BtWoG3a7xKMA+BJdpo+Us24WKALFPO0kDao2K5lTyQ3c/2N6jV+iTuZy5JO2LcgujL2faRog5gfTIpCqbuGzNHp7S4fCNGV195ff1IXAITQSCC9USyTi0uHKarNmvxE1Nl4u7kODVZYM1Fq2+/cieE1Vib9S6oR0MeWfL1diPhGlFIa16LAt8knHSUOEoOvE1lB9B022sROixocm7Mk1LQD4zKLezYg78mHcDqNL/epBgL7kEl/WuzyEhM/RwNZMS05b+mwJxRkNyb8p5Hx/Ia9brWfeDQLpBqLaoFOQ36iod5shsrNER8JEhvf3oV5yiccds8nzvtj4stwTdli9rkrAxKNSNiAY3NbTu1vt8UZPHp/z5baDYapLWurZkfE339Ib+MHHLcCug1B7Ju4g0nzsyh8mKCYxo7Gdzih+4TG5b32WvxN13kgbZE/LnZXIVabQ7g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(6486002)(86362001)(6666004)(6506007)(2616005)(508600001)(107886003)(186003)(83380400001)(6916009)(66556008)(66476007)(4326008)(8676002)(66946007)(38100700002)(5660300002)(6512007)(44832011)(8936002)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BOySOsYMKJpteducNqNToo8nQLF9/UP5Tq2nhZZE6OYVZoA5e42KV/BAFKBC?=
 =?us-ascii?Q?MpLKvpx+iTafOPcmeb1G4syyRHUxn9trp/nR6ZskaKM1DpzGFjCMRp5cVwCg?=
 =?us-ascii?Q?AwZm+aWJx4vY42wor3kwWZe28xouqk0Ia1/heviP+aNYjD0YqzYe0ccxMUS0?=
 =?us-ascii?Q?l+tJWSaMLKiu39DDDjoyOOedAp+Sq9Q2j6LKm6fDCN88a8xAPgBJ2vv+27tP?=
 =?us-ascii?Q?8zpAMlKZSkWUIy/N3SKytLJ8GTDklwzMlKVHQ1o2kwKM+ercsUIOq/O60Hn5?=
 =?us-ascii?Q?gU1ZNMVCaJDvFIES3szf3R9GlmwJxt+0fSDhDuB/9R9VurXxbE+emVzLD5c6?=
 =?us-ascii?Q?NWMcYXh7H+614/aoQ/h3zPkg0Gq6jxbswg99ZUI5W3CDpCB9GfJvUL7u7jSm?=
 =?us-ascii?Q?8ByfT2kyX21RMPjLCWzOGaRhcfKwyBhL87htTtggBi9axpBfANAsNKlzxQmA?=
 =?us-ascii?Q?ymYaFC1uWDcfDmBmU155A4k1m9yoo/YsZ3fjr7ucCPoVA/nNK6wwCNSemcBR?=
 =?us-ascii?Q?FqOZZ/A+eTIN2KxQxwwjzR1MSl3yYl7iW2m2+bEDp3sTKF3l+z15nN+a6Ogf?=
 =?us-ascii?Q?wUekCj+dvVXqCOTa/xxIe9hQ2WV0OhQdTVlm7OQbBRTsmUYa6Pr4slkXA2Xb?=
 =?us-ascii?Q?7qfdbvMA9RZaQIlwnQaC+mC3GDbCikAXl394eTtH6pXh84Eh2m+u2qja297p?=
 =?us-ascii?Q?HGO4jv0KDkhj1fgfDyzHYZP5whwDMoVFhFYIe1c/N4Lfnf6K+YGNYrB/6bV3?=
 =?us-ascii?Q?QSRjC1thkxUOaAZRYQD3jmDJciI7UGp1FMwv08RyY5KmwiWDC/AvCbNwMb3D?=
 =?us-ascii?Q?uztGWtgg/qH4IO7bBenkeULOTW0ix/dpgNqK9UmEzYjEID20Go8t+WaCv25X?=
 =?us-ascii?Q?A4GH3iAosU5Wt5rqZa//gd2vkAeMTVoXxRW1suAx/DKWiXH6K15PDFZEiIfM?=
 =?us-ascii?Q?o680qgxMJf4mJ2osPqX4/XCMg0DxSJZSxeUI7SVlanl8ZjnU8lAaaUu2QklH?=
 =?us-ascii?Q?WEe61Q3Pjk1+JamI848jbzRq3Mjtdea/BDViafJMT5tyzCFNEr672duGnriS?=
 =?us-ascii?Q?cLTUoGhHNiFheQ0kqM0XTMVpB/Zf68woocCimuRWYOjq//j+CNJwVH7P+lqV?=
 =?us-ascii?Q?VzHEcYzNK2p8oQv6VysQS7rfwln1GJ3QjXJjLIx8HLyVfNxO+I0kgC+Y1txD?=
 =?us-ascii?Q?xcRWqeukoOV2H8G3i108ZSzFnUEuIRR+rsASGZAVDpIaY+QtYcmoKAE762z0?=
 =?us-ascii?Q?uNSHtqDn7uwM/KNbbUO9LYF4iVTecR3SgH6UNS69TdbTt721Z9zb7UkZ8aB6?=
 =?us-ascii?Q?hWKmmAbitag20Fzd1tMRmZD+l0L0RnzukR1CBFk3D7oRDkoULErwNQ4q1SID?=
 =?us-ascii?Q?GC04eqPt1NN/OIwa5qFpCqdSIkxs61hMHHKrX7YvoQnCBqjawXCXgxD239AK?=
 =?us-ascii?Q?+dkJiomQtDsc/EF75cnPfEnt0knrR7WB1wpyiHwd4OHMlwRrX497j4yOVwy/?=
 =?us-ascii?Q?0csIEYchbOpY9a2C833pRLI0jiJCzm+7l3685HVyzfCn8rNhku+ihuZpifov?=
 =?us-ascii?Q?rCQWmo7y81G+/nGJa1cuKmHGcY994brozZ+YQ6L/IsycJwtgTyzDwCn26zsq?=
 =?us-ascii?Q?oNDnu7jsz97Qfoh6cJq2ij5+jSiyyDHFQfpw9+GOV9nNpofdPJjUYtUukrt0?=
 =?us-ascii?Q?iMW11b4uVkglMTD5DEvBzz4QjHY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 392a28cd-bc83-42fc-46b7-08d9fac72545
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 14:32:28.1306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2090/GpLnwInc4l0ykxfTaaurRNojJR+jQMnXDgEQkMH0K2n58T94Bzl/BeJSfvWzLO/HBAhcing59pwOBblUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2245

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

