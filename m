Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2057.outbound.protection.outlook.com [40.107.241.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2967A134B5
	for <mptcp@lists.linux.dev>; Mon, 12 Jun 2023 13:29:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RChqb/WxEisQxMit5eNtG1IQMfMCrAPlmtMWMBCxtrRCQhf0qHoJ7AAqnlXWgmUysgn/vNTJfF9XzbafpVvh2fUxZxKfn7Vl8hw8GN79MpQKO2kjbL2mARaPk7W2WlhnEJaMP2pFLeUSArRaQ5wLoPqSAjskqVQCDrvYB5DlJm74LPacI6NrEkMxvZCagrTHteRS42M8TngrU+AZV3rhk5tapvcwas1UGd2GcW1zJ0sQQEkFPLI72eHz/I5PRdwUhkUNorGynLjYc4/sBfajfn5U9mK2p+FYM3+2E/Z6fcMvM2ybjhBgfl/Sv/HZrkII7zOVliDcM8beLD3e0WZhOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yz20IzmWCXmE6klbEM27znxXlYglmvCebXFcOEBzex0=;
 b=NluxJmblqgWX28e69r+CgNMMIbVOEBfyFIwe9RGosptq7Pdgr3RBYaSY3UWvamHkXmhzv4f5/tNb2Y8mjtcryxB1feVgj9zt9mUt77f6fTIV5nvgg0HG5hu05AMBTocRExqR6CxSxF+Ti5+RexmVqfrLbdkDL53u+fFyGQ3/yoET5ZmVJ9Jh9LMM2SZ0X4imZ2tyAtlCS1w9nNe9Yi/yTbSESiJKbUqCJN3wO9ZV9hbGuhojWTBo0FMTvf+q5pkfwqseUXpt4e5LBzzP3u6ZiieOk0mNRBnyIOZ+CswmjGWw6FGGw3GTzLuoLg9g3WHwa+9hzbF4kNqzwezcn9v6UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yz20IzmWCXmE6klbEM27znxXlYglmvCebXFcOEBzex0=;
 b=vKbZ0FrDitGv+oHHVDg8O0AZkD+9IbN0wNyDjwh3WtYcQkPtWxX2LBTq65GvptNX/rmHIT23O7OKV3wK8iWiqfAOFkulgUNGP/ig8Q8VEyRpr+k4ljGgs3vHKza2JoTeoaAxO2jc0ui+E6uZJLw7w4uWrGoxVc2myZoCW1QdUPax8MyLHjBR1GWJtQrwbX0mgynuiH+UH1XrOggRAh+IPej0eChzvQdwF/TxpBtAc4c61UDgUX1My+/j+vG2UmSjtul7DQsDfm/PjVyn3Tp4wQqX0kMxeQtEWYnuXGHu4121aqsDmVJcy1OmJQY/pqib+/ysfmJTTLZPXy7D+DMeNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DUZPR04MB9869.eurprd04.prod.outlook.com (2603:10a6:10:4ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 13:29:45 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Mon, 12 Jun 2023
 13:29:45 +0000
Date: Mon, 12 Jun 2023 21:29:34 +0800
From: Geliang Tang <geliang.tang@suse.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v8 13/17] selftests/bpf: Add bpf_burst
 scheduler
Message-ID: <20230612132934.GA9248@localhost>
References: <cover.1686202841.git.geliang.tang@suse.com>
 <bf747921efceb7f066a75cb2dae2ab46071b8275.1686202841.git.geliang.tang@suse.com>
 <666004bda6ff9e3e6d65c6903c5b18f18f0e31ed.camel@redhat.com>
 <20230609133236.GA30403@localhost>
 <4d34b373094d8415d8d6cc29af013dc508a5bf81.camel@redhat.com>
 <20230610014514.GA2843@localhost>
 <5336efd2153d4667f9d0aea52b6d67ed2685ddbf.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5336efd2153d4667f9d0aea52b6d67ed2685ddbf.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DUZPR04MB9869:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b7efc11-0490-4c79-5d82-08db6b4915e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5AvrPgBIOH1VHvuQGXA7wEnJIhMn5TthzXZRarvXFclhkRheVn57KdX3CK4/VvcROs451tu6qHOvM4bWnGgLpwWX3vfKfpNXnywaDPKM4I/DfyXAgJ+ROX4KIqLOK6qmnRHyUWJc5GS6IoT0LAMQiOIjR6WoT936aKwfPsTAEkjxw1br7EBcSYluI/EJhXpEc5V70ijihNI6828NbgRm65UUSdmd5ybQB1Twa8NoHRvQlBd2QSkkwSGpPF5ytJnMWGawlFmeKVjBelc5hi1ypUqDRncy6W6i7fNFZtEbXnJOMr4/CopIelCkmEIknd4SLcj9Vhser6FlyyfdkcpFz5LAdR+e5WCPpi4uWzsrp03kSMTruSS8P9a2xupD37y7tZ84BArkWA6Ps1AeIx4aPwEHsCyQJye4p+Dvp2yRvCyci5cVmgv9xu+bqVsc+oc5wvfbm2N49UJJB7Swd7C+J48CpQlZOnzwfPu4NWPTzbxmNdUiOOF9WZtcrTjSui0DWieSlsr7a9xAC9Ng0pOIOP5FYUle6+3kikAmByMW+Q8rU1Q7Q8uqkEsSgdiTf/oO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(66946007)(66556008)(66476007)(478600001)(8676002)(5660300002)(8936002)(6916009)(6666004)(4326008)(41300700001)(6486002)(316002)(38100700002)(186003)(6506007)(6512007)(26005)(9686003)(2906002)(33716001)(44832011)(83380400001)(86362001)(1076003)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWhyUjBwR2V4QU5CR3F2ZDBIcTZDUEUwTklLNnJWa0JmSXJYa0E3WTl2VUZq?=
 =?utf-8?B?c0ZVR21DVVVDbElRZTFoRHNMQnZZOW4zcEVOZGloUWR4QnZpN3Rockw5N05V?=
 =?utf-8?B?d3R5Z1o3dlEreGR3K2EyQ1F3cUdMbldHWGxOUGJUT3ZhZnJ1eVVsZnRXYnZ6?=
 =?utf-8?B?b2kyNld5THlqbHN4aU91d3NQbXRMeTl1Sm9ZWm9jWDZ5anJPNjVvOVNxbHhp?=
 =?utf-8?B?MXpGMitNUWNWQkRIeURPWStZYlFBK3laQmJ0ejdMN3lRdnB2cnJLM3o0eXBw?=
 =?utf-8?B?K3FNWW05SzdyeUx6WDEzc1VzL3lPcXhaL1RUWFBVeUV1VWxNT01Yc21pNzYw?=
 =?utf-8?B?RVdjc1VDZjBScEkzUnI5a01odG1HVDlJWVhUWGd1a0ltWG5XQ1U0ODFqN0RP?=
 =?utf-8?B?L1Q0RmxBNU5TdjM2OXo4QjRuZ2QwMG80Ym5qMjBEK0tqUmkrSFhxbHNDQmNz?=
 =?utf-8?B?MzV3VkF2Y0E4cElxUEJPN2tqSWs3QW1NTDUwQUxTb3JtbkF3R3p0N1RaMmpC?=
 =?utf-8?B?SFhEYUc4dW9YSjl2ejI1dWlJOGV0SyswZjhCcHE3VEl4WTZZRFdWVDRVYXZT?=
 =?utf-8?B?Z2hKcDZ2U3hqSEthQjh1NzdDM2s4UkRuYlZzcU9XcTRGRldGdHp1UEVObEUv?=
 =?utf-8?B?SitUWWl1THZJRUpwRGhqQTBGaGFmTlRsRTdpMTNTU1FocTVXRy9xVXVEVWxu?=
 =?utf-8?B?UHRZaUNwV0NHMUx6RlZyQ25vNWtrT0tObnoyU29EMml1M3RHVktHdWVhU1FZ?=
 =?utf-8?B?ZkdmZ2p1ekY5dnplYnQvL2t4QUZEdlNja3I5emJqRks5bUsvQjFNQVNvNDE3?=
 =?utf-8?B?UmtsUWpaVkM1eEt6YTZMd0NiOTN0SXViSU80S0g4cVhmUzV2eUgraGFKaTVY?=
 =?utf-8?B?aWxvYzZMQUF6VGhQUVQ5MlFab3FxckhkcC9FVTNMSm5uek5UMGU0NWZGV1lU?=
 =?utf-8?B?Sk1mYUxvQ1owdmZNcGxXUHF3U1V1dklFL0tyMTZrZU9GVXZIQUsxRDJXSVdy?=
 =?utf-8?B?WWpMVXZ4RlRJNDNUcDJabThUVjhDM2FFOVNyVGlOTjF4eUJTOGYxSGJCd09v?=
 =?utf-8?B?U25YUHJBY3JvVnhPNEF3SXJjMGxncWk4VXgvb1lFL2lsSXBlMlVvS3RXMUhl?=
 =?utf-8?B?bUhBeVlMZ2t3ejM2V0h2NFRQWTZ1eGlnSmo1bEpKbXVBYnpEZzZsNFlxSm1W?=
 =?utf-8?B?aDFaZjh3dUJmR3JPT0swRm4zSHJ5a2xUTThYajdSS3ZKMzZqOGF0U3A1MCtY?=
 =?utf-8?B?c2ZMd1VUSUpzdWF3Q1NReGpxaFBjVTlSbUl0aG5hK1U3VTFUOXVTbHNFKy9s?=
 =?utf-8?B?dTFmMEU1bFNHdkpET3ZlWFNGNWs4QTk0eGRKNkp6VjVFL1piZkJaZm5Gc3JQ?=
 =?utf-8?B?YzJQajJwLzhXeldKMXZ3SGFiU3pvVHRrVElJditJVXViS2MzYTJGSVdOcE4r?=
 =?utf-8?B?MUdrVW9pUFB2bUN6YWtBVXZPeTZnRFB3d0Vwa2tFRktVL0t5SkMzaDdBVHhE?=
 =?utf-8?B?cWE4VlhncXVYRVpRR05hUFFLWUNjNlRTUDZ0Vm9xa2N4V1d3VW45UFFqVXha?=
 =?utf-8?B?cWMrRVZmTTJETFg2Q2ZwYWl3emFaTi9DMHlKbjlUZ2JScnQ1NUk4bU8rK3hi?=
 =?utf-8?B?U01DWHlFQmt6NzFWUlp2QjhGSFRGQlhXVXZjeGRuWVhDSE1qMXQ5azZmcTRk?=
 =?utf-8?B?dmNEV2Z2QXZNY2s2OFFkMENWMGI3dEpXRUhoK3dKUHd5M2UzQk5hOGtzU2VK?=
 =?utf-8?B?SEU1SjY4cTNtQmhnbkFiZ2dZZVZNMWIweHZMUUZJdHo1NlFpZUV6ZTlTNEFS?=
 =?utf-8?B?OU5pcDAzNzBJOVFVUmY2TkhmNjdybElFWVV0VkNFcWxSR3VTeUtRSy85U1pn?=
 =?utf-8?B?c1lRenE2bUxNbmt6K0VhMEhhYTBObE96N3RoYWRMVVVHYnBuVTFLSm0vMUpq?=
 =?utf-8?B?ZnJSM1dvRVZpYXN5QWM0eWtVWHFuMENoR2dvM2JxcDhYem5vYVlyVm1TVEZK?=
 =?utf-8?B?M3hEeWlxNXA0dnpwU2hkcFYydEJsc0xrV1V4RmRicW94TXJCbjJpSU9vTEJz?=
 =?utf-8?B?NjhReHY0VkVDcVdlcnJBNXZHSmdibnZyanNqYXRreEsreTZoLy9tOHpBQXBa?=
 =?utf-8?Q?Ay65eCm6wsdm+B6ALyrmeMbrL?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7efc11-0490-4c79-5d82-08db6b4915e3
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 13:29:45.1452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kc4owQlcElfK+t3J7t0J2CcEGpznneFAKERW5T1jHjsJexFriwiz8nZZvn8uE0RU4/YI82ebxd2gAlglua8lEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9869

On Mon, Jun 12, 2023 at 01:05:30PM +0200, Paolo Abeni wrote:
> On Sat, 2023-06-10 at 09:45 +0800, Geliang Tang wrote:
> > On Fri, Jun 09, 2023 at 04:40:01PM +0200, Paolo Abeni wrote:
> > > On Fri, 2023-06-09 at 21:32 +0800, Geliang Tang wrote:
> > > > On Fri, Jun 09, 2023 at 11:57:53AM +0200, Paolo Abeni wrote:
> > > > 
> > > > > May I guess you get a similar error if you do:
> > > > > 
> > > > > 	subflow = mptcp_subflow_ctx(ssk)
> > > > > 
> > > > > ? (just out of sheer ignorance and curiosity)
> > > > 
> > > > Yes. It seems that accessing 'send_info[SSK_MODE_ACTIVE].ssk' is
> > > > considered unsafe in BPF context. So here we pass 'send_info[SSK_MODE_ACTIVE].ssk'
> > > > into bpf_mptcp_subflow_ctx() to find the related subflow. Then we access this
> > > > subflow instead of 'send_info[SSK_MODE_ACTIVE].ssk' below. This can make BPF happy.
> > > > 
> > > > > 
> > > > > > +	 * then use mptcp_subflow_tcp_sock() to get the ssk.
> > > > > > +	 */
> > > > > > +	subflow = mptcp_subflow_tcp_sock(send_info[SSK_MODE_ACTIVE].ssk, data);
> > > > > > +	ssk = mptcp_subflow_tcp_sock(subflow);
> > > > > 
> > > > > What if you store the 'subflow' pointer in 'send_info'? Will the
> > > > > verifier splat with that? and what if we store the corresponding
> > > > > context index 'i' instead?
> > > > 
> > > > Storing the 'subflow' or index 'i' don't work too.
> > > 
> > > Uhmm... I'm very surprised about 'i'. Specifically what I mean is:
> > > 
> > > struct subflow_send_info {
> > > 	unsigned int subflow_id;
> > > 	__u64 linger_time;
> > > };
> > > 
> > > // ...
> > > 	for (i = 0; i < SSK_MODE_MAX; ++i) {
> > > 		send_info[i].ssk = MPTCP_SUBFLOWS_MAX;
> > > 		send_info[i].linger_time = -1;
> > > 	}
> > > // ...
> > > 
> > > 		if (linger_time < send_info[subflow->backup].linger_time) {
> > > 			send_info[subflow->backup].subflow_id = i;
> > > 			send_info[subflow->backup].linger_time = linger_time;
> > > 		}
> > > 
> > > // ...
> > > 	if (send_info[SSK_MODE_ACTIVE].subflow_id == MPTCP_SUBFLOWS_MAX)
> > > 		send_info[SSK_MODE_ACTIVE].subflow_id = send_info[SSK_MODE_BACKUP].subflow_id;
> > > 
> > > 	if (send_info[SSK_MODE_ACTIVE].subflow_id < MPTCP_SUBFLOWS_MAX)
> > > 		subflow = data->context[send_info[SSK_MODE_ACTIVE].subflow_id];
> > > 
> > > The last assignment should be equivalent to the already used 'subflow =
> > > data->contexts[i];'. What kind of errors do you see here?!? Could you
> > > please report them verbatim?
> > 
> > This line "subflow = data->context[send_info[SSK_MODE_ACTIVE].subflow_id];" will get a error:
> > 
> >   R2 is ptr_mptcp_sched_data invalid variable offset: off=16, var_off=(0x0; 0x38)
> 
> I see. This looks like a verifier-imposed artificial constraint.
> 
> Basically any access to:
> 
> btf_type.array_field[valid_and_validated_variable_index]
> 
> is not allowed.
> 
> The main point of having sched_data.context exposed to the pluggable
> scheduler via mptcp_sched_data is to avoid looping through the subflows
> to fetch a given one, I think. But the above verifier constraint
> basically prevents such usage.
> 
> I think we should add an helper into the core implementing the position
> (number) to subflow (context) mapping. e.g.:
> 
> struct mptcp_subflow_context *mptcp_subflow_ctx_by_pos(struct mptcp_sk *msk,
> 							unsigned int pos)
> {
> 	if (pos >= MPTCP_SUBFLOWS_MAX)
> 		return NULL;
> 
> 	return msk->sched_data.context[pos];
> }
> 
> And use such helper here instead of bpf_mptcp_subflow_ctx(). 

"return msk->sched_data.contexts[pos];" will get the same error:

R3 is ptr_mptcp_sock invalid variable offset: off=1880, var_off=(0x0; 0x38)

Here's the patch:

'''
diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
index 3e8df90951e9..5f2d8acc1a84 100644
--- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
@@ -268,6 +268,7 @@ struct mptcp_sock {
 	__u64		snd_nxt;
 	__u32		token;
 	struct sock	*first;
+	struct mptcp_sched_data sched_data;
 	char		ca_name[TCP_CA_NAME_MAX];
 } __attribute__((preserve_access_index));
 
diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
index 2f97ffb707ac..308c254d8aba 100644
--- a/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
+++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c
@@ -10,7 +10,7 @@ char _license[] SEC("license") = "GPL";
 #define MPTCP_SEND_BURST_SIZE	65428
 
 struct subflow_send_info {
-	struct sock *ssk;
+	unsigned int subflow_id;
 	__u64 linger_time;
 };
 
@@ -32,6 +32,14 @@ bpf_mptcp_subflow_ctx(const struct sock *ssk, const struct mptcp_sched_data *dat
 	return data->contexts[nr];
 }
 
+static struct mptcp_subflow_context *
+mptcp_subflow_ctx_by_pos(const struct mptcp_sock *msk, unsigned int pos)
+{
+	if (pos >= MPTCP_SUBFLOWS_MAX)
+		return NULL;
+	return msk->sched_data.contexts[pos];
+}
+
 static inline __u64 div_u64_rem(__u64 dividend, __u32 divisor, __u32 *remainder)
 {
 	*remainder = dividend % divisor;
@@ -79,13 +87,13 @@ static int bpf_burst_get_send(const struct mptcp_sock *msk,
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
 	__u32 pace, burst, wmem;
-	int i, nr_active = 0;
 	__u64 linger_time;
 	struct sock *ssk;
+	int i;
 
 	/* pick the subflow with the lower wmem/wspace ratio */
 	for (i = 0; i < SSK_MODE_MAX; ++i) {
-		send_info[i].ssk = NULL;
+		send_info[i].subflow_id = MPTCP_SUBFLOWS_MAX;
 		send_info[i].linger_time = -1;
 	}
 
@@ -98,7 +106,6 @@ static int bpf_burst_get_send(const struct mptcp_sock *msk,
 		if (!mptcp_subflow_active(subflow))
 			continue;
 
-		nr_active += !subflow->backup;
 		pace = subflow->avg_pacing_rate;
 		if (!pace) {
 			/* init pacing rate from socket */
@@ -110,15 +117,15 @@ static int bpf_burst_get_send(const struct mptcp_sock *msk,
 
 		linger_time = div_u64((__u64)ssk->sk_wmem_queued << 32, pace);
 		if (linger_time < send_info[subflow->backup].linger_time) {
-			send_info[subflow->backup].ssk = ssk;
+			send_info[subflow->backup].subflow_id = i;
 			send_info[subflow->backup].linger_time = linger_time;
 		}
 	}
 	mptcp_set_timeout(sk);
 
 	/* pick the best backup if no other subflow is active */
-	if (!nr_active)
-		send_info[SSK_MODE_ACTIVE].ssk = send_info[SSK_MODE_BACKUP].ssk;
+	if (send_info[SSK_MODE_ACTIVE].subflow_id == MPTCP_SUBFLOWS_MAX)
+		send_info[SSK_MODE_ACTIVE].subflow_id = send_info[SSK_MODE_BACKUP].subflow_id;
 
 	/* Pass "send_info[SSK_MODE_ACTIVE].ssk" directly to bpf_sk_stream_memory_free()
 	 * will get an error:
@@ -127,7 +134,7 @@ static int bpf_burst_get_send(const struct mptcp_sock *msk,
 	 * then use mptcp_subflow_tcp_sock() to get the ssk,
 	 * and pass the ssk to bpf_sk_stream_memory_free().
 	 */
-	subflow = bpf_mptcp_subflow_ctx(send_info[SSK_MODE_ACTIVE].ssk, data);
+	subflow = mptcp_subflow_ctx_by_pos(msk, send_info[SSK_MODE_ACTIVE].subflow_id);
 	ssk = mptcp_subflow_tcp_sock(subflow);
 	if (!ssk || !bpf_sk_stream_memory_free(ssk))
 		return -1;
'''

> 
> There are a number of possible follow-ups to the above, not strictly
> related to this series, but IMHO needed before upstreaming this code:
> 
> -we could remove the 'context' array from the data directly visible to
> the ebpf code. 
> - Instead we could export to the scheduler the number of subflows
> currently present into the msk socket, so the scheduler itself will not
> have to always ask for all the MPTCP_SUBFLOWS_MAX possible subflows. 

This for loop in BPF will get the "invalid variable offset" error too:

for (int i = 0; i < number_of_subflows; i++)
	contexts[i];

So we have to loop from 0 to MAX like this:

for (i = 0; i < SSK_MODE_MAX; i++)
	contexts[i];

Thanks,
-Geliang

> - we could drop entirely the data_init() scheduler operation: all the
> data should be make available/prepared by the core itself, no need to
> add an indirect call to always do the same operation.
> 
> /P
> 
