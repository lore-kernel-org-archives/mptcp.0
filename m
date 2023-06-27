Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D098A23
	for <mptcp@lists.linux.dev>; Tue, 27 Jun 2023 01:39:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvbsEJXlyvF7s8luzefMaiqu1FaYb1fl8llbrSVfnHvmpYPpNUFbdqnzQiLqsgkUjS9SgRJ3CZo5WZ+kN9Ypoec/SWkQPjyfKvneXtYluCCWP0wZbswBPFJneO6W19aiQs2TFFvgMuOSZQEqfqU1j16/O+P6iY6ZXxkUV+Rf14JGq7+AzgQ/aVbxmWd3toO7VI33Lkz26MhDLUten7ft+hUT6te2EdLMuPshkhtD7V26Cyx9m7pDNce7I58FNHJZ27LS74h6Cm8fqmC0OdnBG9sKT8VPJJo5XZ/Ml7W9f0rz4XhNDup35KBqjBSFsVeGRD4gNqUL6nllKp5KNwYnVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/oTyfLNPvGrRexzIpvrw6gUDNkOlIFbUcH8CrjTeA4=;
 b=a5aMGNicTzCYv+VR144shzZy5Vldj/v49nCQIQIgMM1E3WdNvaAy/AAlVIiTTi7v46d3x6C8pP5QIBHWnpQ+NgCVIk/Bosyqo4X3tICJvHriYjwybiRfgtsTUlHZ4igPs7pfrABCDAuklZtJmt/xgQlkpPsVqlKVfbB4fDMaVJkmZerQFG960qGQFGIHqHdXHaNMkZFmNajYY84rpqhggzpCSqwbP1Q7tTClUJ1NNySRIZJWx2MavilR3xn0HI/OOcZ8C8v9VtZh9lb+c40EDuw//ueXp4xgQBvBEJy+U5MPS7hagp4nh5GBOuqKL3AhQIhsMpfnN2y5YZg8how9wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/oTyfLNPvGrRexzIpvrw6gUDNkOlIFbUcH8CrjTeA4=;
 b=Tu7SQHZITYj1ZgUFBAKBslEwhI03ZUdcaSP5G/i3MYhTS/ZlEHmO766K1s3p45tSKvfB8Bpetp8PPclacgyXV3n92s2IFB109RDXGUUDP64eN0DtoztF1fpYIeCSNcPn/WZKHtWsSNiLN9e/WUKDNq5wt5XZY/fW9YO1ucETqHoOs62RIbMMWVQbDSjSYw7iVix0PKv2SR0dPBHOmTT6OLvRLMny5wn/xHTCd4qNdri1r0cMrVf84l1EIA2vWBUjYk28hnHKYZQEeCPTcYQRVyxR9qvOHfoozRkT7OPpSmmX5aKATTZw9HRWNt4LwkgyRqfbdzg1kC9xK5PFBYBRyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8277.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 01:39:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 01:39:46 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 00/10] BPF packet scheduler updates part 2
Date: Tue, 27 Jun 2023 09:39:21 +0800
Message-Id: <cover.1687829823.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:195::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e9740d-ef69-4355-6d96-08db76af6381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CGMc/XNXjCrJ9KuA9HP0V9Vhy5I/BuyAY5bj2l4KkJTikZz1pnONKkqWK4UhERkRJzPBr7p0ubF3lJBZi/YyuW/zqEJGG21jJ3vwvoBYEGYcC3wv3DB/96pdcPRhPzXh9sf/OHdbaIBwxksn53vyof3u+1kuJ9gy40OnLNs8mHhPDV1UraDLJ5kEKoXsdiuUAaFLfaQm9N/JbmOk2teyWTy9qnT9t6XFV8Rbu9qCfYg8B9h/phPHFDFaOQWFBR+Op3U7nSx9y0djRLhWoweY8Y8CfL1R7fUdJ9hWqLcm8MpbG+ZOMUEwvV51/DlEbmSs1RK2dBsecsEzMLGLxEJ5l4FqxUi9zC9oHMVd//foe87rNDU4k3F3M60jJALjlRyb50VBBNuo/GqNwgR/W7TzgxFkp6FnTI8KNwwfhCgvXYmGO/eVBJ6sIuhYgETF4kylMF/cEmD3dekdcc0dAp0W/uBBPeTZqKz4zuygbVjvDOgMX7QgF4rTflCWy30qOFe6cxdnH9LXhnhgh1LOOTlQ9eFWm4Nerq9ejiGzZN3nagQ1baCOsmjnvuBIuiZVNpsh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(6506007)(107886003)(6666004)(478600001)(2616005)(83380400001)(26005)(186003)(2906002)(6486002)(5660300002)(41300700001)(44832011)(86362001)(36756003)(38100700002)(66946007)(316002)(66476007)(8676002)(66556008)(6916009)(8936002)(4326008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BBFL1adKGytt+lHno1bfO9kNV07uF8CugFPmPIFwcqtMaMujwn5/1VpqddjY?=
 =?us-ascii?Q?G1LThGa+UO2vMe5YBUfqd/6OoSxhR8Hu2ZYUkYKb1+y8lZjD0a0avwcB9PId?=
 =?us-ascii?Q?Oy9Wx5pkEI2U9oKjPQxCGS2vgMbQcCBSWIwCAgOhPDKgarHViVDV7ge80lJG?=
 =?us-ascii?Q?BOxrCUolEHqmxRL/jggr1P4qxvh0wQI8Z9nzwBC1CT9DL7zyYgS/LX1lAd/m?=
 =?us-ascii?Q?ZLE+aX/+Tsk9n+PgWBvWhfeGd2OJvgsr1mTc3BZGzaeu/g+nuJGtfTMNwehn?=
 =?us-ascii?Q?SmH2liyYrPT35xRpYFKkNq3PO9FrrtCpYSSqqanLg/lgLQHZOx4e3a5/W8x+?=
 =?us-ascii?Q?K/rqPJKWjeDathxZao+7cNAPAkrwQTBYe+GDvKdPk7Qostc9y41GON/398wz?=
 =?us-ascii?Q?vUQIjplhRLjEUSk/uKLrxe8qo+mqHNu49eHWDP3wQIPjvV9sKHvLzhOsTWpb?=
 =?us-ascii?Q?YbRj0Ghw0XQnKCrAzqdmWP1XiymxnciMh/tyM2kWbVGAnYX/lFHRBDUnm2yT?=
 =?us-ascii?Q?b5oyaRgcmzIseh5z/pyWpqxiK85N5iLuYfg2V1OAME89wHn8KZdcFVJFZNQE?=
 =?us-ascii?Q?5YsDc/FO9zGLOEW6BukagaH5GO2Vs1ZViSW77zNV/I5Bz0GpC8qFq+LPjBlh?=
 =?us-ascii?Q?zfJ7hPzPYZUUVoMnwzJJxVBakvpmTkV+bjMa830jJMK908n1PiFAjxi9LwPS?=
 =?us-ascii?Q?UMqLZti8OdEuMuDbTlGVSGSUAXKPFATdZuraRYP9L9ymG2SzNT1V8cpHCo+Y?=
 =?us-ascii?Q?y4fa+EypUEb8MNI1TwarBtJ9Gmj74SALNoI5s9pwYaRlaEs9UBl6ArO9utW8?=
 =?us-ascii?Q?xYGu3dg1ZRQ7qt0HOvMdLvRL2fPj5uWFIwjQafjcy0ewqUKZSkYvhAWzRQ3v?=
 =?us-ascii?Q?MxykKrJNNJG1zGR2HWwUE+V9QeLEbWndLZnMBAuAbADOAvrTTPX5/nqfuKEf?=
 =?us-ascii?Q?NqPgxRyKAayX7VFtrB0uLR2UDZtS+UDt2/V61hSC6paTf4bwgtGTqQOCCQYX?=
 =?us-ascii?Q?DheCPedo+4Ihb9TO/JJlsqrx0qsZLkci0iRq+sKp/18T6iC/D22Oee3sidan?=
 =?us-ascii?Q?CnNeneM5s3tonvpi0yJVdtfyIHRGZ1UezNF13fwYvdRCDL9H5ytvfgGBJuf8?=
 =?us-ascii?Q?xw9P/REp0koW9K9USmP2Xts+J5WINlnpGWfK6VKjzcTf3yvH8N5FsZYLxlZI?=
 =?us-ascii?Q?Yb2AGgO/twFFXu9dWaJdksgS+cUGDCAEchkLii9OCxC7aFGrFs3B/821Yg+0?=
 =?us-ascii?Q?X9+gOHr6WkPmDA3KuC+MNyw09TxIc068teVb0K1N6F+I6Rw+izSNyElkOzON?=
 =?us-ascii?Q?kkGlcTYuXLIFBE2qwYVbG9A8mtQeeMemdnVSA2RJDT6duYeu/QyJSiUGEpuQ?=
 =?us-ascii?Q?NbX7xlU0jNQcjZGByXjmzd/cwxasSRPw3Lonj6db1LIFRd0EwX4yNdBcx6vI?=
 =?us-ascii?Q?hHlaHwaLdwsQKtdu4pLEtazln1EsJg3ZN9k0vYPiafb/Bu04cLPdBQWIzMtI?=
 =?us-ascii?Q?r47nVDNH4EjqdIFho01Ks1SZP3mF0eWLSE48O03mmegalDbJK1ftbEhbKkFo?=
 =?us-ascii?Q?9g1zfBQK60OhaL4ZQBXTt0eGt9vEcjKAIR0mJcD3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e9740d-ef69-4355-6d96-08db76af6381
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 01:39:46.5488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hq71JP83TZxMoNsAL8d3PH2ff+UEBE431heZw6z1NMrfUbj46qCUCE6codn8RIkcXIe4/vFxZiKAX9ftS0M42g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8277

- Add time metrics for sched tests.
- Add bpf_stale and bpf_burst schedulers.

Geliang Tang (10):
  Squash to "selftests/bpf: Add bpf_first test"
  selftests/bpf: Add bpf_first test
  Squash to "selftests/bpf: Add bpf_bkup test"
  Squash to "selftests/bpf: Add bpf_rr test"
  Squash to "selftests/bpf: Add bpf_red test"
  selftests/bpf: Add bpf_stale scheduler
  selftests/bpf: Add bpf_stale test
  bpf: Export more bpf_burst related functions
  selftests/bpf: Add bpf_burst scheduler
  selftests/bpf: Add bpf_burst test

 net/mptcp/bpf.c                               |  16 ++
 net/mptcp/protocol.c                          |   4 +-
 net/mptcp/protocol.h                          |   4 +
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |   7 +-
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 121 ++++++++++-
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 205 ++++++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_stale.c     |  65 ++++++
 7 files changed, 414 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c

-- 
2.35.3

