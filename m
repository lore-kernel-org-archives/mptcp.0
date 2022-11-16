Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140082.outbound.protection.outlook.com [40.107.14.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F16B7C
	for <mptcp@lists.linux.dev>; Wed, 16 Nov 2022 11:43:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQ9oi3ArAmfC30MRNOMrMdSY85UY3Qzm4UeKm/obPyyZCyHbxVqmpg2/kznup6BuWqwFhnmJxYtXADyM209d17nifY4SXdKYZ8XSttbJ78NaN1jvr9sb7tfpEGld0laOLwUJYWg+DKwyIs1DlzhhY1HszqHa7O6ZPj9y6DkUUJdPylaVq18PDPN4gl0ewEaumpBtE+7p5sviR8dEDmGIKDiCq+d0yUgANB2wF7m8RI0O9Svl9ld+3MCGNa/Qf0PaKRa+HRF6Lk8R2ndAXP3Zu+6mXp6/hLdimM+snpEPqrs1VNHW/MlEqNIQfc7VG0CXPZfmiccTH23jN5V1O7bdjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=d/HZi3/E2sbI/8mBw45YTrJ0YxHllUqiMI+8pK7kqq/C3zL3C6S2TFDtkfATPdUj87jAsCbIKVqpUWrOU2Qz9KO0vQC/BNouH7FN3lm8kcfTv5NE6MA4OgZSmPuXa+K1mVNXs9YkICYPvYcmV4y9TpiL1aJMzcaBczeGFfvX/e8acfMZAsbjbQJynGHF2F8TbjyUd0DYKy6i6OBXBEjYfmDlIx527xP5rhJPweMDWg2MyfajZwestYJ21lnWzQRP9G3xRG08MCuzQYIOBNiegLLeJlyk9iE46N31N6VeuwhHqtr/UgPHRhdXux5uKJz31t8GWp8YYa16TQ4EY/8nVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5VgHOKGiA2QU4SHX+fkno94QBSUGbqMBV+Qv9K8cJ4=;
 b=hMcn+tkKHwG6rdNc6dZekYvxQPHC6KLjLYzvU8nO8xyipvOfGnunUupBrkCA4Kt2ry5eVEKDQ5lMVclYUlbsqf4KV3INX6XHRtDPOyVZ2gHjPBduGNa8NmVP50UbmF9HjtLsoBj2ScayTq7feyRqy2w4GbifsoeidDvaekO6VHGT4HUmQk/6WkVwXBufVIoFwMmH+1xXQhQr5153c0lAvj+7JZX5XgLP2QlXNbzNysRRrQaNS2UQRuJ8Omo+n7b9i+ZVjxLvbQ1Fy810cZmjK+MD1+8oL6irUb0+uEyRNKy4Vis3SwvV6Z/sErhcWiHkgIwskbzOs3R3h45FIOersg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB7153.eurprd04.prod.outlook.com (2603:10a6:208:1a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Wed, 16 Nov
 2022 11:43:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 11:43:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v20 7/7] selftests/bpf: Add bpf_red test
Date: Wed, 16 Nov 2022 19:43:08 +0800
Message-Id: <ff0f987c626e19b942add332cca82b42d578fe77.1668598782.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668598782.git.geliang.tang@suse.com>
References: <cover.1668598782.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: 597cfa76-591a-45a8-c09f-08dac7c7d36b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hiFfVNjIe0Geu9zreTUSeGz7SCBCcq10HAY9fBdbGcgTEDcpPdeHLekDxPnuTBmfMMLTizMZR6kjUlm2LsAWFkdG/Ew84fQty6XBWhtRuwHzfo0hkpoWSGnhuwHR3kFKtgiK+6H5Aw3LvpQKYlTuRi+vtpQH5bAPoOAqxc7WW2ExWVvdbxUyBtQ0/TUGUJRTRbNqTfZxzaqxJ3dHl7PZU43JOyf8Jj1u/Ev4in12dfVqzsAyP01apbt1L8FyAyW5HCyH4QE5C/W841UyM9uqc5ztoMvwEVzrZ6GhKrwDGRDqAqDLmOrVE0neQXTmaOataMQapC0ywInt5vb6scoOEh1tp/9Ks8ZHqr5YH+4ulpH5sIg21fFUzQw8c0kkNwz/DBWVGiJ/+jWC0G5WRRKaafVB5koc/TZWgvXRA/dhzx5q60/9o6NumrSwLBRBYSQdhrLrcRzuZ7k9b+pO4FtP342KEgciWggXY3/yWqcGpgcc1AUV9yPtkQmRujfTW4ERC5vfwP3FIhQ+eM5nkAYOIdFLnvUUnzMQbaY3b8xqTW+bqxwpLo4GiHnvcCbJaFsTwvv2RUrOEjkkJGtZrb4MpJMzLuSEhrqCxTLaNE1QCZOgz3H7ViulL8vCU5t9IROPS6lLHV3zg+mTcnleJat8dg2zUImDi212awyXygQaX41d+WZvk5aZFDb5dtOq5g7c9M15XGdEbrbO9HDuBQc8aA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199015)(86362001)(83380400001)(38100700002)(478600001)(6486002)(6506007)(66556008)(107886003)(6666004)(8676002)(41300700001)(66946007)(4326008)(5660300002)(66476007)(316002)(6916009)(2616005)(186003)(6512007)(26005)(44832011)(8936002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E3gawhFs64B6F9GhSTFOwKxZpIrk9GVL4jKrL6G4dr4cMWtgnL0YeryNraaW?=
 =?us-ascii?Q?5P6bxUL0T/Vg83y6bWc4dtrp67DEgL73iY0X+DEIofkOHg+dSnX6plvgkQpd?=
 =?us-ascii?Q?N/WrTijjcMvmhSs8eSCpi+0DhetYACWQ3EWHAzYSdXmw8IIPvobTaJ6oVoxX?=
 =?us-ascii?Q?MKMcIaC9uWB2qhijUOTpGhnY8ZFecUT1oblQhGgKM+sPU+USAflZ9WMFPiIJ?=
 =?us-ascii?Q?iwD8WPezp/f787YCnaETKpAtMoDlkXUQpLeGRtE0IdJZNa2c+a4D8jIr6gEt?=
 =?us-ascii?Q?zS8UF0uu0TOhDcwCvCV0MHkvgGBtXy0xC1YQ3A1ubYPBYI9iOOaXkxNg8u7u?=
 =?us-ascii?Q?xyvBk6LXBdi/wbD2xp0uhYYaxRluqE7Z8qmWwWkkVKJEQskWFrn6w2OinaRB?=
 =?us-ascii?Q?U4mlCQlBIWmC+hn1uolvVc24ICvxaOFVtV+wghngZhCJiUV5MT66LY0p8znA?=
 =?us-ascii?Q?5YLf1Vb//cvdp2vazC3bHAnXnFbBHKJwFjhqWsj+ADomN7YWruzzHhghj+Lm?=
 =?us-ascii?Q?2n3V0FWSNW9XjrZBmgT+7LHDy061yJWRAnQqMjA1Ox4/YEBnwOdzl27PwNME?=
 =?us-ascii?Q?m468Z1Ozl3PrtJ8ywM64SIbg/3JNv/Pwac+FB1y2vGmjtMv6K4EYWmffDgfC?=
 =?us-ascii?Q?Sn9eyfXhMhxBkhJMih1YH320v82cw+ld/DfE9KcVasHsJjqbBJ3Le/3x8+XK?=
 =?us-ascii?Q?1iSmCohe96E++dfIjSku0H9IfudHsTQ4esT9tfaHNGhnjn2jUmWGpdhOJY42?=
 =?us-ascii?Q?x1tpD0B7meoZXcxDa6VlMGzu0CHt2efXoFJiUVxZBybvk9PjNdWbCm+gngfk?=
 =?us-ascii?Q?1SX/jd14BcW9pujGM2FMeP6bF6Xyxh7/KVUgcfNKl4xzZfeohS/IunmdsRxl?=
 =?us-ascii?Q?8NiU/toHKjdv+/Us0JQJvbbSgeTlXWT+Mk9dJloSmMBQNTRpBoTkxWxGj1Yp?=
 =?us-ascii?Q?w9n8c0TXFo6X7QLFEeC5nLUQZYsXmFRqB18LSxqNfTRdcupX0SL4E6IPDiSL?=
 =?us-ascii?Q?fV5TezTi1BR3UJZaLLEv3rVIj0GYLbEr8qRwnmaLRLfU3iBNKFbmPShv+7kc?=
 =?us-ascii?Q?PEg7DOuFwZORemDSW1Z+RL0VvkmuSiOjNewg/d6wkzSiPquO9SUQod+wRbO4?=
 =?us-ascii?Q?12bHhCM6srV7w+RNtvFXor9NijFFATKzfBhSWXVbRY0gxPsCjr6HDltKUWmG?=
 =?us-ascii?Q?IPlwA3cOu4CnfR4GMipvea+KC86679s5wrTro1ZGLZYeZZDFjNY8DyMcDgKj?=
 =?us-ascii?Q?Xceco2JB347jnNp4fI4HSoivpkgivyvhzZX5kUr0N/JpO5mR2JfjEqrqKt1Q?=
 =?us-ascii?Q?gJjw8TeIPkMfIpdeHaB6QDUsdGv98nM6ZWSQK865tdFPHH3V8NAIPT9m91Hx?=
 =?us-ascii?Q?6dtzwRfsiH4hZUL/J3N1abO3oBVjdPH0zRnJ7loaYMa9mHvdQSr5+7cfhJMu?=
 =?us-ascii?Q?XSVA57TC1ZyUDt5lN+PSdQsghL3geG6C4JVd3xb67YUoRrhcHQrhT8oMedI4?=
 =?us-ascii?Q?qJwJFypzHVwhn2o2n81I7R/07utAPp8VMyuB2OIzo7WFWlGB3sZcn0DldNur?=
 =?us-ascii?Q?oPxBjpx/36cZqVBj/UYWrd3mrqZ0FNIRC4Ynrd8OLGnu69w9Crv6//15R749?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 597cfa76-591a-45a8-c09f-08dac7c7d36b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 11:43:48.7226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMVUgqdLrBYFrxaduDMrdLIvwr/4XOb9LKpN/DZfijYLH2MjpvS2mfOWHep0/dfSm5vA9EVdCcqqXkOoakT8FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7153

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

