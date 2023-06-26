Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540F16FB2
	for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 09:37:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asBIg30VKWKKVj79iwTAORK8qAlN5qXn8DjXOixVYACETVu12J5xoCGE9qZzo4MVdXHBxlyEzyrzqgQWrs3W1GbrAJEWz3zBAg/MtZvN8pkqRg9KMURPdRSTilgx5gbnsDo0vkeysJaB5tVlSuDC0yOrG8sj5/aDVzSraamTWa/nglroBuT4xnbSmpwQTPrhraRmGrOH1yx8blYghL3ztm+9rBGayyK4gD3eWMYxiJ7sNucWCt9vFySbuLdq/tryD2W6fCLVX8HS3RjQ4zAV/qg3+7rtblC/Km3S9seLIr79Rse+Z5lmt/VC/ZA37pIFchs9wVBBHi5E81I2GI7jAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOwrk8TVZFh2sQKafAu7WB79TxR6cLcqkiwaB70Vvos=;
 b=NdxNYFzumyWiw8TPKi14CmuGlU5aH9aupxjo8fbcLofZuqQry9QPewhzPGZp9LkFZcaH/O1078Rne0pLMNGbS0vlwClKRCmoglmDt/isW2Cbw+nzy+WkigdR81wKMzOFuZ+TPVN0pmY50idWCEbFXb6tPSqy2IpjJZN4pmy7RarGR0fm/+61nzHYcD0E6cRfeyzjnmuSRpKAzN7r6rPsb1LUI3YNh3SN2hOeQLMGzpuFNKpZKf208H2s176L8uOskldWBXrNc0JJe4cpznDEoSG5ItDZt1i7cIUMH4NVUDWI7CbDtFOGP0Mpwz6dtTkmkVzQdsUGGsYaug+hGf273A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOwrk8TVZFh2sQKafAu7WB79TxR6cLcqkiwaB70Vvos=;
 b=c7TXPr5yzyxL6EP3ld8gjk74P2yhmz96xE7um4ISeY00WL4eJtZToYC7XuqjTDRyFa3HdF5fe4FDTEKFFZ8NNlK+IOG9lU/wQ+tF4WbcEmH8B1zz24FfDxbYMqeZ2JB0GRFG++yw/q2IgDmDUC+77/QUnxntGwAO7aTwyPhYI4w5n5rjeC1hlX7flHU1ZbJnLfRu7GZeK1egySd6jDHRluwZONkchsKVxjF3geJj2e52SwrEVu90AG1irzKhAlOXDO47SfGKsCpMeIaM/TT429aPF8Cax6KpE9w2XMojVd5tFBVeCdPbDXwPvhyIle+dMn4GD0g46LQJhUnmGXXJaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB9990.eurprd04.prod.outlook.com (2603:10a6:10:4ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 09:37:43 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 09:37:42 +0000
Date: Mon, 26 Jun 2023 17:37:44 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v10 02/13] Squash to "mptcp: add struct
 mptcp_sched_ops"
Message-ID: <20230626093744.GA11120@bogon>
References: <cover.1687746021.git.geliang.tang@suse.com>
 <0379bf05934dc748d9c27734a43e8d7d0a9312b1.1687746021.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0379bf05934dc748d9c27734a43e8d7d0a9312b1.1687746021.git.geliang.tang@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYCPR01CA0075.jpnprd01.prod.outlook.com
 (2603:1096:405:3::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB9990:EE_
X-MS-Office365-Filtering-Correlation-Id: ad1b3fa8-58ce-4103-b5b9-08db7628fcf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3Fyg+QloEGnmJu5E5ODlk7fgVN5ITbRm2jt+H802pDP7023B/GV4KX+LXZaEPVqJQ5RpzV0qswc/I3BVauVtmbmtuePwaZYpSK7sBiu/d3uC4e9GZxot051LLtjVWbT+EZ3oCusEPHFNOwDFn61s2Wbdx2DRTqoTmsiabO1zExuRl3VkssW1+h12gtRAY3fPU9W5mYtUWqIr0S7KR6MkNK6pK+7WxkgJwMWACCOgkbInDlydwIt3h/4Li7zR8CcBoE/gob2JH5DOIUAjlaPIiwamn+5AM+tiKIV6VTKhRNRRFQkYkAULEz39UGSMt49YHlx+Xjy/xijmr6aZc6fUg3oF2Mu41iaAWataLsJ8+/DVveAtlsweJHw/mNRzqNDJsuh6EaBqPA5/7oM9E0oQBtNYDb67icUwLk0roIkj3DDOJif5jcDXIPkXa1xB9dFLoGPfTZ+nGsSw7D7v2IaU9qEr2PDynxttkuGwNH5TcTausZ7UpsCjlwjusB49yJF6dHZdodqpisAhHzinfD+a40zuKZXake7lWt0lUUVWHc/Yuh6Mo2uTCskdD/9gwe9X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199021)(8936002)(8676002)(66476007)(66556008)(66946007)(41300700001)(6916009)(316002)(6506007)(1076003)(186003)(9686003)(6512007)(26005)(478600001)(6486002)(33716001)(2906002)(5660300002)(44832011)(38100700002)(33656002)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?escIcGMRpWYJLACFgzutVbtM1ZRLMM0BTlEbQAx01JM54LnJHGRiipIEQGtO?=
 =?us-ascii?Q?33uB2Vqyz6vJ7720E6UB0ldM9zO/S40lt8nYcZH04AIhDENrJEXqnSRPxJTG?=
 =?us-ascii?Q?e1Xp0cOx1S53zrLBWjdhiRzuAXEC2Uf1ZyJiSkq4BoiS3Y8QkG1LHB8RqpWs?=
 =?us-ascii?Q?Yu23z206JDJwMFsHdl3uOABAGf6NRvIzvqgLTQ87eRneoAdDiWh5WCIVRDnF?=
 =?us-ascii?Q?PUaXpUvoJ52gEISOGLbdy4TSYtr1D9GOtuNDxBeGjOxSmNMpqPXDAIIwZkYh?=
 =?us-ascii?Q?oSnq1d2GSa1l5R92PyQ6wmi+9t9XW1HOQwyefhfnpna38Yma5+e6Mi2J5vre?=
 =?us-ascii?Q?qEa8L/GR6XBXkVYUCdjhsoWekENUAH+NQeJ4aIYnScMg80appOQTMyiYI5RK?=
 =?us-ascii?Q?swkwDp4Ng1/92AsUaUmajkBeqlPK/7Kv4D97oLqRlRBNpuVMl4Sm6r/LkPWg?=
 =?us-ascii?Q?ie7vjGpijEiTpqSB+0IffCv3NJOWQ78+9/Hkhj0tSTfhtML8NhMuOqj+u2J/?=
 =?us-ascii?Q?BKFUCT21U5oHxeOuZx97PlX+4efNoL9Jtn1JybQ9hrnH6qleZ0Hbf2NvJepS?=
 =?us-ascii?Q?KOeizHuN4sjek4Zgv8FXSQcQjG7QB+B9DNUffvXmG1ULlOG6EPzl/+NwqdtS?=
 =?us-ascii?Q?OdvRyQ+4PGhRLzngbzNIEUXW14Yj6u/g76tyXRbHSbGRSXL+QUyfkgMNdiaO?=
 =?us-ascii?Q?aHe/pSt4K5Vn1pCEGpRKbrYEg8ca294shZ9COxaA4CHGRJDXGxjJfEJOhA6s?=
 =?us-ascii?Q?wvkZJRQ6S1AOOsyGcsvpYELA8HCdhoKFYEoKi/bv+cyFNd4E3EGPi97SzBEM?=
 =?us-ascii?Q?pMERv8rz4kag95rsxCl8K97uKjC/B91QqJzNsDC2a1/E/FW9OO99fPMOwi0G?=
 =?us-ascii?Q?oHYv3VsSUNRk0He2Iuk4oJHMrPRXV4GPYmhUs5qu7BeK0cXYTeyj5O8zBJQI?=
 =?us-ascii?Q?NF7U/y9BfTCsVarCHlV7da90ANw9FYiXLBD3vhOHlkNaxmcMs2qdcP30e77g?=
 =?us-ascii?Q?qsSQKht9Fteq8D7enAunBcQvH2kDxpdQsu1m/e9ozTvs9Nn1Re8mOgM8Q9Qo?=
 =?us-ascii?Q?2T1vWYHN7PgYMYVjXqqi6nrxlZsmt87/zQXlFxLV6LJPwp3I3GsPnoYCZ8+v?=
 =?us-ascii?Q?VMVmHCFBT+TAtKRxn+m+nI8OLBa5uSzdJW1iTYpXdgwLOUEmJ+qTMccZNHXk?=
 =?us-ascii?Q?47++W0yXTTDIbkOo59PV0E+gW1wpUu/Ct0GoailaZK81OljXGSCfEB8AJCqp?=
 =?us-ascii?Q?z2xIblph+RAfC5QOxonjrml0Rz8W9T8TFCrUlESnh7R5hVPu2Vn8M8B1u5YE?=
 =?us-ascii?Q?QgpjMCEml29HKccPI6oIeqJIAwQKHeBPHXSH08UHvr9PrIZHMCfTwI4lr2mr?=
 =?us-ascii?Q?ncAiQasnfqCrNkfcDmiIcLDEW8cLIhHmLRJ9WP3Bw4zmn27enko65e8NwNv2?=
 =?us-ascii?Q?SB53Eelkyzo1kPhx51qaqwfGFw1618/CV5bNDi6bweTSsrhDfp/6meq1sV6R?=
 =?us-ascii?Q?9qygQPD1RmzE/wPyVt5nUVN+xhHHgBpWJ3weE5G3jY82Kpv4mjc/uM/TNm05?=
 =?us-ascii?Q?sS7w4kBBnsuC09c/ovkfa1gWN+zsP5pe50y65hdf?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1b3fa8-58ce-4103-b5b9-08db7628fcf5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 09:37:42.4163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMn0qX8XRbm90p0rSkY9vvVg1gtuplGfK7Us64SS/YPz2GBVsThGez5rqvvgfHUIuxhNq3BmqgM3Fhzi1H8GVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9990

On Mon, Jun 26, 2023 at 10:23:03AM +0800, Geliang Tang wrote:
> - Add subflows in mptcp_sched_data.
> 
> - Drop const before msk in data_init() and get_subflow(), since
> msk->bpf_storage needs to be writable.

No need to change msk type, we can keep it as const:

#define MPTCP_SCHED_NAME_MAX    16
#define MPTCP_SUBFLOWS_MAX      8

struct mptcp_sched_data {
        bool    reinject;
        u8      subflows;
        struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
};

struct mptcp_sched_ops {
        void (*data_init)(const struct mptcp_sock *msk,
                          struct mptcp_sched_data *data);
        int (*get_subflow)(struct mptcp_sock *msk,
                           const struct mptcp_sched_data *data);

        char                    name[MPTCP_SCHED_NAME_MAX];
        struct module           *owner;
        struct list_head        list;

        void (*init)(const struct mptcp_sock *msk);
        void (*release)(const struct mptcp_sock *msk);
} ____cacheline_aligned_in_smp;

Will update in v11.

-Geliang

> 
> - Add const before data in get_subflow().
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  include/net/mptcp.h | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 828b10ddabee..ba0e1ee68a05 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -101,21 +101,22 @@ struct mptcp_out_options {
>  
>  struct mptcp_sched_data {
>  	bool	reinject;
> +	u8	subflows;
>  	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
>  };
>  
>  struct mptcp_sched_ops {
> -	void (*data_init)(const struct mptcp_sock *msk,
> +	void (*data_init)(struct mptcp_sock *msk,
>  			  struct mptcp_sched_data *data);
> -	int (*get_subflow)(const struct mptcp_sock *msk,
> -			   struct mptcp_sched_data *data);
> +	int (*get_subflow)(struct mptcp_sock *msk,
> +			   const struct mptcp_sched_data *data);
>  
>  	char			name[MPTCP_SCHED_NAME_MAX];
>  	struct module		*owner;
>  	struct list_head	list;
>  
> -	void (*init)(const struct mptcp_sock *msk);
> -	void (*release)(const struct mptcp_sock *msk);
> +	void (*init)(struct mptcp_sock *msk);
> +	void (*release)(struct mptcp_sock *msk);
>  } ____cacheline_aligned_in_smp;
>  
>  #ifdef CONFIG_MPTCP
> -- 
> 2.35.3
> 
