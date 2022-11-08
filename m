Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2048.outbound.protection.outlook.com [40.107.249.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA806ABA
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 09:09:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnIPBmSazVBrXqVZBYwPW60sFrF1LNKJTxFbAnjkydoPokb3Xe+BHXig2VD6uyC59nXiQ+JO58XvypjK6IjGvNQOJS8KqjBFhrl4KyC5EwpWFdPIKNTURua3cMDhcj1TonSLN5+z7HC5AwXTq4rfOERz0H48YRv+LaU73s/5qg0H7tPs78iLH8UsuEfwLKboP6RDg/b8CJlKkRv99ay+JnE3AKQMnVdvHRrMk0Ew9FlcpA+UPrZ9tD61yYbEW0A4scshbgI1IoFhcKii0WQviH5YR4KXyqMIfA4quNNe8wu+02sV3ccbmpTlKdt10j1E6h0bAN+jDhE1uQZdJW3nwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKrkdCE87NzU+XdrELRcXHVhJvKWasTkIYQ0i8XCnJI=;
 b=koFmIDblprT0E6M9d7qfMnr4YA493gvZXrQPJEHTxWIZ/OWAVTPbAYmf9ASQ4GPaiaSYkg+1UVDT9cibUtBMYblkLmafny8uSy+1FmFOPKXx3SnAh7pWRHIFvXmBFSKJVGKNPfffhChKgUC4hwx+rGgwWiHgfiHI4MOff5ffYnnYjctskKpmg9GFWYNGghTPJVv6O4vm5/WTOozqFqecrB/YxnST7F5FCwR+6snxwvs2YrR3w9hRI4xpg5OFbg17UHR/UGEqvb5FcX87FUvOpwqXTxeSnoBtbP0vYrS8SqlRnSkkXrIrF5JVTgM0FYkEwwKhnhF8i+TZulJ0WwqlTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKrkdCE87NzU+XdrELRcXHVhJvKWasTkIYQ0i8XCnJI=;
 b=HaCx/Td6eQezpDQ8EhtfTBv3HUOmsbrx6Iy1XR0qjCqq6/wav78PMT26xgOx9JkefOezcH6LyS7dOiKSgjQAIbnvQix0FTMmPD2a1OOzuWH6rqM+aCxc7BZetLAI3NVl+iwLKOhLJDk9PYbU/k4eXkLyPnTrMeqxD6/m2Cf4tEy8F4jZEeCxAeA4M0J9Z5479suGuUfLz38yptZC71A7I7a54QHSBhsrGYx2KAngtF4GUaA/K1oSTnvP8bS+PgYz3EMKN+BZ2CTK6kwi+0aTWvvW3VSQDE31YFhaTk83egKE4UUzvUEuxM6WM6gYY9jCf6B6oit8Ezrk810wsXvNbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7914.eurprd04.prod.outlook.com (2603:10a6:10:1f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 09:09:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 09:09:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 05/15] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Tue,  8 Nov 2022 17:08:27 +0800
Message-Id: <74da28510f4d1907757fe377f8431dbe4f00f98c.1667897099.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1667897099.git.geliang.tang@suse.com>
References: <cover.1667897099.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::13)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7914:EE_
X-MS-Office365-Filtering-Correlation-Id: fc1ddb0e-d4b8-49e9-3ad4-08dac168e3bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9PFewbSG9ntS9jEGEteoe6vMk8rA8LV7Q1caL9dsvED95p145SOSdis7XsxwN9u0yfQ2BMYLaptc0otiu76MPJTbWrRpFHXRjaj5JuDM12eoAk1OQQPAmBd6ZNhjnjGqVkqlwU3ge4R6dm0JYMtuopL3vYSC6P6KujjSdwzvwuPtJYba45TNdvjaWiMrNR0V8HBZ5/in1JXIpoa9zGOpc+yD83J6/yyUBuS2zrBowxcrWRVSCONiDvjrAOSLduhQHWcysbtywslQx2xQr31aevc6/Gid+qW7LPFBiA+qhcaK7dpFwW+t0XMohrZ2j+BJ9V1nGEnArp9nkuiSzETHPI7MEISSJlMNcpKf39HJRPO+apFJFQvXk/lZJexRk6sEcjUgbIbebSnfBt2F2jQW1O3BNA0I+SUzTpof0S0nZwQOo+ZhCfJU56N0r2H8XiQzOu0x27jYJxDsAAlwHbczMfMo1PUHv4CRgXl7YGbxD+ix6gXdzvuy3VrynduqiqGoE/Xf2dAHxSG5nq4MIjCwoEeJqiVBapOyVaUyoLMn7Jk2hx5W8IcGVrY2NAEz5mFjjwohp3bmUIfS/LD4szCF/wIRHkFVFYVuQ09nGTOlOYTyX1sZARyJFkwMsPwoz+TjhmGEdzxitlnPqlz1JQbeWjlKh9djbZHddsED1LL5YVxDlzn3M9tkq2uXVtcvsicYVKthNm125aS/NjjK70k3Q9DoyrtiSrfH1TPy/MvFzbcfk8HHOtrVrOkM9caN9t29
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199015)(66556008)(66946007)(8676002)(4326008)(66476007)(316002)(6916009)(2616005)(8936002)(186003)(86362001)(38100700002)(6486002)(5660300002)(41300700001)(6666004)(26005)(107886003)(6512007)(6506007)(2906002)(83380400001)(478600001)(44832011)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bBtz0NM0dGG8b4pYUOxuIIWfXGpp9fXVcwfAvQ2UKLF3qs6E07+1e/tNj0LW?=
 =?us-ascii?Q?2Lw9URWZ8aZBe6duldDewTbOSdFhUiA0SheIVkmIG15LxtoBHWPzSXv76BKQ?=
 =?us-ascii?Q?d6YIs1vtD2J/j06PegCwVxwo/VtEty9I9KnXpe7QOHTRbkpOWriQCo/tCzxv?=
 =?us-ascii?Q?lE+PKXJsA+jnDFpXpqkCsRvSzj7gu0HyK/Sg2qNaakng1B0hbcwXXWBjvF3J?=
 =?us-ascii?Q?5wygwZqgzq4qNvR1Kw2lEBjQrHuLZDzOLprJSalmMNH+5SukHjOYJU/r53Rd?=
 =?us-ascii?Q?UqdAj0KntL3nJKNPYFAs4gkzYWZMUZLPJt2uqwEPUxNuQ8xmB1/NKIonkg47?=
 =?us-ascii?Q?QVldNwGgNA4p67lHexvKNZab5GcMVKhiLolS6DNYEeBIOlB7eViRdl4k2AL3?=
 =?us-ascii?Q?ySjbm0W9oRPzcGXWntwOXQ0DEc1YPZFd64fm2at9DDSPVXe1O0Cr77OjLy/a?=
 =?us-ascii?Q?uHUQR1FRz09MpEIQ148krvP+Ra+5iNq+Vpfr5JYV6Ox8Y22iN1EyCfUZw1EA?=
 =?us-ascii?Q?ZUAowQa7Qc6BU2lpA4PDSsCR1DREnzl2H63iN2KQzK29OiqGWzXNcKDFzGJS?=
 =?us-ascii?Q?Pbona3X+04ysXXY0SY1Fvrml1sur4h7rjTWzFePt4dXZPirg6KdzKF65V7gf?=
 =?us-ascii?Q?0aRd88SQyq5ZeJ0yZfq1tFeyV7WcMlocVujq1tywJkrb6y6yWk65leXPQJnP?=
 =?us-ascii?Q?oySpPbBRxzJ5U/iI6bcc3oGxKBJN5BIuqqKTu0ukYXYAkRFk2Z0Cekw8Sg7w?=
 =?us-ascii?Q?FRcM9EXp1LSpEZ7DINBH9KPd7/a502ncGe+WNfwRslPMJCSy1WijPKJIercW?=
 =?us-ascii?Q?BkXMnBXQPPbIsQ0ta5gy0ABGqW1YhQiD6NCvwWiq9kt7WroK9vTWEWIidOGK?=
 =?us-ascii?Q?EGmXjnTTlaBcsq6g9Gfzl1JQbjfFEjEmI6bfV9ZWjBlaI51C9a0mmi2vpuOv?=
 =?us-ascii?Q?0NgpCRhM83/8xwpEH02zpPvnia2p9H9lk5voP9xQau0/s63rdrEA5U5KT/up?=
 =?us-ascii?Q?2KBeg8P07EU4Wl8xSEbtu1iwxfmS0uR5x8XqkaDWZArQQ3RwtAtn6KIRASTp?=
 =?us-ascii?Q?7F+5ajbYoKHxBOylZmgDSwS0jJE+TEUFW0z4YWA6Pchu8RjCxftg71dQjII9?=
 =?us-ascii?Q?d4LZuQUQQn+TmFwZT9di6LNb2BKYAZZPSvX9aJYokTIkg+BUgYluoR49BwqZ?=
 =?us-ascii?Q?7R7DOR1dtr/X81R3YzYGd0z+QpCkOqm13U2Sj8pa8oc6yQN0mRvyO18+26BG?=
 =?us-ascii?Q?LhnVzqXSLIvB5QPtji6nrfODUm905MPdtl43IQv0KG8mCOvWDWMlUJEUR4dx?=
 =?us-ascii?Q?Oc4mAaUt43342+3vKunOzHoHC+v6QO5HSKIERcxt9mk3YL5vzKZPWduOytZ5?=
 =?us-ascii?Q?X3z/Jgw0vhaOS/cEvlquLx76k2nDe2AuEkyfv7Sdz2mZACh4lardyUXjfENv?=
 =?us-ascii?Q?8rk3HT4mwYKSQ1vSQ3v2WLNAKscAuDjcxJxengcvjZJ7RJTw7jz7f7EMYXuT?=
 =?us-ascii?Q?OSmwfyTrc/iH6hDhpEaeTozB5D0JCOZG4+BCB6/swvo9RLGzzyTI9ByP2CRL?=
 =?us-ascii?Q?AL4BW40dfqIJvGwoR/WXaJbZawC3qeoREx8zn75m?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1ddb0e-d4b8-49e9-3ad4-08dac168e3bf
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 09:09:06.9160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4y0iXVaLCGvYmPYFXWeCVrHgXFWdfCQ9ZCJTDrWJ7o/Cwl8wMUkOGoGod8ptspzm5ViqC7NW//RbkX1i6M0bPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7914

Use new API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index c7d4a9a69cfc..72c618037386 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -249,8 +249,10 @@ struct mptcp_sched_ops {
 	void (*init)(const struct mptcp_sock *msk);
 	void (*release)(const struct mptcp_sock *msk);
 
-	void (*get_subflow)(const struct mptcp_sock *msk,
-			    struct mptcp_sched_data *data);
+	void (*data_init)(const struct mptcp_sock *msk,
+			  struct mptcp_sched_data *data);
+	int (*get_subflow)(const struct mptcp_sock *msk,
+			   struct mptcp_sched_data *data);
 	void *owner;
 };
 
@@ -265,5 +267,7 @@ struct mptcp_sock {
 
 extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 					bool scheduled) __ksym;
+extern void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
+					  struct mptcp_sched_data *data) __ksym;
 
 #endif
-- 
2.35.3

