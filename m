Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3227373
	for <mptcp@lists.linux.dev>; Sun, 13 Feb 2022 14:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644763816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8KpuZVpzF+bAAVys0+PZ/IwynSD0zwCWsUrjCOfjL2U=;
	b=UCvpJLh07KaMzhChdT47C29ZrYXFnZw7PJ+c3hyDhvxpzmFyoapj7nPy4OFeafC8H2EHmf
	qwtbU6UGnWmbtpcTObqJgb2sTRZx7H7Iklrs+zP/fVwluZBPvEhWRgJIO2Ys2oT4KrYxtO
	y6Ub9iQsUNRy0/p/EZbFI/FeFvAVZbs=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2057.outbound.protection.outlook.com [104.47.1.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-6-RSW2CfSnMUeb54xXilrygg-1; Sun, 13 Feb 2022 15:50:15 +0100
X-MC-Unique: RSW2CfSnMUeb54xXilrygg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBcMXP15hYblkhPcjHID1UvgCyguGRUGS6dpM8rtfVbCZ50IZLhC6x8ScK2xbwF+iWvB4fjaF53vd1DJBKY+pMNfGe/bks/Wsv/KS68ZWy7b5ZiaHOveGYYxLFUxjY4TAlN/NB5O8Ej5gm1llJM2dQZqzyhw5zySD+stZ14X/0vhoVqMASAwidUK4vIIJ5AdJs1tHJ8QY5n8R/P2YyYnMncJ97Q79zzBZldkDyoZFqnnoX/KDfh0MqOkhWX487ckDNqbZzHv2RZKieRMF+p+c1IMm5mgxO0JVubW6Td8Uaj0wnByhv3EZi72KKL3VYgqbHZiFixF7BQh5/IPS1ta5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlLFFyvqyQbeuKuGk+tzDgmSBzLiDDaUb/+MsZzTQrw=;
 b=dQKg/8bPD0vtgKcg3K7GrxJdkz+rGvVTIqKG6ChUSfTl0duUmWT6KJEDKbY7ysgbHSkScdnuFOIwPYQ1gEZLCWHDfpBONhzqM35oQV+oEIGvN7hjmebBJ5H7WbZpYctaoZialqBO8XSYMjnk2iSwBEzwc26rV71L30xdBk/dzLcUADguNLR/8tLEbznFPzVn08T0c6dnz5R4qr5JWUwxui5TRUusB6tO3jsFHsTVJcy9JhG6J5AZQsVZ8Upl846OaQaFwOM00qf1jMqUq5pVaUH1xID5kcU46pKT+YGokuBqvjAjEcc2j6MZJ2w5hIeZ5iI5SYz4v10sYR5Ln+xv5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Sun, 13 Feb
 2022 14:50:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Sun, 13 Feb 2022
 14:50:14 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 1/6] mptcp: add the mibs for MP_FASTCLOSE
Date: Sun, 13 Feb 2022 22:50:31 +0800
Message-ID: <eedbbf24806ffbc2f7be93f64ab93d62a320507f.1644763526.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644763526.git.geliang.tang@suse.com>
References: <cover.1644763526.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0101.apcprd03.prod.outlook.com
 (2603:1096:203:b0::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cefb903-6121-464c-2b39-08d9ef00246c
X-MS-TrafficTypeDiagnostic: VI1PR04MB4845:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB4845B2226EF879EBE61EFA9FF8329@VI1PR04MB4845.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j/+PbM0GZKOPb77HnV9mDhQ0aIwVmmGEIEw2024nVsWtmBUImxOJbXy5X3QOsJYTDNnGRD+U1DDxdPVWSqg4o6hxlZJa9v2Hnbwgzu/+Bn2ZeDnF83mGFXUWIXN4THGm7LnCTTqkSGD5oUrDZpxmi8BJOTRhjGZ7PsTy6UrSCel26DTB4joboVQj4mcYVrQeHXxtJl9d6kZt8gCryePUd+erhgXtTYraRbVTk1fqVXsyl4ZO6q0F3fNVAh/HavP9RlHG93gddy5NITemRjqP1uUXZuoSbC2slcx0Gg2XQTT9yShFKNB4OIGBcEwKlJSISKqeFX4djLB9/VZTpYaKbUNCa4i9cUOFY8f9B4NxBpdBKvC9Md7IohxQyQf1KA061R900dqZaT5KgWtGArIVlTKP+1F/RJ8B6DbX9di+cn2JmiiPFeuP1rXf+9G1F2iRfNYRn1KeqN09rG3vTOaX8Brxx2wP6RJn5laOMHIkgR8X+IMaI+QaUFjaO0Iwehs6ODQxGSmvDB7JXpk7OPPUT50++TjbNiJFjg+iM2Q3DHws+XXo3vsylZU07U1orzW3fF+5oJffYlAaMU1ZN2bUSKK3PyWANmutdowI41lQUpfmMg6ZZCfpz9ZN6HRJlOSTvNZV87ZbBPW2V6KcEs6w2A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(186003)(86362001)(83380400001)(8936002)(6512007)(508600001)(6486002)(6506007)(6666004)(38100700002)(316002)(107886003)(8676002)(4326008)(66946007)(6916009)(2616005)(36756003)(44832011)(2906002)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+F1SPSpqOXdAhUqpK479wL7aYcwHR0jD/otxpzy1riDGZL0igvNvlMyHFetl?=
 =?us-ascii?Q?0YX4Gtm9HZQh2rQky8YvYtjr9ZuSeuNbuv1pXwexNwOQ3vyfJxwZPTQYjfxw?=
 =?us-ascii?Q?uVYKX34d2v2cE5CslEW88JZlhZjQaMTeUWoRvCN1Ei0vimzSEROWx+ue1Din?=
 =?us-ascii?Q?CARCJAbbgTA0WhhdGFHcVywKMmZayexi/i8+pPmtZnX6Eo3yL5HN5qbPoMEc?=
 =?us-ascii?Q?pWUfNesEYbowhhWY3hw7jxggppHAXRZMeZLj45pgNZ4q8S1hE4g675bgPC4y?=
 =?us-ascii?Q?SVNnUJxTkpZfTkO2p12rWmIBYGcqDhA1uHsNVXGm34tO0ZUoMbko2y7Pc15b?=
 =?us-ascii?Q?Yvtj8ahVq2n5bxW9iYa5EkGv0c4HBpc2CtASLDqedMjVfQ8B4Y5ia06SUBVj?=
 =?us-ascii?Q?IbKErShSGkVZZM9kIJSiWUzNRKvCbsVVjzdZpItTtVaHZmWeSeFMU0lKwNyn?=
 =?us-ascii?Q?dsuUKApsFmJywdlMybiVwSQtrVM08Ran/SWncgURpw9b6x/AaDPH5d+/iqhf?=
 =?us-ascii?Q?RsVg5gDq/xUfM3o0AHU++El9dDGtw3Em0nA1QVKhUJX125IKiUivCK7gAlIh?=
 =?us-ascii?Q?ylMy0GNGu5EP+pde8S7fv/IRHUNltOWhhEgk1SCkvQYWLP2fs+T8Pjb945m8?=
 =?us-ascii?Q?H0ws5bEVLFtIDttEphuBZQSZR3h4jQoqE6USQkYHKg8SlXX361rxvkbUsQYx?=
 =?us-ascii?Q?rndVlfJbcwaRmuNHSB8DfUiKg8EzLs7xWLIH04Kc3kAwOKTWeYrXpkm8n143?=
 =?us-ascii?Q?ZophyjamRWeIYivdZRcsxXnW8RbRsompFp+tgxdxH8cHugFAniFYybLS4yH0?=
 =?us-ascii?Q?16KFYGA7eIJybJ2wLipDGfBPJF6TN79KirM/fn4wCGlEtYuDXxd3ybsG2Ag8?=
 =?us-ascii?Q?B1QitS7W2kESr/7UUKiNbZVixLRolSU91fVZEGXImN5x6faeB6JX3Ce1zPNX?=
 =?us-ascii?Q?PTRw91YFUWo//M8r1mVmLK+no51Chgq544QN6/aKaI76EwLeA1ysWLr81oGB?=
 =?us-ascii?Q?QbS6d8YE7cg/AY7m63hiIR6XexhMsI2/cR3ufOnGSfigdm+udeYRO1D5hZ0z?=
 =?us-ascii?Q?j56KZhdqU5V/Rf6OM0hV+cUH3goAO7gHPNtfmzootF4EEb/8JvYyW+DmoVXL?=
 =?us-ascii?Q?zOVlFzRjL7RnnoWBQMvluw6SIxR+8jAza16Q4AoVojMik3EG8aSo0LmaCMbe?=
 =?us-ascii?Q?cAZAarx5pkAZubwv5GLgEGet32pCabUm2G6Ztjk3qtI3rZO7G82bQpJkTaWf?=
 =?us-ascii?Q?sKGl8piY+9ipyR5jxpAMb0ochO5oO1arvgpayeASkZNRkSEauIDE0bD69ShD?=
 =?us-ascii?Q?JXtHhGozHQqLgOgpHEQHfvxywOrp778h2U1eAyAIiEGS7+CocBGRT5W32Y2u?=
 =?us-ascii?Q?DEAD4HLNiuL99snuLvZnR+W7ZeCCPCJZm7NLjkdWrPLGrzFjStzV1X7MdOt8?=
 =?us-ascii?Q?X9TtqHwLHl485roS+XY9tpE8/lfIO5vCu+mZoebBcNtzAOblPGf/DKiZId7v?=
 =?us-ascii?Q?xRifIo4edQKnQ1EvDVO23CE1LbptSyWR2iUCJa2E5pmoUy3OsWRk0v0pTY/U?=
 =?us-ascii?Q?surIvh7y3VyetUPD+fGv9NrQrWPsfIbl0Jx62BLQx+gg6UZOQBFE5QvjtH4t?=
 =?us-ascii?Q?HCjHnTLLFXjUy4EQWoATwjqdtdCyeG9XO32OfoTdC0iSibnMtfVHQVeskjEb?=
 =?us-ascii?Q?pLsta20JN5a+o+w08oyD7ML3yIo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cefb903-6121-464c-2b39-08d9ef00246c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2022 14:50:14.2711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJMNAUfjHKSSPkP8Yxbn7b3vXGXa1BK+4jOvAiDF9mdB376ZUkkXRrd5BG+z6YDzCjG87QPdlcngr0qbOZctBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4845

This patch added two more mibs for MP_FASTCLOSE, MPTCP_MIB_MPFASTCLOSETX
for the MP_FASTCLOSE sending and MPTCP_MIB_MPFASTCLOSERX for receiving.

Also added a debug log for MP_FASTCLOSE receiving, printed out the recv_key
of MP_FASTCLOSE in mptcp_parse_option to show that MP_RST is received.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/mib.c     | 2 ++
 net/mptcp/mib.h     | 2 ++
 net/mptcp/options.c | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 7cef7409e300..684643f8af53 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -49,6 +49,8 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("MPPrioRx", MPTCP_MIB_MPPRIORX),
 	SNMP_MIB_ITEM("MPFailTx", MPTCP_MIB_MPFAILTX),
 	SNMP_MIB_ITEM("MPFailRx", MPTCP_MIB_MPFAILRX),
+	SNMP_MIB_ITEM("MPFastcloseTx", MPTCP_MIB_MPFASTCLOSETX),
+	SNMP_MIB_ITEM("MPFastcloseRx", MPTCP_MIB_MPFASTCLOSERX),
 	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
 	SNMP_MIB_ITEM("SubflowStale", MPTCP_MIB_SUBFLOWSTALE),
 	SNMP_MIB_ITEM("SubflowRecover", MPTCP_MIB_SUBFLOWRECOVER),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 785cf751e5c0..93dd5176fd5e 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -42,6 +42,8 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MPPRIORX,		/* Received a MP_PRIO */
 	MPTCP_MIB_MPFAILTX,		/* Transmit a MP_FAIL */
 	MPTCP_MIB_MPFAILRX,		/* Received a MP_FAIL */
+	MPTCP_MIB_MPFASTCLOSETX,	/* Transmit a MP_FASTCLOSE */
+	MPTCP_MIB_MPFASTCLOSERX,	/* Received a MP_FASTCLOSE */
 	MPTCP_MIB_RCVPRUNED,		/* Incoming packet dropped due to memory limit */
 	MPTCP_MIB_SUBFLOWSTALE,		/* Subflows entered 'stale' status */
 	MPTCP_MIB_SUBFLOWRECOVER,	/* Subflows returned to active status after bei=
ng stale */
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0401b22128c4..e775d75807fd 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -323,6 +323,7 @@ static void mptcp_parse_option(const struct sk_buff *sk=
b,
 		mp_opt->rcvr_key =3D get_unaligned_be64(ptr);
 		ptr +=3D 8;
 		mp_opt->suboptions |=3D OPTION_MPTCP_FASTCLOSE;
+		pr_debug("MP_FASTCLOSE: recv_key=3D%llu", mp_opt->rcvr_key);
 		break;
=20
 	case MPTCPOPT_RST:
@@ -832,6 +833,7 @@ bool mptcp_established_options(struct sock *sk, struct =
sk_buff *skb,
 		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
 			*size +=3D opt_size;
 			remaining -=3D opt_size;
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFASTCLOSETX);
 		}
 		/* MP_RST can be used with MP_FASTCLOSE and MP_FAIL if there is room */
 		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) =
{
@@ -1124,6 +1126,7 @@ bool mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb)
 		    msk->local_key =3D=3D mp_opt.rcvr_key) {
 			WRITE_ONCE(msk->rcv_fastclose, true);
 			mptcp_schedule_work((struct sock *)msk);
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFASTCLOSERX);
 		}
=20
 		if ((mp_opt.suboptions & OPTION_MPTCP_ADD_ADDR) &&
--=20
2.34.1

