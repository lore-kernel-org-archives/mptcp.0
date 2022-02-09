Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67342F28
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 13:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1644415163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=teLI/UyrKpK8hb0PswRqTMC0Nxy06u7WBxFiLf2S6cA=;
	b=UC09EGzQZdLUpiLzINOTJBALOuVFvZjf6Q7+ZkJpb52tJH6NctqbNf5XCFLuxgVahrNHm0
	KzzJ9HpNW9JuNEZxjivm2IjEpG5Qj9iUo3QPerFecYage3rxlD4edoqFPno9MeXRRllO84
	35ILLPZyH6/gfCsJ0a9nye3NIP/5G2s=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2058.outbound.protection.outlook.com [104.47.14.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-14-pYr8OVKAP-OTz-I4_nSKfA-1; Wed, 09 Feb 2022 14:59:22 +0100
X-MC-Unique: pYr8OVKAP-OTz-I4_nSKfA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FknozQJ0KTL3RwJfuh7gjVfgLKlFuk9/bvOVHIeyft0+uh/mbEY8+Xvo2ew41mKLSTwqHeAmUeC8ZQUEkoZ0xbAJygsDSdEBpsTXQRNV0gsl1E5hG4OElJU0sxIZS7JwNpSusNOv0A1uZkk6a4L85YKzbCxEuEkYeVsA8HTuYPxRhwWbSqKaocYiIAX3aVUVlz7iCjFHdY5p/3evcVKEQPzJ2cytcHyTB4Of1Su6sEpwvDS4YY/i7sSyI5dy3USvcaQOVCo1nwkAJiTSMESdTjaZbNqJ+FqqTaEd0wbj4sAHIGI2zegZQW5xOUqyaMftvAdOtnVEiYwWgtG6keGn8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teLI/UyrKpK8hb0PswRqTMC0Nxy06u7WBxFiLf2S6cA=;
 b=SpLEfvcisTuAHz3Hl/oK887x/law5tQg7smsN2OKVAv1Yc8HL1MYx3QjzMcDO5T7eR8uYy9HVRS6y9EYoNwIsZD0p3cb1CVxogBi9fLJdKsGxdS73EBg7euMLqXJVGBl79JKK/16iASPiNIqQZhedYKNWmHnlVRjU9MrSnOrX8agU8Y+3tZYX9o89gJ+r+6pcyrZndhSekoBrjg06BMpcnW5LQnzodRApEJml4z9VT2v6vQPaG4N+ivLvidM+K4R3+XbiPjAH3zWnFBfCEZmN5gcEBu+XNo6wxCsoROSLFAsdXabojc6fMnufgYrIr0EUy4nIWLpFLkrF/9QO8N25w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by GV1PR04MB9087.eurprd04.prod.outlook.com (2603:10a6:150:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Wed, 9 Feb
 2022 13:59:20 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::60de:f804:3830:f7c5%4]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 13:59:20 +0000
Date: Wed, 9 Feb 2022 21:59:48 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v5 5/5] selftests: mptcp: add mp_fail testcases
Message-ID: <20220209135948.GA10081@bogon>
References: <cover.1644402973.git.geliang.tang@suse.com>
 <c1dd2b5c0105f42b9fb12447011d3830c057ac57.1644402973.git.geliang.tang@suse.com>
 <fd43654f-12eb-9830-0360-acb42c9d5a55@tessares.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd43654f-12eb-9830-0360-acb42c9d5a55@tessares.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: HK2PR02CA0175.apcprd02.prod.outlook.com
 (2603:1096:201:21::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f54220eb-5c43-4f1a-64c3-08d9ebd45e64
X-MS-TrafficTypeDiagnostic: GV1PR04MB9087:EE_
X-Microsoft-Antispam-PRVS:
	<GV1PR04MB9087F8DD3C80F9C3851BD580F82E9@GV1PR04MB9087.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CZMzN6mqufVRZELwDbqErwFqXVjod/45B3BZYPILeeWLRqvEdwNtktAHC091tk3rpQMvXlEG0W4tjzx5U/luUsntuTV3l51KjBzGgNo7HvOq/s+6GDI0JtTBgmH4cKQ580LobV9iot2d+KhbaxHPjUFp9ypURVJ7gsERYI9C6llcyvcCYebUfzkh2nc/6UyLxYSikmfL06HECfP5wYnMrPeIeWp+rOLm8aGvtnbwsZBwpuQMdPOh6Pu2h8rhk6IfXWOvsSzFyfKXsSILCjO3UEk0pazswI2Je67idIa22fiKxY45FXzd+mDisesQyyqMmYrQMFyIgynx4Rjij+xT5z4P1+jjdsbB8uV4IC33BpFfD51C4czo8SpIigqmR6rZwYsRCiuYFi/aDbkT/J7GTPNkxniv2ygqLKvff7CQg+L+GPMXnmxcVlYnPn+HucSxPw0mqqtlTnRtImr+9TuV2m5gTcP+EdSZFc3RQyLNvoZ8xdI+obtyfBNncNwkmr5bIUUs58FLwKJUqZ5eDoikmYfR9aU9wkacN1hP3aS/qBFUrHZf79HyeorvV+QYmHVArUGjTZ02fO3Z5V3OMN4mBD8o290G5MbskjDX7+xEipow3CuJHfvU9vdCtUZ5BQR88cfAPzhtI29GbOVgXWYfdC9D0H2A5tF6+FiCpBd91gb118w1HIvEJxMarP1untFRhpNZbBDSVNurgJE/L1se9IL/u02Ue7hLsGBDkm4vA6DS6aSfBDTLX8+v/3VpvquJaULfzDkv0ilokYpoehp6jcb35W2ymBq4juXNQwY5JG4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6486002)(8676002)(508600001)(6512007)(5660300002)(53546011)(44832011)(86362001)(83380400001)(186003)(8936002)(15974865002)(33656002)(26005)(9686003)(6506007)(2906002)(1076003)(6666004)(66556008)(66946007)(6916009)(19627235002)(4326008)(66476007)(316002)(38100700002)(33716001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vJI5UXokZkBxuAWO07nHlZ5Ut002VYryxfqdWWil+TLCOe8z+nKGZHLBotOs?=
 =?us-ascii?Q?NRUQOTZQGXmv8ypBdFjsUeO/eg2GLoi6/W/0KWylQXsGC6RuEllSCr0vRVZY?=
 =?us-ascii?Q?qNfkpngsffwyxUt372Qnpa/X0HEeAfRh9PNe3gIZXVwDLaJYIXfc9jh8Qo2L?=
 =?us-ascii?Q?WEcZ8lN4taM4r8KxZ+7rwmVlYjvvwAaPokKabkAM4ilSOO37aGAurEgAeIuX?=
 =?us-ascii?Q?ntZUXb/XTLi3MveXquNWPz+4Vwkya7N+fCAYBe/ZoT+83rMKJygWdJda8xbS?=
 =?us-ascii?Q?+ymflJ6EBZaeIx9Zb+UFizJp4zd7jwUFFvTlEXOCmz9/2TYyUBlD4E1V8bZr?=
 =?us-ascii?Q?ShojKt9EOuIQEa3azFYcd7PJtjWq1U1TTNN2GBEupBETHV+SoE1+K5FpGSpq?=
 =?us-ascii?Q?My410k+26OwrZabqfM59oLfYrT6VQO9lXeSayrWuudC9xFmaLy5lHxv1ZTqu?=
 =?us-ascii?Q?uctuxyJ5oVuCDyp7DCJ65K7vnZvPegTMneBdN/MqiBa1jK3rTGVKgRv1BfdS?=
 =?us-ascii?Q?eBBTumZ8VAw2bM9KY8ojcBSa/V6zlo+3UgX39EJ3Tkf2kb18VeooRgoMuuLI?=
 =?us-ascii?Q?fgOXAELDAx1kVg59iLw+rthEZZlNnu7irIxHCE9FVFxgUIPnPRlMgWJd2iF+?=
 =?us-ascii?Q?y5WZMID+ttlKk81A8TTi4Cjtf+Pon9ECHZJgdOQTKiwDfsnF3yNUiDcT+Afm?=
 =?us-ascii?Q?Y15Ame92QI1bbU0abM2IaUCAqUNbxGfYosdREd/wfz+xspUusuCsMqi2dbHE?=
 =?us-ascii?Q?sL1MCJuIxjGW25bnYKWn8vCqD0TELW99V6OKH0ptObPHC9AOKMxOUxB8qSzP?=
 =?us-ascii?Q?VT1d2z5ooEXt9HxrVUkFtRgdQEro+AsLnw3Lbj7uLQOPLr/8p/g5EY4n9+Xy?=
 =?us-ascii?Q?EnsJQRs4a91LfU/XD277aWAjYOyMW2qZm1RvxOZMss5IJWBUQTP7Y9OqPHhE?=
 =?us-ascii?Q?BwOFkpIjlQZAN+/EJK79QqfkBA9p1dRlNBGF4wQzjsBWW7qgQWnY8k+yaLD7?=
 =?us-ascii?Q?+dSWc9S2TrxH9d166PseWk4e8/w3vgshqgXKiM9rMU5rLbouGzJxz5Jiuy1J?=
 =?us-ascii?Q?unuP+CMKQis6o2S/kZbVr7hmmN2VckgI6xFPbygL13NvLbiFmmjbY9UY0I7V?=
 =?us-ascii?Q?xqH7ziJQ/VJvpLI5I5tbzz8Th63tRe4Z4Exbb0G0nVwyw5X2S3GnHD0QWBZA?=
 =?us-ascii?Q?8cmQPqHoPVYXqiMvs8q57PAMmb1SHsaOZkTJsZeSWe5FE39sdFMG5k7FvsYL?=
 =?us-ascii?Q?hoGtfWlziALzDygFICA9e4p9HstPaY9Egw3BkLtwR7j5NafkDwf8GkZHa+i9?=
 =?us-ascii?Q?hMBik8tTamnfq118I9azPLBxagTNSUA0Uu1MgCBJ0xLqZDnVPzNfr4x112nR?=
 =?us-ascii?Q?uyEAsGwbIqaeNEuRIUhpBSzzFl/sU3DVcJue7NKTNoXhoMbJzmYfURwc21w/?=
 =?us-ascii?Q?v0NKjgQnrpARuWU/ROUBDcWS2heXtRrGXcl6OlUf1etYi4jEPHWsrj8jM23f?=
 =?us-ascii?Q?x7ZFDwzRunaK+KUYbEenpRxFISXeFqVD6wDmlLDwGaf0v9/hfR/IcrcUfDSy?=
 =?us-ascii?Q?h81iEgOYrvE7QNJO0Ts1In47qLvjHF8Rg0vGF3HFs+BmSCMmTkh9M8mkPBJ5?=
 =?us-ascii?Q?cyqUaRhXRE4tnRnphozuJ7s=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54220eb-5c43-4f1a-64c3-08d9ebd45e64
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 13:59:20.1836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZmeUFpISDD88zK5uKgwDpGHBSwYUIhNR0RWk+gXu9dgcBxMbawyojBiavXD5cgJ0h0nLdAm1an8M6ICzUOMTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9087

Hi Matt,

On Wed, Feb 09, 2022 at 01:36:33PM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 09/02/2022 11:43, Geliang Tang wrote:
> > Added the test cases for MP_FAIL, the multiple subflows test for the MP_RST
> > case and the single subflow one for the infinite mapping case.
> 
> The tests are passing on the public CI, that's good!
> 
> But the output is less good:
> 
> # Created /tmp/tmp.crkOA4p7hr (size 1024 KB) containing data sent by client
> # Created /tmp/tmp.jFbZEAnYZa (size 1024 KB) containing data sent by server
> # file received by server has inverted byte at 195585
> # 100 MP_FAIL MP_RST: 1 corrupted pkts     syn[ ok ] - synack[ ok ] -
> ack[ ok ]
> #                                          sum[ ok ] - csum  [ ok ]
> #                                          ftx[ ok ] - failrx[ ok ]
> #                                          rtx[ ok ] - rstrx [ ok ]
> #                                          itx[ ok ] - infirx[ ok ]
> # Created /tmp/tmp.crkOA4p7hr (size 1024 KB) containing data sent by client
> # Created /tmp/tmp.jFbZEAnYZa (size 1024 KB) containing data sent by server
> # [ FAIL ] file received by client does not match (in, out):
> # -rw------- 1 root root 1048604 Feb  9 11:37 /tmp/tmp.jFbZEAnYZa
> # Trailing bytes are:
> # MPTCP_TEST_FILE_END_MARKER
> # -rw------- 1 root root 1048606 Feb  9 11:37 /tmp/tmp.ghV0iWPhu5
> # Trailing bytes are:
> # MPTCP_TEST_FILE_END_MARKER
> # file received by server has inverted byte at 169
> # 101 Infinite map: 5 corrupted pkts       syn[ ok ] - synack[ ok ] -
> ack[ ok ]
> #                                          sum[ ok ] - csum  [ ok ]
> #                                          ftx[ ok ] - failrx[ ok ]
> #                                          rtx[ ok ] - rstrx [ ok ]
> #                                          itx[ ok ] - infirx[ ok ]
> 
> Did you not do a modification earlier not to print "file received by
> client does not match" error while it is "normal" for the moment to have
> that in this case?

My modification works, we got the inverted byte on the server side. This
mismatch is on the client side. This failure rarely happens in my test.
I guess it maybe related the checksum bug reported by me, issue #255.

Thanks,
-Geliang

> 
> Even if it is temporarily, would it not be better to add a variable
> "corrupted_data", set to 0 in the 'init()' side but set to 1 for this
> test? When it happens, we expect to have a mismatch, we can print a
> message if it was (with a ref to a GitHub ticket?) and mark the test as
> failed if not. WDYT?
> 
> (also, because from a TCP point of view, the packet is still OK, we
> could also not drop the data but that's another discussion)
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> 

