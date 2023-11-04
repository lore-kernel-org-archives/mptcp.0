Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF3E196
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 00:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="pCLDMO69"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8LtZN9ZwZ7N7F0JAqzb1UPQgSyJzqZLJJPvg56hCCzmUq9cTdh5eqVDiUnNPThHOx+Xn0V4HPrh+ZCmGw4eda2zqeHAjCZ9OGk/dWAHpByDDikn6g8CTLoigwc+QSE7OtsrWbnD7YWSyVN9bxz9SaSVzp3dW4XCcicAcGAsFWsZiCD0fwEzthoIhrG0vt+/WV+lQr4Opi9PtaMUNDUJ8q9s6mVUt3Itp50345y95a5aai8ZlR4KeKaSRDuKB5pYGyCrTOiveCUO0pX29vrsHvUbsNzHlsWCivn3erO356qRDGDgqoU+557plhdKP0LH9i6J/mDlCYBNRV6E/gqBtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWIUFNR1l7bMsjwD4+3xAQdhrTrMhLH+LZ6pTPHZX/0=;
 b=cvd+RsFHRc/Tp+mZPIGnwW+T4Xo1erqz09vRCIDfS/+kox/PLVM0+D5hQsF2Lpq3klGtsDRc+h0w8WH0knEm4UoB9GNG633uHubCaNGsNNBm/GTL63vlP4e4/iF77ro5/00YcCtDa1V12+P8Y/rzD7jJ4zexgQwuYQdFKd1LnC5JY1TPTXIyh3ibZL6aU9+RWDbZaDYMoLwJrAdVLnWUhabW3IQm7L9YnAA0zbiGO6BipoW1SqeWDbRRl5Lyh503G6eqKwq5uhCvdCUobiw3XB+z1HJBmIvhDPUXIFjgVleMImvbR1Em2Uel+dp45y1G0nOUYkq8khrYNleWet+lrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWIUFNR1l7bMsjwD4+3xAQdhrTrMhLH+LZ6pTPHZX/0=;
 b=pCLDMO69IoU2tWnbzvxa9Ee0bl/2F/BRzTUYfUnlbIlnehe0kqwGxsjK428Wh0GS9M2OvK1zwY1txKdEsTuygQEhaad8wustU1jlD0S9+w+zTYCVueFY+LJMIBNt5Ro1DmfmF9SmGROiFwVToLkwF4Ske5FFsr11bxP2Zj1GpUs/tGYbs29xzoSHkSLhivff3XijCuXczfs92pwD4zxll7ZKRKfYr8aQJ3wIMLF+Rn0Vz1u7ymopuiWUfLFQSfZovfyyXAu3+wsvWt54uuzigsx4xu/L2POvGPcbu9/aY4fx3PQcmdXgxgSxYVmE1zAbM+A0+JYRhrY1fnULKOUeow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 00:28:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 00:28:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v3 02/10] selftests: mptcp: userspace: print colored results
Date: Sat,  4 Nov 2023 08:26:26 +0800
Message-Id: <6761600c8641d8fb622432e44bd0300e74fc6869.1699057401.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699057400.git.geliang.tang@suse.com>
References: <cover.1699057400.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0032.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::19)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: a37dc1b4-dba1-461e-fd80-08dbdcccf021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hmG5EaVXpXVZ+E9qGDkDKw4eUvhR4vJOqxx8rNNRCN9TAMFHBQ7ckU9KvmEeRrzCqjLMjJXUeohtEXaug3mKMb1upORY+LHi2Nxp6ckoc1iAWpREjFeqjLV8+SaZ6gWrGsMheZJ/MhXKoBpvaEziUNK5aiV7qWKv9dUiDbsmpcrYGgEsAoEYiWCRa0b9yo+pKNf9Q+UYN5yZGQ1nbeBUj22IgebqmePb/xwWof9VHekNohc6J4k9lUH8rXmaKkVZedJPJcXR2oMY3js/2yJTpOTMfeJ2f76D8+GLSYFYGu5bj/u0C6Mlhdt4HipmsKjyU2a6EFZca5k5jOQ4pZtRgDKFEIjH0DgvWQ4Fki13SbMihFG0X3TPkS96U4gZwKCs83aktSGcaV9zRmLTZI+d0I7FzdlldyNYfAAPDzd+adBTqr0RzIfxKV5jS+zbD5DpXOdVNWPrkXu6kKh9K5Purq6efble2PrY5rUmTWB8lzmMrvfWaXx1e4ybyvV6+Akey8WWvj2qYwFKsedBWQ3sQmVlYob2MoCjdWnScyxt/MLjGTkmGmQdmE3TcFGTW6gweEGVaJ+vABXlixTP7BytD1J/D3ZffLuxjXmoU9tG2IE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6486002)(5660300002)(54906003)(66476007)(66556008)(6916009)(8676002)(316002)(4326008)(2906002)(8936002)(66946007)(6666004)(478600001)(44832011)(6512007)(41300700001)(26005)(2616005)(6506007)(83380400001)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hbfnJT1bm5Nbw9V7BEjvPfrSjrufdRwcGaK2118qt0gDpnLVr8UKE4NlchU2?=
 =?us-ascii?Q?CYkZu4NLbs5uoex1V8syfApqYD91R7/nVcwK3pKCdCWwgirSYiX0RcleXhQo?=
 =?us-ascii?Q?oYaie2Z/JA5TA6chGRfJ1XHcVcOxs8D68W5HVcZSXnC/I72fZ/qMimRAeiMc?=
 =?us-ascii?Q?fkQf2LJn82ZTc1hFXOnQ8Q+WWmo0MO2w8m0tndaJ24CLxtwTvPLrdWoNYD5t?=
 =?us-ascii?Q?i7Suqkn8ewutfdu6Y3PtfRrrOb3cW+ovkjbDNGXS9cjp6HyvA+PRqWTHFdtm?=
 =?us-ascii?Q?R7xWnnIzrF3gubT6CSb9REuDBnmr7BeUEUCIaA6LjWbnfWq/pzSLo8u19nAO?=
 =?us-ascii?Q?F4uHgtesfdroIU2NfAeUO+dJnwis3586ETc38ouWy8FOzwTpftVHRdktr156?=
 =?us-ascii?Q?SEaDHnPBXJAhVTF9Cf9gRurmFmqzVRzlMqp0Z5EQYyDW3Lq6G7+AIcXMUFbQ?=
 =?us-ascii?Q?78XwIJCA05WEEZ0jPsaXorDpoCX8MTbIcpXYgpdjRYxTYvj0z4rhQ5gNzPBm?=
 =?us-ascii?Q?u+g+qtMNobRsTQ6eCc/C3QNP7y6E9F9Ral4eRGqAvA9HX/uZeJawdKH9XpdG?=
 =?us-ascii?Q?uSyKS3Wz6SCjfWWL1G4/LN2L/90sHhjAh0LkEKhCKRv/iKTeElqMpEetL5qo?=
 =?us-ascii?Q?RSuvHOZdWVmdEtsLoAlYU8LyijdcVHv7yY9QGa2NAq/ks9MEtNeVvpKUpywZ?=
 =?us-ascii?Q?K8lCunQ366rxfZt5o3zAY0DE3yH82bqe7HYsp2Y+6AB9y+lCAZBkPhnDHJvu?=
 =?us-ascii?Q?qG78CTZI4Jluy8/XnmY4gjWaPC631pIsQnKQ1FZ1LY0MDsxodDEhSkTVoipw?=
 =?us-ascii?Q?RyRzShonG2KcsYGJ+AEHBXzhwAG/yhMK8AttK+2BT1uBSiUO6pznMKjnifty?=
 =?us-ascii?Q?Y88bMMbg+XYhFUCZZUcHKHE26HoasCpVS0lWlv8VRkI95QKrmp2XgFPRa3r6?=
 =?us-ascii?Q?EOEBHWgPH3Vsk/0L6NgEOryMC9djxzj0L1Q2mbTHSHVlh7SnmIrQvf2Z61E4?=
 =?us-ascii?Q?AP8NxoVWxiI2z9AYNbIJuZbK425oxygu8GU/AGiXhiwqfpDE4zgN+sTe8qFE?=
 =?us-ascii?Q?Gz4HsbVQ6qHyZsNA7ijsIjQWTu64YbWpvv7hziX4+VfvHlZRdwkBcSgh8Ouc?=
 =?us-ascii?Q?IHikvxzR3+AB5AiNfXpvXYgBzvUpEfgzqJUU4DkWJMv54THd5CCEjYCjZPpB?=
 =?us-ascii?Q?FIRj7vFQS82e+CXBH+DZCQ1LPdnstq/gt6iE3G3axF17LfF/1TFNyk7stka7?=
 =?us-ascii?Q?eKOtE2qVI2q94bJFR2wjVm1ufeBAkn8kp9Q+jCkrCKEsOB/gB9bin/Tpltyf?=
 =?us-ascii?Q?gpn126bFGVj6B+NN+lxQT/wjuRcUk47AOmoolKhMxxYHB1wwkgc5L0y3NzX9?=
 =?us-ascii?Q?8mqFInKAAEHDZtUTaz3MGM5tDK3s7K74Kh+nZNXEPecbUeTYrD0Gk71LyW++?=
 =?us-ascii?Q?AZtq1PtcpydRvL5zCOwbF7vveqB3xfs7dBYCNnYKBXXHQLSwcttKZ+T4kvzt?=
 =?us-ascii?Q?1Vjlg1IHUazMrjw3c/oinhipXbgK1NGXfzgKkraYxWbGid/o9yfVHnpspiwf?=
 =?us-ascii?Q?EoYLEUu1/8M8k0i+0al+7fZl63OrMr3PYR1nARtL0MZsukafHNWMdne2W+HT?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a37dc1b4-dba1-461e-fd80-08dbdcccf021
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 00:28:16.6109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wKP88AMy5/DwvWV0HsYFm3FWTxF+oUtanE2kyWIL71T2ylhTjpOVD9xb9T69weng9DS2Sz0CBWqmKzyaP7TIAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989

Use mptcp_lib_print_ok(), _warn() and _err() to instead print_results()
in test_pass(), _skip() and _fail() in userspace_pm.sh to print test
results with colors.

Having colors helps to quickly identify issues when looking at a long
list of output logs and results.

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index bba42f165340..27ddbd8cf03f 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -74,27 +74,22 @@ print_test()
 	_printf "%-63s" "${test_name}"
 }
 
-print_results()
-{
-	_printf "[%s]\n" "${1}"
-}
-
 test_pass()
 {
-	print_results " OK "
+	mptcp_lib_print_ok "[ ok ]${1:+ ${*}}"
 	mptcp_lib_result_pass "${test_name}"
 }
 
 test_skip()
 {
-	print_results "SKIP"
+	mptcp_lib_print_warn "[skip]${1:+ ${*}}"
 	mptcp_lib_result_skip "${test_name}"
 }
 
 # $1: msg
 test_fail()
 {
-	print_results "FAIL"
+	mptcp_lib_print_err "[fail]${1:+ ${*}}"
 	ret=1
 
 	if [ -n "${1}" ]; then
-- 
2.35.3

