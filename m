Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5029362
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 06:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654066029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FpG6ENw/8D3PwJ90m30Sg3WYwAOt5cFlzsOTeYTz8Ck=;
	b=hR8taHoDUijeIkYkTb/ZZmwnweV531+qgL80kUrO3snMqjUlTFePtFOaGps3L0yuNmchE6
	bynQRSCi2invwb11B1DGiU0VuSR50fjys+eZN4bcRzqQlvMzxXAH0GnAQjOoQINtqq7nQr
	cfHzP7R4IAmkpdOiDroj1atrQijUeCM=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-36-Gq-T7M9mN5OyZueXUKpUCw-1; Wed, 01 Jun 2022 08:47:08 +0200
X-MC-Unique: Gq-T7M9mN5OyZueXUKpUCw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T06FUc58ba6FytmwhpTLthRwdSlQIo235ySN4tjiqWVGeuff0TXCHWuTWUzUJtpvzz0FOdzM2LsCrmlcHWBjLFeZ91g0HBqqMq4Li+ajhcFdZrpzcwHunmjouSoDjBy2bbSauMEZd9Tg/xJU0FCWTUooQC+MbG9TdJKQKmPeDpLushs2VCZjKcOA1peVHU4FFtp3VhfSNThN1iR35htJhSw+siHaynmwMuF3qDgJ1ne0BZXcnM1lsJphkOluEbuRPmsuhLRoBiYSku711FhOUzVe2G/kB2h5kYz7gTyF1K+96QeTWrzLx1zqRO1GtTU1AAOR++yR3w+OAssokwY6lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GcfFui1g5oBNt3wRa0fwp161zlANUD9TuVQAshuDjk=;
 b=GtdEqvy+c6Qt4FLwTxr1MSDKrPVSB87LG+ZXqBdSMtwufo0dK9nLFoTQ/Vh5NPYIBTTXXtb/5dqXJihf9adhIkuohQgRwPNUQW+n0bV3vSJdo1EmUAm2Qs4ZUMh0BqLrnL+LfmMF0uwtaTuoAEYnjiOLscXfHf87Glf4+7Lp5llU2lCUTJ4GywRyVU+5IyaB6pX2gZkgPINCdH4Zlo1/4FGZsDnYJdt8MsAhmXEJowIp3cnSWIR0tNMGQ7GCujreYH4ehALq7aBfEJlTyRrzTpYOaFv99HrLSXr3xKU5LvWl3ZmwyTCi8wJ0vco561Pcqvc9ZMvEUwfTEDIwaiqtBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6904.eurprd04.prod.outlook.com (2603:10a6:20b:106::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 1 Jun
 2022 06:47:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Wed, 1 Jun 2022
 06:47:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 09/11] selftests/bpf: add bpf_bkup test
Date: Wed,  1 Jun 2022 14:45:58 +0800
Message-ID: <43ea815b853c218ce7dfa629a92b70ca3828e37c.1654065674.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654065674.git.geliang.tang@suse.com>
References: <cover.1654065674.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0051.apcprd03.prod.outlook.com
 (2603:1096:202:17::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3feb09ae-212a-46ef-9b28-08da439a8b98
X-MS-TrafficTypeDiagnostic: AM7PR04MB6904:EE_
X-Microsoft-Antispam-PRVS:
	<AM7PR04MB690421EF6AA41AA54D717503F8DF9@AM7PR04MB6904.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oGPaJTPLEa4eIGdSpZ0DKtru9t/j85JoEYGcnKFUlgvmpAHO+KETGzIijirVLYcC0kU5niXRcmCZ/6ywSuNu/cu6HbHM6GJcTdAar2OpL4q7UxwyxjXQCAgyRqQtuoDCZ7ARGaAznvc1HxZA/7KBcaD/VJj5bcjJeFi5wgmK1yzW84wEKdgqY4ewvCjsMwuvUOIvLJ11uQ4Jw1bC2dM+gGDVzKXObdhALT4yAJW0t1NJ19iVjJCZajNJCx2ERjpBY3qg6XDBw/D9ldEStQ467uKA/wZVmNYFbtSG/5HMm4xBuaMyOJ9qJzt/JOm1wuFbLiEA09ADne6D0M8w/KRnPkaCDLCYh3Xr+OhksTCsh0YSijGWbiRBFCN6Or56BN6cluYkXy9B+O+Yx+4Tkfg4u6cq9IH0sIFMgTjzpuKFz6yOlDmfLAevkxA4MqpfsmL6RIlG54ytTdGw90WOKKbebPc3ZcnG3fExfE+ZbXjqoDjqeQfksc/dvPvjgNynRE/8r6GLEU4s4pcKd+r7NcnAHWlfIhRI6wOzRBzSXS7o5hPs/pkJtwA1SXFIrH4K/fIPLlAcSJuiKc+IMkQML2a5Kp19gsJkqoQ4J8QxWDZQJdoq60/hPzeBs7szy1GgK46cuVjzZpcHeDJNBCm0oQLb8rVxY++/St0ElHj2CpSbz2wmLPhlcJ7JJ56fkASm6bwJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(107886003)(86362001)(6666004)(8936002)(186003)(38100700002)(508600001)(5660300002)(44832011)(6486002)(2616005)(6506007)(6512007)(26005)(66946007)(66556008)(66476007)(4326008)(8676002)(36756003)(316002)(6916009)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TtL2B6gNPimtwHWEJ3okglmAJByN+tqQ2fe0nr5kg2XMbE2XfZBa6Y3AEgvL?=
 =?us-ascii?Q?mXrvD5P/trfDVleZALGq8GiOo6Fj2ji3EDBYYmd6Iez9/H+n387881FgW0VL?=
 =?us-ascii?Q?LyEv9ZU6KFgY19ASVESrvVJm9t9Bl2iC+B+1oYTGyQTLR6Q0y/DIac7P28/2?=
 =?us-ascii?Q?XL0EmPG9ftlCrRz5/RQ7XCmNr/Oz1UDgOolQg8yhYx4A/sweWZCkalFHbgRg?=
 =?us-ascii?Q?K0dHXCO5CwGSNm4qWhExKo8jgrHYRHh8BFU0/06WdcgCNTf37G688BKgOb4L?=
 =?us-ascii?Q?2zaLyZZ95zRTQnm/mEcA6Aa29i9AmI1KHhllhz0oVUJCyyoWPAUlKvskCsVM?=
 =?us-ascii?Q?U/+/hlgVHyQsHGSiHYiwBnxU84VdnwV7yUwbM7j8ZxffIKWjVAYQfBCT5QPK?=
 =?us-ascii?Q?qQMxwhznkJzcmrDJJtpcGYMKNsZp1OzGHZMbG4a227F7ai3YjM3YmNUtf0/E?=
 =?us-ascii?Q?UbyQj6Oagp2+cDhaSKtvJXy6oey4AettjqXzjDh77QFDk+n+MAfw+zZgYLMl?=
 =?us-ascii?Q?7FvKpHy7OzjcPy9fp+8GIIweSKrUfHQLF+yaOSnADyrfn7uoUPYOXeEv//EH?=
 =?us-ascii?Q?Pf8nxrRaZc0iGcIUWDFd6nkjpL6nbGnMr5OIABtzt9ztxqCHShpXaNHPXQBY?=
 =?us-ascii?Q?4b9ORTetDaXDH8sGMEwhy1ilUzqsYmZ1qfqZ4mAPc3l2OQ3DMkXHvvdOni2l?=
 =?us-ascii?Q?PskH/QGhieom+fMbeiJ/141irzgK7YFSrVriPlBMzBXxb3ToiJ9aLbbRPavl?=
 =?us-ascii?Q?ECPKsi+vA0h3hTACnW8OpOOEMTWMOOpfcaQfK6sy2pVMHocJML1ep+MbcZe1?=
 =?us-ascii?Q?W11xaQkIgK28SbQ2utgIjXaKkdDbS9DlS4TfSm4TfCLlgYXmYklBsw5Do8dN?=
 =?us-ascii?Q?Mhm2vvJ+HVvpkBjoQJ9gvgJ4hS6mya6PjY6X+kKIw+FsmR7uE2bhAA4gpkEL?=
 =?us-ascii?Q?NAFmoK0hJFTtr7yjkzb8Fa02vHPkXP08Hs5eBWu0Hzpm8u8+7K1LMU0Wnfre?=
 =?us-ascii?Q?QanX3YVsEIwag3H+ThxJbPWcFrDDYfwg6GhLy6V3dadJXfa494as/VT9olrf?=
 =?us-ascii?Q?4yM8rjB7VIPtjk71etv1Xj8lLCZP9VUsYl22JXhViSIQDPHoLj1B0ii/2Vy0?=
 =?us-ascii?Q?YvqBMyJkXI+NroK8sqBU0mSrf0Y/Qn8gbx+LFvzZcAyDIvNXL3cGvOsfqGsp?=
 =?us-ascii?Q?dxFZKZXYnEKpI4Z1F2eptBCAB8oFGUX4u7aVj8fzc8H8xxvAKiE6ALyDxxIW?=
 =?us-ascii?Q?Q2L1dxnT0IXuFoCqDHSVbWoCvokq08YTxlDxsn/Wsrh1KRXQVNi7bfrbx+RY?=
 =?us-ascii?Q?f4av6cjIJxOVYHjyto6UuRvxeya7WlXZ435MWKJ7Pfq4B7sv6uMDp70TCpRd?=
 =?us-ascii?Q?KAOa09qBGgFBdJc7kI+XNqN7lvy1MzDzfjdlk+CE1XA4IOjKNZFKnQ4+Eayc?=
 =?us-ascii?Q?UB5zAhLiBmaC9Elw+qVThIhJ5xcM6ZzXIkQrF72Ha3paUra6Guhy0mJXe6pH?=
 =?us-ascii?Q?6KnOf4GVXrMfUWUiuF5Qhub5hKI3xsNgO/obdU42UVqCsPvyzem4u4zKo8Sy?=
 =?us-ascii?Q?5wM62ODTu2dvS7YF9c/4ikteo8EtZUVPYdbTzhXHt6JpCR2PcEQTeNdXF6CK?=
 =?us-ascii?Q?C/q7iODyoxatkeG4rVRf/JBiAhL5obqgbN6vxs8u7ByP1PBaFoAn667yhyTt?=
 =?us-ascii?Q?0qdQgVhb3djsF1OZ1DqTWucBh7ZjxYDBemg0WGya2/yqivWdpcbcYzBGxp8u?=
 =?us-ascii?Q?gqqAZIpnadHwq+WTjUOUaxOanLZc69I=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3feb09ae-212a-46ef-9b28-08da439a8b98
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 06:47:07.5373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvnyZcRXpHndXRzF824tV5sx2ivS1tRQSIMV3hJXMR5aTybIYLcstzDZauCKloHZU3hiSJe9EFFz2MW9lZLoCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6904

This patch adds the backup BPF MPTCP scheduler test. Use sysctl to
set net.mptcp.scheduler to use this sched. Add a veth net device to
simulate the multiple addresses case. Use 'ip mptcp endpoint' command
to add this new endpoint to PM netlink with backup flag. Send data,
check bytes_sent of 'ss' output, and do some cleanups.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index eaea4105728d..f3c73cd2c786 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -7,6 +7,7 @@
 #include "network_helpers.h"
 #include "mptcp_sock.skel.h"
 #include "mptcp_bpf_first.skel.h"
+#include "mptcp_bpf_bkup.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -296,10 +297,44 @@ static void test_first(void)
 	mptcp_bpf_first__destroy(first_skel);
 }
=20
+static void test_bkup(void)
+{
+	struct mptcp_bpf_bkup *bkup_skel;
+	int server_fd, client_fd;
+	struct bpf_link *link;
+
+	bkup_skel =3D mptcp_bpf_bkup__open_and_load();
+	if (!ASSERT_OK_PTR(bkup_skel, "bpf_bkup__open_and_load"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(bkup_skel->maps.bkup);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_bkup__destroy(bkup_skel);
+		return;
+	}
+
+	add_veth();
+	system("ip mptcp endpoint add 10.0.1.1 subflow backup");
+	system("sysctl -qw net.mptcp.scheduler=3Dbpf_bkup");
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	client_fd =3D connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+	ASSERT_GT(system("ss -MOenita | grep '10.0.1.1' | grep 'bytes_sent:'"), 0=
, "ss");
+
+	close(client_fd);
+	close(server_fd);
+	cleanup();
+	bpf_link__destroy(link);
+	mptcp_bpf_bkup__destroy(bkup_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
 		test_base();
 	if (test__start_subtest("first"))
 		test_first();
+	if (test__start_subtest("bkup"))
+		test_bkup();
 }
--=20
2.34.1

