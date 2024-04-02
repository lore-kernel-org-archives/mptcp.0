Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4BC4778E
	for <mptcp@lists.linux.dev>; Tue,  2 Apr 2024 08:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712048339; cv=none; b=exeU9dRCXMx+3m0Okp7LuReRObFobVr3I4k8rUTx+Wz3PA7UGbqrAQFxm6c41fBviqfyFeHD982OxVC0iR3YnJkpejmb6VYqZv7TYwPaajcYcrOubYZHRttEz2WLXK6ybgOKdvEcuX2VeF+ySJO67x0Hmlz31ZsdU4WAC1hr50s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712048339; c=relaxed/simple;
	bh=/dCv40bXlnkSr5OvW8aU+4NQ732lNJCE5bfMLnoLNAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZOnDWg3Sg1L0dj5AOwUWb860Z6smFuHrFbFCA3/PRGwqOE2WkOzszhghuD6gMTyXRuR/FrpVkp0GvJ2aai6az5pZi9miqh5nxSbm/fcwhkkUEOJ2NTNpyugO/ubWNv1En8uRBiSp6CnBD0WBQlDdZUjGD32ScPnYkiwggxi9S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSw0/U23; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSw0/U23"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77050C433F1;
	Tue,  2 Apr 2024 08:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712048338;
	bh=/dCv40bXlnkSr5OvW8aU+4NQ732lNJCE5bfMLnoLNAQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FSw0/U236Uc/mB/Io7lfLgyvm4PzQ+nk77SY8zAuEE7Z1oq0d1D2SjloJPcesNy6m
	 +uX3KFU4MKfGXhN10RlajKI+T6Jsff0ddIxCFzRH8JuWlze7Z5VYqJEEkthwana8LZ
	 QnbkVFJQ/8fzlVBV6+0rl6VgqKK7mqNdsQhaOrl52ovJCZBb1MzWdSd3SRd2bk7n/Y
	 JjrqjfP59Ixb/OfiFwOGj1BDtfkiwKiLJ1qSUFH9jVGm3BlEWmo7CH3oY6YiIcTI3N
	 WsgzefwKrE/daiTtwCdtwD3238qpTd/bwKswVQA7sYuB0wmb8oM9/jKUnMKkcsRQCr
	 X4u3lf+uUyDaw==
Message-ID: <5d0badac-bff9-4ffe-ab22-487c9cae1e57@kernel.org>
Date: Tue, 2 Apr 2024 10:58:54 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 3/3] selftests: mptcp: add last time actions
 tests
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1711784619.git.tanggeliang@kylinos.cn>
 <b5a4e6d634ae8fd3e0710b02f57f0998a3da7df0.1711784619.git.tanggeliang@kylinos.cn>
 <5b22266f-922f-cfa3-f006-656262aa0351@kernel.org>
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <5b22266f-922f-cfa3-f006-656262aa0351@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 01/04/2024 20:21, Mat Martineau wrote:
> On Sat, 30 Mar 2024, Geliang Tang wrote:
> 
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> This patch adds a new helper chk_msk_info() to show the counters in
>> mptcp_info of the given infos, and check that the timestamps move
>> forward. Use it to show newly added last_data_sent, last_data_recv
>> and last_ack_recv in mptcp_info in diag.sh.
>>
>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>> ---
>> tools/testing/selftests/net/mptcp/diag.sh | 29 +++++++++++++++++++++++
>> 1 file changed, 29 insertions(+)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/
>> testing/selftests/net/mptcp/diag.sh
>> index bc97ab33a00e..2f9f734015b4 100755
>> --- a/tools/testing/selftests/net/mptcp/diag.sh
>> +++ b/tools/testing/selftests/net/mptcp/diag.sh
>> @@ -200,6 +200,34 @@ chk_msk_cestab()
>>          "${expected}" "${msg}" ""
>> }
>>
>> +chk_msk_info()
>> +{
>> +    local port="${1}"
>> +    local info
>> +
>> +    for info in "${@:2}"; do
>> +        local cnt1 cnt2 msg
>> +
>> +        cnt1=$(ss -N ${ns} -inHM dport ${port} |
>> mptcp_lib_get_info_value "$info" "$info")
>> +        sleep 0.5
> 
> Hi Geliang -
> 
> With the loop structured this way, it sleeps 3 times. You could collect
> the first timestamp for all three values (last_data_sent last_data_recv
> last_ack_recv), then sleep once, then get all 3 "after" timestamps.
> 
> (Unless Matthieu doesn't care about the extra test time :) )

Good idea to have only one sleep!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

