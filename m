Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C42196
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 00:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gQjEILf/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXvNO/Mm+1WO+wWkP1b52CB7pUhpzrm1N4eCP+Myz0ocMil9yBeupjvZSo/3OrVxGm3+lWY7D0CZYz1JoA738OtWJQpak+H0hxRVe2ziMEerz8RCyYCtUKc5cDsjxysc6Uy6onnlukbYjgMslj1UsrzaFHfJCHrWHNXvdQbhVPqNW7HLJ6AVp9Gl9/Vvzy38MtMQr7GfuE+6VtHLBcki6QUL7DdxrMu3f8bqzokJu14kZcjOcmXPDu9kPX/sUHK2M2YwDdwtmmJsf5zmMr5bPMWwrPaOKWOS96Lzo7ZzZ/6xGtBUXvwkS8hV42Xmxz3nQE2N8ND0m/piJnxi6sXQsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5O43D9ijb9BIKPHzYDtIYZdhGtMjEN+dhlKgpEMYVs=;
 b=ItVbHryjcErPm2NUEBjYGmtLkDMIYLc8hBPXprjZSiXKHN50YoYJKRDuYTDYzS/8J6/B5OOesmG3ERsklNvEFGjbIGHa2LoFxgRVK7XPCqFiKk2L7FD3V7PqAN3YHnDrsr1BU2+ver9eQMbwALXbbw1HYGg4oZUIzzSjHvTfMCEtfWELyU8q2u1m8EuQJsvEh74Y0Vkiv7YHBFgyQOtmrTqZ6U1WEm+yAU1UjNr9Ghmj/VlJWKrtyqIXNw9vhBIde/XUYpWGzsBDAh5VwtLvUm6hQU7DhJO/xsmOnjsolnI8e8hwe60FtTw1WVtEFJPzxqznJEtllZY8elC2V91RtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5O43D9ijb9BIKPHzYDtIYZdhGtMjEN+dhlKgpEMYVs=;
 b=gQjEILf/hk0C/bdTD40/y1G3tgdR9KjecEk0RF2v6EZomny/bK6vIJSI1ZQ4LrvG2pqzFnqI52kiDbLz6bc0JJtOVM8UVAwntXnqVihHFngKFl1OKFltz0Ng4fE0qRPtCZ7uW+9BNgoxMNzDFfa6qTpIT6ROcU+G2LRuQxtry6Vy+AI3HQjvY1/7MMWavoOkiZkHVB87xEczZvIBnT0Bs+l6//myhcrUj0ez4zgYlbzizKQpV6nU/Ze6lO3YZiXIgYuPlAIPQOpOFBhaK4QiS6PnRhh1vRg7psaLhseXqplVul7B6ZXYcZfEDDB4zIlIWV9h0+68aD7uBBECDy0DWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6989.eurprd04.prod.outlook.com (2603:10a6:803:131::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 00:27:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 00:27:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 09/12] selftests: mptcp: add userspace pm subflow flag
Date: Sat,  4 Nov 2023 08:26:20 +0800
Message-Id: <336fea250fd23e6fdf601c3c3e8d1a9277bb5658.1699057244.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699057244.git.geliang.tang@suse.com>
References: <cover.1699057244.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: d7acbdbd-fddc-488f-9d05-08dbdcccd81f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ObI5Tl/Eotr/iV621LPVcvpRVVcPjSxH/XaDKN50qHm86JeQajf53SruAfbuzcBTLMtOut5pvOC7pA9itJrAgiPgGiTBOAfMEAouavkQcWcCRP4uMeqbVpklRA5c+JI6Dd+anvSJAEgySyBOCF+M1g27SZQjEYHzqsTtNgyUPMhKAE7pTZKhwMmAWFisA5TD6aePvV5B8b2roAdfVbVhKHALjx+afKjZoBBZEKc5zrwXBWVdoc2dEc13Df7T83v3gBwDAHvLbZyuK9VVZlgGCCv5gEh9XZM8JHxxujQesSgdqaRCj7Z1kZsT6kPiXvP6JqzseNbdSshzahW3w1FrAwW/Y1LMgLsFMilvtmj6XrtFpSf8kmWRAhb8ZzJ8CRo0rw7ZG5w82hKYhD3rbTreJ2MkphfQfqXjwZIBDBVH8jmMrytskYtMZdr1TWx9z6BpyulqWZgTVts4HaO+yE7Ny30mUyezKEhcrJqlvtmi+BTIVg1FuSSPobU2FVnOZC952BvdQb9cMLScKY55kcjzNl9DPkCTJCO+bMVqxFocEWLXrbrqrEFoHCUNkFxcqSVWqmOKaFxrKCFOZh2zjyMQD+pdZQm/06X8d49PDtLmfa0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6486002)(5660300002)(66476007)(66556008)(6916009)(8676002)(316002)(4326008)(2906002)(8936002)(66946007)(6666004)(478600001)(44832011)(6512007)(107886003)(41300700001)(26005)(2616005)(6506007)(36756003)(86362001)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5IsPVSgWrBPEYsnezbasa5fqqr7WoLrahJFrPfyvXGWVVU5vk86L8uMOVZle?=
 =?us-ascii?Q?KiPntp1aWuEhfLgons5RZ8ironlPJij89/v+W3jSCnZgGDTR+X+IbavVjzoH?=
 =?us-ascii?Q?zvm3UFqxYeWL7BhBadk6C8BQgVv7dbllguzVY3E7fmz8eXXgpzIfbA1C9s7u?=
 =?us-ascii?Q?hleYbz8fBvZQSsXOeQru/nu2K8NHCa8DDs76HzYBy9SLU0/RcwcnfePyAN+2?=
 =?us-ascii?Q?tE7Www8hWfx9kvEZHkmOVZ0onOvxa6K4eHjJcJY0yf7L8mVE7qjGlc4UUQ6d?=
 =?us-ascii?Q?f7/Pcmv+vEAqfO+gIFXQfg79SAC/CqG5DCjVSRVxhk2xvvSO+Wwv8DmJS/Oh?=
 =?us-ascii?Q?HIvK+eY+BIdCto7O0cUBdzhBktkb+ymqC+HU8kYjQKd63of/eL4t3M5zonfc?=
 =?us-ascii?Q?AH89pJGemxcQicYlDw1eH5vOJznWNi4pc3t2KYqgWdZNitaEaXLXv4GD/VPg?=
 =?us-ascii?Q?vgUpFCqne8HISmg1N5dhR4baBraoGsGQgGbYA3kllPyn7pIzF8L/+NxL/32S?=
 =?us-ascii?Q?NcZ/GrGC0JcHl5MvSDVs/SaRg9F2Oovfsag0R0Gph7CHiqUkNaBcTGIdWbVF?=
 =?us-ascii?Q?trpZXE4HuU6Z9oJsh+KM7H7gI1jScdw2/8s7Pxux5LlLFwLINX+giCLqcVzq?=
 =?us-ascii?Q?7xe1lBy3I1sY9R/RwhjJTeXzYsh0TjAWe3Gxv/bjP7020TA2P0APoAHn1VMC?=
 =?us-ascii?Q?gv9Qeubhz/FlpR63nyPuCXRnOPUuNOxdG8CKFD/8Q8PYMiAg9Zn6BNUxIGNz?=
 =?us-ascii?Q?bZuryogIPUbHY4w2Vw4aSL6D6r62gQtIX5q/XBpZx1T9hf+TGNeaiE4jd63D?=
 =?us-ascii?Q?eddbvvNJooX9JGwRicFmn8mlDpw4UaeBVdV54hZs66a+iiDblvjINYyqVona?=
 =?us-ascii?Q?ddcGsYgAXGL80nzyL9EkcbOAQJCf8f4zBcMR6AI2cJAvpNZ2gmkUnw9yCXs1?=
 =?us-ascii?Q?4fiSSNtgBRXlgSBcoaS2G1bnWO3kpusGZLAWpobsC/IlsPpIZclvsHP0Qnp+?=
 =?us-ascii?Q?K+4t3w/GtUKmMB/BJVmk8r5zvlFpqU8tkr32aLHr5+skXiT5409KzsI1jm9D?=
 =?us-ascii?Q?7gOFqlAnuusHslyW/V5AMwAt6Lu5DpIC8+PUu+cCF3Uh/Gu23hLt+1OkvwEU?=
 =?us-ascii?Q?eZJxY2iv+/suSR0vKOZ9JNtXR3qcd8ZmPNaxw9hHoEzGh8gVYRi0NwaCPdpv?=
 =?us-ascii?Q?O+6AoKHro5RrRT47EMjwu/nI5aEf0yP1SgosEyVytL+9QaREUjsGIbD+IIzw?=
 =?us-ascii?Q?x3WP7XPq/FVfhGrvkgAslf4ldvcCrGn8jBDV62a5q3cdKWjKq85YNOSBNJKf?=
 =?us-ascii?Q?zqVctr9zH0BxQqDrXy50kOZATISWabN+YEt3Tm5CjoPq2n+AxhJVXbXjTZCK?=
 =?us-ascii?Q?a/6bvEOKLxxqejBomzaxlZWsayPsjg5/qfrI4xr45FL54FG6SFgCfW49arDv?=
 =?us-ascii?Q?wcp9w6WPf8UadpudSUkN90fqDkFGvO0urdpfZPVmRlvQvfI7ebwEtGzzbFut?=
 =?us-ascii?Q?Abd/VnKbMRius9zMFynumtA9jywM+ehLsjQV6DOz8Z9pIcTsTqhh5e1Qt+AZ?=
 =?us-ascii?Q?PyTOQd7kAUJEuzHWfa5eS4PHI0SzkfBeGNYzWSdOVnq4TLiviCJuZAtW3B1B?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7acbdbd-fddc-488f-9d05-08dbdcccd81f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 00:27:36.2448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0vy+Z49b7nEUbY25BTgrAAFOZK76goYowGANH6X+IYGfW4chsJtDhsSYRjhaVv8omyx5iHvpwU5FhiHdejNAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6989

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

