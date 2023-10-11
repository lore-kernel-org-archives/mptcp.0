Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2084.outbound.protection.outlook.com [40.107.7.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A74C1F928
	for <mptcp@lists.linux.dev>; Wed, 11 Oct 2023 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="loeUqTS/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fB8axuVBy30eG0r82c2FVmWSsseLSXdYq8hDJUDr2lupPyln8QNwQf/9ugdQQo9SdMLOGeDrnhUD4VFovJaA8+UAiKtVHiLL1m9ovR9xoapGgnYpAFs4UIaFTC/Mbo+Guq6DSteB3VEfBfC4TOchHRqGSnyibVOwsFJEh/tlWn4G/HUU+f75gAKFQBmZv4H3FNafrPEsWn5A8JzxLZ9bgU5KmtyE6z+EauaqaG8APyj4zo9BzyjQKHcni9KYBJ+NKYvSYVip0PchJfxvDNkVbtRfjaG0WRfFZbpz2xusQ/E/7K7dt+gJPLaook1mjhlqpG1ntAL44WQvBFyYv0usOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59Up5/dh7frhV1A7+7v9QalZdCarW+2Pb/vIvQG+bh8=;
 b=XJcxmicShUVBkeBtTSnegAFYZxxjzLA3AZ3ou+31WAVBbqTgRIr7z938AIdqsFNdL+k7Yiij4AKYVt6kLHKBLMhTfYtc3kyX5KLqFkfkQo3gV3tIofW56NJKJcmCmoHFcoBy2WnhAYFrxQ10QW9O/Hwsue6xQ+ju23AuHxuO/xn0/YiAIZn+gaDBVokyCiJzjJTkGnwQZjxROCvQIVrVkXJf6EBuJZi0fMnZh+nFeidF/CK6+KXbPgPG7CSR5F/2sSOQSV6GSX5fDSXeDomss9qRbSIv3tAjN+cOo9Pjqp1hjzlYrR8KwVXf63Al27V31HJY/S60WzhryMFWh5N8gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59Up5/dh7frhV1A7+7v9QalZdCarW+2Pb/vIvQG+bh8=;
 b=loeUqTS/vwGXAZd7v2LrGbx/CLFJiTjYPEPrli5zqjoF3F+jzqVK6xN8ngOE4/kV72MbKoTott+gocWZgaIShdHW8gJDscTjEOzdJMQd9GNLWu9Q9l4cvr6+wLqHPpKiMgV1J9qe5NMGvQXTaKq6ZjKI5a2sKo+rdSRptO/b4/nFSm3LXs8/JUUuPL1ksXA0/cpxDTbe7mG6BCKW1SQ+pQ5fXL0iKTw3op89LK9t1NyfhxegXvSubfXkiIkmAhnxytDJ8bt72HvvI8lBKN25lPkVt9EX8rvslpvoFzyPpimfrjDIscbkfCm/clX73eVmTCXB8utS7uQ5RWzxgpzDnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9139.eurprd04.prod.outlook.com (2603:10a6:102:22e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Wed, 11 Oct
 2023 13:34:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 13:34:12 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>
Subject: [PATCH mptcp-next v14 1/7] selftests: mptcp: join: correctly check for no RST
Date: Wed, 11 Oct 2023 21:34:56 +0800
Message-Id: <b83722d50b969499155ea45ebfb95faa164ca5c3.1697031190.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1697031190.git.geliang.tang@suse.com>
References: <cover.1697031190.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9139:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e7067a5-9307-4e31-825e-08dbca5ec199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	No9Oms6TadJ0rJxovIZIBdJjkadWT3F4v5UABlFMrmGh9e0XLcSA2Dsfx8u36Lu5PV6ajMO7ow9OBR+PauqJRpbqfzRDNpbzubljC0nQJ5dJ9jj7G/PfAcFLQet0O3C8Z77Hsd4FNiLpcs6d+2OjlT6pvHQksmE3WaPP9LPB+U1tIDnG6u4D9uHRz2iSBcY/1+LQzlqUhuExuUcxTdqA8+fC4T1meqiyAc0P7q6PpXkb45votBc+aN+p173OtzvMZxbTTp6v6LicXnSS9fTyTB0W5BP/RaKWwoDOeQde/7Vxa9BSf4FkU4nsA955zz4yVS9Ii+9veu9IU7JEkV98Cc68iPK5AHt3pyNg9jyaXizXrySAVYQM4at0CNZM7kBmOugw+WSr9WzG1QBaPXNAEB/e18KpoKAeRvAQPUiqFLNDMhsmWd2yvIAxy5CFX62Hhm8IQB8+DLcrixDlVYs7iP8icHXpbPFdeQzvphfgSu76YClxExrXRBg0IUhTJkTeOBy6ly63kSmA5Sn87zxwSiHpDJJxip51hLX2/FTDoMVPDfcc1OCcBqT32euVcMg1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2616005)(478600001)(26005)(6486002)(38100700002)(6512007)(66476007)(316002)(66556008)(6916009)(66946007)(54906003)(6506007)(5660300002)(44832011)(83380400001)(4326008)(8936002)(41300700001)(8676002)(36756003)(6666004)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mp8+Uxa7eF/OlfQFqZVTfOiz3Dlrhdwnz3WEDvC+9m3+TVoOFA/15WMvzf0X?=
 =?us-ascii?Q?njn8xt3DxDORiJgadKO2xXQNp/jVIFca50XUJzUWc9iU52XOpU85xCcc5zVe?=
 =?us-ascii?Q?76X9dQLdGNKKcilXPL6Ej0f16od9q/n2zQe0C06wKBigDGKV8x+xB/SkYS5T?=
 =?us-ascii?Q?8pz0qGoeyIlJqYRCqrHFduDD5i1YLNRh12ltqBfeBAORUenlvep4B6ztSo37?=
 =?us-ascii?Q?W7fArYRDIvGq2nImMwVvmt3DDpRDc+QulAbQZH6xrBy3NI5eWiXsErkqqqwP?=
 =?us-ascii?Q?gpUHfoo/g9Rfn/6Ml4VtPeQLxcq0Nsy4ehkBwVZR3Zw+DMXUyxN/xo0eqEW3?=
 =?us-ascii?Q?Pyq9xlUmmHw0ap5dr+rszToLWXajbgfs05dFSEf6dU+60F1uf/uq+DebihPv?=
 =?us-ascii?Q?voadCtbkMegIeqAm6iUFsT4SIO1FylXLwAYHKPkKP55CHBxIMAJb8u956CUf?=
 =?us-ascii?Q?cmNjRxi3mZz9NHooDwveJ3c+HlqKy37zoK1PvEljkRouVH3eicLGyK788tGD?=
 =?us-ascii?Q?rJmwgCc8Y9fHlFGzAlZYs3vxSLOavLhihmT4rizw2QqQOTsjUJpDwpNGNTli?=
 =?us-ascii?Q?JBQ11ESVTj8bzXoHK+GcwCEcS2aoMXgBFyZkTagcOc684JN/VQzZhxcFGaDY?=
 =?us-ascii?Q?D3eNyIynRBtWKsH4k+FngW13CB8VStXRYGY7moXdWAu+/3WSKDGc6lUL4ZhK?=
 =?us-ascii?Q?LnwBt7uhkJWRRel6012FKYH+5nILF+enK196o46QX1VWY/vyhaRJZ1bzW2px?=
 =?us-ascii?Q?YE+EmIq9Ms4L/zrwygskyrz0Lgx90VnPBHk8thETYOIyc8rYJG48Wkaf06As?=
 =?us-ascii?Q?Rh8pheESyU7GePDo6KAVcwO4MpWX8B/dRxVbDbAYYvXImWrylk2hc7Zr0o1y?=
 =?us-ascii?Q?zi3PSMau58oWc73+vfEoxdFD4NmY61T6lOz/ROf5RzDMLBHGW/zGiwBaFx5s?=
 =?us-ascii?Q?O18A5QsDZ/cMMYX8iRkn3FATDx0KK6jz4puTglONwkCBBdBVybYkMljFVpKH?=
 =?us-ascii?Q?N32ltzFFPhLzWTijzDXqbzALV3Fr7C1ptfVQd0PhNk6wCiJhbtD4b8hMTUqU?=
 =?us-ascii?Q?8jDGt4e4r9v1B8KpugBXKTaWFWmcfP9JxzuJCNUoeTUC2S/zw93xzb1lRP2v?=
 =?us-ascii?Q?qDG8073DKUsNM3qxsTaaqT2bxQoJnaYiSBhMI7HBnphTjhiEvUF11TKvCgim?=
 =?us-ascii?Q?doxQ0gh5vzYEJ9IAWbdJvbfdVDJBSEt48LlXSroQS4yaSHGKV6NoRHdzXxrh?=
 =?us-ascii?Q?2BX0ymVQxEbDud4OWg1crkSbuH5Twcro2xlLJoZU44Zd+rLiJ+/VduHHEBan?=
 =?us-ascii?Q?ZRcjOp9DXoD1BQHkszZRKEKpvro9SYhtVI+sIE525SIYpoUC3ueoBGJWCCAi?=
 =?us-ascii?Q?Y1z3nR8enWGkFVl5VqX7yd+N4sj33E/G6V4YsIodZQIvuOoacBc1xez0jbnI?=
 =?us-ascii?Q?/ZdqqtvzKS5/84HG9Yzu7pXQyKGqjI//NV8aC/UzLMHzfUFG6RM8JH8/YXrt?=
 =?us-ascii?Q?eeNfSHkgn3Z8F4rM1DafPfAVFLK/X36ikkkPz6NpWuToolt4HY9ICWajEeg9?=
 =?us-ascii?Q?bwTChTX/3EBp25zb/GC4WcsDF3kCYJ0sZEJs+/r/?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7067a5-9307-4e31-825e-08dbca5ec199
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 13:34:12.8785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5KgZxR/Dv18gLyDBxGjCwpM7KklcLqspf+2y/TGBaoERGBAnXWmzFBSEHEOXJ6O5qLE79BsNGVPIMV76gzRd/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9139

From: Matthieu Baerts <matttbe@kernel.org>

The commit mentioned below was more tolerant with the number of RST seen
during a test because in some uncontrollable situations, multiple RST
can be generated.

But it was not taking into account the case where no RST are expected:
this validation was then no longer reporting issues for the 0 RST case
because it is not possible to have less than 0 RST in the counter. This
patch fixes the issue by adding a specific condition.

Fixes: 6bf41020b72b ("selftests: mptcp: update and extend fastclose test-cases")
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ae38b428e42e..01480663c102 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1432,7 +1432,9 @@ chk_rst_nr()
 	count=$(get_counter ${ns_tx} "MPTcpExtMPRstTx")
 	if [ -z "$count" ]; then
 		print_skip
-	elif [ $count -lt $rst_tx ]; then
+	# accept more rst than expected except if we don't expect any
+	elif { [ $rst_tx -ne 0 ] && [ $count -lt $rst_tx ]; } ||
+	     { [ $rst_tx -eq 0 ] && [ $count -ne 0 ]; }; then
 		fail_test "got $count MP_RST[s] TX expected $rst_tx"
 	else
 		print_ok
@@ -1442,7 +1444,9 @@ chk_rst_nr()
 	count=$(get_counter ${ns_rx} "MPTcpExtMPRstRx")
 	if [ -z "$count" ]; then
 		print_skip
-	elif [ "$count" -lt "$rst_rx" ]; then
+	# accept more rst than expected except if we don't expect any
+	elif { [ $rst_rx -ne 0 ] && [ $count -lt $rst_rx ]; } ||
+	     { [ $rst_rx -eq 0 ] && [ $count -ne 0 ]; }; then
 		fail_test "got $count MP_RST[s] RX expected $rst_rx"
 	else
 		print_ok
-- 
2.35.3

