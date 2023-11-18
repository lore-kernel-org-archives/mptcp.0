Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2086.outbound.protection.outlook.com [40.107.249.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D03B18C2D
	for <mptcp@lists.linux.dev>; Sat, 18 Nov 2023 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="yJ8JRx4J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBrvR8aF0r9GA4L4eGCM4Vx3XxJGWMuXr7Zme3PhAlVwH1/Sg7P5GTeIhjs1jOcSHJ+hNTfHqskV9My5CMiTXd1ysMk6sw/j4IPuaPaMcjmy+GVKbHKzeAkGJ4C+I2ErO0XbPmJYV/FtBhSQWUoP5rM+NwXVxt/oL0myA6Is2+vrpeXRI/jd15jpHdxV4r0ve0Q/5lq0hUwRhZNFQktGATkB4f1rvOmEnwcpSqVNbXMOaSIlRNstSGjW20rkzILCsi3OGWBGeClp/rBTiGTG5dDiEjmXC6UbOPOgiR1aBrHFbatL5KWCvlXJ6rohpt7z5YKCXEZ9x/sE1lQK7G/GQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Brzt87Fl4BH8p6SL0jvXnzx0uBHrhqHlIZ0YCvWHn4E=;
 b=BJvSVPUjrnX1y1VIWZKTUfgRTzDyseN0iswt6FT/ciZVRhDgsNY2zY9UO4nSReIYYUBpM7VpgFMZVLozLB/DMddtFweciuzMo5MtzhRhYFpRMR12jqb/lZ4iujLn8meYNeQvUzlnPxgNy8PTTV24uGFjUHWqPh7ACrpo3HOxShyMkjIa0idz9ut24tpRf6fhkuE6aB+EA/HGydX50iVAimkzkyRosDd3MyQs0rGcgsnDwvr+w2lKWonAOgeYkWsN//hACOUoLKA/sT1h6WtbB/EZ4acM3e5S9sTWT5xmc9SBH0NHIrHmwEwondS66if/vW8k5qttvWOpLJg+/Ev/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Brzt87Fl4BH8p6SL0jvXnzx0uBHrhqHlIZ0YCvWHn4E=;
 b=yJ8JRx4JcchIcjZJNgtXUfTWMny0l++OHcJoqm1WUhjQoM9r/RkR9vQO7Qs8SD6zuhGklPdX2EUJR5X3g10991J/MKY6andw+3lo4Rx3KOijySKpjSCzjzYmFqrs571pjv5YzulTDFe5MGMswESv84AWEZsz+3YHlRLXeDFsTiJxnnXNAusjkfQ9NfBEX4XecSGino3/zNul/Yg0RDcsNg6A7E2iPsIIi/r0CpFp2qwxYFxTZ91hEKceAvPWUJLqWRWfUK0FXfLCbyzqful6cCwVHApqBY/stNjeq7LY1bMFucG6SuWcWVv+GqwJ8FyyqbaC9Tx4ysTFdAMUgm0Kbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM7PR04MB6869.eurprd04.prod.outlook.com (2603:10a6:20b:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.13; Sat, 18 Nov
 2023 14:31:13 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.009; Sat, 18 Nov 2023
 14:31:13 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v11 17/27] mptcp: userspace pm send RM_ADDR for conn_list addr
Date: Sat, 18 Nov 2023 22:28:32 +0800
Message-Id: <761b5a47e05c59729f0a761f796b6d25d919eded.1700312872.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700312872.git.geliang.tang@suse.com>
References: <cover.1700312872.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096::13) To
 HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM7PR04MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bbbdc60-e354-45b2-a17f-08dbe84303f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AbL/ml2KKuuLUpWSXAyxzH0ZBC5ZD8LaqNt4irAj+ymlSDAsVKvmX/8JfIYcFtCzcOBKAY+KF7+GMDKtbuBl10eXnPdJlsRrxhJVQCbps3hEFgcYG3xOUCvs6Wtzf1BRKsrVLbHUkJml0TUAMWOM//sz89BvpN1pFmZtt0PP7JUqQTkWCI9Jp5FgDmwERIJ7GWo1xRVtpnCIUA+3GPSMTkZgozoIb26+VN9PNq0c9Tf/g7xwfkN4MNDwPJnO+5jrZbAqaC8+J7EIBaOlp641PaQp4RIzhjVvEPZu2mZC7evSbypss7nOa/tc3LJ7a/9Wp/TZDz/CQ9mQTiXcGqF9XHee2Lii7svKsx6d5i2KXxhKrf/v0L7F2Tv26NU3uUAEigpDeWAXYdNqxDrmWHIs9Sl0VcSHJicUn7hrvwH2IGMOUl7wabULYv+HyMrxLftds/LhaS7w1X2AXb/rgdyiwPQgDuVpgBKQM9VQLK573j0+dke+keyQw/bm8pIKBu4Z1w5WSTKDzRXo35gbDuSemuXhrwhgIOflL9sFgm503iMJIRWN/ZwLFxxoqcp/S6yhhDkDzM/I4OTLsu5o0l2y7Tg39zt1z9r4bV2PLuLjPjQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(316002)(4326008)(8676002)(8936002)(66556008)(44832011)(66476007)(66946007)(6916009)(5660300002)(6486002)(478600001)(83380400001)(86362001)(2906002)(6506007)(41300700001)(26005)(107886003)(2616005)(6512007)(36756003)(38100700002)(6666004)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BquQShqN0wPyZQsouEVXfD/Udz8qgdrD/dG9pEfKxHVztP9MCMTQPl+Mjua3?=
 =?us-ascii?Q?ibKR8qZ9XOOfPM6I088zJKD37kXCbFI2BH+AHSoYvWxL4EcZnE6vnUJidt7e?=
 =?us-ascii?Q?S4SHiczSkF1AUlVkxytVayJBXAL7/w9HuAxOCqdd6QQVBbXyqtuxnAVAP1Yj?=
 =?us-ascii?Q?I67mU0e09Fogj1OrD31p7eeii3kkmYqt3yU3U4Lo4p2AUho9MO7cmfGp+gx6?=
 =?us-ascii?Q?Y72XjI71uZ69wHJFSsn97bJ63mAig3WcxYv8t28q2hZU0R3IeRI9efLTn24F?=
 =?us-ascii?Q?tpvMcLSITLMcCyYZmG/cMdoFbx+SwC44XrDX464hwuCAiReK68/YmJu22lcL?=
 =?us-ascii?Q?n+yNguEb8XI2H5Hm+39+zWYzVD6ME9f9gn6k0R9M91Xi18kUamyxINIdCR3b?=
 =?us-ascii?Q?DSxmCNyxHpgWRsxITAr3r6w/AN+BOug9XMaPqk1i5s2iZkHO6Q0g89XPAimw?=
 =?us-ascii?Q?lcHpk+u2SolKvCBBWOyyt1c/p8fU4hlwRli8QpCnNKnvOsgzcejTctXkqVxx?=
 =?us-ascii?Q?SDkPf0bIxdJZRbVjxrUxdptfdciuZnAPbabz3mR/BpjPB/WM5KFKObjWzwzX?=
 =?us-ascii?Q?ecbQ8KxTCo+FL5fOxLFQFKGGgGPJXnzhKUfPu0prK28DjmIUdW1rtvfpvm82?=
 =?us-ascii?Q?Q7EGB06yQg1H04jCQpBaCo9TlPfMPk37m3tqtEZMM3F++Za1gJC5B/2uvo+b?=
 =?us-ascii?Q?LVMx3UlHAVVw4DTq0i7Q5Hsg9OoldzxroiQTAktZS3YE0Jiinik7UQZcNfCW?=
 =?us-ascii?Q?+4i+ZQLgwqzRA57Uk/g/ZZnZ8pNL1vhtgOMuY3QvVGCAijJRQ3sVI0pPGhTp?=
 =?us-ascii?Q?4E++R0VVV4AB0xLN32OpotSvdaXJXTFO+ptn53Y8+KXcC2G0nP8r+Oou/REj?=
 =?us-ascii?Q?Jg6RF8UByOkw05z+zkK4LLj3MHnuU4arjR6wMm8td+T0qUV3NpExOLWkrQAQ?=
 =?us-ascii?Q?oQiAhhAaZfu470dSwARK5OVflzXPsHfgYTPk9DfJptYR5d6D7bKokrtpW1tV?=
 =?us-ascii?Q?VrJlmeqjN/Ene8FvzJo7N+tqVT9jrAMQmtahSNJN8G1/fRQMUL3BesjY7XdJ?=
 =?us-ascii?Q?LFlAOH0aHYv3AoXk/OZCXT4QKe6vf32xeqDXFinXa41lgQM62Q8pi2CATpwB?=
 =?us-ascii?Q?ByCWAtUSzSY1kMZR+MXUWmeBRMbmgiDaVABdhyCXh7KNWZEiw4+Mew15TCaB?=
 =?us-ascii?Q?E3aFeHqacXzwz4iSrW9S8fw4I3nZFebKq8vmhrlabqJ4x5qKVyl89kkgxHYz?=
 =?us-ascii?Q?vIEhZ0QTlC/3i7JMz3zzqS0ykONCMnsHUVm9NiNC/Qo+hf7lwyShXRIntQOp?=
 =?us-ascii?Q?ck8VJnKle+Wqx+jMhj5HMNxMnaYJ37v/3phvwYUu+aUClnkWYXOy7QCxh4lr?=
 =?us-ascii?Q?7fYD3VHwDOFefb3jPH9pnlYjx2EDmIB/s2YUU1LtLlRb+dkb2BHfK//XhHpm?=
 =?us-ascii?Q?lzJfqkxwvnN/RVULxdFx9c9gVueHNMSSlGe6gbm36Wee5MOvtl01+hZ55H6n?=
 =?us-ascii?Q?bfJlW7t0I1BH6Jr9Y/5vBxEJIw+i60mCEek+g56orhqLgIbXOpT0O96FcbWC?=
 =?us-ascii?Q?f/cLLzDpH2fiWgQw5RrNQu0NYJ7TEdpG8rRnDSMTwHzThFyErMfwy2pQJJE3?=
 =?us-ascii?Q?+A=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bbbdc60-e354-45b2-a17f-08dbe84303f3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 14:31:13.1042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vl4gELYOgsUaTdnfsXGF/3Zdx1w5PIkjhH8X5RfljQeNAnAXfD6gbzDMell9dak2LA+xtBKXgjrBXrb7urHYxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6869

In mptcp_pm_remove_addrs_and_subflows(), userspace PM not only sends a
RM_ADDR for the address on anno_list, but also sends it for the address
on conn_list, to keep consistency with the behaviors in
mptcp_pm_remove_addrs(). In order not to affect the in-kernel PM, a
userspace PM limit mptcp_pm_is_userspace() has been added too.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index cc4ac206f848..412c6621592e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1500,7 +1500,9 @@ void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 		    slist.nr < MPTCP_RM_IDS_MAX)
 			slist.ids[slist.nr++] = entry->addr.id;
 
-		if (remove_anno_list_by_saddr(msk, &entry->addr) &&
+		if ((remove_anno_list_by_saddr(msk, &entry->addr) ||
+		     (mptcp_pm_is_userspace(msk) &&
+		      lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))) &&
 		    alist.nr < MPTCP_RM_IDS_MAX)
 			alist.ids[alist.nr++] = entry->addr.id;
 	}
-- 
2.35.3

