Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFE57F
	for <mptcp@lists.linux.dev>; Tue, 17 May 2022 07:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652773447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P9eQpBFTOwzicOgMmDXDe/NM2AeTK2WZ1LoTnGPts4E=;
	b=liGMiGlcQY+hVwtsUjwzK/3Vk7MqBN7KBMDF2eI+y1gcBqRtVkyQO3evVIwZE2SWSKXMFN
	7iFDvh2xSJ7LlXQumZFR6s04Z/jHUt5jzwv41u/wYIVXl9nTtCHUfAr4X5O4y5hiP2PLqT
	Mao9NxNOzJDOUZSvyFvC3rO6CX/uFdE=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2057.outbound.protection.outlook.com [104.47.14.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-KOrFAO-QM-qEscIKyW07ow-1; Tue, 17 May 2022 09:44:07 +0200
X-MC-Unique: KOrFAO-QM-qEscIKyW07ow-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLrLqiW8wGZaHlAe7i7ZlvBgI7D+3R0Is1H4wpn02qNax3yqNVtvyKoFnFIjwWu4osMVEOXFVA+leeOQCcgkZdmta8TB5g2FG1xkxh/sZcT4eMRma10oiXmeLX3bqrzMW0FbP13q/bI9YnN/Y2Z8pL0tc2Iqzlhfq1eJX73HsGKg3zMM7OzaY682uFg7rxz2fgL4ZMcSpOwxcpVeP64blWlQe5HvyaX3nMJQgA3gTyLE74UwBITO7wU/noYF8V2gbiWZsQ11K8L1jr8fMFYQZb3No65eqhMJ144HbbgyvLtiM6nPtiQ360p/YrStwPQ5QcDgUoyDKu4ZszVAnloJOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzGP84AWS6LO0lvP/+47VRO9pJMpheu+inQ7jsRf158=;
 b=lL7Xci32QbPBxN5ISQJlDLBtqmA9GmMWz9p1eo55k4NvpkbSZUNXQ+b2P2pQIRt26CKmAA7yITH8bNNKY/mmK2E2QaRNR07pEfK0q63iDZMOhhWom4jLAxpaPN4APIAzTFgucv1TT9CG9nhs50ZakOa5zWUe/f4zl0nYDbD6lb88mfBaGbu26BbFSK8HEfZpDzEYpI+QW9PY0UwY+pZdxfByZeinZCchBdgcX8ykoOgz9JUdmXlJbibUPWZn1OSnOXmCTGOOb3+65C3BDnCE/ltIUd7BQx37Rst5yc9c0CGR287o9yBJJr+613uXjRREQ62nNKis44nuAKXrOQESPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2732.eurprd04.prod.outlook.com (2603:10a6:3:d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 07:44:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 07:44:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests/bpf: verify first of struct mptcp_sock"
Date: Tue, 17 May 2022 15:43:24 +0800
Message-ID: <23dab6e997d28eaa37a5504ee719ff89a93af96f.1652773311.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cc055f923d6d3014e9a0e3273e6d01c8a528bba1.1652773238.git.geliang.tang@suse.com>
References: <cc055f923d6d3014e9a0e3273e6d01c8a528bba1.1652773238.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0009.apcprd03.prod.outlook.com
 (2603:1096:202::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 090c13cb-b151-494f-7eca-08da37d90521
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2732:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB27324A58E75CABF97892ABB1F8CE9@HE1PR0402MB2732.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	epf76uzkXUlkhoD/r48g4EhELafnCoruV3mOyb2YV0PlfWYncL/PGAAB1yOuQm+m4GUS4AU8v8v5H4Y+MWgLbODrPtJVNiYZ+XRtWqtre2CpPVJ3J4ym6qnklZrYPgQsEtXEQ5qvHvWlG5d+WpY98phyNf+a733juVR1xo6CNOIgWCmjj1gLhn6pEfQlOdI+475s6YMIsQFaDMB4VzpzX7vn7UHmU2OjSTRqYfqiRK72kuPyHhGTnzDTAAZqaIAoMn45q8vTvM5jjvrjp67TET0R3g748soPhNX99fVDS9Mx4k15wFKSJBg01VfYcu2pLU0cGni3ess8i0CRGh0Eiek+wf3ZHkAoPwYmrHFazCRtEumM/jsxtBLUgAbiasRTdlD2WGvcntLqD6+fBqvQswHvmr2Gkd10f6RkH1tD/kxbeGdHnAppeGVaHAwD/D5kMKNHNNgyn7a5LFsEpanqxT6xn6L0bpPfQZ2B8gZI6CQN41e81HzQKtzgMF1zOkBInp5kmhrP6RI+LiUq4E/LIWu6C9W8C/GFyDXV0w1aiAqJQmjSNyMmV/ZPUcXWsNXrIou65iU3dNb1EbWzVKLEUZZkk1CPZuO5kd60ZKFJ9nQvT/Lz4N8nh64bXrBO5QmccXRG8DY0qLy7txEcQKc/zhHu9yVGDJkxJz9fQ4w9YCWh+OruxHTD5zui8h88wkCfDajUrXfWLfEf7o3sg8DgYw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66556008)(66476007)(4326008)(2906002)(316002)(8676002)(44832011)(6666004)(15650500001)(36756003)(6486002)(4744005)(6506007)(186003)(26005)(5660300002)(38100700002)(8936002)(508600001)(6916009)(83380400001)(2616005)(86362001)(107886003)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1DcOAeP+MBDsqzAz974Ji7JLHFK6JgRw8a3jZtrJKrTIftYSZomCxryTzi5U?=
 =?us-ascii?Q?tLkg3zqFWmUQXQ/tcjLJIrE3NlS8lGM7LSIV6kC3eGCA+RHfkAVU7x77R7+4?=
 =?us-ascii?Q?VrTI7clM7e8EBjUGYCTQs41HwiqdQzUseWLzCPaUarRgGbw/4rfHkwAio1vN?=
 =?us-ascii?Q?UDV1jDvfjLMfia0F6nJceUneqz2dP616WtFsfsgE479MnMiW9s1bYGpq4+ll?=
 =?us-ascii?Q?yX5bbRAhEv7bQgHRU9c27sXSu/T9T8GzRii9zyvMIOea49uRQh8A5HOR4Gs4?=
 =?us-ascii?Q?/cDjM1biGFqDhBKDvKThBGGv3QdFTYnPO5v8ACOqLvjqCCAa2Pyg+zQsTrFD?=
 =?us-ascii?Q?uJUe2LK3+b18ZU/eiwMV+ensmRMOgBQiybfurDCuNHJW7umK3BqHmr2TfIfd?=
 =?us-ascii?Q?bX7f8jRvyerAS5hktnuzSaDSEL6ZnjcTahRbZKHqU6Yz8k7WqNXenMy1tJ9T?=
 =?us-ascii?Q?8M/iiSE3QVEmwfta3TAa6UN58OoUi7ttfUZ9AUwASVFYbxRiXckdfNWGDWoU?=
 =?us-ascii?Q?fo6IGvF4Ktom5120U321PeJjBU6z6fFQ/Q8b2FzJSF8itXLRMCD2MVOuBHIg?=
 =?us-ascii?Q?0sfi7ltvUP88wKKaUvPJrCpIX9ShKI2I951pVMNGUG+lF8P0bvAUFpwLsZux?=
 =?us-ascii?Q?G9+/rJ+XPNv1SpNyBE5tP6WZiNswxGZoS1Im7tDd1Xur9unzHLT1s4rpzRxz?=
 =?us-ascii?Q?XGBVQVumoRoDOMnD5BBeyh9sVS25p/8BZxc25uAoRwuXcc3KrRWJTXKZYc7A?=
 =?us-ascii?Q?lpkWG1tBsVnqSFcchiJ7YaqVJl9TdQ2wd/UUyr3MJ+GKiLMdENRt7KOyYl5Y?=
 =?us-ascii?Q?kMUnJ0x89IFHIsCE2LZ7Lcv2Uc/9LV996KQOemEt76h/BYzuLh0wfD8UsN5E?=
 =?us-ascii?Q?qQ+xoAhshxtIKoElxuf8JHAicNcfEYxzWuQMnLSn36BHiUsx572Nw26EbXor?=
 =?us-ascii?Q?WntgDj5FOgkh5rXKnGjsyA10+sD7KKXKQsKF0tKLNskG7j27eXn3WTCUuS07?=
 =?us-ascii?Q?busF/95+oCECyKrRNV2nCeIzDVtmHDB4ZIRXgko+vHCPOywnzjp0v2zf4+s/?=
 =?us-ascii?Q?o/rx2Ik+vzkZ1sMiJMBNdCvDDwNxVBApAUM0JQtULGenPA9AkqOzQC7yZaTU?=
 =?us-ascii?Q?xFKPLO8G2QfEiVlH7n+KtKwtHMsU1g5TyhL5+WRbAOU6y50lOi5bFXBRcd98?=
 =?us-ascii?Q?3yNsLkUl5ydexw2DBbuRepHNtHipUtqoeWwA+0YEEbqe4u3L0Ovft6eKEHjd?=
 =?us-ascii?Q?TuIXmewVlTsGessQ1ZjekadKTAXE9lIUvN0Yo1j/Wpc3hyjJsKy/XPQuDJo3?=
 =?us-ascii?Q?s6MtHIoguZC/N1GisUPFEhFcG4VRvssz2h4TCDA8mjY/o//wDJIkEbZmjNtn?=
 =?us-ascii?Q?hrsYf7w23F5wqzFMYLY3UOmh9mxBStQjEx7jDkiy+6sXxAfjgKmX+GlxCy56?=
 =?us-ascii?Q?rH+WyQg/pIDV+UeatlJfysYVE/8LhhWwhddBT7p/kt/6Qk71DVdKMMOIlmxG?=
 =?us-ascii?Q?MSyrUvlBnROjWwJ8ZTS/8He23JLgrD4Ohruo8KvmuvtHacbfElQpE5gvMIHl?=
 =?us-ascii?Q?8ds25UGNZTcjD9OAicxw4zUA/WDi657ODaxSGw6ZLdFyTJjvM0mUyEcpWC8d?=
 =?us-ascii?Q?5K/IYDqAnwzv+pe6rK8QNIwWIGv/0trHlbXuM6oSvKREuSisNzHGoZpBmkDf?=
 =?us-ascii?Q?P9h6ZIFeytBZ6lGVIoe0mNCbrJqHW9ivNQb79zWo9eLjZvTGQUYw7VMYOmj5?=
 =?us-ascii?Q?Rmjy7BGpkxL4iE7+Gu63TEulxBI1lec=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 090c13cb-b151-494f-7eca-08da37d90521
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 07:44:06.0952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2vu9evgtrT3uM1Xk2ibk7CFJF809miEmP09C7GjjeDfsPqHxlPu7VL4nJ/Ki816cUIMYuA0dqy19YxI9UxMpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2732

Use ASSERT_EQ.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 913ece278ffa..4106e0b8e407 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -120,11 +120,8 @@ static int verify_msk(int map_fd, int client_fd)
 	if (!ASSERT_EQ(val.token, token, "unexpected token"))
 		err++;
=20
-	if (val.first !=3D val.sk) {
-		log_err("Unexpected mptcp_sock.first %p !=3D %p",
-			val.first, val.sk);
+	if (!ASSERT_EQ(val.first, val.sk, "unexpected first"))
 		err++;
-	}
=20
 	if (!ASSERT_STRNEQ(val.ca_name, ca_name, TCP_CA_NAME_MAX, "unexpected ca_=
name"))
 		err++;
--=20
2.34.1

