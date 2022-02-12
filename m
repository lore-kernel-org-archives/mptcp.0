Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B270D257E
	for <mptcp@lists.linux.dev>; Sat, 12 Feb 2022 16:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644682552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b3SYO0SO3CvFOAVRDcugHEO6cAH9tGUqAMn9HyqGnGM=;
	b=YKr0mn0gX++8w5XufMnaZGF1UyrXK4gXjEAowZdFITTOkzs4mVwzZJ/icHgTlDZsH0RSx/
	eWg9Ua6dK9XDzPjoPqzMLa5O7VG2pYVJAwrft/wBHmMR1ZfqPuhhdMbOT6BxBOuPfDYvi+
	a0aQ9a2JRlenA3sPOMkFjcmnz+cXcZI=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2107.outbound.protection.outlook.com [104.47.17.107]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-Crubm9s_O_KwmiBChsa6lw-1; Sat, 12 Feb 2022 17:15:50 +0100
X-MC-Unique: Crubm9s_O_KwmiBChsa6lw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQh4czzTvsYAnA1gXwI3zgk6MiZOMxt2aBYjXMWO7pcomofEHvOcqi4m7ql59+lPFsJ7xDDr5lpc3yUR/Y6YTmohLV23vdHFPhMLWDovp4B+76qN3M1u9krn1qxVOrzDfP8qeMjJasQ3YcKZK7yrLuFzSXISunRVEybstkFvUOLXot6nKldmFQpDY2ttKtyP1aWde53y5nnvXc/cuN4Poa9BC02Xp1Z4bFChDw3lK6PvgLP0qn8vMEe1ETyyIzKs9Q8sTEz+vCJ05mpf1g+O2wN7dDNNHF70mnQHs400SvRDPM5Dz9XUUSAtw2SkNC2QTanlMYMeQhmKnqnUIkqfnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hcQdIFS6xCmj7QJ3YF3ld5O2dZadoF899EHSAeTv3Fs=;
 b=OjcIq8SIS7gM1l9atcHcICSWcgb8Nvo24l80GvV0upIqIVqAbEB4jmZuQZiNlE1CZeikzP004HNt7NQzqhGOUSqBja2BcE0TANXqMadhiS/qKI8NAoty25MCI5zSiMkkymqTPP4QQgATiy6uEDseSicmCYEkM8Kri2AzkoG5qDX8wTTKQ/j4ACnYNnVG/AbK1nCVvKvwJYBIumXs2Hl3M1yIsPuuTDC/PUtRt9wVGhFxdf6ygtc15llM8+mTwRxbJdwTvhowinJkVyVm3Uw3BUKq64Di/Q2FrrQzzgFAd+3J4MHta2K2nG0uLy9JGqa86HfKkEWj/3p31EW2QJp4pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6548.eurprd04.prod.outlook.com (2603:10a6:208:175::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Sat, 12 Feb
 2022 16:15:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sat, 12 Feb 2022
 16:15:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 4/6] selftests: mptcp: add the MP_RST mibs check
Date: Sun, 13 Feb 2022 00:15:38 +0800
Message-ID: <207c13257bee474162cacb9f2564fb5b30116a28.1644682054.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644682054.git.geliang.tang@suse.com>
References: <cover.1644682054.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:d0::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0814596d-c74a-4eb7-2264-08d9ee42eefb
X-MS-TrafficTypeDiagnostic: AM0PR04MB6548:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB6548129D1E0326EDD833F991F8319@AM0PR04MB6548.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jYLtlx+XGDAylLNcUzNZPzKX8xtPMPfgeC8XwPPOcI3kkJbYRrvTxn1j71ocs0YIKcdL30khl9b+SgKlNPkhJ/c+rMoszuODdj+V7FLhQO+9Ccz3QI27vLOik/UHZ60LSS8ExsfNMz+X0ERTWJd3hhAbT69s9fmB+BUIKZNL2bHA6j01o7YEPsY0w4BOmFCZorZcPR9kjmBcxIE0asgnrnm4UipVBp+WJGwrLOzt4Dvn/iRdD2+G6GOi+wRgAOABIh+T8CQ3fETakiN5WVt3OCpC2nwLBqxtVnV7EBfEl53335qsOKe7LgNinmdkm1i1dOg2pv9KPXwYm05Zo4cWWaVNLEKMW68vempjBrkjwGhAZ7pb+aEUyREAMXVf96E0uw2O+iZ17+eJKA19yE/FEj2joZpSbdQ1NHp6TEiEpNIblyVeebzvzCTFNaJoTw9p9IEpc6yriRjyGgJyha/zjXUbS0v6UO3Z03GLzo5QhEnRn0usy0+K4GPtEzJbSA7B+VkJ9rrA31Kl/poKOxep1A2kHa2+bzkEBgZBNvA1d2pmybUuryP5UOrgSTiFFrqkAxhlsgRF25sIb/VrZv4tkRcvJ0vqUhfAFDx/sukgco5PPXc7J3822dT2SwKtdjIgKhjOy1t9KB5h9ga1RCoUZ+QnB6kqz3v2T4TbWLkvCiERK4PNKJyrtqXxLLE6ZMjuIwh4FibaC0qlXgI2es6u5w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(6486002)(6512007)(5660300002)(107886003)(38100700002)(8676002)(6916009)(316002)(2906002)(36756003)(8936002)(6506007)(66556008)(508600001)(66476007)(86362001)(66946007)(6666004)(186003)(26005)(2616005)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yCRdo6TXChPhZhPDMa2PIl2Q1mur73kSEyfYVAlMrd/9Dz7dtrP39YUbIuHi?=
 =?us-ascii?Q?y72c9X4ZXs6EfMxRzSmbSxYpNKhGyJA3en3l1HtF83guEyGd7OSo3Fq5n5Es?=
 =?us-ascii?Q?Zrin0ysrxZZ0exQVINTZslBijg/Hwes6ZO/j9d+W7d6sztXfz+xGtpTpRttB?=
 =?us-ascii?Q?EbAuSc5Ho7FB4eQM43Ka35Cd1E3JfpBUDq0gwwFGM3cclQqFim4ECiQfHlOf?=
 =?us-ascii?Q?Cjgll2LhbqiqiXGFh9uanN800HA433U3rT7w0ZbeGJkfGoXCH0k8kic1jcZ3?=
 =?us-ascii?Q?usyRkbp1RnKh5UE/iMUOLDLVtvKx41ZCOGnXnydOQSfGLmOJRDzYX+dWVlzv?=
 =?us-ascii?Q?b+MQedy7W2LnfPfAQxayZd8loWu6Jkmai5KAGX3nxDDlGhpfS0ndYu70bnHf?=
 =?us-ascii?Q?MxbKIMQLxycCrb5MKPjB6WKge4LfmM8T2xSBjhVuLJecK0NmMTO6+Noez/8i?=
 =?us-ascii?Q?3zNE30u6Pjs3nsO1mwXliKau9Gn03v3HdqWbvEGEAAcx70OIWzZ1FcCBj0A4?=
 =?us-ascii?Q?JXtGFsx5xeZTS8HwE/DTDQF3S+29IajA32AG5w3CjmbIk0QmgU58IXKP1kJt?=
 =?us-ascii?Q?pBRqogFbivjznpyUl0xyaWIKVGzYRzUNxk5EXHB5jgkVE8EP8TmciTf3EKd4?=
 =?us-ascii?Q?6KIvcYRHiFvLOHZz5Wx7XXz6AybHWmXZFZZmccDaSnnKkXCnPenyJfqkM9Yp?=
 =?us-ascii?Q?9hhGMLIX61XivNxRGEpWRXPMSmma6Tz7SCgp0GwNFphTa0rcKuBytUdEY6qS?=
 =?us-ascii?Q?7pCOXs8NZPcesIcxKNzrqZX/whPUmUfa9aDdu6WaZvbt+NHq0neoyqjaq2Cb?=
 =?us-ascii?Q?DU/yelrZWVi2xKMiaLXWzySaItgvrI6bJAH5BJ0vdh1cabECPX5TE0tOfxYH?=
 =?us-ascii?Q?LhgRZOmGpNzv+rOHp/XtcF/+c6a25gKMJtwQ8qRYTIdEbI+3KKyeAWnn2HmR?=
 =?us-ascii?Q?r2ilUq7gqGF5cm/P25usDv0UNCgVh4iu1qbl+Cpt5ALSHnVk38GAPJqL5Nnp?=
 =?us-ascii?Q?LIhDe+1Z4vs9Q81EItGYsCI/cQJc9yAlSDHme/Ldayl/QFFi68xmU7HW/rpH?=
 =?us-ascii?Q?aCZCXPSJtFIZRi9obyqItx5o9qas/1rvedEpP+3AdJdPPkd+nbiZSiVY5wpL?=
 =?us-ascii?Q?JQ6r8k8XyJ6H7x3jso97hOPaqfK+0erYMtI5pZwxiuh/5IOBM42cESE+8NGm?=
 =?us-ascii?Q?lPWxEVg7sPhr1DvF/tzF68Bxh5SPWlm54Bdii9oFlyeoxt9el+GqeUa11ggU?=
 =?us-ascii?Q?noHl66Ea/zWEh3Io82sj2Fr8+j0X2CaJLvxBW0+F1y/zFwIjYC3BsJJAyXZk?=
 =?us-ascii?Q?woNqBkjBIGQJqb+PinWNoImOJv+EzFBezQ5gTtaXZxKgD3R/iZ6mkG2ae6zb?=
 =?us-ascii?Q?rbu2DersBXusss9BwOzrvp0dLFHoXLeaDZ/hSuvbQCGcmmzv/ewl9U8KdZp3?=
 =?us-ascii?Q?ePsrlKDDMxQQbJowzvYdMPCtGv6IaYMWcrGp7/fIfVLK5qM80Re08N1DcgVZ?=
 =?us-ascii?Q?WbfHtivUf5tInJX5BHDbJ56wUeG/NDt2T+0S5CRKdH8Ia/Fw32BjxsWSs5PG?=
 =?us-ascii?Q?yoRF1NphyUuStwmBvEeBWT+zfk4PrRO2jxyaIfPkBST8qiAci2BpgtoN1HWT?=
 =?us-ascii?Q?Pwo7+k7y+L+BuSyJ/2QtU8M=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0814596d-c74a-4eb7-2264-08d9ee42eefb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2022 16:15:49.7760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4yVqalmy8w2ZxRYHAduhmUhtzhrq7WIcdU5tjYMxU+VD6fyFNKwLkNfj5DVlxEmNGsGR/vNz3oqHv1Fn0rjZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6548

This patch added a new function chk_rst_nr() to check the numbers
of the MP_RST sending and receiving mibs.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index f71494b87d5e..000272eec5a5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -802,6 +802,47 @@ chk_fail_nr()
 	[ "${dump_stats}" =3D 1 ] && dump_stats
 }
=20
+chk_rst_nr()
+{
+	local rst_tx=3D$1
+	local rst_rx=3D$2
+	local invert=3D${3:-""}
+	local count
+	local dump_stats
+
+	if [ -z $invert ]; then
+		ns_tx=3D$ns1
+		ns_rx=3D$ns2
+	elif [ $invert =3D "invert" ]; then
+		ns_tx=3D$ns2
+		ns_rx=3D$ns1
+	fi
+
+	printf "%-${nr_blank}s %s" " " "rtx"
+	count=3D`ip netns exec $ns_tx nstat -as | grep MPTcpExtMPRstTx | awk '{pr=
int $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$rst_tx" ]; then
+		echo "[fail] got $count MP_RST[s] TX expected $rst_tx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - rstrx "
+	count=3D`ip netns exec $ns_rx nstat -as | grep MPTcpExtMPRstRx | awk '{pr=
int $2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$rst_rx" ]; then
+		echo "[fail] got $count MP_RST[s] RX expected $rst_rx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo "[ ok ]"
+	fi
+
+	[ "${dump_stats}" =3D 1 ] && dump_stats
+}
+
 chk_infi_nr()
 {
 	local mp_infi_nr_tx=3D$1
@@ -920,6 +961,7 @@ chk_join_nr()
 	if [ $checksum -eq 1 ]; then
 		chk_csum_nr
 		chk_fail_nr 0 0
+		chk_rst_nr 0 0
 		chk_infi_nr 0 0
 	fi
 }
--=20
2.34.1

