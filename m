Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4025A28E4
	for <mptcp@lists.linux.dev>; Sat, 28 May 2022 15:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653750750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+6+uwafSgTmnxF7pv7NrORO4rz5yqB1ov+6o6eowgYQ=;
	b=EYe+60T7u6/3HpFxkb2jSLi2U5F+L4zFnB7n5mfTUuSf/UiGDKNMhzOsCgrq+X1qMWFM/N
	iudiMb6rp1snHWho1+bAKTRH0jm8wGsngz9uI8wRo3Tsm8DkttAdgOMSepGgDhUZugs4qL
	BiSGTbroznS6nMumermK5SSc7Yn+vB8=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2175.outbound.protection.outlook.com [104.47.17.175]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-43-A7j6kiG1PMSTnGf3HZ3OAw-1; Sat, 28 May 2022 17:12:29 +0200
X-MC-Unique: A7j6kiG1PMSTnGf3HZ3OAw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZzq4C7HcWN9H/X/EDyfmVx2xzflBdd0SvEMphUwHTAS7Dj0KTCYi8kThjgI98xe8ef/RkyVdRNpmblkYc2AlNilAGtO3dEitdqMekL7pdf1itllBMcddD5xQwkTb92gAo2xjhA533Zqy6bitWPLBM7lDrkdGUipQvJ96qmFwMlXWH/F0kLGq1/ejyfN8AFHfrR8mMJVJUN2OhwmCcMFURkUfBy1KI4O1VCnWmbxwFrgbTxkDegXVCCnCZ/Ph/VJK1/Vtu+QVzXglfC8QDrEJ4+bUeVcIVU8TAOzobrOYp2eZ4Fb4BGS3b4oeYDXF7A4StDaavUHPZ4G/rg5/apqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCRU6PhMc0r4SiWL9K8boAx4U86UXi2rvAI2zVf3IaM=;
 b=g5VC+gc3nWcqyolUtycLlIhzrLNM4BIe8hZj32XFsspGvBMRL/KZ4KfMLFVh/El6Qe+W0fNCw7yx7UOS7JG0MsaLzGBZUXGpwt4Xum1DJQurcf5Clx4XOcMzaqPK/VH7Notc0itxVbt0NOeIt4db64WdKTeR1tsdZB2qNpJMp/OouxDWWr0LNSU4K4u4bAJ5XLdrzZS6Tq8FPFvRE6KkEQpdQRWqVswkwSi7CsPO+XUGBCdUZS4NkZwvWk3KTaJPLm7iUKX3t1Cvn7pE+q3X/VuSS/xzmruLyyax/jckgWp+e8ctXBgzK6m8piLxEP0bK0R9WXbSd+nrkazOpswHvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8485.eurprd04.prod.outlook.com (2603:10a6:20b:418::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Sat, 28 May
 2022 15:12:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5293.017; Sat, 28 May 2022
 15:12:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 05/10] Squash to "selftests/bpf: add bpf_first scheduler"
Date: Sat, 28 May 2022 23:11:47 +0800
Message-ID: <dff4c274ee3efde3bb6da746086c8d10b967582e.1653750351.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653750351.git.geliang.tang@suse.com>
References: <cover.1653750351.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0063.apcprd04.prod.outlook.com
 (2603:1096:202:14::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 389ad975-fbc1-48f7-3c38-08da40bc7ab2
X-MS-TrafficTypeDiagnostic: AM9PR04MB8485:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB84856DD0BA308E51526B0992F8DB9@AM9PR04MB8485.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xeJTDPSfnrlTd+ixnvpW6NFkYSBr0GROo8cDO6xj5jrJWqEBgSquP4rKDRqGGUQNgbTJW2A95txpUs90gS8SpBrkWOfKowv+L+S0OGhsbucPC9ko4nP6lHLqbDxSwZpcqzNU0QNr7bPLWGf1Aiv6rSpEeZsf3xeeSnG9NUgyjmi9gIkppunKghsxBbL5JVjFLRp2ciXSjln+SZhNwRAfToyzQSAmpk5STQ+Y99SlpkjpkCcZG4VuIojK81d5fAFTpL1IxnBic5HI9EB07AaD/E4rJeEc+Q9IqCZt0HpCn0zrSXKXbRMQxfhbCBGvelk9sgNH1O84brzVAyaiNLq3DJvPqJvxkf+fnuy+licCC96Q8bLZtPqINxnNx3l3qHVCEm7XtwemAJjJl2udcxnZWbbG2pxRPsgt01IvnuU4xz6H0VGYylaXNeFMr1y0Xfse7Qy30HXQ2mVN+ZEF+i5vRhT/4Q6vjF2aw5aYYFosHcMJIG18wcMqUE4KZYy6V+NRZmyl+g4eg+d3qrwDLcrZ/g00pkKofrp/8x5amuLUkMg+hMybGvmh+Nlm4/HBlOYdajxHSV7bhYvLBRmEj4HxmWDKk+uYCmOyt4HTIbrR4tsyKQL4OKHwc5e3TEFGbSTwaZr7l9FZ7zMy+GRVCLUSt+lASnNQub95DmtNffABHJvtBTRch06jhvrHkycBITKWc2wP4sfq19iJSYzrujyTEQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(83380400001)(66476007)(38100700002)(4326008)(66556008)(8676002)(86362001)(186003)(107886003)(2616005)(66946007)(6486002)(5660300002)(4744005)(2906002)(6916009)(44832011)(6512007)(316002)(8936002)(6506007)(6666004)(26005)(508600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v0L4umDkXmINsSFEf14bGF60LPBhDfWGhH8KAJWnvJ6GJwoAtedDdZTeouIv?=
 =?us-ascii?Q?xzlSDn6Bf2lAeK4YcXmZAabIcmdAUM1dKAV8d1tCyKRIl3K5J2tT5tR8A4qW?=
 =?us-ascii?Q?tIVmErTk9zQzZ+7pFVbNsrLKb9DCzGlP4yPMYj6aJByujCEX13WEbd27CXgo?=
 =?us-ascii?Q?ZlDpnhzcnpeGlNx0ypVMcHuR8Scdqno7rBhdjFSyqeln13TLk0YIvyH8gwkn?=
 =?us-ascii?Q?InoFuoMuGoGNF48KH6/NFAM5RjfwyBRyIfFb4L02jGwS5D9Oyp2IFoAkN841?=
 =?us-ascii?Q?tNeMNMxucGQSSeFwm4tHqTWR+dOAbc6DxqMLN+zaTwC4arXPddSuXwp1uFUd?=
 =?us-ascii?Q?oyCr+5TxYxPidAcAiJySzjJLKpl/GEbMs9KXpVrXCocOhUSdXgOAlu0JAQLa?=
 =?us-ascii?Q?d0tyl9Gk9+JP+4irfZktImm05s+122G6tLyVNkL4JetkbQ6vGum3bG8cNT//?=
 =?us-ascii?Q?wdOwwBqGdhLXrAWIe+cPuyRRRBpUpar3Th6C6tUp7X50PhmeEx65ewrvDFyB?=
 =?us-ascii?Q?8tx3sdoovnapW4oI0bTCgrMHQzkHEUPqU5mfMf5FFqGH7eAQfuJUD5A/F08U?=
 =?us-ascii?Q?zUk1M9MVhK7plhJOBKs/rfiVRlHhBs61+ATnWdyFSpjD8u1jllDEIF0axOFH?=
 =?us-ascii?Q?GoNza8ZfWx/MN/x6asaWXF7gB6vQ0Yby6uEyml9UtFqWGJLk6METwbLbSdnv?=
 =?us-ascii?Q?a4tUyfbONtTQrWLrYB7ybMai6mgFxpRC6nLzraUlpkoYTozXykLxceRSnbU4?=
 =?us-ascii?Q?t2qkrdvwErlYVSyJrM0y3ZdJjNeSAqUdf0vBwC3qD3ETo0Qo9h1gDsJigwwq?=
 =?us-ascii?Q?RGHMW6TEvye18FFU39ebbQTXhDN4UjqIKJmnFXpzDUGW76TXa0Bb2ME/64lz?=
 =?us-ascii?Q?dPSdWlobrgi7BusLek8GOaixkP1I+ip9G6+JdlizW9RmZjgDt8kg2fWmXgNM?=
 =?us-ascii?Q?iYBZJPRW59qU4fNv/1yUVSsAuNS2huu0sRTHSn3wIL7/8Y1mGxUYTo8c5sp/?=
 =?us-ascii?Q?VUISAfAhYeaWWoaxBsqISOUwoU2FHI204Wvz6Bw++vIoTCZFuFQfC3oJ+Exz?=
 =?us-ascii?Q?3egWL4BCjCYaIGm5dZacEW9T8uSFyfaOj7AZCfdyaWsFV6d+iZGgNMFVI0rT?=
 =?us-ascii?Q?rt3tHN67TDRffCsburOgYQCMtFjFzqhX11jzpIIqj85jXv3wjl0wsb2FRS06?=
 =?us-ascii?Q?ibfzlL28i7/8eVdKG3bl75xw0M1Vy0bKMZRLYQRecK8u/Ty77cVwodlUMmAa?=
 =?us-ascii?Q?sILktgdpFxyQP/Gs9IDj4ozxpzlgRrHDEYzX3q2C3qOYMmy07Rb92ePz6Aqa?=
 =?us-ascii?Q?b9DbpzhcqvAVzctc7aFEyCjgCPaViEN+pSRvYGFJFkE9opsNIoOEWdXlomRm?=
 =?us-ascii?Q?5eN4Qp8bJWQkkm7Kub6qYpp6JbshNRxYB4ASoPgHnJWxlddIecPlzfx2lypD?=
 =?us-ascii?Q?8Sf8zyPWWFFLuoT7umd3pqWkHIskeSlt9Z3VKXCIzPAyWvri600yCaF9RqY6?=
 =?us-ascii?Q?VQ6lp3Xe/tF9xEmeOmsxBG/D3K9e8AqaiNvg7c7BQXeemDmU3TWP/3prWbF5?=
 =?us-ascii?Q?q5VWMTFWN165gXgoKg0E3Lx2YK6ftQ5dbiPspFC+IkeuCbpvNAaodid9HM3m?=
 =?us-ascii?Q?aGbuRKVrPHH7fO22ysb1UqljrCcdUOEJOv4pSyxuAn1apySidOWDsRTj4eu4?=
 =?us-ascii?Q?t4g91tW6cP8lSohFyMltcctFFlb2RhXI35HMkySLQmXaW1EgJmHc2IJD4MLY?=
 =?us-ascii?Q?454L3fiRYfgEO5hA/iQi3oA6ZZv5Zuk=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389ad975-fbc1-48f7-3c38-08da40bc7ab2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2022 15:12:28.3658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SFZmBu4RcKIlD/79le6JZwoQAlLQBy6OWTTvvZ2nv9A7iHZJCywqnNKyxCwsjYNPsgLVDOJ2W2QPbyUi8X2CfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8485

Use new get_subflow API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/te=
sting/selftests/bpf/progs/mptcp_bpf_first.c
index fd67b5f42964..0baacd8b6426 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -17,10 +17,9 @@ void BPF_PROG(mptcp_sched_first_release, const struct mp=
tcp_sock *msk)
 }
=20
 void BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
-		    bool reinject, struct mptcp_sched_data *data)
+		    struct mptcp_sched_data *data)
 {
-	data->sock =3D msk->first;
-	data->call_again =3D 0;
+	data->subflows[0].is_scheduled =3D 1;
 }
=20
 SEC(".struct_ops")
--=20
2.34.1

