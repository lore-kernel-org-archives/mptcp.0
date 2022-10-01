Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4291FBA
	for <mptcp@lists.linux.dev>; Sat,  1 Oct 2022 03:08:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664593705; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=AHv81pPHbidNtxb5RaELaVuaff7LtfHpiR9J5uNX2CqveJViO6NeNKLX10kyqq1dqfrnzNLWmxRDAVLfYw1aA9O0kRJYS8GNhG+TaFUWLjwyllzOTK/3jZkcyNuZ2iqRDsoimgoIMg7qnxE3k9fwHJdi8MtTk6j7VM3SYE80nmU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664593705; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=MlF8Bhtss9rE1Q01UEGLyRyXNIY1ipXuEoTG/jCx5Js=; 
	b=MEXkavP4QZ8Zw0H2QQZScfe/KMWfcsgqs1MeOUEI4YaELQ3DKllTeqhWMXzkwZOegtQk3m70WgvjbV3Y3yOMnhWjeaoBO6MBeCLdScxtSxDIPys+MXgr28spbFRiOPEBA2I49Vb9DtLnHsBEk1qVpUnPkjAc3JFQeIYB6F+Ue+M=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664593705;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:Message-ID:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=MlF8Bhtss9rE1Q01UEGLyRyXNIY1ipXuEoTG/jCx5Js=;
	b=ceSu3EiBoGz03Bw0ehbbs8SRCXjesPraLaQMEK19/RXcLQtvpj002bSHtr74Bgqe
	JFll+PRDz5RAYUdYiiCY+yp59DaqFm/iIwsmWYQTrZ+132Oitdo4Seyhm4aNtTgxyzm
	XIML9CyynxG4rqIaeJUbPmIUhPBzLxl9Ri8Uyzc0=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1664593703704550.013301337681; Sat, 1 Oct 2022 05:08:23 +0200 (CEST)
Date: Sat, 1 Oct 2022 05:08:23 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH mptcp-next v12 1/7] mptcp: introduce MSG_FASTOPEN
 flag.
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>
References: <20220927225341.14165-1-dmytro@shytyi.net>
 <20220927225341.14165-2-dmytro@shytyi.net>
 <c074b37149bbad50ece1b0f0b6e380106b5a0e38.camel@redhat.com>
From: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <44a60bfa-720e-1984-d0c7-dce080a14d4e@shytyi.net>
In-Reply-To: <c074b37149bbad50ece1b0f0b6e380106b5a0e38.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

Hello,

I'm getting the next stack trace [1] when following this approach, yet=20
it needs uarg to be filled, not NULL.

After Matthieu suggestion, I tried to implement the .connect in mptcp,=20
but I'm getting errors like "ENOBUFF" or "EINPROGRESS".

Finally I decided to continue with "mptcp_stream_connect()" function in v13=
.


[1] Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[=C2=A0=C2=A0 27.736069] RSP: 0018:ffffc90000adfce0 EFLAGS: 00010246
[=C2=A0=C2=A0 27.737115] RAX: 0000000000000000 RBX: ffff888003894440 RCX:=
=20
0000000000000000
[=C2=A0=C2=A0 27.738560] RDX: 0000000000000010 RSI: ffffc90000adfe80 RDI:=
=20
ffff888027ce8000
[=C2=A0=C2=A0 27.739883] RBP: 0000000000000000 R08: 0000000000000001 R09:=
=20
ffff888015710cf0
[=C2=A0=C2=A0 27.741286] R10: 0000000000000001 R11: ffff888003ca78c8 R12:=
=20
00000000ffffff96
[=C2=A0=C2=A0 27.742718] R13: ffffc90000adfdb0 R14: ffffc90000adfe80 R15:=
=20
ffff888027ce8000
[=C2=A0=C2=A0 27.744135] FS:=C2=A0 00007f7cc983a740(0000) GS:ffff88803da000=
00(0000)=20
knlGS:0000000000000000
[=C2=A0=C2=A0 27.745612] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 000000008005=
0033
[=C2=A0=C2=A0 27.746788] CR2: ffffffffffffffd6 CR3: 000000001d180006 CR4:=
=20
0000000000370ef0
[=C2=A0=C2=A0 27.748125] Call Trace:
[=C2=A0=C2=A0 27.748655]=C2=A0 <TASK>
[=C2=A0=C2=A0 27.749086] __inet_stream_connect (net/ipv4/af_inet.c:663)
[=C2=A0=C2=A0 27.750093] ? sk_reset_timer (net/core/sock.c:3341)
[=C2=A0=C2=A0 27.750803] ? tcp_connect (net/ipv4/tcp_output.c:3882)
[=C2=A0=C2=A0 27.751590] ? kmem_cache_alloc_trace (mm/slub.c:3286)
[=C2=A0=C2=A0 27.752492] tcp_sendmsg_fastopen (net/ipv4/tcp.c:1198)
[=C2=A0=C2=A0 27.753347] mptcp_sendmsg (net/mptcp/protocol.c:1710)
[=C2=A0=C2=A0 27.754047] sock_sendmsg_nosec (net/socket.c:714)
[=C2=A0=C2=A0 27.754831] __sys_sendto (net/socket.c:2117)
[=C2=A0=C2=A0 27.755539] ? handle_mm_fault (mm/memory.c:5151)
[=C2=A0=C2=A0 27.756311] ? do_user_addr_fault (arch/x86/mm/fault.c:1426)
[=C2=A0=C2=A0 27.757175] __x64_sys_sendto (net/socket.c:2129 net/socket.c:2=
125=20
net/socket.c:2125)
[=C2=A0=C2=A0 27.758029] do_syscall_64 (arch/x86/entry/common.c:50=20
arch/x86/entry/common.c:80)
[=C2=A0=C2=A0 27.758739] entry_SYSCALL_64_after_hwframe=20
(arch/x86/entry/entry_64.S:120)
[=C2=A0=C2=A0 27.759719] RIP: 0033:0x7f7cc99484e6
[ 27.760458] Code: 69 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f=20
1f 00 41 89 ca 64 8b 04 25 18 00 00 00 85 c0c

On 9/28/2022 11:01 AM, Paolo Abeni wrote:
> On Tue, 2022-09-27 at 22:53 +0000, Dmytro Shytyi wrote:
>> In the following patches we will analyse the MSG_FASTOPEN flag
>> in the mptcp_sendmsg() and invoke the MPTFO.
>>
>> Signed-of-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
>> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
>> ---
>>   include/net/mptcp.h  |  9 +++++++++
>>   include/net/tcp.h    |  3 +++
>>   net/ipv4/tcp.c       | 20 ++++++++++++++++----
>>   net/mptcp/protocol.c | 19 +++++++++++--------
>>   4 files changed, 39 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
>> index c25939b2af68..ccf2b42837a1 100644
>> --- a/include/net/mptcp.h
>> +++ b/include/net/mptcp.h
>> @@ -150,6 +150,8 @@ void mptcp_write_options(struct tcphdr *th, __be32 *=
ptr, struct tcp_sock *tp,
>>   =09=09=09 struct mptcp_out_options *opts);
>>  =20
>>   void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *i=
nfo);
>> +int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr, i=
nt addr_len, int flags);
>> +struct sock *mptcp_subflow_conn_sock(struct sock *sk);
>>  =20
>>   /* move the skb extension owership, with the assumption that 'to' is
>>    * newly allocated
>> @@ -286,6 +288,13 @@ static inline bool mptcp_skb_can_collapse(const str=
uct sk_buff *to,
>>  =20
>>   static inline void mptcp_space(const struct sock *ssk, int *s, int *fs=
) { }
>>   static inline void mptcp_seq_show(struct seq_file *seq) { }
>> +static inline int mptcp_stream_connect(struct socket *sock,
>> +=09=09=09=09       struct sockaddr *uaddr,
>> +=09=09=09=09       int addr_len,
>> +=09=09=09=09       int flags)
>> +{
>> +
>> +}
>>  =20
>>   static inline int mptcp_subflow_init_cookie_req(struct request_sock *r=
eq,
>>   =09=09=09=09=09=09const struct sock *sk_listener,
>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>> index 4f71cc15ff8e..e53d26d74dec 100644
>> --- a/include/net/tcp.h
>> +++ b/include/net/tcp.h
>> @@ -1757,6 +1757,9 @@ struct sock *tcp_try_fastopen(struct sock *sk, str=
uct sk_buff *skb,
>>   =09=09=09      struct request_sock *req,
>>   =09=09=09      struct tcp_fastopen_cookie *foc,
>>   =09=09=09      const struct dst_entry *dst);
>> +int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>> +=09=09=09 int *copied, size_t size,
>> +=09=09=09 struct ubuf_info *uarg);
>>   void tcp_fastopen_init_key_once(struct net *net);
>>   bool tcp_fastopen_cookie_check(struct sock *sk, u16 *mss,
>>   =09=09=09     struct tcp_fastopen_cookie *cookie);
>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>> index 5237a3f08c94..daa611671d9a 100644
>> --- a/net/ipv4/tcp.c
>> +++ b/net/ipv4/tcp.c
>> @@ -1162,8 +1162,9 @@ void tcp_free_fastopen_req(struct tcp_sock *tp)
>>   =09}
>>   }
>>  =20
>> -int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copi=
ed,
>> -=09=09=09 size_t size, struct ubuf_info *uarg)
>> +int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>> +=09=09=09 int *copied, size_t size,
>> +=09=09=09 struct ubuf_info *uarg)
>>   {
>>   =09struct tcp_sock *tp =3D tcp_sk(sk);
>>   =09struct inet_sock *inet =3D inet_sk(sk);
>> @@ -1196,8 +1197,19 @@ int tcp_sendmsg_fastopen(struct sock *sk, struct =
msghdr *msg, int *copied,
>>   =09=09}
>>   =09}
>>   =09flags =3D (msg->msg_flags & MSG_DONTWAIT) ? O_NONBLOCK : 0;
>> -=09err =3D __inet_stream_connect(sk->sk_socket, uaddr,
>> -=09=09=09=09    msg->msg_namelen, flags, 1);
>> +=09if (!sk_is_mptcp(sk)) {
>> +=09=09err =3D __inet_stream_connect(sk->sk_socket, uaddr,
>> +=09=09=09=09=09    msg->msg_namelen, flags, 1);
>> +=09} else {
>> +=09=09struct sock *parent =3D mptcp_subflow_conn_sock(sk);
>> +
>> +=09=09release_sock(sk);
>> +=09=09release_sock(parent);
>> +=09=09err =3D mptcp_stream_connect(sk->sk_socket, uaddr,
>> +=09=09=09=09=09   msg->msg_namelen, msg->msg_flags);
>> +=09=09lock_sock(parent);
>> +=09=09lock_sock(sk);
>> +=09}
>>   =09/* fastopen_req could already be freed in __inet_stream_connect
>>   =09 * if the connection times out or gets rst
>>   =09 */
> I'm sorry it looks like I was not clear enough in my previous replies.
>
> I really think we should avoid this chunk. I thought it only served for
> updating the msk socket status, but now I see it is also needed to
> properly allocate the token and update the MIBs, right? Does it serve
> any other roles?
>
> Anyway I still think you can avoid the above chunck, factoring out the
> relevant slice of mptcp_stream_connect() in an helper:
>
> static void __mptcp_pre_connect(struct mptcp_sock *msk, struct sock *ssk)
> {
> =09struct mptcp_subflow_context *subflow;
>
> =09mptcp_token_destroy(msk);
>          subflow =3D mptcp_subflow_ctx(ssk);
> #ifdef CONFIG_TCP_MD5SIG
>          /* no MPTCP if MD5SIG is enabled on this socket or we may run ou=
t of
>           * TCP option space.
>           */
>          if (rcu_access_pointer(tcp_sk(ssk)->md5sig_info))
>                  mptcp_subflow_early_fallback(msk, subflow);
> #endif
>          if (subflow->request_mptcp && mptcp_token_new_connect(ssk)) {
>                  MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_TOKENFALLBACKIN=
IT);
>                  mptcp_subflow_early_fallback(msk, subflow);
>          }
>          if (likely(!__mptcp_check_fallback(msk)))
>                  MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPCAPABLEACTIVE=
);
> }
>
> and call the above in mptcp_sendmsg():
>
> =09if (unlikely(ssock && (inet_sk(ssock->sk)->defer_connect ||
> =09=09=09       msg->msg_flags & MSG_FASTOPEN))) {
> =09=09struct sock *ssk =3D ssock->sk;
>                  int copied_syn =3D 0;
>
>                  lock_sock(ssk);
> =09=09if (msg->msg_flags & MSG_FASTOPEN && sk->sk_state =3D=3D TCP_CLOSE)
> =09=09=09__mptcp_pre_connect(msk, ssk);
> =09=09
> Likely this patch should be split in 2 separate ones: the new patch
> will just create the helper and use it in mptcp_stream_connect.=09
>
>
> Cheers,
>
> Paolo
>
>

