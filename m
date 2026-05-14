Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA95C3F412A
	for <mptcp@lists.linux.dev>; Thu, 14 May 2026 11:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778756960; cv=none; b=gWOpmrlhduk8Wco91lRxWYEvZhB7F4kLNMaL1c6Jiyd72O2KPAXbMJxi7auv7TsM7f8JO9f6V++VrQhC1VtW8EUyOCpGiLkQqEuH8XxwFQJ2rGCwhbPfz8Q8bPQxocxh64AIJ+SEe0usCys0hLkvNrvvXcN/+A5cLYRrJ2BtcTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778756960; c=relaxed/simple;
	bh=kyoamXUXmlRwFKVyLCV119qKfny+U8ARyltFUwVk88w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=SYrSOtRakFTc48kFkr/zIQZFSRquMc7Fu+Dyon4fjUMPM5GVJgyTnGuSq2SveF4uFqG3A2ueWN09+F25rQoXVvlY5/MfLKJkA9pa0WgF+QwpAvICd+af/UgdnzK4Ds9lZxIWb+4Gtw0lDPsBJXLCTZI65t0LzqDZ91cwWxhU0Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1oZuy1v; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1oZuy1v"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8d560ede296so879066685a.0
        for <mptcp@lists.linux.dev>; Thu, 14 May 2026 04:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778756958; x=1779361758; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3cQvek2aoMQeqOj+TpV7s6bX62AfzlHDTc49UbjOcg=;
        b=d1oZuy1vRivuh+X68+yR32EZ9sFDgcaJ6bS3FFERDqxVL6hOi/A/EUErwjFy+QQkML
         KUogt3Oauc4bsi/930omK84cBdEj8EDnkgZu5a6fHyXHCYD4oLQ5RvoQGItl434tkcD8
         xU8FH7Nj0rHWxo+wWJJDtloMMxkGVM1IxbCHEjx4scYLReanF7i/gouQRf2CcjM/0+KJ
         k7VYVPfxiRN5IGj68Se+iSpUHTvumK7dMYjCPla9o+7o978TlNI6r+YuRkx/HKjchHai
         84msGdCyxMUoB8LfXh9aWdFc9u4DsAB0ixxLYd8Tp+z33NQtbmhgW0bkVxfvX6l9Q467
         E6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778756958; x=1779361758;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G3cQvek2aoMQeqOj+TpV7s6bX62AfzlHDTc49UbjOcg=;
        b=XKDnk2/FuIY0sP3tP3jyl8c8U0Z4sgJyb7/0GHhI/nLg/mtLvFI4jN3mvbmSF0NLPp
         eKmI0Wm0Knn8OLjwfTNfW3iANBJk8IG/QLzgbwOAMKVEAhvJljOxDz9+k1pfoXR8wkLK
         7p/4h2rLO+WY9gh+vMPsf/31Tg46P44YuBeyJylvI/xEpJFjIuHTds6FLtNUfmkqa6Rm
         tC9NnpLye7FpnrkTY9pmy0B5/7+vpXjAY2RX3yNAI1vfVs9LLlEm4e08mdhjZwzCg8Dk
         vRoDR3CJUvqFtS1KUy2KEI4rrLfVp/XSNZ1CM97hdW0Dmuf3yYm4w5LEI34rpbXka5Gs
         t02g==
X-Gm-Message-State: AOJu0Yy1VQqu3LJX+NC+mzss84pNF3L5s6q0rjzQtNq7Ya6n+pbpvQ+U
	ABrLxUHPlrWqXPvj/DQDqfSK1JiTcIjJfZS1CkMi49HbAA6awXzPvTrToDWR
X-Gm-Gg: Acq92OH2wpJ1qs/+f0/7e7yatLDdERqfimSFjgW+vXi1CH0DWRsTV4lSKgASBoUxNkZ
	QPrjvYRL0l0/BpwcBs49THBk9y6iJ+8UKVH3AE0BFLEQEbMp9r/BhQEgQ25Hy3iWOvjxPcR4ji3
	fv+El8kC0SjkQD4O+hE16gJIzw1qnyJlk6uxPhmn5PywUo/fD+Ws3bZP3cU2WY0zyYIG0lBjWCR
	5oihM7YbZT5aen3WS8ThCFZz3x2I4uInEmR/9K6vnnZOrgPmjxklfpXJAHLTXAaxgy4yW6HmFew
	IMsmGT7Z0VJkDT2/9CwbHKyS8P3n55pI4ybAyEyuhjDOO4IJbdihMNANyOuJnNdrJ884IKuUyiJ
	bGxL0g4zde2GM1SZdKqJaKgDg/2kFP7tyHTrf4SHqTuXqULT3/9uB44EStYjq62Qd8tKlCPJw/8
	31GGPL+huhG6ro798xj4AjYTGa2gDdTjeFnw==
X-Received: by 2002:a05:620a:d93:b0:8ee:1371:4f7c with SMTP id af79cd13be357-90f8966b09bmr1079857585a.24.1778756957663;
        Thu, 14 May 2026 04:09:17 -0700 (PDT)
Received: from [127.0.0.1] ([4.236.167.8])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc83b85asm213460485a.25.2026.05.14.04.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 04:09:17 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Tao Cui <cuitao@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260514095007.405475-1-cuitao@kylinos.cn>
References: <20260514095007.405475-1-cuitao@kylinos.cn>
Subject: Re: [PATCH v2 0/2] mptcp: pm: fix extra_subflows underflow for
 userspace PM
Message-ID: <1b84ecd6-0a9c-d75f-1b84-110287d173f6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 11:09:16 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Tao,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/258542=
23893

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/34573f7001fb
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1094704


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
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
