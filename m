Content-Type: multipart/mixed; boundary="===============4357028965481937867=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH net 2/2] mptcp: Handle incoming 32-bit
 DATA_FIN values
Date: Tue, 29 Sep 2020 11:39:30 -0700
Message-ID: <alpine.OSX.2.23.453.2009291034450.18559@pengyang-mobl1.ccr.corp.intel.com>
In-Reply-To: 95b5a6c64d14c0b336087fa555410ac80fa76561.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6098

--===============4357028965481937867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Sep 2020, Paolo Abeni wrote:

> On Fri, 2020-09-25 at 17:24 -0700, Mat Martineau wrote:
>> The peer may send a DATA_FIN mapping with either a 32-bit or 64-bit
>> sequence number. When a 32-bit sequence number is received for the
>> DATA_FIN, it must be expanded to 64 bits before comparing it to the
>> last acked sequence number. This expansion was missing.
>>
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/93
>> Fixes: 3721b9b64676 (mptcp: Track received DATA_FIN sequence number and =
add related helpers)
>> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>> ---
>>  net/mptcp/options.c  |  7 ++++---
>>  net/mptcp/protocol.h |  2 +-
>>  net/mptcp/subflow.c  | 17 ++++++++++++++---
>>  3 files changed, 19 insertions(+), 7 deletions(-)
>>
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index 120ef39fe589..afa486912f5a 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -782,7 +782,7 @@ static void update_una(struct mptcp_sock *msk,
>>  	}
>>  }
>>
>> -bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq)
>> +bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq=
, bool use_64bit)
>>  {
>>  	/* Skip if DATA_FIN was already received.
>>  	 * If updating simultaneously with the recvmsg loop, values
>> @@ -792,7 +792,8 @@ bool mptcp_update_rcv_data_fin(struct mptcp_sock *ms=
k, u64 data_fin_seq)
>>  	if (READ_ONCE(msk->rcv_data_fin) || !READ_ONCE(msk->first))
>>  		return false;
>>
>> -	WRITE_ONCE(msk->rcv_data_fin_seq, data_fin_seq);
>> +	WRITE_ONCE(msk->rcv_data_fin_seq,
>> +		   expand_ack(READ_ONCE(msk->ack_seq), data_fin_seq, use_64bit));
>>  	WRITE_ONCE(msk->rcv_data_fin, 1);
>>
>>  	return true;
>> @@ -875,7 +876,7 @@ void mptcp_incoming_options(struct sock *sk, struct =
sk_buff *skb,
>>  	 */
>>  	if (TCP_SKB_CB(skb)->seq =3D=3D TCP_SKB_CB(skb)->end_seq) {
>>  		if (mp_opt.data_fin && mp_opt.data_len =3D=3D 1 &&
>> -		    mptcp_update_rcv_data_fin(msk, mp_opt.data_seq) &&
>> +		    mptcp_update_rcv_data_fin(msk, mp_opt.data_seq, mp_opt.dsn64) &&
>>  		    schedule_work(&msk->work))
>>  			sock_hold(subflow->conn);
>>
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index 60b27d44c184..20f04ac85409 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -387,7 +387,7 @@ void mptcp_data_ready(struct sock *sk, struct sock *=
ssk);
>>  bool mptcp_finish_join(struct sock *sk);
>>  void mptcp_data_acked(struct sock *sk);
>>  void mptcp_subflow_eof(struct sock *sk);
>> -bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq=
);
>> +bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, u64 data_fin_seq=
, bool use_64bit);
>>
>>  void __init mptcp_token_init(void);
>>  static inline void mptcp_token_init_request(struct request_sock *req)
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index 8cbeb68f3775..8519962af3ba 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -731,7 +731,8 @@ static enum mapping_status get_mapping_status(struct=
 sock *ssk,
>>
>>  	if (mpext->data_fin =3D=3D 1) {
>>  		if (data_len =3D=3D 1) {
>> -			bool updated =3D mptcp_update_rcv_data_fin(msk, mpext->data_seq);
>> +			bool updated =3D mptcp_update_rcv_data_fin(msk, mpext->data_seq,
>> +								 mpext->dsn64);
>>  			pr_debug("DATA_FIN with no payload seq=3D%llu", mpext->data_seq);
>>  			if (subflow->map_valid) {
>>  				/* A DATA_FIN might arrive in a DSS
>> @@ -748,8 +749,18 @@ static enum mapping_status get_mapping_status(struc=
t sock *ssk,
>>  				return MAPPING_DATA_FIN;
>>  			}
>>  		} else {
>> -			mptcp_update_rcv_data_fin(msk, mpext->data_seq + data_len);
>> -			pr_debug("DATA_FIN with mapping seq=3D%llu", mpext->data_seq + data_=
len);
>> +			u64 data_fin_seq;
>> +
>> +			if (mpext->dsn64) {
>> +				data_fin_seq =3D mpext->data_seq;
>> +			} else {
>> +				data_fin_seq =3D expand_seq(subflow->map_seq,
>> +							  subflow->map_data_len,
>> +							  mpext->data_seq);
>> +			}
>
> If you wrap the above chunk of code in an helper, you can additionally
> remove some code duplication with a similar chunk.
>
> Not strictly related to this patch, but it looks like (to me) that seq
> expansion is done in a way more conforming to the RFC in expand_ack()
> and it feels strange we have 2 different helper to do the expansions,
> perhaps we should unify them?

Yes, I do think it would be good to unify them (but separately from this =

patch). Having taken another look, I think this patch is cleaner if =

mptcp_update_rcv_data_fin() does the expansion.

--
Mat Martineau
Intel
--===============4357028965481937867==--
