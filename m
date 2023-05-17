Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2089.outbound.protection.outlook.com [40.107.241.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B3364C
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 04:33:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPxFNZhlFrAsQ4Eea5QGNdN3VMLHwxkgEUeWQQzA7p0Z87AVw9Bj05xeOsuUjeQMVpwUzfx/gX6JnnsaXgeKVZQYw3HynMRq0mQKnVlStos6jF8r+IzQJB2NI+63xFqb0bqiC7DcXj81Z91bcPUO/IXnpeUeDsf4AOjC8g0rxuNtDnbpU2RdJJ1c9ywNM8ZIL5iz3jQbt0cV8A7H5zTKFg8sTmSB2nWBuN5vLKeKIBF5Iq17Z//JQqG0QfHLhh4a3viV1b28Ifnan6rPy75MprACEHsTaY9lUUCf41mJ9cATdsPsLa9wJn65eJAQRnA1X0h3vdIqwH3lyFCjsfruWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzLaZRR42trFYGnN2a4thal7yIi9THLsxnDdcAYbh70=;
 b=KYmS6dtbxomYwfUN5N6uWtnFdRFkeg+x8rUCnsFrfe3DjmTtQ93wqBlnBQ583Du1BDhNeNjNdNXAIrBpUdt+DIPa3RffptAX0UMR0GOU+Zvn4yxTjXmq61sW0CM/D9I/h3HKFriR5h1SKX4C20cnoRqQRm0BvozxYAd/3yDb7Jk5TYbJ2ZPrzsXB5bsSaE9cVlsR1JIdmQbZKMQHn3/CYY2jjjnseGSm3zP/L1x2YCW51EklQCnwKcgxZwhkUw/rOvUxdYKVWzx5p5WVaaKGFTAVi0lMEQKO4anGKuwNorxYEFk80EY9y6jIYCfEhi0tFgFbn9Rjtf93sY2o4e0C+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzLaZRR42trFYGnN2a4thal7yIi9THLsxnDdcAYbh70=;
 b=x62hT4NyPn5a/oyuoCTIDlED1hGRg+55LMnss3U+iRKFP2jJ/3hAGFCLc6ZlpM1x75ZwV56eBO8qIPAPEtosaoTbcwERTeQTKLK6H1B88O8WUgrmcsHwhfFD/9PqlQfE1WwrV4YI+7/u05+8dLJdMYIbJBGY8wgwV+gN8547G+BAyLK9bBiBxCq8B21RLJPHeZAhXZ3ULT8N2U1Zk0mAN2/Nj+gpXT+HpXU2JNxRytWA0iSRgqEtTVDJ5F0bHT+kDoYhcGjfmz/kAQuQrLPMVTfEC+H20w7dONPy04hg8yGYaBuP8lDFl5AvZiifr77Th/g14OnVKt5Mx3HENDNDrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7657.eurprd04.prod.outlook.com (2603:10a6:10:1f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 04:33:04 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6387.027; Wed, 17 May 2023
 04:33:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/4] run sched tests in a dedicated ns
Date: Wed, 17 May 2023 12:32:46 +0800
Message-Id: <cover.1684297911.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0197.apcprd06.prod.outlook.com (2603:1096:4:1::29)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7657:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a36cd5d-7ff4-4390-d532-08db568fcd85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y/xmA+K+RCcqMV6CwovuEARoceu+Pg3V4xqxBOotXbQz0bR0osSR052PORuJZpp6zC5fECe15w/PDnk5Vdf3+GtXKW6u5dcSj/jEA1Ysf1ZqDhRPf9nz1eAmkYauFR6a2fEwY8BcGmfaVzQjqvTPmhYWceS0ToETexkRN3z/QiZ2qBnuWDR1OzDfMhJ5gcXQhrhMLtMqfA+42bq9/lPjmPnKOSFac4iDQe6AXgyVUHafU/WeVpfVDm6m/NGLbA+JgariRP3eUiVDuP7pGa9Xa+PZZTV/P6mAhA7pQ8OdCtFiGC+nIZyyISUHUWzO/cUfWNRmugHoYOZ51fD9sgIyBokuxRNAdVCUJoWsaP1pGBvDtn9MX/jfKs6zhEKE+fMpGpADtTqKc0VuNAdSMGlloAf/D0CIyl7S15O4mX9kH7VdQMA8gXZbgGQUjFrfTMEPlitgCAulZAJH9vHQlF+4Hp+bgvgv2hgywsPKbzK/xhMsIgHSpHmRXFdEp1wuTTnuMwzMvgeS6QPIVU0QZD+0g3I67o2VVL37UAkEQAnrKnWmZqk0Ls1OCx7SQrh4TXGz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(5660300002)(66476007)(41300700001)(66946007)(6916009)(36756003)(316002)(6666004)(6486002)(4326008)(66556008)(86362001)(38100700002)(107886003)(83380400001)(6512007)(6506007)(2906002)(4744005)(478600001)(2616005)(8676002)(44832011)(186003)(26005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cb9LkpnZffcECV/s93XDheL1lFdUZHjX/jI9GEhT41xMWZGd29QWHzSsy8Wi?=
 =?us-ascii?Q?CW0FKvf1JKln4KE+RvwxfNFw0jraD8UN7RStUybe+odRXMuo13iJ8JNZ2OfK?=
 =?us-ascii?Q?AYYgj/cpq8IJ6hW1h1a+ggp1lUbhoOSB6ve9W7CcVvOoOyaCnHv3L2triKdc?=
 =?us-ascii?Q?eYzmmPO3Bp6/FAeIlhhcvLSR/yGfe2+/5vUYBmvLa1fjn0Nc8WuTU6POrLWq?=
 =?us-ascii?Q?qDw4INzD0WrOuXLyv4f+OLxd+GQMSrGUHVL9KbS8GO0I5y6/cSlSgGIFoMyR?=
 =?us-ascii?Q?JtbZrWRPnZ/LvZwNdJ6mHF6v16fid6/RfsBXwJVwqIw/UxmMxu1FRXfmjAnV?=
 =?us-ascii?Q?wR7Zn+GR+t9R21w8U6k78Md570pq7/lD2nkrHhya1wNYQVvYR3os0OQxrYYm?=
 =?us-ascii?Q?CBvgHDcGB323gPkdR3AiuaygX+a6M6Tp6AuKK/q4bvjcK7XGkGXaQQswxWQi?=
 =?us-ascii?Q?2AgAHiLY/sgSFZL8KWRotw/s2Fq/YlA1Tp2TgfSc6eJpJA8uzYFfFg88XiJ5?=
 =?us-ascii?Q?4bG3yIpawFdUtYQUCDgLb6OMzZLrhvRo6s/gnNrzUTcFQoDYRlY2BImtWL3R?=
 =?us-ascii?Q?YPqnghWHNkDndcBFvXJaf8u9mvI4BwaRRxSRbCt8MP19Tg+Jhop2mBLQJOMK?=
 =?us-ascii?Q?UB/vzOhdrqi/Fu705w1rGm0oD2RqLRBEp0MldUW3qNKb+54npU7HWuoN2AxK?=
 =?us-ascii?Q?BVbGVH3mUGaWCK8O35/C2IhB/IabnsO2SgVBOBrFhLxuT/Kk5hT+8ZlmgtZG?=
 =?us-ascii?Q?XIo5TAB7LapQFiSP8Q3XhQxiBoqsg7rqJZO9bQ3v6L+XNWYJc9llaAgHELIZ?=
 =?us-ascii?Q?c275D6JXQ7f8LvWBJ8/GvY0mB4tCKkvTWHKb1UpG9GVfiqdU18zRThmYqop5?=
 =?us-ascii?Q?L/tO5CQvdDRuo1uS6di0jN+UydocpD1wvuCVpcUGGxIGZtmchecqzOa9PkbQ?=
 =?us-ascii?Q?KBlp/d30OhBNaE6u5QhuUk19Hwr2L1fl6amDJhyjBK7FRGoEgw0ahr6Ojktx?=
 =?us-ascii?Q?tRAMGl5KHYQTDQj1LvbIcCE24Lgsr4aWYDIB3J+v52Pgk5PGVNgHKWxQe41i?=
 =?us-ascii?Q?TAU1ko01QxD/Olvt4Q8GZG0YA2jk3vKlP/Tpqmy7rtYsR548OxJ1qs/d/PcM?=
 =?us-ascii?Q?zmvrK971dUcUM9Jmqv5Dk+e2Xb1yIZKYqkgrN/DvekYjsN7rjKdmhB7KF7XM?=
 =?us-ascii?Q?PG2onRz4N35gck0UsiXZ9B0R51YNO12VwfOresIkXDtVLZDXZpL3j96FGkud?=
 =?us-ascii?Q?dUV8IGWPjuC3ZntA8llaIm19RJhDBjPMWhDFiJBpXMhHlsffyJCHG7Tm0aD3?=
 =?us-ascii?Q?QXJ1K0yrvNG4zP5xU36DlY8cEsGKb9Krk4PVB0GDUGdPiJXd0j4L7PNIqZEn?=
 =?us-ascii?Q?SY8c0MnpUOesipO907mQFZKjA6+LW1TGfLeN4haHECXtNBYvNu7dvhv8RBpC?=
 =?us-ascii?Q?yzjJqjqvxWUxWL3smXr2e3lVhMlM9qq4P7VclQAlNsoSeiapTj8WJaVe5TwB?=
 =?us-ascii?Q?4x3Qn8B8qRJzm0GfzAD7Jk7f+3QuIclZSZbD3vzYm0+KovYdhrhxneS702pq?=
 =?us-ascii?Q?aWAEDbYDwW2fKXLNMP8KeHxVDCFt7Lvv7Gbbtxsu?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a36cd5d-7ff4-4390-d532-08db568fcd85
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 04:33:03.4921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M6nOuu/m4QLGrhm6w3K92mvpRybUTVdu0rsloczIIiexmER2PkarxUhgkGoILXHaJecsJy+U8nGE8McXfBZZ9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7657

Run mptcp sched tests in a dedicated netns.

Geliang Tang (4):
  Squash to "selftests/bpf: Add bpf_first test"
  Squash to "selftests/bpf: Add bpf_bkup test"
  Squash to "selftests/bpf: Add bpf_rr test"
  Squash to "selftests/bpf: Add bpf_red test"

 .../testing/selftests/bpf/prog_tests/mptcp.c  | 88 ++++++++++++++-----
 1 file changed, 67 insertions(+), 21 deletions(-)

-- 
2.35.3

