Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037A77E
	for <mptcp@lists.linux.dev>; Fri, 20 May 2022 08:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1653033930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZpTxnqAxr2DMfU5jMx7UoxMmvokrc3T6UrAPXTKE9wY=;
	b=jZHnXLzikWi6dTSPtFtz+cCj+YbIzbtuBAOyu/KxQxLCd+Blypw/o9pEFXRjnIh/DWeeSC
	TOHOGm9fBdkAazNXj0VId81Ns75ma/nOusipnUTWz++yeJzldnu9hX6wiVaMU2FPEGzjWg
	+K/FehQZjDABrcyeEQ1ZBxBR0kCQZtM=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2051.outbound.protection.outlook.com [104.47.5.51]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-7-JAFNSzWLNbqHBOrSJkP2Bw-1; Fri, 20 May 2022 10:05:29 +0200
X-MC-Unique: JAFNSzWLNbqHBOrSJkP2Bw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQyZ7WkowE8YZFFL50T2b5DJ7qggDBzbW/E53iiIchdCczQo76dKhIl9OYDgMDxajpmSWQS/WD5fkqyG7PNuOEgf2m5jHnEDuzYR4el1TZ00IQ+udK6r95XQpAO/7rYEiTnulmExCKuC3uOFN642XIPPn5eqcinQ8H/ICzfNTlLdHac2UActPR2F0V4detyvlnZvnGtwvi/tz5SEYmIlw8VLm6Qs2CphSXO+mQbKwVJd5bB2yNeJ80GQbg1GJcycbAWygxRLbtnEqxFnaoyFG8Ta11Tym2VZj1MRv3W/Tx4ZdX4zpbFKgVKw7wxaTCLl/YmNu7ofcH6L8BO0RzQtMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tXnxEUZalbpXTV5jrzSrWL1fHrELnu91R8zabAc/+k=;
 b=k9qLXbz+9S4tYmtvBO+iv1HltL0azWpE1qpP9Z0Jjqr9LozuZn8mLHXI935+f4DBM7wmR4r/L8vFn1oQeCLEubUGAO2uukEKiGl1Pzw5Sris6t055uIe+oG5bCQMnCoPGjMBW75xul7q91wpxTWqSe9bSjye1UzgZ+IGYQrQk1TG1kjGnpfZFlrx9NUuRnnbzdkjXCHx7Nt9FlEbdyFMz57M5PmSDVaknyrPbq315uyohax13tbTGeWTrkjfcUXgsXZSeP+pQRb9eBTV4Vb0/gu3vfXBdmlBadfl6A0KXF8rJPa3eafXaWIfyXNFYKUsSyLOsdAZ8ToKEGRFtkzy7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9149.eurprd04.prod.outlook.com (2603:10a6:150:24::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Fri, 20 May
 2022 08:05:28 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::5557:2d1:efed:96a6%7]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 08:05:28 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 04/10] Squash to "mptcp: add bpf_mptcp_sched_ops"
Date: Fri, 20 May 2022 16:04:49 +0800
Message-ID: <6fd9a8cd42485823f673d6dbae701dad45fb4dfa.1653033459.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1653033459.git.geliang.tang@suse.com>
References: <cover.1653033459.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0023.apcprd06.prod.outlook.com
 (2603:1096:202:2e::35) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7c5be29-6fea-493b-92e9-08da3a3780ae
X-MS-TrafficTypeDiagnostic: GV1PR04MB9149:EE_
X-Microsoft-Antispam-PRVS:
	<GV1PR04MB9149612E171443375800DB82F8D39@GV1PR04MB9149.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SQJzF1grYueZrI9NKmdzYOuFjULKoPVSasqjiMMGubchy5b6lAxTNiux1GVJujYbwH4lbSSXlQb4RmhVBHbqQWnAudX3PqxO02Sju3fDm5ckd5PfLpv8tJOH7KAfM7aWSN0HGJHg3hrCbiNdxUZcnKgmSxCvO65YE4Os4b4tyqJlbHynRavMXLyRWrL8CTTNShXud/6+kUVg+dMBw6OHwcYOYKjYbBKKvcwWGMAIf1+QtOuPwMUvMeGKhj1EWtI564+/rGLabbFHqbCI8a+DRcmw1z7LVR6luBJHFA7cKxxR8KpAL6iCX7wbybHiWDP535NiOqO8Hh9VToG8Ayu3UVraD7ddh0uOaQmuaxyUdWKtKc39gAM8VJ0nn6v/57HirWl0fm1ml7jhlXAlthwRHYWmpbEZYSqyvrcSjIyofPyXnU3sYmTBM38R/GgUOSBIr8ML109lkWIYKw2Elduxxb5cLdE3s+Yk4L6kwp2SKuYYLrtAlifzuMAVwwDO6JEWWJCuTE+q2jMgB/vpjcnJ/Mb8KjebVTiwN+ZI3gAaG2yxcYwDApecIOaN8rWhVnFudAk2LoTFIqi0s/0eimW0cybhJCktwJloP2Fy4GDTLOtlL2uUs6/+5f7DigzTspN5Q/G+uLzmNx8wovcQrifH0Yu2+oMU0SymU3RCsFZCD0DUMbkgHbPS/Q6e4dnEm6raAIbA7gjbZHzk3JH/tTW/0A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(107886003)(2616005)(26005)(5660300002)(83380400001)(86362001)(6512007)(316002)(186003)(4744005)(66476007)(4326008)(508600001)(36756003)(8676002)(66556008)(38100700002)(6666004)(66946007)(2906002)(6916009)(6506007)(6486002)(8936002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OP5sXBXWCsQWVTB0evdVjGxTcVEN5pto26E7V9kD2Ps/Gq/HkpjoPXNiasSE?=
 =?us-ascii?Q?UC39VoeSL+l9Mo4rMwJPNJuR75eWIjMwewqSSYEMNXTCJwKpWtK4ybAAueG/?=
 =?us-ascii?Q?1+s8RwHK+5Yv+d/i5AyM49y+Kmw/CjOw0bTZ7k+P8YhxOi0RMgMAB0/+UqjQ?=
 =?us-ascii?Q?vlzx0qOzgVxZ7SHiiL+kggfwB2O+wRDeRPynBTXXCWTx2+LELEL/H+fy79m0?=
 =?us-ascii?Q?SPYPUYljKN7mSjfImivoR2clhzVampAELthJMkiCDQJ20ht/qgUoulcymGhD?=
 =?us-ascii?Q?4JZuVC/S4KjoxkwXgaM4l/8sY1doB7UV7Hlt9lzTN7veugyaVFEznrhxlI0i?=
 =?us-ascii?Q?hh+gOIv56MIQw61mLRTvOL2K2vIjWdjovDLhAvXoI/ymdvsqIngAqeT4n09j?=
 =?us-ascii?Q?c0jnYigVnDVT+7T/d0hra9zxj71n279N+70xub3q2bHswNgdD99MBkhS7C+l?=
 =?us-ascii?Q?LHmlzjo6EbkUexOis/FdLuz8H3gnWyzuRtc0bCf+ddHwpU3gliN4bz9eH1NG?=
 =?us-ascii?Q?Rp06S6pXC+5SC8/kZTahYRl8hNpFR+UFhmou+csqyyikGhNwp7joc4tJYobe?=
 =?us-ascii?Q?mcwWSqwuf6eJrSqMZBsuSqlGqyKIans0nuMloXflM1EJ6Khg8kgEk3rHh/GK?=
 =?us-ascii?Q?KlDGqv61GgE3QHti1EsgoveZ2r701HlWvH7r/4PdQiK3rM+7lQ3JJVfWb/dE?=
 =?us-ascii?Q?a/FNjkvPdFS7j3yEIl/ZCwiqaMCGpJIUMPTvFEoFdy5WFuYzcNfIhfjL85cf?=
 =?us-ascii?Q?I44QmaxTI/5oVW+s5IdS6ImuiulUtK+eqI4VBclHbiReCLKr2g6pqMjzc6mf?=
 =?us-ascii?Q?+atM4lIn66j+NHq01hT9+FC3QsLeMiebYReFPU14wfxg4NI73vfjNMkkOCWS?=
 =?us-ascii?Q?AxwnxQCreWYwsIK9uu6ogLB/Rfr914cVSs8dW5AAtytxtJHvS2oBijF49g8E?=
 =?us-ascii?Q?iQTr31oIYaJd/EUeSkjpnrX8i0GX3C4/8OZlqL9tGFIbZaRIFf4M8vkqq/w2?=
 =?us-ascii?Q?R0i3x6X0n7exTEUTaXZn5LgzBQ55gBs5aNPl4vmdxgYzJcsML/7wf8yK8BnB?=
 =?us-ascii?Q?UDm0co9eccjfIEcV4xRSJDCj4Zz1Oh/omyC8tvThDIoZ9yfpR1BPX/mShJh8?=
 =?us-ascii?Q?NcZ/f1xcVGeWDnkNif3tvCjy+JDs7siQEHd5WcZadxABVkW8yoNmx++Ssyqo?=
 =?us-ascii?Q?YBQ1yclxWXmcYLm7+/ipFSrPQl+e2qFe52E9+C7uJVCAzzNkHQ9opFzgC6Jo?=
 =?us-ascii?Q?cScmhea0r+bYnpCwjLRdPWer5BffNOv3BFBu0uVL3QI9kBVPEDQ30L2AzcKM?=
 =?us-ascii?Q?7qlRCwcp1mqhBklqtuQQkgFzSFS0PRAMHlnpCtEfiecbcTA9EG7QhR6lZ6OG?=
 =?us-ascii?Q?ztZ8Kfw1rkHyy/BlmKnthL1mSzwNLFq8XXbXcx0JO4sfukdtJmWqeP7tNSH7?=
 =?us-ascii?Q?NYvt8MngjStCfaIbdIabtZ07qd9+EuOq1TBC+Oho0O3R9BQUxuDgvJDM5Ulg?=
 =?us-ascii?Q?NpgzaH3fDq4ls4v9bH/kGl7+My+PcVeuGcQEzkabHhUsd+BOdov4kXprxQrj?=
 =?us-ascii?Q?/BHQ3k1iv+gxeF0vnA3kAdUbG5QFUIu9dMOc/kRVS/wyppLDL4nX6b+ldGw5?=
 =?us-ascii?Q?UwcYVp4jNWtS/+aGxZb94ByIa6PN9rQw0aje5Io5awidq+7PZiyuYG2SR0js?=
 =?us-ascii?Q?JfxHUus/gnVirRw4RnQWBLXp97RxYgQ3XB3msahLLOEFPGMFVkNFO3IR6jzn?=
 =?us-ascii?Q?mkas2Rbt8O9rw51CWOE0wMVNrhH2MtA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c5be29-6fea-493b-92e9-08da3a3780ae
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 08:05:28.4445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23BZHxSZdIO9tOsOR/0DwArOUk1YfO5ubPrRKI5MqwlhYOSr4F0A1L2AQc3xfywqURHY8O2/u9oxf2t37rBctQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9149

Use bitmap instead of sock in struct mptcp_sched_data.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 338146d173f4..8a19ee98c3ad 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -52,11 +52,8 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_=
verifier_log *log,
 	}
=20
 	switch (off) {
-	case offsetof(struct mptcp_sched_data, sock):
-		end =3D offsetofend(struct mptcp_sched_data, sock);
-		break;
-	case offsetof(struct mptcp_sched_data, call_again):
-		end =3D offsetofend(struct mptcp_sched_data, call_again);
+	case offsetof(struct mptcp_sched_data, bitmap):
+		end =3D offsetofend(struct mptcp_sched_data, bitmap);
 		break;
 	default:
 		bpf_log(log, "no write support to mptcp_sched_data at off %d\n", off);
--=20
2.34.1

