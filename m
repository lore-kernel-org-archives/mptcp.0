Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2049.outbound.protection.outlook.com [40.107.104.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3419835888
	for <mptcp@lists.linux.dev>; Tue, 28 Nov 2023 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O1cs/0BK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ij2ieSX1Fz2iddc86+goJ14ftCRJdoy6IqNRfmU0RbDEHrWdbvfO+i/MF5nLzagQ2P833eVA50Qwn0CK2lHpfLDLezPiZv6ufA1CgomGz0eOg5jlNMSQFPs1NDo51HvkqjeHXvblQArlVrzrlKlIFF4MA3LXYJbM2Sn9hIzySa9gUbdMgUvP6KZ8c42UZkGJL6qqtnzekP5kc+aBxXYkH6Hvf1OpebyiA/QNPq0aTp5qM0oId92raZbCVOptI8IFr/H5dkhExPxpKGBIGJ0CcLHSpuSrYEjyLvdVc8TXzfJYJTl0LkiOCe//HD00CENDUff+RuXZmihdSis4mYDFHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1p27bizs9UmTXBRz1zh1Pad4C1GettBC50AN4T/Y9s=;
 b=FLlP3NRbm7NZoQ5jgeMyjouvQ50mf2XTwLVdbWrxJXk3+xTTOFiBIWwKL+KZzSJIpOBKh8oZhHEx6NZPFeh+6HNaIWVL4fViI3x443ArTOjGbdnbjtGRR/YshsWg2Vq73TvLpNsMbkaPhbLbWTPQ17AF0ld506z9bvqoSnkmC7Gk4EhAbI5g29EoEKS7HStqz+b5K8bZaZt3RC2hpFrpxSlbL6eXxQ9tMB6GKR+lv8hWy6mz/Yz/L5QSq4adSYm0a2l71thSlG27QCwdLCXEBrVw7TXQFVffUgvKq2S6Q/uA9tpyeOeAgCKMuXyPIdIpex8PjeMZ9vSWP4wdGl6ahA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1p27bizs9UmTXBRz1zh1Pad4C1GettBC50AN4T/Y9s=;
 b=O1cs/0BK3BdSnuFRMfa0s3VfyT63hqyk+iVuPIhceg11pO47rf9CHggXFavXK9SOIZInuBD93LRm0rddZQeCmiPXQAYZLT1HX/qiEQcTjui5l+jhxVaDErlXVFfiMVj3S5/xGzbowJyUN0TxTy6u8rh6u2YCJtaX4wtzDGvucWk0yFD+0Yz+/P1FwFePohZmooeTutzVZKrgzn/8ML0ISohXYJ9iNdGnzbWHEKhQPEU5zJAapFPZrDAAOeMCepnz+gNuvzkedSS1ZrAHhm2uxsOQ9dhLbHFk+ENYjSwOjAZXE2Lmpa75t+bPK4J9XzyfSXdR7CfytTmx22N3vaBNRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7045.eurprd04.prod.outlook.com (2603:10a6:20b:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 14:23:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 14:23:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 17/32] selftests: mptcp: dump after creating id 0 subflow
Date: Tue, 28 Nov 2023 22:22:10 +0800
Message-Id: <5a6e91b8eab1b36a5a090a089c112e6469144159.1701180969.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1701180969.git.geliang.tang@suse.com>
References: <cover.1701180969.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f89423f-315a-4734-7c68-08dbf01da472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PukoES58MACEOFrAlNnz9N8RpMIxTwq1FbPJL47XIsDvxOX5t8OLhIX7rCyIvrSBNoLU430GwoTOqxKr8jPxT37+8+WZ9aV10l77SujknNu4AvPS0bhomXrBg478NOtz2SltzE1bOvkc6Oqt88MVeSxwOPMTEaAmcjlwWlIcn1xf1htME06xvtPdrgYgOFcjAXZcWHCQ/vR6GY5s/Ou/CLBmwz8An4uKKeykLzNUSKU5uua++NVFvthlCZ0MdNn8KEODsWyhKb459rMsrs8F2k9zJl4XDje1xpsX31fCkG9AzfEFydXq4hpbn64lxZarUrEtng2XH9uXXc2or1LEzbwfwz+hfRH52eVrjf/XqnCaPSHmnbTIn23x3/irDhnHFRa8JQiIKDwKYK/IIcyymQxUSBe/vOn/tRSq9QJbta2NrCBrpAe5j208fBqoNF5+U8scyaCnmioLtLgHo7quLE5BKuMfnAucm/HdpTu8ZFKNScRYj2B2K4S1PFdnUfe9AQa8nHREG2JWSmQaEbr+0DLf75L7j4Bd6oMVfH6wDxyAT9NPyFKiCXnqWSKw0z4U
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6916009)(66476007)(316002)(66946007)(4326008)(66556008)(8936002)(8676002)(478600001)(6486002)(36756003)(44832011)(86362001)(4744005)(5660300002)(2906002)(38100700002)(26005)(107886003)(2616005)(6506007)(41300700001)(6666004)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VxrH+E87oOtMpBx8h3XoG1Tz3/hlvbZCnX7Z4Kqp08xSnHwvj96KZLVt5sqt?=
 =?us-ascii?Q?eRDPsZpZ94ijZi+OyLk56CrUC/AZwu1MXWtjciPddUi46PwGkqOttPj5/XgA?=
 =?us-ascii?Q?KFkoGyM/DzDmypEomRUJErR3Jqh6FOZ/p67v+YdQtTwSEhb2M5V4uduaN++q?=
 =?us-ascii?Q?YPR5XDnng0VjxciBImDgqr/vVIVE1illPflku4wT5DMwJfuYi7/hjfKZ8S93?=
 =?us-ascii?Q?qdtGsu13OYBxTse3EVfVJTNx3zLtpMm10r3IcMa4TRiWw+zTXLFd7KC+oO4z?=
 =?us-ascii?Q?09IUSardrs2QGfhbv0IpPFFk2fWMSLWfQOGjMxnDOpo+EP4hGHnUgE+c+AlC?=
 =?us-ascii?Q?mW6XjvQIhkaE9f/4reILXkOJSiLYNxc1K85EWXIeFfG84CL/rd4W1eQgHzt9?=
 =?us-ascii?Q?IYshFP6qA/D8RC16CwQ4DH8NAcDbeMCriNdgFUAwLWj190A9hqYgEuLolTHm?=
 =?us-ascii?Q?5aQvYhWurf8cOApPj/QRCjIMFfR8SZyTQZSDbtf2sdNK57y+G7aNJZ30g7am?=
 =?us-ascii?Q?UvAFW5lbOW0o4cS4HwYEXBB/kdq1iLzfMdS2+sagl16mJH5w6+VZLnq3cnNn?=
 =?us-ascii?Q?w7YPsnYeCip2+qslnZu3AOLGfqqCxazUlz6p92pFwJwSoQUZlHpmOjE4BLYC?=
 =?us-ascii?Q?sddquKF/0S6gwxGB7Q5qANsC0ftsXmWEl+BYxDN4zsYJMoP+IeUsdi9o4WF5?=
 =?us-ascii?Q?+HE/y9w6YxCKxgEbHKFyuuH68tJPAtieylxZtaGFGj4n6IzKIyKOpX2Si7T7?=
 =?us-ascii?Q?vUFBGG249gKAJXdpQe0wJzfh9OQCkX+XVNnkF2C+LYpq9sKx2PpW+NUk17cG?=
 =?us-ascii?Q?pqi+NbOGFhlYC2xReG4QZXzzCixxzfvQjncGrDQc0j+f4D93oUltatOxu20j?=
 =?us-ascii?Q?/4HiCZZek4QWacSKlnl+KcRNDiyCYnG7UepuxDFnPiT354u/vICAx50soM26?=
 =?us-ascii?Q?WxpMxZ/Q8vsZ6jWUxpsXx1W4HI7YGBEX1No8AV79ArhZ7hinlzVUMDVN0qtU?=
 =?us-ascii?Q?lDaoSt9JO2mcO1yKHef1/OBX1RX03m4UYQJYmZM0d9eHjwN9E5il3T8krMkj?=
 =?us-ascii?Q?8ysxsQMHBLgna5ODgxsuCWum7TMS9e2Ie8fNWkEp7J2XpntZzzohyACJa/aW?=
 =?us-ascii?Q?EbUQ+H0LJhqdfALQIosBSMm5C3WHY9prNkBo8jqc7KRh6Uaq3JZfs37Icjoh?=
 =?us-ascii?Q?XGzDVw9iKJVEdskS+FlyHGgFXKdMoZlWgXpnp7o0USR1ok45Mq1y9ifnnT7u?=
 =?us-ascii?Q?8PanzA7t39ptwWWXPeNYR6Y4MF67/ezoh6TTgtMkVKwxRmnhYERZbf14yIAC?=
 =?us-ascii?Q?h3LC+y2pww04jlqo/6+T0mjq4fZ+DtNYQY3Bk/haaCEudN3WexrVOf6uvYa/?=
 =?us-ascii?Q?vHnQvzx+WG2OK0oFqG8KcLgpNdVleBb1/Lr3uZRH4PBcIB/LVwzXQOY3/L2h?=
 =?us-ascii?Q?ttEdduxXX9dV1BOYIr6O9rahCNxk/Ss1tjjcRfrTInqdLg63bHVfQjVtRlSa?=
 =?us-ascii?Q?wz4vsHeF7xyks3XwH8mWM4hvKxRkkTWcu1e6QOC/YknTV4UOWJRrS19Qudb7?=
 =?us-ascii?Q?gg4zE2qQWIbabZf6gzRsoY4f7ua9KezVIspZ3+I2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f89423f-315a-4734-7c68-08dbf01da472
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:23:50.7744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9m6Ch1ACsrZLZdRw5sE7K3vUc+/vAbSdQuafI/C/TyMXR/DV9SnCzVw4V/DtDlR38iPp1NfU1uqVyLJhu+NyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7045

The output of dump command after creating a ID 0 subflow should be
empty. Since ID 0 address doesn't list by dump command. This patch
uses mptcp_lib_check_output() helper to check whether the output is
empty in "userspace pm create id 0 subflow" test.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 574aaf5372c0..ce5b5b71e508 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3454,6 +3454,8 @@ userspace_tests()
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		userspace_pm_add_sf $ns2 10.0.3.2 0
+		mptcp_lib_check_output "pm_nl_show_endpoints $ns2" \
+				       "" "      dump addrs id 0 subflow"
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
-- 
2.35.3

