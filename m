Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E84CEA4
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 00:54:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esBx8dj19jwRKvr4rK4RdsNEGU1kiIcmR3UqpazC3ifgDAT5ePMP3RCD3yePRVGs4G2NrqUyeslYjge/msKyZCCmDJ5DF3BJsxWJn2zoH3cVUqOk8h8taKSUk2hK4p9MNZIVLasJw+HSFiMdOzrndWg6CeZRHQnZnliKsQ2yx/FnLcy2V/aPfO0t402yAGPtW76NLvWQ6fteHCjxs3BTGNMnStUoOrWqIVzMZn6x0gWO7fn3zqXPwFI8oZup4xOG98nmc24LQWuSYIVI8WhywrYwfE9EQ0yef5cflYbLKs9ww5wInkW2GMNkKvtYujZvIFD7SEDFKCDxiO1TKaruWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fC6JUgj6hQm8uCUbjLKa5cDKSSsdSNL1kVEFk7rK9IM=;
 b=Q+62zQ25+SCzeLTk1qUSk2hK1V/20dLMfL3qbbZeIPKeIRbG7Q159Q7oSOZ9FB1X7EGecf8qeti5C8mM0ZHmn7NrxzNMYMWmg7nC+OPGsqrPyCc5uqzhCCAEZxBOOwcwvaOMQm9Tj7kl+zjUGKNPbwUfo5EnTkeRxPY7S/Grxctw1GwqDNajzwea35GXb8ca7nKFZPkvhpDzSB23R1zWzywV7DfVMQB92zeWC20fpPR5hzK6JR2D52GguzOcijjDR6PS3X6yPXoMSHwnS4ER/ci5WZRqaWRbXo2PefIxoFHUKMuaUHzsiOxa+BV9wu5+hOXwDdXKZQ+jgNVKjlnNZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fC6JUgj6hQm8uCUbjLKa5cDKSSsdSNL1kVEFk7rK9IM=;
 b=QA6QjohFJnT1U0bht9tWRoWQUBSLa8y5DcCjGo4PYaO4Hl1FrQQLZUbhhIirVq5V8JXsBKHOnXw6z0eHeaCVhl0utfJglC3J8FGpCA5spSGIjzxgE1/qmFvi98xG69mRrsDMoLufpUfr9MlRyTENAH/+avDo0xS+Km/Dvh4xUZ0WlQ+yIPTFSavCRaRa7bnpQLg/e+uzKxeSSmELgXsTZf2ZOrzO+UkmdrtjLqTI1wFWkHRx4b5BH939yGMRdlYLAHq8+3OHvPFgY9jT/r8TGoFzaNs5fLcWY5ZjPFf3FUWq2P9D84eq1mdtIIdSlX5x1dxPk7gaaAPsVbHx1eFtCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB7163.eurprd04.prod.outlook.com (2603:10a6:10:fe::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 00:54:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 00:54:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v14 6/7] selftests: mptcp: pass fastclose to sflags
Date: Wed, 31 May 2023 08:53:03 +0800
Message-Id: <cf46573cf65a5c7772fa9d1ef2c080b10dded2c8.1685494054.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685494054.git.geliang.tang@suse.com>
References: <cover.1685494054.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0026.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::13)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: b6e1637f-057f-4486-3f32-08db617188ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aOHyZLNr4FynKkSBr1X0piNLlABmDD0WZBWQ+l6cfAeRijL39oa89b0QSXO+7+VTXXc/1yvj4CAbl/2cUG/KG8Yb7pFfwxdSaBtXPGBKGr6UCQTu3ZAulCVcog+jvgHUEc4Aa7xhkezMArQRzZbmLt5YC9jXgdVlocz8NRK6ghJa7oFP+YSAM9gRnPJk/vr9SpMeD9SkibycmzlrDxiIs4JzkEyC9mHptBFqK0EIB6LHLaIr55BeYGPn89amf2k91RES/DUNDjwYOPWE4hUrm6qRecs6h2qAcuf/CnURe2FzznO6xxg3QZsd5Ef7iH0C/yBJq0Gj+MWREB+bwUw2lsfhwFOH9W0Ds9tM0nNKZrGs8kVGCLZYhLRILQ2NPMfHEZKK42NHrQxkmRcKqV+Sin/AWyi0353ApN4b+jdDDl33jswvLKAT0DaP3nXQUZyBAyPBq365Mjm+Kth6nbMgHnIUyD3mi+UBDe1UKThGVhZHpSHLiPeMqUK9Jgs84bR3+Rx7/my+U3vpcxUSSlyZtYajAVSOgjCpj/M8prLvt3V1NKuXWs/7ZNgFY1R8i0zE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199021)(478600001)(8676002)(44832011)(8936002)(5660300002)(86362001)(36756003)(2906002)(66476007)(4326008)(6916009)(66556008)(66946007)(316002)(38100700002)(41300700001)(2616005)(107886003)(186003)(6506007)(26005)(6486002)(6666004)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rhR9ZzgOJbLil7lz783WlJL9KjzI/Ikvgj69pCPNxEMvUKI0LuZHIKJ/BuEj?=
 =?us-ascii?Q?bQtTIDYNETXEmmN5hm8au5HSGC5wFqjjZIYzHoKL8fWPTtQcEV0Ne1rNUIB5?=
 =?us-ascii?Q?p/uqmRaHgn1UQe3TGbm96i4Sr6agQ+QCU3jZDhwddCeQ1UAydOg2u1+1L4st?=
 =?us-ascii?Q?4TGm1Medi7oTO8IYftSmAE8mStoLEphK+4r5Gz04n3QSCev1pRuywDvPA6nd?=
 =?us-ascii?Q?UsdYkuIBVMb+HXsWhaxSR3rUlmry3CXCQVzUAiB2I5Myu8+Y0SkhqViWARbQ?=
 =?us-ascii?Q?rrAHtCly1LiJZ+ZuastKzPpGjWjaxGTs/wuWdHw+OkbKxHmneQatpFBjg0IA?=
 =?us-ascii?Q?UxYzaDyA50nCJ5hqnd4Hz1ZFyS7OirB3hxscMIWsnJtT2LdJECJX9WDPT1yT?=
 =?us-ascii?Q?iV+cY4M8yWuuCdmQHEj77jv/chX5EhX5kizgQwGXlCLABL+o+QUTnMvwbW3e?=
 =?us-ascii?Q?SP+rFlg8bJmddJ7uTxQqfA51qrBU9pQYWOhVGqyK1dyc6i9Cp+z9HzT3ITST?=
 =?us-ascii?Q?lLlmbaEynsqE8qcLrY2xmppry7ZWU+UkLv6M751Hu3/4b6IbCIMO5YD2/GkN?=
 =?us-ascii?Q?/oQqKyqkwPx2/KXrqkgsy5iYu9HN7gIKytGkbewmLyyop7vGBF/YzwUQnDEa?=
 =?us-ascii?Q?Yn5NZI55eHFl+BfIK3u0AQifFhV8f0/0wwQPnKB/iOYer9/IUIJqQ0g/DIHP?=
 =?us-ascii?Q?G1S9JYnbqUWOV2U1c9nXE+FzPW4Km70UN0fxmxeJQr5Nmm2LAOx6RjCuziK6?=
 =?us-ascii?Q?/KznDMHb4lHg38m/12mqMtpVEV4PjNk+rps5dizupvRZaUfO5L1sMQRV2MiR?=
 =?us-ascii?Q?rs6wBt3NhRii0XtGM8gD3o7YPZSvjSRTBtB2LTUYshz6fL1kv9Y3S4A7jQta?=
 =?us-ascii?Q?yzKCLBbeKn9iVIiTK7Hzy/etF8pJQVAvPyXEkoPSYIHB5/6ffo7/NaOsN7Vg?=
 =?us-ascii?Q?A3bbs3JRYzHDdjIdH9eC4+V8N4Z0t20YAmXjNST2A1x40uc8+Z+tXUlXXdcw?=
 =?us-ascii?Q?Q+7F3gxIzP6lyeaMLUZlCh/m4MfI7RJ8HHZtnHyHTtL2Z5dnTr+aidvynJkF?=
 =?us-ascii?Q?eYO3ZTdYatQrIVbEBpj2sdOjh71FHOB8B2Mj/UWaI35zzPXgFDZxzVSrBsLG?=
 =?us-ascii?Q?PoVZpmK5KRWD1DI8l/YFo47TIQuFfWj42OzTMJzH6iTFGKN+EE1JLMllPaDX?=
 =?us-ascii?Q?I75qBPVQPj7iTVsxQtS3FDFTTMWUZw8RJK71MDOgn3HmY0f5RYl+IrrlH3Po?=
 =?us-ascii?Q?PFFZGJwHevpbHgI7nppFYLIBDJ/jRq/aO4t8ul4ITYexmm8458T0ycVl/F1v?=
 =?us-ascii?Q?5NBrbBvK4PCHhtHvYgOZGy2qjoXrbAVDNfk6kKPt3Puxl9T/SJIkrJjTq80Q?=
 =?us-ascii?Q?tZRIK+3VC2nfg0alhgvqaUz6LgXbDeezHu895Rtyq+rqR7vhyAchD3UacvvM?=
 =?us-ascii?Q?RlUUgQRQqzhvzdyuWf0V2xXs+QvuzM8QwgTC09kh+jrZN/z/oHnDVuRKwxFR?=
 =?us-ascii?Q?Zj3hn0ttIFwSwsC3zO/ROPRWnZYFZPRurlNcJVKoa8E9BFAJv305mYFA++fs?=
 =?us-ascii?Q?OQWAOkAiUEMQsMqgLFscj3WBRlMHj9HcVokmneJ+?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e1637f-057f-4486-3f32-08db617188ba
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 00:54:05.8008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sVOGRKFvZO6sTV6VBUBElxL5T9FnsBMZZvqoxTlSUrG8CprAIcCUKqJSGUWwKg/nH+8HLDW43jcvAvfaTj/bdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7163

Pass fastclose flag to the sflags argument instead of addr_nr_ns2.
Then addr_nr_ns1 and addr_nr_ns2 can be removed in the next commit.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 7270f8cab157..9d71ede742dc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -853,7 +853,7 @@ do_transfer()
 	local extra_cl_args=""
 	local extra_srv_args=""
 	local trunc_size=""
-	if [[ "${addr_nr_ns2}" = "fastclose_"* ]]; then
+	if [[ "${sflags}" = "fastclose_"* ]]; then
 		if [ ${test_link_fail} -le 1 ]; then
 			echo "fastclose tests need test_link_fail argument"
 			fail_test
@@ -862,7 +862,7 @@ do_transfer()
 
 		# disconnect
 		trunc_size=${test_link_fail}
-		local side=${addr_nr_ns2:10}
+		local side=${sflags:10}
 
 		if [ ${side} = "client" ]; then
 			extra_cl_args="-f ${test_link_fail}"
@@ -875,8 +875,9 @@ do_transfer()
 			fail_test
 			return 1
 		fi
-		addr_nr_ns2=0
-	elif [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
+		sflags=0
+	fi
+	if [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
 		flags="${flags},fullmesh"
 		addr_nr_ns2=${addr_nr_ns2:9}
 	fi
@@ -3131,14 +3132,14 @@ fullmesh_tests()
 fastclose_tests()
 {
 	if reset_check_counter "fastclose test" "MPTcpExtMPFastcloseTx"; then
-		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_client
+		run_tests $ns1 $ns2 10.0.1.1 1024 0 0 fast fastclose_client
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1
 		chk_rst_nr 1 1 invert
 	fi
 
 	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
-		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_server
+		run_tests $ns1 $ns2 10.0.1.1 1024 0 0 fast fastclose_server
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1 invert
 		chk_rst_nr 1 1
-- 
2.35.3

