Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2495813F42A
	for <mptcp@lists.linux.dev>; Fri,  5 Jul 2024 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720214757; cv=none; b=Rl3ElRos2w3wkqpWMxjV+qU4Q0cTqkx0aNF1+4n/hsDDSf9/bmSDined9QxsobmbHUWh1EWH+FsKhCmwiqmCtqgKGoXpvnOj5c1C4ADJL7Tnl1zIFDoHrq1G6+sYNXlhI/G3QXs6/znV06g68aQAkerPjOPuaJqY9ogMYqQc/u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720214757; c=relaxed/simple;
	bh=DwhbiKB5OwPAywF1xMn7N9mF3Tjr54cT5l7C/YrXkcI=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=CEHSpntl8Wp2ECi5qT16W+dxn1YF2pFccCl5MAJdHOuCmB7eDayRkkcftbNn6anVW48LB9iTQKZxCyC9InjOsiJmqAzpxRFVuiUm7qZ7b2ajsGhY+zl+NwUJfyEIkJShSQvMpPJMwxWV0V1XLndZSg5NrdQkYULYdrWwifXrmj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5/37UHJ; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5/37UHJ"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6b5dd7cd945so11171906d6.1
        for <mptcp@lists.linux.dev>; Fri, 05 Jul 2024 14:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720214755; x=1720819555; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XojsRw8hDQMPH0mKV8JdFcNQiZoF1o6R0Z561mw/Wks=;
        b=H5/37UHJDm1OthvF/272pqOv747Ymj3qUbLmXAFCbvh42BtxKpOjLOblmZv5gp4MPm
         8tsmnEa6SlDpPWe//AjS3U2zlNv9erAdro2zmNIwlR6/CEbbiqZLsxnmD8uwwbMHOAtW
         3q8qcDXGbsF9F9PVahCj4JLpa2jikZ5Mhs17KNtgSe2au7ki0aJmVUKSkalKRckWmZDz
         XB2TnUvF55SdqYTrKUpzK+f5tTSnJXWyE9aCUcxURWIaP1A4Ibrbr+qC8DUjECHNROWa
         BtsYSNwBE79qwaDdjtx7ycbtG2KS3OEbMywVZ+Ir27GkI0/cJPm60C8zODDUp32DDJQn
         muGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720214755; x=1720819555;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XojsRw8hDQMPH0mKV8JdFcNQiZoF1o6R0Z561mw/Wks=;
        b=ZRn5ZjCqTj2XgP8lo/uvz8Z6idb8DuSMHKFujU1MWEmL0cAI8rA9uogKInTXoLr8ZW
         csvPsaCwQ3iqet9HQgALAsDf4U7tGxYYP6fo7r2mi3bZjXw18iBXr5BfwRQD4bswY70+
         nusLFlgHXsmEkitvaCMPzBXieOuYtcac/iA9a5UDu0OvXO0ABF7oGlRpnxTSDmFARF2j
         KaONyx7I5aBls1MhM+Sjug8XpXb5SOFQODcvvS2RAqnwbhALRfn5QClT4CKoqFNH/TAi
         R5qhN/wf8mnIt3g5d+22taX4kNliOObgtsTII1a+B0aZXaJwvkB4llBsxhE8A7fmlmEt
         tvrQ==
X-Gm-Message-State: AOJu0Yxlf8GfhgmVf1pFXLzcMntkvhg5vMSRCQKVeSMn6KRSSc/9VWCP
	aiaj1o85Uid6qP4h7t9D4cywaN6N6D7sA03NwI58N3jOLZdPqqw=
X-Google-Smtp-Source: AGHT+IHlN87RPqkkhEL8rhvOtDhynQthqO6OM/GYI0w45Eq/PH0WR4NSJmuhgImMLjnQAgvQJk0HYw==
X-Received: by 2002:a05:6214:d6d:b0:6b5:4fe6:1eb6 with SMTP id 6a1803df08f44-6b5ed27245bmr62181896d6.65.1720214755028;
        Fri, 05 Jul 2024 14:25:55 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.131.96])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5fe1de71esm4264946d6.75.2024.07.05.14.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 14:25:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1720211515.git.pabeni@redhat.com>
References: <cover.1720211515.git.pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net v2 0/4] mptcp: fix signal endpoint readd
Message-ID: <a66ec51f-33dd-07ba-df34-21c6de5c0199@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jul 2024 21:25:53 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Unstable: 1 failed test(s): packetdrill_mp_capable =F0=9F=94=B4
- KVM Validation: btf (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/981347=
5267

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/3675d1072e39
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D868916


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
