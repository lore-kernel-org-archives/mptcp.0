Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08222E851
	for <mptcp@lists.linux.dev>; Tue, 11 Jun 2024 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718120526; cv=none; b=Q0z85I2xQVgRFGpPuWRYIyjtltDf1rKTCSV/YlVDcSIryxuZn70ACT5dCNdMm4VVkSsmCvbDk6ZmQydSAYw7H7+hiFsMcZQ7UZf5yuoZpMytGpg1G/Ds6EFMn1N591mMIn6o3Ens902kN92c2ulJ1fc5POI4UL+QJRr/KH2KmDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718120526; c=relaxed/simple;
	bh=1/7eAVDQat5gCXNSBJV4n2WJ1ms6yCnQD0/6uNgIv3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=M/b9GBcWLctgGaBwu2u41Samgx687vrBSssJKbEXOnIjtaOItczHHlzD5x9FegqGSN4d7E1btwinjCpWrbpVaMhCGS+8dGdCLKauxotAWOkD5PGphD2KQ0LcQkTs7j2xaD5pKBaYnd2UbSk/svFHvSzh2u+9zlOpZBYF84l04N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBZV0k3h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBZV0k3h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BC2C4AF48;
	Tue, 11 Jun 2024 15:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718120526;
	bh=1/7eAVDQat5gCXNSBJV4n2WJ1ms6yCnQD0/6uNgIv3o=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=tBZV0k3hWrkYBT5UC28Fc+R1C+YE7CQ5ZDgtUdg8nyxAmexlBigssCO59CjDcQK+S
	 jkj+1T/nX5XQF4ayTZtnTqSPfvJ/4FDC32GS/nZMptwVNMh2AlV1JSWD4UMkKagu9H
	 rCHvXMLn0jGCfBoRKYG47xZ8JzXlH225ii+xd2vq+3pOqtgyk4yGHotj9q/UoCqmia
	 5gO3/VWZdV7wffbTQVg33r7lWmUg9UNe3N/pxZrosVKcnR+bymcVCWeq7CgV8/wj3z
	 pKCvdpsyCxSSx4O6i3d81Za+F6vY8bxPUtc+9kiT2d6zMC6sEer9Obmde1KGPGDYNo
	 79nXBvQxxC+Vg==
Message-ID: <4c776740-3953-41c9-bb63-a5814351293b@kernel.org>
Date: Tue, 11 Jun 2024 17:42:03 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: Create_on_err or anything else for auto recreate subflows in
 mainline kernels
Content-Language: en-GB
To: vgusev2007@yandex.ru
References: <20240611152044.3q6OMIkD@mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240611152044.3q6OMIkD@mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Please be patient: I got 4 messages from you from different canals in a
couple of hours about the same question.

On 11/06/2024 14:20, vgusev2007@yandex.ru wrote:
> Dear all, I don' t understand where is that parameter? I mean create_on_err  or anything else for auto recreate subflows. Is it possible to change shceduler?
>  
> In the old doc it was in a separate mptcp module, but I don't understand where I can create it or found it in a new kernel (after v 5.6 - for example 6.8 in ubuntu 24.04).

The two implementations are very different: the new implementation is a
rewrite of the previous one to fit Netdev maintainers' requirements.

There is no such "create_on_err" handled by the in-kernel path-manager
with the new implementation. Currently, subflows are re-created when the
MPTCP endpoints are removed and re-added later, but not when there are
network issues as described in [1]. New contributions are welcome!

Note that such issues can be prevented by enabling SO_KEEPALIVE socket
option in the userspace program. Of course, if you create your own
path-manager controlled by the userspace -- e.g. by creating a custom
plugin with mptcpd [2] -- it can handle this.

[1] https://github.com/multipath-tcp/mptcp_net-next/issues/440
[2] https://github.com/multipath-tcp/mptcpd/wiki/Plugins

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

