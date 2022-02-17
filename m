Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5011C1FD3
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 22:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645136597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XPr+EJkNQ/34SiZCOJDQtEx1md/G9vgIF+3XXqD9ZfI=;
	b=WY2YpumO8xK4k8YrlG+LNmBPAoOJDyaB0T0z7H+Zs9H2tjxOzD5CQlJneCleNiTkoZ9zYA
	h3PZzdHXsB/sgeiLTffFQvPectjd8kw664rc7I9IBFkPw7keep8hwmEhFAsJIiAZSEXs92
	ETvpMPlIjK/jvG0nBTe5PF/FmVKyad0=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2053.outbound.protection.outlook.com [104.47.14.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-pp8YnkJOO3Gb0tBL4mTF9Q-1; Thu, 17 Feb 2022 23:27:34 +0100
X-MC-Unique: pp8YnkJOO3Gb0tBL4mTF9Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YF8u7AD7RxFSVepb4d6Z0pds7+s03zASVztp4ZS082GZVjGQ8DCbBXenJu2mLx5lSITHG1x3DEEQ9VKkTjENEZleVUvwq6hgai70mzjUSwN2ldldSIzKse27+S4P8ni4aAyGtK1+S7FW/9ZNs+xTdmp77MTxaqLW7cdDHodk7A71f6IP9Xmv2B8vc5pWME1QFJSAOCYDgNeYlJMtkfCS2VH8QkRiCmcZEdBdefzD+jeGkUXlx/4kmoSj1eDSBWrhXVr4EuvPzJoQaYwaQ2hLyksOyxD7FO4IMGX0SMmwLAJcT2I2mPx1SoYWN1/Z7d4EIDb2GKJXtjEfQexpYQ9oeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oBYppPHpqMMAMixYdPgtigisLfCDIu4y7VHBoLKXHk=;
 b=nksypDt7mshVMaqKp5udIuvq9YFtTYkYZdMCJalJZYgtpB/qJ3dKgCJhg8tIECLeqRPfz1lQCESu5bkoNfU8cfzn3vAO2pM4/GR1ajY8hYfPhmBNTH/gC0nxgaTInX2Ezg4lClMH1yWUBYHvPftsqCFI9quOfLHb8RSVym7dIrwGuHK+0xv/tYRWoGXxwA+m1e9AOyXTksNj1gjj0pV704x4FF9lCO0tUNbYYxwqBYV0w+r+GepKWncDR+3qfFwWFHNX1dntBAYm/d3BIyk/pVhGH0GAu+cDPc1GSnHFU/C66ZPXN+nix5MliwVlO3Db5mkjHKncmHrHqdMioWEihQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB6315.eurprd04.prod.outlook.com (2603:10a6:10:d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 22:27:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Thu, 17 Feb 2022
 22:27:31 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4] Squash to "selftests: mptcp: add the MP_RST mibs check v3"
Date: Fri, 18 Feb 2022 06:27:56 +0800
Message-ID: <963f2f26574e15433cd3f50087c30599474250cb.1645136543.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:203:d0::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b70a2006-30ed-4b6e-dfea-08d9f264afcc
X-MS-TrafficTypeDiagnostic: DBBPR04MB6315:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB63157DB99EF8EE735AFC5CF4F8369@DBBPR04MB6315.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:213;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sYWF/OhNv3NfXGOfEXibKrxyoXXBmVLnYyQ5/5jKsjCv2up3we4eo6gNYsyn++ZZdgMRc8WECxwUTDGxjQAx8O2XaCDMarPzE/WzAdGEF8LhMwLlfQCHZpQNpZOPR1fPRhkWT6j1ZzLpupnO23vYd85tp6Vyi3ZJ/f0kG21ASkCvC3VKg1Bu0AvYLu/8huXT24sDejSn+uZPRcZchg6Mjz/0aM3xhfFNeErjDp9p2IKrC89HoxIpBdH5S1k70+8rct0YSHE0tbBKdtqaC5qj0NIkd18+8ZQiDXtRK7pd043Qc+XKAwdmbPe0IW0n7wVeYGOtix/WWEL0msEuky940Un/ZcNG24YBBuEF6y0HF8IRRtedxIN1y9Dpbr/9gGqTrwSMGlshh3BzM6ufEJP2Wz9Rp1R6hmUuQPBRqLZQavfvp2Fni34YUxf1rUIcTrzcsloB6QVz7sg9pe+ssL0RW+XBXWuHYLSvjUpNU2nS59EBCLrvFWQdh9UbZErVNUMBqcIlWa6+zEW/RG8bZe4wbgtH4w+VqFZfqnD/fcyYccTb+K/aE04cVtVrT9wtlY7TUKAO72/LKU2PEdWypTt1i/+xI5xP3kN0PFtKYCP6eU3WLZ54sFxR+PHncCJaNehRss1+Af8pcVCh+nGkdgeNUg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(107886003)(5660300002)(8936002)(66476007)(8676002)(2906002)(66556008)(44832011)(4326008)(86362001)(6512007)(66946007)(6506007)(186003)(36756003)(83380400001)(6666004)(508600001)(38100700002)(6916009)(6486002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Iuw1a9Ni49Xcyd2Or+8n8L+q409q3PpjBzBHhrhVLhr0t1MO3hj3Qom+efwZ?=
 =?us-ascii?Q?dOVOAp9TFI0bF5TRKikwQeI7RE+357dxS5xbOGtCegCL4l0NaRnGaLWaGwv3?=
 =?us-ascii?Q?QGk/TqLHyRM8YPhKUiZ92jeRLOuAvz10V01Bwc17pNmzX0YJZ0cwdH0ubyEz?=
 =?us-ascii?Q?eCIQIyy8YONUkSpD1jlDInWcg6+93iuCCH+/sh69DTBOvBR0jY9yoZvZ+ljH?=
 =?us-ascii?Q?wgwJCtgai2oROaQ2h3DmRsVBk5qaF60MvRgdgF0QFLitTOSAxDmMZfaybbg0?=
 =?us-ascii?Q?HzojARkcglXmuW0/EVrmGv9SnzDcyOpCmniZlZMiiEY+62RCy6J26BdNOGV0?=
 =?us-ascii?Q?011rCkGjLlcr3siwFLseyHv12rai5U1epg2VRhGG7kfPGCJLDsBwLi4mf/yU?=
 =?us-ascii?Q?K/8ywVHlSlbOzcyxYPRyeG+wXvgQCvppv0WiETZb7OTKiffwaZCXGcDvzs+f?=
 =?us-ascii?Q?PZ48zVFWVSML3J6YExPdHwIb1dQsIsqUVWUWVH85oZXvGDOr32JLBnLUGfRp?=
 =?us-ascii?Q?Aid24Nia7BiAqeGVOzgOD+8FbeOGjsWu3yes9F3/cH/WBjTrrC5Ms2CfYHTB?=
 =?us-ascii?Q?jBY9XX+aIoSNozVN6U+E92cmimdElmBVeVrVZG+/+WQweR8dRyTCb8I1gDMG?=
 =?us-ascii?Q?mjijN843fE/oAkwHkYgp8jgY4vMZD42qXz4HSItgmCJCL7SwCZLrdWDCtQGi?=
 =?us-ascii?Q?D7QmcvcDTqSyIXIQChwMr67ZyoQ8W5KVh246EX7TsUlqhMvz8HMMs7H07FI4?=
 =?us-ascii?Q?phzGCvEnLBryz6tRxQcHSoFn+QIJAyIZA2EhOKDvoSnIBmLef/BzykVdpYFj?=
 =?us-ascii?Q?UQw4npjpsI8lZIT9D6fLGFCf5InWVOSK3rMeHwI1JQItmOLtKJQuJyKd5VuL?=
 =?us-ascii?Q?ID5ZbGhddsGAy5Srp1D7LgwSFsSML0kK0yTjikj7O6tySIAP6tjjnSOk9NgV?=
 =?us-ascii?Q?6CKrWvO8gvCx5jMtWJRXZx6g5G5OM337P0tQ7jDPoHNS2ETzIJ7UKFb2fniV?=
 =?us-ascii?Q?QV8KkJ9xSaEIkqN89BR7j2yFBL48jEc5ha9R2cNM3U+KQNEPj4mbQedMGe5D?=
 =?us-ascii?Q?I6dL5P6mwmCSEJ1HTcQTCCJY25T/Fu/wcUwhYylbu0K3X2X9dTfsqG3ph+kG?=
 =?us-ascii?Q?Gl0P4f5LTj/uszbNuqZRN6p+kMcaJeqGp4MkHovilKNCz2MSNpF3xBP/AH1C?=
 =?us-ascii?Q?ybHn3yqMbY5154YZn7webo4XRNaWsi5/DzgXimd5HS07UsYwL+bJ6aDUkHx6?=
 =?us-ascii?Q?1lNCKezX8Auu8sqOD1qTqPjZLLIsfhCi3+6ZqAcZL4z/czZa6zbHFf439EKG?=
 =?us-ascii?Q?UqxmRbXrehyh9wzKvTEJHWwWJYSaIErD9LX68UqN9Rz0yiJgRMfFuDB5w99I?=
 =?us-ascii?Q?W3KWsN2NwXNIQTBbTrmRkKL03H88dnQwHrCr+M01yuwcfRbdoShi2/JOCkkg?=
 =?us-ascii?Q?8Bn1E67gojKAcI0+EwL5JePWCqPe/TsjbWlN7PR213vI1DOTPovUrpEqtYNk?=
 =?us-ascii?Q?mYQL5b8neiyjc2362E4ALPSTUVQQiXwQGa4SsiaWxLkPWQIA86AMWnsMprsp?=
 =?us-ascii?Q?HaVmrNeDGreEji8h8wyXlet3yH5RNT0KgNOLIY+oM0J3hXvpQoNbyvj7pW9K?=
 =?us-ascii?Q?u0E+HWUlo6QdtUoAZCbqrWENSCFafSy5gFMgJ8zki1dw3W+OhsJAn8z0J351?=
 =?us-ascii?Q?24VWGUrNUF9LBLNjDch1n3klr/0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70a2006-30ed-4b6e-dfea-08d9f264afcc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 22:27:31.4570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qs9dn5FMMYeMqGJkEM/1bMbMcCJvUivIpjN9V1dsv+zuYpYiXhpodx/g7yjeVLqimiYT9OwXFqDuA6jUSdFxTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6315

Reflect the ns_invert.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
v4:
 - show extra_msg after dump_stats

v3:
 - add extra_msg

v2:
 - update the output message from
                                         rtx[ ok ] - rstrx [ ok ] - invert
 to
                                         rtx[ ok ] - rstrx [ ok ]   invert
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 21 +++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 3252865352f3..644db851a56c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -809,13 +809,14 @@ chk_rst_nr()
 	local ns_invert=3D${3:-""}
 	local count
 	local dump_stats
+	local ns_tx=3D$ns1
+	local ns_rx=3D$ns2
+	local extra_msg=3D""
=20
-	if [ -z $ns_invert ]; then
-		ns_tx=3D$ns1
-		ns_rx=3D$ns2
-	elif [ $ns_invert =3D "invert" ]; then
+	if [[ $ns_invert =3D "invert" ]]; then
 		ns_tx=3D$ns2
 		ns_rx=3D$ns1
+		extra_msg=3D"   invert"
 	fi
=20
 	printf "%-${nr_blank}s %s" " " "rtx"
@@ -837,18 +838,12 @@ chk_rst_nr()
 		ret=3D1
 		dump_stats=3D1
 	else
-		if [ -z $ns_invert ]; then
-			echo "[ ok ]"
-		elif [ $ns_invert =3D "invert" ]; then
-			echo -n "[ ok ]"
-		fi
-	fi
-
-	if [ ! -z $ns_invert ] && [ $ns_invert =3D "invert" ]; then
-		echo " - invert"
+		echo -n "[ ok ]"
 	fi
=20
 	[ "${dump_stats}" =3D 1 ] && dump_stats
+
+	echo "$extra_msg"
 }
=20
 chk_infi_nr()
--=20
2.34.1

