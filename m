Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE24A46
	for <mptcp@lists.linux.dev>; Sun, 13 Mar 2022 10:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1647169179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TnowKe6x5obPQmpFPENqjOny2LgfEVNRcdMLdbPqOXY=;
	b=mpS8wANh6Cu0r/y4lV8M4AhJzcfDVB2li5HyozgscflXI8FZq+jPfwuoJtBzZ+/uJkWFY0
	xoSJd5Gje87OuUSfj7SZVvZHUjg+lW7JYIEp4AO7dP4O+t3n0cY5cJORSCarOSHoU6GIg6
	nsauLwbyfe9neZoVmT18AOMo8ktaxp8=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2104.outbound.protection.outlook.com [104.47.17.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-36-MafBChIMN_KFReNL6TzMpQ-1; Sun, 13 Mar 2022 11:59:38 +0100
X-MC-Unique: MafBChIMN_KFReNL6TzMpQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8K3v22aC75KwMySba2h5758KdcvSsqqYuBLPxhbzXDqtgAiO8FaDnNdNtCZQTXW4m1wjubeeTELY5Zi0vtzsK96Sl1eHCsJPxsGruDEy48L62bseHOuA3dP3tAEMQnzrjGesf3bL/U00UsXIDHSWCa3zPkcE/zN4yz3mu50LRwhYjT0sd3wz/MM2cURQ7bQxlmIYPzdit9r/MvcKcsocKIaBex/fabJBWY8lDI7rqaUvi+Ngm9kXTfGU1e+82IDflmMl5MwyTG9Eiwah1Ax1G4bhufxVeifGzpQDs76FcdK6Dxu2Sk/aCCm1S33i2xk241E4wrHk8GfwxzbkYw/Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/gViiPl9cNM++9ZePqGw0untIZFgzGamTvNp/G1OfQ=;
 b=aNd+OV+8VuYToeIR8Tdht9b874QsCVgSuQvVTvQYvjmcacm1vZPjVmtrSRyku4AoTXh0w7vt6dg1uQMLewl5XubMb/lhYzlvH/IpbXDIF/qPBntuA3gR+UKsVWrDi1j9weTqxesedbcvQIKU6gP+BFfH3jOFTdLVWGa3dVNvW0Ad1kM+OOpGafVHKs4w8SJ3WB8vkEGDg77AMrPhs79HkK5l8KUPR7uxIIVvCMwrJwb6w+cDyVkdGRHMHvLo0a8IvM/EN/ERWYZWpVt7erF1zALTRRxa7PE35clhR/QxiqjNhDUbe9vegZqwcD6/I5DzbyLMvQcT4TEsQyoPFWYVrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9283.eurprd04.prod.outlook.com (2603:10a6:10:36d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Sun, 13 Mar
 2022 10:59:37 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5061.026; Sun, 13 Mar 2022
 10:59:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 3/3] selftests: bpf: verify first subflow of mptcp_sock
Date: Sun, 13 Mar 2022 18:59:13 +0800
Message-ID: <3613220025caaaf4fa1bb941a0b7f7c2efc6c3b3.1647168955.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647168955.git.geliang.tang@suse.com>
References: <cover.1647168955.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0060.apcprd04.prod.outlook.com
 (2603:1096:202:14::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffda7021-ce0c-4ca8-097d-08da04e090c8
X-MS-TrafficTypeDiagnostic: DB9PR04MB9283:EE_
X-Microsoft-Antispam-PRVS:
	<DB9PR04MB9283C2E07F555F16894DD225F80E9@DB9PR04MB9283.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lI331xAI3FmfYh7zT7nps0wD0Edc5SqE3b/fuS069RaB2SaIOUGQXNPIWtIA6GE7NaPVEVIHfSBbi9ZsrqrjQzKssnRMf74WCYVVpwvpPNFJxmg1kHhvWUzobAOHfZa6Gkz8Z1DVBkTZQQyw3Cg1p4jka4LS4lyn5cT0jzlAusNsDbgQVbKPeIpX35JT1/vL5IBzVP6FBRVD6yZpHmFvgG+qsfIAV6IXzjQZIebwCfkVQH1pQ+Tdc9ZBNypEDRBtVk5+D0uOUgLIjofT12C6ByVcL4qQFafXx1uCN6ZANrLc7v0oeNwkiVRd7HC4auwp4aLgc9LQFWxas00+u62XPUWadcoIwFtOC8C2W6MZ6lP3bde4Aq4WYmwwhIkfD5emYsoJ7dQ3L0nKFZlvBCHC5anaks/AivI9BOriU6ULs3SwqMNbQO5AqC6l8gLNyMKpZvilwFO7CnOllcBoulIvE0vkebTcxtuBZvIDfabYrle28uCFYRj1vtxMz84uzJmRq293BM1rdr4Ek5KeqbDEMbBRyPR3BhmmwDV3l+nhcLLXAx6fF3qYjI466uU7/FsPOEzZFoNjZ4uPhE47dtU4y/lRIITopfPs+ZARgGufr9/2Fum0aFs3Yt1dLrds37NQjcgZ0Dp9CschsxIBqAWfCkv0WOZt/blmWFo+MtApN2SFH+7Mh0UGjsudRzNw1bLD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(107886003)(2616005)(38100700002)(26005)(186003)(6916009)(86362001)(66476007)(8676002)(4326008)(66556008)(2906002)(316002)(66946007)(8936002)(5660300002)(44832011)(36756003)(15650500001)(508600001)(6666004)(6512007)(6506007)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T3rY0Zii2nQTdRAlQdvO/I4W/kqHd+BYSoQzEwGjnD52htV17kxKljtralgw?=
 =?us-ascii?Q?KRWxfSV+fcnSzX5p84m4CgALz24VocA2V1klWcBCNb/49pC/U6MR2FOmtxCe?=
 =?us-ascii?Q?Hm2dmrBQYVGi1tDGpiXVsJTt99hYkYBTFePOj8EOwO86cpWXG7nWyCQs+J1t?=
 =?us-ascii?Q?wLpFdNqAUcnNymxU8pGxcxEGaMszFZFwLthTDl9mTb0Df06unC8uaOYCKFGk?=
 =?us-ascii?Q?0LJfBpo/VW8F9mYh8U5/NddHmU5ablsnRSW1W0iYpwg1kBi9FGynmIZHuLja?=
 =?us-ascii?Q?NS1GZ2xZN23VBkWW2sPWe1ZxXmY+0pEUPppsMScHXUpEinKWQXR0GgP9yDjX?=
 =?us-ascii?Q?PLXvBvgn9sumCZfM0Shg1Wf4wlxn1gfRPwpzVa8K4mqcYsQF+/FEUSD9MohH?=
 =?us-ascii?Q?Y180mBQSXmwcIHklpPWsce6nHILfmGsJwEFqYWW4ED9uGi9+QioEFqtPKVMl?=
 =?us-ascii?Q?que+Y9ToHClI7ZO0NrHfSx+BEQq+xN3VbjbteTJyZzjAP+uc0oGyhmHRpzhI?=
 =?us-ascii?Q?geXMp5w7IM1Ex3OKIwJ2qRCsNsB/VQhkXf2iI5QpYY5La3vt/HAJVgp7tQ93?=
 =?us-ascii?Q?z5nSBBJJZfmgk3PMCruJG0IYpWVUZRMGOYyP22quL7BVVN7t/63CD/2nA7JM?=
 =?us-ascii?Q?AvkLTis3IpY6gberUvOl15nIzKDyECQ+Dm+Amcw8Wcdi6t4OSSm2Nl4sCuTR?=
 =?us-ascii?Q?w5BGbb/tISp1tuG35byVm2CNiqo0a21jvbUdAevwLd9xiB1rrDtm2qDjjB0z?=
 =?us-ascii?Q?h27uGkheKI02Kt36PTZXfMhBXtAMpTDJrZVBKVRtEHRsoMxRDtnbGtupM8JR?=
 =?us-ascii?Q?5/mu7rwA0FUtfOsp4s8aVgbEr3S9fzSmi1CL7z1TBqEGyVAnZmbhOjWKnjmk?=
 =?us-ascii?Q?6nTlt0OGpu9xa1O39a1acaCMoPSljwuR5cD1MUOni7K5Ije+8tCqpPV8BgWk?=
 =?us-ascii?Q?9E96KGMBQFEurTzQ0+XPVNBG0i6GVnNFxbkEJNCUYZsOAP37TvFgw6iZWm7v?=
 =?us-ascii?Q?ywDF4MILNphhKctwVRKi/f7RWwJscNpNR3vt7XwzghdUdzhbSydKTyE1A5xM?=
 =?us-ascii?Q?09Ch/K/e8kflFT+70UHkWN6bm1HICd6YvTvJH+n4I9GsPh3HcDXYf8daRn4N?=
 =?us-ascii?Q?WZbGTEZLLY+gC0aMIQv0De21rwFXPZirACwwmYURl1nxMim0GK3/VlOuiz1b?=
 =?us-ascii?Q?blcY4IqNTFW702d6UqMfqhTOc48nj7oHE1k3q7UvGXBC7ygxsMKpA9a5KyQ3?=
 =?us-ascii?Q?8SIpETX2mgklq8duU7SB+aDNzHmpadxqehghGs78/niv4xbhvPQZ5Vr2VDp/?=
 =?us-ascii?Q?FVbiIknDDIcz2XEKhdtFp9oVcuHGq82ID0MMrs2XmHX5V1LYFsWNCQ3JPlTn?=
 =?us-ascii?Q?ZJiaVso5/xv08Q74XFvNqsgJR/qfy6rwFSwix2skSx7GlT99u6EV9U8lrDdR?=
 =?us-ascii?Q?VvJw5NpKxGSY1I24bgTID7eLnCXmgi78xuK7JlPT7T20VIHWjv06Jw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffda7021-ce0c-4ca8-097d-08da04e090c8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2022 10:59:37.5810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CWZkYLC0SXybW4AszT3358yg6AkgEGh15UqwI120i/Dn2zPZ6za2NjT0A9DTARE2gviOGHvF94n0BCis7rsvlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9283

This patch verified the 'first' struct member of struct mptcp_sock, which
pointed to the first subflow of msk. Saved 'sk' in mptcp_storage, and
verified it with 'first' in verify_msk().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h  |  1 +
 tools/testing/selftests/bpf/prog_tests/mptcp.c |  8 ++++++++
 tools/testing/selftests/bpf/progs/mptcp.c      | 13 +++++++++----
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index 57de5ca5ed50..728ab2fba0c9 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -89,6 +89,7 @@ struct mptcp_sock {
 	struct inet_connection_sock	sk;
=20
 	__u32		token;
+	struct sock	*first;
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index aff35ab33379..eb3b542a4d73 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -11,7 +11,9 @@ char monitor_log_path[64];
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	struct sock *sk;
 	__u32 token;
+	struct sock *first;
 	char ca_name[TCP_CA_NAME_MAX];
 };
=20
@@ -140,6 +142,12 @@ static int verify_msk(int map_fd, int client_fd)
 		err++;
 	}
=20
+	if (val.first !=3D val.sk) {
+		log_err("Unexpected mptcp_sock.first %p !=3D %p",
+			val.first, val.sk);
+		err++;
+	}
+
 	if (strncmp(val.ca_name, ca_name, strlen(val.ca_name))) {
 		log_err("Unexpected mptcp_sock.ca_name %s !=3D %s",
 			val.ca_name, ca_name);
diff --git a/tools/testing/selftests/bpf/progs/mptcp.c b/tools/testing/self=
tests/bpf/progs/mptcp.c
index 61adc4396abf..5c8dfd5774fc 100644
--- a/tools/testing/selftests/bpf/progs/mptcp.c
+++ b/tools/testing/selftests/bpf/progs/mptcp.c
@@ -10,7 +10,9 @@ __u32 _version SEC("version") =3D 1;
 struct mptcp_storage {
 	__u32 invoked;
 	__u32 is_mptcp;
+	struct sock *sk;
 	__u32 token;
+	struct sock *first;
 	char ca_name[TCP_CA_NAME_MAX];
 };
=20
@@ -24,8 +26,8 @@ struct {
 SEC("sockops")
 int _sockops(struct bpf_sock_ops *ctx)
 {
-	char fmt1[] =3D "invoked=3D%u is_mptcp=3D%u";
-	char fmt2[] =3D "token=3D%x ca_name=3D%s";
+	char fmt1[] =3D "invoked=3D%u is_mptcp=3D%u sk=3D%p";
+	char fmt2[] =3D "token=3D%x ca_name=3D%s first=3D%p";
 	struct mptcp_storage *storage;
 	struct bpf_tcp_sock *tcp_sk;
 	struct mptcp_sock *msk;
@@ -51,6 +53,7 @@ int _sockops(struct bpf_sock_ops *ctx)
=20
 		storage->token =3D 0;
 		bzero(storage->ca_name, TCP_CA_NAME_MAX);
+		storage->first =3D NULL;
 	} else {
 		msk =3D bpf_skc_to_mptcp_sock(sk);
 		if (!msk)
@@ -63,13 +66,15 @@ int _sockops(struct bpf_sock_ops *ctx)
=20
 		storage->token =3D msk->token;
 		memcpy(storage->ca_name, msk->ca_name, TCP_CA_NAME_MAX);
+		storage->first =3D msk->first;
 	}
 	storage->invoked++;
 	storage->is_mptcp =3D tcp_sk->is_mptcp;
+	storage->sk =3D (struct sock *)sk;
 	bpf_trace_printk(fmt1, sizeof(fmt1),
-			 storage->invoked, storage->is_mptcp);
+			 storage->invoked, storage->is_mptcp, storage->sk);
 	bpf_trace_printk(fmt2, sizeof(fmt2),
-			 storage->token, storage->ca_name);
+			 storage->token, storage->ca_name, storage->first);
=20
 	return 1;
 }
--=20
2.34.1

