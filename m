Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C6D28E4
	for <mptcp@lists.linux.dev>; Sat, 28 May 2022 15:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653750792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A8o1dmjAPuzjWnTF94tHAl4G2hRnUZc4lxxspXLgyzs=;
	b=MxhpkMT8nlyZaekr3jYSme9yfLxZfYAffDfSrEegoGY3iG1+drI4lFa8xynMmi0NEwIUeo
	BH0wW/dNlifoe6eo1vy5kO4sp2AT70QoenvCHefu9WFRvQilPMhZ2RIjYpuR4clYloqr4H
	24AdbOuWmorBdoXp01DjED9c3tH8rBs=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2177.outbound.protection.outlook.com [104.47.17.177]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-kTPpg5h0Ny-zBFjP426WbQ-1; Sat, 28 May 2022 17:13:11 +0200
X-MC-Unique: kTPpg5h0Ny-zBFjP426WbQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eA3gQRQJCG7aJPGneMhSwHKGDL0qSsZROsXD5GKgIKT19mw7aqrgJAIGrwo1+191nxbyxODfx1zjuRMX7d6yHiL9sI5XLABQkEpopaMXEnXZLRkuNwP10Z3UV+naGOVheAWkwtyqAbBvTUbBZfzTsNRM1lO7iuJc51hgSvUlfVVJ7A6Ba864xzzvUM/EapJjVV/EFAdNJqym/zzX7Z4QbJRzAj0tbDWA/IVXJydh2ybaxLbtl/K61dIYZSIg4RX2tR1HGsInhvbOVrm61n/2RTkQx6HJFwRFAXVMOn1oWq6uWlXuBPMx2ocpYDJUzxilHyxbFXesVBXTmchqyT4JDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fc+zRpA46RihtQSmRZ7Id94cSOuDDSYibsw/Zd/+lsQ=;
 b=neNOlWn6XnIkyPlGHRoIFIjgv/hdpbgOBhD6BsYWfMONiE6sM/QJNeTZQONw+wDFYLkAa2lgT6OuDBt71/kvXnmOf0J5+zqqjKP5x37/sdauZ6krXcRk+kqCYodPFSd4iCAF+SeBkjiYntMt543IQgimOnEJ7/BljmXaj8uOITzLYBx5m1A5nNpPQSsfj+NemNxOKTVmQuDyzhem4ZRCel5JDVmFXlwXA7s2/2VMV5cAoOr5c9HhKi/NuPvEHZSnQzl0JSUhvNdTy65FguavWM2Xx13Y4OkXV2pqAB5pa8CuQVzyagApWrwTUjldJK1hqbThWKIUybY+G8pewlLiqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8485.eurprd04.prod.outlook.com (2603:10a6:20b:418::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Sat, 28 May
 2022 15:13:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5293.017; Sat, 28 May 2022
 15:13:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 10/10] selftests/bpf: add bpf_rr test
Date: Sat, 28 May 2022 23:11:52 +0800
Message-ID: <1e2b27869e72af5e2928450ff6216f0d78d609da.1653750351.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653750351.git.geliang.tang@suse.com>
References: <cover.1653750351.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0152.apcprd02.prod.outlook.com
 (2603:1096:201:1f::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8f76a2b-953f-401c-1fd9-08da40bc936e
X-MS-TrafficTypeDiagnostic: AM9PR04MB8485:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB848560A32EB0AD4F6EEF693CF8DB9@AM9PR04MB8485.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PiASCgBRRNLekr2G4GGyEK6RNgRrggDkyLwwbnj0YXqyJVvJx7VnMQGPq3bSZDnZ0tK+9sgQh4dR1Dyt+pLfN2z8Z28Xe2CLNJ6Ee5gAyVAYbOvHxhGPy+1i/R9ah/eaJeZ4HvuNYJzNP7StovW/XJnQDSJXmEC64Bq0Ifu6EkMl4tCdqJb+yBwc7+R7hJQ+/qbmAbwSxEgg4dNjOvkFE9F7ZhpXgUyB8nwHyaZE9rpF1+yPO0yUX7iLgFmSj9AUBbxZ7cGa7AyOmO8t8u+c1R/CmtP944Txj/L1RZwHlnmeYvWVk8ikNXxpNXGo/fQI2PydGtnBJQhXMVdu0+0qaddC/M7V8C/ZV8rPHYfrdDInhHLDzrB7G5/mIAz7L9U/EYEm3PJgtDnG1MISSKd9pkrYd8Nve1ZIYaDewalq3XLYilg7sSFYJLuMa8agDS49B8OOTnWIiY/KCNkxoGKEUvyp27r3XASQ5hs+Hi3BIRuf6ANtv6MF3hxmsLltuB30qacoSDg4X/BWEUJecfG7hpplRV27ufZFtMd1Jznc+S8cH0vJw88zM09cN7TQI8QslLcslQSg81DdOhL5BEIWRpSO9O8BWWGhn9JZIyPy4XXhqXMRtNFsQO1T3JFHjD1gs75oDR2RdmklXDuygFMPk//+IR133i8RtEIJMEKrKNxZq75Nw2EU9Yx7S/3Up+1W
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(83380400001)(66476007)(38100700002)(4326008)(66556008)(8676002)(86362001)(186003)(107886003)(2616005)(66946007)(6486002)(5660300002)(2906002)(6916009)(44832011)(6512007)(316002)(8936002)(6506007)(6666004)(26005)(508600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?St8jxSubEgAZA1vLXXJ40niAkXlLdfFm2fpg4uVsBAfZDK8bwNM6071nXzw3?=
 =?us-ascii?Q?ABhcEQGacFXBA3BX/8EcXtogrmngD9XHf4uqLtWo89a6HOyoUwBAZwa0oYVL?=
 =?us-ascii?Q?Dya8YsT3U4c84vs8ziwsX4jRtr1n7G/F0qTcANwmjxdDEyyQv2O6yx1hXFCk?=
 =?us-ascii?Q?+f+JPU2ZI84WcZ8SWTEtjZqljeZaYTLMZkkpOfPFvu6mReBO71qbBgye1X51?=
 =?us-ascii?Q?O9HYtdrzHH5NaFb1EMWmJ71iRsttXiHEotKSJ2+FavnFH0dKjUOF+/jGBKq/?=
 =?us-ascii?Q?SlhmTXkaLNEG/qvK8rH/kQ7Kyf2iCXzluHU9upkr2aveyb56RYn5GpohWG8a?=
 =?us-ascii?Q?qIDZzhjq78q0opFMQnNPOAeUebMoKC2gwFe2t2XeFkS/Y0E2HbGwX3/fkxBc?=
 =?us-ascii?Q?70qY/6kQ4vMjaqJZ2eVf8DgN8BbSRNnRS79J9WzRu+F4h/GnCgAyosLYwKPo?=
 =?us-ascii?Q?KAvwDn38XgVYwhUyCarem6BVkbORuwNsdrEAbuF9+M8dPcGFkgECeCnaTYt7?=
 =?us-ascii?Q?aWBxqBxYx7VL/aFjq7mbENZWHtAtDIODtgIvXgapA9nDCPy/5cD9EBsmJE7M?=
 =?us-ascii?Q?X3rQ+fqSN0QYTxl4VbqHkZIyus5tlaL9mgaI4FH38LTt23t1dXurjpkrQHRI?=
 =?us-ascii?Q?oW5G0FwrfGeDOBO//YbZjwcUEcCAoKVLF21QpVCTA58NdcdJPOaAAy32tChS?=
 =?us-ascii?Q?B2AVrnUrD46NAB4yvD0ySt3I7mM3UvxbSpxd54TDdxIH/gd0NwqB7cc3AJvk?=
 =?us-ascii?Q?CZiLnf5wCJk+CxFl4upeWl5GKcfSGf8XW/rLUAifRdTZfPxXrvUadVNWmv4Y?=
 =?us-ascii?Q?sHXhhQGrbbq7aD3qbvXrxSx0wyL3ztwWQEhRSEPP3UTKgSvspWIvArSp0b/c?=
 =?us-ascii?Q?HnGO/I+1VokEI+xaXBsodReYsttD8jW9nZRFT3Kf/Tamp4RwIg7F9lmkQq48?=
 =?us-ascii?Q?WsUzmClO2DjCvUuEzySLxlR/mDQrdUzzLvkzzKVTZMNTo86N72WZm7Kf+Kmt?=
 =?us-ascii?Q?UHs9nOKE4moRjj4TT8VcBlnV+W8iyD4h7Qrm7EYP1gPhQD+SMXmUrxf+CMwO?=
 =?us-ascii?Q?vQR7TDxpChJSjraG45KC3oOoufFeGYuDD1yF9LvIg3qZUTj1nDRGq7Kixy60?=
 =?us-ascii?Q?/Sn/WzjLfm4N+/2l05fvO/aSw7EcpBZPX3dumrdK0MDksfTkqvAQkaegQ5ka?=
 =?us-ascii?Q?Kq7zvYD92b1lwmX+zG4M70CK8Dh+6grHb+1e8DEXtywYc+gQBxDcWrJTllKc?=
 =?us-ascii?Q?hUlUNm7AaTAD2Cjk5JFLK1V6sjJzMhYf3ZjaQHf4GkH67U4/+yD2yd9/7eVK?=
 =?us-ascii?Q?KYtN4OSt9BOj28PDrJCwuOhnNjmi/ha0CG1CVBKRaUjp6fx2NwMo+5xtGdtR?=
 =?us-ascii?Q?iNH8MQ57bHL2F9K6ccuquFhZYQec/cGs3gzFszL8x1Hhi+iOWkdW7qPoYRyK?=
 =?us-ascii?Q?wvpnADL2trofzThlCzw9huZN52UKdzhftks0IvIGGrSCZvRlr68gk+Up3zsh?=
 =?us-ascii?Q?AiJWG3xXlissZD07gqwXUS87wyngfgMFE1kk7EOlvG0qDZDGQK+KIkqgPir9?=
 =?us-ascii?Q?LytkS+Usl+Ib0735ezbD7fvbhLirEYXdEAF2yj6JLBPmIR7K2zAOJzM/vUqL?=
 =?us-ascii?Q?C7L4X1nOhDFold+fjEUOlwjnyLZpSjspdFKfO6zCgr8r9+sm4kQ3+vFHu23F?=
 =?us-ascii?Q?loPlaBQUsQUcTKKZsuDiowsQhUG1nCsxw9BhSpmYgO+Tsr0DHoKP5ahOJBtR?=
 =?us-ascii?Q?MXczU3jWufzjetDfLGI6aEqdpy84nls=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f76a2b-953f-401c-1fd9-08da40bc936e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2022 15:13:10.0499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DFBC22aKdvfVafnOB68yzU8rmRNd7CLRWxFHOIGB5mO8svlD8JaFHEoSISJl+Y5Su9mUveAVfkeBtzy1da3v6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8485

This patch adds the round-robin BPF MPTCP scheduler test. Use sysctl to
set net.mptcp.scheduler to use this sched. Add a veth net device to
simulate the multiple addresses case. Use 'ip mptcp endpoint' command to
add this new endpoint to PM netlink.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 1f92d251a9ba..17536ea8dbab 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -8,6 +8,7 @@
 #include "mptcp_sock.skel.h"
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_backup.skel.h"
+#include "mptcp_bpf_rr.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -329,6 +330,38 @@ static void test_backup(void)
 	mptcp_bpf_backup__destroy(backup_skel);
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
+	add_veth();
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
+	cleanup();
+	bpf_link__destroy(link);
+	mptcp_bpf_rr__destroy(rr_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -337,4 +370,6 @@ void test_mptcp(void)
 		test_first();
 	if (test__start_subtest("backup"))
 		test_backup();
+	if (test__start_subtest("rr"))
+		test_rr();
 }
--=20
2.34.1

