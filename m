Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAF1946A
	for <mptcp@lists.linux.dev>; Fri, 20 Mar 2026 07:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773992758; cv=none; b=FTWJEBlD+zJHrVj/OW1sMoRezg//abN7olD33PpfJ03SpwG+ssQ4VV+XfHi3gpxMn+B7AkgGPhEGNxL3xbl/LLeFWm52oftm1gWJ/Vp3o3oZKncZeOxAAkPN6+yHLq5Knrd74GqRkHjnKHr5AqKsCMxy8IIKDEWnRaA9VBXB4f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773992758; c=relaxed/simple;
	bh=91PV7KoT5q1h0LqmcN19juVNFNqSWdLx2IbwCna97gY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a5InYO8sfkeIJAqhs9bXxkrAU1O0ry5Mh8IVBUvqpDywAgaDs4ad6LD5nN2pRLvtn4P5fG3OeKTpohP8uGFPB12tXGDeI3VflprPWSE9QlAn5nn8Sn+ClAkMMutwalDUn5Ulrxr/RCwh8c6UjhRSo9FbL28N9G4LcWqJXLlEb3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQGWF5AZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQGWF5AZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56345C4CEF7;
	Fri, 20 Mar 2026 07:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773992758;
	bh=91PV7KoT5q1h0LqmcN19juVNFNqSWdLx2IbwCna97gY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=iQGWF5AZYm1/jEQd0r55qdkAEeZoo40Uz6dD9PR9Mn15OJls2w21Hvsv0GpEoIgjS
	 gejFdBly/tomzR4NCFf4wBP0SMvtFgxqWrjZq7EL7341a+WsxV400RJGyLRtV8zVYU
	 1Iq58CwE8jLuL8Vb8rMzzf6eM1QX1iLMHOF/m15rDz6gXa0XMz4PL8vduKe5EoFtiE
	 kYcXBwv0GWVCbl1aNJd6YkT7CZU24k7M0KqL5KGqekp7dymqOTLB5B40B3XLl/MzwY
	 nDHvuhmB7gsGt6E6rO32HSPcr/I73851DSHNvGle/HqLvd3tUDGpQu2VSzCD48M74o
	 3DDWnjsgQaoFw==
Message-ID: <d229f43010fd00178c87d2acd78bc7519d3c516d.camel@kernel.org>
Subject: Re: [RFC mptcp-next v10 00/14] MPTCP KTLS support
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, Geliang Tang
 <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Date: Fri, 20 Mar 2026 15:45:52 +0800
In-Reply-To: <b7ce3e8b-dd6a-49c7-aede-23c846c6dfc4@kernel.org>
References: <cover.1773737371.git.tanggeliang@kylinos.cn>
	 <347b9b69-7fcb-d7eb-a3f8-921d1a6060de@gmail.com>
	 <b7ce3e8b-dd6a-49c7-aede-23c846c6dfc4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Tue, 2026-03-17 at 14:15 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 17/03/2026 11:41, MPTCP CI wrote:
> > Hi Geliang,
> > 
> > Thank you for your modifications, that's great!
> > 
> > Our CI did some validations and here is its report:
> > 
> > - KVM Validation: normal (except selftest_mptcp_join): Success! ✅
> > - KVM Validation: normal (only selftest_mptcp_join): Success! ✅
> > - KVM Validation: debug (except selftest_mptcp_join): Critical:
> > KMemLeak ❌
> 
> It looks like the leak is linked to the new code. Is that right?

Yes, it's related to the changes to shutdown_reuse() in patch 12, and
it has been fixed in v11.

However, I noticed that v10 and v11 didn't trigger AI review. Any idea
why?

Thanks,
-Geliang

> 
> No hurry if it is, it is just to make sure it is not linked to:
> 
>   https://github.com/multipath-tcp/mptcp_net-next/issues/583
> 
> (if it is linked, then we have a reproducer, that might be helpful)
> 
> Cheers,
> Matt
