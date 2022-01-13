Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6402C9C
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 09:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642066178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hgDF8RSani62gB4xYNwgT3lXjk1DtdkXos/ZneUanLY=;
	b=TfsrTsXyCat07CIKOxJY3R84edVM+XEi6gvrCvuxi/DRyB5FLTqlfLg1SG+qONetN62HWL
	gK+4F2HaIX82e4GTzibA+XaLb+2FIehERQvdxGiUHFgb+mOHTj7Z7saB6+n0SxYn1+925U
	5VXJstCP4m5C7AcPRFv1ISQZzVWew1A=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2055.outbound.protection.outlook.com [104.47.14.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-Khvl3aCXPk2K-lDBd3lKlg-1; Thu, 13 Jan 2022 10:29:37 +0100
X-MC-Unique: Khvl3aCXPk2K-lDBd3lKlg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngbvQVo4b8Sw1goUDncpt2JkgvNwbyP77IbnKWA2CWQJ8y62yoYUYlBIJojaJdxnxliBoCJCU2eB2xV0jygU3op/xTkAAzLoPLNM4sJ73ThurmVg7ZSTiw7O0Yp7GlbbJx5M+4oZ4lDdvctSbqvWa9ta4jbaKm9ve1lON/iAXmpzsXnW0FzmnjKEX+yO4nSY/LLPkEODq2MOygEHSvvaN4c+O+RziD97lXlqMx61YHDfNRTg9W+L8f3hTJjnKTewdmtTYGdVL23ot5nUHJwM+CaeV23HQbkVfCZNPfYKCXBNAA+G4vG/C34xEakPXQ9jPgs+0ppAQerJZnzKdljfHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=131jIaMkdJ3hWqyBRWcrC0FVUgXi3uyawDDazxg+Kgo=;
 b=KYss2qra/7Otu8gUc5fyUaQbNZ196HyZhZtAcEKnTU+0nBR/Kg267oj338+gD4699sahGQlQBdUglPgn9Ch3kkMr0GLq23AOY+JTZmCiMzgpQqLgKQLdn4l0+Qffl5k6K+W2O4A+UPQmPAuXP399kc2aS+vGS9iQBVcIFFrXOqwF2Hp/YERIK7Xt5+XOo3kMDzndtSlgwsuaQ3sY0bJP9AdZcIKwnXX3ilpkzFYHWGAKi6t55NQkqf3ZqtU/KqhuJfDabSbIlS7bia0FGUn1U8lbFzg2+ugyNKjb6wI+HtRPn430qiCclCJUZQCzlEJt8vKozl1rdsZhQVb3DrmtQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9446.eurprd04.prod.outlook.com (2603:10a6:102:2b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Thu, 13 Jan
 2022 09:29:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Thu, 13 Jan 2022
 09:29:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 3/5] selftests: mptcp: add wrapper for showing addrs
Date: Thu, 13 Jan 2022 17:29:04 +0800
Message-ID: <212346e3199ce09ed978a82c47d055a0f189984d.1642065488.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642065488.git.geliang.tang@suse.com>
References: <cover.1642065488.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:202:2e::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04f18131-760d-40a7-424d-08d9d677371d
X-MS-TrafficTypeDiagnostic: PAXPR04MB9446:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB94461051C88E3056586D046CF8539@PAXPR04MB9446.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Pa3whbFPrZN7pBbQ+jrNbmliCcw9QF7Ma22zr+i22qTjqMKi+Z/Ql6/7sOFkCe6whxbRZPzjj14Vpibpp4qhD8weTD54ZGJtA42WpBj/ptLsFHsyHQAn4HrMhdQJhOKl/cWAEW3OxLCnBzgTkpNneTPFiDqLDfFt4nohb6R3av2mfpTEPFMKjsmiMC62JDMdKZA9bt6wnxN8sZImalSlgZSYARwhPK+M6ixzo3FK1SfK9r0j6ff6Fi8W9u8dJWwAWcrnyAsjVVw1+U8xOsTAF5noJPHjZvYIjx8b+U3cBxivoqlOBMgsVn9aY+SnHw04SXJkBgugiiQqWff5HmmQXgr9dx3d08KSWLZEVNC15vzG4kzygf22GOCRzMwn3FszOQJckcrxg35rBvqveKsDHfAh/u2Pz6NOwTqR7mHv7Xe85+gVb9OqCHkVwgeGgCd/ExcmuShn/TXxuJMrfIM4YM0npvPDLU3UOPP6BerLelbckIGrtNnjU4SOWyf3XUhpOEGYUJG8fQo852bnkb5IZTNcxK4hOQb3tbVCjckpJD3WiXQ/6KBr0OskqzPcw1AWQMY3nXp2M5c9WeHKSTltw2504J+Rk8jIIei7hHUZsTxh8/PAhAHOcbZ7QxTmM+3L+k/4+z0eBE1YnK1JHzNXLw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(508600001)(83380400001)(26005)(38100700002)(86362001)(6666004)(55236004)(2616005)(186003)(66476007)(316002)(66946007)(44832011)(6506007)(36756003)(8676002)(107886003)(8936002)(6512007)(2906002)(66556008)(5660300002)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lRUzycOEmLHJNOSJ4bZ5ItjVNNWIImTbFUfW7btfMHatw+7XxkjvZxQmZaCj?=
 =?us-ascii?Q?pHfKCeZ8K1NahGPpwC2Ah0gFCwNH9LrDtIilmQtY49YDSdcHC8Xw0NJldEZ7?=
 =?us-ascii?Q?CYVi/oBto5MI+xKBTUzICXR08ajbvuFIn1nvCpGSIvX3i3yTWo03vcsUIACq?=
 =?us-ascii?Q?5WXh7J+2bpY4oBtPAGAws7a22e6xOnmOO4S2ctp1t3aV7Xa34sZVSgbJ4blU?=
 =?us-ascii?Q?uBCv50n7DUYkgzGmXwVVghVzMXWlYGYgj4uoQw/GUrP2huYr3zm5wCoOrnUr?=
 =?us-ascii?Q?7MvBPom6saf59jN1H4P/69I5XKSzhF1aMO4gaOKtpFQmxYIuFJKI0sqO25vF?=
 =?us-ascii?Q?xY3XCyMjyfiV1D5uKSMAqBhFDdg6uVLhr5x/YRX4cAiJnBJhFr5cBI8xIGxh?=
 =?us-ascii?Q?RKnSlMgW5NG4Q14khy3XM3/PvIcOfQuiADUuy+vv1egQU2slayjI931Zt3S3?=
 =?us-ascii?Q?HbU3mg350MLRLiU32IR65p9XDvqNVOdjhSKDT1DAbhRWl71CMptWUkRUy32U?=
 =?us-ascii?Q?1mwRrWrDWRJqnF/Vij+YRyZ/y93DPdp8dcoFfhYgPfRBKxDDV/5tF1VMAptc?=
 =?us-ascii?Q?mtfFiiP8xPf9e3nfeLTr+fabMtY0P5je9Wa5Av1HHM+JFA1Nf3IKO5F6q5+p?=
 =?us-ascii?Q?CNrKt2rVMst7Ds6bwtB+nh3cw8VFShhM/+LbqFXHIY4pqFrHiXv+/ZRQMlJ5?=
 =?us-ascii?Q?BhqWvXXKW08dsHUw/Vs+DtIRGtS6GYu1pQhPISMd6W3m2JcTe/zN4h6r24YU?=
 =?us-ascii?Q?aBRtA8c31wf0RSgtnaqATbzfCGJtbxRs1A8yh9vdk/m22oILhn3Rb0ZJj0hs?=
 =?us-ascii?Q?UYGJh3dDFrjgzAeuq3S6ZsxJSoUvgZbyrea3YMTtjeUsWwFxp0+kimZ4Q974?=
 =?us-ascii?Q?/XJ/h81BIMeMx0r30xypVcx7L9Mo5rWJ9woZn0qp+wQdSM6k+/V3WqDM3zep?=
 =?us-ascii?Q?skPUqtNVdCGej0EIXN2ZDhNEtC5N04fITVaf8pj1K/soH7nC4o7OHr/xPnkR?=
 =?us-ascii?Q?13cpz3I/5R4REZFteybjJvQyNMhJtrnv4E4qZMTyMrd0Zr8HzQkfH+zXi9Dj?=
 =?us-ascii?Q?x/Z2Nx9Anh9W5g67kI0QoLtihmyLXTxZXmuMBaT2ydOVVDpptulG+Vjx8Mpe?=
 =?us-ascii?Q?I2gkSHjs03COlBokWMpALTTAGEsn69O37m0bsaes3uKzBMoq+m2VrNjPnELc?=
 =?us-ascii?Q?YJ/JotDfvASqBS2e6iaS2a3SnZCbBq3oXQYbvtC2LKnX2qdliMMqrlIr3ZUQ?=
 =?us-ascii?Q?/12/9pp1EZ8MM9NiMsE125NaLpRRZOGgHjMeFGGxyRRK4Cr/lnpPYlK7Docb?=
 =?us-ascii?Q?YP42lNeKtWy2F3VXKjfz3oxOOabjZz2y9durtY6NjEPYhDCmchZ9fNMP8aHC?=
 =?us-ascii?Q?vemKZgbb4uhciQ0E3RFtLdg5Kh/5X9rwhWYsOYrasEksZJloyDISxDNBqUbG?=
 =?us-ascii?Q?30QjEE/zaISmTvirSvm5ZgTSpntqnDCDMrglq4N/epYZiuQakRizn6cXcevd?=
 =?us-ascii?Q?t4AbVBbSDzi3U9jb7XSFkOQ1d76bQ+YCZTBMhaOZkgm4PL1qZ+pjNBvMtTzF?=
 =?us-ascii?Q?QCLHSBlX/RXS67H8lFotjuxZmtHis3lm+ruIRPcaLRwxWfw/r3e82kaFpNwR?=
 =?us-ascii?Q?0bkQI1nx2Llz11kk312uAs4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f18131-760d-40a7-424d-08d9d677371d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 09:29:36.4533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 05Kvw1fv/io+MgqBX9DVG13kyvLctpEx8iDJoWonlLjBs3h+EDTyLLAXTXglqobD28LTcJm1PNLiZkPTldtk/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9446

This patch implemented a new function named pm_nl_show_endpoints(), wraped
the PM netlink commands 'ip mptcp' and 'pm_nl_ctl' in it, and used a new
argument 'ip_mptcp' to choose which one to use to show all the PM
endpoints.

Used this wrapper in do_transfer() instead of using the pm_nl_ctl commands
directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index a2d5cafb2174..ec86ea9d57a8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -365,6 +365,17 @@ pm_nl_flush_endpoint()
 	fi
 }
=20
+pm_nl_show_endpoints()
+{
+	local ns=3D$1
+
+	if [ $ip_mptcp -eq 1 ]; then
+		ip -n $ns mptcp endpoint show
+	else
+		ip netns exec $ns ./pm_nl_ctl dump
+	fi
+}
+
 do_transfer()
 {
 	listener_ns=3D"$1"
@@ -473,7 +484,7 @@ do_transfer()
 		let rm_nr_ns1=3D-addr_nr_ns1
 		if [ $rm_nr_ns1 -lt 8 ]; then
 			counter=3D0
-			ip netns exec ${listener_ns} ./pm_nl_ctl dump | while read line; do
+			pm_nl_show_endpoints ${listener_ns} | while read line; do
 				local arr=3D($line)
 				local nr=3D0
=20
@@ -526,7 +537,7 @@ do_transfer()
 		let rm_nr_ns2=3D-addr_nr_ns2
 		if [ $rm_nr_ns2 -lt 8 ]; then
 			counter=3D0
-			ip netns exec ${connector_ns} ./pm_nl_ctl dump | while read line; do
+			pm_nl_show_endpoints ${connector_ns} | while read line; do
 				local arr=3D($line)
 				local nr=3D0
=20
@@ -562,7 +573,7 @@ do_transfer()
 	if [ ! -z $sflags ]; then
 		sleep 1
 		for netns in "$ns1" "$ns2"; do
-			ip netns exec $netns ./pm_nl_ctl dump | while read line; do
+			pm_nl_show_endpoints $netns | while read line; do
 				local arr=3D($line)
 				local addr
 				local port=3D0
--=20
2.31.1

