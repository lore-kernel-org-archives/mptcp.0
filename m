Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B84173
	for <mptcp@lists.linux.dev>; Thu,  6 Jan 2022 02:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641435492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0oh7PRdkJKsnruQMKMYmUZU7fWGDOsqEVzg9Zb+Oio=;
	b=M/NLh5weh+Y/QaRxHu9WottvHTX3uO5W7NzNMxhYPfHjLIOXOrYEnCVaKtH2haKW5rrhKh
	8ln/9fYetigd9F+PtSNVrIZte7mdu1LderGjGaK5Qg/TxD95hclkIcWUY+sc9pIG/g/YeC
	OKvNLj9+LTuwPsFIJNUxmUaaYOpWDT8=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2056.outbound.protection.outlook.com [104.47.14.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-RSP23zquMXuR902ZXGVWOw-1; Thu, 06 Jan 2022 03:18:11 +0100
X-MC-Unique: RSP23zquMXuR902ZXGVWOw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3VKEqIHo0bKXSLy4ERSbDmSuVRi2cMsdVZ4b94hlPm20Bx5bBWJWZOjtwZxs5suQe7+B0E/7vZXRR6Pfosf23Gsc873GGYB+Lf+PidQt1649EluzIkGbeeWw6/c/BjkuL+JhJiS22SXySzhWsmSCtlWQtOcYdK7ACD4eBQ7hCknNsu8UfEZyYFMRciZb2wQx6c+zbtwEX7xUerhsHBijJysdvSDnTDl07kdKuNr4R34oyzFto3mqbOMrAYe4gNejBndPmROyYSzaEkrRv+bw29zRErF0aODnZ/1HDyAlntfBp0gorzoarXJCcN+4arNvwREX+eNbrk6AQ2VEznIlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaRzJWPx8DuPGulZQV5wq9r58uDtKQeJUfStpk53cfg=;
 b=XkgpKa4bGiq8K2fcU/XnHzbGS5DhOmq2MrVIfDma3ZCn8RfMPapI0V7ja+f6G1PNR71L0CRU7QLSscwnIQe4xU6Xoj6uvfDZju+2Smba1cUbaIQcYHWhJ3jBjbmTlU+PwqW8X3NllwLPws5eC2x6wg59Dj12v/p3lqA4RB4ZIf/zg4eOKH7GUfX25u4EeTSpX91dXMDeFlkFJxO3hXNqbKL1XYdCaboWqpx3UeOkO1JFUBoI+Jhz4j/oVw9Ne2rNpYwhVO/88tNt15v1sCHQVMj2OvzL1akaiyh8qk5ReHpfAe7296F/28+V04lYAak2ecuVV4thDDYFWgqgq4I7PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Thu, 6 Jan
 2022 02:18:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4844.016; Thu, 6 Jan 2022
 02:18:09 +0000
Date: Thu, 6 Jan 2022 10:17:59 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
CC: mptcp@lists.linux.dev
Subject: Re: Upstreaming to net-next
Message-ID: <20220106021759.GA3858@dhcp-10-157-36-190>
References: <7b9cdfb-9ae6-287e-9e3e-7cf8e67e998d@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7b9cdfb-9ae6-287e-9e3e-7cf8e67e998d@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
X-MS-Office365-Filtering-Correlation-Id: a2f16072-037d-4cf2-5549-08d9d0bac7d2
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0402MB3497A014AB0690FC00134E87F84C9@HE1PR0402MB3497.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9aPAGs2AmHIDKFQXF97LgtLH5zYGC/s2W8DFbzWUdsARaU6Rw3XVtmfIJAwE09PVa7ILsiTUUPbeX8HTx0Qy4gj5IXo02O8qWXp8Q19GSy2Zq0G6hv+vyyfYhmdXPTBmJvTqHl9YAxc75wXws9M0D64r1rrLb05obs+qDGH+neqHBmTeqOxIGcS1CDcqkh8bN/hAQ4JBT7ICYGurOovNAM51gJNNX1TVS1JZmPgioTPDwcJ1+lNP9+RbVwnBBofjd31JMoSGV4GWOByNFJn1Rmm124gA1ksPXVUq7zp0bJNN+vhSatVNzmmYjBwQjXHFasemRPqU9Cb5NYtWQS+bqskj1Dyuczl1RkTkXM1dommYR7DAOTjPLu7ReaYsla3usQhlSFMsd2dPxhmg0hlPqO1xjzUikPf3IrAW8NoGq9SCkGMjIBH0VpkTmba0N1j/B6aSGlQlct3Pf1tY25xJ1vYvtM13ZZg47dIJ55iAuJvOBBW5GhdzQWGxIxvyZqPr56LvTh+9rSsiwZpOswZzBp7pSL29pHqi/rX1Tx/9jgcDINXIKgrxeqPcaUIXxIuCs8GE1TfJzVDPa8Z87/OBSXrmLG6g24GD9GPajgSxghkOTHe8wLtujr75yrn4DBrEqjKg3mYoymBQXZXzP1kD6A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6506007)(55236004)(4326008)(6666004)(38100700002)(186003)(66946007)(44832011)(26005)(6512007)(9686003)(2906002)(508600001)(33656002)(66476007)(6916009)(1076003)(66556008)(8676002)(6486002)(316002)(5660300002)(83380400001)(8936002)(3480700007)(33716001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bJMt8zBjikScQpj+GrJ57hUsbfPEk/V5BlFWUyNK1W9b3lwlAkmQUXmXzr/j?=
 =?us-ascii?Q?Uc7KL8YjhvR/HPJZLNOkAVXcz8yJ8UKQ2fDdLYKZN0vDMMnVind4hdP5iNKm?=
 =?us-ascii?Q?0Y6aC7jzbWLQwVjtWsow/ga/+xcqFkVOX1t5GzgF9OnfKaTAFLRbKdfkehjh?=
 =?us-ascii?Q?g+xEtNR3SNtxodFbXffX8YTm6ET9xdeOmQEty1nZ9Qfx50VVgwOcxxVMeBIY?=
 =?us-ascii?Q?A4CTQDeIhhU4rhoe2QO5gIoLO6bkg0lGk8aoesNtGB00JAvogh4kLDGLNFNw?=
 =?us-ascii?Q?bHXAREuEaPLlNAN7RZIG9zYfeuOxTk8swW7hk5/VHWu8GmOUqhxIPHcVR5cR?=
 =?us-ascii?Q?d5MjOSFC9KPwerKxkHRSPCgken/Sk5jW77TsgTfyUYQcqH8tDt0C/w5TPVzR?=
 =?us-ascii?Q?LkFJ8NTOYuWZH7sOvRtKay6ONxxhPro/gW8F4eD3FEr3Um6GCwEgo+J81bTc?=
 =?us-ascii?Q?uPAlcbcAFiycfABmjKXP1y2l2xHRMuKwd9PjmR17AB1AC6EbaD0Y+4Kx0k8j?=
 =?us-ascii?Q?E5VW5iC4+O8Kx3RewLQyfoW3X79OXwH7vq41rj0U6Y/8pq9aurr42AKPV2wh?=
 =?us-ascii?Q?8+5ds2Y2xtPJhA3WMW0PcrVWNjUhDUwBnWm6EOLIRq7VhJRMJcTf0m2jIOaN?=
 =?us-ascii?Q?RydbnPCAKB7iAZyNCz22xIPMWtlXuWvLp+x8HgmcB8l6qfKgc89tKrUR1pzE?=
 =?us-ascii?Q?/wpciL0D5voLdoVWGlUkYWfNwMLS03R9sTzzW9rUFBOAW1NZlftBWHGRqSYf?=
 =?us-ascii?Q?7f/t24QDssRwLjvWgllbyum7CNJers1OjqAQ4Wryvzrlyd6vKxX8aYhiAiYT?=
 =?us-ascii?Q?tbteTPDf4+Ojp8tH4oBKEt9dqLSO2qhW8wO7PdNmoJq2KoJduFjPuuB2Gpxe?=
 =?us-ascii?Q?u6iuhdn/AbRE5HqxAZqqlCISxVNIRreSBBgm0dLHkv0dtjghE1SFTxQ6ouLO?=
 =?us-ascii?Q?iOQ0Ltdxr5TzcDEnX6EcCPi18/pV+tURtCiR0HK1VMLEvfeg4A+bfDMJ66Jn?=
 =?us-ascii?Q?Z+gslHTiPkeJL68aReBShTETDA0qFTXMdZZNrESro4qNnuqKhQH+ZtODK2LC?=
 =?us-ascii?Q?gc62aS7phJvWPAKw7NIb0zrCdpKWSXs3d0ehoGowHQ+Be1L1TS6GjlKV9hB2?=
 =?us-ascii?Q?KYgivMCPbVFWbhDNNzolg5dtBRHNnM9ovzN6rtXBj6F5RKbZZLIPzqd0NjJI?=
 =?us-ascii?Q?k0g1OyegV3xSmjyuA3Jvq6F7gFkhCh+kVJE+G8fZU7Hn9Ld1pIcK8dUidlfz?=
 =?us-ascii?Q?RVh0n2OfyqQROHGG4qB0WmV/s5YjGfWT5wnDPavNrMpNGf25rSA66m5XfsmM?=
 =?us-ascii?Q?McCGWDRw0ajdl3AWbkBjfXaE/Vf+kq2sT7TAWL5q9JPDEpEMGKVNsDQIjAPx?=
 =?us-ascii?Q?mJ7Gf3DNBaElQoF9mq4F0ZJ/7etJm25eS5nvFPipqENHXLVqonv7RpdQQ0G+?=
 =?us-ascii?Q?G36lXJ8vqzl+bo33QpLPX3SDhsuJDhjpXlNvJLF0gN4jjV9pr9eQoW3NBr4k?=
 =?us-ascii?Q?9BvwlSYMA3ZmPFOwwnQjMbHb3dq5iyN7aneDvn9Gf9pV7GBEhfzbxMFQv5+6?=
 =?us-ascii?Q?VsJSjYAlC7dTITaHqFRIjK6mK6+/metzVAPsovFEUZ296svXTIhs+F0ZuWmJ?=
 =?us-ascii?Q?BBc7GH7BTHxemJx2qHDVrIo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f16072-037d-4cf2-5549-08d9d0bac7d2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 02:18:08.9111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OnxRVwDBDneOCK3uUuTB8FdQIJxnQ/J2GAbiKK4C2C3atYnVQ/AmfbFQU6K9WHfZ23LTeM30taV2MP6TsNstA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3497

On Wed, Jan 05, 2022 at 05:54:12PM -0800, Mat Martineau wrote:
>=20
> As Matthieu noted in today's meeting, we need to figure out what goes
> upstream to netdev this week:
>=20
> On Wed, 5 Jan 2022, Matthieu Baerts wrote:
>=20
> > Patches to send to netdev:
> >    - net:
> >        - probably best to send:
> >            - mptcp: fix opt size when sending DSS + MP_FAIL
> >            - mptcp: fix a DSS option writing error =E2=86=92 but we mig=
ht need
> > to change
> >        - But if they are accepted after the last PR from Net maintainer
> > to Linus would delay stuff.
>=20
> I noticed that Jakub sent a "Networking for 5.16-final" pull request to
> Linus today, so the 5.16 ship has sailed.
>=20
> >        - So if we don't want to rush to look at the tests, we can also
> > send to net-next for the future -net (to be check which tree is merged
> > in which one first?
>=20
> The next pull requests from Jakub to Linus will be from net-next, so that=
's
> the fastest route to Linus' tree for fixes that will be added to the stab=
le
> tree.
>=20
>=20
> >=20
> >    - net-next:
> >        - patches from Paolo could go there, fixing issues, see GH
> > issues/250:
> >            - *@Paolo*: OK for you?
> >=20
> >        - + checksum fixes probably
> >=20
> >        - best to skip MP_FAIL series for now as we don't have a stable
> > selftest yet
> >=20
> >        - and no need to send Mat's series as it is linked to new
> > features in the Netlink PM part, not ready yet
>=20
> Here are the commits that look ready (commit ids from
> export/20220105T054758):
>=20
> Paolo:
>=20
> 9f6720406819 mptcp: keep snd_una updated for fallback socket
> 95bc19b21e00 mptcp: implement fastclose xmit path

Hi Mat,

There's a squash-to patch for this commit in the ML, ([mptcp-next,
v8,1/8] Squash to "mptcp: implement fastclose xmit path"). It works
on my test and looks good to me.

Could we squash it to "mptcp: implement fastclose xmit path", then
send them together to net-next if this squash-to patch looks good
to you too? Or could we send this commit to net-next in the next
turn next week?

WDYT?

Thanks,
-Geliang

> 37b1cee6f04f mptcp: full disconnect implementation
> 916957cdccd6 mptcp: cleanup accept and poll
> 6358b829913e mptcp: implement support for user-space disconnect
> adba2e970980 selftests: mptcp: add disconnect tests
> afef858f5fa4 mptcp: fix per socket endpoint accounting
> 9caba598fe7a mptcp: clean-up MPJ option writing
> f584047ecf9a mptcp: keep track of local endpoint still available for each=
 msk
> fc51a4526843 mptcp: do not block subflows creation on errors
> 893d4cb7ccb9 selftests: mptcp: add tests for subflow creation failure
> 128e78db18bf mptcp: cleanup MPJ subflow list handling
> e470b365da5f mptcp: avoid atomic bit manipulation when possible
>=20
> 3cdd8e644985 selftests: mptcp: more stable join tests-cases
>=20
> Geliang:
>=20
> e493c8de5c58 mptcp: change the parameter of __mptcp_make_csum
> b79d45e020fd mptcp: reuse __mptcp_make_csum in validate_data_csum
>=20
>=20
> Sound good? I may have to send in two batches so that patch count is not =
too
> large.
>=20
> --
> Mat Martineau
> Intel

