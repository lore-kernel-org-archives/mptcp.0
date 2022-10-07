Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10073.outbound.protection.outlook.com [40.107.1.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514C1A4E
	for <mptcp@lists.linux.dev>; Fri,  7 Oct 2022 08:59:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJW2TqdhsxWVUpyn+TQGLQox/GZLlogpL8ME0PZesO2lo+i7a2j+bhx/U/ucK9LH39p9QpPLzVV43vjY55GnLSwQt3/XTlo7uuezlYkk2USQEnvnzukgsnUnqCljiXkFUCWfDKmT6cGbuvQFBwtRLoy/epspdKUi6NPuhmcRkBRAtww25YKOPXqm41wjfgVtnwuwTIhukyaQTFB5OuolCf3ryvSfmXrg3u3WlYZdHlSEszPTThYS6jYNvEM30pcJFda1KpJwGEcAErMytr+rVphx5LyJmxsQcEJI4FW3B58l91PuEbiYM7amI03QkDISIfK/I++KSVCZHvR4Xp9O/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4XwE2qvIk1X7LXM9hnr9WtddgwGl0UpffZsaVDGf/Y=;
 b=hQ+75LTEgy1eST9+DDnM1gz412l9nlfcLLy7b8XKR5j0UfHVDJouONiD162NG0ycUBT/b6v8RDJyQuRt9zUKM+ufoeRoenukNZ9dyUvuncXQYZ0ICNk/atP8FtjnlJ1ETHGIAU8l5twMoS5G09Q++o144/dHU9CArbSgqSJRRICrTL3GG9lqVsv05M0RcgXE3K9pmIkAJieSPbXfh44R0VcdEVQ88Ck2eLQ6uqWcVlUm1usAOxnuofZPsE7bFstFxEmxZzsSv8G59XgWfy+uv+Y1mMGwye5qaci+JrdNLqrKSny35R0tRvpNhl06Vp3va/BjjkBegTtIvGan/p790A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4XwE2qvIk1X7LXM9hnr9WtddgwGl0UpffZsaVDGf/Y=;
 b=hdtV5NPqx6SunFLP4po0IBRAjtm4khBguD9SYJWwmG6jLApI3H8uYBJvI0cVQ9GLT4iX98mYutkKQO5Cu8tyhl6QJx0PsYyXNrcUm+ucsAgetJZd/6yMcgnItFEY6eeyvVGmotHSLYlgW3w9TRI3XLhna4AGSp9d0Swt9lRlWZCFXLt7ho5X3Rl0LmO1c/86B3E5PexZkR/zjNLsdTFiGMk6a6yAuHeqKvJ9USoacoF5AdYM0b1uKrmXQQTZl2FeGPjEZ5+FMZCjSWOyzIxdP52yw1qwwDwHokRxtgNg1UragL2yC1Px+JXTbJ1WZZFJ/WiTC4IaHj2aIpbgf5ajUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB9664.eurprd04.prod.outlook.com (2603:10a6:102:262::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Fri, 7 Oct
 2022 08:59:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::c5ff:965f:506f:6770%4]) with mapi id 15.20.5676.034; Fri, 7 Oct 2022
 08:59:47 +0000
Date: Fri, 7 Oct 2022 17:00:31 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v5 00/11] refactor push pending
Message-ID: <20221007090031.GA15380@bogon>
References: <cover.1665058388.git.geliang.tang@suse.com>
 <86e6c9a8-4361-ec40-56ee-98c270d8342a@linux.intel.com>
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
In-Reply-To: <86e6c9a8-4361-ec40-56ee-98c270d8342a@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYCPR01CA0110.jpnprd01.prod.outlook.com
 (2603:1096:405:4::26) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB9664:EE_
X-MS-Office365-Filtering-Correlation-Id: 883c46c6-4a24-4bc6-66a9-08daa8424900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nzhh+d2AZHLlXkGGWOAm6zBq+yEe76It8E0CSh+nzWDWgqdqWCUfthjghhgFM7dz4E5+1RdcH4QBB9BdEnQ0uWR78MsFbVTdrUZslSh+RQ6cHOf+QXI26DWK4UYNSoPJlRmimzJnu2apDfrn7j5FECzYKD8YdOG/E+mMlbD92oUFqxknOAbmNdXDbtJkxxNMyMVsF42P8N31D8p1jnOVmcDJMZ4Kz3UzwNesHccgk75YdqJaCp5Tlz0aUUy5K9bxGm9JFOmcEoIn44dHcd6Em0sG7sRd+N3l96704q3RrTdozYUMn4rjtf0eN9BJoYG3XZ13UBmXdzCyttQcsZ9MDF8X4S0po03TJMiTkSyQINNM/zn0LgwmNWCjj5zGT7AwX99ZamtR28VJqUXjOUYuK5McVAEBPh8KRiRJKaTju0/Mk147vo2dNsuyl7Zd8124EityqYHYt1qNFNgDbQQYWlBg32YIfpn1dPMz77+A7IqUFnHJ+mAYGgOkD7wZbBnmHN06MBpSBzpbIoS/ne9DvVv/w1N+P3djCpmbA3fdMEyE5hF7ax2rcO05LTUL1YFxekLqlLp/O+Ow6kCX/oL7UlmrdTPAIUA4hQDESIWFgmN0sPn8cECiwx88YB2IXBM+2R/JkRyNvHcgdqCTr2/xZQhZ1pQ4MiqY05iUX/FjtB/BFw42NSZKQy+/Lv7FC/xB4HhetGyXyrDkzDUWFjPbWYUDDIDMvYBSOJ55rNCPUBb2CD4L1vU0aI0gA7RBjMjSQy7Z+fmChIvYvFWEPsf31fQNjtfyDm7CVI6pPopM1+k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199015)(38100700002)(8936002)(44832011)(2906002)(83380400001)(33716001)(186003)(1076003)(33656002)(26005)(66556008)(21480400003)(66476007)(8676002)(4326008)(66946007)(86362001)(6666004)(6916009)(6506007)(6486002)(235185007)(6512007)(9686003)(5660300002)(41300700001)(478600001)(44144004)(316002)(13296009)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CZVB/aHm1iFinyMOX+T2bGOrI65dZW72dvREBrULA2rjDHyZQYHjeDnJogkA?=
 =?us-ascii?Q?lqmG2RRR7CjP5kjPclJm+eNNxSR9O88T3kVWcjF+HzIpXjZ/O0oYOiF8iu5C?=
 =?us-ascii?Q?WHOnWsKL/wqE6moDDGBeplsRUgT+SuLniN8y1fRVmLRT3x8QjpvF2nS7yc93?=
 =?us-ascii?Q?OP09xp+sqFGt0Qt4YDVnHwjFpa2hJ/WfLZSKzt0+nI8Y3iiT8tkgzSBjxdX7?=
 =?us-ascii?Q?14wLl55ccxLuswrtobiTM8p9Wpa5op7wa+hUNDE/89iBRDeUe4yJbpGEkuTO?=
 =?us-ascii?Q?LLdZ5JPhVDopvtCCkgHhEHgYJJuIhSzlJKqqE0xwsYOyuspUrV42Q5BJ2/gj?=
 =?us-ascii?Q?eiH3zzcdFcILPu4oXYg+wK5/iWqAjNHk5IRqiGd+9OOW1DVdxBS8woxWA10f?=
 =?us-ascii?Q?pypsGzvAMlrR80P8LOQh0OZIrIgTCU21hPZPZKWr+9LdaAdS5vsTr/5UM4Nm?=
 =?us-ascii?Q?EqH7/uhPl8sZMLb5i6z02VcNyDgOQMzWvj4ax45hXYN5OdQBHOiyNer4pm9I?=
 =?us-ascii?Q?TNDDbp9Vlpb1PAopiACdWyM42cpu7FW22e0jDJjBnn0kS51VkxD9n+Z0TwZF?=
 =?us-ascii?Q?Iob4RdqD2evpSiQocPhhkty3sOWM3wvuGrzJEaiGJA1iGIWh3wHk+C+VnpZF?=
 =?us-ascii?Q?ImGcJEst4POfvLHX2fUEj8nEMO4o6kvkd2+PhGo0sh0lGhpqSjcuLS2vEgl2?=
 =?us-ascii?Q?xd3adDBIoIHry6xF+Ms4bDU7cbVih20Y2SBMEHBw39kXKL068i4KNGqWBf2G?=
 =?us-ascii?Q?6ZLC/lWcKHORFj6Sol6+rJPx6K8+TVMSlXICQJBFCB3Vs/8yhH4tIys3qnJM?=
 =?us-ascii?Q?tpiWfjLAb76zghfYqob6PFkmpRsxIKEoSUqh3dxSoDZ4GVdA74dm8YlOxQ5W?=
 =?us-ascii?Q?J7gFFCCQ18MeGVOcG6v/h2facHr4/qVQK+R4/flBSQz/4bHflR5BvoIx9BBK?=
 =?us-ascii?Q?Ug8THqoA383oc5Tnu34qQyO+GqMcdcfmZ1GQB5uhRsZjUU7oGgythTtk1xQX?=
 =?us-ascii?Q?Pyeq8rggJvV45cDdBKOu+5RpQICXW2flf3L0QIIEvxWPOY23u5N2kjxTgEFU?=
 =?us-ascii?Q?xSKh8czE+R0QdGyNhIWrERp6eUYcTWSbv12qR2dAan/0NYE3eoSR+s5GV4UU?=
 =?us-ascii?Q?fIjjDDTjTJ64p6JtfCU1eUF2q5lwgpIjcPdy9P7yfSq5y0e+Paiek4wCMwcf?=
 =?us-ascii?Q?sjdCNuMpj76dOxYsN8a6vanvFb5PJ59ePoug0l0o6shubrf2vlHTd4yZJn10?=
 =?us-ascii?Q?73fid5c4bmLzyipCONL2LV/isaWogPMVHCGQtCRWQ4EwE7tRMThr62xw6L0l?=
 =?us-ascii?Q?PHW526+Ovy7oBX80JwJMyfln7n+H3WwDY7cAe7ccZyWMCguakO4N9jLJq4sb?=
 =?us-ascii?Q?FCzVpOGK0hX4ELjzFwhybFvSAoQfXmAWpDop1D3TQPE5HeVi0K9jjX/uTMHc?=
 =?us-ascii?Q?sLfB7CqK60uAG3lvI3Yu4a3tf941nY4sqYHw3ARWCYQtf0Ui1vAw6eNScvr7?=
 =?us-ascii?Q?OvjXegf1SHbxeA4GrH6xWep9UxdU3nEYloZRZVL5Zka2pQetQ8Pg2LGuA5Gd?=
 =?us-ascii?Q?a3xKSUVHVBzxxnNe2DiOa3x1lt6BWwJ0Ve0TZCudKLmb186PRiSkR41tmenA?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 883c46c6-4a24-4bc6-66a9-08daa8424900
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 08:59:47.7104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mQs0moldYwmlnc9qxCdLKvCWaPSJQyLCOuTqV6ASzz+tKn1hrlC6D2hT1RgdJJ/Jcn5KnWWMKnGGFxkuUPTHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9664

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 06, 2022 at 05:16:55PM -0700, Mat Martineau wrote:
> On Thu, 6 Oct 2022, Geliang Tang wrote:
> 
> > v5:
> > - address Mat's comments in v4.
> 
> Hi Geliang -
> 
> Thanks for the v5. I haven't finished looking over all the patches in detail
> yet, but two things I do want to reply to right now:
> 
>  * Thanks for explaining in patch 4 that last_snd is still useful for round
> robin. I had forgotten about that, and it looked like a "write-only"
> variable in the kernel code.
> 
>  * In the meeting today Paolo suggested that a good test for the new
> scheduler loop would be to modify simult_flows.sh to use much larger files,
> then see if the modified code slowed down any of the simult_flows tests.
> 
> He suggested making the test file 10x larger in simult_flows.sh:
> 
> -	size=$((2 * 2048 * 4096))
> +	size=$((2 * 2048 * 4096 * 10))
> 
> Can you compare the test times between the export branch and this series,
> with both of them using the larger file size?

10x larger failed in my tests with timeout. So I changed it to 5x
larger.

Here's the patch:

@@ -52,7 +52,7 @@ setup()
 	sout=$(mktemp)
 	cout=$(mktemp)
 	capout=$(mktemp)
-	size=$((2 * 2048 * 4096))
+	size=$((2 * 2048 * 4096 * 5))

 	dd if=/dev/zero of=$small bs=4096 count=20 >/dev/null 2>&1
 	dd if=/dev/zero of=$large bs=4096 count=$((size / 4096)) >/dev/null 2>&1
@@ -210,13 +210,13 @@ do_transfer()
 	fi

 	echo " [ fail ]"
-	echo "client exit code $retc, server $rets" 1>&2
-	echo -e "\nnetns ${ns3} socket stat for $port:" 1>&2
-	ip netns exec ${ns3} ss -nita 1>&2 -o "sport = :$port"
-	echo -e "\nnetns ${ns1} socket stat for $port:" 1>&2
-	ip netns exec ${ns1} ss -nita 1>&2 -o "dport = :$port"
-	ls -l $sin $cout
-	ls -l $cin $sout
+	#echo "client exit code $retc, server $rets" 1>&2
+	#echo -e "\nnetns ${ns3} socket stat for $port:" 1>&2
+	#ip netns exec ${ns3} ss -nita 1>&2 -o "sport = :$port"
+	#echo -e "\nnetns ${ns1} socket stat for $port:" 1>&2
+	#ip netns exec ${ns1} ss -nita 1>&2 -o "dport = :$port"
+	#ls -l $sin $cout
+	#ls -l $cin $sout

 	cat "$capout"
 	return 1

All logs are attached. "5x_10times_export.log" is for the export branch
and "5x_10times_refactor_v5.log" is for this series.

Thanks,
-Geliang

> 
> 
> Thanks,
> 
> Mat
> 
> 
> > 
> > v4:
> > - update __mptcp_subflow_push_pending as Mat suggested.
> > - add more patches from "BPF redundant scheduler" series.
> > 
> > v3:
> > - add a cleanup patch.
> > - remove msk->last_snd in mptcp_subflow_get_send().
> > - add the loop that calls the scheduler again in __mptcp_push_pending().
> > 
> > v2:
> > - add snd_burst check in dfrags loop as Mat suggested.
> > 
> > Refactor __mptcp_push_pending() and __mptcp_subflow_push_pending() to
> > remove duplicate code and support redundant scheduler more easily in
> > __mptcp_subflow_push_pending().
> > 
> > Geliang Tang (11):
> >  Squash to "mptcp: add get_subflow wrappers"
> >  mptcp: 'first' argument for subflow_push_pending
> >  mptcp: refactor push_pending logic
> >  mptcp: drop last_snd for burst scheduler
> >  mptcp: simplify push_pending
> >  mptcp: multi subflows push_pending
> >  mptcp: use msk instead of mptcp_sk
> >  mptcp: refactor subflow_push_pending logic
> >  mptcp: simplify subflow_push_pending
> >  mptcp: multi subflows subflow_push_pending
> >  mptcp: multi subflows retrans support
> > 
> > net/mptcp/pm.c         |   9 +-
> > net/mptcp/pm_netlink.c |   3 -
> > net/mptcp/protocol.c   | 285 ++++++++++++++++++++++-------------------
> > net/mptcp/protocol.h   |   5 +-
> > net/mptcp/sched.c      |  61 +++++----
> > 5 files changed, 184 insertions(+), 179 deletions(-)
> > 
> > -- 
> > 2.35.3
> > 
> > 
> > 
> 
> --
> Mat Martineau
> Intel

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="5x_10times_export.log"

1

balanced bwidth                                             transfer slower than expected! runtime 36150 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth - reverse direction                         transfer slower than expected! runtime 36135 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay                       transfer slower than expected! runtime 36087 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay - reverse direction   transfer slower than expected! runtime 36103 ms, expected 36005 ms max 36005       [ fail ]
unbalanced bwidth                                           18173 max 18227      [ OK ]
unbalanced bwidth - reverse direction                       transfer slower than expected! runtime 18284 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with unbalanced delay                     18160 max 18227      [ OK ]
unbalanced bwidth with unbalanced delay - reverse direction 18169 max 18227      [ OK ]
unbalanced bwidth with opposed, unbalanced delay            transfer slower than expected! runtime 18349 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with opposed, unbalanced delay - reverse direction18170 max 18227      [ OK ]

2

balanced bwidth                                             transfer slower than expected! runtime 36085 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth - reverse direction                         transfer slower than expected! runtime 36095 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay                       transfer slower than expected! runtime 36104 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay - reverse direction   transfer slower than expected! runtime 36106 ms, expected 36005 ms max 36005       [ fail ]
unbalanced bwidth                                           transfer slower than expected! runtime 18364 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth - reverse direction                       transfer slower than expected! runtime 18272 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with unbalanced delay                     transfer slower than expected! runtime 18246 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with unbalanced delay - reverse direction 18150 max 18227      [ OK ]
unbalanced bwidth with opposed, unbalanced delay            18216 max 18227      [ OK ]
unbalanced bwidth with opposed, unbalanced delay - reverse direction18199 max 18227      [ OK ]

3

balanced bwidth                                             transfer slower than expected! runtime 36114 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth - reverse direction                         transfer slower than expected! runtime 36082 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay                       transfer slower than expected! runtime 36125 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay - reverse direction   transfer slower than expected! runtime 36093 ms, expected 36005 ms max 36005       [ fail ]
unbalanced bwidth                                           18198 max 18227      [ OK ]
unbalanced bwidth - reverse direction                       transfer slower than expected! runtime 18431 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with unbalanced delay                     transfer slower than expected! runtime 18312 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with unbalanced delay - reverse direction 18197 max 18227      [ OK ]
unbalanced bwidth with opposed, unbalanced delay            transfer slower than expected! runtime 18284 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with opposed, unbalanced delay - reverse directiontransfer slower than expected! runtime 18450 ms, expected 18227 ms max 18227       [ fail ]

4

balanced bwidth                                             transfer slower than expected! runtime 36111 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth - reverse direction                         transfer slower than expected! runtime 36112 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay                       transfer slower than expected! runtime 36126 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay - reverse direction   transfer slower than expected! runtime 36106 ms, expected 36005 ms max 36005       [ fail ]
unbalanced bwidth                                           18217 max 18227      [ OK ]
unbalanced bwidth - reverse direction                       18214 max 18227      [ OK ]
unbalanced bwidth with unbalanced delay                     transfer slower than expected! runtime 18366 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with unbalanced delay - reverse direction transfer slower than expected! runtime 18347 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with opposed, unbalanced delay            18218 max 18227      [ OK ]
unbalanced bwidth with opposed, unbalanced delay - reverse directiontransfer slower than expected! runtime 18459 ms, expected 18227 ms max 18227       [ fail ]

5

balanced bwidth                                             transfer slower than expected! runtime 36128 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth - reverse direction                         transfer slower than expected! runtime 36106 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay                       transfer slower than expected! runtime 36125 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay - reverse direction   transfer slower than expected! runtime 36108 ms, expected 36005 ms max 36005       [ fail ]
unbalanced bwidth                                           18172 max 18227      [ OK ]
unbalanced bwidth - reverse direction                       transfer slower than expected! runtime 18288 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with unbalanced delay                     transfer slower than expected! runtime 18312 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with unbalanced delay - reverse direction transfer slower than expected! runtime 18265 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with opposed, unbalanced delay            transfer slower than expected! runtime 18344 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with opposed, unbalanced delay - reverse direction18133 max 18227      [ OK ]

6

balanced bwidth                                             transfer slower than expected! runtime 36114 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth - reverse direction                         transfer slower than expected! runtime 36085 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay                       transfer slower than expected! runtime 36156 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay - reverse direction   transfer slower than expected! runtime 36109 ms, expected 36005 ms max 36005       [ fail ]
unbalanced bwidth                                           transfer slower than expected! runtime 18345 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth - reverse direction                       transfer slower than expected! runtime 18409 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with unbalanced delay                     18167 max 18227      [ OK ]
unbalanced bwidth with unbalanced delay - reverse direction transfer slower than expected! runtime 18317 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with opposed, unbalanced delay            18178 max 18227      [ OK ]
unbalanced bwidth with opposed, unbalanced delay - reverse direction18163 max 18227      [ OK ]

7

balanced bwidth                                             transfer slower than expected! runtime 36150 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth - reverse direction                         transfer slower than expected! runtime 36087 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay                       transfer slower than expected! runtime 36108 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay - reverse direction   transfer slower than expected! runtime 36082 ms, expected 36005 ms max 36005       [ fail ]
unbalanced bwidth                                           transfer slower than expected! runtime 18292 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth - reverse direction                       transfer slower than expected! runtime 18442 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with unbalanced delay                     transfer slower than expected! runtime 18283 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with unbalanced delay - reverse direction 18203 max 18227      [ OK ]
unbalanced bwidth with opposed, unbalanced delay            18218 max 18227      [ OK ]
unbalanced bwidth with opposed, unbalanced delay - reverse directiontransfer slower than expected! runtime 18383 ms, expected 18227 ms max 18227       [ fail ]

8

balanced bwidth                                             transfer slower than expected! runtime 36090 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth - reverse direction                         transfer slower than expected! runtime 36089 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay                       transfer slower than expected! runtime 36106 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay - reverse direction   transfer slower than expected! runtime 36101 ms, expected 36005 ms max 36005       [ fail ]
unbalanced bwidth                                           transfer slower than expected! runtime 18271 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth - reverse direction                       transfer slower than expected! runtime 18267 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with unbalanced delay                     transfer slower than expected! runtime 18330 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with unbalanced delay - reverse direction transfer slower than expected! runtime 18323 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with opposed, unbalanced delay            transfer slower than expected! runtime 18332 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with opposed, unbalanced delay - reverse directiontransfer slower than expected! runtime 18357 ms, expected 18227 ms max 18227       [ fail ]

9

balanced bwidth                                             transfer slower than expected! runtime 36134 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth - reverse direction                         transfer slower than expected! runtime 36108 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay                       transfer slower than expected! runtime 36110 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay - reverse direction   transfer slower than expected! runtime 36077 ms, expected 36005 ms max 36005       [ fail ]
unbalanced bwidth                                           transfer slower than expected! runtime 18256 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth - reverse direction                       transfer slower than expected! runtime 18232 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with unbalanced delay                     transfer slower than expected! runtime 18265 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with unbalanced delay - reverse direction 18211 max 18227      [ OK ]
unbalanced bwidth with opposed, unbalanced delay            transfer slower than expected! runtime 18389 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with opposed, unbalanced delay - reverse direction18165 max 18227      [ OK ]

10

balanced bwidth                                             transfer slower than expected! runtime 36113 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth - reverse direction                         transfer slower than expected! runtime 36089 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay                       transfer slower than expected! runtime 36092 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay - reverse direction   transfer slower than expected! runtime 36103 ms, expected 36005 ms max 36005       [ fail ]
unbalanced bwidth                                           transfer slower than expected! runtime 18413 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth - reverse direction                       18162 max 18227      [ OK ]
unbalanced bwidth with unbalanced delay                     18139 max 18227      [ OK ]
unbalanced bwidth with unbalanced delay - reverse direction transfer slower than expected! runtime 18349 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with opposed, unbalanced delay            transfer slower than expected! runtime 18256 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with opposed, unbalanced delay - reverse directiontransfer slower than expected! runtime 18540 ms, expected 18227 ms max 18227       [ fail ]

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="5x_10times_refactor_v5.log"


1

balanced bwidth                                             transfer slower than expected! runtime 36095 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth - reverse direction                         transfer slower than expected! runtime 36168 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay                       transfer slower than expected! runtime 36112 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay - reverse direction   transfer slower than expected! runtime 36120 ms, expected 36005 ms max 36005       [ fail ]
unbalanced bwidth                                           transfer slower than expected! runtime 18235 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth - reverse direction                       transfer slower than expected! runtime 18445 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with unbalanced delay                     transfer slower than expected! runtime 18310 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with unbalanced delay - reverse direction transfer slower than expected! runtime 18299 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with opposed, unbalanced delay            transfer slower than expected! runtime 18388 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with opposed, unbalanced delay - reverse directiontransfer slower than expected! runtime 18493 ms, expected 18227 ms max 18227       [ fail ]

2

balanced bwidth                                             transfer slower than expected! runtime 36134 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth - reverse direction                         transfer slower than expected! runtime 36202 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay                       transfer slower than expected! runtime 36174 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay - reverse direction   transfer slower than expected! runtime 36145 ms, expected 36005 ms max 36005       [ fail ]
unbalanced bwidth                                           18144 max 18227      [ OK ]
unbalanced bwidth - reverse direction                       transfer slower than expected! runtime 18329 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with unbalanced delay                     transfer slower than expected! runtime 18281 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with unbalanced delay - reverse direction transfer slower than expected! runtime 18512 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with opposed, unbalanced delay            transfer slower than expected! runtime 18297 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with opposed, unbalanced delay - reverse directiontransfer slower than expected! runtime 18361 ms, expected 18227 ms max 18227       [ fail ]

3

balanced bwidth                                             transfer slower than expected! runtime 36186 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth - reverse direction                         transfer slower than expected! runtime 36166 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay                       transfer slower than expected! runtime 36157 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay - reverse direction   transfer slower than expected! runtime 36185 ms, expected 36005 ms max 36005       [ fail ]
unbalanced bwidth                                           18207 max 18227      [ OK ]
unbalanced bwidth - reverse direction                       transfer slower than expected! runtime 18270 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with unbalanced delay                     18148 max 18227      [ OK ]
unbalanced bwidth with unbalanced delay - reverse direction transfer slower than expected! runtime 18247 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with opposed, unbalanced delay            transfer slower than expected! runtime 18405 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with opposed, unbalanced delay - reverse directiontransfer slower than expected! runtime 18495 ms, expected 18227 ms max 18227       [ fail ]

4

balanced bwidth                                             transfer slower than expected! runtime 36128 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth - reverse direction                         transfer slower than expected! runtime 36145 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay                       transfer slower than expected! runtime 36176 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay - reverse direction   transfer slower than expected! runtime 36109 ms, expected 36005 ms max 36005       [ fail ]
unbalanced bwidth                                           transfer slower than expected! runtime 18355 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth - reverse direction                       transfer slower than expected! runtime 18521 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with unbalanced delay                     18203 max 18227      [ OK ]
unbalanced bwidth with unbalanced delay - reverse direction transfer slower than expected! runtime 18282 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with opposed, unbalanced delay            transfer slower than expected! runtime 18473 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with opposed, unbalanced delay - reverse directiontransfer slower than expected! runtime 18415 ms, expected 18227 ms max 18227       [ fail ]

5

balanced bwidth                                             transfer slower than expected! runtime 36131 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth - reverse direction                         transfer slower than expected! runtime 36167 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay                       transfer slower than expected! runtime 36173 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay - reverse direction   transfer slower than expected! runtime 36143 ms, expected 36005 ms max 36005       [ fail ]
unbalanced bwidth                                           18182 max 18227      [ OK ]
unbalanced bwidth - reverse direction                       transfer slower than expected! runtime 18377 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with unbalanced delay                     18184 max 18227      [ OK ]
unbalanced bwidth with unbalanced delay - reverse direction transfer slower than expected! runtime 18274 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with opposed, unbalanced delay            18151 max 18227      [ OK ]
unbalanced bwidth with opposed, unbalanced delay - reverse directiontransfer slower than expected! runtime 18450 ms, expected 18227 ms max 18227       [ fail ]

6

balanced bwidth                                             transfer slower than expected! runtime 36129 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth - reverse direction                         transfer slower than expected! runtime 36199 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay                       transfer slower than expected! runtime 36133 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay - reverse direction   transfer slower than expected! runtime 36158 ms, expected 36005 ms max 36005       [ fail ]
unbalanced bwidth                                           18133 max 18227      [ OK ]
unbalanced bwidth - reverse direction                       transfer slower than expected! runtime 18488 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with unbalanced delay                     transfer slower than expected! runtime 18334 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with unbalanced delay - reverse direction transfer slower than expected! runtime 18457 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with opposed, unbalanced delay            transfer slower than expected! runtime 18379 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with opposed, unbalanced delay - reverse directiontransfer slower than expected! runtime 18271 ms, expected 18227 ms max 18227       [ fail ]

7

balanced bwidth                                             transfer slower than expected! runtime 36135 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth - reverse direction                         transfer slower than expected! runtime 36119 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay                       transfer slower than expected! runtime 36131 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay - reverse direction   transfer slower than expected! runtime 36112 ms, expected 36005 ms max 36005       [ fail ]
unbalanced bwidth                                           transfer slower than expected! runtime 18344 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth - reverse direction                       transfer slower than expected! runtime 18378 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with unbalanced delay                     18145 max 18227      [ OK ]
unbalanced bwidth with unbalanced delay - reverse direction transfer slower than expected! runtime 18434 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with opposed, unbalanced delay            transfer slower than expected! runtime 18612 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with opposed, unbalanced delay - reverse directiontransfer slower than expected! runtime 18535 ms, expected 18227 ms max 18227       [ fail ]

8

balanced bwidth                                             transfer slower than expected! runtime 36158 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth - reverse direction                         transfer slower than expected! runtime 36180 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay                       transfer slower than expected! runtime 36108 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay - reverse direction   transfer slower than expected! runtime 36136 ms, expected 36005 ms max 36005       [ fail ]
unbalanced bwidth                                           18183 max 18227      [ OK ]
unbalanced bwidth - reverse direction                       transfer slower than expected! runtime 18352 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with unbalanced delay                     18151 max 18227      [ OK ]
unbalanced bwidth with unbalanced delay - reverse direction transfer slower than expected! runtime 18423 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with opposed, unbalanced delay            transfer slower than expected! runtime 18333 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with opposed, unbalanced delay - reverse directiontransfer slower than expected! runtime 18373 ms, expected 18227 ms max 18227       [ fail ]

9

balanced bwidth                                             transfer slower than expected! runtime 36123 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth - reverse direction                         transfer slower than expected! runtime 36152 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay                       transfer slower than expected! runtime 36112 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay - reverse direction   transfer slower than expected! runtime 36128 ms, expected 36005 ms max 36005       [ fail ]
unbalanced bwidth                                           transfer slower than expected! runtime 18267 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth - reverse direction                       transfer slower than expected! runtime 18311 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with unbalanced delay                     18167 max 18227      [ OK ]
unbalanced bwidth with unbalanced delay - reverse direction transfer slower than expected! runtime 18294 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with opposed, unbalanced delay            transfer slower than expected! runtime 18279 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with opposed, unbalanced delay - reverse directiontransfer slower than expected! runtime 18392 ms, expected 18227 ms max 18227       [ fail ]

10

balanced bwidth                                             transfer slower than expected! runtime 36152 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth - reverse direction                         transfer slower than expected! runtime 36164 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay                       transfer slower than expected! runtime 36172 ms, expected 36005 ms max 36005       [ fail ]
balanced bwidth with unbalanced delay - reverse direction   transfer slower than expected! runtime 36170 ms, expected 36005 ms max 36005       [ fail ]
unbalanced bwidth                                           transfer slower than expected! runtime 18345 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth - reverse direction                       transfer slower than expected! runtime 18317 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with unbalanced delay                     transfer slower than expected! runtime 18367 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with unbalanced delay - reverse direction transfer slower than expected! runtime 18407 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with opposed, unbalanced delay            transfer slower than expected! runtime 18444 ms, expected 18227 ms max 18227       [ fail ]
unbalanced bwidth with opposed, unbalanced delay - reverse directiontransfer slower than expected! runtime 18489 ms, expected 18227 ms max 18227       [ fail ]

--NzB8fVQJ5HfG6fxh--
