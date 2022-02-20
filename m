Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC77180
	for <mptcp@lists.linux.dev>; Sun, 20 Feb 2022 03:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645327050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ix9jbG2GO/3bBhbXmMBAvL0PSE5hwDB3gi82PYD6orE=;
	b=HDGOuOTs3R9XhUpyPCd9IgitYwa1JH6QZGhSezrPEz5TCVVdG4XU1oriuqdCoCQGAOC7Ui
	tCX47GHOcEjYBoew+Bag6aC+HaOtxHVYNAdHG6D7TChmsXpeUDBeQpici0zzaSuWW+j8GO
	iHSEiIjL8MS/WmkX2G+gk9fMjBhhWsA=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2053.outbound.protection.outlook.com [104.47.8.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-v8LpKDnHNGa6dDq-x9fkuw-1; Sun, 20 Feb 2022 04:17:29 +0100
X-MC-Unique: v8LpKDnHNGa6dDq-x9fkuw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjhKGpfizItVZkS5ikAc+P440Pj0r26kV5H/3VVdWjo3I3LyL9wk4FN/xwaE5iCzlVDJt0aVemic5vKrbUh9oo5ityV5NsSYr5Qa0Z7oZzrIUcEgYAMOgemALay+TfceNN0yCRyCudzKunV4JfYzU0T4KacGzkgUqy9i6vh6f+MNZlP7pEQHuZGAhYrnRjUJ+Hgjid3YCm4bNBNtSu0Tqsmfx2Zia52oE5n5GoGC/L0jWle1UgdW2lYU4CKh6ILuMZEIOatEygrZM7om1UrlNmgnaiHkWdwkT9+dk0oV6TqSODlUNHyu63+NJI6D22dHkqGJzPtEcCgRM1zg4j9NIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9W7Vuvzhol4J4BXXy4ejtGcgTQw/jZ0wCwzRL5+qvp8=;
 b=U7fkKwnG+DKfTViRltB3EBbj/Ntt4Pn1rEi2EgX2B9fYo96oBicvhAsKqFdeuSsUKNGwSE8L4WkklcOUtmv2f3Qc5+yB0821OMI2L+gpK6ws1Sgqyi7hqnJbweRE0sY50R9xgdS8Jr3L5Spmsdez5CuEJz4XIyfOnlCVdWFl/ZJBcwXKWpYCSPlTYISi80BY7ZxeBeeXvJYgoGZiGPtheOpYQpPBHgIGYNeDuqaJlQd31a1CQTAoasKfmufaTH+ClamMd9w1Flxvi9sC7q4KEnLC8xnnVBNCjBYlaKgEH0/+7u0cLH3xWbcDzl53/PwD6J8zh2NPeCysVDNqavJviA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3525.eurprd04.prod.outlook.com (2603:10a6:209:4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Sun, 20 Feb
 2022 03:17:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sun, 20 Feb 2022
 03:17:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: add implicit endpoint test case"
Date: Sun, 20 Feb 2022 11:17:58 +0800
Message-ID: <3ea291cb4de94c65127fb78200fe4a121d584748.1645326965.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0200.apcprd02.prod.outlook.com
 (2603:1096:201:20::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4577532-6eef-4295-3ac0-08d9f41f862f
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3525:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB3525895BAEC8BF73C78DF960F8399@AM6PR0402MB3525.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T/o+FrG3CQCPSdKi9HwZaKiSALC8UortKz2zX3p916zfhRntNJljnp9jJXcHovzq7K2iTbhcVMlc9YJz0VUxxNJ8etDLnQ0Q5SRwUpjhl7ulKb799qSBAkacX+yvoJG1aMeCvhLyX6kukZUX2Rw0c/74s6KRVHLEEO81DkaP4a/GSxvuN8HVud8bqlQbkbXUewMkiihpOMKFETd1J0a2lD9MKaJ7J/TtLGI8U8gCJA9lgAcvefdmq8i/u2pHCgSksO+nGUNikBRy1jf7pvo5JH64GlEEsju4N1vXZLyYw4fWgQzcmnyGSRVi3saKVe/jJRkaFh5wvtyOfanVf2r3A68RqQKRNqpBIOYgVEAQFeRgVUxCf3N8SwfF7yL7M6Or1a0+h+EiosyynXghtUSRqIjMsKDkBomj5gxi8p6JH9a4ncut3QA39yfJiHRyYlJyUBzHdZfJPkY6+DZ/9AnfkipayG4lTtxZYdnOfXA1kVo+F4eEr4oUwrj3tAatJ47Pc1EcxL6uE2Li4ocCgBSb49b0anXmXv++wQmlBwZnnAotam69tnQSed72lFV1sr2KLVtbzBtBYzcrevTp1v6ETjwVp+FkqCUH2xeOL3uF9Gl8gBGmwYRasqtpajlAz4RGDBT6lMplRDMPl2/kisn7Nw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4744005)(5660300002)(44832011)(6486002)(66946007)(66476007)(86362001)(4326008)(8676002)(66556008)(508600001)(107886003)(8936002)(2616005)(6916009)(38100700002)(186003)(6506007)(2906002)(6512007)(316002)(6666004)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RSg1KabO2Ep5lxv/DVFUMLWBcTm2Fsk57Dft3J85N16JabauLxR3J63KmvPI?=
 =?us-ascii?Q?QCt8mC3mOQWCRy461rQAjqOTaLLZqbWSv+EUbvFTOQJWt41jdCHl1ynJOJFQ?=
 =?us-ascii?Q?DJEYPBlTJ2+Hsh5I6q5zKfme8gSQJtBKZ+aB9bxX3oMk9byuxEt/SxEJwAf3?=
 =?us-ascii?Q?QWOAHaK3A6jqy5hOjKum8iqdnjbpY0ENP3moB4to7L0w7zhRCYMMN+pHfNR4?=
 =?us-ascii?Q?/Lx+fml6b+dhTK1ftX+gUgrwHb2ngfLuZndnl366Hv2krgZpJKaiFYuOiqYU?=
 =?us-ascii?Q?7PIa5UO+DVnEW51evF3zbL0j0NZgruJBPG5R5aPFgRHRzmqZKIuVtGBlwehI?=
 =?us-ascii?Q?TpbF/Ub4YpLg8yxrsZL9LDFJLW7N6Hfx8WFC93WgM22f3NkOxRJ1e+K3t1FK?=
 =?us-ascii?Q?DUw743rQDskdtdqELugMR8uaFIn4MTUgZl5q92FO4xO+NkeVHPgqkHzvnujC?=
 =?us-ascii?Q?O9oRhN/O/CHk/1+76Yjqu24H1nfrV/fNVuhN+8SIXC0Mn2mafJQNh8QOQ0ZV?=
 =?us-ascii?Q?2tM404I3ciNUsKdri6KVFkTLd36SDeI5LKQ5fomKBB1I3RtFs4xu8715NuZC?=
 =?us-ascii?Q?KDSgq3+tdJbksYG0tUyWkuAbRoFBwdCptJTucEasFkY2UJVPk+6CWlk1hq3U?=
 =?us-ascii?Q?uAQKzgUCCpw/bOCmLk+24T/vOntQ1FtJi4HdiKGC6Ya7vs49nZXntabmLSUE?=
 =?us-ascii?Q?gXXA4Ws6Uy3mjis8X9KbhMqp6DY3Zw42QlI+tCUmdPzWfeZd+Bp3UEmEuucU?=
 =?us-ascii?Q?+FcdqQkA/reGNBvLAplYIHCXhhLUu+mGaIsWQpbISV+tWiMRTgEtrJqElTZg?=
 =?us-ascii?Q?rpukoDt+c75TbkcGh7JOqyH92gAE6ndAdcuFZR5BkTyYGBXTuRt8KtXFq9Ke?=
 =?us-ascii?Q?AsWBjHWKCjOLC1PNWFZb69dbyJZEgY6VOzRDcea3+WEz5eXLNn460wDhbAwh?=
 =?us-ascii?Q?C5IdKX/R9oYNsAznHMJBRYTadfzkOH1Mp+JievmtmbNtFtsgBQnYPTeYr2JR?=
 =?us-ascii?Q?65oG90dEDxfHmm5ftUjQDAAbdcw4n05VUKMkNQ3A2qHxRJOZ2BZYVj6wxPBT?=
 =?us-ascii?Q?Ogw7dT6L5TNziWEg5U+A399TuSbM6cEv49H1nv+YHARPhpzsZkOBXQ0wbDoB?=
 =?us-ascii?Q?ut3XOO9Ode7kRDQF1k1vuwJNIvIjAZADezEJ3+UAawwlNJ1rEZigqggwgjfu?=
 =?us-ascii?Q?DuVwdzF6n0rfQtCW3jWNS5cXox/p+gMedaFstyGgkeB5hUZ9OuLJl4AEzNf2?=
 =?us-ascii?Q?/PTiYweTQlvhqNaewzz1Q1ByWd0L0NN1bcLLcD8Lv/rsRiVPkNPyuUMp/Nyc?=
 =?us-ascii?Q?fjbH09Pt3VLNaUYJj6svtR7m89DydMyQwIBCw90RK/z4xxhRfcbLNM/YYMgI?=
 =?us-ascii?Q?AdzueDrxicfwVEJPsYpSpn+q8Ep444LYUepRg8ViRekoqzRPHg7acNvQpwBL?=
 =?us-ascii?Q?MInN4zK06hE/2QFl2kI1fKhYmjCLA1yeT5LJ8IDW8ENqcXj3ju0MRMgG7Vuh?=
 =?us-ascii?Q?2MSr/ZoF1WcEn1w9+2YrY72V53kBC2OA12qr9bIUF52ukumh6VNAv15QWJwi?=
 =?us-ascii?Q?U5uPxyQzoYi+gVKXEF2koZZadRs15j2cBPdhIlSNAwa+olS0UmfUo+tn5e0H?=
 =?us-ascii?Q?Klwucaxcp17lXVXAl5jNnJqmV9i0lH6Osjaj5vaKEcY4lcZwZGKp2zGUY+j5?=
 =?us-ascii?Q?qohFUr67bNVCCIn7N38I+nzEaWA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4577532-6eef-4295-3ac0-08d9f41f862f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2022 03:17:28.2822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGeMc3GFP4RRD7Du2WFRUXD007gIgx5zuSq5ZDZFVSGiVtFjt4YLcPwxJErJtNXjv/Hw6BfpNzbVhHeh7npILQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3525

Use the newly defined nr_blank.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 3655911667e0..081f1bc78b0f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -481,7 +481,7 @@ pm_nl_check_endpoint()
 	local id
=20
 	TEST_COUNT=3D$((TEST_COUNT + 1))
-	printf "%03u %-40s" "$TEST_COUNT" "$msg"
+	printf "%03u %-${nr_blank}s" "$TEST_COUNT" "$msg"
=20
 	shift 3
 	while [ -n "$1" ]; do
--=20
2.34.1

