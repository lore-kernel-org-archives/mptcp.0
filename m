Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E419315F308;
	Sat,  7 Sep 2024 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725723788; cv=none; b=DxD9Sm9FL3VBgteh28SAsVtVJyyl7E3Y+pg+hyTym9zMv6WXQR+5eqNBZVZadIDYXkvzQHKM/N0jXc3iNZHeVXXOY9T5kjqfIaFisWuIbbz4DhA6VwMxDK9q/ug/DMgSy/mNiIXg84I1kV9PPN9xkPVlUYrg+LM1L6UQzE6P1us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725723788; c=relaxed/simple;
	bh=08twX4UQNWgzpSje5WMUvhmLZ8rSu3to6AH0oOdogac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRJUeXTe3d0wNpU3xEFFRME3OfFvYAiTnxpZwAWHd70qdCzRBek4ZkIYM0JlKcAVRekcArd9qsmNeaCbVS+tlDW3i3BgD4gEM2gTyV7XCdxC2aotxrIByMIv7EuIs6gisKOvage5jXH9NhbzHMAAECmt6YUYQCGkqj09tct8+j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9qFeI7L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9qFeI7L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A5FC4CEC4;
	Sat,  7 Sep 2024 15:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725723787;
	bh=08twX4UQNWgzpSje5WMUvhmLZ8rSu3to6AH0oOdogac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K9qFeI7L5U0cAPijk1FxysMlXiqQbk8ZE0j1Zwtr+AApsYxhCidbZs3UjAGLxyimQ
	 BTA7LsRdbazz4oJsPSRiT6kM9ZN0VFEO0GGZU0h8AlWz6DY7B70X/wbkrSQH/H2Vow
	 7V6Mrb9uoSOty4+rvgQmZphDUgY0fYIgx70dIcCRUR4vJz5An5EdQppiTb6hFVHRwl
	 fgdAoaxPPypM/bmFxXlJtutdQ5NxYxuZzO9XTxQBkJxy05lpGmbCZIBWL0fZwgIuZL
	 i8PfIOa1gMnOTmZ1RMhagtVbvLV2dcHwK2LEv2BjGuZqGdQDNedvKFGfQGN5MBNJoH
	 2H/n2i9OJtsWg==
Date: Sat, 7 Sep 2024 11:43:06 -0400
From: Sasha Levin <sashal@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: MPTCP stable backports: is the workflow OK?
Message-ID: <Ztx0ii15ulDATpUK@sashalap>
References: <32148274-08bb-4031-a55b-6b16b48a5497@kernel.org>
 <2024090642-viewing-happier-23b8@gregkh>
 <be29b0d9-83be-4947-912e-8d9f5b8f5f9c@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <be29b0d9-83be-4947-912e-8d9f5b8f5f9c@kernel.org>

On Fri, Sep 06, 2024 at 12:10:22PM +0200, Matthieu Baerts wrote:
>Hi Greg, Sasha,
>
>Thank you for your reply!
>
>On 06/09/2024 11:56, Greg KH wrote:
>> On Fri, Sep 06, 2024 at 11:36:25AM +0200, Matthieu Baerts wrote:
>>> Hi Greg,
>>>
>>> Thank you again for your support when we send patches for stable
>>> versions for MPTCP!
>>>
>>> Recently, I sent many patches for the stable versions, and I just wanted
>>> to check if what I did was OK for you?
>>>
>>> I tried to reply to all the 'FAILED: patch' emails you sent, either with
>>> patches, or with reasons explaining why it is fine not to backport them.
>>> Are you OK with that?
>>>
>>> Or do you prefer only receiving the patches, and not the emails with the
>>> reasons not to backport some of them?
>>>
>>> About the patches, do you prefer to receive one big series per version
>>> or individual patches sent in reply to the different 'FAILED: patch'
>>> emails like I did?
>>
>> One big series, per kernel tree, would be ideal as that way I don't have
>> to pick them out and guess as to the order.
>
>Sure, I will do that next time, it is even easier for me.
>
>I sent the patches in the same order as they are in my working branch,
>but I understand they could be received in a different order.
>
>> Also, if you don't respond to the FAILED emails, that's fine with me, I
>> don't keep track, but maybe Sasha does as I know he does backports based
>> on them at times.  So I'll let him answer that.
>
>Thanks! I will wait for Sasha's reply.

Doesn't matter on my end :)

-- 
Thanks,
Sasha
