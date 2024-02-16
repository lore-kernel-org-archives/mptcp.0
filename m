Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EFE1C11
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 00:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708043087; cv=none; b=AWn64fFAEwYafb1h+uufgzJlA7FOCFn/FfKEy7tDhx8Cva39pbRMHTkgw2/R2/m0DHrcJMEnhb1myrrsex7l9vuLSH8UX7LtXicVFFHFeA0VGyXjuQs8n6CxYgGcAxfuKk0sho8QST6s2tF7MZCRb0ph8RuebPLrG7Z1CCV/2eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708043087; c=relaxed/simple;
	bh=FnQON7gaO6seUwBoFIlOaLwlXRQB5Z/OekVu1Jov7EU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=XP0f/pWgquwHozjONnTpT4pFWNYkQhTWI4YX1Bd4WEV31btrwGM9W2qfDha7vyad6s+DovoBRkG+7Sur5AMLIDRQ7ps8B63D57FowS8ADhmcKtPTHNcIqP89zlWyrmk3BpNHTPyg0hfCCciBZe5bjgIotfeG/p3fcuxdg3mL05A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9sMUbPQ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9sMUbPQ"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7872bc61fccso79162685a.1
        for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 16:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708043085; x=1708647885; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Onzcc0DUKkpa9fn2qyTAkCYN8FhqFUEkAor+S7rBVH0=;
        b=f9sMUbPQPpRIZYDaOVEEIluVbAHtYj0D5ecQG1xDJ7kFpoE33PZRsQDontAZg+fDH+
         Nl5fKxX2eKd2VhwyXrBTXKFv4a/mHw6woZ4q5P0Q/OE6xw5RcF64wnApVmjMjc4AvMqc
         SHj65PGxz5rH5vAMjQF9N5m3RYveUVgvaA/kpSXrWV7ULGnWXpQyQq7bcqN3W1wR/mf5
         o4xBe6ZURA/9Z/vCuhdvDMVEx2PXWtIKnRWaVlOl8TskZknrpvqosC8pZqj7cmIxptKk
         siCt0WIKRJWnVQfks1S5B4C4YEvNRUn3AZASzDvhhmy+pUuWr9nWL6ZAm3fqrHe70aYi
         iW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708043085; x=1708647885;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Onzcc0DUKkpa9fn2qyTAkCYN8FhqFUEkAor+S7rBVH0=;
        b=gvr06Q/MSTCWcfKPepUy1jB7aklXZ541hVvUHJ+yCYKuBiVsiLLt3ehf/uETNl3EUu
         dsO95w5zoEIWuuRkfadQcuxSdg1yBMlsGR+5w3TQYH7k3EtOsgP9gBSwNrnvx42L16Ry
         SbqfEZSj1E5AT9v+1azKmSNRzW5R9vzNCX5c53ebIt9op0fjnJh1p2WM2zvFzLo8cPvD
         0H43Q4LkvF0UjicOvtEMxBSz1qwzSa3x/FJPahXTjtrFH2rpA+BSzlCZu6ieRTpU6dIw
         vG6bVqLrDmupte/VXKxISQZVLAspGmrlEP1UbslmfzSkfIFfj5LK7//3/HWqL+Igm8x3
         idCA==
X-Gm-Message-State: AOJu0YydUME8jn/rR1C0bT4PrzTDJ3cjy4E1GV8y8HNg0huzwZIKXp7w
	V5lBQGBcHiiwNLg+uE4Zd9cTnfYobVYG06KNz0ed6nxEchfCX45eveHNBPw=
X-Google-Smtp-Source: AGHT+IFrfLzykco52o1ubWvQy3BMWHwKgRLKIlOesJG93opiptjkkAXUoN73NqDFuIQgb09cAMpG2g==
X-Received: by 2002:a05:620a:2103:b0:785:7d89:6b8e with SMTP id l3-20020a05620a210300b007857d896b8emr3653830qkl.55.1708043084798;
        Thu, 15 Feb 2024 16:24:44 -0800 (PST)
Received: from [127.0.0.1] ([20.57.14.194])
        by smtp.gmail.com with ESMTPSA id j5-20020a05620a0a4500b00787267dbc73sm1052390qka.72.2024.02.15.16.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 16:24:44 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240215-mptcp-fix-bogus-pr-warn-v1-1-d14c10312820@kernel.org>
References: <20240215-mptcp-fix-bogus-pr-warn-v1-1-d14c10312820@kernel.org>
Subject: Re: mptcp: avoid printing warning once on client side: Tests
 Results
Message-ID: <88ef3ebc-93aa-3e46-3016-73843b416e3b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Feb 2024 00:24:43 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
packetdrill_regressions =F0=9F=94=B4:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7923753742

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/70f039ef7f55


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
