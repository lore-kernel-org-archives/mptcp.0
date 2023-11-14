Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2041.outbound.protection.outlook.com [40.107.15.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC97612A
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="v2yjGATC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTYwZYvOfPDk8Fa1OZjQwTYFh6OXTRT3fF1VFnWRq7UVAMe0Rczs0m+SS79HuzdnH4mmeqQDzzjuYKUrbXoFt/M8RVMVqgRb6DlfnItl9RK2G/vh8QiF4PpQkb9STypCVqtFx3+iYb9bJ3N+mYU6Hagi0NyhbFO/RvcLJo6YEbQLtE0k38Obz2sIOFNIe/m9oSz3jprQOrxenDAxSGD4zcdyde4j5K8R8gLA2jmA+xd4VBNglHMaymrBvZfOthfglSg5K1MsaPAkS538Daw+qIKXru2F1hhbpWUOd4gAcXhrWrvXG98TnHuh56+4FqPE4F2SG+sEM1QhWSQh1aDdxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Crt14c+XfXZGr+AztNhi8cZ3GTw2J6SRrvjLnY6374U=;
 b=RIawFyWq5hHyuvYlG8fRfTDjcf/uVmWDJsmqbhPhYvAOgRWTOg7tJMEJr3XK3wxUVgB10Sh1em2kmFZB3UmWqneDwfw0azF+Y3ZqBKMdbYPzNF6Qoire3OjnZq8XIWvf/U+Sg39F1/xRVhd1wJSW7E8IsnP+/K31HW3mHYzzY21KwDyxiHBjCTojZ00J5F5KRfLMaADzCy6cg/loa2yC2mZaqL1wpq7oiQWFv+BPkmy4q0GijaOd+jZg500dSxQ5bno4/Q+6PNkNJI40sNoFopXpJgoNaa+M8VTzL3YrZt6i9pSPR5mXZ/0gfK7Lkzbcgr9TfbLMZAaGkrJnwDw1QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Crt14c+XfXZGr+AztNhi8cZ3GTw2J6SRrvjLnY6374U=;
 b=v2yjGATCgVhPag/s+78F4lWQHEUE7otJU6L6lbllXEjaWYD7iE1Gh/y/Usaneny6c8XRYXLNwPxpDHIZ30is9Z24SZHLXLYDZKQP2lshX4Sty5xyTrv6Cee1FnQmNLSaZLVj1wKE6SQ88kxQdHJ9YaPiGciobiZ6P+aB+bUiUwtNeC3w6FgW1eXXz2XL8sTs3LOCntlXPa5UbVRAsO9Jmbp9ModUK8ht1z/688drzK5pt97zMYlgLt9ysfmxExyPZI71LSGN86I7V9U3n7V8RwxplrAGurfQ8woB7NfxLZbqgzxkOwuAVdMhfLPg28/SQRanXLyznL3KhK9IKxV79Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8480.eurprd04.prod.outlook.com (2603:10a6:10:2c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:39:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:39:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 15/32] selftests: mptcp: sockopt: print colored output
Date: Tue, 14 Nov 2023 14:35:34 +0800
Message-Id: <d8301408312e3e0b23f4b87bb63290f8a16e4358.1699943337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699943337.git.geliang.tang@suse.com>
References: <cover.1699943337.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: 97aa20ab-db6d-464c-5f48-08dbe4dc81fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1UqYOZT85WjCQ/RS8vD7bX3XvsUMoUp7gatiGgsyvypEFsvZR1bxpd3OiOOiLqIYYm1pHJKUzgRYhcv2DXhna/iAl9A+yGiJzuvqwxXezscL7uNWOijT/yFdrSG8ALjfvdLRgKRanLYjqIGBA5FdpPpj4oTtmTCFL0wDfblCJ/loMZ1O6pN0GJwAyHgvsRIr3Ki1ad9YTpR/OhTsuGIYAwyA9JZdaI1ZgAxWC4pPhmprvKevrhp0VBS2kJAdJCtUgRvUHvEZiDNoTW2GOIlqnu4TX+QLHgvk15QCZ14osgHuydBoi1hn+IgJOxKYybLPaxgLnBMmdtfXFJLXkgaavjg37ecuubtPD0BUsLZRge3dLAELNgrWK496d612beq6xmzwyfIWr3OE6OoZBJhj7FNmjUwAZyiLsg0cvkJnFXUuS6ddGiGKTdrD0OSh4MarLYxfxBxOCI6p36DHGZZGqxFuA/WuhM8YjN89g2GKABY2H0rLHNbATaQkr20nV67kbgyc5bbq+t34kw0tU97goXI+OWhAgay5fmDqcWIZtux31jgOwHRBdjYAjN2ETzdo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(2906002)(41300700001)(38100700002)(66476007)(66556008)(478600001)(6486002)(86362001)(66946007)(6512007)(2616005)(26005)(107886003)(6506007)(6666004)(83380400001)(8936002)(8676002)(4326008)(44832011)(5660300002)(316002)(36756003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r8qoCJNnUkX4GK5Q4OxLzWcJi8Rn2+LFoZrWjVxJkohdpVkij74gWfzj5JCY?=
 =?us-ascii?Q?U0CnGFeac5QfryFkJgFrEA+aZooYxpz2mu3DvVq/Jtm3FStO7hLJ4VSY0yBP?=
 =?us-ascii?Q?EVF0varFNvkjOj6DEmh4btc57X9/kg3WMFE+PQhWo2KqR5hsUNXsKHsMxkkf?=
 =?us-ascii?Q?90Tvmo1WFnrltAZkNTZSMpL9fsotMfpNV73qvrKAW8xednillPfumD6fR1XZ?=
 =?us-ascii?Q?4Ls5sMI8qpyOnz4Rpr+1ck6ZWpYHKDPWwPq4hmVepp9FitoLNj8LyMRjl363?=
 =?us-ascii?Q?089jzejXyofcNvnE+oBKHTCkPwu5JHj5A0tFboylUD51hAMg8PWJjC8ZgMGE?=
 =?us-ascii?Q?K12m/AnVtmrCW9TsM9ZuAvRZh8pxE02zS3wOR51iBPAeDbZymquj7gm96XRd?=
 =?us-ascii?Q?2rfke5amj+OHtsrWXHovOej8hxtyeRpK8IIOIc6eZtTFz4O3U2czy+T5hSaf?=
 =?us-ascii?Q?o1vR2boejhyOsnifebY3e+BiGoPtW2njnf9ci9itG3xveYauWXVIhYnmJVAd?=
 =?us-ascii?Q?dgqKCvsx1gbPFpjb6ZgvPiygBAhYJa6vFtZDq0wOmx0hGm8l4UjnaZ+OCfEp?=
 =?us-ascii?Q?aBi6skJpmlDKBij7PbsPIBvwT4qsLp71H6piJFBNiDR326xi2VC8WuWnDKS9?=
 =?us-ascii?Q?VOnWGvunYbrZFWfLdymmeRN/4xgqxd3a6LioXCB3kEaCLhJDS7e3mz/1IMZB?=
 =?us-ascii?Q?k3PvH8nVGsBgApPQSORXh+eN9SZQZBu3qOmqzwFNEU3MCWuFM9TqbExP51X7?=
 =?us-ascii?Q?ObI5ivZCmnTrJUKtDRein1d519Ld4Knidw4/4d6LSOjsxyYQE00ZNwzfXYMj?=
 =?us-ascii?Q?0X65wr+8STZ4CKACJk7Op9uPJO+AJQZVM/gSGKNqK5/QwNp++WPyo4mboVbU?=
 =?us-ascii?Q?T8pv2h8IROox8gWR4+rkiwLM6xhDcq6Ut4xrxYtvp0e0ddBuImKIDMgibKn+?=
 =?us-ascii?Q?UyCLqnUtHu40qCE9oxyAIzG4nsC5HL9iy5KzODE6x1Hz4fddJoTJe2MmdPji?=
 =?us-ascii?Q?kglLOdwaEujrzy0wMyQQa/qwx/Ckb+pR+h7jvY0rnKFXF2q3So8GgLa4YUlq?=
 =?us-ascii?Q?DoeHL2F9Wy0U3FtrkTBfz/JhE/uMS9A7r5wAZVff3cXad0x6OlS6O8RhAUCC?=
 =?us-ascii?Q?QNwZVXWVMSYwv6OoGsIjrBFGVdNVc1XXMVZTqQS/zaikTrJeAC9WIytXOBZk?=
 =?us-ascii?Q?xnW3/RcLdfK3UDtFd5Gb57eZjzqwq+PL7phrILhu6ytQloyqdGa5OibyqVad?=
 =?us-ascii?Q?bxUyi2xHodbJ32LQi4PUmAFDRed9KEp/bQHEEY35jG2IGRWoggJ5+l6cdqw7?=
 =?us-ascii?Q?eKlBGyve7+tUdiGztmjif9bmUpPQ9EdkP0Ne5wtpSOnJbmFHI4gaubK9f0Z4?=
 =?us-ascii?Q?PVRBvRL/mIeYpFwjXZFPSfGSMoMi2LlYsPqNt7vRMsysRIjTmrE7qojlCvV8?=
 =?us-ascii?Q?wBxIr9kXiTjn5xoThJxLCPjlpQC7nRR25bvLm1wjlI5A4jnYPp6PAGzCWRe4?=
 =?us-ascii?Q?ADVPsJoCShybE9qGZTFf1SIQuc4NAndAPO+9RRXmi471+Ylfg2iIU5err4ay?=
 =?us-ascii?Q?kkWbIL9L6lyKNZrtFQ0NfaBBFoJw5orK4an1Dyhy?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97aa20ab-db6d-464c-5f48-08dbe4dc81fc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:39:52.8995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fM0+sX03S0dnPeDoGiK3JYCDxkfXzax+rGo2zFI/Sg2oGf+E0zFm68K958CIy7KAp0FN2+4xMtX8ndYVPUgQaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8480

Use mptcp_lib_print_info() helper in script mptcp_sockopt.sh to print
test results with colors.

Having colors helps to quickly identify issues when looking at a long
list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index f445fc685b86..d03f9f9daa39 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -290,7 +290,7 @@ do_tcpinq_test()
 	fi
 	mptcp_lib_print_ok "[ OK ]"
 
-	echo "PASS: TCP_INQ cmsg/ioctl $@"
+	mptcp_lib_print_info "PASS: TCP_INQ cmsg/ioctl $@"
 	mptcp_lib_result_pass "TCP_INQ: $*"
 	return $lret
 }
@@ -337,12 +337,12 @@ run_tests $ns1 $ns2 10.0.1.1
 run_tests $ns1 $ns2 dead:beef:1::1
 
 if [ $ret -eq 0 ];then
-	echo "PASS: all packets had packet mark set"
+	mptcp_lib_print_info "PASS: all packets had packet mark set"
 fi
 
 do_mptcp_sockopt_tests
 if [ $ret -eq 0 ];then
-	echo "PASS: SOL_MPTCP getsockopt has expected information"
+	mptcp_lib_print_info "PASS: SOL_MPTCP getsockopt has expected information"
 fi
 
 do_tcpinq_tests
-- 
2.35.3

