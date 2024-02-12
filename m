Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB4541208
	for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 19:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707766368; cv=none; b=aQYgq3uYW7D9bp1rjMo0ziXUhWB+BrNJWtnqKEPbXOQ8kfdVDzw+9TFU0jM4du7tE2kC7ZGyesSuUCxooawgMrT/Z9yX3S16ip0jNeJN/FZqjWbhUMmXsodWN1C+Il2Na9GnNXABcfe4haNmbKDQSFEnlhiM6utoU5iKCaRo5xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707766368; c=relaxed/simple;
	bh=/sF/Rcxq0AQN/udu3qBOwOQUgt0HVrfC8tSvBN4nmBY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=C2kSHTShVTeqwAklKqL+T1ysrZ2JhFZnnHvF9mxbgkZEqQ+Hh+2yXEd1EHN/gXoe5AW5TzZcdIdU3mSRXyU6TmSYQWIaT6YNdqZYx7dGB/VM/ad3ZRXKlnZUunae8tIYgNF+PeBHfKV1Nd2fjrLA95k8GV1a0npf9udxzHsnlxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnDU1SVS; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnDU1SVS"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-680b1335af6so39530276d6.1
        for <mptcp@lists.linux.dev>; Mon, 12 Feb 2024 11:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707766366; x=1708371166; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDbVNJBoukiHFu3bLy8IaXq7vaTGQ72A19i9WITfMv4=;
        b=SnDU1SVSurFFg/0tqzWyFzggTCWiDIzACJbzTRq8RbW+15MrYm78Ctoe0Z9Vl2mcKk
         Ay8Lnru6RUmoUsacSlkk/yeiH7P2NAiSCZ6xDPRdt8IzMaq4vF8SHrqvCtVRNxfcacZV
         Si8qQTihQk0mgZ06IHKDZvRN8NyiH4Xl4w3+X72ykOalxw2ePSSuePUmiBw44kO+Qgg7
         0oNKPE6SS0+hN7kpX0oIez7MRa8q7jXcHR55MviUOjHXKyFBoR992plM+9j4tGQLT+/S
         pB4jd8ycQoNiaO4CNGurVBqfdj0KLmwKpslPQFrpG6lOdl1JTrwtZ6PQz60fGXORfBg3
         L5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707766366; x=1708371166;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qDbVNJBoukiHFu3bLy8IaXq7vaTGQ72A19i9WITfMv4=;
        b=hBY+auh1YO+AEn5+++ocSckWVSSQ9dyuCphoWhEV3LYY8wKA5j97aFY6NYUSAO9HbC
         TPVRO8bR+L7aoSr5PBCM50miX7as9ARLz3HI4X/EuSErOa4zo3+bgh0Xi+WVx7msoHFh
         1F8J0vRGPFaOtY+USX2ExqmxMirCQizZtBu9b50zrtrh4w90o0iEMW92PGEWQ18mNthq
         W+Nwddki6eNik2QXGaqZ4dgq1ZaYbbcJ25pvdZteb3PvltjrdFI9fRZ8ooDEyd6glPEu
         Nfh5W+4l+v6LSZUR11UsloKtOg96pAB2xJm8vrMJhP/GGchkIaail4YbZJSM0SNh27eQ
         NcCw==
X-Gm-Message-State: AOJu0YyZeOAAHkq+cKsXUAORrLaOIOCTh8hILQ1V15Z48XtS/xs+7xXA
	Y+FJrtoM5sVTmp8Zf9EwgMQ8JVA6GRb2cdOeh+qKga+nmm6BxR8=
X-Google-Smtp-Source: AGHT+IGGc+KEMA2sSMT6ZywZcRpbWvhUVO+JJoxs3tn5OLX+hGZLfLCAqcAuYS10/fyw8ER30odTzA==
X-Received: by 2002:a05:6214:588a:b0:68c:db13:cc27 with SMTP id md10-20020a056214588a00b0068cdb13cc27mr880825qvb.23.1707766365922;
        Mon, 12 Feb 2024 11:32:45 -0800 (PST)
Received: from [127.0.0.1] ([20.55.214.241])
        by smtp.gmail.com with ESMTPSA id el6-20020ad459c6000000b0068d0ace76adsm469098qvb.43.2024.02.12.11.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 11:32:45 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240212-kconfig-debug-enable-net-v1-1-fb026de8174c@kernel.org>
References:
 <20240212-kconfig-debug-enable-net-v1-1-fb026de8174c@kernel.org>
Subject: Re: configs/debug: add NET debug config: Tests Results
Message-ID: <5c4a3ec2-4c7f-25c1-bb60-0a94b69a1cf6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Feb 2024 19:32:44 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7876550556

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/00e075ae7c82


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
