Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6651FD3
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 11:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645097044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zmBASFmmBE+qtLJ5tmsDVYaiMDBz+H+MgyxsvoDHkjY=;
	b=dWbI8Lg0RwK81ucJ9aEk+IanySjEBhcMhbjpCW9XtDwsF+pA3qKLEC3QLZx2Fc84Ahkw9H
	fZ1uody4tLO0JrqTmEig3y7nBu43ci5fvpQozf3U1e/Qjb9tSqSP0yWvjFB63FTmBIw9Wv
	cQiidGJgm5Myi2G20l9v6Xq88iMqExA=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2052.outbound.protection.outlook.com [104.47.9.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-MJmR8t5pOC2VB8TB1hnfmA-1; Thu, 17 Feb 2022 12:24:03 +0100
X-MC-Unique: MJmR8t5pOC2VB8TB1hnfmA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrQxw1a6czUPiohYZLwcpPP05gHOQjlLnwzpc1CCj1yRUba5N90NazO8XYmLZ7q0aWg19nbg/U0mdnk/auB+BGHexqIjOvQhuE8M/dwyBmWwJnCuA4t1uoCG4xK1aXhdNngnKClTOCF6halRziFf5Ztn6DendnSxI/SbfiDlYqH8vBjBjFEtiC/SdU4tnjTEFKGpU3eG49FAmcSPQDesnZRJXk56PqJc0EhfpqI0n5FlnRvDBmFnrPnTpyo4rdSUUy9N7DzHsK4VC8lmxJZrZ2t/+hGjGo1df4V5Woer5gcvSj7kWhMhUQgjwloS+KzD8a9ozcraXr4dYgNrGbitgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZadQYNWtiCwn4V4Cx/lzRAoJbzv3m8Dst1z0t9afHw=;
 b=Bqt+1+x1ueP2QEceW3hJcqyCQmSF2DUguQcc6Cay4nbxenhEK01/Q4ZiBFb1Pt7WzqKk9kQlYMK8CRix0fBkIvepw8M73Ap74zywoi/qp+hcb5+VE8+GnLFuIiYe81zO90gaRh5M6PreyPkRAMJwfU1ze4lrdjquQ6xWRoXbNDqyuZSS/14C/bEe6V3HGLrV7xplakTS+g2Vzh20mxAKcZ1RdUmvCSk+AvYW9AMWlllr/vqNd/xP5KlxvZ/G7ItwK7vVK8J1UlxbXG+Az0pTAm3dBRY1siETouaImbC4agyY61Cxy9oYW2FpwBz/u8chjlFTR9kB6RIv/TOrlAhJWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB7280.eurprd04.prod.outlook.com (2603:10a6:800:1af::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Thu, 17 Feb
 2022 11:24:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Thu, 17 Feb 2022
 11:24:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [RFC mptcp-next v2 6/6] selftests: mptcp: MP_FAIL timeout testcases TODO
Date: Thu, 17 Feb 2022 19:23:44 +0800
Message-ID: <b3a5990a41193c678d0fa6a54bfea13dee680df1.1645096378.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645096378.git.geliang.tang@suse.com>
References: <cover.1645096378.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0151.apcprd02.prod.outlook.com
 (2603:1096:201:1f::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73382490-0839-4588-621e-08d9f208000b
X-MS-TrafficTypeDiagnostic: VE1PR04MB7280:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB72804F1995EED26D9FAC5A94F8369@VE1PR04MB7280.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yV6KsCHE+v/zETHaa0vnuRfpggwfymNYahnHGe+hsKacKZluK3bz2kB81szJEcOmjA+WT8DiycTcURkkKYHGQz/27IIaUpJdSLqOF4RNjmrNaqNmbi7qiWWtAYL6SlC+ZQ+ktPy+XOykTUQJHQFGU55DM0KxKJ/kxNULZNbfSs9S1QtxRCKjVjcRGFA76OTckmbrEeIcUuTGtRIICT4kqwR9+NLMW5LSPL2ri9aQHikjb8KJ+DKXzDJVXsGDiJbo9l6EYMgpE+Qgoc5zkLPPF5EWTy7+zrxACSHbis5vg4gwmZh9k+y7Z5jJnLpEYqj1xhhdA80rCFLbC1YFQXeTjnFWlQGZcoxK2D7OjOstB2U9UAWMLTinXmzIlJxNo66zbHgUCsp2kvyDeYTovbRLmGhV3pKRoJwYVLaycLIiG9dpR0tqqp3mnpTTyTRm8hHzXQo0pAdeBMb1XX9wPeXAMj1e3rhVd70T3NNv8gaf4Yza39gSz/pbpsdc2eqBCmIPhpDm7CQSe7799BiM8uXkgMGOy+CeO3ptw0vRz0DB8oSocaKyWkn4mEdVRiTdJwbbr/zOo26eS0jnS6CSMsKJIKWWMPgkglQ2P8uJM7ZishjPKoF0VHtE2d4e1DGlMUnYRxQPMfldTAqj32WJmmOFLA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(2906002)(2616005)(107886003)(86362001)(6506007)(8676002)(66556008)(55236004)(4326008)(8936002)(5660300002)(6512007)(6666004)(44832011)(186003)(66946007)(316002)(6486002)(38100700002)(508600001)(26005)(6916009)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HTuvWANviwkelX28nYL/ZczlNV2HdLiL2IGPtWQorzaAwmQ4mDy+67Xr7D86?=
 =?us-ascii?Q?oR/W49k2GvHmMrWOQILfcgJIv2kCU7UqQJRU87gPuZgEV0QaNyRrpx/capqZ?=
 =?us-ascii?Q?XXIP6nUeDqfkFFziGVW9Mx34ljTkrtQ3LqLlrxcJu7qGAmO4hlHAX8y9WD+L?=
 =?us-ascii?Q?/QmmI51BD9hOpl9fvyG04bnMLHwKPiFsYBWzW7+eltl0XsEhZZDQ8lScFS3+?=
 =?us-ascii?Q?PrPGFIusYN/KO1bWm+ceDr7yEr64UGZ4j5+aMpRux75G8uQmBDe8J4vdCNy9?=
 =?us-ascii?Q?jPlsxbdyZ0dS0qObxI++wdv0xkOGPSNiSNgqvj3dPz+v4ZIpJ0zGzUh0jjRB?=
 =?us-ascii?Q?VOnXFktT9ZWsSWz6Omz0oScg/oINo/ow5kXJW1zc0xG+nqIbuHLWn6oc337r?=
 =?us-ascii?Q?a+uZfjBcOzGPZMEMulRHWBQjSeZC7KJlpR22u5HO9R86F0fgA5ckKp+GeHuN?=
 =?us-ascii?Q?cFRLG7CgCqZ7Yp9RKKqR3rmvwjPeWgE6d+7QJWeq30Ziz40kxBu7Br3QecXs?=
 =?us-ascii?Q?EUSst/hq8M+dcblTMtbflLSGA5ReKrdf9oayL8Ex4bHsq6/TsUvMqnhOTsLb?=
 =?us-ascii?Q?01vHKTBKZSiQ2aGUt20DK6qZ97w5K+6033mUGEyorquBVwcg+VXseNlCfeoH?=
 =?us-ascii?Q?57PgoCwWnXtPyN51Y7EZoQ1p+HTbOJxedDLLRDlRuf/YXmmQTtSVxPHkPbTh?=
 =?us-ascii?Q?7qCot51h5Lmh+z+Bp1SHsFMxysEg6ELtxebO8tkIuPJTS1MWIAateLM5e8Jb?=
 =?us-ascii?Q?SCKNevQTA4OqN2lVHUjZGF6xypU4/Wtwaq5ZUIHHZYbSuiHunxNw/RzkKF/+?=
 =?us-ascii?Q?H0hw9ySmXyniE4t1CMqkLWqegNTHXAbN8AyBLu95LrbsZf0o6EymyFnIRVgd?=
 =?us-ascii?Q?gTsWdMnCyQWAw6KgSgDdJgBJ3obuJOdAFNgeBMg61BtI2S+KuRkj9a3GPhRl?=
 =?us-ascii?Q?O3dhbCYVKj+HuPfp8wPPxCCzdTco8sIybJxNlaevD+YoXX8lnGhoK4pvKMIW?=
 =?us-ascii?Q?rhjX+Mg5WpB380oPxKWPOXL65X8HTM6OgpG9jbzeDr006UIfREml2LLDLau4?=
 =?us-ascii?Q?flLtq+T90oiRs37Ca+VGwJvPLLVJtIO77SQtaEmFKIMUikZBPijYPwsU8FGe?=
 =?us-ascii?Q?pSBIiiUs/jT/PHYjyT/jEMi0/u3k1h9d4Xz/B3UtWJTT6hhri3UFOT+ziX85?=
 =?us-ascii?Q?HgeuVqCD8y8czuOSJ8oJnvn3DzatRa8VlLbINjKuugHbI81eyfZIVC83ponW?=
 =?us-ascii?Q?qYV3vd8tSZ/y5wHnj0KGBxWD0XLpdMOQDl/pIZn2S1Qotkn1RaSUJbKgFqvd?=
 =?us-ascii?Q?o/7OFpF7wDg9m84koa4ThZZiH+W8qzX7m7qMYistbrgCcWCe3/sW7SeQiBEG?=
 =?us-ascii?Q?AGORWwPv9n5SNM7qJV3epaz7O6qlQ9x4hIvT5bkeQo/UGdoE37RM2GBAuw/a?=
 =?us-ascii?Q?5fpwxgPTkx/+/avIN1KjLhvZfyP54iLPQ/eY8mGmKqxW1Kp50UAg34d4VsNy?=
 =?us-ascii?Q?YqdMILhNpEhKO8SurIbG3y9qeK1teYmtiVxw7rsxhEKeYCrdZ2j5CX+BKvC9?=
 =?us-ascii?Q?P/OHr4Jx6c96x2KA7WO1wx2As4gHd7YRokwiHsK4VVtZ0QC6JX8QvVKavAU5?=
 =?us-ascii?Q?BpK3O/GBciiyd7sCdnf9wAE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73382490-0839-4588-621e-08d9f208000b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 11:24:02.4979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6+vnlS3nGQv2nDhfCzJN6Idn26pSj/cs9Jq2RA3pUsL9lTgVdgBMy8dM35lW2wPBFh7LkB7i8oNzcd/XV1Hdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7280

This patch added the MP_FAIL timeout testcases.

Doesn't work yet.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 9a1d8a1d3447..f28faf901a24 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -41,6 +41,24 @@ CBPF_MPTCP_SUBOPTION_ADD_ADDR=3D"14,
 			       6 0 0 65535,
 			       6 0 0 0"
=20
+# generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) =3D=3D 0x60) ||
+#				  (ip6 && (ip6[74] & 0xf0) =3D=3D 0x60)'"
+CBPF_MPTCP_SUBOPTION_MP_FAIL=3D"14,
+			      48 0 0 0,
+			      84 0 0 240,
+			      21 0 3 64,
+			      48 0 0 54,
+			      84 0 0 240,
+			      21 6 7 96,
+			      48 0 0 0,
+			      84 0 0 240,
+			      21 0 4 96,
+			      48 0 0 74,
+			      84 0 0 240,
+			      21 0 1 96,
+			      6 0 0 65535,
+			      6 0 0 0"
+
 init_partial()
 {
 	capout=3D$(mktemp)
@@ -261,6 +279,27 @@ reset_with_fail()
 		index 100 || exit 1
 }
=20
+reset_with_fail_timeout()
+{
+	local i=3D"$1"
+	local ip=3D"${2:-4}"
+	local tables
+
+	tables=3D"iptables"
+	if [ $ip -eq 6 ]; then
+		tables=3D"ip6tables"
+	fi
+
+	reset_with_fail $i $ip
+
+	ip netns exec $ns1 sysctl -q net.mptcp.mp_fail_timeout=3D1
+	ip netns exec $ns2 $tables -A OUTPUT -p tcp \
+		-m tcp --tcp-option 30 \
+		-m bpf --bytecode \
+		"$CBPF_MPTCP_SUBOPTION_MP_FAIL" \
+		-j DROP
+}
+
 print_file_err()
 {
 	ls -l "$1" 1>&2
@@ -2455,6 +2494,15 @@ fail_tests()
 									1 \
 									0 \
 									1
+
+	# single subflow
+	reset_with_fail_timeout 1
+	run_tests $ns1 $ns2 10.0.1.1 128
+	chk_join_nr "MP_FAIL timeout 1: $(pedit_action_pkts) corrupted pkts" 0 0 =
0 \
+									     +1 +0 \
+									     1 \
+									     0 \
+									     1
 }
=20
 all_tests()
--=20
2.34.1

