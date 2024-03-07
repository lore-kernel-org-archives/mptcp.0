Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93353CA6B
	for <mptcp@lists.linux.dev>; Thu,  7 Mar 2024 06:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709794071; cv=none; b=GuPXAgJKw/rqIfQD1C0IF0G0RT/fSxv8wJYRJxg+aVMKChcw7WZFpc0CDK0vshu01CQSTNUVtXHW+t1l39Z2Pb8080Tng31wN2AgXv5HTV4Xf8ced7FBO/Kubxwvm3DrCLe4l0KOH9KyrmQb69FreWRMvGvexxf0C2kRebimulk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709794071; c=relaxed/simple;
	bh=hqeeJaU7HjlVZvuGce9ySxftVMM37M7zx9odRdWNAXA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=hDsETxTQw63N9fMazp+pJ4VKVQB8p7gMxHNcw0C/H5ZB+Diqh4djCw315LiL0DNIxUUVV1NbVyX/j0jPi60HqzfDNfFOa+X/gpoBLxAeUKL8MJ+jqcunh+3QfdEV76M6qzLaX4/g0mewKItUDebBQqkVjidFXMq0aY7yLVvniPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1ByRDfy; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1ByRDfy"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e627596554so410417b3a.2
        for <mptcp@lists.linux.dev>; Wed, 06 Mar 2024 22:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709794069; x=1710398869; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6l6BQ7tZj7e3gGlBRr6Olrsw81a2rKvUM15aOSxtORg=;
        b=f1ByRDfyOkBbZmyivUUtalaMLqEColRxzxUlp9zTfOns2/m35iAu/bEH8kXibfMamY
         2tYTurJhvTOVV18jfYiQUv+xsiyHMB+pA8eYFASig1C32y9s3/oAKTKvQhWgVUrNhyLC
         iJYKpHTiKVhRB2ukIiBXpfNBO116td5xiDJAnt4fq9Vd6wQDWIG7V36018oJJC03y9xX
         edRG/AndLaoy/aj/+v5jlg+bquCtbk43m7irn/cmxoCzZtdKfN1TImARVRrKCyqkpEtH
         AE3YYvRoqr5JO6qo/wtdGu6EDVnH13ELvxii/+W24bZlfKC5BqpfaXGgmSRPZl9qnDW+
         Hh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709794069; x=1710398869;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6l6BQ7tZj7e3gGlBRr6Olrsw81a2rKvUM15aOSxtORg=;
        b=ZwgE8Lpy9Xy+pyk36zC7Lcky0Mlf/91l8+qMFM0Wy6R8uouUYoXmGsiQO0I7oQKnE+
         TMlkocP3NnYM2rXmyjc6PXl3W2Id0zdtfC0Cwp2fPa1Mogd7rzFYBpk7keqd1bgJ+cxn
         iKj5X9l+J4nimm43q1dkjSIZG6gMIDGfrpz0go4OJFc5vXjh6LUKnN66yaA/j1v0k0gj
         9lnhPNizSVb5799rKCMu0y+eo8v3s9PbLUROn9AdxIb4rLx+YZx8+AtR6+mUQBiTk7wT
         ZpQz/cAnHJ6apld5i0VPCEdBEKqsMZg88kJ+/2Q7LGswI9mHyOlsDNpE4an9pYZrIf61
         FO5Q==
X-Gm-Message-State: AOJu0Yzn/ODJyMOKQu62B1RsGeIgcgxcuRW7XM73URGoXIVUK8+HWPnj
	NP6vvURUw9mfE8EF7QqskFgJz110Rizbm5enc5NXeMxuoka94VPJEv5KjSM=
X-Google-Smtp-Source: AGHT+IGpqtTdY6YAN62TbYaITiYPMYJXFTMZzI7gvIiF+8bdvWwbvSFMb00QXwNVEnPcW4z/a1Cb0Q==
X-Received: by 2002:a05:6a20:d806:b0:1a1:6b78:d70 with SMTP id iv6-20020a056a20d80600b001a16b780d70mr2868783pzb.61.1709794068820;
        Wed, 06 Mar 2024 22:47:48 -0800 (PST)
Received: from [127.0.0.1] ([52.225.77.221])
        by smtp.gmail.com with ESMTPSA id i16-20020a17090332d000b001dc3916853csm13669392plr.73.2024.03.06.22.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 22:47:48 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <6f47bafed58fcc6fd3236b12134b23ff012d5643.1709791100.git.tanggeliang@kylinos.cn>
References:
 <6f47bafed58fcc6fd3236b12134b23ff012d5643.1709791100.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests=3A_mptcp=3A?=
 =?UTF-8?Q?_print_test_results_with_colors=22=3A_Te?=
 =?UTF-8?Q?sts_Results?=
Message-ID: <974c9e7a-771d-ac8a-c905-15ab682ff57e@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 Mar 2024 06:47:47 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/8183741163

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/b5adaaf15cb4


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
