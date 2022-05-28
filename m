Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856E828E4
	for <mptcp@lists.linux.dev>; Sat, 28 May 2022 15:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653750733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9XmF7HJpflZbQvfFsCpJ/iPdwLhcYjnRn0y9EBZnSAc=;
	b=SbI4pT3w4FP4bKJYNIv4BYOJaJDsLvCg1Z4oGcYvyK+ODML3QDLvFjio4OTgImlWPzi6L/
	WxLKVYsmZz81D3tLoQh+Wn48u+OaqZuJ3ClbyM1qSyjfJjcR5f1t2hpi+IpF4XKQS8LLo2
	QUgYsLf40dVa9tLAMz4Um+vHRfZ4fVo=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2177.outbound.protection.outlook.com [104.47.17.177]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-36-Rubzp80iMeu0BOV5FjzJjg-1; Sat, 28 May 2022 17:12:12 +0200
X-MC-Unique: Rubzp80iMeu0BOV5FjzJjg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8c4mS7Z03WbayMDr38gPqDomnOCFOGDVOfcSpb2psQPgV5HJADzsBQOYIXWtyagB12NzZ3fu/nyhIAlNDj3Pn76LyG9SAa4MeLwGYICslLVqkkgnWrc/wuK2QKJxwOYH2eDXALuFZkvBWBXBka3yx1oFkhIRV1LQNbGCYQ34BDSFUY2mNj+1O7z0L2fvHTbrZDlJdV4W+icoRc22tOlIPcV5mo00dJzplbFr3mFEhFesndi5HD166Cd+hcnSOXzAJ5YCFbVGzB51EQ+yhiFXsxP8Lt6GS4V4cX1u/3//PuHRWxK/BvsvEnT/kj/hsyUJwnjXt/oQCzY++jknc5fkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgB9d5ELINUzOk8+q2P21UZQ434MjG4JDSRjl8ntqGc=;
 b=OZSy+RrnMZHH7bIvq8ly2W/tB46fq+Xbycpjnn7YhY+KECdiRGnbQStxfSSbhzig9J266qw+u+Zh5NoucyoynGOLtJ76s3zxzQGwb4NFAgT14O55O3iBXOaDILTZxkJaWlaioBCRdAjLP8P3sz0B4ncUcXRUisMTNUHwiUALGUDnmn64mgx+d/XuSN5EAuKF3w3Jw7eITw9MQWjPC16ODcKD6324AsvtX/cwGYayahSGkcP37z3nLlcUHZvUfdn6vkMfOYOoSqbx+iGArSsrDZZclhgKat0TmQQC5mZIRsPAHQqEKb3gayQ8epFXYhNkPGNdkSC3D98ttMGLaYdhxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8485.eurprd04.prod.outlook.com (2603:10a6:20b:418::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Sat, 28 May
 2022 15:12:11 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5293.017; Sat, 28 May 2022
 15:12:11 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 03/10] Squash to "mptcp: add get_subflow wrappers"
Date: Sat, 28 May 2022 23:11:45 +0800
Message-ID: <ae60bed30cca593369e8d5de195c84f815a16217.1653750351.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653750351.git.geliang.tang@suse.com>
References: <cover.1653750351.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0085.apcprd04.prod.outlook.com
 (2603:1096:202:15::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45414fda-f6bf-485e-3a16-08da40bc7076
X-MS-TrafficTypeDiagnostic: AM9PR04MB8485:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB8485EDEE3A20937E805F0713F8DB9@AM9PR04MB8485.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DQ2PFoFVrZiw0D7Vt0eB4w3s3dPTXhBbcGFuV+kxfRamAnzVUOu6fWVjYIQmKn88AYl29OfQcdpWbHTJ9gwWYeyBb+q0CXC165Yb7RTu/XxhM1+f6KR67tKBHm2r03eDzZWgpeDPoy9iuUQfstTHAa+rWPYrWEzqNrrVhtG1Ot/Wh6sAGgSX5LqjQp8qAT1Las6Q3WeXP3TrEuK2ZnOh2KvDmA+69odC0rXTXzEC/jylIBgOJ+prL2z3BjoYm4UghFWSwh4Xrp9koLyuaG5pbZASDgXo9938i8nhy43yF0pxkZ+v/FGJFFM4AAS0AMnHows83+ctYM1TY/LDD0+jPm4BR+snD56ppSTLKZiEj2+iUpITu7F0UFLriid1ALOg4CEtgFMcwGNJbr+y1h2/WS37YvtB4vqc67dovxzAE8Gj54M/ArnBjDbOZ6bq2ZxDUiS3VlMC+Wt87Ac4R13gy/rvPBEzIbbF8b+A3oqmUPFyHffr7Z/0tLOJjFjfF8HqlBKAVhdXGRYDTHkOib4dDt3vYKEieu/jgyxvRfzkctPpZnN77JdripnwLnfKPx0DUU3z9EGJZirLe2aTJ2PDs4wcrkKDxCTUFjH8HuLyGDdwDr6yaDW5Z6GS6oC/s+bdDNThPWyLBZr+bd7zWTpPlMdrSh+ITzmY8GFUcVggtW7vBXkwHO/mD57Uw3XV0BWMAK+O+tuTILYorlf+0o9cxg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(83380400001)(66476007)(38100700002)(4326008)(66556008)(8676002)(86362001)(186003)(107886003)(2616005)(66946007)(6486002)(5660300002)(2906002)(6916009)(44832011)(6512007)(316002)(8936002)(6506007)(6666004)(26005)(508600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oj1xzJRnt6ACX5tGmZCszrpBesxFgiXi+7D6nxpZW53EzF3PL3hO8N52gQ0A?=
 =?us-ascii?Q?sdpslgTZdS2HfMZNpnHb31dsk0Oq/Za0w6bqeScet/5TWGhY+qtlYAlz6ccl?=
 =?us-ascii?Q?+/gvEm53LALo8x2Tr0IKLsa/3zElOXFG6ydwwaEcV55SYAunantSmTtk6zCC?=
 =?us-ascii?Q?5296epkd/fE238g5xoVV0Fza/NOkuq2SWoTI2JKhX3DN8Es9C5EMDXGDd8xD?=
 =?us-ascii?Q?bSGwmRzyvxGeIEDRQom4RXBaGSy0UbJOF9PSPUxiQThvZBFpRskiWLiCKzyI?=
 =?us-ascii?Q?BXtAv/KpHIX5oJZxOrniunCyj2xXkK025xJOn625fsuA+xhG4tvMHKg/KSuA?=
 =?us-ascii?Q?LcwueEDLNgsj3ZY9QoO3tqpaozYf/MLpvFbN+6ZElU8s800z6sBnubTj2Zwc?=
 =?us-ascii?Q?lFg0vLyVhWB7hvdwI8m0xGJeY+qbrlq6w7Yaeeb3eqBl9RnOi0NA/pJybDXa?=
 =?us-ascii?Q?rcvMwdMDF3aYacPVx2jESzB+SRb4eGaBk6oOHnO354mjXkqo1lSqTEUxKuzc?=
 =?us-ascii?Q?brWIZClFVFQfQc3x9NGXd8I1fC9xxg6m3vS/y/YP5voGu/6NnnLor8DwP1Im?=
 =?us-ascii?Q?+3J8vieuvSDKIOeaUvOEHp21+gC1P5psShHR1yhg3bvz6QClLss/CvPUs/ea?=
 =?us-ascii?Q?xveJ2aKtE11UJLHO7f7+aXXokwEL5Y/gBr/Qy96dktannJdCCmoDp4+1QtE9?=
 =?us-ascii?Q?v19tnIdmSI+4ulTW4aK35mL42TuJXsmnn9/L0o4KTH1yzl45sdF4torQ2oqP?=
 =?us-ascii?Q?AiJSW2Jgee/OATGU/UnmACbZZuT5lMJYDiU1/IJz1kEq58/HyKo7IrwyAIjI?=
 =?us-ascii?Q?131hnw/WwV9iJAE6jEDfM20tpNWYkqOEu1JaSVRTb1aK9okvZTRAoijBgdhS?=
 =?us-ascii?Q?Su0HXG8gQkaISEDPYPwEwgGzISda6i9CIaphidafTZlq02iB9FUy0NRWr3Bh?=
 =?us-ascii?Q?O0HT0VhEsDfaAp8ikId5zmfNmV8j5bNOMIa8Z0qsrfRv/hEwd1LJR67JvFJP?=
 =?us-ascii?Q?G97ZAgsnKMK1/91zQRuq3PpPXCP3b2LLqSScz5oIKH8GJYzh/TGu7iAR1PCH?=
 =?us-ascii?Q?p/PKiNsOh6DfLZDzdigwx+eDXfDj+Hfe+5yRdq4Cz+O0GoAORbwbrOVKGOAS?=
 =?us-ascii?Q?Rf0v1l5yMG6DQpeaOJivIa82tI2JAQoXNHlZspZ3X3HD6GTHN2TkeA84pT4S?=
 =?us-ascii?Q?DHVsnUtysLzEN3vuAPAa2NwAOyCA+AOywopGYHQBubrOvvR0jk35TF3g5FsJ?=
 =?us-ascii?Q?FMxndPUJ2i449Iol9WIQCyEUNbw0r8rDyqOEjW8qjXEhDaBlFJoG2Wt3rf2E?=
 =?us-ascii?Q?M48Lnm94Hbz8sFSRJEf34ZdeuHt5HUKTIq2Hi7X89uvnqUWtlgLdXpmGm2DA?=
 =?us-ascii?Q?YrLOp3mtuxVKmqWbaeSU7rdiHv/c59FjBcYyupoRVq+o8/eKV1e9QAxZwWpn?=
 =?us-ascii?Q?QHSQGGTG2Wc5Sf1iQcMu8aBwUexJRilLZAvVxxSgSUO5WS+sQGuX4OvVs3pW?=
 =?us-ascii?Q?0V8DsNZ1VKB+pHsSDkddyX8ubxnZqo/FM1FSMFkhAhbXEIVeRxnZOcJ1FMql?=
 =?us-ascii?Q?8wQuZFZGdjrg4C3HnEBscFyVuRvH2eBT6cwfn0Quf2brjOyzrXNaAGAnIg19?=
 =?us-ascii?Q?3Ft2PCuiHZsjFCOEFoXXRcur9LMHd6ZkXT/dH4LopVgEf1De1cTPnlJsytAz?=
 =?us-ascii?Q?KViJ4d7Cs9RfDdMJreZs65PM0Ujtabl+HLja8Na3IhjARP9BKT0F8qFvOTCx?=
 =?us-ascii?Q?Jf1Q6pQMkMSI4vzt2igzPY1MssdeAfM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45414fda-f6bf-485e-3a16-08da40bc7076
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2022 15:12:11.3828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLAEjjA1cD3qTGjiBFdgV/GKLfHaJRuIFprpK3/onNj1UcKB9FDnTdede8Q9+/B2SboRMCh+IMd4k0useUwpbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8485

Please update the commit log:

'''
This patch defines two new wrappers mptcp_sched_get_send() and
mptcp_sched_get_retrans(), invoke get_subflow() of msk->sched in them.
Use them instead of using mptcp_subflow_get_send() or
mptcp_subflow_get_retrans() directly.

Set the subflow pointers array in struct mptcp_sched_data before invoking
get_subflow(), then it can be used in get_subflow() in the BPF contexts.

Check the is_scheduled flags to test which subflow or subflows are picked
by the scheduler.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/sched.c | 59 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 3ceb721e6489..46396eed62d0 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -88,11 +88,28 @@ void mptcp_release_sched(struct mptcp_sock *msk)
 	bpf_module_put(sched, sched->owner);
 }
=20
-static int mptcp_sched_data_init(struct mptcp_sock *msk,
+static int mptcp_sched_data_init(struct mptcp_sock *msk, bool reinject,
 				 struct mptcp_sched_data *data)
 {
-	data->sock =3D NULL;
-	data->call_again =3D 0;
+	struct mptcp_subflow_context *subflow;
+	int i =3D 0;
+
+	data->reinject =3D reinject;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (i =3D=3D MPTCP_SUBFLOWS_MAX) {
+			pr_warn_once("too many subflows");
+			break;
+		}
+		data->subflows[i].context =3D subflow;
+		data->subflows[i].is_scheduled =3D 0;
+		i++;
+	}
+
+	for (; i < MPTCP_SUBFLOWS_MAX; i++) {
+		data->subflows[i].context =3D NULL;
+		data->subflows[i].is_scheduled =3D 0;
+	}
=20
 	return 0;
 }
@@ -100,6 +117,8 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk=
,
 struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
 {
 	struct mptcp_sched_data data;
+	struct sock *ssk =3D NULL;
+	int i;
=20
 	sock_owned_by_me((struct sock *)msk);
=20
@@ -113,16 +132,26 @@ struct sock *mptcp_sched_get_send(struct mptcp_sock *=
msk)
 	if (!msk->sched)
 		return mptcp_subflow_get_send(msk);
=20
-	mptcp_sched_data_init(msk, &data);
-	msk->sched->get_subflow(msk, false, &data);
+	mptcp_sched_data_init(msk, false, &data);
+	msk->sched->get_subflow(msk, &data);
=20
-	msk->last_snd =3D data.sock;
-	return data.sock;
+	for (i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (data.subflows[i].is_scheduled &&
+		    data.subflows[i].context) {
+			ssk =3D data.subflows[i].context->tcp_sock;
+			msk->last_snd =3D ssk;
+			break;
+		}
+	}
+
+	return ssk;
 }
=20
 struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
 {
 	struct mptcp_sched_data data;
+	struct sock *ssk =3D NULL;
+	int i;
=20
 	sock_owned_by_me((const struct sock *)msk);
=20
@@ -133,9 +162,17 @@ struct sock *mptcp_sched_get_retrans(struct mptcp_sock=
 *msk)
 	if (!msk->sched)
 		return mptcp_subflow_get_retrans(msk);
=20
-	mptcp_sched_data_init(msk, &data);
-	msk->sched->get_subflow(msk, true, &data);
+	mptcp_sched_data_init(msk, true, &data);
+	msk->sched->get_subflow(msk, &data);
+
+	for (i =3D 0; i < MPTCP_SUBFLOWS_MAX; i++) {
+		if (data.subflows[i].is_scheduled &&
+		    data.subflows[i].context) {
+			ssk =3D data.subflows[i].context->tcp_sock;
+			msk->last_snd =3D ssk;
+			break;
+		}
+	}
=20
-	msk->last_snd =3D data.sock;
-	return data.sock;
+	return ssk;
 }
--=20
2.34.1

