Received: from mta0.migadu.com (out-111.mta0.migadu.com [91.218.175.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D873BB69D
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 08:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425884; cv=none; b=ZBjCJcRetcClyMpqF/OXC/De6sUdnHGhG61Yj8HjQV0XdgchnrlYcVvs2jA6x28mWagQJ1ibsPCo+IoCCnyEwzQlJzmIGLxv2L9B29yqTo4BgbEjcgulj5ZhhSmlOmMPcUZf8/BBNV5CUGA78RxH/CeV5uWZpy02Whq18m8sTLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425884; c=relaxed/simple;
	bh=Lw3OLnHeyZOT0FN7YgF/sIZ5uk6xKMs8ikSX0szJiZk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p9nV0goOOIg4zuVEiV4KJAK6G6wMOXT1TW+po9FX/SrfR/SKzSSMGMgbojrjSN5meOoQi2HJd4Y4m2nz7ZnPJeXmZCQwlUlQ+4u0bCSsOTKM85buz4WS7Dn/LlaOVkf4y5JFbdgqCxl0TpXBenNToYIlo4gSR65rWsucdXgS8Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CT/4QreS; arc=none smtp.client-ip=91.218.175.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CT/4QreS"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=Lw3OLnHeyZOT0FN7YgF/sIZ5uk6xKMs8ikSX0szJiZk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788425880; v=1; x=1789030680;
 b=CT/4QreSJdDgUrZirfC92QrSpGQ/WuezhytuBEqjqJPiI1klPzwvUMLHd7cEnhtOYENkxwIt
 oDirTaxuHr1WpgFM8otg1QDWGMq4XyDnEWpJS+kD9bx4TKVKiC/U1hXbkCAsM75xhH50w69X/m2
 2daIZpW2KV7NQ7VTgh8eHACs=
X-Envelope-To: mptcp@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 2e751ee37d4a2c68;
	Thu, 03 Sep 2026 08:58:00 +0000
X-Mizu-Trace-ID: 2e751ee37d4a2c68
X-Migadu-Flow: FLOW_OUT
Message-ID: <b898ed5f-702f-4b22-9af9-7f79b111ae77@linux.dev>
Date: Thu, 3 Sep 2026 16:57:56 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, mptcp@lists.linux.dev, geliang@kernel.org,
 cuitao@kylinos.cn
Subject: Re: [PATCH mptcp-next 1/2] mptcp: pm: bound extra_subflows admission
 on userspace PM
To: quanyeyang <quanyeyang@proton.me>, Matthieu Baerts <matttbe@kernel.org>
References: <20260831093206.689827-1-cui.tao@linux.dev>
 <20260831093206.689827-2-cui.tao@linux.dev>
 <c8c4f667-5d25-4d94-8627-387d4091c8c4@kernel.org>
 <U6pTh6EPoeSgwE2EHl9q6Urj4YiZFTfOINajSmMtooO9YzNmfQXdeB4pXt8P9Nh6FjtZrqjgs50Rlkxdm5Hyfgz65nUYNcmwmV76PVrTeUY=@proton.me>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <U6pTh6EPoeSgwE2EHl9q6Urj4YiZFTfOINajSmMtooO9YzNmfQXdeB4pXt8P9Nh6FjtZrqjgs50Rlkxdm5Hyfgz65nUYNcmwmV76PVrTeUY=@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Quanye,

在 2026/9/3 11:42, quanyeyang 写道:
> Hi Matt, Tao,
> 
> On 02/09/2026 18:36, Matthieu Baerts wrote:
>> So, at the end, we can re-used the same version as Quanye. Would it be
>> OK for both of you to have a Co-developed-by tag here?
> 
> Fine with me. Please reuse `ret` and drop the comment in v2, with
> Co-developed-by tags for both of us.
> 
> On 02/09/2026 18:52, Matthieu Baerts wrote:
>> Maybe a goto could be used here ... to here, not to modify the rest
>> of the code?
>>
>> Would it be OK for both of you if this part of Quanye's patch is
>> added to Tao's v2 series with Quanye as author?
> 
> Also fine. Please take the Netlink extra_subflows cap in v2 with me
> as author, using a goto to the existing error cleanup instead of the
> else-wrapping I sent.
> 
> I will not send a competing series.
> 

Thanks for having a look at this too, and for making the
coordination easy.

You're right that the Netlink path was still open in my series,
good catch. I'll take your patch into the v2 series as we just
agreed, with you as author of that part.

Happy to share this one with you.

Thanks,
Tao

> Thanks,
> Quanye

