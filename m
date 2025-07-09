Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD031E5B78
	for <mptcp@lists.linux.dev>; Wed,  9 Jul 2025 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752077206; cv=none; b=mJT5E3iQiFq9cooz71tIm79/8WrD/UX3qcziL/ECppH1YGKzpYkK2Jyt7VITnLDiwQzuWBLlw6it5QfhKdXRBZ0fbYjQV5h3EKKCrZjjSPcH01GIcW3w2YSx34V3s2GpGsVgF6NVRRjnxo1mw9SfwsG5PyFsE02LTYJn+cVHsuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752077206; c=relaxed/simple;
	bh=hOiWlacKkrfrr3ndo/Rl8T/mxFrsLo40/jLXRZa0qHw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=QsRYQfxdRAVgJZX2p4jws+4KJ/ktu6exWN+41RIJMz9aSGCTzJKQoKP3xBiXAulI8FKPj0vnJVYsbMmrsdG4HKvyyJggrjQMz82ywEcyVBNeQaCvx4WJcnEXBFSUQ/FWiPfRNACRYmS9k3rohoH7c2DrclGFgy8YwvcCOXOQhV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsfBvqyt; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsfBvqyt"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23c8f179e1bso1102295ad.1
        for <mptcp@lists.linux.dev>; Wed, 09 Jul 2025 09:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752077204; x=1752682004; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDgSNHBfxInBHrPrGXfwGyBxh0g/OFeuBWw4tuxUpDs=;
        b=gsfBvqyttUTwjveeN6C3qB2hdrIZG1NkO1rnnWNyrV9AFqzmaczrnYi5lmyVTN14mQ
         NIFytdSApDl35LbsxcSTGU4ZiZLiFJ+WE0u0AvEW2v6bEFZI2wE5/Ry4fCx8Y7zQBTQm
         MNMN3Qbbu0tK0/wNPKliNBr9FjAZhUZNxK6DKNhgWKCWFi0YpIYeWv88vzoBYmyJgVEL
         jdI8HteCfsOKUNfizHFuij9GZzXdYsytAatcb/gww5N2j+viclH4PPB8SfIsVsBrfFVn
         /HyNLNNECxCkFLmF529WbH+uiswz6Nvtl2BjmMQ09FWvLOYoduiGyAoFvvhZgP3v5jP2
         kSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752077204; x=1752682004;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bDgSNHBfxInBHrPrGXfwGyBxh0g/OFeuBWw4tuxUpDs=;
        b=RRQGCWH/kBFkQI/8okf9aTIeGAh6CP9l88HGto92RG9K7ZVyrOEMUPSYX9vzm5hBcS
         ieXlRC4gLoOF0TxEp+TF1Q/fYenxO6VY1RxPC7bg425IhcNlEgLSTlbGzBkHGIJGhRv9
         r+JyKx3vNtZYpC8ER/VTa9hsWTi+PQcSaYpm+RabO0Vmumv/eR45t2bqT1wzHhhtDz0a
         hfXwZAy7EZv3W1yfCZdt371fEZ4Ulu0Igi+tbhZZ91irmkdp5gZlunDbcMgnOrgA4OXP
         9EjBiLOepcQkHrsLlfnWOYcks90S4R5ptENF1hsrC7fqLfKgzWCVcmS56OPpAf/eXXBY
         Zzvg==
X-Gm-Message-State: AOJu0YxBZQOGtfHjszVxq01SBxtOg6whoaJwc+mMMiZqLHbs6SZ8wN2d
	MskGY4R3TOwYGzu4KFBwvCHQG6MQojHgpvxGWwR5bwifWMHxJYVAbO7zKh3y
X-Gm-Gg: ASbGncuXVgR64TulfiZ8PcYl9QlyBxpl0/brvtQb5gsUA9N52ru1uYwifichmqIaGYN
	NpNYW6c0Klm8xQhi1oxgOW0XXSnbSEmWB86iFZk5x0EkJu3tgu6M4XVCCs0ZKrrmQMgK3yMFOoP
	iymSqUJEyKdhgafXqLwlXNGpMzzxjx7/ufvtvnx5K172FW6lyzui46vor55AhqGZpEY4szNX6Sw
	NbXcVI/2q+JOSffQu77E5yu1JKGvXihHOVEg1g04+4lO42kTkSEZU6wtu3acRy3g1vk1H6dX3+V
	DIF2k3SAeLhc5mrdY32h9NBSctotMvm1fvFcPJG/epqrwFl4n81uPTxzeVlmI0V4p0XxaJLIWQ=
	=
X-Google-Smtp-Source: AGHT+IETDnr/ZwSiFz/XtymLSoUJDk3PQV65+WXpSR7Y0E2NyQwqdg8n0A1NiH+LWdep7eJi7ZYjcA==
X-Received: by 2002:a17:902:ea06:b0:235:f45f:ed55 with SMTP id d9443c01a7336-23ddb1dc49cmr50219055ad.1.1752077203761;
        Wed, 09 Jul 2025 09:06:43 -0700 (PDT)
Received: from [127.0.0.1] ([51.57.63.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455d39csm153417455ad.140.2025.07.09.09.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 09:06:43 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1752045499.git.tanggeliang@kylinos.cn>
References: <cover.1752045499.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v8 0/7] implement mptcp read_sock
Message-ID: <69005cec-14cb-451c-e117-a25a25f09b69@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Jul 2025 16:06:42 +0000
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
Critical: 223 Call Trace(s) - Critical: Global Timeout =E2=9D=8C
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/161721=
61051

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/aa295276bd34
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D980362


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
