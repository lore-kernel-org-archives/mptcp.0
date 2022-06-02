Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BD9622
	for <mptcp@lists.linux.dev>; Thu,  2 Jun 2022 04:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654145696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ckyg/JxA2V2VgnC/FwoYQ6C6XJThQi1trDzrhvmxwbc=;
	b=O/HStHUCUAVTBI1RwYslndua6IWAOL+DwLanQCENvhXSJCXbxQg7+uEe46uX0b78rEPpv6
	FPFbX6sD9CcPRhSc1R+HYXmHpJ4838ljExr5peLJEIGNL6olbWU/Usc1Lcy3rGdPkqWnuc
	XH2yHm6tBNOXqp7hchRFxAM0zXe2yTM=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2057.outbound.protection.outlook.com [104.47.5.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-28-AnZn6TrXMzGPjryLQAWllg-1; Thu, 02 Jun 2022 06:54:55 +0200
X-MC-Unique: AnZn6TrXMzGPjryLQAWllg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bfvw1QHpNnnTdbmBe8EkFdNpD4CWpVlhF++eJy96mZ6Vzb3xTsF83Xytpz1Ky10ZzydgzzYPLXGyR0nqqDlXP/+DvKq55DFnQWXUuyvIoHPrpb5PtdhZeOAnvyfpthW2iyZuzUw/qh5qt/eJVVxVLXxzgi5MKEFEIwZY+90o5chhEwiSWIEs8kcuirIydo9TxQa/AIddaMT90/RkBSEvNE2a2aI2t9d4QKBblnHbly4wmq2vC1h/xaxiAWZ8cIObdj7mWC2AF2UCRWITJZBS9HxJc4bDJ5wDjw1oRWg6wyIlgUoGNrpx9WtwIH4Hs4Em/DxbrOZNjpbJkoses5Yawg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySVDKnFJcz8WDTHlq6qm+UHt6uDvIGqKOARv/L5RnvE=;
 b=VbE5SauuzImoUm395wNve56/D76fKGEe2slHAyDvDTgoPMA7NiO/yyc8CXNcb5WBJGcJPQcvGbvgqY2Dvep5M2iuHkh4BNpGXNa5kA1vRC+QaBAX1rwpOePRKQaz87q8CYLocD3okGtRrqrvNk3NBzIzZLbGt2hs0p4k97RspdFTRMFn+7jyzit9C+T6mPvyvoVOUn9yWOxoYxRbZ2+BBfCddNZEpaDkFONqYblEXRQJ7omZ/2WEK7R537sYZWqBMXUvCZ/067vflxfCzJZpnnY04i5Wz/KsjYYHEMrkdXCfrAYhGIWIsoqJ9NUT1+DiJxYuu1DtR3KctT6EtLxpVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3384.eurprd04.prod.outlook.com (2603:10a6:209:6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 04:54:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 04:54:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 08/13] Squash to "selftests/bpf: add bpf_first scheduler"
Date: Thu,  2 Jun 2022 12:53:45 +0800
Message-ID: <db816c88010e4fb53ad5b3f1622ab49a6a7d1226.1654143895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654143895.git.geliang.tang@suse.com>
References: <cover.1654143895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a4061e1-0f9a-4ea7-71e5-08da445408ea
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3384:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB3384EE8B69D6D8364F9BDFBFF8DE9@AM6PR0402MB3384.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v2imgX4bClrb7XO8hhVyersFqwzLEdSk1iUV5bklv+v01P3i+KSM0w3n9ZTJfPuGPOdHbzNGAExH7TiFM80PhCA8MJ7TAzfNPfA4M9DsaYecPoMg/ZT+fQdUDnb5gQvY095gIa9BT0EMf3n8FdGCMaebYWKZKPN28VPDG4ROXZK2UJaaFTYBRh2b1Y9aAN8pfdXt3bueCpd/6uO68+jY3E+sSXyHGtNmPwDyLvZ+w1KRomj6tVFoPUJOoJUhRH6e2FHC4z5ELDT2PTPB1Cn7MnPTHC59YXqYGsNAdbZQ7/LJjxEeZ4iKkMrLCmWVoSxdDM2Kyphu7OoYSEjUx8hmIX0Ff6zwcns4YYUt/7z80bJJR2II8DGkkVqWEDe4SNO0/t0DVYjT89adjV8vdHGDxYlkgE5kMTBu8fwKlRJmB6tL378ftCmTQvTPFdEH/UWWoSGpqiq7KKdWiQC/T1EZJNC2NvVoBI+6sjDrL1tq7jspkWxi2z4GcPexmzE/yFhXSIG6eADo/REErkIL1HJdXzj6VeT+4w3e5AMuP8OJRuIS5oSK/dyOPmDMG4DLzoJuMGEN6lKJ7lnp2y5sTpj7GqtB5+1fB7rchD5PgeDXmO0FUURLAQWh9MQ6goAcNqJW1IkwcvR3IA660IkAEH6mPJT3LrEYiHa7+44aKK2mu1gDjGd+hkSv36HG+NWtAvQx0y88TqmEEq8TV5uGGaQbMQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4744005)(44832011)(86362001)(83380400001)(6666004)(8936002)(36756003)(186003)(4326008)(2616005)(5660300002)(2906002)(107886003)(38100700002)(26005)(316002)(66556008)(66476007)(508600001)(66946007)(8676002)(6512007)(6486002)(6916009)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/XMpDMQ3+4NAZ6lFSv+oJVya/2eiUA0AGHTug9KvIdDCRDGMATZQsnCPCKAT?=
 =?us-ascii?Q?Gt/FHouCNWR6fKdWQJMF2nSpw+lcQmYov+Zf00XTRu1Vrh2qeTG+LSEDqML9?=
 =?us-ascii?Q?9BUdIByJaOYBslgnFjwFXSJ/RCgxJ/gfcGo5e+By3eSsi6RY5wOoCxhLNZHJ?=
 =?us-ascii?Q?OfCEjfTGxDHyaGCfzsMo171u2kWWcZSJsKqsI3njNS2ozWSALxLXX689p21W?=
 =?us-ascii?Q?m7IdhbMQOmdVoNCPXTMxQPcWjDkfnijfBROzRu27noz9qPwcB4HCxjfWJ7hc?=
 =?us-ascii?Q?8jUYSDJN+ITPN4sEYeepJfNfVa9aKVW+wy3AIvWMdcdvbHaeux9/Vvcg4bDE?=
 =?us-ascii?Q?VmTISKE7hrpLdTSSVG8phGA6RxbUpVzVacsbcD3SAhe36NAfwZ2x/40DjQOX?=
 =?us-ascii?Q?9PxQBJ1Rp8dhK7oUjBYluDsMDSBRyKBLhy3Dt8jVi8JWDUL+aP0hPQTdFsCf?=
 =?us-ascii?Q?ljdM5zzIEuoCxf7GOs55Rtw6xamsUfZ8lLCZVj40kZdWxN5Q28Ujj6wG3CMa?=
 =?us-ascii?Q?wUSTklIvoKJhHqJhP2cAotVFAgml6YLvwzGiDrQoNXDeiuyOvx5nz4C8MqBN?=
 =?us-ascii?Q?VBjIOunRMIraEN7FIdp/k1J3OzdFU7l7w5xDqxWPegVSRntZ1you/V+7yms0?=
 =?us-ascii?Q?wjNvwzDujNopO8L5IzJl0kgPGMyr0O3PNZMPq/OkXRjmoVBrupOG5synqv/p?=
 =?us-ascii?Q?NK6WYtk1mOrTBxYnEcQmh3vTD8ap901Ep1OgDcMYbLksu+i3XezFgvBGkRKu?=
 =?us-ascii?Q?pou3X+p7yuWoMvEdhbKqbbOfQuaYd7JZ/oJ4dNO7dmd0httFAEvievo/Kqf6?=
 =?us-ascii?Q?VVOnLK6bJnVsAqwZ1+uBk6M+p+VXykmyMDe0BQ1O8KZ9cys7lxQEpcYQD5da?=
 =?us-ascii?Q?5/LfNasKzxjgJ+0VSqJke8ExPSnwU//+P3KN07xtZvc4FZ0uXE386+GNKtZu?=
 =?us-ascii?Q?g2Lmci3RUpikRUdYqgGidomf0vJX+IWausSY91hp5aIV8A63qdCLOuwJVRd5?=
 =?us-ascii?Q?1Um5TlCXgFUX0pAzO5QV7sSLRlZw82xu3e+as4c9yjVRHCYN/ALi+mTCk9P2?=
 =?us-ascii?Q?ad/Escmn7nL9GErUVqucwJFqfFd+RiXKPu0T2mypKznQzbnm+1xfZMqdP8j2?=
 =?us-ascii?Q?kBdwlU3PFBJl76AM0NQJs1mx/tuHvt/jOm2kKBuN3Z3s3UoiYwcqOX9l9+3s?=
 =?us-ascii?Q?f+4Kd8krlzXXv/HaUCV1ULGjEREXCZYqT8RdxbxadZKRwrtRNJMxKr+rvFDo?=
 =?us-ascii?Q?pAiMB/LQvwP6klEAhyGr+ExDi5ZDHfesriwtSXZc5ORw1iIsRP6noX6swTt+?=
 =?us-ascii?Q?cYblx1iep13/yeRpAlLuFuwo6Eo1zvKrZ9yy4d5v6jm8/uj5sJpmC1SeOgt2?=
 =?us-ascii?Q?6IIiFaXC+riuYuCZHwdO88WSIvbKNAHQ3N9t8K9vPuWGziE96dXAnF7lPqI7?=
 =?us-ascii?Q?HGN7pw2H1ICatbZMu3Hsx6vGs4YWshmK3d7NyVoSsiuix2QvzaGSGszOnFFE?=
 =?us-ascii?Q?3IfYFzDa3Qg5rRQ0XM6ZVUbw8z2oGpVy3RuLXJz/0iMbtL95zJ235qTma+jr?=
 =?us-ascii?Q?crHR7wR1FWuWsyZk/VX6nes6RYnT5HQ0z34YCW15G7HBx5FrQVBDdQVPJ/RQ?=
 =?us-ascii?Q?rNxPR9sSEl/ic9C6K0aBIBe6HuQMWmNczgpcULUbg25GMnckJI+GqVoasrYC?=
 =?us-ascii?Q?2HRYVp1t90gC9giM3w2Lqf69DMdcK4/Zbc1bZfxtSLiTYZt+kpUvtMJI/Fi2?=
 =?us-ascii?Q?wDqwXNxZIAqjOn1PQhZJO9s2RMtBiZY=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4061e1-0f9a-4ea7-71e5-08da445408ea
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 04:54:54.4807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngM6uO0T9izNOH9FC9/zw04SxzvHgh7pTPG96ICfLduqg9MfunP14UxMPyNCbrxHISmyBLD6/tymaeU3Wrm1sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3384

Use new get_subflow API.

Please update the subject:

'''
selftests/bpf: Add bpf_first scheduler
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/te=
sting/selftests/bpf/progs/mptcp_bpf_first.c
index fd67b5f42964..fcd733e88b02 100644
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
+	mptcp_subflow_set_scheduled(data->contexts[0], true);
 }
=20
 SEC(".struct_ops")
--=20
2.34.1

