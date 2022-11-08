Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942576ABA
	for <mptcp@lists.linux.dev>; Tue,  8 Nov 2022 09:10:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzFv/wMpYIkhhT1iJ3cd/9JkkhYDvOMQuOzwNWrOztuYIi3DY0RhIYOHtX+u62No25b1WTrzX1D2zrieKwOFDL9N4XNZE0ru5e5odFg4hG/MmQpnMud4ce3RF0LTThDRcajyaxyoztSq+Y1njGg58n1F0QeoyoQsVTeb+6lfvzSBize7faes1tq+4peaSQC13eVANafQpJ/anSQ4n3X9euPdeplSBMIXz3l/SEm3ftn06wQFu+ZNd8GEpLzQ11LUsa9frx94r3qxLdiGAAbTvqWDNT/uuVS6b77JFFbSQzmeIzEFSR2BQL9agvEeqNGJaO0Gv+6HB86PDAEODwrApQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1orINlyI/A0It99NkoBadOMmufLfxUmYtKySvKsPWQ=;
 b=czvZdTzBKzWzZszjorWXpDi3lgw+tXTlCg8fJu1Rayudem2Dk9gh0i1FcuoqygkkKBd3mg19rOoROpG7X7Z7odBBxjciPwiAMY6Jt8hhm5TLYqXShW82CuBdUu/WowUHo5HBhOkaSEx8H+SV2iOTkef/8fctpCEXNRip0Qap7Y4gIIv8BLgbKWSbB9iu8bfy2XEHtLEVtfdbc97MItsmsCQCJzyl9gIhPhED2+Rvmo4tURQQKGh62tXSvDimDp8x/mK6UmBJqS3kaH+SOr8+MZ3XV1NxKWjaqqiHG4V1aLdLaGb+uTRK7NJZvSXcCcRdeJVr2SpKpoU32RZGur078g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1orINlyI/A0It99NkoBadOMmufLfxUmYtKySvKsPWQ=;
 b=op7r5iC/TZFk8JR79UjKRid88GpfXWi1x1NX0uDkqsGgJWbg/bO297fHe9m4YEt0gQClJINOVW+xzB5KsmmjpCBtpDWEsMVnnOzwwz/fKeac7Ko2C1LksIf/5ihgzrx1GNW0vAAZ9+AQuRaoO2Mj/anUsnQ3pIsqyP9yuTFhJe0TGmI4byOx8i7YDCwrwdvwHS+NW5mPD4giN7skjcJRXynGDc4K6+fGaSx16Uq92fhrEVggx4I809fPx0sJt4qAjroJLwZKnXcq9zhqK61IHVx25FIHZ2JWtf0gIno0RJtfXZehq0fSONcjNuuGREsjbMFWrYMsAI8AyVa3H2GOXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8831.eurprd04.prod.outlook.com (2603:10a6:102:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 09:10:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::a1a0:6e54:f31e:2bad%5]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 09:10:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v18 13/15] mptcp: delay updating already_sent
Date: Tue,  8 Nov 2022 17:08:35 +0800
Message-Id: <4efb16b4dd58a380dc23948a22785062d900d402.1667897099.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1667897099.git.geliang.tang@suse.com>
References: <cover.1667897099.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0227.apcprd06.prod.outlook.com
 (2603:1096:4:68::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f858d1-3747-4f1c-fe66-08dac16906af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WhK/llQWM+8hF5Nw9GqLYvdbevnBqATSAtmPOPo5/d+ADfdsXRucQySswmX4djMRb/AIvztPxjWIMh+hI8Ddrk+nLGC7Uw3gTOhuCzsvh0ic7jR9c/Bl6CKbh+8drddyyJ5aNHiOFUMNO8MN96JXUCKU+A7Ql9kOo1A3M9beywjF0ceneoNv/DDC8JtBBkmPvH4vuVMo/pIDnyw7rDSQnbaAwoVv5m25IWCqarwc63bb2g9AGSL/ZAkCI36bLgb6NW02OKtH4KJy11u8IZYczRuJ6bfDgqVqxvUAv0GuAB4/3kA2SO+hhd6PVPNBL45z+tTjvafkEIVpyopgq2VcyJC/PovNA5om//pMRyGfHanghTY/IZOY66jhU/KhrzA7qNuOPB9MRLuH7laoQC3IwPc3Y0UbfEtVfqCf62ywmDPuK3ruro3ba6qXN9zevYmed4c8n+6mnXTaVQ5hI7dZZFnnKEE1vXPlzHOsZmrBZ15DMl7UOGRt/vi5+pC9HeNnRYK4nvLbS5Z7ZmoNiergodWZYNIMIFFnJne4AjnDnCotOGkOvJcK0Rs+W+x6B/CFDkXfCQKliGJqCB8t24uLi99eCA4VD02dfzt5PVPkehsSGPfhtTCXabpQmxOAdgDCoRPAE14TEZY60UPq74bBxIz/b176jtd8azJvl0RiTv9ueWy04IqznudrZfwWZIE6z48lWRxXDOg05gwIkNC0fL0x6cYiBELPaoo9meOn7obP6FCBNzKcq3/ZkfmTFKwU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199015)(6916009)(316002)(8936002)(8676002)(2616005)(4326008)(186003)(41300700001)(36756003)(66946007)(66476007)(66556008)(86362001)(2906002)(5660300002)(83380400001)(38100700002)(44832011)(6486002)(6666004)(6506007)(6512007)(107886003)(478600001)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XWJddrBcXnM8iFU0/0X+iCdw0FfUlsylNQORpP+bUTtWTDm1JMYIDXyShdyE?=
 =?us-ascii?Q?MoHq/9nmkBmf3pmxLLxy+UHfspmoPNGF8RYcIc6uyWn5j8rlO9Mk8+KzB+bV?=
 =?us-ascii?Q?9gN+c6BFiJQCdPEWKL0hHqkQeWAb8ZKuFSwHYFkdlEANxQGFE51oB7ETIjCg?=
 =?us-ascii?Q?gKlHByFad4qetEJmlvvPoqbiLIpHNXQyl1XxeCUmg195wp/hVP02KSC9dpeA?=
 =?us-ascii?Q?0AUHjqvOnOp9xWuvBFq5RbcPJ5uczxnWsOGI+aG2AlXzx1xKWa3JRTHNrmSb?=
 =?us-ascii?Q?ffi7dr+lwc01fzkJ7d8weWbRrYZK8U64EpRN9lh9522cB+sQQQh95TbuHWXD?=
 =?us-ascii?Q?mZca3UquoWRq6JE6OBDofAgM5uBhhF2sUOpaX3rx3nZa+FFetXjqQUekOkOz?=
 =?us-ascii?Q?zSyvSIERoWeRlueTX6dTYjZipPv6xhK5YlR+fE2Ap5gbFjMbcNa/YmtbEHWP?=
 =?us-ascii?Q?3O8iofn1xwJaFDUpdxqs5loO4l/GWcbruesRgM619f9rkqP1W8zGTkmEh/O1?=
 =?us-ascii?Q?5hjDWZ4PRLfTJjdnPVOtUz0jNq0jpG0GsU/2KpFpbV08FbuWweQb4tb9N9QX?=
 =?us-ascii?Q?jGFuVGzSaVz+++TfqniGqNz3WrNx3TpBfqCYDnG05NB6GkeiQU//236smGy/?=
 =?us-ascii?Q?Jku6mJyBllBgdQ5QbZ4h8Zp5rSl3SZMdu9q7RnkKGHKuHbdN1m+fCh78CQB1?=
 =?us-ascii?Q?hP/JE6ba+G1OnLJ3xs8040k35kFf653NYX29bI+x9GqRQN/Qx3NCEGK2tv60?=
 =?us-ascii?Q?e9B2WTcLjdNGHjid4q9xqnGAQl6+4qgyCmUZfsIxDnnE+X6kKMxjIMpOE64y?=
 =?us-ascii?Q?FTt1SaaBY8cu1yRNTHHvjblDZNX2LWoB9quPjDdFIpnkmezSzTB/w7pT2zm7?=
 =?us-ascii?Q?mZDGtSNQV/oj9fA+8nv1RExTz4ewdkXGUbwkWD1s5GNamYTTciV2PEB5LjJY?=
 =?us-ascii?Q?RZGztmAOreO7BMQWXdXmNmAHHHx9ktlCrtakk5RawGNdGAcdi/3P5WkZbzTr?=
 =?us-ascii?Q?lFzmzynCYnynnmHP0ABnzmmez4yMfMq80H+k5wvMkuR7QQUTcn92q0cXkORV?=
 =?us-ascii?Q?38+ynGPns92mxfboHeODoN1jGpPUJna5IDsUY0oYTUatFJhXJ1LVFV0lVirE?=
 =?us-ascii?Q?MlmMw/I8Dn3oxFWCsNuunzIDZclKWNQ8sW2EjN84WCRR20Eqr+E/Jw8kHp3b?=
 =?us-ascii?Q?e2iSS6GQj/1IPSm5p2Eaqj7HaBeFG4evdkSJG/vkN2XCzhM0FAWArHgx8pcr?=
 =?us-ascii?Q?LK6x59bspl5DuzviHH9loTv15/uumU09myxFuB/v7YqVvHdrh01G/OqMsj9O?=
 =?us-ascii?Q?kHtAEXa/GWMAU5GU5OZ5U8/o9HzNR+DBejM8yAEEJsZFH0sr6uemd+F8bO3v?=
 =?us-ascii?Q?wmuwaxQg7ePcRsbAiwOcKmivcvQHqtNJM3FLZxcLawZN7gFMQ2onNxFtcRcq?=
 =?us-ascii?Q?ZA+c/MhdGiKCMNJ7Bv0ff71t3rHMAVFzGPc3LD33DPQ8PFXKNy5mkaejY+zz?=
 =?us-ascii?Q?+N+7DOS92hCkXS+aNlV2CXOVp+PIgTmELX7uPoNKPwXOpOBvynBZ95XBOl50?=
 =?us-ascii?Q?GBMTgveLOIl1O485w9XXfwFQ+tB3xSBdIUADrpI0?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f858d1-3747-4f1c-fe66-08dac16906af
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 09:10:05.7082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJHlc71EqZsMbfDW7Z0UnVPbjt8Q+wUEZ5y2nagbIENVz79XWsei3Cc64sL6SPBd9oEo+lSe52Q2KlONjRB+bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8831

This patch adds a new member sent in struct mptcp_data_frag, save
info->sent in it, to support delay updating already_sent of dfrag
until all data are sent.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 18 ++++++++++++++++--
 net/mptcp/protocol.h |  1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fc3498f84964..b179eb56b4f2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1108,6 +1108,7 @@ mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag,
 	dfrag->data_seq = msk->write_seq;
 	dfrag->overhead = offset - orig_offset + sizeof(struct mptcp_data_frag);
 	dfrag->offset = offset + sizeof(struct mptcp_data_frag);
+	dfrag->sent = 0;
 	dfrag->already_sent = 0;
 	dfrag->page = pfrag->page;
 
@@ -1493,11 +1494,11 @@ static void mptcp_update_post_push(struct mptcp_sock *msk,
 {
 	u64 snd_nxt_new = dfrag->data_seq;
 
-	dfrag->already_sent += sent;
+	dfrag->sent += sent;
 
 	msk->snd_burst -= sent;
 
-	snd_nxt_new += dfrag->already_sent;
+	snd_nxt_new += dfrag->sent;
 
 	/* snd_nxt_new can be smaller than snd_nxt in case mptcp
 	 * is recovering after a failover. In that event, this re-sends
@@ -1522,6 +1523,18 @@ static void mptcp_update_first_pending(struct sock *sk, struct mptcp_sendmsg_inf
 
 static void mptcp_update_dfrags(struct sock *sk, struct mptcp_sendmsg_info *info)
 {
+	struct mptcp_data_frag *dfrag = mptcp_send_head(sk);
+
+	if (!dfrag)
+		return;
+
+	do {
+		if (dfrag->sent) {
+			dfrag->already_sent = max(dfrag->already_sent, dfrag->sent);
+			dfrag->sent = 0;
+		}
+	} while ((dfrag = mptcp_next_frag(sk, dfrag)));
+
 	mptcp_update_first_pending(sk, info);
 }
 
@@ -1548,6 +1561,7 @@ static int __subflow_push_pending(struct sock *sk, struct sock *ssk,
 		info->sent = dfrag->already_sent;
 		info->limit = dfrag->data_len;
 		len = dfrag->data_len - dfrag->already_sent;
+		dfrag->sent = info->sent;
 		while (len > 0) {
 			int ret = 0;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4b13ba9df34f..5d85063dd5a2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -241,6 +241,7 @@ struct mptcp_data_frag {
 	u16 data_len;
 	u16 offset;
 	u16 overhead;
+	u16 sent;
 	u16 already_sent;
 	struct page *page;
 };
-- 
2.35.3

