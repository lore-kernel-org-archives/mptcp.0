Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2079.outbound.protection.outlook.com [40.107.8.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9D5612D
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H5eK8Ezc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsVCycLgmJGnszIDtD56i/lvo7IAI/FrDtOcH5VD6lv76f7TFD/bz2vMr1K0BrrnOfPqe6IHFC+V2vxxq0jfnaE5/+5DBZBlWcjVHKGiWhsh+8S0y7pzh6CsLE96W6c1yyn1vcUTsPlNGkLCgogSYa47xJdy708Nyvmkxb3rNt9NDD3h5DDnG2ZeMBgUxm77fl/zxQXAR3eVYkvjjOwcKyq+spL5jn7Suuk67QCghBcq2DALZwOYbljH3xT9nEM8grN5S4VNWWUB7KSZwP58lcPv4eFZ+oICkxuYp1DMw8GJrc1QR6s/6F4FBWgpB6PDKGV8d0PzbDK1Dcn9Sr8tJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCOC34A7NOHHacDzXSV9dzFvdvFIfMdp35uaZwEZOWs=;
 b=WRp3ueu6ieHJYjec3TEL9t47IpvTA2yb4i5d/Vd1NaH+KBnvTjEutMJR4to1+f2l+m4uA9p593m+I2AToznSZdUcUehuHfGllQoauaDPVAzwqAMfpEp8dH0V2KzujQAMkcP1oKdulADaLiGdBRiRdbXVxkgS5zuiifYbfuG/Pl32zQQrGhnl6T79yqiNlNOetICKi0xLZWO43uYs1aCB2xpHcQ9Npr6+4YcoojCUyBRjHee32ppILqsgYmL3oYhVGS1Iw579kMZrUk8Lu20kgp4/x0nuzJX/7JAIxeFZIjaMpWWOptG20GNJvddsHk22qxEYm7iR5uhu8jsrELpc6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCOC34A7NOHHacDzXSV9dzFvdvFIfMdp35uaZwEZOWs=;
 b=H5eK8Ezc+aZ2wOAfTZxuX3qxVLC5g38X6Ot1555jTgznhycXU4xy6GmwqVgVdFFCcNSJuqBxG1uSl816FU/lqVW+vGFmfayjNoxlTATe5Rv3pnpedDpM5jsQax1Sb2eboX3xd2bgho4WQeHwFEG5SYkJarbgIhnlqrcli8zfH3zYrLQDgXqzJyup1H/o5aIS5dMMv9LMmetJHlILhQsArAX1V7sOMCZwlShCNN5C/RsvlrnDz3vR2afJgAowPZaevuDO7r3CU3PkzUjDZkOpFPFyek9VFU/skeud+UowAwh4zt65GDvIjsbfqw6R3K3XBWWo/x5l9yGUWEF7F0JfZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7451.eurprd04.prod.outlook.com (2603:10a6:102:93::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:37:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:37:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 14/21] selftests: mptcp: flush userspace addrs list
Date: Tue, 14 Nov 2023 14:35:11 +0800
Message-Id: <05cf40741dd610d79bd0867a26143c48c8ebd94a.1699942931.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699942931.git.geliang.tang@suse.com>
References: <cover.1699942931.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0131.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 471d4aae-cd32-4bc3-b719-08dbe4dc2051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YE8BDORVwpm/wCYBdbPYHKypdY8gqGJEMReZjuqba//0iRBLVn/CBZwLpjy2XSXgW8dbR4BrKv0cXIvrO6+Dgv+X9VNYpsVqrlqoFTk+501Fp+6JKN15Y3GaMifxzqce4PdDN1Vo5V+eeJdppqGfXTznsFmMxMsq2HCpneV563bdBloq8kibeThUdZSFHyU7sCSqcXTcukHBrPrhx6BJrpfiAC2C4dQJNQTONmJtZpwEHPV7sYZJSE6zYgQCz7AAZcKlAyZbqVXXsT9rPY1hV4y8GfCabYEg5sioJO+p6KOqdO9vqUpeaTkdELqFKEmrrNrAK2P510Xmh+2C/oR3s42crDkQREdiLlnyVBJKHEKj6PcZbDJqV83qWjko8DpwIk3pK3BW5Nev7Rxh9rX2dPquoB5bc2lPaMTlU6HWdvtR8hQDWItKrRkb4KuW2JxzbeE1bQRErgW75LRxW3BYUVJTwYm5iitfBkEu10PyTOWrXDgsbPZRwShpVR/iKyPC1/U8cbqKlcHCtqNUzLEGzQO7uIcvFdDWVVsgOw9WEKWAx+u5pA9s2rZ/P+HSvNGy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(366004)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(41300700001)(4744005)(2906002)(44832011)(36756003)(8936002)(4326008)(8676002)(316002)(66946007)(6916009)(66476007)(66556008)(86362001)(5660300002)(6486002)(478600001)(6666004)(6506007)(26005)(38100700002)(6512007)(2616005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xN5pCmdS3Pv8h4Ki34fDUZAW0BUa0GHvqPir8xODmL7H88zzTiTMHsE39cVt?=
 =?us-ascii?Q?cMFR6uQKaTQiyImX/qLjcoqQIHozp81UMAS/ARE6lZRnHSf+CG3YefZdsjMV?=
 =?us-ascii?Q?luTY9LwjL9fwzoTTyrIOf4M5wM4TaItF2iSVbajQBjOHlQU3YIjGnuznDcjX?=
 =?us-ascii?Q?1hX4Z1B4Wj/EiVHVwyhHY6W4Rm+0cjhBHYNjfnluK1qjHaHjv+zlJ/gI3W4f?=
 =?us-ascii?Q?4Fvn8WZy6K0gq/F1anRJeFq1jWpvCzOSKbumqc7TgO1i+TOFT4YPUCJQ0phA?=
 =?us-ascii?Q?Bj1YXh06mJ1XOQ58VgDKAE5B9vTUg3h4iuF7b7XNrdANszs1GIjxzzdEt9bG?=
 =?us-ascii?Q?BhNrAw0CZ0xtEjq+F07eUGx6SFD/7opNhbFqi5Pyeh/XwFjvFFAvOVcRLgiN?=
 =?us-ascii?Q?yW53swk8mOlvP9CacMOO4IdwYqsW4RZGNmSKXiHmy9PEvou9B3G5ljQ+Fz+/?=
 =?us-ascii?Q?L24yhdXokwrucR/M5cfSCUn5k6D8niPAekEkmO0HQeb2uEH76BYtKAesMjLI?=
 =?us-ascii?Q?/LuhcADTmiD7FiQ5TSSEtJL5tHnGjdL0HplgIvFgrPonG216QOx0Cm9XuuIs?=
 =?us-ascii?Q?AP1WlJQX5gJ+TIzzQCCFyWBVMbaoqE9Zor03wSAWtzuO42Q/xU0ttMkqGtyQ?=
 =?us-ascii?Q?o17KIRAgEhNbS50/HWT4sp7NIlN3L4EmlyxCBrRz5WF5zXOR5btVs0xc4qGT?=
 =?us-ascii?Q?4R7n+24KZjqVkIOvxr4eqwEAjH6s4ZyaStjlnDXCar3Gv9m1ni8gB+pWWaQN?=
 =?us-ascii?Q?KJWea83iecHM70vvzmSg0W/FtJnWqkIEzGsN702UpD18Dv94A3dCutzl8f6F?=
 =?us-ascii?Q?2dAtcUmFWmTOb3YyWSSrN/ADLkJ3CD+LoHwvkAaHOu72MUo5FI+H3S+IYXgy?=
 =?us-ascii?Q?T6pWA64sPAs5lWYJaV3Jymc03ACG/Ir1LQF/83zhy5TdRSo411rribh+sm3Y?=
 =?us-ascii?Q?T85XGlKPFuAao0paS2fgC8F/OVD1v/GIh3NylNTcc7HLCvOpUeS/ACQuvN6a?=
 =?us-ascii?Q?BlGgppg28ivrhzlJLw96uaebgiTzxAW5FDOQNYy0ozqMrCybml1szNJnzcFr?=
 =?us-ascii?Q?/DYzXdT9OCX1Z+n7N91CzpGt/v+s+2XHKVTVdrXg+ldsUX8olN6v2Xo6lmyN?=
 =?us-ascii?Q?TS0XxyblzDUaz2/giY9ZeTGJyjJZVIHJNCgtrKNz0OEfwmDwr6vLD/cySRxO?=
 =?us-ascii?Q?47zxGNulmquepSNRXp/8d46Qz+pNFPKoO6tlbJqG09WMmf0gconCa8whTwVK?=
 =?us-ascii?Q?cgp1+bymuofBWSb4d1KEmZo4/3vUg6poXwiR8z2JNvjugnTJQphkMy/nZasO?=
 =?us-ascii?Q?yuXpFBdo86mQ3cnOXF2a/oI59sbij6od+K16hA1DScGQUxLoYsFd6p1wNOTK?=
 =?us-ascii?Q?jY2XKG2Zr6Vb9ctfb4XoDT9WjVilhMs5i1HhTlSuNCXSHDbA4G6TwhOtjek5?=
 =?us-ascii?Q?iDFcVJIrDUIEnCKShz9oRWjoqVscoLsdf5nkh+YGAHROJ4l8JtWrb2Y9O7Ih?=
 =?us-ascii?Q?inZ4hKXntaV4Q6Nv4wjJJCgHv5EByMIrZGXww44hasPX88bqLn/v2opnA3BI?=
 =?us-ascii?Q?gdfk48gxt2m15gkIrSwobBeLRH1Gky05JLoAj/H6gRsa20VjGIW+t9NkvsZ4?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 471d4aae-cd32-4bc3-b719-08dbe4dc2051
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:37:09.0409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P1nSmBmTizB5grCKbYiNP9KCji5isbZqTucdUnTuUd0meUcyrB4aFVp12QzJ7gPzz2X2YZq7QTY0UP3DcxK6ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7451

This patch tests newly added flush command for the userspace PM. Add this
command into userspace pm test.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f5c51e74417d..a027cb229dbe 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3461,6 +3461,10 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
+		ip netns exec $ns2 ./pm_nl_ctl flush
+		mptcp_lib_check "ip netns exec $ns2 ./pm_nl_ctl dump" \
+				"" "      dump addrs"
+		chk_rm_nr 0 1
 		kill_events_pids
 		wait $tests_pid
 	fi
-- 
2.35.3

