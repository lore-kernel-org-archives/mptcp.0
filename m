Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720D5A34
	for <mptcp@lists.linux.dev>; Tue, 10 Oct 2023 06:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C9yRmTCg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cl5deaozWNmK5QYH22CH/byOAHHvUPL37TG30KBeAx6THVhXK+2F3iRMGqEjpNukoT5LKIwMj+Kf4c+u7/cwIAV6aSrLs6p+rv6zTJt9XFWdCUqdMp1QEJrSLgL1Ak/HZwwYkcNXng+wgThps7XAkKbt6qR/FuQ13YWCwwLvmAal1HaWAc5tR0CpBu/BNg3FR8pzVrVTOoUaPaw2JIfnB8vjAmQ0RuXmYc208ahhIZp3TddBrmaxKBklQFwoQd5zdiKGXWsmkkwc3aiOjmPgHoYA3g/PnBYzOjfLwoD+vbTy/C8awoeADF8l99BbKwuQzOQdf4D13TRE9dRh2sxksA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJvAtfpEx09++nOijHyEcHZHhI9pssNQOImcwb/1N0U=;
 b=XqWxPdhtfY8PjTdgIo3/yQTb5whoDnN8tiG0vb6nwTxIW2fOhfz+JuI0+JjZRysf6i3+vF4eZ1/l8YMqM/eOPzBejih5xUB8Cy3w8e0Un3lHai0qoV+s/wKYdoOBPHO6dzqc+s3xusRJGyhoUTL1A2oNBEt5K9WOg4xCFRiSHvbOozFmnhX3pRLZ4rcp/+uoW9dwVpryPf663F3YKtJSFPB7rzctgbHrgsPAIskSxe4umNnaT3Ru4+OACIjudkHNaphwFAM6c4HayZ4BkOxcAFhSiOhD7J1zW6J6injFgAg3wIAlfQ5eHcicQDvWLawLo77UrhZ/DIjSlYlVYY8bpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJvAtfpEx09++nOijHyEcHZHhI9pssNQOImcwb/1N0U=;
 b=C9yRmTCglgathXqdcV14hol0UIvAxzyLcy3rN5DvNnOme1065inTGYv2XIZxrNLJZx8Pc3Uil5Cff9/lTGYVAg/IAD7eC6c8xacClrG5a/4IEF9thAlcuWkImbmOuoQlwdTzOPakMwvw75w/n7AXELHUSCl0NdWawV6u7mizacEgrJo43T+FLmLDrej/Wh8Yu43eUrbtSkKoPD5bio8A2QISoV5s5knxAKevfT73JTbNFjWzk6YxVI9/0pSIRcgRtV9r24t8T9ATMnKPywKh5BjfuzZz8reM4P6LABqD2AtOEQz5y1AUh8Dj1jiiOJbHSCDv58HrvCOvSbIx3gYezA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8650.eurprd04.prod.outlook.com (2603:10a6:20b:43d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 06:02:44 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::3852:4f89:9891:73c8%3]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 06:02:43 +0000
Date: Tue, 10 Oct 2023 14:04:03 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v11 1/4] mptcp: set next subflow to msk->first
Message-ID: <20231010060403.GA6593@localhost.localdomain>
References: <cover.1696760702.git.geliang.tang@suse.com>
 <6a31565e01d3474be56bdf62c54d0c20c065c65c.1696760702.git.geliang.tang@suse.com>
 <6c266459-dbba-4bda-b868-b5bcdaf351b0@kernel.org>
 <20231008123313.GA8315@localhost>
 <ff0b0fbc-8bb1-4579-b1b9-09cc06ab734e@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff0b0fbc-8bb1-4579-b1b9-09cc06ab734e@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR01CA0169.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8650:EE_
X-MS-Office365-Filtering-Correlation-Id: 63763cea-bf67-4289-01a0-08dbc9568459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hZhVuFuFVo7ryFj1/siLbJ18ZiM6TQCaMarofsi24HtIwF/HFBkasFsmwLubuCjTnCLMOoEohPlaVY7Z0X9b/k74I8KHipV/CkFEyrZX3NbqxVE/3ZxkM0gFUbQkcxAn4tadPfgh4MrfTCRyM42bOD7co8nqUqPRmfMzt5n+XZt8P4ruZoehgQuLRmfyx2DuG2/zGonguZ9To6F85HXcXlweGxu68sAO0ufe+VnKHXl1gWpPGKOJL8QqBiDjzsPEp3wCvBWUGuiVl1GHWGi3DI/ncUF1CFtIbmDY5zTLJTm4KkgjaSnruV/eCpStl0sKRrjQhrN7A/Hypc764YEuGljHuHenokoAlvPDCXOHqgBvVEibwPesYFzIyE1Q8uj/rgDbJ5G43cqzJHHDDcrCJhPVssW3zz/Kv9E3zuVfhMUgLE6VBb30MvXdFXs4b+gWGmbgbuuyAqeWONGBL0anfF2KS8reDEwCf2GUf1Di3M5NRAEeGAL31+vjqOsvm0qq7eogkEBR7heHfyZFwM0fzpciy2MeQ/zsF+PshCXxiFGHoZVYAmJx+AJ6xcZmWWhif3dkPpo2RowUyBCm/iVe7Or6lpM8fjrBAT8qedsSeyY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(136003)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(53546011)(1076003)(9686003)(6512007)(33656002)(86362001)(15974865002)(38100700002)(26005)(83380400001)(2906002)(6486002)(6666004)(6506007)(478600001)(44832011)(8936002)(8676002)(4326008)(6916009)(316002)(41300700001)(5660300002)(66476007)(66556008)(66946007)(18886075002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pMIGpXr1kX9Hj+Ny9mODUAYKnr/2/bEud4Nl4D4v7pZtgn8M4StDc1C2t0+i?=
 =?us-ascii?Q?WBFJr85H+t6Kx1w1lCkG2iOeWUnNSeIcQwnvSeEqRQMKOx72CH1h7InuB/MY?=
 =?us-ascii?Q?15+6oHsRPO4+XIWZ1KyHH1ci1yevdiKMYvgHESQU2AL9PTC15ewyIZLJIzuc?=
 =?us-ascii?Q?tMX95kV3IUedfmLMUwW/XfRNaGxNvgh5nazrVB1Tmpdb9WS/jOMKAjbnRH3H?=
 =?us-ascii?Q?mb8waP6Pj7sAJl+Tj9KJZhxjlYIJK3apOx1SkQawG6RsqplmtF3RC8wsaHMl?=
 =?us-ascii?Q?ZCLFgSP5yWWONATJU1qzyck14/oGQdL/4W7iyhDtI6KByQTP6I27Gh+UDq6U?=
 =?us-ascii?Q?keQmeBa9+y7MdfBkMAbLrSppdheAUvEQd40oni81KLZ/cg7ew1ZW7+cjhE3N?=
 =?us-ascii?Q?8CI9BsZCaBAtZZB7xq+NCHKu5Z6EtZJq7mz1B5u3qRayHXQ8ucp8SlwWQBzh?=
 =?us-ascii?Q?/BcMXKebg5nYosF1pQMZx3kpijmIbvEBkjnWygs8wcFeZKPyVube1dbCLjXo?=
 =?us-ascii?Q?sgtIZpRkvznuhS/gHu1sacBQzZSlIIC0DJ4SMlvvYercFZY5PEZcEcg3JCfF?=
 =?us-ascii?Q?taOHZfhclxBUbjiGZU5OE8ICgugVu/Bld3ud8+g0XOOWL7hn7kqQvOb5GT29?=
 =?us-ascii?Q?v8sLaqTxa1Bufwy/WBfE63R+Wax9r5zOA7I3/LlUYpVuWFVbS7wjdAYOqsNV?=
 =?us-ascii?Q?phZhzLCiZyVEqo+93VOVMy28EOYLEV7YyaxUSTCcGZVZoofl/vV8SCayoTjN?=
 =?us-ascii?Q?bLGS/Wmi4xbvIjAhUFd/kwwyw2azfMGmZWCBzeh97IuWG3i5HLSqysjZ19ly?=
 =?us-ascii?Q?1NiE7y9fUwgTDPvbKT6psviQ97N9TJ4vjXEfHfVseY+woyeAkeCKQ1L0TeN/?=
 =?us-ascii?Q?CAjdwGacfyEiHZkv7AetR8lFr1owhdSIPJhMHkNA6HJ1DCOKibZKd26AAbks?=
 =?us-ascii?Q?mA7bcpuDF5JaShMsvxkpj2cM6kxIrqKQOi48QpxhQLre+GMuQBcJOQXPn27T?=
 =?us-ascii?Q?iK3H0uxtkmOPViAi7AKii/wtEbxK2NsSa81j2M99qOjLue+w/jdDUpfdaYbk?=
 =?us-ascii?Q?LhbQAdUWoFenxhpKnI4aSqKu2WuRSOQmvZb71NPhVhq5tNJeuCHxY24PU+4J?=
 =?us-ascii?Q?yjFPOAHUWZex+cBbAnCxWks4HHkNXcNMTEgRObWjA23kpIvm2HO2wY50FuNE?=
 =?us-ascii?Q?D3KRFahSrG6O40osOgz8JyIrhVG8r6h2S2y+loujvq5oj52L0rlFJ5pON6B5?=
 =?us-ascii?Q?Xd3pXkmbqnpSRxflsMjJNRJi+D9srM4mRa1x3FCdZ7Vv02XTaIKMd9C/w6IT?=
 =?us-ascii?Q?E5FCJ+GUFJIlm7qq0JmG7N+DtbWZxfAWpfLhVViY+5xt6NvtgurkOZ7joagD?=
 =?us-ascii?Q?u1tSfL92Oz/Vao0DX1+2Oe75DLBVvfxvxTT+uTFLompfY4nPLHr0vGm+mo8/?=
 =?us-ascii?Q?zIQJG//ZEzAjH8ST5EA0X/TVBrddf+W5ExuVzc2aHSBtzFXsxn8TPTWTlBWw?=
 =?us-ascii?Q?vqfgYdA/5sOt13MSBkJZ4rVj70FrvDpCa6/TtFw2QC8RkwcNNw2MGlalKc2T?=
 =?us-ascii?Q?jlHwCu7BgFUQYtlUtUq7pMd0RHrqeobcje/tierO?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63763cea-bf67-4289-01a0-08dbc9568459
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 06:02:42.9561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqq7fQZ0kJqNIcS+eLhpb+iDuQ8Ph4/QvqVWrI0+h403mpGSuH7+kUy+OJwbAZxGrorgTkNsVozQrFXjKZwmNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8650

On Sun, Oct 08, 2023 at 04:05:10PM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 08/10/2023 14:33, Geliang Tang wrote:
> > On Sun, Oct 08, 2023 at 01:11:32PM +0200, Matthieu Baerts wrote:
> >> Hi Geliang,
> >>
> >> +cc Paolo
> >>
> >> On 08/10/2023 12:27, Geliang Tang wrote:
> >>> When closing the msk->first socket in __mptcp_close_ssk(), the original
> >>> behaviour is to reset this socket. But if there's another subflow available
> >>> in this case, it's better to set the first available subflow to msk->first,
> >>> instead of resetting the msk->first.
> >>
> >> I don't think we want to do that. If I remember well, we want to keep
> >> having 'msk->first' pointing to the initial subflow for various reasons
> >> (I don't remember exactly).
> >>
> >> I think what we want to do is not to reset the initial subflow if there
> >> are other subflows still available and we don't want to set it to 'NULL'
> >> in such case.
> > 
> > Is it like this:
> > 
> >        if (ssk == msk->first && !msk->pm.subflows)
> >                WRITE_ONCE(msk->first, NULL);

The code:

        if (ssk == msk->first && list_is_singular(&msk->conn_list))
                WRITE_ONCE(msk->first, NULL);

works, no NULL pointer crash with this now. I update it into v12.

> 
> No, we cannot set it to NULL nor release it but we should avoid the
> "reset" being sent.
> 
> I don't have access to the code for the moment but by looking at your
> patch, I would say you should not modify 'dispose_it' nor 'msk->first'
> but maybe check if you can avoid calling 'mptcp_subflow_ctx_reset()' if
> '!dispose_it', maybe by checking something like
> 'list_is_singular(&msk->conn_list)'? (I think you should avoid looking
> at the PM structure here).

Something like this, right:

                 * disconnect should never fail
                 */
                WARN_ON_ONCE(tcp_disconnect(ssk, 0));
-               mptcp_subflow_ctx_reset(subflow);
+               list_is_singular(&msk->conn_list)
+                       mptcp_subflow_ctx_reset(subflow);
                release_sock(ssk);
 
                goto out;

This doesn't work, if we only avoid calling mptcp_subflow_ctx_reset,
tcp_disconnect will send a RST too.

Thanks,
-Geliang

> 
> Please tell me if it is not clear.
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
