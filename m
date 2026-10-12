Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazon11021079.outbound.protection.outlook.com [40.107.57.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64AB41D114
	for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 11:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.57.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805369; cv=fail; b=DatJX1qZIzDtC4YwdxAMg0RoHK9VthQZkHaF4hmPn+uw9qih+VyuCQ3E8BD4scRlG06jynPkNkuvNAEsWDG7UFFCk9RP57Gw+sRhbObsLFK2t2rxdY1eZLtONRaZwuqzXjrjSBsux79vFkaKXx4e4oxHzEXTNxsZHyFHraRvoOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805369; c=relaxed/simple;
	bh=fcdvUZFhqn0t+9QHh7tuQuagRQlQHELG2YJMbi+iUa0=;
	h=Message-ID:In-Reply-To:References:From:To:Subject:Date:
	 Content-Type:MIME-Version; b=Vcnhf6M3wb2A6d2wPhye/7XYefV1dUnTgmInquwcRpaZPMr+WPqTWrVnNTpv1c6jcLVkS8S3RixVTRERMBIHUlbVwQ199aEY1MfKLXtL0SKJHMN/ZCuVVec+4xed/Tn7qSxs8P4OF6ssUSfpI0qa+RUx9nIebGe1k0FaO0DGn10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=persistiqalpha1.pro; spf=pass smtp.mailfrom=PersistIQAlpha1.pro; dkim=pass (2048-bit key) header.d=PersistIQAlpha1.pro header.i=@PersistIQAlpha1.pro header.b=m+y0oZCP; arc=fail smtp.client-ip=40.107.57.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=persistiqalpha1.pro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=PersistIQAlpha1.pro
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=PersistIQAlpha1.pro header.i=@PersistIQAlpha1.pro header.b="m+y0oZCP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvQLjjZBnwJ/ES2s6T//lwHjTXrbFYypoMjRXUgyFDLZsj2tiHYfH/Je5vD/Ecb2jX0+P18pYKULPvAlnKrfNujVAEOOP7u2xoUP25xq0/ZzZXfXxmSK1ruz4vUh/PaGTgGuIOGOV3kNE4c/cAkHUQI2Odc2IsrIwotC8NCssPdHf73jX0z1hsQyzNw77tJBBpZPOjsZ5p7T+uYSqfgV8smt/i7OJwHll4OZ5UZjJxQ1xdYOtq5owCVJuS9D1T969BLwMgw9fvWHnYn662Sw4c9E1Ubob3PIZBvcsSMq7qzgC70XU4G18crPJa8mJdUcvj0L/b4zSb6bJhQCKXjWCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcdvUZFhqn0t+9QHh7tuQuagRQlQHELG2YJMbi+iUa0=;
 b=s5Bmw2ck66HsrtANNtqlMY5SrudXZzN41LdqCMAvNv4JWTDQXhpPBLORrBQEgMWRhy5hG/ozRm7eZLJYf77M62gFjC9dncGAX8Y0uddg4la3OTFNP2r79Adttcjb0eVQAqeT5VH59VABuYw05pAMkTvqNoAsud/842ZxHYAXxuzV5U6WfV53ad1FFsxL8NkCH3ocdCFvA+jmoXpcwxVpwA5pDMNnwCIZ4SHPZQ8RY4HvLyg9o5FyuBvOaoquzyiX3hjHg3NU8w34BlafRXmOnMfNQy26HaGUi3FNFN62jfzDaFynaGgZSUL7AJzLwEVlUb7HHTZC18/umlEF/+wY6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=persistiqalpha1.pro; dmarc=pass action=none
 header.from=persistiqalpha1.pro; dkim=pass header.d=persistiqalpha1.pro;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=PersistIQAlpha1.pro;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcdvUZFhqn0t+9QHh7tuQuagRQlQHELG2YJMbi+iUa0=;
 b=m+y0oZCPXneNFsZ6C3LDvNHjIfxrfoenryDy6yZccNNMdcYHNvmNTNyUN2zuLdBm4H3iYn9PuH7cAG58bSZh6FP4wWEDorXYF0COpaDSTAbnvAoLzcJIMetM31N/Xz6x00LmSZexEu4B+SJDE053PD0XHXaVAx9V59a9b8NsYBgewZDVd/fGlRnIjIFE5yRzLy/onRnHtqDUZJ7IDltUmGTNj7DbqP1jZlP6gCm3k0CXISqN65vFCv4MXJjpD5tdlbn3mrFmlIOpxPntYbpbpAMeJcbtxUAfqhySp15OgU/seb1II9Nfy6aVJu0yud1CcxuULHrl4O3ib5FVxHUGOA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=persistiqalpha1.pro;
Received: from MA5PR01MB12114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1bc::12) by MA5PR01MB12677.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1e7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.11; Mon, 12 Oct
 2026 11:42:43 +0000
Received: from MA5PR01MB12114.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5e2f:fac0:972d:8c93]) by MA5PR01MB12114.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5e2f:fac0:972d:8c93%5]) with mapi id 15.21.0522.009; Mon, 12 Oct 2026
 11:42:43 +0000
Message-ID: <01a12fec-034f-70cc-9fc7-9ac4a0c0565c@persistiqalpha1.pro>
In-Reply-To: <01a12850-490a-78bd-bbac-a07716cf46f8@persistiqalpha1.pro>
References: <01a12850-490a-78bd-bbac-a07716cf46f8@persistiqalpha1.pro>
From: Christine Bennett <christinebennett@persistiqalpha1.pro>
To: mptcp@lists.linux.dev
Subject: Re: about network protocols clients
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 11:42:38 +0000
Content-Type: text/plain; charset=utf-8
X-ClientProxiedBy: BN9PR03CA0721.namprd03.prod.outlook.com
 (2603:10b6:408:110::6) To MA5PR01MB12114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1bc::12)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA5PR01MB12114:EE_|MA5PR01MB12677:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b6794e6-2f49-4439-704f-08df2855ed48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|18002099003|22082099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	OHk/7Tkr0k02XUo4GRE9fLxNwUn35TSehBGM8dkZ/reRCU5KLMApfljPE3HPHpXryDTE4witMXVd6XpltNXM7+G20PdUSytFqIqirpEf2AOyrRDWaGHWPorOn6IGot+s5++DLLOEJbwlVHQXZqKBC8Eeb/jviT7bv4mfg0ESE5Ar2iXj+rG+RONlQyQDuDp4Nl30Iww0qwvm1Gq8jAWU5DhdyECjtbdNRE8IPcAQD0W/5EC9xv1/Ka4MlAHaNUF4I7lFDw1e40s9D0ZiyyUF6TCeiGbY4+BB+XgY6lG0mgVLhH//ZcFm3xEqR8TO/bTKqIb9peUxNqmv/Lkv2Jk6N/n4jaojrpNWkSKpKtg7D6/mMcPGdTuiqxaXjrZnIPNZDBUag7fT2f8s3nVjF0hHeNKnSX6om1H41uB6N5NcLui0Dh4byfS2zG4WoC8pxVZL6zdn+w2iSB9+6J1XcGhlfxnd/CD9v+CqHk7E1YSHvYEQEjqpngr5mzyvImNdJ8S6aDfR1yboCWb2Kbhkephm9aI97AknGz9C8wvD/3JAhAdqD0KPgTGajRFc5sO2Xju9rfOh2L8Jq+deyXqUiHHu1lUzvVw5l8Dfu8jsOaGFQfZNTffTUXBxtCWsiitflYmThT+KfNxXI9W1BQjbQm7F8MZctalG0rW+LtvzGS3XF3Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA5PR01MB12114.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(18002099003)(22082099003)(3023799007)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTdRdDEva25aLzZESitoTU0zUWRSZDNuS0RYTGZJb1dRVGhHMmZnUW45a3A4?=
 =?utf-8?B?R2NJU0x6Zk5GRi93eTZjaDRmOHVxaXFoeHo5R2Y3SElDcEpGVkt0N2NmODN1?=
 =?utf-8?B?VjFsajl4Z2t4Y21vTmVPZFB1STFZNVBHWk40eUtFcXZVVCtrdEFuMG9ZZm02?=
 =?utf-8?B?Z0N0L1BpcU1zYTJqdEVJa25Xd3R4VGNPQXRtUVhhUGFva0xoUXFOamh0WFBq?=
 =?utf-8?B?SnkzNmhjOFhjaXZKMTRLYnNZT2grS0ZmSjRkQXdBNzlFdXljelBpaUFoTk40?=
 =?utf-8?B?NXZ6cVczZHVRaUVsUi85bmVZUGwwb3R5THNaQVpVS0pRRFB0UDFQU3dCU1Zw?=
 =?utf-8?B?bC9lUU10Wk9MWmFvYko1WU9CREo0ZVdtcUF0RTdOcDJ5UWJja0FxL1lacHFK?=
 =?utf-8?B?SFIxUmZoOTBVYTduSVZhM24rTUl6bmd4dk1uZkF5alBMQVQvNVdWa2ZNdW9R?=
 =?utf-8?B?ZFUwQ0dDdGh2Y0RhVVdUMXF0TUVmTnQ0Yk16d1I5R05aWk45SDJyRy9SRjYz?=
 =?utf-8?B?YmRFTDZYclFJMWduQjZ4OVY0V3I5TVdyTDdsaUgzSmxZbkhmL3VUazcxSllG?=
 =?utf-8?B?OERKazd6bTJoVkZ0M0hGKzFrSjJIZFZtUkxnMmJCbWYvdnB5bVdSeDlqNjJt?=
 =?utf-8?B?WEpsb1ppS0hVUjlZSEFIZEhtQlYrTERqMEk2VUN1UjJ3NHg1RGQ2VHVYWVU0?=
 =?utf-8?B?NU11TjVGOENaN081WitUMW1tYi9NMTVEMVlEdXFwNzJWZTZTQjg5V1cyL1Bo?=
 =?utf-8?B?N1JBbGNYTDZ3ZHdXbDU3d0JrTjl2V21WVWxhcEN2em5mbXZ4NXlxZUhBU3VD?=
 =?utf-8?B?ZnNjbVpDZTFzejlaNmVFUjRhV1JMeHlhdTAvaGt3VmhyQzJqRDU3REQrbkFq?=
 =?utf-8?B?QjZjY2RETVNqNmZJUXZlK0NGd0xqNGZFeDdPSWJRdG5vS05YL1JKSzd0VDE3?=
 =?utf-8?B?QWgvaDMxT3BocEtBWm0wNGp2aEMwMHUrQmtRZDBkTmhUZndOMnFjREZETldy?=
 =?utf-8?B?SlFsa3NmbjM2Y0U2blh5Rlhsemw2VG5EUjZYeHNyeDhFaTRoU1dEVlRSTmVG?=
 =?utf-8?B?clhGRDFRaHlkaUY2VVZLTHNMNGl1d0UydmZSMTUybmY1T2FWaHF1UE5TLy9l?=
 =?utf-8?B?Rkd5R2dlL1NEeXllaEZTVEJtdTB1TXRuRGVrcGViZk5uZXJjRXJ0bU5oMjBB?=
 =?utf-8?B?bFEydjZabkRqQ0hSb1NoRGxTQXI2OXBhbVV4a1pvYkVYTVNYTlFmRGFhNEVM?=
 =?utf-8?B?VHM5VXRlci9QVUZrU1puazFJdnh4VXEzNUlqd2F0U295a1VrMXBGM3dBSGtt?=
 =?utf-8?B?d3FST0VTNXVTcTNkbXQyeXkya0xCRFdScEFGZURhZkhoNjdRb3dXNjhjaDRE?=
 =?utf-8?B?YUdJTTFRVGp0YkhsanJpV1BUdlV5Qk1BYWNMWEE0K0dUN3o5c245UXRuR3hl?=
 =?utf-8?B?WDBGUlM3TGF2NlJJSkF6UjQySzczbkFSY0NBcGxmNkE0Y0ZRak5vVXRwc29K?=
 =?utf-8?B?ck5vSG10ejJWenZSZzhRekJWM0gycDlTNDBNaldxcmpVMFRMc016aVVYSW1B?=
 =?utf-8?B?NERPM2ovMHUxT3Nid0ZvUnZaNThhemkxZXNGU3hGK3FOeVFTblp0QVVCLytN?=
 =?utf-8?B?VzEwOENsSnUraHFDZk95WW9IelBjbG9TWXFTMkNyY2NZaWxHdmR1dHNGeFZs?=
 =?utf-8?B?NDk1ZFFtSzl4UTl2UU8vQXdXYWxTMHJNTDdPalR5MGZpVDRaOE5VVGpGUUZ2?=
 =?utf-8?B?aUNVSnlLWGI5UHpzYkovdjd3OStmY2ZEa1dPYWhieHdoVGdCam9XS3ROVCtz?=
 =?utf-8?B?YStkZVBVZWlLRDYrdHlqRGVva3MyWXpaS1JQamhUdWdoWnJCTEJReklwZnBC?=
 =?utf-8?B?eXk1eU93eGo0SFM4WmtMaEtEUHpHdmVxaktxZDh6TVBYaGNBQW42TExjZkYw?=
 =?utf-8?B?OWVpWGl2MHJ0bmE1ZWlGMnUyUy94T1Mza2x6dnVWek83SnVaN2RjVm5vaitP?=
 =?utf-8?B?SlJKVXNhaWZFc2d3WjJhUFUxc09xdmJzNDdsUFdtRGlZbGJENW1DbzY2TnFU?=
 =?utf-8?B?T3NVanZJS1NPZi9JZ2lSMnVTTkVHR1V1VGMyT3pHTlMvR2pmUG5OTmIyNkNu?=
 =?utf-8?B?VXNCK3BERU4xTEdoZ293S1RFazJXMmZwMW90aFlmMVhzK1hoTHlBbkROaFc2?=
 =?utf-8?B?N0h6V2pOcEovTnkvbm4zZ2NIZSs4Y24vdnNJelN3WUlBNkNXMFBtOVF6dDh3?=
 =?utf-8?B?R05kVXRFaUphdnl1dmlnWHh5SUtrTUlrd05zRWZxU0dLVGZha0xkT3ZnRVE3?=
 =?utf-8?B?NXNubkd6OHhlVUU3SUh0ckZlYVRKYkJBUUJ0aXQzbWY1a2orU1lDcXE1TlRV?=
 =?utf-8?Q?duOxNZ+PCsJNFybs3uEmC0bEU8XicqOL1yz4m?=
X-OriginatorOrg: PersistIQAlpha1.pro
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b6794e6-2f49-4439-704f-08df2855ed48
X-MS-Exchange-CrossTenant-AuthSource: MA5PR01MB12114.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 11:42:43.1666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 207f505b-349f-4fb5-a048-321d02f8ab9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3PnKtZ0InUUq7B9JwoiZszeHs4z5CHu17oCUrHlEoRDFRo0XemppAnqoYF5HA9KZ6WJFLRZtqMM4WF7jwrNXhjR2e0YyT2Wvzjwh6/433oOVqg8dcPkeKgeZmB9NDLd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA5PR01MB12677

Hi,

I know you're busy, so making it quick. PersistIQ could help MPTCP enhance =
its client bookings consistently.

Mind a quick call in the next few days to see if this can work?

Thanks!
-Christine
PersistIQ

P.S: let me know if irrelevant.

On Sun, October 11, 2026 12:15 AM, Christine Bennett <christinebennett@pers=
istiqalpha1.pro>
[christinebennett@persistiqalpha1.pro]> wrote:

> Hi
>=20
> I previously mentioned that I=E2=80=99ve been helping software projects f=
ind clients by creating personalized email sequences, finding targeted pros=
pects, and booking them meetings with warm leads.
>=20
> Would that be interesting to you?
>=20
> Best,
> -Christine
> PersistIQ
>=20
> P.S: let me know if irrelevant.
> On Thu, October 1, 2026 12:07 AM, Christine Bennett <christinebennett@per=
sistiqalpha1.pro>
> [christinebennett@persistiqalpha1.pro]> wrote:
>=20
> > Hey,
> >=20
> > Came across MPTCP, and wanted to check if you are looking to bring in m=
ore clients for network protocols?
> >=20
> > If yes, worth a quick chat to see how we can help?
> >=20
> > -Christine
> >=20
> > Thanks,
> > -Christine
> > PersistIQ
> >=20
> > P.S: let me know if irrelevant.
> >
