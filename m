Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2046.outbound.protection.outlook.com [40.107.105.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD6A20F8
	for <mptcp@lists.linux.dev>; Fri, 14 Oct 2022 13:33:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsAFQnAJmaBgfR6Pff9fs9Hx5y6hdGuehIBp5ZIQ9vUKJMyFIbpnYIfT6qlvGNQx/TyLvyTOdqllW/Zc7fHRuiugtBVi+g2/++liM66/2+HXtHkZdkvwIzd2Hzp3VOeT9CIhuA9UGJvH68oPCZbxwdZFmbowRvn3k21+Bg814Y2zdzIZNQ4PNv/lTWpvdfLmxV9DzxMZoumWd5MFqhJ38SI5j7jJUaHpUr+hYebAfVjrb0CA/HkLcQP/goWnEygyIqfXVKQjiNpQGOUnr7QlzXb6c3FdZHnNtBLq53p9GHaFIFo57TGvbUVqHxuq7dkY15oCKhXU8kuadIG1BiJDtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIU9CvpQ0IlgjgDAxG9XKwx2SdUSsUTPbSQH/VeLUe0=;
 b=HedWAnxEcr7sWp4WdeQ327VFsMnmefRBwx+tuCWUn1d+GpG1BHa5ahUp91vCLUQ9A0ap5BAS7JAZt1/fMGXc04r3dWpjAuJPXnHqoi5ZvLhJDzrV6LhPY3WW3neQ7sURon67V/1SEqmFQCLifEwE0LEbP230WsopLs3/vzLDNnhHQldBxq0Z4xflU2yxrj9sWp33UZABsTLiNOFc7l055STHHCTk4Ou32DM8akonHT6bSb7blbifTQQNnKYJX5WkyB2TBO4ui9r/oDOfLldn8jvzZcGylZ3CdyRTcOktdMfos1GA15plY0dnyaJMz15S4kolexEVk+XV/v+EXzZ3Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIU9CvpQ0IlgjgDAxG9XKwx2SdUSsUTPbSQH/VeLUe0=;
 b=y0wRMU0Fk3G/niBRLOgpw/C4FmP4Gqdv2g2HqbBpR1oqPm8eNUO9l4/P0g1qZYbHqB/UkUDO6crR+ApjCoEu9vqSOBe8ljdIxDqIVam7/IjzlJHub5KTNRRHixh8ufwDNDG2E3YxE0FDVW+gXyZXypwTT+95TEJzOBT7txBqxfUizdLETuVJbhfSeLVS2AsH1fxsmx6CmlNnOywXRLsZf3Gvz1f0VtqOU6a48hP27vKhBauzZwHDjtGuaI18ezQeHmuwLTwyOXMQ7wT+1y9F08eOMoG9DzokDbhdyUZ87aaLtajCMsYTnynqdzW+yF6R+Eue1Xdz5ktGBrQysQVYNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB6975.eurprd04.prod.outlook.com (2603:10a6:803:138::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Fri, 14 Oct
 2022 13:33:01 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.029; Fri, 14 Oct 2022
 13:33:01 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 02/15] Squash to "mptcp: add struct mptcp_sched_ops"
Date: Fri, 14 Oct 2022 21:32:09 +0800
Message-Id: <f13602e09c6e0854f43ba68cf926dc03b6036f4a.1665753926.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665753926.git.geliang.tang@suse.com>
References: <cover.1665753926.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0001.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 68aa15b4-1ef6-4561-096b-08daade89d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	txtrpSZJsMAwbuc/XUU6nU0nWnxYhHk+TLVmT+mQMVZYpOXA28gG+rsQ7r519vlncS/yD/j8/ZJJcw2q9Cxcxnyd54/sMgvDhcdZdfpVUGzG0aKm+FgvFkJdo8DjlBCyklD/lj+l2nksJEKiv2riLuRqvk7AUcgzV/rA1WR0/BpPwptliocI2PGL92NmuwzZyhY7huGlY7m/3QVyRXIzZCkeYXm6qy7m3/WnCBkzM/NMMnKuAyZfoi4ijbmre1vuCm0xqBYdTFvjJTELqcZsAq8fdAU+Zj91xbF9NgfFPfJVJAzcn5CuG7i2eLaCyBcu1OGEPm6Yr1/Q1CY5Adw5AqGsjvVPxnV9qRGhXlR+GpFcPSA9m8an9Tgn5kSMD7miSFsp/gfhqZ1Hyre8RPftTevbrrz1g8LvBtV/iSe2GQiq8Y4htal1KBOHgVEBDUGr8Rl5xmfbF1Ls2mPhAn80XkkHqA1UmiHNYVgn/9YFM6071s605rleBz+t/C3lNhm2zM9C6eLeI/svxlcyiaeJa8TDrbhDier49qdaqtB9qUxoBHjl8KtQ5zQ7gZllMjUTzePttP6jXoMioEylX5i6p3kDXc3pT/HF17rfTsYh+goAHx06mgfx2nvCQ3MTEt9EhsAEGUBpToNAMIbdZX9Z8uJSVvL38RdLunK5gPatlSFTnmW5anFLykslk/UchbblUUHuWZNDKvSeXND1GRVvzGsPQWPq/791jyswpt+0wndj+Ib842vNBvrSM4LMzfXV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(8676002)(38100700002)(6916009)(316002)(478600001)(36756003)(6486002)(86362001)(83380400001)(44832011)(2906002)(66476007)(66556008)(4326008)(5660300002)(41300700001)(2616005)(6506007)(6512007)(66946007)(26005)(107886003)(8936002)(186003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UsJrrcAWKJLdzel9al1vemTl10iJ5Vmzzx2FuyQqpHHI/hahPwJmN34Qac8z?=
 =?us-ascii?Q?hjpu7GUBcKuYMygmBu/32COJEQn0tyivxbWzDFvtaDAnM+u9dms9mbKS2cxv?=
 =?us-ascii?Q?Lh/O8dRiU0XOT8lhwazt0+zWlARi0u7biS/BJGoudT2lU40Bxbtf/+kGKJlH?=
 =?us-ascii?Q?g1Nh+Q/rc5ggUQmNjh9OnVSqtGtWF+KFfnW//5S3/ylECPQ+aHWU1rQuZv2c?=
 =?us-ascii?Q?Twro53WkFV7b8SZSunyuyxgQzDENRRfBUz4RUWM3FbE72dvghLG0ybJwnemn?=
 =?us-ascii?Q?8ShBrcVtSlvMOrwMTyVX388ehOgGwdJ3lvV2Z0F74JCSVTwdK85eF7249Ecw?=
 =?us-ascii?Q?YguUBJoY0GaXAhLy/2cUTEHe6lNaUn1R4LxDl+wNdVmQbfkpaCWA7iDvAdo6?=
 =?us-ascii?Q?pcyyhKajFvFaI4DzQqaApWc3gv9zl3uDvZgLZzbr7wq+MmHYBPTU9k5e011k?=
 =?us-ascii?Q?HfgGhr2hc1zC3fyGZUdRODz+1JLvVK9HSSQkBOsWWzV5i1fdtDR0BcbYOTYZ?=
 =?us-ascii?Q?jscsuXDR64YT4vl0DX4c1CV+ykXmez6OJG7i63T70h5K0CWssrrMjr8VWPm/?=
 =?us-ascii?Q?15Tfpn3E7rBYodzhWZRJgSql+jA4YbCKfvo8kguI8f6qcxOph2ZO7tUqXLHm?=
 =?us-ascii?Q?Z17kqhMFA+WmmHPRmHLpKFPWBQvHGg4QfcXCfjmgLSm2YZNp7BUJluSqC0kS?=
 =?us-ascii?Q?IWHeNehoTF1gnWnOuSHXGIrnQYz8NNjxBH/d5MQMk7qVzO80z0O6Qx2AbJF1?=
 =?us-ascii?Q?dhzK/H0RX7Y00ZstjSblSgX3/60JBfLWx6G+W4xcvp1pmuNZuovkTbntEX3a?=
 =?us-ascii?Q?Ju+0V5srfAl+01SG0jsjA5sReBX/teeBjVqSCvbbpi1J3gt4dRmWug68N3iE?=
 =?us-ascii?Q?QINz5q0nRZbibT1oDth2VguIIrXmwSBJuBuya9CEJMneATCOUPMQND4/8/Qg?=
 =?us-ascii?Q?BFUNWrZctrsCrItiL6DgeKAxaGI+SODeJJa3Y7A1sxy2iXUxreImKsYDtm0b?=
 =?us-ascii?Q?VP/Rg4k0L3+WLMlEVsLZt8WLjjEfNy1lnsqyOU+UPPxg1JfXuybi1Nra4NFH?=
 =?us-ascii?Q?PMZc8GjZhTuEu99XNPBfvltIuU0DlsvPF3+9z5GgPzqlQeTbx57dn0WyeO3R?=
 =?us-ascii?Q?0bp/5ul0Lp0UWOzitcelmiZica6EBtLU6ipqMJsEPd2wM21SuYaqp9HytAkm?=
 =?us-ascii?Q?l5oInvyspdnI3eNiW1aYXoy2Wtje0hQq+mhNcNn/6arpz1mLtgF3Bp0mtP7O?=
 =?us-ascii?Q?7ArbYAy/bXwd4u6+ajwXJHAMJSSeQlZIyGaR7916yqBdc8FCiWKjBVrcWcDo?=
 =?us-ascii?Q?FqUeRh/oNZau8jUukA8dI7327AyPoUj/HvWaALTc1q+Ettj08td3+i+YjxCZ?=
 =?us-ascii?Q?TCKaK4YLX9D3u05aTJsbeSI+xiRzu0y3WSsgVhrl1FJazDUVfe22E6QGF3eV?=
 =?us-ascii?Q?p1LO0kFG0leAX3etihQv4ZS/TVb5C74rXZ97bVHNehYR6drRYmJsnS5qSb18?=
 =?us-ascii?Q?zOFPEYkRP7dwbmbLnfaLKp4GCVIHyBtpy4gr+7HcECYiBmvU+8qgVEe+uOID?=
 =?us-ascii?Q?XkjobAEpDdDOyX3AiSD+GmD0I1kePR2/s3z2aTW6dmC4vntl0GAW/4D0FWhY?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68aa15b4-1ef6-4561-096b-08daade89d67
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 13:33:01.2233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VppzpUKQLEQQKRJuImhriDmjvuc3hXrGGQ1htZxclNleqxyDVsftptVizM3g09w6smvzdp5qo1egtUPNXHZdkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6975

New api:
 - add new data_init
 - add snd_burst in mptcp_sched_data
 - add an int return value for get_subflow

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h | 7 +++++--
 net/mptcp/sched.c   | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index c25939b2af68..cac5b0d512fd 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -101,12 +101,15 @@ struct mptcp_out_options {
 
 struct mptcp_sched_data {
 	bool	reinject;
+	int	snd_burst;
 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
 
 struct mptcp_sched_ops {
-	void (*get_subflow)(const struct mptcp_sock *msk,
-			    struct mptcp_sched_data *data);
+	void (*data_init)(const struct mptcp_sock *msk,
+			  struct mptcp_sched_data *data);
+	int (*get_subflow)(const struct mptcp_sock *msk,
+			   struct mptcp_sched_data *data);
 
 	char			name[MPTCP_SCHED_NAME_MAX];
 	struct module		*owner;
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index d295b92a5789..949663742f14 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -33,7 +33,7 @@ struct mptcp_sched_ops *mptcp_sched_find(const char *name)
 
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
 {
-	if (!sched->get_subflow)
+	if (!sched->data_init || !sched->get_subflow)
 		return -EINVAL;
 
 	spin_lock(&mptcp_sched_list_lock);
-- 
2.35.3

