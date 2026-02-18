Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8D7322C98
	for <mptcp@lists.linux.dev>; Wed, 18 Feb 2026 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771439521; cv=none; b=qwl8DLsnF4lgK0D7JqHx95/VPpfDf6LVAiWdBUGfAXhxywAls4JWQz+ONUm2HtXF44fMZgXNR/FDW4eHMRt99JSDWQo/0ehj+GMX00gWdaYUPofiKrVSoRuTV5Dhb99fXMStRXv3cY0e9y27dYoityUQMsdjxPImClkFIxU3WBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771439521; c=relaxed/simple;
	bh=2EHUA0fanuBS81BjEWu273ZFRWW8IbSSVv9bDpRJrKw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P43i/xu/acgI2UcD074Hp2IZuP4MGjZbhTCCa803U6jRAhtVPfID5qp3fKqT4x2xYuDDt6st2l6a30aZhNk2oVYf00bYSUgriewKTSDfyBcgD4WOvCNW6EIXja6NKS4IgE1Govzo3uCMFyLCihlikceiEyyYU8ow55Wwz8ep6OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=scnYqYll; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="scnYqYll"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-896f8feee14so1757926d6.0
        for <mptcp@lists.linux.dev>; Wed, 18 Feb 2026 10:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771439518; x=1772044318; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXSRRpfr9jF/KBDZrI0ZvqAcSJszJWLY93yov92tiK0=;
        b=scnYqYllHSaT9tdOiPTjSsK3hXQ2eo2d2Fd81CMBPtlmou2GPmgrCksyQa74LqPeBs
         5MPfD6AIyRQjfuT+NPnAjkRGnN7dH/zkOoVqybx2LGoeq2PzrSwhBQKDoCWcH9tKUXH6
         MD+C6CEy/KmrIy7wYBVF7PV2iXkpa4gqOrtWRrWZafy0CiOrbvTi/cMnb27cb2gswOWX
         Rh9Q+GeqgJAkcBwf55/gs4bQF/moAaqT7KGB9qrVt6JgpYQ5Ct3H7EApZhZhzFk9g3qm
         TjL+LLH/Op8yUW+Rc8nbfZvCuamPETRhDEkEZheLys3dC3sEGaph5GciJTjEn76w+HSX
         KPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771439518; x=1772044318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DXSRRpfr9jF/KBDZrI0ZvqAcSJszJWLY93yov92tiK0=;
        b=hzEJ2NhjP9o4xS2KYaIeOGZYnI9hH71lLjloeTkKYPdllviRq7l4dTBuDVxQaTewEL
         yqSQCfz45M3LN4UtcM1LLo+zfWb62ydPScm7UiE6al6Y6l90vPSIec9arXTjReovbttG
         Zz+jmgO93KlsdDk+ZgS21LTlL/lEwKejdWeCNhGuJolZAwyXQsTVRxmMvrQT3gVry/HM
         yaUrlhKp+/FRXoNrTU8aV/UdCldL52/KbKkG5/WI2fkT1Un3Hh0G2/BZav/pGHWGVh7N
         Qg3zqocpvJh9nonwGkzjCVSAxnB834INhd8/hdzO+Ti9r3E1uY0gZpvk/K1e3ayJSz6S
         yWrw==
X-Forwarded-Encrypted: i=1; AJvYcCV4WzHTXWJKpqu/FtLLWABlFliMIaXQAboFZAKASP7nMo2oaRu79DSsfofKDfUEOG+JaaXPHw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwSlr3I87gtdhUoT3cCQn1Or9aezDqhUMPcW/zgfISC2febR1/y
	6+gWFp2V1UhMf6pw+/3XjE6pfU9KYZv+6KgH6e6C8SATlMnx3kWReLNCuuOfYFuSvQI=
X-Gm-Gg: AZuq6aLKdajyB7uB2CgE8eLmopmHaua6vQhQQAey78lmlE8AQqCpP++A909AjY2QpGY
	F4BCyqMhuh6Pcm/wIXW2uvI81TsBEDZIrfddaokcs+tTrI23mJHntEZmFMux6aj7rDr1nvndoqA
	uBVfMJrgK77FEdKrvsg8A80jGxcO5M62Hr1dUOB0ep70N1i+8A4XlzmBn0C6RDRb3NtmmsGSkZl
	ITgJ4hPxtEE7Kew7K/GrTUy13OBu1khrSBcRRR9HHjP+wTMCcgvh7qjkSgE7xLRBX3aoqnOI4Wu
	7VIPH+rUpxGa+7gp8WYTgzO6ufokr6Fqf8+HnWgvxt4VLRYVRYH0IYb5arOLv1EzkaNjzSzSiUv
	p7IrjrRGAzj2m2pRhd56IqMgtoYpDgh83oDfabwYYMZGNNVyjxcgJGb0PEYVZ3b7cM3rr3CH4gl
	FhLmNM+9J3Am1VpdZCB0mcePYkUXNwvk2QxkFA8XynHmEoeAl8fyvydBYNouL/M2Vf
X-Received: by 2002:ac8:7d8e:0:b0:4f1:c66d:4c98 with SMTP id d75a77b69052e-506a8294747mr241250731cf.24.1771439518454;
        Wed, 18 Feb 2026 10:31:58 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506849fbb9dsm202588841cf.15.2026.02.18.10.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 10:31:58 -0800 (PST)
Date: Wed, 18 Feb 2026 10:31:55 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev
Subject: Re: [PATCH iproute2 1/2] mptcp: monitor: also show iface name
Message-ID: <20260218103155.486d20ee@phoenix.local>
In-Reply-To: <20260211-mptcp-color-v1-1-01832777611d@kernel.org>
References: <20260211-mptcp-color-v1-0-01832777611d@kernel.org>
	<20260211-mptcp-color-v1-1-01832777611d@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Feb 2026 13:03:17 +0100
"Matthieu Baerts (NGI0)" <matttbe@kernel.org> wrote:

> @@ -530,7 +541,7 @@ static int mptcp_monitor_msg(struct rtnl_ctrl_data *ctrl,
>  	if (tb[MPTCP_ATTR_TIMEOUT])
>  		printf(" timeout=%u", rta_getattr_u32(tb[MPTCP_ATTR_TIMEOUT]));
>  	if (tb[MPTCP_ATTR_IF_IDX])
> -		printf(" ifindex=%d", rta_getattr_s32(tb[MPTCP_ATTR_IF_IDX]));
> +		print_iface(rta_getattr_s32(tb[MPTCP_ATTR_IF_IDX]));
>  	if (tb[MPTCP_ATTR_RESET_REASON])
>  		printf(" reset_reason=%u", rta_getattr_u32(tb[MPTCP_ATTR_RESET_REASON]));
>  	if (tb[MPTCP_ATTR_RESET_FLAGS])


The whole monitor message output format here is divergent from what other
iproute2 commands do. If you look at ip monitor there are no '=' signs
in the output.

Please fix the whole function. Ideally all of iproute commands should
support JSON in monitor mode as well. But that is a bigger effort.


