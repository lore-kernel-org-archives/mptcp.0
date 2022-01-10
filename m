Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113E02C80
	for <mptcp@lists.linux.dev>; Mon, 10 Jan 2022 07:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1641800630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XJ+efC/rBF/MUZsLbCH4nqe4tDE+qrfXQ43tvq2SHHQ=;
	b=jjIFGjQ9Z9VXlKBgZGcDDLl22oF/vqj33VsEo0yAG6O/YQwbq7r9voSagRFlH7irRq8PDR
	SGtPRCuHlH/loSr+LH9Y27VA6xdscS5tWmyAE02NUjY1B0riMgWzX0pMv4aphnWxfemErw
	bKuHuVkL8sFZ6o3yat6Y4OHomkz00Uk=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-36-LcMTZCF3NKCQDc7n_xHAEg-1; Mon, 10 Jan 2022 08:43:49 +0100
X-MC-Unique: LcMTZCF3NKCQDc7n_xHAEg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekQ4nxnopKxM1p1aiBYo9nEg1o3OoTUonBaGvx1AfDO3YkuQbHmfTzIoELukXYDwmV3imdVtAwUBNDoWFAC1pimU/QZzBOyFAF0jHy+CEM4u4jiU+Z4A20BxNYbu8hxxQuEArJQ8TLiLvXIihpYOcaAZnocQoYqbS/TjoQVAqay7gM2kRHNZSYcWmwl12d/FyzoxHVmc8jEkuNbej4Ap7tCvDYi7DlHl7fP/UMlH9TLUnqFSgxmhp9+ZvSyvUZjoOIO/KVnj8AJg6DHzev67zhlj3glTr5w2svhJs7e6fRXK6lFPH6005yPKqiaytJAWYO4aFau2xbtLIPrCNnavwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qx3wn8sOyYCMMrazn00TboJLjo/CPobGW5njPPaCqdI=;
 b=JNttnUKdg5U6bVs1dLbTAxu0iHmjlKYZrM2MMitYg9aMO1YURdTOjQ/Sz+R4zzHv2Bt0Sg3zt15gK4e3damevtRwb26EKbc3mQBJq95ySoekeKx9KZMAnxvcCNQi5a79nVd9R/tIvEIKY4iglrFhIY/jSbrJ3oTq/ojK9k04IWKrhdCcHGXgJIJ7sHxXOrBrbIjaNNucHQjurl7MCwAXDmNpfSQrxij+LB8hDn1e8Y8+exmbS+xYzEuNQIm0pvDcMIvXD35gpLfe1aLP9GCyZcMB7WfqphyAB2xSMONz/cEgdMNOvZw8exqul9OAR9jnROCvbAVliMjiW4r5Gu6A6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by HE1PR0401MB2539.eurprd04.prod.outlook.com (2603:10a6:3:7d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Mon, 10 Jan
 2022 07:43:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::b5bf:e1b5:42fd:4dba%4]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 07:43:46 +0000
Date: Mon, 10 Jan 2022 15:43:43 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
CC: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: more stable join
 tests-cases"
Message-ID: <20220110074343.GA4714@dhcp-10-157-36-190>
References: <613b986defe37faa7298095b364d9c81d6899664.1641549011.git.geliang.tang@suse.com>
 <9fde3240-18c4-ceb5-903d-64c532a87992@tessares.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9fde3240-18c4-ceb5-903d-64c532a87992@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR01CA0190.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1ccf939-1275-42a6-2e06-08d9d40ceec1
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2539:EE_
X-Microsoft-Antispam-PRVS:
	<HE1PR0401MB25391C6D9135D6D3B29C75D2F8509@HE1PR0401MB2539.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9LwDzk1Rccyy+M4Mi59TM8dYCiLRrjycTiO68Jhgj8L0dAdAGZNvHM/JqZe3x4iIctJY318Q4aMCifRBMPcpN/oVZGEXfJ7Ury4VreFYrimRjvz0diEZOoJjMECWQYwsfF8sTTWQIDGgtyNTl4BMshS2EXdnX7PvuRcVrMrbpOqiwK8UWqXkvO53ET70hFGgzr0HQ2eYy/VLpAFRBkQhoH6RMX38AD8WE8bNhoKqjJgKmzODDJLNzIgp3Yvu3xNaL0LZMLnDoT0Edeqk9v6dGeYd9Hn9lypQF6QJJtdx/lrrbYAa7D80kpL6eRF86JO9vxm0SW4Ov3NIT1racYSAQhmZLcTZvA0mmPj6CMCBHpMStPCPOl+PEf/R65/5TLfnJPcjwresrgvOY6iUzclQhv8A1dBdYE1V2CDTfCYWe4XXJIfKcJuxBflZPg5h0jK6V6SwHAQfNW/nhjYW9bKTp/Z/Br0365rSsJuGTcGQucQPNQZa1FOxnwOtF9RqmiAAEe5OpAqmGLWKd6Hc+QZPFroYq6kqXH0nq6pws20B54DAvS73nz6yx3/MBs/uoBak4h4YpcFHqCOg67ITDrxS5spXFPlVsifO1/yqbZR9xJUTurVxiquMFR4vW9INg8XOFe5eQHO1VzWjcypulzlxTzlMXgpZNIARkaTjME7iXp5sn16Jojs+2hJSkDUUG28ks251oAVaFfi75wyv12+Kmg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6916009)(38100700002)(4326008)(186003)(2906002)(1076003)(6666004)(6486002)(508600001)(15974865002)(966005)(83380400001)(44832011)(5660300002)(33716001)(26005)(66476007)(86362001)(66946007)(33656002)(66556008)(8936002)(53546011)(8676002)(6506007)(55236004)(316002)(6512007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6YqcpM/DdP+bU7AKsumZUjfT/SC2nqkYGpDRXMhSsmJWoInOxttGEPNzCjZI?=
 =?us-ascii?Q?8oZ23pCVuQW6wLSJO81YoOcmGRloqLhn3slDBrzQuryKU0vR/DTkCZu3d5fu?=
 =?us-ascii?Q?TYAn3PYOfLndaS3of715s7qk0wticBQ5Ddew7Ak+nhHiG1vgSooAYFJO2BUs?=
 =?us-ascii?Q?OoVQPA2nC0d6zbpGepdqfgouTiqxFQZMAgRtZ73x2zCDTSDmocm986aWEtEQ?=
 =?us-ascii?Q?+N2EbS13Xs/rXAmpNK7DNtwEdP8Xni7qaeZUiuZaCVXQe04ikZbk4v38J8G7?=
 =?us-ascii?Q?IEaJhGFW8dr946NvbVNjobeYDHFFj93k9hUM/pPxG7gX3+nQKPzRGWLaiQyr?=
 =?us-ascii?Q?ot3bZnilO8/KasSldEKIVBYE+lasA3c2z13ZPJwcy2c1vi0wdW2VK8SYPJfd?=
 =?us-ascii?Q?LTPoz0dV5XAobzEyOk2QXGtPhzvsohHa3+3NTJ5QIxzNS/WYfZIjPKWMaf2f?=
 =?us-ascii?Q?eVfA+YxDRxBCr4oMxLaid9cTlixSA77rqXDVtZnv39302nVg1xllyAhh5F8f?=
 =?us-ascii?Q?GPi+Y3jWPmy0ebq0HqHiVLRhPXfKGznfH5JaR9ho4wPceLNYyA2k76E5U+Gm?=
 =?us-ascii?Q?W9jStzCRQHE0U/wH3Tbll87oa6FLq3L4zFpcxiRNxxLZNaMdvy6oOptOXyFb?=
 =?us-ascii?Q?5mSWEKX2rxaXf5wf9A6veirqg2VEVMvLWnI8/sTK/OU1nUuSyAsL4SC3h7dn?=
 =?us-ascii?Q?QxIZ31UJuBk2zLH4Gyd3TiOFmfMw8yq6H6QYJI4tBlSV8FxTIFOLrqBNTBd7?=
 =?us-ascii?Q?IrtMQWz5rbPW2MS7gmsYveCf5cxC/fRlkvex4VxXHnvoNDKzjhcjZt8joOe/?=
 =?us-ascii?Q?6i0OnTa2Zs4oIvJpuzAdkyO+lvJP6cFyHS0C6/8WotxpXRoaEIgicG/E1T0n?=
 =?us-ascii?Q?xkYsPrIo3Rj81JiAEflyEKIzgiR8YphnuLKJiu8lCivX9r6UH5wsQMwrUCuG?=
 =?us-ascii?Q?kVUu84GABf1RGy2bdrkHPyuYnn0mxB3SSvLBwOSswlno9/lXN2bg8WP0olXl?=
 =?us-ascii?Q?Gtlo6W3G8iT4X4uhcStKzzbXm07nYpcFZLkcbqBFRa2iCWMuNVm91Wn1E8Uq?=
 =?us-ascii?Q?ngMZX4oL8n3wLvBB2j8JfzPrJbGfu2SDXf1DuWM/z0UNqkjdMNQoQbgVZ3tJ?=
 =?us-ascii?Q?Z38LVSgBBN616bLxsD/83wOs9NDqFhGJE2gmBE6GRyq/YFjgTHMGZz9Fyvxu?=
 =?us-ascii?Q?giYF/zS2FQj6e3MeC7nz4gEEt+eUuwdgYhufH13rFXGSblmEmvLtxITl+ZyZ?=
 =?us-ascii?Q?hwDrpinqpWGE5LepeUX9b6KxJHtQXMf5o+kOO9Gihst30gPtt5WZjq3mTHHz?=
 =?us-ascii?Q?gt8HnMky2ZTXsri5Nto/BgFpWRjMR5dsmY2JGJo3tb5ZuhhYo8lsQV91kNBZ?=
 =?us-ascii?Q?LofCorpLDQk+D7r9MDuHDT7PHCP6MhpaJKl21z9OtvC1jFPlA1QPx8VJ0IhQ?=
 =?us-ascii?Q?jvi1m21OrQ7WwRarwAMirR0TwymkKCMZgimN74Xc1SI7+Cfmi+SniJ1JhFD/?=
 =?us-ascii?Q?ASL60jX/MhtNjhWzT2Q5Hk6S7EsPn4Xg7UYe+IEhH4GB1+W1I+4BN9c+b/Y3?=
 =?us-ascii?Q?/tR4ACQV7a9OFC02G1rN3x2fyiWUnUhly1UHXRzc6tl2YLgiLxJCTRByZvP0?=
 =?us-ascii?Q?OoscqXKCI2zHwFwaYim6dpQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ccf939-1275-42a6-2e06-08d9d40ceec1
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 07:43:46.2156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: reJpMtd5PFEDNYivKJA5edcRXrmeoOpNhWFts1vcLyCXX20kdJsJAeGerW5zb3Z2f2OQY2MI+STlQCHIfiO1Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2539

On Fri, Jan 07, 2022 at 12:03:00PM +0100, Matthieu Baerts wrote:
> Hi Geliang,
>=20
> On 07/01/2022 10:51, Geliang Tang wrote:
> > IPv6 removing test failed on my test every time, this patch fixed it.
>=20
> Thank you for looking at that!
>=20
> The public CI has many similar errors and maybe (hard to say) more with
> your patch, e.g.:
>=20
> https://api.cirrus-ci.com/v1/artifact/task/5889173428109312/summary/summa=
ry.txt
>=20
>=20
> > Our CI did some validations and here is its report:
> >
> > - KVM Validation: normal:
> >   - Unstable: 1 failed test(s): selftest_mptcp_join =F0=9F=94=B4:
> >   - Task: https://cirrus-ci.com/task/5889173428109312
> >   - Summary:
> https://api.cirrus-ci.com/v1/artifact/task/5889173428109312/summary/summa=
ry.txt
> >
> > - KVM Validation: debug:
> >   - Unstable: 2 failed test(s): selftest_diag selftest_mptcp_join =F0=
=9F=94=B4:
> >   - Task: https://cirrus-ci.com/task/5326223474688000
> >   - Summary:
> https://api.cirrus-ci.com/v1/artifact/task/5326223474688000/summary/summa=
ry.txt
> >
> > Initiator: Patchew Applier
> > Commits:
> https://github.com/multipath-tcp/mptcp_net-next/commits/3b5258004128
>=20
> Could it be linked?

Hi Matt,

I tested this on my Thinkpad X1 laptop, only two failures occur. But
I think it's somehow linked with the commit "selftests: mptcp: more
stable join tests-cases", it dropped many latencies (sleep 1) in the
selftests.

The CI is runing in a KVM, right? I think we didn't tune the latencies
of the selftests for a KVM yet (At least for me). I think we need to login
into a KVM to run the selftests there and change the latencies there. I
think different latencies are needed. We need to make sure the selftests
could be passed on both a real machine and a KVM.

Could you tell me how to get the CI KVM image? Or could you do this
test?

Thanks
-Geliang

>=20
> Should we eventually wait before and after having emitted the del
> command with different counters?
>=20
> Cheers,
> Matt
> --=20
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>=20

