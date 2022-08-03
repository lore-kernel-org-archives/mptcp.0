Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01874368
	for <mptcp@lists.linux.dev>; Wed,  3 Aug 2022 07:36:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1659512167; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=F+U2ftBqzF7lC3bJiEFB6B9Tc87OKnm+xHui18LPdaOQpHjy3cbN9o4nn1fsyXMOkm5+2BpWp2+kUkkpysQmWXP1z6tX6WhKb2mX+mdyPTJ0o+2ZkA3PRfzwCoPaEGQPd8WwTuHr7dTY5yqrBmYkN4yEKI+cACaVA1TR4v33Rv4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1659512167; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=d3Lhtd4VKbS7nqr3z87sgclkomDjPLcy2YVMaTGSMWw=; 
	b=Z5/yfDLzDz91obPnpFw3vwCXl6yua9OFepQxdaD5hrvspjdbIVa+jWdIWMDf6Z4AKWxl9+ykfPz/ARWp6+ZnYR2l05I4HiPjan0XvIWOUwaGXlUngKSg0G60JN+yVbDfKhw/jXegQ0PldSeA2M+ShtrJRYq3j5fsZT7bPrMOuec=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659512167;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:Message-ID:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=d3Lhtd4VKbS7nqr3z87sgclkomDjPLcy2YVMaTGSMWw=;
	b=UsmgZhf2Sj8xlJMZhFF0sF2GyPjtbx2cHMEXfJlCq0kuSCwvR07zC4M9JmUkiHn+
	yxC4Ni7JTtRttvde8dhwZdUN4xDDNtrXrXlZMa/a23csAuqyJ2/bFLAqUQbmLSnftv7
	BAuaerbsCz3+a80E2G1bPaRgWbTQQ7Ika/h6mDnc=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1659512166050405.54899479639585; Wed, 3 Aug 2022 09:36:06 +0200 (CEST)
Date: Wed, 3 Aug 2022 08:36:05 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH mptcp-next v4] mptcp: Fast Open Mechanism
Content-Language: en-US
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <20220801024656.397714-1-dmytro@shytyi.net>
 <1d70103b-3ef9-1c1b-fedf-2359a93746f9@linux.intel.com>
From: Dmytro SHYTYI <dmytro@shytyi.net>
Message-ID: <07d15711-89e4-2d82-b66d-1f1f66a25c73@shytyi.net>
In-Reply-To: <1d70103b-3ef9-1c1b-fedf-2359a93746f9@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

Hello Mat,


On 03/08/2022 01:32, Mat Martineau wrote:
> On Mon, 1 Aug 2022, Dmytro SHYTYI wrote:
>=20
>> This set of patches will bring "Fast Open" Option support to MPTCP.
>> The aim of Fast Open Mechanism is to eliminate one round trip
>> time from a TCP conversation by allowing data to be included as
>> part of the SYN segment that initiates the connection.
>>
>> IETF RFC 8684: Appendix B. TCP Fast Open and MPTCP.
>>
>> [PATCH v3] includes "client-server" partial support for :
>> 1. MPTCP cookie request from client (seems to be working).
>> 2. MPTCP cookie offering from server (seems to be working).
>> 3. MPTCP SYN+DATA+COOKIE from client (seems to be working).
>> 4. subsequent write + read on the opened socket (first launch
>> with TFO request seems to be working, hovewer the second launch
>> appears to have a mptcp "RST" issue).
>>
>> This patch is Work In Progress transitional draft.
>> The differences between v3 and v4:
>> 1. An attempt to reduce impact on existing TCP code.
>> 2. 2 files related to mptcp_fastopen are created(*.h + *.c).
>> 3. "subflow_v4_conn_request" is used to call "mptcp_conn_request"(
>> located in "mptcp_fastopen.c") to process the received packet on the
>> listener side when "SYN" is received during 3way handshake.
>> 4. This chain adds "skb" to "&msk->sk_receive_queue"
>> ("subflow_v4_conn_request"->"mptcp_conn_request"->
>> "mptcp_try_fastopen"->"mptcp_fastopen_create_child"->
>> "mptcp_fastopen_add_skb")
>> 5. Some minor comments from mailing list are not yet included
>> in the current version of the PATCH.
>>
>> Signed-off-by: Dmytro SHYTYI <dmytro@shytyi.net>
>=20
> Hi Dmytro -
>=20
> Thanks for sharing this work-in-progress, I appreciate all the changes=20
> from the last RFC.
>=20
> Since you've noted that this current version is still transitional and=20
> my understanding is that Benjamin is going to be collaborating on TFO,=20
> I'm assuming it's best to do a detailed review after some more progress.=
=20
> (If you do want more feedback now, just let me know).
>=20
> I do have one comment below on the socket option handling.

@Mat, Thank you!

Recently I shared pcap file and some thoughts on RST issue that you can=20
find by following the next link:=20
https://dmytro.shytyi.net/mptcp-fast-open-in-linux-kernel/ and expanding=20
the section called "_PATCH v4_ client-server partial support + less=20
impact on existing TCP and MPTCP code."

@Benjamin, could you please share your thoughts on sequence numbers=20
subject during the second launch that probably cause the mptcp RST?


>> ---
>> include/net/mptcp.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 2 +-
>> net/ipv4/tcp_output.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
>> net/mptcp/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 2 +-
>> net/mptcp/mptcp_fastopen.c | 476 +++++++++++++++++++++++++++++++++++++
>> net/mptcp/mptcp_fastopen.h |=C2=A0 67 ++++++
>> net/mptcp/options.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 7 +-
>> net/mptcp/protocol.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8=
 +-
>> net/mptcp/protocol.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3=
 +
>> net/mptcp/sockopt.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 41=
 ++++
>> net/mptcp/subflow.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 7 +-
>> 10 files changed, 604 insertions(+), 12 deletions(-)
>> create mode 100644 net/mptcp/mptcp_fastopen.c
>> create mode 100644 net/mptcp/mptcp_fastopen.h
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
>> diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
>> index 8a7f68efa35f..0f1022b395ef 100644
>> --- a/net/mptcp/Makefile
>> +++ b/net/mptcp/Makefile
>> @@ -2,7 +2,7 @@
>> obj-$(CONFIG_MPTCP) +=3D mptcp.o
>>
>> mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o ctrl.o pm.o=
=20
>> diag.o \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mib.o pm_netlink.o sockopt.o pm_us=
erspace.o sched.o
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mib.o pm_netlink.o sockopt.o pm_us=
erspace.o sched.o=20
>> mptcp_fastopen.o
>>
>> obj-$(CONFIG_SYN_COOKIES) +=3D syncookies.o
>> obj-$(CONFIG_INET_MPTCP_DIAG) +=3D mptcp_diag.o
>> diff --git a/net/mptcp/mptcp_fastopen.c b/net/mptcp/mptcp_fastopen.c
>> new file mode 100644
>> index 000000000000..cca086e178a6
>> --- /dev/null
>> +++ b/net/mptcp/mptcp_fastopen.c
>> @@ -0,0 +1,476 @@
>> +#include "mptcp_fastopen.h"
>> +
>> +int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 size_t len, struct mptcp_sock *msk,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 size_t *copied)
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
(sizeof(*tp->fastopen_req),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ssk->sk->sk=
_allocation);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (unlikely(!tp->fastopen_req))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_EFAULT;
>> +=C2=A0=C2=A0=C2=A0 tp->fastopen_req->data =3D msg;
>> +=C2=A0=C2=A0=C2=A0 tp->fastopen_req->size =3D len;
>> +=C2=A0=C2=A0=C2=A0 tp->fastopen_req->uarg =3D uarg;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* requests a cookie */
>> +=C2=A0=C2=A0=C2=A0 *copied =3D mptcp_stream_connect(sk->sk_socket, uadd=
r,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msg->msg_namelen, msg->msg_flags);
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +out_EFAULT:
>> +=C2=A0=C2=A0=C2=A0 ret =3D -EFAULT;
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +
>> +void mptcp_reqsk_record_syn(const struct sock *sk,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct request_sock *req,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 const struct sk_buff *skb)
>> +{
>> +=C2=A0=C2=A0=C2=A0 if (tcp_sk(sk)->save_syn) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 length =3D skb_network_h=
eader_len(skb) + tcp_hdrlen(skb);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct saved_syn *svd_syn;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 mac_headerlen;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *base;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (tcp_sk(sk)->save_syn =3D=
=3D 2) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 base=
 =3D skb_mac_header(skb);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mac_=
headerlen =3D skb_mac_header_len(skb);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 leng=
th +=3D mac_headerlen;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 base=
 =3D skb_network_header(skb);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mac_=
headerlen =3D 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 svd_syn =3D kmalloc(struct_s=
ize(svd_syn, data, length),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_ATOMIC);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (svd_syn) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 svd_=
syn->mac_hdrlen =3D mac_headerlen;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 svd_=
syn->network_hdrlen =3D skb_network_header_len(skb);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 svd_=
syn->tcp_hdrlen =3D tcp_hdrlen(skb);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memc=
py(svd_syn->data, base, length);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req-=
>saved_syn =3D svd_syn;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +}
>> +
>> +void mptcp_ecn_create_request(struct request_sock *req,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct sk_buff *skb,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct sock *listen_sk,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct dst_entry *dst)
>> +{
>> +=C2=A0=C2=A0=C2=A0 const struct tcphdr *thdr =3D tcp_hdr(skb);
>> +=C2=A0=C2=A0=C2=A0 const struct net *net =3D sock_net(listen_sk);
>> +=C2=A0=C2=A0=C2=A0 bool thdr_ecn =3D thdr->ece && thdr->cwr;
>> +=C2=A0=C2=A0=C2=A0 bool ect_stat, ecn_okay;
>> +=C2=A0=C2=A0=C2=A0 u32 ecn_okay_dst;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!thdr_ecn)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +
>> +=C2=A0=C2=A0=C2=A0 ect_stat =3D !INET_ECN_is_not_ect(TCP_SKB_CB(skb)->i=
p_dsfield);
>> +=C2=A0=C2=A0=C2=A0 ecn_okay_dst =3D dst_feature(dst, DST_FEATURE_ECN_MA=
SK);
>> +=C2=A0=C2=A0=C2=A0 ecn_okay =3D net->ipv4.sysctl_tcp_ecn || ecn_okay_ds=
t;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (((!ect_stat || thdr->res1) && ecn_okay) ||=20
>> tcp_ca_needs_ecn(listen_sk) ||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (ecn_okay_dst & DST_FEATURE_=
ECN_CA) ||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcp_bpf_ca_needs_ecn((struct=
 sock *)req))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inet_rsk(req)->ecn_ok =3D 1;
>> +}
>> +
>> +void mptcp_openreq_init(struct request_sock *req,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cons=
t struct tcp_options_received *rx_opt,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stru=
ct sk_buff *skb, const struct sock *sk)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct inet_request_sock *ireq =3D inet_rsk(req);
>> +
>> +=C2=A0=C2=A0=C2=A0 req->rsk_rcv_wnd =3D 0;
>> +=C2=A0=C2=A0=C2=A0 tcp_rsk(req)->rcv_isn =3D TCP_SKB_CB(skb)->seq;
>> +=C2=A0=C2=A0=C2=A0 tcp_rsk(req)->rcv_nxt =3D TCP_SKB_CB(skb)->seq + 1;
>> +=C2=A0=C2=A0=C2=A0 tcp_rsk(req)->snt_synack =3D 0;
>> +=C2=A0=C2=A0=C2=A0 tcp_rsk(req)->last_oow_ack_time =3D 0;
>> +=C2=A0=C2=A0=C2=A0 req->mss =3D rx_opt->mss_clamp;
>> +=C2=A0=C2=A0=C2=A0 req->ts_recent =3D rx_opt->saw_tstamp ? rx_opt->rcv_=
tsval : 0;
>> +=C2=A0=C2=A0=C2=A0 ireq->tstamp_ok =3D rx_opt->tstamp_ok;
>> +=C2=A0=C2=A0=C2=A0 ireq->sack_ok =3D rx_opt->sack_ok;
>> +=C2=A0=C2=A0=C2=A0 ireq->snd_wscale =3D rx_opt->snd_wscale;
>> +=C2=A0=C2=A0=C2=A0 ireq->wscale_ok =3D rx_opt->wscale_ok;
>> +=C2=A0=C2=A0=C2=A0 ireq->acked =3D 0;
>> +=C2=A0=C2=A0=C2=A0 ireq->ecn_ok =3D 0;
>> +=C2=A0=C2=A0=C2=A0 ireq->ir_rmt_port =3D tcp_hdr(skb)->source;
>> +=C2=A0=C2=A0=C2=A0 ireq->ir_num =3D ntohs(tcp_hdr(skb)->dest);
>> +=C2=A0=C2=A0=C2=A0 ireq->ir_mark =3D inet_request_mark(sk, skb);
>> +}
>> +
>> +void mptcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct sock *msk =3D mptcp_subflow_ctx(sk)->conn;
>> +=C2=A0=C2=A0=C2=A0 struct tcp_sock *tp =3D tcp_sk(sk);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (TCP_SKB_CB(skb)->end_seq =3D=3D tp->rcv_nxt)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +
>> +=C2=A0=C2=A0=C2=A0 skb =3D skb_clone(skb, GFP_ATOMIC);
>> +=C2=A0=C2=A0=C2=A0 if (!skb)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +
>> +=C2=A0=C2=A0=C2=A0 skb_dst_drop(skb);
>> +
>> +=C2=A0=C2=A0=C2=A0 tp->segs_in =3D 0;
>> +=C2=A0=C2=A0=C2=A0 tcp_segs_in(tp, skb);
>> +=C2=A0=C2=A0=C2=A0 __skb_pull(skb, tcp_hdrlen(skb));
>> +=C2=A0=C2=A0=C2=A0 sk_forced_mem_schedule(sk, skb->truesize);
>> +=C2=A0=C2=A0=C2=A0 skb_set_owner_r(skb, sk);
>> +
>> +=C2=A0=C2=A0=C2=A0 TCP_SKB_CB(skb)->seq++;
>> +=C2=A0=C2=A0=C2=A0 TCP_SKB_CB(skb)->tcp_flags &=3D ~TCPHDR_SYN;
>> +
>> +=C2=A0=C2=A0=C2=A0 tp->rcv_nxt =3D TCP_SKB_CB(skb)->end_seq;
>> +
>> +=C2=A0=C2=A0=C2=A0 __skb_queue_tail(&msk->sk_receive_queue, skb);
>> +
>> +=C2=A0=C2=A0=C2=A0 tp->syn_data_acked =3D 1;
>> +
>> +=C2=A0=C2=A0=C2=A0 tp->bytes_received =3D skb->len;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcp_fin(sk);
>> +}
>> +
>> +struct sock *mptcp_fastopen_create_child(struct sock *sk,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sk_buff *skb,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct request_sock *re=
q)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct request_sock_queue *r_sock_queue =3D=20
>> &inet_csk(sk)->icsk_accept_queue;
>> +=C2=A0=C2=A0=C2=A0 struct tcp_sock *tp;
>> +=C2=A0=C2=A0=C2=A0 struct sock *child_sock;
>> +=C2=A0=C2=A0=C2=A0 bool own_req;
>> +
>> +=C2=A0=C2=A0=C2=A0 child_sock =3D inet_csk(sk)->icsk_af_ops->syn_recv_s=
ock(sk, skb,=20
>> req, NULL,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 NULL, &own_req);
>> +=C2=A0=C2=A0=C2=A0 if (!child_sock)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +
>> +=C2=A0=C2=A0=C2=A0 spin_lock(&r_sock_queue->fastopenq.lock);
>> +=C2=A0=C2=A0=C2=A0 r_sock_queue->fastopenq.qlen++;
>> +=C2=A0=C2=A0=C2=A0 spin_unlock(&r_sock_queue->fastopenq.lock);
>> +
>> +=C2=A0=C2=A0=C2=A0 tp =3D tcp_sk(child_sock);
>> +
>> +=C2=A0=C2=A0=C2=A0 rcu_assign_pointer(tp->fastopen_rsk, req);
>> +=C2=A0=C2=A0=C2=A0 tcp_rsk(req)->tfo_listener =3D true;
>> +
>> +=C2=A0=C2=A0=C2=A0 tp->snd_wnd =3D ntohs(tcp_hdr(skb)->window);
>> +=C2=A0=C2=A0=C2=A0 tp->max_window =3D tp->snd_wnd;
>> +
>> +=C2=A0=C2=A0=C2=A0 inet_csk_reset_xmit_timer(child_sock, ICSK_TIME_RETR=
ANS,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TCP_TIMEOUT_INIT, TCP_RTO_MAX);
>> +
>> +=C2=A0=C2=A0=C2=A0 refcount_set(&req->rsk_refcnt, 2);
>> +
>> +=C2=A0=C2=A0=C2=A0 tcp_init_transfer(child_sock,=20
>> BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB, skb);
>> +
>> +
>> +=C2=A0=C2=A0=C2=A0 tp->rcv_nxt =3D TCP_SKB_CB(skb)->seq + 1;
>> +=C2=A0=C2=A0=C2=A0 //tp->rcv_nxt =3D TCP_SKB_CB(skb)->end_seq;
>> +=C2=A0=C2=A0=C2=A0 //tp->copied_seq =3D 4;//3
>> +
>> +=C2=A0=C2=A0=C2=A0 mptcp_fastopen_add_skb(child_sock, skb);
>> +
>> +=C2=A0=C2=A0=C2=A0 tcp_rsk(req)->rcv_nxt =3D tp->rcv_nxt;
>> +=C2=A0=C2=A0=C2=A0 tp->rcv_wup =3D tp->rcv_nxt;
>> +
>> +=C2=A0=C2=A0=C2=A0 return child_sock;
>> +}
>> +
>> +bool mptcp_fastopen_queue_check(struct sock *sk)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct fastopen_queue *fo_queue;
>> +=C2=A0=C2=A0=C2=A0 struct request_sock *req_sock;
>> +
>> +=C2=A0=C2=A0=C2=A0 fo_queue =3D &inet_csk(sk)->icsk_accept_queue.fastop=
enq;
>> +=C2=A0=C2=A0=C2=A0 if (fo_queue->max_qlen =3D=3D 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (fo_queue->qlen >=3D fo_queue->max_qlen) {
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&fo_queue->lock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req_sock =3D fo_queue->rskq_=
rst_head;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!req_sock || time_after(=
req_sock->rsk_timer.expires,=20
>> jiffies)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin=
_unlock(&fo_queue->lock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn false;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fo_queue->rskq_rst_head =3D =
req_sock->dl_next;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fo_queue->qlen--;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock(&fo_queue->lock)=
;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reqsk_put(req_sock);
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 return true;
>> +}
>> +
>> +bool mptcp_fastopen_cookie_gen_cipher(struct request_sock *req,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sk_buff *s=
yn,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const siphash_key=
_t *key,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct tcp_fastop=
en_cookie *foc)
>> +{
>> +=C2=A0=C2=A0=C2=A0 if (req->rsk_ops->family =3D=3D AF_INET) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iphdr *iph =3D =
ip_hdr(syn);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 foc->val[0] =3D cpu_to_le64(=
siphash(&iph->saddr,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(iph->saddr=
) +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(iph->daddr=
),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 key));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 foc->len =3D TCP_FASTOPEN_CO=
OKIE_SIZE;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return false;
>> +}
>> +
>> +
>> +void mptcp_fastopen_cookie_gen(struct sock *sk,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct request_sock *req,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sk_buff *syn,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct tcp_fastopen_cookie *foc)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct tcp_fastopen_context *ctx;
>> +
>> +=C2=A0=C2=A0=C2=A0 rcu_read_lock();
>> +=C2=A0=C2=A0=C2=A0 ctx =3D tcp_fastopen_get_ctx(sk);
>> +=C2=A0=C2=A0=C2=A0 if (ctx)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp_fastopen_cookie_gen_ci=
pher(req, syn, &ctx->key[0], foc);
>> +=C2=A0=C2=A0=C2=A0 rcu_read_unlock();
>> +}
>> +
>> +int mptcp_fastopen_cookie_gen_check(struct sock *sk,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct request_sock *req,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sk_buff *syn,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct tcp_fastopen_cookie *o=
rig,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct tcp_fastopen_cookie *v=
alid_foc)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct tcp_fastopen_cookie mptcp_search_foc =3D { .l=
en =3D -1 };
>> +=C2=A0=C2=A0=C2=A0 struct tcp_fastopen_cookie *mptcp_foc =3D valid_foc;
>> +=C2=A0=C2=A0=C2=A0 struct tcp_fastopen_context *mptcp_fo_ctx;
>> +=C2=A0=C2=A0=C2=A0 int i, ret =3D 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 rcu_read_lock();
>> +=C2=A0=C2=A0=C2=A0 mptcp_fo_ctx =3D tcp_fastopen_get_ctx(sk);
>> +=C2=A0=C2=A0=C2=A0 if (!mptcp_fo_ctx)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < tcp_fastopen_context_len(mptcp_fo_=
ctx); i++) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp_fastopen_cookie_gen_ci=
pher(req, syn,=20
>> &mptcp_fo_ctx->key[i], mptcp_foc);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (tcp_fastopen_cookie_matc=
h(mptcp_foc, orig)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D i + 1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto=
 out;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp_foc =3D &mptcp_search_=
foc;
>> +=C2=A0=C2=A0=C2=A0 }
>> +out:
>> +=C2=A0=C2=A0=C2=A0 rcu_read_unlock();
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +
>> +
>> +bool mptcp_fastopen_no_cookie(const struct sock *sk,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct dst_entry *dst,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int flag)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return (sock_net(sk)->ipv4.sysctl_tcp_fastopen & fla=
g) ||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcp_sk(sk)=
->fastopen_no_cookie ||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (dst && ds=
t_metric(dst, RTAX_FASTOPEN_NO_COOKIE));
>> +}
>> +
>> +struct sock *mptcp_try_fastopen(struct sock *sk, struct sk_buff *skb,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct request_sock *req,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct tcp_fastopen_cookie *foc,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 const struct dst_entry *dst)
>> +{
>> +=C2=A0=C2=A0=C2=A0 bool syn_data_status =3D TCP_SKB_CB(skb)->end_seq !=
=3D=20
>> TCP_SKB_CB(skb)->seq + 1;
>> +=C2=A0=C2=A0=C2=A0 struct tcp_fastopen_cookie valid_mptcp_foc =3D { .le=
n =3D -1 };
>> +=C2=A0=C2=A0=C2=A0 struct sock *child_sock;
>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>> +
>> +
>> +=C2=A0=C2=A0=C2=A0 if ((syn_data_status || foc->len >=3D 0) &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp_fastopen_q=
ueue_check(sk)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 foc->len =3D -1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (mptcp_fastopen_no_cookie(sk, dst, TFO_SERVER_COO=
KIE_NOT_REQD))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fastopen;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (foc->len =3D=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp_fastopen_cookie_gen(sk=
, req, skb, &valid_mptcp_foc);
>> +=C2=A0=C2=A0=C2=A0 } else if (foc->len > 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D mptcp_fastopen_cooki=
e_gen_check(sk, req, skb, foc,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 &valid_mptcp_foc);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __as=
m__ ("NOP");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> +fastopen:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chil=
d_sock =3D mptcp_fastopen_create_child(sk, skb, req);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
child_sock) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=3D 2) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 valid_mptcp_foc.exp =3D foc->=
exp;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *foc =3D valid_mptcp_foc;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 foc->len =3D -1;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return child_sock;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 valid_mptcp_foc.exp =3D foc->exp;
>> +=C2=A0=C2=A0=C2=A0 *foc =3D valid_mptcp_foc;
>> +=C2=A0=C2=A0=C2=A0 return NULL;
>> +}
>> +
>> +int mptcp_conn_request(struct request_sock_ops *rsk_ops,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 const struct tcp_request_sock_ops *af_ops,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct sock *sk, struct sk_buff *skb)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct tcp_fastopen_cookie mptcp_foc =3D { .len =3D =
-1 };
>> +=C2=A0=C2=A0=C2=A0 struct tcp_options_received tmp_opt_rcvd;
>> +=C2=A0=C2=A0=C2=A0 __u32 isn =3D TCP_SKB_CB(skb)->tcp_tw_isn;
>> +=C2=A0=C2=A0=C2=A0 struct tcp_sock *tp_sock =3D tcp_sk(sk);
>> +=C2=A0=C2=A0=C2=A0 struct sock *mptcp_fo_sk =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 struct net *net =3D sock_net(sk);
>> +=C2=A0=C2=A0=C2=A0 struct request_sock *req_sock;
>> +=C2=A0=C2=A0=C2=A0 bool want_cookie =3D false;
>> +=C2=A0=C2=A0=C2=A0 struct dst_entry *dst;
>> +=C2=A0=C2=A0=C2=A0 struct flowi fl;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (sk_acceptq_is_full(sk)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto drop;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 req_sock =3D inet_reqsk_alloc(rsk_ops, sk, !want_coo=
kie);
>> +=C2=A0=C2=A0=C2=A0 if (!req_sock)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto drop;
>> +
>> +=C2=A0=C2=A0=C2=A0 req_sock->syncookie =3D want_cookie;
>> +=C2=A0=C2=A0=C2=A0 tcp_rsk(req_sock)->af_specific =3D af_ops;
>> +=C2=A0=C2=A0=C2=A0 tcp_rsk(req_sock)->ts_off =3D 0;
>> +=C2=A0=C2=A0=C2=A0 tcp_rsk(req_sock)->is_mptcp =3D 1;
>> +
>> +=C2=A0=C2=A0=C2=A0 tcp_clear_options(&tmp_opt_rcvd);
>> +=C2=A0=C2=A0=C2=A0 tmp_opt_rcvd.mss_clamp =3D af_ops->mss_clamp;
>> +=C2=A0=C2=A0=C2=A0 tmp_opt_rcvd.user_mss=C2=A0 =3D tp_sock->rx_opt.user=
_mss;
>> +=C2=A0=C2=A0=C2=A0 tcp_parse_options(sock_net(sk), skb, &tmp_opt_rcvd, =
0,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 want_cookie ? NULL : &mptcp_foc);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (want_cookie && !tmp_opt_rcvd.saw_tstamp)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcp_clear_options(&tmp_opt_r=
cvd);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (IS_ENABLED(CONFIG_SMC) && want_cookie)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp_opt_rcvd.smc_ok =3D 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 tmp_opt_rcvd.tstamp_ok =3D tmp_opt_rcvd.saw_tstamp;
>> +=C2=A0=C2=A0=C2=A0 mptcp_openreq_init(req_sock, &tmp_opt_rcvd, skb, sk)=
;
>> +=C2=A0=C2=A0=C2=A0 inet_rsk(req_sock)->no_srccheck =3D inet_sk(sk)->tra=
nsparent;
>> +
>> +=C2=A0=C2=A0=C2=A0 inet_rsk(req_sock)->ir_iif =3D inet_request_bound_de=
v_if(sk, skb);
>> +
>> +=C2=A0=C2=A0=C2=A0 dst =3D af_ops->route_req(sk, skb, &fl, req_sock);
>> +=C2=A0=C2=A0=C2=A0 if (!dst)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto drop_and_free;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (tmp_opt_rcvd.tstamp_ok)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcp_rsk(req_sock)->ts_off =
=3D af_ops->init_ts_off(net, skb);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!want_cookie && !isn) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!net->ipv4.sysctl_tcp_sy=
ncookies &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (net=
->ipv4.sysctl_max_syn_backlog -=20
>> inet_csk_reqsk_queue_len(sk) <
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 (net->ipv4.sysctl_max_syn_backlog >> 2)) &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !tcp=
_peer_is_proven(req_sock, dst)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto=
 drop_and_release;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 isn =3D af_ops->init_seq(skb=
);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 mptcp_ecn_create_request(req_sock, skb, sk, dst);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (want_cookie) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 isn =3D cookie_init_sequence=
(af_ops, sk, skb, &req_sock->mss);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!tmp_opt_rcvd.tstamp_ok)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inet=
_rsk(req_sock)->ecn_ok =3D 0;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 tcp_rsk(req_sock)->snt_isn =3D isn;
>> +=C2=A0=C2=A0=C2=A0 tcp_rsk(req_sock)->txhash =3D net_tx_rndhash();
>> +=C2=A0=C2=A0=C2=A0 tcp_rsk(req_sock)->syn_tos =3D TCP_SKB_CB(skb)->ip_d=
sfield;
>> +
>> +=C2=A0=C2=A0=C2=A0 tcp_openreq_init_rwin(req_sock, sk, dst);
>> +=C2=A0=C2=A0=C2=A0 sk_rx_queue_set(req_to_sk(req_sock), skb);
>> +=C2=A0=C2=A0=C2=A0 if (!want_cookie) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp_reqsk_record_syn(sk, r=
eq_sock, skb);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp_fo_sk =3D mptcp_try_fa=
stopen(sk, skb, req_sock,=20
>> &mptcp_foc, dst);
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 if (mptcp_fo_sk) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 af_ops->send_synack(mptcp_fo=
_sk, dst, &fl, req_sock,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &mptcp_foc, TCP_SYNACK_FASTOP=
EN, skb);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!inet_csk_reqsk_queue_ad=
d(sk, req_sock, mptcp_fo_sk)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reqs=
k_fastopen_remove(mptcp_fo_sk, req_sock, false);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bh_u=
nlock_sock(mptcp_fo_sk);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sock=
_put(mptcp_fo_sk);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto=
 drop_and_free;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sk->sk_data_ready(sk);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bh_unlock_sock(mptcp_fo_sk);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sock_put(mptcp_fo_sk);
>> +
>> +
>> +=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcp_rsk(req_sock)->tfo_liste=
ner =3D false;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!want_cookie) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req_=
sock->timeout =3D tcp_timeout_init((struct sock=20
>> *)req_sock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inet=
_csk_reqsk_queue_hash_add(sk, req_sock,=20
>> req_sock->timeout);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 af_ops->send_synack(sk, dst,=
 &fl, req_sock, &mptcp_foc,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !want_cookie ? TCP_SYNACK_NOR=
MAL :
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 TCP_SYNACK_COOKIE,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skb);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (want_cookie) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reqs=
k_free(req_sock);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn 0;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 reqsk_put(req_sock);
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +
>> +drop_and_release:
>> +=C2=A0=C2=A0=C2=A0 dst_release(dst);
>> +drop_and_free:
>> +=C2=A0=C2=A0=C2=A0 __reqsk_free(req_sock);
>> +drop:
>> +=C2=A0=C2=A0=C2=A0 tcp_listendrop(sk);
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> diff --git a/net/mptcp/mptcp_fastopen.h b/net/mptcp/mptcp_fastopen.h
>> new file mode 100644
>> index 000000000000..c050195c60a7
>> --- /dev/null
>> +++ b/net/mptcp/mptcp_fastopen.h
>> @@ -0,0 +1,67 @@
>> +/* SPDX-License-Identifier: GPL-2.0
>> + * MPTCP Fast Open Mechanism. Copyright (c) 2021-2022, Dmytro SHYTYI.
>> + */
>> +
>> +#ifndef __MPTCP_FASTOPEN_H
>> +#define __MPTCP_FASTOPEN_H
>> +
>> +#include <uapi/linux/mptcp.h>
>> +#include <net/mptcp.h>
>> +#include <net/sock.h>
>> +#include "protocol.h"
>> +
>> +int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 size_t len, struct mptcp_sock *msk,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 size_t *copied);
>> +
>> +void mptcp_reqsk_record_syn(const struct sock *sk,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct request_sock *req,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 const struct sk_buff *skb);
>> +
>> +void mptcp_ecn_create_request(struct request_sock *req,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct sk_buff *skb,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct sock *listen_sk,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct dst_entry *dst);
>> +
>> +void mptcp_openreq_init(struct request_sock *req,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cons=
t struct tcp_options_received *rx_opt,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stru=
ct sk_buff *skb, const struct sock *sk);
>> +
>> +void mptcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb);
>> +
>> +struct sock *mptcp_fastopen_create_child(struct sock *sk,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sk_buff *skb,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct request_sock *re=
q);
>> +
>> +bool mptcp_fastopen_queue_check(struct sock *sk);
>> +
>> +bool mptcp_fastopen_cookie_gen_cipher(struct request_sock *req,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sk_buff *s=
yn,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const siphash_key=
_t *key,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct tcp_fastop=
en_cookie *foc);
>> +
>> +void mptcp_fastopen_cookie_gen(struct sock *sk,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct request_sock *req,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sk_buff *syn,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct tcp_fastopen_cookie *foc);
>> +
>> +int mptcp_fastopen_cookie_gen_check(struct sock *sk,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct request_sock *req,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sk_buff *syn,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct tcp_fastopen_cookie *o=
rig,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct tcp_fastopen_cookie *v=
alid_foc);
>> +
>> +bool mptcp_fastopen_no_cookie(const struct sock *sk,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct dst_entry *dst,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int flag);
>> +
>> +struct sock *mptcp_try_fastopen(struct sock *sk, struct sk_buff *skb,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct request_sock *req,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct tcp_fastopen_cookie *foc,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 const struct dst_entry *dst);
>> +
>> +int mptcp_conn_request(struct request_sock_ops *rsk_ops,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 const struct tcp_request_sock_ops *af_ops,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 struct sock *sk, struct sk_buff *skb);
>> +
>> +#endif /* __MPTCP_FASTOPEN_H */
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index be3b918a6d15..1ce965ee71d2 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -887,16 +887,19 @@ bool mptcp_established_options(struct sock *sk,=20
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
>> +=C2=A0=C2=A0=C2=A0 struct inet_request_sock *ireq =3D inet_rsk(req);
>> +#define OPTION_TS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(1)
>> +=C2=A0=C2=A0=C2=A0 *tcp_options ^=3D OPTION_TS;
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
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_debug("subflow_req=3D%p, l=
ocal_key=3D%llu",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 subflow_req, subflow_req->local_key);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index d6aef4b13b8a..64a2635405c4 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -25,6 +25,7 @@
>> #include <asm/ioctls.h>
>> #include "protocol.h"
>> #include "mib.h"
>> +#include "mptcp_fastopen.h"
>>
>> #define CREATE_TRACE_POINTS
>> #include <trace/events/mptcp.h>
>> @@ -1690,9 +1691,9 @@ static int mptcp_sendmsg(struct sock *sk, struct=
=20
>> msghdr *msg, size_t len)
>> =C2=A0=C2=A0=C2=A0=C2=A0int ret =3D 0;
>> =C2=A0=C2=A0=C2=A0=C2=A0long timeo;
>>
>> -=C2=A0=C2=A0=C2=A0 /* we don't support FASTOPEN yet */
>> +=C2=A0=C2=A0=C2=A0 /* we don't fully support FASTOPEN yet */
>> =C2=A0=C2=A0=C2=A0=C2=A0if (msg->msg_flags & MSG_FASTOPEN)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EOPNOTSUPP;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp_sendmsg_fastopen(sk, m=
sg, len, msk, &copied);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0/* silently ignore everything else */
>> =C2=A0=C2=A0=C2=A0=C2=A0msg->msg_flags &=3D MSG_MORE | MSG_DONTWAIT | MS=
G_NOSIGNAL;
>> @@ -2681,6 +2682,7 @@ void mptcp_subflow_shutdown(struct sock *sk,=20
>> struct sock *ssk, int how)
>> =C2=A0=C2=A0=C2=A0=C2=A0case TCP_SYN_SENT:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcp_disconnect(ssk, O_NONBLOC=
K);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 case TCP_ESTABLISHED:
>> =C2=A0=C2=A0=C2=A0=C2=A0default:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (__mptcp_check_fallback(mp=
tcp_sk(sk))) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_de=
bug("Fallback");
>> @@ -3476,7 +3478,7 @@ static void mptcp_subflow_early_fallback(struct=20
>> mptcp_sock *msk,
>> =C2=A0=C2=A0=C2=A0=C2=A0__mptcp_do_fallback(msk);
>> }
>>
>> -static int mptcp_stream_connect(struct socket *sock, struct sockaddr=20
>> *uaddr,
>> +int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 int addr_len, int flags)
>> {
>> =C2=A0=C2=A0=C2=A0=C2=A0struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>> index 8739794166d8..6b8784a35244 100644
>> --- a/net/mptcp/protocol.h
>> +++ b/net/mptcp/protocol.h
>> @@ -891,6 +891,9 @@ unsigned int=20
>> mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
>> unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
>> unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk);
>>
>> +int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 int addr_len, int flags);
>> +
>> /* called under PM lock */
>> static inline void __mptcp_pm_close_subflow(struct mptcp_sock *msk)
>> {
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
>=20
> Since fastopen is only relevant for the initial subflow (and never with=
=20
> MP_JOIN), I don't think it's necessary to iterate over the subflows=20
> here. __mptcp_nmpc_socket() should give the initial subflow, check how=20
> it is used elsewhere in net/mptcp/sockopt.c
>=20
>=20
> Thanks,
>=20
> Mat

Thank you,

Dmytro.
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
>> index 8841e8cd9ad8..9fa71b67fd5a 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -22,6 +22,7 @@
>> #endif
>> #include <net/mptcp.h>
>> #include <uapi/linux/mptcp.h>
>> +#include "mptcp_fastopen.h"
>> #include "protocol.h"
>> #include "mib.h"
>>
>> @@ -542,9 +543,9 @@ static int subflow_v4_conn_request(struct sock=20
>> *sk, struct sk_buff *skb)
>> =C2=A0=C2=A0=C2=A0=C2=A0if (skb_rtable(skb)->rt_flags & (RTCF_BROADCAST =
| RTCF_MULTICAST))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto drop;
>>
>> -=C2=A0=C2=A0=C2=A0 return tcp_conn_request(&mptcp_subflow_request_sock_=
ops,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 &subflow_request_sock_ipv4_ops,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 sk, skb);
>> +=C2=A0=C2=A0=C2=A0 return mptcp_conn_request(&mptcp_subflow_request_soc=
k_ops,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &subflow_request_=
sock_ipv4_ops,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sk, skb);
>> drop:
>> =C2=A0=C2=A0=C2=A0=C2=A0tcp_listendrop(sk);
>> =C2=A0=C2=A0=C2=A0=C2=A0return 0;
>> --=20
>> 2.25.1
>>
>>
>>
>>
>=20
> --=20
> Mat Martineau
> Intel

