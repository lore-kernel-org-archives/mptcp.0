Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2079.outbound.protection.outlook.com [40.107.105.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA977628
	for <mptcp@lists.linux.dev>; Thu,  8 Jun 2023 05:48:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaG1ZeYAWBM7YV4aBp8CmakLv9dz9vWzbv8kH5+fOelmbwhyXBy/aQG61OHgzmbpGjFJ9SnMnhnOMdEOMHfmADEN3hoSf2J4nbEcnoKcNfrqYwaZgRKr9B+VaY2FQSdvWOVTd38s96Z8+46syJ6O7wV6kiUg+ix/cXCkbNWc9Jel6dUmIsk9CsKxbVFEcVCxwHYUJnUMJwcdu+H4z9FAPqqlzLCiUe2Zj1oEi/6KR/Gp5hLquxZEJpXP2fc7NGhzJeq8XWywwtapPwFxnw5F7HUHScBey75U57AbdjZ4larSBFj1oLiagPGKkM/ckQ0ht0B7sXK11YnubBgNuXpZvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jivDzjsfIh6qB2dyArM31gmAOKyV93m36LJi/YFBHHk=;
 b=jQCsd/9zKpPYNdNDThqqGAMhgP1iBDdAHDAbqTU/onk60zQ2QlpDxYhTe8D5CBJg/bOUVeWvXuFrnW8onv4AnlzWCjr06vdcc8Ci1mQksqwgJg4RZLEZbqBmdTiLD2z9d7CWzITzd/aQBWvSzN0hcX9NfHI9gI4vu8aizMogc8d5h/w7+fGbkkC36UR9vlRpUi+FrV8j6uvplLW6mqbrqxt0ZTJg0m5Th/0buJTI7fxNpCa4GhD+Lgfb+w0TAvmenDxYMB2J4H49zYzpj07MuNOgkTHA/bHeBg8HAwbjwtF+wp9d5KXMmowTU5Xpp9rSZdISNB/ACzoBknBUU5JHag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jivDzjsfIh6qB2dyArM31gmAOKyV93m36LJi/YFBHHk=;
 b=vfPtnUKtRVgRcurihLkHv18NYht3r/gB7vLc4Pe2AC2kBJhr7tTqYp7wZIFS9jKrTj0kbuolJI8tiL4l9CVci+AG3sU3xOvnm2/PATDoZVU8C0GGU6H5DWb3OtyL8le1UyL5fyCwwIz/ROH9z+NjTb2iRhTVystyVGB+qsiBNtN/GKd0j7T5UMemlLsQqBXQj3UbiruG86I7ddwZ4v30wO6bCAOpIHF3UAmzyLc7Lpda3FIkSR2IITOsmUwioR17OQUQQXPri03qLG3Vak2tUWAvyVShGKfhJ7lnUzb0dDAvKd9w8JDOkkJW/BapGsmEXEF4Vzh/rxSYJsaP3xQhOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7600.eurprd04.prod.outlook.com (2603:10a6:102:f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 05:48:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 05:48:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 10/17] mptcp: add two wrappers needed by bpf_burst
Date: Thu,  8 Jun 2023 13:46:48 +0800
Message-Id: <439c0ed62b5ce426e93de1aab6f92324df0c0768.1686202841.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686202841.git.geliang.tang@suse.com>
References: <cover.1686202841.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 45348619-05e1-4f3b-63cc-08db67e40be5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jsjq92FF3pEeQ5lGIFXKehgU7HlNFTREzEmUfCA2ZgtpZqmC0c7vJKn8Jsg75YAEjlCV4G9DohcJu28w4egabMK/S4rnyMHrx1QhIbT4oSs3WNT0p/fRfJ84XL63uNDthc7ES9RoUGb6aIyEDY8mGBpOG40hMxaHeM6jakwfdyAJY25bByCK4YhEHMX+ajN4odXCBkLMHIAl0cQYxb9oQxIT3Or4UuQm+ghhVMPncTmlOxVW4zTJL1/QZjVMmk3T9vAflJdP8GgQ9HSeUU7uZ9WrATRvT7PxFRYFBZQFVTbg1niqjKy8paXxtaLFl3PP2ntK/cxFDJmxK/YVcOujkeqVHdtBw45TW5V/5BiRQTj+xmCghQDEFEqCdVI2hC7zL+/KfbmsSCha3R7qItE9aTcRnimio9p3ojKl+cfQy18FU0ZlqGjzecVEOOaOz8gQIhmaTJfC0PZde2oFOdRpVOkgbgrKtP+2nqNSDqMjjNw0xNGHaVtNHDJcQ3e9Qhd/eHg85z+Zsus9eqTncDtSdfzatlSCzA+jpraZRd+bci27vDFRkGH/3iEoUutFUfkp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(6506007)(6512007)(26005)(107886003)(36756003)(86362001)(38100700002)(2616005)(186003)(41300700001)(44832011)(6916009)(478600001)(66946007)(66476007)(4326008)(2906002)(8936002)(8676002)(316002)(5660300002)(6486002)(66556008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LvvNf5FyNWnegTx2mJpoBspR3apfWGJH4xIJ0To5IGY17aAxkrZjdLXxyHOk?=
 =?us-ascii?Q?40yom0qM4Lf+OtADUNDUY3TxfF99oDefKK8JZhx0i4E7XPaERYMh+zSAZo9r?=
 =?us-ascii?Q?Pp+3gGU+Ad9tU+Vo1fRICmU2dlR2sI9mQJrc+KM586w0wyyYr090H8o0kE71?=
 =?us-ascii?Q?LzgJ6fDi+AKAAl1EV1huQPhFIEzRBmFqPzaXFmTc78PSSCeYjVHsAzXcf+M7?=
 =?us-ascii?Q?QnpeT2G2+U80CeSYIfFKP41DbJ6GpgQ3LuB6Wvfj8XHyqjyFERL+tpdIbhY4?=
 =?us-ascii?Q?cHXpCtnEeNAl0Y7caQ+9udUHhKYGZdqmQdka6FhUmXTMFhifs/M6g7tC90LH?=
 =?us-ascii?Q?4BaoeqeGbTW7RdGcfehdSmQrpukqpaI6tI3AFon0vw5LTSfkMwuBqYlyLc+R?=
 =?us-ascii?Q?febYK1Jz7cYlt8HGPu53X7H0Y+sn/giQ4/trQkcvt4Lij/x+4d0Zvx6zdcC9?=
 =?us-ascii?Q?RysNSTm+2rOZvmaUgzg8nVTj3zusq3RdWMGfjUY4HolabEH2Ug80Ye5E3tyk?=
 =?us-ascii?Q?BSUjbtvBm6wNonC95JtRu8MpfgnsykOuP8i1hpnbhQbVw9gNS3Qz0FpViswI?=
 =?us-ascii?Q?4D+5haMHqLvfdJLawTNsxfsepw0SMA+DFDgYkiJLiyGrorYTTvzrs6q5lbs3?=
 =?us-ascii?Q?vSuVya0g8AXQ6QCCghWSltn8QRxEJytlpyElTFsH68nceHo6twa3IKhDoYdw?=
 =?us-ascii?Q?49T1hJ4RXks6jE8e31BmzImTJz8Tr+UtJj3LM4xrbLAG7kO2od23vx7xLFsG?=
 =?us-ascii?Q?SXJxhwnSlh5atEiwp7NyC6VH0d/7DOLXCCy9vs1GIQpnb6GsSTX4AENrKOZg?=
 =?us-ascii?Q?R/YjcbDDr7jpa8AzAyNBDtQ91M5nnF5C1uK/Nae15LM3YOajZT+Q12sLvY93?=
 =?us-ascii?Q?C4+HyqvXaJo4Yw+if17Gvot/Ia9s15TmKvoeO46xapl0IsSJFf1MwTcvfFlW?=
 =?us-ascii?Q?OTSaGRDOEVu7cY+kxv2kh+El42BLY4NZlMTqT/9/Auf6hcCDFUirbyV88Zeu?=
 =?us-ascii?Q?Eb1K+14NXR8chmd2UgUkhqyx0JqK9l05pN3gK4jXJVA/IgF3tyAJrNqbxveW?=
 =?us-ascii?Q?DrwhqpoyY45/jAMggwLL2BXN4C0mERkbKzvi6q+YQRB762Q8l6FRQHF3xgwq?=
 =?us-ascii?Q?zBwzxo4iojAGkBwy1jrBZgxU+b54T0mj7L6Jf4CZLxUDA/50v98/HlXhHCRy?=
 =?us-ascii?Q?grHZ2LP5g6gET4w5FT+Ohp4AzG6e+IsvzuGp+0uI4XW6oO+kbokX04t+OioZ?=
 =?us-ascii?Q?TpbhCHGTvjwd0jdNi623yHEp7xGm+Jyfopjohkxua4/KXUxxR919BrUJ5PWq?=
 =?us-ascii?Q?PH11eDI6tju9EAjnBEL45wskKQ5xZcK+0o7DMnMRUjvT1O3+ulYMTCvLF+HM?=
 =?us-ascii?Q?Vx2G+iIXvi9sjRV0tOTjraBGWos8UFH//qE5gTV+toSMvhewQji/drLsSDD6?=
 =?us-ascii?Q?fGJO91RoRbohAcc5i9iP6RLXvYvNV786CXv8uxPcYTOpiTRvvEuYSFrmNvzQ?=
 =?us-ascii?Q?fWziF5QWA/J/2IfOhiD+faySShxBuBpQZIW5JLecfSUuOZ0Fy8ekKSiZOXQh?=
 =?us-ascii?Q?g9nOWOqjZvnzoWxvdcNOzJi0m24lYKSOS//gSTM1?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45348619-05e1-4f3b-63cc-08db67e40be5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 05:48:55.4203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JhdlSYEL05rRgIRUABeg9ilW1FCuO3srZ8PgCmBjclKfGalsNz1gUpHL8v6kDP429t4/Som+/5EAYOTB7B7Wqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7600

sk_stream_memory_free() and tcp_rtx_and_write_queues_empty() are needed
to export into the BPF context for bpf_burst scheduler. But these two
functions are inline ones. So this patch added two wrappers for them,
and export the wrappers in the BPF context.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c      | 10 ++++++++++
 net/mptcp/protocol.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index e2ed4223617a..14de8f46b5fe 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -169,6 +169,16 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
 	.name		= "mptcp_sched_ops",
 };
 
+bool bpf_sk_stream_memory_free(const struct sock *sk)
+{
+	return sk_stream_memory_free(sk);
+}
+
+bool bpf_tcp_rtx_and_write_queues_empty(const struct sock *sk)
+{
+	return tcp_rtx_and_write_queues_empty(sk);
+}
+
 BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f30af7891c20..a38b712a6d2f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -667,6 +667,8 @@ void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
 				 bool scheduled);
 void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 				   struct mptcp_sched_data *data);
+bool bpf_sk_stream_memory_free(const struct sock *sk);
+bool bpf_tcp_rtx_and_write_queues_empty(const struct sock *sk);
 struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
 				    struct mptcp_sched_data *data);
 struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk);
-- 
2.35.3

