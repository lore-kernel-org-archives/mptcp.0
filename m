Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7EF57D1
	for <mptcp@lists.linux.dev>; Sat, 19 Feb 2022 23:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645312888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8tbIkHkTiElUDe84s+cYrXPPT5kmzi3Lc3qV4BvYOoI=;
	b=Cr7faQhoQ/kajDNUbIayhxgw+F3gFp1hGz6BIibpUSW03X6jQv1N7l0tf/XLiwyLSBUcYC
	4V7ML2nmlRJGpdgbTYWI5i0fVAo9Sji5q+82hH5/ceA6k+gimWcjqRJtf9jz0vcXQrcURa
	zFqUY2RLqfLrOTRMkkqdTlzxPa/70u4=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2176.outbound.protection.outlook.com [104.47.17.176]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-m5wZwsG9OOupj-yuFmpRvg-1; Sun, 20 Feb 2022 00:21:27 +0100
X-MC-Unique: m5wZwsG9OOupj-yuFmpRvg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtbVRngczHLpnWc2NCwNlspfEyouFdLhGMqY6Xq+G+8kHBQYEh+wrLt+Z0BenazehWU1FE9eVtFTlwKBmlLl19RKOGzSBd54JxVTzTKhRYkU8Pw39V0vxbg4vkkNffLcH5f6Jcc6G231KJavfx7DgHXPXlX496Kb4izaEFyS9sqAkr8zwXGUMSDseNjOhLXzjf9SzBBHvLMCEodLpRX9fVqJpfv1e9qYw7O3kj8Xz4ZmkmOvsTspjELXbaiIC7jwv9CeWvhtKRSGQtFHnipJxHBTP6Y+LwyEGdwN+K/ziYq8kRiGQJo8ljW/F04zjMPsofkeytyEBSV2MomPgzYmCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rc2tq/veRVwiIyyPNBhrwigMi4dadOkUO+7tTsIi5rg=;
 b=jZJv53asWga00xX9Q1yF8jowFDVR6fF0t7m5qRExCq9ctMZjAdr7v1ZBDxhic8wR41CqsImZ8HmUynhGKTk46OGyToFaFVydP6VeAo5Shc0jHUjGzOQtBz1iX4npZfkbyyAi+QSGsgEob/dnnhxNxxCERIXtrxFapHKJLDDrXFDo6kYE9jrodh/YS1q8Yer8adDF5xV7hXEj9OLlLWj04iFx+/yzcSUNI/FM8jUIdSbXPjwOm2dLsXo4SNw65gqwVcqi0i2XTxKPugSK8B87KMkI8/QaK2qAKgSKFXqziRKK2jPy3tbC3IG3nEWuZVCZwdah2q3zqenATkeEsWd/DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB6841.eurprd04.prod.outlook.com (2603:10a6:10:116::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.25; Sat, 19 Feb
 2022 23:21:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sat, 19 Feb 2022
 23:21:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH RESEND mptcp-next 14/19] selftests: mptcp: reuse linkfail to make given size files
Date: Sun, 20 Feb 2022 07:21:29 +0800
Message-ID: <4cc1bafd6d58a743d4cbaafb1ca80b02d71efab8.1645311956.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645311956.git.geliang.tang@suse.com>
References: <cover.1645311956.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb86dd3f-ba9b-48ce-1e06-08d9f3fe8cdb
X-MS-TrafficTypeDiagnostic: DB8PR04MB6841:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB6841363E2E46A23E0AC6835CF8389@DB8PR04MB6841.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sjjTJF9DnfOkmsJHH2KrjS89k3RJO05EJEGt6K8HAvbUlK5M9lRtovFF6NAtnfZi3s25u/yCgz87+fG25DhXvHyZ7uxQh7ivFQ7IfCrXI7NpyDlfzDu09fbTTCwWUJYJ/8UzlBbrjOtwzocjCtA2ytyCvpZfLLDmCUqjdVfVZeZ2JmW97T1vHBq49aRMDQH0SfAjcYaAAYzrOHGhHM7N2eceYxxvshLMBHGL2endm8m8UmomkK2rhTaVuu7dexu/M4bOqKlyXsEW/eWmQVLY0dmLU4ycXtHYQ8tBY0AD1IA6HRlBF0VWsmmMeXvhyNMvsIheXREfqhAD7YYzfrtFVrfmkWFa+Aq7Al5LvK5Gn0X4yV/LQhbaXCn5oXUkTTlUZI1j7j5uiAmkfZtD1jb2ZvsdbRUZwvM7g3lErmj4D1+jdxalhun4T+zBCjnuSylyqZflzJr3kBqXlPCqr61Wci7KpXD+zr6It7mI7sFd6o5Cw7xtQEqHFe0FG1sC3TeMPDQDTjxQZFsSJoAOdgIm78DwjuH3aVdxTWP+hUxVi0RS47y6h3rmS0w9xM7edXoKa5rD9o5yVIlNr3Z//GjSL4pcqlQdDiR3QSdM1qTqvWtqUk8+4R9axea2rtl99tzJyer42EPrTxnmWRJWbbtHkw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(6512007)(54906003)(6916009)(38100700002)(8936002)(86362001)(2616005)(36756003)(6506007)(2906002)(508600001)(83380400001)(5660300002)(66946007)(316002)(44832011)(6486002)(4326008)(66556008)(66476007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v+hn9CL9zPtNcXmfLDJz5/gFuPg4On1PKtZkYTiLuEpahJJ/Ejiz8JfBPJW8?=
 =?us-ascii?Q?djFkUf0dSeLEV5HIW7F+FNZlVtvu4XhK6nwWWJN6V9HgJBasQ28iyUqhCylD?=
 =?us-ascii?Q?D7/kgsC2LmEGKc+I1JhM3Qw/qGhyHZntF/PwcfoQmO5uQd/+EREJUGcKH1Ds?=
 =?us-ascii?Q?mlmyqDRrGgJgDBwi3Sh19HkeVg9iB0rYINUgaOvkNXTWopKSNw+cUDuJrXgi?=
 =?us-ascii?Q?K+OqEM8+UQVSHMR5eQ2o7oSlqDttEqpz+1zkYJt8vXaTXGa6Ug9ugH+kFes/?=
 =?us-ascii?Q?5snr3xKp7xx8sz5qBfi4ziyHP0H12a4Kd3LpZ/XhkpWM0jP+8S8weuNqdJJE?=
 =?us-ascii?Q?RRz5CLRWQHd/Zwo/qdV2GSP1/c5xgIVMggKEjcF6VfuaGtQYESclSEpZDC70?=
 =?us-ascii?Q?8KYSeU7gyINL9+iO8X5vxowSXBhMxD78W6QRMJxaVfbJofOxXZOHewxsxtpR?=
 =?us-ascii?Q?vbgWtBg5VgOFlGFDCY8iPs6HYMUtv4/ypdzlzCSIwZBpAxD6MgjsYYNI9Yed?=
 =?us-ascii?Q?SGMnLeq/Xo5zpvS6QUeGO4d1pMXop8eoYR2bX5JdeXzj/sNwUiAfXM4TYetR?=
 =?us-ascii?Q?DCsSuVbflTbNlsjsNkIgXh6J3mcL1V/xXgURix2EGVmb8JY7hEh/u6cmH5N5?=
 =?us-ascii?Q?kwgN6vrvCjCWBtjebY2dTdPrGIrOIZYx7qBFPtiy/NN9m3TkKvthAjkCkwOU?=
 =?us-ascii?Q?qGppBf04lwASm+us6INzCc/4jysaWyO4/14cVEUlsV71+DYYWhgilW3ynyra?=
 =?us-ascii?Q?UPQyEoZXQlhap3fngYsUPDGKpda8Oispkg1vBoc0jYJ7WWXquqUMXjHui7As?=
 =?us-ascii?Q?18oVHh/RWb57cYFh53YZthJOE2vieCi0FdD7R9iE/UN77rdenJVl46f9f4Xw?=
 =?us-ascii?Q?CuKnykaIl7cTQHpESHTrK9JkDoQXiqu0hLCtEZ4cpBNN8cmDtiTXIProEDNu?=
 =?us-ascii?Q?AGf7l3ubE/pXOZu9aVMfaM1O6KsI5Yc+zbWxI4k+WlWOPGKMT62pC+r1Y/Jb?=
 =?us-ascii?Q?OlWNFu6OrT3XLd7eq1E5ZI+5QRI/FDLX/FQsDwubP13pRmpneAGN4WqrhknG?=
 =?us-ascii?Q?evb5Jy4tVPncOD7PhfBCytne2AAvt22cAmTnKOCdNTyrEBJA+uV+SiTjN1vq?=
 =?us-ascii?Q?CwlSDl93b/kP7zRVysY/+249Fc9ddeZ8cTIQty2vtCL7Vl4dOTmmh+x3zDir?=
 =?us-ascii?Q?aRVd447ISBP39Skguv57nr+PiB83K4wrKad1XTkvF4E5wWcCxr9c7EVc/p7L?=
 =?us-ascii?Q?CNbxSbuCFfq5/fzn8xbpsxcdtOccVCUD38Ec7EMgyB3um8mOiSl71v5EovD7?=
 =?us-ascii?Q?YM+dQwhJSiZaWXRbW4a7EWoqko3YHoT0KXTTvrl7bOfu/aIhoDYWYgncNknT?=
 =?us-ascii?Q?IwRhiXX0loR9DAO3v+kS6Mr9mIghTeim6mjIkxi0fQAGknDqp4EX/1sGMn+t?=
 =?us-ascii?Q?gW9p0clJkJ/XHNlHDeastChmviYNxo4V3qnpuHqZw8dQKl4YnIKZJTIJz0UG?=
 =?us-ascii?Q?Gb4oEeImrIztZ8wCrgMNWmqqu6xUFteTYAEZhz5gDS0U3p9LNMNmg+3AwN0J?=
 =?us-ascii?Q?TU3E+Ft1oH1lSjXuacanqacEShnFJhylDOzU0QrW1m1oRN0ZeBJdnumOj5vb?=
 =?us-ascii?Q?0Rr01Fu5NBiWS9mByLi1EnsgsO40hG1utqUwujwR6sbOZrOoxNea4kZIdBT1?=
 =?us-ascii?Q?ZC3qXZxoX4aY8c7+x3s7ExkAtBQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb86dd3f-ba9b-48ce-1e06-08d9f3fe8cdb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2022 23:21:26.3017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pK7bktZvmFmQyd0oczioHHNT1XkTl2JJKZGaUWyYZQ4R+lDiQHfDtFMbji/1He9pPcMndA6JMcvHemKpjFjq/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6841

This patch reused the test_linkfail values above 2 to make test files with
the given sizes (KB) for both the client side and the server side. It's
useful for the test cases using different file sizes.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 32 ++++++++++++++++---
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 4ce578fda369..9a9e84cc3917 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -530,7 +530,7 @@ do_transfer()
 		local_addr=3D"0.0.0.0"
 	fi
=20
-	if [ "$test_link_fail" -eq 2 ];then
+	if [ "$test_link_fail" -gt 1 ];then
 		timeout ${timeout_test} \
 			ip netns exec ${listener_ns} \
 				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
@@ -550,13 +550,19 @@ do_transfer()
 			ip netns exec ${connector_ns} \
 				./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
 					$extra_args $connect_addr < "$cin" > "$cout" &
-	else
+	elif [ "$test_link_fail" -eq 1 ] || [ "$test_link_fail" -eq 2 ];then
 		( cat "$cinfail" ; sleep 2; link_failure $listener_ns ; cat "$cinfail" )=
 | \
 			tee "$cinsent" | \
 			timeout ${timeout_test} \
 				ip netns exec ${connector_ns} \
 					./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
 						$extra_args $connect_addr > "$cout" &
+	else
+		cat "$cinfail" | tee "$cinsent" | \
+			timeout ${timeout_test} \
+				ip netns exec ${connector_ns} \
+					./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
+						$extra_args $connect_addr > "$cout" &
 	fi
 	cpid=3D$!
=20
@@ -716,7 +722,7 @@ do_transfer()
 		return 1
 	fi
=20
-	if [ "$test_link_fail" -eq 2 ];then
+	if [ "$test_link_fail" -gt 1 ];then
 		check_transfer $sinfail $cout "file received by client"
 	else
 		check_transfer $sin $cout "file received by client"
@@ -761,9 +767,18 @@ run_tests()
 	speed=3D"${7:-fast}"
 	sflags=3D"${8:-""}"
=20
+	# The values above 2 are reused to make test files
+	# with the given sizes (KB)
+	if [ "$test_linkfail" -gt 2 ]; then
+		size=3D$test_linkfail
+
+		if [ -z "$cinfail" ]; then
+			cinfail=3D$(mktemp)
+		fi
+		make_file "$cinfail" "client" $size
 	# create the input file for the failure test when
 	# the first failure test run
-	if [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
+	elif [ "$test_linkfail" -ne 0 -a -z "$cinfail" ]; then
 		# the client file must be considerably larger
 		# of the maximum expected cwin value, or the
 		# link utilization will be not predicable
@@ -776,7 +791,14 @@ run_tests()
 		make_file "$cinfail" "client" $size
 	fi
=20
-	if [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
+	if [ "$test_linkfail" -gt 2 ]; then
+		size=3D$test_linkfail
+
+		if [ -z "$sinfail" ]; then
+			sinfail=3D$(mktemp)
+		fi
+		make_file "$sinfail" "server" $size
+	elif [ "$test_linkfail" -eq 2 -a -z "$sinfail" ]; then
 		size=3D$((RANDOM%16))
 		size=3D$((size+1))
 		size=3D$((size*2048))
--=20
2.34.1

