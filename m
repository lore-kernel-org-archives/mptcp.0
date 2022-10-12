Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60054.outbound.protection.outlook.com [40.107.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5484917CA
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 04:51:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTnNs14kLzOcPyRI1Bwlt2bZgjrauHq/60FQIG2KabqqCuyZJujQU2/+HJXEyNSnXTjvbYXvnP4fMdwxOnRqo/1OKv/o1scS0jo1IuFGVwtd3nczq6q07dXCXR93EIAuk7fcZwN1l8N6MWtSmBn57TQ0fAIjWQfenOnQ3ZadK3PeNwyem32eYepsEzsrxBqVUP8HowIzGpSp1b9nzZs7Fa8p+PX5ZXska6InVGOjiprExUAHxe1AQmblI8dhyPSWftjVsf3AFcikhizPcHkjOL53Hu4hIjGhNQAqalMBelwWU38NRwQnopQ2U5tD8aqWrsvDPbrMzUzbzJIjt4CFIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfswZEZVHBOGeFTqc5psgb42BV1tvAq7wKQOwzt7mJM=;
 b=hG+5eD9kGIeYi2RPCpAP5fXDPLgZBDK/6POstiKdfE1naBn0LXD0cdkOK9QDS7wntamRa06ng7iJQdpoPdPoXOLmIjVfAHy+uM8BpW30hpTv5cYKIeOCRiS4C2LYe5WZzluiX0+mjkKJI/39BskqHxq78Ye+8X8UYJexzdYlsxD9Nu7a4WnpUQB2CpMrQ/I+gAcBnJ3jmbvXGN7dMaeSRt8MF9yjG0UJHBtfFnomLGVtvkt8oRhMJUXE2+k3bd1Rc7/Irrc37d66Cmmo1+KAEfVg3PPDcMROZ/OX6ydCMYv8wk4J4SFNVnhuK52Jh0O5CqZbcyJm7/W9ASkwwEmrqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfswZEZVHBOGeFTqc5psgb42BV1tvAq7wKQOwzt7mJM=;
 b=Oaw6rJLUlxwAoTSB4MOnJder3xCvg/Q4M/TUZRJQvDpj/AVtx/IwmQ+ukqkoBcDloCnl2evt6l5v6TDxqKqZl8zJOEV6h7ggUW+uup6yNG+shl39Wka5b39qWsswpmF0LrinD8bAX1MfLohfpLvxP797teTKo9lmgF0rj92CsvIzXeHJ2vBjP9cqDBuHyUaGLp1zte8ut6lR1EkhzxbpoUs+/GXXPY1V3s9SUUyWEQT7cnpj/qF5mCU0YhetttTvI6BvGIHepRf4tUptnaeIV/1uSCSHZqZLvUccnt4lZuw29OvhE4Gd8c7rWZTLH5a4kdlNO6R4NgGRpU3RwS1z/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7722.eurprd04.prod.outlook.com (2603:10a6:10:207::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 04:51:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 04:51:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 09/16] mptcp: define default scheduler
Date: Wed, 12 Oct 2022 12:50:30 +0800
Message-Id: <03837d5c7c1878502cda32e0261066b4026c8e13.1665549881.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665549881.git.geliang.tang@suse.com>
References: <cover.1665549881.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: 182fe542-a52a-4450-6081-08daac0d74ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SwwtK8I1eIw7SirdZG2xTG9LcqfGmaOyg6qJih+g+ZlUHPhJTiRSx7WinnbdplL1bznuwm1bb1sSniVqOCTS6DggFZz/1HNMb9iSpWqc9qgPXLynioeAsNhBntczR1QkEOFtgRCO6muL36JBnlRbxmk2Fmei2RUUIutsESwXrlkeqq262vRMHpVjwqPlPSY4wHMYQidpIJlecj958RjEDA/ayy8N5o6xPo1A7C43rYjjVRBSHQ2K0ZEwkvjqK9ExHEQL75wXZWpTsxvBdCuOfpg9Yob0B7hto123SjI1qS4JxoYIbWR8Cd/nMS+Aaa1fkbnzBcZzR/9QlIZ8KA8PBm1gJGBDz88uf7DhAAjIE0K1fK3KAcunK3G0moXkSPYCH0A2nSOIVNacV/0BIBFRF8oxCIfV89MmdwhdCA863oKr1CcyEogO3k/ru1NupPijT5suS3XI0b9+iPJ/4eGBAKHMizI6L8jxYb6/6hEJrNzbKkJsemeTYfSisu5QNhof5JfZshHlgUyB3ZyscHgvRwgVleaKbsbKHvsaONVO9nTyzHGWZtR3NTKGNiqwVc+B+U/YB0QR0iI7mWFoEJfAHOoVrnN77tsuVcwMVQ8WkRyDCcuRWf3SkxAiSTtbZ7W4P8biHVhwEA1+zx5eUnlFGDuv0DwFJFIrXyCe2x0XNDM7djlghvNwuwyu3E9M9WAaK06kNAvwSMChHQWAzaidNWcQCTtSuKfWSWtnboL38aLfTpk6So8cfYa5Nf+p2iZH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199015)(6486002)(478600001)(38100700002)(316002)(6916009)(186003)(66556008)(66946007)(66476007)(8676002)(6666004)(107886003)(4326008)(44832011)(5660300002)(26005)(41300700001)(36756003)(8936002)(6506007)(83380400001)(2616005)(2906002)(86362001)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8kOI+7W+/cgKZfR7cQfPrCwx4sbweoRP0HFnv4AAj4CmBwebJYYTkTZp5FtS?=
 =?us-ascii?Q?7IEe4yl7fM5HU2uxpt0GHD8UgrqlOWwiI/Y6zDBPvOyKF86R17L3InFKOQbj?=
 =?us-ascii?Q?cRzQTCE5BBhEMlMwu0X+NGljVBgW92pifhfqEL3p2K2Z6pKGHH9MkofWcrKE?=
 =?us-ascii?Q?XOhV/uWlCaTdFHcgpQxbJMpXVouujXMmsMqnNcCHKhR+0Awt9WzcVf4fPBgx?=
 =?us-ascii?Q?7oi6UVyAlCv4WCg0yEoTAiHEquPEiRCusJ5JWyQ/zUICu3YYSQlQqpatrikx?=
 =?us-ascii?Q?zBvHrrATd7GN+RUFci4+WJ9I2hJfilMVWyld3U9Pxe3tRV6ndMlm44C3vvi+?=
 =?us-ascii?Q?WdwhzRZr5pgGyXSpgbwfmqc7ExASDOiU8z0ftLFRG2mJlmbx/LYrsCByvnRT?=
 =?us-ascii?Q?fkJ/cRvVfA3QZG9kL1LmmG8IVuA4QzA4wLBwtfP6C8gj44Kbsk2Q9T/l0uq8?=
 =?us-ascii?Q?8dAJKXg08ZXsTtTevnTJKHDvXBkvziXz1kUWVgn9fk4DeEhCwH3FEDFRo9kT?=
 =?us-ascii?Q?OlhENDXuOVcmmPJRZYw6ahUFitlUgD4kl8S4EWpnBbDgyHDBquDyB2NEbxas?=
 =?us-ascii?Q?U4UGAtngPu43yQLndaIpWdMm4UpwK6xn1Sv+qObP9fOnI5dVaoP+Laxr5ASK?=
 =?us-ascii?Q?kl+jQDR9C/yUgYlMsgumXwjtTbem8jd9PILOw2pYI7DvqUx+ZSurua8lhy6g?=
 =?us-ascii?Q?mpVIjGvJC0zgywbZ25Q6UXk/CpYa6I6pFyIKgMcJmf4stiKgov3JVtVwXnIP?=
 =?us-ascii?Q?Q0lmEqq7r8ZLE+mlweKGBi9yQrKr+74p5AVpZUmtKXXB1TzrGVkggfVcxn8K?=
 =?us-ascii?Q?Nk4NOIqGJgciTSLx3SfFvD4V62JtLo77tAKS4+GkuJfX80Ek0srSFlzCDljr?=
 =?us-ascii?Q?MFGQobUrqG8pvcc/uKtAZZsFtg9jpwa+6DELDUwnAWBSBD0MWnGiXgc8Zg9T?=
 =?us-ascii?Q?A/oJQwqpiedqyWrY/YSYYq+ahtc4EtdOdSvxaoxGAus1FtNX6FpulOtfyo2Y?=
 =?us-ascii?Q?7O4MG6jpaY0eorSQ1G4C5yMr9p+M+nFoaX7dUEfBocwCAkthOmrcRx70B2ko?=
 =?us-ascii?Q?AJThC2N8BWcXsihk+BfqR+XGbOxEIETq8C7Zd2NlrMq66Eqjzq05cv16ILHD?=
 =?us-ascii?Q?GLAZwj4csAa5CfodZck0LRRfTp0M/O8dNuZPfGwyyJxY2Lec+XPGzJ89igzM?=
 =?us-ascii?Q?Fq7YhHbj6xjsc/wx1X2PN1beEWgSb55HhubtQNUmwHX0/obgUTVeWZOFghkQ?=
 =?us-ascii?Q?c83vjJKPWTCJJicLrj1UMxFEcpXnA8D0ZZUaol8NS7tz95/R8inCuYHuyenX?=
 =?us-ascii?Q?RUhf7NwZBIEbkCDQr6SzxgXYPEv5ok8z4bM0Mlkquodjd0KsugEcPf+OWTfA?=
 =?us-ascii?Q?cP6gNPpE/HANftPxor31Em/4xBD4NALgOYel25+hIPWF+kdcPYjQK4Dqth1E?=
 =?us-ascii?Q?UoK0n95WfwMAembdVZYjqXjgjPizsJiCjm50mIrK5diUzrzvIEhLIABV07ks?=
 =?us-ascii?Q?kxnEUGc5VvYhMbL7/hQAGsWpICz0Qq6UqwSjZZCxV2ex1q8KsBS5c6cfU2B0?=
 =?us-ascii?Q?xyUs3/VML05FWqFLyeupXs/bAzhB9Anv9C0hB6wM4647dp+zBpMFYnnG1FSK?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 182fe542-a52a-4450-6081-08daac0d74ae
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 04:51:42.1452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eX7ba0XUte5fz4NfBssI+w0Sp+j8hnG3GbV8e74CHN1Vy5oOeN9LOyh+QDPnZtTRTLZasaUj/4P0zAn03fhIeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7722

This patch defines the default packet scheduler mptcp_sched_default.
Skip deleting this default scheduler in mptcp_unregister_scheduler().

Use data->snd_burst instead of msk->snd_burst.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  2 +-
 net/mptcp/protocol.h |  2 +-
 net/mptcp/sched.c    | 30 ++++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 956c8ea0edcf..3f0829ea2ad9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2211,7 +2211,7 @@ static void mptcp_timeout_timer(struct timer_list *t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
 {
 	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3f97bacca67d..d3cc84b15929 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -639,7 +639,7 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
 				    struct mptcp_sched_data *data);
-struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk,
 			 struct mptcp_sched_data *data);
 int mptcp_sched_get_retrans(struct mptcp_sock *msk,
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index f9440b935c76..14b3efb347bd 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -16,6 +16,33 @@
 static DEFINE_SPINLOCK(mptcp_sched_list_lock);
 static LIST_HEAD(mptcp_sched_list);
 
+static void mptcp_sched_default_data_init(const struct mptcp_sock *msk,
+					  struct mptcp_sched_data *data)
+{
+	data->snd_burst = 0;
+}
+
+static int mptcp_sched_default_get_subflow(const struct mptcp_sock *msk,
+					   struct mptcp_sched_data *data)
+{
+	struct sock *ssk;
+
+	ssk = data->reinject ? mptcp_subflow_get_retrans(msk) :
+			       mptcp_subflow_get_send(msk, data);
+	if (!ssk)
+		return -EINVAL;
+
+	mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+	return 0;
+}
+
+static struct mptcp_sched_ops mptcp_sched_default = {
+	.data_init	= mptcp_sched_default_data_init,
+	.get_subflow    = mptcp_sched_default_get_subflow,
+	.name           = "default",
+	.owner          = THIS_MODULE,
+};
+
 /* Must be called with rcu read lock held */
 struct mptcp_sched_ops *mptcp_sched_find(const char *name)
 {
@@ -50,6 +77,9 @@ int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
 
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched)
 {
+	if (sched == &mptcp_sched_default)
+		return;
+
 	spin_lock(&mptcp_sched_list_lock);
 	list_del_rcu(&sched->list);
 	spin_unlock(&mptcp_sched_list_lock);
-- 
2.35.3

