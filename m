Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24317A
	for <mptcp@lists.linux.dev>; Thu, 10 Mar 2022 08:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646899799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f76RwFKA5b8Bwp0PUQTNxsNuvx+bwEcYBtw6HMHVNYg=;
	b=Koux0SkODs77LdeMtdGxawxPQoKSfRdfVQLijAfVBG3J+YWKTHYv5gH8/x0Drs+/OfjVgS
	OvP0CTCDd9ejLxa+k478DhZHJ3lnmCACZcOYyIuBRa6CYfwyOLBgjBp4+i0sttq2oKWvsN
	owUs3XhWl6FwvcL5X+bMP8xEprexZcc=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2059.outbound.protection.outlook.com [104.47.14.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-c9YApHcIOdOSu1Hu9uO0UQ-1; Thu, 10 Mar 2022 09:09:58 +0100
X-MC-Unique: c9YApHcIOdOSu1Hu9uO0UQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzW4Y+dVAcqVcDBJ2zNBSVJnnKjF+4NzV2Uu69532r8atUkDXkKEBtL3veQDyo6KBVgLbkK/YDK8FGT7Pszf21fYFtus/KMOOEqxAPNpC3b58A/6O/o8Kyqs9z/WcvSxfV6SXvlPfhMfT+1zg57aDoJoOdrl5y8g7OUFDwlXjj+0LZ1aLYWBWErdYimYlQTZfaGinlwxURhDgfj9VUyIH5tFNvANPWR2TWKTjk84v/koa9A8WnwZs7Wdygh5BUzDq9up28Oby1+7vB0o6pZpjc/zqrpUDlq7C07iR5uvjGPKWTMvOZl+sgFp44m0Vh74eVIffkEhyM5MZMcVUtWM9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uU1mCqPs4Vw4kAL2cPM5Yvxj80ihZXnk3ObKZFUzFZI=;
 b=cxG1aXdWMjduPdDBa89lpDiIcR++3BzmLi4tqRZMq8e0Y7bsMAA7Utwg9ZZ6vfXBmDAzBokG3h1I0O2Q/Us11nxV+NqX0aMJ2Imwe4FQMMsbKLUooZPrZp5nAjd2mCFtQcHZWaS3nE9ZeSOo/dsW8vsCt+H5SvbX10Ns/LqQsBcqmDI2Zgv6KW+93g8REa0OKNpmlb8LAh51/BgJpnwmyGXUnepMrRTB6CfGToeTJWqVAB79ccdRnWiNPsFWTQgoFGkdw5vftqq7ipY7u/iX+l8Q5M8jk4APYSYsGFoiyqwitWOIIukatM5oe3+7wsrtpQlFoghEFmilhQkdu7la1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR0402MB2772.eurprd04.prod.outlook.com (2603:10a6:203:99::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 08:09:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 08:09:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 3/4] selftests: mptcp: check MP_FAIL response mibs
Date: Thu, 10 Mar 2022 16:09:26 +0800
Message-ID: <4fb02333cf49b959fbe5770879a48d0feae42184.1646898548.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646898548.git.geliang.tang@suse.com>
References: <cover.1646898548.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0017.apcprd03.prod.outlook.com
 (2603:1096:202::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8ddcc63-d3fa-40e5-824c-08da026d5d96
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2772:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR0402MB277266C5CCEEF34B705DF459F80B9@AM5PR0402MB2772.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6modB0ofoVy/HBbWcXzYz2ddnPbhRN4FDYDTJCwYp0osQ6yAL/v1cxx7WgkUKrsmfGNWVLpv2IpaAiDT71ddUcS1Rm8jX9Xio70t1FXFbDCx0HuzO5o230EKy4UWMWdbLvhww0GxthQ4eUWrbXhj23ycnF1Px0S0Lve3rRhyoAra5R+JrkhQF4AFg+ENGYbnOylUK7gg0ETG6yPXjNcCwRuou32npa20DzqNr6aPBAy7Yit8libBQZ/ztn0LWTJDMNYaZlt1EGVanR/6t+SnKfoSyIvaxG2QaxbsMHdzZ9Ij5cuBqjrFW/BUQn8qlgvWJAYutdpwI7hk5Zghv+40GfB4ezYQuvRR4qL789aOAIQwID1QWOSOQfqzDkkA/T1VWhluUsdgiBATh6Jqi2bkeAwilhHG0Asu2enc87FWzW7KAVtfxpCWSkmnW/JUGAhizfwe8NKhtE7ZjStLYneJ3MXC7Pk9pHhgBbsVBY22ZM21oWx6of/qjd5LoR/9MFPfzrC52OyhpBn1wvtiOGw+cTA0IV1Opj2d3fYLL2rlbhXOm42u+yO2k6SERbhVRHoCh619GdaW0toQSITQQ1YW7WxexM7GPdsrNhYQBRBceD8ZgTa9S/WQvp1BGX12j24Wxr+oCyqslyolzB3Zgpt7XaZmXkpr78M0H0b2nmrj7q0X+IlHKDHnsNgd521Cf8wt+wToEAxscSYLJB2LhnLbOw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(8936002)(66556008)(36756003)(38100700002)(2906002)(2616005)(6512007)(107886003)(86362001)(6666004)(6506007)(44832011)(508600001)(6486002)(8676002)(4326008)(316002)(6916009)(83380400001)(26005)(66476007)(66946007)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?imOyzubpdl/tQmvNJBiBV8KZWCJ/+2OvAj9r85FiZoeGBNxVTRHqGCiw6JtB?=
 =?us-ascii?Q?Y+P8jeVEmrO/Vts7PX429pA/SjvUAJDnc0xrsI8kLtcewH9vbSI6+REEY5vV?=
 =?us-ascii?Q?lI32RMtwji+qyIYPPkTx/JkqVrSNQ5O5yKvV3qO10hLmLI902zBn/0El/JgY?=
 =?us-ascii?Q?iJExCl+cOyQeN+rrSUO9cQj7L2XVp+WpE/nsRHOka/dlavcbghUyBnbpenef?=
 =?us-ascii?Q?EjsLsMJZLCe6PY4nchx9ZFzQ7OSndFJ5cLwx5JpixLaru0bW1ZOJer1A0vxz?=
 =?us-ascii?Q?kITZFV+hE8bqiFYrpjGfiCOLexl7RJQc9Zy1f7dV9gk/eyxLR2+YpkNOaJm0?=
 =?us-ascii?Q?hNJdOjUEK0/oIBdIQ9ax/zmTyAGoQFu5vuY9Crg5/L9vwkUSzO+tN+vhlWyb?=
 =?us-ascii?Q?SWz4jqr0oWsIJUF6Ui2MTp28q3O+USkLFrWJ/yuLsLdIMok+QNAxfeTviosl?=
 =?us-ascii?Q?yOEwplGlSfgr0VUB7zcCbKDrXJIesomEGaHSLW/V6lJVQal+g4/1/p3XKjDW?=
 =?us-ascii?Q?HgZCdqpdZgxy7FUX6+GRlX3CUqsZzsqv19YI62i+7FSgkIpWGUzA8gNvXM9y?=
 =?us-ascii?Q?geoIuHr8k7fXFLwEOAnJD8XWdBd7VJH+gAG1SER2IBSkRZ7vS5dEfujvPg0w?=
 =?us-ascii?Q?MmNZO0w11UMQLvvDxjvVw/XGY5ZrfB+BesI54jloPdE4OsDn5vRT/fQqDfjX?=
 =?us-ascii?Q?rQtKnT4/jF/hzEc6oDqe3WAVJM4Yh+w/1WeVn7P+SqYl+5D54U+UlMpPxovu?=
 =?us-ascii?Q?4PfqryXcx/4ebfYeIXFrfpSBJN6T3rhA44M88r2bQyS8qd4ttMPR2fEvOQZQ?=
 =?us-ascii?Q?mcssdZr5oNc31sAkqx3Ki7+MV8TcstVpHfGRZy9bPzNGxK5R87k17fGbtd5J?=
 =?us-ascii?Q?uXTK5s3J3Dv2T1wRdY5DGvXQ4tnZoJvtnR78q2Yn8PxAa7EZ0oy3pjRIbVMz?=
 =?us-ascii?Q?NSFKBllr/qIbWr+yauqCtARebWR9yiurcjkwQzNfYJwobmVDMU8ZTkF6b7MY?=
 =?us-ascii?Q?DyGn4M3PWGKjECWI6izqqCEhpVkrlXf3NnslNM7XkTDU9WP3F4CUlKk9gqx5?=
 =?us-ascii?Q?ykGWzcd/zPuYT6Buj66gUpMAnKb6KjDggopkA2dUQuG8rTMhvQQUniMtp6j4?=
 =?us-ascii?Q?NCuoc2PnL56NCkWKrfBKpHflM65GKIe6mZNL7rhokuXyw+DdTdlBfOnzLzFP?=
 =?us-ascii?Q?EoYXBaGnP+jhk1BRLBCRekkImAYmfCFfHU9Se+7y78qlYkQnUrjtdBfpn+gW?=
 =?us-ascii?Q?VzKF3flohj31RNfg5D/saTKkgUs5RYRomtl4IiFxjqVFX1q6WHPUkU/6eyXW?=
 =?us-ascii?Q?+GkwGuVALpa3TvTtR5spqWnXbTj6S1E+p40gTnxK91lyYARKKqdt6n/0C+97?=
 =?us-ascii?Q?wf4Xfpm/VMJ2pLPAdUa4GMAtmshzrX/v0K+Wxsi0YGu++4gpPBdhZvAYu2+r?=
 =?us-ascii?Q?YeMmGqJ0VFBUDE1um5GwFJkqWU+APtZoHSU9ZdZkBZ5B3n7qBJDFhA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ddcc63-d3fa-40e5-824c-08da026d5d96
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 08:09:57.2275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+stP54oW4sqCRKg4JAOWGJtvFlJEBnodhuwR4kdFj7lcRqZP5CfJAovgaGLJpWluMYqygtIkE1fotkdxAtx6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2772

This patch extended chk_fail_nr to check the MP_FAIL response mibs.

Added a new argument invert for chk_fail_nr to allow it can check the
MP_FAIL TX and RX mibs from the opposite direction.

When the infinite map was received before the MP_FAIL response, the
response will be lost. A '-' can be added into fail_tx or fail_rx to
represent that MP_FAIL response TX or RX can be lost when doing the
checks.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 38 +++++++++++++++++--
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 959e46122a84..2b77576d773c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1055,13 +1055,38 @@ chk_fail_nr()
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
+		extra_msg=3D" invert"
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
 	if [ "$count" !=3D "$fail_tx" ]; then
+		extra_msg=3D"$extra_msg,tx=3D$count"
+	fi
+	if { [ "$count" !=3D "$fail_tx" ] && [ $allow_tx_lost -eq 0 ]; } ||
+	   { [ "$count" -gt "$fail_tx" ] && [ $allow_tx_lost -eq 1 ]; }; then
 		echo "[fail] got $count MP_FAIL[s] TX expected $fail_tx"
 		fail_test
 		dump_stats=3D1
@@ -1070,17 +1095,23 @@ chk_fail_nr()
 	fi
=20
 	echo -n " - failrx"
-	count=3D$(ip netns exec $ns2 nstat -as | grep MPTcpExtMPFailRx | awk '{pr=
int $2}')
+	count=3D$(ip netns exec $ns_rx nstat -as | grep MPTcpExtMPFailRx | awk '{=
print $2}')
 	[ -z "$count" ] && count=3D0
 	if [ "$count" !=3D "$fail_rx" ]; then
+		extra_msg=3D"$extra_msg,rx=3D$count"
+	fi
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
@@ -2672,6 +2703,7 @@ fail_tests()
 	if reset_with_fail "Infinite map" 1; then
 		run_tests $ns1 $ns2 10.0.1.1 128
 		chk_join_nr 0 0 0 +1 +0 1 0 1 "$(pedit_action_pkts)"
+		chk_fail_nr 1 -1 invert
 	fi
 }
=20
--=20
2.34.1

