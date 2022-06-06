Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EE623BD
	for <mptcp@lists.linux.dev>; Mon,  6 Jun 2022 09:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1654508292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XuvOmWXSWmD0okORzpZRMhcGspdMXihA36GIMe4wZXU=;
	b=QNBydM3adTDL3S1284p6cpEFtUoJA1PdVdrQLFr7CLH0TAlYhkxBbLgBbwFXVq196ECZyF
	QRSI5cw8o3F9CY1F4LNi+EfISIqBuCHEfo7uNDd6dBhRIoPZjA/4PBp/OAaE5h96+1upeR
	OpduHK5izbMysENyV9ysOSP+zDVZ3MM=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2059.outbound.protection.outlook.com [104.47.1.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-oR8hRksGNByy9bl7ezZjew-1; Mon, 06 Jun 2022 11:38:11 +0200
X-MC-Unique: oR8hRksGNByy9bl7ezZjew-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7EK05O6a336aaIWqzbZqV9jadeboBDQEi9vaG97iCx6EYwzHo1u9yatQVJm5hTdp2peXFGBiVVLy+isvdxqPET5Y5+b8V+Af7BjwwdQkn5yZapfv415F4DGriJix/BtEEJXSnONcCu6vQqx+3vNADwrvaCP8WKI3UaxIsu4Ys0K8UExLgHrOJeqAx6PbgDIT2UTpg3cQvKQYN7ukU2YbOLHIaKE9FIpqmQd9KoVmbbBpxV29rbdmvD6dBUBm4gNZxoGCWmSuV9mi0h7B03dwOhBvCinPswjBhz87h/viZ0lwZdQA57MW1SXexHlpxy1zgP/FFVrfFB93ksGV2b4Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfGcOCS0PNObgQJXcNK/NF/xARDlF7Nw+ndAZ0JNbKw=;
 b=gD/uz8Mir4+NXkLkB4UC6oUPpGTbwAG/Hfd5TNs2d0h71d2bRkuQf+AP5K9kmeSYtyhTqlP6LVmQitdKD79gdE58VKvcPeNERTwqeTyiqFaMJ9HLTqztrhKjxsaYnp97sg8V/LyHviAfQHLiQP6hAJXvd1yc8uvQS7XBhqDgQIOb29+sLOlAEZrcg++bbl1TU1YzCnOHXvMNUFgs8AmG9jPuqgbkzi9mXhZC4kx32eUljRqrcSIKtcYovx4mmDFKlLG5wT2f324HSUuAj34577Jb9QQs4ZrDuE3YMGOnyXmMN6++tsriwT3eh2rP4g7xvHWERo4D5UiafgxEey35fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4751.eurprd04.prod.outlook.com (2603:10a6:803:53::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 09:38:10 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 09:38:10 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 3/3] Squash to "selftests/bpf: Add bpf_rr test"
Date: Mon,  6 Jun 2022 17:37:30 +0800
Message-ID: <9c943b559892de4d8c76e38f3fd2622a59cb6f0e.1654507832.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1654507832.git.geliang.tang@suse.com>
References: <cover.1654507832.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e14c7e4-7083-418f-8ecf-08da47a04497
X-MS-TrafficTypeDiagnostic: VI1PR04MB4751:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB4751483E71204C21CBE7D884F8A29@VI1PR04MB4751.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y9ooHkhHJpx2ShkVgUOmaeucoozF2nHLabLci6I45KSnsJGM2FTZ0xMvL9KoPbCQ8AL6xzc2Cj+dup/tXD/cqK1ulD3smfyP9Kfnz+QH+hHbvQGCXyQC8LKZqH//Smhg/y/gQM4a2WmzIcFFHaTnsm1dbYMs+zRrFnO2hCQR4HXtHDQIgY0okcZs+U/A3wRtNgHGBT29Vm03an1/ixJ8K7ylW/EY4i3Gt0Bb4YI/xIXeKutqIRMbUGnnK7J6vl1QiYmPXsZ9k2Zk25hPwDKJhVj13AhlWNCQkB8jaamDK9AWL61BvnIcdhg6mgOuhANReTUrwaG9qxQLXn2ObpQoFAMem0wyJ+/0iL8fEzUCMcZ+VlWVuwrjWZkdu+RxJsGXnxsKJM1XHn//ySYW54aNlMqZIQ5vhnNKPWFrLwEIX3dqZ583MuPTylXPetINH5ZF3zB2WKLEpYZ7SPSP0kouTkVsf25waZaQZNpXqLtNdDAlLbmrYieaqUHacAMFN6n3QtId0+M/ryA3LZ2P+uuJ0KrztvCfTZu42+jrvWQZoZfHpjOhu6TbuMcDlaJ+47MjazZrjcjTgmerrnuPqlZcjiMewyQSy77R3S3TU+FXHe3L/STsCg8fuRgxBz18F8wQv0AborJEdviBgO9hpjDYePAEmFM2IzqOlAS07prgZcPzvm+tP1TOp7P3rvBTOD1jybqTFVbN1Jl0q+vIy51q6g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8936002)(8676002)(5660300002)(36756003)(66476007)(66556008)(66946007)(2906002)(44832011)(316002)(6666004)(86362001)(83380400001)(6486002)(508600001)(38100700002)(6512007)(6506007)(26005)(107886003)(186003)(2616005)(6916009)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+RbcLwd244LtZvAKBp+nPFd2s4MAhX9kiLSmfCPFCXvNLJ/7rZnzOufCIPw7?=
 =?us-ascii?Q?c4UIRt3QPH6BtMUXUJ/yb/VL1DWJFrCQk11PVQF73KpshAffocBQmTfx5hKO?=
 =?us-ascii?Q?2x3cat+8lJrrtiO6BnNO7F9TrNUjuV4Pv3rLUDmlma9s7Cdk1ihtRja++h7f?=
 =?us-ascii?Q?OcaAkaq5ifS1bXHKbsvlmirHd/wwS/shPVYdwGsnwjVSP6GJiL8TyRhVvNW6?=
 =?us-ascii?Q?uoVtmoAJxDFJy10t+scEe6rncpwWByTDeTSHeEvjSAaLEAjZKxe2Qwc/mFV5?=
 =?us-ascii?Q?6RIMAKsB1vJY75hQR+uMnqp9/kKS6dMQFaxtGSECrR4hEtaI4QXP4fU+E4zG?=
 =?us-ascii?Q?2/oIoyyb04h6tSJYU9dsVNMSjabxGoXixg935I7/Bj3HrT9aaeeJ8Zb/Ygbk?=
 =?us-ascii?Q?6bT7QgzPM4l++YvPKeoXCItULG4KpcE4t3ApqG6H3d3qw6mnDVU/8WcK9SeV?=
 =?us-ascii?Q?eOIAyH4OvnaevLAoDlXwjhR0LV5pTcNmd+H59ge53PKIBeJg7sjEdi/CMgNS?=
 =?us-ascii?Q?ErJfX8WkYjbS3xpbTci4kYBLhzGY80JjRaFMmMkhEybT/XF0I/nBGxMGQIeH?=
 =?us-ascii?Q?9pv8lYmpHfv9/3k5h7+wlpB3yuEqWDlfW03aD9TyZb5n0UkwuAuAqiCh8yMB?=
 =?us-ascii?Q?CisWEXAQALP0vTfLyOZT68BUBjafmK6SJqrtVbV070IJ9Hs+9tM48FWWNJLB?=
 =?us-ascii?Q?fY6BXcyTfAU1yZdTlHgRL80OxvG0UgjQgiIl3i58pzB9eQcIe+zf8ZVWbd9/?=
 =?us-ascii?Q?uJd5CmmuVEdbIB6W/GXxF+4XCxUGCRakYeD/9/GPWRHycWVXSBiwPs2c/vjv?=
 =?us-ascii?Q?dMkgf1S4Hl0XRp/QdqhAZqb9E3CFwVILITlJyDPl2W1RdKfcoYBuOZk74q1g?=
 =?us-ascii?Q?JIDJMQIyVleg59gpcd+97+i7BDkUO3WQ5E3rTnMAQIt85dG0HfHtQvjsvEv3?=
 =?us-ascii?Q?jv2TVw85CwCDfCMDx48SZnmvgGR1EN0c3DovuWq9WAoHF+GlhKEfx043d+Mc?=
 =?us-ascii?Q?LdGCVG/zJ0+gG7J2DLDVqjF12MzKXmDdKRm2vLznaSqbLGn10P4+Q8e3I7Tc?=
 =?us-ascii?Q?TH0bPWm1K7+lvtjMZRVHgTcfwaOpuT5pgB9rLCLqGGSHO0RQyORvWm6MJqpS?=
 =?us-ascii?Q?Bp+UAm7DVJWnIfc3sEj92GlsQLfFlL1mlKhYbst0rWiYq6I8DAs4/3F1dHtn?=
 =?us-ascii?Q?WsYsGMIiq9cOMY9IDUJyb8RFMbuSVnimwwZpglkcN9dJ8KC2UMwEsDgoL/ps?=
 =?us-ascii?Q?HYlO3cEqKJdVwepCDuzxNF2nvXBYQQ75rggTnPWeUy3SBbYAhGFua5tSPygL?=
 =?us-ascii?Q?RUVXXmycVl1UB/F3DLjLjjdeQNP2c/Wes9kTp+Z5f8jvCKSBuOHbRtLf/UBB?=
 =?us-ascii?Q?HN4zegmMf65Aftktkwfm7HpJaLjmBSVI5zEHeZhNTAAkS3r9fxs2e2eFcUVl?=
 =?us-ascii?Q?d4RHNZ3JjRpMJSPTt+DqLdPIfeJ/9Cn6ekPMvRcAkWaeDjs4mWLDkfmyTkNV?=
 =?us-ascii?Q?7N2ycSD7s5ZkUgXA5u45A9iIrWnmVCYUvUdDaEJ7TeeXILWo3Wpu5YeAt8yW?=
 =?us-ascii?Q?7SX3tM6KpeiVgtWW3eYxtNJTG0PMi7W/Gbai8FUroj+oxcoZGFu6+mPQ8z5X?=
 =?us-ascii?Q?Y07hbp+0eTpo0SolzZfOfSpzNLILsp52d8zbrKpVdIf5GeeasS4T1ZlAAIdR?=
 =?us-ascii?Q?ruPWjAM4CcP2DYtIOrxhhYZ2DUVmO3dCRBEqyR/bnh73qSFJdOZL+Vsyw0rz?=
 =?us-ascii?Q?XqDfGdHvoOshcihJtbQavZhn8i+20/k=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e14c7e4-7083-418f-8ecf-08da47a04497
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 09:38:10.0281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txTpohMtNO428z6YLM69nsHx0JoLoGyw2q7xse8Du15n6qj1aB09i0HOuhONa9xtgyoDQHEtROqzTh3vvBRbJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4751

Please update the commit log:

'''
This patch adds the round-robin BPF MPTCP scheduler test: test_rr(). Use
sysctl to set net.mptcp.scheduler to use this sched. Add two veth net
devices to simulate the multiple addresses case. Use 'ip mptcp endpoint'
command to add the new endpoint ADDR_2 to PM netlink. Send data and check
bytes_sent of 'ss' output after it to make sure the data has been sent on
both net devices.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing=
/selftests/bpf/prog_tests/mptcp.c
index 0fc446c20d72..8b2fe1004323 100644
--- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
+++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
@@ -366,18 +366,17 @@ static void test_rr(void)
 		return;
 	}
=20
-	add_veth();
-	system("ip mptcp endpoint add 10.0.1.1 subflow");
-	system("sysctl -qw net.mptcp.scheduler=3Dbpf_rr");
-	server_fd =3D start_mptcp_server(AF_INET, NULL, 0, 0);
+	sched_init("subflow", "bpf_rr");
+	server_fd =3D start_mptcp_server(AF_INET, ADDR_1, 0, 0);
 	client_fd =3D connect_to_fd(server_fd, 0);
=20
 	send_data(server_fd, client_fd);
-	ASSERT_OK(system("ss -MOenita | grep '10.0.1.1' | grep -q 'bytes_sent:'")=
, "ss");
+	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr 1");
+	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr 2");
=20
 	close(client_fd);
 	close(server_fd);
-	cleanup();
+	sched_cleanup();
 	bpf_link__destroy(link);
 	mptcp_bpf_rr__destroy(rr_skel);
 }
--=20
2.34.1

