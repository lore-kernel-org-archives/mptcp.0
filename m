Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140052.outbound.protection.outlook.com [40.107.14.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664B87E
	for <mptcp@lists.linux.dev>; Mon, 10 Oct 2022 11:18:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etOqHezRfrXN0v+QtZmTqKwvuQ4FC3Yg1BxkgqZ2uUIrdRdMaROScQXkrMpU6uIGH6A3Wh7qpzZo0MnU2mHz09ZuntgMGw0mptNZKoz7yTGIRtvJJN6YCHvXjIKPDMKpI0jS1TnG5bsSNz3vg3SLcF7mvB+GsEUfujZfA2lkjFQ/dQwas+ZHvcl2lHUhc9VEgaAIGtKJ5Be/t/49sx10SFsCRNRghef1a7oCfA5S4MdyviE2NviDzxKG7gUoJ8FBITV+ucHVyD9DbFCuIm1qrMyKuJY4dD59PVbT1z+o/IB5JMmklZT7djcTwRkboNc/ontD9ODZs5yy2c/WHQjnXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4L9wJeK5WHvs+sK0K+GO8x55Kj3I5upSi31LAJKEKUY=;
 b=H0E7796l+L5sACZQLlSKWS2H0PLHXvYKu9xHIkK3fhRmgnCVccKF2C91rjZt2VCsS9EwIuWUIf1cHCX7nHGZ+s5uWlGyah+z+c1DxJ3L/1X28IubMLw7+NrQBfsGQ0FvArkCXkwGv9KAXfSHPwqkrfvW9dyO3MU9lLYD6aX69/o0cC/jCuFyP8VbN6brgAhyfc1DKPgrAZAtzkITrUSbVdpbc9IxG8S02r0h0hh5wO84cPOab1+nJuLY26RN3bDx4K6U+0un9YPznnTKjNSoIMuvlkymr9vtGGd20SFCB08Dac1HGQ3piXkQ9AALzUNFZYjqQ5Bhwk6iPrjvvmKJSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4L9wJeK5WHvs+sK0K+GO8x55Kj3I5upSi31LAJKEKUY=;
 b=QKqRiBReXsg8Rd4yo/5iuCDDn/Z8RIOlh/rsdE8xQuHlvrzb1TJ6RuVHng4kvZmRq9HiWGI23e1ymIpOk26JsNdlhYRSwhXp5+Zxc8N3WOjQTBnZBl7BCbTHugj8+X+LlMeFGLnmHc0JUXHjbZBFWFdza/GBA6vjDTwaGo2t0RKrTN5qm0EgI/vov5gqxxPk2gMWIo1bjLp07TKgUmRRZ7vNSKd78YT1jTS37Oxdu7+OnFUAsm/2KMmfg5FGYEKdGvxZE5xLI+wy2WLz8CNvk9u8eLF++DFZLUe0RO5mWygBn1jSFAPdxlKZnqML3gL1QAoHNqHilU0lAbTTZqEPhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7595.eurprd04.prod.outlook.com (2603:10a6:10:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 11:18:14 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770%4]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 11:18:14 +0000
Date: Mon, 10 Oct 2022 19:18:54 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "selftests/bpf: Add bpf_rr
 scheduler"
Message-ID: <20221010111854.GA4614@bogon>
References: <20221009154531.11543-1-geliang.tang@suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009154531.11543-1-geliang.tang@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: 27e6e4c4-41f9-4c23-1a81-08daaab11f8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ce047rXUZIS+3rQJmcr5LHpvacogAgUrg+tHFH/xHvp5OUMLnEzuYtUF3EItfeG+l4+R+Uo/OgDdHEyoqpYiZc7Vde7I821hhBBvb9pCcz4aP2Sb+qfwDQpxYynDkTLQzs7uNwRCuSO2e0/4Qp/1mtENzV41tFnZh80ipKo+vGWMqG+d/V4MYwPxKDZorIF900wgaqai+sJ9JoFliA58IehfhdiKwFGZbIieqEmZkISY2r3JZMEpoTI2qWHXM6pOXo3kvjNC9rxbgqBopIUspmacp6Sh5zB6ZFgQN8DHLANHdsOibR4fCH/6zUIQN7MtORaMTP/1KEh4kALkLhDbaZN4pWr49m9zVy+5b+jBbv21DhOXJXgWo0z5ccbYhN4vHMkmwkvMWMg0TeRXxkq9biaJ4+cKlI//A9OI2jvHySF2RDok3EUt+UWT+KLFtDEXjSeN8EmHA4kKnENHJuLqx3VDAMkxlfjYfqc20kL+29wASf9rY4zQhsc+6k2zt6XqfmPpaaGHNAJAVmU+IZpbmhGC9cdbvrnaW0ZVm58OcVMng3Eq1UqFS445NvH7tnOLqEBfdR8jlq2lw67cRthCR3qM53W7XcEsHztmYUuK1mdd6/Uy9mmjGTQjogupuVxZhAfZwxYC+vZ0/MgChEPucQqDtg3zOpCqCcG+QZburHhbVAaVBPf8Rf98X7qR0qFk48sfwH7M3g1+oeIQ9VtywzFyPQOsnijtXZ1f5qP6TrWwUtKpkqBTTkb20+XwiFf6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199015)(1076003)(186003)(44832011)(2906002)(66556008)(66946007)(6666004)(66476007)(8676002)(478600001)(316002)(6486002)(33656002)(41300700001)(6512007)(9686003)(5660300002)(26005)(6916009)(83380400001)(86362001)(8936002)(6506007)(38100700002)(33716001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?slU8Y/N0bsz+4040nCTZB2cmLU/LmoeooNS6N+TFo3eO162qye+cWX6V7iiV?=
 =?us-ascii?Q?fr+wKDgI7N3tloosCgKGTkRrSbS8j+tZaeXy454syIYrIdtoiLeyDwaPp8jx?=
 =?us-ascii?Q?rSFIn/LExZcPfCI9worbV4whtfqElQgRYBK4zOIdgMTI6/4ImPtOhVjB2tNv?=
 =?us-ascii?Q?PqOiDjId8LQQCp3B66bqc87gwXO4jY3aVCnzM3XpJ3RiS7LbrxosPR9WV4TM?=
 =?us-ascii?Q?Zo4RwQjD2kpH+wh0wxBCmbxs0R3nKqTkvvYTjK+7GKwCkCgsOv/WYpLgDfGM?=
 =?us-ascii?Q?1f1Fb4ndj5V1DhwEQkbitEkTFMqjW3HLKI2xNiOhc+uHPUuvBijJ/D9fkwQR?=
 =?us-ascii?Q?PkEaioV/V48gEa6Cm8e6yzjTqHI2q5X/Uonk9yPDe3fv9ZYJ07YoYtwwelbH?=
 =?us-ascii?Q?S6XRm7wZfWz9soWeGk5EeGkjpBkCwd1cT2QmEqVpvs32zERvYMuSsbwdOeUX?=
 =?us-ascii?Q?Gw7icP4g3HXjS4L0oeFg3EGVzPONM1aC2ngj4cnnhEugQtcSaiF+FDm36ExB?=
 =?us-ascii?Q?WsvCwjBOIdmrXcVY0TLK/vkDBYu0aOkkSExsdMdxkSv5dM22HktiF+LTBHTy?=
 =?us-ascii?Q?xY6PuAQzAiiJ/GPUNXvSyvtsoAPU3Ddg2aNvAWuqTHkdbSUHHtscTtW8iUqX?=
 =?us-ascii?Q?mcM02QntzVVEVBFjL1q/7rPxS0ipt5LAvOZQzOZvb3o4KVtdmaejbVO1RXed?=
 =?us-ascii?Q?uQ5+2LGoeraathCerP0xNBZAXykrmWyu5K2jFGiF2uV31lCIXaOQSWIt48t9?=
 =?us-ascii?Q?dF1t+lHzh3rUwK8rU1KHpP3Tckj7KZQQOh4HzH/iMC8NFxP93B3UM8IGYb9y?=
 =?us-ascii?Q?4Qx4r/malmfcR8j7is30USqGTdKZTbGH2a7qBSOEqiDtVJBsBWmIrGM9ehl/?=
 =?us-ascii?Q?D5HXMax8ECh+iy01aaixZF5/0DTLtJAg+KhRGbQPvyT1hhBqE9KOYdQNV1kF?=
 =?us-ascii?Q?QRr0dhePcBCqppjtbfJyycsBc40hds8//0lJfDzZwzUFbfdde0OsxNW8v/7Z?=
 =?us-ascii?Q?fBTRGmgBKcK1LePQpNqz+9DRyM4/ypV1fB+UpLb0CS9DbDDWbDBrQ6OzWsWL?=
 =?us-ascii?Q?n5rZReGXz22A5ZvVcCxlpHL4p3B2tA4vkNqNgpEA4k3zELHnifSve6i6OTU/?=
 =?us-ascii?Q?FnEVmGBMEz6YdIpw08VSaF+/0vHGnkfwMdhQM90q/M7KOu3h+q7cMIgTAyNY?=
 =?us-ascii?Q?lF3wh3IkXVzefKcUl3I7F2xwp1uk6jwv21Ky4mkwGc5i8DoBwr4vEUUTu4An?=
 =?us-ascii?Q?ZdvZRsZZPJdPwq8ySlfASMxfNcshlQIsGhrq2UsozIyxBxggDRmB0nv+lMvg?=
 =?us-ascii?Q?ZNKLX7fvksaEmPGvAp/twTn5/0oGH+NhU1sV+CCBWZ3mLgyGoQQHtYfNftgm?=
 =?us-ascii?Q?SW/fnOztH2dvS5g1MMBH960Dj6PpOIWzPicbBAedkGwXKWo2QBFhtGhiOORS?=
 =?us-ascii?Q?BW7E7/IhI/bSzkHQxaUTy9H7cP+RywPj5lAwXgHE7rl3oHLzrz6vQdU3/Rk8?=
 =?us-ascii?Q?+fqonHahmACFYeK0Jzt30oZZkiU8cYQh8Hwd/NHc2/IRosFuSI5ZCZvNfNTv?=
 =?us-ascii?Q?CYUjMWX1dg9wVjyy3hLqGP/3aN5txTnkdi3cJZvMUXzTicKckBKSeO16x1ol?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e6e4c4-41f9-4c23-1a81-08daaab11f8a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 11:18:14.5017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+YWv5a0Gxq70BlZn24wcOEo/lXL1/ugwhFLaFMPf3tMAmA/C+bGfjM7I5E/ahMluxihccnbhmwdhnksUgCguA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7595

On Sun, Oct 09, 2022 at 11:45:31PM +0800, Geliang Tang wrote:
> Use last_snd instead of msk->last_snd, then last_snd of mptcp_sock could
> be removed.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  tools/testing/selftests/bpf/bpf_tcp_helpers.h    | 1 -
>  tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 7 +++++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> index c7d4a9a69cfc..c8792e6f125a 100644
> --- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> +++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> @@ -257,7 +257,6 @@ struct mptcp_sched_ops {
>  struct mptcp_sock {
>  	struct inet_connection_sock	sk;
>  
> -	struct sock	*last_snd;
>  	__u32		token;
>  	struct sock	*first;
>  	char		ca_name[TCP_CA_NAME_MAX];
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
> index ce4e98f83e43..65d4f7f41bc2 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
> @@ -5,10 +5,12 @@
>  #include "bpf_tcp_helpers.h"
>  
>  char _license[] SEC("license") = "GPL";
> +struct sock *last_snd = NULL;
>  
>  SEC("struct_ops/mptcp_sched_rr_init")
>  void BPF_PROG(mptcp_sched_rr_init, const struct mptcp_sock *msk)
>  {
> +	last_snd = msk->first;

This line should be dropped. Will update in v6.

-Geliang

>  }
>  
>  SEC("struct_ops/mptcp_sched_rr_release")
> @@ -22,10 +24,10 @@ void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
>  	int nr = 0;
>  
>  	for (int i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
> -		if (!msk->last_snd || !data->contexts[i])
> +		if (!last_snd || !data->contexts[i])
>  			break;
>  
> -		if (data->contexts[i]->tcp_sock == msk->last_snd) {
> +		if (data->contexts[i]->tcp_sock == last_snd) {
>  			if (i + 1 == MPTCP_SUBFLOWS_MAX || !data->contexts[i + 1])
>  				break;
>  
> @@ -35,6 +37,7 @@ void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
>  	}
>  
>  	mptcp_subflow_set_scheduled(data->contexts[nr], true);
> +	last_snd = data->contexts[nr]->tcp_sock;
>  }
>  
>  SEC(".struct_ops")
> -- 
> 2.35.3
> 
