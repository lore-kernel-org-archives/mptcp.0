Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2047.outbound.protection.outlook.com [40.107.249.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111723FEF
	for <mptcp@lists.linux.dev>; Fri, 15 Sep 2023 07:44:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JT37CRklZdZEgN9oI+Y9tnZOLaJdEBY+siUMIlv8ZBR6aDI8EwgqI1l/tQoHyI0LZqJLS5pcKkGgiqBUu8+zSkc26skq8LlMQ7GXz7F+5KOvR4r7Wg8rGK12lltzZpN36xfesdvBETEJmuBNFdguwrcwvUKBguOUXyP5xLE5ozr2aY7NuRK1JZgAEkvoSPcDRw6mcaRYvCm0zWEcGmmSjHWpcMjKCBJL6bhHyxr3yGW31aGHFVk75061V544WzXQqEZ9OIXMecqOIxh62Y2mpy8MliC5gjyvrHLMC/9zUtRpxdA825dlZc8xsS+HJFIAAvcJknpsx20UBaZFi65xeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7MQneB/L2zNrKONWwQoEuSa6jZgfhKosCUS1hCCBqc=;
 b=T7d+DRLnBZLN7hEeFQg8bhOYdt88v0664uz6XMCUbVb6yeGZ89PG3NoxRI/hcxtiAhd8GYZX6KIu0WoCm0KsnL7DlpBT23RPlqp9T1dmRsi2T3lA+0JnCOGA3bVMI+JnibtcfDowq+O3Hk8qYu9igxmYhNyCUknvRKoR7zHSrkOwgManpMlMN9UHnCCXWJb0BwjJauEYXw552e1IcgINzgphS3x0nsnd2kDd4W+9EOdZrG/O9LJrLPh6PZJvbWeQ9dzVCgF2onpgXUM+YVtIMrV7UjRbRhI38++zzswjvexrDCTZULmI11YuGryBPrU9SF2v5roHjNANORWyjZpNFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7MQneB/L2zNrKONWwQoEuSa6jZgfhKosCUS1hCCBqc=;
 b=ed6FIIG2NBbSNNgMZSR96OLNH3Dp8JjcWemr/q7fwHp2u2+fw0fvz0N1r6b7b3GQIuAym/HuXlpC6w8G2cTT4EeZ4MzQl3unV/HIBl980qxschiutFsWEsnG1FBpviY9yod68cnbv6zquFneiTpc3u7fbdpHV72i67nNCcWNf9slRpjlMLb1ufuS3Rw/srnOuHo59DYkhpKwr0V8MFimzl89N0KwckIxfmvIzlmPDrhEZgvbdGfQ6iudb2/lpb6boVnEaJnd97iJ6wzkXyjNOWzE/P3iB99Tp9mSyCBAQfbaMT7ELjK7SSkOzRkDFBgrSlNF+d27GGGm31oNE7uaug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB9079.eurprd04.prod.outlook.com (2603:10a6:20b:446::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 07:44:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 07:44:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 1/8] mptcp: add mptcpi_subflows_total counter
Date: Fri, 15 Sep 2023 15:45:11 +0800
Message-Id: <8309187dbf3d14c73ab8852fccfcf46fb6f7b43f.1694763508.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694763508.git.geliang.tang@suse.com>
References: <cover.1694763508.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB9079:EE_
X-MS-Office365-Filtering-Correlation-Id: 4030d6c4-4629-48cf-f29f-08dbb5bfa14f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DDM6je4dJ7vFA1Z1kgClpcO1EY+OD4sHuyO+1cI1paaOmStdy9cUf1ZBxofPlu+JeGHZK75qaLXrslrdn58HpEkHuUkcgODqztZb7Ovw8D+yXprEMlhMh2tlwlGLHZJ8pujeXxOYi9uQexADKvYwCd/y9VRf0rlq3mDo1dY2UModrlynh+bLL6etFpIysy6qr6SUARdlv/V89lX6hx535E201Q7wxRSh2SZwtepTVtuSKi0dHkTE34uvBSifPPxO4MsFVpv6ov/qSN0n961qa9TYZ4IHvQ3PDQTzAFRa/XWzQTLdWBmJp+kMN9Zl2bmQXKOHQbMRDhiIdFhPaZcUAjeWkvbqLjZaYvzj4mUy2ycz0QRVbo0siLX1JpmPhPeK0iOc4RZ6C0i4LYizpMfAdZ3SmvIjRxfXnazQqRbFoLa0QQ267kc/cQ0SolKlQWT2KzU4tc3FYwtmTYL2FbGt7XRLlU/QDaZO7lkSby4h8gwkfr4bfkZQgwTphcdHK4KQQINXvkpLem7z++3J19tiBO+bUfkGunNouLYMhMQ9+vjNNbPE3qleEjWjDD6OX3/5XqNEWz3hPaKnisDjlLAZVm5hXk2iYtJaY8p3C316Dnc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199024)(1800799009)(186009)(2906002)(86362001)(36756003)(83380400001)(26005)(107886003)(44832011)(2616005)(5660300002)(4326008)(8676002)(6666004)(6512007)(8936002)(6486002)(6506007)(41300700001)(38100700002)(478600001)(6916009)(316002)(66476007)(66556008)(66946007)(966005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wVDg8OihvbyV2TdaW390DsCejhqt5cwk8mLJ+ZP0uO5Wqy1eJ0ntWCisLW/m?=
 =?us-ascii?Q?NrFs6WaprrKw79SqA1edv5E8UMRis0mvMcA+LwtrfKleb/8dUvmpRKdk3S8W?=
 =?us-ascii?Q?BjVL2KZ55cBVKWmO6RAeZ4l3aKLSLxgEg+4tEZ3a2Qcx9nure9XkQd9Q44p/?=
 =?us-ascii?Q?59OMYObemSLVleO1XxcKeN5+JdAdMvwLG8dgvDklU5yAeBelqrkRy/YAs1Pe?=
 =?us-ascii?Q?ssIwDH4ac9MIRQp8WLX/3fBTFJ8K7QoPEkM+CULYg+AxHfQVaYJYv9YcGtg4?=
 =?us-ascii?Q?vHq5+bnTTEn2j6o4h0DwfuHzNAEw+Dv1XewHJX+yfHlfnV3uHGbdleNLUt8d?=
 =?us-ascii?Q?lemvSeIHLVZXBnKmc9ZcIT5+p1rPdoGKC8uMAfiszEfvEm+FXEOaYwN2ggNK?=
 =?us-ascii?Q?U8LcjW9c4BT1wfXR3bRK/0WxW2gbAQw/TE9c8NprYOpEZTQtzx9/EZRtyfxl?=
 =?us-ascii?Q?Fqw5CPmkB3SDB+s1s6Z+RjWgyqBoSGHQDTzTUrceYO7xIDX87fF9C6iZKGUx?=
 =?us-ascii?Q?AvfCxgXoNXPTo0wi/ssFla3PdUwUM/78zVawYdu03hk6yve0URC4bE87XR5/?=
 =?us-ascii?Q?HHxTGP9Qu/ga2CaeeyJjUXNvO6wAHKP51Bnz7ryN5ghPmZ99Wp8ga0jRSdxf?=
 =?us-ascii?Q?ywdYkZHmtKoJC/dlbzq/wr7xMpVnk9PqDDyFyF3ZUgayS0YHFownOf2zx1sK?=
 =?us-ascii?Q?rrEHwhxUf2eQxWnInZitXL1fLojmxICljgatbXa8kAlMNG6/rXuLjyLSaaRm?=
 =?us-ascii?Q?WTLbR9U1LkSx59HcgOC2RGb9NoljTxl1ObFx7zxGgA0NVd/QvH4kV7qtiH0V?=
 =?us-ascii?Q?WRLsTMv65iWCd9+s9ftN8LTwd89dGY2vjfmpAc9nWoHGWu1gDKKbgrCaiRWR?=
 =?us-ascii?Q?8/LtewhFwvXLFfpVza9sbaCCxXo7wTGbaga8xSaEraqxov2SJtXR1/AwAHrx?=
 =?us-ascii?Q?K+Msu3Ia3oKlnBqLFRUaE+BrFxI9KBuexfu1PhuhQWO6eMyjp1lFSyqGnTTG?=
 =?us-ascii?Q?YPqaA7mTlvM5lLrdjgaykNeLEgTMPNVCIjHj/IJEHytlK8GwjrK2Ne5rET64?=
 =?us-ascii?Q?XnOyLPrx6zx24DxdsBZRtDdwmzI1d1ZpxMkElOinzBX0H1kP4XDwDqw1J/7d?=
 =?us-ascii?Q?weM+kmS4/nmwr+xlkisxDihmDnamUCJvfqs4YxMov3uE746oyW9mbd+rvy7o?=
 =?us-ascii?Q?dFKeJ2plm1cvsT/FKtD7wJAe8Z5umwb9thh/5ILctnI/Ixx7pjSBG3kuITp4?=
 =?us-ascii?Q?i/vUemzEYeFBfbaS8eDPUjbApNMkVtnU1zuW57bm2UDlLUJTPG25vJDQ6HO+?=
 =?us-ascii?Q?XPAbAxgcan1T2HJvyPM2NSqrHnQgc0MnAhWtKVlSJqjRo3aZePUcvTAGJ3cl?=
 =?us-ascii?Q?aBGpeBgKyD68JllBP9Ohw0d5r47B9857PkVjX5CA86h6cSUY/LN6hvxyIpgz?=
 =?us-ascii?Q?CzGqV2LzganQ5KuxEFMhuLhfkd8ml8QPSVa4iUuep4b9EaD8iZuLh08nCdXY?=
 =?us-ascii?Q?pneUhEAxfR2QLa7ELLkFrCIzhbjmMdmecTi6kZDNC4e5Y0VklglPIEp+x+zf?=
 =?us-ascii?Q?THQf9CmrPrMSuW5gXZOOYSOyXWoWT5Oxv2Ds/EJoFxppjE9Dp9nYqnGDZUjt?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4030d6c4-4629-48cf-f29f-08dbb5bfa14f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 07:44:45.3780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpowbMre5wHMFH/3HgU1te6GDFX4eUrakhxkLsMCcc5W7w3vkOs4eRBvxlDc3tjO04BLNgTXd6suG38cDF7fCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9079

If the initial subflow has been removed, we cannot know without checking
other counters, e.g. ss -ti <filter> | grep -c tcp-ulp-mptcp or
getsockopt(SOL_MPTCP, MPTCP_FULL_INFO, ...) (or others except MPTCP_INFO
of course) and then check mptcp_subflow_data->num_subflows to get the
total amount of subflows.

This patch adds a new counter mptcpi_subflows_total in mptcpi_flags to
store the total amount of subflows, including the initial one. A new
helper __mptcp_has_initial_subflow() is added to check whether the
initial subflow has been removed or not. With this helper, we can then
compute the total amount of subflows from mptcp_info by doing something
like:

    mptcpi_subflows_total = mptcpi_subflows +
            __mptcp_has_initial_subflow(msk).

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/428
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/uapi/linux/mptcp.h | 1 +
 net/mptcp/protocol.h       | 7 +++++++
 net/mptcp/sockopt.c        | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index ee9c49f949a2..f89aaa67f10d 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -128,6 +128,7 @@ struct mptcp_info {
 	__u64	mptcpi_bytes_sent;
 	__u64	mptcpi_bytes_received;
 	__u64	mptcpi_bytes_acked;
+	__u8	mptcpi_subflows_total;
 };
 
 /*
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3c938e3560e4..9259c75d805f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1031,6 +1031,13 @@ static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
 }
 
+static inline bool __mptcp_has_initial_subflow(const struct mptcp_sock *msk)
+{
+	struct sock *ssk = READ_ONCE(msk->first);
+
+	return ssk && inet_sk_state_load(ssk) != TCP_CLOSE;
+}
+
 static inline void mptcp_do_fallback(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 8260202c0066..9998e9f7a2d5 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -934,6 +934,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	info->mptcpi_bytes_sent = msk->bytes_sent;
 	info->mptcpi_bytes_received = msk->bytes_received;
 	info->mptcpi_bytes_retrans = msk->bytes_retrans;
+	info->mptcpi_subflows_total = info->mptcpi_subflows +
+		__mptcp_has_initial_subflow(msk);
 	unlock_sock_fast(sk, slow);
 }
 EXPORT_SYMBOL_GPL(mptcp_diag_fill_info);
-- 
2.35.3

