Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20066.outbound.protection.outlook.com [40.107.2.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAD917E0
	for <mptcp@lists.linux.dev>; Thu, 17 Nov 2022 05:31:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPFcAGEA11w07TVqlHD6WAlab2arzaEqhnjltqlI5WyHm42xyE2uDuF135a3lgMZA30/eqy6YlcMCIATiV2qlPEnWTSTrvWsPXzgnx5tB8nL7Pw5K4qANitSpNf5QQEH8k1tXlyGrN4bcmlxooPHQq/h90uvnb/IlLTJAJhJRrsr4HOa+mgtmog2BIfrNYXvSkFlLSrZmIfrAS+r8m1JgXwjeljH3S1o32kGMso38S1yijD21xytGEAUBlRsPR3Di0T9YT9xEIVCuTjRvRAbZFQd1RQLpUshzXUMdStiBn46ilH7fxiEls5n1vgvzjrFdMOvVd8e239Ig9/yClSvkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFURh1JYxzRAGM5bGz1I1aiW1H/7t8cevLZzxUKj3Hc=;
 b=U0PgCsLJC1IzSzzjFZr+6Pl+WigHAqzS1fWupjIZWJqWazYt9zVAzbcV4DzrgbtqyH87l06qUsOW4PMAKaUu6ZKkGg/IwRaL/MtoBZq4C0pzT0DVPIIwKA/4w5YlS20QShIuFw4NzRvsGczYXV/WzJFXqul1qZZO13FhCPFia1Z+XkY+I+PuECJaZ06Gw4OxYzAUmyq+f4l+PKhm6RtPHkBSmHGvlUJGKDLLe8XCfc0t0yQ4aVZeP4R7wAQY7neLT4khwWB7oDtjDTVe35b3Y0rNcktFxEsAxDaro3X2X1GUt2KnEG8BRod3h134w+FM/l4GYrrq2IlPH1zwTo77Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFURh1JYxzRAGM5bGz1I1aiW1H/7t8cevLZzxUKj3Hc=;
 b=bSVz7IDNKnKUuX5jBfoqVDVhz8shN+gtlmvywr6LC07Gz+CY7yBeyH9aytZfEZrrmgHO1Scev8UJ3kMM97GUNadtVP6ZuVXXJu4n1sYt3HVGAAtmRdxmSNm1+gUjPk5kug6jUBgE39dbbcizloQ82dDpTT6HnaGynTmFxD2OveCcnn0GJmuxKEwC4X02Kn4/GPL2ChJQMdFJB5ynqW0TUf7i4Jf4Ql6tIvtMpAxbR+eMsGkJ2IvQmDus67V9M5g+ujGcAnW+nT9jxYXlWl3AI3dpe27hefVZAshNZ5cgZJZ0NIX1QXu8+MXcmKx2xn0Halz7PV/ECkCku8t5ogj3zQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8286.eurprd04.prod.outlook.com (2603:10a6:102:1cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Thu, 17 Nov
 2022 05:31:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5813.017; Thu, 17 Nov 2022
 05:31:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 2/4] selftests: mptcp: enhance userspace pm tests
Date: Thu, 17 Nov 2022 13:31:32 +0800
Message-Id: <ac8f37d13925eb33338c99d770f16848ff8f1b68.1668662624.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668662624.git.geliang.tang@suse.com>
References: <cover.1668662624.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0215.apcprd04.prod.outlook.com
 (2603:1096:4:187::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c742ed1-91f8-4184-83b8-08dac85cf5eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NCtrVCTJ40s1gss+bStinlQhNDJWTKW9t4o9IBnmUlXayh07LkQwa8F7fNB6aktnE28Jd5IW+vq+yhwkubOU5KJN4LIQay0cOPkm+I5fa3xXWSV7kPtXH/GaP0++UOIguDpuEZzYLdeHTZaHgkwZw2YZjMIYsVJKoOOuyhU811lraM9rTdWO2HI2sVPaDPiyVt5fPnjZatS/a5v5blm++Cn/2Sfcfj3IF63zyH4zyMppQ25qRbvyE5E1kXUyQJD1S6QONQ2kXzhCaqGUGPozcnyIO3mxnBuZJ4wh3Y2u3qQLrCKbk48QlCp7uFk5Iv0Hz0rNV6J/IJUXZVUGmYPA/G/412QgY/J78k74rDBX2nQBXvZOdqbBjjPNa5dtTIvWQe6bmqTbAP+l4vZfZds6YRSyP6T8YDt2wIR89cj/wFCAoxuypQ2obcZHXaroSt34LgbQcJ4rN/qpXRdNbBvLBWPurOfbEGNgO/+2y2MByNauoi5APdxg8CIp5vMIrZWSFFpBXbFS0kmFtOheax8OVTUEqlYbbpVg2Ru72OLSkwy0XJAgjlVY68il6XlX3nDCvqdgF3LTJcXH6R324fcjfrzguKN83MI9FEm7/SWtNCyXhiRS6GJEN6sU9xNJli0JKp7Bb6IpRgPeQchYdkZzxg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199015)(6486002)(478600001)(6666004)(107886003)(6916009)(6506007)(316002)(86362001)(6512007)(26005)(38100700002)(66476007)(66556008)(8936002)(4326008)(8676002)(5660300002)(66946007)(36756003)(2616005)(186003)(83380400001)(44832011)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aU+iAWx6pDlezInDC3lav2spunGHz0PcYRTptOFnhfeHLondpsT2UkkqshD6?=
 =?us-ascii?Q?FhCdMZodpzB7j7YWi7oYdQaJJdmQOR6hut7XtaMt1jnys7J7a2qon0eHCcb8?=
 =?us-ascii?Q?uTkmykD7Haj1PW2VNYnNNys9uioFNHIQzSvGRlRVcML27Is1/02MW46JBm4l?=
 =?us-ascii?Q?wwrajXZFwY4Ok1hH86Q6ErnnOSWUd1ZdklXVxF9ZD6+prPNygtx6fTOMEQRl?=
 =?us-ascii?Q?Zrc7DCiTPIhXveWnFOQqHoRgtfJN8Jh8WHy8oct2Li2kyb/OK/3zt32DgDon?=
 =?us-ascii?Q?NxNuTgTq+N75+z2Kw4WTI543Rv72yZ5WNFIcoqYnGRF1cdxgdNhh+yOXglJp?=
 =?us-ascii?Q?GVw4AkOetMU7FVzbjpnDivVgN+4kzNNmqGpj4Ll0kgnaOtZwVgBbhu5helW0?=
 =?us-ascii?Q?M53cfk2MfcxNuxwfIZX65Y7Cmx160hy6K5IhuVwsMh7vGxoefOh3nKCGggQW?=
 =?us-ascii?Q?9OcrnfTXzKonyS0tmjVwgrFq3iEk5F2sxVnLMhSjjwWzfcKHYAyWG1S1k6xV?=
 =?us-ascii?Q?s6SKhqw2D5sL2YAI4LCzi03BEcP/biB7XU+C3wVDU3GkWaCO91lvDcrcSlAn?=
 =?us-ascii?Q?r7md1v2f7YbMWyBXHwfUsVLjqDfhPId37iqcGq/B/3VqIa8JchODZRRjBx+b?=
 =?us-ascii?Q?/2HCcrTFPGt2cBj6dqUZol3kpDyl9/vocLhMs9ZA0lnAv9hM4t8Wl+ikjVjG?=
 =?us-ascii?Q?s3Ih0KkA67md7aqDz6L9f2SUdvwOGnXRL3cCizllTwTcOKDmh5mz4M9/W2fF?=
 =?us-ascii?Q?q9A8lXiTtSIYOIjykC3CkwBX9Hw5AuQqjdf25uV6+BuXEygM3FgENiG20Cd8?=
 =?us-ascii?Q?0RbPnfUyLSAEDPo82zg/+zvyp/1KM2lKq7hrJbqXCUAH4wISoHCIDT2ko/N2?=
 =?us-ascii?Q?d4kIXC2rvGM8j5xiMcl73xAG0veKsxcb0UYd9G0v/JefIEnjhNSlBrsSu58+?=
 =?us-ascii?Q?JRSRaOWc+QBg3K6fULTXd4DbJ84cQioX7K71bTN96e9bzmMLWJLU+iv5AhkB?=
 =?us-ascii?Q?Q7fv96g7zGoj3GBCWvEpUm5qJcqkrZi2lHfBIXvzVOGIY7j/aauyJkJpFiTD?=
 =?us-ascii?Q?SbqybWXhlJ3oXa0Vg4nd+AdxQT8FoZdS5n+rApRjkcAl1u0KV7SG6bCb5nfW?=
 =?us-ascii?Q?cAcEuCrk/usOr3EijdI5w6mQ4HbizF7rfAjvwlSZh3RP9uyzTKCXMxjgG5cx?=
 =?us-ascii?Q?dBc9SX3pbitPZRcuaneHpWkVakr0IhmA/p3S1sZmDTP34YB36f7D9NXS7Np5?=
 =?us-ascii?Q?5v8T5Q7UL2SvnH/BDvKQg32fId9vW/hKsfKN5D+bTybirgH6Sp7CqbT9HYJN?=
 =?us-ascii?Q?yoeCnPcr8eNfcCUJ/HSE9sWafMFSWfbvU/TMlAaGTqTPxVTgWyHfAp1sKhNz?=
 =?us-ascii?Q?o6l47Jtcawqyq8l0nNzS0NtcUBC7nGOGynP81/jNmatG2jjQkwM0eQhDbngM?=
 =?us-ascii?Q?Vvrj6j1iTY1WWDHssvDoRYhP0piP6njBOlSjI7+YPNlpmVxxodG0EGPd7tWE?=
 =?us-ascii?Q?ddI8ZnPUcYLI+VqQlWv8oqreU9KTmq7L/S6QA+h/S/vPiLqtSXkVFIaIkg/x?=
 =?us-ascii?Q?oRjaEN+DJWfKhqbHV+T99fMcGpojdMnkidsEHzjV2DkvNiGuXzHKbaXPApzK?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c742ed1-91f8-4184-83b8-08dac85cf5eb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 05:31:21.8651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+wSpO8/ks6nVfVvHIjGTLRmZNs6om75wkMwdp6VX6EKpCTgv66fGSaSNgzqG0hyfSzpbUUMC52fT+Uh/1JI9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8286

Some userspace pm tests failed since pm listener events have been added.
Now MPTCP_EVENT_LISTENER_CREATED event becomes the first item in the
events list like this:

 type:15,family:2,sport:10006,saddr4:0.0.0.0
 type:1,token:3701282876,server_side:1,family:2,saddr4:10.0.1.1,...

And no token value in this MPTCP_EVENT_LISTENER_CREATED event.

This patch fixes this by specifying the type 1 item to search for token
values.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 3 ++-
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 7 ++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2a402b3b771f..f10ef65a7009 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -830,7 +830,8 @@ do_transfer()
 			if [ $userspace_pm -eq 0 ]; then
 				pm_nl_add_endpoint $ns1 $addr flags signal
 			else
-				tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns1")
+				tk=$(grep "type:1," "$evts_ns1" |
+				     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
 				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
 				sleep 1
 				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 5dfc3ee74b98..08a88ea47a29 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -172,9 +172,10 @@ make_connection()
 	client_serverside=$(sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q'\
 				      "$client_evts")
 	kill_wait $server_evts_pid
-	server_token=$(sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$server_evts")
-	server_serverside=$(sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q'\
-				      "$server_evts")
+	server_token=$(grep "type:1," "$server_evts" |
+		       sed --unbuffered -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
+	server_serverside=$(grep "type:1," "$server_evts" |
+			    sed --unbuffered -n 's/.*\(server_side:\)\([[:digit:]]*\).*$/\2/p;q')
 	rm -f "$client_evts" "$server_evts" "$file"
 
 	if [ "$client_token" != "" ] && [ "$server_token" != "" ] && [ "$client_serverside" = 0 ] &&
-- 
2.35.3

