Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEB929CA
	for <mptcp@lists.linux.dev>; Fri, 21 Jan 2022 00:01:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1642723253; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Z8D/kJLEPZ41cLPUjGPQbpjKOIxl4T2iBqbeploJAgjQe8jaOUpz1Vx7eDECw4mum/+bft569CVLd+1RJRcNMSSVUyE+u6rcc+BiOAzozQGrHilQVtzA2obQ4EjTdCaAL2tJY3rZGFieyQpjeBD7/qlKaP4298j5/DOkbjb2Mbg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1642723253; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=0gM4B0TKBl9GM6psqEdSpx1yMkDEZROkuY391BDzbak=; 
	b=jeLb99BlN16yiBSRzfM8fBrDp1aRhj1wfXIVSCIH/aeOOPSV0X5mh0Kr0cz5odu6F3Y6rg31V+4Np8ja1+Rg6O1CK4e521nMAEDRgb4kAZ44aQrIxe8X5U46uZQQlzDU4FT6L7HTzap9OvkLVdsy6NupM55y/GNZ/fLmTvX1zjI=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1642723253;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Subject:From:To:Message-ID:References:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=0gM4B0TKBl9GM6psqEdSpx1yMkDEZROkuY391BDzbak=;
	b=cFkL2/wtPnsvXlh9OTGfFKdN/dqz2n1WXdJB3gRwRuJODJ0WIbHeGU+PazxViQnL
	Dt76k6eOQhFuGz3+zZjMpyQhXCb+TaXDtSW0l1NbyhMa61rYdr2opeAU5Vwzax0ZTsr
	FKxQlL8DIl3MJ+QD9M3WCfXcvVf9Srm6EoAFQysg=
Received: from [192.168.100.116] (vps-f3afed4e.vps.ovh.net [198.244.151.99]) by mx.zoho.eu
	with SMTPS id 1642723251587447.0943211539394; Fri, 21 Jan 2022 01:00:51 +0100 (CET)
Subject: Re: [PATCH net-next v2] net: mptcp, Fast Open Mechanism
From: Dmytro SHYTYI <dmytro@shytyi.net>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Message-ID: <3d5264b0-80b1-3c94-c4d4-671f7040f7a6@shytyi.net>
References: <20220116001259.203319-1-dmytro@shytyi.net>
 <449d3338d759e9f72f33e7c37e1b9956bdda77f4.camel@redhat.com>
 <9f700f12472bddc0d9d899773d2a211bfe8517f6.camel@redhat.com>
 <7d5bdd13-e565-87fd-2854-7f95487d1157@shytyi.net>
 <3f1ec9d12c7903988639689f3a7568a97ce83ef0.camel@redhat.com>
 <27a82812-5502-73ba-8d1d-1cff7a86e207@shytyi.net>
Date: Fri, 21 Jan 2022 00:00:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <27a82812-5502-73ba-8d1d-1cff7a86e207@shytyi.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

Hello Paolo,

On 19/01/2022 17:35, Dmytro SHYTYI wrote:
> Hello Paolo,
>=20
> On 18/01/2022 11:02, Paolo Abeni wrote:
>> On Mon, 2022-01-17 at 21:48 +0000, Dmytro SHYTYI wrote:
>>> Hi Paolo,
>>>
>>> AFAIK, TFO option requires more that 8 bytes, if cookie len is 8 bytes:
>>>
>>> In file /net/ipv4/tcp_output.c (line 689):
>>>
>>> static void tcp_options_write(__be32 *ptr, struct tcp_sock *tp,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct tcp_out_options *opts)
>>> ....
>>> {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(OPT=
ION_FAST_OPEN_COOKIE & options)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct tcp_fastopen_cookie *foc =3D=20
>>> opts->fastopen_cookie;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 *p =3D (u8 *)ptr;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 len; /* Fast Open option length */
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (foc->exp) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 len =3D TCPOLEN_EXP_FASTOPEN_BASE + foc->len;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 *ptr =3D htonl((TCPOPT_EXP << 24) | (len <<=20
>>> 16) |
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 TCPOPT_FASTOPEN_MAGIC);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 p +=3D TCPOLEN_EXP_FASTOPEN_BASE;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 len =3D TCPOLEN_FASTOPEN_BASE + foc->len;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 *p++ =3D TCPOPT_FASTOPEN;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 *p++ =3D len;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memcpy(p, foc->val, foc->len);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((len & 3) =3D=3D 2) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 p[foc->len] =3D TCPOPT_NOP;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 p[foc->len + 1] =3D TCPOPT_NOP;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptr +=3D (len + 3) >> 2;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> ...
>>>
>>> Here we do have=C2=A0 "len =3D TCPOLEN_FASTOPEN_BASE + foc->len" that i=
s
>>> slightly more than 8 bytes.
>>>
>>> This is the cause of introducing 4 byte cookie for MPTCP implementation=
.
>>>
>>> The RFC 8684 B.1. says:
>>> =C2=A0=C2=A0=C2=A0 This is done with the TCP cookie request/response
>>> =C2=A0=C2=A0=C2=A0=C2=A0 options, of 2 bytes and 6-18 bytes, respective=
ly (depending on the
>>> =C2=A0=C2=A0=C2=A0=C2=A0 chosen cookie length).
>>>
>>> So in my understanding, the "selected cookie size +
>>> TCPOLEN_FASTOPEN_BASE" =3D 6, is not prohibited by, and in the allowed
>>> range of the RFC 8684.
>>
>> You are right, I underlooked the TFO option writing.
>>
>>> As you suggested I will document the size of the cookie, if there is no
>>> objections to above information :)
>>
>> Shrinking the TFO cookie size has both security and functional impact:
>>
>> - we do not want to change the TFO cookie size for TCP connection in
>> MPTCP enabled build.
>> - dynamically selecting the TFO cookie size depending on the specific
>> rsk type will add more complexity to the TCP code.
>=20
> I agree with functional and future security impact in case if we reduce=
=20
> the cookie size.
>=20
>> rfc8684 suggests we could remove the TS option from the synack packet.
>> I think it's worthy to try such idea.
>>
>> To do that, we need to change the 'mptcp_synack_options()' hook
>> signature, to accept a 'struct tcp_out_options' as the 3rd argument, so
>> that mptcp_synack_options() can clear the TCPOLEN_TSTAMP_ALIGNED bit
>> when needed.
>=20
> With this we can try to keep "cookie len =3D=3D 8". It will simplify thin=
gs.=20
> I will look into it.

Thanks Paolo!

It looks like it works in my local setup with "MPTCP" and "cookie len =3D=
=3D=20
8", while changing the function signature to:
bool mptcp_synack_options(const struct request_sock *req, unsigned int=20
*size, struct mptcp_out_options *opts, u16 *tcp_options)

and further, edit tcp_options with:
         *tcp_options ^=3D OPTION_TS;


Also I needed to do something like this in func "mptcp_synack_options":
*size =3D TCPOLEN_MPTCP_MPC_SYNACK  - TCPOLEN_TSTAMP_ALIGNED +=20
TCPOLEN_SACKPERM_ALIGNED;


This affected (excluded) some parts of my code that not anymore have=20
impact on the TCP implementation.

Result:
tcpdump with 8 byte cookie len + mptcp option without TSvals in SYNACK:
 >> cookie req:
2022-01-20 22:10:04.275317 IP 10.0.0.1.49572 > 10.0.0.2.7003: Flags [S],=20
seq 4140071331, win 64240, options [mss 1460,sackOK,TS val 608747398 ecr=20
0,nop,wscale 7,tfo  cookiereq,nop,nop,mptcp capable[bad opt]>
2022-01-20 22:10:04.275353 IP 10.0.0.2.7003 > 10.0.0.1.49572: Flags
 >> cookie offer "0696fccb1b35cc39" + mptcp capable:
[S.], seq 2992182232, ack 4140071332, win 65160, options [mss=20
1460,nop,nop,sackOK,nop,wscale 7,tfo  cookie=20
0696fccb1b35cc39,nop,nop,mptcp capable Unknown Version (1)], length 0
2022-01-20 22:10:04.275406 IP 10.0.0.1.49572 > 10.0.0.2.7003: Flags [.],=20
ack 1, win 502, options [mptcp capable Unknown Version (1)], length 0
2022-01-20 22:10:04.275535 IP 10.0.0.1.49572 > 10.0.0.2.7003: Flags=20
[P.], seq 1:4, ack 1, win 502, options [mptcp capable[bad opt]
2022-01-20 22:10:04.275597 IP 10.0.0.2.7003 > 10.0.0.1.49572: Flags [.],=20
ack 4, win 510, options [nop,nop,TS val 458375399 ecr 608747398,mptcp=20
dss ack 17405876484214860771], length 0
2022-01-20 22:10:04.275745 IP 10.0.0.1.49572 > 10.0.0.2.7003: Flags=20
[P.], seq 4:7, ack 1, win 502, options [mptcp dss ack 3584389301 seq=20
17405876484214860771 subseq 4 len 3,nop,nop], length 3
2022-01-20 22:10:04.275850 IP 10.0.0.2.7003 > 10.0.0.1.49572: Flags [.],=20
ack 7, win 510, options [nop,nop,TS val 458375399 ecr 608747398,mptcp=20
dss ack 17405876484214860774], length 0
2022-01-20 22:10:04.275967 IP 10.0.0.1.49572 > 10.0.0.2.7003: Flags=20
[P.], seq 7:10, ack 1, win 502, options [mptcp dss ack 3584389301 seq=20
17405876484214860774 subseq 7 len 3,nop,nop], length 3
2022-01-20 22:10:04.275977 IP 10.0.0.2.7003 > 10.0.0.1.49572: Flags [.],=20
ack 10, win 510, options [nop,nop,TS val 458375399 ecr 608747398,mptcp=20
dss ack 17405876484214860777], length 0
2022-01-20 22:10:04.276073 IP 10.0.0.1.49572 > 10.0.0.2.7003: Flags=20
[P.], seq 10:13, ack 1, win 502, options [mptcp dss ack 3584389301 seq=20
17405876484214860777 subseq 10 len 3,nop,nop], length 3
2022-01-20 22:10:04.276133 IP 10.0.0.2.7003 > 10.0.0.1.49572: Flags [.],=20
ack 13, win 510, options [nop,nop,TS val 458375399 ecr 608747398,mptcp=20
dss ack 17405876484214860780], length 0
2022-01-20 22:10:04.276156 IP 10.0.0.1.49572 > 10.0.0.2.7003: Flags=20
[P.], seq 13:16, ack 1, win 502, options [mptcp dss ack 3584389301 seq=20
17405876484214860780 subseq 13 len 3,nop,nop], length 3
2022-01-20 22:10:04.276161 IP 10.0.0.2.7003 > 10.0.0.1.49572: Flags [.],=20
ack 16, win 510, options [nop,nop,TS val 458375399 ecr 608747398,mptcp=20
dss ack 17405876484214860783], length 0
2022-01-20 22:10:05.902411 IP 10.0.0.1.49574 > 10.0.0.2.7003: Flags [S],=20
seq 3696317251:3696317254, win 64240, options [mss 1460,sackOK,TS val=20
608749026 ecr 0,nop,wscale 7,tfo  cookie 0696fccb1b35cc39,nop,nop,mptcp=20
capable[bad opt]>
2022-01-20 22:10:05.902456 IP 10.0.0.2.7003 > 10.0.0.1.49574: Flags=20
[S.], seq 3169634712, ack 3696317255, win 65160, options [mss=20
1460,nop,nop,sackOK,nop,wscale 7,mptcp capable Unknown Version (1)],=20
length 0
2022-01-20 22:10:05.902496 IP 10.0.0.1.49574 > 10.0.0.2.7003: Flags [.],=20
ack 1, win 502, options [mptcp capable Unknown Version (1)], length 0
2022-01-20 22:10:05.902559 IP 10.0.0.1.49574 > 10.0.0.2.7003: Flags=20
[P.], seq 1:4, ack 1, win 502, options [mptcp capable[bad opt]
2022-01-20 22:10:05.902597 IP 10.0.0.2.7003 > 10.0.0.1.49574: Flags [.],=20
ack 4, win 510, options [nop,nop,TS val 458377026 ecr 608749026,mptcp=20
dss ack 1878450330782657922], length 0
2022-01-20 22:10:05.902620 IP 10.0.0.1.49574 > 10.0.0.2.7003: Flags=20
[P.], seq 4:7, ack 1, win 502, options [mptcp dss ack 414760887 seq=20
2527731727539835193 subseq 4 len 3,nop,nop], length 3
2022-01-20 22:10:05.902638 IP 10.0.0.2.7003 > 10.0.0.1.49574: Flags [.],=20
ack 7, win 510, options [nop,nop,TS val 458377026 ecr 608749026,mptcp=20
dss ack 1878450330782657925], length 0
2022-01-20 22:10:05.902644 IP 10.0.0.1.49574 > 10.0.0.2.7003: Flags=20
[P.], seq 7:10, ack 1, win 502, options [mptcp dss ack 414760887 seq=20
2527731727539835196 subseq 7 len 3,nop,nop], length 3
2022-01-20 22:10:05.902647 IP 10.0.0.2.7003 > 10.0.0.1.49574: Flags [.],=20
ack 10, win 510, options [nop,nop,TS val 458377026 ecr 608749026,mptcp=20
dss ack 1878450330782657928], length 0
2022-01-20 22:10:05.902653 IP 10.0.0.1.49574 > 10.0.0.2.7003: Flags=20
[P.], seq 10:13, ack 1, win 502, options [mptcp dss ack 414760887 seq=20
2527731727539835199 subseq 10 len 3,nop,nop], length 3
2022-01-20 22:10:05.902680 IP 10.0.0.2.7003 > 10.0.0.1.49574: Flags [.],=20
ack 13, win 510, options [nop,nop,TS val 458377026 ecr 608749026,mptcp=20
dss ack 1878450330782657931], length 0


Dmytro.
>> Thanks
>>
>> Paolo
>>
>=20
> Thanks,
> Dmytro.

