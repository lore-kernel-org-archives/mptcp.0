Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D274AF66
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YmynZ1rw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJabjA9GKvWNV56tebcyWt8gFKbsYZ5AJ5XNr4EOgudL74/msIl2y3BeFuqd3poMPJJgRNRaHQT18kFaTAYR1p6T960pEsa2yAjKiHlA53y6rUjGcnnqTmoT1PkBjx30j6z/XpqTIIKcJnBcOFaQrViAX6W4CT8xMFlJzRllB5XHQ0GsjRJSuZy0tCJ8nBAknRYDbAAOYAavcKrFACnAkIK6TwKCi7gAOnCXePuEY9aLDBYhUl2jU8piLPT3CaGSTn5KTpfrTnQXz0phcIFWZK6ezRRavVe+fG5TdH6uuyy+GUFZftN8AUqls+pey2Uk15jQAKs0t6qTbPOd714o5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPwCLfjOAzEXOluzrsobxL9Yrk7FkFZXeG7b81W4fQI=;
 b=SYLvWOUGpmAnHvglKthm4P8OYDeeJJZa53iVMedWqHCm7xfRLJf8Mh0w7/vRRw8m7t6ygJWMVVlSFZ54bfUuPNUZj+uQpi0kvVduCvICqUOouDoPHb1ZPIrtiZYZatINe47rocEh6F4m4jzUXQbkzBLB/3W2WeoNSV1AuNvF6TlX8PqsaMCgxiKZNQ57s0pH8nk8rgBm5H/HMdTHlA7kTuefINi6Mz9K/2cUeYQog5eKMfn2ZH+6tog6y/hblWBjCrafV77wmWkjVpB5fD2dlrxoYXbKaHfSXQgsI96b2th5UuKy71CPQEraJawPa+js3tMTplWQ9oiS8RaeHkMg7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPwCLfjOAzEXOluzrsobxL9Yrk7FkFZXeG7b81W4fQI=;
 b=YmynZ1rwZPqNzOENF+n4znUPY3ClDi1sSHENpCxFOJb24z7xueQhMDDAGa4gS/AberoNhq7dbk1pYQXZ7ZW930iFWSJYIr/RjSEgAwVI9mkv1OkLK9JPviIR1Zq0hLnHjYduefkUVkKZWhlHr8ZiQvWgIWfBZraXdxa95j9hkwYHb/WQF88SJHXWiVeXEILYClKenX3PYSGr7Uc3ZHBzazLTNZiXNxMSbiw/8VL7LB9xCzIs8ucrT7PZpHg9bZKM7CF3vRBvHYdP/eRBiJK/3Rvkobt1026tVPRy1k6pQzbkugFZsre3oqQIt6AdFYejUUsuqo/xBVs1AS8JZhBRYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8858.eurprd04.prod.outlook.com (2603:10a6:20b:409::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 11:34:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:34:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 24/33] selftests: mptcp: userspace: print out test counter
Date: Wed, 22 Nov 2023 19:31:12 +0800
Message-Id: <7ec189777cb3ccd22e513f5bd5ecb2205a5b0a65.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0233.apcprd06.prod.outlook.com
 (2603:1096:4:ac::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: c02334c1-d877-4b73-d7e5-08dbeb4eecb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ndA0VeI7XAmgAAX6iV9nk7xsvjRDTt4GXOYgExBPaqxTFGEjRzdmDEBKq3HxL36iFnijL91OpFq20LVrI2WBSERCmgwAKxuCcVtfjv+Q/rXKZOQ3D16CM7sUoSCwpSvgGVtKr3JgQcEPF4uFMvplwfNg5nu1QTPwekBfVd818ehBb6CIjfJTx8aa/srpdQVZC3f3M88RtCE2OgjDP2r+IV+zqyo4mpoFrFmJ2zAlKKptrv0hcepluGr6SEcOmbsXhFKaZhyX14GJm4qu691APNxrotQQQLB7s7NamCSciiWqdlo+LloaWge5IMaeBs3+vDTMqRkNLlXijskwxEV373ggXDekMbhcH+a05O4mZRgqcWyIIdiduS6ORHnCKyCuYWc61C9nNwOguqe62ErHDpvZay93Dnl35UV81nWqR/Q7KdFLHaQiDAjgwgXktEWH8A1nrp9qbqm/et4rC3aoDV2mJjGWGJ9EzPwaeZ0AIjDYDZAAD5JsP5EXJ12Qf0DycDYL3ytQ4wnsZ2Q9EFDrvaDVXTLfSnbQeXMkv/ffod2bX8AxKo19sxFy1gdMt1RRFe2O9lJrfhRoQ7ZVTjmeuFNpE/QEA03KySfwE/2X7R4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(5660300002)(36756003)(8936002)(44832011)(8676002)(478600001)(6486002)(86362001)(4326008)(6512007)(316002)(6916009)(66476007)(66946007)(66556008)(41300700001)(38100700002)(2906002)(83380400001)(26005)(2616005)(107886003)(6666004)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SoYE/DXja4TVLUqD2Iyx3iYBNjAGyOWk0DcEVFG3499L6Mk/zmBQbSXtEk73?=
 =?us-ascii?Q?6iiUFrcBZmeOvfeLUe+4y2VVKJG4DqMSgt3LD3yx3kMrx9Eldz+7vSdJCkF6?=
 =?us-ascii?Q?rW7+yh5rxhbplt4YALR407RzS4ow6FZcLHWpArq3MVamJQ/mQBCiK/DV86g2?=
 =?us-ascii?Q?OISYTpcShk+Z3b82rA8kanvTrA8BsZ7KHSdZj1DV7tpKLwp3yoZ1QwwyEDTW?=
 =?us-ascii?Q?tGtQc6Rznl/x3Z+sNYb8ZbI9GOY4YE9sTGv6LspZKL+wccFTHXeZQGm0Qk0Q?=
 =?us-ascii?Q?8D7xAmwQqaPmG5iF+o8CXb++EU1BZpD80d/UNKyEjd8T5Pp5oCkCynhvvkJW?=
 =?us-ascii?Q?wAnTXRSYBt5pnysKB8hDpnYTm1MnydKUtTWxOb9ysgrQ5ZYZ9JEysqSgPW2k?=
 =?us-ascii?Q?dZxAO1QTyjrelfZiFuuG2eidR2/8RDHSOClIRqQHcCtI5eJoVDMI1ArJymiZ?=
 =?us-ascii?Q?cr4oflRJXPKl170vOOM6J9Db4lgZvL1VpzlM2hs3g3rVu4MoorauxKWXbvhG?=
 =?us-ascii?Q?8Mo9718D+eCIwk6hS7Ynbxw9pWkxuGB00cB7oR0OM/Gpy6X3ssL+mlHCvcnF?=
 =?us-ascii?Q?cua10zH1mJIIDY2dJjE/Meiiaa6OICtIIawTbXZI1cK0YYWdtxquAhnelqHu?=
 =?us-ascii?Q?DfT/5Jp28SerRCsFmGVxRALS/tsgIxgJCA7e57WN60SwOqzDiPeNc/FEj+UK?=
 =?us-ascii?Q?lv4RY4o59mCvomEXevhqWNsi0vUbPNBzzDJc3t65AhX0KrvT2COSBx+LnF6Z?=
 =?us-ascii?Q?dT4v4uhcvzbg1tIQg1gjxvXT36KAhT/41X0DgU/plm0wpcdxQQIgy11IrlBc?=
 =?us-ascii?Q?3960T9ErHnCVAj/N3Gmmr42UIefXqj6QZUddZECwIgeBsr2xLmzo984JzRFQ?=
 =?us-ascii?Q?23nA3w7Spb4I+oqlDgWI4DhY4pZrBWl/kd0W2DNC9a50hbFmwO9ilDHlLN9j?=
 =?us-ascii?Q?omWgGWZ0wl3x0SWL93fjsvLIgfHogUWYJnxvt1jbnrPrKPIPA2QkWKKmxEmx?=
 =?us-ascii?Q?gqfvzS8Vkp5EtdAwlHSIWZpDs81gEfFdFxm19ZkvIITHdpCMtM7R+yif4fe9?=
 =?us-ascii?Q?KOaJmwJ3tyMQnY2qfXx+yG6QsW1cWg7ck5BegLutcE8wFxurAoGDXxTDWifA?=
 =?us-ascii?Q?R46T0OOGEKzSRYuObXXZQzu0llj93bWxsB63ZlZj7MLua1Qi4ZZBRVY7kZng?=
 =?us-ascii?Q?fWui04xk1K4vS4H2R6EkVfnLwmGHDP6wLQ3TNHRrAtPEmUP/7L7Oc4niRpwA?=
 =?us-ascii?Q?J6a9/dfyHUQXOsUn6HBT29lcsqgD9iRpCh3auFXvyg9TR9E1B4b+8oP8rzzu?=
 =?us-ascii?Q?PZZAFs2unK119yEsoj3BTAzneNbA8D0yLYa+gdZFfOp1pzS0DAaqSkC6zlQd?=
 =?us-ascii?Q?5AhFAe/wdTG21o2L2vivwjLzu6a45RAn30BBQsPxSabkytKq1NygynqnYbX7?=
 =?us-ascii?Q?0R7b5CTb6rLnL44/fbiE816TC7J47MfKuWLryRQeMfZXcR8pVvnKbFynzOWe?=
 =?us-ascii?Q?bgpqKBsVUZOJRj5GmvCtswdZQzOHEKxBI5Pa8vRPSt9+ZjM4LUGlEO1mbq91?=
 =?us-ascii?Q?vH7RT4c1CLQpZyhigA/cNOazWnQEcLyyPiFxOjQCdQ+mRVF29x+SQoA/vPGF?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c02334c1-d877-4b73-d7e5-08dbeb4eecb0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:34:01.5425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOjdbkk4PrXMK8M26X4vPQrFw/6bV5H91oK/maL9/OQLP5ckKR5ETuLv72gw9f1Xkcqc6iVm1g6ix8gUjjSxUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8858

This patch prints out TEST_COUNT for every tests in script userspace_pm.sh.

The output looks like:

 INFO: Init
 01 Created network namespaces ns1, ns2                       [ OK ]
 INFO: Make connections
 02 Established IPv4 MPTCP Connection ns2 => ns1              [ OK ]
 03 Established IPv6 MPTCP Connection ns2 => ns1              [ OK ]
 INFO: Announce tests
 04 ADD_ADDR 10.0.2.2 (ns2) => ns1, invalid token             [ OK ]
 05 ADD_ADDR id:14 10.0.2.2 (ns2) => ns1, reuse port          [ OK ]

Having test counters helps to quickly identify issues when looking at a
long list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 93f8b200ce49..f1fc0a4f3624 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -42,6 +42,7 @@ server_addr_id=${RANDOM:0:2}
 
 mptcp_lib_ns_init
 TEST_NAME=""
+TEST_COUNT=0
 
 _printf() {
 	stdbuf -o0 -e0 printf "${@}"
@@ -56,8 +57,9 @@ print_title()
 print_test()
 {
 	TEST_NAME="${1}"
+	TEST_COUNT=$((TEST_COUNT+1))
 
-	_printf "%-63s" "${TEST_NAME}"
+	_printf "%02u %-63s" "${TEST_COUNT}" "${TEST_NAME}"
 }
 
 test_pass()
-- 
2.35.3

