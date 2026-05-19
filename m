Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F59E20C461
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 10:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186856; cv=none; b=kdVyxuIn4pMg5Ct24iX38kM5mu8ecFs/sOCL+2P4T/UKU6IYmcknBXU28AYFluLfPCBMF43qDxbQLSQtKqTFFfWLk+8tFRekgRtb9IkjSVgMcPHvgggX774wj8Pp7yzHulSmLPy8H8zP4vJWLaRDXU828IxI6AMguxU4NDGdkw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186856; c=relaxed/simple;
	bh=6izPfbVJg/q98L1tMbV9XVrCwvELOaZ5AXtxRdLhdaA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=WOz7Z8FY+G1cLCgbO2qCHaO6anHM0tppUYMfcjR69lMYjRWFQa/TbrchPXftZQT2Rr7SxmLvjP1x2OBM1HY5Zk+5R+YHbY4DKzOry65dKpDR9/V+fk6fMihnCp4ouSe9gYnNqRfGauI5uCH5/XDLCZQBqOrePRC282r1OzSEQHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvwNWg6P; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvwNWg6P"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-303f2fb7225so1410288eec.1
        for <mptcp@lists.linux.dev>; Tue, 19 May 2026 03:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779186854; x=1779791654; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJn9XKnuXUoRaPab5wFEO5TF1RtZTARRWXxjF6iCQKM=;
        b=JvwNWg6PhclXjZMeXbxDP9UcL4La3S+F3Tgjb/fUlNTI+lCuQt1zao6GzLm9eqyk7D
         7DGLkbGv8Hp6B0DixJ9C3NhDeUYrW3RiWirJw8PQ1xRzFK6KpPp4ti2hBSZ6EPMKnT77
         0OWEFS/nTfK9QYPrTVK+8IOc2opprd4WX8sfQTuc2DFrRexV/IBfbDeb67kz6f0rlQzC
         ++G27LftPBXT80jfXcGOrN9Sl51xB9u33aiKwEnMJ9DorgWeV1GdQ9EX2b06oX5n2a2z
         clVbHx0x/W3D4lAqorwb+y46vd34z+GIlFntZpcli/gsUFHOxAVdE9ORITSyHkbPeC/X
         yr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779186854; x=1779791654;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJn9XKnuXUoRaPab5wFEO5TF1RtZTARRWXxjF6iCQKM=;
        b=dk+99VVk+dmDwMzl5cFzu3Vf19CXps1Yb2LMJ1YESQl9KGbt5fRWxsL9HYVjKnYkgU
         yaOpTsbODWEHSC0RP5U7BLQTkKZF6Y523J5SbyoXtxDtXngdyUE5MXOgthiSEl5d2bLn
         B3wlk35I7lENbD8ltG2UZcq1C8jpNP4pd2ifzaenpDHAtPEkFcYb7M8UOg9Nr7xAOe7O
         mhlCfkGakQM8JYkWU/zUZW/3nPqR8UNbAo2oo/VC4UfyZ2IEMwjQvRTV1nAB2tBMcKz1
         Bpo3LxxSbQm5sy2EXx4N9ews8qoBE8WHeqWPVveIhTSm/x5vaaIIdC7QkQZVOTg4CvXK
         MfzQ==
X-Gm-Message-State: AOJu0Yx2/jFJYkLLpNJOoQEOmkPkCjsRCXYCuqTdz4ETRU2T3tkpP/E2
	o/PvJHdTGBmRoLl+/9WcBP3YEup1CmzDCWDAsVKxYmf6JDLxZxvuhmKo5sE3
X-Gm-Gg: Acq92OHNhfm6eJz9LPTYejJHBU9U77flRvk1yvZTVhik3TzDvT//RbGNW6LIJT9xQLv
	iuCvVoyz9J4ieb6A8NVN2DW47z2fyjXBNh2eU+7ol1I9nlL3suo88AalIfwMSrpWg3gR2sf50wf
	tAWuJDDds3MiekQXIi/0fckmEBNESHQiHK03K0LzeE12ePJd7OSnErWd2zpfvfroRcQnMXFHfWL
	1SporNfwHZxzG3+yQub07GQvtHxjcy6RJIh125aJbJhVBql1Qgf3HakrR/ztkVVFSF2WUnHNM7D
	Cw+RNlj1GLoCJVsBFa/2wI+4ReFfyXiVgr8AdvmGQGyCLOShxafSvdfxG6VaPlMFblizY89uW9C
	L9OTmiuqbSr+hFW9Bsm4JJ2Tvxt7mYqMexDsfWR0Zm8LBeFK18MKXmoy874WcrEL/EkE6pjcjf/
	fqyYHbCMsvbOTDFnpD/tLRaV+6lIo3CMtHi2aGuj0i0PEywDs=
X-Received: by 2002:a05:7300:e78c:b0:2da:a813:a60c with SMTP id 5a478bee46e88-3039867e573mr8023775eec.20.1779186854377;
        Tue, 19 May 2026 03:34:14 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.58.148])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30294adddaasm15793470eec.13.2026.05.19.03.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 03:34:13 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260519092243.1242351-1-kalpan.jani@mpiricsoftware.com>
References: <20260519092243.1242351-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH net v3] mptcp: fix stale skb->sk reference on subflow
 close
Message-ID: <54abf60d-f210-9239-1a6c-28b25eb9552e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 10:34:12 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/260890=
06573

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/473e5e16d4df
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1097212


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
