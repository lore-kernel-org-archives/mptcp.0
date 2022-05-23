Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8067E2592
	for <mptcp@lists.linux.dev>; Mon, 23 May 2022 15:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653319574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o2T7mVubO4wK3t8OKAo+M4lfxkoVeL3vDkH7Up6zTd0=;
	b=gZ7sNYg4Xuh4S0ETf0FaqwloonkGFxrBIz6oQ4s001iqz6p3klJf4EcnsSJ8cXGuHa6jG9
	fxSJ5GitRxkxJZYoaiJDyqrjvIiShv55SO/9evrMvw0FeYFHCq8wBq+48MvwXEdMlfhxcm
	CIvSUjbAYYsuOaKEHhflNBFocfMavZY=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2057.outbound.protection.outlook.com [104.47.13.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-I3rZYC3vMlOI3PRPUTpHEw-2; Mon, 23 May 2022 17:26:13 +0200
X-MC-Unique: I3rZYC3vMlOI3PRPUTpHEw-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oy9mKu2fIDQfLg+FRTGBfGjdupMrEVffOgbe3JCWNm57KCT+OIgi+sfX7HsSqZf3t9/985wHPNFtj5o5ozYmmX0XInWet7nR/dS54bLE7tBdS8m5pzu7bZ2MvcFMY707iahvaHYcchdfm18NIa5O/CTvntDN1Hs2A/1OBtz2TOVgwK1yNdIPzCKCxeKNHY9h3c3TaITYuaC429zxq64pjL0s0VRZFFqe3V+VagTtS+nojBtPREFt6WT/0FFv6PorEPDCQxHExQafOSf2DGlWmCyT/9YmuENVzwQKc9lCQuUdOrZ/kRABvFu4LNh+4w4aT2THM7LvmveytvFZGCKxNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyIY/QEIFZgnefDkNKNmY8JMeoMtlAOCnZdxvWYV0vc=;
 b=JQUTgbdRV0gRSalTYPyxNIlb+F4TLAg4q5y0Xy8dWv9e7ovdAR3sLnZCrRjmUXMsre+P/C7ABIcZjjv29oqXT31dJI+KCG0juMFz9mhxIxkRQpJuSgrSWMQXSOvlUQ+pL6ZW1P6DiFs7E0dORn1pdYUVTkOJWa4V7aQTjclorP0WiBf3HvsJCYQ0V4uMNFo/o63fBxRXEXJYC9AtszA7T/oa3Ew2JA3Wjm/g+ZSVb1XVX+Pm1KsuIu0PMw4qBLert4CS9yxdcSjMj0KkLVRePnNQ0ouhsE0x0HD5+iZuqPO4yR/xDXy8mRX4mior8ePH63o0Z+dmL9DmYz6DsHy6zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5681.eurprd04.prod.outlook.com (2603:10a6:208:12a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Mon, 23 May
 2022 15:26:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 15:26:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 2/2] selftests/bpf: add bpf_rr test
Date: Mon, 23 May 2022 23:25:54 +0800
Message-ID: <b2074f7736fbab5843560833ec010d844134d6ef.1653319279.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653319279.git.geliang.tang@suse.com>
References: <cover.1653319279.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:203:d0::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a371dd25-d741-48d4-3e0d-08da3cd08ee4
X-MS-TrafficTypeDiagnostic: AM0PR04MB5681:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB56813CBE77D3E2AD08EE43E4F8D49@AM0PR04MB5681.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iTXDkM6eSff3nqUrLJGXVk0vhRcmuU2TMufb4Nd6AMv2j8ztzOfuatLWjQUAe8RUmcdywAF4B6NnRO5ESCRasww5bKJOFTQ9WSn5JtQQ2EISA56UTtGnXhJww3pGiA4zHDITFv2fv5DuD9IttKm+rWW1owdtn0a8CfbMwYi3P1YwS5RnzpFW7uQb4xJWqlB0Uj7yFvD6oivz2Dh9lx8NkKzlrDmg4XoGF6SfF3ER5LpUthUPXLPb1AVypDfF6/fiI1DE7XdjebRXJQfjPB4SZAWal5dU3VN3a8Src79tiHP9Lg6ievi6leCiST+G1rjq4S5gBAO1YAicrVSM4Hx71vmf22NHpJaHKHjcpEBL7tobn8QATuCd7o6FmIHT3BL/Qio7Y/d/cqJdtGwKpgMMr8BbbYlwpY8hxXU1P+nu0KrGN6pxrVMijCf7grvl90h8KTE9+UIXhfu6kM1FSjrn2Ro4hpsuridwXk9twsYp1eJxPLDGxlD2o2tNT4eer0DGrB55fETrZV/taNh0vegi75FoOzawksWWP35AV20+JIAGpS6xrbGcKvQqd975/cKGTWe+yDp7uVJSpKxId5Po8fS6GveU7nAu3zg2dyT3207jfbLWEcebiMMWv1RwGh+myoNXwtdRNjmjFRbOQOjgf2eoFJoXnq4ZTxYLJf7qGgMj3O//11FI4cfn7jGsxrwe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(4326008)(66476007)(8676002)(66946007)(66556008)(83380400001)(8936002)(508600001)(2906002)(6486002)(316002)(107886003)(86362001)(6512007)(38100700002)(44832011)(2616005)(186003)(6666004)(6916009)(26005)(36756003)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sfyez7q7PPcFg1vdBD8unjh4LiFkB7wUfnZnJLOUjIS92kki0H6bHPfzI7jg?=
 =?us-ascii?Q?ujOD2k8SmqpVQzszSZdMG5fSveSuf4xUv7dLuD8TUj8f1jS7EiFHSunSoyBn?=
 =?us-ascii?Q?cqbmOOT7YfVHf/LKBIBBr3t48GUUsib5RdC9/DBYuzgCnVwrdLHcyKaMs7wz?=
 =?us-ascii?Q?rE0Ppy/2jmaMlhOPBTF4pX/Z6WAOPcZvIPgNE/n0rYfRjXjyO+VFz9ata8KR?=
 =?us-ascii?Q?Znnv1ysPGWp3l5kbeusV9QJS/iUExR2dZJB6I3zpzUC60KducLh/GpKPNZWh?=
 =?us-ascii?Q?FkjeEa47w2CyQVLZETEiZylxxSmKYTCnwqVfoP3OSKeOCaMHDo1hQL8NRB+Z?=
 =?us-ascii?Q?U+YmFPi2811J9OVwHDU0r4Xky3nm5L+m+RFMDEYz/wFyVjFDBj1BFymYub11?=
 =?us-ascii?Q?Va3+yMj3T7bxSjHzWg6O87eTu+j30w7+UnLnXFekBLzpi1uNk5N0D9OFmc4d?=
 =?us-ascii?Q?EEG6bLCFOksrugzZFaJiA+/Yx/XY0Xb92YW9YKYU0bt7jhLxsic8dT46xr3w?=
 =?us-ascii?Q?f0xFjfIknX+gKhCQklv2ULDBQ/FpISWN0JOO+WPBm+6OYrTNIhLzCRY0APMr?=
 =?us-ascii?Q?hQ7mbcSk0ekG25mK9T/uwDLMDg7IIuSSotfxYao9ODN3cpzW0CO3zFZW/jbM?=
 =?us-ascii?Q?+PqdDeCJcQ+KawF2MOGyn+BzN9gy35qoqx8Y6rs+Hb02zR5ITOXCZpg7ZbFf?=
 =?us-ascii?Q?8S63fzP+Yo5gL/YVF/+XEIcDHwGmgOl0X0FrtzWy8edJFRw2ZYe+bqV8byY1?=
 =?us-ascii?Q?90DdbY8Pl3ctOsdox3e0cgaJc5ehyiPjPtBXST64442Uy2Plgs+WB9tyJsVH?=
 =?us-ascii?Q?IAjl/uX4SIbRsGet+9dchiggQI7PD2qOvwGuEjA7XP89HKiLbfiv8bOi+N7j?=
 =?us-ascii?Q?wKGM2tH6zf2+ax/4X8rPuedBBxfkm1O7b6Z0a1dhcqWR/KHgeNB1A+wbQbYa?=
 =?us-ascii?Q?cGL3hANUw3b+qb+69PoPUV9hXjXflYUkcpFuIU7L4SrRNCNs+nYPybRfc358?=
 =?us-ascii?Q?KvOQ/g25qyrtqIat+EfCIIPWd5fssNCJCnWS/6a19iyCFniQyrkr0YBgMAG1?=
 =?us-ascii?Q?aEPbe3SixVKFVJeZ/WvkCj7xn1sfb9ZlZ5vaXof4o/+GGdEs4EwNGCb7qB2z?=
 =?us-ascii?Q?U4PQsQIa3WgUM+7s9kQDnjUrDtmqy1JadBC6Skg9eSPZF0Ohg3TZ3R2USpJ6?=
 =?us-ascii?Q?VkXdSFoibzDsOuFrW58MUq0u9GiQT9+Yb+MWmyMPOscS452Ft6EQo+2EGCfP?=
 =?us-ascii?Q?uIzMRiqlN8yF1LacAEd83qmxoOT4o04dminD2sQg4lIpXrF9vZ4N3a4x+aXe?=
 =?us-ascii?Q?xKKZUinjB4efALXCIobrjv5uEVbcr3riwg2oFBfMx5uLZiPkewKua7uSjOCb?=
 =?us-ascii?Q?9ojEElmOj0uGbYtmLgEEhjpjFtVKGjlzaBAynt6i85KSUcCl8krFuNpUWqWn?=
 =?us-ascii?Q?/p85IVCzCLNa08CrZYqZ4zdcnybnNmEzDGHRjxnsJVpJwrDM/rMgT/SB651W?=
 =?us-ascii?Q?K+FvIOiSsdVadxJ5yD6AcBrOUViS9sXaaxQMNAe3sowQxiH3WJ4GFP2Hieco?=
 =?us-ascii?Q?fE7TT0tAiz9eEnkZ1Oeocn0sosiNEA7zSt30lQ8hAkh2sg2JJzIcOrB+UyT8?=
 =?us-ascii?Q?j9TryPKD+JycGXlzQT7qtH/lmkVpemjunhGgcUPtqrvgKZbeFPJ2efcTAw3Y?=
 =?us-ascii?Q?HP0YnTiUT3zO3iUtCqtteX3CnZYaUubdaQ0BScLGJr5phgns4+/7LaA7/RNQ?=
 =?us-ascii?Q?PlNxdJh88Hn15Gwd+UA0OSrpy7rVBVY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a371dd25-d741-48d4-3e0d-08da3cd08ee4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 15:26:07.7658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bt6g1fCqZhWqcf3t/VStJbZCRHsl9zYUeTcR6H1heJ28eIvqASzg2TNpQkPaP4lDDqmI/gJGZf1aGGgu5+EdLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5681

This patch adds the round-robin BPF MPTCP scheduler test. Use sysctl to
set net.mptcp.scheduler to use this sched. Add a veth net device to
simulate the multiple addresses case. Use 'ip mptcp endpoint' command to
add this new endpoint to PM netlink.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 9d37c509d3ce..1746b6488bc0 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -7,6 +7,7 @@
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
 #include "mptcp_bpf_first.skel.h"
+#include "mptcp_bpf_rr.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -279,10 +280,48 @@ static void test_first(void)
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
+	if (!ASSERT_OK_PTR(rr_skel, "bpf_rr__open_and_load"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(rr_skel->maps.rr);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_rr__destroy(rr_skel);
+		return;
+	}
+
+	system("ip link add veth1 type veth");
+	system("ip addr add 10.0.1.1/24 dev veth1");
+	system("ip link set veth1 up");
+	system("ip mptcp endpoint add 10.0.1.1 subflow");
+	system("sysctl -qw net.mptcp.scheduler=3Dbpf_rr");
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	client_fd =3D connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+	ASSERT_OK(system("ss -MOenita | grep '10.0.1.1' | grep -q 'bytes_sent:'")=
, "ss");
+
+	close(client_fd);
+	close(server_fd);
+	system("sysctl -qw net.mptcp.scheduler=3Ddefault");
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

