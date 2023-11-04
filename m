Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E0115486
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ClikmNgT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYcwFChVDfvOfW2c0wwCQPnwJXIQC4h/LlF2J94aHDdVk39ef6J4gMZ/aDBaIyG/8ouDKmUMrS7FOMF4RXxLef5JhBtmIH2mmWVSQhs/2QSRj5fHEr/HSb2XuzEAROFL298bbzIppBxnGwx2Qx9fPM7smrjcOIdP6tNiDDYCT+qWcvGhi7deHFgXhanzmPaB1uvO7Lz/EbgqUfOuDttndcmVpIZFEctUr9V0guZoCcZkW95vHibO03wBC1oqlGdjb94c5rFzBnW1GnXp9HxI0FYM0iGjHV5j4icJWBdR+BzM7nWN0lKKqZia+mfNG+3VuQa46YjSIbdGrSfSonhaeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmlG2BtJ5D0TKRdWHuiNmNkxnLq2LDl1aM1UXtI2uQ4=;
 b=VDsIiE3z76Fucr9kIbUf4gI1b04pTrbZ6cxvLrJTP6XNdr/gaYrv/idM2qtLLwNV8PldzDu4zx/KCN4gP03oip/f0+HpBFZJvf1St4hOIhpUDg5rhrNJXZW760PfnxTPGv3Dm526bXap1mW+esaN0lZkIDmhkca44E1bci2ocwFXl8dvbT4Ehw6TxB6iK2Fw0sRxfMS338LkZxyrh8nRuFwQsDzt6ZQG0DeUFV9y8hNa49lpEehvJR5wLK0EZYEAK08M6BskEox/tWpQTS4F5DxwMtY9S9QzwV5TDNiTKltrXMW78J5BUFFEPnki2jpO2yz2rE8sEfSZtg8ojkXL/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmlG2BtJ5D0TKRdWHuiNmNkxnLq2LDl1aM1UXtI2uQ4=;
 b=ClikmNgTB3BH++GWMxbAvB2BFEqM7EXksVsiocVXxf2/spr4zn3lVtHuKR2WRu3sRgwHLvzMgAkBNsLy/TBzzGTxWGrUE9JOHcDhKQRBjHZlGAWeyHFm4iwXjKCgUASYaLRLpgW2bxH9odPWaRDGYlscdze3QZyi+mU5MOymS9CJx0RTU0cAC8FgOCikQydxxzymTaJjyOqiw0Ic8igQO2c5p5SuX0cCmIIP9rm3xkT3EBnHpwo2owGzEjYReIq/mnYkTZqt/dvpfAJi0uy3pyTJnt7qmjteW3xVCxvQJ0w5+Jpl3YnPD6FkpsOqiCkuJUQnYN7FbqGA0vu9ETC+dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6820.eurprd04.prod.outlook.com (2603:10a6:208:188::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Sat, 4 Nov
 2023 14:17:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 14:17:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 09/12] selftests: mptcp: flush and dump userspace addrs list
Date: Sat,  4 Nov 2023 22:16:23 +0800
Message-Id: <cf49026a1241a2a785094da637cadc969b573689.1699107275.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699107275.git.geliang.tang@suse.com>
References: <cover.1699107275.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: f6474d69-e9f1-4cb7-7487-08dbdd40c6cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YqYpo03E7s41OJnZoMQlA3Wm1K9IkSGoWz+VhveERJ2SN1au+zGoPQa6yD2odBZq6tSSzGUwCkljGBDYvpDGrwnYPzDHIlr5Q3lWdjnPcQS4jKEu/m5MyDbt8oq5s1kA7vc3G+HndZZXEbjbljXHhNesUQvwVmjNt5rb/6boKAoawL8SZAva2WU6/9t7KV18Mlz+p2+IpSYjsav/7X/Xg3qOvPoTmTowaCiZSw1YDOMatg/eLHdS5FU6oUfleZcUgzuFRdYWk4OAShwsRD9XHRD9Y/jB6DzRHnCilnvafooqxpHM25gTAneWwaoV7t72CBXgYiYcD9WVzRVcCKMZMvpnOQkBCfc3fLG71NoCrAGu1aA2WyjYEaH03cuOgnOpPv2DW8GwC1LMPFBadoeGQJ5BMG89ucpTIBCCQZWqnq2TNEsqX81jCXvQ7vrJXMboh7sP+73xxGXi0bWwt990rVVBP1uwIoDtDXBNj3UKM4PFv7j2ctrYgTIkXk/wgc7NgzmUL3fJx445fuzBZRzz0IZgE6G5oZ9NxZRAt3tCe/DekUzeaagECMul2BIsU0cTqUYzJGT15bcbRZcHSrf1RNLXvZux/tG54UXxXRQqn70=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(5660300002)(2906002)(6512007)(26005)(38100700002)(2616005)(36756003)(86362001)(41300700001)(6506007)(8936002)(107886003)(6666004)(66476007)(478600001)(4326008)(66556008)(8676002)(6486002)(316002)(6916009)(66946007)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BLNPI9VIwHC5X6nOgu1q5lq0o/weWdDXwiSk86t5/VxMJQc0GiS/IX++Kocp?=
 =?us-ascii?Q?1SKWOuV9EPiHvCIRkR9RmGATLR4wvORYD3ly7JVGlLI0eS4tc6MC8qri/xOa?=
 =?us-ascii?Q?BiU2jsuyf6wF3WJZtUR7/P6WyRIGcrVoVcepF8RnDQPQPjJc/t/tloWrFuu6?=
 =?us-ascii?Q?cz5Di0P66QuaZpsXlsM8OgouSS+Yyt5J0VSkRB/PbT0r0x2DCzr3vgsJ5bOA?=
 =?us-ascii?Q?MtvUDo3++7iieToMnRh/it8T5Jbt+Ezllc56MSmPiqfow9aBBeYyagwjTs54?=
 =?us-ascii?Q?+Og8kWz8lLf6bZPt1Hc1FK0vqILsTzR+NYXMuoxxVc+PRa+TTwgVvFTuDHC6?=
 =?us-ascii?Q?s09DK4MSlYJ6KHx7rUucgHWQ0quIfazPfZ07xXJhfTmZUyUxpIdxQUoQU90w?=
 =?us-ascii?Q?ndF4mLUJTCMBt+OfjylSUHgcqPB8w1apNZX9v4XcKA8g8tbg5b1Dx6NM89Hd?=
 =?us-ascii?Q?BOHxYpBbOLLiFkW21eFyoq6wFIX+6acNKCaD/8d2uo6oGhmCewOADese5qmb?=
 =?us-ascii?Q?hq0QFiSTHqNLkqdlTR8Ov4Ji3hzDvmzlS0XgbimElVck4/P5hqSat/ySJ8Pl?=
 =?us-ascii?Q?GeXYBDSA6bl2ITgu2U7gKz8r9d/6DvVHuk25CLZO6WoPOLCNyQhYDcSi+l0o?=
 =?us-ascii?Q?3s7WJPKy9YUICrfRx2DA4gfOigyqc3JJgVIkqxSPT16gTLICsSm0zEEUXBXb?=
 =?us-ascii?Q?EbuORVvO9Ec15PmAcvDXqFoI1Zg5ivFhld8/QFpMKuerV2k2u/6FHWbCR4SP?=
 =?us-ascii?Q?rhvSFt9o6/2C06f/iEOrO8aqXzWUnQE/dmzIcG6D+IgB1HN1tqBRAKSGtfpR?=
 =?us-ascii?Q?ZbK70c+RW46DE/ZlP1UhRXOdzfDhwiqOWsJ5WuKHGy8H22hilrrjXBKZhg6F?=
 =?us-ascii?Q?NLAa3km8Qe6SzLXHadXQ/rgRRa6X8UB4siKkpX+d1lHfuuoFi27bLobTSiVw?=
 =?us-ascii?Q?aGAf9wDjfXkzmFIE/Z9TXBL+kInmwqderroALnMI48JIXziXIDAed5v6C3o1?=
 =?us-ascii?Q?bQtTFlW/kdpOU8jxfsBEAKqQpHBbB7ChDmn67EjGPLqdDbPDe3mLQ45H+b4E?=
 =?us-ascii?Q?CRtOLx0M9ErgSeQvhGJ4vNam4d56otH87yFGzKLx9fZmCuhwb1fz9zNCB6pS?=
 =?us-ascii?Q?dUh1OMzLOMvWel1okJ7RssIOUY465d7hSVNeoE3kdIN/VZe5rvovsr8JdGIJ?=
 =?us-ascii?Q?jzJ967SV2Fj9KhbhJvjnZ6afwkBj8rSl3wRJBI+BkysS2zU90PNDOvS+sl01?=
 =?us-ascii?Q?xzHpCfTCqfFzLEWgEjKQHHvnhe+yePUuYz2pnQzXJFD7U4+wEwJn6u0FqCnl?=
 =?us-ascii?Q?EuLWF6DR0aTPQYb3Xb4PufyGw6RiIPg9euL9YahWMVihuvjLmWF+0eeH1ObJ?=
 =?us-ascii?Q?qmgqjzXC2zjdEGznK/GXZyPvxYNwl2D9HYHEIMP6MMKaCDpsEsp8//YV3LjW?=
 =?us-ascii?Q?tu9hvoSh3E1g0h6b+wvH6rY4g1xDuGPp2Tf7Y9qH/DZrnZhd6VFIBs+79TFl?=
 =?us-ascii?Q?jR/WWHJPbAl0eOX9LyyipPPWkSCfAWuIBO8xaPi7ZoQRj2rumJneA3W2Vk8A?=
 =?us-ascii?Q?QIMWcdw0rRzIE/K8OlM7w8KvZwqk8zrnJ3Zz0yCa4fj0LBUbnNIuGuDfjqKR?=
 =?us-ascii?Q?0A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6474d69-e9f1-4cb7-7487-08dbdd40c6cc
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 14:17:28.8819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78LInk4SkANXQW4UAcT1F8o46XlQP9FYAzzIlbjOvDyAVTXsZknYfYss/NAyZKLQHsdrwgVJc+8JSA8ZIZiSSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6820

This patch tests newly added flush and dump commands for the userspace PM.
Add these commands into userspace pm tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 995280882428..b56e141547db 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3405,6 +3405,7 @@ userspace_tests()
 		local tests_pid=$!
 		wait_mpj $ns1
 		userspace_pm_add_addr $ns1 10.0.2.1 10
+		ip netns exec $ns1 ./pm_nl_ctl dump
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
 		chk_mptcp_info subflows 1 subflows 1
@@ -3429,6 +3430,7 @@ userspace_tests()
 		local tests_pid=$!
 		wait_mpj $ns2
 		userspace_pm_add_sf $ns2 10.0.3.2 20
+		ip netns exec $ns2 ./pm_nl_ctl dump
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
@@ -3456,6 +3458,9 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
+		ip netns exec $ns2 ./pm_nl_ctl flush
+		ip netns exec $ns2 ./pm_nl_ctl dump
+		chk_rm_nr 0 1
 		kill_events_pids
 		wait $tests_pid
 	fi
-- 
2.35.3

