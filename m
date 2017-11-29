Content-Type: multipart/mixed; boundary="===============7427089395866326001=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2 06/25] tcp_md5: Don't pass along md5-key
Date: Wed, 29 Nov 2017 10:46:41 -0800
Message-ID: <alpine.OSX.2.21.1711291044090.22612@skpadalx-mobl.amr.corp.intel.com>
In-Reply-To: 20171129173709.GN94116@Chimay.local
X-Status: 
X-Keywords:                  
X-UID: 219

--===============7427089395866326001==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 29 Nov 2017, Christoph Paasch wrote:

> On 28/11/17 - 17:36:22, Mat Martineau wrote:
>> On Mon, 27 Nov 2017, Christoph Paasch wrote:
>>
>>> It is much cleaner to store the key-pointer in tcp_out_options.
>>>
>>> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
>>> ---
>>> net/ipv4/tcp_output.c | 47 +++++++++++++++++++++-----------------------=
---
>>> 1 file changed, 21 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>>> index 751396f22bb3..fedaaea83b43 100644
>>> --- a/net/ipv4/tcp_output.c
>>> +++ b/net/ipv4/tcp_output.c
>>> @@ -429,6 +429,7 @@ struct tcp_out_options {
>>> 	__u8 *hash_location;	/* temporary pointer, overloaded */
>>> 	__u32 tsval, tsecr;	/* need to include OPTION_TS */
>>> 	struct tcp_fastopen_cookie *fastopen_cookie;	/* Fast open cookie */
>>> +	struct tcp_md5sig_key *md5; /* TCP_MD5 signature key */
>>
>> The md5 member can be wrapped in an #ifdef CONFIG_TCP_MD5SIG (and propag=
ated
>> to tcp.h when the struct gets moved), with some tweaks below.
>
> See my comment below - ifdef'ing will make an if-statement quite messy.
>
>>
>>> };
>>>
>>> /* Write previously computed TCP options to the packet.
>>> @@ -582,21 +583,20 @@ static void smc_set_option_cond(const struct tcp_=
sock *tp,
>>>  * network wire format yet.
>>>  */
>>> static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *sk=
b,
>>> -				struct tcp_out_options *opts,
>>> -				struct tcp_md5sig_key **md5)
>>> +				struct tcp_out_options *opts)
>>> {
>>> 	struct tcp_sock *tp =3D tcp_sk(sk);
>>> 	unsigned int remaining =3D MAX_TCP_OPTION_SPACE;
>>> 	struct tcp_fastopen_request *fastopen =3D tp->fastopen_req;
>>>
>>> #ifdef CONFIG_TCP_MD5SIG
>>> -	*md5 =3D tp->af_specific->md5_lookup(sk, sk);
>>> -	if (*md5) {
>>> +	opts->md5 =3D tp->af_specific->md5_lookup(sk, sk);
>>> +	if (opts->md5) {
>>> 		opts->options |=3D OPTION_MD5;
>>> 		remaining -=3D TCPOLEN_MD5SIG_ALIGNED;
>>> 	}
>>> #else
>>> -	*md5 =3D NULL;
>>> +	opts->md5 =3D NULL;
>>> #endif
>>
>> Since *opts is zeroed out, the #else block might not be needed. This wou=
ld
>> allow the struct member to be configured out too. While this is an
>> intermediate step in the refactoring process, it is helpful to have opts=
.md5
>> #ifdef'd from the start.
>
> I removed the opts->md5 =3D NULL here.
>
>>> 	/* We always get an MSS option.  The option bytes which will be seen in
>>> @@ -611,7 +611,7 @@ static unsigned int tcp_syn_options(struct sock *sk=
, struct sk_buff *skb,
>>> 	opts->mss =3D tcp_advertise_mss(sk);
>>> 	remaining -=3D TCPOLEN_MSS_ALIGNED;
>>>
>>> -	if (likely(sock_net(sk)->ipv4.sysctl_tcp_timestamps && !*md5)) {
>>> +	if (likely(sock_net(sk)->ipv4.sysctl_tcp_timestamps && !opts->md5)) {
>
> If I #ifdef opts->md5, this if-statement here will become quite messy.
>
> However in the later patch when I adopt the framework for MD5, I will ifd=
ef
> it out.
>

Ah, ok.

>>> 		opts->options |=3D OPTION_TS;
>>> 		opts->tsval =3D tcp_skb_timestamp(skb) + tp->tsoffset;
>>> 		opts->tsecr =3D tp->rx_opt.ts_recent;
>>> @@ -653,14 +653,13 @@ static unsigned int tcp_synack_options(const stru=
ct sock *sk,
>>> 				       struct request_sock *req,
>>> 				       unsigned int mss, struct sk_buff *skb,
>>> 				       struct tcp_out_options *opts,
>>> -				       const struct tcp_md5sig_key *md5,
>>> 				       struct tcp_fastopen_cookie *foc)
>>> {
>>> 	struct inet_request_sock *ireq =3D inet_rsk(req);
>>> 	unsigned int remaining =3D MAX_TCP_OPTION_SPACE;
>>>
>>> #ifdef CONFIG_TCP_MD5SIG
>>> -	if (md5) {
>>> +	if (opts->md5) {
>>> 		opts->options |=3D OPTION_MD5;
>>> 		remaining -=3D TCPOLEN_MD5SIG_ALIGNED;
>>>
>>> @@ -715,8 +714,7 @@ static unsigned int tcp_synack_options(const struct=
 sock *sk,
>>>  * final wire format yet.
>>>  */
>>> static unsigned int tcp_established_options(struct sock *sk, struct sk_=
buff *skb,
>>> -					struct tcp_out_options *opts,
>>> -					struct tcp_md5sig_key **md5)
>>> +					struct tcp_out_options *opts)
>>> {
>>> 	struct tcp_sock *tp =3D tcp_sk(sk);
>>> 	unsigned int size =3D 0;
>>> @@ -725,13 +723,13 @@ static unsigned int tcp_established_options(struc=
t sock *sk, struct sk_buff *skb
>>> 	opts->options =3D 0;
>>>
>>> #ifdef CONFIG_TCP_MD5SIG
>>> -	*md5 =3D tp->af_specific->md5_lookup(sk, sk);
>>> -	if (unlikely(*md5)) {
>>> +	opts->md5 =3D tp->af_specific->md5_lookup(sk, sk);
>>> +	if (unlikely(opts->md5)) {
>>> 		opts->options |=3D OPTION_MD5;
>>> 		size +=3D TCPOLEN_MD5SIG_ALIGNED;
>>> 	}
>>> #else
>>> -	*md5 =3D NULL;
>>> +	opts->md5 =3D NULL;
>>> #endif
>>
>> Same as previous comment.
>
> When coming from tcp_current_mss(), opts is not zeroed out. So, I think i=
t's
> safer to leave this here.
>

I had missed that. Looks like it's not zeroed because all of the struct =

values are ignored.

Mat


>
>>
>>>
>>> 	if (likely(tp->rx_opt.tstamp_ok)) {
>>> @@ -1045,7 +1043,6 @@ static int tcp_transmit_skb(struct sock *sk, stru=
ct sk_buff *skb, int clone_it,
>>> 	struct tcp_out_options opts;
>>> 	unsigned int tcp_options_size, tcp_header_size;
>>> 	struct sk_buff *oskb =3D NULL;
>>> -	struct tcp_md5sig_key *md5;
>>> 	struct tcphdr *th;
>>> 	int err;
>>>
>>> @@ -1074,10 +1071,9 @@ static int tcp_transmit_skb(struct sock *sk, str=
uct sk_buff *skb, int clone_it,
>>> 	memset(&opts, 0, sizeof(opts));
>>>
>>> 	if (unlikely(tcb->tcp_flags & TCPHDR_SYN))
>>> -		tcp_options_size =3D tcp_syn_options(sk, skb, &opts, &md5);
>>> +		tcp_options_size =3D tcp_syn_options(sk, skb, &opts);
>>> 	else
>>> -		tcp_options_size =3D tcp_established_options(sk, skb, &opts,
>>> -							   &md5);
>>> +		tcp_options_size =3D tcp_established_options(sk, skb, &opts);
>>> 	tcp_header_size =3D tcp_options_size + sizeof(struct tcphdr);
>>>
>>> 	/* if no packet is in qdisc/device queue, then allow XPS to select
>>> @@ -1143,10 +1139,10 @@ static int tcp_transmit_skb(struct sock *sk, st=
ruct sk_buff *skb, int clone_it,
>>> 	tcp_options_write((__be32 *)(th + 1), skb, sk, &opts);
>>> #ifdef CONFIG_TCP_MD5SIG
>>> 	/* Calculate the MD5 hash, as we have all we need now */
>>> -	if (md5) {
>>> +	if (opts.md5) {
>>> 		sk_nocaps_add(sk, NETIF_F_GSO_MASK);
>>> 		tp->af_specific->calc_md5_hash(opts.hash_location,
>>> -					       md5, sk, skb);
>>> +					       opts.md5, sk, skb);
>>> 	}
>>> #endif
>>>
>>> @@ -1590,7 +1586,6 @@ unsigned int tcp_current_mss(struct sock *sk)
>>> 	u32 mss_now;
>>> 	unsigned int header_len;
>>> 	struct tcp_out_options opts;
>>> -	struct tcp_md5sig_key *md5;
>>>
>>> 	mss_now =3D tp->mss_cache;
>>>
>>> @@ -1600,7 +1595,7 @@ unsigned int tcp_current_mss(struct sock *sk)
>>> 			mss_now =3D tcp_sync_mss(sk, mtu);
>>> 	}
>>>
>>> -	header_len =3D tcp_established_options(sk, NULL, &opts, &md5) +
>>> +	header_len =3D tcp_established_options(sk, NULL, &opts) +
>>> 		     sizeof(struct tcphdr);
>>> 	/* The mss_cache is sized based on tp->tcp_header_len, which assumes
>>> 	 * some common options. If this is an odd packet (because we have SACK
>>> @@ -3179,7 +3174,6 @@ struct sk_buff *tcp_make_synack(const struct sock=
 *sk, struct dst_entry *dst,
>>> {
>>> 	struct inet_request_sock *ireq =3D inet_rsk(req);
>>> 	const struct tcp_sock *tp =3D tcp_sk(sk);
>>> -	struct tcp_md5sig_key *md5 =3D NULL;
>>> 	struct tcp_out_options opts;
>>> 	struct sk_buff *skb;
>>> 	int tcp_header_size;
>>> @@ -3225,10 +3219,10 @@ struct sk_buff *tcp_make_synack(const struct so=
ck *sk, struct dst_entry *dst,
>>>
>>> #ifdef CONFIG_TCP_MD5SIG
>>> 	rcu_read_lock();
>>> -	md5 =3D tcp_rsk(req)->af_specific->req_md5_lookup(sk, req_to_sk(req));
>>> +	opts.md5 =3D tcp_rsk(req)->af_specific->req_md5_lookup(sk, req_to_sk(=
req));
>>> #endif
>>> 	skb_set_hash(skb, tcp_rsk(req)->txhash, PKT_HASH_TYPE_L4);
>>> -	tcp_header_size =3D tcp_synack_options(sk, req, mss, skb, &opts, md5,
>>> +	tcp_header_size =3D tcp_synack_options(sk, req, mss, skb, &opts,
>>> 					     foc) + sizeof(*th);
>>>
>>> 	skb_push(skb, tcp_header_size);
>>> @@ -3255,9 +3249,10 @@ struct sk_buff *tcp_make_synack(const struct soc=
k *sk, struct dst_entry *dst,
>>>
>>> #ifdef CONFIG_TCP_MD5SIG
>>> 	/* Okay, we have all we need - do the md5 hash if needed */
>>> -	if (md5)
>>> +	if (opts.md5)
>>> 		tcp_rsk(req)->af_specific->calc_md5_hash(opts.hash_location,
>>> -					       md5, req_to_sk(req), skb);
>>> +							 opts.md5,
>>> +							 req_to_sk(req), skb);
>>> 	rcu_read_unlock();
>>> #endif
>>>
>>> --
>>> 2.15.0
>>>
>>>
>>
>> --
>> Mat Martineau
>> Intel OTC
>

--
Mat Martineau
Intel OTC

--===============7427089395866326001==--
