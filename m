Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D700F1CB327
	for <mptcp@lists.linux.dev>; Wed,  7 Aug 2024 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723024316; cv=none; b=agO2rBDRqlN34XOG0i8RwvFFgoybZR4QVkbKHWWfs6PViUIcDf/L09wK5Oy1z0eS1ZS9erZo75F5GHR939oZrv26pXpwshydmfeekqe18GkiCZnxHC14JvjewOLGcfNs+HaogikceyPpZQipf7oogW/FmenmWu9Rnc5So8T0/iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723024316; c=relaxed/simple;
	bh=ljKYdbNWXNtE3D2QSWdllFkO4nHeRd0XKq/4Ypmc10M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4Gh26f7sFAn7wve34F1txZXnuPjJ9zS5mipWIi66xWMbDzy02wurtGbaXm9LxRwgcIm49+QkUdk5k17bSppIFKXY5IszKD7FbEMu2LT62LqmPMp+4Lato4wSvnFZfKd+kqjcsi56eov43m7eoNMzE5Cif99lzfbjTenqDAC9Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVKP4s90; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVKP4s90"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3E7C32782;
	Wed,  7 Aug 2024 09:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723024316;
	bh=ljKYdbNWXNtE3D2QSWdllFkO4nHeRd0XKq/4Ypmc10M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UVKP4s902PQh8+EMy0N0kfqI1TFXZRiQl7xFRWtc442lNsMOM0BJu2JuHM8UzDztj
	 tqZvfdCpkTq5JAlD1Q3thpvPY729CrnP2abmyvCwCo75lv11qQ17OCXjiRQxKlT7YS
	 ZXgnQ+iRxEhuRecY7cTAqkkP5RQxx1Lc5Gp8C0BVcR8/23Dq7pnSvg/hcu3dzERRaM
	 mjO8xSTQXMPS9wtDeUPzFPEeq1h5e1K4ka5jArCEzrU59vdpMOGpB+nWuL9i714Ley
	 tpQOck8uoz1RPFhOGfdkD41Cj+k76uB1S1hTRL7X95TqXxkpPq3GKjciMRFIgIxY8E
	 o+vbEapVFSm+Q==
Message-ID: <5e7b7057-8c01-491c-8b0e-39a3035657f7@kernel.org>
Date: Wed, 7 Aug 2024 11:51:53 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v6 05/11] mptcp: pm: send ACK on an active
 subflow
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
 <20240802-mptcp-pm-avail-v6-5-964ba9ce279f@kernel.org>
 <e3368a02-2083-b0b2-54c4-3a9662c0d80f@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <e3368a02-2083-b0b2-54c4-3a9662c0d80f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

Thank you for the review!

On 07/08/2024 00:29, Mat Martineau wrote:
> On Fri, 2 Aug 2024, Matthieu Baerts (NGI0) wrote:
> 
>> Taking the first one on the list doesn't work in some cases, e.g. if the
>> initial subflow is being removed. Pick another one instead of not
>> sending anything.
>>
>> Fixes: 84dfe3677a6f ("mptcp: send out dedicated ADD_ADDR packet")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Notes:
>>  - We could also check if the subflow is not "staled", but probably
>>    best to do that for net-next only.
>> ---
>> net/mptcp/pm_netlink.c | 9 ++++++---
>> 1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
>> index 4000de54c99c..e25cda3909fa 100644
>> --- a/net/mptcp/pm_netlink.c
>> +++ b/net/mptcp/pm_netlink.c
>> @@ -768,9 +768,12 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock
>> *msk)
>>         !mptcp_pm_should_rm_signal(msk))
>>         return;
>>
>> -    subflow = list_first_entry_or_null(&msk->conn_list,
>> typeof(*subflow), node);
>> -    if (subflow)
>> -        mptcp_pm_send_ack(msk, subflow, false, false);
>> +    mptcp_for_each_subflow(msk, subflow) {
>> +        if (__mptcp_subflow_active(subflow)) {
>> +            mptcp_pm_send_ack(msk, subflow, false, false);
>> +            break;
>> +        }
>> +    }
> 
> Hi Matthieu -
> 
> If all subflows are stale, it should still try to send on one (falling
> back to the original first entry seems as good as anything else?)

Yes, good point, probably something I should do in patch 11/11.

But here, 'stale' is not checked. Probably the __mptcp_subflow_active()
helper doesn't have a good name. It is only checking the state (fully
established, and not closed):


> static inline bool __tcp_can_send(const struct sock *ssk)
> {
> 	/* only send if our side has not closed yet */
> 	return ((1 << inet_sk_state_load(ssk)) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT));
> }
> 
> static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
> {
> 	/* can't send if JOIN hasn't completed yet (i.e. is usable for mptcp) */
> 	if (subflow->request_join && !subflow->fully_established)
> 		return false;
> 
> 	return __tcp_can_send(mptcp_subflow_tcp_sock(subflow));
> }


If __mptcp_subflow_active() returns 'false', we cannot send the
ADD_ADDR. So I think we are good like that, no?

We can drop the patch 11/11 for the moment.

> 
> - Mat
> 
>> }
>>
>> int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
>>
>> -- 
>> 2.45.2
>>
>>

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

