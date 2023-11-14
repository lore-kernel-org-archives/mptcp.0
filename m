Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30E311734
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 07:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="stDQkppI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQ7l1m6AoFMsxcOQ3PATpBXMS3p0hUTpIyJwIng/BZvvHR0iALVTWGOJcXIIMjn1IZ6aHxttqzsaVH9TyrgT0L2W0E/7Ge+izcPy3VBDv/bGEiPDaNfV3cAtfbH43YKHpZYzannHvJxuLQwJtD/OHDCMflxEhAea1gq9fsYcrXf5l9D3j7U8DdOmEqhnwL7ocyush4zMwpSvlVy75O/JOtflG4XQGn0ja+bgCY88HewkQ+4zbxIDwTXXflUke6DrJKZDaT3dABnN0k9J2YZHD0tKYr7OryYpsbfWV2Fzedsayuas/yKPCL+NsWy+vt1JdNm0/OQTfpLokd6YEl6Msw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bof5TGqNZJNWYpE/Dchej1H/il1ztYNYNIBN5dfoyU0=;
 b=SsqUbjRBhMpTp8bU/KJ4h9qb1soHG+unv16pijWknXdnTZAwcdXh1HeYiOyYhoIAl1Y4vjhPCEnfjdoNx3JPVS3uD4e4x3oIJIrXTyoJqP5Pjo0lEycwHSrMBtVjnTx/8UYq0SaDtWgBZ2EG8wS+r14MJ4pVtwwuhrhxLBP/pw6M9tPQcnPf1RSx+jPuKCEUrD5t4Mm3cH8nxUV9fhgIEzotEpiwkk43TBX53lLKSIo6JYGGEzOZxF4qksC2dLF9aYYe4eet6CniPf2wcvPsOc20SWulu9aZomZ2+jirhPA4jVMdwWZKs5qXupvOsW0ajSGgit6OTqUQ6mVfal8upg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bof5TGqNZJNWYpE/Dchej1H/il1ztYNYNIBN5dfoyU0=;
 b=stDQkppIPtFFSBC8d5DF7q2lRBqnEhzvCOqW6q4/PHEorJqX321tptzflq9f/xO8iqpXxmWPpVtVJL2yOAx3PBmk6VXQ/LpInvPePL6qzNS1GZBqWeLSg+J9gw+6+wXcvSHqhhgYT+KfDI/sG71FXxlmKaUiqGQS1SsfxS+vFHeJFnBgDelx1v6V86+VnuLmWLylENM6oeUBFOzpTIzeS37iK0A29uqFxomBbm1UHXl3VvAo1o3DQvyLAV3j/kpjmDTUB6U6n5/a+ZG0jly/GtLVsQJV4Ty49SZiOiLx72is0vDYBaZ1SIm7WRD+5KshHvXrADDZ+/nz/HZqGb3QPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7962.eurprd04.prod.outlook.com (2603:10a6:10:1e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 07:35:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 07:35:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add mptcp_lib_ns_* helpers"
Date: Tue, 14 Nov 2023 15:35:50 +0800
Message-Id: <528a7bef922864e03cdbc0513577ea6053b06e11.1699947341.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYXPR01CA0065.jpnprd01.prod.outlook.com
 (2603:1096:403:a::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a7ab8d-eb4f-4473-1e3a-08dbe4e44c1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SkQawUL8yzSiAGnOLiIz4vn/THCdE/Z+XjHiL1+qUgHwJRWvMfUaz9jdqmLK+83D2mGa3jfLBGdkMOATkXjcK1hrlMxgp4FMijWltO5faO2R07Js8Nt6ch3Kt0V+OoBU5VgX2ybWaLX+qHeHI5fRPEr5OT9gQ/ui+esHgDwERLHHnYwzb3RKrC1/YJMPBXuPsOYiTLcvXPKySRT7WshBneg0dCpIwY8fUiMQ+GL8EnMcvSYKGXJ8XzJtGiBt1D27Pe17WyINf7k9IeO35RSjxg5fxCr8nEPZK8AqX+NyuHpdOra85+x1va/2BE9k5o/WAM5m+mZz2tM4ySHh1wSWopcHKWvjgjb//H2bxjFXc1Vvm3YNe6snfr5T0UTRPzHKZyZymRd4H3vgVfWfhS8sahcfA5tAtmWGlpTgnt/t4ZG0Jk28L8+ng11VIhFKAKQpPAyM9pqair4All/K6xH7xLbE3aBHqK4w2QE+mK7IOEFf0pVp7cyVLhLd+XZVZbm9vdD+R3FYTJK/eDPlqx5/bMvCrSPTplc71leubpd7+t0U8Ym1R8UFL31xefFfzozR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(2616005)(6512007)(86362001)(107886003)(26005)(6486002)(478600001)(44832011)(36756003)(4326008)(8936002)(41300700001)(5660300002)(2906002)(4744005)(66946007)(66476007)(66556008)(6916009)(316002)(8676002)(6666004)(6506007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C7YO0drhGno9cmdUHAqjeJam6PX2/Wy42YK0hOFW9/M5toIIXkcOjj2AVNsL?=
 =?us-ascii?Q?/2ZCPna4Q61eKJrOa1Vm9IJcORo8NLwYgL6ZnFJMsFelFhnDhEBOar3meS2n?=
 =?us-ascii?Q?+QyCrZV8hYL4zCMOH2S4mo8+RrnU92piOnfXze4JXGzE2DFvhWt+pQa6nCd4?=
 =?us-ascii?Q?hf+I/5AUBIzyyd9gwahCo2twgGr0OQK5szOofNtwlRYKmHZFKL3XqxU0Np4Q?=
 =?us-ascii?Q?9A8Tq/CDVL3qUvkh16LA10AnX4jroePlbgdz6wHxvBCShKvsNUh12ZUv5EaF?=
 =?us-ascii?Q?x3bJj4r2kaRSi+ZXQb4Rap9Ppo66F0XKHWU+BvoglkzFVUhn0YLkX4aglZyT?=
 =?us-ascii?Q?VgbnscWYS4tUe97o2QM3FlR3VPVNmwSVpM1QjKM/v2ksrDkmEZ3uJmo2WN3d?=
 =?us-ascii?Q?KskQOOS0lAsd7cG5yismmRdRfu7CBGz8O1sZpjSV1LMfBkMgNK5Bmdf0SX4l?=
 =?us-ascii?Q?2FUQDwIh6j3wPB7GKSaeZPQFYhEOttpDa8+MCtYa68OeXC0bcT0vnI4i4soU?=
 =?us-ascii?Q?1rw0zE0k7f7VJp44p+eepUGez5H93Oi+5OTMSI0EMtybjVnESZT43W9An3NN?=
 =?us-ascii?Q?87VSs+yRc029ghbvtwo8qo3zjc+26kPMWyNClhoql1+N6kXVB87A50vGcNO8?=
 =?us-ascii?Q?PFAqkW+55YDjHfJDkCogk9mx+jK/3Yv4bmNy6yPVm723YlyrDmDp8JFGOzeQ?=
 =?us-ascii?Q?Z5AyL7pgmzAa9L6NFyAHfewy5SLcQww+ljIzgb7p3pDgUp5OnGCfNFbD7LWn?=
 =?us-ascii?Q?VoNWIETr3lBg4pFw5G6HCQIlBOH9hx2KMKgvT+Xg+NO2IKGuwDhcxpzrVopu?=
 =?us-ascii?Q?flRUFog0WatJgytWt78qrlGfX62/eZkY6I8pXgfM2c6QOGmH7Rqeqc5AdZeH?=
 =?us-ascii?Q?Qsx9kOl8aS58Nfu9MdjlypcynsLOYZdUxO74jK+qhdBJNLmZU68/bgYExOuQ?=
 =?us-ascii?Q?FSazfV4FDpBZQDTjRsd8FPjqGCpYdauLPG50LrPCTBmDw3ztxI16veQzU3Ps?=
 =?us-ascii?Q?xnhXtPmbytPh1oyT33KaKFahl6kQ3ZuCCc5+EUf2Mp0uGVXrns/xdYYz6GYl?=
 =?us-ascii?Q?JRgyEBtsUQ17qK+XbTHjsPSoA9t0KHY9E3niuNVl6A9D8BoyrhwJp1Tym/+q?=
 =?us-ascii?Q?L8bld75Yqt3WUo0s+c7Swp3voSeXatokPPPXQgcKP6w0XN+8mDj+uAnOHsMt?=
 =?us-ascii?Q?4+wBQ3wcVNVmGb6+kgFmnxhA2q1IXBNQTfCO7Wz4CGvhOz/L8SZ5XgtULvzw?=
 =?us-ascii?Q?GHcy+OVMTt/JA5tVx1Zv9UponF2bhB8sFS3/Mhm+RIslNu5aVrrftGPv+H/Y?=
 =?us-ascii?Q?TGNPkA+n3RovB18c0cWYaKvN7x5FWR0JCP+vAzZn8ugrsKcqIQMj99cmosJE?=
 =?us-ascii?Q?pfEt+TCp1DE//yKPNU/Bl+vZS9sUxrYjp5GeYTPTvvbnvO5jcdqcePQLOH90?=
 =?us-ascii?Q?e6ufXW9Td7UK//CxZ+HGiwK52zkUXG4rxlGDS+M7jb7rAK0H0GcNqdrt1IVd?=
 =?us-ascii?Q?BAj8PC9Fyfko4gUh1F+9Qj0XhjwTJMzPHAdBG2d2kRn6x/D2Nxj5R5h2EiIM?=
 =?us-ascii?Q?MF1ZFqN9hP9vnbESdCm3vCDSrOmX9DxksbG/+1IC?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a7ab8d-eb4f-4473-1e3a-08dbe4e44c1c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 07:35:38.5618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aeSK43KhQxR0vSTHmirEq9doNYrYCQeD72JJ0V+fyzNPyDwXFAxfvmDENwz+3WiWt6Ld6g5PxVXzuhqF4C4H5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7962

Squash to:

[mptcp-next,v2,11/32] selftests: mptcp: add mptcp_lib_ns_* helpers

add back 'TEST_NAME=""'.

With this change, 'TEST_NAME=""' will drop automatically in

[mptcp-next,v2,24/32] selftests: mptcp: userspace: print out test counter

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 22a436c4a77a..4207ce0912e1 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -45,6 +45,7 @@ client_addr_id=${RANDOM:0:2}
 server_addr_id=${RANDOM:0:2}
 
 mptcp_lib_ns_init
+TEST_NAME=""
 
 _printf() {
 	stdbuf -o0 -e0 printf "${@}"
-- 
2.35.3

