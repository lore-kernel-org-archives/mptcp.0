Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2045.outbound.protection.outlook.com [40.107.104.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C42B525F
	for <mptcp@lists.linux.dev>; Wed,  9 Aug 2023 07:06:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0aMuXlZBivCTbZ7zCO/BrVmEE2tZgttEJ87YhmoONPad0J0i0sXZJX1aY+mNDdXgSfJXsUJyKN2MW463wBas/RG+197/7beY31WHnC6nufzOB/oDwM4OSH2Hw64C4+nLlYEKbQWqffkET4HroMorbAN9Ra/YqCfXKWqbEjsZ9xf9K6Sj0/+vLY4K12W40U0t3MaSp7LiTyYenLDnW8lf3VMRfsQySTYqOQ0PqukC0m7WM1Dazg74yW0QLVuxHl9iri97D+dhGEoIPsv5GWYxo+UZOHn6VbWSduRw7itBzB5UpDXqxnRE3fEGtdq+cbQwUfbtk9npMJUz7jwXwuPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3lPi5Wik4xxfUZiWXaVI8p2PmvixO+S4VJX7UJgtis=;
 b=NoPZRYIIqVWlYGy1Yx1HdYKxMvhCrH1oDOzDVm0ssOdiY84v8bYUX31rnDGnGjYeE9Lb8JV5joErk99WgwD+jStihk3RgetaAbeBV42+831aA/GRVcPZXdI6ICICSzI/Vygm8FRMly1EdJvI3nkv1GBiD70DvsagLMvrWPvfZXq6TeWllL0gYNx8LRKYIDVpbAhAEfEEi2HpQU94P0Z4GlbERtZ+p52ENK9TYHeIlkmH81TyhSNDy56sVrSEUCXktO4WC17THq5y9tq6gGMfVyS/6JukUzCgN2rdsmp/CgzkGL8y/jG3L4wbVleb8wcq0A9P5LIGfIzg/OHdPE0hBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3lPi5Wik4xxfUZiWXaVI8p2PmvixO+S4VJX7UJgtis=;
 b=tbTHxogtfO1pD+OebptGPCxrWJPOnXkRgEQaKn0zyTEvMVVE0JfdqsV+1TRBGOzbY/Vcy0iFFdHS4zFNmoN55K4Ld15G8YIlHHrYyI0x+SUYW4T8cKIXj+bpKJSzwu/WHp55sxwOkRrqjvMXFD0AzJPkKvTDLNZyRbF/53URHF4A7fhtCDjTKkyCc/HG6YhYlnp+/ZoScO9wGaDGiZ2F+OdoduouW8sRQ7VletMbr6/AsfqieynHKYinTfIEM/1RIHXr7WFIFnSeG4IWUAXtfA7D11E4S4r4B4O0At8hDLxaDMBe4G74M9HW10zOkLcJQTqrQfQYuRobpwzoQO0CDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB6850.eurprd04.prod.outlook.com (2603:10a6:208:180::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 07:06:54 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 07:06:54 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 2/4] mptcp: remove id 0 subflow & address
Date: Wed,  9 Aug 2023 15:06:37 +0800
Message-Id: <03bfb31a8baa468a3cd4001635cd6b7fdc1c8725.1691564649.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691564649.git.geliang.tang@suse.com>
References: <cover.1691564649.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0032.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM0PR04MB6850:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ea84ab-643d-4062-10dc-08db98a73666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a2GiAPOm1UOnv0agUfq+vbyalQIiBMNcjuRnZdEQkZhlr0JKNUSVNxvWDgN+j2Kdg2SSl+E23yft7WxWrF3fwUHuPMtEDQEznNRkZ/ZsIjpt/mIUysOu1sx7KylPGaNJbz1HD+w7woGwrKK278gkFkztLn6Ve3kF/mB2OQrBZoOIkMPaQhxXNJNcrtyYopNg/x3h8qZDT77rvIY2ZHWrxT94Izr7Lq2XQURVQsBwojFuXXpgCsivInRX+jzdkH2+PF8PsM7ARgycGyiJG/HhRbG1eEnxo3+6Tw/hCGKYQteI3L6bFG4OJVHv6pxwo3MfS8+ZZ+ItTp1Ak29C90Glw1dG7E+u6VmqEbhHwmCtA/N6B2JCTC1aGrMO+b1gG+d4ppiL/CaVD2yDv6TPMsKJ4bjShBW9CADNoA4YznoaKGw6fpQgQnIVgeiIT2cfZFajdCIwaRk8ViZ7ch/cch85F6I/+WwaOaG0axrlYNs/aEgP4gz4FLhWPpyo5GVvHBf1/VVngep4t15GiZ7XvsGusiCTPiD0y8jUgmKXnx1qZZ1vL8gq5czABfc1LIpwgfeSlqxvKy2VqJU5HSqMpRWIFVaf4YmxyuFmoTVKBfcSilY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(136003)(346002)(366004)(186006)(451199021)(1800799006)(6506007)(38100700002)(26005)(107886003)(2616005)(83380400001)(2906002)(36756003)(5660300002)(44832011)(478600001)(86362001)(966005)(6512007)(6486002)(6666004)(41300700001)(316002)(8936002)(8676002)(4326008)(66946007)(6916009)(66556008)(66476007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2nvhQ/VBMu98KKmytrjDE5fn4zuxfWPAB8dhpz8KSXBfZ5iJObF3Ij2VGBE+?=
 =?us-ascii?Q?xRlybknqORUr4p4UHFPyCpr/9dCcsrIIVXQR5gr8Ya3LwrKIBwmvWp6dNpp7?=
 =?us-ascii?Q?v06mIZuwUifz/NsYZ5tIHGwRQGwUj8VD08FdzpUqyYe1stMuJev18WevLtQ4?=
 =?us-ascii?Q?ygl2XThOTIwIUDkjLGz6ypbwA+u+7z5ixKENAk0HY3kSKDg2HgeS5zsCdehw?=
 =?us-ascii?Q?tIDmuozrcWlZ2/+MJ+9D4fp3kw5POStpBFFQhHohHora/r4GZvCBFHmKnhI1?=
 =?us-ascii?Q?bz3lM9Fcn+snfIBjYd0suKnek6+1kK7T21FgnwS4LEqaUm2d16j1glMA6IFZ?=
 =?us-ascii?Q?bj5KLXr/3invN/ArPtl7Gv5aEc7Eip73te+a9qMIr6HWkRusWLmgl/0Fl2mS?=
 =?us-ascii?Q?zxkBClqsH1sK0k4PGBOJdvT8d7pQJzuNEmh2sdhX64WVtB0H9AUnJ0TVF7XY?=
 =?us-ascii?Q?70Y8AkiYwlY8LOOO5xklDfaFXLxP/d911goZn0xkjqznr1pIwRINQ+KPrvwD?=
 =?us-ascii?Q?iaYG6/qjttD85oUNMVXttOUFamkZcAoI+tnPW2lqy0/K/SRVDAbRXYraof+F?=
 =?us-ascii?Q?TbQeRl2/APNZ+RVcAyZYXxI/cUanZxdilajsmvWMI3Jq7Vd7iKGAUKRFqTDk?=
 =?us-ascii?Q?mjqh+LbtMw7DZExZiiHaJ0GAW5gTw5hpmvDi2MglvuXbqrpnq3Mlpbj29Hm+?=
 =?us-ascii?Q?31zp4uKQCyfsOtAL+WoTOcOomzlcfAe1AwQ/i7KDuGzaN3QlzXSaVpS9ox7m?=
 =?us-ascii?Q?yOdPSAz1TQcp0LJClPIj+1GG6vbK5xBYs0Ne0VPT2XqzYNALoad6pXpJ3zvh?=
 =?us-ascii?Q?otYyenYV5EOOZHcC2R/yqZ2QURZg+mhaxkr+Xm8CWAvCvFSAm1esGBq8BFyU?=
 =?us-ascii?Q?V791TW7dMGAL3Ifx2ku2lhcVhVZ4vBJM2bM4Ka//RtjiWbqQUgahCZ8uDQHx?=
 =?us-ascii?Q?CxcM8VVMCfOqsXj7u07afhOtmkA6sN/MPSzMw/u6ugTNhYTx49y9p6EqJ0aI?=
 =?us-ascii?Q?vMN6U8HnoyOtQcxkqbTK3gUgrI7OFbPtXgHg9cx6XlVT2TK7AFVQs6VYx7yg?=
 =?us-ascii?Q?iw9FXZZRXoaBtbfUYqZlEn/jwnwHiB496OKk/LohI20+vraEp2FTIFnmCtzr?=
 =?us-ascii?Q?fgNzHXx+e78++3nNMruDdAoshVJmQpO2CH5MCCIQN5RX7KC3IOfRUjLKQfoE?=
 =?us-ascii?Q?agffR6Tu50dWr7Ac1reKh0HtJCUvXyFW8VPd1g7RNM2O5dVezs6+1UmoN8Go?=
 =?us-ascii?Q?m6Z/9/MDdNCa6wxXfn9PUP8V2C3vjRWvjij6RlfjMULztsoMrpxEntnfXjp8?=
 =?us-ascii?Q?G1iz1tyu9R9hbpWIE2zkilN61YF42xVfkH39jROh+xstWBWnv7fVhPJPlusW?=
 =?us-ascii?Q?kntYX1NB5wM32NO7WR2zZuF3eXJPKV7+xIurWn3xYPnyWMkj7z943HDI7D4p?=
 =?us-ascii?Q?krm3FFuC3ks8IE4nh9C4IhUM1lXtXJcj/OxTzenguhpNX8Pl/Z7Z462Vz5Le?=
 =?us-ascii?Q?TaMNfxpKs5SDatVN4m+phakRf7pQtDhB3jy3B/NgtMNzHuvIKAiKy3a+g7fL?=
 =?us-ascii?Q?OztqhiLgEyKolIL7uenkwRWSm7UMn4UhXkKBZi9Z?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ea84ab-643d-4062-10dc-08db98a73666
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 07:06:54.5590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K3ixOAo+Ob5owmuadilVNXj47+dz/v8I6lHMSnt12JLmfVP46bM7Z1jRHMs3y6vx9vWW+Uzx7I+8NRfd9qZdkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6850

This patch adds the ability to send RM_ADDR for local ID 0 and the
ability to remove id 0 subflow.

Put id 0 into a removing list, pass it to mptcp_pm_remove_addr() to
remve id 0 address and pass it to mptcp_pm_nl_rm_subflow_received() to
remove id 0 subflow.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/379
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index d042d32beb4d..38629ebc4ec6 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -239,6 +239,21 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 		goto remove_err;
 	}
 
+	if (id_val == 0) {
+		struct mptcp_rm_list list = { .nr = 0 };
+
+		list.ids[list.nr++] = 0;
+
+		lock_sock((struct sock *)msk);
+		spin_lock_bh(&msk->pm.lock);
+		mptcp_pm_remove_addr(msk, &list);
+		spin_unlock_bh(&msk->pm.lock);
+		release_sock((struct sock *)msk);
+
+		err = 0;
+		goto remove_err;
+	}
+
 	lock_sock((struct sock *)msk);
 
 	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
@@ -399,14 +414,16 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
 	struct mptcp_addr_info addr_l;
 	struct mptcp_addr_info addr_r;
 	struct mptcp_sock *msk;
 	struct sock *sk, *ssk;
 	int err = -EINVAL;
 	u32 token_val;
+	u8 id_val;
 
-	if (!laddr || !raddr || !token) {
+	if (((!laddr || !raddr) && !id) || !token) {
 		GENL_SET_ERR_MSG(info, "missing required inputs");
 		return err;
 	}
@@ -424,6 +441,27 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 		goto destroy_err;
 	}
 
+	if (id) {
+		id_val = nla_get_u8(id);
+		if (id_val == 0) {
+			struct mptcp_rm_list list = { .nr = 0 };
+
+			list.ids[list.nr++] = 0;
+
+			sk = (struct sock *)msk;
+			lock_sock(sk);
+			spin_lock_bh(&msk->pm.lock);
+			mptcp_pm_nl_rm_subflow_received(msk, &list);
+			spin_unlock_bh(&msk->pm.lock);
+			release_sock(sk);
+
+			err = 0;
+		} else {
+			err = -EINVAL;
+		}
+		goto destroy_err;
+	}
+
 	err = mptcp_pm_parse_addr(laddr, info, &addr_l);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
-- 
2.35.3

