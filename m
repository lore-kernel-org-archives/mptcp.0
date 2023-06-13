Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2084.outbound.protection.outlook.com [40.107.15.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B77522B
	for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 14:03:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RsnqqZ5rdb/LycFhRUO/8YEiOySkGIxT8B0x8GkZT5V7E/7Io46+TUZ9Y3VmZjmnU36PEcFC/c3tA/gjZJCx/KWlh35dRwj8zwzcS2RVxneoEpIzjtqbpgGcFLAEadVHYbDT2IYDAHQdadpaRLkYML2dCjoV9Ubum9bWJkCdXS87bCKhci1rGqEztmPaAHuXxl96wtPAAqa2NRmaXmdTA1Dt+BvoqOfEPmSySP/B/5JAt3QNmbCuI4GLyt5KSR6hojqmixNc1GUnY5dYPm1/ZDcoNSeWAQjZLFlPebZoHblo1lEH1dv+O5jMd2XBWfSb910MC7WKCUKHPDFrgL/lEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3UKCMlMrNla+tiTlO0TmwgsbuoQ79W9pjS+/ysHYVg=;
 b=I/VLXLfCYeVN9g0o/U9wfULu+v762KNZ7tw8NUyv0rnNXw4q9SE9jNvHtqSh/uIj5Zi2LoQbJI02yURpbIT8KWCfbFjW3c0zQ3viiJpBJ9dnXPTq6dPnsh2A8FpLQ2AaXj6Tsa8GB/9KGW5wB7S47ZB1jZA2195KM/Y6NHfCVzTE6c4mHAunCcaxrztrhSR9pbyAI+l1bAa5nBUgqXCPFwOlSRiE0VstFuWtczd6owPUP3xj3aS1M96nUKt78Pb11pDcc67f6K3bEJYl5JPWARetJQDG73u/ALuAjxmdUSVobT6n4VsHulk3gerGbh9QU8TUvscIa+BKEA1hSzxJQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3UKCMlMrNla+tiTlO0TmwgsbuoQ79W9pjS+/ysHYVg=;
 b=BbFWUxwkXSx2w1dy7MyyMEagjgYYQW6OXZGYuFIHJLXHL2eeYJS56kWQZqoUh5ceFsYtVTdtZSUvMU3/WjLV2YD+mnJuw2pkfrxnVYs4xViZmsRVsANI0Y02vdS6OB6fYTIY1G+SjErbWcySyRHvq+0Mc7hkY1C+DECFSvpQo4LaDvbtLBkAFedj9CmJ1fFAgPO/U4AttkiWoVk/IdQbadSYerXnYfJ6lHa9jtTrBV+9ep7BmWUptaHlkWIwEZ/dUSVSjlCNLZc7fApVNIf2P3XNwtWNAQMED0K3JvsAAY3YebX8y5E001bb0xqwQPG6n9Z6soOh18s9YIRKtfvw3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7889.eurprd04.prod.outlook.com (2603:10a6:20b:24c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 14:03:48 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 14:03:48 +0000
Date: Tue, 13 Jun 2023 22:03:38 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v8 13/17] selftests/bpf: Add bpf_burst
 scheduler
Message-ID: <20230613140338.GA22458@bogon>
References: <bf747921efceb7f066a75cb2dae2ab46071b8275.1686202841.git.geliang.tang@suse.com>
 <666004bda6ff9e3e6d65c6903c5b18f18f0e31ed.camel@redhat.com>
 <20230609133236.GA30403@localhost>
 <4d34b373094d8415d8d6cc29af013dc508a5bf81.camel@redhat.com>
 <20230610014514.GA2843@localhost>
 <5336efd2153d4667f9d0aea52b6d67ed2685ddbf.camel@redhat.com>
 <20230612132934.GA9248@localhost>
 <45ff221dfa3fce66e12bd76737c2dea8eeed7e00.camel@redhat.com>
 <20230613123235.GA16406@bogon>
 <b8e34248d35aa358e60966c95d22453dd1b89ba9.camel@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8e34248d35aa358e60966c95d22453dd1b89ba9.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYCPR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:405:1::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: e17c8117-d9f8-4ce8-f28c-08db6c17020e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Xdd0i0czutg9xz5ffAveWncoHGxWj0f4NmnCmttuJm1ioygfvwt7OvGRdbcprQrh69s21VfxVP5/rYOHiz5UabUriPnFic/B21UaQ7xJ0m1qGdYbDwL4Ox3NShAIruZatsLty891X6YKQg4VVAaImrP27W+2nzly2HJzsNf4JITMtydJqKRAksJKM6o+XSfAGlVdzivTqg8jxta/gXcYZ0LOqGMVeIlv0c5PqjEwX0GIjS6wi02m5V1mahwFMK/IOiFOiBTLlir07XsWmg6T4hIFt8NnmZrMlhutd3OUD7DN3GdadmLEszfJZMK+ZDpMaJJwXtbsIpbOtXrzV+I9ogafMgK5DyLIzIWXudkXvPJ4GNx5m2WHkfQ+WC7Xjx5SN0f7JU1aOhrjuqwsp2ThcK/g/B+cEX3GgBKE4i149r7VQpzeKJdBNcX+CU0yH8YfWA1FzUwJy3Wl9TXrNb+0PHxhgXTJS+9u3pqVrTR8HYBCzq0qoEf7+jiXZlW6qqGRwfL6equIJZ1RFkWDTWlXiJ8gd+skMl4oieg9XV60tBSsgWxAcJ4JiQ4HnDdHi5SY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199021)(6486002)(6666004)(83380400001)(38100700002)(86362001)(33716001)(33656002)(26005)(6506007)(9686003)(6512007)(1076003)(186003)(2906002)(4326008)(6916009)(316002)(44832011)(66476007)(66556008)(41300700001)(66946007)(5660300002)(478600001)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1n4b7cuNk2QXOBQBmDH2C0Ikly7JRRKzsyRTc43RWNpqQZxjGX6QxoVozOD/?=
 =?us-ascii?Q?ap9648hLdeS5UfID6CuhTG/w1/YV86SgRYuDutJ4hLt8J8q52gw2oZANozPC?=
 =?us-ascii?Q?CrKUvq+KvuXWjOB1WxLXymfvV4ubh+BNmoTQyJ/LmfxtNzabeg2gkv3vPmf2?=
 =?us-ascii?Q?Pv9mJ9GrHrg985Um2c9JktgtoNGHfp4cGM0n640zb8dbjK+27FydSId0bZUy?=
 =?us-ascii?Q?PYsFmjeO0g0QEeiZXRarnioH9NsY5puezQBt+Hx3BbVa/X/ND7ChToRpw0HK?=
 =?us-ascii?Q?EtllSZiJt6i1it5aZc4cSZJlC4L7IVDvSQZYOpD0XbPMGWPl5fZtw8b/4fGA?=
 =?us-ascii?Q?ikgzwN7sFwhbX7J6ZXfZ9fWOF3nZbgpKs838BPbCovvL1x/IZsT59ecw5xIf?=
 =?us-ascii?Q?TAypKi2l3YxFQX8auiFm9WxjEuI1W7jJ6WO5DMl0+38bdjg/lLq5v/q07sjL?=
 =?us-ascii?Q?FV8YCzI+Cg1HnkKSK+i1XYRD/oazh7S1IdR/9wL0m4kRQFofxbaBi17H9sJw?=
 =?us-ascii?Q?nfP24PqPAo9r509v5FsIt4o2Xg0x57jwx14sZUGTY2wfg0sP0+eee8uiU4I1?=
 =?us-ascii?Q?UTQZSdtZzUYcWCCtbwLGdEmNuYXf0gCzKGzCMj/VFAy0JLULi7bZ9hIsTGRe?=
 =?us-ascii?Q?K9j8bqoQEKO4YLfvj8Eli6W7s0VZX5YX9Kr+H+IWCW2LlVJ1JI+Wx7Bp8xX1?=
 =?us-ascii?Q?0kP9gXNoFzYqaap8evV/q1NwXZcwMiMzuu6cWNqGXO+LUx2wkWelZV95w9Dh?=
 =?us-ascii?Q?roakjUv+tY3y3m/orqxuaSDqWQZVRH5JAdJ8SiDDuLrwiIZRBr48gMykNOSc?=
 =?us-ascii?Q?qxggw/nMQNb8+zIvvQVpKgkyb0h4ruOGnbf49XeKbTqlrXIZAp3zr/wv2ODy?=
 =?us-ascii?Q?BRnnBzMlPPZjihKWwggWXw2qjH7aj4Ypic5L0TYOqGhaCfiUh+UMaY5DsF/0?=
 =?us-ascii?Q?GIYwyRodEFkmPOyACDXrGC+50Fuq/aJNvqGyWb5PqX6Xtb/HK+mjZAy4pgId?=
 =?us-ascii?Q?LtAFogRLoZaN8MN4vJ05Ic01s2zaRFkSqEdnHL9LY3qgv7+oh8lde4BlLJn8?=
 =?us-ascii?Q?h9qPKIFyJ5mS0ydTQs2nRb8XByHq5wsc1Fw0hwxWzJ9A/pibjSYBEaPeWB/5?=
 =?us-ascii?Q?LALNe/KscJHuy1Qi/1pF45q3N0DR2PXaPbcv672B/UVxAeba78k207Oos43h?=
 =?us-ascii?Q?jLFmYSGlclfTuWRmQzdkN5DL2bYvQTxVj3zzef4OaiYCkKj/G/Cmnyr9LcLw?=
 =?us-ascii?Q?NkgcJ8oPisP3uv5QcRI0j8tgDXBty03atIijSw0PwYNx5Ny6WDs305ZBla4P?=
 =?us-ascii?Q?EelJroUxUhwsBIK5FukSIQi+kXx3/7ocgdaVv9Hte6LvQ7nsF4L9vKh9RJyN?=
 =?us-ascii?Q?ke8M7r7WHGpbus7XKL1+CnEx62GQvUM36cNPAZtNdOvsZNbiPUFcq7Arcn3N?=
 =?us-ascii?Q?+uxs0QS30M1W+CDSbY2aA/jvQUHPZJHPXwWysUGzK8rXmlkaoKnd2heHB2lX?=
 =?us-ascii?Q?A168ODobmyn5k21beCS+sVOD87l1SbiEqWaTKrz91MIM1AXgRKFUrqfkhxwY?=
 =?us-ascii?Q?bvtmTjkOAZNjQ7TdjCT5CRcRtlpv/n77g/NXSlaJ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e17c8117-d9f8-4ce8-f28c-08db6c17020e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 14:03:48.1295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SP38dz5OP47ZcmROBwecHsCRIzzlPizTy5Br4h02zXxsa26WonJPf2fHC1QGWcGvWSztZPdq/CFhgAEP1UbR9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7889

On Tue, Jun 13, 2023 at 03:36:32PM +0200, Paolo Abeni wrote:
> On Tue, 2023-06-13 at 20:32 +0800, Geliang Tang wrote:
> > On Mon, Jun 12, 2023 at 04:22:31PM +0200, Paolo Abeni wrote:
> > > """
> > > Basically any access to:
> > > 
> > > btf_type.array_field[valid_and_validated_variable_index]
> > > 
> > > is not allowed.
> > > """
> > > 
> > > The above should be:
> > > 
> > > 	for (int i=0; i < data->number_of_subflows; i++) {
> > > 		context = mptcp_subflow_ctx_by_pos(i);
> > > 		// ...
> > > 	}
> > 
> > "for (int i = 0; i < data->subflows; i++)" will get an error too:
> > 
> >   The sequence of 8193 jumps is too complex.
> 
> Oops, the joy of loop unrolling! :( I almost forgot about that.
> 
> I guess/hope/think that changing this definition:
> 
> struct mptcp_sched_data {
>  	struct sock	*last_snd;
>  	int		snd_burst;
>  	bool		reinject;
> 	int		subflows;
>  	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
>  };
> 
> to:
> 
> struct mptcp_sched_data {
>  	struct sock	*last_snd;
>  	int		snd_burst;
>  	bool		reinject;
> 	s8		subflow;
>  	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
>  };
> 
> should "address" the issue (basically 'subflow' should have the minimum
> size possible.
> 
> Or possibly even better, simply:
> 
> 	for (int i = 0; i < < MIN(data->subflows, MPTCP_SUBFLOWS_MAX); i++)
> 
> 
> Or you could try using the bpf_loop() helper, even if that *looks*
> slow.

"for (int i = 0; i < min(data->subflows, MPTCP_SUBFLOWS_MAX); i++)"
doesn't work but this works:

  for (int i = 0; i < data->subflows && i < MPTCP_SUBFLOWS_MAX; i++)

So I just updated the patch and sent it to ML, named "mptcp: make the
contexts array of sched_data invisible in BPF". Please give me some
suggestions about it.

Thanks,
-Geliang

> 
> 
> Cheers,
> 
> Paolo
> 
