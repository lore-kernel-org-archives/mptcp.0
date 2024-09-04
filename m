Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458A28289A
	for <mptcp@lists.linux.dev>; Wed,  4 Sep 2024 08:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440080; cv=none; b=StGzs+caMPm6sxShdMWMAIjXPWqJpVt1Gr5ileg/Ybv2DEVwqb1m86AKEutF7ywT+6a1wf8S/xkG5JkoEBInWae7y9BTEK7KaC4bTOyBj6aBGUD/L2y72E0Rs/nw3nKZlcJmO/m7/L0to8hESPAa3zRcNBm5PlWjGNCj5Pvnou4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440080; c=relaxed/simple;
	bh=3hoFzcR/p3bLMWWVYfyYmY1LEsG4VqVy0BP7MRPz4KQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B49OkDDR+3W26Ku9X5zCEU2K2K2eM680TDMnDoPrpfNZt9LnhWgkRmO+Dsg9Qj5LyCx2KcdvAW5utBhLV928B+6ESpUgDdaOGyYDwVfhHoIG7WcQnLatQ5NLorvsrJ2jQj9yMJX8aAbjyKsI4OHwIRyfMxby3i62Z8kuTgxuYqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=student.unisi.it; spf=pass smtp.mailfrom=student.unisi.it; dkim=pass (2048-bit key) header.d=student.unisi.it header.i=@student.unisi.it header.b=LOp2i9mm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=student.unisi.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.unisi.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=student.unisi.it header.i=@student.unisi.it header.b="LOp2i9mm"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-201d5af11a4so55006125ad.3
        for <mptcp@lists.linux.dev>; Wed, 04 Sep 2024 01:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=student.unisi.it; s=google; t=1725440077; x=1726044877; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OazflBcO2kq2zFYE/9385dRmUl8NMeGCblDaj3jgbag=;
        b=LOp2i9mmP8nKikOIF41x0r0bTFggN56H3PVqUXO+rXfJH22xc0GN8T2WX0mHZpI1OO
         pBH7j5frkuW9rcaqtE3xxHNullHintAo78Eyr7nqbgDyri6LhIzG5VsNxygBVx/fOXEn
         Ov1/86VwEEH6z4lX+jbltt7B5rZsofJvszI4UyWhjmMqMqyQaB+00YK6Ivd+6LPPHRCp
         pMO966NXsWIh4isdGF4JmYX6QdcFI479LrjDRUGVAV19RkQYK4HSGdb7Hy9AF7+OTmDL
         XgYZEjZhbwfcJKqgEELlq8823jDpE/sIjpmOcX0i9i7yWrV9kl4lUJOCrYcr1RzoDmip
         gk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725440077; x=1726044877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OazflBcO2kq2zFYE/9385dRmUl8NMeGCblDaj3jgbag=;
        b=jyFABsjisQnZvTYCaHACinOCx3OWUs+q8kMUW+ndb0Tb+HGEZY/G/WSdQDPo8PeEfq
         BxX63eTguPjWyWm4T+37zrMDsFfG3dGoK1WXF/WrQnKnYxU6DQl5fJFy+xBRdn0Vm/ki
         +7/dTezqNxyEtjS/+JxHOnyCjLERYvXJ8/j64UbCKEfgJUEU8k8dcwunNGTKLSY5mv5w
         8mhnGQxQkktK9y8M3eXsJto/z1z81DBKYDPG6S/tpTFRl+3F3IAx02RKZl4O1JLT5ZDD
         47KMy7AcP+WPFVCqnkRjQ99+pLUBjcFfRBisgXSA/YEOcak/TDpW7iuxu73jt0uq/Tl1
         pdzw==
X-Gm-Message-State: AOJu0YxO+4CCWj4td19YO7fSowHdfsyET6G0kovp8L1k5mH/eSoM5zkF
	etf0JWGI53dlmDaOQ6SlmY/RRQwOelM1ZGWI2T6FJ9FDC2CoOJurdiL5eVvXwwprYJN8ZIVdyz9
	k0dkMM3529O6+GhB4NVYPljEN49nMssTHLvCxjHaI/oeH58FnhpcSX8nCycNbwnqkGfru+D5X8U
	zEGm/mSq+ur9nBJv4HjesvaiV9U0RnKGk=
X-Google-Smtp-Source: AGHT+IFS7Ni72AWS7MdgQA1NXX5VW2SUwy6tfflXf/5x26PEOzGCvD7OvD9aBH54AFUNajdLpR8exmwY3bqyaNB8RVo=
X-Received: by 2002:a17:902:d543:b0:1fd:aa8d:acde with SMTP id
 d9443c01a7336-205467061ebmr154697205ad.36.1725440076771; Wed, 04 Sep 2024
 01:54:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAOU6Dw9xnP2ha8Csj47_zQQEHg7_FUrgVRW+CrTon-aPLokKog@mail.gmail.com>
 <45634fda-f0d0-4bc7-99a3-97bb979d0494@kernel.org> <CAOU6Dw9doa_aH8bzLmUxQjFrxn3ThHunDKEzXFmdEcE1w+5CmA@mail.gmail.com>
 <8f355da2-5667-412b-b3fd-1ce8f7571fa8@kernel.org>
In-Reply-To: <8f355da2-5667-412b-b3fd-1ce8f7571fa8@kernel.org>
From: ROSHITH SEBASTIAN <roshith.sebastian@student.unisi.it>
Date: Wed, 4 Sep 2024 10:54:25 +0200
Message-ID: <CAOU6Dw-P_RRcVJqf2bGY=d8Vsas+H-9Y0tWLRmyTuFxA+5wsMw@mail.gmail.com>
Subject: Re: mptcpd Usersapce PM
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Gm-Unisi: student.unisi.it

Thank you for your answer. I will try to proceed accordingly.

Thanks and Regards,
Roshith Sebastian

On Tue, 3 Sept 2024 at 17:31, Matthieu Baerts <matttbe@kernel.org> wrote:
>
> On 03/09/2024 17:21, ROSHITH SEBASTIAN wrote:
>
> (...)
>
> > I am trying to implement userspace PM, because different rules have to
> > be set for each suflow based on different conditions (these are still
> > being defined). For example, 75% of the data should flow through one
> > and the rest through the other subflow based on the delay or the cost
> > of the link. The fraction in which the traffic is split might not be
> > known beforehand and can vary during simulation.
> > So my objective is to divide the traffic unevenly across the links
> > based on certain rules.
> > Is it possible to accomplish this with a PM or is a custom scheduler
> > needed? Although I have seen references to shedulers in previous
> > versions, it has not been mentioned in mptcpd.
>
> The PM is in charge of subflows, from creation to deletion, and also
> address announcements. From what I understand, you don't need to have
> custom rules for that: you just want to create 2 paths using two
> different networks, no?
>
>   https://www.mptcp.dev/#path-manager
>
> mptcpd can only control the path-managers.
>
> The packet scheduler is in charge of selecting which available
> subflow(s) to use to send the next data packet.
>
>   https://www.mptcp.dev/#packet-scheduler
>
> For the moment, it is not possible to control the packet scheduler. It
> might be possible to do that in the future with BPF, the work is in
> progress, e.g.
>
>   https://github.com/multipath-tcp/mptcp_net-next/issues/75
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>
