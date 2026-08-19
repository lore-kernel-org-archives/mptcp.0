Received: from mta1.migadu.com (out-67.mta1.migadu.com [95.215.58.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9A7383C99
	for <mptcp@lists.linux.dev>; Wed, 19 Aug 2026 11:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138184; cv=none; b=Sre6iaz9EdQRgQF8hs8+/4qyDCGFKH5aTBZgggVOImsaHyabQQPDO8xG2hXymxYuL3DLDF2vh0eKB2KFBwsKhMGdVfEacj5YU36THP9DFFmG6Ha8xDTzJzZcVmQyCL93cSfu7uwHlHemyiSS3NGcPatK9F7MNIN2DCvaWNMbs8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138184; c=relaxed/simple;
	bh=8fwLqMUm+W98Aoyc3lgDaWsyr3vQPnL4nVcOJUzKoMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cyrsyi/lsEyEIlmPM/vit8ExVNmCL+qCYe+sZ79JoOTY7O+KyLsnG7BD/PKJsHgLt0XRHI7s0ckWTLgHNbnM+yuIT0UjBBHV+kNE4y48lNWW0dDyZmY/eZEzwu/unJOSFgB73j9N1CLhScqRJY5B10YCmakRsLaZfqR3WAc5kug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VB5KLvNq; arc=none smtp.client-ip=95.215.58.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VB5KLvNq"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=8fwLqMUm+W98Aoyc3lgDaWsyr3vQPnL4nVcOJUzKoMw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787138179; v=1; x=1787742979;
 b=VB5KLvNqJlHXxr0xSvdYeYGUunLLNCw+AZLZNujeENNb2grx81QWYvq7OaRezSind5tr+PHz
 P9DPnfcAPL+4CdR7Z6JjBEYNNYu2sK0Z1mtJHtsqK4aw7IglWkCxaItwrjMJObqi7t01OPWOdVj
 oVFJa2d6Xyd+qzg7jpWnMXt4=
X-Envelope-To: mptcp@lists.linux.dev
Received: from [192.168.109.30] (223.70.159.239)
	by smtp.migadu.com with ESMTPS id a59c95efca6e53fc;
	Wed, 19 Aug 2026 11:16:09 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <691b982a-7825-490c-b516-ac23b601c64a@linux.dev>
Date: Wed, 19 Aug 2026 19:16:21 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next RFC v4 2/2] mptcp: send MP_FAIL and infinite
 mapping on the same ACK
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260818091417.2200986-1-chenguang.zhao@linux.dev>
 <20260818091417.2200986-3-chenguang.zhao@linux.dev>
 <68791a9e-9310-4368-854e-d379ce0b416c@kernel.org>
Content-Language: en-US
From: Chenguang Zhao <chenguang.zhao@linux.dev>
In-Reply-To: <68791a9e-9310-4368-854e-d379ce0b416c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


在 2026/8/19 00:19, Matthieu Baerts 写道:
> Hi Chenguang,
>
> On 18/08/2026 11:14, Chenguang Zhao wrote:
>> From: Chenguang Zhao <zhaochenguang@kylinos.cn>
>>
>> On a single subflow, accepting MP_FAIL must leave MPTCP mode at once
>> (RFC8684 §3.7). Emit the infinite mapping on the MP_FAIL reply ACK,
>> then call mptcp_try_fallback() immediately after.
> I think Sashiko is right about the issue of lacking option space to have
> both the MP_FAIL and the infinite mapping sent together.
Yes, Sashiko is right, I did not consider all the aspects.
> Please also note this from RFC 8684 §3.7.11 [1]:
>
>> This infinite mapping will be a DSS option (Section 3.3) on the first
>> new packet, containing a Data Sequence Mapping that acts retroactively
> The "on the first new packet" seems to suggest the infinite mapping
> shouldn't be attached to the MP_FAIL.
>
> [1] https://datatracker.ietf.org/doc/html/rfc8684#section-3.7-11
>
>
> Maybe a fallback for the single subflow without csum is enough? Or maybe
> nothing needs to be done? Or maybe this fallback is just an
> optimisation, and can be done in net-next (and both commits can be
> combined)? WDYT?

Hi Matthieu

I am getting a bit confused, so let me summarize my current understanding to verify if I got this right.
In the existing kernel code, fallback will be triggered upon receiving MP_FAIL. However, the FALLBACK_DONE
flag is currently set inside mptcp_update_infinite_map(), which only gets invoked when transmitting a data packet.
This creates a timing window between receiving MP_FAIL and sending the first subsequent packet, resulting in this minor bug.
Our goal is to close this timing window: set the FALLBACK_DONE flag immediately after MP_FAIL is received.
Besides, add a __mptcp_check_fallback() check within mptcp_can_accept_new_subflow() to reject MP_JOIN requests ahead of time.

Is my understanding correct? I will send out a v5 RFC based on the above ideas.      

>> Fixes: 1e39e5a32ad7 ("mptcp: infinite mapping sending")
>> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
>> ---
>>  net/mptcp/options.c  | 33 ++++++++++++++++++++++++++++++++-
>>  net/mptcp/pm.c       |  5 +++++
>>  net/mptcp/protocol.c |  8 +-------
>>  3 files changed, 38 insertions(+), 8 deletions(-)
>>
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index 97da22668dbe..ecf77e77d2de 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -638,7 +638,29 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
>>  	opts->csum_reqd = READ_ONCE(msk->csum_enabled);
>>  	mpext = skb ? mptcp_get_ext(skb) : NULL;
>>  
>> -	if (!skb || (mpext && mpext->use_map) || snd_data_fin_enable) {
>> +	if (unlikely(subflow->send_infinite_map)) {
>> +		unsigned int map_size = TCPOLEN_MPTCP_DSS_BASE + TCPOLEN_MPTCP_DSS_MAP64;
>> +
>> +		if (opts->csum_reqd)
>> +			map_size += TCPOLEN_MPTCP_DSS_CHECKSUM;
>> +
>> +		if (mpext) {
>> +			opts->ext_copy = *mpext;
>> +			opts->ext_copy.infinite_map = 1;
>> +			opts->ext_copy.data_len = 0;
>> +		} else {
>> +			opts->ext_copy.use_map = 1;
>> +			opts->ext_copy.dsn64 = 1;> +			opts->ext_copy.infinite_map = 1;
>> +			opts->ext_copy.data_len = 0;
>> +			opts->ext_copy.data_seq = READ_ONCE(msk->snd_nxt);
>> +			opts->ext_copy.subflow_seq = subflow->rel_write_seq;
>> +		}
> You probably also need to reset "csum". Note that common fields
> (infinite_map and data_len) can also be set once here.
>
> (...)
>
> Cheers,
> Matt
