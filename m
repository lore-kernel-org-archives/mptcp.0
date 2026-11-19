Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795113209;
	b=K4q7wbk+aKfbfVXjLzRJBhz1H4u6IM4RgeR+VPPw9Ucddt/v0aazU5OegjkcQQQCyWUQ
	 57rBreiINmQtit1LO4R97wr2Vh2oEZwWDpeLZoGe4hXNptkDGeryGiOBjqFEGNdjgjKvY
	 gwlCudhcXHK5idE8U6nud+lgI8Cm3p13gcmlHoKRlYL9RyF6rgXfToZD6hxm5eJRPfw6S
	 d8Nt2SivLXGUbnGX5GsNGqy7mqK5/autwp4PqX46WqSRZIhVLTt2PDpZNk8LR4Ndg8oMt
	 Eocsj8i4G1HToiR4m+11VgaO80EE9EN+dAuRa6obE8WKg+T2Riknk7Y1FsmGamIEphA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795113209;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=cW1Gp/SLXYhxx5A9Q5dr7GIRM3j5LjmrWw0BlEu5f0M=;
	b=ygigcAZcL6aF8wRoiTmJfrM4yKjctM/a0FLmSKEYQ55ltNawG2zW+1gJoJTvFeQdQI/2
	 m8aGwe+15QtGSWas8l2XnNAHpHf7QYT+onxPlBh0JNhQpHSqpDaeG7dtIn5/3Fk/Hjo0p
	 dCvns3D+31t5jwhDHu3SeGSWYQH8XNBjBmm2FLlm27OmryTXlC21TwzC8pbJFT4WpoKKv
	 LPP8SZSo2udppk1sHryXFxHbiIHEEYG6kr43UHIRhOWWgIZGnDU8fltUfCewzwkyD4rTT
	 fq71wotNaKh2QaJgP01z5qlokMvfrZmaWCftc6AmFnw+TL3N3HvEodbzDR8p2RRDH8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LftXorVd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C36F606A324;
	Thu, 19 Nov 2026 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LftXorVd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C08C1F000C7;
	Thu, 19 Nov 2026 18:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795113208;
	bh=cW1Gp/SLXYhxx5A9Q5dr7GIRM3j5LjmrWw0BlEu5f0M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LftXorVdYWkIH/eKEEiACZdlDi2wHbqiibu28g6YGHfvZtuH+Yr3N6hOUSovVKTwv
	 mziTPULqd4/+RbUap3VPHM661ho0Ttdz0nxZZ8N9ZDwBpQ2uq0V8+PfXTrFSMuXajj
	 pXuP2GtQO6zhyRYzbgpgpJPUrdEFnYSFfl3gDdAz5+siFiDn8Gj5pRdRcM55jc0w/1
	 wMSXH6NqCwoF9vTnCceN4Pa0FtOoTviSnHGYs1jGzhem1zhnlNGiB6wYM315U3QsYW
	 4k5fOUjyOBMtpWx/V1WxnQ8qVg4iyumUE+R9mYHttnCGnGrHZruHR8fkOhWpe9j5Bi
	 2JdA39KfX1kYA==
Message-ID: <cab39a1c-056f-488f-b217-194af2056db2@kernel.org>
Date: Thu, 19 Nov 2026 19:33:23 +0100
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net 3/3] mptcp: exclude MSG_PEEK from receive buffer
 autotuning
Content-Language: fr
To: Eric Dumazet <edumazet@kernel.org>
Cc: lei lei <llleigoing@outlook.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>,
 "ncardwell@google.com" <ncardwell@google.com>,
 "kuniyu@google.com" <kuniyu@google.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
 "martineau@kernel.org" <martineau@kernel.org>,
 "geliang@kernel.org" <geliang@kernel.org>
References: <20261117052200.1507847-1-llleigoing@outlook.com>
 <20261117052200.1507847-4-llleigoing@outlook.com>
 <CAL4WiioFmJXhfGSY7rs7aR3FA_xC_f0sjuArBo7CBjV_tXTbTw@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CAL4WiioFmJXhfGSY7rs7aR3FA_xC_f0sjuArBo7CBjV_tXTbTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Eric, Lei,

Thank you for the patch, and for the review!

On 19/11/2026 08:59, Eric Dumazet wrote:
> Le mar. 17 nov. 2026 à 06:22, lei lei <llleigoing@outlook.com> a écrit :
>>
>> __mptcp_recvmsg_mskq() passes bytes copied by MSG_PEEK to
>> mptcp_rcv_space_adjust(), although those bytes remain in the receive
>> queue. Repeated peeks count the same data as new application
>> consumption and can inflate the receive-memory budget. Subtracting the
>> unread queue at a measurement boundary cannot undo that repeated count.
>>
>> The receive path originally skipped this adjustment for MSG_PEEK.
>> Commit 581302298524 ("mptcp: error out earlier on disconnect") moved
>> the adjustment calls without preserving that check.
>>
>> Only adjust receive space for non-peeking reads. Keep the returned
>> byte count unchanged.
> 
> This one looks good to me.
> 
> mptcp_rcv_space_adjust() accumulates @copied in msk->rcvq_space.copied,
> and mptcp_inq_hint() is subtracted once per measurement, so N peeks
> of the same bytes are indeed counted N times.
> 
> (TCP also calls tcp_rcv_space_adjust() for MSG_PEEK, but it uses
> tp->copied_seq, which is not changed by a peek, so it has no such
> issue.)
> 
> The Fixes: tag is correct, commit 581302298524 removed the
> "if (!(flags & MSG_PEEK))" test.

It looks good to me too, please send a v2 with the Signed-off-by:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

>> A loopback test leaves a fixed 32 KiB queue unread and peeks 4096 times.
>> Before this change, sk_rcvbuf grows to the configured 8 MiB limit.
>> Afterwards, both the budget and the queue remain unchanged, and a
>> subsequent consuming read returns the original data intact.
> 
> It would be nice to have this test in
> tools/testing/selftests/net/mptcp/ (or as a packetdrill test),
> MPTCP maintainers can tell you what they prefer.

Good idea! We prefer a packetdrill test here, using the MPTCP fork [1]:
such tests are usually shorter and easier to read than a new selftest,
and our CI
runs them.

@Lei: could you open a PR on this separate repository with a new test,
please? For example in gtests/net/mptcp/syscalls/recv_peek_rcvbuf.pkt,
next to recv_peek_waitall.pkt. Feel free to use the following script if
it works on your side. You can test it with:

  ./packetdrill/run_all.py -lv mptcp/syscalls/recv_peek_rcvbuf.pkt


------------------------- 8< -------------------------
  // MSG_PEEK must not be counted as consumed data by the rcvbuf autotuning
  --tolerance_usecs=100000
  `../common/defaults.sh`

  // Small initial rcvbuf: without the fix, a few peeks are enough to grow it
  +0.0  `sysctl -q net.ipv4.tcp_rmem="4096 8192 15728640"`

  +0.0  socket(..., SOCK_STREAM, IPPROTO_MPTCP) = 3
  +0.0  setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
  +0.0  bind(3, ..., ...) = 0
  +0.0  listen(3, 1) = 0

  // With TS, the first data gives an RTT sample (~100ms), needed by autotuning
  +0.0    <  S   0:0(0)                win 65535  <mss 1460, sackOK, TS val 100 ecr 0,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
  +0.0    >  S.  0:0(0)        ack 1              <mss 1460, sackOK, TS val 700 ecr 100, nop, wscale 8, mpcapable v1 flags[flag_h] key[skey]>
  +0.1    <   .  1:1(0)        ack 1     win 256  <nop, nop,         TS val 200 ecr 700,                mpcapable v1 flags[flag_h] key[ckey=2, skey]>
  +0.0  accept(3, ..., ...) = 4

  +0.0    <  P.  1:1001(1000)  ack 1     win 256  <nop, nop,         TS val 300 ecr 700,                mpcapable v1 flags[flag_h] key[skey, ckey] mpcdatalen 1000, nop, nop>
  +0.0    >   .  1:1(0)        ack 1001           <nop, nop,         TS val 700 ecr 300,                dss dack8=1001 dll=0 nocs>

  // Peek the same data multiple times within one RTT...
  +0.0  recv(4, ..., 1000, MSG_PEEK) = 1000
  +0.0  recv(4, ..., 1000, MSG_PEEK) = 1000
  +0.0  recv(4, ..., 1000, MSG_PEEK) = 1000
  +0.0  recv(4, ..., 1000, MSG_PEEK) = 1000
  +0.0  recv(4, ..., 1000, MSG_PEEK) = 1000

  // ... then once more after one RTT: nothing consumed, the rcvbuf is unchanged
  +0.2  recv(4, ..., 1000, MSG_PEEK) = 1000
  +0.0  getsockopt(4, SOL_SOCKET, SO_RCVBUF, [8192], [4]) = 0

------------------------- 8< -------------------------

[1] https://github.com/multipath-tcp/packetdrill

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

