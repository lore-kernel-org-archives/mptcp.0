Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC682CA2
	for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 10:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642156064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qb9OFtwENt4D/tQvc7XQ3rg5vqfQXNlr7jrhTX+Ctq0=;
	b=TMW932VJ3XrwOeMtPsI3LfQab2JgblT+W+U7efJOnBPcOta0zLznPBkzgg8zXUUWgK+8kq
	Jqr1a1NZRPTLkEMzryx9nEbuPVLIBNTZFx5KKjBH3BNoM51dxqwqgl1uFqAyHSz0zaikYV
	zpvGW6tPPMxy0H93xKCi9JkqqQRSsb4=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2111.outbound.protection.outlook.com [104.47.18.111]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-32--FzHelQkPSqjJZ1JUCdjSA-1; Fri, 14 Jan 2022 11:27:43 +0100
X-MC-Unique: -FzHelQkPSqjJZ1JUCdjSA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lC5E4OPjKwvvkRMFf2/StTIJehhfsDIZAgQdlKFTwIigOyFRRRhse57i7wR2OLELx/anJfuVENdijoyFaLC6fL6jCMJF6yOwyBQVVp6JFlXKT5aDsESrCuLyTU9Ca93mfss2s0MmWxjtOibfXEFLZBUipOUUoDj1tOUKvSWeUL5/m1XYL/UVKQB14umLajicMI+fwoK9/uIT0qSfcDjFybtzRxIruoAzrF4dlpHEjqgUtD53Fqm25JUToLeveBqz4OTIKYju3AG25+P6DFEaEcRHHsmn/DKZPgq3dP1izE7pAHzPYJLaxNEo6HrckMozZ/xk6i3CG7xTCd889qo9FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5t+MW8f6yp/T2U2D7v/fggsiJcfW3b7dg2aV7Fz5nck=;
 b=QpYvD2kcrKSq+6MbRRtmscDaW03yzeEn8FJv3tlEt8rWN7mrd2SW+561BsmLmb5FvNLe/8qmFQqZ10XfYOXVCjRskznQlFPxRyys69GIjBCSTQfJ+i7yvPH0jql0CKeLu6j2s1uXNw/T5f8ahO3A97HGuLBfdJqdS//upWYZWkm6zjpvlwsFWsWeGJFhQzukkw/kzQuL6ULen7W1TN8CgU0TX2EHo5/lw3KFeMU33BzLIO5sLyXHYvfbxnJYYEnvYF/FyKCd21R/8/FHpszBhParoswoWx8ecqt0Wuner5o2FAqOfNOe5SObNK9rprj+Wze7b53GqXIf1ghfIWvUbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by VI1PR04MB4558.eurprd04.prod.outlook.com (2603:10a6:803:6f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 14 Jan
 2022 10:27:42 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::94c7:de62:9c1b:6484]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::94c7:de62:9c1b:6484%4]) with mapi id 15.20.4888.011; Fri, 14 Jan 2022
 10:27:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 08/11] selftests: mptcp: new approach of getting ID
Date: Fri, 14 Jan 2022 18:26:27 +0800
Message-ID: <14e547f9691ee85c0e34a0c8c87a3e6f19612b22.1642154579.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642154579.git.geliang.tang@suse.com>
References: <cover.1642154579.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0193.apcprd02.prod.outlook.com
 (2603:1096:201:21::29) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5b0c087-0f16-46a3-35aa-08d9d7487f3c
X-MS-TrafficTypeDiagnostic: VI1PR04MB4558:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB45589F3D56BBD75487DF8832F8549@VI1PR04MB4558.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l9Osp5iVXIJbmEnYruxJ9ryWhm31lUXrsxjPfgDLwRbDJhPyoGShXo5sH2pUs45RxWFnzNMY6n9JkKu2Jv46ERYrTzJcT12MFOaMHCtIlDdrA1YE5jI6A7OOONhNrFQPhAQla9LnTSlk+cVXNi43yhc55Ma80itYURWsKvIQU2/zJYWTzMdAmXYBvzKI2wQwLUnT21rcWDCgzucXb/fjENuHfZVk2mDbHDNtLTu+qsKi2oW6YZjRZoqS3ZicT53ig0EdGry57EBoMPoUvZQl0HHEwY09KZaoyKIeBBPlmAGFu+wv5F4GPYytAlrY5oHCC2mKw5+eI2jj9dZcbfLwqA0a/LgFZijHDNX4uwBdLqhTxs6Hw6QCH3Otm7n0zmlKE+uI3qR69DlMk4aVP0F1NbknoSW3o9v5s/eAVdmG8RqBBRMM8Liq+1Ue1ZmjbWD+UrSnHMQRbfjEku1J6L/Htx05IcF93B0bx+mqvP7TFLf5f3yJk+tv8t1iENVqKflvNjWRoicBvbFSahwxR7814KWVlWUy8Su2i04hBYwK3khVyb98M6BLoVE0GgXstSPfjANk4vmUBMEWj3L4J5ztLbKUiLsyplug6RnIkWYFah0/ga6+kEfbV+PFFaHGcq7CqnHBbtuMULKo/5CkCz1cJA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(6512007)(5660300002)(38100700002)(316002)(66946007)(66556008)(6506007)(8676002)(36756003)(86362001)(8936002)(44832011)(2906002)(26005)(4326008)(508600001)(6666004)(2616005)(55236004)(107886003)(6486002)(66476007)(6916009)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SMnHvO7l43Zq4lCXBU2Aw+1LS7KPokcfYvIzMLfEhPqXdhCF2oJniDI8Y6vG?=
 =?us-ascii?Q?zct7CKY+43SAqy7g8pHm58K7QBpf+qZad77AdItMmadEqO3ZTpx40GyPWnnG?=
 =?us-ascii?Q?N4VZ9r8S/KF6gCtu8PF5zCqBl4MWPA3ONRhXGaAUVFBrygCnUuvVA4AFmJkb?=
 =?us-ascii?Q?yItc5ls/LIxmfiyb0ePlMcEEUf5gqWgVgzK0iRbR3XKgbhqBBA0/iA+Nbs7E?=
 =?us-ascii?Q?3e2RGcDDkp2lJmk+9Rzel83NGx1LwLq0VJ2Vh/fOQu58ePacAa7VKQCUiXOW?=
 =?us-ascii?Q?uRpusGQ1H9CgFCtvRZ1DG4WlNwEcjtmnTbi2iIg3Vp6d9qP91CgQci0sUH4Z?=
 =?us-ascii?Q?+bepp+yVrwgs6KuEwTT9w8HfjHvbCwjgqNCOgW6Nu6zlrTfbz6/zt3951oNS?=
 =?us-ascii?Q?uzHcMS+en1aBzkeByL5BFuRG0h50JaxSZWB8VtbIjcFLLt0VYrfF3aHmByVc?=
 =?us-ascii?Q?oTuEEMQjv21AjihWgYvcFXyahYnNPPKpCjJ07OWFG9rGEeScC9vAyx/R+eMT?=
 =?us-ascii?Q?QLuitPI6GREttDrv6hAM5GOJNIpUuIQD4TxF40IGQncGUdyFjK/vzO7zf/aw?=
 =?us-ascii?Q?aYNlG5Erf2yzZpeM3qxYYQToIbq3xqB9qx0Ikx50pxQPShRYqhP5N4ILTUd1?=
 =?us-ascii?Q?fX+bU+fVSrjOYdf+kzwPCPhXJAbNBgHejPIwe825JthZSJMqXHl3frrWzdXA?=
 =?us-ascii?Q?JX5MhM5xFNNPDv90KNINAeeJNe72JmKjSghpK84+xGkjcYdO7rXidSmqtLuI?=
 =?us-ascii?Q?xZ73yDHBT9HJHJlSlxidvDxRQ0BLVfan8hHuC8QN3BhvR91iTTndmBhm7Obi?=
 =?us-ascii?Q?IhyLPtCTTTMCuU2TPD2l+ZsbcexFgONpJQPXuu88NIshFAvw+KlF3W1iBIWj?=
 =?us-ascii?Q?pOqscMfNCEnl7pHYULhtOFE3F83mT0Jr7z2NAbxkyGsWXfGeHQ1sYBpdwl2U?=
 =?us-ascii?Q?O1M5Fhb3xyyEYkBXjTrRL90BAUw8YrQrg5/oUpdkAYRMoDSCpbaaK6N0ahGL?=
 =?us-ascii?Q?/UYEvulJCuhvIeh3ZZMDXh8sO8Tv6RLYrxFoZiLIfcCfHWbseSG07wpmCGGh?=
 =?us-ascii?Q?togRc6TqEHOEM/TNDEvgsHrbsic+VHUVBStbzX8lHjILqNiCmx9zhnubeRnj?=
 =?us-ascii?Q?80XCKY2hElUydnxm0I/in6R2FS2NkTsp83J1o+lRbEXWZA+Heo120r5hCZ/r?=
 =?us-ascii?Q?/I52o2vDEIv5jatf6zpNAhkAqlZer4qytvvA1SOww6PNJX5C+PfPcpHLH1je?=
 =?us-ascii?Q?ccyOS8Su9fL56nwpjX/dxWAzBoHW/8//PsKT0zgW/Hef+Vaw1267dmEDmc/C?=
 =?us-ascii?Q?V6PT7TvL/aXiJzXzy0te3oLaNOow1t8pk+frv9vvsTAEDDEr+1JmTmihf9S9?=
 =?us-ascii?Q?B+cSW8+CNEPvYm0uXkEcZeXWydCXD2O889A9BmvjcD6w65o9QvBNLRXacMHm?=
 =?us-ascii?Q?9ZzwRya+Y1CrCkFIN+34drLlbcAfPOivQPCqtb0TvGh2cRCwuNBRRtV2eTY6?=
 =?us-ascii?Q?DnyUfQz9uck/mo1ZhQyVW7w0T3Fa4HhIvhctArzFlP+10Ds8je2r0QWJ0OFx?=
 =?us-ascii?Q?e7Rqjj1rUJaERG7lg1X5lwZ+vvlkD4KzmPd0LGNSatMf0eUNB2jjblVJQvw2?=
 =?us-ascii?Q?rCnQX/rloTsgZT4ruu6NCoQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b0c087-0f16-46a3-35aa-08d9d7487f3c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 10:27:42.4873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3WA5R6bwYGkRAqKXvC0hmRn7QOVZGYyOBS/sYPogFyhEa4GuumkYUWi3kSyjyZ5zNSacVjsb8xfhHRPAqL/8cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4558

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
index b8090963d1df..866b499202c3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -473,20 +473,25 @@ do_transfer()
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
@@ -521,21 +526,27 @@ do_transfer()
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

