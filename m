Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352DF23BD
	for <mptcp@lists.linux.dev>; Mon,  6 Jun 2022 09:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654508285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XwkqS9PSLhqCLgcCxG/hUYB4/dM8U5lqZKFohpHwfRM=;
	b=aNuud4uYgZEIbRefBoEQXG8Sqmr2GD+sIWu6pS+1yncpBco3xnRMP9+d7HyQp4RyUeODx7
	n/9pLWkUCC5iWn9+j4AjymPxWNOvpi75+4qG6LznXJLck/XpszbxqLAWxD3zzVUGXGaYx1
	z9HSzbv60h6AdjJXx+CX2UHMiZqCicU=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2050.outbound.protection.outlook.com [104.47.1.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-Rmn6qIIBNCqsFjYgg0xjNA-1; Mon, 06 Jun 2022 11:38:04 +0200
X-MC-Unique: Rmn6qIIBNCqsFjYgg0xjNA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWU7MrmRaxHhteXswyueF31SWm5A8ZhnMKNSG9PLynwnaT3YD7WkdNBOAZL0CY5oEOUPNvG6HlbH/7x5gh6J5xBXAsLYi5+SSyx+ixCSTHnxiaRjexlowg/UTFJCNPGG8KHpcPecnN8PBiVXhz7cyG7y7t7KM4trTS8FGU9EePBwZYXTRDlJNfjIVvskKkrdEqhTxZJaA87zte/cnp5EObUc7Jc/hpJS285c+aO679Ce36Sye6mqRnEOg8hjmLyqMunKOBFZ018EnHTUcI0S6Pio6Zu4EDgzfBJjUpLopLRQAH1hUIA3T9jEh6T7ORoOIlEgM9Rln+bpSO0h05cYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdUZ25v4zFIOIs+cj5BRwYxi67vW3lbmBfPb7D42oIE=;
 b=CBEOzNp4kbmZZvQG4GqsmFhfDmK4ueuJUlgAC+aOcA0+/vqzG4axXYg1iQbWJUQ9F0QgNw0jC3Dt0IawFt0y/AlwjSmxPyR17LpRuPzfKqrsMWF0/uuzBAv7OQ6aCYBzfQ1aIBeyofSRMo7ngyyCSlKcjacF9KvAE6kaLFdi4EqR/xhJeid+Q84OTGwv63nG6d7SJ/CJCG8zXdUdbuF+KDhBKzwtMY48Cq3E+SVD92pk14v65J+mujLBwGALW88jl8/vGBMWzxIsrcLceowwtUgky1WTUSVXHvPRnpSH0zMUVPIT3XClbgk6X2//YNKusU0PR9a6SzP0nsq8dnJXKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4751.eurprd04.prod.outlook.com (2603:10a6:803:53::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 09:38:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 09:38:03 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/3] Squash to "selftests/bpf: Add bpf_bkup test"
Date: Mon,  6 Jun 2022 17:37:29 +0800
Message-ID: <bf0c3a562af07ebc092082ecf5b0032c4c56e715.1654507832.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654507832.git.geliang.tang@suse.com>
References: <cover.1654507832.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0194.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1dd654ba-d7a0-48f9-351f-08da47a0409b
X-MS-TrafficTypeDiagnostic: VI1PR04MB4751:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB4751BCB3AE1099BC3B2A6990F8A29@VI1PR04MB4751.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vqItSXcXit7ANLlnR/RnXz6rsZZWWQqYdclBvTgzsJkkavMOGHNgZRyCCMLtQf6F5Ndi+nFieTNC/Vzv323r1K1EbpZgKj9b4DSnxyQpQXJLMpouSiJcoDXqj9BMnb+HoippJcwmy6xe6gS5Nmk8LrOg4GKIOzo9XlHpV5p/jvbV9N5XjRjLysAPWIlDNl5UhekjLc2Gr77fE6AXFM0SqzvGFNOwvASd27Qn6g6c8ffk5ZjJr79DzJuL+5f/EtK61hUqPloBB6Fv3mYNs3gyq79H4VR6blNFhcKf/Nk7yoVnMItTdqi4EIJKgmntUMUsAdsw3xIcBDHYMtLTnhoNal8mYMOlr4hwQFaEM1bmHgBWwmOdZbej5yssHvnKmF2FzwhqSMwjdhnCdnPhxh5MT1fwHvBqknBrBCAs4bX6H05IGzQfPCCE/tV0AkVSfoOshESmExeTNVIzlErmP3diEw6WzZ7/iIEUk9/puRrtc0QupGDuaJaz56Xf0qXc5pCHgMeTwxdn3jKdoZv36eI3OVFcewbOY0OF5J5i/uvmiFkVJa99IEqOX9qOSm2Rvaa64ETIdgjHIB5wmeiTzXkr4l8FNnytax+ymWmo0CA81TFI1Le15X2Rtbh/ET/ngI3IvGnw9PoFZU676KFfZmSCdZRd50/F/WyCD9J+dPR9NpVC5/iFd67MOnTRI2xwhROe2NlSd5Mxzj2s3HDNIY0LAw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8936002)(8676002)(5660300002)(36756003)(66476007)(66556008)(66946007)(2906002)(44832011)(316002)(6666004)(86362001)(83380400001)(6486002)(508600001)(38100700002)(6512007)(6506007)(26005)(107886003)(186003)(2616005)(6916009)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IOjLRccmhFo1uiFWkcqz3hGQMHdJwbYewAa7+pMOpshC1GukT0CTay591rNB?=
 =?us-ascii?Q?p+2rKKEVLqPYK91ZSSpAT2Ou5BYQmQWrgK5Ut7DMbHRVFCHk3CWAMCFtdjYx?=
 =?us-ascii?Q?haam0oL1yzfRhg2fwJcKrxsJj3nwFKejxliGPoZKj4BWzMGGAW2A4lDS4BMM?=
 =?us-ascii?Q?ppBfUa1FWSjXiwBTe8VjOumwy6/XHT4rMvHzO3d2ztOo2/WxGRu3DTB1Beyi?=
 =?us-ascii?Q?ScXaw+KzhkkPC8fUahkqQsqVi7eMZOTY8+DIxLXrxj7vq3IsGnJ0qWSyLpTt?=
 =?us-ascii?Q?3VjqLVVD0IBEx6EPpaSS3sqVoG/5liTJitvrgkC+YaZRIpMmAa4n9m34aCI5?=
 =?us-ascii?Q?qAUoNI+Bs8nLi2g1mrbROWjwxxzJxEZev08RW51gsXM3Nc3b+1IE0cVp4Zoc?=
 =?us-ascii?Q?sUcFcaxIBmPQryU3EqvuwepjLbKzTH02bNZ6LlaZsl3qLDppSTLBxDHrWX0I?=
 =?us-ascii?Q?8uC6O5Y2xh7NCzV3VAPuLWBChZZb7xPs6ycQfSS2uN/hj1b0WagsH6jr0WHS?=
 =?us-ascii?Q?boBiUBLRVM3J83ULHl9Fn+uMy1d0Pd1/MY/tmVjId6Mr/Z7i2kJ8skqd9NGh?=
 =?us-ascii?Q?Byd0HWMnRv5QmbDCNRDuLCXY/dgAs8JBDkH2ABawjJ4sqEvljzyP11YeRjmT?=
 =?us-ascii?Q?8iASxLSpKnatf+IHxbNh4usBeofCny2WyuDnyXfWqS1DqAavyPi14AubKpBk?=
 =?us-ascii?Q?jWh4bHmtFc3vY1OnKRYpRNOAcRfN0xUK+uqsKTotvHcd5M2eycXtPnBgzUKj?=
 =?us-ascii?Q?WsUzm6BfWOBMzAChhTwElXAg8PT+OZOQ8q60puHBSYeR2V+qn6X+eZbb1msv?=
 =?us-ascii?Q?Wipkyyw95CLl2zgVZLZKHoiwPOElQPLkmp4i8mz/sTf4opc7pDrKnMq5sAOT?=
 =?us-ascii?Q?Akb49oyG05N0eIaxvIu6AKcLQC+vZmM21rUWDFqrjt0Ew9MvdA2SgX9X2TUg?=
 =?us-ascii?Q?vxY0dLXukFrX3z6YVW585UMZ71qvYueHsHYl5aEKlBDgNw5OIknVmzEVmcnq?=
 =?us-ascii?Q?MViL5DjCipYB/10l5qah82raXLGzmKdMw9NO6zyspvWlXOIhpvBWKrjOzZB9?=
 =?us-ascii?Q?OaqgaA/e4KaS3bxh7MCkrXcmUowlQEM7zW7S+r5+6ZnxRORPuEb2fiaFMDve?=
 =?us-ascii?Q?4+3tOp2K+KL4skK8OH1aZrEv2+e6tE5OHPAjSs5nKIXyQhtVMROcl2QZEIvp?=
 =?us-ascii?Q?f3ledvJQvJ8f3+23pLZxa27Zfii5+lpu2l/wGfsVgS4G8pANbyw0xLW2Ljc7?=
 =?us-ascii?Q?VVvI/FKjo1bpXsYcDl/qeVQDf9UCwcMnaE371OpcZvbO5fqpm0Mlz/ph2HSF?=
 =?us-ascii?Q?KUP39mJ98U73uiC/VNd8I0HgLkMZ5/2AGlEfsjN7amelKIBJlQwRTqP3LmgS?=
 =?us-ascii?Q?3/JJx1iLIvCT3msi0ix47yIYVHZ0t7PF5TkgPLP7RTHXVaCTPb0DrDa1dKjf?=
 =?us-ascii?Q?rhTqk4ZMbuKC9t4YIlxq5IrjLdYRB9gzjVrcy1I2mRlkE3LAP7zDvKZV2Ngr?=
 =?us-ascii?Q?Gx23e8CCKoARfPdyRLYOT9GhCxU/XxTKW50r8w4V9Sc0kD7i1LQeCEk7Y8fD?=
 =?us-ascii?Q?bNxeBs92tF1D9qCoVFAueHFvEDKD/s3LzPQVN7LWyGKjfpQLo933mfbTdFaZ?=
 =?us-ascii?Q?3XsKDG/2zbdNzWbXfv/ivHdJpu6jV+fb1fmbwUNGobHM8zahocYogckrwyTK?=
 =?us-ascii?Q?Oz8cK7qNYLy/jYYoKGP4b/XHpvC91F554QZpzVwh4SapO66XmQhvzL0XBrEI?=
 =?us-ascii?Q?fc4nAOU8jfsyDUQuef4evPYVdO1RDkA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd654ba-d7a0-48f9-351f-08da47a0409b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 09:38:03.1536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfCH4GSP5cxHFsJtVVaqdI9aoT4hqkrfvO8Pm4a0Vb+C19aRwTf7lvT/Of5fk3/LXQNZztHPXIUvNS4K/TMPiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4751

Please update the commit log:

'''
This patch adds the backup BPF MPTCP scheduler test: test_bkup(). Use
sysctl to set net.mptcp.scheduler to use this sched. Add two veth net
devices to simulate the multiple addresses case. Use 'ip mptcp endpoint'
command to add the new endpoint ADDR_2 to PM netlink with backup flag.
Send data, check bytes_sent of 'ss' output, and do some cleanups.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 3122279d0b9d..0fc446c20d72 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -335,18 +335,17 @@ static void test_bkup(void)
 		return;
 	}
=20
-	add_veth();
-	system("ip mptcp endpoint add 10.0.1.1 subflow backup");
-	system("sysctl -qw net.mptcp.scheduler=3Dbpf_bkup");
-	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	sched_init("subflow backup", "bpf_bkup");
+	server_fd =3D start_mptcp_server(AF_INET, ADDR_1, 0, 0);
 	client_fd =3D connect_to_fd(server_fd, 0);
=20
 	send_data(server_fd, client_fd);
-	ASSERT_GT(system("ss -MOenita | grep '10.0.1.1' | grep 'bytes_sent:'"), 0=
, "ss");
+	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
+	ASSERT_GT(has_bytes_sent(ADDR_2), 0, "has_bytes_sent addr_2");
=20
 	close(client_fd);
 	close(server_fd);
-	cleanup();
+	sched_cleanup();
 	bpf_link__destroy(link);
 	mptcp_bpf_bkup__destroy(bkup_skel);
 }
--=20
2.34.1

