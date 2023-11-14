Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2011216412
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="jVjFX+la"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USY09buL0DsmBSS25VTqvwl58zjpZgDRsCzkvPFvlCM1ezqx4qAOrv28sjQ9fMh6PxkvC4A//Wfo3DdbQZo1NvvJs4daYfbvM/Y+cd2GTmqSJkcq67XpvJBeAgdgQr2OuH3UrN40SvsGLDqQiHeGW5Lp0mAAKLRmquQF4Srix+zPP+WNwmS1HOKj9F+j2ItpO2kU12xCFR272qUgwwhWwdvx7QiEmpK0EZCfQ3ZxlpRsDXZsZz2YKy/Oxqy3paUCcr836a1BryS0r2Jt7RNBmPemKxd1B1mV6NBaCJ6e8+RICjdtoyDRImkAyCvPDhf8QlIxr/tx9zbpEU9euaTwdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T38sL+r3/wWcw1Yc3opwLZGblto/rvJgRPxzV6SkvKU=;
 b=hJUcerK9kNfASWar7uI3ORtpRkMAQgNB2Ciq2Q161yv4s2muQMeyAJyBptr8HIBoYW+z15Wo2U+g1FCN6VpJMbdSAhL7PIM9G/gCxcDlx0TIexxRtQWfoyQTkSV56zFrR3YqKuwtCjMrYLZB4P/RoShdmXwNFFpgQfPxHty7hd1UU3GmtkF/fMkgbFBr3/hZ8lkkHuK6/y5fklDNzjErWRtk/L1ca0zVJ7uhckHakaU89tQxzQRqw3UzkAAKe3GVBW5VOPn78bgPzK4S33bqIlr2qgkPRf4DhzygxKGJ6EI8DWbUX/1K38j5yUD69K8bJ/6wpKvNBP0mom1NlApyfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T38sL+r3/wWcw1Yc3opwLZGblto/rvJgRPxzV6SkvKU=;
 b=jVjFX+laFr9iaFN6aITtjwoCuik+lxPy+kq/NpWPlDpn8iBpLeFP6549ockA9Oc+9oKu5XmShgwWOt7zTT1HHxwHOJvR9qs7vpyWkz5gBsEjW+ZKxNmn9XhUaU9BgiitxnIolUuyO4U3zq0kWRdQ8usxH1Jwq4RJb7lw6vQfM4KO1S1WQQPCdtopkAja8tKC+sCUyDsrx17sV0RicL1NmwMZeDNEe/e6vPXPMzUQV2Q/5DOWIc7aFf4ctguXcIVoWTuPa/crLEjV55l5rQKCyZqB7w2aMN9DXgnmRtihvlIGHqg6PV4i8eOpX+ft2mat1fNWo4g7egc7y0DoyIsVww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB7013.eurprd04.prod.outlook.com (2603:10a6:20b:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:23:07 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:23:07 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 12/33] selftests: mptcp: diag: print colored output
Date: Tue, 14 Nov 2023 18:21:42 +0800
Message-Id: <0c29ece3c46db3a94f63a66c2bb96cf1dc53b2be.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 484b2947-9f21-4e6a-23b9-08dbe4fbb194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pKRa8bGlHFGk6CpLdBU0/s2AHf+yU43lHrN8EwwdzM+2URHwxqWURmJJLqjLY7NHwZj+ALtqPvjjDlgxMDpk5Ue6LaYszD63I1Bx8o8ZHdsdtdQ/VsLyf0/H6H/VSz2yCffjWFcMm7YptGABP6rLq3aH4qFB68tWh2RdroZZ+cfYrORf9ADU0vE9vYeCM6yXMy95TgqnSRpD8oJK/tidS5s/U0ZvC+r/BhLLvJm/yykskJwm7puLCW5h3Xik4VrLPP3z4iqTh0R8HEsSPVL0+bB2cB6SzJQmn7dL+3docc/rJlz8O2wjA5dqKxE/m+tbSp+1cUXoEhOn/qot/u7VtgkHC5OWO4zVmlbSBJ6NY3XtxZ6qOZHfJ7MOflbCLfZ7Ozjw16u4oBlc6+S2DWeqzYRrrd6V2cdvjek5Q3EaKuFHX67RnGCGXcUVT7UZvA1XDLvD7QMVp2tzbaHI3R0Y99burW9QFmLBaiNywf+HtvC1PucwHADpMlMh36JOZ6Ms9+pyCQrhOwoOh2/H99vk6jbKRGrjlqG51K9JdX3oPfDMN7Vmt5HuYmCy6kclEhDx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6666004)(83380400001)(6506007)(38100700002)(8676002)(107886003)(2616005)(6512007)(2906002)(86362001)(41300700001)(5660300002)(36756003)(8936002)(44832011)(66946007)(66556008)(66476007)(4326008)(6916009)(316002)(26005)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sfMEoN7tqVYFJM4+YmqVVHmtDN2uBVZ3GRbyUBinwoyvoqxowmUG8qu0Dktw?=
 =?us-ascii?Q?WLkfLCjFMydgdJ/neVSs7rU2P4n1fYPgO2F6KM0naL4+tqrA/soPMg/XohU3?=
 =?us-ascii?Q?i2hrIxECWoJDmhjKgkHQETlFyB6QBkZ6ipaEU/K7BiLj6Elji0Dee02RW6tq?=
 =?us-ascii?Q?fNIhjjcI/Jf3ms4RywM8mGI7bVh3Gw50ymMKxghdBVDRE0InCuRbr9ZveeNG?=
 =?us-ascii?Q?zOFkS95jsysNbC9ZR9Y5oQY5PLTsDRfHJ44bH/7R6wUkpsG9X8yPvi7T2Pnx?=
 =?us-ascii?Q?aXcJ/SMQlXhUTpxfMqG1M4w0mX79CN3iSRjgwrt8GDYIByFWb8JDgg+LQUk9?=
 =?us-ascii?Q?Xl6CoFMlwp3i6dCJDlm8sPAKpJqbC6OhF5LU6UoRHNoK9OsqHSpCy1b9Za47?=
 =?us-ascii?Q?zdIewAvEMBKGiq93SvSAw7IIChkKl/v7y9G1Ki39htoRexfwy/cn3Jf/fn/c?=
 =?us-ascii?Q?zamE6hvh8+im/nlEi5J6a5lgMb6ww/e95d0jvE564ke7fDEy9yuo7UMemLxk?=
 =?us-ascii?Q?1/upolHG2pOYeYOWjZg/9/bqvKuGLtjifw8cztclomzMbczcbEdi/LFSfCbu?=
 =?us-ascii?Q?KQE6qTodDPQFdA/MJplF+r1tQdTVmWUNHrN7CXJoiG8tmgm0KiQ2u6q5i7er?=
 =?us-ascii?Q?M68wrdaRo/5o+V2IgOFkDP9s4aasZLRUKGV+UfFDPbOyqe3KlvBuX4M979Z0?=
 =?us-ascii?Q?opTCpi9KG7UJEz2YxdmoBzg96GFu8uLEQsaHYM+sXLOsNdg5tJp+SRRBJ/Vf?=
 =?us-ascii?Q?ZWtkhyCcfS0ju6GBAJSek4BBjn5u2TTRE3wwWVjnVY4lntez5d5/owqLuz20?=
 =?us-ascii?Q?pnNbY13hZAWkpBVN/d/17t7cw4If93K7TEtZhtjWK+aGZqKyi8biwyL0i9lq?=
 =?us-ascii?Q?rJHLDitD8bQHUMU5Amniq6UoSEOCvcX8d3suEd1DDRh8Ad6w4lnIieO73aBA?=
 =?us-ascii?Q?/KJ3RKtqzxA36htsXIZFq9G4phaW/WFtNgKHZrBdLDsI9gI6XhWloFyvh7XJ?=
 =?us-ascii?Q?brvmcon39IzoYJF4vyE0Puao/oUcuLEiCega9kAm4ao0dIRzK0608j9RnWRB?=
 =?us-ascii?Q?UB+v/LEjhd6GW62d3JJcvY/NUYDtrtF84E547cmdSkhILIIM3jI7K4uJ5Zj7?=
 =?us-ascii?Q?CsKcsR+YMKIEIRKLuXz8GCv1538ypaJQUT3mXyRu+EVQNPFBV7k1sQ7fqs1h?=
 =?us-ascii?Q?1949wQ2wrqzCGooR4Xdl0gmGM90vPsVYQkFntxsexCOYK/MMJmsj6uGOM6tH?=
 =?us-ascii?Q?mePebVIr63SaO8AhpMCdazjnBUu6cxevGPJEwbIy4QU3VJ7i1zXP8z6Rzhor?=
 =?us-ascii?Q?wqNcAO/4KY/zYVjaZ/jWfEyoXW8GQKLRwCi8yU37YB0nHoXDqVNO54qQeTbc?=
 =?us-ascii?Q?b0MeqpWUUJ+3GSBUnasbeOKncvCNK+IiaTZMW0JAdq88+mquICLE/3RgeWke?=
 =?us-ascii?Q?8B6sbTDdE/EGXiHU15LOdVKIQkdzVyrR9YZZacvvL0mIr4Vwhq2D2s5+dFoZ?=
 =?us-ascii?Q?YbKLFn3UctL7+ni+LCi4S7nZBBf5atC4UjMmw5t22QgDUx8dyU4ayQjX6TSx?=
 =?us-ascii?Q?9MiKEqVDWhvrKwf5g0hyxYi7AEUrqgnV8rdWcsLMT/PE7EbtiywCMxPCAm24?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 484b2947-9f21-4e6a-23b9-08dbe4fbb194
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:23:07.2048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y1kTeLniUi+8CQDN/wqahHsaa7/I3bZWIYvLDZRb/xAlSwcU67NkOdjGHMwVyz8jAQmixCEQ2UhStlD9OiThBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7013

Use mptcp_lib_print_ok(), _warn(), and _err() helpers in script diag.sh
to print test results with colors.

Having colors helps to quickly identify issues when looking at a long
list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 3119811018fc..7cf1f602bf48 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -62,15 +62,15 @@ __chk_nr()
 	printf "%-50s" "$msg"
 	if [ $nr != $expected ]; then
 		if [ $nr = "$skip" ] && ! mptcp_lib_expect_all_features; then
-			echo "[ SKIP ] Feature probably not supported"
+			mptcp_lib_print_warn "[ SKIP ] Feature probably not supported"
 			mptcp_lib_result_skip "${msg}"
 		else
-			echo "[ FAIL ] expected $expected found $nr"
+			mptcp_lib_print_err "[ FAIL ] expected $expected found $nr"
 			mptcp_lib_result_fail "${msg}"
 			ret=$test_cnt
 		fi
 	else
-		echo "[  OK  ]"
+		mptcp_lib_print_ok "[  OK  ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
 	test_cnt=$((test_cnt+1))
@@ -111,15 +111,15 @@ wait_msk_nr()
 
 	printf "%-50s" "$msg"
 	if [ $i -ge $timeout ]; then
-		echo "[ FAIL ] timeout while expecting $expected max $max last $nr"
+		mptcp_lib_print_err "[ FAIL ] timeout while expecting $expected max $max last $nr"
 		mptcp_lib_result_fail "${msg} # timeout"
 		ret=$test_cnt
 	elif [ $nr != $expected ]; then
-		echo "[ FAIL ] expected $expected found $nr"
+		mptcp_lib_print_err "[ FAIL ] expected $expected found $nr"
 		mptcp_lib_result_fail "${msg} # unexpected result"
 		ret=$test_cnt
 	else
-		echo "[  OK  ]"
+		mptcp_lib_print_ok "[  OK  ]"
 		mptcp_lib_result_pass "${msg}"
 	fi
 	test_cnt=$((test_cnt+1))
-- 
2.35.3

