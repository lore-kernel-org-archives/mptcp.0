Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18492C3258
	for <mptcp@lists.linux.dev>; Thu, 11 Sep 2025 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757577770; cv=none; b=HGjR+FtTsYO4lqOn9tMiBuqNXZZ+pi3/g0wKHkzyHxNTiyw83gj0E5zwGZBu+laDAoMR4hlIrNcQ9IgEv4ysz6uOARaljCgG5yawVQkVRJvBRIQj613s+kEhiAbGS6CCJUuUy1b33kbcKPUC+IY5/iIWEY5P/8X5pF8cRw+FcCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757577770; c=relaxed/simple;
	bh=1RA62wHr8CoXR5n6RYfFpqsZ+lrlI9RxYironCdTfcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tbe9Gq0K21yDocFmCkhONxTheZ3Soizt765J1uKXYnlW0Cowln1W1gNtg/IZWzKY3eWgMK/u5x5Thnsqw1hI/yQCsrDLDapTDazjxwHstlhizQ/WEHMgPQQY724/Umojq7lOfsit5p+mQvmFHh1KkmZDdtK5oNXvrMW7NU2UzrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzm/IbMK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzm/IbMK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093EFC4CEF1;
	Thu, 11 Sep 2025 08:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757577770;
	bh=1RA62wHr8CoXR5n6RYfFpqsZ+lrlI9RxYironCdTfcI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dzm/IbMK+E8ULQdlb4oYVEjp7GX5hoK5mNzzAUj0SROzGvya9usQI76tXdIhuDoRm
	 C4iMARQAikeFhd3KmlTwkwDNYG4TWF+Gm8KbIuvaPHlp8TNoNdhBPMIn7MSXsE27ns
	 E/oFN/ewGNZceBX3i8c5aRBOYJYPp12BQZIWhoSBO3o7dk732pOVFHI5mIiR0VL8Nm
	 Adv3Na4SHrCxGPMOVwW5cq/IWFwuKA+YR5nAST1xHI9vt7dCxb3ajYmnjjTVEerYfR
	 Kf7W6XDm8Pum/UU1gAAgg/Z2jcjF4KUNwi+0z4lZ9mHup/igDpklMwBliE7da1Ydan
	 x/jjrvHsXssgA==
Message-ID: <c3d5dc57-ebd3-49a8-99e4-a40910ec85d8@kernel.org>
Date: Thu, 11 Sep 2025 10:02:45 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v3 0/5] selftests: mptcp: avoid spurious errors
 on TCP disconnect
Content-Language: en-GB, fr-BE
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20250910-sft-mptcp-disc-err-v3-0-6799fa467d77@kernel.org>
 <13b53a08-0be4-fdf7-d8ef-58671c96e964@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <13b53a08-0be4-fdf7-d8ef-58671c96e964@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang, Mat,

On 10/09/2025 21:03, Mat Martineau wrote:
> 
> On Wed, 10 Sep 2025, Matthieu Baerts (NGI0) wrote:
> 
>> This should fix the recent instabilities seen by MPTCP and NIPA CIs
>> where the 'mptcp_connect.sh' tests fail regularly when running the
>> 'disconnect' subtests with "plain" TCP sockets, e.g.
>>
>>  # INFO: disconnect
>>  # 63 ns1 MPTCP -> ns1 (10.0.1.1:20001      ) MPTCP     (duration  
>> 996ms) [ OK ]
>>  # 64 ns1 MPTCP -> ns1 (10.0.1.1:20002      ) TCP       (duration  
>> 851ms) [ OK ]
>>  # 65 ns1 TCP   -> ns1 (10.0.1.1:20003      ) MPTCP     Unexpected
>> revents: POLLERR/POLLNVAL(19)
>>  # (duration   896ms) [FAIL] file received by server does not match
>> (in, out):
>>  # -rw-r--r-- 1 root root 11112852 Aug 19 09:16 /tmp/
>> tmp.hlJe5DoMoq.disconnect
>>  # Trailing bytes are:
>>  # /{ga 6@=#.8:-rw------- 1 root root 10085368 Aug 19 09:16 /tmp/
>> tmp.blClunilxx
>>  # Trailing bytes are:
>>  # /{ga 6@=#.8:66 ns1 MPTCP -> ns1 (dead:beef:1::1:20004) MPTCP    
>> (duration   987ms) [ OK ]
>>  # 67 ns1 MPTCP -> ns1 (dead:beef:1::1:20005) TCP       (duration  
>> 911ms) [ OK ]
>>  # 68 ns1 TCP   -> ns1 (dead:beef:1::1:20006) MPTCP     (duration  
>> 980ms) [ OK ]
>>  # [FAIL] Tests of the full disconnection have failed
>>
>> Patch 3 fixes this issue, but a fix in MPTCP in patch 1 is also needed
>> to fix MPTCP behaviour, and simplify patch 3. Patches 2 and 4 improve
>> some errors reported by the selftests, and patch 5 helps with the
>> debugging. I guess all these patches can be sent to 'net'
>>
>> Note: Patch 1 will cause errors in Packetdrill, that's normal, see [1].
>>
>> Link: https://github.com/multipath-tcp/packetdrill/pull/171 [1]
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Changes in v3:
>> - Patch 2: close some FDs in case of errors (Geliang)
>> - Patch 4: mention there are now more bytes (Geliang)
>> - Link to v2: https://lore.kernel.org/r/20250905-sft-mptcp-disc-err-
>> v2-0-dfb3b6b4a877@kernel.org
> 
> Hi Matthieu -
> 
> Patch 5 I acked separately, one minor fix in the commit message but no
> need for v4.

Good catch! Fixed!

> Patches 1-4 LGTM. Even though it's possible (in patch 1) that a shutdown
> may be attempted on a subflow that doesn't need it, tcp_shutdown() has
> the logic to handle that.

Indeed, that's why I didn't add extra checks before calling
tcp_shutdown(). I just added this note in the commit message:

 Note that tcp_shutdown() will check the subflow state, so no need to do
 that again before calling it.

> Reviewed-by: Mat Martineau <martineau@kernel.org>

Thank you for the review here and in the packetdrill PR (applied and
backported)!

Now in our tree (fixes for -net):

New patches for t/upstream-net and t/upstream:
- 8cc6e542f150: mptcp: propagate shutdown to subflows when possible
- 07cc3161a4a6: selftests: mptcp: connect: catch IO errors on listen side
- 4f6152573302: selftests: mptcp: avoid spurious errors on TCP disconnect
- 42c1206d2751: selftests: mptcp: print trailing bytes with od
- 83fd25a7e401: selftests: mptcp: connect: print pcap prefix
- Results: c62821417a96..c3bb5aa20b8e (export-net)
- Results: 623fb42fecc5..6ff9d54223e3 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/b6b24ce1bd89c893d3e7f9262f7a9b92aaa19736/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/bf5738cace8ab21e5bba9ebe1d8fa7175407f222/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

