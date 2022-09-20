Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F23A1C34
	for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 13:40:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663681239; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=RyXKDpdf2odN+6U5NMsurqStAEz2sYObGjoj0MN8reqsWgwsd+6kYo+u0bfbSFg6w7vDEaEQHw9HcNvxZrTzzJ/6oQidGyb6oDbaSjtDO+2vQ8A9QUlJf9RAiAGLJs0/OTy7REc0P94gkbBNAJcuOd3qKTnnrhb4Y3rBOnEag8U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663681239; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=HYG1JqWf8wKsQhJ6upVlIk0KXtXAkVmxOJcU6GVRCi0=; 
	b=JFNnTMYNcuKwoYAMD8gXFS/STalAtfbrw6GdgB0dBA2Ee+IVkjII5jKpWYbTtLR4xAxrr7KRAUpvKlodtGd06ms8/eHsPySD6rIXE17LD20kuLe7QcJD2pWGVvciqTMpageCk0CMTLG4PtegVFS5lk7yxeCdOVpm4oZl1MOkKQ8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663681239;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:Message-ID:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=HYG1JqWf8wKsQhJ6upVlIk0KXtXAkVmxOJcU6GVRCi0=;
	b=flpljSTqL/Yl1TvX7sH0RC3ZXwuFaWjgNLoCUpliHSOnGjAydznKSxbdczknKyxk
	2CDYHXqSEDhKaXSO+kAqyghiVEEjeXvRaCCqeXN2nsPz99nOrZtbE7mbA+Y0WSQGD1C
	iVFNNSEF/MYQtyec9HjcyEJa5/I+VrxEkV0DndKM=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663681237443395.87616353773615; Tue, 20 Sep 2022 15:40:37 +0200 (CEST)
Date: Tue, 20 Sep 2022 15:40:36 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH mptcp-next v7 07/11] mptfo variables for msk, options.
 Fix loop retrans
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20220917222853.2406-1-dmytro@shytyi.net>
 <20220917222853.2406-8-dmytro@shytyi.net>
 <be427fe3457391b7b50af213c255d8fd1f3703c7.camel@redhat.com>
From: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <dcedb781-507b-700d-68b2-71dfb80b6fa2@shytyi.net>
In-Reply-To: <be427fe3457391b7b50af213c255d8fd1f3703c7.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

This is refactored in v8.


Best regards,

Dmytro

On 9/19/2022 1:11 PM, Paolo Abeni wrote:
> On Sun, 2022-09-18 at 00:28 +0200, Dmytro Shytyi wrote:
>> Introduce mptfo variables for msk and options.
>> Also fixe the infinite retransmissions in the end of second session.
>> Suggestion @palbeni (SEP 1) during the meting to 'look at ack'
>>
>> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
>> ---
>>   net/mptcp/fastopen.c | 16 ++++++++++++++++
>>   net/mptcp/options.c  |  3 +++
>>   net/mptcp/protocol.h |  6 +++++-
>>   3 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
>> index 436e773d798a..149a4b1d3dac 100644
>> --- a/net/mptcp/fastopen.c
>> +++ b/net/mptcp/fastopen.c
>> @@ -91,3 +91,19 @@ int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_so=
ck *msk, sockptr_t optval,
>>  =20
>>   =09return ret;
>>   }
>> +
>> +void mptcp_treat_hshake_ack_fastopen(struct mptcp_sock *msk, struct mpt=
cp_subflow_context *subflow,
>> +=09=09=09=09     struct mptcp_options_received mp_opt)
>> +{
>> +=09u64 ack_seq;
>> +
>> +=09if (mp_opt.suboptions & OPTIONS_MPTCP_MPC && mp_opt.is_mptfo && msk-=
>is_mptfo) {
>> +=09=09msk->can_ack =3D true;
>> +=09=09msk->remote_key =3D mp_opt.sndr_key;
>> +=09=09mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
>> +=09=09ack_seq++;
>> +=09=09WRITE_ONCE(msk->ack_seq, ack_seq);
>> +=09=09pr_debug("ack_seq=3D%llu sndr_key=3D%llu", msk->ack_seq, mp_opt.s=
ndr_key);
>> +=09=09atomic64_set(&msk->rcv_wnd_sent, ack_seq);
> It's not clear to me why the above is needed. According to the RFC we
> should not do additional MPTCP-level key management for TFO' sake ?!?
>
>> +=09}
>> +}
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index 30d289044e71..185b069e57f4 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -91,6 +91,7 @@ static void mptcp_parse_option(const struct sk_buff *s=
kb,
>>   =09=09=09ptr +=3D 8;
>>   =09=09}
>>   =09=09if (opsize >=3D TCPOLEN_MPTCP_MPC_ACK) {
>> +=09=09=09mp_opt->is_mptfo =3D 1;
> This looks incorrect.=C2=A0Plain MPTCP MP_CAPABLE handshake will be marke=
d
> as TFO regardless of the actual TCP option exchange.
>
> It looks like the only already available hook to catch the 'incoming
> fast open' info would be implementing custom mptcp subflow {v4,v6}
> send_synack and checking the 'foc' pointer.
>
> Otherwise you can add TCPOPT_FASTOPEN parsing capability to
> mptcp_parse_option(), but that would be more duplicate code, I think it
> would be better to avoid that if possible.
>
>>   =09=09=09mp_opt->rcvr_key =3D get_unaligned_be64(ptr);
>>   =09=09=09ptr +=3D 8;
>>   =09=09}
>> @@ -1124,6 +1125,8 @@ bool mptcp_incoming_options(struct sock *sk, struc=
t sk_buff *skb)
>>   =09=09return sk->sk_state !=3D TCP_CLOSE;
>>  =20
>>   =09if (unlikely(mp_opt.suboptions !=3D OPTION_MPTCP_DSS)) {
>> +=09=09mptcp_treat_hshake_ack_fastopen(msk, subflow, mp_opt);
>> +
>>   =09=09if ((mp_opt.suboptions & OPTION_MPTCP_FASTCLOSE) &&
>>   =09=09    msk->local_key =3D=3D mp_opt.rcvr_key) {
>>   =09=09=09WRITE_ONCE(msk->rcv_fastclose, true);
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index 8caaeeedb9da..b90279c734ae 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -155,7 +155,8 @@ struct mptcp_options_received {
>>   =09=09echo:1,
>>   =09=09backup:1,
>>   =09=09deny_join_id0:1,
>> -=09=09__unused:2;
>> +=09=09is_mptfo:1,
>> +=09=09__unused:1;
>>   =09u8=09join_id;
>>   =09u64=09thmac;
>>   =09u8=09hmac[MPTCPOPT_HMAC_LEN];
>> @@ -282,6 +283,7 @@ struct mptcp_sock {
>>   =09bool=09=09use_64bit_ack; /* Set when we received a 64-bit DSN */
>>   =09bool=09=09csum_enabled;
>>   =09bool=09=09allow_infinite_fallback;
>> +=09bool=09=09is_mptfo;
>>   =09u8=09=09mpc_endpoint_id;
>>   =09u8=09=09recvmsg_inq:1,
>>   =09=09=09cork:1,
>> @@ -845,6 +847,8 @@ int mptcp_sendmsg_fastopen(struct sock *sk, struct m=
sghdr *msg,
>>   =09=09=09   size_t *copied);
>>   int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk, sockptr_=
t optval,
>>   =09=09=09=09      unsigned int optlen);
>> +void mptcp_treat_hshake_ack_fastopen(struct mptcp_sock *msk, struct mpt=
cp_subflow_context *subflow,
>> +=09=09=09=09     struct mptcp_options_received mp_opt);
>>   // Fast Open Mechanism functions end
>>  =20
>>   static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)

