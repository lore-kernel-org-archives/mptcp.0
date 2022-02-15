Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86901388
	for <mptcp@lists.linux.dev>; Tue, 15 Feb 2022 11:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644924343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rpvjijw/f3FOXqWwuq8fUOziZPUJ6WcmIUaWPaHs5PE=;
	b=hsELZM08tLijBJlNObOW9Rv77OD+7xQMOGwTRwbPXb5E7/5e91QtFqyfmdKSOBt72XUPmv
	EKysifnNsqza6bsQN7/TQ+eUM0uPAsZbPXoYL4BNyZ1BDRRBk/Bf8C3+Xft+XK+aFmCuLE
	Ong0LJbP0wXw5sveo8BobL97mCkRWAI=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2173.outbound.protection.outlook.com [104.47.17.173]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-liiGyOJJP5erqv0adWcN-Q-1; Tue, 15 Feb 2022 12:25:42 +0100
X-MC-Unique: liiGyOJJP5erqv0adWcN-Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InUmXLw4BHngiBCaP9FI7JF4IKnHrXzAt+lp8LwRmyVc7Rmfn2GTgqfMr4+QEsrCN/VL9BPJwvLn1tsYQjDb76oRKKnLPqBnH1JVlJFIrE03Zg1wYN/M05Jwfp8MydVC0wc3iLkLr7kLlyBI0yUVhH7ZLDz1XlebEAkGYj1pNg2HyD4c1/y47ft4lITBFcNvkvpcUPdSMrE7JDEOUoRJM0IS3XI+b9ZSJdHoQupc4H36XFDURYXuyG1AsBb0v8siCbxseeixs17Z5Ya2/+NF1DCY/ZGO12L3v7h+8XR3EwCbvLpUROn6BqwLYjOFCOWepNwgNdmrQfNgZOb0NCBezA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaXkYwJwQdIcg6ho/r9axu6yM8n7F9fr4yUzlVW4wTo=;
 b=Op46hhz8uMgNjcIjDr3iYIYdNtYgMikk8fZWc8BHgz4uc/bWOdC7SUy8Z0of6GMfKbmosHDs7Q9HxK1X1bEMqMgN7nci2rJFMBVt7Y/YZ2L+SI68qZo3avnA2yV7OdVErNSZ6SWNtib5nuXByzV+BbwP2fvShBFaND/sx+TMgPtWNQVNAjexSmwnLmffSwi5YsF9SPB5MksSCNuhdlPM0ypiDk+cLe9L5sZDan3NiFBZdNKm/SCNCfZACmacyZgz1iUUyTMvL6kFpC6qQEl0IQLNaDVvZvF2tsZa1GzsR20Zuq68pyNaOf/gBjFGPzPRLv1HiI7tLuGoYZHd7LMk5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM5PR0401MB2561.eurprd04.prod.outlook.com (2603:10a6:203:37::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Tue, 15 Feb
 2022 11:25:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Tue, 15 Feb 2022
 11:25:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 2/5] Squash to "selftests: mptcp: add infinite map mibs check"
Date: Tue, 15 Feb 2022 19:25:51 +0800
Message-ID: <715e59a39bf5b1e2ec095925004fafc28ba605a6.1644923833.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644923833.git.geliang.tang@suse.com>
References: <cover.1644923833.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0063.apcprd04.prod.outlook.com
 (2603:1096:202:14::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90e3f54e-6645-4a6b-5ba6-08d9f075e600
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2561:EE_
X-Microsoft-Antispam-PRVS:
	<AM5PR0401MB25614F77FD7407D365690B90F8349@AM5PR0401MB2561.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:88;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ocBFdR7IEp2qCNlW4o923CnUU7mB//FKRKuikA/WyLkbepDGt4KP5F5LwQ/VoVt3ixGU6LFc7zBvgAEqRsu0hTYfBomD14ZuxLRUH3SQDohY8bf2LCqZQocCbE6FwwHqW1Dw03neXWPg6rNhJNaboKqIPPTXZpvu0NZPNHJkyBhoPc1vtyEPhvdqckU5TuMKc7Thl+O0btFW9YSiYjrdipjIq9fnmHVU1SY8CZYcc5Np392RE0J9/shRMlTh43SXKsJzCQgEzOH9es/kxZpqMt/BuVtbHuM04lBFhimasxkizAyXrVlYS/osk8nS7f5zwjmz/yRpzVTOvDK0XN5wMViGAeCheJn+n23Z37/Pqgi5lXmQ0UDgIfAeYK61LEpFXt/G3KbTa64EO4CtjMqNHTm+g/px3X4vCi2/frF1rPH2lJiN0pvxUIFuK4L0aOGEtpY+HU4ugBBn3Tv9F1B10RK1HJzki6Beji768Z84UNd0/2pgj3L3A/7hafQp09GqTQbVuIDPvfk7L3czTnzLuH17oaPjBI00/A9my9f01GQUH7pagIYPo1SlGrhWneAwwUJZyTzdrtFlldMYTTF/0tIHOQyDU+qPAGtiMEyyiq5hXAOnVyw94CJuMgkAjd+GozkNhtrqCc/2MfNwEDsQzA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(66476007)(8676002)(66946007)(66556008)(508600001)(107886003)(6512007)(2616005)(2906002)(36756003)(86362001)(83380400001)(6506007)(6916009)(55236004)(26005)(316002)(8936002)(44832011)(186003)(6666004)(5660300002)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7lZMwtQ6BAHTSSu9Xak4fAm19fKW9PnQReQ51+1JJF+QPlOB/QHieJycjDkD?=
 =?us-ascii?Q?bYpLK7eSpfqvGSu2+Y+m2ZtHKTDartqY1/JYzOOYDRKTr2utYdwKBvknAnih?=
 =?us-ascii?Q?5R1uDrluaUfAO67pj6zGS113C+nVK59bMlYYDJRSncs6GZ3P2eddIZ7Ff1k1?=
 =?us-ascii?Q?v9P1BvAEawUyRSgrsPFGzP9Ivw18PBOa6H3J3Z3P/2sBy3YvPTxTB6pTSl3A?=
 =?us-ascii?Q?OhPLi4hl3lpw0sLZalpAeMCljdbqybiTofmx5lPpsmvrc3WjM/ywy6ki14J8?=
 =?us-ascii?Q?p27y3+b3zBvlMlY8Hf+E2jhnJNmcKIbl2kjTBKYDwmEcEgr8IqSrjadIZ2hW?=
 =?us-ascii?Q?yDIPi1WC+O8v/4he+f+b0/rLGdVxtXHebK+SF/xtD/D+IV7Emy1AbsxvVBSI?=
 =?us-ascii?Q?k2Gvpn1jfr4Gqmw741qtyC48bBb+vrijDIPEn1LY5l+Dew8DW4HqK/sDhRHZ?=
 =?us-ascii?Q?ERsTat4LW9M8Bt4hvvTsyCwOp6Mh77VlJ99teyBhNMMfpLsJ78A3vBqR0qY2?=
 =?us-ascii?Q?zW33MT08dO4QcyyP/RTe2nnhfgQQechkauvZupBdhdbRSo92aKhiZZiOqmKY?=
 =?us-ascii?Q?p2S71yPDhq/90q2dwmL2q1LcfP5PwN/DVU/nOdAJ/qTncbRws+LGSB/TEQ14?=
 =?us-ascii?Q?lSmafn6X9fbgj8YG/w7AjRHckRzSPuo6h0C81VxVQW4fCt8sWEcMGRmWNeld?=
 =?us-ascii?Q?S+hf/ihKEgcGfan9QpsKVCt87RL50td8I5ggI2gW3c1SLos/TyKeL+1AsW3O?=
 =?us-ascii?Q?yUVJjf6LMj/EZ62s+c7W8WViTni5ATcu9FyIezou+Adnc2NE9j46LK82dgpQ?=
 =?us-ascii?Q?mWCPRUt6HmMbvzTH0ayFdenvEaCH8rAYUIfjTRnyrgIfkFlV8+cflX3OGr5b?=
 =?us-ascii?Q?t2VL0XrKk1NZE1lBGMsPrBVnyq9+/Ne2rSfrtO6a1eZNpFgWK3xm8t8U/h5L?=
 =?us-ascii?Q?u1nRvdBJDNY7TbnZRiXtg0ZgiqOI9onVlONJn9QGxnudBUAVgkZJ8G36QJlU?=
 =?us-ascii?Q?iE7V7TQU/ByU1dW6ltT2Y/z0zyV7Taz4bTV/nu0R6agg3OpjJoNKgmKOPGEe?=
 =?us-ascii?Q?xcqZs2AREoKAWe0OstDf3g5Q/tjV9xmCht79CmVd9L3jnVtW5VqcMoJ8z4/T?=
 =?us-ascii?Q?2TUcLx1E7mnSyEdAVR3RoTZGpe6H41wdDgFsAn/Kr8axQBnstJ9CZkJkZdOn?=
 =?us-ascii?Q?QK3nyxIHvXr9XZiSFClnsoVXpEniUxFlcncU+Wtf9H53PQ5k2TeJ2qNWr9yb?=
 =?us-ascii?Q?oAr8B3kh1YYZWm2Z61SJw2mZkOyX1hO5H9RF4w4aBEA4jMemCLtUn77U0Rck?=
 =?us-ascii?Q?IiG4go+eWSmZkeyjjOou0AipbqQb0IDJsA2WAqKnFOJ3KnQx4pvXQgU6gaVJ?=
 =?us-ascii?Q?grRSj/jj6fnEa5OIdRzDtxo+mwbavqpRdnEAwtJkDti+kHp6BeWWMzQO0ZYT?=
 =?us-ascii?Q?LCEju4bxRNsaCObIPrxv5JtZzqS+P8HNAHascf4uGsGeUIcGpjDGYUXDdqB/?=
 =?us-ascii?Q?IKHWsKCdUsJ7o7gM4ouLBIZEkQGWTfp9iU0t7qbXjiNEZVgwS0cHcP9Uzniz?=
 =?us-ascii?Q?VfwyjNxeS+3LxLoo1CPYMChAF+WR+c3bWhJLHZVC3rNbboo9/zzTdmddApor?=
 =?us-ascii?Q?gIOGlUCNJBak7PFq97P5Fyo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e3f54e-6645-4a6b-5ba6-08d9f075e600
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 11:25:41.2914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MVOdwTKPAo7uR3m1mTboqH+L6jrAiKBLLnHAQWOBkHpDTSjnB755zwEGTLjFzeRnHr0q6RgE6U9Hx2y2aIrFkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2561

Rename mp_infi_nr_tx, mp_infi_nr_rx and irx.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 00a35601f319..243eb7e14921 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -859,27 +859,27 @@ chk_rst_nr()
=20
 chk_infi_nr()
 {
-	local mp_infi_nr_tx=3D$1
-	local mp_infi_nr_rx=3D$2
+	local infi_tx=3D$1
+	local infi_rx=3D$2
 	local count
 	local dump_stats
=20
 	printf "%-${nr_blank}s %s" " " "itx"
 	count=3D`ip netns exec $ns2 nstat -as | grep InfiniteMapTx | awk '{print =
$2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D "$mp_infi_nr_tx" ]; then
-		echo "[fail] got $count infinite map[s] TX expected $mp_infi_nr_tx"
+	if [ "$count" !=3D "$infi_tx" ]; then
+		echo "[fail] got $count infinite map[s] TX expected $infi_tx"
 		ret=3D1
 		dump_stats=3D1
 	else
 		echo -n "[ ok ]"
 	fi
=20
-	echo -n " - irx   "
+	echo -n " - infirx"
 	count=3D`ip netns exec $ns1 nstat -as | grep InfiniteMapRx | awk '{print =
$2}'`
 	[ -z "$count" ] && count=3D0
-	if [ "$count" !=3D "$mp_infi_nr_rx" ]; then
-		echo "[fail] got $count infinite map[s] RX expected $mp_infi_nr_rx"
+	if [ "$count" !=3D "$infi_rx" ]; then
+		echo "[fail] got $count infinite map[s] RX expected $infi_rx"
 		ret=3D1
 		dump_stats=3D1
 	else
--=20
2.34.1

