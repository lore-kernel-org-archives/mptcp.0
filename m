Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197AB1A4F04
	for <mptcp@lists.linux.dev>; Fri, 16 Aug 2024 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723811328; cv=none; b=mYNUi9XasjAuztCB1N2WK73n1ftxDOIec/LI5C7HtmGVmnnNUgCyFulLxhhD9B59PB5pdOMjpWTBsE3wRr9QI7Gt31+JdThFXtIHGFk3BYhZoWA3nGtlAhHyBATbqUfi0kFlC6gg7M79uvk50plefGARMA3ECH+JwiPYdT3lywc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723811328; c=relaxed/simple;
	bh=bvd0+LrKKoHkj9QI7FmI/Tyhbh6SRER/tkhHNiq04sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C8/CAwLnjoBtcjK+Nf22fwzcEJFGKTW0G+Buh35xmfu+SCnBCuj93rLTv34Pb+P3MNAAKcnNmslp5RqGecrFU8uFYIs13v2dLtPyMG5gt9NgZCXKlKJm9a0/kOPHEVJVCTq8he3EKIQkOzGE8cE0h1Y2ES9KNgAXqCH3Fd6wejY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=imcjnE8n; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="imcjnE8n"
Received: by mail.gandi.net (Postfix) with ESMTPSA id B7E5540006;
	Fri, 16 Aug 2024 12:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1723811324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yxy6RuTv67nQRkvSGQiaEuvYysI7zyokHhIeFqiABes=;
	b=imcjnE8nGMc3l9IIpCu+8jSncso5ST4K5lB6kjtje4gEualPwm7+zbh+77aWXrRZ9ZZmK5
	jX3vZmru+ITEyFowLf6GcO4hXRwV/bwoWRVA9wKcL7bQC+MPIoAbH5S1p8fLLu7TK+Z2MY
	w+FenxY3AqoDtFtdzx2at6lUHwr+TAHa4y+u6IDXwOfkrXompOSUXqMVvPE+7LQ4C4kjHX
	6utirL1PabZRxPjS5AOD87eRlWWV1pgDypAdr578fCGGG57DCx0GokWG51/misehOCe1jW
	5szSjNI6oTXtyRH89CxV6aH5Vkdlaji2lzMHs7xIUT5ucxNGLR+CU3aDR33CbQ==
Message-ID: <925f9bd0-d95d-45d8-8750-b27e844115fd@arinc9.com>
Date: Fri, 16 Aug 2024 15:28:42 +0300
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v2 09/12] mptcp: avoid duplicated SUB_CLOSED
 events
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
 <20240816-mptcp-dup-close-evt-v2-9-8a33f6617f5c@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240816-mptcp-dup-close-evt-v2-9-8a33f6617f5c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 16/08/2024 14:02, Matthieu Baerts (NGI0) wrote:
> The initial subflow might have already been closed, but still in the
> connection list. When the worker is instructed to close the subflows
> that have been marked as closed, it might then try to close the initial
> subflow again.
> 
>   A consequence of that is that the SUB_CLOSED event can be seen twice:
> 
>    # ip mptcp endpoint
>    1.1.1.1 id 1 subflow dev eth0
>    2.2.2.2 id 2 subflow dev eth1
> 
>    # ip mptcp monitor &
>    [         CREATED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
>    [     ESTABLISHED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
>    [  SF_ESTABLISHED] remid=0 locid=2 saddr4=2.2.2.2 daddr4=9.9.9.9
> 
>    # ip mptcp endpoint delete id 1
>    [       SF_CLOSED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
>    [       SF_CLOSED] remid=0 locid=0 saddr4=1.1.1.1 daddr4=9.9.9.9
> 
> The first one is coming from mptcp_pm_nl_rm_subflow_received(), and the
> second one from __mptcp_close_subflow().
> 
> To avoid doing the post-closed processing twice, the subflow is now
> marked as closed the first time.
> 
> Note that it is not enough to check if we are dealing with the first
> subflow and check its sk_state: the subflow might have been reset or
> closed before calling mptcp_close_ssk().
> 
> Fixes: b911c97c7dc7 ("mptcp: add netlink event support")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Tested-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç
