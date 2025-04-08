Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CD4267704
	for <mptcp@lists.linux.dev>; Tue,  8 Apr 2025 10:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106527; cv=none; b=jFkAOKM9mDIk6sFPnD3FUrtBX2vpJCpIQSaAYJoL4IL2CZ5TPzePDJL+maYwS8E/18SRmlBAoSSx0ndDuUDyPwo2487PMuMStivy9Hg/fVTkHo+dLMa+Ujm+PY7p0iilyWWgNOxqnkDpMr1yslCdRQKF9f0HjKEOJE9zDJNhTIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106527; c=relaxed/simple;
	bh=gZntUJPbGt02ptbTJ7eooEvMUQPFHvSvl9ui8MrlOBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6/eCj3YHgt4Lc1hxJMVqdoVQPPswT19RTRPNm6iGF5lEiT3YSr7VA+zyfbr5nizlINM7ToP10EsLRr3XS4+dlUxJAf33lR5Hr+WJ7rQHhH4oa9yCkieurh2RoAD+Bo/MtLp4XME3O/qg4jU7nLgq0KT80RnZ/jpluAXQs02UZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7rCHQY+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7rCHQY+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AB0C4CEE5;
	Tue,  8 Apr 2025 10:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744106526;
	bh=gZntUJPbGt02ptbTJ7eooEvMUQPFHvSvl9ui8MrlOBc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=G7rCHQY+4h6GVPSzJROK2+gAYEZCpdQuiUh8MLMx+3jR2nHGeTAyArd03I6RilMkE
	 OU0B/8Pi1UjByw2IiSKTEOTTNgGNB1oPEoyz1nIpE97eJrvmFosdNyMVveJNtRtBWX
	 VzmqO+YUVHHcrRs1ukmp73ZOfVMRMaEOGrF7jDRNXyFzGlDYcufJhFvHwsKVpvPqNr
	 iHOEUYD+W6/CtXM/QNZlUdZzFVv/jm2FhX4L8UmvClZigjGZW4nLxjnsJZ4HjrgpZh
	 w1pBwacIoyzWIE2FM9syUE76GdRP1u/D6phNNeiaMF+7k7lzVbr9lME+XrIdwQycUU
	 gHcFAyrveD5FQ==
Message-ID: <94302e22-13c0-43c6-8f63-64fdce93986e@kernel.org>
Date: Tue, 8 Apr 2025 12:02:04 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 1/2] BCC: Python: Support 'fmod_ret' method for eBPF
Content-Language: en-GB, fr-BE
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
References: <cover.1743988616.git.yangang@kylinos.cn>
 <766ea5e9772f92d97100f8b52e70b2895c3de628.1743988616.git.yangang@kylinos.cn>
 <851297ad-5e66-4374-9914-cd48868c4c7b@kernel.org>
 <20250408015649.GA21239@yangang-pc>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250408015649.GA21239@yangang-pc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gang,

On 08/04/2025 03:56, Gang Yan wrote:
> On Mon, Apr 07, 2025 at 11:07:41AM +0200, Matthieu Baerts wrote:
> Hi Matt,
> 
> 
>> Hi Gang,
>>
>> On 07/04/2025 04:37, Gang Yan wrote:
>>> In kernel, there exists a lot of 'fmod_ret' functions, such as
>>> 'update_socket_protocol'. But it cannot be attached in BCC-python
>>> directly, so this patch provides an interface for Python to use
>>> 'fmod_ret' attaching method.
>>>
>>> Signed-off-by: Gang Yan <yangang@kylinos.cn>
>>> ---
>>>  src/python/bcc/__init__.py | 43 ++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 43 insertions(+)
>>>
>>> diff --git a/src/python/bcc/__init__.py b/src/python/bcc/__init__.py
>>> index 8bc85516..96de3d40 100644
>>> --- a/src/python/bcc/__init__.py
>>> +++ b/src/python/bcc/__init__.py
>>> @@ -461,6 +461,7 @@ class BPF(object):
>>>          self.raw_tracepoint_fds = {}
>>>          self.kfunc_entry_fds = {}
>>>          self.kfunc_exit_fds = {}
>>> +        self.fmod_ret_fds = {}
>>>          self.lsm_fds = {}
>>>          self.perf_buffers = {}
>>>          self.open_perf_events = {}
>>> @@ -1157,6 +1158,21 @@ class BPF(object):
>>>              return True
>>>          return False
>>>  
>>> +    @staticmethod
>>> +    def support_fmod_ret():
>>> +        if not BPF.support_kfunc():

(I don't know if this dependence is needed here.)

>>> +            return False
>>> +
>>> +        kernel_version = platform.release()
>>> +        major, minor, _ = kernel_version.split(".")
>>> +
>>> +        if int(major) > 5:
>>> +            return True
>>> +        elif int(major) ==5 and int(minor) >= 6:
>>
>> Was it not introduced in v5.7 instead of v5.6?
>>
>>   return int(major) > 5 or (int(major) == 5 and int(minor) >= 7)
>>
> I think v5.7 is right, the 5.6 is from the bcc repo:
> 
> bcc/example/cpp/KModRetExample.cc:
> 	 * Kfunc modify_ret support is only available at kernel version 5.6 and later.
> 
> Maybe this is also need to be fixed later?

Maybe this bit is supported since v5.6 and fmod_ret from 5.7? I didn't
check.

>> https://lore.kernel.org/20200304191853.1529-1-kpsingh@chromium.org
>>
>>
>> But also, it feels wrong to look at the kernel version, in case of
>> backports, etc. Can you not look at something else? e.g. kallsyms?
>>
> 
> Do you think we can do this after making a PR first?

I don't know the BCC project, but I think checking the version will not
be accepted. I think it would be better to do something like that instead:

  @staticmethod
  def support_fmod_ret():
      # It is not clear what can be used to check if 'fmod_ret'
      # supported by the kernel. Assuming checking kfunc is enough.
      return BPF.support_kfunc():

And add a note about that in the commit message, asking BCC devs for
ideas. You can also say you considered checking the kernel version.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

