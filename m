Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF331C0DF3
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716705; cv=none; b=KA4DOwPrirXCigaz9kxK0ItRBVhBTLY9ZjAIE9ldgVeBVQUrEZmz5tUePBqzxC9I8ylYsc2bKU3OH1KR+kAZCEck1CUwVk8YVP5k4JbWpQu6ZLtTkO70fxuZ10EfGH8uKGGrc45QsaxeDAHGxBok6/mdzowTp9vTd3ReZTwciwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716705; c=relaxed/simple;
	bh=NyCsrx8psmpPC+CkP1J0Ng6NFEcPdnZdUmv4i3eMp9U=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=CMi70AC/lJF5KhbjrkkphyW2pDyAwCVZozCi0fZdpSNju0ATfNUN5RkXEriOQc0ZdzS5xkqIxe3/GtoA9CUSa6UMIzMFxrruSklynjR8zVJgL70dLGEZB+MOF3yGNfw5j/5oLTdLRQloxKQVyEnOdReGQ+Ov+ELVTKxbKaid6Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0DgqtZ6; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0DgqtZ6"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c1e992f060so807327b6e.0
        for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 05:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711716703; x=1712321503; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jDGq9SgMhU45d2GTeI2qQnV5aUqK4JcvlPXHRgFJv4=;
        b=Y0DgqtZ6NyknCTE9t5fuw2vEXk9tcqZWUqtxCA+si2LnMIGbCsmM9nt1ylTk/hOZ8j
         JPU6yeSk8lo63kUJUtzdPqcgZlyFeNwDS9POqt9BsGKuYNZCnVgpNsAv87c6K/RlPivH
         8HOCNFItcYyTgJlKsUmfavDCPk3mKko3XwVf+f/L3hh7zr97ZShFC5JMNHqQ9JarwQMl
         Md13hZYnY5ORVN1hCw3h8Nt7J0XLM0dyjlPVObFEFvApinL7VibE2anOOpMvxwi2xGoU
         A5ypnD56lcwk+aVEVcveBx+xZNDqpsBQzDaTnTfBUWIrn2RPmrpJcKDhd9S0EJIqMmSC
         IRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711716703; x=1712321503;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1jDGq9SgMhU45d2GTeI2qQnV5aUqK4JcvlPXHRgFJv4=;
        b=eOQCV/klpdo8LaPuVYuGFu37wQulG1jFjAmI5WY0vYkbq72giWjufeIGTGCSW5ZXqY
         2l9Sc8gOaTLAnM8cybg6jiaKdqiBtjMUQbVd1gS02sARHUhn9Ctf9uO+92OBSEWxl/wf
         97qvGz/Pu/E/IWukulXbZnODKR60FBREbk3ev84HDhb5Jxgp9zlC0MpCc8arpXeD343V
         2mcinhLOCXa/MEvcc6LtCUtnEoGQU0eA0CIpiKFd9dvZoZm23B/076QRWy9K85PayN9g
         G6td+J2Jehz9zWflUVNTTrHf8mgSyClIp3JbHn59IkhFeCurwb5hJkURHOWkdO6CdrBi
         de/g==
X-Gm-Message-State: AOJu0YziAONMwrsLwnCYbHlsj/8UeonfSWnEa1DldQzMbLcYaUJ2fgK7
	56arQqKYdZjCauy42LdNrqSBXgMAfvF9mDI6GdEz2/OkU57NL0hPM8xw58w=
X-Google-Smtp-Source: AGHT+IFGRXrLX9qd/9Nt26Nb76HP8ZeTdyV8tuuLMWRI9H6n8/R++3QGFm7kbPG6Qy1HrOQAJILBjQ==
X-Received: by 2002:a05:6358:8008:b0:17f:56be:8c95 with SMTP id g8-20020a056358800800b0017f56be8c95mr2718354rwn.25.1711716702620;
        Fri, 29 Mar 2024 05:51:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.91.68.83])
        by smtp.gmail.com with ESMTPSA id l4-20020a639844000000b005dc9439c56bsm2860508pgo.13.2024.03.29.05.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 05:51:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d177c05847edc56a2bbc56d904a18cee8011a1ef.1711713371.git.tanggeliang@kylinos.cn>
References:
 <d177c05847edc56a2bbc56d904a18cee8011a1ef.1711713371.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22selftests=3A_mptcp=3A_add_last_time_a?=
 =?UTF-8?Q?ctions_tests=22?=
Message-ID: <0ef79195-993d-4691-342d-f2d225f162c8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 Mar 2024 12:51:41 +0000
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
uns/8480786404

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/20185a174dc3
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D839763


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
