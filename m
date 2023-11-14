Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D871612A
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="rf1aAw/r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQ4VvRXcOVpLuy2v8cDkV6RYR6MqRkaT2qItKoS5R8uJcBgfT1YPxgBsulaAMHZJ1KIhPxp9hWik7JpC1mrwkpIAIXav5+bSDbYFWP33Od4p65Hnjz6pQOukDbRjcn1Ph949chNmkb6AdUXFoNbBova+N7JlfRNzp4Kx3rRc3N74Ds00sulQR5wDT/U5mugTN42SN6RiERzb8IED8dgg6JUp2aNWcUKah8kaUT0Artj4NSZuoVNOqwzwWnX6Jg82bCbyQHuzNR4qmEoPNKcODx0eL7O3sCyLYBUhRcgQ/SPJMTreBWWWzpbR+cPWY2EFQcStzoQym1obUVaoUgGrrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMWyzIRgTveyLoMGLF3s1j6KGJf1VZabkqUcSTUPQ5c=;
 b=dgkjlJQzXb+bGkNdXvogL+MGPEiNhnH3OCVVZkR3xwoqaGhDb7ImCwflSt+T+JNQUTyP+b2yei4Bm2cpzBBJPsTfa8MZNF3vE0goPOlC0p1Qj/VhjGZrUkyYwmEQyOSUectXm1gcGdA93kz2Ui+Izr+gnlnx7pL12xws0mz4RdtJfGPJa+EigsWOrZI+u/PuLEotSuh3cUrMO6wA4BZ0SMqrdRaytpZ+leiJOSX2PRpywCn52HOdGyYoQYuMra7FZVS3lhQEa0D4G0bISw5GGOw0rMmonI7hjAnZWmf7kIGk+JZIqJl807c2khW5Tu8MEdbbFSZmZh0ORpKjDfgAYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMWyzIRgTveyLoMGLF3s1j6KGJf1VZabkqUcSTUPQ5c=;
 b=rf1aAw/rkcNmUdHPYg1yvlfmZ3Z9yZ2fB3cHCkBGUgVryTIiHLvPilNd7HBeyMavZ/QzBkVuQSFtV9ufJNKTER+JQ/LaUnefLvZ9tQYfqTamQy0UGKzhzkz06anXYaxU4Qa8N4jTHNxd0FQP0y36oxYSJNrk04T0lGd3XEkSjp5r1xRxUpJKx2/mJH0r3ZNzc07eI4vVrUTmoNNB5YAUmgQgZUiYGXiTCxI2+YLkT7fm/TDPHij6wCwh4TXhYIEO/3fxDZcZYGuzsU2jDnLJDFaLN7P3ahjkuZ5vavfd1d5Kz7bywm0apCMRoyxpmuvwvl9qh0zkmMuBeWMlsdUNhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8932.eurprd04.prod.outlook.com (2603:10a6:20b:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:40:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:40:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 24/32] selftests: mptcp: userspace: print out test counter
Date: Tue, 14 Nov 2023 14:35:43 +0800
Message-Id: <93d0892894d965265aeb963f1e96fd65b44a9a12.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0254.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: 2675f5fa-ed1a-41a6-7f78-08dbe4dca81f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G1lpTQOVWlLUTPnfmIk0SW63BWZWlQEGIN3iPamG4FMddVle/ONzsjizWtQzmvRNpdBnjtjkKeW058Sz5d4TSPBOHHikY22Hh4L9lFR8daluGLfWY6/SKk3RAbsK189YcKYurE+qeAUqoPZhFWZXk9hbMGYdgSP9p7vGAByRBV8queB6x5QegsYth4GOQJwj+gjEjYy3K47ocZv2a8AL2h4IlWZa4RFcYVka0wa01r/SGzIet1+WIUKv391gR4upHJ7gJnl8jF56WtCXhpXK0QKXM5wh2f4qtYkPJSKXmsSy/7SRXhSGncATeupc79XkhITrDUPdasypK60gjQ2m8bkg44adAVGBySe4vJVUb6t0RjB8ZEsPeQtb2cSdWz0CS/cgIIxh5lvgZV4dbJtp7btNTjeSiQTHO3xGw6o7vyIhPV67B7nbWJG3b6ETNzjhXShtOxo7hTnXirqqQghob3XRBIeo7WoJni9agGB3/egqICpOL7jdalmDPQuUhQBl/z8yO45jG51XOFMtkk99dF6/pJWmRowJx+4YtWwmoKCIZoJD3veKyocp6lgAFSNE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(107886003)(5660300002)(2616005)(26005)(6506007)(6512007)(44832011)(6666004)(83380400001)(2906002)(478600001)(41300700001)(6916009)(66946007)(36756003)(316002)(66476007)(66556008)(8936002)(4326008)(8676002)(6486002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oLrRaQhmPt6tcWb1LaPMoqlt7w3TWRiiowh7kN3GhhqpVGDNsyYXtMIeGjUu?=
 =?us-ascii?Q?57eTMkdt3+YVRkiSenU80eZ0Sz1mPq10iqLmXan+4F55sDLGOP3vValhtttK?=
 =?us-ascii?Q?u0OTR/KHsKr/jL/zkPI1gfk2Foq+x36OHKbmCNAhQgl/CznxvsTK8WvceLCY?=
 =?us-ascii?Q?CjnZqx0WCazuwbMzRlSzfXlhHJFatDTPUCmOduATuy9M1hk5US8VTzRT4+xv?=
 =?us-ascii?Q?4ig1+Z7rvmT24tWR/xKi+80/mzLjYLIQHvOyEz3mYNYgkjJZPZGeWvuojNoy?=
 =?us-ascii?Q?TksWVZRbEnIKUB+52gbWGx24E0QlCXEKRJFIjByLwtFKfT0WvkSIPymWduPC?=
 =?us-ascii?Q?BiRllaxzMVqsOBRgV6JQKsh48QhUuiSDRbG1smTS627fzUEowuWzGi/P631j?=
 =?us-ascii?Q?GEqI5td302gXWCDL8AJbHniVbMKrE9e6aGvkjwD8oog7ZCcQTExHL0NZvDy2?=
 =?us-ascii?Q?qp5ECX2YWxqlkokZ6BCkLENhDTntBypOZm3PZUKeplisbdUkkDznakLcQvP1?=
 =?us-ascii?Q?n6aRrqs4L7Tvhm6LavvTvAMSh/3zh2ohMgwZ3+yM/byMpnAZa7lcQEeshBO/?=
 =?us-ascii?Q?7TFgzXUx9MSHZt3qKOAE3ZLzjKkVvo/mvR2zV7GQyyuBF9TFMYLbnlFk3wKH?=
 =?us-ascii?Q?lx0H6ctKt1ssXDCwiLjiH3EbtNfu/XAGPal9UqhhTBoNrCSLFpBUnL0uQDuZ?=
 =?us-ascii?Q?xplndsVJUlBuDPD6fvKUhF48F7ZxxPyvb7GysvLzFDCufBWUUhltFV8+NWfe?=
 =?us-ascii?Q?b07d4hvrD+BsPouUL6D6fl5a6MQ2qeEfh95rRJx86GF3rTnb/tpAVOr1Wsf6?=
 =?us-ascii?Q?/4iBiL76p9+k8gdd83yEdMrwTP3j6+1UB85QXlKFVzrcRWu2dJ858Wa9afQ/?=
 =?us-ascii?Q?zkS378TBXk8y1jPxg64P1iwRrH8ir4o/XQcU+pLiHqOM35VBFyjNi+UD0X0F?=
 =?us-ascii?Q?L8+nLf7cVh1O/yFKtdpJcqtUUo2Cgds9ZBq4iWNaaebqZJfsF/mXjBpmw9S9?=
 =?us-ascii?Q?MGWu7ppsr0IngVATSUdlAr4eC1fv/bIL8dUg8GqfX7yvXn9umVq9InpiHqxw?=
 =?us-ascii?Q?A9aw5n6rnEKCr1zqO1SnWinzslcngsdLb/UcqN3etTatUfQSv3ZB6AT50Iir?=
 =?us-ascii?Q?Fuc6E3tdX3ePyjutulP8tFqg25Rs8KG1Ctyln9ZpKjM67hmiuXIDjiJoj5bC?=
 =?us-ascii?Q?yz5gvuhG0T6lFdslBlgyZD5dn1Kyw7GkBp/xruifSflQi6Khstap0hHHsi34?=
 =?us-ascii?Q?C+biJFH9uxSz1+vAbs4l+bOfTdqwCCmlibeDrOEFzqU3i40SyAy7e2WdU61n?=
 =?us-ascii?Q?UTolIfn7nmZrQXIoMPqfjs/doQilBdXeyb+VX1OgOhzqAH4lEdsDidvv8OzL?=
 =?us-ascii?Q?/eJnrSTlhdHUbmCbbHTPeQ4+y/Fd1m7JHIrkOhl1PMo+tTUWxVhpMpAWKgtU?=
 =?us-ascii?Q?OIvOtJEYXqAGJJICG+Amt1FBn7uRjkWaZaGn7vA/5yO8pqwxit8bL1O7t4Q4?=
 =?us-ascii?Q?TnfbK97orLhv9Ugo+UaypR/K9wouh2Q5CWmbbRbtIRfypsEUu12rESy9ez52?=
 =?us-ascii?Q?p+frcFaGOrSbWUvOXe0AcXYlZJha0anaAg3huoYw?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2675f5fa-ed1a-41a6-7f78-08dbe4dca81f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:40:56.8819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i5stqYgDbDg2XPFnk7mSvf7FizH0yhnC6/ghi3TQzYqxGZoT/RxWOyt4F0IRv7ZbMuIgEy1FadaaqPWzTVjgJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8932

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
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 22a436c4a77a..9399dff81dd8 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -45,6 +45,8 @@ client_addr_id=${RANDOM:0:2}
 server_addr_id=${RANDOM:0:2}
 
 mptcp_lib_ns_init
+TEST_NAME=""
+TEST_COUNT=0
 
 _printf() {
 	stdbuf -o0 -e0 printf "${@}"
@@ -59,8 +61,9 @@ print_title()
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

