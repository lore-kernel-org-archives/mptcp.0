Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06452C80
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 08:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644397072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nj5HhsN4FBm6qCeTR1W9NK9GCfy0YFPY4neg9Svftjo=;
	b=nosBcmQxUxCaObfoZu7jj8D9QAhQsRd2pw99D90TUEQCyVzlrPxCTDELkQHn/0F2SfXljy
	fefkUvtj3PQ6tVF5vOS/uBtTHDrZuT9WTTZIKLM8YbSCSKVf8UUreyPcvQCLjbLIMyWb6+
	thiRhkG1l/ixXvzf2muCYatx5rzVzks=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2050.outbound.protection.outlook.com [104.47.6.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-MLqK_Ar8MGiJ4SRtWQB0lw-1; Wed, 09 Feb 2022 09:57:51 +0100
X-MC-Unique: MLqK_Ar8MGiJ4SRtWQB0lw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZzj1oRpZ6kP9COb9SaqFlEZZh1kEfDGxo9uhXqUJgtx+oVg37ATWzmRS+V4lplKF5ZTP2/hS0t8/1v5A4ENCfnwBIBg2y0zdpJag+WXo8kTpxsoOH/KqCdp7uUBUpKfv5646Q9nTzHPMJsn/3mB1NQ960bQ5hJiWVztaJrgPbmQsA0rd+midwtgMOzfA7EgozXwwJBBqxthjjhRSEbb4XbASpkWQ+tulxDu0+7gxjtE6WrUaN3QVs8z7L4/ucHdT6SS2bMsOvsj6K3Yd/TEvqZry0/4dLQi21QD/uChiv486uQiYCpQ4k8Q7angBXz/WUncIoAlYkiiaxUe3q/nqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIS0iiWvzfWJ9fl7EdkrYPiYbDH2CakyGvRIkVWp/kc=;
 b=HzRKALGsoV5XHqbSjnznhIHFFuyI27u3tdviW6U9i1q0BN6hX+dqIaAMRlpI2g+UV/0A9I5pFQCBeheEGV6rLvb1bAh1VgL+7sAGLRsV+l6b/kX/12m1SvMpS6BRlYqaRF2aphWK6pCCqhfm5cUs2OwYQ5FLNy/ig3RPKDq1tstX4v1wme7UutSY/8I10Iasio8+gO8vIObnSpRK4xF1Wi3Hp8xkwwNL2xlx4W+8Rl9x/0DwuIHEr6auIa6Z+wnKotXt74UWBNA/iiHj+cYtaVWoSS8JZEmcYlga4au+kAXbXeWypckoHBRvl/h5G6Jvooy3PaVaKvGkzfqgI3XqkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR04MB2961.eurprd04.prod.outlook.com (2603:10a6:206:a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Wed, 9 Feb
 2022 08:57:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 08:57:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 4/5] selftests: mptcp: add MP_RST mibs check
Date: Wed,  9 Feb 2022 16:57:40 +0800
Message-ID: <02b525e9e44709015b2331008afe169aec7add96.1644396927.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644396927.git.geliang.tang@suse.com>
References: <cover.1644396927.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0203.apcprd02.prod.outlook.com
 (2603:1096:201:20::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16ca6438-806f-40cd-a88a-08d9ebaa4008
X-MS-TrafficTypeDiagnostic: AM5PR04MB2961:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR04MB2961AEE7DB68A3A2DD3853E6F82E9@AM5PR04MB2961.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aTTslfmf1xBcLJXVnQ37HO3dPdmfI/dsTPbzEjs1ut1dhHa45/6+60zNqSOyUmEuDcicb77kYrAA6kZeioLXmQyvvP7qfgp2TepSrztXw2b86V6goFJz2KaBbYaUkJPWFKE2zYltMg00WWohUDw1z9RAzBfNuRyUQVJI+GzTFkH72VrCpJn1xw8Nc/itdscwfZEjgdtJt/AnljodBx2UO7KKHM0zN0XHAv9ltCyoCtbzq64y/bunDIQFQULl0xjqYp6Y7X56UfHnbyvHL1FKK0Q8X04jMEzQXpx/FIa3P7v7xf7CwerhB3CauaWRWS+HMM/ztvH3O0qBy9J5+dfeaudl2LbfN5Zzlptt2PBiB+Hzfv9JRXUvSpKga8LM12KbzP0+Shb5dCTquvWr9FkVkEgtObYlnbqp0uwq87sQc2rori7qMvuSYwa5Dpo5JTbyHKS7kEQwOVilhWrK74hr6xxDeJCN1PIoxLGUdpJovuE2YNPbFkYKPOkZrQA/A1oTkdi+Wl/VHc2IZKmWI9mn3pTG65Fwg0qsW+Z5RkgDXRzD2yOq5frFIAxvUoxxjor3PbKFWGS97IfUUbYFzoj20sclBCHmLn32yZGsNQ0k4iNbwEbL/iLmvAz3ZHqa2E5PnmAsTzoXCtDE/4EPAR2bqA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(8936002)(66476007)(4326008)(508600001)(38100700002)(55236004)(2906002)(66946007)(6486002)(8676002)(66556008)(6666004)(36756003)(186003)(26005)(107886003)(2616005)(6916009)(44832011)(6512007)(5660300002)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eMK7U6m0lKFkikN1Yna0aRqG9ByDjTfmbkMuDp5Em5K06VNdSSnPVHC1SFXj?=
 =?us-ascii?Q?+TJhyMCPfj0RYRgi9uKQ9A4u8eN21k/3ATjq5Qul2ipu4gaxWJ5qdOELBNRY?=
 =?us-ascii?Q?8j1UJJlTPvzElGaUWvYKeJBhLPOynZcNBRGrIdU76qYkYV1nit6+VaQy3Iw2?=
 =?us-ascii?Q?OpzWcP7KZGBKzbbduf8qDUiR8beY6dYFrGWeN7FoWFIsBgejvEdVnaeecJQL?=
 =?us-ascii?Q?rf+cwvj9RIr0bd5c1PbkxGtmtcvTFiMq4X82mCsrg5NRt4u0BiZUcHkhYb9x?=
 =?us-ascii?Q?MHn3j7AM6QvLqWo3Suiraq7WCp5O6k5yI5us5munvvQbZ1+qPEzy3pQI1v0R?=
 =?us-ascii?Q?HxWju+cHLejacqonQm6mnkC2AF/DQ8V6+44UIU3ZZlE32qp0eNM1+E6aRHXj?=
 =?us-ascii?Q?oUL/gofXIxalNU5ADrU/gLPPjUsD+tTB2mXnKPNDHjYulArClhDaz/xxVurU?=
 =?us-ascii?Q?IF4spmrmXrjxvpgbZTclHhtDzGxpnjGnFnIREFdqY5epjhaywhtlF2cme1Jo?=
 =?us-ascii?Q?Xt1EUMXLkhyC6XXyn2IFgBdXQgGBrl+8WLwraEQaFUhGZxkBW6U8FK+wP6bo?=
 =?us-ascii?Q?vXk9qeOCUGwgMBrcO01AbxgN+ipRm9NesKE6ZoEMijBMJuP+ZCeMbFLIN/lw?=
 =?us-ascii?Q?omTNpOYyYveRDWkHsRmJFbffLqe8TzpE9DTUAbzcKgEKDyLnLJ18uwvZuh+P?=
 =?us-ascii?Q?K2OtC8SOXVPKimtLlhYT9TUzNv5/Z0KP/GpPqGCa6ZUR3IOtbfa2/mpnvyA0?=
 =?us-ascii?Q?j8Le5E/PP5HsLN2eJJ9TDdOmIFFux81Lyd4qqOku3xb65V3ZTfMuNYBRuaJx?=
 =?us-ascii?Q?Ab2iTML/8dkDiqMRijdvh89cL5jkjCZivMObuZ5VGuVBYI7M4dG1rRfnRgaw?=
 =?us-ascii?Q?uh0Z8pOdXdrZhafAbY4IFUD3grL162IC2fyvRJ3op4tVQM33Yhi276oocAkm?=
 =?us-ascii?Q?LD8yjkJPzWrsfjpAYKj+csZz3EqoUdEOJTrIP5VbQSG0ZOtGQ48Ms40uSDDj?=
 =?us-ascii?Q?5mcfuTtakP1KrYkiVMNESzyNvte2a+yw/4DzIHQM7sY3jvtK5QpjrCNON+4g?=
 =?us-ascii?Q?gqS4bw5n6OTIrvRBtplGwtpvYJLxe6T/OeYX2Tc3eVXY8a8tdzYAORGhXuc6?=
 =?us-ascii?Q?yYBWwLIc3CS8S4dcgnlXIa8YBmeN7datgjpNAymNVAZ+QQwkJSQtP1uziZmw?=
 =?us-ascii?Q?H/cDivusfW1dbkTUEj+1GopLJRv1QWc8ZmhD0Y56TGaYNguH9fewGx6MOOV2?=
 =?us-ascii?Q?Nc5uVzRdA1uUPvl//H/bYoUtpk8rMH7KJp1Scyiao/+/CbC/+d5RPID8oJ2E?=
 =?us-ascii?Q?wAm7fErUAAi52Y2l8qetP4HwQdFChsCuVUlnNU/AUhQiPPGguNV1j76xrCE9?=
 =?us-ascii?Q?FB3oiXp5YLe3tNDTeofhErEorSNxOQ6GiBGcf13uE0y9Ezz6jaf8Ab5OqeaR?=
 =?us-ascii?Q?G/UZ7U3iDTwbZQyOVTaf/yWy3lxpziezuqXr/h9/N++Zm8viI+fhR86bwWIn?=
 =?us-ascii?Q?BhtOBoFMorYtD2P6wTnKqAa0gPgV6MNFhXt4hYLwPy5qU3qE5On1WxAO5vEN?=
 =?us-ascii?Q?6ZNW1Y5iQiSuLWcZZ/j1wMnTvdQiLA0Ev0TfB+pV2Wc5Gy1pVP1pIAtPX8QZ?=
 =?us-ascii?Q?z+n6qRPu5/DXlYnoIgiFTuc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ca6438-806f-40cd-a88a-08d9ebaa4008
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 08:57:50.1537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0d3LoZh3z753/OMW5bTVt+yXJ8p1DNZtBeGw9/mbVEwKj26M4qh4Qgo7D5hh5BjyQ2LDI5B0ek1Y3BcaauSHkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2961

This patch added a function chk_rst_nr() to check the numbers of the
MP_RST mibs for sending and receiving.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 3577716cd5e6..95d61c97ccad 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -782,6 +782,38 @@ chk_fail_nr()
 	[ "${dump_stats}" =3D 1 ] && dump_stats
 }
=20
+chk_rst_nr()
+{
+	local rst_tx=3D$1
+	local rst_rx=3D$2
+	local count
+	local dump_stats
+
+	printf "%-${nr_blank}s %s" " " "rtx"
+	count=3D`ip netns exec $ns1 nstat -as | grep MPTcpExtMPRstTx | awk '{prin=
t $2}'`
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
+	count=3D`ip netns exec $ns2 nstat -as | grep MPTcpExtMPRstRx | awk '{prin=
t $2}'`
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
 	local infi_tx=3D$1
@@ -859,6 +891,7 @@ chk_join_nr()
 	if [ $checksum -eq 1 ]; then
 		chk_csum_nr
 		chk_fail_nr 0 0
+		chk_rst_nr 0 0
 		chk_infi_nr 0 0
 	fi
 }
--=20
2.34.1

