Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AD92C9E
	for <mptcp@lists.linux.dev>; Sun, 13 Feb 2022 00:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644710670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g/a6zmk4VBHMtlx/koUTZ9pjbAMdNZtm3rYqYEu2FRM=;
	b=QPg8/XLUbZK+dvlo7Wg6C3LzJodhPItzkNXo/4i+XNP2Yg6yIqT0zpEQe5qzoQYYBjowJf
	4okYoOk+aVPYVTuFGaY4JXNe0I7TuJPRQctzrXI4l0er+shzhMEXue6l6S3nG/3Vd7bzx/
	qjlcgLKHnyK9fVM1MvKKC8iQm36rlaY=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2171.outbound.protection.outlook.com [104.47.17.171]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-wSSECn9yO0-B1gQb2i1FBg-1; Sun, 13 Feb 2022 01:04:28 +0100
X-MC-Unique: wSSECn9yO0-B1gQb2i1FBg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2Fa/eCxKiPkenau6EaiPwqt7k3GPFd7YgiYTrjR/3Wd3xHuJXeE5cCV1zW4yuMMRmO79tKCZrNazKcgbmbPKHyi1m99A8KpcwqfHx/PRDNexCC5i+XvDIuK3s/BxGUsQEVhSndnqoM4rdXZfiXI04zT3vIkbCejEG2KaWJMszue4EiRs0wnvhOxfI8zj2vB2oZ1kAyTbO1dWUsxs2GCNIXZBN6ps4M6OpkrMlrKNZ8wHhkk9ZPBN5Ex7sl/M2G48OTeW64G+txiHMcCG8ziUjVtns4VnRoMG2+DCBXaO2iBzUioqwDG6uiRqlRoTQrfK2RL0CZFNcOPVUB4RvfHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18/Jx1OyQNS6LbyE+YbW2Z/OlTRTyTY6A7Ll6hItwO8=;
 b=PkfEr/Cpj+L4oYg8knVndHZgBK69RG24scxk1kdB4dULamA/dW5YW3aeCWQ04KHfJa5akM4K12f6V+0IkqijRFBvKtDdwZZ/LfM8KI+PgIg9bgz0W0JPIB+NaAZrS8fJBYPPWOSxrmr9KzGpGmEthqu0gSTwXSgdI+jV7a4AKq7Q/KylGb8TQXqmA1+Ar7lyIpAQAtMPN7xLCjbE7yulYU5U3cdQ31MoJ5SjU0xFnsHQwTm0dv04G+s4kJTPszQ/+jhY8WWXSLKJuuvlG7vrznYTPOw51yy/D+qaxEcmvQS96R1rJ8kuXlXQTh6Dcu9hkdlJedu2KYXvoBpG8NBlnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB6617.eurprd04.prod.outlook.com (2603:10a6:10:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Sun, 13 Feb
 2022 00:04:25 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sun, 13 Feb 2022
 00:04:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add the MP_RST mibs check"
Date: Sun, 13 Feb 2022 08:04:46 +0800
Message-ID: <6ecf6a9ce191ab50a0e187ccd50c37987eaecb20.1644710649.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:203:b0::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 767ee193-cd9d-4cc1-aba4-08d9ee846514
X-MS-TrafficTypeDiagnostic: DB8PR04MB6617:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB66177A12D1FE6C4B4E445FC4F8329@DB8PR04MB6617.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oRXujAAkHTvZTwEMHjGAxDgOuyfbnAGIdGyTpj59vG63pGwPVdujt4n9USkGZCfXIatSKu4JxufWv8gkmqvOFhpxFqdJk68N391JDhYnVmU/70hnlw+9URK5hfcppxCYRn1YskxltaKWM6ENpnchw6aOK2QVzEM0KEjoLCZBvxOLiuvlTURphIctYsTAejtB0/J2YazVZ3OA1aFG2Qa5vb5MFd4aoURCXu5nRSu/Z/94SQkqXx1zQrgE3xzCiP2Mla4b1M4KZXX3ibfwtXecCpH8eAcW6uJmQqnKqtZ1eEP55WfXWwucR/0FEc+klluOEtxMgtV9Fu7GLUyWGasyS/qktua5QTLoHTYcG7t4lvuxueLmYjVTjTdRk42yVpCSulnZE0TwcktTSxn1uNOVws87KHn0n9bLHx9yP+9E9+ETCkvHOF6HijV98fK6yfamJ3pHh1hrjiKBiXI+hv77SJEWUb7WwQ02JvmntesouuOSsr6r1mt1Qjf6zmXgVWYLfB3xpSc2pLhxtgQ87W3oQzxD81hT6LDRqVOjDRx1SRtyNQoSKzNs0tYwt6Cew+lEOmA1bzgnmHqr6XaaSjxs8MAa3/iRpfCGHkzH7Cr7G/09udQeUY9LjmSpRe/d2TX7O0TWnjy9y/1pq4kidQIwrEwJ/CSewg6uLxTRxIT1zkV8nu+zJnlbZfXwLSo2UuEs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(8676002)(44832011)(4326008)(86362001)(6506007)(8936002)(66476007)(6486002)(66946007)(5660300002)(83380400001)(508600001)(6916009)(107886003)(26005)(36756003)(6512007)(6666004)(2906002)(186003)(2616005)(38100700002)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2QprmfmDeQM73Zu9lk42ht96dw5VQaIcUzmO01sZdJ0DO9rTfSkuCQwTuoL5?=
 =?us-ascii?Q?YShKUoIs2UN0+cZ7eh16BOgBqxSDiVrBhIORLfuRZ83HcNg0zyQNJq4aPBAJ?=
 =?us-ascii?Q?5Hwoc+A+c3WDso+hyWJ6fYRfnXCQoMbtr93F7ZH4LhPRS+iGHwIZjcyz22o7?=
 =?us-ascii?Q?P6y/g3e3LOLh0VVBu1g3OtXBLuF00/vBM9GH/8kVbl9VWUzPXqqR2uq6zKuJ?=
 =?us-ascii?Q?Uf+WFx+WerwzdmzjFQtz2Y9qw/5BT3x73bhSXap8sw0tWJGaFtViT+kaXkRy?=
 =?us-ascii?Q?WDFJ8i/MqBqaVCu5S2h4CG2QXFvK3F0453nCnfgrauCdGlwdmwV4zMRnZoC2?=
 =?us-ascii?Q?KDmIDSeNYZrsJZ1g1hM0pRVtAqnmoSffTjqmqj7aEs4PoxEV5CykTVxBvkAb?=
 =?us-ascii?Q?+SN9QIsPvdJS0QLUg5V8SWLC6ppi/6v4BPkMUv0swyLMVYth09iDy7abBZqP?=
 =?us-ascii?Q?b3Hy+Gmi77+MptuhFKuEGbPHOjz0ChXioxa45Ud5UR4yGF9bc5+fPlKpibgh?=
 =?us-ascii?Q?X6B1AROG6PAkHEyaH46fikiBLcFC+GilkNf8nSlo4bx4uPj7kLQMorAXk7aD?=
 =?us-ascii?Q?V70haZdAfeifSS7nhSvq0enkvvX7cR7xN1NG0bCPfoC0tQuD7Khy1xwlmVhO?=
 =?us-ascii?Q?uI3P0nybdDz4p0oLHvBfTpbylSfmQpPMhKo5gH8h1nZtr/mabMPSkxOspovT?=
 =?us-ascii?Q?/EfJtcaeBLLn6hxUxgJ5aX/cEeBIZf7aWqR4gu4KWB0IynfeysFu47jNXeM3?=
 =?us-ascii?Q?jZKF3KZH5QSeMNo2cCVPOu1VSSfX/qvE7cIi/eyKGCEXojyZ7EK1Pea3ERmv?=
 =?us-ascii?Q?gbIjSQTFGFBi2mogf5hjhbvCMhhQf7xCJOOdcyIbXwc6KIJ9uwzWYWjAbrO7?=
 =?us-ascii?Q?yDluQWxIYXK5OyojkYYOuUJ12h/jrSbgMKpUtGwJCSAz3KuAnL+oHgc2jD8s?=
 =?us-ascii?Q?IxWwzQt1YuHPnZGSDdUWPZ4s5FgyVTPEw9AgFVyh0OIfiTx4DNQE5xqbMm06?=
 =?us-ascii?Q?3yL8AHSEC2bezAckfGleBulqYRJNEqG9xGx8nSS3GC19k4m7uGRo1zfc2lk0?=
 =?us-ascii?Q?QhMEaHGBW52OjzF6iPzNyRyyRaW1dw83n5lx7mL69LR+Ib6P5PGvJygnEtnC?=
 =?us-ascii?Q?EN3/OEo3sMt18otqyW7uzeALukwmijyL/1Tq3nqBITXDl4D6bsrtZW4QfuEG?=
 =?us-ascii?Q?tHQmlR2dqscPBo7QFTRyhYnv154HOpxxShASQ+ky/f6B8IbcuwuB+BIOC3gc?=
 =?us-ascii?Q?AxYxFZVfU0sR3NrhPUDYm3XV/24Z8C/FEGrUSXFgrGmuldUdxHTQpPMbEa1J?=
 =?us-ascii?Q?nBFfzhS2HQoCgkWRJiUYwNW7VrWB4A4SEajPcmye10FYS3y1S9xyCgxGQbri?=
 =?us-ascii?Q?+63ymKbDvHDAlGNkZsXM2XsvEvYmueWjmZAG/WLj9NfzGWHuSEC5LHrafgoR?=
 =?us-ascii?Q?uIQuuaCvFwOHvPAM1FGKSQrlFuVE1m/6B+pdqijLMm+5GPNSWVEeEXVVMyti?=
 =?us-ascii?Q?TCzaXdzWZxRHfHPMJOCmrrBaIuHICCszyzPG4VTje750KkAm328AmPAftl3f?=
 =?us-ascii?Q?zX8BdpB/rWwmHdVdwxrJTI8Dg479eXuFUYj187Xcaf2ltI9iqrVSzlfbEeV9?=
 =?us-ascii?Q?IEtqP//GUPMiCVQKzljX9qw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 767ee193-cd9d-4cc1-aba4-08d9ee846514
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2022 00:04:25.2801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljgG8f3W19GKVUlpUCCwbcI6h58zleRkiWnjlaVmJku0tuquPcMZL1V4CMF9cJLjSW2toYtYhUZB64ZE0lypbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6617

Showed in the output whether the inverted namespaces check order is used.
Since if we pass -Cz to mptcp_join.sh, the MP_RST information is showed
twice:

 001 fastclose test 1              syn[ ok ] - synack[ ok ] - ack[ ok ]
                                   sum[ ok ] - csum  [ ok ]
                                   ftx[ ok ] - frx   [ ok ]
                                   rtx[ ok ] - rstrx [ ok ]
                                   itx[ ok ] - irx   [ ok ]
                                   ctx[ ok ] - fclzrx[ ok ]
                                   rtx[ ok ] - rstrx [ ok ] - invert

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 000272eec5a5..3252865352f3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -806,14 +806,14 @@ chk_rst_nr()
 {
 	local rst_tx=3D$1
 	local rst_rx=3D$2
-	local invert=3D${3:-""}
+	local ns_invert=3D${3:-""}
 	local count
 	local dump_stats
=20
-	if [ -z $invert ]; then
+	if [ -z $ns_invert ]; then
 		ns_tx=3D$ns1
 		ns_rx=3D$ns2
-	elif [ $invert =3D "invert" ]; then
+	elif [ $ns_invert =3D "invert" ]; then
 		ns_tx=3D$ns2
 		ns_rx=3D$ns1
 	fi
@@ -837,7 +837,15 @@ chk_rst_nr()
 		ret=3D1
 		dump_stats=3D1
 	else
-		echo "[ ok ]"
+		if [ -z $ns_invert ]; then
+			echo "[ ok ]"
+		elif [ $ns_invert =3D "invert" ]; then
+			echo -n "[ ok ]"
+		fi
+	fi
+
+	if [ ! -z $ns_invert ] && [ $ns_invert =3D "invert" ]; then
+		echo " - invert"
 	fi
=20
 	[ "${dump_stats}" =3D 1 ] && dump_stats
--=20
2.34.1

