Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CF63DAAA6
	for <mptcp@lists.linux.dev>; Fri, 28 Aug 2026 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787916134; cv=none; b=lmMx6QSyC7CGLe98EySF5BlaVd1ANAIZ2mfpIhynihLuCKjmS/h4W1MwF2U2RtWLsxUM2p3Dsh7/QJhXOkFsQyAfyorO1bQbH12Vf6/OF+ybeL7jdHyisUygYppyxDGH4cxDKKReBgFdFDYkNvS8QCmGvZahUcGqhn44aJRGdGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787916134; c=relaxed/simple;
	bh=2eOeECl+QnHCljVa4j5fZrBX77s4CTBm8WffH1bsvrs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=RG9+zi5KLx1M9U690g8h783HTI0HqCIp7i2zb40H2AhVx0O7bACzD38JjP+Ll+mMseRNtAb1dNmlP6annHrHo4NpkDFrp9H8Va7hfz03Kcl+G41uw0c0vFWyGmDfhuU9f8buiUgMdhPYK1sYD2oEeZ7ONo5uRZsj4d7iwCCa+bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nofiqXJ3; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nofiqXJ3"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc11a905ba5so649816a12.2
        for <mptcp@lists.linux.dev>; Fri, 28 Aug 2026 04:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787916132; x=1788520932; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p83ZnWe87VhYZMef3OPsmM6svXD9aZK43xbMWSK5xhM=;
        b=nofiqXJ3OZ56xTt349TWpNxvwmQ2z4Skuf8AK9EK67ucJnaeu4oU+C/E3MT8AB9Wyv
         3hTpeutpqxy+8BqbnA9Z2FEbJlJaQ1J5Dd8M7qHg80RWcRKsJ1dYLMDLdrZ9Iu1geF2l
         e2jBuiISHnli2+r/IlqcQIC1hETrqy4Ce2JXVS/JLbZ7O4oSQjCObCiffUgsHOv3VhdT
         96oSxUqZXWWN/AVGZpxsZMtdmlSBO4LxYjT4guyCFKEV62ZMhj1SK6YiTHmvbo0Ox9NY
         8Qiqw97JIMjEdlwCyGhmLwo6ny2gXDD1PD66q2E5fkfPLvKnj1ci10e7p3lReA/xgR23
         v5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787916132; x=1788520932;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p83ZnWe87VhYZMef3OPsmM6svXD9aZK43xbMWSK5xhM=;
        b=l6wXAo9jLb7fx40UTKWr9oaqnLtWpA19gw5s9iVLwy/Qh7z9kfDUGr+2Gf3f3K52hn
         X37fmtdyGpODB8jNeHs2z8oFH7AfkX4Z9qyst2iv/qqbAI1MkfDf3iW1qjRtaCfq/P2M
         J6v/IkL+bDL1+JSUM3rAI9W6CqeLhKDmvQCKpqhFt1Q9U41EglfHR1s5vvdQWQulLxuP
         NMUkUyadX4wjsmw7ps32rurQQ2+6oBt5Qz0okwaHcQ/oYBSqQoOmZqzIehvimqe8Wo/H
         ULtJUKlfmhGsq3xExsy7wqQRePfV+q1DNlkCGXN/qkIdOJz9hFkClFBajJvVVpiAUAYL
         WvKw==
X-Gm-Message-State: AFuF++nhKWucf+9BAlxmjc9aZqI4SRA5lR3O9Kaw3E+fLTwEvy4Uu0ug
	9Ea/Zfif4/8YNcvSAzngPTBUa5bXjkq+M/PWZgIGnrhliAEVzXIZeG0=
X-Gm-Gg: AR+sD133emSMegfDKmsgfV0AtMUH3m5hLH3MKmFB/3wJu5GWcGAOt9TrmF5QUOSqfYb
	dBk1Y0aI8j5oV+0H2P5n4Alacq3bNy7j8UUGK1HnXcX95oQet0zfdiJvSZhRhNANmeT4E7StvPV
	9if++EvroW1uGOS0bFllzu2+ysVBUQspkRYt2t/wasNVL5tHY8Js7MMLWqagUNdhfLj/r7ahucU
	BqeR/7ynU7WDXbZmO9h2WIEj3GBnIlT7b7k192zILIBzT7reJkx1v5g17rnmXJ2r0w6dKOvNpYB
	QIYmTwLa0ADM9OCtyXHUbZtOi4t/GYIwCJM0eKiTBW1clFjMItfXghkT0lzV/cQqYD8CVbURVuW
	yKTAesE22RUwrWBVs7SfKm9BMyh2y12vsZ7pLSuRr+WmvzO9UqyxPPGb3/CrpJp2KRtdk5TnwgH
	nuub0TmNBZzfNUe0lHbjQ0r3oWQxRN385/a52cAd2iaFsH1gWyvEGZ4BskUh+1z+XUHC6zASp1Q
	/E=
X-Received: by 2002:a17:90b:3c08:b0:38e:485c:ebd3 with SMTP id 98e67ed59e1d1-396d0f9ad1fmr13366769a91.15.1787916131952;
        Fri, 28 Aug 2026 04:22:11 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.245.164])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0d1b38esm5008573c88.3.2026.08.28.04.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 04:22:11 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1787911017.git.pabeni@redhat.com>
References: <cover.1787911017.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net v3 0/2] mptcp: more cleanups
Message-ID: <27599b15-bfea-a6b8-a83f-3142dc7a47b8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 11:22:10 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/331640=
19952

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/bce912e922bd
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1153165


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
