Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63AD43146
	for <mptcp@lists.linux.dev>; Thu,  7 Aug 2025 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754589080; cv=none; b=joF6ajFWcpTTtCtRHNuHbE1m5bdktCx+akgGMY/DtFoXKkVevai37x9I2LmSwP0qOYzANFZmSJdDpnQxp/u/U0MREmK8vZxg/d94apBJpO69G8d/hRJbUsmmCbTiv510a4z2R5Tu4qUrCkJ38bx/Uouz6qND1yV5LZ8cyjwEWeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754589080; c=relaxed/simple;
	bh=GuN1jH2XkXjG/USNatBRKZOmLWLHfAExst0T1e1cPoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhSywHYi5E65IYDdlgi1zryGBBB9FVY5nMyrvvOWJNyNA/lzQvcxjFQe64kgsYOPbdEk4RRiZDFl2sZT8Rz5fqa1ZyP+ix4E+QgqVbSNuK8Ien8pCiINdE8uRP1Uyg4seO0yvp7uc/tFYyL9xwUYR5uDz3/AvCzWt36OQ+CT8Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=B7UQdEzF; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="B7UQdEzF"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55b96b154bdso1261522e87.0
        for <mptcp@lists.linux.dev>; Thu, 07 Aug 2025 10:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1754589076; x=1755193876; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bQe4XFO+fr7ySAU0chXpDFzN9nVHM7VFqfRezmjMbE=;
        b=B7UQdEzFcyoeUXSk1LCrWErx3hkMug1Na+/inyb/UlTK/mGxlvCRu7ct2D5F31Kkdf
         FR9Owen7jn78rcNCDTvkkmFtJR3PpC0q4ef8QogJ28psJNfFNmIVe7F/3m+D/8hp7kfp
         GFICXBWPVIl/3pEuGepiAYjR1IkD60/M39S+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754589076; x=1755193876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bQe4XFO+fr7ySAU0chXpDFzN9nVHM7VFqfRezmjMbE=;
        b=uCXtrR0Gxwi+TwmVLyR95Kg1E+QpADNpuw5weIrQsQ0M37yEeMrGFzMQWe4TLRAflz
         kxfDUvCVkr+RzAMIBwBvPLuEdOYd9S8eNc+0RdG3p50LJ6Ts59LAShRFTS33wnQ/V/zr
         20hXOXsJ5nU74m6ZLgg4VISBYdGVABpuU4Cq59hulOQZdW28Ju2Uon1r2zIMChOSEh9d
         Tna+Dvwi+EYg86kIrEifrgwsKzJxA5CQJ93vdVsu0jZXWR+knc/y7nhM4wCplxPGOqEp
         5g6UrPKUAcKFKvr5JPjfmfMq5gyHaZoEFXs2bIIy6nCpE19b7SU1c2cXqZBTXWGF6kmx
         MC2Q==
X-Gm-Message-State: AOJu0YzanNo9vIYU98ScWiOdyXPH9bHy3RNmK37vEahq3nBuSKg0eJzd
	nxBk3vvkVK0UVUk1/72DDQf9LqCFglfLPJcyHVSUazqWmeeEa2PI5loCPIJphuJ6luNkQs/RUAF
	S8qGVfHokUW4uz2lieC/viFKd1blBMixCxbzTvK9K4w==
X-Gm-Gg: ASbGncsXjmVD/lsPtM8PdJJDvyR36IsOoud+oi8NZrOSPRj9GYEXjwKXa7h7EOVGwNL
	gq07hHdRgrkK9IfY1U/l2FFB3ZsM8Wkg6fhcdoscWdPVkydyJ97XuX8f8JN7bROCAPDzV5WMk9m
	UbCK6XiDustRSrTQSGCgAADpXWO4D+AsBJvwMNR/SkfF0pCZsoFaMkmsx+MpQFJqqemSEQPqhew
	piQ0R14Ps0Wr4XM
X-Google-Smtp-Source: AGHT+IE4H3r2U/PVcm9D5Lw6kpI9EGAhFrAPvACHcUqTUPiDbfgNh0cl87ShgXZSK3aOHebpgHRCIDvIx7Q4TNFHWB4=
X-Received: by 2002:a05:6512:3f0c:b0:55b:973b:d9bf with SMTP id
 2adb3069b0e04-55cbe6285b4mr232689e87.5.1754589075892; Thu, 07 Aug 2025
 10:51:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CADg4-L8X3_O5O67NfcE5PUeNWWDBqa1cbQ0L9L0Ti_Mn-m-7Jw@mail.gmail.com>
 <f833716b-32e5-4ec8-845c-294c519e1b2e@kernel.org>
In-Reply-To: <f833716b-32e5-4ec8-845c-294c519e1b2e@kernel.org>
From: Christoph Paasch <cpaasch@openai.com>
Date: Thu, 7 Aug 2025 10:51:04 -0700
X-Gm-Features: Ac12FXyfhpb19KcrVxMIYX19n06dJSRvtjeipOlpnk5SNX65reZNhpW3ON3BiHA
Message-ID: <CADg4-L_wscbqmn_D+SjwYsgnJPP9AcVire4Ae4AjMMzoZyaFaA@mail.gmail.com>
Subject: Re: .b4-config in export and export-net
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 10:03=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Christoph,
>
> On 07/08/2025 18:35, Christoph Paasch wrote:
> > Is there a reason we have the .b4-config files ?
>
> Yes, to help people using 'b4', to use the right prefix and to send to
> the ML (no need to run --auto-to-cc)
>
> >  And specifically them having the same name ?
>
> It has to have this name for b4 to work as expected.
>
> > Because, when managing different branches based off either export or
> > export-net it creates a conflict when merging everything together to
> > have a single branch with all my changes.
>
> export and export-net share the same history:
>  - export-net is on top of net
>  - export is on top of net-next, but merged with net, "almost" on top of
> export-net
>
> In other words, why do you need to merge both?

I have a branch with some fixes (based on top of export-net) and
another with a feature (based on top of export).

When I want to run tests (or in general do dev-work), I want to do
this on top of all my branches together, so I merge them.

> Please also note that these branches are rewritten regularly. You might
> want to use 'for-review' and 'for-review-net' if you want a continuous
> history.

I rebase my branches on top of export / export-net / ... regularly.

> > Would it be possible to have .b4-config files with different names for
> > export and export-net ?
>
> We cannot rename them. We could remove them, but I think they are
> helpful. If you need to use these branches, can you not add an extra
> commit removing these files? Or a '.gitattributes' to give instructions
> about how to merge these files? Or pass that to 'git merge', or use
> rerere, or ... :)

Ok, .git/info/attributes does the job for me.

Thanks,
Christoph
