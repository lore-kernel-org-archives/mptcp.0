Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894C41FA1
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 14:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1648133635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=21Pi8jvO0EgzAHw0HQ5G7r46DVwAFZ7xVmH1lX+hJa4=;
	b=O0LaTgomlFLDHaQB9PHt/L+LUKw+ndPAcGASnxX6xpc6+5AZvpM5CP4n9mAsfraBXQY4uc
	/othFSBKpQzuX0st5bJfFWAzzsrtCyjztIbjoQHBgAxQzIFuF9Nuu3jvJLkj7S+pCEiJaG
	JsPt9SUZObjpFLsFLRgaxQ1QHr3aprw=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2058.outbound.protection.outlook.com [104.47.0.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-20-SOMUdVWJNHirFMaNyk9VYg-1; Thu, 24 Mar 2022 15:53:53 +0100
X-MC-Unique: SOMUdVWJNHirFMaNyk9VYg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTvt+1UDs7WZ+WoFxcgEHgNgLrpCteyYfkxjRpb6Cm7we3Q8nHOed4aorgHxV8ShclgmsSsgJL2NNFEEjmc60vpgJ8sY0PKaAn7uXgR/0GSqi9NlOIerTNu7u3QdJwZ1Jw35kWKsqnOvM7WP7gJ4fPRXD6sF+Fb0nGuJ6jJYm8zkXW5Zb1MhQ00Rr9Ctp59vCrKcxx5DvfJA10tRQ0pvk7KMszWP6XIKPo8ff3idQLM1CoYI2TNZARX7MBWidPqi2KjpCF4xIlTAbPrfeKM+T/8fK6W0aRJkGIpKiRgHCm7PNZTfjSu85ieQ/l09Ebg7Ji3hb5gPr9Ne0YcBnJ+Yiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21Pi8jvO0EgzAHw0HQ5G7r46DVwAFZ7xVmH1lX+hJa4=;
 b=lIo3WVyOpc3Bxv/glwnynaxf86deRcWmMQsUMfOoeMg0FHF6IviQ7y1jXC4mfo4ZzAJYYQSGLAuhYGLabNXQiDZ1cKJDiajeqiorLVqzCxbIAvcdDdXy3S8pONIfjPhw1xXqDyQrm3N4HVsl9VsjAWLgc0kbauFYWuiz0kUX2kW0fg6FifkIXWEu0bt+oRYwxsy0JGsgYVr7QgB5wi1GP0PI0ZT9kaMrc0FrNwKtXgZueerHu2Au3zjf8jOihlTX3fRnnVfepKOLH/VEoAjO2V9c2N7OYrIT4oXDYnAx9ap6JYAqDi1XHc3jMdD2aQXD3Qd7gpkRbC2a7sUxhgfigg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Thu, 24 Mar
 2022 14:53:51 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5102.016; Thu, 24 Mar 2022
 14:53:51 +0000
Date: Thu, 24 Mar 2022 22:53:56 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v11 6/7] selftests: bpf: verify ca_name of
 struct mptcp_sock
Message-ID: <20220324145356.GA15720@localhost>
References: <cover.1648025307.git.geliang.tang@suse.com>
 <42bf5ab5eda469d54c3e00d0d13523b815f31554.1648025308.git.geliang.tang@suse.com>
 <55171cab-2ab0-d367-951e-3968ff26511@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55171cab-2ab0-d367-951e-3968ff26511@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR0401CA0003.apcprd04.prod.outlook.com
 (2603:1096:202:2::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 179b2fab-fde5-4693-8ab1-08da0da61c0c
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_
X-Microsoft-Antispam-PRVS:
	<PA4PR04MB779068048BBC483E5B9E2A6BF8199@PA4PR04MB7790.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T6V3QxFFHA6s+zRSlciVLMbf0NWa4GfFAJrpVow/wbyHStY3NG7R6alUtLiFS48yTt5KdCf4vWHSlhQkET7qOoeImetuEwtKbM8Qm9ndvcoXngF6V22W/crR4iLvshwyvIkpzDb9ZMNTVXl3rg2GqkEta9UoBofUkOymkPJ4RH0JyvaVwtci4Bq1ohaeEwY//5v8/e8KeS/E33UN2x4wtjQAMfqChf7J70EsV1NJdJv4PB2+8SoHkg5W1iTwI3gc+LraQRtiE8V3rUmJUqwNz+Q0Wqd+amvT2puaPb7Wv3Acx3Hecej8/xRb/Yiq5JI9wB2g6SPEwly8mFtzC3VKiS+YIheSO1o2dFahy8QFoQNnXbXRzFTBO05WFZCot8ZZhTsL7PLGbuLjxHbu2Nphj0h/jrfPOg6o0iUTWWB7NA8v0YwzObL3JwkTardBIMoT27bTHFXK5L85AFwkgsMW5pqWSMzwI/gxVea9LBJWgmJn4J4bYnmh6HLxNGnOM0XY6wYXtQkJ84JCHUtBAl5pUvDVwYaPk49WRr4exnBwM6gsE6WXJXyOL9t1CTbEzTD4NDitTafeVwi45urDQcFUXYSiNFQFZTpwrSFmkhV2skv33GOzxcWZeFu9ZK63RcXQ01MoGg7/Dx1N5Vc/TJ8KZuWAj5A1C0rdGchM0ylsYKVyjsLc2ZtqtZ0+zrPAkTUK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(26005)(186003)(1076003)(38100700002)(83380400001)(4326008)(86362001)(6916009)(66946007)(66556008)(316002)(33716001)(15650500001)(2906002)(8936002)(8676002)(66476007)(508600001)(6486002)(5660300002)(6506007)(44832011)(33656002)(6512007)(9686003)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?USFnLOUbHXj/ZiIZRZBpD8sjrn4dSVwZMiq8kUT8QUOUL0/d+GKSjMaFH5RP?=
 =?us-ascii?Q?JPFIAK9psIxUUiQJ5CH/gDyNuGVSpF+IaKeK9sq+Vd4gDvq/Yivk9vlY5OWJ?=
 =?us-ascii?Q?ZixIfk7hiI+X73TzdQEsl78N6nLIk3vcl369NX+xpq4zEtROIRIBBfciTkbT?=
 =?us-ascii?Q?OKtDuAGTgz7swK9WTK4FvknCR0sumPAREM3B5sddQ0gJXXaYjgN77Qg7eQxK?=
 =?us-ascii?Q?MhKdAgyrk0ieq5NZhCayrGRuqfSKuPdgzovqFBKU6wvCrUFFk+mdqP2zhuUv?=
 =?us-ascii?Q?LuMXBsi9dF4yIdfEZUmVJf50/Qc0zwueRe9SPs1YOKzoKyntusRBv02FwqeV?=
 =?us-ascii?Q?sqPHryn3drX8CPeDK18avQU0Y9CjmsSzUYBbYxU4ee0TKTJ/g2wBhKbSiAiU?=
 =?us-ascii?Q?r4w2e9DhFgHeq3NzPw+VC+LeBygogpfiuCFV5CRhcnKVnG9kwP2nWz/S9YNt?=
 =?us-ascii?Q?VPeoqsuWBdgn0nYWlDirSi/S8vVf/YQ7d8eD17K1i+N33VBTLTQtoHHelIGf?=
 =?us-ascii?Q?UeyShtnC6InLol3TehTwKAZIbUP5x93bjNq7q/VeolIih3inmZ3p0YJr9B8G?=
 =?us-ascii?Q?yTkpfSexG4RL56KLAMLiQTp1A1oH/V/Bi8IgLGYr70cw2nESI7HBqupVcujy?=
 =?us-ascii?Q?uLB4OvdtAm5RMeQJ9skSi9Ae5y2gjxp/p4ton5ei8BpOQw5Y+sXxFVke+vjY?=
 =?us-ascii?Q?HVE2AJskBJJBAguFsYz18i8m4JUEAiwyjPihECoQTb5Yln2OIicgc5bmEoNn?=
 =?us-ascii?Q?HQVKDJStpWYXJyHMdhBnE6O6bAMFqlcWTL/FxPZrmlYOd6sCWqgBDV4H7XvA?=
 =?us-ascii?Q?6CULK5sf8zNtG2GRF0acxQm70z7rf7h84Ka38kBKIgmrju6skq9ENSHCa3ux?=
 =?us-ascii?Q?oFGO+oqR1lGvyKGuwlPwBMpvP1q2AX5+xPlFA7UvzX3Hiopqqjs3OB3KExzJ?=
 =?us-ascii?Q?BP41ZzLLZ879c9AV+iIe68+r58VxKq3hlWWyfSDLi76VaxzcB6jkkB5ylWmA?=
 =?us-ascii?Q?ALv078yo4o5puTrBfFNbHjUP2kXmSl3pSwTQ75mGLv1nTH6VnN5+Trd5UmWB?=
 =?us-ascii?Q?NGQGPyiMTR26BK0Nr5E4aY3EzhWnBDdvBT36NO7GR8j2GM0Q1lbKM7GR0yu1?=
 =?us-ascii?Q?VNssuY+G7Ant8FtbzLBkrasR9DkBN34KLt9rNi5Z6r9GjtJeh1L8ievM44Ic?=
 =?us-ascii?Q?9ApfpYiOFK4gci8vAqKKoDf5MJLQ7PyhbGJjKdyfsq9GRDoxtqM6PbUHWTrw?=
 =?us-ascii?Q?HLp8Er8VpPngmFqQxdPgVsX+uMMeDbxURcb3gNf1P8O3ICMPj6dZZgmonVfo?=
 =?us-ascii?Q?TnW1Ud4SNPsEgex8Rk+Te+VgR2bW6iM6K7SozZqL+w+78WNssUcP/lw3WJ71?=
 =?us-ascii?Q?J69gBCSdZKZse9wlNvIlHhgU+B+UKXCtbgLczACNNlRLAR/hyAROEsrHxX3N?=
 =?us-ascii?Q?21r5Ie0ggivg94wA54KQj4PjXZxJ5Bv/7pY5bo+LT33Cft7A7+f73U0j0PUQ?=
 =?us-ascii?Q?Elxf3gcwucKNAo0v2pswRaiIXFtbZvl0W970vTvpEUnv2PtXrlMKoKnxFJSE?=
 =?us-ascii?Q?8jUw58EOt0SKaUqcvVBPqTGBtW4UKv5BENIjG0fUjATSUnMDoKQGfE8XrKZM?=
 =?us-ascii?Q?Qj2kQaynNSHoVJ0kUnWhiRZAY/5fn0cGfz+zKNldBzhVv3zIrdfoMWLL9Ax3?=
 =?us-ascii?Q?AfLk/6wUh5puKhhv0L7sujqXbRSzuFDFmHqPQmycAuC3GHXktygI4Dx1Est5?=
 =?us-ascii?Q?SUCt4v7wRWScBtBDO2y5Qk3ny4MPd0M=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 179b2fab-fde5-4693-8ab1-08da0da61c0c
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 14:53:51.6568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VyXArvDt2KN2sgKCnWqe8FIsMkzUOS6CER6cTQFrARulSpZ7sxRnzpu6me1ouk6B9yktD6x1zmoKNQcfiGQChg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7790

On Wed, Mar 23, 2022 at 11:28:50AM -0700, Mat Martineau wrote:
> On Wed, 23 Mar 2022, Geliang Tang wrote:
> 
> > This patch verified another member of struct mptcp_sock, ca_name. Added a
> > new function get_msk_ca_name() to read the sysctl tcp_congestion_control
> > and verified it in verify_msk().
> > 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> > tools/testing/selftests/bpf/bpf_tcp_helpers.h |  5 ++++
> > .../testing/selftests/bpf/prog_tests/mptcp.c  | 25 +++++++++++++++++++
> > tools/testing/selftests/bpf/progs/mptcp.c     |  4 +++
> > 3 files changed, 34 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> > index 9ea6687c8f4d..bebe382bcc7a 100644
> > --- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> > +++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> > @@ -16,6 +16,10 @@ BPF_PROG(name, args)
> > #define SOL_TCP 6
> > #endif
> > 
> > +#ifndef TCP_CA_NAME_MAX
> > +#define TCP_CA_NAME_MAX	16
> > +#endif
> > +
> > #define tcp_jiffies32 ((__u32)bpf_jiffies64())
> > 
> > struct sock_common {
> > @@ -87,6 +91,7 @@ struct mptcp_sock {
> > 	struct inet_connection_sock	sk;
> > 
> > 	__u32		token;
> > +	char		ca_name[TCP_CA_NAME_MAX];
> > } __attribute__((preserve_access_index));
> > 
> > static __always_inline struct inet_connection_sock *inet_csk(const struct sock *sk)
> > diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > index 80e57ca1ea4d..0f8ced3845c9 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > @@ -5,10 +5,15 @@
> > #include "cgroup_helpers.h"
> > #include "network_helpers.h"
> > 
> > +#ifndef TCP_CA_NAME_MAX
> > +#define TCP_CA_NAME_MAX	16
> > +#endif
> > +
> > struct mptcp_storage {
> > 	__u32 invoked;
> > 	__u32 is_mptcp;
> > 	__u32 token;
> > +	char ca_name[TCP_CA_NAME_MAX];
> > };
> > 
> > static char monitor_log_path[64];
> > @@ -79,14 +84,28 @@ static __u32 get_msk_token(void)
> > 	return token;
> > }
> > 
> > +void get_msk_ca_name(char ca_name[])
> > +{
> > +	FILE *stream = popen("sysctl -b net.ipv4.tcp_congestion_control", "r");
> > +	ssize_t len;
> > +
> > +	len = fread(ca_name, TCP_CA_NAME_MAX, 1, stream);
> > +	if (CHECK_FAIL(len < 0))
> > +		log_err("Failed to read ca_name");
> > +
> > +	pclose(stream);
> > +}
> > +
> > static int verify_msk(int map_fd, int client_fd)
> > {
> > 	char *msg = "MPTCP subflow socket";
> > 	int err = 0, cfd = client_fd;
> > 	struct mptcp_storage val;
> > +	char ca_name[TCP_CA_NAME_MAX];
> > 	__u32 token;
> > 
> > 	token = get_msk_token();
> > +	get_msk_ca_name(ca_name);
> > 	if (token <= 0) {
> > 		log_err("Unexpected token %x", token);
> > 		return -1;
> > @@ -115,6 +134,12 @@ static int verify_msk(int map_fd, int client_fd)
> > 		err++;
> > 	}
> > 
> > +	if (strncmp(val.ca_name, ca_name, TCP_CA_NAME_MAX)) {
> > +		log_err("Unexpected mptcp_sock.ca_name %s != %s",
> > +			val.ca_name, ca_name);
> 
> Double checking - is it guaranteed that ca_name and val.ca_name are null
> terminated?

val.ca_name is null terminated, but ca_name isn't. I should use fgets()
instead of fread() in get_msk_ca_name().

On today's export branch, 3/7 of v11 needs to be rebased, and thers's a
build break in 4/7, so I just sent a v12 with all these changes.

Thanks,
-Geliang

> 
> -Mat
> 
> > +		err++;
> > +	}
> > +
> > 	return err;
> > }
> > 
> > diff --git a/tools/testing/selftests/bpf/progs/mptcp.c b/tools/testing/selftests/bpf/progs/mptcp.c
> > index afacea5ad9ca..6e7d2abf6ce3 100644
> > --- a/tools/testing/selftests/bpf/progs/mptcp.c
> > +++ b/tools/testing/selftests/bpf/progs/mptcp.c
> > @@ -1,6 +1,7 @@
> > // SPDX-License-Identifier: GPL-2.0
> > /* Copyright (c) 2020, Tessares SA. */
> > 
> > +#include <string.h>
> > #include <linux/bpf.h>
> > #include <bpf/bpf_helpers.h>
> > #include "bpf_tcp_helpers.h"
> > @@ -12,6 +13,7 @@ struct mptcp_storage {
> > 	__u32 invoked;
> > 	__u32 is_mptcp;
> > 	__u32 token;
> > +	char ca_name[TCP_CA_NAME_MAX];
> > };
> > 
> > struct {
> > @@ -48,6 +50,7 @@ int _sockops(struct bpf_sock_ops *ctx)
> > 			return 1;
> > 
> > 		storage->token = 0;
> > +		bzero(storage->ca_name, TCP_CA_NAME_MAX);
> > 	} else {
> > 		msk = bpf_skc_to_mptcp_sock(sk);
> > 		if (!msk)
> > @@ -59,6 +62,7 @@ int _sockops(struct bpf_sock_ops *ctx)
> > 			return 1;
> > 
> > 		storage->token = msk->token;
> > +		memcpy(storage->ca_name, msk->ca_name, TCP_CA_NAME_MAX);
> > 	}
> > 	storage->invoked++;
> > 	storage->is_mptcp = tcp_sk->is_mptcp;
> > -- 
> > 2.34.1
> > 
> > 
> > 
> 
> --
> Mat Martineau
> Intel
> 

