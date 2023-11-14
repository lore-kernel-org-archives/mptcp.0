Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCF7612D
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Iyn5Ppj3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEpyUGeUiHV4XD+AwA0VPzrH2WCivGnAsBkl57T9I/l573sEH7WEJElf5/uo4/RjSpYjEOc8Y6mcIsH3ax3DO+pbk5WjDwM0VPf3FxyVfaai9CSdO8xNyRnPTT7NTMiHKhVjscBJuPVCt1F68lLTh0ETy5KuXS6pDReBqd651YrPhbIxIaDhD1Y3EmLQRwCjxzHzk6L2Tq/6cfujxlj/G+V0Yymwhx+LgDobdaX1NcTP98J/G3C7W4nvlvSMDihQ5oUg9yAa2UX7PO+8HhUh7Xch6V20YFzJD+Rzho+dq9Vi0EBbkb5hoSqBtsA9TH+3PVbz51snKjg12+p8G0JqCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZ3fz085YDmwRF5fAVouCfSBd8YHlg8edij7XjgQ4j4=;
 b=ZKfgSvBW2+TpGubj/cW2vxm+icJIY2ouloitUhoKT36JzPDnXGD8gJM3zDdR6ffwked3/f+/CjxXofwoMv9VkL7+hoSCxCo4E7Au1gyDWA6VwFHS4nAwXZmR+XlXnDfxWHhbGVtXeaytIVstUxXxtv0sMoioR5frPGFBgOMa3EdAcL+4gym1ud3DhdClHSdfjpqoYpuLjjeZOULAsnJos4ESwS0BMa3KD/az8NBoRHG1ZI5lr/asGAd/sHJwDm9DBzOYDiXNjyiHhCCTkdTEEaC61gvgiLBQXgqGDN/7ADWed+a4dkbT6PNgWKYhPwsWZrJGV3mI0zc8rSf707LxQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZ3fz085YDmwRF5fAVouCfSBd8YHlg8edij7XjgQ4j4=;
 b=Iyn5Ppj3o+tanZP5dqr01bD9E1kMKHfAfAb6dxyYsIRc6LSW+apWaWNxBraL8bUfHOaUREKkGWEU2GKDYqFdUsxL0I4K+0JK5m674IivIeW1F0MtwrBPYA1hhuNV2oonkMHmq6SD5XrAJQGf90LuDxx4smpHSrn7zhWSVu85NR3cfdeb4LbDL5QnLJzAQFQaxJYXG3YlpHzVXvsYMC4YgeY9ZYW4k3hkZYn3iRSsg8IqOuYcJRenXlIwmLLj8Ba3YiUVGkvRabirDSaG6o7j60YYb2PpV7w2difDIgb6ubhDRX2ZnYy1DkHUopWox1O/g+3Jy81tHWz/KgdZNEotIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10052.eurprd04.prod.outlook.com (2603:10a6:800:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Tue, 14 Nov
 2023 06:36:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:36:49 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 11/21] selftests: mptcp: dump userspace addrs list
Date: Tue, 14 Nov 2023 14:35:08 +0800
Message-Id: <cda7c0e7691cec853a9d183bcace9d5519e0e97d.1699942931.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699942931.git.geliang.tang@suse.com>
References: <cover.1699942931.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0096.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10052:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c293b80-c10f-49f3-7219-08dbe4dc149a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eFojxWN1poT+/m83S4FriBod5glV+YFYMIPmG+BqZVkH89UoZhshtsuGMewW0aqsixFR8jjzIRlW72A9u8TvBEIcnFsEKjgOATsc1FztzN0bnyFylPDQYRDKOwZlCGDKGMBsWHAF166Pc+4BwUWzoxI7uTe1xT+wWwI1CLpYUjjWExhrHo5bbDTuXur+zwqzJSAMitzhZwKxyrrF32kGRix3WmF9HTj2TjObeMV+dGmxfq9WroIuqusgTFc0GtxFcRE2ZyNvCn9uogODOVzN9Dio2FfONyBqEEWliJawx3E4goUmaaOYYuF1YrCttyE3DvXkK61hXuZKFwYLXEHnuMOy30iDHMPJaXxYjW3rtk6knXA0DIK1waKsWP6XL025+E30RHva9MkEq8cdOPgxaTGoQw4z3TQl1V0X/wpqyQrUfyK9PE8dHL33vUYdd8Tu9kXaPdooI4ySY1OSTk9yo5mKk10F1O1L5+NuylgG13cHOohl+TS7gzsOBdvzP5NIjpj3/C6li0n6tTjZsBbYOjTXqQXzBsCnPFN46iCzh3ZL09eUx2CuVzShc991qv2S
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(107886003)(38100700002)(66476007)(66946007)(6916009)(66556008)(86362001)(36756003)(6512007)(6506007)(6666004)(2616005)(2906002)(41300700001)(316002)(478600001)(6486002)(5660300002)(8936002)(4326008)(44832011)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SRktrqiAkYlmXBjFDFyxglepEllYOwpeKi2dkB0qIdRWvQvLlQU4fSIZwu4e?=
 =?us-ascii?Q?lAx2lrw3/hrzmy4kwaHbKe02GHxhlpUgzHj08koO6TfFdLI1R3LcoWvguQyY?=
 =?us-ascii?Q?CLBsvdF32IQAD6MfBn1pv2elwmDNgd9+lvjnEGf6gmVKX9aNPB5yUhepCCcs?=
 =?us-ascii?Q?X8sd+BeK7QKY6q5gYo27OEygp8F0E8xjqXmmzXwUKZvl5i/F3FHKu594Zu8+?=
 =?us-ascii?Q?pmOMbn38c76b37KytAC/7XECsHezakqbFUyEJVOU4j9tPpW9WT8AmIyoa8ZU?=
 =?us-ascii?Q?a4ZF7fMbjJXrn96PmOoORrLwBT9TccBNsr7vndkBhqZtuuuQTW/lyE1BSLvx?=
 =?us-ascii?Q?ChTziLmw3vLRXoDHZl6Sdj/EZZdkLJanTyVrDJhtc3qclw315FzuMa7S5vJu?=
 =?us-ascii?Q?uriWxLTUcxIrfrUXufGBqDX5BpBRK9avPiqKoourMmFO3YEN6wwAZPC0/ymm?=
 =?us-ascii?Q?KgdZGfJkdMfQ4NB3DvpKDCAoWCmcEC1T5tM5IPYX6hv2X9ndby3YKcC7srEm?=
 =?us-ascii?Q?rFM+caJpH9AdEf6Jxg096QKKi4jEBzjzgtY76W+1PRYp74PRHkZ3w9De6Yct?=
 =?us-ascii?Q?tWtPF6kKuyQ5UuqP0oJW5p4WPttoQ2ql0YZAW1siU+O0c/ouzCNp3HnuDmqH?=
 =?us-ascii?Q?VKvnGA6MyUoBXNgQZpifzd9TMkmKbeaxHiEME1N7hsFLs8mpxWQAWA21pO3R?=
 =?us-ascii?Q?OkFxO8Itv/4YfCiWN2BkEEtYaGuppd40mjeqBBfKS2QSf0v61jCcqTeBBMNO?=
 =?us-ascii?Q?TMhdj+CNIMY1s4BOv8peB8WyEmJk+uuWQvfH2cogp7pSQINEGh/9llTF29kz?=
 =?us-ascii?Q?Lnt1VcGF/7mUO6vy4fZoK0f4r9c+e5ogmxN+GpzA6+luy6ucx9lcIjfbu5sv?=
 =?us-ascii?Q?rRvnUrZI0+rePrfXxx/e3p/6JibsQ4iuDhXIv/TULnwcFvbopiqWDApBzZho?=
 =?us-ascii?Q?v/wxstTfZ/rooiOFAeICz8ToMWJOSGLF/2lbMyDdZwdW6UgBAtyX5pltCwBc?=
 =?us-ascii?Q?2m9vC6a+6DS9UfnkaPJVFZ+VKYY4rBjG8DKJJEkha6Zn0su6ZOW7fPBGssQU?=
 =?us-ascii?Q?nKu4rdbvhNdZNP8ZmXPY/8fnSBk0ASw8J3DeRs9H2dqsL02TlxmpjSUvih4m?=
 =?us-ascii?Q?sh3uSAp3pYn1k/SXHGpIA6TzgswA4qxGuyv2dB1ZTT4gbuahwNHXC1xjjDSb?=
 =?us-ascii?Q?OlkeTfUwuiucChopQ6j/DtsdZ9a88JktlEU+qTT/67Ivqu94+WgtHrwx6YHK?=
 =?us-ascii?Q?US+52p/9udLzEO6EYZGPqe6DaH1dF39WgcOWZCUoNrTH2/kyWhGIos5DSvnC?=
 =?us-ascii?Q?ACt28y6sCnjdIYre28UloeF78+k48HNq/FKgVVdm3ctp9EutKdqdjDSfIEtR?=
 =?us-ascii?Q?png56CaM9ovdEzvYfqhKnWBUDjIGDLDrJMOzk0yOYkZ+zsuZr15blHQd+DXi?=
 =?us-ascii?Q?LCdsLXnxsW+l5RXc/s73eiwLE+7Hb8gtUCt4VppsPe2QDLJtOaV63o8Jhbmd?=
 =?us-ascii?Q?p2Tx42wTzLdc7l9AAaIL8zzF6Zcxhwx43ZMiQWyyuHy8itz5abf89iLTRSTM?=
 =?us-ascii?Q?v0LiqrHf4LyedbpZ8BsHVoYJkuqISXxXl+sedmHfQiodVKwBD0f+zIltTkT4?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c293b80-c10f-49f3-7219-08dbe4dc149a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:36:49.3901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fq9VIFhKwQpvIgz2dZXyW1o8NlcviLj+XgHk8KznjYRlWWOf/RWa6o0ydh9FlGEovI+CH6j+XIhEMx923ZJKHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10052

This patch tests newly added dump command for the userspace PM. Add these
commands into userspace pm tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a46515c198af..f5c51e74417d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3406,6 +3406,8 @@ userspace_tests()
 		local tests_pid=$!
 		wait_mpj $ns1
 		userspace_pm_add_addr $ns1 10.0.2.1 10
+		mptcp_lib_check "ip netns exec $ns1 ./pm_nl_ctl dump" \
+				"id 10 flags signal 10.0.2.1" "      dump addrs"
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_mptcp_info subflows 1 subflows 1
@@ -3430,6 +3432,8 @@ userspace_tests()
 		local tests_pid=$!
 		wait_mpj $ns2
 		userspace_pm_add_sf $ns2 10.0.3.2 20
+		mptcp_lib_check "ip netns exec $ns2 ./pm_nl_ctl dump" \
+				"id 20 flags subflow 10.0.3.2" "      dump addrs"
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
-- 
2.35.3

