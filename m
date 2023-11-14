Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0E8612A
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="iFCoMRb0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrEldpDIeClUQPFtkvAXtdNq6EPQIbzYHzzuatx9FQh2QtBy8RkX6uAREQT4s3eNj8S6P2TSR9+7iUHxKeanudtLVQBQoFqW8+3QGvm5S6VS6M8l25talmf7cr3Mi6wERN2XQpTOmLato01zC0/nnCgvRAAXEAEUKxdums/7GPCr3c+ECe4BVzi+vu/A7AGjL4ETK38RxBf3h6u2fiLUV4UXApU+9lhfxLWM6cyRUUkFnvnnlUsvtp2X+HsTzhjNBRl1Hb7b66rt4swtjTfAlbHKX62DPJ8owyqfkIbiisQCKz86uxc3IAEqBfoy2U6uJbuErlY3/3e1eBHmt1Ay/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvNMoWxeIJtaEInpK0iT0VR1O0bULxCyHqMobB0bfF8=;
 b=ThAX2+rYnUXr1Rt4T7QP6XKbepAXSsnO0C4XajgFiA1ZWyDEYrvMbqQP6Q4y5bptUgh/3oaIEM4FND4ti/7okId97SVs0aW8bGXUTJe1NbAk87DndQLQlCRbPSawiKyuURWf3VAQe8IrfAgmbwcW7qOYpCNAfwL0hTYbFqN2We+OwXmWJcXB5i8meYXteI16FVqxNr50ZOmkOKsV8H7szCQ4zIVWLSVIEIpKoD+go0d9zAebSNSZiJ4/667NJwqHVsnq0xQg10D6lwbXSEK71XONmT5u8wfG98RtYw0oGvHBGt8x83cTVyCIkF85oLsqskhpBU1/uwY3GlzP2bmEjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvNMoWxeIJtaEInpK0iT0VR1O0bULxCyHqMobB0bfF8=;
 b=iFCoMRb0a+JckCXoP/Y2Up2OFX1db0FNFcdO5prVwQhv5KAczxfyU3D09gsyj8JX1zkGA+3m08WzeKDqQD++LC4W761BM+M9lwir4AdHRbVWVvrRqTLSsQ9Obb330nprBDYxZsEoVZ0x213ScKGgl4Cqzm7XXTsV7NErHzetxGpQNbja34RAv8MLElevHQwRlgXUS+45uyit04fClN24eZwANHO9PoOBOiL26MSHVgR4UK6hI2p3ArsLQ4mLc9JILyW6rRsfFoxg+skNntAv18p9rMhih0SPqiCVxbxR6pk03ca/vIVZwTxTaCpwRQg91th05SVm7WaSLiMfdZp6Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8480.eurprd04.prod.outlook.com (2603:10a6:10:2c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:38:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:38:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 07/32] selftests: mptcp: extract mptcp_lib_check_expected
Date: Tue, 14 Nov 2023 14:35:26 +0800
Message-Id: <7dcddd1f3d03b7869c21c5cbc6ed9d7107849e9e.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR01CA0006.jpnprd01.prod.outlook.com
 (2603:1096:404:a::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: 5344447d-4155-4f46-71a8-08dbe4dc5c8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5PNWU0k3rhmAtVLoE19uAqcLhfNaL4qf2d28ZLLfySwjSkjjOMXwa7EjMXdOhcS5mVviS5mWeBgzSrsZexAlDSiJrWlCmcgOPI4mVs5oEHvi6JSFVINqktuChMIVTSuzRfiRS7SHBMpbnAwugL1PrwL899ERKCGJngtMQqkzCw0qKS8IRqg2GJh/NgCf7Lg6aMqA2GyypdeYBEM0KIhQ3wMCfQJyGyqgLbpN26aup23rbAU2CE8wNnnJJp6gjJ0gtqGFOTJ+4PIwrt35k/YJLK3A8MpEjBsCGCefzatPLcS0TskTbluEcg4m5uc9R2gMvueV/QiugHgwcbuDwDnncQ8TzVAglr1QJG+TTZg4uwNBWEvE1DuFMYlCtSvrDZOdegKebyDgUyHmR7L0tFZkeYeeBGDM5oTN4pUVJSfTToD+IE2nuntEMdu/LZTh3nBjxlaDUbiLzrkaQkIwo8p9KLOkWOAsZ+Y/SUceDI8mhKNNn3dkequo6lNVbQAS3T3maAiAq4tkb1D7RIJB/QxeUUXrKgh8fMGJL40b/HzSxXRtSxCsn9lDnrzq+yJFm3I2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(2906002)(41300700001)(38100700002)(66476007)(66556008)(478600001)(6486002)(86362001)(66946007)(6512007)(2616005)(26005)(107886003)(6506007)(6666004)(83380400001)(8936002)(8676002)(4326008)(44832011)(5660300002)(316002)(36756003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TUDszy/y22uRRfrqRsuaIOaiyu1YyGG6NpqrwS8q38GNmGjte1rdkLkmIAjO?=
 =?us-ascii?Q?UUMQR4BexpF1EOM8hnoX0rvYFKMiamsb0vQRygWpL2jvcGv4G89q7Q67S+aL?=
 =?us-ascii?Q?DBuXYTRN2IUQ+zGLiyV++D8SNnRzir8jhty1R9npxfQcJLQfnGlU29KHyzxP?=
 =?us-ascii?Q?mrvtOOANrYyN3pMdW9lpcSvExKxsS7rt4pnqhMwd+Dh3VePAXpUmmcfMaEDc?=
 =?us-ascii?Q?L10BhK5zCIYVgEBW2laOY9ruROrIpPKzNy0D3teW2UnQbnnvPbbRsMxDVsHn?=
 =?us-ascii?Q?LGwWVYlsCTtG0Nyh3jsjdZ3FfWLASWuNSNfd0S+4rucjr5Un1izUJ6K4iw9o?=
 =?us-ascii?Q?SJTGpfxjrdTkL0hPc2EfSd9eJr/MmWdBvBKsN/t3Q8BwnOWoewRETOshzSce?=
 =?us-ascii?Q?/dJsDuEbZVUzzhFxvC18bXTxUyk9r50zi5Lo1+4yS5W9X/njCDobsGkkA/MN?=
 =?us-ascii?Q?bDaB4NqNIr/9TzzVWKUq2Glq5Pn5hBen0B6k7TdQenfWAXVBb4MrbI1ihNAH?=
 =?us-ascii?Q?EtzXwo5pC4WvxZwkHD8ZjWvaczvrjuRUiRm/wiTs50NLFW3E16uXFm2xWlic?=
 =?us-ascii?Q?1XOVe0RmmzSW1NktHC96Js2Jg7cfag/y1F7QxAH/aVdJQZqprkQTMEJ4jwXx?=
 =?us-ascii?Q?XhIaQXyxjXIgpcBuJGy2jnQhMy1ue8oefqwWqkJdwN1jn5a734+iPW09Le2x?=
 =?us-ascii?Q?CuNilB4C0NVbjnh7BfzM592SA5xn4Nx8zG8aq/Uf+fUegfsWijRbbO4zSxkh?=
 =?us-ascii?Q?JYfWkPoF7y9HujCO8xPFjIT2hzPMgN+yuVBbuyt5MejpDE+B2/HQytHu1sw3?=
 =?us-ascii?Q?HWk5u2i5UEmyhdGpmdRMi2GDoBXn79wqT68gK/jXOV3oICH5BNEB/HAEs+5e?=
 =?us-ascii?Q?4ZVLVDhdE8hfigHeEcjJvc6wUS7w45WOpEGYCLVxuWXB50hmljNumooNsUPi?=
 =?us-ascii?Q?YlZQqsq49PixCoOIlXB2OsIXwFypXGjouHidjKMCyNKM+4xJOdsc+zta8ci0?=
 =?us-ascii?Q?ZXA6zV9jTPGXGH+cPgZD+pml39oOmMlE9/h96hXyl3201iBb6PFD6LeAhpsN?=
 =?us-ascii?Q?h324Krf2GYCqAEH5EPBr2sWZXXnYG4y/bdDT+G9xb2JFbKa/IWt1p8EZi6+E?=
 =?us-ascii?Q?UldlhdaEI8i+yRHUywX4KjBIHgIVZLWGl5Yj5S1PRvqLx0G2MEGkFDGaV3qu?=
 =?us-ascii?Q?2s7lA1C4vcB1hADn9HVqxQdPuKrZcoaDBRKWZ5A/fPgu7LaaDX+aN0XjEXkk?=
 =?us-ascii?Q?JQlpNEQ2ajYB75yLWoxvYS6mBasincEXcxbA5LfKIkvjIZN9dsNoebja0pND?=
 =?us-ascii?Q?5KMcodGg/HoGvhGFcV7qjPPaM5lXAn18eWRMCBQQzJVIIXuNFbD7V35NuBF7?=
 =?us-ascii?Q?J48cE9XeljDi3tvcIR+BVjeblLEJSCRa3fjgsP9IbrLKgP7uap3jH5owedAR?=
 =?us-ascii?Q?zfTgx0IxMC4jxgvIKrWYDsB9M2mtymNfC0/r65OiKpUWi1woRMFMFhisH1Eh?=
 =?us-ascii?Q?bsBr/Dy4+ulfOcDSASjS8j7emFqSt/n1qk5ojqX8Bo2CKCKSbKss+zEdmcYc?=
 =?us-ascii?Q?SH40Xg7SbD5pSRyWhMSEtegQm8+ytBvHQixDR10m?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5344447d-4155-4f46-71a8-08dbe4dc5c8e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:38:50.3763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MkeBQ7obSqbPg0H6/qq7QLeDKpkBtKCfUdilBr8OEiXb1ywVDmmdTbLBVjopqhVWs/g8colD3DsPa0WN23kryQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8480

Extract the main part of check_expected() in userspace_pm.sh to a new
function mptcp_lib_check_expected() in mptcp_lib.sh. It will be used
in both mptcp_john.sh and userspace_pm.sh.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 42 +++++++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 41 +++---------------
 2 files changed, 47 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 88ea621e7df5..3d23783dc307 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -391,6 +391,48 @@ mptcp_lib_evts_remove() {
 	rm -rf "${server_evts}" "${client_evts}"
 }
 
+# $1: var name ; $2: prev ret
+mptcp_lib_check_expected_one()
+{
+	local var="${1}"
+	local exp="e_${var}"
+	local prev_ret="${2}"
+
+	if [ "${!var}" = "${!exp}" ]
+	then
+		return 0
+	fi
+
+	if [ "${prev_ret}" = "0" ]
+	then
+		ret=1
+	fi
+
+	printf "\tExpected value for '%s': '%s', got '%s'.\n" \
+		"${var}" "${!exp}" "${!var}"
+	return 1
+}
+
+# $@: all var names to check
+mptcp_lib_check_expected()
+{
+	local rc=0
+	local var
+
+	for var in "${@}"
+	do
+		mptcp_lib_check_expected_one "${var}" "${rc}" || rc=1
+	done
+
+	if [ ${rc} -eq 0 ]
+	then
+		mptcp_lib_print_ok "[ OK ]"
+		return 0
+	fi
+
+	return 1
+}
+
 mptcp_lib_cleanup()
 {
 	echo "cleanup"
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 7de2ca99edbd..a85eb83a61f8 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -237,46 +237,15 @@ make_connection()
 	fi
 }
 
-# $1: var name ; $2: prev ret
-check_expected_one()
-{
-	local var="${1}"
-	local exp="e_${var}"
-	local prev_ret="${2}"
-
-	if [ "${!var}" = "${!exp}" ]
-	then
-		return 0
-	fi
-
-	if [ "${prev_ret}" = "0" ]
-	then
-		test_fail
-	fi
-
-	_printf "\tExpected value for '%s': '%s', got '%s'.\n" \
-		"${var}" "${!exp}" "${!var}"
-	return 1
-}
-
 # $@: all var names to check
 check_expected()
 {
-	local rc=0
-	local var
-
-	for var in "${@}"
-	do
-		check_expected_one "${var}" "${rc}" || rc=1
-	done
-
-	if [ ${rc} -eq 0 ]
-	then
-		test_pass
-		return 0
+	mptcp_lib_check_expected ${*}
+	if [ $? -eq 0 ]; then
+		mptcp_lib_result_pass "${TEST_NAME}"
+	else
+		test_fail
 	fi
-
-	return 1
 }
 
 verify_announce_event()
-- 
2.35.3

