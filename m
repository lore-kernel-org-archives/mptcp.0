Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130045.outbound.protection.outlook.com [40.107.13.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B772B3207
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 12:02:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0+D9yYZOk1xC97LCLawVREbV1VY8BErZhE3hUp+KuwY71PQZr7IU7Ng8Zqasah3WHgfAkBQuMzunL4zN+npQmxg/UgVUyk7k+/l9uqN0ChjKJsRdUSwe97is8hPe1DNIfup8SgP2KeVC2MvqHzzoryQXLqk06XdfC7qBCYB12jVCQQqvZKN3/oJheeMAIFfBXnXrAcqqjxt2ZQbaDj3xCe1DLiR6GrYflo/ojasPLpr1QxbfvYLgz1UBB2j+F2jS1W/OlCuALylA05u1KEA6TLTvGZ1VseVrDKA1kkKVL0PqO4H9rzSKPDeXVg2hGdJSp8GH6W8uG/z8syrei1JoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20RVBhpRQXhxUTJvHjXUpXRrX2qXUF4NiXAZFWpUtgQ=;
 b=dmg6ULN8ml8zqbbc2T6a/igBiDJZ8hqQMjuME0SpX6rjkGHUALH4JA6oaermt8v+YAFT5u4uEHxe3UZ3vErVC2rdi8Wx6I0eNdAy4hR39mO3vAy46ba/p1DgICyLG6YEqkiBkljLo1pdAWGlaT6GABCOMmZBLk5xJc4tlAFdt3TSvtQWZ4Dn8aOh/OiXakuATsudNyGt86hA31dyu7+simhTLmSZjNpvh9XRYIsdcR6lnsbRXoBVPd+PKF5LZ9Ka5Evk5zOflAcgonlf3Ufo/nz/2NQWkVmSZLv1fUnN71uGL3neHtF38RiShbhkS8HAtBkh3Gk59bFI5WOb8gIamw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20RVBhpRQXhxUTJvHjXUpXRrX2qXUF4NiXAZFWpUtgQ=;
 b=p8IpF9SLitrffWCenLVfiAOU/3OoDpfRj/zQ5s3R2vngFNlRShdFVYarKOmqWPXNq/f2tiYYz+4Hx1xZsjaIZLahDfJeMRGYn4v0m01G9Y094aCwRjiyEbRoaFlhCy+GCaFd1Ejh1Ec4CGsNwmB75su1B30iSCjC05f88bgOkAQZK7WO3nxW5B0GNk6IcuF8LZGPhLQ1g0uLMoNggQdBPwRdvBWw4Rv492HxJERlAnpdsBrsc7UNlxqZj0adWxE4u3jkyMvctmHJHP7ojSHswSD90VykdXC7G3jkWF0JQ/sHEQxgLayz/RT+NvVagzPmPZNRGLnqqU4vl14Zn+ocIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7557.eurprd04.prod.outlook.com (2603:10a6:20b:294::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.38; Tue, 11 Oct
 2022 12:02:15 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::f426:b04f:d9f1:cd5f%4]) with mapi id 15.20.5709.019; Tue, 11 Oct 2022
 12:02:15 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 08/13] mptcp: use msk instead of mptcp_sk
Date: Tue, 11 Oct 2022 20:01:32 +0800
Message-Id: <20221011120137.5475-9-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221011120137.5475-1-geliang.tang@suse.com>
References: <20221011120137.5475-1-geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0232.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed7cbba-0a42-479a-09c9-08daab806fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zD5SN7W3oO2mjT41loeeH3yHgd/+Csuo5y8q35jFWYXCtWaLEdvzXwBpOB2HlFSxGv6ukL/O21llEEg24zOwGNdCX7CNex7IvkGiWHDyGUznRgq2geOlWk7xd6Ykz8k+/6H5KjTgBPmENYp+ktMUgyOgKYVtE0n/scHPciH72WnFBQEkGWQiiHg2Kgtu5ag2EwnMs02VaHf/GhEaUtdAQtlKQBfOI0wDQXB0U1TGN9S6LsqeteLIKtoR6hzuyJVeAwOWBHSjs/hlAkse/NMWU9hs1RpNU9+RbE6bOK3Qme2ESq4S/NkmrvCIxIrlYaA8F/vPtM9H/GwwykAHW+y2VQcz6T2CvABtPRXvojcdsXNkCI0pC84Qz96e7fu0bP83epcFmdteKG7WhL7uaiSSmEjxydVQWYjJ4RAvsc46UaVMiHcPitZQFwDrN/34fvmsj9vMIFMfDPkSU64k2K2EcbaL3U/GJcP6d8UOHcjj/DAUVvBGSylXHPsqGyi/NQQJZi/i7r+GMJ7Fc//1C6PtKA6ZcyopsCDpZHseeu+fzB4H2813Y+b8SFLp/+S6I1QOE5S+8A6cM5NcmpyG3MP9E7Zo5hKUcKFMPZMNRDZr9hNTTh9XMnyrzT0aAOGOAuVhhofe2E9CPiccxCN05G/6NL+QhImWH5RKGn06A7FsxQ0JnuQcMemQP3EUJb94pQDxWN6exd/p86oGBUkcQIy1MEFyTLb/5LXcvxQSXMJF+V/Be+8ds22aB+XvgPIn+sWZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199015)(83380400001)(44832011)(5660300002)(8936002)(316002)(41300700001)(66946007)(66476007)(8676002)(66556008)(6916009)(4326008)(36756003)(2906002)(107886003)(1076003)(6506007)(6486002)(86362001)(2616005)(478600001)(38100700002)(6666004)(26005)(186003)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7e48HU2Y88vC9iDrF4C/b/laxjnNcEKA9ItPnegmpfI3JYsadLH5kCuleJcP?=
 =?us-ascii?Q?SjQJIUy9yaaASgNLu1+rqLmUb66sKCNUsBvlvpq/kQbpJZ7zr1LCURhNqasw?=
 =?us-ascii?Q?D/abGcnAC9hl1yerkGd7z4QT+2e+VniI+nYqT+qVi5Bpt4NTMAYcXHBIz73s?=
 =?us-ascii?Q?73XahPHb8RZszIARNxoetE68x8sEiCCeUe4UKdSlL6M9WU8IZLfjyFrOhTxu?=
 =?us-ascii?Q?zyiTbhq7HtFrYcwEKF62e7nKWI2WRWCZT4lHBL9/b7Oes1F8o/KOcnhZt7cd?=
 =?us-ascii?Q?nmMP0t+pS/uoffCB86KLvW/KVSGGPA5S7hs90RC0e3MVj6AC5ADysPM7chUY?=
 =?us-ascii?Q?7i+tE6FoHEzBuemBSpKqe4EasrxJnGdreiHT1XDWlyOxjUH/SlRxlxb6YoVG?=
 =?us-ascii?Q?mRaj+T1B8MH+hyTXhtsZoEbpkZhFAP7OyGLPAlZrk+e/XepPFPH+SZO5fD4o?=
 =?us-ascii?Q?gVrEhpE6deF2KdM4J8QuBia7fJ4EDaMa7VazIvjzasiVkfiDleOVD5kUgE5R?=
 =?us-ascii?Q?BD56NsPIKZcEljIC+VQqMU1VF00oP3k46NkAlMdUdBkeDuk0jAR2VGd+OsOm?=
 =?us-ascii?Q?pM17v9i3kXnqw7lPP0mh6/LAkxlnyv/D783JXZUue+XijDctKKKyXoyvGiah?=
 =?us-ascii?Q?rrkmjkR5j9/Hn1m/hYNTO5Sn6HunLUQEcXfcgXk9WAyLe/MIf5McFVHxfDom?=
 =?us-ascii?Q?m3/5Dpc0V9coDLXkQGdk5v1rK3z7fzuQAMttfNR/hEt7rjg3VK8PoCn31K1O?=
 =?us-ascii?Q?EXFnL3PF9/UGcuF4sj+//cY33EAnHz7wsMvT2xuo6/zBefkcwXu4E2D8iIVy?=
 =?us-ascii?Q?14qBMsQqXu6i/kU3WghJlWwwIh/KLf5KiL2DW9Dsxn8POfIOcRwoaC/pBOgg?=
 =?us-ascii?Q?/QHfzHxqqCotX4V7Q1oiTK+2seNjOu8WTyweLWhZo9MtMYl0/CsBpd2wrGXs?=
 =?us-ascii?Q?TLYWtT+0PMlBHdu8q426Ajr8JccNfUEcTOobUnM0zaupjTqIxpxtdHwgnOq1?=
 =?us-ascii?Q?+KCt2dA7Jhb6USnOvJ6C66vCIUwtvZ2IGHu4arP1PTjrWBOY29y7iVB8pVWY?=
 =?us-ascii?Q?23b/Qe9SeCM18k12Boxw+CWrW4aowsGKoJYvQyotq5AwBVca3RnJu4IMsMI5?=
 =?us-ascii?Q?JsoFh9V7d73mD/Y0nOw+W7+bDo5pYgZxbwY9UAgiFSY77mRYEyIkHDQB/hh8?=
 =?us-ascii?Q?KXvy5neZSho22AGLvobQqXvGDWXDN4RhS4TxlmM8rx98iqFAapQpcRaDpnM/?=
 =?us-ascii?Q?3J9T2mzHhvg6BVVDt/cVBRKKTaJoL+q2uUXUb0vtC/kMnpwGmAusUaVcvHH3?=
 =?us-ascii?Q?blE16ZFGFMGTJ7W5CVRWn2GvSlbqs8oL6zNYmq3SUR5lz9uQuWcruymHEQAs?=
 =?us-ascii?Q?Q2lW2wGDAuSmtp1fPAIhbDkdHn2tSORuVC5be4xVZS6472vsQyJZMGebQIsP?=
 =?us-ascii?Q?5B3/dpNhw6g27o3D8V2x1SX6fl06dT9yJD+cjWhY7kZte4QPgLQfzqDyw+Eb?=
 =?us-ascii?Q?UfPluT9m2QS1yj3BBOjstt2wpGvAvaZd6fCkEmDq1V0LbKBTD4AiPoOJXNq9?=
 =?us-ascii?Q?BEHF466/frmoo55HDn+bVszjBfboG84g+RRz8oSJRQ464jLmfI3s4iZYCz1L?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed7cbba-0a42-479a-09c9-08daab806fff
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 12:02:15.0120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egTX5Exvot4NVNmxPk/pVqqhWR6yCDcdOtNutiypu5rTLZmP3sSSeTDo2fbS76wkV4mE05c/X7QfVJDPIezNAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7557

Use msk instead of mptcp_sk(sk) in the functions where the variable
"msk = mptcp_sk(sk)" has been defined.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6f55b51e10eb..e3a5936df0fc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1619,7 +1619,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
 			/* check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
-			xmit_ssk = first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
+			xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
 			if (!xmit_ssk)
 				goto out;
 			if (xmit_ssk != ssk) {
@@ -2255,7 +2255,7 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 	struct mptcp_data_frag *cur, *rtx_head;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	if (__mptcp_check_fallback(mptcp_sk(sk)))
+	if (__mptcp_check_fallback(msk))
 		return false;
 
 	if (tcp_rtx_and_write_queues_empty(sk))
@@ -2934,7 +2934,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 
 	sock_hold(sk);
 	pr_debug("msk=%p state=%d", sk, sk->sk_state);
-	if (mptcp_sk(sk)->token)
+	if (msk->token)
 		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
 
 	if (sk->sk_state == TCP_CLOSE) {
@@ -2993,8 +2993,8 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	mptcp_stop_timer(sk);
 	sk_stop_timer(sk, &sk->sk_timer);
 
-	if (mptcp_sk(sk)->token)
-		mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);
+	if (msk->token)
+		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
 
 	/* msk->subflow is still intact, the following will not free the first
 	 * subflow
-- 
2.35.3

