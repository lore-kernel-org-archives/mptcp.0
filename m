Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DEC1C9ED1
	for <mptcp@lists.linux.dev>; Thu, 10 Oct 2024 08:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548552; cv=none; b=DHOU/9J5bGOXPra7nXNw+yjqks1Elve4r7RkuzGwAfRA0l5EM4p+73k5jQ9KLrJThu2Md8r2544zo3d5jynMO9SCULhHufPeu60vSAzUp/uZ7aBVbMAgck85TOaCIT4jM9MjqemG4jRCtwoeARUnsdrG0ez10t3BfL88mmSS2Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548552; c=relaxed/simple;
	bh=iJnnRZWESR70Zdf3nk+0Qc20u4zJR7vB7sz7FhJ73nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sT7yhIgnO0hvSuXIQg4zjzTVg8GSoy608X2ihaAoYsCqofH8u2xq5Ays0stlHJtten1fbPtwoXhzyj4yG5IOJTb0h5qwGtTz33UbGR8JCGYDKl6NG2rGzvLtg5ilfdwMNeWpFJt+a5dchOj3rsM0oz8mR50oSKpC5KWUT98eZZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BILRr9CR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BILRr9CR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50B9C4CED1;
	Thu, 10 Oct 2024 08:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728548551;
	bh=iJnnRZWESR70Zdf3nk+0Qc20u4zJR7vB7sz7FhJ73nc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=BILRr9CR1jRDwZX7e99C54xLrHl4rLifrGz6EtaPdY/MEwKnnSlw/dPSYdTVtlJSw
	 ECqeyFT5oXq3GLcpWodl96G/K61X6jFJN08lPfcy6l6DvaXM5PCfndD55eLAlSxBvL
	 qH9Y6eDUlFFMvj+UPOzpLuVIft8uZ0eh3OCR830i3K4UUOa3WdlV/U22V660sGdTzi
	 hpzB0OIXNPbdYsY+qVLHK+cwCjtSssLJXCK+eZLcCmYpe6mM/vG3o+udPqmPGL8YRR
	 tx7If6B2zi9FmGadT4RDahlQMGHw0DaX9P/kg+yf9/dw4b0jD3ZXg6ax6dh811SeTo
	 9jDxsDiSrnV1g==
Message-ID: <1da2a366-63c5-454a-9455-30b7fdb4ac21@kernel.org>
Date: Thu, 10 Oct 2024 10:22:28 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 00/15] refactor PM interfaces
Content-Language: en-GB
To: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1728538975.git.tanggeliang@kylinos.cn>
 <bb0bd72b-cb68-0386-b7c5-76383707840b@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Organization: NGI0 Core
In-Reply-To: <bb0bd72b-cb68-0386-b7c5-76383707840b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 10/10/2024 08:52, MPTCP CI wrote:
> Hi Geliang,
> 
> Thank you for your modifications, that's great!
> 
> Our CI did some validations and here is its report:
> 
> - KVM Validation: normal: Unstable: 1 failed test(s): packetdrill_dss 🔴
> - KVM Validation: debug: Unstable: 1 failed test(s): packetdrill_dss 🔴

That's interesting: the CI had this error, because the code doesn't have
"mptcp: fallback when MPTCP opts are dropped after 1st data" commit.

  https://github.com/multipath-tcp/mptcp_net-next/commits/8a88c16c3a19

That's appently because when using the "Based-on", Patchew will use the
tag it created, then apply the new patches. It will then not use the
last version of the "export" branch, then apply the dependences, then
the new ones.

In other words, we can ignore the failed tests here.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

