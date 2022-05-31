Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639AB210B
	for <mptcp@lists.linux.dev>; Tue, 31 May 2022 09:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653988193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D5e9kmLCen3qW6BxWyCek/8GIY90xE2O8l4ztQ2D25E=;
	b=gg2EyEVxC3YQeJcRkkTk0/TAJPPJ8thZdgSDobuEOlcpPPXtkPQW15ueECinL/v/ucDVMp
	JrQi3zTHHd1YbEYXq2JKChAU/BXHmTUBVTHy2wMoNfkckYbux2a97P5unmMepS9S+yCmN2
	i6e4MEtBTwwSOJJWaPr6o249Yt5YF2E=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2051.outbound.protection.outlook.com [104.47.8.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-Cu_DymFWMI2NcvozVkTWNA-1; Tue, 31 May 2022 11:09:52 +0200
X-MC-Unique: Cu_DymFWMI2NcvozVkTWNA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXaLwI9ZEa8z1C8G/umIsxGaEpc6J9hrhmRzF0yeqNzicbtWszPXMJyngkoIfTYVBh0ASB/JGywrdjCln04NSpGErZj12qkKZ/pPgSoC6gYDcyjhKRhfuQ1VIrWGL1KZeq5mmeZ/ZrM6CqD/WwHTgsxGCVHFg/AOBljgx6hbewsYkW7e6+dpVIDo2t6Acj4IyP0r/Pg9KuRwQjB66m2ELYqA6cbH1FSQuXplW4HsgFneQ8uqtc+MvOYfzvCxlor12YMUrw/e678VLEer3qbduCu6xb/l1/uUlyzwqaFIhsVSePQpbbt2w7GoJLOYtsQXu8bWbeWb6shmUCGU/OYfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6C+ohQ1ix2M+7gCHiC+pCz9ZvHrv/F0gHVo5Hf6hMLU=;
 b=IgTc0UPJJI0/D/IUq239Jzc45hBCFKoqumEcj9aDTqsHgasaMcxaagK1ZVqCCeLLnEIubsKBT2m3Yqb2bFNhwUhjRFzOptERWbH5RXXWhzD7+XVlk9tqYiWk/0eCsqNR82DsX5hGM7BCdc1rvu8FUzmsqHr1kGLoNVXOtgh3wsgIL8U1egrxNqqjH9xOcAsgYKph58ExuBQWyTfYzWJHXE1aNSO9jL5JSZAsGG0PdEAb3L1fKoSoTL3PwAH1E6tEXEzjBRj1r9pZdT4XCXfxXy+CFIX7X13OuS1ftpwUCrC7HbrqyURaw8AlnJ1vobWVLLOrSgwvq3VH53J8zcKalg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM0PR04MB4356.eurprd04.prod.outlook.com (2603:10a6:208:5c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Tue, 31 May
 2022 09:09:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 09:09:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v4 01/10] Squash to "mptcp: add struct mptcp_sched_ops"
Date: Tue, 31 May 2022 17:09:46 +0800
Message-ID: <fc0419737e68303ab2f9da821b740f5069d1da7e.1653987929.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653987929.git.geliang.tang@suse.com>
References: <cover.1653987929.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0030.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::17)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41222bcd-ae66-4a73-eb14-08da42e5519b
X-MS-TrafficTypeDiagnostic: AM0PR04MB4356:EE_
X-Microsoft-Antispam-PRVS:
	<AM0PR04MB4356A5E3B468A5D9F75AD8ABF8DC9@AM0PR04MB4356.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uwMidYAF8oFLxIPBWBydttBhdSKbHPyh2Y7fqNefaguGgRFawFizKSsrhRiYlgXxdYKGUrP4BBsgXNgtB6MSSvpW5XOMisD4UwfC75NtwGMcXc0akk051Eo9aKfRZZs4sSq2oMEPuy8qNwaC7YVeDM7Hi2f7e8RnpQYD7xJiSIpdEcT72R5FDU/vsEWybVNhH1tJ/Ddt3psQCjvHH/wErko3GJykz6GsWiueNqAZbrkJuvUseky5mCQLEs19WmTkdS5Du0gIgJ5HKVfWNpm5HeNdNBCcKiRBYlYPGxqm2PA2VupO6zwHeUH/+Mw7DaNEcruN3kAG+puRPw88aXx/NWhrkZ7RUWiXe57V78iit7aQzqjRlTNekctOJnbd93/ZzaJDTU5s/xivd4qeGYSBusH1KVWPRmg6Vi5SMig4s4MlgexTRFKA+pNC1zOOaThO5x/qklcazr2uabO0JSIbFGjRvkPlOsV98Ou8naDdTO0wlUpj3tKPTcxlmg/Qmn2Fn5BrTfpdBZxDkFCu7Cwd8MwaMre074i9G3XyfzT81Opl1FS/n/pex+7u/fJpMzu2TNyXkLYDyMgrsh1YETLhOUbubyRe6HOANC/GUFbrVFR3q/lGs0/QJGHwL7jXk3LthJB69QFAwdlJzmrqGi6d8esCMMQyPwvULwkPJpkIoBI9bNHSjAW6mW6TrKVWM+KcUs5yMT46mwWVDTsU8lgQ3A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(66946007)(8936002)(6666004)(36756003)(66556008)(4326008)(316002)(6916009)(66476007)(8676002)(6506007)(26005)(6486002)(2906002)(6512007)(508600001)(44832011)(186003)(5660300002)(107886003)(2616005)(86362001)(83380400001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FhHMN0PXg7NMONUuv+aSSAZxKk4dU/cX7tiQH/m79nJmfJ3EkI0wbvGrocTy?=
 =?us-ascii?Q?LR18GgbC9KTYzpP0mXr9gSKJHLEFWTdzuylmM57pbqnbmxCqc/pvFhwBAXp1?=
 =?us-ascii?Q?xnrBR99nztrvelpMawooNkaZxsGb4WhTEmHYm7bcOLvIYo/I7HHps750WS3f?=
 =?us-ascii?Q?Pz+HVPOcVPaMim+CS77tlbZ/OC8wUnaJ75jfHeICHpK2mRiovyi6EK1c79jx?=
 =?us-ascii?Q?gKDCUW8UpMYJCfHIoVQ6l8/kHLVlrMPho/sNX6s0lT04lZsaHAmU7ND/AMO5?=
 =?us-ascii?Q?SC8380Pzv6cjfDuwWO40nRnW08fNjj3V4gnDY/E7dbm4sqQ7bRPC3MifKfjp?=
 =?us-ascii?Q?jK10bmrRc4NeOQg/pHVWD3WS43fhMQ7s3CDI7GB3XRoFzX6YkQRoCtTLHTEP?=
 =?us-ascii?Q?qOxI/+71/ipffXz0e62iXCIFHT2hl2EmFf0qg4mg89EGnqwxj3HXnKdZPi6t?=
 =?us-ascii?Q?AYASFgbmG5O29ZzD30FXX/nrELW32/KmYjqkxYLGB5NKnNiZ2EG1MdVr2TRV?=
 =?us-ascii?Q?wEPRjxCyyg517lRDSlpho3rsMiaANtDK3HzBO7dNOKw6VEW5V3uFQkEmDscH?=
 =?us-ascii?Q?OKy2fzlnrcc2DVB3kpGGcSI8OFmcTiK0GS0Zdk/6ozDbMqjJmztRLmabRV3s?=
 =?us-ascii?Q?u1nuhZPnziHRFUfMZOCOEIHgTTqNMWmphuLjwFroMvyXCByuMgzRPBrlEFdN?=
 =?us-ascii?Q?6dXBcJpeemZF2oj3iE/f6tzfHZnclQ+2VHq2TVCtPxKTKt0J9g7CyG/5zvqv?=
 =?us-ascii?Q?q9DwER40a59eAOGGzKUdilP2VRJsSk5NqHOXaoBcHgfOy4M65d/lo9J04TuP?=
 =?us-ascii?Q?SUog/JRnw7JTixcmT5yMCJmlYa0tVhO0l+cUMtxw1sTr3uqsVRegKATLBznd?=
 =?us-ascii?Q?kU2nA7Ss8NLoQqagOCOXv1Y/1I9cAh3xVYqFy4DjPHG1sm86iFTiEAYwafz5?=
 =?us-ascii?Q?Tpl5wj4ssa5F0M9POaIA9Sgm2XVnda0Q2zELah6Nz1W6HjfR4uMyeznpEMEL?=
 =?us-ascii?Q?zWmalq12nEa0GNuxQBtq6l7wwZZaEIYltmQo0144e+IFAQDMBmZ1crrpaSuM?=
 =?us-ascii?Q?yfOs092VrsiQy8Vamm11Ez+1VFLh1eDOAlXHSs0Gm1w5/1Bl3TgRA74FCYtM?=
 =?us-ascii?Q?BO6b1IQSREG4zbCt7vQVFPL9CEH3c064yl+xOETcBqaiUFr9kRk24B/zJM8R?=
 =?us-ascii?Q?nOvUcvhN8aqzCHfUgoKTgi1ZO8PdrSaZzExA+adGclQzsQNKo4PRMfCLDmUH?=
 =?us-ascii?Q?wkGJZ0qBHuhwuIxxCHL1eZJknuHhIF/BsmYYaoVmrpKkhp5/1dQ5DgzHMVDz?=
 =?us-ascii?Q?x7yAkqOfHPF4nlzZo+5FkA92pt9udbQMi8iwtsFc3tdAtGVlE9nY5RC6c9gf?=
 =?us-ascii?Q?8Cith9rF2bXvMB8CWm8A495Na3eQ3dIRDnsdRKuVhf+BNyDd8EsB4SCB66o5?=
 =?us-ascii?Q?J2HZHhgUnZZn5ixb4X1EAEMsRhBbRT2NWKlu1Onf/k63cdA44glb7rBdoQuy?=
 =?us-ascii?Q?pFH6lx5PyNWjRCpkBaSKTJyfL/rd/Dwya5cEJTKgNdFFw46BVUzqQzl4A47B?=
 =?us-ascii?Q?K2eOgSfaWdfVwanHIFEQQnKkJicM238RTU+GnoZpALhGkw3QLsOENCn5ftbF?=
 =?us-ascii?Q?xW5GEpgaQyXMuSQwjJyadCd/9zPIQ8RC4F0r72POXS0sEsqZC/u3hQlDEANo?=
 =?us-ascii?Q?EQ+TIxES5z6NK8FVKX5xjoRqhBQZMZfvYJRr0oCVrHVEfAfJEyr2Tc2wGEln?=
 =?us-ascii?Q?NK9s1fEbkxb6nxOH6ONA64uAWlcZz1E=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41222bcd-ae66-4a73-eb14-08da42e5519b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 09:09:51.4056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RFdi+AsePVpg0zP8+1ddkFfybNc/CaMbMGQtuJ5S9ry2MTwrmEtTZ8tNp55agZNUTA3tGOxgwNGjSpHZATzmQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4356

Use bitmap instead of sock in struct mptcp_sched_data.

Please update the commit log:

'''
This patch defines struct mptcp_sched_ops, which has three struct members,
name, owner and list, and three function pointers, init, release and
get_subflow.

Add the scheduler registering, unregistering and finding functions to add,
delete and find a packet scheduler on the global list mptcp_sched_list.

The BPF scheduler function get_subflow() has a struct mptcp_sched_data
parameter, which contains a mptcp_subflow_context array. Add a new member
scheduled for mptcp_subflow_context, which will be set in the MPTCP
scheduler context when the scheduler picks this subflow to send data.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 include/net/mptcp.h                           |  7 ++++---
 net/mptcp/protocol.h                          |  1 +
 tools/testing/selftests/bpf/bpf_tcp_helpers.h | 11 ++++++++---
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 6456ea26e4c7..7af7fd48acc7 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -97,14 +97,15 @@ struct mptcp_out_options {
 };
=20
 #define MPTCP_SCHED_NAME_MAX	16
+#define MPTCP_SUBFLOWS_MAX	8
=20
 struct mptcp_sched_data {
-	struct sock	*sock;
-	bool		call_again;
+	bool	reinject;
+	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
=20
 struct mptcp_sched_ops {
-	void (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
+	void (*get_subflow)(const struct mptcp_sock *msk,
 			    struct mptcp_sched_data *data);
=20
 	char			name[MPTCP_SCHED_NAME_MAX];
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8739794166d8..48c5261b7b15 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -469,6 +469,7 @@ struct mptcp_subflow_context {
 		valid_csum_seen : 1;        /* at least one csum validated */
 	enum mptcp_data_avail data_avail;
 	bool	mp_fail_response_expect;
+	bool	scheduled;
 	u32	remote_nonce;
 	u64	thmac;
 	u32	local_nonce;
diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index aca4e3c6ac48..a705054f38c5 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -231,10 +231,15 @@ extern __u32 tcp_slow_start(struct tcp_sock *tp, __u3=
2 acked) __ksym;
 extern void tcp_cong_avoid_ai(struct tcp_sock *tp, __u32 w, __u32 acked) _=
_ksym;
=20
 #define MPTCP_SCHED_NAME_MAX	16
+#define MPTCP_SUBFLOWS_MAX	8
+
+struct mptcp_subflow_context {
+	bool	scheduled;
+} __attribute__((preserve_access_index));
=20
 struct mptcp_sched_data {
-	struct sock	*sock;
-	bool		call_again;
+	bool	reinject;
+	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
 };
=20
 struct mptcp_sched_ops {
@@ -243,7 +248,7 @@ struct mptcp_sched_ops {
 	void (*init)(const struct mptcp_sock *msk);
 	void (*release)(const struct mptcp_sock *msk);
=20
-	void (*get_subflow)(const struct mptcp_sock *msk, bool reinject,
+	void (*get_subflow)(const struct mptcp_sock *msk,
 			    struct mptcp_sched_data *data);
 	void *owner;
 };
--=20
2.34.1

