Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B97917C7C9
	for <mptcp@lists.linux.dev>; Thu, 22 Aug 2024 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724338105; cv=none; b=J/BrVZFC+wWYIwnLKbjoaQDEOSkFUOcNpS5BECnAM/9nM28vf5vvZCcL29WPqf0IN3u/8TiUSaz1PQsfBUpyI/XfmL1PyDemOiOogkZn+tI39tWAIgCpvs6qdBMbk5QzRZ+r8aBan01HIAjLAL2bS7/3t5EpJVf3QRVoA4guD/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724338105; c=relaxed/simple;
	bh=G83byOvmYFuEJOTixV2ptjdAE4j/geTU0OlE5oDt328=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LcqZ/NIBU76Dj4hLAchBnO+QMQllQQwZyNhLOn70WUL8jDEoYvrCJKeY9qebX7oF6qM4xrkc2Qd7Kh1rElLrHuvSXmP9xiTjyzxKnAptS2awuNlt2RDFC5brMIvUIIeXx8kEGl+37dBzYhPtTTtFtlvLG86nbCBun91a2c5OxWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOuiQnS8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOuiQnS8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5175C4AF0E;
	Thu, 22 Aug 2024 14:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724338104;
	bh=G83byOvmYFuEJOTixV2ptjdAE4j/geTU0OlE5oDt328=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SOuiQnS8ZWoHGFi11z7v170UrY8NiljRd7UfZeg5HtO7BRsF3ihLAIubXLOxottpi
	 7qhlqRqR+oohZ2cbJy8tsBRaAGZFMxKLsyywvpETmqk6eT4wpkiHMYNz5RXijLYoY0
	 YeDAPOknJO+IRnoNB6o2VoVFVvwDuU9+lCVOI+sz0f6gsVNIpJUifSnIt3z3CcZ/9a
	 dhUm8CJoxbTMP6uFYJcgIjByMlVN0wpxwnf4T9lSoBxXGj+JaP145366RfGrpx49/+
	 yOwo2or1ReUJo/QG8ofqeTNuiqrnJjykFp2nV4hKLWmtybLhOR8yTaZPqNadt4BWM+
	 0nNTgiunkkhFw==
Message-ID: <1ed09f3d-fd1c-402a-b7fd-a5bdd8674b9f@kernel.org>
Date: Thu, 22 Aug 2024 16:48:21 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 2/2] selftests/bpf: Add getsockopt to
 inspect mptcp subflow
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <cover.1724318341.git.tanggeliang@kylinos.cn>
 <f4c969836e4c051f6752446a1bd26b763caa121c.1724318341.git.tanggeliang@kylinos.cn>
 <c70ef113-0168-44f0-8e4e-ac5d7c75131d@kernel.org>
 <1cfb8506929db74e0494966b3599ced60c58e51e.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <1cfb8506929db74e0494966b3599ced60c58e51e.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/08/2024 15:31, Geliang Tang wrote:
> On Thu, 2024-08-22 at 12:56 +0200, Matthieu Baerts wrote:
>> On 22/08/2024 11:22, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>

(...)

>>> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
>>> b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
>>> index 782f36ed027e..70d9f5888976 100644
>>> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
>>> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
>>> @@ -4,9 +4,44 @@
>>>  
>>>  #include <vmlinux.h>
>>>  #include <bpf/bpf_core_read.h>
>>> +#include "bpf_experimental.h"
>>>  
>>>  #define MPTCP_SUBFLOWS_MAX 8
>>>  
>>> +static inline int list_is_head(const struct list_head *list,
>>> +			       const struct list_head *head)
>>> +{
>>> +	return list == head;
>>> +}
>>> +
>>> +#define list_entry(ptr, type,
>>> member)					\
>>> +	container_of(ptr, type, member)
>>> +
>>> +#define list_first_entry(ptr, type,
>>> member)				\
>>> +	list_entry((ptr)->next, type, member)
>>> +
>>> +#define list_next_entry(pos,
>>> member)					\
>>> +	list_entry((pos)->member.next, typeof(*(pos)), member)
>>> +
>>> +#define list_entry_is_head(pos, head,
>>> member)				\
>>> +	list_is_head(&pos->member, (head))
>>> +
>>> +#define list_for_each_entry(pos, head,
>>> member)				\
>>> +	for (pos = list_first_entry(head, typeof(*pos),
>>> member);	\
>>> +	     !list_entry_is_head(pos, head,
>>> member);			\
>>
>> I guess you cannot add 'cond_break' in the condition, because that's
>> the
>> equivalent of 'break', right?
> 
> Hi Matt,
> 
> This confuses me.
> 
> I used this in v2:
> 
> 	mptcp_for_each_subflow(msk, subflow) {
> 		... ...
> 
> 		cond_break;
> 	}
> 
> And you suggested to add "cond_break" into list_for_each_entry().
> 
> Do you mean that I should go back to v2?

No, sorry, I was just initially surprised to see 'cond_break' in the
last part of the 'for', not in second part: the condition to stop the
loop. But I then saw that 'cond_break' is a cryptic define, doing the
equivalent of a "break", not just a simple condition, it has be where
you added it.

I'm personally a bit annoy to see a copy of all these "define" for the
list here in mptcp_bpf.h, but maybe it is normal, and accepted by BPF
maintainers. Thanks to the 'cond_break' you added there, they look quite
generic, and not specific to MPTCP. They could go elsewhere, but maybe
nobody else needs to iterate a list in the BPF selftests. And they can
always be moved later on I suppose. So no need to change that in the v4.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

