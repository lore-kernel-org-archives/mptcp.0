Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2064.outbound.protection.outlook.com [40.107.6.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9896FD2
	for <mptcp@lists.linux.dev>; Wed,  2 Aug 2023 11:55:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJFFsGi833r+akBEpIgy+txacVvr61ASkZwJz1O5EbuQbDs8oIz3yOsxVOsjSblYK2q9Zgb/4kjiPbVANIplmE78eDIkj0EH8GMPDqPQNf3zUqSKOqE+P8jfd5A0QC+3hphJcXz/r2Sd08kN3JHJT8deVq7AV3U4dJQRX0ULsT4IxKaz43A4NNAyER423wrKJdRy2pa8UPRN31Jd5+QSWlzho2kGf06o+D3n89nfl3qu2eqXf+slvsRK0I8eupJhIaPIbjhZx1ks7RJi99X+Ac7+YSpuj/y3jyEXC53Ry318qpTxmpzOHuYCvXttwHA+1vusitdhqTnL2AhpyjM+fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yEn8TlopC7dVZhwUXv7F4eB0betq9iLVjIFK+o7/Ps=;
 b=JEDJI/0nnHBqTCRJ09kZD//tqdzBlL4O7LES35X0Q9S78R1q9ztuDfKT+QRaoatJ32NplhLXnj+mfq1rDrh/X4rZhsCHUtnHiHhh8mT+GiMTVy8+lH0+ymLPKAfMZa232L9fqNkX1fv7sqiBaRXufamIxHxA5jKC0DxSTca3ZShbRr51LvFItJ4xBY6/Yh018P+icjlIwQtS0SKdyc03opmCAKakqiVBOqHgPc5yLTOlM1jcRBHDKDBsvRKazc4gJ/6HYozcdSDDmqGLC30uiIGuFC8+TZb9BTtlqMrVhiEqzL8ZRBl7WmtACBDxtVs7rlAXMHULqXJSZ4qCY7/a3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yEn8TlopC7dVZhwUXv7F4eB0betq9iLVjIFK+o7/Ps=;
 b=Vjow8n8Y6Pcd6nrN3ln6pHo38rTjI5HY6Z9XcCIbReQnJB4Fv9H+j8ntBpNaGzDFppgu55NnYfS9R1VLs5rwwm3TIITpHLTcsC7o4ChbjuFad6zEjvGO/ihHN2MhaWuENb3Kz5/yGoJY+oZj+atpRS/vyFHpstuZ/TVnD05tS6JlGsZi9xEWq1UEpg3CxhL51Vo+55zatIQk5LaqcY1lOr0n6QVuDzy7oVjkCxhe9HDw9j3nz9QRBNy8c4f9TAADSaYgK9P+aAWt/tuZ9VClYha8ZGHbbT2e081snorurVxwb6Vw1N0flbh7yAOi575wVENr1tNC6uMFdiZQ7JdtvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8023.eurprd04.prod.outlook.com (2603:10a6:20b:2a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 11:55:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::bf65:a49a:8861:4f92%2]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 11:55:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 0/6] BPF packet scheduler updates part 3
Date: Wed,  2 Aug 2023 19:55:26 +0800
Message-Id: <cover.1690976940.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:4:7c::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dadebd1-7ef4-48f4-8676-08db934f5c01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	azZe/Dj5Bx84rFU4VF7PfMFMBXdNpQnvQGug5Zypctbr2nEW/9cqucBHHyufYU1Ss1hZ96J+hmxzlszcpDs2JRARlgfWEv/A19OkNk+9bHmy4wSEIoU0oa5H1EIQLwr+db9bn3qLf1ChIlUT1IcQw05O4zZM4szcjkk9W2dT/F5Yq1Hf79LzcmYua2iJy0yRK8pvKWjOx/8RIkbcpY/icymNUofPe70SYbXx3OICdEivvOCHgPiR+WUoLjCd/DrgI9bU9aNm0IPmwwHMz0ZLj7SBAu4bvYodacnYfeB1Cjxb+1jkjJF6g7dfFmihoVjWK4/4CxT6LI3Xj3epE4o5U1xoiigV37YGg82lkFKc768nRDuz8Vlc+J7y/t9h/TGX1ElL5fgMwaho7vHi3OUe6lLvtgEjq5aRXR+0nfmkT/s63Mn4zajO4DxMrxZVhrSsqzGLuKx7jJFLFmrEtX1vLjfOHHhgXbzYbmnfI/gwOCPChe7zB3DKW/UaMkgjQ1Nz8T6g2VcLBi+PmX7aNgFoFbE+sq59HrL6BIrnqR1ycoynG41MWGPulSySUjKdfZScacSNwJwrcag/YdSI2VjHgD2N6hlCH8i6YlqfN+BqY1o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(8936002)(8676002)(5660300002)(26005)(41300700001)(107886003)(2906002)(83380400001)(44832011)(4744005)(36756003)(2616005)(478600001)(38100700002)(316002)(86362001)(6506007)(6486002)(66946007)(66556008)(66476007)(4326008)(6916009)(186003)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3YCZv/9V2pBDHxJaYB+OU4m6TniJB7P8ayCd2keGXidvsLgSTFu0Olvpup1x?=
 =?us-ascii?Q?C3QN6K+ScXZtuGiYlc2/m145TIHHoT7Nc5jHQPFkPERCjNiCIGDmhK2VppXY?=
 =?us-ascii?Q?uxokHb7GaS9Wh5m8PsqoUXeTWiqX/0pxmsw+DyIOXURmuYLNDmrJO3KqHcFG?=
 =?us-ascii?Q?BX9O2yOve4I7p6nU9/Iwb2sbWPdzY0GFcCZBlUuOFjpzKztV590PKhc8S4Vm?=
 =?us-ascii?Q?c9lcsYoOsbdXYPjiwgopTTQzzEGqeT1kjVFWR4urd2aMMQTUChnudB00HTAE?=
 =?us-ascii?Q?c76Sr6xkAbgv/TjXvgVh0jxnk/Tg4LeLRFZv6UpUVMOYbEkAMC3lA8c9208M?=
 =?us-ascii?Q?aK4eY72A4ROQNhPhsQn1r8sLhlh69YGQWFiE5VyuJdUC++GRctzRqJQcllQP?=
 =?us-ascii?Q?z7lPCu0KL/PlzPP/TokP8OSZHkv59U0J+KaoNd/PPtXaYKMnCShrvKCHqNSC?=
 =?us-ascii?Q?VJ25F8mXUt0uZZ24oqH6ZjzFNJoxwH1R8JMQ7uvPLgrWIgcYxXAoRCywY6cN?=
 =?us-ascii?Q?NYYSVQtvcoXPtzbWBo7OP8WNKuOrZflq/qPqvsK/nQcJtTXEh4wV9BtuWFSA?=
 =?us-ascii?Q?ahqytShc/DinlLnskPlFDFRPK0CdUM6Y+7nt8rCnWgI+AWh90ZdzPU9N/D5d?=
 =?us-ascii?Q?bsqOzfHm337o3Ahz5/mFjs/FJ2eQX8QPyzRegHvZ87vRr0SEFfV5TCZcGJx4?=
 =?us-ascii?Q?I2eWRZeaQcbIBfcHnKmcBnnn+R7x78E85r1yMB2NGNJTh265lnl7AtLOQVp6?=
 =?us-ascii?Q?s3/IEj/EN4XsGcKL+ebPBwHKsLbLTwWpEqFONeRiqp7x6cdEpZ1OE5I1czKr?=
 =?us-ascii?Q?UFLmGTOtNkKU/JrWBKqIWzTb6AYRM0oAyxxFKm04QXjlWKggxTU0BSOw7BxK?=
 =?us-ascii?Q?eOpkhRIauP4sFtz09WB/qRQfDyE5oBYImGN3ienTb98siFB9mkRNP4aeqQrg?=
 =?us-ascii?Q?JhVAs3kZXw1acCuOVBvT2iYFhBAU4yYzZhEKxckIvG5+1w/5bThEFYKeSZAI?=
 =?us-ascii?Q?soOO/yCxWg312BQS1vJOCpQXsipXKbsbL78gJiqQdcoJaVa0m0Mr+E1HA0Qf?=
 =?us-ascii?Q?Rujdc8bjaV6f+sgB+Q1LAlkwQXelBf6KExFnjhIEbWx5gAsuc3rNoYMc1BjL?=
 =?us-ascii?Q?j2SXFYcsklM/MhtDIHI4hlJDXRbflA08dKwLbP59hkOeDq8krlamkVAyneZW?=
 =?us-ascii?Q?AfNpPdrTb+DZg3xlYL8PJfGwMBVgDFSObRTpvj9U5nII1BrgCcCOPe+PZ/GV?=
 =?us-ascii?Q?d1A8TAIU/zoURKw/MH8VbmHcJbZr3umusEmaGZxOVLAkQGWPk4aVlkFQdukI?=
 =?us-ascii?Q?yaLOIxCMzySN37mxoFZtNNDOBBreobHJbw7BRW+va8O7ddhzwgU9aIshQN6r?=
 =?us-ascii?Q?FJTv8g6+1DbDySSvvg5w4/+7qr9QsMuuQIJ0Y2jaEyXJdu/Qj8F1KItrY9ma?=
 =?us-ascii?Q?bSLrh1590ElaYLpFFM+lsSGtALvy2R2j5gg0HssN42xUMoEp02XwqFax9a/Z?=
 =?us-ascii?Q?6GOZFfY3LppiH8jN2yskaPzjxFNqs4Aat8FbhKVJ6hlr1Em0P5nMFJvTDOFM?=
 =?us-ascii?Q?waOCmuAIaWCznR59M+TCbmKsMsWXrPczgWcqjVK3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dadebd1-7ef4-48f4-8676-08db934f5c01
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 11:55:26.1024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7h8GsWidDaTgHTi0wpEBWuTmmijHQEp0ZFKorkKm01X2l5VYfGWvcA+i9/Nfjr7X3d2kuTYjh2+A5wTwW7g5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8023

v2:
 - use __always_inline instead of inline.

Some cleanups.

Geliang Tang (6):
  Squash to "mptcp: add sched_data helpers"
  Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
  Squash to "selftests/bpf: add two mptcp netns helpers"
  Squash to "bpf: Export more bpf_burst related functions"
  Squash to "selftests/bpf: Add bpf_rr scheduler"
  Squash to "selftests/bpf: Add bpf_burst scheduler"

 net/mptcp/bpf.c                                     | 10 ++++++++--
 net/mptcp/protocol.h                                |  6 ------
 net/mptcp/sched.c                                   |  6 ++++++
 tools/testing/selftests/bpf/bpf_tcp_helpers.h       |  2 +-
 tools/testing/selftests/bpf/prog_tests/mptcp.c      |  1 -
 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c |  2 +-
 6 files changed, 16 insertions(+), 11 deletions(-)

-- 
2.35.3

