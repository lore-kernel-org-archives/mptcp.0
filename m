Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214E52110
	for <mptcp@lists.linux.dev>; Fri,  8 Aug 2025 12:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754657240; cv=none; b=Zf4F36vqbHOSSr2EvHSaNkCAy3ZPyUnDcVuGg/Md259fbBC0acyJ+0XcmdWkEY30nkg7MqGstSY2UITZI+xg0ddAlLq4qZUdZ543SVgsj+bVziWAwW1ddhgD35misoSB48xEM51PrrWjX0uZysAKg5YBsLFkSydZ7SBPDhBvjBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754657240; c=relaxed/simple;
	bh=eojbkIBC083LYF9l2Um6ycWSow17E4uZxVppSh0bt2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTPddVnlXfhKvwGAL56rxV35ZH/qHPyO64I9+fEBFV8ZOtYADL9uQALlws8a1oe1XL5VR78/4Kvss4QaM70SRP7B4oQ3vP39XsHniWwWiLWnF/JclkUzhg0831moAkF5Y1fKn4B/07ozKbVoy6tf/MuCNNq544t8Abr+NtVYFNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubsRc+iZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubsRc+iZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD55C4CEED;
	Fri,  8 Aug 2025 12:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754657237;
	bh=eojbkIBC083LYF9l2Um6ycWSow17E4uZxVppSh0bt2s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ubsRc+iZj4GewzKxl4uWAc5fw5BE5KydWXZdA1qAIiPLvAverVgb3oCyfKMSo8vgU
	 3w2QpYBehnQ1CpoYSy98F4BEYVXY1JYw8oOOn3B5BirDrF0UmH/Zz6VEAVpwdlu4F4
	 5GoKsfdQu06rQV9k7VVMsSwG4YUmLaGnUg8kmOvbQoTFWJcZaqIw/IMNoUwFlTBoBk
	 WjlaZamvtFmOS1O4B2uUirBWmt8XchMPpZBKjrV6n02EGA/6LpFEMZ4/8m5++pkFmH
	 oKkoyxSir/pLQz9pMu/Pmc3wRFmhBLVkA0+/mMDp6Jo8nSvBMV564xtWA2yz4VgCNT
	 2tEH+VbYXFhsw==
Message-ID: <cfe07742-5470-4991-854a-0c6067af35d6@kernel.org>
Date: Fri, 8 Aug 2025 14:47:14 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: .b4-config in export and export-net
Content-Language: en-GB, fr-BE
To: Christoph Paasch <cpaasch@openai.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <CADg4-L8X3_O5O67NfcE5PUeNWWDBqa1cbQ0L9L0Ti_Mn-m-7Jw@mail.gmail.com>
 <f833716b-32e5-4ec8-845c-294c519e1b2e@kernel.org>
 <CADg4-L_wscbqmn_D+SjwYsgnJPP9AcVire4Ae4AjMMzoZyaFaA@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CADg4-L_wscbqmn_D+SjwYsgnJPP9AcVire4Ae4AjMMzoZyaFaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/08/2025 19:51, Christoph Paasch wrote:
> On Thu, Aug 7, 2025 at 10:03 AM Matthieu Baerts <matttbe@kernel.org> wrote:
>>
>> Hi Christoph,
>>
>> On 07/08/2025 18:35, Christoph Paasch wrote:
>>> Is there a reason we have the .b4-config files ?
>>
>> Yes, to help people using 'b4', to use the right prefix and to send to
>> the ML (no need to run --auto-to-cc)
>>
>>>  And specifically them having the same name ?
>>
>> It has to have this name for b4 to work as expected.
>>
>>> Because, when managing different branches based off either export or
>>> export-net it creates a conflict when merging everything together to
>>> have a single branch with all my changes.
>>
>> export and export-net share the same history:
>>  - export-net is on top of net
>>  - export is on top of net-next, but merged with net, "almost" on top of
>> export-net
>>
>> In other words, why do you need to merge both?
> 
> I have a branch with some fixes (based on top of export-net) and
> another with a feature (based on top of export).
> 
> When I want to run tests (or in general do dev-work), I want to do
> this on top of all my branches together, so I merge them.

It makes sense.

Personally, I usually only create branches on top of "export", because
"export" is already on top of "net" (synced daily), so no need to be on
top of just "export-net" most of the time.

>> Please also note that these branches are rewritten regularly. You might
>> want to use 'for-review' and 'for-review-net' if you want a continuous
>> history.
> 
> I rebase my branches on top of export / export-net / ... regularly.

Excellent! A regular user of 'git rebase --onto' then :)

>>> Would it be possible to have .b4-config files with different names for
>>> export and export-net ?
>>
>> We cannot rename them. We could remove them, but I think they are
>> helpful. If you need to use these branches, can you not add an extra
>> commit removing these files? Or a '.gitattributes' to give instructions
>> about how to merge these files? Or pass that to 'git merge', or use
>> rerere, or ... :)
> 
> Ok, .git/info/attributes does the job for me.

Great, easier!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

