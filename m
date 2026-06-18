Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36463C6A2B
	for <mptcp@lists.linux.dev>; Thu, 18 Jun 2026 09:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781775058; cv=none; b=dfNc3dRzuYQw7likHwfk/LqtprDaUt9COK0cVEE0xUKOBV9FeftuYAQ9YWqmajJBvW154etTZKGp61Qb9iRjOd4CrZo0o02nE+TbibuHBmvzESb0Dfusgyddn9t8PPr8QgEQQiol4r5HVY79nYuq3VjaZ5kE/aUc7znh1LwWUSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781775058; c=relaxed/simple;
	bh=neNY1L6ZVXQlvdds7yBHQiASe01uHv63HJbIM6GidZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SoDdHfD3e7UKP8od4tn2gkBTCG+k49qc2Y+VykjW3tFksMysTrjqxEvapjOhp1/n9YkrqTkTqXAYN5cQw2omteexU/Qs+jgo2fYSmz7Zii6XK8NxlD/4zR4dv3cqbT+zkxHCRf0KTxn2WVpP1qH1SOExAXlRh0qZVqJedZhGcSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zl0fg3VX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zl0fg3VX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C281F00A3D;
	Thu, 18 Jun 2026 09:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781775057;
	bh=oDQiH1PhpZT/+W3HEVuQCbwVSDxzHDTjdnQi1JOA3/U=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=Zl0fg3VXxYAQ95sUyooGzoQDrSQFCKlmksG58lh1rGxPxGBs8p640VUJJf74ErA3T
	 fXAD5QKDTbNhsMSHXOO3DuGCScUblI3hOKLTtIfdlaVwEu+2gSJogy8tSCyJ1CIRKc
	 nc+B4N3e1rEPte3Pq/YS0Z0k86DlIdU06QCwbWtEjUPYfIygteTCQUEl+RWVVnA8BZ
	 2krDFPppXSDHuhPL4lKMs+hutWG8Z6VXIBUbMDkgHBvdcv2VapeMvfdram7qsC55+m
	 cLVxz++sSo4/wrh3EQBSGVG8TJUUesIQk94HnNOlBUC4im5hP7X2fNp5Yr1WBA6usr
	 eI8xFZ3DcXCFA==
Message-ID: <f61d6d7c-19ee-466f-b514-77f687392644@kernel.org>
Date: Thu, 18 Jun 2026 11:30:54 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 0/9] selftests: mptcp: skip the v6 subtests
 when CONFIG_MPTCP_IPV6=n
Content-Language: fr
To: gang.yan@linux.dev, mptcp@lists.linux.dev
References: <cover.1781707101.git.yangang@kylinos.cn>
 <5e2e5ded267ad207d84932c653bbfa4b701f5e59@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <5e2e5ded267ad207d84932c653bbfa4b701f5e59@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Gang,

On 18/06/2026 04:55, gang.yan@linux.dev wrote:
> June 17, 2026 at 10:46 PM, "Gang Yan" <gang.yan@linux.dev mailto:gang.yan@linux.dev?to=%22Gang%20Yan%22%20%3Cgang.yan%40linux.dev%3E > wrote:
> 
> 
> Hi Matt,
> 
> As we discussed during yesterday's Weekly Meeting, I’ve quickly gone
> through this patch series thread[1].
> 
> This patch converts CONFIG_IPV6 from a tristate option to a bool. From the
> discussion in the thread v1, ARM-based devices like mobile phones can still
> set CONFIG_IPV6=n. In such cases, our CONFIG_MPTCP_IPV6 will also be disabled,
> which results in kselftest failures even when CONFIG_MPTCP=y.

I don't think that will be the case :)
The trend is more to have IPv6 only, than v4 only.
> Given that, I believe it’s still valuable to mark and skip all IPv6-dependent
> test cases within our self-test suite. 

I don't know. I did a quick review, and maybe the code could be reduced,
but still I don't think such modification would be accepted, and it
would probably be easier not to introduce all these extra checks in the
selftests, and maintain that with new tests that will be added later on.

I do think the best is to talk to people still using CONFIG_IPV6=m. The
thread you mentioned explains why it is likely a bad idea. In short: the
IPv6 module will certainly be loaded very early in the boot process
simply to have IPv6 on the localhost interface. The IPv6 module is just
an overhead, and more prone to (security) bugs. Could you then please
first check if CONFIG_IPV6 could be set to =y on your side, because that
will be the new value anyway when switching to a more recent kernel version?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

