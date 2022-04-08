Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F273F2564
	for <mptcp@lists.linux.dev>; Fri,  8 Apr 2022 15:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649432569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gp6B6YSAl1fY8zJ2qbVz1zeF5plUKW3Flc0vrP2LCjY=;
	b=LX+PbxI1Wr2oqRiW62YrBrI0y+F4mj9mJNykPHfLoZ8iZQJlKPmTrSgdsOlqT3Fy+WF2ko
	lzWyFksuQOT7K8qt6nMFEeNKgjuSaF1SjRZEP1RugUVV4Sv9SMtETR6U7CQOscTNm+tE89
	BJP0ioJgnuZ2zuXsXpCnCPvmX4runfk=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2050.outbound.protection.outlook.com [104.47.0.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-12-XjG7lAMoP8KP32q5RtlZ_A-1; Fri, 08 Apr 2022 17:42:48 +0200
X-MC-Unique: XjG7lAMoP8KP32q5RtlZ_A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCdR5MhHOQt8SESjFmrR0uwmBIiRypMGdt+lpGOcYqVdQ3IsdVoMqPVgxWQpNQ0j9kAsuChFSk4KZRV5BU1iMns5Qv1ZHF9pCcmRQ2e8P1KBs3yJWDF3sVPTwCeaqn3QDXJCBx/FftqruUdnjwhs7Il28PICxIYN1RfVnk6tYo16yLEAq7OLVHIOEk+6JPTA5o4vLu90NXy0sUDPzUyDai6by9xHOkz3SbzTtqo8xxbu2bJvd/xvCAGx6bpax/kYKOLGSsYVIWpyOdMPagXB0O5bNvVJVJZhCb2bOFbuP1O/6Zx2XDXwhOUIfOg/gna7NCOLDi8TGCiB6+NG0smyFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdbazcLTvK4bieYrW2A3PG8NmlvEz85lq+QoEiEX3sg=;
 b=LwUZIBSFYwruWQ59HOsrdzv1i+hHLdB9D+LMiNBUlg9nSxpA/QxfYm31OFWJIbbwPHd3FZWhjWQXWov+eSovzIBcEMbEkQvrYDsh9T0X+qu9v2Ls4TAI60mDs5lvuKW1ETdm2UeuH2e+JF2q8bTRsX9IKM7J7JUkMAsGjLKS16fX3IT3eJhihJbNpFk5PFi+mzLmnPQiYjVtHB7Iwr+6uPHUIL/hppUzMKFYYEfpTaUN6HxMohSuEOtIMJZXsJS2D8Lo0RjeOy6nnu12aISh0w9G8Ew6QcO/hKW/ZES+5jKQgvlMxOILwW7vY4buHdDzJuc00C3tATJWl+MAnykLnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB3957.eurprd04.prod.outlook.com (2603:10a6:209:40::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Fri, 8 Apr
 2022 15:42:36 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Fri, 8 Apr 2022
 15:42:36 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 1/4] mptcp: add last_snd write access
Date: Fri,  8 Apr 2022 23:42:32 +0800
Message-ID: <b23e8bee41d2a13e5eba4d408a8a47bd41aaf939.1649432434.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649432434.git.geliang.tang@suse.com>
References: <cover.1649432434.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TY2PR01CA0014.jpnprd01.prod.outlook.com
 (2603:1096:404:a::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bbb4025-03f9-4c90-d667-08da19766785
X-MS-TrafficTypeDiagnostic: AM6PR04MB3957:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR04MB3957131BD6A96F77060494C2F8E99@AM6PR04MB3957.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OifpXdSuWR8hVmriXIv3iqNmHor9FaxUYbxN8i3x2V+razQZNjBYOpNHwIBS2VVA/6NhkKrc188IZrRuH6L5CjK0HnBT/05szYK6uGZoVnlx58zp/aQ0yDpkUTXgQci49SVnOiq6XrL0TcxnaA0NaZew6yG79eit0VnTGBzMrgYIKCJm4u1yXltyqnnM+q+iflf9dhghEX1nsJow0i/JRtStLkzOjWT+5XyRzWO9rU/Mhe3O3IXsI3l1OumCmC8Xie7kkTnDyVzF1Z0qxLhaPuuTHUVHAciQwE3SrAf1m92vuw8PbEAZ0+i5hQxsYGj4+Gt1BiANO5vg/WiTCoCW1okLJgTmasIGFDku3/wYhyq2qg2oISOpXFBv4ev23AcVmaIaai7Y/I6TwE/qOkVrXnj5URZCV42zK9Tnf0vSE+xJjBxUsxG1s5zw4gqyt6NKi8vtqtdrZSKstEBxzv/JOBM6ds93yCfVZ7zBEcfhd4CR3t4ahdX2QOQ6vX9ApK6+9jL4BRWM8sZunTptInpzgBhQaLhWxtKGBvMsCsYZioFHOh9oZV1OOKlhRbm6H9UoGIqNz0g7FiaRwO47FAiLvNgQdsTQ96fIzMNY4WHffg9gE6ze9HdQyeqCUvYcNwXexIfZoE8txgU7J77yjVF0xp0+7TLvKGPYM6kQFWAhavlh6jM6npVGbipY4GcXvRx9Nb9wbe1/ATSiyOjRxsPq8g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(6916009)(36756003)(26005)(6512007)(66946007)(316002)(8676002)(4326008)(83380400001)(186003)(6666004)(2616005)(5660300002)(6506007)(44832011)(508600001)(66476007)(2906002)(86362001)(107886003)(66556008)(8936002)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pb4mL7HkYmOrGcov2SKKlYWyB6iSBs7lUmiV6lgzUUMtJso2QmDTdkMk+Y64?=
 =?us-ascii?Q?QceR1PTgDKWZP459MqYjzt3Wc8fE53pGHD+3iiATJN4znQGq5J4uQ3WxzPy9?=
 =?us-ascii?Q?yBv3BbBfaOolGqr99FWWvXzRJ0QWn4rep5YSNZgI8V9ih7r0NxmXrNPYuS4d?=
 =?us-ascii?Q?75N0eePxeZGJe3EHK3CfFotOWMUQ6YXQwnmbPznU4gtEkWR2wQ84zhq4XyN2?=
 =?us-ascii?Q?2uHTZYt7NKe3Z3XRXS7quhSbO+O7+fefqYLykVZE1KX9KJvaL5ecBhVH8Heo?=
 =?us-ascii?Q?sLtLqXFIUbhoi+T/HK8NYvpeGzdtJ4c0b8c0wBBZne3cnRC8UnmKDap2/B9m?=
 =?us-ascii?Q?qhJROts6N3P2JeTE5WIydhRFALeIaTi9+ZAQNI9lr+v7XAYEM17x9sPuHPDi?=
 =?us-ascii?Q?hELTQlP25uGZiFGZwq+cJWrApQYf6MHLInNXKKhEQ97EqCVRePIF3DEukhZx?=
 =?us-ascii?Q?QVixghDkEWp0Rvid8M5Ahhdpsj6jQxcHRIiCOiXGa6hxdU3qyzBokX/DsbFW?=
 =?us-ascii?Q?x3Ya3gI6b54ZERST7BAb83MXwsI8UEzpuuEmjjscdOubezqhmcZjABCv6pub?=
 =?us-ascii?Q?DHoKCXsyf8NQDEEuo/IJa5DI9de0rFL7RfYyjRiqc7gxWR9dG2mBFdNCpFuP?=
 =?us-ascii?Q?EQUFlskSG7ShHTOYbAqaWrxbEGv6otvfBl1hVEZoeBtbv/AG/gxjqcuXJp3q?=
 =?us-ascii?Q?vmyODHBepD0uWHG6FIifDmUmbzD1/fGqZLzUTvWaPYTaVEsE7vNpEYvXz1WD?=
 =?us-ascii?Q?cnGu/3uzPQ+prF9SOLCk1jPqKJjO4Z73WrAOGrTvkkShyyUQNeRYtFYqw72c?=
 =?us-ascii?Q?B4iGv+xQ4S8xalSFsGhBCV0lJx1KN87Y77tPsalTlehPih/QqgrRifwneRtk?=
 =?us-ascii?Q?r+sSOeBnYrSRiQ3SmB9Bxtxljt0ncN/6VLciZc4NQf6M8uvKu7iunAz6rPyg?=
 =?us-ascii?Q?OnkJIJmV+j6au3bn0+AN1O2L07n31ys5vcZ2mk2TFsRjfzo3BLUR0UM8/y48?=
 =?us-ascii?Q?JxJrAHMenc+1xeeZ5bbGYZO/A/fXFHQ/+HwlvKe4oIlAAw1EZ63mEfnla7uk?=
 =?us-ascii?Q?/2i7GLAH2fzPW0bm/Q9zk8SBWp7IL1iRPO+lGosOXOT3LnBfv1VYSir1nwNa?=
 =?us-ascii?Q?Twdz8O8d246HgnhbfveV1X1fMv+wapms/PJ1x9zrCeuPwGRmqLUpn+GvaUFg?=
 =?us-ascii?Q?+jcUoNz+D9eR36SicPT7ZD0RHecVx8h9UUYWa7RI1Q1IfGS/VDxtTwmmoKb7?=
 =?us-ascii?Q?E/kZ5Oo5FM4LnMonC6zNqH+VjlRFc3WeeIW+3iZHZTg3ciY9r1bk/24w7n+7?=
 =?us-ascii?Q?81mIeYcwl0ajFDxjtliFh8i2Wr5eFTPs7xvLKfzpjNCzLIahxViAzYZ9Zv8e?=
 =?us-ascii?Q?pk7oxVKC4ynckiL0rNWf03RzJZm+PBUrJLcEu2c66UwdadeA2+V3rgRt5zK1?=
 =?us-ascii?Q?EKBPylcHFTfhb4snFOEoF174XjA31+993apTEEGwrPfTuVk/ciaanRk38sxf?=
 =?us-ascii?Q?/aP3fVRni3svjT2En+XRoayVXyga4tgco/1zk8IBXyna07mjZdiHHGNkMWpA?=
 =?us-ascii?Q?6FQsRegi7fR93vdjBgPltJvjwlUbQs3U4WBsgp6eyeI5s7uRTw/1mbCC2+k6?=
 =?us-ascii?Q?qYjTfQW0NRqj7vvh2qWSjMJlyjuPzf5Isjzf6bi3W4eKi5T+Gt+JqZEqWkin?=
 =?us-ascii?Q?3+6tpwlejCzWXNrrknVshl/1+0La+aD7fRSVtqILAC/6jY5hF4dxxOFYw0Fb?=
 =?us-ascii?Q?KZMT6WSPTdTNFsMfDfVeLPdejOSp2vw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bbb4025-03f9-4c90-d667-08da19766785
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 15:42:36.1412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zN4ZPp3cvLfzUjHMtZBW68KNjjRwmjkDYZ5y+E2FK9iRk6AJlSpEtmqytqT27OaLyU9VKsrNbt1Svnwff9yjJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB3957

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

