Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68398225412
	for <mptcp@lists.linux.dev>; Thu, 27 Feb 2025 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740642522; cv=none; b=l9lpD1fq8URg2Yejsd492YOhFKUx72ych7iuqjvIB6zCMFJKtRan5CXLQg5gWyifDenXUyh4FJQ52H+XK7HM3E964VMiM0crIAIfIb7VrFu+7jX0UZDV832HVmbFA/eNh33HAFmp5FqZSdZNSGaVHJ0ct0el4II2xThmgCaLFPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740642522; c=relaxed/simple;
	bh=jAmRZ47/GAbWMEtW6Gq5cSKVHFchIkvYmuKmZ1IiAk0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=kViv5+rhbYzmuYSMEoLrgGfvgDoHrmE5jxcFhUBuk+pE6EZD/u5HKSKmAiflItZIFJY0EakCg4Ti//TZ+5a82AUGFudmggBDoRO2/OomUiGhol1mMW4z4YWntaHyw0vNK9LS3bpcBikGWhRzd33DQd7I5Q7U8cfB3mr9IkWqoZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbBVmR4X; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbBVmR4X"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6dd420f82e2so9201886d6.1
        for <mptcp@lists.linux.dev>; Wed, 26 Feb 2025 23:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740642520; x=1741247320; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giwp3odr+MCojvMP/9a9ymDN4wuU86aFjclc0RwLMU0=;
        b=mbBVmR4XgDOu/bGrnOpqCPjNqC3b/Czn3QsA5HLZEqHrEwI4zkWTSK8+1xh3ZyC1TG
         KYWwGcFfgR9rjjV7Zgxl3htXAGxCk30is/kiAQLP45BGT/CkCkQUTqjEdzdQ4JKI7/4y
         e33nthyuety5e2TN6Eg/ZUsUFvY1+s5n70gVVCnzQvQiyUYZ2jrz3+vbmRgVBietaW3N
         VkNFtjt33Qnb4n0aJXhDMweOokmfHmlebTaMJQ3khCbKpjRLi6352m2c8YC0Yd/Bp6Kx
         FkdtAG3n1yYXEWDVkujzAd21+qbq6zs4ZIZuTXRYpXAAiqEfn5Ul29NjsdxxZ/zNG7hj
         3V9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740642520; x=1741247320;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=giwp3odr+MCojvMP/9a9ymDN4wuU86aFjclc0RwLMU0=;
        b=DzC13P7i9FkN8DvBe/1t0jrrSyP9s0bcnW5Ky1RwwAWr292CQYh2V3yTpjc7XVkIge
         D9WGSdA9K/doMTpjjInJeKBAeBQ7BTa28muyKIhO3B6Unw5XlJ4mVQLjs0cOkOWXH3xV
         pyidHNthg1MhCgLhi8GpUSzMbGFDC3Rm0k33yL/nqQpAwOaKQdw5i2KyMBvVtAwhRSGR
         Q8ZvoXOU6tKo2u8H1tIyuX+WogiW77TP9DewwhMl1Ac+9kxhPtLKUIG8/Ea9Nu57eLBJ
         wgL98syzKtVV+hlm9NkmD2UKSTzw1DW9UbaQkqQzaVcbxk2UMWQlrQfKBol5GRdcsG4S
         nVfw==
X-Gm-Message-State: AOJu0YydIZHekyrbNy52dnh7OyEio5je+W5B22UAnzUOlePNayTuFMvU
	u+j16q4ihMxAROJO7RgWMAmi6dMO1U0qOzjQGYOOcizhEPibYQoeD53s
X-Gm-Gg: ASbGncsHENx6kcZGz6ZBj2yO6IX2XtJVeq/KrXv8HOoZulteTlFkqlU1iJqBPvIIevo
	VgDvB8O1EjBqrqIFH1ZNzvnFeqxSP9uLQeVi2ck5U00RZPL9prXLJbWG1kGoAOn//SKwSvljo3D
	aLljmLYjaxytVxkUFAkdSeJjmtskEI7QZXvKXogRRihuQFB8yXMPOc5MP1uCFA81tqLcqKtM81H
	BEkGpQwO4GsAc9bpakYTa5SfyZoo7aCvdklBBtHq6Gk2KtXDP9n8aPBnbsCkowFqmrc30mKBo3h
	zJRBH58I0I7hBYtscSe4U2JOoXzOXUmg5z1bPx4=
X-Google-Smtp-Source: AGHT+IG/W2B91Ah8hD/RYxYE6H5c/vmOwJJZ0OjS5pngokW+K97mYgqSVV7xL+8n4uDv+hzPgVkxOQ==
X-Received: by 2002:a05:6214:224b:b0:6e4:442c:2888 with SMTP id 6a1803df08f44-6e87abba277mr146850126d6.39.1740642520195;
        Wed, 26 Feb 2025 23:48:40 -0800 (PST)
Received: from [127.0.0.1] ([20.161.77.247])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976615b4sm7568126d6.62.2025.02.26.23.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 23:48:39 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1740638334.git.tanggeliang@kylinos.cn>
References: <cover.1740638334.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v1 0/6] BPF path manager, part 5
Message-ID: <aaa86f19-68a2-e4b4-4fb2-b6ed30ff9ab9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Feb 2025 07:48:38 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/13560646466

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2fc0cce80faf
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D938355


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
