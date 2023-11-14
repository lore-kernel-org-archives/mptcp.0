Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC0B18C1E
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="azU9mMH3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPpoPxrCyVbcerXcrtPseax80vAbczD15UBt3MEzXOiKcDOKYPweV1pzX416rEnBOc3PyR79OGkvM7DC352rW+/4r3UQvW8ncLZN0afmr6pf5eiArgvyai6SxWvPcSnRInd0ml2GR9jVRriuha3VVM+ezG2e119V/F/ZRxFiype6ujStceX5z4QUPM1lUV5/m5cuBHFv/OoG5vlxIneKe7+rQnAsvsyA8oh71Qed7tjJhBZr4x1XrGKo1yDWInmTVu8YLvQF5E1405edhlOm3oCoD+oMumMTu9q6jptLyNcYoK8dJMFdipo4tLk9GCZpmePKX+7InC1Om8LEfNASgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylyB2i6xIwqVSug7eHgYL6mnnTQJMkmRI7REsg7punY=;
 b=ljFRM7hB4MBIF9Beh1T0MK+XNPnEpZEEKlFGyc5C2RyK+Sk+GSso/0ei81ckiQPGTCGnQFccpMqCXbmK4bPsmUgTot+jAwNl083ssnQBC/PsQmRHpma0+NEMcfA484EYlBmFLnbp+vVaRJNIFaHcH7Yw3nkJU/zmxp5rxquULmznSD88tx1Qxz95NzPC+iQkR3QpMxzkOSP9mfycpcF9+Ou1ZAkJKKfK5pVUjhU4EY3HoESl4RsdPiuvQ08hew94BHj0ng62jsrIN0SRNGHKxiEbc8lOQ/qYTOB3hAMyQ0Hz+l+cNqZ17asua3xa6eJV0DYzTGsg9Bt+GBrEG/kDVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylyB2i6xIwqVSug7eHgYL6mnnTQJMkmRI7REsg7punY=;
 b=azU9mMH3cjfTHWJz7DdGZYvR5DkKWwQ0mEnHp/bLrJYS1BlkAuTw15EoJ77DaNgYHrPQxT+1WCTtutcb/qsq/5iNa94c82DwNVYDMNL/k/qYEuhiZFzId2gkmuuRP9mgERlDHjpXn7bGS4JUxXtjwVrl+KTT0lBpQJFRDu/8V7yI0AFe6DjeOMfErJVR22P7hEMuXH4qYNS2xdIj68uZRcoqj93PwMcfGmCruKK/mA6/z8dMt6EBziqavkFR8gJ3oLRkB0aRzEwuSoyHbGXP0QgMln7G6KV7dpI4Y7sMYmLy+3VKuKU7Sz3Y4CTF/qcHUiL3LbzapGXL7h7FN0W5Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7013.eurprd04.prod.outlook.com (2603:10a6:20b:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:23:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:23:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 20/33] selftests: mptcp: diag: print out test counter
Date: Tue, 14 Nov 2023 18:21:50 +0800
Message-Id: <f0d32afa91a3ba45cc7bdad926e3cd5ba26e6893.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0154.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f220e7-ac35-44d4-1a42-08dbe4fbd00d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b4hswU4x0nZaAhHucw5F+EwomD6vCJsyJ+c2uy+T5Aqk72rmOtIgPWdR+A8Km74EGEOsQ4ppFpmCpOURFphjlr22YQEbcCVM+94QYvJuwOm/6VsQAak/IpbP29cS3yMVQQW/attOQlU9nL+YsH+AItQ3yb67SdbTHtKVI8o84+1z6cWRduCRzbQHQUWIPLv/3ZxbpIv9VrI10oWKlQtCmnKNlGInhRmiTPt6yVpWxKcaqTVugYFeM+w2Orl7quA+rHbsiIPIAHU7iLOQ6D+C0jVJvPpFO3xHINbPP7mLK8mieeZSo47JQO+EnGfmnItxW0yi6TNLP+DYA5jWRR0rRCGfXXY2ePzQbI2LMvEwFp6wOSKs8VSRbphlGEvuhIw7bCsvxLc3QvAOv/cyVkoyRl/SKGiKdjisbbZ6GREEIhMR02xZ72n39J3VhtsiOmfLfB2gqzYhIKmh/nX+V1e0KYenyoqU4pHPYOKhZdtzUlc0A1eAr0T3YuM5o3OHo0KR4MEzmRd4TRe2nFa0OSYNICP4c1uBPTiawPy7v0CeLPEk4lFdazuuuYsucV2Q6rOr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6666004)(83380400001)(6506007)(38100700002)(8676002)(107886003)(2616005)(6512007)(2906002)(86362001)(41300700001)(5660300002)(36756003)(8936002)(44832011)(66946007)(66556008)(66476007)(4326008)(6916009)(316002)(26005)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D/V34SPGGVp56ENH+QuVT5w846YGzFCJLqolV+Iu0qXNwdAmcwvxYmuFmn23?=
 =?us-ascii?Q?ozQ2IeO2H6xTPcDQlVfXT4tzzPvp9rWr3z3xM+YtnjuQ57o6SRU/64It5RTb?=
 =?us-ascii?Q?dvd1dJTpcZziOP3FEFhuxmbJ5HeNxx/0ifrHlpXvkLxRzVrlAjAR10oxvZN5?=
 =?us-ascii?Q?67lsRIwRxN5z0iq3q/7tTfVrYBQpqQNd46Jyj6LLGuqKdihn4LSOq45XILRV?=
 =?us-ascii?Q?VUCkyQziWYSdJrwt5QU/yw0u1A92NhbUkqBbAbp8j8B2mZy6InGO1BdWsEOf?=
 =?us-ascii?Q?S/bOsQNG37rD35YQC56UOvW6EO02ykptCzuKQNGLsKmQjxySz9dGll+QAqEl?=
 =?us-ascii?Q?xTMvT3E+3ckdy+HomMPsRbmERMf3tVsy32f734kKzcX1qvj1dEE5mvDaW0ZE?=
 =?us-ascii?Q?551MLcI8wwSKQ+CmxasU99a1CMhumtMOZj1h24iwOjuTI+9xecJOC077Jt8n?=
 =?us-ascii?Q?ohZ8RNSLnhARLnxS2jBWXmlsWSgrfwGax3zq7gwcrQ5QjqrbFtFl9svIoX/P?=
 =?us-ascii?Q?SJx89OwCouVcshmawyQNBNnXM4GFdAIofC0tGPbCDTCK9OWLgPx4ZL2ufSww?=
 =?us-ascii?Q?LOK0DAPO+bXhmaBMoSdrCT5M8COH8j9dXdaPP1+19WDOlfbe+TDM5MBW8HkO?=
 =?us-ascii?Q?61/XnO6NNZ44j6Bt1DWvtTGDv05U+MhxO8Epg2ZUWkzfO6IlSaBkYUmk/xpd?=
 =?us-ascii?Q?XwiUCI2oi62pbHOAsx5MG2PKieOYqxKeqH3K9vnx3IRsOfyay4Qv4G2k8od9?=
 =?us-ascii?Q?23V7b7xJMX9EXv0ytCMLxAqXIqWTWKzUGXq+ZVH6HO7e2orcch/Sj4aGP/03?=
 =?us-ascii?Q?7Obl9kMfe3ulG3wWd2kSO/uZClcbP4/O6yBlYX/oyjXXnB8HAEdEWIzi8oYi?=
 =?us-ascii?Q?G1MQEQz5NRaMSdrnZmc+08VpPdIuAfSgcug1H9e3C8ot3O9VlNcQmI/6dG/d?=
 =?us-ascii?Q?FGLefoOW1PsIZ4neZ2WesROUbmjIinlYbZPofbep+vWvjgFi5tkHfl+Jj3QB?=
 =?us-ascii?Q?eRZXkbv3pnVSo4yklbINXplMFSc3OnJ0LsOpD0qG0Jshxn2Iccg96+gLnSao?=
 =?us-ascii?Q?w0RpQGnCiIgA4IKZksxu2miAxUBLXv7BCkpA5qxHmZmYdJ+m5FCkFg91waB/?=
 =?us-ascii?Q?BjaSZuUTF/lWH9FkisNvbr8+jJs9qn318jEnPJ7+if+pxYozEqhjt31CjhHs?=
 =?us-ascii?Q?0pfBOS8/lW+ZVhXiKAictJ2jUFIYFIGggHxIZ7CTZ6QpstHBiUcSzAkK5nPL?=
 =?us-ascii?Q?dEe7DYKPcy1MKeadgPrZ+5UAbdCzeJX+F9Jkfuy/M1kMtGRs1Z0lv3vX1GlW?=
 =?us-ascii?Q?a7cSzXNV5s8YkQL9U05hPAAc9No9Pd7BqKazf+3qYR1msXJbq6OJsNZY0Ey7?=
 =?us-ascii?Q?7eK3kwVqBrb2Gee5OQXaKkzjcOQ9gf9NDitcyYKK7dOU4DzoT2GwQGyvEIRf?=
 =?us-ascii?Q?8va/si03GB2b+8RAJlge761JFZuWQVbV/GU0fBn+DpIVd7QcIiuCpHIuiATr?=
 =?us-ascii?Q?vbfPOWiUPAF9GiK7nGRhGrvjtGKPTjVMotJMiJSKyVAN+wDoo+7pqmlqwdVY?=
 =?us-ascii?Q?zAolY3pmyxg0fs+GKrMnm+60AUAdSYbvocpgOqWNblc3/EOYrt2ovvjjLZWq?=
 =?us-ascii?Q?iw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f220e7-ac35-44d4-1a42-08dbe4fbd00d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:23:58.2493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlfXEvbp6Tm1weL9skKqun/U/eRIl5NVw5ZuneGH/ALiwcVKrBARJIsx1czzRpF7TuPbLLDq8hspMo2LiICXFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7013

This patch prints out TEST_COUNT for every tests in script diag.sh.

The output looks like:

 01 no msk on netns creation                          [  OK  ]
 02 listen match for dport 10000                      [  OK  ]
 03 listen match for sport 10000                      [  OK  ]
 04 listen match for saddr and sport                  [  OK  ]
 05 all listen sockets                                [  OK  ]

Having test counters helps to quickly identify issues when looking at a
long list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 541a9d2d128c..4279bb59939d 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -5,7 +5,7 @@
 
 mptcp_lib_ns_init
 ksft_skip=4
-TEST_COUNT=1
+TEST_COUNT=0
 timeout_poll=100
 timeout_test=$((timeout_poll * 2 + 1))
 
@@ -59,7 +59,7 @@ __chk_nr()
 
 	nr=$(eval $command)
 
-	printf "%-50s" "$msg"
+	printf "%02u %-50s" "$((TEST_COUNT+1))" "$msg"
 	if [ $nr != $expected ]; then
 		if [ $nr = "$skip" ] && ! mptcp_lib_expect_all_features; then
 			mptcp_lib_print_warn "[ SKIP ] Feature probably not supported"
@@ -109,7 +109,7 @@ wait_msk_nr()
 		sleep 1
 	done
 
-	printf "%-50s" "$msg"
+	printf "%02u %-50s" "$((TEST_COUNT+1))" "$msg"
 	if [ $i -ge $timeout ]; then
 		mptcp_lib_print_err "[ FAIL ] timeout while expecting $expected max $max last $nr"
 		mptcp_lib_result_fail "${msg} # timeout"
-- 
2.35.3

