Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351CA20DEF
	for <mptcp@lists.linux.dev>; Tue, 23 Jan 2024 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706049165; cv=none; b=bIbQlmEagDQPf/sxEHKd2IQO1+X8dwqlov+auRNXkx31hvwg930iXLKiRGdb34GaqrvrMxEMzh0o/lnpU2K67Oa+4SVKyZPD8qHlGoJVlcJcSfE4w4Rgyh6Y38rJzdDc/KDwDethFi0ODEBj6XYLRBhXkGZxGbZuPKpfseTBdHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706049165; c=relaxed/simple;
	bh=h7y8W10JUiYxKfhdp+kGXxsheHLj5yChYtDY5dphW8I=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=qxuyoi8W6rabEjyUcj+y+0W3hutQFg9LAb7rirkU9ekxOZ2MOTPyZYRSlG9KzQGcbAQkJl6R+p6A8BFngueO/FdwovOgqdIHUnhLV5UH+OrOfnT+r3yhUN2PIi09kGgXATwM3EuP/xpA3Nyw5446SiTOGHXA5Zpad39oXpigzLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHRH6JaN; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHRH6JaN"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-681922a61baso39532136d6.1
        for <mptcp@lists.linux.dev>; Tue, 23 Jan 2024 14:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706049163; x=1706653963; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcgLLU45nOoszUaTm3HVYctgWQhrU5RJ0nPPKRlbWJ4=;
        b=kHRH6JaN+7f7+c/37PbSzyztOUoZ2T2s32FufgWZFa6NuwgCl/Xzdj80m4GwCNlvks
         Gvdzn2VLk2oX2QVGYpsJhah/kvQLdgR4QScvPL6mBJDtXMHHQTduW6Y/zLveLqUtdi/l
         K1EC7VujRCKvn0lFptu6IJ345ud5OSXAsKDAhSTSBm/lyQm/mWckWffpyysB43bWgSDm
         ZrR08d6A4DspubvUD9+u45l/1FmxzZ0bsyi8Rc+jUHwPdTpwbW5YPND18DTyxVyKcz/d
         AXYCNkLg+BVA+fCcr/Bebf7Z4fQ/UB9KHsqN6Bugfh0DeHmgK0vX+KxATaPPTfwzV/Af
         ewrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706049163; x=1706653963;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kcgLLU45nOoszUaTm3HVYctgWQhrU5RJ0nPPKRlbWJ4=;
        b=iLCZlmClH52voa68VWTT/gseYiFci/k4YNe72ODKVhnuZ9D1TFiUFpb2VhZGOk1hpG
         WPWA32WbgVuY9P4uMMUR1OlqujT1FQHIbtLKiKIOAia9L4jWLHI62HqN5jNfC9Ggh7yO
         0N8I0Y+bIoVIsRhPQvDH8xR7tpvoE2dsB1uu8kL0e94Vb2ilYwMZX2dTWMp1bWa87DL9
         ePDX0KVY7N67AWjx73dK/2zptWdkLOro0AbTg7cvtKafyrunDfWr+E4yQeQAH6hR1CsA
         1nqINOry5FbZ1i6Tb5BEAz3ktXM/aek+gm0edAv+ADuKi0JKKfrbLlcfRk1M0/xRRozE
         t+tQ==
X-Gm-Message-State: AOJu0Yzwp/fUJ3xeGrj7MYp2xTC+J/0F2payAXZKpEAqaM3MJ9SaGlmw
	wx3qechqCOWJx6p+cYm6qVXeo+twqDcxnIdweqGXBG4xIAGOuYw=
X-Google-Smtp-Source: AGHT+IEUQvD/suxJ9p+sKly3YW2MdxLul+hNJaR70zQ81QcErDN6IIBETmrfBHfw/aUEstr4vL0XJA==
X-Received: by 2002:a05:6214:dae:b0:681:9a39:c572 with SMTP id h14-20020a0562140dae00b006819a39c572mr498762qvh.1.1706049162983;
        Tue, 23 Jan 2024 14:32:42 -0800 (PST)
Received: from [127.0.0.1] ([20.97.191.182])
        by smtp.gmail.com with ESMTPSA id kr10-20020a0562142b8a00b006862b537412sm3368731qvb.123.2024.01.23.14.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 14:32:42 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <35875ef9cb7194563b580e14c71cc8cb065f846c.1706043786.git.pabeni@redhat.com>
References:
 <35875ef9cb7194563b580e14c71cc8cb065f846c.1706043786.git.pabeni@redhat.com>
Subject: Re: mptcp: fix data re-injection from stale subflow: Tests Results
Message-ID: <aa82961d-10a5-95d0-b1b4-b5136d0d3a7d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jan 2024 22:32:42 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 2 failed test(s): packetdrill_mp_join selftest_diag - =
Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/6235859205226496
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6235859205226496/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Critical: 1 Call Trace(s) =E2=9D=8C:
  - Task: https://cirrus-ci.=
com/task/4828484321673216
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4828484321673216/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/035781441dd7


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
