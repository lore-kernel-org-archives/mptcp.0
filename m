Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309FA1865E
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="k+ULHaZ9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2CIUTgUAPqMkIhC+o9dSe1lZ+TtqRdeMCQk+rJdZc01ktqt7Nkd9so8z1FdU7mn/RDltYPX7pMga00RsIepkffuwanRI9t9xW18T51hGBRRNf70BxOCjqWMkp7sdxqnSiplo94rLT8zhp7DnyQ8O8k2AEGmW/yGjes1gYwqILZ8Mfe7mNdhNyIlsTHfPBTNWyRD99vSLaq098LTigNl9zHXTMoHXWHxBwG15EmjK+XcHKx3x4G0aB8lOlF7olXHom7VIK2aW9ksIcwVAihoQKK0cjp7sghwPG8jjZyBTLafZYv0+taM6/8/mxpzmZ346tH358vbAm+uIRBB7siOMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ky15XWBtA/4dpY1pWmdvI+JIciuSmIx+xXLtgq6JwBA=;
 b=X70GjfN/lZA6+BHw7St8XCSBp774Z9pOXSNtWYsacHujon7brJ+F5vWbhCMsTilUQIMgqH3OkUFFf4i7L1mvkPUftngr8q1baNw3771GxkXy2Lt+ys1cwZcPhOQgGeKxjtQYl+vdfyO5efEw2STlr0Xb01BYJT4+Y/tu8rwVburUfcO2HDdRUxqR0P3R15q3EtHlfLSr4tbxzKyWD+bl/uvs/tBQqA1Ol0GB7S2I+RJDyQaqFS5Di4exyYVCAid/aYujm6JNxxrHVQ79DnjB3JG9GXdLmTxryjP+mAbMipsqmmp+DwJlN1jifuDSIL+7K/Ag5g33u3CrIA2XO32D/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ky15XWBtA/4dpY1pWmdvI+JIciuSmIx+xXLtgq6JwBA=;
 b=k+ULHaZ9om+OIs082ag4s5aJVXk5kwP41COSvwmpvjf8fkwDk4ByoG80qE0etCJu9m4LUlYHTlDnqyxzUsci+AW4Y5Cyb5JMpOKahyt5zO7repWD1hg1nSxkVzjOMY1G+ic6ZMporkyLgM4+Of4yS4sIlAjHffc/GNSAzfbRWZXSrmWANP+i+Ae85a+YI4RfdXfUmrMbpYgSSbPHeIm++f7DH33XA3Y+iftdyaaAJHu6YYwkF44f7FQ6J/WAH2r1S/wbHJvIK1ZxvX0bgzokL/Hee9XzJItF5mbQGlK8CiKqgemjUcNbPX7jfDl8Yn5L53BzP5LJo6m3iYPprEWyCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9104.eurprd04.prod.outlook.com (2603:10a6:150:23::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13; Sat, 18 Nov
 2023 14:31:55 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Sat, 18 Nov 2023
 14:31:55 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 24/27] mptcp: drop addr_match and id_match
Date: Sat, 18 Nov 2023 22:28:39 +0800
Message-Id: <b99bf211aa43fd448086b2d916f38e5747717d7a.1700312872.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700312872.git.geliang.tang@suse.com>
References: <cover.1700312872.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0186.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|GV1PR04MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb49cf1-2971-482a-51d6-08dbe8431d2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c8XnGxoLqACStQJfz+/qy/u5zZKshWCsDLi2eKhZOw+0X1dr1b36ZjKSXZRFFaNjF7FkborUJQhR7sFCEGmEdKHsBLvgATNfQCvxCiBOpnzHxMqq2Zjl9pJr/WF2yd/lDN6Y2UCxy6MYxRQJDe8vrEJLXji4C8XYUhwdV2h2+HCHIrf2SHK6IpmOUKr8jq6tbNmFwbOW6chMmilFLBy+n7ioSuGSpGOcEPwx5ZCzPIG4ucwEGczf7pkniWVMbBeq0yL+s32Y+jZHe8UdJCuw3o23wq4GW0IuhmRJ13AWkderxirE1ydZiuwRhhOeh6D6WoY3er5SmJcPH4ek49ERNIeFj2cvrR3uzFlYRZcThgw3rh6NAuy3J/iexHyiyKlTeSn6Wk66EbleZ1DJH12l8emDO/JuA9qAVyV/zQHAQUz1r6lmxnA3/PQXhXc12zYpNZ/HiegzA4W3CeLltb7bTUttj8gLkJjWPo3siHruKj1Jm0mlWi1bVPN2454Dd0JZqRCVjofRUtMeluw/hMFwcUi/6J9LqvlAsVNuTjzQ37GhY+riaNQVK19I7ycPHreJizeX9d70Uct9i2S4e4fD8stV16AhVcSziZ/vVRPrLkI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66946007)(6916009)(316002)(4326008)(66476007)(8936002)(8676002)(6666004)(478600001)(6486002)(41300700001)(36756003)(5660300002)(86362001)(44832011)(2906002)(38100700002)(2616005)(107886003)(26005)(6506007)(6512007)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4eZe+C5lkTUvTRJLTGcDYS7wXE+TI+3+3wKSKwvxTxXE/2k+HNhFz9ZfToGi?=
 =?us-ascii?Q?gRPKx17LSKFyaTnAILkmlEo/MYkGpKMbN7bNnWLZGkZjelHM4EWCY+7Hqc0U?=
 =?us-ascii?Q?GaJ5Kvf/JiSBe1gF38gdsUmbnC8fFk6BYyKEpausqgE9cvtIpZdGWIhD1h2M?=
 =?us-ascii?Q?3HqRYs8m0VFftp5u5/lmuYBXsA5peUCunrm/M1yqQrWYDnxNXHspAbHetTnz?=
 =?us-ascii?Q?NL3XFIh3NydtVqZsY25yQhVIVLk+BhzF59yq+TRSofb9fqVz3fwTr3RtS+nN?=
 =?us-ascii?Q?a7vU6CgR43cRXFeOTyBEVXavrTsA8Ds7f0Hzy3tTPvmHMuHZLNRbuViAdq7t?=
 =?us-ascii?Q?iBUL8/NJw7/0eT3lbVi9/g1wjK/8z6vLQ4oe+aGfG4FUUQRlxaox/Tt8x1QS?=
 =?us-ascii?Q?7dNH7ZrBU8nNrSUwX7FPv7NqZJmifXCnNpNbjl363p0DS0xpJQT/J0q2/69o?=
 =?us-ascii?Q?G+hRL+AyM0AyuDc5xT4ECb4pHM2kdVrSvyYpasiIdWsHbiVyIq6XliUww8zC?=
 =?us-ascii?Q?cHvJFT0/430b0gJwxNr5scCWiBSQXrKTSqkzwV/jSqQhb6PF6+r0oKWAvnj+?=
 =?us-ascii?Q?HHfJbh9GxqjSXYgIySxjuxdcXwv+QwxmItCsDpniQcWyc8lAjKjsMrPqNm5H?=
 =?us-ascii?Q?ZyBURikks5i1XVpC46kc14TNLyhMShntA6T468WFv7W2eASio/PdQ9noEQXY?=
 =?us-ascii?Q?Gich6T8go8y8JLIQo6nQ3aqzrFdIorVfzhUpLiRmolmEesf/kuckc+4pX1Rd?=
 =?us-ascii?Q?BtfcijQjK1M4nrvgZmusVbF8D2j2oYqg5BN7a4xD8MpTCGP+5aG/XtJhF5OH?=
 =?us-ascii?Q?3huOWIXs1Zgs61JTNMVaqUeecD/EFTNR2+2W797fN6p2Rsnv/DXm3Z9Q+PWn?=
 =?us-ascii?Q?ikWLT0aK+iMgmTayy9GCxvWQ8PRy9DqZhFRug5mooNlKxD+KUqEE19RNGZTC?=
 =?us-ascii?Q?KCVmoTTwsrcqUyRZlQZniNbZhJ5b/On8Bv91kHGTvimbGHb1nqHe/E1+nIAf?=
 =?us-ascii?Q?mFLhvmNhSrAhW6JJswya5y3QKnkux5isw7DuNJPj3hkQozvHS7YxfcUNZ3bP?=
 =?us-ascii?Q?73J8mDeKhA6W1IxdsQTCPRqD3B5BI3hIDtuBC3a/gLF4PkMpFGAPQlTxJ1ql?=
 =?us-ascii?Q?KgkIddWE+h3bi1XH9L0257uhJuR6fdOC2pFx+kB5pHKe85i+c+7ppflVBvWx?=
 =?us-ascii?Q?ImO1FNcCN+v6XkIUhxEYyydkwotsJTjyCa3FKAGxhv9qUgyZEsKcQwiWABpA?=
 =?us-ascii?Q?gQ7bzAy1BepmtOQF5/0RXMfXUZmCnAPCk+fdIvGmD4aPDC00q8Z4c+bLVD6d?=
 =?us-ascii?Q?t4MHMPpLShTUIpcDFbALzDRzFzK8lEOf7+4HoPaNuyKXa3eJNGpPLD7XPNuA?=
 =?us-ascii?Q?dae8mjYYwDaNRcJ5BQJiI+Lh236cayTd4mzQsDRai74AVHrJqKPPrZ+UCne5?=
 =?us-ascii?Q?uDayUcjrw/qZCmBBEasDvGRUmZSBow1RLSBZqaakKubPv6LTY3537AV+8yGd?=
 =?us-ascii?Q?mfa+/o9Znjf/Tlqfd/RM0qzoBzNJjwyUENhhdLioRaMLXQzZ3zr/YVKvo1Qu?=
 =?us-ascii?Q?ZqutKjgVYqEmL9oCecItDWmLVQYyxTNtJaDi7yrs0xtbs5IWCpP2Vv5T6mA8?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb49cf1-2971-482a-51d6-08dbe8431d2e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 14:31:55.6066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iORsexXwzxSyc7anuS7Bh0BQsyJdJV1nanydUhCR1rXQzXfsc8phYqxMYN3Wd14oHt6mjxnG/5fgW51ak5j1bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9104

This patch uses the newly defined helper mptcp_userspace_pm_get_entry()
in mptcp_userspace_pm_append_new_local_addr(), and drop local variables
addr_match and id_match to simplify the code.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 255cb733c59b..af9bd7950fa9 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -60,26 +60,13 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 	struct mptcp_pm_addr_entry *match = NULL;
 	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_addr_entry *e;
-	bool addr_match = false;
-	bool id_match = false;
 	int ret = -EINVAL;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
-		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true, false);
-		if (addr_match && entry->addr.id == 0 && !set_id)
-			entry->addr.id = e->addr.id;
-		id_match = (e->addr.id == entry->addr.id);
-		if (addr_match && id_match) {
-			match = e;
-			break;
-		} else if (addr_match || id_match) {
-			break;
-		}
-	}
+	match = mptcp_userspace_pm_get_entry(msk, &entry->addr, true, entry->addr.id);
+	if (!match) {
+		struct mptcp_pm_addr_entry *e;
 
-	if (!match && !addr_match && !id_match) {
 		/* Memory for the entry is allocated from the
 		 * sock option buffer.
 		 */
@@ -98,10 +85,13 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;
-	} else if (match) {
-		ret = entry->addr.id;
+		goto append_err;
 	}
 
+	if (entry->addr.id == 0 && !set_id)
+		entry->addr.id = match->addr.id;
+	ret = entry->addr.id;
+
 append_err:
 	spin_unlock_bh(&msk->pm.lock);
 	return ret;
-- 
2.35.3

