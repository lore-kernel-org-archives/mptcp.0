Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3660A383986;
	Tue, 12 May 2026 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592151; cv=none; b=Nf4H/ddLIxVghRbQaLsBYWNXhEABmvrmme/oz7s8ZpSUXrX6tvUAaGVfeDKzpNVdkZz/FVua+keaFf9VyLDv8vnj12qfWtnyF/V2uXWMzgkeXpxx4v7oU7t923y4oO8Sd2VjDOslXY4BtsfUBvAv/f+vhOPY6uDv7Bc9D+LM48E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592151; c=relaxed/simple;
	bh=FNuf7M1vdOgHagEGaNCNEiJ3iCELXDAsc/C5AjbequE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UdVgHDKz2f5NryfPJUOSY0fxsPlY1FA/lsqKCJjsj7ccoaut8Ywv3025tjpgfw4gjkEb0EpLeCaYWWEebPPDOC/QHuZElLDfMLauQcl9TeB35i5N4XTe5he/If3E5Mba8HnWBmt18PIDIDJZzVs1P0FtXFy0QZjG2Nysv3NOdTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHUrMVzW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHUrMVzW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E690C2BCB0;
	Tue, 12 May 2026 13:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778592150;
	bh=FNuf7M1vdOgHagEGaNCNEiJ3iCELXDAsc/C5AjbequE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GHUrMVzWZ1mnwsMr6mZALcWQOUjwz0I15yA7G0VpxdtOp+wtyXghafYxfMZ/oU6yw
	 XwwJpOClcwyuhvFAHyQFdp9sM9XvZad0CeoK0OQ/8uT8Uv6BfXN8m24krLHIsUlcL4
	 gaWSo5QsNDo6EDd0tT+cSSi2gktDsKd8LkCkCJ0QpMaT7D5Essw0DX4MKBnm1XPlKM
	 RzVpDQE2ujSXRI5fcC3s7QbembovEUO8FxujgUkGVXP0ztw6+p81uIy16XM2JRGUm1
	 mSQVrDhVQscv3pJCEGdNfkeROGuBtxzuxMMNOEzOXJUvhLRaOYf5e/9asv7QMoD/aL
	 3+izIMx4pp2SA==
Message-ID: <a009da4e-35bf-4db1-b722-693a796f602d@kernel.org>
Date: Tue, 12 May 2026 15:22:26 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [syzbot] [mptcp?] KMSAN: uninit-value in
 mptcp_established_options
Content-Language: fr
To: Alexander Potapenko <glider@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, kuniyu@google.com,
 syzbot <syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 syzkaller-bugs@googlegroups.com
References: <69f8e352.170a0220.bb392.0005.GAE@google.com>
 <2a9bde65-d2de-44cc-9192-e7aa8a0935a7@kernel.org>
 <672f5b7d-6fa0-41c5-a950-2890028c8572@redhat.com>
 <CAG_fn=Ud-sXzebnwvsiwnu6e0uOHRAFzmUH91Du9pek7Fsx5bA@mail.gmail.com>
 <43a84c8c-0d65-400e-b735-76210af4cddb@kernel.org>
 <88d94464-9391-49f4-848f-f359b09b0500@kernel.org>
 <CAG_fn=Wq87q5wGZt6_c_jutS1yKC+Yv1CsOOfcO03pZBVWzTdg@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CAG_fn=Wq87q5wGZt6_c_jutS1yKC+Yv1CsOOfcO03pZBVWzTdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alexander,

On 12/05/2026 11:31, Alexander Potapenko wrote:
>>>>>> Plus I'm not exactly sure to understand the issue here: mp_opt is
>>>>>> defined and used only in mptcp_incoming_options(), and I don't see
>>>>>> anything using it after the end of this function. Or did I miss something?
>>>>>
>>>>> I also had hard time understanding the backtrace, I think some frames
>>>>> are omitted/missing (it happens sometime, IDK why), specifically the one
>>>>> related to mptcp_options_received() - which would be useful to
>>>>> understand the issue.
>>>>
>>>> This is probably related to
>>>> https://lore.kernel.org/all/69e7ee1f.a00a0220.17a17.001d.GAE@google.com/T/
>>>
>>> Ah yes, it looks similar.
>>>
>>>> Let me send the patch, perhaps this issue will also go away.
>>>
>>> That would be great, thank you!
>>
>> Thank you for having sent your patch.
>>
>> Here is one combining your modifications, and the ones from Paolo, for
>> syzbot. If this one is OK, we can continue with Paolo's patch.
> 
> 
> Hi Matt,
> 
> Unfortunately my approach was wrong: see tglx's response there.
> Hope we'll figure something out (__no_kmsan_checks looks promising)
Thank you for your reply, I just found the email thread you mentioned:

  https://lore.kernel.org/all/87v7cu876c.ffs@tglx

If a v2 is not expected "soon", I'm sure we can continue with Paolo's
patch, and double-check later to see if it was enough.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

