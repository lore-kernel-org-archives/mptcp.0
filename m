Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54E77B
	for <mptcp@lists.linux.dev>; Tue, 10 May 2022 04:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652156635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kXPz2jL6hNk7P9k6UZB9ZH0rCy/Vj143G1gLWCSM6VQ=;
	b=R6Zk5tO7b0qpE5ZF1uo1Gv8yL9Jb1MR6n7eR5l4EiM+ON1PMivpW8r9TeX4cWf4cDo5//T
	06YlAOzhfuS9FsTbBp1p11KAI6uL8wLgO4d7I6DhYtR+W/BfkRhBg6oq6dCMS1bbGEnstS
	fYGz80Y/RnuJfRWXf3go81V4OMNFquk=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2053.outbound.protection.outlook.com [104.47.1.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-11-atXRJWomPEGqm-KDMIargQ-1; Tue, 10 May 2022 06:23:54 +0200
X-MC-Unique: atXRJWomPEGqm-KDMIargQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILEx3cEmF26Y41sDr/aYcPycfIjg7Ve7iLXjQqY3abbDh4uEP1Js0EB6MqL8NqYSTGe06xKdby7SrAvSXgmshXKEp+4vXUWiAcaSewUjSm9zg0ScnU8AgHOXBrN4omrWExLl9Af3EnU4FWyEQaiGACHkx5X2MTbm57DJzMkO3LXTe//+KSIc57Ir7XYLm9YfggyJDSmEStUFMTQe0sH7WvbdQCOj/qZMxyOf4MlgIqaf0nmIwVXxjcDJ3i2Yz149jHRcTT+odA7l6zF29kKzQggpyDCejHQqQ4L6uJV2JSCIJjjAwxRup14TiGg6Ekj2TLpp9nufA7yVM9m7IxQlKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMRJ7/Y4IknM3+RT68rpk9rYgqQ3G/OUin0QfW3zkSg=;
 b=GZY31PijuXrxMId3yoK6HqnvPBW0ybOoP8KAJS8lHOG8VTG2xPJqpP1vvzjjq4dCkroPvG/IHZ1YtpSYeb6ZB72C+Tr3MTE/dUmYK8wcivxQfWRs4+7eGDDQp64/yoVH8IGnmsoIcSO4kNMZfTWCPeAOx8IvTc+FnaEUXb51ZaegFWuWpRp3p0cmj0yEe6xkpdjFTMixaPog87xDYmen+69w+RSjeZpijCuVm+Oa8cNfcufFfvthZ07d2VGMdoueX6I4zWkBkLCSf3m21IGtJuS/dLFq4Qg3P5wfEv903Gqvm18LxLT49DyryB810+T2OQ2hfmCkzHrK2GEEoKAoYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by VI1PR04MB6224.eurprd04.prod.outlook.com (2603:10a6:803:100::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 04:23:53 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::b5c8:f15:91fb:33f7%6]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 04:23:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests/bpf: test bpf_skc_to_mptcp_sock"
Date: Tue, 10 May 2022 12:23:45 +0800
Message-ID: <6de915f94665491d2944dd7aab1e6f7a0f3abcaf.1652156539.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:203:d0::27) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93fa9282-1fa4-4f44-1857-08da323ce36e
X-MS-TrafficTypeDiagnostic: VI1PR04MB6224:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB6224975DA4D0405C87033CD9F8C99@VI1PR04MB6224.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jZ3QYTxJhsHRzvgpr0e2oQwkm4Mp7rMyPxmq2Hrl3JGxVXtKNUsQCgDG2KHuktUNsocUlrYrnwF9ax1U5lNWo3Pkf/Zh6DqX6u5UhWF0Rkgyu+IYH5hlCnFf08p635i3QLT2jNB5bKe+q6p+uTZvNaFUK6JQ4CuyJ3gIQ25aN1N53bWhqtU/kjxOeRLFT884lyyj4XYXRFPoYKStshDQ4bhz6m5wJ+z06LWvXcUvWUu4hYAV9z4+0VkjqxumNhzn8ywg6aX4JFUrD5JHbGFXs/qyglDqSd+TfxSM/XRq+UqeE55nx3fZ2kIqhKO5LT8qVLHqitAqG3kVDY3Roq18UZXenak6VijDrY0L1HJUToVWiAdg7bxOZm1cGmZSrc/3nyljhwSip1yAmP+QiSLtlo5MWaeWnvX32Q1hytNBGwJpOVcfp9ipwmniICo16cQGqUDg3CpDYziqJ9wBRWObfRjI/ilmwRRsb517mr+U1qWgeTuzj5eA/Y1Aq43o5YPa5Dc5QiudpDNlJx+IWgVBSRdG36xbVJyN9Nd/ReZchzBttD++bR8czbr43chHVsUzFMhOEFwc3hatyQLGXLzNud6BkheDcaR5JJfXcQQM4uenF4MlSrlOiG138CTyAL1A1+OGiTsaonzr59zXbpP5mZfsA9MY59R6He4BHPMnN1/lhgRKvlqvCLavFdVop152
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(107886003)(316002)(66556008)(8676002)(66946007)(66476007)(6916009)(26005)(38100700002)(2616005)(4326008)(6512007)(86362001)(6666004)(2906002)(83380400001)(8936002)(6486002)(6506007)(5660300002)(508600001)(44832011)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IAy7A0PtnD0W0nxxbDFiYWqGMQ7k3qfCtOCl6BWV9VRpetPs3MRMg0vlbTv3?=
 =?us-ascii?Q?QVACMLQ3VOTlRGIxHvyv3wHsZSeJywP0CTfI6IbsvpewCfGIiKaLaqndR7+r?=
 =?us-ascii?Q?OBNJCk+6J2edQyUo600Dwq4m5D3wJ1fCkEuVtfdiwG5oez9pMkUj0zmpb4cp?=
 =?us-ascii?Q?w+p8nRmHgmEnnJyS1KDnhXSXjANgCP6ro4+QubuJHRtGFvsZtxnUuj+7o1jy?=
 =?us-ascii?Q?wNO/fNh2QCpQmDIyoC2edcK9PoUfkQ2zIQNWsYuwxGqb311SsI8c9P/qE0tC?=
 =?us-ascii?Q?mldayy/wMS1ZmufLogl3P/1L+f1OZXU9BILfuJfvz+fQgzmXYF8flXTq3ADU?=
 =?us-ascii?Q?8wQ94F4g7lX5w5y48zWIcZagpiO7jOxiTWk6Ky4/89DbT0GQ+ENSqMKdE8/6?=
 =?us-ascii?Q?Nv3wQhhPCqDaJsAmupkQDxVi2fasCTdjCOBWed49TmfhxHZ3S7iwfP1EqGiD?=
 =?us-ascii?Q?S6KmL98L94mrJ/NBzpU0WQqeum5In4mgm48uJge6urWBbJwlFKKLX2NFn4o0?=
 =?us-ascii?Q?cKCe0A1338k6JfecAYzIR5S3bFb4iEsi5G0i8m3FJ8OBpYKboRvsb+yZ4y0N?=
 =?us-ascii?Q?QpABLbADrLoXse3GG8AzwBgXsVb5eL1FPNdHJEe9WBzhwiCBTVyCbQ1zSNZU?=
 =?us-ascii?Q?qofZ34iPphTHQM0og+EgpK1I9r8KeOTj4MmZ2HXV/s67jk9Tj94dnqSN3FgW?=
 =?us-ascii?Q?DFhLTLnn+0T7+1d2Lhfy2NvF3Naws/MyWLnsXn7mXQc/C6U7qu+6xxzAGO3Z?=
 =?us-ascii?Q?Wgbl6xglTVvK/VOsVd/pukPKir2OMJCMAIDZ8MIMYpp5nWcZ6rkeZrIq1/4M?=
 =?us-ascii?Q?cWCaoQkk5/aU8PEe+uAO59n6rldBoQbkVhHLm+tFC9eML21f4PN40yzCsbLq?=
 =?us-ascii?Q?JNkU1tEjYFU9sJp5/2wI7pq00yS/IOG7Uc0QVPMdTdel4EF5hzPt/2ENJfsC?=
 =?us-ascii?Q?aPIx6Z41b1YTP2vVT/X2rCTMF5WhFHtHw/q99pPZ/2orW8QH647QBnFcmgIY?=
 =?us-ascii?Q?GPCthEbmRtlINmeu9z/AJMLTc9DTbTdyDWEDLMOpxcXj7pWq2VTbO4MAwShW?=
 =?us-ascii?Q?cMBkl6T1daoIc16rSSYLQKGPfzy9G/Tnbg/TBPgVYOPrRC2ELiFWNJDUgSP1?=
 =?us-ascii?Q?VK4h5wLrbouJ7N3T0E6TDxS1H+smGloJuO4Mz6NPdDwswsm9Y4OasZHEhQNk?=
 =?us-ascii?Q?owspvbs3BPrFzShaCtcAWJzZqfZoFlajDJEhb67cqOZg1jfvp44CbCRk4Ysa?=
 =?us-ascii?Q?8N9d0tubSy9gsI+AAf3EUIpHK8XQ1fgukXLhyg7i6/ZfmB5z2f0M6dAdkJxM?=
 =?us-ascii?Q?3hl0xQqv+0CXrEWCe0Y5usqMjR6pP2+FeFUCPM7DbPIr6uVUmIbVbvBfcvl5?=
 =?us-ascii?Q?yF4ekm4oS4W0KNto3ciqcUGIf5UqizeZY0uPfrI19Tnlw3ccHJ7AwUQqvIqa?=
 =?us-ascii?Q?HVLvU8RCXo4NcmmlWyThZST36H8S1B1INn8dnaF3S9O9QgTTR2kQqvWC4bo3?=
 =?us-ascii?Q?0GaAfKkbiZV9zbR8ga0q3XWua4VTsHeJiKIj0Tujj1Q97XyZf9CbRT2RqUCy?=
 =?us-ascii?Q?nF2fttDNyLPhyyU8gGE+V2zLkHc/JuarLyvt2CYS6O1fjeKZJjvgErgqEXXX?=
 =?us-ascii?Q?vuRR1OvCQwqz2Q2R+ouAKBFJnPe6MK3W1f7BecRO+MaeJ1xd1Ej7e/N9kLME?=
 =?us-ascii?Q?poiOqagELR32ZMdbMM3qmX/Gp8sbZ+i8ReLsx9k804CJ0UXSrwrkQ7f4LsWc?=
 =?us-ascii?Q?cV/UKfB7ckmKOclrY12T8gHOkF7KB5g=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93fa9282-1fa4-4f44-1857-08da323ce36e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 04:23:52.6415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22CCfYh/9iSG+N6+SBTAC+Ylmtx0f59U/23dUbC8wo0PaeruAbqgpvFSokMbTAITKgC7snCILyYVn2iKMI0GzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6224

Drop bpf_mptcp_helpers.h, squash into bpf_tcp_helpers.h (Andrii)

1

CONFLICT (modify/delete): tools/testing/selftests/bpf/bpf_mptcp_helpers.h d=
eleted in HEAD and modified in 8996b41ffcd2 (selftests/bpf: verify token of=
 struct mptcp_sock).  Version 8996b41ffcd2 (selftests/bpf: verify token of =
struct mptcp_sock) of tools/testing/selftests/bpf/bpf_mptcp_helpers.h left =
in tree.
Auto-merging tools/testing/selftests/bpf/progs/mptcp_sock.c
error: could not apply 8996b41ffcd2... selftests/bpf: verify token of struc=
t mptcp_sock

cat tools/testing/selftests/bpf/bpf_tcp_helpers.h:

'''
extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __=
ksym;

struct mptcp_sock {
	struct inet_connection_sock	sk;

	__u32		token;
} __attribute__((preserve_access_index));

'''

git add tools/testing/selftests/bpf/bpf_tcp_helpers.h
git rm tools/testing/selftests/bpf/bpf_mptcp_helpers.h

2

CONFLICT (modify/delete): tools/testing/selftests/bpf/bpf_mptcp_helpers.h d=
eleted in HEAD and modified in 57dcfb6f61ec (selftests/bpf: verify ca_name =
of struct mptcp_sock).  Version 57dcfb6f61ec (selftests/bpf: verify ca_name=
 of struct mptcp_sock) of tools/testing/selftests/bpf/bpf_mptcp_helpers.h l=
eft in tree.
Auto-merging tools/testing/selftests/bpf/bpf_tcp_helpers.h
Auto-merging tools/testing/selftests/bpf/progs/mptcp_sock.c
error: could not apply 57dcfb6f61ec... selftests/bpf: verify ca_name of str=
uct mptcp_sock

cat tools/testing/selftests/bpf/bpf_tcp_helpers.h:

'''
extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __=
ksym;

struct mptcp_sock {
	struct inet_connection_sock	sk;

	__u32		token;
	char		ca_name[TCP_CA_NAME_MAX];
} __attribute__((preserve_access_index));

'''

git add tools/testing/selftests/bpf/bpf_tcp_helpers.h
git rm tools/testing/selftests/bpf/bpf_mptcp_helpers.h

3

CONFLICT (modify/delete): tools/testing/selftests/bpf/bpf_mptcp_helpers.h d=
eleted in HEAD and modified in 416cb433f1df (selftests/bpf: verify first of=
 struct mptcp_sock).  Version 416cb433f1df (selftests/bpf: verify first of =
struct mptcp_sock) of tools/testing/selftests/bpf/bpf_mptcp_helpers.h left =
in tree.
Auto-merging tools/testing/selftests/bpf/progs/mptcp_sock.c
error: could not apply 416cb433f1df... selftests/bpf: verify first of struc=
t mptcp_sock

cat tools/testing/selftests/bpf/bpf_tcp_helpers.h:

'''
extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __=
ksym;

struct mptcp_sock {
	struct inet_connection_sock	sk;

	__u32		token;
	struct sock	*first;
	char		ca_name[TCP_CA_NAME_MAX];
} __attribute__((preserve_access_index));

'''

git add tools/testing/selftests/bpf/bpf_tcp_helpers.h
git rm tools/testing/selftests/bpf/bpf_mptcp_helpers.h

4

CONFLICT (modify/delete): tools/testing/selftests/bpf/bpf_mptcp_helpers.h d=
eleted in HEAD and modified in 74d3c74494e6 (mptcp: add struct mptcp_sched_=
ops).  Version 74d3c74494e6 (mptcp: add struct mptcp_sched_ops) of tools/te=
sting/selftests/bpf/bpf_mptcp_helpers.h left in tree.
error: could not apply 74d3c74494e6... mptcp: add struct mptcp_sched_ops

cat tools/testing/selftests/bpf/bpf_tcp_helpers.h:

'''
extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __=
ksym;

struct mptcp_sched_data {
	struct sock	*sock;
	bool		call_again;
};

struct mptcp_sched_ops {
	char name[MPTCP_SCHED_NAME_MAX];

	void (*init)(const struct mptcp_sock *msk);
	void (*release)(const struct mptcp_sock *msk);

	void (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
			    struct mptcp_sched_data *data);
	void *owner;
};

struct mptcp_sock {
	struct inet_connection_sock	sk;

	__u32		token;
	struct sock	*first;
	char		ca_name[TCP_CA_NAME_MAX];
} __attribute__((preserve_access_index));

'''

git add tools/testing/selftests/bpf/bpf_tcp_helpers.h
git rm tools/testing/selftests/bpf/bpf_mptcp_helpers.h

5

CONFLICT (modify/delete): tools/testing/selftests/bpf/bpf_mptcp_helpers.h d=
eleted in HEAD and modified in 1b3d7a5f1f10 (mptcp: add sched in mptcp_sock=
).  Version 1b3d7a5f1f10 (mptcp: add sched in mptcp_sock) of tools/testing/=
selftests/bpf/bpf_mptcp_helpers.h left in tree.
error: could not apply 1b3d7a5f1f10... mptcp: add sched in mptcp_sock

cat tools/testing/selftests/bpf/bpf_tcp_helpers.h:

'''
extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) __=
ksym;

struct mptcp_sched_data {
	struct sock	*sock;
	bool		call_again;
};

struct mptcp_sched_ops {
	char name[MPTCP_SCHED_NAME_MAX];

	void (*init)(const struct mptcp_sock *msk);
	void (*release)(const struct mptcp_sock *msk);

	void (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
			    struct mptcp_sched_data *data);
	void *owner;
};

struct mptcp_sock {
	struct inet_connection_sock	sk;

	__u32		token;
	struct sock	*first;
	struct mptcp_sched_ops *sched;
	char		ca_name[TCP_CA_NAME_MAX];
} __attribute__((preserve_access_index));

'''

git add tools/testing/selftests/bpf/bpf_tcp_helpers.h
git rm tools/testing/selftests/bpf/bpf_mptcp_helpers.h

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 MAINTAINERS                                     |  1 -
 tools/testing/selftests/bpf/bpf_mptcp_helpers.h | 14 --------------
 tools/testing/selftests/bpf/bpf_tcp_helpers.h   |  5 +++++
 tools/testing/selftests/bpf/progs/mptcp_sock.c  |  2 +-
 4 files changed, 6 insertions(+), 16 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/bpf_mptcp_helpers.h

diff --git a/MAINTAINERS b/MAINTAINERS
index af0d6a8543f6..56f5dd17859b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13787,7 +13787,6 @@ F:	include/net/mptcp.h
 F:	include/trace/events/mptcp.h
 F:	include/uapi/linux/mptcp.h
 F:	net/mptcp/
-F:	tools/testing/selftests/bpf/bpf_mptcp_helpers.h
 F:	tools/testing/selftests/bpf/*/*mptcp*.c
 F:	tools/testing/selftests/net/mptcp/
=20
diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
deleted file mode 100644
index 18da4cc65e89..000000000000
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (c) 2022, SUSE. */
-
-#ifndef __BPF_MPTCP_HELPERS_H
-#define __BPF_MPTCP_HELPERS_H
-
-#include "bpf_tcp_helpers.h"
-
-struct mptcp_sock {
-	struct inet_connection_sock	sk;
-
-} __attribute__((preserve_access_index));
-
-#endif
diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index b1ede6f0b821..a43b1afe22bd 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -225,4 +225,9 @@ static __always_inline bool tcp_cc_eq(const char *a, co=
nst char *b)
 extern __u32 tcp_slow_start(struct tcp_sock *tp, __u32 acked) __ksym;
 extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) _=
_ksym;
=20
+struct mptcp_sock {
+	struct inet_connection_sock	sk;
+
+} __attribute__((preserve_access_index));
+
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_sock.c b/tools/testing=
/selftests/bpf/progs/mptcp_sock.c
index 9552584b1b6c..dd2448d1e7fc 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_sock.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_sock.c
@@ -4,7 +4,7 @@
=20
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
-#include "bpf_mptcp_helpers.h"
+#include "bpf_tcp_helpers.h"
=20
 char _license[] SEC("license") =3D "GPL";
 extern bool CONFIG_MPTCP __kconfig;
--=20
2.34.1

