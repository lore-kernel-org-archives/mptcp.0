Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8A57F
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 22:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644619555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W2tsF4PLWhhXE2Vp0zDTFIxEjkpnm4aDFXcqrAwWWdE=;
	b=EUGx/Yq6I62ZpI0NtieR6OnAfG+I6Ekaft78ey/v8E8b1f9VXyeAguOXdnDbU90TiEGCFL
	5+2F2UxB+jlTYpcWDenrVyozNyhtnnur8B3T6RJtCCXpl9FAL4KP7nTidMRYBbB0bLLJnV
	u3Vga1c157zJ8lNycHy6BOIjKh/eqXs=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2111.outbound.protection.outlook.com [104.47.18.111]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-sNKfFvc-MtWIwHcm6VVouA-1; Fri, 11 Feb 2022 23:45:54 +0100
X-MC-Unique: sNKfFvc-MtWIwHcm6VVouA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgNjkjnTP7kGvlYLLu1JI8MkB3lFwd3EE6gMkmjuXQHjj5FT6Z6F1RCbYAZYx2Ca35SXg0bdrVGVLz+OyqAJgCMZfNp11FMhw2K0XBMoctCSUmXALwllYXwWgSqm7X5kPZjlpXdjQyhqqUdgTTNEEf3D5Qr3LtQBNRyo18esJmIIDEB+pfv36x4bDklnWWUndcQ/ipkta5BM31FiPVx/HKozbSg+Vx/9OxuXKgbBheGKETFz4owoN8NI4mHXTHjl98AzotdCK1YMcONdhZULloaGcbEO5jUwg/8Jr+L19zpto+ZcLeTUqOWAGEvEZGp+8Qb94IvmDGbLP7oLdUpJ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8K4d7ESJk0atp/+mJ6lEAuP+JvtaIhIecvFANBr69M=;
 b=f6DR20J/6yuPlsXDWL2hVIqZDHWfVHoCi3cYZ9uT5mbRPEf50+jz+3OpwWqf6XPMcWy1TfxWThU7/W8vgEtGZIamUMEDFf5oZoFWzCwvvoLQSxIWB7KBfY+LSXzqEHdJrPbGvPrsupXL+u/yxkmK8yStnzWpdiAObumo4wG5IbYedBzhOtKHnv9avNLzh5PoBrBxkYwVRDKpC0CbqGgBIDXj3kaTYjJdhPzD3LAfZeLZtOuLzNOJw806oetkMFlpNn4Bf1WIfqcwzelSwvH8zRgYDddh+8WF43RdQ8XMvq2S2B5e84+GQLWjfvZtSIcZyIm7CMWYNy2ftH/917m+sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB5652.eurprd04.prod.outlook.com (2603:10a6:208:12b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 22:45:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 22:45:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v7 4/7] selftests: mptcp: add the MP_RST mibs check
Date: Sat, 12 Feb 2022 06:45:40 +0800
Message-ID: <9cc0ab6f688f129e1945ef870bbef6240300fca0.1644618926.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644618926.git.geliang.tang@suse.com>
References: <cover.1644618926.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0069.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6941a729-9a73-46c5-7796-08d9edb0424c
X-MS-TrafficTypeDiagnostic: AM0PR04MB5652:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB565260A91C49A45976F558BDF8309@AM0PR04MB5652.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T+33i4emWMdjxq1JA6cFllUF60NtTfHqXv6Inlphc8dfxdmBSmpeou1sP3WsVMAqMLufDoS8ZdqM1eU2E//LDAvE5uEEcu5K/uIGvDoVNcpxlKJwOJtvX/BCf1h0WZ5SvzsuU3kC1lq2MX7O32NkJUnrEy6JZdXhOOicJaS9POwcSIP6N6v46gJSrwgpiC4+KaWL5Sq0J97dYaaOrb6xQlUzJWzeH2YlJT/rhRztwaXmUNzwY/SeDJ3HS2oD23DQj+b162O5Kp6njqaLyyaG6me7cItp35RX/JXiVZK0qdTQmE3ZbOBLWtpnlGduMuB+RMjcTLyZNljwifFTTUC0qWTbToQZrKEHOftdG+WL6xq9xcNCvXSj7XPoqf4lH56XRG2BrBxdElzL/nmNEc6BMb13ib9oM/piRXwTpIcd0n6IKiaEisJky4N24zUsQFs7BPCuanfnLVP+pXI3rzeCdIRd3iwbEe6uVsPkUGgrm64nUiof0rGxpUZc1v5Q73evLP6sx3eU8ZNQmTJ7CtXyZfXs5nOQb+h0s9V21vazJV8HRMu1XNi6aTj/L10mrAHwf0dwQkgBDvvxJ7FW4vo/R8QpIaQHY4TWFNt5jcKaiAmxO+2R+JISYvOCx1ugokGNYkOMKtSVCSNv5jmISX4n6w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(6512007)(316002)(66556008)(66946007)(66476007)(86362001)(2616005)(38100700002)(4326008)(8676002)(36756003)(6486002)(508600001)(6506007)(8936002)(44832011)(186003)(6916009)(6666004)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5unnyUxcE+N4WXBZHwnwM6zLIxQikOcvXZ4/wCY8BSWKZkS4Am6iW4Xk3q8C?=
 =?us-ascii?Q?vt1ZumFOEer5M0zkoH2nigFtvPlVrCtEYAcUPKRItTvHABpCOzXKArE0BfCP?=
 =?us-ascii?Q?ShKK2c8K0MS1JD7KldXjEbWvmdgMRZCg4yCdwl8GOMcSVm++hG58yrCn10jr?=
 =?us-ascii?Q?dBQw9CWVk//kllWXdhOtIE/gh3ixKeH4PBWoA4Ebzbopw+RAr5K52dLzSd/K?=
 =?us-ascii?Q?/dO2hIcoFGs1oP/P7EZji76lvwF9Qr+l2ReYRYBUK1Vxx4wVVSw0Q6iSfdV1?=
 =?us-ascii?Q?/yi0+Uq8hpCfdT3IUK8IA0zFW/19Taj35WoYiaovyklwh5nLOEi9nfnwbebW?=
 =?us-ascii?Q?7oSrfE6f+irIM1Q+d9XXT+JCrUp6piAFigyAEpSbEgMrVK17tTFXIRlGPKpP?=
 =?us-ascii?Q?uHKWT9Vr73pvaG6S/I40jk4DiRQVebrGfw5UFHeGyDlJnMRNxB4ucV7uT2zB?=
 =?us-ascii?Q?nUgf0M0ZFuObHNJeeedupXoNS/Fitx7qYzo5wq/LedyZxqPY6G7BUHFHlJAZ?=
 =?us-ascii?Q?HrJXTbOuLaZoMB36NrIiKAcs70Wz6WSKzqhqTq1WkLTzbEweYMBAjpgjzB0v?=
 =?us-ascii?Q?NfXLLNsdiNFHR+SHpGvvnx72TLCXcsStNAd3GPlTwsIVF6u6Af98y9H45XxO?=
 =?us-ascii?Q?0ZGI2ak099xv8TCxynItWrZ8KdfpAl4JA8qShtvByUABaRh1mTHcaoM02o6y?=
 =?us-ascii?Q?cKOqFuxizm+OtrZFwkSf4u4qsWqseI8lVCG6y48dRR+s/nr3bX9nXW80ncyS?=
 =?us-ascii?Q?ijHUe/bgst5158jipL5+Kz1ggJpO/5bB8J5ZkRimImFVj/XTGx216xSA8FbX?=
 =?us-ascii?Q?RcOrHzAoyUwBUQUYi6pX0wq5AZbaP0bbTqXrXAfWtstQR/johpgGlerkqhEL?=
 =?us-ascii?Q?DYzNaViDOffaHqu3YICkmQo62JFI7xGZwq7+dZZVLLO231XhVz2PLpQvAlw1?=
 =?us-ascii?Q?n7CpVtHt9CIlBEHCxFmGbeov8/aNhbRd0IMENm+B4l4rW67EKbQMCCLl3NrY?=
 =?us-ascii?Q?P6X+cGNLyOQczqH4HGL3AEXJywrW7IL8ZY9t9VdeavtbWatVYmo5wvwJk+Y0?=
 =?us-ascii?Q?G/2VXqCbJSst1qdvhb/EiIVO+OeR2b43VHTKBfQJY4LE81/WUP5xsyhqMk3y?=
 =?us-ascii?Q?YOGPrDITw7WGL5S71WJ9910PZ2NUfPDX+QprFsvY0KxTCIy6S/n0HSzXmhC9?=
 =?us-ascii?Q?fDnSFrus0NUTxSl3gZB//IH/z/brwa6AEc2FfHixabFe+8csA6ao+RY4AaIe?=
 =?us-ascii?Q?YTjaytnwQi4k4ogDwyLS+x7vNdcZW0GZ82B++yxGA1iSvjI7BLY8smuFc8R5?=
 =?us-ascii?Q?HFEUfEyGOEnH+N7Sm7ag1kHHCRMy/4gE29rU7Cw70T+I0NRgENE8EmTdI9wU?=
 =?us-ascii?Q?dImx0fTNUDsNOEzcI9QK8xk2qLlH+64mrZc2OLZk+H3KVPzFTGpXL16uygV/?=
 =?us-ascii?Q?ylYiyIljCcBq0ag7Cgwf5b2IhABBOL4fAowfbOXKCGSkuzKiw/G14U7k9udz?=
 =?us-ascii?Q?IFRgrQ5fLPqPIlz6oDDfFZsH37R8IV1USUvQz3qx/GAoKkeA50FsIC8u32cH?=
 =?us-ascii?Q?ftbmJaPiRcOhkAY1ltkWxl8t8MayAd2ehZ3kTR7dJvD0GVBfEpopUNa8uVIc?=
 =?us-ascii?Q?hq11Um5BX+y2Z8TdRn1m99+dVgMAuNsTovqRZGXwIf1g2e5+OxIxfTx9a8sW?=
 =?us-ascii?Q?Uc4qAlsQ9yXV4LZqEGm/2zF5kv8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6941a729-9a73-46c5-7796-08d9edb0424c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 22:45:53.4938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3SHy/m5Hclv9P/OPdWdbuf9zIuBqm9ESyyQiizQ43IyvnC3jlhnUTpT5NQGn5UGS8++gQuLHQSiJoNp2DU611g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5652

This patch added a new function chk_rst_nr() to check the numbers
of the MP_RST sending and receiving mibs.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 9b75569e423a..7537f4fe8078 100755
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
@@ -868,6 +900,7 @@ chk_join_nr()
 	if [ $checksum -eq 1 ]; then
 		chk_csum_nr
 		chk_fail_nr 0 0
+		chk_rst_nr 0 0
 		chk_infi_nr 0 0
 	fi
 }
--=20
2.34.1

