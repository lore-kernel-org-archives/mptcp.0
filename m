Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103241D90D7
	for <mptcp@lists.linux.dev>; Thu, 17 Oct 2024 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158444; cv=none; b=nE6zTOD+h4sHnBQE0SLqIldVwlG9rvC8sHCKoyJdW0k5cCuYe+wgQZZkvW1cN9DwWKcAPxNaCFOLgsra6JSovIVpcbyjZR4CNMoyw1aMxBiNgRotJbP/uKR/WeWgKGsD1860RRUBYXnphpWZTF1QHiOG0nsJGDImDXzXlzLWxpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158444; c=relaxed/simple;
	bh=26Q6xbgmQlLER6jMymKqHY3Ujt5QR8xJAkwzMOU2H/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PWkamGr/5MFrpfqvkY0DZc5IK7tlC7bfRzBifis2zDC/RSxUQRKr6SCjA0t59QGVwOUmCdKEZAW2YttTcv3XHAhlLDcg9OhKTCk4BZYDHhyh7S+SyarNQNpqh9xvlIdc2iTSzt3sEzi0iMq80Fqpndp3sALItFoluM1bEOqwfIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PflZjrYS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PflZjrYS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2E3C4CEC3;
	Thu, 17 Oct 2024 09:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729158443;
	bh=26Q6xbgmQlLER6jMymKqHY3Ujt5QR8xJAkwzMOU2H/M=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=PflZjrYSSTmvVpcMDKKbrTk0GXTr8TmCbN3x9OkrPf4V5DYVHN0VmAwzawkKPX4ZH
	 hxuwD0Pv+lYMhiVPNE5drk9jeQ5rjIfSFJEvdkC7Iw+awyacDYGuTJF+O+2jgiqxw5
	 E8sqlvujZINof95zVxO1uSSeUSinWhBjYsKD139C6l6g1sdNrOR9E6nC0yL8biYVA4
	 866QsHFIHy0ulKpkElYS31/J/v3f+0puk08LgypkF5ZhpX01FJ3SVWAz0TUAT6VJ8o
	 xZKySf9XEWSnYAoBz/0st3zVltykIB+y0Qj58ObWWg6rrI1fZ0oM7Dlc535a75NQNY
	 0BLDDeBb09dLQ==
Message-ID: <17059f40-2948-4db4-82ce-0c82f7d2e492@kernel.org>
Date: Thu, 17 Oct 2024 11:47:21 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 0/2] mptcp: "fix suspicious RCU usage" warnings
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20241016-mptcp-sched-find-rcu-v1-0-5e9af4fbce11@kernel.org>
 <fab2f100-afa1-4b15-b7d8-b8ca267e959f@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <fab2f100-afa1-4b15-b7d8-b8ca267e959f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

On 17/10/2024 11:38, Paolo Abeni wrote:
> On 10/16/24 21:05, Matthieu Baerts (NGI0) wrote:
>> Enabling PROVE_RCU_LIST (and RCU_EXPERT) shows list_for_each_entry_rcu()
>> from mptcp_sched_find() not being used with RCU read lock held.
>>
>> The first patch is a fix for -net. The other one is for a commit that is
>> only in our tree.
>>
>> Link: https://lore.kernel.org/20241016011144.3058445-1-kuba@kernel.org
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Matthieu Baerts (NGI0) (2):
>>        mptcp: init: protect sched with rcu_read_lock
>>        Squash to "bpf: Add bpf_mptcp_sched_ops"
>>
>>   net/mptcp/bpf.c      | 10 +++++++---
>>   net/mptcp/protocol.c |  2 ++
>>   2 files changed, 9 insertions(+), 3 deletions(-)
>> ---
>> base-commit: baccd7675477b1db387aa71b48c3312b5fb67a5d
>> change-id: 20241016-mptcp-sched-find-rcu-649ce3399334
>>
>> Best regards,
> 
> Only slightly related, but mptcp_get_available_schedulers() currently
> acquires both the rcu and the sched_list lock. I think the latter is not
> needed and should be dropped.

Good point, the list is not modified.
I can send a patch for that.

(sorry, I should not have applied these patches that quickly, I was busy
adding 'debug' support for the BPF tests in our CI, and I didn't think
it was too quick)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

