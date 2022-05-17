Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A167F
	for <mptcp@lists.linux.dev>; Tue, 17 May 2022 07:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1652773440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NwLft7UgVRocv+Z/fIQiOnrSi6r1C0K6a8o0chlzPgU=;
	b=O3wPiocuUfzhtiIg3dB8CbUH9/ARSpg4Ecy72vRV7og+VkUpgjev1g5hn5HoV3OZ5JTxUx
	M/On6Y7Rfwh9vvUX+G0UzXh4bQafBSPcJw7Q55d/mZCMjA0WLk0bJLQHjv2FTQwVohqq6M
	psLRako6G97Enq5yI5XLpxe3E+ggzjY=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2055.outbound.protection.outlook.com [104.47.4.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-34-mZ9wuR-BOqKGXxyQzYkMlA-1; Tue, 17 May 2022 09:43:59 +0200
X-MC-Unique: mZ9wuR-BOqKGXxyQzYkMlA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=is/qTcRyK2yKWSkwN3Gqsr9+VMFIgD8++eSn3+WKWqS8V918RsCRXkGvnPdZCjLhVJIJScQ1UOpGC4dB0xGInYi72lY1uNSy+WsRFcYTtmCwB10VM64jGWJiSfxKlTunmolae9BOqXbS+ZSyY8su7r1YewbIv3VDR0WE2yB6qfdpgnsOC6f9sGHo6eRynZJv1KvGbPDZc92oZ+p6HgNOIE4t6LZkn6bZ6tJXOSwCsbJwoPuowqGTaPCUKQxIewvF31g4g2akBjWvoMgKLyvPPYu+p34MwRNywTIjetdlcTPXoDXnM9ob0nN5OA5wsvvenQ3xkaijCdIYceSmGBRNhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcmVXXxmZIZm5SFeAQSMNCMMBgfkYUOZXv6eYX8NrnU=;
 b=g4AuAkgoe3vC2DQBOtIBeyOVNLueBVq6CKO4xg7d0zZbSheoQiKmkR86JqSo2peucT9X8JZFjxkVUfUFeA8MOhCl5fgmvta0e/RWfSHhTjYQ6IKBI+tmYyXDW+LyoMZfdB4B1t7V8WK2A29Ui/NYjwRNsoNgLrxeHixYe7T1yRfemTArHzkYm6MADzgf4iVGJHt2+YqK3IjiapB4qJ71XaArT9Uol/fTa6NCtjt29lxWjtGoIHARu1H8nIeoYFyM0W/nhv3PazjCR9lJUMFxJcJksrPFG1/wq+h2ZXvJHWj6I9shzP18E4TTg2yNrcSjibjiVxLwnUOYyoTpZu0ogg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Tue, 17 May
 2022 07:43:58 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 07:43:58 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests/bpf: verify ca_name of struct mptcp_sock"
Date: Tue, 17 May 2022 15:43:23 +0800
Message-ID: <0887c95325cb197974a5ebfb16c0d8d81c9f2035.1652773296.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cc055f923d6d3014e9a0e3273e6d01c8a528bba1.1652773238.git.geliang.tang@suse.com>
References: <cc055f923d6d3014e9a0e3273e6d01c8a528bba1.1652773238.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0021.apcprd03.prod.outlook.com
 (2603:1096:202::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c558a722-1ec1-4971-9512-08da37d9004e
X-MS-TrafficTypeDiagnostic: AS8PR04MB9126:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB912640405E1E5396CA7A3CE1F8CE9@AS8PR04MB9126.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RH6cB4We4zI4krA7zP84VrBu5VTl5tyOkszdL+ibsNWFU9Okz9CgRDJ28tayca0pLE5eM1pcFaynB6vN6Ckh1a6EsBETrZ5uTqbc6tFLqaDeghi0EoOrYZEzjdn4chR1iNMe6yqHx8rv194d9gLKGWo+tjAbq7lFuTL9I9ruhvmNBhHPZzgjR+FjBt6We1KmmGxY+QxcZ0DzUWvO9z7c7pxTlVBijGB+wVhsqKd6rkIetxJ5hndJL8y8TzNXtva96ktaqRTU+BvMAvhzNcZYU/nJrup76cjm6KPoQ8af60Ums6ADORVZ2W4UGVgADhF7dGP9ASMqYpobelrzbxfMNTJVyR2ywx3YjZ6crjWkWpgu0f4N4Hjmpaugf0NFbVY++qKRJtfRyEJZ8UqwgtgJ8yo9HCTQhf0aMBeLmvcIIuv+5TjxSTfoELWMhmuvpfoaeQ+l0itB3+tYKHEE51AGLkMX+9ifSdx6AaTRx3C6a+gw1A9MjbOijSrkGJkm0FbjP8EiEe18XuC8Eck4kr/kZmwgrsrrmzK647Q072plc16GWUjtjjIIfWw78Cx54efZBeoSg2a8w3ZZQulXUYAZTukU7iQxZgWt7e87vtuH8AQxwonbdhiM7UP26PHBNLyZ1G1o64lbIKvguaILkPbypjXZdiC1Brn0u6TCE/Z7tmwYKJUjGI5c6nrAf6nrCFZA+Bp0r2TkpeMAVxY4JwmHAQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(44832011)(15650500001)(2906002)(38100700002)(86362001)(8676002)(66556008)(66476007)(6916009)(508600001)(8936002)(26005)(4326008)(6512007)(83380400001)(6486002)(5660300002)(2616005)(107886003)(6506007)(36756003)(186003)(66946007)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RXlq/5AAf5sJxsQOukWnngyFuDGVonZy/aP5EQ8AmN8Q+tYLw/HOSyRMPSOT?=
 =?us-ascii?Q?J70YahdUrCorZrNtBoCEGthOGv7o2gE/Pz3gS0fsyu7v6DOlEarpZ12Y0VHA?=
 =?us-ascii?Q?7sEpjVFglSnw+MGMQjlMQymOOIwPy6Epj6Eqvwb45UuyqnR/rWYCLJfdPIrS?=
 =?us-ascii?Q?lY1bUDGcrYtMMFgDsctUXamghXRuMliimmUoHMSeYCYxjCVoVPB4FzMao6gK?=
 =?us-ascii?Q?SJ1klzueC3kHp3GvCSuJusX8xhXAGYA0q8Np+1jtH1Y3gd6b0/jieAL6xNzF?=
 =?us-ascii?Q?R81DMtoMBrpHrJv5OWjKVYou87uq7ACG7b8YvWjGdzOCfpRHhDUrY5uRhPNe?=
 =?us-ascii?Q?xfM/UNGgnNqjiEqPtNML/4LSQn1CSkQQZHa3h6gxCJKUYRweO1nK1j8fS9ki?=
 =?us-ascii?Q?+26Eh45sjotq5dzuzj1tthIo4iRqQh+5HYb3bdJrgqXTTtQQE6DB6T0PVCBV?=
 =?us-ascii?Q?+8hsSVR8Pi1jlqIbv7gcyW1SLIYjwmINcPLHY83FIxDJNPNI3/CWtNiQZMj2?=
 =?us-ascii?Q?6gQY4iZirUC76RvTomC2FSq7m3d9ps9KylwKOPBcHNJ2W45VV5XfR8tx74HK?=
 =?us-ascii?Q?oMSwk4gs1RzBaDa28veasOiIIHiNpHa2O1M2PEPaTbNnUzJopeEdFiwUVhyW?=
 =?us-ascii?Q?Z0dpDpT89OTFAbqpFaDOtfW2CuVe2Fdw0CXELLnoD46DvpW2GdEDF9z537j6?=
 =?us-ascii?Q?tRejdYt4hqhiIWtI+wTR2p74r0EpZglXxp+i5RDwYGUhGcL3/8t43otKQgqJ?=
 =?us-ascii?Q?RiByB0UFCw9kWFzduzIUNbk1vA4sACXzWEc7EZ9gqhHe6XEcyupMgyW0S0EF?=
 =?us-ascii?Q?HfddXuQ3Od1r5OXyEQJ4F/anIGfMkiN46NwyRN1tYSrrOFM8XI29VQ7h2avJ?=
 =?us-ascii?Q?Wtr7KT51ZuaMQNO75ORmqq52Fhaw2XaBFQEbhFxjjpLZlWR90fwrYcmjyl80?=
 =?us-ascii?Q?SKhJYh91CpRy/Jf2NEX6Zgv45pAQkIPHeyKi7SCZf4xDVcvV8Hi/KEFdntpZ?=
 =?us-ascii?Q?NsWnSfIsX6+ahGnURVU3OfModhoAHW7rd3S4idQP5c7mxVdIrSIAZENI//hR?=
 =?us-ascii?Q?iRqsjjoLa4EGtUZlJlVCju3I84FVmTRiAA/Beo/T8rn7Bv+LTE97auw6F6zH?=
 =?us-ascii?Q?LDdEmmJ/Ga+GpYeUOQEUENRqR+8O+auXHZKSHBR7DjvNYAR05Nl8Q9h1OMBM?=
 =?us-ascii?Q?UNLc8jYE3q9dwlOOITirzSHUcbHlq6LBVVTE2Nvy1N++ZKQAZuOxriaMhDBH?=
 =?us-ascii?Q?Aty3lS+DPIO7m/SR4chahKzQmdq2vx7uzD/ECL+vy1q0F7uNyWZLU6+QQKjZ?=
 =?us-ascii?Q?8rtago2ypYTjzQR80wutkU98IaR9oYtppZy4REBIfwAJPa4rgSjVoZnGamOr?=
 =?us-ascii?Q?tL01Y+r8kYwQMKeZdJ5gk7UXmlaO4VK/k25Y8SfezHNV6c1U65J2VwQwJK0j?=
 =?us-ascii?Q?uZJWAvPpF1Fjdj3GqieJXVditFLq2UB6Vpb7zKLy6pRq/s8CgOkAPAGheNxp?=
 =?us-ascii?Q?2iuFd/gJWpCzT/6pF7JHGSKwWL3ZrALIYTasVAhowMtZjjnuEn+ti1OMDGdi?=
 =?us-ascii?Q?ukW4U1Vgqyf2aPJekhrP+lMb4GoP7xR6tjfcypTKU/FiQA3liKGWu3YlKDPu?=
 =?us-ascii?Q?psVo8jI465gkn99w7nUi3rhySDhVb0zcUY+MobZ2s5UIKQlv9ZmeoKbT8Ubd?=
 =?us-ascii?Q?oTIMWjqowNoaOtABRUm8eQ+It8OoBK2e/z9qEzzwRan9ZDl/d6y+QScCKb8x?=
 =?us-ascii?Q?kxFh2x3StlhrRGopPrcpnw/B9CyXFeM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c558a722-1ec1-4971-9512-08da37d9004e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 07:43:58.3614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PtZGbazGNFZ/XCqqkhKjhxAzWPGZgE13Ll15whSSxHhV87C4Z/0pK8H7vKJKFXicRBqb5L60HZSjzEFNnlQvig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9126

Use ASSERT_STRNEQ and cleanups.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index d90ac3620635..3050655d71d6 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -78,11 +78,11 @@ void get_msk_ca_name(char ca_name[])
 	int fd;
=20
 	fd =3D open("/proc/sys/net/ipv4/tcp_congestion_control", O_RDONLY);
-	if (!ASSERT_GE(fd, 0, "Failed to open tcp_congestion_control"))
+	if (!ASSERT_GE(fd, 0, "failed to open tcp_congestion_control"))
 		return;
=20
 	len =3D read(fd, ca_name, TCP_CA_NAME_MAX);
-	if (!ASSERT_GT(len, 0, "Failed to read ca_name"))
+	if (!ASSERT_GT(len, 0, "failed to read ca_name"))
 		goto err;
=20
 	if (len > 0 && ca_name[len - 1] =3D=3D '\n')
@@ -118,11 +118,8 @@ static int verify_msk(int map_fd, int client_fd)
 	if (!ASSERT_EQ(val.token, token, "unexpected token"))
 		err++;
=20
-	if (strncmp(val.ca_name, ca_name, TCP_CA_NAME_MAX)) {
-		log_err("Unexpected mptcp_sock.ca_name %s !=3D %s",
-			val.ca_name, ca_name);
+	if (!ASSERT_STRNEQ(val.ca_name, ca_name, TCP_CA_NAME_MAX, "unexpected ca_=
name"))
 		err++;
-	}
=20
 	return err;
 }
--=20
2.34.1

