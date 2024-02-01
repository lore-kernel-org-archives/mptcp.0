Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136105E3B4
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808184; cv=none; b=NDgvft9tZv+PWAgFcXKI+0GfYIofYFXOHTGoql0hwOaPAEHMRH55lvkeB4lyvgKEeCMkrBQvyW89wFaoR12wC4ZYuc4mWlOg6jnGRiUKrXgDDGb7nWyubq13MhRXtvRZg+IpsPVdvsSWg10ApdfQeJLUMzyLDGY6I3HZqAahRPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808184; c=relaxed/simple;
	bh=rVHifbe3TXmZL96NgOyqMR6uEVwKrope3/K9R0SAhao=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=HG5Kf44p0Jl9TRFYkMaNMAJp3v/DSj0Xkn8KooNKkFRPH7+qbf/T4mxnNJ2unmSE82Ky/zh4gpbNDYFf2jCo7kBYa3XubORqXl0EUDMrHcJzCxLYSm7aFvJiVn8dLbHG8GMePTiK2ss3NfO6UIKU1Vh57kklnikZeT+Ot2uyRUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPNQKPoz; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPNQKPoz"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-68c814135a9so2460556d6.1
        for <mptcp@lists.linux.dev>; Thu, 01 Feb 2024 09:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706808182; x=1707412982; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vs86htT/c6ULhRUYVxrkavXcmUidhyyjY6n+RX6h1sg=;
        b=lPNQKPozEYEW2TS2V0xycMLm1KARdMAeDCDfRrhIF6HD3C3B6iq+ywdJ95bmhg5rUx
         OxlCZk/hPE7NyfupFVqEEvcNtcOO55HAx7drMcampzYEgidaO/EMpKx5y/xI2BM2hpsu
         ONhd74m5GRrrkTVA5QK0Q6fAbCssqywjrjn/aFk60I0tNcPx2Xx9Ja0KHEKcIufbc0p3
         K65b7n4XLgR5ONuXd+pGGe385zeKQOrg9lzPb0d+L/0BcNsK3IFp08H+RajUpwJ6y25t
         o7ILJ7dFY8YNDLt8nxqn7qeXhbLaqfrbr/TFcplcJdlOaFTEoAzoBzcjlVF0VM7qwMl0
         FpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706808182; x=1707412982;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vs86htT/c6ULhRUYVxrkavXcmUidhyyjY6n+RX6h1sg=;
        b=s10YDBAyFn7Jpy/w2aCXjcKIyH00X9cfxbYfP1+Rv4u4hQdT4X7XyZp7m/d47egsxb
         2qhRvrUy6U0FeciPARaJisLczgF+QM6oWwE6Z2dXTSc8rbPOO+HTv/yIop5Rg6+RnQHP
         92M0ihNcxb9ixyEU2SoUQ+WmZyjx4S4j6OQqwUDtOAegWAgY5iIXEzCwLWQFvliMrYUT
         wmwH+ocrS8b3qNRKmuFpQQ/KEd4KccI6068P36VceTmheu+7y65gnUPgDdBs0jTSXcx5
         UXw/SGdvNUcGdQGlLw6XuPy5cIVjLKw6TtCgMWJutrxcXmzqzIAqFj0AMYYPd0eaIQU+
         0G+w==
X-Gm-Message-State: AOJu0Yye7lwSlAZy76gSEUGpOxTJ1ca0HRq64cp5bwaDUBjCMzrL53pX
	N4Gs+7QXbGWUlZVXDhR12wcie0jwI0PA5mMWK8/G6l2SDPRuAxajBGL/FEk=
X-Google-Smtp-Source: AGHT+IF4gPjgjAjqfV3e9QqXbMchNCH6/l5i70lZ3C10hNncit95S+9XEp5kJwai4UlAXs4x+eeOkQ==
X-Received: by 2002:a05:6214:411b:b0:686:aaa0:71b3 with SMTP id kc27-20020a056214411b00b00686aaa071b3mr4985929qvb.4.1706808181924;
        Thu, 01 Feb 2024 09:23:01 -0800 (PST)
Received: from [127.0.0.1] ([74.249.21.252])
        by smtp.gmail.com with ESMTPSA id x19-20020a05620a0ed300b00783534c512bsm5824310qkm.32.2024.02.01.09.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 09:23:01 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240201-mptcp-check-protocol-v2-3-1e253ef51990@kernel.org>
References: <20240201-mptcp-check-protocol-v2-3-1e253ef51990@kernel.org>
Subject: Re: mptcp: check the protocol in mptcp_sk() with DEBUG_NET: Tests
 Results
Message-ID: <f88add46-994f-6a64-99b6-689f830170a5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Feb 2024 17:23:00 +0000
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
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7744410100

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/05d35e87fc2b


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
