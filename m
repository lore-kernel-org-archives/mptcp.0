Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF581FD3
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 11:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1645097030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkDhkLOe3wktycDJ8qLssvnpH/ATYl+mWmo7Hw1mNpo=;
	b=gIPkSQfE0aehN9i9IFXupZrL35W/1xmD/Kp9vCAxXpMQAZ3iFRRIaotl8cdOEDjwmEtrKj
	YjfKP8MNRZek8CHS2ZvDlbKpzdLLGW9dHG/zHOAFQoQaFz8trNV90lh+QxoEIckc03vDTP
	YMubykoZK+b29YTK2f0unogNTrYY7GQ=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2059.outbound.protection.outlook.com [104.47.6.59]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-3-7XmpikM2M76oTFNDDaDmmg-1; Thu, 17 Feb 2022 12:23:49 +0100
X-MC-Unique: 7XmpikM2M76oTFNDDaDmmg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oP27IcGuE+eXHX3ewBs1Eh6T1ru/htZMNLrphsaIxykE+FwkU0ya9MmeD3qhOHQsCI6xGkuvSoCQp8JWwWM7SCtBmeOwacEwswR4VxAXL3xcGHK20mZ6HoPjxylTGJCddc0THULHD5QWVamFwU+zHh6M927XEuwH33wM8az+6iIEkx754zk5zU6HIjWO+oRFSpbLj6rUTeimQ/o4o+HPUisW5xdtajpM1UZl7F5SW3KGfzadK4boshje/1izTmmt/mEBwxKh1mIHEzIiVjcVlDYw3P0WgKvMt7UHURAYqFo/8moYlYnIYkja4E7pqv7iLzkB5D2Qm5TOeK8cDZ/dRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOFLrPlu6sWLU4J9NHdaoxLU33UCYjbK1OaYgwcWZKw=;
 b=M6HZcpKBZDjNUs+2+W7ZrXHFtUw5wVHYUjQ1OAgcGK7cZ/Y942DwYAy+Is9YODnnsEp/norJ8qHDsOJkBWdadXjHODe3uHanuM8OuOy9mSoAhm0730zdRQdAvVtBjsSvVXAE3ZHSkuH+vfEs3wtPA/2zeMJpYTj7ViLekg2OcuZwlMZB1i1eHT21Fxe1Z2I7ZpxLF7MKEijNQz++k8H4yIJa134KItjAMCAxRDMBBXMMqSpw6g6AFOIavsT4RK24tgTiHqvs90otkscpZism3GPZPZGFMuPydv4An//p1SgXw5KcXnuXCEqESLOUoJiWNOtbqZorRixG0d1DlXLNJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB9413.eurprd04.prod.outlook.com (2603:10a6:102:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Thu, 17 Feb
 2022 11:23:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Thu, 17 Feb 2022
 11:23:48 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [RFC mptcp-next v2 4/6] mptcp: add a new sysctl mp_fail_timeout
Date: Thu, 17 Feb 2022 19:23:42 +0800
Message-ID: <59946591122d6453baa10bfc3de3badda3bccd47.1645096378.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645096378.git.geliang.tang@suse.com>
References: <cover.1645096378.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0059.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bc5f2ae-a2d6-4a5a-9ee0-08d9f207f7e0
X-MS-TrafficTypeDiagnostic: PA4PR04MB9413:EE_
X-Microsoft-Antispam-PRVS:
	<PA4PR04MB94138F6103A080036E8B3488F8369@PA4PR04MB9413.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9W/MVAIfpWmrfCnnkKbSQszrkDAdVWj3hOYAh53mBCt3sS2ZMBmJyyMXlHXQGIqzMHNJewnftiPc9FnYlNxRThCOuu0KYBa8ZtAUAb/0GuNlplOEdzq/e8068X+9RE20q7Y1cavuEAZLbU5RuD/1Y7MIxf/8QenBmJ+ZPRLUPjmYqSNCDBXijNQJEitTGWTfMvN0VACsp5pKnjrnA5u5t75EpJqHeOaA50ncQLEf/JHAC/UzucBxZIb7RY9BHKgWRBU/DaW82WVVhlEfyolr+5gwao7d0m9RPxPCyOWwZ3ks/5+bncPju2APupEokLyxjGaHGFZO+UKhRsrIfNusuRT8KrV9ZjUKGKjoZ1e3I1FejZw9QK1+NKKpM2jqssercpVgQQYpu9++7/LM6xy0GV4dPl9s+clntH5c5wh25zpaGtGxwhXvmf5o/UfO/TZ+/7a2DyRPPvFiBMNGjjHRXGVlCzQghXZ8Ogb3NqkbRP+uaRWPFmu57SeM4ZOr5CoSPZDniahHXblX5rYOyp/UK+yp/af97ESG7viy7FLGxCF+5kl4t/5qthf5+7LZVbAfqT9wgNcL/QQkhphTbFFUblZsOP+Az4ZQTAfU+7mEisjnqqX27v581sUSFjHhyc6piMsKY7FBksD7t1AIBvfwmQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(2906002)(44832011)(6916009)(107886003)(316002)(6506007)(38100700002)(508600001)(8676002)(4326008)(66556008)(66476007)(66946007)(6486002)(6512007)(86362001)(2616005)(8936002)(6666004)(186003)(36756003)(26005)(83380400001)(55236004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bc7GlgsthIrMomBvbucNQTo17vsUUXJC0gMvRkW1eseFYtgTxDDeZL+kFNbC?=
 =?us-ascii?Q?NrUJHIyKrCh7yFSzEp/7KLEMVQ4DA5Nt/61nrML7D6pYTns6+I5KhP5/owgj?=
 =?us-ascii?Q?1Xfu+IimM8BmDQQmFGDf0jZbno0An0IEK6eKm+eJU7PeQBgBQ5ksH4wUIXyD?=
 =?us-ascii?Q?tri2mPUthXNx0SLlLVwOdFUcZnZ4rRDJA5wUHOC84FYkU7IbncTXu18Tl4iT?=
 =?us-ascii?Q?TdKPND44a3aAnb9cIDR5C2wLzPEi+ngzOdufzVaRgRSIQRmHm/prbBbE3/3Z?=
 =?us-ascii?Q?L2dUksJ8zJ2fEt8BUKFN+wi4cqrqwEBQXsAHxq1upMYMxvg1kqrNZ5QmMu5x?=
 =?us-ascii?Q?YWVECK2c0kLML+BxswCxyDC5/AQoCit1+wv3krvhPT1jLie+m6kEbIKV1bLC?=
 =?us-ascii?Q?h3Xm7KmAUTvcajTXvYeKcpWsIawG5GSRrNasSqdPOZvE9ujmqdjl+sfCmrhk?=
 =?us-ascii?Q?MsnfNoV7hipBSZzILubK4yuMy2xEGjbDqccw3qZ7IDQaxde/iGfaib6Yw8/8?=
 =?us-ascii?Q?+kwlxIpI3Mi8le7Vv2cJWvfs0J7MRMFg3hQ2Qa9+tef0utQ2vV02Cowgm7Gx?=
 =?us-ascii?Q?aXLt0SHG4a9HZgFPdoXiDwAFHhPpMu7Aa1ez+D+DvoeM3KNAs/yfgSks5Ip+?=
 =?us-ascii?Q?e906qimtwIvyCj88Igi9FkBN4d/5pdIN1f26NeN3IiEgNtbt5SJw3UkjLbEi?=
 =?us-ascii?Q?TZaLVOd7A8c59fVeKdhrgv0QoFIwTm4IMbVWuG3N+LXpuzsGaYmgEChNz/WE?=
 =?us-ascii?Q?1DDYd2ctC6vJAIEo7pbpmPvqbsx+2pq/5zXN+XNoiSVT9AmNbjYYUvIoaGd+?=
 =?us-ascii?Q?MfsotsEWXS8gH3x1i1tca/ji7+QmQfk6JinQDZgOyWVIo22uac7IzKc28+38?=
 =?us-ascii?Q?M+t5uE7e/FaDqiFlL0ugAH2R2Bfq3hduIdkSWQiLK43IvjHSnqRGqjRLJEW1?=
 =?us-ascii?Q?+6rTNh84OIgBHhvtNMwoWAbE4y61oB4X8nSjsrAbfu9852XKMLNFwZG64JD9?=
 =?us-ascii?Q?iCfgG4ZbQYzTuigb4BmvttLfyJyk91Bu35xwt+UAIQHyBWRf6ySqzRJ3MjIw?=
 =?us-ascii?Q?tr7WAwjrJ83nByoU3HJgFqVAnWM5iRuC1avIBhaymJ4revhyS8aVurhgBsIT?=
 =?us-ascii?Q?bVVDIEzab87osZS5zDjYJxYDR7ejglFloRxjB6DSNPabBNBwut/hxdpdwkxP?=
 =?us-ascii?Q?evZ9yuJzpsu4WLUXMbFtjDyxEOPNxzafev4F2U7quanWQ63rQ+hAzChMU3Iv?=
 =?us-ascii?Q?YwERYJmpNzZ6pfCVbK1WvoQINB7zycV1RAFdBYFzNzUR784ltyMRt3NYirFh?=
 =?us-ascii?Q?DyBk4+xawh3yRKCe9pxwAi2M9e0h55WIkQiIHdeYdIeQ5uiXvsJHFh6s/HlJ?=
 =?us-ascii?Q?BReuqvRg3CNGs/6JDipR8eygzIYzzAJiVKOV5G3xWVcOL5JnzywFGDv6HaZy?=
 =?us-ascii?Q?y9Y6OqCfzSq+hiQmLMDWN4eZJ0a6jTjPee9otEfGwTmjotR8vb5CxJXxPKDc?=
 =?us-ascii?Q?mpQHXF819nc1oIIsur9siGHN7gPPZiYrqXTcZbPX1xWw9GnC5SMdDf6fBLxP?=
 =?us-ascii?Q?6Wr4XDG9nlwEG063jBa7aYNzB9B0uhJpZK4obzbwKgYjXIvoSPK/Xh2oulE6?=
 =?us-ascii?Q?uHwu9NLy5AobuzGvf0d8SWE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc5f2ae-a2d6-4a5a-9ee0-08d9f207f7e0
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 11:23:48.7802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DveEMpfYJRnnpBLBYIuEUe6QzMNApJbHrjjQBKH6MO3cosKXs3kTz3u7uMeIBQ53FPDp/qKpO3EktdoCFb3vsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9413

This patch added a new sysctl, named mp_fail_timeout, to control the
timeout value (in seconds) of the MP_FAIL retransmission.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 Documentation/networking/mptcp-sysctl.rst | 10 ++++++++++
 net/mptcp/ctrl.c                          | 14 ++++++++++++++
 net/mptcp/protocol.h                      |  1 +
 3 files changed, 25 insertions(+)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/netw=
orking/mptcp-sysctl.rst
index e263dfcc4b40..3ad19e04ecce 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -75,3 +75,13 @@ stale_loss_cnt - INTEGER
 	This is a per-namespace sysctl.
=20
 	Default: 4
+
+mp_fail_timeout - INTEGER (seconds)
+	Set the timeout after which a MP_FAIL control message will be
+	resent to an MPTCP peer that has not acknowledged a previous
+	MP_FAIL message.
+
+	The default value matches TCP_RTO_MAX. This is a per-namespace
+	sysctl.
+
+	Default: 120
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index ae20b7d92e28..a211af9b19e8 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -32,6 +32,7 @@ struct mptcp_pernet {
 	u8 checksum_enabled;
 	u8 allow_join_initial_addr_port;
 	u8 pm_type;
+	unsigned int mp_fail_timeout;
 };
=20
 static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
@@ -69,6 +70,11 @@ int mptcp_get_pm_type(const struct net *net)
 	return mptcp_get_pernet(net)->pm_type;
 }
=20
+unsigned int mptcp_get_mp_fail_timeout(const struct net *net)
+{
+	return mptcp_get_pernet(net)->mp_fail_timeout;
+}
+
 static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
 	pernet->mptcp_enabled =3D 1;
@@ -77,6 +83,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet=
 *pernet)
 	pernet->allow_join_initial_addr_port =3D 1;
 	pernet->stale_loss_cnt =3D 4;
 	pernet->pm_type =3D MPTCP_PM_TYPE_KERNEL;
+	pernet->mp_fail_timeout =3D TCP_RTO_MAX;
 }
=20
 #ifdef CONFIG_SYSCTL
@@ -128,6 +135,12 @@ static struct ctl_table mptcp_sysctl_table[] =3D {
 		.extra1       =3D SYSCTL_ZERO,
 		.extra2       =3D &mptcp_pm_type_max
 	},
+	{
+		.procname =3D "mp_fail_timeout",
+		.maxlen =3D sizeof(unsigned int),
+		.mode =3D 0644,
+		.proc_handler =3D proc_dointvec_jiffies,
+	},
 	{}
 };
=20
@@ -149,6 +162,7 @@ static int mptcp_pernet_new_table(struct net *net, stru=
ct mptcp_pernet *pernet)
 	table[3].data =3D &pernet->allow_join_initial_addr_port;
 	table[4].data =3D &pernet->stale_loss_cnt;
 	table[5].data =3D &pernet->pm_type;
+	table[6].data =3D &pernet->mp_fail_timeout;
=20
 	hdr =3D register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
 	if (!hdr)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3c74b04fba6c..c28842ab0dcc 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -583,6 +583,7 @@ int mptcp_is_checksum_enabled(const struct net *net);
 int mptcp_allow_join_id0(const struct net *net);
 unsigned int mptcp_stale_loss_cnt(const struct net *net);
 int mptcp_get_pm_type(const struct net *net);
+unsigned int mptcp_get_mp_fail_timeout(const struct net *net);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow=
,
 				     struct mptcp_options_received *mp_opt);
 bool __mptcp_retransmit_pending_data(struct sock *sk);
--=20
2.34.1

