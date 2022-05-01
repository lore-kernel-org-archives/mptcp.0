Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA1628EB
	for <mptcp@lists.linux.dev>; Sun,  1 May 2022 13:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651413456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D9Bad7WF2rpg51Ltsn/U9BnRpoaQ/rMmtcoefWcPw6U=;
	b=Npah68JWextzSOm0IcpdNI9o4t+YhSFtYOgPiMakmtyzXGEgLzRONMNObA0FfIsGzLhgPy
	YGlamafuEOkiF6Qy/0VZ1uYTdgk2lHaYM/PMp16F3FF36stKaun/9UANnurJtnTObPGlkg
	CGft7W2TlowV8wjO2uwninxFq28k/yc=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2059.outbound.protection.outlook.com [104.47.13.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-26-uQx05n3lPxKbEoxMUvnSCA-1; Sun, 01 May 2022 15:57:33 +0200
X-MC-Unique: uQx05n3lPxKbEoxMUvnSCA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erU66Z0GeoqHI58bBSzfcxv9CCJJF5BVbJFJHWMkdhGK2NjIxmykWyTd10D01+ymrwKoVoANdVuwaQR/8jdipWL0KHExXhoP8fstLYR/SNU9r/3uZY4u06ma9rPS3IBpY4ZSPnqLfGw/EQYuHhCIHUhELyPGI72GFlAVojcu61lZnPeJJV7PtNsHJHsIKezmQ1VqgmiCOX5m7PUILJzU6RXsUnyZxY/yYXIezewMmUu7/fRkVWAuleh1Q9BpR9x07Sf22bC6n6Al/SiFwA2pWd88gv6EtqTijXtnInAcEG4F+5iOxrdf3VEoUDffwUuWwE3B8+s6PK5NKj36bfty7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydplW64k1JeybmBNR0WaDyXv+VafYF79AY1tdQxYMko=;
 b=MsCUoYdAWc3XpVKcPStMbSDqxn7Erat7gbYxMRysCsxnVQh1iKPwLXOaPElPqEz2qNp4QmipSPgT/gvJ+LeLWIeZr+xpKQVeYT7seuMTh0JSmu7kv9kAZ93A14SNl+bLQJP4ZNFv1SvZBngFv0XN+5g08nIsiuzC0oIv+dIKjqqqLn7ko8ej0iaDYslGpyDvKp7Pzk6LWeIu0+uu+izZ6Ctp3xz4EhpYsGrWdIlX0rq7GlGsZy/svS0ESmo1P974R3S2wqQFFZ8VtDO0CWSa2wBy/fEMpSkMi4GbVBnDiwU7HeDfemynSVtwfrgD0fjbWD8duYxodzy/katT9ZUouA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VE1PR04MB6605.eurprd04.prod.outlook.com (2603:10a6:803:124::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Sun, 1 May
 2022 13:57:31 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.028; Sun, 1 May 2022
 13:57:31 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 1/3] mptcp: add subflows array in sched data
Date: Sun,  1 May 2022 21:57:12 +0800
Message-ID: <d944e0f6c9549f004d68083dd5ad2879b77126a0.1651413062.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651413062.git.geliang.tang@suse.com>
References: <cover.1651413062.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0048.apcprd03.prod.outlook.com
 (2603:1096:202:17::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce2c59fa-068d-44ac-a4bc-08da2b7a88c6
X-MS-TrafficTypeDiagnostic: VE1PR04MB6605:EE_
X-Microsoft-Antispam-PRVS:
	<VE1PR04MB660538AD57F086571C52650EF8FE9@VE1PR04MB6605.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wDYHDcQ1U9jIaiXQwLhcE7NuLorgg+UJ1q8BcLQ4RljHmYWf/zP1VN+1xBj2d/cUzM1695/nkdAm47jJOfrnsgysnqQbzF+zNY0pMTqJP11A9GCSe/J+fuuNSerc3ywZhqrzwTNOehQrjHG1peXzBOD8TEszZNoTwR2QbvEP1r20a5dOj5+9018OZ744s1MBP1l3ytCKEZP1WW65wxXvQlnufU2ZEy9f/ziaD8tznM94lmq4f/oAKi0VJQx7nVzkcyw0y/RwEI2R3l/M7SyA+at+/9sKaxICHFflLxtpAtcim7sxeeBEB77JfCTSrSkC9q5g8r2iuMDPW0g9oawkGKcr31Ky9/OfZrTFGHsZWqWpSliIPsUd7e27g2OVkeaQ6TvrSCwE+4GNOSmlvgVcb6rMr0+4O06rZ652lSRSDlo+ZgIkuy269pvi/sVkumEOaidI1mY/qsk0yzDy/t0FyMxtYpwebhT1QeKq92RMMuLbg4Gb0sV6B+/BXiwbNyg1aIQPRjz/IV1HNDZ93Yr16Ef03ZDVAEuDfa+Bs2dQVXUn/tK70tCgsV2Hhlk06fN28fMfRRNLf24WPlaUDz4oggukdp1QRCf/wb7vqfssvroKNOvPaKgyM8U/07zJ0NGui/4kcZgjQjtQVWfpkWrsDiSDiU7H15dmk2NTX74NjI7/EYLzswmcc0So9E3BEjE76TS4dTHmSBEWVU5d6YbiEQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(107886003)(508600001)(86362001)(2616005)(6506007)(6512007)(26005)(38100700002)(6666004)(66556008)(66946007)(186003)(66476007)(316002)(44832011)(2906002)(36756003)(5660300002)(8936002)(4326008)(6916009)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r+TKRBwaIHaflvrBslOTOe9C2/nhJCMFjtmnvqh362d4fl0IK4mnTIXJ9NYd?=
 =?us-ascii?Q?yeKnJprM9j9BZ3Cl0sOd6khSyxdqBBbH/B77cqtTYHYv8gK3VJJNqmQlJrZj?=
 =?us-ascii?Q?w5pkPvii+bNIyOIbCnDLEkhEt161nEUYJskLHsg8dGvx1GD7RK0n2/8YzBQE?=
 =?us-ascii?Q?BhOI59EXIwbxjL3Jv6KEB4X9R1HnG/3j1JvbaSTBYC3E5eq6z2WsQ97pocfo?=
 =?us-ascii?Q?Gfz8LcHV5+XFjvQkkgtexrW8n5PDd+Y0qmMZEeDPSDkKBKZFl57CwujB6jOV?=
 =?us-ascii?Q?v85Cpzp7ye9/SgzCqS1WmqW6Z92UPG4djojXrEvloLZzSb1IhxGxgT7AKSkU?=
 =?us-ascii?Q?to9hFFLSP42Y8d7miESG4YdhO3c2jNaULpSsvzsot3aFKaH/bregHj+WOJX8?=
 =?us-ascii?Q?HMqeEXUXNi2zqP6fNkT+N5KvITPmaC85PpK8x9Lb3w78+NONguWj2k9EsEv5?=
 =?us-ascii?Q?tUE1jCfQ8udqfWkhAgom9XoroVWI1kZGLWporoUafSmi8YnXSILpgLkJ9cfL?=
 =?us-ascii?Q?6HMpfqD2bdRfzw+kg5163xOF02zhaH2HoCKCOwBBQBS/6CfK3Qih6TQ7l6US?=
 =?us-ascii?Q?G9vjFdieFW0FwJAND5npE6HN2zFgIkcLdec9jjNEeCw46r9SNYxEXF6jWLKS?=
 =?us-ascii?Q?149vOLC2mhc/00gcAo+/jzSecaQ0xWvFoY1qebRYGn9q9hU6nfuPu5wqe/b+?=
 =?us-ascii?Q?wDTRWxViPwCuTXUuWZCy7HJ9ESM9VhUe6ldOeGXpCSClhApMVnqryLaSsj6H?=
 =?us-ascii?Q?9/p/n2i6Sjsq5SjluiVuXKpfZZrxITnrosDkLeADKm+PB09L5LQtDpVfrfvV?=
 =?us-ascii?Q?SgH20tx9bAnQgxns66akgaIs0Dmg9Xh1I+DnD/CUf45pOZevB9xD9Wx6/9+y?=
 =?us-ascii?Q?SxekyoDZhusIpWH8Ma3O4XHW6C9fitE1/rs74WEZF4IV12uvs2JmV+b6n1Fs?=
 =?us-ascii?Q?G4Jkm0DYZs8K4/+bt2C2HELFe43IcXV6OIPxyDf6oNQXZj5K/C0/VaA1pnmv?=
 =?us-ascii?Q?51rrjS/UbrS2oGoi6KDR/RnOI2nxYQaPZYXUuckCoOZWmIovQVurHWwYnpe9?=
 =?us-ascii?Q?GPDJ4OyyN1mkKmAjoSDb3t90Gpdz3u9OqFMkepO7qITnQm0YVFKx/0JjNy1s?=
 =?us-ascii?Q?ipYFvIzvJES2KH5nLjj/8dZCmw8ArQ53bcqi0C4DIbSxSDIo48z65iK453hh?=
 =?us-ascii?Q?KAh8cNI6mqAsSnbvdcQOgnxS+Tzr2p6YpvuPk9Q8ultEm1SAhOgxenvPpEz7?=
 =?us-ascii?Q?VYuOOUH6gCZvo7N90hYYTMQ0oc4VPz2OF8yzajyJvJXwpKlR1PPQfBzK/Qtt?=
 =?us-ascii?Q?80uKSN7vI41Qvkgz19mor9PLG27aJ/wDc+8VRbF/DAaMpfh8T64Wi82XmBd8?=
 =?us-ascii?Q?ldPhEQ6mPnObzkLNzk7PMNVxKxZvJy6Mw9vZ8BYvqVqU+4WRaxHFOl8YVQ8u?=
 =?us-ascii?Q?S9qgxjO4IwgzMazNyClQslwFNbS3brjz0N2knB3++/g2rs7sFRy3o+UhROEH?=
 =?us-ascii?Q?WuXGDNJXykzDwVtvYzSFRNtMNjsbA7okBbaDdgD8EyA/D8iQJbV68LkiYtrC?=
 =?us-ascii?Q?aLsDqgGOmGS/GSlnu9Rxe4SeTNHnpj+Ce1NRk78MCAUH430XuoXmxx2LwASX?=
 =?us-ascii?Q?2/vZI3t2WZZhRJw4RRcoIbaLPCGpp1n+Htr9W8e6gl81fVN8U3GLu36Nz3bl?=
 =?us-ascii?Q?j+V3+tMVotiGiElOYw8BmfEAdyrMXGWC3pHB88OTTQXsROS4vByRDqI+LRgT?=
 =?us-ascii?Q?Y8RvQ23999ry8DMaknNNAo8eWY740eQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2c59fa-068d-44ac-a4bc-08da2b7a88c6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2022 13:57:31.0039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/GFoMePgnJvHvwrxs6IpW7ueK8phDH274syFMISa8Hg4nOUFXLRmjTRKUsKw6xwGtHWa/oq9TlR0swDqWDl1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6605

This patch adds a subflow pointers array in struct mptcp_sched_data. Set
the array before invoking get_subflow(), then get it in get_subflow() in
the BPF contexts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h                             | 3 +++
 net/mptcp/sched.c                               | 7 +++++++
 tools/testing/selftests/bpf/bpf_mptcp_helpers.h | 3 +++
 3 files changed, 13 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index bea7608d72d3..1a48e31f3ac7 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -96,10 +96,13 @@ struct mptcp_out_options {
 };
=20
 #define MPTCP_SCHED_NAME_MAX	16
+#define MPTCP_SUBFLOWS_MAX	8
=20
 struct mptcp_sched_data {
 	struct sock	*sock;
 	bool		call_again;
+	u8		subflows;
+	struct mptcp_subflow_context *array[MPTCP_SUBFLOWS_MAX];
 };
=20
 struct mptcp_sched_ops {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 7a5654132ed3..1efbcfe80fe7 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -93,9 +93,16 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 static int mptcp_sched_data_init(struct mptcp_sock *msk,
 				 struct mptcp_sched_data *data)
 {
+	struct mptcp_subflow_context *subflow;
+	int i =3D 0;
+
 	data->sock =3D NULL;
 	data->call_again =3D 0;
=20
+	mptcp_for_each_subflow(msk, subflow)
+		data->array[i++] =3D subflow;
+	data->subflows =3D i;
+
 	return 0;
 }
=20
diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index e863954de701..1f991ff2e325 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -7,10 +7,13 @@
 #include "bpf_tcp_helpers.h"
=20
 #define MPTCP_SCHED_NAME_MAX	16
+#define MPTCP_SUBFLOWS_MAX	8
=20
 struct mptcp_sched_data {
 	struct sock	*sock;
 	bool		call_again;
+	__u8		subflows;
+	struct mptcp_subflow_context *array[MPTCP_SUBFLOWS_MAX];
 };
=20
 struct mptcp_sched_ops {
--=20
2.34.1

