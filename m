Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38138ED5
	for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 12:52:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEX7pYIkYU1mgbXsOAyntbizB7vChOKTW7n1cbDIgHjCMRJkHzsaXbDk44zMDf+kc67cgW37X0MnxUCAUZ964L6WopuubM9as6cAvAgDN57i3CTk9fR4E3zz7u4snkYZGzQs7YQadhq6O6DAzUS+lmpe0PO0caavidf3JjXfCRevSp5rbgtQvlLTx+HOpWcG2zrokYaorgRqRNFETV3tix7hBiBq3Xd3lwETa/7JikVKKrh+kbMiLd75vZ6/jvmNmlQxPB36SibJBoyCq3Y330PAXtO2Hxn+RggS8yVkMEVCuQVQ4HhFarerHtYLkHC/ezIgjKiJfiuQZASbuAjKUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkaV9Qk/LYvkDWXhYm7LERFHYR9a+tSQknvB+FzYtvY=;
 b=d6wMXp9QyHMqI+VgqeuwX9l1Icx3D4IRgtE87IIlmaf06pnSuZoyIdgqgd+6NXA2brCwwCymRMyK6fjr1FyMMUNWnlxfly8jDjWnpu0MoziY2fvAPMD6bSmSqCqdEMgUyN/pBiMq8AtmIIrs++0sQvJVnbiW2mRRRhK+AnZC/27ctmza6EhkgMqcfeTyQFqyjcz1pDx0MiCM1CWNi1dANYVexkw3Yq3U+jdYFPVpBn2mRrCZG+xSfs7VhKWH3wINrFFE0934nxasjBcnP6DrqvqKB1pM1f94filVc5my0cviM6aYFA2eP7VQpFnkvnwpMrBsdLccUSRBcJUs7YQcig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkaV9Qk/LYvkDWXhYm7LERFHYR9a+tSQknvB+FzYtvY=;
 b=TuBNd6a26jNW6mcxeFxB9XH/1qOwk/NZRZEf6PI7+HWMz6AZ01+v8wlgQ3fInTL/ZSLLOn270DhZuvi6sWjQSYfYS7jVGe/qHIjKJdhHdbTzPgxjJQ+5ertFaAUdMYDFfEUJx6s3JkbMnJHk+KzFfaB4nCclMIm7YFpcsN7DndSMauX/c9rJv3fXSQbPbDg1k9naPT9J2eO/9jaxs0jbOmB3cHKeu+P9Hq7XvXo5tvArffEe8vzpcqKnrys+/hDUieWulvwG1Ilh0y/jwtjJ4T8OYOKEERqImMoqDUNPR2fBrj01TDbipV47fPi9TrigJj1pasJj6193ahTsFTIyMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 12:52:10 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::247c:645d:3f4e:d907]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::247c:645d:3f4e:d907%6]) with mapi id 15.20.5654.025; Wed, 28 Sep 2022
 12:52:10 +0000
Date: Wed, 28 Sep 2022 20:52:51 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 1/4] mptcp: update __mptcp_push_pending
Message-ID: <20220928125251.GA4575@bogon>
References: <cover.1664358100.git.geliang.tang@suse.com>
 <0b90e9ec304d919c833863e056f8e6c7b62d0dc2.1664358100.git.geliang.tang@suse.com>
 <5b186defb2217a8de5ef73c4a8f0809dac920d07.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b186defb2217a8de5ef73c4a8f0809dac920d07.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|DBBPR04MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c8acb3-0eab-49b4-f20a-08daa1504218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6uHrW8yYj5QHCHNVLnou7u77A4PLqy/73aD28pIwtDTImSG2Fg2CxDCEnvzTUTazt8e70ehHN0lRzbKBusbOU+pV835Syv/SvwY968mBBm4rvvBPzSLr2/QDYy92+muJFmCh1DH3FxZFVKiZBGFuO4BjYRb677r4kvU/K7CptaH14DG3JespL62Bg3wP2iGG2AzydzHGegWMLwfor/br+vP71sXkrIOpEYjiAsC1ymWZSTcHT4l9QJoupV/EnWd8JqFI0EKFerwJzomQ6EH7QfqRxOPqztQfjE5QGOy6rUEub9NieoGCRlXHpjIAdKu8MihzbHE6+iwFgyffnwTU75CJHOym5oJTC1iM4HSfBDlMk8D3jzxrdN510x4yTDm/jMpESUukDmK2gK4ZSYoPucDmcl3NOugfh6fU4+NLiIH0lWKM/wQVtAGDX0qAgPlx+okSsa6Nm+1a8Tc9M5h+ItLwcZSG/53TJSjPPilgxP7icw7VIois23Eh4bRKGs285tagwH2+QZBvQfrVS69GXbLp2KXMxaO48w4FJqEB7U1Y5nB2QxCdYobBye10RBjWX/RVe/zWVHUqHbGZB9RbJh76tB6P5ud8IZWi298VomgPEBtu9Zn2Gh4BsbPnCLE+jsLqo/v4uDpFIYq7hOoOfsSrvJyJlwvom6veLC5ovV6MNcg9nPhT/iNMjUaDDdei3oIiF5wLXBJyY/Nc+4tpbNBX1XxT3jNMwffgzacTBWoJ7aAqe0e/aBXBzAAcWmrb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199015)(2906002)(44832011)(9686003)(4744005)(6512007)(26005)(6506007)(5660300002)(6916009)(6486002)(83380400001)(8936002)(478600001)(316002)(41300700001)(186003)(38100700002)(1076003)(6666004)(4326008)(8676002)(33716001)(86362001)(66476007)(66946007)(66556008)(33656002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clZ2cVNuMTlEQmxnaWc1dEZiaU50bG5Cd2ZFaEpaNC8rajlMc1JjS3VmWWcv?=
 =?utf-8?B?bW9CT1RwTGo4RGhyRmp4NzdRcFQ4ODRLem9aSk5MTWhCWXU1OTIzekphZFlE?=
 =?utf-8?B?cTl2djRVU1BUZGREVElaZEx5SXJwTEdJUmJxZVF6MTBNWDNWNG5mUzVVbWFW?=
 =?utf-8?B?cDBlTkx4cTJsYldsaXdqTlJVUmJ6SXpJSXc0Uk4rVC84WmM3eWN3MWZORXF4?=
 =?utf-8?B?UVRjRVU2aVI3M3Q3dnJldTNhUmVIL0R0TmxrTm5lclhWN0IyeEpoMGE0UUFC?=
 =?utf-8?B?eTZhOWhjRmhNdjdCMmswVlI2bUNheDdZTUhRaVlxK094OXZQeXlrL21PUEw1?=
 =?utf-8?B?U1lHNHZ3OHdLUnBzK3I2MmIzcnFGU1oySVJrRmdqWC9zc09BdkdldDZ3SWxX?=
 =?utf-8?B?S2dydWpCREZLTTdya2psa3VrM1grYmd0K1FVQTh1c1QvY0hUTWMvWjJ6OTl6?=
 =?utf-8?B?aTVjQ1ZYWFo0ajk4V2xHS1Z6QzhOTW5QRnZ4cXE3R0EwWXhveXJ4aVhQQTNa?=
 =?utf-8?B?eWN4VmdFSUk2M0dCQ2lnR0ZtaEI0TCt4VzUyYW4zUjNaRTRwcGc1WUZ6b29v?=
 =?utf-8?B?Rld0MEFMNjFlVm5GbEJzV2dCMHAvUkh1Tmh6MW9vK2hSRkhiUERxckZ3eWs2?=
 =?utf-8?B?NXpianUvZVBlQit5SFAxaDVuM09KczZDRVROTzN5TGFNNDJyOUR6enExUXBP?=
 =?utf-8?B?ZkJpNTZQODJzbkpBQUlVQ2xQMy8xSlJJTmxTY2FHMmFKSFZhQmVSWEwvMmZP?=
 =?utf-8?B?ZUdRL3RXVUx2QXZJZUh3bGNOUXU0M3JFZE4wOGNldU9pQ0phdEpvZFdneHp5?=
 =?utf-8?B?T1ArZS9lSWVid1VYVklsT2tRWSs2bUdDclJ3M0xLL0lDaDVNNGFEeW1zSi83?=
 =?utf-8?B?Q3JFRGc1RlludHp6T2t5T2wvblZqY2hqVnpsY0Nqamhza2RWRWhVemVraUto?=
 =?utf-8?B?TS92Z0docnJ6U3ord3NWcHRBLzYrQmVpWXN2YVZRZmRMRE0xYmNPMWg3RUdt?=
 =?utf-8?B?MmFqY3pZcExnUUJGU0w3K0ZsQ2s4SUNBS3RHZkpUOW5EZnlRelhBMzBzVFJi?=
 =?utf-8?B?bkN6VVlMU2dKbU0wLytwK1JUcS9tYmt4Q1FCcEdFbkthZ2JqRmxjRllaNnFk?=
 =?utf-8?B?OUxmMUNsa01YN1RpcnFJdTBUZ2xhWUx2UkI2djh4SWE5WllZZk9RN05qSm1F?=
 =?utf-8?B?eTBKUGZHRmpRV2VWc01palpUSi9WcUxFMGdUTGRMb0taY25Wd002THk0cURP?=
 =?utf-8?B?Tm5qUkVDWHY5OW9WSVVVWmtFTUw1V2dVd3JDcmxxYTZTekdCaTZvbEJ3WVVR?=
 =?utf-8?B?dUxoeEIwbXhkb1dFY05saUJ4Q1d5clFSWnQ0OWNqaFFXZ2l0RThiVHlYQjYw?=
 =?utf-8?B?MG5Wb0V3S2hZVE1XTGFrek5HR0hObjV5d3BpeE9nK2drdEtJbkhqNzVLNG5x?=
 =?utf-8?B?eVFneldESFRpVTFmeWxQTVk0d2F6WXhoS25nVENIdFl2UlpzeWpIRkN3RnRv?=
 =?utf-8?B?U2YvMmszekZ6UDNoOFBoTHR1dUV2aDJVQWxkOGxROGlDQ2xaVDlsLzYzYXNr?=
 =?utf-8?B?Q2hBL0VnbkJpalEyT3BEblRFSmNVWWVoMk5zaVZDN2dORWV4a2ZLcGxLUDMx?=
 =?utf-8?B?Q0NCUHgrMkpoWFhFRUx3N2wrcUZRNm1YQTUzTHVXaFJFamlPbndrQWF6MVRl?=
 =?utf-8?B?MVFUTUMzUURkRTE0REdZNW0wc2hnL2NqNUs1dE5pSk1teDEvdFY4ZmwrSlVj?=
 =?utf-8?B?ZCtrRlQvS01hZU8rQ2tIY1kvSmU1Y3lPb2lKbnIzVTBlNkpVS2ZuY2x6NG03?=
 =?utf-8?B?Q21kdVVtMi8yNFNaWHp5emt1bExrUVVvbmh3VmEzSk9rRXhLM2ZzWjZwa0ZU?=
 =?utf-8?B?cDBWckdmVWIwOHUxYUZBSFlxelFPNXZ5MHNobE5VbklBOHlucnhHNGMzbTho?=
 =?utf-8?B?eVZ6TzUxNEJ2TEU3d3Z2VFR6Ti9wNUxzRkxWZ3QvdVgzaFRCWGloLzFpbkxD?=
 =?utf-8?B?L1BSRkpxdzRKc1dwc0lIQ0JTaEt1T3BoWDdrUnhhUEx0aHNTSkowbmpCV1Fu?=
 =?utf-8?B?Z3kzVmlQb3hGVERVQUFKbjFqaFdXQWVGV0NaT3pZY2xYT0R1cEtWWWM1OXg3?=
 =?utf-8?B?cTdzRDBRcllSUGt2S0VjdHJMWExnSkIrY1FnTkdJNWo3eWdWQTNZQXduSXp6?=
 =?utf-8?B?VVE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c8acb3-0eab-49b4-f20a-08daa1504218
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 12:52:10.6608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dP/+BxRkXMIP/SdBq3stwD73vqKMKSIqGVGbMCGfctQAPRuCMCXH0snPJU+gie4dpt5pPaG3ekCwpzrmvW7nxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7737

On Wed, Sep 28, 2022 at 01:02:07PM +0200, Paolo Abeni wrote:
> On Wed, 2022-09-28 at 17:48 +0800, Geliang Tang wrote:
> > To support redundant package schedulers more easily, this patch moves the
> > packet scheduler out of the dfrags loop in __mptcp_push_pending(), invoke
> > mptcp_sched_get_send() only once. 
> 
> I fear the above will make cause hitting HoL blocking [more]
> frequently/easily. I'm not sure if the simult_flows.sh self test will
> catch that, but you should see a measurably worse running time for such
> test - in non debug build, as the average of multiple runs.

Yes, simult_flows.sh self test failed in my tests. I guess this problem
also exists in "BPF redundant scheduler" v12, because it also uses the
same logic in __mptcp_push_pending(), move the packet scheduler out of
the dfrags loop.

> 
> I'm sorry, I can't see a feasible way out here :(
> 
> /P
> 
