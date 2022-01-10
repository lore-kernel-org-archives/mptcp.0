Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AFC2CA2
	for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 03:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641785452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hlwJexNV2YJMEp6552AM85uhwEAt5maTJVSSKuDRERY=;
	b=aRUHam4csYGNRXegIMPmtVsAgdpRoa3qBNLx2+MHDxj+mEWxBRP553w4XUmJ2KZC+o6Eu/
	dkEMNBaQCJ/IBVYcxAbvZ1qs0qpJIWrIkRBYexKZUzYwo9wMaqR9bI99/FaqD9H6vxtgMu
	OOjIWO4++E3DUfedNBNxoE5bHEQkRzM=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-IvSnB6g0O0iGXIvqdS0QhA-1; Mon, 10 Jan 2022 04:30:51 +0100
X-MC-Unique: IvSnB6g0O0iGXIvqdS0QhA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REiaWWyTXMdw8KpAcgjcuhQe0YaQypTuLQJOsOdXrbeia+mpfOuVXOU/O/yEGOusmggtlhxMfbhtCpdcNvcB8D6R1CCI2mAKyxLtupsk5ZH3r2aqR/Qzwphqs3xXKfT6dRuDzSQC5niwZR297s+SlRRfzxIoIfOM6bSQgZUrpy3cu0qwOB0NFg0uKiFjCvGpj8offQj9EXoeCtMAfpINSN8aKq9TH/FXkSd9dAhxefoxN/Asf12h3HQPav1xlkPyCQqiX+WfZjAM1ksT4FlV2Fjq/P9TjoKpBhREEn1TFyUKZrSPzgNGUH+Wf7MivfjDe7QU+qJVsBBRTrnbux1Bmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWXooMOVCedFSl4If7n1Q8Ua7hTopj2zu8IHtBQZiSQ=;
 b=iKdC+fM2zCkW8ScUBzv3bKR797l72hVgiAdhKQJZCOR/BrFSPI6xPJalKV4F9H0194roowsGMueAyvrzwqe5tkQtWyygO5W4kPBRGU7qFLQKgEsjXOKeyvXNnNfMmsoc0HePusZ+D8YmTYFktEXRIQ1hUxG85pDAm4kWRTW0HTd9gvgl+gwEb7HyrlK6aM/Ed/8LkCAcU7AUecWGj7S2H9mRlubsA6IYQwk4FuUBw78BlukJHL8lbGX3aZs1fwECBDhwSzH3KmHrRsPbqUsjjUIiaGgsF3/OKyKtu91b9rIl2CYjFV8OxD9XExEqYRc1bI6rAGXvGHNql5L8jXmruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2569.eurprd04.prod.outlook.com (2603:10a6:3:7c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 03:30:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 03:30:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 5/7] mptcp: set fullmesh flag in pm_netlink
Date: Mon, 10 Jan 2022 11:30:03 +0800
Message-ID: <f267b8fb51b9c01f7c37ca7555f15a1a33efec42.1641785106.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641785106.git.geliang.tang@suse.com>
References: <cover.1641785106.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0401CA0019.apcprd04.prod.outlook.com
 (2603:1096:3:1::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f24ece0-6777-4c35-4ae3-08d9d3e999a5
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2569:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB25699F1406C5185ECB4FC7DFF8509@HE1PR0401MB2569.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Fbymi/ZR6/0pBgF6amyMo0jxhkZRXUzLEUHWHsX5LjBh4zxrV7uOXCJAUc8p18uUGYbWz7W/sIhGO/8FEdtmb2+SVophgs/qKgLJyNry9ud7OjfRhV1pTrgu5xfVrsVwOxJHbu36doFOYUNX7ySb85v/z23bQcg84qNEVZRR3/BKDGRELIqNvQEzg6ddkpx0jtoYf0YVCnhrE87wp+IOo4tQB+ns1Ik+f5ah5zJ9ipXB5d0iHG6NWoEP5cH/VlVqPsvOXsEJOdnYfTnZsF9e/wM08/ehejtEsX9U2vWu7XVGUuZBOy6qV+nTsRFu5X+w5b88RWAiW9ymgGn39nd6upaGEV1VwKPiGnpq/TUv51QElnj4m4h9ER9X4tgNkixngnTC8HhFcydCfhEARKc/UFsLm8XXu1isMtEW0pvR/VKPHR6v5bMNXOB4LXjxEp4kQ4vOYtkueMkELq+eRPKi00w5k3tmBEohGW3gyokeGw4fyQySuEsZajPMdK6Eb0pP4/NwYjwgi+s22GXQRS4di0UheDiTEf0agfTkBePJfdA/yAldpyzAVtUc+FtfEKHPNig5/HfqbfXIBKlN+QJ+grFbmR7saeTzLkDPK7bSsIjNC3lD1WzWhwecFoeQh4u4kjEwnwGErF98VQAYCI84+g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(6506007)(66476007)(66556008)(6486002)(66946007)(8676002)(107886003)(44832011)(38100700002)(6512007)(2616005)(2906002)(508600001)(8936002)(316002)(26005)(4744005)(55236004)(86362001)(186003)(6666004)(36756003)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3qsne1nKZP7tFwC3YCRYS4FjeYvLn1aOGTiOG4lzqLDiTf8HjNe2VDOsLgJ3?=
 =?us-ascii?Q?wE1tWcbCLgptCMEtpDGOPFpto2rQppyIpmOi7ykOlQLVNGVC4T64HymWy6QI?=
 =?us-ascii?Q?YvLKNPECsihW2gbIpZ63hHQ90NOgKBLLvovcpCsLFw6VvLmFkXREgPN2pBRC?=
 =?us-ascii?Q?NYCB7hnZMODTMtNRJeZxkwvgUCxLHsIA6IxugAG7IwKawt69t01iS98I1lKk?=
 =?us-ascii?Q?UrlvYTnEdix6+Mu9qRQwog3t/Gy6UA9FgYdudpwn2AoAp98sUZkATkKc7T9F?=
 =?us-ascii?Q?DLzNoOU0zhAXfxdZ8bycLddVuChSCQRpSRafHeDp9EnVlIkf5m9beZFetS8/?=
 =?us-ascii?Q?QQvhXv/7OB3OePH2Nfg1motdHx5aeXzWMu6/Ca1ciP90OJshJt5Q8acWoBQt?=
 =?us-ascii?Q?67cj9+h+myVMusXJVhhBW5gZS+Wc+DpJXIf4oaJP2Va1vhWzYd+bgmJUrGdC?=
 =?us-ascii?Q?SzZs6vzNmffBIIz+wS/KRXZwSMRafBCwEvZOuw4RfnOig5do9HJfvBs3THQs?=
 =?us-ascii?Q?nFx7zACpMx6CtOETyejmlAgDxtmAo9FGV5qKff7rswkOPT2s31VaPzIY9FK/?=
 =?us-ascii?Q?o3UrJJnx4EAZsx8TmO1Z1LMeQK7LdKffMfVcyWHAh7L3e+ZMos5mi6vyTApi?=
 =?us-ascii?Q?d9BmJdjsIUtasIrk+2vXCFOVqcWnSer21tDgEsNlA8RSmCp7kVlio1v105o9?=
 =?us-ascii?Q?+KoOMoVKZ0J4hdmUzw7cC0RpXcv2nPd6aeCEHcrdpW/cxRphYFdoqsCXbotq?=
 =?us-ascii?Q?L4uMRCz9kkwWmMA4yLIVNcKfLpABLr7emBoapIIGNj13MkJb9eND0PolPLSM?=
 =?us-ascii?Q?Uhjd/g/Smgg5txO3nPFeWEV5Yp7rAvoyXDONv3X1f7ofY5v8Hifqum/YKxoY?=
 =?us-ascii?Q?vAV3DjbfjfIBo0degHlaGP1YvuOF4ikGvqUQjZ4BLNbdroc1Vp45FkxlgDZk?=
 =?us-ascii?Q?iMFHZew01sg8PQQFZk/rGcJ16csC1mBFbRVDtx8pNbEs83TPaIG4K08LX6Fa?=
 =?us-ascii?Q?n5XVOcwD+uSWuNbxxOHGqW5K66tqApJl0O6gi/9Jzf+eKfGiF+PGdI6N08gx?=
 =?us-ascii?Q?ILJsh61vJ0WCuI2Em274Vk+tLWYaJvO5ApbNbXk/fMyqyZmnHROl6RTyb5ZD?=
 =?us-ascii?Q?eV7xJjAtEP9yUk2t0CR3sXmjc117acOwkmGphd93xOJ4jPo0/bxVBZr4nceO?=
 =?us-ascii?Q?tBJ09L8xVvYVKmOXwAI7SpO7QimJf3CkY1oBXkHg8jEYzs2fiAVZ83xLfBqv?=
 =?us-ascii?Q?yzGwn/YHskeI8YNUtPxznp0M2SwzGSNBdeV+Db559odCcSkQdfc3QtYCil88?=
 =?us-ascii?Q?Upw2rg32iupgbzbHd7aEIqRasCfS3459pNzSrsZ868Smf7yxUdDSyP10MRmU?=
 =?us-ascii?Q?xaa/kEcvWbVxZH/NuloN+wjjKHaIi34KMpf4Aqo7RnwY4tSvwjHngX1mNNYo?=
 =?us-ascii?Q?MZFbxQgBPI+M8iQxCGLOSeCueXAc3MmDZ+R7H9/d581CtYj9csYzwxIqLR/v?=
 =?us-ascii?Q?sddWE03rM6fefSXi2mT0jwNLTugjWXLvJ5/8cgd9tMx5RveEBrkpePR6CaX3?=
 =?us-ascii?Q?pfypc9qNQxcu1osF5bD9tgQhgvG6Hr0T7iC95OWGUgaMahdv79Ypdlz1zVZ3?=
 =?us-ascii?Q?N8QX+6DqB62gt0t8892k++8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f24ece0-6777-4c35-4ae3-08d9d3e999a5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 03:30:50.9473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjvzYPkKuMY9aDyVTl+IoU86jXkoK/f3MD56z88ohlJIhnBnbj88YUhLq5BMHnTbWnhIORoFv9Kz1K0cI7UpEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2569

This patch added the fullmesh flag setting and clearing support in
pm_netlink.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index da1bef34e8e6..5fcf0f979579 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1766,6 +1766,13 @@ static int __mptcp_nl_cmd_set_flags(struct sk_buff *=
skb,
 					entry->flags &=3D ~MPTCP_PM_ADDR_FLAG_BACKUP;
 				else
 					entry->flags |=3D MPTCP_PM_ADDR_FLAG_BACKUP;
+			} else if (addr.flags & MPTCP_PM_ADDR_FLAG_FULLMESH) {
+				mptcp_nl_remove_subflow_and_signal_addr(net, &entry->addr);
+				if (clear_flags)
+					entry->flags &=3D ~MPTCP_PM_ADDR_FLAG_FULLMESH;
+				else
+					entry->flags |=3D MPTCP_PM_ADDR_FLAG_FULLMESH;
+				mptcp_nl_add_subflow_or_signal_addr(net);
 			}
 		}
 	}
--=20
2.31.1

