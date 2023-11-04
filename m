Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2087.outbound.protection.outlook.com [40.107.15.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE607472
	for <mptcp@lists.linux.dev>; Sat,  4 Nov 2023 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="p8xOe404"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScgpmvcdVQed2iwQyvYhkCjRoyusGcfTIvHy3qMDJ/1MaJ8se5E22PihZ3Zn9BBrPZySRPFjzRIzvEWLpCEdwu4a+x2Dz/iZgR2x57gftow9RNSftiKQJ/Z9Ck4A/jcmS3NOBrlP7v42wgx1vXNmf5TXIW3hPh7WX4/4EwOPc0ArFrsRK/uAdB8nqEShXcDTRDFmTivBSGSG0MbzUDeJSg5E+p4Jr0XZh5/Mq2GLDAwz9/BQ6H4W/EGQ0G0phlJDfpzUMFo06NK8smX4jJxhle8+u9uxDW4aKmO9ofh6eVWQdEi6Fjra7HxxovzlN/EDr3AGD1BZIe98dRMCp/ULEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZaQm2NohJlVpeSBHV9Yj8zp/QYbK9JoDo6m9oRamo4=;
 b=czQ/GWNiXD/FnReYZ0k8bFCzd/yDtl2oThsDSLaLm+J5X0HsEivEtz5MJkitRgd04tjaJ7mzBH4G9bE8p9ZzFEC1tgM6ONtQYhLlg1+pVEb3j85j8GWBCOsj82M9V2+d5QWH1sOiEyzz5C73EchwKaQUS9Phm/MYpFlhRQ1wHMmtpifXiJBORRdt/xC2uxc/WMDaL5rBoL3VJkD60vng/5tHKFAVEGNFVSK+tIPS39wHYhgNpkpebWR75aW4Sk0TeuqPr3vDDSAamyjQTcEnHM9SaQWqhTnVLMFq8Irh6ICsxA1JnKrnP1IirxrBgC7MHrjEhh8sA3fOKKrGz6ZEXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZaQm2NohJlVpeSBHV9Yj8zp/QYbK9JoDo6m9oRamo4=;
 b=p8xOe404upW6RTxjGqaD8zO8cEltQxP4lELE0fKCIJA7DItxnzurBDi3jDiGwxMkfeXVB3MkLLDzGlm0a+PCRMpjF7OmKQioUXjwZ8aQ4FWsWiZqGMBHXRIajykTYSsMfOsG2yZSEA0McM3hTMAxzAOpU5lMWc3CirV71q+W/kK2cetQXKTWFY8rtfhKoIcPb3HBmhaChJo5WICw+UTftiIOxn8QAh5v/gpZqsQT8k1Zg/RotURT1nGjkAObRGD0qyuBHKyLey3IMtE2XXZbvK7x8rMrZ5y5FbOjLVi1jmFdxZfd4UiSENunHMSyCOjoJ5QjyKyVgUrZzu5XpElleA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7681.eurprd04.prod.outlook.com (2603:10a6:20b:286::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Sat, 4 Nov
 2023 08:38:00 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Sat, 4 Nov 2023
 08:38:00 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 10/12] selftests: mptcp: extract mptcp_lib_check_expected
Date: Sat,  4 Nov 2023 16:35:58 +0800
Message-Id: <5d075a12fbf93693a5a39da0599a296be2a46ebd.1699086300.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699086300.git.geliang.tang@suse.com>
References: <cover.1699086300.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0139.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: d04b33e8-3196-4e8c-afe9-08dbdd115a50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gfwbzS+Qd/CVL7QR2K/c8yRU+r+i/32A256gDxWq3opnX/rcOobp1NMFtwjVHA8Lj5J4c2q+eqHUnALrjUZBGGC95jeDge4XT0FMpnMWcbt8U4DO1I8sc9k/Xfhvj97NM6BG0+VVhLVabVgj4renk8Q3BpqSgguGJ+G43t8MGWu9BF2RBO0/5XDvzE5LiYolwX48G2QwjwC+tlAWbyaS/jvx0nDN6va9G1lAbaZnPdlymwXgUXMOLTSG2fO+g9SI36xvbBJ0FLtgOpWeT5lwxcr5UkOVwt5VRmHXLOy7CBZOK7h5IA9b4LEM6kyoIJFrixl2KWC2FyOxeCSkb/zmW2WgS9wQjjcT6QYqVwLv38mAd+DxfrTa7+JTdrokf4RmWQ/Snk67ltbtURgcCfl2zO1NoUoEWQaq2PzgW0uJALQNqM4QBQk0q2hn5J0gghpTm9e6S5upqCeAB5bUVEwAeXh5nCopXjeqiJmdfdfwYFGWDcujEDYz1KaOrb2+wJQPJ702jmWGGnY1ZJg6RDYY3mNnex48/KjJVKNjJQgF3EX81gtv/WEFsAecThMJuRSME+iycCQP46PC7LX8noG9AqMtFyD3VBiRlvgKMYRGkDw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(36756003)(86362001)(2906002)(6506007)(6512007)(6486002)(44832011)(478600001)(41300700001)(8676002)(8936002)(26005)(107886003)(83380400001)(2616005)(4326008)(66476007)(66946007)(66556008)(6916009)(38100700002)(316002)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/ghgEO6KTcT2LoaGAA2NRXZuHS+U/TJs3ZxuaSKEkSJBMQv040X9b8SgWKdT?=
 =?us-ascii?Q?VJ6jynoOeiIZT0dSMR7blPW/pMyDSOREAqNPPVF/DfXS/IROqOfO3NxNg7V2?=
 =?us-ascii?Q?bBZNe3mimRKAoBE+bWgCblHCnD3+q7cacdt6mo79bAV2S3kVeNhVi4ECBpSM?=
 =?us-ascii?Q?+SOlqroYemUnOzpp1euRosbgEwkOr52W26tnTF91SuxvoIfoVl9+j2tSmr0L?=
 =?us-ascii?Q?2AxDVVaqZBJIQ2bLOct8CH56P8jWL+DWidGKniEBAW7ffSLimjU6Mmj0QHXY?=
 =?us-ascii?Q?lwJ8oqD5N83y6Gw45WQt2ja/0RwY6/BxcVv7YOXf6utrKJaEXvnCCSF5KshS?=
 =?us-ascii?Q?1M/jf1AW26C+u0EoemPaQK9ys3nlgSVS8ralA+LEFNVR6eVfy0ZTNmoJuo8M?=
 =?us-ascii?Q?6ubcEYKqN48+lL3G9Cxjv267X5e2nLiCal5lj0SA0fym+X+Tvc/XuPRGLyrP?=
 =?us-ascii?Q?tW1Oj3FFz6ws2VL32uqJzKRiu0KkW1qblGcsL4GZb6e/iw6VqyKYjFnxIG5m?=
 =?us-ascii?Q?q2hq1+2ZQ3YiIxiDgpcF/LNbXkb0JIaMptcfYyZK6upKspHMRLXiZ040zlR2?=
 =?us-ascii?Q?MfMMgiCCcXfHPtQAce0wb9Ji7IWQlzY2z9GWn48lmgBediQTxjtcEF/T58BR?=
 =?us-ascii?Q?RvonFaJCFWKXFCh+ESso32MK2V9qD867gVt+UFmVBzROOZ6qMBAYPCX93Iyg?=
 =?us-ascii?Q?KviFWte9CHW3P2k6xXgzE/1JT6kXSkvVpPhwl+x8SiEW7nnqjpF8RUq96uyg?=
 =?us-ascii?Q?CNG2/uPktrxNzU2jVZ5m1s2BkHRAuhU12+Cvf73evw0w/SXI6dU14HHNCtYQ?=
 =?us-ascii?Q?FhkstvyOwIEHBaCaDQnIquQ0KrnRqlAqUDSYlm074Kjfd30PMI54nWVJYwPT?=
 =?us-ascii?Q?otGsXXuMcAri6kDDyLAq8T3DdqlAA8iLE/APKH29/lN+KrmqA3l3urYGqz7a?=
 =?us-ascii?Q?/zxyDeIkwPLSbkMV6bEwaE2EaiKNje0KrBtBrG/spzLdq/6LmTSnOI7zazum?=
 =?us-ascii?Q?BLv7tqKsse5+JU/kT8eD+DVyvXDXqH8jlk67AjWrnspuchOH5dbEkrFMxAs+?=
 =?us-ascii?Q?5eN5PFC2d2GJRMp5hOlCpLVK4eAnjtDjzRDvwk7cHyXw23BU1/j7Srdy9CYS?=
 =?us-ascii?Q?ouLVPDnfves2GudCuKOlVwjgLXhqkFYDdtEw95cn0Z6SQcCkX2ZiqN80Obet?=
 =?us-ascii?Q?vOAqHtqU+PwOyNWvkwG12caCFMzXOsBPJFs+M9q4Jl0+Z04aAGNoPiGlpNLp?=
 =?us-ascii?Q?peMqDD0zi1ulxnuYCc4j/Zyeb5UtCLS61cEYA+D1+Xc180vT9IPacDEGbSSO?=
 =?us-ascii?Q?EZGZ67GSCrI3lqfJU6G/3OFx/MOcimaPP2OriTreNE3pdgc6gE+i/ag6fWd2?=
 =?us-ascii?Q?HubUssBAZkDdNjc+OEQcjnsYxctAWZHOK8oA/Gp+9hYT6Sqc4riz/UEX8jk5?=
 =?us-ascii?Q?IFOqZ/0nM62w6nuTXCnFguunJi0SSdLPk2btMfhitEE04aAk07ZqEYxjzWfX?=
 =?us-ascii?Q?iPFrV95+C5sMUvMxIzPRpFY7BO7qGfFiWHybNOUId68L3YEswckyn9QOEsL5?=
 =?us-ascii?Q?/sE00WjyJT6Ll/JJk0WeHlumGoS0M3+86O53wQPnrC1BBWq4RaujTkjcHDBS?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d04b33e8-3196-4e8c-afe9-08dbdd115a50
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 08:38:00.5942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TUI7t0tz6gx2HxGOH94YYlHvA6jdUr/Ce4UHj3TfVjhl3nfGwjRn8fy79bfzBB/yoToXYfxr7dmpvaeAq080Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7681

Extract the main part of check_expected() in userspace_pm.sh to a new
function mptcp_lib_check_expected() in mptcp_lib.sh. It will be used
in both mptcp_john.sh and userspace_pm.sh.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 42 +++++++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 39 +----------------
 2 files changed, 44 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index ffd78187237b..68b07216e47a 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -369,3 +369,45 @@ mptcp_lib_evts_remove() {
 
 	rm -rf "${server_evts}" "${client_evts}"
 }
+
+# $1: var name ; $2: prev ret
+mptcp_lib_check_expected_one()
+{
+	local var="${1}"
+	local exp="e_${var}"
+	local prev_ret="${2}"
+
+	if [ "${!var}" = "${!exp}" ]
+	then
+		return 0
+	fi
+
+	if [ "${prev_ret}" = "0" ]
+	then
+		mptcp_lib_result_fail
+	fi
+
+	printf "\tExpected value for '%s': '%s', got '%s'.\n" \
+		"${var}" "${!exp}" "${!var}"
+	return 1
+}
+
+# $@: all var names to check
+mptcp_lib_check_expected()
+{
+	local rc=0
+	local var
+
+	for var in "${@}"
+	do
+		mptcp_lib_check_expected_one "${var}" "${rc}" || rc=1
+	done
+
+	if [ ${rc} -eq 0 ]
+	then
+		mptcp_lib_print_ok "[ ok ]"
+		return 0
+	fi
+
+	return 1
+}
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index fb05d207fa44..6a84e563b2ca 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -231,46 +231,11 @@ make_connection()
 	fi
 }
 
-# $1: var name ; $2: prev ret
-check_expected_one()
-{
-	local var="${1}"
-	local exp="e_${var}"
-	local prev_ret="${2}"
-
-	if [ "${!var}" = "${!exp}" ]
-	then
-		return 0
-	fi
-
-	if [ "${prev_ret}" = "0" ]
-	then
-		test_fail
-	fi
-
-	_printf "\tExpected value for '%s': '%s', got '%s'.\n" \
-		"${var}" "${!exp}" "${!var}"
-	return 1
-}
-
 # $@: all var names to check
 check_expected()
 {
-	local rc=0
-	local var
-
-	for var in "${@}"
-	do
-		check_expected_one "${var}" "${rc}" || rc=1
-	done
-
-	if [ ${rc} -eq 0 ]
-	then
-		test_pass
-		return 0
-	fi
-
-	return 1
+	mptcp_lib_check_expected ${*}
+	[ $? -eq 0 ] && mptcp_lib_result_pass "${TEST_NAME}"
 }
 
 verify_announce_event()
-- 
2.35.3

