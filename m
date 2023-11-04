Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2061.outbound.protection.outlook.com [40.107.22.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1836A15486
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="21gf4ozJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gjr5Eay5lMvULmBoz6hk1eJQliW1iYcEp7VwqtBQInju3WDEIdpvbie4aEb+U71l10PqfJ2K7uHhSAOuzmARt7cjRKZm3IuEtfKSbZlMv+EAfSIoOfcwLFo3VJtE1GW29RGzzp34WzFc9W+C9LdwptJaSAWRhty8J7xRzj96VHRSKokU6MmQwkTbgnU1MEs56VWu5iLD8Hj5ydJQWc1yZIZ4jSaFocAKY438+hNkx9rfaplF/3/iiEb8cSCDqoewMFyM0Sb5ZvA1NHYyX2qIwdxYvtbaZ2ejKxL3JvR+TP73x/jmgNwC+4yYk4UuVQ+IUvWW+z9KEZBsWLFC7pn8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5O43D9ijb9BIKPHzYDtIYZdhGtMjEN+dhlKgpEMYVs=;
 b=grPpLfSvgxGCoQGIP6mvvR9px0WXKyib3IuboevPK++sfGOAWpvjqPCSr3VQ2bHEGMo9/lrMFhRI0YLgzA5BAY8J1Cx+CUERt3/nOCGiMmkkEaH3QYTBIb0kQxtlz06X+augwFF6sBQGroYtOphLtXvGGLS/xRAVxdmzn5y2qi+efXJ71kYBppt7P+Zcr4OONCwacIUpeSEsO5WIz4dPzJ2Qmc4gQOocpta8L1EXgyhpMblZPQqZ1I1rilXJAgop4WTk6UnBWH3OnuLRwnbl0uXE+SmFoI9nRBawM5bNmFRtnF+r2vOt7EkrYoC2dLBXkISfWMJR3AX7EcUjR6ScWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5O43D9ijb9BIKPHzYDtIYZdhGtMjEN+dhlKgpEMYVs=;
 b=21gf4ozJvXPpKZZ8hWhLMEfdS9Pav5ta/air+/5R10+sDGWkuex5hL5Hx+2Ci1bHg2kV1tuoxt2x/FM6i54ZVUDupgVd1cXqHB0qFjpuP9QU21JFC2uvrykrnX852IPC2QfUlwGwIznbkAghOqf+Ii1FiAS9I6S+M/hoSuf1RgjblzFKoVw5EA7Rg4oSnwVh/iZpYq0VcCZzc6082EKc85in+qumCjpZOT0hQztnzlHcIw+4XZjmOJzgwn8tjzXPRRHGfK4VLqppu+36KmnXD8qSf8aTAlwlBDOEJ8lDLx93dQxT+SiRJdKL3RZoC2HGj5mp7luw8DIeFURyMpOqVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6820.eurprd04.prod.outlook.com (2603:10a6:208:188::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Sat, 4 Nov
 2023 14:17:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 14:17:23 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 08/12] selftests: mptcp: add userspace pm subflow flag
Date: Sat,  4 Nov 2023 22:16:22 +0800
Message-Id: <309fc7e6f9d1a62b0425673630a7d3f588891798.1699107275.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699107275.git.geliang.tang@suse.com>
References: <cover.1699107275.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: e3b020f4-1ea1-4680-c16a-08dbdd40c3cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LFXvUnDKyXiVeir4xpEjKqRDIX08yY67I2NRDhfWJgp3NrXFS5feoO5434iPkU8NgdbQVL9c48xWI2s8qCgfoCMJF7IZLn4rDURW66CHsrgLSqbp0dEeB30AXZk4ifBXD0U46mftMyaKuiKuVzozW5TwIP8sYk4Zel7ONvtAmp0gqi7B7AyHDx4fyo0WRnGuaVwk9oiUnASHH3n7klcYx14lsJwSMrcdIPhTGGsjbktofa1FN/qj6wnOL/7DGK30X+bdOkZKwW0azgaInfnvdS7tMtB/RlJoASXGbOhQfTFuUZwj9cTJIxRmG7+ztI7YYXKvHWDAPSh6jkqbG/ujPw6dnBZ2/OnZTh/xNx1jB9JWjhnmMRfV72+6CQicWx8W4Ltlgjm7wJqT/ShqlGdg+PL7uaL5xTfDzjNK0vC7SQSdi5MgMd1oRv6iNFBW8AC1ITjul9dPB1EWuiY052hg0y79NfT7U8rp9+eNZdOu5fcwHHULi01peIT7g0pIQWXZuHXjEMoV11Bklr1tM+IA1lbvWdhgcGvm4cd6HN1llOiMpVNWShurzyXmWzrw/A/7KjXIkJd0NOixyp1qwoliecyrwbsHDWgAp2a6KXs/5v8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(5660300002)(2906002)(6512007)(26005)(38100700002)(2616005)(36756003)(86362001)(41300700001)(6506007)(8936002)(107886003)(66476007)(478600001)(4326008)(66556008)(8676002)(6486002)(316002)(6916009)(66946007)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W4SyKPdRJobln1WqcLWctXOpAzWkfc181mRBDlNo4YOb0fa8Zg9ndmERBAh7?=
 =?us-ascii?Q?LM9QS2kTg5gIl4fZ3GQvGAagWL3ok49/z4cpO5M/uzlf5+XQHrlyY2PQFGPt?=
 =?us-ascii?Q?cYxAyMc7VwlmabpGC9cgCb74UMV283vSKUFsdtx8HOgh5VqLXFsTW5hwcYiC?=
 =?us-ascii?Q?RT71HKyaLCEP9VvPvdIo1Mwuz6IlMWG4PSKc4M2Rm3swx1spwokkNrc095g3?=
 =?us-ascii?Q?Yud/2t8jC4bFbtwZKW2wUlEhXCugsaD/Hr6WVOzOrvTCIi0q25ZT8JGweP/R?=
 =?us-ascii?Q?3ENcpa4twiMgey5yL3KHhIsiXi1mI4qLrSSBTblHIv1jTuPEma5CuUU3QKdq?=
 =?us-ascii?Q?wZi1zdlhLLkFUshH93Vvpu+SYjZmXkRDWdukI/A+isn2YW5Iv6Kj9HV2k5iy?=
 =?us-ascii?Q?jAzwy38/ZkPXXID337YmHBdNzeoDwBAUFNYPGbmgqPgrC4wgX2L3IFAhXEy5?=
 =?us-ascii?Q?UGUxrpcfgcYchhsdRevlCdn9m3c8wRv+ualRRzqaJCGa8IrBP9r9imUGLNu+?=
 =?us-ascii?Q?ogQTiqSevxspByl4q9JFjr91XW8w4oAQs1SSz1yWg76u7mL5ticNvyBr32wo?=
 =?us-ascii?Q?I02sKgkCI2fUIj86ztYkwIsnDGOuzvo+Gc66KbALNMDc8WYoHr3zro8rLce6?=
 =?us-ascii?Q?aPdEyBWOb2bMO9q6u+RaTBVd181azaLX6pjcmnGSm6BNgc5p+5YJIlXsvpla?=
 =?us-ascii?Q?FWYrpaAx+FvZhDfSwOQmYWWmmQBgVRrtvs7uQynq4icxa87lG3oOF1w0uzWj?=
 =?us-ascii?Q?Vieb5zNkxlcXI7e6J7GG4+iEbQr/t0C4f/uNOhdv+q3WmJY4mWnQQ7gRdqwg?=
 =?us-ascii?Q?bVcqVhiz968/Lp3CsbS9B5UMB9kYoFKpU6TfNd8B8smhoXtvrV8oyFb48tPB?=
 =?us-ascii?Q?IyIGIVm2BG8hP722nW1kKt1eLyvQORKCcH409uW/2x1JvaZ2zT9IpkWvI3YY?=
 =?us-ascii?Q?dpuz4Sg1KDL7UJd3b8ih+UA1bA2vbbN4yBB6dGMbdGBC2+9QwwR6vWroZoB+?=
 =?us-ascii?Q?3mHuPyD9O+0BkJyFkEnoEhWMnEqYSw3ttKBKkGuWATDzAia1nCY3ZtVdA3UH?=
 =?us-ascii?Q?lH9s8vs9VDvNyQltC2MjT0HssX8J669dAZa4PXnyZQmcCZlgpN0uVjKrPqvJ?=
 =?us-ascii?Q?XKOrVb7oo+3pHVRnMtfTLbJ8bR74UjHGsdhvS2mi3fIQMzTjgKHX3Tx1DTUZ?=
 =?us-ascii?Q?kYKgXYE0FDl4bJ87pTVq0S+6EQ2f51O2W+1vjErB75BJy3kSb2QyLJ4RvH38?=
 =?us-ascii?Q?Hbupu5xtx5+vA+XJh6krKZ0gp8GYSlsfST96RSDHKFBl608a6GeQrStODC60?=
 =?us-ascii?Q?8nUdXwB8dnh+wkhos/IuuGMzUEviACpEvbOLuF2IZ5m6kl3osDVY1eN0WNGY?=
 =?us-ascii?Q?EdGsfzFAMZYKMD4ShOpivxP6Cep1hya1CxmXb48DhgqtZlGskk4gXMsq7LiR?=
 =?us-ascii?Q?KTdsLWW0KTi+bHIqagb99bSJIWfIEXhCSkRwo0vZAVz9lpk6bKvZpcPz+7di?=
 =?us-ascii?Q?O9uxhPWlxxIY5aQjHcl9x/X/Fk0pX5R/1Z73do+xr4ei2jdFqQabYDdLcI/z?=
 =?us-ascii?Q?fdHDJHac+43ortZdpoatnn6OXwxbOgA8ouvoDnLKv5YxgzCxTrmguxLjMQSN?=
 =?us-ascii?Q?Qg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b020f4-1ea1-4680-c16a-08dbdd40c3cc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 14:17:23.6815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hDl5bkpQFrOlAP1mVJCHgNzs/X5VKAtAMrIMf7XcqySCMonKE2YUfOL1XnBZb3EE26k3KsLdcQZ5GRq5n91+/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6820

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

