Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3421228E6
	for <mptcp@lists.linux.dev>; Mon,  6 Jun 2022 14:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654526544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dcxFYknSSqn2iCp/EC6eSvsoTZmmfAXbqcIbOIVxtBU=;
	b=Wn7w4EfhMvUojkNUP7XI5KeYusmQywC5fQzhh+TYt/ruD0GccTPW1V/878xBoj6lAIZg/k
	1X4+bK3JAeSb00HPlJcXcdJSNEIUyPZFJxb1vA5M5HT9voTOIZyOMIoa88rcZ0yzTJtWle
	AUqTv0LYk2EpCDMbLsNjD3nLYmBIwbE=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2052.outbound.protection.outlook.com [104.47.1.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-32-TTzik33xMQyweqewqVhXMQ-1; Mon, 06 Jun 2022 16:42:23 +0200
X-MC-Unique: TTzik33xMQyweqewqVhXMQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmIqp4cgTDdISQ6LVo2Aoap2KjutQwzuKBBm7CLAjQOVchkQuZVCMH305xdrkdSVod6KzoX74GGH/7uzlS+8UaKBTi/Du/FH4DvO9fevDSzGMywUPj+Way8BwRjls7vZnH3JROchlwhu4sIHl0g8PqamDZXBv02x3u6lG67/5y5FHu2AN7FauFB5FoqhYWpr9POUnTXaQhMzWsHuWYZBSt8cOcJoqG+DZfxKzvp77oq8Vt711jiQaIX9/AE2Z5LiIN2ODInspohpZtj4MOqre+xJdPTYctMfL2cZfaGufR9E4hlvp/fUUlP97TcCV4IkeWQeHsTGZoPjRyh3L1k29w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MJQgoHc2RXthhjd/g/4xWmqUBrv08pWo3t2q2k3m3E=;
 b=l+ownWXfg3xEvQQAWRlasGpc/klSXGsGuvQ3vfJod1aTvNqDbVyL0FlW1JAoqbBOWUDzKWXl9ASTNU/48rJQRhI0MGKOSUTKpytVjERtRdaLBIWQybRxm5qD9F8l0TJZglQwG/i2mZz5FCA0Kxox+XysmlDyLR8aH0LVQT+6nsYGkKCnWO9rt/ruPd/TMt6bl1iKtN7SDrOviFdcoaQS5ciwBAArXEcepqT/Yc+VAwU3Zu0Y0ylIvkeW3S1s/QbLfz+AuaQhWZ392b0hufFyD75uhRLSrvXL1bYjbylvdvxmq3CxXMIlysVrsglU9vVwB1r9oDZ5RhUPVwjt5OCrNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR0402MB3364.eurprd04.prod.outlook.com (2603:10a6:208:17::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 14:42:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 14:42:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 7/7] selftests/bpf: Add bpf_red test
Date: Mon,  6 Jun 2022 22:41:22 +0800
Message-ID: <6a85c083498b77aa387de4e21c683b2230f0317f.1654526068.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654526068.git.geliang.tang@suse.com>
References: <cover.1654526068.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0068.apcprd02.prod.outlook.com
 (2603:1096:4:54::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3210e297-553f-487a-3e8d-08da47cac420
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3364:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR0402MB33642DA8841D698B9BD44444F8A29@AM0PR0402MB3364.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6UzfcztExaMaoyMTFIVny/GS2ouaBh5URg381snrl4bbsc9K8Gb21iX9gOjI70kMBFA0/lxNKhuzqTSzn+YzTp/rU5N0n6IRq95Z6AwSBAnKHlRsco8aJr3PfgndLRxkzjr0M1hkMu5wPre6CQg+2bbjOne8GiUJ5l3m455E7kq901FrANzMQ78hvaSK1C5f5w0BMW2DmwWMKUNg2+Dl0L4oqtMwhv2XajmX3DutX2CVpFCZuVw6iw8ubFE23PbgW8qhIfeD1wWoGiX8TXEZZ+1CzCNWz0xpEDJPm0JrQp8c/Nr476wOvDI6cmQMdHGMCH8HVp/WCgYXrgbX5w58iDq+SwZ8T42drCfapJDuR1LULbVeFNG9HdjFpBwyultEzRTJJhp325ICxjOOJCPBLY4oDTMEV4dP7VjrFIi0ZSWmTe8jyOfeXyzIZTqJ6umVLzd31VZseOu8EoA5+c38MZy+sV5LJ83albLcgmfcFnBj5VtIQqd7PxhyQZfyEDLADVk1B2cfGh+AzJGdnc9iHfv4bhlSK77DdNzSceZ+pX3PSzRaruyiFVB4ZvVk9H15T/j+7KOuZ87d0q2XOIkNUbSD5sJoT+70cJv1FSmNjKBMFi+lBZ0Nbm7yIqrWE6WQ/TP92djmPgh8ePshsqezt/aoMiZyWlWADjknoodewbqAZmkjyng1c8pDZuwiQrlM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(36756003)(8936002)(66476007)(38100700002)(107886003)(26005)(316002)(66946007)(5660300002)(6512007)(4326008)(66556008)(8676002)(83380400001)(44832011)(6506007)(2616005)(508600001)(6486002)(186003)(86362001)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s+UWBmTOUCLy3U5vsbXfrH++jytPIYTRxtEnViMQikYOqZcFo8FfSvEBc/4b?=
 =?us-ascii?Q?B16cYTqMl9VANLhE5EGTxtK9ubh7US3nAv+0qwENQqD7HAK9qe02eUthjaXN?=
 =?us-ascii?Q?0nm1HALBYlA4Or5Z7tRx6FNj8GLEOzgB5LmB/kEN9+v6gZiGiEtfF5lm+VDE?=
 =?us-ascii?Q?IVVf4FEq0j5EmbJSex83Hvo6RbDX3FnRu32cohzcLiwXDXpo3k482jvwKpq8?=
 =?us-ascii?Q?r4Nm5dG+sDdavE30NMyI+Zn6e54V8tiIeZV2iPNsYkv63mLZBrtmv4SWuwJO?=
 =?us-ascii?Q?us7vVcyMbkNqTbeGMJfGZkchSb3GMEd4uc7hruv8b0l4QHtvaBVrLf9lCDsJ?=
 =?us-ascii?Q?eObUx3e/TpoSvkl+L3bbvTD+PR3a80lSmfCbHQ16vf8KRHrR/lfIjBoAOuxg?=
 =?us-ascii?Q?/z+gZ/gZ5QdqjqvRZxVwiSY/RJw/9OykXW1Trb38oj5DRvmF/xL/ThR3Shk+?=
 =?us-ascii?Q?iNBoRBasaVU/iH3+w+BtYcj/UPuJuYzJGf9xuLdDguuBEO9IWcjHubu/S1F1?=
 =?us-ascii?Q?koZyWOdnsvUCDT5qHB78b5c/HbR/PbI275I5VmS2vay9HFLNZUcAVVwdkS2/?=
 =?us-ascii?Q?r5DPc6q7Fy9IMpiOyCHV5QYeCYlC13lxCrH+42tGnAOuRq59waFjwrgs2yLU?=
 =?us-ascii?Q?ws7KBK5swkbzPxoyJjqI1oo2WoYY5HE/RpSG4SNK6BbhRbk8kQufCyVTFHZB?=
 =?us-ascii?Q?jPG+mrtDreO35Fhcs5QhkX+n8d0LrAcpXuut7gjft6x4fSBEUbvubVmEaeHu?=
 =?us-ascii?Q?QRH2GLh+pwKhH439tGFPVK/p/TLnTxwUV8VUcep7uLNyiLY7zUUl9C2w+2+a?=
 =?us-ascii?Q?KrErVf/i4ygTZf0/l73n00xFLQbpmm/eAL6W9TJ6o8feBV6WrW5OLxgTVlhk?=
 =?us-ascii?Q?Ly/gTaYeV1e3f/S3cpxu03uBtA3LV8gy9rSI4MFcOME4iTPWwxSqcZZZFX1f?=
 =?us-ascii?Q?7SdNXuUlVpEqbLBu44kGd/ueEffxfcILfAoj73LabQZllZkZ2KXg2yn3UFZ0?=
 =?us-ascii?Q?X+6ALZocLOaYqcxR7ZCSUwrYxcyLbWemPucBnvyepTs8tWqC6Zie4oij+fFZ?=
 =?us-ascii?Q?DVJHpVIpE0VGR8iizMuk8qnYfgGS5uGHve6srcDCLie+twfYDwqPXM5d1ZWk?=
 =?us-ascii?Q?2GKSfe17BcPGTxs/iij2csVPP19K6qry6NSvSOlG5pAuJxXqk86wf2ANEoRW?=
 =?us-ascii?Q?vLwPki024vjDjfe4jWhlSFpygAnWTQv4P+g21pjfZP1b0n4uUgNon9xRtyQB?=
 =?us-ascii?Q?6yujFeCNOiy1ohe6jjF2XwuV7f7fdQm82ArJOtC2nDF70+dFVLYsGbtpckXp?=
 =?us-ascii?Q?juZdq1DGYoA8F82kn5ERydTr3towG4m2NGbizmwcHk23I4bGpuy9fy/lix/2?=
 =?us-ascii?Q?S2ZmYKMtuENp8tewZLc+0YTu+rCnaPESjEB0KPTmIB7Ce3NhH+Loe8xhCO2G?=
 =?us-ascii?Q?bKIHoYY050d8zjYHv62cW+CGoKOiaSecT3awmu0n65R1AmfTHFC9S2iZbbLA?=
 =?us-ascii?Q?MY9g9vtXBEPeJ7T9n+JiM7QWnyS5rDMEfUadcNDdEInrV3bv3BlNPWR3ERLb?=
 =?us-ascii?Q?kdHe3d/sbiGdEAKLY3nJSVkHMcGIMHZF3lrwCbnkHuW1XKyf4+asEPpaTLR6?=
 =?us-ascii?Q?gsEZ4qPutSGb37cWvVjHzJYBF9Q8Qu+Xojz1WuNRxJH34Ep/qeJIUqi06XIr?=
 =?us-ascii?Q?wnnPk5S/7Hcx7g/q1vID5gBjM0SFA8au8Nb5tH2PiSt/Ed6zgZ0DAyCmCF9z?=
 =?us-ascii?Q?/jnbI88VyrOqz4fZ0bbbrKbX7AGBCkI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3210e297-553f-487a-3e8d-08da47cac420
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 14:42:22.8103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mpuw6tFwiuJsvRCBL1gLDYtIvkNzm1WoXedrr8h5JQ7wSUDKLV/z7dRfXut/z3s1ZFIs6BfPl3l9CXAXKWu1HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3364

This patch adds the redundant BPF MPTCP scheduler test: test_red(). Use
sysctl to set net.mptcp.scheduler to use this sched. Add two veth net
devices to simulate the multiple addresses case. Use 'ip mptcp endpoint'
command to add the new endpoint ADDR_2 to PM netlink. Send data and check
bytes_sent of 'ss' output after it to make sure the data has been
redundantly sent on both net devices.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 8b2fe1004323..9f3242c7920a 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -9,6 +9,7 @@
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
+#include "mptcp_bpf_red.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -381,6 +382,37 @@ static void test_rr(void)
 	mptcp_bpf_rr__destroy(rr_skel);
 }
=20
+static void test_red(void)
+{
+	struct mptcp_bpf_red *red_skel;
+	int server_fd, client_fd;
+	struct bpf_link *link;
+
+	red_skel =3D mptcp_bpf_red__open_and_load();
+	if (!ASSERT_OK_PTR(red_skel, "bpf_red__open_and_load"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(red_skel->maps.red);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_red__destroy(red_skel);
+		return;
+	}
+
+	sched_init("subflow", "bpf_red");
+	server_fd =3D start_mptcp_server(AF_INET, ADDR_1, 0, 0);
+	client_fd =3D connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
+	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
+
+	close(client_fd);
+	close(server_fd);
+	sched_cleanup();
+	bpf_link__destroy(link);
+	mptcp_bpf_red__destroy(red_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -391,4 +423,6 @@ void test_mptcp(void)
 		test_bkup();
 	if (test__start_subtest("rr"))
 		test_rr();
+	if (test__start_subtest("red"))
+		test_red();
 }
--=20
2.34.1

