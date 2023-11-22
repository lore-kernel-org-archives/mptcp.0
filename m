Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F0D4AF66
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="05zY/aQf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cs7ATyTvasZZNkkkRSEfG/6ZoVK45VzEoYFZpQLI0eA+C0hB8gVxDVXt/0y/hVaBXObaGZPZ+AYn47Q47zBbCKzO3FBOfT4JWdfieEWUtJIeh53KRNkbDL9G8rXoRBdkmuxUdTB36UUKTNcp0yPCir9Ta45/N6UO4m3hJFWVB8aSTDkFwqjEW71RTYxg36NV3U9VFMstgs72GHcW2m3J0lqVpMUsIjF7pCfvIBEzusvyvL+0x+/SnhtOOlN9iLuj+6DoGfO4g1rPsOyFE+ecadRN2SiNhsyMT7N9RdXvzOlLGWy3AxQDP6kwWCojIU1c/jiJ/wpftIYjt0O2pkL6TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FklXwd1WMO0eLgu6KcNHcczXiArb7w3mYCRLahKA1KM=;
 b=SG1u6tNywHbHab/TksoatM+X3PXNLToa3+N4OgwZK3nG/5K78O+EjYjKhawV+TDO79Q8mQteRer6NjFiNEM14OsWN+GU3eqn/YnHJt17oqbYrUubdiCsiHZm01F2atRTWHXnUBtiwtZa59sSnzlrb2R0UYd5A+mA/8NYa6eU2AJ4XSSYw6uN63D5Fq9ZJYYjkpVNWzIxQdx8ZhGEHaJJb6dvhZsOQAIvfZ+MlfVMpzuAgMzOQJFOWobu/KzDex1r6FOIBq45dVhzCDsBzq9+uHOC/jH3W0hvaY6xhI6Sxedj/OMKzoF8GtzlAdi0njc/tDXFBDJWxDghcQ7jjLSpNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FklXwd1WMO0eLgu6KcNHcczXiArb7w3mYCRLahKA1KM=;
 b=05zY/aQfoab2QHKtZMVXXlACHGAR5tywSQ764fiqOkyWne8ThsaG6bR6ucg3PwnDLXSIGi0ZTUJz6x6NRzezMhhP0tfUuxgL1pMWmvQyQF0l3p7q0MzTwwKHTIHLnG2WfTr47UIk7tFB7y2/j3sRTrPuuxL7Vng2Ht4GuzhXzmkDa5CSRN199p2pjGwMz2THS6U/0ufxjdFYZC87yZH7HdqWrnWn4GZ9csv/EEne47q2CxMBw1UK/omA9CQGiEyf37oMLFPIB3sKAFrXP1SALZPxwbK8KNhASj9K3xqBZsoWo+SpHv3noGH5izZQM0DNhrfdoS6g/t43D5bxCO5i/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8858.eurprd04.prod.outlook.com (2603:10a6:20b:409::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 11:34:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:34:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 29/33] selftests: mptcp: export capture/checksum vars
Date: Wed, 22 Nov 2023 19:31:17 +0800
Message-Id: <b2fb05e90375913fb1efcca6a759c78a1df5e068.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0239.apcprd06.prod.outlook.com
 (2603:1096:4:ac::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: a4536b3e-b31c-4cc0-a6e2-08dbeb4efd25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c2K4YPp2CDjzL/kZ4gednpQuWKsojJuSHKa1vInF417IEMY1/1ZSEzihMTsvHdhVyLOVR/34TXR5z/SdiCTAviH7RndfCWXjSvnJPfUh3T/5D+uRt5qGJhWTGNbhAlHLbDUpPSx6MgEN56GPrFMjLb6jXoNSIBKpfke4fn5VcTjlbkxgM3erh2c6uAg0ID4ensC6gZiU3G9we05Vska07MQObFDO7uwqHTOKJ79kABKUpGP0rXeu7PJasOj0F8AkVotM7s1h5FRknjflFxeNWt9BJPwoRFwZ41kVcF6g8VuBlVtA6Wdk2bpsdp0pCyI3fEcFCsajMoYOfKzvanEUuWritetEOCVAG4yqLDgKgWHlAM02wljG1JMBRPoMaHczzSlpKAedPHV9aasp/TOGxqyxw0ZayRNGauyJHkSAabTN1mjDSewRDUUjwIr2QFpAOpIdvII8FylJ0DbwzucOKGt408m52zhswDn3tiuPQjOMFMTbSm4+cb6xSieGHtNpjfxdWBF1413H1/MHR+o+CMUwRWj0DfTZi8smCKGUNH/pgx1DqpHb+fZlgAeqxBKgUT3n7vtw+B5x0/xnrcGpHjCm/uEQW1NbibenInVkLGo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(5660300002)(36756003)(8936002)(44832011)(8676002)(478600001)(6486002)(86362001)(4326008)(6512007)(316002)(6916009)(66476007)(66946007)(66556008)(41300700001)(38100700002)(2906002)(83380400001)(26005)(2616005)(107886003)(6666004)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XWZD13HqmxSuShVasG9H30Ln3w3TWwRggVTXqN4iswr+MLt4ZFctXN5xSFyK?=
 =?us-ascii?Q?fAknihiOFAvv8KsrsUx2BIH4DyCHiVVc0bUCCj3YtgwqobXhD8hhZ29P5Mrc?=
 =?us-ascii?Q?lY23bzy5FK6+QgJmMQ8LjttuMjmA55Kc2nZReBzI7Wuw7Ixk0KYF8vyzLuC/?=
 =?us-ascii?Q?frJtPYtwvEs00jn+Keiya9cZUfnHVBlhRJ+C3KcOuD//BHO/YZ3isN+b7VvV?=
 =?us-ascii?Q?LVFCgpyhvcaUWI5ZNOnnjgwTE2EQu89BjpXXt3qfqYEt4NtvbeOT/13LZZEZ?=
 =?us-ascii?Q?KXi20sBTgNsbx8WIuciV8UtEL5QHB64JhnS0ifof6aZg8mnSoMXrFUdkEbRM?=
 =?us-ascii?Q?+2X2LKvueSCUxVtFeLRsTJfhQoYb6hlAOdGfPd+wz5jcdM7SQG/7rySQE/UY?=
 =?us-ascii?Q?tLuIao3WSpIhFF5wEHibxqqSZbQmrMvhgQYTrEX+XYb0Jo4AH3jfEArD/nxU?=
 =?us-ascii?Q?Y7kkhsW2ruGeWuHEpy9CKU7stXwZEQCGbj07kzE4OUhGwkShhWDJDv34vDLT?=
 =?us-ascii?Q?UzXfBEsAwN9rEQ3RUvbspxlZagMip/8GOIKttYiyKWT4uQuQMaAertKbrY8E?=
 =?us-ascii?Q?XEEDSKPR9wsi17NwnfOyTq38ynaARFhRiz2P+JJ9090ylV+SnLOv0602xzfG?=
 =?us-ascii?Q?xjbGkoCHOOZQcIe8JbFhg30Xh6GCYIACdhwpBQzRrnScf+Yuaw6CFWvuKwPz?=
 =?us-ascii?Q?rAN8fH7re3gVKYxEiLdP86bXizvzoHVV0wsSsb4t+s9bAGcbvv43D8v3Seym?=
 =?us-ascii?Q?JUbadDfd+uSApJ39KPh2DTCZXi+uQ8M6CSVas7vCaJPVo/wNpCOMJUQz93Nh?=
 =?us-ascii?Q?HV9TBbnN6WTNiO6CiUcbylamJWl8dTVo641owIHFL07OrMp7M+r+h8loLOxn?=
 =?us-ascii?Q?E/tf6UzqvpKJD9fLGKisRbm1jSkQs8+92BY91BNpwt/g5VP+d3h4Go6L/qOv?=
 =?us-ascii?Q?/cfFCsdC/kYm8hpLKMUYlcof6gsJ5TzWXB0Y/q3eRbCJPAFADy+PZqumVVoO?=
 =?us-ascii?Q?hvGoB7W0TpKkD/xpeR9s1O/eeOoS1ol3h1HZJmLcPBcQPi+6HsH4xyqzyouk?=
 =?us-ascii?Q?Irgox6y5Rh7S3aNKiZ9txRDb1IDsJxvHi03fIkJHLOOIqirOR9qGXM+rlz5p?=
 =?us-ascii?Q?sudcIFzqlH6cIXXwbarXcc9FdZ3y6HwS8k7YwfACurH8CKly2Hkx9Fi5BVjD?=
 =?us-ascii?Q?dPfojmfdaVmPx44x8/58HGFH7/1Yf6QuyZeh+4b80PTymNac53NvbTfWErWm?=
 =?us-ascii?Q?QOZ4hrEhT8au+xjp0/x1f4RcME3lvp5vKRhGeLmBzADJ/KGQGMqn8xuPSDCk?=
 =?us-ascii?Q?hHUzhYETYzlI8EGpDAi37ZFnAgCc2cfwBJFyc7LslNzxdifJJis7OcYim+4Z?=
 =?us-ascii?Q?Y6c47mNs16F/Rg7/5JFeTv/CE2FMRONwUrNhpzJS9F3iDMF8X9fbVmRDI6hG?=
 =?us-ascii?Q?FvX+kjXbnmtP7iuZCR/oi+KfptducwZ8VmfyoSLAapAii1mEyLp6xJQuBtAR?=
 =?us-ascii?Q?tRD6wgNcxc9usgfzj/KJ/V4cDmIT8NVwD512RDWsP8BrvluqiUEw5Hq9O7lA?=
 =?us-ascii?Q?Eyh1+bXqQQwpc5Y/2P11KJw1JR56fIf6lTVD9/ED2mDR6pJMiTlc9Hy3vA+c?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4536b3e-b31c-4cc0-a6e2-08dbeb4efd25
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:34:29.1411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfQKPSBcDtoGPwaFmqip6OV7xHCVmkVU59dvQ7CeuEXPJjhz1RKoo1V7ex20HD6q46EGPeOmJX1LpGlLloGNUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8858

The variables 'capture' and 'checksum' are defined in multiple scripts.
So this patch moves them into mptcp_lib.sh as public variables.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 --
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 2 --
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 3 +++
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 1 -
 4 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index f412c6cf7d3c..6311deaeab8b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -9,7 +9,6 @@ optstring="S:R:d:e:l:r:h4cm:f:tC"
 final_ret=0
 cin_disconnect=""
 ksft_skip=4
-capture=false
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 ipv6=true
@@ -21,7 +20,6 @@ sndbuf=0
 rcvbuf=0
 options_log=true
 do_tcp=0
-checksum=false
 filesize=0
 connect_per_transfer=1
 PORT=0
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a3b895c845a3..da209af098a8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -22,8 +22,6 @@ iptables="iptables"
 ip6tables="ip6tables"
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-capture=false
-checksum=false
 ip_mptcp=0
 check_invert=0
 validate_checksum=false
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index ea04b2888bf4..215dfae871e5 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -23,6 +23,9 @@ readonly AF_INET6=10
 TEST_NAME=""
 TEST_COUNT=0
 
+capture=false
+checksum=false
+
 MPTCP_LIB_SUBTESTS=()
 
 sin=$(mktemp)
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index de897b226d40..67643ffc5c08 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -4,7 +4,6 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 mptcp_lib_ns_init
-capture=false
 ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-- 
2.35.3

