Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2043.outbound.protection.outlook.com [40.107.8.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2982F1E1C4
	for <mptcp@lists.linux.dev>; Thu, 10 Aug 2023 14:09:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdHPhx2DTuypvbQgPuCPOKTAOjvdhjd+bC5Z+T7tLrhesrDxCsrDZl1M0tM8fAQBDEI1Rm12ZaulSMJr3awfLb11WCA3QMRg8C1p98LPVAUhvmsqpCBWkgayCdS0MSmmds9gqMPl2T3bp7N3+WoBf/P3KXlAaHhbnIf1FHlmH9ZC1IDmvmjq1PNap1soR+dNfr0rCoNZgDjSADFjAbOiEEzaOnmKx28EFQvN5PloxxCj1/1bZ43fhQJ5+GK9EvaUk1FwgcBjxxaG+CsvJaetDTLchEsyOvwRB8Xaai3unT0zaM+fRty0crn4aHb06CK1zSb9Ymt3J2NfHp4YkIZqfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IV5Oq9jpxDEsJqfgtHfqvdF+zWXqpWpPqbVS87npQuc=;
 b=VgZR7BO7nwGVAFoCXFZEeOvLrSCTGe7quHSVkv6iz4zWMGoM9e9Ve1RL/JyeilhUyk8dny3/LiTyWIhVNK+IoUeombguYRTbsIq4nvSWMfeXnm9FWp1xW3Zko75YG0zh1zQXUvHKBnEIosOWGSwvzfMvP4UfcNgepIpHGPNOU7bihUs0vlPcW4ATQeyf9khONDSdhmN6KDxF60KCsa8wyVZjo37LSQWk+kLSCODEPxCnnPu3P0+mlRZZRyGVr9xS/g0tyympz6l5YYMyB52ULNhBlxCFkBp8EAbhG/XSiH25isKbCeYOHqOYR4Wow16O5/5z2Q8NG46ek5smORhoJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IV5Oq9jpxDEsJqfgtHfqvdF+zWXqpWpPqbVS87npQuc=;
 b=bqmuiwqFWaz31pvi5ChnS/MqxnkeHONWVyshImHTjbhWHBKPVcMuDtnE1H/dMe4Q9TEHOtV6r09D7MOQptpgx7KLHRvOi8NtauoKhlH1K4CV75LuUjzhn8fUYvqVJEihdwUzKFZ+E2b+8PZfN9rY7xhQ+zsfHRhPVwUG2vKmnSBe/6pbqRcijAMvyrSCnRNfJDze1miD3pA2LliybEE9Li9hUF3bwYzDJX8zpkbG1g+FIZsT2ptII8sPR+PzQCP2K6No3wCJU/X1ESaG6/8aA6bVHfTvS844kFpyOSVwofPwyzUgktJp7rOSPWitBfL2HgQCYBoEvnTMmfKqUNDhjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8993.eurprd04.prod.outlook.com (2603:10a6:20b:42c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Thu, 10 Aug
 2023 14:09:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 14:09:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [RFC mptcp-next 00/11] BPF packet scheduler updates part 4
Date: Thu, 10 Aug 2023 22:09:52 +0800
Message-Id: <cover.1691676509.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: 2461b553-4e60-4007-cf95-08db99ab7739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8aQwes9zwM9u2jItzWkxqjghyCRtoqotv2IVdJBPDmPTucGfjLeSAnml+p7KVKR0toz7qUN5d8AwWcOyyatvdvDuH7TNEQdO7ACGwyPn+Ym+F0vmkrEc/JCMnkeE4YcVdM0ABJBvQsoSWBpdxKP934e8MhaaF8Yn905p87zfy5+Elxd9BUeonGpxKJkCN+rLAreQHEu0Yw5Gtd3jHbhx8YTqh1ESZBET2cQKeArxO5IHF5BrQVLPW+GmXpFG3i6VDiGA2oQL3r+b8SNCAbtF0UBx9+gdbxVRreeWlXhEACYKnnEw1GWllmrl6iUbEEOvAEIeFr2B4W7Xh37XKK23MBX6PwLipuMeqGb0yRVktXWJhCWcxRDHLMWEKJvQlZcr4KsrxRJ/c4xaFHI7i1ZrDnwIGQ4HMR11n+ANfIALGFt/eoB+xZvNjgKe89uwwr/q0+pQCweff2sFkFb/jJlSxAtfbJTJcZWiuzOh5I43z7YKNplAhO13AaBpYlqO5snBpfv9OFkpZG3EBXBGQ44evpuLVNXBJ3pktVowbZ4wPT0GKd/vt/j2aGWnLEKeh5rZoQOaTaTu/UtygUMhM11qa4dcK8UOYPfc3eQkIJDbnW0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199021)(186006)(1800799006)(2616005)(6506007)(6916009)(36756003)(4326008)(6512007)(316002)(86362001)(38100700002)(478600001)(66946007)(66476007)(6486002)(66556008)(26005)(107886003)(8936002)(41300700001)(8676002)(2906002)(83380400001)(44832011)(5660300002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y1B5nWQ+xDFRomjieadEsvUQJs0avaiYtbv2lLenKQlsxwYUx6fiOa997nGO?=
 =?us-ascii?Q?3Wa2j5JCyRDhJsleUB9vjTZJZgbGH6CeZaqU8JeKzMyVc5Y9XERd6wp777Xx?=
 =?us-ascii?Q?89yKvlY7TFZFEVpzymjbIxIuJSATg+SprsbzyPs76sGi6lGmFz288pbYtve8?=
 =?us-ascii?Q?iP1GGQ3lzw3yd/C8r7lMjUEJrW1ENfEm00nu9xYK6SakDNtuLaOd9VydGYP/?=
 =?us-ascii?Q?r5ZQ7twzhi5Kkwh+uwebJnZP1duO9kYv8KFDtKD95vVCQ+9gJN2rNZmC0RMx?=
 =?us-ascii?Q?iP1dhACHVjGojxCnBnDjafNgim1cP+x28pk1OXd3/K+5cClkGtEyAhGPj2Qf?=
 =?us-ascii?Q?d7d9DnrO9pKdeViS9PX3k181G5JzNo9Su7NZ0Bb5VRfQqO2hVoFB/uRyVOua?=
 =?us-ascii?Q?RyTGwr6RqfHGhzhmrzSDlA/lJEExCPKrz0EEO4jnZaVYAsF4T1dZk/5mjcK4?=
 =?us-ascii?Q?JPuSfu/HRT/g+ukPKaf+Ae+HqWolBuBWZyfVtyxDkaKamkyQUMmTsrThpssh?=
 =?us-ascii?Q?jCN4nwZQsYPUdZceXPaOAcnwZENFppUJxWIwRxr4P6SlwWD+QTiFGXExdPOF?=
 =?us-ascii?Q?mHt4fWYk3Bc+KaN9IMXwZ/mqK00A+MJUGcy++zTXQLD/COuGCDK209I1gJag?=
 =?us-ascii?Q?0LhDDPiGUJ8Yl6KgpBqRg/iIDuHb/vPHxvRCLqExZAArSdemO6ehgQrj6t45?=
 =?us-ascii?Q?hgFXpY+JcejwkeCkZ2pl8JSfvRF+S4ytBUVkosr3KOnyh8js96iEOfSuWFX2?=
 =?us-ascii?Q?n4fvhVVvkVml17Yf57CmmsUACoAMutzkzTx/s0uS7dXi5RSrmvB3ey17K52M?=
 =?us-ascii?Q?jvSu0zsBCduKjNFaL8j9c7g6kZC+BGtOqxQj3hmsyQ7eSug9mibfD9xfDFEz?=
 =?us-ascii?Q?zRD+xSerJxbSsDGxD48r31EF8zce+LQdss9+s4AIP4iMM7E5UNuTNGPce3ni?=
 =?us-ascii?Q?rIERk+5ANiURLYv0YEXz9H8qztypRLy1zkoaJhOgeSenA84wKIMkud+c1q2E?=
 =?us-ascii?Q?cDMrxfT6CO7/QdRzXumWJivbGgptcZHKmLlv4ywH5Zbx2B8KbogN+8xQb5r/?=
 =?us-ascii?Q?VhXCFnCqhoc80Cs2i/4csAqkKbPLJdr6NekoqwLwb1zRQfHAzO69IItAoS98?=
 =?us-ascii?Q?gYeW2cFL+fV9Aaw2dNwr02wMeYi+iGOM28Q6QuEsA8ySprGGxohSYw5nkmwB?=
 =?us-ascii?Q?euMgHh3k11SKHqo4uGgJziv5kZmAN9xddlYF3BL946aEmoEz9Fv6iEcH0mRL?=
 =?us-ascii?Q?FGqHuPhTPKj/LNEEN5G8It3n4lZG+52Q2JNTK6nmn8srwUaQKLg03O+/UcHY?=
 =?us-ascii?Q?l4zd3QLFBWp3cVO6KOjBjkR1uoEYXq0r8JaGJ2ksA+ILmbJEpa3L7SDzHMv7?=
 =?us-ascii?Q?9Ywe2NuA2LaPLHfnHJtwnaDiJlIayv/zq9+pUepPEiWJ8cdP7uO/D9JABDJ6?=
 =?us-ascii?Q?nXAf35IcJ09uPaLT5notTHYin382zQ4VzmFMQci3RZfJsQW2o+QW4vvvUL8R?=
 =?us-ascii?Q?7o8cFjsACwqZ5aY93DH6pKP78Y/uwAHHIzWMN/26zCaWwFN0r/oy/GjilK4t?=
 =?us-ascii?Q?fxYxopBNp82UtkC2zLH8VcflCEcNCGPZVMduG0vd?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2461b553-4e60-4007-cf95-08db99ab7739
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 14:09:52.4855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VMlOS6F+KVEfHzgvy7eDcQM0t0ftRrJ2YElRKIEWxBlqIL0PpP1Sv+Jh1OyekCkqw39MODlfMMSuMHK6HaLH4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8993

There's a bug in bpf_burst. snd_burst stored in mptcp_burst_storage in
BPF context is not used. msk->snd_burst is still used in kernel space.
To fix this, add two new interfaces in mptcp_sched_ops to get and set
scheduler's paramters from BPF context to kernel space.

Geliang Tang (11):
  Squash to "mptcp: add struct mptcp_sched_ops"
  Squash to "mptcp: add scheduler wrappers"
  mptcp: use snd_burst wrappers
  Squash to "mptcp: register default scheduler"
  Squash to "bpf: Add bpf_mptcp_sched_ops"
  Squash to "selftests/bpf: Add mptcp sched structs"
  Squash to "selftests/bpf: Add bpf_bkup scheduler"
  Squash to "selftests/bpf: Add bpf_rr scheduler"
  Squash to "selftests/bpf: Add bpf_burst scheduler"
  selftests/bpf: Add bpf_stale scheduler
  selftests/bpf: Add bpf_stale test

 include/net/mptcp.h                           |  10 ++
 net/mptcp/bpf.c                               |  27 ++-
 net/mptcp/protocol.c                          |   8 +-
 net/mptcp/protocol.h                          |   2 +
 net/mptcp/sched.c                             |  49 ++++++
 tools/testing/selftests/bpf/bpf_tcp_helpers.h |  11 ++
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  38 ++++
 .../selftests/bpf/progs/mptcp_bpf_bkup.c      |   4 +-
 .../selftests/bpf/progs/mptcp_bpf_burst.c     |  43 ++++-
 .../selftests/bpf/progs/mptcp_bpf_rr.c        |   2 +
 .../selftests/bpf/progs/mptcp_bpf_stale.c     | 163 ++++++++++++++++++
 11 files changed, 339 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_stale.c

-- 
2.35.3

