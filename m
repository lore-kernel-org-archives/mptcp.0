Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615212CA0
	for <mptcp@lists.linux.dev>; Mon, 17 Jan 2022 21:48:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1642456129; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Z1Vvp4bSA4OiKq2DvamBFox8mZzaUn6UbXP+bkZm0s4lI+r5UEcfh1TlmznFBqB/RySItrZDbxkaqL5dqnLjAByycPt4Ap6qKLD4tFLZluq+SU1ehviAyB0uBUKY78EUnyTrUc0BV9NjMvrH1o6BqbvddyMmuVtxOQZSAESJOhQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1642456129; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=a1iUOofYzovVX6fi5qXsIbXRvrkbHdcgxKy4+8AcoyQ=; 
	b=AsV7qnHSKB3WdaRUgD3/wGRIZJb6/zNKC5vlVRg5SE5tp44kffee+wPfIXrT2x4Z+/Mf3HFWpZJ66F6AhzYtOZtfpJx0PzObsXzVOhOW019G7qphveUH2A04Z8uLAT+57a9k67CJ8vrzcAfH6mUmQgNsvp9vtoTz0QN/5cUyRqw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1642456129;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=a1iUOofYzovVX6fi5qXsIbXRvrkbHdcgxKy4+8AcoyQ=;
	b=DhU3SFbVt1aBhL79RQlfdEi5ZHdUWdR+fVQPm60hEGRdePwmGOMMXBIPbldYiNto
	JzgnmDTxuon24uzVo7DAX/BfjgjPlBlhclrtwp4qjL0dyCau06inCZauJhCJBaKOfc9
	e3Jh75sSjIYKH7rNZzK0xKSyX/EQCylPWGvV7UOQ=
Received: from [192.168.100.116] (vps-f3afed4e.vps.ovh.net [198.244.151.99]) by mx.zoho.eu
	with SMTPS id 1642456127691844.6426740299876; Mon, 17 Jan 2022 22:48:47 +0100 (CET)
Subject: Re: [PATCH net-next v2] net: mptcp, Fast Open Mechanism
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20220116001259.203319-1-dmytro@shytyi.net>
 <449d3338d759e9f72f33e7c37e1b9956bdda77f4.camel@redhat.com>
 <9f700f12472bddc0d9d899773d2a211bfe8517f6.camel@redhat.com>
From: Dmytro SHYTYI <dmytro@shytyi.net>
Message-ID: <7d5bdd13-e565-87fd-2854-7f95487d1157@shytyi.net>
Date: Mon, 17 Jan 2022 21:48:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <9f700f12472bddc0d9d899773d2a211bfe8517f6.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi Paolo,

AFAIK, TFO option requires more that 8 bytes, if cookie len is 8 bytes:

In file /net/ipv4/tcp_output.c (line 689):

static void tcp_options_write(__be32 *ptr, struct tcp_sock *tp,
                               struct tcp_out_options *opts)
....
{
         if (unlikely(OPTION_FAST_OPEN_COOKIE & options)) {
                 struct tcp_fastopen_cookie *foc = opts->fastopen_cookie;
                 u8 *p = (u8 *)ptr;
                 u32 len; /* Fast Open option length */

                 if (foc->exp) {
                         len = TCPOLEN_EXP_FASTOPEN_BASE + foc->len;
                         *ptr = htonl((TCPOPT_EXP << 24) | (len << 16) |
                                      TCPOPT_FASTOPEN_MAGIC);
                         p += TCPOLEN_EXP_FASTOPEN_BASE;
                 } else {
                         len = TCPOLEN_FASTOPEN_BASE + foc->len;
                         *p++ = TCPOPT_FASTOPEN;
                         *p++ = len;
                 }

                 memcpy(p, foc->val, foc->len);
                 if ((len & 3) == 2) {
                         p[foc->len] = TCPOPT_NOP;
                         p[foc->len + 1] = TCPOPT_NOP;
                 }
                 ptr += (len + 3) >> 2;
         }
...

Here we do have  "len = TCPOLEN_FASTOPEN_BASE + foc->len" that is 
slightly more than 8 bytes.

This is the cause of introducing 4 byte cookie for MPTCP implementation.

The RFC 8684 B.1. says:
   This is done with the TCP cookie request/response
    options, of 2 bytes and 6-18 bytes, respectively (depending on the
    chosen cookie length).

So in my understanding, the "selected cookie size + 
TCPOLEN_FASTOPEN_BASE" = 6, is not prohibited by, and in the allowed 
range of the RFC 8684.

As you suggested I will document the size of the cookie, if there is no 
objections to above information :)

Dmytro.

On 17/01/2022 10:03, Paolo Abeni wrote:
> On Mon, 2022-01-17 at 10:58 +0100, Paolo Abeni wrote:
>>> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
>>> index 48d8a363319e..d7092234d442 100644
>>> --- a/include/linux/tcp.h
>>> +++ b/include/linux/tcp.h
>>> @@ -54,7 +54,14 @@ static inline unsigned int tcp_optlen(const struct sk_buff *skb)
>>>   /* TCP Fast Open */
>>>   #define TCP_FASTOPEN_COOKIE_MIN	4	/* Min Fast Open Cookie size in bytes */
>>>   #define TCP_FASTOPEN_COOKIE_MAX	16	/* Max Fast Open Cookie size in bytes */
>>> +
>>> +#if IS_ENABLED(CONFIG_MPTCP)
>>> +#define TCP_FASTOPEN_COOKIE_SIZE 4	/* the size employed by MPTCP impl. */
>>> +#else
>>>   #define TCP_FASTOPEN_COOKIE_SIZE 8	/* the size employed by this impl. */
>>> +#endif
>>
>> You really need to document this kind of changes in the code, possibly
>> referring to the RFC bits requiring it.
> Note that MPC + syn currently uses 24 bytes of TCP option spaces, and
> MPC + syn + ack is using 32 bytes, to there is enough room for 8 bytes
> cookies.
> 
> /P
> 
