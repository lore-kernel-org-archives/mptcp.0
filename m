Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9538A2C9C
	for <mptcp@lists.linux.dev>; Tue, 11 Jan 2022 15:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641913602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5TVkC7bV2MUh2xAPGf+/ZDKfS66v98p9dgi4fjYS63A=;
	b=H+GKyCFUvCeR3YJPJbggRO/C/ry0q2X89u3tcolE1n5/1A9Q1AnSZAS2Xex/49PH2ba0t5
	eX/eqvKs3uQP5WorMKztxG65AgBQpxnCgb6KBQOcIea4tjjf9dFoR+LTJPYpnvVZsfsC9j
	b4yRFZ9e9pHGi9XZz/Q37cDLktH1M1c=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-dxYnV0jhMi6iHPjyZTvGFw-1; Tue, 11 Jan 2022 16:06:41 +0100
X-MC-Unique: dxYnV0jhMi6iHPjyZTvGFw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeSMBS3NeGV88nvB+13c3yOBHASkBF48F9HDHu2/rePJnghhWHTtn7dLM1oZpvPlZKh+oP7nVzq+FocuMXp7WtQhk6YNaipsfyvkf6huBVCIw1ctVg0K7GTdMEyOhXnfz+xubj+OlF+rARkW0SpgdukwncsWKiBPhWSBDaLYNG1bp9Z21U0wspm8SFJNUWWlT2Ejxm6Q+o+pl4N2GT33JL5iFGJ3Xdb0CA5n9RgyhGlEE/zY7/i6xzXFBHcoBbByIBacojAVzxvt9QNUC8vHlFfh3UQFG5D/lauTijVEIFlx1Eb9rbDFVkcIpuw6zMJgzZhHpNLL9mg6r448DGpBIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XXeEsixw78gM1tbU3VOBaEwG4prjpx9drFEfzV4mGo=;
 b=Y9g7+aly4FbLp8OlFTtsO1c5iRBjAoRrf7Jaja4C/LaE5K75ufOiCaF5wAKhaQqY7CcbQj7Ao8k2L1B3RIivIrSVV4OjFFrwwkOgKnZgIk8LkHnDDQykz0GDrYkhRC047n1yi/oNTkqHIbhTF7za18TbdkV5FwY21rSRhFKHbpHBxqj7prg+Y3GpTHpGtO3XM/9zM7A315OY8IzOvv8zdh6+nhX5IBFWQVAvKEjDuhIywbssQi2PwaICDy/3dBUQRfZYfjhgKvNJ3D55VqAQpqRMA9m+q2w7eoHT6wfm/bbqfQ8qzaPCjbwp+U9InaATugHirRZDYcY8qqDa0FOmpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2458.eurprd04.prod.outlook.com (2603:10a6:3:7f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 15:06:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 15:06:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 3/3] selftests: mptcp: add fullmesh setting tests
Date: Tue, 11 Jan 2022 23:06:12 +0800
Message-ID: <8c0845ee8eadbb70bf9bd4a263c23e64e530d986.1641913113.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641913113.git.geliang.tang@suse.com>
References: <cover.1641913113.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0192.apcprd02.prod.outlook.com
 (2603:1096:201:21::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f88a667-1340-4bf0-10de-08d9d513f87d
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2458:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB2458B81C38E1176F16941481F8519@HE1PR0401MB2458.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P9shk6psUotoakvX+4c1hL7/6myK5LtjspBA6GK81r+cjyqpWeHEya7ZnrTuNWj+El/OU7ybQC7XJxZjIxWxXWn1r8rVbziyMeMM4+Q4dCFgo96ClQo3xcGSWygEdMUKq044z56GZIFIS1VurKRZQKfUs3fJwUH7PaV8TpUYyaLNecED8TPjQ3tETpTTmibKQn8OfMrykFVCZaNxBPeCE3V1HMHTNV929+4FD1xoJXhsX8WPcKg2sMtLfR0hOBIC/IGEeQW6Z67gVyKVHUq0wKlROxvfYyojmBJSw8GxKsbRBo7weMi7O4TUjUCgTCESOAJpudoJ6CV6SxQG3N5UsO/c3izSOxnqKjmb/T5iT+K2hb9EM0ODTisnjFYD+HWTiO7Kyhjnm0K+HaakjJZr1CmzLUVoUUZaTk7N+OFGblMW0RGsbH6oC+Sl1bYwyHPgXx+UG8GPBex6riSU96yPEOGYdwWaEbLP6irnVfOir7SU9uag7M4k47QLXWE7FmOafUvIWrezfDoMibd0W2BiA0n8vZfJz8qaRD7rj0FRNUQSUcYWyYlQ2HeixlZPoxLJ1YAy5Xt8ydsxI/TbRGcJxfjqNMva7S0gwxrK0QwXmXl714ygZmnZXyi0fAz86XRwzE4ApwG+y/xFKtJn1dFClw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(6512007)(66556008)(6486002)(2906002)(6916009)(66476007)(38100700002)(4326008)(508600001)(8936002)(5660300002)(107886003)(6666004)(8676002)(44832011)(186003)(36756003)(83380400001)(6506007)(2616005)(86362001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FunjvTVJZI2BrEaGqRPyNP/PPHeU/z7yr6KIdgiikQQuSxHvzMXfWdopuIxE?=
 =?us-ascii?Q?cYPHlHG66pnVo97cAVsDJQPdT8OMY0TDC72rl6WzY7naSj0N085PpdQ7oyHU?=
 =?us-ascii?Q?qJPL5F/yP97+p3cfxBww63r5T6EbHhprn5+IryyJkJxP06Kt0oB3YURUDDd1?=
 =?us-ascii?Q?0EmLIFubBp+2RIO/OZd/hZM8refKRuo6/gPUQieHI8513pphSl9w7S1Ehzth?=
 =?us-ascii?Q?AtxbbjvDGCGVxyTPdpwaMbv4pwDWWRticU72efJqUC47EEbBz7RVgUgQTLzF?=
 =?us-ascii?Q?CStXIsm6d4X4i3TSAaQG5VoXvqCzZoQSRBLHaV31PGVbdnyQi203NfBlXAx0?=
 =?us-ascii?Q?j6pLp6Uafupy9iGqTQmY5DYWcLiNdeSHQkXaj72i5jg86tiuB5HF0EFSXQqg?=
 =?us-ascii?Q?NU3a8db/9FhGiDfJb1EvF6Yrk3+h+EoAxz5Wm26D6sC+jmkmmGBryDxbxhni?=
 =?us-ascii?Q?VyUGZvTsGUY0HBfZc3EXSvVAEImfmlYJQp78JO8x4kJ7MBH6xa4mMkaqLO+8?=
 =?us-ascii?Q?f9U/YA3HKoMxV4GHkieDQVFBa+suS8tNz+y31CphcdUOulfXUNNoE9mprucD?=
 =?us-ascii?Q?86msCW6Hw6kGs5CXf1/oVd/Yd9WEa5Udfxi6UrB4j4pvbOU74LH7xjqGW7x0?=
 =?us-ascii?Q?3aYPkdXT84MNbF33CyGiPI57xyrCpvTSY+tWbWGVHNhOkvYkBTcHmw/NZ7q2?=
 =?us-ascii?Q?YOUiOxG2KEwLBUHPNWXKEQXQpW6XD+unpJblUzHAwsJ0cNp/W7OI7fjCbSPN?=
 =?us-ascii?Q?wE4szgk3Fr6YXmyKsjd28wB3MbyvLumhVT0W8UBf6/9ZasRtFfVnCghTaBP0?=
 =?us-ascii?Q?fycURdw5mxm2O2El3U1bduXgQ7Cv0s05fYbJIHJE8jrpy0fweth7MAfEHwLY?=
 =?us-ascii?Q?X68wCc/xRa7I6XX42LVkNaMf99J85UcMlKSdhOwDylSJdTk2IongCkPTXRfK?=
 =?us-ascii?Q?KTwkTZbCfkx2vtzHdZtVkVAdiGAwXi4MGqJ3fCdaq183hB2a4kbpvx8PopXi?=
 =?us-ascii?Q?/QAFySE38L9kCxXKhKmdoJdZIeHww18AHwJiJGEkXwPP7lz+M7WNDGXEzeRx?=
 =?us-ascii?Q?wHWcbor18XpVhOwBB4vbx1G+dX+5vW58R2dmuxC500ppnROcg+0rJxUcGqJR?=
 =?us-ascii?Q?LMx92Aosc2D/dcfFykwkyhq18KtkUpQvMs4s16Ats/2CMFB0KWVhWYXWc+CL?=
 =?us-ascii?Q?q+zLKR1STPnEhu6JoG4vIym/w8TQ8LzKYosI+5WHVZInXys2j2ieHS86tcas?=
 =?us-ascii?Q?BfLydB7tt2omVrJrVmBvpuYsX5/+iNYsGpUOFcPRk7bNKsmhB5wAHsrFyEIM?=
 =?us-ascii?Q?w16A15AgujiMsqfpR9YXLhPgk1SQPuSivSyVoqdWXnTDsiGaYCM9M3dYAT8F?=
 =?us-ascii?Q?nF8THiwSiEBotGJqEkVO1BuQ6N2DEdPH3OZLSxVkePPE9Chl5NIXLARfg24k?=
 =?us-ascii?Q?9BNLszrfoxoN+Vy15zFkeMyeFeMiLq6GWEBKRGICJVrlrlIKIE0pLEnFOVQA?=
 =?us-ascii?Q?FYSFkTs8oZueRlYlqLAnLMb3LlFYSQRDr7+EKNHxfP0vT7woXojhfVxyIMvE?=
 =?us-ascii?Q?kREpFNLtPeSR1yXNrStE3UTJnmDhYMYrDFb/ZtS4ghhD0xnydTAJ8pUkSnjs?=
 =?us-ascii?Q?sNnlLWjKMcrF2dj5H/m27kcEeRAI90RVBs001mtDeJj+hKe1JfVnILF0kdT6?=
 =?us-ascii?Q?iLlbjHU4XGb6PaXsBV9L249H6Tk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f88a667-1340-4bf0-10de-08d9d513f87d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 15:06:40.2801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 541KCqbDzXKRp5zI1OeBuTE1bETBMEplVRnLqatIqTTQWt5SXuNOj+Fc1jcAGUVCSGuOLRgwBbgR7A98A1Cdag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2458

This patch added the fullmesh setting and clearing selftests in
mptcp_join.sh.

Now we can set both backup and fullmesh flags, so avoid using the
words 'backup' and 'bkup'.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 29 +++++++++++++++----
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index e48ce23d2386..3060da3f7c04 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -289,7 +289,7 @@ do_transfer()
 	addr_nr_ns1=3D"$7"
 	addr_nr_ns2=3D"$8"
 	speed=3D"$9"
-	bkup=3D"${10}"
+	sflags=3D"${10}"
=20
 	port=3D$((10000+$TEST_COUNT))
 	TEST_COUNT=3D$((TEST_COUNT+1))
@@ -461,14 +461,13 @@ do_transfer()
 		fi
 	fi
=20
-	if [ ! -z $bkup ]; then
+	if [ ! -z $sflags ]; then
 		sleep 1
 		for netns in "$ns1" "$ns2"; do
 			dump=3D(`ip netns exec $netns ./pm_nl_ctl dump`)
 			if [ ${#dump[@]} -gt 0 ]; then
 				addr=3D${dump[${#dump[@]} - 1]}
-				backup=3D"ip netns exec $netns ./pm_nl_ctl set $addr flags $bkup"
-				$backup
+				ip netns exec $netns ./pm_nl_ctl set $addr flags $sflags
 			fi
 		done
 	fi
@@ -545,7 +544,7 @@ run_tests()
 	addr_nr_ns1=3D"${5:-0}"
 	addr_nr_ns2=3D"${6:-0}"
 	speed=3D"${7:-fast}"
-	bkup=3D"${8:-""}"
+	sflags=3D"${8:-""}"
 	lret=3D0
 	oldin=3D""
=20
@@ -574,7 +573,7 @@ run_tests()
 	fi
=20
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
-		${test_linkfail} ${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${bkup}
+		${test_linkfail} ${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${sflags}
 	lret=3D$?
 }
=20
@@ -1921,6 +1920,24 @@ fullmesh_tests()
 	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
 	chk_join_nr "fullmesh test 1x2, limited" 4 4 4
 	chk_add_nr 1 1
+
+	# set fullmesh flag
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 4 4
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl limits 4 4
+	run_tests $ns1 $ns2 10.0.1.1 0 0 1 slow fullmesh
+	chk_join_nr "set fullmesh flag test" 2 2 2
+	chk_rm_nr 0 1
+
+	# set nofullmesh flag
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 4 4
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags subflow,fullmesh
+	ip netns exec $ns2 ./pm_nl_ctl limits 4 4
+	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow nofullmesh
+	chk_join_nr "set nofullmesh flag test" 2 2 2
+	chk_rm_nr 0 1
 }
=20
 userspace_tests()
--=20
2.31.1

