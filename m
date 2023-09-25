Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BB7125A0
	for <mptcp@lists.linux.dev>; Mon, 25 Sep 2023 08:43:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjIeHMuLSHSXTKx5e1Io+yICai4C3p6IXPRUNJjKm/GYrU+50uwrD0tvhcTGaTRuIlvwmidOttRpszDyn1iCENm8XypkKLtlcKClijR1U9lZ/L0pjJinUQEUAUdUwxaUnKk6TQBI2pEzXElBERNuTFN7pwg94veBtb3TOYUSay+XknNvgJlfJpeUkUxJ5OV8TbLc5kiu+j5WwXBT8YXu7dgcUUY7ZleD2EHgfa0ZBNi4g0Y8efR3mpV6i3PRnQhoKEMscO5znCIeCUKI2DCQAXWOHVPPCcS2YbBI2HIeCFAaP2QgZjKK1MfL+CYqigNLWaPvOJJ2lLvOk9+/2dOk0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3/Thb9MfRuKOX6+LCvr/Dd4cn72+PR9JNmDkwAOZbE=;
 b=UQ/s5nibaDqPHnmocn8LCSN5SEuiOccjkSn22V3/QIGRlgUKGvvKJ6unMwbFBmvb+UeVx1SGTtemP+Y0n9U5adwybN0jFNQzJ7HF21rAcv1/mydJNZNmqimkaXfDtPa1G9i98hTSTXJnbRX8t7Z+AW0ATl+l08FlRK2R32s+cjBB0Lz+VMiJmTZMmpX6Va+nPdM2mOLY9RK5KFud4MHHWJ1n8vLV3b5Rac9FThgMWTsK1g2kFJVxyFSCgi+PR199Dff/UZBxgHPYGghNC/kQEsnEH++k9w8Ryp7BGgNpdn4/AK/cwIiJBkpOhfPHWTU+H32c5sWGfBl1/SGw6MVpJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3/Thb9MfRuKOX6+LCvr/Dd4cn72+PR9JNmDkwAOZbE=;
 b=mOXv6hmLJLb/fmg353bW4fnejy2DYfqVfjmDbcJw+I7kQbtiEYgYBNf8wznoXQM1nRgil2jQk7YBi8gYO7mwQa81e3fa/TCbGyYQYE2XxHba+ExKHW7+RZW+hzhgyD6QHxYK4gT3VowEY2qTLiPtsNed22MIWkqvtUSqdSJ6Zdq1z/jwJ+lZHaruGGmLtAaMVQA/RoSOT/tjQdH5rgphkyekSrltLHNxUzj2ne/EBszsEI7ZQT/nUF9OIgjwyWwUhNg5aaYpRspQhlnEkEegbW9W3ssDiI2hT17dAx2OK7t6dUezh5ky+DEYq9+5L3dfOkrvTNoTUr8UrXT4uGwg0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:43:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:43:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 16/29] selftests: mptcp: userspace pm remove id 0 address
Date: Mon, 25 Sep 2023 16:41:55 +0800
Message-Id: <a4881572b8700e7c6f351cc8d0f11ff75fab31ba.1695631132.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695631132.git.geliang.tang@suse.com>
References: <cover.1695631132.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::26)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: a15bce63-511c-42c4-a468-08dbbda377a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	prz4DVpH44EU49Hrl7PY5k8G0+NE4yT9NoeOJ2Gcfbi1XRDROpPGlndfcYKlj/6zfZPgukDsbyba/K0P5U7ie+eh7unW6UZ3l/VZh2sWk/tfBZSu5bD3aqUMB47CSD9LAY1frlx8MBqh24ru9V4DrqWuG6u0x34tC5DUGjLfMaMmaKOry5V529CuEhtRZXY99WYOEzUihRKA6tKxVNtA/HxxBFynMOOmwvmcIp21LJlW2S5g3/Fg6eG5r4Tr+wXNr1drouKnP5JJ15KyHCxj1H8bHAdnPxojLJubr+bv42XCDvOMBNh68kG6+3C1Z/EV+5OJAJUCBUHDiZToMWaJqOrgt+FDptEzF5ADCvzEmbTPG5pPFN0uIeC2lAtvtbzMjJj7nSWIh/ivE2+fDMbAS685hjmoWrO9CP+GBRYHmFOmciBquaim/ndSYt8G0JeQuySfkMlJQj39P4OZ8n4k//kdBi1DDL82PbybvA+bKM1Bwmrr9KP/zGM/KESNxTi2Q4NMpIQutxFezt//+W1zUT0/mgCWmYgzB0MZx5PUVGsvWGHOpy6HMoaV+EC6wupT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(1800799009)(186009)(451199024)(6512007)(6486002)(6666004)(6506007)(83380400001)(86362001)(38100700002)(36756003)(107886003)(2616005)(26005)(44832011)(2906002)(8936002)(8676002)(4326008)(41300700001)(66556008)(66946007)(6916009)(316002)(66476007)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QUAnbiFg93nlma/xyemU6edRgUkG8sFeBUu/x9Ehcxv0Oz0DaHHsFl4Ab/Dq?=
 =?us-ascii?Q?HSXH1rBckIoHtTSw0LCsmeRY8m6AOVgZ6rWfZRgI6/2OMafjQOy+rAqBtUti?=
 =?us-ascii?Q?cJsv9a6H2AhIetz+0A1SIeKGMZIag5dxSn6M9+O7gkmNMJIbhh8ODd1iJJRB?=
 =?us-ascii?Q?nxbdIPYusDcGQjHeHJLLOrfHkDrRvZpFh5PPsRaUJgH+Lgqg1nm3wLDKHraU?=
 =?us-ascii?Q?DFZrZoTgM79TGFO8k+8u7m1tY5wloGOfeXDoSgbWDmVHANtqNf5jZ+osS1wn?=
 =?us-ascii?Q?gTD6oJC5zLNqfHUxEv+vLfMH74WPIEG6xLQsEUAugug6lPh+BoUexyBtd3DX?=
 =?us-ascii?Q?I8eKi2qNPvV5OCkHvMq7ZcxAyIZ0DhmtaM9RxAVbrDBv7xvo3yEa4TRpPWhP?=
 =?us-ascii?Q?V2AISasYXh7lrP57de/wvRMc9KCrE+8pBxmnTQYNQkCisgNVmYzVNxvUZHRJ?=
 =?us-ascii?Q?zUY7Aui7fbh7jRd5Ryb0pZlUpO6c8sOeGNvWoP3jqJbpt+uOs8UCx0BAskKp?=
 =?us-ascii?Q?V3b1/fBrZFcb4yeBcjKHCXaU8YqGNZgoR0u4kNK/+PO9SrH0IDd8Z4EIrGXX?=
 =?us-ascii?Q?78F5LQBVXebXq+k+FpLevoXyTp4oN3mwO8hxkDt9Vz5YHxSbJd5bj2QTdbeE?=
 =?us-ascii?Q?ljWLuh9iWvkfHLI0CMLLZc1qgI2095buJORGcgUYAcrkcJVK9nIrzPKdf+eF?=
 =?us-ascii?Q?FA8QOObC4eCqsV4IY63qeocz0gFLi+bzp+L9EiEyY+8Cju6umW+GFhS8ptYJ?=
 =?us-ascii?Q?ZPqXv1BEtfmKOgvdFRzJ4YSKV2vtQJue/8cmX9bK//svpYHYByy/HtptfW/j?=
 =?us-ascii?Q?77k+CW9T4aEiCsH1AHBqY2G0ZS2x0kpYUtVRXQEew6gW/xyrtB19EnRvJkhP?=
 =?us-ascii?Q?qz7dZSYqIMo/JPSNNbbaV/BE27JDKt2BzEfCrR43qYkfI7BOFfd0SSL2A4AN?=
 =?us-ascii?Q?KxcVm+QJTayWjTII60QfP4IAEojzmReZkKYsPTVZRCNOQnQAhbqV3snyjgch?=
 =?us-ascii?Q?wJ5WH0t2TK0U5daAtEl6AjY2wzpwYNyGq3HmWca/UOyf8dXWfVCQb37+p46L?=
 =?us-ascii?Q?oUXMsACHck3mIklpXaajXpOwCFcmRiC/eJDOkzgVbBse8+WoD6oSTvA7Sr3U?=
 =?us-ascii?Q?aIv7VjM5qNC1AGi33EilHbMhEN4G0hw7AjkG03svn9vIBcI8JACfeppuMxUx?=
 =?us-ascii?Q?Uuje2BjnlNumlhHilnfreHwR7F19zRFNw1GndfSMd8R7e3FYYi9kqeyUSnZQ?=
 =?us-ascii?Q?8d4IeKMjNytD3nG7h2fOYC533jKKctBpIvhMc/F/7Cw+q4Zmq4T2HSJ7EHsy?=
 =?us-ascii?Q?XzI0vWf3T+nU9my7LPyGrFRCO55bYUB9XkBAwnaO26QqLifGaUpe/ZM3QraR?=
 =?us-ascii?Q?/ogtdvB4/Zf7V53KEP+daPAuK+24XEa2E5enRF458vTVtYFo3Psw5jBwcoCl?=
 =?us-ascii?Q?gZpiNEBxvAjXFv6muNbn/mDFM2VMkStBZ6gqFYg52b7LkTZTBmDRKNFWqxuQ?=
 =?us-ascii?Q?EkDKvCTUmcbLSpFF2C8kR7DqjKL0A46Y2ig8xL4BgN4p8E7kdXQ4wpoaOFlC?=
 =?us-ascii?Q?eaDaujMhojzi6cLkG5d1ZLbaDtKuJ5b8KIBrtZd8?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15bce63-511c-42c4-a468-08dbbda377a3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:43:19.1076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgw+rWF1DSImKInuWMxKl9orWLxhGF4jXlVM2e+wcr4MVz+gYHdf5qv2tEY8RhdDLC47JZhtxWCq6KUdX8Aw7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8510

This patch adds a selftest for userpsace PM to remove id 0 address.
Use userspace_pm_add_addr() helper to add a id 10 address, then use
userspace_pm_rm_addr() helper to remove id 0 address.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 22aa69db87ab..aac50ef86785 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3508,6 +3508,30 @@ userspace_tests()
 		kill_events_pids
 		wait $tests_pid
 	fi
+
+	# userspace pm remove id 0 address
+	if reset_with_events "userspace pm remove id 0 address" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+		set_userspace_pm $ns1
+		pm_nl_set_limits $ns2 1 1
+		speed=10 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+		wait_mpj $ns1
+		userspace_pm_add_addr $ns1 10.0.2.1 10
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 2 2
+		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
+		userspace_pm_rm_addr $ns1 0
+		chk_rm_nr 1 0 invert
+		chk_rst_nr 1 1 invert
+		chk_mptcp_info subflows 1 subflows 1
+		chk_subflows_total 1 1
+		kill_events_pids
+		wait $tests_pid
+	fi
 }
 
 endpoint_tests()
-- 
2.35.3

