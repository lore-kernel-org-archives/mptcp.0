Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB23B7C
	for <mptcp@lists.linux.dev>; Mon, 23 May 2022 11:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653305669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Y33AjUXSWd3OP4RDXO2n5NPt6zUbnR1AUzN7OeCYfM=;
	b=PMWCVpKPaKM2N2c8KdFqhb4lYsDcMdCUzDTRx5GJWAeV+SE3r6eS9PcZrUc3hq1jYW8uFF
	VNGTfdUl+D1IQim+XEhOMtU0Crp6zxKCybN7OXbdeldXkDQWEPB85B6I7W1sU4o0QE5feV
	8TybXXhjJhLCMa7RAOQasf9QOg6wvH4=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2056.outbound.protection.outlook.com [104.47.9.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-19-KTPKgcIYNI20OyKThqEUlQ-1; Mon, 23 May 2022 13:34:28 +0200
X-MC-Unique: KTPKgcIYNI20OyKThqEUlQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XeqegTpUQ3Rh6r0gpn5m202UE3OVogFRH3LCVmqQ/vR34+RWnSNYPeAj3lYo5FYUQoD19J44wfSl+yHT7QCA7OfKL8l7Juz0JBgwSRR6T4qEnMPPhKoP4ZeJ5R/yG9CtuMVu5KL+J5MPP/5TSeubn5uxFQsjfjr8K31JQfaSM7faG4GULBGmb7K5Ca0NmATuBpvDsT1JFZLRprkQaSKfMAGEEag2UglLB5Y0HiEZfUf0O+y+9KVOyorUHyr+2IWk9fEVMo0hDLteUimEyc2WwwfaQ48GCSYQ9sUF0o1u3OARp01pAITPlw/KLJEPYsogW5g1wUnByFfIOSDpu+NAEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTfiBxvsus/mUkvL8arYB+EyiCRDIEPyGJXyb35fha8=;
 b=OGWvjWX0FOebfj4Qg5HRSXhAPZY4Rd6y0nIg09U0c4YbDVxXC3++wnaRx27lppCh6qs2wpjOKunCRfKhwJa3DR0HljMCkjgEPqdy004vhblZvzmvjE7PlQyx29AtDzdxhd8aFaUqdqtNGVFCqbr9f2+CPOHa3Zaf66M8ySCSLm06nu+BKN+HsyadzJvu459qFJuzP7q47M2D/n29x9Lura04Jg5KH8SAn8D21SHH3vJe3ZvwiFKK8dqpH3r5h+o4HDNtncW7TTVr3/5YcK9tOyONk8bxyrA2cTtYx6aFux2udpa4x27ERvtr+ObnUp//MqsRWFWaYzMax3+zBcMJ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB3PR0402MB3899.eurprd04.prod.outlook.com (2603:10a6:8:f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Mon, 23 May
 2022 11:34:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 11:34:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 5/5] Squash to "selftests/bpf: add bpf_first scheduler"
Date: Mon, 23 May 2022 19:33:39 +0800
Message-ID: <94abb5c4207ee3fc0827c77816648ad37dccf5d0.1653305364.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653305364.git.geliang.tang@suse.com>
References: <cover.1653305364.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0056.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b64b9248-8850-4fa5-9b54-08da3cb0316d
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3899:EE_
X-Microsoft-Antispam-PRVS:
	<DB3PR0402MB389970DF0509455167C87444F8D49@DB3PR0402MB3899.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cDKPrmis9mv5i5YxLYL5LqkLG0oBfXlpnkQ9o6ua31pKx64DO3yM0Q6vFd8D7qU1JZKMSvNVpZPM7bSaQkXrJp3IaVFaDWVqzP9tdvf5WvFieND1yORW7oSOxoKqDClhjdH7V546EksE9HxUDQi0EF7UcikrMaT5OWeRz+RQwE8+ikF/sNwjYE7XKPz0/nWXXFLrYpbZnZLcFMV6zDxgZRMO1yAIhSF2t98VrRuz1ifEBIzXs981ukBSk+rrtQKuOPcWdLNLYGus9SSdSanORHYvDSM8NtXYgnvg41DoRamBf7CcNCZGQc7oXGGfe9DDnMJb/2/sU6yVapwEw8nbwYL8Aruh0wtWoLcn4SeYtxiMa8o+Ixcz0VTVoGAyJShny+8mlhAL+89TjidLzM6WlqGtMKHX3/x9bh9BeW0eXFb9FreByjqk6x1ny4cSaMI+qDcqgaVB7yCtB1mDsAndN2EsMDm38yc6wuiS5s04nSaWCv5L09iikBTrMmzhXKRrGzLoRyAgJGq5OhgTvWAb1ZDWSjDVou8t8j2ShFdEJ1My1x+3LiN2TvI+mLaPY3U74JKc9L/Dfh1H1YaD22CyDcxBWCM3LuIVBQ10M252pWY7SldFKVHjogpW5qmMEzpT0MG5pp/R5P+BR54+vUZT3jvnOUUyDI+vTuZtZTN+i4AeVK1jjxiu8sMDX+5N0EMBWZ2sfKxdQgIWvWYOFxicuA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(107886003)(8936002)(8676002)(316002)(6916009)(86362001)(2906002)(66946007)(4326008)(66556008)(66476007)(36756003)(186003)(6666004)(2616005)(83380400001)(6486002)(5660300002)(508600001)(38100700002)(44832011)(6506007)(26005)(6512007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oQkKxn0IEtiJNWhiwJQF2Uvv3crauGqydDYlZQN8El76+aaZFQ2IgefCBdaQ?=
 =?us-ascii?Q?BqGRU822IDA4H5Qo19lpvzKVo/BPXmTX4T1nWhbEDzp2dYmVgaRdN8QJyAS/?=
 =?us-ascii?Q?nusbrWUjadg+LQ/xEeplQ7rIbsGDz4oCiw19AaZFv8uplx9tOTXOyfLIcJlp?=
 =?us-ascii?Q?Ua+tasDFsZdaze7EwgKryGXOLbXjjHvel2Q8b3h7WV6i5y81+ZrrPTH0+TMz?=
 =?us-ascii?Q?wFJmzb/GLv6vekIEGHeWSZz2uxRqElSYNHKbeActAR/AzkyffVOUzxSOvZXZ?=
 =?us-ascii?Q?lHmjZFyY1SD06R5ULN1ovz1HcaKNlw6ElVUpHOxbayyORlRwvyF7uOmSLUXu?=
 =?us-ascii?Q?+3+xVGvNJ2R7UvySQuKgMMv6PjGCt0I23viSz+4+vTgTpB3fqDqTkbfhPGAc?=
 =?us-ascii?Q?tZzfuoeGA+52wnz4OpOas5I/+ZRcow0E4tgdEUsoYZ0L2gUmUtVsECMv5DK2?=
 =?us-ascii?Q?gp67iCP9qHImvdZrKLzL8pXV3NytwZH2M2xIvmYzVha5qrjtTTHoR2V1yvEt?=
 =?us-ascii?Q?W0ccn1wkkn7OyrNiX9+gD4TYBcVyb5dmEzAXGCIKQf3jYbz2FjEFmkqEk1pz?=
 =?us-ascii?Q?tVDDi1eBNVcmjThJ0iOx013nB18+xeaPe9GpWwehNeDcXHup8UWZ3ePJxiVk?=
 =?us-ascii?Q?zjnFbv8dBrMgExcIIrPGLm6EW7KqkdaBnN8KfP1RDuZ0wBgutWR0YofQFW70?=
 =?us-ascii?Q?KS8EPf2DWosIMPPFRRLxNPvzh9M6T6I/xTCnzoY7ktWYKOlc4nBdUclAEy/P?=
 =?us-ascii?Q?7uH+NqHVHBJQu6I2O7zK4r7WqriT4lGTC6VdIgIUvqw1y3BEDP44wW1tCaEc?=
 =?us-ascii?Q?UAGDfJ5v36vMvD3PM1wAeQPY0a80oYALJewRRhG6syB5DedD2c0cjxgyF9qk?=
 =?us-ascii?Q?suKHskDmi+0sD3gdDdIC1UScwx7l3UMLJVPj5eH/8Q6Xh18feDbMkJljE9yM?=
 =?us-ascii?Q?eHW5PiYDQQLA/JAWW4BVPOQU+2AsTARgnEzCi8d+INairC7APKSUwMiIdRcd?=
 =?us-ascii?Q?cL45K37501jbrK16Lv1eAf+hQfc2DhPAVRrE5ehZI43O90GQDI6YS23sFss5?=
 =?us-ascii?Q?IKJDZrIMTBhVYFdaRPrAVLZLLeO208VQHAc7uAWzbzr7MFLG8qz2NuWjoVih?=
 =?us-ascii?Q?rgNpxlpFtBcMMxmtAqY5VGBrXaJX8vGRHZbbIqdjMs0pDTygizgCYORFiNFs?=
 =?us-ascii?Q?zn0sNwfxU9TPD4xT9zA5NxIlHKuccGz+Dne9lb2m8naG0M1wpfz+EIOTXyiE?=
 =?us-ascii?Q?L2KYluijtCxGDGmb24KmDMOVR/rATzmMOVhGnY4IPDt2jvZFi+rYnfKZtRho?=
 =?us-ascii?Q?k5yizV5cjrlRNj+LVAUGdh463T07VCgdzaB5bsy4mluETNLqqW1TGjtH83sr?=
 =?us-ascii?Q?3ftoF5n/mPRvo61A/d1Res3j0XbLHhiuGOTTT7qqkeJOsTrZ5JPnoyG/3hlr?=
 =?us-ascii?Q?ZNL2iTLqqmcc+GWGy8IpXHgSyb0M+ep4AyW3XW8wJ96GFnBUFuLRXS1F9LDq?=
 =?us-ascii?Q?GXbv5ioyLDm/CwXqU4lzpVN6h1qcEny0PoONo45/H3XA+ClYY5DUWUIi1bRf?=
 =?us-ascii?Q?LDoI1sZdGJbv4sFiVVqJQvlg6gcGiWFr/G3ExOmSqYDRA9mCPJ8yiGdp+kUR?=
 =?us-ascii?Q?o95b8vSIlVdgjuKfJjV67IoYEru62ZnCUe8ooyUJY5hsQcko1FTQ6dv325jy?=
 =?us-ascii?Q?Cd0HV6NczEZynpNmak/6+VhzdtpAkm2wyQubWGFZ3LDRbYjoW+ywmcPlD08G?=
 =?us-ascii?Q?Ctj7YDAxP99AQXQucCFJManKUeG7K1Q=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64b9248-8850-4fa5-9b54-08da3cb0316d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 11:34:27.0648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVnk+xH3RoxWjBnuJVzYgnfDkQrkAJSVG4mH0v3P/NAxwAEZur8MKK8cLzueO0NdIY3lgu6riQZJ1x5IqM3rDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3899

Add set_bit() helper and use new get_subflow API.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/bpf/bpf_tcp_helpers.h       | 11 +++++++++++
 tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 10 ++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/=
selftests/bpf/bpf_tcp_helpers.h
index cb3db7ea36b9..9c7d33e106a4 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -260,4 +260,15 @@ struct mptcp_sock {
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
=20
+#define _AC(X,Y)	(X##Y)
+#define UL(x)		(_AC(x, UL))
+
+static inline void set_bit(unsigned int nr, volatile unsigned long *addr)
+{
+        unsigned long *p =3D ((unsigned long *)addr) + (nr / sizeof(unsign=
ed long));
+        unsigned long mask =3D UL(1) << (nr % sizeof(unsigned long));
+
+        *p  |=3D mask;
+}
+
 #endif
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/te=
sting/selftests/bpf/progs/mptcp_bpf_first.c
index fd67b5f42964..e5dc53965642 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
@@ -16,11 +16,13 @@ void BPF_PROG(mptcp_sched_first_release, const struct m=
ptcp_sock *msk)
 {
 }
=20
-void BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
-		    bool reinject, struct mptcp_sched_data *data)
+unsigned long BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_soc=
k *msk,
+			     bool reinject, struct mptcp_sched_data *data)
 {
-	data->sock =3D msk->first;
-	data->call_again =3D 0;
+	unsigned long bitmap =3D 0;
+
+	set_bit(0, &bitmap);
+	return bitmap;
 }
=20
 SEC(".struct_ops")
--=20
2.34.1

