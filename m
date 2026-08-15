Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C935F2641FC
	for <mptcp@lists.linux.dev>; Sat, 15 Aug 2026 13:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786799225; cv=none; b=fMLV134r8vKYzp0OqHHogluy4+5mQyk5fyYsXjr/qW/aTWb0HTbSRH8nQzfCQY51Pmg401uq835EJ3zkXNjTorRR82bFS8D7hLSkUsRW2Ry/XUgLtvvOQRqnExl8cOmKPd0X9dUubBXsFAok37aeQZPmMccB0jL3F0Fz6h+EFDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786799225; c=relaxed/simple;
	bh=gdqrdeZ5Mw/ix+euaX4vZHWrb5SEUQU4K5BOuII0yqI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Si7YadvcBxf/e4vsRvfgqe41m0SdPw/F8FN3n4ZuHGxyuTiNsZsp2oHeN6AcP/iUZGZRJ1PHG8zRo3feSdxoIw05/JTlrzBsze/ayqRcXgNJZbotXScENBpaJWu2EKF+kc4NqtXqkkcLx4BSe9Rxu1mjVV8OUH1b9gVbeyGfyrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wit89js9; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wit89js9"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c16ac21acso12385221cf.0
        for <mptcp@lists.linux.dev>; Sat, 15 Aug 2026 06:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786799212; x=1787404012; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DlD5ty1tgOxgrKXOb5KddG0bkdZs7G2LHhPuKc4dI7E=;
        b=Wit89js9bG0L7ySxE53OC3uf/7CnAjUjuCftLKQ2BV1kMc/rSgNGYJcjLSXGUN+MWL
         U4X2qNIioTZyFVt7o71STXuUpNK6TRLrMyh8Xgeczhm3pOqyDq6e8hNXmrQJxZPV5Xx0
         NszFLzCD0o2Y4T11PQOw1qg4nfWeFvwr60Yc4d8jIYhqMkh6OfmxYoQflZy6vxjpSCmF
         wR3Jpno/r9TLfqr2KKrRJUP0Q8KODWt/I5ny2PZyZ2vKdHRb0J3fzmZJ2dn/b+SYJhZo
         1PjyLJo17YAbttg84K652MxaeeRQyFiap2chRp7oaC4HJKWNlD/toh/JoMYDWreyZbL0
         6tQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786799212; x=1787404012;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DlD5ty1tgOxgrKXOb5KddG0bkdZs7G2LHhPuKc4dI7E=;
        b=hdlk0wlXka0XAgySgwlnpAAoS8V40m+uVe8+kVjAH2xB/Oi8wRKsohRLNOVuIYFzOQ
         3QPKylM2rmk1pGuKXWbI03YmhzwpIlyyXRGSD3Xe2RwzIC6kxb5btV8Zkea+yv6U3I+c
         NE9JR8SscF6AlW3+zJx2jAr/VvkMBko8KZaAytK+1kOWOTh97fuho0fTgheB8TmGaehL
         Zz565e+NsoyNmKcbSSGOJjdT9MNjsuNs8lYzQNdgNqkHQ7ch19du2rhzdZiPJMItaOcu
         T3iAHH5F8n1aPO7j2QdgCDFSi6eT0yhhKulLggvXeDC56vK24qoGsO5kovXYRO5sEexz
         ERWw==
X-Gm-Message-State: AOJu0Yw6oDakB66PFL3U6wuUCBhzKWxj+8DoLKOlvFySYe2p0Cm7Tghv
	qRpUCveEQEvIqRMQpFkKPpgq1Om9598t62XiZ9xaCSvdYH8qJYoyOBc=
X-Gm-Gg: AR+sD11EVcRmPQL4Ia7JXSQko8geQ3Xo36UY/42e6PrGK05pB/M+XP4nRPp9V2ES0VC
	9w3R/GrPInCpt8cN6qKxgvNLVSFGtagR4rN9sWpSZ0K2d0C6dLIb52CqezujT7oX2CmrHmrYvk+
	mpPKRertGQEglfx6ZL3WsclpfSZ1urtW8I59GgiMh1MBpfCkdRZsQiGB62aC09zkkoNpCLeNdVR
	GsxPU0cy2p19BEBdumZHmQKcWeo9dtmFdFkKLREcl4O+zsliGuYW/1Gk0MDyhqZPYCjxKutttCx
	c7kHYOIEgj+c4rcpuUkEDumB7wikrJa3Aif9rbaf83EWmgeH4rckNTfwSrPWx8FQWI71vYDugCO
	vTDudH91he+BbVYrzjhsjf+cIOtuu49GrLqmpNn8LEc4Vv8WCKBf0MwjpxC31GcNDy/qKZJU/UQ
	OknMoBl4PAhxxwu8hIqI+0ZkC7FkvdcK2Wn3uF5JlHUlph2jp7N6TqEbz2jf8fkQZHd80G1Io6d
	PGy
X-Received: by 2002:a05:622a:c6:b0:51c:1e2f:1281 with SMTP id d75a77b69052e-52d854f1871mr141654131cf.42.1786799211471;
        Sat, 15 Aug 2026 06:06:51 -0700 (PDT)
Received: from [127.0.0.1] ([172.172.237.177])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d83ece848sm42113401cf.3.2026.08.15.06.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 06:06:50 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Harshit Varu <harshitvaru666@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260815115205.197151-1-harshitvaru666@gmail.com>
References: <20260815115205.197151-1-harshitvaru666@gmail.com>
Subject: Re: [PATCH net] mptcp: fix uninitialized local_id in syncookie
 MP_JOIN reconstruction
Message-ID: <96ba4c7c-4e4e-470d-6bee-ee54acd56cc6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 13:06:49 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Harshit,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/318842=
29084

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6ac3c6cc38ea
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1146490


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
