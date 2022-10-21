Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00060.outbound.protection.outlook.com [40.107.0.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B707B
	for <mptcp@lists.linux.dev>; Fri, 21 Oct 2022 11:01:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLEDQJvSF3bKUaJDXfBAoGxvUFqhLSfy1tSvZ5ps0am6cjGeKA2QP8HNUdOxH7mJtqcZOMxT3nuWh9BSL9YhqBGsqrkQL/CXazj8UZSllvKX8w2FvyrgewGln90w0EHaIztuAGyCdqBDNC7rFvOZ3awVVJS44NTnZnUYh4Jb1CqCaRhyLe6zwtaRcW6svpULg/SPp8CIRUkUUPLX4XSJxAaP+IXm9GczP4b7XAJWBGEezV7Ddy4CcROWeaat0kRHhIQvwP9mofPKzYRiszYRjhH0Au8cCidKOWEedTShN6KMDVb1GBhtcbXm/fFnhzVqAZQz15mKWaU1AxF31Cvv/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLG3FOwPqtJ/hQL/djJpA4lAUiUND6uo2vouSU5Ipow=;
 b=Vouq0ZCwvh1u6EL02LFXzLZORAKkyLX1hWsnv+sIfVD6bti1x08JZEc8AADRJf2KOMVBaWRHq24eCaS/Px8PiOL2q+nl8EUWmbly/UR0vIIO20nXGjGLy559oZ8/AiA+Yg+Q07PHVmBoFDXTsooZKQ2oPtIZlfV5/D3JAil7wejFLgTUR8CGzU3qQgWwUYY3GERNWqeBXHO8SbVBMOI707AKExc7WBZoWVqdbFvtQAzIJaT25r52/YaQNVlrj5ZbLlMQslY66EFYRluOWwq21tUqITP6k5mGpIACzjH+EaA4Ei2PvwoFSoPQGLAtvUohgfPjc7TGKOm/vmImJ+e4Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLG3FOwPqtJ/hQL/djJpA4lAUiUND6uo2vouSU5Ipow=;
 b=f+QCQ92CkvXqdAGdRTDWAvqEjEEIG8Bej3c69nVFKy3hZRyg97GxjJiPbmYYPMs7SrqtJ0lA3Zn+WwcpVQRbHkHAuCRaLn6EHvWnCzLi4bAIgWAlVCHNq8FmM7PfQAM1Syk36pMcl1YAzEYMI7RvYNGaaWQ/WKod5kxlBICiyiykKuIEuLYiLjUFoOvZrSIL3vPou3xH8LxNvS0sWyBjsiRr1njQ+mVPMpcwC+NLC0diyJWzALqQlFnvBh5f6zAp9WRZzOHtNAnweAGXvteVkU7SxBsVUVsJiJXz5sOzLHYjpwrnna02w8kgGl+L8wIH42AsF5WOjz3u8Bj6S10CYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DBBPR04MB7835.eurprd04.prod.outlook.com (2603:10a6:10:1ea::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 21 Oct
 2022 11:01:37 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::58fb:e772:9521:1a5%7]) with mapi id 15.20.5723.032; Fri, 21 Oct 2022
 11:01:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v15 06/19] mptcp: add sched_data_set_contexts helper
Date: Fri, 21 Oct 2022 18:59:58 +0800
Message-Id: <a95dd03e0cad84b3173381f0585bccb9f5cbba13.1666349129.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1666349129.git.geliang.tang@suse.com>
References: <cover.1666349129.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0019.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::6) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|DBBPR04MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cdb7645-7704-49b9-9e8a-08dab3539fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GL6ZwnqFBrmvZ1VZxVgLJSpeyjwCRrwsVDCG0tWQtz2qcxZvG/eE+LaymwxZQwvPdh6U6zPZQGKLehRbXju59RA2LFwKoTP0xSjdBkIYB3cE/9rM/hRS6fL/W2QcQQ9hUSH3NkW8a6d/BhJhw4VfS9e0monWjITWoaJMI9VItxRqSaAN5IhgOfmcYW9L6WMO74oXZAgZMHO01362ShIa/yO2QY7zeLU8P+ySvTQtJcr6Q6sytwNAXmQMCUk038TypKEsneXZ7Zp0x3NXWFpASnNHOcicpfgNvKat8nMehAptE1cqVMzbXrT8gBSlT1woCZyuwfcTw3EK4Kb/ufIyoSv337ONwfXf1VxbJMCK9NEwWC5LDS5RIe4g2H2iVTCusxfRe/p6Mrx5Gi7SLf2Lyoa0h7HcRwrIKJH6pp60ee/bHIGoyixlTQkgiJsK8Kg6+H8y5c76IQiOyIx3GkBs+vpPIGG1OIlqddb9Z6ToFfe80G0BY/ouJDBqV4C0DiREvbazcMPnuUb99xD0/pmgCyv+V1MgRGZQIdi3njcNAb1+y2MaD0wYR43CZBVXV7ZtxMAebcUJnz7dW7o65tMsEK9OFQ/cHvMXFciSU5WMl3A44VCaWjOlLzj5WoOsT2Hwa8qvphlnWkogYgI9g7FEqT0BUSO1l1Lb0UaYomHKfG0A/PAkn6f5bueht31ME6a/GLbMdJcSJdU4wtmDWrQY+z72VRV2hJ46/GwLJKBSjhtuDIlvYg1BY/ar7kS2nhIo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199015)(44832011)(66476007)(86362001)(8676002)(66556008)(36756003)(66946007)(26005)(6506007)(5660300002)(41300700001)(6916009)(4326008)(316002)(8936002)(107886003)(6666004)(38100700002)(6512007)(6486002)(2616005)(2906002)(186003)(478600001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4GX3b4IaAHlZv/t9VnrqC70rp2ojAx94d0X5CRn5zmIF1C46KEgMsYtcG8ru?=
 =?us-ascii?Q?7Jq1WrUVa93jz2xaH4BIWVgdU+44D8dxZDuusYApWMSt5IM5pD8xqRpguGT+?=
 =?us-ascii?Q?6K0VRer/oRwnpwasfqifrS5f3M8Yxlf5Y5scsVhAO/fc6ZmpZhPSjE7MjclB?=
 =?us-ascii?Q?L/ftAKVc7+76Hq8jGI1gJ2/gGNFp0U60Xdy1U9tCgEb9dqPTW+Mw5kBGdNSY?=
 =?us-ascii?Q?F5i/AYVPBUbORcgKGOQAEb+F9p1TZ9+EW4JWrLMacWds62ZY/G4QJXiD67gc?=
 =?us-ascii?Q?VOF5CeytFGjbC10iAQDef7fkX0zsHwQesYKDYd7/zWl9tAbHx4tbINRwSvaW?=
 =?us-ascii?Q?2xKt2tJahA9kX5xnCrvux3ncSjLg5BbH9PlbJxn/QTjfqQNQTHLVYQLL84nh?=
 =?us-ascii?Q?fEQUffEO7c6zVd2NIVTDmEl8oLDjc7gsIXgzXpzLM/Z3SC5xvKCrkvFqrfwX?=
 =?us-ascii?Q?Lj3QKPuQmj8e4J11/ede3oUxXQAqcw+APq7j6sG5gdDrFJiO4lFUOTwJGL8x?=
 =?us-ascii?Q?9e07C4wSmVzupHyaN8PDykYej1M/W8TbkUOpVPNxQ9bY4bG4scM1WKdHh/Ey?=
 =?us-ascii?Q?WPzSIZQwbiQQAjd4dmr6Gx2XwgB7fmEDuvaleRjUNRfqaShrV0cKjBXLgtoN?=
 =?us-ascii?Q?jk/yBDjbWnrR0MpOAtdcPJ7wWktZrUx9m3+s6sayTPUsSjjyeUCNLaradxvB?=
 =?us-ascii?Q?dwnk0G2E7k+ayDHhypw7LczbO4+HdeVtDSnqBE3gG3pSr4W1EnUlTPEW7WoC?=
 =?us-ascii?Q?3NyttKuTSST0kKcdCa+8MTttFVJx0o7TdjQ+prKhO7nCJz1PunLN4Bp7s2EB?=
 =?us-ascii?Q?JP6XNtPYuXotPKU7SLwundRZ7Zd53jC6SttL/qFN7w/aVvIuCHHUfABPBQ+E?=
 =?us-ascii?Q?uWuBqHfhvyQNWiEUqDVQwYPpXyEAWJ9ThvA8YkA174nTwCAGnpgyAPq5/7yR?=
 =?us-ascii?Q?t5o6I1H7qSRyTpAQolrFk5bn2XF1N8p3EScU9lPaj4ptliKhjhWLB+vh+Iw1?=
 =?us-ascii?Q?t+G2C7a0wTUM9RQSrbU7oeB8hS1dTC9zKKv+nSUuMMMoBNt8YaCOTxxqsXY8?=
 =?us-ascii?Q?2BJ7U9eKXGT6mzZTzv89uDWaGppn2VS98uDlkREIpEv/mjl3zpP3/ivmHT79?=
 =?us-ascii?Q?6k4v1S4YUBX8Uh8PpYFjep/mtD8LQTq/uRHQBGY+vBS7B4lWoUBQzCuqivrn?=
 =?us-ascii?Q?i10t1D7ITmT9KVjcxP2T7ioTGqzPXmt7eHb+LHNlAHYIf9Gsw1chFWXvEIzl?=
 =?us-ascii?Q?YIg+L5k5wcC6xJZ0qTDCH4oGNr7LgT3Db981muMXCZ9JGo1Kdj3tcWYz8BZ9?=
 =?us-ascii?Q?HEO6T2WHpNCpNcqqnNS/mp15mTAWFjAqTsBV6evQeUUkbD1Hph0nJy+zTwHk?=
 =?us-ascii?Q?lejt8gsC2e8+rMd0VaHNFQ8QK8R+C5WbtDWp/+uq7ptjUnDMa+UnEI1EA0Io?=
 =?us-ascii?Q?4IM8B0HpS/cN+nIwn6Z/qosAObq/zOWEyEp9mC78ImIupXXOyPnztCk/SmnB?=
 =?us-ascii?Q?cyHVb2KDGS3u2D7VxC/16HTeutABtfzegWUoTiNlesp8vEmR7Vq1uqnwTIC+?=
 =?us-ascii?Q?mWFcYltY6YXoFbbyw3y/fidgklpjRdAiYuvIvHmmrUV1QuOmmLC6IffVX/M7?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cdb7645-7704-49b9-9e8a-08dab3539fe3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 11:01:37.5623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lX+35oCIZe30XFvP8rpV7URUCCobUaR3EgsBNvzVXNjdl/r+xVHa/H/ilin0XArbsAquqCNsIqPFAZjKlymS4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7835

Add a new helper mptcp_sched_data_set_contexts() to set the subflow
pointers array in struct mptcp_sched_data. It will be invoked by the
BPF schedulers to export the subflow pointers to the BPF contexts.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/sched.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 1ff2955c6f26..500ca89f6424 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -105,3 +105,22 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 {
 	WRITE_ONCE(subflow->scheduled, scheduled);
 }
+
+void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
+				   struct mptcp_sched_data *data)
+{
+	struct mptcp_subflow_context *subflow;
+	int i = 0;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		if (i == MPTCP_SUBFLOWS_MAX) {
+			pr_warn_once("too many subflows");
+			break;
+		}
+		mptcp_subflow_set_scheduled(subflow, false);
+		data->contexts[i++] = subflow;
+	}
+
+	for (; i < MPTCP_SUBFLOWS_MAX; i++)
+		data->contexts[i] = NULL;
+}
-- 
2.35.3

