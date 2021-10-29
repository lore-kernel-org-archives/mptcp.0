Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231CC72
	for <mptcp@lists.linux.dev>; Fri, 29 Oct 2021 04:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1635482430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b4g01QnOcFQ/ZxGYd8iM8AkjVgeaQEKXNuu4JrRcYq8=;
	b=lH6ZFEZvGWfr0KZRqK8jYRUfz1BTFopS/RFuFbeC9uxXFHM3x+WMGx8A3VSyk4DhqePCF2
	nrc6PF5rLExAArbZuCPKUt36ra2mglpV6UCpCV+zRuwn8/pjYNDCCMFlpxlGE0LvsMFrDv
	bmPzZZDrgIQT/hOffyoWjw6bCAbn3ro=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2107.outbound.protection.outlook.com [104.47.18.107])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-6-m53MxJ_FOgeJnEnYR-gUQg-1; Fri, 29 Oct 2021 06:40:29 +0200
X-MC-Unique: m53MxJ_FOgeJnEnYR-gUQg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZmnPltRYceHsgMb88f2K01+AEgQVVlvENa1Hqw1rSA7/kEQ9XUCgNJMEX+5VWa7WJMfd3Mg9bY8w0pwwCs3L3ucHRlzQcWdCINZgaIEU5HPURbHhzU388v+k7DEmTmG0LONOoi9u/7yoiGTTMZ95kmnwGoJXU2oqVVah8A2l8JLOs3Zkmuw9ApB63w7kM3fDXi/UuCDoPNKNtFZpXa0YDvHj/FZFMbmA4BOwyTEDC0D1t3dUhTEuORIQikA9dqTcnCvTm/H7i2iCWVAAPLMtQElEQbPXBK9p7xQmAemUsOYCcuDQwEdwRSkJTHgehjGhHOg7AbXQ6+aSBOWjqdaOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IA9Un7L4QvkrOoZNMTI5t7eoqC0RH2bbmke6ijzsQCw=;
 b=Ly9JiBxu1agswPzRQljVpInhbGIuH7ImQCDh0HrID12ga6reM/rW7TAsDhCK7l+hX3lGa/++NcZHTWQu2K3q34xbHZ3rDc87e6BTFDZuNCI0AXAdTlWPX7bzdUdA9PjcHhAwHUTu166zFvGzm/BFIeNJZxur3lUCODmjWQJgJV1BsdNuC+yMpFe6BrbCZXNyq9L8CMcwvzRIJv25Zog4SXLPDjzJlv6BPH74Mfcj/0+4DWuId3uKe1ePRDfFyggdO5deMBTNeh16fGZ9iRKXkQC2s7M/d52mGenK2jzW/3JRRkWn+j25hkMdv0KuJPhDS8CpL+itR5KCjZEIYmMmBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2652.eurprd04.prod.outlook.com (2603:10a6:3:83::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Fri, 29 Oct
 2021 04:40:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 04:40:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 0/8] The infinite mapping support
Date: Fri, 29 Oct 2021 12:40:10 +0800
Message-ID: <cover.1635481641.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0198.apcprd02.prod.outlook.com
 (2603:1096:201:21::34) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK2PR02CA0198.apcprd02.prod.outlook.com (2603:1096:201:21::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Fri, 29 Oct 2021 04:40:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50188754-0e1a-45d0-c986-08d99a963b2d
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2652:
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB26527202F2F941AE54C0FC09F8879@HE1PR0401MB2652.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fEoVkUwYhXKog83gh37kAIfmVRsuaMxaC5Uv7nEJ4ZJpJBnNSlqFRaATV3ca3btRCtdR9AzRw1y5p7PmFDecq1xZfN44eNYbEQxXoWqH++YSWyk9omTXupTjhJIicV/Iai+95K2T+7Ini/xNf5PqJngBj49mQTKaFYSfPjg2c446eVC5yJnHEXQ83c/E1gqg0qxzy7OREIAc3IUMnsmFPGgnjJh+TQUW/TXF8KvVxApy5nLsuszl3DrOpzPCq4Z4Y4Vs7REUECv2472T6tYnTFcVljYFW6MNMqeWu0fdahHiIO5C1bJQr6Y3pi4QJJX851899N9HPrKcQpkeOynYtGrEBxNnp1Vcjsxl8RG/GGEhuHDvhIXm2sa60+O07nvI+hslTDYmoU6ALbf+cduM3poD+aVo75VJUeUxBL3/da4m/MQEE5FCha98TUw4TaO0XS8yRC89+h45Y5TbeRTZ05lXKGqwrQQrNuVgiSmVqdWrot/5uftdZtN81E5jFCfoNsyFNVi8QKE2NJhVugaolyaoXpZEFjHT/hDyGr+svVmRahr7LerW+JwtOOuhJJafZIjFVWICo39VMQ3IJh7xtK5ACsGWh3jCDLCweBh06CPXISErH9m+p1QqcGJma6qIdNwGewVLVmhumuIA3njo/cMW6DV/1i2bw43D6k8CnxCCyg7z1FFGJzTze7jjj60b7e3J/QEkPr3c/MEj+gItBzqwUFBfdy8+BCSKfbEMcME=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(4326008)(66946007)(966005)(316002)(6496006)(83380400001)(55236004)(8676002)(66556008)(6916009)(6666004)(2906002)(44832011)(66476007)(86362001)(956004)(6486002)(8936002)(2616005)(107886003)(26005)(36756003)(5660300002)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ewn18bJ5i5aXeWxOfW6crgM8Gly7U3tMZPNursCaYQ0BuZCjntBIkuQGHsjM?=
 =?us-ascii?Q?FpP2O2yjeBlKF+TSn1V7eUOa573oxQELD9TW3ETG/XFHzDbdasDRf6KqBfEj?=
 =?us-ascii?Q?Zsj2sYoD+kWurcbA8rzEjBpVrWorGAIqmCWJt83azmaq4ss+twxxn1HWCCik?=
 =?us-ascii?Q?oFYMtD51EWsBKBSTxFfgDmSflzo5PDJAQioMIA/snFSGGGlUsKzkJFKUIBCg?=
 =?us-ascii?Q?Bs51FYaDTGTLvcnebfUdptvipZUfV8z+Qe/fTm6JNJejz0rWioZ6m/zi//fe?=
 =?us-ascii?Q?9ItB9hf5hoxZXcgUMOm7L/ju7B1QDcgcnecZWIFZnPhVjx3kvbwEZd5ykaZ0?=
 =?us-ascii?Q?dJWbu2/YunNP6Dv7+AFov41wo97639GHP4e+i/2sQo1a3sDzj5ZfWCAkhmzH?=
 =?us-ascii?Q?wnFLrxtjmNhL85nNdZjbEHRdZ5T7CzRyztd0xoHMXbD6b4/7SlD9s8+Gq3/b?=
 =?us-ascii?Q?rClOnZfoihfHCNi9OGUAEoNQkHYzP6fd3e/Qulzgjj66bqhKf8ahxvBu5E2Q?=
 =?us-ascii?Q?fyQZ0VWMUuxuyraeIJBKk6rPbV4cHt4JaXAETtByAXmvfYZh1/uSZ9xNu5Dd?=
 =?us-ascii?Q?ZLjlpr91l0/rfdCNY0Ij8caUD8IkfpeVlmIB/aaG4r+IS+FNxXLPcyW49DVX?=
 =?us-ascii?Q?8JhByQTYKjF4wFkMSouDNjZO6hrTuECX2j+E9sVzbPg31GmIclDY5F81DLGq?=
 =?us-ascii?Q?P4FiJnC10VwitBMSCascpzcwXL+3TH6m+6Vpx3WHtNIZPWib4DwI1D1CZ0NZ?=
 =?us-ascii?Q?P60NEwKqSLVist5vyCJhG8EgXshuizieT2Tw9rDTPX2X7IWSTFcooYBvtJG5?=
 =?us-ascii?Q?WGclb0E5jvGj9328HbiCx5m0UXSYgdRdqAoU8yGIOVr+/AwIfcQ0t1WwPFyS?=
 =?us-ascii?Q?eAt1gTJfd7YjpdCY9thLgESecrZd3bci4VBOnIiTkKw98mzur6hgeX5NGxxf?=
 =?us-ascii?Q?+J7gyC5bXKWfVEqDzGH+zbuMDGPM7ypBnIgcq81/SiClTHO/4G8BImKIT4fP?=
 =?us-ascii?Q?hrH/t9vAW2DxLSoPUm1kPCBhB9jhTwDKPXFcThggVDeuBNfaag7wMM3Stl/X?=
 =?us-ascii?Q?irTOnznzvXcEBmK2pm06T5+f+D4twV9BJFWkk5wWqjR69c6S2L8eEXdzWXM3?=
 =?us-ascii?Q?4tA2Uk4fQF7hehNQTJKXRcmybzaij0kxnrlvyKr7m02iSsWJnjKtiGTKIGIu?=
 =?us-ascii?Q?jSSZisb/cBc0ywDI+S7vOoxaiw04L8A7+oJRuto+ay8+ZMMGzks0qnmpV0Y7?=
 =?us-ascii?Q?4V/psy6j0BE05Xmv15Uvod/WZUGjHrgarnFyVYwrXSXPnzkib6VSoLnMXqa6?=
 =?us-ascii?Q?055HaIdzhhxDUffqT4x1nE6ibkNSo7p4hcBJrO5HSfcnYmJctm57AZwsujgE?=
 =?us-ascii?Q?ttmn+I5crtEjzs/HoxaX04JHvGQSmz40AxWHLkZBue3JPpFWUgSTkogu/NUo?=
 =?us-ascii?Q?Xqk/z2XtKY23Jb9ucdeHGdNbB8vGVWZOUW5ZKnGq/+FkDt3S0of/2pNBRjzh?=
 =?us-ascii?Q?4DBLVnYV6Lr1YnqVwckM0e7XQUM8/6vpAxrGfUq1QdhFc2ZaQnEA8iqJRsxb?=
 =?us-ascii?Q?hZeoMzFOos4fl+fzWAi4i3p5KPD+mvamOynFg0+hYbujLUef5IhAhnQRUJlC?=
 =?us-ascii?Q?HH92tHl7YFC1IvvexUpRFZA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50188754-0e1a-45d0-c986-08d99a963b2d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 04:40:27.9756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8g2GEMEQixUh1o5+9AhYHifoxYVEd+JiEEKG/rHJWKgL2cjU4YG2zvTskxSzQb7xeNWDSP+jCjsDGCgUtPtcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2652

v8:
 - Patches 1-6 are unchanged, only updated the selftests scripts.
 - The patch (Squash to "mptcp: infinite mapping receiving" for v7) is
dropped too. Since this series only implemented MP_FAIL in one direction.
The TODO items, "MP_FAIL echo" and "MP_FAIL retrans", will implement later
as new patches.

v7:
 - drop the patch "mptcp: add last_ack_dss_start in the msk" in v6
 - set allow_infinite_fallback to false in __mptcp_subflow_connect and
   mptcp_finish_join.

v6:
 - use allow_infinite_fallback instead of last_retrans_seq.
 - rename mptcp_is_data_contiguous to mptcp_allow_infinite_fallback.
 - rename last_fully_acked_dss_start_seq to last_ack_dss_start.

v5:
 - move last_retrans_seq from msk to mptcp_subflow_context

v4:
 - update patch 1 and patch 2

v3:
 - drop MPTCP_INFINITE_DONE flag
 - drop MAPPING_INFINITE
 - add mptcp_is_data_contiguous helper
 - add the fallback check
 - The u32 target testcase has not been completed yet.

v2:
 - add MPTCP_INFINITE_DONE flag
 - add MAPPING_INFINITE mapping status
 - add start_seq in the msk

v1:
 - add noncontiguous flag
 - add the mibs check
 - tag: export/20210904T080009

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/216

Geliang Tang (8):
  mptcp: don't send RST for single subflow
  mptcp: add the fallback check
  mptcp: track and update contiguous data status
  mptcp: infinite mapping sending
  mptcp: infinite mapping receiving
  mptcp: add mib for infinite map sending
  selftests: mptcp: add infinite map mibs check
  selftests: mptcp: add mp_fail testcases

 include/net/mptcp.h                           |   3 +-
 net/mptcp/mib.c                               |   1 +
 net/mptcp/mib.h                               |   1 +
 net/mptcp/options.c                           |   2 +-
 net/mptcp/pm.c                                |   6 +
 net/mptcp/protocol.c                          |  22 ++++
 net/mptcp/protocol.h                          |  13 ++
 net/mptcp/subflow.c                           |  56 +++++----
 tools/testing/selftests/net/mptcp/config      |   5 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 111 ++++++++++++++++--
 10 files changed, 186 insertions(+), 34 deletions(-)

--=20
2.26.2

