Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD5F2CA8
	for <mptcp@lists.linux.dev>; Wed,  8 Nov 2023 06:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ren62/5J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5pCAL7B+a1d5nMNjtYnH8HtusOHMGEUERGGWSX5slbjBZY9m2kbrMQPEoJ7dkUkpFUXIgBqzFf+TYDNleze5+2KXenIUcoALfpdFIW9VLrVThu0J/ApXj3stHYMjs5ZAQqXn4IKJ90l97FIt/380PZXo41F0GJ/ySyHW9Yc13X2AS60KrjKhWy+Pt+2DbGqFjwbAzIuNn9NYtTNPQGQA6Dlp+Cin+k7nXK7oUq0gZdUcOHWQvWeqcYVt13KI2j4SSM5UwnDURZsoYKRhXJ/gVbakjshC1jM8d59LrLDtGEXUrp5DYhK+06UIHaU8z39UTL/S1zE/UBm7BjQnGtBTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sx65YAN9kdex6GGyHYp8vMQfSQoElqK4D5eJ5zgy6A=;
 b=eUOF/BCyJ5DluBWFDQAKLTnoARxaTq3Rgn2lBrZyWD2dxlwnBzMt44NGjMcgQnrRNV9fHuINb0RQUGyW8Lm1RkArh/kRbfw9jEid/CH5gNTCfSx2hGXbKZubZiwpjppFqw4jzfPVBzLmrDpjz1idf3N6d7oYvCDrUJxxJXkFza22jQAN4RHKS8GGQu5lE758fk2U7OOR1bGjsmqJi5X7n0UgyXZ0dg33SPgY1n2tmsbW0LzO6TMVBE4a1KP9kNp/dF8fxNi0yZoxtixtHDmgao2gSnLmMbfAKYQKgTASEwRsVsmMnwALIEU7dJ4zLgTgYhCpeDQ3EwrihVDBBekKvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sx65YAN9kdex6GGyHYp8vMQfSQoElqK4D5eJ5zgy6A=;
 b=ren62/5JD8BZTNYmk4gn77CkLCgLah+Nkz2Pj/u1IYZSPdyFTPGxm4m7wQK7rOaHi6bLlTRFxhdcbTteFHI4uIAk/+fdwnQ1q7POfpnjXy7GodX7TmXO5qBNE2ymYyrba9taCkv49/4zFY5V+GqbuZayTfClrMnIadiTdxymRG6NG4sgK+PXXNea6EADuHNAVu5TnCn1urV6cDReQ3X58FoIR9OF/WEUk/w3uK0vor7X/rfv0rqw3tI+7ceOW1F23OFQylhubk109EgDBfK/IwlcOIoIxm3dWF/ZHfoU8mO/oR5TiVxM8jPJjCEJdRsVpqomVz9M5qg/ACMoFfiD2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8803.eurprd04.prod.outlook.com (2603:10a6:20b:42e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 06:50:22 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%6]) with mapi id 15.20.6977.011; Wed, 8 Nov 2023
 06:50:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 04/22] mptcp: add userspace_pm_lookup_addr_by_id helper
Date: Wed,  8 Nov 2023 14:49:34 +0800
Message-Id: <44f22fd1dc0664a8653b0d76f703563a9c3ace1a.1699425895.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699425895.git.geliang.tang@suse.com>
References: <cover.1699425895.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: e28fdaec-04d6-47f9-5e28-08dbe026f9e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j72Z6TFFHpneIo0GQmHdN+YWauTsVfLHWbhJJYwDFeOdPrtAyTZgTa+bdRJg01Yyd/L9xyIjI84Kb6WNb5X9BC12XeolFunFdtwCqQ5T8mV5Chfx5KTImtPnJpKbR3xV6ubCqDq7jzXMpXkY4gYkQIaK5fJ7gli4BCLyW4E8O7csDgY/Mz5MtGWiE7GnP1Bx6LpE1X5gdpd1kBP3wgpmhGUWBn7bdzM8to/iYIS6arcyXYMkiZ0KBbDuFuxKhM6Lgnk5BpsGnPSDJfGXAUwc3PjzXM7obuXci0oNhQvrXv2BzFk0Ev3enVT7RUF8lPaPc88diTXxUizp5AvBzicnf5QA3uepiJ4cUHuq7WHdo3+sTr3tMU5FJ7DtJ7u1QXXr02l7VAF4Q1oV6Paz/4ug0N+LbD6qodQaQ7WZjesUd6nNr18E3fQD8JRAn+ewunUz52bUJWHWbglnWE0UAiwVyZ6VT7CmYZDfs1OhzklXAczTMDAlv+RJclhnfkcpc46q5113plEy13aJcP+GjlmLoRUqE+Rp1knWx1SxkoCP0+hrELhprtaIwzN+UaJ/kjwjZvCW6kz0dWzVuE2lj1ypAuEw6PxmvCB27C0d1Khsrqk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(38100700002)(6666004)(6512007)(6506007)(478600001)(6486002)(83380400001)(107886003)(2616005)(26005)(86362001)(36756003)(8936002)(44832011)(4326008)(8676002)(2906002)(41300700001)(5660300002)(316002)(6916009)(66476007)(66946007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZII9PK21cMJkDNs2YdB5Z3px9d4IEAl1L94lOHiwh8F2khHvri4gpog2s13O?=
 =?us-ascii?Q?8w5fwwvbDXd2lYzwuTTvFDHxmtbXZH8B5hFmRoolNgmX38U6Ol506G0bRToq?=
 =?us-ascii?Q?VHTF03Lk/e3OYxN18PmaN+4rW7y0oaEVUdAN3noVsn07xFLvkxDyo+QIA6M9?=
 =?us-ascii?Q?4ih2oIv/NZxOUMxOPlzmGSbHd1LwmO4XSyScKkPmnxdHPVkymEK09bUndO2Y?=
 =?us-ascii?Q?SiVTdbbAl77mUUU8GurS/6JXUUq96Mssy8Ts4hopWEZjGTqlRYB8r02Rl119?=
 =?us-ascii?Q?o/BI7t0xBJdR4BFNdWZZZwXZ7djc8d3QIgaXwdVZxdZeJVhfX1ULFk51aoSr?=
 =?us-ascii?Q?8aqQ4WXuNE6K1ppFzsO8ZEvjPDM2nbq9yCNUigrzK3ibsjqZ85n2dUrjbaZW?=
 =?us-ascii?Q?5UwiHJzvcSuXZxRVCYAngqMLFKU1Y7ai8KX4U4ri4QUAr2OyUTnfysIKj9mo?=
 =?us-ascii?Q?BNTt0jhnLNd+ciFHXCjFCTKXJrgh/xD3S5/CDh6t6n0J975zRb18UURzhWO2?=
 =?us-ascii?Q?I/bVLvm3xOtmlpeaNNaSXlM9b39JuOejc0m0aQYTYhXLMcGeefa6j8a+gfLR?=
 =?us-ascii?Q?7zPjxRE5MB250myPwwEcPu0tXZUOR1GGFB/p+wAX9CtxPxXAKoJjMHS2rB+d?=
 =?us-ascii?Q?Kx+TUclhfCxEhxNP/a1nWyHQkKnmMve/BS8E4DOaDocwM3okhMLWj1sUkzIW?=
 =?us-ascii?Q?S21EGnNLpVJMOz7kb6XyMxPLmIj1c06wSADByLSDJzV6siFndIhc/svd84gq?=
 =?us-ascii?Q?R31LI8SR/LDz0MkCG1c3Z4DjjsPXl4Mok2renucBrBno9XoZJcO6wpp3g/+P?=
 =?us-ascii?Q?PqsDNousflwaNc1PiE+qxXDNNNEQvVeS/We5OXNoYh1VgrTGcJpgHvU0ahan?=
 =?us-ascii?Q?mows4OtGsBY7zglAwA40xiOKFeeNMQwZ1US7zffXdpolGF9g3KaE0niMLARN?=
 =?us-ascii?Q?jE6KHrr8gzB6qXdR5f/1MjNXtsFrUX1gnKZ5r6qFkZUMv8szsAOdBXVOh4vN?=
 =?us-ascii?Q?n+C0FvT/FpErBRvisNpLkLgTnwRr6JNVcH1Re3WIcYJof7vYZM2S+I7G94vc?=
 =?us-ascii?Q?6b7b407203CxaPEd7laikHYIsAFVV4kRP4/WE+xteK68r0InKRjqzX7xELtm?=
 =?us-ascii?Q?KnUCLmzoTsCP+Rtaq2b+Vz2Kx5GqbI1gDaMEQIUE+BEOkHZ2xaNGywCK1JMs?=
 =?us-ascii?Q?g5hEdNLlepWjJB8hAsD0Xmt8EkuUVio21c4G0IVEIg+2IWJaTHfvugKwS7HJ?=
 =?us-ascii?Q?h1z9kqkwqrY/4/V2Slm+AZ/HW1xJNg1OwmCPnCwq1SSbqsPMlbUcENmWHHYy?=
 =?us-ascii?Q?2gbtAfSCuEiOtvH2VFJz1k0fMlsg3M7hv/H53adKxXckUfvkW0s3esTFMYoh?=
 =?us-ascii?Q?EaVD0dbhOdtYVAmRrDp8LdKwLGthmef1cXSRCG2rtp4UwRNVMDkZhTMcnwzf?=
 =?us-ascii?Q?vnBr9JtmNaaOFR8X/xeR2CIhiSgzhCq0oY0iRdfWpuXH7S049D4+rDUwbNiW?=
 =?us-ascii?Q?McoTcElxXp5S5e9pkFs99QsfoOqE9SYQaRA122c/GZinqrDy/umKhASQQgID?=
 =?us-ascii?Q?u9+K0bUehJtimALO5jKDmknOJ0h9vqF+gXuYGRrMY4Fom6SMkYkIaIA7Pmun?=
 =?us-ascii?Q?mQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e28fdaec-04d6-47f9-5e28-08dbe026f9e7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:50:21.8992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6kJ3qVwedGZwiT2+wcetxvzx0dC5c8ys44OtRdCT1vBu3Fu1qGunsYNn0MyjW4mDvdekzCFuqNDKm81FKCyPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8803

Corresponding __lookup_addr_by_id() function in the in-kernel netlink PM,
this patch adds a new helper mptcp_userspace_pm_lookup_addr_by_id() to
lookup the address entry with the given id on the userspace pm local
address list.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b3a606a5e182..6999296cd5db 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -25,6 +25,18 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 	}
 }
 
+static struct mptcp_pm_addr_entry *
+mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (entry->addr.id == id)
+			return entry;
+	}
+	return NULL;
+}
+
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    struct mptcp_pm_addr_entry *entry)
 {
@@ -107,15 +119,10 @@ int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 						   unsigned int id,
 						   u8 *flags, int *ifindex)
 {
-	struct mptcp_pm_addr_entry *entry, *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (id == entry->addr.id) {
-			match = entry;
-			break;
-		}
-	}
+	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
 	spin_unlock_bh(&msk->pm.lock);
 	if (match) {
 		*flags = match->flags;
@@ -247,7 +254,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
-	struct mptcp_pm_addr_entry *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	LIST_HEAD(free_list);
@@ -284,13 +291,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	lock_sock(sk);
 
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (entry->addr.id == id_val) {
-			match = entry;
-			break;
-		}
-	}
-
+	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
 		release_sock(sk);
-- 
2.35.3

