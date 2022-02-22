Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22D9366
	for <mptcp@lists.linux.dev>; Tue, 22 Feb 2022 03:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645499197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uefkMAHuAj+W2kwPOOTlayn6e7qD9XFVKeHFDJYySxc=;
	b=gnWWme0Arpjtlpkdhid7tP2l2cXeQrDPyFHcWQaSge3trmEdKV4O3KEOLmlAlfEyZvjKq0
	iQUDWit1BABJ6vCxfH/ObzUSDdyyD1cbDXkvKBL6mjOgkb9478k70pvMpPFZp9LNX9UNKB
	6hS3MT41yAWRj1l5EIoafUoLHqzEGAg=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2058.outbound.protection.outlook.com [104.47.4.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-3eEthmhxOoiG3jlMlmYMiw-2; Tue, 22 Feb 2022 04:06:36 +0100
X-MC-Unique: 3eEthmhxOoiG3jlMlmYMiw-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPBWfAr2xHORqiqfeRSy11o+rEQabxRIe5UR6QthOaby2OaWaSRpqQo0iIutX2LHKNpiUxT+kCm7K9nBBIgzCOswMXRV2oxXk/sn6hfGcZSJ8oov03tbvHtoNz+/3jEFFOFABdR6eTDJQNZ4KiRUMO9ALqSp67YHYW4r23/nvoMPK2X2Lvc8fwnSti3i2+NLTOG9ljYF+N/fRMTPMSENHUMR+RouDvrBZ9fdO3UpccFLanyN2jZaK1iGXycv0NPokI9rXPvKI1WFghUyIGvk82HdN6V3nPQA5fk/nynyLKtFCPFT9sQZZER2WwFb1oUPKQon0QyO36Qv9yS4KgW4Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jsfz6jOHQWnLQU4ZqYsCBfYueIj9dPAWYFwEDn3E9qk=;
 b=SVAA/JXyDLbGB+QlegYzQMY4R2DI8Siz/+nnXlgUFLfeo2xS6/Dt9/VJBPaif4W4Gu/rxNPgX+z8VVXbwJfDiWSolj7/G+pz5QJ07v+lL4/49pXTwlePONUEQPm56VmOwcX5ibbSo8S9sjvUNAfW0Tsb7J7HUPGv3Kylq7lVAulJ5uN17VvB3q3tuVbfIw6btbBgfzZCBldz0BmVA1ehqoQfZdxNAMz3XuW7Iu8nQdKCKer5hq7u+u0wb+LZnJVCe8M/9n4SPw0KY9WFHxuQky9AaLO6y4HKXeD8WWDmbt1SukfoiSJUd0OFIOMg4z6+/AqYE9tlAi7Gjr75L5y/uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR04MB3267.eurprd04.prod.outlook.com (2603:10a6:206:d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Tue, 22 Feb
 2022 03:06:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 22 Feb 2022
 03:06:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] bpf: example: fix libbpf 0.7 deprecated warnings
Date: Tue, 22 Feb 2022 11:06:56 +0800
Message-ID: <e3e578af284227cf9aa552f5bca791fc51674b04.1645499143.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0187.apcprd04.prod.outlook.com
 (2603:1096:4:14::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62ee5a26-6a68-45c8-7a84-08d9f5b05508
X-MS-TrafficTypeDiagnostic: AM5PR04MB3267:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR04MB3267118A880AA274A23175A0F83B9@AM5PR04MB3267.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	auwwOJpDj4b1fesBOjj3YB1WltkRlShts1Glem6XycauEyp6Y/9rUimUYtxE+a2KeurQ7DukUmEGrtMk2dB0CamA7i5WucOL4/nTggCv+sYzlwsVOJ/6Qndi+uuTTS2yavG9lk1KwvLcZkJVYzjm9wagT9xmQQri+ehVQtH7zY5/kPZrQc9JFla9J9DY+4wBAs+jy6grJhLMPmNRYEXCNxUJMJZMny0mbCOFUAaikfgM3ro9PzkwbVoOvZQwF/pavh9ENFqzHzjSMEy4flfM2DxbtAd+eOCjOTpfos3zs4+MiFy9jS4rgAJDpnkrga3b/nXZ/v/K1N+xIMCrKjFgWzkqn5s9xJrayJi8E5MZG+D8pZcEL2u0oZbafpoEBsHkMkyvR/NfeDrHRwzh/3PENGcP3C5Gh5dC6mwZ5d893WuALrC0O2vjftSmT8Zj0Y41YP/LxsxyJCMmuJ9b4rO+JoAp1NXoC0U2Vo+wVKk38um0bQP116hLa+LzgzTvASULD+/ZtMdtxP6nfYV14H317X5uPDvu7EbAZOYe4bP0q8tdLhzjdNRO+xDzVYqOrhnOYglQvmQyq99URkCSSccdfxvNhbd4xl/HJV0mSgjqm+PoNAYe1xgUz93WYdESqNzbAuKAuMHVj3pHsZKol6R/gg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(8936002)(6512007)(86362001)(6486002)(83380400001)(6916009)(2906002)(316002)(5660300002)(2616005)(107886003)(44832011)(8676002)(186003)(38100700002)(6506007)(4326008)(66946007)(26005)(6666004)(36756003)(66556008)(66476007)(55236004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?03HJuuAWBGKWOIHaM1BQqKgAQEC0v6nuCPfN9DaaClZWAPbTOhNpJAJ+mT2W?=
 =?us-ascii?Q?zJJDD/kM/v0MtkcS63oEJwqq/K5vHKVXVZ8alif30J42WPUSPCaCdbXQ4iOv?=
 =?us-ascii?Q?gFuWr+BlGRvS+dcCb3roe8qvv1+atUnzDNH+nZjJEpFcbpK4f60srxIty855?=
 =?us-ascii?Q?Xuz7QKPZvVJHsRtL/EW9Y4Ks8QvZhWoc7D15nns8IB2g9oSYGoeqsNNlPQQ5?=
 =?us-ascii?Q?DxNGsIO/z3sN3doRBf5uDpOu6u5n8GpKeTtWjLyXGrWLT+yTXoee53/XsN5Z?=
 =?us-ascii?Q?jAbUmq9SkDjR7YnX8i30GEl4PZ2lME4o6rbyA6CEKwiDzkEjS4BaRl68KIAv?=
 =?us-ascii?Q?Th0HVhjUXOCWNM2ny6n0CeALzyAOvBnD0uo2KozvrafjMUco59Q7c5Jzw+/C?=
 =?us-ascii?Q?FYLyE08TyWMRJO6UT8Jd3UXaeLOiJ8h9QGvaOrwa1Dl3sHvVjghIV7bmnIqa?=
 =?us-ascii?Q?+e+Mr9v2xG3ddnSVkbRska2zVNQjglDcx1WZ+6TDshR/6w+jgOPEtmcQovWh?=
 =?us-ascii?Q?Ut5b7rSpQaNZLJm+jWNv0/+LDD6GPTyrZn0bFtB/6xc7ozmm7eQmpLqCWrdi?=
 =?us-ascii?Q?J1QhlSPLsRefSHp3z5JgJ6+rHUX1+0LO+k0AY7Z0y0IViJUbCeOzlwl9KFuq?=
 =?us-ascii?Q?rzlSHFn4zpX+zyfyMB0BInTAJsU+Tz2hAXMxJnkV7yLRxvRC2prhxdegZVdU?=
 =?us-ascii?Q?zt99jfCWg69ONJyiBIdWDT7CS7uIM7SrUGjqyifEqqvvbAnDLYrsOZELmg5K?=
 =?us-ascii?Q?RShqXZTHsGqGOGfloXR1NS01vafFf3vxJpMvNWtMo7FktaaeD0u0Hhi9R1c2?=
 =?us-ascii?Q?qTLX+GuIBYPFMs031TydFnXtNujPmfqRQK6/9SHXtA3byJO40PnSHDJhYdh5?=
 =?us-ascii?Q?IeltnlXe43NVmoGiqs583WpQyKkBLSs2wNDOQ9cxN37l5OYZJYSedCG9asQa?=
 =?us-ascii?Q?sHBtITIXaHCkOazBOOXFBEAWjEYYf7lFc+10uVkK9kdAKhmPzV2LQqx5g8BX?=
 =?us-ascii?Q?iQTs7jMTWVkOLVOlBNcWD3eUk3ddPL0oxXTSyw77U3+jki+hMk/E6DOZlKt6?=
 =?us-ascii?Q?pquWKDZIlpaIHao4mnH91D0gabAwHjRRn+kjC7ntJkFyaHNxtA3bRKA8g2a0?=
 =?us-ascii?Q?O+6Y3244RLddXr8zLfwEDIJA9LPnw9s4vhSEUqOGv27GR0YUOCNrJC85g9rI?=
 =?us-ascii?Q?+6uQZrhwuszL7ZclqxpFg0DNGDj7f6C+WrVeUAoffTFhWJ33f/6os8ek4EI3?=
 =?us-ascii?Q?B9oar2WHihY5QdqaUPl6m84USjxHPkSF8nHFzRoOpsPVK1DbDSSWYkpdSnIY?=
 =?us-ascii?Q?CghfdG5VMlsoHVC/B+Ud5Zz7RfL4QtGTEN9u3X2WsyJVzfBXKr/h+vOyZqHu?=
 =?us-ascii?Q?zVcX3RtmSGz96ugkIKfVPkiestayFnQ8HGOSi1xOKf1GQGWuEtlSMs3TMcg0?=
 =?us-ascii?Q?MvQBDXB/ukqPlozHy2VwHr2Kyl7SoJMdU/t1fsTyLY57bEgSCY1V2HjUozKM?=
 =?us-ascii?Q?7z/ZhB+3gGhSz2WZBEe51h15XhZkHQUuEf9VJPJaed+QaXvaYPGlUTv5kfDt?=
 =?us-ascii?Q?RJmn5s9+qe5J7dCWwMaoCU68/MzrgsCWFkwDxiivjmgRytVz8DTysikuo1X4?=
 =?us-ascii?Q?1Hx8bDv9ZTtf2Y5zttY/Cm4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ee5a26-6a68-45c8-7a84-08d9f5b05508
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 03:06:34.1647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJJUWibd0ZNkHsNCyKycjv0dp+COwQZORn58/7htjIIxRogLZL7Z8LhRQUvDD7dA9zvmU8E8sBLVup3dXY5e3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3267

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

