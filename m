Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834C62C9D
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 10:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641985026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VFdu2kTEYUUXO0pAH6RQX7ddJKNVT3/+yJY9Kk0AC/Q=;
	b=e7zcTNrS/FCmq53xphXlBV0ix5WuhsPieV93T38zyCdSUuPKby8jg0FgHPkkJJR70Z4IWc
	h9ZxMHWbtTLzDgYH7xJUxWtRHCdYXuQDvOxAOJHt4k3iH27St07w9yh9pQoA+e1hiXanb7
	PABPm1e23VSDruVCgWdt6PqrZNvfF48=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2053.outbound.protection.outlook.com [104.47.12.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-18-BZCk6S_AOtqGCA3uerykWw-1; Wed, 12 Jan 2022 11:57:06 +0100
X-MC-Unique: BZCk6S_AOtqGCA3uerykWw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6QxCbSfd5E2efEi15a5KMYIJHkGmsXqJ457/jn8F1ywxcg90fpfUwZyiEbJ7uTO1MmyrQdaAEgr4469gT1AgpZmrXYm3g+ABHRsGj7XCHSXY3BXHK1hrAbWQaWGmVod0wpVb3dgga0ybMeyumeGcVBjTmcYvbH1UVVro/vMJ+8g364dUSMlfcu51YombD4EVgVwRTX2i6IixSHqZ2ctSAy2aVvF25/jKMAszMzB4eI2VpFNWafc/pL6pnxvFtvbO7MY4JOWonlU/m/+2dJ97wH8wK7OZivERczaHTiqfGi53927PsVp9a6w0jkzFkwDHNJyYq2TYChOhXrWlfTylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xcS6wUrzYqDeT+uGAiQnEsJ4mX149h+DrHw7SOE0SY=;
 b=lMdwDYfP/rxVe4I2bthC3GKH5IkJ/RTSv1KeB3mUblF2wuxglhl6jpv+z0XaJgpDnEVDZM7fMfPUk514d+YPYzxHa4I5TJsi6APqXd8RkHQ+S9eaMaOsSreNe/idSq7ZkQoF5KYXlwQ7GBSl08XJ/Ol99UXq29U60uaIy2r6EY+zr7epBMO5Dx7rJW1suzJCD3YQ73ilytnre0XGqrTkJjl/e0ksae420NzHFj0WQxSbw7HRS9uL9xXLCleg1Jf3nFb7noNKAp0lrNvIdoieyHM32aOeH0SF621al7ZYSDdb0NpNmrTq+xOXSdauyu9MsW7Joxk9KAFHZLFjp2LOYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3483.eurprd04.prod.outlook.com (2603:10a6:7:8a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 12 Jan
 2022 10:57:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Wed, 12 Jan 2022
 10:57:04 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH RESEND mptcp-next v3 2/6] selftests: mptcp: new approach of getting ID
Date: Wed, 12 Jan 2022 18:56:42 +0800
Message-ID: <ec4d71e9e4908f9b4557f7a3bcfaaf8889e018e3.1641984855.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641984855.git.geliang.tang@suse.com>
References: <cover.1641984855.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0067.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bcf962b-76d3-4dc0-89d1-08d9d5ba44dd
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3483:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB3483A2727932A2C36CFA3430F8529@HE1PR0402MB3483.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nqlHALTy6ZGeFyX9BEF4CwGsQQEbx6h//zE4a1C+X0QzZU/Yl+1WLlCC9SfcQ7N9gRFquMDDy3VBgW8UrLHR0KDgtFfhhCJHrXBcgp+aPSErRMqHBnn6IR6TbxfhXyB1MqwdHO48EUpqK384qALlyTrUYKRm9HrT41rshvxDu4d/wNgx0Xz9G6B8u3Ijqf6wIJ3to+ZWZxL54BQDxyIT4RBJ2enusqjBbgW7vTzCisg52gFwktig0PAM5nX89thbR18zuWiQmLYVnzuEELiIo3Jf996MmkdvWtg1TAcU9mKLYeo8aoCfpNpaDTmJAKj/tOwJmeBqdVzrTYLbWNES0xHObmoT28dIqxbvRWbaDGKAa9P6VWnPCESX87lLk8b4LmFVihohXZdakkfvIeQBPFux/VzPPudH6YSi8r8Out4uxgrc/K0hagNMTVcYaxm3UKqJROeSYVTzQwFTkiC4FgGwQIuVi2pZxRXDhoFwzANLptjhtxF09j4U5saIjkbLJuFHZNSlurlBsfk3UikkQptHvuiJwrtcLUAXzEOIn/2Y+qc6cztBtYBLuCFFgj7vn017hAiMQ5dERs/JvzEyW+0s7wcU/EXtfaLClp5zqysk/PuC6mKi/cASgmLElAAICKUZcUkemaXD0sldBYgizg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55236004)(8936002)(6506007)(107886003)(6916009)(8676002)(36756003)(38100700002)(5660300002)(6666004)(4326008)(186003)(26005)(508600001)(44832011)(83380400001)(2906002)(86362001)(66476007)(316002)(66946007)(6486002)(66556008)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AIeMgAtRC80aARoGkA11NRtykFa5t3yQEiFBxVlAks9P8hq7oDY6B/8AnRqB?=
 =?us-ascii?Q?m9eeXYIXRt3dTqo1Gn72aQDhbx6j/suEHfi3gzKJSUrOCs87N53MF17tf23Y?=
 =?us-ascii?Q?TSiE/I7HBPT8h1AGqw/mIZMR5UrjPIgDbL/tFaTL3h6frCOHZnFZNj8Ekahh?=
 =?us-ascii?Q?3xN5kvkC0+NRDaCEsDwB96OVRbv9FidFbSidDcU57OBc2psRZLiYueEcETnZ?=
 =?us-ascii?Q?ktFhgckDCuS6b+5CoCfmCcTQDRrBtXm96oQgU6JNkFx9+nKY0NFSai39rizd?=
 =?us-ascii?Q?jHfIkCx0d/D8ItnnKwfpyFq7jYUZSBo4nz2gbmaYQfpoZkJXyIMYZIyz7ssl?=
 =?us-ascii?Q?1BRxZBDTQPLQF06thVywZSvV+l8uxnVIWb/MC7CVHyUZB3Sw4wYccUJZ9hqO?=
 =?us-ascii?Q?byySo9wKHZk5gINLAy8AMSTxHHIFMRbpaBVc7W2nLqvu4acLYRJnR5Ksu+im?=
 =?us-ascii?Q?McW0a6jTuXlmCWoRGoFxsnWxgM8nDg5n0cn4BiK1NJma8ECOZ4jG2p/NBBGS?=
 =?us-ascii?Q?Ku3/rtYq0JcSFr4I4e5uCs022FG3ZRA58DTKuoshFIpw7L95Lb0uqG26iPEM?=
 =?us-ascii?Q?1cYlM7L4oSNQJ+m/a+Ddye1EtXFcJrc3jbhNfI5cJTnVsQasuzrjwRyePu47?=
 =?us-ascii?Q?MyFHbm4Hv4ihXyC9C+OgjdqBn+2DnD9hSOi0fSmkL+4lVpyElP5niZBNYxJY?=
 =?us-ascii?Q?6azH9CGCFNWTWGjGjHc4zubWYs0Lr5lOoutQHLbKa8dH0Pt6Ij+uMSv+ZuNX?=
 =?us-ascii?Q?gT/cp/xWTCLPjo6aPf7IE7juXjitGT4An8jWvDa066wXpu7cMPmWRUYpHMHK?=
 =?us-ascii?Q?XaixdqJ2KpmzPeLcEwCm78EFh9UQ2GXeXLGGz2DuSWoLVBrnawPQ1nPvcg73?=
 =?us-ascii?Q?8e6H2x2mImad2upnTgA6JEW3f0u5X+gHzT7rJjS/tCFjGeNN0yUIoa/tkUKu?=
 =?us-ascii?Q?jSiwGImqGKbeS/D/8wDP3sD1Tg7+mtQCcGuHeUlmee79Tg8uVW5ow8kmEo8s?=
 =?us-ascii?Q?m40jiJ3/suChPiCHaUuPgWp18YOOHs1SprO2+Eh8iCz6ZelBufdLKigKzWwC?=
 =?us-ascii?Q?c1GvAC7LrKNC7A4pNBSu9HhAknaUvr9L3ixhGcshY9ZwBGuHJuNlvJ4I2j3E?=
 =?us-ascii?Q?V2joCgBjxqQ4DivvmeJlQJMgl/frXF3kF1pouFAep3Vw5ZLtZM4iPiNNweIe?=
 =?us-ascii?Q?ghcj5BC7m45e1kgiH+Hw/bPR964aH1AfbNx1qj9iqa+frnwAl9wGsx1LMmUO?=
 =?us-ascii?Q?NqdKkxnOvNT0b1fLHfMF7DFdhvyPgJOydoQFhICBU3zRqhRO6F1B5Z/XRbvd?=
 =?us-ascii?Q?NWPnRz2lr7JRlMNUgU4SwOR+queJ6P0nEtJgMgvsMlOWejzw3jA0huDiDDru?=
 =?us-ascii?Q?FJTHRwWevzP4UjZZkUrCxewL0hkD4WlAoOiGA8XmGpMEy0ifAMtfHEtbROCO?=
 =?us-ascii?Q?KQuURti/7b1Z8AKQPh3BU8TVb9/92b4TqMNluMpqmCsiwjKtyXTu5fBI75AA?=
 =?us-ascii?Q?bNwsom0rm80ZM8Ao1yExZPLr0mPlUEm6s/TGpn2EvJ3iveyxQUQZuS5mfgZW?=
 =?us-ascii?Q?khyfP7N4eDhJpXw7XkhEMORdKHEFtyrMmDKxU5FBxlehw5rvZq9XUbVKzP3b?=
 =?us-ascii?Q?J4x/J0g6xXxOvOyQaMoohG8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcf962b-76d3-4dc0-89d1-08d9d5ba44dd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 10:57:04.8607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L464aiwxN/Uz/GZsz59TZdfQdiAq3/WNrR51ZtaXfDAkLRcAbZid6FlAS2NffD4HHOoFdAguxXo23khLGn7Ixg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3483

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

