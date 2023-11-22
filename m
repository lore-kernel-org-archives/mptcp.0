Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231DA3FB06
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Bw+1GF7y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6EvWEDccBAIKtvdjRtRrKRDirUvH0OWD8scFvOopEIIWziFWGV5LadJFGinTboMKUZkT3GNOS6vRR+tyrYKqG7678yXNup0p9VTclRx58PhfmXNZLD0FZgnAAGpZKNHLJ6YdDi6cL6ZN1sbnTiVJc+WusvJBc/MMLfPDHxOZcoaxXMxnVubMLrF3ZOy3ILMf1NFr87GzkTf3VbeIB6A/x2Sp0j530uZ6zOMGep/+KpCwoAVU2toadvJwbaT49mNcL7J5ME3ez2vm+5e0SKT8TUwH6PPMv3rFk+MnuRJs01yr0D/b3OnAOa7aylU8ZeeY1xg84E4f1+60RP/sdd/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnrbHek0IzYTAneu92fpPXnq2J8mQLj2jvDJNMUCwJE=;
 b=DjzhnPqLDHQ9Rxfme7FAo0m6vKFybD0jqq3McP/JmKA505gxIoicJAT2AVUfZb8QRCi0DkO2xYX70u4WNZbV8i4WQTqEIjmor/21/neFpMCUhL90gVHc+rI2CTDorBmeBiEAwXN6zL/Xzx3g6cxKk+1ufX3lBlFogcM8oXOUNOuEIawNtGY3dXzHUZcL2ih3gXBQk4NYMsV4EJp3gfoIMHkd9WrFYUWMky3OTYFvqT3Yc7/PZkmOh7oL/Mw+E2qNWQceKy/CZLL9Gb2rxzNcvIhj0CRHgh9dIJP55CX8SLwMAJemXheTd0Qak5ebgD3NJEJdljZNsM9pJhKyU1l/Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnrbHek0IzYTAneu92fpPXnq2J8mQLj2jvDJNMUCwJE=;
 b=Bw+1GF7yw3DOFAIiY5OPItwEn0k4PEoHJsPdcgB6TJ+VYZ3U84NNtvsfdlLq53D9JGOh0w1vFHNwuvr6gP+Tx/ZH4kSSr49piYoSatEudbBNCoXy/Olst2DPbuv9DvGV0VgrOfUuRamfHglKEC6fTPxHL9XO2Y2DygvVSp5ea0NgiS40svS/d9s26lXskYDkFZclHXnmIyYoZ/0c14HbElE4N8gisEGMx1yQOnDl+ladX4xQtnNU+qn23fJwS43Sa+7UD86IxxPF42xlk8CcStadfo0s3STI7kH7ORIvoCXkmWMAOlpAozUceiSUodaLHXLZtDiRzgCjH0ybsCNdyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8858.eurprd04.prod.outlook.com (2603:10a6:20b:409::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 11:34:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 11:34:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 26/33] selftests: mptcp: simult flows: define missing vars
Date: Wed, 22 Nov 2023 19:31:14 +0800
Message-Id: <3746b16095842327de5f84273f70a08c4f25c002.1700652422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700652422.git.geliang.tang@suse.com>
References: <cover.1700652422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0252.apcprd06.prod.outlook.com
 (2603:1096:4:ac::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: 772b3973-d903-401d-48ed-08dbeb4ef35e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A9280O8oF8UCep9R5v2xQURxpsy5Kpf5UQxJCz5YXKa3z8ug3AkS6KTe7IPGuwNEcvr8zCZ8bgcx6HzH3i4+QR7G33RC9wJBqMjzjVZa+AGjEIpQW2SuS1E/0gXOAaKca5qCQaQ/tSUH5n07AFwTiTXFiVH61KiCRC3FIQWuP00QIlhbaswxWzIw5jWwKgWJTdWmi+Yw0p+FTNEecGVWjW8TOxtvnKkcaoT1paHyuQ0PDdgjGhgo5D43CzpoyM0E/45MeRNYuxBakpM6tUP5+m4LNGqjlu6BeBBYW+xRD9Ij5WytyVuHnBTFI21SkCDa5JmIycx0AQhc4aoLJ3f0JIo7VIRC5Ymhfgs7CVoFEkrWSQVeFzuZ7bqoR7ubKQfAF+b5lrjixTIosifJoJGm9R6MWrji9vl6peyWQA0FtGtXK9uoruBQs6kEE0ltmEIhY7RZ+TuQZMRTFVwAmRlO09t48a/rHKMGLSIrwn+oxQXsS+46BHG6vauReoHJwXbFzDYKgVkXLTGjYQJE81v2llB5kOwyf8IEYQ+XuQcvi/zhalTGUHBYudHYFAO4YyZa9xa1y1JKc4+X0N5IHEZ8AZHLvfOXf5gEtNYKqLaOzPw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(5660300002)(36756003)(8936002)(44832011)(8676002)(478600001)(6486002)(86362001)(4326008)(6512007)(316002)(6916009)(66476007)(66946007)(66556008)(4744005)(41300700001)(38100700002)(2906002)(26005)(2616005)(107886003)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p1EBr4fJjY1WuXIaBnPXHaMsMJCizPpOOnJ3Mt0XrYbcimld73TG+J11V3P6?=
 =?us-ascii?Q?0NKU1UOOQIdhBBurMlVwr/VC0+GCXVTccs2Pm8pmVeiREIhmZYdOhUePqQgv?=
 =?us-ascii?Q?O3nMPE6gc0Upg1y1E95OHbmuA0IJ5qivcazLcDDB2nTm4NWhpb1SlggYj8UH?=
 =?us-ascii?Q?HpK7sQ//vare1W3JGv5Y2WjmRm+5Yp2m3DZ2JAYGj1BTInBEKkF5fRzUwuTJ?=
 =?us-ascii?Q?gPAU+uSlb9VJNEEHhrtG0gDLI+GKolVbWpZhtWWv6o3/1UIqgUP9fUDWB8OP?=
 =?us-ascii?Q?cVPxCYlbPJ2bhaqha3ImcrBNG+H74CkvDj/2VvT5rNvQsDuqatTCtK9ynaby?=
 =?us-ascii?Q?ZG03URqowhT+flkAEE5Ub8hHnCgRKt7fnlaEPtmkC5DqUVULgTDAK4o3Hu6x?=
 =?us-ascii?Q?LvRKc5NXfi57FBQfevnwxT2LTMv6WoYzvHVuAIyqimw87GeI/p5tAAu6+eZQ?=
 =?us-ascii?Q?UJ1IiUiZOL6uUqEGzRZKgn9u9t+/o8nn6TPuvBNhCR/BYZW4grlke51JYXI6?=
 =?us-ascii?Q?vn0PXAMUaYHgT4gU3W97hzrf8Qj8A8kL1BpjfvAX2wYyg9ojMgF18iqR9Kix?=
 =?us-ascii?Q?40G1JR2SOjiKo4GGjRjBQPqvKtoJ6gmekwFHzxG9uOg2fZhQvNxPOGaRQB2Q?=
 =?us-ascii?Q?f5DF82Skvs6EISkxCFShbdjyFgiLmEWk7Zp/eSt4wMKK9z3nsvfzRs2To9W+?=
 =?us-ascii?Q?sl/WBJVQ16g7FHdJ0fxX/YEitT8Xo/Ik/NMAkb2KemsPcsuvn2Suj/OsbyvE?=
 =?us-ascii?Q?P29tFf3yq8X2uB+1ZiCMRyeAZajFrlOx4lhsKxIm2SkGx+ISbTDyMRpBsGWz?=
 =?us-ascii?Q?Dqz+EClWHjOME4VQpoD4wlRRAfjH4AWbmOtSf2LalYz7shuIBut094Jw0y2R?=
 =?us-ascii?Q?SkHzcgRV4JBRSMT+4+cjQaxtybXdz2ZI/7LaH649n3OevJRr0m7nC7Mqp7ou?=
 =?us-ascii?Q?m/+EHqL3z8ycU0zlOGeHMfVLVKqDrzYDPyVZ3YCXfcg7cFGAyUC29Fr2CXb2?=
 =?us-ascii?Q?XwrYP8s3DhytqqmgXD2S0yrgaxCl/wDM/4nRMg/9CdEWp0va6REthu6i4hSJ?=
 =?us-ascii?Q?VQJkszR9wdU0fGdBtvEQDw2uTgY5M+m6yTbiTQi5RHtGOYvaYRuxCTsuayDB?=
 =?us-ascii?Q?HCJmsU/U8mYZvHife4HBG5dp6z2WZLEhuMjGv9d0BolO0t9FWPMstm9lZJ87?=
 =?us-ascii?Q?FwLsq8SPos6lm2WdtjhsIQ9KqMaTHiw9/y4hzpUMaob8GLnWJgrNdb8onVM/?=
 =?us-ascii?Q?u2MdyCBYk+ovo7MH14uQV92e69Qj/5BDQV8FgV6WAVdHAwy3Hp8/OrvMSNQO?=
 =?us-ascii?Q?SkiQUZE0ldhx1/e9vkfHpy0/TYC1BoMBGJpqpSDjj3G8zD/cpzwn9KVqekro?=
 =?us-ascii?Q?ANuuqj8HJOAJgtwVSRl2avDMBh2c5KeO3c19AMdBX2BgXB6e+c82DvwxUGfd?=
 =?us-ascii?Q?mrLWPO+aFvYlLKxYLXvS02w5YYtsG6QWGxQ0ZXpiZlhsEfFK9Ozpy+ztkha9?=
 =?us-ascii?Q?cmVCOOoRBxOH1g16apiHQ2LGp4NMyHMSUFmV5/7YG3HAJ8MZiKQTauSmHn58?=
 =?us-ascii?Q?bdJyolblmQIfCU/CYctTJKF5Icvv7LcQ6SJA7fn/oghI06ZcpTDKpqsoc7+1?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 772b3973-d903-401d-48ed-08dbeb4ef35e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 11:34:12.7184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ji40Sb0Fr42w/YgWK0kekNifnVFFtKjJIwxXsPyZqQ+VrzIYdx/OPM5fV+zIH9DgvZ03z5G3cMsBK8FLm1FNyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8858

The variables 'large', 'small', 'sout', 'cout', 'capout' and 'size' are
used in multiple functions, so they should be defined as global variables.
This patch redefines them at the beginning of simult_flows.sh.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index e1f4ddf04bc3..a85c9ff21e54 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -10,6 +10,12 @@ timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 bail=0
 slack=50
+large=""
+small=""
+sout=""
+cout=""
+capout=""
+size=0
 
 usage() {
 	echo "Usage: $0 [ -b ] [ -c ] [ -d ]"
-- 
2.35.3

