Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F32C1876
	for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 21:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644961564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bAY3W6yYIzasLDKF45dHDIeCIEU3HCCJ8JqdE0/sHFw=;
	b=LwNxxsnscq3ZEap4Ue+AySsozRFhZlElkm7bpNEMe0PMLw+4KVUeZFZEf4RtpoTBWytzt5
	z62CG0thZoWtDZTWun/nRhUFT1uC9NtP3Ivsp8VuaUL7AsXqUPYqDHHsH9uuuBp8PLUrj6
	IBAdoXo48VmAzkuo4/qmY7lyhwZBJQA=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2059.outbound.protection.outlook.com [104.47.12.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-rNU1jn1hNjOrRnr9rBxwTg-1; Tue, 15 Feb 2022 22:46:03 +0100
X-MC-Unique: rNU1jn1hNjOrRnr9rBxwTg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BI4BhZhqz3R+MLWsZ3pCBtDuhFnIRRN7zutNhhEOAHX9t3RMP3deGmSU6XOzuSCyn/zrDqbvW6Yy1w8OWa1iox2FQM7oL52CKtWedRgaucESWUAfDrmqQSqGVR9I9TXskSWd+fnwXUgkXYbWiegbr8ASjjQTyy0CxTUHnfQOddaxZLB7jftZ6dalMK33ULvzpC+3xZNA7M3JyH8cRbU9WkyOy6vhBPS2K144QyKIDdXflycJd2moYVjaSOutzEWp6k1fty9JLU1DSje86+dg5YsyB43lnIbFcTr6yedySb138SRKDpf9XGBCjp7dWb4f4bBxtkCJ9rFfmkyUki3W1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGWlkuDexyDYbf62dBt7qTIrMJlvp/M9KFoxtonZa0U=;
 b=LG9BcPvtXGsRUIDUTlUjYacq1k2lpTMQvNNLLv8SOeHu9m9a6Pq38qzQuTJDtpTu/u4U9feW4FedzXZ23J1KKOi7hSDp+9cIrMbXbilnczBnJMUvy8cig51hKkyXDdD4XjB0waVaKMJSuSSgioy+R6893IL4oRvV5gZjGkfYoaZZGTaQpjSa+YDI7n8Kz4a0nbhKL9uT2nF+8WBxObCdeWWfqjIAZNEX9LaNW6tdFd9c/EbhlFzJK6DSQijtUjXkZvWUQ+y50K7ClbRaSvo9YwaxXkvssh2j0Bk/ZmAqiQJtO3c4pRS2Qr923SZTTT84CeDWvzqziB2CnML/SdQF0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7371.eurprd04.prod.outlook.com (2603:10a6:102:87::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Tue, 15 Feb
 2022 21:46:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 15 Feb 2022
 21:46:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2] Squash to "selftests: mptcp: add the MP_RST mibs check v3"
Date: Wed, 16 Feb 2022 05:46:27 +0800
Message-ID: <745e938fabd63bdcb630cffb2074579672c84260.1644961452.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c493afb2-9477-4275-0e44-08d9f0cc8f69
X-MS-TrafficTypeDiagnostic: PR3PR04MB7371:EE_
X-Microsoft-Antispam-PRVS:
	<PR3PR04MB73710DFB7F941C083D3B5E3DF8349@PR3PR04MB7371.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2BGjnIyweCuwJ8EGprcnPZ4g1jsAOnZ0gFkOvtlRaMWq5Oztsl/JlS+vumZcULJnYxAMq8N5pLUd+n7a5B/7evQolR/JXDCmMv18hBJnV3LnGyUFEFRO+GHugHvvpF9E+wtVvq1DC0yJu89xsO0q+LPcYjNmZ0fVz+TrIAny9+gtBd8GvJyPNXE8JdcfFFQPyM+ai12cJk0XIWBdqNZewTXfU2+j+H/GMpbniX7M/sLUrtD/0YwRH0FvrR7zwJaEQXwoazZif/aZ+QG3xNxxjvGxsokuKRMDWYEkIAGV1QRv1vNycjkOuW6BvUXaSvPEE/5uCy94iDClXmgXUQJT5S3c/b14BvF9jb22dTJK588EpQWqLqvtHO73PaWH5DpVYIpMPooI0NGT7oA8vTLKOXIaG6LK87EB3xTrDJ4+oDD/h49ohTrwFljdNWnBZBt9mtyyG+TnpymOKQq4whEo0uqjouZo/Oc3anK6s+AvpY6R2MlnfMJF8c+VQQIIwim8xXsi2Wt2sGQHUEhHFCnnvznqwqcHzVC5MR9nkeQ60YWJI3GdcnlK8wJOpSsDKU4htK1QSnJx1YvPbGVO/xOwvWZTPZElkRgRL1Z33Nif4tcFYB6YO++j2pNFcVc77mxVWRu2nyBHiEQQRv+oQA+lgQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(86362001)(66476007)(2906002)(4326008)(8676002)(8936002)(83380400001)(66946007)(2616005)(5660300002)(107886003)(6506007)(6512007)(6666004)(44832011)(36756003)(6486002)(6916009)(316002)(186003)(508600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WUmjLbE+7V4s1NxlDPykWFGcryrzcBWStDyrDAbVDCyiwY24951eYWiUKdtk?=
 =?us-ascii?Q?ydY2+aM0aVgZcHdAHETF5uV3ieVLwYgRWjcGaX4cmRsAwEyavfJy8b3ugv+b?=
 =?us-ascii?Q?mmbtWKbughSRbfVsMQzhl3KmP4QkSlpYMSbhYpEG23jjxQODA709gQqFQbA3?=
 =?us-ascii?Q?9MpXc/jyZZvzqRGHu2UU3vGgLQYxiXhAwSi/Ws4GGucpXXm8bTh9lrgz3uIB?=
 =?us-ascii?Q?55AXUMvJhQuSPXDLyuId4sCDZ/rx2svhKtOdDReNWlRS+EYnvJ34517CYSIl?=
 =?us-ascii?Q?8mz/zAF9CDTteqMXNbMYLTDV6b6mndGyaQImGMgE5Oq269L2/1CDa3+CZuPA?=
 =?us-ascii?Q?N1IrQgR71eGoOyh7ckCB6rSyO1uYhZ4m/IgGO+69zMzVHFKOJ2WL/C+/6Kt4?=
 =?us-ascii?Q?ti8T1BUW+0MyRcaCrHy7lnu3gnGacY9xRbNY8ONcsoD39DXK2We2MToOqNMh?=
 =?us-ascii?Q?OJze2gxRwUkX7acg7TvikTpwJng6TED6/hfYCbOthYiZ2g3LZl0wCW9Ylq0Y?=
 =?us-ascii?Q?hy0xBpKhTiWEvPg8T/Xr5zWMRYDWj2GvBzlrKmz4bxwBSwNICsLBzH3dgk6Y?=
 =?us-ascii?Q?hactZ3pAtp+Oq5fquKdxY+cmHT7GerLcutQ/2JNI0ZcM8s+rQ7nweEF/peiy?=
 =?us-ascii?Q?+gdQ/0uOBa6DoLhONslrecr9tMSFSL5aZmrHZ3IvBKdKa+ELYfSTG59GfKFG?=
 =?us-ascii?Q?27F64RjL7e+Tlw4WKeBoHmueVXCcqn7UOjkXIN1OZ5hpuzg8gBGB8YMtoRZu?=
 =?us-ascii?Q?ZV+4ruLAyam6+mhT842ASgsmijsCnR25CoSCndxTzWP2JyW/ePgzDLx32FXP?=
 =?us-ascii?Q?Nv35ToPO0N6hQzoWm3tEUTsg+LAN7gEDjB4Z+qlhMti9VhM7SfifLBSuD+Za?=
 =?us-ascii?Q?x1UF55XrFFHOaqbeQec2dKjc2Ixfyj5/aquVJP2EbWDGy/fxMLkvs/uWuot8?=
 =?us-ascii?Q?5OpP5LtmXz4xYsKyQgDE+tExVDtpLZN9heW0lRGf8h73tWg9MG0FqSzdJnCG?=
 =?us-ascii?Q?qwwpY7Q9ilsFS39TGMHLQFVwn/OBup54wIrB2y0cmMC/2Ki2bOYIjoMISwqD?=
 =?us-ascii?Q?e/EyTbqnkmyr5/8Cfbu82MaLSozEaxEWYbFEGvAN63hkIDWLHw+Pda0I/Uh/?=
 =?us-ascii?Q?bMpeWk2av/sOhbEOPhtIB4mEvkGnvdnJii91ocsSAle/R2j34x8xJkCSdifY?=
 =?us-ascii?Q?26BjvcqK75gGpzCq9VjIt17AHgC8m+As+bwTpEhtatmqbrKwR9UUK9TEKFz7?=
 =?us-ascii?Q?l6Nzso5Loww1PCkYGjWg7im4q5aYUdMB+d9POA3/sfrC2LqDRnYZZZobX+Dg?=
 =?us-ascii?Q?Ep95iGuEW849sgwXa5Y42q3bK/P3lWjcrasT+ozorEouW9cxQopmiwIQEkeL?=
 =?us-ascii?Q?+SXRc9HQwEAHlgj4fn2BoRmmqS04roWTEHAz+jKvbFghpm1Wq5j+w0U3V/MQ?=
 =?us-ascii?Q?KZYavoSSt6kGGHxXBmVrgw8zdplZsLtaz0Wg8YeJh1DVpMeZJrqmMaPnjzFg?=
 =?us-ascii?Q?UV4zig1Eyx8NyhRnlSd8fe9RuRuQEaIcfw5ggYL2oFCDw0R8WRwIISXurwJq?=
 =?us-ascii?Q?anm3op/AkeHlAInmBzFx94Wo8MRtTFogAQwbIJbzMb+2M6abcocdlJ37AwiL?=
 =?us-ascii?Q?O/uez4TmJU0QzeO0WluLa6oCBmR/inwKouzwPjh1u3U071SEblbVLEZ5BT90?=
 =?us-ascii?Q?rWtfMFh1VugA6XXvxZ3ypU3TLCE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c493afb2-9477-4275-0e44-08d9f0cc8f69
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 21:46:02.2313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jeb1WkqIZ0paREArmClEF2Ud02BVOQbWHfd5EqgX2tuihl7MsUxJSFzMCyQSSD1aQjrX7zJXfHgKE9F9d9Cikg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7371

Reflect the ns_invert.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
v2:
 - update the output message from
                                         rtx[ ok ] - rstrx [ ok ] - invert
 to
                                         rtx[ ok ] - rstrx [ ok ]   invert
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 3252865352f3..9aad8d21dc0c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -809,11 +809,10 @@ chk_rst_nr()
 	local ns_invert=3D${3:-""}
 	local count
 	local dump_stats
+	local ns_tx=3D$ns1
+	local ns_rx=3D$ns2
=20
-	if [ -z $ns_invert ]; then
-		ns_tx=3D$ns1
-		ns_rx=3D$ns2
-	elif [ $ns_invert =3D "invert" ]; then
+	if [[ $ns_invert =3D "invert" ]]; then
 		ns_tx=3D$ns2
 		ns_rx=3D$ns1
 	fi
@@ -837,15 +836,13 @@ chk_rst_nr()
 		ret=3D1
 		dump_stats=3D1
 	else
-		if [ -z $ns_invert ]; then
-			echo "[ ok ]"
-		elif [ $ns_invert =3D "invert" ]; then
-			echo -n "[ ok ]"
-		fi
+		echo -n "[ ok ]"
 	fi
=20
-	if [ ! -z $ns_invert ] && [ $ns_invert =3D "invert" ]; then
-		echo " - invert"
+	if [[ $ns_invert =3D "invert" ]]; then
+		echo "   invert"
+	else
+		echo ""
 	fi
=20
 	[ "${dump_stats}" =3D 1 ] && dump_stats
--=20
2.34.1

