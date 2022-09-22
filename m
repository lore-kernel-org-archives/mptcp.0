Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB633229
	for <mptcp@lists.linux.dev>; Thu, 22 Sep 2022 11:50:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663847438; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ERwE3GxAmSJSkz1zCjdsGiE/AEUkUcGslPi9YzE/8Paealg3r6+XrQnqZcEuzpPdzsbGp/XSfkW5vaoJsWGgLCZbwF7p6gvn8siRYLIHNPknNthl3xKsBCMfeVtSA7I0qxgPUbZPIzNVHcfKANXgoauc6ik1dlSTd+g/jmxpRbc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663847438; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=nECqAoa0VSijW+/aaWa0nSBdT+T4VpamGJ9tftCAno4=; 
	b=U0vDaLGNYojBxOc2TJmP6EbkPQ/EHHCWsqwIF910+zVR1wQxaVRoJVTwzbTLN07JCFN6kmvnToTeRIv/hR8xM6EC/M26dqq90Nbqksekmjky2nkkaqlKBqDBr/Rzj7/oFtKExJbL/3rRYZ1uCQAzDOgjNbEPtx427RIIVBUqA1E=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663847438;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:Message-ID:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=nECqAoa0VSijW+/aaWa0nSBdT+T4VpamGJ9tftCAno4=;
	b=W6K0HuLNwGv/hv567YQfYMa0EEGXWW2pUJ+wVhXgsyfii3Ap5qqCNL8GsyQIwVX6
	qpsX+a1LtxKB6umdHaihn0/M1hj/MkxRq0ZAKitiE2NH8i+TvXkz2hF8c/kGcHPKy6J
	8cXdoQJ/AWwfeqJSXrnednATiIElCENxEfqVgjWE=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663847435080260.29147703451963; Thu, 22 Sep 2022 13:50:35 +0200 (CEST)
Date: Thu, 22 Sep 2022 13:50:34 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH mptcp-next v9 5/6] mptcp: add
 subflow_v(4,6)_send_synack()
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20220921125558.19483-1-dmytro@shytyi.net>
 <20220921125558.19483-6-dmytro@shytyi.net>
 <9b128bc8a24d35e3764ef84607ada5758ef55693.camel@redhat.com>
From: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <894db34f-a3ff-d6d1-db0d-ff38f63c695d@shytyi.net>
In-Reply-To: <9b128bc8a24d35e3764ef84607ada5758ef55693.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

Hello Paolo,

Thank you for comments.

My comments are in-line + the new patch in the bottom of this message=20
with corrections.

On 9/21/2022 8:00 PM, Paolo Abeni wrote:
> On Wed, 2022-09-21 at 14:55 +0200, Dmytro Shytyi wrote:
>> In this patch we add skb to the msk, dequeue it from sk, remove TSs and
>> do skb mapping.
>>
>> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
>> ---
>>   net/ipv4/tcp_fastopen.c | 19 +++++++----
>>   net/mptcp/protocol.c    |  2 +-
>>   net/mptcp/protocol.h    |  1 +
>>   net/mptcp/subflow.c     | 70 +++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 85 insertions(+), 7 deletions(-)
>>
>> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
>> index 45cc7f1ca296..d6b1380525ea 100644
>> --- a/net/ipv4/tcp_fastopen.c
>> +++ b/net/ipv4/tcp_fastopen.c
>> @@ -356,13 +356,20 @@ struct sock *tcp_try_fastopen(struct sock *sk, str=
uct sk_buff *skb,
>>   =09if (foc->len =3D=3D 0) /* Client requests a cookie */
>>   =09=09NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPFASTOPENCOOKIEREQD);
>>  =20
>> -=09if (!((tcp_fastopen & TFO_SERVER_ENABLE) &&
>> -=09      (syn_data || foc->len >=3D 0) &&
>> -=09      tcp_fastopen_queue_check(sk))) {
>> -=09=09foc->len =3D -1;
>> -=09=09return NULL;
>> +=09if (sk_is_mptcp(sk)) {
>> +=09=09if (((syn_data || foc->len >=3D 0) &&
>> +=09=09     tcp_fastopen_queue_check(sk))) {
>> +=09=09=09foc->len =3D -1;
>> +=09=09=09return NULL;
>> +=09=09}
>> +=09} else {
>> +=09=09if (!((tcp_fastopen & TFO_SERVER_ENABLE) &&
>> +=09=09      (syn_data || foc->len >=3D 0) &&
>> +=09=09      tcp_fastopen_queue_check(sk))) {
>> +=09=09=09foc->len =3D -1;
>> +=09=09=09return NULL;
>> +=09=09}
>>   =09}
>> -
> Why the above chunk is needed?

I didn't check why yet, but without this I don't have Cookie reply from=20
listener even if I activate fastopen in sysctl.

I realise this is not good to do. Currently it is more like bypass. I am=20
going to look at if later.


>>   =09if (tcp_fastopen_no_cookie(sk, dst, TFO_SERVER_COOKIE_NOT_REQD))
>>   =09=09goto fastopen;
>>  =20
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index d5c502d141b4..6a593be6076b 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -200,7 +200,7 @@ static void mptcp_rfree(struct sk_buff *skb)
>>   =09mptcp_rmem_uncharge(sk, len);
>>   }
>>  =20
>> -static void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk)
>> +void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk)
>>   {
>>   =09skb_orphan(skb);
>>   =09skb->sk =3D sk;
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index b9e251848099..58a04144fff0 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -845,6 +845,7 @@ int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_s=
ock *msk, sockptr_t optval,
>>   =09=09=09=09      unsigned int optlen);
>>   void mptcp_gen_msk_ackseq_fastopen(struct mptcp_sock *msk, struct mptc=
p_subflow_context *subflow,
>>   =09=09=09=09   struct mptcp_options_received mp_opt);
>> +void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk);
>>   // Fast Open Mechanism functions end
>>  =20
>>   static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index 07dd23d0fe04..7deb80c2af69 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -307,6 +307,74 @@ static struct dst_entry *subflow_v4_route_req(const=
 struct sock *sk,
>>   =09return NULL;
>>   }
>>  =20
>> +static int subflow_v4_send_synack(const struct sock *sk, struct dst_ent=
ry *dst,
> If you use 'ssk' instead of 'sk'

I dont think it is a good idea to change sk to ssk as argument and use=20
it because of "const" compiler should throw an error if I will try to=20
dequeue, etc from const struct sock *sk ant it is right. So I retreived=20
ssk from subflow without const to do what is needed.

But still I modify the naming scheme as you suggested.

>> +=09=09=09=09  struct flowi *fl,
>> +=09=09=09=09  struct request_sock *req,
>> +=09=09=09=09  struct tcp_fastopen_cookie *foc,
>> +=09=09=09=09  enum tcp_synack_type synack_type,
>> +=09=09=09=09  struct sk_buff *syn_skb)
>> +{
>> +=09struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
>> +=09struct tcp_request_sock *tcp_r_sock =3D tcp_rsk(req);
>> +=09struct sock *socket =3D mptcp_subflow_ctx(sk)->conn;
> than you can use 'sk' here and respect mptcp convection for variable
> names.
Yes, Fixed.
>> +=09struct inet_request_sock *ireq =3D inet_rsk(req);
>> +=09struct mptcp_sock *msk =3D mptcp_sk(socket);
>> +=09struct sock *var_sk =3D subflow->tcp_sock;
> This should be actually equal to ssk
var_sk changed to ssk
>> +=09struct tcp_sock *tp =3D tcp_sk(sk);
>> +=09struct sk_buff *skb;
> All the above variable should be moved under the 'if (synack_type =3D=3D
> TCP_SYNACK_FASTOPEN) {' branch, as there are used only there.
>
> Additionally if you move all the code in the 'if (synack_type =3D=3D
> TCP_SYNACK_FASTOPEN)' branch in a separate helper you can later reuse
> it in subflow_v6_send_synack()
>
>> +
>> +=09//<evenutally clear tstamp_ok, as needed depending on cookie size>
>> +=09//We add ts here as in the "if" below it has no effect.
> Please, don't use '//' for comments

Oh sorry, Yes in C we don't use these "//", I replaced it with "/* */".


>> +=09if (foc->len > -1) {
>> +=09=09ireq->tstamp_ok =3D 0;
>> +=09}
> No need to add the '{' for a single line 'then' statement; addtionally
> I guess you can move the above check under the below if, and you should
> check for 'foc !=3D NULL'


If I move the foc check into "if", no metter how I modify it : "foc !=3D=20
NULL" or " for !=3D -1", it doesn't affect the TS, but it should.

I suppose I observe this behaviour because of "tcp_conn_request()"=20
starting from line 7013: tcp_input.c - net/ipv4/tcp_input.c - Linux=20
source code (v5.19.10) - Bootlin=20
<https://elixir.bootlin.com/linux/latest/source/net/ipv4/tcp_input.c#L7013>


I keep "foc" check outside "if" statement for the moment.



>
>> +=09if (synack_type =3D=3D TCP_SYNACK_FASTOPEN) {
>> +=09=09// <mark subflow/msk as "mptfo">
>> +=09=09msk->is_mptfo =3D 1;
>> +
>> +=09=09skb =3D skb_peek(&var_sk->sk_receive_queue);
>> +
>> +=09=09//<dequeue the skb from sk receive queue>
>> +=09=09__skb_unlink(skb, &var_sk->sk_receive_queue);
>> +=09=09skb_ext_reset(skb);
>> +=09=09skb_orphan(skb);
>> +
>> +=09=09//<set the skb mapping>
>> +=09=09//Solves: WARNING: at 704 _mptcp_move_skbs_from_subflow+0x5d0/0x6=
51
> Please, drop the WARNING reference.
Fixed
>> +=09=09tp->copied_seq +=3D tp->rcv_nxt - tcp_r_sock->rcv_isn - 1;
>> +
>> +=09=09subflow->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
>> +
>> +=09=09//Solves: BAD mapping: ssn=3D0 map_seq=3D1 map_data_len=3D3
> Same here.
FIxed
>> +=09=09subflow->ssn_offset =3D tp->copied_seq - 1;
>> +
>> +=09=09//<acquire the msk data lock>
>> +=09=09lock_sock((struct sock *)msk);
> the mptcp data lock is acquired with:
>
> =09=09 mptcp_data_lock((struct sock *)msk)
>
> which become
> =09=09mptcp_data_lock(sk);
>
> if you apply the mptcp variable name conventions.
Fixed
> I think you additionally need to init the mptcp CB for skb.
>
> I'm not sure what will happen to later skb coming via
> __mptcp_move_skb(). You must ensure that they will not be coalesced.
> Probably correctly initializing the mptcp CB should ensure the above.

Could you please evolve the comment? Set the MPTCP_SKB_CB: offset ,=20
map_seq, end_seq?


>> +
>> +=09=09//<move skb into msk receive queue>
>> +=09=09mptcp_set_owner_r(skb, (struct sock *)msk);
>> +=09=09__skb_queue_tail(&msk->receive_queue, skb);
>> +=09=09atomic64_set(&msk->rcv_wnd_sent, mptcp_subflow_get_mapped_dsn(sub=
flow));
>> +
>> +=09=09//<call msk data_ready>
>> +=09=09((struct sock *)msk)->sk_data_ready((struct sock *)msk);
> or just:
> =09=09sk->sk_data_ready(sk);
>
> (when respecting the mptcp variables name conventions)
Fixed.
>> +
>> +=09=09//<release the msk data lock>
>> +=09=09release_sock((struct sock *)msk);
>> +=09}
>> +=09return tcp_request_sock_ipv4_ops.send_synack(sk, dst, fl, req, foc, =
synack_type, syn_skb);
>> +}
>> +
>> +static int subflow_v6_send_synack(const struct sock *sk, struct dst_ent=
ry *dst,
>> +=09=09=09=09  struct flowi *fl,
>> +=09=09=09=09  struct request_sock *req,
>> +=09=09=09=09  struct tcp_fastopen_cookie *foc,
>> +=09=09=09=09  enum tcp_synack_type synack_type,
>> +=09=09=09=09  struct sk_buff *syn_skb)
>> +{
> This is not enough, you need to do the same things as under the 'if
> (synack_type =3D=3D TCP_SYNACK_FASTOPEN) {' conditional in
> subflow_v4_send_synack()

Yes, it was a placeholder. I was wondering if the content is=C2=A0 the same=
=20
as in v4 probably I could add a helper and reuse in v4/6. And hopefully=20
you suggest to do so in this message :)


>> +=09return tcp_request_sock_ipv6_ops.send_synack(sk, dst, fl, req, foc, =
synack_type, syn_skb);
>> +}
>> +
>>   #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>>   static struct dst_entry *subflow_v6_route_req(const struct sock *sk,
>>   =09=09=09=09=09      struct sk_buff *skb,
>> @@ -1920,6 +1988,7 @@ void __init mptcp_subflow_init(void)
>>  =20
>>   =09subflow_request_sock_ipv4_ops =3D tcp_request_sock_ipv4_ops;
>>   =09subflow_request_sock_ipv4_ops.route_req =3D subflow_v4_route_req;
>> +=09subflow_request_sock_ipv4_ops.send_synack =3D subflow_v4_send_synack=
;
>>  =20
>>   =09subflow_specific =3D ipv4_specific;
>>   =09subflow_specific.conn_request =3D subflow_v4_conn_request;
>> @@ -1933,6 +2002,7 @@ void __init mptcp_subflow_init(void)
>>   #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>>   =09subflow_request_sock_ipv6_ops =3D tcp_request_sock_ipv6_ops;
>>   =09subflow_request_sock_ipv6_ops.route_req =3D subflow_v6_route_req;
>> +=09subflow_request_sock_ipv6_ops.send_synack =3D subflow_v6_send_synack=
;
>>  =20
>>   =09subflow_v6_specific =3D ipv6_specific;
>>   =09subflow_v6_specific.conn_request =3D subflow_v6_conn_request;


Here is a commit with modifictions:

 From 13de5d435a4323519235c811719bd9d5fd1802de Mon Sep 17 00:00:00 2001
From: Dmytro Shytyi <dmytro@shytyi.net>
Date: Tue, 20 Sep 2022 19:53:56 +0200
Subject: [RFC PATCH mptcp-next v9 5/6] mptcp: add=20
subflow_v(4,6)_send_synack()

In this patch we add skb to the msk, dequeue it from sk, remove TSs and
do skb mapping.

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 =C2=A0net/ipv4/tcp_fastopen.c | 19 ++++++---
 =C2=A0net/mptcp/protocol.c=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
 =C2=A0net/mptcp/protocol.h=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
 =C2=A0net/mptcp/subflow.c=C2=A0=C2=A0=C2=A0=C2=A0 | 85 +++++++++++++++++++=
++++++++++++++++++++++
 =C2=A04 files changed, 100 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 45cc7f1ca296..d6b1380525ea 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -356,13 +356,20 @@ struct sock *tcp_try_fastopen(struct sock *sk,=20
struct sk_buff *skb,
 =C2=A0=C2=A0=C2=A0=C2=A0 if (foc->len =3D=3D 0) /* Client requests a cooki=
e */
 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 NET_INC_STATS(sock_net(sk), LI=
NUX_MIB_TCPFASTOPENCOOKIEREQD);

-=C2=A0=C2=A0=C2=A0 if (!((tcp_fastopen & TFO_SERVER_ENABLE) &&
-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (syn_data || foc->len >=
=3D 0) &&
-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcp_fastopen_queue_check=
(sk))) {
-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 foc->len =3D -1;
-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return NULL;
+=C2=A0=C2=A0=C2=A0 if (sk_is_mptcp(sk)) {
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (((syn_data || foc->len >=3D 0) &=
&
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 tcp_fastope=
n_queue_check(sk))) {
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 foc->len =3D -1;
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return NULL;
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }
+=C2=A0=C2=A0=C2=A0 } else {
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (!((tcp_fastopen & TFO_SERVER_ENA=
BLE) &&
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (syn_=
data || foc->len >=3D 0) &&
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcp_f=
astopen_queue_check(sk))) {
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 foc->len =3D -1;
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return NULL;
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }
 =C2=A0=C2=A0=C2=A0=C2=A0 }
-
 =C2=A0=C2=A0=C2=A0=C2=A0 if (tcp_fastopen_no_cookie(sk, dst, TFO_SERVER_CO=
OKIE_NOT_REQD))
 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 goto fastopen;

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d5c502d141b4..6a593be6076b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -200,7 +200,7 @@ static void mptcp_rfree(struct sk_buff *skb)
 =C2=A0=C2=A0=C2=A0=C2=A0 mptcp_rmem_uncharge(sk, len);
 =C2=A0}

-static void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk)
+void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk)
 =C2=A0{
 =C2=A0=C2=A0=C2=A0=C2=A0 skb_orphan(skb);
 =C2=A0=C2=A0=C2=A0=C2=A0 skb->sk =3D sk;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b9e251848099..58a04144fff0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -845,6 +845,7 @@ int mptcp_setsockopt_sol_tcp_fastopen(struct=20
mptcp_sock *msk, sockptr_t optval,
 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int optlen);
 =C2=A0void mptcp_gen_msk_ackseq_fastopen(struct mptcp_sock *msk, struct=20
mptcp_subflow_context *subflow,
 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0 struct mptcp_options_received mp_opt);
+void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk);
 =C2=A0// Fast Open Mechanism functions end

 =C2=A0static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk=
)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 07dd23d0fe04..cca888bae261 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -307,6 +307,89 @@ static struct dst_entry *subflow_v4_route_req(const=20
struct sock *sk,
 =C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
 =C2=A0}

+static void subflow_fastopen_set_params(struct mptcp_subflow_context=20
*subflow,
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 struct request_sock *req)
+{
+=C2=A0=C2=A0=C2=A0 struct tcp_request_sock *tcp_r_sock =3D tcp_rsk(req);
+=C2=A0=C2=A0=C2=A0 struct sock *ssk =3D subflow->tcp_sock;
+=C2=A0=C2=A0=C2=A0 struct sock *sk =3D subflow->conn;
+=C2=A0=C2=A0=C2=A0 struct mptcp_sock *msk;
+=C2=A0=C2=A0=C2=A0 struct sk_buff *skb;
+=C2=A0=C2=A0=C2=A0 struct tcp_sock *tp;
+
+=C2=A0=C2=A0=C2=A0 msk =3D mptcp_sk(sk);
+=C2=A0=C2=A0=C2=A0 tp =3D tcp_sk(ssk);
+
+=C2=A0=C2=A0=C2=A0 /* <mark subflow/msk as "mptfo"> */
+=C2=A0=C2=A0=C2=A0 msk->is_mptfo =3D 1;
+
+=C2=A0=C2=A0=C2=A0 skb =3D skb_peek(&ssk->sk_receive_queue);
+
+=C2=A0=C2=A0=C2=A0 /* <dequeue the skb from sk receive queue> */
+=C2=A0=C2=A0=C2=A0 __skb_unlink(skb, &ssk->sk_receive_queue);
+=C2=A0=C2=A0=C2=A0 skb_ext_reset(skb);
+=C2=A0=C2=A0=C2=A0 skb_orphan(skb);
+
+=C2=A0=C2=A0=C2=A0 /* <set the skb mapping> */
+=C2=A0=C2=A0=C2=A0 tp->copied_seq +=3D tp->rcv_nxt - tcp_r_sock->rcv_isn -=
 1;
+=C2=A0=C2=A0=C2=A0 subflow->map_seq =3D mptcp_subflow_get_mapped_dsn(subfl=
ow);
+=C2=A0=C2=A0=C2=A0 subflow->ssn_offset =3D tp->copied_seq - 1;
+
+=C2=A0=C2=A0=C2=A0 /* <acquire the msk data lock> */
+=C2=A0=C2=A0=C2=A0 mptcp_data_lock(sk);
+
+=C2=A0=C2=A0=C2=A0 /* <move skb into msk receive queue> */
+=C2=A0=C2=A0=C2=A0 mptcp_set_owner_r(skb, sk);
+=C2=A0=C2=A0=C2=A0 __skb_queue_tail(&msk->receive_queue, skb);
+=C2=A0=C2=A0=C2=A0 atomic64_set(&msk->rcv_wnd_sent,=20
mptcp_subflow_get_mapped_dsn(subflow));
+
+=C2=A0=C2=A0=C2=A0 /* <call msk data_ready> */
+=C2=A0=C2=A0=C2=A0 (sk)->sk_data_ready(sk);
+
+=C2=A0=C2=A0=C2=A0 /* <release the msk data lock> */
+=C2=A0=C2=A0=C2=A0 mptcp_data_unlock(sk);
+}
+
+static int subflow_v4_send_synack(const struct sock *sk, struct=20
dst_entry *dst,
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0 struct flowi *fl,
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0 struct request_sock *req,
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0 struct tcp_fastopen_cookie *foc,
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0 enum tcp_synack_type synack_type,
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0 struct sk_buff *syn_skb)
+{
+=C2=A0=C2=A0=C2=A0 struct mptcp_subflow_context *subflow =3D mptcp_subflow=
_ctx(sk);
+=C2=A0=C2=A0=C2=A0 struct inet_request_sock *ireq =3D inet_rsk(req);
+
+=C2=A0=C2=A0=C2=A0 /* <evenutally clear tstamp_ok, as needed depending on =
cookie size> */
+=C2=A0=C2=A0=C2=A0 if (foc !=3D NULL)
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ireq->tstamp_ok =3D 0;
+
+=C2=A0=C2=A0=C2=A0 if (synack_type =3D=3D TCP_SYNACK_FASTOPEN) {
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 subflow_fastopen_set_params(subflow,=
 req);
+=C2=A0=C2=A0=C2=A0 }
+=C2=A0=C2=A0=C2=A0 return tcp_request_sock_ipv4_ops.send_synack(sk, dst, f=
l, req, foc,=20
synack_type, syn_skb);
+}
+
+static int subflow_v6_send_synack(const struct sock *sk, struct=20
dst_entry *dst,
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0 struct flowi *fl,
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0 struct request_sock *req,
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0 struct tcp_fastopen_cookie *foc,
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0 enum tcp_synack_type synack_type,
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0 struct sk_buff *syn_skb)
+{
+=C2=A0=C2=A0=C2=A0 struct mptcp_subflow_context *subflow =3D mptcp_subflow=
_ctx(sk);
+=C2=A0=C2=A0=C2=A0 struct inet_request_sock *ireq =3D inet_rsk(req);
+
+=C2=A0=C2=A0=C2=A0 /* <evenutally clear tstamp_ok, as needed depending on =
cookie size> */
+=C2=A0=C2=A0=C2=A0 if (foc !=3D NULL)
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ireq->tstamp_ok =3D 0;
+
+=C2=A0=C2=A0=C2=A0 if (synack_type =3D=3D TCP_SYNACK_FASTOPEN) {
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 subflow_fastopen_set_params(subflow,=
 req);
+=C2=A0=C2=A0=C2=A0 }
+=C2=A0=C2=A0=C2=A0 return tcp_request_sock_ipv6_ops.send_synack(sk, dst, f=
l, req, foc,=20
synack_type, syn_skb);
+}
+
 =C2=A0#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 =C2=A0static struct dst_entry *subflow_v6_route_req(const struct sock *sk,
 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sk_buff =
*skb,
@@ -1920,6 +2003,7 @@ void __init mptcp_subflow_init(void)

 =C2=A0=C2=A0=C2=A0=C2=A0 subflow_request_sock_ipv4_ops =3D tcp_request_soc=
k_ipv4_ops;
 =C2=A0=C2=A0=C2=A0=C2=A0 subflow_request_sock_ipv4_ops.route_req =3D subfl=
ow_v4_route_req;
+=C2=A0=C2=A0=C2=A0 subflow_request_sock_ipv4_ops.send_synack =3D subflow_v=
4_send_synack;

 =C2=A0=C2=A0=C2=A0=C2=A0 subflow_specific =3D ipv4_specific;
 =C2=A0=C2=A0=C2=A0=C2=A0 subflow_specific.conn_request =3D subflow_v4_conn=
_request;
@@ -1933,6 +2017,7 @@ void __init mptcp_subflow_init(void)
 =C2=A0#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 =C2=A0=C2=A0=C2=A0=C2=A0 subflow_request_sock_ipv6_ops =3D tcp_request_soc=
k_ipv6_ops;
 =C2=A0=C2=A0=C2=A0=C2=A0 subflow_request_sock_ipv6_ops.route_req =3D subfl=
ow_v6_route_req;
+=C2=A0=C2=A0=C2=A0 subflow_request_sock_ipv6_ops.send_synack =3D subflow_v=
6_send_synack;

 =C2=A0=C2=A0=C2=A0=C2=A0 subflow_v6_specific =3D ipv6_specific;
 =C2=A0=C2=A0=C2=A0=C2=A0 subflow_v6_specific.conn_request =3D subflow_v6_c=
onn_request;
--=20
2.25.1



