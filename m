Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546227E
	for <mptcp@lists.linux.dev>; Sun,  5 Jun 2022 13:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654435857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WWEP/wyamLnZxSSxtJeTlU7/dVWUCPGItWuKR8r7UlI=;
	b=GgOx4/kFwTIZfuDlK8W3+ga5DFmFlD0k7TYJGstkSCMxWm7G+1sfVZ9BmF7T743T1wVgAM
	3MwaFTUQJZr6nIbJvOGHtApaOBsTIMBLspnSkrisPQJp08Gv8OYdNCbvAxKK6WYgm0nWwg
	Elv9dl1Oi07PdH2h3MoW/WZMSg64ruo=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2057.outbound.protection.outlook.com [104.47.14.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-pFtTqeBBNIS88ecGcXH87g-1; Sun, 05 Jun 2022 15:30:56 +0200
X-MC-Unique: pFtTqeBBNIS88ecGcXH87g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtX00tipttE8mRPTLLFUVel3I4jeP7kgODZDJV1rYNO5UdrLMUaCpowiliOLQ/MKzMXmd66SW/N9fYn5WI1azME0LRSjJDvOlIv/4J5YCFER4JMmeon+K0b6JCVAhtOm4mf7XfoYhdgy2KVJRC+pg9HkU76e8i9MCLCv3E7DLFs83lNay9NuNyKI/Gkj7ldx/3PcH20w0CLO+RKPUscOazFX6N3URSd5nuINSPSgvkbImvdZ+SJIONbp+VzZZAoyTIXwsDRZUVwb+8t5DrSMtlg3c2R5oFd6FdZQOY8lj8sCqZdC1C2SIGyqOlo0wE7fZyoeBb3KWbdSigkZPd9wag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ai3kSBQTYD2GmYnF7gbvplw4aV/HQnCWdyQ3RtCEzMc=;
 b=lP7L81CF4M3W+Fqbop5HuG9wBStyiPbOMhutpPCNn7r1RwmJ+uTDRfxHS95CJuy8Q43C6hEbeUP1uVh0aA6Q8CcZsD8sTwOes5K79YuegXE6EqZ/RRt8r5XVnfq7vZrdE+4hRnPP/GDNiuiTobWcV705CZ/jQgMNFG0EpuHtiBHI9TaJ7yZs6EEG15iHzZtiYQ8F24RVjzznxbFzGpnEyaZnM9JsKW3XKSHGYFpvDHV3BIpOa6drf8JhRE5bnoFzQUEB8FA58PDoeUo2rVEMQuAlhELEERHmNgeVHNH96k+mLe86A21PlolrUxCH96fSHF8m5IJnTCcJ7u4r8E/ONA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM0PR04MB5028.eurprd04.prod.outlook.com (2603:10a6:208:cc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.18; Sun, 5 Jun
 2022 13:30:55 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::5082:d38e:6d50:4f7f]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::5082:d38e:6d50:4f7f%7]) with mapi id 15.20.5314.018; Sun, 5 Jun 2022
 13:30:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 5/5] selftests/bpf: Add bpf_red test
Date: Sun,  5 Jun 2022 21:29:40 +0800
Message-ID: <dd9799cf2ef5365fa38bdd10ae831034b91d1d38.1654435294.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654435294.git.geliang.tang@suse.com>
References: <cover.1654435294.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0106.apcprd02.prod.outlook.com
 (2603:1096:4:92::22) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d81aec5-8e13-4ac6-655d-08da46f79e4c
X-MS-TrafficTypeDiagnostic: AM0PR04MB5028:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB5028D978310676AD56346C4FF8A39@AM0PR04MB5028.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8sr8ywZi3zD0lOsJgFa78I+0jlK9yy5Abf01XU0sKa8bdPL5K4ejYGs8g0dSzekzAJfCY2XG8cOZuo9fM+M1yXmiYxZ+VjC2d1DlqbkKYDzbvnssDHIlsaJq0AR2GHZZoss4RAkxsdKMHTuEvNt4E5sxOcXhrIPMKoF1JnGy8kqkFisv8J5n90o2yVVeiiJD5Znpsf6+U9tlDVJGGoXy0JEAhP0Y7Ud+qOSLB2v6w4mGuTGuhw+FiJdQj4vTLmC5HE9A8I6FhrqqWjqkpwTKDTFKRI4BI+fbFGopbvl8Fcp0wnPRTYnvYaiaytx5s585WrGBJ98iN52HPqCc3aJkHwYZ2tutycRefDuJlO9ifBFi9QUanKsyOQz0yIS7yQzSu3rDl9oLfqtI+Vn7ngPv/rTMQsLmLwjDYaokf1a/8tjSlM+sNujzd7ln6ddgTROMfFvBNM8Mm6wD7mvZxYcYzG77XtLChPO52Xj6gZSkR5WvBPbOCAiDbHmQdeelnnFT4nOQ3spiQuTa0vgRYLcC0kd/R7nb0F4YZDDByqc1VDqn1PGShvAzg3CjjYHYhJTzZ9LEj7hQyn4kOhRRMLK14bomAgdrzr/87PeNEUuWCAfR0RoIJbDpLpQ1QHxpsgUDJEJ1o9qYaLBuTfbYfmptT01rc9XS3gCvO+RGchwLEJfiWvBPLvSjwl18MMtYeHFW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(66476007)(66556008)(66946007)(38100700002)(107886003)(8676002)(186003)(6486002)(86362001)(6916009)(26005)(6512007)(508600001)(5660300002)(44832011)(36756003)(316002)(6506007)(2616005)(4326008)(2906002)(8936002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dj87qw3RYhlW9p+TXd+vV4IZwLCRW8ZdTfA6bJ3c6viVPPlRyAnqnDNGsjXT?=
 =?us-ascii?Q?ttLAgFzV5wxcBya6S8s4WB0SjbVexC8KZibC+2VOnB/7ArJttvCj4vTbaard?=
 =?us-ascii?Q?tUQPKVCsebScjxM/vEGDp58POzxE95hbZ7xjYQgP/bzSv+7i1b/jFuGS2OSz?=
 =?us-ascii?Q?bGhKwVhtC60wCo+Lkzdcg+Bs7YNJye+rWtiuZzHOjvD84rvhE1v2y4BTYFAQ?=
 =?us-ascii?Q?MZF3cHXiHF2s4BlbN10KSij/M3PjZB2sSIdca+rfYlQl/ESFQ/eb36E5CGWe?=
 =?us-ascii?Q?Aioliy3mhQzoLSN8k7hMBsP9DAuAMH0Ks2EdTNaXekLY4S/mKz7nMQs/QJ16?=
 =?us-ascii?Q?2rDNBauVQRZMfAiNRl4kGOMl+IoQtoAITDA1J+1oZYXEHDLrDmOSyEG6H7pU?=
 =?us-ascii?Q?NItKvm2NYXOTdCL7DCW4fYnUc/BTQEEQJsVA67KkXDv47jU1wEgRzUQYIY+o?=
 =?us-ascii?Q?kzQOECvMGv5prm4pkhbQTrRph84BXr1KEvOaE72TkaU6dtmtjgNaNbtUUQoH?=
 =?us-ascii?Q?RbRtsu9McvVKf9CH8t1jE+H6SmBjKjPjxH547oJkB1Nao0IOYCxHvQTAet7c?=
 =?us-ascii?Q?64J2vRs7Y1KQjcgL6ctjzxAHRYR2kg/C9YdtIciSNf7KYCLS0FGigu4CrZzl?=
 =?us-ascii?Q?5O5g8LxzCRq88tlUlwIbsSfqP7RZN+Ke1dhMpopBxCtes7sLbHoZdPv4vAT6?=
 =?us-ascii?Q?GwLBK6tbp/yrvTJsmztA2jNdafHDovEe10hgkiRcxIcF/RmyKsxd5l+pXdnN?=
 =?us-ascii?Q?eiwYUoPco3ecB8oyMgXE4vr6QlkRbDDUqMag5pdY8YjapktXgQA/75mcHubB?=
 =?us-ascii?Q?GWj7G/xG46yuP21kWR68m9qwV9ekSoP+/j7E3TZy0mOaNbfoDJNoQXAU1h8l?=
 =?us-ascii?Q?Wm94kw+3SSt1euf0bZB2KHCKwjBRvisDesnYX7K2eEYtK7vm4JC26i2WrW9o?=
 =?us-ascii?Q?sF3tlZJFzkYUDfTgcgGmp2Xp3q4XGQWJty4yF6q5/T4W05w2qWqdkHq/HWRb?=
 =?us-ascii?Q?/uSAZ2l+fcshA/lgeugSG3YuL/jq0uMMjqmIICRW35Mq2+3NSKCwviCke7Hi?=
 =?us-ascii?Q?1VLGwxmD/zdfDxFY9RxvB603UMInfewImE2ycp1LEI/UQO3auT91iRvW+GVg?=
 =?us-ascii?Q?NeXIC0F3/bMUihqJ75eR2L89JVEXRNsSJBs3z30usDedA6jo9E1ODtOfTWv2?=
 =?us-ascii?Q?Xf12lb/+c4MlHsWJkXqv/Q18eBE234+mL/fwlPgJvi+D6zYFlAJnNDscKnzF?=
 =?us-ascii?Q?C1nyyPwxs1zEeSS6kcALeQ3cvF/qcC1dIwrDVi6Ta19pTgz3K1v9PWdjUI3n?=
 =?us-ascii?Q?AripPIbW3kcQ4nPNdH1Vg7Ni04Hh2SvZmEfIAnGk+553wHz0tscq3oXqCfL3?=
 =?us-ascii?Q?tUO+yBzf+x4q5C2bBisvhz78Nj/lRTjPREkuXLNqMM67++Qv+lgf5/lbI5dx?=
 =?us-ascii?Q?PatC8o8dmmMGgLMbamrBgeEScgtXZ4lC0k9aJmYaLtXNS8Is5EuDzMGGdP18?=
 =?us-ascii?Q?2+U/i+enuBZElCQxWJEeUS6/z/+RRNvGKyBJ25kvmh/ceJHpEWqRJpnDsfhC?=
 =?us-ascii?Q?USoJnJvz8CehUx/OqCsgwrLSPFWbqM6lqbFoqZhUy68n+KDX9GpnfN18mvos?=
 =?us-ascii?Q?8a5k/oxhSQOX0CPXFNSFWI7QNtcOVhSF6KwuvnBQVHNi6o6MxpJibNvhOArj?=
 =?us-ascii?Q?9rTr+szrAYysKWJABPF5YHKN03VIZr4psLOqdHzjr3r3tAd7tpIrd4OEfn/f?=
 =?us-ascii?Q?XNCXao9nLnAMW52kHsvPSUU7EmrWL7c=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d81aec5-8e13-4ac6-655d-08da46f79e4c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2022 13:30:55.6300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4yI08dUMjnjeE9d7CRe5IITgPRfGXmmq0qdGPrF5yMpX+/4OZLs2Q26jPdVaq5ffl6mgFoNFAuQaXcPpbWl8Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5028

This patch adds the redundant BPF MPTCP scheduler test. Use sysctl to
set net.mptcp.scheduler to use this sched.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 1ecc8a2b76b6..e321cd046368 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -9,6 +9,7 @@
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_bkup.skel.h"
 #include "mptcp_bpf_rr.skel.h"
+#include "mptcp_bpf_red.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -362,6 +363,38 @@ static void test_rr(void)
 	mptcp_bpf_rr__destroy(rr_skel);
 }
=20
+static void test_red(void)
+{
+	struct mptcp_bpf_red *red_skel;
+	int server_fd, client_fd;
+	struct bpf_link *link;
+
+	red_skel =3D mptcp_bpf_red__open_and_load();
+	if (!ASSERT_OK_PTR(red_skel, "bpf_red__open_and_load"))
+		return;
+
+	link =3D bpf_map__attach_struct_ops(red_skel->maps.red);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		mptcp_bpf_red__destroy(red_skel);
+		return;
+	}
+
+	add_veth();
+	system("ip mptcp endpoint add 10.0.1.1 subflow");
+	system("sysctl -qw net.mptcp.scheduler=3Dbpf_red");
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	client_fd =3D connect_to_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+	ASSERT_OK(system("ss -MOenita | grep '10.0.1.1' | grep -q 'bytes_sent:'")=
, "ss");
+
+	close(client_fd);
+	close(server_fd);
+	cleanup();
+	bpf_link__destroy(link);
+	mptcp_bpf_red__destroy(red_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -372,4 +405,6 @@ void test_mptcp(void)
 		test_bkup();
 	if (test__start_subtest("rr"))
 		test_rr();
+	if (test__start_subtest("red"))
+		test_red();
 }
--=20
2.34.1

