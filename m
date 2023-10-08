Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2066.outbound.protection.outlook.com [40.107.249.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B957620E1
	for <mptcp@lists.linux.dev>; Sun,  8 Oct 2023 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L+SBuuu5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sj/uc/BlzpPzL13EvMyTn47Pj8S4AjHw4vInG7oTpEDFHcu+stMSHT/HheZy5vjvreMu5k4YQxhE1PEsFWh7XwKqmFijM1uyCYIk+ZysZ3OVcu477V334xeNTv7ASa7++hCi4OK+ohaHyVV8BkjB3CTy2LIwRsjZ+zEpQsBWeKmr7IMKJU5XuxapZmyAv7xhuusR/x9CTr5TdKIEsL3Hoes9XvQ4CkQDxxCotaoJhPbi0Dx+o9es0WQdyluCicZ31EIXQgJcNH2I6naVuL92VbHFDNcYuJbpRHUSyzy3eLHx9a6dhhP+68o9ZCYIoiZHU+VxdiU8ToorZamO1YPr1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZeeNAqCakXhc4M08eBpk4pwSPzLmyBi6AipPFqUQMQ=;
 b=KkyqWpArJ0DczqBGHEc8JZ9CQ3c1LdAE5sgw+JHUbDNqQNayDAHte13rBONgUs11yqg46iVznlJndO0MdfqiyyP338dnIiKVJ5GJ47LEIJ6NNmoLGfQFh4xprrI6rwyUU8JU/R9XfXy7gTp2dTpOotcDESlWRyBqFpHh4PpXIKXmaTpW1XXeEVdR2JJYZ1JAas3VZC0MHhiCOvovWx1YyzgXPsJAnTwDRZaLyR0oSbNRLgfCG+1vTCkM9VSwa4vzBiAAbmaYy8keMf1lRYMX/hZ4sJCix9j4fa9f/R8T9j4zpNhitzwZ8JgD07Oz8JfqEi76EOdlWmxJEQLdoHXUzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZeeNAqCakXhc4M08eBpk4pwSPzLmyBi6AipPFqUQMQ=;
 b=L+SBuuu5RYnfK0z1Gwt38DSa/1KhuHu+m3jeRQ03AH5mqXCSQy7PedKkCWL3h8peBZ4nJWoq4tF3tcOvJhr4Y+kavk9R74KqQ4Aarv/E+nnqRNABIFMLFsbwMXz1ol4omAbkJ70X22gm3qT8HnxBx0JjniZxyXFFsBIX1ncSPW1k8XveOOax+UFNv8F1kb/fBJoS0CwiML8LDTMdJXlWvvlUQpYmzKbG6grspjWZQBLWLls9tVIfejshPZDd7e8/leT+h7uuwED4cW3WKyA5zBF04KbbB/1rUQbV6i68304bfzQaE8UyFJSG91AUk8M+VKQFULc6HHmTTFY6WQIJ9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBAPR04MB7222.eurprd04.prod.outlook.com (2603:10a6:10:1af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.42; Sun, 8 Oct
 2023 10:25:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6838.030; Sun, 8 Oct 2023
 10:25:59 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 0/4] userspace pm remove id 0 subflow & address
Date: Sun,  8 Oct 2023 18:27:06 +0800
Message-Id: <cover.1696760702.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::32)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBAPR04MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b5a6f45-2643-4330-ed3e-08dbc7e8f667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kAX16bdLcU3Kbo40f1AEdFs8epCzXyGCXLgHTD3ddeU1EOLL9RT0gM/HBEnZrZvA+72dEE6OMvsA6eyHyFR2tJqnIaiwfnB9NlezAVX38Mh3PTdNC9KQwffGwI4/hw3Vvfqxhl5ZhLgb2h+bLi66SyCN5FFnKCVxiEHyghbtuC4widr24+iMnZw0QIfGxgXSxogS5X+bT2SOe8f5TcFpZDOg+rl+FRAw2KgJpVF9dfrjBs3jQVyLgXHFVmZOknwNK7UsS4b6qMHTuwPXzLL51T6RbqQsqxDzS+ExcK0BRuZGNK1FkkddFlRO7ZXTSLOR+7tqlwZ5PKruuSdUL+3bP+vxxG4xQaPjlhzYGDAG0zO17phBcZ0fAWIRyvLr2g7xywfsazRoP2ght9y21NCOscXT+nfLTU/sIuqwYydirpBgXLtQ8YreeW6ueqm9eJ0fkwyMMf48PTs7JckElwXTnbbHvtfDCsdVXuAELVuqXsTGq/N3Em0aCQ7K8BvlqiuiMdNyvZZLqo0wlxolzzHxwDcl73LVh+BtxRMekOCLVcJ05eUAO6fPIeNC8+eowBzp9+SjcYFJC7KgADhQ254LFUITT07JCE0ocsPYYbtMc0w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39850400004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(86362001)(36756003)(38100700002)(2616005)(26005)(6666004)(5660300002)(8676002)(8936002)(4326008)(6512007)(6486002)(6506007)(44832011)(83380400001)(107886003)(2906002)(4744005)(41300700001)(66476007)(66556008)(66946007)(6916009)(316002)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BgbjBBe5px0GMmquN/gnCTMKxZ0vld95mcVYDnmzrNH2RQ9CGPcoF39dq57W?=
 =?us-ascii?Q?Wbj6HG1ZfAErBozm3rY6C6mxCXSpK6DlbIP3rLboV0qLXQqHIBASNVgy7Cke?=
 =?us-ascii?Q?evAwhXtboUY/ALDnhtQqCh1gkSE/ymOCS3kK4RUw0qZ/UNsopemc+wCCVd8E?=
 =?us-ascii?Q?2aFEyol7yon3RGPFBexuKAABdklbQTN8P26A8rRmuki7BDLh2d8uHmOG1zqD?=
 =?us-ascii?Q?i48kBvYcTrlBof9tIPOkvWa+aTrNvyBKvzRIz79unJifdb3mOGNJqAlJj+8I?=
 =?us-ascii?Q?kKhAUd1GU4bq4Mn5H8pd0SVgxH++HecV+jtlzSRnqc8q/XDM6oQhCAclehjI?=
 =?us-ascii?Q?srneHF5tSE1I96tXpwkp8xHe6oP5aNLYh9NvE6ZjUCKwsFM4Ya/3k/8eUsud?=
 =?us-ascii?Q?+xfhmdIu96ifLjQr70ougkdH6mFVoQALP5Lt4tk8wAqBhUSwFTFl5ogxGop2?=
 =?us-ascii?Q?K1JWneERgNhgWSSd1XL/VYnQD5k/z5Hqg8oJFIcyrphZC5jPGbRvTOvMcS/I?=
 =?us-ascii?Q?rif/7omi58SsnSe8XOjgxzUomdT4FPacpWcxyZ22yxPwI/MtlPtX8Je68i/o?=
 =?us-ascii?Q?VYZFxAqcmthWNiNY6Vg2P+lgqEATBX3NGVAJPbg3epsgxXJRe042XGJcKkBY?=
 =?us-ascii?Q?54Cr4qlz2tW8ZkJBcVV/Z/SDBROPYQ1gGUxZEGMoSTs2L12b5PXZ83ugvPCq?=
 =?us-ascii?Q?bDRJmLnG4AdqD0wfD6Lnx94c8On9Qdj4hutSxxR1fUeGox76y5sm0OFBxw2r?=
 =?us-ascii?Q?0IFX0pzvjpvRYE1jS2Xt7rl97uXH4wfA0+u8Jf6Uo/4yJdZmBFlInK1BeiFp?=
 =?us-ascii?Q?Z9oqsKE+c5Aes5hQ8Mueh0DFj5UXJfG18whOgrrtlTgrq45rNGGvGcnxTW0k?=
 =?us-ascii?Q?YcPl2UcRF7nYBWfsGLYOCHe72Rv4t8TvYdu8pERPzdmtsXIbs2ffeK1tWWbo?=
 =?us-ascii?Q?BKplywxfNzCqjvzQoAGKFVQsmKsYTjrA/Fzch7/3COqR8du87c/LbFyM2GT4?=
 =?us-ascii?Q?//coh3N6IRmDI7saq/a5m3BdiWwM4XBorTVIg+VvsjGeOIE4MFtzDDiQD1Fe?=
 =?us-ascii?Q?zdR+1c33ww0LTgNLHtvTNnzSv7V5FzlGqvZhM5ZQnKOau+R9WFs3KxIDUCaK?=
 =?us-ascii?Q?BYhf/d8aKDC/Q5JMKjUl6Iy5JLQVRA+BnIPlof9ImtsHOflVlyVTQ3DQH0Tl?=
 =?us-ascii?Q?ibkHBMLR112Nui9c4vOft6GcVji1UlsDT6cF9SUfERjxyvTcSk5qnsf+SvfZ?=
 =?us-ascii?Q?ZOUF0jgR4XnE0Iub2/W96o2F0SjbwaOZroOMV9dvrALA4DyNum90jp5598iN?=
 =?us-ascii?Q?zahL5lj8+twDs5NLu/t2z0NN7IownTmDfoZoPXVXuaYLQBVE4lp+fpec5nXW?=
 =?us-ascii?Q?myTSoS5NnW0UfYBLsgcKi5UlNVgMN/fTJ4Yq13PicBJ8m6OrlV6bbgXjvhTK?=
 =?us-ascii?Q?wv0MQ/pWjsSNp10iWLDsXzo3koO77sdTRnCtIHMwi3xsijOHpFWAh7QEECC2?=
 =?us-ascii?Q?sUzQeguk2ZhJ7bgguykIr0BRJrp1KgPJti1gW1KzGX8XfDVLbmVyXu/Djh3S?=
 =?us-ascii?Q?Dm/Kk3hJlIZbMKk6Cl6YzSN7a3ExbMVoSDYE18mh?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5a6f45-2643-4330-ed3e-08dbc7e8f667
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 10:25:58.6923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXi5O9I8kR8Sqg+7802HPDytaHkIp6DeLkecqaKKJ1xepIgYZVmBW8DUe6eCWY8U5E2nRpOrNCyUL7C/Nlb32A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7222

v11:
 - avoid sending RSTs.
 - rename 'id 0 subflow' to 'inital subflow'.

Geliang Tang (4):
  mptcp: set next subflow to msk->first
  selftests: mptcp: userspace pm remove initial subflow
  mptcp: userspace pm remove id 0 address
  selftests: mptcp: userspace pm remove id 0 address

 net/mptcp/pm_userspace.c                      | 36 +++++++++++++++
 net/mptcp/protocol.c                          | 18 ++++++--
 .../testing/selftests/net/mptcp/mptcp_join.sh | 44 +++++++++++++++++++
 3 files changed, 95 insertions(+), 3 deletions(-)

-- 
2.35.3

