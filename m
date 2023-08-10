Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2074.outbound.protection.outlook.com [40.107.247.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092DD1E1C4
	for <mptcp@lists.linux.dev>; Thu, 10 Aug 2023 14:10:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqVO4nig0piM/BLH+KpSvah6wNTb+RicgS7zrU28u45saNAJLiHNvN9eAOlBgIWWzPVmzxV1MKR1DEMkWM/r1s9qKFI6d4RFVjK7c/TO8bk8KfOs8Bl3QLmUfNPqHBenyk4Qu7jrILa6ovViFDM+uZG4I796wnK6DSvrifzwRvu3avDjeX1HSFz8h8+cJve6XwJRcgXkWdG8j8k2EwLA1rJP6RDf7pkEG6c4xwjLeJ7255HDLmg95kNUbx0et6PUU797Qd/hZ/63pGV2Sw4hBHZJ9F3mmy06uakglxa1FYfIIdkEB+MRhY0EyLC0R5SjhpbGjZx8Y9Db2TFQXx3rVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1vdmBDZM4ZFswTr2xyq2ealzjM+vqkCMBfYk4LkzNw=;
 b=QdzuUWZetu7yKUaxIXeSsZsqymvwbjoq7YrHfWW8vhhLya0Kkf3PFRQ9oXNL43pP9lsToccd5QmiZtpltHVqgy1ZuhWy8q7J+9BqzXFhqYp1E63uqYzgrVFwXfVDgOX4rpUYv78+YVGnMQtP3hn0AEmQTSWtok7bh5J/0ZolT6oOmHJ+2+070nXSfITGluFSGJ5z+wrLBfYYaFt+26yRj5ZKc+/t89ZU14vbH640c+U/SCru/NzVoTWeRw5Ky12Udgn0naV63cybDcPEeWVMChp76kHgzmrJRYB8/fGYoMRCViRpztMcu8Ifm2bOllfVCiiCvbLbgEXsE573d9xhiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1vdmBDZM4ZFswTr2xyq2ealzjM+vqkCMBfYk4LkzNw=;
 b=Auo91tv6D/8KPAlSBTIiEEKeG0nQcgAkuIbDu0JwhFYj6y1Agx45XOQ7RJpzs0CThJWaFc30XUiBfbff4aAVdunpE83eUgvTVNqmEMwLxtcl8f3V0pyHNGqIA/nLWFHacH6OtYe1PaR25m2kHz54+JhPmK7HC0r6nzeb+85GljRdVWw02kW013Yz5KmnLVBETQHlPacVrxe2BPU7rIL4ZsB3Iard6LarwHeQg1xmxGnEEWCzIhlKv67rdi00Hy0SFG7UhpO/i8zCz5xbVfwgv31KhmVx38H0ax8bK5+FMvJw/HNk3hC2c63TP54oIBm6sEXtNUXGa8Pn6qwKgyGSEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB8314.eurprd04.prod.outlook.com (2603:10a6:10:249::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 14:10:39 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 14:10:38 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [RFC mptcp-next 06/11] Squash to "selftests/bpf: Add mptcp sched structs"
Date: Thu, 10 Aug 2023 22:09:58 +0800
Message-Id: <77e7674c9f045d3e8c0254fd41d7fe6764aaa7c6.1691676509.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1691676509.git.geliang.tang@suse.com>
References: <cover.1691676509.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:3:17::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB8314:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e22ff99-e5c5-4b2f-98e2-08db99ab92d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sH/5uM2IxsHI7We8Aw51ujq9fbpMv3frwcOrtkqXqAu3t9DCvVGbHCoPg3sYq3OzdxKEdHc3OLP5UtixqfZlaj3nW7vR1Q3NwZ13uYflsPkkaBao5zVZzERXXp83eCL4hfBwonpyXzUHUcyfONqm5ZRAczGlBoNTLi9jlr0Sqq4sGe1DB+B2vnOFRAAdXV/acPZnZvfJ7tfhZ8N1PhtS5/Xvjv0189IFTxOWZpMPwciOJBPOOcr/BKuPGpcuaCIAc+9EEtTZSlIWCbxDz5RXxFaq6NOBLJAjfMuniGxB1UT0e/px6r31VltW25uQlZJjfyCaS0OVrva/Yzr7T6SuBWSQ3v6c8+iLgC45swvqdjtkaN+X2HFS9i+QL0OuKl2KKqxT5+aJBerjggKyDScwkSUgEFpO8KGi/Yn4V0ySKRoLGdte/ewAldUogMtVglTzrJLWUffrGdBiLfNg/n0IAO4IKgJOC1v2ktBHhxWEg02gJ/PfTw8//e01+XC5HW3z8cQAupsUtKGlgJqDSHA2U2EV3+nlJMwtZnbucrwcizd88zPj9Gy6QqtEEenQO58Yy3C6QzCi4ifQckW+dVAm5mlBXyoamil3vLJbhwvQdyc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(366004)(346002)(39860400002)(1800799006)(186006)(451199021)(36756003)(478600001)(6666004)(66946007)(107886003)(6916009)(26005)(66476007)(6506007)(66556008)(6512007)(6486002)(4326008)(2906002)(41300700001)(316002)(44832011)(5660300002)(8936002)(8676002)(38100700002)(86362001)(83380400001)(2616005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?scJhmfoiwCskDOZUU8GNagysot4xzPLI8cjWw9UW9H3gyZoSF5FLYx5TuanK?=
 =?us-ascii?Q?A9rdXHYBnbbdBmF5z1O1N90qT8zCjpsCVjHyax8CuiU/aVBb7MgRNNHpmh8l?=
 =?us-ascii?Q?h7jfu0AuqCBY7KF+R1LNFlaSFG8XoSDf7dBNDKP/iXb6XteYRktW2kgDmAZa?=
 =?us-ascii?Q?mNrD14LzP+TPZ4NgNP92ClymJEMk8zxzBapSLPeZobxg2ymcUjrha/bCUidz?=
 =?us-ascii?Q?uMDxyw8hpWxkdZxKZ+IgqvZOfSAXfBUZuIraaXMJ+FonMiKBB1n0SgQ1Uy2b?=
 =?us-ascii?Q?o35+jmaBFMcVxbpvJq1qa3CS8LEtSb7fCNF/5K62a9rXk0mf3YNMerylWLqZ?=
 =?us-ascii?Q?ZpBgSOxUhhn8tL15vMBbf8bPcLFjgqLIvpZykRxx8T2BlDNO832qeuuQbjtY?=
 =?us-ascii?Q?Q6wQZ3LMu6ujOubn0TaEefw6OYA8UTB+DZNs6RvkFNmWhk0lbI5gc1g8qdXF?=
 =?us-ascii?Q?XTD1e8nMP3MIwY6cTTPS8lQhAZbL0DoL6G3k8/G7mUdxqoIL4SLhsaikQn2z?=
 =?us-ascii?Q?8M0kg8TxOkdg+h1XB0lUb20TxYNZcFjE2JAPwSEayJZJSzMI3xh3IrJeo+yf?=
 =?us-ascii?Q?3k44osXJZ4eNpiZaYtpuTTkdvzHt7vS1Ebf/p//ZKAyDswRVotei22ysy4yY?=
 =?us-ascii?Q?elHbcbiWjVDWmINsOmXcoKa6L7zI1Hs+6D7/l5waYpN1rKxhsZtYged/TGvj?=
 =?us-ascii?Q?vrmeXA4IMvAnBw0uq9fUfKsGKPfSGbrKJug/+j+KpYXcHg7bMcMmxFinQ9kO?=
 =?us-ascii?Q?9Qk+iKJyq62fhKpDEBQ1JAgfoDZ+/cP5wXqF5jkVEGOKHZUtAD9bFkHziVG2?=
 =?us-ascii?Q?jLKD1JGD6uqcVUPNoH/wISk8+tv58ynpYd7CpBcMQTR0ChDBi9gFUWYqVyc1?=
 =?us-ascii?Q?M8eGoJCj5US3i7800O5dR4yl9yYBajeBngIDL/pvFFHP4dGqfnMeO59zVGNo?=
 =?us-ascii?Q?PaIMiZFQQw8s6dcVzaRf/C/5OI2j0L5xA5vh9eF/90TE5zuCqMMmiE7vDrD/?=
 =?us-ascii?Q?iiyShP5hke7orrzD3tCRipdiN+pIldARMRxj1sMDqqDcjvl/14XRe05NHOJV?=
 =?us-ascii?Q?iar4Y7ksiqeiQshbDqPigrjNNoXvZZQt7Jp3wJhb7uvmBt8SPb/5k7+9ue4A?=
 =?us-ascii?Q?tX6nOQKajd/ftHUQNuCygKiJ0k/mFDKkez6xtaRBXBZ6WKEsojQQrYQbEzId?=
 =?us-ascii?Q?mmNVw10PbjDqqJR3mR1UKZ4nbY6d6kxnvUDMW9BfrPobQvZ5+frGRBy11kcN?=
 =?us-ascii?Q?xf+FJjRlCsy5a8WCz2obBDRUxj970/q5Z48cZGDTmCZLzsDm+5EweTTxmRyA?=
 =?us-ascii?Q?3fx2cRMy6IBBMwRelI/T2oJkYvTmqXL4HTcXUTLqZpgw0FBzf/JkucWuUbCL?=
 =?us-ascii?Q?1PQMa/wnlawzkJeMBGwLZsTDXYdbDh8NtHdEdGQFjbaeh0ifvWFlqRcHoCmy?=
 =?us-ascii?Q?H3uItPBvTKV81MVG2ErSu7PzBQTvkWukahBHNWokB/KaUgrdAHKPU0Ixo+j6?=
 =?us-ascii?Q?zi82zpFsmxCiZvXLZP/WsiZZPZNBdCLrm1GpNXzovkyicgefy/ByLb1H12nG?=
 =?us-ascii?Q?nGSPcUcd74nsitO0VBbIlM6pWJ3qeVgq7/O21lwQ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e22ff99-e5c5-4b2f-98e2-08db99ab92d1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 14:10:38.6984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+Wch6QaE4kZ7SPvxB+Y6wHukwJDeiPWC7UkURe1gIbKcilfijYSwXUz16vgaiC4u83wKVRSXG80oVEIwiPcVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8314

Add get_params and set_params.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 776c54948a4a..6360593f64a4 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -247,6 +247,12 @@ struct mptcp_sched_data {
 	__u8	subflows;
 } __attribute__((preserve_access_index));
 
+struct mptcp_sched_params {
+	union {
+		int	snd_burst;
+	};
+};
+
 struct mptcp_sched_ops {
 	char name[MPTCP_SCHED_NAME_MAX];
 
@@ -257,6 +263,10 @@ struct mptcp_sched_ops {
 			  struct mptcp_sched_data *data);
 	int (*get_subflow)(struct mptcp_sock *msk,
 			   const struct mptcp_sched_data *data);
+	int (*get_params)(struct mptcp_sock *msk,
+			  struct mptcp_sched_params *params);
+	int (*set_params)(struct mptcp_sock *msk,
+			  struct mptcp_sched_params *params);
 	void *owner;
 };
 
-- 
2.35.3

