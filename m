Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6332E2DDD
	for <mptcp@lists.linux.dev>; Thu, 11 Sep 2025 08:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757579714; cv=none; b=hDRnrqE0JncC8SyBIfRYSim8RODi/khn2fpgVtjofNT2oxNm1rV8pnqmaWgdpiehG54cvzIMC99FJ5NH5xU5j0GZq/Ska8yvq7TVji/7FtqXyUgxzaEC1keUZLKgzJo9EfnOH8dMG1MjBZMLO8j5PtpkR9L44J+bLc3gO6zUabc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757579714; c=relaxed/simple;
	bh=o/t0CdPrmYH0WE1Ekhc498lmRb2+EaFv6YBSw4/N3zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WaAcbkSfHXJGKse79YHQu4TRB/0ItEWmXS9Ai0GXy1n7EORMlb/tqsGWEOWSXHZCVf+u9zrc/7LTX1IC1GF+rYx+8w/r8rnTAG9k7x2T+olq3yUDPrkm5Mp7s8kQQWTPR9NO+pqO4gLIQozb8h9NcSqdJikA7fGkLOw3wNfyXqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpTbCOF5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpTbCOF5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFFBC4CEF7;
	Thu, 11 Sep 2025 08:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757579712;
	bh=o/t0CdPrmYH0WE1Ekhc498lmRb2+EaFv6YBSw4/N3zc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=LpTbCOF5VKBSKGkXs6RNax4UGw8qR55VrPaKdTkfIn5pd8CRWepr2vJ3q44IApbZM
	 wefzgzDkKgbs7f9dVbGNRg0XARliAYU1fbfBFJEm064rx5hS54yuNWMfe8ODtvmr24
	 FBsEnCG++cJHJjU21G6VODo/IL9vrID0jX2PfA1/tUombgjm2X5q7go/0LjrioGQuH
	 aN4nWj3q31pWZnhIaRliGZkGDDS2FvrG3GXp8eWlualrWRZRvGvg3X91b6yaxVOh9h
	 EteO7DcSqdNHSXBb+XlkUzPubpY7mprOepcJI8Q80IeHfdNR+V7lGkxirXV2g95oVY
	 9B41UOrQqgT5g==
Message-ID: <1f62d970-631e-4031-a386-2b1db50642fb@kernel.org>
Date: Thu, 11 Sep 2025 10:35:09 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 4/4] selftests: mptcp: pm: get server-side flag
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>
References: <20250909-mptcp-pm-user-server-side-flag-v1-0-cb8e2b8d1c0c@kernel.org>
 <20250909-mptcp-pm-user-server-side-flag-v1-4-cb8e2b8d1c0c@kernel.org>
 <20639f7f4b2616afaa4c4e511a13aa8ad49c8d90.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20639f7f4b2616afaa4c4e511a13aa8ad49c8d90.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 11/09/2025 10:16, Geliang Tang wrote:
> Hi Matt,
> 
> On Tue, 2025-09-09 at 18:30 +0200, Matthieu Baerts (NGI0) wrote:
>> server-side info linked to the MPTCP connect/established events can
>> now
>> come from the flags, in addition to the dedicated attribute.
>>
>> The attribute is now deprecated -- in favour of the new flag, and
>> will
>> be removed later on.
>>
>> Print this info only once.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
>> b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
>> index
>> 93fea3442216c8fef43731a99c1d5710f234b150..d4981b76693bbddca74169437a5
>> 40ad6294cf1d5 100644
>> --- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
>> +++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
>> @@ -2,6 +2,7 @@
>>  
>>  #include <errno.h>
>>  #include <error.h>
>> +#include <stdbool.h>
>>  #include <stdio.h>
>>  #include <stdlib.h>
>>  #include <string.h>
>> @@ -113,6 +114,8 @@ static int capture_events(int fd, int
>> event_group)
>>  		error(1, errno, "could not join the "
>> MPTCP_PM_EV_GRP_NAME " mcast group");
>>  
>>  	do {
>> +		bool server_side = false;
>> +
>>  		FD_ZERO(&rfds);
>>  		FD_SET(fd, &rfds);
>>  		res_len = NLMSG_ALIGN(sizeof(struct nlmsghdr)) +
>> @@ -187,18 +190,22 @@ static int capture_events(int fd, int
>> event_group)
>>  				else if (attrs->rta_type ==
>> MPTCP_ATTR_ERROR)
>>  					fprintf(stderr, ",error:%u",
>> *(__u8 *)RTA_DATA(attrs));
>>  				else if (attrs->rta_type ==
>> MPTCP_ATTR_SERVER_SIDE)
>> -					fprintf(stderr,
>> ",server_side:%u", *(__u8 *)RTA_DATA(attrs));
> 
> It is a little strange that server_side is displayed at the end. It
> changes the original display order.  It is better to display it in the
> original position, but check whether the server_side flag is false:

I'm not sure to understand why it is strange: the output is read by
scripts, the order should not matter, right?

Plus the order depends on what was received by the kernel, not where
they are printed here.

Do you really think it is worth it changing this patch and making longer
just to keep an order that we don't currently fully control here?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

