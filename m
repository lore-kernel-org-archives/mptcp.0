Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E82113AA2B
	for <mptcp@lists.linux.dev>; Fri, 16 Aug 2024 12:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723811315; cv=none; b=S6AmemuJqGnDGaO6t2NU+XgBMOGCiUIVIFhDxGqYyTQ7ChuvQAuQyIAaSPhteXCpI9v/S6XjF7F3gTbXUSzK4tBZDfDpCdtHVBX3pGeaIdO32Vu29oesTExIjOBOPFugHxr2gW7TDj3jFd9GEMlpgnKCx0vgjKYbDkeWa9FjTIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723811315; c=relaxed/simple;
	bh=qXPIWZp1FNcobxA8iQGqYPG7k6ayhRVHvY+WvzZECCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ngj6B+bRy5jPuIsHaDd1t0csrnJAkdPEIUu85tfwHVY0u1msGfUDyNBdf/lkzA5iDFFzGnrNHYzVYbv+ArdBIZc6rgazD8hS1nMNxUnc3yHvrrNEqvatuuNcNin1mjXOBQZwYHK2rQyUIlGNYIPczLJRrltSBlkHdxHqpGgxEpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=ivUBaI88; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="ivUBaI88"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 779DD240002;
	Fri, 16 Aug 2024 12:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1723811310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kMhNE+EY1jol70wm7wI/nPLyTPgzj82oFX+Ju2XyoV4=;
	b=ivUBaI88fAeEF8ETroeFcKzIbSX0EMGdgHdlTxjpdDemlkElnTaknVmlUpNA90hnl/NAVu
	GpHkVKRQ1ncd1brnGaN1OdEUHef6bnY4GphNp4D55/fqYl0ah9FIUj3kzX3kna0wIGZSWL
	C3PY7YPBSaNt8rSflw/w1Yd9CdgLASAHFrlaPd86HzkBUulLK4XtU0DksuiuKzkYT2/PWr
	3X9AZp5oF0WFjdHB7J5Q+bYf6b1T9242NHwD1OePquX4Cs8IVTfegi6G1jFvcTNq/rp7oG
	slVel3gKIW1n5QHuhpGY2xKeAVDD2cfdazsLxBzHfjlgnVyrUVUGqz7TGXUMTw==
Message-ID: <7bc26b73-32e5-48df-b978-d3c322915ce2@arinc9.com>
Date: Fri, 16 Aug 2024 15:28:29 +0300
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v2 07/12] mptcp: pm: fix ID 0 endp usage after
 multiple re-creations
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <20240816-mptcp-dup-close-evt-v2-0-8a33f6617f5c@kernel.org>
 <20240816-mptcp-dup-close-evt-v2-7-8a33f6617f5c@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240816-mptcp-dup-close-evt-v2-7-8a33f6617f5c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 16/08/2024 14:02, Matthieu Baerts (NGI0) wrote:
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

Tested-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Thanks a lot!

Arınç
