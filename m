Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BFE168
	for <mptcp@lists.linux.dev>; Sat, 15 Jan 2022 15:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642261640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=D5dRcJmrRD8EF097A4eUO1xyeEdZMcEwbi8w2up0+rQ=;
	b=cAYhi9tnHq6nZ/bNbZe0bMsb3EjkTNcM50owiSrnJ4zpv3EWZQAnlPd5qgqwcVMwnT0Fsb
	bA6qa+poC7W7WfpPd7gDiUQafot7uNylqgaZddfYbblBMTod+CUKg6z2gD9DJZb6g/17Cs
	o6VWBqFVhzMPAjMy/Z1yHgOqMihVtLA=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2057.outbound.protection.outlook.com [104.47.4.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-1WP4zcY_M7yfs53zQsW5pg-1; Sat, 15 Jan 2022 16:47:19 +0100
X-MC-Unique: 1WP4zcY_M7yfs53zQsW5pg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEheg49y0xErXmrN5xifQHllhidbvrg4P9BTxt7Oltgf6QmqOv8LlybH6kKZIwPolDx6zcqq+H+HC8m/Nq64ZxnksbU4SVcpauMQ9QlLuJLTi9SdKuzXC76EN4wPlT0zth+CfjVvXCalVFgEpvL5y6DYey1JztbptTE1Vh9PRVZfzcgbYkvfnW4sK3UrvShrgGjwo7g/rbZXAtZQz+TdklXcBjYOA33spIjNzFd/8A8+ykBqUWQVhiTGp7NJlnOfrVn7hBvOllDCiBOWiwhVBXOXPg6INSVRQ19E7bWRSJnrnzz2N0ZyUdGuclhfWH3VmTSmz164ONqDSeZOhfctZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0R95RABht5NWN7zhw8tj+J8WrfIol+UWuWHiABcXagA=;
 b=Rl5+ZBykktwkcuEkY4iUlkO/OKL98gnSgq9fjtJTjGceDLDDgoxPl5fcpZc5tvX53ickIya8XQsQP5UFgLlbSG98bHTT+z+KroXuCsyJyqiDvuBOjzFTD265IOY82AFtKFD3Sjp2HjIey6ToPO61mzO92wYozs36S87Q1rePf+lLpXVVe2cV0YukKUzoWf3HBk0lxrj1kmcuxXxXfjm2GC00WA/nlnovQpyzp+oGm6vA3F2bUPd0cG2oZPS+GKfsGpWPJsqzTrh2fcx2w0G1xI8JBkB5KyKGUE5jkG3n68gBJY50RJ5O7EZOx3NawThOGRxiz6CTkr3w2qg2wPK/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB2761.eurprd04.prod.outlook.com (2603:10a6:3:e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Sat, 15 Jan
 2022 15:47:16 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3837:57a2:45dc:e879]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3837:57a2:45dc:e879%3]) with mapi id 15.20.4888.012; Sat, 15 Jan 2022
 15:47:16 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] selftests: mptcp: implement is_invert
Date: Sat, 15 Jan 2022 23:47:13 +0800
Message-ID: <821a371e8b3abd990a426eeabe244113a88bbb14.1642261584.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0150.apcprd02.prod.outlook.com
 (2603:1096:202:16::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4aa14752-1caf-4883-7ae2-08d9d83e4e28
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2761:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB276155B2A7648E03FE7240D2F8559@HE1PR0402MB2761.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hc5vzu7q0/cSx0RHNaBmkN5YnDunRyb9BOSCORq06tFkvouI54Rr+kUBdb3vyKb4YY9OMFhQcEj2GFLRZdigTHUqrQqHmU5izJdry5Vo3URbvVRUBUjy5FG4PZlRS93RJ4tmO/JeBf90OczEImDFdN5xf+CkeIwHI4GgscuDG4q0Sz2yebQiTW9/x2T0RISAtTuOOvEvj6gkNQxuEU9Kk5SwrEBCrM3pEEs0WsFE/x6sx01hGZWYmeOzoSP5Ie80GClgIOBKLS7+d8zNSTlaDrtPLSKdZJtPkB0SjBthmV+JyEEAn+JI1SQVHkU6iGUImmZSQzzXXT4gXUbvlVDb1uXG9Ea/1YwlM+3mn2wJvqKocYcvIqZs5bHACNoU3Oaw0p0Ulm8MH2xQSPvgX+cHpdBP6xp/y3TTnjMTXG4kPot4nmyWXe4lyoa6wBnb3JYUoEoqaqzJGSklXwK+/hXM/hpy2R3HB+y2LFbZ9/TOEHcHDJYMf6LZkZxLsYqq8upv3dm547hCBHZsd5e+fEBKAu2rcr4qkmFTCh5a4TB+9f7aJxig6YV6qkO0NtU/v/V6cIqXSfrkMX+CY/UshTicSLEk++pCTJUfUZWJjkEFuX5AYicghaSfkKrklvGVmGh7UyDf5zZqn9bK140L1Lu1xQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(86362001)(66476007)(66556008)(6916009)(316002)(6506007)(186003)(6666004)(2616005)(8936002)(44832011)(4326008)(36756003)(38100700002)(5660300002)(6512007)(6486002)(66946007)(107886003)(2906002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/esKIz8Vw7tZpTQ9aNPd/XDDDcaRdsUKeoMvEgabvuOhrnhei1Hr7fgygF3J?=
 =?us-ascii?Q?jysju0P6qbbeLZx87mbWAh8/doxtm5FOrYrv7JhO86SMpjUJ/mcdrMoIeI9K?=
 =?us-ascii?Q?i3d0OD15178OSQWAnnXm+Yu34XwwvKTlM8GVJT/eU7MHKucLtlfPEaMPNUNt?=
 =?us-ascii?Q?F1ZpRdy7/c99/s+qzAfLk6F3s/IzSMnoOvcWQ7uPW2bJcN3jJejjWH8wDlBs?=
 =?us-ascii?Q?+F3znqcA54xS27f5MgvPvIDiqQVHgdERO49BIeYw4Bru0uHeUHzP3mYQ8pbq?=
 =?us-ascii?Q?sJJRvJNwNeTBgpvV6w+FXZEDknpof/OXMMdiU5Np0ilcOA+EQeyfGdmhdkPt?=
 =?us-ascii?Q?OPS3amBrzNXxQfZA+jK0bxD59xH9xF/XjrxXg+QUFZxeSTfLlCeqFQF6f0s0?=
 =?us-ascii?Q?e1ibb30sS53ifF3J5XY3IKOSN4W94jV4PKI8OeAAW7q0G2+Eb9mBjBRBTjJ1?=
 =?us-ascii?Q?4S3Imy8s/HcBNsG/Juej4AR9IIfrodJByXRdoSwv3CZoivx2aWqtaryqvqUT?=
 =?us-ascii?Q?coT6j2TmroAkJSRZbTQsaYtpgs+w6f9vQXxP6ioifnlln7XoMmm6gjY4Gude?=
 =?us-ascii?Q?p6bGdgXhK3unM2jrE5+wN0W2Ul1ZwhwFoveZCYlVfihdau3DDnVPVyijb5nV?=
 =?us-ascii?Q?38xvcVuBXfZ+R/xN7s/Y3PCrGZ/Yv+fVa4QStF7P+FFhyLcQDwrHzaczX/T2?=
 =?us-ascii?Q?yFBC7/Fdp91oILFYN1bv6nahzCYM3WqZlZQ9WQT24JPH9cRpGubZLh4WNe4t?=
 =?us-ascii?Q?UULa58zudvSKz2uteNo9fU0fC8/A8QOfQvEi7Ijt4yFl7VchyVXvcrbJRRPL?=
 =?us-ascii?Q?UrrBxWS8NSHnAZxkjjeFfC9/kMFE0MV+ZQLSQdrfbBgXxLTZfC/pPEVAHYzp?=
 =?us-ascii?Q?SYy5RHroN9thwpvHelT7/PJTrzhqjCVUzkU7Meiz4Z0rMHUwq3VlZLdHi84l?=
 =?us-ascii?Q?dcpLST8dIdQx+ormPlw/opH1+VSsftmrs73N5q9NGn8JEacAGp9r0+V2mMfs?=
 =?us-ascii?Q?ObON5YFmB2HxWquX7Ba/MHdiuqHikfsWraH8J+oqscxdoAJckTYlg5FHUdXk?=
 =?us-ascii?Q?/ZHf0aOab0itjkHi44PjPFpjLGN2SEwqZtGVMqUqCxeRIkg6C6LUYOtD+jWl?=
 =?us-ascii?Q?xQCQHPMc+qpYq/tfMj3Uzq3JcxBLBPSTQp79CVX4UThK0AIa2YYVDvYZoALm?=
 =?us-ascii?Q?Qnq6yaCPU2UcQJOyFo+dGvZCzQXamOGyeLgTxq9M71uuuuH3nrHXTRG4v8gN?=
 =?us-ascii?Q?EXVMhsCJm1gBmPw4EmHiBG1m+9L1WicMrjiBKqTdZFty1gypYh0aWbMMZCsQ?=
 =?us-ascii?Q?/itrc3h/JqcYo/BZdvPKrJ+tk1AfMCJ8m5bCQIm9bcxZL38gzsdqsv6u1N3i?=
 =?us-ascii?Q?5d+jIEU4wJCRwInl8BEy2emI5pJ3kg+yhF8VbHLSJrhvDkqv+G7jiGSZZ/59?=
 =?us-ascii?Q?NZTHvFbih/8ieFtKqtN8sHolCsd4a61Jyn+hAwan673sekgawqOClc4lXd8Q?=
 =?us-ascii?Q?lWEIadGk4awkrNnEc0Qgb8WJODxjv9dG3cvaPCYpSaIsLa3owg4MMHPsQGN5?=
 =?us-ascii?Q?zCExGVK2hfsaF2Cg1giWGceYFKGIuRy2M0/HvpZir52du8emvbIFjJHNM2P6?=
 =?us-ascii?Q?h17d4H/KmyiOldqAwAr9vDKrJUwCBzZYzuIPDyDG91ha079SIUM4WOh78eFF?=
 =?us-ascii?Q?MiSWOBooMa9GUxS14YfPZl9AnBk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa14752-1caf-4883-7ae2-08d9d83e4e28
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2022 15:47:16.2670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b7HgSLWTw629NcXNJu/k4rw5mKJvn6OKCSdHA2tVMyZrhhhwaEfUqHLFgRjsxI8pPBQULYiRGbvrGUo9gs7r1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2761

This patch implemented a new function is_invert() to check whether
the output data has the inverted bytes of the input.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 2be3cad4b52b..b0e4c5be9d38 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -180,6 +180,22 @@ if [ $? -ne 0 ];then
 	exit $ksft_skip
 fi
=20
+is_invert()
+{
+	in=3D$1
+	out=3D$2
+
+	cmp -l "$in" "$out" | while read line; do
+		local arr=3D($line)
+
+		let sum=3D${arr[1]}+${arr[2]}
+		# Octal 377 is 0xFF
+		if [ $sum -ne 377 ]; then
+			return 1
+		fi
+	done
+}
+
 print_file_err()
 {
 	ls -l "$1" 1>&2
@@ -195,6 +211,11 @@ check_transfer()
=20
 	cmp "$in" "$out" > /dev/null 2>&1
 	if [ $? -ne 0 ] ;then
+		is_invert "$in" "$out"
+		if [ $? -eq 0 ]; then
+			echo "[ FAIL ] $what has inverted bytes (in, out)"
+			return 0
+		fi
 		echo "[ FAIL ] $what does not match (in, out):"
 		print_file_err "$in"
 		print_file_err "$out"
--=20
2.31.1

