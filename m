Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150044.outbound.protection.outlook.com [40.107.15.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADAC1FB1
	for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 14:55:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQRZn9huyr9tARKVpstQzDHbemH80XlvlSy3fp/MPc9x2YrcTCOEYRf52zwKpR/607+gUM/tFGwpquZ6i5eRpFyl8m/0MmkJV8e5Q1GJwPidPkNq94x/XL0Qo2FlCa3/6B2WOW4u1blbHTu+kYJCbk7hNQ6squLE92xAe/MiiIo1lryz8SkAqpHrr72pigGRCAAoPaJc4zZQEbxkM4MGlqmlkIlKfWavHCKbCi1RwXmmiImTpt+e/rv7pvcxF3kTvU4JxBHo0q+GAcI35zAru23FD0i/Wwz882g+tjWF+ZhVHWuQN4bgTk9mxs/4N+EG+df0vVKlCzU+grvw8aX8vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=mUTfe9Y2Ly9T7zcmmHVMBeX/MkraNAkunmZRz++M+ZC5l18xKySfHmaYVIwiTyF2FYl/A1BmwNMd5UQnTVanGawKUjVf58+tC/MQGgcOYxDmVOoGX4We/6igxp4nlsO+tpu86u24yc4MWfSMqNiR7D60SrRST0ffAIvPybXJz0w8FGTYvwNyNDqYYqiuM8Lt157udjqV8rxEf/lnFDxH/EWLQjCcVVFXyZto5YHCZShajc0dZ7XL/RQRJ406JzyL7rjNjZ8kwulqUK5Vtj0o19sZHMN5oYcEJET1lFdfFdFrkhv+6lHuEQZaYzfQHdSBSeGh8X9yWzGNdkKBsf3Phw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=imhagwWsqykBFniqIMON2x1rawaVNymjDSJ8qWc6zg5IJdKjcr5Gc0ks0z9dE4YcvBf0taBbG34GrVN1EjTSUo1T3+Sm6aictLHxhvF5nXOFWvBP2DLFUNB3QqRny0frst9wyLplLmOxobynTHYP+z8dFGoNJUOMkjZBMVrdu66LdCFR9sKAth56RFno2kJ88jE8SBWd8A03Cc2lZPjEQ1KseLpDf0ncDNaVxiheZifjK/GE+8AB8tewQhh6xvN3drsYG+gw2e95+fB283XnBONjmMgsVQMj/GXj3vYytOCT9yyJsW5/swjVdF4Mh3pHTN/H52PHnOgvByQHKdxmGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8299.eurprd04.prod.outlook.com (2603:10a6:10:241::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Thu, 23 Jun
 2022 14:55:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 14:55:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 6/6] selftests/bpf: Add bpf_red test
Date: Thu, 23 Jun 2022 22:54:22 +0800
Message-Id: <9eeeda9e63480ed2ac0b01399a70a5c3e92d9816.1655995770.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1655995770.git.geliang.tang@suse.com>
References: <cover.1655995770.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0134.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83d1791f-bca6-432e-90c1-08da55285950
X-MS-TrafficTypeDiagnostic: DB9PR04MB8299:EE_
X-Microsoft-Antispam-PRVS:
	<DB9PR04MB8299E1F908A7D37B809E52C1F8B59@DB9PR04MB8299.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fkGeP6kPiAAqd4HEp1mLVq1/d87jGb8M6ensjcildt2tJT+4gvlRX1rVN4aTqvN6CZRO2FLbCXSFRszqqav35ek22cqE0uAZpxJUOt1ldA0Ne8Yw/eS+D7yK9/bys4hxtHYBMDFEy/GrL1/O7OnSX47n9UbSq3vhDWZAPVdwxCv5hXYFAP3+9jpDqCR5OhJEImAUKrBo89SiIqsa/AUBDzNbwvctm5hcyNDGL0dY+oGgj4XZXWe/G+ZDYpKbjJpVgmS8m+6U6zaFdzPo/UFCsMXwTICoKx7MifAjwJ8yTcI0mxuCB2AoGNrNq3oI2PWawQl4nuiJWSXPojU+x8tK/12eGLIr0dHIoZAt6MVDyOAo+gppm9AroU+zZ6kEXJQghpvtELCmtCTS96TcWn7wrXQ8xA+rorjd3vPbNoQTi/utxxjOhc5CaZ3JyZ8TrFDSKvLb+KIgBkDdou6ilHwnnXS0/+RDQoWVRC/aSiw+S+jCUOaoNvLup8ssRviRw0jbbjsr0zoEpNmqF9zwD3bePJuzrMYIAs/T7kC5yx1KgbJX9UI30WLmCauWwJJwbOCn3VYvmulcng7cTfp1WLS5b4Yi5FjxH58qpcX+YBaHSJAzPJtYg/Rf1ZKtU7DPfVxXaTAGDRCue64xaEO1dTKiVW0vnvl45Wx9LuOj3lIJ+I9ANxW90uqvRM7XuwPRY8FJ4guE/fBdHGU4W7yggFT239txEyNtgYkFm+nngl9kgrfiMHgaNQwEzy5xzLigmWk2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(39860400002)(136003)(396003)(376002)(66946007)(66476007)(83380400001)(4326008)(8936002)(8676002)(5660300002)(316002)(66556008)(2906002)(6916009)(6486002)(478600001)(36756003)(44832011)(41300700001)(6666004)(86362001)(6512007)(26005)(186003)(2616005)(38100700002)(6506007)(107886003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZdrF/XpZ6ZUo12G/HEzKNZxzV4BbU55/5sdRQErbWommn7KP9EpE17pjnBWl?=
 =?us-ascii?Q?lx3lXMmyVGmtCi+F6TW9y5kNbEd2diKUYL8trtJeqaiiRdPKCIux0TavLJi6?=
 =?us-ascii?Q?GLdWrvu6dW5c/t0WDMANrDAK89lCYCfTP2Ggz3zMhiyA7m5YS3I9hFk9ubMW?=
 =?us-ascii?Q?e/EZNDprmJ2q9Al/+F1nSQrjWSYIZJM+hQ2pzeKCl8fwWR3OKHWDmCD699cf?=
 =?us-ascii?Q?7qWql1bbDRnA0GjQVesRbVqVhHK+jC3Xeo9FSLEnu6hdoeGdj7RtjJI5akj1?=
 =?us-ascii?Q?JLnSJGo78N5Pk0JOrmQNf2doxewML59ktXs5c3kahYqMamKAlfZ7h1QyUSfN?=
 =?us-ascii?Q?zd2+nF2J28eR3bElazGhIoooGoRHuLWiDOW2G69tALDy1Msj9c30zhqHfUl6?=
 =?us-ascii?Q?/WtZ0v7eycZtopJIZqMWAIAUD8uygGXBckgplyLEl3Myqh1QcWQB9/hLHi7g?=
 =?us-ascii?Q?ICIeJqxPtTfWEuBlT3A3GcTGaOi1Ua3PmouCpgbtNWH1DfLcCH5HZ2w3Ib1v?=
 =?us-ascii?Q?0DXY7Q4bAjs4stCaQPe12pzwdNAc8NySj+pzlSyfsi1u+dqfukNGm8zgUbVU?=
 =?us-ascii?Q?VeTIpi88bcizl5MiZbGpQ1Zhwj57ysxdYCzdxcSeIT2JiO3qIcdq+NZfbAaf?=
 =?us-ascii?Q?10eH8Kww97E9i35pupaZZ5qUiJnGtLabqIQuapJjFD85MH+14MPvAF4+uj6y?=
 =?us-ascii?Q?cEG4W4vWKmHInVu9X4h5eixquSnRsKDBEcPlVvy5rqbRy7WSQoBY0M4fzyjn?=
 =?us-ascii?Q?ynnxkcJwG/sJoLP9FzDE1i9EHHBO6fUj+iD+4ySH/387UC4Zb16Z7EiAkGb0?=
 =?us-ascii?Q?V52CUV4Joh0Xjj9uRC2SICsYAxrChbdJC718TzhFZaYB7SAS+QTVVYUKsOh4?=
 =?us-ascii?Q?k9uNrYW+waYElygkBO17kAsliQj1R2sJOEl9GFcQxkbCK3sm/+cvtY80ajbV?=
 =?us-ascii?Q?T83OuGQ87CbFRu9BVdPlW8z2ZJN7Q45Zrd70QYUoL2t9HT2K+T9jjoR3ckWW?=
 =?us-ascii?Q?/55FWKYiTw2CvJA6Pj7SzdMusqJxid/hrZlsa9sLRtfVACKmvJmHht/wEDpO?=
 =?us-ascii?Q?sxZ+Y2izaT95OBl1p0Q9m1mO/uUeF+Esw5RyGMrFC+vi9o0XvsBd21k30I9S?=
 =?us-ascii?Q?Cu1Hpyg1W8/VNhw1EkzdVdSY/Hzobw9a7+BpL/2B8n87rN1DiyurN6i26U4x?=
 =?us-ascii?Q?ErpTC6sVbZ1+bsguvS/usASJ2+Z5dIztPl9jZbEsiEOxiUhxnIcQHpIANhwB?=
 =?us-ascii?Q?+60o+BbiHs8WhIKry1iQR7zausAjnLGloL0qhagC+TbcLmrPtAgEXjYqHa9F?=
 =?us-ascii?Q?eFuZvpyBw9YJEGneDSpriY+hjdlrvKPwGVEJA9ercNeLK9lzdMtNsaITpptv?=
 =?us-ascii?Q?ustfGovW94p9uS+V3oVRu4DWvZ3NfXUZa1BLBfar+y/4vxJFptXNXgH3Ihoa?=
 =?us-ascii?Q?Cy4gHyUfM2XL6AOnvigr+KmyYIiYTIIb0le7Qapz2jQ7rSo4rv042Om7govs?=
 =?us-ascii?Q?BxaSaqNRngEn0qZrGcNVn4GP+CswgL2efj7E5y7F5/INgrj0x2nDknz6+Vw9?=
 =?us-ascii?Q?3Knzbj5walAVN+0RfEtyV3PGesj42KlIW+7mhDxz1D8mCWQqv/txfY6ZG0gw?=
 =?us-ascii?Q?l93SGPKNjt2dU4OrHT4NOuWQncZBXlLKln07MN6m2IerFff3mW2izlUH5DB0?=
 =?us-ascii?Q?VBZVUE9GnAVKPIqUmEDwbyfMz4POj4l7WqX0FNRr+zEMLwdTNwsbHDOtwprA?=
 =?us-ascii?Q?keHDxgX4rwbc/INmWdLBlyN+mwIFbVU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d1791f-bca6-432e-90c1-08da55285950
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 14:55:01.4351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PwVAMY/d+AB/h3H9fthkedXdJmjJE5nGU6SPguxDndtq7wo1fXB0xPDP+fnB9c/iIkIi81gAIiCM5ZeRbEW5Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8299

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

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
index 647d313475bc..8426a5aba721 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -9,6 +9,7 @@
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
+#include "mptcp_bpf_red.skel.h"
 
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -381,6 +382,37 @@ static void test_rr(void)
 	mptcp_bpf_rr__destroy(rr_skel);
 }
 
+static void test_red(void)
+{
+	struct mptcp_bpf_red *red_skel;
+	int server_fd, client_fd;
+	struct bpf_link *link;
+
+	red_skel = mptcp_bpf_red__open_and_load();
+	if (!ASSERT_OK_PTR(red_skel, "bpf_red__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(red_skel->maps.red);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_red__destroy(red_skel);
+		return;
+	}
+
+	sched_init("subflow", "bpf_red");
+	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
+	client_fd = connect_to_fd(server_fd, 0);
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
-- 
2.35.3

