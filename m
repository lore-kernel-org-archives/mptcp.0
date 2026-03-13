Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3215366573
	for <mptcp@lists.linux.dev>; Fri, 13 Mar 2026 08:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773389226; cv=none; b=PUSGpeLDWM24QTp0+9DPePu8JJSRC/ON/UxNQez4B9C04gRJGDwsFHvkMC8wTtCRPCbRr1aNxrwbEg/YZojfLP1stvQa5UJPpPfdYUZ4OoS25C355I5q27592IJf90r0MIp8iAlxjZKFjeWvBpkhMnRFYe+elJUg7WfG05SF7o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773389226; c=relaxed/simple;
	bh=o8OLLxM+6mCbe/HfjwwK1ZnyS0UdCgFRsCY4L1JfjZ4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OUddTaubkk5JF2tuBP6vNMtuiQriZ923BRjnIBhn4nnmJBqu/uRh6GaGMJuEaoBu+KeHQ96RRb05qOHVRU6voWh5/Tksayp3uJfIu8gn+isSk+E2VcIZPrvomTAJYbK+UtIepPgQQ0h8RgKIDxQTzzXgFbYRHmAD1jjh/ahFSTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTy01fdj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTy01fdj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0687C19421;
	Fri, 13 Mar 2026 08:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773389226;
	bh=o8OLLxM+6mCbe/HfjwwK1ZnyS0UdCgFRsCY4L1JfjZ4=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=TTy01fdj9E90VcBm48XAj1bx44uByMYsC0GQtOY0618XJ6EMJUQ2vqih+jPHiJBa5
	 3jlEKa+uiek9gHtRdVmq3vwrqZozpaRAS5f7RRiCc6Vqntns0US0QPDq5+8wMwUADh
	 zvY641lLnSPz/CseArF+YkXDnbBCr54og7e+2REWfBdrTR/DAcOmldVZrzB1RJxcwQ
	 CpwJb7rveLjS53Qobr5NwDCOZtRHACY+XTcvFiA8lFqhPIHP/yPw0ZZgMnPoeY7fm4
	 bh03Yw3jJ7qh1wyI9c+zMZwSClgsvanLa2NyALiDvkb/RrYAbZUctYlXyGXYpfO9jv
	 9GL0ONsbpBfcQ==
Message-ID: <2a80a9f2989ee4194e3d42bd4773059dbc8e53c5.camel@kernel.org>
Subject: Re: [RFC mptcp-next v9 00/10] MPTCP KTLS support
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Date: Fri, 13 Mar 2026 16:07:02 +0800
In-Reply-To: <98a77c2a-ad83-349f-0ad0-c687637218d1@gmail.com>
References: <cover.1773365606.git.tanggeliang@kylinos.cn>
	 <98a77c2a-ad83-349f-0ad0-c687637218d1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2026-03-13 at 04:27 +0000, MPTCP CI wrote:
> Hi Geliang,
> 
> Thank you for your modifications, that's great!
> 
> Our CI did some validations and here is its report:
> 
> - KVM Validation: normal (except selftest_mptcp_join): Unstable: 1
> failed test(s): selftest_mptcp_connect_splice 🔴
> - KVM Validation: normal (only selftest_mptcp_join): Success! ✅
> - KVM Validation: debug (except selftest_mptcp_join): Unstable: 4
> failed test(s): packetdrill_dss packetdrill_mp_capable selftest_diag
> selftest_mptcp_connect_splice 🔴

Patch 10 broke the mptcp_connect_splice.sh test. I will find a way to
fix it.

Thanks,
-Geliang

> - KVM Validation: debug (only selftest_mptcp_join): Success! ✅
> - KVM Validation: btf-normal (only bpftest_all): Success! ✅
> - KVM Validation: btf-debug (only bpftest_all): Success! ✅
> - Task:
> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/23032875328
> 
> Initiator: Patchew Applier
> Commits:
> https://github.com/multipath-tcp/mptcp_net-next/commits/6363c87fa2fa
> Patchwork:
> https://patchwork.kernel.org/project/mptcp/list/?series=1066012
> 
> 
> If there are some issues, you can reproduce them using the same
> environment as
> the one used by the CI thanks to a docker image, e.g.:
> 
>     $ cd [kernel source code]
>     $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm
> -it \
>         --pull always mptcp/mptcp-upstream-virtme-docker:latest \
>         auto-normal
> 
> For more details:
> 
>     https://github.com/multipath-tcp/mptcp-upstream-virtme-docker
> 
> 
> Please note that despite all the efforts that have been already done
> to have a
> stable tests suite when executed on a public CI like here, it is
> possible some
> reported issues are not due to your modifications. Still, do not
> hesitate to
> help us improve that ;-)
> 
> Cheers,
> MPTCP GH Action bot
> Bot operated by Matthieu Baerts (NGI0 Core)
