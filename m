Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BFB7C
	for <mptcp@lists.linux.dev>; Wed,  9 Mar 2022 12:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646829275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=olnvc5NvkdoW3A+98EK/h+S07QcFlCMWFsDN749EOXA=;
	b=H8PqOQkY2EVn6kL6wiMkj7XlGkb2phdDwlXRi29vpYDdYgva+SWrCB4a1CVVeL+ocA1lvb
	DtROQrMYk0esHCa/OeVkyIZxY8hUP2Fkxq1bJ8toWr1p4M6JZ2QckGnDybxcvzWb0Ds4Uu
	VGEFkypRb0ejwUNOqg1nWsrjI4SynDo=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2172.outbound.protection.outlook.com [104.47.17.172]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-tqxIxoFNPV-KbR-wpr4voQ-1; Wed, 09 Mar 2022 13:34:33 +0100
X-MC-Unique: tqxIxoFNPV-KbR-wpr4voQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXn9AIjxtXzBONROknSxLpUp0b/5ErIRxF/6xr0WgdM4+xUhkdTijrGd3AKzguhNcZBT2MDNMQALiUkJuX0xn12xW8ci1rela4sXMN+GxpLajcRG3N3p2EkDGMVBIIccnTb8uLKNe0JRhN8LWdgYG2bm8TVnQ1huMbflVgzLoLP+sPjPDl8znL86kswnjGSGPJ18LD/sueVWzyivgnhdqYma+KKxW4rytyz6diaQu2m0CuDOe/Ym8ZrZ8UkIrfGZ0jFne7fiX4E4li9s1y6N1pNvxWD49+BmF0UMdF//2mZvo1NKUYL6C8w51l+3qHUy1gNFszrfW/K2SwIDHF1h1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6f/uPyVi8UpnkNN4hDah4OxYbdNpiEdFprWgq5JOZRA=;
 b=CNkH/dIIHQA8nq/xPoIRMPM5UYZy+d0IGJLzRMFZJl15aorpx/fbGPrJMHdnjRtys5/hD5LCNbSsv++CEZuUh2/uUaq0J8BUJlfQr60svbyLMYmSmQmQPtljxMLhvQ3wewLl9jd4D3dFQwuoHBaHSTPcPBz5/VknDEoxjcHVnYS4HVqTlZj3XiRov3SPSnBcjpk7LEszxcb0J5UnhnpA3ICrmuKv8MKeMiCZvFRxFG4ua9Xxj4rg4L8iajxAVHtNp3XnY9IWHRdKKKv2SLJCalIKU8w4WrCKxxkiIwIwdvh+55gfcMLpdshOydBWhkfs+fjSa2jW3pEv3jCV+bynHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB5782.eurprd04.prod.outlook.com (2603:10a6:20b:aa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.29; Wed, 9 Mar
 2022 12:34:33 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 12:34:33 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 3/3] selftests: mptcp: check MP_FAIL response mibs
Date: Wed,  9 Mar 2022 20:33:59 +0800
Message-ID: <f278d5dda12571f464f4b97da68a6627de3eea95.1646829006.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646829006.git.geliang.tang@suse.com>
References: <cover.1646829006.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0019.apcprd06.prod.outlook.com
 (2603:1096:202:2e::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5df38a5-e901-484e-bfa6-08da01c929c8
X-MS-TrafficTypeDiagnostic: AM6PR04MB5782:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB57825324C95644E71906D0B1F80A9@AM6PR04MB5782.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F5doYRvvDA6uk7bI6uRC6MEM40CCxNJbNfojXF4lrFkKu0eW6e69V0HGI0dVWxy3SuEhnKeGc1bsJbn2YDbWkxDVmsK24oq1n3jYWvC49yldjahSzzUhksain3Dkr9fZ+q5baTYZsSfPPVtyVcvIzpU7nriXocOkd112xHpWiQb5KzklY5/mCq3eACoSrE0MR/VA1Ky0xEAE+wNuhhP7lbVyy6hS7dskBvqsYDyGqMoJWRQNKfeWcS6nFuTwERhPAVFE5KqsBjukIlJP1UY1UQ9rul00fU1B7KpgK8WdLB3JnHOhoeFXGj0L/bMJ6QIlErTr9prDdY5tjRRA0Xzmq1bhXjr3drZ6CPCrG5EKG0SLCKP+NIxHgtTU2G2+fLTG4UKUj54T+YTqcPIYTM/99RqkmFlWbmp4DCE5sRWV4SnOYNc4yAbL5fwsM6vxsp48w34DkUXwrE58StnQ+5xkqZri/VO+deI2y25fd66jkS5QiPcm1z1Trqmotf6sazzktBMamiUzUcBGT3FXm3/GHcI9xzDxE0gqjxMbu2ZNvsyyv2YkgxWE+tPbkTC6OysQYVFYzs42AZLzBJynbRaz9ha1+1w6SLmslwV1hxaR6J576KDk6E/h0aodibN65FN0C7ALJlEewekAYuJDmvPHVuOMe2kYkytOiEq9GdfXEtRRJt5DC/+aFBmvKjJkbPVGocK5o4B4zKKnakA7Jw1MTA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(83380400001)(36756003)(44832011)(6512007)(6666004)(8676002)(5660300002)(6506007)(186003)(26005)(2616005)(2906002)(86362001)(107886003)(38100700002)(316002)(508600001)(6486002)(6916009)(4326008)(66556008)(66946007)(66476007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ux/tXse4nncLnkM+PHuI2vTb4G6VQXBAvB8vloW8ApJJa6FhEMNQ22c9qYxP?=
 =?us-ascii?Q?cxmMWHGr2SeRmkTpoxTXR3tBuvf5RkuW6tM/Wpqb/lZ9miIvoc5X/3zwdu54?=
 =?us-ascii?Q?vtMM/BVAijdKh+sbhlULdX9PteYIK9wimGcnEXq6Up/0KP0YsOmTP/nWdR41?=
 =?us-ascii?Q?5yOQ4OwRXEm9Ig4c6QDIbluGzG6blaK5KbmTCJ02nSItxiJ0V2ZTckPg3H+X?=
 =?us-ascii?Q?Xym7H4BLz6PMBkXwgGIvw38+2L0Awhzc1bS0TnDZ3sNi20DiTE2FiLdhyfjo?=
 =?us-ascii?Q?rGXvOjnLrBqJavklTXbuZ8E/aNomRZ7wFp3mDh6a2324jaueEqOZjGsZhdBL?=
 =?us-ascii?Q?DzA6wDbTnw92hDwzaq2eP2u/KBGhhCRiU50TMsTqp7gz868c00O+PBx8yEjD?=
 =?us-ascii?Q?gRdhSw8sGe9i5PZyNCaY6Ys/E3AWybkLV1HefIzVj4EUmHfnAK3E7A+UoenP?=
 =?us-ascii?Q?4kx3kfWDoHHImCHddT6hjJ/k27DUGgJ9giPiPCiDCp5bHWiX2V7ouCOOHwYy?=
 =?us-ascii?Q?UWNSVCE71oleCCHPEsl5ozw03guwSB2f+YieWBDoqVtO6hQg05mARtfvDQId?=
 =?us-ascii?Q?vOlv6dB5NF8S4OsCHfcGp7HkOqiqtOu8RUjb6OZRy2IU9LBiR8fbvHT8cZ7T?=
 =?us-ascii?Q?gia/ZdqTxfi64mptxCtdT5sco5C4BPgDPAmTh67Q8zGZPdgNlDLKYYXTqL3r?=
 =?us-ascii?Q?sbqTeX6RUlY7RFsHr2StxmgL2DYogLXGh088mwVoBEjDS3CWkm50DVbuLZrN?=
 =?us-ascii?Q?ngV4lKZ3Q6JjCQOXoqOdpsfOoCKUZD8/2qUmRqb6JexSOv6RRMhQ2KW1fp2Y?=
 =?us-ascii?Q?SRVUqt9OdZ4eKhr7xmBz18hIGYqiW5iqZ4OZSy0mRqFjqfXxiQwLwhcRy3Lj?=
 =?us-ascii?Q?kCN/DGcBFen0lej4UNVbxbToPWst52bbejLuKG2+GoCIemHF35FVcT8K+rJu?=
 =?us-ascii?Q?tk8X4FQAMJ21mClFeI1Mbw+lTROU3zltYa9A8mQBJ64+I/0/pc4efLpMh8ON?=
 =?us-ascii?Q?QZM/3I1hXUkWfUgOEmnhPSqOT7VIhn0sXYdXbsSrLaiJlSu1xhhxA24DO084?=
 =?us-ascii?Q?pjdF8J79T45w9kbqw5p07LZCBw6jmy2wi2iPBGh7qXIUYeiORZCCiw8Rs+GY?=
 =?us-ascii?Q?m4q8/WeoaPyLjBjg5wg0CMBJ/bN+DrpHwdkx4ET2reCkbmjyUfXUJdLNafD8?=
 =?us-ascii?Q?bKdxyPtN1vf8c+qK99lityBfqbESoFyNJzzl4UWRaO8pczoJl5TvkRXESKh5?=
 =?us-ascii?Q?x1ch3FIB2G1rc6ue3X6B9isQLMFe2BvDCqu8O1A3181k4ro46WbC8/sV6334?=
 =?us-ascii?Q?19DW4RnAk+Dxa82Lv3+KDGa0BUEgTUNyYfoIhteIZYHiWSsPUdawbJgffTtZ?=
 =?us-ascii?Q?UiWumWKp1xb0b57xDf2sPxvgNQxgQmQao88pXXlfJZCFH3Bf7bg9dv1c1umW?=
 =?us-ascii?Q?su2JHTghv0tL5HEC7zfKw2cqZjrkJs1eUmhApijHthdgyRdqwbxqvOjYNA/q?=
 =?us-ascii?Q?7eblIcGrOlfPC5BbaFAZ/v4O1DH8Aq6fmYzOv0Umb7C2t2ZCOz9s30xQMwKw?=
 =?us-ascii?Q?vHOxa0M6dWgSxVw8xH7+Es/jZ3Z+Y9GeSYDqN7qDeT91by8mth12S9MkblLB?=
 =?us-ascii?Q?8fKynR+8RiAcWs6bltanh8w=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5df38a5-e901-484e-bfa6-08da01c929c8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 12:34:33.0391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /p9tCnxpgf6Jc9xT5c5b/ApXsRTNAVj99CQuthdxLYvZQZiFnyav1lpCnBubukEiQlcHUAU69wuqsUPDxrt9CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5782

This patch extended chk_fail_nr to check the MP_FAIL response mibs.

Added a new argument invert for chk_fail_nr to allow it can check the
MP_FAIL Tx and Rx mibs from the opposite direction.

When the infinite map was received before the MP_FAIL response, the
response will be lost. A '-' can be added into fail_tx or fail_rx to
represent that MP_FAIL response Tx or Rx can be lost when doing the
checks.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 36 ++++++++++++++++---
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 959e46122a84..294396225f31 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1055,13 +1055,35 @@ chk_fail_nr()
 {
 	local fail_tx=3D$1
 	local fail_rx=3D$2
+	local ns_invert=3D${3:-""}
 	local count
 	local dump_stats
+	local ns_tx=3D$ns1
+	local ns_rx=3D$ns2
+	local extra_msg=3D""
+	local allow_tx_lost=3D0
+	local allow_rx_lost=3D0
+
+	if [[ $ns_invert =3D "invert" ]]; then
+		ns_tx=3D$ns2
+		ns_rx=3D$ns1
+		extra_msg=3D"   invert"
+	fi
+
+	if [[ "${fail_tx}" =3D "-"* ]]; then
+		allow_tx_lost=3D1
+		fail_tx=3D${fail_tx:1}
+	fi
+	if [[ "${fail_rx}" =3D "-"* ]]; then
+		allow_rx_lost=3D1
+		fail_rx=3D${fail_rx:1}
+	fi
=20
 	printf "%-${nr_blank}s %s" " " "ftx"
-	count=3D$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPFailTx | awk '{pr=
int $2}')
+	count=3D$(ip netns exec $ns_tx nstat -as | grep MPTcpExtMPFailTx | awk '{=
print $2}')
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D "$fail_tx" ]; then
+	if { [ "$count" !=3D "$fail_tx" ] && [ $allow_tx_lost -eq 0 ]; } ||
+	   { [ "$count" -gt "$fail_tx" ] && [ $allow_tx_lost -eq 1 ]; }; then
 		echo "[fail] got $count MP_FAIL[s] TX expected $fail_tx"
 		fail_test
 		dump_stats=3D1
@@ -1070,17 +1092,20 @@ chk_fail_nr()
 	fi
=20
 	echo -n " - failrx"
-	count=3D$(ip netns exec $ns2 nstat -as | grep MPTcpExtMPFailRx | awk '{pr=
int $2}')
+	count=3D$(ip netns exec $ns_rx nstat -as | grep MPTcpExtMPFailRx | awk '{=
print $2}')
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D "$fail_rx" ]; then
+	if { [ "$count" !=3D "$fail_rx" ] && [ $allow_rx_lost -eq 0 ]; } ||
+	   { [ "$count" -gt "$fail_rx" ] && [ $allow_rx_lost -eq 1 ]; }; then
 		echo "[fail] got $count MP_FAIL[s] RX expected $fail_rx"
 		fail_test
 		dump_stats=3D1
 	else
-		echo "[ ok ]"
+		echo -n "[ ok ]"
 	fi
=20
 	[ "${dump_stats}" =3D 1 ] && dump_stats
+
+	echo "$extra_msg"
 }
=20
 chk_fclose_nr()
@@ -2672,6 +2697,7 @@ fail_tests()
 	if reset_with_fail "Infinite map" 1; then
 		run_tests $ns1 $ns2 10.0.1.1 128
 		chk_join_nr 0 0 0 +1 +0 1 0 1 "$(pedit_action_pkts)"
+		chk_fail_nr 1 -1 invert
 	fi
 }
=20
--=20
2.34.1

