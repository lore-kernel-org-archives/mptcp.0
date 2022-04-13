Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B966E23AE
	for <mptcp@lists.linux.dev>; Wed, 13 Apr 2022 14:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649860230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gp6B6YSAl1fY8zJ2qbVz1zeF5plUKW3Flc0vrP2LCjY=;
	b=VJSCtMm4EfJwNGGFx+Ftx4EvZaEv8VzUlir86fnyrQQPtwmix4DT0O0gYc3gnbFuVdcaq3
	L1dkXn5dO7B1GINF1XPJFuu+af502VOKREo3ZXzMWOsMJso+ltzXd+RN9fg+mjBePQUC1G
	YwdyvYUbZsqu5nTyUOOuXa1O0tgKFdI=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2051.outbound.protection.outlook.com [104.47.12.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-n68c_DToOX24lmMdLRjz1g-1; Wed, 13 Apr 2022 16:30:29 +0200
X-MC-Unique: n68c_DToOX24lmMdLRjz1g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKCQPeYMziyCati5D8Trhzi06u21tdSLJMmfvg/Z9GVShIiEKfIKVg0Y7F1fRjjiG36YB9QqF7XW4d7XWzXa2cNuxEAC6NtaovlMAjtcQzM2tpDTevRboRbcne6w26HuAFDCSwa/9GrwmjhYaw/AvHDQlJg4wMfLGrBqD8P8sHD8w+Yqx45eejxyCW1j8YC5rIxZiudOpMrXxxVgIbmT66xLlXcXUOzXcD+KSXUlveisO+uNrSxkYgQ/0/818XiOBXMG7GpOm7i0N6B4i80Kml6Y3NC/1IDEqzFu0DdaulTvWEDbjTH4ukbn18mo47qTQn6nF9JHJ6zHocTWPJgd3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdbazcLTvK4bieYrW2A3PG8NmlvEz85lq+QoEiEX3sg=;
 b=FuqLjBmTh7mQkGGx55bmCmJdUx8zkm+m9ZGgm7Z7WXjtCE5Id0aJ/14OKCHO69PezjHkuP/fZUHg2l52RMk1hJauWU4KGmLXC8/RUjCHp73K6g+rotb1JKANsnfMApTAVFiDvESSw+wmOuzsN0CpYmT165Mdge6pKhHZ6e79FjuCmhCZn8hPKFCnhSS3wcWsfBKO+PqVjOlFGOdaShJUbh9oI7j+QjRkPgOYK6Tv9ZN47UJKuU92AuMkc9BfVty6NLytb952BTfTkQoT8VUO/U/e9dbs8Ml5dAkq0bbwM/+2MM10b2uxRTkSsbSuNVgAMR7g6CpdVE2JtkWaBGGVoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.28; Wed, 13 Apr
 2022 14:30:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5164.018; Wed, 13 Apr 2022
 14:30:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v5 1/4] mptcp: add last_snd write access
Date: Wed, 13 Apr 2022 22:30:20 +0800
Message-ID: <90c8f9049d9353785ae4a3974a01d9b8c9ae3392.1649860043.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649860043.git.geliang.tang@suse.com>
References: <cover.1649860043.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR04CA0023.apcprd04.prod.outlook.com
 (2603:1096:404:15::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91019f79-6149-42f1-2c97-08da1d5a2741
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_
X-Microsoft-Antispam-PRVS:
	<PAXPR04MB935103F5B38951FF196FBE76F8EC9@PAXPR04MB9351.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J6yCc7hsploMHTGyHecaGwlSIoP7VNXrCb/vKVJ2wZ/k/bPyrGlyQmyZ7O2rwkHFSIDakdzijgdXwo+S3XaEX5S0e1AwCmDgyl9DpveT8YIIPh8DN+8EAyvqxaTJG/NJ6Bh+UCe9M0/BzMLTUT4ReygF6KgCnMMVbrW5i4WL4MRbkjIMGFlMN7OS0WbrFKcbICCwM95M4Guq23ruKPqZSWV7NMn9E7pMo/BcjW6iRihNmRrCpJRkdzZqpMMt5wh4daTuU40DZQPlUIAbyS0BejWeXVrABYzQktZxXv6F8hsMJsjE3ZnuEBq82iCvSq0MNH4UaqUHu9AEYPp9uvxqq3/RlZSkM/ukgObKV5jHrsGvmjUnNYrdjEvV+yM7b8X3icc3IxbK4qmNB1pZzX2UcpxmOAwXqftKCdLBBSj0BdJYWG9pvReLAtT1d8Z1++RRhC2aFbmrcnJw6zfzIu5Cc4BIqNeVKTrjptUkZzDUchgosINh2gFmmjvqk8MDW3lfmCXh56+x9EGPo3yE4PQRErerfuaW5XYr2xQwyP2K+nOVDsWNz9G68j7bT4K82oRRvLfzILEtSZ1FPOYMQx0+Aw8JKiUUWNjh3tkgJgPs9rN/Vtg0US1cJjMqjIfO5sfLgCU6nYo6k974zZVryuTLnYgcaMmNx8CIiNNx57qinR4z+6Tq2Dl44mpfWylOSPk6GgoMZXTMaVclGwzv0mkHCQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(83380400001)(6486002)(2906002)(6512007)(8676002)(186003)(66476007)(6916009)(66556008)(44832011)(4326008)(107886003)(86362001)(508600001)(38100700002)(26005)(66946007)(5660300002)(2616005)(8936002)(6506007)(316002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qxOYliBEBpcEtbr2hC4qzoRwFYb381mn+zywe1jWXbdFURSpeFF1OqPJOAAg?=
 =?us-ascii?Q?MVrrri9jUBn4sPruIDojfr4EMliHWnM2QiqyYJjv+CgPGaRHQe19I5ID4F9N?=
 =?us-ascii?Q?mtARNLuploTlHJLwlHcUsdQrZn5jhD4TCLnBQmIVSepqcco28PfvXhxtEK2V?=
 =?us-ascii?Q?MJ6bmAJShCbgabNfAd2H/JKkCuTJfS94mWUaR6AAeYaCcHkto/O3oIqPsK38?=
 =?us-ascii?Q?brBb5CLuZM1eLWUkQlGd2LHZbP3mkh9dcBgAf1I8xquEwtRNV30lk/1uroNP?=
 =?us-ascii?Q?9yAAbRZkreF8bPRn9nkGhoCcEJ+4A5NTRH0YS7X1Qy5e6pTZy8feWEbf8wBO?=
 =?us-ascii?Q?P9zrDAglGaUpV4kt76/bQ6KARV0AqRjYZzrTJtKXGHwaAtfDrFHEW4Vos52r?=
 =?us-ascii?Q?ButkdSfMbB3cBtCejPqRAuPtNqwtApwQa35nY1eUwKTQQYkrUidWVXu++KRR?=
 =?us-ascii?Q?Hx7vSA78sw2WoZWk2CzZl3PUIAFJ5brOE058tnJGb+mbafO2MSvj3q6ydT1u?=
 =?us-ascii?Q?KFPd//wdIBBDs6WylL3ly3aTGWr7CqJwAd2HIV6RPx992yL7ILzcALiDVSvk?=
 =?us-ascii?Q?cP2Wqmhr2cDqDAD+vY+Qw+skXUziQfQQLTpsZxiH0ivrdi3bmuPi/Tma/8So?=
 =?us-ascii?Q?btr/DbvSttGgUO1eKIh4ufmuXkm6WVP7JEKUpvqlkioxL2agXbEnFFtC8Gvu?=
 =?us-ascii?Q?1+XOPzcmjPjd5EZYeTmeAYPmUGGSk8MuuD7oPeotIFN+vtiBsVoIutNPSNDq?=
 =?us-ascii?Q?ZhTX7CejMfspQHGjlZU+ItyiN6kcVKhxpt45OqE1edA6vnE5+FkxYSMvuRh9?=
 =?us-ascii?Q?Mc/N7cX8tORnZkHSSU8FF4q9FBFhZ0Wt/m1j0TgjMz6B4I4E+Twp8fTkqZVx?=
 =?us-ascii?Q?u+XZlcd0UDpqXKLilw3Pgc9BZ3H0p+pMyQrxlkC53Oyn4tohfH0w2EOnynzq?=
 =?us-ascii?Q?tspGkz5lwT59fo7BMmWlQBSDoOw5XciBghRpEDENEM5AhUqkdrS255rWMmsg?=
 =?us-ascii?Q?OUd9qQVMFSZn2TnewX1twC0LG0t4zs18ikqeJWbK0B1fTB5Mm1pazeu5jdnO?=
 =?us-ascii?Q?60r7lnq4aKjkSZ+NB5nDxSwr7W19XPWZha11QXR3XYjwYAiwhdzLDLYSFcqT?=
 =?us-ascii?Q?cyfXYTNkjdKCF5iDsgTZyGCprcFwbzswtDYum9csoc+aNoereaRHtCaIln4O?=
 =?us-ascii?Q?jpB51erFrgaa+QSCEmnb78vPxpjCT0mgSWx69WY6NT9bO2AlfMp+nNaIRx0V?=
 =?us-ascii?Q?FMzFiBexfSGCvizC0tyAywsJZSF3gkAOg5jljUF53KcoBowslbCci8SQPcbo?=
 =?us-ascii?Q?+fG+xQL6+wph4XZU+JEb2E/wc2Kqe0+RMij8waP2L+jY8AS7XMcJfXPg6rG3?=
 =?us-ascii?Q?aimHtupc0ycDKEVBZOuW/xNWw78m481SkAFGK7aHnCDtdy9jNdeCllVq0Ziv?=
 =?us-ascii?Q?llAq3XmxUTBD/l5eh5w/vRYmcvWhFKdo82ja2Xmm2YXSLcPWTRgR7464QQRl?=
 =?us-ascii?Q?VgZycjxaqK1QzgPaAmQYEnirrnxPb3yEAlZqarUI+axiWXtKf6/U4dNBiRCR?=
 =?us-ascii?Q?R9d2Mf7M4U7JG6+R5DKuDgD37mUB7/8VMthpAYTrTEXAHRvC3LlQoPiFaGLm?=
 =?us-ascii?Q?52tyLndLmDYgWNExCzNUm3WYKUvwSCkm7NpC3IZG9KLTfRrYQPoXEhHavipk?=
 =?us-ascii?Q?ebuHw5RjlZg4aR6/k5+OmLIydY0V1DyQmbtbWz+bSqfPfudEnKFjgN7hMD8P?=
 =?us-ascii?Q?nviPjtS8uzss0huuvXanM6UDsArBsDw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91019f79-6149-42f1-2c97-08da1d5a2741
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 14:30:27.2941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2oKeKtAPksUxicE0DxysVw6KsFLDWBNpQNmch1LhUVutkxMxQKeeDMRR8r0NX4jvevUwujjbe8854oZbaanj6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9351

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
index 9a0e3e7766b0..4f82baee998c 100644
--- a/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_mptcp_helpers.h
@@ -9,6 +9,7 @@
 struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
+	struct sock	*last_snd;
 	__u32		token;
 	struct sock	*first;
 	char		ca_name[TCP_CA_NAME_MAX];
--=20
2.34.1

