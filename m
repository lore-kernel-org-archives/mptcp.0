Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2044.outbound.protection.outlook.com [40.107.8.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC572846A
	for <mptcp@lists.linux.dev>; Thu,  3 Aug 2023 04:27:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1iSr8ZLBCWJqy8DxBLhEcJmMwwKzzP9NkRCXesH7Rr0DPupEP+tI8q4XrVX35/7DFlBHEYxz2lqB0gDL6GN+3lEmg7tky3uft985B/JpjOKqsZYUoJ+Rm89NdQtUp4nTwkUZ/RvMtziKnv3PHjCdfkZs5xEFNN7q+Ak3p4W7tGuqjHSlS1+uaTxh5rxkMEX3NolxHMRqETd157E6ug7TBzgaIBFD7HNzki2j6XaYkRQ+LMk34PLtMvsM6mOGE0BNQc+h3fsFlQLlYcNgIkKBDDa/Z0POZmNtF91HV5M0vMOSHSJ7AfSzSnk8KnkKAiCGzh+c4pK0X8swR2XEvEmrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+d1xj7+9Uf6NGj3b3FitS8px+lTPF9CFEsvyz8asE3c=;
 b=QhYnKjKXZOByPXuf8Ng91dcAu0qwbSIWgwlmulKnsuovcWqaZH0GnMC8qS9wPDT9uuqh9sTyUWzRyZf145g6gyQuEfXBvUw/xHauh4p1EBCy8TpcKan3vhD/VZCatZQ0kTf0p1hwbMdRGRYhNi33DQfLysTn2BW6FJ+b+ANN22emy0ah3bArawrbbKMfzrbey9KZ0LQtW1bm43DtEdxbmiOT/qaR563YDHOczPyHUo4tJofN7rH0Q0x1aSDHe1rMkSytDHczfLHr88+laqpj/RMry5a5Z8AV17dOmUsXKSSLPLA7hblPHfXDUJTbW4VZxe5ZqIzaab85me+pg+FPHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+d1xj7+9Uf6NGj3b3FitS8px+lTPF9CFEsvyz8asE3c=;
 b=sPxEkZznZKxLxJAttGtbZezWfYqhuaZy2mV8uw+T62FjbvMdSCb+3isvnaGSszgrga1tCHwlKN/pPA9amFQjV6HLN46tma2+MAD2y4a+dFLudKnFEainoTCpuwOM8ZuDAXgWkwX6ZaDVFpCOm6PuIPfROWh5rwnefT5UvG92+q+Jti/qd0IWaVtSPKvxFHmmMLGqPu3HmdvJKMr1vzHxIse7JXfoNtwEnmSGWYCE7h/AqiehO3XDzilpzRcXWa/ox2iyplu6I3lZK1pZ+9uC2X6qq8J36CmK8mzb4ZJ0O7VWnASLo8v7Mh1OCL8kc+D6abO41t+p/veia6hu1GALug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7909.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 3 Aug
 2023 04:27:23 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.045; Thu, 3 Aug 2023
 04:27:22 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 0/6] BPF packet scheduler updates part 3
Date: Thu,  3 Aug 2023 12:27:16 +0800
Message-Id: <cover.1691036765.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0165.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 90880163-bd08-47f7-e67f-08db93d9ee80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WTTBML9oTbMqgyONekujRgkxiuxvr5qykZuZOx2A+PqY+hxl0IVY24fZ9v9YRkWiQ/lAA2zBUWOUzcPC3/Hj+dv6/+opFYav39QM6temz0FtJcs5MYhUkxBd1oFhe1aKQDrP07oN6AL6htbQQk8DcxIC6/8PnpaqM4IveGoJ90MNLGRfkFjKn5fLVEidNZ5d+/eCbE28ZFobzMhqPD3T5UqdF9rLjZekTi573k5QNTSI6Ov/xJQmV7cSFnwEYqa8ydfoGHMoi8vVZwehgm7vILZWPwvajGDXApIofakRDiDldi6A4EbCjv+o0wJ1ghCHGZuvO7D434vepGKAEeOAohcGQ6WQFqMbkdBE7Pa/5LqWiHudZIevnkqZDdUSd6d4nF3+URqZGJkT8vk2F6zZyOWRmK4JSNT0Rv4hA/YZV49JNkZT213MNHT7JjWZq6NsuwQRz9xrdAJzXWSf1pUsb+VeI5zVruK38byAHA8i5loEeOLvOLAG3mvy3RAVMQSt4Q3A3YRE2QGVD/OMbwmzxjXtd6umJIYrxPC4eqZtW+l0mm6D8F9v6VsQgfzTO7ZzES6yK2KorGAJ2idXBYHZxJVKkKrp/fCuSKvRc4ERdYg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199021)(4744005)(2906002)(478600001)(6666004)(6486002)(6512007)(36756003)(83380400001)(2616005)(86362001)(316002)(4326008)(6916009)(66556008)(66946007)(66476007)(8936002)(8676002)(186003)(38100700002)(26005)(107886003)(5660300002)(44832011)(41300700001)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vxzQXBIgpiFIGeDZBZA/bJiXvfhA2Cbz/qrwfFCtwNOvTk59Hw+Hqxnk5nw2?=
 =?us-ascii?Q?FhgK9k5MLdQIQ1813k3uK0fEZZndcFUln8jx5cY9AR89DaaY/LhnTGJbHocr?=
 =?us-ascii?Q?yJAmgPufA134mqKZ5q8YYlE1Ayidv95iSF6Tu/DzB3GzI2sgatCmah5Y74RO?=
 =?us-ascii?Q?FkVcg2Vbie+th4V8T8H9b2nojfKXrL34RDjCzpUc93WIql/r/2cuYjcgmyBS?=
 =?us-ascii?Q?/M4BCrD2QXXSE9TbzR/g2y2/1xx0nSs6pXoacBVALle5l15SwZcJ5A1QBkUv?=
 =?us-ascii?Q?dt8vo0z9gLqqYAqxU7m/ovhNzOVeaPkg67deXKqFj/Wf4ULWlwQISFYytvK3?=
 =?us-ascii?Q?7isHtSWknGh44pRMJe7KVPRsLR1eMa17PPYn/VCbxcUJdINApYrZYygK1+cU?=
 =?us-ascii?Q?IM60Nrf8HtN2fvbS977WpLHUjNtfeUG0lM3Imm/lrf75EAaOhqxBK9XyxrU6?=
 =?us-ascii?Q?wm4JQsffmtjzEKE9FHk75KfZ7cm30krSVzTPiDqn99J/DtvvXEmobgrtvJr2?=
 =?us-ascii?Q?zupy8taVdXdfUb06ZcgumQ7XSAnD6vaazeG0Zt6a4YZfe0vle60hO8yTjKsc?=
 =?us-ascii?Q?Gvk6nzbEKjXSXjHgZHzy3l/VWomMsDpUVf3b1BLHmXL+n+CuEYJ+JtG1XDm3?=
 =?us-ascii?Q?i/WT571NqUHSy6YWOAE66JXJvHI/iAussGlLNAHVv7y14N4Ga5JhESgiq3nd?=
 =?us-ascii?Q?nwJIjtn6O/l12TErnleoMgO1823phR2PGB38x9xMFL2n2bKedPTgw8dpgXPa?=
 =?us-ascii?Q?UMDDLvxVV6pr+O8zNmpQF2ModXh1t96Sw9Eh84/JyrSoh4aytsFBeWdKRikq?=
 =?us-ascii?Q?CDWCHfp37iEhhuyZgOWupGNgD0VZ6njL5HPhLMM51L8hM4lrILwerpOVnfJ1?=
 =?us-ascii?Q?GMpQ9NOZACY/SbghQUb/LDW/WsZvwrFVC8TDiy+30wcNvA9Iy7G/+aZKEg/k?=
 =?us-ascii?Q?dB40iX5TrWFyRQ1yE4UB0+7ZBEGZWfcdDi//GKyp85cuE6Q3Bg9WT2g4/dMp?=
 =?us-ascii?Q?Pr8l8/fn9VTHNpINt3Qccv/JOFjOkZwDcwIJqgeqyKhSK9NzSZqfKDyvGtdc?=
 =?us-ascii?Q?uoL1WmVilFDbb095Xli1EKyi+4wB45jmbPWHhoB8JCaxX7AX/2fPKm7+AePQ?=
 =?us-ascii?Q?kpfE6U0utoFJt3I6ylz0sUFFwSVU8BoLh+iTBOGXG9emwEVlfa0sfQajdgoy?=
 =?us-ascii?Q?gTmACgHVYbRMt02NNVV/4FY/IVS3seLtoyiSUXCUebb6aHvgYaysFANfpIZq?=
 =?us-ascii?Q?DUQNeCTGSNmwUBp8DjZZ9yNs8L8b8FUJcsKC7vcKndBaQJ0fvzcK2flZSTEv?=
 =?us-ascii?Q?yTeZrzNF2bLddmIKf4Mwsi1oZM2B7sAY2YOmbWOsy0P8+UBWcS7WVh6A6RKF?=
 =?us-ascii?Q?HFXS5BddkTiB13x+F4hlzvnexFxvUWud23edQbl7k6LfgYezuwnVahlnedgV?=
 =?us-ascii?Q?9bp9hz7XhPss3DNSG38yitfC6rK6VUTPotq1haCH6gsXsA5Wb2C8JK6OpKxj?=
 =?us-ascii?Q?kla1/HvzkRFF7NwE9qojVtG1Q8kuh713thNsY1Am4XD9pygn+ETPHyvwxaCa?=
 =?us-ascii?Q?ksmHSKhJnuryTCALIHd669Q/BhapU5tZbfgHfmSq?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90880163-bd08-47f7-e67f-08db93d9ee80
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 04:27:22.3507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /UZM0MYX2TfvKMLHtLDYDKYFU+VJAnDu6FnfqgkNDmccPu9CLAtFJruoHkV8o150VC7Y7OQImwQ3wxyEBQ2/EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7909

v3:
 - define tcp_rtx_and_write_queues_empty() and sk_stream_memory_free() in
BPF context.

v2:
 - use __always_inline instead of inline.

Some cleanups.

Geliang Tang (6):
  Squash to "mptcp: add sched_data helpers"
  Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
  Squash to "selftests/bpf: add two mptcp netns helpers"
  Squash to "selftests/bpf: Add bpf_rr scheduler"
  Squash to "bpf: Export more bpf_burst related functions"
  Squash to "selftests/bpf: Add bpf_burst scheduler"

 net/mptcp/bpf.c                               | 19 ++++----
 net/mptcp/protocol.h                          |  6 ---
 net/mptcp/sched.c                             |  6 +++
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  3 +-
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  1 -
 .../selftests/bpf/progs/mptcp_bpf_burst.c     | 43 +++++++++++++++----
 6 files changed, 52 insertions(+), 26 deletions(-)

-- 
2.35.3

