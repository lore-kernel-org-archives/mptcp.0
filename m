Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7472639A7EF
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 08:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787041391; cv=none; b=caXXyOgHfsMoMqLnfRFYpzbymCFFSZr5LuX8KrUtB6zlECo816KARBkzmYnqQyLH3RB47Jvy2A0mmfW0kVrD06mv27jwtb/ljRwLmvnqNJcmVPizCXiDNCKZQx0H55XmzIB8cU2FNiKsc+nXgmLiamNEYgMbD1lbIrvJrHQTl1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787041391; c=relaxed/simple;
	bh=63fjq9YfrVnP4mrOjEF/7G8AWkh1mgn73u7+5QfGPDA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pSMVTWwlVojSGBdi7IiLtbl944gGWpqVH/0vBei2htVU91PmXZVz7+nJ7439gLDD9e4eM5Y9L9cFgqm/8qAzdXPWgIxMlbHQ3nW6IeF6NZnWRKeubt5H89Glx6bLJ+sZo3tVBHXb3nxRppA7q9NuP1g9HdUmMlRSObN288R4FB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvqGSKlL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvqGSKlL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FF01F000E9;
	Tue, 18 Aug 2026 08:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787041390;
	bh=9Ct5u1ggbp/Q7gSbTIV5/Xx2iAruA5EGLPE6Ql+hwko=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=GvqGSKlLq3FkjEFOWx1I2L0/6uo1qrvEzvda7IEkdtONnShL2ayXuhHu+GbIkhv9/
	 aGFE9ECGvRcxF1JIJT6uERbJox2ZuT7JIWWsRbNv7EAAO0y32nz1CcByV+R+tzvSep
	 8+xUO2pyzsUcFSWzedqCZYdKcNigStsjhDS92WefbvT1dmYEA/joEGFjZfco/MdTWB
	 SD8M3kRddu6X9wtCNTcJkh0CMAV05abvJWcXZx1cj+wcsUCm+oyNi3Y/YsgrVgtBfM
	 79gWgVN/ch/13eWKRv/Vik2b+kduDzYqN2X9O3+GDtwPdqL/liSrF4TLU9hRU4FDx+
	 ZduCYbQIYpI5w==
Message-ID: <4a4ce805c08bf5a8c2f34e0fa371b81317af795e.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v6 0/6] Fix socket options used by NVMe over
 MPTCP
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Date: Tue, 18 Aug 2026 16:23:04 +0800
In-Reply-To: <cddcbdb5-b4ab-b99f-54ae-ee6cf8fd8cc5@gmail.com>
References: <cover.1786938892.git.tanggeliang@kylinos.cn>
	 <cddcbdb5-b4ab-b99f-54ae-ee6cf8fd8cc5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Mon, 2026-08-17 at 05:11 +0000, MPTCP CI wrote:
> Hi Geliang,
> 
> Thank you for your modifications, that's great!
> 
> Our CI did some validations and here is its report:
> 
> - KVM Validation: normal (except selftest_mptcp_join): Success! ✅
> - KVM Validation: normal (only selftest_mptcp_join): Success! ✅
> - KVM Validation: debug (except selftest_mptcp_join): Success! ✅
> - KVM Validation: debug (only selftest_mptcp_join): Success! ✅
> - KVM Validation: btf-normal (only bpftest_all): Success! ✅
> - KVM Validation: btf-debug (only bpftest_all): Success! ✅

Sashiko has already reviewed this v6 and has no further comments. If
you have time, could you please take a look and review it as well?

Thanks,
-Geliang

> - Task:
> https://github.com/multipath-tcp/mptcp_net-next/actions/runs/31994206151
> 
> Initiator: Patchew Applier
> Commits:
> https://github.com/multipath-tcp/mptcp_net-next/commits/f3f2396df333
> Patchwork:
> https://patchwork.kernel.org/project/mptcp/list/?series=1146924
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
