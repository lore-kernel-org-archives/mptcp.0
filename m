Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2712B7C
	for <mptcp@lists.linux.dev>; Wed, 16 Feb 2022 11:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645009518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rCiQVDu0XnoUmaVuyPisbtQpLlEQ/+NOBphkgxBTMMQ=;
	b=BMid2Smde46jbBPAbGsHoOV+MvhP0LtkhM6YgsOWi3TCpkkEsn2N6Vi2GoMxxSjiK5azfU
	R027p5ICq8WzNPCeT1unJoWGaJ6Omxi8x6+NqhlN/37vMko0tNL0fanswsTV3UmVkif9rq
	I37R3PxHzJWOxwvdNXWv2yNL7Cj0A2M=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2110.outbound.protection.outlook.com [104.47.17.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-4-Fe4AKD7QOAid8DVExBX80A-1; Wed, 16 Feb 2022 12:05:17 +0100
X-MC-Unique: Fe4AKD7QOAid8DVExBX80A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxMm+gTzPG7y/nKyjK/JHFJYo+B3O9ngfg8tTTrQs2p0IiPNt5IpuBiV5eiBvZgaW51/C+zjPdUGfoBTbxP21qacrWqXWyOKvvxkFmAazziUPQPfNjelBkBWsDwPpkGur1xMUCGzSusoYoURbh6ZADUU9SBhMhtg58TxeE/dEMT+i3QBFHbPf2VYWmqUzeNq3mt2Io0RHmMvCyIk4A+pEeFftCO3bw1rVgYVEK/mcRSI3gaaUy/HI0yLI4q7X+n+hD7HsD3fxAlXneTHKyNU2oMCE9iExqrKRwl52e+3WJhDR4SY3wLiLtBeWROqq+33v7v00NYCxOivcQeAHR7hhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4IYwIIy4XxpeR0bO+g9/xVfFZK0yg0N5Zsx6jNwtgA=;
 b=AeSoEJnt/Taz4lBTAr6x8EGa4zYJXDMcvUJq1qmbcPiFXqQDqHZYZXDkou4O/g/AT1ZLVbcSmizBavhufmIgia8Wkjh/Muob4uC/ZtjjGvwW4rVoHirq92Fp4walCUxlx5tkGOj63exOEMrSNeM4AW0HVYmUFeh9SZO8yTg6o/t10WVN+qevdNvxx3ln+ggURuvpFiEp/8czytv042s/QyGmfu0nhX9KOjjK8yGSYCniDA4/ExSv9DwX+1ytuWdbLz5yYIojasAH8G37UUbCkpwapZ/Yn6beKB3dORR4QpMffe7lQsy26wQBZSGrxZrx8C0kQI5G+Op93cN98b33JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB5799.eurprd04.prod.outlook.com (2603:10a6:20b:a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 11:05:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 16 Feb 2022
 11:05:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [RFC mptcp-next 3/6] selftests: mptcp: add MP_FAIL echo mibs check
Date: Wed, 16 Feb 2022 19:05:10 +0800
Message-ID: <93f054f3fea5895fe86b17c1dbcaf7d597b1edb5.1645009373.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645009373.git.geliang.tang@suse.com>
References: <cover.1645009373.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0018.apcprd03.prod.outlook.com
 (2603:1096:202::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69313cc7-ef87-4d28-0437-08d9f13c36a1
X-MS-TrafficTypeDiagnostic: AM6PR04MB5799:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB5799C9BBC1CD08AB34EE2D57F8359@AM6PR04MB5799.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:157;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gUY483eSDDu13k+GpiQ1haP1xF8l+ue6XLyNkkaG0rqn9/iK1yn441a6q1SS2V1oBZSBZEHYl/nLSKqt8lHax1mRgHvZSGg17eCVACt4ul1o6MQmx2JYVVFiOHbO8LBppNaEgUhT+Z6ihT33EiFRne/f08XSP82NlVbHnHywSRNd4b6gLWxdQJs8mu55C19nInTA5cFQ/BMJy8/0eA5AKkIdW0qCMFbLCPtC+PR8VrMPe0+rC6dm59M4Z4CQX15wUYM1/kwNeeyhMATbDmJ7yO/jehSYa0oDkfqOz+FdwfZGzzBfqnqGcTeMhye49o/un9t4yvpcsKJRXJotYzd7xR5H/fjNTvnsVa9TaEom5T/6RSm3LyEH2IzPkio+nf43ZH8Fz9fh73wHBP6sEjQF2ysGy/gxOkAKvWOAPdzqnhYv3/6KOlKvjld/pQURODI+DuP57kuQ/8r23myRnJ1ZExviaCU5AR6stka7idTFKNuy3H6s5mu9VwxwpK5GKmHdbS0KGzUZPIfX0ftmkrwwnjU+25Yg7ARYdO/INLgzkvNCF9CtgexB4SrAD8MS1AI7XQ2X5fsUlFckI6BxVjlz9wEZ0mktLaTxdCuP0pZMt0Sv7ybfaykrYNeWkRsJ4+T4p5n+MVSY822oPkR6F848Ag==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(508600001)(36756003)(107886003)(86362001)(66946007)(66476007)(55236004)(44832011)(26005)(186003)(8936002)(2616005)(6486002)(316002)(38100700002)(6916009)(4326008)(8676002)(6666004)(6512007)(6506007)(66556008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+uRwwO/SDkKH9Rr1gZF+QPZBre/Yy7QlS3t41H/5iH0WQr7RVTwHqV1CQxoE?=
 =?us-ascii?Q?Wml/trKCW63X9gVesM1iegIUyOVrnv68fP+MOiqt31DrSuoEGLOuAzCFDvBk?=
 =?us-ascii?Q?6xW0Xrd5YTtAPtaS1Tc4oIGwhrsdckxrvjKnmw7biGHHHC8HC2ChXg7OwyDc?=
 =?us-ascii?Q?1KadodEgICE6swxnWYMyaR2pbg7iC62UBuosppc2vxZdXc+E3HvBNGK6hvJ2?=
 =?us-ascii?Q?UqgzncF+Vxvq0IYSuNxWLcrx7j0xQfU4S6EjKf/MG6E8SdfLb0I463/0G1Ei?=
 =?us-ascii?Q?xEqLdxZZty7//kDS8rnZ+j5Cxe3FZ9wdr0ptKKdJmeLUKF0qXU57G9Z6uW3x?=
 =?us-ascii?Q?f9GHebT6GeyFiejYsTUTZFV9SQwjaq0kDVRtVCuWGzx2ALgAPDCLUoQpt6jL?=
 =?us-ascii?Q?MhaJ/2/YskQXzW4x/1NH1XSlhQ3qAGQgg8Qv2jYfP50xUTvDgS00ZAeFBM3I?=
 =?us-ascii?Q?W3/oGJlrz/2LbKw6wekamtkQuQmDBKmlvEv+qBuzt1J120NvNsWpjdykjw13?=
 =?us-ascii?Q?a2DMDz6xVT6qzvQiyJDDupXaOdOGAvqwaMvR6X4IL7Al2J+ZN9VxsjuvqxrZ?=
 =?us-ascii?Q?pFhP6tv+d4Ce8EhY5MPWajBZoUXQCaXyTT52sqU7GC4x0zTOtCeAHKGSnExv?=
 =?us-ascii?Q?FeNCV4Bv7YAVgrV0D9c+k2dt3udqKUuDehX3q0hpR1L6XzyRSTLtQG3AruNf?=
 =?us-ascii?Q?yen5BqD94Z2U44oaNhOtGnTqQ8Kzh/CQ4bNwk9qU/0Y+PM7ueYWzhP88pPh7?=
 =?us-ascii?Q?YiRx1BTIkDnkubTbz6mxZ5S2++K9PpoWCNCZqmi80/DcPH53Qq8VuSqKf0Dq?=
 =?us-ascii?Q?KHx6IWYG2r5rCX45oorsElnkqSaff79YZx7x850QgVLsvE5LqVI9H+R/Gqi+?=
 =?us-ascii?Q?gSLl2Amke4PDB65K+OVAdcjbTAfOVJi9tXseyXn0HJPK0LCvgFqB0IzJWxep?=
 =?us-ascii?Q?zg6PKsopdukt6UrFs2fJf8FOEj4JP/tEegDvx7imwcocw0srI6eqW+VIUPC2?=
 =?us-ascii?Q?UobF9S9MtPQkMbJflzGvXSPRpZyMA5I55aBl5mot790DxulDdrX4ZANMUoYA?=
 =?us-ascii?Q?TvV/2XnDV+NEg+NFVMHUqytF/KWmiV7jrkduAZxgRvy/BX8xY8liN4XoOXaF?=
 =?us-ascii?Q?ww40gB4wl6+Xw1/QuvP2Bn/MMQstKJU73LQYpUWIvOqcD3ICDN8cRu8BpM0h?=
 =?us-ascii?Q?RkaRjbkgRFkqedQRHsk4P527ImZQgGQmDpMNQUH+OG/Kpp+00LPB3PkFcK7G?=
 =?us-ascii?Q?gkIw9FJEq7wOPEM2ClXDouCJGT3XVNJZpH+/xirlirzD9Gm9zkMZmaRVT6ct?=
 =?us-ascii?Q?864rsC4faHn0TpUutgFAJ3s6RkUVwi1bbcHRS4hqZC3M9Q2OG4Rs3DSTKrY1?=
 =?us-ascii?Q?yiwla8JMzu2Oan+DQWkl+9Pvssc0Q3cKGfIjzZOZia6vo7MV0UMVLPsGpX9R?=
 =?us-ascii?Q?VNo3Xxy2zsLQTqdF+Uz9SX310/d9w5D52NwjFpjE0KLCgMhA+2Unv8UoMcQf?=
 =?us-ascii?Q?+6nrMhMS5Tjthx19EsqTAmVuH//CW0l6D9udETqA3CshgkUCaw4Olx/fFhW0?=
 =?us-ascii?Q?PVqYYO6mPcqE0L3yZeX5MvwXoLPNOrhC5M3lprYgXO2BX40fBaVUMytTwopx?=
 =?us-ascii?Q?lA9L1ZHHwtCsYB188y1+9X0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69313cc7-ef87-4d28-0437-08d9f13c36a1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 11:05:16.7427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0a4UByZyrOH4WBvNR4d6iPOAJAHUHkLYM8IgX4lV7Ezv6ma5C+fSx71i8f8RDuJz3glqxop/lCT8lWcdU7q7uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5799

This patch added the MP_FAIL echo mibs check.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 37b3d00b2dcb..01b9cc190134 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -871,6 +871,8 @@ chk_fail_nr()
 {
 	local fail_tx=3D$1
 	local fail_rx=3D$2
+	local echo_tx=3D${3:-$fail_tx}
+	local echo_rx=3D${4:-$fail_rx}
 	local count
 	local dump_stats
=20
@@ -896,6 +898,28 @@ chk_fail_nr()
 		echo "[ ok ]"
 	fi
=20
+	printf "%-${nr_blank}s %s" " " "etx"
+	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtMPFailEchoTx | awk '=
{print $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$echo_tx" ]; then
+		echo "[fail] got $count MP_FAIL[s] RX expected $echo_tx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - echorx"
+	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailEchoRx | awk '=
{print $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$echo_rx" ]; then
+		echo "[fail] got $count MP_FAIL[s] RX expected $echo_rx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo "[ ok ]"
+	fi
+
 	[ "${dump_stats}" =3D 1 ] && dump_stats
 }
=20
--=20
2.34.1

