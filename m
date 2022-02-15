Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30CB1388
	for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 11:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644923559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UAxbJ3lm6VhLg6Czenz+Qos9TMeti8BNHsAMqQvZhQY=;
	b=alHV6x+ZkTKDACndt7of4Zrf5Z4dZIy4ubNTztxmz4Ox1xWnNrx+Kb6nWCKZn2ZQPpg+v4
	Gf7GQ1+hN0jmT46zTd6xJ/D1hQLkMt8D/XZ3uIttwmhYzm3K6RFQ2W3QN4BsLroL456f3X
	BQ1oG6hYObyD/UI/FPRBq7euIbkX4h8=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-24-Y3T1TXVOMK-TMwT73zkTyw-1; Tue, 15 Feb 2022 12:12:38 +0100
X-MC-Unique: Y3T1TXVOMK-TMwT73zkTyw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmvDJRQCUW4GLQGqIEwhVTs0yIz8z8Qa8MJB45zw+vK52Fr9HHZQJ9PRZ6X+kwh9QrLJ4XZP59c7LnW1vs4xpfmchqSsNlDvq0kEl5PYHp8/7M5V8ghAWnimMhsPkdmTbPkgvPt7lA2ocp717tlcFyNLlvA4X/N5r+qK9zV8or/X1CwiwgYJsz0jqgXnZXS1GhNIhSjxbyfwxOUI6cd7k32lnDTKAyZfOC7/3wylTnqjod+8Seo/ON9+2ITSsNKZSl7Xu1jsFc8l97siarCiO6zd9qOC8fXMfxQboPr0dPYTbWwS/X1bYSu7YxNVfYELluUqWolnuIAyleautEDizg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sorjQj7txn9tkcQBr+ENLkOY4LCKsA1vIsX+H5KXUl0=;
 b=PVddmtsCFzbUpc+OlZ63bkCVgrQQZWuuxiYmuUUl+DPuCkUEju8vtrVLvRcdMvAnYUu33qJKZziM6+7xiJrNA+TrYld/EoRwS8w1SE5IhFpnuEsTvUcLWbNvP6vlXfcuwCbWe+wTL4+aeYZZfbAdvxYFBAOAHolvIU9ugN0AtQ7GaawUgTsycoYjSDWeKF1VZms7cZVI2S5PINqud4BiO4vvBUagip1OOq55lFmcwFJxA7I5XCcW1JAozY6ElIUM6h6YkF/89u3QMhPiDz0iX31hUFZzXKwJnpSxflvUKtNI2XD72sFi+gEZ5z5JWLr0vkWR0hpH0rwIFQSVhBi5AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2921.eurprd04.prod.outlook.com (2603:10a6:3:d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Tue, 15 Feb
 2022 11:12:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 15 Feb 2022
 11:12:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 5/7] selftests: mptcp: add extra_args in do_transfer
Date: Tue, 15 Feb 2022 19:12:21 +0800
Message-ID: <957c1a8f6986f338a6fbd99d61beaafe593bc3c1.1644923074.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644923074.git.geliang.tang@suse.com>
References: <cover.1644923074.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0009.apcprd04.prod.outlook.com
 (2603:1096:202:2::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbcd1862-8034-4708-0b77-08d9f07412bd
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2921:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB2921DC8DF60401E73AC383ACF8349@HE1PR0402MB2921.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YMgsnmm0u6Fsjo9Hn6NtIETgL4ZsSzEDFGdUg30VgjpsH/Tn4UlrnZSW+MxG7p8arZITENOKKlbAqsfHGHh7E0IqE/wY0TkV/PEPnt19g3NEPR8KYapGPgZYnqqYFJnC9bg76npdbqKM9mxUOW1/lEh+lpczU/yWaFkf+ElF5GkNKA6zWbyV8K4alUQoYSsNkdibMosvoZJuvuzoL/w4lopKJH84f6kVZI3Lz4eNBi4Iy5TEEpg4QOQrbx5XR7OFjTNPyCPGXeAKkmgxPuQgCR+2YGOihTJ528TW/gDn6QDLR6UdMfiTo2zDmo/vsn0kPodYjKWF/POug8/SxkSj1xF54yup3S7le3KReqiq4ysY1TeXQNlUQUJ9LtIFST9xqSlxFXggz49ju9+yQY99/bb99htHq6VTUpy9oYW8G2ZbG8zQjsIk6Rwle6S/6Sc28DDGyy5ZGDG0mOsDt2xpoGqlEciLTSqRnPJHkFwtFFfUgHoeFLQwvEJpyfGxEqfYToToLxY399zoDCZ1KraNP0BiqqoXHzu1yntbsWNv4UMx9m/8wC3Y/lU1j8+w36sxBVs7JD0XePvKFk9/5mKVHt3nheyoGTS0yEzdl1DwDekTR9Q/qQDKGxNhPHrV9opk7s9nLqofessXI8TjE79qGQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(86362001)(38100700002)(5660300002)(55236004)(8936002)(8676002)(66476007)(66556008)(66946007)(508600001)(6666004)(6506007)(6512007)(316002)(6486002)(36756003)(83380400001)(44832011)(2616005)(107886003)(6916009)(4326008)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0uOt+mrtQ9FdKOtadWtQT12lVivw5g+9xhOZKGwtCQ/IRZhLoyY+gcYlHiRk?=
 =?us-ascii?Q?9UCmnuGzN+0Do7bPw4h1W+nExnkRxagES53dnKZ134APcIoE9veRIWSGGYxp?=
 =?us-ascii?Q?eTtAXIuyKfB6Isy9SGMS2q7axAPCCIURtsGOH5mByTiGM+M1Z/Fvcgext9p+?=
 =?us-ascii?Q?WKkctmhR/bsATPkyvzKMXuTjA6oRdIaezEQl6XcGwFBDr6DT9tRV4SNYlsNy?=
 =?us-ascii?Q?YIoBJOHrIbhg3VfqIchwlYOXI+YsGsAdTlXkscrpUAEB8PS7J05R/YTX8KU/?=
 =?us-ascii?Q?g1UA2EcM7NNDb8s0vjhaXTGrKnmcB+gyNi/x/i/ekQtKZ96wQ9/x+dCJ4aMj?=
 =?us-ascii?Q?3DG/oF9keuzTVu3m9DTECmZilQd5djWW1lwxLBicqVeaWSCbkrQpe4iLmITm?=
 =?us-ascii?Q?zC3nEY+3phgVeLnQfHIqOAqfdlt6qsysIz6RAgPMVehqoTqdLZJXhVeCJEV5?=
 =?us-ascii?Q?yVrcrr+VfSbShTuqtz3B4r/ZP7s0JF/mhCDJGF76jNpkNb9IIqyrBfOveHYm?=
 =?us-ascii?Q?pwx3nPq2ndnCvpf3yJGXNLbwXfgHPKaD2HPJtV2zFep/093+iSEAsAUMxMRp?=
 =?us-ascii?Q?kuSXXr6RAB3tVCm8MkByeORzy2IWOtvNQMMnBflXmmm+Oa2yRNnfEwfD561a?=
 =?us-ascii?Q?D1bzyTkuKcv51tMhLn2+b01x2Q/TXlFyvOraAuTeCr7E+TNTPJY393qriBPU?=
 =?us-ascii?Q?glwhP702pTnqfXMsCo4LZJop1lenls/hqbhL+2WGAepcP+MHqjPmG71Ai74h?=
 =?us-ascii?Q?9G+b8ARzd2BNE2USYDG3SgGrj3aUDqUKe5vvdfUj/w4+rZRQT8cXPBzrKLoa?=
 =?us-ascii?Q?enZ2/Q+/c43EPzYygfh4ZQXtciPOtXxhmGRkmTPSrjEIXHcIbtDoKA+vWemh?=
 =?us-ascii?Q?nAUuCcgauptgC60Eg1zrEF7p+cbMUqZRaYO+Wo+Bx8PQn2+nKw4hvqbLKbxt?=
 =?us-ascii?Q?bb2LjHViHmZKoH3WL49Z0ILhrvzf+olmOyUan3tnHs7uhcLLlX9utsI/BAuT?=
 =?us-ascii?Q?yMjOyPzY/zfiPh5OV310eq5PkZmCOzTHOrCYuUIb0yU7sbnxGpQhSnACyBO/?=
 =?us-ascii?Q?QXORE639soj27FCjiiq0CzSA4yfup9mMacw5fcanr6bmjnmf51V6ymaAMuYX?=
 =?us-ascii?Q?AewKgwwVcOsea2vhH8Bk2BbGLagNuUXicxyxdMiHpIdsmD2O3CPhbcCUTq4R?=
 =?us-ascii?Q?TmHqdiXc97YSiBovFh7HrcLTA20fpH+VM0QPHbjc5P9NA5qGe7OLTSvMf+Rg?=
 =?us-ascii?Q?f/HUtHNBw06fwBtUHqp9a/uepBhqiIOKw1umSetM4aEiQC6tg9JIvnr9l7cB?=
 =?us-ascii?Q?HJxrMVHINOyxkmu5rf6afye2f/adrRnXoRQ4DAguTZgGkrSvPUrq64L4r4DN?=
 =?us-ascii?Q?OuQx+FD5VeAjOify9VoETevHFJO9DszZDhT2WwW3IzlnDhJb+zjeb2+rNc8C?=
 =?us-ascii?Q?SDWhqkkI8/br4YWeuUfexwBYSJNmdP5YXFSDY3yLx1s2qIP1+/PHJApzyHQ4?=
 =?us-ascii?Q?j/Ypiepl+HWs78V44sh8zLVTFEHJkC1pwFjTq+D54UkYX5Hp8YOEKcaXPEZW?=
 =?us-ascii?Q?5xnpLUuO1MSckYvPB7rFXGsvzGC57W90/yNgJt5YojYVFoyHSPtcase7RIAv?=
 =?us-ascii?Q?TKoi97mVNcl05xD1KuXqejc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbcd1862-8034-4708-0b77-08d9f07412bd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 11:12:37.1668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVAj5S1l2jv8YiLcfN3MFQ7cY73PZjRekR97PscdLQPbPcVZjHsKl82JTUS5/JQadnuJdKB7iojeSf6ZSCL5Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2921

Instead of using a global variable mptcp_connect, this patch added
a new local variable extra_args in do_transfer() to store the extra
argments passing to the mptcp_connect commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 3252865352f3..ee747f4a4c7d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -12,7 +12,6 @@ cout=3D""
 ksft_skip=3D4
 timeout_poll=3D30
 timeout_test=3D$((timeout_poll * 2 + 1))
-mptcp_connect=3D""
 capture=3D0
 checksum=3D0
 ip_mptcp=3D0
@@ -454,12 +453,13 @@ do_transfer()
 	NSTAT_HISTORY=3D/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} =
\
 		nstat -n
=20
+	local extra_args
 	if [ $speed =3D "fast" ]; then
-		mptcp_connect=3D"./mptcp_connect -j"
+		extra_args=3D"-j"
 	elif [ $speed =3D "slow" ]; then
-		mptcp_connect=3D"./mptcp_connect -r 50"
+		extra_args=3D"-r 50"
 	elif [ $speed =3D "least" ]; then
-		mptcp_connect=3D"./mptcp_connect -r 10"
+		extra_args=3D"-r 10"
 	fi
=20
 	local local_addr
@@ -472,13 +472,13 @@ do_transfer()
 	if [ "$test_link_fail" -eq 2 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
-				$mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
-					${local_addr} < "$sinfail" > "$sout" &
+				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
+					$extra_args ${local_addr} < "$sinfail" > "$sout" &
 	else
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
-				$mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
-					${local_addr} < "$sin" > "$sout" &
+				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
+					$extra_args ${local_addr} < "$sin" > "$sout" &
 	fi
 	spid=3D$!
=20
@@ -487,15 +487,15 @@ do_transfer()
 	if [ "$test_link_fail" -eq 0 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${connector_ns} \
-				$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
-					$connect_addr < "$cin" > "$cout" &
+				./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
+					$extra_args $connect_addr < "$cin" > "$cout" &
 	else
 		( cat "$cinfail" ; sleep 2; link_failure $listener_ns ; cat "$cinfail" )=
 | \
 			tee "$cinsent" | \
 			timeout ${timeout_test} \
 				ip netns exec ${connector_ns} \
-					$mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
-						$connect_addr > "$cout" &
+					./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
+						$extra_args $connect_addr > "$cout" &
 	fi
 	cpid=3D$!
=20
--=20
2.34.1

