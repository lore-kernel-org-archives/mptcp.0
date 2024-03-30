Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554C31426A
	for <mptcp@lists.linux.dev>; Sat, 30 Mar 2024 09:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711791952; cv=none; b=CtbBQa1809S3jpQy5ZIucEUKU9CljQDd0YEcdrHd4eom5VS2CP1J5kymUxXSo2bnuvrXWAeMrrBHuMkZ7PPWnYlSZVjuIU9Ld3HcAEDlmSEmnlP4k3ZC5o+Lmp0G9B09cgdu42exB6fTqNCToczbAixJgS6kvaQ2SNTm62nPDxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711791952; c=relaxed/simple;
	bh=UAuXK8xJ7gqJrstcoCJahqD02j3012iqpQN53d67qpo=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=mYYp85IHhAtiQykLk2Onc+lxzgUU5PIbzlcjGMlQE9EAQj8/UhUpJ07XxTp0EoRkaqBaWOk2cffkDh2/D15AEqe7lGQ0O0hhxJcENJ/e5u4dk1gQ5NaP7/sMKMzDlArQBjVtXXU5WFOf/2twKbdV6Hb7qaM70LByWWfXsrlE9pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hgu0QAIU; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hgu0QAIU"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78a01a3012aso178050485a.2
        for <mptcp@lists.linux.dev>; Sat, 30 Mar 2024 02:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711791950; x=1712396750; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMFBfL/KCIV1Th2ZD5NFwYi/0F+tsD9/uiXILlF9rG4=;
        b=Hgu0QAIUQjPHthgZNoORUq5MiYheaNJRzw6203ddfpOlPz8EgzKlqjwyYaEJymSIj8
         thMw4g7HalNR8JyR6TtGKIAVjwmfOCzQTunJi4mluTuYup65lvDIkznd3ne7guhU9moQ
         NFecQntT1BKy7b1epJ86EgVNLWjKsPRDffeU2LCeQv1hv53RWMU+jFH3hFQ4SAIUSNLk
         dDst7NtUBWzjbYZAOrx73c/A8Ps5E/A/RqpbrT2qJ/idjzcqiCPsMi9daLPnbJogyLCC
         33iYCt4f+yc2+QY8Kojd2cgLdKV3gMS1RVjqaNuHFLnBTDNdBjOZBJZTqp4ZcdwvHJu0
         RrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711791950; x=1712396750;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wMFBfL/KCIV1Th2ZD5NFwYi/0F+tsD9/uiXILlF9rG4=;
        b=c0s2nubOhBmzWKmlNvw2O+lkFjEPsvtZL8bTP2NE/Zi+UT1j8K6d+3T8/rV59rzCfR
         cXxVQQsPw0v0wzDtVdhIFpcxYceA+G/MFVW5qjccJpRkNSnhX0cLXzzExmQjZm3yOV3o
         VtN3rJdvpPyLjGwXGYaa6u8qsARkIFSkpo2x2x8IeyDIdKYfSUNvM1CLpinroiUvG493
         ROYREXQlW2nfE3YIIi4E7afyfahATTOSsX+I/EWtmMS7KenIBYYYjYR4dZe921NwxKHD
         rhUWOVmp3TQKu7QOcda4RIY/4k8t3FGWgHa45XU251ooH2DWv7b/3frIPjhgpjctGhyy
         u0Ng==
X-Gm-Message-State: AOJu0YzwtxEik4lTdv/y/uK7TZgj5JwID6o0oYmrAZEpCk580a/dv2lF
	Ppyjq9klyCY6s1SqfuKtT+IAs+IV0JcAQJgjez/Y2klDrF0yR+1TNoWMLNY=
X-Google-Smtp-Source: AGHT+IH+E/kuYaKPRt7jVyNWDpbUf9CS/Yns9HA9QNCd5oKSdm/7/tFx9W+hwLOvkueoft23XjMkWw==
X-Received: by 2002:a05:620a:298a:b0:78b:c6bf:576b with SMTP id r10-20020a05620a298a00b0078bc6bf576bmr5516198qkp.62.1711791950113;
        Sat, 30 Mar 2024 02:45:50 -0700 (PDT)
Received: from [127.0.0.1] ([20.81.159.82])
        by smtp.gmail.com with ESMTPSA id g1-20020a05620a218100b0078a6bf6918asm1959055qka.110.2024.03.30.02.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 02:45:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1711788593.git.tanggeliang@kylinos.cn>
References: <cover.1711788593.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 0/8] refactor mptcp bpf tests
Message-ID: <e3da1ba2-4f0c-06b8-21a3-9fe1341d2a63@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 Mar 2024 09:45:49 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8489731778

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/9012caf5c889
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D839980


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
