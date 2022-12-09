Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1310AA3F
	for <mptcp@lists.linux.dev>; Fri,  9 Dec 2022 08:58:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSR1K+yEFj6JxgEyLu+yQ6aBcOoAnrRaaar6xrKSVEfu6xuysVrg+Cjy1B/1xGPzzdmsk2AOcDTrFW8/alo36o3S2a8xf9rUc1aRuodswbbMBC4o8MYVCwkTSO09sg4JKF4f9z/ghOpukko1D6lo0M0G8yvXHDEorCvnDFU9JyR5bTZH5vf4cJ3jZOjOcoHxVpqtvuArYg0nJQKdDvdBRpxwmoeK+HYS8vQHJbHUS/81StOCodVOaLW6hNQtdMcMuZlsh1NUp43Msfkzx/231xZLUSQlf9iADOIJxaRSqJ8luwx/08rMPIUqZGBGGhujqrw3v4PLOpEJgLTZtzYNRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rl83Si2JzIaCeCRS0awc7jF4LoBYnfBNc4QA56AnD+w=;
 b=Zg6hAGtf5gHwIPUsJtZJ6q9FHfAeGupsiWepnipyKwZ6DP8X4aIJ88CetiefukVZYs5hI+vVJeKnfCNS/HST38NO77r/Zwww8+D7GyN1dm39mHQGiYYSqOP9K3aYjF9DCCSRFmRsGwaIBLAriAiRd7tb8dWBcBQa8APsYJal6SwTCMNRRZQPT/wdF6HCF1S8dXO4JQxQV7XMTgJ1G/hl150d0cYwmt1NqZn6RGv7wu/PFxzL0zGxfXHKc62SUzv18+B6EYTAEaNeP4LoX/xEf2wZMEe2i4sJfsuumJwztZYpQ2ZplvB3lFIIe/xhXvadmMDf6xBzEg/FkkNY6Nz1kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rl83Si2JzIaCeCRS0awc7jF4LoBYnfBNc4QA56AnD+w=;
 b=hw5uVD5PKFAwNgwH016Xhi+35Co1AxxQnRlFPBVeDLL3ADH/ncDM1RfAIvoyRRhCKidEbwpAxF3fuLyulP1Ccz0E+mQvek83o+j8KVF+Qxh8DRX/1F77A6DgfnSi2k+ByL4I8eciW9eH2FIiwvZbdRM2JbkKo1ZJG6nay7R+0Pn3LT/B+1xaXZcVk4OuTpnkjhw7W5+CXGMotqMQTh2kku/thDrmuFobqgrDKXq2YdRRTWQfbtGweP9FKEqLFrL/PJ/LiwoU7a3+402IOrgmAgLtYBXhUfnj6EeFosixHKYjoAFoR54gNeECIVkw6C4qKccf/ikWsCbQcT5XYKx5fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9257.eurprd04.prod.outlook.com (2603:10a6:10:373::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 08:58:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::4c71:cec1:22de:41b5%6]) with mapi id 15.20.5880.016; Fri, 9 Dec 2022
 08:58:02 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 2/2] mptcp: use local variable ssk in write_options
Date: Fri,  9 Dec 2022 16:57:43 +0800
Message-Id: <0802393e224df13d9ac71e5fe7524e40d262b8b5.1670575887.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1670575887.git.geliang.tang@suse.com>
References: <cover.1670575887.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9257:EE_
X-MS-Office365-Filtering-Correlation-Id: 2853f7db-c063-4cb9-2c1c-08dad9c37a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2OiOdiTWTJiLn/PhNNR2q/2NJmTsY4YcwS9yPXX/GTjO2NBl0RQDjWw1epmd64R71NruCqDiKhybnbz4PRGPCnQRPEzDue/Ny7WpH+I7WuFOVt5L9L8DoqPKtOpitFyeSiTmF5uF+2knON7D12cyuWpuw7VafNZ/gUi9BOmRzF87wNB6xCJsiyl31/AD7RSHrYdRdATDWepqjDxUy1eN4MlWNEgRQcM+utj6+pb4A9Ln14msfhUKp2GIyNPL3T0+Pw9fDu7ilXSMyKrVXBs8558AV2piKTMFxvP0bqWniK4DQn4+r+nDRK7Dc0UXV6fzOtRERpXLyTWmw2VIYYK3uVWaLFmpzGQuu9sLh0QC+vqNfC40CmH8RYB6tZbnzlsDfpcVpLLxcOb1VjgE0vKXF/EmySYqmLGCHN7WNqAnx8KRp12b/yaJaxjs7LrjLV7/5QjecLb1qomBkh+teK80lmd/0hvJs7B+Zwl+lzANKaCtUvPrdDVgWdgbiDgGV2SfV8ZAOtuGlvzie8HKT8CqSCnmY8D9u7nvl57Nj9ZfNlSQwsX79pv0by9ytZr09EZrJxPKTxiMCp93/6znO+KG0MVpwQ240nXwd989k0ipnZNZOnF2bf/JUyz0nuxF8Erk5lse00Rauzt3/sdGzyHQvQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199015)(83380400001)(6486002)(4744005)(44832011)(86362001)(8936002)(5660300002)(41300700001)(4326008)(2906002)(6666004)(186003)(478600001)(6506007)(6512007)(26005)(2616005)(38100700002)(6916009)(107886003)(8676002)(316002)(66556008)(66946007)(66476007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VkZpCUAwyIKvn0hQZWXAftQgTxHHpKnz2qs/iJJwSqjdOw5z8w8Nq4KrHMx5?=
 =?us-ascii?Q?4Db4hl6G3ionabNxX9xkb62yDXSpvGW4isY1nLuh8JsE2bCHXovFK3e/BGwF?=
 =?us-ascii?Q?Mh50ak54gN2z5lH1sRQSuVGrF4mT0eWIg66gJCck+50jLgJqIbnCzM/0bdRI?=
 =?us-ascii?Q?wKpUF/utY2/eTdnHM9v1wqDs1PmutpwMEYknICbWYPLm1KBgHi7NXcE7R+GM?=
 =?us-ascii?Q?M6biWwfWgtw/YL98WtUTsOXCdpIrmbRzI6Gg3XeDT8uXYMaTzMkbmJXQZk0U?=
 =?us-ascii?Q?7wyxyCUWup39c8G/HDhFFJSlj7vyUMvnOGqU/FbIvaf4b4geZTtMUg0PamYp?=
 =?us-ascii?Q?Vrkv1p+INdmpIt9sAIHk5HUM9j/SDlvzbStNckABDhRLZ+3xlWKtrXEiSBAk?=
 =?us-ascii?Q?QdWoih6zm7yGJT+USI0Fn2ZVkGQyCXdwUVFoSaJlhuVddkaMtA6UBlx+6QVY?=
 =?us-ascii?Q?mRJH22SYbNS9cwQvKeu6Lag0H7up8puxyPGmml0wEfs728QKOl74jk61/FYV?=
 =?us-ascii?Q?LHPxZ0OcMDK9paz9/VsFvMbz2AXJRs1sTvY5JutPr5u5z+Pcyg5ijtEyHp+l?=
 =?us-ascii?Q?dZ+IPizX5v+IF/9dW7cgUsRYiqouHivxdy3hje5O9Spd6lsbp/IP7IRzBieS?=
 =?us-ascii?Q?ub2ZscYJmsLd0yVw+sFI6am02cnSIqf6gx1GhHTBrW3y6XCyiusQNPczHcLs?=
 =?us-ascii?Q?hEMs6lvTjo2+kLFMa0z3m4MoWqP3O67CUKSpCyu84dTpi4Wdj5UW+cikhzrH?=
 =?us-ascii?Q?T7I153Wkr00rSB3PQCTUh8ew0SPcZkJ1xdAMoXCRYoehWVYoAHzdRGb9Nou2?=
 =?us-ascii?Q?1EQNaGiHXc/rWkejRq4+jgPlYiM3tAlRcucrUgPuCib1EVN4EVdaDkYFUo+y?=
 =?us-ascii?Q?wLkMhWad56xxcyoCHvIUs4bulLsDEaWFef4V6dxpPVQUUcgQ4yKMERm4JapA?=
 =?us-ascii?Q?Pil47+itlLikw6Hr37PtuFPVKfijfD0BtDRAAUfVgiRX5vLWgln3uBUPm16A?=
 =?us-ascii?Q?GD2z1dtX78fE/fJvU3br4adNzw4N4XuK/wJzehduMAAKEPhCHexzJzaYyET+?=
 =?us-ascii?Q?XqLPKwwuqr+5TfwWJN2MEe/3cL6i5nNqgSFMQF8+zBuFW/juMjwOnBEWxuRx?=
 =?us-ascii?Q?Y+Ig3Lbo0Fmq1eklUsETIJ6i5oxeXmf5f8X4IlwuDX/wkYKZF/USLWbOm9tI?=
 =?us-ascii?Q?FYsMl7oqIDQ9rKt++vNsm/lHMPeN8yJJKKTaefvntIudUD7mBKoEcpWd7E3j?=
 =?us-ascii?Q?7VvT+NSuaEmyMUP6Uc1EMrAmztrXxGsNw+rB9u6AMpRAgGPtuz3XD4CNAgs3?=
 =?us-ascii?Q?NVF3b4tEM0hvFqvaSJ827cbbhD3Vfv0NVmXkObcnTv4A22Sl6d373G19HNXX?=
 =?us-ascii?Q?YL+fMERwHawQcW4+kZzwi0HmFua4crulXJf2LzfPDQwbNJP0gBTb6sYhd9iB?=
 =?us-ascii?Q?FVSbfFeMyTw0Co3hng0cz4J31nv4jDbP5ksNHfv4ccx7Bf9uwComr8hzDlKO?=
 =?us-ascii?Q?Svu+qA0Byl7DZnGkkZFLSK41QlhCQ7cA8nsE9hQCVb8YVKqsgMOi9hy1nq60?=
 =?us-ascii?Q?tgov7iMJNAsX6O18WGuYJfWmgTFasUUYVhSVWHDu2RKDI88oc7NgGWuKzrrH?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2853f7db-c063-4cb9-2c1c-08dad9c37a5b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 08:58:02.2398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cL1WPUw1REARpJwyRnccy8uHxgEvUkMNiuM/0Xek+YCtmBE//b50MribF2XNhotNIbgJVdgfDDEu+xt7XKwIyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9257

The local variable 'ssk' has been defined at the beginning of the function
mptcp_write_options(), use it instead of getting 'ssk' again.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/options.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 5ded85e2c374..b30cea2fbf3f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1594,8 +1594,7 @@ void mptcp_write_options(struct tcphdr *th, __be32 *ptr, struct tcp_sock *tp,
 				      TCPOLEN_MPTCP_PRIO,
 				      opts->backup, TCPOPT_NOP);
 
-		MPTCP_INC_STATS(sock_net((const struct sock *)tp),
-				MPTCP_MIB_MPPRIOTX);
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPPRIOTX);
 	}
 
 mp_capable_done:
-- 
2.35.3

