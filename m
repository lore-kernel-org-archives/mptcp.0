Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396123603DD
	for <mptcp@lists.linux.dev>; Tue,  2 Jun 2026 06:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780383572; cv=none; b=ZcDUEMyMTSvD2x21eXBc+vj80zAq7KtRWDpd6s0WQCpYJmoq8YTk8xCOvjXEVzyg5nA7tbtT3IAQXgEvH8b2WnHbkYaIlukclQvv4l7ne6yXRNjo7CvzEaNnD/3yFWdWAASsMOeikMi4dUE9q8R8poUwMDWXr1oFlraL3UTUEdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780383572; c=relaxed/simple;
	bh=zs6cJxRjRiAvCSRB63u9fVnfJUTBHWnUZu0/4015mm0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=edb5ujUg3A6SJY8QSHQgXPcyKhQFdYYICw5Y3M7+UmvO4Q14j78QITqZN4xeJGID8BbnsuYFca87+swFrb+qVIRu+0US+C2jUsDb32XFyXvLF/Vc5WO08QVZF1L/tolesmIZeuPmudFPz+3aHdJBAZJtJ0sAS0BZf+p/kje5fj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNqLCT/b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNqLCT/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D8C1F00893
	for <mptcp@lists.linux.dev>; Tue,  2 Jun 2026 06:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780383570;
	bh=77/ulHSs4GjU6coYm265if/8r9kdwE+p0wsjKmYeDO8=;
	h=Date:Subject:From:To:References:In-Reply-To;
	b=ZNqLCT/b7nQxHJyrdTbpsLP9527OSBcNhL5nNUhXSKS7igIswIDXZ8Gcp/Q9WpSF0
	 iaTUiNgmca5ZGjhMvcuKlGPo3ivBRtI+X0GJvdjLc1XQSf1GX1EEhxyy/2pgI2xrZa
	 qZNBEQN9aDJ0KGLaUsnih2PSMCzlWnMiG+5HJv4/HkAJMNhX6Id0ZioQLsmzNbj+0k
	 24rP7GBYs868JSsrAwmymDwnNZXHcDC4EB5AfOjCKDBr73JHd8G+oKj03gigJqn1IP
	 DeNADMKLY5kg+Rc8AaMF3GZx+KbDlOXfdBTaqi4yikIwyg6eHgRs8e+5YuZK1P1pIx
	 UGRQ2Dx8q8sIA==
Message-ID: <0bab614d-ae6a-4ade-abf6-ffa62fab22f2@kernel.org>
Date: Tue, 2 Jun 2026 16:59:27 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 0/4] Fixes for "mptcp: pm: drop TCP TS with
 ADD_ADDRv6 + port"
Content-Language: fr
From: Matthieu Baerts <matttbe@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
References: <20260601-mptcp-add-addr6-port-ts-fixes-v2-v1-0-d7c842e80446@kernel.org>
 <1294ddc5-94ec-4667-8765-baa184df0f32@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <1294ddc5-94ec-4667-8765-baa184df0f32@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/06/2026 16:31, Matthieu Baerts wrote:
> Hello,
> 
> On 01/06/2026 18:27, Matthieu Baerts (NGI0) wrote:
>> This address Eric's comments from [1].
>>
>> Note that the CI will complain that not each patch can be built
>> individually. That's normal: the fix from patch 2 has to be split in
>> patch 3, to be applied in the right commit.
> 
> I'm going to apply patches 1-3, because they have been requested by
> Eric, I guess that's fine. After that, I will apply Eric's patch [1]
> with the small fix in our tree, resolve conflicts, and send an extra fix.

*Eric's patch*

New patches for t/upstream:
- ab84e16ad93d: mptcp: change mptcp_established_options() to return opt_size
- 1ac623cbe9db: conflict in t/mptcp-options-suboptions-sizes-can-be-negative
- 5876b14f5c8a: conflict in t/tcp-allow-mptcp-to-drop-TS-for-some-packets
- 3dfc91dff1d0: conflict in t/mptcp-pm-drop-TCP-TS-with-ADD_ADDRv6-port
- Results: 7676d254f320..00d928af360b (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/c7e8a9cddd2beb5eae02e8af51de83483f6b25aa/checks


*Squash-to patches*

New patches for t/upstream:
- 2889b65f2e3a: "squashed" patch 1/4 in "mptcp: introduce
add_addr_v6_port_drop_ts sysctl knob"
- 8d5986a8c346: "squashed" (with conflicts) in "tcp: allow mptcp to drop
TS for some packets"
- f1a8e699dcb7: "squashed" (with conflicts) in "mptcp: pm: drop TCP TS
with ADD_ADDRv6 + port"
- Results: 00d928af360b..39cfd0474a57 (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/3c61701c6140a3b53e64a488ba135da8470d5de4/checks


Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

