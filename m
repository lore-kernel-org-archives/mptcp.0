Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6024E2E719C
	for <mptcp@lists.linux.dev>; Fri, 22 May 2026 23:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779491444; cv=none; b=ovYVazZbtp6WNQNxD1WJ/CTYMBDoWAXPfjL3uQsIbD6aY3LqcRydWj4IEWslZoiVkTzD1rgaPQkQtZMWUccU7Akvd/TQneNiCPr+oqk0U0h9nRfUXswNjJwsIrO1XrPjF7o8cRYC5PZczS8plG6cwn5ZNXGFUMhUeUkJokblY4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779491444; c=relaxed/simple;
	bh=rtqLcHFPW8iYA7pagGUJycuJe7GWLsBfh0zhJy/ODvY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=kZa31SFFIG9nSXVpUapJbrFxTZb9z/Yvl241SH+yWKXnuuLWkc2ZgJRbO5BfZtHmm3qMpOJSLrm7YO2ai09xlaAGZIItMJlTF6f7i7TJEJHFHJz8H/gg53rG2t84JFGg2XDjdQML3CL/E6CWL9kret6kD8pZxejLjokqPz6Nf0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEv/1ZAV; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEv/1ZAV"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12db2e415a7so3926024c88.1
        for <mptcp@lists.linux.dev>; Fri, 22 May 2026 16:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779491442; x=1780096242; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbwB4FeUUSrTgOuXWKlv5q3SZAa0nIDlA7LhOPTaEnE=;
        b=lEv/1ZAVO2QzY8dJKSAyehyxGwOggDkZqMjdN1APxi9RDA9lrkLeyAURJ61izFGgUE
         hk1iOJko4ed22owSi7J2I0w3WauzBbXjGhz9TPi7ocfveVK3t4KVNTUmPjxSR1VzK8xN
         66kELY50iKOYehNEa9ECfCxCsht/gRZwhNE1QWnauNVUgWDQ8EiZBBwcebgJi89ghZsL
         Mon5IvoGsVlq1P3Sxxl0eiMQarJQkR4Dj60q7WkEoH7y4laViBbglLFTZF4w46XBnXIA
         uEBijKtZhH/8UuFy9qqvB1ZhVAXUvGPIijxdl69akQbrZgqDg7Qd9IkmueoEOk53kt6z
         RNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779491442; x=1780096242;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qbwB4FeUUSrTgOuXWKlv5q3SZAa0nIDlA7LhOPTaEnE=;
        b=ibSmNn/AQiiGLhKa83gJcxRmrMkQLthzCG/OuZo8w/FOkoL29wu+N/U/dgf1m8VbmC
         12xMmYOJx22ZA0eJx1h1N+sJkqDGsfvsrXOvYLDrqz3VvErzPxyZitCTiQaVvXoQdG27
         lDat9Wt5u3WzHL67TMkrcwm9v/VRikm8jbvXdmhnPDC8kLVgcFRTlQIAYtOlW5/wCxwd
         N+SbskxNeoXdY/ZJ6CsybTi/6mHYX8fl2ORAVgxri5y4xl7zLbrytJ791CK1vzEI4EAx
         zEzrXynJ1ofMMYwjQxZa6v1DCckbefW68SRkQmJkFKqA0H6EPPwMu6i7zoLipJM1Vfrm
         nWQg==
X-Gm-Message-State: AOJu0YxFEjpQfWGE+obQqGiZAKKh84GnBlNPXCB09F6owN8byzl5uD/q
	idHlOL9QIxdhZb8mdDquxBQXla0Hrw9WOmIRnbsCplvT4o2wIF4FkyQ=
X-Gm-Gg: Acq92OGqrxqpYLIarTiMpa0UbvPG9Ibq9v2qjnspqC+YfAkUqwdS+quni51lp0CzHT+
	zsWNmQTFXauZiBXUF0xx3g11hEUCGu5jefkN2vluZqUoyRm0YzqQYrRzo+5vfMiAFLZvojvRHYd
	1O1OKN/RILrzrQpvrMLjfemUHx0m1+nsbWohBuTRvyBytzgLgahh6bHZWhH0QfJ+xv1rRFNi967
	qbnDOhkGL2qPOTKbts7YMGy40RFqs4Cg7ZJmtx43cQ2wV570050Oow0z4gSlE3FezaUDceQ/8le
	/SVOTITujBsuaGVlwzaHHhsiEKSLAkWYrFBAe6BLLNpAke7KcPYNd5By4qzhnwWLZNNuwK11rtL
	hjxItroVOxWWVZcfC8Fl+rSYfTkWa2/6N6/7S4FvJ41+q0u52Bugus0TdpjF5RSEqEExvFrXlPC
	j3KHtrLb2xH0dN5ayiEpOw05rE8NKgQudDVQ==
X-Received: by 2002:a05:7022:689d:b0:127:5cd6:fa45 with SMTP id a92af1059eb24-1365f818ee5mr2350469c88.14.1779491442175;
        Fri, 22 May 2026 16:10:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.162.4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366aba2b9asm2509357c88.15.2026.05.22.16.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 16:10:41 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1779485511.git.pabeni@redhat.com>
References: <cover.1779485511.git.pabeni@redhat.com>
Subject: Re: [PATCH v8 mptcp-next 0/9] mptcp: address stall under memory
 pressure
Message-ID: <ea3b727e-3bbb-0600-0910-474f7e996da4@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 23:10:40 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_dss packetdrill_fastopen =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/263142=
95414

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0bcab31fe736
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1099630


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
