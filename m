Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D0118C34
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="p/8fXDzH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVWjdq+GA1h3PPzgFkDiCp7AaQxTBw11OTB3nvaAPkiqxTC+fH4yt67HounyMbkehcKl1wXyCBORAF9MC60K9ITVeyynWxiHosRlBzN5vVZ40OqrVaoya5FgSPf2F1WfEmunWUk+EC4UXNQ3zPLzqiMhofWHYnYdnYNCCnbN+9grb9wrJy3QXb6mpNiTUFYaU9zjwPOfJ+oZNasKf0s3h/DhKYrZstqrsYdg2SHJ4Yk2sPvtZW4kbDg4ZV1R/irijihY3P4clolInIhSvgQq0QC7lMBwsWjCIt52iNY0APQ4AP/dupMSBCur7j1Jg1+w62Ms7Q8lmUdlM08I67o7zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFaaCn+LweXwfCLkz9lZ0JmO2TYwkPBbrMhpBnPl//Y=;
 b=GwNOkqsPSIbgbN6jSXWhVpyvVnhsCnj0MFakVnoOR5eGrT7D3d0I5vefPjKI1yeD2WoHDGDXC0pj+9m/daACIQIXRReN+qJ4A99I97ITxykPCwQY/QtTs/GEBpoV0qJcwp5XbPp8M9l0wLh+9lX6nmJJHPt4w6CdgmP2+1JKnWyAExkaEo09SB7qhaP619pFaFqTEiCliHu7JORiT0U3h7R+mkHfh/misW4Tvx5ljq5//bDxRbMKXmAPnBthHejRFIKoTnFD8K65wHRMLnirjxLZuntb7cmRWKzVbYIkoSFly0o9Afq1wGjLci1Anhlj1hfj4p/7OT/fXpy06ZOmLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFaaCn+LweXwfCLkz9lZ0JmO2TYwkPBbrMhpBnPl//Y=;
 b=p/8fXDzHmhXOAh4SAV3IpQsMGwjgjixyevnMTgjWrRXwzzB2AHz1bpNrYHa6ii/FuSUmUsqwey2+5j1BK4SeSHInQaXn/3bstFXEAA7CR6BSh9ZelLFOXZbp17OIkymKDEmhn98aBiCbF6UvB6cQbO8TdhrSYhmKthdmZtPapagKGNoEcLXo7DxWuZxcIcFeWdLtgRhDVyXPSlBOsKpcIKsSZ7ZbzIHfh6ee5XndG9EqBgefZQnbaYD8nvobtz13+6G+tbWwwo8iIY3wfHXH79NqgxJno3vt6INTdGZdXC3Mo+3PD6xyDC//LKxR1ECkbs/00S1IRJp1MzJYyeuylA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8896.eurprd04.prod.outlook.com (2603:10a6:102:20f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Tue, 14 Nov
 2023 10:24:30 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 10:24:30 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 25/33] selftests: mptcp: export TEST_NAME/COUNT to mptcp_lib
Date: Tue, 14 Nov 2023 18:21:55 +0800
Message-Id: <007081e3971c8dcc03728f48647aef2c59cca4b5.1699956980.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699956980.git.geliang.tang@suse.com>
References: <cover.1699956980.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d566475-bcba-4f75-0b4d-08dbe4fbe26d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pWuTyjV+LhGBhMeH2ef96XOJ8ujEZJaH5TlUOT2TylaLp+fF5UEoVLGyaChrPlYkaHLOMNoPJSDCzZJAINZjageE2bgudJP2ZACcd/pN0RGbULwhdqDLGViVikQtl9Ve1tE76d+b5ZdF336H8KZZ0tDiYy+H1Xl/gSZf2g87NH3A5oeBKb3ainayRJExytB3qfPiqXWuvCLtLnfvBMd1P64TsHb9A25NthZTZa3XNgXDUuD5p2X257YBfClSgTamaw6iP+kLCycQPNfAAE4RER/58h8fUGGnQ01LmusnqPy8uC44qTCu5VKRYuB92vX6J8XdWH7JAWaf0snlGsyCOZkhmcdTrFbu7C87qdpqvl4wUXfjReu+nZInnHKsk+eRgnGb0dAHTUZ8XQt4pqB77YZGhz5bLIwCGVB01Nl1emW1dkMrTDby7cMNHPsbVQiysxkfEaHXn4cUvYDpy0a3KtK7r8TJWLUi5dW0fS7K6etW5ci0NPjQuZsV1OE9EZtF6YnEIZfOySqRYi2qkgRa4LC67asI2Ua5IYERS1ffnnvLswfoy2NdGlRd8wnjH4yw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(39860400002)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(316002)(6916009)(66476007)(66556008)(66946007)(478600001)(6486002)(38100700002)(44832011)(6512007)(2616005)(5660300002)(6666004)(6506007)(4326008)(8676002)(8936002)(26005)(107886003)(2906002)(83380400001)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9rIMK9EyzJFeTM74uXheB9IArX3otSA69McI0CeauamdCP19QiNCSt2iNuKV?=
 =?us-ascii?Q?6fuCc+773Go6dx1KoJPYcss0Qdf0BE4RYL1/qWiot3zjbcMWdz6M+I+OBCy0?=
 =?us-ascii?Q?omHxwlA/xciaB+a1GF/C4wn2R9mKknxwJ5b5j5KmcAXlCD+Ny4K9M0SCVUFU?=
 =?us-ascii?Q?WxwA6rQk1nEzVdeyJrw5GmSZcsgbbekO0n6MKTvycOv/UasfnwwGz2Tsa9YS?=
 =?us-ascii?Q?vSzvY2TpchEviADKMHtSgNQlf3Ynw7QG4GYwAYPTqlzGBen+w6rswFC7jU40?=
 =?us-ascii?Q?wVqnr8ubKJtZ2pE3+mgC2HMfzqwxTwmT4XAKiNBAC49WnKazul0CS9nkw5Ml?=
 =?us-ascii?Q?CA7vIqdBN9dqt4patIjf9n4LUX3D64k3IQ1FD6NcwF2xQ8nXwGLrvjTnPfiZ?=
 =?us-ascii?Q?QVdpbPC+QBxHQ9xLm43012HxUxQTc+y6lmxJAGI0+7uM5afLjirLjSdW9dyf?=
 =?us-ascii?Q?lpqfKC59bnsjgaRzGebpsjajC8ZHLz0dMRo2MKHoWopBg/Se351sKR3bTu8X?=
 =?us-ascii?Q?lRFkU0Gbg3XiPfECyoi6m2TK5vt7of38ebf85X5IHvHtf6I9fFDQFFaHFD/k?=
 =?us-ascii?Q?7nr+EMyiw3xnBgottmBu+UR6QenQHW2y/4t3RGAzaDAazSNslKPcq0Qzz6JC?=
 =?us-ascii?Q?IQY62LURZyDjFZ6q3QupC7uaVpIgy5JPW1iciuPcBVmr/dhoMfS3jX7xEXsd?=
 =?us-ascii?Q?6s1LxXE1LjEsMNGBB+J9yY+h/jqHZ5o9Usdm+UYuV2lORy57zE+yb4Wk/FBh?=
 =?us-ascii?Q?FcCIXJfV70WvfdOsmiEcpSTZ+L0aqNfYwkrjn0FmfjlpgVnOr9RTv03hkAkc?=
 =?us-ascii?Q?Xp4e3hqj5KMPPVGBJA6UmzA0KKXm50kJDXYsvWgQMMGUEYqj+NqtflmnL8yw?=
 =?us-ascii?Q?fiOCYSxYKxYmVZbA9UttzHAQBYKxIMWhywQ/uJxaV0SIWm/uq7D/d08ZAvlY?=
 =?us-ascii?Q?/tLhHNuYs2pnr2kG85mNOyg2dPVcw3SXk1YFBi3op4MhFE3N+zHP+/adGD5F?=
 =?us-ascii?Q?EqzQyc0nvfSFUUkH70iadZOemMsx1HlaRvaJW2usOyA+deF1cQFL7aDkysBK?=
 =?us-ascii?Q?IUP0H5KmFlWFCSKmcZcyBiXJdy5USwlZVeF9SYxMfVIWJxErgg+PMVJee37j?=
 =?us-ascii?Q?t238FGShm03qHqhi2UZaxDun26I3sG3k8jcGJAYQxnGPhb/tIQQqA93FfbNm?=
 =?us-ascii?Q?1AK2r2+1EOvfyq9UbAHaa0rw1J6JPnNKj0u/Nk0lar8Uv4FkxTK+SXtOjvXH?=
 =?us-ascii?Q?5wKe5Vg5tNK40JRlsUlN8bubgyckTL+AX0K2t6ETxMyltzlUL+s7hCUHZ3LW?=
 =?us-ascii?Q?+x4yGB+8PBK/JzUig7Mqc5E5ktCN4EOjoCB2ejcJ8yVZhZKhAz6eslhvooNh?=
 =?us-ascii?Q?x+QRTmhSyZf3GvV0dexBSAnMglvrvQbPtrQrqB5zvCJnNZ8llMSDRn1MZ72K?=
 =?us-ascii?Q?Ek1GxB/vjQychgmkF5tKsYn6+R63T1Zh/XnKybOHIoVvS6KN82nreJW2nAnK?=
 =?us-ascii?Q?Bgm+gKoW98EaK1E3izvV15yAGHL2OZQPw60jc5GZd/GP/i8rBAcVSb4u/mxM?=
 =?us-ascii?Q?5Vp1UKQ4hCJm5iO0J+atR18hgNHke9oLHTXvRy/dckZesjBnYF/UPdnlXc7n?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d566475-bcba-4f75-0b4d-08dbe4fbe26d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 10:24:30.2755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PW++f49m0kuEqLjcS3nntt0DeAHAPMWEV8NfRL7hFq5UqTj059Zx+O+t4/wspvYJyrKWZJLpitFSIrPXXHXdHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8896

Move the variables 'TEST_NAME' and 'TEST_COUNT' into mptcp_lib.sh as
public variables.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh          | 1 -
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 1 -
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 2 --
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 3 +++
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 1 -
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 2 --
 6 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 4279bb59939d..c7a7c0d2792c 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -5,7 +5,6 @@
 
 mptcp_lib_ns_init
 ksft_skip=4
-TEST_COUNT=0
 timeout_poll=100
 timeout_test=$((timeout_poll * 2 + 1))
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 7442bb2a8562..54ad82ed8c91 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -123,7 +123,6 @@ done
 
 mptcp_lib_ns_init
 
-TEST_COUNT=0
 TEST_GROUP=""
 
 cleanup()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 52a4080b32d9..bf2f73209cdc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -40,8 +40,6 @@ declare -A all_tests
 declare -a only_tests_ids
 declare -a only_tests_names
 declare -A failed_tests
-TEST_COUNT=0
-TEST_NAME=""
 nr_blank=6
 
 # These var are used only in some tests, make sure they are not already set
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 0498e3758b9a..cc65d9e25481 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -20,6 +20,9 @@ MPTCP_LIB_LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
 readonly AF_INET=2
 readonly AF_INET6=10
 
+TEST_NAME=""
+TEST_COUNT=0
+
 MPTCP_LIB_SUBTESTS=()
 
 # only if supported (or forced) and not disabled, see no-color.org
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index a9e14698c179..e1f4ddf04bc3 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -8,7 +8,6 @@ capture=false
 ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
-TEST_COUNT=0
 bail=0
 slack=50
 
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index b25456fad2f7..7a45abb789b6 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -41,8 +41,6 @@ client_addr_id=${RANDOM:0:2}
 server_addr_id=${RANDOM:0:2}
 
 mptcp_lib_ns_init
-TEST_NAME=""
-TEST_COUNT=0
 
 _printf() {
 	stdbuf -o0 -e0 printf "${@}"
-- 
2.35.3

