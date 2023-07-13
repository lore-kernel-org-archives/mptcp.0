Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0443D2FB3
	for <mptcp@lists.linux.dev>; Thu, 13 Jul 2023 17:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91766C433C8;
	Thu, 13 Jul 2023 17:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689268655;
	bh=A/KBHfpsrXMba0zo5O6OduJ4iIsxJvy8TN7wFUL/bNQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=bSEUjuta35LroYkojxQEqLbm4M747+hzL572NeBT44ObZ+65i2ttlpR0yP+0JpUNq
	 kRVpnnUmxvsIURZCY0dCVCOgFO8XzcN4i34BOKjsVYPL2maOMpJZfIFhJ4VL7w7jBW
	 D2cRK3Mb6S1LyItkg25dg8DZOLEFlclLpUiePmt6JWK/QYhuf4LjH5o4K0y7MnODK3
	 kovBa/Rkzc2JDubfmf2oqFkVMjaXYawcPY28zIcfoyZMn+U6/JvszxzmyRKRz4CceO
	 QrLS/K0OFF3rJvN8F2IvyKXkysDhGiUdukF3T5QKjx/ZQZ7CqMAB+jQrQp0xi9C9r8
	 y/toQ5Jmz4Vug==
Date: Thu, 13 Jul 2023 10:17:34 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/2] selftests: mptcp: pm_nl_ctl: display
 errors if any
In-Reply-To: <20230705-mptcp-issue-368-pm_nl_ctl_ack-v1-0-40bcff40cb6b@tessares.net>
Message-ID: <3f261320-9413-187e-56ef-c64d7fc983a2@kernel.org>
References: <20230705-mptcp-issue-368-pm_nl_ctl_ack-v1-0-40bcff40cb6b@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 5 Jul 2023, Matthieu Baerts wrote:

> Recently, I wanted to understand why the userspace_pm.sh test was
> failing on some arch according to lkft reports. There was nothing in the
> logs apart from seeing the expected event had been missing. I then
> realised the output of pm_nl_ctl was muted but also this tool was not
> looking if there were errors after having sent some Netlink commands.
>
> I don't think it is a good idea to mute the output and ignore errors,
> especially here in the tests where we do want to validate these Netlink
> commands. So now the tool checks for errors and the output is no longer
> discarded.
>
> Note that I didn't manage to read the error message set by the kernel. I
> think the rtattr pointer in nl_error() is wrong. I think it should get
> info from &err->msg instead of nh. Anyway, here we at least print errno
> and just in case someone wants to have a look, it is easy to test:
>
>  ./pm_nl_ctl ann 1.1.1.1 token 12 id 0
>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>


Hi Matthieu -

Good idea to add the relevant error output.

I noticed in the CI run for this patch set 
(https://cirrus-ci.com/task/5548960819970048) that some netlink error info 
is printed in the "OK" test results too:

[17:50:36.964] # flush addrs                                       [ OK ]
[17:50:37.070] # netlink error -22 (Invalid argument)
[17:50:37.076] # ./pm_nl_ctl: bailing out due to netlink error[s]
[17:50:37.187] # rcv addrs above hard limit                        [ OK ]
[17:50:37.295] # netlink error -22 (Invalid argument)
[17:50:37.300] # ./pm_nl_ctl: bailing out due to netlink error[s]
[17:50:37.413] # subflows above hard limit                         [ OK ]

Do you expect that with your changes?


- Mat


> ---
> Matthieu Baerts (2):
>      selftests: mptcp: pm_nl_ctl: always look for errors
>      selftests: mptcp: userspace_pm: unmute unexpected errors
>
> tools/testing/selftests/net/mptcp/pm_nl_ctl.c     |  33 ++++---
> tools/testing/selftests/net/mptcp/userspace_pm.sh | 100 +++++++++++-----------
> 2 files changed, 72 insertions(+), 61 deletions(-)
> ---
> base-commit: cde4fa6a0a5ed3effb75008ce99eb842bc448e5d
> change-id: 20230705-mptcp-issue-368-pm_nl_ctl_ack-bb1625f5bdda
>
> Best regards,
> -- 
> Matthieu Baerts <matthieu.baerts@tessares.net>
>
>
>
