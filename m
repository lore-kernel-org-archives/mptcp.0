Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2627A1FAF
	for <mptcp@lists.linux.dev>; Wed, 16 Feb 2022 02:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644979868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7B2951bo1MFs/WcmVtpoeckzjtipdWmQkqDoQWL7oAk=;
	b=DyOH+GHV0ABIJI0d7ZpPEMz3OSrms2vBM815VpdUWcBWNZnbCL10e4HCqY0VpcoYm3yit0
	8FoZWcFyVvVwjT/2AoRFRzzw/B57dS8F315YMRP/z0GBD3nSJoCBvM7p/XAlqoywYiNRLM
	bAjGLyr0W/MhRDKHXNyExYHlx5Qd+BQ=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-DJh5HCeyPweVYY03oQ3Idg-1; Wed, 16 Feb 2022 03:51:07 +0100
X-MC-Unique: DJh5HCeyPweVYY03oQ3Idg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edia2yQDEVRobD5x/tXbX0vX/Y634zy0N7zI/GO37L4v2yZIO64GDg2PN9wt/ZKpqoV2hUL88MXC3eoX9qFYroSvpSG/2KdsJTZ01VSTZLkbzmY/hKk/Mn4A+4tcfE9HqkLcNqh13dDXqxYbUwRko3hXix32MoHDSzndxS3Dt7cedTCUBKcBsRSl4TGs9oK6ojVoJfE/YoTtoizGMDQNpPa23zAYrmN50v8jq2Q7XqspIkTVFoPTjTEWhTXKZTYderWxg29O9o+AP61ruRCVY7oeflia7gscSw0Pb21CD2VXw2Ns3QzpLQ/Qo3XH31aNSnsbVIJpZp0i6pY2v6sokQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdAx9YzIjDBeUSb/REoo8U5qvheb36OsHwVN5XU116I=;
 b=hKVidSS7BWcYWkM4EsHe9YUmzy4ImAuxUmhJ30QJgMxEOyNVo/D9EuaTbwILRSd4nCiYo3M4gaso6gPdnS7vjchVxnY5Xbe9sCz8NVWk022u8TJLqkKuVHM4tveK1emJdOn/rjVMKRnS3X4Y/AV95fOXs6zu5lT9YYDLCHLv7jLFS1adL04KRtgj3uKre1UJX0joflm2K5lnBKqLR45Mi1W1HUxXdQfMPq7T6F9PZRcMowC+DiT+/7/W2MKBeMl5EFmxzu9yLRhUCA4gW69zs5dfL+eJlEJoJqOjFuBKucY5wbF9+mgJMdoQrxN012iQOX49aZv0/7bkeZszzav7OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8796.eurprd04.prod.outlook.com (2603:10a6:20b:40b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 02:51:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 16 Feb 2022
 02:51:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] selftests: mptcp: update output info of chk_rm_nr
Date: Wed, 16 Feb 2022 10:51:31 +0800
Message-ID: <ea86b05ef31336262889bbb02a0da28e40f86907.1644979837.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0134.apcprd02.prod.outlook.com
 (2603:1096:202:16::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b299e44-d166-442b-6e06-08d9f0f72d6f
X-MS-TrafficTypeDiagnostic: AM9PR04MB8796:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB879692302FBDF7B46227580BF8359@AM9PR04MB8796.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tfwyhCqQXiZrO8M7rTDdJr+yR6Xn1fcDru0aLkehU1phyJpBjY3Mg2ayOzxpKkkCclFK91dEky1Alt6k8nMTC25EQxI2p5sot7me1Nd62VmVtAK8b0eVK/yf5LAOQz5+ttUpVisfwnGLPm6SGS9+nL3nynHt8oItZDmFUrKLIMC3yHLAodJvaubBYesAyMcmji2U5XyUq5MUPJRVrVB4Hd56PqqrwYl47yeflq6cFeAZbMxbhNsE5oTtJidyBEB88rwmDMvptD1gIyCqJ3Asu2PAVZpycP5n3Y/tlSCX5JPyED//lTGdTATGpDmTEeCQUY4hbm+yrzqoxYYjBAgbDLUnIcyLXemG4VjUpG0KdynVF3dwoe57O/TTwDqW3h++oyxeApEdYYO4ENCr1mRK2CM2YjGY/2jC2EbjIokdPZ7GVwiegmI/Ifv1Ukzj0CK2+4hPoJkZic7xsZ8rP02d6sQYReDeuBKvh5qOR9WFj3loIsVnEU5J6NCPwJOQ8lh6LMtTRvJ9Qig+iFYmp+do65HvW7Kn+olTcglbAUmkCik5BeGZ1BHgzkbY9ziNGz+6aVGz8v14gi7wfJvuyFWcFYtafDH6ZrgrKeZ3bQ4aXNAsUybb7icBwKWRkfo3tHuQUamHI//p2dXQB8PFTw9M2g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(38100700002)(26005)(8936002)(36756003)(5660300002)(2906002)(44832011)(15650500001)(186003)(6506007)(6916009)(316002)(66946007)(66476007)(66556008)(8676002)(6666004)(86362001)(2616005)(6512007)(4326008)(508600001)(6486002)(107886003)(55236004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lgfB5hvuDx4TPhX4C8BP/2rknMv0zMtGNjZv+YrdL2DSBD0G9f97XBfuzxWq?=
 =?us-ascii?Q?vo2vKjUnE52a9ioshHc+TnA6IocLKNlsOL3XwbtJf+Us6BdJ9Jqr5n+KeDfP?=
 =?us-ascii?Q?bWOpzqw1/kSp8p5CGl4idl5E03tXZXpoJgHu5UNEkXwB9beHjte/EdOZokks?=
 =?us-ascii?Q?xQlufFYZ3vF7nxpep3LV9QhgLBcsv2LThjpOkIfFd3D7rw1Xb6LQ2x5rxZON?=
 =?us-ascii?Q?1ngVlxUgs7m9BNksEo3G3RfYXxLzrtFWWHGQU7H2dkHPHw1kxHpEmWrbupIR?=
 =?us-ascii?Q?p1fvw6mTWInCeFhBRNnMyB/eFEd6rPRN0IVzsPuerseBvqt1YchmqrbveNdm?=
 =?us-ascii?Q?NWl80W/jHJ6Nze95yOEoaVaEwIIlahQpy2L7wgRBBwYDGDmBCAZI3PVQbCX5?=
 =?us-ascii?Q?11qdHRAIHoJcTEvcb83Ii5EWAFNoN38YfBPGTowZHM6xvt8Zo9LeaG7NBw/7?=
 =?us-ascii?Q?Borcao5KvqmRw7a/YDApR85OXxUGyDOGT8Yy/r6dDSBSkhSt5H5znNIQ82Vw?=
 =?us-ascii?Q?lUleC5826yRg8f/xaBhOhbfLIaQ8bmcjRPEHUCA5DppIe5YAarnYdOgaEmPK?=
 =?us-ascii?Q?j1kSPGB2nQwF7ux9pY5ahdlatgFCWoMUMzfpm39Iwqcza8ufahbeon2YqQ+l?=
 =?us-ascii?Q?hZTpiOkZ4l1hUdDLFWUrNkxDHqt/7ZzK4tE/QsSKyryUP2OuRjPz+Mr4/Jyj?=
 =?us-ascii?Q?LIMmlGN/tDZ1kVadp9i/tOPEzREYptVeA/Y0iE8vgiac/cYLnyGQIHXHD2gJ?=
 =?us-ascii?Q?KJDa65Z7ODRAAZkLqbNLnWKmvUUjzEXXG4RijlQ5x4h45gOWg9xITdK5/1kW?=
 =?us-ascii?Q?LCvqizfoOypTliROQQMLi1TAAcvZGL+wE86OsIBVm27yV/htQyaerqL0FgHB?=
 =?us-ascii?Q?ai2UBzregbZ81FJO2cJWgCC4Muxh2DUindCmkX+SWWzRDmq0i2NaYSwGdx/S?=
 =?us-ascii?Q?FyZGu/s5TU4C6tGOfwYT7CLLLeyo3U61qhpTirym2Ou+UlMAtpL83G16yUYn?=
 =?us-ascii?Q?tjL462z+alHcQeqOP4kg5bx/jRxz/bwpS8bb6vAVTecK8Mc/+j20Lkwd8p94?=
 =?us-ascii?Q?d7b1z8uiNCeasUoLAOu7LIdyX2UCdCovIUBpzffsgL9NMqJf1o8JneinVFD9?=
 =?us-ascii?Q?q5o9vo007BcRoRYFElnwz59hDTH/MDaquJk8zIqusaSk7yl7IeaNPYujyPye?=
 =?us-ascii?Q?aXNpcCbHn6o9uVo66pMgO/Bzmzec67GbVBMJuIGaVXmM1jjDZOPg1+s6bJ1t?=
 =?us-ascii?Q?CHxMqbVDoz5MMw/5JIIz/9e514/wiygVhJU4EH76EZ1wiloqQEA8bA4Cfhn4?=
 =?us-ascii?Q?JyyzyOhEU3MsLKuc/OjGUWQQcU+V5bsGiVG9QXN8pA009Zd2JHwnW74EHZ/A?=
 =?us-ascii?Q?Jn0+g2GrFPAFPTRr1sF5MO1aasVK8+bet2xz10JwwMCH7EKd7ubtTG+84DUW?=
 =?us-ascii?Q?IvyHbooXBDEj3ijfDWAhkjFxjRsV+bKMjxk7iuzyUfUXEEWDx9SmcMwW5Bau?=
 =?us-ascii?Q?q/u9Zq7IjBx8WMGVnf5o9CErw77MzV2CqgJAAXYxKd0x1C2bbKFVDAQZaBkn?=
 =?us-ascii?Q?zUc2q0hWb+xf+QS/8rkzTavTqmgShg5CY06FcoCRpCYsqCotFYNxr3bKO+Qq?=
 =?us-ascii?Q?IDl3ktcOWBSSRBdHsoiKNn8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b299e44-d166-442b-6e06-08d9f0f72d6f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 02:51:06.1532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TqwUgeI4fvhTu9CmtcS6qNl+BXCpzKh/QTGOSsnAk7ZHJ8SYQH2KUeF+v1pxei47hSiXZFl827R8cDPCbLySMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8796

This patch updated the output info of chk_rm_nr. Renamed 'sf' to 'rmsf',
which means 'remove subflow'. Added the display of whether the inverted
namespaces has been used to check the mib counters.

The new output looks like this:

 002 remove multiple subflows          syn[ ok ] - synack[ ok ] - ack[ ok ]
                                       rm [ ok ] - rmsf  [ ok ]
 003 remove single address             syn[ ok ] - synack[ ok ] - ack[ ok ]
                                       add[ ok ] - echo  [ ok ]
                                       rm [ ok ] - rmsf  [ ok ]   invert

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index c664565aa8b1..37b3d00b2dcb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1242,15 +1242,14 @@ chk_rm_nr()
 	local invert=3D${3:-""}
 	local count
 	local dump_stats
-	local addr_ns
-	local subflow_ns
+	local addr_ns=3D$ns1
+	local subflow_ns=3D$ns2
+	local extra_msg=3D""
=20
-	if [ -z $invert ]; then
-		addr_ns=3D$ns1
-		subflow_ns=3D$ns2
-	elif [ $invert =3D "invert" ]; then
+	if [[ $invert =3D "invert" ]]; then
 		addr_ns=3D$ns2
 		subflow_ns=3D$ns1
+		extra_msg=3D"   invert"
 	fi
=20
 	printf "%-${nr_blank}s %s" " " "rm "
@@ -1264,7 +1263,7 @@ chk_rm_nr()
 		echo -n "[ ok ]"
 	fi
=20
-	echo -n " - sf    "
+	echo -n " - rmsf  "
 	count=3D`ip netns exec $subflow_ns nstat -as | grep MPTcpExtRmSubflow | a=
wk '{print $2}'`
 	[ -z "$count" ] && count=3D0
 	if [ "$count" !=3D "$rm_subflow_nr" ]; then
@@ -1272,9 +1271,11 @@ chk_rm_nr()
 		ret=3D1
 		dump_stats=3D1
 	else
-		echo "[ ok ]"
+		echo -n "[ ok ]"
 	fi
=20
+	echo "$extra_msg"
+
 	[ "${dump_stats}" =3D 1 ] && dump_stats
 }
=20
--=20
2.34.1

