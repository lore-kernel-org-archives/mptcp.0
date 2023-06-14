Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2075.outbound.protection.outlook.com [40.107.104.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C7A38E
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 02:23:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngYPlfzXofksvDs9WoteoD/nJpjXHpYStcbtm6+S0/ZCGbBSUU/N+goWCkSoEowE7ksmsCqIFdnkp9CDtfim98N8o3jmt6+8rrRvm3HCgp+jsDV+LF0MWbNVcJ+xxn3vkDIH+u+1bxo1qNOrZ+S/ij6Duez1Y5mOiCF0KA22OCPgxs/qPYxo0gqZNk/sKb5ccYJ1ELS3ZPwlnWTcE3/zPPvm5wgDzYzm256ljq8HwbYxgO/t/FFonrONZbYFp25aFno3VdIfugdaIcYcwKVubUEMA8L8YiuM8Ow6BFMrL7xPveWnUSuU1yERkBR0Qbq+4YBh/Bbj4KdoOG85M7UvfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgduBDQ9X8wBDsQyjCmIpOT/P1tK5AQNgLwXikIirmE=;
 b=SXvcOg0US68eY8F4nzBLjYVwOFCdDqLhc8OCgm0lDlHJYq0ZQ3XPESeJSZbh9xf8jX2RvQiWY9ArKi8OxEX/GDjK0Oj4O9HvXfMxg0rJD6H7rHcqOA2sADgPWa9FHHJ0HXnWzlLTQAYPPdnB7KwDDwxeHzLFIP6vjHYhDxzbLw4NjoGOmQnifUa++qkSjSxDF5mLD4n7RoguCRgxek3Tw7mClHTHxoxGBSnJvsZoaE/kqowd8tMSRm/vUZywE31TJuoFN9yP+Xrpnrux+K3nXnH1wwWYTaUJm2dXj3N6NpbnUbHXv6zDoEYvfkfBREv2BhLmPa8BUsKTB81cV8s51A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgduBDQ9X8wBDsQyjCmIpOT/P1tK5AQNgLwXikIirmE=;
 b=K3SrvX/xw1RhJ0xgDyNjndnq0kb1qR812r2toApd0R1Zqvo85AJykCcuIq3qHvJoT9d/XBMRNVQo/Xv8gg/ZUe1fRxiIN0o/BM+TBmrhNJj0DN7X3YTwuCNI0t9CaTDcVYb5UMMZ3TeSPh4QBTqVeAYf0fjsHN/AQMgy/76GqH8kMpOR1L2TIP94ALDQVJEjK0Ba736gtbAeqGR0adycy8L76H/0lPW38LltSkccO/KQywpRWH+sP+1+3sWWQ2em7Hexjgsa4cpn17Cuu/YxghDw22CvFYRoF4ZLbJSF79Nsx1w/cxcvymN9oLwKCbz0GNaUaZ3Bu/eJMoz+fRZMhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7956.eurprd04.prod.outlook.com (2603:10a6:20b:241::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 02:23:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 02:23:39 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 13/23] Squash to "selftests/bpf: Add bpf_bkup scheduler"
Date: Wed, 14 Jun 2023 10:21:00 +0800
Message-Id: <d922ced3c914bda2da152e6f8b783eadc8cbdeae.1686709116.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686709116.git.geliang.tang@suse.com>
References: <cover.1686709116.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0245.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: c4c5fb66-0210-45a8-50da-08db6c7e5d3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vlrpaBB6NypBBtkhsr8iSr1AzxYJrvrmqOathgoIwyS45KWLVHUme1Qi7NfSYNWN5iuffb4juqz5E21D+VM0GrAG/TWfvLmnjTTTVHz3WhAlZk+jhnHWDCvRHkZVF/3/2VY4+U7sRH5w7fZrDaG2pHDfFHeVQHORBMYd9FuM6/+lG3ugrvoSrMgPX4I0TXlXIGxYneM1nT4CxGiFONLm6qR7GONsBxo3lp4wLL6uadvHiu0Qoq8Zj21+FrWeidnm/wpNryNaqj7zlrX4VA3M1OxEt7g8wJr9cOSMk1xGnV4xr5a91yxKv3Q2DdNchS0UMEe/9mxLg8D0nsRkknMrFwRILjwnnGFjF67jN8gwE+947y3oeOgrsKx9OJd+NPn3x6fbIL3pQbAyBJk3aLlqwf0AQJZNM+7Um9jkpdjPzvy7OLn5yf+uqAaFk2rIQwOcRJg5Mz77xsAMfpW0G6Mz0Ak8vbuqr1XSSbpGiJKNdpe8oz+dYJ3vKrKxpR2Wz4T6fsd4B5Js6zr8/R8Bu/o1tg8BlKvzECcZiEp233G8PKUz2SepEanRnAtAPC7uH//p
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199021)(6916009)(66946007)(4326008)(66556008)(36756003)(186003)(478600001)(2616005)(2906002)(66476007)(8676002)(6666004)(316002)(41300700001)(107886003)(86362001)(6486002)(6506007)(8936002)(44832011)(83380400001)(26005)(5660300002)(38100700002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2LtSd7GZ98F5zF4+3Hh8ZmYSJGQjCeycDpA280TUjZgBKfkl9tFsYy2jI1By?=
 =?us-ascii?Q?8bgshYqjpOu+fB0JwJ7sxt2tPK12lj1owx5D3AK4N/7dWdri7CwTxHKkvb5E?=
 =?us-ascii?Q?BNSe+YdEVmQjyeb1LTD52NL8TlpS/d79i/F02zWM9ZzFV6uMLFYMVvD8an1w?=
 =?us-ascii?Q?PZCz0NQpCkg4pt78CKWNjzCctdhJuzbogbOG5UHPnODhIDCjcEATV2vWyXaa?=
 =?us-ascii?Q?9VY7i7Hn0t4Oo284LdTp61qzCXLnSVLdsSceV1T9FmZUIzbiZFFnWZjjYN5W?=
 =?us-ascii?Q?F5jD/t0FQiWKXhR/uvB37VAsv95L64liIp2m6l+MqJrzY1+dk2Lq+9flT5fm?=
 =?us-ascii?Q?+Y5DkGr+tEmkitcZWmPEDo9tnrq2xN9sEQOopbtvLG1dnAcXkhmHfhtxQmxm?=
 =?us-ascii?Q?eN22ACu9hHQzhkEflWUvXFUYKBA29eg+1Nz78IHUfBKyHZX1CgCr6a/jPVm0?=
 =?us-ascii?Q?Xrs4p/lgAXGpR891QBhIvlONV77/JBg/DJ3ewzG6JoHyeWrHMiS+wefLwXu2?=
 =?us-ascii?Q?NXAFG3P/7R7eRSIGcBFN1jOgk9wB8M2ywcwSq/Sc9uvFLT/gL68FNNxdBFRy?=
 =?us-ascii?Q?dcPG3xTf+wI2KS/DxZR72XRWr8X23fghviG4N3jA6TW1ENPhuGp6sKWaiyS8?=
 =?us-ascii?Q?p+Du2nnk+efO6s6LjjSGt7Hl5/8lTALeKu8OTDToug4Ypk/rxPtfySG82Ks1?=
 =?us-ascii?Q?Wodw3VaAHL9TMl4UlRFETaPMvZSr5buvDtniZ5g5wM9zT2inV/e1xj5Jd+o+?=
 =?us-ascii?Q?9BXK209rAhLXiMkuWw5z4y219ADCeySQcCHHFa4MkmbcuxEDxPf4W6nnnW2Q?=
 =?us-ascii?Q?8i034oLYKFQMQU88e07stbzttFIN97Hw0P6+CJvW+VGjJVeYy1JmJ4+WGDcs?=
 =?us-ascii?Q?4Nnr3UpN9xjXKDZdB9Sx61HAKkcvUsEx3pB6Ro4XWs7p7vb0Pl/Gvp1uzodG?=
 =?us-ascii?Q?zNoYixZYs9pzTPEfZEu34n4eh3KxpCpM2RPZTs6RzbCM4jQeuXPTwY9w89em?=
 =?us-ascii?Q?jh56hh9Q7tCZf7ykMNzG5mSoLUnGLj15KstzSU7DKh2wV02edouW4otxhpAQ?=
 =?us-ascii?Q?bwF4odZPzgYEQeNOkqLbAJJwqzBhUvM3pC2y6CswAbGsCqCdA5xVSaLEFglk?=
 =?us-ascii?Q?2iwcemb3nrgcxQwiXmVUoe7dbaAkBo571NhlDzrjMBNggndHBY39F8xU+fGY?=
 =?us-ascii?Q?5QLc6wJ6a3094nr4+mmLlUPTtR8dQCGH7XlYhDdpKNA3Dk+u3kniPWK7jrjF?=
 =?us-ascii?Q?MGzAo9Uhs88IScCJ9tkR3sVniDcocKBwGSWyPRfvOqqzRlMDvAszZ3PDpYgj?=
 =?us-ascii?Q?CfCgoH/L+zOUIZRsWkNKX4DM3NkPXKq1dTan+X0Vd69s1U84sOZEWP1gCliM?=
 =?us-ascii?Q?f+0vBBixH9oOeydg6TxLEuOXOqp//NRojXyH1Lr3A/eVp6gnR0cTjjuD3Z+G?=
 =?us-ascii?Q?LG00lGiHqUDo779hOe1UO572aJNsN71s4COYymA1BW5WUu3T9mMFzkIHne/A?=
 =?us-ascii?Q?+ME10T+qB/QoqNo1E+V98qbL5jVZOKQu5jvQwTX6C794ClyQy9CfO4px7Ah4?=
 =?us-ascii?Q?esr+rZzJcB35AfuzIiroXr7XTxnhBhdZ8mPOntHD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c5fb66-0210-45a8-50da-08db6c7e5d3f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 02:23:39.0572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzQXIR+CWQYVJ4LB6ow+LuljmHPbgvi7Dt0Six6wJaV355UVr47R+a6OIqXCMiE1etmgnPc/zl1VKas/hv2KJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7956

Update API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
index b2724426676e..a8c53f93bf9f 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_bkup.c
@@ -27,17 +27,20 @@ int BPF_STRUCT_OPS(bpf_bkup_get_subflow, const struct mptcp_sock *msk,
 {
 	int nr = 0;
 
-	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
-		if (!data->contexts[i])
+	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
+		struct mptcp_subflow_context *subflow;
+
+		subflow = mptcp_subflow_ctx_by_pos(msk, i);
+		if (!subflow)
 			break;
 
-		if (!BPF_CORE_READ_BITFIELD_PROBED(data->contexts[i], backup)) {
+		if (!BPF_CORE_READ_BITFIELD_PROBED(subflow, backup)) {
 			nr = i;
 			break;
 		}
 	}
 
-	mptcp_subflow_set_scheduled(data->contexts[nr], true);
+	mptcp_subflow_set_scheduled(mptcp_subflow_ctx_by_pos(msk, nr), true);
 	return 0;
 }
 
-- 
2.35.3

