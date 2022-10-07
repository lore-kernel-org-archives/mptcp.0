Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80048.outbound.protection.outlook.com [40.107.8.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E849468F
	for <mptcp@lists.linux.dev>; Fri,  7 Oct 2022 15:02:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RdNgH7Xcll7POZZNx1U0qoBGpKIyqtnPNk4oF4F5AxaX10TADW7YpwaRkUrz5ss2s//gzAer8p0sjl2wJBfyPPoLHFux21BGwxJmRewUeRKUQySS+uDzZcydUPE5ZzSVY9Vt5DsoH/B6nFVQNWp17liotiUQznunCF01HuTS5W6qtez/qUPkDmMxSwb7g1kKN66gw3esqCeO8MJOWWLQorjwtNj9zLRFveECnWHqO4bFnSCSuN9uFUfJu1JSzj7YXJn5TrPPxkhPDYJ5/8oypD36kmKZQxJOcwPXSuHxcmUa01isWQCuB0LufvnDvs7GNEst8pwaZ5wIzhO73bbaIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJjowJ4690G2NdLtiQ+Je2I0ckCnZXEC/DGaQQoUNmE=;
 b=J4tKCipU7UJYatYWlBVEtGCTpEiLLtU6U0EHINiz2ZT/lt6PuNKSywHEhfw15YpTnIOCsBeEDlPt1Ho9IOe96wwQKYefy1ER3Nx3+9ZeR7oS5ywnpO606esOIDeNnGwPdsyo5jOkQS/dd5zttV5qZzuOFpi+Mq1+wYKLJ+waxkm4yv523JXzXH3kiBZGfFj6hsGgqV9X+LRdRy+Ik48R4thDkdunkmuT3L7k7CB/jyvQbYfdlrGMttnOKgxHc8q8QpD+ZW0UCOGbbftgFj7Wl2KNroJ0y17V03hvRnM0c7jfN5EAWuSK8tuFvVA5ycJxTeIeVZQ8sy95JwSVJmC51w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJjowJ4690G2NdLtiQ+Je2I0ckCnZXEC/DGaQQoUNmE=;
 b=oycPB1naoBjcYUm3nc2fa9VL3+dxI4UM1IMmckcSXieQSwHIER/elIXgKiXuGfsMnBuKeSGYvub+EDlXFXG28+/IDp7Wh2LBg+io6XvtydejUtuUZUTqVRuntygd+e/7TyA8kjoURaWMOnpbMLLpMk8WEAsNiJIjFFvG9L53XCgfH2L5GYgcSW1CbwcaEE6/lWVO+maCUZnmHjZ06Ex6LxfpgV7EkDn6iJ5jtfmL5gZqf8s1VyUqQRwDdpYLCW23QSiAVpjyF79+2qu/ZwYHUv1IzKrTyj+XBY6XnKf0DUS8eK+oZcRDkDFsJOdd1ZgfvsnFygstbMrfl2WUm1PRpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8295.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Fri, 7 Oct
 2022 15:02:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770%4]) with mapi id 15.20.5676.034; Fri, 7 Oct 2022
 15:02:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 07/10] Squash to "bpf: Add bpf_mptcp_sched_kfunc_set"
Date: Fri,  7 Oct 2022 23:02:31 +0800
Message-Id: <d5548cd9eebdd88ba935c5ee441443a4da8ad2cb.1665154582.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1665154582.git.geliang.tang@suse.com>
References: <cover.1665154582.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 931cd00a-c5e4-47e8-c246-08daa874fb24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gDhcZYIaKstcO+9SWylqGmkyrUKBzeN47GbBbTpnIiiCa5iFaD78kd1Wh9z3loF9Nh7HKUzUlktZpHYtsdL8pJ67EXp+XRq66KGlSgPQ2Hg+gkBR2jAmye8UR/EcM/SlaQoXRpqLnwsBERvMN5GAYwx+Q3Q/KyP0XmVEWHwtISDa0tsmiVzf6Q4TXOqxJVwgoKM4J08Rlcrtm+/cSBUQGZDuPVF60YaSMxuvu9mfxYoXBefvzBw2ZTv4QMdgC10Pim1jX+UC56M9CnAPwnCrahFwBxI0Nztx56sHitgyLfc9og33KVeDhzmf5peQG46B72RQLH752JuFPIBzowDtCNALA+uo8q3eYAXua9/WzkczuJYRPvwubS3vkftjwT+amKiAub5fuywsnzHUxZMjYPSQZ67aE/ETDlcNx3u5Ao+dX3P8rprx1Ueg6r0AcfypKMJMljtchK/GRSXSA2tv6qUq/UAmvKpTxuNkd0IaNNjoA2VnpymVhaORtUIRrxpBS8orCAk9l23orqln209WF34UnYFrMHTRIZqLyR4xgO+2RDz3eMIsvzc9EXPTsVYsSPY4+nEDJ626mGUgjYjXoSZWkqkLRA/BMXJPNHrytjmsG2bF9s/y41rTlNQ5ntAq0BS1nirc1N3MW2Bd0MuLY16aDl+p3XqnZp/VNcOkv3qSeolTUSZjisku7Peu9TziYZFtHGI+Vmbm6cuvJHFydkVupmItX7mwl4RG50gzI0v/FS3wc2O/D+RoHc8P0kTZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199015)(5660300002)(4744005)(41300700001)(8936002)(6506007)(26005)(6512007)(36756003)(2906002)(44832011)(2616005)(186003)(38100700002)(478600001)(6486002)(6916009)(6666004)(8676002)(86362001)(107886003)(4326008)(66556008)(66476007)(66946007)(316002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fgtd0XE3aHPe+niI5ggix6D0ap8e54mGgD//sEm2GdvmxxpD3Tjxcp+rUfKh?=
 =?us-ascii?Q?Z7b573UXioD1PLbbeCoXetj7UdNEVJy1EaE9So27xQw2weUG+muzxNmKtKhy?=
 =?us-ascii?Q?lHKKD17E915/rsYNImtUZuR6zBh5NZW7qqkE+Xydq4M+Hjf5ghZ3xZiGvJfo?=
 =?us-ascii?Q?1p5wWaB3Ci/jTR+Fmij+JAU2+HJID3Z/40znBJSkhNeGac6Cfv4KL6REafb7?=
 =?us-ascii?Q?s0CL2NIJoQxu7QJU/cPxfuGZAop97AsPbv0mZ4jYSUHy+QAtcwve9lgOBhWb?=
 =?us-ascii?Q?VKy6xuRx7it02W/f6o9e5ymFxj5u6f0RpFMb+8X/u0jiMsywYau5izgWwQ3e?=
 =?us-ascii?Q?94S1On7+nzeLYsek/E4sYXP0cdLs3NClLldi5eUJbiGcTCGvdUJ+BTtSjtwP?=
 =?us-ascii?Q?OhmhUpLFv9hd6bqOc5k2itNQYiTa/9zPpcUUbfvu3ZaBso4f3giPTZJQnQjh?=
 =?us-ascii?Q?rihBB8gI+VQSCVMdid3bX7FrEUNknDhtWgrHL/3oREdnOrnXnTnYifeoO8pn?=
 =?us-ascii?Q?g4UXn+y4KWmahEKkr+w77HbMKkQB+f75xUTSgYNJK79NThU79Oqd8ySN+I3H?=
 =?us-ascii?Q?cBfFNHsJIxXyVlRpyMSUNgkVPfhISsHA+OQeXGzklmLOA12TKHOFwx6hf+xF?=
 =?us-ascii?Q?YYke+8G6hZ/c18f0LaCc8K/RmcoSbCVxGWfrBA3/xXU7C7BZgRsAnw2xEwQv?=
 =?us-ascii?Q?Xw2e9SIaMrGWyRJ8/fpaUm/LdF3X6NCUKHuo55okGYyN18yehJ6Cf4UICsbA?=
 =?us-ascii?Q?sULVnjmJfKJO3rE5KD4EQg0gXZ/vQNRjamjK6uRBVo9M1TSRs+5Z81K0PRfH?=
 =?us-ascii?Q?wutF4Uk8hrAlBlMLn7CB/WVbR6w8Wti2vBl3qo6zo9D0o0oSWaPL50m22MdB?=
 =?us-ascii?Q?ktL1tKsEhGojzFAWOcEFVuuAn+XMI/FuooYY4h6O6K6SCSaTUm+L2GVS8ciM?=
 =?us-ascii?Q?wGJJ8y60iTotDAwW+Z3fV2UW+MZCwhlBpKVmPaqV++H8/ve/BKItUSxUhLfx?=
 =?us-ascii?Q?o9lmdvuojB3T80JN2eyT1rXsCgveYijD2km8AFTfCQdAmtdqb92V+SU+xm/1?=
 =?us-ascii?Q?D0k6qpkHYbG3t7CnP+z6CaqRShwv+GMtHabQaNu5K5SEgqkvnAJKwwSopHKL?=
 =?us-ascii?Q?Hj7YNIb7dJ/DyzbyiRY4j/cw901ZeQ7veJnlW6BGVJaevnNYKJDwtrCsJY2W?=
 =?us-ascii?Q?31Cz7htm1WarQFk+etiGTqGgTT7kSKEB0cjmb6NtUuPkdTKKlNojJkRN6S5b?=
 =?us-ascii?Q?lTYcO+s205O/O5+0j8d/iFGxlePtpVgHeR6enyiQSf1AdTi7iIex4CoQGxvQ?=
 =?us-ascii?Q?shPHqQBZreLlJ4bOm7QPE0dEUjoDlZXV4t+jMRsIuYaVtgHTQVgJcKsfSwVq?=
 =?us-ascii?Q?ebGWX3S4FXJA7CK1PO8T6aCc5b8lq9K60PteUxg0qWcRj9lDvCCaZC+5PzU7?=
 =?us-ascii?Q?gP4f2uRjRCyAGyZtri+Uo5GRwG1IkB5EoPyNG8I+19FESLCEZoCSHNsqC9RL?=
 =?us-ascii?Q?MuB9a8MtF9zMpEHUPpOmDTfkW7z+DfNZnmv+iv/7mPecLFtX4Tp3jSFf0oBv?=
 =?us-ascii?Q?zjNQxDE8cVjjBfDuUfmBMA1CbsORJo7vdCjrH0CQt+tmudo6HN7IYlb8b5nl?=
 =?us-ascii?Q?JQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931cd00a-c5e4-47e8-c246-08daa874fb24
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 15:02:41.1071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2yNSjUK21J7EQ9Pk40kwBbHUGisn31j6BKOtHCrtwtn5vSuB4xxwY1GXN7SiPtZ3Tw0dYjajyJKmgoUTO4IcTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8295

Add mptcp_sched_data_set_contexts in kfunc_set.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 0a768898990f..03decb05755f 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -164,6 +164,7 @@ struct bpf_struct_ops bpf_mptcp_sched_ops = {
 
 BTF_SET8_START(bpf_mptcp_sched_kfunc_ids)
 BTF_ID_FLAGS(func, mptcp_subflow_set_scheduled)
+BTF_ID_FLAGS(func, mptcp_sched_data_set_contexts)
 BTF_SET8_END(bpf_mptcp_sched_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_mptcp_sched_kfunc_set = {
-- 
2.35.3

