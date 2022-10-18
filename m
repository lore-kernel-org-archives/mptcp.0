Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DDF4A24
	for <mptcp@lists.linux.dev>; Tue, 18 Oct 2022 11:03:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBM1J9Z40hMoTzr0EGXpJsB1tSC6IlsiMLiYIgtOW4hxGlA1f908XvE4aaaQW+TgLPyywCzZCeF+8Hzdv08pEkzj26Pdz+kV0hx0NEynry85KeH+i0YVC+u0hNZkATA//RJ3EeC8EYhclzXbWa85IriM/ZwwoUv4ij456f1x6xzSm2tzmCxaBxm+EZV3UMzZOKfPOX9R1UQVxWxFtGg4iZZC4kNWi8m6RW/OAB/wNJqtkbS5Ji2OTZ5lt6lVXQxzYwq7xKFRQUSWJ44p7bUvgJEYB8msy66A6MpvjRtEjtSfUyBghB8rFuJ1AXLsh/Rvy2nDNoDMK5DwY9IIAqNc7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DUDj7dDw4RxUBo8Uvh8oU7TYmiFNVL0XXd2PV8vpp0=;
 b=DfmQetaJuqLIkZu32/2MgexL4yp+OZGR+VtWHvIButN2jyZ5NQhJKoGNXFS06e4aNrR/hFSn83AXUJgZIJkVgktXt6ZB2vC23nc/P6vQ5a5BW33Gg/GTlEKVoeJAuJwfqJsaRSA76J1hAMxFTf0kV3cfhNgURcXHehgiLO8zmwJ7BT4wjV8FbdtFHSx/5g8oaESiUGot6rDLu1a+wabZqDkze4J63NnRBsWX/66sZPUg3z7/B8AvbScnySik3d3lvbjRC5q0YPhaq6l2odSJ6yANyAkLYAgEi/yUqyplzgiYZcKO2DktbX6OH00+cdk3eyRoA/1ULGwv659AF4WSTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DUDj7dDw4RxUBo8Uvh8oU7TYmiFNVL0XXd2PV8vpp0=;
 b=UyCc7Gquzf6HgydUIfUvjMqm+c4PLp7+i56c5W3V2sy18MB8cMV/xT9M5JGbITZUon+5qhqWJqWbPwoec8UHRlZXQphcIc3RPM4qM8ukLpdAzcIgJWg3OW+x+g91KZcwuFSyRqt1tzkGzHscRuOWr1h4CXraT91PnLFHdmaJVVhD2Z43wJH775nxhnj+mpDen3R0W8yzc9IgeBH+RnrPXMh3osYTCxY02+R3+rKgcDhnmOTdwccGE5xODbvK4gwf5Xv9uLDnRHm0apn7LAIWpUcXN+NVGiAeopyBtvk8BBWQwxrn2YC+LInMGaG2egVts9BPAXOJk2k5P+wxhWaxZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7369.eurprd04.prod.outlook.com (2603:10a6:102:89::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 11:03:50 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::645c:cc06:a616:fe45%7]) with mapi id 15.20.5723.032; Tue, 18 Oct 2022
 11:03:50 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v9 3/4] mptcp: change 'first' as a parameter
Date: Tue, 18 Oct 2022 19:03:11 +0800
Message-Id: <20221018110312.22510-4-geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221018110312.22510-1-geliang.tang@suse.com>
References: <20221018110312.22510-1-geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0037.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7369:EE_
X-MS-Office365-Filtering-Correlation-Id: 3663cc26-9b1c-4aa1-bddd-08dab0f86fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VpVwOLgg6LgzxgWvN/eRB7cqub36GzN6u3/A142LDatdrfgG//sqAsxqiYruH1G4/IV5YcI1GXs51Gtl/i29oCMIxK1ro3TFEQWkANz7wzEw+RcnwsNmKRKVC5VLUCzhk7aN9ngxZIRthhOQyDvISw4VK/5W70pyX5Erg60c+BGLYnEWqexKjh0IgB2It7lOYk5rUWdK6bV0ADGCWg0eZJgZssYPJWEAwmSmjmw4J3xLIOs4zpwfbn8Y+ceTk0ZQKYo9qUpKvquKSb9cj8LZpP8TsVHFoG8sUMqjnT9gOpEyQdZdf7zMnQ8IBiATxBHYw3E/U2vsR4068VSJDzcWMtWxm54d2K2ovbPUxjsz1QWqbqcp/i/JY0o320MTlecZsJbuUTF0mnRHO6x6m7ofZ0AhwquiHJmUmQGVMGKJh9dYdhPKKhOSkgOZBmJpcZMTf7WvnLqZN+Ag48aySixnda/H/Vdrw6TAJ+LO37KBowvzXktPCOY7xJmpUz9zwMuLX3KZ/3IZTrE57RP+FQ8Yuid47PNOI3H4dTCABcr/9wgLPumGNW58FOsH8Kzrev8ehu/KBiVa5ah+q0XOG1drJlprY1SbGsJwZPB3gjnO7EJq70j0zppOQRMdQX8ni0AHEi+NXsik+YZqCL0XlWHNb7VGt/onjLKO0lAdVLayi6FNRudf7gSV7jE0B1eg4hCv0BNjOSfm+7PONYvMZ0J6Qt3sS8FIiYfYzjSXY9VVhi7b2udDKBNNcRG0j3hQIRoM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199015)(36756003)(86362001)(107886003)(6666004)(83380400001)(38100700002)(66946007)(66556008)(8676002)(5660300002)(316002)(8936002)(6916009)(44832011)(4326008)(6486002)(2906002)(186003)(1076003)(66476007)(2616005)(66899015)(6506007)(478600001)(26005)(6512007)(41300700001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?azDbhDfYESJgGQdHgRo3hTK9TT3Th4pZsu9/kCWkiUIcjfDAudYghvMLS0l6?=
 =?us-ascii?Q?z9kAlWvDtnmKm+8VmFirzVXyorIvrs5krCP9tlfunks6SCki0cQUJ+Q9FzQE?=
 =?us-ascii?Q?5B88miqGTcYSkt1EcjTdNmI9MXsLu50kv4VWKt27aERXK4OveX0KVoDytQym?=
 =?us-ascii?Q?YaUCMDOo0iPam7PWIKNNhIISlLgw4u/3qvSaan+Wipg3FA98/UOcgwkIXTSR?=
 =?us-ascii?Q?f/KFLehTm2DhDE/zEmJxADXaxPRn+ZPeelCLPcP74m+6UB9OxSxM4AelvpVy?=
 =?us-ascii?Q?OtQ8dswjhAiZOvXKtu8xmPbIjn1dTomWtSpPjtYs48HJOkGgzpE6klHutid4?=
 =?us-ascii?Q?VWZaORiqVmqhsgrcVpwl6gA63xXXYciKz949mG9Q06b/v+dlOFTZ0WZ+L+1P?=
 =?us-ascii?Q?pb1D6goKCiu8tUJ1Fd+yznDl5xumVmsjdU3AraOn0aC0VeVFVwqt/jQLfTq1?=
 =?us-ascii?Q?mwoUlJ2TU8Y0FO+OAIFvh1KP8jyr9/sC4fFuyl4559cz/DNhCTtZKqo0gP4n?=
 =?us-ascii?Q?OY/bpBWdR9Rro2RzmmMa3dFcXAaiPwX7nbAoZ+OT8JnoUkOphOCQ17QL7lxI?=
 =?us-ascii?Q?EdPNSdbePQu+W2CIAz3K6F6sj4uqUX326uYk+FHt+Y2dKWM8ZO+usdNGbYP1?=
 =?us-ascii?Q?A+UH58s146um5BQi3fhxzvFJOBYosUofLVLgixNem+mhQHnRHgzM+0X8RvW/?=
 =?us-ascii?Q?I+TBfZNKPfDnJo4owetlS+PIDnYYXqP7GSWJw+8FcfuR83dQTJZIxcxHp+BN?=
 =?us-ascii?Q?NNqFAgHT3ZE6g13m2q1GQg+D/ZgNCkRvoqaUPqpoqfaN/gaQ9I+nQ5CWxiNe?=
 =?us-ascii?Q?Z65VnFTI4+BAWyduUKI+n6ouqfpUJ2sB6gZgXIL1GAOEYpxIDzmdO/yNWrFW?=
 =?us-ascii?Q?Ob2v8yAB88G2Qxza+fDejj77kHbNRhmCoMyolqpgEO3kRJL5AMzis4ajEbee?=
 =?us-ascii?Q?uUo2pnTS4uvB5o/1Gb/1JmMryuIeRzvnKjYBrpFBAKcZuvS8Y/vgc+wmcIpG?=
 =?us-ascii?Q?6aIH1BNC/MZjiCAOQplyr+JkBQO8j1ivNUkDkvbxbPbsvgFSvBMYdV+yjfeR?=
 =?us-ascii?Q?vASU67FypZwebaOY87338i428/OalZduRr1KcY70xUAWMBQyb+wKFhF2QHZq?=
 =?us-ascii?Q?Tmr76z8ywFfRy4KuOcym91osO1jXEIfROIX1topC/RG8kjivfJxA+yRxprke?=
 =?us-ascii?Q?eXe9qGMOhl+mViPY0N50wrjhhpnQD2zQfJMp+n4OJOF70677D44w+ikx/gmo?=
 =?us-ascii?Q?wGPa8tTHSdLuPHPG/GCH/t1oFjX0h0RLouD7F2OyGKmE9aQyQmkatRUk1lzF?=
 =?us-ascii?Q?BjCwhCaHcGoKueR1JqbzL/baIRZt4vW4oWb4ChuwaerdVQs9uWuDkuVhyG4f?=
 =?us-ascii?Q?Yut7j96uHq8U6WIl63LXS/fYNp4HnN1N1Crm49SXKUrOVM+SN+Jhi7xwHkyE?=
 =?us-ascii?Q?3qsodiJBv6pSYNDvEEiDyqiL/QqIcA6KWHPzu7EDJVx5WPEWWz7StS47/QZI?=
 =?us-ascii?Q?YnEKhAq6LwaDkmVHoyrlPdxxL9p6SR/eA5PmPaJ3DNqaflnYR3/NJ9uqTDfb?=
 =?us-ascii?Q?GDDHp5L/GkKvLvjA+rnBUwSb5mis+HPwOjXDp+p1zloZxrNR+19+QvIh249a?=
 =?us-ascii?Q?QQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3663cc26-9b1c-4aa1-bddd-08dab0f86fc4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 11:03:50.3326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tpfqVYBgHr3/EnoA20Idzg0MCiJIZcQBwy/HCl1qTbIKjbFNPPLgbZkDbOEXY77OwgCgoS3ZerUM7kOckXr8eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7369

The function mptcp_subflow_process_delegated() uses the input ssk first,
while __mptcp_check_push() invokes the packet scheduler first.

So this patch adds a new parameter named 'first' for the function
__mptcp_subflow_push_pending() to deal with these two cases separately.

With this change, the code that invokes the packet scheduler in the
function __mptcp_check_push() can be removed, and replaced by invoking
__mptcp_subflow_push_pending() directly.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 11be5b9c379d..ddeb8b36a677 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1593,7 +1593,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 		__mptcp_check_send_data_fin(sk);
 }
 
-static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
+static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_sendmsg_info info = {
@@ -1602,7 +1602,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 	struct mptcp_data_frag *dfrag;
 	struct sock *xmit_ssk;
 	int len, copied = 0;
-	bool first = true;
 
 	info.flags = 0;
 	while ((dfrag = mptcp_send_head(sk))) {
@@ -1612,8 +1611,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
 		while (len > 0) {
 			int ret = 0;
 
-			/* the caller already invoked the packet scheduler,
-			 * check for a different subflow usage only after
+			/* check for a different subflow usage only after
 			 * spooling the first chunk of data
 			 */
 			xmit_ssk = first ? ssk : mptcp_subflow_get_send(msk);
@@ -3217,16 +3215,10 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
 	if (!mptcp_send_head(sk))
 		return;
 
-	if (!sock_owned_by_user(sk)) {
-		struct sock *xmit_ssk = mptcp_subflow_get_send(mptcp_sk(sk));
-
-		if (xmit_ssk == ssk)
-			__mptcp_subflow_push_pending(sk, ssk);
-		else if (xmit_ssk)
-			mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk), MPTCP_DELEGATE_SEND);
-	} else {
+	if (!sock_owned_by_user(sk))
+		__mptcp_subflow_push_pending(sk, ssk, false);
+	else
 		__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
-	}
 }
 
 #define MPTCP_FLAGS_PROCESS_CTX_NEED (BIT(MPTCP_PUSH_PENDING) | \
@@ -3317,7 +3309,7 @@ void mptcp_subflow_process_delegated(struct sock *ssk)
 	if (test_bit(MPTCP_DELEGATE_SEND, &subflow->delegated_status)) {
 		mptcp_data_lock(sk);
 		if (!sock_owned_by_user(sk))
-			__mptcp_subflow_push_pending(sk, ssk);
+			__mptcp_subflow_push_pending(sk, ssk, true);
 		else
 			__set_bit(MPTCP_PUSH_PENDING, &mptcp_sk(sk)->cb_flags);
 		mptcp_data_unlock(sk);
-- 
2.35.3

