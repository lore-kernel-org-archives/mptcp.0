Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE2072
	for <mptcp@lists.linux.dev>; Mon, 18 Oct 2021 12:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1634560486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VuBYQ/0BbTvkbfJzQ92KdOhxj1OZ9fC6LoJQZxRqaJc=;
	b=OoInlnVrZj7AJknEmdvLurrUolHmIuYqp/2Jkiy4z1vXZvxL1FqGoBzubSSWeXsoMocW4p
	7k7EHjYzckyL2vqavOv/eHfSMYqGXopws1MrF/NBxZBRBJ2y5lVAQgWRPe/yzDJF/tS631
	SiZTUjyoI1I20Z/TFwwsGOaJbEmXRmc=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2050.outbound.protection.outlook.com [104.47.2.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-32-KbJNlx-9O0mp8ufTIcjO0A-1; Mon, 18 Oct 2021 14:34:46 +0200
X-MC-Unique: KbJNlx-9O0mp8ufTIcjO0A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFK19lghzP0fbHnBf6UHjbLD2i5ef7NT5d1uHRp2rSmbvHCJwHg4XRUe+hZaafCe8jsBuUMW0ZSD+PT4jpitHEskD8T5kS7PYr54zmg5jyTGgm1+YOjJG5aof5jMLclsSEGlR7tyeFoJEeVLj/ptt17OcC+mb2O3E0DuBLHfMxN674Vv7/L+Zv9NNNcnxyCmdMLKakiANpuKwVMcbnU4MX3CRovFziYv0fslyDzyw30mE7MUxGmTGrt7dchy9XjopykvW+S6BASW1oPAdlVd18Rv8nC4h3cOs/mDR3IGAg4VYXzhVJUJyXovIQC4EJryg5T+ubVk/miVwYnKyiBUKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FsLEcP/fJTPjLrK9vckC5QqOoPd2i6jdAZBSjrKIAk=;
 b=gd5waeB+o8zXBLYCw/lrVA+9+G3JQYwJm+4oEb44BQ3wnqfU3t5K8bZi133jJwhMLe54BJx4w8Sd9Is1imth9OxanuOuT3Jfki0N3QxLouWIUS94M6QsievMv/KECEgrtL/KYW3fkFNykvqvy0uFKy/W3J5MsocM3wTo382NmuKiQOaao22XS0SN3mjXhI0suYUr483DuZ7D6dW96DW0FJIk719cXIbdMU8te8Je97nIYfEKPQG9M3ktLbXgBznmE0ejDPkMLeKjSdCFSif+l+1Y2M4f0/UXopqaoEuLAYAOHCDt+IVgFTtymAUb6cfQiYjXdM8JGTFrELGSpFq4dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: lists.linux.dev; dkim=none (message not signed)
 header.d=none;lists.linux.dev; dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB2956.eurprd04.prod.outlook.com (2603:10a6:7:1f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Mon, 18 Oct
 2021 12:34:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 12:34:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 8/8] DO-NOT-MERGE: mptcp: mp_fail test
Date: Mon, 18 Oct 2021 12:33:15 +0800
Message-ID: <2e9a15d32cd39483dd1e18174d6c73b33e0566b5.1634531093.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634531093.git.geliang.tang@suse.com>
References: <cover.1634531093.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:202:2e::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (2408:8207:2546:b4d0:1867:9999:db2f:de88) by HK2PR06CA0013.apcprd06.prod.outlook.com (2603:1096:202:2e::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18 via Frontend Transport; Mon, 18 Oct 2021 12:34:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5282def2-43dc-4bd9-5bb8-08d99233aa5a
X-MS-TrafficTypeDiagnostic: HE1PR04MB2956:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB295670366E08E667E3041D3AF8BC9@HE1PR04MB2956.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6lFqlV/2Pi0rh5GWP/9+1NqlnkuLXeyviV10JxOIHCqJouJfb8V1tILwA8LtTyPAIoyZBz4ONUlR4kmL9UznXBlUSvo7AMPYJR/zIlGqU2KWFv/tOmyR1c55glY0ZzDfTawtR9X8PLs7G2KQapTm+3xLrsXdHBwJ28edZhIXLHYTYqiJmm+IQVPmAiC+i5gYWtB/Aaj3Nm345NZh8/eO/VndPhjDDwwAHeibM9P34sryqMxpE54H9ECscqHrtpXgBAOScE6ynInyenOoWUNxpqxyMMpDQce3h/A6ydpfYSIIggl21+Y54x9e/BVCeWYwK8G7RjzABe+uAcN72hePAVM4K+meRROh+KTD8KxvtjyuWsSxQRRjHSPG/OjL6a4NWxE0EuEcyaw+3Ujt4Abgaxbf2LYe6HfaE/PxuBjWGoQ7rQLlrrPPDcv6j2hgmBhEQUAJJM1F8YwDjOiAVh22+tVIsJmlO+OGBcqQYnwglKAKpXw7FcewxvHcYQd+SDwsk4Vhd22uI/kOniZvQDHV6ZPV4QhCBgax2SSjDHYDEJRpLr6IyVo6IpbxDfiXTVqlmwYeEa/kklNUn2XCkMfkrBe9ZL9FzAQrtpzsr+soeJQ+dbpr3fHw1stfrLrVLG5qK6VGmTd7w05kP+h9i1QyWQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(2906002)(8676002)(508600001)(86362001)(316002)(36756003)(66556008)(66476007)(8936002)(6666004)(186003)(6916009)(4326008)(38100700002)(6496006)(6486002)(2616005)(44832011)(107886003)(5660300002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m1HT1pbOWjmddxtKHM4lNJQd5UIHJyhf63++AKJmR5RnJKfNuTBNAkQoCMoB?=
 =?us-ascii?Q?PzrNM5ap/anDHbYrUVsC3CxLc/VazJnjP5K2/5e947bXPsIaA5hrqrdR4wIe?=
 =?us-ascii?Q?3ViQ70z9/4uzo5Xb6ZCdt2oZC+MzYhuDJrERNZf+Gek7H+/xt42Tjzoyr+qY?=
 =?us-ascii?Q?BqhEQDIMscHL4V98Dyqhcl7O5RcF0fsgJmRjtexn3FuofpRyKb31Wlnsxeou?=
 =?us-ascii?Q?Li/bjI0jfgftJna+OkNpUP1JBggoGDaJqw0lVak/yM7N7bDEKSe600i71y0L?=
 =?us-ascii?Q?ZBRUXn0Ks/891BxY7rfRvIZLzFvFdY2m/0sttv2x49vPi5l8AoOhe5muVymU?=
 =?us-ascii?Q?M6fwEefWJbJjPvisXJ3Vrx+9bkLxYL9K/oz3FepDmdotcgQz8cm0Upf71p2r?=
 =?us-ascii?Q?ZxPT/uDCGqWcDmXWGuAeCRqcMmpH5QOfdvGi1qrrzCeNtaqoX/Sb04meAGLC?=
 =?us-ascii?Q?n/JLP3XGts1ZaxFb4iHej44hKPhX7P1y4TpBa1Ak8TU2TESg2z49512t6U7/?=
 =?us-ascii?Q?uGvTXMtpyS3TTiKtjlmY2as4HxDHAmD339DWWZRodsMGbERL0dv+qzcDpsTk?=
 =?us-ascii?Q?86WFlatSdzVBG/yGgG0PmB3/4IHJMQkR691IWPfRu3MkqX6FNTGgApOlfWO5?=
 =?us-ascii?Q?FFLhHkpk7w+tG/dHt4U/izWCpFBsAxrsNidojU0rF70DxKYEUP0Zh7DL5JTH?=
 =?us-ascii?Q?YZLPmz49qV28FI3+Ha19/fOBw2Blv+5M0ZsRnw4jrnk2q2buDNGgDQ71rBX9?=
 =?us-ascii?Q?2dek1AdfVNxvfuB6UqkQZSfTGrg0Pc1gD6sxXcO6q4ZrKj+Pt1UjsLj4C+7A?=
 =?us-ascii?Q?muGyhkFWPqYuwxmfNEe5i+WlbW0jHI5CbOwjPtM1qA+x0You5qB34w+zv0FV?=
 =?us-ascii?Q?XEP8EcT6o94ytw798q5ZcLmdfuxvkx8wmy0Jic7t8Ybv4wLmlfbvlVlsjJzj?=
 =?us-ascii?Q?lxQBEXp50XnmuxlI6vQsmUHkpZrpPRpHPEC+863LnkeE0snuvYZHjpnJdFC3?=
 =?us-ascii?Q?PN3NDBzPOIU2vNCTNIOlRt8r9nEpmavUhnt5o1mKjwQbnzTWB8KfpvxuypDs?=
 =?us-ascii?Q?73+p+AniNnDak83bnlUKUAEaOpbYcSdOvbJ+eBeJ2CwI7xNfBW7NssqjJk92?=
 =?us-ascii?Q?iJuSovnOa9uSmvPyyI544NBzepGXBDmZaB7t+efBgvUZU/xRHhSuo1gQkc2F?=
 =?us-ascii?Q?a0stGUnc4l78b2nw0MdXHszTXRi6g00WjseOxx8JXdhfTbsP7dywuZZknzhU?=
 =?us-ascii?Q?ENALZ+HX9u59uGuizzLJerLxXOhcLeJ7AOEY4L6uvFW4zkzjAJO83VJ9y31P?=
 =?us-ascii?Q?Mt302u9jngGiRa4Aks2Ukc+6edMIIbmpgS6deRGffRxJD+om9kRDcGZ2Qcdi?=
 =?us-ascii?Q?4e29JVZWsOD5J13kXy5krJ/gpw/e?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5282def2-43dc-4bd9-5bb8-08d99233aa5a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 12:34:44.9751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GeRb/pcaKB4G+m1XFKe/+C03+BD6xJSn22hhNwht65bEcBT6nMWCHKB9GziigZH/eU49pHXdmlvO6fHiNFZyKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB2956

./mptcp_join.sh -Cf

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c                           |  9 +++++++++
 .../testing/selftests/net/mptcp/mptcp_join.sh  | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2283efda1bc9..fc3a4fb81fbb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1243,6 +1243,8 @@ static void mptcp_update_infinite_map(struct mptcp_so=
ck *msk,
 	__mptcp_do_fallback(msk);
 }
=20
+static int j;
+
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct mptcp_data_frag *dfrag,
 			      struct mptcp_sendmsg_info *info)
@@ -1377,6 +1379,13 @@ static int mptcp_sendmsg_frag(struct sock *sk, struc=
t sock *ssk,
 		mptcp_update_data_checksum(skb, copy);
 	if (mptcp_subflow_ctx(ssk)->send_infinite_map)
 		mptcp_update_infinite_map(msk, ssk, mpext);
+
+	pr_debug("%s j=3D%d", __func__, j++);
+	if (j =3D=3D 20)
+		skb->data_len =3D 1;
+	if (j > 40)
+		j =3D 0;
+
 	mptcp_subflow_ctx(ssk)->rel_write_seq +=3D copy;
 	return copy;
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index b3b351b868f9..3339633e87d4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -977,6 +977,24 @@ chk_link_usage()
=20
 subflows_tests()
 {
+	# 1 subflow
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+	chk_join_nr "1 subflow" 0 0 0
+
+	exit
+
+	# multiple subflows
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl limits 0 2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+	chk_join_nr "multiple subflows" 2 2 2
+
 	reset
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "no JOIN" "0" "0" "0"
--=20
2.31.1

