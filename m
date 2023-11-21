Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8913C090
	for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Gz3hrVqN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZL1ZFFcl8iyRxhgVHDk3BPltaccZ3aaExDE0Q+ZiZHXm+u1DPmDEpm0r9SJIURK54hvMX0cZIT9wZmGbpLAMw4xd790y+RsbB5lisEUdMJc2ipEHm1hEytQJCERfMnDlL05ULytS6W4nFIhcUtNRsapcYr4xyeb/OifAM2voEHCc00VUGVC1juhJC31hGGEx1FzVV2u3P7vYmoyVoAwzgK0B9pT/GfZPheerZnPvvzugCD6dGW2ksYSCL+9MjQYfH2HNEoUCwo8PzTh5Oz9pGWMF4IL2MgDVxu0blxX042ReNOgmQNsebWNYtQDdBdqS6gZwut6CDyksAImWUXIHmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFHe7S+Hy0deBz2+JZd2T4avlxaVx0U1hIAvevaw8cs=;
 b=C7TNAZzFzbMEZGWNjmotYj1VSXPXjfGTOh6Q9LO+PjvCiuIIEmrxcuhBkOlbvlNimnAc4ZHeuYSJbAm3all9+P380NEneeEhvmSwioDgbhg6HrfZGNaF52ioDAFWCh29iMZ2qdHHwPlKrQNn8798BOOJVtOvCce7CyeHwYVeoUCYNOVUL5XbTRLwdT4LOWBC3ygjemyzNAll0Qk/qCqIPxjVyxM4e0SSdPs8uX6WpTNv1gcC/kA9RK9GHIpYxLwZJGJNIKHRyFTyM+rex8sieZGSWbtEygwB6tzlFXjlVU1l5crmzAEo9q3U5Vyhbx63kcXcnEToRZAL7YI8UtXiWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFHe7S+Hy0deBz2+JZd2T4avlxaVx0U1hIAvevaw8cs=;
 b=Gz3hrVqNyiFFrKy+HphYgGKhjTHLwg89J3fd5Z3+PxVm9FopIT5eDPec8YpXz4PsB+b0utkNGNbqCd+eJYFSZ8PZC4UmAbXQ6PR6YcCC2rGmi0ewdqpqY5HPQqiIEe+HDaK7+lJmFCpIQDVJJFnOrzEMQrVk821F9Z6HVUJfOwgrS1Y/b3NY3MzimwxOzJgY3tnHDoOkPCRTJY6QSjr6bHJiUabRHd7pPp5p9wxy+gYBKHScZApuJu3KqgYtZGL2rXAh1V3R/51HFw93vmjoM2b+k78DrSjCPQVH23subwHt8d4UMkWouBEi2UDNdwyWhxSUoWHKKXeeCpM66IiijA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB9667.eurprd04.prod.outlook.com (2603:10a6:102:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Tue, 21 Nov
 2023 09:55:34 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 09:55:34 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v12 19/28] mptcp: rm addrs and subflows before free local list
Date: Tue, 21 Nov 2023 17:52:42 +0800
Message-Id: <8b2e711211e64562cb3492a563489fb6e128e304.1700560046.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1700560046.git.geliang.tang@suse.com>
References: <cover.1700560046.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0012.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB9667:EE_
X-MS-Office365-Filtering-Correlation-Id: c561a720-9026-4291-f09a-08dbea780169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r0REWCeYgdgUtPsTJb2gTIuasL1fapi4aMZu0y4zT6Vvzsir0P2gxhY8sjxpIdunTrmtWRU0xjP225ykSanjTwq64iI5BviyrfhQCGxtq3IiPTL1Rx+6dfejMwyXCa7u8lJGrC9SoumNi7V20sTdyIhr4FI1gpr4ISIzcDHjoLCpgEYXTZsx+qo+Gx9xs0DBBebNTx2X6wk0N9HsJcLCyS1aw+2gbwQQOXTMvQjDkO2OXj9PpfhFJpP6eATwQO/oe8i9IMaYSAIDGzdq1NRXWiKWbQzTYPQl7jD3b6UVKWI/Z5pQoDTLZBrbsBeGKprg62a8CdBPGSLQz3hpFQgXBF4w53PWsD3X4oFQSSD/C7gVugF9hohCR2wabzr2HC6Q+qeigKDECrYYPPjvupCzx4R5YGIE7hha4dlvt/fcYN0At5OIYRgztVsIQP6JoZoQebGWZxAgEQiAcduZEHBeUVTUT9ZONimVJKHQl0mztPgeik1Al3WHTOgq1/qwGlHQ90flH94DaGamFR/7xFcjJm74kjvJrnavsfzWZ6lRZYIgVHoATC0qTUXwDfAEm5N8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(6666004)(478600001)(2616005)(6506007)(6486002)(26005)(6916009)(316002)(66946007)(66476007)(66556008)(107886003)(6512007)(38100700002)(8936002)(4326008)(8676002)(44832011)(5660300002)(2906002)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JCKbw62MEsS/C/sjRHHC1YCjEMXoGzcG8DGPvkTW+QGPfeQeO/UoSWtKigtF?=
 =?us-ascii?Q?60h4ybmOSWhgjdroy0enSw0UUC4Oz28ExF9KYcpW4O/J6sazak3t1Fjzy+x7?=
 =?us-ascii?Q?CewESHHQuNj389r48uKb/0p0nLCH48RsCKBnm3qtYzDEVoESYIkCLbExoFRh?=
 =?us-ascii?Q?ZSuB9ibfPLMyyQONNHyv84ejm6rrUyjPlvi9aAUBfCoQsxQDg1t0N4zS3r4c?=
 =?us-ascii?Q?boPu7XxnjQnykFmfO32zHBxMSpXLCR01zN+7QUqPuD9DxFgcnPbhFbbBi29A?=
 =?us-ascii?Q?mue5RORGIAYF1NiLt2U7i5GARuGqQY7zo+QkiMgiBn7e1uCu759kZJvEDEns?=
 =?us-ascii?Q?E5LpCq7jCcfnQIiaLsYCTmrV8pAGag1o76IQfh3LAmI+jk4ShTCBBnZzxFIX?=
 =?us-ascii?Q?U2FuQeLBhMGohBRXW8MrrW1pqZO+iK7IWIy/A3npt6CeMZmS4JimdUi6e07E?=
 =?us-ascii?Q?Vkigm0WPqw3APrOLyc1uWDWG3xl4mMr7CrjQpON0GTXAcUFQx3x6za/ejKfu?=
 =?us-ascii?Q?5r+QMKzdnZERQyHxF8jKlFgXtGrIPkEPslneAh09hP0yLSCKi7mZPICrztpE?=
 =?us-ascii?Q?IZ5bh2Zyj3Y8R7vsBz7mL1Oa3YTI7FKGtmhlXvvncRWe7jFso3S1j/U32Kd1?=
 =?us-ascii?Q?4WObaE5sTeAX89yR+d1wSnlpzKFBwmhGKKXbUTMa3okahtVIPjaN0gpkZI3V?=
 =?us-ascii?Q?RYIKmwZQre6aVNuhMZHFFmyGKbAs6j5WlnGyjYNozzCHVoLwqqn1z4twdGPU?=
 =?us-ascii?Q?d1aKNgdjCsIBq+0yRCPHRUkz2g9NWhqR6XoWTSuDIDkF5x6lmtaBfYkvPBfu?=
 =?us-ascii?Q?4cjTaUv3CGqo//USYait7kJ6dSlW+bPpglNdv4fChNABpwOoA9EwQz1kPvtb?=
 =?us-ascii?Q?Uvdl9R3PT91bigmzUuRAwxyj6KLk2rtum2eOfX/bQq95bCeu1bFvHvFE24QA?=
 =?us-ascii?Q?v5NfQBGevEFvkIZzTf7wEq7n8jeJP4IMwZsK2gL2FL0OhfesC9Ii+fJa/3RT?=
 =?us-ascii?Q?GOfLV2kcpWF/EcYYlWju6C/YOXCQ+JoiubQKabnO5NPBYgNh2ZBngZ5LF3t4?=
 =?us-ascii?Q?xWHxq3jVGVALm45YPArwfrpB54znWli2OMBaU2V2fE/aP48awinWSB1rnD5N?=
 =?us-ascii?Q?12X6P8zttknFBQ4FZ1oq3QAr+CmDVP0W/SXxzLiA8WZ5wDDoqgBMS8krctgB?=
 =?us-ascii?Q?FnE4b7Bjjb8zKUlkvlvZayhUYG5VFI3gmdh7lIZenNY4j1NINuRBE1YfMDR9?=
 =?us-ascii?Q?YcEwy1z3avE5ubxBvUJfcP64QCiM+Hkm732wYUIoFNIXUeL11IireLNZWNtw?=
 =?us-ascii?Q?4vIL/cptCC8UyF//RdiLfZZZZqV5rIUEpU1T3ljVWTC2ezmh5qbCz1NTlvVN?=
 =?us-ascii?Q?yvdmbei84rlSbUnNITGGcIjukuZvPqCMwWjzZVyHf6PqoDrIEUE9IQivilTQ?=
 =?us-ascii?Q?os5mIfKZfC06n01fwJpWA28AAyyXpmo7Uro5Y7s8FcwVqzrqqYk5OPZXFY8Z?=
 =?us-ascii?Q?e7QtVBN3AwdgZxQLDjHDAsJ2LUkWbe1xHb3iIdC3s9wLPw/2k61/gwd8e5Pu?=
 =?us-ascii?Q?wSWrGsAim8fiTNOU6gd/Xv46k17EDfii0dmY7dTT+wSZhFpgeFfhLVKNcJTt?=
 =?us-ascii?Q?PQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c561a720-9026-4291-f09a-08dbea780169
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:55:34.8629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YIp3eqZS02fmiu6eGf+X7BXIJY3fJ+gV4VysRybf46t1y8Ke7F/foJjMzyoDS8ETvwiK4b9c0z6cUezxvcIP1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9667

Before freeing addresses in userspace_pm_local_addr_list(), RM_ADDRs for
the addresses should be sent and the subflows established with these
addresses should be deleted.

This patch invokes mptcp_pm_remove_addrs() and mptcp_pm_remove_subflows()
in mptcp_userspace_pm_free_local_addr_list() to remove the related
addresses and subflows.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 87cf27dc1d0a..674262face65 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -20,6 +20,9 @@ void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk)
 	list_splice_init(&msk->pm.userspace_pm_local_addr_list, &free_list);
 	spin_unlock_bh(&msk->pm.lock);
 
+	mptcp_pm_remove_addrs(msk, &free_list);
+	mptcp_pm_remove_subflows(msk, &free_list);
+
 	list_for_each_entry_safe(entry, tmp, &free_list, list) {
 		sock_kfree_s(sk, entry, sizeof(*entry));
 	}
-- 
2.35.3

