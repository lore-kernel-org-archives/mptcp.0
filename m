Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62D9125D9
	for <mptcp@lists.linux.dev>; Fri, 19 May 2023 18:03:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF30C433D2;
	Fri, 19 May 2023 18:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684519385;
	bh=XbNzvcmFo8fwJEEEIOQnM7EF/m/wo9/sUG2UuChSJ+8=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=tvdSpujtaafdJdIab8rZcEA3he8Db5qgD4w6qOMpk3Hy1z5ChVeeHaJD89VSwtB/y
	 i8kDfOFtQ/LGrYwKmUTc9C8HtDsIHD66dLYwYx4U+p+Nm1N/zzOZv2pv4Fs/qZIOHw
	 Rs0Fdsxkq3a4LjWDJ5IAKAKMN2J+lV/CVBBtFwLZk22ha+aLnwqkLBI7eMxiCAK+Jo
	 33z5fsfS8edhcE/XzSHxnpCShalGPCLP5VlXPXY8LejbKd4m0pehzPSOq18zVZxYQw
	 UWFW+qJsz2h6H/v3LpFd3x2BDRBZhinOGkX3yz9wqT/Uq0mve49VoxzZwaKEdcRfXi
	 /U/I7Gf5erJnQ==
Date: Fri, 19 May 2023 11:03:04 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: mptcp@lists.linux.dev, Breno Leitao <leitao@debian.org>
Subject: Re: net: ioctl: Use kernel memory on protocol ioctl callbacks: Tests
 Results
In-Reply-To: <68711854-61ee-3892-ba5a-136c73b8aff0@gmail.com>
Message-ID: <7f3ef790-1cca-5cea-46f8-3aa838da59b7@kernel.org>
References: <20230519135821.922326-2-leitao@debian.org> <68711854-61ee-3892-ba5a-136c73b8aff0@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="0-1871007554-1684519287=:84732"
Content-ID: <6770a605-61ec-7519-7331-adfe145a2d14@kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1871007554-1684519287=:84732
Content-Type: text/plain; CHARSET=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <0ca50502-0568-7c45-cc96-2f8e3908a6a0@kernel.org>

On Fri, 19 May 2023, MPTCP CI wrote:

> Hi Breno,
>
> Thank you for your modifications, that's great!
>
> Our CI did some validations and here is its report:
>
> - KVM Validation: normal (except selftest_mptcp_join):
>  - Unstable: 1 failed test(s): packetdrill_fastopen 🔴:
>  - Task: https://cirrus-ci.com/task/6416256383844352
>  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6416256383844352/summary/summary.txt
>
> - KVM Validation: normal (only selftest_mptcp_join):
>  - Success! ✅:
>  - Task: https://cirrus-ci.com/task/5008881500291072
>  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5008881500291072/summary/summary.txt
>
> - KVM Validation: debug (except selftest_mptcp_join):
>  - Unstable: 6 failed test(s): packetdrill_add_addr packetdrill_dss packetdrill_fastopen packetdrill_mp_capable packetdrill_sockopts selftest_diag 🔴:
>  - Task: https://cirrus-ci.com/task/6134781407133696
>  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6134781407133696/summary/summary.txt

Hi Breno -

These appear to be false positives that are popping up in our CI on other 
patches too, no need for you to check on them!

Thanks,

Mat


>
> - KVM Validation: debug (only selftest_mptcp_join):
>  - Success! ✅:
>  - Task: https://cirrus-ci.com/task/5571831453712384
>  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5571831453712384/summary/summary.txt
>
> Initiator: Patchew Applier
> Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/65a7e8021b1b
>
>
> If there are some issues, you can reproduce them using the same environment as
> the one used by the CI thanks to a docker image, e.g.:
>
>    $ cd [kernel source code]
>    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
>        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
>        auto-debug
>
> For more details:
>
>    https://github.com/multipath-tcp/mptcp-upstream-virtme-docker
>
>
> Please note that despite all the efforts that have been already done to have a
> stable tests suite when executed on a public CI like here, it is possible some
> reported issues are not due to your modifications. Still, do not hesitate to
> help us improve that ;-)
>
> Cheers,
> MPTCP GH Action bot
> Bot operated by Matthieu Baerts (Tessares)
>
>
--0-1871007554-1684519287=:84732--
