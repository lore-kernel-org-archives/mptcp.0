Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FD02595
	for <mptcp@lists.linux.dev>; Tue,  7 Nov 2023 08:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="quH3M9d8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaNpoXcwAG3YBvcbbnTSz9qhCm+owb0RDcHG4rGRyvGQUTBkC0LL/eokOZ3PYWr6Wr/QEtH8lDQgFuQTKC+C09f+37kYFqjeDaEDKGJQj3Qn6hPuVB8RG5cVtm/eOu66nhQxDx7viuEg9GVX4e2bejLDYUGYerdmj6HbMHEYDKCn7YTWgGVrigU31aNM0BLCpEhS0WF9DLuW8sPRgLUCK2K/4cEnSNl3DwC724KOb9Hb+33ujvyFcXTmhZCc8OqwL5DaSXuC3HIMt09pn1Evjg0D5D1dWOssUzBFhBnLZWCbH3AHCw24IUcvxzf/MyGDK9HR4bqd+1mrBkikv/XchQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+/ZuAXfHSyv1DrgoNaqFzwvPPcuB347ktDYa5YTh64=;
 b=aANE6u6dzP6bmY80cXYlvBR2aoFqkGG5Dgv4cR65gkb2GuSwSrayaBSdQG4bU/oRAxNYUkFhjXKG4xdZRbgat94+zbNHxKPKZLqMHs8x/nf4MiK/wptghHnaI9Lnx465WkISS2zBhhft9cIugPUExuGGCKoDdlNgvdiALTE5LzzGr+GFEMSxFSEr9+GMXPLTr+3iQ7DyJgUJYvCxlsS+yuH0MpFzaKVlV3pvOEmcvlMBh+vOMFacGOBTWq0mMFB8z1GMmrqH5kHSXAI9E9R0AHp45l8yRasG2GqVOYVe6cALfEUB2wJSisCCPZ/plhrtwdFSYcpyWrU/0YhhUv250Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+/ZuAXfHSyv1DrgoNaqFzwvPPcuB347ktDYa5YTh64=;
 b=quH3M9d8jdCmGFg7HlpRWrNF7Cssr1rSiWvGQ4Xw9HJldpsFVsYkkC/RBkalR/P4SYptKJ3fQ549JfstjhRx+pOOBUZZB6oaDXp8AenMicqrnILiuOcYk5JECpHqKbI0uOUN6gR8zV0DeO2QrkXhWyNO+8DlqKx78RV78tD+hoJlyZCGTEchiJeNayBNrLL0Ar0vuUwWxrToBhpLL7qgAGGcKpPOVlrU8YlI7ie4pNevoQZ9CYkC+86xfRgBdOmp+/ta8hcQQOfX2b5WAEemu7TuxAPbAFNU2XCYHmJrH4ko/2bayspdmapK6Duk4ioMY4QUeGzB3faGAS+LFWLvyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7663.eurprd04.prod.outlook.com (2603:10a6:102:e9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Tue, 7 Nov
 2023 08:15:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Tue, 7 Nov 2023
 08:15:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 12/20] selftests: mptcp: flush and dump userspace addrs list
Date: Tue,  7 Nov 2023 16:14:18 +0800
Message-Id: <dac9f2295b1cdc31a1d488087ac3e18969293958.1699344621.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699344621.git.geliang.tang@suse.com>
References: <cover.1699344621.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7663:EE_
X-MS-Office365-Filtering-Correlation-Id: 5136357e-36c4-4c47-f91b-08dbdf69be52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	toP7kpzAKvhxDsq1/hTEoJJF11Sy4FywgAVGvBT3Qq4dnVUR5ZhiEzZLuMajWLWVuJftqKHwAXQqUReEEh8rkEIjwQ0F0ozNpsJGAq3qK650jFnagwVcz6XkJlZmbbflvSQkxNSvSkec9+iTCsZhD8SkBpVZPrqCzfptazo6TP1iVw8wfIM8wKrI6kX1jY+TkaH96w0IJh2wJTI2RbG8EzyLvoEw7hgS26yku7QFlkJsM36GMfbIxhWo0hRtbzZFdA/FxfLMeGhzUV0vzv54pgnfoJaOB6UR+I1Yge/kUBLq8lP6l0J9uhQM+q/+N7jOPhKfqYSydsaPNna3mAFUoC026RUrOkFYO01/e2C7+CPosv1hzdeLM1van/nmQ8+aGaBlxPgZgwW5D6psOsmxYnDDKQ1Ad9SgNhqi5Xr9QjAVrKUgJvkub7RRwBMGkXxVoCDJtUk/FEEaswpVGYEMxOV9YI4N9dzomi/ipQfpK+4HD0sw2s8A9pI6wKbXorwcGRy8O07uEuAGMvU6wJl9XmDr3DasaMOQSNKeS+JxKUIt+JWv7g6UqYswS6MmjSp6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(2906002)(41300700001)(38100700002)(8936002)(478600001)(4326008)(6666004)(6486002)(86362001)(44832011)(8676002)(66556008)(66946007)(6916009)(316002)(66476007)(107886003)(2616005)(5660300002)(6506007)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gz4/mVXbbduMp6Y90iuoFaVg8FFq+FWyCqaaOswtlSE+S0Wmoey9s+UZ4RDz?=
 =?us-ascii?Q?xOQPZBI+K1d7n7z5Pa4on9Yw7PCYLq7IsfI+0Sv8/gDfHGZYXnQy5kwgQG+b?=
 =?us-ascii?Q?f1zruKuDcgqBytI8K7Itahhljp+BUpHq1+kkyUj3IwHJyImVv5bRI5oxB8Hw?=
 =?us-ascii?Q?GwbXLv5S0hfr3oAmwR+hHrB+y9dftXy2i3LnyT+FFO22v7lGzIVkrj1Ru7gg?=
 =?us-ascii?Q?QWI/u98NuOfeuOlq191Lz2VfeT+q83Zjw9bZU7+nSCbsor0L/AKWi04ryNrA?=
 =?us-ascii?Q?x579AuZ634zVMzBop6xKWhR1IwHrL5akHCArgt+sn6eLRXkLjQ6Rr7ivWhD0?=
 =?us-ascii?Q?hThv0YItJm4M5g2R1HEqw+OrtCnLasS1fLYYOHOsXqy6COPVWgmXoe2wqshv?=
 =?us-ascii?Q?DLAjJzFmMYE2+bWy+jmhKpxHg+Ef0lOLIucVbOp5uQeKJSHUiu6QLRF5ZLOl?=
 =?us-ascii?Q?X1NyeBiu7xSyC/+TCio43fh+65rX7+pkVavpjE9ll7PXPY/+ujQEQEUiSIwp?=
 =?us-ascii?Q?0wMEjcGRl45xv/ZI2GS6zSjb/19CaMRq+AJMYlmAau/DpXp9r+s0h6zX+HwC?=
 =?us-ascii?Q?AjNymX/0WABMZyFk+uFYixPv/cbICeW7mFDpBI7nFIHFHwCqdM7v7iVWdTQj?=
 =?us-ascii?Q?WbIBYoE6kfNa7iYOh6n5vr6dT7SOqy6UIv9zTSVTXfmpMLhirjdRH3ppOGAB?=
 =?us-ascii?Q?plfy4H/4pfz6F4JXD0WuvmTZWlhEOixFk5eIKMMAdz+0c3PY2Yua5ciNUoad?=
 =?us-ascii?Q?vKsv4X7saUjhYvEZ8pOlRTrWp/5nsPkzpj4TPC/NTCvZAs4z4ZxWnbOS58Jx?=
 =?us-ascii?Q?RRAcXA3CEet3ayGydAWWGJnNy/N9kWvbWngnkeocnvne16hEw3ufem+1fxND?=
 =?us-ascii?Q?xYeGCl9Nf+R4Xk4n+isRh1Iyv8hjKF6MteURR52HFrROnSDYuyi3cUM+1GMs?=
 =?us-ascii?Q?df0Fc0Hr6XXFlVCS00anX4Qmt1bCNaWIQEBGClXmT8ZquV6bX08C0dRnt2Um?=
 =?us-ascii?Q?zQYp/KGtpJx230DG61u5PnDjF+j6acK8NjMM/TN8PR8JVlU1dIubBbQQv6uN?=
 =?us-ascii?Q?IjVeQ/8lBsRksnGaPKHNTFPrpbQedZWt1OlQSaJJoGoT4r9xgBKp/A++2Fy0?=
 =?us-ascii?Q?+HadKfeij3blbhQVYc7DjCYhrV32ZBbZ7PIhrOuXGG4UtITDn1k+XpPJ92S0?=
 =?us-ascii?Q?h9yXstSayxkvwyg3FyGVY6EIfwO9miU2GtCdnnxT0ghRcO6qd1tcmEFCzlid?=
 =?us-ascii?Q?Dbgn1968fc1uTVU8qGo16ADwTkdbxnutSgTaL6ERMoSLDrP88cOiThmoc0JQ?=
 =?us-ascii?Q?IhcN6JouMu1GtbDlCt03fKtbOMbOG7TQfhQGUTkPoyqhwmOVjfHBF7flHVdF?=
 =?us-ascii?Q?MzrDipdY+o8D7oNSvQsDaHgKiE1jlybUYymv7/2hnSpN1U5eQ65+OHxMDhLX?=
 =?us-ascii?Q?lCJbvaWkUdsgt1ui715fouDTQxbXPZ9a/i2bd0EhjtJsbpWSkxZN6UPC/ASi?=
 =?us-ascii?Q?0pTiY08DOwEWLGMv5Ae1wYq68WXE8lksF7Wkgtvjj8347aV304lLVox9Iojw?=
 =?us-ascii?Q?DeEOUlFnbRyR64yOvb67Sgo7YkTHBgXSC81bbO72?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5136357e-36c4-4c47-f91b-08dbdf69be52
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 08:15:46.4048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YDG/duBmryDqb2rgz+okV23CVhpYRQi84qCalj660sOmBxRaaDJVtcdHhl3iYeIFmJvZTF6nX0c0ZQ9a1xCHBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7663

This patch tests newly added flush and dump commands for the userspace PM.
Add these commands into userspace pm tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ac7cee3f4dac..634b51e40435 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3389,6 +3389,7 @@ userspace_tests()
 		local tests_pid=$!
 		wait_mpj $ns1
 		userspace_pm_add_addr $ns1 10.0.2.1 10
+		ip netns exec $ns1 ./pm_nl_ctl dump
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_mptcp_info subflows 1 subflows 1
@@ -3413,6 +3414,7 @@ userspace_tests()
 		local tests_pid=$!
 		wait_mpj $ns2
 		userspace_pm_add_sf $ns2 10.0.3.2 20
+		ip netns exec $ns2 ./pm_nl_ctl dump
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
@@ -3440,6 +3442,9 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
+		ip netns exec $ns2 ./pm_nl_ctl flush
+		ip netns exec $ns2 ./pm_nl_ctl dump
+		chk_rm_nr 0 1
 		mptcp_lib_evts_kill
 		wait $tests_pid
 	fi
-- 
2.35.3

