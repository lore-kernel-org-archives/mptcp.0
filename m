Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C362457D1
	for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 23:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645312910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mh2tg507qcJCqZnIHi1UZoLJ1hU6HQf7cDsPiNFkKtc=;
	b=eR+kxzWQMvb/qeJJFBtLAIW/s/QXFzz9xIczIqiE8p50onAgBNVaj3/9guqkVXK8zEerkX
	O7eh03F/ABZeiQELzVKeHeSBRfzeTVGoC9A2GEbkYbuya7Qr0A9t0VYPTtFdMRAFeowRsW
	aJTITG2GmQmNeMXHD63UkkovIrLlHbw=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2050.outbound.protection.outlook.com [104.47.5.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-n7ywSd80Mfq7HZ5ecExjfg-1; Sun, 20 Feb 2022 00:21:48 +0100
X-MC-Unique: n7ywSd80Mfq7HZ5ecExjfg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jm7klxH/FS944YE5vUaLu8WQqzu4IDQnrORa21qmxK+3ScDzeS6BRl/SkAbJKjlRYL1jWx+j/HFaJkNgK6HHK0q5uKObfv9irWvP4KqElOHnfrA5w930ksMFXZDTuVrK4mTdwYFuBCnJ3Jiph5VhDR1RD+mw++AmdPWz5bbzOAc+WyIrBrXpe5f5bR3bBM7ZgatiUORD1wjsS1QUCzplX/3NlE4VfHOhvwNykvyN0vFHP9x022eeOCG+sQBDlx1HidMPNUBOqtKxE4cnytHvvrZPcnSfkf77dBr+arOar0neVOEgeyrifWtil/3e+34J/QoGbkhIFQJX0MIFC+xU1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhT+R7+o4Yg1g+hFec7xcA+EDCmgGyRfjLfB6Sy8Ddw=;
 b=KWgyGHowOP0Fng7RKoAqYczYdhYw5HydTRqj4WEJIh04z9vdkIptYpiJyuXUk3wYZYbYnke5yW4N6hHPr2TZZIvDXFzN7rV7cdrh0+Z4Vm6stFXec8dtyRNfHE63ZqMfELYaHvfe/CcCL0PBYwIuZji/yvxTZXRi/WqsV5/r1i1nK1Rrt6JVjKvK4jaRiD7cMW690H//UAcDWEBSFXPJaI6pp9geEG41HbHZSIfjWp+mjd7DprxvluItWHm8fjPvUezlnZQ53vtlSSyZUOdnis51iai1s0yJz/DEcJ9vxWBVHHWTXLN1U7CRp5y+Gyp64t5l8XM8ujuRon8mfjmRVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8812.eurprd04.prod.outlook.com (2603:10a6:20b:40b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Sat, 19 Feb
 2022 23:21:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sat, 19 Feb 2022
 23:21:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH RESEND mptcp-next 17/19] selftests: mptcp: add invert check in check_transfer
Date: Sun, 20 Feb 2022 07:21:32 +0800
Message-ID: <f70769fc828d0a6b2bd6ac0e5d7787b266be9886.1645311956.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645311956.git.geliang.tang@suse.com>
References: <cover.1645311956.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0058.apcprd03.prod.outlook.com
 (2603:1096:202:17::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85d96033-4693-481f-2fe6-08d9f3fe999d
X-MS-TrafficTypeDiagnostic: AM9PR04MB8812:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB88122E66C3E4BEF13194D21DF8389@AM9PR04MB8812.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	46adLUWCjW26FRWoXqdH4DLeE9I40wQzNTYCebYmVD4wGfXxcon4ov/HLsXbxEof3whzK7nM9HVKst/yEbVP1v4oJaDWgylFOeKhpIsFZBDkvI1v+PcwB0wIW3tgKkgu/0/Uo3Pdx7Lkce7Rsgc9u6nJ1wvhzh1w/VWbG6Dp7G+8LtYuodTa/J6B3i6qOZExDE5z6qTHchsb58bwMH+KFotWI17ShzXEwFExEn/bWgbFEiP6CTV499Ell051xjo2yA6aZhcZOF3GtghVJdUon6w6Oq6LV44De2fPWGQDuSL+JLQJqfGDI2Zw7CRlMo0330mCHEYUCJtWwmxD/0H+HjUVTK3xx2uRltMok53M6mqEpLk3ipo3eG6kCYns6WIKnNPSA7fNCBJE4AOS9E6+GgNqxS8I+YrCCUd4UvVJS2ztvLfN/0DfdkoWx8cYY7AmR9fxdz2J8pA3cOWVLT8JFqqj6e/pX74o6K1AUE5iaGmrdPDtVptIHGtFdIZQ9SEae2Ibon4CnXJpZ9VfpH92i7r/5SVto45ONXfzQnM1K3F81rI+mPOu6Yv8k1QhQZozaZs3tUDYkCaYsU07Gj1maaemcRJhIxEq9CO7VfN+g27h451RMKuErKBALIHXQSVMP5bBkgo0n1fakawYtiOu2A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(66476007)(6486002)(66946007)(66556008)(4326008)(86362001)(8676002)(5660300002)(54906003)(186003)(8936002)(508600001)(6666004)(2616005)(38100700002)(6916009)(36756003)(19627235002)(6506007)(2906002)(316002)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sxnerI365h5AuxOeZBLnbeTDKvl8za4ed6Dd6kAsnorOERIwhoqXtn/TXFDI?=
 =?us-ascii?Q?x5rINK6O5tLlK9K7vCuqaBqwLHEhGPLKaPlkXP4Jf3l70O5RsRlk7S140ORX?=
 =?us-ascii?Q?efW0wOsJC1G/5qBbApNC1r/RcYWiz70DGqhE8UcYe0L3w56RGNQbKbZWuCIP?=
 =?us-ascii?Q?qg22fi1J+ExjFLPlJpsWD96rrHS3G1WCVlUeGulcQKvf3Cou/ScXkiAbnAtC?=
 =?us-ascii?Q?n+b3KtJJUEm/0Un6BByhTp9NVnaAfsePo8GXpNwy7inHoDTg33q2SP2KsTnQ?=
 =?us-ascii?Q?S4rLrPQMYKl0w1nR5x5EcVep1CCFAvQ+uFJdku/VTyTgOa7MTOQafTYoI188?=
 =?us-ascii?Q?2Y4b4mHQVr1yFWIctl8q5jKJgifjuRWN1cticSBdsQQqCHenJG1VK0dn5vJc?=
 =?us-ascii?Q?SHwDqa4txHVWB+kABL5JzAgTBeiJYqlU6zji5wY4GpHh8RBwV8O1FWzq8XgQ?=
 =?us-ascii?Q?mIwibSDx1CkJat+zS9To6q4K5aX2Ok5jCmLeRaptFcn5E5cyFBBbzRaWpoOm?=
 =?us-ascii?Q?Luv3G1YaL2jrHeIy9a1VKgCrF5TOygi6zcojVsOTvlDy1yn/7v5sWzlZQ5Mp?=
 =?us-ascii?Q?IxNxZ5DwP9506kd7NlcwJ/VTPj1z2oP7XV/+PZPBaMR7XuPVTUjqepMVmeJ0?=
 =?us-ascii?Q?NR6eEWsqgpav9F1BxkZ1OsbMoxUZQbt0epvMfC+6/p35aDjNwSucgjuJRQ2E?=
 =?us-ascii?Q?RP1jcyVlCGYp+597DJl5/M6CnocYpBgedko4mGwbQufkBySlGcR4f0ixJ5e3?=
 =?us-ascii?Q?/PEODdtt/Hr/fYZHTpv17HTvHynyYA9Kl40NWXzI2onWNasU1pZ9VKmHlA3k?=
 =?us-ascii?Q?Bf0UpNLmxJnfsBJxdQgWYM3v8ybCLXhghJQp8MNQEIXpxxR8Cfhp7O7Fd8N2?=
 =?us-ascii?Q?6MJKcbENrJ27Uu0XIANgSsHdeBqjfW9JxJ/JzIzAO1gRcU60md0MolY6XA3h?=
 =?us-ascii?Q?1Uo3ngS5lb4ITWeVgPysuHuX7gTEwRW65GV12xEUZAJACR6WFJDCUOfRdSr2?=
 =?us-ascii?Q?vRIgHoGLk3K2KzYyvQ/bCRHtg/pLrWXKPNL7RfRXgK+V/XXnksJ1hSu7lV5n?=
 =?us-ascii?Q?BX7uvYFeait38GHm5Eu3u1xWjf73dDTvgLDaZL8waKajONrHB2vcPHBbtpW4?=
 =?us-ascii?Q?iaUOp3p8WVcceht8XdIvXqndIZOJd3cBUpcBTuCeMTdbpW45suEEWzRZ/9Wt?=
 =?us-ascii?Q?ACgEiBkNab+LfBBjSHJ5GX9mOXmM8RIpOKxgnN9HLWrxOrvPqkQGDGL7mHFS?=
 =?us-ascii?Q?sPgnIF5niPLB3NzN3VsoYXRqcH4IhIO8j5PxuOmTjsSWV7paXxlt6mxRHO6A?=
 =?us-ascii?Q?dhDSidOmjAe5o9KZ/oQVUPDBhwwKcjZDwPjFbl761X7fziXifWQAsVMVyFuz?=
 =?us-ascii?Q?YsJlSzrGe6S2TBSWD8Os4+ASUYjLErIXiYz7YpiEde16NhzSMYBc/tUqJdOx?=
 =?us-ascii?Q?VLI04hwi5wIJqbO8oVFilZvLOOLkYynaOfnDHUkXhfbmDw48c95CCjNBTLox?=
 =?us-ascii?Q?jy+J2DzK7URGvosIzrWyq42SLryGJpiZPfIU+a+58Bg5Drz6aGU3qQeKARcA?=
 =?us-ascii?Q?qV0/SALhQ69rhSr6fx/+MWKj8IuT6s33a1lorfmd4cglFfF+7UNFDhfnG7Q4?=
 =?us-ascii?Q?gchCqz7SqogQV2qTI7QeZnERp42EllXB0bxUaz9AYBtMZblDJ4k4NWkaxVoJ?=
 =?us-ascii?Q?gFGdFGICfjA91TPzwgHjnPod0sI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d96033-4693-481f-2fe6-08d9f3fe999d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2022 23:21:47.6906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7lyC7ign/sAan5bKposGCvdgibFWZfdetLuvnrk9rEwdUkL7tvNNc3wSY8dn3qBfXSHxlMC8ym6Gcjv8DokI3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8812

This patch added the invert bytes check for the output data in
check_transfer().

Instead of the file mismatch error:

  [ FAIL ] file received by server does not match (in, out):
  -rw------- 1 root root 45643832 Jan 16 15:04 /tmp/tmp.9xpM6Paivv
  Trailing bytes are:
  MPTCP_TEST_FILE_END_MARKER
  -rw------- 1 root root 45643832 Jan 16 15:04 /tmp/tmp.wnz1Yp4u7Z
  Trailing bytes are:
  MPTCP_TEST_FILE_END_MARKER

Print out the inverted bytes like this:

  file received by server has inverted byte at 7454789
  file received by server has inverted byte at 7454790
  file received by server has inverted byte at 7454791
  file received by server has inverted byte at 7454792

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 25 +++++++++++++------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 310988a8acb2..f33822b28058 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -15,6 +15,7 @@ timeout_test=3D$((timeout_poll * 2 + 1))
 capture=3D0
 checksum=3D0
 ip_mptcp=3D0
+check_invert=3D0
 do_all_tests=3D1
 init=3D0
=20
@@ -60,6 +61,8 @@ init_partial()
 		fi
 	done
=20
+	check_invert=3D0
+
 	#  ns1              ns2
 	# ns1eth1    ns2eth1
 	# ns1eth2    ns2eth2
@@ -217,15 +220,21 @@ check_transfer()
 	out=3D$2
 	what=3D$3
=20
-	cmp "$in" "$out" > /dev/null 2>&1
-	if [ $? -ne 0 ] ;then
-		echo "[ FAIL ] $what does not match (in, out):"
-		print_file_err "$in"
-		print_file_err "$out"
-		ret=3D1
+	cmp -l "$in" "$out" | while read line; do
+		local arr=3D($line)
=20
-		return 1
-	fi
+		let sum=3D0${arr[1]}+0${arr[2]}
+		if [ $check_invert -eq 0 ] || [ $sum -ne $((0xff)) ]; then
+			echo "[ FAIL ] $what does not match (in, out):"
+			print_file_err "$in"
+			print_file_err "$out"
+			ret=3D1
+
+			return 1
+		else
+			echo "$what has inverted byte at ${arr[0]}"
+		fi
+	done
=20
 	return 0
 }
--=20
2.34.1

