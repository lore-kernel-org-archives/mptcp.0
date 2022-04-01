Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F217B
	for <mptcp@lists.linux.dev>; Fri,  1 Apr 2022 15:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648827082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5epcZGQKaa0TT7hMtpEISfkfqb4Pl7oHJYKj+0jOfdo=;
	b=WQat8hEwBYzlMJp2ZnCMXBYBe811p77VU8cSdi4mN0zPjdNAWY1/GXC3ITajw7y0vcckyP
	mqDM5HEb9PttJe5xvWKgM4CDd03SBYOlny1qdjjxk8lRsahlRJWMDtA6/OB3b/JpQU3bW/
	jg2IS6TaOErvq0ksykKPBZbnQVpluOA=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2057.outbound.protection.outlook.com [104.47.0.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-jKXhzX3kM6mrYaqvbI8XwA-1; Fri, 01 Apr 2022 17:31:22 +0200
X-MC-Unique: jKXhzX3kM6mrYaqvbI8XwA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duJ/5q+CYUmiQT/xhbVOH/0bT0wmwPgH3nUReOi5SFUUvVZtgiq5cG1sI8P0LYjE3az3Je6Q1zlUnrXnEOzVrRZFKelGV0h4yiKTz77HK5jPSuEC7E7lVlviqo+e696QDGDHRDm/zperyFkeOTT54YGakHilt4ZYJHwNtNpOEHKf4ZJ7CiB2eMqunXzg0/Z8NmrVGobUcpknCJPZtO0CfNoSdunKGkoBigt5iowZddNLCFvU4rqspWizN32wihl/I5UP53Ux76z5Cg7Ogr6tsYrj8wti0p6t3DqRBwehd0Q9HMy0o2CfEZ9AuDzV2OhO5GlJxur5N7qoQ1gNjtNmQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXlpdoLk/axwcdTgY3Oy8BirHh1sSEELd3/DkIt0QCs=;
 b=MwuD/iPW+JSNiHq/GhQn2kZCYanOpi7RtC/06G19+SVyU+EOUL6mctbxK1m1QFV6Ekiig957+b3Ez7dzBm8Mh3Q09ywWsW7eo2cxwMgNwtzzJAmWlEYQKvI25nu00IjRg7hGIUb4uhKYCTENAIEg6qpd1Wwnd1nfryZrk7LipoSE2TE3ukhtIhF2HoQHOtSNjB2HZ9FQKaQYz0DPvjuNPPH8cHb34e8dSZr8+SesVKYN0eTbHUhCVbMjIMARbE43x6qRIKKgt7gH/Dx0J4lEgCJcm8Vt2nJvm3etTQtqI5nkD5aQv0JexzjAVO2zgmaWW/2/poE5Pb1PThy7iiDweQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3418.eurprd04.prod.outlook.com (2603:10a6:7:82::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Fri, 1 Apr
 2022 15:31:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.025; Fri, 1 Apr 2022
 15:31:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 1/2] Squash to "selftests: mptcp: add the MP_FAIL testcases"
Date: Fri,  1 Apr 2022 23:31:06 +0800
Message-ID: <80f84ba19a38140e5ecce9609e1e6981a0cb0a46.1648826372.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1648826372.git.geliang.tang@suse.com>
References: <cover.1648826372.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0082.jpnprd01.prod.outlook.com
 (2603:1096:405:3::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c8bad25-f6ae-442c-69df-08da13f4ac22
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3418:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB341894B451AEF3C4B86AC7CBF8E09@HE1PR0402MB3418.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TLINgvMBAvBufbcX5luhdQBbupbANOV6pBqliz0F0OjR4lseZLGZU86sWWcoV8O3Gf8y81uDxVm5x7OVREMSVH4GoWO7x6YYIL/Ith+4iBGxU8Ef/zMmNMFW+8iocKddd5/4iDV/IZijXfecQ7evCufs3RwaiVYdQD9T/QUQOBAJ4aL6HQVWhdz9Vqeic0o37VcKTPeaOlM/fRG3Xew7V8FGb4r5K5BRk9bXH1RdTV4lTSDN0j788K3wd6JhapAAGcpHeOMraeKB/DNQsWLU/BiWvpvygVTi1Uz2c7m4MdrGhhCecdS4jXNgLxbRFoa3FleZwC2k9GGK4bobx0pWF017Y7QtvcblbhXVQC1rkBdrPzZursxx0yuK8PWbw7VEt36UrYh4GfM5c/Mm61NaSIHrb+a/j7smsEcn7liJTgPz25ggaB4Fa4IHuK16vYe2DNL5TuBA+SJzRLOOYLPOLEv8wJG6Bk2GGYoypXRpTGaFJJdexNRdQEo99JILjdwtOwIOUEPStdZomkZtvFEqZuAM86evZQezN3ND9qnWAc6fEX0UR9w4GCDo18YJ+5p5D0TkWIYm11HWEAXetaamY4ABxefSfWkZosyShboR6xlaP6CxOL7TZvD8iaoEsFRHxDYbi8uMCksT0kOj7NOPq9Jx4BSrOiXw7A47JY0MPhe9SquNljBMlx3/47yZK9ApGn1Q678dTYW/z0h2LoliAg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(186003)(8936002)(4326008)(107886003)(44832011)(26005)(5660300002)(508600001)(6486002)(8676002)(66946007)(66556008)(2906002)(86362001)(316002)(6916009)(83380400001)(2616005)(6506007)(38100700002)(6666004)(6512007)(66476007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3ab/WHcHRMHzHZxiaTtvttp0yexLH/ojrcivGsvDFK4l//7JqoIT7Hzuo1Bu?=
 =?us-ascii?Q?9XFaF+kEVIC0tireyMN62+au5bTaVuZzVBUb/wVjsNpORKFcHw76QdVyWwmv?=
 =?us-ascii?Q?Zc565djhKEfQBMwcSeQG7NmkeZ1KMG1OcN/w7LDDdSaQ/MjloX0oP+jG7fe7?=
 =?us-ascii?Q?+qI4y21aFSv5QMw5TYDgSl+plGPLNzh+yOOlN8ANdB8orybevX5NOFgzZxuO?=
 =?us-ascii?Q?h8TritubCiuCGZPi2ut+b9AbzcHQHegkQff/JRYFkbnzQLJA/Hz7xcdKZzo7?=
 =?us-ascii?Q?KhSjfynAlP7pVDjxlsPtChvtUMT+hRI04sdFHaa2FIQg2LCPwOODXN5q6cEX?=
 =?us-ascii?Q?4iXdutJ5671h/gY3OVdQavMeBHVqXAnBPh07YFuAzwXTiEitQ/UxS3rTfo9f?=
 =?us-ascii?Q?W1CBLamyptKWHukuKlv8eCLqx82zIV1noN6QzPYP/uHhWgcbKsDSLbcC4eUZ?=
 =?us-ascii?Q?aIpJVkeAeXez1MNH0Vbn8Hv+FXOVet7CRuu/aeZSqe4dSBI53mH39QeHX73D?=
 =?us-ascii?Q?qLv8yEBOIrcfX2Kg65B8vh/ZmEiRmn4JsTdijU8//qNgJpAxoXoUVGY/RR0T?=
 =?us-ascii?Q?7eDkwlMrL6Txet6zkDB+0TR7WuNlU1VCt9xusibLWiZM4F6owTFQ61XZj/Ns?=
 =?us-ascii?Q?+JtitD6lgasDoHgRUKT7+XQ0g4c1s6ODV6Ait/BSTwCSwIt8AHX6uWKkMf0w?=
 =?us-ascii?Q?Gplo4LApcy/icGwpiUgByDOGzm8wE9Fs2mJf1kRImFnD3MhQVHBQwOQrQESC?=
 =?us-ascii?Q?hZbCwqsMAGRu60HSoNWo5IyBlWwSwrzEgNwYtjb5mGtCtV+YfLc2RyaH7sX7?=
 =?us-ascii?Q?Id4kY+KIOorCbUQKvQmgsvrEms9XnZlQfyPeyvGer11qPhZsci6cXkN2XvAw?=
 =?us-ascii?Q?xqJ23SjbxKMS+p/1M4EbkIYcBzOuWvgxljkmlHk3/gvedgZCRExCGafIKYpC?=
 =?us-ascii?Q?0JdeHqnOT6U0j1EpuDVDx6vqQIRFl72lY7qEKDIOD2MFwo5gyNd7OwSsDoWV?=
 =?us-ascii?Q?80sj2u88L1qpfY61rXUC32yLO4o3GZKXTF+mrgrZvdRWpDYlXidgWWsQQqx4?=
 =?us-ascii?Q?WtEuQcrdSMJ+dCLQ/w+aqPUR5TiP/PjJf6B0fJbG4tTku3meRq9EX0BAHPn3?=
 =?us-ascii?Q?jTfP4Hk8bV4pmmItlJQViqPEbCRvuFKcO1rLb6fqAT02sxV/Dx/CrC5mVls7?=
 =?us-ascii?Q?bfbCrC1EMXnZ1H3jBCzlTOZPQWwD1JbtWuwE/+WSXQIdnccwmuC9MI27y9ud?=
 =?us-ascii?Q?TZ4qjetIRmqrIVQIxxytGl+B4T3O/zEMyxJfIUPPjvqxnNLYWK4y4ekFMZXR?=
 =?us-ascii?Q?ADKvlx7CruNGBaF2QSFy0M0Usejq0qitD/KA/olRx4I++hvpHtddpHWN37qS?=
 =?us-ascii?Q?bOsOZW3yXX1P0yS7rXFwgghyRdDj58/8BAXdSjE+hmNPpUyjZwsgU/tCPMbM?=
 =?us-ascii?Q?v3sXMe0z3N1u++AqvgEXRrLFwqCC0q2dv9P038kmvkYZJK0bxMzoQqBj5Zai?=
 =?us-ascii?Q?rlGbi+w0gOZ5nCcVwADio9Vinp1F4R8MpSqmAa33kOVopjzQ7EnwHiqXhs73?=
 =?us-ascii?Q?AUrCozwI2/5lqh1NjEeS/tEf6gATDonIPp8TmHfQAbsUrbGVVnZJYF0S5xDY?=
 =?us-ascii?Q?+L3y8e8SaJ9ueJfPwqs+M366CxMBWht2TqWi5q6AOT0nwk9u8dChVgWIi5hH?=
 =?us-ascii?Q?xeEmI0oiZOvEwibGZbsc34PCMYtaaQn9ABxRsDpTpPRZ6AKit1OV/BY3voDk?=
 =?us-ascii?Q?55sNSScOhzJQ+maX3W+lsOBZygGgKF0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8bad25-f6ae-442c-69df-08da13f4ac22
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 15:31:21.0668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yukJWNtSstnVFTIVbw7eCIr2U13gBDPN4Jd4N8paW5lOWvdMIJ3HHMrUTqaum1ylq6p4IAH3HgpmpK8oJfgmRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3418

Drop the multiple subflows testcase, make this patch for the infinite
mapping only. Split the multiple subflows testcase into a new patch.

Please update the subject and commit log:

'''
selftests: mptcp: add infinite map testcase

Add the single subflow test case for MP_FAIL, to test the infinite
mapping case. Use the test_linkfail value to make 128KB test files.

Add a new function reset_with_fail(), in it use 'iptables' and 'tc
action pedit' rules to produce the bit flips to trigger the checksum
failures. Set validate_checksum to enable checksums for the MP_FAIL
tests without passing the '-C' argument. Set check_invert flag to
enable the invert bytes check for the output data in check_transfer().
Instead of the file mismatch error, this test prints out the inverted
bytes.

Add a new function pedit_action_pkts() to get the numbers of the packets
edited by the tc pedit actions. Print this numbers to the output.

Also add the needed kernel configures in the selftests config file.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 375b087edc7b..c7a26c40663f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2698,16 +2698,6 @@ pedit_action_pkts()
=20
 fail_tests()
 {
-	# multiple subflows
-	if reset_with_fail "MP_FAIL MP_RST" 2; then
-		tc -n $ns2 qdisc add dev ns2eth1 root netem rate 20mbit delay 1
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 1024
-		chk_join_nr 1 1 1 +1 +0 1 1 0 "$(pedit_action_pkts)"
-	fi
-
 	# single subflow
 	if reset_with_fail "Infinite map" 1; then
 		run_tests $ns1 $ns2 10.0.1.1 128
--=20
2.34.1

