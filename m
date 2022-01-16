Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F1529CA
	for <mptcp@lists.linux.dev>; Sun, 16 Jan 2022 07:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1642317740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H8VXaxYWzOUDYpedswqDdMK/Mg1nGv1SMeTR7HN9kwQ=;
	b=gOYABSz5EvFhrk20lD+BfdBvDkkqz6cbxa0ArFxAYX8eYZ5NuAwAJ0/ooz53ja01119edZ
	t4Q3jc2UZZ74Blgri591v8HuZGm0r7/NDH5ziLUrxj8d+IgCFLhFSXHuDJ5Wkvxatz5b8P
	agjhbTHcGxOCkWCpwdBWpfmU60wVc9U=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2054.outbound.protection.outlook.com [104.47.4.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-RdFYllqAMdOl2u9x0V5KCQ-2; Sun, 16 Jan 2022 08:22:19 +0100
X-MC-Unique: RdFYllqAMdOl2u9x0V5KCQ-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hn2qTVfyjA6dTnNIyckjq8GBswpbj32FV5Y7IXJxlqDTOPl4IJvcrQUvWsf9ilCagRpd+Nocw6MQLRbOg1W+JzMB1Yo3tZYkZ3Gee7Li8UFc5rqoK4Uw40Mf7vNdXE1Zvoq/rwZq/pQf3Y4iEjW8jGudMRDpA80uxOahSUNtTkZ2hPkVWA4hVPL0KVVI+PC3tbbZgTy0QN86ZoSAVo3peGomSHyIPTy47nU5Qw3PsRMWfTp9nJvmpTgLkHfZtto9wqEiUgAIhYXrnHn9BJdfhTDNlUqYooiCOyoBpxUs4xAnTVBdQQ92Oa5o5GntbbqQY4iH7IImZdWoeNO/D/qaaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUE0jK70R+3qJZBR8NwWYqH8AUIG1TjJVGswBGFyqkg=;
 b=JQWy8/b4gPgowpgoqc9u6KxiuopqTl4O1hBbjTm9GoWtFwQGPu4mqTOfEer7PDp8PVWzJROptavJoTqDrIiIsWKYoOjVyQsm73DhOhSHUnyuw5oYzv8m8CqB7oUGdUm1ciZs/R0kFMyySu95itRb/S+xDzy+ktp52M3QYhPHt1SyE3O2Lrz3nlqoX+6JIkRHtHs+mr9kVa7wBrtvlwU8GKo9asbzQkS0xlndM6g/t9rAmoJ+bLN25f6Mj8k7T+Ts7Zap32jsNlz28+kJeTSKfw88zBCmQcQjaIPjrPyjxDBysBmXzx9+TbTnByX/9yIxhFwwF4/6U0Iru4p7VY0UbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6467.eurprd04.prod.outlook.com (2603:10a6:208:16c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Sun, 16 Jan
 2022 07:22:18 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3837:57a2:45dc:e879]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3837:57a2:45dc:e879%3]) with mapi id 15.20.4888.013; Sun, 16 Jan 2022
 07:22:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2] selftests: mptcp: add invert check in check_transfer
Date: Sun, 16 Jan 2022 15:22:15 +0800
Message-ID: <43bc1675461051df68f3ffc09d4f309b7c0ba4b6.1642317523.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0055.apcprd04.prod.outlook.com
 (2603:1096:202:14::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fe09217-6588-44ae-e72a-08d9d8c0ed5d
X-MS-TrafficTypeDiagnostic: AM0PR04MB6467:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB6467C7F10C5B960CA14CA5F5F8569@AM0PR04MB6467.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DAtT0TzP52+GjZKyO+JhU+x4CmCfIqwpa10rw32LzZzlpc5T+tf4FWwOytpqgTVxi/OseACfbrWpdeLV78oIE9yYLco2U+NDDMBki2JHY3XrOAoqEPJTdkCWBVqbi/O/HYvNLRQS487V1WSmCw3h/P/WSpnp4WbMoqoku+lZ+qHHeFGgUkhcOK5dlg2Xh30QLH92/WjcYk8suvCWw4LRj98Ir3XcBT7BAZ7SC7H/eVlXU7jLkrz3zwdoeyChPQGH5a0+fpfNu5jcS1Dp5kVUbeusWIIcKWxygHjVKnymy1yz2yuKelTriXbNFcXi20GQ10YedaQZI4Gdo/AtK7k7cmb8S9SgxGYANrExkb9JmdkReeJFps4lAnNSBQF7PyJD8lCW2BOhKWyEQH82xriEvcZfMYFeUep6KO3p83P07ySn4QSBRXiQslT1G4cxrnAy9WfzLr5J1MfNCJYtGv9pAX+OxXg4LcKmUzXk0IH13KL8AtmkfChbjY8GeRrEIglwiYfhzaRQa+6fF13kox/1I79Up54p12IxIhhRH4mKk4w3Ja56m2K68eSmKQys6LCKbVtlDaw3RF9MT6Srf9yvLBaeST/W8dLLZoDlvdB+dZPalxMDCbb5Lyfjsk8ZVnWG8cBf/y2KT8ut08eQtnDiklYyVlGmcs4gt1mq98M09mgGZf2PcX/czZeV/RPwc6B4NyZTJN6yOBDwquWRReAnoQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(83380400001)(2906002)(6506007)(6916009)(6486002)(8936002)(8676002)(508600001)(86362001)(4326008)(66946007)(66476007)(5660300002)(66556008)(38100700002)(26005)(2616005)(316002)(107886003)(36756003)(19627235002)(6512007)(186003)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IPbBzyzBIC+5ngscL01gvjpm5uKYGsRm38snXaiKvR/msG1GEQT8sOdF5wUn?=
 =?us-ascii?Q?Zs7TBozfj+MyRrZTn383znRKs89Dm/Ioov+LIdCFzxxY7pM5GNjhYf0iuYIm?=
 =?us-ascii?Q?m62oIjUcERWblogGg//eYqF/rZSdNXIx+lgA7CMQAo1viG3OLJER6IE+YkWN?=
 =?us-ascii?Q?eAHu0D3u9lkPTwVGm5HW4UqIWP1J5l+XG4AUhVavT6RUmlLq6eXMyC3yUGzD?=
 =?us-ascii?Q?SY4JZ1D/YhmctfnjVFmWOkc0IwZb8VHUhz4XBYbZFwY/1pipVf6BX/nzBWGC?=
 =?us-ascii?Q?UGzIDM+msSn/1GrC6uGTY+Ayi84qJMVCZ5UNyeS/4MVt+Srh8sQKfL0ixTXa?=
 =?us-ascii?Q?ItRbEcan7DUDFLz3LFn6CU0eqXMZOzd1bJHLFnTM72dXWr2AH2ayvd9K+7O2?=
 =?us-ascii?Q?MzKH9+0huOEy8UdqWT81eCPanENOopQgN4rgrJqXjPhSaHN0laloj7Yo9bf4?=
 =?us-ascii?Q?edHkMAQVsL2FOnntPbqrncckfedFENseOJcTQ+5AYEKhKy/6N24yCz9ZoEko?=
 =?us-ascii?Q?sJmtEEFtGdrLoso4Sw2YjRDLgQ5GI+5CbcGZ/7O7m8Ok5znad3TaYHepdPXc?=
 =?us-ascii?Q?vRAi348YAaPj9w1RNwJ5MQXhhpsiFiaW2oS9MMbHzlIQNIaT/Tm2s0OtEXzB?=
 =?us-ascii?Q?fTUtk96ivkkJXdoPQZPb9gLeL1ebh9O/c4lgYJuh1Fih4VUxgzkH9BMx6HNX?=
 =?us-ascii?Q?rPTz5OM5nBtz3e9uHFYHk5/TS6r6SI2y+tr39ZZ8HWXXfF5BvD7Y/4oDx3S+?=
 =?us-ascii?Q?el6Ab1eCxU7tNVe6LCsq8aRddoplSXNy0yTvH12xGeFLS9KVUMYu4gz9aJFX?=
 =?us-ascii?Q?Baahg5mFLw4OtWUEjoabv8BbodBRJ7nGEKgM46zHqlcz6oaC+aph93vpIlro?=
 =?us-ascii?Q?zbi46vc7N4POEnClParCMU2A8QHSrurLZVyi6SUDlIVlqf90b5eMwfL3JZws?=
 =?us-ascii?Q?OSFSr5HZNvr5qdFcOMlBfDQXi+u1Z0SWfxZcLDj8D9j+hNTWZMFvr/kTM+b9?=
 =?us-ascii?Q?ZyPa+IYYbgGbhRbis4BaY6BulXHLe9HPFonexze/j4L2rDyeHDNFeaeX/78B?=
 =?us-ascii?Q?/AX4zPUDm9oY9SdOT//mO6cyvz7/jXJPKSEkEjW6v8yQf0yUqJJ1EJVeLXKn?=
 =?us-ascii?Q?weCnvakamFtbTPPSkXvG9l8uhpNogntmP01AulhsVU1vfYjR8icLHsFy6LLG?=
 =?us-ascii?Q?xR9t2t22a4598fuqtzLgcTG/hBDdz0unCPuEeY6l05QgXzE0pPvofw6zb7T0?=
 =?us-ascii?Q?cv8VczsEdoWHVnmQxanINubOrIZAxuMX+WRBhwfW2B4ubdurH9fUygcnmj3Z?=
 =?us-ascii?Q?kOjohOWcqzH4+xPQ7J9RigXTM54FXlH79aIrjU0xbHSt4SkmosQhaM3caTXX?=
 =?us-ascii?Q?ycThQTBHXQ8etFGcSthBhFUPcmzV+/2Hf6oMdxE4v6qsP00DhcTKvtI7lI+S?=
 =?us-ascii?Q?vQo+orxW8xA1+h8ECTHs7gy4xSfsODRF88pssrMtk5r/4AEHk8dWV9l++f9N?=
 =?us-ascii?Q?UHKYoErie5Dk2DjiySYEoukv4AfsrMkUcIC8y48ii9c8rwZyu5/nkXbwTWJr?=
 =?us-ascii?Q?U6o5VEONo6PKXHzSHt6cxv+Jd+XojLbNBMFE01RgAFIzswvpvPQ28P1Gt2PT?=
 =?us-ascii?Q?INQa9zMH9Lo++ya9qGJwjkE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe09217-6588-44ae-e72a-08d9d8c0ed5d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2022 07:22:18.1841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iq5Czk1ynlr3I+IjQSORaP2+XvwzpqMVwXepHR9w8fI1/Q2CmpYibdI0+LryUpD4y4hOVMSSQ7Mj0EttHL5t8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6467

This patch added the invert bytes check for the output data in
check_transfer().

Instead of the file mismatch error:

  [ FAIL ] file received by server does not match (in, out):
  -rw------- 1 root root 45643832 Jan 16 15:04 /tmp/tmp.9xpM6Paivv
  Trailing bytes are:
  MPTCP_TEST_FILE_END_MARKER
  -rw------- 1 root root 45643832 Jan 16 15:04 /tmp/tmp.wnz1Yp4u7Z
  Trailing bytes are:
  MPTCP_TEST_FILE_END_MARKER

Print out the inverted bytes like this:

  file received by server has inverted bytes at 7454789 (in, out)
  file received by server has inverted bytes at 7454790 (in, out)
  file received by server has inverted bytes at 7454791 (in, out)
  file received by server has inverted bytes at 7454792 (in, out)

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 v2:
 - instead of adding a new function is_invert, add the invert bytes
   check in check_transfer().
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 23 ++++++++++++-------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 2be3cad4b52b..de6589d1c541 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -193,15 +193,22 @@ check_transfer()
 	out=3D$2
 	what=3D$3
=20
-	cmp "$in" "$out" > /dev/null 2>&1
-	if [ $? -ne 0 ] ;then
-		echo "[ FAIL ] $what does not match (in, out):"
-		print_file_err "$in"
-		print_file_err "$out"
-		ret=3D1
+	cmp -l "$in" "$out" | while read line; do
+		local arr=3D($line)
+
+		let sum=3D${arr[1]}+${arr[2]}
+		# Octal 377 is 0xFF
+		if [ $sum -ne 377 ]; then
+			echo "[ FAIL ] $what does not match (in, out):"
+			print_file_err "$in"
+			print_file_err "$out"
+			ret=3D1
=20
-		return 1
-	fi
+			return 1
+		else
+			echo "$what has inverted bytes at ${arr[0]} (in, out)"
+		fi
+	done
=20
 	return 0
 }
--=20
2.31.1

