Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1F018A93C
	for <mptcp@lists.linux.dev>; Mon, 31 Mar 2025 12:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743425832; cv=none; b=Gj8DCKkMuiin3gzzQH6UZ7JJMXbxURx8PneeC8XjRNpDbsiNlAPUdEGSKhCRCpkkz/AVlXQe4JppFg05grx5Cgd9d9+LpMUl3DPIodYUL7qvu4jfODpC8MsR5dReLbxczNDH5pyapA2k6dZfIOJDSI2Ld9b4eyHYlGisrqCCb9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743425832; c=relaxed/simple;
	bh=QITiDu8ac5SB5yn21KgRsvvyvSjNAwtErLK9C3Vaojo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Qv+js6TXm0bo5KksfeMzy0lRvTek+Vnxq3G5LD5Vu2ksZ6BL6osrgCuzsKKeAt8tNf+4vfeUkvlQWUE4Vienm6QQwwQPO7MXp3f3IkQ5aghtP6SstsCKy5jmzCA/+X4dTZxX+/thJj1hGYgPEeKzpiQql8In7/BPKc8C0V4esXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQmDD1Xm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQmDD1Xm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB3BC4CEE3;
	Mon, 31 Mar 2025 12:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743425832;
	bh=QITiDu8ac5SB5yn21KgRsvvyvSjNAwtErLK9C3Vaojo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=oQmDD1Xmg/ula91TPrSoPMbJyxgURURgAzi6e/ElKqsTwnMiwbL/VXh9SWpAesd0T
	 Lrm+Bv+nvfbWiltxeBGfXAAHWtVDewEPoznlcFakeloFZl0QpwYa6RIjKO+dfHZWC2
	 F4l+OZ4arAJfY8VGBCnQ2eQNR6gxahZ6TQQtAaeJicz9T8PdOGubbOTae1kzKnQy9a
	 PqkajArKjB44OOyVgaSrCyWojMJMGocH50R0D4/TaFNGsYuCIsabGTgp0MpVnDQT7X
	 HSIXFHeLDo8DhjHnzHpPHuqFUDg+nvvsljLR+rnmEvd4RZtJTO2KGvhIv+fHXuQCer
	 kFlw4Sgfy2Z7g==
Message-ID: <34ce1680-a30e-4bf6-a214-101d91c83cd1@kernel.org>
Date: Mon, 31 Mar 2025 14:57:08 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 4/5] mptcp: add MPJoinRejected MIB counter
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20250329-mptcp-mpj-reject-v1-0-2396d5666e8f@kernel.org>
 <20250329-mptcp-mpj-reject-v1-4-2396d5666e8f@kernel.org>
 <910fc74590b10617dfc0dffe950f895f2457c089.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <910fc74590b10617dfc0dffe950f895f2457c089.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 31/03/2025 03:59, Geliang Tang wrote:
> Hi Matt,
> 
> On Sat, 2025-03-29 at 17:26 +0100, Matthieu Baerts (NGI0) wrote:
>> This counter is useful to understand why some paths are rejected, and
>> not created as expected.
>>
>> It is incremented when receiving a connection request, if the PM
>> didn't
>> allow the creation of new subflows.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  net/mptcp/mib.c      | 1 +
>>  net/mptcp/mib.h      | 1 +
>>  net/mptcp/protocol.c | 4 +++-
>>  net/mptcp/subflow.c  | 2 ++
>>  4 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
>> index
>> 19eb9292bd6093a760b41f98c1774fd2490c48e3..0c24545f0e8df95b3475bfccc7a
>> 2f2ce440f7ad2 100644
>> --- a/net/mptcp/mib.c
>> +++ b/net/mptcp/mib.c
>> @@ -28,6 +28,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
>>  	SNMP_MIB_ITEM("MPJoinSynAckHMacFailure",
>> MPTCP_MIB_JOINSYNACKMAC),
>>  	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
>>  	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
>> +	SNMP_MIB_ITEM("MPJoinRejected", MPTCP_MIB_JOINREJECTED),
>>  	SNMP_MIB_ITEM("MPJoinSynTx", MPTCP_MIB_JOINSYNTX),
>>  	SNMP_MIB_ITEM("MPJoinSynTxCreatSkErr",
>> MPTCP_MIB_JOINSYNTXCREATSKERR),
>>  	SNMP_MIB_ITEM("MPJoinSynTxBindErr",
>> MPTCP_MIB_JOINSYNTXBINDERR),
>> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
>> index
>> 128282982843a07614a46f9b2c2f7c708306c769..250c6b77977e8f846b5741304f7
>> 841a922f51967 100644
>> --- a/net/mptcp/mib.h
>> +++ b/net/mptcp/mib.h
>> @@ -23,6 +23,7 @@ enum linux_mptcp_mib_field {
>>  	MPTCP_MIB_JOINSYNACKMAC,	/* HMAC was wrong on SYN/ACK
>> + MP_JOIN */
>>  	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN
>> */
>>  	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK +
>> MP_JOIN */
>> +	MPTCP_MIB_JOINREJECTED,		/* The PM rejected
>> the JOIN request */
>>  	MPTCP_MIB_JOINSYNTX,		/* Sending a SYN + MP_JOIN
>> */
>>  	MPTCP_MIB_JOINSYNTXCREATSKERR,	/* Not able to create a
>> socket when sending a SYN + MP_JOIN */
>>  	MPTCP_MIB_JOINSYNTXBINDERR,	/* Not able to bind() the
>> address when sending a SYN + MP_JOIN */
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index
>> 9042a86e003036f8eb9680bc6c520fb57d92dbd0..8ba1a4f225bd2014ebdc973e752
>> 702028ee5f31a 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -3527,8 +3527,10 @@ bool mptcp_finish_join(struct sock *ssk)
>>  		return true;
>>  	}
>>  
>> -	if (!mptcp_pm_allow_new_subflow(msk))
>> +	if (!mptcp_pm_allow_new_subflow(msk)) {
>> +		MPTCP_INC_STATS(sock_net(ssk),
>> MPTCP_MIB_JOINREJECTED);
> 
> nit:
> 
> Although the result is the same as sock_net(ssk), what do you think of
> using sock_net(parent) here?

We could, but why would you prefer using 'parent' instead of 'ssk'? Ii
picked 'ssk' because that's the one passed in argument of this function.
'parent' is obtained from 'ssk'.

I hope you don't mind if I apply the patch as it is because I already
applied the parent patches. I can always change that later of course.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

