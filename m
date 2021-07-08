Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81789173
	for <mptcp@lists.linux.dev>; Thu,  8 Jul 2021 00:44:46 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10038"; a="273259267"
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="273259267"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 17:44:43 -0700
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="628212313"
Received: from wilesamy-mobl.amr.corp.intel.com ([10.212.141.74])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 17:44:42 -0700
Date: Wed, 7 Jul 2021 17:44:42 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH v3 mptcp-next 6/8] mptcp: infinite mapping
 sending
In-Reply-To: <2f64b65-f77c-dab3-669-e7787e42d070@linux.intel.com>
Message-ID: <f2493c6f-ba23-85f-c6c3-17839f2a5b8c@linux.intel.com>
References: <cover.1624854005.git.geliangtang@gmail.com> <3cc57b70ec147b4c77610737241aeadf4150f323.1624854005.git.geliangtang@gmail.com> <d10ab4b89d053ba9a3debc9c7f6bdab0ca0d95bd.1624854005.git.geliangtang@gmail.com>
 <30a102a69a09fe644776dbddc93a1a3710c0fd51.1624854005.git.geliangtang@gmail.com> <fd3ac7612efa93564019e8542bf67ed38ef06627.1624854005.git.geliangtang@gmail.com> <926e95605f1d2a7cdc02b99a1701a1dddf1e6424.1624854005.git.geliangtang@gmail.com>
 <0e01e10358c89896ad265d9b57cfe4995965e445.1624854005.git.geliangtang@gmail.com> <2f64b65-f77c-dab3-669-e7787e42d070@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 7 Jul 2021, Mat Martineau wrote:

> On Mon, 28 Jun 2021, Geliang Tang wrote:
>
>> This patch added the infinite mapping sending logic.
>> 
>> Added a new flag snd_infinite_mapping_enable in mptcp_sock. Set it true
>> when echoing the MP_FAIL in mptcp_pm_mp_fail_received.
>> 
>> In mptcp_established_options_dss, if this flag is true, call the new
>> function mptcp_write_infinite_mapping to set the infiniting mapping and
>> sent it out.
>> 
>> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
>> ---
>
> Hi Geliang -
>
> Thanks for working on the infinite mapping support to include in this patch 
> set.
>
>> net/mptcp/options.c  | 23 +++++++++++++++++++++--
>> net/mptcp/pm.c       |  1 +
>> net/mptcp/protocol.c |  1 +
>> net/mptcp/protocol.h |  6 ++++++
>> 4 files changed, 29 insertions(+), 2 deletions(-)
>> 
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index 9c2e122f1a6e..1fce6fddb6ab 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -572,8 +572,21 @@ static void mptcp_write_data_fin(struct 
>> mptcp_subflow_context *subflow,
>> 	}
>> }
>> 
>> +static void mptcp_write_infinite_mapping(struct mptcp_subflow_context 
>> *subflow,
>> +					 struct mptcp_ext *ext)
>> +{
>> +	pr_debug("fail_seq=%llu", subflow->fail_seq);
>> +
>> +	if (ext->use_map) {
>> +		ext->data_seq = subflow->fail_seq;
>> +		ext->data_len = 0;
>> +		WRITE_ONCE(msk->snd_infinite_mapping_enable, false);
>
> I'm not sure it's enough to override the data_seq / data_len on an existing 
> skb like this, more careful coordination with fallback might be needed. What 
> do you think about handling the infinite mapping where data_seq & data_len 
> get populated in mptcp_sendmsg_frag()?
>
> The RFC also says the infinite mapping should only be sent once, I wonder if 
> we can guarantee that with GSO?
>

One more thing: if the checksum is enabled when an infinite mapping is 
set, it must also be set to 0. The rx side should check this too.

- Mat

>> +	}
>> +}
>> +
>> static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff 
>> *skb,
>> 					  bool snd_data_fin_enable,
>> +					  bool snd_infinite_mapping_enable,
>
> This new parameter isn't necessary, it can be read from the msk.
>
>> 					  unsigned int *size,
>> 					  unsigned int remaining,
>> 					  struct mptcp_out_options *opts)
>> @@ -589,7 +602,8 @@ static bool mptcp_established_options_dss(struct sock 
>> *sk, struct sk_buff *skb,
>> 	opts->csum_reqd = READ_ONCE(msk->csum_enabled);
>> 	mpext = skb ? mptcp_get_ext(skb) : NULL;
>> 
>> -	if (!skb || (mpext && mpext->use_map) || snd_data_fin_enable) {
>> +	if (!skb || (mpext && mpext->use_map) ||
>> +	    snd_data_fin_enable || snd_infinite_mapping_enable) {
>> 		unsigned int map_size = TCPOLEN_MPTCP_DSS_BASE + 
>> TCPOLEN_MPTCP_DSS_MAP64;
>>
>> 		if (mpext) {
>> @@ -603,6 +617,8 @@ static bool mptcp_established_options_dss(struct sock 
>> *sk, struct sk_buff *skb,
>> 		dss_size = map_size;
>> 		if (skb && snd_data_fin_enable)
>> 			mptcp_write_data_fin(subflow, skb, &opts->ext_copy);
>> +		if (skb && snd_infinite_mapping_enable)
>> +			mptcp_write_infinite_mapping(subflow, 
>> &opts->ext_copy);
>> 		ret = true;
>> 	}
>> 
>> @@ -811,6 +827,7 @@ bool mptcp_established_options(struct sock *sk, struct 
>> sk_buff *skb,
>> 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
>> 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
>> 	unsigned int opt_size = 0;
>> +	bool snd_infinite_mapping;
>> 	bool snd_data_fin;
>> 	bool ret = false;
>> 
>> @@ -831,9 +848,11 @@ bool mptcp_established_options(struct sock *sk, struct 
>> sk_buff *skb,
>> 	}
>>
>> 	snd_data_fin = mptcp_data_fin_enabled(msk);
>> +	snd_infinite_mapping = mptcp_infinite_mapping_enabled(msk);
>> 	if (mptcp_established_options_mp(sk, skb, snd_data_fin, &opt_size, 
>> remaining, opts))
>> 		ret = true;
>> -	else if (mptcp_established_options_dss(sk, skb, snd_data_fin, 
>> &opt_size, remaining, opts)) {
>> +	else if (mptcp_established_options_dss(sk, skb, snd_data_fin, 
>> snd_infinite_mapping,
>> +					       &opt_size, remaining, opts)) {
>> 		ret = true;
>> 		if (opts->ext_copy.use_ack) {
>> 			if (mptcp_established_options_mp_fail(sk, &opt_size, 
>> remaining, opts)) {
>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>> index 539fc2892191..1b3b815f1eca 100644
>> --- a/net/mptcp/pm.c
>> +++ b/net/mptcp/pm.c
>> @@ -257,6 +257,7 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 
>> fail_seq)
>>
>> 	if (!msk->pm.subflows) {
>> 		if (!subflow->mp_fail_need_echo) {
>> +			WRITE_ONCE(msk->snd_infinite_mapping_enable, true);
>> 			subflow->send_mp_fail = 1;
>> 			subflow->fail_seq = fail_seq;
>> 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 199a36fe4f69..f1d057ee5887 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -2727,6 +2727,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
>> 	WRITE_ONCE(msk->fully_established, false);
>> 	if (mp_opt->csum_reqd)
>> 		WRITE_ONCE(msk->csum_enabled, true);
>> +	WRITE_ONCE(msk->snd_infinite_mapping_enable, false);
>>
>> 	msk->write_seq = subflow_req->idsn + 1;
>> 	msk->snd_nxt = msk->write_seq;
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index 7a49454c77a6..fff2f5021619 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -244,6 +244,7 @@ struct mptcp_sock {
>> 	bool		fully_established;
>> 	bool		rcv_data_fin;
>> 	bool		snd_data_fin_enable;
>> +	bool		snd_infinite_mapping_enable;
>> 	bool		rcv_fastclose;
>> 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN 
>> */
>> 	bool		csum_enabled;
>> @@ -656,6 +657,11 @@ static inline bool mptcp_data_fin_enabled(const struct 
>> mptcp_sock *msk)
>> 	       READ_ONCE(msk->write_seq) == READ_ONCE(msk->snd_nxt);
>> }
>> 
>> +static inline bool mptcp_infinite_mapping_enabled(const struct mptcp_sock 
>> *msk)
>
> I don't think this helper is needed.
>
>> +{
>> +	return READ_ONCE(msk->snd_infinite_mapping_enable);
>> +}
>> +
>> static inline bool mptcp_propagate_sndbuf(struct sock *sk, struct sock 
>> *ssk)
>> {
>> 	if ((sk->sk_userlocks & SOCK_SNDBUF_LOCK) || ssk->sk_sndbuf <= 
>> READ_ONCE(sk->sk_sndbuf))
>> -- 
>> 2.31.1
>> 
>> 
>> 
>
> --
> Mat Martineau
> Intel
>
>

--
Mat Martineau
Intel
