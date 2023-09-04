Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2049.outbound.protection.outlook.com [40.107.7.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363FD7E
	for <mptcp@lists.linux.dev>; Mon,  4 Sep 2023 09:40:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWc09Qus4OjeRu1DFWx2yWa9nZoeHFdWh1fPey1FgxHRP3y/CTQAfyOCmvmm6YM3qJ18TCmirra7sLc8qFpKu7fVB9P4mank9Pc7LIqi7IevYtqbZfZUDPiLl9GkshxPsbNRFPZIR/ta+Kotf2+lNVTbaljRcqJ6pULtBtTnWBJjnLrG29glcZBO7ASgNC7eGxDqf+MiZiRW94Cb0HbcEGSDp+SLDSXDqQSgNGWz/aSYbtMmRG+IVyc0l1joiUa96BlNeZJKc/+BMc5e13gwE89vr7H4t8T0S/elsifmc0wyXBj74z3fZwIa+P62xYgvLIDkWKQ6vXlTkW+5cwB/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTxnsC9OtoWD844aAdlc4l/6YxnEHxQoxhA+tLThtJQ=;
 b=ZBAGKmSIU6WZ27cj5n6a/ysklOKyTRuk4auxuO9b87WuW1zj+c9Ww/PVrdDf3G+jKEpc1ONShfes8mP+Zgf8d2dBIaMQ4SDdYhE2Id6u9ScDypBQilDhNdaSpua7ob2cKTfh0G7LAe3yLPEXf4d9khP2sbD1W/LVzXipCugLE3evVPNxDigG6fC0g6ARxH9TfOZBCzufMFtaqMd5NNV2ksDw2Ml/BtX1O34atsPYBx+VyCo8tQl2RxZsqu98oI8H/EQmC6mfdla9ywMMWVL0WzRK5G7OhxrfLtiYDvFFTcyB/t924S+34jZhzNfuMZWJD0JhJ/PYre42bqj45EK5FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTxnsC9OtoWD844aAdlc4l/6YxnEHxQoxhA+tLThtJQ=;
 b=IlZHRJJlOIOlhnV99kNGA+jwX4LxXsggcY3Nd6LrJQZcfwengdglHJj9u9DBdsEJED6QBB+7mJ9X/IKiQ2Y51TCTcwZSXmzcrk99P9ZZpGfBOKcYYtaS3daFsJMKuOc3iteR5ewT7YEvoMoDSmLyISntpOSf6mOyMAa7yuNJS+ZElMnaGI7VO0lZ54d/P6nvjoqGh81I2B0mkvhQcdBlPSnKn1+N8LWTs3wzOwvYjCuWU5rHgK2nTN0s02zl7qnZfgYTRMzB01SxGN/tKOUfmiJLJ90wJL0Dzm/9t9tcPLa2eB7gTtXVZFdTNmTZXgeHvYzrGy+/UPVa/1b8HOAS4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by AM9PR04MB7716.eurprd04.prod.outlook.com (2603:10a6:20b:280::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Mon, 4 Sep
 2023 09:40:18 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::a5bd:13d0:b0ae:59da]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::a5bd:13d0:b0ae:59da%7]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 09:40:17 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 7/9] Squash to "selftests/bpf: Add bpf_rr scheduler"
Date: Mon,  4 Sep 2023 17:39:26 +0800
Message-Id: <34cdf57377b20cdd33473ae97b3ee71c4e4cea36.1693820153.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1693820153.git.geliang.tang@suse.com>
References: <cover.1693820153.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0288.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::16) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|AM9PR04MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: a88405b2-519e-427d-87c0-08dbad2af2c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wN+lJCJGLvzGJq2M8HkB47P50yd6RSLgDYZ6UaTXq4X0NR3ZhUMqCIZnWoqAB/TBmqD7hwrhph4e2rtSMyUHsvGASzw2YsHXkBedb61jJbgXWpB7vBNdUMwxLeO0zx9/AmSG1o4xNuhUgfa1qYm/Hu7ytxPMgcnNMfajDn6divofcqt/bbCcj/1g1YjxO6aFKhPAa3BNAU3N9lrLPROVzh7uAZanIQV/8e2p1xFfUnq9kGFLAbwHDn/ZPSS97+FJ2BQLjmiFzBAds0DwxF2YUODXKmXS2QH9vh17HevPYCJFYJHxh0bICGPk4INCnTk3AhKSU+lsYMQ/dRi800ElF91l1cgrRLfTM2Wnkvgx0GYbwIvyXPxw8lPgkcgs9bGH7I7MJxishnSo6fqsBBH7R8oOW4r370ZKM5KfQrt9ZEEh1VAIYolAhqQtnc8zuwz+5eZ0nu5ayG4agNweRjDBIl5Ziklji5+6m0Zh2gOXXKhXqSb+ltqhxHbvGIK+rlG3WGTaAEBdH8aypWlui8sAOyanjDJz02rc+MEWmUnA6NkvtYsfqanDP/4WRqDzvKwW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(39860400002)(396003)(186009)(1800799009)(451199024)(41300700001)(6666004)(6506007)(6486002)(478600001)(38100700002)(83380400001)(2616005)(107886003)(6512007)(36756003)(2906002)(66556008)(316002)(66476007)(6916009)(86362001)(8936002)(66946007)(5660300002)(44832011)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F7wJcDa3AtY29JKqoD++1w2xuG+lFvEEnAvXgQ5oqS0/A4C32QVQJCeWWAde?=
 =?us-ascii?Q?VLDHyn3tgS/c0r3xUH/Anku3yJUgInrWNUw5YIYHXOrncEhxUfidujmz5diQ?=
 =?us-ascii?Q?NxMfzVeFdHHIJkHqKlrQW4gasqSiFwROwo4SbrJe+70TTJcBuUIlyNh3FSKS?=
 =?us-ascii?Q?tFC5mPiU4KnUOY4LSJ9WPWyp1Y3DhkEy7/6NrWTJtXcZ7LSdebIrDZmwX7aE?=
 =?us-ascii?Q?v5toDpQ9RNOiged4YQVtppr+ACewYorGl23rrJdvIg8H3suH3Wce8Bcv6+3a?=
 =?us-ascii?Q?ejDy22UI8KJNzClUARM/Xm+z02hRJQGYBsXDb/1HNOC+sBxhzwyrruZojI5E?=
 =?us-ascii?Q?S1PHIfs0qhn0EbyBMgX0ZUwVfz7Hq6djmg/XkWup4MbSPAh9Wj2hyeE3qrMM?=
 =?us-ascii?Q?PxaYvwjbQ9iJFGgf9Ls7rWJe8yNQbZ9ijbiShXFSb9xtD53UGQZxDd4nhUsR?=
 =?us-ascii?Q?OCThy1pf3y+UL4PRnFsKe3iUxdX3dKYXl/Ch/rvixVNbCiFZpTbn/I/J0rAO?=
 =?us-ascii?Q?3YVhNoA4r0raGwYwtCvMljsJPTR/0JCGPBYn16ectGxq9snhG38BQVcnqpzH?=
 =?us-ascii?Q?EaBVMi+Q0AS7DDNz2ILfo5gXpHZbdpnn4dYduUCnu1s6D3NhoJR5DMqZ549N?=
 =?us-ascii?Q?LTbxI86Symm0Qq8+77sXFRAEeQXuCyLYZJD+XWYxTBImXdoft04kTWnoFjVR?=
 =?us-ascii?Q?vYjDv9AJeJN7dann09gCKNLovdaljqD9J2u2qlSY7Nu3rsi89PI/VMZFPSrR?=
 =?us-ascii?Q?MmBlpOhWLbPRSdFVdegiCOMTyUiieoBfugRqbUdwEICKQIg054nyt+JarFxO?=
 =?us-ascii?Q?3pubea4p86Q3U2450IxP/f41MrLpJPjtzBnyO5aFg9RG605ITtETVZO/WFIY?=
 =?us-ascii?Q?M/JH20P8r4sKFE8+h0aPFvVv165IWxati4NZpnQ4IMPpYZd/W0Ykml2j69a4?=
 =?us-ascii?Q?r5ym7BZ/92a1yO9TjUmXTeBpdbQRAojRerXUUXFYXxsaJT/nlpetU9mfP58V?=
 =?us-ascii?Q?vuwVEQkaCuVITy5yKpVAbYBjuDQ7G0YaRBAliuzXLZl8t660hB2DB5U1k7/A?=
 =?us-ascii?Q?0bGMrkunronX3lpFIXiqSGqJ8JGsxCPs5PGlHx6NbSr9WLTrYtuTpMAV+PsX?=
 =?us-ascii?Q?aygJOilCR9tWkpT1QfksjnjWDdZydAxVuV0G8ic+/xkCzzwjhl8yOqLGk3dD?=
 =?us-ascii?Q?Rg2iv4Gz1eQyyIJjzL+4QK29lgtZXH/pTRQWqNqGgsNfWMc/05uJgk+rWyux?=
 =?us-ascii?Q?Z2dYrYPJTFJTKd7w83RqRGkSZEVuEG4P9U/xvYTp8rwINnIBeR+UfMfWzaTx?=
 =?us-ascii?Q?KkKUYvEUYRnvYvCf+iYuq3ARvhJG2vj6tF26pUr2Uc3oPq6SYVWNiymAQvX1?=
 =?us-ascii?Q?yEJjwM4sUlwVuru4Sr6DdYxN6Nrl2OQ48rfB7pQFxpG8C4OsIal33zpTwrQ5?=
 =?us-ascii?Q?1ZqFhUMUCnOMfRDwNUsgEHgi49phs3JHEsOAuqqBv7i/fprDfK/kNSaoSUDO?=
 =?us-ascii?Q?r6pjvIiUKbi9FXfBXYk+TU3muCSal98ZylT1EYsOiIN3OlRMUbmvmEvj4QZx?=
 =?us-ascii?Q?HDtNelEkM53C5VWn0AImYGrJ2VYz92kSU9cV24aegP5zX6TJ9yoDyZKqFDv3?=
 =?us-ascii?Q?ekNr5paxjhmoNVUIkvKyiNCxVy6zKukcN/g7TFJ/1uGv?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a88405b2-519e-427d-87c0-08dbad2af2c8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 09:40:17.7692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3voi9DqjDBda7N7r0ne/KZyc9NxEZ7JTnPZ84+NKjStKrMSaULZMjCsy5F90gEzQcQMN5CU/cVdq8Nxqtb5E8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7716

Update mptcp_sched_data_set_contexts and mptcp_subflow_ctx_by_pos.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
index 347ffad90860..39b7e1cfbbd5 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
@@ -45,15 +45,14 @@ int BPF_STRUCT_OPS(bpf_rr_get_subflow, struct mptcp_sock *msk,
 
 	last_snd = ptr->last_snd;
 
-	mptcp_sched_data_set_contexts(msk, data);
-
 	for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++) {
-		subflow = mptcp_subflow_ctx_by_pos(data, i);
+		subflow = bpf_mptcp_subflow_ctx_by_pos(data, i);
 		if (!last_snd || !subflow)
 			break;
 
 		if (mptcp_subflow_tcp_sock(subflow) == last_snd) {
-			if (i + 1 == MPTCP_SUBFLOWS_MAX || !mptcp_subflow_ctx_by_pos(data, i + 1))
+			if (i + 1 == MPTCP_SUBFLOWS_MAX ||
+			    !bpf_mptcp_subflow_ctx_by_pos(data, i + 1))
 				break;
 
 			nr = i + 1;
@@ -61,7 +60,7 @@ int BPF_STRUCT_OPS(bpf_rr_get_subflow, struct mptcp_sock *msk,
 		}
 	}
 
-	subflow = mptcp_subflow_ctx_by_pos(data, nr);
+	subflow = bpf_mptcp_subflow_ctx_by_pos(data, nr);
 	if (!subflow)
 		return -1;
 	mptcp_subflow_set_scheduled(subflow, true);
-- 
2.35.3

