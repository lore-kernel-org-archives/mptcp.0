Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB321259C
	for <mptcp@lists.linux.dev>; Mon,  3 Jun 2024 19:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717443603; cv=none; b=RYHjHnybw/CenFZiOY2arlYH15NlouscI/39ylqC1i7Oeob6GwZbw2ht56MtlKwH5dyPcQtkeXesMoubTBrd8Z6GYtqHr1NZ8FYzhrOtVEtp3A/WkoJLT1gfSazhKx9Y6zaHAa2cXriLqotXlfXB+8CAJXgYtW5Dgdc1yZB9mjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717443603; c=relaxed/simple;
	bh=bbezwj4MM00N2rfa4637qA45U0qt0MoIqbrhcdSVWcc=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=qkIQJkuOZc18dMNbAgXT/B54kmCvOpYlTdui0wgNSsuoK22AtNDYxlE3cPporxOfqehXiw4dUNoc64cy8axT/rfX3ORR2GHlr4pmmTjdfOQVLg+DQalSd7u5VMwmmqFYJskbPd7EO4PUO+0H0jrOIABpCvpFZQ5k4QZB9oqUozg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FahPbZzb; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FahPbZzb"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6ae279e6427so21649856d6.1
        for <mptcp@lists.linux.dev>; Mon, 03 Jun 2024 12:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717443601; x=1718048401; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOW4vAPGyQ49ahy/rlH8Z8nFF6qUlaB1hsZtGQdQqzE=;
        b=FahPbZzb/yzjxnvwfy20uERAsOY8bpPtQR+kIsaBpwKbiI7d3qxeludq/Xt9eGnGSA
         F7FJVYD3ZiknDm147opk40hB7Q1oKk8D/EEHo2jkWglxR/GQHYx0btkBivZBLcgk4iS3
         Zpmue0996nyM9thVzsV3oBtgIAw9cBfrMlEJXNZkBZ0eSjFbGzC5PJD3s0ZFW9LYaWZ5
         sTwY9wZJCIRwOSlc10MvZxOwZivWC47BWbUqbJyJiOL13VH7H98IqblOJBgYHd5Ktqgd
         T97yz+gIEWFJvimolmGcEOchUHvW7MfjZ528G0N0+yDDdtz6jj5BeTbqcAEMHjZ+MqTA
         CtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717443601; x=1718048401;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MOW4vAPGyQ49ahy/rlH8Z8nFF6qUlaB1hsZtGQdQqzE=;
        b=ADH2JTmN0jMLvQsCEAqmMkgiqwXsMsgiF74ef3o0hQMUqmppeUh/DF1I8pk1MUTuRl
         1s6qKrZUZ8CTaBTFDfgfFR/A7/gT5hRKuEd2r233sr3zdEnpfVwGBMbLwSS+nC07c6CD
         wu8VbNp4hQY8NkQ3kS70ZIR8Zddd+ktHBPDteDWgLtGHmenyBfDy9R8MXii/P4fim/de
         yDwyg7iNWTdNL4hZlJjmyIeAQ7A+HyGITsGDbqXZ9NebGwva4fSttFvDmNMQB0oSLd2J
         IK9Tzb7hVEsyfejKybYCwjrGqClYkZSPkpljmFk76P73lDtbKvP5UqHZiGv2A9ldXj5u
         1fcA==
X-Gm-Message-State: AOJu0YyqjaAMuO7lU1+H0SkCnbCVcZkkpQbTMGr6ysJi8XuF/ro11k07
	+5gIOn/C/H7IISe5ic/AhA8V5+dXTgzzqZdi2INqAFjAgftfJ9U=
X-Google-Smtp-Source: AGHT+IEwQm2h+E7NyfG6lizPYA708baBIIxftOkiDpF5cDglkTfcZqWsmXCW40YoKHrzl7LlpxmWNw==
X-Received: by 2002:a05:6214:5bc9:b0:6ab:8b56:5f4a with SMTP id 6a1803df08f44-6aecd6da677mr105513526d6.43.1717443600682;
        Mon, 03 Jun 2024 12:40:00 -0700 (PDT)
Received: from [127.0.0.1] ([40.71.163.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6afbcf61646sm13458146d6.27.2024.06.03.12.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 12:40:00 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Jason Xing <kernelxing@tencent.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240603170217.6243-1-kerneljasonxing@gmail.com>
References: <20240603170217.6243-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net v5 0/2] tcp/mptcp: count CLOSE-WAIT for CurrEstab
Message-ID: <6c6037e9-33d0-e19f-ee38-32f40663477c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Jun 2024 19:39:59 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jason,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/9355807888

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3b2b65c4b8ae
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D858351


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
