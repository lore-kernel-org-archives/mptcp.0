Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B64623AE
	for <mptcp@lists.linux.dev>; Wed, 13 Apr 2022 14:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649860260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8wez0+3CPjJOxxz7GBxzDLeS9+2Vn6taghNySVWF3do=;
	b=dKZHPXdv+d2jqrRZ9zrEvE5WVO7eiNDSoKEpQh0uWl+W4wbpEEerP5rZ/cF/V3laP8V5RR
	eV5DFx1PqwnnyjJ9TljSZrQH1K7GL9wQiTJlGEGT/DAph0qZUIzQhmQJkeW0yuL3BSpMv8
	v8IbJEjVGRVQMo7Vpad6H2EFl6dT460=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2052.outbound.protection.outlook.com [104.47.2.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-3Y67AvApMviTOoq63rhwIA-1; Wed, 13 Apr 2022 16:30:59 +0200
X-MC-Unique: 3Y67AvApMviTOoq63rhwIA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUb/gZXyhQXOib2UEIejEedN7j3rJS0Y1pt1CybJs1h42kLKZSH8UTy8XZlyurBJErqSjNtDa+ecy9DGxnhj5ZfpOFpTHh7QZtFBRdsOHCP4pXuqnJ5GenWZbqWNkAc4m3eSBjfTrJUJAA8AM+/bwBPPJaEVtWUI7e5vavjB4UDWjOKSu4DX77BAKMgQEYVgv7hr3xmVIhGWAa7cE5Ehv+kkUOfRSFc0cWQG99csvsfY7g3JKOb1wItd82QVtkMZtK5aqBoZivKGoTwO93szwwYtLA2j601t4ouqEAC7M+ot10gZXk7rmEg0qgPLCYLjpyr3UXoIMgElEQbOxW7jXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hn6Nuq2Qf3qcvDzwF6dbcAk4KEj3jHOBKBmSNDXuajY=;
 b=QBlH5qrIxi1CmcyfBOYhLxGNyMuzWTdSNShfSsXZyM0Ap3fI1SWn9eJGI31WPzrhloa6iU9DGxRFjnbYWdSCeG828F/I1uH1T1a1RmowwfibQOHnUgvPq8ylYRvwOrlUFN1Lj/FBZjxtZzOjCw4AZuehu+5gwbCyDi9RIigDz4bc7KoILWeZV/bEuHt7r9V8ECMPeGds63oTh5pf5z35l1d8uuCsDQzoajzg3x9uJRBEQahLQApil7Vjti6JwFOmej/XwNqURzT0rqITkHdqHKSKJTsHR03tgsa/T8/hOM1yxeZMxxiz3AeQLMpmfvK/8URaJWngv5sOgHoSm8knYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.28; Wed, 13 Apr
 2022 14:30:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5164.018; Wed, 13 Apr 2022
 14:30:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 4/4] selftests: bpf: add bpf_rr test
Date: Wed, 13 Apr 2022 22:30:23 +0800
Message-ID: <ff8e582ccc28b3b85499ea950f5c23695af36f6e.1649860043.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649860043.git.geliang.tang@suse.com>
References: <cover.1649860043.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:404:15::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c41229e-ea47-49b1-a2de-08da1d5a39b8
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB93514C59A8F58E6805C1389FF8EC9@PAXPR04MB9351.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gjIJbZT2MlNf1kagPKkssXG7a3pTxGPeJG8GC/K1wbQFCComlK9eDP+n9eM8ccU8uqEWylvj+P2AYSLuKm+nRJ0W6iA/wsHjdjty7KpWWyxc1qHOX+9N2sMemVUY1OYAF8Fe4T4xTHJN4XCBIZ4c+UvfEnXTjxcBj5l6iTF/+o1JmhTpuP7JQBsaxnmvEuccRr8PGXsKCBZIDlXu2i6tVBI8ZVDfZrpUKPvOaW9NFgxVNaz/PivwU0AWdr1Vf9z6YcZXyEIIdV7U3xf7cEx02iTYr/nTpBNfCtRZPv1To5ZNmu7Z6+jl0XIjWTuH9wBEL6gNAqTkj2C/BzBGIl2pqwFU5Q1hL0hDS2SSQ43JfCvldDnViKZ9wULkKu22dFYSu7HJVHuPDlAzVXxcYYs6QO78W7cDKbL6uSb76k6Dyr0+P0AgfeNjFzgxpHa72qLT3uU2HanCTV9rspFCKRjuNCqyIqknOSp1yvz43nM7ICxm/9TJthix26SyMpeeO9W+aRNIDR+F1ZJT/wP8XHGjVNioI5DY8DdnQ5IW7A32ZdEDSxq0qvErGOLnY6yhoMH4f4qoECRb3fVPKcBnQ1iCLAfMuGybaqapDmsF+DSjtNNxGaFn06YVfDITeEMduI+37v+NTo+lvlTTbHTNKxvLjGDNFMMzP+nvdl/RYI0DsagIfWRYmup8URkuvdSufzxY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(83380400001)(6486002)(2906002)(6512007)(8676002)(186003)(66476007)(6916009)(66556008)(44832011)(4326008)(107886003)(86362001)(508600001)(38100700002)(26005)(66946007)(5660300002)(2616005)(8936002)(6506007)(316002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9inUiLgORtzAFK5hjU/eEKkQk/wOUfKSv75KhxvYlazucxSn9UqUzm5llQ70?=
 =?us-ascii?Q?Uy+9bsIJgMcQlT8ISQy1Z86eh9/yJxcNn8IAIrCF6rd1VjxnvcBYJb0ZHrDu?=
 =?us-ascii?Q?+obHfOnfXq+PzaCoYDM8CNVFsxhwBNaItmSdkWWCfWsKupt4DsZMULiwQ6hi?=
 =?us-ascii?Q?AKhT75si4l/xKNN8BSWUTBvlSfdK6AcAunZqcyVEddwzUi9Wn7HnHYyOHF+L?=
 =?us-ascii?Q?TlCRNU0Ou9nyAEn/8TpGKSBFpAn7zHIQYXSsIjJqRQCVcbPpUV/j8hGfPGk8?=
 =?us-ascii?Q?K5JjNslxiFfTs4qssTS6Tz0UIpMx6KbQCGgYIkNZmjjMSl4107zGzHEPe6XM?=
 =?us-ascii?Q?LWQ7ualfTInX8UD/T9fIWrDONm7STQgEsEx/wrbZ0KKVOXqsvFlrMBhrmhDm?=
 =?us-ascii?Q?6nbPrUk7P+Ct/fyW/+5UYkKKv0n8TKJfUN+FO/l6Izx3+nTK1FbTn4J4XKsU?=
 =?us-ascii?Q?Nj9y8nkVffNW8MqoyAyinyTBFhAHlHMdW4RUk6q6se40Jbe1w+oiWwilU9Uo?=
 =?us-ascii?Q?szb+znIP+pITVKB7EuJiAa32jXGm84qwYz0H3BKmCCa3xkuEIVNK7cKc7ljd?=
 =?us-ascii?Q?JfELECSbkPHOuFM7T3eDBd2r8yKhog9UWEJZtPEOmAEcx1+U6wr4td5ZlVUz?=
 =?us-ascii?Q?vhjoWNTdY14EjuzMOBgyYePmC44UVMIDBBil4VLUhZU+02z1WeYGFmVMOqw7?=
 =?us-ascii?Q?mJla1ncnayrwU86YIxgPx+JArzaytm+WylaSbECUbPddndHGs15sK/dYzNk6?=
 =?us-ascii?Q?iWwAwr6t+2hqzTMsHYwEQnrnL111sJrsgEBvMzpoJkvauOjWgBdcLkxpAQPM?=
 =?us-ascii?Q?uRqIfy063uCQigrFyG1CWSTO9BMwwEBCVrKA1OmFp43RUDd9GpcJ6HjKM9pC?=
 =?us-ascii?Q?ybflts9ts4XKfbGPBvMqws2iJ/fRJff8GWZk2xUpW5Qowd/BkOcttozN1iIH?=
 =?us-ascii?Q?GKl+1qV4CXqycuDtAnpXX1Ib2zEhA0OgE/vWML09P8OlH1eFUTCvhXxjprJE?=
 =?us-ascii?Q?tctFsSGIMUOAtknnImuWJsqr+tEWGwBPDrFiSkEGIGgDSwUQvDB+YY6Htj32?=
 =?us-ascii?Q?s3GpfzMhWO9LrzrlYDUi+C2U9T6a7ZdhB6vGa3uoN9KQYO3y23Iv/kxhlshe?=
 =?us-ascii?Q?T+aXnVdfAmyaKHvT8QUfZW7Ihf/H/i+3RI2JkYu5mZeQkrAWL9DSWdu1o7DG?=
 =?us-ascii?Q?YxekjnFk3lMXw3cnlHOP0X2MC3Ru5e78D9Q91u4xSfrWFd/Z6FNaW44TzmY8?=
 =?us-ascii?Q?MgxoN0Y8wxLnlDNXHPYkixCmm+L9MMYvBRukWZmr4yAq5jjMwaIEPkgDJ9az?=
 =?us-ascii?Q?y9SGIWW9uicRNRDpCEM8u3R8NG18f0a4Ip16tPcAzlvjZ4BIIYjMv86piJEc?=
 =?us-ascii?Q?p+juUdd4b74wLuqM/6rSU8wbSYhcI9GZ6rjFyfZqQSAvlkFB1XyeTpmouXkr?=
 =?us-ascii?Q?YhxwRnu+YN/mwNUDgdHNB+k3iexM5I4kDOuFh65svmR6gqmcLJgiSLKG6mn6?=
 =?us-ascii?Q?jFDT6g/eQ9lynG0a1hWt8RDtJIFGRyhg8+xBr24CEin57QkvnvclA7WJvrrO?=
 =?us-ascii?Q?E7EVMslFNqbrLGU0bfILbx8vaVQKSDtP+y0t2cLzpC6n0erb7mOm4dTQxWQt?=
 =?us-ascii?Q?oX94IZKPKtkJ87TDGqPsxfu2ZnkSSkQUxGA97mx3YhD7jqgu11f8XsvNeA8m?=
 =?us-ascii?Q?71o0KJ6TLJoHY55mTHLev2TYY9ofmU2WUMGJ15JqcHtbTwdJQSiZDHgnVV6g?=
 =?us-ascii?Q?7cUp41chI7GrqSYXf46VONBcHt2h3nM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c41229e-ea47-49b1-a2de-08da1d5a39b8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 14:30:58.2759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdUo+PP86B+ctzw5vP3hRe40rqEOLsTjQO5weQnSL2auvd486KsGS0WBRwuKPhsPGXgj8Fap13vV/cfpm0g/7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9351

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
index 01679077521d..20f382da6812 100644
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

