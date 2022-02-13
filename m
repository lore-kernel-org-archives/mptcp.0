Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D98373
	for <mptcp@lists.linux.dev>; Sun, 13 Feb 2022 14:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644763090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7DYmG2SpBKPmo3y3XQSY3K4PCUi8iqo5hh0RJyqVO6s=;
	b=JxfwGTO3jfCnz2yBkQKulOyjPVwzYuELjywJukB2H9XthokJHT/vrebDPSrzm01XlHNBWX
	wXrO56dFNqGlG8ss9aZJ1P5HkgvKV9xjyyQuHaNIY+/g2T+afI/9b3ap7v1pXuZqQhmJdd
	UbLk/FAiDgY+vHraFbn2+QSgkQajgG4=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2173.outbound.protection.outlook.com [104.47.17.173]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-23-Y3edJYVjOSusN4E8y4WUgg-1; Sun, 13 Feb 2022 15:38:09 +0100
X-MC-Unique: Y3edJYVjOSusN4E8y4WUgg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keNWL7Ewe4zRxK4xAbIadOAdGuA2F0VtWrMbr6H88kSPvTYyNXbvOPqlZ8p1N6VqfvMAy0kzpjHchmPvnOQs3Vdajc1R3d4ZwY8ou6RKghP4k7k3TCwmV9bmSnh7bKoYKb88RtNFXDVxHeTNwUifbLx1SoU/MQjxjTa3l0h1D4E7WY1Lx9b90HoMZMxyutz/hmF59/LcS6hBXMgqE4RuOL2a6f9/paTH6DGd3YJaR2HFWsv0hNlYI0QU5l6ebT1yq+zJ8jm3X014+7k9325yusj5yxZUWo2a6H9r9k3twyneFHsd587Nnd3I5hngpzLpsoKe8w3s72Chw20OHN4Uyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpu/CBI2Ea7d++sISM0ZwSNNcaOAiTc5KzE5eoOlGG4=;
 b=jw5ElnwBzAGf82orbr4Sp+GQE2LagJqZs4alqgpvP771f1m5UDypTAYgTXpnr2r9Dxfp4qLsan8LbNlXH4K2tFBx75DiNOay+e/z0UABh/JgkCGmnlkllEasK5O2o6Em139uJn9sd6dg+ce5twq92GRGt5XRydmMWPdNsWB90hBc6zIVff1Gw5fgAJFHub0YwvUZwA5Y9Lx7AJ5/NFYz0ZIb4Zxh4LLzbVknKmCQ/uRu8WieoofOeLpVCK610Z0tx8hMNutIxobY8mAyOtTxjkTGp0R9UFa4BW0PctMj3q1z63KTWkFaQC2DLj5MDCWNixVvzgP4JFGt6mqn7J6B7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB4246.eurprd04.prod.outlook.com (2603:10a6:209:50::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Sun, 13 Feb
 2022 14:38:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sun, 13 Feb 2022
 14:38:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2] selftests: mptcp: add csum mib check for mptcp_connect
Date: Sun, 13 Feb 2022 22:38:33 +0800
Message-ID: <068c6ecb38fae8a5c0a67097b6a8c86896a27675.1644763024.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0146.apcprd02.prod.outlook.com
 (2603:1096:202:16::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3199032e-5ffe-40fe-7095-08d9eefe72e3
X-MS-TrafficTypeDiagnostic: AM6PR04MB4246:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB4246FAAAF1415FB026784EF7F8329@AM6PR04MB4246.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zWk2rY9wTkN8ZS32JvMYLmEGHqgcNwem+Df6ZZeF94XIPlgrYC9pAADZExN1qgG5dwj3idcJ2i9Wl+0ckzGQtYZLiPNRXULDWf6BJlLS5UYH1lKdC9MoIZOG2JoLDRygwZLiMHYZqexUYyPRCxQKbkjGrCH9LzJ3LnrBzt52X/Z26bGRsi/FaOotnHH1LuA5XOc/57FxQisXoVMQuTO+g58FZ1QfAMGm/elwD4X7pElj3oVTRZACkeXLhEuKC5KD33dWb/M0mLeRXEPi4lwXJZDYFUGtCxJ8HzaLpIm8VTGmetD9e3KKeyqvM4KfT2Sll1wsmXQmmHOfiAOwLjgUc/TFtEgjIyTPy+pdVQp7lVbqqNE46fT3ARfSb8v0HmuHQbOQxf+FFulM69VBI9ZuEPYZ9p6w+mA3AyfqeOgav3Jdupbru7hs6heLRmajO9EO4tVzaytNa5xgpmwiEX+ycFCcvwjORxmQ+EoeNF4EdlImMKr38mAzocjk9+LKTlThik2ELQgpO4O3rAp5W8paRtu3bYCLkxmu827G9QdLy42c/LwUWnCmy6cvBrEEUKBZzmfE0MIxMdumX7Hct+A4YQUymCE70IRMFlTe80QnftiVSz1tS5m++O/czlgTg1Pvgai1rFpDBNIbYzgdjxkbOWoBQNFnw20/hV2oOEfJV+Axo14sk72KseSSO/pEtN+JsoPYupy5+ybL9QFBOE/gvl5M6OdLOSVMOu2REd+sPpM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(2906002)(6512007)(44832011)(2616005)(5660300002)(107886003)(83380400001)(38100700002)(6506007)(36756003)(6666004)(186003)(6486002)(66556008)(86362001)(508600001)(8676002)(6916009)(66476007)(4326008)(966005)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+s2gsp742gpuLEsOTvBWPWsH4o4zv9FNp/Sr/f0Us7l47SllavP5+powZYmJ?=
 =?us-ascii?Q?U5s6Dsg3v+D3uA16lt/bt96uK9Z7mDBe1ys3AG+awtJAAfcFth4WgpiUXMGj?=
 =?us-ascii?Q?3rqQ87/8il6HVkKcTckW29TQ/RcWVX7xMP1UGhBOLz1tlHhxibH4OWPJIN9s?=
 =?us-ascii?Q?AM4KJkaAhfGjHN6m9BkB/iGXVdn7gTikYjn0KH5F/lhnpuCmmuuucvmaD0fW?=
 =?us-ascii?Q?OYHzFOHZeScufO9AFgeNCA85cjZLaR5qIBhwJ7Pw2BsIuGyPuB69oXJmQmem?=
 =?us-ascii?Q?JReNicxLergs5OQJyw4sqgcya5DrEvOAca6667KZUSijlzfDuQIDShGvxa11?=
 =?us-ascii?Q?T1u86lhGiBdqhGilBGoDHrTps6nZ+ZZqYktIG/W6KGBGTFUS2HGJA+7FmYq4?=
 =?us-ascii?Q?YlbpGGlREYbEu8Hz1kCNef8n3+kGDifpe1a+3o3d1JAiRYjVa+3csjLomg0p?=
 =?us-ascii?Q?D74Kf71GXenDixaUDk5niqssb03fMBRG7OiA0jDdbNM0FPkB9a64BmHSpih9?=
 =?us-ascii?Q?KwncWgps0aK40avsdBNkU1HwKZwN8gdPEVxGZhT6MExYo4zS/b1lDAN0DY+6?=
 =?us-ascii?Q?fIbCg4o0OUqwZvs3ovCgvwC8oT7rv6cJ4uVJGczUJDQ+oaJEwDByBuWJ4Uvb?=
 =?us-ascii?Q?pOCYNUFmT0WzCTXJPR39IdiqMy58acb7WV1HKDSMxl5duGZQ9PtixROrXNRg?=
 =?us-ascii?Q?q4fbXijCOlU68+Y1vu7jiRoA0N/uiJxzURFn2GIJ4GygzgbXS+I9HU3DxMlM?=
 =?us-ascii?Q?HMaoelof+oiSe9pXshD5mlsBT0hYGBBz2mPbbzgV1Y642G7O5RtXG2ikErrb?=
 =?us-ascii?Q?qM78gWTkjSGkI2v/m+D7NK/IrKEnBaEuDdZ6ib77Vskp7r6m+85fPJBppkRM?=
 =?us-ascii?Q?EPNZ70vMx2ULaSeJ97ZrOLVnSK0gmDTyRizBuQU+ocZtJZ+QuLgmqEMbXhpm?=
 =?us-ascii?Q?XTzzCz4eOwLNZdPLkpaRFhl627DQAYAS4qFJPCtF1ySTQDgJQbb1Qo0jtukD?=
 =?us-ascii?Q?uqvQ/Hx6WhNrnA6JQrqACiHOvl5/6JO3zM2hcqQBV3MCGIKiCvYLJuSD4cB5?=
 =?us-ascii?Q?vzYiilLtwaykgtdcn3Ld6cMYdfcUaSr32dYO8nNrqs4JJ543bqlJk2NYNC5D?=
 =?us-ascii?Q?L5vzyPqNEi2/I4turx8EBXM6Bnr3aGSU1MmoP+f/BYc/naPEasVU2bU3Rxn7?=
 =?us-ascii?Q?k8uP6xRHM43uG1ACpRfHsWQfO5hdnmYbLyf/oNpZ/ulTx/MyECjL/c49HC2g?=
 =?us-ascii?Q?yDFCpKJ2Of4XMjOS3VNR/5e29xvmA77/0+Amul1bkbSJ0FwdCRxFGmJCJ9J6?=
 =?us-ascii?Q?TXRWze9D07wJOaXkRdRjolj81MsBX1hcRbnJl8K0yI/oxMKhD5Cs+CcS1zwo?=
 =?us-ascii?Q?NYFICCCKNMLtZYra/JeGbrpVBkhJl0OPcG5ap+v5XdWdMEO6niJQvY0dmwL0?=
 =?us-ascii?Q?t6MUk1L2Cnk1nD3l+HcOiRYxVJq0hN3bGsyv3i79aaT76BBUGCYXeUGrzsK1?=
 =?us-ascii?Q?vl+eTTFqQoS5SbeeJy12Dmye4gFjLLO/FGdaaAbOHLHgWL6Em3lJx1VMq2en?=
 =?us-ascii?Q?WDxBQgPMjRcH2JY1cJO9j7fZlivxmZiO1AL2C7KHKOE0wJJeSVv93D8mB89K?=
 =?us-ascii?Q?WqOcuGr3SD+frygr0KPxUwYJOxAkb8sBcws7EjhmgSoZPNPdlEsXW8nkCwqj?=
 =?us-ascii?Q?uHlcH9lB9M0yPgfGwn8dGhcFTq4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3199032e-5ffe-40fe-7095-08d9eefe72e3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2022 14:38:07.0778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4YkeR/uevkuU3airIQ8u9SxgoY5gE/GwIHmGt/2AZjfYak26ME0/+YrZh2JyKeYa+fC6HMg2AYK6NfQzoXWgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4246

This patch added the data checksum error mib counters check for the
script mptcp_connect.sh when the data checksum is enabled.

In do_transfer(), got the mib counters twice, before and after running
the mptcp_connect commands. The latter minus the former is the actual
number of the data checksum mib counter.

The output looks like this:

ns1 MPTCP -> ns2 (dead:beef:1::2:10007) MPTCP   (duration    86ms) [ OK ]
ns1 MPTCP -> ns2 (10.0.2.1:10008      ) MPTCP   (duration    66ms) [ FAIL ]
server got 1 data checksum error[s]

Fixes: 94d66ba1d8e48 ("selftests: mptcp: enable checksum in mptcp_connect.s=
h")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
v2:
 - get mib counters twice.
 - Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/255
---
 .../selftests/net/mptcp/mptcp_connect.sh      | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index cb5809b89081..5b7a40d73253 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -432,6 +432,8 @@ do_transfer()
 	local stat_ackrx_last_l=3D$(get_mib_counter "${listener_ns}" "MPTcpExtMPC=
apableACKRX")
 	local stat_cookietx_last=3D$(get_mib_counter "${listener_ns}" "TcpExtSync=
ookiesSent")
 	local stat_cookierx_last=3D$(get_mib_counter "${listener_ns}" "TcpExtSync=
ookiesRecv")
+	local stat_csum_err_s=3D$(get_mib_counter "${listener_ns}" "MPTcpExtDataC=
sumErr")
+	local stat_csum_err_c=3D$(get_mib_counter "${connector_ns}" "MPTcpExtData=
CsumErr")
=20
 	timeout ${timeout_test} \
 		ip netns exec ${listener_ns} \
@@ -524,6 +526,23 @@ do_transfer()
 		fi
 	fi
=20
+	if $checksum; then
+		local csum_err_s=3D$(get_mib_counter "${listener_ns}" "MPTcpExtDataCsumE=
rr")
+		local csum_err_c=3D$(get_mib_counter "${connector_ns}" "MPTcpExtDataCsum=
Err")
+
+		local csum_err_s_nr=3D$((csum_err_s - stat_csum_err_s))
+		if [ $csum_err_s_nr -gt 0 ]; then
+			printf "[ FAIL ]\nserver got $csum_err_s_nr data checksum error[s]"
+			rets=3D1
+		fi
+
+		local csum_err_c_nr=3D$((csum_err_c - stat_csum_err_c))
+		if [ $csum_err_c_nr -gt 0 ]; then
+			printf "[ FAIL ]\nclient got $csum_err_c_nr data checksum error[s]"
+			retc=3D1
+		fi
+	fi
+
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
 		printf "[ OK ]"
 	fi
--=20
2.34.1

