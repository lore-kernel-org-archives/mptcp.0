Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFA379E4
	for <mptcp@lists.linux.dev>; Wed,  6 Mar 2024 03:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709696572; cv=none; b=DbWpik2MHVtGoDLWa0CH+NQtBKAJ/ZyL0++wgzrVjJzlD901LOjMzj1IS68AHeqYc5iEN/Om5slxfUkOCLBsDxY3LrZDaSTkk9TA4xS5HIGEVeLr7c/twXbkBrBATUd27s35keSrpcqB7418mJwU81nVJ1h4UPnos0NZxUJgvvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709696572; c=relaxed/simple;
	bh=sRPMFk+WPPE66P0hrTxLGe+fMTd4KvdOtdDPJp5ER60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JtmscNbV8R8AqKVHOZQNlE4z9nJLSROtf+ZWDzSDRJ4CrfNql0s65CjOwTYnRxv4alt3G6mDCZt50dKi2A4voNQtVVVSgN/6ze9RVcoU9FeL9CnFIPnkfAHSGQtAUm8a6hpuyWsj/5L9nNAbU3iLWEJJXxc8Wo2j/T1RYE7g6UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCPHFxi8; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCPHFxi8"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a4417fa396fso771535466b.1
        for <mptcp@lists.linux.dev>; Tue, 05 Mar 2024 19:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709696569; x=1710301369; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sRPMFk+WPPE66P0hrTxLGe+fMTd4KvdOtdDPJp5ER60=;
        b=RCPHFxi8qeRicpf8s9wPnwXVDyD0FckCxn6wDr1GHZpBaqNrqMW26fLAzbBcuJIlYP
         LE7Lu0iLQfj0lP0FZO/2k5+IHMNGiBnXnftDmkd68aY7iRhhmf7YqwtEpTDuwvBxu1Uq
         jsn6BwLul7hjqEPcHsh8pQKZWmlXG3PO69XoQySJTtZRD5GyvA592ptNM1dwbyu97o0M
         Ws+pU7mNmwOhlKHOBKEHzS65qWbPif8jP7j0mOxM3wjtNvNbwVbDYgJ5DebmcYzQ8eOC
         XMAc0KzN9hOZCDQjzKCckxC5J7JtmKvnV4Z1MFlqIdiNVAyyzsFs5FCVMRlY8EtjUZFk
         oKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709696569; x=1710301369;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sRPMFk+WPPE66P0hrTxLGe+fMTd4KvdOtdDPJp5ER60=;
        b=qQZBaIrrNosE84MMJZUEZYBEoVExSaK9FXMxUXyZ4tQCp6hR5cgOgyT6P3JWY//N8b
         5/4XVxg6ItKW1I6Bg4ci/LVRcFG+30XrvGsV2Bi/r4W4ZsS6wLdNvgzlGbHoY+/4uCpX
         09v8dAe9RoEYnsb6TRxQagDEBNDjpwcx2mOon7KWqFD0Mf/JpRXvgAjM2wJ+qInbFupS
         rOIV4a7hXCSiWR/fHndyi6nvrV2fB2E0mdK7vomY4coZ6B0GLWeM8Jvo7h5sWOsesG74
         mNDz3ZD7GMCoZFNkkfYHeapOHaEHfDvMenkdBQOgnKy5LnxMt9vD0SRZDrL4EZJwAcrB
         lBxA==
X-Forwarded-Encrypted: i=1; AJvYcCV6hu0rWWQwOEyvHG/mY5Lvirh307oWZEaCmaXV1YPiZ3xTQxIeYB7nkPMIeal0o43MihL7FtDYHK3Ix6roWUcSYR3adNY=
X-Gm-Message-State: AOJu0Yx+IQnHSLI126SkoxoRF/TScN/L4A3ryI0wtOPEUx2HiF1vYOGI
	BZfNyFHP+yobKP67rFo0rtb5csZo9q4vbpTM1w8Dlh7wAIzcu4wWdfM71+tteKwvTiFI9NJJFH6
	5GLqwNeFhcOJLama69HLdHS6Ak6RkrXR/XVU=
X-Google-Smtp-Source: AGHT+IFTzNr4cKm8sOSz23mKr8JTtVR45bWwnWrjQshAJbH3fFylA98d7jKAOcHGfi0vOYprr+8AGW+Fb6guV2cUmao=
X-Received: by 2002:a17:906:cc93:b0:a43:e46b:7a80 with SMTP id
 oq19-20020a170906cc9300b00a43e46b7a80mr8777808ejb.43.1709696568566; Tue, 05
 Mar 2024 19:42:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <298b8a39788b5b24db3abdce70323cc5a17dcbd1.1687843228.git.geliang.tang@suse.com>
 <724f9aa6-b66a-700c-a411-5aa19768af53@tessares.net> <8c868c93-86a0-39ab-57d6-e621c833f8bd@tessares.net>
 <20230713070345.GA19473@localhost.localdomain> <c43a99a1-72f0-7ae5-c954-6d1932a7956d@tessares.net>
In-Reply-To: <c43a99a1-72f0-7ae5-c954-6d1932a7956d@tessares.net>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 6 Mar 2024 11:42:36 +0800
Message-ID: <CA+WQbwsnoGTfwc1R1svxd7fVk7_b5+6ZdT7f=X7jkRkigmRp_A@mail.gmail.com>
Subject: Re: [PATCH iperf3] add MPTCPv1 support
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Matt,

>
> Hi Geliang,
>
> On 13/07/2023 09:03, Geliang Tang wrote:
> > On Wed, Jul 12, 2023 at 10:14:31AM +0200, Matthieu Baerts wrote:
> >> Hi Geliang,
> >>
> >> On 30/06/2023 18:03, Matthieu Baerts wrote:
> >>> Hi Geliang,
> >>>
> >>> Thank you for this, that would be helpful!
> >>>
> >>> The code looks good to me, I just have one suggestion for the commit
> >>> message, one "typo" with the alignment and one small suggestion in the
> >>> code. Please see below.
> >>>
> >>> I think you can create a new PR on esnet/iperf repo (and mention it
> >>> replaces the one of Paolo).
> >>
> >> What do you plan to do with this patch?
> >>
> >> There is no hurry at all to suggest it upstream (esnet/iperf) but it is
> >> mainly to know if you are expecting something from one of us, just to
> >> avoid a deadlock :)
> >
> > Hi Matt,
> >
> > Thanks for the review, a v2 will be sent later.
>
> Thank you, no hurry at all, take your time!
>
> If you prefer, you can also directly send the v2 to repo, up
> to you, I don't mind reviewing it before or after.

I sent out v2 to MPTCP ML and the iperf maintainer today. Sorry, v2
came too late. You can now update the status on patchwork.

Thanks,
-Geliang

>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
>
