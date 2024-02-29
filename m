Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346087B3D1
	for <mptcp@lists.linux.dev>; Thu, 29 Feb 2024 12:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709209095; cv=none; b=skgBwUTBYmDajjKpuCCtcI1cKIUq5fRsDCQUV06yWp819kHbwkmydYKeSyKQBvp3JhQfz/F/KUbt4jUxghLFij5fVmcZn1fo3gQrF6oX71c2PMSvnF/NuBg3Q5WpsaHK0WOXJzG7HuMc7S6F4qJWshUUMRNLygt3AAA6yo/SD5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709209095; c=relaxed/simple;
	bh=eJYYAtUND4mca7CWYZxhENQ2NwpZ28YL76V68yoIC0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBu9wOHF1XtVif3JrvjwkujD4zXQodjCujTOfGCued+eHwpTKvNWwuFoZG3yNeBbxcxgtfXyOQVo5LA+opxgV4al7ydBjMcQ05B35Va3V/psoFHmNLhH3aGKxMixWEADXvme5hsmON0tWmpuQbKYUXOmmV4D3iUzVMphbWV8m+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mdhdee4M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mdhdee4M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251D9C433C7;
	Thu, 29 Feb 2024 12:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709209094;
	bh=eJYYAtUND4mca7CWYZxhENQ2NwpZ28YL76V68yoIC0s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Mdhdee4MFFkEyS21UcXQE90DTMNvJOsMK4IQUMTbVS6zfAmwqeQEnd5I1pfRttc7x
	 XSLRXjiv1oMGbbqF2EoqSyW/wI9Xp7U7KTP4WKJnObbGl9M492lCiyViXNacIGrciW
	 aQCWRfc23S7AxKiMf4lX3p81SlUro3tILvFGENIDw5UyCZu9EUIH6gQ0DYAVjkP4zI
	 VMvwcJDM0kAP0GxbPF6hadhx2n8de9/1RNvS/Az5qOgoL+wx3JB0aLluhNaYySk47h
	 z94HgWgtxgLUC2jTQFteUdAlGrus9fO8+y0N0ZPC5voM0GzY/MRWjsGwPx+p/joauc
	 UTmwq24v82VJw==
Message-ID: <f30e91dd-efd9-4359-9fda-417214348e60@kernel.org>
Date: Thu, 29 Feb 2024 13:18:11 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v7 4/8] selftests: mptcp: simult_flows: fix
 misaligned output
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
References: <cover.1709200070.git.tanggeliang@kylinos.cn>
 <c5534d2e878f0d776e0f46a28ba6703e0a05abd9.1709200070.git.tanggeliang@kylinos.cn>
 <ZeBXcFdtho6hZUZV@t480> <efe9694c-8792-4fba-a90f-44477e6909f9@kernel.org>
 <ZeByMRcqfKz1s43B@t480>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ZeByMRcqfKz1s43B@t480>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 29/02/2024 13:01, Geliang Tang wrote:
> Hi Matt,
> 
> On Thu, Feb 29, 2024 at 11:27:29AM +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 29/02/2024 11:07, Geliang Tang wrote:
>>> On Thu, Feb 29, 2024 at 05:51:07PM +0800, Geliang Tang wrote:
>>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>>
>>>> The last line in the output of simult_flows.sh misaligns with the other
>>>> lines, and all lines are over maximum 75 chars per line.
>>>>
>>>> This patch aligns them by using the newly added print_title() helper,
>>>> and truncate them within 75 chars per line to allow it to be displayed
>>>> normally in regular terminals without breaking lines.
>>>
>>> This part of commit log needs to be updated:
>>>
>>>     This patch aligns them by reducing the number of spaces before [ OK ] to
>>>     1, and truncate them within 75 chars per line to allow it to be displayed
>>>     normally in regular terminals without breaking lines.
>>>
>>> Thanks,
>>> -Geliang
>>
>> I don't know if the 2nd part of my previous comment was clear:
>>
>>> But also, why not having a wider output instead? Why the 75 chars limit?
> 
> "... to allow it to be displayed normally in regular terminals (80 chars)
> without breaking lines." 2 chars is reserved for "# " added at the beginning
> of each line when running tests in virtme-docker. So I chose 75 chars.

Ah OK, I didn't get that "regular terminals are 80 chars wide". To be
honest, I don't know if this is still true. I mean: I never use a
terminal that is only 80 chars wide, at least 100/120. That's why I was
suggesting to show the full info, instead of trunking it.

>>> I mean: yes, the test names should not be too long. But here, probably
>>> too late to change, only modify (increase) the value in print_title(), no?
> 
> I thinks it's not too late, it's the right time to change this, since
> printing title with test counter increases 3 chars for each line,
> becoming much longer. It makes sense to reduce it this time.

But are we not loosing info? e.g. the last one is already:

  "unbalanced bwidth with opposed, unbalanced delay - rev"

If you remove the last 3 chars for the counter, we don't know the
difference with the previous test.

>> Why having this limit of 75 char? In other words, why not printing a
>> larger title, e.g. 90 chars or more if needed?
>>
>>   print_title() {
>>       printf "%-90s" "${1}"
>>   }
> 
> And the lines is too long already, so it makes sense to reduce it, not
> increase it, right?
> 
> I thinks another option is too keep the length unchanged, not reducing
> it, nor increasing it too.

Yes, maybe better, not to "lose" bits. So increasing the title to be
able to align on the last one, and reducing the "${maxtime}" to save a
bit of space?

About the "maxtime", be careful that "selftests: mptcp: simult flows:
re-adapt BW" patch is "blocked" for the moment. So in net and net-next,
we have something like:

  7384 max 7906
  11345 max 11921

(that's 2 more chars than the current version in our tree)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
