Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2075.outbound.protection.outlook.com [40.107.7.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3E951035
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="vufi23iN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkwBCvfGVVtwcONS60UROFG4toPYIu892/tb/h3+X+02UQHyDzE/3AFIRjJI35UXxLqTQ/byNC2TY5E6ami1/OIvGfhxn8FwmECr2u6/wZ50NUdoXVYy/4KyiY+r6rSKBYYwV6e+tDobH/Awx4apuxsHj2HZI09lhD7OBuIBH1QdTVpRsNthXYLgjE6XBSQZ/zsPuIphf19YFv0JsSeOmicDddGPN+92ylbQ/dzwWnTj904Mwc5cXyejAbCvPPdGF4XsdTyFH71fS9MHzDX3FrBUEwWflkeBN7QuHxHZeLmledcPJYHKdYl5xgEENmj66/8vMeGCwnoDzIfDqedNSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQkxNoCe6dpOQFraOb6hwmZhqymdwFCV/IA9RNfj1iU=;
 b=N21tlXv29zImbggg1S6bsYzzdKc1xBCWglEyPFdoyyxciXxXdScUkwV++3QImy+XfUV+rka/DOrKBaA8hL9769Fs0ufsTiUqWaCzYr2qa0d2uKiuNpdsvTQpCpxp05Wxgb0KSYa7/xYIgOQ4lyCnMqeGeTPRbADUNuPA/eHHNLf2ejSIEHmygGXH9zU6HNCQuobE3LnYNBwOQCsQzSFI4IPvrPm5iWPps8otnYOIRgpy6/vj0GaESTKUHmeuaKRqQ7ZgEuTkNumLhE5HOJlISBJYxclT8Kr6cIzE9at2gVjvFWXQQ/ZouodJuSHIBTj/+KxBnaZezbHMxJTePJAKqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQkxNoCe6dpOQFraOb6hwmZhqymdwFCV/IA9RNfj1iU=;
 b=vufi23iNnDY2PgdR/hhtldwEG8w8hoViEyYgKV4G3WMmCdRZhvg4C0ESI1D51XGlgaWdQioUrH7e6sJp+KPuFBhujvUe1SZVdO1LsbpWmn7bRAFR+eYXOBuLZ8y8d865jSc1GTHidZjfCQr+qs58YiJTqGJGTytdw9qqSz/IPwbsukQtGIZjalUTV+CR7gJKK5nn1TWWUkAv5AL3uPMPy6Roy9tRvnBVBlR7C/9tOwBlNDjXY8fh8RsjP3ulqW1ZeRoBYPQDnGuz1MTQxcn2IAa1bW4wgzUXOqkdZqLKXsh8AZAq5TPDjJgimhl+manPH2ysASRJ7O6QVETQfllfcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10050.eurprd04.prod.outlook.com (2603:10a6:800:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Wed, 22 Nov
 2023 11:33:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:33:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 22/33] selftests: mptcp: sockopt: print out test counter
Date: Wed, 22 Nov 2023 19:31:10 +0800
Message-Id: <bce4f3ce1d764d3b840edce8d3e49a3e8876da3f.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0229.apcprd06.prod.outlook.com
 (2603:1096:4:ac::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10050:EE_
X-MS-Office365-Filtering-Correlation-Id: ce9507c3-c046-4559-1d53-08dbeb4ee598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bgbEp4UlZlCfJqvp2ZF0xokNDWcoyp/lSBVIO6tfK70VKBlQH40QQeFT8ElcfLkZAz1FFyFsax4yB3ASaoAs8nC88xxRMO6GHWDuvIb5Pz68SeVWPMTnlubQmTWfhRwZXJuGCaOBAgozYDcf9MhOxq/4d2Iaea3xQ1zcI65d0mHSG18BlEoBqTEg2QP+YzLKIUr49YNNP7rU83J4f1LbfJX3m5ZdGmaDacgVKHZQDBoQ5OfkRL5D49cU8XT9zFX9+VirgrEiK7aDSzEQatwXpWpz0XrBGBWRlcbeGtiTepPr/RUJlz2ZIBdEK1UtTvviKN6eXe5e3C1qkjJk0vcL0NS/pX7hHaMU/vj3S172d3Ig/KnZ2yx7gDSbWrsEvPZ7fvuUvz9haYUEHvLBki87QKKbBhnYmfh5z9qHMACZWn/knsjv7w+cF7eAQ9KVCU0wxn/WORwfzUaH0JBXaDwQjU4Zkxpah9wySMRhzKVJIcRmlYxAe9FCJlbhriPMUC5DP/53lBVwRMreN8UTh99dy8ukDwEHNr4SJ+o6E0CxZ31vdUqx0j4Mh1OsTQ4JSBOdH8qaoGQmYpj8yxF3HQeIpIBLzgZJ/SJ9gxFxJkuGzNg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(5660300002)(44832011)(2906002)(4326008)(8936002)(41300700001)(8676002)(66946007)(66476007)(316002)(6916009)(66556008)(86362001)(6486002)(107886003)(478600001)(26005)(6512007)(6666004)(36756003)(6506007)(2616005)(38100700002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZNtYmkSw1lEz8i9L8jqNV+1qqE78lrLxdiC33mKP9CSfjSx/id8LU1OdN5et?=
 =?us-ascii?Q?5kTaxxbnI7tTCC+eo5o4mk97yl808jrPLD5SC5q89II8rUF0RKkLgfYTg32c?=
 =?us-ascii?Q?oxADA8Gpp6sHuJlZBdTHzBrjz+PRFsAcGPPmExT/Qx04Mvo8p5xgh0p5rhrM?=
 =?us-ascii?Q?eccTLPwUOUgP9smW1okCZ3mEplmWzRFJSLmNlsTCymx9buYCFCJNrW9U1kP+?=
 =?us-ascii?Q?wag1jaxxcgWLxGNX3My+D4JUlkTPSc8MeBI7OstdOkOLyQpJi1200Sqyvb8O?=
 =?us-ascii?Q?k/Q+iQAXNcWj76gvugQnS/y5ut4tNJNw/59ayJ3RPCLNPKMba1ZK0Nq6QA+z?=
 =?us-ascii?Q?29JdbNB8kvyItRVUSXJrsu6FquxJ0/6Qv6iukD/bx6Ihn8ygIedCcHN95BJ5?=
 =?us-ascii?Q?w+Cj0W0G5Q4O3+do5oVId48eZvRl1gPAYGmk6VAuzdZ1APlVbpSd7xwKg4NM?=
 =?us-ascii?Q?2tgJpmLfzFETdudbZlVdRC2vIwmHIZynWGD25kyvfyh/1AHUpaX8jlfAAihl?=
 =?us-ascii?Q?rSiJduMsMxMHyzdVfCiABgwLv/kAHcQYgVExJONIP0+GFUycGIRrAHvJ3iIz?=
 =?us-ascii?Q?6UFaXF/XZP2WavZRIa7ZkiFGzSNVakqrqRpjumgTQ9nQC6wZE8yot0+Zyf42?=
 =?us-ascii?Q?HGMZETQo5ESgCkybWKzZizSrtXZsZtKStG5hP3o/CNDYxropL7PmZP8ApdDi?=
 =?us-ascii?Q?yn7pKuAh6r7jtUJWw/56/BH7iuvSxngg5A3sgTMVMqKxpO5E9weNPMGjUKby?=
 =?us-ascii?Q?Wlo5p26MRr4be2fEs414yPgjn7e62CHJ3LBDPs+TecLrY+jELw4960AY/bzf?=
 =?us-ascii?Q?EQkaCQaIl+21j92uETPOI4/xJh3b0ws0zbwurxZ2PHK0ptVw8raGme75LcRO?=
 =?us-ascii?Q?kDeZ1HpBUY60aOsPBWQyuz2kzCOkv3wAlmJTzW5xTBiWW3bO4i10onxivIlw?=
 =?us-ascii?Q?hVlBZy0PqrYmNmNb6YaGo5kYoRVU+LEGjYXUkYK6v9YMnqfhm7T5JIBp4Rst?=
 =?us-ascii?Q?9IF3CYsmzHDKTjiX7j6uRDI/VSOhvn/59EJ8bNm6J1ZK5Vq6ju1WCWSgomOO?=
 =?us-ascii?Q?YxZpUjpDPdrKZBFCteQGCcR1Me8BGIn7GNW2mi1rX7vtpaJci07g1zOmNGBY?=
 =?us-ascii?Q?563QQAsOOwf+m7xWwg5mYgofYxRl8Bf6+krjcYvZkfd8E9/Jh50CamQC8Ns0?=
 =?us-ascii?Q?MJP1otCqv91zjZ0zwP2rTcVbXLxaKYp8SsdAtSNbGYPwvDb11QRCXYdLF94F?=
 =?us-ascii?Q?10yb/zcaoW/a31eHh0qDkxZR8+2beuKH7vgDFAnVDAjoofmnbKybXJL+aVkO?=
 =?us-ascii?Q?RlEA/XdldifZrqojZt7ODpJPKC5o9/MkZ/xvci4lyHPEQzOiNPDHfNtZxvn0?=
 =?us-ascii?Q?CvEqRksvKGDpS3twL7ADYsQmVSH3nRKvZVnuMYw2fH0Rc8xCiMHJ/WIv/ZVZ?=
 =?us-ascii?Q?5CvHw41fs5l1kkpzZIXlkM7tgdGzXz5LLKGVxTG+Kg+zz0U4zC2nLUSTFi4C?=
 =?us-ascii?Q?F2f4YUrcdrwvQIFRwMrPE2rngC7RERHil+pzA1VoXqwAXE8nxUk28Vb3cO4n?=
 =?us-ascii?Q?EhyShlQNYlxaLhdNbDIvlEHRsjawV8JRa8Qr9BhS5Uo+9dNH3Sx1hl9HzV/I?=
 =?us-ascii?Q?dA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce9507c3-c046-4559-1d53-08dbeb4ee598
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:33:49.9218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8CYCx6lji8UbSLCHXvVqpIoaqg4viuEcKLkVmeYmPpnRtUwSSI7cG8ez4iEGyPmU3Se1GMHJAAVEpvMfZ3BACw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10050

This patch prints out TEST_COUNT for every tests in script
mptcp_sockopt.sh.

The output looks like:

 01 transfer ipv4                                                [ OK ]
 02 mark ipv4                                                    [ OK ]
 03 transfer ipv6                                                [ OK ]
 04 mark ipv6                                                    [ OK ]
 PASS: all packets had packet mark set
 05 sockopt v4                                                   [ OK ]
 06 sockopt v6                                                   [ OK ]
 PASS: SOL_MPTCP getsockopt has expected information
 07 TCP_INQ: -t tcp                                              [ OK ]
 PASS: TCP_INQ cmsg/ioctl -t tcp
 08 TCP_INQ: -6 -t tcp                                           [ OK ]
 PASS: TCP_INQ cmsg/ioctl -6 -t tcp
 09 TCP_INQ: -r tcp                                              [ OK ]
 PASS: TCP_INQ cmsg/ioctl -r tcp
 10 TCP_INQ: -6 -r tcp                                           [ OK ]

Having test counters helps to quickly identify issues when looking at a
long list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_sockopt.sh  | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 9baa103055c4..2b02689a92f2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -173,7 +173,8 @@ do_transfer()
 	wait $spid
 	local rets=$?
 
-	printf "%-25s %35s" "transfer ${ip}" " "
+	TEST_COUNT=$((TEST_COUNT+1))
+	printf "%02u %-25s %35s" "$TEST_COUNT" "transfer ${ip}" " "
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		echo " client exit code $retc, server $rets" 1>&2
 		echo -e "\nnetns ${listener_ns} socket stat for ${port}:" 1>&2
@@ -190,7 +191,8 @@ do_transfer()
 	fi
 	mptcp_lib_print_ok "[ OK ]"
 
-	printf "%-25s %35s" "mark ${ip}" " "
+	TEST_COUNT=$((TEST_COUNT+1))
+	printf "%02u %-25s %35s" "$TEST_COUNT" "mark ${ip}" " "
 	if [ $local_addr = "::" ];then
 		check_mark $listener_ns 6 || retc=1
 		check_mark $connector_ns 6 || retc=1
@@ -238,7 +240,8 @@ do_mptcp_sockopt_tests()
 	ip netns exec "$ns3" ./mptcp_sockopt
 	lret=$?
 
-	printf "%-25s %35s" "sockopt v4" " "
+	TEST_COUNT=$((TEST_COUNT+1))
+	printf "%02u %-25s %35s" "$TEST_COUNT" "sockopt v4" " "
 	if [ $lret -ne 0 ]; then
 		mptcp_lib_print_err "[ FAIL ] SOL_MPTCP getsockopt"
 		mptcp_lib_result_fail "sockopt v4"
@@ -251,7 +254,8 @@ do_mptcp_sockopt_tests()
 	ip netns exec "$ns3" ./mptcp_sockopt -6
 	lret=$?
 
-	printf "%-25s %35s" "sockopt v6" " "
+	TEST_COUNT=$((TEST_COUNT+1))
+	printf "%02u %-25s %35s" "$TEST_COUNT" "sockopt v6" " "
 	if [ $lret -ne 0 ]; then
 		mptcp_lib_print_err "[ FAIL] SOL_MPTCP getsockopt (ipv6)"
 		mptcp_lib_result_fail "sockopt v6"
@@ -281,7 +285,8 @@ run_tests()
 
 do_tcpinq_test()
 {
-	printf "%-25s %35s" "TCP_INQ: $*" " "
+	TEST_COUNT=$((TEST_COUNT+1))
+	printf "%02u %-25s %35s" "$TEST_COUNT" "TCP_INQ: $*" " "
 	ip netns exec "$ns3" ./mptcp_inq "$@"
 	local lret=$?
 	if [ $lret -ne 0 ];then
-- 
2.35.3

