Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80071.outbound.protection.outlook.com [40.107.8.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF03C7A
	for <mptcp@lists.linux.dev>; Fri, 10 Jun 2022 13:06:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTqyqoJXVz9G6Uv2eqmZd7CNXqlpwUEpsSFZHafIhm/WIemHXSxrcK17aSCSehdbaRlowxnhI8VcugJaxqVGbmvaOf2MWTWJ3Lpd9FjWwUfWid8A7qSz/KmlevjvPL9HzNiFuoAPAnhNzzMkom5LXWpEJdl5CDXaH32Vd/UVLkT/FTW0+25zONjOvlixnF52idKXMWDU32Zn4f9BdBNl2NZO4rMFU73YJZZiDP+v0KYvEzz8dHu1SThBDvwxZZTry5pJwQlnfxzk323hIBB+5GiJ9yb8jcqA/0/KubSiyqT3Sd3RPOngbBoOwIPEH5ekF/sxD2odadq3gdI6vuG1rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKVdeKpUGp9QrdLtxrbUjQoMSJ7Gr6pgRXorvM3oM9Y=;
 b=TR0VyrskkikfwwXQ11BrGe+yjApE+iTcg6s9lZniVo8yF9QmPo6Dhhx0lTFz0Vp0iZSLv49XMFpa1hsuLuwhgTnXY4y73j4FTX+o6E3jKfrOszQCVTgSwJz5+npDHJpF23jxkbfaWX5e7f62xYbv6YoTXFTrngyKuCewtlE1VaYsP1pIHzKn1Gm5SBn5X41h3sVQ7miBfa3JJfBt8GHG3aF43sXv5eSM/49cVpbviBXxScGlb2mQWd7yjxHOKdLk+98LGC2dgaJgubP6RD/MydXMU40/R4iaaL/XGfFfkrzM5msIuOLvCBiVTFesSiqeyKYomYuFbXiD/JObscNLlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKVdeKpUGp9QrdLtxrbUjQoMSJ7Gr6pgRXorvM3oM9Y=;
 b=uaaUgaKq0vCEVaGtrhjDYlVely9KBnjtygrZwMIpAX+X4BP4R1BlUPt2JeH5+lykBzuwvAHwx8UT+ym+IQ8O9mu0w672gVhVU8wTeMyBiCJSyX6iIMZ95fI2AsiLKE9F6FZtnjMCf9Upxm8WX1NABrUN6xowbJDTz0jnyl3aDxXlbBNAXB2sTz3MwdiZCLIkLLtoGRP91Zz3ApCwlIPW0EYpK4Tw3YgCLAR2RycZlzf/0ugD2lBIh2uvPxUxA7P7wjMgsIMTKiJ2mgwmkFtXP+TtvkIeIhpoIT8+yeB9ZdvAntCZtsFlD+zEl4BZ5Keb6BPfJ8zsyqTMT23l90VBDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0402MB2725.eurprd04.prod.outlook.com (2603:10a6:4:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 13:06:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 13:06:06 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 3/9] mptcp: redundant subflows push pending
Date: Fri, 10 Jun 2022 21:05:28 +0800
Message-Id: <7918875de1a12ffcc6221da479cce24e4e556889.1654865847.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1654865847.git.geliang.tang@suse.com>
References: <cover.1654865847.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0132.apcprd03.prod.outlook.com
 (2603:1096:4:91::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d756b079-3263-453a-710b-08da4ae1fadd
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2725:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0402MB2725D7B610D38CC4AAAF812FF8A69@DB6PR0402MB2725.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P1pSa3aoOTDazocL6cA2CnGgXmkhMHodSb9xzCXpbXPIHl5GRIvs8LbwMP+bkvgivZrhkis5pS/L//lWlTcXOnp9RrT3J7bxqZUjKJynGuCJ3EzNpCxFXP/m5Z4pAqfv5BH5Ar0/fBeodefzAe4LO7BdfonPnLe94GcI3s7RPT4hs6W99rgTlzshONAo27uehNFugzz46Erc+T6OKj8UepCSRsiFEsGjBGgdQg4vFxTPZUmaclrn55GQSau/vxsItXljKDT+IQpqkAKKQa28u1wSDLRpUJtTOeXsahG5GmePoNJlYkDHhC6W93TPefXi9duTi617GUlP/nY4ffHbxBxC1RiXy3HuzNUe8B3UxpEERokGd5V/9bM0VvXNZPBS55b3EIM3mzBeHpHkmNHkN6H8EYw3J2BzXHVQhno8OUWHaTuEVX668LSLhwN5eoRnIfiuiUR+rvEbz19B8qaTh6JU/+KCL/vT+s9+kqKHNQU95eyDF4H28CX8E7FScmMcLiNHR8dRw7Qivhtvzq5Q5YjK/cmHTcALpNg5LKCeDQAo7gsLlKZI4TqtV1h6e/55gO9xMPDcjRqQ1LXwloqIbEDzVhtD3iqevup25PBKbHleKvvJLh/aRw3vOf3w2Vjn2YNdFY+A/DnrSh4QrJPs5T8qb7nYvfhx21baKLOfAB0mTBatWeLj+1Upk8Qbia6RWHhm49eLzbJ9UZ+3LkCZvg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(26005)(6666004)(2906002)(44832011)(86362001)(6486002)(508600001)(6506007)(83380400001)(2616005)(107886003)(186003)(8936002)(36756003)(38100700002)(5660300002)(316002)(8676002)(4326008)(6916009)(66476007)(66556008)(66946007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vcmylog2RJfRcyjlYooiyE/0QBaaqt8KTHHF08JzpWOigf4W/LiRhcHTL6xa?=
 =?us-ascii?Q?h77aXVFs+tCSHybsr4S8xTcoVHfI5XLU1uRs5B6Z7Add2hhHKISZCCgKR/N5?=
 =?us-ascii?Q?IqQePZwGYGw5/DWRtCh/KdC/gDbyXTHO45z9GVQf+eCsDIN4HAbeoRbuGVh6?=
 =?us-ascii?Q?XojswpLpIEwA+qplfhrnveSmw2Pp6GTZ5eUt9kiMG+5xmlqTz4SIlDdr6QOP?=
 =?us-ascii?Q?ERIfy1pmDflMNwPhYXOH/9C77B6/H6z45CdEjNSU8o1J31Yn28SaZ9ie3qHm?=
 =?us-ascii?Q?NoAYWmc45lbXEHvipy6eYqUPsnkoK2ITZ283e2TomPpMWxYufKyHGbkikgc9?=
 =?us-ascii?Q?5vIbMXY1BYekZ8+qoDRW8XXL7NkAruM+WD7wEtl26Z5gJj0a3SVohig9BOuy?=
 =?us-ascii?Q?7wPScc28sdMWIe0ceNcovRXGtzZtIROegroPNPylDHlKHBwW+vlnN9rikUfk?=
 =?us-ascii?Q?pMTgRFW+iAJSv9aALRch9gpqOJEIB8yI2Gr+9JfehWpsndkvtzdX3qKEFegN?=
 =?us-ascii?Q?58QkMuKFI02LdAn0ixFxpnx1ygLiHdb2GyyuBZYPEufYUWVoBXjyJpVY2rsN?=
 =?us-ascii?Q?sS1VKtDe1T1X/la2cLjTqKklNqq/31HceWZvqnz3o86gbx7O4PSximOBKWDA?=
 =?us-ascii?Q?7BiDA3P5IPrnhTvctvvW5YDvyaSYoQtGEijgpIK0BYneID24sUmRrntxaMgM?=
 =?us-ascii?Q?RAO7OesJ1udUTtGW4IFycQd+P3o3eB9UpaDnXtHQYa5efDXd21f85T+bU/Ph?=
 =?us-ascii?Q?+6UO0+SB4CPSk5Y9RD93xuSElvBMGucbSBujubDfuOH3KdZKNH1qiscfgkjs?=
 =?us-ascii?Q?ZDEX/pvP8slayqsuP9Zev9HV1dpvP4dzhYxdt6DuTrfYDwOuM4bNhlDN2mGd?=
 =?us-ascii?Q?ppsVp5u9t/cMJqWmW2Qn+7RKpzX/d2K6Dx04BvrgczBHPx0f71wg5obCKylo?=
 =?us-ascii?Q?sNzBi1ovHUmz9qKpM12wmgYH2Ly2rvr+BFX2vYeB8K/6TmYej3UvHwiWkEfh?=
 =?us-ascii?Q?4/Uf9MGupBsxPqJf2aklQbjaGVPrmSuLbP+/dR10ivGsmcmvsObUau/euDSt?=
 =?us-ascii?Q?EaOdzE/gMc8CqXsEIfbiSl+kJ9PiYyeRlZBm9b9yt1W4cKssJUEyPhLGAiEh?=
 =?us-ascii?Q?j0AipMAkQdN7KR1XVg0WJQtFFsGQuoIKML4IBE23XyByVo951BllDoturRv+?=
 =?us-ascii?Q?6Jab2dpEFgsvN+P6SxK1AaKVNGdT48CWdP8TDKjKYWjPRZdp9VYtSXuCa4ch?=
 =?us-ascii?Q?X+jHaQ8KOE5gkt5YGot+sxF+RlOG2cxglKcSVbbvIseINVHv/S7hBqMx8i2y?=
 =?us-ascii?Q?nIK8SM6bbnJrlV8pU+bAYVRoqDBIO5zkOsBCPFeQ4QbpEzf2XpEaJwkBOEvk?=
 =?us-ascii?Q?IT8rM+eUGjAtZ5azm+q17++7pj1ICUpQOk8cqk70XLD4qXb2hMFan6vWw4jp?=
 =?us-ascii?Q?y3kSkIyfx7GL1QfmvjPVOLTyrm72aRrVmOgvmV79Cp+ekajCFCmwyhtfup6Z?=
 =?us-ascii?Q?5VtDg2RiHOVmsx4bv5JOUO5IOqBWl2Cy2QAq6fGb7XafSXI3gL0qft9MjKuL?=
 =?us-ascii?Q?gT0XFol9omqbHqncQfzdYfk6XD4ZzSztvLI8eQxxfsimk3ysWXVLTzbmMtZB?=
 =?us-ascii?Q?OxsoojU0+2w2FW9duN7wX5OpER4+mjqyouVTt61sM0ttI0Wwa9OMge59eyqz?=
 =?us-ascii?Q?mxrtx39ZjDCdPUhjgASoYZ3pQHSDMLLoSgO525FgyZ+cNfmZHm2jOYF2pA+Q?=
 =?us-ascii?Q?mjyo+1cijok1nqGHfp6Bx/w5RoD3zQM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d756b079-3263-453a-710b-08da4ae1fadd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 13:06:06.5759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pStK7MBoTkupoVPHeRaSIEcKAzPaKrLKw6yynkpC+jhVY9k+Zp2tjSBZs8+ax8U9ld3gMIuaSmHqgASjdz6vuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2725

This patch adds the redundant subflows support for __mptcp_push_pending().
Use mptcp_sched_get_send() wrapper instead of mptcp_subflow_get_send()
in it.

Check the subflow scheduled flags to test which subflow or subflows are
picked by the scheduler, use them to send data.

Redundant subflows are not supported in __mptcp_subflow_push_pending()
yet. This patch adds a placeholder in mptcp_sched_get_send() to pick the
first subflow for the redundant subflows case.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 73 +++++++++++++++++++++++++++++++++++++++++---
 net/mptcp/subflow.c  |  1 -
 2 files changed, 68 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ab42059143fa..257b04315271 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1549,6 +1549,62 @@ void mptcp_check_and_set_pending(struct sock *sk)
 		mptcp_sk(sk)->push_pending |= BIT(MPTCP_PUSH_PENDING);
 }
 
+static int __mptcp_subflows_push_pending(struct sock *sk, struct mptcp_sendmsg_info *info)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_data_frag *dfrag;
+	int len, copied = 0, err = 0;
+	struct sock *ssk = NULL;
+
+	while ((dfrag = mptcp_send_head(sk))) {
+		info->sent = dfrag->already_sent;
+		info->limit = dfrag->data_len;
+		len = dfrag->data_len - dfrag->already_sent;
+		while (len > 0) {
+			int ret = 0, max = 0;
+
+			mptcp_sched_get_send(msk, &err);
+			if (err)
+				goto out;
+
+			mptcp_for_each_subflow(msk, subflow) {
+				if (READ_ONCE(subflow->scheduled)) {
+					ssk = mptcp_subflow_tcp_sock(subflow);
+					if (!ssk)
+						goto out;
+
+					lock_sock(ssk);
+
+					ret = mptcp_sendmsg_frag(sk, ssk, dfrag, info);
+					if (ret <= 0) {
+						mptcp_push_release(ssk, info);
+						goto out;
+					}
+
+					if (ret > max)
+						max = ret;
+
+					mptcp_push_release(ssk, info);
+
+					msk->last_snd = ssk;
+					mptcp_subflow_set_scheduled(subflow, false);
+				}
+			}
+
+			info->sent += max;
+			copied += max;
+			len -= max;
+
+			mptcp_update_post_push(msk, dfrag, max);
+		}
+		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
+	}
+
+out:
+	return copied;
+}
+
 void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 {
 	struct sock *prev_ssk = NULL, *ssk = NULL;
@@ -1559,15 +1615,20 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 	struct mptcp_data_frag *dfrag;
 	int len, copied = 0;
 
+	if (unlikely(msk->sched && msk->sched->redundant)) {
+		copied = __mptcp_subflows_push_pending(sk, &info);
+		goto out;
+	}
+
 	while ((dfrag = mptcp_send_head(sk))) {
 		info.sent = dfrag->already_sent;
 		info.limit = dfrag->data_len;
 		len = dfrag->data_len - dfrag->already_sent;
 		while (len > 0) {
-			int ret = 0;
+			int ret = 0, err = 0;
 
 			prev_ssk = ssk;
-			ssk = mptcp_subflow_get_send(msk);
+			ssk = mptcp_sched_get_send(msk, &err);
 
 			/* First check. If the ssk has changed since
 			 * the last round, release prev_ssk
@@ -1628,13 +1689,13 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 		info.limit = dfrag->data_len;
 		len = dfrag->data_len - dfrag->already_sent;
 		while (len > 0) {
-			int ret = 0;
+			int ret = 0, err = 0;
 
 			/* the caller already invoked the packet scheduler,
 			 * check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk = first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			xmit_ssk = first ? ssk : mptcp_sched_get_send(mptcp_sk(sk), &err);
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk != ssk) {
@@ -3093,11 +3154,13 @@ void __mptcp_data_acked(struct sock *sk)
 
 void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 {
+	int err = 0;
+
 	if (!mptcp_send_head(sk))
 		return;
 
 	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk = mptcp_subflow_get_send(mptcp_sk(sk));
+		struct sock *xmit_ssk = mptcp_sched_get_send(mptcp_sk(sk), &err);
 
 		if (xmit_ssk == ssk)
 			__mptcp_subflow_push_pending(sk, ssk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 5351d54e514a..021b454640a3 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -881,7 +881,6 @@ static bool validate_mapping(struct sock *ssk, struct sk_buff *skb)
 				  subflow->map_data_len))) {
 		/* Mapping does covers past subflow data, invalid */
 		dbg_bad_map(subflow, ssn);
-		return false;
 	}
 	return true;
 }
-- 
2.35.3

