Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EEC1FD2
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 06:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="rZzpBmpz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPdfNXHjZJ1ZdCVgnie/HZ9rXk6r7soT5eiUX/6MJloM0ir8xcHDPelOmcefw+w5dNy7oJAYYsUCd845ijSxrepQHHxUsJwsLp1xcAhk8+dchVWDccrW1muLHFGsDBitynlAxoRgCnisjU40cNouVgQnFrzJvp800yD7ihwubwH0pCIRpVOnhMc3tr7aja2QEusUwvcMdlcLE2Q8Hvvr3MlBjG4F8mt5V8dCbX5oqK+X5ixyvYf4Hu8nOSlah9+WLyqBtXrIsyEH1Xtz/kPmw7V+u/jHk49iq0JXjOJcNhPMfV+0becTyPbUL69cWvr8pw1RbBO74gPuLxDp9bND6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5O43D9ijb9BIKPHzYDtIYZdhGtMjEN+dhlKgpEMYVs=;
 b=fZfx1yEOFy3zVs0nGrNENHH9thFJSrH2KMwM073+X9v0Oe9XG+9XO7LgVKxUKD/WV3rVX2702Jk7M7SkdPkybnuEMshXFd8bALy7QF1Xpf+91xeKSEiZIXwttNaiD8+xQqPJskpKpSX4fV86ObC9D+IeFg16GCgxBT79fh2i3A59Ve9CwyPJ2uNmEnZJ4SKAo+XQVrW51OHwdFmGO+LbZKIQqHEyRZZTn1ghC6bUrR+wL0HaEPqposryrxsWbiI1HoelFZbNrsOc8z//+1GGHLoLOZgVVMHhSRcrtFfwDonNFJ+ry9HjKbGg613Nf0ROSEAn3Ao7oSMjgoS0+RMM1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5O43D9ijb9BIKPHzYDtIYZdhGtMjEN+dhlKgpEMYVs=;
 b=rZzpBmpziZGYXI3ngID2jIu18RkzBsi5m4K6lhCqS/KaQYxnEUZmE6PxefC4RcXCNztOOdKQDtCBu0lPBhBeXpL2PCaCDZPJIsbqXwhFZVhAwc1ppEf0h2tN/CecPFvXwr/Ij3PZjwje+O8u+FQHEZZl7CafsyLjsRC6qdnGUP3wb2VD8AjnNFAkP1IeZvqtrN3KjUL85kojlhuZfMYGQZ0olLZ2UiL1uUWIghct1njSCQa6VkqaYm7WDAK6NS+RCApGz4db6kecUQ34hDEV3I4384rNPkh0B1vqhX01FiwokpU7E1VPdKG6Jl6QEM/YcRbST57QXJhbhMdeFG7JyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9669.eurprd04.prod.outlook.com (2603:10a6:10:316::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.16; Tue, 7 Nov
 2023 06:03:12 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 06:03:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 10/21] selftests: mptcp: add userspace pm subflow flag
Date: Tue,  7 Nov 2023 14:01:54 +0800
Message-Id: <f730754de17bb2613de47bec0b3e6c4f9ec3ae44.1699336526.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699336526.git.geliang.tang@suse.com>
References: <cover.1699336526.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0212.apcprd04.prod.outlook.com
 (2603:1096:4:187::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9669:EE_
X-MS-Office365-Filtering-Correlation-Id: 27fc6c3b-06fa-4440-3c92-08dbdf573954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Nm7Q9P2Kt3atfs8uObQZRpwbVOgrSmn1nAOdyGO5gIiYO4U3qqxNbiRkm1RMH7eRa0KZEi8HfDN8wcqSJ1/0m4wLg6kjGm+KKl6gdMMy1DFco9i7NU9U1IWUCD+xtig73tJz5ySada6X6Gz+o7ZNVuqw4x4hyNwEWYiR//CzXsjPWrNtG+mKfbbE82dHRPhp/HQ0bNtesQsP75cpMGNpDws/bjQGwRcMfMns8y/fLiRYklbIPIgnvWhKbfbN/3QT2etmu9acZm4f8rYPflyt0+3CS/LIZuVd7qgH3ZhtJTuomfxt6QzkF4URdRAyvzA2TgxsGQNoIMG+vBTxRwcGr79+shnmoEbM3lSzYsYbPQqDPva0FDZ0It7Z05pqvDUSK66GLhXfLO1qVqVy5PEdJ+iH3Q0CqtoqY3086d+9G3zGCUEwV+7F+8yUPvytM3pXRgaIq84u8CXcofFSoAX0udgbqdXKM37pxHI1VdMAS1iS9z8PK7ni2m1idG2ea/NIZfS2nBLnKsSiqpoY7C7q5Q3E9DaJrTV9q5pb1Fh5kfvT+WDQ4I3p24kvQvDSjz1H
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(107886003)(41300700001)(6506007)(2616005)(6486002)(6512007)(6666004)(44832011)(316002)(4326008)(8936002)(8676002)(5660300002)(66556008)(6916009)(26005)(66476007)(66946007)(38100700002)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H9R4CThRghOoAkopb6BpKFLJ5xvpbiy4y16Vhx3RopeSwMUk2cLlRlpijJ0S?=
 =?us-ascii?Q?Mz8s53ZPSsg6wgqXxVs4mM62Hb6AuS7U6YJcGdpvzNpS2sscEFwPq/5adqEI?=
 =?us-ascii?Q?2L1JUi7lsN/IW8sELaY9QND5F7LWj6fEXgOPN5Z28GIZuBzofcji3vUw46gt?=
 =?us-ascii?Q?3gkQVyUCxc2FLBkj0EsOiZWMWiv8To4odaTT8zti3gQuTOFCBN5+BImBZ61Z?=
 =?us-ascii?Q?3N2ROqC8wA1s/29c8gVvgd/ErSyC+/NNg2v06qsanZyqOf4uF4bQEFzmMCK/?=
 =?us-ascii?Q?gpPL8Vgj6Ak4yZuYk7V+kcgLeHcwVleBEps/VKnh0nMoxqUqy7iHmpf1wbOJ?=
 =?us-ascii?Q?UPxP11Q47NzrYA6+MKiZ0uPII6Wog14vHIsyaMiJeHGfQIPyVpjzNH9E1DiJ?=
 =?us-ascii?Q?j7Jn1Mwd59e0nnK1fTgGLmfi6o0nMMj+wK884FJg5lpA8KGb2Ui9FFgSXd/O?=
 =?us-ascii?Q?Yj1YVBBT2b7YAz+Rsdoc8Eao2kiUXHAG/PRj1eiZYJZ/sA5rTDjnZXurnnD1?=
 =?us-ascii?Q?tnG1dFTLXlpKu5zsj/71B6O7gySpmzcbpqX7RQzAXIhPGdGwlMSBHsoBIFol?=
 =?us-ascii?Q?V4Maf+JjnY2/9DvgOIh5lGIpBWTWKeQHscevEtOxH/HeYWhvAwEnkPLo1O2l?=
 =?us-ascii?Q?Re9p0S0mgoxvEH5qiAhueIdrhb3wAnbAXmPOp5YJcbgxWLIEFoRAqhpQ+ZEu?=
 =?us-ascii?Q?AcoE7ObwsXDJxeXmalusuKyOdWSbQeq0OuI3uKTwO78ovu+pCbE2kjFJ/hL6?=
 =?us-ascii?Q?rU9QUtfEZCXGz1GNvCgv8g1UO/GbvoTQH4EvYAp+MFWnLWSkCfYkZ5tteYvZ?=
 =?us-ascii?Q?SFZBvc2AfOea808M1no4VtTsHxALjtpbUGZTJZWQM8ggmnVCDSgxRUuBVxIz?=
 =?us-ascii?Q?kTG5GJ5gYfbReFhwgV0gttdV+asTHO6MCe3W53BsLLFYyVI+Sh71ITNZaHUR?=
 =?us-ascii?Q?AhRgv1bl2ThdYNyB8wc6CGT+DZrsEt7htyOzEqQCFkX1oKnfVgiLuXN+oiCE?=
 =?us-ascii?Q?xkKs82ozfPsxgZ8TrIYjxxTRWQdu1FPcKTrPfqZaLg/N006Zz9mWJbN4BEDi?=
 =?us-ascii?Q?uYK36LV14rj+Tw1MrVwhPKmj4d91A4zh4GCe739a06QkfD8rxtVDy0iiHf5C?=
 =?us-ascii?Q?xS//9PB2VKtzcpQUJU58TTWjG7Gymb17BHRzNjXjRTzZcukBYnuchzwZ90jN?=
 =?us-ascii?Q?QEtZHJst5qD28sxxxMD1vy7mtEy/10Cenm6T0YX9iaYKlJ+dElyV6rh6lYi8?=
 =?us-ascii?Q?IihUJ97ORJMQxrAejYdNo1TGdCX7f20nm7fbLDZpBlbA5GECY7ZNxzxI4E1K?=
 =?us-ascii?Q?hGbCK9Ubyu7vGv5Kk05rTLs17/Lakb/NYQyv1CW4EzG6r6REAylErM0vCNzV?=
 =?us-ascii?Q?a7qHiDd5IDLwCZZmHr/V07BOO7lmbX6ZoecTVt5ut0jUPQfaubFDUrXiUi80?=
 =?us-ascii?Q?i6eV2dwn6siPC4Tiw9HyUthnh6+P30TB8bPddm8ZfjjzcNd+7iY/v4M3AiZj?=
 =?us-ascii?Q?fxEScLt/xUHlr/AB47eY8xtlOdeuMPcwUPHcx7k9UCWWTNsBWnycIWm6tmBs?=
 =?us-ascii?Q?XuTDupKMRd47ngFS2rMG92H2Lo7JLns5A+MS2Ukl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fc6c3b-06fa-4440-3c92-08dbdf573954
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 06:03:12.1764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMwB+wdGg+84+krG7T00XssmUmNzB6TsEiFmgRWrdCWxeU4zt2KKzAOwYc5dfnCHTqs2h1+AFxunrFLwvaMtaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9669

This patch adds the address flag MPTCP_PM_ADDR_FLAG_SUBFLOW in csf()
when subflow is created by a userspace PM.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 49369c4a5f26..e97856323ec3 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -453,6 +453,7 @@ int csf(int fd, int pm_family, int argc, char *argv[])
 	char data[NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
 		  NLMSG_ALIGN(sizeof(struct genlmsghdr)) +
 		  1024];
+	u_int32_t flags = MPTCP_PM_ADDR_FLAG_SUBFLOW;
 	const char *params[5];
 	struct nlmsghdr *nh;
 	struct rtattr *addr;
@@ -558,6 +559,13 @@ int csf(int fd, int pm_family, int argc, char *argv[])
 			off += NLMSG_ALIGN(rta->rta_len);
 		}
 
+		/* addr flags */
+		rta = (void *)(data + off);
+		rta->rta_type = MPTCP_PM_ADDR_ATTR_FLAGS;
+		rta->rta_len = RTA_LENGTH(4);
+		memcpy(RTA_DATA(rta), &flags, 4);
+		off += NLMSG_ALIGN(rta->rta_len);
+
 		addr->rta_len = off - addr_start;
 	}
 
-- 
2.35.3

