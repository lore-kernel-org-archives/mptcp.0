Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF337F
	for <mptcp@lists.linux.dev>; Tue,  3 May 2022 02:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651543662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OvhWp4RKnUM015J53JauzKSDb1BunN8uPTWBC3F2dNA=;
	b=MJ1C9Wc4HullCA/cht60+hjXBKXqUXcpQAN5irmeYSGn6snPe0xP4Cv/kBj3m8ub4svfbD
	6Ty9T73jNOVIXOsnV1KpEfUFitI+ttvR9O4hwz5GeDOlLq25cSHul7Mm1wvOmVo1O5jvB9
	2yqYFFWsezu9XXfc0bZ6uinRpwN+dys=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2057.outbound.protection.outlook.com [104.47.13.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-30-srnbimBIMc2jFrpG62CF-w-1; Tue, 03 May 2022 04:07:41 +0200
X-MC-Unique: srnbimBIMc2jFrpG62CF-w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hd1Ky12yV+qnBmVHitj8gbD8hEZ15QzMw1NQAYqXYmqJ1gvB9TlybzFS4sRSkCObYMJ9HdKDmrYO/nbIz/xCmUfuZ69aXx7+bn/tF1lnC/NSMFDrrTTAT6zjwN7pXZWGrZTXk8uTC1fmwhwGA5kdAegfFrndS5cu7mZRqsy33m7PdWumEMIkpqc2WA+vmWb969VedUioffwzeVY9zpSfZDuTF09T1YASov2WN7kqc6xaZbwZ/jPAglh0MZFtYJ/xr5l6LPHAAuW2STDQaTRNtv/10kf2CDphGN+KLLvapmwdwAWWraKYGFk0TIHF6CPV0vsB7maeulJUxloGEgRI0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77xl6blDJTQWiP3dnuxQ6IKbGLMauQbifmO+zz5Jx/s=;
 b=Z43MJxKbcrHf4KNCCN9+jgwZ0FaJSJidb1kE3ToINNmF+lstBK1vhcwGU+nP4vs1MK/bmKcdciTyldgS6NUiTU4vkNt2VNNZxL3TTDjcLfIusG5T/mfOF0Z9yXcoJBSER65TDM422wLnJv5rNxBnWmqVux9CwYbonjjOSYUlPaiF5DCCpp7ZgKC0qchRSiqV2DgabzB1ACRZgghebiLZHLH4W4OALACXoMgMrc9cW9+COUzz1cqkMF6woU7R5DjHUYG1PKLgmrYwcCUPJqpqyJDEm+puAp18olGV9A0wipY3xq8JFUW2PO1wZ9pDjwuFqnrhtaVUTBePjktCsqd/cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB6364.eurprd04.prod.outlook.com (2603:10a6:10:10c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 02:07:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 02:07:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 0/3] BPF round-robin scheduler
Date: Tue,  3 May 2022 10:07:24 +0800
Message-ID: <cover.1651543362.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0184.apcprd02.prod.outlook.com
 (2603:1096:201:21::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00779518-dfae-469b-d9bd-08da2ca9b303
X-MS-TrafficTypeDiagnostic: DB8PR04MB6364:EE_
X-Microsoft-Antispam-PRVS:
	<DB8PR04MB6364AEC6A5756EB06E0B2C41F8C09@DB8PR04MB6364.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IywhOAqaQ2hZMC12DcCaOnDqoL6cS3q1xYKf8pLwsNZ7Hw0QKcKS/+iAytwrLz6k8zR7PfMLQvtOTc0yr7vTn3Q84JxR8AqgUZUaos2ED391q8qDuijdDh1z19EPNHQexeGrhwqJ2QICtvt1Lbl+X2HMozRcmd6i7e0ElG6GdfH6BDDCU/5uy4dVpWV0bKfD4souGwe+l3ME8GI0wqMrfftYeQEza7flon4bhPXyN286rqFw1JOSG+p4Ahums9HRTTBtbZYm22g3x/0Og4UrzqTuTc3xCXR8VEhm2ngMsV/2mCuCKGpks7KJUy1X1gxUyiPULKF3ko4zP0ffzqkhapA1ge8Vr+e6D0Vs3ycfDhFFbmpvTdtH/1k5xeX1HKn3XS4dkwh5T3qzV6aPGPSkcoGQOMp5DS9wR+u5XSmHWdjqctceOo3xKNzl7b43euIawQrRVfvrZwAEEHj+9NdfZp6AzEkBfmpbFEpEG7qoNHx9LS2h49GsfmjGXb0SdAyVmdKyVSjnTOgrlFLhYqO7wScXyxsw8Y2G40BBo34w9P4y+8115UuJ0+2bhrogHvhSlu02qNYJhdM85TptMHN7IZG2OnhEopBAaKk1VUjvQsx0taHjlspzUefFywmk5ITpGDDNEdlvfjKGA/87QR3GT+bsWHArOPegNs7R59BBsz5eXkRXNWz39EDcmsYOKTZ6KN/Jp9DHL1lFt4O+UQi+NTcdYRuubMc9PmT9e3kGkRwupSwolTVEUXIAgglk3anH47DomN30upEv0yXGnbNIFddsYvf/7OS/6ZpW2pvQ2W6p4p4iZ8ne1Wy4I4yxFIOX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(508600001)(86362001)(2906002)(6486002)(966005)(38100700002)(66476007)(8676002)(4326008)(66556008)(66946007)(44832011)(6916009)(5660300002)(8936002)(186003)(107886003)(6666004)(36756003)(2616005)(6512007)(26005)(6506007)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TB/F3ogOncf3pKcbLWW9rGpbZ2+49a3VSXDj1gcy8EvqDPW65zolQd8sx8Yr?=
 =?us-ascii?Q?Y8aKsnpPfoVqqPoZxvRc9AvUtXwxJ04Q39U7wqbm31NZG2KqvOGByLLcv736?=
 =?us-ascii?Q?47xYrkarHyDNCJjyHJNlXS46oGq4Rxal4pzzXA4+o05FP2oyrin8b5hSmPYl?=
 =?us-ascii?Q?W8N4DDwdvMht2kcDNfGd4C/B21GQQP9Hpqq3ThnwRkg3bAsQCuIa8I70ri+2?=
 =?us-ascii?Q?Vtu8OBAn/tamb070GbVF8pCZbac+zO0gnZ/erfUHNypR6Td901ivOal8WeUw?=
 =?us-ascii?Q?QDmyNyPnylkejYSlQ8FqUXYDDsWVpuuHTJmwDTJ5c9YUy7N52A1tuo78oMN/?=
 =?us-ascii?Q?dUXYdhyc//Iu3oLNLVqa7ROAqBdDTlga877F5sg9IY6ZwLBmU82TY+3Hb16A?=
 =?us-ascii?Q?NKvJrvl2NL8ZjfebPCoO5tT+VpEV87hmclyz4z7lsEHeyVfivEsxDuxKhsBq?=
 =?us-ascii?Q?blAU7sUdgdy3wWPrxFbzValuPw7pEJTVpCBVUBhJ5AMuIu84PS7KK1yFqGIV?=
 =?us-ascii?Q?u/IpTaipUQ/30I9EngMsoAz/IGg1yUZiGKy5Li3mKp4xDCM4k8Pl7nXHNTmK?=
 =?us-ascii?Q?xfu/Ywd71h/+PUV4N0M768r8mPcQC+FS2g4libPcHGcDiQUlJ8rMBPqQMEmF?=
 =?us-ascii?Q?7w/+swFyrClczBOv6bRtk7iXmDeGbHYmu5vzAwkUn+R9TQomoCxlS7p4nzk4?=
 =?us-ascii?Q?+ZgRU14JjmJ+LeXGDobVYk1Yuiah+FDb7HR7fs99oSpKIrT3vmZ9QO8nG68T?=
 =?us-ascii?Q?XcBm5dDzz85gggTtSFc/6hN3gRn3qjPWEvEohdIRpaRLpWjhsJhxTkCc6lMr?=
 =?us-ascii?Q?uaYbJN68EAelviYWDHjSczEp9UtBEuaxdJDuAAd5f32WxCK9+LFquV9QpdSZ?=
 =?us-ascii?Q?lJDCiwSOz/94D+WUO0zZBdydRdKlLCTJDVB3sH+FFMJajjx1a/e9AuGUrmdf?=
 =?us-ascii?Q?MWg6Zw9CbSCL7rUxeEyl7GPE5oawgTHPhyF/EaLhTpMNWt52t/MXfo+lTphY?=
 =?us-ascii?Q?hNCzHDNNxERMnC9NIh/p1lWjVdSDElXJ45JztMmmAPB9NSFCOKYUVHaJ4LGl?=
 =?us-ascii?Q?pz6lU+EQLJUoU1cCf8YYvv9lWa53kPT7MVrRWroO9QhjAqDjQdgUUE4lF44h?=
 =?us-ascii?Q?3KXNuaG6MjpbV0XOzQ6QUpMOFzuyY8Rc8pKx4DmqX7aMUGBzdn8P76AHp9qr?=
 =?us-ascii?Q?ZRvQabo0dXQezX/kocLW+dWqYQV3DegVHxAQ6LHBs6arzaWLCwlTrnn8j5g1?=
 =?us-ascii?Q?ooYEnBF4+OjgLlDXBk82s64zmfirlsKBH18ejxplQOi9BM+puLALrAsP8rYE?=
 =?us-ascii?Q?Fe9SG82BUezcrjHcE+6EU2v5omz0RINJe2C4AN+iIxeX6tfH2gc69PujyKrr?=
 =?us-ascii?Q?vu+Wcysbw/R6OJuNQuIZWfkrun1Vqf5yLw+f64a1qWVTq/VgNxj73wKAqQ9J?=
 =?us-ascii?Q?GEP5SAdvzx8ArVhtInbt5Ij3B4irkfsSsbJIxbJj/91QleQYi1ynZAZ2R5D5?=
 =?us-ascii?Q?O2pVx7WVBLDF6KyKJm+Oo1woRIZKrlzseMPkSLg9zXyE1XGsv4G4rgDQ+aEY?=
 =?us-ascii?Q?6smcGREKLoxbKoP6UezDxNhhfFiDmzxSWbwxz+HWOKbejvrksw8yX7GUxw9t?=
 =?us-ascii?Q?fW4ZaDI87RqwaUDf48E+bzXQBSSt1VlaTgYE7m3mx0gyVBVT0xSnEnfBB1BY?=
 =?us-ascii?Q?n2LAfPGxfXxmPaTAL7onThN4dO3R8vJ+kAf0ThiaW81UbSIbttZiMng4O22E?=
 =?us-ascii?Q?5VIu5E5BkQIwMr7PqY0aIdgVovc21t8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00779518-dfae-469b-d9bd-08da2ca9b303
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 02:07:39.3940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cuoki3lDueSzBpUBrz7oVnNUrONv2EN8Oqm0Ch4h5HLQmeRDC9e4bKkLA0Ec2pFibDk6J3GtGX3xJzdSAZKOxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6364

v11:
 - rename array to contexts.
 - drop number of subflows in mptcp_sched_data.
 - set unused array elements to NULL.
 - add MPTCP_SUBFLOWS_MAX check in mptcp_sched_data_init.

v10:
 - init subflows array in mptcp_sched_data_init.
 - for (int i =3D 0; i < data->subflows; i++) is not allowed in BPF, using
   this instead:
	for (int i =3D 0; i < MPTCP_SUBFLOWS_MAX && i < data->subflows; i++)
 - deponds on: "BPF packet scheduler" series v18.

v9:
 - add subflows array in mptcp_sched_data
 - deponds on: "BPF packet scheduler" series v17 +
               Squash to "mptcp: add struct mptcp_sched_ops v17".

v8:
 - use struct mptcp_sched_data.
 - deponds on: "BPF packet scheduler" series v14.

v7:
 - rename retrans to reinject.
 - drop last_snd setting.
 - deponds on: "BPF packet scheduler" series v13.

v6:
 - set call_me_again flag.
 - deponds on: "BPF packet scheduler" series v12.

v5:
 - update patch 2, use temporary storage instead.
 - update patch 3, use new helpers.
 - deponds on: "BPF packet scheduler" series v11.

v4:
 - add retrans argment for get_subflow()

v3:
 - add last_snd write access.
 - keep msk->last_snd setting in get_subflow().
 - deponds on: "BPF packet scheduler" series v10.

v2:
 - merge the squash-to patch.
 - implement bpf_mptcp_get_subflows helper, instead of
   bpf_mptcp_get_next_subflow.
 - deponds on: "BPF packet scheduler v9".

This patchset implements round-robin scheduler using BPF. Address to
some commends for the RFC version:

https://patchwork.kernel.org/project/mptcp/cover/cover.1631011068.git.gelia=
ngtang@xiaomi.com/

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/75

Geliang Tang (3):
  mptcp: add subflows array in sched data
  selftests: bpf: add bpf_rr scheduler
  selftests: bpf: add bpf_rr test

 include/net/mptcp.h                           |  2 +
 net/mptcp/sched.c                             | 14 ++++++
 .../testing/selftests/bpf/bpf_mptcp_helpers.h |  8 ++++
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 37 ++++++++++++++
 .../selftests/bpf/progs/mptcp_bpf_rr.c        | 48 +++++++++++++++++++
 5 files changed, 109 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c

--=20
2.34.1

