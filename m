Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0988F38734D
	for <mptcp@lists.linux.dev>; Tue,  9 Jun 2026 03:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780977033; cv=none; b=uhd9cR87eUoq5z0NXN31C7MrhGzKgE0q/Rk8A0R9bnfwkS9wCZzD8P+1ifmRComQB+bufAifOyemW8uVLTmf0EmL/E+J8B0nRhDvp0xIRG1kw5Qfo8o2Q22MPhSePbSwwA6l/1xVwP8MYvyn58q+NIfjY5RIqp6TiG4g9a7s9P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780977033; c=relaxed/simple;
	bh=0fcbg4RhpotrkmMLFwZgIY4720ke5Ys4ZQoq6xLIDG8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=e5Dj5AAgiAHda/PuYvJ/1UQ5KJXLYw8Wdqx2ADBYfD7LxzMCwk+tiXScbQqOB4CIUvaTM2jDLJ655vCYxj0mWV4GG+5huaDVyN7/pT8wvxuZUB/RZN6lEtmdTDDGUC53MfmUMEhzcaJxWbrI5QRKbKe8ohfHLVOTgOOTWviyf8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VI5GFaek; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VI5GFaek"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-91563382bcfso586271285a.0
        for <mptcp@lists.linux.dev>; Mon, 08 Jun 2026 20:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780977031; x=1781581831; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYMz5jCCQfj20jlWOKvtP8b0LW6J+rw9/fwmkBGMKeo=;
        b=VI5GFaeky1ZIz53i6x7688lqXlHtXtez16kF8HH1jN4AVSt462nCBmR5lUYGCQkHy4
         SYNEOKEUQVe+M/VBcfAIJJlSuM6nUIuhmhs1R9EDSgOCZE6je47Nl/4hiiYnfwbEwbqj
         rcynwaeNGHa/OWt7W0e0Fevp3eyrT6m2saxav0klwD5U8N/7iTCA1Xk680ZJ27L+yT2S
         0jpk6fj+L/88luAlUHQRHz9ronvUEC7U5i7hiyzXxYAz5rrG70G9A6XT8/aPt7FV+mNk
         9lQPD/gkwBp+oGLygk8Nck0CM/GUh704oIF0QzmjCpMucOEkUwLG8r4npDV82NhdhusQ
         xcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780977031; x=1781581831;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VYMz5jCCQfj20jlWOKvtP8b0LW6J+rw9/fwmkBGMKeo=;
        b=RiyWjghXqfClyBpGvWLjJADglbARzeFycyvOJQnG8RkLiVz0VQB7h9Wjq/zA8DxPns
         5CBBVHEg9mVMf5fqauTZ1HYk2UVZ+HnlD4cN1BEVbqvXTqDbaKg5V0omCnGiLW1nONC4
         JiWfIncSxdMPi8dqWKDzer6XGFao7dPsgmtPcBaYpK0G5z2tO0U8vhatkl162bJ9epUQ
         TfBH+P1v+ZuNn1WtLWHQaFIG5n09t2lxnK8/GEPwCuVciYSLGFn+KSXV3GB8PFBkZNcR
         UJhrDHkD8IrG8pfehKIqshZq0x71csLIUZJ9EMF/azS+8i+qwKs/I4n8X3e8DfscqiLI
         0pbg==
X-Gm-Message-State: AOJu0YwPUSAvwEDg/1fjp7OTTZ5QBDTp+lgVuPu2MwnPwcySuOksJnYq
	X9e/ndOSWVdWkKwMd8ZpJBj8Ix2EJkFNqGBx+56+Vlaz1dSaG/5SjNPEJ/Z0
X-Gm-Gg: Acq92OEFJUEnxaOzvQ00HYnWDJs4IGiwN5O4gEKRzGJp8r4dOpyB/j3G2hxQzkaxurL
	mTi5fPwb50ZHNt+fVXI0S6g1LnyivmPqnbG0aawHzMifuVVBR1hAGUFeDOQPMW5he8q1cgZ674V
	7hScPMr/nxPKwTyQfznHmgFmZStnaDcfqXGLQEabc22SGLTa16Dabnqfg8vyOfcsCmMy6JOLpxe
	kHVANFjtwLAmge6wsR51XNfEinBe5Rq1nYIneJGbIz0B1+cqe8jRJg1ecPUMJm0K74F7XpTvvi9
	IRQwAk+ke8L52CvxSJVcKqIep2vPJEwdtfFiEeOOW7kwNsEX41cQbyjrrlE7KcsclW37pk0qDRQ
	C6gpgRmqEsZGOebDNaxpByrIc8jBaT85WHkNNydKI1gJHlOoIhv+7c1LEtjpcXwASw6vPGzhG+L
	6oXbKlYAU5730KKQQ+ZR/mOeTeV9YKwAFMfyw8yYo4g0LA0N/fgApfXsdB9AE=
X-Received: by 2002:a05:620a:4107:b0:915:79c8:ec94 with SMTP id af79cd13be357-915a9da9982mr3043175785a.39.1780977030835;
        Mon, 08 Jun 2026 20:50:30 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.131.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a238f8esm1988671585a.15.2026.06.08.20.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 20:50:30 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1780970284.git.tanggeliang@kylinos.cn>
References: <cover.1780970284.git.tanggeliang@kylinos.cn>
Subject: Re: [RFC mptcp-next v25 00/22] MPTCP KTLS support
Message-ID: <2e70f24f-ba9c-63cf-f9c1-a0b61544940e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 03:50:29 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/271805=
73957

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/e457cd2f830b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1108217


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
