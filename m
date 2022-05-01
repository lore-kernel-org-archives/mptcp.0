Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671EB28EB
	for <mptcp@lists.linux.dev>; Sun,  1 May 2022 13:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651413470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QP/HhjyqP5e+YvH8PJ+d5E86H72GakFzEBOOq5Hu6Yg=;
	b=aJxs7BEKUxjawx2YcENqVbq2ObNIZ43MZocNClsSzKxq5OYoCCZUlGbgHvvgxgrPk7eLfh
	gGPmOdg4t4Yw8nncSrMJ5re0QpkssflbeTUIGdu0NgV4tI/tzwLrGC7N8eZYU/pOjOVq/d
	Y8HHgwqXR8dVYFJRPB5NoX/ZV7DPoPE=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2176.outbound.protection.outlook.com [104.47.17.176]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-30-BV9XgFGhNimN8JwmizjQLw-1; Sun, 01 May 2022 15:57:49 +0200
X-MC-Unique: BV9XgFGhNimN8JwmizjQLw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RogzVlAcmXOOa10K2RhX3WT7D+ertRpoWukxWTWAYPfdVO8+WxVmAgGqycUkONelKOIVlN5kuILVVaBuPo7Q77h7EkTzb4QfymPL6obJfYI1Oua7IhVsKJBI3FEeUHRy8uzJPIQGAcOSIZ8HCaOEec07p+/eIUQwwzNBDP2my49H5edAlPEQmMh71dYBa2ZvxuPSodmHVdtiJL0KV0WVzgCXRkjK3R2c4b3IYB4co1qJixOVG4lS8ef0y+bBKW127lvWuBMUOfT6SY0GFjtx27nDOvMpMjmfGQlPte2htqxFHaQXZ8gFmMgCZ98VRzjUrmGAFMggULmoPkEzCXDqeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioI8YHiHz+f7fGNENfwLQdD9qu5mu22h56pvCDu9Sqg=;
 b=JsflYwAMCuczh1YHlcX8MqkpVFAQBS7nxK6M5iZoRoogbsqr6btHJRPDIrE+d/oo7QTe753PWfYcbHSVLj9dtxgWG3kHyjDxuyCt9HCUrBHmVkmfxiR0PbVYC+yWf1DXJX5qjNJfr5v2CdZc+cNoFxcWIbbCZFnJcBn3z3KJfhH7LIO/Y+OrnxwDp1Ow6kRXiOIIZhrljNiTXS+fbvv3DK4cMsxhRFD2H+zdZqJyzSvYSKzUNVoE44gbLMYj8GQglD8XOQRpDFwH0UgnEhBXOlA+5GN339HBKsFEASKDm0GT1QoJktAwY1D6hDlI0cDh3mQZF6yfsaUrHdNdBw2SjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB6605.eurprd04.prod.outlook.com (2603:10a6:803:124::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Sun, 1 May
 2022 13:57:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.028; Sun, 1 May 2022
 13:57:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 3/3] selftests: bpf: add bpf_rr test
Date: Sun,  1 May 2022 21:57:14 +0800
Message-ID: <f21cb6b7d49b4a98dbbfff20321c5a9a2e382456.1651413062.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651413062.git.geliang.tang@suse.com>
References: <cover.1651413062.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0054.apcprd04.prod.outlook.com
 (2603:1096:202:14::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f450766-c37e-42c3-684c-08da2b7a9345
X-MS-TrafficTypeDiagnostic: VE1PR04MB6605:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB6605FC016856D2FB18E98D10F8FE9@VE1PR04MB6605.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZRbz8vdvD7wU0xjiOcHTFj8PxLjBJU3pZlG42Lm3Y+xCG9IvHlZ3im7l8255oQOYTwzFCJYym7CtNWl88TD0PtAjtUg4ajkh+HJLOA6VSCK+6cw/Np2KeYO5oVPbJsFpVXVrRnCgCPlwelADUKZ+bya7F1S58vkQnrUe9aNnj/Yx5tYyUcYMO5ousUFYCIVYy9FrOj/eTuZls5fGqMxJ0pPJBZNn7zSBmg+42odQGVmy8bP5Qg5TGzvH1xoJg2BaPN+ifwBhH4+6w+uXIMZpBfpXDqb+ayydcujZhYZcz94XzXJqgLAq8TwzabGZuk62fszrvbti1I1SXlNtwJ5w3vp1MvDCi+lpS0kaUg3DaAYzA7mlNv5fEoc4Wkx+0RstkhquLywev7mMcs+M/Z0ujW5h+J6Ist3qBhUnzaE2JS22MlYGJoBbduEGeDlthBRxZNyKVtNsbfTStLXanr4hV5kkuDy279ZpQHHMSJEszWXBCK1Cs1Hd094cEVMFaYzsMiBN+JV8YPICsJ9p5UwuAK2QUrSd8DpmeI1XFAxhqivrdwQN0vMSOycyPK5RT+rP8FjFwLhfPUBKqcdz1TP2OeMZVpAJ4uAnmAg+vS9sYCtmHArjrtTptQQgWowafe41hqW8nsYOQaQza0oVyXjTO5O9UbaDyrfyrnSRQzRCgb5Z0FizugXpMCHFE7ltuVP8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(107886003)(508600001)(86362001)(2616005)(6506007)(6512007)(26005)(38100700002)(6666004)(66556008)(66946007)(186003)(66476007)(316002)(44832011)(2906002)(36756003)(5660300002)(8936002)(4326008)(6916009)(8676002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SaIbtl4VtbKIPADqECxh0x0g00JYdz/ckcFK/LhyirdoCdVDdBphix/h3Bkv?=
 =?us-ascii?Q?nBF+N2CSEjkaEGSSg0KoaJjfSz/DAOdjev08A1B0jYOVAiIt04cSvLBHu5EG?=
 =?us-ascii?Q?teFpWgglRpndCcqpgt8ttdOH/IIl1xNbSba95gyoMhNH3wXAePs0l7xztikF?=
 =?us-ascii?Q?HsEak8d/Il+OL1Vi/YV5175vbCdcO2d9+jh2MibwHTWtFFRS6zWBQpsI6Rz2?=
 =?us-ascii?Q?de4IKVkhpLabbWDvl9CM8C6PAvPqKgetcipzNiO//It0hYqb3o6RCFvMbDUJ?=
 =?us-ascii?Q?jpnjN7DZ6i0jdUX8BOuukNT15flsWJsKgTNPnemRK1+7ItsRuS160rr0fOOI?=
 =?us-ascii?Q?/Jl3ozUa8Ndre7sp5ATE9j3aXMjK2BDr5QB3c8mP3/iZ77AzcU8RZHB8EEjn?=
 =?us-ascii?Q?F7zYDVxPtVsU6btCCoJoL5449x8v7zIRlkJeQsjb+2Rxkb8Utwq1ypKNoZjF?=
 =?us-ascii?Q?EK24ZmY7MF03yLiiUEnINT+HIsgmLpnqZKW20VsQqXLLjVwDazyYLH0MAFzE?=
 =?us-ascii?Q?wDbLnJjlOAh10lWts+bGqB4oeN7nEjpfPBzZy5qGdMTD1HKSEf3m0jVtHoXw?=
 =?us-ascii?Q?O711SvFCH/YjeAYfcjrV2iMn44HupiraM/vKh+E+/0p30/q9/God5E/WFxq7?=
 =?us-ascii?Q?EN18BbLDr+NbdwtriSQDDBM24Z7YxWptMVCnEHZsqdfOLIMJyvF6C0F0TIFK?=
 =?us-ascii?Q?q6YlaZiOd7L78PfTsWFF1gV4dimAYxcc3ioo4nwDcTmI2BsXC8YVSSfNXceU?=
 =?us-ascii?Q?y/fDyrPegvnULUXaISKKzquGSEuPRFH6ZR9rPFkvNKQOlyYfFqM603V/K/jX?=
 =?us-ascii?Q?Z7Y/uCBRLztBSCb5o2WWimocltkO8MlYKuEOpxJOlZBYh7p6eQqPuonmyK0A?=
 =?us-ascii?Q?GSJsLaWE+PoKq3sftsVDd8cVlL7rCTLheL0/86TQUkmd+bMz3uYxFI8VOW9Q?=
 =?us-ascii?Q?OM1ROYERKn1JI3k9mYUTp1RE3DMNryn/c274Ju4bgVErl+Kx7OlqHWq4cKh1?=
 =?us-ascii?Q?YmXcLzFY/k7sEj6dShIYZ3YPO9Zqi0AGw/lA+zHKbJnQjtiucRU7dQzrCPxE?=
 =?us-ascii?Q?5o8fHXLZ/3kfKNc3vjsfYhBXiV0qGByccyVNl3JBMBTirrzqdb1q/xiMuIUu?=
 =?us-ascii?Q?FuwmlhOQZeStoA1UI2o3yoG+9nAYmUX6Fb5o4zzUsIiW1OXaGoEyFkKwuZOt?=
 =?us-ascii?Q?GQOEfhMfWxMztwRXHN8gh/iUTgu6BXWBB7BtxLGb6DN1YZFyrI256AeCjI9u?=
 =?us-ascii?Q?Bop7R5pLEYEjR1HhUiiR/ulnHdXFZ82nOWJ355VRYdbha8sb09qSRDvO+twE?=
 =?us-ascii?Q?wv75W6WGaaFe/l4gH31FIG1kngL4k7wFfmBkeQoJfCepYDUj+8X0US407CoD?=
 =?us-ascii?Q?P8qKvZD8PFN9Bzev2sKGtCxBUVvF193N17nzSRKEofwOEHLAkpj9l0y+C9WD?=
 =?us-ascii?Q?BZIaOgPZplXi/fptmGrH6O1yfwITKzwU2z3E9NG61a29trc1OMu6Th3Vq5b5?=
 =?us-ascii?Q?6m2TagPzSqCnRZUsVHQJvQUFfxN30iAbo5xGbrt64AViABrD/1zqiXZKz7vz?=
 =?us-ascii?Q?JT/ZbPrE9fNlSK3qJ4AqI7L8W2wNx+y2QFMQWFMLs/CfkBBv2msb3G62SGgR?=
 =?us-ascii?Q?im6pIcaB7DlsQ8Oa6hWZYTPUBr1aDWH4Vf+6HNYsnoBvGP3US409gVLHmbaK?=
 =?us-ascii?Q?WXh5YrkOWdC7BTEWoVmTv7ixuBXIk3VLECXCujm0oM4CP5Ppe7WErLWpAj/G?=
 =?us-ascii?Q?7mcbVg25S3sbnMV7muR1LiQnA1T5nec=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f450766-c37e-42c3-684c-08da2b7a9345
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2022 13:57:48.6431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BeljjctHm0iCHt1O5ecJmvZJ/AIU/alnx5K07W1h3heRx28ZF+d9jMQziX+2RYJC0Qu5BS0kp4YVgBHfx2LPQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6605

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

