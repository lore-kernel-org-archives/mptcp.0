Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FC110E8
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 01:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AoX6scfD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VurAJQrzqlbKxhFwVOxOamOuQ0J4pLXBIur2MnFOMSyaVVD0db6Yyqm3czBEkOIYWp8RwHI1yDqp++AXkkoPoYZ+FljjudCm19H8ZypNosZufZM1eZR/j2R3OjDVJkrcXeNGi7pCOLdAeTFmK7gZE1/xaOVDM+kRNArRIH0hNzUKuXOVg3x7BgUXYMCUtYUJKHFEaUv37zN8q0L+Csaquh2O1dT1aOcuDC5MwDruHk/8iXxuXkdw8TvsGKc7v1HRzNDKUjdcnsIwEBESZfoNHhdAwwgxZB4o1XgoapdNRQFVTdaxLmMKh1Se6c2545rTWDW0zpliJolV98fg2i6QrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Gv9HIJZEzyVoCuvq0bOQPQM31M7SKLoytanobYqjGw=;
 b=gIZVST4YhRu/2plxAr/4VL7zr9/uKTTkdl6wemDwaTQc/GhBu1TuA8rwGp9++OYS/CMXX7E/xs8DCKS43+yRavL5bplGhcOcjTfyoOPeP1SzzXy1thfs9scB/qmTZ4dIwTpPS9JgHFIdrQ7R5t6QEwNk8rVfBeTHS/PRetBTzpS3+Kx+CtB6Ac66fKp8hvctXSrqULrXOnGEn3IULNTnsQ6m2bjVEUbeE02NwxY6AOKHBgkX/IGNz5RslfDhYbmZ3whKQWu3G/M3ZHunD+qSVMFtIiljOX+n0OHBz0jk7+oY9LBdSMAb+Z5NAyj3fNpmeGSmKzZk6Udyuw3rzMwqDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Gv9HIJZEzyVoCuvq0bOQPQM31M7SKLoytanobYqjGw=;
 b=AoX6scfD9/DzUREuHTg+hjSpQpYGAgxFDn2mgrKm4bg/PvK4JCi4ABg31YKSRebQk8r0QPVao7ZDXz6fin6jPV6jB2fk7zaUba/63zRnb6NGVvgHC5s6QI1jq+QszqWtJ6IGije2lel1I1F4TxkgqCj5iljzF7pGN9fog6fBft7Kjsu/ffoLmCeUmO1PZbQ0vGARgEvzBd9XA0xr5mx9NlQbVMuHXA7q9l6JX6n4vRrCac9GHORUiyS0qBiWSMdNq0P0EVeYptm3J3fz/sfTms4wGJBbuX3mrPY4aOTieuWZwejxM7tLHQyBeqAiZAg1L7hXFWlJO2linRm6QoPdiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9721.eurprd04.prod.outlook.com (2603:10a6:10:4c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.13; Wed, 8 Nov
 2023 01:47:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 01:47:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2] Squash to "selftests: mptcp: add mptcp_lib_get_counter"
Date: Wed,  8 Nov 2023 09:47:09 +0800
Message-Id: <a345cc5ff04729307b7b5b3a26f81e4e653dbefb.1699408002.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0325.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9721:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a24344-a678-4c24-e2ab-08dbdffca072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SpvyGIX6EU5skviU3af8FYNAyEKU/PYIPrpL22WsxQv7gmk8sT2TflS3INsZGp9vwA1g0b5eVcCPsgwgoqU5VW84hMV9e4qt/bR6gGwRz3DKfF4Kj4trn2cCQc1I5i/JIjnEdB5gkT7SilLl+dW+4QNflyIqn2kXgBNqIoPd5F9eDHkoMuB5YHHhBoCfr8HgeWCNuY+6dYS9U9t/wIUnuUZEThzBCvvXroIAzthcnwGh8dzStqIL/LNf3RfyCRrfADnjw9zkZiOQpbUrsfi/Ja1/tl8Qd9XTz5jrSM8IEMEW1hgSBu8yhbAHk9NXciDXC9UD/cQR35T6673MbsBB+4+/1L2jbmdVSuriYY2wabud9yNFeltocbxEKNJvZCOFhLqTtGAl+QmK2J3YWJkXtwnEI/9R85UIlAOL2dxXiqoMoIhspzJQiwKEtbdyQeVGpDUJKHnmG+h4RJRGTzyZ/bsbrEz13UWc1hHjs0OnkI3CRinnFdUNKJFT/5UCfJvvFJZU/GBxfbqEZOuSMMmU+VS0bsLutMlWA3bfrxqSddI9tiuY0rrcJRdOiMgRiwIO/sFEb5G4AqCTgJf92P2DeV+m7JTKhp2j7lt17rsKlyA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(107886003)(2616005)(6512007)(36756003)(38100700002)(86362001)(2906002)(5660300002)(83380400001)(26005)(6666004)(478600001)(4326008)(6506007)(316002)(6916009)(66476007)(66556008)(66946007)(8936002)(8676002)(41300700001)(44832011)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nCee0OvYdBk19WsTfeaTyWLmOEwz4s7eSBS7FoY2JYYLvtnnonBU9uXcMHNt?=
 =?us-ascii?Q?PI83Va7Qg+YF9jgYvaHkfhhMkb2uxIEk6u8iI0UO+Xw+uViL2Xv9sC8a98JV?=
 =?us-ascii?Q?+MdiFjYn/hlNHWh36V1vDfeKJONPtqsMBRxxqQ9yUJc8sS2mPetl/8NSjEcs?=
 =?us-ascii?Q?bD6M/2vSU7GRpn/TtlwxEiUo6OKk7A4TtuQEtqdeJCGkZYVCW8HWMMO7ndNT?=
 =?us-ascii?Q?oWl22yAnkkE3fI1B2x88DNaALNtxpZv/wbNgdDld0EspypwTqlFJJbtwCwWy?=
 =?us-ascii?Q?6WWC43xGRhKuzZH+apCN683VoQjbN2s12o5vbHKY2K77J5M9cnTHPdjm/fKe?=
 =?us-ascii?Q?ARsCKzTSKlqrqijtAAUk/aNYVRmI1snub8rsEPq+d7LIILFW7XzgXkm4KCI2?=
 =?us-ascii?Q?YtrRXvEKx3UTYKYH6vyTkYZiWLnUgfZ/IdizvaAEFVmiMEryfrZYPmRmvHE1?=
 =?us-ascii?Q?DHDA9PGXb6d2Zqapuk2b7/c+6GfUckM/Dk8PvibW58SKkhKrWY9kicYfCcfd?=
 =?us-ascii?Q?Nt3ZN848Pm3rc+j9QWnDE/VgjwlAfikK8t8jcuxdfoclvNcr5d+aktirJa8i?=
 =?us-ascii?Q?jGOmGnusBA1rCuLJGIjD6scT/CmnKfJC2wywnpriofKTdx2fmklLt5xcf76E?=
 =?us-ascii?Q?sSeDP0mpbTXPoYiMgWlc2gsg1ZMGrqfRaPdNQvzibZ4fW41xcIT7HO/olmJZ?=
 =?us-ascii?Q?gemMx/qu7WLq2apNJ70wOYbDKn9dFrNdykK6m28Z5xuYI6//tDp7S2nuB/ra?=
 =?us-ascii?Q?1/WWLGyk/n+yULWPFRU5gmxnH8zAY2QOkqwS1Y0Qu41kMIM8bY6g3zhGk0qt?=
 =?us-ascii?Q?Enjru9ek77CvfxZUvJUkkv9J8LYKWNh4RugEFLBRkjGOlCi6cCtboDDcmiNB?=
 =?us-ascii?Q?OwB4F33Q30ATAsBQQiNQj14uYG8mMlw2hGWsxiQ+f64RiTuASE01Tb+Nz3dp?=
 =?us-ascii?Q?mFEpDNp5ozOoVNh2SbZwecpapGGuPvUANYcttI7mnRvhJ+InH97x4tM46I7u?=
 =?us-ascii?Q?5kq7cMdox8paatOtMrxvGe78KNrxT1dtZlseAyzbw0WSPfnbsumitFxWF1c6?=
 =?us-ascii?Q?lcL10JxEdIPQ1+LFSRG1W/I03FFRUVx3pRJMDybCRKUcTB5hxAXCqRWx1/NI?=
 =?us-ascii?Q?VrhAP/d/DLami0gQVpNuLEnS3meD7f6yL0mhmXq0pZAj+jemc52G8JVgsdxI?=
 =?us-ascii?Q?n+Nw/EZji5kLsHU5kHVqGLh/b9E8HTOMCJllC0uSSEWdiAkQN6XaYarMPS7x?=
 =?us-ascii?Q?J6khLIeMr+m5RhV5TxmWEOICCEcvICQ3ZER6MtUvPAxqFYrskSX8jPmvloH4?=
 =?us-ascii?Q?XzpNegyz/PcgRODSrSZDdxgQbeRbym+aORL/+vuWM/BeykSBvm44QG/87dbW?=
 =?us-ascii?Q?MGJcZc182L4gvuQ+Zlp8I9zEqBAlJ58njKk14vRdhucBGMoxr+1m9EaiEDEH?=
 =?us-ascii?Q?OzzrGE+k91+Mp+3FXsd7I4z70XpVoTOSN5yQcP0dYpo2BCTVdcoPaR/sQyHN?=
 =?us-ascii?Q?m+kC2WXkLKmjkdgSSwhfSXIfxpwyWuCDREwrbIvRHfElQYAnWRb0I6s+PYu0?=
 =?us-ascii?Q?sktwjRSEEEoi8Yn9pNu5Y5tr5gjX0Y9LxZYVRULFaFle6QKplGHzCVPNPyxt?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a24344-a678-4c24-e2ab-08dbdffca072
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 01:47:12.8609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exd6rGXPniqE9ZV58tKYGmrUcbBdCCzQr7vsL4dds2dPW5/B88FTokCYjOrzzLCTEboJnl5up0z+RhlWNleGrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9721

Please add this line into the commit log:

'''
Use this helper in test_prio() in userspace_pm.sh too instead of
open-coding.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 v2:
 - add test_skip
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index f9156f544ebf..6167837f48e1 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -874,9 +874,10 @@ test_prio()
 
 	# Check TX
 	print_test "MP_PRIO TX"
-	count=$(ip netns exec "$ns2" nstat -as | grep MPTcpExtMPPrioTx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ $count != 1 ]; then
+	count=$(mptcp_lib_get_counter "$ns2" "MPTcpExtMPPrioTx")
+	if [ -z "$count" ]; then
+		test_skip
+	elif [ $count != 1 ]; then
 		test_fail "Count != 1: ${count}"
 	else
 		test_pass
@@ -884,9 +885,10 @@ test_prio()
 
 	# Check RX
 	print_test "MP_PRIO RX"
-	count=$(ip netns exec "$ns1" nstat -as | grep MPTcpExtMPPrioRx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ $count != 1 ]; then
+	count=$(mptcp_lib_get_counter "$ns1" "MPTcpExtMPPrioRx")
+	if [ -z "$count" ]; then
+		test_skip
+	elif [ $count != 1 ]; then
 		test_fail "Count != 1: ${count}"
 	else
 		test_pass
-- 
2.35.3

