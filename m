Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2055628E6
	for <mptcp@lists.linux.dev>; Mon,  6 Jun 2022 14:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654526502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=huKkVcfICPHSHthlnKooFXkI7DNVojAxOt6o4Aj41Yg=;
	b=OhjI9wSKZIhMRVvJS87gD5e/t4KRc15SASqDympVGpRzVrMFfHoA2DhFkbYMP5MQjB3EHt
	5tLR9Vm+kBCEp+dWhs/ZhSL7c9ALFTiMWCkNQlF1gKEZKScjroTlsw8tWuKS8XAvVdiUev
	orzLWJa4i7MyQv4v6kkKthpvZbqNipw=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2111.outbound.protection.outlook.com [104.47.18.111]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-26-Ta14KV1gNqGdRiqykYOGwQ-1; Mon, 06 Jun 2022 16:41:41 +0200
X-MC-Unique: Ta14KV1gNqGdRiqykYOGwQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LI7MU8J3hIjdEsq9h2UeBaKMw062PK/odxUY7DsFdlfcC/Jrfw2vGc1nXWA3JvyiRQktHY7aN3rL24xZcmS3eFSpLG8+csyEU85ogvlNtIgMpnxrXrrmAhrEZ8YmgVnBp039ow9cOqfWALWB3ZXyX26Lu/Dv5yyP1SlgkxzVaKk1gxh1lMWof04xJuv9/2TBDgiY0io2krvkPe9ItaOiTFTgAZ0aKZRG+7lyO0piQ/rE3iUcaRGwcx1YykiE+aS8nvPyne+Q+LWVyfvvwdu71rah/FblIKXg0qYLb05jctJL4+jVRiAX+4A1cPclyjYZumcYOs/nNsMpZnOjXC62Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hM3nFBLdsGVwW9WdVbmyDUCUhqg1fHTlecVJ1mlgmjU=;
 b=ltM/omIZhMjGSvas5lIOsicjqwtV9gqJ1ku+e6zBNrVfTnfEBfRoMcDrykSK5/Vb810uCa0pikCxFmsi7KQ15EcUf//CqPyoj7J2w1mEvb6qN7m7zxyFPaN9RmznZdjB31upnm/XWMRmtXG4TPwADRWJc+edSKX1ygKBc4vI8LiF+VpXvaM5knJ5DlN43aNNQvxjg6SZgvBlexGTAr6BGUjSf0DQgV1AqYmkEI7A4aNpygvb2BvNHsnUQ27nGI+Ro27zbxC63PSXJTWz0HZFjYzrjb006S8pSEpt+RO3mAyjIp9wE3APbdDiFaDRq3m078h5vuDKqxw7Ly+fY06zKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR0402MB3536.eurprd04.prod.outlook.com (2603:10a6:803:2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 14:41:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 14:41:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 0/7] BPF redundant scheduler
Date: Mon,  6 Jun 2022 22:41:15 +0800
Message-ID: <cover.1654526068.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:54::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98b2d559-cbaa-4ae6-b20a-08da47caa9ad
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3536:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0402MB3536C0FB4B34F8835376061AF8A29@VI1PR0402MB3536.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qgn/Z3R7/RjgsqLzbfAp+Xn9g4LcFj8nILwgyniHPiiKdMkzSyVcsXUTDh8xvVJ8BJuFzdesi2v64Q9jv06JAjEbhmxt0o79otLII6idsKg578Z4K6Q0JR0B0X40TjgNVsB1fRtCZT4cyLfXprEgGcx1SXU1Ma7xhwlj8a4Y0BEk14ew0LD1ENFFV06dmpKdzBiEHLfTpocL1ETHg+26tvhRoLBlL6mCrxaqNxr+FMLIVSTa/oR8o9ysOjNF74jfrQ0qrAfoJfY4HLSnvPT9d2ZzMpT17JgfgJ6knVjMxRuqqirnGObJHInIEEyYKq5bnr855eiV7pdnlHjvSpwwdnScl2ZdW60uTJd8t3jYruLadGhntDIU22Hb1o1s5IdbWGa7CAPHa2LfcQjWEUBf2163jNbiXLNSe13WMWkZ8+UYGT6yW2UZacCGzIXZbfbU4zToKJ7LPYhixJsj0jJs7/q+PGGulE/+dTAawSTkipxMFufXYfYwTa7yT/iTkIg9gllVgvv/jN3qE4Pl+5IA80ZMTIoElho7N0b4olpaEoC6UgMXYy+0GxB0yfEEFO5FQSbVAph5pdGBEi3yverkXa1Vo5cUxPyN6dvq67UpM5KzlbiTLxoGo+VS0fNXRyhpX7BojYJA1s0eAvDdA9K1cbJgBjx3MHCduRC/wg6xAj9RK2V8ZDR936C1o8mNpk3M+nrQCB8TxpKf8eeKBhCZs6ymvn3HeoiPQYqQ1L4T+lVw0ZoAWnkmqojBr/A2syRDGy9pb+ZpwrU1yUBPnumR2Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(107886003)(36756003)(66946007)(186003)(2616005)(6486002)(6512007)(26005)(6666004)(6506007)(38100700002)(66556008)(66476007)(8936002)(44832011)(316002)(86362001)(4326008)(508600001)(8676002)(5660300002)(6916009)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R1WTOC4bNtR0gTFbM5fX9u9QnQLDmUYuJJz+0z/kYycC5n6qj8TJGQEttHEN?=
 =?us-ascii?Q?dTVpN36nH8RAEVaOrpWbYLpwPr8Bz6L2OVSKkskkFDskpMbjfkPDrGlNt7tb?=
 =?us-ascii?Q?W97dwF2IEZYWXZKa8C1vb/u0VxwHbrUB0t3zWka3YckwgS4HuULLSydmC6I2?=
 =?us-ascii?Q?wAzFF43WH582vt39dPf5hj3fREr/wtoEynPemkiYmqZckcH/9HHooIUUaZAf?=
 =?us-ascii?Q?Jx1GowDQBSyC0ahuvdVSi1LLcJRfCQbP3AW2+iGwjlpn3qRfICpcnW3UBYqe?=
 =?us-ascii?Q?73NtqIr+xKbwIAAnFPv4fgnY7HerUYSyZswpVWWvdvQ/1S1sxoMLjq3C+1eG?=
 =?us-ascii?Q?flVRx7+sbngR69d2rWZ/UY10/n86s8XdaMuYhZUAaS2ELCl7r+kJWFbtyPsz?=
 =?us-ascii?Q?ePfN2leRbo7NlWMVd4n97sKJfe8Saw6gXS2mcyIZ4vkXiuWVQqWQMYGCOnom?=
 =?us-ascii?Q?54GI/GHnihDhlJHtp+g9LGdt7LgvWpAIyqPY8pSGHey+I4bckeN0BCBPP+U2?=
 =?us-ascii?Q?aV9rkt0MAA5sfrvd6aalrhmFEmPH749HktbRHlwnLxk/ArxxjI/Y3ghOz6rg?=
 =?us-ascii?Q?irQoC/mn07L4JyIyCFtShtajnjTrfGrQJ/p/CD4qdEl6TAD42BnX3YCnzBzL?=
 =?us-ascii?Q?o6ZwXdLUlh8RFJ6d8U3U7ZXcuJ+FV89ELceC5JeYlBjGrX0w/75l4yXawQ3U?=
 =?us-ascii?Q?BK2B2HbFIYG9VKFhc6ehWF0FrYC7dDimyCVKb0LHA3hGMdFYr804DJo2J0ht?=
 =?us-ascii?Q?jGrhqnh6404uJ3RLzc3gCjsbKvnEqCmnpXicE+zldhNTBw/c9fPbg9RSnvoE?=
 =?us-ascii?Q?JZpLOHh5vUPGPKEnicbQiFdZ1keTceI6CbwuT28Vc4AJQDYTweACAmIGkrQZ?=
 =?us-ascii?Q?T/C3nHriiKJqSwtZbwqnetzLMORCKgOXYRBhBtmBMkrSUZqMl8kZ48DCRqlV?=
 =?us-ascii?Q?9nLJzorQuu6mLOJ8UojdOvDitllp4iwQb7nsS3GuytZ66O0+uA/B06aegCOr?=
 =?us-ascii?Q?ImZAwMtuUnJwnw+BUHFMb5t+vFcsre0+h4pwF5rqpSsTInn2fjQheehOG3ei?=
 =?us-ascii?Q?I3nRorGQbr+VZUe7UJi9AfxnPo1s0UaBZfKgYVAhNkFwbNyOMhZ29/ZlZNPz?=
 =?us-ascii?Q?LMc7uOAabBhBQpQa0qajT2kcOaElDX2TGzz/xlZ22eLaH7LMeVVn7al3Pe0T?=
 =?us-ascii?Q?5I2oIOrzVB5YxymoQdUIhgNc7zooD6FrfCBasnS4yBUmEMblWwa2Q3iIqQzI?=
 =?us-ascii?Q?Pfe3nMRR8cjTRus34Ml/w6fceuM0CP9MJTCvs29dxsk3ASs2b96eRuNipzar?=
 =?us-ascii?Q?zjlXD7uM2nhr44grnmVLc46HF5LpsZmA4ac/eqAmJS9JYQ9FQsZqtE/e7MWz?=
 =?us-ascii?Q?8r8tl1Uh7ySMWZXB2b3BZbP2rte0CaHRR3/60IC/BmfbxmR3Vl9OfjwDs/F/?=
 =?us-ascii?Q?kJqy7jJoXZLtOGMeO5YHn2T67krT/EdYoHFwd9CkOpQ4QvotG4mSTR852zdW?=
 =?us-ascii?Q?Wxmwok3upojk61n3/YBcEvFqHerk3D3KcZV82Bk+oGg0YiKmd8DyyGg03Afr?=
 =?us-ascii?Q?s7DR33SgwyyRWcBi91M4sZbeszE0+6VBLYWZQsGvqC61tB+Ei6NKpuQRwVis?=
 =?us-ascii?Q?MhOv7cojNidjqAquZSH2K8N4zP+2TI2xoEP6by7MAD1UgSWVBVxrzId/MIKr?=
 =?us-ascii?Q?pTn/7Jbl3WrIDcumHmgUSmaSi/G7jE83hq0wujz37EHPHkptrPaTSjFFB4i3?=
 =?us-ascii?Q?2C/xJlTHbGnCBMD9lQrJJDfol1RWxtU=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b2d559-cbaa-4ae6-b20a-08da47caa9ad
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 14:41:38.5794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENsbSSnebmpy2rGXfQteZH4fLMkL90ff9digRZLm8lTM+7Cj1aIZ7UqY1/ztFBYx9vgIXPp67ouUAhjYcFFCkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3536

v5:
 - address to Paolo's comment, keep the optimization to
mptcp_subflow_get_send() for the non eBPF case.
 - merge mptcp_sched_get_send() and __mptcp_sched_get_send() in v4 into one=
.
 - depends on "cleanups for bpf sched selftests".

v4:
 - small cleanups in patch 1, 2.
 - add TODO in patch 3.
 - rebase patch 5 on 'cleanups for bpf sched selftests'.

v3:
 - use new API.
 - fix the link failure tests issue mentioned in ("https://patchwork.kernel=
.org/project/mptcp/cover/cover.1653033459.git.geliang.tang@suse.com/").

v2:
 - add MPTCP_SUBFLOWS_MAX limit to avoid infinite loops when the
   scheduler always sets call_again to true.
 - track the largest copied amount.
 - deal with __mptcp_subflow_push_pending() and the retransmit loop.
 - depends on "BPF round-robin scheduler" v14.

v1:

Implements the redundant BPF MPTCP scheduler, which sends all packets
redundantly on all available subflows.

Geliang Tang (7):
  Squash to "mptcp: add get_subflow wrappers"
  mptcp: redundant subflows push pending
  mptcp: placeholder for subflow_push_pending
  mptcp: add sched_get_retrans wrapper
  mptcp: redundant subflows retrans support
  selftests/bpf: Add bpf_red scheduler
  selftests/bpf: Add bpf_red test

 net/mptcp/protocol.c                          | 116 ++++++++++--------
 net/mptcp/protocol.h                          |   4 +-
 net/mptcp/sched.c                             |  62 ++++++----
 net/mptcp/subflow.c                           |   1 -
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  34 +++++
 .../selftests/bpf/progs/mptcp_bpf_red.c       |  36 ++++++
 6 files changed, 177 insertions(+), 76 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/mptcp_bpf_red.c

--=20
2.34.1

