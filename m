Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E18D2CA7
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 10:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641982091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFdu2kTEYUUXO0pAH6RQX7ddJKNVT3/+yJY9Kk0AC/Q=;
	b=DVJ6p5CU8pZTPrgPqjS2b9F15qFNJxXcofayTkXui1Pd/Dkpdslemhc0X0P/AGMzCZvwxw
	bej/ffEyddzn+eAo978PAHffuDdU10bmplp29/Jel0Dj/JYRsQIngsqT7P4yM4r4n6D2g2
	0SI8bRDj+h+lUgq9rfdMJPTQQzZqzmU=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-RFqw7_QjMeeHSFuzMY3e2Q-1; Wed, 12 Jan 2022 11:08:09 +0100
X-MC-Unique: RFqw7_QjMeeHSFuzMY3e2Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyKkkezb3tjTeNmLhfN6n2eygExyuYq/08DbjLn1vF3IbPIrK7PYdea3Z9PGEsMbZ87PXGQ4dejluVjGrcPGHmP2/vb37uHeei4AJkStsjh5COLLdbeis2c2skpC8Hs9t8anptgTsc7DxzTZeKM0v/PLYv0ExMjhXiJKTlEYh8UXPbB6/GGQbrNv68L6gnjCmLl4If1tahuu+NgLcg5/SGet7fqz/vVfp34AUbXq3S0eiUg1FpC1CAQKOveSc+C/fZlZpYD292BhB/xaMOsitvjC+07bKPrg+KloKT6VSu4LCsObpQhEOef20G4zA60n7g7k7b/MzRpbMkL/QkKG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xcS6wUrzYqDeT+uGAiQnEsJ4mX149h+DrHw7SOE0SY=;
 b=NPritOCnQKqW1ra/KUr4hlWI1+ivyxUK6P78Z4ao3ZAZMU/F1PDGpH86rsBGksipRIkaxjDOJODo5IBzcQpgDXEFQgDpku5vnSmOyhwjBIWJVt3gIrtwdZvVTta10GS4ZHcQ28ltQntcVtlLPE/mapYzRsIogVjZnTsy75W+0/Zd330zrfBAX4Srwy52bjfQ7AqtsdyCtb925Dt4iBwoS8T3H7VReNjKzGlLFWThCGYUDiRXUHdCQB9wfwkGNcAGTfF/Pi5byvtCv8jki6SOdV0HicGm9R60lj96T7Co3u7e6pxnnDhIkr5R8Hp0eWBOp90mZ2M231DFsXTz5Ib97Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB4533.eurprd04.prod.outlook.com (2603:10a6:20b:18::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Wed, 12 Jan
 2022 10:08:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Wed, 12 Jan 2022
 10:08:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 2/6] selftests: mptcp: new approach of getting ID
Date: Wed, 12 Jan 2022 18:07:31 +0800
Message-ID: <977c0a7be2ba34aa0bb45b21e37b5be66c8b93b1.1641981669.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641981669.git.geliang.tang@suse.com>
References: <cover.1641981669.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0170.apcprd02.prod.outlook.com
 (2603:1096:201:1f::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8aa565bb-0029-4e46-7dae-08d9d5b36f08
X-MS-TrafficTypeDiagnostic: AM6PR04MB4533:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB453310D9D200FB1675BB2386F8529@AM6PR04MB4533.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hDCjgEXGM3tNBiu1VZSS1J6MP98q8W7T2FohZu0Q4ekURhhvMiZe4H9LSy340JZYGYjV90BB++SyAd3Ra0Uks1SnjkBcKOm5FjZxZmbn0Vbxx9UDFk0Jp4SgFIWGVEL7YmZisBRQnIVHnhiXzuX6/SBg6QbxjKihnnx8RgCEjClDiskK4mqlsIivd3pvp2jH0QJ17GjiMNT9ASZLUvgU53cnOEQRA6KvkG8OGA3z329zbrf/0PLbFYTdnDRTNb7RwuUKKOC2J8tRYClMAHmL2if5yBJaFTgdoBTzgkhWS7LgQRtAHakl1/svs6HiqTIto/Nu/posvPDBNFsPeRoWozi1LSMW0oAZ8zz+U75YF/4HRcmo6L8oxwbGkHy0PBYH1nkTNrLDTnd71+JNd0ABpLJEbRQwyZ65Zod0V/rVd1MvECs0dwZQVntO6G23YuHKStrGIuoW2cr/IEs5jY16N0UrwBtmmfU1rgKBWfDebYzXdEeSmEZYGTIFTRT0xRggpCTWhPwEoABWf8zIVe4C8iSGr+crtIfaXQuLHoxP1oM06mTMeyBjUufgpkmoFIKW8DBip6ggun+5qYjd4OtdGpdCmuPuyOMknr2EMRgWuew2GbIAa/VYQz+wLoyL40DhS34O+ISXrpSx9blZdA94Dw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(508600001)(316002)(6512007)(5660300002)(2906002)(8936002)(6506007)(44832011)(55236004)(6666004)(2616005)(66946007)(66476007)(66556008)(8676002)(6486002)(4326008)(36756003)(6916009)(86362001)(83380400001)(38100700002)(186003)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0RCJHH2MoALp36oKJWDGas6a6MeKFyjtCX9TT5+INiSZdg/gQD1h+l1lHO92?=
 =?us-ascii?Q?+ffeo89+pkfOR/y5wL1z/h5FUz2UCtmIX2LXk2MC4Yayeor1E0M8X4St3Nmm?=
 =?us-ascii?Q?gFD42NaYSjCLFcB5XQHiHo6LklfZ21PfawFZcyLZOFDu/LllI/zK37BN9xrH?=
 =?us-ascii?Q?g72uDQZwV5iyChJ6+976Q5XCVGFJxvgnKRAQk2g5JXHQfKZ0Q9xli6bWdTjr?=
 =?us-ascii?Q?3FLt/hQbfMaA35f/EHBNHzYMvu+aYV8vdFcjESHWlqU+xz7BrXl9yki4YPKJ?=
 =?us-ascii?Q?XphbGt7VCyU93ICyNPWhSs1SccQ1iCGNWbur9apxIyVjC4kxkx87wAkRnW4N?=
 =?us-ascii?Q?lAG0ulDBGmrwY7MKJRmLNEcDcoj2aPFiU9D7saeXsWFwrrBN1+KKGzv+4RXf?=
 =?us-ascii?Q?mz57n0kGi1s22VKATge3qSCgcsTY/u42YVnaNTXnMFgH9CQ8BwTFC5T8lCbp?=
 =?us-ascii?Q?Id5NLxjNZXR+U8utduqLiPA4kfhSnkMTa2bPp5JHxHtRuKz5S/vpT2Y6is8T?=
 =?us-ascii?Q?MwguGmzaCgHfip6yV1myWsmDjmOTvHat7FzeT229unHWstXNGmda+nq9N+tP?=
 =?us-ascii?Q?d02BDSYYQchy8ef82AtMaAqEXRpZyD6jRI6KGJ3zFxFnpx4+7G5bamXbl/Fm?=
 =?us-ascii?Q?fH0cATp3ojQbePhxtIp6widPdfTVWlVyZcmYlpK5/8hanyxEJ7Eaq2fh4NCA?=
 =?us-ascii?Q?r7ezLWRsMtvOhSScaHAF7E9cRAhJS4K9KVKrUmnwGEfrERT95zbcuV0i0ONv?=
 =?us-ascii?Q?bSAJnZirHSw0Ugz1keHtck3w3/Y8tTXcHzXg6RvXWoxel1agz6w+gBCZFoOt?=
 =?us-ascii?Q?yJUaRR0I/7NhNTdEhehC4L0Kl/qOsDknstcYRQAqL/l+YNUKoZof9eguZtUL?=
 =?us-ascii?Q?8YfqkS3NcqzFEE+H0j9/gGIbNbxfvoFS1M09paaFU2+StAJzm1B5kc75rvAa?=
 =?us-ascii?Q?RZsSFO6ywF6KKXC7KzbHLRAm8ac/u2GucxXsCIGSt1i6d+PEBjVA+CSG4/YJ?=
 =?us-ascii?Q?1AdnzypwaIDMOsekwKBJ/SHrvRpkOAYwu452H9H3a9lpdNXmLOiBj9lfZnz5?=
 =?us-ascii?Q?pEv1pIKqZ0vo3qZ3Bf6o68lzao4ZhBqyEn9cKH+XWdQ3g1MXOUeBqCsu3zQY?=
 =?us-ascii?Q?X/qiR2DKJd1Zk+1sqAJdQcSn/TWXKpC8l5M+v5OsXjs5KlwwLO/oc6NKaFsH?=
 =?us-ascii?Q?igxG7nMwpzmoNUODTnKcpOxELtl+ao9JatlfxlerJuCAHj9t/RZQsFgiUa19?=
 =?us-ascii?Q?VATpjKM9TK76g4qbNR47ketkweuTc7Q8YsSP3PytuUJdX2c/z3SzCy8ke93q?=
 =?us-ascii?Q?Xzn8E5hE9fGTJOP7fnfltJg5uvwEmSoV4LPJXF3+uIZOzwz7SkjWnoxUT5VX?=
 =?us-ascii?Q?QUhq9MwQwsYkqZzrdAPdgYgqPrh7ago5OCPcQD2eftT8cTYZKPzVDkGVCf3v?=
 =?us-ascii?Q?beG+CJ/8gkJ8DBzGztjvWZeyeKwIaUD5e23Lc+q1guoDEgEKnNMCtRyRBQIC?=
 =?us-ascii?Q?rjMI9WhENGEsLLdiCL1oMby5r05leo63h4OwkS5YJkO6RwuCnc1cW354AYL0?=
 =?us-ascii?Q?OjQvaLmXWXrkwxNg7PJbsnKjcj6BzgINzobkTf+S3VvqL5F0rhLotkfM/7zo?=
 =?us-ascii?Q?N4iyP0y61mp+OTdqyYZLUOI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa565bb-0029-4e46-7dae-08d9d5b36f08
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 10:08:09.1606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kl7SrZ1Dhf2rwxuV5g81a5p0a6ma8+YGAJOmsXsIWsb2isD82BYg275mVgkAEsBw+s8OWgSJuUUhd18eK/uoGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4533

This patch implemented a more flexible approach to get the address ID
from the PM dump output.

The original 'pos+=3D5' in the remoing tests only works for the simple
case of 'pm_nl_ctl show':

id 1 flags subflow 10.0.1.1

It dosen't work for the outputs with dev or port:

id 1 flags signal 10.0.2.1 10100
id 1 flags subflow dev ns2eth3 10.0.3.2

This patch rewrites it to fit for more cases and the output of
'ip mptcp'.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 65 +++++++++++--------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index f7c41ba01de5..395f06784582 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -462,20 +462,25 @@ do_transfer()
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
@@ -510,21 +515,27 @@ do_transfer()
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
+			ip netns exec ${connector_ns} ./pm_nl_ctl dump | while read line; do
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
--=20
2.31.1

