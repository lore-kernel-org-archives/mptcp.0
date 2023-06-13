Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2041.outbound.protection.outlook.com [40.107.6.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2828361
	for <mptcp@lists.linux.dev>; Tue, 13 Jun 2023 05:36:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7cAlpK0uAf2ZZ/aYwjtw3r9JUdtv6efdrOKiOg/6RguSMtGL7uZlOM7MM7kz311tQckZd2ssc0p6zJva0Qxwpp6cQINe8vjd45nnzE7Pwpm8XLTiNjB2Mm3XSURgiDcjBf3ByAKvqkqN4eJ/l3ER9bhytRztmjIx9ohK07S4DZ2I3mZPk6Y/+soBkLvkjglcciZehyF2J6Ci6ENt7vOHUca0whezjLtTbRP/4aaHlgd3ozyd/rNyrohcVEj5R8RpTA+Z+hZ3H76RvlS3OFBdi7rx+LCbSNegeqfPhy5U9e9B87a/h1vZeF0rAoc67q63Eu5jd5udfIAaz1M465/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5xDCeryVPUmRP84jNCzKwNM0SPy54vOOM71VX5fppk=;
 b=GyzpNl59BzPJNKlfuvowyMoQ7PwDaw+wzI3oLbK/VCPoVUBa4cNd/YeG3FH4wuUs2lGzIXRuqsWt/DsKus2zYCgh0qoG//pzFjfOKkph5jSb9Ejir5/nxso18UZqKROjh8DFd8KONTC3C1QZ7qqvFOAz6e5d8m7BQed9j8zOvVNX36f92HYOk4PT/nFmhWuhJsyg412xfAzFbWvK9NVb51HU7UCGmdKN9UGnusnZpzswbQhMn6MGNFL14ylT2fbCLxyOIUBvJW+O4Sa/4v69UAecTDi2Fg5nwha3JE/LFhazEmKGcrQoHJ9oHcgilAr/BIEPqc/9PhRUYjmdnUrGKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5xDCeryVPUmRP84jNCzKwNM0SPy54vOOM71VX5fppk=;
 b=rr/08ffflvJnkRa+U0fzX/k4wfE8hnP09rg8PReVOfkwU3WH13Lviuz+3imYHVqTbjv6Cl3Ge/0Zda9GIxfhBgYJI7GJiKH7DbgpelDIn5yPFt2s9dEIn2OkcJ2FZOLxU2fVcafBKkKRX0kDCwLWOkWb/6pCSAQYlTvAR0RQ+JFt4zuihD/yYXMzxNJ8JkSaZNd7JaTUGTun9ergkuJIyF25rpV87wEfExZ2Dw2R8IB2+g1L43Zh4E0kEcCKGiJgN84YJvVnxMRiK3EdpXCYfiUxqCtm0fc11c32XkT2r6M+2AZKn6OQV8ymYubQcAxC3ASxHu+A7OOOjdrafqE1Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DBBPR04MB7642.eurprd04.prod.outlook.com (2603:10a6:10:207::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Tue, 13 Jun
 2023 05:36:09 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 05:36:08 +0000
Date: Tue, 13 Jun 2023 13:36:00 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v8 13/17] selftests/bpf: Add bpf_burst
 scheduler
Message-ID: <20230613053600.GA1395@bogon>
References: <cover.1686202841.git.geliang.tang@suse.com>
 <bf747921efceb7f066a75cb2dae2ab46071b8275.1686202841.git.geliang.tang@suse.com>
 <666004bda6ff9e3e6d65c6903c5b18f18f0e31ed.camel@redhat.com>
 <20230609133236.GA30403@localhost>
 <4d34b373094d8415d8d6cc29af013dc508a5bf81.camel@redhat.com>
 <20230610014514.GA2843@localhost>
 <5336efd2153d4667f9d0aea52b6d67ed2685ddbf.camel@redhat.com>
 <20230612132934.GA9248@localhost>
 <45ff221dfa3fce66e12bd76737c2dea8eeed7e00.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45ff221dfa3fce66e12bd76737c2dea8eeed7e00.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: TYCPR01CA0096.jpnprd01.prod.outlook.com
 (2603:1096:405:3::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DBBPR04MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f298ae0-abc4-4903-0ed5-08db6bd016d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5KOMcuFhjtiuJ9GMYiCkgVMvRkWsgnWhlqcgGTH6nsbvCx1E8B8jcGpRqIBjD2qjuyy5BxWHiep28sle8H0vBvfy2iXi+S2XUm2BM9VzWxmWKceh+gHjW/0DLv1XjL+C7SsjXe2hFeK5xPgEKDbzc6x8cT63Pzsnr6azm8ztoxpIOaXaoN66vjqKeMbJGpelcnWC4yKIHKePluN3P50fqy6YKCIQWcgaqFG29N/FY2xGbKHRnsg0RcYd+fEf+ga/laKxmZ6PlriXO5VgFuLKbvqonrvN2dge/PzY+ofoIqZgF6AACj2nkuSHPYE/ZgxNbuVlNhMRfDHy24TkRivkuMno8UCNUMiCcvfxgcFEt87jn0m9V69h6pCiVxN+wA60fHrjPinZ9fUkUsOjURz8bCRBd+peYnne5YasovyYSEC7fUBNcBYCPvmLuPJJBQgs7ro8x1xh4KNV4G18Bfq61UAiuAMyaeNaje9tFB4YVAK15KlE+fVQ4YlpkQs9RufQF2aoWgw96rH/tgzoPud9tsjohQtUZI3Ktpl8Zl+7eA+VYZZN6GUVLKSK2HA+P6Vs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199021)(8936002)(44832011)(8676002)(5660300002)(4326008)(66946007)(6916009)(66476007)(66556008)(316002)(2906002)(41300700001)(966005)(6666004)(478600001)(6486002)(9686003)(1076003)(6506007)(6512007)(33656002)(83380400001)(186003)(26005)(33716001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3hnQXdaTFZQMW8wYVliNGszU0haMmV4MXZ6SURIQmJvWjFhbFhjNnJ0czFF?=
 =?utf-8?B?TTJwYVVXd1VVeUx0ZzY2K1JHT0xYUkl3RmtoVzd0amVkMFo3SnExb0VtUVpS?=
 =?utf-8?B?NEk5MVhOMTlVQjFVOWtET24vTk0vVldxK2RYSlVCU3czbkhYTWNMOWpSQy9I?=
 =?utf-8?B?bmQ5Vk5wYmJaSTdMdnBuNUc5MW16VlczSmVOb0d0azh6aXQ0R2dmMlQ5Tytr?=
 =?utf-8?B?R2R2ZFR2WllxTzdjQWthY0tJb2x2T3krY3BYZkZVV1VaTC90bTRZanBWQjdL?=
 =?utf-8?B?VVl2NGZmaTVWWmlKN1hGcHVJQm5JRlJqdW5iNDEzdVNteUpVMTgwekFXQ3pZ?=
 =?utf-8?B?cDViNEhIVHhwQjBsQnpPVGg3YThUR0NVM0svbTA1ZVRCdk9zb3JSV0hONHBB?=
 =?utf-8?B?UlJLTVlacmVzdVdpYko1Tjk3V1UrVEhmQW5KclFVVXVZRFdGaktCcUxHbjRW?=
 =?utf-8?B?QkduVWJoVTFOcXhNdzM0Y3M4YjdlMXBtNEw1c2JEK3ZjcjhJeUUveXMyeGM4?=
 =?utf-8?B?MXdNbTM2UHovdDdwcGYzbldkSjZ1Mk9IZmVqWDZiZ2hOUU45MWNVSWErajJs?=
 =?utf-8?B?aTVVL3I2WUhQYmdjcWdOL2oyNWNWYWczTXNqRkp4VlNjK3JJYVgwb1hjS3pU?=
 =?utf-8?B?dmtaUUJUWW9xQjk5VkpYbjFPVlpYUko2QjJJZnEyOXpzc2lzbHBOMmJvYm9x?=
 =?utf-8?B?VFZPcWRMSm5rOHd0cjJYUUluRThJcE01WldPN3VDZHJHSXRSTlA5YVlvNkVH?=
 =?utf-8?B?MUJ2SzY2NUkzU1RLTkFXaSsrenhzUFdqdC9BcHdMTStnVzdtYXoxVExzNDZa?=
 =?utf-8?B?T3M1bDB4ZXZEU05yMlpOQWVBWVpWY0RVeUVkdnZ2K09ueU83QVJTQ24xdHU0?=
 =?utf-8?B?VTZaWWxMdEZFdjZDZW9xL05FWE53N3B1WDZWZ2xZaFN1TXRnWnNsTGVFRGhO?=
 =?utf-8?B?TWhHWlNpNGk4bXFaUm9BRTdHaVJDRzRIVzBTRE1qb1ROb0lHWlpRRmVzc0wy?=
 =?utf-8?B?VVV1UlhMT3NRNEUxVlV3SHo2TWxQeCtrU2kvZFJ0NDJNcWJJY2ttVDFDY1Qy?=
 =?utf-8?B?MzY2dDdkZXZlUHhaK0JYYU5YYTRlUFRrNmtBa2xRZ1l1UWdJUjdEdVBlbU9l?=
 =?utf-8?B?WE5zNWQ1UWRYTkI5NHRvNWZzbU5kaUMwVEQrVW95Q01zOWg5bGxIYXVoNy9J?=
 =?utf-8?B?WUN4TEx4dEJvMFVkTmx4YS9oeWg5ayt4dSt5L3Rna0tqWTRteUkyUGNkem5t?=
 =?utf-8?B?ZGFFbVVYNlBhMlE5WXJKUjhyVEhUQlpjSjk0aUxEa0o1Vm1tTDE3VkkrN2My?=
 =?utf-8?B?K0R5dnBRd0cxM1AvM3hzbm0yYkxLMnRuQmpTT2lmSHIrcVA3Qk82ZGFqdmFC?=
 =?utf-8?B?RWhtSzFYMnc3U09tdWxYSngra3FCMUtuTzVQK2IxSlRqOTVaOXA2ZHlIYlpj?=
 =?utf-8?B?b1M2cEFiZmNQeWJsVzhybGlYb3ZMR3pXM3pQSnJDbVJtcFpSRFZraTFYalJz?=
 =?utf-8?B?QkRUMEd6d2hvVW5Pd0VvemtXVHRkQkhjUkZ1bHBFeUMyYi9jeVYvSTBJL25h?=
 =?utf-8?B?YzI1WXFnWGdMUVlPbmE5MG5mUGsvY3U0OThnZEdkVTRMcWNaS2pVMGlTLzJq?=
 =?utf-8?B?MEZGVm51NThJTEZ2WUFBeGhQTGVTbHZqUE05UEc0YXFDSk1NRmdjdng0VkVJ?=
 =?utf-8?B?UGE2TG1VRENHa0FRM09sNmE3VHNBYkdVN1VUeGltL3lFQTUzWXgzOTRlR3Iv?=
 =?utf-8?B?VG1zdVZjV2tpUnMyNVY2VHJBbjVTdFBuN3pCalZyNHFCOVlGWmtEMTBXZDZM?=
 =?utf-8?B?V0s3eUdjZnNQMzZYMkx0Sk9GODhwRENqUXZ5em5TeGYvb2YxZHdtRHBoYmJP?=
 =?utf-8?B?M0NOUjVPTzgvd3l2aGZtejRXZGlpbytZWFJwUW0rSlZRWGg4V0ZqV3J0dGZC?=
 =?utf-8?B?VjNPMTZQZEFsM2IyTXhFdENLVXMyaDh2bjBKWm1sYzg1bEJyZGxEUGVHV0Fk?=
 =?utf-8?B?dnQ0TkZXMWt3ZDVNdzhrNzFqSy94VXdOTHRaZEdwZ3BibzRPMWZFRGJBRzMw?=
 =?utf-8?B?T3U5alg1cFpwVXpLN0VlZkQxVTJUT3h3NFNUYit5Zk11OFhyKzhUNytTSmVO?=
 =?utf-8?Q?blW2azy+7+uPMCyWF+VmTIbjl?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f298ae0-abc4-4903-0ed5-08db6bd016d5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 05:36:08.7574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68IeQyvPci8LWfMmlUSCYMPqj7iQXZgs0IbXQh5IcDv5CZP412Nr/gHmJE+AD0D/AEYLrP8kvo8nydSlwWY4OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7642

On Mon, Jun 12, 2023 at 04:22:31PM +0200, Paolo Abeni wrote:
> On Mon, 2023-06-12 at 21:29 +0800, Geliang Tang wrote:
> > On Mon, Jun 12, 2023 at 01:05:30PM +0200, Paolo Abeni wrote:
> > > On Sat, 2023-06-10 at 09:45 +0800, Geliang Tang wrote:
> > > > On Fri, Jun 09, 2023 at 04:40:01PM +0200, Paolo Abeni wrote:
> > > > > On Fri, 2023-06-09 at 21:32 +0800, Geliang Tang wrote:
> > > > > > On Fri, Jun 09, 2023 at 11:57:53AM +0200, Paolo Abeni wrote:
> > > > > > 
> > > > > > > May I guess you get a similar error if you do:
> > > > > > > 
> > > > > > > 	subflow = mptcp_subflow_ctx(ssk)
> > > > > > > 
> > > > > > > ? (just out of sheer ignorance and curiosity)
> > > > > > 
> > > > > > Yes. It seems that accessing 'send_info[SSK_MODE_ACTIVE].ssk' is
> > > > > > considered unsafe in BPF context. So here we pass 'send_info[SSK_MODE_ACTIVE].ssk'
> > > > > > into bpf_mptcp_subflow_ctx() to find the related subflow. Then we access this
> > > > > > subflow instead of 'send_info[SSK_MODE_ACTIVE].ssk' below. This can make BPF happy.
> > > > > > 
> > > > > > > 
> > > > > > > > +	 * then use mptcp_subflow_tcp_sock() to get the ssk.
> > > > > > > > +	 */
> > > > > > > > +	subflow = mptcp_subflow_tcp_sock(send_info[SSK_MODE_ACTIVE].ssk, data);
> > > > > > > > +	ssk = mptcp_subflow_tcp_sock(subflow);
> > > > > > > 
> > > > > > > What if you store the 'subflow' pointer in 'send_info'? Will the
> > > > > > > verifier splat with that? and what if we store the corresponding
> > > > > > > context index 'i' instead?
> > > > > > 
> > > > > > Storing the 'subflow' or index 'i' don't work too.
> > > > > 
> > > > > Uhmm... I'm very surprised about 'i'. Specifically what I mean is:
> > > > > 
> > > > > struct subflow_send_info {
> > > > > 	unsigned int subflow_id;
> > > > > 	__u64 linger_time;
> > > > > };
> > > > > 
> > > > > // ...
> > > > > 	for (i = 0; i < SSK_MODE_MAX; ++i) {
> > > > > 		send_info[i].ssk = MPTCP_SUBFLOWS_MAX;
> > > > > 		send_info[i].linger_time = -1;
> > > > > 	}
> > > > > // ...
> > > > > 
> > > > > 		if (linger_time < send_info[subflow->backup].linger_time) {
> > > > > 			send_info[subflow->backup].subflow_id = i;
> > > > > 			send_info[subflow->backup].linger_time = linger_time;
> > > > > 		}
> > > > > 
> > > > > // ...
> > > > > 	if (send_info[SSK_MODE_ACTIVE].subflow_id == MPTCP_SUBFLOWS_MAX)
> > > > > 		send_info[SSK_MODE_ACTIVE].subflow_id = send_info[SSK_MODE_BACKUP].subflow_id;
> > > > > 
> > > > > 	if (send_info[SSK_MODE_ACTIVE].subflow_id < MPTCP_SUBFLOWS_MAX)
> > > > > 		subflow = data->context[send_info[SSK_MODE_ACTIVE].subflow_id];
> > > > > 
> > > > > The last assignment should be equivalent to the already used 'subflow =
> > > > > data->contexts[i];'. What kind of errors do you see here?!? Could you
> > > > > please report them verbatim?
> > > > 
> > > > This line "subflow = data->context[send_info[SSK_MODE_ACTIVE].subflow_id];" will get a error:
> > > > 
> > > >   R2 is ptr_mptcp_sched_data invalid variable offset: off=16, var_off=(0x0; 0x38)
> > > 
> > > I see. This looks like a verifier-imposed artificial constraint.
> > > 
> > > Basically any access to:
> > > 
> > > btf_type.array_field[valid_and_validated_variable_index]
> > > 
> > > is not allowed.
> > > 
> > > The main point of having sched_data.context exposed to the pluggable
> > > scheduler via mptcp_sched_data is to avoid looping through the subflows
> > > to fetch a given one, I think. But the above verifier constraint
> > > basically prevents such usage.
> > > 
> > > I think we should add an helper into the core implementing the position
> > > (number) to subflow (context) mapping. e.g.:
> > > 
> > > struct mptcp_subflow_context *mptcp_subflow_ctx_by_pos(struct mptcp_sk *msk,
> > > 							unsigned int pos)
> > > {
> > > 	if (pos >= MPTCP_SUBFLOWS_MAX)
> > > 		return NULL;
> > > 
> > > 	return msk->sched_data.context[pos];
> > > }
> > > 
> > > And use such helper here instead of bpf_mptcp_subflow_ctx(). 
> > 
> > "return msk->sched_data.contexts[pos];" will get the same error:
> > 
> > R3 is ptr_mptcp_sock invalid variable offset: off=1880, var_off=(0x0; 0x38)
> 
> I'm sorry, I was not clear enough. I mean that the
> 'mptcp_subflow_ctx_by_pos()' helper must be implemented by the kernel
> and exported/made visible to eBPF. The verifier must not see that code.

Thanks Paolo, it works now. I updated the patch as a squash-to one and
sent it to the ML as 'Squash to "BPF packet scheduler updates v8"':

https://patchwork.kernel.org/project/mptcp/patch/8193bd590a4d811054a36f50a2aad79a02e8c137.1686620367.git.geliang.tang@suse.com/

-Geliang

> > > 
> > > There are a number of possible follow-ups to the above, not strictly
> > > related to this series, but IMHO needed before upstreaming this code:
> > > 
> > > -we could remove the 'context' array from the data directly visible to
> > > the ebpf code. 
> > > - Instead we could export to the scheduler the number of subflows
> > > currently present into the msk socket, so the scheduler itself will not
> > > have to always ask for all the MPTCP_SUBFLOWS_MAX possible subflows. 
> > 
> > This for loop in BPF will get the "invalid variable offset" error too:
> > 
> > for (int i = 0; i < number_of_subflows; i++)
> > 	contexts[i];
> > 
> > So we have to loop from 0 to MAX like this:
> > 
> > for (i = 0; i < SSK_MODE_MAX; i++)
> > 	contexts[i];
> 
> Yep, the error you reported in the previous email hinted that. As I
> wrote
> 
> """
> Basically any access to:
> 
> btf_type.array_field[valid_and_validated_variable_index]
> 
> is not allowed.
> """
> 
> The above should be:
> 
> 	for (int i=0; i < data->number_of_subflows; i++) {
> 		context = mptcp_subflow_ctx_by_pos(i);
> 		// ...
> 	}
> 
> 
> Cheers,
> 
> Paolo
> 
