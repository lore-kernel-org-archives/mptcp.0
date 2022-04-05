Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBE228E5
	for <mptcp@lists.linux.dev>; Tue,  5 Apr 2022 13:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649165598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G2X+NotEuIUM8Hh08PZLxKOY35OGWug777jx8n/Ctn4=;
	b=QZbvLv5wX183XjzHaF84yT+e6IKqbDcq8xtdN/pQXuJ+AoKM+U3sp5UdShGOO7x7YHvD7o
	n5LbLf0I9Ix7SrN9Iw4IDcM9fn3lZVacz7RvZ7RwKu3R3CNRUiuK4W/Z39IUOyKg+StrRv
	dtqYFVj/LJeIGw675IEncI3OLZksNNU=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2052.outbound.protection.outlook.com [104.47.0.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-04mC7_anPqaWObXPJcNJ0w-1; Tue, 05 Apr 2022 15:33:17 +0200
X-MC-Unique: 04mC7_anPqaWObXPJcNJ0w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nnk9obpRGNVx6ZxxL80XC1VwL2WnnX+YQzM1Lt4HQdGNRJorK03m4RDxYInE9PEFojTZXKcCO2CaftQOKDUZW2IqPDyLeBTzRvS6gJN0xSonbJ3E2MGCAbY0VwqU6fPEQTc5pm8INYC1W/FbLw8XxXc5TiOCckXX858lUr5G3XZJXGD29w01pOpjTPETcfOPeJVKQycPtCV0y9HELwaoVdHUOcY+m2OHaWGt+Wn33t2CpBxteE4np0XsVoJsbp5ruOHV/sUID2PRfVCZYZpisb4U4JT9/wSqhugmXxGtmhnZcTclXp3VbXaeXGniJwA9JyR4ZElljXmarrc6D18lzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4uatU09Gcmx1NOXqXBBGQ5V4h8fibD2OApWwZzwKx0=;
 b=UjSkoaL1mHlFfcnTCyCZuQs2AEDFtHEjK7jhKGmkB4osLjjJdieX2oaM4QPYuHDXwl/R/baklkM/yB2HwGJ6VgGLgAa0F2LOSC3/xNH+M4iZuzvGwyZuMPxKUbzzlPv4oNIMFWZtw+McvBdU1oDZ3ClarUkT+1kO+r4YH6B6p4zEZ0q5HcjahWzNaLObd6gT/3L6ekiawoVlDJOL/qo9leI1fiOHoHo7MH4Ht1ykfSIw48PW/XYxCDv/H2cZ0NIDen84DXf9a0v4bYx58PtrB4fR6bExF8zfg+xHBqyqdxes/p0el1KNjcjljuOUvsayLO2CwSDD6COzjK+38fmjHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3579.eurprd04.prod.outlook.com (2603:10a6:7:88::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Tue, 5 Apr
 2022 13:33:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 13:33:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: bpf: add bpf_rr test"
Date: Tue,  5 Apr 2022 21:33:21 +0800
Message-ID: <550a0186478b4844dc8663ad7424ef8f1dd1298f.1649165421.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0109.jpnprd01.prod.outlook.com
 (2603:1096:405:4::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e6d254a-c888-452b-fdd5-08da1708d66c
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3579:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB3579D314087A6A577DCF9F70F8E49@HE1PR0402MB3579.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FI6+A/mHH9pbVSKgVx9ZTiCspFEzkZUtaRqMQeZk5fJ8bqMUEtYnnzSaHYzf9UJcom7UqCfer29/SCQ5wk+6O5UnxAbWCEC8je8d2zx44hUHtaFHWtKick7n6071YwHgM3gag516n97jBT+CtK978wceYmcA+2XFCbSSubBoQz2PNPtVuLW0bafU9e/n3vhHjQ71kyUU5XZ4fkO+YFNUiNC1N57dSedCziC99UYKlj4HKioST7B9P1JMaQXWLnIVplrzTu62jwl1GLwRvEnny/Z8+2PqngehZ99DkYBabupfDNF9vxY6LbDhIWgdkL304jU6nish5BmoYVoeb/76bJtiahMA2IpWZ8sbGEj2aOODVIvHu9Dun6I+7yHnBuoQ+m68xClaNy77pq0dtBS2eDcAM0g2RbCtY6pxRWqBzc3X5niBaNCx5EeUPKA9ozT40xzFJCCqkcMe9S7mcjVx/cmQdrP+PZW2CGmuYO9CNwmzy0Nu/NY8oB5t0m+Sa+35cTN/ppPtpbG8BMyo6N8IGSnsI3JAx5EUz8GaxwPNnSaXV1SMmYHe8OvG6dktpx2nfyMoOX2VfG9YkdbAjJwwJTZ+79bb030WCKHF3YZY9WdAhLN8GGiiSocfi1Ew8hpV3st8jfXJRSoaNqYrRBeEqveJPUhMzwAq210VkES40RiqMk/qjo3KWjs2f9lz7HCx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(66946007)(36756003)(66556008)(6916009)(316002)(8676002)(4326008)(83380400001)(86362001)(66476007)(6506007)(26005)(186003)(6512007)(2906002)(508600001)(5660300002)(6666004)(2616005)(107886003)(44832011)(6486002)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b1Zq+a5WrEYcmOHEG+ZXB5O6NLIH6kubWhU5e8VRmttewyaCeK1koSZRmTy7?=
 =?us-ascii?Q?pJ/zpNuiE2OzRefUB+8cr4USPt/JiJb7vWfmzgnF2Mmao9hWuxgiPhYVNkVF?=
 =?us-ascii?Q?S6egiQ1cfBIhbltpB6KB3q9Gq4YQZqbjOd1EbG/O8wVIj/2QsV7iL7YlorEZ?=
 =?us-ascii?Q?c23sWb0+GIvXRENYhX0YkFjyrVMy6eJHGF3iOZSfWYUYjIE9CDwrLjj0lNYM?=
 =?us-ascii?Q?AeeCr4YvVMJcC1zjCOfCTPksHOL4Y8B8+VIAR1tL3PMlA+KZ4EaGYTxDrftE?=
 =?us-ascii?Q?twuAcLMzxg4Z1uLVTIjufABQG+rddnolM7JiDz84e1Bf6sRR0IEWmXFtuP1z?=
 =?us-ascii?Q?aKn7IblGajm0A6xK0t/+4qirYATqw+YcgJ1KyaOnqw9z483rU+mW1FLcI/eU?=
 =?us-ascii?Q?UH3vpGpWiMBIe56CCGdwn0Q8qkFXNESKU2irt5q0rYwp7cVMUnQDYYeAabZl?=
 =?us-ascii?Q?v/hE4s/5MAiMrqBHcgVtKal5oylJmyFPUH0oDVDtKMizHwJW8aZzdcy3OHvJ?=
 =?us-ascii?Q?H64sVfhyf+89xU78jClPbK91/i38eNqshLkyMcu/Swc8BsiHSKI23De25rKT?=
 =?us-ascii?Q?lAxtQUB4Fd2on6CrJe3TW6M03opyjitkFn60XTeu622k+cqzYAWU7YeajlVD?=
 =?us-ascii?Q?zcK4CP5doKVXJeyeenLGGx+ve3kTeFT+EqCfpQJLfQQxKqTKWJ7ffukdhm9a?=
 =?us-ascii?Q?QM5GmeWmsL6SsK0d7S+Y+5FMgEr/d6kmuU7UiceBbTMkCvxHw0FBAGxjpy11?=
 =?us-ascii?Q?IOdVHe9CUxHtJRu8ETKHBupDaJblHLAyh3Vk4iU0QwTcGnNVBQq5RzbV+li6?=
 =?us-ascii?Q?PCCoqKkAmXgHbrqCFc4pcUxPTqzLPHr/VTByp0dLLJSLDzEW6h1mELYHBePu?=
 =?us-ascii?Q?BUFn1CkkqzFSEHuls6T1KwOQBtnuGDUwoFrbPVAmOQZNXApLGfwXmU+thhux?=
 =?us-ascii?Q?5dXqxBZPiIDpGs9ZWTpZ3ds32Aj85CobhEh2KOsgPg1rSLRDdL592vGpF+YE?=
 =?us-ascii?Q?JNBKCIMTlyjwuGerS6bMEPM5aXQ3peJ/n/r3rpseZh8eR/ekI1Jc1bQiVzrl?=
 =?us-ascii?Q?hgD9RHWe2t22ZbcaHoJYhEmH6PFU7yhyktu6xPSlMefJ90nlznp/4ugIWPMH?=
 =?us-ascii?Q?wHMT+OX4Hc/7RDt4MTtcA4vx/7m4Mh1HmlcShB71WEWWGmwGihlh41j8wVU3?=
 =?us-ascii?Q?5Sq5MIRuNa2rjosn02enMULRfFNnmzMlkNKJUozqRt9fG+SjHwx/FpJiw9Xs?=
 =?us-ascii?Q?YAUow5NHhMxhXfKLnqY/WVlu7Xse9G1xD5ZM4XTRvOOqL1aL6QwBXAxSj2bZ?=
 =?us-ascii?Q?wf4XWxy03s+wcThS464MvUwK37Fn8Ga97ACHSMcZNuAue+rDNGvkx2UmaR6Y?=
 =?us-ascii?Q?g/ZMMYam+PhHTL6lbiKb2w3pURkSCuh3/ALMItNn4IuAZ8bCnZMCpRADsyMI?=
 =?us-ascii?Q?xgKZCStv3Bsdtvc4HW4EtlWMt2EVmELaYEI4TY6e31dtagEOOfKjs5zN3Efz?=
 =?us-ascii?Q?ZBY2SfKU51AHeFuImTtbRO636Khn0nHlNxdTI+8BRiZRNvXOWLuGYUISDKyf?=
 =?us-ascii?Q?bXlLiDgONp2TNucFhmzC06d9QjheezKiv7GfuNqgPKSwgM4l/tlpj5HaAU8L?=
 =?us-ascii?Q?9vqCLOhIIX9zYbkXBEhkaMheeKkQwa3DzKi6onxLsKY8nDdrYd9llPNtKv35?=
 =?us-ascii?Q?b3WNlvE0Z6C0k0kLFxavEicNUAsZ/DB6YLjiKZ8XurrxYirDnzFk9hMd7Jb7?=
 =?us-ascii?Q?cxa0Cs9zjqwPmZ6tM7Kbxv2WRd4/R+U=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6d254a-c888-452b-fdd5-08da1708d66c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 13:33:15.3178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RqxtGBnFyjCpXvq59Jmz04GbcboGBWwQdPT+QEkyq4J6jozA4Dr1vmChzsPlcDRO3W+4ZmgiTzRvyeT2AE0Wfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3579

Add a veth address to test multiple subflows.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 12287f086238..4b191a7fd12c 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -380,6 +380,10 @@ static void test_rr(void)
 		return;
 	}
=20
+	system("ip link add veth1 type veth; \
+		ip addr add 10.0.1.1/24 dev veth1; \
+		ip link set veth1 up");
+	system("ip mptcp endpoint add 10.0.1.1 subflow");
 	system("sysctl -q net.mptcp.scheduler=3Dbpf_rr");
 	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
 	client_fd =3D connect_to_mptcp_fd(server_fd, 0);
@@ -388,6 +392,8 @@ static void test_rr(void)
=20
 	close(client_fd);
 	close(server_fd);
+	system("ip mptcp endpoint flush");
+	system("ip link del veth1");
 	bpf_link__destroy(link);
 	mptcp_bpf_rr__destroy(rr_skel);
 }
--=20
2.34.1

