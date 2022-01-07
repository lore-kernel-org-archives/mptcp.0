Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6862C9C
	for <mptcp@lists.linux.dev>; Fri,  7 Jan 2022 05:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641534749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vbUPi5guQyale6iUXT9t7jOV1g7ngjXvsSxN5jq0Sas=;
	b=lmV5p1eQSQ0/TH3suKF7KnmCdNyjaIXw+JUq9eLcDlOnz+VVMAtqaEygyeca9VHfRXvQsX
	79RYTPgh4+d4ZSN2g1lqYHYbo1MvnmiOXxW+y0/mBC/H/YNUpRC5gwCOTz2jFOI2SdHGzu
	sfAcTZvEoDmdUAaaI8qgEt7hjWWN0eo=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-fhIMVixCNky66_2JCqqWdw-1; Fri, 07 Jan 2022 06:52:28 +0100
X-MC-Unique: fhIMVixCNky66_2JCqqWdw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nuf4Rc2wixc0+Us0DCsGJhDXSDt+qGcelDg1/hmIUJVjEzaqWHipcrsVeBRgg2rgMUpzL43OtHm1FWppSAkAZJ4WkKSfzwZ6I2y5SOC+UxZQk+IXWM6cwhKABJ9HZGMJ9ARj0CVUaou9JDinD7CozMyHCcWdk1zmoD/DqPjLR7poUd7FgFYh3oyu/a0cFusJkeoNZxuAzVPsLxBzF7FBfg7DOaVkndtKKGgjlJgf2dta9xmbLCJ9auyfeiDf1XAmYgBSxSvy3k7UKWAALVJlnkBnwoYzHcVRiClzmrv4crbA0GqNaVrOZHTOFDTjEtvfQhH9iEXUxKwkLoSXNGczCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ah+E0eVIe+nTvrqUI/VQhbolU0E1OzoM4Pfk6x7qMk8=;
 b=bPgRwJPjhMdjR1egh3jJS54e37Z8QIq+mt+UBuF9srhWIq3wYdz29pQ05X53tATEqD1Xi74q1fmIJaafce4hgUWBm2zbEB/swAh2B37eq1ZzvIxfG6lvNfWVBrQQ9njdrvXabAIyJzPVDypScOuI7p0W7zDYltdxXyTwma0gCGI/1aRLrXprzoJEX3z4DQIDwMvfcA2xCi6EqhEdKIiMMbZINX2SQVgqhqs3lHxko1evqC3Iy/2bEuekdkno64H6D0tCFM+DlXdpLrv/dg1luTkzTdKc1cqmhtOe4k5VT70MyS+pvRkT66Ckj2he+L0CE728u4ljqtqubFv+2rvmTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2731.eurprd04.prod.outlook.com (2603:10a6:3:d7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Fri, 7 Jan
 2022 05:52:25 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.017; Fri, 7 Jan 2022
 05:52:25 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 4/9] selftests: mptcp: implement pm_nl_add_endpoint
Date: Fri,  7 Jan 2022 13:51:46 +0800
Message-ID: <73fc4696a94038df411a0b1c4ed329ffb3abcd57.1641534346.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641534346.git.geliang.tang@suse.com>
References: <cover.1641534346.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0043.apcprd04.prod.outlook.com
 (2603:1096:202:14::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c74b4f21-b4ec-490f-a30b-08d9d1a1e183
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2731:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB273119F6D5C70771F4364A40F84D9@HE1PR0402MB2731.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4fsGfTVYYKRm+v8EnoZqp4vTFInyIyJwD069xYnzNBmzo7tr4htRkZKJCQ3/R3PgVgkNjZYOLPviQNcpVAcF3Dsdg8H3Y+Hf4KlnVbGMNkK5gFbUOB47gyNz6b/CXOfHHD4fwJjBaNouby/nDtz42uhevBV2b1PcTF9ZK24CXMA4T45Z8OcmT1TYwKVQ1kg/dfEMFOttKK7+Arv0vB/+KXMoArHUoIXJcHpItm5+eD8wKwfPnHu/O6EAMGgO/CNffnmwzZ+Pb9SWW1cYZosiUUKoT3hLBSwP3XRgJfeHDPIMlPBheHbvdD1BdEQWx8XapqVuVc3vMjy+9PqtdiAzAf6m0sBbYtpgO6WNXcv+zwTj1bRhIe3S5YIOClSdN7w23xhOtsrdzp2Q1AIB7g0/jjb+XibKbbJ9j8Zz7OARrqjobJ6HSoIE/KL4a15D+nocXKAg2rj8b7kYivK9nx5D3BnxEI2EdojkfO8dEZF+HsGH6ZPA+IuCEr2ZmI9FJTA3+nYv09xrHN3yWG5JZmrwHiUmGWEYJ6nG3q1S/9YEdEuoclcfBv0V1ouxEPOKFe5ip8xMxevKLzUKqlPSWRRaLtYXP5NU/HmcSExNvbq/N+gxMk4k0AbvGKKAl7PYAcuT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(36756003)(6916009)(8676002)(107886003)(6486002)(6512007)(4326008)(186003)(2906002)(83380400001)(66556008)(8936002)(44832011)(66476007)(66946007)(2616005)(6666004)(55236004)(30864003)(5660300002)(38100700002)(316002)(6506007)(508600001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XU6alJqkVQ7QuVmI6vxWKwDkZUDqIxHfqcz+xOftd8NnckH7qWSdNVjpV+GN?=
 =?us-ascii?Q?cRgLsifJ5t5lGMevUMbo4iyxAToepVExF4UORjg348OENKUKdK/1US8hxC1x?=
 =?us-ascii?Q?HgNKFvel0nYXIXURmEkT3wS+Bv9SmVOC5/aZNQ1z6E1P98PMUngoYaen5HTr?=
 =?us-ascii?Q?ptgN7xbfnhDX6dQnBG2rcLiJd/fCAQzDC107pus9XiXgaHpFawLWJPNv8hpU?=
 =?us-ascii?Q?imfWv0HVaL3mC95fDwoyZ+wyss3Jrhvb3xPT84hpJeRHBX2BCYAqO9CgREay?=
 =?us-ascii?Q?mGbAnArjt5kqZ90YQU1VNWADJliEVUh85nIVCw66cePMLhtkyDhx5CRZv8E7?=
 =?us-ascii?Q?DmgID2HFHII27VM55r0qxzRhx2wjsENlXMWqye2r6HTyzeEUsx3OEd+4Kfcf?=
 =?us-ascii?Q?UZwd0kAuhe1pTeEuGF6WNCwip67I/72Xl0x3GD0fSzPOF2eiBYYNhhwKA3eV?=
 =?us-ascii?Q?vHJPYXfRYCay7QRiv+X48oGihU+v8WpqN1QI/2knUhwvZjsLsytV52ONt4nL?=
 =?us-ascii?Q?+Ywrsf+e3U0/0b3ZtfEonRKgqIKbCREcmZ7BXlCXKze7Mp2e7JiQ+RYdmEJg?=
 =?us-ascii?Q?qPhRDvL31ErZCDp3U2XiuD44o/1HajRk7vnPlE5PtnjTLmyywgsKA3Bj8Yhf?=
 =?us-ascii?Q?PSR+TEr7rNBwun/eCpWVreaZbjSTOqjfsNfaK+TabRvea3RIKzw2C4WI2mQG?=
 =?us-ascii?Q?IyFhQzTEPW2cb51PLEwW8UChy4LSqe6AXHR4+C9jPYEi+rpPPMpYYiYYLUkp?=
 =?us-ascii?Q?8yvCcPUFaQlXsTrg05WnZZ1Zp6hOS4R7ApqNQwUzPfN/5CQJFIBc7CT213vM?=
 =?us-ascii?Q?GpajUnp/kuPSi2U24hALCCFhunFF0vV92uOcXSIK7TQ/NXwTab+BJ1JtLR+7?=
 =?us-ascii?Q?TozJcZ1/jPLgIMtZ6AvTmh1xG2bviDenMvYtyGybtQqIubMnmko7QogOhmJ4?=
 =?us-ascii?Q?wVJp3IZ3XHeVn88nkoudjPSijzPf3uXi5TcFNwMd63nnaJFDyjUN3FAV6/Ir?=
 =?us-ascii?Q?zT0OXk/zuKLNni5/nN3BrBpE64WvNxRdhy47KSlYXaaS7ARCVOAc8YghMNPd?=
 =?us-ascii?Q?JYKIsYLimpliFdnsGZg7JN4LoPtFXI+nTufbMIS01hYtyKy0qclP8tegTMye?=
 =?us-ascii?Q?zjr5YBXVbu9N2+0j/Pvl8ypJAk0YlMDM37Ke+VLV2v0+GNTNKyZVQAzBWN/R?=
 =?us-ascii?Q?+ucBW2hQ+CCkiVpaBCCSKeOz48JUs/R70ZSsuikF/knlGaR8LmN+VaoR/FVl?=
 =?us-ascii?Q?rXMmozYcaGwXu+wkku5dHUsuoZLEv29bKkUPV5TjrTKCQhcSjC2mr5jQo+52?=
 =?us-ascii?Q?+KxvuFnusWl58qYXwoZeXxpT7kaI2xVhb0EaqvRaNP/wbYUPL91Q7sz1ghmL?=
 =?us-ascii?Q?iM9SgC9onaHUrpDrydmqxDZJyDgTxigsQ1i+O6IZF7K8KBVec1z4WF+Vm/N3?=
 =?us-ascii?Q?aqqbUj/YNpNRtr/n4hzm2GNWuWHe0BBUzGX8HCov8l7xPp+P54xrC1NtaVx+?=
 =?us-ascii?Q?7odiYadgJ0RWT4W8jev7UoMHaCnu9IB4cT2BeQPwYmC6ShqF96JQYMKBl7/6?=
 =?us-ascii?Q?ozTRDHaLMd7X++Pevo3Y4nsjSsgsMB4fYTtYtt28t565XzbzaeiJa5ehe5tm?=
 =?us-ascii?Q?mFNdkPvsdklLT90EZN8QqDQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c74b4f21-b4ec-490f-a30b-08d9d1a1e183
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 05:52:25.6825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RIJ1gNPoYISAmFDAiYFy2V2wEE2KjruMNBC67ilXqoo2Z6n8ukFhHIYSAceKMRWVDpimvcg0a98hS/wvugXpTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2731

This patch implemented a new function named pm_nl_add_endpoint(), wraped
the PM netlink commands 'ip mptcp' and 'pm_nl_ctl' in it, and used a new
argument 'ip_mptcp' to choose which one to use for adding the PM endpoint.

Used this wrapper in all the selftests in mptcp_join.sh instead of using
the pm_nl_ctl commands directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 337 ++++++++++--------
 1 file changed, 192 insertions(+), 145 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 9a571665f7a1..740258ad45b1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -292,6 +292,53 @@ pm_nl_set_limits()
 	fi
 }
=20
+pm_nl_add_endpoint()
+{
+	local ns=3D$1
+	local addr=3D$2
+	local flags
+	local port
+	local dev
+	local id
+	local nr=3D2
+
+	for p in $@
+	do
+		if [ $p =3D "flags" ]; then
+			eval _flags=3D\$"$nr"
+			if [ ! -z $_flags ]; then
+				flags=3D"flags $_flags"
+			fi
+		fi
+		if [ $p =3D "dev" ]; then
+			eval _dev=3D\$"$nr"
+			if [ ! -z $_dev ]; then
+				dev=3D"dev $_dev"
+			fi
+		fi
+		if [ $p =3D "id" ]; then
+			eval _id=3D\$"$nr"
+			if [ ! -z $_id ]; then
+				id=3D"id $_id"
+			fi
+		fi
+		if [ $p =3D "port" ]; then
+			eval _port=3D\$"$nr"
+			if [ ! -z $_port ]; then
+				port=3D"port $_port"
+			fi
+		fi
+
+		let nr+=3D1
+	done
+
+	if [ $ip_mptcp -eq 1 ]; then
+		ip -n $ns mptcp endpoint add $addr ${_flags/,/ } $dev $id $port
+	else
+		ip netns exec $ns ./pm_nl_ctl add $addr $flags $dev $id $port
+	fi
+}
+
 do_transfer()
 {
 	listener_ns=3D"$1"
@@ -392,7 +439,7 @@ do_transfer()
 			else
 				addr=3D"10.0.$counter.1"
 			fi
-			ip netns exec $ns1 ./pm_nl_ctl add $addr flags signal
+			pm_nl_add_endpoint $ns1 $addr flags signal
 			let counter+=3D1
 			let add_nr_ns1-=3D1
 		done
@@ -445,7 +492,7 @@ do_transfer()
 			else
 				addr=3D"10.0.$counter.2"
 			fi
-			ip netns exec $ns2 ./pm_nl_ctl add $addr flags $flags
+			pm_nl_add_endpoint $ns2 $addr flags $flags
 			let counter+=3D1
 			let add_nr_ns2-=3D1
 		done
@@ -1039,7 +1086,7 @@ subflows_tests()
 	reset
 	pm_nl_set_limits $ns1 0 0
 	pm_nl_set_limits $ns2 0 0
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow, limited by client" 0 0 0
=20
@@ -1047,7 +1094,7 @@ subflows_tests()
 	reset
 	pm_nl_set_limits $ns1 0 0
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow, limited by server" 1 1 0
=20
@@ -1055,7 +1102,7 @@ subflows_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow" 1 1 1
=20
@@ -1063,8 +1110,8 @@ subflows_tests()
 	reset
 	pm_nl_set_limits $ns1 0 2
 	pm_nl_set_limits $ns2 0 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple subflows" 2 2 2
=20
@@ -1072,8 +1119,8 @@ subflows_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple subflows, limited by server" 2 2 1
=20
@@ -1081,7 +1128,7 @@ subflows_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow dev ns2eth3
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow dev ns2eth3
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow, dev" 1 1 1
 }
@@ -1093,7 +1140,7 @@ subflows_error_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.1.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 	chk_join_nr "no MPC reuse with single endpoint" 0 0 0
=20
@@ -1101,8 +1148,8 @@ subflows_error_tests()
 	reset
 	pm_nl_set_limits $ns1 0 2
 	pm_nl_set_limits $ns2 0 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 	chk_join_nr "multi subflows, with failing subflow" 1 1 1
@@ -1111,8 +1158,8 @@ subflows_error_tests()
 	reset
 	pm_nl_set_limits $ns1 0 2
 	pm_nl_set_limits $ns2 0 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j DROP
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 	chk_join_nr "multi subflows, with subflow timeout" 1 1 1
@@ -1123,7 +1170,7 @@ subflows_error_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	ip netns exec $ns1 iptables -A INPUT -s 10.0.3.2 -p tcp -j REJECT
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
=20
@@ -1133,7 +1180,7 @@ subflows_error_tests()
=20
 	# mpj subflow will be in TW after the reset
 	wait_for_tw $ns2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 	wait
=20
 	# additional subflow could be created only if the PM select
@@ -1145,7 +1192,7 @@ signal_address_tests()
 {
 	# add_address, unused
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "unused signal address" 0 0 0
 	chk_add_nr 1 1
@@ -1154,7 +1201,7 @@ signal_address_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address" 1 1 1
 	chk_add_nr 1 1
@@ -1164,10 +1211,10 @@ signal_address_tests()
 	# belong to different subnets or one of the listed local address could be
 	# used for 'add_addr' subflow
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	pm_nl_set_limits $ns1 0 2
 	pm_nl_set_limits $ns2 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and signal" 2 2 2
 	chk_add_nr 1 1
@@ -1175,10 +1222,10 @@ signal_address_tests()
 	# accept and use add_addr with additional subflows
 	reset
 	pm_nl_set_limits $ns1 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	pm_nl_set_limits $ns2 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple subflows and signal" 3 3 3
 	chk_add_nr 1 1
@@ -1186,9 +1233,9 @@ signal_address_tests()
 	# signal addresses
 	reset
 	pm_nl_set_limits $ns1 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 	pm_nl_set_limits $ns2 3 3
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal addresses" 3 3 3
@@ -1197,9 +1244,9 @@ signal_address_tests()
 	# signal invalid addresses
 	reset
 	pm_nl_set_limits $ns1 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 	pm_nl_set_limits $ns2 3 3
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal invalid addresses" 1 1 1
@@ -1209,14 +1256,14 @@ signal_address_tests()
 	reset
 	pm_nl_set_limits $ns1 4 4
 	pm_nl_set_limits $ns2 4 4
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.1.2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags signal
+	pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
+	pm_nl_add_endpoint $ns2 10.0.1.2 flags signal
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags signal
+	pm_nl_add_endpoint $ns2 10.0.4.2 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
=20
 	# the server will not signal the address terminating
@@ -1237,10 +1284,10 @@ link_failure_tests()
 	# Let's set some arbitrary (low) virtual link limits.
 	init_shapers
 	pm_nl_set_limits $ns1 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 	pm_nl_set_limits $ns2 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 dev ns2eth4 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.4.2 dev ns2eth4 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 1
 	chk_join_nr "multiple flows, signal, link failure" 3 3 3
 	chk_add_nr 1 1
@@ -1251,10 +1298,10 @@ link_failure_tests()
 	reset
 	init_shapers
 	pm_nl_set_limits $ns1 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 	pm_nl_set_limits $ns2 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 dev ns2eth4 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.4.2 dev ns2eth4 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 2
 	chk_join_nr "multi flows, signal, bidi, link fail" 3 3 3
 	chk_add_nr 1 1
@@ -1265,10 +1312,10 @@ link_failure_tests()
 	reset
 	init_shapers
 	pm_nl_set_limits $ns1 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 	pm_nl_set_limits $ns2 1 2
 	export FAILING_LINKS=3D"1"
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow,bac=
kup
+	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 1
 	chk_join_nr "backup subflow unused, link failure" 2 2 2
 	chk_add_nr 1 1
@@ -1279,9 +1326,9 @@ link_failure_tests()
 	reset
 	init_shapers
 	pm_nl_set_limits $ns1 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 	pm_nl_set_limits $ns2 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow,bac=
kup
+	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
 	export FAILING_LINKS=3D"1 2"
 	run_tests $ns1 $ns2 10.0.1.1 1
 	chk_join_nr "backup flow used, multi links fail" 2 2 2
@@ -1294,9 +1341,9 @@ link_failure_tests()
 	reset
 	init_shapers
 	pm_nl_set_limits $ns1 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 dev ns1eth2 flags signal
 	pm_nl_set_limits $ns2 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow,bac=
kup
+	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 2
 	chk_join_nr "backup flow used, bidi, link failure" 2 2 2
 	chk_add_nr 1 1
@@ -1310,7 +1357,7 @@ add_addr_timeout_tests()
 	reset_with_add_addr_timeout
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 	chk_join_nr "signal address, ADD_ADDR timeout" 1 1 1
 	chk_add_nr 4 0
@@ -1319,7 +1366,7 @@ add_addr_timeout_tests()
 	reset_with_add_addr_timeout 6
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
+	pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
 	chk_join_nr "signal address, ADD_ADDR6 timeout" 1 1 1
 	chk_add_nr 4 0
@@ -1327,8 +1374,8 @@ add_addr_timeout_tests()
 	# signal addresses timeout
 	reset_with_add_addr_timeout
 	pm_nl_set_limits $ns1 2 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 	pm_nl_set_limits $ns2 2 2
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
 	chk_join_nr "signal addresses, ADD_ADDR timeout" 2 2 2
@@ -1337,8 +1384,8 @@ add_addr_timeout_tests()
 	# signal invalid addresses timeout
 	reset_with_add_addr_timeout
 	pm_nl_set_limits $ns1 2 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 	pm_nl_set_limits $ns2 2 2
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
 	chk_join_nr "invalid address, ADD_ADDR timeout" 1 1 1
@@ -1351,7 +1398,7 @@ remove_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
 	chk_join_nr "remove single subflow" 1 1 1
 	chk_rm_nr 1 1
@@ -1360,8 +1407,8 @@ remove_tests()
 	reset
 	pm_nl_set_limits $ns1 0 2
 	pm_nl_set_limits $ns2 0 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 -2 slow
 	chk_join_nr "remove multiple subflows" 2 2 2
 	chk_rm_nr 2 2
@@ -1369,7 +1416,7 @@ remove_tests()
 	# single address, remove
 	reset
 	pm_nl_set_limits $ns1 0 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
 	chk_join_nr "remove single address" 1 1 1
@@ -1379,9 +1426,9 @@ remove_tests()
 	# subflow and signal, remove
 	reset
 	pm_nl_set_limits $ns1 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	pm_nl_set_limits $ns2 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
 	chk_join_nr "remove subflow and signal" 2 2 2
 	chk_add_nr 1 1
@@ -1390,10 +1437,10 @@ remove_tests()
 	# subflows and signal, remove
 	reset
 	pm_nl_set_limits $ns1 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	pm_nl_set_limits $ns2 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 slow
 	chk_join_nr "remove subflows and signal" 3 3 3
 	chk_add_nr 1 1
@@ -1402,9 +1449,9 @@ remove_tests()
 	# addresses remove
 	reset
 	pm_nl_set_limits $ns1 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal id 250
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal id 250
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 	pm_nl_set_limits $ns2 3 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
 	chk_join_nr "remove addresses" 3 3 3
@@ -1414,9 +1461,9 @@ remove_tests()
 	# invalid addresses remove
 	reset
 	pm_nl_set_limits $ns1 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 	pm_nl_set_limits $ns2 3 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
 	chk_join_nr "remove invalid addresses" 1 1 1
@@ -1426,10 +1473,10 @@ remove_tests()
 	# subflows and signal, flush
 	reset
 	pm_nl_set_limits $ns1 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	pm_nl_set_limits $ns2 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush subflows and signal" 3 3 3
 	chk_add_nr 1 1
@@ -1439,9 +1486,9 @@ remove_tests()
 	reset
 	pm_nl_set_limits $ns1 3 3
 	pm_nl_set_limits $ns2 3 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow id 150
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow id 150
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush subflows" 3 3 3
 	chk_rm_nr 3 3
@@ -1449,9 +1496,9 @@ remove_tests()
 	# addresses flush
 	reset
 	pm_nl_set_limits $ns1 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal id 250
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal id 250
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 	pm_nl_set_limits $ns2 3 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush addresses" 3 3 3
@@ -1461,9 +1508,9 @@ remove_tests()
 	# invalid addresses flush
 	reset
 	pm_nl_set_limits $ns1 3 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 	pm_nl_set_limits $ns2 3 3
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 0 slow
 	chk_join_nr "flush invalid addresses" 1 1 1
@@ -1474,7 +1521,7 @@ remove_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 -9 slow
 	chk_join_nr "remove id 0 subflow" 1 1 1
 	chk_rm_nr 1 1
@@ -1482,7 +1529,7 @@ remove_tests()
 	# remove id 0 address
 	reset
 	pm_nl_set_limits $ns1 0 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 10.0.1.1 0 -9 0 slow
 	chk_join_nr "remove id 0 address" 1 1 1
@@ -1536,13 +1583,13 @@ ipv6_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
+	pm_nl_add_endpoint $ns2 dead:beef:3::2 flags subflow
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
 	chk_join_nr "single subflow IPv6" 1 1 1
=20
 	# add_address, unused IPv6
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
+	pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
 	chk_join_nr "unused signal address IPv6" 0 0 0
 	chk_add_nr 1 1
@@ -1550,7 +1597,7 @@ ipv6_tests()
 	# signal address IPv6
 	reset
 	pm_nl_set_limits $ns1 0 1
-	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
+	pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
 	chk_join_nr "single address IPv6" 1 1 1
@@ -1559,7 +1606,7 @@ ipv6_tests()
 	# single address IPv6, remove
 	reset
 	pm_nl_set_limits $ns1 0 1
-	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
+	pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 dead:beef:1::1 0 -1 0 slow
 	chk_join_nr "remove single address IPv6" 1 1 1
@@ -1569,9 +1616,9 @@ ipv6_tests()
 	# subflow and signal IPv6, remove
 	reset
 	pm_nl_set_limits $ns1 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
+	pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
 	pm_nl_set_limits $ns2 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
+	pm_nl_add_endpoint $ns2 dead:beef:3::2 flags subflow
 	run_tests $ns1 $ns2 dead:beef:1::1 0 -1 -1 slow
 	chk_join_nr "remove subflow and signal IPv6" 2 2 2
 	chk_add_nr 1 1
@@ -1584,7 +1631,7 @@ v4mapped_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add "::ffff:10.0.3.2" flags subflow
+	pm_nl_add_endpoint $ns2 "::ffff:10.0.3.2" flags subflow
 	run_tests $ns1 $ns2 "::ffff:10.0.1.1"
 	chk_join_nr "single subflow IPv4-mapped" 1 1 1
=20
@@ -1592,7 +1639,7 @@ v4mapped_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add "::ffff:10.0.2.1" flags signal
+	pm_nl_add_endpoint $ns1 "::ffff:10.0.2.1" flags signal
 	run_tests $ns1 $ns2 "::ffff:10.0.1.1"
 	chk_join_nr "signal address IPv4-mapped" 1 1 1
 	chk_add_nr 1 1
@@ -1601,7 +1648,7 @@ v4mapped_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 "::ffff:10.0.1.1"
 	chk_join_nr "single subflow v4-map-v6" 1 1 1
=20
@@ -1609,7 +1656,7 @@ v4mapped_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 "::ffff:10.0.1.1"
 	chk_join_nr "signal address v4-map-v6" 1 1 1
 	chk_add_nr 1 1
@@ -1618,7 +1665,7 @@ v4mapped_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add "::ffff:10.0.3.2" flags subflow
+	pm_nl_add_endpoint $ns2 "::ffff:10.0.3.2" flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow v6-map-v4" 1 1 1
=20
@@ -1626,7 +1673,7 @@ v4mapped_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add "::ffff:10.0.2.1" flags signal
+	pm_nl_add_endpoint $ns1 "::ffff:10.0.2.1" flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address v6-map-v4" 1 1 1
 	chk_add_nr 1 1
@@ -1635,7 +1682,7 @@ v4mapped_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:2::2 flags subflow
+	pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "no JOIN with diff families v4-v6" 0 0 0
=20
@@ -1643,7 +1690,7 @@ v4mapped_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:2::10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 dead:beef:2::10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "no JOIN with diff families v4-v6-2" 0 0 0
=20
@@ -1651,7 +1698,7 @@ v4mapped_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 dead:beef:1::1
 	chk_join_nr "no JOIN with diff families v6-v4" 0 0 0
 }
@@ -1662,7 +1709,7 @@ backup_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,backup
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
 	chk_join_nr "single subflow, backup" 1 1 1
 	chk_prio_nr 0 1
@@ -1670,7 +1717,7 @@ backup_tests()
 	# single address, backup
 	reset
 	pm_nl_set_limits $ns1 0 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 	chk_join_nr "single address, backup" 1 1 1
@@ -1684,17 +1731,17 @@ add_addr_ports_tests()
 	reset
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address with port" 1 1 1
 	chk_add_nr 1 1 1
=20
 	# subflow and signal with port
 	reset
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 	pm_nl_set_limits $ns1 0 2
 	pm_nl_set_limits $ns2 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and signal with port" 2 2 2
 	chk_add_nr 1 1 1
@@ -1702,7 +1749,7 @@ add_addr_ports_tests()
 	# single address with port, remove
 	reset
 	pm_nl_set_limits $ns1 0 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 	pm_nl_set_limits $ns2 1 1
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
 	chk_join_nr "remove single address with port" 1 1 1
@@ -1712,9 +1759,9 @@ add_addr_ports_tests()
 	# subflow and signal with port, remove
 	reset
 	pm_nl_set_limits $ns1 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 	pm_nl_set_limits $ns2 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
 	chk_join_nr "remove subflow and signal with port" 2 2 2
 	chk_add_nr 1 1 1
@@ -1723,10 +1770,10 @@ add_addr_ports_tests()
 	# subflows and signal with port, flush
 	reset
 	pm_nl_set_limits $ns1 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 	pm_nl_set_limits $ns2 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -2 slow
 	chk_join_nr "flush subflows and signal with port" 3 3 3
 	chk_add_nr 1 1
@@ -1735,8 +1782,8 @@ add_addr_ports_tests()
 	# multiple addresses with port
 	reset
 	pm_nl_set_limits $ns1 2 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal port 10100
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal port 10100
 	pm_nl_set_limits $ns2 2 2
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple addresses with port" 2 2 2
@@ -1745,8 +1792,8 @@ add_addr_ports_tests()
 	# multiple addresses with ports
 	reset
 	pm_nl_set_limits $ns1 2 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal port 10101
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
+	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal port 10101
 	pm_nl_set_limits $ns2 2 2
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple addresses with ports" 2 2 2
@@ -1759,7 +1806,7 @@ syncookies_tests()
 	reset_with_cookies
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow with syn cookies" 1 1 1
=20
@@ -1767,8 +1814,8 @@ syncookies_tests()
 	reset_with_cookies
 	pm_nl_set_limits $ns1 0 2
 	pm_nl_set_limits $ns2 0 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple subflows with syn cookies" 2 2 2
=20
@@ -1776,8 +1823,8 @@ syncookies_tests()
 	reset_with_cookies
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflows limited by server w cookies" 2 1 1
=20
@@ -1785,17 +1832,17 @@ syncookies_tests()
 	reset_with_cookies
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address with syn cookies" 1 1 1
 	chk_add_nr 1 1
=20
 	# test cookie with subflow and signal
 	reset_with_cookies
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	pm_nl_set_limits $ns1 0 2
 	pm_nl_set_limits $ns2 1 2
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and signal w cookies" 2 2 2
 	chk_add_nr 1 1
@@ -1803,10 +1850,10 @@ syncookies_tests()
 	# accept and use add_addr with additional subflows
 	reset_with_cookies
 	pm_nl_set_limits $ns1 0 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	pm_nl_set_limits $ns2 1 3
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflows and signal w. cookies" 3 3 3
 	chk_add_nr 1 1
@@ -1849,7 +1896,7 @@ deny_join_id0_tests()
 	reset_with_allow_join_id0 1 0
 	pm_nl_set_limits $ns1 1 1
 	pm_nl_set_limits $ns2 1 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow allow join id0 ns1" 1 1 1
=20
@@ -1857,7 +1904,7 @@ deny_join_id0_tests()
 	reset_with_allow_join_id0 0 1
 	pm_nl_set_limits $ns1 1 1
 	pm_nl_set_limits $ns2 1 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "single subflow allow join id0 ns2" 0 0 0
=20
@@ -1866,7 +1913,7 @@ deny_join_id0_tests()
 	reset_with_allow_join_id0 1 0
 	pm_nl_set_limits $ns1 1 1
 	pm_nl_set_limits $ns2 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address allow join id0 ns1" 1 1 1
 	chk_add_nr 1 1
@@ -1876,7 +1923,7 @@ deny_join_id0_tests()
 	reset_with_allow_join_id0 0 1
 	pm_nl_set_limits $ns1 1 1
 	pm_nl_set_limits $ns2 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address allow join id0 ns2" 1 1 1
 	chk_add_nr 1 1
@@ -1885,8 +1932,8 @@ deny_join_id0_tests()
 	reset_with_allow_join_id0 1 0
 	pm_nl_set_limits $ns1 2 2
 	pm_nl_set_limits $ns2 2 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and address allow join id0 1" 2 2 2
=20
@@ -1894,8 +1941,8 @@ deny_join_id0_tests()
 	reset_with_allow_join_id0 0 1
 	pm_nl_set_limits $ns1 2 2
 	pm_nl_set_limits $ns2 2 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and address allow join id0 2" 1 1 1
 }
@@ -1908,8 +1955,8 @@ fullmesh_tests()
 	reset
 	pm_nl_set_limits $ns1 0 4
 	pm_nl_set_limits $ns2 1 4
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow,fullmesh
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,fullmesh
+	pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,fullmesh
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,fullmesh
 	run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
 	chk_join_nr "fullmesh test 2x1" 4 4 4
 	chk_add_nr 1 1
@@ -1920,7 +1967,7 @@ fullmesh_tests()
 	reset
 	pm_nl_set_limits $ns1 1 3
 	pm_nl_set_limits $ns2 1 3
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow
 	chk_join_nr "fullmesh test 1x1" 3 3 3
 	chk_add_nr 1 1
@@ -1931,7 +1978,7 @@ fullmesh_tests()
 	reset
 	pm_nl_set_limits $ns1 2 5
 	pm_nl_set_limits $ns2 1 5
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
 	chk_join_nr "fullmesh test 1x2" 5 5 5
 	chk_add_nr 1 1
@@ -1943,7 +1990,7 @@ fullmesh_tests()
 	reset
 	pm_nl_set_limits $ns1 2 4
 	pm_nl_set_limits $ns2 1 4
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
 	chk_join_nr "fullmesh test 1x2, limited" 4 4 4
 	chk_add_nr 1 1
@@ -1956,7 +2003,7 @@ userspace_tests()
 	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=3D1
 	pm_nl_set_limits $ns1 0 2
 	pm_nl_set_limits $ns2 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "userspace pm type prevents add_addr" 0 0 0
 	chk_add_nr 0 0
@@ -1966,7 +2013,7 @@ userspace_tests()
 	ip netns exec $ns2 sysctl -q net.mptcp.pm_type=3D1
 	pm_nl_set_limits $ns1 0 2
 	pm_nl_set_limits $ns2 0 2
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "userspace pm type echoes add_addr" 0 0 0
 	chk_add_nr 1 1
@@ -1976,7 +2023,7 @@ userspace_tests()
 	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=3D1
 	pm_nl_set_limits $ns1 1 1
 	pm_nl_set_limits $ns2 1 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "userspace pm type rejects join" 1 1 0
=20
@@ -1985,7 +2032,7 @@ userspace_tests()
 	ip netns exec $ns2 sysctl -q net.mptcp.pm_type=3D1
 	pm_nl_set_limits $ns1 1 1
 	pm_nl_set_limits $ns2 1 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "userspace pm type does not send join" 0 0 0
=20
@@ -1994,7 +2041,7 @@ userspace_tests()
 	ip netns exec $ns1 sysctl -q net.mptcp.pm_type=3D1
 	pm_nl_set_limits $ns1 1 1
 	pm_nl_set_limits $ns2 1 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 	chk_join_nr "userspace pm type prevents mp_prio" 1 1 0
 	chk_prio_nr 0 0
@@ -2005,7 +2052,7 @@ userspace_tests()
 	ip netns exec $ns2 sysctl -q net.mptcp.pm_type=3D1
 	pm_nl_set_limits $ns1 0 1
 	pm_nl_set_limits $ns2 0 1
-	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
 	chk_join_nr "userspace pm type prevents rm_addr" 0 0 0
 	chk_rm_nr 0 0
--=20
2.31.1

