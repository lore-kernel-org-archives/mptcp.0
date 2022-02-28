Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5F27C
	for <mptcp@lists.linux.dev>; Mon, 28 Feb 2022 14:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646058743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPrkNfM79+/ouMei1PnprsjAzNicJIoo/hUp15oIdMc=;
	b=K68vQkrgMg8jnYU0h4Ur85pnb26zB83U85vtWb/ZkdmLFEZTj9gmaeQFlo1AU+FddxD/ln
	WJQ/LAz9O8so8G4QXRixiEYP13YdCiblp7t5CLvHrFAD7ET516sl3AirhRSkG+ZDbbQ2Po
	51SU87YUihZSSUP3kiWfD1Px1TTyWI4=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2054.outbound.protection.outlook.com [104.47.13.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-Rn41obGdNT2kLbmByHAD4Q-1; Mon, 28 Feb 2022 15:32:22 +0100
X-MC-Unique: Rn41obGdNT2kLbmByHAD4Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obV3GqroaQKnPhd0lt7x1JE56fLdmUrRZUaiOl40ZOAa+P+mKMWJ77C5nePerrGOTWPCt097RxZKJA4db1/Edux5CkRpIhjybvviFzpY0D6OC7bFdnu0S5lWLXim5B9g1SNaWAfEvqB79QrbXGVntxYTLfKCSHKTNGGo3zd1bNPlLHTgk0NwmLM8Bo7kNmM76VYJrygGa6fY6eV181i8v52KfPGH8QYsDAnLxA1VpgCQm4+aaqJbKZ5iRSdI/+PTG1cRNmPE93g2NQsDP9jamJ7ZUIZ3B499esDlRE9Ec5G6awgVz6MLa9SlffmvQpNAMtMOyykAaHe9ogPRdTGTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a24iQfUb81I0XeW1JwaRALZessAExnehlokf4LQIg4M=;
 b=bY/X5oZ6DaoQeP7sbQXuHf06HTYPmiljBgoNrjjsK9Og534jFpHD0KntH0hbSZ+aA+9kx7PZYa4bPz4Ee/fkZoQCJjVBgQSoOUvGdnTJNPbVfyPZJ8TxdwHVxoJGqfjnTreSEauLPMGhwDSFqoHuQNY5A9ZTH3YKl6Qm/nNv9rLQcJADePCOLvi61Duoyp8VZvfW/lT/Dq07RfV9mrDYYgQb88Y73+2277yUw3iY+PvhlmbkliFqT0EiqKGQ1a9wmtjDdd0q8GQu2uYvxiYSgABFTZ5vZ+bNGM9wTnnKdlLoV1bP24XQwcVQyxwtpKApc1AbanpDXJMc6ECWBhPl8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB6PR0401MB2245.eurprd04.prod.outlook.com (2603:10a6:4:47::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 14:32:21 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%5]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 14:32:21 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 1/2] bpf: examples: static library link to libbpf
Date: Mon, 28 Feb 2022 22:32:47 +0800
Message-ID: <fd0f1905d026a017bc7d09f01fbf6c8a6f7e2fe6.1646058641.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646058641.git.geliang.tang@suse.com>
References: <cover.1646058641.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0071.apcprd04.prod.outlook.com
 (2603:1096:202:15::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db0f4f1d-dce3-4219-5397-08d9fac7210d
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2245:EE_
X-Microsoft-Antispam-PRVS:
	<DB6PR0401MB224595BD0733FCCD47E93A12F8019@DB6PR0401MB2245.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jkjbMH3uwNvHfAoXxyZvAw0JfIzi0IWoxfDYumjlvdSKSAp5gAW+c/ZHywFZrurPLVstjmLvbc3a+UaWNR0Bqh4hYetxpCfQPSA5wP+vlC2qdYe7S25nlXvwPMLoDZh9/dlm236oGEvMl60z87x1yCvtjOA0AhD05y8ll6fli+89pezetpURVdnNWhMB54owpbVPS/XJGZRVD1qfUFdpAcoCxLikUAvs/kOPHNMA27SAHH1jxgBZhXFwwGVPZcVmeAv4rQhTnsFHmbaqTqTjwXeixnKMTWTXf6D/Jmc/MQeytL3fZrA6yclTXcdWLTMXLuXiLxMoxpgX5Xe7h9HIbd3zFlwK5Uu6Hi1+R05NwuiqpWkOvqP+htgzQ6Kw7L5DeRyrKD/Mc9jmFRvJ+51O41yyF7ofGQlyukYFNOrQlWVnrbz83EEk66G1QNJ/kzafMS8BltlLU2muowiKWOm8/SvIdprzWSivee0FY5URAjSU5hFD5pf4XElFq/ttjxmpTjWPdSpR/Egjw8C51CxKCEESvnZDFrHVMbi7frErYhWzogkTwMn3IXHYG66SyFqhBFKZnvE2GrX6e66bmXHmaw0NlQQFHRm9wEeQNjbl9WSqhUjBnO8pd7eayO1FcrUYi+9ZpTHd8fjTY3dnHvoorA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(6486002)(86362001)(6666004)(6506007)(2616005)(508600001)(107886003)(186003)(83380400001)(6916009)(66556008)(66476007)(4326008)(8676002)(66946007)(38100700002)(5660300002)(6512007)(44832011)(8936002)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?myJ+VgTlCxR/Vv3/nvtDAQpTPOSiyp041thfFD23SgMYw7gPD5l2u/5aC6+A?=
 =?us-ascii?Q?YsS7/0gg6bhqfn6XgnENgfN3pm/n4S2jJz7oqdHVcbqXg78Mu6dvvZlMY26I?=
 =?us-ascii?Q?k/ItZTMJ8g3rQuE9ikzg1boUVw9wyOzwfgiN+3YYd88Dj/kOWcouF0oVvDHQ?=
 =?us-ascii?Q?D4XKn0VjkS1Kp1seHTkQxgSZuPzASPOJwI+wIDASIYmqxJzefNudN8dZXO++?=
 =?us-ascii?Q?uAbk8Rv4jSE8Q3gksP/h2oMU64V5+gNCj/1ySo4u84BCgw3EgoRDRJxEQheH?=
 =?us-ascii?Q?Nhw8OJGJel4MA+YmOB3KmzJ7WrjjYtZGx9JB+qGIW5KpzMQNbt0P2HZYjfNt?=
 =?us-ascii?Q?DEymIr7m5sP7tOPobl/6wsUOSgj5j5b3DK3tWL1t8mE+iRTptmZMByatOwKH?=
 =?us-ascii?Q?WWL6/ZfLnBz6hoDk/7PhD9+FjhO82ukw9Jq6XGmfp5TGsXkvzxOgjzVH1s2h?=
 =?us-ascii?Q?09sL0UUhLvmjvQk7PX3VCwhyXebQ5JL1ueH5pmPYXIXwdgQlCKi4vplOVn7b?=
 =?us-ascii?Q?WC6PSKQdAGFk2mMIC4D4ujg/IkQ2qgA8ASOcYQ3GvyKMNFkk5idxOYFEPyXO?=
 =?us-ascii?Q?me5PmQBuWk0AtcVUNgg5kbIENeXC9j0D3VrKkY2YPZb1keLz0icphWjhbX2I?=
 =?us-ascii?Q?FwkXzfGX/ERdG4D1DN2E2bzf4vpPBhj6l7NLilh2tED7BGV7EZqJpsud7Ton?=
 =?us-ascii?Q?wiy8fG0U8Rk9BGaHKTcJzW5YBcvQqLjgMLL8ZP+U8wkGabYQEogT57SRLXkX?=
 =?us-ascii?Q?tvTx42n0/mAT0C42QGqqHTfzeaY7Xwp0rrwT6/iQpLnv0ujFDQRPoZ3rDM2D?=
 =?us-ascii?Q?0EMn44BWWn/yLO0fUJlg75CEuH8JK4He2qcXCEuqVM1X+OOYgeTjTsaImsw6?=
 =?us-ascii?Q?2YxqSE1QEHzQQYZbuDWYoBb+l6M1/IA9B1KTjg3U0Dxn4fb7QSmpjz0UnZLA?=
 =?us-ascii?Q?WoK+fNj/NINQPhsmYxjWhxnHORQMgYfdD+BX3ATbSyt7Q0rMkdiiY5XautGx?=
 =?us-ascii?Q?CNTqdWCBFqP/RxxHgfBd7ejkGeyukwFPffeKBAtid339JQVZKjgfOaP43zZ/?=
 =?us-ascii?Q?i3AXEbuAXDKzPmy4B/kx1DdY9mb1M8+bAJd+Bze1TIk0tSN7nydKlI1QTvQO?=
 =?us-ascii?Q?r3UG1RvcEp1I6+yCZm3zn/5AUDlnF1Vnj8XaGnGAzz3NVY26uOtK4U5JwUft?=
 =?us-ascii?Q?ls53llo0FdlhOPXxDKlOBTC1DRQTU3w7+wjVRch5mqXsEa3uftTRO9RUGuGS?=
 =?us-ascii?Q?Q08YQuzvA93KA1IPr1eiCf4WcUkTnWVLWoc6b+s6iKop18Safz+MnHEqdSco?=
 =?us-ascii?Q?7MFdcgrD6XHDwBOL/ikCEs+wUC8U40U91C0n5Jd6C5BG3L1U+SrcflGL70g1?=
 =?us-ascii?Q?pM787kpy11VF7AvDH3nS6VrXk6JkTxHWK4TgQ+5Y4km6nPTvKvNC7zj1YwDr?=
 =?us-ascii?Q?gY/0orB97FmTcQUnMFHhuWEBM+AOYzqIH1sZ9j+k/d6IynYVsdcejbsmFloi?=
 =?us-ascii?Q?2RMpW1ZoTyi7QaKqyVhlhbGfMgO02/8JHxiqwr/s5h5XfQhphEB44KKMZfHG?=
 =?us-ascii?Q?RL60mKJCqbZL8P6XlBns4pFr7WN3nsSs/rUx+pE8ZzQ4NZ3RICHplQk2k/9I?=
 =?us-ascii?Q?DxPtqBm+p4Vj7YX9dNSqCFaCkFyx+G43IWngYhDpILZrLwS8JgjkBEeSl7Ok?=
 =?us-ascii?Q?IvTda2LA+4TNbEn/cnpacsYUSUE=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db0f4f1d-dce3-4219-5397-08d9fac7210d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 14:32:21.0374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PN6GOX4TAUioAO4/q6qIvtikR5bwDxNOJghf3ujTic6Lg5j/cIIAgJ4wZYhPjpCcIW5ZrQj8OloFkQruV7Ot/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2245

Change the dynamic libbpf function library link of this BPF examples into
a static function library link, so that it no longer depends on the libbpf
installed systemwide, but on the latest version of libbpf in a given
kernel tree.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 bpf/examples/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bpf/examples/Makefile b/bpf/examples/Makefile
index ff5d1a1ff939..32000cfc72d5 100644
--- a/bpf/examples/Makefile
+++ b/bpf/examples/Makefile
@@ -5,7 +5,7 @@ CFLAGS +=3D -I${MPTCP}/tools/lib
 CFLAGS +=3D -I${MPTCP}/tools/include
 CFLAGS +=3D -I${MPTCP}/tools/perf
=20
-LOADER_FLAGS :=3D -lelf -lbpf
+LOADER_FLAGS :=3D -lelf -lz ${MPTCP}/tools/lib/bpf/libbpf.a
 LOADER_FLAGS +=3D -DHAVE_ATTR_TEST=3D0
=20
 BPF_FLAGS :=3D -O2 -target bpf -g
@@ -13,7 +13,7 @@ BPF_FLAGS :=3D -O2 -target bpf -g
 all: loader mptcp_set_sf_sockopt_kern.o
=20
 loader:
-	@clang $(CFLAGS) $(LOADER_FLAGS) -o loader loader.c
+	@clang $(CFLAGS) -o loader loader.c $(LOADER_FLAGS)
=20
 mptcp_set_sf_sockopt_kern.o:
 	@clang $(BPF_FLAGS) -c mptcp_set_sf_sockopt_kern.c \
--=20
2.34.1

