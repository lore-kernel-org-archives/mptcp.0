Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAA910EE
	for <mptcp@lists.linux.dev>; Sun,  6 Mar 2022 01:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646528515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o8g+5ZmRQpnmFzOQbgiSBoYtHDjbyjGz7feXvARjY48=;
	b=Q6h/Oh/2bmr6TiQmV/Rw0WRWXsbyKbl1FpFCVgDv1rA3N/RPsIt7fzYrS0nv/gVnkhsb81
	0LfCkv9gdFjQU/b7rWeIxfoIVvGOf1JHVAu8DwtNc0BxXAskFPdJvkFL7+0pq5FJ/fPurR
	7duy+AOdVRpP5yy4++jv9qgZ3h3YUAk=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2053.outbound.protection.outlook.com [104.47.0.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-g5MhH4sRP0OBPD-yXJueuQ-1; Sun, 06 Mar 2022 02:01:54 +0100
X-MC-Unique: g5MhH4sRP0OBPD-yXJueuQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeQKTq0OoxRMkLw8VTPHa5MBx6EyToCiGcI0LrKLt70X0i500YKhcZ12xZgYpMZbtu3wHs+gHwn+B/c5hWa1xQKB51Ra9P05/XbWqqWwhQGqi1yArlKWN6VejqbndOvGVDs0YiGTNyzUfHw6+mFHc8QrA1tto3orhcp4va8pepvi0rl8DkTf78QvvCA0vnZ4vVRO7LREGGy7MuL8IA0gqlHmmRumgDSpttBEXLFrRnifoAF3eNOhSWKplf34moVxYT/Ex4/iiIJGf7w6gOUL7udSQXEr11An0ok3Ee029vRzQkwYCmfN6C7TCBn2VDVnWLSHAxT4jUFtryRLrUkGUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jbfhr02d6PwTpWxhaG3wIHOOPL4WfqPm1ojc7SUPe3o=;
 b=Zi1KL3K2pmaDc6mqVANoBhpqA9sWsxsEfgZCaYkfscjf+NSfuTEgj34TzBb/R37wBxknDZbQq4Ksx7rY7Hb0H6QcdzsY5p4+Xy/rqGz2haVSiW5d/LdlE5s5dLQSSoBmYmQIScf85CalOxFv+dLYS0TpUQ8vg02CkhnUkdTIqjNxkpnYZWr9gpdO51hcwgFS3RRWegjnU1m5WeHY53FFT1M9MbKFcIxMonGKuF0xbGs0BohA6uzIBygwtoHMpxaqQUQwTik1/Vmmpj03WQ6XZhUzlFlj/wf+vJ38Ofwc0PFbmOzxp64Xk1A0NlNtQ3T3jMvLBvWDl81bhn0AbWqNPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB5724.eurprd04.prod.outlook.com (2603:10a6:10:a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Sun, 6 Mar
 2022 01:01:52 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.020; Sun, 6 Mar 2022
 01:01:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 0/4] add skc_to_mptcp_sock
Date: Sun,  6 Mar 2022 09:01:33 +0800
Message-ID: <cover.1646528337.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0059.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d33284ec-346b-402e-0267-08d9ff0ce60b
X-MS-TrafficTypeDiagnostic: DB8PR04MB5724:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB572455B43C22C952A5A5B610F8079@DB8PR04MB5724.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BWkpiFlHzi+ak/Qq6iNj1Pvboh3ZHHF4qOrVRGf7UAS2tYmq92KP2/c7HnRnZ0b4/VKeJDm1rIywT4Rqz3uL5zYBa+kGsU1yqnq5UscxbHIJNGjBkU3FJEknU6KEB33Y0bwstLhBbL4uZpvkQu/thXKaoSYh24BWC88/fsnlZyw7ZWFQ7DJj31iIVsPfiuElnXnPIfdkP4p0/YW9fY9W35r6F/9KmYV69+jN7LlaXWmwm1idz1yPHIY1WGrsLzKpBBQQqRziHe9EXZ8Vncj/o3s1uC8Ux0dXRNSBqEbxL0ciugqj9hvAz/VxjS5q0jwNlgkyX7PxalDghe+j3Em15a6uI5nSOyvgNOFuBxNoayClOoO4ofiQLv1JTarMXlr06ETtXVV2dyPK6pS1VOZevNE2QUKKqI/PzN/xAPaWqDPUxpY7s2kPWoJimThzuC3d+Y5jkmm+ZCrGcovvzPPZzEKxc4ciyed1SHUwCBnbswBQ+k15BqVLuEs1K024o4pcylvclQ+a9EbGXsa9jXU01TN1BrQpPJSaSKNsbavTxgl6jW1/0E97FU1ChNCqyo+QsdPZbg27H62az/puYi4l1zy4eBEQDZYlCODr07kxAqJJ69lTD8CloKtgoMICn0o3dtJO/nNPO6XatGhEuMnlrp/V5wDjVbYdFjIESJMyeAvCeSxFQQbZ1MEtWVgbOmWY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(86362001)(8676002)(4326008)(6512007)(66556008)(66476007)(66946007)(44832011)(38100700002)(6666004)(2906002)(8936002)(6506007)(83380400001)(316002)(26005)(186003)(107886003)(6916009)(508600001)(36756003)(6486002)(2616005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vICjWPSV58ayzwa1EKGtAnjVdNde+LYABirh7GjIICmQVh17Md4w7iPtBL7c?=
 =?us-ascii?Q?xJmw8S+kaT+6YeyLjnc6MXM3JleDXtVgij6mZX8QsWY/pm0lYfuarUdSm9jI?=
 =?us-ascii?Q?4i6O3WmKchmtGk5dFxN5WyeORyaZOG8mWPXXSFPUde6cFjEQ0THTuBCDDiVG?=
 =?us-ascii?Q?yUFeKHwKoMv5dnRc+k1qNIZAsTTDjeUcNGjuKc7YgRuGV3AGRD4qKvTeOAjm?=
 =?us-ascii?Q?y+7cUlJYEDVrfH+VSIJb7/8LDlOJAaetZvV7wxPC9+m3ZbrlkCbvsG8QInuc?=
 =?us-ascii?Q?afq4AWEaRH5QKat6aNnwgDu07oK1sD0y4Jbbd8il7tLFiu9soaaerhv1TtyB?=
 =?us-ascii?Q?ZgkK7HoTRg6bus+Cs1E4ggc3WPkDmJUVx6ZnnOZGPs2yAD4SP06IiCOEW9mF?=
 =?us-ascii?Q?7TUKXVfATsBCYNeIXgxH1QqSs0JvY+XzK8TPSUgRqSWwr7lWeorpHf+TemuR?=
 =?us-ascii?Q?xODrL1PVzxu/8xGaKTFr6ip0T8fWxNw4OIs834zbjowogjEjK7+/f8m7ntFI?=
 =?us-ascii?Q?RkdHr0+/9EUH7BfW8cxoUF3iH7LZNZim3VbaEImIxsAfJDU2QYqSlozRi/T6?=
 =?us-ascii?Q?GkX+Bk287owrb+06l1Ih0NevGknOubl/Od/Pi0LAW/xIs40tWHT36DfVDD84?=
 =?us-ascii?Q?WHCWFLyAH1zMrnjy7BTUMOX2uOBcQtOzgM37Ti+M9bUeG3M+qQtGTwOnjd9B?=
 =?us-ascii?Q?rPH0Rdsu1KX14PLCPnNE1vcMeXpfFs1acqEyONFEiO8+Ahn636Pvnc34YKOa?=
 =?us-ascii?Q?LckOHoRwZ8uUrIMmQUYUGrXJGtU+kb0w15AsLBx8pHDQPK4HhD+712iALMw3?=
 =?us-ascii?Q?he9h4cE/FKcu2RqBI2gGw03tWBIZa15j6nVAOlWSt6nU6+Lu9KgYU3KKuhVN?=
 =?us-ascii?Q?rVGZ54U1l4vEuVpqV2C1jYMnp9c0qmEEP3kI7vCYRtTuVzJjyK+yJsNigIgM?=
 =?us-ascii?Q?NSeNggLAQZl0+KMSaIsTFvWwXcWmcbYhEL/JbhEE/JXOK5Kq/ELG+2Eih95z?=
 =?us-ascii?Q?dFQvyBKK/9IULPb92dBuasW+FpYu7DB6DOqQPbAVYNsPE1q0h5+muT3oABtY?=
 =?us-ascii?Q?jA6Xeoood0Kf7L7eVNTEAb9X4MmB3Z+TDfBBcvlhQgiSdJNWbPXVJsNotp4y?=
 =?us-ascii?Q?cOPpw0/DHYFCAL1m0mGbbGLhI1Z/gVRIdLqnHtinOWCcKPSYLzbkNGGI245x?=
 =?us-ascii?Q?CuxarO2RyHMHWgQAdzkCrim6Qe0kXTzycj2Wk98meTHAeJNXw/6tSDTcDt+D?=
 =?us-ascii?Q?iTOCj6LuhY799DxFZdzJRpkO4BZn87eTcKtnjUkQrjPQFFOx6ahFKMY6m/MO?=
 =?us-ascii?Q?DpbBdw3SRIyjaKezbJ3FBcheRc8Z/EZSnSlYQyQMq5RPRyxSd/OcYF/dNRg7?=
 =?us-ascii?Q?2kP+b5PsogQ4pdyIxQeNy+v6pyAwoAtmBtaAi9qfsvnZlkz0pD1KdTwnt6hK?=
 =?us-ascii?Q?KCghuzami92ajmtLKHb4616zb6vRPU8PpTj0VKRMroqbfel3PbWADDxgb3lP?=
 =?us-ascii?Q?hXa9xSKnP76Whz4qv/+t0kmd1HXKUmWQs4AMKQ2F/ObfyJS0ZmFrZWdl4+O/?=
 =?us-ascii?Q?vtnjsyQOtSBC2l72neYGQQw3xZBE4FO8lPtj7sSw160tvxSHhzFyOPPb1E5K?=
 =?us-ascii?Q?e2HYhaVMrvN8F/9BFPuEKPM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d33284ec-346b-402e-0267-08d9ff0ce60b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2022 01:01:51.7088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0ZVeDIjVMt7LWzK+1Kp7MGJDv1tmXj8fJ8shcF5AXeLWOmrBCwEciPtVTtBDELepjJHTgcEC7t3A0zqsKFcRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5724

v6:
 - add skc_to_mptcp_sock helper and test

RESEND:
 - fix the CI Build Failure.
v5:
 - fix incorrect token value
 - verify the token in selftest

v4:
 - define bpf_mptcp_sock_proto as a static function, no longer export
   it in linux/bpf.h

v3:
 - use RET_PTR_TO_BTF_ID_OR_NULL instead of RET_PTR_TO_MPTCP_SOCK_OR_NULL
 - add a new bpf_id BTF_SOCK_TYPE_MPTCP

v2:
 - keep RET_PTR_TO_MPTCP_SOCK_OR_NULL. If we use RET_PTR_TO_BTF_ID_OR_NULL
instead of RET_PTR_TO_MPTCP_SOCK_OR_NULL as Alexei suggested, the
"userspace" tests developed by Nicolas will break.

Geliang Tang (4):
  Revert "selftests: bpf: add bpf_mptcp_sock() verifier tests"
  Revert "bpf: add 'bpf_mptcp_sock' structure and helper"
  bpf: add skc_to_mptcp_sock helper
  selftests: bpf: add skc_to_mptcp_sock test

 include/linux/bpf.h                           | 31 +--------
 include/linux/btf_ids.h                       |  3 +-
 include/uapi/linux/bpf.h                      | 14 ++--
 kernel/bpf/verifier.c                         | 20 ------
 net/core/filter.c                             | 21 ++++--
 net/mptcp/bpf.c                               | 67 ++-----------------
 scripts/bpf_doc.py                            |  4 +-
 tools/include/uapi/linux/bpf.h                | 14 ++--
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  6 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 27 ++++++--
 tools/testing/selftests/bpf/progs/mptcp.c     | 23 +++++++
 tools/testing/selftests/bpf/verifier/sock.c   | 63 -----------------
 12 files changed, 89 insertions(+), 204 deletions(-)

--=20
2.34.1

