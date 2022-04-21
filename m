Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7117A
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 06:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650522399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x9PjuXmxx//rp3Sg1bxMtKi7svQtMfnWGsRK9tVAIhg=;
	b=EzRILEm1X4zgaRxyusniw5+W5XpKgJ3qs8wmyTzEmBJaZ/uPFonqNDyr6EIvjqJpxfNe+7
	xp8iBdmmE5lHAwmXb/nqe01WXktZma6TwugjGuwK6ECM5wMcsKoHghK8c0kEMZV6gWKc5c
	O8KYR5aX0roZS9QvXPXwsyQRwN2hC0w=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2112.outbound.protection.outlook.com [104.47.17.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-j5Hgen8dPCWOA9-KvwnOcA-1; Thu, 21 Apr 2022 08:26:38 +0200
X-MC-Unique: j5Hgen8dPCWOA9-KvwnOcA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VawV1tAIrGoUnc93Wuc2eBKc5I4xff4O7paSxjJaz1/ccc6+un8G2Bmb+zMYdc40MSfjnBmlCNKNuOJIVTftRmZlQvcPrq6KYm/XGTfdoJjnEa5VcKJg4a4StCmPB7AQm08mBb2r1uh/xYVKdDfcuXrLh9n3iKuyqE0YrZOaLD5n7U1SnoeMvCbcQ5LMgfn4dcFHlAMSXiTkgHgc2304hIHCSP17R+Rw1FKVmDV58B6N0NV6lakrxgr9bfIwjBTUdfLTmq4Ou7PABV3RcLlySrgBF94qM1RhoYHpFItaIU8Dnv/UhU7dR2c/xE0j5HAbaAFa/0xoDdn0I4CA2C4kDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDnccN4Ej6cG02KY5kELgZn3ENNVMtxOEg3GeS2yTrk=;
 b=OXMPV6tpMkWrfJ+uo+BuThJgtg5BllpnS7O4N0cDxMjxZHwLCO1x4zAtzcg7cs7V/pREw/hqKSEPSFz2EIMx9zfhgg0RdhCp4TpJhZ6+bK6eSOv7DB7pt7zBRgyTyUofKtngn03V3TvWXxH4fqI9XuVaqdQe21BkJtR9DHQUb3ttnl8kvNWGOtbtWFd4JBoc2zeCI6mSOUs6RwMEK9QmQw4kISW95k4x/cLxnK60Wf8kwwNAe7f3vjtZ7j8z3cUuWYYmZsJV8FBvsS284zTiwHfhix1E2LYehqYNefxXT/MsQEmHG34c2mZXfLkLBq8hmZoocB0eAs0flrix1E3zyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB5855.eurprd04.prod.outlook.com (2603:10a6:803:de::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 21 Apr
 2022 06:26:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 06:26:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 3/3] selftests: bpf: add bpf_rr test
Date: Thu, 21 Apr 2022 14:26:34 +0800
Message-ID: <9656f5b4ef6b38e18264e250c1ada42774eb0961.1650522297.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650522297.git.geliang.tang@suse.com>
References: <cover.1650522297.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0063.apcprd03.prod.outlook.com
 (2603:1096:202:17::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81b05bd1-66a8-4e3a-04e8-08da235fe329
X-MS-TrafficTypeDiagnostic: VI1PR04MB5855:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB5855A95962CB450F5B8FB9B8F8F49@VI1PR04MB5855.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4dn62MvXBNpBWNzl3R9OxH7HlIXCKzXaur5gzCXGH670Peaead4jcMEofXy44/3pENxwCAEMev8pL/Mg135t9VWqWAkX6nfBPf427qMX1AnZ9Ue86uyV4YvaTMHwNJ9vOKe0lbvCOSu+g6EiuxhV2GsD2m/04XRmitRy3J+JjCqzEGopqz6kVYIIGg1PpSQ54z1Qo327aLuLDJKIoCjf3J/Iikv86Ie0y8R5APnCMM5tB1V4CGEf7sXl14MivUGxZjlMs0k7eDb+ed7Uq42tuuNiwdmKaY/xfd7X5xnPnQfnJKyZ3Yb6CtR2Rvq1nQ39AJh7OCmjjRZV0V6bdalr0Jk5+Dkic3bF8MTO+c2c+7ey7UyXXLc8tWQZm/Glp5FglBZWa9YNULnmWbpwo9Stk7Nn0ZSaxEXNndfa8dePfe/0+yVs0ztJsbaa/XtnjapcCuwoDNlZoRQiILwChT+OEioq1VTfsysd4bo8STJtJhQVJwZSSdKNHbu8ypw3CvSBymksUQTSMpPCnE35a5BkZqmpVje+CuJ5BGV7tvwTH2X6TGwFduiq9EI38GTpTydqeCCiG1/R+HUmVRQQuWRSbpe/GRkmnfwmYX+ygJgOjYa4E61WV60QlyEG6yzKcMqi7DLt2UDJDkcgpv5z78+mleFmc1UB/1QaiDQr1WPrMDuumhnZK0CAewlhryo5HwoL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(4326008)(186003)(38100700002)(508600001)(66946007)(8676002)(6916009)(6486002)(2616005)(316002)(86362001)(66476007)(2906002)(26005)(66556008)(83380400001)(6666004)(107886003)(6506007)(44832011)(6512007)(8936002)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gqNikqVVpMIGCUsI+4NaVr5WWUkw3ufNoDwCNRS7Zts3W2HwgOTvR6QO7jDK?=
 =?us-ascii?Q?0adydT2tXkDTg4P21Y+kYXSJ2P0bgYeSLlysRZ5RjuCZxxGEXuvJwwAy1evc?=
 =?us-ascii?Q?tZtnV7aGkgnk5Wft/AddosiXaAFdbXhPeWEtaH/gmg0yXtEREP2Zy9xlXft5?=
 =?us-ascii?Q?IqaLMqZBvLPkaO8V2x122jvN0ykHpIaZXrGHYOe9pQ+tVPfIIqRzDBcET4BM?=
 =?us-ascii?Q?nE4qw/+4aBNF2VIV8TKHwMExgjI6tH2zNbsgopQcK66ZpChiQE0dIDLlcpI2?=
 =?us-ascii?Q?OU9D5tCaUb8aGJ1tv5pFgcTUHZ2xOXEyyk++IWrQaR04Pu231HmIj1cTd9Fo?=
 =?us-ascii?Q?67nZFIxHzbC0APBNBPPARlJHr8OFAxXU+sBbUgnj4ye+H491gKuosS2cbEmB?=
 =?us-ascii?Q?sehKzwYevg0rHQxUjS/5QY2yyOOsx3N3A9rzfMEkAZySP4xc8k1d38z3GDet?=
 =?us-ascii?Q?XXgtVUzbXh+xHtW6d4yY9Tw1js0eIiBhWFmcGZe6k8cJREAfaIZiyzYYK+XF?=
 =?us-ascii?Q?EacoxPQNtS7Ou0xsrU4Tc/21pgESXmwNzQMMMcvsJ4yuHsmeKmP4YQk3NtSn?=
 =?us-ascii?Q?toK87KKbfKOpeMfGrrWfu2i3W/tcQaiJjf85cLa5HOgclU8uXEeAXxahcDqo?=
 =?us-ascii?Q?TdcV2z3cuWrJTSopBW6hcxgHP7QLUFpFvwooLihSPMVWFpGRzPfzxVNJhu6o?=
 =?us-ascii?Q?pe1gFTSk7XY1oj+PA6z3pV87XWgyusc5qKLrTPW6As4W8YW25hdc7I+qTlAk?=
 =?us-ascii?Q?FSzv7YjUOXN1KXmzLm+CVNfvgL9GCOCpsfmuCi8YK1sl4QOhA/yPoulvHCkQ?=
 =?us-ascii?Q?n1RvNz3MupdmSNjGUSynKuMhkhTZXoITQlnNklXY0Xi1kmYJAxpyt2QB3Vup?=
 =?us-ascii?Q?f+8oq7zk2siKAgFUKKoXXnoaBtQt9EjITLOsXkrA3caSS2N35zAeiZ9EciOo?=
 =?us-ascii?Q?snd06RcteChjJHoI0Mgiz+UDgEyc2vOb4z2uHoN1//dtq26EyZBPcr6crUoo?=
 =?us-ascii?Q?GrQwv2qZ5df3sGSohXHYC0B4FNqStZEpZSBkKbXGyywkSLQU/1NxZA+O4NqX?=
 =?us-ascii?Q?sqCzdu5Sg3tZDyt0po3iPnmXSfUMI1VYYykVKHZWGCVWuAlMlQ9yYbuvwqtG?=
 =?us-ascii?Q?yFaH39m4z5iQoVop2I1Iqvh+ibtHF5Z/VEk5Yt8uLlKVzMWxJEG8LcgCpz/W?=
 =?us-ascii?Q?MjXlka10namsPkvdh54UfgE9Yn9YIVkp/aHuAEeIX+rI4FWVS1FYpzdnx5U0?=
 =?us-ascii?Q?DGORJ6KKRip+Oq1bZkR7p9IRdN6egbfxDnSLV9an6f3ebzCWYRtBKf8Xi5jt?=
 =?us-ascii?Q?ynVohHrbjA6NR7u2BFSqXy7QUVGb7ND6PE5ZHbvdbul76lT6IuuETnvNZbvx?=
 =?us-ascii?Q?j8/OPWqBRqgdLc5cIGaMi846O/gerVmmVsOoKpSKTJCd7ogXZ8uv4YPbcG/c?=
 =?us-ascii?Q?nuFeApDWy71JWRG/TyFA6RRtqtnAY1TYn0ftNZTeZOQQ20K+sxJtvKf0pVYG?=
 =?us-ascii?Q?wpySs3mc6sM9gl2g3olvcKxFZzkKUVkrEliNwePUOHEL2sP4IeWK8TuWoLy0?=
 =?us-ascii?Q?BzkwKzT4Hn3IXrtu0rwffDeASJ56bJ7MV/q6L5MCvaTQlHHoAd7LR1/z3+2p?=
 =?us-ascii?Q?1di7RK20ODpmY4BLx52XVD37BtJjnwFA43D1JoxyqPS8cr4IlRit0IHfHWHr?=
 =?us-ascii?Q?8FwY6rcL5Idiru3RK6WHT71RRJd0gmfzkIWFQP2Q/G3x2DfPbLF/b0CWS1zU?=
 =?us-ascii?Q?R3zADfFboXkos6k+FpFuOiUruVXOooQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b05bd1-66a8-4e3a-04e8-08da235fe329
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 06:26:36.9452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: piEofr2dw3IlWK0uhBnqdLn4IueghiAL7MgJkXTtBRzLEPO72XVHYUqp4e9sJJMg/pzE/ovo7LIz+ruRa5oZHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5855

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
index 377ebc0fbcbe..7052c520c0f7 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -6,6 +6,7 @@
 #include "cgroup_helpers.h"
 #include "network_helpers.h"
 #include "mptcp_bpf_first.skel.h"
+#include "mptcp_bpf_rr.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -362,10 +363,46 @@ static void test_first(void)
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

