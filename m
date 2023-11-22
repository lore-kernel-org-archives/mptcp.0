Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B912451035
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YbeuS3hs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zhyf2gCU78MNPP4XIPwbKqPuPExsTgwM8IwK0IjEg4pHUdMuffP27s+vfo9lE0nFxUGa961olYcqXf8rWYhwIUcbpE2l6F9HNBwjWpeNrSQAFVTPOhe4R58T3d8EkEd5oFOXzDZFLJlzEPCPUCyHRbLTqEHHW2LUy+lb213+/DsNe6BRZZypovKalH0mHSTfkfJ7Tw+ueYvtZv1O53WDScFCHxM0FflnX5PX6TXXuawLJWXLoHYBc/LwPNH1N0Mi4bcCgvE4pvqgXZ7rMY6OULgf6gp4kPsA+9PPv0aTArBlvr3IP/3Sz4W2/Qlqxe8Vcu+J0/7wwRgzjMZn5VXbug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLOe+CQcYe9FqZu581+QjycQ0uUj8Rq0ecFVdF9B/fQ=;
 b=bKRDIUryMpA0LjQmEM70bKvoSVrZjeiwu09SElfVySLBpyzJMs3TXy1eci8VW+bcF9Ntux32R/QgbshjavJ1pxcw5l5NaI/gNZneR9glx66wZUBohHJ75WTtf4NIh1Sp0lwvOJ2x37LGQyA9z3xG3FcxwO3AItp3VXV4kHQGIUA+2UxfZGhTvjAI+kZjtBdBi/NzRKmvnn5TR0wA8rO1gslYeRGMiKhC2si8Wvcr/dkNluJcSoetyB7fwCqBJjoEKqReSAu4Uyc+2tmPI56R7zw69537VJ6mw6gCzSw0HneJZKqvbWTl04PqiKpp0jAp+3O0aP0cxzBBij4QCqiZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLOe+CQcYe9FqZu581+QjycQ0uUj8Rq0ecFVdF9B/fQ=;
 b=YbeuS3hsyLxe+slLCvWYJ5msRk0DCrBYoWe9dNVmQBchitkIaCiIsbNkVT9vzMVTgNzjg0ZY6D+q5jK5R+/QhHqCMjqe+hoPVHnVLtD510rOmA3X2rV2wylnmVclkVQ+ya+gQx9THtOV4enJkMj0Aru0RsPTuC+rpoixu/vDAmvhv+vzytMiq1zhVT4hFfXnWx7bCPrF4NwecggyqHIbPPXw7ot6OKPL3dler+Pkc1fay3SNivr4Ep/CZiTW5O+ZJ9nzUW8nLKBxq0E2eX7+uG2WmQCpSbKBwtnsHeX9QUIqDt2k6qOdhp4vsgdtX44jodWdkLTMLP845/TI6L9z4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8333.eurprd04.prod.outlook.com (2603:10a6:102:1c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Wed, 22 Nov
 2023 11:33:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:33:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 17/33] selftests: mptcp: connect: add PORT instead of TEST_COUNT
Date: Wed, 22 Nov 2023 19:31:05 +0800
Message-Id: <904771031cfaa44eeb41df15fadd7cdb78d4b0e5.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0088.apcprd02.prod.outlook.com
 (2603:1096:4:90::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: b848e7d4-c23c-4f13-3cb4-08dbeb4ed36a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NZHlBKvfkIRxHNpgZDcT+SutT3muR1c8qIK6Cpqlu4rjtUZVcyfjiOrf/PCLIYm71RzoxLebxbFxbWeDvyvoz9hqL5Z8HDssR3A+nnl+Fu4EqilWO7siMx85P/tyHXHNdAYAAGVXGWNu0PnMWZIEFWm6Xmaey2E/JASCuIrE0F1fPjJQOtiveQRJSHviULrjYclSDtcskzrcm2GNc8IzrpJSo7YZeN5I5OmY+lU1DYfuS9l4Xp94eALR8+RPvJiXQftzgzdOhFWzHncTX7UwDIweBkCLSF0Ca2vixCX8yPtQwqxHR4nodJ0fU28ukULo/TnG60lLoYpkDKNnn2F7aYMz1d3tXDTXfDOcOX9Kaf4QnBqdP38dIieLYnNeDzWRlpWcURMD0m6JOM3NBQiS+oboeKMNvizy8aS47TQVh1rp5B1aCJg5uqV+8vlxKGGi4A9+uJosiSuPRL+m+6+2YaQsO4IskYSHbEtuKSDQn0tG/FhnxJ7kQ4yQoTHc1wd/Ky3S/4zYphq0MmB2rF5+Bg629JKlm5GOHMykKSsXaVb4keJzJ2Bznpu8ajdXf9V9HYxefrgI0JQlenQhkXZsoY0cMfdHiJKiNh6TUm1IhNI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(346002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6506007)(2616005)(107886003)(26005)(6512007)(6666004)(316002)(6486002)(478600001)(83380400001)(66556008)(6916009)(66946007)(66476007)(44832011)(4326008)(8676002)(5660300002)(38100700002)(86362001)(8936002)(2906002)(41300700001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bfQmuceRckeep5kYs256SZQdwZ3vRHRrNPjOCvZLRWUm1t5UwPSz183clDUF?=
 =?us-ascii?Q?D24z3MrIH95nz3cH6KVmPLFXWlFk3jfPbTsW1LPHZ6ONKyEL2wpz89JYdG4/?=
 =?us-ascii?Q?q565IKGnR0BP63CiH/RiAXCSv+kB21A4QQh8az6lLlLLkRfLUe1FL6o7+aqG?=
 =?us-ascii?Q?jXV+SDufJKn2SJjccljFGzXWLci7D9xXA/P1wJE6zqBKgvTTnijOV9PiuUFx?=
 =?us-ascii?Q?TpbElWQE0QnadiCfSUrVh2tRt0uUcOc+XW+3uQzxW8TjtsMONdO2bsXLF3Np?=
 =?us-ascii?Q?CJvyVdpR4B3DuN3L/WHgtn+nbFQbDEmAgOmhApBS/tKpYv5Q4n4pD6FU41+G?=
 =?us-ascii?Q?5xDXlmIfu/XGVJo04aktgB2BFaXdaKV9oahKZCO8nw8m460+Dn02laXXn3w+?=
 =?us-ascii?Q?72NWXNnasyjIiDAbNz4We+W1n/CKMYr7PI6SDOoTNBPeryUm2KA83zjB32QN?=
 =?us-ascii?Q?Tev3qRFN8uQFFTDf7l/gJkt9srrsOXZvi+4wKQovOjnfuc+71tKHTdTY/4t5?=
 =?us-ascii?Q?zU49y7JzRCYc8Li5KAujmvbpAuE8TlPYoL405AQ3jslEEqTqpM8O6FR8UhVV?=
 =?us-ascii?Q?5Ey5Q3gSIzpqlyT8Gb6k9V3gbkhiyEpMvbqeovViAiJb94+yUSO7ZjDRo8aj?=
 =?us-ascii?Q?1U/+uEoQYW2pIiiLVTJ11rR0JPxJ3DOTJ+fS2QuIryHW+Gy4Gggt7oAojwt8?=
 =?us-ascii?Q?FGN3dblrLZRfMG9NK46nUsct0NTtYSkv1890Mjs9uR13vwDfD4627IP8Y7Fs?=
 =?us-ascii?Q?FH/w1kOtFsgR4P9H2+UkeDBR1cYkrkR1mdsCe7WQB64H7mVaj5Juqboku7uz?=
 =?us-ascii?Q?abEVxjmnPOSTs47LmNtqg5UrMWW6gGCMHECJi3MWnZ80BcqCeL/7SarsZdX+?=
 =?us-ascii?Q?ON+XsJ855Ef6DlgGUCW61godHixdegJR7pd+VgVRcC0SSOdGzhg/teAzZ+Wx?=
 =?us-ascii?Q?QTgjrQyc+2rRPigMPVwEfdySn2LLzWPvDSy9Y2KKES6Mao5paKZZM/+WY7D8?=
 =?us-ascii?Q?lcJdxHGqf+NKQqt3kJOCb2QxZrBoFEtETbQirCXLmD84BizPC8CqwEqX105G?=
 =?us-ascii?Q?xv/zyRuEtZbrJvi7jQ+s8ycrQuL2xpJepUEvmqsGGr+LOa30aqtDQ0af4Fz6?=
 =?us-ascii?Q?vrT6z+HELj/fDFqRWGlIQog7nbaBRrym1/zpdz6fR3Chqwr7H35BeHSKsH/P?=
 =?us-ascii?Q?27ZUp9KSAs4+d68MJNrkcGlU7lHYZvV4FLCwnGM6HwhtrL4yAA+9jjTehRLp?=
 =?us-ascii?Q?1wqqpHqWpMMl96BIw9/2yW3MnRfLtsyLjQ1YhJOfsQoawedQrfbLvicaTv94?=
 =?us-ascii?Q?giKLcN23gN1lIOlv/wvV9cAQjh7bg8qWb9mY/Txj9DKFyq9Hy71RUYsHL3zS?=
 =?us-ascii?Q?M80PgNEWQnfkyzLp7EBRr4LfNipozmUD6bOQG7SZWZt+5SMGmi9giMlI4S/i?=
 =?us-ascii?Q?itFhKjDWBcfa81glOm+Ps36409S0rR+boMZqy32G9KlelTzAwOSkGCu/b6zC?=
 =?us-ascii?Q?hniwJ7xuHgX7dPB5ykjoNurcPRxfronF5Qiu4FpX4kZXGfASV4xY4BM9NI7n?=
 =?us-ascii?Q?JBPLfpqNMETh7cdStIuevoL5P9lL7l49iIEcAV/TVzYAzXWCDqjw5DI3e8aY?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b848e7d4-c23c-4f13-3cb4-08dbeb4ed36a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:33:19.1228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UIqh9RvbGCB+FmbRgElqr7WU56bbYn1AWDuXP0yDVEgOD86U8TnvUqV8+1mqudohWgvpgk4/8QbJ740S6Qeb8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8333

This patch adds a new counter 'PORT' instead of TEST_COUNT to increase
port numbers in mptcp_connect.sh.

This can avoid outputting discontinuous test counters.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index d085a32f662a..560eadc1de85 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -28,6 +28,7 @@ do_tcp=0
 checksum=false
 filesize=0
 connect_per_transfer=1
+PORT=0
 
 if [ $tc_loss -eq 100 ];then
 	tc_loss=1%
@@ -308,8 +309,9 @@ do_transfer()
 	local extra_args="$7"
 
 	local port
-	port=$((10000+$TEST_COUNT))
+	port=$((10000+$PORT))
 	TEST_COUNT=$((TEST_COUNT+1))
+	PORT=$((PORT+1))
 
 	if [ "$rcvbuf" -gt 0 ]; then
 		extra_args="$extra_args -R $rcvbuf"
@@ -691,7 +693,7 @@ EOF
 
 	mptcp_lib_print_info "INFO: test $msg"
 
-	TEST_COUNT=10000
+	PORT=10000
 	local extra_args="-o TRANSPARENT"
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP \
 		    ${connect_addr} ${local_addr} "${extra_args}"
-- 
2.35.3

