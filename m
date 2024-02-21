Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394F183CB2
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708536336; cv=none; b=fNvtjzuflQr319+cT0aOi+HTVmGf6KJqvFiSwvtIDH8XrT7AS8gLIsvdvBnI3v1Udis9WIOFjjQzU8qPHUmWX5f8t4k1XjnU09G/3VwHqOVNJ86kKtC/3Bsb67HEB54rjIidf3K3v5FON4Rnff4nwhcwNfZ6SoTSgr+7xyIVYmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708536336; c=relaxed/simple;
	bh=fzjKukM1uGUUTJ8I6KIj0aRKHmKoPiflK+sU435Vim0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=PulZHSb4yBqLmPJtnyRvPxDDKaMF4/RNqxQUo8J0eBGsmyK3Fo/1q7NFC1tDz1yRd6Y83RI3JZ4e1KL6flH33TwF6Uty6MAsdAls+Ew2upsy4I3WhOmHiN+uOfqM2pN/4mfRj8B9rNLaDkJ+HZ5xN4DQ0K0rfJKpKLZhhfrBWaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1qn0ehU; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1qn0ehU"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-607fc3e69adso59882097b3.0
        for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 09:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708536334; x=1709141134; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Fhxy1Yf8bpLNsU5Z7gH7kv7mtIzIMzCX+k5NewCX20=;
        b=X1qn0ehUC5ALR79CBfuIoENebnP3ct9xH6/DJ0Skt9g1J7VO4zycu+1vItVzEhZ3RL
         R08jP5RNjEwLYBUC2qWgTzsZEve4bPmr5EVZjP5omLJQs7kZUjTDFkENvD6lY9Qh5iDf
         x5fa+l/vVB14VFHGcTH7Z/hr/b0Pje9+A6WOGLqWMqOh+ZlaXyYR+F/FBJU236iIpiH0
         9wBkhhTmmCSolG3PY2vkOfzvf+RreBJD0CdF8xx6i8oApDK8N4ma2x7+Hm3UIDawzivx
         AuDREk7B6ggntafbhTpoYIkFIRg7cfo/U8LBWhoerIukh6rEE2xtHEYL9p0sVJny54y2
         zfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708536334; x=1709141134;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Fhxy1Yf8bpLNsU5Z7gH7kv7mtIzIMzCX+k5NewCX20=;
        b=UCH6AZ6G9XsFqR9XlOqGtEvsBepBu9V1NfZoHTeTo7gOFBM3VhwxiYtyo/KT64R5Qo
         Amp7zPnrbMTYhc/FfWCuWwOIHyWohTY96T7IlcSxfb/rkSnY4fVPw2JC8rUlBcvowgBl
         gejp3EO1B05ZdOIQK9cT38I9Vy9KU8W7y0R5Pp7yYKNa4jwmfiNRAdYlvji2ezBV3LA9
         cLeh/Gp2MRttEnUo0IwHEJWOYsm5FFJNVZg8s35k6pb3xFefcym2Qa7SJD7dWR3S9+mu
         pfDzRLus9MC7SyUN8+LulKQxzTeMHjNlCR93pKBPNKatE2q/vYgISASI5+Kiy1M/4EHs
         XniA==
X-Gm-Message-State: AOJu0YzKtdZsQ976dRPjWGvtIS91hga6VmB+EGNM6BOpTJYhaBgrMEbV
	Vjpy4cmwGotJodczfpIrOpEtWbpTj0IE0Scc6L2NtmJpWDo5oTw=
X-Google-Smtp-Source: AGHT+IGlb97VrkfMX4AdxDPhJt6xskZkFjIWX+v2v5Ruh+ELdTLIXhS1vihpe3Ln3y2HF6ppgjnO9Q==
X-Received: by 2002:a81:5748:0:b0:607:813b:ad62 with SMTP id l69-20020a815748000000b00607813bad62mr19379009ywb.22.1708536334127;
        Wed, 21 Feb 2024 09:25:34 -0800 (PST)
Received: from [127.0.0.1] ([20.75.95.98])
        by smtp.gmail.com with ESMTPSA id i11-20020ac871cb000000b0042dfb466c85sm3946803qtp.64.2024.02.21.09.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 09:25:33 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <47b5459f6b9b07c5a669d5a5233b35cf6ec601ac.1708532911.git.dcaratti@redhat.com>
References:
 <47b5459f6b9b07c5a669d5a5233b35cf6ec601ac.1708532911.git.dcaratti@redhat.com>
Subject: Re: mptcp: fix double-free on socket dismantle: Tests Results
Message-ID: <5d620fad-0084-34b7-1089-5ab8cfa5abe7@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Feb 2024 17:25:32 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Davide,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7992617007

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/dc4d4d869ec0


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
