Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1233D63
	for <mptcp@lists.linux.dev>; Fri, 23 Sep 2022 14:08:57 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id w28so376327edi.7
        for <mptcp@lists.linux.dev>; Fri, 23 Sep 2022 07:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=C1X9sW3v+fr5FlOBTRLr8OBCJWO5X+gthgg5KmJUoxk=;
        b=NFynTgGQ9ZDBUCWaXpKkkxagEFK+Hy3Jl57SMLk6DFxRqZzeV7Jyz0WSqPOAWw93qd
         p1z8yGug1MgwaSOZygLLDj0oTt+XoSGQAHeHffJhbj1XrZ0VlaAvfTecttmSWKx7iUjt
         iCppQgSZ5C6WMWY89SsLn76m/0HoMSUVs8g9IImcOy6PxQIMlbOTHjDe1MJe8BWsHQDh
         1PQ9h+R/Rb6zkQ/4w/gOoa9xWwMMRsDneAQJM8PVzAzyQv+Ou8T2rq9+clWwrMEqFOgP
         b52a3H4cava+PK8bVWQKlnAr2WYt2n7iNhlZscuUR47xz7FseTEB+XQ3JvIpTPHkavxy
         DU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=C1X9sW3v+fr5FlOBTRLr8OBCJWO5X+gthgg5KmJUoxk=;
        b=WqhZawz48rLW4RWNUYYXodd6VrV3+3w1Sv+vQl5KCRYI8ztJwGeESwqkzmRkFO9OYB
         qw/eLvdan8DVJxvchg8eJYQOoMM8Jf39l+AfdDpS9cDXm/eo7cPL0jJkVPIfM/DtlUQs
         ifZtdycFCf8B621QzxBwOyp1UkpevhbGifl6B8rFzRKXKN6kLDYtB2g+7dVd2hb/kfBs
         zP7yyaCJU9PyJyvEP+7C+iISYg2OEqPhlSixfHhRDKEDCb62uAeVeKznNdruD/jzDxx1
         V26ykYcOjSfqdVY52DUQZyD4P94iwTko+A6vpW/sOFp6VT/DIbwwxZMyQ6ZUmyCX5st3
         V+6A==
X-Gm-Message-State: ACrzQf1CpOebS7XsKoN/WzWbM5vwztpww+lfVp9ztXdDDnYEieR6q6ms
	WMdpZ15hwnCvpvk3lQVe7RYGSoTYfuM/Rt+1
X-Google-Smtp-Source: AMsMyM5217dRqiiABnhPNSfdGKa9oxb4a+2w6v3gA267Xw4+cUEYR4p7vHo/Zr38sKKuzngS4U/gKQ==
X-Received: by 2002:a05:6402:1353:b0:454:8f82:d1d2 with SMTP id y19-20020a056402135300b004548f82d1d2mr8567709edw.210.1663942135378;
        Fri, 23 Sep 2022 07:08:55 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:482e:b017:edec:7f18? ([2a02:578:8593:1200:482e:b017:edec:7f18])
        by smtp.gmail.com with ESMTPSA id n16-20020a1709062bd000b00730bfe6adc4sm4163703ejg.37.2022.09.23.07.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 07:08:26 -0700 (PDT)
Message-ID: <93789ec4-7998-6d69-b5c6-e3b88ae178bf@tessares.net>
Date: Fri, 23 Sep 2022 16:08:24 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH mptcp-next v2 0/4] mptcp: add support for TFO, sender side
 only
Content-Language: en-GB
To: Dmytro Shytyi <dmytro@shytyi.net>, benjamin.hesmans@tessares.net,
 mptcp@lists.linux.dev, pabeni@redhat.com
References: <20220921125558.19483-1-dmytro@shytyi.net>
 <709a843b-b7f7-438d-39c6-f139aaa55a10@shytyi.net>
 <3d37f47b-dd2e-fe80-caab-d1863028d7f1@tessares.net>
 <deea610c-8f09-fbbe-5bbe-7a8900a3b9cd@shytyi.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <deea610c-8f09-fbbe-5bbe-7a8900a3b9cd@shytyi.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/09/2022 15:41, Dmytro Shytyi wrote:
> Hello,
> 
> I am sharing experience from using the patch with environment that is
> provided to test the patch with selftest ( As i mentioned before).
> I take me some time to launch the patch. Hope this will help.

Probably best to check with packetdrill as usually recommended to
validate such modifications. The manual steps can lead to a wrong
environment.

> 
> On 9/23/2022 12:58 PM, Matthieu Baerts wrote:
>> Hi Dmytro,
>>
>> On 23/09/2022 01:23, Dmytro Shytyi wrote:
>>> Hello Benjamin, All,
>>>
>>> I excuse for the later if I made any mistake.
>>>
>>> My thought is comming from experience with the patch.
>>>
>>>
>>> Will huge respect, I think this patch _*MUST NOT*_ be accepted because
>>> of multiple reasons:
>>>
>>> 1. it violates the RFC 8684 [1] section B1:
>>>
>>> "When a TFO initiator first connects to a listener, it cannot
>>> immediately include data in the SYN for security reasons[RFC7413
>>> <https://www.rfc-editor.org/rfc/rfc8684.html#RFC7413>]. Instead, it
>>> requests a cookie that will be used in subsequent connections."
>>>
>>>
>>> Also I created environment[3] using commit[2], I tested v0, v2 and I do
>>> not see the mptcp capable option in SYN.
>>  From what I see in your setup, you set net.ipv4.tcp_fastopen:
>> - The sender has the 0x4 flag to send data in the opening SYN regardless
>> of cookie availability and without a cookie option.
>> - The receiver has the 0x200 flag to accept data-in-SYN w/o any cookie
>> option present
>>
>> See the link below for more details about the bitmap:
>>
>> https://www.kernel.org/doc/html/latest/networking/ip-sysctl.html
>>
>> If you change these values, I guess you will see the TFO cookie option.
>>
>> Please note that the proper way to validate exchanged packet is to use
>> Packetdrill. The following PR proves the implementation works with TFO
>> cookies:
>>
>> https://github.com/multipath-tcp/packetdrill/pull/87
> 
> Could you please verify this with wireshark before the acceptence?

Here is the output from Packetdrill:

> root@(none):/opt/packetdrill/gtests/net/mptcp# ../packetdrill/packetdrill -v ./fastopen/client-TCP_FASTOPEN_CONNECT.pkt
> socket syscall: 1663941238.170913
> fcntl syscall: 1663941238.171243
> setsockopt syscall: 1663941238.171551
> connect syscall: 1663941238.171964
> outbound sniffed packet:  0.001058 S 1708222581:1708222581(0) win 65535 <mss 1460,sackOK,TS val 1122428945 ecr 0,nop,wscale 8,FO,nop,nop,mp_capable v1 flags: |H| >
> inbound injected packet:  0.012799 S. 0:0(0) ack 1708222582 win 65535 <mss 1460,sackOK,TS val 700 ecr 1122428945,nop,wscale 8,FO abcd1234,nop,nop,mp_capable v1 flags: |H| sender_key: 2>
> outbound sniffed packet:  0.015375 . 1708222582:1708222582(0) ack 1 win 256 <nop,nop,TS val 1122428959 ecr 700,mp_capable v1 flags: |H| sender_key: 12211970130642946725 receiver_key: 2>
> close syscall: 1663941238.199617
> outbound sniffed packet:  0.028711 . 1708222582:1708222582(0) ack 1 win 256 <nop,nop,TS val 1122428959 ecr 700,dss dack4 3007449509 dsn8 17003222625898214342 ssn 0 dll 1 no_checksum flags: MmAF,nop,nop>
> inbound injected packet:  0.030712 . 1:1(0) ack 1708222582 win 450 <nop,nop,TS val 700 ecr 1122428959,dss dack4 764163015 dsn4 3007449509 ssn 0 dll 1 no_checksum flags: MAF,nop,nop>
> outbound sniffed packet:  0.032187 . 1708222582:1708222582(0) ack 1 win 256 <nop,nop,TS val 1122428976 ecr 700,dss dack4 3007449510 flags: A>
> outbound sniffed packet:  0.033824 R. 1708222582:1708222582(0) ack 1 win 256 <nop,nop,TS val 1122428978 ecr 700,mp_fastclose receiver key: 2,mp_reset 0>
> socket syscall: 1663941238.306640
> fcntl syscall: 1663941238.307030
> setsockopt syscall: 1663941238.307543
> connect syscall: 1663941238.308340
> write syscall: 1663941238.309088
> outbound sniffed packet:  0.138181 S 3843296367:3843296867(500) win 65535 <mss 1460,sackOK,TS val 1122429082 ecr 0,nop,wscale 8,FO abcd1234,nop,nop,mp_capable v1 flags: |H| >
> inbound injected packet:  0.151901 S. 0:0(0) ack 3843296868 win 65535 <mss 1460,sackOK,TS val 700 ecr 1122429082,nop,wscale 8,mp_capable v1 flags: |H| sender_key: 2>


And the output from tcpdump when doing the same test:

> root@(none):/opt/packetdrill/gtests/net/mptcp# ../packetdrill/packetdrill ./fastopen/client-TCP_FASTOPEN_CONNECT.pkt
> 13:53:44.586369 tun0  Out IP6 fe80::2ecf:46fa:841:cae > ff02::2: ICMP6, router solicitation, length 8
> 13:53:44.860976 tun0  Out IP 192.168.49.174.60676 > 192.0.2.1.8080: Flags [S], seq 2694673015, win 65535, options [mss 1460,sackOK,TS val 2036993134 ecr 0,nop,wscale 8,tfo  cookiereq,nop,nop,mptcp capable v1], length 0
> 13:53:44.871047 tun0  In  IP 192.0.2.1.8080 > 192.168.49.174.60676: Flags [S.], seq 0, ack 2694673016, win 65535, options [mss 1460,sackOK,TS val 700 ecr 2036993134,nop,wscale 8,tfo  cookie abcd1234,nop,nop,mptcp capable v1 {0x200000000000000}], length 0
> 13:53:44.871063 tun0  Out IP 192.168.49.174.60676 > 192.0.2.1.8080: Flags [.], ack 1, win 256, options [nop,nop,TS val 2036993144 ecr 700,mptcp capable v1 {0x3827b4480bfa870f,0x200000000000000}], length 0
> 13:53:44.881125 tun0  Out IP 192.168.49.174.60676 > 192.0.2.1.8080: Flags [.], ack 1, win 256, options [nop,nop,TS val 2036993144 ecr 700,mptcp dss fin ack 3007449509 seq 5431916111306864352 subseq 0 len 1,nop,nop], length 0
> 13:53:44.881210 tun0  In  IP 192.0.2.1.8080 > 192.168.49.174.60676: Flags [.], ack 1, win 450, options [nop,nop,TS val 700 ecr 2036993144,mptcp dss fin ack 2016065249 seq 3007449509 subseq 0 len 1,nop,nop], length 0
> 13:53:44.881226 tun0  Out IP 192.168.49.174.60676 > 192.0.2.1.8080: Flags [.], ack 1, win 256, options [nop,nop,TS val 2036993154 ecr 700,mptcp dss ack 3007449510], length 0
> 13:53:44.881260 tun0  Out IP 192.168.49.174.60676 > 192.0.2.1.8080: Flags [R.], seq 1, ack 1, win 256, options [nop,nop,TS val 2036993154 ecr 700,mptcp fast-close key 0x200000000000000,mptcp unknown], length 0
> 13:53:44.982454 ?     Out IP 192.168.49.174.60680 > 192.0.2.1.8080: Flags [S], seq 1531938899:1531939399, win 65535, options [mss 1460,sackOK,TS val 2036993255 ecr 0,nop,wscale 8,tfo  cookie abcd1234,nop,nop,mptcp capable v1], length 500: HTTP
> 13:53:44.992484 ?     In  IP 192.0.2.1.8080 > 192.168.49.174.60680: Flags [S.], seq 0, ack 1531939400, win 65535, options [mss 1460,sackOK,TS val 700 ecr 2036993255,nop,wscale 8,mptcp capable v1 {0x200000000000000}], length 0
> 13:53:44.992494 ?     Out IP 192.168.49.174.60680 > 192.0.2.1.8080: Flags [.], ack 1, win 256, options [nop,nop,TS val 2036993265 ecr 700,mptcp capable v1 {0x75382dfb6dafc693,0x200000000000000}], length 0
> 13:53:44.992539 ?     Out IP 192.168.49.174.60680 > 192.0.2.1.8080: Flags [.], ack 1, win 256, options [nop,nop,TS val 2036993265 ecr 700,mptcp dss fin ack 3007449509 seq 6967145468519815204 subseq 0 len 1,nop,nop], length 0

We can see:

- in the first SYN:
  - "tfo cookiereq"
  - "mptcp capable v1"
  - "length 0"

- in the second SYN:
  - "tfo  cookie abcd1234"
  - "mptcp capable v1"
  - "length 500"

Everything seems then OK.

>>> 3. Patch uses an original Idea of another autor from mailing list (Reuse
>>> the TCP FASTOPEN option in MPTCP).
>> A v3 mentioning you is going to be sent as discussed at the last meeting.
>>
>> We should indeed mention the authors of the original idea to have TFO in
>> MPTCP:
>>
>> https://datatracker.ietf.org/doc/draft-barre-mptcp-tfo/
>>
>> Cheers,
>> Matt
> 
> It seems this draft didn't get the consensus and was not accepted by
> IETF as RFC.


This link is just to point to the original idea of having TFO supported
with MPTCP. This document was used as a base for the evolution of the
MPTCPv0 (RFC6824) and it was the main reason why we have an MPTCPv1
(RFC8684) where the MP_CAPABLE is different from the v0 to allow TFO
cookie options in the initial SYN. So yes, it was somehow accepted by
the IETF but as part of RFC8684.

> How the abstract RFC related to the original idea to reuse
> TFO option from regular TCP in linux kernel implementation?
Sorry, what do you mean here?
Implementing TFO in MPTCP Linux Upstream is part of the roadmap from the
beginning, see ticket 59 on Github.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
