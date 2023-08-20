Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2071.outbound.protection.outlook.com [40.107.15.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F51566C
	for <mptcp@lists.linux.dev>; Sun, 20 Aug 2023 12:07:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IU4smllXxotHIMFDNafRgUOabjXUnrMXsWmz7JKeSB2L9BQMa+mePeM63lkf4lpkhaXdAemy4rbdJ4nmh9KoZkSbL/hhaSkwNgLXudRlZeZvPV2V578bI9azeV1cmKwikfELbUMV20jnExhenYyKo3cAx/cGaVP9mfChAxdRQv+lIOA358IlRqH2Tpd1ChDprjVRdzyiYnLjW2KnTMvVCgyNoafbDpG8pe86WS+nUROzqP4HVRsLAFTeRzTCRxCrxfqL4b3wPZJ+1F6dNvdr1lYCM1JV2WE7ws8/+fimdb1q8JhnbTNv0ysp3pynTFFMWig9DhZMfKiEYUN1MrGhew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXmcAUCfUmOReUSVDfxOt3IGTv+aXSxM6T/pQvKaxf4=;
 b=EGa9aVkcGN+PjO0XZm6oAPSKxBMwYgLfvBkczozoR6wbhD7QnPMqvPMXNNNrEXuqcLeN5h4Ww1f2zW0mWtEVFhtk+b0kA05gF2xGM6EMRIZb08CujX9ko6NT6wcfaLcQWigoa0bX/pu1uwvmZ3E7fPQKH6eD/EaOW0taR912RL/jxTJlfFKxPa1mAJSB9OjOqCeoU8Ym3rh7WCvedBenViRH9DHsSSQLlN7/luuP7D1KaS8hwutpJYzflfl15qU6b84VXPgxRbj+hd1+SEtt6GlkFbOXr3LEglvc8nq4/eJjEyEC9zvo5xIIKIYZhzxD3TuPeEPONbx6kCT4W16v2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXmcAUCfUmOReUSVDfxOt3IGTv+aXSxM6T/pQvKaxf4=;
 b=cZO4LfGQh2NqPm03zwN3p89fL65MzrzZPDNW/jMMMtEfmaBztPGHI2LMUES1wydk7cJmxt1e6nkcii2f0VctGFqy+ifLFl8fd5h9HZEY48mVIxZ7G5h8PJ+8fJtSPudVMvkK2MV1QQexY7gPy3IU0mBeslDYYfoS/XuZYsR2DxicqSjyFwvp6RBrqYr6pnkX1WPujTHk2eZ9atleWVzE1iprWULTaJyc3qcD0jcD0ws8UuYLzbPzW+LP4xRKaxTh9PYuXZwxq2qTdau3ZDk/3JEJpxqavEB2pk/kvB+XMeX15iteMr59cyv4tIztwG6ce3jZOoTMgTi9twrjG7/5yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB9523.eurprd04.prod.outlook.com (2603:10a6:10:2f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sun, 20 Aug
 2023 12:07:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6678.031; Sun, 20 Aug 2023
 12:07:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 5/9] selftests: mptcp: userspace pm create id 0 subflow
Date: Sun, 20 Aug 2023 20:06:36 +0800
Message-Id: <2eb29b7b29b06ef36448b466c3f20cc3b1ba8ac1.1692532859.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1692532859.git.geliang.tang@suse.com>
References: <cover.1692532859.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::28)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB9523:EE_
X-MS-Office365-Filtering-Correlation-Id: e4748a0a-99dd-416f-861b-08dba175f7cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dziuniBLk9cqysYtzpD2UCLECHOaQwe3n2mDMdG+i+xrdB9JyM42ZYBmA7921roWU+uIeFfyqQOiacBidMRVkvuI7C75QHXF3FyINYY0RtZGWWr8QTA5eeygHCIl+crQ6Z99YXDd0TFBHBSJMI/+vEtUT+dhScX2ZQO/Qye7SgIGowa/7FDc0od+2RU8qFGCWtBvMWpILMtbE5y7+ZJeaL9hEJGWJ1nCFuYysL72HtQuYweP6FRuyXLPHgyTvwWHT1nVXyK9KEAkqbaDAqO8tRlbfhvSC2Tr3ZHO+fWk7bMSrKeEOyhLwt4MyCBYE/DmK96hrIyiq6lJXE3KCKTuXHYUlfAWPg2YzvO0f5ai5TwniZmEzSrpRSSpDonQPKhRWhSnl/LBDNP0sm48AXIQAAUhjzyarb9EzJM2e1i1qELgZFEupq9BvjmDkRhDxICNNhPUOlTuy7v6jjY6B6iZ9dTJy5KCJpqWSCoBJZ1FDEmPjrkX6KMd9ei5wSn0bP2kud/cQ4Tl2CAVxJoQJ4RZ9rdQTYqGWDZY3zgKlP8owd2DfogXJRnub5ozypeVa6zx/N2p+yw2EmzDIVsvVm453Crc+Akga+u/OOURTG8RjDw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(376002)(396003)(346002)(366004)(186009)(1800799009)(451199024)(86362001)(36756003)(478600001)(66476007)(66556008)(66946007)(6916009)(316002)(41300700001)(38100700002)(6486002)(6506007)(26005)(6666004)(6512007)(107886003)(2616005)(8676002)(5660300002)(2906002)(4326008)(44832011)(8936002)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iSISfIZ7g+7xLf6v1Ucr9hA4X7YF94nOuRZyy4rYioBkXmoRv+UfX3dmJKMp?=
 =?us-ascii?Q?DdTlkDFgnzMUxCPdrzZg/bDUXhTw64tyaI2jJegjRpuG/b4UdJMSZX5dqdz3?=
 =?us-ascii?Q?goAP1q+EhGYC/ys6dMleS5bWTEJGLpOH0VWVke8tAnehYNWmmJ6EfaxYOmuE?=
 =?us-ascii?Q?WXcrGt15KVdNI/NsGINI8Lr/t/kiFveO4Fg6G/+GFBYcujZ+2CCVw48iPIml?=
 =?us-ascii?Q?f8d3w5gAmkLqapuSnkTozvVF5oFzMB+8v8k6rtKjNwFFgOorBamNngNLXlYW?=
 =?us-ascii?Q?HdUE3PNJdY8dJHt9UN6ea6/i+s+VnTAjoquubtn93l3JwN2Pj6cqCQMjmR6U?=
 =?us-ascii?Q?on9cFXylyPoVUmQwkU921Bas90zZSAg5yF+5GWBpO0WLhJgWdz26EODfbLJb?=
 =?us-ascii?Q?QpHQmgddNdc66J6yYhVW1lfVmuHFDKEfgGtLEJBZbUqLtyNxWfvsqdka2aUL?=
 =?us-ascii?Q?VKbEq2LLcbkLywuGNHwvA7sNCjXSsblKmsnSQ9pByr7CAizfxrPSuthkb9lv?=
 =?us-ascii?Q?ptXzdLzzVgZnmahpgf0hVnpMRnyWhkeS3h4j+Ekq5LD02JFJf/YuBgrJ8fTU?=
 =?us-ascii?Q?gzTveD/7zejC2P9I3Fin36j7gNfIr47DoboF4L/GG/h9qexDDAAaGmBNga7E?=
 =?us-ascii?Q?qJQj1kLuAm/ExHbJugiDF0TwtTNKnIOXhwb4fv50Y/8ETPiYFg2NEULWhKSr?=
 =?us-ascii?Q?jh1LZDl8ATDtBpa5qgQf4j022Dq/iz96Cggfp9/M7YYBmEiQkM2h+Z8VpuJ9?=
 =?us-ascii?Q?xWsUzUDA1g1rgXaafhzHVcbVN2KMu+Zkd//K1d0V5vpZy1IlejmRzjx3nOM2?=
 =?us-ascii?Q?HXVjJDjeRYI8W+shqrBWWtvz8aUrxQ0IEqSGVMKo8JypP+HDKKABC4lChths?=
 =?us-ascii?Q?2bSfPNZukxlgcTcFpYkOrJO6rztCBwfmG155CMaWeF1FnnSmRBQpwJrUgdA2?=
 =?us-ascii?Q?xgMbU1IdlIP3rH3ZGmFrZr+YTdELhb1IlvmZstIZWnIYakWeQxl9Y1wcYmKd?=
 =?us-ascii?Q?TyMGQBoQpHuU4K6GlSN1uz06hEpY1nvWY+/JqoGJJmNkYQUfS+tIne8s39wd?=
 =?us-ascii?Q?Fw5xGp65Cn2RPzRy2BitLkuCeBxVYspZEHqvfxhG2fu7urr6h+bnaYWczxpQ?=
 =?us-ascii?Q?v1XErQ16kBIgcFW5zSIuLs1DqmjpwxePQS//8xB7LQRy+mH6dI0YM4CZA7DP?=
 =?us-ascii?Q?g++NUG+u2cC90C+6/1vd5/p/QewQPtf4yGPxPZ2NGIDm1oe4495zAnfcmnBB?=
 =?us-ascii?Q?ASDLJjem2nt23jNC3oIRIRoD9BGIvhV3rkEGoHbmUjOvage4rnsaxZmtnkWv?=
 =?us-ascii?Q?LTDL7Guuwu1IPJ266FOFqNSqPMqzYD+0SuTPOnbYjmNhlvD7kpNbwG+LZA5f?=
 =?us-ascii?Q?YFQaHf1CDynsVVK9RPMqQkhfZCeLmL6Q0mnnnNEn8hb6V3cz3uHVlcDapfRt?=
 =?us-ascii?Q?v2ZNTO7qX1LvFaZwtrRvLed/MQFNax+QAf+SDaDBX+XnkqP2NarxBiVdaJNv?=
 =?us-ascii?Q?eHEDMDn9P2ylXnqN6rIEn5LAVsw2CjdGViFROCMz5r8PTCQFb8KsFC3NTI4/?=
 =?us-ascii?Q?DSqw6Obe794ebwO/VTipLcJpuFZvQexFj14J8jV1?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4748a0a-99dd-416f-861b-08dba175f7cc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2023 12:07:04.6726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cBlAqoDQEzpHXGOm0px/uLtKRa1WmMvmRa1RqnXWMxnCcns3F2YJp6zdAEa7OMwtkiXuUFtKlkTHOFTAbHLXyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9523

This patch adds a selftest to create id 0 subflow. Pass id 0 to the
helper userspace_pm_add_sf() to create id 0 subflow. chk_mptcp_info
shows one subflow but chk_all_subflows shows two subflows in each
namespace.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 0ca1ae7acb68..22d0c861e974 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3465,6 +3465,25 @@ userspace_tests()
 		wait $tests_pid
 	fi
 
+	# userspace pm create id 0 subflow
+	if reset_with_events "userspace pm create id 0 subflow" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns2
+		pm_nl_set_limits $ns1 0 1
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns2
+		chk_mptcp_info subflows 0 subflows 0
+		chk_all_subflows 1 1
+		userspace_pm_add_sf $ns2 10.0.3.2 0
+		chk_join_nr 1 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_all_subflows 2 2
+		kill_events_pids
+		wait $tests_pid
+	fi
+
 	# userspace pm remove id 0 subflow
 	if reset_with_events "userspace pm remove id 0 subflow" &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
-- 
2.35.3

