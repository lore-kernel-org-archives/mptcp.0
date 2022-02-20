Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DA128E2
	for <mptcp@lists.linux.dev>; Sun, 20 Feb 2022 03:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645326019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=azrnEwBQderhXPPkBiWQSW4EmY+Kf4ZJB+FQQt+eQx4=;
	b=NE/xueOk7B/GIpi5+YwHhj13eFAMFSIcovUcrpVtcqidSPKB0+29DIUXrcY0+s44S9lR+c
	0B+m2feIE4pPsIYd/4hWmzyhQ16U/i09CluOc50i+Qhgxf9prP3JpC5+xwIIJ3sYYWzz6Z
	OKH85/RLQ4rzl83VvY+MV5oFFRh2D/U=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2056.outbound.protection.outlook.com [104.47.5.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-7-t0AsbHGEMYao656JNZgYLQ-1; Sun, 20 Feb 2022 04:00:18 +0100
X-MC-Unique: t0AsbHGEMYao656JNZgYLQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaWGWvCKqrjEjBEDmsM8TTIuhbJwVTLscb8AUePTezVo2WZmvuZizL8DvNrtul8yD9HiQZXp8IAGXc/Kpz8VN6UxechOTEkqF+F2MQzGlcGLGcNcOAC5dnDME5VVXmve7lR3mrHTiOkw8+4QMo+5uBmIS37Y0x26T9Gc0K1V4brU8aFbpO29A2xEF86RpjeMakYVdp6omrJ0bWAN0y9yzwBjIDk5ILfzBSYzxZsLajQ/nUUlE/rtTKOU0W/piStUgrshGDq1etPfT1H8yDxwgaaTRHnh8wBereKbWzPKq0E1+cKp4X1Ob9yH2LMwWACYL5haLHp8Tzp625Sp0xDaxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWZUcEBP7UPsZBR854BU5jS1XyCEKMzvclO00opvPvc=;
 b=UqXkmekcgZRZNpGu2Oc3tzjIO16U/xUT0LGtBSHCj66dhSC6uF84Yfsna3YxhfDdlkVcrpp5m5fQuryDi4koFYDOYpNYUR7fRcHRmz79a8Zj08aQpOuSdeTQGwYFY+iJ8LFgbX2zJZcT6KlZ1eO2L3vGP82ExLz2JmYhoCx3jVP7Lb8CbYPOGh4h70CSF1mb6OlfL8N9z1icFtmGSmirn/p826D4A4r6CQGDcGMQyEMCGx2uVGrGN7NNB2PLSTEmjsGxF86TJBii3/3MayqliQPxufsYnRjm1pgDoFmrj0wCKC+Nnrz+dRNGh61iw9Vzfh6xFxKBR5y139u2jPn8rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR0402MB3414.eurprd04.prod.outlook.com (2603:10a6:209:3::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Sun, 20 Feb
 2022 03:00:17 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sun, 20 Feb 2022
 03:00:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH RESEND mptcp-next v2 09/12] Squash to "selftests: mptcp: add infinite map mibs check"
Date: Sun, 20 Feb 2022 10:59:35 +0800
Message-ID: <bbd021b9bd5b0605df0a5c58d25f519378316455.1645325178.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645325178.git.geliang.tang@suse.com>
References: <cover.1645325178.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0107.apcprd03.prod.outlook.com
 (2603:1096:203:b0::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d3a6359-9c5d-49e0-167d-08d9f41d1f97
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3414:EE_
X-Microsoft-Antispam-PRVS:
	<AM6PR0402MB34141B9E6F12DB2353C6A7CBF8399@AM6PR0402MB3414.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VaSO1e1g8DBLpMBllhXz1bypMfPV7OI1v8PZUZgkn4tS16QCV43saBMdb27Z/poMum9+XvpCk8lest2AaNfnY8np/fcn4Tc/G0hDDwOWBRYsDioeLj4H2zhQt3KX60AvXnyeJ974h7p27gi3LIVsDyMt5UnmRUJf5hgvCm8m3vCoQJuaZAqRiE1ARC6RAH4jzRXm8Gk+tAcCQmESjuYZKXuoanYUHay40tfj415+EpqBrrx40t/ldOr0nkLHHR26VVxGPKpkLHW49qc0rcnrXxsZ2uOupizqAuzOCNCK8VCqHDgrkcjPgc80YipWkvINgauRt+1zgWrOsRkLU55oKSqSqpVzhybgwBf/9O3fJehZ53TuNLDSVVPTQsviUksfDyIOa6F3MhD9Pr5DLu5ghbA1iB8WvMQcyhgAylV6ZUfslE8CFLW6uRplQ7bkkiPLkNayD4O8gDajhY2gZ8y2LYexOIJUGqR7VMTO69REPp5cQdD87he0GpxmpcZfpIluvN8LvQM90QhY3oFmv1HfPqBrOVNl/PwtmN8Je4IuZHQSK6bFmg4LwxA0xb4kynKSjLGs4O9LKVKzEOgbCw7OROHH7yPWQfoDgKl+WFhutAIe7l/s3ioe8Wpx7slZyScL1HzDgl0BhuSgqXVdMVSGOA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(38100700002)(2616005)(36756003)(2906002)(5660300002)(44832011)(8936002)(6486002)(508600001)(66946007)(4326008)(66476007)(66556008)(6666004)(8676002)(6506007)(6512007)(83380400001)(86362001)(316002)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mzbqFUE9Dgd2eawZJbcNTEtzYVBPD2aj8vKA4AbpmNrqJqh10W7Qw9gJN/OD?=
 =?us-ascii?Q?WoKrecww1j7lkXJ5x27AqlkV+vepms9kR805GerhplH6rEJc/DHtzr2oTPiR?=
 =?us-ascii?Q?ROYi5pHlCkQXK08if6pE/tx+REq+TLW45OcDfYgoPlR8oiJmoWMN/76BlDWC?=
 =?us-ascii?Q?WfJ+FtSYLCBMQrwYo4TtYeUEb1A7Uk4t+q/R687lVqWHE73qEQHMoXD7T/+A?=
 =?us-ascii?Q?qQv3/0D2yEms7h/SdcbUuV3QVLWzJdjQvGEHn6TVE8qoKny0cb4V5XnNmto5?=
 =?us-ascii?Q?7mtXLnvRnLAUveGqRiI3D4YoRLpoWb8PAh44QUgE9erM89qE1+uzHQpZciZU?=
 =?us-ascii?Q?/cXvlsS1BOLHAB9ty98kRFPdbHtLyOdhdxXM5G3RO1WRkxzOkXk8YcJy/4Iz?=
 =?us-ascii?Q?uRzCIrP2NqRsjg1ZzSaxKxD+l7WHAzwfrgrdAS24H43St7w86Qo/QDyy/y07?=
 =?us-ascii?Q?a0k9UMgNoZgnqftixPIFjEQcQJNZw1zLzavJVsf3a9HXtFbJKJAzHCIe8RSE?=
 =?us-ascii?Q?v5E/hXdTsZlqAhYJe6DFlOjzDqJeMes4fg/8clQBfnKREYq/VaXkKgyUVWbY?=
 =?us-ascii?Q?s0QwUaIMYvIdqCsMJMoRp5QUv+oHMVahQlI4uYVVrcOS2UKpOgtu/Ew9cL29?=
 =?us-ascii?Q?/PgLs30b+LcCnGZx2CaNVT4FwY3d4DWjHZUJC/ffgXUrFocJVht5EbMvBkwY?=
 =?us-ascii?Q?WVmSeEbYuAa6hTnIH24RJ6rAggYYGZQKJlErW0mLDpfV+WEibBNfTe0kRG43?=
 =?us-ascii?Q?giOIMLHql7gH7gg/K9uKbDG12HmaEqFSnk9RZrhUKNqgW+3mIBxvmPwAjS4i?=
 =?us-ascii?Q?ahXdlBRGCJFDzEorFZDpz4SpR/4H/4TNa7oZtTC+W3LloLeimbmMvvYIBeEp?=
 =?us-ascii?Q?7CJJCk5Fr3hMEjL4i9reS80QF3e/KCkNDncA4KFolMmoTWuOCUH5NoZ24gW+?=
 =?us-ascii?Q?RIFA9d76tNkT4Q7Gj36dw5yxD7SiQCiVTU7MLYaUetxvii0KOriEOQy+D/mi?=
 =?us-ascii?Q?kFwglQLULmmItpVnXFT1maEQWjCKxYGpQ6aL44GLGNcSXq/uw6cnXMsMpOxt?=
 =?us-ascii?Q?XiPd6uLkCygm+sAonoNzGgJ6yTRR9kzmC45Pryp2ZNMxlLqTXgAAIo2wNGuE?=
 =?us-ascii?Q?6JDX0LtpeY5PAR0ozpMTvsCMlEtQJpaE2l8TZxW22wKplGlI/NMP5Z6PRt9b?=
 =?us-ascii?Q?U5TcHsgOYcNOHLx4nxpK2AvzfZDXB33/LatiEaa1deNvl8B5CkgAhoPoF+lF?=
 =?us-ascii?Q?RtuBSh9emrvMQuJu0VWHS2H3tMHC3ib4Bj3xj+0/+TyIkz1V7gJ4NA+U2qVE?=
 =?us-ascii?Q?d0c68n9pX3uDbAqpIAr9ElX59R7ixGCwYBNPbJiDyiat7VhknJHW74ZNzf15?=
 =?us-ascii?Q?6gaa7ztO3rnOhRzZskfqzep5HV6UX4RqOTjG7t9jIBn3Kj2VJFGK5OMm7pF3?=
 =?us-ascii?Q?djFwbY9Eu8Iq/80hWbPte6XbMP9ecz38A5Jq0Mc+nF7BHgLXTOruQ4DGC/wY?=
 =?us-ascii?Q?g/eul2pxNhE3XGxQD/6vO4o53a/zLsEq1ka0oHmJy6AO37XU5nepYJQxCnYL?=
 =?us-ascii?Q?yAZL/AUpl86kji4qKILnqq8e46yYN3JURzolpKialtdVXxMDRamK6cOoWa/s?=
 =?us-ascii?Q?lYYdjbO2Oom+cRQmh2tqHnJ35SLq5pHzoalbcDCWPt61MSW0tntaMkZPgkHs?=
 =?us-ascii?Q?1xaH7h5tffFJqLBkW4w73QHELuo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3a6359-9c5d-49e0-167d-08d9f41d1f97
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2022 03:00:17.3828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XX5oPzCAuDWhSwspVjkdSlymfRa6bLsU4cAAxOzF8JO+cux/gsWxxs3002PU/BfzkHMg+YLUTQ6WnIApbTA4/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3414

Rename mp_infi_nr_tx, mp_infi_nr_rx and irx.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 1b8b531c8a87..dfb87794056f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -946,27 +946,27 @@ chk_rst_nr()
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

