Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074951FA4
	for <mptcp@lists.linux.dev>; Sat, 30 Apr 2022 14:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651329082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ip/2kHQ1CCGl4d0wYGEttEvqkD8v5XDXQmMRvyeC9pw=;
	b=CUiV2cLN1io1HTe6mQut3ptASr2GcoMiPp4fZ2UlsXqzj14UKclTvSy6D2yCYYQU2yxlfG
	jYoHogdM4zX0cotrg4BYEDoHK2cjf3pi+mXXAj4VxygfiWyUAoMqTRI5rXvEb3vvAXKAzZ
	BzsqBy8bD6vatiwVyVypJ1ICRVBVKZo=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2111.outbound.protection.outlook.com [104.47.18.111]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-3z5CmYJXNYu_bCW9tUBpvg-2; Sat, 30 Apr 2022 16:31:20 +0200
X-MC-Unique: 3z5CmYJXNYu_bCW9tUBpvg-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=be0oz6JzpUb0AyCkIapCq3i3xI2nVAtiArixGMnns5bDZ8Y63+GuP1v1KLtj4sYT/yja6PAjiKNpNRoXkjO2AUxXcS/wLM5EAzmpcBS1TpsMeg7ZhV86VEOf/Q0SnB+NoItXi6DlgB9w8vxE5+5hH3BCO9lUESgQC9HjS8C82pUyRjRxumN71ctUpqEBNabtwxUmV4Dc7APEuIyhzFkx8VpTl4QwKywUclCXhUyx4rbgKOJQCnWwvseGM7V7+Hw2YgY5LIPZ7ueQKhauwUhW971lxUtqhl50uMTLanpNWW0BFE43djL8fNa1zGg141FkHUfCcN+WuZFHz1LBHqmneA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGe6i35l6G9FEcMck1a8S+AXJ6/QfOp0a2PZfeUHEM0=;
 b=Z0ui5AANufXch3brTSVnHOYpSeDjKsPtrD3Cj6JjHd6ApdrULEh5OfdVSwmCqdtScgSGeRpMgyg+Ju32uBv1+vUDL60YEIvpsdJJT7hvovmb9xV7IjCyjpL/G4zqfBmJdZzYQoaJsfO1gAR9ePzoc3iQeztyODc0B/vFH/Pt07yTKTSAXrSpGjNccFP9iDYukfE3R6wsi0hpzoFIaSZ4VbWF0ZYbCUhoc5Bo9qMmm8Q5J1iqjpWmRmN8lhaUVXunjuEDNT4GfnQz0SG2CNHfBNRvAMlAQ0crne+2IREUuiYerm8XbY5mW4B9nMi9iG+asDX9bHn+HT+voP7mq0coUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0401MB2519.eurprd04.prod.outlook.com (2603:10a6:4:35::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Sat, 30 Apr
 2022 14:31:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5186.028; Sat, 30 Apr 2022
 14:31:18 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: bpf: verify ca_name of struct mptcp_sock"
Date: Sat, 30 Apr 2022 22:31:32 +0800
Message-ID: <47419fbef3ed25bd1bb9d641e4817b85ea55ecda.1651329059.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3da8ac07-e3c4-497a-a42e-08da2ab61706
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2519:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0401MB2519384B171ED5176A32FEDBF8FF9@DB6PR0401MB2519.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fqzFRqdy09sOonZV6y+MYmbFYRrQg/o25on4PwsFCG2+e+jHBaFwWII0IXR1noh5bhLUN0Fw7drq8ocArU0xR73gY5KZ7B/Ogedlhe8Os2/xqb4b51zJjGnKMqJ1/8zCBv0GClvgZoWZuLS/CZ/YnX8SiBL7QgSj4TbNtty1nvWA4fSkxoJ6f31YAzc/YoyuKgZwq8Ysi773kj/5iNOexcni9XTmpOjcnaLJwvyS6NyAwfipZcrRe4e9SJOyzCZkBuxElzKKrfHkvfNZcXLk3z4Xcp92diIOAzYYGTv/vSWAC6Iz6aN6VtiFuGen2kJiHw7GKmci60b5qJw9BvHtyN8/yXKcrUcw3qNRjFcaJnk9Dt1ymA/Tfu4akmgsWukO4CWv3PzSM2N4xkYWRslMDpgORGN5/I2Twznrej0neEJpGnbWwdQ4Uh7W8JzJ9CmGsMMsbGSqHY76q3KVwgWQwsqoBg9hO/NBfL6TtwRUFHm+45ZAb6Vonkjsy8fq8x3x+tJzvQgf6w64oQ4DNotY+L69JuN7lY9FsNiUUMm52QQB/4jBzeCjySiBKNI0JfC8tTdgMmPNJmNGWIbwAP77EvSPrL0oLfb68p5I7ucECssa5h5YeZsFdvo1jmVGtpgeFEIaksmQDHUdDEuyAGvnJIyJrIweindVVw6ERtVOzmDzLNa4Es8hPJEw9TufZMzZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(6916009)(508600001)(15650500001)(38100700002)(44832011)(6512007)(6666004)(5660300002)(316002)(6506007)(26005)(2906002)(86362001)(83380400001)(2616005)(107886003)(186003)(36756003)(66556008)(66476007)(4326008)(8676002)(66946007)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T2LZ8X7v/kCyoDVyGH4qk3YigXBgciFNrzehUojBxcs2bgc/cic5TJw3muQ3?=
 =?us-ascii?Q?h2daAilG2tXuYjx8q1CvSlGKSdIHFjp24v2rHNk3RViNWklJOJT3blGYYIBh?=
 =?us-ascii?Q?U/TXem0fsPebH+7BLzqziYZxfnpMFKDvjrvqWoWlw5DxTzdmueVtVb5KfLQE?=
 =?us-ascii?Q?312bi1MvyQCpJFSU/ky5tLN4sbRpdP97s239jfcoBcPezkhZC0L0nyHrQnb5?=
 =?us-ascii?Q?/JFFLQ4FcTWRKu1RFF1ZCIDnhacmbU4lXYmi6p76UL5jqihtYoC0N8V/cunX?=
 =?us-ascii?Q?6DSrKa1eBdYXYnbN/GDo4K5acp5HY8aF4rNsBjmkktqJBDSgVTp6mcTBH7Pg?=
 =?us-ascii?Q?7+P9I0ycK78mYPnrw0jKiQX9v9g2/HtQhFJj2D/aB2YqcXYJFAJ8IdlucXJE?=
 =?us-ascii?Q?0QRJ7NtcvrU0rYSbGw9n7gVOfJb8+f3aWQUGvRC3OrqvvQxwbB3xDOk1wGks?=
 =?us-ascii?Q?NZGNHPHlL20B+VmGauYxxCPtPMCiMmpYcTZd+i19UMkWbN1HpqBC32lrJntB?=
 =?us-ascii?Q?9ufRvBtfuou95138cXlOR+zXsJcFdQRZNamQR/8gwzjkFdity10XsbCNBFCe?=
 =?us-ascii?Q?uvcGuCzij2tTwda2rvxPbY2itaFTN9GzqNSTTWVtPDRyfwUJIUVUl/78cza6?=
 =?us-ascii?Q?0qtTk2cYkwVkc4TvNoGNSrnKF9rLhct8jR0KERNyTjm8r0hFOcL81cNy0D1l?=
 =?us-ascii?Q?zQWijRi9EBJRG47+TmR/BYTJT3lfXogq5up8Waz3+XOu9Q/0YabPpKb0Yv0T?=
 =?us-ascii?Q?FjFO3nrSNBHCDVE6+NiDP5C92JgP5M17gZooMJsqW9PHYrWOcy3yqFoOzfCL?=
 =?us-ascii?Q?QnsCnAoa0kGgmXRLGqKcNidCxJ6Rc/YWTqNO8kyf5ES/rlmZbdla9XpeOT94?=
 =?us-ascii?Q?G3BEzgNn0aiXW7c5k/Cb4rcwS9GSZjbTg8aIGl4EC/dl66cxfpFjeKfkSAO2?=
 =?us-ascii?Q?OXrfW2hwgMr5nlkxlIB8PJ6VwJ8D9bcBMUadNTEWph+WROMmCeT5BVSEvAd5?=
 =?us-ascii?Q?0fz4NZemmTx9c+5ozFDkuDmKFqvx6b1/b656ALarAEHVTNEbLlnTPfklSR4B?=
 =?us-ascii?Q?FhcCUJHapwpuJdphKzcKn+d4mINbUxWRom6Pp2bKwbJwfE74DNqVC1ok03lz?=
 =?us-ascii?Q?YcvL3YWzp6LqiHdKXXMV12BVGdZ99jIWmoJw6tYsQ6lQ1xUF98lyZJaT7Eqv?=
 =?us-ascii?Q?9+wS1jKeEJ1AaRzOt/N8eE1/qbahKv6QkiFS+f17TF4nEcHEXTTDdUJD/zvx?=
 =?us-ascii?Q?tCyI4BZJyE9HJ9zN+TDVYfJ+dKpzVRgk8jUlfLXaFe4arHSS8+s032Xv7sRz?=
 =?us-ascii?Q?K8kM+pCxf68A1y1gDMyOMGOZhH6hCsc3S/mW8uaQ1EP4a33aJ/AwEMzjA0Wj?=
 =?us-ascii?Q?ikeXKecPoXNaTcEQkRxRdd3K2V/0Jh3f5DaDFlZhUIj7tB4hy1vtILDCKLuw?=
 =?us-ascii?Q?rsqHqPdEb7hMYqEC3XsaelwFtt2gMTo79CuWGtF2XVwIuGfbGp2aDD84XVwC?=
 =?us-ascii?Q?OnhnZTk31fWHLtHvhvrv0jvUcslWN8P36ARLtxjCN3FlkDj8HTrtG0JlRlEt?=
 =?us-ascii?Q?H5bqBIMX18uHa0VR/RTtaPzygDmgr7kN+RCYo+iVSoEOCFua72zDYQh3gall?=
 =?us-ascii?Q?qmYL1fYZTq8DSnYPbrmPwWOQuNDigMo4UxiSBuSP8yvxGHxqGUcit3kR7w8G?=
 =?us-ascii?Q?episoPbJ7EDBu3ugdXsVMCec2H8mczbyfhm044Nz7U+hPfeWHuL4jYBvmVSx?=
 =?us-ascii?Q?6Zylm/4juACg5sePWW5t4bcO/GUnWw4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da8ac07-e3c4-497a-a42e-08da2ab61706
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2022 14:31:18.6478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/JYxscsTP4+mxsZ4rTCwa/8SWhZvyePdpzdYRcR4BDY9phjUA+FztCuq2RkOwtPH21vI0CuE4IiOXW90wfkFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2519

Read /proc/sys/net/ipv4/tcp_congestion_control directly, instead of
using sysctl.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 7e704f5aab05..ed5773c26045 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -88,12 +88,26 @@ static __u32 get_msk_token(void)
=20
 void get_msk_ca_name(char ca_name[])
 {
-	FILE *stream =3D popen("sysctl -b net.ipv4.tcp_congestion_control", "r");
+	size_t len;
+	int fd;
+
+	fd =3D open("/proc/sys/net/ipv4/tcp_congestion_control", O_RDONLY);
+	if (CHECK_FAIL(fd < 0)) {
+		log_err("Failed to open tcp_congestion_control");
+		return;
+	}
=20
-	if (!fgets(ca_name, TCP_CA_NAME_MAX, stream))
+	len =3D read(fd, ca_name, TCP_CA_NAME_MAX);
+	if (CHECK_FAIL(len < 0)) {
 		log_err("Failed to read ca_name");
+		goto err;
+	}
+
+	if (len > 0 && ca_name[len - 1] =3D=3D '\n')
+		ca_name[len - 1] =3D '\0';
=20
-	pclose(stream);
+err:
+	close(fd);
 }
=20
 static int verify_msk(int map_fd, int client_fd)
--=20
2.34.1

