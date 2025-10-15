Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A538B2FB0A3
	for <mptcp@lists.linux.dev>; Wed, 15 Oct 2025 02:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760495803; cv=none; b=PAHUsMTI4hxVKs9phn1w+t5Vl01PGU6C4hpWCLEhh7dINTRGbFKfnTyhmh1WCXon6JPzr0BB+BveiPF3mSAZ8tt4LorZ/xIFLff9BuKmlXrj5GfPCcAB4/YSsng0t2haJyyi7bJi+FqiIhjOyov7nU6eTzMK29r3PK7Ye8bpEJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760495803; c=relaxed/simple;
	bh=caeD/If8h27jwbtaoGBSTV5CEOoGGbzMCKOJxTZHB08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWmiHt8cYEgA69Ni1wk2K8DhSIwBO4p51ZHVaJXa2S9Pa9b2iMf2yeESD+Z4ESIxpnsCubypls3uXAiNwX78yySNCBZAk1G7NO0X5NVYkP6OhRIfyFJLuGI3iEg8vQsKSdseGyYhrbwdyNBop6kI/Z2X3PksaC8Uzzo5GPLXnXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sZiHQj8J; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sZiHQj8J"
Date: Wed, 15 Oct 2025 10:36:30 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760495799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HLwZGw+J7GgdAsikcDgCgKEcVvzvj023A7f2jnT/lyo=;
	b=sZiHQj8JbI/BwnZV426Vsjz5RqVizJqQMjeOjbI4owtyy5EHxaoa5uQ5gcLyf4pUywATqR
	cRkCfTqP3QG7vWwhnR4c3zT3PHb1EfkGvMvx+aQ3H44u5Iy6NvDiDxs+heO8zaOO6IDW4w
	ksXY283SPHrYnxXJUtQ8HCayqI1LZps=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: GangYan <gang.yan@linux.dev>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Gang Yan <yangang@kylinos.cn>, Geliang Tang <geliang@kernel.org>,
	mptcp@lists.linux.dev
Subject: Re: [PATCH] gen_initramfs.sh: use 'date -u' to get Timestamp
Message-ID: <aO8Irkln40JYcLrF@yangang-ThinkPad-T14-Gen-1>
References: <20251013101946.248420-1-yangang@kylinos.cn>
 <70e9b1e4-41c4-41ba-a684-f6a0b7d7644c@kernel.org>
 <aOz9HkqEE_2FfNQX@yangang-ThinkPad-T14-Gen-1>
 <1a1d7145-35fc-4faf-9b90-d7abb542b758@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1a1d7145-35fc-4faf-9b90-d7abb542b758@kernel.org>
X-Migadu-Flow: FLOW_OUT

> On Tue, Oct 14, 2025 at 11:44:45AM +0200, Matthieu Baerts wrote:
> Hi Gang,
> 
> On 13/10/2025 15:22, GangYan wrote:
> > Still, I have another question: Is the compilation error too strict when
> > failing to retrieve the date? Would throwing a simple error be enough by
> > default? Or would it be better to provide a default value when the date
> > cannot be obtained, ensuring the compilation can be completed?
> 
> Maybe, I don't know. This gen_initramfs.sh already checks that 'date'
> returned something, and if not, it doesn't try to set the option. Maybe
> an extra check could be added to make sure the timestamp is positive?
> 
>   if test -n "$timestamp" && test "$timestamp" -ge 0; then
> 
> But because it is not linked to MPTCP, do you mind checking this with
> the maintainers of this file, please?
Already sent the email[1], please check.

Thanks,
Gang
> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
> 
