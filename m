Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70048.outbound.protection.outlook.com [40.107.7.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F62E33D6
	for <mptcp@lists.linux.dev>; Fri, 30 Sep 2022 14:17:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jt6hhG628jEyz/0NNj0AuueWw//WPzX+6vPAtvna08JOM4Yl2GikqwFmSTOl5jlNwhC7vzaKnCgut9ssT3enTOeLDKI6ZtPKrWYTaDbWKyyFfFDAn9v1W4I3EKBxGVHQ3uEi3Btd/1Tvh+GQuNfCRY8Ywo+CeN18Nz06OwpyUIhqrKXpq7hL8r5POYEELYfrS4qpDpnLLWf82AgTJMP7beD/Cfw8sbFz6GBfsKKvDI5gkqsSK/0XiLx6Q0tbJGeHq6GDEeftASRa5R0Q0VoBpYoDg0oT2YtJBE7e/0NV6viWzfRxK5Rw16yCKvZKIPs1GduTe13jN5EbQ5JgYKuqfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWWq+rR/vONQ0GE4Ypg3G1pEUUoF2bzwk5+XneNP5/4=;
 b=K3R00JyLkXud3AoqCpESkTiV3xX+kwyThaM5PXomCr4s5vWSfaii2UosrKxfx7hqnv/szYrqkBbvylVnM/BH1S9KpoGAQ0KTLGZE30DB259BgQLnWcflSYjue+iJicd2FVzw20DsXPg2T6yfpbNIWkGXH3K59q4VV4mfL3MPYVtR2PksPUFY6eau41NoAp1FJJZmYU1azJpRQncdty1IkBRJ/bNy71QmHHMDU1YSYhJv2EGyFlBpENgixXSHQF1KSEhwfzY6hMXXaLFnvk7NL5vt94nbx5ShefF02fAlQ9sYUbIbSIJtuuN4vBVRTuDzxnNTrM3Hl9DCJjMSWh3Jew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWWq+rR/vONQ0GE4Ypg3G1pEUUoF2bzwk5+XneNP5/4=;
 b=ZGq9SnXzA/c8C5pFHEmpJxliQj/a2xcPGp4Z6EtMJsBW+wQ4lHLCq18uRncZtP+e0lPfbbaOUDfB+UKmJM4UcQCwK6kRNsjbuABi9j9+jBX7WFH6yS8DVpZZvXZQzLkEQzvILE6ChQf9BHdS/cn2Cc1fLWhnidu4nHNDTD1c2N38On1iSeA0CL/ggqNGsWVj/+AoCN5gPFhim5S5ZWoec7ymjmJ1LF9XiTkaPQv2nHZZTqcw8xuRlv9MDFefPyyckX6ucKhoe4BQfx8HmnTkLUkTYWV3/8gVf7D82xFVdffhq7l4f0ZffNp/pET44OVICqL+ilI2JnO9X4ZrO7DMyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7882.eurprd04.prod.outlook.com (2603:10a6:10:1e7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Fri, 30 Sep
 2022 14:16:56 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e936:9fd1:22e7:97d1%5]) with mapi id 15.20.5676.020; Fri, 30 Sep 2022
 14:16:56 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 0/5] refactor push pending
Date: Fri, 30 Sep 2022 22:17:30 +0800
Message-Id: <cover.1664547250.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b90ac93-6a95-4705-8d87-08daa2ee6e34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ORXLFg30+FR/fqYaErqeOkOSMtNOC7U8l9+r6XFI1/Jzzu89oqZfU71Z318F7RcpYO6Yx+ivoU+birl+bOK2D8UoWFQ6XyXmIldIDtyl8P6BTrXUZRNc+AVoFxdPb7+S2AV48/eG+/L3WlJ/OxOVoXedCSJch+lirtwjXmzTKIVphsncfdK+UzEsQHI/gk89eiE4TkXwjA0Vrs9qXG7GT+4b4LMsy9KbGGHEKQhENSseRlUvESy2n4lMR8grW4I/itj6SAhG9bb1AhsFesogljZni49EVO5XMuXO17aX/TOfpYprgWV6Mx4iK/vhehWXI6Czr5kNWx0Hr8Drv8+hPYMQHFA/hf0ZKIM8Jo5d14Cw9EW5Wc0CsmniY6AYOP1n+6G4XgIhxpF4wCzRLfWxKtMaqXy9tCFjBleb3WdoSkSU9jZTn5svymN2zahFVmkowdam58mmXGrfxwTuJAN7SRd9VLy64a0FryVQjhMSxP6RY2+U0vLk/aKzrRmS48sOavb/ZJ2yXBhfyPUK1DviqYqUD8W55R3xS4w1hwJxCZpPGVV7YaVxPDtDW5dPvf9fp+ChhMamYRLh9N/6HyxeMkx3rosAFfHP33yrJgCv7HuRxK5+RAn8aRH++mafVBt9ev+s4ak9Ea+/EQNLeubq1zn2IsMwCtFWIiZAp0j8aJb+DUwLdHDHQ4FP+K7FflJstpeIoVjf6yDprDvazjUFeviMtc7uId09athlVIZOlx3nEL4Pz7ff/8Llgm/PxzMM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199015)(478600001)(6486002)(66556008)(4326008)(186003)(2616005)(316002)(66946007)(8676002)(5660300002)(2906002)(26005)(6916009)(6506007)(6512007)(6666004)(107886003)(36756003)(8936002)(83380400001)(44832011)(41300700001)(66476007)(4744005)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UPou9fG9MXv8TlQDoG2Jb7Hq3qP3UW3gY0KVfe7zLPb5FDu2qB7QAJb52AMo?=
 =?us-ascii?Q?r27CZ8I5nP/z1Tm6zWPvxSLABrHxhYHUOgDELj1LcnUz9jbSHb3Tuxajf82P?=
 =?us-ascii?Q?a7mdtFIKYurqx952EvayvDgYDZlNUpLgIxRMZnUm2/qi/GrHcqDeKRhOlgPd?=
 =?us-ascii?Q?xEFjqC+CfZ08Ucc8pq9w6NCA3Jo+Iv1DtsBq1Kk+SCkYQi7lRbu7D1Dxz2ac?=
 =?us-ascii?Q?2C2i7uaG2nQDGHKzGLl/8GBOdzOG57R9ShxqitT0VCPudTzBgwQ9voRGEaKW?=
 =?us-ascii?Q?8xre5rdPFPo/16xOveB+gM5pcLN3gOBeaDgn7Bi33c12reXv9ewOJCdvct+v?=
 =?us-ascii?Q?98K5shWQISwV7uCTKuTVYCTHi4UtOaClkXFxBEptrFd4B3RVqchnQySai+cW?=
 =?us-ascii?Q?6p0Z69gSAqYtxibiWOSa3JzOBrw0IcjTIzwVhzU2CqJqtwiReICoxveOyVAb?=
 =?us-ascii?Q?MmOaBsFSE+2UZ/v4xpBcTili03tQjQCljRsPDZkAL4KFDhDIYhLx0UBkP3Ox?=
 =?us-ascii?Q?DIiw2EUccdP2QRtmJK5ZIyUkgii3DwBENYGoI/Adzf1AGQC+ADqgIgyM/nUT?=
 =?us-ascii?Q?F86VhLhnSFULRVY8FhzsukFwZeTga6wTbKJPszty3OT0htN3rOpQsoVH7Dqv?=
 =?us-ascii?Q?puhfWDQuThffNythvvX+h1Ll5HXDwya/+rI0PuHnD20BjKLjKgUSAgWt/uaw?=
 =?us-ascii?Q?6dsAxx2A/De+d9L3rCqanmMvT4FGW2LduqlccNcJwG0/Or0vdZyV/+iTLgzl?=
 =?us-ascii?Q?4GCV5jFyiCug+mGnT7jJtp5dcrPg2mTy9oMKP89Wf8m1xpN4Uo2SYgIVGWxN?=
 =?us-ascii?Q?oG1RAEDjloJEP9W8MjzhSoubeOlaEEN7+uZt+wX/lHyewkIpMtFszUvO5nAw?=
 =?us-ascii?Q?2/mDBh/opmF+LUqUacXhJexTYrJ1iJuifG1JzrgC9eRfxa83pqdcKc4BW/yG?=
 =?us-ascii?Q?/9LYGPxU1pEGaOqgnY6+TPf3Cf8CoLNzpK7WJlSSJLjZonU9Ncr14yVv2oGv?=
 =?us-ascii?Q?7W/d4kcyGmodnw8HaeG+go3o5sNqYPH5Dr55BumZHIdpLpIj4V/lM7iI75rs?=
 =?us-ascii?Q?z0S46baKAquRLeK+8vMi/IXXRSbasVbf0xf3dsHkFkl4mOlNv3RNDmtawdBl?=
 =?us-ascii?Q?8Jht7Hqny8Xzl0CLtPfeV5jzFYG/RM+3dmpy3ciCTiTg5QNx99ZHsAKg1jMu?=
 =?us-ascii?Q?bNvd92EabCWJOXRdw8UZQyIwsXsB4+LPaPrAriO7iMsqAMFy5mwMKy8+oEad?=
 =?us-ascii?Q?29UgI5nQYofjFVaAjHmJd7G3gy96P41AnuzCsgaYpyFZMSLdTcQZlVBCEbh/?=
 =?us-ascii?Q?Ml1oe8CyaIU4hYL2IE5E1GeLjVgeuGaO+DbWiAfOxJ3YwPvML+Bl8iGgMkak?=
 =?us-ascii?Q?n3q51dWE6kLHPylS6usIJHCTYGfJrDBMTpfdsmylNR0bWfkf7H6PuPN3atbq?=
 =?us-ascii?Q?3iBh9ET3CdhsOp3fLeTDt9QXoS+iFQEPWEsVmtu3lLgCnOvIP+ylYANHuaFV?=
 =?us-ascii?Q?hJRmtE/gPImrQSf5/Z30CduPVP59vP0Eg95pRlB5KAInIf7fU1srEyLtRSj1?=
 =?us-ascii?Q?eq7Be/b8DuzpVipe4ycG62qNCXWXGgefV2Wrz9lZ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b90ac93-6a95-4705-8d87-08daa2ee6e34
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 14:16:56.3856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LaWCQS7RkTRZ4m8PJvnt8Qk+Bm+rQmZ6BJyB5pwhHbiIwVLxsa2NuP97uCzN75lBKLCsimSIx2Ja9/5QXVNTjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7882

v3:
- add a cleanup patch.
- remove msk->last_snd in mptcp_subflow_get_send().
- add the loop that calls the scheduler again in __mptcp_push_pending().

v2:
- add snd_burst check in dfrags loop as Mat suggested.

Refactor __mptcp_push_pending() and __mptcp_subflow_push_pending() to
remove duplicate code and support redundant scheduler more easily in
__mptcp_subflow_push_pending().

Geliang Tang (5):
  mptcp: use msk instead of mptcp_sk(sk)
  mptcp: update __mptcp_push_pending
  mptcp: add do_push_pending helper
  mptcp: update __mptcp_subflow_push_pending
  mptcp: simplify __mptcp_subflow_push_pending

 net/mptcp/protocol.c | 162 ++++++++++++++++---------------------------
 1 file changed, 58 insertions(+), 104 deletions(-)

-- 
2.35.3

