Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5A02595
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 08:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XHr33rIZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOevyBsv99tbZFDm43lDYhvN2f934qva+CdXGOYFhIVPOpMYO5VtYDhC1n1hz3XtM3lsLi/mD680ryAyZ3H33z8+zAfl+slwHBERJ8K6all3S+w3EzUvBuoP6RptMr5JTlAnGae281xtaUfx8txPNnBptejejDWwjUSHf3knrrgzhO0NPeYDDGog3OY3kYiqH758SPlZaxV5GMBH6svn5XBh1pxXRakbQ9PcD4+R581qsAulw7vmJYk/jp7T5UIDrHCD2TXLtvN2aZg/TvE7zgSeyLn2wlrqMmck8GGA5mIgqzH/5wVd315xNON+61Ji2lryyp7fY2k+dSNOfPdGcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5O43D9ijb9BIKPHzYDtIYZdhGtMjEN+dhlKgpEMYVs=;
 b=HzDy81xfSsifBr1WIN6NDS54V9kTxRmDH0keM6L1SSWyW0c2btUS4Khfd28+Qzg79sXNXDAau5WwflmAZ83rd3FGLAkzHKqGBC2KL7rJtEBNMSFOZi2M31xkAxfQBU0buciXhUrPon/kxxZ9FRK+3pPtZ4rb8FE9n9/1fAaqKTI2xFE78hnn95pmAWulYpM0jMtJAWzlkGuTwX7TnUOtSjAZsM6s8blpVlhB39CHYWg3V/CDvyrONm4vnDHREpfJh8koyk5fqU+x+YWdNuCeXGY3DkEatsRolZe1xiPnhUNj2jJlwKswADvnA3KBOZ7Bw3CvWB+YVx7hm4EvSqbikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5O43D9ijb9BIKPHzYDtIYZdhGtMjEN+dhlKgpEMYVs=;
 b=XHr33rIZ5kaMC2F5ek699KBoZEPNCN9HNrRWWRxPFOMpz5WhZMAtGTNdqxBeGYwjENRHZ2xyaVgD132BCLrIEaylcObwEpIhIU+wbKHj9HZfjLBStdmqOWEIvd037nb7jAtxuBPWaKuC0oSIM3Qq9MI9wSTyrpVeo7aEtBUydOOIuc5AFxpRiKCwG/u/R+6bdHpCI7GHV6JsvZptvAFWSIizEB8xMFLksUmugQKYcbVeh2tm5oE1cQzyi7F29lZZ09BF43pmiymSMIhwUPwTYDt24K6eNb2mKAP1/HMDQRYwJ+XN4ymqPwdQi0Y0zeujz2i1PDihNN9ZtRUFcrhJcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7663.eurprd04.prod.outlook.com (2603:10a6:102:e9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Tue, 7 Nov
 2023 08:15:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 08:15:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 10/20] selftests: mptcp: add userspace pm subflow flag
Date: Tue,  7 Nov 2023 16:14:16 +0800
Message-Id: <931d208d6ce5dbcb9cc0a834cf5e7b641be8f0e9.1699344621.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699344621.git.geliang.tang@suse.com>
References: <cover.1699344621.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: aaf71a35-5fec-494e-8994-08dbdf69b459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k6V9sjmSYTxbcthDywWklysmrGIiecEi3dOjCxOWal7c6d5na3VIpP2glClRFqGmgDJcR/yQwasnzZoZeVzchps+jdT1MEA9rmkF6yOyanNY1bawByPQmPlBri8SKP2xrdFiB8KR0rQvIwapfzl/EyZnv0/TOboE7mECm1Xe7B/+6o/RfNOHHR45FwEEuveL0VpnL5KLwxZfh9VenzxNnC5gkQfQuV9Dr89gMn0gxxzNIpUIvsZihu5hA+JlS3ebas8cp7ZQy6rDHT4dP7JZUbRX1SJNnSTR/dB7Hl8qFcOJLxDERsYhWBtq6VcFU3/aYp3wMsGRQv+7+5XihR54HbtdjlI6BMu3+H9tvwE0uVfa0wkTTDTEinyakn9uQn9ornJfwqQh+4vxfDA7Yd2Rmox6aWoRTScnw/7pF3yVzlhOjVjD+cyW1/KODf0CLHzGpeRi0yQOkoxhDJDB6rPDUy55TzMntOI9HWTJSr/lCBmHuq79ZDD2AMk6IHdjsyPE/r41F6p0csUcGazgpj/Hecff8/yjI0qWFtPKj28ULYLXLNKtpZLOM1BUvJqdTdVX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(2906002)(41300700001)(38100700002)(8936002)(478600001)(4326008)(6666004)(6486002)(86362001)(44832011)(8676002)(66556008)(66946007)(6916009)(316002)(66476007)(107886003)(2616005)(5660300002)(6506007)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O4mMbCmQ8L7kyhxBfm1lA+uLAns/gnkBy/XnQjSDfZc/Wgp70DsXYHm6PMSe?=
 =?us-ascii?Q?AkYRhdjWtC1gzaFb62k514/oQt1KezuuIao2ZVxvb1qUpk8q56e/eqd/iLPQ?=
 =?us-ascii?Q?v7jPz6ELlFuSBVNihy//zAodGsxPE8jgoXycIUAN+JvPt7VjyvH3rnmA8zsq?=
 =?us-ascii?Q?jqJGHfzkhnqhSOy03KhjosjfzrjD3vKPrZE+NcSWet3DP7K9deXSvD+W9zON?=
 =?us-ascii?Q?YEhanOWxgJGaEWq+yMKGFNpxj0LBNuk8RulEzv6p3zqQDODCPFmoy+t6brRr?=
 =?us-ascii?Q?jkjlqrirTkFqlz9EIt7JQym4q9NRrwYtSQLlBXeuLPGxuOI+8cnwO8DyiCI1?=
 =?us-ascii?Q?+FQu4Gnr+xGgoKBlc63YRZYsSaUGjg19RGIXemS8GNRrBo+UX60VMH8zofSs?=
 =?us-ascii?Q?f3x1TKYAJGjzn3IsdNWVAJ3y0/4HGArWUjNW1H/l7L0Hk931xtseQ/aHTff6?=
 =?us-ascii?Q?bKk9awG7cEjg4I8nIzjJyaP8lxQ4yoHCV5guv1LKXpr4Blro6qXr9X8Lugr4?=
 =?us-ascii?Q?WYUzyfbnCh8xtyoEbeRSMmVXUee2AC5CjLca8xLY93EQCVrTJzI+xHZb/ZCK?=
 =?us-ascii?Q?z83lE6OdnDt7q+V9VejBvqP6iK+2rTcA3lL9kAWFfMggaLZjsK17Ss8H0rSt?=
 =?us-ascii?Q?DPqgEn+JR9IxaHkhAXbdvj1NKT4RMi80vn7XzbKN40cCKoTZieUVQaNm8lYy?=
 =?us-ascii?Q?D0AJxKeXYrLa4Lf7lDCmn6oXjq4zhK/bG5P25Aqmj68aRUpGKgws/El097Qs?=
 =?us-ascii?Q?0Wdjeq2yKxRIXp5yC4N3Bt3oTTXHdt7BRUVkZXmFo32koMW/2ru7ZTQLzFU5?=
 =?us-ascii?Q?YHzjWqEb0U2X+Sx5yRx8JNwwnYYsg5EA8D6hSjD25c5Mc/5KvwIcrV4FiKHB?=
 =?us-ascii?Q?1qNk1d/X0SMLMbF00ryM3Zu+0O3VUr6TXyVG9ASK078jeC00Q44lR5KdmTwX?=
 =?us-ascii?Q?isVuGPel3mk1HIV8x6Vu73t9x+8muHvVZDi0lbIgTNQHk8GaRItNgmu91Suy?=
 =?us-ascii?Q?fWAYT7OYPOzgqhhhY4NixXyDVSjLn0El+TMxrntPLfoxAzRJ2eb+txXKtqDJ?=
 =?us-ascii?Q?WWb3mVQk66RAB0t/rQc3N+YVmFzVuDmQWdW0myLGwFaI9rU6dDkoyca2qzZF?=
 =?us-ascii?Q?POiO6dYHbI8GIcuYGROPFyFkPU+yUH+CzQWQI31ESJDDnu5f00H0jM5ASnBR?=
 =?us-ascii?Q?BM2rB7SR8H3lXUnAUwX+QY+6cfFxEkD5YGwvYEnbOIbnCqm03ttanrMflLuX?=
 =?us-ascii?Q?knpH7j6fUtr1l/k91o1n7313DM9mp4GA46MPERVbXmW6JQjlgHdiMRJT35b4?=
 =?us-ascii?Q?qT/Kg/lBO7ISXAOroXfWdKTeOTawk5tCqOGDhR/cHii1rgHAe5Jfjk5C+T9y?=
 =?us-ascii?Q?+arsh1yHQ6hocv+WHQrUBzVEdvT1KDkB3KGScGe03Fy54shaVMYNVVZoR4qb?=
 =?us-ascii?Q?B/pEejudIUpGHyNMWpr5wlaVD7USdebqa8+suNLH3bvspzLnTOvUJwMDdhh9?=
 =?us-ascii?Q?d2tECMicDLOeIsTuL5/2Fw3JlZ6lEVb/iSISJyC4HTZHwU+GQB0ybZ6bBXOQ?=
 =?us-ascii?Q?TYxGOmAhA0HvEl1brZaZT60XyOCG+023EaKA7AWz?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf71a35-5fec-494e-8994-08dbdf69b459
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 08:15:29.7152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0p7xWfB00/H7UBxj1Ug/jEEjcivuN371kJmvnWBW/xALthNNff06iQGjuLTL4iB8/rbdIuZusXliPDJnlcg5lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7663

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

