Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB558110C
	for <mptcp@lists.linux.dev>; Sun,  5 Jun 2022 01:10:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1654391396; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=bKuiJCeXQqNyCZ+ZljOzYMVd+P0/vIKVzWMOJ6wU7um4dtlFkA7TNvLQkfw0XKiieWnxfF3mlryhCtQyIzEcCyw8yX7VWrF1MwXS+7vOiR/gcsyHV7ZlGCTEUyu+3x8lO7vx4wwcCTvklfgHrUmGnbH4+2HXE0LHdRu+6xI1rwQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1654391396; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=bWiljbmRbp57iHwCl4qQccDZZBhUSTp3Fn2QVNvsfp8=; 
	b=EEbmdzrofSo8SlNRwsZd3gJrh8uMwy9W8buRCOprF172vBWnF1RavRCi5huazEpyvL1n/EftaPhtAnU+DML4QVdBg7KSLDS3EqURQpiQyDEmM8XurVAE/GcjVoOi3mk1NW5ckbxDpd1dK7yTit/uGI0p6c2OE/Eu0Mzjk5KhSgM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1654391396;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:Message-ID:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=bWiljbmRbp57iHwCl4qQccDZZBhUSTp3Fn2QVNvsfp8=;
	b=hIYcghJ0NImJZ21iihAppi9CfZJjdcRomLYZjywIhHpOkyIA5BA+qgVd8T0CJcga
	Rizu59iNXc6tNwelynwA10XzzRtFck5x6jeuu5+48QkRGYTkvBDWCb2LoQTxY1qzv1B
	MdoBE6KTQwr7mtLrsURfdVr26CCoQUEAcYJRFTQo=
Received: from [192.168.100.118] (51.150.22.93.rev.sfr.net [93.22.150.51]) by mx.zoho.eu
	with SMTPS id 1654391396354182.69194084751484; Sun, 5 Jun 2022 03:09:56 +0200 (CEST)
Date: Sun, 5 Jun 2022 02:09:55 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH mptcp-next v3] mptcp: Fast Open Mechanism
Content-Language: en-US
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <20220522183921.103526-1-dmytro@shytyi.net>
 <30709939-9ba2-c9f1-1a0-d63236f53d86@linux.intel.com>
From: Dmytro SHYTYI <dmytro@shytyi.net>
Message-ID: <75cef8e0-d668-d2de-fcf5-ca7c71a9161d@shytyi.net>
In-Reply-To: <30709939-9ba2-c9f1-1a0-d63236f53d86@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External


On 25/05/2022 02:04, Mat Martineau wrote:
>=20
> On Sun, 22 May 2022, Dmytro SHYTYI wrote:
>=20
>> This set of patches will bring "Fast Open" Option support to MPTCP.
>> The aim of Fast Open Mechanism is to eliminate one round trip
>> time from a TCP conversation by allowing data to be included as
>> part of the SYN segment that initiates the connection.
>>
>> IETF RFC 8684: Appendix B.=C2=A0 TCP Fast Open and MPTCP.
>>
>> [PATCH v3] includes "client-server" partial support for :
>> 1. MPTCP cookie request from client.
>> 2. MPTCP cookie offering from server.
>> 3. MPTCP SYN+DATA+COOKIE from client.
>> 4. subsequent write + read on the opened socket.
>>
>> This patch is Work In Progress transitional draft. There was a pause
>> in code development that was unpaused recently.
>=20
> Welcome back Dmytro.

I'm happy to be back :) Thank you!

>=20
>> Now this code is based
>> on the top of mptcp-next branch. The option below will be modified in
>> future inelligently, depending on socket type (TCP||MPTCP):
>> *tcp_options ^=3D OPTION_TS
>> You also might notice some of commented pieces of the upstream code -
>> that (is probably not good) and was done to observe an
>> expected behavior of MPTCP Fast Open mechanism. Any comments how
>> to achive the same behavior of MPTCP_FO without commenting the related
>> parts of the code are welcome.
>=20
> One step would be to split those commented out regions in to a separate=
=20
> commit, so they're at least separate from the other changes
Understood.

> Also, if you could trim out any extra whitespace changes (blank lines=20
> that were added or deleted), that makes it easier to review.
My bad - forgot about those lines. will fix that.

> I have some first-pass comments below. I'll have to learn more about=20
> fastopen before I can comment on the protocol specifics.
Thank's for comments!

>>
>> Signed-off-by: Dmytro SHYTYI <dmytro@shytyi.net>
>> ---
>> include/net/mptcp.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>> net/ipv4/tcp_fastopen.c |=C2=A0 4 +++
>> net/ipv4/tcp_input.c=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++---
>> net/ipv4/tcp_output.c=C2=A0=C2=A0 |=C2=A0 3 +--
>> net/mptcp/options.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++++--
>> net/mptcp/protocol.c=C2=A0=C2=A0=C2=A0 | 59 ++++++++++++++++++++++++++++=
++++++++++---
>> net/mptcp/sockopt.c=C2=A0=C2=A0=C2=A0=C2=A0 | 41 +++++++++++++++++++++++=
+++++
>> net/mptcp/subflow.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 ++++---
>> 8 files changed, 118 insertions(+), 15 deletions(-)
>>
>> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
>> index 6456ea26e4c7..692197187af8 100644
>> --- a/include/net/mptcp.h
>> +++ b/include/net/mptcp.h
>> @@ -139,7 +139,7 @@ void mptcp_space(const struct sock *ssk, int=20
>> *space, int *full_space);
>> bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 unsigned int *size, struct mptcp_out_options *opts);
>> bool mptcp_synack_options(const struct request_sock *req, unsigned int=
=20
>> *size,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct mptcp_out_options *opts);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct mptcp_out_options *opts, u16 *tcp_options);
>> bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int *size, unsigned int remai=
ning,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mptcp_out_options *opts);
>> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
>> index fdbcf2a6d08e..f5f189e4d15a 100644
>> --- a/net/ipv4/tcp_fastopen.c
>> +++ b/net/ipv4/tcp_fastopen.c
>> @@ -346,8 +346,10 @@ struct sock *tcp_try_fastopen(struct sock *sk,=20
>> struct sk_buff *skb,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct tcp_fastopen_cookie *foc,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct dst_entry *dst)
>> {
>> +=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0bool syn_data =3D TCP_SKB_CB(skb)->end_seq !=3D =
TCP_SKB_CB(skb)->seq + 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0int tcp_fastopen =3D sock_net(sk)->ipv4.sysctl_t=
cp_fastopen;
>> +=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0struct tcp_fastopen_cookie valid_foc =3D { .len =
=3D -1 };
>> =C2=A0=C2=A0=C2=A0=C2=A0struct sock *child;
>> =C2=A0=C2=A0=C2=A0=C2=A0int ret =3D 0;
>> @@ -355,12 +357,14 @@ struct sock *tcp_try_fastopen(struct sock *sk,=20
>> struct sk_buff *skb,
>> =C2=A0=C2=A0=C2=A0=C2=A0if (foc->len =3D=3D 0) /* Client requests a cook=
ie */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NET_INC_STATS(sock_net(sk), L=
INUX_MIB_TCPFASTOPENCOOKIEREQD);
>>
>> +=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0if (!((tcp_fastopen & TFO_SERVER_ENABLE) &&
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (syn_data || foc-=
>len >=3D 0) &&
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcp_fastopen_queu=
e_check(sk))) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 foc->len =3D -1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0}
>> +=C2=A0=C2=A0=C2=A0 */
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0if (tcp_fastopen_no_cookie(sk, dst, TFO_SERVER_C=
OOKIE_NOT_REQD))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fastopen;
>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>> index 3231af73e430..38119b96171d 100644
>> --- a/net/ipv4/tcp_input.c
>> +++ b/net/ipv4/tcp_input.c
>> @@ -6273,9 +6273,10 @@ static int tcp_rcv_synsent_state_process(struct=
=20
>> sock *sk, struct sk_buff *skb,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (fastopen_fail)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n -1;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (sk->sk_write_pending ||
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 icsk=
->icsk_accept_queue.rskq_defer_accept ||
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inet=
_csk_in_pingpong_mode(sk)) {
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!sk_is_mptcp(sk) && (sk-=
>sk_write_pending ||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 icsk->icsk_accept_queue.rskq_defer_accept ||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 inet_csk_in_pingpong_mode(sk))) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Sa=
ve one ACK. Data will be ready after
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * several ticks, if write_pending is set.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 *
>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>> index b4b2284ed4a2..864517e63bdf 100644
>> --- a/net/ipv4/tcp_output.c
>> +++ b/net/ipv4/tcp_output.c
>> @@ -747,7 +747,7 @@ static void mptcp_set_option_cond(const struct=20
>> request_sock *req,
>> =C2=A0=C2=A0=C2=A0=C2=A0if (rsk_is_mptcp(req)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int size;
>>
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mptcp_synack_options(req=
, &size, &opts->mptcp)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mptcp_synack_options(req=
, &size, &opts->mptcp,=20
>> &opts->options)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (*=
remaining >=3D size) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 opts->options |=3D OPTION_MPTCP;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 *remaining -=3D size;
>> @@ -822,7 +822,6 @@ static unsigned int tcp_syn_options(struct sock=20
>> *sk, struct sk_buff *skb,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tp->s=
yn_fastopen_exp =3D fastopen->cookie.exp ? 1 : 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0}
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0smc_set_option(tp, opts, &remaining);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0if (sk_is_mptcp(sk)) {
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index be3b918a6d15..ebcb9c04ead9 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -887,16 +887,20 @@ bool mptcp_established_options(struct sock *sk,=20
>> struct sk_buff *skb,
>> }
>>
>> bool mptcp_synack_options(const struct request_sock *req, unsigned int=
=20
>> *size,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct mptcp_out_options *opts)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct mptcp_out_options *opts, u16 *tcp_options)
>> {
>> =C2=A0=C2=A0=C2=A0=C2=A0struct mptcp_subflow_request_sock *subflow_req =
=3D=20
>> mptcp_subflow_rsk(req);
>> +#define OPTION_TS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(1)
>> +
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *tcp_options ^=3D OPTION_TS;
>=20
> Did you try setting tstamp_ok =3D 0 in the inet_request_sock, so=20
> tcp_synack_options() doesn't consume the space for the timestamp option=
=20
> to begin with?

Something like this?

         struct inet_request_sock *ireq =3D inet_rsk(req);
         ireq->tstamp_ok =3D 0;

I'm not sure it will help... Because a function mptcp_synack_options is=20
a part of mptcp_set_option_cond(req, opts, &remaining) that is called in=20
the end of tcp_synack_options after all.


>>
>> =C2=A0=C2=A0=C2=A0=C2=A0if (subflow_req->mp_capable) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opts->suboptions =3D OPTION_M=
PTCP_MPC_SYNACK;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opts->sndr_key =3D subflow_re=
q->local_key;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opts->csum_reqd =3D subflow_r=
eq->csum_reqd;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opts->allow_join_id0 =3D subf=
low_req->allow_join_id0;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *size =3D TCPOLEN_MPTCP_MPC_=
SYNACK;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *size =3D TCPOLEN_MPTCP_MPC_=
SYNACK=C2=A0 - TCPOLEN_TSTAMP_ALIGNED +=20
>> TCPOLEN_SACKPERM_ALIGNED;
>=20
> It's important to keep the timestamp and SACK logic in=20
> tcp_synack_options() so this function won't have to readjust the options=
=20
> size based on whatever combination of fastopen/timestamps/sack are enable=
d.

So does this mean we are allowed to modify it?
If yes -> I think to move this(code below) to the end of=20
tcp_synack_options. In this case we can set tstamp_ok =3D 0 in the=20
inet_requst_sock in the mptcp_synack_options.

=09if (likely(ireq->tstamp_ok)) {
=09=09opts->options |=3D OPTION_TS;
=09=09opts->tsval =3D tcp_skb_timestamp(skb) + tcp_rsk(req)->ts_off;
=09=09opts->tsecr =3D req->ts_recent;
=09=09remaining -=3D TCPOLEN_TSTAMP_ALIGNED;
=09}
=09if (likely(ireq->sack_ok)) {
=09=09opts->options |=3D OPTION_SACK_ADVERTISE;
=09=09if (unlikely(!ireq->tstamp_ok))
=09=09=09remaining -=3D TCPOLEN_SACKPERM_ALIGNED;
=09}

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_debug("subflow_req=3D%p, l=
ocal_key=3D%llu",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 subflow_req, subflow_req->local_key);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index d6aef4b13b8a..6649088baae5 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -54,6 +54,8 @@ static struct percpu_counter mptcp_sockets_allocated=
=20
>> ____cacheline_aligned_in_sm
>>
>> static void __mptcp_destroy_sock(struct sock *sk);
>> static void __mptcp_check_send_data_fin(struct sock *sk);
>> +static int mptcp_stream_connect(struct socket *sock, struct sockaddr=20
>> *uaddr,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 int addr_len, int flags);
>>
>> DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
>> static struct net_device mptcp_napi_dev;
>> @@ -1673,6 +1675,53 @@ static void __mptcp_subflow_push_pending(struct=
=20
>> sock *sk, struct sock *ssk)
>> =C2=A0=C2=A0=C2=A0=C2=A0}
>> }
>>
>> +static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t len, struct mptcp_sock *msk, size_=
t copied)
>> +{
>> +=C2=A0=C2=A0=C2=A0 const struct iphdr *iph;
>> +=C2=A0=C2=A0=C2=A0 struct ubuf_info *uarg;
>> +=C2=A0=C2=A0=C2=A0 struct sockaddr *uaddr;
>> +=C2=A0=C2=A0=C2=A0 struct sk_buff *skb;
>> +=C2=A0=C2=A0=C2=A0 struct tcp_sock *tp;
>> +=C2=A0=C2=A0=C2=A0 struct socket *ssk;
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 ssk =3D __mptcp_nmpc_socket(msk);
>> +=C2=A0=C2=A0=C2=A0 if (unlikely(!ssk))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_EFAULT;
>=20
> Need to lock_sock() / release_sock() for both sk and ssk here. Be sure=20
> to observe the correct locking order (sk acquired first, released last).
Understood. I will check that.

>> +=C2=A0=C2=A0=C2=A0 skb =3D tcp_stream_alloc_skb(ssk->sk, 0, ssk->sk->sk=
_allocation,=20
>> true);
>> +=C2=A0=C2=A0=C2=A0 if (unlikely(!skb))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_EFAULT;
>> +=C2=A0=C2=A0=C2=A0 iph =3D ip_hdr(skb);
>> +=C2=A0=C2=A0=C2=A0 if (unlikely(!iph))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_EFAULT;
>> +=C2=A0=C2=A0=C2=A0 uarg =3D msg_zerocopy_realloc(sk, len, skb_zcopy(skb=
));
>> +=C2=A0=C2=A0=C2=A0 if (unlikely(!uarg))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_EFAULT;
>> +=C2=A0=C2=A0=C2=A0 uaddr =3D msg->msg_name;
>> +
>> +=C2=A0=C2=A0=C2=A0 tp =3D tcp_sk(ssk->sk);
>> +=C2=A0=C2=A0=C2=A0 if (unlikely(!tp))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_EFAULT;
>> +=C2=A0=C2=A0=C2=A0 if (!tp->fastopen_req)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tp->fastopen_req =3D kzalloc=
(sizeof(*tp->fastopen_req),=20
>> ssk->sk->sk_allocation);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (unlikely(!tp->fastopen_req))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_EFAULT;
>> +=C2=A0=C2=A0=C2=A0 tp->fastopen_req->data =3D msg;
>> +=C2=A0=C2=A0=C2=A0 tp->fastopen_req->size =3D len;
>> +=C2=A0=C2=A0=C2=A0 tp->fastopen_req->uarg =3D uarg;
>>=20
>> Similar to how mptcp_sendmsg() has to reimplement tcp_sendmsg() because=
=20
>> of all the custom handling of the MPTCP retransmit queue and=20
>> coordinating the mappings and data, I don't think the normal TCP=20
>> fastopen code invoked by ssock->ops->connect() in mptcp_stream_connect()=
=20
>> is going to work out-of-the-box.
>>=20
>> I haven't had a chance to look at how the multipath-tcp.org kernel=20
>> handles that yet, it might be good to check that out
>=20
> I realized what I said here might not be correct. Since the initial data=
=20
> is not part of the DSS-mapped sequence space, it doesn't need to be=20
> stored for possible retransmission. The regular TCP fastopen code for=20
> adding the data skb to the SYN packet might be ok on the transmit side.
>=20
> - Mat


Okay.


>> +
>> +=C2=A0=C2=A0=C2=A0 /* requests a cookie */
>> +=C2=A0=C2=A0=C2=A0 ret =3D mptcp_stream_connect(sk->sk_socket, uaddr,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msg->msg_namelen, msg->msg_flags);
>> +
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +out_EFAULT:
>> +=C2=A0=C2=A0=C2=A0 ret =3D -EFAULT;
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +
>> static void mptcp_set_nospace(struct sock *sk)
>> {
>> =C2=A0=C2=A0=C2=A0=C2=A0/* enable autotune */
>> @@ -1690,9 +1739,9 @@ static int mptcp_sendmsg(struct sock *sk, struct=
=20
>> msghdr *msg, size_t len)
>> =C2=A0=C2=A0=C2=A0=C2=A0int ret =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0long timeo;
>>
>> -=C2=A0=C2=A0=C2=A0 /* we don't support FASTOPEN yet */
>> +=C2=A0=C2=A0=C2=A0 /* we don't fully support FASTOPEN yet */
>> =C2=A0=C2=A0=C2=A0=C2=A0if (msg->msg_flags & MSG_FASTOPEN)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EOPNOTSUPP;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D mptcp_sendmsg_fastop=
en(sk, msg, len, msk, copied);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0/* silently ignore everything else */
>> =C2=A0=C2=A0=C2=A0=C2=A0msg->msg_flags &=3D MSG_MORE | MSG_DONTWAIT | MS=
G_NOSIGNAL;
>> @@ -2558,10 +2607,10 @@ static void mptcp_worker(struct work_struct=20
>> *work)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW,=
 &msk->flags))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __mptcp_close_subflow(msk);
>> -
>> +/*
>> =C2=A0=C2=A0=C2=A0=C2=A0if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->fla=
gs))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __mptcp_retrans(sk);
>> -
>> +*/
>> =C2=A0=C2=A0=C2=A0=C2=A0mptcp_mp_fail_no_response(msk);
>>
>> unlock:
>> @@ -2681,6 +2730,8 @@ void mptcp_subflow_shutdown(struct sock *sk,=20
>> struct sock *ssk, int how)
>> =C2=A0=C2=A0=C2=A0=C2=A0case TCP_SYN_SENT:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcp_disconnect(ssk, O_NONBLOC=
K);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 case TCP_ESTABLISHED:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>=20
> This would prevent subflows from being closed by any calls to=20
> mptcp_subflow_shutdown() - I'm curious what caused you to add this?

I observer this exchange when "break" is abscent (please have a look at=20
lines 16-19.

     1   0.000000 5a:32:1b:03:7b:fd =E2=86=92              ARP 44      Who =
has=20
10.0.0.2? Tell 10.0.0.1
     2   0.000028 5e:44:20:24:ea:59 =E2=86=92              ARP 44      10.0=
.0.2=20
is at 5e:44:20:24:ea:59
     3   0.000036     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 84  0 1 0  5686=
0 =E2=86=92=20
7003 [SYN] Seq=3D0 Win=3D64240 Len=3D0 MSS=3D1460 SACK_PERM=3D1 TSval=3D162=
2166160=20
TSecr=3D0 WS=3D128 TFO=3DR
     4   0.000076     10.0.0.2 =E2=86=92 10.0.0.1     MPTCP 92  0 1 1  7003=
 =E2=86=92=20
56860 [SYN, ACK] Seq=3D0 Ack=3D1 Win=3D65160 Len=3D0 MSS=3D1460 SACK_PERM=
=3D1 WS=3D128=20
TFO=3DC
     5   0.000108     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 76  1 1 1  5686=
0 =E2=86=92=20
7003 [ACK] Seq=3D1 Ack=3D1 Win=3D64256 Len=3D0
     6   0.000234     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 83 3 1 4 1 =E2=
=9C=93 56860 =E2=86=92=20
7003 [PSH, ACK] Seq=3D1 Ack=3D1 Win=3D64256 Len=3D3
     7   0.000247     10.0.0.2 =E2=86=92 10.0.0.1     MPTCP 80  1 1 4  7003=
 =E2=86=92=20
56860 [ACK] Seq=3D1 Ack=3D4 Win=3D65280 Len=3D0 TSval=3D15353468 TSecr=3D16=
22166160
     8   0.001918     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 83 3 4 7 1 =E2=
=9C=93 56860 =E2=86=92=20
7003 [PSH, ACK] Seq=3D4 Ack=3D1 Win=3D64256 Len=3D3
     9   0.001937     10.0.0.2 =E2=86=92 10.0.0.1     MPTCP 80  1 1 7  7003=
 =E2=86=92=20
56860 [ACK] Seq=3D1 Ack=3D7 Win=3D65280 Len=3D0 TSval=3D15353469 TSecr=3D16=
22166160
    10   0.001986     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 83 3 7 10 1 =E2=
=9C=93 56860=20
=E2=86=92 7003 [PSH, ACK] Seq=3D7 Ack=3D1 Win=3D64256 Len=3D3
    11   0.001993     10.0.0.2 =E2=86=92 10.0.0.1     MPTCP 80  1 1 10  700=
3 =E2=86=92=20
56860 [ACK] Seq=3D1 Ack=3D10 Win=3D65280 Len=3D0 TSval=3D15353469 TSecr=3D1=
622166160
    12   0.002016     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 83 3 10 13 1 =
=E2=9C=93 56860=20
=E2=86=92 7003 [PSH, ACK] Seq=3D10 Ack=3D1 Win=3D64256 Len=3D3
    13   0.002023     10.0.0.2 =E2=86=92 10.0.0.1     MPTCP 80  1 1 13  700=
3 =E2=86=92=20
56860 [ACK] Seq=3D1 Ack=3D13 Win=3D65280 Len=3D0 TSval=3D15353469 TSecr=3D1=
622166160
    14   0.002043     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 83 3 13 16 1 =
=E2=9C=93 56860=20
=E2=86=92 7003 [PSH, ACK] Seq=3D13 Ack=3D1 Win=3D64256 Len=3D3
    15   0.002048     10.0.0.2 =E2=86=92 10.0.0.1     MPTCP 80  1 1 16  700=
3 =E2=86=92=20
56860 [ACK] Seq=3D1 Ack=3D16 Win=3D65280 Len=3D0 TSval=3D15353469 TSecr=3D1=
622166160
    16   0.002070     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 80  16 16 1  [T=
CP=20
Dup ACK 5#1] 56860 =E2=86=92 7003 [ACK] Seq=3D16 Ack=3D1 Win=3D64256 Len=3D=
0
    17   0.002100     10.0.0.2 =E2=86=92 10.0.0.1     MPTCP 80  1 1 16  [TC=
P Dup=20
ACK 15#1] 7003 =E2=86=92 56860 [ACK] Seq=3D1 Ack=3D16 Win=3D65280 Len=3D0 T=
Sval=3D15353469=20
TSecr=3D1622166160
    18   0.004087     10.0.0.2 =E2=86=92 10.0.0.1     MPTCP 96  1 1 16  [TC=
P Dup=20
ACK 15#2] 7003 =E2=86=92 56860 [ACK] Seq=3D1 Ack=3D16 Win=3D65280 Len=3D0 T=
Sval=3D15353469=20
TSecr=3D1622166160
    19   0.004182     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 64  16 16 1  [T=
CP=20
Dup ACK 5#2] 56860 =E2=86=92 7003 [ACK] Seq=3D16 Ack=3D1 Win=3D64256 Len=3D=
0
    20   0.004195     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 64  16 17 1  56=
860 =E2=86=92=20
7003 [FIN, ACK] Seq=3D16 Ack=3D1 Win=3D64256 Len=3D0
    21   0.004209     10.0.0.2 =E2=86=92 10.0.0.1     MPTCP 80  1 2 17  700=
3 =E2=86=92=20
56860 [FIN, ACK] Seq=3D1 Ack=3D17 Win=3D65280 Len=3D0 TSval=3D15353472=20
TSecr=3D1622166160
    22   0.004235     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 64  17 17 2  56=
860 =E2=86=92=20
7003 [ACK] Seq=3D17 Ack=3D2 Win=3D64256 Len=3D0
    23   0.588626 fe80::5832:1bff:fe03:7bfd =E2=86=92 ff02::2      ICMPv6 7=
2=20
   Router Solicitation from 5a:32:1b:03:7b:fd
    24   3.361860 fe80::5c44:20ff:fe24:ea59 =E2=86=92 ff02::2      ICMPv6 7=
2=20
   Router Solicitation from 5e:44:20:24:ea:59
    25   5.068551 5e:44:20:24:ea:59 =E2=86=92              ARP 44      Who =
has=20
10.0.0.1? Tell 10.0.0.2
    26   5.068640 5a:32:1b:03:7b:fd =E2=86=92              ARP 44      10.0=
.0.1=20
is at 5a:32:1b:03:7b:fd
    27   5.645553     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 95 3 0 4 0 =E2=
=9C=93 56862 =E2=86=92=20
7003 [SYN] Seq=3D0 Win=3D64240 Len=3D3 MSS=3D1460 SACK_PERM=3D1 TSval=3D162=
2171806=20
TSecr=3D0 WS=3D128 TFO=3DC
    28   5.645634     10.0.0.2 =E2=86=92 10.0.0.1     MPTCP 80  0 1 4  7003=
 =E2=86=92=20
56862 [SYN, ACK] Seq=3D0 Ack=3D4 Win=3D65160 Len=3D0 MSS=3D1460 SACK_PERM=
=3D1 WS=3D128
    29   5.645661     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 76  4 4 1  5686=
2 =E2=86=92=20
7003 [ACK] Seq=3D4 Ack=3D1 Win=3D64256 Len=3D0
    30   5.647081     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 83 3 4 7 1 =E2=
=9C=93 56862 =E2=86=92=20
7003 [PSH, ACK] Seq=3D4 Ack=3D1 Win=3D64256 Len=3D3
    31   5.647131     10.0.0.2 =E2=86=92 10.0.0.1     MPTCP 80  1 1 7  7003=
 =E2=86=92=20
56862 [ACK] Seq=3D1 Ack=3D7 Win=3D65280 Len=3D0 TSval=3D15359115 TSecr=3D16=
22171806
    32   5.647497     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 83 3 7 10 1 =E2=
=9C=93 56862=20
=E2=86=92 7003 [PSH, ACK] Seq=3D7 Ack=3D1 Win=3D64256 Len=3D3
    33   5.647526     10.0.0.2 =E2=86=92 10.0.0.1     MPTCP 80  1 1 10  700=
3 =E2=86=92=20
56862 [ACK] Seq=3D1 Ack=3D10 Win=3D65280 Len=3D0 TSval=3D15359115 TSecr=3D1=
622171806
    34   5.647827     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 83 3 10 13 1 =
=E2=9C=93 56862=20
=E2=86=92 7003 [PSH, ACK] Seq=3D10 Ack=3D1 Win=3D64256 Len=3D3
    35   5.647864     10.0.0.2 =E2=86=92 10.0.0.1     MPTCP 80  1 1 13  700=
3 =E2=86=92=20
56862 [ACK] Seq=3D1 Ack=3D13 Win=3D65280 Len=3D0 TSval=3D15359115 TSecr=3D1=
622171806
    36   5.648198     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 83 3 13 16 1 =
=E2=9C=93 56862=20
=E2=86=92 7003 [PSH, ACK] Seq=3D13 Ack=3D1 Win=3D64256 Len=3D3
    37   5.648228     10.0.0.2 =E2=86=92 10.0.0.1     MPTCP 80  1 1 16  700=
3 =E2=86=92=20
56862 [ACK] Seq=3D1 Ack=3D16 Win=3D65280 Len=3D0 TSval=3D15359116 TSecr=3D1=
622171806
    38   5.648671     10.0.0.2 =E2=86=92 10.0.0.1     MPTCP 96  1 1 16  [TC=
P Dup=20
ACK 37#1] 7003 =E2=86=92 56862 [ACK] Seq=3D1 Ack=3D16 Win=3D65280 Len=3D0 T=
Sval=3D15359116=20
TSecr=3D1622171806
    39   5.648732     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 64  16 16 1  [T=
CP=20
Dup ACK 29#1] 56862 =E2=86=92 7003 [ACK] Seq=3D16 Ack=3D1 Win=3D64256 Len=
=3D0
    40   5.648743     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 80  16 16 1  [T=
CP=20
Dup ACK 29#2] 56862 =E2=86=92 7003 [ACK] Seq=3D16 Ack=3D1 Win=3D64256 Len=
=3D0
    41  15.948621 fe80::5832:1bff:fe03:7bfd =E2=86=92 ff02::2      ICMPv6 7=
2=20
   Router Solicitation from 5a:32:1b:03:7b:fd

With "break" what is not normal (I agree) as you also mentioned, I=20
observe this (seems ok for me):

     5   1.702231     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 84  0 1 0  5275=
6 =E2=86=92=20
7003 [SYN] Seq=3D0 Win=3D64240 Len=3D0 MSS=3D1460 SACK_PERM=3D1 TSval=3D250=
7020170=20
TSecr=3D0 WS=3D128 TFO=3DR
     6   1.702251     10.0.0.2 =E2=86=92 10.0.0.1     MPTCP 92  0 1 1  7003=
 =E2=86=92=20
52756 [SYN, ACK] Seq=3D0 Ack=3D1 Win=3D65160 Len=3D0 MSS=3D1460 SACK_PERM=
=3D1 WS=3D128=20
TFO=3DC
     7   1.702270     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 76  1 1 1  5275=
6 =E2=86=92=20
7003 [ACK] Seq=3D1 Ack=3D1 Win=3D64256 Len=3D0
     8   1.702316     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 83 3 1 4 1 =E2=
=9C=93 52756 =E2=86=92=20
7003 [PSH, ACK] Seq=3D1 Ack=3D1 Win=3D64256 Len=3D3
     9   1.702338     10.0.0.2 =E2=86=92 10.0.0.1     MPTCP 80  1 1 4  7003=
 =E2=86=92=20
52756 [ACK] Seq=3D1 Ack=3D4 Win=3D65280 Len=3D0 TSval=3D696906899 TSecr=3D2=
507020170
    10   1.703196     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 83 3 4 7 1 =E2=
=9C=93 52756 =E2=86=92=20
7003 [PSH, ACK] Seq=3D4 Ack=3D1 Win=3D64256 Len=3D3
    11   1.703221     10.0.0.2 =E2=86=92 10.0.0.1     MPTCP 80  1 1 7  7003=
 =E2=86=92=20
52756 [ACK] Seq=3D1 Ack=3D7 Win=3D65280 Len=3D0 TSval=3D696906900 TSecr=3D2=
507020170
    12   1.703231     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 83 3 7 10 1 =E2=
=9C=93 52756=20
=E2=86=92 7003 [PSH, ACK] Seq=3D7 Ack=3D1 Win=3D64256 Len=3D3
    13   1.703234     10.0.0.2 =E2=86=92 10.0.0.1     MPTCP 80  1 1 10  700=
3 =E2=86=92=20
52756 [ACK] Seq=3D1 Ack=3D10 Win=3D65280 Len=3D0 TSval=3D696906900 TSecr=3D=
2507020170
    14   1.703240     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 83 3 10 13 1 =
=E2=9C=93 52756=20
=E2=86=92 7003 [PSH, ACK] Seq=3D10 Ack=3D1 Win=3D64256 Len=3D3
    15   1.703242     10.0.0.2 =E2=86=92 10.0.0.1     MPTCP 80  1 1 13  700=
3 =E2=86=92=20
52756 [ACK] Seq=3D1 Ack=3D13 Win=3D65280 Len=3D0 TSval=3D696906900 TSecr=3D=
2507020170
    16   1.703246     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 83 3 13 16 1 =
=E2=9C=93 52756=20
=E2=86=92 7003 [PSH, ACK] Seq=3D13 Ack=3D1 Win=3D64256 Len=3D3
    17   1.703248     10.0.0.2 =E2=86=92 10.0.0.1     MPTCP 80  1 1 16  700=
3 =E2=86=92=20
52756 [ACK] Seq=3D1 Ack=3D16 Win=3D65280 Len=3D0 TSval=3D696906900 TSecr=3D=
2507020170
    18   6.826669 5e:44:20:24:ea:59 =E2=86=92              ARP 44      Who =
has=20
10.0.0.1? Tell 10.0.0.2
    19   6.826783 5a:32:1b:03:7b:fd =E2=86=92              ARP 44      10.0=
.0.1=20
is at 5a:32:1b:03:7b:fd
    20   7.253337 fe80::5c44:20ff:fe24:ea59 =E2=86=92 ff02::2      ICMPv6 7=
2=20
   Router Solicitation from 5e:44:20:24:ea:59
    21   7.680014 fe80::5832:1bff:fe03:7bfd =E2=86=92 ff02::2      ICMPv6 7=
2=20
   Router Solicitation from 5a:32:1b:03:7b:fd
    22  21.973339 fe80::5c44:20ff:fe24:ea59 =E2=86=92 ff02::2      ICMPv6 7=
2=20
   Router Solicitation from 5e:44:20:24:ea:59
    23  23.680053 fe80::5832:1bff:fe03:7bfd =E2=86=92 ff02::2      ICMPv6 7=
2=20
   Router Solicitation from 5a:32:1b:03:7b:fd
    24  52.693332 fe80::5c44:20ff:fe24:ea59 =E2=86=92 ff02::2      ICMPv6 7=
2=20
   Router Solicitation from 5e:44:20:24:ea:59
    25  56.106676 fe80::5832:1bff:fe03:7bfd =E2=86=92 ff02::2      ICMPv6 7=
2=20
   Router Solicitation from 5a:32:1b:03:7b:fd
    26  62.933206     10.0.0.2 =E2=86=92 10.0.0.1     MPTCP 96  1 2 16  700=
3 =E2=86=92=20
52756 [FIN, ACK] Seq=3D1 Ack=3D16 Win=3D65280 Len=3D0 TSval=3D696968130=20
TSecr=3D2507020170
    27  62.933223     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 80  16 17 1  52=
756 =E2=86=92=20
7003 [FIN, ACK] Seq=3D16 Ack=3D1 Win=3D64256 Len=3D0
    28  62.933303     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 80  17 17 2  52=
756 =E2=86=92=20
7003 [ACK] Seq=3D17 Ack=3D2 Win=3D64256 Len=3D0
    29  62.933319     10.0.0.2 =E2=86=92 10.0.0.1     MPTCP 96  2 2 17  700=
3 =E2=86=92=20
52756 [ACK] Seq=3D2 Ack=3D17 Win=3D65280 Len=3D0 TSval=3D696968130 TSecr=3D=
2507020170
    30  67.754885     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 95 3 0 4 0 =E2=
=9C=93 51742 =E2=86=92=20
7003 [SYN] Seq=3D0 Win=3D64240 Len=3D3 MSS=3D1460 SACK_PERM=3D1 TSval=3D250=
7086222=20
TSecr=3D0 WS=3D128 TFO=3DC
    31  67.754921     10.0.0.2 =E2=86=92 10.0.0.1     MPTCP 80  0 1 4  7003=
 =E2=86=92=20
51742 [SYN, ACK] Seq=3D0 Ack=3D4 Win=3D65160 Len=3D0 MSS=3D1460 SACK_PERM=
=3D1 WS=3D128
    32  67.754983     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 76  4 4 1  5174=
2 =E2=86=92=20
7003 [ACK] Seq=3D4 Ack=3D1 Win=3D64256 Len=3D0
    33  67.756278     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 83 3 4 7 1 =E2=
=9C=93 51742 =E2=86=92=20
7003 [PSH, ACK] Seq=3D4 Ack=3D1 Win=3D64256 Len=3D3
    34  67.756326     10.0.0.2 =E2=86=92 10.0.0.1     MPTCP 80  1 1 7  7003=
 =E2=86=92=20
51742 [ACK] Seq=3D1 Ack=3D7 Win=3D65280 Len=3D0 TSval=3D696972953 TSecr=3D2=
507086222
    35  67.756368     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 83 3 7 10 1 =E2=
=9C=93 51742=20
=E2=86=92 7003 [PSH, ACK] Seq=3D7 Ack=3D1 Win=3D64256 Len=3D3
    36  67.756375     10.0.0.2 =E2=86=92 10.0.0.1     MPTCP 80  1 1 10  700=
3 =E2=86=92=20
51742 [ACK] Seq=3D1 Ack=3D10 Win=3D65280 Len=3D0 TSval=3D696972953 TSecr=3D=
2507086222
    37  67.756393     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 83 3 10 13 1 =
=E2=9C=93 51742=20
=E2=86=92 7003 [PSH, ACK] Seq=3D10 Ack=3D1 Win=3D64256 Len=3D3
    38  67.756401     10.0.0.2 =E2=86=92 10.0.0.1     MPTCP 80  1 1 13  700=
3 =E2=86=92=20
51742 [ACK] Seq=3D1 Ack=3D13 Win=3D65280 Len=3D0 TSval=3D696972953 TSecr=3D=
2507086222
    39  67.756417     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 83 3 13 16 1 =
=E2=9C=93 51742=20
=E2=86=92 7003 [PSH, ACK] Seq=3D13 Ack=3D1 Win=3D64256 Len=3D3
    40  67.756422     10.0.0.2 =E2=86=92 10.0.0.1     MPTCP 80  1 1 16  700=
3 =E2=86=92=20
51742 [ACK] Seq=3D1 Ack=3D16 Win=3D65280 Len=3D0 TSval=3D696972953 TSecr=3D=
2507086222
    41 112.426695 fe80::5c44:20ff:fe24:ea59 =E2=86=92 ff02::2      ICMPv6 7=
2=20
   Router Solicitation from 5e:44:20:24:ea:59
    42 119.253281 fe80::5832:1bff:fe03:7bfd =E2=86=92 ff02::2      ICMPv6 7=
2=20
   Router Solicitation from 5a:32:1b:03:7b:fd
    43 127.786550     10.0.0.2 =E2=86=92 10.0.0.1     MPTCP 96  1 2 16  700=
3 =E2=86=92=20
51742 [FIN, ACK] Seq=3D1 Ack=3D16 Win=3D65280 Len=3D0 TSval=3D697032983=20
TSecr=3D2507086222
    44 127.786674     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 80  16 17 1  51=
742 =E2=86=92=20
7003 [FIN, ACK] Seq=3D16 Ack=3D1 Win=3D64256 Len=3D0
    45 127.786696     10.0.0.2 =E2=86=92 10.0.0.1     MPTCP 96  2 2 17  700=
3 =E2=86=92=20
51742 [ACK] Seq=3D2 Ack=3D17 Win=3D65280 Len=3D0 TSval=3D697032983 TSecr=3D=
2507086222
    46 127.786720     10.0.0.1 =E2=86=92 10.0.0.2     MPTCP 80  17 17 2  51=
742 =E2=86=92=20
7003 [ACK] Seq=3D17 Ack=3D2 Win=3D64256 Len=3D0




>> =C2=A0=C2=A0=C2=A0=C2=A0default:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (__mptcp_check_fallback(mp=
tcp_sk(sk))) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_de=
bug("Fallback");
>> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
>> index 423d3826ca1e..e1ae1ef224cf 100644
>> --- a/net/mptcp/sockopt.c
>> +++ b/net/mptcp/sockopt.c
>> @@ -560,6 +560,8 @@ static bool mptcp_supported_sockopt(int level, int=
=20
>> optname)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case TCP_TX_DELAY:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case TCP_INQ:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n true;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case TCP_FASTOPEN:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn true;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* TCP_MD5SIG, TCP_MD5SIG_EXT=
 are not supported, MD5 is not=20
>> compatible with MPTCP */
>> @@ -768,6 +770,43 @@ static int mptcp_setsockopt_sol_tcp_defer(struct=20
>> mptcp_sock *msk, sockptr_t optv
>> =C2=A0=C2=A0=C2=A0=C2=A0return tcp_setsockopt(listener->sk, SOL_TCP, TCP=
_DEFER_ACCEPT,=20
>> optval, optlen);
>> }
>>
>> +static int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk,=20
>> sockptr_t optval,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 unsigned int optlen)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct mptcp_subflow_context *subflow;
>> +=C2=A0=C2=A0=C2=A0 struct sock *sk =3D (struct sock *)msk;
>> +=C2=A0=C2=A0=C2=A0 struct net *net =3D sock_net(sk);
>> +=C2=A0=C2=A0=C2=A0 int val;
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (copy_from_sockptr(&val, optval, sizeof(val)))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EFAULT;
>> +
>> +=C2=A0=C2=A0=C2=A0 lock_sock(sk);
>> +
>> +=C2=A0=C2=A0=C2=A0 mptcp_for_each_subflow(msk, subflow) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sock *ssk =3D mptcp_s=
ubflow_tcp_sock(subflow);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock_sock(ssk);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val >=3D 0 && ((1 << sk-=
>sk_state) & (TCPF_CLOSE |
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TCPF=
_LISTEN))) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcp_=
fastopen_init_key_once(net);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fast=
open_queue_tune(sk, val);
>=20
> Need to use ssk instead of sk in these several lines, right?
Heh) I will check this, thanks!

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D -EINVAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 release_sock(ssk);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 release_sock(sk);
>> +
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +
>> static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sockptr_t optval, unsigned int o=
ptlen)
>> {
>> @@ -796,6 +835,8 @@ static int mptcp_setsockopt_sol_tcp(struct=20
>> mptcp_sock *msk, int optname,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return mptcp_setsockopt_sol_t=
cp_nodelay(msk, optval, optlen);
>> =C2=A0=C2=A0=C2=A0=C2=A0case TCP_DEFER_ACCEPT:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return mptcp_setsockopt_sol_t=
cp_defer(msk, optval, optlen);
>> +=C2=A0=C2=A0=C2=A0 case TCP_FASTOPEN:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return mptcp_setsockopt_sol_=
tcp_fastopen(msk, optval, optlen);
>> =C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0return -EOPNOTSUPP;
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index 8841e8cd9ad8..f732e41e12df 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -1002,16 +1002,17 @@ static enum mapping_status=20
>> get_mapping_status(struct sock *ssk,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sk_ea=
t_skb(ssk, skb);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n MAPPING_EMPTY;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -
>> +/*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!subflow->map_valid)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n MAPPING_INVALID;
>> -
>> +*/
>=20
> Yeah, there's some work to do to handle TFO data since the RFC says it=20
> is not part of the data sequence number space. Fastopen will need to=20
> move the SYN data directly to the msk->receive_queue, bypassing the=20
> normal mapping code.
I will check that, thanks for the tip.

>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto validate_seq;
>> =C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0trace_get_mapping_status(mpext);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0data_len =3D mpext->data_len;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0if (data_len =3D=3D 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_debug("infinite mapping re=
ceived");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MPTCP_INC_STATS(sock_net(ssk)=
, MPTCP_MIB_INFINITEMAPRX);
>> @@ -1075,6 +1076,7 @@ static enum mapping_status=20
>> get_mapping_status(struct sock *ssk,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If this skb data are fully=
 covered by the current mapping,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the new map would nee=
d caching, which is not supported
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (skb_is_fully_mapped(ssk, =
skb)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MPTCP=
_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSNOMATCH);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n MAPPING_INVALID;
>> @@ -1107,11 +1109,12 @@ static enum mapping_status=20
>> get_mapping_status(struct sock *ssk,
>> =C2=A0=C2=A0=C2=A0=C2=A0/* we revalidate valid mapping on new skb, becau=
se we must ensure
>> =C2=A0=C2=A0=C2=A0=C2=A0 * the current skb is completely covered by the =
available mapping
>> =C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0if (!validate_mapping(ssk, skb)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MPTCP_INC_STATS(sock_net(ssk)=
, MPTCP_MIB_DSSTCPMISMATCH);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return MAPPING_INVALID;
>> =C2=A0=C2=A0=C2=A0=C2=A0}
>> -
>> +=C2=A0=C2=A0=C2=A0 */
>=20
> If the fastopen data bypasses the normal mptcp receive path, mappings=20
> can still be validated (as they must be :) ) for regular data.
>=20

No objections :)

>> =C2=A0=C2=A0=C2=A0=C2=A0skb_ext_del(skb, SKB_EXT_MPTCP);
>>
>> validate_csum:
>> --=20
>> 2.25.1
>>
>>
>>

Btw, I noticed one more thing:

Without this messy modification, userspace receiver doesn't get the data:

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8841e8cd9ad8..b72527d6398c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1002,10 +1002,10 @@ static enum mapping_status=20
get_mapping_status(struct sock *ssk,
                         sk_eat_skb(ssk, skb);
                         return MAPPING_EMPTY;
                 }
-
+/*
                 if (!subflow->map_valid)
                         return MAPPING_INVALID;
-
+*/
                 goto validate_seq;
         }

@@ -1084,6 +1084,15 @@ static enum mapping_status=20
get_mapping_status(struct sock *ssk,
                 goto validate_csum;
         }

+       skb =3D skb_peek(&ssk->sk_receive_queue);
+       subflow->map_valid =3D 1;
+       subflow->map_seq =3D READ_ONCE(msk->ack_seq);
+       subflow->map_data_len =3D skb->len;
+       subflow->map_subflow_seq =3D tcp_sk(ssk)->copied_seq -=20
subflow->ssn_offset;
+
+       WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_DATA_AVAIL);
+       goto validate_csum;
+/*
         subflow->map_seq =3D map_seq;
         subflow->map_subflow_seq =3D mpext->subflow_seq;
         subflow->map_data_len =3D data_len;
@@ -1093,7 +1102,7 @@ static enum mapping_status=20
get_mapping_status(struct sock *ssk,
         subflow->map_csum_reqd =3D mpext->csum_reqd;
         subflow->map_csum_len =3D 0;
         subflow->map_data_csum =3D csum_unfold(mpext->csum);
-
+*/
         /* Cfr RFC 8684 Section 3.3.0 */
         if (unlikely(subflow->map_csum_reqd !=3D csum_reqd))
                 return MAPPING_INVALID;

>=20
> --=20
> Mat Martineau
> Intel



> Dymtro, it will also be important to add some 'fast open' coverage to=20
> the kernel self tests in this directory of the kernel source tree:
>=20
> tools/testing/selftests/net/mptcp/
>=20
> There's a short guide to running these tests at=20
> https://github.com/multipath-tcp/mptcp_net-next/wiki/Testing#kselftest
>=20
>=20
> We appreciate your work to add this feature to MPTCP in the Linux kernel!
>=20
> --=20
> Mat Martineau
> Intel

I wrote 2 simple userspace tests (sender(with sendmsg) and receiver)=20
using namespaces.
I would add 2 *.c files and 2 *.bash files. But maybe it is better just=20
to alter the existing files in mptcp tests folder?


Dmytro SHYTYI

