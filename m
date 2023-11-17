Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E374ED28E
	for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C2Orl6tb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsX4Kvofmo9eXGEoDBvlA3ReDEkC52d412xlN2ZpKya39WL3ZXmPpXxhdX7V4acYaUeTQHim4Bj8x3spVhsfZWNTQzzYDZH09k7EHHnmQiafQzD+CLQnNOs35sWssHeGlcSCmCu+o04EmBlBICwk2Mqu67x1DIzq0AkghRi1Em/9UnJ24AVfSmTw+YU6dcUEEfaX32MUNQ68x3e9UzIxS7n+ltTT/llbH73kaffWQkHbBPWspjVjFFW9usw+5OXuaguu4oNohIMDkD7s2nSqnTTb4ZaIU3OYGRVvcwmGalkQWonLp8ptpWBNsSmdmZqe5+a8wskPVq2vHjWzZC2Adg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOp2TWhtoPPob1E5rhy13X9kUGO29azvPp9LWLnT+zM=;
 b=aqIum1CDkhj2aUGzreegrW4ui4xBcAL22haCs5G1x3L/uzB0c0FsaSM+xEeePKf9ISZPxYcu6jnwX7JU/f3Wpz8bzlRNAoGUKyF7iB0foxclCcJrksehCjSYPpucR3/M8Vp9xNZwtdhGGFDUkqW3IYGhOzHKyR289ZAgLR3VRnDP0HsvvXtm/j4Nefx/+ZvIXV8SlowtIZ6L//vx3g/PdfitdH8dzjwYF9uSaXCrVVQ7dqeyIRP6UUSi4bms7Xnv3N7/LJNUrGOhgwgZNbE6/umpOD2L0XoKE+gF0rNMr3um1rHOCt+iWZkHKgv79BZZYI02nxvfKw1x0sfLoKXhlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOp2TWhtoPPob1E5rhy13X9kUGO29azvPp9LWLnT+zM=;
 b=C2Orl6tbN5+lGRCuANoiyXLd6Xk4gz6zLSf2423YeRM8mYdtp0Dnv3eAEx1noH7TJUwUTOvwV/fXKTtXgWAxQued35MoM7Br6jfSX/+EfZXSY4t9k0F/YLlX7XMLS2AbjVzp4FfUh3V8+YJgBMdzttZ6ez+hXIGc7RgihWYQxSENTOmm/d3Ij0uwMTmFHMLIkMZx2xdfeFgy+fO3xLTrRs77ooSuH9ln3Ci3/q0/2SBDPiyBm65WZrkJsd7S3B1fMeUBkmTE97f8hnKlFxlRI7uqfYP/NPoVomDGCi8uzgh2bK2ZSlGf23iyFs45lmn4vKa0VXxSnxH6v3XU18jC5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7271.eurprd04.prod.outlook.com (2603:10a6:10:1a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.8; Fri, 17 Nov
 2023 08:57:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Fri, 17 Nov 2023
 08:57:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 08/26] selftests: mptcp: add userspace pm subflow flag
Date: Fri, 17 Nov 2023 16:56:01 +0800
Message-Id: <3c11e8bbf026b185f8e26902acc93c73747052fa.1700210966.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700210966.git.geliang.tang@suse.com>
References: <cover.1700210966.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0209.jpnprd01.prod.outlook.com
 (2603:1096:404:29::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBAPR04MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: dab0ceab-2434-4b55-9a95-08dbe74b2d3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OKO7pgKpyPe6Zii9V7L9e0TrX2KJVJsCeFV4J2kteBHZydIFzFa0v7I+phKhJS4eSsqYabjRCDtXU63dti9HGPmYXecZXZSR9y8X7uBuA+Ufo+ljz9dy9fBzXYHVpc9qyCQxi+eQZgwGml5eKijvzgnzV26tWSnf1ERpzUtoMgjv3SkRfoQ8McsoD4IY51wNpCLICNgWosuYQnBVNHkcBeF1dTB5yCWhhwppSNgkaK7YywAHmWMNM2ndZeN+XqEmE84ePwJXldDuq0d1A4Y1IneTTVVmmpGBt4SyDJbGCEJCtgBQrj77nfWkB39XFqXklkR0uYC+NXr0LktSWKDgI9efAjAarCc6zDivsiEdSBpSKf3XvQHzVqVmWxlqJzJakhHeb0M3dI9N1hCt8+2rVX3Jd4Twj/mAxCo89toLQ9JmsYMZLs84Eg+AQSSm7WHfRAfXViJ+2CGFPrdYJ+jx32vXELegN23nnkl1kYstlHqeSgrpoizQVHrUasiIwd7vfLd0KZmHSUsKddRuuH7wgI41MY7dVFJ80qUxfvC3C0X6ZH41A65rrVZLtb9HMg6R
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(86362001)(38100700002)(36756003)(66946007)(66556008)(66476007)(6916009)(316002)(26005)(107886003)(2616005)(6512007)(6486002)(478600001)(6506007)(6666004)(5660300002)(44832011)(2906002)(8676002)(4326008)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F/hHzuR+mxLtqpJ+gZteSQjHGwjrxBqSrtUu/lyQO1wbHlj4l/sJjQxgfvlM?=
 =?us-ascii?Q?R7PmAoxik5WEsueePl6YaTnDp5Rh/Nxzj6WyeHw/PDKWNCeNd4RkeesLKixN?=
 =?us-ascii?Q?aqNdyaN/IrnSYQDV6n74OH9VlG0JPjbtRWq8981uinKrWMOjSKg/hR38BWyX?=
 =?us-ascii?Q?7uJZyyL7kRP1VkKg4qiWTeezEmNuQzSe8g4jF72tvHdboloapLic+afrxtot?=
 =?us-ascii?Q?3pDrsG62I7mIaLspFNOuATAH1N9St5i9tF4m64qvgIxgxswj4ub+gyWvML/0?=
 =?us-ascii?Q?RD3QGpTAKyofDtosWDQDvGj84zGdmORlktO5ql4FgNYqlQeSimLEUZrZCeAs?=
 =?us-ascii?Q?mJLpOW0r16QxBF/hmk8OUNaFtpu4CLNW9okxOr8P8VXogrwTZbXpbh9YTBni?=
 =?us-ascii?Q?FmiPzAvedllf9s9gNRXBc9NgxvN/ADOQdC9+J4iTVUQorSjX/bbhJq+bw3hn?=
 =?us-ascii?Q?ZEU/yHp99/U116vTX3uyl6732GPRTlgXp9qOkm24jhKfzPPV51ypSP0stPzV?=
 =?us-ascii?Q?QZshZ2eNhcGf/EPxUcEYgIdJ0w5ZOlHWQIMnaaiypiflit2eMjyx5sJXxVm3?=
 =?us-ascii?Q?8n0T/vvUoAuF2lgFBSNQ0P2BxVsI2HwnjYrPAlO9oI9elkSsGyQ1YQ8gHraF?=
 =?us-ascii?Q?E6ukWY9j1jUxzz/WNpW2sNg1y8CxnOHUVVW5CFQVb/vN3SOAEHYjZosLe0Ro?=
 =?us-ascii?Q?avhxgap+Ot39KEG5w1sETUaFY+xa4w4t3RYU325NEBLs8WkmdpMhylYgOIyI?=
 =?us-ascii?Q?qg1qePUCIvrCNz6MzdL5/fo/rcix2uIIEyS6+V7m+dLTkccKZ2XwlWrW6k8/?=
 =?us-ascii?Q?Z4pZWsdAHJObJEyEuWsGLsvIG5EdnvAHFSVTcUrVLlNlwy+wsEkHRTnpcBlB?=
 =?us-ascii?Q?PgwOIRSt52/SnIyCLpx9NavaReaK3lR3bZqOBu0gi4+arLNdq7852xmlgWC4?=
 =?us-ascii?Q?AMIN3w/xPTZbsSZPu8T/KhaH1NZoQQHh88WmOk40uUVojYD/OWEqeFiUlgGF?=
 =?us-ascii?Q?qNkGrOXxoFLbHW1nq+RnCBZ3RcDfV3D7MLNHcgN8k6NGYkTAqMlDzb1FF3S5?=
 =?us-ascii?Q?ZdFedE+412PAFHHyCdBs6D+nVbRMNc/d9hbiPn6eBkxukLdzhYD5g97zexkU?=
 =?us-ascii?Q?q1sTjnGe+/L4dn9pwEJqxhtME1Z2PeNsCa4MXPwocSCeiGr9m9L51lRRgIuf?=
 =?us-ascii?Q?C8m/YWToQAx629KpPiyzsa38xWOZfQkVZ42V0Irt4ZgZzBE6o48TnSsXLA+r?=
 =?us-ascii?Q?4cztOw233g+sHVC631lsMePq4pFU0gqt9NDO77i1sOpHrfqtbhHNHlj09QSe?=
 =?us-ascii?Q?BjGI1/5etdLQol5G9j+6mwyHFPJxZYIO2SAWGIIGXFbZcVCh+2N7wPceB0c9?=
 =?us-ascii?Q?FRcioNa4jCM4hiP09l9+TYQy9SXzmVa3xwg+ddUWsiMBKQ9X/DHJO8pUlNny?=
 =?us-ascii?Q?Nu9XrTHLigiN+VQWHfRDSBTXDher+eQJfy9eVPE3SVRmvk8JikPdXCz9Q03h?=
 =?us-ascii?Q?tcm5Jd1Om5WVaNiyvjC6k/mM66IeJQj8cj6oOFjpOCZVhnYGOfr2NTSdElwE?=
 =?us-ascii?Q?l8bsfpmiOo0DFfw3Qyo0K3OfU4n5JPTzUZ4nmPJLkjaXNgRx0/4ueb4937eY?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab0ceab-2434-4b55-9a95-08dbe74b2d3d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:57:07.5971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUVcUA/HZRs6uv796xrhhQmizXvRZkPc+yo2u4JOhXOYbbVnPvegKOreFCYqOiUEK8y7KEnup4mIpCjkL7ecCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7271

This patch adds the address flag MPTCP_PM_ADDR_FLAG_SUBFLOW in csf() in
pm_nl_ctl.c when subflow is created by a userspace PM.

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

