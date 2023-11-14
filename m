Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2083.outbound.protection.outlook.com [40.107.8.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B489C2F29
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZB5dElUZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ix8BLf9o3O+AD5gppmJ2UtBqyHwpc7KX/042nwzUY3epsptNhLUzrXgYoRxcfYZKHIojB82tFGDZldqjYDuK4WwwxeMgoPQPA9ZsXAdBP8PVptMZ8/8O3O8UdG7eQznJw9XueyHKNginE1rC/pyP+QUCF37TtKFVIMuuyBSukKOArrNDt+L+O+tX5oOrcQ3W3+FLvTUZ9pTdXv7roOuT/fip+BRRp7e1v7oFaogfmeXpdnhwAZouLwYPvpBOZuVpr1bOAlsIPvF31VV+cTxSK82D2b2Y6acfQfk2IdUiRNGnj9Jh+P1/0EDANKB4B4fJ69w3EOC5Dxyx2qCE9yAUuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsDSQWjynadFk0+3YAr/Uvp2fbP2u1LoAunk8fUy5mo=;
 b=QUsK+1k9MSOwEklRW6swgU+RU+QUB4YWZrjXKag+7RcMkvJ2Nreft9v0Z3DeX9+wo10TkbttpAyrEpqZWcWFLmv1yrwP7/5eatGScBW9OqLgycqQCqW3MAfaMcy5q+mNzEKqCY713c2ntCLpud8XGUlYXEhFdxfXwDCl3PaJociHnB9j8Yrp2LHVCNwTCLVOzhM45qFlUCxFQG1+n93qN2zvsRVM0HOUlBo5gFYxXBQVC5pK7s68MJ4BbvYCG2DzPb75HAw6BMKKBrD2uhTuY/gDVbn/SiWMItc8PpNSb48Wo7tIScEkwBwY05OkNZzZFX2WDc8X0uTPrVJOP1WlEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsDSQWjynadFk0+3YAr/Uvp2fbP2u1LoAunk8fUy5mo=;
 b=ZB5dElUZxBFi5PmSNfUFjAJOoQ/IgdR98BLAcQMEMVMucS6J4Wf2VkHkSr745/wooLe2rgxUR4JgG61aylWeFGGUybJ1099fXDTjaXCCP4syMAQWvYU9+qWKBtLYB+A9R+q7XgW72iT4+iZs6p+rnWtZYJzbeyIp+idFMp0jHei4ipxDQNqCmNnQwbNhtS9oA37ldRiySzrdoT6HCpkawLjnt2Wc/IbMVjLqiqDY5o2sVhroRxWdJlhps8BPIPvrouHNElqvZNBPdVxjq08pJVaWXoENgFtOOJg8RMdyCwQdptAlAIYbMOu5jnwdq4cePJ81wgNPcoutRrMbUYZ8ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7451.eurprd04.prod.outlook.com (2603:10a6:102:93::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 06:37:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:37:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 21/21] selftests: mptcp: rm userspace addr with random order
Date: Tue, 14 Nov 2023 14:35:18 +0800
Message-Id: <67568899e98f205deb8107dac5b623f68655ccdf.1699942931.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699942931.git.geliang.tang@suse.com>
References: <cover.1699942931.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:196::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 62afd3ba-7c22-460f-94d3-08dbe4dc3a7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	15Wg5m26poR3EJEb6/cdwl8MkODi/UuAejsx+y/VifhU8Cc3/4Ly132Y2kD3skSSlNSV6IDXTRCYdmvWqI7/OyPMmULu36brlTGlqRhfx9ZTnPc5k3IZBpFP+pimR2yslQSBF4D97VDgrD2MbSV543TGXCwMWeV1XJCN/J0hrs5aEUWr/PPGfv3NxNmXbyS+qY35LMHXnUb/ZPFB7fXipK+u8iCtzw3HXix30dC7SVN+EGgzsLeBzs31QLUDzfhOz28kE3+ooC7mRx6N+slSK02UIyS30/q4ordzNmLzytzlgIgcsdh+X2mVBz13Q3YwF39GQS9YZQ3lJiEGy14x15taQgbYZ5Qy67/XzgLdyNHgf0q5ipx3rn8D6Pq5RTGmcbybctfm5vHmOzs6aLATRPJ6729xoHHARYUiIf2duZ40nCfsPohSkHchLfbwTlkicjo58wSc99CrMptnM3zTwlFB4J4ujZ/Tv8zPZYwjdLFS709BxAwK58tl+v8iO1zW8gqcKic9sGvOl+00VZ5MXyaNTaDHBER38UUNhFBsLC5kB0DCABBUTs+Q6m8fw+oj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(366004)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(41300700001)(2906002)(44832011)(36756003)(8936002)(4326008)(8676002)(316002)(66946007)(6916009)(66476007)(66556008)(86362001)(5660300002)(6486002)(478600001)(6666004)(83380400001)(6506007)(26005)(38100700002)(6512007)(2616005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hsf4rMg8IcUYUe/Tvdos+qeN791kvItv2JryqYk4qUbQN+FjEY7GeKiaOvxM?=
 =?us-ascii?Q?BrMuoZYGZtVCTI2IWwqVtGLTRCyMooJDhFc7jspIQwAlIuZ92UxVrrrb7Ft6?=
 =?us-ascii?Q?x5zwDFuHFjaiwVHUZgJxfRP5kL6INxCTxC/VPIpX0KGTOTE0Oep41w2oC/7c?=
 =?us-ascii?Q?bjo3tEf0scNqdmMLqErmBHiHx8LDSRotEPwYfhVYSZghEzfn+Up2zrL9dc3g?=
 =?us-ascii?Q?3BKBC2cX3MGRysiVA1si21yh65dHolm0ufOPWJMbZf8UKysyGPDvyJjCpAOq?=
 =?us-ascii?Q?CVnw+fklk4Dmj194oWV91U3kEv/yt4syAeYir/YZ7M1hGRxwP6gCR+T/KIMa?=
 =?us-ascii?Q?skKakVNp574uu0xbloiNu0zozNkSo5+xoVlRrvgGARhvn4jT7dnz2jnfEBgU?=
 =?us-ascii?Q?/kapSuuFbbCW3zwd3gBHW2DpK3xai29omw9AZ3pv9Vo9iIDHmeMahXty5rTD?=
 =?us-ascii?Q?JG9PxdR/ZU3Kf6QI7M1OmyqZlVpsuym7XBWCW8xJ+pMmMT65NonaKclnjTJt?=
 =?us-ascii?Q?rmyIQY2Pc7b3OUQuAXQK4U2HNlPVjnLveLuTHNbhLVeseDQJ/xdw+IOuGvVd?=
 =?us-ascii?Q?OorcL5y/diQPFrXb1tKiP59flDl1LC4ooWJdUplpIuONPtN6k/nq9cIDlcDH?=
 =?us-ascii?Q?oZ5VJoTduocURXQea9+UZax+qPz9IBejDqgKE7KTgt1lLDWJ1R34aOROdtIo?=
 =?us-ascii?Q?U8H7ma0hnRkVZxbDRFO10+OnKjRiTI1T7QXl/M9CQLIbRrKoOBCVRQtJotRH?=
 =?us-ascii?Q?x7WzN1V3kjXGCUskvk3ePnJM69yZxkCj8StjYm8gIxWRstEjXzzqODRZtTTS?=
 =?us-ascii?Q?gBG9Ipijx+l1wrlB/H2mV7q1Nx5mrMhB6PjUb1LrcpIHIRjHj7cY4fpN1Kyw?=
 =?us-ascii?Q?Xh/+h3heQ7Ba877xddUk3f1XFsTJdsiInYg8GuVDSf7k2dWGcRx3cgwadrCo?=
 =?us-ascii?Q?fi6G7bn+D3QGRpKaWkV7DNz+VDPCJeMTPVhcKucHdtrn2/NRQmw7D30KWo3q?=
 =?us-ascii?Q?yNDANszNidZ8qldrXYs5x3cTgH8O2+RT94LePp7DyvF/HwiNsgAEnuYG62Rj?=
 =?us-ascii?Q?OjSvh/UBES90atYPgz6szaalknaOmUWk+CMlX5wOj++/ljQwKsXEuWG9gfOm?=
 =?us-ascii?Q?WpOox6Hz3ZNnuvkW3ih1TGhz3zLeWd+3ktVClFcprp9LLoMK24iBmyE6uGCa?=
 =?us-ascii?Q?uFeCGnFKmyRPDauTuJb2+PcszoS2BGYcj7ho+hLs6B/45nBorsASP53wHJp8?=
 =?us-ascii?Q?uD4on2/JXHM79ZCaoL3BK/0DT4NMpCYQ+QlUyWi1CDIKkaITN+FrvjbyP93z?=
 =?us-ascii?Q?yXQ3XoDgG0w51c4TKt3PSkllxv66Sw+dnTQZO+b/bHjBCWAP89DcYEePLPQb?=
 =?us-ascii?Q?9ZoIgo3rdS8WIUyWe1bHjTXCvaak2UspYEI39hFywwTOL4Ut336KaeJaDu6j?=
 =?us-ascii?Q?qmgwOH1OHOrIhpQERN0W6Wf+o6uefposzIidVWN5hSyDjzr+htGk57Aas1hn?=
 =?us-ascii?Q?KqPeHT7RNPTTLwu2UoM7xqhSqaofcJCxGk0jsPpcVtiC5JfjhGq2s45SrAtv?=
 =?us-ascii?Q?U0bePm+TcJWDBZfXN49oyLXoVJ3eBgtdB2bVtFPbjtg0t4d49qivCQ8hcPWc?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62afd3ba-7c22-460f-94d3-08dbe4dc3a7f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:37:52.9679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: se3P581dajETHGQF3SnN3Io/1OEFu2pRu18n+7gHeTxHwZF5PQNp6bdU0A7qhpfD0PX/1Thh+DSmvN5rJZE9Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7451

Previously, when deleting a userspace address and subflow, it was necessary
to follow the current order of deleting the address and then deleting the
subflow. With this series of changes, addresses and subflows can be deleted
in any order. This patch uses random numbers to add this type of tests.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a027cb229dbe..24a55f7622f3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3413,8 +3413,13 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
-		userspace_pm_rm_addr $ns1 10
-		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
+		local rm_addr="userspace_pm_rm_addr $ns1 10"
+		local rm_sf="userspace_pm_rm_sf $ns1 ::ffff:10.0.2.1 $SUB_ESTABLISHED"
+		if [ $((RANDOM%2)) -eq 0 ]; then
+			$($rm_addr); $($rm_sf)
+		else
+			$($rm_sf); $($rm_addr)
+		fi
 		chk_rm_nr 1 1 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
-- 
2.35.3

