Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FF92F23
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 16:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644510895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o95F4a6vJI9DHMxXuI1ysYGysTBtVztd9m89aSXOz9w=;
	b=L8807RfjdNJWff22Sm8/XqhGcxXEXoqEZvBk0hjx6bjQzIzBRZ9hJFcFBNn3S3gcM507Nu
	1HWcfDXmMBQ3yNvqg4Crs2ti6URddqgG/+TnUvLxM+4Ytbe2bqOz1uiP5tCPsa9J6s2X6H
	Luhly0m0XA/bC2SrUrY8ULAoiwneaRo=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2051.outbound.protection.outlook.com [104.47.14.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-xO7iqE71P7uHsmLlUP1y8w-1; Thu, 10 Feb 2022 17:34:54 +0100
X-MC-Unique: xO7iqE71P7uHsmLlUP1y8w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbGVtZNFE3vQu5DBlFJm73hDeLyoKa1taTdUIOfCod31m+Morwg/Zw0TfUg5X3ncosc8GlwGl86ocKKJlULycJIgGIAro2/9XdJFi0SFdSir/Aj4A2D16ROeOLqhL4jx75ZaOnJlVxWvM3FHBFc4OsU4u8dmo62Xv6mV2xEtYzlqDlHOz11TAeas8YyUTmJ+2eWUWtSvi5Ry3V80nAQ39TTjA9hQ8c3UDNhcDjZEMFJaB/wjUjLxW2GiPeTH0nAbK5cSLVHsNDYgG050/xe905gth6K7WFY5xnnSW3Fn/iFZYGoOnp72cHIDFHPXGu/yl0DiLZW3Ee43GD22EgqEWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnL//27s1Jq3+u/tcJh1s1nkg9pwCf9ECy4G/oEEa3Q=;
 b=cxSGQqkfGq5BGRIM4PYIraMPu2T+UMVbfL0iEIc8FOKDayOfLis5rzGExsoiAC8mkDEqsCu+OJpaSGmjDKQUfDk2oiuEr3eA7nPcRO0pUCaj7I/k+Q5kZGBJxc12exl6GYnyynqVJDBjf35e3onNqkUAL3OZggArH3gduzEXolM0bkCAKPXDbK+qcN392rXUGpIMh6OlJ4I7XRFjBMH7muq4RNtp8Um7MrKdf4tdHvGpvPhpKyPLU7cuqmQT158UbCLVCzo3ojC4ybA3KsWuW0jw3yXX868NtTQ5Zs8uGwNORBNla33/3gaLo71f0Gn1Uj5QePMFlQmHEVihRf+oyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8550.eurprd04.prod.outlook.com (2603:10a6:10:2d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 16:34:52 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 16:34:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add the MP_FAIL testcases v6"
Date: Fri, 11 Feb 2022 00:34:53 +0800
Message-ID: <27265ff31ca14a679d79140e4b7d1141322b66ae.1644510882.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0187.apcprd02.prod.outlook.com
 (2603:1096:201:21::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba34ed4d-1994-4519-663f-08d9ecb3437c
X-MS-TrafficTypeDiagnostic: DU2PR04MB8550:EE_
X-Microsoft-Antispam-PRVS:
	<DU2PR04MB85504C3DAB68780B88E4442EF82F9@DU2PR04MB8550.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DOIUMYAtLnZpsiVaYDFNQAsmLci87ZkmkZ703hjYl9O8ZX2Qbk4MimE/nRKNY5Q/DqBwGm+P1eIaEDdTcIkj4yzAs+e1QpqwZMPbCrLIruSHb0GnL+hZCLGYsRwNdiLzskEUOnwPEAKPKyami71d0wde3YTclbR0xrLEP10LIrsFXuDYr1I4sz02W4MLgnzwpbuQOetVyYHIaHgC2i1LkHSXAotum+MIW8aSqQPvA49c8sT7FJ61bqXiqoJa0ScPGoti7PvTV2o66y/UvMwF3u88IhgHtz06wGalFcvyUH0UBi0xEUthkSQGIT48akekyHocL/GCFgCbp2EfjTvkpCX8ObwxrwYO6aACzbdjoFtI80KFG4X2S4H04oyU9n2rEKaDpe8cCuNBVzi0LTXXtfYyyzWfnSccdUJqwY6yHF/c29+VWH5oyXTXGN9/JI7P3qKu3WxCQ9S5JaIAGAqY15lL3dpNv7Yo5h3gVWMe9BGoqY+hLZtC/esVhgFJECIWWj2FFxkD24Td3CzuaoAPw7Hln2/khbzNaS/J54NCYZnQIgREboNeREfJ5XqdiKiGexPhMSzusWO1SfySxzOF6Q8bA+6dgXiOCY/HsOUURzsYyCNjuYLw5ABO7+sN+ZSooQKW/O1en3AF1HtgiTgYyg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(6486002)(508600001)(36756003)(38100700002)(2616005)(107886003)(44832011)(2906002)(6512007)(86362001)(8936002)(5660300002)(6506007)(6916009)(83380400001)(316002)(4326008)(8676002)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fp106dobLP4bhX7uWejHU0ZiGVW/KuhOSoUnvuzzHo0Ml+nFCBsp+gsU8ODI?=
 =?us-ascii?Q?Pw3wUK7u72KzAuw7d5euwYtxGw30TK3hq5Hg3sQSHvyY76EMMTXBtBAEfL88?=
 =?us-ascii?Q?YqACPT9z373FdTgHA5X97vorkQjkvplM2ZZkvLBN884LkpvyP9fYk4wz4Wqk?=
 =?us-ascii?Q?PV8INeAHa2sltGpC9V03gPXoGD1yPWgjxvbFPhaFEmeF7tfh0NXUJxqMGCvV?=
 =?us-ascii?Q?ocFb/yxI4fUJWZdUCTDIEeWEiw5dsdWInXtTXc2vTBr4pz8AJGc7QMZDRtDp?=
 =?us-ascii?Q?LmuarjiH6JxXYwO+bAXK7zBSXHv0oiOtMoxaNnsPayiqAVYYNG6HaPCqFuv3?=
 =?us-ascii?Q?wkDk4UEbpBkTLpQP8AaS6LOL0dlChBrXvywf2So4fCRaT4uaf3hmw8Hbsx8v?=
 =?us-ascii?Q?bOKdhYdx7NihC0h7BTPRlf7takg0zCIURCefx6fCXYAiitqAg7l3PSxCplXT?=
 =?us-ascii?Q?NiBabxzBweBhiRaG4QWzBb0Lhie6ZKQfoHWVH1A4s40UCwdg/zZOjqZA0GyL?=
 =?us-ascii?Q?cWijDkMdSDX7bVdokJy6ULOO7S9D/boMTI4gqj3Dmda2MRyWxbLyxibgaKnU?=
 =?us-ascii?Q?TUhxHIHRZIYAhEekcVlIaTjX4FoVXqIoqlTVb8B0zAlywV9p0v/t7dAkfshT?=
 =?us-ascii?Q?YHpl6gC1mFtxKsoSV0OIztuFQiVFZkAhWQdf8UDejVuo5RHhCBpehTraUgp9?=
 =?us-ascii?Q?XuI6SRniC6Ozc0kZLrA00F4dQzD5JCmawsiidCqttGt+pZmZqutwMZRUtPS4?=
 =?us-ascii?Q?2eOQ4ckf//A1GeJ65gleZGx71ZpGKriaO+kXdbXVgSuTPa+wz+ppev4TQcwk?=
 =?us-ascii?Q?XZkNahs0qUoohrb1tfoWpAKXa8QUYGUHDYD7yjFzXq5gjO9/ozWIuZTKxJDw?=
 =?us-ascii?Q?Fx7eImOxzVfgyfV9Quq0QpawJl6iDvOAM6Xh3bybFq+WXZtdqqV+Q5gv3LRJ?=
 =?us-ascii?Q?pZEk5mm14YS22hV001ZZbNED0nM8FeorW3Ci0vHOBq+NQywdlFw2WU8DBfpe?=
 =?us-ascii?Q?owc+scjuo5rFPBPIIISCjsHZ+bjZGn+JzuaNbs7w45JdLF6E5jXFE+UdoYhL?=
 =?us-ascii?Q?F94l3JEJMrVhrZnsvU4inmF4h2ASFYu6JePit3p7uvtVN7gj4Q+YuGtwPlfq?=
 =?us-ascii?Q?K+bREfjG++zjmBSjUDHF2WAS+qd/zdXzRhb7QIG7Tm+WqqHXt2lSbBNDFmXh?=
 =?us-ascii?Q?ovKg0hL8nliyDmCIlkhxhbwBgjpztyRqQfCKSjt74nyzvLPeRoP9uQNi88y5?=
 =?us-ascii?Q?xh6hdV/vMFC9YJyU/DvmuOj5xF0BvhYu3jn8xkiSty6gtbRSdMlLb0NNIPnu?=
 =?us-ascii?Q?ngXOnFu0oBDHSXvswRexm3S8qy2lIlRmUC988WLFHTQ9eu2njYyfkSrXIkAp?=
 =?us-ascii?Q?1MPDh7bYH21gNoziZiajeO4gdO3D/CwSQHKh8Wz9JXGl/s6iw+M5/6CoNYH5?=
 =?us-ascii?Q?9cNJpXJB98l9ZGR6Za6gi2J/lIZ9QGXMOqAbFWtz4rODiOcVqRRqpKhZ3WuM?=
 =?us-ascii?Q?7w2v4OeDxp5gDTPknNP+fNrwOJaW+u7VVHsBl9LZzVJp8qzJn9lx8F+weZ6u?=
 =?us-ascii?Q?EN4OVLm0b2pFVxQCcOdFB8VNu3mGUaZWQ8/zuuRu+jJHUBWcznYUb6gkEufd?=
 =?us-ascii?Q?yatTTEV+MiYNt7M63E24qELqrvxk1Rju/OU9JlPkUf21T/OuBfBqon+k9w6N?=
 =?us-ascii?Q?7SaRkvpbHextnT4kUoiNLaW506E=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba34ed4d-1994-4519-663f-08d9ecb3437c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 16:34:52.6725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BX9bL/GHJXWJDXxqAKs8tzBAbJGx3/tJf3dutgL/Ok90ufyJ5BVp+KM5eIJTbRA50sYoYg9RjH5pa9rD/AHXPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8550

Add delays and drop 'retry' in the multiple subflows test.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 25 ++++++++-----------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index dbc73e28cc06..d44508e5e1c3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -219,6 +219,11 @@ reset_with_fail()
 		action pedit munge offset 148 u8 invert \
 		pipe csum tcp \
 		index 100 || exit 1
+
+	if [ $i -eq 2 ]; then
+		tc -n $ns2 qdisc add dev ns2eth1 root netem rate 20mbit delay 1
+		tc -n $ns2 qdisc add dev ns2eth3 root netem rate 20mbit delay 1
+	fi
 }
=20
 ip -Version > /dev/null 2>&1
@@ -2291,20 +2296,12 @@ pedit_action_pkts()
 fail_tests()
 {
 	# multiple subflows
-	# If the tc rules didn't produce the bit flips, retry three times.
-	for n in `seq 1 3`; do
-		reset_with_fail 2
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_set_limits $ns2 0 2
-		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
-		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 1024
-		if [ $(pedit_action_pkts) -gt 0 ]; then
-			break
-		else
-			printf "%03u %s\n" "$TEST_COUNT" "MP_FAIL MP_RST: retry $n"
-		fi
-	done
+	reset_with_fail 2
+	pm_nl_set_limits $ns1 0 2
+	pm_nl_set_limits $ns2 0 2
+	pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1 1024
 	chk_join_nr "MP_FAIL MP_RST: $(pedit_action_pkts) corrupted pkts" 2 2 2 1=
 1
=20
 	# single subflow
--=20
2.34.1

