Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2045.outbound.protection.outlook.com [40.107.15.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DECB566C
	for <mptcp@lists.linux.dev>; Sun, 20 Aug 2023 12:07:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1bWTVztvR93nSM0IjM4atWuYeaXwxfBVUkUafsQdzVdyE427R09WQEIt10cCazGvsgsjvuEOuM8XD4BJ0iRn3p4GA08tDln8WmL1hzYJ9B9txZtOIGHyZK9sm/7UljFi67DyWG6jfbzxsTDOq99Q/gP3Qop5MSRDvKm6lkfn0ZVyGMcgwRAV8yzWfIG1Boz0i3kGDNXqSFpbDgrYV6Q1sMOPIOztojNmuYAMPM8HMNH4Em0vRLKY1mxa8znoBSbqtKn5cPPBGtdnZZybjfrJP++BxD/i7Y2P2iUci1qaxk4MW+d0zxgqRYMfutUsUsvuZE6pTi7sDDAaJmRDupsJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jp5PPt3WXGDG4BAEGTWJmK1DsCudIJM0THHXhQeWWTw=;
 b=hrvpRAyggykBVNSDqCEOIZ5P/1flIPSb/uaJJ07WRT06jYtKJxRyezBVL050IiKxbiMoL8+AbifIhrVzn72ynMzjsLnEsFovy6c5T7B+h7tOLMdyXsSOn6ZpiXtS1y8kPwhhDAi3XdQVHdc5VM/zwcHUlwHixylcUGJnWxl61/Unp0Hz1TBEqRxLDIi1lbJ+o0NAQ84DLcayS72oDVu82o0HxcTQyqwxJFXYIJLRLwYJDOoKGo7oSEpS08wuE/rhGiLluTePcFUNMVSqJVLVkaQGYR6ThLKBh+8gFOGyB+75oa7f0ShCBMqSMhkKjmhK/ajt+nEuntc53DDXOsTK/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jp5PPt3WXGDG4BAEGTWJmK1DsCudIJM0THHXhQeWWTw=;
 b=0FPWqVnk4ysNF89+NUt2xPOkjF46BLgkAdRRimcIoxaMqWwSRmMDAZcYF+OqXncyYTQeU7BZbqTD6uPY5Zdyn04LIfuvt4nimnX+XJGLE7MJDE2MUQTQ+lkcXovYTNbH8hXlw1F1othVN95ddkY1Cr6SIpT5P09ITk299LyCFvkgOMr3K9A9sgJwfHHKpabRMfSEp/9OVH6HkdnsJH+ml0laQKpZDaCs6VvN7x0xjPHc0CrHYswTe6iXEXPXbvzKEbNIIuODgJLTTxrGdi9a1Y/bJf7A27jcwl4Y2OJV1X6ktYpY0jQaT8txdrdMN48ZHdsxwhzkDbYS/I7ovyMCkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB9523.eurprd04.prod.outlook.com (2603:10a6:10:2f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sun, 20 Aug
 2023 12:07:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Sun, 20 Aug 2023
 12:07:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 8/9] selftests: mptcp: simplify checksum_tests
Date: Sun, 20 Aug 2023 20:06:39 +0800
Message-Id: <3e8a1da2d8c25dbcfc8c741a85645421cb04a91d.1692532859.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692532859.git.geliang.tang@suse.com>
References: <cover.1692532859.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0131.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB9523:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f5a878f-e6f5-4bfb-b468-08dba1760c6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ijOjoQWZKXmXw5gEbIldKaZ7u7aS5hHkaC1410IsN4pRaltY7agPq3VXvEHUi0IYUNeOFyfA4R7Hi+44RNKxSromKzP9JR1TkBw/oGOQdiCRO8yZNiSGxH64Df0GGpl9Y6GCKQGSX2PSDYK/NiAk7M8zbt//aEdRt4dzvEbOIZgOu8HqwhqeSmIQUiJOsJLS0abjtnw+xZgJdhyWa3oOrVZbmj8GmnzJk3kHoUskkeD6mb1SDyzNufhADLYwUGLh0d0YhEvOE/4J/4L1DUUw8dgrMAEuGymbVDhH38HlJYAz7yd7OnDdsM6Sun7iN0wi+ymY8c1u+AfDZcfm8dSC1943Bowu9ZxMSxk7b33kCMYXjkd+v/PaOahKFl8RIT4gzTavy3Xi70QOVvbezyr62RLEv9C9Ra/jZvuFlQCaqlnSKd9k3ndE4yJEUpGpBBoFey7LNS1YmDNBnxD7Tt4r4t+DIF8FnfXHrl5erlxgPhfKhyDgHpFxTg4QSOek4x1Z6dSsGYQ4BZc3WarU1dn/ZdoY7sUIw5c8FU1UqlEgKEDw5rMzZ2K5xXShK2lgCLymgYGTCnPg6zMVoecH/j4djGsA6k4Ve+DYi8SjVwvvREo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(376002)(396003)(346002)(366004)(186009)(1800799009)(451199024)(86362001)(36756003)(478600001)(66476007)(66556008)(66946007)(6916009)(316002)(41300700001)(38100700002)(6486002)(6506007)(26005)(6512007)(107886003)(2616005)(8676002)(5660300002)(2906002)(4326008)(44832011)(8936002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zfm364qHxEbEzeZmNRzQFzAE06EQq2I/MeHZFVAf1o1COTrKiqmVlGpIDVYB?=
 =?us-ascii?Q?5svJXSq0nvTlI7Lc0Ntznth2p0bNdcZIKebR9QaH6pPxokrl/LINWsuv46hr?=
 =?us-ascii?Q?axS/1lcAHSlaZG0BBHBl7R8Qck+gtwkqmSOTee+lIPvnzo414t7+RnI17Lgk?=
 =?us-ascii?Q?fuKtkF2kQ7jYOCKQjkJV0xhY6IwbfzyT4dKf7es6X7QO/lAG/Sjiktre7Ap6?=
 =?us-ascii?Q?oxRPwMJoy91la8K2qJAIJ0y3jKuAfK0B299YBme7Ge78y7kqT1uonA02pdhc?=
 =?us-ascii?Q?Am2PWwOzUTl8RT6+1PYq4BO9a6DtIGaN5JlQ5jHA8WkhEW3At/HE/8lVL4yp?=
 =?us-ascii?Q?t3cBWHPYIREetekj/IuHyrtrf+3r0gKxXXnjvoWBsECBRO6rQUmHaDXbv7aL?=
 =?us-ascii?Q?ARUWRtIRJas5lYW5dGHfttA+poe6PJkfPbxfPs8Om/k8RKsh7gOa0y13jwO/?=
 =?us-ascii?Q?HPZT3E0G3lKMSmc81bAtGFJwhSBryzjwPRMh82+HyUGKVhX2HWw7m9ZV84Hh?=
 =?us-ascii?Q?5vaFDTFXhbG9ZTLdLHWAO/R8gaF+PAg/uyeX/UGY1hRtjqzDPAwojevDAJCo?=
 =?us-ascii?Q?84fdW0PXarrBTM5w+dViX85D0CsA7TIDlin0vVoNNfKUqi3k+IMaSTlUC5rP?=
 =?us-ascii?Q?shaPq/fqd4a96PGdDAznqlgeeMCOCd5sLdzjkWRnb/Kun//XVTX+33LcBK5c?=
 =?us-ascii?Q?2VltDm7fMe17MSFuoRyOdBVHYEq0yJwlJZmTKmJPewuE2JAKkXYv8zfjVYt0?=
 =?us-ascii?Q?hY6cDIoh6VpmkfJgKXsGQ0GWTJX8ZyG9js864H3NOQ8yD+26eJOUsqthAzzc?=
 =?us-ascii?Q?S6FyrzIrHbYmh2K/h9fXyvfzDfYtZVM3c37VqKDQjpM7xZCpgSlneRDCIEiz?=
 =?us-ascii?Q?wiG6OILIMWpxohrLdIO57TV0nYu1eWpBpj/Tc9mA0znAtMqQ5fq3m2qUhJH9?=
 =?us-ascii?Q?eNpNAXsiY06oZJIt1cj5sCKNyVkhTu4oZ0oqo1Sn+EDDivybi/kj+4NShRRQ?=
 =?us-ascii?Q?QqNsNSlLVWQgDlRGeDay2h4q4uA8j9PNsrsc5KX3QffY3XTFXQ4NnVoZzA5w?=
 =?us-ascii?Q?gSjdpXETPMJ7M98l1STckualYYh40AS9TEUy18luLu4z1eK0urH/XPIU6vAg?=
 =?us-ascii?Q?WJUIfXXhOkG8Jx0F6Qv5B3ANhBfvWMFxmRQZY64onaBPbi3BvkfuKEj3Bdd+?=
 =?us-ascii?Q?KTE2zX6n3q+AFe90PRkZFGlLpo6C59J/klLHtxORz1XFaSJYq4We561V1lYu?=
 =?us-ascii?Q?YYPQDsOJ4P4o/7B444oZ7WL5z3p2LVgApRCKPPlvktPANjLVM4aSRK2PXqQu?=
 =?us-ascii?Q?n7cfITf/cKIbgS28A47aC+fZdMP2z+162mOMb6SwXG7wp9WHw/M13WxwAla+?=
 =?us-ascii?Q?2eyFDV0jvdbDD+bmG2nB3o4EeCfmoB+Ct9GXOsCImit4e6yBSqPpfMLDkyID?=
 =?us-ascii?Q?CqDVVHD9ERDM/30BKNw49m5QsDjMJx9E6NxQb0736ZxMpf94JF8pbO8HhIce?=
 =?us-ascii?Q?fEyqmlVcs4tsBWF8x8pOYLg4gnvZSFKBZfaR11ugktBje8NgSuAiwlfFF1yw?=
 =?us-ascii?Q?RWYMM47/3rWiO4O6MKHmB2xVepMpNw06hvb3UvMc?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5a878f-e6f5-4bfb-b468-08dba1760c6a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2023 12:07:39.0549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdsOrkwZOx8/GITEqcLlg0rFT1B1KnfooTfPC7izjOWpqNfyQdUjII0Uzdyso5fHvuzwrlrV1inUB1xldwopcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9523

The four checksum tests are similar, only one line is different. So
a for-loop can be used to simplify these tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 40 +++++--------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a4012e09728d..df9bc6e2ed09 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3029,37 +3029,17 @@ syncookies_tests()
 
 checksum_tests()
 {
-	# checksum test 0 0
-	if reset_with_checksum 0 0; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0
-	fi
+	local enable
 
-	# checksum test 1 1
-	if reset_with_checksum 1 1; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0
-	fi
-
-	# checksum test 0 1
-	if reset_with_checksum 0 1; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0
-	fi
-
-	# checksum test 1 0
-	if reset_with_checksum 1 0; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0
-	fi
+	for enable in "0 0" "1 1" "0 1" "1 0"; do
+		# checksum test 0 0, 1 1, 0 1, 1 0
+		if reset_with_checksum $enable; then
+			pm_nl_set_limits $ns1 0 1
+			pm_nl_set_limits $ns2 0 1
+			run_tests $ns1 $ns2 10.0.1.1
+			chk_join_nr 0 0 0
+		fi
+	done
 }
 
 deny_join_id0_tests()
-- 
2.35.3

