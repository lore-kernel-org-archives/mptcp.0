Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A3C2CA2
	for <mptcp@lists.linux.dev>; Thu, 13 Jan 2022 09:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642066170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BeHruzZ7KK3kOCNWUBgD5MJC5atbY3Zn68WKd793jas=;
	b=msAg7jTQulOBEnRN+C5h77o8mcH8ZUHlgxawww8nOrSodPwpFVn/Qq1RoxSd0PumbPBq1o
	noQffeQ6UoIJ/baVE0dkMTQYmNcJT8MWCLvhkBrYPd7Zy1ZmQd4Z2z4+aQgNypTzqNGPjG
	1boZ/ABfT/6dTifqZdtQAR1BZY+/gnI=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2054.outbound.protection.outlook.com [104.47.14.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-j_fTD-fWO5igIJjXJJ0V2Q-1; Thu, 13 Jan 2022 10:29:30 +0100
X-MC-Unique: j_fTD-fWO5igIJjXJJ0V2Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9Qynwk+OlnH0ZMghxTWW8s7F9F5+g8WV4pS3tUHZtqdhAaU7QzYRESW8G1lcez+3Jj6OvxPN/dd8qsgHNKsJ8n8n45UKUYKz7lLcTDGciM3FHJb+3EO7suO0D5VYmdJEwoMEWMa4PeAc/+I6Y7K4B9KrYa9MqIsNSleW46+ziOM6+W26xlaZ6gvwdBTfcxhZKmmOuLf3X5qvpFGHWDSFcL4Y2bD/9lXQHLePPZE7MBcldiwt57Me/Vz55JpnVMHFNCi2kBGinPmM+It9nsopyKbI4EFiEhGNVSzybGgmGbA6hqcXUxzqxgDXyNNWPhTYPsMA+qz+9ExY4d7WoIffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgKCwLDIaoSwyRdTxC9AvPZiwnd2XUrLx4oJSXvp6jk=;
 b=fKuOIdL0B3VInVFxJXL4UBUp15fBMPyQvoNZkISkqmSrBiBJPsjnGXWeSXCAprNXiYwqe18/Dd51m98XzaFKHBpW3iXAvdKzHZw31OqO2KRPOZbun0l/tL/s5lYL7aYdpFbMhKlDYxHuioYAlnVAIQACv2E29uT7wyrYgkrBNsTifczq5O6EVDtHzdE7d1eXSLSrr0AKfuyRcjtOgKDNj/6/0xjeBEdocaxhuF3Zdntym7ARb6XLvHRNnM/mn1nZQMNedU+rt+Nd9w/v3Am1ECZ8jWGsFL/Q4i0dLVI2PBh9CNHxbEy+Zy454GIFi4h5uHAgV5lGxb3eT0JN8tScEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9446.eurprd04.prod.outlook.com (2603:10a6:102:2b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Thu, 13 Jan
 2022 09:29:29 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%5]) with mapi id 15.20.4867.011; Thu, 13 Jan 2022
 09:29:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 2/5] selftests: mptcp: new approach of getting ID
Date: Thu, 13 Jan 2022 17:29:03 +0800
Message-ID: <b391d564951de2b38a2390a49861e6bcad048bcf.1642065488.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642065488.git.geliang.tang@suse.com>
References: <cover.1642065488.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:202:2e::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e87076d1-5a48-49d1-69b8-08d9d677327c
X-MS-TrafficTypeDiagnostic: PAXPR04MB9446:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB944615E3C4FD864161271A60F8539@PAXPR04MB9446.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aNBjNhyaobbW0H6xROsgJEHZzOt8hPxcg27rOyPM6plcmFe9RVxKsHqfSR9z2eDseC7TJFJTVbzw9mFzAu9vUZhCz1Srzna6PeGCEMt8aPiJY2v9icie9QWxbwxfABgFfLVtwxXTtjGddqCmJAMZbYgwnAjpbJ9zJdwEvkT5Bj3u0n1ed7NJYJzc3KJMyFyZy/6fjk3suHzS5vz5NV2gYWpMFobXnJHwH9r1AV3mA90dU0DKGJ7oZBLGR/0ONnj/EbKMaintadXKuA4c5Y9xze+L9AL5VgR/NV6QuWw427VJ9/pS0zbv1wxta7GRxiZyrbTCLK6d79ParphCQGXYIPdelqWAkCSCNR4BClkLdS68PNmM5BK6BEQcZTGyN8er390ulPGMbCpteqS7Cf0sdGbmxKnV6hHlOjwoL2ahfdQDjDhExQByycVGPz6XV5bJr7g11caQn1nn0zhJY3vCeoP9Wj2MKk+PgN3xHok/5wjN9ZW2Wf+xhdEFSfGZmemBiYvXm2NON8vbesMR6H2h+OaVBuuo65SAN2p49mRNMJYFPMagGx+TqicaPFRj/LNNK7CvEEkNxr4zpPz9kMeXY0iUnChqTv3KeiRMHH/nT9hEFSTBYS1aJnjyMpUXHX63YpX2MrkI9DVBa3fr3XjqCA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(508600001)(83380400001)(26005)(38100700002)(86362001)(6666004)(55236004)(2616005)(186003)(66476007)(316002)(66946007)(44832011)(6506007)(36756003)(8676002)(107886003)(8936002)(6512007)(2906002)(66556008)(5660300002)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gHNUVqfUcyDzC7OX0Ye8kTbaRORIQqnqeU0dcPCjIIKqWH8/ydri/6Kn5p1h?=
 =?us-ascii?Q?tmPmCN/A6tYIT/bt4whzQh0thfdZdRA+7EAAHkkWX/z6B+F4BunjIbVqr6O5?=
 =?us-ascii?Q?wkgz2O9UY59IOVltPxtlA4Wr51rD7/w/in8CVU/aFu6/GUp0FU8bxqN8pywN?=
 =?us-ascii?Q?XXEfuilKL3waNACKr6Pgztu7VwL/toz8KmkUv7fUIArgRMuUqv+GCM4vUZtY?=
 =?us-ascii?Q?3/i9pbk8bpaPekOGv5s6plqPsaAluucmuUdKQrydPnviU5GD9FheaSskK3Ri?=
 =?us-ascii?Q?eaPx/IO0EDKfH8opCl/3Xhi1iy91UYxh/EPZOf7xVqNvhXY3VeqRHq8Pu/dc?=
 =?us-ascii?Q?o859bLfDlZSHkU6zUFkPtWTafhB50tszBpxzxiXUz1NNoednhFdieA2Xiowy?=
 =?us-ascii?Q?Gk4au5GNaXO7txGNQuJSfcjzKnTraX02r51UWA32BIBZmgFc/AezswQhGMsw?=
 =?us-ascii?Q?zkfD3aAC7vnjZ85jiN22J9TtPneHGTSOxcaQEmrZRCzjk0zrGWEoR14fLzli?=
 =?us-ascii?Q?MqvxxFn4FuJgk233SwyLIh+Osjzi5SI7M+p8SCP4/BgpQR/UpECp+FplUnNq?=
 =?us-ascii?Q?kneyIeAjmDbMdYDEsfOxh5+/ja1SaLrk/dGL1HU6es4DGaBqc7YgUvZTplkS?=
 =?us-ascii?Q?63TLRPVi1XOhIkrxpOHDySDH5Nsh4K9XR/yowcCDdhl4XTQasLTJ9bIz1ulK?=
 =?us-ascii?Q?6j7F5AiIP1kmvVNlNCLH/NAeciC3hhffSzIsvZTfUJQJCx33tZa8DaYH0R5v?=
 =?us-ascii?Q?fMT1j9WxjAHdE9q5OrgQD7pjkLaUxIJrctRDjMIkRJjdM5R41c+UUh4LZI07?=
 =?us-ascii?Q?5iZzmTq4DFiTToG4ZGlD80lrCx1koYLqU7GlSyeQI2izBV+TlArXSFM2C56R?=
 =?us-ascii?Q?2k9EoixRlKpbMUFPImqs78d8SNk+2WkNII3KTvY1AqmYqXCUwXQZPj0/cuXh?=
 =?us-ascii?Q?LlmKV4B5NwijE2jZtK2M4dNjDRiYCU6u+JQZoMU0CwG8g07888N23LtZp9DQ?=
 =?us-ascii?Q?EubxOG/Y8L37AGfsYoVDl2wu+9MHL64sTeB0bUrfQdWtNSShig9S6VNJm9Ks?=
 =?us-ascii?Q?iAX9seLrpvHZbvIWZI+clumItQ5R6Ht80ii1uWth9dpFcS4cHhsMn6A7KzoB?=
 =?us-ascii?Q?TnDxrUQn6n5MJC+VgWBziTjvQ6rp0/prDbfgeJVYJKMqO1hIF571WidNVUNY?=
 =?us-ascii?Q?VBK4B9qMGj/yJUJaxs9B7ltcNBnPe0fr6+LoDd8has7/zYMcVEvqp6lNxwAV?=
 =?us-ascii?Q?drMXlPXes9JmyaZkuT6qa2vXUX+Qyk7RQ5wwxbcYc6P49ZI6YIHhr4lzWYOO?=
 =?us-ascii?Q?XkPIAUV4H/mx8Jf5le1grBUWqs3l6r8ysedbo6fO817pz9tg55318/V0HF57?=
 =?us-ascii?Q?1pdksx5ejGyvOHIXDnGAuEK+n95r6yk0b/w6Nv04T1DVY9Qi0Dhb7XCYP3gA?=
 =?us-ascii?Q?goqsY9JXt0nCIfkURia+8VsETNyEHLLAWRoFuiUTUJMD7lFO4Vzq6A6csuv0?=
 =?us-ascii?Q?wwDtF6qSYa51i0nErMiCyMYaLlmelQ5FBZENAqC9uGot2ZXi8+WRmqn+dwW4?=
 =?us-ascii?Q?3prhvrT2ALH5juSZOE91sDqNGW4pnQnb97BFRIVaaR29cPLd/JJJG8b73cDu?=
 =?us-ascii?Q?Hf4VlHl/nnChBIdyQNQAhdQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e87076d1-5a48-49d1-69b8-08d9d677327c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 09:29:28.9070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XN1VBFeJ9a8/leX068MhIzsuAs9/RI2QrzEnTeCs/W5XvaiyWLzczPVOIwPhB9Oguh9o1JgpbTuZ66h1GCWzTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9446

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
index e6492347d75d..a2d5cafb2174 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -472,20 +472,25 @@ do_transfer()
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
@@ -520,21 +525,27 @@ do_transfer()
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

