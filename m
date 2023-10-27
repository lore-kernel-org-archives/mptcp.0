Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120998F75
	for <mptcp@lists.linux.dev>; Fri, 27 Oct 2023 07:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="vFBbej+P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9AuNiGuC6ONWCccol/TLf9xt9rF2otNN8qERWSylKBI1sOA30ozWBdizS5WQxDQTS1r14179f4FJ+NGRLtIxcteCozyepXdofOdFPC7IO4HJ75pjmlMr8v8aK3FAEkHdF8UfdgvLLqTwvDSliFneeuqM34ZdB1hcR4nLfXk7mfVUspZKX2p1dLySfC2nnWqb7e8LADI5+zPurnP8kWiQ8GQQeIC+Bg05wGZzPkmBeMYg8gsT2LneeBDRcy1yIAnoa8j73oIzA7OcNzjebqpxtgKvMXb8KEHns3W3ZTGC0i56ysMu2ylgu7SSNBTk8cLh4zz9UzGgJ8+zejpOELvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaEooZiBW762oyaIfdsuE266hzuU+CJR+CQi59UsuX0=;
 b=jRKEuTIzjzfI/BLkl6dpoym5Gm+xTyXY+CTxhEopXfYAKlboSQq221jdUMqyMBnpz8pe5w7krrpCXcF1nXwMtOfweHLTmA58FGsRhkjySO7jOSlDSDZnyq1rcWOiyydafn2HtbbKZQK93pXgEQW7zokgagJocD4xn3yYRlhVBXdMQPqvwhUoxphYVbFtIYIQTXmmdvoX8fxbBVvNuW0WtwiDCLUPizd41Cb8aIXsxIEVTbMhfyygxrQirZc9Nxs4+TJgdAO2+2x/qcS69sg/k3RKIk6F/xAb4snnPw3N+Z6neQ92SE79QIl3JUsrrSMx2xQxknmErpFKv4HC5VPJcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaEooZiBW762oyaIfdsuE266hzuU+CJR+CQi59UsuX0=;
 b=vFBbej+PdUietSqlCaYI0Z5pqnU7hLlHvRN2S5ODDolEuBAuWym44M5FzRFNMAWAHXPhO/b70Sis6b7JVirY3OTgfhvyVu3n70Wtwn1LejAu4XTIlSDOCB9o61t3JInMFEf+hIh08xgVinNoZxNjeafW4NZuoDWXLvzkiGuufiaXsHRySSzDelw+XHvG2ea5ATyS7PPDGaS/NmMmy7VEq7jJKM8gyYEDDEFmZ+n2JizjpakkEQZxPtRp0Tu5d69aSSGtBGUOhFvcVp0VyEBwWOOwIj7SlQmsBD6vz/uSwCVvKTOTAW65IMzaevUcTcY1qNESWrP0bMyDVeZF5EY53g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU2PR04MB8919.eurprd04.prod.outlook.com (2603:10a6:10:2e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.11; Fri, 27 Oct
 2023 07:05:25 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235%6]) with mapi id 15.20.6933.011; Fri, 27 Oct 2023
 07:05:24 +0000
Date: Fri, 27 Oct 2023 15:05:26 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 03/10] mptcp: userspace pm send RM_ADDR for ID 0
Message-ID: <20231027070526.GA10154@localhost.localdomain>
References: <20231025-send-net-next-20231025-v1-0-db8f25f798eb@kernel.org>
 <20231025-send-net-next-20231025-v1-3-db8f25f798eb@kernel.org>
 <20231026202629.07ecc7a7@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026202629.07ecc7a7@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYCP286CA0263.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::11) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU2PR04MB8919:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e81e800-eec0-44d5-1f87-08dbd6bb1762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EPCQVnfiWkgjQmC6sfWj6fnaGFq2xLz1rp/4HZ3sh/IfVLx+ySOBR3xT+gtNSnz/nblIfRT8Hfhj/n7S+AJ+WR30vcWPLhS/tPnxIj4I0a68ADFWffBviWEbkEVawPx4g/NSbK2jQpOjsbnObb85LhKBTgfy2tVSSgZM7DlKS1m3MIaAv+ilVB9LW4hkaiOPgTatG7keZhro6XEYrwYjv2nEWEjDeYC2QBYuVaYOwwz5t3chNN+umoOAtEGRhe7/QHErKKOi/HBKC4z3Ti3fhiXTVjztAQ3yZ+WIfKYyuoIuNfipGY9liy62xWWaFPsb5uI5kYAarXZnMBVXW/BuqjA0PG4SGgx2jsign1dc5Y+mdwcOFJEHSSzIOF2Cl4nA+Wue02J/RNh8K/x7XIc0ptI5L1sEdnhEWjBRopXEGyCOe3RJ6gGDGAe0FTTgflbIlx2MrNHPgKeZhOppRpKqDbub3Nv7qCt7TPnneehLy9lYeAhKCpiip1GaX7lc6B+p9Eh+E3xssy2ue/4VHjlsUg3VJekWqmm6GkSvxSFhZN+Cihs00Ksco648jC3+9Pxi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(33656002)(1076003)(86362001)(9686003)(6506007)(6512007)(6486002)(478600001)(4326008)(8936002)(8676002)(316002)(44832011)(41300700001)(5660300002)(4744005)(2906002)(6916009)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LjgkOsQOOTUq+VsirhTHPew6NySt6pMO5yaEGuu+a4ANQt55tdG4uC76089F?=
 =?us-ascii?Q?lDX8g06XeThgucG107xcU7zXfHom4KfAXFV9OliJAx/PfSRquUdtmk1wgCqp?=
 =?us-ascii?Q?PC9DfPcq+tymY3rhqh5VE0kR2zrlO1pmP9khuvB5/FhKVYvmzos8xwAXE068?=
 =?us-ascii?Q?fW4zARZDfHT84BCs5LJIypz/TPeqz9nWquwR9bkJ9JhVrKQ/tqG75S2iSNGy?=
 =?us-ascii?Q?tnK8spK57jna/v2ZSY+nJpujLC1opdElCKsuOEn4HpoEQ4+9X3NiCwrHoCZz?=
 =?us-ascii?Q?o+CMi21VGdkxkCCJ/hTtWap/Y0TzSg8wh5hev8HE/QgJTW7ob/WQh8bZzVS1?=
 =?us-ascii?Q?i7tJ7FeF1B7SOTxR+qwy24AMPuwhTUuqv4m2H3mrnbVDdLAGYyziBfBrYz3n?=
 =?us-ascii?Q?rfKLMRP6tFEErxVmNRFIV/V46OykXhbTSI/WMfQaogHEljr8SggSfSX1l5ge?=
 =?us-ascii?Q?jxJ3HVPp7SsEecjdtEV820EnYfvKf9CcGItSBIb9wYWioCFq6IEpFjw/P04i?=
 =?us-ascii?Q?u/slOa5+52iwh+V7uBpaU90SNIGbmfx4uIJyIpwUMf59LIcu1V3FyzAG4Zel?=
 =?us-ascii?Q?qdS+jvDdSneJknO+1xgWdskDR2g95UKfyGACX+EovnjQ/6Wb9T2Kv1DH9qjE?=
 =?us-ascii?Q?u+jeMjdWkBc7jFXGgjrjKTEzJPARzNbGfbF5RdAXqFEsSQExuRQHjoNyL62A?=
 =?us-ascii?Q?T5gfJxtTfTdLzJk90q3A3ox8LcmRZyWwpIkqWqb1/HGC4FVS5OSbS0leObjc?=
 =?us-ascii?Q?Q0dY/jjqQY4kjvEk6QnY1WHbAnVcXVmhgxDsLapi9B+sjN11jCeVkHDneaAB?=
 =?us-ascii?Q?r/Pumnv9y2Wjaj2gjA1/MNauG2eCt/ysCjiMA5ogAkSwj8oi7DHuEwXxyiKs?=
 =?us-ascii?Q?pTBCe3wvtk87JjuiVJnG11m5PlJTyuEKxH3JKoOcjXI+qvXVgXAucPDbT8SU?=
 =?us-ascii?Q?Hitp6ldKYkhvu9VJiTiivZyYuJ0pvZcdD6YcLx6N+unrctEpBK7aytUh5Y+a?=
 =?us-ascii?Q?60CCKN47VzJSK+4WsrGh2jbBpQqqbTsYsrZL9ibIsd69NTd2vYS4SV1adS0S?=
 =?us-ascii?Q?kSINQmJwjdOceHloJW10GCO5QZDehFTdFzxxh5Q1Q4UKx/TwVK6RqTJCwged?=
 =?us-ascii?Q?H1bgpRrCyvG6m3YmxZzH7CdseQtHXrt8NK78l9TjCf/DOiRkyveLeuolOblV?=
 =?us-ascii?Q?B93gg5rXppu0+gqGdwl28pynh7wAOfKrHconLT62KS2NH1Uc71jiyCgdn+xL?=
 =?us-ascii?Q?0zpecFfyyg1dGmyvaTpTJ3zW306Api/GY3dLIEn5EARUmh1XA9aWoFW5GGom?=
 =?us-ascii?Q?RIdyxxHp9962KsCtAxwZexZ9o3SPZ/9862VUGfX2URy7IXcIJd6TKVOHHt/q?=
 =?us-ascii?Q?43++htjL2T9H1jOu9WzSWUveKD8vRypUI+jFFP8pcoipoimIuvL0h99Tlyff?=
 =?us-ascii?Q?jrQ7iQzmWNH5HSnPPda3GBdLt7/af4LLXIX5JiRAo3GE255BzGa/lcYxGYZt?=
 =?us-ascii?Q?+aIw1bp+U9K5Zsogo5S/owK81Mcu1JH1eF0UHwvbXJgYAY9Z0LeUIXIhfhkK?=
 =?us-ascii?Q?BVaexwZCQIbqOkH22G4ouSeYagkxspdtTAzhgftoebBEEA5bGKdfUR1xqxnl?=
 =?us-ascii?Q?JCnnUQgpPLCkg2+ywAvZYm0GJ+kl1KaAkGxtzKVoOJcOdvEuUF8r47p8Bjwn?=
 =?us-ascii?Q?PBPTaw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e81e800-eec0-44d5-1f87-08dbd6bb1762
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 07:05:24.6842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71Bw6en7XKCV11m2hbRISdvWYTiqqyHAnwCmCFPlFcZvhnJDfB+imjUyqsVXusX2Oz/ENTnoNNbz0l2Rybyj4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8919

Hi Mat,

On Thu, Oct 26, 2023 at 08:26:29PM -0700, Jakub Kicinski wrote:
> On Wed, 25 Oct 2023 16:37:04 -0700 Mat Martineau wrote:
> > Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
> > Cc: stable@vger.kernel.org
> 
> CC: stable@ + net-next really doesn't make sense.
> Either it's important or it's not. Which one do you pick?

'Cc: stable@' in the first two patches should be dropped too.

Thanks,
-Geliang
