Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F7D2574B
	for <mptcp@lists.linux.dev>; Tue,  8 Oct 2024 08:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728376834; cv=none; b=MJovBAr4zJBs3K81q+E8IcSdGcntDDIUA5doEQjrHOBq6nJ0KDDFIiggCfrfvfRYCqKxuJDosO7GbKt+yzKvnDxYZFMjdcKZlLGZRSxsaiDXcYrSbRFT9VIbSxs9RaUpR1Vjc78lflcbBh5LHGcAv6KAQQGRCGwv7MdHlvPeSWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728376834; c=relaxed/simple;
	bh=4awbZXVSTW5CLuAreB2OKTgE3EZ3Uq9Or8JOB+MVy3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ns66ixq0cqy7EFbRyCWe4Ljf/Ocs38kfLXAgmogn3Z9TxvGVMRT7VoKS46UIqs9m02Z4PasRAQef7YKqsAbfFdVt6HhD5+/1hwisz9Tnwi14TwMTXBPRj6bRtjDON+/vXRpiGkrhiYYKLmyfS6RvhcwbOpII7+0FH0Avr8r0UGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWxN1pxe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWxN1pxe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA269C4CECF;
	Tue,  8 Oct 2024 08:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728376834;
	bh=4awbZXVSTW5CLuAreB2OKTgE3EZ3Uq9Or8JOB+MVy3A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BWxN1pxehjKIZpCdHrKLga3qITgyfivioar5jcbhPlKqCe8GG9gh1J2kcFyeibKlf
	 djgyhzeyyCSf3IEOU1YgJ7BGhyMBUGBZ5cB2sp1NL3haHJTc5+DCK13YHiYQCw4JK4
	 15qjxx4bnjdiSXTu3gXbZHFJp4ep2VLde1+i/SNhZb5Qd7M4ezjqGLlpSMF1ZW61Pn
	 5mvLel7qVaQ5IQjEMoaVla/v7sxLCP1FG/8InkwlDaDU7gtOudohiK5gk4o4aO6df7
	 1X3GPg04qxVrfkEjprvf1cRXhegC0N5esyEi+50gVA/jDv3aSQ44xxZD/BVQEFvZF2
	 FtlkuUkXMQ0wA==
Message-ID: <e7782910-1807-4405-b77c-c6f392b51f46@kernel.org>
Date: Tue, 8 Oct 2024 10:40:29 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] mptcp: fallback if MPTCP opts are dropped after
 1st data
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>, Davide Caratti <dcaratti@redhat.com>
References: <20241003-mptcp-gh-518-v1-1-e79e1f6434ad@kernel.org>
 <76f527b4-4a80-44cd-925c-9de397562345@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <76f527b4-4a80-44cd-925c-9de397562345@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

On 08/10/2024 08:55, Paolo Abeni wrote:
> On 10/3/24 20:43, Matthieu Baerts (NGI0) wrote:
>> As reported by Christoph [1], before this patch, an MPTCP connection was
>> wrongly reset when a host received a first data packet with MPTCP
>> options after the 3wHS, but got the next ones without.
>>
>> According to the MPTCP v1 specs [2], a fallback should happen in this
>> case, because the host didn't receive a DATA_ACK from the other peer,
>> nor receive data for more than the initial window which implies a
>> DATA_ACK being received by the other peer.
>>
>> The patch here re-uses the same logic as the one used in other places:
>> by looking at allow_infinite_fallback, which is disabled at the creation
>> of an additional subflow. It's not looking at the first DATA_ACK (or
>> implying one received from the other side) as suggested by the RFC, but
>> it is in continuation with what was already done, which is safer, and it
>> fixes the reported issue. The next step, looking at this first DATA_ACK,
>> is tracked in [4].
>>
>> This patch has been validated using the following Packetdrill script:
>>
>>     0 socket(..., SOCK_STREAM, IPPROTO_MPTCP) = 3
>>    +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
>>    +0 bind(3, ..., ...) = 0
>>    +0 listen(3, 1) = 0
>>
>>    // 3WHS is OK
>>    +0.0 < S  0:0(0)       win 65535  <mss 1460, sackOK, nop, nop, nop,
>> wscale 6, mpcapable v1 flags[flag_h] nokey>
>>    +0.0 > S. 0:0(0) ack 1            <mss 1460, nop, nop, sackOK, nop,
>> wscale 8, mpcapable v1 flags[flag_h] key[skey]>
>>    +0.1 <  . 1:1(0) ack 1 win
>> 2048                                              <mpcapable v1
>> flags[flag_h] key[ckey=2, skey]>
>>    +0 accept(3, ..., ...) = 4
>>
>>    // Data from the client with valid MPTCP options (no DATA_ACK: normal)
>>    +0.1 < P. 1:501(500) ack 1 win 2048 <mpcapable v1 flags[flag_h]
>> key[skey, ckey] mpcdatalen 500, nop, nop>
>>    // From here, the MPTCP options will be dropped by a middlebox
>>    +0.0 >  . 1:1(0)     ack 501        <dss dack8=501 dll=0 nocs>
>>
>>    +0.1 read(4, ..., 500) = 500
>>    +0   write(4, ..., 100) = 100
>>
>>    // The server replies with data, still thinking MPTCP is being used
>>    +0.0 > P. 1:101(100)   ack 501          <dss dack8=501 dsn8=1 ssn=1
>> dll=100 nocs, nop, nop>
>>    // But the client already did a fallback to TCP, because the two
>> previous packets have been received without MPTCP options
>>    +0.1 <  . 501:501(0)   ack 101 win 2048
>>
>>    +0.0 < P. 501:601(100) ack 101 win 2048
>>    // The server should fallback to TCP, not reset: it didn't get a
>> DATA_ACK, nor data for more than the initial window
>>    +0.0 >  . 101:101(0)   ack 601
>>
>> Note that this script requires Packetdrill with MPTCP support, see [3].
>>
>> Fixes: dea2b1ea9c70 ("mptcp: do not reset MP_CAPABLE subflow on
>> mapping errors")
>> Reported-by: Christoph Paasch <cpaasch@apple.com>
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/518 [1]
>> Link: https://datatracker.ietf.org/doc/html/rfc8684#name-fallback [2]
>> Link: https://github.com/multipath-tcp/packetdrill [3]
>> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/519 [4]
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Cc: Davide Caratti <dcaratti@redhat.com>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> ---
>>   net/mptcp/subflow.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index
>> a1e28e1d8b4e39e14bc8f98164013d302d62595c..61482f8b425b5dde17a4f3272d04973ae5ec7849 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -1282,7 +1282,7 @@ static bool subflow_can_fallback(struct
>> mptcp_subflow_context *subflow)
>>       else if (READ_ONCE(msk->csum_enabled))
>>           return !subflow->valid_csum_seen;
>>       else
>> -        return !READ_ONCE(subflow->fully_established);
>> +        return READ_ONCE(msk->allow_infinite_fallback);
>>   }
>>     static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock
>> *ssk)
> 
> Reviewd-by: Paolo Abeni <pabeni@redhat.com>

Thank you for the review!

> Note that when checksum is enabled the condition in use is much more
> restrictive. That should be ok in practice, as hopefully no-one uses
> csum ;)

Good point! Probably something to improve there.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

