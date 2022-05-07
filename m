Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F3DEA3
	for <mptcp@lists.linux.dev>; Sat,  7 May 2022 06:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651904272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=soBi83udivpqr7Rm+cWmnBScAq6I5PwCD19YWb6LLLc=;
	b=kuD6TaCgOHt1bO7YlGcgk/Ga+Xqd+H0RDvIJXslATixJpzrg///OPSPU3o0IvgRMS+Iu4S
	dIu5zZndNyxuyJNIQjPCPpK+ZlmjEQW/etxjpp8c/ImyLzI6j03YvPPQQDz06XTAHJs7al
	202zgpaYtGXgbptp2sXfRVEdmy1GtBo=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-9htH5kc-OIG7ENle6dLKmw-1; Sat, 07 May 2022 08:17:51 +0200
X-MC-Unique: 9htH5kc-OIG7ENle6dLKmw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/WBjHEdPW4TfZJ7UUaS81If4ejT2qhNKc6+Oa+Dlmimhq03L8bJUJtvEa0smdayqgtjk/IGxAP42zOclzIjGyMtb0Qg1MnCNVnd9ApLbqKUzgM4Rkr3MsPwFwjIdO8PWbzt4GBe3l/IgYFzqpL+gCQ1tz0/SB/D2vTDbkEL8k/Sm/rFc4agC066z6SK9B+75BSU3CxrwqGuHUMXvVP6taEAf8Qmvqd4HXFf/grbd76hDMnErJE9GuliixE1+5pDc+HY5/zpmevIEwHkO8lp7xpgoCwN8EKReL2jCp0E+Z20kLyAPK9UHZYFrEKK56Edo2J+u2+XgJ5MWQxDKsJ93A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULQhgITVwRz8aPhwsRK+XWftfpmxrenLqPdU80C+Ios=;
 b=ayxbqRpKGX3BHxIrI/JokfgVEhqXGwgGOAS5Nv8X0/5oet8/aUxu+iB8dk9hhVKkhm57Nb/rACLlsyYyQsDMOraMq8Ikr6BOvAsCKMM0lvNO+YhFBKUpQUfp7XrzS/4RE86bIko/z4xTCA6+YVOFiJZl5f5Ln4dAg7SmJU047WjnlVaWVwUQrNoZNgH0HRowFl6gBLp4fCGX//LyQY7bfaiMrwjRKpoi6MwNv7KWAVD+7swLguLrh+WdqsJdL9+7AumvsU1yOGWpk6CG2aABku9XPKirreKLubGFNO8Qur6LHpvE+kyoO+E3mjvO+np2PjYPOq7RkwTvmmDqFeIqWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7489.eurprd04.prod.outlook.com (2603:10a6:20b:281::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Sat, 7 May
 2022 06:17:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5206.027; Sat, 7 May 2022
 06:17:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: bpf: test bpf_skc_to_mptcp_sock"
Date: Sat,  7 May 2022 14:17:31 +0800
Message-ID: <a9c8e40a85a5ebb0e4ce0fd6a20eda4d594ccde1.1651904137.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <83acce83a5bafc3b45c45b56105678210d07ac92.1651904124.git.geliang.tang@suse.com>
References: <83acce83a5bafc3b45c45b56105678210d07ac92.1651904124.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0062.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 089dbb99-8624-40d2-ffe2-08da2ff14fe9
X-MS-TrafficTypeDiagnostic: AM9PR04MB7489:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB74892DBBFB4EE29C32ED32A9F8C49@AM9PR04MB7489.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4F5RHJblL5B3bK5B7oVmQYJlJdmEeEAlP4n73l9fpO5ozE8rgRlRq91wGJKRzk2rPELScwpcPsPj1w8Gm2aOEloA43FSUiGZrBj80TY12PUouE57jZvH9I6X5Rmr4FKq6C4n2WW/LuvygmLNSndT/bARvoFC8gOuWFI/IARxgG4Gsm/CO8gPPUThl3JXX5bto3gQhRNwqhU1z5xv2CZ5HpkNvjoVO8qi0MIVJR0vSQlHgZ5bSagN2wmPpOM3F4gAlTLZJVHJcMxe1CB8Lu14KGq3wTb8A3H6Nx8EDui1n4T3Gv63vOwcpP33gTfCpUDohigC4UclxyGsdukxsKpSxYhLGE8tXrk+cJUUTCfM+56/5+mOKBI/flE/Vo8gZnHoZM6Ph/ultmt6V5pNos88RFxcTDEPIFuQodsPYoDMop8gS4Z2G80fdA5IMlMpf4aAvIeRi2pC1jCK+0MxBTcJGWAqgCMoyRrQITAJ1882WR4yj0H4mVpiFyDHD4TYuOSp3Wk+pI4P9nAdrnQvqu6e7eVPuQeXbL8ou26MHawyicXvU2ZOBwKkcQCmt8diIAsW4W/oXL9gnJYL8B2q/OV+efLn+A0/0QzJ8GPX/hyzE2b1eW44LMRnDUTS6YeKZjC8T2aB7qH2pXvFlAFplFdDtUenBRjD32EQx5KkiaOxGPwQHtr7ebr/Y6rke80fTZP8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(8936002)(2616005)(2906002)(5660300002)(44832011)(186003)(6666004)(316002)(508600001)(6486002)(66556008)(8676002)(4326008)(66946007)(66476007)(26005)(6512007)(6916009)(86362001)(6506007)(83380400001)(36756003)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UHfAUMyDFtDwHorngeG0WImrCceKRXevP1C8qot+5ALXNfWZLR/iZRMs6KUR?=
 =?us-ascii?Q?fRDPMShpRRyVKsd8lXNdgu7P0pXslqj+WaGuXPlR1bAmtXR5c+yTvTWW176H?=
 =?us-ascii?Q?g4AiEhpP5dGA5JZ0nA5eGx2DXpL4IADB71iyKa+Bv6GRPl0Ql3apMLMv6yDQ?=
 =?us-ascii?Q?Drhl7X77MIeg5TkN5evzbPZ2DFMfH5WzBCfeNbgd3Ov16VkPxPPi0y/LJOjo?=
 =?us-ascii?Q?cwoCxO97jxSBXSDbiUv5/OuDWMvp+IrymMkT4kl77T0yMKDMwXnDmXdQFubP?=
 =?us-ascii?Q?l3UdhtYpGBhsASg3CYDemFEeU3KLA7cqVzAjKpkqkdV4pR7MIy958hk7T5JG?=
 =?us-ascii?Q?tUs2JC+pRSuJmROX+hd7gJmlyzfm8sAeBS5bjQtZi80Gghi91PkCSZhhdMV4?=
 =?us-ascii?Q?vg0fgIccsyyyUXFivzjxpIdI1tvFs2AcVGQFVu1YJQATEbF3Ow/Gad4eZdNq?=
 =?us-ascii?Q?26op08dPELN0WnGWvNw8mwfq+koMhMnagDZGf9NCYYaJLg1LKcT5Dakbd5Xz?=
 =?us-ascii?Q?zQgHZTuYZJAQK7m0PzMrTZxZMkU1sroiaiXAnrvcuixPYUIJIR7Ok20ayZuR?=
 =?us-ascii?Q?jrbn0CzXqiv+Qul5QWUQ6ZvWX8cHXdXAXi/2J5qT/pq7ttumiCE8CPwS4WCZ?=
 =?us-ascii?Q?/NFrFc2JHfjYABysr4joADUd9N+9qI07dQjDNvivNCbvjmYWEsea8HkLNaqS?=
 =?us-ascii?Q?I95zPjcK2Gi1Hzr1rLRUB24/PC6ub/jpOS6dedF7Mf1INSc9SRv3qI+BIkdb?=
 =?us-ascii?Q?C3Ze9+7yd9ZWixkfgVy+cCKwSo9Ro1JKAqFBUdnqdI6D3dSzbUYS0JegVCy7?=
 =?us-ascii?Q?3+FYVewlIIDOUOASxX37mA9dbxR3b8ZMw1/VL70RpIp6pSgmINJdT7BLp24b?=
 =?us-ascii?Q?kbTGik+7ahCRMJY75ggf425WO4iMDxIcGOriBj63yF6VqTrwJKa2/O8CMB8j?=
 =?us-ascii?Q?gHXkAHK+PjzQ2chMBR7oI+d12pMYFjyQ3juN31Kj5VBckm/GkFVGjNLrI21y?=
 =?us-ascii?Q?dzoT8ilaLjQXg9OxosUjbp8At7Z0QA5v4kpz5EMcyDvdZOo3lXm6EwYhSall?=
 =?us-ascii?Q?i9poU+MEbt8IxQ7aLNh1jJP1Sd4Su9hc3F8E69wJoy7fas/d2ziMvck/xolW?=
 =?us-ascii?Q?ZO8W57RKovcx9B3FSBheZdbl4mOSNjVsRbg2e36uS3aaCf7hnZTTstnsvT5T?=
 =?us-ascii?Q?ixSDKVtMuozR//kooYc/YF9fYL3lDL/a+m1B2XguLjCZMXQWdUlnQNyS6QGT?=
 =?us-ascii?Q?7Az0JhUAP07ujhSIsooEQ4FXnMWTJeXeFOWg2D0y3upEBjW5MjRrtESDuDlK?=
 =?us-ascii?Q?ldrCTdmTh0nu8m+xjWXdjms2xOnzeLFPnsp9wQnDHFt6jPI2najQn0iwAVGN?=
 =?us-ascii?Q?KMgICLfyTuLFJpohEKXa16A6skbczp7QZFHsu368JG9qPb25m+3lfWGV/9DK?=
 =?us-ascii?Q?ikikXzy5qk1Beu5J8GMULCnS3GLom0bjxzxDztF0LmpmgyxEk2SWLGPu7C1L?=
 =?us-ascii?Q?tPS5UvwMDYKc6kkNcpuRbaHCUSogk/G4bkTrKmj6DDE80wENQXMRupShKqlH?=
 =?us-ascii?Q?sIiafHjscGyVqKLs1MyllF20eyzTvrZCbvniN7TmCgn00Amd21ZgiT9VPQYY?=
 =?us-ascii?Q?nsfIcqSsg/SYZ6uk9Ys3STiu6Xyf1kv7C+I+Nc/uADyXRKrE3QnzYwnFF0de?=
 =?us-ascii?Q?Et0C1zdODQMZ+KxfGQFWdqaNDnH2WzpRWSZrIgTWxzPzLUTkCAKpaTuAgXcp?=
 =?us-ascii?Q?/qmBKxXx3hPhGzOHmOVakOg3g0gEv6g=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 089dbb99-8624-40d2-ffe2-08da2ff14fe9
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2022 06:17:50.3361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FD+NUC1ABySx2ojZvWNhY2Kxr/DmW2nalY3vJ51+gaR7ylI1GNJGaS4T/Xfu+fOtMowoKMpJWLJCXVPbt5rLBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7489

Address to Andrii's comments:
- use ASSERT_* instead of CHECK_FAIL

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index b74df17b47ba..2f2b110d7f56 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -39,13 +39,12 @@ static int verify_tsk(int map_fd, int client_fd)
 static int verify_msk(int map_fd, int client_fd)
 {
 	char *msg =3D "MPTCP subflow socket";
-	int err =3D 0, cfd =3D client_fd;
+	int err, cfd =3D client_fd;
 	struct mptcp_storage val;
=20
-	if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &cfd, &val) < 0)) {
-		perror("Failed to read socket storage");
-		return -1;
-	}
+	err =3D bpf_map_lookup_elem(map_fd, &cfd, &val);
+	if (!ASSERT_OK(err, "bpf_map_lookup_elem"))
+		return err;
=20
 	if (val.invoked !=3D 1) {
 		log_err("%s: unexpected invoked count %d !=3D 1",
@@ -127,25 +126,25 @@ void test_base(void)
 	int server_fd, cgroup_fd;
=20
 	cgroup_fd =3D test__join_cgroup("/mptcp");
-	if (CHECK_FAIL(cgroup_fd < 0))
+	if (!ASSERT_GT(cgroup_fd, 0, "test__join_cgroup"))
 		return;
=20
 	/* without MPTCP */
 	server_fd =3D start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
-	if (CHECK_FAIL(server_fd < 0))
+	if (!ASSERT_GT(server_fd, 0, "start_server"))
 		goto with_mptcp;
=20
-	CHECK_FAIL(run_test(cgroup_fd, server_fd, false));
+	ASSERT_OK(run_test(cgroup_fd, server_fd, false), "run_test tcp");
=20
 	close(server_fd);
=20
 with_mptcp:
 	/* with MPTCP */
 	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
-	if (CHECK_FAIL(server_fd < 0))
+	if (!ASSERT_GT(server_fd, 0, "start_mptcp_server"))
 		goto close_cgroup_fd;
=20
-	CHECK_FAIL(run_test(cgroup_fd, server_fd, true));
+	ASSERT_OK(run_test(cgroup_fd, server_fd, true), "run_test mptcp");
=20
 	close(server_fd);
=20
--=20
2.34.1

