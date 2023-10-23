Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F371168AF
	for <mptcp@lists.linux.dev>; Mon, 23 Oct 2023 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5d4Wa96"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24D4C433C8;
	Mon, 23 Oct 2023 16:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698079470;
	bh=mDUPSQRMckqKCrwaaejHldzNPdW+p09Y+uuGMvjXwm4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=m5d4Wa96U2gi4VfVVOm0TxXSeuKh4A6QOz6wk7UND3r/IZyXxeefBgKlaZ9Avh4L0
	 4y++trqPI39HjixSSK84Qs8WygZVlY6pYCWbwT0CXmIPLKBhWkf1P3LsR+uAYCnTz0
	 pNT0NMb5rCJEF6KctbEuwqzhVKMuRVrxkpWpktgMy4YvjtLWl9EU3tzrRONXJdR+S2
	 rHlgOqgw9YXHh/u0SuZWDk38RohTwsiuurg0D/MgL52qJG/nBESLPFSX/Uk9/gjZ7m
	 ZRVBJwl/+hcYXLESloRo6pBeWOJ0tdSjbBeC3E8lvbbw0lO1Fl4MWPQUk1sJgF7kL+
	 hUyctFlbHshYw==
Date: Mon, 23 Oct 2023 09:44:26 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: Patches for netdev (for 6.7)
In-Reply-To: <ee535704-52c3-48a5-9893-c195f7975e64@kernel.org>
Message-ID: <2dea2b8e-6395-fb49-dfed-493ad538cc05@kernel.org>
References: <ee535704-52c3-48a5-9893-c195f7975e64@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-204083318-1698079470=:6030"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-204083318-1698079470=:6030
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 23 Oct 2023, Matthieu Baerts wrote:

> Hi Mat,
>
> Regarding the patches we might want to send to netdev this week, I think
> all the ones for -net and net-next can go.
>
> ...

Hi Matthieu -

Thanks for summarizing the state of our trees and the net/net-next 
conflicts.

> Just a few notes:
>
> In -net, 2 patches introduce conflicts with what is queued for net-next:
>
> - "selftests: mptcp: fix wait_rm_addr/sf parameters" conflicts with:
>  - "selftests: mptcp: update userspace pm test helper"
>    → the patch fixes the same issue but in different functions
>
> - "mptcp: userspace pm send RM_ADDR for ID 0" conflicts with:
>  - "net: mptcp: rename netlink handlers to
> mptcp_pm_nl_<blah>_{doit,dumpit}"
>    → the conflict is easy to fix: we want to put a function before one
> that is being renamed
>
>  - "mptcp: define more local variables sk"
>    → also easy to fix: one line in the context that has changed
>
> Because these fixes don't seem critical and because we are getting
> closer to have a new release, I think it might be better to send these 3
> fixes with the new feature (but keep them at the beginning of the
> series). I guess if a note is added in the cover-letter message
> explaining it is easier like that, and it is fine to delay the fixes, it
> should be OK. WDYT?
>

Ok, I agree that those -net patches are fine to go to net-next rather than 
introduce the net/net-next conflict issues or delay the other series. They 
will not be too delayed in getting to Linus' tree.

> Also, about the MPTCP NL YAML specs series where a v2 was needed: it
> looks OK to me, but I don't know if Paolo wants to double-check the last
> modifications from Davide before sending them. There is a conflict with
> one patch from this series and one for -net (see above). I think it
> might be better to send this YAML specs series first, then the other
> patches.
>

Yes, will send this v2 series first.

> I think Paolo's patches for net-next can be sent in parallel to Davide's
> patches.
>

While I normally try to avoid having more than one series waiting for 
review, this is a unique situation with the v2 series. It should work to 
set them up without any conflicts so I will try sending both (unless Paolo 
says "don't do that" :) )

>
> Do you think you can send all these patches, please? :)
>

I will - have a good week!


- Mat

--0-204083318-1698079470=:6030--
