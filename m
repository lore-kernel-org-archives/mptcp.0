Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2082.outbound.protection.outlook.com [40.107.8.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6456828E11
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 14:51:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cvek2oU79ECakKHGHgIzfOk21J7X15d1zRupyq1x407Iw8elBo98dKdhxVa7vahwSH6tciigU+U02lMJcPmYuNHXQ7arYxV4xhn+hx2ry7YoBxnsjPURwXDqj2/K6eTCGf3ZlN4bh8tvejYoS49SWsuZ6YBNKxivvzH8Hi/VnKXEE+a6D0nGeSzznef5sLQNn6T9NAJxFJLX5BXCpvkBVz1jh7LDVkRl/yhmmPiyusPWpgzkYY4itN7BVBkGwwE+AmCAUUdy/e4LvZ94SsimDaoou1t4AOF9r3WXXzAqdLgzRCr6itRJ8V66AT2uV99P2quZ/9m0gCufKCf6B/16/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qz541K+ZLe+eosg3tp29Yzuihba8FYIfSFPTbbWcB9Y=;
 b=h9hlNIFAbbi4tw5c/pWlic6kpJ5hs0Is6ntxeFzcpNaCW6rG5Foutl+Hv0rJvcX5+ofAAOQnVlIGDtOoT3by6dDAlnqmcmIBMtIt2dMk6clo7kZ7zNA3oYNMr8LSth4mJ4y+2ffkO276ToU4CCC5kLyjzR8RUmmUSENNfz3rng3PtU9XpC1BY2BnlkoH+54MMMPS7C+B3YRWNUxial4IUWY4jx/OvZbNo6x259nlaeG2DzDINKFS5ay09AhJVSZZm5u8SAUWPL1IZDTfdOAb0rVU4VJy7uwxb8rloke0UthhMwI8CUcPf8tGOkQRfB9ac3j5YyZWIl5R4oo7NsY0oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qz541K+ZLe+eosg3tp29Yzuihba8FYIfSFPTbbWcB9Y=;
 b=LEGB/r1+/clsgJufS35st8HNqWX9bYu98yRcbxpan74nR9kTXsDtYjMNFx7FeLbHiDZ5xE2tZIKEWqJNLB/5s+SLhfE1sx3SEA67Snf5ndtwLDkpyYGYrrZEapxn+cXfDI3ogl+MCxAfuh8wyvcnDiMVZ3/nN6JXsaZVcNz3GibP1u0pIG0liMsjWyFb4UohBOZDXu0dhE3KrMmOU/hnZY1ZjafGy+UfT45IJ0PlIj412bdBc0GXgMl+dw0MpNVaihrziAC4Ur9QAYCGKVz6HfSeP7fuxPP4ha8CLlsAqou/xwOKvdhlVAeVI5QkjH10RPs/BCiuF49kzJasslIqlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 14:51:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 14:51:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 9/9] selftests: mptcp: check no_initial_subflow flag
Date: Thu, 14 Sep 2023 22:50:24 +0800
Message-Id: <d379239e00cd08312d3cfa0229b60772d3ce0205.1694702984.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694702984.git.geliang.tang@suse.com>
References: <cover.1694702984.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0007.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:117::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9135:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a78b39f-f091-45c4-cee8-08dbb5320551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LjmSvc+U5WbS72Ou78wJxM1ca/R7XXW4gwawxBlsfJ+Utq+rZONrDVWorIpj5X1wdZHY0FnKgWLBVmio+khmIPIwQA2HYaTC3oQdSNrZ1WzlNNcId3b654SfIlsCxnQOha9x/5Hj9izKg3pP9HtW9h8xefsA29mOpyyc9q3UxtlC7Bv4WLKWywgc0EMzh9AvCUCDfaifqd7cXWxo6A9+HNJ3tnTy3r1+pqDYi3Ps+5G6b1ff/shdJ1X+A2Vb6tLt4/wUs6ebzMHpLwqmisMzlLe6JvgKn89ZpYf673K99QZC8nEpwPbaIRTLU6XmoYjIEmGBjkBWFWfDDW3hN5AIN6QTsAG1weEqPOifxtYfcqQuBVliEHHMKJLULkopvRPCmRwoH/DwiPUtKvOGSnMRboyhpXJDkDohTRDB31PDvqYqWaauAAMjfBuwb6VIk9njx0OECrnsGKd9UPGLxv4494c/gzPiZ6MuQTOqKyBwN+mJRjecA0+T744QpZZAt9MdIw4/Ar2fweuebpxJrp9Z1uiRp6H9/K3ODF2fFADj6BLITVlzGmneqqHS1WPTQsRz9hPlrIFDJ1MhRxBJFKsjJcif6ftmcbQKwJH0O7kZTSQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(396003)(366004)(186009)(1800799009)(451199024)(6506007)(6666004)(6486002)(6512007)(83380400001)(2906002)(8676002)(478600001)(26005)(2616005)(44832011)(66476007)(6916009)(66556008)(66946007)(316002)(4326008)(5660300002)(41300700001)(107886003)(8936002)(38100700002)(86362001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Ou8GfTIdXCqBV0WdHsrzlH/K0atKohGEKJ0VKErzgj2UGMV+0yXHYFzDKDd?=
 =?us-ascii?Q?E1kLIq+TFu1OJGaZIops6poXz4UoD8foV6QbQwYxypqJhi2Tk2s5HYqhp/QV?=
 =?us-ascii?Q?aFFohOz+YaYGK68UuRJ/QN2dJfTiQ0rPkFVi3OeYoYV4ehml8wZOTCO7vu+3?=
 =?us-ascii?Q?ieuXJKQWttsqWM54aVj1ByaaHGQI7M1UsF/7h+aAHVlLjlk+S3F5VdM/G/UE?=
 =?us-ascii?Q?IiJW75Fdl8oh7VbEMeqPKOqaMVgF6NDGiEopmMZKFcVVcxWmAsD0L316Ejs3?=
 =?us-ascii?Q?Lqn8SjgOzJPw7rhov/G8B1LczKDFsoR21IrWGMwjuHhfqXdX19LRe9JDBw1v?=
 =?us-ascii?Q?g5+QeUXzv8YgesNkW7xHRKqwyVhg72UxCb2MGMLxQ2yZMmnhYMim54ItkcTh?=
 =?us-ascii?Q?bBuxt4E6HAZIzwarf4jU1zF1LoOEx24aW4BESPvMWwpnhU0/8iEoOsqsFJPX?=
 =?us-ascii?Q?OQ6Gjv5RUfbo3oRg92lnYmEv69M3w2+ZVgoWLVFrYArmn9EdTzyn9KjIAUOj?=
 =?us-ascii?Q?VTqfDDrQ4+O4k3krIBXBZ2KfhsT3SN5JhVDwtzgyxkuOwMB0c3z2SBB0ddqU?=
 =?us-ascii?Q?ppciQ3E8RNXJ5Ns6nvl1Wvg/vN6dg+D+X+mTcaU2Za5kVOuGUUh3Ww9Ymknw?=
 =?us-ascii?Q?Zc8weTzAEgPihS7p3AgRwCs+U/S3INrz6AfAw5onbTjfeWD6Q6HTdjSX+0Br?=
 =?us-ascii?Q?gc1aDWAYvu4WWrzbFXliVSRRfCJL/3t/vfbzBtgwpzQgU+equG0qI4czmdnG?=
 =?us-ascii?Q?3jPBUOan6BtwIiRKE+m6XHkt9QG6jL7w0htwPeE5bjyFYEyfaUOi2tAsCLcU?=
 =?us-ascii?Q?PFBayy0mEh3Fc3aEMn1458l7eqqDsyMLWmbhFSReEFcbibuiedQdRbjEu4qO?=
 =?us-ascii?Q?FdSe8lGisCSgsth6DuUSEiigfu1yTY2ttDnlzFk+Ebzq+ncCuO9CZhc/caXS?=
 =?us-ascii?Q?8tPctp7h3sMilQbebHEkf8QuuQd++CcBe7hcVWTeJrsM2HFzWNJMN8tA3bUu?=
 =?us-ascii?Q?QIgToJOlGxKJJblBhuKlZQ3Wh3cSA12wql27RgLJ2N9mlzfVc5uCTjhNRMRU?=
 =?us-ascii?Q?6cRJSCyeuQvtwBOkVcrrk3BHIoekjm71s3O/lTynvIB3CeX4tvrGs72OvEFM?=
 =?us-ascii?Q?KCYbThGWHun9T/KjoSJnDW+S/fxuRTmWuRLe43whqeGOpy0nPiaBTs3JkJBz?=
 =?us-ascii?Q?DRgsXxswA8va/udJ7yVA4sW/edGuuV4Cd/NzH/za9uON5S3l/wX/+14MC5Py?=
 =?us-ascii?Q?Q/GR702yp6yiPukDBtjWJZzfUns+RdFQ5emyumhpBKycuf2EA1VrPnwgW1PT?=
 =?us-ascii?Q?kCO0y4xCCY0BCPcTZPZLz0Oo5kyeIGcrzvcc5Wdud4Rt8kE79GdSnpAXDHNk?=
 =?us-ascii?Q?vCBmcQE5ju9+c8klC05PAK8qUXiMK3g6CwTHpb+EichlYEiGuiaAjksF0Xgu?=
 =?us-ascii?Q?LcMD82a3O5RlYHpyYspzwXxbGM/wH2L4GkHVWoK5l/cJyjp0E/qQlfchOLQb?=
 =?us-ascii?Q?MdQCJda79sszvI2Y84MWJagq+Of3c5BT4fHclMTq8KHqw5zykeu4QqhDd2tc?=
 =?us-ascii?Q?bAlNzsl/JRxkzZRSEuyQkpZDVGezDK9dlAmKy4hB9qDn8hzlzyeGL32OVoXa?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a78b39f-f091-45c4-cee8-08dbb5320551
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 14:51:05.0853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFSgFUAcopWpHw4x1JIs+jCS4dchPyPrhOmld2lfFElZgpJEWFfMQIge1edyWWseF9RhuRyBjl2AU6r0y1+8aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9135

Add a new argument all for chk_mptcp_info() to get the "correct" amount
of subflows, including the initial one, if it's set as "all".

New version of ss will test the no_initial_subflow flag to count number
of all subflows.

With this new flag, we can then compute the total amount of subflows
from mptcp_info by doing something like:

  if (mptcpi_flags & MPTCP_INFO_FLAG_HAS_INITIAL_SUBFLOW)
          mptcpi_subflows += 1;

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 19a6859bd207..29250f5729ef 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1856,14 +1856,23 @@ chk_mptcp_info()
 	local exp1=$2
 	local info2=$3
 	local exp2=$4
+	local all=${5:-""}
 	local cnt1
 	local cnt2
 	local dump_stats
 
-	print_check "mptcp_info ${info1:0:8}=$exp1:$exp2"
+	print_check "mptcp_info $all ${info1:0:8}=$exp1:$exp2"
 
 	cnt1=$(ss -N $ns1 -inmHM | mptcp_lib_get_info_value "$info1" "$info1")
 	cnt2=$(ss -N $ns2 -inmHM | mptcp_lib_get_info_value "$info2" "$info2")
+	if [ "$all" == "all" ]; then
+		local flag1=0 flag2=0
+
+		flag1=$(ss -N $ns1 -inmHM | grep -c "no_initial_subflow")
+		flag2=$(ss -N $ns2 -inmHM | grep -c "no_initial_subflow")
+		[ $info1 == "subflows" ] && [ $flag1 == 0 ] && cnt1=$((cnt1+1))
+		[ $info2 == "subflows" ] && [ $flag2 == 0 ] && cnt2=$((cnt2+1))
+	fi
 	# 'ss' only display active connections and counters that are not 0.
 	[ -z "$cnt1" ] && cnt1=0
 	[ -z "$cnt2" ] && cnt2=0
@@ -1881,13 +1890,25 @@ chk_mptcp_info()
 	fi
 }
 
+ver()
+{
+	printf "%02d%02d%02d%02d" ${1//./ }
+}
+
 # $1: subflows in ns1 ; $2: subflows in ns2
 # number of all subflows, including the initial subflow.
 chk_all_subflows()
 {
+	local ver_iproute2
 	local cnt1
 	local cnt2
 
+	ver_iproute2=$(ss -v |
+		 sed -n 's/.*\(iproute2-\)\([0-9].[0-9].[0-9]\).*$/\2/p')
+	(( $(ver $ver_iproute2) > $(ver 6.5.0) )) && \
+		chk_mptcp_info subflows $1 subflows $2 all && \
+		return
+
 	print_check "all subflows $1:$2"
 
 	cnt1=$(ss -N $ns1 -ti | grep -c tcp-ulp-mptcp)
-- 
2.35.3

