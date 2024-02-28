Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98537350A
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 12:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709122124; cv=none; b=PJHAAagPK8S17rZOdHaRt26wx1K+j0spmqgOU9nulUAcjNUl/y/GUts0u4l6lIbBW+P9ricn2orjHkqa9pgxJSIJqvIyyCiCd5ex/wb4XD+oVHn/m0D6Z849qFd8phJT2HR9WxLGZ3MTacHlcYS8b0tTVmivvEuS38uwjgl+aYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709122124; c=relaxed/simple;
	bh=jvQTug4SUhQ5PC9eW6a7/+wXjZZb5zT/PF3B/y76Rrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOtLxelDsMuUCDapWSxVhlu8ck9MFberIV704duSQwcbuxIdf6ijh62kIe8iXGfhDsMXob9Ef3744jqa/jW+ZArc1S/gvJfMp+3ixRn/mxTwA/M15vZWIbx4PPclCcZG+OYu6vyG7NRJCL7OSfeFwAEaAIoROE7Ja4J0GP6kMcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVU/1K4k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVU/1K4k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90595C433C7;
	Wed, 28 Feb 2024 12:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709122124;
	bh=jvQTug4SUhQ5PC9eW6a7/+wXjZZb5zT/PF3B/y76Rrg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lVU/1K4kGUcw2cQA8Pmqdn05eXRZIRVldlEsDYHFOQ2/yGql/X1PzcTzEERTr5cAp
	 e4Zwbh1zRkBl9n5+mu+Wq8QJ8G9UGA5kWwGm2YX8EVT8dg/di+uuWKX2d6s8BR4C+u
	 vb7B0Ndu6wLXLynh/eBJMwMpN7v6eZi3XsJz9stfnbvKVeUkU64BBJVnx3QMsFBbag
	 l0yg78guO8K3zUT9aNKYUyMjiTkKLWFiaLYf0OoPSWJBYfEjixiTsTcgoWodebDifl
	 FndnQg6mwyGe4vP/VnI6qAgwCA+xk1//OK5DUpAf5T7HlVSXLO/XKmWv/041gmsXfw
	 DsKGXWhGfh2mA==
Message-ID: <ebb78a4a-ecba-4a16-adea-18d5387402fc@kernel.org>
Date: Wed, 28 Feb 2024 13:08:41 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v6 5/9] selftests: mptcp: sockopt: print every
 test result
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1709105922.git.tanggeliang@kylinos.cn>
 <51944c2c405df17d101f0103a3640daaf5c3f885.1709105922.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <51944c2c405df17d101f0103a3640daaf5c3f885.1709105922.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 28/02/2024 08:43, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Only total test results are printed out in mptcp_sockopt.sh:
> 
> INFO: PASS: all packets had packet mark set
> INFO: PASS: SOL_MPTCP getsockopt has expected information
> INFO: PASS: TCP_INQ cmsg/ioctl -t tcp
> INFO: PASS: TCP_INQ cmsg/ioctl -6 -t tcp
> INFO: PASS: TCP_INQ cmsg/ioctl -r tcp
> INFO: PASS: TCP_INQ cmsg/ioctl -6 -r tcp
> INFO: PASS: TCP_INQ cmsg/ioctl -r tcp -t tcp
> 
> They mismatch with the test results:
> 
> ok 1 - mptcp_sockopt: mark ipv4
> ok 2 - mptcp_sockopt: transfer ipv4
> ok 3 - mptcp_sockopt: mark ipv6
> ok 4 - mptcp_sockopt: transfer ipv6
> ok 5 - mptcp_sockopt: sockopt v4
> ok 6 - mptcp_sockopt: sockopt v6
> ok 7 - mptcp_sockopt: TCP_INQ: -t tcp
> ok 8 - mptcp_sockopt: TCP_INQ: -6 -t tcp
> ok 9 - mptcp_sockopt: TCP_INQ: -r tcp
> ok 10 - mptcp_sockopt: TCP_INQ: -6 -r tcp
> ok 11 - mptcp_sockopt: TCP_INQ: -r tcp -t tcp
> 
> This patch prints more info for every test result in each test
> group to match with the test results:
> 
> Transfer ipv4                                     [ OK ]
> Mark ipv4                                         [ OK ]
> Transfer ipv6                                     [ OK ]
> Mark ipv6                                         [ OK ]
> INFO: PASS: all packets had packet mark set
> SOL_MPTCP sockopt v4                              [ OK ]
> SOL_MPTCP sockopt v6                              [ OK ]
> INFO: PASS: SOL_MPTCP getsockopt has expected information
> TCP_INQ: -t tcp                                   [ OK ]
> INFO: PASS: TCP_INQ cmsg/ioctl -t tcp
> TCP_INQ: -6 -t tcp                                [ OK ]
> INFO: PASS: TCP_INQ cmsg/ioctl -6 -t tcp
> TCP_INQ: -r tcp                                   [ OK ]
> INFO: PASS: TCP_INQ cmsg/ioctl -r tcp
> TCP_INQ: -6 -r tcp                                [ OK ]
> INFO: PASS: TCP_INQ cmsg/ioctl -6 -r tcp
> TCP_INQ: -r tcp -t tcp                            [ OK ]
> INFO: PASS: TCP_INQ cmsg/ioctl -r tcp -t tcp

As discussed on the v5, looks OK, but we can probably remove the 'INFO:
PASS:' (and duplicated 'FAIL' if any), and use IPv4 or just v4 instead
of 'ipv4'.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
