Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B962D7DD7
	for <mptcp@lists.linux.dev>; Fri,  1 May 2026 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777646993; cv=none; b=YGol3/KDurgR35fUC4cdA6HVvBFvyrvu5hwawzpYaAAvaeG126s6kst51ZZj4O/GSfyZFsFT8dqzkd6V3Md9EFmeIxdmehq3PBKJKKmR82QU+dDh1XOr6f6Zfwfs5rbkx4xWtUIvMggSJz06lgphwurUcJMH4Ez4qit2Kx+Q1oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777646993; c=relaxed/simple;
	bh=btK0wTtSF0kVMQQmxeS2yF+vXvOYBzn87CQgdxA5U/w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ii7VMO30GK0FGWUwusPbhv0+tgQyOqxtUQUIA3R1IGjVM0ef5/ZVonLV6UtAV3YF8ca8RMXENjCUNgrqTEpCD37oZfP2TtdU/fCIeSiWK94wd4UblhPe8NPE+MGX8EZ5zkMlsYYbWzOjtyyxizUDUEs3+L6ImBTc4Eh58+rT+WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DysKjpUu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DysKjpUu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B946C2BCB9;
	Fri,  1 May 2026 14:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777646993;
	bh=btK0wTtSF0kVMQQmxeS2yF+vXvOYBzn87CQgdxA5U/w=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=DysKjpUuA9VOa3EOAP3LzDBLT3a82ve1vC4NVj0G1HkMq8nbSGxnVafC84ws9SawC
	 U5dQo5ybnBjcJutAgNCrhnwjUZhFDM6ELNdkEJSISMqg4nrYFtLluQ/DDCQrQvQoda
	 lPO8oFhCgcDkn1BnjxUVLT+kpav91U3UP8EDN5uOOCTKdWLFMgCqcQICIlKKDxgr2F
	 3wcSJ9KRpiVMdNP6RpoAi4nk2ChEY66atCXhTdWjziWqIVgY7Q2ccFLvn3ktD5ycB8
	 0ljl9+kVlJpEcKNEavSrDUFj8537nTzSoktpDRRu6eHZXMI1m8Vyzfioz3eHkfB70a
	 mLg1P38PfraRA==
Message-ID: <efb7cbc4-a4c9-4f84-b440-0a2aa3267c02@kernel.org>
Date: Fri, 1 May 2026 16:49:49 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v4 0/4] mptcp: MSG_ERRQUEUE support on the
 parent socket
Content-Language: fr
From: Matthieu Baerts <matttbe@kernel.org>
To: David Carlier <devnexen@gmail.com>, mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20260421223338.52743-1-devnexen@gmail.com>
 <cover.1777324037.git.devnexen@gmail.com>
 <43f69e5e-b0a5-4bc5-8e6b-8f41ef4cf55a@kernel.org>
 <59eccce4-cbc6-48b9-9243-9b9b5a5ca066@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <59eccce4-cbc6-48b9-9243-9b9b5a5ca066@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi David,

On 28/04/2026 20:56, Matthieu Baerts wrote:
> On 28/04/2026 20:48, Matthieu Baerts wrote:
>> Hi David,
>>
>> Thank you for the new version.
>>
>> On 27/04/2026 23:10, David Carlier wrote:
>>> MPTCP already advertises IP_RECVERR/IPV6_RECVERR as supported, but the
>>> parent socket does not currently provide usable MSG_ERRQUEUE handling.
>>>
>>> This series wires the MPTCP socket up to the IPv4/IPv6 error queue
>>> paths. It propagates RECVERR-related sockopts to existing and future
>>> subflows, makes poll() report pending errqueue activity through the
>>> parent socket, and lets recvmsg(MSG_ERRQUEUE) on the MPTCP socket
>>> consume queued errors with the parent socket ABI.
>>>
>>> A new prerequisite patch factors the per-flag inet_flags propagation
>>> in sync_socket_options() into a single masked word copy, so further
>>> inet_flags propagated by MPTCP can be added by extending the mask
>>> rather than touching the call site.
>>>
>>> Patch 2 then leverages the existing mptcp_setsockopt_all_sf() helper
>>> for the setsockopt path and extends MPTCP_INET_FLAGS_MASK with the
>>> four RECVERR bits, dropping the family-specific helpers from v3.
>>>
>>> Based-on: <20260424-mptcp-pm-sockopt-set-all-sf-v1-1-38e7023822f8@kernel.org>
>>
>> I didn't review it, but I notice that the CI cannot apply your series,
>> because it looks like it is not based on the one you mentioned here.
>>
>> Can you either remove this line, or rebase your series on top of this
>> other patch?
>>
>> Also, please don't send your series as a reply to a previous posting,
>> please use a new thread. That's what is usually done, clearer, plus some
>> tools don't support replies.
> 
> Note: I just manually resolved the conflicts and sent the series to the
> CI, not to have to resend a series just to retrigger the CI.

It looks like the CI (and sashiko) found some issues with this series.

But globally, I'm a bit puzzled: with MPTCP, there might be multiple
paths being used, and reporting errors about all of them when the
"legacy" RECVERR socket options are used will confuse the userspace that
doesn't (have to) know multiple subflows are being used. In this case,
either messages should be filtered (might be hard to handle all
use-cases and maintain that?), or this should be limited to cases where
only one subflow is being used. Which leads me to this question: what's
your use-case exactly? What are you trying to solve?

It might be easier to have a dedicated MPTCP_RECERR, and eventually
propagate more MPTCP-specific messages. Something that could be linked to:

  https://github.com/multipath-tcp/mptcp_net-next/issues/78

WDYT?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

