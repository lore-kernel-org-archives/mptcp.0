Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AEB3B53
	for <mptcp@lists.linux.dev>; Mon,  7 Mar 2022 15:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1646668744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d6qN6dRjX11BZoiAwmjNHiM6q4+C8vr7V75bSrRhn6E=;
	b=k12r+6XDALj/vSMtlI3qnf7WmETpT+lD8Cs3S29j8iAAYVJtYBk1dc26rknU/Wp3Bm9zJQ
	aE/0sMMEry/WhCS5yHgkiS+fWRl4W7OdN20JX3drtyVIaob24rS/ejh/654m2M1/VuluAi
	YYR6lKeJsT/aK0qvtIl47iEryjo/mV4=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-26-F0KPojp3OUG7e1Kk0yUgyQ-1; Mon, 07 Mar 2022 16:59:03 +0100
X-MC-Unique: F0KPojp3OUG7e1Kk0yUgyQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c806O7kAZIu19MQDJfjj5n8buAgCmBnT2HHeSgjNkaJt+44sOdG2v9AblPv9sZaYXCFSbWuI17r+O/pAwPHfsXWwf2vT5RX6DpB+pEoq27ycxCbSg/Pv3yvU0t6OXv4MU/oEHlTSxHuAg4T4p4xawfyWekYP0XbrwTWV5vQlgV2U9W5N60nin8ArvBw80+wHq69oH5mkRI1YunHVNeXoX5IS/mqWO6d57Vuwai/OW54ETlucedLNPM3i/JHFaQzFJI5/ILqY3cyxLg1+6akYn+GKEY/+fzjgIx+D5eUsxi6I2p2ROvEgIV8JQIFP5g7swy4PkRFDNX5E6OTF1DMd4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6qN6dRjX11BZoiAwmjNHiM6q4+C8vr7V75bSrRhn6E=;
 b=DvNRvEn0CFxCj7Fn9KXEKj7oUw2q0zfLcdYIN/XcD1+FNCR4je6oEhllwMA5AV01Xk6SBA6vkmxuXTC+DtYxfyyCPPmYJQOzGoIG2dWOhczXq3yA8MpzJ7n8yYGO8PyZNEzuqMRMQFU/BD48FeCJ/qsljq61Ew+AbvIfr1TY547c87NHUaHyGCkePwha1d1pydZtmxpbv4tUUKZwLg6qMWGF60kZxJblBxvw5xBIeOZBPNrzexm3Nqautc8im46n8TgAxUfRfljy+f/KUfeOOxdpoI/vgKoYu+JImNI2rT/fW/nMmRvRs1aPFfMLG7YZWaqwMz3i6L2NDm32d8A0kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB8044.eurprd04.prod.outlook.com (2603:10a6:10:1e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 15:59:02 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b110:cb51:e09f:bb05%6]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 15:59:02 +0000
Date: Mon, 7 Mar 2022 23:58:51 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v6 4/4] selftests: bpf: add skc_to_mptcp_sock
 test
Message-ID: <20220307155851.GA20573@bogon>
References: <cover.1646528337.git.geliang.tang@suse.com>
 <f1b08465b87273f458eaa67df848453fc0e25413.1646528337.git.geliang.tang@suse.com>
 <4b248f07-d749-400a-ff81-4f08a12c7814@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b248f07-d749-400a-ff81-4f08a12c7814@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR0401CA0004.apcprd04.prod.outlook.com
 (2603:1096:202:2::14) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8502735d-8c62-47eb-be20-08da005365ad
X-MS-TrafficTypeDiagnostic: DBBPR04MB8044:EE_
X-Microsoft-Antispam-PRVS:
	<DBBPR04MB8044FC48E67AE4F49A2943A6F8089@DBBPR04MB8044.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uXVTWYcknUpKbQR1y0zsVI5Lgc5mPy8puNgJ4x9JwoFqZnwE3lTCQSfwL+cB4zMoresDBWitEDdsAIwZLiHyypO9QBbaXcWN8gU5dsPp1ynybYA8ROVlX5AfKzIbQ8c10/zIQwYztijY9/giq33RK/zCKuZyOq4eUMHQKFwfwe1pncrrUKvAez204GSVZh7/aREAJDvnBWv+Mao11UcAQEyxqCxG9uEQbNIOTtM5CsEWsi2rxDomFl0+Rj8MgvKFj1yDrVu7e3NDRsNElTx3xJNKdYSJ6csTsdaq2qhi+YBMpTJo3Uwr/RpqWL9oZhWCM2FCnrXpUVX1ygVCZfbsCtqi6YzpMqigZSfPrI08ohv1Lajz1u4I9f39M9F2LUz1CEfGvtfuCUuvCKRdwRckKQDFdydcd9ZpcYL+VRN8m6rDpPJkyp1kVRHL9m5wEz+golr2aBn4LsAEDMb8vYb2kEFdaj0RoylP/JVeZnGAA1zUnvPcGH8l3AjnXMBLhnNZZMWCeIYAA8Nlqc3XjZPn1RgcK4HXnKtVdqzTrxYExHjH6p0AXeG1hVqKzDintffU9oc5eGWxzT5VRa8dO2QFqjnX4ETUE6UiI2/2fKxRigQZ9SG01qtV22w234ytqk2HT521dEx5bSl4gIb6nX18JUsShxSDCYzH+G+qy7J8eoEAhKQJzCorfD4ZF6EQexTpqjtQ4jVQW1pc+VzFGI4Lo9E5r77nfl4PfAUyIzfftJXoR+wgpQBwr5ueO/y0kSanRkuLhN1t8+ZM15I0vlkHhA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(26005)(44832011)(1076003)(186003)(5660300002)(86362001)(83380400001)(38100700002)(66476007)(66946007)(8676002)(4326008)(2906002)(33656002)(66556008)(508600001)(15974865002)(316002)(6486002)(6916009)(8936002)(33716001)(9686003)(6506007)(6666004)(6512007)(53546011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tgz2ZrQRQVgZpQGSEUD91xRo4IJhjiXU77zHo3p6g97YrqirFcGHvrxgFaCn?=
 =?us-ascii?Q?kojGf9lnmddPC7IWGJm+TkuxvM6QZl2UNtP96iVL4rJFkMXU0jIdeLYUSX5r?=
 =?us-ascii?Q?OqebY8fRPhNBTlyGlQiVkUcKchAf8EkcssJn7dsRg5JTnrRTadxkcGnCzb3m?=
 =?us-ascii?Q?VRokq9EOaAphDAQ55WszUXjXpkC1BaCVG4b+prM2MlzZVk0U0zHsTV/uR4TL?=
 =?us-ascii?Q?VgicTldH3/Apc6uGXpCXmC3vzqJLpYXOMysmyVv6xd/VHacoHfRw7p1izm5L?=
 =?us-ascii?Q?ePFBkEAK7PG48oz2oGj11OZRBcGZPud0MB2PdEEbqs05BydTN2ye49kaMvSK?=
 =?us-ascii?Q?OCaHBkpP4DdkVqpod4smNIcb9erS4i8fR7KKQ0UQf0fgiA6CZ5Z+Vk/nCTkh?=
 =?us-ascii?Q?Yy6orxHtmzdOk5dgDPgr5hYsTzPN3I3vV6SNPIqSbYJPIdh8MmEvdYjbjLFb?=
 =?us-ascii?Q?SBltoMNdIzAkR5C1bFxOgSALwH+8fqpdsY27SFFbwwkQaSY717nqQHIrj4Lf?=
 =?us-ascii?Q?473MEz9tnSeeCzoZ4VQ97SHMs6Ebs0pFqOa8Cx+oiBplujWJO2fFAdSwVy0O?=
 =?us-ascii?Q?ceLGhwWZsoqyIalK76yct16JvZ+v3d9/+L0GmUwCzInXY9DL2Jv32nUdKsqh?=
 =?us-ascii?Q?DwZgIsm0hm+tKsYRuadzU6lh2MaQwCiUk0PExNT+oqOaTa+2e7Zxecv09mSt?=
 =?us-ascii?Q?c0/9WeGTmGhSU+JfPnu0buGjYT7kAadTLxwvQj+iSm28geZPfvFCoy5r/GR7?=
 =?us-ascii?Q?wLzl0O9SrWe+cj32Sj7u+oj6ivWLXybzeIpUKoY4DEuEi+vCBRQ+LzFIOz7i?=
 =?us-ascii?Q?2GvHyzspYoo2LTbQUVv9b4fzOeNHB+1V18GBJIn2n6EwDcPhB1RUvk006u3d?=
 =?us-ascii?Q?yiTzb7Fff5ujKJWc6nQ9Jcg852Yd2lWKaGhyozjwvy/kw+V27bW14qtpKK+l?=
 =?us-ascii?Q?iOZUuVfIYb/Q9PqfP2+WQuJoHakNi264ooRRnSk8zY4UNYnBE+bRjnow1Lfg?=
 =?us-ascii?Q?9JkkjRBVaNY5AQ/DzMlPeOc1/hpnbYypLhQdhk9cXFasuluQJ4C4x6xzkm2+?=
 =?us-ascii?Q?f1ZcYNmmYgZ3B8Q1jwZhwC+WCyzvEu3LoDYrVi7ra/EFJ4qUCD9UV5lnK8Y3?=
 =?us-ascii?Q?/IXzLTKYHknuzGAycWpbn5tKPnLqCA9wCVVVy29RIuHjPLDi/7/JJOlv1pN6?=
 =?us-ascii?Q?aqtbdntjdw0lGV95rJSNN2FivTsu8EkS1eLuE9G2sSUrrAd8oJtKQrp6aIrO?=
 =?us-ascii?Q?Y1RL/i2r7aXrfqTCqO/NxhxrE59n91rus37bVGInMfhP+lNlePvzuBWpZpMT?=
 =?us-ascii?Q?hw+TdtZbHGiFJjvjGU0VChNdBC1ILmhfn4uXcHdgTN01LRtDmBcLxRLVhwJg?=
 =?us-ascii?Q?5URQSWh9UIR1uWdoT2JjJ8FxO37r9i6+O2VM3vPsCNveWqp98Cbmmuom+AfM?=
 =?us-ascii?Q?i31sezR6zCi+LR2cjdjeRH7MyZ11Qrj33RVvwgIUFv3Hym3OvqNVLyBotdA0?=
 =?us-ascii?Q?pje6LGqq0QkqrdMoZJYTOE9Ej+QId2xbd38JLO66x/mn7vE5oaoYjkGqCjCq?=
 =?us-ascii?Q?798Df1iEQ0TcQprNjNXx26yW3rUWyI3Q3h1APTmMQCCqNiYUEn2uZMM/l+ar?=
 =?us-ascii?Q?wYBtYFImSH7SXzwgbwSY598=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8502735d-8c62-47eb-be20-08da005365ad
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 15:59:01.9829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWaH93vZpfMdIWpa8u8lhYV0NZEnA/NcEdAPA4S3sRlNPca8XttjQpWA69BANaLMJjeE7AkEzIilB9Y80hTnmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8044

Hi Matt,

On Mon, Mar 07, 2022 at 03:15:46PM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 06/03/2022 02:01, Geliang Tang wrote:
> > This patch extended the MPTCP test base, to exercise bpf_skc_to_mptcp_sock()
> > from C test as Alexei suggested in v3.
> > 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> >  tools/testing/selftests/bpf/bpf_tcp_helpers.h |  6 +++++
> >  .../testing/selftests/bpf/prog_tests/mptcp.c  | 27 +++++++++++++++----
> >  tools/testing/selftests/bpf/progs/mptcp.c     | 23 ++++++++++++++++
> >  3 files changed, 51 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> > index b1ede6f0b821..05f62f81cc4d 100644
> > --- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> > +++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> > @@ -83,6 +83,12 @@ struct tcp_sock {
> >  	__u64	tcp_mstamp;	/* most recent packet received/sent */
> >  } __attribute__((preserve_access_index));
> >  
> > +struct mptcp_sock {
> > +	struct inet_connection_sock	sk;
> > +
> > +	__u32	token;
> > +} __attribute__((preserve_access_index));
> 
> Is it really OK to do that when 'struct mptcp_sock' is not declared in
> the 'include' directory?
> I guess the compiler can find where 'struct mptcp_sock' is actually
> defined but I'm surprised it doesn't need more assistance here.

Without this struct mptcp_sock declaration, we'll get the following build
errors:

progs/mptcp.c:64:23: error: progs/mptcp.cincomplete definition of type 'struct mptcp_sock':
64:23: error: incomplete definition of type 'struct mptcp_sock'
                storage->token = msk->token;
                                 ~~~^
                storage->token = msk->token;
                                 ~~~^
/home/tgl/mptcp_net-next/tools/testing/selftests/bpf/tools/include/bpf/bpf_helper_defs.h:32:8: note: forward declaration of 'struct mptcp_sock'
/home/tgl/mptcp_net-next/tools/testing/selftests/bpf/tools/include/bpf/bpf_helper_defs.h:struct mptcp_sock;32
:8       ^:
 note: forward declaration of 'struct mptcp_sock'
struct mptcp_sock;
       ^
11 error error generated generated.
.
make: *** [Makefile:487: /home/tgl/mptcp_net-next/tools/testing/selftests/bpf/mptcp.o] Error 1
make: *** Waiting for unfinished jobs....
make: *** [Makefile:492: /home/tgl/mptcp_net-next/tools/testing/selftests/bpf/no_alu32/mptcp.o] Error 1

> 
> In your tests, did you check that the token seen in the kernel --
> outside the BPF part but in MPTCP code -- is the same as what the
> userspace program can see after a capture from BPF side? I mean: the
> current test only check the token is different from 0 but it could also
> be set at a wrong value (any random value except 0) and we would not
> notice the issue, no?

Yes, in my tests, the token in the userspace (both bpf and ip mptcp monitor)
is the same as it printed in the kernel:

> sudo dmesg | grep mptcp_sock
[ 3057.842339] bpf_mptcp_sock_from_subflow sk=000000004370e862 sk_fullsock=1 sk_protocol=1 sk_is_mptcp=1
[ 3057.842341] bpf_mptcp_sock_from_subflow subflow->conn=00000000f16c62fd msk=00000000f16c62fd token=3420716048

# cat /sys/kernel/debug/tracing/trace_pipe
      test_progs-22898   [007] d..21  3057.858031: bpf_trace_printk: is_mptcp=0 token=0(0x0)
      test_progs-22898   [007] d..21  3057.872544: bpf_trace_printk: is_mptcp=1 token=3420716048(0xcbe3fc10)

> sudo ip mptcp monitor
[       CREATED] token=cbe3fc10 remid=0 locid=0 saddr4=127.0.0.1 daddr4=127.0.0.1 sport=54646 dport=60123
[       CREATED] token=68f336ad remid=0 locid=0 saddr4=127.0.0.1 daddr4=127.0.0.1 sport=60123 dport=54646
[        CLOSED] token=cbe3fc10

> 
> > +
> >  static __always_inline struct inet_connection_sock *inet_csk(const struct sock *sk)
> >  {
> >  	return (struct inet_connection_sock *)sk;
> > diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > index 04aef0f147dc..ba856956f9c3 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > @@ -6,9 +6,11 @@
> >  struct mptcp_storage {
> >  	__u32 invoked;
> >  	__u32 is_mptcp;
> > +	__u32 token;
> >  };
> >  
> > -static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 is_mptcp)
> > +static int verify_sk(int map_fd, int client_fd, const char *msg,
> > +		     __u32 is_mptcp, __u32 token)
> >  {
> >  	int err = 0, cfd = client_fd;
> >  	struct mptcp_storage val;
> > @@ -19,8 +21,23 @@ static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 is_mptcp)
> >  	 * does not trigger sockops events.
> >  	 * We silently pass this situation at the moment.
> >  	 */
> > -	if (is_mptcp == 1)
> > -		return 0;
> > +	if (is_mptcp == 1) {
> > +		if (token <= 0)
> 
> It looks like you no longer need 'token': it always has the same value
> as "is_mptcp", which makes sense: if it is an MPTCP connection, it
> should have a token. So maybe good not to add this new 'token' variable,
> WDYT?
> 
> (it can be added later if it is needed to manage different cases)

agree.

> 
> > +			return 0;
> > +
> > +		if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &cfd, &val) < 0)) {
> > +			perror("Failed to read socket storage");
> > +			return -1;
> > +		}
> > +
> > +		if (val.token <= 0) {
> > +			log_err("%s: unexpected bpf_mptcp_sock.token %d %d",
> > +				msg, val.token, token);
> > +			err++;
> > +		}
> > +
> > +		return err;
> > +	}
> >  
> >  	if (CHECK_FAIL(bpf_map_lookup_elem(map_fd, &cfd, &val) < 0)) {
> >  		perror("Failed to read socket storage");
> > @@ -76,8 +93,8 @@ static int run_test(int cgroup_fd, int server_fd, bool is_mptcp)
> >  		goto close_client_fd;
> >  	}
> >  
> > -	err += is_mptcp ? verify_sk(map_fd, client_fd, "MPTCP subflow socket", 1) :
> > -			  verify_sk(map_fd, client_fd, "plain TCP socket", 0);
> > +	err += is_mptcp ? verify_sk(map_fd, client_fd, "MPTCP subflow socket", 1, 1) :
> > +			  verify_sk(map_fd, client_fd, "plain TCP socket", 0, 0);
> >  
> >  close_client_fd:
> >  	close(client_fd);
> > diff --git a/tools/testing/selftests/bpf/progs/mptcp.c b/tools/testing/selftests/bpf/progs/mptcp.c
> > index be5ee8dac2b3..212e9341b877 100644
> > --- a/tools/testing/selftests/bpf/progs/mptcp.c
> > +++ b/tools/testing/selftests/bpf/progs/mptcp.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <linux/bpf.h>
> >  #include <bpf/bpf_helpers.h>
> > +#include "bpf_tcp_helpers.h"
> >  
> >  char _license[] SEC("license") = "GPL";
> >  __u32 _version SEC("version") = 1;
> > @@ -8,6 +9,7 @@ __u32 _version SEC("version") = 1;
> >  struct mptcp_storage {
> >  	__u32 invoked;
> >  	__u32 is_mptcp;
> > +	__u32 token;
> >  };
> >  
> >  struct {
> > @@ -20,6 +22,7 @@ struct {
> >  SEC("sockops")
> >  int _sockops(struct bpf_sock_ops *ctx)
> >  {
> > +	char fmt[] = "invoked=%u is_mptcp=%u token=%u\n";
> >  	struct mptcp_storage *storage;
> >  	struct bpf_tcp_sock *tcp_sk;
> >  	int op = (int)ctx->op;
> > @@ -43,6 +46,26 @@ int _sockops(struct bpf_sock_ops *ctx)
> >  
> >  	storage->invoked++;
> >  	storage->is_mptcp = tcp_sk->is_mptcp;
> > +	storage->token = 0;
> > +
> > +	if (tcp_sk->is_mptcp) {
> > +		struct mptcp_sock *msk;
> > +
> > +		msk = bpf_skc_to_mptcp_sock(sk);
> > +		if (!msk)
> > +			return 1;
> 
> (detail) if you have to edit this commit, please add a new empty line
> here after the 'return'.

Agree.

> 
> > +		storage = bpf_sk_storage_get(&socket_storage_map, msk, 0,
> > +					     BPF_SK_STORAGE_GET_F_CREATE);
> > +		if (!storage)
> > +			return 1;
> > +
> > +		storage->invoked++;
> > +		storage->token = msk->token;
> 
> Linked to my previous comment about checking if 'token' had the right
> value: it is not enough to compare this 'msk->token' printed with
> 'bpf_trace_printk' here below with the value you have in
> 'prog_tests/mptcp.c' because it is supposed to be the same one if the
> BPF MAP storage does its job (I guess it does).
> 
> Instead, we should compare with either what you can see with 'ss' or 'ip
> mptcp monitor' or with the code in 'net/mptcp/' dir (pr_debug's print it
> at some points I guess). But doing that is not enough: that will not be
> part of the automated tests, just a manual check. But still good to do :)
> 
> My point is that the token is supposed to be random: if you read the
> wrong address in the memory, it will also appear as a random value
> because it is unlikely to read '0'.

I did these manual checks. The all token values are the same in both
user space and kernel space. I'll try to add the automated check in the
next version, using netlink (like 'ip mptcp monitor') to get the token
values from kernel space, and compare it in bpf.

> 
> Maybe it would be good to also check other values from 'mptcp_sock'. But
> I don't know which one can be known in advanced in this structure appart
> from booleans: fully_established, cork, etc. But I guess we should avoid
> using booleans: one bit, we could be lucky to have the good value.
> 
> Or maybe interesting to use 'struct sock *first' (or *last_snd or
> *subflow)? I mean it would be a good test case to keep a ref to a
> subflow. Then from the userspace, we could get info from the MSK and
> then get info about the subflow.
> But I don't know if it is possible: typically from the usespace, we get
> a sk from a fd. Can we get a sk from its pointer?
> I guess it will be needed to iterate over the different subflows from a msk.

I'll try to check other more 'mptcp_sock' members later.

Thanks,
-Geliang

> 
> Cheers,
> Matt
> 
> 
> > +		storage->is_mptcp = 1;
> > +	}
> > +
> > +	bpf_trace_printk(fmt, sizeof(fmt),
> > +			 storage->invoked, storage->is_mptcp, storage->token);
> >  
> >  	return 1;
> >  }
> 
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> 

