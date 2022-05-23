Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C137C
	for <mptcp@lists.linux.dev>; Mon, 23 May 2022 11:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653305623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3yDp+38AYaVgpufJ4A/XAHBGxX9NgfsMdAb7o/7Y5xA=;
	b=NCyUN7vST0ZY38YeRRztYLmOmCzC1tV+UzeMYNzdyBV3QPycXsOOwuH27GQnvs3DndBxXe
	t044a8CvtftXnCoVlel8CFCE6gTnP94JezemOzF5U9lCI/IoqzQpTqEspOks3BGwuR4JK1
	4l01khc28x7G16gb5P5ZmEZaSzRzJGE=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2059.outbound.protection.outlook.com [104.47.5.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-UvSa0IrBP7WuCDMEZNYYZA-1; Mon, 23 May 2022 13:33:43 +0200
X-MC-Unique: UvSa0IrBP7WuCDMEZNYYZA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTlj96a/Ryev6dCyPo4jEy6gbwTzWXqA5il8R4IQTmJEkQbaTvo8hGrVaZbzOURWMjdfp2PrvRcq24NJmOf1JtBxG2hnCBOA+mi9YRtt/PnpyZheWGCkkWyVqykmvQZ9mDvhfWltVMVygyWxdOdPi55BBINAiIs5rNrsMSbRfDo6psymm0Rwp+tYDanwV+rupf180/H8Xg0Sxh+IhRw2R47SrhrA30SvlWu+rbhfsMJiYvq6RB/t0DJGJGo7P1AFtzbzZUTqB4tLkNVbOyZAIEagIFZBJ1DF4a32fbKW5PZxlxJ3x5ua/uGVnU/jI1w8Kfys9P6JFd2LBT1GTPMnQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8S0flcEMHDLxDnsvsYWyw20lwGo2q47JxK1JL4+2Ps=;
 b=eqYpLxSHx8kcDCp5b3zSPNSkl/mabOQq6z0z610M2HLheYuX0lx9tswthzldDuTIUrwuEjPMwWcJTEsXZYOe3+/JL5lGXwq+pwa88gSoRazrws+CUBxZPR5CDoa6wNcdM2DJkii1LRJONDZSt4XMQ1fwA+bYhNmCECDop+6g/R9+v7u7lqNXqkrH1ACi4+IrZBrxoT+j2gOrS4knYv8OjgWT4l36JamffXSMBDzwxhFuuy3MVhcBV6ZmDxOxRchVr9+/qbj4ehTh55HbnNAJX3ykaScWG+Kwt/TPwl1F5uLIqTV5EZwOXPyouFpYLlZIPQLcMcSCkDHnw0Xt0rhAqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB3PR0402MB3899.eurprd04.prod.outlook.com (2603:10a6:8:f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Mon, 23 May
 2022 11:33:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 11:33:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 1/5] Squash to "mptcp: add struct mptcp_sched_ops"
Date: Mon, 23 May 2022 19:33:35 +0800
Message-ID: <be64d685eaa8c59bb2c19b87ccc37d81996d2a3a.1653305364.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653305364.git.geliang.tang@suse.com>
References: <cover.1653305364.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::29) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94f96c9d-a80d-4994-7aa3-08da3cb01662
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3899:EE_
X-Microsoft-Antispam-PRVS:
	<DB3PR0402MB389955F307CC893DB5734116F8D49@DB3PR0402MB3899.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kngodd+jiXNIlhTECopFODFMwKdAiJnbh4EOW+Le5nUxt4cE+L+5mW+efVKVvpQhlBnYtS6F4fYGpnqGOVSV19Q5RiQUdwDDiby4Q7DhiSaWrRL79usThc6r2tKCbsUY80e0PNQjqt9T4Vvr4gvsWqyYXUJwrLiIUm7KuQNcPVs+rMRaSfJySOC87EgeUdmOx1RyygJ3Qqk2AQIwEX/FxKIs04xs/S5xn8O9PeMD11vNKzRe8wMvkK4MlppUNJIH4u2CruJYQtY9+vVGUs2MlVdMunPJr8RKWgPtl3DvrnoicIq0n6y2JNXRC1DIrl0uCnez8O6ONzBQOswggFts0R0aPQFCoGX7hyL35UIaaoD824yGhcw1sKWMQuU9vGYCMZ1Szg1zWX9ZewR6+Zibh999ycZD7L5wLydTOy6WjARn2Diq4eJ+bBzJSl6m5O1zmWzOqry7brAWVosxS18QBkb7DdX+tJz+S1N1qgioSeiqk4O0qSfeeEI3Sepb6EM5tqFpDgl94Fcwj367nyoPCa+wNjOqyYZYSeW1Kofw5RmPEKReRzUtOLwZClDGtAbpstWMNIstZdEGj/RvxcbIOOoGJ8Z30t0sAKJbV/UP9L3wYGuqvB24yClZVNzns2p1tWre0OCMjjwi6n+VLbzObKKflip4zY+7/t6X6Z4CHmf5GMQ2vm0J9bpKNQ9VhD7bPJcatHcPKoPvDDoc5KpDyA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(186003)(6666004)(508600001)(38100700002)(6506007)(26005)(6512007)(44832011)(5660300002)(6486002)(83380400001)(8676002)(107886003)(8936002)(6916009)(316002)(66556008)(66476007)(4326008)(66946007)(36756003)(86362001)(2906002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oeIOHxxmD2NAxAYKA/yue29m1wK5p5VbLCx1XKbowtoV3KxL553L3XBQBZod?=
 =?us-ascii?Q?SsmN+1wLz2sEQmky6AhfKDVHxebDKe+V/5fg4dT+jADei+6oxVK4DfsJS+xZ?=
 =?us-ascii?Q?AKlkplDFT0QtHjiE2ZBGtOrsFvyfyE8SIJuWr5c/s4LkPVsDJK0Cu5Ek3Vn0?=
 =?us-ascii?Q?RCubk+1noqyhWGbBoQReoBHu1z/espaCv0oSP3pNdf4gZX7cYoGtVmuJ75LZ?=
 =?us-ascii?Q?sG8VnIY6PYXTnKvbQ9I1KdAWufVPwPGB9ix/ppB+tf11c++NSN68L5evUSKQ?=
 =?us-ascii?Q?xvrAlaE5fDER3tNF4/U6pdoJi1w4gWosO9WGaRTMVbTFvhFyhIZyn3+U1XXm?=
 =?us-ascii?Q?aSNgpwqPh8EsL6rFpwUAFB8evhseOPXlcXdM1tqAdW7wriwpOtMyQBDq7NUp?=
 =?us-ascii?Q?Ocz0IoqxcfLYVvYa0E3eUpA9xaMq7D6Ju4LQnPbbjNK1gcvffiobDd4ynTE5?=
 =?us-ascii?Q?iRJDAiYc20Vs9AsAPHWQzp5xKIRJQcBDGUahhGTkS+sTXu6ccqUeJU4ZHkCK?=
 =?us-ascii?Q?PMP8+7HgAOm7rzqoy8KDmDTl/kN/RWN2Ij2P7jt379NQesqsO3u5svXFbzvE?=
 =?us-ascii?Q?f9IKItiOAkUPZ7fwdPTHnETqvjPfaYFtp7ecDepmvD2iiaZnW1cMweL1QuoS?=
 =?us-ascii?Q?YdR+ws8UpiHmDO2W9KBYvbag+AJxz6WvvAw4gAUBLBu32C9lG/IRY2iTl+R1?=
 =?us-ascii?Q?m53F9nEhbU9qVN61Sek1WDTpH+KxXI2B37XHRPCHUGqpXfXDkUvcKgbnJcoP?=
 =?us-ascii?Q?wITROSWqud9nttIm4Ny4vxaz1i+zYumREzmkxEmqk89cXpRA4RC9ySJX5Srg?=
 =?us-ascii?Q?Y9rYPIxyIfhynXvbZUN0zLtXvSVvRA5Z4GclfldcFAvsBz8xNUOETQEhWQss?=
 =?us-ascii?Q?KIENP/lvBaiGXkGHpMDJS43/LKSFlomtal7GUTq4GdJKhM+GcBIJVEkaO9Qn?=
 =?us-ascii?Q?GD0+uDvsLDagux5DdPY3/ss0K9V+OUGKub/ODyUMjM+rBLrwKVCvvDclla51?=
 =?us-ascii?Q?5sczL1YuQeDAtmANfkTQf4x6Iu90U/819E87kT2z2Q7ZyTKZnlY9YBhL5zYC?=
 =?us-ascii?Q?6bxMqLnyfD94OouPJvvczhCVcG7K6m3geGP0VEcI1JqmiYNjfvDKh2keRErQ?=
 =?us-ascii?Q?CvW4C/M8lR+O4vtAor08mCIEXSQxdOdIipkp4cjlHEoNwmaXVVRWQnpOk1d7?=
 =?us-ascii?Q?HV5r6GevNGcwOX/ZpsrhlgD6YEghKv3etUpvQgv+P6r8Fgspy9xtVzdJaqyY?=
 =?us-ascii?Q?DQiKseuTxWA4c2fDD4BU2jhVuLnkISycQdvCPP1Hoq/NxNghvHMhuQenYFQm?=
 =?us-ascii?Q?vL8bMFd18v87lL/thbZRDSdnJmVWPpfAeM4UTngp1QkEAadKqAMMwUA1VmIq?=
 =?us-ascii?Q?bLO/McBRASIfXyiDiL4DVtohDNOYGc31A+NW2bwZxRDSZT4UrXDg0Q4wB+fx?=
 =?us-ascii?Q?JvBwQoomNG55vH8fL1L5GA9DHpwMqowwsovOw9qjCwn+Gz3OSddhT0aOtLyF?=
 =?us-ascii?Q?jvCsQYj7HXslStilACqDrygwIzwrTGJGn3vsGG0jKb4oSDxNS82yXZOUozHk?=
 =?us-ascii?Q?JtrcIbd2/2IJpOBPcFCTV+SNKZGH29S1kTAeghQoRD93v9QKwfrwf5hzw14R?=
 =?us-ascii?Q?Z4b0Rp5Of/EJGna4bkXBxdpQ/Dkrjaxur0jWIARZvilB4L7PZ8U4E9RrMqYM?=
 =?us-ascii?Q?5mrHOdp0lAAWUQ2EQAsREnI9iYex7oPVMGzXo/9WNyD0iWLe+i+dFJZX78I6?=
 =?us-ascii?Q?WCUufTtYLwtneHtGJ2D9bnFOqL6GMWA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f96c9d-a80d-4994-7aa3-08da3cb01662
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 11:33:41.6934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gh7FnAM6gr13oXKGHcu/Ohe2UjwdR3v2crHf+3P2LR4KjM2o1hWLcxf1ulGEwA93aYj+J0PGtMz0GGzmQ713jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3899

Use bitmap instead of sock in struct mptcp_sched_data.

Please update the commit log:

'''
This patch defines struct mptcp_sched_ops, which has three struct members,
name, owner and list, and three function pointers, init, release and
get_subflow.

Add the scheduler registering, unregistering and finding functions to add,
delete and find a packet scheduler on the global list mptcp_sched_list.

The BPF scheduler function get_subflow() has a struct mptcp_sched_data
parameter, which contains a subflow pointers array. It returns a bitmap of
which subflow or subflows in the array are picked by the scheduler to
send data.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h                           |  8 ++++----
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 12 ++++++++----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 6456ea26e4c7..24a9eb32c1dd 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -97,15 +97,15 @@ struct mptcp_out_options {
 };
=20
 #define MPTCP_SCHED_NAME_MAX	16
+#define MPTCP_SUBFLOWS_MAX	8
=20
 struct mptcp_sched_data {
-	struct sock	*sock;
-	bool		call_again;
+	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
=20
 struct mptcp_sched_ops {
-	void (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
-			    struct mptcp_sched_data *data);
+	unsigned long (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
+				     struct mptcp_sched_data *data);
=20
 	char			name[MPTCP_SCHED_NAME_MAX];
 	struct module		*owner;
diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index aca4e3c6ac48..17d97e21b1ea 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -231,10 +231,14 @@ extern __u32 tcp_slow_start(struct tcp_sock *tp, __u3=
2 acked) __ksym;
 extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) _=
_ksym;
=20
 #define MPTCP_SCHED_NAME_MAX	16
+#define MPTCP_SUBFLOWS_MAX	8
+
+struct mptcp_subflow_context {
+	struct	sock *tcp_sock;	    /* tcp sk backpointer */
+} __attribute__((preserve_access_index));
=20
 struct mptcp_sched_data {
-	struct sock	*sock;
-	bool		call_again;
+	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
=20
 struct mptcp_sched_ops {
@@ -243,8 +247,8 @@ struct mptcp_sched_ops {
 	void (*init)(const struct mptcp_sock *msk);
 	void (*release)(const struct mptcp_sock *msk);
=20
-	void (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
-			    struct mptcp_sched_data *data);
+	unsigned long (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
+				     struct mptcp_sched_data *data);
 	void *owner;
 };
=20
--=20
2.34.1

