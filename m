Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2044.outbound.protection.outlook.com [40.107.8.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330ECA34
	for <mptcp@lists.linux.dev>; Tue, 10 Oct 2023 06:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T/nbEbRi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAMCfiH2M/YVHHfRybXRdr7oSkCg/VEB06QrTfQ6d4ObSEP4NUKpq31zESvYuni2ZEx3eKXTD4KMlCE9a94zk0TT0LjG5M0b/GYK76knfJUDKM6K96vRQSp8GCqSLNM1xOCnMpso75V8wMWRyZ649Qpc+ifQKWAQuhg42UgSBerMg+frd07J6evpX0uIQzRDmJwDbnknMpZpGhJCZ1UCpMKkme+GLGEiNH6NV2Vsl3m3pK8S8os3K78EgfW6Q1VMbx7Ve4QNpfeuF8FfeWyhgFq+Rg2kyiS/m5RAOt/l8kTykxvo02RhL2n0L6h9WIRbddBgwh7LTc+/y/nX0uQ3EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2f5tDxasLELQoFck8TUIqNmfhAMXAJgNV+6sRDn6rw=;
 b=f728n9a8BZegzmFQM6HVPCXBTeaagGfxko6ph10/iu8I7rforelDkeYmYx2fF/fbzObQNKDCRhro+uan6vvohSlnzWg+hbSc2WdCaqvxssbDlkUtTA0zjq4p5IFYN9SPlwfAoeJkNRlDPb7Y2mMhVtrhZxx6/WiYVfTayvFK528JlFEcQ0LVz+gPoDlx5+CWhqU6EKvQA/rj/uQeF1NMaqYtRKJA/e1VxC1L7zFC0QluLbv+Wd/54UZh2nFwJha9Vnb/V5eLSK6fuUdDwsrFBFskLLahhG4vm5z3qifyJqxb/u53rgsY/SSxw4RmYT9LNeeJ08VXgXB/wMQCJuTdRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2f5tDxasLELQoFck8TUIqNmfhAMXAJgNV+6sRDn6rw=;
 b=T/nbEbRioFFSZk7MsuCwJfVPjsLVvbnsjnmL4WaGqLLs3FSdSdHoLwonDfokc2pq1pQy+QYLFtQX44XhkiYXgGnneqNsBcaSl7joTiddSbwlOKNP/Q8pyg5mh+GVM2VWj/vvI6c3WBBAtV84nFdJLNpkLWi/DeOfs5mf+124TN+q+0bcSyQMwDcyiJH9k7/KqCyRzZwCJIu0OioC1wwlijzS9jl2cUG+0C2XWsXm1SVtO4VdqNNS/PAEe4z/EGiqK+9XrnJP1uZNVAf0k5SF9uy0qP/DR7rHjMQz3akiQQ6AI49zmXoYBL9BL0/AmyVaqc0rxld1hET24hw0wslU0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8908.eurprd04.prod.outlook.com (2603:10a6:20b:40b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 06:11:59 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 06:11:59 +0000
Date: Tue, 10 Oct 2023 14:13:20 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v12 1/5] mptcp: avoid resetting when another
 subflow available
Message-ID: <20231010061320.GB6593@localhost.localdomain>
References: <cover.1696831239.git.geliang.tang@suse.com>
 <2b69fa22510db02a12eb101c3e8173dda76f8133.1696831239.git.geliang.tang@suse.com>
 <76f31a37-16b4-4e3a-8b00-fdb2c1eabfb4@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76f31a37-16b4-4e3a-8b00-fdb2c1eabfb4@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR01CA0115.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8908:EE_
X-MS-Office365-Filtering-Correlation-Id: ec7d5772-26b1-4c47-0159-08dbc957cfa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+SCE8S7MDBzIy3jJR5Zw3L6FqKfFBHUa9XWi6dIXzjovxKfKuV69uHq/NZdYaR9H8X/fFQHs3li8Nq9nmZwCABBk0GnggRSKkxzy4qr93NuhM741Ux/BAIcoIU/AUpisZyHi/6w3sGWw0r0ePeWTvAAc1TkZNC0aUhLnLqnEde4u/SefstguWb4KLqA9jI+8hu9hyRafRKFqR0VFmtZ/iAWzvrdyKKOuRIelWJ6Y4YbTLycawQ7h65fS2OTIobj/NmwcgWltMOmCyTGUxUXZCt8CMWPSZ6P0CNKh/6Y1iP3vsWMteZu9DDw11pUFJiMEP+B8cgBHmspbhwbXVeTJuDm7LwZaRZ13fBz+6Hh7rQlp1XdDQ9aMV5dwrQkzKnINr5Kf89cfFQNaZ08/03D36l8HneOnLLLgoPb1rgpLH0FRGlNeaGaZNhVS1Au79s5KjuQwC1HvVQQ0RzMd0VYbL+ZvOIDJw/6ocAMVvLVEpMVa41TxYYZU18Vvl+F4VhdVOqt/+7LgeMmjzeYSYSEcOWtahuG4c8BJR1h1JWx9s4Jk7+8ZdkINPO9A5cMXFqgoypQGwX/XoUXQYxMuUvp+NRi/UK7qmru8p1wVqMQSVN4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(2906002)(86362001)(33656002)(15974865002)(38100700002)(26005)(6666004)(8936002)(4326008)(8676002)(6486002)(9686003)(6512007)(53546011)(6506007)(1076003)(316002)(41300700001)(6916009)(66556008)(66946007)(5660300002)(44832011)(83380400001)(66476007)(478600001)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m+a3KRNnTMHVjYvMAVfwEnQgpSHLLG7BvT3vu7B4N+jzYx+K+ifVjr1Kg3+K?=
 =?us-ascii?Q?OYoB7VjnwXVFy3c3qpKqM8aygB/vA+nJQGn4nc58F9B9H7bRZ9LnxidTGWuT?=
 =?us-ascii?Q?ewnAEKT3ZfE4TdK94IOE39PSOQKlzvS27kf2m6uQaOOVZh7yXPMN5Jf6xFcc?=
 =?us-ascii?Q?3s/VvGEX30iqpwcduifFyOzvXFitVrRphbJybNTE/3MbqDEYigr6xGAjRBf7?=
 =?us-ascii?Q?FNkgf0/kPmeU0Ah75NMe+9tmpop6tUgYs8LI1IJO3RK8iiziLFJojgZ1NOmo?=
 =?us-ascii?Q?/v0+QCXCHNTRqKGxnrFhAgRwHZTdUxWh1OsAhqrwSgvWzInQjhRnOavOvs6x?=
 =?us-ascii?Q?gmNnpWJh7FbxuNkOh0gvzeBiIAK+rm+gw3UPlVH3MnO+rzKLPaWo7B0Oyhqv?=
 =?us-ascii?Q?1e9DbyTF+O7SyCLala1GiIP1UjwqSGceNcFTLU2Mv6f++KTyMe3pGIE7d08T?=
 =?us-ascii?Q?xFuyZbEEA1fY4EMkpYgzIwbSxPOc7AdJc4R1Nvb/asEAgERvP4wGvFhmFuGR?=
 =?us-ascii?Q?jCCzPc9P04WDpsiXL05ft0KT8mJeZ3ep2f73G4HA7IVHC/VaheGT6K1yNY6r?=
 =?us-ascii?Q?D0UAPJdUIHppWSwhn+Mc5Os6PwCo5QclxvOrA/ZNTwauO+8QNKq1OvGzSlWG?=
 =?us-ascii?Q?sRHR0X0KSrmY+dl595T9ijBi/GMPPgqwQ0JGQapJKiNQyHU0dbt23i8nFyAi?=
 =?us-ascii?Q?U2qZcxExppFT/uyS0FHXknJn4CRWKPclzqgLLP8/bzXN3zMab7dn1IhCfabF?=
 =?us-ascii?Q?/ZDYp4LNzt8zNSdxBZ4hPlgTCD4r7AoAJn1aYBBTaHvtbYETB7X9D1uDEebr?=
 =?us-ascii?Q?jY0GB1ciZ63RdPcYmH5YaDJIGG2UIUTBV0eZFB7WHEe/CrYgzcnpt3VcKzMb?=
 =?us-ascii?Q?rx0sM8QOY0tnk1qnEhLgIQ5iDHPd42VmTuxAHnScPc6EVqsSGgMtIUH5KxRD?=
 =?us-ascii?Q?74JKlrQCtutH1vHRzK8ybD3lfScR0CV0VD4PB1BrHUrRCx87na2t+rrNHN70?=
 =?us-ascii?Q?MOWXyBi2DU6Av0jRX50LV3R1MsFCdwLyLgzxOIE6r2O2DnMNbTzrQ2RL2o6y?=
 =?us-ascii?Q?STs1gCW4LIbQO3/yk1ACm2D+SIVNf7l0nuQGBMjukcVQQ01lCff6nim6fpPL?=
 =?us-ascii?Q?kollT1vzv9Du2PCjZs8/9sEEbyioC/GTNQWHHr9Aqaor64gM4HpBeIlvHdHO?=
 =?us-ascii?Q?4/igZCkqv78QvHkjZdJIKErFkvqFlhNB8PZnDPmB0bntGDN6awIiin0+PRaH?=
 =?us-ascii?Q?bB6JZ1Fd1lmScM+lFQ3x5Tb+43AzWxsQVfRnUUOaB9Tw/rQgipnB4Nwh/C+1?=
 =?us-ascii?Q?5xYRcPfJ+YgWULZvYUJCzkOdHe5WCay2n7yilqNiOUJBmR1prmWRE04ReXMe?=
 =?us-ascii?Q?YdN0HSKsPmhgDYJUNgNsCU3icy/CNPywVzAVNq4AaBXNWS8etTRSblZq2wnF?=
 =?us-ascii?Q?//0koIni7aY9XAoMwTrQzronBeUin1mpoWfYOWuwRrDA8uli5nMv7Plggnhy?=
 =?us-ascii?Q?tTKEQfMba06LbJhxdO40ZCmWPiAxYlBNf3yZqv5wV5q0N1nCMaaQoA+d1Pca?=
 =?us-ascii?Q?ZpPS/JqGl10XL9b6clLLcwWqdvzCNgFuu46wFZ2N?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7d5772-26b1-4c47-0159-08dbc957cfa6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 06:11:58.8677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HssnYlIKAxwBJODLMJZgA5KQSjCXq4k6C6fUjzjhOckL+83JZuDHOyFSA61MwOiTTc+bE2newG2DrYIHgeB/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8908

On Mon, Oct 09, 2023 at 06:13:19PM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 09/10/2023 08:02, Geliang Tang wrote:
> > When closing the msk->first socket in __mptcp_close_ssk(), if there's
> > another subflow available, it's better to avoid resetting it.
> > 
> > Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> > ---
> >  net/mptcp/protocol.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 30e0c29ae0a4..6346a164ed66 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2396,7 +2396,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> >  		goto out_release;
> >  	}
> >  
> > -	dispose_it = msk->free_first || ssk != msk->first;
> > +	dispose_it = msk->free_first || ssk != msk->first || !list_is_singular(&msk->conn_list);
> >  	if (dispose_it)
> >  		list_del(&subflow->node);
> >  
> > @@ -2446,7 +2446,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> >  
> >  	sock_put(ssk);
> >  
> > -	if (ssk == msk->first)
> > +	if (ssk == msk->first && list_is_singular(&msk->conn_list))
> >  		WRITE_ONCE(msk->first, NULL);
> 
> I don't think we should 'dispose it' nor set 'msk->first' to NULL but

That's what this patch dose. Dispose it, not set msk->first to NULL.

> instead, we should not call tcp_disconnect() directly: if the connection

But this patch lacks the code to handle:

	ssk == msk->first && !list_is_singular(&msk->conn_list)

Is my understanding correct?

How about dropping list_is_singular() in the next block, something like:

         * For established sockets, allow an additional timeout before closing,
         * as the protocol can still create more subflows.
         */
-       if (list_is_singular(&msk->conn_list) && msk->first &&
-           inet_sk_state_load(msk->first) == TCP_CLOSE) {
+       if (msk->first && inet_sk_state_load(msk->first) == TCP_CLOSE) {
                if (sk->sk_state != TCP_ESTABLISHED ||
                    msk->in_accept_queue || sock_flag(sk, SOCK_DEAD)) {
                        inet_sk_state_store(sk, TCP_CLOSE);

> is still in ESTABLISHED, tcp_disconnect() will send a RST if I'm not
> mistaken. That's what we want to avoid, no?

Yes, tcp_disconnect will send a RST.

Thanks,
-Geliang

> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
