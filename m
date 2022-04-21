Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769961876
	for <mptcp@lists.linux.dev>; Thu, 21 Apr 2022 06:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650522198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9T20V3kb15iW9g7EhammtTDahxNd+9L46X4RSowSFu4=;
	b=Sy/itiQwfZ0mDIDxQrlPHn4hdCkhT5otnreEDnaPPHcwW0Wk08OZ4lMz+Hu8ICtF5Df7og
	Yo+ZfQFPSacnqc1cHr4ScoNXcnx0q9+j9YOpLKCS9yfrHFK2Bm2CbxfGgPiiop3/EchX7O
	n/UDVE9qD3mWrSdlhHwZHq8qM3J50gk=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2106.outbound.protection.outlook.com [104.47.17.106]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-LSlx6S3SMQWgCHi5Ge9PMw-1; Thu, 21 Apr 2022 08:23:10 +0200
X-MC-Unique: LSlx6S3SMQWgCHi5Ge9PMw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYRzOPi5Bo56LndKsV2FaazNwS9lCZkPRTPI7PthT+Vf6+Mhgb54THySUWVhSY56INiQsXy5dTNvs5ciGqIbNebWFbFCKdxq8XRZpgGOVm7lR3bE1KoxaeGAMM9kGV2yfylEzGEv4o9RC2Hz36+O2hEmXSHPPHJlq1IcqMUF6j86Jdt+fse5lEJ87vqS6LdBl03XDll8RzDSd+48MiWjyiDcT34YDbUbFeE9TzESVw6YA/irGFotHrSFLdBWSoszW5jjKBFokDTcANWCcF1XgsUg2A2IGo/xINhZ+LE4zB4XxZ4sb/613pvw1zQ2vpg/LmgpqWucHEZRbhylBx61ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1wrBVY8g/CbefO7X86Mo8vAkDC4xsNdeQ2pE5FyG4U=;
 b=M/fjQ1II/3yhEXJanNRYmcHpysvIIyMoY5zeA1l32iCiSfyCn21aNzAVUgyqfp7Gp2EdX47JgkTRWtAKARS4BYYXBDwsA/EaNh+tnFksZX5Vy21kbQyt0QkbiKpihGTCqG6Z1IwWOPAiKy7rIalT4/csuxX/Dn4IQEOTfeChf/QWAn6Q8Riseyj33iGRCgK8woSDrn5We/AVHZ3f2eQUWZqGfzQHd0SpzBZkcBUdiWUKQ5e7YPmHRiZb+aFHXozedxA0k+ueVMKYeK9UNXPsKm2/s+4Njk6nkcZdVqhvEpbK1Nf3LL3fyrGBlYW1b0J5HndEfFv3V8N562+Z5pX8rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8100.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 06:23:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 06:23:09 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v13 7/9] mptcp: add call_me_again flag
Date: Thu, 21 Apr 2022 14:22:25 +0800
Message-ID: <11f597e62ca79b4c5c1d6256b5eb5233c1bdfba1.1650521788.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650521788.git.geliang.tang@suse.com>
References: <cover.1650521788.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0170.apcprd02.prod.outlook.com
 (2603:1096:201:1f::30) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 151c1305-4f6f-4972-57f6-08da235f6744
X-MS-TrafficTypeDiagnostic: AM9PR04MB8100:EE_
X-Microsoft-Antispam-PRVS:
	<AM9PR04MB8100DD37C49F6B43C6BD8369F8F49@AM9PR04MB8100.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/kHTIe6bzzDAdvr6HZeoJQZKY9qokWokE6r7DZnjWya8mABI4nI7s/38ZIGqJh0AQXpwZ09atXlyhIGtGnz2V2dn8bTHfrgJoMDhVjZWsLYCmXgL/P3+bqzcbqCRNXyJOwOoAR+HpWo2/EbmzhxS4PVzgVkG7qyvQNLkWFNWFy+Sv+Mi9YQlwlDnkDW0WN7a6w9yNoiEVg2NsG2zn3sDxSd4h4/3O46uB835AQp4syveXhkWDba1Jh58ycd6OUJE3vIYmijNhYtOpqFRhEJZBnVX4nfInK6Y/YM0Px+xteIMrykhK4i5W2vFywYffhrCJF4P82MbQ5ZwFU7DbQroRULnbyBxu7omLt6f40MhIAr0iNhR8i87DbL3VCgdJhz3WmwyTet/Xl9QnMYGn/9Hd+Sm7YAUE4FWyGKnye+O3UGDlEy3vMm2u7+mv7yDF11syfOtE08Ex3cy0XWxzGbGszVUuQDVZq3DZNjdWm+QqYHMgRjk+GejpsEnOunmWOHR3CZSupA7dSTeW0l/Zy/EnAqnWh7lXgdLsPA2mcnkVTBDZE1R8lffYbz6Wye87cUKLcMmTM5R73Gy3hzMS3cTUpGHdfrXN53Uti17WnFyzD9y5FyOoUJuBgkTDFyVTosuQxfr/QpF5w23u+5LH3SdkYycTCzYwuv/ArkqmqnqP1GN2sWFa6/oqF0O2rY9HoxI3wkE3SJMv3NQGIrmURZuAA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(2616005)(86362001)(6512007)(26005)(316002)(6916009)(508600001)(6506007)(6486002)(38100700002)(66946007)(66556008)(107886003)(186003)(83380400001)(66476007)(36756003)(2906002)(4326008)(5660300002)(8936002)(44832011)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ztI6In22OM2qKU+K/fVUsJJWyGlBgGT7Sg9W/pRmUC2rvRtwrvbW6qC1FeXS?=
 =?us-ascii?Q?gVtGxoulGAuRIV0rDUUgdGihajLsdAMCaPLuwvb+fNzAa/Deb3amVX7AYadQ?=
 =?us-ascii?Q?4LbAQ9F9nu0Btaw5DJeubGu+rDi1o2bHacSlR5yAnimKNt4MHoM+hAstBq5T?=
 =?us-ascii?Q?3/9N691kKKmNG+wMvV9yP4RX8ASQUOU+nB/3Ov3zkN9erx/R23avpqg/EHDR?=
 =?us-ascii?Q?ylh3PHZMwk7/wPR2SXV+/ruE6mET13KkqsWmAGWkFgUfX2MbBx7htIoSvRlw?=
 =?us-ascii?Q?P/yDjtjtCep1eTIR+7OirawDbkZkfLlA6v9aRFkoBt4DGpj37ZvT8NGl8w61?=
 =?us-ascii?Q?jlokC8BXHc7ci911jBarD/7aBbAFCdijoPkASNIaHEEH+LWCVrgVf/iI4BQ8?=
 =?us-ascii?Q?Sz3zisjOROS/ezbg0d6zmvwO1JpA7xqi6nGYzz5604ReNmwn220yPd5XYCdS?=
 =?us-ascii?Q?X24wc3LK2ufh2/v/3GFNGBUlr+BW61TwmFJrpSiCRemBv6fC2mXqMQ3gLB6m?=
 =?us-ascii?Q?32dncwbUSMHfMH7J3tp4ofQLwEshB3GCRF4TBC8k4mA9wIQatArT0/eosEIs?=
 =?us-ascii?Q?0wqFtn4lXfGV2PqiyoYoMl09hPvaHE2B2sdPYswvpA8TeiaGwwr3LZRDKn6h?=
 =?us-ascii?Q?nhs0TusJEecWvOJi8WwnfOAkMrA52ZidKZtUzelstUeFQH8Yiiq8+jy2hrkk?=
 =?us-ascii?Q?1h+8HegkAFjSid5SvcNwN2xG/EDy0vzxu3ZgpSZDvAn+8lF8lpDOybplsVKc?=
 =?us-ascii?Q?PYi4NSVx+cv5z3qp6iIbP11SQXsmgsG49yeAxYrL5npsK9E1wS/5Q8nm43BT?=
 =?us-ascii?Q?705tbyvho/RN30V7S2payg7SSe7VAoIcxodg44mGeVgfS+SrYixdDB4EW2iJ?=
 =?us-ascii?Q?2ISrQ9OvQlkNR154Ek+HQ1hVfZltPrloGS+8XF+9zhPOCQ6C8x9MKq4vjIvm?=
 =?us-ascii?Q?pd40OpTkMY1ca6u7n0hhJZqOhsHyddkPwWkwOAFaFUOvL51nNggl1IXM52bh?=
 =?us-ascii?Q?O2G0a20HpLIWDCSyvRbH93COcBu2ARETNP41WN1YwZYrQT8eruluZTuKYrMR?=
 =?us-ascii?Q?m3i4+E8xU09rZPjEhNRr8Cr8h7K08wvN8cCIIXxcOfwnh9fNNGhWg2QabNcK?=
 =?us-ascii?Q?b6cJAgBtRboUqENq1DwypiOVvBnWp91YszL62pYW1ar28LfoCfTE6jy3Cw46?=
 =?us-ascii?Q?ODKQQ5f8A7Sptu4qWehYDZPyjcuFj3IpZq/M0Kn79TMZbDLh6kZPH3m/OYm0?=
 =?us-ascii?Q?VCVLIQlUeZYPqQ7jUNfE/GKMS3zMmf5SfgrQxSKe2ATZltAXcu8IYx04M93B?=
 =?us-ascii?Q?qLqFIhNyBRI/CR5mjGxGVCPC06DMaQDZybv9BsDh+ilS4TrDVnLMJhEkWM8R?=
 =?us-ascii?Q?F1Ca7dbpSZW34D/o5jF8Ej93ripNK6EKqOXMOgPeCC8ADWjdh2jb9NjTS9Mm?=
 =?us-ascii?Q?yR794GDLON8uxFF1b6HQ7uYnU00EpmoM7Vr0Ot47PIPUDDgO0pJF8sJNoStd?=
 =?us-ascii?Q?2uuNx2czXVgq7uHc8hIlPDQppvknLtE2DD8KhZUeGhS12C8jTW2ft6cV0y76?=
 =?us-ascii?Q?kGoRh+RsCuX+GFbIPOM4IKZs7ll1s8glb7Mg568gcAzyREXwuFGul7+y/kxe?=
 =?us-ascii?Q?+UBpEsxlIrNDVeVfXKYYic9kU75BXZcBwazif5arGLH/uTv6Xstcf6AvMnug?=
 =?us-ascii?Q?apmxZbR28uVRT5FKf6MuuutVAU/186DWJJLpx9LAb42UmdJTNx3dM1SYT92N?=
 =?us-ascii?Q?YKmnefbxj+LeKzl8cdM3IzY0rF+w9Us=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 151c1305-4f6f-4972-57f6-08da235f6744
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 06:23:09.0868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGSaKI8DUa5ny6OTi8gQq9clIY0j+jrkuwI4bio0r5wox1vMbGUaq1dp5PbrRXQQOXVQV/YExoMpVfnY3UzquQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8100

For supporting a "redundant" packet scheduler in the future, this patch
adds a flag of struct mptcp_sock named call_me_again to indicate that
get_subflow() function needs to be called again.

Export it in bpf_mptcp_helpers.h, and add BPF write access to it.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c                                 | 16 ++++++++++++++++
 net/mptcp/protocol.h                            |  1 +
 net/mptcp/sched.c                               |  1 +
 tools/testing/selftests/bpf/bpf_mptcp_helpers.h |  1 +
 4 files changed, 19 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index e849fc3fb6c5..1611dbe63eb2 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -40,6 +40,7 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_v=
erifier_log *log,
 {
 	const struct btf_type *state;
 	u32 type_id;
+	size_t end;
=20
 	if (atype =3D=3D BPF_READ)
 		return btf_struct_access(log, btf, t, off, size, atype,
@@ -55,6 +56,21 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_=
verifier_log *log,
 		return -EACCES;
 	}
=20
+	switch (off) {
+	case offsetofend(struct mptcp_sock, sched):
+		end =3D offsetofend(struct mptcp_sock, sched) + sizeof(u8);
+		break;
+	default:
+		bpf_log(log, "no write support to mptcp_sock at off %d\n", off);
+		return -EACCES;
+	}
+
+	if (off + size > end) {
+		bpf_log(log, "access beyond mptcp_sock at off %u size %u ended at %zu",
+			off, size, end);
+		return -EACCES;
+	}
+
 	return NOT_INIT;
 }
=20
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f31bc3271bcc..13c6ad5fbade 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -299,6 +299,7 @@ struct mptcp_sock {
 	struct sock	*first;
 	struct mptcp_pm_data	pm;
 	struct mptcp_sched_ops	*sched;
+	u8		call_me_again:1;
 	struct {
 		u32	space;	/* bytes copied in last measurement window */
 		u32	copied; /* bytes copied in this measurement window */
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 8025dc51fbe9..05ab45505f88 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -83,6 +83,7 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 	msk->sched =3D sched_init;
 	if (msk->sched->init)
 		msk->sched->init(msk);
+	msk->call_me_again =3D 0;
=20
 	pr_debug("sched=3D%s", msk->sched->name);
=20
diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index 81a9c5d91aae..dacee63455f5 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -24,6 +24,7 @@ struct mptcp_sock {
 	__u32		token;
 	struct sock	*first;
 	struct mptcp_sched_ops *sched;
+	__u8		call_me_again:1;
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
--=20
2.34.1

