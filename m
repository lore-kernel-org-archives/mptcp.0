Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C330158DC8
	for <mptcp@lists.linux.dev>; Fri, 16 Aug 2024 10:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723804554; cv=none; b=ClLx10EU9OFpZmFMPzdXy0WTnHCZpBEhSWDFOI5BJVz6OquHiRW5sgfGk+dAB0mWbOiCHbvxzuEmaWN3LCBb+Rn7ZyNKkWWX3vJsUoIZxXhHMX8I+nXxFj3vuaWrL6XnWpxgSvNiogT51xjdQWrObneQnsLhW4C5/2DvBbE6SYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723804554; c=relaxed/simple;
	bh=GjsYCwXBvx00NDDEiFhNvCRp5fUHzbqyWZlVvw4Y4SY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hehlSiMkBbrnEXWKiD61+oi/2yXIrDwYjdzuEHtkjev/qi60/uWNpjjuL6l9f4K36mqDqpl7ZeVTGipJQtvCXo1EfM/BItt2b9ETrQLiI664EQn3JMa9MX7gsZYiTI6x7V5UXRPtbg+eGDoqNVwtiWl+IuMvlF1NULub79AvVqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=kjIxp8pB; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="kjIxp8pB"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4B478240002;
	Fri, 16 Aug 2024 10:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1723804550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vehx1jHk+VGzCeE5whUaaMt593HedKJyMOI5aZUq7OM=;
	b=kjIxp8pBaH9wkzj6JlsmWBy4i0zV2qNWGOIaqItnIGdCSTc+zIuqqlhdKa2dfWVuyAs2nM
	2W1eHxz2RB9IvdAd1vqu+3EjICzBmv7AHUk57KXN0wVQNzD/FMvkXtEoiUrWs2W5Uj98lP
	BT2Y+qLmCS4GEnL+Bt+zquHMDopNVlFjYLQmA2D2+pqrYMLx5ZLEuSswiuxtROgWiJMvIs
	Caxf2rKRtspnsLSEipTjp872Fr6ltdRgnI98EZ8BVhE/b6KKpKdBZlQoM3XcGjJ1liB34/
	G8ctbZIEbRV5kGAsocgZimGI65l681KROu0E+Td/wDWC2KHXnSQOLgVegcd6+Q==
Message-ID: <a59509c4-9a1e-413e-8a18-eeab9991ac2e@arinc9.com>
Date: Fri, 16 Aug 2024 13:35:49 +0300
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net 05/10] mptcp: pm: fix ID 0 endp usage after
 multiple re-creations
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <20240815-mptcp-dup-close-evt-v1-0-5a551d3a66cc@kernel.org>
 <20240815-mptcp-dup-close-evt-v1-5-5a551d3a66cc@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240815-mptcp-dup-close-evt-v1-5-5a551d3a66cc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 15/08/2024 23:45, Matthieu Baerts (NGI0) wrote:
> 'local_addr_used' and 'add_addr_accepted' are decremented for addresses
> not related to the initial subflow (ID0), because the source and
> destination addresses of the initial subflows are known from the
> beginning: they don't count as "additional local address being used" or
> "ADD_ADDR being accepted".
> 
> It is then required not to increment them when the entrypoint used by
> the initial subflow is removed and re-added during a connection. Without
> this modification, this entrypoint cannot be removed and re-added more
> than once.
> 
> Reported-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/512
> Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

I've tested this. I confirm that it fixes the issue. However, there's a
warning being reported when removing the endpoint for the third time. I
will refrain from submitting my tested-by tag for now. Details are on the
GitHub issue mentioned.

Arınç
