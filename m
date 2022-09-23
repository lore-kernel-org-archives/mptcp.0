Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE423D63
	for <mptcp@lists.linux.dev>; Fri, 23 Sep 2022 14:17:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663942669; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Prp8k1S81gZTiHfbuCzcUSrBSdvZbeC+dl58lQNXnmWIUClVVrO9YX5mtRp1GCmL27KEQ3XW4UG9jr2dmLGr0PV3fPLjQtbjSoTsn6kuH4qVDNO642bRciNQFmxWXdqhtC91BCqlZinQIikW406B49uLi03UHffh3jbejvRP60s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663942669; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=Q/JnHtgMuvnMlGztyydbvfx8CY30sJStW4veFJNpLMQ=; 
	b=Hg90vIbmbKlGx/UAsC6F+IExVV1Pra5nJrN7MkX1YU0zB3D2eEBBaJ9m80wevyieww9eZoBQcjNrAM0/q/EgqyY3yuZC6FZczEtQH0zRJvbGu8nZzhDIWEsYnkJ1OjSo1TnV+UrU84NyeNHUo0/wyvzwC06KaqUL7eFRYQKaN/M=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663942669;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Date:Date:MIME-Version:Subject:Subject:To:To:References:From:From:Message-ID:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=Q/JnHtgMuvnMlGztyydbvfx8CY30sJStW4veFJNpLMQ=;
	b=Op0Hi2eWjUUoXPWsoNrBPrn/wbk5eY535gy78AwcG1tFsQcUkDcTLN5BRItaY4Q3
	yoY7tCPJrMfmDD9YaM3+N0Qlc2pVOCu/EBzS3HEijpyZDJoHgI77n8N9p39ol2K7vAf
	lo3jN/8ZrHaGjhmMKbobMb+1dsJpsoXi2T/dOcks=
Received: from [192.168.1.25] (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663942666612428.91416366634155; Fri, 23 Sep 2022 16:17:46 +0200 (CEST)
Date: Fri, 23 Sep 2022 16:17:45 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH mptcp-next v2 0/4] mptcp: add support for TFO, sender side
 only
Content-Language: fr
To: Matthieu Baerts <matthieu.baerts@tessares.net>,
 benjamin.hesmans@tessares.net, mptcp@lists.linux.dev, pabeni@redhat.com
References: <20220921125558.19483-1-dmytro@shytyi.net>
 <709a843b-b7f7-438d-39c6-f139aaa55a10@shytyi.net>
 <3d37f47b-dd2e-fe80-caab-d1863028d7f1@tessares.net>
 <deea610c-8f09-fbbe-5bbe-7a8900a3b9cd@shytyi.net>
 <93789ec4-7998-6d69-b5c6-e3b88ae178bf@tessares.net>
From: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <f2c771fa-817e-e62b-fab5-828283286fcd@shytyi.net>
In-Reply-To: <93789ec4-7998-6d69-b5c6-e3b88ae178bf@tessares.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External


On 9/23/2022 4:08 PM, Matthieu Baerts wrote:
> On 23/09/2022 15:41, Dmytro Shytyi wrote:
>> Hello,
>>
>> I am sharing experience from using the patch with environment that is
>> provided to test the patch with selftest ( As i mentioned before).
>> I take me some time to launch the patch. Hope this will help.
> Probably best to check with packetdrill as usually recommended to
> validate such modifications. The manual steps can lead to a wrong
> environment.
>
>> On 9/23/2022 12:58 PM, Matthieu Baerts wrote:
>>> Hi Dmytro,
>>>
>>> On 23/09/2022 01:23, Dmytro Shytyi wrote:
>>>> Hello Benjamin, All,
>>>>
>>>> I excuse for the later if I made any mistake.
>>>>
>>>> My thought is comming from experience with the patch.
>>>>
>>>>
>>>> Will huge respect, I think this patch _*MUST NOT*_ be accepted because
>>>> of multiple reasons:
>>>>
>>>> 1. it violates the RFC 8684 [1] section B1:
>>>>
>>>> "When a TFO initiator first connects to a listener, it cannot
>>>> immediately include data in the SYN for security reasons[RFC7413
>>>> <https://www.rfc-editor.org/rfc/rfc8684.html#RFC7413>]. Instead, it
>>>> requests a cookie that will be used in subsequent connections."
>>>>
>>>>
>>>> Also I created environment[3] using commit[2], I tested v0, v2 and I d=
o
>>>> not see the mptcp capable option in SYN.
>>>  =C2=A0From what I see in your setup, you set net.ipv4.tcp_fastopen:
>>> - The sender has the 0x4 flag to send data in the opening SYN regardles=
s
>>> of cookie availability and without a cookie option.
>>> - The receiver has the 0x200 flag to accept data-in-SYN w/o any cookie
>>> option present
>>>
>>> See the link below for more details about the bitmap:
>>>
>>> https://www.kernel.org/doc/html/latest/networking/ip-sysctl.html
>>>
>>> If you change these values, I guess you will see the TFO cookie option.
>>>
>>> Please note that the proper way to validate exchanged packet is to use
>>> Packetdrill. The following PR proves the implementation works with TFO
>>> cookies:
>>>
>>> https://github.com/multipath-tcp/packetdrill/pull/87
>> Could you please verify this with wireshark before the acceptence?
> Here is the output from Packetdrill:
>
>> root@(none):/opt/packetdrill/gtests/net/mptcp# ../packetdrill/packetdril=
l -v ./fastopen/client-TCP_FASTOPEN_CONNECT.pkt
>> socket syscall: 1663941238.170913
>> fcntl syscall: 1663941238.171243
>> setsockopt syscall: 1663941238.171551
>> connect syscall: 1663941238.171964
>> outbound sniffed packet:  0.001058 S 1708222581:1708222581(0) win 65535 =
<mss 1460,sackOK,TS val 1122428945 ecr 0,nop,wscale 8,FO,nop,nop,mp_capable=
 v1 flags: |H| >
>> inbound injected packet:  0.012799 S. 0:0(0) ack 1708222582 win 65535 <m=
ss 1460,sackOK,TS val 700 ecr 1122428945,nop,wscale 8,FO abcd1234,nop,nop,m=
p_capable v1 flags: |H| sender_key: 2>
>> outbound sniffed packet:  0.015375 . 1708222582:1708222582(0) ack 1 win =
256 <nop,nop,TS val 1122428959 ecr 700,mp_capable v1 flags: |H| sender_key:=
 12211970130642946725 receiver_key: 2>
>> close syscall: 1663941238.199617
>> outbound sniffed packet:  0.028711 . 1708222582:1708222582(0) ack 1 win =
256 <nop,nop,TS val 1122428959 ecr 700,dss dack4 3007449509 dsn8 1700322262=
5898214342 ssn 0 dll 1 no_checksum flags: MmAF,nop,nop>
>> inbound injected packet:  0.030712 . 1:1(0) ack 1708222582 win 450 <nop,=
nop,TS val 700 ecr 1122428959,dss dack4 764163015 dsn4 3007449509 ssn 0 dll=
 1 no_checksum flags: MAF,nop,nop>
>> outbound sniffed packet:  0.032187 . 1708222582:1708222582(0) ack 1 win =
256 <nop,nop,TS val 1122428976 ecr 700,dss dack4 3007449510 flags: A>
>> outbound sniffed packet:  0.033824 R. 1708222582:1708222582(0) ack 1 win=
 256 <nop,nop,TS val 1122428978 ecr 700,mp_fastclose receiver key: 2,mp_res=
et 0>
>> socket syscall: 1663941238.306640
>> fcntl syscall: 1663941238.307030
>> setsockopt syscall: 1663941238.307543
>> connect syscall: 1663941238.308340
>> write syscall: 1663941238.309088
>> outbound sniffed packet:  0.138181 S 3843296367:3843296867(500) win 6553=
5 <mss 1460,sackOK,TS val 1122429082 ecr 0,nop,wscale 8,FO abcd1234,nop,nop=
,mp_capable v1 flags: |H| >
>> inbound injected packet:  0.151901 S. 0:0(0) ack 3843296868 win 65535 <m=
ss 1460,sackOK,TS val 700 ecr 1122429082,nop,wscale 8,mp_capable v1 flags: =
|H| sender_key: 2>
>
> And the output from tcpdump when doing the same test:
>
>> root@(none):/opt/packetdrill/gtests/net/mptcp# ../packetdrill/packetdril=
l ./fastopen/client-TCP_FASTOPEN_CONNECT.pkt
>> 13:53:44.586369 tun0  Out IP6 fe80::2ecf:46fa:841:cae > ff02::2: ICMP6, =
router solicitation, length 8
>> 13:53:44.860976 tun0  Out IP 192.168.49.174.60676 > 192.0.2.1.8080: Flag=
s [S], seq 2694673015, win 65535, options [mss 1460,sackOK,TS val 203699313=
4 ecr 0,nop,wscale 8,tfo  cookiereq,nop,nop,mptcp capable v1], length 0
>> 13:53:44.871047 tun0  In  IP 192.0.2.1.8080 > 192.168.49.174.60676: Flag=
s [S.], seq 0, ack 2694673016, win 65535, options [mss 1460,sackOK,TS val 7=
00 ecr 2036993134,nop,wscale 8,tfo  cookie abcd1234,nop,nop,mptcp capable v=
1 {0x200000000000000}], length 0
>> 13:53:44.871063 tun0  Out IP 192.168.49.174.60676 > 192.0.2.1.8080: Flag=
s [.], ack 1, win 256, options [nop,nop,TS val 2036993144 ecr 700,mptcp cap=
able v1 {0x3827b4480bfa870f,0x200000000000000}], length 0
>> 13:53:44.881125 tun0  Out IP 192.168.49.174.60676 > 192.0.2.1.8080: Flag=
s [.], ack 1, win 256, options [nop,nop,TS val 2036993144 ecr 700,mptcp dss=
 fin ack 3007449509 seq 5431916111306864352 subseq 0 len 1,nop,nop], length=
 0
>> 13:53:44.881210 tun0  In  IP 192.0.2.1.8080 > 192.168.49.174.60676: Flag=
s [.], ack 1, win 450, options [nop,nop,TS val 700 ecr 2036993144,mptcp dss=
 fin ack 2016065249 seq 3007449509 subseq 0 len 1,nop,nop], length 0
>> 13:53:44.881226 tun0  Out IP 192.168.49.174.60676 > 192.0.2.1.8080: Flag=
s [.], ack 1, win 256, options [nop,nop,TS val 2036993154 ecr 700,mptcp dss=
 ack 3007449510], length 0
>> 13:53:44.881260 tun0  Out IP 192.168.49.174.60676 > 192.0.2.1.8080: Flag=
s [R.], seq 1, ack 1, win 256, options [nop,nop,TS val 2036993154 ecr 700,m=
ptcp fast-close key 0x200000000000000,mptcp unknown], length 0
>> 13:53:44.982454 ?     Out IP 192.168.49.174.60680 > 192.0.2.1.8080: Flag=
s [S], seq 1531938899:1531939399, win 65535, options [mss 1460,sackOK,TS va=
l 2036993255 ecr 0,nop,wscale 8,tfo  cookie abcd1234,nop,nop,mptcp capable =
v1], length 500: HTTP
>> 13:53:44.992484 ?     In  IP 192.0.2.1.8080 > 192.168.49.174.60680: Flag=
s [S.], seq 0, ack 1531939400, win 65535, options [mss 1460,sackOK,TS val 7=
00 ecr 2036993255,nop,wscale 8,mptcp capable v1 {0x200000000000000}], lengt=
h 0
>> 13:53:44.992494 ?     Out IP 192.168.49.174.60680 > 192.0.2.1.8080: Flag=
s [.], ack 1, win 256, options [nop,nop,TS val 2036993265 ecr 700,mptcp cap=
able v1 {0x75382dfb6dafc693,0x200000000000000}], length 0
>> 13:53:44.992539 ?     Out IP 192.168.49.174.60680 > 192.0.2.1.8080: Flag=
s [.], ack 1, win 256, options [nop,nop,TS val 2036993265 ecr 700,mptcp dss=
 fin ack 3007449509 seq 6967145468519815204 subseq 0 len 1,nop,nop], length=
 0
> We can see:
>
> - in the first SYN:
>    - "tfo cookiereq"
>    - "mptcp capable v1"
>    - "length 0"
>
> - in the second SYN:
>    - "tfo  cookie abcd1234"
>    - "mptcp capable v1"
>    - "length 500"
>
> Everything seems then OK.

Yes. Indeed. In this case my environment is wrongly configured. I=20
appoligise for creating the disturbance about functionality of the patch=20
( as mentioned in the beggining of the original message)

>>>> 3. Patch uses an original Idea of another autor from mailing list (Reu=
se
>>>> the TCP FASTOPEN option in MPTCP).
>>> A v3 mentioning you is going to be sent as discussed at the last meetin=
g.
>>>
>>> We should indeed mention the authors of the original idea to have TFO i=
n
>>> MPTCP:
>>>
>>> https://datatracker.ietf.org/doc/draft-barre-mptcp-tfo/
>>>
>>> Cheers,
>>> Matt
>> It seems this draft didn't get the consensus and was not accepted by
>> IETF as RFC.
>
> This link is just to point to the original idea of having TFO supported
> with MPTCP. This document was used as a base for the evolution of the
> MPTCPv0 (RFC6824) and it was the main reason why we have an MPTCPv1
> (RFC8684) where the MP_CAPABLE is different from the v0 to allow TFO
> cookie options in the initial SYN. So yes, it was somehow accepted by
> the IETF but as part of RFC8684.
>
>> How the abstract RFC related to the original idea to reuse
>> TFO option from regular TCP in linux kernel implementation?
> Sorry, what do you mean here?
> Implementing TFO in MPTCP Linux Upstream is part of the roadmap from the
> beginning, see ticket 59 on Github.

I think there could be some confision:

1. One thing to implement TFO in MPTCP (draft)

2. Second thing is roadmap to implement in in upstream Linux.

What I'm talking about is: "reuse regular TFO option from regular TCP in=20
MPTCP".


Best,

Dmytro.


> Cheers,
> Matt




