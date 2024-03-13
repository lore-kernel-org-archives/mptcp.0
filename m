Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C9E3F9CC
	for <mptcp@lists.linux.dev>; Wed, 13 Mar 2024 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710335574; cv=none; b=LlUkFrCNxHtQqnQaXY7rWCV2IcAkXIqO3g+dYd7e1rGJIKEuzvMLHxxsZRGWgjDExZYMYqPDJCRJtaLf0n6vnfaKzlJn1QlecAX43DanzdruZbuwEJPZLsNF1MJ0G5ldqRnCS87BqH2LQmHIuYbjg58s2WSOE6VoNg3EkZiKwbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710335574; c=relaxed/simple;
	bh=idRT2EkoKo+mWTrwp609DkdATxiT6wb5IdXqEaUIKos=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=U1E3aVYabpAcGQLkiU9csF6muA9RKfdPMGlOAYQVsqr3R9VQv7SiD4rxlXAYrzgBbQsbPcstCLb3v01oCn7stv3J4qSNP+dQ2Eop7RH/7NmF3lBwKfZ7YwRWZoncQ+i24aSjnbDSY6z/OCebjVOF9U3hvXoZf4/vkSD2ahA15Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TopjvjBA; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TopjvjBA"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78863dc4247so41026085a.3
        for <mptcp@lists.linux.dev>; Wed, 13 Mar 2024 06:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710335571; x=1710940371; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FB+d6o4nnxSNXN7l2FJUEvNkNEK37y+W5qXcHUXGr1U=;
        b=TopjvjBAYVWoSw7/wkHUi6ctsk4gil+iXaonOA29pwaj1vOuT0dqtKtp70P4jkmQoR
         IGb4K0MD8RDamaR5n3i4aStdYEYWuoimPtR/dvdOJMRagz+Xp3LGVOGp9DGgNQQfHYe+
         ocRMXefT/lUTvMywWoITz+mo4Bkp7JDS6dUXKVwMdsku2hVDPKWlDYf9wqMB69XQzmsv
         jC1G4G2Te8zkR3KrKG+0f42K0qVetJkxm5/iqixSOrCnu72r0i9utAb6d6rqBVqtI2g0
         kvEl3mq18WHxZn7KRGuRc/c5UWAtEz8es6R1JG3I8KuESKQ2DdAb0/HMYaBw9+qo3Yt8
         xxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710335571; x=1710940371;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FB+d6o4nnxSNXN7l2FJUEvNkNEK37y+W5qXcHUXGr1U=;
        b=tWC4fst8SB/x89x5WHWKIOSEvkk2YAiHyvXpMattxFwm+gJ8Anrkxckz20zg/aTnfx
         C+0QXumcUi5aRijIvS7jdMmVN7gPgMOADZKf6v4gwQfB2iaqiA8DgXFkaqQQHuxehYtq
         Y3VG4ICirswnvp7Uw03141VA7W9fkuzkI78xn7LDo20etzqcgm9ifFv6pr8dLCE9S9c3
         YdLycHQlVr16gv43lvn9AYAOGwMRtFU3PXKTIU77x4hDAgW3tnxoDwUl4b2g4C4hA8yu
         zx2G7qLIQycHJGYL/GaIw2+JgKswOrb+A0TJvvi2MR4IGpTvJWVxbwo1Tel6VylyL3Q1
         buJQ==
X-Gm-Message-State: AOJu0YySHE0b+j7OGKT+vIIystXOBBbvruOJ9rI8E5yIr40gfUWS3hAb
	fENbFBZvy/70tID1qAYRODH1XrXeP4sxgq3TvwxYyogan+oMmNs=
X-Google-Smtp-Source: AGHT+IFY4sz/wxrjxjbgY1WXoaUV9NELqWpB6nklTR75SOb/3WlhJCst7gisvpuW38Xh+MDArTaaIQ==
X-Received: by 2002:ae9:f815:0:b0:788:5a10:e787 with SMTP id x21-20020ae9f815000000b007885a10e787mr3138922qkh.74.1710335571375;
        Wed, 13 Mar 2024 06:12:51 -0700 (PDT)
Received: from [127.0.0.1] ([40.67.133.146])
        by smtp.gmail.com with ESMTPSA id f6-20020ae9ea06000000b00788752b4966sm2277381qkg.92.2024.03.13.06.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 06:12:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <>
References: <>
Subject: Re: DO-NOT-MERGE: mptcp: enabled by default
Message-ID: <009fd32f-50a2-8826-c3b1-b83d8e615910@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Mar 2024 13:12:50 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8264660675

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/1b843882c5de
Patchwork:=20


If there are some issues, you can reproduce them using the same environment=
 as
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
