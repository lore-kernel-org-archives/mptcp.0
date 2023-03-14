Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2081.outbound.protection.outlook.com [40.107.14.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F882565
	for <mptcp@lists.linux.dev>; Tue, 14 Mar 2023 07:31:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tlze/a/C9PXt0O9dc6Gsoy5hQNtEdwlpV9j1uee9u0RAhZCS0TRsb8XsQYWdmb+KS4J2+HkV3isSxu7bCa9/TasdncDag80puXpRaYLuc0g62z0oiYkuwFAAF2Y03TQ1qi7KC/KWYJlkpP3MjlqnY4qaHR/FeSs+KIwpoZMR4nlS4xR+zvHI65x/G6+FyqR4DWh3C1cyUr8M1yGvqRY8hbRJzPSNUsxynHMP7IDwJJF06MOFZb9FEQNbAxy8UaP5I7vLYf9yd9kmFH9FbGUJx1+/UkpyLPMRalHwQbVfTu9n+krQQO8H1xEh7TkRUUkLuXdU8FrBFcTJGA378Y91SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sg06QCUNxOtjdN1eNGzTpNV3CUoqRJIORsSCRteWPtU=;
 b=ipAuCuG5RFe+BOWMxcai8Xs8Vwi5StV2p1eZSAPESgt72Yh70lcwWNvutbjAUzCIRPoaGcZIzpE4UbU/3+8QsuifWqAXgMdEN17MGcPwK3JnEVbBPjR5k4Q3xRABnVJKLDR9IUpDASckLNFf6EElf6b47rBUZfXetOOF9ax8pb7IGFvbfR2gCxcPAaR9Xpt/7QZk6M9kbaWttGe0LKfl9EqS3F9xHmH2r5AUVoxV5nb700JeRM2GULdyStU8q+9xnUV+Xty35SCr/QoQlVXxUU+s6VaUPt234/NY8IXeDXYqLf8R/jRJ0Yyia/eeBQ2gx2ueCAT0X9MVmo9N0e0/dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sg06QCUNxOtjdN1eNGzTpNV3CUoqRJIORsSCRteWPtU=;
 b=JZg3e65bbwtCPL7O0Xft3ldieRmwE4MqE7fppgiUvfDanWFBXaPw9+yzFdA6h2StOIUJ50J7TRJz50hq7E7Vxn+8/t64DW85l0PT5suA7hGPeg+HN2WZ4hiuKEDcyqTz20Siol+S8IF+ihrRbfI69tBR2eqYeNIFbILsj9P9mVwH/zZBFh6nM9Yx+IJVhJvp+6mQMMZk2i+/x3tTLqh2tS1eTrjhn9io2ec6QBFXVzqJzSFhmkiO2ZreLmIGQ6HaRFtObIdIobhVx+p4PQ3ooEH8ONI0IAuv0nXIZPkzIcBI0UTL0del41qtaUbT6/uAsMb8PjHPCG4tcj07zwOn+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8759.eurprd04.prod.outlook.com (2603:10a6:10:2e2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 07:31:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f6b0:27af:a96f:ab6e%4]) with mapi id 15.20.6178.026; Tue, 14 Mar 2023
 07:31:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 7/7] selftests: mptcp: check userspace mptcp_info
Date: Tue, 14 Mar 2023 15:31:44 +0800
Message-Id: <9511e6740c7249bcdb48ba8716b9248e073b99a3.1678778977.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1678778977.git.geliang.tang@suse.com>
References: <cover.1678778977.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0041.apcprd06.prod.outlook.com
 (2603:1096:404:2e::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd6a8c0-f6ad-4eeb-7ed3-08db245e256b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m/UTfpanglGNeP5EX0cVpYG213NzHHgfVz80rLSoQBuaY+Dz/IqjXwf/C03j8BySyndOyyYh1txCidCHslikRHbyByvAoYPK0+y6WolsIoeeOwQ17P8ZjoHmcMICsI7ffwjPLzAIRy1D0JFMZA/IR0HPcaHUUCLIUg2WkwoJ+8UhxYUO7RABZ9sjUFiZzRCXxvTsatLAXdYRwKExE+IgPivvQ6HfysPfoIe82xyh04J5PCpAcdTNW8zDh8/R4W8ExN28UO1tAmdHaDgTgxocDKWdukuyoy1jCW8dqeT5lh9vhd/VVcq8JnfcSai05xsnyy8iWRGos3Tqg3t7SPAk95w33whnKmPzXOPaa1crxQ1Q7sgsP4R3p7MnX9CkBp9wqsCrsGOE53ozzk/NvfkrxBDbnsK86nWkN5NPYTqnXNClaEULQl7kFJmB54ENOyATkzl3WfyXJDNwffVOTJpJ1E/GfWMGiwyeFqxJLrspOxrTOmOmaWlyGPqfFFsRZxF1h+iIs0OwM22cJpMPWDICQBTmGbvOmPzEYew1bwLK7cpvEv88+MUILv/Jg12vnUK9evWHOUXKPDY/xqyLaK59NvRwW8+H304BFRB50EqlPqe/XcGOmeuVaZ489SKH3cOYuQcSyTS3ROqK3QmJLSle5D1qiovvmNROVbpwp2lppV+vPQ4H05+dp9mm4zSLu9wr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199018)(36756003)(186003)(8936002)(2616005)(41300700001)(478600001)(26005)(5660300002)(38100700002)(6506007)(6512007)(86362001)(6666004)(107886003)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(44832011)(2906002)(6486002)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xrfMGnFhtfN+6NwQUvyfLeuT27cK4Wt4x63BJsNSgsFq8KEVTfhrUh4V/+Bz?=
 =?us-ascii?Q?r2ta1AjCuh2fqrjRZYfpgxg4hsuy6r3qEeAhNlSbFPhcdb378e9CKmOyUCWT?=
 =?us-ascii?Q?7Ri+yK+T/L+hFOD1cMjJrePXVc1O9Is3jzdRjrpxapf5pqLJNUQgnznQbAz7?=
 =?us-ascii?Q?7lxxChBPTNdSBQapqQyUAM1hnU639PboF7jhzbogp2YlmU4VZjykSvEgjprr?=
 =?us-ascii?Q?eHBuCl7x2L8R3XQE/LZ8pCGa53dlxYyfd1AiJjvKiKdvEV2I9lyM5Oza7LW3?=
 =?us-ascii?Q?svqkmZvE6gTZAvA+2m8fcuayamdBKfBGDUvOeIwArwPTR/Fk/URyNpyaR+Tb?=
 =?us-ascii?Q?OlGDC+vUTVG61anUPO6Kx+ONo/ZhDtwfB5YcGeQ0GT0BURWXSYVA92HBpK/v?=
 =?us-ascii?Q?sMrVoR0/6VSGA5Pat07AeBQGIPmru4atMLVGdrN9/73Si44y7t05E96jOT40?=
 =?us-ascii?Q?C40XOM16lEVQQ/al/kiD9sk8r+KU1LOlR8wxcd9oPnurWXu3AsOC3L2bmnLU?=
 =?us-ascii?Q?ACUMwAAOumfAGp6bNwI9E6W9ZuXy3fsuRIOGMolPFvK93D1bitgO0MyXSZJq?=
 =?us-ascii?Q?4PtnA0qMbS0sqLJO44q5xN2BctcV5N2uqe+Pe/Mxpcc6mKFoPW1SDck64DNI?=
 =?us-ascii?Q?XZbPB1Qx1Liiu1BquNgiLm0iBLuHgQRMNNeYRYJDiBsfQzlbxAhvhCpAXd82?=
 =?us-ascii?Q?G8vHJxhjlB1juB17ib6lTWObrXNnBOMsc96bWdssJB0piBlWrZvm6lKBRIUd?=
 =?us-ascii?Q?huLEU9yHJCzsc+j3qFLu+zyabaL4uQZz09Yk8CfRNTW+OFmYOYYud682SMpo?=
 =?us-ascii?Q?tja7i/hdtD2cJUzGcmak5W3u32kN7eMzQRmXNGD2kZJQlmlGYeFFN5ZkdnV+?=
 =?us-ascii?Q?oGXQZoxBjQLN/8e9T3Fd67GN5Q91tLSAGCcVI+DhRg0Te04lN2fOGf8G22O4?=
 =?us-ascii?Q?k1PlYGED8BDRlv6Kz1c/msLJOeEKNIaA7gZwMgWycREKPb9XBDwAuX06z7wh?=
 =?us-ascii?Q?MUagkXCz+eiMQkEfZXZDoB5Z4NOUMGJ5q/M2oZgR7Qb/jKoiRFNrXpxK5lGj?=
 =?us-ascii?Q?v4HgyR2rICYEE5/HC58Yp0s28VmJpJ0YaQ4kpY7+w9xfxR/TM9yesl72Gq3/?=
 =?us-ascii?Q?gEgTRrwLEWCn6/u0/I8lIgqpOXfZkE2qWd11Tu9Xh+ctjifHrULbkreSpwHb?=
 =?us-ascii?Q?EKXunZnzrsRdXgKeIAyiAfSjAOmJnSaquIMKPDKnZNhYjNzlIFkpc/RXaJMN?=
 =?us-ascii?Q?ra2ARRoGmoYAeRTWiqdgCY98eFo1CG5sq4RSoTFsxXYbmLvvSRjflcFHkFYR?=
 =?us-ascii?Q?GXIPeJB+u2EjEy/SRGMwrQT8ti0vUto+WwefsC5M8INqvCEJzRTHen96vASh?=
 =?us-ascii?Q?sSmnsG1NeCMfzVx1sbBvHzCkwb2J/ySR6fpG4s/SopZfq9u2x2iWNDKD9ReA?=
 =?us-ascii?Q?w9vV4fRKv/NQPVqdLSUb9eI/XsDR3kQvZ3O9DLcSUXtjgjyPNW8BWMS7i7kE?=
 =?us-ascii?Q?L38b9DtX5lyLO2xB89qCTKvIdAlydU9b1iaeu5hGVn6V33Q//SR2uwHpJr0c?=
 =?us-ascii?Q?edJiNzMcFyAEZoZKXhaOY6cNoXj3LrlpimhbaWA7ywe2mcD1hf+pIHoizj2M?=
 =?us-ascii?Q?6w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd6a8c0-f6ad-4eeb-7ed3-08db245e256b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 07:31:37.8103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i30XAQCXFDtIV+Nwig21klPfbPdRd0O4TVbdCvHqLia4YC5b11DkUZ+SngWKGQJ9uYK0OxlQg1PTWSFFx/ovVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8759

This patch invokes chk_mptcp_info() to check mptcp_info of userspace PM.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 506120401abe..8ca5accd5c82 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -842,8 +842,11 @@ do_transfer()
 				tk=$(grep "type:1," "$evts_ns1" |
 				     sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q')
 				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
+				chk_mptcp_info subflows_1
 				sleep 1
 				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
+				sleep 1
+				chk_mptcp_info subflows_0
 			fi
 
 			counter=$((counter + 1))
@@ -906,11 +909,14 @@ do_transfer()
 				dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
 				ip netns exec ${connector_ns} ./pm_nl_ctl csf lip $addr lid $id \
 									rip $da rport $dp token $tk
+				chk_mptcp_info subflows_1
 				sleep 1
 				sp=$(grep "type:10" "$evts_ns2" |
 				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
 				ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
 									rip $da rport $dp token $tk
+				sleep 1
+				chk_mptcp_info subflows_0
 			fi
 			counter=$((counter + 1))
 			add_nr_ns2=$((add_nr_ns2 - 1))
@@ -3148,6 +3154,10 @@ endpoint_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
 		pm_nl_check_endpoint 0 "modif is allowed" \
 			$ns2 10.0.2.2 id 1 flags signal
+
+		chk_mptcp_info subflows_1
+		pm_nl_del_endpoint $ns2 1 10.0.2.2
+		chk_mptcp_info subflows_0
 		kill_tests_wait
 	fi
 
-- 
2.35.3

