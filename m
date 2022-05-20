Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0457E
	for <mptcp@lists.linux.dev>; Fri, 20 May 2022 08:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653033944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C7Zp5XiahT2IIX4KKy411lOUGph3lY9ODy5GSWTeI28=;
	b=d5Z1yy+/lORmJ0BSTIMR3UbnG469XXF5js6EC+0hHdrsvBqdXawQtA5kmdGn0oQxHq7Kdq
	83ImEG08ar5uSB1YZVSvSXzvc+9A3uHugVcjyz/DV8xK+ZjD8RRldYdv2Gk3IqyOMZ2W3E
	rxkazcEp9a/p26SW7VtqW6yvf2wG9Jo=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2056.outbound.protection.outlook.com [104.47.12.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-D6t83HBJMIWFCMcCgKjVzA-1; Fri, 20 May 2022 10:05:43 +0200
X-MC-Unique: D6t83HBJMIWFCMcCgKjVzA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzCGXFrQ+jAS98ZMbxy4TaG2IMtCC1ftRxhb5Vb/Iyym33+wiR6Q0Df+2U7fALnIpMC21SNXP51e5OWqiCrbRDA/Pv2WtrrmMWZFdkQIl0oazC+DY5R3l+dsAQHQlRhrgUhg82A55Bd0zwFgr9MhpFpeQGzubFnF9a0lCQr0H+PWHku52jdqOR7oGHWPlQVXDlCrd6/Ru+bwcqdItwKtv1As5BZU0LWyMvbVCzrbWITZDE0s5xSCo6AJjc9eq4p98sGfwmALZ0VUZu56rIKaQBbu7NIgmAZ4N3f2+SZHFSoUcFpn1OshOrb8KortRFGAunMosoLNx+88FHa7bkzusA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+W2PmkoiLIgVsCdWtj3EccX/I63gpI4tu4C2IwsV/8=;
 b=I0MB5jHuHI1MlCfA87SqvxMgJ7GyXvQ1NDu6MIBX0xFOtHeIyFTTUo79L/kwFAJQtgBoCXmYZmU76vVGKSiQKmVjplcfi9b1/cXjvutimZjlxNLZ2fhkeldOO5GaEfNL6XPvnvYP4M0DeKwT+g3pPfLTvyMt09UGyCLM/acLIhctA8ZUKCgRblmXL0WjpdD9TzYPDrlWw7hhrgPa+HPsoi1zCI6APO/3wbMFjPJ4117xt/8tsxbZzMUouSN2NDBbOLmtVHPOIG/IJZt7DF/SZK8HDqrpUpDpG5vk2Bce5VQr1tTiAsYvi2JYr70w1wPLNGj2ry+BlZFmHtUs/CSBAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9149.eurprd04.prod.outlook.com (2603:10a6:150:24::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Fri, 20 May
 2022 08:05:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 08:05:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 06/10] Squash to "selftests/bpf: add bpf_first scheduler"
Date: Fri, 20 May 2022 16:04:51 +0800
Message-ID: <0e823b492d7c6d4cbb736a88e0c72333d13ccfd2.1653033459.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653033459.git.geliang.tang@suse.com>
References: <cover.1653033459.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:202:2e::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2dbe485-c11b-4d75-7d2a-08da3a3788e0
X-MS-TrafficTypeDiagnostic: GV1PR04MB9149:EE_
X-Microsoft-Antispam-PRVS:
	<GV1PR04MB9149671D2AA720356E940CE4F8D39@GV1PR04MB9149.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fdpcJ4OU8EkbZGA3nDH8fcqxkL/Su5fuHtJfyVUft5G2zcS5tfTJODQ9+B/n3NSRXHQxjOHenTBzpdz3LKGVfePGnIfqwgqsvMkkWzFBiML2rGy/oqXdfXS0H8fbx6+bhOKpgsk1YCI1grlk9eB1Jeb94dL7EGM/7DRT1ehtQW4fhCO/5EsBTrDqXYbVrztcOpJSNzVvzWjT5HwKCUz32aMduuyhF6i/f3sFX96oP5odN3vavnNV8ME1aOwoGuuNtBvpWWF21pqjNxRS/LtvR2YMfVaK+yUG88h/sjub5gyMTo552OF5TBeI8ciYwlWxK74SbJxoqmqEmursbYm7bmSZex+0L7l7uJ+9SpTP7wOsRLfrDBb0Kk2h4JVw0wXh3KKE+AD94oAHn/hQJl808k8VWThGGTGWKoIGKhuipINquDkyRHOU9p5Hr/EB4PC9Hvw3U8iKFJlp3JzMUdyEXIAw5HsWxoUit4KdN9MuKHBoQWsqGZ0y3qmeIj1l6a9EThrYosE7srH4nf1/aMdmiKg71v4QHghowmI4OVySOnAjAgonbpwKairzfokBcw7kg5E3i5Dp18aII+PNvfmG+x3Gst2w301R4ns46Dlb8nEejv43Z3XCahmlJ1BMkOXNMD9GOF+5aaBnb4HON9ikBoJHjh9kVFgLldxVU6Zb5gowUFMELK4TWvdKc+TgawxzndVfmqe4Nr0A90Nzf8bubQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(2906002)(6666004)(6916009)(36756003)(508600001)(38100700002)(8676002)(66556008)(6486002)(6506007)(8936002)(316002)(44832011)(26005)(5660300002)(107886003)(2616005)(4326008)(66476007)(86362001)(83380400001)(186003)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YgcxpDvMLqO/sYQz6Xp9QW65X1b+3nteenU9dIUtQxVvFw6Lufq3IxbGuKmR?=
 =?us-ascii?Q?X3ag6IFsMPGM1wDa1qSSv1I3Yb9zb3kiDGHoVyEIj4uAGh48MflnfOwcqlvm?=
 =?us-ascii?Q?vUkBV4TfBjcD6Oc0SFPkczMXr85flYxj4jWXmwS7GCCd9rBcXSiDQsh75dwL?=
 =?us-ascii?Q?aTNSFQmE8eoZV7jEPZ6l6RhJiE8SN5fq3TcUZLfh50QXUH2AFW4jW+idgjNl?=
 =?us-ascii?Q?r2HYcafIJ0T6xsS1OzmoVlCG2uUKn5ZgWmAbvk5doi9gPXv4HLyVQDuLPpRp?=
 =?us-ascii?Q?2REg4kquFQlGXQlGlJnNJW7oFGtBxZ/T2MlBS65/hwm0MBgLrPE+6OJoLz8B?=
 =?us-ascii?Q?8D/zDQpy3GgSHM3jfBTz/SI86UVVf4AfCu/rBK/kUr5zcBmgf4541ODcrBGI?=
 =?us-ascii?Q?fjmwccBpRFx4ALYXwiI7m6ACX9LnfqUsavrrde3qfmDc47T+qLtezN2CU+4U?=
 =?us-ascii?Q?lyKb7aZK4Oj7Q8bpFQd2d7EwZPKdNxXllzJdvsknacvj0gqGqXTIjUloLdDY?=
 =?us-ascii?Q?sLarPBP1WFEY92+ceXbaI26FNLfxvyoQQaLDWq9fBumrNCsEB2S2wXqOjkya?=
 =?us-ascii?Q?QYoG0XHLC36ekAxtdXxjDMGgrqBebYimRuP/z/iKJscEaz9vzrAQHHHKCs3R?=
 =?us-ascii?Q?XH2MHRfO+CAUA5T9sTTUWd4BRfNPuXWF2MdMK9aAT9sbu/ykVDbcAnFgqwQ8?=
 =?us-ascii?Q?hDYipeQpkl1vOet7y50OfTPOSrdpXuwkPFH+w3JmKIgV/ckcvrC0bU0n6equ?=
 =?us-ascii?Q?YCmNDNtHgp59+JWwQcpRohrwmQEhefXOu0PH6zxwD7rldP5m5cwGX0tq/TGs?=
 =?us-ascii?Q?oQ9BmD+sGmLaBido2AS8rYp4HlVXad2qjn/6X2pbxBe4wIi21R/tYOjXoG82?=
 =?us-ascii?Q?Na0XX25AIn3wIjamjHS3euseJPVDwn9MeCKPecnk6ogqfIvZrfY2iKh53YvB?=
 =?us-ascii?Q?fVE4FSAP95McBDwi5cfhzJK2S7s52RTLQJiPWf92nDlp86AXO7F9uHqtZkcj?=
 =?us-ascii?Q?tLpdZf4t36O+gB7rQB1hgXAwrjtI5u9AO2CfRM8fEA8P9c7GqhF637CWr61Y?=
 =?us-ascii?Q?cn+LLeyuAAerOzMIQdUl8BGmH9p1RT3tYTvqRLmgguw8AVPvS6RMziH+081R?=
 =?us-ascii?Q?Kh9NNC/l7HGJmJokFwRbpwhyu7hlA3nyOP+dhJRzKx6MZR7m2CKqZxR2tC5s?=
 =?us-ascii?Q?+GGAW3+Gh4eiG8/fba1jdJe6umC7o6uhEd/vp1vyh5VQiODgCkxQ32ec88Z/?=
 =?us-ascii?Q?PZZReG72tYsyx4EdXyvwFolLGFmUD+GElmCRmt/rPArkoW+TesDJpcxsRMzx?=
 =?us-ascii?Q?wpDRpsV7EkiSiBim1FB0ouAzEz0XFbINhYtESY6ZK6U28PwK+oCArLYVNoso?=
 =?us-ascii?Q?IBRsJci27zBvKrLhLexfTSL164JNl+ZlBVjOaBPqpb2g/UP3uhQ4aiD5cAs+?=
 =?us-ascii?Q?TCvrT+h/lQ+2VktunR8UeJKYt9Iqdb6kPr7m0aFMlQAIb+C5mpD/Wr9vEL3o?=
 =?us-ascii?Q?TXKpRwdAGfy2YjkcAU/b25mL/5EW07F+NvXhzK8QT6bxG9Txpkt3k5PGbhfp?=
 =?us-ascii?Q?8HtsabsNxPW0hDeRkFyLdr6IeiX8orQDSShvzYWQUyx0eaqsTUnmWLR/F0Kr?=
 =?us-ascii?Q?TPAip6fUpZmw69ATLvp6WbknTB4LRC3FDArGTM0DHpe8ltDGWLmpmP5yMQV5?=
 =?us-ascii?Q?beeVkGYw4mVk0MOFE286XMtEfnKr1flmBpwgtzi6BoJf3AbimsyDRggDignj?=
 =?us-ascii?Q?GeKXSFmwv3emgvvZ4uGW1KH72Oc89Q0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2dbe485-c11b-4d75-7d2a-08da3a3788e0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 08:05:42.4121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9LpPpor4plYFr92+Wx9A9vnO+RubFBXqu0sVRbEltUOvm/lFNFZtDzK2eT8A3QUrkiUoSS86SldIuNxlQRv2Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9149

Add set_bit().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h       | 11 +++++++++++
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c |  6 ++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 4c7192cb6134..97407c02dc48 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -263,4 +263,15 @@ struct mptcp_sock {
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
+#define _AC(X,Y)	(X##Y)
+#define UL(x)		(_AC(x, UL))
+
+static inline void set_bit(unsigned int nr, volatile unsigned long *addr)
+{
+        unsigned long *p =3D ((unsigned long *)addr) + (nr / sizeof(unsign=
ed long));
+        unsigned long mask =3D UL(1) << (nr % sizeof(unsigned long));
+
+        *p  |=3D mask;
+}
+
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/te=
sting/selftests/bpf/progs/mptcp_bpf_first.c
index fd67b5f42964..5a938249dfdd 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -19,8 +19,10 @@ void BPF_PROG(mptcp_sched_first_release, const struct mp=
tcp_sock *msk)
 void BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
 		    bool reinject, struct mptcp_sched_data *data)
 {
-	data->sock =3D msk->first;
-	data->call_again =3D 0;
+	unsigned long bitmap =3D 0;
+
+	set_bit(0, &bitmap);
+	data->bitmap =3D bitmap;
 }
=20
 SEC(".struct_ops")
--=20
2.34.1

