Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8A018C39
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LtdBtR6m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OH/UnipjXYxVyt0BK+5r3aQCApbnRXsJa+uQ4u1/HuadIOUJghWczWhNJBLm8uwiYwsYWCMJPddvVsFWI3IhShqcHvjO8gkbm88VZ39OZXxvTnIXIZVd3/BmeWTmLgER1XtTMXlObmNbvLT2RQPxhR66XWPL+oPeWFWt1BNGKKEC8KcYHEAZTxM7+bb62hL6oo77AaR/F2HU5AS907QAgFmHhqaBh5YgOR1FKmolGbOIyTFkzLKTgRB6mbMiziCXkFKX6zieCocJoBKAi48LHZ/Ll3SwI+O6qLiQWDGmD7nIGZcGoqI3oIC6MXqC9cl7qJrgjNPshrEgAcEHAkH3Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1U3CurSV/n5ykq6OhYD6nb8sVbokeful+uBInQxa/ZQ=;
 b=Le0GZGcjzQwHcysP1IrBxbXnQe+eL73x5O10IpyAkPzf1qjhjyMs4DU0nOSuLfFyCjdJlNk+fEIRUua6C4+Ax0+wzijMM3WHiG8Dv9ZC2jnwVESW5vz09Mov1ghdZDgQ5SEChLto1oeUv9boufWlQw1B+V/1jIaYh5hRpf2/qqXhClGVjWq9NxeOQ42MDkPW7cVF2VG65Isyd60TPWw05X3Z1hs2Ywah0ZxGsQ+9zhWqfQ8y6Yu70fEE/m+bz2TNqz8rmPzm48WwI0ywQqrtvrzUoz1CVnlF6dmYEjYTKzp+97Q1Lh/Kme43JFchAffMNHkBvSpxOq4OlQnDJZ/GpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1U3CurSV/n5ykq6OhYD6nb8sVbokeful+uBInQxa/ZQ=;
 b=LtdBtR6mr6huHVp645z8F7jUA85uvYkHEQyU8vAwRRRtsmm/7Ule25cJsX6ENJIiPnRc/+OhLleMGVYFJYPeDul9ZSocpzjaSVyt+CqTZVcWWG/PKgbr32Mvn9sac4eGEF/Otx1b+qTWDUOWBnt7xVhKldtA+P/RMc5RA2ZgAM27CuZMkIek3Zc1KuxKCvSZL02YVST2fPYaZkafw7q5pyolDrW3whQc9MnMqbFm+Bqq/ttG8G8ZT8Ox5OtwygF+FNA8SmHOe97WBN8k3eGJVYA8JunXz6gl4yqFDff4QSNq+sWwsNfx+cK8FZyXqRlv8Jt3B0ARKbc1zaqYRLrGGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7013.eurprd04.prod.outlook.com (2603:10a6:20b:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:23:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:23:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 17/33] selftests: mptcp: connect: add PORT instead of TEST_COUNT
Date: Tue, 14 Nov 2023 18:21:47 +0800
Message-Id: <00ba57c6b464d1807f6189dfe977f73e73752021.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0252.apcprd06.prod.outlook.com
 (2603:1096:4:ac::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a60175a-2149-410c-97fd-08dbe4fbc2f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZPwjeFxAqy5KJoNRXpUcmYMQJVTka534jqbOBDLQk96xCA+jh+Q5hx8EpIA3Yjt7hCPkzrIHGqTi9iJERuvYccf0X2Boncqo99/BWhnDb4raliAyvpoVFE4BpTpDCA2L2WD5ot3rGKzgj3xprKbueQatZYPfckhaoIqFcO3KqGHa1JngY689HoMyIRgtNYt+zh9uO4jYmK+o3+aOEyELjbNFOOdoecQrdWQkRZz7vt1PJ6EQbV9OAFB2YJppyNCQ3SRp1hOiEWF5QtUUUqpvvxyD838yRr1mTXIui7uvVKnBc2Z0/gu/DReX1zFuOFDDVfzm5LOz93OYXCKVemS2CXgxUMFZwyq/nkJQ5hvYg/X0BR6uwY41MPsP+QIJjDM5mFrPCZBN/iVZEvIMASowfT0ERyiY7EIrJiMHjiF4bymsY+x0wmY1D/6c8IvNWyox5Coki0+EXJo3ghIOMTX1XWHEXCiTtyRHvN1gYG9n0pBeKKY56F/rJzh0PmEVQYOw1gwFuElzThu74H1rqSVloyP423MlIf44QP15CL+lEMK5gpvDp602QvMmwB81R/KS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6666004)(83380400001)(6506007)(38100700002)(8676002)(107886003)(2616005)(6512007)(2906002)(86362001)(41300700001)(5660300002)(36756003)(8936002)(44832011)(66946007)(66556008)(66476007)(4326008)(6916009)(316002)(26005)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?APZpoIFoIJdCdGXSBtyXzhLapUB1DNEMuaYAf+uh/p1de035diuXnWYhWP/I?=
 =?us-ascii?Q?Qbi225CLlde6NjUB1z0amfxaowhlhsQ7bNc6NG12DFgPe3nSyOWYsywfNq3S?=
 =?us-ascii?Q?vJtFwm5ZsxDVStyBz3ioAXehPtNh1dQWvbE7EWGcYv0D9D/YxcwPlT2qOrkg?=
 =?us-ascii?Q?GCSyxW2370yAU2jkzX1hkMGY04zC7GO8UkAdigV68bWoJq/hSVEzLimHVDE3?=
 =?us-ascii?Q?9qzOIYoYme2CbLZegz1iU484kcIQV9DPKHTMbDTJ3+GrX/DwKLj+0mn0Tgaj?=
 =?us-ascii?Q?dADObIW2ZRr/12W+LgWbCkggQ2EHOQk0wlHdD9WdbMYksOJ37Uwh83IhcyA7?=
 =?us-ascii?Q?gtjyTvbPSu8A89FaTBuY75yOXZXJj7WcTlCisrv04eMMiM2JgUMFl+ZLCah7?=
 =?us-ascii?Q?fJ6mIRfTkuPBkpTnMxP7/GCD7BvVeedeKQQQ2oL+FFeKiLrLVZ6LArzSXWDL?=
 =?us-ascii?Q?kUddwFzLZ9nKhPaEhpuE0jdKNYLMVsmzZFKdtpbWYITLgyHX8ngbOvkGnFlz?=
 =?us-ascii?Q?MgPEpKIdxh8rIGpa6lISETKhjGjOLmGO3lz3uxEZr1ScBSxdAvhgy4X5x7B2?=
 =?us-ascii?Q?auoiUZXloQ33i9nd7DIj1wtc+vAHWPkY2y2GvmPr1T4FL2CZic/yqEHr1Y6x?=
 =?us-ascii?Q?mnytshkHBwFsVOcYc9ktA6evyCpjk+hDOF+ez2X+79NEDzEhRbIVD/glbEt8?=
 =?us-ascii?Q?E5xxWQuoom3psK3r6WnsyuNIMoqFVV4Oz/FP/OTZY5TVthDLjNf3eZK64t78?=
 =?us-ascii?Q?E8MHOGR+cT0ldB1vXTs0ZEyGH3zp90lLQGO5UZ5XuOYvuISJYbvVUSI8kedZ?=
 =?us-ascii?Q?dlGf4j9Seh9lAPhiPZTnpQ8Vbxvewrm+QVMLmewlLZEorIlTqr8PKNDeoP3L?=
 =?us-ascii?Q?mu5BXaNd7r1oxpllEEF2YpAEQZiTczj8kXxAUvcHBIufvB1IUybnaNSUJABQ?=
 =?us-ascii?Q?1x3KijOyJ/1sEcks9EpYd2rZokHw+QhtHKOpEMLLcah8ztGtmBBkFzkhFfqp?=
 =?us-ascii?Q?PSw4AiPg09azCvptWehG3mv9s7HaOFZhW96tJOgumLXinFbZibtMZsIkEnAC?=
 =?us-ascii?Q?npna388Yk/gApp007kMbRjm65dG5B7put5LegqKhZ3QA+mA7UkKcEY+Ia1xm?=
 =?us-ascii?Q?f/xFaLT66xLbuM7uQ8djmDrepjZwUsmQYvLCrQLI1oX5Tf8TBv3BTDkQIhQb?=
 =?us-ascii?Q?XjpEzkw/xuW1DbV0BSNTZUCIHdS2pVk8x234GKTAVVXvfnZLt5JGGyy8Zxno?=
 =?us-ascii?Q?5CcNEIuE+o9Rf+DlXEB0KeLpNXmGJWhZ6XgscZI5aUi9aUvDLl2R7Frp+a2J?=
 =?us-ascii?Q?SBgtC31++3fSbP4tbaPpToPcxk4AHWEyzo2J0riuUnEoUYTYpkxcd23Z7MXS?=
 =?us-ascii?Q?aY2sucowfxO/d+JjFewLk2PpLoFF/hvoiLhz2Yk5dY0nLbTxG6GzQQWS5B1H?=
 =?us-ascii?Q?lEjIb2YwgixV8NctMIew9rBGzKwr2OGCI2ZMDrxtQQDY5W8nOgGe+qj6eiq3?=
 =?us-ascii?Q?Q3jSgp9v4A7nQgcn6bAX+GdNOnpM37rTOJVjdML58t5IcHsUHwHALvBaqW9W?=
 =?us-ascii?Q?6Spm5k7Zs4DoSvo3FAhPAgr7HeQaA8z6n5E+yNWKNlRZrn2FWmRyX5eQzvk1?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a60175a-2149-410c-97fd-08dbe4fbc2f2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:23:36.3347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B3766LgR+jXBBYwzW3Bp2trCRA0v6822Oq5vde3GO7/NLfJT/smPRHlMYlkQ420yGnk7Xd5WQmOMOSH4/LCeYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7013

This patch adds a new counter 'PORT' instead of TEST_COUNT to increase
port numbers in mptcp_connect.sh.

This can avoid outputting discontinuous test counters.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 4041414c8804..0a6d40c3aa85 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -28,6 +28,7 @@ do_tcp=0
 checksum=false
 filesize=0
 connect_per_transfer=1
+PORT=0
 
 if [ $tc_loss -eq 100 ];then
 	tc_loss=1%
@@ -308,8 +309,9 @@ do_transfer()
 	local extra_args="$7"
 
 	local port
-	port=$((10000+$TEST_COUNT))
+	port=$((10000+$PORT))
 	TEST_COUNT=$((TEST_COUNT+1))
+	PORT=$((PORT+1))
 
 	if [ "$rcvbuf" -gt 0 ]; then
 		extra_args="$extra_args -R $rcvbuf"
@@ -691,7 +693,7 @@ EOF
 
 	mptcp_lib_print_info "INFO: test $msg"
 
-	TEST_COUNT=10000
+	PORT=10000
 	local extra_args="-o TRANSPARENT"
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP \
 		    ${connect_addr} ${local_addr} "${extra_args}"
-- 
2.35.3

