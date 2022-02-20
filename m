Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2040928E2
	for <mptcp@lists.linux.dev>; Sun, 20 Feb 2022 03:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645326040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eDFf38yVs+fnroJ77VArdIC6sq7WdXiKn3HvTmjPgG4=;
	b=bVPbZbIaXlkeZGBTVny7DP2ZVThveC8Jl1yntNcOlXm78o0FBhpC3P1+jshdBPArZT4TlU
	afkJA1dgVi25uwc2qxCoHfbCYwSYZY1O9hRD7Q+xY5BTsfwc4ardEtHEQcATrNPzvzs5d/
	Jj4muww7AeTBOgiqvkkcYujkJ+WeXBE=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2050.outbound.protection.outlook.com [104.47.5.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-25-KCZw3B18MKabxGvu0Bm0Xg-1; Sun, 20 Feb 2022 04:00:39 +0100
X-MC-Unique: KCZw3B18MKabxGvu0Bm0Xg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSJUupXaEBSpIJLwBa6M8cC42MJdrxosoJbwTUsaWJEnrPGlqhol1A8JuZqrUVNfojuW9H+/bp1fMojy4ZdHnEYL6Zx//4c0nfpr0EED8VMVdpwJJkGNWYXxRLfvRkGHPcGQWGuWhZRb2hbupg+kG5fp0HH4TH7vT6B9NxWvkPz5nUqHF4bgYh8+q5y5D6C8QzU1QY21aa7LK0qXOFx5xrWhIMkIksLIt6LuTFKhr8incFgktQxf1iBERBI3l6sIicXaz2cFGcVhd1fN8KWy7HkTvyoISYc1CE8v/DN+gn5zDRXEp00LUWySEliPNJgxGmM/J83H8LNQhfp3GvG9Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbzQJ4MMOd0a2SJ2/9lDPQFtYW0Nl50iulAsByUFh6A=;
 b=ILLtisOWzu7/e7yhqO83f5aOMxyYUwRu8uUK8SzDzbAXnmSYX1jUtCvVk+jbuZrJo8FQ5Rs1zi7u8qRKy0FECjuQ7XFyUBTKgvcZIyHdyO+kvvveW+2KnleXpqKgLr4Y14BnbjE0UUMsg8LD4HCbGBnZ4wg67KeV/2KYgEmjGQYhpc1492BaEyj809Nlcz7wkPF0b97I6KsXfttCy9zpq6+mbdCdr1qhdxWIPBf5vN32RFHDoNB/xk3nwCWPjVd6f8nHc1zR05WFQjLUzlXnQ+RgtVcDQNlnrFc9NBTP4z9fPtYHTT56/CE2n4EzpM+TBExwod4cYvY0dU2/oBHKQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3414.eurprd04.prod.outlook.com (2603:10a6:209:3::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Sun, 20 Feb
 2022 03:00:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sun, 20 Feb 2022
 03:00:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH RESEND mptcp-next v2 12/12] selftests: mptcp: update output info of chk_rm_nr
Date: Sun, 20 Feb 2022 10:59:38 +0800
Message-ID: <4f53046d92965c794bab7a611997e40ef225b21a.1645325178.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645325178.git.geliang.tang@suse.com>
References: <cover.1645325178.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0044.apcprd04.prod.outlook.com
 (2603:1096:202:14::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6ff2ff6-183b-41f2-8b76-08d9f41d2c3c
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3414:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB34149F24F3120B7A5BBA6D3FF8399@AM6PR0402MB3414.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1eJ5fwwPxHQPTe9oBqKqWW6sAA8Ui9JMq4akreBMn+si9l2iANIULsvV+Bx3uJo3FAEJd/iJzMBi2RxVPp2aQS8hdteuGqLYZgM3tHgt8iPwwa6+LOGd5o6ob2W2696xOIGlNi7seb3Qc4+uHd/PrphUX0z0jPj1SS77VPOEetsxHWMarcDWaBwNlAnfcPCm9Vn8D5eji7WZo5yyT0VjFGoKulfP4ugkkQ+6zQjZhkziUsNjMP1fFHl0NfgcVeHAqxz2ch5Jyxv70ehqoVjXVYRjtzp3IMwQfg1PToQOfiYl146xErqxh15/kbEj/xCA4Z5Y3mp4UBDnT3Bj2UZKflXu8aHYWGRZBM37aSznzZBEj9iuqxabXyC24hBTyilTntvWAY+/wtfbBTVE33lanm6Picr5X09ou54PoC6sYajcWiHhiW60kpxfRg1+Bh09SJMlqNXx/KUjdr0I+tgcubDRWScMIKBPNIUiRAETgpIZKUQJSawreGF3b6Pts9WPH70k4ipZLek8c/2VuNhDFj13P4RM0YXN59ig/quemH5nQbRoXYHJIEbTfV39m66bncYGYmX8v7099o8Tl+49HQF261b19KZpeGIwfn4Exhq2YCwzbSBgh5cRqpXTnswaDQX98fEl3mzcDQNK8vWU9A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(38100700002)(2616005)(36756003)(2906002)(5660300002)(15650500001)(44832011)(8936002)(6486002)(508600001)(66946007)(4326008)(66476007)(66556008)(8676002)(6506007)(6512007)(83380400001)(86362001)(316002)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qaJHIcY4BE6cGo9QTw1hcV7NyAg8aybsadQNkzRA4iBJFZc+Sh+7+17gep8H?=
 =?us-ascii?Q?rSlMj/RQbOzEmQOUQsmjDByl6SM8clO0cvq1aBQMgYveg/5ZMX23vXtsOZ8D?=
 =?us-ascii?Q?QFzLdb+HhaSu7Ycan/dmYvjIFpb3UCd8QqAQi64lspCXJQ2P/JNLEwTHlaW0?=
 =?us-ascii?Q?t3f6EHSY6mUChRc6QwKZvhi6YFQUIqZf6af+5VpDcW1Jwmb7MOgiLmtQqlU8?=
 =?us-ascii?Q?tsxQrMldqqrKDoaHXVZZ9Us2DZSPCXPwhfdLLf0zJ4RxqsbP9rdM2b0VQTiJ?=
 =?us-ascii?Q?045PWsZgtTmRvrsN4K29ZAKCF1EDZlL79FlQykvhqiKGf+Peeff6IYdZfRjS?=
 =?us-ascii?Q?8zrqhyWw9sXyIafekn4+IeuyuljfaDQatW7a++3OQtu1XgF476Aiq2X02nTA?=
 =?us-ascii?Q?yhAc+19Y4XB9fcrf0rRMLrorBQLMuFBg6Hmi8s8UDw79LDFVVaCHOrJWq3NX?=
 =?us-ascii?Q?+9IVtNgY8k+ua46Ascc95NB4k75eesUjMWQ5QuK5Tz0GMPkFebbmG1rWHyVo?=
 =?us-ascii?Q?lzjACHH6RYC/OjRAeLi594wsXbkJ8S3OtCaTbR8Ol+M5A2rUYpVrP8ppNqNN?=
 =?us-ascii?Q?pYtbDLmzM/I1SNdbTTWmMgN8lTOaoOYQVVfpLrZIWV/TiieTZJs9jFLnY7mF?=
 =?us-ascii?Q?DJR9XEh7IY5SUxiur42UiLOaT8xht/xbKuLt7MG9DBZRb5kv4wjTK7s4nPdt?=
 =?us-ascii?Q?R7C6vmMUOdRKeE1/vAuexybLra5Ort8e0AqoTM/bwW39u/UqpXhxN2p/G9nq?=
 =?us-ascii?Q?Tq+0tPLyPPzA6rUW/bf9Dp5lJsaUh+M187kqVGLSNLEs/+jARGSas40UpDyj?=
 =?us-ascii?Q?7xiijxwruT7qF07GyUaazKc1qI36bDc9PT8ETgRj0XGT1EbVd/QH/A/o+MHj?=
 =?us-ascii?Q?JXAuMFn/Vq42tcGS4ifRk3Vllkgoz0Auv7QU+G7kQaUwBkfp9fd4HsZQYpNI?=
 =?us-ascii?Q?6fPC8p0U5UQeFHT1UVcWK3ewAfFC1mPshSVSFEoxqO63SI5FSxm6UULvnqGW?=
 =?us-ascii?Q?Bg2vHkMrJYt1qoNxGoVcY71QhVx4MXtizYU0wl/AkNtEacXD9Kiswlg5Utts?=
 =?us-ascii?Q?QfD8GyfltghbM1cNb8StaJYIGseBxj0ysq6AUWJnJmCxcg/llLePZi5TLBS8?=
 =?us-ascii?Q?E/+K+51NQrXksxdr3uOatDCL4YsOZvge7oVjNsuwxObt+HxpRm7oXKvyFLUm?=
 =?us-ascii?Q?k0T9bUJCDVSzk2yNHEMZ4tdwsZQV1cBs6+D7nRFdbha2kyNF5ephv8yImY7U?=
 =?us-ascii?Q?C2ZwFtRlAQcvPAwOOIuX80Zz5pWNiyn7bTtlET02HtOp/sPxRADD89szxxZR?=
 =?us-ascii?Q?sLUAJkHEJ/lDXHi1WejtQzWVysWQylFO6CgxHXGrSaXBJYOa3hc+6EBdQFdH?=
 =?us-ascii?Q?em6V2w1yaK8QZcVP9HMvJ00065l8f33XE5S24UrtgsREHOWPR4zxzNmCWr+x?=
 =?us-ascii?Q?oLOFABEMMPkhysVN3uXNs97Ul24JSGwjBzzCVMfdOrcBWyfem2pZEFdfqj8a?=
 =?us-ascii?Q?imLoGYgHWFwm6K5V1JfwMR/SwlSrTuvUjtJLk46+o1xw5MmFRSy1X9NIHFWl?=
 =?us-ascii?Q?Dmjm2ifDe5btyk/3rFnB+N2+I7B+gdoiT2O+a1FpaEdl4fArccZAD8xQKfMO?=
 =?us-ascii?Q?naZVur+0Y4XEDCnJJ90I6xu9gvAb+osrb6jwgmVVkn6vw8Lkj9VBleOmCSp+?=
 =?us-ascii?Q?OxeliitopAXdDcVj4EP86r+9k5s=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ff2ff6-183b-41f2-8b76-08d9f41d2c3c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2022 03:00:38.5842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K9frpNR7+6pH1VXX4Fx2szfz+z6SZMKF6acAcD5pNrBs96y5BnSGeHlsEs7eUweZQYd2CdcaMUvT3C9ZD0pgqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3414

This patch updated the output info of chk_rm_nr. Renamed 'sf' to 'rmsf',
which means 'remove subflow'. Added the display of whether the inverted
namespaces has been used to check the mib counters.

The new output looks like this:

 002 remove multiple subflows          syn[ ok ] - synack[ ok ] - ack[ ok ]
                                       rm [ ok ] - rmsf  [ ok ]
 003 remove single address             syn[ ok ] - synack[ ok ] - ack[ ok ]
                                       add[ ok ] - echo  [ ok ]
                                       rm [ ok ] - rmsf  [ ok ]   invert

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 6fb883971d46..3655911667e0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1312,15 +1312,14 @@ chk_rm_nr()
 	local invert=3D${3:-""}
 	local count
 	local dump_stats
-	local addr_ns
-	local subflow_ns
+	local addr_ns=3D$ns1
+	local subflow_ns=3D$ns2
+	local extra_msg=3D""
=20
-	if [ -z $invert ]; then
-		addr_ns=3D$ns1
-		subflow_ns=3D$ns2
-	elif [ $invert =3D "invert" ]; then
+	if [[ $invert =3D "invert" ]]; then
 		addr_ns=3D$ns2
 		subflow_ns=3D$ns1
+		extra_msg=3D"   invert"
 	fi
=20
 	printf "%-${nr_blank}s %s" " " "rm "
@@ -1334,7 +1333,7 @@ chk_rm_nr()
 		echo -n "[ ok ]"
 	fi
=20
-	echo -n " - sf    "
+	echo -n " - rmsf  "
 	count=3D`ip netns exec $subflow_ns nstat -as | grep MPTcpExtRmSubflow | a=
wk '{print $2}'`
 	[ -z "$count" ] && count=3D0
 	if [ "$count" !=3D "$rm_subflow_nr" ]; then
@@ -1342,10 +1341,12 @@ chk_rm_nr()
 		ret=3D1
 		dump_stats=3D1
 	else
-		echo "[ ok ]"
+		echo -n "[ ok ]"
 	fi
=20
 	[ "${dump_stats}" =3D 1 ] && dump_stats
+
+	echo "$extra_msg"
 }
=20
 chk_prio_nr()
--=20
2.34.1

