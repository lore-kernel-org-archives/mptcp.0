Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1672C80
	for <mptcp@lists.linux.dev>; Wed, 19 Jan 2022 17:35:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1642613725; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=KQuFLNn8d5bIPK5fuLFB26Z9SglmFHYm4grZpn7B1Dj2NI4xRVcrLEQNo9q2dBp13CHlJM1Xcc+4bvn7et/6bkMSRaJg0WgUGM+h/K4A2K28uA2EyFco2H8nyqwsTX+/VSLSLZswBpnVD9j4FtyUWoOaWVZ+a2+4zO8cK2gja+8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1642613725; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=Ee9CPRq9O3EfPCxbjHiVFeaes64oDDc3Ydy/H75SpNo=; 
	b=FPnLSkRonX1f2Nm78G58ocIgOjkMGs+cg1jqFC4VdbbeixCdv/SGYAr6StW1pzhYcG3xMXCqy+N3EuwkMlcmHkbSP/lc00Mrro1SFtmrlu4GfedWIHepDSklIGVeneSYjfOcsUfocVUKufL/NHi6FmW/cYJG6Vi+XsZbcTQdI8Y=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1642613725;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Ee9CPRq9O3EfPCxbjHiVFeaes64oDDc3Ydy/H75SpNo=;
	b=AEU4y3BIRkS7CZNoxkhF25T2pj/n1qRV9tqixi87H6wa39g85MfxlLhN7pk44CHX
	UqmpiLTtLj8B9IB3hwq2gayoT9lsPylxwVuzZJGhp0MKQSgoyjvPdA93PcgRsP/fVVv
	7l9Z56/GZ6mEZqtMCpws3l149GmCJJ4w0uS6z9Yk=
Received: from [192.168.100.116] (vps-f3afed4e.vps.ovh.net [198.244.151.99]) by mx.zoho.eu
	with SMTPS id 1642613723034569.379953308687; Wed, 19 Jan 2022 18:35:23 +0100 (CET)
Subject: Re: [PATCH net-next v2] net: mptcp, Fast Open Mechanism
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20220116001259.203319-1-dmytro@shytyi.net>
 <449d3338d759e9f72f33e7c37e1b9956bdda77f4.camel@redhat.com>
 <9f700f12472bddc0d9d899773d2a211bfe8517f6.camel@redhat.com>
 <7d5bdd13-e565-87fd-2854-7f95487d1157@shytyi.net>
 <3f1ec9d12c7903988639689f3a7568a97ce83ef0.camel@redhat.com>
From: Dmytro SHYTYI <dmytro@shytyi.net>
Message-ID: <27a82812-5502-73ba-8d1d-1cff7a86e207@shytyi.net>
Date: Wed, 19 Jan 2022 17:35:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <3f1ec9d12c7903988639689f3a7568a97ce83ef0.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hello Paolo,

On 18/01/2022 11:02, Paolo Abeni wrote:
> On Mon, 2022-01-17 at 21:48 +0000, Dmytro SHYTYI wrote:
>> Hi Paolo,
>>
>> AFAIK, TFO option requires more that 8 bytes, if cookie len is 8 bytes:
>>
>> In file /net/ipv4/tcp_output.c (line 689):
>>
>> static void tcp_options_write(__be32 *ptr, struct tcp_sock *tp,
>>                                 struct tcp_out_options *opts)
>> ....
>> {
>>           if (unlikely(OPTION_FAST_OPEN_COOKIE & options)) {
>>                   struct tcp_fastopen_cookie *foc = opts->fastopen_cookie;
>>                   u8 *p = (u8 *)ptr;
>>                   u32 len; /* Fast Open option length */
>>
>>                   if (foc->exp) {
>>                           len = TCPOLEN_EXP_FASTOPEN_BASE + foc->len;
>>                           *ptr = htonl((TCPOPT_EXP << 24) | (len << 16) |
>>                                        TCPOPT_FASTOPEN_MAGIC);
>>                           p += TCPOLEN_EXP_FASTOPEN_BASE;
>>                   } else {
>>                           len = TCPOLEN_FASTOPEN_BASE + foc->len;
>>                           *p++ = TCPOPT_FASTOPEN;
>>                           *p++ = len;
>>                   }
>>
>>                   memcpy(p, foc->val, foc->len);
>>                   if ((len & 3) == 2) {
>>                           p[foc->len] = TCPOPT_NOP;
>>                           p[foc->len + 1] = TCPOPT_NOP;
>>                   }
>>                   ptr += (len + 3) >> 2;
>>           }
>> ...
>>
>> Here we do have  "len = TCPOLEN_FASTOPEN_BASE + foc->len" that is
>> slightly more than 8 bytes.
>>
>> This is the cause of introducing 4 byte cookie for MPTCP implementation.
>>
>> The RFC 8684 B.1. says:
>>     This is done with the TCP cookie request/response
>>      options, of 2 bytes and 6-18 bytes, respectively (depending on the
>>      chosen cookie length).
>>
>> So in my understanding, the "selected cookie size +
>> TCPOLEN_FASTOPEN_BASE" = 6, is not prohibited by, and in the allowed
>> range of the RFC 8684.
> 
> You are right, I underlooked the TFO option writing.
> 
>> As you suggested I will document the size of the cookie, if there is no
>> objections to above information :)
> 
> Shrinking the TFO cookie size has both security and functional impact:
> 
> - we do not want to change the TFO cookie size for TCP connection in
> MPTCP enabled build.
> - dynamically selecting the TFO cookie size depending on the specific
> rsk type will add more complexity to the TCP code.

I agree with functional and future security impact in case if we reduce 
the cookie size.

> rfc8684 suggests we could remove the TS option from the synack packet.
> I think it's worthy to try such idea.
> 
> To do that, we need to change the 'mptcp_synack_options()' hook
> signature, to accept a 'struct tcp_out_options' as the 3rd argument, so
> that mptcp_synack_options() can clear the TCPOLEN_TSTAMP_ALIGNED bit
> when needed.

With this we can try to keep "cookie len == 8". It will simplify things. 
I will look into it.

> Thanks
> 
> Paolo
> 

Thanks,
Dmytro.
