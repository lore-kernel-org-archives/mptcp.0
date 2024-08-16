Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4320D86AE3
	for <mptcp@lists.linux.dev>; Fri, 16 Aug 2024 10:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723803625; cv=none; b=rnLPq4VdBDoNLZXdmTLD01wU9Rg/fl+E7NtVY8B9tVAvqGHY6O1eChXZb715GayteAoNiEZyHH2Ea9J6tHU0+GvIOskJwVieJM+tJ3J1beuNdETQR/ecLmeLza9wKlpU+fl0mBB5hv1hns54z5Npi8p+VgrB2ZOFGapxegduxmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723803625; c=relaxed/simple;
	bh=e2pu1DCaplSNT5gLalc0ULOinyV6aT156sLBf4IqFLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lT3xkC1zMDqs2LoRtnZE8qXrA+DBC7WfOobvPy+WIVUAD5QGudXwvN0TXsMb2AdUVgyHDNSHE5QrlEhptC3L/ZIurskpHk2e+CRw/CD/9KaWIPkLLnbtFJxnCGQOdKQk0BHSjYxDQBiCiGF/DmyyPmorIJm0EhMOBO9TOmzJxyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=HPYe1bW6; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="HPYe1bW6"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9AC0F240004;
	Fri, 16 Aug 2024 10:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1723803614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GMBpRGoJXEXJUiSJGJYrX8cwCYpBLRlZwi69XYtUSoc=;
	b=HPYe1bW6fGxZBID5/J9nw05BJTUsjT1SJvUrw5pEJ6yhdT1PvmQ/HGaHldi/ojOnTv2MWM
	C12Gr+ocak1ff9I5SUPAFB+239YZxeTd+6/WoupB1WdymWzrRD+11VltwZoHN4LfByY4mp
	PmRRbXnv2YeZfWFsLWD0804zlPKT7UPPwKHpAYkt3vYtW2fcJCJ7CaAVYWGNO08d/RKVoE
	ButhzDbR/ClVFipoY2TCIE/6GX6J0wOA6jGuLWHM0Tmr00sRWUzCoOoRMNO/II1vPcJ+Xe
	FXqgGAsmOV8mhfVSwJvpc9L948o2gcB/wyQs6WrAezspJ2UweszVRfa9iHHvLw==
Message-ID: <cdc28738-8d6e-4591-b618-0d0a61492b87@arinc9.com>
Date: Fri, 16 Aug 2024 13:20:12 +0300
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net 07/10] mptcp: avoid duplicated SUB_CLOSED events
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
References: <20240815-mptcp-dup-close-evt-v1-0-5a551d3a66cc@kernel.org>
 <20240815-mptcp-dup-close-evt-v1-7-5a551d3a66cc@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240815-mptcp-dup-close-evt-v1-7-5a551d3a66cc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 15/08/2024 23:45, Matthieu Baerts (NGI0) wrote:
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
