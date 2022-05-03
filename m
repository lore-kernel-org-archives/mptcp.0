Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A487F
	for <mptcp@lists.linux.dev>; Tue,  3 May 2022 02:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651543686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QP/HhjyqP5e+YvH8PJ+d5E86H72GakFzEBOOq5Hu6Yg=;
	b=OjfOdj8oV64+SnRSVQ11qlpexRHa+hIidVLYs2+0s3KZEaqfByhpFJ6xhz/YkEIveUSP4E
	nylPJNArtpTFnrq/imM2oVhIN3/hSHQSS/R3B3QslutVfX6r4EA5LSou8P3ZO1oQpkkI4T
	iIFJ18r4h9es5nzLoSrV4ZQ5PfkyRi4=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2058.outbound.protection.outlook.com [104.47.12.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-4-aLEDbq-INjqkaSPBkzyUxQ-2; Tue, 03 May 2022 04:08:05 +0200
X-MC-Unique: aLEDbq-INjqkaSPBkzyUxQ-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNPzkUdcy1G84B4DTPMMJ8n1dpM+IOuf1EF1DPBxLmsDGH025vx+ej6hC7qwOas5RyfV9zTx8XvQksKMqFxydTgecH6ZYKj/xwNn82PosTBbp1lnKLkAOEqobBImk61hIirl5yCuL1x1h04+ZIkawE+Lg2jCIaplbAuCEeA/mCimzSVf4wwse6Zc4cVBrmqHcJlphnQKH9gH2GxKwX7xLBc33DYyMKc1/M15FlJftwmetbo9zl3BhRlghLDQqpkBm0/0aqZzrzLVnBSUXKBjCM8RetY1ZYOUwtqAkpiQa4MVp6c6dNCsEaM5bf9ljbqW5Z22+XquOk3q9liWt3Abxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioI8YHiHz+f7fGNENfwLQdD9qu5mu22h56pvCDu9Sqg=;
 b=hovB0AW3c7IjBjtUewoPZjEoiwsmbGrSYmLReqTnHXTFleejjQ8XnulJnjwmR5NRlvuWlgtIXMWemAxb7Nh+3m8FPX+x968R39Grp1/NegY7uMBnVZFGr+F0u+kDasHk3Lsa+OkYfUk/0qmC5/x434rU9zqmDfeCWtQEvU9Aqp0NpvMO1JTVkq2KGKD44Xt7tPwfBbqpDrDLAd55bCSLqtItJ3ZtnqpRPFiDqXKYejEHtalepUR94COs6FNbFZvypTv8yw3cXwReASalM+1UlnhukQyP4XphoqTZK8AymWlzrikgLtughSHRxsh7sABVcSbHuyyUkfx0NTv3KJV7og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB6364.eurprd04.prod.outlook.com (2603:10a6:10:10c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 02:08:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 02:08:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 3/3] selftests: bpf: add bpf_rr test
Date: Tue,  3 May 2022 10:07:27 +0800
Message-ID: <349a28151d13448d44fa062f57ce2f6f24cfe9bb.1651543362.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651543362.git.geliang.tang@suse.com>
References: <cover.1651543362.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:d0::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 904c6689-7250-4403-9384-08da2ca9c19b
X-MS-TrafficTypeDiagnostic: DB8PR04MB6364:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB636470F34FB5673CD643F20AF8C09@DB8PR04MB6364.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Jr1/rLYwh+xfnp+Q3IUhl8L1BxTo4ESSvZqQXbLj3cCa2bEp6a8RNxxFeDX9l0KCJixHvnFOqF2YKt4pcWKzC+pVnKqI/qPqa6AOUhud8Epg+095eACSpEyQkHHaLMe1KNqVgHzauMP8/JAYYeJRrl9dQdk/WAZ/vhiL4AQ8aUglFlKqbcVO89NCARYXTK7k3leOA019yXS4VqNuvGZuSxaWR5/rsrxCZo3eJEfujCuc98fRNmPunKMXrMBeAvkyQyhrIR3GON4pvNUwmP5hYOizHrDnNDG2Sg9F9DL/ZdWJC0RnjNIeu3I5O58HwB3BRCTFfNlrpMuE0NHv31zeDu+9GRLs/l3/wpdB4UlCqI2Gg+BHGWjYsXoUuJG6NZ3PCqBeCYwliJHT6VnSbMNI1goHIHtBRJ2NEXQbJXplOcz4NRHATN4GRE5e95D4VKVC0cRe3Z8UU5IbSG1S6ZH2adQVIYjziokSWj1KakXCRvEKyMbMVsskCiXRp5wFDUZ30wJ0vuHH4odkYu/kmc7MeB12EmJWlllEIIcNK//wy6OtcftjDfwEjXtpLhutAte/rf5zuk+LjlwUlyBtorAYfbUVMNCzt1zfHU9OCK7EtqJ97Suv8tCq/bApcjsusnYROTPhgv1SxHu+fE53Np/LxXqplasj3qXvrhZyJvLWoDNUn6eZPTEJZuCnr4K27dAD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(508600001)(86362001)(2906002)(6486002)(38100700002)(66476007)(8676002)(4326008)(66556008)(66946007)(44832011)(6916009)(5660300002)(8936002)(186003)(107886003)(6666004)(36756003)(2616005)(6512007)(26005)(6506007)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6m99AgvBsOt4F492ihSrT6g/mtXn4f0vu44zsojJGWZPvbuWZxO1Vq+yQfT/?=
 =?us-ascii?Q?GvpdRiCnd8WcVgeBXUP0CgKsN75/cYK6AOuXx347I3fIx2hpEGJtk97R8gCb?=
 =?us-ascii?Q?DO0va/8ska9D3BUr5p44/GE4naclaGKZlHJ1PqCyH6WkX8UbYKF57DNrqcTW?=
 =?us-ascii?Q?nV4ClzETEqwDdxCPVdMV1Cvznb9xecA/Hf0hK4LRLVWj72hyPk/6kovvoVtS?=
 =?us-ascii?Q?lR7yEoZe+goQ5+B22CX5qk3P8Jf9vwuxmq3EYjmNSc6Yzfpg62PamlEgz0xq?=
 =?us-ascii?Q?1pxyFsvT92mZfWooFZ5K9zqR97LqMs0UgzQ8U+ZaznxyI+Wwxl07kOegBsUQ?=
 =?us-ascii?Q?s2kGgZTjHslU6nHWZIMy9U2RD+Z2FYlL53ir9kglr1FED8Cy5ikKyGQTOE42?=
 =?us-ascii?Q?QX5OfAXkzvNamDhrsHAbs9V3bYsHEbC0kdQSRwbxQErA3moo6f9cwDRTe1uQ?=
 =?us-ascii?Q?k7G6Ziv6BunBNrYVrptHsAsNRh+SNbie+lBvH+3k1aDdi4LNNHxrwusVToOM?=
 =?us-ascii?Q?7wDmQyfLMoNx+GsREjC3OzMZ6pAzGCcg5A9hr73ao4r92jo0SbPlreDMp/2U?=
 =?us-ascii?Q?Ioogr0VEqEtOX9szzWuRGeWdknlyOYzZ9ofEklvK70t/Br0bfVrUA3OCYNn8?=
 =?us-ascii?Q?7ciMVskdsLwdhgZbONaklbkWIi96wYOYJnIV4bI49+YqxP2pG+nuldsmho+8?=
 =?us-ascii?Q?nQ+7V2/0wJhCFgdgyktSVYi0yC8NdIialhfucDoWU61awk7wuEvN8rULiSfE?=
 =?us-ascii?Q?+Krq9P4uwcCOO3qoPzHH2zynHOZftg/jmtOu3tS20i6eyC/bkNdIevRb9fua?=
 =?us-ascii?Q?u0amiv2lYzBHri5TN//IpT0M7P23zdcxNQ23t6FgrR02T+7oqJBtCSdSlmkh?=
 =?us-ascii?Q?aUenTQO+VBDCEehTJgzc6/FdOgwxR8eC5CkGCt35xZvOSOMYTtqLb7wxe9Gd?=
 =?us-ascii?Q?+wApqzbQuUq4wcTEo6/FPBw9z7l8+pUjYXyeJcEzuZ8SOUs5x2yavQK7knCZ?=
 =?us-ascii?Q?2FNn6CWlckbC8NKqoaS2Jo3DQQ96q+3HfoF0DNyyk6JMycZQ66mcfFEYE6dx?=
 =?us-ascii?Q?wfRN6X22ADzcLrH2MmkzYLMxuwYKgtcasi7LHQNTmKe4ITJ60O4hP8NELXCe?=
 =?us-ascii?Q?OYQkkgP9FYITVNhnl3HCkRnHzpFN9m5uHaWXgmCTbi0NhxWDqtTcXlmdEOtv?=
 =?us-ascii?Q?cf/yRQiuCEB1/Etj7fqMzji2wIxb+E/VRKWyoVOK/aQJEwvLGihuf0EtcY7B?=
 =?us-ascii?Q?iW54xxft3P1EoZ0aeP42AsVNhsbrpbS8303G9ze0wVqOg5Z6DZGk7n3J4HRA?=
 =?us-ascii?Q?OaElHif82ZGYYXbHfZ4HkgPebcz4W03EZ2wrdOJPHpPtrrLtJw9mf9J5w0LR?=
 =?us-ascii?Q?dPNYQp5XISi71OJ4MOypDKLkArXj5fDfGLNt+J78fNXwiE95jSW1S+pjv79q?=
 =?us-ascii?Q?eMEgruLhks3kCUKDJs59B+7pq73HFMik+lzfMVPbn2xc2IiOdOrD8pbIq5g4?=
 =?us-ascii?Q?fvup5jbV7LRh+eEvHzF1HaCFPDMONUw7XVF5WkyKpovAndqYYWWfQCpOetMv?=
 =?us-ascii?Q?l76IvRZ1FIPO36SANJ7+5gSXYkhqSeVQDDeQf+yKahzzjGGyctqYIM4eWR7E?=
 =?us-ascii?Q?G3QRUmHsCngvrj8jp7U8HSg9VY3LxfhBLC6bh7h/lNNgyJ5I0KBQIGFGvN64?=
 =?us-ascii?Q?EJau8QwDIHk022s4Y6u40f4fvDVNkixhRdSzau/0j27PKAMVfXleVM0NOsFb?=
 =?us-ascii?Q?YtI299XiTQB0Dr7MqssYwaTTeUp7l38=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 904c6689-7250-4403-9384-08da2ca9c19b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 02:08:03.8140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUo1avQqcA5PZJauuUQaE/2KXWbw1CWkrvGRHv2EDMaGTTwNEf/2wAvNGBQiiHRZRBkTocvVGkj/GJwh/GNwkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6364

This patch adds the round-robin BPF MPTCP scheduler test. Use sysctl to
set net.mptcp.scheduler to use this sched. Add a veth net device to
simulate the multiple addresses case. Use 'ip mptcp endpoint' command to
add this new endpoint to PM netlink.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 21462c29683c..c400be612f72 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -5,6 +5,7 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 #include "mptcp_bpf_first.skel.h"
+#include "mptcp_bpf_rr.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -375,10 +376,46 @@ static void test_first(void)
 	mptcp_bpf_first__destroy(first_skel);
 }
=20
+static void test_rr(void)
+{
+	struct mptcp_bpf_rr *rr_skel;
+	int server_fd, client_fd;
+	struct bpf_link *link;
+
+	rr_skel =3D mptcp_bpf_rr__open_and_load();
+	if (CHECK(!rr_skel, "bpf_rr__open_and_load", "failed\n"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(rr_skel->maps.rr);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_rr__destroy(rr_skel);
+		return;
+	}
+
+	system("ip link add veth1 type veth; \
+		ip addr add 10.0.1.1/24 dev veth1; \
+		ip link set veth1 up");
+	system("ip mptcp endpoint add 10.0.1.1 subflow");
+	system("sysctl -q net.mptcp.scheduler=3Dbpf_rr");
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	client_fd =3D connect_to_mptcp_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+
+	close(client_fd);
+	close(server_fd);
+	system("ip mptcp endpoint flush");
+	system("ip link del veth1");
+	bpf_link__destroy(link);
+	mptcp_bpf_rr__destroy(rr_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
 		test_base();
 	if (test__start_subtest("first"))
 		test_first();
+	if (test__start_subtest("rr"))
+		test_rr();
 }
--=20
2.34.1

