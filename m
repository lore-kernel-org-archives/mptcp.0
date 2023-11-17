Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2043.outbound.protection.outlook.com [40.107.14.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AB4D28E
	for <mptcp@lists.linux.dev>; Fri, 17 Nov 2023 08:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QUJstndT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIhirhRxkbuGgbrHB73ynVZpXpGNp0SoOmQgknNspHBCKcf+ot2RODFtqxJbM0Xwg0xZmx+mw9kuSOsvIyfrxIGSEp4ivnhU/LBKrQVPRewV5NSsRipj6DXdgap6Rmr5ACPMN9xz/bOF5D+Fd925iwbHN3a2EZqWE7whzpmW2/FZrtrqPLPw280UJmtlEubc00vZxk+gFaxHBAxlvPipE90q/UxkOQddJmt6w4a3FpTVeFieEXdybG0us5p4bsnqc7fHsOWuA6Lvhmz+kHoG7j1EO0kzu8rTEtUPg4omCPYNRLUE8PzovKzESyq6/QRQw27QKVeYtCm9p7ZvjqDXYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vDpT0hHggKqx39kTqVJCYvx8sTIQkI9ecBsqJdwEm0=;
 b=KP/FN3BD3IImLTL7nIibicrt1KbP3kPRiZkAxGy0zbgGy7W3EgtXkA/9zf6PggPGpDVzCvPRXURL/zgLAKSkeg7fDLwgpBuDYQzNQXcyJyRA35FXIrjFrLitFllgUXs4+sfxpY6aox7Gm37dOW2ObR8jTscWQXzf260mqbwaVmYxW6zu1kMZ7lyJ0WZE7a776XZz7Btr6wfiGIp1Dmf+KXlwR8DfbelXsp0gcfsNhah87x4WAHfZBUYS+xxzlkzZW/qWb9YJvo3C3hJA9bFvsDB6ZtgbLJ1tK0o8Y8WtyyUqc0UVSmiwOy/361Vsg+cZGT6+iOX9bjwWlNvDA4EjDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vDpT0hHggKqx39kTqVJCYvx8sTIQkI9ecBsqJdwEm0=;
 b=QUJstndT3LpOH8MTASJW7NwLrtw3PhLrgDRgfxAg4cGkYm4/8a33oHhsx5g0ZembLTVccIVcbRfdij7hvg2IGAo5C7g1goNYfZ/jFY5iRrhGlP5nB1NfEHPRX7Lxx8j8WklIJBQqsyVv7YzCiLKOwTSxCJSHnVixpl1uxbpOVOGOPastTRza8e3SHEpdSeTa5/NX0OgZ3EVIFZ5okMI+eZJZxVQ9QxpyoPPkG73ewDahf90N9DxmMVhDGy4UqQ+7I95Whl3wrFaQK4Yxi3Jg1HlgUz71lVURcm0BF11tF/B8zN5fe+kFOqU+PVdO/U9Z3Xe41R00ZicaThs0Jp6BCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GVXPR04MB9975.eurprd04.prod.outlook.com (2603:10a6:150:118::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Fri, 17 Nov
 2023 08:57:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Fri, 17 Nov 2023
 08:57:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 15/26] selftests: mptcp: dump after creating id 0 subflow
Date: Fri, 17 Nov 2023 16:56:08 +0800
Message-Id: <7c135bd1079953dc08866dc685b8cc80e16cfd02.1700210966.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700210966.git.geliang.tang@suse.com>
References: <cover.1700210966.git.geliang.tang@suse.com>
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
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GVXPR04MB9975:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bb7f7c2-248b-46ec-35b5-08dbe74b4868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FnxPyCiIuvmAeghb76nB/JQ9erl7x+b0wASHtO4OdaDz15jXdbLgqtOMtS6wDO4bpLQWQfaqAV+6oxOemSZ/uORDVFmm9oUEmHnYJfkvgBAzMMcaS6dc5AW0CbJ4xqMoBlOBn97psEAuOQOKh7udkH3Cu79/bYEzKT4xlMuM2fAQHCvX5a2GtbDa4ttYhtXg8KeXypH+v5tVXf8enoDA46tCTAKSd3l1TmHRsawcEhKOcLJDJeB3znllj5jEqeLgJtkXOf5lDHorAsEr2ugND91L0JFqzRTDrq7M4LB5OtJFr5KTvRTj0nBo5Y3xK0Kkp9AROnauRKUn+byh6WEQ3wUuoV/8m1m7rgzP5yZLn/d1v781qvQwn5YeCEi03WYjxvDGNLQRDzcvPy+h6EUKVwKXIIi3rl5MfRZNEtQjFdaQvR9Tzc7a4qx2IXcOpbD69Syh4U4NGCyobh+CyG0f60PsxLKchLets1bVnSnI4A0FeBmTYBQ4/dbb3F5CaTqwPMAcxzRssN+bXwSrjYICMZ7PGAdbIhvIL82ZZ6DVe8ytFlkaxlSdNguZcG5JYyhY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(5660300002)(2906002)(4744005)(36756003)(86362001)(6666004)(41300700001)(316002)(6486002)(26005)(66556008)(6916009)(107886003)(66946007)(66476007)(4326008)(8676002)(8936002)(6506007)(6512007)(478600001)(2616005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9b5q1WVJQ6Z/CPUmxQK3IL+hLOP+tPzeoMcHd4PEBWYVOx1H2upD2sQCCf1N?=
 =?us-ascii?Q?oH10E7dUmse9Qali/io0hGnI5scLzheblC2w9QcQTiSJ7bJTZovmhe3zb8ns?=
 =?us-ascii?Q?r7ay3bEfVd9q31tXY4O6ZwT7+7FxGoAzTC2GktgUp2vzJQXT/2R9yUXw/Ocb?=
 =?us-ascii?Q?W5AhCF8RLa013CjOviQKgsnT4PdxTLGym/ZzLviJVmy7mQqQyKoTSPyZ+pp2?=
 =?us-ascii?Q?+DvpSDsuuCrWcxq+dOSAoZ1rreyFS6XWC2UizgzqeHTtAiiDzdj3RdkafiND?=
 =?us-ascii?Q?OGfGCaGCN246MO2WserdawR1QeUBaMFqqENrHABPJTPcLEatoprej9Z3gjAL?=
 =?us-ascii?Q?pAqnEFnOr+JTL1OB87fpO7XQUn8yx33t2EitF04SWF6hKOxAxbTo4zHaJjYp?=
 =?us-ascii?Q?ajiAmwFhuHNliqWg6e290zQnxHmBF6SikeWh6/QYaSAiADX1+y3ugrz/nRq1?=
 =?us-ascii?Q?rl4zFDDznq8sJHLHkyg82cPBddp3/Kt7ipZDtS/b2uouA9lx6zIOOnXc9her?=
 =?us-ascii?Q?WS0vniXgIzViHQrHmT6yNq8/L53G6/Bc+EkaJvqgQOiPqsEo5/qpe2cA3pEK?=
 =?us-ascii?Q?mxqyezWOP5+EZlQGGiOdxXFu3XFqSTlg+w/V5q58fx58pkDH8+qC1Ze10VTt?=
 =?us-ascii?Q?kSqhH7BCOb011mwcjEd4FCUJTxgKvyNWoGOCsthDEN3QzCj1ZGfqH1hymCxO?=
 =?us-ascii?Q?6lWwuYEpwlcOOeEajqhEITyFQwXy7aBbt34YUJdy8dtm7S72H8W7RsuiY873?=
 =?us-ascii?Q?UQBOmuX9Vlazr3vCYchifSOaJuW9ucqrmU/QwA/CyLH4mLVGlRaqZ+GfvBp6?=
 =?us-ascii?Q?v1NSxihqL4sS8NkdHsyMJrKAEKCXTgvHQfNIfzCGNaZS28qMOoXv1bLzH7fW?=
 =?us-ascii?Q?AD8lgfp1/Zep1P4Q3mcoimvq/TiH2l1avlCUmT065u7+WIUDqasudtNB8GFU?=
 =?us-ascii?Q?dUA92jahlX7PZDrbxjzndO/zACsRDDMysCmH+TD1X6R8bOXCQxo017PStUx8?=
 =?us-ascii?Q?Gc71uAYlrS5zY3VWlwo1hil2xB1WCxjeEzw/qztjziGchDyLksygvQRbqQZt?=
 =?us-ascii?Q?eJwKHgtGQ3fIa7gx/YSagZ8W3WcR6iTGSeWLan0sWKF1qtvK6q83DSBBe1qn?=
 =?us-ascii?Q?j32gtrRPwtGZiZcq7Wcrj39QtdWyD0mLlaXLuOr+jwUjZU6KFaKQjmeQOOu2?=
 =?us-ascii?Q?NgJS/JKT4I5UTCuDlupZRRKu6FMjQbOavlbMQkeTu2Csu0RzfQ5PL0Jk/x/M?=
 =?us-ascii?Q?p9KuDO2T6peKrfxasjSCkVlmZmgCer8h8zfIRE/InjN0vCj5p5zudmT5gQwg?=
 =?us-ascii?Q?ohjR9DrbstZbjoWZo0irKQ1sMDwP6yf5QTuFMNzr7u7VOkmjbbIvL0b1Luge?=
 =?us-ascii?Q?CPt+n8smSMXg0y2cxfQpsMyMDQwoUy347nhuk5V1O2aMplDkfGnTZvI85HGE?=
 =?us-ascii?Q?n54TNnOnwJrZHDuMB5aVaeFL72lYC7nLYt3MWXmxW+4Bs52dFQtCxMCLOxq4?=
 =?us-ascii?Q?p/2WFlcXhMNigR5SGLE7fpILyKYhbNl6OQb8afKbJDULC3XqhRxlaGIoDTeN?=
 =?us-ascii?Q?lPYvt5mKzX+JFsnQub9aSmEZMikv3XrNtZJ8BVGw47vHUDZnJGANwsAVo2JE?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb7f7c2-248b-46ec-35b5-08dbe74b4868
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:57:52.9754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 39i3bE3d5AOOw8jLDAemXMINFffx2XJM4mWtFgjAiGridphLfDHNK2SnkklFbCZmABJR0vTLKLMhETltPTQdQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9975

The output of dump command after creating a ID 0 subflow should be
empty. Since ID 0 address doesn't list by dump command. This patch
uses mptcp_lib_check() helper to check whether the output is empty
in "userspace pm create id 0 subflow" test.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b346631d94d5..4fd1688498f1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3454,6 +3454,8 @@ userspace_tests()
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		userspace_pm_add_sf $ns2 10.0.3.2 0
+		mptcp_lib_check "ip netns exec $ns2 ./pm_nl_ctl dump" \
+				"" "      dump addrs"
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
-- 
2.35.3

