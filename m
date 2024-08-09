Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781521DFF5
	for <mptcp@lists.linux.dev>; Fri,  9 Aug 2024 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723206363; cv=none; b=FY011bDobJYI5lCC0NadnsyX+OZHEz5nqKy0LZdl1Dxbvl4GcpRxxf8Q5le0n9wJnJ2Zl51lcyCpGAxkyEMhxFEWc61X+9f5VOJkAjQuhcnAwFEA3qWqylLQH3A+nVFsqd7GP00Pnk/94LNpcA6gffANfkni5KNECNvqGa7iFvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723206363; c=relaxed/simple;
	bh=bi+fSehW2qO2h6IMHUdLJGZCe5b8wNAMHo/dGNxh6Ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iOaUUEhOL1mICCpJA1CBpbQaevW3U4kxT5BrMrc2MLaydrBiwmIOtlQ3ZgdD7qrWq9dx/wyrgqIhfRSQASCxhexTGkaF/zHlbk68N9rBYIUsJuU+57c8KBDFK0bhiAERT/muvYBe/wnnI3d5BuBtBG7F50WzUQ/4I6ZoTSeFWl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xd+Rw+BA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xd+Rw+BA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B11C4AF0E;
	Fri,  9 Aug 2024 12:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723206363;
	bh=bi+fSehW2qO2h6IMHUdLJGZCe5b8wNAMHo/dGNxh6Ys=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xd+Rw+BAtV5wK2FdjVlAhL1V5FyjV6U8+2aqMFOENHWny/m0TKY/dWjjp2ldP8UEN
	 Xc4HpuDsQjI49w94sSeebA6B+ElPRApNu4/W0uFAgACWUFp6tk0L+ppR+daH4bgPzF
	 ambJwyq1c7dsaWnJ825353KvgaEvAONdCawhC0rgN71uy89qwDC8qib325fGnDXBax
	 DpKzDsefPCfozcK4btYa1nMltbeeKSP6q7/EnAYJIPSD+3Y/eFmLWmLs3Iv6fR1dH/
	 X3ykSTUn+HOeR8f7Nl45QmfaepBedIU8U9jDMnix0dCECW246/SslBBKtluvbU+1jH
	 zFAd4o7QSzb6g==
Message-ID: <bc502de8-03c5-4e26-86ec-a3820a6bb993@kernel.org>
Date: Fri, 9 Aug 2024 14:26:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v6 09/11] mptcp: close subflow when receiving
 TCP+FIN
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
 <20240802-mptcp-pm-avail-v6-9-964ba9ce279f@kernel.org>
 <661729ef-4fbd-a497-8a39-5657069384eb@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <661729ef-4fbd-a497-8a39-5657069384eb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 09/08/2024 02:28, Mat Martineau wrote:
> On Fri, 2 Aug 2024, Matthieu Baerts (NGI0) wrote:
> 
>> When a peer decides to close one subflow in the middle of a connection
>> having multiple subflows, the receiver of the first FIN should accept
>> that, and close the subflow on its side as well. If not, the subflow
>> will stay half closed, and would even continue to be used until the end
>> of the MPTCP connection or a reset from the network.
>>
>> The issue has not been seen before, probably because the in-kernel
>> path-manager always sends a RM_ADDR before closing the subflow. Upon the
>> reception of this RM_ADDR, the other peer will initiate the closure on
>> its side as well. On the other hand, if the RM_ADDR is lost, or if the
>> path-manager of the other peer only closes the subflow without sending a
>> RM_ADDR, the subflow would switch to TCP_CLOSE_WAIT, but that's it,
>> leaving the subflow half-closed.
>>
>> So now, when the subflow switches to the TCP_CLOSE_WAIT state, and if
>> the MPTCP connection has not been closed before with a DATA_FIN, the
>> kernel owning the subflow schedules its worker to initiate the closure
>> on its side as well.
>>
>> This issue can be easily reproduced with packetdrill, as visible in [1],
>> by creating an additional subflow, injecting a FIN+ACK before sending
>> the DATA_FIN, and expecting a FIN+ACK in return.
>>
>> Fixes: 40947e13997a ("mptcp: schedule worker when subflow is closed")
>> Link: https://github.com/multipath-tcp/packetdrill/pull/154 [1]
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> net/mptcp/protocol.c | 5 ++++-
>> net/mptcp/subflow.c  | 8 ++++++--
>> 2 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 13777c35496c..609d684135dc 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -2533,8 +2533,11 @@ static void __mptcp_close_subflow(struct sock *sk)
>>
>>     mptcp_for_each_subflow_safe(msk, subflow, tmp) {
>>         struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>> +        int ssk_state = inet_sk_state_load(ssk);
>>
>> -        if (inet_sk_state_load(ssk) != TCP_CLOSE)
>> +        if (ssk_state != TCP_CLOSE &&
>> +            (ssk->sk_state != TCP_CLOSE_WAIT ||
> 
> Hi Matthieu -
> 
> Looks like both those ssk checks should use ssk_state, but otherwise the
> patch looks good.

Good catch!

Will fix that in the v7.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

