Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE82314A6F
	for <mptcp@lists.linux.dev>; Thu, 20 Nov 2025 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763632107; cv=none; b=snSLpqT5qZG989NsvJEGXUMPxDwj2nTYPFDh9k+eAUpA+oRbeeaoUHhHqKwYMQdYvaFRXvm5wl86Gpa1loL1Il4IwZ1OhLVc2rCYszJdE7IduTgRcPdjwbk1Z2WhuRSuo/BbbZlrc/eM25l1H5oe2oXi9euEDuzq/dD9M+eFU7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763632107; c=relaxed/simple;
	bh=fy82/HLO0D6LYzkSigV+l0D+6XIzxCKa4ehq96+h3GE=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Fwg9h8i7k6gvDLtb9ErkS+uvi4tqjU7Q1/ok4FVFQKB62Nd8Nd08fzmXnxbTztCDOPM2trKzOaUbbaiuI6lA9KgUuoP8UwgmTCCRA5kFjjn97rUT3IG0ZChWqAdBnmuQDelepawTUAjg9ZAuG1Cnmc/Fk+GUGlpQYxbwqK1BjhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3LXwBAY; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3LXwBAY"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b2f2c5ec36so73150385a.1
        for <mptcp@lists.linux.dev>; Thu, 20 Nov 2025 01:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763632105; x=1764236905; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/9mvXSZDjMkpLC29PZi6Okp3sP0fho6RuN8bSMfFJ8=;
        b=d3LXwBAYWop2fBzZjJFvBqsCEYAqKm57z29OwIJVB0SlPUKWa6JH0WwkowhMJ9KRGu
         adJkplQPiKgx3ekTX7lS4S9aZbSv0GkqhT8y5nuuTZ+FX2gfOEhq9bkMErrxO6uTv1bM
         PJwHLzZdLFRt0De9eIm589vfX9WbS3D8kxYqAjlZIDMkEifBpqRep7PgwRbgWvoWewQ6
         8DGnjuw3ePcklGzy2xcHXavj6sTudwG5zK5iKbWG+nsFE2uEIc5qGR+PrkuWcdV1VxfD
         uK01RHK9iXAHeJ0CxUIauEhqoZnWPNEk2ymypHRXCRCJItNChp7iZtAToh5dasMEivF1
         8Vqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763632105; x=1764236905;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L/9mvXSZDjMkpLC29PZi6Okp3sP0fho6RuN8bSMfFJ8=;
        b=E2FUwLic2VeC5Pqlc/P/Wz8DRpjAYvsFe5THrq2Msqi8o24IYqsqGAkM5X2MyVPx7V
         VyqOPzhxKzzupXLUVFzx+sB5IitTwFvZ06beyyBFuPq0pqx3e7udVnnLe7r/dPJxbAT1
         o767HzuFvHlD2LbHvU6MRnE41+HXQQ5vMqvt8h77BknDGRQ5Wb1G/2gGgMLSZ6YWLThK
         o4toMSg70Kd+cibRiYo4zXESciuaUSsvGSsIfjuL1i5CcE1d9zfnOn/qP6wIjFw9AAzH
         ZQYO0bA503rOEQEyv9n69LuWIzXOIB9WmAzsMkBtC3GOf9ZnYGkImGrfiH6c6lxDcXPs
         IZwA==
X-Gm-Message-State: AOJu0YzfGReF6rGfinMDCP1ZeuLJJtOl9JlCxJ7PablaFRfDpKWj1i3X
	14xvgK4WWOej4gmHhnzDjhMF2Vzn72y/iEVb9cjmzPBZoAskIb9GO4M=
X-Gm-Gg: ASbGncv9QlciWaB03E+F9uIprBYeWfk48eI45SyvR1ZhoQSNHaKPxr9Jqje5HUwBCE2
	PqsGTqvKNquDGNcZtuZ7JTTO+iDiBQwubCMquWmjn0myN2hpVjKraSLU8Wzh4OGtcY+DulscaT1
	K1NS0zaTwSTVAVs1NeFs2VzwNY2/Pzuj1ONanGr+3sd/+R1+9dbKzlzzJbC9SZTUWtw1+oPRsBc
	4hvPT4Nmyxk9x+80BQdEnS0do+ocUnu2P6zDqMKfniMHnJOSA9W1SLIiEHnaOuz2LSIY4RyojMo
	3xDKdbCrrfiydIkQOE8BIiSld2zhorLhq5Iqpj5dgJwh5KA6aaAImIlqBSCY0kM16vmE1oN8qbL
	9Ht6KK0TDxvWTd3uTDmoCJMjFatbyftbVjw7/DUTG6Aa3fA+QUqAfHectOwxmHPXuI6gW4Cd7xh
	2bif7Cf+of6xLhFEFA9P89XbQ=
X-Google-Smtp-Source: AGHT+IFCsEme5MllRp+QFKXR/RqTDix5zUVZEofj8/7dhRBm26+Pv2FOknYAkHziLwgOOqrhvd/swQ==
X-Received: by 2002:a05:620a:7108:b0:892:526b:fa6f with SMTP id af79cd13be357-8b3274a014fmr320140185a.71.1763632104842;
        Thu, 20 Nov 2025 01:48:24 -0800 (PST)
Received: from [127.0.0.1] ([172.214.47.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295e4b96sm120721585a.45.2025.11.20.01.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 01:48:24 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1763625391.git.pabeni@redhat.com>
References: <cover.1763625391.git.pabeni@redhat.com>
Subject: Re: [PATCH v7 mptcp-next 0/6] mptcp: autotune related improvement
Message-ID: <275a04f8-7ab8-fe27-85c0-ae08bd511ea6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Nov 2025 09:48:23 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/195312=
47842

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/9db02a7e6d33
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1025709


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
