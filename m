Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F8D612A
	for <mptcp@lists.linux.dev>; Tue, 14 Nov 2023 06:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UUTdGtxP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrPEGGza2rW3GQIwVTsq6f8XQ8zyfDmxDbB+DBF6sVi6P8E8L2C8cR22IborGMrULT2ylC42N7mkwQfdtMzxNMBX4Jh2CnS5wfqTuTVflnZAMAMxV7qN4aG1Or5NodsBL0ljlJqA7jWgyi/MCj6IrWmMw80Q9KKD4Ehk7gaaV+eXqd1T8NGZ2aRZzp5N2h5sf72LfNw3Bmq0PYo+wFVkNH7J/gIjOPXUU4epSNmeidu/sYTpsnL1zw3BDS5M2YQxYpQ5XZ5GnAkKdakCQF/U7R4h4d9c+HJSSdIqAbOc+8Ene+/ql8OFMLTfIMl+CbeeUdRqybenXI6EAw7yuNbBQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYKTAEIRKa/NRf09qVpkECUefww2t+9LQuV9jv07FME=;
 b=LMKj1fKXMcQXA3MU56geSgquHzX6SqS4Sp81SjgsWNFr/qVr44OCG1Ca63/zP5r0ptEs0mLoeKlf8TbMFS3cZ/XDxrSSJCEyslkytY/cDcFDelWlLtcuuunNmXQs2jKRGYsxUkvryd8tA/C2DfYKgAm+qcIZnZa+1vTeIvVPHBvyBQ5me7Eb6ZjWlVcjjh7y9KgN6Y6hh0gddLdxGR6XeaWWQ2FD7Q+ryNE+JNc5RAOpHTDflTXM80b0sFAy7DtQbViDN92c5Hg6VfM05Cep7v6zGUewt9stU9CfFe3gIQ0vHGxNpcKIV3BL8E5QB6YmDJLhkA69yT5BNfuWZC7QUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYKTAEIRKa/NRf09qVpkECUefww2t+9LQuV9jv07FME=;
 b=UUTdGtxPDbheoLhuEVWyXi6t0I1bp0fDl3jSrJ7VlMJxY0TNqT+LMODJ0ai1Xy9i+VWbrHbrMDmKXckP9HCjtpocSpyKyDMOIAUgixaFxCAHIp9A1MUbeQh5hvcaxg/8O3HX5Ca/Oy6rsnsNe0TPHDGbk5Pd7+cONoW0uqmqfsdgWI8RBwrzgA5FLO7yJIddW66PvMVpufSjyKNSwgbPozLG3aW8fgJ3t22H45w6vwHP/jHFx0jtIZPxiWdvdTHclRZ2bM5ibEB6nn0y4r8RT+mqSqIxa4ShB7LMvx4vd4vfmLWdd8sPX2gv1qRi40YjPT1wwd9mNKi9t61PPotdvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB10052.eurprd04.prod.outlook.com (2603:10a6:800:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Tue, 14 Nov
 2023 06:36:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Tue, 14 Nov 2023
 06:36:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 09/21] selftests: mptcp: add mptcp_lib_cleanup
Date: Tue, 14 Nov 2023 14:35:06 +0800
Message-Id: <a557613a4dd38c9563822ccfc81b9494bc3aaffc.1699942931.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699942931.git.geliang.tang@suse.com>
References: <cover.1699942931.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0180.apcprd04.prod.outlook.com
 (2603:1096:4:14::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB10052:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dca7114-c9bc-44ee-1b3b-08dbe4dc0bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+fgrQkp7CHMEfSHfeIHntVkj1fl81EJN6X1W8YQ9mqvUwonLYz7hDL8Vk5j4CcxxaWPtaLrebDlZnP81k6UFjNHkDtpydIujL+YtbUGAqas58MAeO33G0M0fpEPKwgNFOYnb2Co6umnJVYBsNXKS6mcQD58rs/HgxQD9Y8sS3eDhDzNrOR/gZIKG7Rjo7eDL2WtPHVJhwHX6XD3DbjwGt2UcmyRIpSIubG6aybfuJsavkfzwx1vZnqcegekHg+vnpmkvY4IuFlyKPIXnKzfWvKNZvzXEREsq0H8uh66gawEjgHQkeNQ2I4KXnMJIOiQQAbgS0BRc44tpFNneMFribp8hMDQUFYbXxIK4kN1bzaBMvX5F903qgLXlwKuf2gcv1ljn6aJcBuaTTtHyZpH1KQydJOs7Yq9ZKErhMrbG58izbviqnX49X79eFhwASrQKz2tt8mucuyNu7CEB9+jK2nJ7ZsX4shCRwTZlcEUhGrwemlV8Z6mmAkx8EBZPX+FFP404KEw8caoYhJUVQXcSp3pxQLU+JNP630IypwlGLCLpgjlxt7N1FXwzEsmcmlKS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(107886003)(38100700002)(66476007)(66946007)(6916009)(66556008)(86362001)(36756003)(6512007)(6506007)(6666004)(2616005)(2906002)(41300700001)(316002)(478600001)(6486002)(5660300002)(8936002)(4326008)(44832011)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gT5Vkd1BU1ihW3im6mDKSwOFFMQbbnS2ppoVwrQvYgFTovQnfgSBmw1khh1V?=
 =?us-ascii?Q?mU2zlnuLVwWhFxk+sRXhZhkM6MOxj34xdGrEY3mxaGW6wrGkYsLy/BCFhXy1?=
 =?us-ascii?Q?L2HWRBAuzF+c1nmZ/pRafVXnAhLspvDSF1wNIA36Wxqw6hXG/9v8E9aGLl/4?=
 =?us-ascii?Q?epJcQ9ixcFtONFf5OwFhnCN9BGo1YoTJd/gmhM+irxgJCMVOIHcekbjL5h37?=
 =?us-ascii?Q?vuE6zVYscS/uG55+QtquKSIepvxlIVF0eK+smgd8LAYhvRLr60rno2AXJ0SX?=
 =?us-ascii?Q?cSxT8Y8+yzW8A3Rm3x65phbj3+NDRjYEengq78gL+8OS4Hl4gs4uKtDLem/6?=
 =?us-ascii?Q?r3KO5yjCnqFVZtAiQB3H6XG328ozyYfjbRZLB1iMAnranjaZaTCFa4QRiigw?=
 =?us-ascii?Q?c2UUIeNY+0/pCeUJJx5U64J0oQSvV48soV23bKPhczBWb6tTXnGpSjpq1o8Z?=
 =?us-ascii?Q?XWQReC/9zRZxfjaJGQeLiFBJZilVEaiOcmmILBPdpjA2oWXOVBgkrSp1YS+a?=
 =?us-ascii?Q?4NK1VOvVc6YCNmBYT72MuoxUul+1MpS0+PSoe+BK9u5s5i6EZ8by1mgxEPE1?=
 =?us-ascii?Q?Ni+6gnuX7u0LPsQXrZrmbdg41jDuP4aR4aXCJjARzctqP/qNKVM918abDFGE?=
 =?us-ascii?Q?5xIx13jQgLjAdmyjtp+HbQJ8X6QGdFIye3s+Qnok/3VXJZo4dIvMZDfIIg7B?=
 =?us-ascii?Q?r/QixJ3h6L5wsnhYBc7s9Lvg/rd9dx3qo5l6XilShP6pLGm750zq1tYLr8OW?=
 =?us-ascii?Q?iEF28GoKCl/YGn31jKOwcycc3fBRTU2usDUp8j/ana7MVDsE9ztIPk6PSqIM?=
 =?us-ascii?Q?zOWdQQcOudGZWfdJHhgqGA2uLnXC4xbQjsrtzApPCyih+Trxvk6/TKu2C4b4?=
 =?us-ascii?Q?RprfNqkU0IWPt3nk587ud88herF1+eWGz48V4nhomHwVTPBdWPskPalG8VdJ?=
 =?us-ascii?Q?ilhDo+dNbqy3pX6NiixjMMZR2FUIdXoa/iOc5QSzpuWu4KsPn+F5UDK0ZfQr?=
 =?us-ascii?Q?vJS0w1l09eaGIdO1OlHCddMtjS0ez39PXKGhFoRnNY5z3aCMOhVnU87gg04Q?=
 =?us-ascii?Q?byj0u7iEfOEzOHfLZOs1X/y5tUQpds2DTzmyTXY1ZHYI5GXIXmEXbsH2MOZk?=
 =?us-ascii?Q?tJWjClZhM7Q5iHigPn5ZOW42dy2rUeqzMKwEqRlhvyUAJgthxAxriTGVV1kP?=
 =?us-ascii?Q?5LMHfK54R8IRlP5pp+0Vfnuc63juXqTLGK8yCpTaJpBSwg0xqJOLybdIq/+u?=
 =?us-ascii?Q?zs9/1rxl4lV3sfvxsUy4B/NYcJDV3dFFPdnCSKiFSTtd5CVmwhSCFVz4zGiY?=
 =?us-ascii?Q?+3cXaXtONo1EP+fmEmh+onlYy6smcFf/GGSgZr2vLS+v71FmOd39sI1YOYxN?=
 =?us-ascii?Q?IeeB60WZfAnliJ5gJDfKHxs61ojWK2uMXmrhZUqOfch5D7OF0LL0njNQNQfs?=
 =?us-ascii?Q?HWpP77k2Lv10ohQ7SIVUFIjgUkoOYmQEyCg3OWewwmL5v9VSujbt/+9VODN0?=
 =?us-ascii?Q?7LiRc4SSZjSkv9IdPTOFTnm0DQqigtU1ajw4eVHusYhStQ1t2w/FeiI61vvu?=
 =?us-ascii?Q?u1hlH1FJEbXS/IfRpSifIYfWWjYyEQF1BKW93Q13?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dca7114-c9bc-44ee-1b3b-08dbe4dc0bde
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 06:36:35.9767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mbv5GMjK5sDoH3x5EuGpQZD5eOyllAoGl5JOwd/Qvv6m00NGH4rxSwKKuSN8DTmD/ukgTb7uAzlL7k3d+34EEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10052

This patch adds a new helper mptcp_lib_cleanup() in mptcp_lib.sh, it's
a public cleanup interface, being invoked in every cleanup() in all
scripts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/diag.sh          | 1 +
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 1 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 1 +
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 5 +++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 1 +
 tools/testing/selftests/net/mptcp/pm_netlink.sh    | 1 +
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 1 +
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 1 +
 8 files changed, 12 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 95b498efacd1..a678ee21973b 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -31,6 +31,7 @@ cleanup()
 	ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGKILL &>/dev/null
 
 	ip netns del $ns
+	mptcp_lib_cleanup
 }
 
 mptcp_lib_check_mptcp
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 7898d62fce0b..98f4e82789ba 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -143,6 +143,7 @@ cleanup()
 		ip netns del $netns
 		rm -f /tmp/$netns.{nstat,out}
 	done
+	mptcp_lib_cleanup
 }
 
 mptcp_lib_check_mptcp
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 1606474232f6..a46515c198af 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -198,6 +198,7 @@ cleanup()
 	rm -f "$tmpfile"
 	rm -rf $evts_ns1 $evts_ns2
 	cleanup_partial
+	mptcp_lib_cleanup
 }
 
 print_title()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 1f8be9dd0e20..cbaa55ab89b1 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -299,3 +299,8 @@ mptcp_lib_wait_local_port_listen() {
 		sleep 0.1
 	done
 }
+
+mptcp_lib_cleanup()
+{
+	echo "cleanup"
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index c643872ddf47..75d8c648f9de 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -85,6 +85,7 @@ cleanup()
 	done
 	rm -f "$cin" "$cout"
 	rm -f "$sin" "$sout"
+	mptcp_lib_cleanup
 }
 
 mptcp_lib_check_mptcp
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 8f4ff123a7eb..fd413b4c8123 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -34,6 +34,7 @@ cleanup()
 {
 	rm -f $err
 	ip netns del $ns1
+	mptcp_lib_cleanup
 }
 
 mptcp_lib_check_mptcp
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index ae8ad5d6fb9d..436500c55e12 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -34,6 +34,7 @@ cleanup()
 	for netns in "$ns1" "$ns2" "$ns3";do
 		ip netns del $netns
 	done
+	mptcp_lib_cleanup
 }
 
 mptcp_lib_check_mptcp
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 6167837f48e1..005251b61d7a 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -129,6 +129,7 @@ cleanup()
 
 	rm -rf $file $client_evts $server_evts
 
+	mptcp_lib_cleanup
 	_printf "Done\n"
 }
 
-- 
2.35.3

