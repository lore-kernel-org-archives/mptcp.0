Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7875692
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 07:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZLsmgjA0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfF+CnN22OjS2xq7UtIxtdkHGKD4RzoSpRP2gVcl5cyXIFkl4C8Ha9ubskPtQQoyJxkeV134RG6Nz0QTtvxVwz2+JCd2M+a2khaJlU9oCj2cEssxJ3sMYMaDQJpQ+Ka6urm1ebF6kEIU7kZiX3CT0NLH8nF8RYHQfsy5DI3EnNK48vpdeefQiX7WD9YsIDETVfiFS3qcqG7DCtOjst9PSKAJpLLMxhfu71rF+vs3IOqclA6iEwVDamtAEX27Xm4ZB/XDbzt+F5npd0karNu0IyUejEzpaYlB2s5VEUDbRAA5UW/nsjN+RXhWyZPQacEUWRX2mixT+DwO5p9kbg7+wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zju0JsdDDZ8iaxZHujNRdJQwpDtizpEAQUxwxQ6vRNM=;
 b=WRh05haSHjMklwBbGDPDhcCMdZ5BgLOIXiPyt+GHQPFM2JeC2Ey23e0pP8pZKFUHwZVRy5VXQD/Vvy6HgKDh+IzycbS+723c2zrX/bZEA3U6Byflqblxx686XJdCFMbj2ptFjrnEaAtbqJK/Q1rmnJtnOOa8UvMbf+8bMgpSQkLo0MJeAwOrmn79wsJt0uimng6R7MT9AWeDTVe+BHrMHKN4F6hlq/ddf1Tu2WW3fUlxJ4wzd7eNJ6kfk/CAw+/Z6VYaXq1R0TL6rNMlIwOmhyvxTbnRRSEolIkRXaptIMMKiUxltzolMnZKmTw3pmZY7HI/7237o3F+H9t5Z2jwbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zju0JsdDDZ8iaxZHujNRdJQwpDtizpEAQUxwxQ6vRNM=;
 b=ZLsmgjA0YIhUHBvTjKTFMmOOng/+PEcpLuPr0NzBHCC0X2S9m61X4Tq8i/2NZ2/1Cmvwz8xJvnRx66XrcnOzAair1QGcIEKKC4jBaL5tU+2gk/JQ1AYNIkwpX3ghhryL30dD1TSm2SikK0oWzFy3t1Te6p16lHGNIS+/+rh5JsWsN9pGtJfPHABPQncqUHnOyTUuFXjtK0wA05o3S5Ht9wbDp+Wj5sRwbsticZmvh0qoKgqJVfoxxeVlRlxpvHSRP1gDcYnj7NzK5fSgXwgfeHW4/4GumkIeovxfPh2opRrJKulyhNXjAVnzQGJd8cHCrM2mpbkdki617ecKs9l59w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8566.eurprd04.prod.outlook.com (2603:10a6:10:2d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 07:43:49 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 07:43:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v4 4/7] selftests: mptcp: add missing oflag=append
Date: Fri, 13 Oct 2023 15:44:34 +0800
Message-Id: <546a444fcf38c964d65cfd5e0f98d45e07244f5c.1697182955.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697182955.git.geliang.tang@suse.com>
References: <cover.1697182955.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8566:EE_
X-MS-Office365-Filtering-Correlation-Id: 684a0300-b279-4e42-0d93-08dbcbc02289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ug+KPgnFThmdzRX3e2ZNBqhmQ77ycbNsyhef0GC8Ea9QnJ4P6l8/t1ByjPvSVghtN+0RARWu1XVxyGg3Hso0BRN2pNWXXwLZGViPrklvw/tC1DFWnT20AbHPshGQgTb7KH8iINwBjBMynmKc6gMhX0f/LqDDwwQKhxG5L9jOl86vQMNK8A1a59YXHg8ZLgpqQJFmFzRMs59i4xW+ynSBR06XU2hA1qE05wTI2B9J11pr/5l2gahwRgGbtHIyn24XqbCoNSodXPriHGggzh+gNzKHzbzBNIbqccDNiFzf+cyUNQ+ql0UIKsKlx9GzE46MhciAq3mX4+bFj+PnOSQKsWFFV+T+LwTJBR7N9YKOA0LpLZG9XqTE1JyHL735pSFsfh9WbgkTbIXsmV3ZOJ6J4jDjVjs7il42owszfILWPb+pQRCy6rWtCzdH/MpMprspb8KyoVFKZb08dfLUmpCZQBI4vTxXjm0SLuMMVKL00Lpcn4qB8o45Kr2W3MtHWAP9EFuI+m3FDLLBNxXvyXMaj/BCCweM6NeSfLjnw2aBkZU57cAO2dlBJOy4C8nNYtw8t36MbuBPgc+6RdW079H/1wP/v7/+728zZxTh+sqraRs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39850400004)(136003)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(6486002)(6666004)(38100700002)(316002)(66946007)(6916009)(41300700001)(2616005)(66476007)(54906003)(66556008)(5660300002)(83380400001)(44832011)(8676002)(4326008)(8936002)(6506007)(6512007)(478600001)(2906002)(86362001)(36756003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G/ZQw6oNZSWlPL5VD9onYaOWor/LRVNWeDIt0UHYzHCye0fFIFsb4hImgo81?=
 =?us-ascii?Q?8PhcPOasBVExCPqyPzSDPLu2ZbjkPUjD69lkKTiRLgk1FLvsM8KCIGTFuiDo?=
 =?us-ascii?Q?vJgLvD2OODLIXmkVoimQOFwdABBty1Mw0BtM8i+XyUJnbtC0EwuEj3JXaa07?=
 =?us-ascii?Q?hPik7lpdtxeVTrqOPAD7+Vc/1Q4xydEGpxknZ56jiSmcyOi80jeCs/Usj/hi?=
 =?us-ascii?Q?dE+tiGZKhKJT5YD0xIrqA2jZF2nwTSjrsWX+vBjwPqUPCl6Jiq+leLLYhhix?=
 =?us-ascii?Q?DOAFhq6RMTZ2lPu9UQzwY8rXqOZ71MYXJPbKZt/5V6fMx3Ts9TQSsMad/78i?=
 =?us-ascii?Q?H9OsPm6zKMBzccqpKH37bz5WkYSzklGK+RT6ejwXLuQHBdB5XjlCYm4Rby0l?=
 =?us-ascii?Q?nRFvffQ+Bg6ZKWJTOiQR9coHPzO3K95syj+5Bh+xCvlVdqycjorREcQl+gEg?=
 =?us-ascii?Q?y2cSAdTDBvlvbZAWYeAhwV6oqhpevSa7nJ9UCmWgsRafU3gxHyzF380Infsw?=
 =?us-ascii?Q?2up6uWxw2xXuox9LZaU03bvEnXdRUfO3PE18fGs6nrgHLhSXUPloKhKs2pAY?=
 =?us-ascii?Q?/8jc88p2OHExCv6dAftN4S9tXLCjDqdTWmxPLnphuDwm2ifIWng4Gv9DLZ1j?=
 =?us-ascii?Q?vatECYp6WfaUTuchirtIy6pdRkscXXsB3OBQkTHiBQOmpXK4Tyj0Mz5DxHjz?=
 =?us-ascii?Q?3CGWf0s24H91SayR70Q0xX9SpRuDg80TJoAzFcYoZQInUANsmNC+aUg0LLW6?=
 =?us-ascii?Q?ITfma1BgdHs6Dnf8D1/77QilBdojEKHu2fNO330Vwc2WNBPLUNrH9xQ0O5N1?=
 =?us-ascii?Q?PGwLmjgle+Lxwxh6EB53ggRM473+lrnGtKuJUXcel5TeOTNoY4d21Xs6moOg?=
 =?us-ascii?Q?0P6Fl0dVaFsFpasjByfsR7BLJ4PC2S74YttAI18wQeaJo7m4EeHwzbPKlytA?=
 =?us-ascii?Q?StEWN4gxjXftvd4o7oeE3ADXt8YxUCdovO+WI2MdN9P85TOSCblNUspiDszJ?=
 =?us-ascii?Q?u/l5ZliVjcHixSR3N0ZMxboXF3icpxbKS+RX60s//EXJJw4FT6dwU4QMvJLt?=
 =?us-ascii?Q?w2TZAK4IupHVnBk9oQfhKUGmih3ceb+pQwou/TzLyCjw+VNsbEk/Iwopn57s?=
 =?us-ascii?Q?q4ZCOM2wtpy6zXyBCeHaqKvW0TAmYb04ktLppWZh2aFzelRcjxKrdI25xwqC?=
 =?us-ascii?Q?wyITuIzRfo2YsC0TeFJhNuSGVqgbWvzNaVMAyiqBKSUeARL+Z5zF5T3O3ufy?=
 =?us-ascii?Q?O76xQqijhNYfg/x5T/0AyjFdVOaUV4MCBYpM1DSmF8JZF8YzxyUq5yB7wktV?=
 =?us-ascii?Q?xMLsckiZmvxIwtoIvnrMDNrH8rm4hV4hLrd5ii0yOO/dFT65xtpJ/96TxGx8?=
 =?us-ascii?Q?oiih6IJwYYw4kJfAHJE94Ur4d6t+qhBtqAyN9Bb98NUcDaZsJe0ODxaQSKrt?=
 =?us-ascii?Q?NkQi24iMcrXxX9zUqE2hJbvr3ubaDv5lNne2co6IlfBJ1l779J/JQmkCo018?=
 =?us-ascii?Q?t12rm1P6Dv3Kgp3Awf6kQtppARD5QWX6I5wzc5toRIbqQSlq2dt69Vcc2MjE?=
 =?us-ascii?Q?Zc9mgINkO5lrZ1DKA9JSO4l6vTLvKOkCS25rTXINOLpFUZ+aHiDteeM6aoHo?=
 =?us-ascii?Q?Iw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684a0300-b279-4e42-0d93-08dbcbc02289
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 07:43:47.7863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4QLpUBhovxNSEPX+DtWStcF0SFF8yoHoVtJTQOKrXmlDEevSRm8KVrQkb1rZowM5jHSoqERAkwhQL3ei1NDfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8566

In mptcp_connect.sh we are missing something like "oflag=append"
because this will write "${rem}" bytes at the beginning of the file
where there is already some random bytes. It should write that at
the end.

This patch adds this missing 'oflag=append' flag for 'dd' command in
make_file().

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 4dfbbde6df77..f00942cc23c7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -593,7 +593,7 @@ make_file()
 	rem=$((SIZE - (ksize * 1024)))
 
 	dd if=/dev/urandom of="$name" bs=1024 count=$ksize 2> /dev/null
-	dd if=/dev/urandom conv=notrunc of="$name" bs=1 count=$rem 2> /dev/null
+	dd if=/dev/urandom conv=notrunc of="$name" oflag=append bs=1 count=$rem 2> /dev/null
 	echo -e "\nMPTCP_TEST_FILE_END_MARKER" >> "$name"
 
 	echo "Created $name (size $(du -b "$name")) containing data sent by $who"
-- 
2.35.3

