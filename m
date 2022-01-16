Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417BD2CA0
	for <mptcp@lists.linux.dev>; Sun, 16 Jan 2022 08:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642321133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5hq5TfBwMB7L6nO+L/oifUm//GUOwXDS6xSG6XfrvEg=;
	b=OEDacYBpO2BmYQhiWln99Zk6zW4VqxXl2T7kAuSkKLWSam3teuaYNjKcgmbULC7PPF/JK3
	x8awunOJb56zrQTwvndbt4nGl2CC936g74GGdpl/hDb35logsl8FrOVmIs4hico/QexOkD
	R5tbc/TH23hbJRLN8I+JWZ4kaN5Oi2A=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2059.outbound.protection.outlook.com [104.47.4.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-5k3MCSx7P16cD-3L1GEUSw-1; Sun, 16 Jan 2022 09:18:52 +0100
X-MC-Unique: 5k3MCSx7P16cD-3L1GEUSw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sr71s6FSpKywQQw+vqkwRZCUJMQwjuOrBvYw09iLtCDGOgRn7Pprr8eXbnF6IWer/mlyepSlEpnRxIz469CG/ZLW2wOAmX378nISRehbicPr1+0kNJ74dM1R2f9XgJU38qh3FtCHEguJT2pMm0LlVug009gc44U2dYUIM+YTulBHS0GyX38FOVKL5BpdNmro2QSE9p9shlvDSxc8esPciYpCFrza//gCxGLxKMaQ3ni21qProt/I5JseCCaI0N21L/LwlRCIPQpV0TP6GNUSOGI4mRfiIfLN0fDhnYCbLq+WKzsJNs17Qpq+MQxo/z9EdI/dXLih7YJUT/jkbxDwFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8mezQIrL4XNxOglZQa+gPbornlne0UZcZeCzafcduo=;
 b=gA49YhkaZDxuPomEGC7gAfzm9kru+/dU1sypfP1AFsk99lKVE4cV8bYPVRApj/VjxGwK/hr+mOjwjemr6Wmvcj3YtkCQm5UTkXVdYN/p1PSpH6feG17c6AM+8oRl9MM3q+CCCK586cUv5/oCt9OMt29gmmsAWn02jq91EW/RHI/g00lIUd7pRoKSKWh0PrOweD8qWX4VnA9NYsC58/HNap2+1LH5GjIO3YZjiOJ8o7LtH9/iJ59LXXaD4AG5afYtTVNRLM2Kl7x3jUPscyBgMuya/WJgNglxCODcvgaz+n+247MQ1kJk53bSGFn8V+ZjxmaiCkJr43qQlSD4aw/gZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR04MB3047.eurprd04.prod.outlook.com (2603:10a6:6:a::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.12; Sun, 16 Jan 2022 08:18:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3837:57a2:45dc:e879]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3837:57a2:45dc:e879%3]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 08:18:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 08/10] selftests: mptcp: add wrapper for showing addrs
Date: Sun, 16 Jan 2022 16:17:38 +0800
Message-ID: <bb14fb9e846201dec2a6b36dbc3e03b4d7bc8202.1642320655.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642320655.git.geliang.tang@suse.com>
References: <cover.1642320655.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0159.apcprd02.prod.outlook.com
 (2603:1096:201:1f::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0816bf76-7319-4e92-721e-08d9d8c8d428
X-MS-TrafficTypeDiagnostic: DB6PR04MB3047:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR04MB3047B6EE7EA438BB9148F80DF8569@DB6PR04MB3047.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U1LhGlssWyTxR544EWYWM6Z2w4nnn8XNqtyRFofSsANCWTDYefygX2qCk1tWYcCGQZ6sFBOH2g/xRA+F/zKA2C0yRpqjL0a8PDfUg5Y00uXHXNch4BklWi651cuBm7rtVAzZPUGJFNmhAFzV5GJOAyrST9npUWHoDvmdJzAC2XouEiOKLD6oZSKUrrgtHkhDa9IYCRNyfvOQf7c/eriqBhMUifnFyfl68E37LtxqULHt218RcfQ9lyJXXEWgv6db2vKirCunFMMoz98Rz6kxpaSJnDN6jMmUknj9oc+HmfQCS9jpmbizddS8nqzJrmEkA/xwRR8QPe9fYM91AQZ51LV8VOop4+lqNlKHIRakg2Yk27TAPbwK/zOx3t8AyepxAWSM0r0bBroDt9NBYxSNjTD5yNsu7OOmy7323R7Aeo5f6BlIo1eaRRE+zalLBd8oZ5H4I2Z7xef7/iE8+56goxNUMwuzOy6ZHc4WqKdvHm3GxIDnpZKnWrx5nOhiX1oNjuwY7LpwOqV6WNzERN3zzjCbIKvjb176jh7VJzJt5ynjGvUdkIQ34HgFA2C0z64NJQ+tixWdM1K0+7MxMR0EU1TEIUwR5wW4gxnKBG4mh36NMAcQ5865mEMNWDDFFnnqMrqiY5zj58KtS0TiFpF1ZW/30xVoH7tBIt+40jfI7nukEcMTzUamDOinjOEeu8cn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(107886003)(4326008)(8936002)(6512007)(5660300002)(6506007)(83380400001)(86362001)(508600001)(6666004)(6916009)(44832011)(36756003)(8676002)(66556008)(186003)(66476007)(66946007)(6486002)(2906002)(38100700002)(316002)(2616005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IrdAR+qgTXNHG8m+UpqlA198eXduL+F+4RBEUlXwxvTUjJT6zS02YNJXpVGu?=
 =?us-ascii?Q?eDpKqv/k/2s62zGaER8NmaPia+bxDgzc9kaDelz7HkEdaRHHdS9w3jsVYRWL?=
 =?us-ascii?Q?bn69IM24h1SSIPg71MH/fFnj8HcOqr6S32vcV8c6xGB5zFfiZb15oJHECKQ9?=
 =?us-ascii?Q?nGQ/2Fm72dledcTpK28WGZ7u8e3+o7SyTQS5Z7we39DeaN/ZciNEhXv11x/+?=
 =?us-ascii?Q?U8lc4iGKbrPIGBenu91zGNE34kfR5W38ywl3iQZHrMwdZzSB41p2Lt6uYXdX?=
 =?us-ascii?Q?pzNK63v19tC5EDZlWNCqTik4xBLrvJF85D7bdwgF7+1nh+I/Lk8U+sb1TmXd?=
 =?us-ascii?Q?3gH9gU8Wk5xsuD6ojdyglG4O4CZ+MvxoA8sz+oBUIVJbIkpixQC3U3TjcLJI?=
 =?us-ascii?Q?EychuKeGu3epMeFHChJRtwj6nedrf2zSdjqMIMUeCVQV5RJz8vZZvYMXPhsK?=
 =?us-ascii?Q?ceik/mYNOSUPjQ0EtreT6lSP8cKma/zbG6DdXHJIDP0VK22gWNAt/9H79WyF?=
 =?us-ascii?Q?jz4ee423OCLNnIclC9ZjzLX1/taZ7FY5I+lER+AimQR67rSMhFWCwNhxOPK8?=
 =?us-ascii?Q?aMZ/1D64rmQp8HV8rUT0aH9GfLoydNIKXGXGXJf/LKMgILRf79pu25JS4AsY?=
 =?us-ascii?Q?I4ig4twNgzswKq3CWkQ6Ni24Q0Ofc60uh9XZ+uBfalJsj3vUxrzX5J0ZkDNL?=
 =?us-ascii?Q?qiUwYJ8ERcQ9o6aI0jyI5qoZaMmDjbjg4BfuFuroI0IOzvwhnnYgBkyiZVuT?=
 =?us-ascii?Q?3FyF+nnHDccEi0IYfzPoPVOS52EoP1s8XoqtfYx7C0GeZjKu0YvhDiZyROw8?=
 =?us-ascii?Q?1kPTO6O82DfIHfW4eihcjhbgkkltqaK0rp8f1/4qblKrjhXLMHtHTUyBZkkx?=
 =?us-ascii?Q?utokAsjMyoVmccwkFRQmJv+kaITUSW5EC6reOa3f3SWOu2GBeJyhFwut+uEC?=
 =?us-ascii?Q?fGISWPTNDVrbHhSuJqaaQOOvXM1+AAtqmGih3jmzU5iagE5Yp44yCoADEKLs?=
 =?us-ascii?Q?+KPe7VYtznNyqv8cpoXMIsyqd9a+bW7IV3SS1wbhHiS0TCG8mE5gNgVvLOWM?=
 =?us-ascii?Q?F3xQoioVjcUdQ1b1e0IwNm1kw3DtgOTtGrxIPde8Kk9p5cPXoyvLrpgkdX9t?=
 =?us-ascii?Q?XubqGawdEaxgr+nI6USsLiMWIUl6sMCMR0/Eo2DyQlAIWhqwMriiLFVyMPlK?=
 =?us-ascii?Q?Gw42eSWnkycCGrGQLpUI2fLt6j99shBLzUXWRDyXvpG9HB6HzgmgnzB1inRJ?=
 =?us-ascii?Q?CGNu4m7mSOJYtnsGKGq4V68EouO28Bkc9H5vaPbeGjeph4LTjlcW53lqz/+1?=
 =?us-ascii?Q?BwCXgAkpZzOgr4NR+V4fBDvZTju5H5Wr+HMkSeReqGyFenUGkKwvPy1MWIPp?=
 =?us-ascii?Q?Yf7vO7iZfZ2LEh4PweaQ4V47ReJ4DC1XxJDlDRVoiT9Y6MRWTpXGgaSMrqc3?=
 =?us-ascii?Q?fIeqYa7sLD9/gC+UiiK+bOEoeliFlR8v7k2sga01Q2FN/kQBBd55U79hZtxC?=
 =?us-ascii?Q?d4JOfbzjKbbyvToZUsn2dRk6b06BkXs7LqNeFLehDljM5cU/IpJJWAZEyj20?=
 =?us-ascii?Q?Puyv67v9lThBC/JepqJajnFt/AczMtVdlnJ/aW/g1K6dS4kfEXUezmRXzbBf?=
 =?us-ascii?Q?wGeBKnkyoy/zDKawIW7Obs4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0816bf76-7319-4e92-721e-08d9d8c8d428
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 08:18:51.6927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNHOXYP+q1zLKvBFFwMAaa+bfH0z5lvEBhMSs2gjVsG3ej2iBvMXUPqAmEH1NpfzqwsnOBXxqPFSVkUpM8hAFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3047

This patch implemented a new function named pm_nl_show_endpoints(), wraped
the PM netlink commands 'ip mptcp endpoint show' and 'pm_nl_ctl dump' in
it, used a new argument 'ip_mptcp' to choose which one to use to show all
the PM endpoints.

Used this wrapper in do_transfer() instead of using the pm_nl_ctl commands
directly.

The original 'pos+=3D5' in the remoing tests only works for the output of
'pm_nl_ctl show':

  id 1 flags subflow 10.0.1.1

It dosen't work for the output of 'ip mptcp endpoint show':

  10.0.1.1 id 1 subflow

So implemented a more flexible approach to get the address ID from the PM
dump output to fit for both commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 78 ++++++++++++-------
 1 file changed, 50 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 143cf1ced488..84c03267ea9f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -373,6 +373,17 @@ pm_nl_flush_endpoint()
 	fi
 }
=20
+pm_nl_show_endpoints()
+{
+	local ns=3D$1
+
+	if [ $ip_mptcp -eq 1 ]; then
+		ip -n $ns mptcp endpoint show
+	else
+		ip netns exec $ns ./pm_nl_ctl dump
+	fi
+}
+
 do_transfer()
 {
 	listener_ns=3D"$1"
@@ -480,20 +491,25 @@ do_transfer()
 	elif [ $addr_nr_ns1 -lt 0 ]; then
 		let rm_nr_ns1=3D-addr_nr_ns1
 		if [ $rm_nr_ns1 -lt 8 ]; then
-			counter=3D1
-			pos=3D1
-			dump=3D(`ip netns exec ${listener_ns} ./pm_nl_ctl dump`)
-			if [ ${#dump[@]} -gt 0 ]; then
-				while [ $counter -le $rm_nr_ns1 ]
-				do
-					id=3D${dump[$pos]}
-					rm_addr=3D$(rm_addr_count ${connector_ns})
-					pm_nl_del_endpoint ${listener_ns} $id
-					wait_rm_addr ${connector_ns} ${rm_addr}
-					let counter+=3D1
-					let pos+=3D5
+			counter=3D0
+			pm_nl_show_endpoints ${listener_ns} | while read line; do
+				local arr=3D($line)
+				local nr=3D0
+
+				for i in ${arr[@]}; do
+					if [ $i =3D "id" ]; then
+						if [ $counter -eq $rm_nr_ns1 ]; then
+							break
+						fi
+						id=3D${arr[$nr+1]}
+						rm_addr=3D$(rm_addr_count ${connector_ns})
+						pm_nl_del_endpoint ${listener_ns} $id
+						wait_rm_addr ${connector_ns} ${rm_addr}
+						let counter+=3D1
+					fi
+					let nr+=3D1
 				done
-			fi
+			done
 		elif [ $rm_nr_ns1 -eq 8 ]; then
 			pm_nl_flush_endpoint ${listener_ns}
 		elif [ $rm_nr_ns1 -eq 9 ]; then
@@ -528,21 +544,27 @@ do_transfer()
 	elif [ $addr_nr_ns2 -lt 0 ]; then
 		let rm_nr_ns2=3D-addr_nr_ns2
 		if [ $rm_nr_ns2 -lt 8 ]; then
-			counter=3D1
-			pos=3D1
-			dump=3D(`ip netns exec ${connector_ns} ./pm_nl_ctl dump`)
-			if [ ${#dump[@]} -gt 0 ]; then
-				while [ $counter -le $rm_nr_ns2 ]
-				do
-					# rm_addr are serialized, allow the previous one to complete
-					id=3D${dump[$pos]}
-					rm_addr=3D$(rm_addr_count ${listener_ns})
-					pm_nl_del_endpoint ${connector_ns} $id
-					wait_rm_addr ${listener_ns} ${rm_addr}
-					let counter+=3D1
-					let pos+=3D5
+			counter=3D0
+			pm_nl_show_endpoints ${connector_ns} | while read line; do
+				local arr=3D($line)
+				local nr=3D0
+
+				for i in ${arr[@]}; do
+					if [ $i =3D "id" ]; then
+						if [ $counter -eq $rm_nr_ns2 ]; then
+							break
+						fi
+						# rm_addr are serialized, allow the previous one to
+						# complete
+						id=3D${arr[$nr+1]}
+						rm_addr=3D$(rm_addr_count ${listener_ns})
+						pm_nl_del_endpoint ${connector_ns} $id
+						wait_rm_addr ${listener_ns} ${rm_addr}
+						let counter+=3D1
+					fi
+					let nr+=3D1
 				done
-			fi
+			done
 		elif [ $rm_nr_ns2 -eq 8 ]; then
 			pm_nl_flush_endpoint ${connector_ns}
 		elif [ $rm_nr_ns2 -eq 9 ]; then
@@ -559,7 +581,7 @@ do_transfer()
 	if [ ! -z $sflags ]; then
 		sleep 1
 		for netns in "$ns1" "$ns2"; do
-			ip netns exec $netns ./pm_nl_ctl dump | while read line; do
+			pm_nl_show_endpoints $netns | while read line; do
 				local arr=3D($line)
 				local addr
 				local port=3D0
--=20
2.31.1

