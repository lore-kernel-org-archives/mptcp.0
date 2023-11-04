Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33837472
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eijwQscT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyKbcgNlTMHlHPPH1DkxJKTuD7Kc5TQeDhLcb6fmu7HE0/4BKRMJs61ibcO4cLND3lMcFZ/Sv+JcQDL+SDphaQRzoB5/ekGKK6yV7d8wF1KL0MBOQcObVrPGy4BADWeACI0WTMHfHMJrq215t8hJgsjlWabhn+7KVSQj1ljkDmhRpZyOoNeA9TrHRbQH90Pr6WwcpLFLi4Q2yZnxdX33VXeb/I/lRc3svtqVN3J2RvRmSUY9UwJe5WEtmdx8+2+Wxp9GzrS1s6poro6EKVhbTUCBWuVK6U5I74vd6KtRbiTHRwg5+4pZN5Tq8W6Le8wwy6eLouP0W0islCimhgexEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmlG2BtJ5D0TKRdWHuiNmNkxnLq2LDl1aM1UXtI2uQ4=;
 b=SguT89FgtqSkd/FTojK/iy4epMzEIhDJ3OwYFMQnHxcJp2Ch7e4pHRnAMoIO4h8bMJI4iUjX8lYjQuHRgbrxADYN32c/tcAIf2lIJ65KgGwQwrtRRUZ9lXAPyK0pdP0w7X5qNIpnh+8BeumC/taK5sLNbx56Xz9mc2WjkRhJO3jxD02SZ5pmjN7kEF+y5eWii6rqMhWFyWdC6jC8gPufVIp70wQppftcV56SMsXEHb34IGbwcGORjJy7KQszwDuZANBYv6JVQNifv4e9VrKHquxL3oD05Tf6KgqNkOs98b3YHnwjW1DKovQHmw5YC5SnErTBuHmNCJTtDzOgd+1dgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmlG2BtJ5D0TKRdWHuiNmNkxnLq2LDl1aM1UXtI2uQ4=;
 b=eijwQscTc/33CDR66Df8HD5+Q5h8whPbaZJ/J4LL8AY8gA1jawzT0GpCmrufKR221xSUpCL1TW9WHB5iYxHh/e4bJWk7kTfX5jA2mWVjzStbyST6UZ2boyApA9/Wi55gShXlJesBTudH+XWZ3DZOYa0iO2vpYz/Q3PTG1TWAMvQ0+q2L99Pt0QwevcfIcAXcnC2PGo1QpX34i7cvVaHjLf8Faugwy22tBpXY1Azxx/TUU9rOwr7p+8/K22//Xy3lOjklJpVZ/roztWwYX8OmdHJ4bWgTIId8QItS3/eikvKfMarjnuKepuw25hq1lHMDTWtpe0ZlnIwbr0qayucijQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8874.eurprd04.prod.outlook.com (2603:10a6:20b:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10; Sat, 4 Nov
 2023 08:36:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 08:36:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 09/12] selftests: mptcp: flush and dump userspace addrs list
Date: Sat,  4 Nov 2023 16:35:44 +0800
Message-Id: <9584b3f7d80c51431424d104647fd43fece39671.1699086244.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699086244.git.geliang.tang@suse.com>
References: <cover.1699086244.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: 6db8c582-4e7b-4d00-623c-08dbdd112c64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C8ygbgf2YGJ9heRyVU3CZbVFbWOp7Fi+pp1ipCEzntK+qFsZnKRf76OjoEZLV0MDYiKiIJVIwtPCHg50DAu1+v0p1UmUu9CQH5H9hGRDiOGLW+Ege+XzLD7MO4J1yeL0YENTSWcqNdLmeD4SSLXQCI1YDebdlLMkBcj43J0X7/8ZLW29XIAJTQJYWDZMLgOQz0/Azoksjl71GLUArZ9VeUWoYDDzPf9lfcuiwTB82UEczQQdGyjrCfbodQxdeGa0iimzqtXrWjgNMLf0CSpp2glJP5C1CbYGon6jkkbn01lT4YaakGpU+2ybbC7/sVssBPb+K48nFNM2rJUhuC/FQwuQmITqkbymGhatIJTEzfx42r/XhCeS+VN2afLn50qqLfevdjgPohgiouV1FZnugdppq9e53OtX9LHc8hDJauIhjpMmt/ea4WFyp9BmTwu1AdLuoS2nQLi3dv01UuRDjZb6CbkG81aL0YxanRAVL5SK/BDoHnDTl00mU1awnUEN/+CwKkVBlAY7/KMwR2kX2RlUtGXKL4hIFmzfKhwo6QkRF3xwMqrFxLejgYCMRTA1XJ1otkidYNBCYHHuk5Oyanme+ooPimtLGoIP8JIn5Ng=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(316002)(86362001)(107886003)(6486002)(8936002)(44832011)(4326008)(478600001)(66476007)(66556008)(41300700001)(66946007)(6916009)(8676002)(36756003)(26005)(5660300002)(2616005)(2906002)(6506007)(6512007)(38100700002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CbkscI2lnntpGQ16hCtOkHtnxXRvQ17vt6j/2euI7orjloc25p8RF3z1Qn7v?=
 =?us-ascii?Q?PJfjJQV5QvVMYU0HTJ+SIxllbblemhwhHkiLwkbecMXCE4/ArONw/g6KWIlo?=
 =?us-ascii?Q?E/6JVlE9nugxiL164SfrVXrooUQAqOkDVapr3GUN7DJ2E66r7rUXX4TLpKj5?=
 =?us-ascii?Q?aJ4ZmMjXw79D7yCWxf5aecAgrL8yq2pNuJ7tAxyz92BBe7EKPQAtsbNWb4up?=
 =?us-ascii?Q?DvZp/QwQqr5WqoZv2QDGxLjozBIE8azd7BVruud1CdVTCpiUu/E76T+OjMd5?=
 =?us-ascii?Q?Hdgxq3begh4ZxztbB9Ivn0WjRVV73MXjnWdVuFLEc2HpgMYnnjP5uTFiKZym?=
 =?us-ascii?Q?oDUulDCjutM1wVoKALV5OScscckZEOLDF14Hf/wES+CKIDiy4qlF8yCcK7tw?=
 =?us-ascii?Q?FjakCG/QwAd7D1W+ahjGDQ5Uu3As1PjAmDYvTye1T9Bd3tWfBnZ4gSTL/Yh2?=
 =?us-ascii?Q?nid6ROqyW3UQRyfo25O3iQdbC4cX7TW20tlsQfVMCJl1AvILSSic/wiDmm/6?=
 =?us-ascii?Q?lWdvKVcg0q4ezL7Bizxcl46kVKgpj4JUe188X4z5qpwnNwndLk2ljEXu9CSh?=
 =?us-ascii?Q?EH47wny9A7X7mdR1Dfl7GOc8Hjx6FeytTfZGT97AKwHUz06Erw/KiHWHJp3n?=
 =?us-ascii?Q?+mUFzkWbAngvh++HCEPD0cMfQd6lysefZ79l04gOPabzsHboTrZWYVpoZARK?=
 =?us-ascii?Q?0EzHOSxAmFgqTp3FjEMumgL8VW1YHeVZ6sBzEweGFzsiI6NMOn+4aha+v9XJ?=
 =?us-ascii?Q?HXXuRFA0CVb1SENH3OmI0tZHvLdU/R/RnyFHGBk6TrwonjNlwvY/ci9PCfjq?=
 =?us-ascii?Q?Io9ufsmzEEoST/BIQB4YwFsbnAB9krgGBYogn2KFOQvOO2olbcpf5aXZgHv+?=
 =?us-ascii?Q?ZwN+9VYWSsS/4Bv1nyiLukstWpO/00IQLOHGOgh8ZdzLsJ109AOrlAzjXR0I?=
 =?us-ascii?Q?OhZGGAA9JbdVXTHbMbQZQy3QqTmgCnKNWQ4bxFGc6LhE8OOB5MjF1+9yX4ub?=
 =?us-ascii?Q?VgUP5010W7B9i51q9Ag87TRhpQRdj8lzZlfFuLSP2AynAF+kdP2cDSG1kHgz?=
 =?us-ascii?Q?PxiSNumSDjWJUC/Dq3SmjLnzfhWvzpQnr/3EQ3EoNhmK8syOb/1Rufcn+609?=
 =?us-ascii?Q?mZJTzsb4i0vrJ0Fvvwl/+wNQihTgNkzmrRyXe8m4h4B7vCC41sn0DACnKeh4?=
 =?us-ascii?Q?n00SNhp18AD1PhO+YAr8WgVSLmdgouWDQyjyZP75Zi+EXAxQM0xVwDy0V3ZX?=
 =?us-ascii?Q?GGwlyHUiVjsmJ5ijWB7/AIAZB/cDT2zk+uathbMNp0/GDUUP2ZUjF3ecTx77?=
 =?us-ascii?Q?ssaQhpuBJCn7FIcjaXI5FHDJQnW9PGtG4CxrSUUT3ACaTrJMB8MuUEUcxsyz?=
 =?us-ascii?Q?ljEMbIXJRTs05nySZ/S8cDJWeztr+c60ML42WTSUwHfY2IQcbMYQ6TDaBQoh?=
 =?us-ascii?Q?/AV1gutplskkRH3oQsBTsDH0ywbpGr7zkEEa9pzZD2qxaZjqbxdeKE5nT5Wg?=
 =?us-ascii?Q?U5Y7xKWjWmGToiDYpRzWk93fHh1T0zqISSF7lPcoaxz1KWK0aOt2T4MR3W8Y?=
 =?us-ascii?Q?bAjZu6U55HNIVZPdj+oWIvdYU/EcPnh5UR5JGvRMCmEhoxuxOFm//C/Yo+vV?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db8c582-4e7b-4d00-623c-08dbdd112c64
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 08:36:43.2984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WZasoS/Y70lDfHYQAMCPs5Q7Kfwg+RE4Z1SxTLq/VB2wpWT1OPR69ZCCICPf+hPZQ7uOlkDX+uLkN35cPUasQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8874

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

