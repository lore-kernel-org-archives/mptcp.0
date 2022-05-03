Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDC82F44
	for <mptcp@lists.linux.dev>; Tue,  3 May 2022 13:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1651585484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/rjyHRiYvGLivKBcEMye5SCpnsfr77ducaxdMUpOy4=;
	b=gsvyrE1oxVoZIdO1E8icDxRJ1Mq8tYht1jfMErMVkSPe8izyzRSoR4/n1LsIZ1aDPARzJi
	FN13frMHs065Hqrn8TBV2E3kXD2bd7sXorTWktOEbgv+5EFitDqAQLPPUxtaOAagG9Vy/o
	IwNTCVoUd+zgzwCFi6reozgcwBf3ccQ=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2056.outbound.protection.outlook.com [104.47.6.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-N_9rZCygOoiRATYpnNcyng-1; Tue, 03 May 2022 15:44:43 +0200
X-MC-Unique: N_9rZCygOoiRATYpnNcyng-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fD+tZE1KoaINuOwnuvQPS3regwquIgvyj7sB8ZJbn6pl6iRP2IY+o6KhqheIuHfNzUGJO+6ce76sKyI5irZXEI6OAS6mGUydWdibH/XeF+iloYZWRkYg9BxQYtNJvolJHnWCtaB5HvuaFnrEwCzWvpNSv5lIMxDuJafz8ctyb1MKcLm81QJsjvB2gZAkOCljqEcVwlQjnQILaWzpSK9KJEj+1TmB9clFmuWDCHZH6KOaK/tB7Pci9yjEqOxJbQ0iBo1O3CGW4Qp+jHnSb0g8PT8OU9AgWr5djRyvSoKnJHgmshjikDqRsuWDYckRRNPxswU1zcqBqDnDILONOEpyXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NY4UjrFQTD1dDr+NyFI4XpnUAaj23520QJXsC7vbz3s=;
 b=DtGgeRv4hyZdZN/EGXRz88aT6njYF3aFHRLlzLe3JidgL+S3PhExjqYYamYSyKWkb+oYYqTfv6iSyh8wHFb6DMX8VQ1ZwWkM9P5r75Xa8MNO/L6b8S/3e1mVa9SXR34BXAxMLTxsj3UO8AS2qDQQeaaUDghIwePlo3XVPtHvxWquUTOMNdLRD50aUEXaAfFWcOpcCqn2xaEd1f5ehPVRKPeAxD54UH1D8kl91hcaH7Cg8IsskkbLit50ZWIohkh6pxnHtjscM0BIvb9koX+b/WDhv0VCuvoats2v4tCt3fThmmmZzdFGYuM+N+/3pSeyOlJzeZvikdMjunhjXA64LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR0401MB2607.eurprd04.prod.outlook.com (2603:10a6:800:58::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 13:44:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5206.024; Tue, 3 May 2022
 13:44:43 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "selftests: bpf: add bpf_rr test v11"
Date: Tue,  3 May 2022 21:44:19 +0800
Message-ID: <c63db78167c4f1c6e2e7d224d1097991671eecf8.1651585432.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <c7fdf7862cc989dbb43ee07247113b6d9d861cac.1651585416.git.geliang.tang@suse.com>
References: <c7fdf7862cc989dbb43ee07247113b6d9d861cac.1651585416.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0119.apcprd03.prod.outlook.com
 (2603:1096:203:b0::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e3ea37c-34d5-4193-6b16-08da2d0b13f8
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2607:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR0401MB26073AA1FC6FEC93EF9C9327F8C09@VI1PR0401MB2607.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SBUlmMdS9aa2VJaMHOq/ePQh66FirMgPpqp7BsdKDWN/mCJVdWGtPIYLg3FgTnDfg6imiqxsIQaDRc1zGKPuI7gNOs48nhZi4/hGdTUYYXP4FVNHk0+1rBGikRNMSRL1rJCloKVjydFPt0jZDh4JTNBNAxH1B7WVPoDPMNWSn4OnWY1EP7aXV3DdFeJ2ZFv0+TtZYGS9tfhkcPDxSDZHLH82nwPLqbj1NNG4dhOQ5nTJ2oDXhC/OqEb3vifixdGyO1ytdUHqtgHd226F9RVu5EYEvri7yVwM8beAylVpxrVGywvlifPJ0fqNytAxZ2BVArUJ6tO5uLMHU/4ZF8usUyfmesz/ixDrk60aDMRWiMHlPYXyKWUu/BF5kMLLHQMvRmLEqzjN7s2m1sxj6rGw05WeAkxbehMU/v1VSxXYxDNWkPrrZJPPW7P3D1nRpAvyJUheV64H8d17/GTA4XcB6MacjpiZrCSLaKqCHF3TJ7CZCMzk0Z/mdRuo0A3wE6d8Ne+aS/Wa/pFOZv0yq9tE0yU5k/3X+G5KrhUlZSkMW7mZGKloAlwyPhhVeKdNeFPKXo6eB8wjelSxDA5hCzwuohopFSwMfa9Xvt8KgF6z3Q1glIT6gAffJTPTRrertyuvPMEZtRUsmvCWuYIWLC2c2dg17LusiSv+nodFWWpgmnmd460QApJ/HOkkdqKDuyWrcOwT22IZNca5owxgwqBZLw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(6512007)(38100700002)(6506007)(44832011)(186003)(5660300002)(4744005)(26005)(107886003)(316002)(4326008)(66476007)(8936002)(66556008)(2616005)(83380400001)(508600001)(8676002)(86362001)(6916009)(2906002)(36756003)(6486002)(66946007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6a0ujtf1lVNpoiUCELX7foV3LknPfQhFz9eFHg/2buDq9TUf/MwDj95DAy0I?=
 =?us-ascii?Q?+VNIoRH3wZTpoyEThFlBMJRkJtlxeEsFU0H05WwhkLF/+5h6l69Zy6HyjabM?=
 =?us-ascii?Q?Ne4qr/UygRa1LNiZTeZ2NuAXXum6rtOi63JtfKMwkVxP8O3HfvMl1JkyBjRS?=
 =?us-ascii?Q?AjdDR+defPBX687n/wX7IANbltlSFZksDYk01BAY/ujqb6RDcyoFyxMWagEY?=
 =?us-ascii?Q?Bb2yvg+LEp82mQ7PAQgIuegEx2Pewqe7Zj0MZk/mOO8w2PhTq329H+QiW+vK?=
 =?us-ascii?Q?PLD6kFHJCLIQGsMePknhzoKvOpvXoe9Wxru54ZfbnHVdiXZ5fVeepTDuhm7W?=
 =?us-ascii?Q?azMdotpLlGGkHJlNgZ+JlrYEEi0NSwrsum52569v3bC283ewqaV82ibM2XjA?=
 =?us-ascii?Q?MIdJdPuXl/j1h3lbFE7rQ7ZiL1jRILyQQOOe8Rgaem/ipYi0glDd9uBG7hNm?=
 =?us-ascii?Q?GsbtfqEb6s5cpsEg1VZ5dVmPKcyhF31qKYW9TqC/rCZmYN3mmNXni0ePlKCv?=
 =?us-ascii?Q?0eIKn6VOZFwJkwM3HqxAMrgfVfv7RbnZWsc/B1rWDdnxXq02M2suY0JR8MtG?=
 =?us-ascii?Q?NLPc+AcxNNTcx4VaP2uGuwoiiF26dJVM8y6i6jZf4BmcTc9+4Jj+GV1iwfXQ?=
 =?us-ascii?Q?wWB82yFp4oeWc8yVXNAXxoHFTprAkk320dMIflQxkRDyprEys8Cql8lbDMTQ?=
 =?us-ascii?Q?UPS/+pJJSuOiAWsvKz9ThjWP1O1AxRscAWB5K8k08HivXY0dMaiQJ3gYt+3M?=
 =?us-ascii?Q?MHpu6y1qdVu/MN5rZa4eYc1M8IRWTeYY4mOivQ9KCzChZnqlxyAXMXo7XIYq?=
 =?us-ascii?Q?9+zgz/3LfmHf72kXg5rSut1gM9ySrZ5CvUz0blWE6qLWneHlhcnP06bW4Zc6?=
 =?us-ascii?Q?JZxw8R1GSYgcDH+Q8mla+/tArXCi2DAyTY/N36J5xlWgnVRoOxXGiB2hF1Op?=
 =?us-ascii?Q?wZGxAIUhCyni/I2yTcqHRuJqKxtwBViAIFOoubB4Onospi/33EOcCSln3KP5?=
 =?us-ascii?Q?lMkCjhzUl5uXud7qH6RKEfhrz2/BKviaWiZ6d9mnoK0avaRCnpACm9NfkKBM?=
 =?us-ascii?Q?oEZW/tsGTX0El1t8/YEq0WJJB8evGnR2sLpmup51BGYVoMtTidWnsJ+84z9K?=
 =?us-ascii?Q?OWcdyikoYxYnPmAX7VmypKAgEKw5K7So1K68vGksaKeUa8K9nFWcJYgvCtr2?=
 =?us-ascii?Q?CZBPnJagNECIJukQkcE871j9tjfStZY4iKYDMMv8y6zqBRcOgQRhbf16lOh3?=
 =?us-ascii?Q?FQZ6Bj0JSPbD+ZK4tq0LtHi4m98QNPrnT28Qd/I8SD5lUr0hGmfKnrh3xvyC?=
 =?us-ascii?Q?A9Kl+ws89RCqm/YPr5/6CcTFYz9CXWuTbboSr9y1y2yhM0HyoaE9RW0fAIkp?=
 =?us-ascii?Q?5iiC9Htr7IoIMTsjZhOMjbbNHVoAFBw9qK/ji57mUDap1naDkB8rzqJFfT7T?=
 =?us-ascii?Q?CIt20K4Wy2xa6LP0xGs4zjPmP4Y2sctObhNHT7/+8tc6mRS1PS8tTXVRQb/J?=
 =?us-ascii?Q?KjQTo8+ji0eGo18g5rtgAVz2M4xJnfRefgMumUWCYU8GFOc+mnSNNDmAb4ng?=
 =?us-ascii?Q?8YIKf7bMc+gxYiqneFGXpDrAmoXpUut5HjEahoIJ2hfFjcm3CEbItD50ooFQ?=
 =?us-ascii?Q?jLghWvK7aT1NS+mXXssNzszybR3pD3dSTPOt/RUhY899zAOE5KiSuB+boqAR?=
 =?us-ascii?Q?nBAOxoHxLwycvibJ2eEjLBZMtojtNYzRgIX9mt7An6eX48KM+Ix2mqoh9cHi?=
 =?us-ascii?Q?C1Na3bqvmFBjzEcOKXOTPfqMuKFU70E=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3ea37c-34d5-4193-6b16-08da2d0b13f8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 13:44:43.0221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4lsGT+1dmxX/JAdwSAYYU0VQKZtVfALAza6DETOL5vnUz4hBdJ+5H3KX1J2MI/9+Fq0xZWOQUuFrOoofyi27AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2607

Make the sysctl command working with busybox too.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 91707c49e88b..54c981dce47e 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -396,7 +396,7 @@ static void test_rr(void)
 		ip addr add 10.0.1.1/24 dev veth1; \
 		ip link set veth1 up");
 	system("ip mptcp endpoint add 10.0.1.1 subflow");
-	system("sysctl -q net.mptcp.scheduler=3Dbpf_rr");
+	system("sysctl -qw net.mptcp.scheduler=3Dbpf_rr");
 	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
 	client_fd =3D connect_to_mptcp_fd(server_fd, 0);
=20
--=20
2.34.1

