Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983661FA0
	for <mptcp@lists.linux.dev>; Mon,  9 May 2022 15:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652108490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7/Wtg27IArqnG7ZvLzl7iOMdqSNO3s3ea/08k0HbLaE=;
	b=N/E1zDD3ZmG0XgpKoA4wZ/e4HCa74VDNOKX4PRJFvkaJvOTSYyh771RXgxVd3/u7sybxzE
	S0xkmDCUvAwkru+lF9KDsz7dAD0BymDcvI7BmKTY76ulIIwQrMYg+SXmfOSDMdVIezaqxB
	TlrhGqMMMuJDylBOhve6rLABT4O+WyU=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2057.outbound.protection.outlook.com [104.47.14.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-GZLeN9SZN3iw-w_LSkIwyA-1; Mon, 09 May 2022 17:01:28 +0200
X-MC-Unique: GZLeN9SZN3iw-w_LSkIwyA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYhuIqd7qMmWi3e26RLkXiDnIlSam0E/vilvymfm4u09pgnxABVFJhyxNAmSClJ/TKcgU0Aoei1wOc5eKIdLxQH4iuRz6k6D5yvoRLkycvEA/2XAAVPxHW4r2AXRJ3Pd2tZcKJqCfhm3h0JrB/fol/4JBr7NqGz96fA108DeeRtqwsD8gA/VwAwtoX5La07+0dJGJZ5Kiw4+xPw9vr3iS5nWGt6TQDaWc9iwnyR5EAcHPhlCSn1PO+nOpfo9HVl+Abl6nsM/oYmHiRjdQPGI4d2XA1fVvSC/IyOVi+yb7EuKVtKYCuk7Fizdv+hqiRhSwJ8BYYKLLbDKzM01GYVLtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqaLfTEwjRJOvnGoZchTs5ZXVzg5LIPMOusZdbb23n4=;
 b=lOTOcW4PeoHV2QgQ9UmTRLNXfY9qDfsODvOeMiksy0ujiBTOgePvdJ++EKwCfxXfOdOc4BY82kpyedXpCVU4ouQTZ5xyy5EAAFKz4tcINEDBA2x8tLXqfuAKnfyAR+xGUmnep2S4YPfCVb5NfsgxbnllTiuXhBsipCtyE+l/raTddULRknKQR2cggmbMRxxnJk7u68Y+O3zm2FKUiW9p5ni0ypkh1KUUZMlQQvwD5zPntRhc2O+LcWldDrhp4HqK9qeHYX89nE7Ew6Vb8Owoe9+pHuvr4M0eWralzDxtQlBtClA62HNeUffyh2PGl8+Pzjk6kSaDrgP3H3+dM3R5vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR0402MB3924.eurprd04.prod.outlook.com (2603:10a6:208:7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.28; Mon, 9 May
 2022 15:01:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5227.022; Mon, 9 May 2022
 15:01:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/4] mptcp: add redundant subflows support
Date: Mon,  9 May 2022 23:01:08 +0800
Message-ID: <7455f0b7b02d6f2edac5fca53c8667e1e0e84533.1652108279.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1652108279.git.geliang.tang@suse.com>
References: <cover.1652108279.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:203:d0::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff84da2a-a549-48ce-8d30-08da31cccab6
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3924:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR0402MB392415B3BFB03F166F1BDC1FF8C69@AM0PR0402MB3924.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IA/AwN/ZCt4TbEMSjvNh4ZRuJAcAUPGL/uyUxDG/ezzNFsDm99bSmnqfQdyKs6Dz57iVva9aamQLrFnvHBcKc9nxYa3NQEnKjh64Vwplh9J5KejRn/VJgXYluvdyINhgwPRafx/xPKY2UloM2DX4nT3u0bn27e7SIxibRClNZ/xvNrOpNvH1POIeiIqjqBjyrO29d/hzYjSCrAxQ3MiHuARU6f0gR21Xsc26wOqXbRnZZOF+fYNFi6DgblZCH0pCgC/ybR/oyAmo9EY9ADOv2B1xzytjPf4xaamN84p9p+87tAIgQQMSROYP5DOeYuuiZW5L9JDKw/TFtiOdVHnSNwVLcv3YmT52Ec+NwdF5RYSrzBsT8KNHtXJkNAgMlT/xzXCZBtVrZFHa2y96KZHI4sJE1XRXZPeMqZfFE4PISG3SDtmmvodV/DWnHs678+uAjGYPuWd5atdDxJiLMzpIMa9gTPITdiMzD0YQfNFLG+1bn9fXKwq3vlhGnFtp7LGma2zrGVSQECa1G+iimvNjDJp0iy0YgVN+oVlLJwD65wUmjBEiWB3c+fQrypsvyZmd9VNSczKibNSwFURype/YpZkm8IKvYDrR2HJCIffFtHHKixenhccl9m9tPeE1w33bRO+OHhiO+p2yUz8ozt5wZJ1ao8uSaMKjxHrd/YVY/FBgxI5Hm5FbIDxNogjZLSX+m5SyTkKpRtYpNF55vwyFJQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(6916009)(2616005)(86362001)(107886003)(316002)(66946007)(8676002)(4326008)(186003)(83380400001)(44832011)(36756003)(66476007)(8936002)(38100700002)(6666004)(5660300002)(6486002)(508600001)(26005)(6512007)(6506007)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OPMfjuvQPUNgsw6c0IzgHn0vfRwn0ClD+Soj1Bd+r0Hy4l6adiTiEyq1gvbk?=
 =?us-ascii?Q?3WcQNNKbEr9YND7NxC/9QWsE2yca7Lh+buzV43zP7kDvYpgB9/mDanYfqRWj?=
 =?us-ascii?Q?jGInXHGeTlT1H99oiI18dH6PS7PNaHo4tXxP9Hd5vmLl/hZCBaQzPiX5WbSJ?=
 =?us-ascii?Q?hGLb4ygKT94Lwpi32htkWP4jEexVI6M8BiPU9ES8/n+cJ16d7nv/mzoUhxPL?=
 =?us-ascii?Q?dCeHs/j7KXg0xp24Spwrx/nZdIoIutohMbxGmPQorLM+J11Hp5B7CPxoWnFA?=
 =?us-ascii?Q?xf2EIFSIYsU5aGgj/xn8aMRRjPokXMjWx8SNPgqIssONFGiyE6W2LylPcBQ+?=
 =?us-ascii?Q?s2DbdEhIJKFHAoIoe5dstIVaogfP1H1OYRH0VB7+sH8uKfItxrSfmoQBxVUz?=
 =?us-ascii?Q?bPTK9Lfa+l+9cyAqenDtiOcAdK0OiUik7yfv2PiSws1UAcu4roMWkZrBTPiz?=
 =?us-ascii?Q?tVaBtFvufYgr/XULbJ5MAcxq4NtW0Dvs4/9QkUJnZ6eryj5/UPbO1KVWEDJc?=
 =?us-ascii?Q?MvN1WEHQdpxW9woHkxN2W5Q0kqELueS+oF9VC8Nsv09avIj7vdxlmHYfLp4R?=
 =?us-ascii?Q?2d4LxxRwTBicPcka2msZtaRsC3/R/wn+S4xE+q6EOtB07iHPTdX6hLp7vEJG?=
 =?us-ascii?Q?4ZvBU6LcbR9AFYY2Evcj21lS8IwyrNg2xanP2Dy2kHfuqFXrumSazYiCdWWs?=
 =?us-ascii?Q?I8FyDOrV/lZyYHDWIaR32m1qbzoCwFxyRdF9gP4hqwbyE+ddUVdoL0OAetYg?=
 =?us-ascii?Q?RD0mdYYbRYHxJhJIjYpzYa+9OI69YlEUAsbFPy0B9ypFEo1hWMWzXB7n19XR?=
 =?us-ascii?Q?sc+NAdsVOsMXX2U2UVIVMv/4pPvaoMK8w4bLw4a2rTvnNmZKGdiCzeFOorlw?=
 =?us-ascii?Q?bsKG1HmwprxANWaMPKiICQYWPCKnY8U31WqJwwPBuH7C6d00AVngMYrsXjQ9?=
 =?us-ascii?Q?sqSMLaB4tV1EfgJt5sxEP4N3ykhmqNcK47Iqdo5Arhwajg/00U8rGxttqRyu?=
 =?us-ascii?Q?B5KkQzpg6FOQ2Hf8fk/lVoVGTw+C+y2KrUzOBSn7/aHJKaueGhFHjIKbsw54?=
 =?us-ascii?Q?zQP2gjf8ME7HIhehJW6rygdqEXNUlTlg2Mv9teHkSt9blSFU6VKg/vAc2gct?=
 =?us-ascii?Q?yABlWNdx9hWXsaq0ZYgRJ5EPU/ksyu5Jh/CUnkpKDO8I3WQaD0bPgAUFjjEr?=
 =?us-ascii?Q?/LukJVnVnTlOWT9GlYEWVvBM03IOD65ZJ48YfuXt6mTXbJ5qvGngJSpv9oqN?=
 =?us-ascii?Q?dD0LQKJS5t8HEJEigO6KICXo5CAQuL8l2K6j5cOfoCNvpbiA67GJmpGaXiLu?=
 =?us-ascii?Q?T1QQ/KNuBH6V51+LyUt1tOnxA88zNZhjBJfwILZDnkn49Kfbg/B0wv+HwGwm?=
 =?us-ascii?Q?eHu4GqQXFix8jQOdeKZRJLCAgduKwtCsAzHTs5a2a/wt21ET62A3FHfUnNBD?=
 =?us-ascii?Q?Vxe8ie/RTMq2fGF7URJEwjQnSaWChfPzEcOrfzRDPnvumIZgRkmGF1iSVF3o?=
 =?us-ascii?Q?/HoQckAcJ2BiG99xSr78ITVXH3pF1gKEASemFvuCEWZ0buVQISYGEcEUr/HZ?=
 =?us-ascii?Q?IecNuyDrA3HS8iUaPh/D7Hnayk8+UGVMMMbQyrkjdhsbJRafXMy3s5sZOD22?=
 =?us-ascii?Q?OC/J6ksXnsPTqtCQ8bPj8RlyaVOoBxy3eubkLE5JraNAkvQLB/zywvcO0a/j?=
 =?us-ascii?Q?itQA8GFNP28cb0UYXwzfVscjUjzWpkRDiPwqzLqpK0R3TCZVtwVZlkDvK4hO?=
 =?us-ascii?Q?6N6MbvPtXqEigGWSb+FPWUHfHPwa1Es=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff84da2a-a549-48ce-8d30-08da31cccab6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 15:01:27.3834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E7AO9qe6QFi740oQtm0vxAlbfSwROIBtCwxJGxRoFuCSuXI/zb87AmZ6eFG7Py0TfX/LJpagg6IJSRrAx8uvcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3924

This patch adds the redundant subflows support, sending all packets
redundantly on all available subflows.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h  |  1 +
 net/mptcp/protocol.c | 13 ++++++++-----
 net/mptcp/sched.c    |  1 +
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 345f27a68eaa..d48c66de8466 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -101,6 +101,7 @@ struct mptcp_out_options {
 struct mptcp_sched_data {
 	struct sock	*sock;
 	bool		call_again;
+	u8		subflows;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
=20
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4a55a6e89ed5..e3e1026aad97 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1591,13 +1591,16 @@ void __mptcp_push_pending(struct sock *sk, unsigned=
 int flags)
 				goto out;
 			}
=20
-			info.sent +=3D ret;
-			copied +=3D ret;
-			len -=3D ret;
+			if (!call_again) {
+				info.sent +=3D ret;
+				copied +=3D ret;
+				len -=3D ret;
=20
-			mptcp_update_post_push(msk, dfrag, ret);
+				mptcp_update_post_push(msk, dfrag, ret);
+			}
 		}
-		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+		if (!call_again)
+			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
 	}
=20
 	/* at this point we held the socket lock for the last subflow we used */
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 83377cd1a4de..0d5fc96a2ce0 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -104,6 +104,7 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk=
,
 		}
 		data->contexts[i++] =3D subflow;
 	}
+	data->subflows =3D i;
=20
 	for (; i < MPTCP_SUBFLOWS_MAX; i++)
 		data->contexts[i++] =3D NULL;
--=20
2.34.1

