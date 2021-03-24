Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC01D70
	for <mptcp@lists.linux.dev>; Wed, 24 Mar 2021 01:05:08 +0000 (UTC)
IronPort-SDR: f5xutML1iO10neG1I8bjlAjeuWndvnp/htX06PCeKWo1YziTjMpjiAo9vxyLidfIU/mdMyGFkL
 0DIpqR0lzxMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="170564650"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="170564650"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 18:05:06 -0700
IronPort-SDR: uDK61WG0nWTBvB/1muSe8kCQEAghH6Vv28ooyCZ5/2CfXRLTzaybGEopb7t2NUVBR/OyjJgeZT
 FULBEn8kz+aQ==
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="513981977"
Received: from dnwagbuo-mobl1.amr.corp.intel.com ([10.252.143.194])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 18:05:04 -0700
Date: Tue, 23 Mar 2021 18:05:03 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.01.org, 
    mptcp@lists.linux.dev, Florian Westphal <fwestpha@redhat.com>
Subject: Re: [MPTCP] [MPTCP][PATCH mptcp-next 3/6] mptcp: add the csum_reqd
 fields
In-Reply-To: <4e71ee0d3af1cac20d27c5b200bb615395630b51.camel@redhat.com>
Message-ID: <b73d6ee0-363b-41dd-b327-806a5b5eba23@linux.intel.com>
References: <cover.1616412490.git.geliangtang@gmail.com>  <e56c579836e40e330bfd24a191fd0c313a9e4634.1616412490.git.geliangtang@gmail.com>  <7ad133370d4bb939ba69e35203797494181873b0.1616412490.git.geliangtang@gmail.com> 
 <33da8b854a7397e7ecc807b335a0c7e69e023ca6.1616412490.git.geliangtang@gmail.com> <4e71ee0d3af1cac20d27c5b200bb615395630b51.camel@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 23 Mar 2021, Paolo Abeni wrote:

> On Mon, 2021-03-22 at 19:37 +0800, Geliang Tang wrote:
>> This patch added a new flag csum_reqd in struct mptcp_options_received, if
>> the flag MPTCP_CAP_CHECKSUM_REQD is set in the receiving MP_CAPABLE
>> suboption, set this csum_reqd flag.
>>
>> It also added another new csum_reqd member in struct mptcp_sock too, if the
>> csum_reqd flag in mptcp_options_received is set, set this member to true.
>>
>> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
>> ---
>>  net/mptcp/options.c  | 8 +++++---
>>  net/mptcp/protocol.c | 1 +
>>  net/mptcp/protocol.h | 2 ++
>>  net/mptcp/subflow.c  | 4 ++++
>>  4 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index f45bebb923dc..bdced173edff 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -69,11 +69,9 @@ static void mptcp_parse_option(const struct sk_buff *skb,
>>  		 * "If a checksum is not present when its use has been
>>  		 * negotiated, the receiver MUST close the subflow with a RST as
>>  		 * it is considered broken."
>> -		 *
>> -		 * We don't implement DSS checksum - fall back to TCP.
>>  		 */
>>  		if (flags & MPTCP_CAP_CHECKSUM_REQD)
>> -			break;
>> +			mp_opt->csum_reqd = 1;
>>
>>  		mp_opt->mp_capable = 1;
>>  		if (opsize >= TCPOLEN_MPTCP_MPC_SYNACK) {
>> @@ -340,6 +338,7 @@ void mptcp_get_options(const struct sk_buff *skb,
>>  	mp_opt->dss = 0;
>>  	mp_opt->mp_prio = 0;
>>  	mp_opt->reset = 0;
>> +	mp_opt->csum_reqd = 0;
>>
>>  	length = (th->doff * 4) - sizeof(struct tcphdr);
>>  	ptr = (const unsigned char *)(th + 1);
>> @@ -1013,6 +1012,9 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>>  		mptcp_schedule_work((struct sock *)msk);
>>  	}
>>
>> +	if (mp_opt.csum_reqd)
>> +		WRITE_ONCE(msk->csum_reqd, true);
>> +
>>  	if (mp_opt.add_addr && add_addr_hmac_valid(msk, &mp_opt)) {
>>  		if (!mp_opt.echo) {
>>  			mptcp_pm_add_addr_received(msk, &mp_opt.addr);
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 9d7e7e13fba8..94c3568c7a60 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -2364,6 +2364,7 @@ static int __mptcp_init_sock(struct sock *sk)
>>  	msk->ack_hint = NULL;
>>  	msk->first = NULL;
>>  	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
>> +	WRITE_ONCE(msk->csum_reqd, mptcp_is_checksum_enabled(sock_net(sk)));
>>
>>  	mptcp_pm_data_init(msk);
>>
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index 14f1e2fd3c08..4fc4871595ef 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -132,6 +132,7 @@ struct mptcp_options_received {
>>  		rm_addr : 1,
>>  		mp_prio : 1,
>>  		echo : 1,
>> +		csum_reqd : 1,
>>  		backup : 1;
>>  	u32	token;
>>  	u32	nonce;
>> @@ -233,6 +234,7 @@ struct mptcp_sock {
>>  	bool		snd_data_fin_enable;
>>  	bool		rcv_fastclose;
>>  	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
>> +	bool		csum_reqd;
>>  	spinlock_t	join_list_lock;
>>  	struct sock	*ack_hint;
>>  	struct work_struct work;
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index e2e9cc34713d..9fec1a273100 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -403,6 +403,8 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
>>  			goto fallback;
>>  		}
>>
>> +		if (mp_opt.csum_reqd)
>> +			WRITE_ONCE(mptcp_sk(parent)->csum_reqd, true);
>>  		subflow->mp_capable = 1;
>>  		subflow->can_ack = 1;
>>  		subflow->remote_key = mp_opt.sndr_key;
>> @@ -643,6 +645,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
>>  		new_msk = mptcp_sk_clone(listener->conn, &mp_opt, req);
>>  		if (!new_msk)
>>  			fallback = true;
>> +		else if (mp_opt.csum_reqd)
>> +			WRITE_ONCE(mptcp_sk(new_msk)->csum_reqd, true);
>
> I think this chunk would be better located inside mptcp_sk_clone().
>
> @Mat, @Florian, slighly related: if we do the assignment there, the
> WRITE_ONCE will not be required, right? - since that functions runs
> under msk lock. We already have a few WRITE_ONCE there which are likely
> not really needed...

Yeah, I think it would fit well in mptcp_sk_clone(). Given that csum_reqd 
doesn't change after the connection starts I'm not sure 
WRITE_ONCE/READ_ONCE are really needed for the value, and I think the need 
for WRITE_ONCE is determined by the lockless readers rather than whether 
the writer is under msk lock (there's a recent LWN article I really should 
read to confirm my understanding).

--
Mat Martineau
Intel
