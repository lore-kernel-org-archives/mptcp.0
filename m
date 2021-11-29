Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3936E72
	for <mptcp@lists.linux.dev>; Mon, 29 Nov 2021 03:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1638157228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zfWGWVyuMRk9ThHDAdLZTbVWpNAuIsQtXzqtwYRsXyk=;
	b=HUytohb14zNl5Z6bvcd9vQ7ad8PK7gbMLooHC80ZuSAmDekyHfZGItoK3/HRNC+jaK0mpl
	r+pgA8jkQ1UCAWPss0GFMjGLMTzSOqgTMhkv974E3Wr5+byARoaN4OF+vIl23xF7loQhyK
	zVPMMc7fjmTbpbLchmCtyQZgNJ+HjL8=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2053.outbound.protection.outlook.com [104.47.13.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-a8Td1uurMvGXMqZaGgGljw-1; Mon, 29 Nov 2021 04:40:27 +0100
X-MC-Unique: a8Td1uurMvGXMqZaGgGljw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nkw7sT/1Y36xpTkI173qbDvdbEkAF7dFzXBcd9Tp3XK4fHwYZqFEXQeD9q97uyxrLuGdL788NNqUs32P5LmGDW5Nzgw815fNWfpiF7StFuwPdthW/dzhksjsdLYMalBPDntIKdWUWXkTffnp/clqgmBc8xVGSznig2YoCsJhoRWzzr0qPYEHs0iewNMVbn8fj1XIPwxYWhNTQ328G/BfEXQqtgW9S2J4vIbq+YMXjWnLOHLBtxYSRVwO51fWJDN3nbeWwZVmDi0qhqwOXb/zsFvTeqxg4gxxjoGF8t1A44yRNRGAhgF+4sarkUx64ocu0wA/ysZnhFC5x64/n9/IMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvqNuJsRbq/uZGVDRAybLAwi5zMRSSNP/vNZW/KO+M0=;
 b=g2p9jbYXcXIdQMS451sVsV6hpdV6dzAYgFX5DAQdu07DjLU1vjqlNcLWmTTqbFfO/hErPbQdZt2Q7QRSwvUfHH/VjyVpbeF0COK76YQ6wuELn6wIpFh07yzPXn7Dxmb0s65HMGnxI7NIvwn0ecMwg2AsL59qUQvGAezr9yWRF9k99IUTO9hhKUIlfqQpEm55WkswLL1XnX5jeIutMjtx/JhJ/6+K5u8GeVCqRT4M0cVwJlaUZohlpbQbvCoBnDnCf4QZwJrcWdOSxKZqJaFAd7fEg3R9WAEUsWKKwGxYEHDBpQ7EsiqzCYjy/p6N6RFIwpwlYy1ZobxVogaJfEd0EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2507.eurprd04.prod.outlook.com (2603:10a6:3:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 03:40:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::59a0:4185:3e03:7366%6]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 03:40:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 1/2] Squash to "mptcp: implement fastclose xmit path"
Date: Mon, 29 Nov 2021 11:39:58 +0800
Message-ID: <5a8c6024481d6106c662c3e892ae5e499b4a7f76.1638156809.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1638156809.git.geliang.tang@suse.com>
References: <cover.1638156809.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0003.apcprd03.prod.outlook.com
 (2603:1096:202::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (60.251.47.115) by HK2PR0302CA0003.apcprd03.prod.outlook.com (2603:1096:202::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.7 via Frontend Transport; Mon, 29 Nov 2021 03:40:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2171200d-50e7-4361-f285-08d9b2e9fb6f
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2507:
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB25076CE82B7928325243ABC4F8669@HE1PR0401MB2507.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	85i2wTTKRQvOrq+8EHkgPTpfPI6qREkMRZLyJcUaN5ckDxZJcxj6gFlhyWWsgDd2I97wPEeVrwjUW9eAv6aluNO3Ao48PkW4Gh7sq0MtSd0IdGjpavELy9XhHUbqLWsdmRXr15temiph/Ya56TLccgiVuytaiVO3EU43Gf+nSqHCB+278Gy4ffonRXilY9MVcJoMKxN59JHH+xTHX/8EzDOxFJgYF2uCVEb7Q+h659qClGUM7YXumvGCbne/DiJgPMQtT/1PcfFZTNnuVAHWcdgldNVlXykTdYrYhGqt0ERm2ag6G4G6/yW5Ti5QkKE31bezmRrhFzZfImKixyrwHnL6JaXZj8EsBL/3/VliPYzAP29IfDc+/ssZRmP5N8KuHq67fNxBIfA6ErnrkMlNPxe/kF2uz00NzTrJZKsvZdWkrshAmoIxjlKqjRgmDI6C8Q4yVhaONxdkLu87uH8RzRLu0Wc8SXYYTloyZ8YDlSTRN8aL9679UChXbfUysIAGh/s8p0T97cPSwBP+1gmTDPdJkQ0L++avqbhWXtSmd/PVgF+YW4STZ1eiqLeTK8GDIg58Q9++nAs4AdusW90WYNq7A/7nV0mgB4jjiHjXetJQEZaPZhvvhSX75LwRUFtwFhNpsxZkH2XATcbwt2NuRQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(2906002)(4326008)(36756003)(6916009)(8936002)(6486002)(83380400001)(55236004)(38100700002)(26005)(2616005)(107886003)(956004)(44832011)(186003)(86362001)(66556008)(66476007)(66946007)(316002)(5660300002)(6666004)(6496006)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/vkPp1/LSdeTxwHHZJjcXtQfp7S8wyveq+0McDa6OL/7TOlkRob0L+W25Wyj?=
 =?us-ascii?Q?KwraodmgyDCHtxhpt/SHCarU/HuTboQwtisVQZokS4louQ3pVNObmszBkwfx?=
 =?us-ascii?Q?Pv6juyfuhhhI9uySB46fRfDjZl2wRTyH0yX2kaeikuE0d/IXb8zl4rmJfGl3?=
 =?us-ascii?Q?Pe7A2zbbfTHCOcxo7Xf8B1iwIowshR7uxFOyYHIFOuOR8yLtCM+RzTH4IqoX?=
 =?us-ascii?Q?g5RYpvIrkXDOapjw9zcbLjDQvixzKCDoiQKp6Mh4tFucX24FG9kF1iVsD+Sv?=
 =?us-ascii?Q?z+oXxBQiSPEPOrw/j1gASwYCHpvbUOXVwpYPqwWO7158p8om+oDqM3PzX7Ls?=
 =?us-ascii?Q?PPD5UAgi1+wzqbo2XzMAijk3WhSIGVJWAf+HL4mAaRfcts+axM36G2fxPs5z?=
 =?us-ascii?Q?qijdTa7csxbxD3o0DOjQYC40abyk5aHYj1k/Iso4yMUPgr/IijIlAS+ERKVk?=
 =?us-ascii?Q?RVslrLK3Vv+e/P+PwsH8j1CAFsoWpLuDhp+cDQC/DsBqyRbC7tWpoQNrc4K8?=
 =?us-ascii?Q?D8CeGyXwwKUyblWNybz+4FpJrkidMTtAIEJc+MAgrV+fbwm0A3/5EWxx3nLJ?=
 =?us-ascii?Q?l2kae/R67XeWkGQcxbbibIb8eGuLW1pTEQ3VjreD3wou4mI9u5qBNVS9Y6Ws?=
 =?us-ascii?Q?EUAKsFPyNu8koWuxA5ZXK1G+LwvCwygdqVIDWuXc3eV5XC7VLzA4PUIguhsU?=
 =?us-ascii?Q?C+a53Kvjiq3l84QXUGdmQ9FkeVwyo3HgAF0yoGw3RZ5jwZmY109mq+W5NsQP?=
 =?us-ascii?Q?X33/bxUKlCxkgz8oY2XDZhryBJSvT0IowE8NrGhXmWkF5o0IgYYeuK2RQ8z0?=
 =?us-ascii?Q?pj15bgjl2RTkzF8mj24AJYcNjjA45EKJalj4NbBn0svpcJ/QCH2ghgZ6iP4c?=
 =?us-ascii?Q?vqG9pi0uBaR6/1AcFHlgB1w/33SUXWItxdiHe1VPiSo/LGACSsIM/Z4IGv/6?=
 =?us-ascii?Q?O97oIQ1iF6SYKNePQ3l25Lu3bTh2k8hpBvwCOm5cbcgjjoTNKlsrqygLiK0y?=
 =?us-ascii?Q?ApP+ad6D+T/0+Q1qMZi73VwEPKknN6y1wySEBA8Gt8zeM8NyYVn6UdEzLn3m?=
 =?us-ascii?Q?BlnjT49zH72Sg0VWmbXKCD/FETdqrKg4IJoFxr4cXOBUfvD5B2JA3CwfHBhO?=
 =?us-ascii?Q?FlhUuYBX08OI7URSnvU//n7rOkwHZDKRe1qq86hgx+xiMJo7JxCrF6TwUF3M?=
 =?us-ascii?Q?8Sw5U84GVTRSmIGwpnvhlpR8bZ/cHbJamsbxCowfyc6bGHrsEYysVHXKC5Ar?=
 =?us-ascii?Q?pAvRk7HjebbQJBeeQHwcJkCuTkWti0rJLWgX2Y0TfUORRvW5eD8N7ffurMKo?=
 =?us-ascii?Q?DiuA+IVJnIpuZCFX0IIG/Gx1nw1XngAHzEEj2lkcwvEV9WFzlNtaYE8jbvhU?=
 =?us-ascii?Q?DLIO0tCoKRHiVWpfP2bq8zBuvxGLHdCGbb5GLfbNhRZEnJ6i6tmqK05VZgmO?=
 =?us-ascii?Q?wMDg3oHwaLfNvWnpsM7cwF4A11SqoWlGJOWs0j88+Zx4mp+r8iXDSyLrifM7?=
 =?us-ascii?Q?cD2yCib0VT/+ZMd1qZ3zCWYMAt8hADIb6mbtiFtrce0i+keywzF2m1iVTalr?=
 =?us-ascii?Q?QRnfSqp/caIL1in+jyn5Lbl4TVn1eCxnU1gTp1ms6J2fgm8VcBgMK5VGpidu?=
 =?us-ascii?Q?Skfk9DeYZR2+hQdM+ZztA4E=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2171200d-50e7-4361-f285-08d9b2e9fb6f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 03:40:26.5907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKnVHZokWuuUUBW4SwpfCpkEdbkJ7S2bH0ecQKbqav2BRghARKDyGEmLJeibpW1uJ/1h+/kWw/pNuuOA4H3Rrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2507

As described in RFC8684, 3.7 Fallback:

'''
Therefore, it is not possible to recover the subflow, and the affected
subflow must be immediately closed with a RST that includes an MP_FAIL
option (Figure 16), which defines the data sequence number at the start
of the segment (defined by the Data Sequence Mapping) that had the
checksum failure.
'''

MP_FAIL could be sent with MP_RST at the same time.

This patch fixed it.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/options.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8a1020e4285c..dc998a14f4cb 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -829,8 +829,11 @@ bool mptcp_established_options(struct sock *sk, struct=
 sk_buff *skb,
=20
 	if (unlikely(skb && TCP_SKB_CB(skb)->tcp_flags & TCPHDR_RST)) {
 		if (mptcp_established_options_fastclose(sk, &opt_size, remaining, opts) =
||
-		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts) ||
-		    mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) =
{
+		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
+			*size +=3D opt_size;
+			remaining -=3D opt_size;
+		}
+		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) =
{
 			*size +=3D opt_size;
 			remaining -=3D opt_size;
 		}
--=20
2.31.1

