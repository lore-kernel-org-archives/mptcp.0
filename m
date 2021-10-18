Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17BB72
	for <mptcp@lists.linux.dev>; Mon, 18 Oct 2021 12:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1634560479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Exeez92Ya2eI+5vo09cXtMBsysV2vCWhQn1AqetNvEk=;
	b=N3iv0G7XI+/pUBPMYOichNPjo40ef5VJYNLS7XXYlcKhoCNmD0p7xUwYl+IEhEYQ218a5i
	C5aut/aGrzjNeuZTBIH+NWoLKZsBGugOFIrz5H/9MWYg6/Cix+XOWUyf+VIYuhdGwvMTnl
	058Ke07nZ8rERhHktH5jGmg9tg/Ap9g=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2056.outbound.protection.outlook.com [104.47.2.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-1-oSlrJLUAPhCNOwRWzrChRA-1;
 Mon, 18 Oct 2021 14:34:38 +0200
X-MC-Unique: oSlrJLUAPhCNOwRWzrChRA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arEv2Sf+V1XvlNpONM1pMdT+mIryNjOqd6bWS3a6D2XT8CtD4TLdSWpGWy1pr0FNwDiAvJCoo1xRkJv+H6Qr48YBmGEHUOsPZ/ZSnR9Jw0Aj+75SROyaNwL9YEcqE+mxMAK0q6tO4500Raay6Tl5a1EW+epNYnT39mtKnAm2V/auOTaxfqQ+NxsMZ8FsiK8uy09om5opdbFAelXG04YHdhDkbCGfsQQiDPSoxKrd1xTVevuga/8C1oA5pGYJCM+en6kOehGmVzcmHxcj/cP9Kb/j7kPMYim0J4liCoVZ3T1qwSvCNbztzT7v86DcUPVJkv5wF84SO/U6STvvj/xgoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XS/jsiQkXhk+mLJvBB91SlVQTLEQXU4Wf82OtJ3tIRI=;
 b=SFB7yDienZ4DVmDkOUrmmGUIASig9gGtRZ1Z66owKJ1ijSADSxM2+Nzt+fH9/FDC6t0aofXbUv5wvS7AF9hNmtsR7IzrFpomJgODJsztnjnefL8r7k1dIHNDAxYBxmFjWcTWupQMpM6qvAmoHEWp97uBI8Hid55S+F7vJ7Usj4pB2xmB/cPDzIOzOFhZMgUFymMrqYTc0AZSU7+eeGfI76u9G9Lnhse5rUoLGFdeOTSvLttpy7sTu8ely+hBDPOiefBa0FIiLG6JotH9GK5XQEM5hYH09gaBE0/zM0Q/2S5TrSaXlKVS3GU6o8VBJbC5d3C8jnm2t6gjM/AuvmfBhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB2956.eurprd04.prod.outlook.com (2603:10a6:7:1f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Mon, 18 Oct
 2021 12:34:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 12:34:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 7/8] selftests: mptcp: add infinite map mibs check
Date: Mon, 18 Oct 2021 12:33:14 +0800
Message-ID: <d9d2717eba30644f5e3816e01c6918628f6bc2ed.1634531093.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634531093.git.geliang.tang@suse.com>
References: <cover.1634531093.git.geliang.tang@suse.com>
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
Received: from localhost (2408:8207:2546:b4d0:1867:9999:db2f:de88) by HK2PR06CA0006.apcprd06.prod.outlook.com (2603:1096:202:2e::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18 via Frontend Transport; Mon, 18 Oct 2021 12:34:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7f55ad9-e427-47a0-4785-08d99233a48f
X-MS-TrafficTypeDiagnostic: HE1PR04MB2956:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB29568BBE143F0FFCA8110E10F8BC9@HE1PR04MB2956.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UO2YfrG2/IQOYgU/7tQTcv0TuLHtDc4AHsRMumPT9++B3Y0PlkHyhJFPgAg9HRxFe3oUlfVeVgoxTMyO0urMLgqgh+/eSdLbvSQdLAidVI+T5ZJXa2BZChofsTmR70dhAJqlFaOyd5gLZm+O16E6I79t4W0Wuo31i67yxaOU3alSCyOZ19sqf3XsEnnn2uVU8f/QVHhP98E4ZYipj8hknxsChwJWYR2PSgd+7dM873qwqZbFy/BvKRs/M21SsJT/jhsvrP21M1br/jHwR7W/2mCjvNfbO+dLjML/lcaJvxHJMjGdY1bU/bH/bwZfPdRO18mdvKVVyD/RCb+DEgA8eNEsS4nj5y9dIPHwLDyCKhOYLdzqSTQI5XecXIZQF+5+682JHNS3gDrH5fdFQlqvxIQLBHpk2s/uN7rcGNLTXAIxLvoeFm2YrqB1EFbKVZG5VVluzzKaFRo6DMTF+N/9KselNUB1nnSLk7dMKFRjYLIVegmNuqYV0Tn0ABLE9vM3Ln8UzbdyJEs5ugjhz58VJ3HDzlYm/iBmYNbGcpmO8VNxLw0sFnV55uUDvnEgHD9hz0bbeaEDDAVDmWzY3kz3VRSsBa7W7QSX/SZ+8TqMHLATnjjlsCl9mUG02bPaB4ghzVV1VD8+D6Xl2jLDEKJuZg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(8676002)(508600001)(86362001)(316002)(36756003)(66556008)(66476007)(8936002)(6666004)(186003)(6916009)(4326008)(38100700002)(6496006)(6486002)(2616005)(44832011)(107886003)(5660300002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9aYYVlkWEwVSU2BQ+MYUVYG8PueQyfheTG8do/Zotp9V3RZd4dB3JEiW1Cig?=
 =?us-ascii?Q?VTnR6YpD1LwVguDOvexRTfwLJVcl+b7ahDRiAgA9LedkY7/yfOTWab2GthIQ?=
 =?us-ascii?Q?W3tb9f5UlDdk9MHdJKE5A7I0ciwkG1qeeYTJCtARRiqfuSKRbfD3gPP1Rz50?=
 =?us-ascii?Q?9/fm8bBG2L+E0xpTFci7fXqhUK3Gohk6XY+Uo42cMBMJTSr3EuZhxv5iKeWZ?=
 =?us-ascii?Q?xEkYye8ZUtgp+sS5KGDD6J5TLX189FJfJJ52f7bbeiJ14sgXiPYNWkaw5Lx6?=
 =?us-ascii?Q?EyKFbDnQ6V/jA0fzG7qrD4/XoB4bRD7cMZoPjAFVAdeVJWeA1CPjCxm7XIRP?=
 =?us-ascii?Q?zUQiVLk4Z3YVdRnvuUaYHDct3SlPgvOKHMBw3lzXTOOs/cjIomNlGj7U07jd?=
 =?us-ascii?Q?hHe/d3byjM/nf6yivbQpMwdujqbFF4TuPYH9hbZmRTvMpWwlm+CdpdARYctJ?=
 =?us-ascii?Q?1SRsncNjk0S8hXE+N4qtO/GiLLsFndjLRmQ6brInPEQJsBCL/dp5cXB0h60i?=
 =?us-ascii?Q?APLdSSiLQwdTwCjaCdRMZtk3hzS+cLPM7WYyle5TB97G85hgTAxwS0zMhwgw?=
 =?us-ascii?Q?5xOyGZxQAr7acZF3kx+QD1lyCtKx6ajnOcWNl2pEuVmR8mVenVjrWsYSMTpS?=
 =?us-ascii?Q?cOkjOa3XGg28V3d2/+hogV+4UEZ/DJcCide7UPayQO+5dOnYyec9n7EwdIyR?=
 =?us-ascii?Q?vRuQ2wRWq92DUY39W7RLdgIsQxG95yBcRFBPF/geg9CeqfKkMY3tVWxL7nWA?=
 =?us-ascii?Q?CMWt9MNmqOjpZKgOfiLpkm+udQmhGN4PFWtUyiZsBq2Tzs09qrwzb5NHPVe/?=
 =?us-ascii?Q?RuwSBKmxN9Jj+Jx3EZIA3YeQjDBBqHnVIcD+jNKQPbLAxgGH6gvjjfFMng0H?=
 =?us-ascii?Q?dOreXXZu81NaOsiC+dsEOxMdP2qP9T4ydUAjMWnbDK9x1b7+RPuyE7Sxgs5Q?=
 =?us-ascii?Q?SsfOl4O2+fyAeZsq4o2T8Fr7e/1L8AxU0TgGqjAjR//SJU8t5eMQlwWBTE2s?=
 =?us-ascii?Q?3u/pS4vSp93nImxEr9erG3ceD31aw85EDSFsT3im2FjVTUQdLzjEMF0PxKt0?=
 =?us-ascii?Q?QPkipI3K5IIpy/zWaiVyvCvsurTsotkCTlXRLWqKsQpxfq3mKIl4rLPId+ra?=
 =?us-ascii?Q?GIYTV40sV/1g0oFbZCzS0uPLy77GbJJ8sFCtoiBybdW4eFVWsmem3RVJK2oR?=
 =?us-ascii?Q?nuwvybMf9JN/9HYtVqtaIBMGuKazDfmrn8LUKyVbB0LOjluokhGyDQO3vrv5?=
 =?us-ascii?Q?iS5MNLZGFw/GG4PZtc7Ad2cDUILNYAXRql17iq4WHqZ44fFnpCTmAFZJQFdO?=
 =?us-ascii?Q?Vq9HdZbFUA/3W30c72soUzBD2zY0070oiS2otxWwmiB0yLPf5Lp5wEQus2yR?=
 =?us-ascii?Q?1IwtNkTRREpZwNotknUv5B06QHaS?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f55ad9-e427-47a0-4785-08d99233a48f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 12:34:35.2605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PpiTUxoU87JvZ+lYvSw/FEkcUrBxu+epUkg3wzmjVoH8Sd42vBwU/Q6Gn5DrGbQ5j38TXyFXkahMfwuqOlWfdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB2956

This patch added a function chk_infi_nr() to check the mibs for the
infinite mapping.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 293d349e21fe..b3b351b868f9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -615,6 +615,43 @@ chk_fail_nr()
 	fi
 }
=20
+chk_infi_nr()
+{
+	local mp_infi_nr_tx=3D$1
+	local mp_infi_nr_rx=3D$2
+	local count
+	local dump_stats
+
+	printf "%-39s %s" " " "itx"
+	count=3D`ip netns exec $ns1 nstat -as | grep InfiniteMapTx | awk '{print =
$2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$mp_infi_nr_tx" ]; then
+		echo "[fail] got $count infinite map[s] TX expected $mp_infi_nr_tx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - irx   "
+	count=3D`ip netns exec $ns2 nstat -as | grep InfiniteMapRx | awk '{print =
$2}'`
+	[ -z "$count" ] && count=3D0
+	if [ "$count" !=3D "$mp_infi_nr_rx" ]; then
+		echo "[fail] got $count infinite map[s] RX expected $mp_infi_nr_rx"
+		ret=3D1
+		dump_stats=3D1
+	else
+		echo "[ ok ]"
+	fi
+
+	if [ "${dump_stats}" =3D 1 ]; then
+		echo Server ns stats
+		ip netns exec $ns1 nstat -as | grep MPTcp
+		echo Client ns stats
+		ip netns exec $ns2 nstat -as | grep MPTcp
+	fi
+}
+
 chk_join_nr()
 {
 	local msg=3D"$1"
@@ -665,6 +702,7 @@ chk_join_nr()
 	if [ $checksum -eq 1 ]; then
 		chk_csum_nr
 		chk_fail_nr 0 0
+		chk_infi_nr 0 0
 	fi
 }
=20
--=20
2.31.1

