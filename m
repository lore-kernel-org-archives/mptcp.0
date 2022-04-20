Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC4D7A
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 04:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1650430669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0jv/VSWGUQZjcFiujo4d26vI7YOdDA3d0IM5WZNoZAU=;
	b=i82tjFYJ6kaqRVigAzTOPrnZTXp1Trj0O3sZaXf9vcCoVAtAttjMgwgafoWZPPUDPCm0Au
	WKfxyZ7LabeFyyVJ1ZInjTfLBTIu6Sd+fyL6JGffIC18Mx27TqNppplRfVhIDNew5f7GE4
	Vtd9wTPXqO9QG8u5erLSaNsh+N3O92E=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-28-iU2ZeyGWNk-5ntVzMz_Jzw-1; Wed, 20 Apr 2022 06:57:48 +0200
X-MC-Unique: iU2ZeyGWNk-5ntVzMz_Jzw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwSEKzVAFwpGydsZztWUkiMibLFqGrN8tZfuO9mUPDWxecOItt3zkZ9sx7jtzeHSR4tWGIkh2cte6gMexQsgVDuz24Sd6XRzCCA+Jq+fnErMctfQ0+9aRvF2UUJpvqaHECHCVZN9qekEmQswy5hA68SzS8+8Eu8J3//VbxU2AQsMbcuwujdXYCR8rdRWoz57pKPLEWwjlQvXh4tQUruGa07+zBOBtHGnf01e43ued0iPHZnYsQn1TZbrzn5zA+e7ciXtow2jBDBR7Iw889mgEi+wdN1Za/UCvNQVANHG5szEzgJaE1l8K0QQS2WBDUWYgZk8LpUa4XkfjxgJwxTs/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fH2xOTvjbQnpgPpLLskyQQQvnLVmdD0Lktfx/kZzr0=;
 b=dZLKzVfkHCVrnuE0ON4l2SPYUX5mJg914rGAOJB/FgN2Jk8AXEexSCrgc0gTEUYUnwku+Alm81S4dJS4YaINPok5MMjvM+iBlcQ9dKqbBihtOJizlnoHv0ET+LdMldURha9lb2W/XlGunQgq67G8saGxrY0/Ryp09IFDl2vUp5s5xedsqM5HCu1VasPb8/fq7IFPAcjhgHyZah/zhwvGoqyycQORZrn5jylyrNsduDfhmSAcLWo+dsWTITaA9RWbicM5Oc7L99LNQbmZUzqDvWdQTvu11J67FjojcraJBQhyvuGY4sQyqbqs/kyZQLrNed3kxz3wNv0tlnlTtezqUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB5752.eurprd04.prod.outlook.com (2603:10a6:20b:a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 04:57:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 04:57:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 07/10] mptcp: add last_snd write access
Date: Wed, 20 Apr 2022 12:57:06 +0800
Message-ID: <396f8edcbf8e4f65a1d76c228dc3d12aa4dd2f11.1650430389.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650430388.git.geliang.tang@suse.com>
References: <cover.1650430388.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0178.apcprd02.prod.outlook.com
 (2603:1096:201:21::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23a8caef-c868-444b-f124-08da228a507b
X-MS-TrafficTypeDiagnostic: AM6PR04MB5752:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB5752B0A36E62C9DC02A5D773F8F59@AM6PR04MB5752.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y540FFVJZEeZ2MpWpn+cVtu5n0yRBawAsxo3AX8puieApXQplMYxKXb7V8MOOmTKjyU6EENprEM02b5djuRpp/Ft/B4EQ+dktjOmboLui4rR2YMB6BvovU7AMGP/4kJ+1GNBCypyiNkElK9NVtZnhHCnS0Xqfb5CQfmzd6BrXxn7fHE4vgRRs0Fco9nHbZNrQFddzVXh74ZPal3BQWDtJpkxhv8nJLa7du8extIXWL93BfhYMYTGSxMKnIugKWkb9plmmLnvDBnDcOamafQgEssJXZyr7hilW6u6CBNKJPeEGoDqEBVyYYLBt2eLXz7mXfoa6/ArvfnQN6IRo2wFGL488U8UeNIvkbsqM95uMCa4lUvJmenjWDaCyGwxhnD9MLKteLAAXfQcVMqNAZR4H2MntqgEhoNYMdJRSuY0bldk5c8DKWr8vLK+PVGyH7uFJdMgJv9uHDRE6Lsjh1ZhF8s55IrbY9tPlMI8fDPsdef2JCWWQD4tk2xhORTMhs6ncEfIwc5AJYhF7RSgk0MQMXOv2o43oWHxCS8S21PlDMg4s4OfXsqeWDZLPW4b/f/w3Ozz4VgMrMSVRG8phfhZEOKPZFpHoHfwvQ5k53x/diYYunXPAj5N4Djv806D1HHMT+2BubYSrIGXG9w0sHq66WMvmIj0pGp5ay9jIM/l1ehOwxvBbToq7eM2ixvxIZ4EyLqcuw7OUnf2sp4fxWLlvQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(38100700002)(508600001)(36756003)(316002)(6916009)(6486002)(66946007)(4326008)(2906002)(8936002)(6666004)(8676002)(86362001)(6506007)(44832011)(107886003)(6512007)(66556008)(66476007)(5660300002)(186003)(83380400001)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5dJSmD5vfmeS4nATzaaMxfH9pBcol9SwAHK2q6UsWdM6PnQvzMS4gXlAi/X3?=
 =?us-ascii?Q?9aXyrAiA5jr8EE3+tgvnye8WVzQ4ZVzEGmBAcgemVzBIK1MSLMCNf1P7ikEG?=
 =?us-ascii?Q?9SDHyNw/baoxYNWdkHXHEiHJ68VvUorKwjVySJPMPIqqT5E6D7sMxJKXV7N+?=
 =?us-ascii?Q?jxlxl7rDn1x7VwEgCqJtCLK11m4r4CSgVZkVF/TluejkwEXOCit/6Z7+RTxp?=
 =?us-ascii?Q?aLz1WL4drcmoI7y65isVRY+UsHwha9TSZWFyZxL4n4tvgc63U9N4Cu5PvQ0x?=
 =?us-ascii?Q?cl5o/VjaestJqjKQorHnvRsC8zTr/xuuZ+01SgQ1fUPAU0LTLXYzcAoAAAJD?=
 =?us-ascii?Q?fkerXOp/U39AaC+sKjMOsbZ+68b/go9eGa8XzomS1RPAcUqMePT3Ia1WMM+7?=
 =?us-ascii?Q?UmHvAeWc1U0jRjURf/L58fswZvoPiu7WE6xlXwEaB/UZHFyfBWvroWeJRwDA?=
 =?us-ascii?Q?TShKMCoK9K3fRpcPfc+QkD2lmYg55Xlp0i/zxsPkg/DrN+2hpR5yS2ZKLaDA?=
 =?us-ascii?Q?ByBmYNddC0Gq4F4Jy5ps/1moPFVdGWJMJCldXyErKl+urewcwJO+q2FnMi+7?=
 =?us-ascii?Q?gOW/yQXZs0dLFmy44ntOdpxUUbTToUw7rASmHdpgDQH2bWgj5TGfl9H60LiJ?=
 =?us-ascii?Q?bQ1QFuJA+C9xKB9wJiijnUoKo+62dVShFOHlAWWJH8CWKagOZ/nGQkX2dUuV?=
 =?us-ascii?Q?JitKl5cNuIcz3mvWDGHJ5Yh6gjqN/GQ127H78MJbLmOY/s2s+rCfQdyJcOgG?=
 =?us-ascii?Q?hv8n7XJZxWylfECfy3Ru1rHQtbl2gaC87rhR43c9MZYexIy+NB3KtqldTJ30?=
 =?us-ascii?Q?j9qSekapDuhmBAc7p+AeqkBNl6ReUEYh3LoEZRwTDHKrNbkHsSU20zEIfxCB?=
 =?us-ascii?Q?ODj1fLJnjqunY+pOg71zt+AsfkifHtSEVtXtGX9SVCmVkqh3Y5FH0+fNexej?=
 =?us-ascii?Q?YmR49z16bQG3J+JbJdEfjW3rMKWSV+yMFrzTAxVEeeITTaaPl+6Dl9IJO2sk?=
 =?us-ascii?Q?TjKiXRhz/YRqmHBBoPXC5y/b0Ye6NaCAS4NDB6FHlHpTmIuyl4GKLiPq8iBW?=
 =?us-ascii?Q?gw8ZXJ+TW7BI0yl59Hcg66JKQ06aLyEE08VKueASjfO7GL9t2Os/d4nSYPxv?=
 =?us-ascii?Q?kaDer1pITufVhGNkM62cheWEhmmwUJSQwh0gHT4TtELD+v6CgMEFcaZ979dr?=
 =?us-ascii?Q?jV+v3/b98gf3pflJzQ+/DeXDulxr2oFmUl1377rF9RGZa2qA8eAwweCLydnq?=
 =?us-ascii?Q?rwrGL5O7MERp/ccMN0abAKxBJdmONBZSC2vThg7HLZ2K6G0s1PC/NsqLyi+a?=
 =?us-ascii?Q?oVA9pJYz4xs9tIXTq32BBPizj+0rF9GGqBQVlcytujjJ0he5xdLEMBWHdeqS?=
 =?us-ascii?Q?X1hMkJ5p6ENPKUmWvy+gRS/XWUaA6xfEnZ8BmTNnXGKy2y3H+74J+IU7QdZd?=
 =?us-ascii?Q?4k8mGvkPp2XAjj4IvIDU74UuI/XqxHCItLRtdsihWOGfPd7TZFkzs3KHHbqA?=
 =?us-ascii?Q?Tf2vLcohGlvZX3AKCt6xq8ul4FlMaHO7XgTITOp/WJAKPe7n7vlLxH1f88il?=
 =?us-ascii?Q?2Hb7XTzA+fog2+vuPuVdlGvr7KFPdf5g4ADG7rKt6isg18Kd35/aO31JvHX6?=
 =?us-ascii?Q?qZ2uNIaQLmR9+mPeWxsj2C5GbvM2AIXgERVjJUpSpI9ioqyM0P9LEMY+Fh5M?=
 =?us-ascii?Q?o0WZ75hlLdT+RrmfJxmOfwDkB64AmQ3UpfhkAhhEszVCX0RpIeZESLic46dj?=
 =?us-ascii?Q?Clbtoait8WKeywNoIi0c+PpYhLI6HFg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a8caef-c868-444b-f124-08da228a507b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 04:57:48.0758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVEx78vtbIVUhal1SBuYcgfCKw8s6cYJe74WF9jYH1WfY55JN9awauqtyV8r1hPfs6dt7zNQwtC2nyYYoRLMjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5752

This patch exports the member last_snd of struct mptcp_sock in
bpf_mptcp_helpers.h, and adds BPF write access to it.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c                                 | 16 ++++++++++++++++
 tools/testing/selftests/bpf/bpf_mptcp_helpers.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index e849fc3fb6c5..bd3c50b07ab2 100644
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
+	case offsetof(struct mptcp_sock, last_snd):
+		end =3D offsetofend(struct mptcp_sock, last_snd);
+		break;
+	default:
+		bpf_log(log, "no write support to mptcp_sock at off %d\n", off);
+		return -EACCES;
+	}
+
+	if (off + size > end) {
+		bpf_log(log, "access beyond mptcp_sock at off %u size %u ended at %lu",
+			off, size, end);
+		return -EACCES;
+	}
+
 	return NOT_INIT;
 }
=20
diff --git a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h b/tools/testin=
g/selftests/bpf/bpf_mptcp_helpers.h
index eb51fc1f54d5..90accd94e947 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -21,6 +21,7 @@ struct mptcp_sched_ops {
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
+	struct sock	*last_snd;
 	__u32		token;
 	struct sock	*first;
 	struct mptcp_sched_ops *sched;
--=20
2.34.1

