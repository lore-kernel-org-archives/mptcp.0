Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795805833;
	b=fZK3uuPNamm1VgKj8gayJgDKPTaA8zov4TYasckBKUGThY3YrN/kOF5Ne0GCJkXXPdL1
	 Z1CFS0D3pIoNaGd0hgSt3OJ2nnCsKdrEI1aWFZ9eMNnSyC1/RnSTdLMkNtsWx+BbECI3d
	 bXT6/+GXkcEW0ap6iDGwwMfe/oslNCDTZjCeMvoT02g1Tcpcq2/k+f45YGSv29pLg8S6y
	 +TpPDNJlZfKNDc77sc/uJtqasID2sTiExXvxBC0AwX/fAQ6geh4eZL3EdJobW3QZt4amA
	 o6gEUqaEBlzOZnNdtI1MVpxC1lXHXJccbwuRBrKkbB1lFNGBECcdgD/OG+pt+I7XZHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795805833;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:References:From:Cc:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=AIOZ86c7k+hDxdA611wbge9BSJgYPfv5sIosQNz6StQ=;
	b=Wf8ZF+d6dr/DOQJIk1RA8rCYhsbRXLL3WcPdDpFxNKPSRxZxcxcFAtI/RfK4bzHpBsn1
	 gYbhlVgiI8hzOo+BP8xGplB+3WqjbMa6deGT1bmSj4CulYnmPDyKwVi1bP5sM6QOv7P+4
	 su/TxldogUS6Yrj7iZA+e5ivw+XhXb+UCswai2SdGUez64ZstDYXhV3XbfFtV24kHpR7r
	 AileW1ReCT5EXJaVwq/An0MxBtvoKbdaJeQ4eGhiQnoAG7r5AA3SWcP69uexo0p4kXDMb
	 C0oqS1hBxs5X5OkQ4cROPBul4ldnriJf9UiKyQFPFWSBW6LQlYbBm4E4gd6cwma2YOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OeCTbn3W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE34A606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 18:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OeCTbn3W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6B21F00897;
	Fri, 27 Nov 2026 18:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795805833;
	bh=AIOZ86c7k+hDxdA611wbge9BSJgYPfv5sIosQNz6StQ=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To;
	b=OeCTbn3W77MugqYS2qdxQMiul0rh43YxBduw30J2QcV9xa5AoXA7lOjxpXtvistZ+
	 abMUlNn4bYej8kW5G+12cPWqw1k7EqwzoYM/9sPu1lj+0ZkpA/gO4JxXoLeSiKnvfg
	 oWqKSnKMRMgVZ3hDoplUI/1k1hcsRsZxmaWdGMpXb9PRJ2PDBv79X38HJzFC5uYvUy
	 ffv7Bp2AJlW7+JhDQQsm+MAdLjZHy6K4YIgEu5W4Hr14EPrsaEjqVknhWIK0Uab49g
	 VQBU+u6i/EZs8fqwOD3NVEnJTEps+eT7o7FU5Q/RYs0LUxlo+1v02NUiQJPwRH03FO
	 fsc2krQDAZiuw==
Message-ID: <b2603ef7-0095-45c3-8c42-01d64d62bcbd@kernel.org>
Date: Fri, 27 Nov 2026 19:57:10 +0100
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
Subject: Re: [PATCH mptcp-net v3 11/50] mptcp: no sf left: process pending
 MP_FASTCLOSE
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
 <20261124-mptcp-cmason-fixes-v3-11-416c0920c73f@kernel.org>
 <6f9057868b35286ebf0e487787b5b0e15f1582c6.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <6f9057868b35286ebf0e487787b5b0e15f1582c6.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for the review!

On 27/11/2026 02:12, Geliang Tang wrote:
> Hi Matt,
> 
> On Tue, 2026-11-24 at 22:59 +0100, Matthieu Baerts (NGI0) wrote:
>> When the last subflow is closed while the MPTCP socket is no longer in
>> the ESTABLISHED state, e.g. in CLOSE_WAIT after a DATA_FIN, the MPTCP
>> socket moves to TCP_CLOSE. But this subflow could have been closed by a
>> reset carrying an MP_FASTCLOSE, not processed yet: if this reset is
>> received while the worker is running, after mptcp_check_fastclose(), and
>> before __mptcp_close_subflow(). At the next run of the worker, the MPTCP
>> socket being closed, the MP_FASTCLOSE is ignored, and no error is
>> reported.
>>
>> This issue has been observed with the "fastclose test" subtest from
>> mptcp_join.sh: after the DATA_FIN from the client, then its
>> MP_FASTCLOSE, the server, still having data to send, was killed after
>> the timeout:
>>
>>   [FAIL] client exit code 0, server 143
>>
>> Since commit "mptcp: wake up blocked senders when no sf left", this
>> subtest no longer fails: SEND_SHUTDOWN is set in this case, and the
>> server gets EPIPE when writing, which is expected there. But the reset
>> is still not reported. This has been confirmed with a debug patch
>> keeping the worker busy until the subflow is closed, and Packetdrill
>> scripts sending an MP_FASTCLOSE in this window: in CLOSE_WAIT, SO_ERROR
>> was 0 instead of EPIPE, and poll() did not report EPOLLERR; in
>> FIN_WAIT2, read() returned ENOTCONN instead of ECONNRESET:
>>
>>   fastclose_close_wait_race_err.pkt:26: runtime error in getsockopt call: Bad getsockopt optval: expected: 32 actual: 0
>>   fastclose_fin_wait2_race_read.pkt:28: runtime error in read call: Expected errno 104 (Connection reset by peer) but got 107 (Transport endpoint is not connected)
>>
>> To fix this, process a pending MP_FASTCLOSE before the close, if the
>> socket is still in use.
>>
>> Fixes: 27e5ccc2d5a5 ("mptcp: fix dangling connection hang-up")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> v2: new, for an issue causing a flaky selftest
>> v3: msg: the subtest no longer fails since patch 7, and the remaining
>>     issue, checked with Packetdrill (Clashiko)
>> ---
>>  net/mptcp/protocol.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 5d916c6b43f4..bcdad00d3573 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -2705,6 +2705,8 @@ static void mptcp_cleanup_ssk_backlog(struct sock *sk, struct sock *ssk)
>>  	mptcp_data_unlock(sk);
>>  }
>>  
>> +static void mptcp_check_fastclose(struct mptcp_sock *msk);
>> +
> 
> Would it be more appropriate to move the definition of mptcp_check_rcv_close()
> helper from patch 12 into this patch?

It's a good idea, but I prefer not to do that for net and keep the patch
as small as possible. The patch 11/50 can be backported up to v5.10:
better to keep it small. While the next one is for v6.19 (so only
backported to v7.3).

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

