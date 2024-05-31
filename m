Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467FE2594
	for <mptcp@lists.linux.dev>; Fri, 31 May 2024 02:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717123357; cv=none; b=IUH8UKfRjkQRE+aLNV2MS8Y5Pf8qFz1PEPaFoXqPk1XMTXs8LmOQk/mZ6yEPJg7P6RECye97T4CQJErQppnMB6j5ebQUlpwhkR6aKVjZaiN+jcVSveYF+cQmUIyl3Rgn18NfjACsyPA59XDR78kN0eoU5M2o6xUkCTgogSfz4JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717123357; c=relaxed/simple;
	bh=Cbt/ZwHa7nYmsAK4d54PMn0aIf6lcAXk5A2Arj4OjhM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=RKbC0MdALANToPhEpeiOYYBpaRhWtT9P+13jR1hYAmCk1wta/QCpcHJuvQQzJQ5yEndEJOPAbuiFyER3qIaRVUNzXAcs03y/WvfJEkjXvh+3eRun/mYMUREWO72lOrOKxbLf9+dDuulubMYE9ennYxRXHmPwO3IKn6V5cpVjJYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PblLBa0B; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PblLBa0B"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-794ab0ae817so100658085a.2
        for <mptcp@lists.linux.dev>; Thu, 30 May 2024 19:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717123355; x=1717728155; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugsCSoxIHMct/P+8EaNdfo/YFwEJCf3L7dZDhnlbx50=;
        b=PblLBa0Bk1U7jkwE5DDwqaUQNvGFVbJqFHG7CtpbjlsFY6Blw8seyP5EAq71iK7pRZ
         1+BoxwBF38rpipuGFRuDBwL6a13gGgFyhBkVHcHa0RGahlAiiekkos6Pa+PExmpmOzAs
         m6JTGLAMmEHHZA3AWT15cWXg3e428o4dlm71fhLSkWI5n4FEexF5/g+03xEKv8nqI1Wf
         rdXjWcguSU3L2xzh05GwjIWSAh87VDEdCqMfvVjLHq7xN8KNN3LXTkRap/3gdywM1QuQ
         RiqgMHDPGAJksCE0p3IIr4u77xTaI3NL+U7sW7ssPnwGDlfnY3xeedVuJB7X0bb8yiF5
         6hbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717123355; x=1717728155;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ugsCSoxIHMct/P+8EaNdfo/YFwEJCf3L7dZDhnlbx50=;
        b=tyDer5+TT2633sFC0pWzH3IkUzQQEcRs8zA4Egx6xm2eljPQrOlP5Jd+dWT1ddKB7Z
         EApXPFAUXFwuFennFhYRNLaDp7cIKAf1xO4ZrzvSVryOXJAwi5fsgl+ZC44F9LDjLyp+
         S05JSu//0li+ma1bNu+smUX2DbcK/JFdp8cHvfwlaTdOGuxdXJKRBC+M2eR4QyeCqUds
         v/VQHqKMuknmZql107L/mJt8LGJ8RfhmBDSPUepzWDj9yH1It79JakQQyCNKuokgLYT/
         cYyHS9ZGFndKg+4gataIzaNR5fjtMqe1i66RZjQkM1+m/VGZRokSSaiLtamdEKWSZe6o
         7bLA==
X-Gm-Message-State: AOJu0YxL6jQDbTAtMPDZF9j9Stz281NyQUcQucx4HVSlTfb7quYK2pvU
	faJBVXYVVr6xsf41ONU8LvDONoxLoYgXP1OQuxEtFuHrI3nVfik=
X-Google-Smtp-Source: AGHT+IEin+woPv2Vxpq+IPWC7QaJKojOr9S+DSiQgDGvt/qxbGA6o/YBk6d9nLA0Xv5jjSuE7PUaIQ==
X-Received: by 2002:a05:620a:d5b:b0:794:8423:9a11 with SMTP id af79cd13be357-794f5ed18cdmr56233485a.67.1717123354952;
        Thu, 30 May 2024 19:42:34 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.106.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794f2f1297csm28572085a.45.2024.05.30.19.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 19:42:34 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <58464660b9d2f74d45c0c91663fd71132749db90.1717119915.git.geliang@kernel.org>
References:
 <58464660b9d2f74d45c0c91663fd71132749db90.1717119915.git.geliang@kernel.org>
Subject: Re: [PATCH mptcp-next] mailmap: map Geliang's new email address
Message-ID: <320c72ae-abbe-f551-76ab-9dd3b98f20a3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 May 2024 02:42:33 +0000
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
uns/9311827528

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2beaef1638ce
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D857527


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
