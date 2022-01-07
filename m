Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7655A2C9C
	for <mptcp@lists.linux.dev>; Fri,  7 Jan 2022 05:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641534726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6OgpNsKu2LmROJMUCIvmNWWbCbrj9KB5/lMwGcyGb9k=;
	b=JBiM8x7QQU8OX6R0Gqb1jhavYAi+FG30W31rvGVY0ARXEh+JFHOZP50vwi7oC3he2zUJnN
	WwnwVOuHHk88kLRla1tRIOS5wH/XWSS6VSOVJcBJHQyx4rva7q6cVmpClqKH+PzS22ENPY
	F37c7aTY3Fj2HNazyy2R4KndcbFePU4=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2059.outbound.protection.outlook.com [104.47.13.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-_i2OVl2jMXukUBeZjIavsw-1; Fri, 07 Jan 2022 06:52:06 +0100
X-MC-Unique: _i2OVl2jMXukUBeZjIavsw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXynHNjORu9vIIN+fPRjLufmAU7CJudkpSrVjZEzHHIoLq/8KVTYWtGMEESbNfSx/UQD33UiLEp3Y+w6AyXwquV2vk4IdZMKcukfvUuiVPYiQiARexSMhcqEM/x+iS4/nDtiNeF4f1VFulTCNYt9wacto6zoh9q8tUCVaxX8xP/65vT/Rt4JQINvOBklCKAfCmrE047+QQi21P5hmVrN9XjyyVP+UooCmfR53Qs2iU3i4KObOviUs4T8jsweLCI3N78rBqQUbZJr8fAobsYl/zXsNIOIn8oNF6MxQVgu0vb+lFT1k1l8eNzWoKoUEyvyWiA7UY8xFvtucCzn62u6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZrn5vbgC0iPi5F1qUKl77WDq6ghg2PX50O6J+BKFYg=;
 b=L69fhuI6JweY5C/U5M99zEINFhz14X0qphzr9bCyuc1LlQ6+1f5mYagNYdKV9Eo5InUYZpnS+fqakX8OF6OORRSxF5eDZHp3c0RH9XPCr2MO2YlaL3g6lFceiosq9GUBveyEPxbCnQAlrnBCReDUrGX3Pj6tR9J90m5QFpyCiLypLRELCGDCAuLTV2cRBZWKqhwTY232qRp+d8ouKBOqKCTmN4YMgObSCJ9KZjf6273oY8EVW7J1RH89fEACBWu5N1z3jkAm0g9ZgK/NslSF08CMc1U8ijqR5juf8BjQrsD3sMuCTmSQa6wUtlH2JphS0ot20LCZIGAU2qanL2JPMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2731.eurprd04.prod.outlook.com (2603:10a6:3:d7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Fri, 7 Jan
 2022 05:52:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.017; Fri, 7 Jan 2022
 05:52:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 1/9] selftests: mptcp: rewrite removing tests
Date: Fri,  7 Jan 2022 13:51:43 +0800
Message-ID: <6496a688fa9dfee75d103638b56ecea4bc07072e.1641534346.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641534346.git.geliang.tang@suse.com>
References: <cover.1641534346.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0178.apcprd02.prod.outlook.com
 (2603:1096:201:21::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c57b486-e9fc-4ea8-0f6b-08d9d1a1d566
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2731:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB27316FD8EF24D94BA38CD2BAF84D9@HE1PR0402MB2731.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OWBfBXmDSSW8ynHq3XOh8Me/hlkzMG15A+bhJH6Fte0EOtfVWoUI6Q1GCQJi+syIe2SFIvY46qaPs373//UR+zZt9fXcWqbzJS3+PkWxU/H8D59Q/8zClv+feIaiAjVQ+DnZu77y9bm1nuZc84Qj0smv3bklJ63fgUimFSb3XN0bJhBuVRH7/GXB1hMoiM0MSwckDxcqRWLo5sWV5sIJu+g5aJhLLSP9RAozVnsDl/QsF22JoyZIdZl87UCRF57dAPlO5DofwOS9KlJg3ocsIAxbKej9xVz+r8N1Os1LL8pms70BU1xerbds7Q1e83MI+9rMnjLqLy3TgxYC+3ed3uEZ/1DukLVCzowVyCFu9P5yRH68Oa5ntRQoTnzun5sWi3TLJNKymJdWtztEp+no1awLdS+gQgqSfXDhZNUMtndnn9AGMfW3BxblcqXrxgnfn7M9kC6qyrWvOkpbRQe7+OULLBeChbcmS3P18LNBSG47i7En0IN7+hHgKGNoawsBBZx26xkkbD9aya/fs/knoXFAfr4owQjmhT+h4as3RgzDHThPBo+bsU2DfSMX6xW3b5S/GnNT1gLsln5ovTbOXN+pv4K087q/oNe/6i+1Lp6plikh+aRGAg6AaZFViLzrg1B8T5b35xjSR591w0cqug==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(36756003)(6916009)(8676002)(107886003)(6486002)(6512007)(4326008)(186003)(2906002)(83380400001)(66556008)(8936002)(44832011)(66476007)(66946007)(2616005)(6666004)(55236004)(5660300002)(38100700002)(316002)(6506007)(508600001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w9PXFchSZV3KiqNYkzIBCXNfe60efzRejkkyPR7It9dZwhBp/XH05JiHABgS?=
 =?us-ascii?Q?R+U9J1Fr5UNK9PMu5khXQ9dh3wkjid61fa/aqlQkJ+UtDnghTdBaOQfbc/N2?=
 =?us-ascii?Q?+6ASK8Ur8a4PZ6yXZwlsHI0NSKspjZ6kqy2gZtjp7ObdiypH1/jRjv9zn0V/?=
 =?us-ascii?Q?7KwqnnFE3B3UmNSFEIVjb7E6roJSO69RrpKnJzJ+Ms9hwWz21l4PDffGiCg4?=
 =?us-ascii?Q?NMqHMgRtzIsl0ot3twUyGC31SyWXfkvr8yBGICvk/6CJBWFOwuOgvFCgNL3B?=
 =?us-ascii?Q?PscBtNcbh+r3ATFhV8nUB0XDDewbf70CQiLR0dfT3fdi748il1+TU1/8TLZb?=
 =?us-ascii?Q?jGTTlas1E80YzYGFphCdFNX5xRBzIbO+VZ5+SD5rxuyJZWGRnVHX6vydrSvK?=
 =?us-ascii?Q?1tKnxnhUN//3wZU1V3Gnn9PslBjy36TDOO5Ju+Nwg+LME17u8sZokwCSqHMC?=
 =?us-ascii?Q?Plr6qPXpwKG2ln4/deqBK0WqRumZMExOCsJ6FcfLWNa86K3ZpYtHbgpy/H2k?=
 =?us-ascii?Q?mN+F/me/hfwm8tPViu+nMsJDiVLYnIKNxcXniEUn2xLHWR1zHN9AITCDJHpa?=
 =?us-ascii?Q?0D2Pra2GlosyIg8WEbuenmvIRBijhs7E5KTzcWabYIYT/5kpuSXgD13F6pAD?=
 =?us-ascii?Q?jDcsn3WTUvMCFT5kiNDE4l/u86uoR3zGFcM/r4onudigXBiu1dTfgssAAZp6?=
 =?us-ascii?Q?qme0/GALHTnohAUs9acG6itYGP0HRDtL0vUrGnFAxIA2ll3QWe8nJHohB5iO?=
 =?us-ascii?Q?cbdWHBCJAL4ENeYn4MPSUY+lSeaSxxiVnQXcstBPmKfujz0/xycCdJ3avobF?=
 =?us-ascii?Q?2VxyYcdFdZ9XW1K3DjAo/CpRlFiRml823Kdpww79pJnJutMH3Q68wwDVWnXk?=
 =?us-ascii?Q?CFehtlJBNsd5SC8Z2XThJ47W1uv+Aen1mFIHefju/uxdJc8/ITvw05vNcojF?=
 =?us-ascii?Q?4VMn09+vXdCy/iMaTZMYGQYnLvtk/XPPggguG6+OShdyL/rOmuUWB9hH3HI6?=
 =?us-ascii?Q?m0/g7bwDM4vfSp1p8tkUUe6W5rdniF3jj3ZT5w4fqUJE+dkmZ9hVAiWS0ej2?=
 =?us-ascii?Q?MLiQuZikr+fCFPutIOMeu3l3irErRkDj3SuTgCl/sd6LFZ7siWBEPcJHbtam?=
 =?us-ascii?Q?I5T6ZBSQl644prCeOI/T0PFqPMGUxotjBqo55ify4RxWebsJrT1JUU2zJL7V?=
 =?us-ascii?Q?/LWsKfdIPPcvm6aDesdUgRSO/YYzDbBDPzJartVr7Neb4/AOD9D8Tq/Sb4ej?=
 =?us-ascii?Q?SuUgexY+VbETL5ZZevH8awpv5o4eDRjwIGnnan8M5x5+r4OhFCwx1Ldnemv7?=
 =?us-ascii?Q?AEdNLrdE0UICrthO4a8wX45qxv9sE9HVZiCNmhzUXWlRpQeeCrThIZdO2DbQ?=
 =?us-ascii?Q?5MkKMCALLtqO0QJfb60N3O8wd08Jybt1xLUnJsqD/5BhkewWdsvfhK679s3S?=
 =?us-ascii?Q?qyDWb/2qACkj04F2IAMNLHsVBOz+tNVePeqJC69G+80gDsYqlsfxm2zFzNLr?=
 =?us-ascii?Q?gkJF2SY8M9Nc/3QdfPQlmBmWdRvLLNFJCgtIj5q6SjQZh/inNMoqoh99ZDWb?=
 =?us-ascii?Q?z8b+wQa/OWHoKWcGl9djPThBsK7dBQL+uiq3KiHhAvHMz7Yvwvvjznmv18+a?=
 =?us-ascii?Q?wd8hWajDiKSeAMSuUZLoxAU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c57b486-e9fc-4ea8-0f6b-08d9d1a1d566
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 05:52:05.0592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUMvSZNh6i/OedWVO2aLS08Nt52G+gIDS/V7bt6DkY4rOeUnpbTIsVvfE7Y3WLdOI1N4Ctv+B21QHgCYJJHLTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2731

'pos+=3D5' in the remoing tests only works for the simple case of
'pm_nl_ctl show':

id 1 flags subflow 10.0.1.1

It dosen't work for the outputs with dev or port:

id 1 flags signal 10.0.2.1 10100
id 1 flags subflow dev ns2eth3 10.0.3.2

This patch rewrites it to fit for more cases and the output of
'ip mptcp'.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 64 +++++++++++--------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index e48ce23d2386..1b7f63d64e55 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -385,20 +385,25 @@ do_transfer()
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
-					ip netns exec ${listener_ns} ./pm_nl_ctl del $id
-					wait_rm_addr ${connector_ns} ${rm_addr}
-					let counter+=3D1
-					let pos+=3D5
+			counter=3D0
+			ip netns exec ${listener_ns} ./pm_nl_ctl dump | while read line; do
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
+						ip netns exec ${listener_ns} ./pm_nl_ctl del $id
+						wait_rm_addr ${connector_ns} ${rm_addr}
+						let counter+=3D1
+					fi
+					let nr+=3D1
 				done
-			fi
+			done
 		elif [ $rm_nr_ns1 -eq 8 ]; then
 			ip netns exec ${listener_ns} ./pm_nl_ctl flush
 		elif [ $rm_nr_ns1 -eq 9 ]; then
@@ -433,21 +438,26 @@ do_transfer()
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
-					ip netns exec ${connector_ns} ./pm_nl_ctl del $id
-					wait_rm_addr ${listener_ns} ${rm_addr}
-					let counter+=3D1
-					let pos+=3D5
+			counter=3D0
+			ip netns exec ${connector_ns} ./pm_nl_ctl dump | while read line; do
+				local arr=3D($line)
+				local nr=3D0
+
+				for i in ${arr[@]}; do
+					if [ $i =3D "id" ]; then
+						if [ $counter -eq $rm_nr_ns2 ]; then
+							break
+						fi
+						# rm_addr are serialized, allow the previous one to complete
+						id=3D${arr[$nr+1]}
+						rm_addr=3D$(rm_addr_count ${listener_ns})
+						ip netns exec ${connector_ns} ./pm_nl_ctl del $id
+						wait_rm_addr ${listener_ns} ${rm_addr}
+						let counter+=3D1
+					fi
+					let nr+=3D1
 				done
-			fi
+			done
 		elif [ $rm_nr_ns2 -eq 8 ]; then
 			ip netns exec ${connector_ns} ./pm_nl_ctl flush
 		elif [ $rm_nr_ns2 -eq 9 ]; then
--=20
2.31.1

