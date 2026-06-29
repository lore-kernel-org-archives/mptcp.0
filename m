Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA7C3644AF
	for <mptcp@lists.linux.dev>; Mon, 29 Jun 2026 11:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782730872; cv=pass; b=a4zlB4XH5J2D7vLyaOySx34n1D0NFCsuHf5QCrdD3cNI069WS9viajLz2dZoa0pcJr/No5UAFcZh8wpwr3NNaFMH6JBIkytjf9/qXdmX254+fuqnWjK166Y2KDuT7mAkEHBDUPwHsdym6uU9pr0I2VKczWQMCOAOYR2KRcktcqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782730872; c=relaxed/simple;
	bh=mnjAikTk0vv4dO5nL8VUxxfpJVPjQ++bk5iE6002ruc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGzx0wRUOdGjjAyLVASLIkIJCMgwhD/9EhSzOJKBOCspFBdDCcue6LoJCoaQ7ipaB4phbPPE3T+PwpUdiNy+h4nU8pcpiFLboK+Geob8Glm59wcloPWjkaIR2ImrSb1Rtkfyf5etFkiJ2hPp5FwcWEsbFaDxv8uYgiPcjUEUKdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7nE+Bm5; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7nE+Bm5"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-664d7863920so739165d50.0
        for <mptcp@lists.linux.dev>; Mon, 29 Jun 2026 04:01:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782730870; cv=none;
        d=google.com; s=arc-20260327;
        b=aUigUmkpKvSTNsFetp3hm0oS602VGsDhhVwT4zM5KAN6dZ0eU3b3Y4m1RqvuHzfnxv
         o/YvUG62ChU3wwAAS+p4VQcCe5jhsjvaB0uEhcS4IuLQx+Nzxk3uJzvYFcV0m6L+Ei5n
         02eOBj0HVVCi+aOKSQLWOqHWbVGZExHC94YcdFX0WrgtkWwRo9l7zA0OVQ7zmaqF5OpZ
         CHpvGf9NYmOJfsZfOmmBn5eZfXdxSU8Xj9cEDYb0gtTl1J1AK1Ib2Q5U8k65b2ijaU5A
         Yx/hqEgB1PSecqGCsgoH00oP2ONo0+fAGqE0SbbTFva+y8ZAheULioHDbJu1ggcGYGeU
         RVsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wrWH5ScwQ0Ic395xhzkFoF+xIvoGXKTlXaVtM87Ug6o=;
        fh=C1yV75gHQ9MLz+IjNXx4OhAA4JYQVFbCQnY2DCsMGB8=;
        b=KXGuOPrBL9d9/caCe94FhTlqAikby6GhXIL1aCSWDhpxyDat1FfHFrF4V7uqwnkK8Z
         34ZE557HUei6kGnlLQLPg9f3vdWG+c66fTkSLeow4hVD420LgHuAeEBywIRfni6HIHx6
         sqBHrMbVK2agUFLfxhELMUWvut9C0CVsdlf10WuO6IG3Gd7doOCFPlW7yUdkuCWqQ02h
         9lqc60P7Cm+chgOxkFdMPSP8++ucjG/MzcyP8UInCAr5UETjnnCvcMewIKnEpEM3ws6X
         mKISANWrUmaQ6KvyM/yZDvIdvEOiRRFgsNwKY3wpY8f8yqkuv0egp4RNwkQf6hRgkpsB
         1Ijg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782730870; x=1783335670; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrWH5ScwQ0Ic395xhzkFoF+xIvoGXKTlXaVtM87Ug6o=;
        b=c7nE+Bm5/LvsYnnbLF9JYECb5wIgVQ7zPHBrFFFBPaRStPklpjH7QukSJL9ZoWT4Vr
         PL2KdtjOMi1vRSVYP4Lc0OSnZu2B8VURkrgcfYAN1IFdEOs1QwUE91zPupeJqtWZevfo
         5tKLzczqw7031OOHbCnP2gqjHaa/waOKh1FcZ5K42xRcuR0LBe43IUth4LOdk3eTOTf7
         7rZKQUg1t7ptDqeHyk0rXEpSyQT3CgdTzhTJW16lGWKj4ClEEZHInJEHrRTJ/jhvFBtD
         sDp0MW7i7MzuZ0XfIcnyb/BUO40RvSNlqVW4GW0dRhL3zAPTnT/JQX1Y83tvLaItECPU
         ziJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782730870; x=1783335670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wrWH5ScwQ0Ic395xhzkFoF+xIvoGXKTlXaVtM87Ug6o=;
        b=adAsvImQ3xWJuMAX0N5sSUtLodozPkDZi3e+siSiwN/LrBF9k2i6qYo4LL54i6yKfy
         CgNRx53yt2DW5z72RLh+iNMo88vk1cQeCgIdzt1q9dSii45EOBzfVzTSu+VelVvq2xFZ
         tTk1ik82Zwb+xd8GzFqchdhX1do1RJ/CJrtmU7qmPIPhhE8FeTH96nAhckfvWaMWb7LJ
         wDMf0u4YWMR/r1bRUNK2U+VX7PW4iXnOC7O4ofOp/KXCTObF0zyjtRX2Bm2ZeH+yR1tn
         Y5rIdOz1/gQ0mpASQInnZSa/MUDPF6bfy6n1oi19FOkn8nBAAnC7c16FblsZXXQ52dhg
         vKgA==
X-Forwarded-Encrypted: i=1; AHgh+Rqfliu72FfgsN2ZGzDwHKF3SUuYhWS8L7uw6oPkqRfSBoRiS5p0ITMEOQ/n43dSyHFIhGAx6g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEwYyUPm/Cp5Dn6nR+SR7XLOrrBTZqP/WLxC+XeyTrteQYtKgI
	jC0dTfmqcnmAwehA3JcudCFkAGO045d/JCyCIHUFVljuejCVaU0LmMEKUMoLCe0QAH4rAkmY9rW
	jBS82gYDX3239hL4PFAxHrgtXvB5HtuI=
X-Gm-Gg: AfdE7cn+E8hCHR2B8G3Uwf2ZR5GCTDBVoTZFwIAUjsxW4F7CKWhnIXVEOx7BKHTm6qy
	+sfpLhL0woPIvokxhYL7klQAkvBepNl9cYBbJ4Asjdme7OmNYCGk2Sl/lejHTUTstAl4U8drG0x
	qsGhnBht76dtRO3UiLjS/j1PwZnwrhLM0GicLESh6weMPGM6Fifl23IYCG6f0eBT62s9qQEUPmh
	XNpCpXMw9Sc+4sq7dsYpLFHHAn4mnlpGnRgY61/c75ll6R3cHHBh3YPKaNcen71fdvJERqZ013z
	D9apA4KHFlx/Vyi3u05idzmMLA==
X-Received: by 2002:a05:690e:13c9:b0:664:c1a2:36ed with SMTP id
 956f58d0204a3-664c1a23e05mr6439084d50.63.1782730870031; Mon, 29 Jun 2026
 04:01:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260617215725.1116295-1-michael.bommarito@gmail.com> <3ad5bba8-18b9-48a6-94e0-99d958f23984@redhat.com>
In-Reply-To: <3ad5bba8-18b9-48a6-94e0-99d958f23984@redhat.com>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Mon, 29 Jun 2026 07:00:56 -0400
X-Gm-Features: AVVi8CebS_wHEonSTuO6wt_iy1ve7dsxgWilTCtlVWkEeNvzRN3DOJlfDOphaVo
Message-ID: <CAJJ9bXw4Xz=Y8Jt1KxSTA-0EOfKU829zGF7nJcfwWPQjh4ZGyg@mail.gmail.com>
Subject: Re: [PATCH] mptcp: only honor zero-length DATA_FIN when a mapping is present
To: Paolo Abeni <pabeni@redhat.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 5:50=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
> Isn't this fixed by commit 5e939544f9d2 ("mptcp: fix uninit-value in
> mptcp_established_options") ?

I did the reproduction ~10 days ago on linus's latest, so definitely
still reproducing.  I think 5e939544f9d2 was on the TX side and this
is about the RX option path, so they don't overlap on flows either.

Thanks,
Mike
