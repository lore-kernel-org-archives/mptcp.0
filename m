Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909B01FA0
	for <mptcp@lists.linux.dev>; Mon,  9 May 2022 15:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652108506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FyT4vd8d4FgbG8UHBfY1tYno8mNZh93Jdxr/CCjhsaQ=;
	b=KwhI7nMeBak/fbiCyaCiA+nS6PZ/FamD3hh+EnfKgj8CT4DDFkq5bj1ufKus13yEAoZ5d9
	omVQ95e7bfY8J7Hfz2CfOE6Rg0hogNo+EWu4h6OKakqfPkQVfyseEczijuyhe67eIKBzMF
	m/KntDbd2utTMfzEVJqLh+mOnrsDplo=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2059.outbound.protection.outlook.com [104.47.5.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-CkUCgqIqNKOmioQRPPfzEA-1; Mon, 09 May 2022 17:01:45 +0200
X-MC-Unique: CkUCgqIqNKOmioQRPPfzEA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIGbilEoZ9WZSKiDZnop5BBqAvsWCRoL7X2QPgBGv/gNhsD4TXx/Lao4hW9n0dq1jDsQxChZ1dOR2vTHsnrDpS7XP9yRr8s4HmYzS3QBTVvtY7DRO/w918R+q/vy28hQ13X5AUFtoCQ0g1Snvom7HFjZ94VqiH7x5TJQaROdfZHVVpXq+GpixwUdWnjbOs8Tnh99x5cowv0467mwjkC3Yorm2dlxkhEBTsOEldGllebrrfu6HUsxjsRuXvDXpnmTI9RkfABaLIvLrlN/RxBXBkKgXg1kwfVq5eZkgyNg0IENV7tFf636W3xpm0u5KpX3bUGXlgojtYTA/YEr/z1OVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgjhE9V8pRbjyUsxda7KtE0cCEZt2CWfZlfnVVFkgT0=;
 b=K1RFX3JTQWSQKIldvJOUYhKgrq5z5hYFUkJ1y2h7Wz500htjDHUfll3HYisp8ktm++spJ2u7O7ld7X4dVs5xSLqIRZ113DHrmzCoGdrnkNM8hlOxcNWCBOC29YNFHSxTVsRH2UGBW8pnIw9U3z+1mjtXmug+JwkCcbUWBjPKomYIAd+p/NZmGPugtNvhKL1j+2WCSUvsS6XIxrIU1PbK1WTgf66h/umUs1gx+NiHeJoy/WHXkuGRGU5IR1EzOBOtfFLtkfsXaac0D38aBjATTGZplnQZwX8+0VpN/rkzfkMCohU0kF8CAwAKJCeS+al8w2rxf/WrObgTXXgMGtNJPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7000.eurprd04.prod.outlook.com (2603:10a6:20b:104::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Mon, 9 May
 2022 15:01:44 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5227.022; Mon, 9 May 2022
 15:01:44 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 4/4] selftests/bpf: add bpf_red test
Date: Mon,  9 May 2022 23:01:10 +0800
Message-ID: <8a186af1c7c19fe4cdfe3eb768be7bdf498a346a.1652108279.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652108279.git.geliang.tang@suse.com>
References: <cover.1652108279.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0213.apcprd02.prod.outlook.com
 (2603:1096:201:20::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a177904e-b76f-4818-2d90-08da31ccd4f0
X-MS-TrafficTypeDiagnostic: AM7PR04MB7000:EE_
X-Microsoft-Antispam-PRVS:
	<AM7PR04MB7000E3254D8EFCBE48B1383AF8C69@AM7PR04MB7000.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sj5VBY8Z4gesLE8p6wmucg1lDon8vCWauEXjf/vNgGh9hoFIlbPMvtBshY1hCM+JWR0HuxjXO7A5HZy/vEO26d4sz8HatNIthsFE+cYlFQFyszNKiWNRHcduLQUYH+XozOCCrpedhGIE1A+XGfYaRVas6FWTB/Hx+5SwOWv2MkD0E1pn69Vuv24VbX9SU5jqI/1SDlV+DBNcMqt5H8ZX0pr1F5HOXKVxcgRhVD7izLGOCak5FcERiaE7J+KmV6Vn+mVPanMy81XQYk3z6L2eWdhw7joDyFMc8Q90WVTo/bC2orYmQ323bhUyRIBMUhOcpy9YtU9fnKMUFcqATR592qkMijR+LRAhGfFrEP20sZIz4IQ85CxN/TgFLrmZtYwYB98OarzHbtsn+QzXBeSafG7IKOA6IpvoWD9FNcJ65hTYKqWuMNrtir3BZBBTKLD3re9zTjYOeUrh9onaKoomU5FvfPk85QGNE/SV4lBLwPKGqddGwLBkawa/ow4gZMp4Ag5xkprJLnPXFFV59fCupNRPn0v1/hkTvFhqu0PBaS1UTCLEo4hVzZ3SriNJgaEhy6lI9dKgi2+ZEmxYr6R0IPg4jdcS7wC7XJ3xy/qqvDF+Hd657epubCTy6F2t4Nu1yQ5+Cmh8uiPBS0FoOwBZgiVXUxb1EZURVFZmPJtzgDBh8+cXUP8o93vLlY7/0HaN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(4326008)(8676002)(316002)(66556008)(66946007)(83380400001)(66476007)(86362001)(8936002)(508600001)(44832011)(5660300002)(107886003)(2616005)(26005)(6666004)(186003)(6512007)(2906002)(6486002)(36756003)(38100700002)(6916009)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fDpbYpPzTzdbw9kpHoNzqrLrmnurz+oEoyDaeI4PYqiNk6a8j9+rV35Ct9Qe?=
 =?us-ascii?Q?eP2VGx/Hkw5UvAxliocejRTPN+2OoXf1ktyPO2K9uscdIIrx5iNaeK90cHxr?=
 =?us-ascii?Q?hp0lXHRrzMTnYAxbSv8o9eHnuZHwzf1ZadsuDVNMX02aFb0GR3AfWLoYkBp6?=
 =?us-ascii?Q?qQ7tm1333LVuVH06kHhaPSqsuqTFixSERqFdsYAHKJVpKKzhYdrn2YR3maN8?=
 =?us-ascii?Q?7eiJvSwnDDc63wwLN29NcAGNzCAK6jRRU0ClITycON3joztQ7fSCBKzs4lvj?=
 =?us-ascii?Q?yXl95KOlHBeLvxiTMJVecv8/LbQmTpaKuw4cro2aC0us65lkzF28p85Dnfb0?=
 =?us-ascii?Q?hu+vCT2u3oxn8yOk5Q158KPwAVL6AQxqRA9LcU/5q5tkxDDx6xo9xfE+49mi?=
 =?us-ascii?Q?RAmeGcWj4PFTCo7B/U1W1mGFv5Iwvzbk2P9+nmiWrip/LORGw5CokI8+fZCm?=
 =?us-ascii?Q?kXiaMiRu2KJ9VNXdsO19/WtdgVAMJy82FumU3Fn7jVszFI+cl/3jhuUfliKQ?=
 =?us-ascii?Q?9KHhrv35y4kpXuDG5iYuLPBUsUfS/8JUAm44BWcit9GAQrjvl4POsGTqoUu1?=
 =?us-ascii?Q?LAlxMyCOKnlGb3DSos7XR1Xz5wC1W4rDDM2Wu0QvOrhvonGR/lta8C8it1WF?=
 =?us-ascii?Q?Zee7DK4kPFnU84KCtCN+9LBN42wQFzjpqyWf+NzHPIcMsKLGX/4xQClv36yJ?=
 =?us-ascii?Q?OuMkom+2pX3PXp0suMaE4fjBbliDd1vNptPFAC+HAMrZO2UUKjkKmLjKE2DM?=
 =?us-ascii?Q?0Igqg7P8raHweXPfwJWVTRs6d+m7/d2EKt5Liv8gEJQkXMPmqtE2l7fkFtun?=
 =?us-ascii?Q?jS1fGmxq3SJXP/YVtVVpv+cCqFtkzPNBXkphAUzwWYqwBcCc/d4aREGqdg5g?=
 =?us-ascii?Q?IjWejfaGwOUq5NUklBH4hFq4rxbPceUzD61Rbzh40CNPuyxhN04RD4LxAXWM?=
 =?us-ascii?Q?MutidUrsYs2+NtNLvT4HSxCyZbWE3n25uDZszNpFjGaPAJbYNJSv8Mrzry2+?=
 =?us-ascii?Q?Uws2HISFMmion98A1GlYToWXVzwZg/zOf73nxfUhQpLGxqQ60mO/LSzxBA8b?=
 =?us-ascii?Q?ZZZqqXPs4DTpgih21NDN0/43WPjpCcZExYHuUd3cA+6fN9GVKH9DUbtFEv1R?=
 =?us-ascii?Q?H4oFdF95Qvd6GQQTF1JkO0QLBJr71OWFEsq0tbGZHeaiTxL09qnul1ywqnwQ?=
 =?us-ascii?Q?qJSlVp7ycKdbDJcPgWlBHNGopMAmEIIwaEnJDp3Gvw/MTvjsOvIYaKNhLqIE?=
 =?us-ascii?Q?9VOKD3hdzZEsx3Fse72j3E/bnXv7jGIWYXMCXoXk54EBlyaPmofN2dzDDOEu?=
 =?us-ascii?Q?Tt/pfmoOLFTQNRpobJ0fqkLo3PFrEpB/FJlcHwl/OaVwGiBEI/m4NqjlsP51?=
 =?us-ascii?Q?FLUq5+xSRJp+9AtjMGs7fhhFIeBr9F/0JFZCcxfmGUrojxDsNyeLFoGh862i?=
 =?us-ascii?Q?vGtz/csV6PwF+cHkoCuENQpR8Vyd5T/dqVym6SrSRAPJwPI0t6minUKeDIJe?=
 =?us-ascii?Q?sSZJv/jGl4MI7boBKtqcLvn19FvhhUaNOyhPcif7bfIa+c2dMu1/qX4tFSMW?=
 =?us-ascii?Q?/y+LMjrLmjDum16yDtlCzgLGkY86dj6Qs678snanCKqV4bWX5zBqzT6VQfcW?=
 =?us-ascii?Q?ZAr1LajfGynFdyfN+I/NzIMkWszLEs2YpgArS63JnrJ4+FkNvfm3Mi5td5BD?=
 =?us-ascii?Q?dcdVQSNQRIbbeQAdYzlfeNujmeCuim5R5NXDgWoDclgLaqprHGrPnNqZdl/T?=
 =?us-ascii?Q?9jmkZg21mly2WYrToWlbVkdttGA2WEo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a177904e-b76f-4818-2d90-08da31ccd4f0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 15:01:44.4914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfWpO2x2y5ijN84DGdbIJCqfTwZ4I9f7vIHJmXkCsd+POwhfNhOacfbo6njynG17HLSYC2oZeiaWnM9366BDYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7000

This patch adds the redundant BPF MPTCP scheduler test. Use sysctl to
set net.mptcp.scheduler to use this sched.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 5058daf15ce5..7dd36e92c0b1 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -7,6 +7,7 @@
 #include "network_helpers.h"
 #include "mptcp_bpf_first.skel.h"
 #include "mptcp_bpf_rr.skel.h"
+#include "mptcp_bpf_red.skel.h"
=20
 #ifndef TCP_CA_NAME_MAX
 #define TCP_CA_NAME_MAX	16
@@ -401,6 +402,41 @@ static void test_rr(void)
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
+	system("ip link add veth1 type veth");
+	system("ip addr add 10.0.1.1/24 dev veth1");
+	system("ip link set veth1 up");
+	system("ip mptcp endpoint add 10.0.1.1 subflow");
+	system("sysctl -qw net.mptcp.scheduler=3Dbpf_red");
+	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	client_fd =3D connect_to_mptcp_fd(server_fd, 0);
+
+	send_data(server_fd, client_fd);
+
+	close(client_fd);
+	close(server_fd);
+	system("sysctl -qw net.mptcp.scheduler=3Ddefault");
+	system("ip mptcp endpoint flush");
+	system("ip link del veth1");
+	bpf_link__destroy(link);
+	mptcp_bpf_red__destroy(red_skel);
+}
+
 void test_mptcp(void)
 {
 	if (test__start_subtest("base"))
@@ -409,4 +445,6 @@ void test_mptcp(void)
 		test_first();
 	if (test__start_subtest("rr"))
 		test_rr();
+	if (test__start_subtest("red"))
+		test_red();
 }
--=20
2.34.1

