Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECA82C9D
	for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 09:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641805733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kIerVLmKYRLr9D7gMQbV1LDnYK7cFhblY4TuiJBiG1c=;
	b=ReafRwRH71y5Rx3pH/6Bv7gOwXE/T8aCbEFIt+8/uL6UpMYdBamCUuAFLkgxVfrTBhtkh7
	yXYmZFBvKXBYYL3ONA5nbysJyMpqLnhpvfkHPUDjUB0kDX89AGVukVYzFsKgvew6wdmeAo
	LKOGffg9LTVOqufYy2h+fUiBXANGyAA=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2057.outbound.protection.outlook.com [104.47.0.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13--jR_LUIoOV-jFKQQZ-5NVA-1; Mon, 10 Jan 2022 10:08:52 +0100
X-MC-Unique: -jR_LUIoOV-jFKQQZ-5NVA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcHcCQFYZmu3lL9AvkGSC8me1ltFl1I6IheDfD5YOYwjdkVrggVgxNPKrKi9ji7vbs8UzsN7ajKJ8IwM/zdizOkJkBCALL5tkSBy+wcz4+ziijBNh1o00FnljruA0Wmur3mlzRSkyC/RXOAI28SuHDNjNDTwtWFU2Q/FE/3olsJjzxkWEJESEwa30R2jz+C9oMkwW3nGY4rn7n4liRZYS/xI+e1Qo9zDqX4cQsWeOktn5yq2QKkuX0PhFGikPmprrIviYe8zIEgwh/PC6dyyIM4KfVHzcY6g0dagurdHAHi3+O8aMd53gTQXjQEMk6MUeduGpfpS+pr7Jh8D3upNsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWIu+Gx1M3PYhGKFSGHDhIXXzxBCNNoeJl0Uo/5hAHU=;
 b=gWTIAaTyAWlEmVFpWdR3f4rdcppbi3z9EC06R7JpGDBl5lfUhLkMVJRCmW47J6hy8p3xiA9eSglmBAmCds18P3o0YEN/HW+u4qnyyfVDbZMvuMvlkHtIeIyOvTVtE5AoaF1dTOf8omNPbL1H/9dEPkBtrvlz3B80TRTGZ7Vfid6J0tAIpLMIMOGelc4OZwgJkROdDB0WqsIMGCQnLvIcTshfOEn6KJh457eEtQx6GFNaEhu/PRIkDWnJKuNAIWJZrSz87wAaQ5GbjdsSo4X796j0jtrKxzRZPgrwGDnPlFbRPF6RrDaO5Des2im5BEhuAn1BObprOT4bWiID9HCbtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR04MB3244.eurprd04.prod.outlook.com (2603:10a6:7:1c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 09:08:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 09:08:51 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v9 3/5] mptcp: clarify when options can be used
Date: Mon, 10 Jan 2022 17:08:20 +0800
Message-ID: <e261bc760b71f7155adc3671431770939b78e2b3.1641804767.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1641804767.git.geliang.tang@suse.com>
References: <cover.1641804767.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0192.apcprd02.prod.outlook.com
 (2603:1096:201:21::28) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d77e7773-e397-44c3-6d78-08d9d418d194
X-MS-TrafficTypeDiagnostic: HE1PR04MB3244:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR04MB32443D64A7EEAE343FF7B246F8509@HE1PR04MB3244.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UtfsHW22fFkECHYXEx4LI+WMx20cAEEo/tXFj3E/FVjKa6dIRfbHb/NNgye8KM23qAkxC3UEUOgyAqoT+AYjL9lMUxkloMeCgDSLoMFtdVQooEB4KO+MSIdDZknpZGhjWPLoy/VMVfoqQFnfQ5L7Rc4QVz5uF8weFKvEwkcA9lhuFWlyoFmV/MKqhGheRLVNQyTGLMsMTfAvn9VTElecg0O4MdWmQqGKRbm4fKL7dOWsD6KchYkJ+Jm+ceRRvMpRrBQTNSw14Qaa6vhWiwZ0I71p/+PQKlzI14jOaPUX5GfwmxBiFloi4SeFCpbGdUUfp9SMDR/Q0vi6AArEDit6VPFiRiZmlqCBCO9Miv/Ty4iHzs4qmDK6dXWh9Dv2ancXszU+Sq71kxJWEQYR0pXCOnu/u99YhPDYhMW9PPkkNncGGxjEaQYa8KqXBWFNKHT+vRUhGkAX8n/eOWuMK95abhmW2vhBTb8Wlxqu4jCfZUOWBN9NJHxa/Gheqf6JLqFD54xRluiiDCjYCAjuF/aUrsz5LVAZ3jPMu40txag73zSL/hquWA4HZentTQ7zyp/OPdzCnR64hdhewtOld+9zij1GQRVh6pbNRO9GHoeVgGnpCEOW9K6WqerIa974dlU7gZ5g6PjRbIFAzD4/i5pkMA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(66556008)(6666004)(316002)(6916009)(508600001)(83380400001)(2906002)(26005)(186003)(55236004)(38100700002)(6512007)(5660300002)(2616005)(66476007)(44832011)(4326008)(66946007)(6506007)(8936002)(86362001)(36756003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ccLKLR6J4hcOw4NGCFZhc5UZkjm8Ay+Bzvmtwi32IcgI0Tx6HshimeIoSg6g?=
 =?us-ascii?Q?mWHkXgW1lkHkPXl8lYg+4mileEoaOrrEr2UcdKZfoROeV156D8XACmcktmaj?=
 =?us-ascii?Q?6i2qjSNRSzTzaqY25X2mqH44v7CgyvWRChrG4ijYfdk9Q+BqFomWhRcWOiUQ?=
 =?us-ascii?Q?GsnB0Jcw894TR9yAFaN7JKB18NbYBEmRec83SxMQ4Y7K5zUx84ybzGjMdEZb?=
 =?us-ascii?Q?IUjEb2rROV4D3GL9Bt2h9CQdenx7lc5pXk+N+Vd9p2nzbsSdlhSDr8nGBkli?=
 =?us-ascii?Q?EWDfXTLJOfLPAivRvDPbhi7eGXRu0c64r3GLFDQ5bpifasmpl2AWa5O8k4/6?=
 =?us-ascii?Q?A18CU8SiPtsdNU0frIU8fdJWaBmFYoagrT0ztoJ/kjhYqn/KM1NcK4yQzo2e?=
 =?us-ascii?Q?R+RvaAtKrZekfiId80tMiVXJilb++J/dkLx3Z3iSEis6VBuOoPD5KNz8CxoF?=
 =?us-ascii?Q?izr3PpUyWeW2npSUzocFAYNC9PoEd0KOWytnuWYq2/UwscI8ghEFRIrHTx0r?=
 =?us-ascii?Q?imSNH8LowA4GZDntK5x44cqjxeF2C66byFvFvJYibK75/pH+kR7Zli2T8CZt?=
 =?us-ascii?Q?WLrdfufHCwaHqUa9zj0yLyvW0beO1wHhSpNfapFkP1X2OIJQhwxvlGIQ0unG?=
 =?us-ascii?Q?AvDx6E2+VaIHkVLl5fNe05qhkE2TZO4YdWdCuKovqHdSJOVTvC4cChxrlmGw?=
 =?us-ascii?Q?/Z4sMu81uuLRaMOD4rMn3omt9GKGuvrZe9j5fZTCg7eFo7CdCScCuf/0yOgB?=
 =?us-ascii?Q?sX0aocUbKfK24h7m8xqfVfHQ0F0qSGsFUhnaLMj7Q1XzsiHV5px5iVJjAShD?=
 =?us-ascii?Q?FumKCntOJ1pJgfaY3ZQZKZLTFsFS5R2JOcbW6paC8CriXLRRHRBmRKbLII4g?=
 =?us-ascii?Q?DxKrxVteagcFlWWMdYVHiSy5edAJqZXEPokCYce410Sosot3rlOStgvKReqa?=
 =?us-ascii?Q?qe6o4N/hESi5iU3OG0i/QL/fdRJqGksb+OZookk/0/03SQm19SygXfBEzeyO?=
 =?us-ascii?Q?jOQjcDNjuOy0qT9awwlg9tmiSQb+ZoC0Xl1Kq2bnWuAs/etccvRuytqMDgZi?=
 =?us-ascii?Q?CzguffsV9odurig7LbZRmW8Y7uikhw1RQ3sz9R2JW7m1GmEIQxwsJ6Iw0a82?=
 =?us-ascii?Q?vHBaei3WuC654Cud93hX7j+NBNwBlXKk8DFggqQAwYtl0dQ9IgVUD07jwvpH?=
 =?us-ascii?Q?XGUHFiOpmCbBfGznyiK1tUP0O80TUHBmOfZXPcBv+PMQtuXAMRAkcXE51p6d?=
 =?us-ascii?Q?hGc6+TJF8R21bOKyg7VfBG2N+jTzlzZ/NB2UKHSFW1G4OWIKbF2yrZfZKZ0b?=
 =?us-ascii?Q?e6op2Pb+absrsCwDfQ8G49Ba5KGnG0wIk2lh8x8VcwNJgg+JgTmqnxab9f4E?=
 =?us-ascii?Q?jViAXse6YC4+to3//8JmzkmfNf3fFL8UoOfEt88UZyFrCKj8JAK8CC7TjWyR?=
 =?us-ascii?Q?Z3zYxyge9ExHqKYYFFlA+NKm22As426zSONQtz3td//TYXZ/JRJc8Oa/qETl?=
 =?us-ascii?Q?WuqCoSCeb82gKhwIzXVtqJwsTbC6x54+cRWfGc4ggnr4WPhqvbRs3v7MaAp0?=
 =?us-ascii?Q?/NxrFV3uTsx4QYjzQuGCAm6sb+Kx+RMenJR+ZL/J7eLbZXG+ekyoiR3VMogG?=
 =?us-ascii?Q?19CdldA2uYV5H1c8rz1wXWc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77e7773-e397-44c3-6d78-08d9d418d194
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 09:08:51.0886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hY+FZ/uuMqkDylkj23SRcuuSQqDo0h6LZyT/KGVgNKf6m1cYv84FLJjEuvrSUVqNw3zR7iETVS3Psy947C6Aaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3244

From: Matthieu Baerts <matthieu.baerts@tessares.net>

RFC8684 doesn't seem to clearly specify which MPTCP options can be used
together.

Some options are mutually exclusive -- e.g. MP_CAPABLE and MP_JOIN --,
some can be used together -- e.g. DSS + MP_PRIO --, some can but we
prefer not to -- e.g. DSS + ADD_ADDR -- and some have to be used
together at some points -- e.g. MP_FAIL and DSS.

We need to clarify this as a base before allowing other modifications.

For example, does it make sense to send a RM_ADDR with an MPC or MPJ?
This remains open for possible future discussions.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 v9:
 - Change 'ADD+RM' from 'C' to 'P'.
---
 net/mptcp/options.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 491362d8dcda..bc2beeb6b5a0 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1267,8 +1267,27 @@ void mptcp_write_options(__be32 *ptr, const struct t=
cp_sock *tp,
 	const struct sock *ssk =3D (const struct sock *)tp;
 	struct mptcp_subflow_context *subflow;
=20
-	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and RST are mutually exclusive,
-	 * see mptcp_established_options*()
+	/* Which options can be used together?
+	 *
+	 * X: mutually exclusive
+	 * O: often used together
+	 * C: can be used together in some cases
+	 * P: could be used together but we prefer not to (optimisations)
+	 *
+	 *  Opt: | MPC  | MPJ  | DSS  | ADD  |  RM  | PRIO | FAIL |  FC  |
+	 * ------|------|------|------|------|------|------|------|------|
+	 *  MPC  |------|------|------|------|------|------|------|------|
+	 *  MPJ  |  X   |------|------|------|------|------|------|------|
+	 *  DSS  |  X   |  X   |------|------|------|------|------|------|
+	 *  ADD  |  X   |  X   |  P   |------|------|------|------|------|
+	 *  RM   |  C   |  C   |  C   |  P   |------|------|------|------|
+	 *  PRIO |  X   |  C   |  C   |  C   |  C   |------|------|------|
+	 *  FAIL |  X   |  X   |  C   |  X   |  X   |  X   |------|------|
+	 *  FC   |  X   |  X   |  X   |  X   |  X   |  X   |  X   |------|
+	 *  RST  |  X   |  X   |  X   |  X   |  X   |  X   |  O   |  O   |
+	 * ------|------|------|------|------|------|------|------|------|
+	 *
+	 * The same applies in mptcp_established_options() function.
 	 */
 	if (likely(OPTION_MPTCP_DSS & opts->suboptions)) {
 		struct mptcp_ext *mpext =3D &opts->ext_copy;
--=20
2.31.1

