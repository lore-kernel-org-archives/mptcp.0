Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF6D612D
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="tN37hGv+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSdXNJ4bWSi5sG7VkGuMZc9iws1ygq7GMxqWpU+oT7ylFCMMqqmhvEQgDgWkl9RHTJiUPvsUpl5yjusJweC6l6Rh/N7pt617G1lIIE6cfj36LW0z0J6ACw3++dGEQocldSmloB8IzeTxeAP6ZDvSdsoDKMv3qhLPKAzLBJraRaIYLNKbypPgC13fKAMUStnhZRGhMhC5glW1rn5kJF5XGwOwKuI7PnW7RP0646TCWp7rD3meiLay5KI387+nNPplTL0GxoGL+NHlcm5J/0Dz/G7bcXbDLjrBhZwIbzj1l3h0CNo/y9NEqFgk51fyTHwf6/HpjZh9v400jaS2uczFDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pstlKgHJVkC1IFYS0OtawCtL3Nx6gmiEQybXiFmd+Co=;
 b=Ag+QUeb0NElZytJF6ZexyL0moCwhMQ1CzWe8Rz7rAafwcnQJS40JEbPmJDa6sZpHbST/WiRs0u058YoGe+GoTRYc+bx6ScBGGS7IRK1bRukET0NQNrYIzPq9B495ufEaqmGr+TpQapFH8EQzZ/2z3DmTyYiXFXmQc+ANeIVnZdWL5odI04OihqoyNwSpe1AkqmIZ9DAcPzp2oHB1pj43Cw40ual/ug0aJvqwXcMAT2/D6pgkEaGZ4vLYlIc5B/F1of/W9BOpqbQoUySz4J8tJlN4mpxxjXWpZvQXSX+OprSlc3J8uEEr80DdLuJNV1aXEsrqYeYOkCpKF3AJRxkHAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pstlKgHJVkC1IFYS0OtawCtL3Nx6gmiEQybXiFmd+Co=;
 b=tN37hGv+rTgAs2L9NTVOGbc83XvDuaOCcAKgpwnR593urXT8VZM/WiIguAvzSJGugUsMORRfLm+igb27KKVPjTCh9HgXHh9oxfayiNElWx6tfjhYh40WYjkYIqysJs9DuuEOo9Gi+s1V8PqluDnaOUBCfjnE79tRYzLvCfTMvmNfuzZ8kFM5c0whF9rBGioK0DSEfKiLmhu4GeHruDoZhP74rCnfQYK9q4pj2J9lnEzECdVcr5EWjs37wbUSKhDZhwaJFgUYR9tD9xSfGG/g5QusvuYsPNgujRbJB8R80MTBjCW+4XF5P+7ekbC4N/fj/lG6ZQ8A+7Qg2CUXy0+udw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8932.eurprd04.prod.outlook.com (2603:10a6:20b:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:40:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:40:20 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 19/32] selftests: mptcp: rename test_cnt to TEST_COUNT
Date: Tue, 14 Nov 2023 14:35:38 +0800
Message-Id: <2883c2687349762a5180f08f3e0d2e0871aa4ed0.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c1a7cc-d117-405e-307e-08dbe4dc9233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BRPK15Eb7S0+G9CxdLV8gKAGYEoKGndpQfV4LpkunrRZOO8LW4BP/eoL84JR4ssdQFkhmk0pfS2dKDGR+wkTsw/SEBCtJXU1R7cCWJPH7F//o+u4oiPILVmm+WnvFPLzJ3UDA/6nUmDy/DgwOYV7lhhSgY0xbtgDenCiwIh2sU+UCSq6G0Ins9iyivHORsF9vkUNMZ+f7f9zZ7vRboZQnkQLRPFe2441wPG//E7yffDJ8A6O4pew3jgKuzxl6LbP3C7CDE+d3FqyUZjGWwqQTPf/4/zuIEHOmUuEAqXkQaNVaUR/7C3vs2qLInlCy9TxgBL7YMrcVWUSZcPLiyQknf4j+c5JidFicwKRxHY05ryL7TfYG2J16ONdUOaaN5S4OMtEJFmyZ+qfOSPPbWYIbG+2yJRNsyEHD7S5594cAh9b9GMjWvIPw9FSAeAIDlTrXHD8siBO4YsnN9lTrZA6W2Ef+LCvjNjzEaEde7iCVWcqjviBMtDEbZyyvb01QixHaANTwWBHcCNokLU6BvrlPckdNXCrpWCV1tlmmsDweDYJbuT5OTFPRY32/ZR2RojY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(107886003)(5660300002)(2616005)(26005)(6506007)(6512007)(44832011)(6666004)(83380400001)(2906002)(478600001)(41300700001)(6916009)(66946007)(36756003)(316002)(66476007)(66556008)(8936002)(4326008)(8676002)(6486002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8NAn/Gyw2OxiCzhxJUd1JLpiSv3C6m0tiCcmTHrO9XOjgxllPv1/L8/qch7v?=
 =?us-ascii?Q?Q8VtFOHjsy9msNHD0QB5VCFYpBgXnECYWtpEMDcSn6JNcRJFCVLSboCJ1km3?=
 =?us-ascii?Q?dTshkEfnGRM9XhLuw+jVUjKkTl48ZR4LXz8pWLJN9U6uAbYO29wBfDsPOXDk?=
 =?us-ascii?Q?DVPVjVid8SXDbbmIgW3SRvxjg2zhaVOV/NzW4UB4qWFvjnrWNMBnlWl4BDvB?=
 =?us-ascii?Q?7ZwxMP7BfURKmSIpE982OQdvtMrbHWDOoJD7At83gwKlJx7GtKWBBYwknvfH?=
 =?us-ascii?Q?MzHjdU2X01++lUSiCiGPh53naHJxZWrFlmQS7LBUGHVEVLGRxLjb9SANQZFQ?=
 =?us-ascii?Q?JlmK3zxhTDKLu84ouZO9nFgCeU2UNWbQdjsENN9zHVMwG7PkUf+aKdjTp8Ju?=
 =?us-ascii?Q?+rNpfILaD6p31zCrsaEd6cOwSyVr/6ewNlUqfPurMML6YPrVKwd28ssUeQT5?=
 =?us-ascii?Q?Ina4iA9x38lL9tJrH9Y+BFJeKvVGAKf8XqaKGA85vcI0ICS4uivIj82YclaT?=
 =?us-ascii?Q?lL3fVg4glfjMA1o0p+x5ZeQSULocHoqI9tC0v5qlP9lKfYC/7xl68RMnr10F?=
 =?us-ascii?Q?eVB2NxOLYZ+55ppD6N2n3rrFNK3V9nMi/V6qPqU2398LkUQJcLzrfxcuEg/5?=
 =?us-ascii?Q?eR7rTK0LhKmv6Od5L7uPKr3/FklH/+iag/BRAUrFj/iPsepxIlMha6PRrpOJ?=
 =?us-ascii?Q?Zyrp7HMPKPVnEWirnAuu39JBGSX5w84NEmV5GaTPWFq61Rs7xdrl9tV4gwnh?=
 =?us-ascii?Q?VJgiUeUJ+TMAs9ILNr0rauUsQ9wEvaK48nBgK8kb+4p8186TPBRou6iD+545?=
 =?us-ascii?Q?NFiyP0JAr1JRw2rtcWz+Ker1RDymnMcXvhieA1VLRhqrTQo0A9w045a1D8lD?=
 =?us-ascii?Q?TaQovPUQF74z/isB8OdRr3fA37GO2C8GbYoRcp6fWXZmXMa0NZevgkyda4ub?=
 =?us-ascii?Q?PMh4xZw5VSi74zf6WUee183x/NSR0dQFU5WI7Hj/1QqONuWmoQzjOt1AiDNi?=
 =?us-ascii?Q?EFsz4BoiKZlOEaK6eoZcqeAlzs+vE15STDR4mhdYgT30htkUKZU8xlABfcHY?=
 =?us-ascii?Q?uaX/afao1XBadHacPRxBdRmwiBnkHlc8GK5pA6Z58glBeauxX8DzaWlnWvQo?=
 =?us-ascii?Q?UkqJj7g1zf4h3G3e9a5IiIxhU2URkjcfeVCtqIx60sODRKAdbWbY4yif18gM?=
 =?us-ascii?Q?j1alIVDoPcVKS9P/SibIXpJ0Yoqxp31yP29Msn9jcHLhwQ2jCSYF2gd0K5Xg?=
 =?us-ascii?Q?6ONvEogAWLVqOYzvpG7GlxL/lHm2ql6zI/mpl/LGrUyO+D3Q7iQ9cy5+yh0V?=
 =?us-ascii?Q?vSYlPUeJH2muEp6objK9x9vVXWZFcogL/NOjAKP6iancT+Ajxf5Y9Pl1jgo2?=
 =?us-ascii?Q?gHy8UrvTVqHMtm+ZgO4+MY0RyI7B03gQ1onV153/cTFhUqL1qXuuDkRM4VRX?=
 =?us-ascii?Q?vEpcJVTOq4gOesgMuC/foAqJXZyAW2ElYXNtzejVOl1IdJ6itf6rMFQLGHYL?=
 =?us-ascii?Q?jEPbJ7TQhEHZcbcohM7vOMW7NvV4NgFGoWEbDN0O5Ao6yGC56rcH0zV3AQca?=
 =?us-ascii?Q?YKuZ5zoteDE3NDSeahJicqP7D/eRzDfBbsjHRY+k?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c1a7cc-d117-405e-307e-08dbe4dc9233
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:40:20.0885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVkxHQAn3N6SKTcHUIUnc2Kj0q2NSHA2WWRgjFZhDG282VX3Bbz/AiY9ZAlD89VovPtjkbSDcYvWtLIcdEcMrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8932

Most scripts use variable TEST_COUNT, but test_cnt are used in diag.sh
and simult_flows.sh. To maintain consistency with other scripts, this
patch renames them as TEST_COUNT:

    test_cnt  -> TEST_COUNT  in diag.sh, simult_flows.sh

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh         | 12 ++++++------
 tools/testing/selftests/net/mptcp/simult_flows.sh |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 7cf1f602bf48..541a9d2d128c 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -5,7 +5,7 @@
 
 mptcp_lib_ns_init
 ksft_skip=4
-test_cnt=1
+TEST_COUNT=1
 timeout_poll=100
 timeout_test=$((timeout_poll * 2 + 1))
 
@@ -67,13 +67,13 @@ __chk_nr()
 		else
 			mptcp_lib_print_err "[ FAIL ] expected $expected found $nr"
 			mptcp_lib_result_fail "${msg}"
-			ret=$test_cnt
+			ret=$TEST_COUNT
 		fi
 	else
 		mptcp_lib_print_ok "[  OK  ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
-	test_cnt=$((test_cnt+1))
+	TEST_COUNT=$((TEST_COUNT+1))
 }
 
 __chk_msk_nr()
@@ -113,16 +113,16 @@ wait_msk_nr()
 	if [ $i -ge $timeout ]; then
 		mptcp_lib_print_err "[ FAIL ] timeout while expecting $expected max $max last $nr"
 		mptcp_lib_result_fail "${msg} # timeout"
-		ret=$test_cnt
+		ret=$TEST_COUNT
 	elif [ $nr != $expected ]; then
 		mptcp_lib_print_err "[ FAIL ] expected $expected found $nr"
 		mptcp_lib_result_fail "${msg} # unexpected result"
-		ret=$test_cnt
+		ret=$TEST_COUNT
 	else
 		mptcp_lib_print_ok "[  OK  ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
-	test_cnt=$((test_cnt+1))
+	TEST_COUNT=$((TEST_COUNT+1))
 }
 
 chk_msk_fallback_nr()
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 86f021bccae0..6a4568d8f596 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -8,7 +8,7 @@ capture=false
 ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-test_cnt=1
+TEST_COUNT=1
 bail=0
 slack=50
 
@@ -115,8 +115,8 @@ do_transfer()
 	local sin=$2
 	local max_time=$3
 	local port
-	port=$((10000+$test_cnt))
-	test_cnt=$((test_cnt+1))
+	port=$((10000+$TEST_COUNT))
+	TEST_COUNT=$((TEST_COUNT+1))
 
 	:> "$cout"
 	:> "$sout"
-- 
2.35.3

