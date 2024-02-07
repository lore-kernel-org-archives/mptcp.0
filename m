Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F7C7F7FC
	for <mptcp@lists.linux.dev>; Wed,  7 Feb 2024 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707334011; cv=none; b=ZGK2LNFwfaCplqjpFUrY+6We1R2Y8wJmXZpgvLGRGULjomtNCkEdHQ6XkB9ArupftUt32IN4CLHPOPPhIG5PhOF9w57SDjLYIsPnhJm/a3JKLKcvCmj240B/2jr1BPKTa+Y0crVSAN7FWG6/wW6xqOhgOZY86wDW86h0e98ynq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707334011; c=relaxed/simple;
	bh=SNgmsk7f9ElAY72f43VybqqVdCoyec/2pLPrXWiPOxw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=UNVqBj1l/KtYLjtedC91ppdKVi8GY8Y6OdiOg4QnFGtFiR1irq29kZH07tn1BQBkcfme0rN761DvfUDNApAl1NEVMoOZOrZ26dwNeDVKN1cPHOB0gdaBxLTKJ4PBdgXEqVvXGApQ4a/gA8wMWCht0FYvsOWLf1PtX4lFeH5gqyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ga9bjAeI; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ga9bjAeI"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-60495209415so8962437b3.3
        for <mptcp@lists.linux.dev>; Wed, 07 Feb 2024 11:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707334008; x=1707938808; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtGJsh+ktjHR+ljvZOy8F31GWcVxcs2FR5vhWE7Mm6E=;
        b=Ga9bjAeISK+fPPwBNjY8Bpfdcj/80U2DhBQhuASVhwzaD4yQAqr4ZBWVib/33Pfjgn
         SLB4lIAlwLrLUV9lhTlIt/M/fV4VZEvr5lRgSCW0FTe5yK3aKVzNTmWS/c3EJgd6Wa6e
         Wb2lRoxN08GcYtv05yeDC1m9iyledlXYWH76M1aoFrKaZt0pOjOdtRJCPjhMxflqlz88
         44UEzp9sScrjb5fUfVqEgQWuZdWxKtBHH31UK86ukOrwaPbFSBqgQUj+WmO6ntw8TdVh
         w3JFV79gDfx8em5Fs5O6D4pWD+F6EGCYJv0g5tzvCXgJD4o7Oiz8L152Kclwf6uvAdCW
         /wCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707334008; x=1707938808;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PtGJsh+ktjHR+ljvZOy8F31GWcVxcs2FR5vhWE7Mm6E=;
        b=diTn29RH/m1ZJME53rCrkXTZhr9WrQ251IaKn1PS4Oj268EZfyBL5Ox5Ytw/NQ7yIX
         LitUa9FUzZSibFo2iMAWmPXxT6vu/Wdudo5jpoD8gHFW7Ld/W3MX+FJnWdIBKJ0Tqr3O
         J5WSWs4LnGdu3/ufoO1zmfeYyTwcsJhkg4bunAJYfoDgOSwBEbJkycteB6kO/LodkuvE
         G5/aP5+ytgQrAmULUJnhoiXER0JcJrWMDVgDw6ccZhlNtWL3G5l8mhNg63ygsWFcSXOx
         U+OA12Yn7uy3UWsZUVp2RB+5d6g6x4fwqOGUPbk1Z+xfQi0staea6kRwgXqGCPAjkTTK
         faSQ==
X-Gm-Message-State: AOJu0YzvrUo+5Q/NVD4EpSzfwu2/3VuPRRKFP05NbCXneoBcdse/qJb5
	pKxMFpNMQ2KZwSWywR9Vm6yTaFz3lrjRtfnMSm6XSS7YNPSg5RxaXnjLIH8=
X-Google-Smtp-Source: AGHT+IFxhFDmOBXFZ155w8kZBVOLyr6+lRT7j3k8mAYCFAICam36+Jx7nKlRkpnGauQJToU7NSMWxQ==
X-Received: by 2002:a81:b388:0:b0:604:7bb0:cfb6 with SMTP id r130-20020a81b388000000b006047bb0cfb6mr5893977ywh.2.1707334008388;
        Wed, 07 Feb 2024 11:26:48 -0800 (PST)
Received: from [127.0.0.1] ([74.249.21.242])
        by smtp.gmail.com with ESMTPSA id i12-20020ac8488c000000b0042c1c54d237sm782135qtq.77.2024.02.07.11.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 11:26:48 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240207-selftests-mptcp-fix-5-15-v1-3-005b0cdb135a@kernel.org>
References:
 <20240207-selftests-mptcp-fix-5-15-v1-3-005b0cdb135a@kernel.org>
Subject: Re: selftests: mptcp: diag: fix bash warnings on older kernels:
 Tests Results
Message-ID: <8e4b1398-e93c-7506-842b-0e52f7320070@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Feb 2024 19:26:47 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Unstable: 1 failed test(s): packetdrill_regressions =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5232589070401536
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5232589070401536/su=
mmary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6358488977244160
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6358488977244160/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/bb075ba934d0


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
