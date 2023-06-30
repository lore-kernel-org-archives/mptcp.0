Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2059.outbound.protection.outlook.com [40.107.7.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD0710FB
	for <mptcp@lists.linux.dev>; Fri, 30 Jun 2023 02:42:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AZiOGFih7yBn5kfDu80WjB/L3oac0yArGkzT6+f69GJMC3D166v4LVKANQfHo24ZhYmA3LGJDzkiodrYRSytVvTy1aT7F43oDywRSRRIEFD9jlnWUsn6l4niex0hZRtCEx6DeRNnAOrk4clfGNMZCWQSC76CPC3IO/lex4KLgRoiMuOVKUPV+P1viYb1e66wzNbwqae/eD9RdKG5b0onoFF3bEPyZU6XSudbXAx/uu+Y5GOOMRBVa6d+kZFScFscDfo8ghqh/ug4e7V0Fg+oYchk4vZSpIZgjdenpY6WlnGjl/kvpxTk4NxS2FyaMjkzXVYdnYIEEz0evGPOy3q1QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9sL/f0sbZKvMT06qbnZ9CmztkUvyrHyOLnfPR5o5vY=;
 b=ZAgMJElMdeiNuz25takC8hJZ5MunhluPzowu6REV24aNg5ryWGmW3TDAieJnNOp5VInCrjBKTni64e16GXKjzE4y3R5onfcEb1t3zRzfHgZyfDxacl8c7m4YA66jX32CBpoXDTDNhyy3iRasTURofMnsYE7IGf29VmgNs8BGD+wlu66g0QBzoJaLRo2WYquymqE/f39l1xnA6OWld2FaCCguhvP9Css1uvKbFVe/uVlf8vCO1oyWnRz996ygpBZe6/1bbdP0k3B9Fjfdxgj3RJwZE+AwQXQLJ3zcYbSAz9GEjxBGP/wp07PLYYC77nYjRc6y1hpDDgvnj7KYznhM6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9sL/f0sbZKvMT06qbnZ9CmztkUvyrHyOLnfPR5o5vY=;
 b=3mVoJu/Cl58UeSk+5V0VRtfVbc8594RVaD5pKsYq4ngwdiyaInkGIRmAwLhGWwTau1tQxYyresNK4OdNM7C3aKpdzU4nbmzGn4b/mU31WhowH6a3eS8+F3rioObRjyBkv/EcWNyH2L4jvQ7ufOfBe4PTclBGmFs9+lMXQPH8evDVdbJguAPwB4aNxXXkEnWyQn5PNo0KVk+qkKkV9v0jO4ARfaFqjYwEY8x0DBnLFbjr0kZ/lCwkSqWIebQzqp8ahmceRFvQaLnQOEN2MbCgVl1ZmEwHrGjPBSO5P7FJBT5FdZumSeIBr+0td2MNi75yIwEFcXprSrlRgfLsd9OFWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9103.eurprd04.prod.outlook.com (2603:10a6:150:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 02:42:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Fri, 30 Jun 2023
 02:42:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 1/4] selftests: mptcp: set all env vars as local ones
Date: Fri, 30 Jun 2023 10:42:31 +0800
Message-Id: <0c0c8ee5bd9c49c17565d018e4bd6985901ac7d8.1688092826.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688092826.git.geliang.tang@suse.com>
References: <cover.1688092826.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:195::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fb6c693-38c4-4a98-3c01-08db7913af34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NXliX30QkCz8W0h4V5zuHVfSlNZP8OxrIk209/aNLZMVuHUoWMmpMdTHNhOh8kvzoofliskAXxVKXYYUsTTjU1QSZpXpZhG5/+6SXibvtT6F1Z4y+Tq6cpHxUEZj4Xqx11dmj1hKZi5ANoWM6wfe0N/soPuySUGY6tZYEzrA/GyhBDgmZK/VvpHbtfMsfh032uIYFIYngv3RUYG/dma2ecwW32nWspXDEAFZCwf35/6mUlKFKjQ+OiURCqjOwRv1JoPDXbXlmvMIrXaSwY18RqIuIBrZiG+0GH7DOTLljPLYESDCVy+h3WDIB/e40ZB/0dIsq+MB1c4v32HbwbFR8wztzbWtUH3dmABZWUWMXRPLBmtqO02a3gLAUDZg/ZAlGcH59Dd/RDniJJyTYMGDtNl2Ozl2TVF6iSXe06qNgw1a7sABHszzY9oYbnQltINakVdLbQuDexB7ztRwnrxqF6IxFJXrdHLWNqGh3YtaopnmKnIiFZJLihzGOmjBaJIQZjCufmvRyPmz/k6uZ6TkWG+lkpBGhLz/KhH+UNKh6HVXHXxtS6Tsr/0nZGGGURMR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(86362001)(107886003)(8936002)(8676002)(5660300002)(26005)(6506007)(44832011)(6486002)(478600001)(66946007)(66556008)(66476007)(6916009)(4326008)(6512007)(41300700001)(316002)(6666004)(186003)(2616005)(2906002)(83380400001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SE2GWi1xhhBusjcVzTL69LaJF5kF8oqXMIkPeBmMq5SLu0exy7uKOKGzlAaw?=
 =?us-ascii?Q?jfDRWjhbFAFutpLEwtDUGuflrnlb4f/XgX1y8ZY2DJdBvEsbbbj54jLHYeu6?=
 =?us-ascii?Q?jIIaQRQ+Tb5ofrZATtVpNHa7ZOOdft4x1a7zqUAVF5RpOdm+622WBUxdC+W6?=
 =?us-ascii?Q?AGCSq8p06gTUlf0qK9geALPy8sMuARZ5Xt1B44lAOiNokmj+FhYCWQb10wdX?=
 =?us-ascii?Q?Tk9N15LxnIAyWq4pMf+9JwDhTlMsaD9OnEtkVkIJfEPWQGhLOKtsS0BoJ+lT?=
 =?us-ascii?Q?K7CMrqYKocbpabOMRlq8Mkq7c70gOGLBLXRCviC7xYgQxncRyNRg120K9EGX?=
 =?us-ascii?Q?BQYBU0TDFTDV/Uw8GK+BPa+ycmbZ/VosKu4527qu6+OgzhC3YjgUTof1geh2?=
 =?us-ascii?Q?AnUhqPN6ljVoyBIcFmIv8da3XtNPz4nglsOzjCjatVjBWV9ALcVNv5eSNNjj?=
 =?us-ascii?Q?vsv1kuN8iayf83n0hgVtnHu1ubHPE4H7qjVJPkO34ps5KcWvT++tsC6uLkHw?=
 =?us-ascii?Q?j2nH7nDnUK5tvQcSDddP8EK5GphwpC3BAAu9oWAgHYwkJk3yxcMZ6wgMJIo2?=
 =?us-ascii?Q?nRaoV60lUxXXk5hWOuJsPi98aNixPJXRQvVAQRhuKwECloNpk6n7JXEvwRYm?=
 =?us-ascii?Q?LN1VTkG5e9wTJTZxPBSXUMtoOXD10iVz1IsFUx0veEWWaHCRmKKK6f2KciCO?=
 =?us-ascii?Q?N2tNckJCs2PFz/LjBJSwcWkoSOZ4MQfflOGm1MJzhhvpkgRXm1YuZhkgF082?=
 =?us-ascii?Q?th5HLI6s8Dus/yPLS78/1FjxYX76QSiEBnLs8JwBp0IBmi8ferPvlKapu+fL?=
 =?us-ascii?Q?wB5dWm9FfvoZ5F1me8IlHFuFQHSBFsk84Aazd4mVcVjK+CAhfSeoyfcpZ5Dq?=
 =?us-ascii?Q?oC1MYlwwxxONeLwUUZkpgB3euRy8KRCaImBvOw436uumvh62ml8jQmPm5+Ie?=
 =?us-ascii?Q?sew65qHF5bRvfcEwmqohCKk39lq3OiyLad3JPo/IaQNUYdgyAKCeDMVoktMZ?=
 =?us-ascii?Q?/3DiNksH/6qxh8iwKWCKrRnI5sxv6tEraLBXCeNsiORJ7msS9rjSfKYNFD/y?=
 =?us-ascii?Q?Pi+l7eSbkvyP60M/r2Cs/jHBkYv39RSXfbAo7u6vz7b4fDBKszf16oYNZDYJ?=
 =?us-ascii?Q?kuUE4rFIkA5ZCx6VB4at5WknhzdSFdkU+1sQBmQLd8o7VNYtk/hJTV7M8QJA?=
 =?us-ascii?Q?jS/FWx3QH6NiT9K/5VjghfweGWbN0wibwXi3njrCWjvlO8tjOz60M8V25+4c?=
 =?us-ascii?Q?fU+Cm0HoWpgwUtT6Dx1WQaiUa2X7WOfqpDLmljXd/cx+zEZvoMfS7iSPaZUQ?=
 =?us-ascii?Q?LxY/bsRvphrHrim8p/oGN+IC9Wi/qAXrUGUaOKYpEorFnp6wcZekca2JlamU?=
 =?us-ascii?Q?3I4PNILSRJ0m75M/qa8ZcDbaum+v/jCKvUu5BsXqOcA1PNiG2KbUUFIhu5vP?=
 =?us-ascii?Q?NUDDUx5kwLVlDtP/IQUDVcthnm7//RmkriNjeFJKdxKIUOMTr81Yy0ORLCO6?=
 =?us-ascii?Q?5+WGXdPB52/OlPU8sQ57GDuceMPXR9RwxupGT2kB9UVEjKbhmVTVi6eKCczV?=
 =?us-ascii?Q?BbyeqDJuuMzTZmUjOcip2cGZ0brW4qi7v31fu8pa?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb6c693-38c4-4a98-3c01-08db7913af34
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 02:42:45.6762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q3htEt8uL6Ifw09bQ8lrKlDlS+gSAH/shedXQ58k7mDkaSvpG6kZ9qEaUAj1LQ+sQ7mHiCVtO8JtbS7ibOebLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9103

It would be better to move the declaration of all the env variables to
do_transfer(), run_tests(), or pm_nl_set_endpoint() as local variables,
instead of exporting them globally at the beginning of the file.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e6c9d5451c5b..ad0717cb0d7e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -49,11 +49,11 @@ TEST_COUNT=0
 TEST_NAME=""
 nr_blank=40
 
-export FAILING_LINKS=""
-export test_linkfail=0
-export addr_nr_ns1=0
-export addr_nr_ns2=0
-export sflags=""
+FAILING_LINKS=""
+test_linkfail=0
+addr_nr_ns1=0
+addr_nr_ns2=0
+sflags=""
 
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
@@ -100,7 +100,6 @@ init_partial()
 	stats_dumped=0
 	check_invert=0
 	validate_checksum=$checksum
-	FAILING_LINKS=""
 
 	#  ns1         ns2
 	# ns1eth1    ns2eth1
@@ -828,6 +827,10 @@ pm_nl_set_endpoint()
 	local connector_ns="$2"
 	local connect_addr="$3"
 
+	local addr_nr_ns1=${addr_nr_ns1:-0}
+	local addr_nr_ns2=${addr_nr_ns2:-0}
+	local sflags=${sflags:-""}
+
 	# let the mptcp subflow be established in background before
 	# do endpoint manipulation
 	if [ $addr_nr_ns1 != "0" ] || [ $addr_nr_ns2 != "0" ]; then
@@ -979,6 +982,7 @@ do_transfer()
 
 	local port=$((10000 + TEST_COUNT - 1))
 	local cappid
+	local FAILING_LINKS=${FAILING_LINKS:-""}
 
 	:> "$cout"
 	:> "$sout"
@@ -1158,6 +1162,7 @@ run_tests()
 	local speed="${4:-fast}"
 
 	local size
+	local test_linkfail=${test_linkfail:-0}
 
 	# The values above 2 are reused to make test files
 	# with the given sizes (KB)
-- 
2.35.3

