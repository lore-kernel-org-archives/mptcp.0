Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03588355057
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786727735; cv=none; b=I6T5/Mfi/alHsx2v1qHzjgUFRCuQ/8UGadMGiEpxmP9G+oVjbzjEiBFAsxvsjYD0t3unucS5OCcrVVdEZC6nhXHXDGQNK7OMUnCCwe2PpWM54INyKtcsBzEGFxouKeV+MHvWnMHvXJXdGvELF+5Oyq1Z91btMbecuVyBYRT1EtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786727735; c=relaxed/simple;
	bh=FdBmJBZsQ6t3ngL13iEaqXZjNorYoJSL9OEM4AeNFVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BEOql/os8ZYPcr+hH1hTfq/cTejIhxTdFgVy42VYtlq9jjN3gaRBrbipzJEmbZ1ODUiKdFo6o/CNcXhjVcZxCKMXFGQPxWNJ5Q4izjnhcbB7Ltzyd+yfptrIdWqYMa0Sv8DkGCEQlwGCQSwBHhNaublq+Ym9jYGSSHK1GUFZ8A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xyjybu7S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xyjybu7S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20601F000E9;
	Fri, 14 Aug 2026 17:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786727733;
	bh=rMfMnrs3dGdZByoH9DheEmdTfKGxHZpki+3DZ9HFazI=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=Xyjybu7SBR5rVDYi5GNnmH9bHIR+i5K30l3fDWY+WZcGkeD9QbN1QzPQAW/pa8PEM
	 NPJP5RxRGF23xIkwdBkECjejTCAQdehf5bOvvxzJZ9+brgxK6Q7jZ/MkqmwiE6d61C
	 FrtEqXHbq53fS95ZcJfhD5p4KXPS78RFhTNzNNsAZ6gT9/dVcjlQIkfxXzT4EEdRHy
	 vX6H7kp737utv1M8aTOKOZ8r4pO/vOhvdZmQmz9Be3DFqH0aBnOYydmGuCzMFEwx1/
	 x3O6hBpUGyywmAW3RoJ4zAqv2Fv3MEiksPjtvlif5M1lBPcvDmzXUYW0EDs7oCEJlY
	 +AW+pAl8JFfPA==
Message-ID: <a11eca34-7a65-4023-94a3-9ca9f5cb8490@kernel.org>
Date: Fri, 14 Aug 2026 19:15:30 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] selftests: mptcp: print stats before socket
 closure
Content-Language: fr
To: Paolo Abeni <pabeni@redhat.com>, MPTCP Linux <mptcp@lists.linux.dev>
References: <20260814-sft-mptcp-stats-b4-close-v1-1-2945a591be7e@kernel.org>
 <b8ac43a1-d5f1-4498-8aae-dc87c2e3b437@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <b8ac43a1-d5f1-4498-8aae-dc87c2e3b437@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 14/08/2026 18:44, Paolo Abeni wrote:
> On 8/14/26 4:07 PM, Matthieu Baerts (NGI0) wrote:
>> In case of poll timeout, it might be too late to print the stats after
>> the socket closure.
>>
>> Now, in case of poll timeout, 'ss' and 'nstat' are invoked from
>> mptcp_connect to print the stats before exiting. This should help
>> debugging poll timeout issues.
>>
>> Note: for this "workaround", system() is used for debugging purposes
>> only. The returned result can then be safely ignored.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_connect.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>> index ea4cb6c1bd5e..842c0eb99aa9 100644
>> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>> @@ -210,6 +210,19 @@ static void xgetaddrinfo(const char *node, const char *service,
>>  	}
>>  }
>>  
>> +static void print_err_stats(void)
>> +{
>> +	char cmd[128];
>> +
>> +	snprintf(cmd, sizeof(cmd), "ss -Menitam -o '%cport = :%s' >&2",
>> +		 listen_mode ? 's' : 'd', cfg_port);
>> +
>> +	fprintf(stderr, "socket stats before socket closure:\n");
>> +	(void)!system(cmd);
>> +	(void)!system("NSTAT_HISTORY='/tmp/$(ip netns id).nstat' nstat -s | "
>> +		      "grep Tcp >&2");
> 
> Overall LGTM. I tried something similar in the past, but the correct
> redirection always fouled me. A couple of questions:

Thank you for having checked!

> - Is the '!' operator needed?

Yes, to avoid a warning because the results are unused. Only using
(void) is not enough from what I saw.

> - Can we avoid the pipe? with something alike the following:
> 	(void)system("NSTAT_HISTORY='/tmp/$(ip netns id).nstat' nstat -s *Tcp*

Oh nice, I didn't think about that. Yes it works except it keeps the
header (#kernel). Maybe fine here, but we don't change that in the .sh
scripts?

I can send a v2 with that and an extra explanation.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

