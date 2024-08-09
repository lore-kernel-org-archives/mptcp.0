Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C7A1DFF5
	for <mptcp@lists.linux.dev>; Fri,  9 Aug 2024 12:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723206852; cv=none; b=ZzNRcdrcCxWGqCvG+U3oGjyNUoMVWtn8pdi/CzEg8PKU57i6FQTH7fmtAffvI3kNg4hwNVioOfjLWfBnL4N+ythMgbKTHjYEqeXQ5+aKO3iXPHan6Zbb5J5Gn6HQ+cWsrWbK+uD7yQCWJJ9y4VxkJdhowfDtxDDMyvBW0ZJ2eC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723206852; c=relaxed/simple;
	bh=rVA1sY+YAx6uMBTdzphpj/hIRU9Bvtw4Hib+DaTHKIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fPfgMdyC5vh8xp7Cq6Jm+CSc27h5ANnlJXoObCgoPAgUKR9LgBEBajKC5qKvsTzxEJl+Hq20pv4Bwcx9LzpEVHCfT9vzlIBdr90HQpcFknJLDtZO3QtzLv6jj1ElLYYtPVKkf93kjwKrIlf6JVAPUFPFFfVoxYsIWzKs7coRkCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0jURAvY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0jURAvY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8ADC32782;
	Fri,  9 Aug 2024 12:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723206852;
	bh=rVA1sY+YAx6uMBTdzphpj/hIRU9Bvtw4Hib+DaTHKIs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t0jURAvYTBD08jHg4dzyr642lwhMxSXjAlvI1Z9mtzzaWT0nue+w8z+Ix9y/H/2RX
	 j6Z9GUyYZzTqwPFWBoiDqzt1ggCyMhhWcrFq0pnnAcliNs8EO7CN5A+tUTll4rGwYh
	 tnpWqdz0dWrcjVKKER5rgk3J62bifukwPT6e9KSUea4CNdden0qeJ1uD7j4PLALROu
	 nYnB/kRwAkTxv7+eoAiaAFys5hTYf31NSi6ZQix6wtHjiCtZ8WIDcDmwUnydIy5MjD
	 z2EPNVpSNKQ7P3uP/J543FTpEyBsI7WAxLNgsq+ajGTDjsITt85MdLsi6EF2jz+1bt
	 0UtzAKftx0ROg==
Message-ID: <cacca721-92d9-4ded-9011-e201cec31c50@kernel.org>
Date: Fri, 9 Aug 2024 14:34:09 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v6 10/11] selftests: mptcp: join: cannot rm sf
 if closed
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
 <20240802-mptcp-pm-avail-v6-10-964ba9ce279f@kernel.org>
 <115783a3-d667-b9a9-3f8c-266023e15069@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <115783a3-d667-b9a9-3f8c-266023e15069@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 09/08/2024 02:33, Mat Martineau wrote:
> On Fri, 2 Aug 2024, Matthieu Baerts (NGI0) wrote:
> 
>> Thanks to the previous commit, the MPTCP subflows are now closed on both
>> directions even when only the MPTCP path-manager of one peer asks for
>> their closure.
>>
>> In the two tests modified here -- "userspace pm add & remove address"
>> and "userspace pm create destroy subflow" -- one peer is controlled by
>> the userspace PM, and the other one by in-kernel PM. When the userspace
>> PM sends a RM_ADDR notification, the in-kernel PM will automatically
>> react by closing all subflows using this address. Now that the subflows
>> are properly closed on both direction, the userspace PM can no longer
>> closes the same subflows if they are already closed. In this case, an
>> error will be returned to the userspace. So no need to run this command,
>> which mean that the linked counters will then not be incremented.
>>
>> These tests are then no longer sending both a RM_ADDR, then closing the
>> linked subflow just after. The test with the userspace PM on the server
>> side is now removing one subflow linked to one address, then sending
>> a RM_ADDR for another address. The test with the userspace PM on the
>> client side is now only removing the subflow that was previously
>> created.
>>
> 
> Hi Matthieu -
> 
> How does this selftest behave on older kernels without the fix in the
> previous patch? Would be good to include that information in the commit
> message.

I tried to explain that in the commit message. Let me try to clarify
this in the v7 :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

