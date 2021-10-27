Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453BC2C81
	for <mptcp@lists.linux.dev>; Wed, 27 Oct 2021 13:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1635340087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bdomIllnwPfXUE0ib69vGCFmMgxaJv7tU9n9KbuwXHo=;
	b=n6ZI0kbYf3T+3qld4YqHi7BGWb7M/Xg8TvUVS0S5HBmPC8S0UX6wL2+HfDtwSgMKI6dJly
	UhycqF4F5lN4aFhD7LeG92eXxqLxMchVbRM/7Gvt3JsgmV0iOxU1TIEBbiOlVSfmjisBz/
	vZzeCLUcXKTG10yn4WZzv2ZN1hF6Uwk=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2052.outbound.protection.outlook.com [104.47.13.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-26-02BVkBpOMX6ncCCPXt_q4Q-1; Wed, 27 Oct 2021 15:08:05 +0200
X-MC-Unique: 02BVkBpOMX6ncCCPXt_q4Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHe2KyR+R5LvGad60Sj+U2PRlbuB8q2swGVCjv4av4mEIyDkIG1auMp9X76qpgHR/IUrgJtfKbGumoJNgTJhEHFY4XHVlT/B9rbygLyhbXSHN8yrHd6m9F2C1M1kiygtcgeYxjO6A1za3SGhgc26xRUqXp/kzF8oWIqryhQI7lmOux2n4ns4lMmJ+Ycqt5lx5z5z6F27fbJ3Tfgq2R5AlXaTEwNRVq1kVzfXPB9yY7w8hJhklGz4KwBNsIcOa6jTgySeg/caAhqlFoVOONRsH+9j1j0TBGqUtkDNJHeecgrbnxZ6GcZfs8akrRXQpVwkxQyBjYz+PqnADBj6/mvUuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Me7ZFl4t5BrWOhFwdKuJebGPsO5XXcTtkiBKawbOZgg=;
 b=ZVQkk7xOj55dPdeWAQDunRiqplYXmkE4+/Y8Ml6sxzBz9Ddp+au4Nz3KD4UJpDAZY2gMVXB1RMo8ROK5dI8YfhTGL5Ul2Wpl4XNovrA/jiijM8m0SaqXJq3JZ3J0gtKEBosnrGNmW9viiDDkmvERLgAFcY0EZKbq1STwquN4wIXJa9YXlecTDgE9cRmXiIQsdvVKBT5CxgURtYB7CNujahhN/XzcLSQ85f9B4yIrtZKrPr7su8CVywN0JlDCa9e0EnLpWBH4thQzZf4FsODWwLFbFKk5wo7eL+PoaOysFGIMVDFaeCq/4GCMHENom9XgyKbcSAEdETKOn4ZFV1UUtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 13:08:03 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::15cd:f2b4:6acf:99af%6]) with mapi id 15.20.4649.015; Wed, 27 Oct 2021
 13:08:03 +0000
Date: Wed, 27 Oct 2021 21:08:00 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
CC: Davide Caratti <dcaratti@redhat.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] selftests: mptcp: add mp_fail testcases
Message-ID: <20211027130800.GA3518@bogon>
References: <98ce131530c3ae91bf2ca29e6566ca1f7debe202.1635330390.git.geliang.tang@suse.com>
 <0014ae81-c8b1-e3d1-4580-40bb299c17f4@tessares.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0014ae81-c8b1-e3d1-4580-40bb299c17f4@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR02CA0135.apcprd02.prod.outlook.com
 (2603:1096:202:16::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Received: from localhost (2408:8207:2546:b4d0:c652:b659:7170:192c) by HK2PR02CA0135.apcprd02.prod.outlook.com (2603:1096:202:16::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Wed, 27 Oct 2021 13:08:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3907f8fb-0673-4f58-ff7d-08d9994acf46
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3371:
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB337148483287FE298940501CF8859@HE1PR0402MB3371.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RFNeqknW8boQiZy7MKtdwhOtKXEei28RqBfbD73zwctkMJoLUK1P5aalzlHuGZ4rPv+CyyEh9W3yqVT51nmpFxLTAfk944PwL2ZjKFBzDL+AeCaQJZMQ2sgElUj7Fla1MkKpQLLkcje6SYWv71oaQxBuMKGlf0nEpAXzrXuSvVrqLtSk7lb1W4LMYswyv32uvVhPv116hQ++91ldf5aAls9YS3Och4nxD6ZtvvHkF6p86EAJnfG+YQ5frCg1umBZOYQ0tdbTu8nGDFR+BsXuqfNd3iIHfabgEjXbi4/WxF+9JaZa+MYXAn3M8A6m5BERGfE5Qxlsh4yloiIiX9RkSzJs1l1tZtIA/A+Z6MYWc1fPzIR1ritXob79wCTXu1dM0DZj0qO4cmfjFTrUWGpBUbfJN8DParDtHGs4quN4xJzkSK/1PG3Xfyq3hJeds39FM07hgk2jTDBDmn/kOISahPbb1hTn+/9h36XkvMCICzYi5ABnDQ1/NyR59vw0jIcsrhpcnSLhc9pTuIjGeEPDUNGuUmvw8HwAoJ+eni0/pkDAYGzmZ644mfQnh/lttZORSCPrGilqXQfCgBsax9rXinNVcSPKK33Da7NZ6X2TAfiZ+P03fCFYrOF3UYxLreC4l92uzkYhZaNy9M7OIjU6M2wSKwXY9+ZE8gY7tI0cJcVVks2wVQ7hVknEU5oTai3o2jnzazgPWE+9Avh4JaQCLvrQgUA0WCVLDvxQX6HHudc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(38100700002)(6496006)(9686003)(186003)(44832011)(6486002)(33716001)(53546011)(1076003)(5660300002)(8936002)(86362001)(8676002)(33656002)(4326008)(508600001)(66946007)(15974865002)(83380400001)(66476007)(2906002)(316002)(6916009)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KkIn8U+MOmz68zKzw8XpE7Jmd3xxO3LJg+kLYJV2lvTQ6Qw0G6fF2PuTzeQd?=
 =?us-ascii?Q?Ca8rX3pNIXsysbYqKQvqKn4OiSYOaFij3O/fD/TUd2Ra8dW2LKvFWZ3+4Gvl?=
 =?us-ascii?Q?aMf2jsf56NwuvY7KFt+e+ID59+oLSzQL56KMUjfxbeEFK5bKECNVkmTDTuUJ?=
 =?us-ascii?Q?ylHM/U+CbGZQP9s63qMRZhdUR00Ks43josR8dgYcf0ywWVn4HZPI9RlCdigE?=
 =?us-ascii?Q?tfYec1SiBx06kzx8iRw/daeKZQQKRMYLogsXNv0hN48lOtleEH2dgUkwOyL6?=
 =?us-ascii?Q?wxpXxWQv2q20gWS8kLTC1LStBhEiICMZkZv1/YoYsDPIjomNavcIZ16EFPCz?=
 =?us-ascii?Q?w/xXChMVTgz19sT6XxmAc8GTMQINQKGgx+4wkl9RQqv+77l8SdHUIIHDai+M?=
 =?us-ascii?Q?9F9OBAo1I+bCz0GcO8nUbTuqHALgD2iUgJF6pj2ibq5/yHbLVBzj9THXTDjG?=
 =?us-ascii?Q?/AlwmV9Tg8ulflk8sCmCyt5WxgjJkr9yB3psxKgGTmouD8HQ9ohzNx7W10pV?=
 =?us-ascii?Q?YNv3skvRi2JVOGQNTkqNcQ4xVGUnSe5N6cizbUTgRbdc/4g/JwsATS+RqwI3?=
 =?us-ascii?Q?bZaoFnO9+1JJi6xC6z2UszT3Ic1Vef10SV+WQcF1oe3hAMNCQHY665mtuMDb?=
 =?us-ascii?Q?vYvBapUZJSz+JVD8XA8ctV5SqGSR7Es+0dDxU8w0GzFeaM1qwC+9hsDNCEIy?=
 =?us-ascii?Q?CP7El5/4A6d+XEPJUM161HHhZXTq1rLpxojiyz2A6ZMALm8Fqctell51hBVP?=
 =?us-ascii?Q?hYjX/NRJBQMSbIQrHM6croN4nvu0sJC2djm2/uxnAaP8F3IqgBTxEMK81g4E?=
 =?us-ascii?Q?zrxsxANHupPYbB4IiOhmmBvkSg2dPPWIssoi1doXyjVj5/+YHuBISXZG0svz?=
 =?us-ascii?Q?oH3HM/dMamJ+jbfZ/0paIyxwT3SMAmRXzAS5AGjphXbiRKbpNGVZAJC5G+VE?=
 =?us-ascii?Q?NuDk/tDGe1mKG/SY0coUyhcoOLbTW3gDmYV13udrGL3LEYcsCb5kk7lIAcBP?=
 =?us-ascii?Q?JDl4Xr8o+ctLtdUbVhVujrgSjZLJdOD8gWeSKswmFiBcveZeaXaOsHoszXIZ?=
 =?us-ascii?Q?6hCER834PIsKRvRk00iNvuf/wiGC3WbcbpWHhG/wlp0vy5lX9hMIjXtt2dEu?=
 =?us-ascii?Q?fc/51CXdgJvY7ButdZcJdvSvR36+dzxuo3mD4aOuaLujC1Lwe2dEP2ns1mPY?=
 =?us-ascii?Q?dZia1vtr371E3KeZha14W+zlt9SY1n+JIVXfhtFZH4yWXQ2C11+1LtFesSvN?=
 =?us-ascii?Q?XtNtErqGp2Knda4Ti9/AQpZ3CZC/vpAWs0tqW4DF9KX9B9uExeH6rMkJfxvw?=
 =?us-ascii?Q?q+A2sbrlxzyoD595wzM+xGj2u5vO+T31YsQ1D6aj0LOm54QON0BwHSd/z+HY?=
 =?us-ascii?Q?p0Z2dXFqZsFdQPoMd/fzIXUf+IqIl3ki0nBPqNdhAE5jYnRvg4yZWHvB+VR6?=
 =?us-ascii?Q?CifWHkLlJg58e1Ipi+9G1Z2K5+ZnbEW24yKOt7A9/5IXaefh+uFTFGyu8U/w?=
 =?us-ascii?Q?KULYFqGmTTWKet0Qu8dIxicYhGfW4LQvP0L/8uvdEZS5qMWw1+xIGQrEw/Zd?=
 =?us-ascii?Q?PUqYziZa+m3uCf6dWMITAG3hyI4DrTZrAzHmEf7zGNIqT1XSE5BwXirLR3w8?=
 =?us-ascii?Q?X0BEHDnFBgFpFaoIShrer71Kqg1Zd/39UjpeBNGP6lV7q+EH4yIC8tCF4Eis?=
 =?us-ascii?Q?40BSkGy9cqpXkeuU+Wunk8LltMw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3907f8fb-0673-4f58-ff7d-08d9994acf46
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 13:08:03.5169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6YzhcLdYOZ1Sdz5JqTuFalp6OKdU+l7hL3OLvWT3acExoX7X5z+eQIxAvk9DkPXu8S1jfaSLv/8JGYf22vHz6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3371

Hi Matt,

Thanks for your review.

On Wed, Oct 27, 2021 at 01:07:20PM +0200, Matthieu Baerts wrote:
> Hi Geliang,
>=20
> On 27/10/2021 12:26, Geliang Tang wrote:
> > Added the test cases for MP_FAIL, use 'tc' command to trigger the
> > checksum failure.
>=20
> Thank you for looking at that!
>=20
> > diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/s=
elftests/net/mptcp/config
> > index 0faaccd21447..dc7d5d1d5861 100644
> > --- a/tools/testing/selftests/net/mptcp/config
> > +++ b/tools/testing/selftests/net/mptcp/config
> > @@ -15,3 +15,11 @@ CONFIG_NETFILTER_XTABLES=3Dm
> >  CONFIG_NETFILTER_XT_MATCH_BPF=3Dm
> >  CONFIG_NF_TABLES_IPV4=3Dy
> >  CONFIG_NF_TABLES_IPV6=3Dy
> > +CONFIG_GACT_PROB=3Dy
> > +CONFIG_NET_CLS_FLOWER=3Dm
> > +CONFIG_NET_CLS_ACT=3Dm
> > +CONFIG_NET_SCH_INGRESS=3Dm
> > +CONFIG_NET_SCH_HTB=3Dm
>=20
> I guess we no longer need HTB with the TC commands you are using.
>=20
> > +CONFIG_NET_ACT_CSUM=3Dm
> > +CONFIG_NET_ACT_GACT=3Dm
>=20
> I don't think we need gact anymore if you don't need to filter some
> packets, e.g; one out of 10.
> Same for CONFIG_GACT_PROB.

I'll update this in v2.

>=20
> > +CONFIG_NET_ACT_PEDIT=3Dm> diff --git a/tools/testing/selftests/net/mpt=
cp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > index 7ef639a9d4a6..8bf38db1d54c 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > @@ -232,6 +232,20 @@ link_failure()
> >  	done
> >  }
> > =20
> > +checksum_failure()
> > +{
> > +	tc -n $ns2 qdisc add dev ns2eth2 clsact
> > +	tc -n $ns2 filter add dev ns2eth2 egress \
> > +		protocol ip prio 1000 \
> > +		flower ip_proto tcp \
> > +		action pedit munge offset 148 u32 invert \
> > +		pipe csum tcp
> > +
> > +	sleep 1
>=20
> This looks dangerous to me. We should probably check tc counters to see
> if the pedit action did something, no?

I don't know how to use tc counters, could you please tell me?

>=20
> Maybe on slow environments, one second will not be enough (or way too
> much). Maybe iterating every .1 second on the counters to see if
> something happened might help.
>=20
> > +
> > +	tc -n $ns2 qdisc del dev ns2eth2 clsact
> > +}
> > +
> >  # $1: IP address
> >  is_v6()
> >  {
> > @@ -419,6 +433,8 @@ do_transfer()
> >  			fi
> >  			sleep 1
> >  			ip netns exec ${connector_ns} ./pm_nl_ctl del 0 $addr
> > +		elif [ $rm_nr_ns2 -eq 10 ]; then
>=20
> I'm really not a big fan of giving a number representing something but I
> see we are already doing that before. Also when you use it later:
>=20
>   run_tests $ns1 $ns2 10.0.1.1 2 0 -10 fast
>=20
> With the IP and "fast" it is clear but not the rest. Using something
> like what we do with the fullmesh (fullmesh_1: 'fullmesh' mode with one
> add_addr) seems clearer to me than giving "-10" or replacing "-10" by a
> variable (e.g. ${CORRUPT_PACKETS}) but OK =E2=86=92 we should do more
> modifications around that I guess.

Update in v2.

> > +fail_tests()
> > +{
> > +       # multiple subflows
> > +       reset
> > +       ip netns exec $ns1 ./pm_nl_ctl limits 0 2
> > +       ip netns exec $ns2 ./pm_nl_ctl limits 0 2
> > +       ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags s=
ubflow
> > +       ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 dev ns2eth2 flags s=
ubflow
> > +       run_tests $ns1 $ns2 10.0.1.1 2 0 -10 fast
> > +       chk_join_nr "MP_FAIL test, multiple subflows" 2 2 2 1
> > +}
>=20
> It looks like you are using spaces instead of tabs here.

Update in v2.

Thanks,
-Geliang

>=20
> Cheers,
> Matt
> --=20
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>=20

