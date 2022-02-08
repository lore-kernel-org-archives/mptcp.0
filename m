Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5412C80
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 23:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644364741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Jo1AKAZ9SaQqhW2mYvsrGiFq6n7/kWkMoKIIrmWE2LY=;
	b=ncMvW0yTDupIq0HlQ9e5ac+mQzApAgyFi1qfVsS39Pv+xwUJBz8whA28vQBWXju/+vKzsu
	WcC5X26M1OfrNf9aUt8YiFZDez0CiHDoVcRbXtyPu8o/lwuJW1qPDGdf+FCro1Q9tTP9Xs
	2Pdbg/yHz4/NTFxxwuKhJyDNe+IKqvI=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2050.outbound.protection.outlook.com [104.47.13.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-22-xdiKKTwSOlGlAVrBfyEHoQ-1; Wed, 09 Feb 2022 00:59:00 +0100
X-MC-Unique: xdiKKTwSOlGlAVrBfyEHoQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5CbKDKvIM8sucXfdUBFRgRoAMCTwXlyVe0a8mpU0oq4bJVszOLpULPUXnSoJnVyzyqBKNGgvCx1kDFakC/ayYJzzVhStv5GhqwqvhsXXxrXoaOQsNe1FvCN3Gdbn5hZcb0lj6TqJtLx04/IY6Vi+cFmYwF0BiTym9vqW31h/jCmDg8g/HM5v/rqJfpitP9aHBIC8jBMu9THKFGqx4H4abHWxXVao5r+izClvJD6X+DlMi8Ox/F0J0qK4BufUgsv9bQuXnA/eggY3MNNrIYcGWepHjv3K7DUuhJbHvcESGiGWlj3Zi6qTKdL6BISxwrlehoZ7AFCY7eTHKGIFKFkwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RnNjJiriS/B/WwTx+/fPJH8EabOgMPL4PjLZD3InRiE=;
 b=IkqOut1DjP5MPNbdZwD2SHY6UZHL0Rd9fAIGakM9a1D46CrC0RcbIUb3qsGt/3ZhQ6U+buUOMrqDLrh54zpwpC5gyCgfY2GO2qbJbVOjGQiT/WzZwvqjGZbmZAo7Po7Jz5MaNv3zRFzV6BwPDlcROFdi6H8Q+Emcrsw3za6SHllyaIoTHNbPHB/x3g5/BgDgaYS+qyzlaGBnkEdWqpB7gi96Dvgji792nNd2F/3MPW/ofLIThqiAGPpaVjIkrsiG/+AvnI5Rgx/iN4G3kUe/9jTVEo2Aa/5COCZtd4GhPi/ned6KxQwFVhBQZH0wd0adcQ4ymuFzzZfsQacpgpFSBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB2959.eurprd04.prod.outlook.com (2603:10a6:802:8::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 8 Feb
 2022 23:58:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 23:58:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 0/2] add mp_fail testcases
Date: Wed,  9 Feb 2022 07:59:14 +0800
Message-ID: <cover.1644364562.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0099.apcprd03.prod.outlook.com
 (2603:1096:203:b0::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fc57c79-e815-4bfa-6e47-08d9eb5ef802
X-MS-TrafficTypeDiagnostic: VI1PR04MB2959:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB295972289878FCA15BF59AC4F82D9@VI1PR04MB2959.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WpcYl+VJlWd5IEhziCytCgX+tKWp5pVPx0wb0kfHsk76BcsT3Pkk2RUx9C7aIh9rlArgKdO0S4f507ksvlP2I+BKbutHeap5Z49qF2Z4edbc0RZq3DFa9oiDP4BPKmUP/wcEMBrSdsaMO9xy6YJHk4bNOLPpoyRxkTldWV8Wb1hcaAQn9tcJcu+KCJPHuHsC9py8W2WW0aNs+XZvc2czBOwy557RIwYAQ+7RXYJU2TAPG1YcNn+GfHM0r+jCJeq1sPlHK57OxWypPKTIUE59Syfr5D1hp9oEsaZPlh2IoDT8TWRtReDWIExuRdOJ4h6cOzJxHwNjpBo+M6DKPhVtSET7O1jRGSy2+zv5axsgF2XMY3chhhW5xF8XeR0DVIZO+nah7GEMIll6YtMjWYHqzWw0gM3gP0cYNd0pBl3DXY9SCi1vi+Ovv5Ze3oeELWcfLN6INijVFk5O5a8+A48f8mQqww9kuorXgCHBWahPYvWPXK4CzDgVCvT0Bp6NU4k8+6loL8vJie+7/t/MZch5b+qtXGBJDxAih4r980qlaksqyAnsFJBBdk0BgPpQ+QXN/GNrTnmP+vxVqVvyImNYMEPWSihHS6FkV6UxxBDyuHUTcTq6SwVeFXWN+PDQduLnFS6nFB39IfSlLhg560FRDQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(2906002)(83380400001)(2616005)(5660300002)(44832011)(107886003)(6506007)(6512007)(36756003)(38100700002)(186003)(6666004)(86362001)(66556008)(508600001)(6916009)(8676002)(4326008)(66476007)(66946007)(4744005)(6486002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?js219n142AT8uoAnH8qmdDJr41QRCDMuohey1frdhfSPl2yvS366pGt9JWVY?=
 =?us-ascii?Q?Xsyv5Bhwz3cGwcVIYLDTrtMKrT5Hpxnnwx6H6k6JuFyx2XTFLFcLwoyuRWet?=
 =?us-ascii?Q?0/vGyrpQ/M57nL/dCkiyn57L44g7atX8/fEENNUHLZ9Q+efefhipstxLbOAC?=
 =?us-ascii?Q?cgK0On/j3LFpQ+Sc86IjQx3amYwlxri4U0xxY/0WZqIpac9WYHQRK4tz3L3R?=
 =?us-ascii?Q?Euep5qW8wJ9aIa+oKj4HkXQPVRSWd8aiAMi4H7PUF5sdy6r9Cp80d8pDOtno?=
 =?us-ascii?Q?Lgao7jHNAE1qIAKRVK9D/eAzZRluVBxpctAsMhNFYt/B00lgjCe0agmEgcS2?=
 =?us-ascii?Q?ysSO2zDdu1ZeWfTAPrLuDnkTtYV9Z5z8tnfeE7JNq5CEtI/oWxKv8qGjbSYw?=
 =?us-ascii?Q?ZBeUPtlZAzY6m2e8LwRBKaUVAAI8IPTbE63+Iuoia/H7r8x5ews8nRum7H8i?=
 =?us-ascii?Q?F61YONlUhMqYdyyNFhVNiePiNlXnQnQpgjcD1EBHG1wOlvk1D6IlMgCtEW/2?=
 =?us-ascii?Q?HPHn1FSUgwsdwsw2IYevl6mQ2+e7ih/CDE2cPlF6LYtP7cSpwlNELmNm2Wgj?=
 =?us-ascii?Q?/L7T/tqYf48vrKYUYkyBmexRb9v7278O++H/3uJF9egAN1AvCnpsn24pLqsD?=
 =?us-ascii?Q?5lAmLOTaIhbt5v6k2seVP99DTd4e/wjHv7tudZhJOwqyx5uPC4+ljjz2A9bQ?=
 =?us-ascii?Q?bFWMb+7u58zdSYf02tf1d1b7NSOuSjkMl6G8ROK4jFnnSi/9aOkXjh/2l6UL?=
 =?us-ascii?Q?8qqkcGGqgve0pf99KucmgdKaSmhjFLL6Rr3eK1TxMdeg9BdyYTgq8D/TGRgE?=
 =?us-ascii?Q?fEBhtWWnGkHyoz75OiaWvGKoTLa7qhDGvDuzvtLrVp+nxafQhbkbpYHcRXu3?=
 =?us-ascii?Q?L0SWgyyEbmXnpqZjkOjNZ5XT9cZhfUywGaKN1a413ziAFMW8Nns7cC03dPmI?=
 =?us-ascii?Q?Ia0eA0qPKPau97QVkp7FJ0+eKLvR8ZQRkhcSVTG+o3LryvnEPqH8Y6sr2+YB?=
 =?us-ascii?Q?wViGCxrLw+HrN/dagHRTm699KF7r1B5SAPRwBH48DDMO6sGBFXtgStSs+372?=
 =?us-ascii?Q?LikXXAtII6+0crXUoA9M3V7Q+T0DMy8/pu+jyeBZWNm0tUwWPgEVpHDn74fh?=
 =?us-ascii?Q?wmMzmwUK8YN7CSGC+CVEqJ6LhvYScX0Hb2OSi0gbXg1ZB0OpEjQSEMIeMbIJ?=
 =?us-ascii?Q?m4i7pItyb2UVXPP6bitNn6deOukuc/H6lGEQaCtJFjpoRFHH1J3GBk15Alaw?=
 =?us-ascii?Q?4r3AYB4Ooc7uLJK2eZJpXsCJ65pJThujY7eoG9rTUgjf+dEVRZimFzEjYMUz?=
 =?us-ascii?Q?hOH4pMef/ahrVQpTpYjLPaDacrbpNDBvQy14yY1WevV1UWI+Z6laJToERAj+?=
 =?us-ascii?Q?3nkBPXaZQFNgzyGTHXz4OS7jJeBlvMRQIMgsQ78myHW+2aqiZ6zf2z98v882?=
 =?us-ascii?Q?Lf9TGvbGNIdPfCI3w2uBos//8dGdQehM4gG1/yWUicpAlcdmyF7g1mi5nfIL?=
 =?us-ascii?Q?xpLS1pULgR4ZaoQQrpFZnWW3cMG1odxuVgEbJq9uvpyD1eV2MvscNAfGzep8?=
 =?us-ascii?Q?/uuWLX8n1CTUZ5NwFbgeqfK152swyp66QlvPuBKvrcBTpsuWn4v9CkwbXy2h?=
 =?us-ascii?Q?eLcRvM/cl2QOzoatECc9YYlwGrZTRxVitZXztWJR8XbWOkAi+iN8wXOM/FUK?=
 =?us-ascii?Q?SAwqlEPltkGlv1tRRyhXKbmWlbk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc57c79-e815-4bfa-6e47-08d9eb5ef802
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 23:58:57.1872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3wZxLJC2qV/3bz4tsI0jd1iSeeCHZxI0MCSaqiltgjGcV4V23TMCAUvJbKIxbV51S9ZjzMRkQV5kUYyIm7JvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2959

This is v12 of the mp_fail testcases with Matt's changes. It works well
and very stable.

Geliang Tang (2):
  Squash to "mptcp: infinite mapping receiving"
  selftests: mptcp: add mp_fail testcases

 net/mptcp/subflow.c                           |   1 +
 tools/testing/selftests/net/mptcp/config      |   8 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 142 ++++++++++++++++--
 3 files changed, 137 insertions(+), 14 deletions(-)

--=20
2.34.1

