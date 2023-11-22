Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2061.outbound.protection.outlook.com [40.107.6.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CA84AF66
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="wsKo/mgr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEHhrO3y9ImlgYCUzxP9Tf7Bky8+dcDHf2fTU+6eovgBCJHYPL+x608vf5GbAK8lMO1DguI0MUKoqmiJ5UlMW2+MFFDtoyGqVZT7GqQadCUtLd12nT8AXjmbvpdntOlyUYlQZr3atYNETlqLs7FKQ+BAN6TrGihdhFJif1iabUchlQjvmFWzod34jDH3H+P72JS5gz1sto13Pi4CYrLiwPCLHJ65uSk78dGvY7C56nAOhVUDB5x+SCjrBAinapgW+OULxsCKtPHDkL8PuWfsbmhe17awSrJ/wZg8U2z92lSxASwyjMXh3AhCG8DWWPI3JBs/z82OPktvlnqJCw8u4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zegY6h/fmqcRrg/93R+5oej5y1CXdTsZnW37dwfOeEA=;
 b=AwH2RPejDE1RMdERp3U0ISYXN5S/QuSvS3gXYQR3Y/oO4n2/LqyMd5b/pf0Sak1FuqjTd2A9/fNX4MoGXrKQzeJO08vYPvjDJB+glYje20n9n5Z9pFTqU8FHSB9upHwBFHqWlluUPFHDAZS9BqTIFjnFYATnt7CWQyqe+fzN6haWptJEpHC/dzkYIAI+33mTZsF+rT51ipJNSEOGmP4Y4EtjGdTEbJyLPJUY0CL2FUK0/jbvbdoCPUSvMTRES5Fh+5c9mbWMkWLwf7GftZuqI4JPMuUK9RyMyyHCht3VzwutqOMEeTqfewRi8AqEwqEHAkKvfj3a+X9WWa7OYGKiNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zegY6h/fmqcRrg/93R+5oej5y1CXdTsZnW37dwfOeEA=;
 b=wsKo/mgrB80JgAjz2QrzVa/+gp7VNEsDJNFR0P8zWc4TPml43/Ru/fvfoMOXJyKRc0q9LTkQYGPQ5IuHyAd1fHMYOU8fpwGR+2BvxC/BFlt08XW+TwN30HXXQbnimF+ck32tSZtxw6BDYDxtjwZ31ZGkouXEEPaRHHsehmKIiYS+Af38lgtmkM4jxttBtIp9j/wHkzL6VzGkTYFV7MeFZ2AeCtH5OHgdITrw6zHJcTCh0cXOmf4+mgmD6+VisSK5qDrLSK1Yq355AtCfqwk5HCPLk4vC+ST2mbq4vR2L8SkiiqEfTROrMeQ1ua706Jr043tcyLuNjDVhY54sAyjPHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8333.eurprd04.prod.outlook.com (2603:10a6:102:1c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Wed, 22 Nov
 2023 11:31:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:31:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 02/33] selftests: mptcp: userspace: capitalize test_name
Date: Wed, 22 Nov 2023 19:30:50 +0800
Message-Id: <044017799f04e90b0863391e2c401500c49f5626.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0019.jpnprd01.prod.outlook.com (2603:1096:405::31)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: 02dbe259-7603-4759-7dfb-08dbeb4e8de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Jf/CHuKEUMJpbdx/MG5vC2LIioO34+k/oPEnyEjLVM6CudkWjF4ATSrGb90LETi8uB4E25TApNm8/d/d9X1UKzfWaMFSrmpDz1ghfIWfkWEe6AB1TejFq7pKLB4Bbp44UxAGn49RzAtbQg0ito0NI86PDBIUUyeEcxpevFTicnO7K7DNExsvysCBfg2p4oyY5hEZnLbpKxWvmUmlkW8NF1rncP6tnbSYaMN2m+FQE2UY50HVzvHmVT7w7+oSsITBmQXeDqdu8pMyqDK7mrwzBCDqdee+7O+nQnxYY2LodCq/1f0+VjcKQ0Pnbgq14+KEjQa5snZdFXy6LrbKxkXZD9yrCaV2klrat4GHCvj6vOx3AEaBNgzeVrn6ysmN+OpOq7MqXDIhlgjBhk228T5TxUN1yJ0i6xXB83Zr4/SzAnwmg23m6Pay005WfY11tJ1XOUofP4AsNRUzyvYfwdJM7LgbPPYwKu2oTFYdEZli/MRSgY6H0O2kziccas4hVTotE6r2njesjEdNNEQQkh3t2uTUzg4Kp9iBa/SN0DYNxYfupjTHg6pEZB4VG6V2bWRigtrAqnY1sFwn1ETTzVmuEkRrmQwAKSjKl2otoifKk+w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(346002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6506007)(2616005)(107886003)(26005)(6512007)(6666004)(316002)(6486002)(478600001)(83380400001)(66556008)(6916009)(66946007)(66476007)(44832011)(4326008)(8676002)(5660300002)(38100700002)(86362001)(8936002)(2906002)(41300700001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qQEvHn6YhSw3dqJ5e8lwa2atd/A1n5vJcyEHiGtY+4+0JuTkFlibi8raRC64?=
 =?us-ascii?Q?F0xsz4EARPrPap/WX/Igbt8l874CY1ZXHJ0opTXJE1znTNQfradMSnljOVt+?=
 =?us-ascii?Q?wTmt+9WUBEw2jrzzVJh6rq54EzVSISIdwaFCPK3xa59bjAtG9n1Kk2jPlwrr?=
 =?us-ascii?Q?DHa/REtQeGU8k2u/aIjQ2POlFaKekzU9n1RMYxfYt1BrXCARtEBwdwp9etWs?=
 =?us-ascii?Q?/u5Cz8ECzKrBjgtwtz1FaVAYrD0mdAAUICxCGFXzAgydcceP2FdPwjaYCiil?=
 =?us-ascii?Q?8HL1WuYk6G74F+QBzb6W9+xSIO/2zV+AYdQHodk6tRfxC7+6zrGEVfp72Ksv?=
 =?us-ascii?Q?T8nx1+tszQzC25VaI1dL8FZIU7P7lDsghrrDKHPlLM/UKiKuX+4AyA0+qkcC?=
 =?us-ascii?Q?A4K3yzq7I6/X3rzL4aFWdYbj4NBHlQNgLs/d0VQtxXDf213a6SGvuMNwEhyf?=
 =?us-ascii?Q?ALDfAW8H+XG0dfOe2rycMjbQgL5uomQ3Kd4ReKvIRz4PCsv36Yz8ZHPk5kaM?=
 =?us-ascii?Q?XJSjfQHa0voxev4e5bfAGxt3tXnP5s1XKm/Henp6SvPBotWz4uo3uBPswD5a?=
 =?us-ascii?Q?nQDuh/AalvCOFRXxYQxNgdTE+g6cAq2jJt7uaipMhnjkXzeLs5BUPVHiBQvN?=
 =?us-ascii?Q?t92ZGph+JeJEgjm6u4/IDbIYYO391qagztI0A/AoANpTIvJqfrne24rC24mD?=
 =?us-ascii?Q?B2WUXoxucycDh2ckxOrz5lxa4SDLnwRDqfWewhTxC90n/hmjbYTsob3OQIgt?=
 =?us-ascii?Q?FoeOVksNNfMR+KhvMuueiCFS9E0c2Xn5QFgfN95WKTfiZu0aNRKs2NVqFO4I?=
 =?us-ascii?Q?PKXyqQf3oCvDM9ajDbsd9BmjaZOAgg/vd5mBUwh8y2PMNdXdgkAlZr3t5Ibd?=
 =?us-ascii?Q?6s3ok/av8gE6We38d8fIRFd9bNn5sOFBKVJ1+sd4GZhHMo++/i6lBL+rjzUZ?=
 =?us-ascii?Q?ChVLlGpiu3K1/nqAerpNQi6ua0vG0VOFkd852eLTXViG9X3u3PcB8/Roivm6?=
 =?us-ascii?Q?xanhYFltRbTz8mcl7fg8gDvvBlWoNDS/hEolUWUaobguT88cTegNhP0/Jn0o?=
 =?us-ascii?Q?vyX3DK/g+isZNv90Rfb8fMLVShEPLuuGKJG/AY4xbS9GQXa/geVa7jSpkbxW?=
 =?us-ascii?Q?eiA/SbpA0gMbTfDbX2clOA4KAPVh7WayI6AM74hrKgEYfWbJufJ032PCJuNz?=
 =?us-ascii?Q?VqHoXBmx3t2gGfh0EAr6JjbjNdaVhnDO2DuOLj1ywsak483UODJA24CUBPcv?=
 =?us-ascii?Q?3+KRDTuwT17GonEJWJd3VLFx9E2z+507jHqSeReLfbq7UCLgKm1pK/5inr6j?=
 =?us-ascii?Q?Pv8+q034J5Mgpohlq8RP2hLn6YbFRN8gG5Qvswa5lz84r2PJejdNb2RSrJ0l?=
 =?us-ascii?Q?pdbBK5g61OdekyAOoE8PG2C3WgQ65nPV65PF23CSUhdCoLE4CM4sxO3tePqD?=
 =?us-ascii?Q?IucKiaaBPSfdLCsVgNTtYyg0d1L+LAwZtltlXsatCA6LqxfTAKt9pyNPQoUf?=
 =?us-ascii?Q?qv/les1BVRbjvbhbB0qoMGB3FdkyABlsizTNwErpi2+c5AWJ7bjG8E6/paaw?=
 =?us-ascii?Q?FKXDyv2Di652txeLl+t67THfZ58SCdUt3h5oU1bD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02dbe259-7603-4759-7dfb-08dbeb4e8de4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:31:22.4816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nn6dyWE5f4/RuJzgSKlQ5tn32zJm25V48uPCJPU+nRVT+M5O4mqWto0AocEA8R9u++qpf/9Dg7M2JQIJfrPQ0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8333

Most scripts use uppercase variable TEST_NAME, but lowercase one are
used in userspace_pm.sh. To maintain consistency with other scripts,
this patch renames variable test_name to TEST_NAME:

    test_name -> TEST_NAME   in userspace_pm.sh

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 55ed3ea0a691..f1d5cd4ab95a 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -55,7 +55,7 @@ rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 ns2="ns2-$rndh"
 ret=0
-test_name=""
+TEST_NAME=""
 
 _printf() {
 	stdbuf -o0 -e0 printf "${@}"
@@ -69,9 +69,9 @@ print_title()
 # $1: test name
 print_test()
 {
-	test_name="${1}"
+	TEST_NAME="${1}"
 
-	_printf "%-63s" "${test_name}"
+	_printf "%-63s" "${TEST_NAME}"
 }
 
 print_results()
@@ -82,13 +82,13 @@ print_results()
 test_pass()
 {
 	print_results " OK "
-	mptcp_lib_result_pass "${test_name}"
+	mptcp_lib_result_pass "${TEST_NAME}"
 }
 
 test_skip()
 {
 	print_results "SKIP"
-	mptcp_lib_result_skip "${test_name}"
+	mptcp_lib_result_skip "${TEST_NAME}"
 }
 
 # $1: msg
@@ -101,7 +101,7 @@ test_fail()
 		_printf "\t%s\n" "${1}"
 	fi
 
-	mptcp_lib_result_fail "${test_name}"
+	mptcp_lib_result_fail "${TEST_NAME}"
 }
 
 # This function is used in the cleanup trap
-- 
2.35.3

