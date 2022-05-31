Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C317210B
	for <mptcp@lists.linux.dev>; Tue, 31 May 2022 09:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653988226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B6Eth9dsXeWY4kS3+bXuxDVlQ7Xkhzg5XatxfAJjSEI=;
	b=WDqMjm73nmJDLTn/e5mNr9DUfPH3qYMxuMW/43sh0Qvr+HyfYgn6/xzp/YLP4BAPkELami
	qLl2VWvcrcQw5mioeEm+0qL4lXkVZqHVl/nltpfwVc3dOKCcKNx60MvFeHgVx169MDvOW8
	UR1OBlrb0lDbDjSqJvfHIvKeFWhXhYw=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2055.outbound.protection.outlook.com [104.47.13.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-lk6y0Mt0MVqwKB9-iNwY0A-1; Tue, 31 May 2022 11:10:25 +0200
X-MC-Unique: lk6y0Mt0MVqwKB9-iNwY0A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7WwtxHocnhll5SjkXdnI0FFNNrpMOeifsG4o/cWoBhzdSHQiS+OcG/ooibwliUAUnTf4eXT2oHP27GDzR9LB+irP7CsMKKsvVO4Cb69EW0Kl4ZZEqcSRv1V0zCrWIDDPuGVOXPkbzclHelX1DoKal8eaLDXTu4dq6zRn29pCR6Wo/djS0u7keLuDRsDg2xlgvBnJd6y8sUCTnZv7b6iV2bUIDnmfqiAGd6un5pC8Bke6K0NKc4XFKYAJDKOV6qqpREnnN0l+ljcGxJRK3CNomIfJCCVmtYFowimAO1Dub/XWZK5pksCHqVJufH/qYOZL9F7Tf4Ha4vMz8k4xRrwNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NCFrq9klNPD7YBFHVDpPdg7F64kDPE5LA0UPye3HXI=;
 b=G3DjukMH074f6bOi9y+IXPA/H5sz2csp4pYnqnrIZ8UrgGj5KENgSkvRAu/jmORxMlcF+FWLZ75B+ppocYck0I6UQGf8hG1G875CpDHSN+6yRz48x4utm1vvPtMZhD6KDVe4fmz4S5YVTK5mZtriATHXIGFtNZJYnKsmzd0WT5nKtgjR58rGrkOjncGIS5Xf7kmcASl6aYT1l5dsk8N2ffMK272sA3/9fyK0/mYiKXZ6Jx9Mw54qFy9n9XYULBdJvjxFExHv6sag56QoPqRCO7QD0qaQAzHAmAOU6hTJmuQN6+6AzUdd9IhKDtByJzfzQvLeS/fG1Id/WO0AMjWLNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6434.eurprd04.prod.outlook.com (2603:10a6:208:174::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 31 May
 2022 09:10:24 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 09:10:24 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 06/10] Squash to "selftests/bpf: add bpf_first test"
Date: Tue, 31 May 2022 17:09:51 +0800
Message-ID: <4e6d1b17a1b2384c57fc34e3b0fcb1ac8cda765c.1653987929.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653987929.git.geliang.tang@suse.com>
References: <cover.1653987929.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0200.apcprd06.prod.outlook.com (2603:1096:4:1::32)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c94607f1-76d7-4ace-b3bd-08da42e5650d
X-MS-TrafficTypeDiagnostic: AM0PR04MB6434:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB6434F6B0325E15066D8478DAF8DC9@AM0PR04MB6434.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3E5zn7SfiA2cF2mEk1ZLB72XezGEBpS7ICqCu+wiUIFYVuP2vLSOOtap09hML2trYegcASLa9ueMnKvi+WtDA/wHWu1v6wn/ZCpjUG4EJwtyuhA2agXkBCbPzc4FEYn/fThIud+AY+9WYLgcpyBcFVpbm9pyQffW6lhIhww/KbiH8paJ6QXM/zqluLl3PRTvv/NdReP7kNrIAtOdSqTPwhkOz8UjkS3L1BKthWiVVJ1aydl7Q61/7/D6UJr8krwmkQNQMx7rjOD46UB/7rxgPS2qSJZYHEfzCqZpgHsyPlT1EeT0eHosUUR5omo2GqYGDv68F4DQ56GgG0XBasYnaVNqjLrPPy+jXRinU5/f/G9H9ODRCq8UFoPrwHqkDsrbSwGlnx/fq4ZJvvIP+tEFECEdtcigLUDG+VatB49tJXVePNIXw5/s++rD3v9/QqcMu24VrIWPAKwxA9S4pJf4eMazjgi1DBd0kOc7sPskrJonTra1JcTHAYlh1PaU9uGTqaZX8U0L4WhtRAgSUCfZVXbXeW2zZ3ZlBU7HBpilZaH4+h06z3q9XPeZlWP++MRSAynyIT4vo5OhBMW3acciCsygabsPo0rvVSEikqsqXxKJ205ga74MpXiqlrXZjUrZkQ9qBnoZN7VrZ9Zytohg3a3PW4ah96QZhzCTXCRr9QO26eVmokUez9kawwV5udJc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(6666004)(6486002)(8936002)(5660300002)(508600001)(38100700002)(44832011)(107886003)(2616005)(86362001)(83380400001)(6506007)(186003)(26005)(6512007)(36756003)(316002)(8676002)(4326008)(66946007)(66476007)(66556008)(6916009)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0yf/AhYLY4HWXz8+8eFp72oRNKVHm3iADa4uAeTPXHzrswyBFX6mVtJvMUWW?=
 =?us-ascii?Q?c39gAfuBmPxOCx9tguL0Al+k1Lm4K8DSa6A63oKlBg137VeSUSIxKH6i0QVx?=
 =?us-ascii?Q?OH2vpx9+pRDIE3UpNIoDVL+kEAU+5s9ymiKdzD9QZtkiCTyLTVlFRYx7Gg68?=
 =?us-ascii?Q?uikTj7U+kjXws0Is9p+SPl4YxL5lQGDwfr8VKDjSLSVnHHH3YRDZgLEIgmWz?=
 =?us-ascii?Q?rX4I1V7w3fV9gXDmG4pfHSKIIWchYDIY7LKOHCFR2SD5l5rsqt3MKrlYSoDw?=
 =?us-ascii?Q?khwtQYeockysMq2TKFbSZjRBzeLqZeNP2lmmnQZmS83f2ZcBo+WWuihJAjBp?=
 =?us-ascii?Q?AvpF8DWY3unYfHqbK5AUDGORwNRzm+VSSY6ERA1kOmrkKCiHBlJS70uZ30Jh?=
 =?us-ascii?Q?rZ15NGsZMQBLBFO9tCp5lKub0rr8/Z1IrOXkxDy9ZusRowPRRwdzI4Tu2Duq?=
 =?us-ascii?Q?Qnq5SOT9wH6qbsj0DWxGlMXU31EwXiJW/DCH+5dsbHZuSN5qdb8RxeShk+jC?=
 =?us-ascii?Q?+KkGJ4LBY+r1sAky1cjBXqZeIv5uaQRzGDEoSet+zdGM7ZpUR6zM7B7wxE8h?=
 =?us-ascii?Q?36Sn5Pvg3TVRpVLJoR+OpnIW/hPnEJKeU12/RInH6L0cBXcCDySasMTX/don?=
 =?us-ascii?Q?qHuQTCVUPx9dcJ+VIzTd97nr/i/C6aM67CBLI5S2T2lcd18mytJhaSCC4w8L?=
 =?us-ascii?Q?Er8nAdxoGm+66C3U52gmhgi1aOxysQme9cyTxnUUQUy6z+rKPPnWxIOEor6d?=
 =?us-ascii?Q?iPCjj5sjrN9EeDVp6woN+j5rllN5G9Id+Gk4Y70krolgGm0CFAFGVGGRxw8S?=
 =?us-ascii?Q?rC3HrVNPiToe1jcXe/9uTYrsGDgZX+nVTYvB80b8qEpW3gn4jfPBNn8my+VZ?=
 =?us-ascii?Q?c6Bo3rU0sIaWjfMfi2Ric0JbEZXOtu49m2/sjHhO9oqoe30mBCSPozZpej4f?=
 =?us-ascii?Q?LglASCu+XdwwMufkUiGf+DEetIoGS3jDSzqF9b+XfPy9bM9gDwHYWvW6M3UV?=
 =?us-ascii?Q?gh7bYfV5pm+xeyCFJMnlqPjHieg6KoxFNPPtdTNLka0B1jDVsGlzEQDqS2jv?=
 =?us-ascii?Q?2qhZC/6uqkk4zjs6cHpNMURigWzox/+UvQB1uhScodgzbjsdVgY9/vr+TUPG?=
 =?us-ascii?Q?2L5PiemnGeBJQ6TFXU0WSyxCO3WGjacMeDXiGmPZlzL00bZkTe8ZA8ZJ49lL?=
 =?us-ascii?Q?niFo4sEnnvubLGC1apQOtw4xekJA7Wad6ZiVIba6lM4vswN4YQeESQMqeaqa?=
 =?us-ascii?Q?twQ+C1UERSRPInJsu52PPaYSeLjMGJPOHZAXEtmtXlZrHxG9XWZfNwijnMIN?=
 =?us-ascii?Q?PHkhO1UsVFUgEgV5ap6tjkh9PsQW85h0U6M7n11ZNjT9UnehG6vcKs0rzhXb?=
 =?us-ascii?Q?56HmyvdVxsxyc5p43pNj0MmXBeXre6Cjfu91NBy3lMD+FP6Y9sF7Hkj9E3eb?=
 =?us-ascii?Q?3VQgUB1v5B9byDaBL77PK3D1lM3lUPBdgJWuI1m2d9JNQYATBiW1qQZpJ6x2?=
 =?us-ascii?Q?9lfR0qd1pjp6ZbIY+OxXpaxGaDhNK+HVUkyLQBeu0J7HW4vfkF0xfAcCaTNv?=
 =?us-ascii?Q?cma/ogic7kLHa/eqzE0k1fMMzJg/qHpMzyTLsOm0ns4AhBhVaecIaGlxEVz6?=
 =?us-ascii?Q?GF+Va10sqSeCCUu9Z0z+B2kw77CZOaF+Sljk8wFYXedKiMBNtXu0wv/Or/zA?=
 =?us-ascii?Q?yPlF0Vfi6A++l+HkF0n5rpHZ0fkpMZO3tTNqmUzKTw+lT2rLSzK1bxLuZWeN?=
 =?us-ascii?Q?J7F7nrIl0c+hmXDaLm+HsceDArIQFk8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c94607f1-76d7-4ace-b3bd-08da42e5650d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 09:10:23.9655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FX07es+hrGLYOeLE8Yt9VLCzciepDyibbjq8xX0uHk4UbO2bktbCZrVKDlqyk6o2PVuTJt1rWJBDFORtn2OZcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6434

Add two helpers, add_veth() and cleanup().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 8e9764275b07..eaea4105728d 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -250,6 +250,20 @@ static void send_data(int lfd, int fd)
 	      PTR_ERR(thread_ret));
 }
=20
+static void add_veth(void)
+{
+	system("ip link add veth1 type veth");
+	system("ip addr add 10.0.1.1/24 dev veth1");
+	system("ip link set veth1 up");
+}
+
+static void cleanup(void)
+{
+	system("sysctl -qw net.mptcp.scheduler=3Ddefault");
+	system("ip mptcp endpoint flush");
+	system("ip link del veth1");
+}
+
 static void test_first(void)
 {
 	struct mptcp_bpf_first *first_skel;
@@ -266,15 +280,18 @@ static void test_first(void)
 		return;
 	}
=20
+	add_veth();
+	system("ip mptcp endpoint add 10.0.1.1 subflow");
 	system("sysctl -qw net.mptcp.scheduler=3Dbpf_first");
 	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
 	client_fd =3D connect_to_fd(server_fd, 0);
=20
 	send_data(server_fd, client_fd);
+	ASSERT_GT(system("ss -MOenita | grep '10.0.1.1' | grep 'bytes_sent:'"), 0=
, "ss");
=20
 	close(client_fd);
 	close(server_fd);
-	system("sysctl -qw net.mptcp.scheduler=3Ddefault");
+	cleanup();
 	bpf_link__destroy(link);
 	mptcp_bpf_first__destroy(first_skel);
 }
--=20
2.34.1

