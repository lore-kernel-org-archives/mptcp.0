Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A0638E
	for <mptcp@lists.linux.dev>; Wed, 14 Jun 2023 02:24:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBhVyjr5tXtdc4IMqiumhwapq4vPtzXQmsnIEqNA1DbV4Gqgiou5TRu4hLGffhhGzJj61zqrgY88jc/kPtEyj4LVG4VaqG+2ImyvAETov9JQjSioikMa64yH3cdQ/BDHKdFsYbp8/WBKNk89/r3SKwBugPx4JUr+fMRCuyWH1jrAuaspxE36ugolZaBb+jgG4FhUHeF7PGWhIxspfcbqrQwiiB7x2QqfYOnpxZLXPXxVoNS7CJXcgF9bwbQ45daZFBCCyU3/tktIBUaORYzSpmmpEuGamgugB1ZB6COSsWfwIXBQEbo6okZsWZX7ywoCDA5vGcRhc+wGTpYbYP0k6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rthE8MwKdz/VBTt0zWlIBnJYPMyT5dS6OhqDja73kGg=;
 b=hKDW974AHJO6R3xDAt5+auYny3CRyi192hAzEiCI6lOgTIU/B6ycUnb/qVkD7vpzMLggLH/sItz1pDhHJ8E6Jzl5R1+dwSRyIqJz5NqRMEjbXZ66U1qSBOU6LS9K2W/jt0Zr8YiLb5U4AUEKwwLSdOyZnPXX7j76YqVVaxeDNoR90Z3TCJ42/JiZE24efizaQWTDMQ30EH45NCgTZgfgUmmnWoIz7yEns0GSdYaRLcO728WWf2BKAr3Xrq0xp739SXI+6WL4Z91Js6zRYyZC37TmKnpi3DO0Jtc4ikldKDm8Nv6D4O3qSnG3QLBDhFvYM8/azos44aok41am86dsVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rthE8MwKdz/VBTt0zWlIBnJYPMyT5dS6OhqDja73kGg=;
 b=XIhGoZ9yYWfvHQ5wQxVEROSoUCL0FjDreRvCW2jnAduV24TLvpYGFd7TO+zB28meiLAvpfj2C4Vg0bc54Sl4bsSInWGP1/oS0rKByhr8SgRvzCzA6oJHxBBkEuozKworqxRO0NnGtDWQ4r1C7+xJfpdwjrBnI6L6OS1vwBHCRaSMzLlNJ3yzluOabE5Nb1pDfQkLmea+QDUDiV4qDTiE4lEee6yRAEKfmHHtMpJcdPcjUcn8I88KYCa7TUM+hyaFjdGFA4RC5IW9voM4eDc7M889NNO9SOcGpP6WXyhR0PxMOe/N4eRhASsFwIbd+7VwzZuW5ecvDEwlEHXbIHbaXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS4PR04MB9241.eurprd04.prod.outlook.com (2603:10a6:20b:4e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 02:24:32 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 02:24:32 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 18/23] bpf: Export more bpf_burst related functions
Date: Wed, 14 Jun 2023 10:21:05 +0800
Message-Id: <be941f6e3ab0d2c4f8ca7e940093046d184dff54.1686709116.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686709116.git.geliang.tang@suse.com>
References: <cover.1686709116.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0041.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS4PR04MB9241:EE_
X-MS-Office365-Filtering-Correlation-Id: f7dd0966-4db4-41d2-9aee-08db6c7e7cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BB+vfhcVNnAm54zK1vSuaDHD9rfF8ceB0nn9NC5sqeZDyhEAzlehqX+0WCzaP3YvsP/2oErB8srmtQ2WXhiTMZKn+aN6fkCyQri8iO87Y9VUz5+hYph6+lismVrTxlN1/tfOZHDdMJrSPN1wyJ1fvU+tdvPd3tG7xf65PGP8TPd3M8BkMJHuYx1LdsT4HYLDDJycYYTECeG5RBwUKiK8i/3SL8et2Dc18XQ2UO+Y9dy70Z/fqQUTi/Lep1xTdv6DrsD5Ir3grZeXUZwOPnzCUe7kMdSqYNoHyiH5084yUb0prq6k+gkQ6EaYPDcnAhFdKp8D8hMI5n1KDWDGCWJXUqrvSMmQBF5lXfkhRpdx9MNwSBtr0p9zkj1ArB3fFL4p6aUbGWbzybMhIQI9t/i7hy35u7JqhzAStERCBL547t/R6L0rsJdddLFXQ3ZpAYPfTz66g8hNWaf5FvqiAJkYOKxMIBULuAbqWoV5Zs1kU1WLgJNYIEMyPm63oXvPZhbvW+LVWkbbZtV6VOCS2m+h1vDp8PILP67GivCIJ/oTtC0yJ0g70Ra9I7ubWOB0bgQP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199021)(478600001)(8676002)(5660300002)(8936002)(41300700001)(316002)(4326008)(66946007)(66556008)(6916009)(66476007)(38100700002)(2616005)(186003)(6486002)(83380400001)(6666004)(107886003)(6512007)(6506007)(26005)(86362001)(44832011)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U/fm1kFQlBQ3PxMWD6tZnlxlKDVpXbdcxYPiaBaaE4G+IrkQTydLbwSdG0lY?=
 =?us-ascii?Q?TiloVMPvT1FB+oQ3lKRnAeO4xtZiBql8zx3FvWCTe7CsMIvoQICzKBpn4ZB/?=
 =?us-ascii?Q?foRbargV3hdzvuUch9XrrK7RXES+8Qh4pVSFngjKe+NOF5aIidRf72mRzw27?=
 =?us-ascii?Q?r6cvgRq9yvBL9NDsGzeZnoftAH6cSb8o1+dJ2TKD/X+QPCuGTRSk6n4CBoKH?=
 =?us-ascii?Q?uHJs7eYXnuhilGhBmsrWMdu0gU/fdMVM+ZpAEzv0SdL0YZyHQL25SzJkC/Rq?=
 =?us-ascii?Q?xVyWEaueH0mIyxarLg+9bDib/W5qnsIhKAqehRG+/aAdaI0Na7oxhKgp3NkL?=
 =?us-ascii?Q?h3kwUC4g/zzohAVxrCVH8CtAXEB4eCSKsIfAIHmyAui4Di7AWNq6fWQ/KKTH?=
 =?us-ascii?Q?kBbOInBoiD+uwiGMpVMHO+5zWF+5FUI9zXVfu8FM7RMNoqGqQoHqa9N/MB1D?=
 =?us-ascii?Q?IIznFmtqqTxC2Mbdw08r5MvrKvfRRbFq8+veWODunfnYjcgJiJdQ2oYF+uWS?=
 =?us-ascii?Q?TQGnoW/IRyctgr6xNlCPZ7AsgV4/GNVKmFoRzPXk4nhBqBXhvqWFk4ikX9hH?=
 =?us-ascii?Q?o+WN/klRCPWAgyKbmkYDGuqn4HprR9MXNge5VOfx14F2EMf3+fGjgW7PYrF7?=
 =?us-ascii?Q?OrKFdb4zjDChQgYS1srJlI/p6fBORecsANxB9JktALFq+lfYKkUMqTSgm3gk?=
 =?us-ascii?Q?XfFMXQxu7zpp4I2dk4j05Fm5htf2pptY/SN5wThsi26YcNj48HmDM28MX/47?=
 =?us-ascii?Q?B3Wit3eho+iZADP1ltTzoK5AEXpHBek2ymsb4zu1pFCFSocnpLTewEMdXOQq?=
 =?us-ascii?Q?hMqKcdB2+o0pB784gGrPJgmjG/25hKts/4L2sl+b+CN5tvda1btViKTrps9x?=
 =?us-ascii?Q?S4cKbAkAyAD49yfYeg563kxIGS7Am6ktMxGttaGaoC656G91fvm1MfhuavQV?=
 =?us-ascii?Q?rd1BqdEPiwN0dY9MH5eLgAzu2+KhA3XdmWw1lRxhNQkcbhFLSy1N2r/IYZx4?=
 =?us-ascii?Q?H2aoOEdALjFr9Rm6uugalF6KBqIzhW6OEDzSIb/XeTTP5dAYoLnYOGhyTgmU?=
 =?us-ascii?Q?cPXLr60Jwixd5Kjjx34JRLXyVSV6xC3EmA3c1zH47yGzL9DV+YsunecDOVEh?=
 =?us-ascii?Q?fa8/4Z7TjJhGABWvwXR9tbkMnqzxQVUXlCRwer/NSJey1c7uHYjoJYf037AG?=
 =?us-ascii?Q?I9+PdDvxXeEPuaJ2OutLirCVgTIxG0FOKNniIvMxjvzd5PDe6AlCoqtB4XMO?=
 =?us-ascii?Q?nv7HGF2vSw9jJGueroW8SEwyjgL+fvV3g1I29sZMv0WCLZ80Qf5FRaK78qEr?=
 =?us-ascii?Q?Ctlp7MLM3Jbn8gwOFFT+q5RxzB02ZdlwxenIRZzMgZ8Rw1PkK4r+pDks39iy?=
 =?us-ascii?Q?wjX2AY0GO/n9Edv9FpkgjTSrDzOpZmDgkqk5c5jWDkhrI15dzElxw9SEOrOm?=
 =?us-ascii?Q?tQrYuTvodL4IukolbRvs9vArMmLw9gNwGc8QxSI2uKLNdRReUN7UO08MSxrC?=
 =?us-ascii?Q?iaCP//YilAnoDawv//Ks+qHkYRzhlY31mD0W2Ok2h5ZQpLGZ815qYsDQWQ8Q?=
 =?us-ascii?Q?ZUkCsUASSn9wrk4eb8RlLCMJlcIc7p5aIGFIOFIG?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7dd0966-4db4-41d2-9aee-08db6c7e7cbb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 02:24:32.1009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UW69SrDwdNV3srn4NIFX0TYjeFKxX9m7mFqoNSFD4nNjRME52slVqp8l7mhatmu+Vcc/6Vb+sckVP+NsybFCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9241

Add more bpf_burst related functions into bpf_mptcp_sched_kfunc_set to make
sure these helpers can be accessed from the BPF context.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c      | 6 ++++++
 net/mptcp/protocol.c | 4 ++--
 net/mptcp/protocol.h | 2 ++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 97fc0dc1f3d9..15f399317ac2 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -189,6 +189,12 @@ BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
 BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
 BTF_ID_FLAGS(func, mptcp_subflow_ctx_by_pos)
+BTF_ID_FLAGS(func, mptcp_subflow_active)
+BTF_ID_FLAGS(func, mptcp_set_timeout)
+BTF_ID_FLAGS(func, mptcp_wnd_end)
+BTF_ID_FLAGS(func, bpf_sk_stream_memory_free)
+BTF_ID_FLAGS(func, bpf_tcp_rtx_and_write_queues_empty)
+BTF_ID_FLAGS(func, mptcp_pm_subflow_chk_stale)
 BTF_SET8_END(bpf_mptcp_sched_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cd96a0fb369c..0093128a8c75 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -50,7 +50,7 @@ DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 static struct net_device mptcp_napi_dev;
 
 /* Returns end sequence number of the receiver's advertised window */
-static u64 mptcp_wnd_end(const struct mptcp_sock *msk)
+u64 mptcp_wnd_end(const struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->wnd_end);
 }
@@ -498,7 +498,7 @@ static long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subfl
 	       inet_csk(ssk)->icsk_timeout - jiffies : 0;
 }
 
-static void mptcp_set_timeout(struct sock *sk)
+void mptcp_set_timeout(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
 	long tout = 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 784f4643831c..88a8c72ecdcf 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -638,6 +638,8 @@ void __mptcp_subflow_send_ack(struct sock *ssk);
 void mptcp_subflow_reset(struct sock *ssk);
 void mptcp_subflow_queue_clean(struct sock *sk, struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
+u64 mptcp_wnd_end(const struct mptcp_sock *msk);
+void mptcp_set_timeout(struct sock *sk);
 struct socket *__mptcp_nmpc_socket(struct mptcp_sock *msk);
 bool __mptcp_close(struct sock *sk, long timeout);
 void mptcp_cancel_work(struct sock *sk);
-- 
2.35.3

